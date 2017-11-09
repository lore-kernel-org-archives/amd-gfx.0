From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH umr] Fix access_vram bug introduced by
 f105ce1f5c54f3e371f1572292f87cfa9b116b33
Date: Thu,  9 Nov 2017 08:09:23 -0500
Message-ID: <20171109130923.25797-1-tom.stdenis@amd.com>
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

VGhlIGxvZ2ljIHdhcyByZXZlcnNlZCB3aGVuIFBSVCBzdXBwb3J0IHdhcyBhZGRlZC4KClNpZ25l
ZC1vZmYtYnk6IFRvbSBTdCBEZW5pcyA8dG9tLnN0ZGVuaXNAYW1kLmNvbT4KLS0tCiBzcmMvbGli
L3JlYWRfdnJhbS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL2xpYi9yZWFkX3ZyYW0uYyBiL3NyYy9saWIvcmVh
ZF92cmFtLmMKaW5kZXggYjc4ZDA2MTk0YWRkLi44MGY4ZTA1NjI1OGYgMTAwNjQ0Ci0tLSBhL3Ny
Yy9saWIvcmVhZF92cmFtLmMKKysrIGIvc3JjL2xpYi9yZWFkX3ZyYW0uYwpAQCAtNjMyLDcgKzYz
Miw3IEBAIHBkZV9pc19wdGU6CiAJCQkodW5zaWduZWQgbG9uZyBsb25nKXN0YXJ0X2FkZHIsICh1
bnNpZ25lZCBsb25nKWNodW5rX3NpemUpOwogCiAJCS8vIGFsbG93IGRlc3RpbmF0aW9uIHRvIGJl
IE5VTEwgdG8gc2ltcGx5IHVzZSBkZWNvZGVyCi0JCWlmICghcHRlX2ZpZWxkcy52YWxpZCkgewor
CQlpZiAocHRlX2ZpZWxkcy52YWxpZCkgewogCQkJaWYgKHBkc3QpIHsKIAkJCQlpZiAocHRlX2Zp
ZWxkcy5zeXN0ZW0pIHsKIAkJCQkJaWYgKHVtcl9hY2Nlc3Nfc3JhbShzdGFydF9hZGRyLCBjaHVu
a19zaXplLCBwZHN0LCB3cml0ZV9lbikgPCAwKSB7Ci0tIAoyLjEyLjAKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
