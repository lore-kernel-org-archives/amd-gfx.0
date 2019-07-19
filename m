From: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Add flag to wipe VRAM on release
Date: Fri, 19 Jul 2019 22:02:04 +0000
Message-ID: <20190719220140.18968-1-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
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
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

VGhpcyBtZW1vcnkgYWxsb2NhdGlvbiBmbGFnIHdpbGwgYmUgdXNlZCB0byBpbmRpY2F0ZSBCT3Mg
Y29udGFpbmluZwpzZW5zaXRpdmUgZGF0YSB0aGF0IHNob3VsZCBub3QgYmUgbGVha2VkIHRvIG90
aGVyIHByb2Nlc3Nlcy4KClNpZ25lZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVo
bGluZ0BhbWQuY29tPgotLS0KIGluY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oIHwgNCArKysr
CiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS91
YXBpL2RybS9hbWRncHVfZHJtLmggYi9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaAppbmRl
eCBkNDk1NzFkYWIyYTEuLmNhOTdiNjgwMjI3NSAxMDA2NDQKLS0tIGEvaW5jbHVkZS91YXBpL2Ry
bS9hbWRncHVfZHJtLmgKKysrIGIvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgKQEAgLTEz
MSw2ICsxMzEsMTAgQEAgZXh0ZXJuICJDIiB7CiAgKiBmb3IgdGhlIHNlY29uZCBwYWdlIG9ud2Fy
ZCBzaG91bGQgYmUgc2V0IHRvIE5DLgogICovCiAjZGVmaW5lIEFNREdQVV9HRU1fQ1JFQVRFX01R
RF9HRlg5CQkoMSA8PCA4KQorLyogRmxhZyB0aGF0IEJPIG1heSBjb250YWluIHNlbnNpdGl2ZSBk
YXRhIHRoYXQgbXVzdCBiZSB3aXBlZCBiZWZvcmUKKyAqIHJlbGVhc2luZyB0aGUgbWVtb3J5Cisg
Ki8KKyNkZWZpbmUgQU1ER1BVX0dFTV9DUkVBVEVfVlJBTV9XSVBFX09OX1JFTEVBU0UJKDEgPDwg
OSkKIAogc3RydWN0IGRybV9hbWRncHVfZ2VtX2NyZWF0ZV9pbiAgewogCS8qKiB0aGUgcmVxdWVz
dGVkIG1lbW9yeSBzaXplICovCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2RyaS1kZXZlbA==
