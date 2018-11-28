From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm: radeon: fix overflow on 32bit systems
Date: Wed, 28 Nov 2018 09:14:01 +0100
Message-ID: <9bc7c444-5567-565c-79cb-3b076ca7dd68@gmail.com>
References: <HK0PR01MB21638498C7DAF86591D36AB0ADD00@HK0PR01MB2163.apcprd01.prod.exchangelabs.com>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <HK0PR01MB21638498C7DAF86591D36AB0ADD00@HK0PR01MB2163.apcprd01.prod.exchangelabs.com>
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
To: Yang Xiao <YangX92@hotmail.com>, "alexander.deucher@amd.com" <alexander.deucher@amd.com>, "christian.koenig@amd.com" <christian.koenig@amd.com>, "David1.Zhou@amd.com" <David1.Zhou@amd.com>, "airlied@linux.ie" <airlied@linux.ie>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

QW0gMjcuMTEuMTggdW0gMTI6NTAgc2NocmllYiBZYW5nIFhpYW86Cj4gRnJvbTogWW91bmcgWGlh
byA8WWFuZ1g5MkBob3RtYWlsLmNvbT4KPgo+IHRoZSB0eXBlIG1lbS0+c3RhcnQgaXMgdW5zaWdu
ZWQgbG9uZywgc28gdGhpcyBjYW4gb3ZlcmZsb3cgb24KPiAzMmJpdCBzeXN0ZW0sIHNpbmNlIHRo
ZSB0eXBlIGFkZHIgaXMgdWludDY0X3QuCj4KPiBTaWduZWQtb2ZmLWJ5OiBZb3VuZyBYaWFvIDxZ
YW5nWDkyQGhvdG1haWwuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Jh
ZGVvbl92bS5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25f
dm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3ZtLmMKPiBpbmRleCA3ZjFhOWM3
Li41MTU1OWQ4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3Zt
LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl92bS5jCj4gQEAgLTk0Niw3
ICs5NDYsNyBAQCBpbnQgcmFkZW9uX3ZtX2JvX3VwZGF0ZShzdHJ1Y3QgcmFkZW9uX2RldmljZSAq
cmRldiwKPiAgIAkJYm9fdmEtPmZsYWdzICY9IH5SQURFT05fVk1fUEFHRV9XUklURUFCTEU7Cj4g
ICAKPiAgIAlpZiAobWVtKSB7Cj4gLQkJYWRkciA9IG1lbS0+c3RhcnQgPDwgUEFHRV9TSElGVDsK
PiArCQlhZGRyID0gKHU2NCltZW0tPnN0YXJ0IDw8IFBBR0VfU0hJRlQ7Cj4gICAJCWlmIChtZW0t
Pm1lbV90eXBlICE9IFRUTV9QTF9TWVNURU0pIHsKPiAgIAkJCWJvX3ZhLT5mbGFncyB8PSBSQURF
T05fVk1fUEFHRV9WQUxJRDsKPiAgIAkJfQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vZHJpLWRldmVsCg==
