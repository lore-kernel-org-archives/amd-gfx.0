From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu/si: add dpm quirk for Oland
Date: Wed, 15 Mar 2017 09:01:30 -0400
Message-ID: <1489582890-17915-2-git-send-email-alexander.deucher@amd.com>
References: <1489582890-17915-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1489582890-17915-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

T0xBTkQgMHgxMDAyOjB4NjYwNCAweDEwMjg6MHgwNjZGIDB4MDAgc2VlbXMgdG8gaGF2ZSBwcm9i
bGVtcwp3aXRoIGhpZ2hlciBzY2xrcy4KClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0uYyB8IDYgKysrKysrCiAxIGZpbGUgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvc2lfZHBtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0uYwppbmRl
eCA0MmU5NWVlLi43NGRlZGY3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9zaV9kcG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0uYwpAQCAt
MzQ2NCw2ICszNDY0LDEyIEBAIHN0YXRpYyB2b2lkIHNpX2FwcGx5X3N0YXRlX2FkanVzdF9ydWxl
cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJICAgIChhZGV2LT5wZGV2LT5kZXZpY2Ug
PT0gMHg2NjY3KSkgewogCQkJbWF4X3NjbGsgPSA3NTAwMDsKIAkJfQorCX0gZWxzZSBpZiAoYWRl
di0+YXNpY190eXBlID09IENISVBfT0xBTkQpIHsKKwkJaWYgKChhZGV2LT5wZGV2LT5kZXZpY2Ug
PT0gMHg2NjA0KSAmJgorCQkgICAgKGFkZXYtPnBkZXYtPnN1YnN5c3RlbV92ZW5kb3IgPT0gMHgx
MDI4KSAmJgorCQkgICAgKGFkZXYtPnBkZXYtPnN1YnN5c3RlbV9kZXZpY2UgPT0gMHgwNjZGKSkg
eworCQkJbWF4X3NjbGsgPSA3NTAwMDsKKwkJfQogCX0KIAogCWlmIChycHMtPnZjZV9hY3RpdmUp
IHsKLS0gCjIuNS41CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
