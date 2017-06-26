From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix solid screen and hard hang when 2k + 4k
 display connected with DP
Date: Mon, 26 Jun 2017 09:18:52 +0200
Message-ID: <24e624a1-3f79-752a-ef12-adf5c1b407a2@vodafone.de>
References: <1498460629-9481-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1498460629-9481-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Sonny Jiang <sonny.jiang-5C7GfCeVMHo@public.gmane.org>, Alvin Huan <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, Xiaojie Yuan <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>, Joe Qiao <Joe2.Qiao-5C7GfCeVMHo@public.gmane.org>, Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>

QW0gMjYuMDYuMjAxNyB1bSAwOTowMyBzY2hyaWViIEh1YW5nIFJ1aToKPiBTaWduZWQtb2ZmLWJ5
OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgo+IENjOiBYaWFvamllIFl1YW4gPFhpYW9q
aWUuWXVhbkBhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3BzcC5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3BzcC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCj4gaW5k
ZXggNWJlZDQ4My4uNjBkMDQ1NSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcHNwLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcHNwLmMKPiBAQCAtMTMwLDcgKzEzMCw3IEBAIHBzcF9jbWRfc3VibWl0X2J1ZihzdHJ1Y3Qg
cHNwX2NvbnRleHQgKnBzcCwKPiAgIAlyZXQgPSBwc3BfY21kX3N1Ym1pdChwc3AsIHVjb2RlLCBj
bWRfYnVmX21jX2FkZHIsCj4gICAJCQkgICAgIGZlbmNlX21jX2FkZHIsIGluZGV4KTsKPiAgIAo+
IC0Jd2hpbGUgKCooKHVuc2lnbmVkIGludCAqKXBzcC0+ZmVuY2VfYnVmKSAhPSBpbmRleCkgewo+
ICsJd2hpbGUgKCooKHVuc2lnbmVkIGludCAqKXBzcC0+ZmVuY2VfYnVmKSA8IGluZGV4KSB7CgpU
aGF0IGlzIHN0aWxsIGhvcnJpYmxlIGluY29ycmVjdC4gQXQgYmFyZSBtaW5pbXVtIHlvdSBuZWVk
IHRvIHVzZSB0aGUgClJFQURfT05DRSgpIG1hY3JvIGhlcmUuCgpCdXQgaXQgd291bGQgYmUgZXZl
biBiZXR0ZXIgdG8gY29tcGxldGVseSBkcm9wIHRoaXMgYW5kIHVzZSB0aGUgZmVuY2UgCmltcGxl
bWVudGF0aW9uIGluIGFtZGdwdV9mZW5jZS5jIGFzIHdlbGwuCgpDaHJpc3RpYW4uCgo+ICAgCQlt
c2xlZXAoMSk7Cj4gICAJfQo+ICAgCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
