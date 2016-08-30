From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 07/14] drm/amdgpu/si: fix the dce6 for si macro
Date: Wed, 31 Aug 2016 00:04:12 +0800
Message-ID: <20160830160411.GB10345@hr-amur2>
References: <1472557811-8015-1-git-send-email-ray.huang@amd.com>
 <1472557811-8015-8-git-send-email-ray.huang@amd.com>
 <MWHPR12MB169435C80C235E574E2D61FBF7E00@MWHPR12MB1694.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <MWHPR12MB169435C80C235E574E2D61FBF7E00-Gy0DoCVfaSW4WA4dJ5YXGAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

T24gVHVlLCBBdWcgMzAsIDIwMTYgYXQgMTA6MTc6NThQTSArMDgwMCwgRGV1Y2hlciwgQWxleGFu
ZGVyIHdyb3RlOgo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiA+IEZyb206IGFtZC1n
ZnggW21haWx0bzphbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnXSBPbiBCZWhh
bGYKPiA+IE9mIEh1YW5nIFJ1aQo+ID4gU2VudDogVHVlc2RheSwgQXVndXN0IDMwLCAyMDE2IDc6
NTAgQU0KPiA+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxl
eGFuZGVyCj4gPiBDYzogV2FuZywgS2VuOyBZdSwgSHVpOyBIdWFuZywgUmF5OyBIdWFuLCBBbHZp
bgo+ID4gU3ViamVjdDogW1BBVENIIDA3LzE0XSBkcm0vYW1kZ3B1L3NpOiBmaXggdGhlIGRjZTYg
Zm9yIHNpIG1hY3JvCj4gPiAKPiA+IENoYW5nZS1JZDogSTNlNWY0MjE1OGM1N2QxZWM3MjJmNzEz
YjEyOTE4OWJjNWY4MDJiMTEKPiA+IFNpZ25lZC1vZmYtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5n
QGFtZC5jb20+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYXNpY19y
ZWcvc2kvc2lkLmggfCA2ICsrKysrLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvaW5jbHVkZS9hc2ljX3JlZy9zaS9zaWQuaAo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2lu
Y2x1ZGUvYXNpY19yZWcvc2kvc2lkLmgKPiA+IGluZGV4IDk2MDkxOTkuLmNlZDAzOTAgMTAwNjQ0
Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYXNpY19yZWcvc2kvc2lkLmgK
PiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hc2ljX3JlZy9zaS9zaWQuaAo+
ID4gQEAgLTE5NjgsNyArMTk2OCwxMSBAQAo+ID4gICNkZWZpbmUgQU1ER1BVX01NX0lOREVYCQkg
ICAgICAgIDB4MDAwMAo+ID4gICNkZWZpbmUgQU1ER1BVX01NX0RBVEEJCSAgICAgICAgMHgwMDAx
Cj4gPiAKPiA+IC0jZGVmaW5lIEFTSUNfSVNfRENFNihhZGV2KSAoKGFkZXYtPmFzaWNfdHlwZSA9
PSBDSElQX1ZFUkRFKSkKPiA+ICsjZGVmaW5lIEFTSUNfSVNfRENFNihhZGV2KSAoKGFkZXYtPmFz
aWNfdHlwZSA9PSBDSElQX1ZFUkRFKSAgICB8fCBcCj4gPiArCQkJICAgIChhZGV2LT5hc2ljX3R5
cGUgPT0gQ0hJUF9UQUhJVEkpICAgfHwgXAo+ID4gKwkJCSAgICAoYWRldi0+YXNpY190eXBlID09
IENISVBfUElUQ0FJUk4pIHx8IFwKPiA+ICsJCQkgICAgKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQ
X09MQU5EKSkKPiA+ICsKPiAKPiBMZXQncyBqdXN0IGRyb3AgdGhpcyBtYWNybyBhbmQgY2hlY2sg
dGhlIGFzaWMgdHlwZXMgZXhwbGljaXRseS4KPiAKCk9LLCB3aWxsIHJlbW92ZSB0aGlzIG1hY3Jv
IGluIFYyLgoKVGhhbmtzLApSdWkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
