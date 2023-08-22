import torch
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

