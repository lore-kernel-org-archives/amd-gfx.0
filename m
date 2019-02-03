From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH 5/6] drm/xen: Use drm_dev_unregister()
Date: Sun,  3 Feb 2019 16:41:59 +0100
Message-ID: <20190203154200.61479-6-noralf@tronnes.org>
References: <20190203154200.61479-1-noralf@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190203154200.61479-1-noralf@tronnes.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org
Cc: oleksandr_andrushchenko@epam.com, intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, airlied@redhat.com, sean@poorly.run, christian.koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

ZHJtX2Rldl91bnBsdWcoKSBoYXMgYmVlbiBzdHJpcHBlZCBkb3duIGFuZCBpcyBnb2luZyBhd2F5
LiBPcGVuIGNvZGUgaXRzCjIgcmVtYWluaW5nIGZ1bmN0aW9uIGNhbGxzLgoKQWxzbyByZW1vdmUg
dGhlIGRybV9kZXZfaXNfdW5wbHVnZ2VkKCkgY2hlY2sgc2luY2UgdGhpcyBjYW4ndCBiZSB0cnVl
CmJlZm9yZSBkcm1fZGV2X3VucmVnaXN0ZXIoKSBpcyBjYWxsZWQgd2hpY2ggaGFwcGVucyBhZnRl
ciB0aGUgY2hlY2suCgpDYzogT2xla3NhbmRyIEFuZHJ1c2hjaGVua28gPG9sZWtzYW5kcl9hbmRy
dXNoY2hlbmtvQGVwYW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBOb3JhbGYgVHLDuG5uZXMgPG5vcmFs
ZkB0cm9ubmVzLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0veGVuL3hlbl9kcm1fZnJvbnQuYyB8
IDcgKystLS0tLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0veGVuL3hlbl9kcm1fZnJvbnQuYyBiL2Ry
aXZlcnMvZ3B1L2RybS94ZW4veGVuX2RybV9mcm9udC5jCmluZGV4IDNlNzhhODMyZDdmOS4uNWM1
ZWIyNGM2MzQyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0veGVuL3hlbl9kcm1fZnJvbnQu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0veGVuL3hlbl9kcm1fZnJvbnQuYwpAQCAtNTc2LDEyICs1
NzYsOSBAQCBzdGF0aWMgdm9pZCB4ZW5fZHJtX2Rydl9maW5pKHN0cnVjdCB4ZW5fZHJtX2Zyb250
X2luZm8gKmZyb250X2luZm8pCiAJaWYgKCFkZXYpCiAJCXJldHVybjsKIAotCS8qIE5vdGhpbmcg
dG8gZG8gaWYgZGV2aWNlIGlzIGFscmVhZHkgdW5wbHVnZ2VkICovCi0JaWYgKGRybV9kZXZfaXNf
dW5wbHVnZ2VkKGRldikpCi0JCXJldHVybjsKLQogCWRybV9rbXNfaGVscGVyX3BvbGxfZmluaShk
ZXYpOwotCWRybV9kZXZfdW5wbHVnKGRldik7CisJZHJtX2Rldl91bnJlZ2lzdGVyKGRldik7CisJ
ZHJtX2Rldl9wdXQoZGV2KTsKIAogCWZyb250X2luZm8tPmRybV9pbmZvID0gTlVMTDsKIAotLSAK
Mi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpk
cmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
