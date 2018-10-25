From: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix VM leaf walking
Date: Thu, 25 Oct 2018 16:01:09 +0000
Message-ID: <a21d8158-8cc8-d46e-49be-99a89e34adc6@amd.com>
References: <20181025143804.1698-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181025143804.1698-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <9A0D8213044A04498AB9ED73D0577482-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOC0xMC0yNSAxMDozOCBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOg0KPiBNYWtl
IHN1cmUgd2UgZG9uJ3QgdHJ5IHRvIGdvIGRvd24gZnVydGhlciBhZnRlciB0aGUgbGVhdmUgd2Fs
ayBhbHJlYWR5DQo+IGVuZGVkLiBUaGlzIGZpeGVzIGEgY3Jhc2ggd2l0aCBhIG5ldyBWTSB0ZXN0
Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+DQoNClJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdA
YW1kLmNvbT4NCg0KUmVnYXJkcywNCsKgIEZlbGl4DQoNCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDMgKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bS5jDQo+IGluZGV4IGRiMGNiZjhkMjE5ZC4uMzUyYjMwNDA5MDYwIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPiBAQCAtNTQyLDcgKzU0Miw4
IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV92bV9wdF9uZXh0X2xlYWYoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsDQo+ICAJCQkJICAgc3RydWN0IGFtZGdwdV92bV9wdF9jdXJzb3IgKmN1cnNvcikN
Cj4gIHsNCj4gIAlhbWRncHVfdm1fcHRfbmV4dChhZGV2LCBjdXJzb3IpOw0KPiAtCXdoaWxlIChh
bWRncHVfdm1fcHRfZGVzY2VuZGFudChhZGV2LCBjdXJzb3IpKTsNCj4gKwlpZiAoY3Vyc29yLT5w
Zm4gIT0gfjBsbCkNCj4gKwkJd2hpbGUgKGFtZGdwdV92bV9wdF9kZXNjZW5kYW50KGFkZXYsIGN1
cnNvcikpOw0KPiAgfQ0KPiAgDQo+ICAvKioNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
