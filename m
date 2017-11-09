From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 36/73] drm/amd/display: Remove unused OPP functions from
 interface
Date: Thu, 9 Nov 2017 15:05:32 -0500
Message-ID: <20171109200609.14566-37-harry.wentland@amd.com>
References: <20171109200609.14566-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171109200609.14566-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Eric Bernstein <eric.bernstein-5C7GfCeVMHo@public.gmane.org>

RnJvbTogRXJpYyBCZXJuc3RlaW4gPGVyaWMuYmVybnN0ZWluQGFtZC5jb20+CgpDaGFuZ2UtSWQ6
IEliNzllNjliMDE3ODIxOWUwMjgxOWE3YjkyY2MxY2IxYmVhOWI1YTY4ClNpZ25lZC1vZmYtYnk6
IEVyaWMgQmVybnN0ZWluIDxlcmljLmJlcm5zdGVpbkBhbWQuY29tPgpSZXZpZXdlZC1ieTogVG9u
eSBDaGVuZyA8VG9ueS5DaGVuZ0BhbWQuY29tPgpBY2tlZC1ieTogSGFycnkgV2VudGxhbmQgPGhh
cnJ5LndlbnRsYW5kQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2luYy9ody9vcHAuaCB8IDkgLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgOSBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvaW5jL2h3L29w
cC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2luYy9ody9vcHAuaAppbmRleCA4
MTQxYjY3N2ZkYTkuLmNkNmIwZDRjZDQ1NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2luYy9ody9vcHAuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvaW5jL2h3L29wcC5oCkBAIC0yODEsMTUgKzI4MSw2IEBAIHN0cnVjdCBvcHBfZnVuY3Mg
ewogCQkJYm9vbCBlbmFibGUsCiAJCQlib29sIHJpZ2h0RXllUG9sYXJpdHkpOwogCi0Jdm9pZCAo
Km9wcF9zZXRfdGVzdF9wYXR0ZXJuKSgKLQkJCXN0cnVjdCBvdXRwdXRfcGl4ZWxfcHJvY2Vzc29y
ICpvcHAsCi0JCQlib29sIGVuYWJsZSk7Ci0KLQl2b2lkICgqb3BwX2RwZ19ibGFua19lbmFibGUp
KAotCQkJc3RydWN0IG91dHB1dF9waXhlbF9wcm9jZXNzb3IgKm9wcCwKLQkJCWJvb2wgZW5hYmxl
LAotCQkJaW50IHdpZHRoLAotCQkJaW50IGhlaWdodCk7CiB9OwogCiAjZW5kaWYKLS0gCjIuMTQu
MQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
