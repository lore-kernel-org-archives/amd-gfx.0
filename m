From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Release the correct object on error in
 amdgpu_benchmark_move()
Date: Fri, 15 Nov 2019 10:27:40 +0300
Message-ID: <20191115072740.4gznld4t3ngbmcsd@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
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
To: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Pan Bian <bianpan2016-9Onoh4P/yGk@public.gmane.org>, Christian K??nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>

VGhlcmUgaXMgYSB0eXBvIHNvIHRoaXMgdW5yZXNlcnZlcyAic29iaiIgaW5zdGVhZCBvZiAiZG9i
aiIuCgpGaXhlczogYmI4MTJmMWVhODdkICgiZHJtL2FtZGdwdTogYWxsb2NhdGUgZ2FydCBtZW1v
cnkgd2hlbiBpdCdzIHJlcXVpcmVkICh2MykiKQpTaWduZWQtb2ZmLWJ5OiBEYW4gQ2FycGVudGVy
IDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+Ci0tLQpGcm9tIHN0YXRpYyBhbmFseXNpcy4gIE5v
dCB0ZXN0ZWQuCgogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2JlbmNobWFyay5j
IHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2JlbmNobWFyay5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2JlbmNobWFyay5jCmluZGV4IGQx
NDk1ZTFjOTI4OS4uNDNkOWQwM2JjN2U3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfYmVuY2htYXJrLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2JlbmNobWFyay5jCkBAIC0xMTQsNyArMTE0LDcgQEAgc3RhdGljIHZvaWQgYW1k
Z3B1X2JlbmNobWFya19tb3ZlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1bnNpZ25lZCBz
aXplLAogCQlnb3RvIG91dF9jbGVhbnVwOwogCXIgPSBhbWRncHVfYm9fcGluKGRvYmosIGRkb21h
aW4pOwogCWlmIChyKSB7Ci0JCWFtZGdwdV9ib191bnJlc2VydmUoc29iaik7CisJCWFtZGdwdV9i
b191bnJlc2VydmUoZG9iaik7CiAJCWdvdG8gb3V0X2NsZWFudXA7CiAJfQogCXIgPSBhbWRncHVf
dHRtX2FsbG9jX2dhcnQoJmRvYmotPnRibyk7Ci0tIAoyLjExLjAKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
