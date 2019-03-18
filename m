From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/amdkfd: Fix unchecked return value
Date: Mon, 18 Mar 2019 13:05:25 -0500
Message-ID: <20190318180525.GA13768@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Felix Kuehling <Felix.Kuehling@amd.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

QXNzaWduIHJldHVybiB2YWx1ZSBvZiBmdW5jdGlvbiBhbWRncHVfYm9fc3luY193YWl0KCkgdG8g
dmFyaWFibGUgcmV0CmZvciBpdHMgZnVydGhlciBjaGVjay4KCkFkZHJlc3Nlcy1Db3Zlcml0eS1J
RDogMTQ0MzkxNCAoIkxvZ2ljYWxseSBkZWFkIGNvZGUiKQpGaXhlczogYzYwY2Q1OTBjYjdkICgi
ZHJtL2FtZGdwdTogUmVwbGFjZSB0dG1fYm9fd2FpdCB3aXRoIGFtZGdwdV9ib19zeW5jX3dhaXQi
KQpTaWduZWQtb2ZmLWJ5OiBHdXN0YXZvIEEuIFIuIFNpbHZhIDxndXN0YXZvQGVtYmVkZGVkb3Iu
Y29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0u
YyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9n
cHV2bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5j
CmluZGV4IDE5MjFkZWMzZGY3YS4uZmI2MjFhYmNiMDA2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCkBAIC05MDYsNyArOTA2LDggQEAg
c3RhdGljIGludCBpbml0X2tmZF92bShzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSwgdm9pZCAqKnByb2Nl
c3NfaW5mbywKIAkJcHJfZXJyKCJ2YWxpZGF0ZV9wdF9wZF9ib3MoKSBmYWlsZWRcbiIpOwogCQln
b3RvIHZhbGlkYXRlX3BkX2ZhaWw7CiAJfQotCWFtZGdwdV9ib19zeW5jX3dhaXQodm0tPnJvb3Qu
YmFzZS5ibywgQU1ER1BVX0ZFTkNFX09XTkVSX0tGRCwgZmFsc2UpOworCXJldCA9IGFtZGdwdV9i
b19zeW5jX3dhaXQodm0tPnJvb3QuYmFzZS5ibywgQU1ER1BVX0ZFTkNFX09XTkVSX0tGRCwKKwkJ
CQkgIGZhbHNlKTsKIAlpZiAocmV0KQogCQlnb3RvIHdhaXRfcGRfZmFpbDsKIAlhbWRncHVfYm9f
ZmVuY2Uodm0tPnJvb3QuYmFzZS5ibywKLS0gCjIuMjEuMAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
