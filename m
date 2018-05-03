From: <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH xf86-video-amdgpu 10/13] Push staged color properties when
 DPMS state toggles On
Date: Thu, 3 May 2018 14:31:52 -0400
Message-ID: <1525372315-28462-11-git-send-email-sunpeng.li@amd.com>
References: <1525372315-28462-1-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1525372315-28462-1-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Leo (Sunpeng) Li" <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, michel-otUistvHUpPR7s880joybQ@public.gmane.org, harry.wentland-5C7GfCeVMHo@public.gmane.org

RnJvbTogIkxlbyAoU3VucGVuZykgTGkiIDxzdW5wZW5nLmxpQGFtZC5jb20+CgpUaGlzIHdpbGwg
cGVyc2lzdCBjb2xvciBtYW5hZ2VtZW50IHByb3BlcnRpZXMgb24gYSBDUlRDIGFjcm9zcyBEUE1T
CnN0YXRlIGNoYW5nZXMuCgpTaWduZWQtb2ZmLWJ5OiBMZW8gKFN1bnBlbmcpIExpIDxzdW5wZW5n
LmxpQGFtZC5jb20+Ci0tLQogc3JjL2RybW1vZGVfZGlzcGxheS5jIHwgNiArKysrKysKIDEgZmls
ZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9zcmMvZHJtbW9kZV9kaXNw
bGF5LmMgYi9zcmMvZHJtbW9kZV9kaXNwbGF5LmMKaW5kZXggNDVjNTgyYy4uMDZhZTkwMiAxMDA2
NDQKLS0tIGEvc3JjL2RybW1vZGVfZGlzcGxheS5jCisrKyBiL3NyYy9kcm1tb2RlX2Rpc3BsYXku
YwpAQCAtMTI5NCw2ICsxMjk0LDcgQEAgZHJtbW9kZV9kb19jcnRjX2RwbXMoeGY4NkNydGNQdHIg
Y3J0YywgaW50IG1vZGUpCiAJQU1ER1BVRW50UHRyIHBBTURHUFVFbnQgPSBBTURHUFVFbnRQcml2
KHNjcm4pOwogCUNBUkQ2NCB1c3Q7CiAJaW50IHJldDsKKwlpbnQgaTsKIAogCWlmIChkcm1tb2Rl
X2NydGMtPmRwbXNfbW9kZSA9PSBEUE1TTW9kZU9uICYmIG1vZGUgIT0gRFBNU01vZGVPbikgewog
CQl1aW50MzJfdCBzZXE7CkBAIC0xMzQxLDYgKzEzNDIsMTEgQEAgZHJtbW9kZV9kb19jcnRjX2Rw
bXMoeGY4NkNydGNQdHIgY3J0YywgaW50IG1vZGUpCiAJCQlkcm1tb2RlX2NydGMtPmludGVycG9s
YXRlZF92YmxhbmtzICs9IGRlbHRhX3NlcTsKIAkJfQogCisJCWZvciAoaSA9IDA7IGkgPCBDTV9O
VU1fUFJPUFM7IGkrKykgeworCQkJaWYgKGkgPT0gQ01fR0FNTUFfTFVUX1NJWkUgfHwgaSA9PSBD
TV9ERUdBTU1BX0xVVF9TSVpFKQorCQkJCWNvbnRpbnVlOworCQkJZHJtbW9kZV9jcnRjX3B1c2hf
Y21fcHJvcChjcnRjLCBpKTsKKwkJfQogCX0KIAlkcm1tb2RlX2NydGMtPmRwbXNfbW9kZSA9IG1v
ZGU7CiB9Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
