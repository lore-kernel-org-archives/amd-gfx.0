From: "Liang, Prike" <Prike.Liang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amdgpu: add GFX_PIPELINE capacity check for updating
 gfx cgpg
Date: Tue, 15 Oct 2019 09:50:21 +0000
Message-ID: <1571133012-19837-1-git-send-email-Prike.Liang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Liang, Prike" <Prike.Liang-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>

QmVmb3JlIGRpc2FibGUgZ2Z4IHBpcGVsaW5lIHBvd2VyIGdhdGluZyBuZWVkIGNoZWNrIHRoZSBm
bGFnIEFNRF9QR19TVVBQT1JUX0dGWF9QSVBFTElORS4KClNpZ25lZC1vZmYtYnk6IFByaWtlIExp
YW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92OV8wLmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCmluZGV4IGI1Nzdi
NjkuLmRlOGY5ZDYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
OV8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwpAQCAtNDI5
Niw3ICs0Mjk2LDggQEAgc3RhdGljIHZvaWQgZ2Z4X3Y5XzBfdXBkYXRlX2dmeF9jZ19wb3dlcl9n
YXRpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQlnZnhfdjlfMF9lbmFibGVfZ2Z4
X3BpcGVsaW5lX3Bvd2VyZ2F0aW5nKGFkZXYsIHRydWUpOwogCX0gZWxzZSB7CiAJCWdmeF92OV8w
X2VuYWJsZV9nZnhfY2dfcG93ZXJfZ2F0aW5nKGFkZXYsIGZhbHNlKTsKLQkJZ2Z4X3Y5XzBfZW5h
YmxlX2dmeF9waXBlbGluZV9wb3dlcmdhdGluZyhhZGV2LCBmYWxzZSk7CisJCWlmIChhZGV2LT5w
Z19mbGFncyAmIEFNRF9QR19TVVBQT1JUX0dGWF9QSVBFTElORSkKKwkJCWdmeF92OV8wX2VuYWJs
ZV9nZnhfcGlwZWxpbmVfcG93ZXJnYXRpbmcoYWRldiwgZmFsc2UpOwogCX0KIAogCWFtZGdwdV9n
ZnhfcmxjX2V4aXRfc2FmZV9tb2RlKGFkZXYpOwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
