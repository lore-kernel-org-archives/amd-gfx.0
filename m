From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/5] drm/amdgpu: Support snooped PTE flag
Date: Fri, 9 Aug 2019 12:31:21 +0000
Message-ID: <88fad585-ad1b-bca9-7079-d79896def19c@amd.com>
References: <1565316926-19516-1-git-send-email-Oak.Zeng@amd.com>
 <1565316926-19516-4-git-send-email-Oak.Zeng@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1565316926-19516-4-git-send-email-Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <1EBDE40D59DCFA4A8BD6D1CE8116CC6B-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Keely,
 Sean" <Sean.Keely-5C7GfCeVMHo@public.gmane.org>

QW0gMDkuMDguMTkgdW0gMDQ6MTUgc2NocmllYiBaZW5nLCBPYWs6DQo+IFNldCBzbm9vcGVkIFBU
RSBmbGFnIGFjY29yZGluZyB0byBtYXBwaW5nIGZsYWcuIFdyaXRlIHJlcXVlc3QgdG8gYQ0KPiBw
YWdlIHdpdGggc25vb3BlZCBiaXQgc2V0LCB3aWxsIHNlbmQgb3V0IGludmFsaWRhdGUgcHJvYmUg
cmVxdWVzdA0KPiB0byBUQ0Mgb2YgdGhlIHJlbW90ZSBHUFUgd2hlcmUgdGhlIHZyYW0gcGFnZSBy
ZXNpZGVzLg0KPg0KPiBDaGFuZ2UtSWQ6IEk3OTlmNjhlYzdhNWExYWJmMzIwNzVmNWVmMzEwNTE2
NDFhMGIzNzM2DQo+IFNpZ25lZC1vZmYtYnk6IE9hayBaZW5nIDxPYWsuWmVuZ0BhbWQuY29tPg0K
PiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIHwgMyArKysN
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ21jX3Y5XzAuYw0KPiBpbmRleCBkNzA5OTAyLi44ZmFlYWQzIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jDQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMNCj4gQEAgLTU5OSw2ICs1OTksOSBAQCBz
dGF0aWMgdWludDY0X3QgZ21jX3Y5XzBfZ2V0X3ZtX3B0ZV9mbGFncyhzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwNCj4gICAJaWYgKGZsYWdzICYgQU1ER1BVX1ZNX1BBR0VfUFJUKQ0KPiAgIAkJ
cHRlX2ZsYWcgfD0gQU1ER1BVX1BURV9QUlQ7DQo+ICAgDQo+ICsJaWYgKGZsYWdzICYgQU1ER1BV
X1ZNX1BBR0VfSU5WQUxJREFURV9QUk9CRSkNCj4gKwkJcHRlX2ZsYWcgfD0gQU1ER1BVX1BURV9T
Tk9PUEVEOw0KPiArDQoNClN0aWxsIGEgTkFLLCB3ZSBhYnNvbHV0ZWx5IG5lZWQgYSBjaGVjayBo
ZXJlIHRoYXQgdGhpcyBpcyBvbmx5IHNldCB3aGVuIA0KdGhlIEJPIGlzIGluIFhHTUkuDQoNCkNo
cmlzdGlhbi4NCg0KPiAgIAlyZXR1cm4gcHRlX2ZsYWc7DQo+ICAgfQ0KPiAgIA0KDQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
