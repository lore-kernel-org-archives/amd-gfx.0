From: =?UTF-8?q?Christian=20K=C3=B6nig?= <deathsimple@vodafone.de>
Subject: [PATCH 4/6] drm/amdgpu: double the priority of kernel allocations
Date: Fri, 13 Jan 2017 10:51:09 +0100
Message-ID: <1484301071-21703-5-git-send-email-deathsimple@vodafone.de>
References: <1484301071-21703-1-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1484301071-21703-1-git-send-email-deathsimple@vodafone.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Hongbo.He@amd.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKR2l2ZSBr
ZXJuZWwgYWxsb2NhdGlvbnMgYSBoaWdoZXIgcHJpb3JpdHkgY2F1c2UgaXQgaXMgb2Z0ZW4KbW9y
ZSB3b3JrIHRvIHN3YXAgdGhlbSBiYWNrIGluLgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvD
tm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9vYmplY3QuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2Jq
ZWN0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKaW5kZXgg
ZjM5OWQ5OC4uMmRlMWRkYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X29iamVjdC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9v
YmplY3QuYwpAQCAtMzg3LDYgKzM4Nyw4IEBAIGludCBhbWRncHVfYm9fY3JlYXRlX3Jlc3RyaWN0
ZWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCXJldHVybiByOwogCiAJYm8tPnRiby5w
cmlvcml0eSA9IGlsb2cyKGJvLT50Ym8ubnVtX3BhZ2VzKTsKKwlpZiAoa2VybmVsKQorCQliby0+
dGJvLnByaW9yaXR5ICo9IDI7CiAJYm8tPnRiby5wcmlvcml0eSA9IG1pbihiby0+dGJvLnByaW9y
aXR5LCBUVE1fTUFYX0JPX1BSSU9SSVRZIC0gMSk7CiAKIAlpZiAoZmxhZ3MgJiBBTURHUFVfR0VN
X0NSRUFURV9WUkFNX0NMRUFSRUQgJiYKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZl
bEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
