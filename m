From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 010/167] drm/amdgpu: Update gc_9_0 golden
 settings.
Date: Tue,  3 Sep 2019 12:22:42 -0400
Message-ID: <20190903162519.7136-10-sashal@kernel.org>
References: <20190903162519.7136-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190903162519.7136-1-sashal@kernel.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Feifei Xu <Feifei.Xu@amd.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogRmVpZmVpIFh1IDxGZWlmZWkuWHVAYW1kLmNvbT4KClsgVXBzdHJlYW0gY29tbWl0IGM1
NTA0NWFkZjcyMTBkMjQ2YTAxNmM5NjE5MTZmMDc4ZWQzMWE5NTEgXQoKQWRkIG1tREJfREVCVUcz
IHNldHRpbmdzLgoKU2lnbmVkLW9mZi1ieTogRmVpZmVpIFh1IDxGZWlmZWkuWHVAYW1kLmNvbT4K
UmV2aWV3ZWQtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPHNhc2hhbEBrZXJuZWwub3Jn
PgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgfCAxICsKIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlf
MC5jCmluZGV4IGYwNDBlYzEwZWVjZjYuLjc4MjQxMTY0OTgxNjkgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3Y5XzAuYwpAQCAtODMsNiArODMsNyBAQCBNT0RVTEVfRklSTVdBUkUoImFt
ZGdwdS9yYXZlbl9ybGMuYmluIik7CiBzdGF0aWMgY29uc3Qgc3RydWN0IHNvYzE1X3JlZ19nb2xk
ZW4gZ29sZGVuX3NldHRpbmdzX2djXzlfMFtdID0KIHsKIAlTT0MxNV9SRUdfR09MREVOX1ZBTFVF
KEdDLCAwLCBtbURCX0RFQlVHMiwgMHhmMDBmZmZmZiwgMHgwMDAwMDQwMCksCisJU09DMTVfUkVH
X0dPTERFTl9WQUxVRShHQywgMCwgbW1EQl9ERUJVRzMsIDB4ODAwMDAwMDAsIDB4ODAwMDAwMDAp
LAogCVNPQzE1X1JFR19HT0xERU5fVkFMVUUoR0MsIDAsIG1tR0JfR1BVX0lELCAweDAwMDAwMDBm
LCAweDAwMDAwMDAwKSwKIAlTT0MxNV9SRUdfR09MREVOX1ZBTFVFKEdDLCAwLCBtbVBBX1NDX0JJ
Tk5FUl9FVkVOVF9DTlRMXzMsIDB4MDAwMDAwMDMsIDB4ODI0MDAwMjQpLAogCVNPQzE1X1JFR19H
T0xERU5fVkFMVUUoR0MsIDAsIG1tUEFfU0NfRU5IQU5DRSwgMHgzZmZmZmZmZiwgMHgwMDAwMDAw
MSksCi0tIAoyLjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1k
ZXZlbA==
