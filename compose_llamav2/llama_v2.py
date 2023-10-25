from pudb import set_trace; set_trace(paused=False)
import torch
import yaml
from transformers import AutoTokenizer, AutoModelForCausalLM

print("Loading model...")
tokenizer = AutoTokenizer.from_pretrained("togethercomputer/Llama-2-7B-32K-Instruct")
model = AutoModelForCausalLM.from_pretrained("togethercomputer/Llama-2-7B-32K-Instruct",
    trust_remote_code=True, torch_dtype=torch.float16).to('cuda:0')
question = "[INST]\nWrite a poem about cats\n[/INST]\n\n"
print("Question:", question)
input_ids = tokenizer.encode(question, return_tensors="pt").to('cuda:0')
output = model.generate(input_ids, max_length=128,
    temperature=0.7, repetition_penalty=1.1, top_p=0.7, top_k=50)
output_text = tokenizer.decode(output[0], skip_special_tokens=True)
print("Answer:", output_text)

rules = yaml.safe_load(open('rules.yaml'))
question = "[INST]\n Correct the grammar in the following sentences:\n"
question += "\n".join([r['Rule']['Example']['Wrong'] for r in rules])
question += "[/INST]\n\n"
input_ids = tokenizer.encode(question, return_tensors="pt").to('cuda:0')
output = model.generate(input_ids, max_length=2*len(input_ids), temperature=0.7, repetition_penalty=1.1, top_p=0.7, top_k=50)
output_text = tokenizer.decode(output[0], skip_special_tokens=True)
print("Answer:", output_text)


# examples consist of context and multiple question/answer pairs
# we can use the same context for all questions
# test efficiency with / without key-value caching
#prefix="[INST]\n"
#suffix="\n[/INST]\n\n"
#def get_context(i):
#    return  f"There once was a man with {i} cats and {2*i} dogs.\n"
#
#def get_qas(i):
#    return [
#        ("How many cats does he have?",  f"He has {i} cats."),
#        ("How many dogs does he have?",  f"He has {2*i} dogs."),
#    ]
#
## run the model on a single example
#index = 2
#context = get_context(index)
#qas = get_qas(index)
#
#for q, a in qas:
#    question = prefix + context + q + suffix
#    print("Question:", question)
#    input_ids = tokenizer.encode(question, return_tensors="pt").to('cuda:0')
#    gt_output_ids = tokenizer.encode(a, return_tensors="pt").to('cuda:0')
#    print(input_ids.shape)
#    print(gt_output_ids.shape)
#    output = model.generate(input_ids, max_length=128,
#        temperature=0.4, repetition_penalty=1.1, top_p=0.7, top_k=50)
#    # print(output)
#    output_text = tokenizer.decode(output[0][len(input_ids[0]):], skip_special_tokens=True)
#    #print(output_text)
#    model_answer = output_text.split("[INST]")[0].strip()
#    print("Answer:\n[\n", model_answer , "\n]\nGround truth:[\n", a, "\n]\n")



