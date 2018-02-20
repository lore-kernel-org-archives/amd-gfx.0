From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] drm/amdgpu: Remove duplicate setting of ->need_swiotlb
Date: Tue, 20 Feb 2018 11:44:50 +0100
Message-ID: <20180220104450.28652-1-thierry.reding@gmail.com>
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
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogVGhpZXJyeSBSZWRpbmcgPHRyZWRpbmdAbnZpZGlhLmNvbT4KClRoZXJlJ3Mgbm8gbmVl
ZCB0byBzZXQgdGhpcyBiZWZvcmUgdGhlIG51bWJlciBvZiBETUEgYml0cyBoYXMgYmVlbgpwcm9w
ZXJseSBkZXRlcm1pbmVkLgoKU2lnbmVkLW9mZi1ieTogVGhpZXJyeSBSZWRpbmcgPHRyZWRpbmdA
bnZpZGlhLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjhfMC5jIHwg
MSAtCiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nbWNfdjhfMC5jCmluZGV4IDlhMTcwZTM3ZmJlNy4uOWNjODQ5ZjgyOWQwIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjhfMC5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dtY192OF8wLmMKQEAgLTEwODYsNyArMTA4Niw2IEBAIHN0YXRpYyBp
bnQgZ21jX3Y4XzBfc3dfaW5pdCh2b2lkICpoYW5kbGUpCiAJICovCiAJYWRldi0+bmVlZF9kbWEz
MiA9IGZhbHNlOwogCWRtYV9iaXRzID0gYWRldi0+bmVlZF9kbWEzMiA/IDMyIDogNDA7Ci0JYWRl
di0+bmVlZF9zd2lvdGxiID0gZHJtX2dldF9tYXhfaW9tZW0oKSA+ICgodTY0KTEgPDwgZG1hX2Jp
dHMpOwogCXIgPSBwY2lfc2V0X2RtYV9tYXNrKGFkZXYtPnBkZXYsIERNQV9CSVRfTUFTSyhkbWFf
Yml0cykpOwogCWlmIChyKSB7CiAJCWFkZXYtPm5lZWRfZG1hMzIgPSB0cnVlOwotLSAKMi4xNS4x
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2
ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
