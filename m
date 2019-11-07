From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/4] Revert "drm/amdgpu: dont schedule jobs while in reset"
Date: Thu, 7 Nov 2019 09:24:25 +0000
Message-ID: <f04113d4-03af-bdfa-3c2c-6021a74df1f3@amd.com>
References: <1573062672-23698-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1573062672-23698-1-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <C03DD884F18EFD4A8B29FE911B1A7764-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "S,
 Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>

QW0gMDYuMTEuMTkgdW0gMTg6NTEgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToNCj4gVGhpcyBy
ZXZlcnRzIGNvbW1pdCAzY2RmOWJkMDA4OTcyM2M0NjhkNWY2MjQwZTU0ZDFhZmE1MmU5YTA0Lg0K
Pg0KPiBXZSB3aWxsIGRvIGEgcHJvcGVyIGZpeCBpbiBuZXh0IHBhdGNoLg0KPg0KPiBTaWduZWQt
b2ZmLWJ5OiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lAYW1kLmNvbT4NCg0K
VGhlIG9yZGVyIG9mIHRoaXMgb25lIGFuZCBwYXRjaCAjMiBuZWVkcyB0byBiZSBzd2FwcGVkLCBv
ciBvdGhlcndpc2Ugd2UgDQpoYXZlIHRoZSBidWcgaW4gYmV0d2VlbiB0aG9zZSB0d28gY29tbWl0
cyBhZ2Fpbi4NCg0KQXBhcnQgZnJvbSB0aGF0IHRoZSBzZXJpZXMgaXMgUmV2aWV3ZWQtYnk6IENo
cmlzdGlhbiBLw7ZuaWcgDQo8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPi4NCg0KVGhhbmtzLA0K
Q2hyaXN0aWFuLg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9jdHguYyB8IDUgKy0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDQg
ZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfY3R4LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMN
Cj4gaW5kZXggMmNkYWYzYi4uNjYxNGQ4YSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9jdHguYw0KPiBAQCAtNjA0LDExICs2MDQsOCBAQCB2b2lkIGFtZGdwdV9jdHhf
bWdyX2VudGl0eV9maW5pKHN0cnVjdCBhbWRncHVfY3R4X21nciAqbWdyKQ0KPiAgIAkJCWNvbnRp
bnVlOw0KPiAgIAkJfQ0KPiAgIA0KPiAtCQlmb3IgKGkgPSAwOyBpIDwgbnVtX2VudGl0aWVzOyBp
KyspIHsNCj4gLQkJCW11dGV4X2xvY2soJmN0eC0+YWRldi0+bG9ja19yZXNldCk7DQo+ICsJCWZv
ciAoaSA9IDA7IGkgPCBudW1fZW50aXRpZXM7IGkrKykNCj4gICAJCQlkcm1fc2NoZWRfZW50aXR5
X2ZpbmkoJmN0eC0+ZW50aXRpZXNbMF1baV0uZW50aXR5KTsNCj4gLQkJCW11dGV4X3VubG9jaygm
Y3R4LT5hZGV2LT5sb2NrX3Jlc2V0KTsNCj4gLQkJfQ0KPiAgIAl9DQo+ICAgfQ0KPiAgIA0KDQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
