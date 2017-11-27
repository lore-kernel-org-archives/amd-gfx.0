From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 05/14] drm/amdgpu: Fix definition of KFD_CIK_SDMA_QUEUE_OFFSET
Date: Mon, 27 Nov 2017 18:29:47 -0500
Message-ID: <1511825396-24579-6-git-send-email-Felix.Kuehling@amd.com>
References: <1511825396-24579-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1511825396-24579-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>

VGhpcyBjb3VudHMgdGhlIHF1ZXVlIG9mZnNldCBpbiByZWdpc3RlciBpbmRleCwgbm90IHJlZ2lz
dGVyIGFkZHJlc3MuCgpTaWduZWQtb2ZmLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxp
bmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9jaWtkLmggfCAyICst
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9jaWtkLmggYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9jaWtkLmgKaW5kZXggNmE5ZTM4YS4uY2VlNmU4YSAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lrZC5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2Npa2QuaApAQCAtNTYyLDcgKzU2Miw3IEBACiAjZGVmaW5lCVBSSVZBVEVfQkFTRSh4
KQkoKHgpIDw8IDApIC8qIHNjcmF0Y2ggKi8KICNkZWZpbmUJU0hBUkVEX0JBU0UoeCkJKCh4KSA8
PCAxNikgLyogTERTICovCiAKLSNkZWZpbmUgS0ZEX0NJS19TRE1BX1FVRVVFX09GRlNFVAkweDIw
MAorI2RlZmluZSBLRkRfQ0lLX1NETUFfUVVFVUVfT0ZGU0VUIChtbVNETUEwX1JMQzFfUkJfQ05U
TCAtIG1tU0RNQTBfUkxDMF9SQl9DTlRMKQogCiAvKiB2YWxpZCBmb3IgYm90aCBERUZBVUxUX01U
WVBFIGFuZCBBUEUxX01UWVBFICovCiBlbnVtIHsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
