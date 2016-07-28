From: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amdgpu: fix default UVD context size
Date: Thu, 28 Jul 2016 10:13:14 -0400
Message-ID: <1469715195-7174-1-git-send-email-leo.liu@amd.com>
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

RnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKQ29udGV4
dCBidWZmZXJzIHNob3VsZCBiZSBkZW5pZWQgYnkgZGVmYXVsdCwgbm90IGFsbG93ZWQuCgpTaWdu
ZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+ClJl
dmlld2VkLWJ5OiBMZW8gTGl1IDxsZW8ubGl1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3V2ZC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3V2
ZC5jCmluZGV4IGIzOTIzOGEuLjI4YzFiNjIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV91dmQuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdXZkLmMKQEAgLTQxMCw3ICs0MTAsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV91dmRfY3Nf
bXNnX2RlY29kZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3QgKm1zZywKIAl1
bnNpZ25lZCBmc19pbl9tYiA9IHdpZHRoX2luX21iICogaGVpZ2h0X2luX21iOwogCiAJdW5zaWdu
ZWQgaW1hZ2Vfc2l6ZSwgdG1wLCBtaW5fZHBiX3NpemUsIG51bV9kcGJfYnVmZmVyOwotCXVuc2ln
bmVkIG1pbl9jdHhfc2l6ZSA9IDA7CisJdW5zaWduZWQgbWluX2N0eF9zaXplID0gfjA7CiAKIAlp
bWFnZV9zaXplID0gd2lkdGggKiBoZWlnaHQ7CiAJaW1hZ2Vfc2l6ZSArPSBpbWFnZV9zaXplIC8g
MjsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
