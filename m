From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH 0/6] drm/drv: Remove drm_dev_unplug()
Date: Sun,  3 Feb 2019 16:41:54 +0100
Message-ID: <20190203154200.61479-1-noralf@tronnes.org>
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
To: dri-devel@lists.freedesktop.org
Cc: oleksandr_andrushchenko@epam.com, intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, airlied@redhat.com, sean@poorly.run, christian.koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

VGhpcyBzZXJpZXMgcmVtb3ZlcyBkcm1fZGV2X3VucGx1ZygpIGFuZCBtb3ZlcyB0aGUgdW5wbHVn
Z2VkIHN0YXRlCnNldHRpbmcgdG8gZHJtX2Rldl91bnJlZ2lzdGVyKCkuIEFsbCBkcml2ZXJzIHdp
bGwgbm93IGhhdmUgYWNjZXNzIHRvIHRoZQp1bnBsdWdnZWQgc3RhdGUgaWYgdGhleSBzbyBkZXNp
cmUuCgpUaGUgZHJtX2RldmljZSByZWYgaGFuZGxpbmcgd3J0IHRvIHRoZSBsYXN0IGZkIGNsb3Nl
ZCBhZnRlciB1bnJlZ2lzdGVyCmhhdmUgYmVlbiBzaW1wbGlmaWVkLCB3aGljaCBhbHNvIGZpeGVk
IGEgZG91YmxlIGRybV9kZXZfdW5yZWdpc3RlcigpCnNpdHVhdGlvbi4KCk5vcmFsZi4KCk5vcmFs
ZiBUcsO4bm5lcyAoNik6CiAgZHJtOiBGaXggZHJtX3JlbGVhc2UoKSBhbmQgZGV2aWNlIHVucGx1
ZwogIGRybS9kcnY6IFByZXBhcmUgdG8gcmVtb3ZlIGRybV9kZXZfdW5wbHVnKCkKICBkcm0vYW1k
OiBVc2UgZHJtX2Rldl91bnJlZ2lzdGVyKCkKICBkcm0vdWRsOiBVc2UgZHJtX2Rldl91bnJlZ2lz
dGVyKCkKICBkcm0veGVuOiBVc2UgZHJtX2Rldl91bnJlZ2lzdGVyKCkKICBkcm0vZHJ2OiBSZW1v
dmUgZHJtX2Rldl91bnBsdWcoKQoKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
cnYuYyB8ICAzICstCiBkcml2ZXJzL2dwdS9kcm0vZHJtX2Rydi5jICAgICAgICAgICAgICAgfCA0
OCArKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vZHJtX2ZpbGUuYyAg
ICAgICAgICAgICAgfCAgNiArKy0tCiBkcml2ZXJzL2dwdS9kcm0vdWRsL3VkbF9kcnYuYyAgICAg
ICAgICAgfCAgMyArLQogZHJpdmVycy9ncHUvZHJtL3hlbi94ZW5fZHJtX2Zyb250LmMgICAgIHwg
IDcgKystLQogaW5jbHVkZS9kcm0vZHJtX2Rydi5oICAgICAgICAgICAgICAgICAgIHwgMTEgKysr
LS0tCiA2IGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDUxIGRlbGV0aW9ucygtKQoK
LS0gCjIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
Cg==
