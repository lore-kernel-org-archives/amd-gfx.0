From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/6] drm/amdgpu: should call drm_helper with dc support
Date: Tue, 27 Feb 2018 16:47:12 +0800
Message-ID: <1519721235-28552-4-git-send-email-Monk.Liu@amd.com>
References: <1519721235-28552-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1519721235-28552-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

b3RoZXJ3aXNlIERSTSBrZWVwIHJlcG9ydGluZyBjb21wbGFpbiBvbiBBVE9NSUMgZmxhZ3MKZHVy
aW5nIGttZCByZWxvYWRpbmcKCkNoYW5nZS1JZDogSTgzNWI5NmU2ZDYxYzc5OTViYmQ1ZGQ1NDc4
ZDA1NjY3MWRkZTkxOTIKU2lnbmVkLW9mZi1ieTogTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+
Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZiLmMgfCAyICstCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmIuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9mYi5jCmluZGV4IDEyMDYzMDEuLjIyMTg0MTYgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mYi5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mYi5jCkBAIC0zNDUsNyArMzQ1LDcgQEAgaW50IGFtZGdw
dV9mYmRldl9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCWRybV9mYl9oZWxwZXJf
c2luZ2xlX2FkZF9hbGxfY29ubmVjdG9ycygmcmZiZGV2LT5oZWxwZXIpOwogCiAJLyogZGlzYWJs
ZSBhbGwgdGhlIHBvc3NpYmxlIG91dHB1dHMvY3J0Y3MgYmVmb3JlIGVudGVyaW5nIEtNUyBtb2Rl
ICovCi0JaWYgKCFhbWRncHVfZGV2aWNlX2hhc19kY19zdXBwb3J0KGFkZXYpKQorCWlmIChhbWRn
cHVfZGV2aWNlX2hhc19kY19zdXBwb3J0KGFkZXYpKQogCQlkcm1faGVscGVyX2Rpc2FibGVfdW51
c2VkX2Z1bmN0aW9ucyhhZGV2LT5kZGV2KTsKIAogCWRybV9mYl9oZWxwZXJfaW5pdGlhbF9jb25m
aWcoJnJmYmRldi0+aGVscGVyLCBicHBfc2VsKTsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
