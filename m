From: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v3 0/3] Add support for XGMI hive reset
Date: Wed, 28 Nov 2018 15:07:09 +0000
Message-ID: <f68ac17d-657d-81fb-42a5-54dfb8cbbd35@amd.com>
References: <1543343848-11249-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1543343848-11249-1-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <CDA2133EEF8B6F4FA0C48A69C21761A8-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

UGluZy4uLg0KDQpBbmRyZXkNCg0KDQpPbiAxMS8yNy8yMDE4IDAxOjM3IFBNLCBBbmRyZXkgR3Jv
ZHpvdnNreSB3cm90ZToNCj4gVGhpcyBzZXQgb2YgcGF0Y2hlcyBhZGRzIHN1cHBvcnQgdG8gcmVz
ZXQgZW50aXJlIFhHTUkgaGl2ZQ0KPiB3aGVuIHJlc2V0IGlzIHJlcXVpcmVkLg0KPg0KPiBQYXRj
aGVzIDEtMiByZWZhY3RvcmluZyBhIGJpdCB0aGUgWEdNSSBpbmZyYXN0cnVjdHVyZSBhcw0KPiBw
cmVwYXJhdG9uIGZvciB0aGUgYWN0dWFsIGhpdmUgcmVzZXQgY2hhbmdlLg0KPg0KPiBQYXRjaCA1
IGlzIEdQVSByZXNldC9yZWNvdmVyeSByZWZhY3RvcmVkIHRvIHN1cHBvcnQgWEdNSQ0KPiBoaXZl
IHJlc2V0Lg0KPg0KPiBBbmRyZXkgR3JvZHpvdnNreSAoMyk6DQo+ICAgIGRybS9hbWRncHU6IFJl
ZmFjdG9yIGFtZGdwdV94Z21pX2FkZF9kZXZpY2UgdjMNCj4gICAgZHJtL2FtZGdwdTogRXhwb3Nl
IGhpdmUgYWRldiBsaXN0IGFuZCB4Z21pX211dGV4IHYzDQo+ICAgIGRybS9hbWRncHU6IFJlZmFj
dG9yIEdQVSByZXNldCBmb3IgWEdNSSBoaXZlIGNhc2UgdjMNCj4NCj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHUuaCAgICAgICAgfCAgIDkgKy0NCj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAzNzYgKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfeGdtaS5jICAg
fCAgNjggKysrLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3hnbWku
aCAgIHwgIDM5ICsrKw0KPiAgIDQgZmlsZXMgY2hhbmdlZCwgMzQzIGluc2VydGlvbnMoKyksIDE0
OSBkZWxldGlvbnMoLSkNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3hnbWkuaA0KPg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
