From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] drm/amd/pp: fix logical or'ing of garbage in result by
 initializing result to zero
Date: Mon, 26 Mar 2018 15:13:54 +0100
Message-ID: <20180326141354.31247-1-colin.king@canonical.com>
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
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Rex Zhu <Rex.Zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Tom St Denis <tom.stdenis@amd.com>, Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KCkN1cnJlbnRs
eSByZXN1bHQgaXMgbm90IGluaXRpYWxpemVkLCBzbyBpdCBjb250YWlucyBhIGdhcmJhZ2UgdmFs
dWUgYW5kCnRoaXMgaXMgb3InZCB3aXRoIGRhdGEgZnJvbSB2ZWdhMTBfcHJvZ3JhbV9kaWR0X2Nv
bmZpZ19yZWdpc3RlcnMoKSB3aGljaApjYW4gZW5kIHVwIHdpdGggYSBub24temVybyB2YWx1ZSB3
aGVuIHRoZSByZXN1bHQgc2hvdWxkIGJlIHplcm8uICBGaXgKdGhpcyBieSBlbnN1cmluZyByZXN1
bHQgaXMgaW5pdGlhbGl6ZWQgdG8gemVyby4KCkRldGVjdGVkIGJ5IENvdmVyaXR5U2NhbiwgQ0lE
IzE0NjYwODggKCJVbmluaXRpYWxpemVkIHNjYWxhciB2YXJpYWJsZSIpCgpGaXhlczogOWI3Yjgx
NTRjZGI4ICgiZHJtL2FtZC9wb3dlcnBsYXk6IGFkZGVkIGRpZHQgc3VwcG9ydCBmb3IgdmVnYTEw
IikKU2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNv
bT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMTBfcG93ZXJ0
dW5lLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdh
MTBfcG93ZXJ0dW5lLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdh
MTBfcG93ZXJ0dW5lLmMKaW5kZXggYjFmNzRjN2YwOTQzLi40OTgyMmVhM2RkZDUgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9wb3dlcnR1bmUu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMTBfcG93ZXJ0
dW5lLmMKQEAgLTEwOTEsNyArMTA5MSw3IEBAIHN0YXRpYyBpbnQgdmVnYTEwX2Rpc2FibGVfc2Vf
ZWRjX2NvbmZpZyhzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKQogCiBzdGF0aWMgaW50IHZlZ2ExMF9l
bmFibGVfcHNtX2djX2VkY19jb25maWcoc3RydWN0IHBwX2h3bWdyICpod21ncikKIHsKLQlpbnQg
cmVzdWx0OworCWludCByZXN1bHQgPSAwOwogCXVpbnQzMl90IG51bV9zZSA9IDA7CiAJdWludDMy
X3QgY291bnQsIGRhdGE7CiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBod21nci0+YWRl
djsKLS0gCjIuMTUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRl
dmVsCg==
