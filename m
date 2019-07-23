From: "Pan, Xinhui" <Xinhui.Pan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Also reserve bad pages after gpu reset
Date: Tue, 23 Jul 2019 03:30:45 +0000
Message-ID: <SN6PR12MB2800D574892ADB78A475241587C70@SN6PR12MB2800.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Grodzovsky,
 Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>

SW4gY2FzZSB3ZSBhZGQgYmFkIHBhZ2VzIGR1cmluZyBncHUgcmVzZXQuIEJhZCBwYWdlcyBtaWdo
dCBub3QgYmVlbgpyZXNlcnZlZCBpbiB0aW1lLgoKU2lnbmVkLW9mZi1ieTogeGluaHVpIHBhbiA8
eGluaHVpLnBhbkBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9yYXMuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKaW5kZXggMjMwYzA2ZTYxOWVkLi43MDliNTJl
NmViYWYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKQEAgLTEyNzEs
NiArMTI3MSw4IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9yYXNfZG9fcmVjb3Zlcnkoc3RydWN0IHdv
cmtfc3RydWN0ICp3b3JrKQogCiAJYW1kZ3B1X2RldmljZV9ncHVfcmVjb3ZlcihyYXMtPmFkZXYs
IDApOwogCWF0b21pY19zZXQoJnJhcy0+aW5fcmVjb3ZlcnksIDApOworCS8qIGluIGNhc2Ugd2Ug
YWRkIGJhZCBwYWdlcyBkdXJpbmcgZ3B1IHJlc2V0LiAqLworCWFtZGdwdV9yYXNfcmVzZXJ2ZV9i
YWRfcGFnZXMocmFzLT5hZGV2KTsKIH0KIAogc3RhdGljIGludCBhbWRncHVfcmFzX3JlbGVhc2Vf
dnJhbShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKLS0gCjIuMTcuMQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
