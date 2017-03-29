From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: CPU mapping of split VRAM buffers
Date: Wed, 29 Mar 2017 15:36:41 +0000
Message-ID: <BN6PR12MB1652DD0CE69D4972798E40DEF7350@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1490792146-2218-1-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490792146-2218-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?utf-8?B?J0NocmlzdGlhbiBLw7ZuaWcn?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IFttYWlsdG86YW1k
LWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZ10gT24gQmVoYWxmDQo+IE9mIENocmlz
dGlhbiBLw7ZuaWcNCj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAyOSwgMjAxNyA4OjU2IEFNDQo+
IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogbWFyYWVvQGdtYWlsLmNv
bQ0KPiBTdWJqZWN0OiBDUFUgbWFwcGluZyBvZiBzcGxpdCBWUkFNIGJ1ZmZlcnMNCj4gDQo+IEhp
IGd1eXMsDQo+IA0KPiB0aGlzIHNldCBpbXBsZW1lbnRzIENQVSBtYXBwaW5nIG9mIHNwbGl0IFZS
QU0gYnVmZmVycyBhbmQgY291bGQNCj4gaGVscCB3aXRoIHNvbWUgcGVyZm9ybWFuY2UgaXNzdWVz
IHJlZ2FyZGluZyB0aGlzLg0KPiANCj4gUGxlYXNlIHJldmlldyBhbmQvb3IgY29tbWVudCwNCg0K
U2hvdWxkIHByb2JhYmx5IHJlc2VuZCB0aGVtIHRvIGRyaS1kZXZlbCBhcyB3ZWxsIHNpbmNlIHRo
ZXkgdG91Y2ggY29yZSB0dG0uDQoNCkFsZXgNCg0KPiBDaHJpc3RpYW4uDQo+IA0KPiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBhbWQtZ2Z4IG1haWxp
bmcgbGlzdA0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngNCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
