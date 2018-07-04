From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] drm/amd/display: off by one in find_irq_source_info()
Date: Wed, 4 Jul 2018 12:46:15 +0300
Message-ID: <20180704094615.ctabdm4cxbkdvuap@kili.mountain>
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
To: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>
Cc: David Airlie <airlied@linux.ie>, Tony Cheng <Tony.Cheng@amd.com>, kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

VGhlIC0+aW5mb1tdIGFycmF5IGhhcyBEQUxfSVJRX1NPVVJDRVNfTlVNQkVSIGVsZW1lbnRzIHNv
IHRoaXMgY29uZGl0aW9uCnNob3VsZCBiZSA+PSBpbnN0ZWFkIG9mID4gb3Igd2UgY291bGQgcmVh
ZCBvbmUgZWxlbWVudCBiZXlvbmQgdGhlIGVuZCBvZgp0aGUgYXJyYXkuCgpGaXhlczogNDU2MjIz
NmIzYmMwICgiZHJtL2FtZC9kYzogQWRkIGRjIGRpc3BsYXkgZHJpdmVyICh2MikiKQpTaWduZWQt
b2ZmLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+CgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2lycS9pcnFfc2VydmljZS5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2lycS9pcnFfc2VydmljZS5jCmluZGV4IGRj
ZGZhMGYwMTU1MS4uNjA0YmVhMDFmYzEzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvaXJxL2lycV9zZXJ2aWNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2lycS9pcnFfc2VydmljZS5jCkBAIC03OCw3ICs3OCw3IEBAIGNvbnN0IHN0cnVj
dCBpcnFfc291cmNlX2luZm8gKmZpbmRfaXJxX3NvdXJjZV9pbmZvKAogCXN0cnVjdCBpcnFfc2Vy
dmljZSAqaXJxX3NlcnZpY2UsCiAJZW51bSBkY19pcnFfc291cmNlIHNvdXJjZSkKIHsKLQlpZiAo
c291cmNlID4gREFMX0lSUV9TT1VSQ0VTX05VTUJFUiB8fCBzb3VyY2UgPCBEQ19JUlFfU09VUkNF
X0lOVkFMSUQpCisJaWYgKHNvdXJjZSA+PSBEQUxfSVJRX1NPVVJDRVNfTlVNQkVSIHx8IHNvdXJj
ZSA8IERDX0lSUV9TT1VSQ0VfSU5WQUxJRCkKIAkJcmV0dXJuIE5VTEw7CiAKIAlyZXR1cm4gJmly
cV9zZXJ2aWNlLT5pbmZvW3NvdXJjZV07Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2RyaS1kZXZlbAo=
