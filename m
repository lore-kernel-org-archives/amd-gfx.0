From: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/8] drm: fix syncobj null_fence_enable_signaling
Date: Fri, 24 Aug 2018 20:12:03 +0800
Message-ID: <20180824121210.19101-1-david1.zhou@amd.com>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>, Jason Ekstrand <jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

VGhhdCBpcyBjZXJ0YWlubHkgdG90YWxseSBub25zZW5zZS4gZG1hX2ZlbmNlX2VuYWJsZV9zd19z
aWduYWxpbmcoKQppcyB0aGUgZnVuY3Rpb24gd2hvIGlzIGNhbGxpbmcgdGhpcyBjYWxsYmFjay4K
ClNpZ25lZC1vZmYtYnk6IENodW5taW5nIFpob3UgPGRhdmlkMS56aG91QGFtZC5jb20+CkNjOiBK
YXNvbiBFa3N0cmFuZCA8amFzb25Aamxla3N0cmFuZC5uZXQ+ClJldmlld2VkLWJ5OiBDaHJpc3Rp
YW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkFja2VkLWJ5OiBEYW5pZWwgVmV0
dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2RybV9zeW5jb2JqLmMg
fCAxIC0KIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2RybV9zeW5jb2JqLmMgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX3N5bmNvYmouYwpp
bmRleCAzYTg4MzdjNDk2MzkuLmQxN2VkNzVhYzdlMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2RybV9zeW5jb2JqLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2RybV9zeW5jb2JqLmMKQEAg
LTE4NCw3ICsxODQsNiBAQCBzdGF0aWMgY29uc3QgY2hhciAqZHJtX3N5bmNvYmpfbnVsbF9mZW5j
ZV9nZXRfbmFtZShzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZSkKIAogc3RhdGljIGJvb2wgZHJtX3N5
bmNvYmpfbnVsbF9mZW5jZV9lbmFibGVfc2lnbmFsaW5nKHN0cnVjdCBkbWFfZmVuY2UgKmZlbmNl
KQogewotICAgIGRtYV9mZW5jZV9lbmFibGVfc3dfc2lnbmFsaW5nKGZlbmNlKTsKICAgICByZXR1
cm4gIWRtYV9mZW5jZV9pc19zaWduYWxlZChmZW5jZSk7CiB9CiAKLS0gCjIuMTcuMQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
