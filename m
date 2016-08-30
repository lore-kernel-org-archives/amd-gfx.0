From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 10/14] drm/amdgpu: add rv770_get_memory_type to set the
 GDDR5 flag
Date: Wed, 31 Aug 2016 00:07:25 +0800
Message-ID: <20160830160724.GC10345@hr-amur2>
References: <1472557811-8015-1-git-send-email-ray.huang@amd.com>
 <1472557811-8015-11-git-send-email-ray.huang@amd.com>
 <MWHPR12MB1694FA622ACA818EB655A084F7E00@MWHPR12MB1694.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <MWHPR12MB1694FA622ACA818EB655A084F7E00-Gy0DoCVfaSW4WA4dJ5YXGAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Huan, Alvin" <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Yu,
 Hui" <Hui.Yu-5C7GfCeVMHo@public.gmane.org>

T24gVHVlLCBBdWcgMzAsIDIwMTYgYXQgMTA6MjE6MjFQTSArMDgwMCwgRGV1Y2hlciwgQWxleGFu
ZGVyIHdyb3RlOgo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiA+IEZyb206IGFtZC1n
ZnggW21haWx0bzphbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnXSBPbiBCZWhh
bGYKPiA+IE9mIEh1YW5nIFJ1aQo+ID4gU2VudDogVHVlc2RheSwgQXVndXN0IDMwLCAyMDE2IDc6
NTAgQU0KPiA+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxl
eGFuZGVyCj4gPiBDYzogV2FuZywgS2VuOyBZdSwgSHVpOyBIdWFuZywgUmF5OyBIdWFuLCBBbHZp
bgo+ID4gU3ViamVjdDogW1BBVENIIDEwLzE0XSBkcm0vYW1kZ3B1OiBhZGQgcnY3NzBfZ2V0X21l
bW9yeV90eXBlIHRvIHNldAo+ID4gdGhlIEdERFI1IGZsYWcKPiA+IAo+ID4gQWRkIHJ2NzcwX2dl
dF9tZW1vcnlfdHlwZSB0byBzZXQgbWVtX2dkZHI1IGZsYWcsIGJlY2F1c2UgaXQgd2lsbCBiZQo+
ID4gdXNlZCBvbiB0aGUgd2hvbGUgc2kgZHBtIHBhcnQuCj4gPiAKPiA+IENoYW5nZS1JZDogSTYw
ZjdlZjM4Nzc1YzNiMjdlNDc1ZjM4ZjkzOTkwNTQ4M2ZiYjU2ZjUKPiA+IFNpZ25lZC1vZmYtYnk6
IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9zaV9kcG0uYyB8IDE2ICsrKysrKysrKysrKysrKysKPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvc2lfZHBtLmMKPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc2lfZHBtLmMKPiA+IGluZGV4IDVmMWU1ZmUuLjU2M2FlZWEgMTAwNjQ0Cj4gPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0uYwo+ID4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvc2lfZHBtLmMKPiA+IEBAIC02NDMzLDggKzY0MzMsMjQgQEAgc3RhdGlj
IHZvaWQgc2lfc2V0X3BjaWVfbGFuZV93aWR0aF9pbl9zbWMoc3RydWN0Cj4gPiBhbWRncHVfZGV2
aWNlICphZGV2LAo+ID4gIAl9Cj4gPiAgfQo+ID4gCj4gPiArdm9pZCBydjc3MF9nZXRfbWVtb3J5
X3R5cGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gCj4gYWRldi0+bWMudnJhbV90eXBl
IHNob3VsZCBiZSBzZXQgaW4gdGhlIGdtYyBtb2R1bGUuICBVc2UgdGhhdCBpbnN0ZWFkIG9mIHBp
LT5tZW1fZ2RkcjUuICBTZWUgY2lfZHBtLmMgZm9yIGV4YW1wbGUuCj4gCgpTbyBzaG91bGQgSSB1
c2UgImFkZXYtPm1jLnZyYW1fdHlwZSA9PSBBTURHUFVfVlJBTV9UWVBFX0dERFI1IiBjaGVjawpp
bnN0ZWFkPyBJIHdpbGwgdXBkYXRlIGl0IGluIFYyLgoKVGhhbmtzLApSdWkKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
