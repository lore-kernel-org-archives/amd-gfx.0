From: "He, Roger" <Hongbo.He@amd.com>
Subject: RE: [PATCH 2/2] drm/ttm: Don't unreserve swapped BOs that were
 previously reserved
Date: Fri, 19 Jan 2018 03:19:42 +0000
Message-ID: <MWHPR1201MB01273D02F9392B227C7BECA9FDEF0@MWHPR1201MB0127.namprd12.prod.outlook.com>
References: <1516294577-29078-1-git-send-email-Felix.Kuehling@amd.com>
 <1516294577-29078-2-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1516294577-29078-2-git-send-email-Felix.Kuehling@amd.com>
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
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

Z29vZCBjYXRjaCEgCgpUaGFua3MKUm9nZXIoSG9uZ2JvLkhlKQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQpGcm9tOiBLdWVobGluZywgRmVsaXggClNlbnQ6IEZyaWRheSwgSmFudWFyeSAxOSwg
MjAxOCAxMjo1NiBBTQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGRyaS1kZXZl
bEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29l
bmlnQGFtZC5jb20+OyBIZSwgUm9nZXIgPEhvbmdiby5IZUBhbWQuY29tPgpDYzogS3VlaGxpbmcs
IEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgpTdWJqZWN0OiBbUEFUQ0ggMi8yXSBkcm0v
dHRtOiBEb24ndCB1bnJlc2VydmUgc3dhcHBlZCBCT3MgdGhhdCB3ZXJlIHByZXZpb3VzbHkgcmVz
ZXJ2ZWQKCklmIHR0bV9ib19zd2Fwb3V0IGRvZXNuJ3Qgb3duIHRoZSBsb2NrLCBkb24ndCByZWxl
YXNlIGl0LiBTb21lb25lIGVsc2UgcHJvYmFibHkgZGVwZW5kcyBvbiBpdCBzdGlsbCBiZWluZyBs
b2NrZWQuCgpTaWduZWQtb2ZmLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1k
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jIHwgNCArKy0tCiAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5j
IGluZGV4IDYyNTE4YjYuLjg5MzAwM2YgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS90dG0v
dHRtX2JvLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYwpAQCAtMTc4MCw4ICsx
NzgwLDggQEAgaW50IHR0bV9ib19zd2Fwb3V0KHN0cnVjdCB0dG1fYm9fZ2xvYmFsICpnbG9iLCBz
dHJ1Y3QgdHRtX29wZXJhdGlvbl9jdHggKmN0eCkKIAkgKiBVbnJlc2VydmUgd2l0aG91dCBwdXR0
aW5nIG9uIExSVSB0byBhdm9pZCBzd2FwcGluZyBvdXQgYW4KIAkgKiBhbHJlYWR5IHN3YXBwZWQg
YnVmZmVyLgogCSAqLwotCi0JcmVzZXJ2YXRpb25fb2JqZWN0X3VubG9jayhiby0+cmVzdik7CisJ
aWYgKGxvY2tlZCkKKwkJcmVzZXJ2YXRpb25fb2JqZWN0X3VubG9jayhiby0+cmVzdik7CiAJa3Jl
Zl9wdXQoJmJvLT5saXN0X2tyZWYsIHR0bV9ib19yZWxlYXNlX2xpc3QpOwogCXJldHVybiByZXQ7
CiB9Ci0tCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2
ZWwK
