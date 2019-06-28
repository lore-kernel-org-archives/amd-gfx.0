From: Colin King <colin.king@canonical.com>
Subject: [PATCH] drm/amd/powerplay: fix incorrect assignments to mclk_mask and
 soc_mask
Date: Fri, 28 Jun 2019 15:45:17 +0100
Message-ID: <20190628144517.7747-1-colin.king@canonical.com>
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
To: Kevin Wang <kevin1.wang@amd.com>, Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KClRoZXJlIGFy
ZSBudWxsIHBvaW50ZXIgY2hlY2tzIG9uIG1sY2tfbWFzayBhbmQgc29jX21hc2sgaG93ZXZlciB0
aGUKc2Nsa19tYXNrIGlzIGJlaW5nIHVzZWQgaW4gYXNzaWdubWVudHMgaW4gd2hhdCBsb29rcyB0
byBiZSBhIGN1dC1uLXBhc3RlCmNvZGluZyBlcnJvci4gRml4IHRoaXMgYnkgdXNpbmcgdGhlIGNv
cnJlY3QgcG9pbnRlcnMgaW4gdGhlIGFzc2lnbm1lbnRzLgoKQWRkcmVzc2VzLUNvdmVyaXR5OiAo
IkRlcmVmZXJlbmNlIGFmdGVyIG51bGwgY2hlY2siKQpGaXhlczogMmQ5ZmI5YjA2NjQzICgiZHJt
L2FtZC9wb3dlcnBsYXk6IGFkZCBmdW5jdGlvbiBnZXRfcHJvZmlsaW5nX2Nsa19tYXNrIGZvciBu
YXZpMTAiKQpTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmlj
YWwuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYyB8
IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9uYXZpMTBfcHB0LmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9uYXZpMTBfcHB0LmMKaW5kZXggMjdlNWM4
MC4uYWMxNTFkYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvbmF2
aTEwX3BwdC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQu
YwpAQCAtMTEzNCwxNCArMTEzNCwxNCBAQCBzdGF0aWMgaW50IG5hdmkxMF9nZXRfcHJvZmlsaW5n
X2Nsa19tYXNrKHN0cnVjdCBzbXVfY29udGV4dCAqc211LAogCQkJcmV0ID0gc211X2dldF9kcG1f
bGV2ZWxfY291bnQoc211LCBTTVVfTUNMSywgJmxldmVsX2NvdW50KTsKIAkJCWlmIChyZXQpCiAJ
CQkJcmV0dXJuIHJldDsKLQkJCSpzY2xrX21hc2sgPSBsZXZlbF9jb3VudCAtIDE7CisJCQkqbWNs
a19tYXNrID0gbGV2ZWxfY291bnQgLSAxOwogCQl9CiAKIAkJaWYoc29jX21hc2spIHsKIAkJCXJl
dCA9IHNtdV9nZXRfZHBtX2xldmVsX2NvdW50KHNtdSwgU01VX1NPQ0NMSywgJmxldmVsX2NvdW50
KTsKIAkJCWlmIChyZXQpCiAJCQkJcmV0dXJuIHJldDsKLQkJCSpzY2xrX21hc2sgPSBsZXZlbF9j
b3VudCAtIDE7CisJCQkqc29jX21hc2sgPSBsZXZlbF9jb3VudCAtIDE7CiAJCX0KIAl9CiAKLS0g
CjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpk
cmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
