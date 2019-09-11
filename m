From: "Huang, Ray" <Ray.Huang@amd.com>
Subject: [PATCH 09/14] drm/amdgpu: add tmz bit in frame control packet
Date: Wed, 11 Sep 2019 11:50:32 +0000
Message-ID: <1568202584-14471-10-git-send-email-ray.huang@amd.com>
References: <1568202584-14471-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1568202584-14471-1-git-send-email-ray.huang@amd.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

VGhpcyBwYXRjaCBhZGRzIHRteiBiaXQgaW4gZnJhbWUgY29udHJvbCBwbTQgcGFja2V0LCBhbmQg
aXQgd2lsbCB1c2VkIGluIGZ1dHVyZS4KClNpZ25lZC1vZmYtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1
YW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVy
QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnZkLmggICAgfCAxICsK
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1ZC5oIHwgMSArCiAyIGZpbGVzIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L252ZC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnZkLmgKaW5kZXggMWRlOTg0
Ni4uZjNkODc3MSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnZkLmgK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnZkLmgKQEAgLTMwNiw2ICszMDYsNyBA
QAogI2RlZmluZQlQQUNLRVQzX0dFVF9MT0RfU1RBVFMJCQkJMHg4RQogI2RlZmluZQlQQUNLRVQz
X0RSQVdfTVVMVElfUFJFQU1CTEUJCQkweDhGCiAjZGVmaW5lCVBBQ0tFVDNfRlJBTUVfQ09OVFJP
TAkJCQkweDkwCisjCQkJZGVmaW5lIEZSQU1FX1RNWgkoMSA8PCAwKQogIwkJCWRlZmluZSBGUkFN
RV9DTUQoeCkgKCh4KSA8PCAyOCkKIAkJCS8qCiAJCQkgKiB4PTA6IHRtel9iZWdpbgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTVkLmggYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9zb2MxNWQuaAppbmRleCBlZGZlNTA4Li4yOTVkNjhjIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNWQuaAorKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9zb2MxNWQuaApAQCAtMjg2LDYgKzI4Niw3IEBACiAjZGVmaW5lCVBBQ0tF
VDNfV0FJVF9PTl9ERV9DT1VOVEVSX0RJRkYJCQkweDg4CiAjZGVmaW5lCVBBQ0tFVDNfU1dJVENI
X0JVRkZFUgkJCQkweDhCCiAjZGVmaW5lIFBBQ0tFVDNfRlJBTUVfQ09OVFJPTAkJCQkweDkwCisj
CQkJZGVmaW5lIEZSQU1FX1RNWgkoMSA8PCAwKQogIwkJCWRlZmluZSBGUkFNRV9DTUQoeCkgKCh4
KSA8PCAyOCkKIAkJCS8qCiAJCQkgKiB4PTA6IHRtel9iZWdpbgotLSAKMi43LjQKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5n
IGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
