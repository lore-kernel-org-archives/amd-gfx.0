From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] drm/amdgpu: Fix a NULL deref in amdgpu_vm_add_prt_cb()
Date: Mon, 3 Apr 2017 21:41:39 +0300
Message-ID: <20170403184139.GA12398@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Junwei Zhang <Jerry.Zhang@amd.com>, Edward O'Callaghan <funfunctor@folklore1984.net>, Alex Xie <AlexBin.Xie@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

V2UgYWNjaWRlbnRhbGx5IGRlcmVmZXJlbmNlICJjYiIgaWYgdGhlIGttYWxsb2MoKSBmYWlscy4K
CkZpeGVzOiA0NTFiYzhlYjhmZTYgKCJkcm0vYW1kZ3B1OiBmaXggUFJUIHRlYXJkb3duIG9uIFZN
IGZpbmkgdjMiKQpTaWduZWQtb2ZmLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQG9y
YWNsZS5jb20+CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwppbmRleCAwMjM1
ZDc5MzNlZmQuLjQ1YTFiY2ZjNDFmNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtLmMKQEAgLTE1MTgsNyArMTUxOCw3IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV92bV9hZGRfcHJ0
X2NiKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQlpZiAoZmVuY2UpCiAJCQlkbWFfZmVu
Y2Vfd2FpdChmZW5jZSwgZmFsc2UpOwogCi0JCWFtZGdwdV92bV9wcnRfcHV0KGNiLT5hZGV2KTsK
KwkJYW1kZ3B1X3ZtX3BydF9wdXQoYWRldik7CiAJfSBlbHNlIHsKIAkJY2ItPmFkZXYgPSBhZGV2
OwogCQlpZiAoIWZlbmNlIHx8IGRtYV9mZW5jZV9hZGRfY2FsbGJhY2soZmVuY2UsICZjYi0+Y2Is
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZl
bCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
