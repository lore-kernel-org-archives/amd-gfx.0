From: Kevin Wang <kevwa-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2] drm/amd/powerplay:clean up the residual mutex for
 smu_hw_init
Date: Wed, 26 Jun 2019 11:40:31 +0000
Message-ID: <7b8da7a5-4f72-90f5-8558-f06635475fc8@amd.com>
References: <1561448595-32319-1-git-send-email-Prike.Liang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1561448595-32319-1-git-send-email-Prike.Liang-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <C379D156B010B644843834C9E01EBA0A-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Liang, Prike" <Prike.Liang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>

UmV2aWV3ZWQtYnk6IEtldmluIFdhbmcgPGtldmluMS53YW5nQGFtZC5jb20+DQoNCg0KT24gNi8y
NS8xOSAzOjQzIFBNLCBQcmlrZSBMaWFuZyB3cm90ZToNCj4gVGhlIG11dGV4IGZvciBwcm9jdGlu
ZyBTTVUgZHVyaW5nIGh3X2luaXQgd2FzIHJlbW92ZWQgYXMgc3lzdGVtDQo+IHdpbGwgYmUgZGVh
ZGxvY2sgd2hlbiBzbXVfcG9wdWxhdGVfdW1kX3N0YXRlX2NsayB0cnkgZ2V0IFNNVSBtdXRleC4N
Cj4gVGhlcmVmb3JlIG5lZWQgcmVtb3ZlIHRoZSByZXNpZHVhbCBtdXRleCBmcm9tIGZhaWxlZCBw
YXRoLg0KPg0KPiBDaGFuZ2UtSWQ6IElkODAxOWMwMWI5NDk2YzA2N2VmZGE0ODE3YTQ2OTgzZTRk
YTNiNmU0DQo+IFNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29t
Pg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMg
fCAxIC0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jDQo+IGluZGV4IGY2MWVjYmYuLmZlODNj
NWUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9z
bXUuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMN
Cj4gQEAgLTEwNDQsNyArMTA0NCw2IEBAIHN0YXRpYyBpbnQgc211X2h3X2luaXQodm9pZCAqaGFu
ZGxlKQ0KPiAgIAlyZXR1cm4gMDsNCj4gICANCj4gICBmYWlsZWQ6DQo+IC0JbXV0ZXhfdW5sb2Nr
KCZzbXUtPm11dGV4KTsNCj4gICAJcmV0dXJuIHJldDsNCj4gICB9DQo+ICAgDQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
