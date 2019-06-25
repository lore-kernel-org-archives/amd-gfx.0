From: Prike Liang <Prike.Liang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2] drm/amd/powerplay:clean up the residual mutex for
 smu_hw_init
Date: Tue, 25 Jun 2019 15:43:15 +0800
Message-ID: <1561448595-32319-1-git-send-email-Prike.Liang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Prike Liang <Prike.Liang-5C7GfCeVMHo@public.gmane.org>, Evan.Quan-5C7GfCeVMHo@public.gmane.org, Ray.Huang-5C7GfCeVMHo@public.gmane.org

VGhlIG11dGV4IGZvciBwcm9jdGluZyBTTVUgZHVyaW5nIGh3X2luaXQgd2FzIHJlbW92ZWQgYXMg
c3lzdGVtCndpbGwgYmUgZGVhZGxvY2sgd2hlbiBzbXVfcG9wdWxhdGVfdW1kX3N0YXRlX2NsayB0
cnkgZ2V0IFNNVSBtdXRleC4KVGhlcmVmb3JlIG5lZWQgcmVtb3ZlIHRoZSByZXNpZHVhbCBtdXRl
eCBmcm9tIGZhaWxlZCBwYXRoLgoKQ2hhbmdlLUlkOiBJZDgwMTljMDFiOTQ5NmMwNjdlZmRhNDgx
N2E0Njk4M2U0ZGEzYjZlNApTaWduZWQtb2ZmLWJ5OiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdA
YW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMg
fCAxIC0KIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jCmluZGV4IGY2MWVjYmYuLmZlODNjNWUgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMKQEAgLTEwNDQsNyArMTA0NCw2
IEBAIHN0YXRpYyBpbnQgc211X2h3X2luaXQodm9pZCAqaGFuZGxlKQogCXJldHVybiAwOwogCiBm
YWlsZWQ6Ci0JbXV0ZXhfdW5sb2NrKCZzbXUtPm11dGV4KTsKIAlyZXR1cm4gcmV0OwogfQogCi0t
IAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
