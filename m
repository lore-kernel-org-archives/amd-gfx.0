From: "Huang, Ray" <Ray.Huang@amd.com>
Subject: [PATCH 07/14] drm/ttm: add helper to get buffer object with
 ttm_mem_reg
Date: Wed, 11 Sep 2019 11:50:25 +0000
Message-ID: <1568202584-14471-8-git-send-email-ray.huang@amd.com>
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

VGhpcyBwYXRjaCBpcyB0byBhZGQgYSBoZWxwZXIgdG8gZ2V0IGNvcnJlc3BvbmRpbmcgYnVmZmVy
IG9iamVjdCB3aXRoIGEgcG9pbnRlcgp0byBhIHN0cnVjdCB0dG1fbWVtX3JlZy4KClNpZ25lZC1v
ZmYtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogaW5jbHVkZS9kcm0vdHRtL3R0
bV9ib19kcml2ZXIuaCB8IDEzICsrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kcm0vdHRtL3R0bV9ib19kcml2ZXIuaCBi
L2luY2x1ZGUvZHJtL3R0bS90dG1fYm9fZHJpdmVyLmgKaW5kZXggZDY5MTIxYy4uMjY0ZTZjMyAx
MDA2NDQKLS0tIGEvaW5jbHVkZS9kcm0vdHRtL3R0bV9ib19kcml2ZXIuaAorKysgYi9pbmNsdWRl
L2RybS90dG0vdHRtX2JvX2RyaXZlci5oCkBAIC03ODYsNiArNzg2LDE5IEBAIHN0YXRpYyBpbmxp
bmUgdm9pZCB0dG1fYm9fdW5yZXNlcnZlKHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8pCiAJ
cmVzZXJ2YXRpb25fb2JqZWN0X3VubG9jayhiby0+cmVzdik7CiB9CiAKKy8qKgorICogdHRtX21l
bV9yZWdfdG9fYm8KKyAqCisgKiBAbWVtOiBBIHBvaW50ZXIgdG8gYSBzdHJ1Y3QgdHRtX21lbV9y
ZWcuCisgKgorICogUmV0dXJucyBjb3JyZXNwb25kaW5nIGJ1ZmZlciBvYmplY3Qgb2YgdGhlIEBt
ZW0uCisgKi8KK3N0YXRpYyBpbmxpbmUKK3N0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqdHRtX21l
bV9yZWdfdG9fYm8oc3RydWN0IHR0bV9tZW1fcmVnICptZW0pCit7CisJcmV0dXJuIGNvbnRhaW5l
cl9vZihtZW0sIHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCwgbWVtKTsKK30KKwogLyoKICAqIHR0
bV9ib191dGlsLmMKICAqLwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2RyaS1kZXZlbA==
