From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/4] drm/amdgpu: align GTT start to 4GB
Date: Fri, 17 Nov 2017 11:12:39 +0100
Message-ID: <20171117101240.1514-3-christian.koenig@amd.com>
References: <20171117101240.1514-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171117101240.1514-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: adf.lists-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, leo.liu-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

Rm9yIFZDRSB0byB3b3JrIHByb3Blcmx5IHRoZSBzdGFydCBvZiB0aGUgR1RUIHNwYWNlIG11c3Qg
YmUgYWxpZ25lZCB0byBhCjRHQiBib3VuZGFyeS4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZGV2aWNlLmMKaW5kZXggZjliZWU3NmU3MDcxLi5iYmFhYjMxMjE4YTggMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKQEAgLTYyMiw3ICs2MjIsNyBAQCB2b2lk
IGFtZGdwdV9nYXJ0X2xvY2F0aW9uKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3Qg
YW1kZ3B1X21jICptYykKIAkJCWRldl93YXJuKGFkZXYtPmRldiwgImxpbWl0aW5nIEdUVFxuIik7
CiAJCQltYy0+Z2FydF9zaXplID0gc2l6ZV9hZjsKIAkJfQotCQltYy0+Z2FydF9zdGFydCA9IG1j
LT52cmFtX2VuZCArIDE7CisJCW1jLT5nYXJ0X3N0YXJ0ID0gQUxJR04obWMtPnZyYW1fZW5kICsg
MSwgMHgxMDAwMDAwMDBVTEwpOwogCX0KIAltYy0+Z2FydF9lbmQgPSBtYy0+Z2FydF9zdGFydCAr
IG1jLT5nYXJ0X3NpemUgLSAxOwogCWRldl9pbmZvKGFkZXYtPmRldiwgIkdUVDogJWxsdU0gMHgl
MDE2bGxYIC0gMHglMDE2bGxYXG4iLAotLSAKMi4xMS4wCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
