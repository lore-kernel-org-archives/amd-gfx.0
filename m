From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PART1 PATCH v4 7/8] drm/amdgpu: add get clockgating_state
 method for uvd v5&v6
Date: Mon, 9 Jan 2017 22:46:15 +0800
Message-ID: <20170109144614.GA3743@hr-amur2>
References: <1483930814-23529-1-git-send-email-ray.huang@amd.com>
 <1483930814-23529-2-git-send-email-ray.huang@amd.com>
 <364cc068-e347-5f77-b4ff-414f8e8b4fdb@amd.com>
 <CY4PR12MB176846FDA72EF232B6825609F7640@CY4PR12MB1768.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CY4PR12MB176846FDA72EF232B6825609F7640-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Fu, Ping" <Ping.Fu-5C7GfCeVMHo@public.gmane.org>, "Mao, David" <David.Mao-5C7GfCeVMHo@public.gmane.org>, "Kuehling,
 Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

T24gTW9uLCBKYW4gMDksIDIwMTcgYXQgMDc6Mjk6MDBQTSArMDgwMCwgU3REZW5pcywgVG9tIHdy
b3RlOgo+IFl1cCBpdCdzIGhlbGQgYnkgYm90aCBhbWRncHVfZHBtX2VuYWJsZV91dmQoKSBhbmQg
YW1kZ3B1X2RwbV9lbmFibGVfdmNlKCkKPiAKPiBUb20KPiAKCjxzbmlwPgoKPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjVfMC5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC8KPiBhbWRncHUvdXZkX3Y1XzAuYwo+ID4gaW5kZXggMDNhMzVkOS4uZTY0N2QzZSAx
MDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92NV8wLmMKPiA+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92NV8wLmMKPiA+IEBAIC03ODEs
MTYgKzc4MSw0OCBAQCBzdGF0aWMgaW50IHV2ZF92NV8wX3NldF9wb3dlcmdhdGluZ19zdGF0ZSh2
b2lkICpoYW5kbGUsCj4gPiAgICAgICAgICogdGhlIHNtYyBhbmQgdGhlIGh3IGJsb2Nrcwo+ID4g
ICAgICAgICAqLwo+ID4gICAgICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVj
dCBhbWRncHVfZGV2aWNlICopaGFuZGxlOwo+ID4gKyAgICAgaW50IHJldCA9IDA7Cj4gPiAgCj4g
PiAgICAgICAgaWYgKCEoYWRldi0+cGdfZmxhZ3MgJiBBTURfUEdfU1VQUE9SVF9VVkQpKQo+ID4g
ICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4gPiAgCj4gPiArICAgICBtdXRleF9sb2NrKCZhZGV2
LT5wbS5tdXRleCk7Cj4gCj4gTWlnaHQgYmUgdGhhdCBJJ20gd3JvbmcsIGJ1dCBkaWRuJ3QgVG9t
IHNhaWQgdGhlIG11dGV4IGlzIHRha2VuIGFueXdheQo+IHdoZW4gdGhpcyBmdW5jdGlvbiBpcyBj
YWxsZWQ/Cj4gCj4gSWYgdGhhdCdzIHRydWUgd2Ugd291bGQgY2VydGFpbmx5IHJ1biBpbnRvIHBy
b2JsZW0gd2hlbiB3ZSB0cnkgdG8KPiBhY3F1aXJlIGl0IGFnYWluLgo+IAoKT0ssIEkgc2VlLiBB
Y3R1YWxseSwgcG0ubXV0ZXggaXMgYWxyZWFkeSBoZWxkIG9uIHVwcGVyIGxheWVyIGNhbGwKKGFt
ZGdwdV9kcG1fZW5hYmxlX3V2ZCkuIFNvIHdlIHNob3VsZCBub3QgaG9sZCBpdCBhZ2FpbiBoZXJl
LgoKPiA+ICsKPiA+ICtzdGF0aWMgdm9pZCB1dmRfdjVfMF9nZXRfY2xvY2tnYXRpbmdfc3RhdGUo
dm9pZCAqaGFuZGxlLCB1MzIgKmZsYWdzKQo+ID4gK3sKPiA+ICsgICAgIHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOwo+ID4gKyAgICAg
aW50IGRhdGE7Cj4gPiArCj4gPiArICAgICBtdXRleF9sb2NrKCZhZGV2LT5wbS5tdXRleCk7Cj4g
PiArCgpXZSBqdXN0IG5lZWQga2VlcCBwbS5tdXRleCBoZXJlIGluIHNldF9jbG9ja2dhdGluZ19z
dGF0ZSwgdGhhdCdzIGVub3VnaC4KCkNocmlzdGlhbiwgVG9tLCBhbSBJIHJpZ2h0PwoKVGhhbmtz
LApSdWkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
