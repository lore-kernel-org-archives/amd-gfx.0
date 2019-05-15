From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] drm/amd/powerplay: fix locking in smu_feature_set_supported()
Date: Wed, 15 May 2019 12:51:30 +0300
Message-ID: <20190515095130.GF3409@mwanda>
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
To: Alex Deucher <alexander.deucher@amd.com>, Kevin Wang <kevin1.wang@amd.com>
Cc: Chengming Gui <Jack.Gui@amd.com>, David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org, Likun Gao <Likun.Gao@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

VGhlcmUgaXMgYSB0eXBvIHNvIHRoZSBjb2RlIHVubG9ja3MgdHdpY2UgaW5zdGVhZCBvZiB0YWtp
bmcgdGhlIGxvY2sgYW5kCnRoZW4gcmVsZWFzaW5nIGl0LgoKRml4ZXM6IGYxNGEzMjNkYjViMCAo
ImRybS9hbWQvcG93ZXJwbGF5OiBpbXBsZW1lbnQgdXBkYXRlIGVuYWJsZWQgZmVhdHVyZSBzdGF0
ZSB0byBzbWMgZm9yIHNtdTExIikKU2lnbmVkLW9mZi1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNh
cnBlbnRlckBvcmFjbGUuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2Ft
ZGdwdV9zbXUuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdw
dV9zbXUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYwppbmRl
eCA1MmQ5MTlhOGI3MGEuLjg1YWMyOWFmNTM2MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L2FtZGdwdV9zbXUuYwpAQCAtMzEwLDcgKzMxMCw3IEBAIGludCBzbXVfZmVhdHVyZV9z
ZXRfc3VwcG9ydGVkKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCBpbnQgZmVhdHVyZV9pZCwKIAog
CVdBUk5fT04oZmVhdHVyZV9pZCA+IGZlYXR1cmUtPmZlYXR1cmVfbnVtKTsKIAotCW11dGV4X3Vu
bG9jaygmZmVhdHVyZS0+bXV0ZXgpOworCW11dGV4X2xvY2soJmZlYXR1cmUtPm11dGV4KTsKIAlp
ZiAoZW5hYmxlKQogCQl0ZXN0X2FuZF9zZXRfYml0KGZlYXR1cmVfaWQsIGZlYXR1cmUtPnN1cHBv
cnRlZCk7CiAJZWxzZQotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9kcmktZGV2ZWw=
