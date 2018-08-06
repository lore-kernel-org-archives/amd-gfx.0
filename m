From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] gpu: drm: radeon: cik: Replace mdelay() with msleep() in
 cik_pcie_gen3_enable()
Date: Mon, 6 Aug 2018 16:26:56 -0400
Message-ID: <CADnq5_MW=3-PbZnb_9JQgfoYBZh8iti0tY+zP+mkZzK6upVHFg@mail.gmail.com>
References: <20180804002535.18434-1-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180804002535.18434-1-baijiaju1990@gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gRnJpLCBBdWcgMywgMjAxOCBhdCA4OjI1IFBNLCBKaWEtSnUgQmFpIDxiYWlqaWFqdTE5OTBA
Z21haWwuY29tPiB3cm90ZToKPiBjaWtfcGNpZV9nZW4zX2VuYWJsZSgpIGlzIG5ldmVyIGNhbGxl
ZCBpbiBhdG9taWMgY29udGV4dC4KPiBJdCBjYWxscyBtZGVsYXkoKSB0byBidXNpbHkgd2FpdCwg
d2hpY2ggaXMgbm90IG5lY2Vzc2FyeS4KPiBtZGVsYXkoKSBjYW4gYmUgcmVwbGFjZWQgd2l0aCBt
c2xlZXAoKS4KPgo+IFRoaXMgaXMgZm91bmQgYnkgYSBzdGF0aWMgYW5hbHlzaXMgdG9vbCBuYW1l
ZCBEQ05TIHdyaXR0ZW4gYnkgbXlzZWxmLgo+Cj4gU2lnbmVkLW9mZi1ieTogSmlhLUp1IEJhaSA8
YmFpamlhanUxOTkwQGdtYWlsLmNvbT4KCkFwcGxpZWQuICB0aGFua3MuCgpBbGV4Cgo+IC0tLQo+
ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2Npay5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL2Npay5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9jaWsuYwo+IGluZGV4
IDdjNzNiYzdlMmY4NS4uYzFiNGQ0ZmJjZjNhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vY2lrLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2Npay5jCj4gQEAg
LTk1OTgsNyArOTU5OCw3IEBAIHN0YXRpYyB2b2lkIGNpa19wY2llX2dlbjNfZW5hYmxlKHN0cnVj
dCByYWRlb25fZGV2aWNlICpyZGV2KQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dG1wIHw9IExDX1JFRE9fRVE7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBXUkVH
MzJfUENJRV9QT1JUKFBDSUVfTENfQ05UTDQsIHRtcCk7Cj4KPiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIG1kZWxheSgxMDApOwo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgbXNsZWVwKDEwMCk7Cj4KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8qIGxp
bmtjdGwgKi8KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBjaV9yZWFkX2NvbmZp
Z193b3JkKHJvb3QsIGJyaWRnZV9wb3MgKyBQQ0lfRVhQX0xOS0NUTCwgJnRtcDE2KTsKPiAtLQo+
IDIuMTcuMAo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KPiBkcmktZGV2ZWwgbWFpbGluZyBsaXN0Cj4gZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJp
LWRldmVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRy
aS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
