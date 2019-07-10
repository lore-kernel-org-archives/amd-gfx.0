From: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/5] drm/amdgpu: Add flag to wipe VRAM on release
Date: Wed, 10 Jul 2019 03:59:08 +0000
Message-ID: <20190710035848.26966-1-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

VGhpcyBtZW1vcnkgYWxsb2NhdGlvbiBmbGFnIHdpbGwgYmUgdXNlZCB0byBpbmRpY2F0ZSBCT3Mg
Y29udGFpbmluZwpzZW5zaXRpdmUgZGF0YSB0aGF0IHNob3VsZCBub3QgYmUgbGVha2VkIHRvIG90
aGVyIHByb2Nlc3Nlcy4KClNpZ25lZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVo
bGluZ0BhbWQuY29tPgotLS0KIGluY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oIHwgNCArKysr
CiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS91
YXBpL2RybS9hbWRncHVfZHJtLmggYi9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaAppbmRl
eCA2MTg3MDQ3OGJjOWMuLmRjMzQyOGIzMjVhZSAxMDA2NDQKLS0tIGEvaW5jbHVkZS91YXBpL2Ry
bS9hbWRncHVfZHJtLmgKKysrIGIvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgKQEAgLTEz
MSw2ICsxMzEsMTAgQEAgZXh0ZXJuICJDIiB7CiAgKiBmb3IgdGhlIHNlY29uZCBwYWdlIG9ud2Fy
ZCBzaG91bGQgYmUgc2V0IHRvIE5DLgogICovCiAjZGVmaW5lIEFNREdQVV9HRU1fQ1JFQVRFX01R
RF9HRlg5CQkoMSA8PCA4KQorLyogRmxhZyB0aGF0IEJPIG1heSBjb250YWluIHNlbnNpdGl2ZSBk
YXRhIHRoYXQgbXVzdCBiZSB3aXBlZCBiZWZvcmUKKyAqIHJlbGVhc2luZyB0aGUgbWVtb3J5Cisg
Ki8KKyNkZWZpbmUgQU1ER1BVX0dFTV9DUkVBVEVfVlJBTV9XSVBFX09OX1JFTEVBU0UJKDEgPDwg
OSkKIAogc3RydWN0IGRybV9hbWRncHVfZ2VtX2NyZWF0ZV9pbiAgewogCS8qKiB0aGUgcmVxdWVz
dGVkIG1lbW9yeSBzaXplICovCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeA==
