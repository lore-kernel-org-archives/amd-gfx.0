From: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/powerplay: fix memory leak of hardcoded pptable
Date: Tue, 31 Oct 2017 17:40:06 -0400
Message-ID: <1509486006-27816-1-git-send-email-JinHuiEric.Huang@amd.com>
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
Cc: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogRXJpYyBIdWFuZyA8SmluSHVpRXJpYy5IdWFuZ0BhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZF9wb3dlcnBsYXkuYyB8IDMgKysrCiAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wb3dlcnBsYXkvYW1kX3Bvd2VycGxheS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvYW1kX3Bvd2VycGxheS5jCmluZGV4IGQ0ZmY3NDIuLjlkM2JkYWQgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZF9wb3dlcnBsYXkuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRfcG93ZXJwbGF5LmMKQEAgLTc4LDYgKzc4
LDkgQEAgc3RhdGljIGludCBhbWRfcG93ZXJwbGF5X2Rlc3Ryb3kodm9pZCAqaGFuZGxlKQogewog
CXN0cnVjdCBwcF9pbnN0YW5jZSAqaW5zdGFuY2UgPSAoc3RydWN0IHBwX2luc3RhbmNlICopaGFu
ZGxlOwogCisJa2ZyZWUoaW5zdGFuY2UtPmh3bWdyLT5oYXJkY29kZV9wcF90YWJsZSk7CisJaW5z
dGFuY2UtPmh3bWdyLT5oYXJkY29kZV9wcF90YWJsZSA9IE5VTEw7CisKIAlrZnJlZShpbnN0YW5j
ZS0+aHdtZ3IpOwogCWluc3RhbmNlLT5od21nciA9IE5VTEw7CiAKLS0gCjIuNy40CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
