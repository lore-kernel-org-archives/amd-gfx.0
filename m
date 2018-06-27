From: Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: remove duplicated codes
Date: Wed, 27 Jun 2018 14:10:13 +0800
Message-ID: <1530079813-4012-1-git-send-email-Flora.Cui@amd.com>
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
Cc: Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJYzBkYmQ2OTNiYWMwOTNlNTRlYjk1YjVlNTQ3Yzg5YjY0YTU3NDNiOApTaWdu
ZWQtb2ZmLWJ5OiBGbG9yYSBDdWkgPEZsb3JhLkN1aUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pZHMuYyB8IDUgLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA1
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9pZHMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pZHMuYwppbmRl
eCBhMWM3OGY5Li4zYTA3MmE3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfaWRzLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lk
cy5jCkBAIC01NzgsMTEgKzU3OCw2IEBAIHZvaWQgYW1kZ3B1X3ZtaWRfbWdyX2luaXQoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJCQlsaXN0X2FkZF90YWlsKCZpZF9tZ3ItPmlkc1tqXS5s
aXN0LCAmaWRfbWdyLT5pZHNfbHJ1KTsKIAkJfQogCX0KLQotCWFkZXYtPnZtX21hbmFnZXIuZmVu
Y2VfY29udGV4dCA9Ci0JCWRtYV9mZW5jZV9jb250ZXh0X2FsbG9jKEFNREdQVV9NQVhfUklOR1Mp
OwotCWZvciAoaSA9IDA7IGkgPCBBTURHUFVfTUFYX1JJTkdTOyArK2kpCi0JCWFkZXYtPnZtX21h
bmFnZXIuc2Vxbm9baV0gPSAwOwogfQogCiAvKioKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
