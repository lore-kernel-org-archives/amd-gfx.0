From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] drm/amd: work around llvm bug #42576
Date: Fri, 12 Jul 2019 11:34:57 +0200
Message-ID: <20190712093508.1420279-1-arnd@arndb.de>
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
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: Philip Yang <Philip.Yang@amd.com>, Arnd Bergmann <arnd@arndb.de>, Oak Zeng <Oak.Zeng@amd.com>, xinhui pan <xinhui.pan@amd.com>, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, clang-built-linux@googlegroups.com, Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org, Evan Quan <evan.quan@amd.com>, Rex Zhu <Rex.Zhu@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

Q29kZSBpbiB0aGUgYW1kZ3B1IGRyaXZlciB0cmlnZ2VycyBhIGJ1ZyB3aGVuIHVzaW5nIGNsYW5n
IHRvIGJ1aWxkCmFuIGFybTY0IGtlcm5lbDoKCi90bXAvc2RtYV92NF8wLWY5NWZkMy5zOiBBc3Nl
bWJsZXIgbWVzc2FnZXM6Ci90bXAvc2RtYV92NF8wLWY5NWZkMy5zOjQ0OiBFcnJvcjogc2VsZWN0
ZWQgcHJvY2Vzc29yIGRvZXMgbm90IHN1cHBvcnQgYGJmYyB3MCwjMSwjNScKCkkgZXhwZWN0IHRo
aXMgdG8gYmUgZml4ZWQgaW4gbGx2bSBzb29uLCBidXQgd2UgY2FuIGFsc28gd29yayBhcm91bmQK
aXQgYnkgaW5zZXJ0aW5nIGEgYmFycmllcigpIHRoYXQgcHJldmVudHMgdGhlIG9wdGltaXphdGlv
bi4KCkxpbms6IGh0dHBzOi8vYnVncy5sbHZtLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9NDI1NzYKU2ln
bmVkLW9mZi1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4KLS0tClNlbmRpbmcgdGhp
cyBmb3IgY29tcGxldGVuZXNzLCBwbGVhc2UgZGVjaWRlIGZvciB5b3Vyc2VsdmVzIHdoZXRoZXIg
dG8KYXBwbHkgaXQgb3Igbm90LCBnaXZlbiB0aGF0IGl0J3MgYSB0cml2aWFsIHdvcmthcm91bmQg
YnV0IHByb2JhYmx5IG5vdApuZWVkZWQgaW4gdGhlIGxvbmcgcnVuLgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0
XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5jCmluZGV4IDQ0Mjgw
MTg2NzJkMy4uMTU0NDE2YTYyNmRmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9zZG1hX3Y0XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0
XzAuYwpAQCAtNzczLDYgKzc3Myw3IEBAIHN0YXRpYyB1aW50MzJfdCBzZG1hX3Y0XzBfcmJfY250
bChzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsIHVpbnQzMl90IHJiX2NudGwpCiAJLyogU2V0IHJp
bmcgYnVmZmVyIHNpemUgaW4gZHdvcmRzICovCiAJdWludDMyX3QgcmJfYnVmc3ogPSBvcmRlcl9i
YXNlXzIocmluZy0+cmluZ19zaXplIC8gNCk7CiAKKwliYXJyaWVyKCk7IC8qIHdvcmsgYXJvdW5k
IGh0dHBzOi8vYnVncy5sbHZtLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9NDI1NzYgKi8KIAlyYl9jbnRs
ID0gUkVHX1NFVF9GSUVMRChyYl9jbnRsLCBTRE1BMF9HRlhfUkJfQ05UTCwgUkJfU0laRSwgcmJf
YnVmc3opOwogI2lmZGVmIF9fQklHX0VORElBTgogCXJiX2NudGwgPSBSRUdfU0VUX0ZJRUxEKHJi
X2NudGwsIFNETUEwX0dGWF9SQl9DTlRMLCBSQl9TV0FQX0VOQUJMRSwgMSk7Ci0tIAoyLjIwLjAK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZl
bCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
