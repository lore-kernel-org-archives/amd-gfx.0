From: <sunpeng.li@amd.com>
Subject: [PATCH 1/3] drm/dp: Use non-cyclic idr
Date: Mon, 22 Apr 2019 19:56:26 -0400
Message-ID: <1555977388-14203-1-git-send-email-sunpeng.li@amd.com>
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
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Leo Li <sunpeng.li@amd.com>, jerry.zuo@amd.com
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+CgpJbiBwcmVwYXJhdGlvbiBmb3IgYWRk
aW5nIGF1eCBkZXZpY2VzIGZvciBEUCBNU1QsIG1ha2UgdGhlIElEUgpub24tY3ljbGljLiBUaGF0
IHdheSwgaG90cGx1ZyBjeWNsaW5nIE1TVCBkZXZpY2VzIHdvbid0IG5lZWRsZXNzbHkKaW5jcmVt
ZW50IHRoZSBtaW5vciB2ZXJzaW9uIGluZGV4LgoKU2lnbmVkLW9mZi1ieTogTGVvIExpIDxzdW5w
ZW5nLmxpQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2RybV9kcF9hdXhfZGV2LmMgfCAz
ICstLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZHBfYXV4X2Rldi5jIGIvZHJpdmVycy9ncHUv
ZHJtL2RybV9kcF9hdXhfZGV2LmMKaW5kZXggMGU0ZjI1ZC4uNmQ4NDYxMSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2RybV9kcF9hdXhfZGV2LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ry
bV9kcF9hdXhfZGV2LmMKQEAgLTgwLDggKzgwLDcgQEAgc3RhdGljIHN0cnVjdCBkcm1fZHBfYXV4
X2RldiAqYWxsb2NfZHJtX2RwX2F1eF9kZXYoc3RydWN0IGRybV9kcF9hdXggKmF1eCkKIAlrcmVm
X2luaXQoJmF1eF9kZXYtPnJlZmNvdW50KTsKIAogCW11dGV4X2xvY2soJmF1eF9pZHJfbXV0ZXgp
OwotCWluZGV4ID0gaWRyX2FsbG9jX2N5Y2xpYygmYXV4X2lkciwgYXV4X2RldiwgMCwgRFJNX0FV
WF9NSU5PUlMsCi0JCQkJIEdGUF9LRVJORUwpOworCWluZGV4ID0gaWRyX2FsbG9jKCZhdXhfaWRy
LCBhdXhfZGV2LCAwLCBEUk1fQVVYX01JTk9SUywgR0ZQX0tFUk5FTCk7CiAJbXV0ZXhfdW5sb2Nr
KCZhdXhfaWRyX211dGV4KTsKIAlpZiAoaW5kZXggPCAwKSB7CiAJCWtmcmVlKGF1eF9kZXYpOwot
LSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
