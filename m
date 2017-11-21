From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] amdgpu: Set adev->vcn.irq.num_types for VCN
Date: Tue, 21 Nov 2017 19:36:33 +0100
Message-ID: <ea695920-65d1-aefe-a603-4c935c70079d@gmail.com>
References: <20171121172847.7971-1-michel@daenzer.net>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171121172847.7971-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>

QW0gMjEuMTEuMjAxNyB1bSAxODoyOCBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IEZyb206IE1p
Y2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgo+Cj4gV2Ugd2VyZSBzZXR0aW5n
IGFkZXYtPnV2ZC5pcnEubnVtX3R5cGVzIGluc3RlYWQuCj4KPiBGaXhlczogOWIyNTcxMTZlNzg0
ICgiZHJtL2FtZGdwdTogYWRkIHZjbiBlbmMgaXJxIHN1cHBvcnQiKQo+IFNpZ25lZC1vZmYtYnk6
IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgoKU3ViamVjdCBsaW5lIGlz
IHdyb25nIDopIEFwYXJ0IGZyb20gdGhhdCBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyAK
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4uCgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvdmNuX3YxXzAuYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3Zjbl92MV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjFfMC5j
Cj4gaW5kZXggMWViNGQ3OWQ2ZTMwLi4wNDUwYWM1YmE2YjYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3Zjbl92MV8wLmMKPiBAQCAtMTE3NSw3ICsxMTc1LDcgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBhbWRncHVfaXJxX3NyY19mdW5jcyB2Y25fdjFfMF9pcnFfZnVuY3MgPSB7Cj4gICAK
PiAgIHN0YXRpYyB2b2lkIHZjbl92MV8wX3NldF9pcnFfZnVuY3Moc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpCj4gICB7Cj4gLQlhZGV2LT51dmQuaXJxLm51bV90eXBlcyA9IGFkZXYtPnZjbi5u
dW1fZW5jX3JpbmdzICsgMTsKPiArCWFkZXYtPnZjbi5pcnEubnVtX3R5cGVzID0gYWRldi0+dmNu
Lm51bV9lbmNfcmluZ3MgKyAxOwo+ICAgCWFkZXYtPnZjbi5pcnEuZnVuY3MgPSAmdmNuX3YxXzBf
aXJxX2Z1bmNzOwo+ICAgfQo+ICAgCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
