From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 05/10] drm/amdgpu: put GART away from VRAM
Date: Mon, 27 Aug 2018 18:53:32 +0200
Message-ID: <20180827165337.1651-5-christian.koenig@amd.com>
References: <20180827165337.1651-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180827165337.1651-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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

QWx3YXlzIHRyeSB0byBwdXQgdGhlIEdBUlQgYXdheSBmcm9tIHdoZXJlIFZSQU0gaXMuCgpTaWdu
ZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0t
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jIHwgMiArLQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2dtYy5jCmluZGV4IDI2NWVjNjgwNzEzMC4uNDMzMWEwZTI1Y2RjIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jCkBAIC0xMzYsNyArMTM2LDcg
QEAgdm9pZCBhbWRncHVfZ21jX2dhcnRfbG9jYXRpb24oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsIHN0cnVjdCBhbWRncHVfZ21jICptYykKIAkgICAgKHNpemVfYWYgPCBtYy0+Z2FydF9zaXpl
KSkKIAkJbWMtPmdhcnRfc3RhcnQgPSAwOwogCWVsc2UKLQkJbWMtPmdhcnRfc3RhcnQgPSBBTElH
TihtYy0+dnJhbV9lbmQgKyAxLCAweDEwMDAwMDAwMFVMTCk7CisJCW1jLT5nYXJ0X3N0YXJ0ID0g
bWMtPm1jX21hc2sgLSBtYy0+Z2FydF9zaXplICsgMTsKIAltYy0+Z2FydF9lbmQgPSBtYy0+Z2Fy
dF9zdGFydCArIG1jLT5nYXJ0X3NpemUgLSAxOwogCWRldl9pbmZvKGFkZXYtPmRldiwgIkdBUlQ6
ICVsbHVNIDB4JTAxNmxsWCAtIDB4JTAxNmxsWFxuIiwKIAkJCW1jLT5nYXJ0X3NpemUgPj4gMjAs
IG1jLT5nYXJ0X3N0YXJ0LCBtYy0+Z2FydF9lbmQpOwotLSAKMi4xNy4xCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
