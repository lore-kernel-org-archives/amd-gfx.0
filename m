From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 0/2] Some changes to fix performance drop on Vega10
Date: Fri, 20 Oct 2017 19:05:03 +0000
Message-ID: <CY4PR12MB16539CB2C897372E837868F4F7430@CY4PR12MB1653.namprd12.prod.outlook.com>
References: <1508440499-19321-1-git-send-email-JinHuiEric.Huang@amd.com>
 <18695bbf-f6c0-9d7b-4c16-20b7ba7a0c23@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <18695bbf-f6c0-9d7b-4c16-20b7ba7a0c23-5C7GfCeVMHo@public.gmane.org>
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
To: "Huang, JinHuiEric" <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IFttYWlsdG86YW1k
LWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZ10gT24gQmVoYWxmDQo+IE9mIEVyaWMg
SHVhbmcNCj4gU2VudDogRnJpZGF5LCBPY3RvYmVyIDIwLCAyMDE3IDI6MTAgUE0NCj4gVG86IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC8yXSBT
b21lIGNoYW5nZXMgdG8gZml4IHBlcmZvcm1hbmNlIGRyb3Agb24gVmVnYTEwDQo+IA0KPiBQaW5n
Lg0KDQpTZXJpZXMgaXM6DQpBY2tlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPg0KDQo+IA0KPiANCj4gT24gMjAxNy0xMC0xOSAwMzoxNCBQTSwgRXJpYyBIdWFu
ZyB3cm90ZToNCj4gPiBFcmljIEh1YW5nICgyKToNCj4gPiAgICBkcm0vYW1kL3Bvd2VycGxheTog
YWRkIG9uZSBzbWMgbWVzc2FnZSBmb3IgVmVnYTEwDQo+ID4gICAgZHJtL2FtZC9wb3dlcnBsYXk6
IGZpeCBwZXJmb3JtYW5jZSBkcm9wIG9uIFZlZ2ExMA0KPiA+DQo+ID4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMTBfaHdtZ3IuYyB8IDYgKysrKysrDQo+ID4gICBk
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvdmVnYTEwX3Bwc21jLmggICB8IDMgKyst
DQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiA+DQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xw0KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zw0KPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
