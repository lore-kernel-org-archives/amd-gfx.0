From: Colin King <colin.king@canonical.com>
Subject: [PATCH] drm/amdgpu: fix a missing break in a switch statement
Date: Fri, 28 Jun 2019 15:33:20 +0100
Message-ID: <20190628143320.5182-1-colin.king@canonical.com>
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
To: Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KCkN1cnJlbnRs
eSBmb3IgdGhlIEFNREdQVV9JUlFfU1RBVEVfRElTQUJMRSB0aGVyZSBpcyBhIG1pc3NpbmcgYnJl
YWsKY2F1c2luZyB0aGUgY29kZSB0byBmYWxsIHRocm91Z2ggdG8gdGhlIEFNREdQVV9JUlFfU1RB
VEVfRU5BQkxFIGNhc2UuCkZpeCB0aGlzIGJ5IGFkZGluZyBpbiB0aGUgbWlzc2luZyBicmVhayBz
dGF0ZW1lbnQuCgpBZGRyZXNzZXMtQ292ZXJpdHk6ICgiTWlzc2luZyBicmVhayBpbiBzd2l0Y2gi
KQpGaXhlczogYTY0NGQ4NWE1Y2Q0ICgiZHJtL2FtZGdwdTogYWRkIGdmeCB2MTAgaW1wbGVtZW50
YXRpb24gKHYxMCkiKQpTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0Bj
YW5vbmljYWwuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5j
IHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92MTBfMC5jCmluZGV4IDI5MzJhZGU3ZGJkMC4uYzE2NTIwMDM2MWIyIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwpAQCAtNDYwOCw2ICs0NjA4LDcgQEAg
Z2Z4X3YxMF8wX3NldF9nZnhfZW9wX2ludGVycnVwdF9zdGF0ZShzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwKIAkJY3BfaW50X2NudGwgPSBSRUdfU0VUX0ZJRUxEKGNwX2ludF9jbnRsLCBDUF9J
TlRfQ05UTF9SSU5HMCwKIAkJCQkJICAgIFRJTUVfU1RBTVBfSU5UX0VOQUJMRSwgMCk7CiAJCVdS
RUczMihjcF9pbnRfY250bF9yZWcsIGNwX2ludF9jbnRsKTsKKwkJYnJlYWs7CiAJY2FzZSBBTURH
UFVfSVJRX1NUQVRFX0VOQUJMRToKIAkJY3BfaW50X2NudGwgPSBSUkVHMzIoY3BfaW50X2NudGxf
cmVnKTsKIAkJY3BfaW50X2NudGwgPSBSRUdfU0VUX0ZJRUxEKGNwX2ludF9jbnRsLCBDUF9JTlRf
Q05UTF9SSU5HMCwKLS0gCjIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vZHJpLWRldmVs
