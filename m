From: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 2/2] drm/amdgpu: print debug message when fails to reserve
 BO
Date: Tue, 18 Apr 2017 11:43:45 -0400
Message-ID: <1492530225-5219-2-git-send-email-AlexBin.Xie@amd.com>
References: <1492530225-5219-1-git-send-email-AlexBin.Xie@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1492530225-5219-1-git-send-email-AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJZTVhNmJhMDQ1YmRlMDdjY2QzNWIyNzY5MDcwOWFkMTY3MDEzOTQ0NwpTaWdu
ZWQtb2ZmLWJ5OiBBbGV4IFhpZSA8QWxleEJpbi5YaWVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYwppbmRleCA3OWI1ZmRhLi43ZTQzZjYzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jCkBAIC0zNTYsNiArMzU2LDkgQEAgc3RhdGljIHZvaWQgYW1kZ3B1
X3ZyYW1fc2NyYXRjaF9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCQlhbWRncHVf
Ym9fdW5waW4oYWRldi0+dnJhbV9zY3JhdGNoLnJvYmopOwogCQlhbWRncHVfYm9fdW5yZXNlcnZl
KGFkZXYtPnZyYW1fc2NyYXRjaC5yb2JqKTsKIAkJYW1kZ3B1X2JvX3VucmVmKCZhZGV2LT52cmFt
X3NjcmF0Y2gucm9iaik7CisJfSBlbHNlIHsKKwkJRFJNX0RFQlVHKCJhbWRncHVfdnJhbV9zY3Jh
dGNoX2ZpbmkgZmFpbGVkLiAiCisJCQkJIkJPIGlzIHN0aWxsIHJlZmVyZW5jZWQuXG4iKTsKIAl9
CiB9CiAKLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
