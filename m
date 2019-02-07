From: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 1/5] staging/vboxvideo: Use same BO mmap offset as other
 drivers
Date: Thu,  7 Feb 2019 09:59:27 +0100
Message-ID: <20190207085931.29569-2-tzimmermann@suse.de>
References: <20190207085931.29569-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190207085931.29569-1-tzimmermann-l3A5Bk7waGM@public.gmane.org>
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
To: alexander.deucher-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, David1.Zhou-5C7GfCeVMHo@public.gmane.org, airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, z.liuxinliang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, thellstrom-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org, linux-graphics-maintainer-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, ray.huang-5C7GfCeVMHo@public.gmane.org, Jerry.Zhang-5C7GfCeVMHo@public.gmane.org
Cc: spice-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org

VGhlIHZib3h2aWRlbyBkcml2ZXIgbW1hcHMgQk9zIGF0IDB4MTAwMDAwMDAgb3IgaGlnaGVyLiBD
aGFuZ2luZyB0aGUKb2Zmc2V0IHRvIDB4MTAwMDAwMDAwIGFsaWducyB0aGUgZHJpdmVyIHdpdGgg
YWxsIG90aGVyIERSTSBkcml2ZXJzLgoKU2lnbmVkLW9mZi1ieTogVGhvbWFzIFppbW1lcm1hbm4g
PHR6aW1tZXJtYW5uQHN1c2UuZGU+Ci0tLQogZHJpdmVycy9zdGFnaW5nL3Zib3h2aWRlby92Ym94
X2Rydi5oIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3Zib3h2aWRlby92Ym94X2Rydi5oIGIv
ZHJpdmVycy9zdGFnaW5nL3Zib3h2aWRlby92Ym94X2Rydi5oCmluZGV4IGFhNDBlNWNjMjg2MS4u
ZWJhNWE4YmM5Y2VhIDEwMDY0NAotLS0gYS9kcml2ZXJzL3N0YWdpbmcvdmJveHZpZGVvL3Zib3hf
ZHJ2LmgKKysrIGIvZHJpdmVycy9zdGFnaW5nL3Zib3h2aWRlby92Ym94X2Rydi5oCkBAIC0yMDks
NyArMjA5LDcgQEAgaW50IHZib3hfZHVtYl9tbWFwX29mZnNldChzdHJ1Y3QgZHJtX2ZpbGUgKmZp
bGUsCiAJCQkgIHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsCiAJCQkgIHUzMiBoYW5kbGUsIHU2NCAq
b2Zmc2V0KTsKIAotI2RlZmluZSBEUk1fRklMRV9QQUdFX09GRlNFVCAoMHgxMDAwMDAwMFVMTCA+
PiBQQUdFX1NISUZUKQorI2RlZmluZSBEUk1fRklMRV9QQUdFX09GRlNFVCAoMHgxMDAwMDAwMDBV
TEwgPj4gUEFHRV9TSElGVCkKIAogaW50IHZib3hfbW1faW5pdChzdHJ1Y3QgdmJveF9wcml2YXRl
ICp2Ym94KTsKIHZvaWQgdmJveF9tbV9maW5pKHN0cnVjdCB2Ym94X3ByaXZhdGUgKnZib3gpOwot
LSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
