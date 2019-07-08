From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] drm/amdgpu: fix building without CONFIG_HMM_MIRROR
Date: Mon,  8 Jul 2019 15:51:24 +0200
Message-ID: <20190708135135.610355-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: Philip Yang <Philip.Yang@amd.com>, Arnd Bergmann <arnd@arndb.de>, Felix Kuehling <Felix.Kuehling@amd.com>, =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

J3N0cnVjdCBobW1fbWlycm9yJyBpcyBub3QgZGVmaW5lZCB3aXRob3V0IHRoZSBLY29uZmlnIG9w
dGlvbiBzZXQsCnNvIHdlIGNhbm5vdCBpbmNsdWRlIGl0IHdpdGhpbiBhbm90aGVyIHN0cnVjdDoK
CkluIGZpbGUgaW5jbHVkZWQgZnJvbSBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9hbWRn
cHUvYW1kZ3B1Lmg6NzI6CmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2FtZGdwdS9hbWRn
cHVfbW4uaDo2OToyMDogZXJyb3I6IGZpZWxkIGhhcyBpbmNvbXBsZXRlIHR5cGUgJ3N0cnVjdCBo
bW1fbWlycm9yJwogICAgICAgIHN0cnVjdCBobW1fbWlycm9yICAgICAgIG1pcnJvcjsKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBeCmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4u
L2FtZGdwdS9hbWRncHVfbW4uaDo2OTo5OiBub3RlOiBmb3J3YXJkIGRlY2xhcmF0aW9uIG9mICdz
dHJ1Y3QgaG1tX21pcnJvcicKICAgICAgICBzdHJ1Y3QgaG1tX21pcnJvciAgICAgICBtaXJyb3I7
CgpBZGQgdGhlICNpZmRlZiBhcm91bmQgaXQgdGhhdCBpcyBhbHNvIHVzZWQgZm9yIGFsbCBmdW5j
dGlvbnMgb3BlcmF0aW5nCm9uIGl0LgoKRml4ZXM6IDc1OTBmNmQyMTFlYyAoImRybS9hbWRncHU6
IFByZXBhcmUgZm9yIGhtbV9yYW5nZV9yZWdpc3RlciBBUEkgY2hhbmdlIikKU2lnbmVkLW9mZi1i
eTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfbW4uaCB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbW4uaCBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tbi5oCmluZGV4IDI4MWZkOWZlZjY2
Mi4uYjhlZDY4OTQzNjI1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfbW4uaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbW4uaApA
QCAtNjUsOCArNjUsMTAgQEAgc3RydWN0IGFtZGdwdV9tbiB7CiAJc3RydWN0IHJ3X3NlbWFwaG9y
ZQlsb2NrOwogCXN0cnVjdCByYl9yb290X2NhY2hlZAlvYmplY3RzOwogCisjaWZkZWYgQ09ORklH
X0hNTV9NSVJST1IKIAkvKiBITU0gbWlycm9yICovCiAJc3RydWN0IGhtbV9taXJyb3IJbWlycm9y
OworI2VuZGlmCiB9OwogCiAjaWYgZGVmaW5lZChDT05GSUdfSE1NX01JUlJPUikKLS0gCjIuMjAu
MAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRl
dmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
