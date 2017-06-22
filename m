From: kbuild test robot <fengguang.wu@intel.com>
Subject: [RFC PATCH linux-next] drm/amdgpu/gfx9:
 gfx_v9_0_enable_gfx_static_mg_power_gating() can be static
Date: Fri, 23 Jun 2017 04:28:47 +0800
Message-ID: <20170622202847.GA25945@lkp-sbx04>
References: <201706230410.vagp71dF%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <201706230410.vagp71dF%fengguang.wu@intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Tom St Denis <tom.stdenis@amd.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Xiangliang Yu <Xiangliang.Yu@amd.com>, kbuild-all@01.org, Alex Deucher <alexander.deucher@amd.com>, Ken Wang <Qingqing.Wang@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Monk Liu <Monk.Liu@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

ClNpZ25lZC1vZmYtYnk6IEZlbmdndWFuZyBXdSA8ZmVuZ2d1YW5nLnd1QGludGVsLmNvbT4KLS0t
CiBnZnhfdjlfMC5jIHwgICAgNiArKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKaW5k
ZXggYTFlMWI3YWEuLmYyYWU2ZjMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92OV8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAu
YwpAQCAtMTk5Miw4ICsxOTkyLDggQEAgc3RhdGljIHZvaWQgZ2Z4X3Y5XzBfZW5hYmxlX2dmeF9w
aXBlbGluZV9wb3dlcmdhdGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJZGF0YSA9
IFJSRUczMihTT0MxNV9SRUdfT0ZGU0VUKEdDLCAwLCBtbURCX1JFTkRFUl9DT05UUk9MKSk7CiB9
CiAKLXZvaWQgZ2Z4X3Y5XzBfZW5hYmxlX2dmeF9zdGF0aWNfbWdfcG93ZXJfZ2F0aW5nKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LAotCQkJCQkJYm9vbCBlbmFibGUpCitzdGF0aWMgdm9pZCBn
ZnhfdjlfMF9lbmFibGVfZ2Z4X3N0YXRpY19tZ19wb3dlcl9nYXRpbmcoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsCisJCQkJCQkgICAgICAgYm9vbCBlbmFibGUpCiB7CiAJdWludDMyX3QgZGF0
YSwgZGVmYXVsdF9kYXRhOwogCkBAIC0yMDA2LDcgKzIwMDYsNyBAQCB2b2lkIGdmeF92OV8wX2Vu
YWJsZV9nZnhfc3RhdGljX21nX3Bvd2VyX2dhdGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diwKIAkJV1JFRzMyKFNPQzE1X1JFR19PRkZTRVQoR0MsIDAsIG1tUkxDX1BHX0NOVEwpLCBkYXRh
KTsKIH0KIAotdm9pZCBnZnhfdjlfMF9lbmFibGVfZ2Z4X2R5bmFtaWNfbWdfcG93ZXJfZ2F0aW5n
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAorc3RhdGljIHZvaWQgZ2Z4X3Y5XzBfZW5hYmxl
X2dmeF9keW5hbWljX21nX3Bvd2VyX2dhdGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwK
IAkJCQkJCWJvb2wgZW5hYmxlKQogewogCXVpbnQzMl90IGRhdGEsIGRlZmF1bHRfZGF0YTsKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1h
aWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
