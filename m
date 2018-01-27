From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] drm/radeon: adjust tested variable
Date: Sat, 27 Jan 2018 15:28:15 +0100
Message-ID: <1517063295-16648-1-git-send-email-Julia.Lawall@lip6.fr>
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
To: Alex Deucher <alexander.deucher@amd.com>
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

Q2hlY2sgdGhlIHZhcmlhYmxlIHRoYXQgd2FzIG1vc3QgcmVjZW50bHkgaW5pdGlhbGl6ZWQuCgpU
aGUgc2VtYW50aWMgbWF0Y2ggdGhhdCBmaW5kcyB0aGlzIHByb2JsZW0gaXMgYXMgZm9sbG93czoK
KGh0dHA6Ly9jb2NjaW5lbGxlLmxpcDYuZnIvKQoKLy8gPHNtcGw+CkBACmV4cHJlc3Npb24geCwg
eSwgZiwgZywgZSwgbTsKc3RhdGVtZW50IFMxLFMyLFMzLFM0OwpAQAoKeCA9IGYoLi4uKTsKaWYg
KFwoPCsuLi54Li4uKz5cJmVcKSkgUzEgZWxzZSBTMgooCnggPSBnKC4uLik7CnwKbSA9IGcoLi4u
LCZ4LC4uLik7CnwKeSA9IGcoLi4uKTsKKmlmIChlKQogUzMgZWxzZSBTNAopCi8vIDwvc21wbD4K
ClNpZ25lZC1vZmYtYnk6IEp1bGlhIExhd2FsbCA8SnVsaWEuTGF3YWxsQGxpcDYuZnI+CgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3V2ZC5jIHwgICAgMiArLQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdXZkLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Jh
ZGVvbl91dmQuYwppbmRleCBkMzRkMWNmLi45NWY0ZGI3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl91dmQuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Jh
ZGVvbl91dmQuYwpAQCAtOTk1LDcgKzk5NSw3IEBAIGludCByYWRlb25fdXZkX2NhbGNfdXBsbF9k
aXZpZGVycyhzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiwKIAkJLyogY2FsYyBkY2xrIGRpdmlk
ZXIgd2l0aCBjdXJyZW50IHZjbyBmcmVxICovCiAJCWRjbGtfZGl2ID0gcmFkZW9uX3V2ZF9jYWxj
X3VwbGxfcG9zdF9kaXYodmNvX2ZyZXEsIGRjbGssCiAJCQkJCQkJIHBkX21pbiwgcGRfZXZlbik7
Ci0JCWlmICh2Y2xrX2RpdiA+IHBkX21heCkKKwkJaWYgKGRjbGtfZGl2ID4gcGRfbWF4KQogCQkJ
YnJlYWs7IC8qIHZjbyBpcyB0b28gYmlnLCBpdCBoYXMgdG8gc3RvcCAqLwogCiAJCS8qIGNhbGMg
c2NvcmUgd2l0aCBjdXJyZW50IHZjbyBmcmVxICovCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9kcmktZGV2ZWwK
