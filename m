From: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Temparary disable the sdma use pollmem feature
 for sriov.
Date: Fri, 19 Jan 2018 18:14:24 +0800
Message-ID: <1516356864-2622-1-git-send-email-Emily.Deng@amd.com>
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
Cc: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>

SXQgc3RpbGwgaGFzIHNvbWUgc2VyaW91cyBpc3N1ZXMoZ3Vlc3QgZHJpdmVyIHJlbG9hZCBmYWls
LCBldGMpLAp3aGVuIHVzZSBwb2xsbWVtIGZlYXR1cmUgZm9yIHNkbWEzLgoKU2lnbmVkLW9mZi1i
eTogRW1pbHkgRGVuZyA8RW1pbHkuRGVuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3NkbWFfdjNfMC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc2RtYV92M18wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3YzXzAuYwpp
bmRleCAzZTIyYWU0Li4wZjhmNjE0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9zZG1hX3YzXzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Yz
XzAuYwpAQCAtMTIwOSw3ICsxMjA5LDcgQEAgc3RhdGljIGludCBzZG1hX3YzXzBfc3dfaW5pdCh2
b2lkICpoYW5kbGUpCiAJZm9yIChpID0gMDsgaSA8IGFkZXYtPnNkbWEubnVtX2luc3RhbmNlczsg
aSsrKSB7CiAJCXJpbmcgPSAmYWRldi0+c2RtYS5pbnN0YW5jZVtpXS5yaW5nOwogCQlyaW5nLT5y
aW5nX29iaiA9IE5VTEw7Ci0JCWlmICghYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKSB7CisJCWlmICgx
KSB7CiAJCQlyaW5nLT51c2VfZG9vcmJlbGwgPSB0cnVlOwogCQkJcmluZy0+ZG9vcmJlbGxfaW5k
ZXggPSAoaSA9PSAwKSA/CiAJCQkJQU1ER1BVX0RPT1JCRUxMX3NETUFfRU5HSU5FMCA6IEFNREdQ
VV9ET09SQkVMTF9zRE1BX0VOR0lORTE7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
