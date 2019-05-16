From: <sunpeng.li@amd.com>
Subject: [PATCH 1/7] drm/dp: Use non-cyclic idr
Date: Thu, 16 May 2019 11:17:57 -0400
Message-ID: <1558019883-12397-2-git-send-email-sunpeng.li@amd.com>
References: <1558019883-12397-1-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1558019883-12397-1-git-send-email-sunpeng.li@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Leo Li <sunpeng.li@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+CgpJbiBwcmVwYXJhdGlvbiBmb3IgYWRk
aW5nIGF1eCBkZXZpY2VzIGZvciBEUCBNU1QsIG1ha2UgdGhlIElEUgpub24tY3ljbGljLiBUaGF0
IHdheSwgaG90cGx1ZyBjeWNsaW5nIE1TVCBkZXZpY2VzIHdvbid0IG5lZWRsZXNzbHkKaW5jcmVt
ZW50IHRoZSBtaW5vciB2ZXJzaW9uIGluZGV4LgoKU2lnbmVkLW9mZi1ieTogTGVvIExpIDxzdW5w
ZW5nLmxpQGFtZC5jb20+ClJldmlld2VkLWJ5OiBMeXVkZSBQYXVsIDxseXVkZUByZWRoYXQuY29t
PgpSZXZpZXdlZC1ieTogVmlsbGUgU3lyasOkbMOkIDx2aWxsZS5zeXJqYWxhQGxpbnV4LmludGVs
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vZHJtX2RwX2F1eF9kZXYuYyB8IDMgKy0tCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2RybV9kcF9hdXhfZGV2LmMgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2Rw
X2F1eF9kZXYuYwppbmRleCAwZTRmMjVkLi42ZDg0NjExIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vZHJtX2RwX2F1eF9kZXYuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2RwX2F1eF9k
ZXYuYwpAQCAtODAsOCArODAsNyBAQCBzdGF0aWMgc3RydWN0IGRybV9kcF9hdXhfZGV2ICphbGxv
Y19kcm1fZHBfYXV4X2RldihzdHJ1Y3QgZHJtX2RwX2F1eCAqYXV4KQogCWtyZWZfaW5pdCgmYXV4
X2Rldi0+cmVmY291bnQpOwogCiAJbXV0ZXhfbG9jaygmYXV4X2lkcl9tdXRleCk7Ci0JaW5kZXgg
PSBpZHJfYWxsb2NfY3ljbGljKCZhdXhfaWRyLCBhdXhfZGV2LCAwLCBEUk1fQVVYX01JTk9SUywK
LQkJCQkgR0ZQX0tFUk5FTCk7CisJaW5kZXggPSBpZHJfYWxsb2MoJmF1eF9pZHIsIGF1eF9kZXYs
IDAsIERSTV9BVVhfTUlOT1JTLCBHRlBfS0VSTkVMKTsKIAltdXRleF91bmxvY2soJmF1eF9pZHJf
bXV0ZXgpOwogCWlmIChpbmRleCA8IDApIHsKIAkJa2ZyZWUoYXV4X2Rldik7Ci0tIAoyLjcuNAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
