From: "Yang, Philip" <Philip.Yang@amd.com>
Subject: [PATCH] mm/hmm: hmm_range_fault handle pages swapped out
Date: Thu, 15 Aug 2019 20:52:56 +0000
Message-ID: <20190815205227.7949-1-Philip.Yang@amd.com>
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
To: "jglisse@redhat.com" <jglisse@redhat.com>, "alex.deucher@amd.com" <alex.deucher@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, "jgg@mellanox.com" <jgg@mellanox.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "Yang, Philip" <Philip.Yang@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

aG1tX3JhbmdlX2ZhdWx0IG1heSByZXR1cm4gTlVMTCBwYWdlcyBiZWNhdXNlIHNvbWUgb2YgcGZu
cyBhcmUgZXF1YWwgdG8KSE1NX1BGTl9OT05FLiBUaGlzIGhhcHBlbnMgcmFuZG9tbHkgdW5kZXIg
bWVtb3J5IHByZXNzdXJlLiBUaGUgcmVhc29uIGlzCmZvciBzd2FwcGVkIG91dCBwYWdlIHB0ZSBw
YXRoLCBobW1fdm1hX2hhbmRsZV9wdGUgZG9lc24ndCB1cGRhdGUgZmF1bHQKdmFyaWFibGUgZnJv
bSBjcHVfZmxhZ3MsIHNvIGl0IGZhaWxlZCB0byBjYWxsIGhtbV92YW1fZG9fZmF1bHQgdG8gc3dh
cAp0aGUgcGFnZSBpbi4KClRoZSBmaXggaXMgdG8gY2FsbCBobW1fcHRlX25lZWRfZmF1bHQgdG8g
dXBkYXRlIGZhdWx0IHZhcmlhYmxlLgoKQ2hhbmdlLUlkOiBJMmU4NjExNDg1NTYzZDExZDkzODg4
MWMxOGI3OTM1ZmExZTdjOTFlZQpTaWduZWQtb2ZmLWJ5OiBQaGlsaXAgWWFuZyA8UGhpbGlwLllh
bmdAYW1kLmNvbT4KLS0tCiBtbS9obW0uYyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvbW0vaG1tLmMgYi9tbS9obW0uYwppbmRleCA5ZjIyNTYy
ZTJjNDMuLjdjYTRmYjM5ZDNkOCAxMDA2NDQKLS0tIGEvbW0vaG1tLmMKKysrIGIvbW0vaG1tLmMK
QEAgLTU0NCw2ICs1NDQsOSBAQCBzdGF0aWMgaW50IGhtbV92bWFfaGFuZGxlX3B0ZShzdHJ1Y3Qg
bW1fd2FsayAqd2FsaywgdW5zaWduZWQgbG9uZyBhZGRyLAogCQlzd3BfZW50cnlfdCBlbnRyeSA9
IHB0ZV90b19zd3BfZW50cnkocHRlKTsKIAogCQlpZiAoIW5vbl9zd2FwX2VudHJ5KGVudHJ5KSkg
eworCQkJY3B1X2ZsYWdzID0gcHRlX3RvX2htbV9wZm5fZmxhZ3MocmFuZ2UsIHB0ZSk7CisJCQlo
bW1fcHRlX25lZWRfZmF1bHQoaG1tX3ZtYV93YWxrLCBvcmlnX3BmbiwgY3B1X2ZsYWdzLAorCQkJ
CQkgICAmZmF1bHQsICZ3cml0ZV9mYXVsdCk7CiAJCQlpZiAoZmF1bHQgfHwgd3JpdGVfZmF1bHQp
CiAJCQkJZ290byBmYXVsdDsKIAkJCXJldHVybiAwOwotLSAKMi4xNy4xCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0
CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
