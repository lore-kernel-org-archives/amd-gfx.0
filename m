From: Colin King <colin.king@canonical.com>
Subject: [PATCH] drm/amdkfd: check for null dev to avoid a null pointer
 dereference
Date: Fri,  8 Sep 2017 15:13:33 +0100
Message-ID: <20170908141333.1563-1-colin.king@canonical.com>
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
To: Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KClRoZSBjYWxs
IHRvIGtmZF9kZXZpY2VfYnlfaWQgY2FuIHBvdGVudGlhbGx5IHJldHVybiBudWxsLCBzbyBjaGVj
ayB0aGF0CmRldiBpcyBudWxsIGFuZCByZXR1cm4gd2l0aCAtRUlOVkFMIHRvIGF2b2lkIGEgbnVs
bCBwb2ludGVyIGRlcmVmZXJlbmNlLgoKRGV0ZWN0ZWQgYnkgQ292ZXJpdHlTY2FuIENJRCMxNDU0
NjI5ICgiRGVyZWZlcmVuY2UgbnVsbCByZXR1cm4gdmFsdWUiKQoKRml4ZXM6IDVkNzFkYmMzYTU4
OCAoImRybS9hbWRrZmQ6IEltcGxlbWVudCBpbWFnZSB0aWxpbmcgbW9kZSBzdXBwb3J0IHYyIikK
U2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jIHwgMiArKwogMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfY2hhcmRldi5jCmluZGV4IGU0YThjMmU1MmNiMi4uNjYwYjNmYmFkZTQxIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMKQEAgLTg5Miw2ICs4OTIsOCBAQCBzdGF0
aWMgaW50IGtmZF9pb2N0bF9nZXRfdGlsZV9jb25maWcoc3RydWN0IGZpbGUgKmZpbGVwLAogCWlu
dCBlcnIgPSAwOwogCiAJZGV2ID0ga2ZkX2RldmljZV9ieV9pZChhcmdzLT5ncHVfaWQpOworCWlm
ICghZGV2KQorCQlyZXR1cm4gLUVJTlZBTDsKIAogCWRldi0+a2ZkMmtnZC0+Z2V0X3RpbGVfY29u
ZmlnKGRldi0+a2dkLCAmY29uZmlnKTsKIAotLSAKMi4xNC4xCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1k
ZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
