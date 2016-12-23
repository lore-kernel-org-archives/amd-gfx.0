From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 03/14] drm/amd/display: Add dcc param to surface
Date: Fri, 23 Dec 2016 10:57:55 -0500
Message-ID: <20161223155806.12043-4-harry.wentland@amd.com>
References: <20161223155806.12043-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161223155806.12043-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Leon Elazar <leon.elazar-5C7GfCeVMHo@public.gmane.org>

RnJvbTogTGVvbiBFbGF6YXIgPGxlb24uZWxhemFyQGFtZC5jb20+CgpDaGFuZ2UtSWQ6IEliOGEw
ZGI1ZjI4MzM2MDJiYjJjNmEzNDgwZTgxYTYzOTU2YjhjNGVhClJldmlld2VkLWJ5OiBUb255IENo
ZW5nIDxUb255LkNoZW5nQGFtZC5jb20+CkFja2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8SGFycnku
V2VudGxhbmRAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMu
aCB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvZGMuaAppbmRleCBmMTcwN2I0OGU0MGYuLjA1ZmNiMDY2M2ZmMCAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmgKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmgKQEAgLTI3NSw2ICsyNzUsNyBAQCBzdHJ1Y3QgZGNfc3Vy
ZmFjZSB7CiBzdHJ1Y3QgZGNfcGxhbmVfaW5mbyB7CiAJdW5pb24gcGxhbmVfc2l6ZSBwbGFuZV9z
aXplOwogCXVuaW9uIGRjX3RpbGluZ19pbmZvIHRpbGluZ19pbmZvOworCXN0cnVjdCBkY19wbGFu
ZV9kY2NfcGFyYW0gZGNjOwogCWVudW0gc3VyZmFjZV9waXhlbF9mb3JtYXQgZm9ybWF0OwogCWVu
dW0gZGNfcm90YXRpb25fYW5nbGUgcm90YXRpb247CiAJYm9vbCBob3Jpem9udGFsX21pcnJvcjsK
LS0gCjIuOS4zCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
