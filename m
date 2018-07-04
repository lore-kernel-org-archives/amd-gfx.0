From: Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH] drm/amd/display: off by one in find_irq_source_info()
Date: Wed, 4 Jul 2018 10:44:58 -0400
Message-ID: <fe92e7f9-06b4-aba0-4cd9-afee1e2ad704@amd.com>
References: <20180704094615.ctabdm4cxbkdvuap@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180704094615.ctabdm4cxbkdvuap@kili.mountain>
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
To: Dan Carpenter <dan.carpenter@oracle.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: David Airlie <airlied@linux.ie>, Tony Cheng <Tony.Cheng@amd.com>, kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gMjAxOC0wNy0wNCAwNTo0NiBBTSwgRGFuIENhcnBlbnRlciB3cm90ZToKPiBUaGUgLT5pbmZv
W10gYXJyYXkgaGFzIERBTF9JUlFfU09VUkNFU19OVU1CRVIgZWxlbWVudHMgc28gdGhpcyBjb25k
aXRpb24KPiBzaG91bGQgYmUgPj0gaW5zdGVhZCBvZiA+IG9yIHdlIGNvdWxkIHJlYWQgb25lIGVs
ZW1lbnQgYmV5b25kIHRoZSBlbmQgb2YKPiB0aGUgYXJyYXkuCj4gCj4gRml4ZXM6IDQ1NjIyMzZi
M2JjMCAoImRybS9hbWQvZGM6IEFkZCBkYyBkaXNwbGF5IGRyaXZlciAodjIpIikKPiBTaWduZWQt
b2ZmLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+CgpSZXZpZXdl
ZC1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+CgpIYXJyeQoKPiAK
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2lycS9pcnFfc2Vy
dmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2lycS9pcnFfc2VydmljZS5j
Cj4gaW5kZXggZGNkZmEwZjAxNTUxLi42MDRiZWEwMWZjMTMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2lycS9pcnFfc2VydmljZS5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2lycS9pcnFfc2VydmljZS5jCj4gQEAgLTc4LDcgKzc4
LDcgQEAgY29uc3Qgc3RydWN0IGlycV9zb3VyY2VfaW5mbyAqZmluZF9pcnFfc291cmNlX2luZm8o
Cj4gIAlzdHJ1Y3QgaXJxX3NlcnZpY2UgKmlycV9zZXJ2aWNlLAo+ICAJZW51bSBkY19pcnFfc291
cmNlIHNvdXJjZSkKPiAgewo+IC0JaWYgKHNvdXJjZSA+IERBTF9JUlFfU09VUkNFU19OVU1CRVIg
fHwgc291cmNlIDwgRENfSVJRX1NPVVJDRV9JTlZBTElEKQo+ICsJaWYgKHNvdXJjZSA+PSBEQUxf
SVJRX1NPVVJDRVNfTlVNQkVSIHx8IHNvdXJjZSA8IERDX0lSUV9TT1VSQ0VfSU5WQUxJRCkKPiAg
CQlyZXR1cm4gTlVMTDsKPiAgCj4gIAlyZXR1cm4gJmlycV9zZXJ2aWNlLT5pbmZvW3NvdXJjZV07
Cj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1k
ZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
