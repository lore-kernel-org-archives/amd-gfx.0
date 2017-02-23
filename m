From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 5/8] drm/amd/display: Fix error where wrong payload size is
 given.
Date: Thu, 23 Feb 2017 11:33:40 -0500
Message-ID: <20170223163343.7476-6-harry.wentland@amd.com>
References: <20170223163343.7476-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170223163343.7476-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Zeyu Fan <Zeyu.Fan-5C7GfCeVMHo@public.gmane.org>

RnJvbTogWmV5dSBGYW4gPFpleXUuRmFuQGFtZC5jb20+CgpDaGFuZ2UtSWQ6IEkyZTA1MThiZTBl
MmVlNTEzZDdiMDAxYzAyNTllZTQxYzBkMTA0ZmQxClNpZ25lZC1vZmYtYnk6IFpleXUgRmFuIDxa
ZXl1LkZhbkBhbWQuY29tPgpSZXZpZXdlZC1ieTogVG9ueSBDaGVuZyA8VG9ueS5DaGVuZ0BhbWQu
Y29tPgpBY2tlZC1ieTogSGFycnkgV2VudGxhbmQgPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+Ci0t
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kZGMuYyB8IDIg
Ky0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZGRjLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rX2RkYy5jCmluZGV4
IGNkNjY5NDFiMmM1OS4uNGU5NDY1YjYzMGQxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rX2RkYy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZGRjLmMKQEAgLTE5OCw3ICsxOTgsNyBAQCBzdHJ1
Y3QgYXV4X3BheWxvYWRzICpkYWxfZGRjX2F1eF9wYXlsb2Fkc19jcmVhdGUoc3RydWN0IGRjX2Nv
bnRleHQgKmN0eCwgdWludDMyXwogCQlyZXR1cm4gTlVMTDsKIAogCWlmIChkYWxfdmVjdG9yX2Nv
bnN0cnVjdCgKLQkJJnBheWxvYWRzLT5wYXlsb2FkcywgY3R4LCBjb3VudCwgc2l6ZW9mKHN0cnVj
dCBhdXhfcGF5bG9hZHMpKSkKKwkJJnBheWxvYWRzLT5wYXlsb2FkcywgY3R4LCBjb3VudCwgc2l6
ZW9mKHN0cnVjdCBhdXhfcGF5bG9hZCkpKQogCQlyZXR1cm4gcGF5bG9hZHM7CiAKIAlkbV9mcmVl
KHBheWxvYWRzKTsKLS0gCjIuOS4zCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
