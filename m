From: "Huang, Ray" <Ray.Huang@amd.com>
Subject: [PATCH v2 02/11] drm/amdgpu: add UAPI to create secure commands (v3)
Date: Wed, 25 Sep 2019 13:45:14 +0000
Message-ID: <1569419090-5304-3-git-send-email-ray.huang@amd.com>
References: <1569419090-5304-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1569419090-5304-1-git-send-email-ray.huang@amd.com>
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
Cc: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogTHViZW4gVHVpa292IDxsdWJlbi50dWlrb3ZAYW1kLmNvbT4KCkFkZCBhIGZsYWcgdG8g
dGhlIGNvbW1hbmQgc3VibWlzc2lvbiBJT0NUTApzdHJ1Y3R1cmUgd2hpY2ggd2hlbiBwcmVzZW50
IGluZGljYXRlcyB0aGF0IHRoaXMKY29tbWFuZCBzdWJtaXNzaW9uIHNob3VsZCBiZSB0cmVhdGVk
IGFzCnNlY3VyZS4gVGhlIGtlcm5lbCBkcml2ZXIgdXNlcyB0aGlzIGZsYWcgdG8KZGV0ZXJtaW5l
IHdoZXRoZXIgdGhlIGVuZ2luZSBzaG91bGQgYmUKdHJhbnNpdGlvbmVkIHRvIHNlY3VyZSBvciB1
bnNlY3VyZSwgb3IgdGhlIHdvcmsKY2FuIGJlIHN1Ym1pdHRlZCB0byBhIHNlY3VyZSBxdWV1ZSBk
ZXBlbmRpbmcgb24KdGhlIElQLgoKdjM6IHRoZSBmbGFnIGlzIG5vdyBhdCBjb21tYW5kIHN1Ym1p
c3Npb24gSU9DVEwKClNpZ25lZC1vZmYtYnk6IEx1YmVuIFR1aWtvdiA8bHViZW4udHVpa292QGFt
ZC5jb20+ClJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+Ci0tLQogaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmggfCA1ICsrKystCiAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvaW5j
bHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmggYi9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0u
aAppbmRleCBmOTBiNDUzLi5hMTAxZWVhIDEwMDY0NAotLS0gYS9pbmNsdWRlL3VhcGkvZHJtL2Ft
ZGdwdV9kcm0uaAorKysgYi9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaApAQCAtMjA3LDYg
KzIwNyw5IEBAIHVuaW9uIGRybV9hbWRncHVfYm9fbGlzdCB7CiAjZGVmaW5lIEFNREdQVV9DVFhf
T1BfUVVFUllfU1RBVEUJMwogI2RlZmluZSBBTURHUFVfQ1RYX09QX1FVRVJZX1NUQVRFMgk0CiAK
Ky8qIEZsYWcgdGhlIGNvbW1hbmQgc3VibWlzc2lvbiBhcyBzZWN1cmUgKi8KKyNkZWZpbmUgQU1E
R1BVX0NTX0ZMQUdTX1NFQ1VSRSAgICAgICAgICAoMSA8PCAwKQorCiAvKiBHUFUgcmVzZXQgc3Rh
dHVzICovCiAjZGVmaW5lIEFNREdQVV9DVFhfTk9fUkVTRVQJCTAKIC8qIHRoaXMgdGhlIGNvbnRl
eHQgY2F1c2VkIGl0ICovCkBAIC01NjIsNyArNTY1LDcgQEAgc3RydWN0IGRybV9hbWRncHVfY3Nf
aW4gewogCS8qKiAgSGFuZGxlIG9mIHJlc291cmNlIGxpc3QgYXNzb2NpYXRlZCB3aXRoIENTICov
CiAJX191MzIJCWJvX2xpc3RfaGFuZGxlOwogCV9fdTMyCQludW1fY2h1bmtzOwotCV9fdTMyCQlf
cGFkOworCV9fdTMyCQlmbGFnczsKIAkvKiogdGhpcyBwb2ludHMgdG8gX191NjQgKiB3aGljaCBw
b2ludCB0byBjcyBjaHVua3MgKi8KIAlfX3U2NAkJY2h1bmtzOwogfTsKLS0gCjIuNy40CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFp
bGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
