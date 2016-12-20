From: "Yu, Xiangliang" <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 21/23] drm/amdgpu: change golden register program sequence
 of virtualization
Date: Tue, 20 Dec 2016 06:09:58 +0000
Message-ID: <CY4PR12MB17013C9CFD61372FC7375D45EB900@CY4PR12MB1701.namprd12.prod.outlook.com>
References: <1481991405-30422-1-git-send-email-Xiangliang.Yu@amd.com>
 <1481991405-30422-22-git-send-email-Xiangliang.Yu@amd.com>,
 <CADnq5_PqscSCAOGn+suNGkoUQdF5Z7O69wrL_CvH27hfKE4b0A@mail.gmail.com>
 <BY2PR12MB005449FC3CC2D91B41B3487884900@BY2PR12MB0054.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1678306192=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BY2PR12MB005449FC3CC2D91B41B3487884900-K//h7OWB4q7GdVlgMuSljQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Min, Frank" <Frank.Min-5C7GfCeVMHo@public.gmane.org>, "dl.SRDC_SW_GPUVirtualization" <dl.SRDC_SW_GPUVirtualization-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1678306192==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB17013C9CFD61372FC7375D45EB900CY4PR12MB1701namp_"

--_000_CY4PR12MB17013C9CFD61372FC7375D45EB900CY4PR12MB1701namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

VGhhbmsgbW9ua6GvcyBjb21tZW50cy4NCg0KDQpGcm9tOiBMaXUsIE1vbmsNClNlbnQ6IFR1ZXNk
YXksIERlY2VtYmVyIDIwLCAyMDE2IDEyOjA5IFBNDQpUbzogQWxleCBEZXVjaGVyIDxhbGV4ZGV1
Y2hlckBnbWFpbC5jb20+OyBZdSwgWGlhbmdsaWFuZyA8WGlhbmdsaWFuZy5ZdUBhbWQuY29tPg0K
Q2M6IGFtZC1nZnggbGlzdCA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+OyBkbC5TUkRD
X1NXX0dQVVZpcnR1YWxpemF0aW9uIDxkbC5TUkRDX1NXX0dQVVZpcnR1YWxpemF0aW9uQGFtZC5j
b20+OyBNaW4sIEZyYW5rIDxGcmFuay5NaW5AYW1kLmNvbT4NClN1YmplY3Q6ILTwuLQ6IFtQQVRD
SCAyMS8yM10gZHJtL2FtZGdwdTogY2hhbmdlIGdvbGRlbiByZWdpc3RlciBwcm9ncmFtIHNlcXVl
bmNlIG9mIHZpcnR1YWxpemF0aW9uDQoNCg0KSGkgQWxleA0KDQoNCg0KSSBhZ3JlZSB3aXRoIHlv
dSB0aGF0IHRoaXMgcGF0Y2gncyBHT0xERU4gc2V0dGluZyBwcm9ncmFtbWluZyBzaG91bGQgYmUg
cHV0IGluIFZJLkMsIGJ1dCBJIGZvdW5kIGEgaGFyZHdhcmUgaXNzdWUgOg0KDQoNCg0Kb3JpZ2lu
YWwgbGludXggbG9naWMgaXMgdGhhdCB3ZSBzZXQgZ29sZGVuIHNldHRpbmcgcmVnaXN0ZXJzIHNl
cGFyYXRlbHkgd2l0aGluIGVhY2ggSVAncyBodyBpbml0IHJvdXRpbmUsIGJ1dCBmb3IgVE9OR0Eg
VkYsIGl0IGlzIHJlYWxseSBzdHJhbmdlIHRoYXQgd2UgbXVzdCBzZXQgYWxsIEdPTERFTiBzZXR0
aW5nIHZhbHVlIHRvIGNoaXAgaW4gb25lIHNob290IChtZWFucyB3ZSB1c2Ugb25lIHJvdXRpbmUg
dG8gcHJvZ3JhbWluZyBhbGwgSVAncyBnb2xkZW4gc2V0dGluZyB0byByZWdpc3RlcnMpLCBvcnRo
ZXJ3aXNlIHdlIGZvdW5kIFRPTkdBIHZmICBqdXN0IGZhaWxlZCBpbiBSSU5HIFRFU1QuDQoNCg0K
DQphbmQgSSBhZG1pdCBJIGRvbid0IGtub3cgd2h5IChJIGNoZWNrZWQgd2luZG93cyBDQUlMIGNv
ZGUsIGl0IGlzIGFsc28gc2V0IGFsbCBnb2xkZW4gc2V0dGluZyByZWdpc3RlcnMgaW4gb25lIHJv
dXRpbmUpDQoNCg0KDQpCUiBNb25rDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
DQq3orz+yMs6IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPG1haWx0bzphbGV4
ZGV1Y2hlckBnbWFpbC5jb20+Pg0Kt6LLzcqxvOQ6IDIwMTbE6jEy1MIyMMjVIDc6Mzc6MDYNCsrV
vP7IyzogWXUsIFhpYW5nbGlhbmcNCrOty806IGFtZC1nZnggbGlzdDsgZGwuU1JEQ19TV19HUFVW
aXJ0dWFsaXphdGlvbjsgTWluLCBGcmFuazsgTGl1LCBNb25rDQrW98ziOiBSZTogW1BBVENIIDIx
LzIzXSBkcm0vYW1kZ3B1OiBjaGFuZ2UgZ29sZGVuIHJlZ2lzdGVyIHByb2dyYW0gc2VxdWVuY2Ug
b2YgdmlydHVhbGl6YXRpb24NCg0KT24gU2F0LCBEZWMgMTcsIDIwMTYgYXQgMTE6MTYgQU0sIFhp
YW5nbGlhbmcgWXUgPFhpYW5nbGlhbmcuWXVAYW1kLmNvbTxtYWlsdG86WGlhbmdsaWFuZy5ZdUBh
bWQuY29tPj4gd3JvdGU6DQo+IEdQVSB2aXJ0dWFsaXphdGlvbiBoYXMgZGlmZmVyZW50IHNlcXVl
bmNlIGZyb20gbm9ybWFsLCBjaGFuZ2UgaXQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEZyYW5rIE1p
biA8RnJhbmsuTWluQGFtZC5jb208bWFpbHRvOkZyYW5rLk1pbkBhbWQuY29tPj4NCj4gU2lnbmVk
LW9mZi1ieTogTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5jb208bWFpbHRvOk1vbmsuTGl1QGFtZC5j
b20+Pg0KPiBTaWduZWQtb2ZmLWJ5OiBYaWFuZ2xpYW5nIFl1IDxYaWFuZ2xpYW5nLll1QGFtZC5j
b208bWFpbHRvOlhpYW5nbGlhbmcuWXVAYW1kLmNvbT4+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuaCB8ICAgMiArDQo+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS92aS5jICAgICAgICAgIHwgICA2ICsNCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQv
bXhncHUvbXhncHVfdmkuYyAgICAgfCAyNjcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAyNzUgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuaCBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0LmgNCj4gaW5kZXggZWIyOTA1ZS4uZTc4MWM5YyAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuaA0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5oDQo+IEBAIC04
NCw0ICs4NCw2IEBAIGludCBhbWRncHVfcHV0X2dwdShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dik7DQo+ICAvKiBhY2Nlc3MgdmYgcmVnaXN0ZXJzICovDQo+ICB1aW50MzJfdCBhbWRncHVfa2lx
X3JyZWcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IHJlZyk7DQo+ICB2b2lk
IGFtZGdwdV9raXFfd3JlZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3QgcmVn
LCB1aW50MzJfdCB2KTsNCj4gKw0KPiArdm9pZCBhbWRncHVfeGdwdV9pbml0X2dvbGRlbl9yZWdp
c3RlcnMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOw0KPiAgI2VuZGlmDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92aS5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvdmkuYw0KPiBpbmRleCA1MjI5YjRhMmEuLjBkNWU4MDcgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvdmkuYw0KPiBAQCAtMjg1LDYgKzI4NSwxMiBAQCBzdGF0aWMgdm9pZCB2aV9p
bml0X2dvbGRlbl9yZWdpc3RlcnMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAgICAg
ICAgLyogU29tZSBvZiB0aGUgcmVnaXN0ZXJzIG1pZ2h0IGJlIGRlcGVuZGVudCBvbiBHUkJNX0dG
WF9JTkRFWCAqLw0KPiAgICAgICAgIG11dGV4X2xvY2soJmFkZXYtPmdyYm1faWR4X211dGV4KTsN
Cj4NCj4gKyAgICAgICBpZiAoYWRldi0+ZmxhZ3MgJiBBTURfSVNfVkYpIHsNCj4gKyAgICAgICAg
ICAgICAgIGFtZGdwdV94Z3B1X2luaXRfZ29sZGVuX3JlZ2lzdGVycyhhZGV2KTsNCj4gKyAgICAg
ICAgICAgICAgIG11dGV4X3VubG9jaygmYWRldi0+Z3JibV9pZHhfbXV0ZXgpOw0KPiArICAgICAg
ICAgICAgICAgcmV0dXJuOw0KPiArICAgICAgIH0NCj4gKw0KPiAgICAgICAgIHN3aXRjaCAoYWRl
di0+YXNpY190eXBlKSB7DQo+ICAgICAgICAgY2FzZSBDSElQX1RPUEFaOg0KPiAgICAgICAgICAg
ICAgICAgYW1kZ3B1X3Byb2dyYW1fcmVnaXN0ZXJfc2VxdWVuY2UoYWRldiwNCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvbXhncHUvbXhncHVfdmkuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvbXhncHUvbXhncHVfdmkuYw0KPiBpbmRleCBlNWQ1MTdmLi5mYTFlZThmIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL214Z3B1L214Z3B1X3ZpLmMNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9teGdwdS9teGdwdV92aS5jDQo+IEBAIC00Miw2ICs0MiwyNzMgQEAN
Cj4gICNpbmNsdWRlICJkY2UvZGNlXzEwXzBfc2hfbWFzay5oIg0KPiAgI2luY2x1ZGUgInNtdS9z
bXVfN18xXzNfZC5oIg0KPg0KPiArc3RhdGljIGNvbnN0IHUzMiB4Z3B1X2ZpamlfbWdjZ19jZ2Nn
X2luaXRbXSA9IHsNCj4gKyAgICAgICBtbVJMQ19DR1RUX01HQ0dfT1ZFUlJJREUsIDB4ZmZmZmZm
ZmYsIDB4ZmZmZmZmZmYsDQo+ICsgICAgICAgbW1HUkJNX0dGWF9JTkRFWCwgMHhmZmZmZmZmZiwg
MHhlMDAwMDAwMCwNCj4gKyAgICAgICBtbUNCX0NHVFRfU0NMS19DVFJMLCAweGZmZmZmZmZmLCAw
eDAwMDAwMTAwLA0KPiArICAgICAgIG1tQ0dUVF9CQ0lfQ0xLX0NUUkwsIDB4ZmZmZmZmZmYsIDB4
MDAwMDAxMDAsDQo+ICsgICAgICAgbW1DR1RUX0NQX0NMS19DVFJMLCAweGZmZmZmZmZmLCAweDAw
MDAwMTAwLA0KPiArICAgICAgIG1tQ0dUVF9DUENfQ0xLX0NUUkwsIDB4ZmZmZmZmZmYsIDB4MDAw
MDAxMDAsDQo+ICsgICAgICAgbW1DR1RUX0NQRl9DTEtfQ1RSTCwgMHhmZmZmZmZmZiwgMHg0MDAw
MDEwMCwNCj4gKyAgICAgICBtbUNHVFRfRFJNX0NMS19DVFJMMCwgMHhmZmZmZmZmZiwgMHgwMDYw
MDEwMCwNCj4gKyAgICAgICBtbUNHVFRfR0RTX0NMS19DVFJMLCAweGZmZmZmZmZmLCAweDAwMDAw
MTAwLA0KPiArICAgICAgIG1tQ0dUVF9JQV9DTEtfQ1RSTCwgMHhmZmZmZmZmZiwgMHgwNjAwMDEw
MCwNCj4gKyAgICAgICBtbUNHVFRfUEFfQ0xLX0NUUkwsIDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAs
DQo+ICsgICAgICAgbW1DR1RUX1dEX0NMS19DVFJMLCAweGZmZmZmZmZmLCAweDA2MDAwMTAwLA0K
PiArICAgICAgIG1tQ0dUVF9QQ19DTEtfQ1RSTCwgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwNCj4g
KyAgICAgICBtbUNHVFRfUkxDX0NMS19DVFJMLCAweGZmZmZmZmZmLCAweDAwMDAwMTAwLA0KPiAr
ICAgICAgIG1tQ0dUVF9TQ19DTEtfQ1RSTCwgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwNCj4gKyAg
ICAgICBtbUNHVFRfU1BJX0NMS19DVFJMLCAweGZmZmZmZmZmLCAweDAwMDAwMTAwLA0KPiArICAg
ICAgIG1tQ0dUVF9TUV9DTEtfQ1RSTCwgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwNCj4gKyAgICAg
ICBtbUNHVFRfU1FHX0NMS19DVFJMLCAweGZmZmZmZmZmLCAweDAwMDAwMTAwLA0KPiArICAgICAg
IG1tQ0dUVF9TWF9DTEtfQ1RSTDAsIDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAsDQo+ICsgICAgICAg
bW1DR1RUX1NYX0NMS19DVFJMMSwgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBt
bUNHVFRfU1hfQ0xLX0NUUkwyLCAweGZmZmZmZmZmLCAweDAwMDAwMTAwLA0KPiArICAgICAgIG1t
Q0dUVF9TWF9DTEtfQ1RSTDMsIDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAsDQo+ICsgICAgICAgbW1D
R1RUX1NYX0NMS19DVFJMNCwgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbUNH
VFRfVENJX0NMS19DVFJMLCAweGZmZmZmZmZmLCAweDAwMDAwMTAwLA0KPiArICAgICAgIG1tQ0dU
VF9UQ1BfQ0xLX0NUUkwsIDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAsDQo+ICsgICAgICAgbW1DR1RU
X1ZHVF9DTEtfQ1RSTCwgMHhmZmZmZmZmZiwgMHgwNjAwMDEwMCwNCj4gKyAgICAgICBtbURCX0NH
VFRfQ0xLX0NUUkxfMCwgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbVRBX0NH
VFRfQ1RSTCwgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbVRDQV9DR1RUX1ND
TEtfQ1RSTCwgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbVRDQ19DR1RUX1ND
TEtfQ1RSTCwgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbVREX0NHVFRfQ1RS
TCwgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbUdSQk1fR0ZYX0lOREVYLCAw
eGZmZmZmZmZmLCAweGUwMDAwMDAwLA0KPiArICAgICAgIG1tQ0dUU19TTV9DVFJMX1JFRywgMHhm
ZmZmZmZmZiwgMHg5NmUwMDIwMCwNCj4gKyAgICAgICBtbUNQX1JCX1dQVFJfUE9MTF9DTlRMLCAw
eGZmZmZmZmZmLCAweDAwOTAwMTAwLA0KPiArICAgICAgIG1tUkxDX0NHQ0dfQ0dMU19DVFJMLCAw
eGZmZmZmZmZmLCAweDAwMjAwMDNjLA0KPiArICAgICAgIG1tUENJRV9JTkRFWCwgMHhmZmZmZmZm
ZiwgMHgwMTQwMDAxYywNCj4gKyAgICAgICBtbVBDSUVfREFUQSwgMHgwMDBmMDAwMCwgMHgwMDAw
MDAwMCwNCj4gKyAgICAgICBtbVNNQ19JTkRfSU5ERVhfNCwgMHhmZmZmZmZmZiwgMHhDMDYwMDAw
QywNCj4gKyAgICAgICBtbVNNQ19JTkRfREFUQV80LCAweGMwMDAwZmZmLCAweDAwMDAwMTAwLA0K
PiArICAgICAgIG1tWERNQV9DTE9DS19HQVRJTkdfQ05UTCwgMHhmZmZmZmZmZiwgMHgwMDAwMDEw
MCwNCj4gKyAgICAgICBtbVhETUFfTUVNX1BPV0VSX0NOVEwsIDB4MDAwMDAxMDEsIDB4MDAwMDAw
MDAsDQo+ICsgICAgICAgbW1NQ19NRU1fUE9XRVJfTFMsIDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDQs
DQo+ICsgICAgICAgbW1DR1RUX0RSTV9DTEtfQ1RSTDAsIDB4ZmYwMDBmZmYsIDB4MDAwMDAxMDAs
DQo+ICsgICAgICAgbW1IRFBfWERQX0NHVFRfQkxLX0NUUkwsIDB4YzAwMDBmZmYsIDB4MDAwMDAx
MDQsDQo+ICsgICAgICAgbW1DUF9NRU1fU0xQX0NOVEwsIDB4MDAwMDAwMDEsIDB4MDAwMDAwMDEs
DQo+ICsgICAgICAgbW1TRE1BMF9DTEtfQ1RSTCwgMHhmZjAwMGZmMCwgMHgwMDAwMDEwMCwNCj4g
KyAgICAgICBtbVNETUExX0NMS19DVFJMLCAweGZmMDAwZmYwLCAweDAwMDAwMTAwLA0KPiArfTsN
Cj4gKw0KPiArc3RhdGljIGNvbnN0IHUzMiB4Z3B1X2dvbGRlbl9zZXR0aW5nc19maWppX2ExMFtd
ID0gew0KPiArICAgICAgIG1tQ0JfSFdfQ09OVFJPTF8zLCAweDAwMDAwMWZmLCAweDAwMDAwMDQw
LA0KPiArICAgICAgIG1tREJfREVCVUcyLCAweGYwMGZmZmZmLCAweDAwMDAwNDAwLA0KPiArICAg
ICAgIG1tRENJX0NMS19DTlRMLCAweDAwMDAwMDgwLCAweDAwMDAwMDAwLA0KPiArICAgICAgIG1t
RkJDX0RFQlVHX0NPTVAsIDB4MDAwMDAwZjAsIDB4MDAwMDAwNzAsDQo+ICsgICAgICAgbW1GQkNf
TUlTQywgMHgxZjMxMWZmZiwgMHgxMjMwMDAwMCwNCj4gKyAgICAgICBtbUhETUlfQ09OVFJPTCwg
MHgzMTAwMDExMSwgMHgwMDAwMDAxMSwNCj4gKyAgICAgICBtbVBBX1NDX0VOSEFOQ0UsIDB4ZmZm
ZmZmZmYsIDB4MjAwMDAwMDEsDQo+ICsgICAgICAgbW1QQV9TQ19MSU5FX1NUSVBQTEVfU1RBVEUs
IDB4MDAwMGZmMGYsIDB4MDAwMDAwMDAsDQo+ICsgICAgICAgbW1TRE1BMF9DSElDS0VOX0JJVFMs
IDB4ZmM5MTAwMDcsIDB4MDA4MTAwMDcsDQo+ICsgICAgICAgbW1TRE1BMF9HRlhfSUJfQ05UTCwg
MHg4MDBmMDExMSwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbVNETUEwX1JMQzBfSUJfQ05UTCwg
MHg4MDBmMDExMSwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbVNETUEwX1JMQzFfSUJfQ05UTCwg
MHg4MDBmMDExMSwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbVNETUExX0NISUNLRU5fQklUUywg
MHhmYzkxMDAwNywgMHgwMDgxMDAwNywNCj4gKyAgICAgICBtbVNETUExX0dGWF9JQl9DTlRMLCAw
eDgwMGYwMTExLCAweDAwMDAwMTAwLA0KPiArICAgICAgIG1tU0RNQTFfUkxDMF9JQl9DTlRMLCAw
eDgwMGYwMTExLCAweDAwMDAwMTAwLA0KPiArICAgICAgIG1tU0RNQTFfUkxDMV9JQl9DTlRMLCAw
eDgwMGYwMTExLCAweDAwMDAwMTAwLA0KPiArICAgICAgIG1tU1FfUkFORE9NX1dBVkVfUFJJLCAw
eDAwMWZmZmZmLCAweDAwMDAwNmZkLA0KPiArICAgICAgIG1tVEFfQ05UTF9BVVgsIDB4MDAwZjAw
MGYsIDB4MDAwYjAwMDAsDQo+ICsgICAgICAgbW1UQ0NfRVhFX0RJU0FCTEUsIDB4MDAwMDAwMDIs
IDB4MDAwMDAwMDIsDQo+ICsgICAgICAgbW1UQ1BfQUREUl9DT05GSUcsIDB4MDAwMDAzZmYsIDB4
MDAwMDAwZmYsDQo+ICsgICAgICAgbW1WR1RfUkVTRVRfREVCVUcsIDB4MDAwMDAwMDQsIDB4MDAw
MDAwMDQsDQo+ICsgICAgICAgbW1WTV9QUlRfQVBFUlRVUkUwX0xPV19BRERSLCAweDBmZmZmZmZm
LCAweDBmZmZmZmZmLA0KPiArICAgICAgIG1tVk1fUFJUX0FQRVJUVVJFMV9MT1dfQUREUiwgMHgw
ZmZmZmZmZiwgMHgwZmZmZmZmZiwNCj4gKyAgICAgICBtbVZNX1BSVF9BUEVSVFVSRTJfTE9XX0FE
RFIsIDB4MGZmZmZmZmYsIDB4MGZmZmZmZmYsDQo+ICsgICAgICAgbW1WTV9QUlRfQVBFUlRVUkUz
X0xPV19BRERSLCAweDBmZmZmZmZmLCAweDBmZmZmZmZmLA0KPiArfTsNCj4gKw0KPiArc3RhdGlj
IGNvbnN0IHUzMiB4Z3B1X2ZpamlfZ29sZGVuX2NvbW1vbl9hbGxbXSA9IHsNCj4gKyAgICAgICBt
bUdSQk1fR0ZYX0lOREVYLCAweGZmZmZmZmZmLCAweGUwMDAwMDAwLA0KPiArICAgICAgIG1tUEFf
U0NfUkFTVEVSX0NPTkZJRywgMHhmZmZmZmZmZiwgMHgzYTAwMTYxYSwNCj4gKyAgICAgICBtbVBB
X1NDX1JBU1RFUl9DT05GSUdfMSwgMHhmZmZmZmZmZiwgMHgwMDAwMDAyZSwNCj4gKyAgICAgICBt
bUdCX0FERFJfQ09ORklHLCAweGZmZmZmZmZmLCAweDIyMDExMDAzLA0KPiArICAgICAgIG1tU1BJ
X1JFU09VUkNFX1JFU0VSVkVfQ1VfMCwgMHhmZmZmZmZmZiwgMHgwMDAwMDgwMCwNCj4gKyAgICAg
ICBtbVNQSV9SRVNPVVJDRV9SRVNFUlZFX0NVXzEsIDB4ZmZmZmZmZmYsIDB4MDAwMDA4MDAsDQo+
ICsgICAgICAgbW1TUElfUkVTT1VSQ0VfUkVTRVJWRV9FTl9DVV8wLCAweGZmZmZmZmZmLCAweDAw
MDA3RkJGLA0KPiArICAgICAgIG1tU1BJX1JFU09VUkNFX1JFU0VSVkVfRU5fQ1VfMSwgMHhmZmZm
ZmZmZiwgMHgwMDAwN0ZBRiwNCj4gKyAgICAgICBtbUdSQk1fR0ZYX0lOREVYLCAweGZmZmZmZmZm
LCAweGUwMDAwMDAwLA0KPiArICAgICAgIG1tU1BJX0NPTkZJR19DTlRMXzEsIDB4MDAwMDAwMGYs
IDB4MDAwMDAwMDksDQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgY29uc3QgdTMyIHhncHVfdG9uZ2Ff
bWdjZ19jZ2NnX2luaXRbXSA9IHsNCj4gKyAgICAgICBtbVJMQ19DR1RUX01HQ0dfT1ZFUlJJREUs
ICAgMHhmZmZmZmZmZiwgMHhmZmZmZmZmZiwNCj4gKyAgICAgICBtbUdSQk1fR0ZYX0lOREVYLCAg
ICAgICAgICAgMHhmZmZmZmZmZiwgMHhlMDAwMDAwMCwNCj4gKyAgICAgICBtbUNCX0NHVFRfU0NM
S19DVFJMLCAgICAgICAgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbUNHVFRf
QkNJX0NMS19DVFJMLCAgICAgICAgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBt
bUNHVFRfQ1BfQ0xLX0NUUkwsICAgICAgICAgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwNCj4gKyAg
ICAgICBtbUNHVFRfQ1BDX0NMS19DVFJMLCAgICAgICAgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwN
Cj4gKyAgICAgICBtbUNHVFRfQ1BGX0NMS19DVFJMLCAgICAgICAgMHhmZmZmZmZmZiwgMHg0MDAw
MDEwMCwNCj4gKyAgICAgICBtbUNHVFRfRFJNX0NMS19DVFJMMCwgICAgICAgMHhmZmZmZmZmZiwg
MHgwMDYwMDEwMCwNCj4gKyAgICAgICBtbUNHVFRfR0RTX0NMS19DVFJMLCAgICAgICAgMHhmZmZm
ZmZmZiwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbUNHVFRfSUFfQ0xLX0NUUkwsICAgICAgICAg
MHhmZmZmZmZmZiwgMHgwNjAwMDEwMCwNCj4gKyAgICAgICBtbUNHVFRfUEFfQ0xLX0NUUkwsICAg
ICAgICAgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbUNHVFRfV0RfQ0xLX0NU
UkwsICAgICAgICAgMHhmZmZmZmZmZiwgMHgwNjAwMDEwMCwNCj4gKyAgICAgICBtbUNHVFRfUENf
Q0xLX0NUUkwsICAgICAgICAgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbUNH
VFRfUkxDX0NMS19DVFJMLCAgICAgICAgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwNCj4gKyAgICAg
ICBtbUNHVFRfU0NfQ0xLX0NUUkwsICAgICAgICAgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwNCj4g
KyAgICAgICBtbUNHVFRfU1BJX0NMS19DVFJMLCAgICAgICAgMHhmZmZmZmZmZiwgMHgwMDAwMDEw
MCwNCj4gKyAgICAgICBtbUNHVFRfU1FfQ0xLX0NUUkwsICAgICAgICAgMHhmZmZmZmZmZiwgMHgw
MDAwMDEwMCwNCj4gKyAgICAgICBtbUNHVFRfU1FHX0NMS19DVFJMLCAgICAgICAgMHhmZmZmZmZm
ZiwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbUNHVFRfU1hfQ0xLX0NUUkwwLCAgICAgICAgMHhm
ZmZmZmZmZiwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbUNHVFRfU1hfQ0xLX0NUUkwxLCAgICAg
ICAgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbUNHVFRfU1hfQ0xLX0NUUkwy
LCAgICAgICAgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbUNHVFRfU1hfQ0xL
X0NUUkwzLCAgICAgICAgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbUNHVFRf
U1hfQ0xLX0NUUkw0LCAgICAgICAgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBt
bUNHVFRfVENJX0NMS19DVFJMLCAgICAgICAgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwNCj4gKyAg
ICAgICBtbUNHVFRfVENQX0NMS19DVFJMLCAgICAgICAgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwN
Cj4gKyAgICAgICBtbUNHVFRfVkdUX0NMS19DVFJMLCAgICAgICAgMHhmZmZmZmZmZiwgMHgwNjAw
MDEwMCwNCj4gKyAgICAgICBtbURCX0NHVFRfQ0xLX0NUUkxfMCwgICAgICAgMHhmZmZmZmZmZiwg
MHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbVRBX0NHVFRfQ1RSTCwgICAgICAgICAgICAgMHhmZmZm
ZmZmZiwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbVRDQV9DR1RUX1NDTEtfQ1RSTCwgICAgICAg
MHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbVRDQ19DR1RUX1NDTEtfQ1RSTCwg
ICAgICAgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbVREX0NHVFRfQ1RSTCwg
ICAgICAgICAgICAgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbUdSQk1fR0ZY
X0lOREVYLCAgICAgICAgICAgMHhmZmZmZmZmZiwgMHhlMDAwMDAwMCwNCj4gKyAgICAgICBtbUNH
VFNfQ1UwX1NQMF9DVFJMX1JFRywgICAgMHhmZmZmZmZmZiwgMHgwMDAxMDAwMCwNCj4gKyAgICAg
ICBtbUNHVFNfQ1UwX0xEU19TUV9DVFJMX1JFRywgMHhmZmZmZmZmZiwgMHgwMDAzMDAwMiwNCj4g
KyAgICAgICBtbUNHVFNfQ1UwX1RBX1NRQ19DVFJMX1JFRywgMHhmZmZmZmZmZiwgMHgwMDA0MDAw
NywNCj4gKyAgICAgICBtbUNHVFNfQ1UwX1NQMV9DVFJMX1JFRywgICAgMHhmZmZmZmZmZiwgMHgw
MDA2MDAwNSwNCj4gKyAgICAgICBtbUNHVFNfQ1UwX1REX1RDUF9DVFJMX1JFRywgMHhmZmZmZmZm
ZiwgMHgwMDA5MDAwOCwNCj4gKyAgICAgICBtbUNHVFNfQ1UxX1NQMF9DVFJMX1JFRywgICAgMHhm
ZmZmZmZmZiwgMHgwMDAxMDAwMCwNCj4gKyAgICAgICBtbUNHVFNfQ1UxX0xEU19TUV9DVFJMX1JF
RywgMHhmZmZmZmZmZiwgMHgwMDAzMDAwMiwNCj4gKyAgICAgICBtbUNHVFNfQ1UxX1RBX0NUUkxf
UkVHLCAgICAgMHhmZmZmZmZmZiwgMHgwMDA0MDAwNywNCj4gKyAgICAgICBtbUNHVFNfQ1UxX1NQ
MV9DVFJMX1JFRywgICAgMHhmZmZmZmZmZiwgMHgwMDA2MDAwNSwNCj4gKyAgICAgICBtbUNHVFNf
Q1UxX1REX1RDUF9DVFJMX1JFRywgMHhmZmZmZmZmZiwgMHgwMDA5MDAwOCwNCj4gKyAgICAgICBt
bUNHVFNfQ1UyX1NQMF9DVFJMX1JFRywgICAgMHhmZmZmZmZmZiwgMHgwMDAxMDAwMCwNCj4gKyAg
ICAgICBtbUNHVFNfQ1UyX0xEU19TUV9DVFJMX1JFRywgMHhmZmZmZmZmZiwgMHgwMDAzMDAwMiwN
Cj4gKyAgICAgICBtbUNHVFNfQ1UyX1RBX0NUUkxfUkVHLCAgICAgMHhmZmZmZmZmZiwgMHgwMDA0
MDAwNywNCj4gKyAgICAgICBtbUNHVFNfQ1UyX1NQMV9DVFJMX1JFRywgICAgMHhmZmZmZmZmZiwg
MHgwMDA2MDAwNSwNCj4gKyAgICAgICBtbUNHVFNfQ1UyX1REX1RDUF9DVFJMX1JFRywgMHhmZmZm
ZmZmZiwgMHgwMDA5MDAwOCwNCj4gKyAgICAgICBtbUNHVFNfQ1UzX1NQMF9DVFJMX1JFRywgICAg
MHhmZmZmZmZmZiwgMHgwMDAxMDAwMCwNCj4gKyAgICAgICBtbUNHVFNfQ1UzX0xEU19TUV9DVFJM
X1JFRywgMHhmZmZmZmZmZiwgMHgwMDAzMDAwMiwNCj4gKyAgICAgICBtbUNHVFNfQ1UzX1RBX0NU
UkxfUkVHLCAgICAgMHhmZmZmZmZmZiwgMHgwMDA0MDAwNywNCj4gKyAgICAgICBtbUNHVFNfQ1Uz
X1NQMV9DVFJMX1JFRywgICAgMHhmZmZmZmZmZiwgMHgwMDA2MDAwNSwNCj4gKyAgICAgICBtbUNH
VFNfQ1UzX1REX1RDUF9DVFJMX1JFRywgMHhmZmZmZmZmZiwgMHgwMDA5MDAwOCwNCj4gKyAgICAg
ICBtbUNHVFNfQ1U0X1NQMF9DVFJMX1JFRywgICAgMHhmZmZmZmZmZiwgMHgwMDAxMDAwMCwNCj4g
KyAgICAgICBtbUNHVFNfQ1U0X0xEU19TUV9DVFJMX1JFRywgMHhmZmZmZmZmZiwgMHgwMDAzMDAw
MiwNCj4gKyAgICAgICBtbUNHVFNfQ1U0X1RBX1NRQ19DVFJMX1JFRywgMHhmZmZmZmZmZiwgMHgw
MDA0MDAwNywNCj4gKyAgICAgICBtbUNHVFNfQ1U0X1NQMV9DVFJMX1JFRywgICAgMHhmZmZmZmZm
ZiwgMHgwMDA2MDAwNSwNCj4gKyAgICAgICBtbUNHVFNfQ1U0X1REX1RDUF9DVFJMX1JFRywgMHhm
ZmZmZmZmZiwgMHgwMDA5MDAwOCwNCj4gKyAgICAgICBtbUNHVFNfQ1U1X1NQMF9DVFJMX1JFRywg
ICAgMHhmZmZmZmZmZiwgMHgwMDAxMDAwMCwNCj4gKyAgICAgICBtbUNHVFNfQ1U1X0xEU19TUV9D
VFJMX1JFRywgMHhmZmZmZmZmZiwgMHgwMDAzMDAwMiwNCj4gKyAgICAgICBtbUNHVFNfQ1U1X1RB
X0NUUkxfUkVHLCAgICAgMHhmZmZmZmZmZiwgMHgwMDA0MDAwNywNCj4gKyAgICAgICBtbUNHVFNf
Q1U1X1NQMV9DVFJMX1JFRywgICAgMHhmZmZmZmZmZiwgMHgwMDA2MDAwNSwNCj4gKyAgICAgICBt
bUNHVFNfQ1U1X1REX1RDUF9DVFJMX1JFRywgMHhmZmZmZmZmZiwgMHgwMDA5MDAwOCwNCj4gKyAg
ICAgICBtbUNHVFNfQ1U2X1NQMF9DVFJMX1JFRywgICAgMHhmZmZmZmZmZiwgMHgwMDAxMDAwMCwN
Cj4gKyAgICAgICBtbUNHVFNfQ1U2X0xEU19TUV9DVFJMX1JFRywgMHhmZmZmZmZmZiwgMHgwMDAz
MDAwMiwNCj4gKyAgICAgICBtbUNHVFNfQ1U2X1RBX0NUUkxfUkVHLCAgICAgMHhmZmZmZmZmZiwg
MHgwMDA0MDAwNywNCj4gKyAgICAgICBtbUNHVFNfQ1U2X1NQMV9DVFJMX1JFRywgICAgMHhmZmZm
ZmZmZiwgMHgwMDA2MDAwNSwNCj4gKyAgICAgICBtbUNHVFNfQ1U2X1REX1RDUF9DVFJMX1JFRywg
MHhmZmZmZmZmZiwgMHgwMDA5MDAwOCwNCj4gKyAgICAgICBtbUNHVFNfQ1U3X1NQMF9DVFJMX1JF
RywgICAgMHhmZmZmZmZmZiwgMHgwMDAxMDAwMCwNCj4gKyAgICAgICBtbUNHVFNfQ1U3X0xEU19T
UV9DVFJMX1JFRywgMHhmZmZmZmZmZiwgMHgwMDAzMDAwMiwNCj4gKyAgICAgICBtbUNHVFNfQ1U3
X1RBX0NUUkxfUkVHLCAgICAgMHhmZmZmZmZmZiwgMHgwMDA0MDAwNywNCj4gKyAgICAgICBtbUNH
VFNfQ1U3X1NQMV9DVFJMX1JFRywgICAgMHhmZmZmZmZmZiwgMHgwMDA2MDAwNSwNCj4gKyAgICAg
ICBtbUNHVFNfQ1U3X1REX1RDUF9DVFJMX1JFRywgMHhmZmZmZmZmZiwgMHgwMDA5MDAwOCwNCj4g
KyAgICAgICBtbUNHVFNfU01fQ1RSTF9SRUcsICAgICAgICAgMHhmZmZmZmZmZiwgMHg5NmUwMDIw
MCwNCj4gKyAgICAgICBtbUNQX1JCX1dQVFJfUE9MTF9DTlRMLCAgICAgMHhmZmZmZmZmZiwgMHgw
MDkwMDEwMCwNCj4gKyAgICAgICBtbVJMQ19DR0NHX0NHTFNfQ1RSTCwgICAgICAgMHhmZmZmZmZm
ZiwgMHgwMDIwMDAzYywNCj4gKyAgICAgICBtbVBDSUVfSU5ERVgsICAgICAgICAgICAgICAgMHhm
ZmZmZmZmZiwgMHgwMTQwMDAxYywNCj4gKyAgICAgICBtbVBDSUVfREFUQSwgICAgICAgICAgICAg
ICAgMHgwMDBmMDAwMCwgMHgwMDAwMDAwMCwNCj4gKyAgICAgICBtbVNNQ19JTkRfSU5ERVhfNCwg
ICAgICAgICAgMHhmZmZmZmZmZiwgMHhDMDYwMDAwQywNCj4gKyAgICAgICBtbVNNQ19JTkRfREFU
QV80LCAgICAgICAgICAgMHhjMDAwMGZmZiwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbVhETUFf
Q0xPQ0tfR0FUSU5HX0NOVEwsICAgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBt
bVhETUFfTUVNX1BPV0VSX0NOVEwsICAgICAgMHgwMDAwMDEwMSwgMHgwMDAwMDAwMCwNCj4gKyAg
ICAgICBtbU1DX01FTV9QT1dFUl9MUywgICAgICAgICAgMHhmZmZmZmZmZiwgMHgwMDAwMDEwNCwN
Cj4gKyAgICAgICBtbUNHVFRfRFJNX0NMS19DVFJMMCwgICAgICAgMHhmZjAwMGZmZiwgMHgwMDAw
MDEwMCwNCj4gKyAgICAgICBtbUhEUF9YRFBfQ0dUVF9CTEtfQ1RSTCwgICAgMHhjMDAwMGZmZiwg
MHgwMDAwMDEwNCwNCj4gKyAgICAgICBtbUNQX01FTV9TTFBfQ05UTCwgICAgICAgICAgMHgwMDAw
MDAwMSwgMHgwMDAwMDAwMSwNCj4gKyAgICAgICBtbVNETUEwX0NMS19DVFJMLCAgICAgICAgICAg
MHhmZjAwMGZmMCwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbVNETUExX0NMS19DVFJMLCAgICAg
ICAgICAgMHhmZjAwMGZmMCwgMHgwMDAwMDEwMCwNCj4gK307DQo+ICsNCj4gK3N0YXRpYyBjb25z
dCB1MzIgeGdwdV9nb2xkZW5fc2V0dGluZ3NfdG9uZ2FfYTExW10gPSB7DQo+ICsgICAgICAgbW1D
Ql9IV19DT05UUk9MLCAweGZmZmRmM2NmLCAweDAwMDA3MjA4LA0KPiArICAgICAgIG1tQ0JfSFdf
Q09OVFJPTF8zLCAweDAwMDAwMDQwLCAweDAwMDAwMDQwLA0KPiArICAgICAgIG1tREJfREVCVUcy
LCAweGYwMGZmZmZmLCAweDAwMDAwNDAwLA0KPiArICAgICAgIG1tRENJX0NMS19DTlRMLCAweDAw
MDAwMDgwLCAweDAwMDAwMDAwLA0KPiArICAgICAgIG1tRkJDX0RFQlVHX0NPTVAsIDB4MDAwMDAw
ZjAsIDB4MDAwMDAwNzAsDQo+ICsgICAgICAgbW1GQkNfTUlTQywgMHgxZjMxMWZmZiwgMHgxMjMw
MDAwMCwNCj4gKyAgICAgICBtbUdCX0dQVV9JRCwgMHgwMDAwMDAwZiwgMHgwMDAwMDAwMCwNCj4g
KyAgICAgICBtbUhETUlfQ09OVFJPTCwgMHgzMTAwMDExMSwgMHgwMDAwMDAxMSwNCj4gKyAgICAg
ICBtbU1DX0FSQl9XVE1fR1JQV1RfUkQsIDB4MDAwMDAwMDMsIDB4MDAwMDAwMDAsDQo+ICsgICAg
ICAgbW1NQ19IVUJfUkRSRVFfRE1JRl9MSU1JVCwgMHgwMDAwMDA3ZiwgMHgwMDAwMDAyOCwNCj4g
KyAgICAgICBtbU1DX0hVQl9XRFBfVU1DLCAweDAwMDA3ZmI2LCAweDAwMDAwOTkxLA0KPiArICAg
ICAgIG1tUEFfU0NfRU5IQU5DRSwgMHhmZmZmZmZmZiwgMHgyMDAwMDAwMSwNCj4gKyAgICAgICBt
bVBBX1NDX0ZJRk9fREVQVEhfQ05UTCwgMHgwMDAwMDNmZiwgMHgwMDAwMDBmYywNCj4gKyAgICAg
ICBtbVBBX1NDX0xJTkVfU1RJUFBMRV9TVEFURSwgMHgwMDAwZmYwZiwgMHgwMDAwMDAwMCwNCj4g
KyAgICAgICBtbVJMQ19DR0NHX0NHTFNfQ1RSTCwgMHgwMDAwMDAwMywgMHgwMDAwMDAzYywNCj4g
KyAgICAgICBtbVNETUEwX0NISUNLRU5fQklUUywgMHhmYzkxMDAwNywgMHgwMDgxMDAwNywNCj4g
KyAgICAgICBtbVNETUEwX0NMS19DVFJMLCAweGZmMDAwZmZmLCAweDAwMDAwMDAwLA0KPiArICAg
ICAgIG1tU0RNQTBfR0ZYX0lCX0NOVEwsIDB4ODAwZjAxMTEsIDB4MDAwMDAxMDAsDQo+ICsgICAg
ICAgbW1TRE1BMF9STEMwX0lCX0NOVEwsIDB4ODAwZjAxMTEsIDB4MDAwMDAxMDAsDQo+ICsgICAg
ICAgbW1TRE1BMF9STEMxX0lCX0NOVEwsIDB4ODAwZjAxMTEsIDB4MDAwMDAxMDAsDQo+ICsgICAg
ICAgbW1TRE1BMV9DSElDS0VOX0JJVFMsIDB4ZmM5MTAwMDcsIDB4MDA4MTAwMDcsDQo+ICsgICAg
ICAgbW1TRE1BMV9DTEtfQ1RSTCwgMHhmZjAwMGZmZiwgMHgwMDAwMDAwMCwNCj4gKyAgICAgICBt
bVNETUExX0dGWF9JQl9DTlRMLCAweDgwMGYwMTExLCAweDAwMDAwMTAwLA0KPiArICAgICAgIG1t
U0RNQTFfUkxDMF9JQl9DTlRMLCAweDgwMGYwMTExLCAweDAwMDAwMTAwLA0KPiArICAgICAgIG1t
U0RNQTFfUkxDMV9JQl9DTlRMLCAweDgwMGYwMTExLCAweDAwMDAwMTAwLA0KPiArICAgICAgIG1t
U1FfUkFORE9NX1dBVkVfUFJJLCAweDAwMWZmZmZmLCAweDAwMDAwNmZkLA0KPiArICAgICAgIG1t
VEFfQ05UTF9BVVgsIDB4MDAwZjAwMGYsIDB4MDAwYjAwMDAsDQo+ICsgICAgICAgbW1UQ0NfQ1RS
TCwgMHgwMDEwMDAwMCwgMHhmMzFmZmY3ZiwNCj4gKyAgICAgICBtbVRDQ19FWEVfRElTQUJMRSwg
MHgwMDAwMDAwMiwgMHgwMDAwMDAwMiwNCj4gKyAgICAgICBtbVRDUF9BRERSX0NPTkZJRywgMHgw
MDAwMDNmZiwgMHgwMDAwMDJmYiwNCj4gKyAgICAgICBtbVRDUF9DSEFOX1NURUVSX0hJLCAweGZm
ZmZmZmZmLCAweDAwMDA1NDNiLA0KPiArICAgICAgIG1tVENQX0NIQU5fU1RFRVJfTE8sIDB4ZmZm
ZmZmZmYsIDB4YTkyMTA4NzYsDQo+ICsgICAgICAgbW1WR1RfUkVTRVRfREVCVUcsIDB4MDAwMDAw
MDQsIDB4MDAwMDAwMDQsDQo+ICsgICAgICAgbW1WTV9QUlRfQVBFUlRVUkUwX0xPV19BRERSLCAw
eDBmZmZmZmZmLCAweDBmZmZmZmZmLA0KPiArICAgICAgIG1tVk1fUFJUX0FQRVJUVVJFMV9MT1df
QUREUiwgMHgwZmZmZmZmZiwgMHgwZmZmZmZmZiwNCj4gKyAgICAgICBtbVZNX1BSVF9BUEVSVFVS
RTJfTE9XX0FERFIsIDB4MGZmZmZmZmYsIDB4MGZmZmZmZmYsDQo+ICsgICAgICAgbW1WTV9QUlRf
QVBFUlRVUkUzX0xPV19BRERSLCAweDBmZmZmZmZmLCAweDBmZmZmZmZmLA0KPiArfTsNCj4gKw0K
PiArc3RhdGljIGNvbnN0IHUzMiB4Z3B1X3RvbmdhX2dvbGRlbl9jb21tb25fYWxsW10gPSB7DQo+
ICsgICAgICAgbW1HUkJNX0dGWF9JTkRFWCwgICAgICAgICAgICAgICAweGZmZmZmZmZmLCAweGUw
MDAwMDAwLA0KPiArICAgICAgIG1tUEFfU0NfUkFTVEVSX0NPTkZJRywgICAgICAgICAgMHhmZmZm
ZmZmZiwgMHgxNjAwMDAxMiwNCj4gKyAgICAgICBtbVBBX1NDX1JBU1RFUl9DT05GSUdfMSwgICAg
ICAgIDB4ZmZmZmZmZmYsIDB4MDAwMDAwMkEsDQo+ICsgICAgICAgbW1HQl9BRERSX0NPTkZJRywg
ICAgICAgICAgICAgICAweGZmZmZmZmZmLCAweDIyMDExMDAyLA0KPiArICAgICAgIG1tU1BJX1JF
U09VUkNFX1JFU0VSVkVfQ1VfMCwgICAgMHhmZmZmZmZmZiwgMHgwMDAwMDgwMCwNCj4gKyAgICAg
ICBtbVNQSV9SRVNPVVJDRV9SRVNFUlZFX0NVXzEsICAgIDB4ZmZmZmZmZmYsIDB4MDAwMDA4MDAs
DQo+ICsgICAgICAgbW1TUElfUkVTT1VSQ0VfUkVTRVJWRV9FTl9DVV8wLCAweGZmZmZmZmZmLCAw
eDAwMDA3RkJGLA0KPiArfTsNCj4gKw0KPiArdm9pZCBhbWRncHVfeGdwdV9pbml0X2dvbGRlbl9y
ZWdpc3RlcnMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICt7DQo+ICsgICAgICAgc3dp
dGNoIChhZGV2LT5hc2ljX3R5cGUpIHsNCj4gKyAgICAgICBjYXNlIENISVBfRklKSToNCj4gKyAg
ICAgICAgICAgICAgIGFtZGdwdV9wcm9ncmFtX3JlZ2lzdGVyX3NlcXVlbmNlKGFkZXYsDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB4Z3B1X2Zpamlf
bWdjZ19jZ2NnX2luaXQsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAoY29uc3QgdTMyKUFSUkFZX1NJWkUoDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB4Z3B1X2ZpamlfbWdjZ19jZ2NnX2luaXQpKTsN
Cj4gKyAgICAgICAgICAgICAgIGFtZGdwdV9wcm9ncmFtX3JlZ2lzdGVyX3NlcXVlbmNlKGFkZXYs
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB4Z3B1
X2dvbGRlbl9zZXR0aW5nc19maWppX2ExMCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIChjb25zdCB1MzIpQVJSQVlfU0laRSgNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHhncHVfZ29sZGVuX3NldHRp
bmdzX2ZpamlfYTEwKSk7DQo+ICsgICAgICAgICAgICAgICBhbWRncHVfcHJvZ3JhbV9yZWdpc3Rl
cl9zZXF1ZW5jZShhZGV2LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgeGdwdV9maWppX2dvbGRlbl9jb21tb25fYWxsLA0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKGNvbnN0IHUzMilBUlJBWV9TSVpF
KA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgeGdw
dV9maWppX2dvbGRlbl9jb21tb25fYWxsKSk7DQo+ICsgICAgICAgICAgICAgICBicmVhazsNCj4g
KyAgICAgICBjYXNlIENISVBfVE9OR0E6DQo+ICsgICAgICAgICAgICAgICBhbWRncHVfcHJvZ3Jh
bV9yZWdpc3Rlcl9zZXF1ZW5jZShhZGV2LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgeGdwdV90b25nYV9tZ2NnX2NnY2dfaW5pdCwNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChjb25zdCB1MzIpQVJS
QVlfU0laRSgNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHhncHVfdG9uZ2FfbWdjZ19jZ2NnX2luaXQpKTsNCj4gKyAgICAgICAgICAgICAgIGFtZGdw
dV9wcm9ncmFtX3JlZ2lzdGVyX3NlcXVlbmNlKGFkZXYsDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB4Z3B1X2dvbGRlbl9zZXR0aW5nc190b25nYV9h
MTEsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAo
Y29uc3QgdTMyKUFSUkFZX1NJWkUoDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB4Z3B1X2dvbGRlbl9zZXR0aW5nc190b25nYV9hMTEpKTsNCj4gKyAg
ICAgICAgICAgICAgIGFtZGdwdV9wcm9ncmFtX3JlZ2lzdGVyX3NlcXVlbmNlKGFkZXYsDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB4Z3B1X3Rvbmdh
X2dvbGRlbl9jb21tb25fYWxsLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgKGNvbnN0IHUzMilBUlJBWV9TSVpFKA0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgeGdwdV90b25nYV9nb2xkZW5fY29tbW9u
X2FsbCkpOw0KPiArICAgICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAgZGVmYXVsdDoNCj4g
KyAgICAgICAgICAgICAgIGJyZWFrOw0KPiArICAgICAgIH0NCj4gK30NCg0KQ2xlYW5lciB0byBq
dXN0IHB1dCB0aGlzIGluIHZpLmMuDQoNCkFsZXgNCg0KPiArDQo+ICBzdGF0aWMgaW50IHhncHVf
dmlfZWFybHlfaW5pdCh2b2lkICpoYW5kbGUpDQo+ICB7DQo+ICAgICAgICAgc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKiloYW5kbGU7DQo+IC0tDQo+
IDIuNy40DQo+DQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fDQo+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnPG1haWx0bzphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4NCj4gaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4DQo=

--_000_CY4PR12MB17013C9CFD61372FC7375D45EB900CY4PR12MB1701namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:=CB=CE=CC=E5;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:=CB=CE=CC=E5;}
p.emailquote, li.emailquote, div.emailquote
	{mso-style-name:emailquote;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:1.0pt;
	margin-bottom:.0001pt;
	border:none;
	padding:0in;
	font-size:12.0pt;
	font-family:=CB=CE=CC=E5;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">Thank monk=A1=AFs comments.<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Liu, Monk
<br>
<b>Sent:</b> Tuesday, December 20, 2016 12:09 PM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;; Yu, Xiangliang &lt;X=
iangliang.Yu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;; dl.SRDC_SW_G=
PUVirtualization &lt;dl.SRDC_SW_GPUVirtualization-5C7GfCeVMHo@public.gmane.org&gt;; Min, Frank &=
lt;Frank.Min-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> </span><span lang=3D"ZH-CN" style=3D"font-size:11.0pt">=B4=
=F0=B8=B4</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&q=
uot;,sans-serif">: [PATCH 21/23] drm/amdgpu: change golden register program=
 sequence of virtualization<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div id=3D"x_divtagdefaultwrapper">
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">H=
i Alex<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"><=
o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">I=
 agree with you that this patch's GOLDEN setting programming should be put =
in VI.C, but I found a hardware issue :<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"><=
o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">o=
riginal linux logic is that we set golden setting registers separately with=
in each IP's hw init routine, but for TONGA VF, it is really strange that w=
e must set all GOLDEN setting value to chip
 in one shoot (means we use one routine to programing all IP's golden setti=
ng to registers), ortherwise we found TONGA vf&nbsp; just failed in RING TE=
ST.<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"><=
o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">a=
nd I admit I don't know why (I checked windows CAIL code, it is also set al=
l golden setting registers in one routine)<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"><=
o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">B=
R Monk<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span lang=3D"ZH-CN" style=3D"font-size:11.0pt;co=
lor:black">=B7=A2=BC=FE=C8=CB</span></b><b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif;color:black">:</span></b><span s=
tyle=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:b=
lack">
 Alex Deucher &lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">alexdeucher@gmai=
l.com</a>&gt;<br>
</span><b><span lang=3D"ZH-CN" style=3D"font-size:11.0pt;color:black">=B7=
=A2=CB=CD=CA=B1=BC=E4</span></b><b><span style=3D"font-size:11.0pt;font-fam=
ily:&quot;Calibri&quot;,sans-serif;color:black">:</span></b><span style=3D"=
font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> 2=
016</span><span lang=3D"ZH-CN" style=3D"font-size:11.0pt;color:black">=C4=
=EA</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:black">12</span><span lang=3D"ZH-CN" style=3D"font-size:11.=
0pt;color:black">=D4=C2</span><span style=3D"font-size:11.0pt;font-family:&=
quot;Calibri&quot;,sans-serif;color:black">20</span><span lang=3D"ZH-CN" st=
yle=3D"font-size:11.0pt;color:black">=C8=D5</span><span style=3D"font-size:=
11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">
 7:37:06<br>
</span><b><span lang=3D"ZH-CN" style=3D"font-size:11.0pt;color:black">=CA=
=D5=BC=FE=C8=CB</span></b><b><span style=3D"font-size:11.0pt;font-family:&q=
uot;Calibri&quot;,sans-serif;color:black">:</span></b><span style=3D"font-s=
ize:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Yu, Xia=
ngliang<br>
</span><b><span lang=3D"ZH-CN" style=3D"font-size:11.0pt;color:black">=B3=
=AD=CB=CD</span></b><b><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black">:</span></b><span style=3D"font-size:11=
.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> amd-gfx list;
 dl.SRDC_SW_GPUVirtualization; Min, Frank; Liu, Monk<br>
</span><b><span lang=3D"ZH-CN" style=3D"font-size:11.0pt;color:black">=D6=
=F7=CC=E2</span></b><b><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black">:</span></b><span style=3D"font-size:11=
.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Re: [PATCH
 21/23] drm/amdgpu: change golden register program sequence of virtualizati=
on</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt">On Sat, Dec 17, 201=
6 at 11:16 AM, Xiangliang Yu &lt;<a href=3D"mailto:Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org">X=
iangliang.Yu-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br>
&gt; GPU virtualization has different sequence from normal, change it.<br>
&gt;<br>
&gt; Signed-off-by: Frank Min &lt;<a href=3D"mailto:Frank.Min-5C7GfCeVMHo@public.gmane.org">Fran=
k.Min-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; Signed-off-by: Monk Liu &lt;<a href=3D"mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">Monk.L=
iu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; Signed-off-by: Xiangliang Yu &lt;<a href=3D"mailto:Xiangliang.Yu@amd.c=
om">Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |&nbsp;&nbsp; 2 &#43;<b=
r>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/vi.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 6 &#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/mxgpu/mxgpu_vi.c&nbsp;&nbsp;&nbsp;&nbsp; | 2=
67 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;<br>
&gt;&nbsp; 3 files changed, 275 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_virt.h<br>
&gt; index eb2905e..e781c9c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
&gt; @@ -84,4 &#43;84,6 @@ int amdgpu_put_gpu(struct amdgpu_device *adev);<=
br>
&gt;&nbsp; /* access vf registers */<br>
&gt;&nbsp; uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t re=
g);<br>
&gt;&nbsp; void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, u=
int32_t v);<br>
&gt; &#43;<br>
&gt; &#43;void amdgpu_xgpu_init_golden_registers(struct amdgpu_device *adev=
);<br>
&gt;&nbsp; #endif<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amd=
gpu/vi.c<br>
&gt; index 5229b4a2a..0d5e807 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vi.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vi.c<br>
&gt; @@ -285,6 &#43;285,12 @@ static void vi_init_golden_registers(struct a=
mdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Some of the registe=
rs might be dependent on GRBM_GFX_INDEX */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&=
gt;grbm_idx_mutex);<br>
&gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;flags &amp; AMD=
_IS_VF) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_xgpu_init_golden_registers(adev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;grbm_idx_mutex);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_=
type) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_TOPAZ:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_program_register_sequence(adev,<br>
&gt; diff --git a/drivers/gpu/drm/amd/mxgpu/mxgpu_vi.c b/drivers/gpu/drm/am=
d/mxgpu/mxgpu_vi.c<br>
&gt; index e5d517f..fa1ee8f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/mxgpu/mxgpu_vi.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/mxgpu/mxgpu_vi.c<br>
&gt; @@ -42,6 &#43;42,273 @@<br>
&gt;&nbsp; #include &quot;dce/dce_10_0_sh_mask.h&quot;<br>
&gt;&nbsp; #include &quot;smu/smu_7_1_3_d.h&quot;<br>
&gt;<br>
&gt; &#43;static const u32 xgpu_fiji_mgcg_cgcg_init[] =3D {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_CGTT_MGCG_OVERRIDE, 0x=
ffffffff, 0xffffffff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmGRBM_GFX_INDEX, 0xffffffff=
, 0xe0000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCB_CGTT_SCLK_CTRL, 0xfffff=
fff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_BCI_CLK_CTRL, 0xfffff=
fff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_CP_CLK_CTRL, 0xffffff=
ff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_CPC_CLK_CTRL, 0xfffff=
fff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_CPF_CLK_CTRL, 0xfffff=
fff, 0x40000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_DRM_CLK_CTRL0, 0xffff=
ffff, 0x00600100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_GDS_CLK_CTRL, 0xfffff=
fff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_IA_CLK_CTRL, 0xffffff=
ff, 0x06000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_PA_CLK_CTRL, 0xffffff=
ff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_WD_CLK_CTRL, 0xffffff=
ff, 0x06000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_PC_CLK_CTRL, 0xffffff=
ff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_RLC_CLK_CTRL, 0xfffff=
fff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SC_CLK_CTRL, 0xffffff=
ff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SPI_CLK_CTRL, 0xfffff=
fff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SQ_CLK_CTRL, 0xffffff=
ff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SQG_CLK_CTRL, 0xfffff=
fff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SX_CLK_CTRL0, 0xfffff=
fff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SX_CLK_CTRL1, 0xfffff=
fff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SX_CLK_CTRL2, 0xfffff=
fff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SX_CLK_CTRL3, 0xfffff=
fff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SX_CLK_CTRL4, 0xfffff=
fff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_TCI_CLK_CTRL, 0xfffff=
fff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_TCP_CLK_CTRL, 0xfffff=
fff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_VGT_CLK_CTRL, 0xfffff=
fff, 0x06000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmDB_CGTT_CLK_CTRL_0, 0xffff=
ffff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmTA_CGTT_CTRL, 0xffffffff, =
0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmTCA_CGTT_SCLK_CTRL, 0xffff=
ffff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmTCC_CGTT_SCLK_CTRL, 0xffff=
ffff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmTD_CGTT_CTRL, 0xffffffff, =
0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmGRBM_GFX_INDEX, 0xffffffff=
, 0xe0000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_SM_CTRL_REG, 0xffffff=
ff, 0x96e00200,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCP_RB_WPTR_POLL_CNTL, 0xff=
ffffff, 0x00900100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_CGCG_CGLS_CTRL, 0xffff=
ffff, 0x0020003c,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmPCIE_INDEX, 0xffffffff, 0x=
0140001c,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmPCIE_DATA, 0x000f0000, 0x0=
0000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSMC_IND_INDEX_4, 0xfffffff=
f, 0xC060000C,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSMC_IND_DATA_4, 0xc0000fff=
, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmXDMA_CLOCK_GATING_CNTL, 0x=
ffffffff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmXDMA_MEM_POWER_CNTL, 0x000=
00101, 0x00000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmMC_MEM_POWER_LS, 0xfffffff=
f, 0x00000104,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_DRM_CLK_CTRL0, 0xff00=
0fff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmHDP_XDP_CGTT_BLK_CTRL, 0xc=
0000fff, 0x00000104,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCP_MEM_SLP_CNTL, 0x0000000=
1, 0x00000001,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA0_CLK_CTRL, 0xff000ff0=
, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA1_CLK_CTRL, 0xff000ff0=
, 0x00000100,<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &#43;static const u32 xgpu_golden_settings_fiji_a10[] =3D {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCB_HW_CONTROL_3, 0x000001f=
f, 0x00000040,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmDB_DEBUG2, 0xf00fffff, 0x0=
0000400,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmDCI_CLK_CNTL, 0x00000080, =
0x00000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmFBC_DEBUG_COMP, 0x000000f0=
, 0x00000070,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmFBC_MISC, 0x1f311fff, 0x12=
300000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmHDMI_CONTROL, 0x31000111, =
0x00000011,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_SC_ENHANCE, 0xffffffff,=
 0x20000001,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_SC_LINE_STIPPLE_STATE, =
0x0000ff0f, 0x00000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA0_CHICKEN_BITS, 0xfc91=
0007, 0x00810007,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA0_GFX_IB_CNTL, 0x800f0=
111, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA0_RLC0_IB_CNTL, 0x800f=
0111, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA0_RLC1_IB_CNTL, 0x800f=
0111, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA1_CHICKEN_BITS, 0xfc91=
0007, 0x00810007,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA1_GFX_IB_CNTL, 0x800f0=
111, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA1_RLC0_IB_CNTL, 0x800f=
0111, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA1_RLC1_IB_CNTL, 0x800f=
0111, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSQ_RANDOM_WAVE_PRI, 0x001f=
ffff, 0x000006fd,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmTA_CNTL_AUX, 0x000f000f, 0=
x000b0000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmTCC_EXE_DISABLE, 0x0000000=
2, 0x00000002,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmTCP_ADDR_CONFIG, 0x000003f=
f, 0x000000ff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmVGT_RESET_DEBUG, 0x0000000=
4, 0x00000004,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_PRT_APERTURE0_LOW_ADDR,=
 0x0fffffff, 0x0fffffff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_PRT_APERTURE1_LOW_ADDR,=
 0x0fffffff, 0x0fffffff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_PRT_APERTURE2_LOW_ADDR,=
 0x0fffffff, 0x0fffffff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_PRT_APERTURE3_LOW_ADDR,=
 0x0fffffff, 0x0fffffff,<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &#43;static const u32 xgpu_fiji_golden_common_all[] =3D {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmGRBM_GFX_INDEX, 0xffffffff=
, 0xe0000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_SC_RASTER_CONFIG, 0xfff=
fffff, 0x3a00161a,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_SC_RASTER_CONFIG_1, 0xf=
fffffff, 0x0000002e,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmGB_ADDR_CONFIG, 0xffffffff=
, 0x22011003,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSPI_RESOURCE_RESERVE_CU_0,=
 0xffffffff, 0x00000800,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSPI_RESOURCE_RESERVE_CU_1,=
 0xffffffff, 0x00000800,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSPI_RESOURCE_RESERVE_EN_CU=
_0, 0xffffffff, 0x00007FBF,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSPI_RESOURCE_RESERVE_EN_CU=
_1, 0xffffffff, 0x00007FAF,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmGRBM_GFX_INDEX, 0xffffffff=
, 0xe0000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSPI_CONFIG_CNTL_1, 0x00000=
00f, 0x00000009,<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &#43;static const u32 xgpu_tonga_mgcg_cgcg_init[] =3D {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_CGTT_MGCG_OVERRIDE,&nb=
sp;&nbsp; 0xffffffff, 0xffffffff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmGRBM_GFX_INDEX,&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0xe0000000,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCB_CGTT_SCLK_CTRL,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_BCI_CLK_CTRL,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_CP_CLK_CTRL,&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_CPC_CLK_CTRL,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_CPF_CLK_CTRL,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x40000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_DRM_CLK_CTRL0,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00600100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_GDS_CLK_CTRL,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_IA_CLK_CTRL,&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x06000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_PA_CLK_CTRL,&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_WD_CLK_CTRL,&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x06000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_PC_CLK_CTRL,&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_RLC_CLK_CTRL,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SC_CLK_CTRL,&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SPI_CLK_CTRL,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SQ_CLK_CTRL,&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SQG_CLK_CTRL,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SX_CLK_CTRL0,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SX_CLK_CTRL1,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SX_CLK_CTRL2,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SX_CLK_CTRL3,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SX_CLK_CTRL4,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_TCI_CLK_CTRL,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_TCP_CLK_CTRL,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_VGT_CLK_CTRL,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x06000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmDB_CGTT_CLK_CTRL_0,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmTA_CGTT_CTRL,&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x0=
0000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmTCA_CGTT_SCLK_CTRL,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmTCC_CGTT_SCLK_CTRL,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmTD_CGTT_CTRL,&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x0=
0000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmGRBM_GFX_INDEX,&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0xe0000000,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU0_SP0_CTRL_REG,&nbs=
p;&nbsp;&nbsp; 0xffffffff, 0x00010000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU0_LDS_SQ_CTRL_REG, =
0xffffffff, 0x00030002,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU0_TA_SQC_CTRL_REG, =
0xffffffff, 0x00040007,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU0_SP1_CTRL_REG,&nbs=
p;&nbsp;&nbsp; 0xffffffff, 0x00060005,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU0_TD_TCP_CTRL_REG, =
0xffffffff, 0x00090008,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU1_SP0_CTRL_REG,&nbs=
p;&nbsp;&nbsp; 0xffffffff, 0x00010000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU1_LDS_SQ_CTRL_REG, =
0xffffffff, 0x00030002,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU1_TA_CTRL_REG,&nbsp=
;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00040007,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU1_SP1_CTRL_REG,&nbs=
p;&nbsp;&nbsp; 0xffffffff, 0x00060005,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU1_TD_TCP_CTRL_REG, =
0xffffffff, 0x00090008,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU2_SP0_CTRL_REG,&nbs=
p;&nbsp;&nbsp; 0xffffffff, 0x00010000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU2_LDS_SQ_CTRL_REG, =
0xffffffff, 0x00030002,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU2_TA_CTRL_REG,&nbsp=
;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00040007,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU2_SP1_CTRL_REG,&nbs=
p;&nbsp;&nbsp; 0xffffffff, 0x00060005,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU2_TD_TCP_CTRL_REG, =
0xffffffff, 0x00090008,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU3_SP0_CTRL_REG,&nbs=
p;&nbsp;&nbsp; 0xffffffff, 0x00010000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU3_LDS_SQ_CTRL_REG, =
0xffffffff, 0x00030002,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU3_TA_CTRL_REG,&nbsp=
;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00040007,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU3_SP1_CTRL_REG,&nbs=
p;&nbsp;&nbsp; 0xffffffff, 0x00060005,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU3_TD_TCP_CTRL_REG, =
0xffffffff, 0x00090008,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU4_SP0_CTRL_REG,&nbs=
p;&nbsp;&nbsp; 0xffffffff, 0x00010000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU4_LDS_SQ_CTRL_REG, =
0xffffffff, 0x00030002,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU4_TA_SQC_CTRL_REG, =
0xffffffff, 0x00040007,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU4_SP1_CTRL_REG,&nbs=
p;&nbsp;&nbsp; 0xffffffff, 0x00060005,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU4_TD_TCP_CTRL_REG, =
0xffffffff, 0x00090008,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU5_SP0_CTRL_REG,&nbs=
p;&nbsp;&nbsp; 0xffffffff, 0x00010000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU5_LDS_SQ_CTRL_REG, =
0xffffffff, 0x00030002,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU5_TA_CTRL_REG,&nbsp=
;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00040007,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU5_SP1_CTRL_REG,&nbs=
p;&nbsp;&nbsp; 0xffffffff, 0x00060005,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU5_TD_TCP_CTRL_REG, =
0xffffffff, 0x00090008,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU6_SP0_CTRL_REG,&nbs=
p;&nbsp;&nbsp; 0xffffffff, 0x00010000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU6_LDS_SQ_CTRL_REG, =
0xffffffff, 0x00030002,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU6_TA_CTRL_REG,&nbsp=
;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00040007,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU6_SP1_CTRL_REG,&nbs=
p;&nbsp;&nbsp; 0xffffffff, 0x00060005,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU6_TD_TCP_CTRL_REG, =
0xffffffff, 0x00090008,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU7_SP0_CTRL_REG,&nbs=
p;&nbsp;&nbsp; 0xffffffff, 0x00010000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU7_LDS_SQ_CTRL_REG, =
0xffffffff, 0x00030002,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU7_TA_CTRL_REG,&nbsp=
;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00040007,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU7_SP1_CTRL_REG,&nbs=
p;&nbsp;&nbsp; 0xffffffff, 0x00060005,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_CU7_TD_TCP_CTRL_REG, =
0xffffffff, 0x00090008,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_SM_CTRL_REG,&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x96e00200,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCP_RB_WPTR_POLL_CNTL,&nbsp=
;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00900100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_CGCG_CGLS_CTRL,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x0020003c,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmPCIE_INDEX,&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xfff=
fffff, 0x0140001c,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmPCIE_DATA,&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x000f0000, 0x00000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSMC_IND_INDEX_4,&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0xC060000C,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSMC_IND_DATA_4,&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xc0000fff, 0x00000100,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmXDMA_CLOCK_GATING_CNTL,&nb=
sp;&nbsp; 0xffffffff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmXDMA_MEM_POWER_CNTL,&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x00000101, 0x00000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmMC_MEM_POWER_LS,&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00000104,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_DRM_CLK_CTRL0,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xff000fff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmHDP_XDP_CGTT_BLK_CTRL,&nbs=
p;&nbsp;&nbsp; 0xc0000fff, 0x00000104,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCP_MEM_SLP_CNTL,&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000001, 0x00000001,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA0_CLK_CTRL,&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xff000ff0, 0x00000100,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA1_CLK_CTRL,&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xff000ff0, 0x00000100,<b=
r>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &#43;static const u32 xgpu_golden_settings_tonga_a11[] =3D {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCB_HW_CONTROL, 0xfffdf3cf,=
 0x00007208,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCB_HW_CONTROL_3, 0x0000004=
0, 0x00000040,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmDB_DEBUG2, 0xf00fffff, 0x0=
0000400,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmDCI_CLK_CNTL, 0x00000080, =
0x00000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmFBC_DEBUG_COMP, 0x000000f0=
, 0x00000070,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmFBC_MISC, 0x1f311fff, 0x12=
300000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmGB_GPU_ID, 0x0000000f, 0x0=
0000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmHDMI_CONTROL, 0x31000111, =
0x00000011,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmMC_ARB_WTM_GRPWT_RD, 0x000=
00003, 0x00000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmMC_HUB_RDREQ_DMIF_LIMIT, 0=
x0000007f, 0x00000028,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmMC_HUB_WDP_UMC, 0x00007fb6=
, 0x00000991,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_SC_ENHANCE, 0xffffffff,=
 0x20000001,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_SC_FIFO_DEPTH_CNTL, 0x0=
00003ff, 0x000000fc,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_SC_LINE_STIPPLE_STATE, =
0x0000ff0f, 0x00000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_CGCG_CGLS_CTRL, 0x0000=
0003, 0x0000003c,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA0_CHICKEN_BITS, 0xfc91=
0007, 0x00810007,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA0_CLK_CTRL, 0xff000fff=
, 0x00000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA0_GFX_IB_CNTL, 0x800f0=
111, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA0_RLC0_IB_CNTL, 0x800f=
0111, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA0_RLC1_IB_CNTL, 0x800f=
0111, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA1_CHICKEN_BITS, 0xfc91=
0007, 0x00810007,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA1_CLK_CTRL, 0xff000fff=
, 0x00000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA1_GFX_IB_CNTL, 0x800f0=
111, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA1_RLC0_IB_CNTL, 0x800f=
0111, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA1_RLC1_IB_CNTL, 0x800f=
0111, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSQ_RANDOM_WAVE_PRI, 0x001f=
ffff, 0x000006fd,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmTA_CNTL_AUX, 0x000f000f, 0=
x000b0000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmTCC_CTRL, 0x00100000, 0xf3=
1fff7f,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmTCC_EXE_DISABLE, 0x0000000=
2, 0x00000002,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmTCP_ADDR_CONFIG, 0x000003f=
f, 0x000002fb,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmTCP_CHAN_STEER_HI, 0xfffff=
fff, 0x0000543b,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmTCP_CHAN_STEER_LO, 0xfffff=
fff, 0xa9210876,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmVGT_RESET_DEBUG, 0x0000000=
4, 0x00000004,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_PRT_APERTURE0_LOW_ADDR,=
 0x0fffffff, 0x0fffffff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_PRT_APERTURE1_LOW_ADDR,=
 0x0fffffff, 0x0fffffff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_PRT_APERTURE2_LOW_ADDR,=
 0x0fffffff, 0x0fffffff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_PRT_APERTURE3_LOW_ADDR,=
 0x0fffffff, 0x0fffffff,<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &#43;static const u32 xgpu_tonga_golden_common_all[] =3D {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmGRBM_GFX_INDEX,&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0=
xffffffff, 0xe0000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_SC_RASTER_CONFIG,&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x16000012,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_SC_RASTER_CONFIG_1,&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffffffff, 0x0000002A,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmGB_ADDR_CONFIG,&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0=
xffffffff, 0x22011002,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSPI_RESOURCE_RESERVE_CU_0,=
&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00000800,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSPI_RESOURCE_RESERVE_CU_1,=
&nbsp;&nbsp;&nbsp; 0xffffffff, 0x00000800,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSPI_RESOURCE_RESERVE_EN_CU=
_0, 0xffffffff, 0x00007FBF,<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &#43;void amdgpu_xgpu_init_golden_registers(struct amdgpu_device *adev=
)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) =
{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_FIJI:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_program_register_sequence(adev,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xgpu_fi=
ji_mgcg_cgcg_init,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const =
u32)ARRAY_SIZE(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xgpu_fi=
ji_mgcg_cgcg_init));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_program_register_sequence(adev,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xgpu_go=
lden_settings_fiji_a10,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const =
u32)ARRAY_SIZE(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xgpu_go=
lden_settings_fiji_a10));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_program_register_sequence(adev,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xgpu_fi=
ji_golden_common_all,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const =
u32)ARRAY_SIZE(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xgpu_fi=
ji_golden_common_all));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_TONGA:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_program_register_sequence(adev,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xgpu_to=
nga_mgcg_cgcg_init,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const =
u32)ARRAY_SIZE(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xgpu_to=
nga_mgcg_cgcg_init));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_program_register_sequence(adev,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xgpu_go=
lden_settings_tonga_a11,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const =
u32)ARRAY_SIZE(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xgpu_go=
lden_settings_tonga_a11));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_program_register_sequence(adev,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xgpu_to=
nga_golden_common_all,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const =
u32)ARRAY_SIZE(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xgpu_to=
nga_golden_common_all));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;}<br>
<br>
Cleaner to just put this in vi.c.<br>
<br>
Alex<br>
<br>
&gt; &#43;<br>
&gt;&nbsp; static int xgpu_vi_early_init(void *handle)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *=
adev =3D (struct amdgpu_device *)handle;<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org=
ktop.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></span></=
p>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB17013C9CFD61372FC7375D45EB900CY4PR12MB1701namp_--

--===============1678306192==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1678306192==--
