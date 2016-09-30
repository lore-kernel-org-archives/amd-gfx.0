From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/4] drm/amdgpu/virtual_dce: adjust config ifdef
Date: Fri, 30 Sep 2016 00:13:47 -0400
Message-ID: <1475208829-27834-2-git-send-email-alexander.deucher@amd.com>
References: <1475208829-27834-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1475208829-27834-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

SW5jbHVkZSB0aGUgQ0lLIGFzaWNzIGluIHRoZSBpZmRlZi4KClNpZ25lZC1vZmYtYnk6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9kY2VfdmlydHVhbC5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2RjZV92aXJ0dWFsLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9kY2Vf
dmlydHVhbC5jCmluZGV4IDdjODg5ZDMuLjViYTk3YTcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2RjZV92aXJ0dWFsLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZGNlX3ZpcnR1YWwuYwpAQCAtOTksMTUgKzk5LDE1IEBAIHN0YXRpYyB2b2lkIGRjZV92
aXJ0dWFsX3N0b3BfbWNfYWNjZXNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQkJICAg
ICAgc3RydWN0IGFtZGdwdV9tb2RlX21jX3NhdmUgKnNhdmUpCiB7CiAJc3dpdGNoIChhZGV2LT5h
c2ljX3R5cGUpIHsKKyNpZmRlZiBDT05GSUdfRFJNX0FNREdQVV9DSUsKIAljYXNlIENISVBfQk9O
QUlSRToKIAljYXNlIENISVBfSEFXQUlJOgogCWNhc2UgQ0hJUF9LQVZFUkk6CiAJY2FzZSBDSElQ
X0tBQklOSToKIAljYXNlIENISVBfTVVMTElOUzoKLSNpZmRlZiBDT05GSUdfRFJNX0FNREdQVV9D
SUsKIAkJZGNlX3Y4XzBfZGlzYWJsZV9kY2UoYWRldik7Ci0jZW5kaWYKIAkJYnJlYWs7CisjZW5k
aWYKIAljYXNlIENISVBfRklKSToKIAljYXNlIENISVBfVE9OR0E6CiAJCWRjZV92MTBfMF9kaXNh
YmxlX2RjZShhZGV2KTsKLS0gCjIuNS41CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
