From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH umr] Fix name of SQ_CMD register for halt/resume waves.
Date: Mon, 31 Jul 2017 18:50:33 -0400
Message-ID: <20170731225033.12737-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

V2l0aCB0aGF0IGNoYW5nZWQgLXdhIHdvcmtzIHdpdGggaGFsdGluZyB3YXZlcy4KClNpZ25lZC1v
ZmYtYnk6IFRvbSBTdCBEZW5pcyA8dG9tLnN0ZGVuaXNAYW1kLmNvbT4KLS0tCiBzcmMvbGliL3Nx
X2NtZF9oYWx0X3dhdmVzLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9zcmMvbGliL3NxX2NtZF9oYWx0X3dhdmVzLmMg
Yi9zcmMvbGliL3NxX2NtZF9oYWx0X3dhdmVzLmMKaW5kZXggODNhYTUyZDJjZmIyLi45M2U5OGQ1
YTYwMzUgMTAwNjQ0Ci0tLSBhL3NyYy9saWIvc3FfY21kX2hhbHRfd2F2ZXMuYworKysgYi9zcmMv
bGliL3NxX2NtZF9oYWx0X3dhdmVzLmMKQEAgLTMwLDcgKzMwLDcgQEAgaW50IHVtcl9zcV9jbWRf
aGFsdF93YXZlcyhzdHJ1Y3QgdW1yX2FzaWMgKmFzaWMsIGVudW0gdW1yX3NxX2NtZF9oYWx0X3Jl
c3VtZSBtb2QKIAl1aW50MzJfdCB2YWx1ZTsKIAl1aW50NjRfdCBhZGRyOwogCi0JcmVnID0gdW1y
X2ZpbmRfcmVnX2RhdGEoYXNpYywgIlNRX0NNRCIpOworCXJlZyA9IHVtcl9maW5kX3JlZ19kYXRh
KGFzaWMsICJtbVNRX0NNRCIpOwogCWlmICghcmVnKSB7CiAJCWZwcmludGYoc3RkZXJyLCAiW0JV
R106IENhbm5vdCBmaW5kIFNRX0NNRCByZWdpc3RlciBpbiB1bXJfc3FfY21kX2hhbHRfd2F2ZXMo
KVxuIik7CiAJCXJldHVybiAtMTsKLS0gCjIuMTIuMAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
