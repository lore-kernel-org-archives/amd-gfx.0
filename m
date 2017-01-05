From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 10/10] drm/radeon: drop the mclk quirk for hainan
Date: Thu,  5 Jan 2017 13:11:04 -0500
Message-ID: <1483639864-16171-10-git-send-email-alexander.deucher@amd.com>
References: <1483639864-16171-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1483639864-16171-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

Zml4ZWQgYnkgdGhlIG5ldyA1OCBtYyBmaXJtd2FyZS4KClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1
Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3NpX2RwbS5jIHwgMSAtCiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2lfZHBtLmMgYi9kcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3NpX2RwbS5jCmluZGV4IDY2ODA2MGYuLjI5NDQ5MTYgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9yYWRlb24vc2lfZHBtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9z
aV9kcG0uYwpAQCAtMzAxNiw3ICszMDE2LDYgQEAgc3RhdGljIHZvaWQgc2lfYXBwbHlfc3RhdGVf
YWRqdXN0X3J1bGVzKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LAogCQkgICAgKHJkZXYtPnBk
ZXYtPmRldmljZSA9PSAweDY2NjUpIHx8CiAJCSAgICAocmRldi0+cGRldi0+ZGV2aWNlID09IDB4
NjY2NykpIHsKIAkJCW1heF9zY2xrID0gNzUwMDA7Ci0JCQltYXhfbWNsayA9IDgwMDAwOwogCQl9
CiAJfQogCS8qIEFwcGx5IGRwbSBxdWlya3MgKi8KLS0gCjIuNS41CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
