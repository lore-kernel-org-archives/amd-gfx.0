From: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Fix 64-bit division for 32-bit builds
Date: Wed, 19 Dec 2018 21:17:07 +0000
Message-ID: <7e157e3b-ef6c-180f-24ad-a1d503527952@amd.com>
References: <1545251294-28136-1-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1545251294-28136-1-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <4173486F9A9B20499324BE1F1F4B3676-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Chalmers, Kenneth" <Ken.Chalmers-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOC0xMi0xOSAzOjI4IHAubS4sIHN1bnBlbmcubGlAYW1kLmNvbSB3cm90ZToNCj4gRnJv
bTogS2VuIENoYWxtZXJzIDxrZW4uY2hhbG1lcnNAYW1kLmNvbT4NCj4gDQo+IFtXaHldDQo+IDMy
LWJpdCBidWlsZHMgYnJlYWsgd2hlbiBkb2luZyA2NC1iaXQgZGl2aXNpb24gZGlyZWN0bHkuDQo+
IA0KPiBbSG93XQ0KPiBVc2UgdGhlIGRpdl91NjQoKSBmdW5jdGlvbiBpbnN0ZWFkIHRvIHBlcmZv
cm0gdGhlIGRpdmlzaW9uLg0KPiANCj4gRml4ZXM6IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL2FyY2hpdmVzL2RyaS1kZXZlbC8yMDE4LURlY2VtYmVyLzIwMTAwOC5odG1sDQo+IFNpZ25l
ZC1vZmYtYnk6IEtlbiBDaGFsbWVycyA8a2VuLmNoYWxtZXJzQGFtZC5jb20+DQo+IFJldmlld2Vk
LWJ5OiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEhhcnJ5IFdl
bnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPg0KDQpIYXJyeQ0KDQo+IC0tLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTgwL2RjZTgwX3RpbWluZ19nZW5lcmF0b3Iu
YyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2U4
MC9kY2U4MF90aW1pbmdfZ2VuZXJhdG9yLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvZGNlODAvZGNlODBfdGltaW5nX2dlbmVyYXRvci5jDQo+IGluZGV4IDVjNjI5YWUuLjhiNWNl
NTUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2U4MC9k
Y2U4MF90aW1pbmdfZ2VuZXJhdG9yLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2RjZTgwL2RjZTgwX3RpbWluZ19nZW5lcmF0b3IuYw0KPiBAQCAtOTQsNyArOTQsNyBA
QCBzdGF0aWMgdm9pZCBwcm9ncmFtX3BpeF9kdXIoc3RydWN0IHRpbWluZ19nZW5lcmF0b3IgKnRn
LCB1aW50MzJfdCBwaXhfY2xrXzEwMGh6KQ0KPiAgCWlmIChwaXhfY2xrXzEwMGh6ID09IDApDQo+
ICAJCXJldHVybjsNCj4gIA0KPiAtCXBpeF9kdXIgPSAxMDAwMDAwMDAwMHVsbCAvIHBpeF9jbGtf
MTAwaHo7DQo+ICsJcGl4X2R1ciA9IGRpdl91NjQoMTAwMDAwMDAwMDB1bGwsIHBpeF9jbGtfMTAw
aHopOw0KPiAgDQo+ICAJc2V0X3JlZ19maWVsZF92YWx1ZSgNCj4gIAkJdmFsdWUsDQo+IA0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
