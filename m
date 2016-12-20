From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 21/23] drm/amdgpu: change golden register program sequence
 of virtualization
Date: Tue, 20 Dec 2016 13:50:17 +0000
Message-ID: <BN6PR12MB1652C93B278BF7B731612169F7900@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1481991405-30422-1-git-send-email-Xiangliang.Yu@amd.com>
 <1481991405-30422-22-git-send-email-Xiangliang.Yu@amd.com>,
 <CADnq5_PqscSCAOGn+suNGkoUQdF5Z7O69wrL_CvH27hfKE4b0A@mail.gmail.com>
 <BY2PR12MB005449FC3CC2D91B41B3487884900@BY2PR12MB0054.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0965081352=="
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Yu,
 Xiangliang" <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Cc: "dl.SRDC_SW_GPUVirtualization" <dl.SRDC_SW_GPUVirtualization-5C7GfCeVMHo@public.gmane.org>, "Min,
 Frank" <Frank.Min-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0965081352==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1652C93B278BF7B731612169F7900BN6PR12MB1652namp_"

--_000_BN6PR12MB1652C93B278BF7B731612169F7900BN6PR12MB1652namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SSBkb24ndCBtaW5kIGtlZXBpbmcgdGhlIGxpc3QgdG9nZXRoZXIuDQoNCkFsZXgNCg0KRnJvbTog
YW1kLWdmeCBbbWFpbHRvOmFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmddIE9u
IEJlaGFsZiBPZiBMaXUsIE1vbmsNClNlbnQ6IE1vbmRheSwgRGVjZW1iZXIgMTksIDIwMTYgMTE6
MDkgUE0NClRvOiBBbGV4IERldWNoZXI7IFl1LCBYaWFuZ2xpYW5nDQpDYzogTWluLCBGcmFuazsg
ZGwuU1JEQ19TV19HUFVWaXJ0dWFsaXphdGlvbjsgYW1kLWdmeCBsaXN0DQpTdWJqZWN0OiC08Li0
OiBbUEFUQ0ggMjEvMjNdIGRybS9hbWRncHU6IGNoYW5nZSBnb2xkZW4gcmVnaXN0ZXIgcHJvZ3Jh
bSBzZXF1ZW5jZSBvZiB2aXJ0dWFsaXphdGlvbg0KDQoNCkhpIEFsZXgNCg0KDQoNCkkgYWdyZWUg
d2l0aCB5b3UgdGhhdCB0aGlzIHBhdGNoJ3MgR09MREVOIHNldHRpbmcgcHJvZ3JhbW1pbmcgc2hv
dWxkIGJlIHB1dCBpbiBWSS5DLCBidXQgSSBmb3VuZCBhIGhhcmR3YXJlIGlzc3VlIDoNCg0KDQoN
Cm9yaWdpbmFsIGxpbnV4IGxvZ2ljIGlzIHRoYXQgd2Ugc2V0IGdvbGRlbiBzZXR0aW5nIHJlZ2lz
dGVycyBzZXBhcmF0ZWx5IHdpdGhpbiBlYWNoIElQJ3MgaHcgaW5pdCByb3V0aW5lLCBidXQgZm9y
IFRPTkdBIFZGLCBpdCBpcyByZWFsbHkgc3RyYW5nZSB0aGF0IHdlIG11c3Qgc2V0IGFsbCBHT0xE
RU4gc2V0dGluZyB2YWx1ZSB0byBjaGlwIGluIG9uZSBzaG9vdCAobWVhbnMgd2UgdXNlIG9uZSBy
b3V0aW5lIHRvIHByb2dyYW1pbmcgYWxsIElQJ3MgZ29sZGVuIHNldHRpbmcgdG8gcmVnaXN0ZXJz
KSwgb3J0aGVyd2lzZSB3ZSBmb3VuZCBUT05HQSB2ZiAganVzdCBmYWlsZWQgaW4gUklORyBURVNU
Lg0KDQoNCg0KYW5kIEkgYWRtaXQgSSBkb24ndCBrbm93IHdoeSAoSSBjaGVja2VkIHdpbmRvd3Mg
Q0FJTCBjb2RlLCBpdCBpcyBhbHNvIHNldCBhbGwgZ29sZGVuIHNldHRpbmcgcmVnaXN0ZXJzIGlu
IG9uZSByb3V0aW5lKQ0KDQoNCg0KQlIgTW9uaw0KDQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXw0Kt6K8/sjLOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbTxtYWls
dG86YWxleGRldWNoZXJAZ21haWwuY29tPj4NCreiy83KsbzkOiAyMDE2xOoxMtTCMjDI1SA3OjM3
OjA2DQrK1bz+yMs6IFl1LCBYaWFuZ2xpYW5nDQqzrcvNOiBhbWQtZ2Z4IGxpc3Q7IGRsLlNSRENf
U1dfR1BVVmlydHVhbGl6YXRpb247IE1pbiwgRnJhbms7IExpdSwgTW9uaw0K1vfM4jogUmU6IFtQ
QVRDSCAyMS8yM10gZHJtL2FtZGdwdTogY2hhbmdlIGdvbGRlbiByZWdpc3RlciBwcm9ncmFtIHNl
cXVlbmNlIG9mIHZpcnR1YWxpemF0aW9uDQoNCk9uIFNhdCwgRGVjIDE3LCAyMDE2IGF0IDExOjE2
IEFNLCBYaWFuZ2xpYW5nIFl1IDxYaWFuZ2xpYW5nLll1QGFtZC5jb208bWFpbHRvOlhpYW5nbGlh
bmcuWXVAYW1kLmNvbT4+IHdyb3RlOg0KPiBHUFUgdmlydHVhbGl6YXRpb24gaGFzIGRpZmZlcmVu
dCBzZXF1ZW5jZSBmcm9tIG5vcm1hbCwgY2hhbmdlIGl0Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBG
cmFuayBNaW4gPEZyYW5rLk1pbkBhbWQuY29tPG1haWx0bzpGcmFuay5NaW5AYW1kLmNvbT4+DQo+
IFNpZ25lZC1vZmYtYnk6IE1vbmsgTGl1IDxNb25rLkxpdUBhbWQuY29tPG1haWx0bzpNb25rLkxp
dUBhbWQuY29tPj4NCj4gU2lnbmVkLW9mZi1ieTogWGlhbmdsaWFuZyBZdSA8WGlhbmdsaWFuZy5Z
dUBhbWQuY29tPG1haWx0bzpYaWFuZ2xpYW5nLll1QGFtZC5jb20+Pg0KPiAtLS0NCj4gIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0LmggfCAgIDIgKw0KPiAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvdmkuYyAgICAgICAgICB8ICAgNiArDQo+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL214Z3B1L214Z3B1X3ZpLmMgICAgIHwgMjY3ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwgMjc1IGluc2VydGlvbnMoKykNCj4NCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0LmggYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5oDQo+IGluZGV4IGViMjkwNWUuLmU3
ODFjOWMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
aXJ0LmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuaA0K
PiBAQCAtODQsNCArODQsNiBAQCBpbnQgYW1kZ3B1X3B1dF9ncHUoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpOw0KPiAgLyogYWNjZXNzIHZmIHJlZ2lzdGVycyAqLw0KPiAgdWludDMyX3QgYW1k
Z3B1X2tpcV9ycmVnKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1aW50MzJfdCByZWcpOw0K
PiAgdm9pZCBhbWRncHVfa2lxX3dyZWcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQz
Ml90IHJlZywgdWludDMyX3Qgdik7DQo+ICsNCj4gK3ZvaWQgYW1kZ3B1X3hncHVfaW5pdF9nb2xk
ZW5fcmVnaXN0ZXJzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsNCj4gICNlbmRpZg0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmkuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3ZpLmMNCj4gaW5kZXggNTIyOWI0YTJhLi4wZDVlODA3IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92aS5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmMNCj4gQEAgLTI4NSw2ICsyODUsMTIgQEAgc3RhdGljIHZv
aWQgdmlfaW5pdF9nb2xkZW5fcmVnaXN0ZXJzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0K
PiAgICAgICAgIC8qIFNvbWUgb2YgdGhlIHJlZ2lzdGVycyBtaWdodCBiZSBkZXBlbmRlbnQgb24g
R1JCTV9HRlhfSU5ERVggKi8NCj4gICAgICAgICBtdXRleF9sb2NrKCZhZGV2LT5ncmJtX2lkeF9t
dXRleCk7DQo+DQo+ICsgICAgICAgaWYgKGFkZXYtPmZsYWdzICYgQU1EX0lTX1ZGKSB7DQo+ICsg
ICAgICAgICAgICAgICBhbWRncHVfeGdwdV9pbml0X2dvbGRlbl9yZWdpc3RlcnMoYWRldik7DQo+
ICsgICAgICAgICAgICAgICBtdXRleF91bmxvY2soJmFkZXYtPmdyYm1faWR4X211dGV4KTsNCj4g
KyAgICAgICAgICAgICAgIHJldHVybjsNCj4gKyAgICAgICB9DQo+ICsNCj4gICAgICAgICBzd2l0
Y2ggKGFkZXYtPmFzaWNfdHlwZSkgew0KPiAgICAgICAgIGNhc2UgQ0hJUF9UT1BBWjoNCj4gICAg
ICAgICAgICAgICAgIGFtZGdwdV9wcm9ncmFtX3JlZ2lzdGVyX3NlcXVlbmNlKGFkZXYsDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL214Z3B1L214Z3B1X3ZpLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL214Z3B1L214Z3B1X3ZpLmMNCj4gaW5kZXggZTVkNTE3Zi4uZmExZWU4ZiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9teGdwdS9teGdwdV92aS5jDQo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvbXhncHUvbXhncHVfdmkuYw0KPiBAQCAtNDIsNiArNDIs
MjczIEBADQo+ICAjaW5jbHVkZSAiZGNlL2RjZV8xMF8wX3NoX21hc2suaCINCj4gICNpbmNsdWRl
ICJzbXUvc211XzdfMV8zX2QuaCINCj4NCj4gK3N0YXRpYyBjb25zdCB1MzIgeGdwdV9maWppX21n
Y2dfY2djZ19pbml0W10gPSB7DQo+ICsgICAgICAgbW1STENfQ0dUVF9NR0NHX09WRVJSSURFLCAw
eGZmZmZmZmZmLCAweGZmZmZmZmZmLA0KPiArICAgICAgIG1tR1JCTV9HRlhfSU5ERVgsIDB4ZmZm
ZmZmZmYsIDB4ZTAwMDAwMDAsDQo+ICsgICAgICAgbW1DQl9DR1RUX1NDTEtfQ1RSTCwgMHhmZmZm
ZmZmZiwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbUNHVFRfQkNJX0NMS19DVFJMLCAweGZmZmZm
ZmZmLCAweDAwMDAwMTAwLA0KPiArICAgICAgIG1tQ0dUVF9DUF9DTEtfQ1RSTCwgMHhmZmZmZmZm
ZiwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbUNHVFRfQ1BDX0NMS19DVFJMLCAweGZmZmZmZmZm
LCAweDAwMDAwMTAwLA0KPiArICAgICAgIG1tQ0dUVF9DUEZfQ0xLX0NUUkwsIDB4ZmZmZmZmZmYs
IDB4NDAwMDAxMDAsDQo+ICsgICAgICAgbW1DR1RUX0RSTV9DTEtfQ1RSTDAsIDB4ZmZmZmZmZmYs
IDB4MDA2MDAxMDAsDQo+ICsgICAgICAgbW1DR1RUX0dEU19DTEtfQ1RSTCwgMHhmZmZmZmZmZiwg
MHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbUNHVFRfSUFfQ0xLX0NUUkwsIDB4ZmZmZmZmZmYsIDB4
MDYwMDAxMDAsDQo+ICsgICAgICAgbW1DR1RUX1BBX0NMS19DVFJMLCAweGZmZmZmZmZmLCAweDAw
MDAwMTAwLA0KPiArICAgICAgIG1tQ0dUVF9XRF9DTEtfQ1RSTCwgMHhmZmZmZmZmZiwgMHgwNjAw
MDEwMCwNCj4gKyAgICAgICBtbUNHVFRfUENfQ0xLX0NUUkwsIDB4ZmZmZmZmZmYsIDB4MDAwMDAx
MDAsDQo+ICsgICAgICAgbW1DR1RUX1JMQ19DTEtfQ1RSTCwgMHhmZmZmZmZmZiwgMHgwMDAwMDEw
MCwNCj4gKyAgICAgICBtbUNHVFRfU0NfQ0xLX0NUUkwsIDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAs
DQo+ICsgICAgICAgbW1DR1RUX1NQSV9DTEtfQ1RSTCwgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwN
Cj4gKyAgICAgICBtbUNHVFRfU1FfQ0xLX0NUUkwsIDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAsDQo+
ICsgICAgICAgbW1DR1RUX1NRR19DTEtfQ1RSTCwgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwNCj4g
KyAgICAgICBtbUNHVFRfU1hfQ0xLX0NUUkwwLCAweGZmZmZmZmZmLCAweDAwMDAwMTAwLA0KPiAr
ICAgICAgIG1tQ0dUVF9TWF9DTEtfQ1RSTDEsIDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAsDQo+ICsg
ICAgICAgbW1DR1RUX1NYX0NMS19DVFJMMiwgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwNCj4gKyAg
ICAgICBtbUNHVFRfU1hfQ0xLX0NUUkwzLCAweGZmZmZmZmZmLCAweDAwMDAwMTAwLA0KPiArICAg
ICAgIG1tQ0dUVF9TWF9DTEtfQ1RSTDQsIDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAsDQo+ICsgICAg
ICAgbW1DR1RUX1RDSV9DTEtfQ1RSTCwgMHhmZmZmZmZmZiwgMHgwMDAwMDEwMCwNCj4gKyAgICAg
ICBtbUNHVFRfVENQX0NMS19DVFJMLCAweGZmZmZmZmZmLCAweDAwMDAwMTAwLA0KPiArICAgICAg
IG1tQ0dUVF9WR1RfQ0xLX0NUUkwsIDB4ZmZmZmZmZmYsIDB4MDYwMDAxMDAsDQo+ICsgICAgICAg
bW1EQl9DR1RUX0NMS19DVFJMXzAsIDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAsDQo+ICsgICAgICAg
bW1UQV9DR1RUX0NUUkwsIDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAsDQo+ICsgICAgICAgbW1UQ0Ff
Q0dUVF9TQ0xLX0NUUkwsIDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAsDQo+ICsgICAgICAgbW1UQ0Nf
Q0dUVF9TQ0xLX0NUUkwsIDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAsDQo+ICsgICAgICAgbW1URF9D
R1RUX0NUUkwsIDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAsDQo+ICsgICAgICAgbW1HUkJNX0dGWF9J
TkRFWCwgMHhmZmZmZmZmZiwgMHhlMDAwMDAwMCwNCj4gKyAgICAgICBtbUNHVFNfU01fQ1RSTF9S
RUcsIDB4ZmZmZmZmZmYsIDB4OTZlMDAyMDAsDQo+ICsgICAgICAgbW1DUF9SQl9XUFRSX1BPTExf
Q05UTCwgMHhmZmZmZmZmZiwgMHgwMDkwMDEwMCwNCj4gKyAgICAgICBtbVJMQ19DR0NHX0NHTFNf
Q1RSTCwgMHhmZmZmZmZmZiwgMHgwMDIwMDAzYywNCj4gKyAgICAgICBtbVBDSUVfSU5ERVgsIDB4
ZmZmZmZmZmYsIDB4MDE0MDAwMWMsDQo+ICsgICAgICAgbW1QQ0lFX0RBVEEsIDB4MDAwZjAwMDAs
IDB4MDAwMDAwMDAsDQo+ICsgICAgICAgbW1TTUNfSU5EX0lOREVYXzQsIDB4ZmZmZmZmZmYsIDB4
QzA2MDAwMEMsDQo+ICsgICAgICAgbW1TTUNfSU5EX0RBVEFfNCwgMHhjMDAwMGZmZiwgMHgwMDAw
MDEwMCwNCj4gKyAgICAgICBtbVhETUFfQ0xPQ0tfR0FUSU5HX0NOVEwsIDB4ZmZmZmZmZmYsIDB4
MDAwMDAxMDAsDQo+ICsgICAgICAgbW1YRE1BX01FTV9QT1dFUl9DTlRMLCAweDAwMDAwMTAxLCAw
eDAwMDAwMDAwLA0KPiArICAgICAgIG1tTUNfTUVNX1BPV0VSX0xTLCAweGZmZmZmZmZmLCAweDAw
MDAwMTA0LA0KPiArICAgICAgIG1tQ0dUVF9EUk1fQ0xLX0NUUkwwLCAweGZmMDAwZmZmLCAweDAw
MDAwMTAwLA0KPiArICAgICAgIG1tSERQX1hEUF9DR1RUX0JMS19DVFJMLCAweGMwMDAwZmZmLCAw
eDAwMDAwMTA0LA0KPiArICAgICAgIG1tQ1BfTUVNX1NMUF9DTlRMLCAweDAwMDAwMDAxLCAweDAw
MDAwMDAxLA0KPiArICAgICAgIG1tU0RNQTBfQ0xLX0NUUkwsIDB4ZmYwMDBmZjAsIDB4MDAwMDAx
MDAsDQo+ICsgICAgICAgbW1TRE1BMV9DTEtfQ1RSTCwgMHhmZjAwMGZmMCwgMHgwMDAwMDEwMCwN
Cj4gK307DQo+ICsNCj4gK3N0YXRpYyBjb25zdCB1MzIgeGdwdV9nb2xkZW5fc2V0dGluZ3NfZmlq
aV9hMTBbXSA9IHsNCj4gKyAgICAgICBtbUNCX0hXX0NPTlRST0xfMywgMHgwMDAwMDFmZiwgMHgw
MDAwMDA0MCwNCj4gKyAgICAgICBtbURCX0RFQlVHMiwgMHhmMDBmZmZmZiwgMHgwMDAwMDQwMCwN
Cj4gKyAgICAgICBtbURDSV9DTEtfQ05UTCwgMHgwMDAwMDA4MCwgMHgwMDAwMDAwMCwNCj4gKyAg
ICAgICBtbUZCQ19ERUJVR19DT01QLCAweDAwMDAwMGYwLCAweDAwMDAwMDcwLA0KPiArICAgICAg
IG1tRkJDX01JU0MsIDB4MWYzMTFmZmYsIDB4MTIzMDAwMDAsDQo+ICsgICAgICAgbW1IRE1JX0NP
TlRST0wsIDB4MzEwMDAxMTEsIDB4MDAwMDAwMTEsDQo+ICsgICAgICAgbW1QQV9TQ19FTkhBTkNF
LCAweGZmZmZmZmZmLCAweDIwMDAwMDAxLA0KPiArICAgICAgIG1tUEFfU0NfTElORV9TVElQUExF
X1NUQVRFLCAweDAwMDBmZjBmLCAweDAwMDAwMDAwLA0KPiArICAgICAgIG1tU0RNQTBfQ0hJQ0tF
Tl9CSVRTLCAweGZjOTEwMDA3LCAweDAwODEwMDA3LA0KPiArICAgICAgIG1tU0RNQTBfR0ZYX0lC
X0NOVEwsIDB4ODAwZjAxMTEsIDB4MDAwMDAxMDAsDQo+ICsgICAgICAgbW1TRE1BMF9STEMwX0lC
X0NOVEwsIDB4ODAwZjAxMTEsIDB4MDAwMDAxMDAsDQo+ICsgICAgICAgbW1TRE1BMF9STEMxX0lC
X0NOVEwsIDB4ODAwZjAxMTEsIDB4MDAwMDAxMDAsDQo+ICsgICAgICAgbW1TRE1BMV9DSElDS0VO
X0JJVFMsIDB4ZmM5MTAwMDcsIDB4MDA4MTAwMDcsDQo+ICsgICAgICAgbW1TRE1BMV9HRlhfSUJf
Q05UTCwgMHg4MDBmMDExMSwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbVNETUExX1JMQzBfSUJf
Q05UTCwgMHg4MDBmMDExMSwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbVNETUExX1JMQzFfSUJf
Q05UTCwgMHg4MDBmMDExMSwgMHgwMDAwMDEwMCwNCj4gKyAgICAgICBtbVNRX1JBTkRPTV9XQVZF
X1BSSSwgMHgwMDFmZmZmZiwgMHgwMDAwMDZmZCwNCj4gKyAgICAgICBtbVRBX0NOVExfQVVYLCAw
eDAwMGYwMDBmLCAweDAwMGIwMDAwLA0KPiArICAgICAgIG1tVENDX0VYRV9ESVNBQkxFLCAweDAw
MDAwMDAyLCAweDAwMDAwMDAyLA0KPiArICAgICAgIG1tVENQX0FERFJfQ09ORklHLCAweDAwMDAw
M2ZmLCAweDAwMDAwMGZmLA0KPiArICAgICAgIG1tVkdUX1JFU0VUX0RFQlVHLCAweDAwMDAwMDA0
LCAweDAwMDAwMDA0LA0KPiArICAgICAgIG1tVk1fUFJUX0FQRVJUVVJFMF9MT1dfQUREUiwgMHgw
ZmZmZmZmZiwgMHgwZmZmZmZmZiwNCj4gKyAgICAgICBtbVZNX1BSVF9BUEVSVFVSRTFfTE9XX0FE
RFIsIDB4MGZmZmZmZmYsIDB4MGZmZmZmZmYsDQo+ICsgICAgICAgbW1WTV9QUlRfQVBFUlRVUkUy
X0xPV19BRERSLCAweDBmZmZmZmZmLCAweDBmZmZmZmZmLA0KPiArICAgICAgIG1tVk1fUFJUX0FQ
RVJUVVJFM19MT1dfQUREUiwgMHgwZmZmZmZmZiwgMHgwZmZmZmZmZiwNCj4gK307DQo+ICsNCj4g
K3N0YXRpYyBjb25zdCB1MzIgeGdwdV9maWppX2dvbGRlbl9jb21tb25fYWxsW10gPSB7DQo+ICsg
ICAgICAgbW1HUkJNX0dGWF9JTkRFWCwgMHhmZmZmZmZmZiwgMHhlMDAwMDAwMCwNCj4gKyAgICAg
ICBtbVBBX1NDX1JBU1RFUl9DT05GSUcsIDB4ZmZmZmZmZmYsIDB4M2EwMDE2MWEsDQo+ICsgICAg
ICAgbW1QQV9TQ19SQVNURVJfQ09ORklHXzEsIDB4ZmZmZmZmZmYsIDB4MDAwMDAwMmUsDQo+ICsg
ICAgICAgbW1HQl9BRERSX0NPTkZJRywgMHhmZmZmZmZmZiwgMHgyMjAxMTAwMywNCj4gKyAgICAg
ICBtbVNQSV9SRVNPVVJDRV9SRVNFUlZFX0NVXzAsIDB4ZmZmZmZmZmYsIDB4MDAwMDA4MDAsDQo+
ICsgICAgICAgbW1TUElfUkVTT1VSQ0VfUkVTRVJWRV9DVV8xLCAweGZmZmZmZmZmLCAweDAwMDAw
ODAwLA0KPiArICAgICAgIG1tU1BJX1JFU09VUkNFX1JFU0VSVkVfRU5fQ1VfMCwgMHhmZmZmZmZm
ZiwgMHgwMDAwN0ZCRiwNCj4gKyAgICAgICBtbVNQSV9SRVNPVVJDRV9SRVNFUlZFX0VOX0NVXzEs
IDB4ZmZmZmZmZmYsIDB4MDAwMDdGQUYsDQo+ICsgICAgICAgbW1HUkJNX0dGWF9JTkRFWCwgMHhm
ZmZmZmZmZiwgMHhlMDAwMDAwMCwNCj4gKyAgICAgICBtbVNQSV9DT05GSUdfQ05UTF8xLCAweDAw
MDAwMDBmLCAweDAwMDAwMDA5LA0KPiArfTsNCj4gKw0KPiArc3RhdGljIGNvbnN0IHUzMiB4Z3B1
X3RvbmdhX21nY2dfY2djZ19pbml0W10gPSB7DQo+ICsgICAgICAgbW1STENfQ0dUVF9NR0NHX09W
RVJSSURFLCAgIDB4ZmZmZmZmZmYsIDB4ZmZmZmZmZmYsDQo+ICsgICAgICAgbW1HUkJNX0dGWF9J
TkRFWCwgICAgICAgICAgIDB4ZmZmZmZmZmYsIDB4ZTAwMDAwMDAsDQo+ICsgICAgICAgbW1DQl9D
R1RUX1NDTEtfQ1RSTCwgICAgICAgIDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAsDQo+ICsgICAgICAg
bW1DR1RUX0JDSV9DTEtfQ1RSTCwgICAgICAgIDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAsDQo+ICsg
ICAgICAgbW1DR1RUX0NQX0NMS19DVFJMLCAgICAgICAgIDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAs
DQo+ICsgICAgICAgbW1DR1RUX0NQQ19DTEtfQ1RSTCwgICAgICAgIDB4ZmZmZmZmZmYsIDB4MDAw
MDAxMDAsDQo+ICsgICAgICAgbW1DR1RUX0NQRl9DTEtfQ1RSTCwgICAgICAgIDB4ZmZmZmZmZmYs
IDB4NDAwMDAxMDAsDQo+ICsgICAgICAgbW1DR1RUX0RSTV9DTEtfQ1RSTDAsICAgICAgIDB4ZmZm
ZmZmZmYsIDB4MDA2MDAxMDAsDQo+ICsgICAgICAgbW1DR1RUX0dEU19DTEtfQ1RSTCwgICAgICAg
IDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAsDQo+ICsgICAgICAgbW1DR1RUX0lBX0NMS19DVFJMLCAg
ICAgICAgIDB4ZmZmZmZmZmYsIDB4MDYwMDAxMDAsDQo+ICsgICAgICAgbW1DR1RUX1BBX0NMS19D
VFJMLCAgICAgICAgIDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAsDQo+ICsgICAgICAgbW1DR1RUX1dE
X0NMS19DVFJMLCAgICAgICAgIDB4ZmZmZmZmZmYsIDB4MDYwMDAxMDAsDQo+ICsgICAgICAgbW1D
R1RUX1BDX0NMS19DVFJMLCAgICAgICAgIDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAsDQo+ICsgICAg
ICAgbW1DR1RUX1JMQ19DTEtfQ1RSTCwgICAgICAgIDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAsDQo+
ICsgICAgICAgbW1DR1RUX1NDX0NMS19DVFJMLCAgICAgICAgIDB4ZmZmZmZmZmYsIDB4MDAwMDAx
MDAsDQo+ICsgICAgICAgbW1DR1RUX1NQSV9DTEtfQ1RSTCwgICAgICAgIDB4ZmZmZmZmZmYsIDB4
MDAwMDAxMDAsDQo+ICsgICAgICAgbW1DR1RUX1NRX0NMS19DVFJMLCAgICAgICAgIDB4ZmZmZmZm
ZmYsIDB4MDAwMDAxMDAsDQo+ICsgICAgICAgbW1DR1RUX1NRR19DTEtfQ1RSTCwgICAgICAgIDB4
ZmZmZmZmZmYsIDB4MDAwMDAxMDAsDQo+ICsgICAgICAgbW1DR1RUX1NYX0NMS19DVFJMMCwgICAg
ICAgIDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAsDQo+ICsgICAgICAgbW1DR1RUX1NYX0NMS19DVFJM
MSwgICAgICAgIDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAsDQo+ICsgICAgICAgbW1DR1RUX1NYX0NM
S19DVFJMMiwgICAgICAgIDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAsDQo+ICsgICAgICAgbW1DR1RU
X1NYX0NMS19DVFJMMywgICAgICAgIDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAsDQo+ICsgICAgICAg
bW1DR1RUX1NYX0NMS19DVFJMNCwgICAgICAgIDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAsDQo+ICsg
ICAgICAgbW1DR1RUX1RDSV9DTEtfQ1RSTCwgICAgICAgIDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAs
DQo+ICsgICAgICAgbW1DR1RUX1RDUF9DTEtfQ1RSTCwgICAgICAgIDB4ZmZmZmZmZmYsIDB4MDAw
MDAxMDAsDQo+ICsgICAgICAgbW1DR1RUX1ZHVF9DTEtfQ1RSTCwgICAgICAgIDB4ZmZmZmZmZmYs
IDB4MDYwMDAxMDAsDQo+ICsgICAgICAgbW1EQl9DR1RUX0NMS19DVFJMXzAsICAgICAgIDB4ZmZm
ZmZmZmYsIDB4MDAwMDAxMDAsDQo+ICsgICAgICAgbW1UQV9DR1RUX0NUUkwsICAgICAgICAgICAg
IDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAsDQo+ICsgICAgICAgbW1UQ0FfQ0dUVF9TQ0xLX0NUUkws
ICAgICAgIDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAsDQo+ICsgICAgICAgbW1UQ0NfQ0dUVF9TQ0xL
X0NUUkwsICAgICAgIDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAsDQo+ICsgICAgICAgbW1URF9DR1RU
X0NUUkwsICAgICAgICAgICAgIDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAsDQo+ICsgICAgICAgbW1H
UkJNX0dGWF9JTkRFWCwgICAgICAgICAgIDB4ZmZmZmZmZmYsIDB4ZTAwMDAwMDAsDQo+ICsgICAg
ICAgbW1DR1RTX0NVMF9TUDBfQ1RSTF9SRUcsICAgIDB4ZmZmZmZmZmYsIDB4MDAwMTAwMDAsDQo+
ICsgICAgICAgbW1DR1RTX0NVMF9MRFNfU1FfQ1RSTF9SRUcsIDB4ZmZmZmZmZmYsIDB4MDAwMzAw
MDIsDQo+ICsgICAgICAgbW1DR1RTX0NVMF9UQV9TUUNfQ1RSTF9SRUcsIDB4ZmZmZmZmZmYsIDB4
MDAwNDAwMDcsDQo+ICsgICAgICAgbW1DR1RTX0NVMF9TUDFfQ1RSTF9SRUcsICAgIDB4ZmZmZmZm
ZmYsIDB4MDAwNjAwMDUsDQo+ICsgICAgICAgbW1DR1RTX0NVMF9URF9UQ1BfQ1RSTF9SRUcsIDB4
ZmZmZmZmZmYsIDB4MDAwOTAwMDgsDQo+ICsgICAgICAgbW1DR1RTX0NVMV9TUDBfQ1RSTF9SRUcs
ICAgIDB4ZmZmZmZmZmYsIDB4MDAwMTAwMDAsDQo+ICsgICAgICAgbW1DR1RTX0NVMV9MRFNfU1Ff
Q1RSTF9SRUcsIDB4ZmZmZmZmZmYsIDB4MDAwMzAwMDIsDQo+ICsgICAgICAgbW1DR1RTX0NVMV9U
QV9DVFJMX1JFRywgICAgIDB4ZmZmZmZmZmYsIDB4MDAwNDAwMDcsDQo+ICsgICAgICAgbW1DR1RT
X0NVMV9TUDFfQ1RSTF9SRUcsICAgIDB4ZmZmZmZmZmYsIDB4MDAwNjAwMDUsDQo+ICsgICAgICAg
bW1DR1RTX0NVMV9URF9UQ1BfQ1RSTF9SRUcsIDB4ZmZmZmZmZmYsIDB4MDAwOTAwMDgsDQo+ICsg
ICAgICAgbW1DR1RTX0NVMl9TUDBfQ1RSTF9SRUcsICAgIDB4ZmZmZmZmZmYsIDB4MDAwMTAwMDAs
DQo+ICsgICAgICAgbW1DR1RTX0NVMl9MRFNfU1FfQ1RSTF9SRUcsIDB4ZmZmZmZmZmYsIDB4MDAw
MzAwMDIsDQo+ICsgICAgICAgbW1DR1RTX0NVMl9UQV9DVFJMX1JFRywgICAgIDB4ZmZmZmZmZmYs
IDB4MDAwNDAwMDcsDQo+ICsgICAgICAgbW1DR1RTX0NVMl9TUDFfQ1RSTF9SRUcsICAgIDB4ZmZm
ZmZmZmYsIDB4MDAwNjAwMDUsDQo+ICsgICAgICAgbW1DR1RTX0NVMl9URF9UQ1BfQ1RSTF9SRUcs
IDB4ZmZmZmZmZmYsIDB4MDAwOTAwMDgsDQo+ICsgICAgICAgbW1DR1RTX0NVM19TUDBfQ1RSTF9S
RUcsICAgIDB4ZmZmZmZmZmYsIDB4MDAwMTAwMDAsDQo+ICsgICAgICAgbW1DR1RTX0NVM19MRFNf
U1FfQ1RSTF9SRUcsIDB4ZmZmZmZmZmYsIDB4MDAwMzAwMDIsDQo+ICsgICAgICAgbW1DR1RTX0NV
M19UQV9DVFJMX1JFRywgICAgIDB4ZmZmZmZmZmYsIDB4MDAwNDAwMDcsDQo+ICsgICAgICAgbW1D
R1RTX0NVM19TUDFfQ1RSTF9SRUcsICAgIDB4ZmZmZmZmZmYsIDB4MDAwNjAwMDUsDQo+ICsgICAg
ICAgbW1DR1RTX0NVM19URF9UQ1BfQ1RSTF9SRUcsIDB4ZmZmZmZmZmYsIDB4MDAwOTAwMDgsDQo+
ICsgICAgICAgbW1DR1RTX0NVNF9TUDBfQ1RSTF9SRUcsICAgIDB4ZmZmZmZmZmYsIDB4MDAwMTAw
MDAsDQo+ICsgICAgICAgbW1DR1RTX0NVNF9MRFNfU1FfQ1RSTF9SRUcsIDB4ZmZmZmZmZmYsIDB4
MDAwMzAwMDIsDQo+ICsgICAgICAgbW1DR1RTX0NVNF9UQV9TUUNfQ1RSTF9SRUcsIDB4ZmZmZmZm
ZmYsIDB4MDAwNDAwMDcsDQo+ICsgICAgICAgbW1DR1RTX0NVNF9TUDFfQ1RSTF9SRUcsICAgIDB4
ZmZmZmZmZmYsIDB4MDAwNjAwMDUsDQo+ICsgICAgICAgbW1DR1RTX0NVNF9URF9UQ1BfQ1RSTF9S
RUcsIDB4ZmZmZmZmZmYsIDB4MDAwOTAwMDgsDQo+ICsgICAgICAgbW1DR1RTX0NVNV9TUDBfQ1RS
TF9SRUcsICAgIDB4ZmZmZmZmZmYsIDB4MDAwMTAwMDAsDQo+ICsgICAgICAgbW1DR1RTX0NVNV9M
RFNfU1FfQ1RSTF9SRUcsIDB4ZmZmZmZmZmYsIDB4MDAwMzAwMDIsDQo+ICsgICAgICAgbW1DR1RT
X0NVNV9UQV9DVFJMX1JFRywgICAgIDB4ZmZmZmZmZmYsIDB4MDAwNDAwMDcsDQo+ICsgICAgICAg
bW1DR1RTX0NVNV9TUDFfQ1RSTF9SRUcsICAgIDB4ZmZmZmZmZmYsIDB4MDAwNjAwMDUsDQo+ICsg
ICAgICAgbW1DR1RTX0NVNV9URF9UQ1BfQ1RSTF9SRUcsIDB4ZmZmZmZmZmYsIDB4MDAwOTAwMDgs
DQo+ICsgICAgICAgbW1DR1RTX0NVNl9TUDBfQ1RSTF9SRUcsICAgIDB4ZmZmZmZmZmYsIDB4MDAw
MTAwMDAsDQo+ICsgICAgICAgbW1DR1RTX0NVNl9MRFNfU1FfQ1RSTF9SRUcsIDB4ZmZmZmZmZmYs
IDB4MDAwMzAwMDIsDQo+ICsgICAgICAgbW1DR1RTX0NVNl9UQV9DVFJMX1JFRywgICAgIDB4ZmZm
ZmZmZmYsIDB4MDAwNDAwMDcsDQo+ICsgICAgICAgbW1DR1RTX0NVNl9TUDFfQ1RSTF9SRUcsICAg
IDB4ZmZmZmZmZmYsIDB4MDAwNjAwMDUsDQo+ICsgICAgICAgbW1DR1RTX0NVNl9URF9UQ1BfQ1RS
TF9SRUcsIDB4ZmZmZmZmZmYsIDB4MDAwOTAwMDgsDQo+ICsgICAgICAgbW1DR1RTX0NVN19TUDBf
Q1RSTF9SRUcsICAgIDB4ZmZmZmZmZmYsIDB4MDAwMTAwMDAsDQo+ICsgICAgICAgbW1DR1RTX0NV
N19MRFNfU1FfQ1RSTF9SRUcsIDB4ZmZmZmZmZmYsIDB4MDAwMzAwMDIsDQo+ICsgICAgICAgbW1D
R1RTX0NVN19UQV9DVFJMX1JFRywgICAgIDB4ZmZmZmZmZmYsIDB4MDAwNDAwMDcsDQo+ICsgICAg
ICAgbW1DR1RTX0NVN19TUDFfQ1RSTF9SRUcsICAgIDB4ZmZmZmZmZmYsIDB4MDAwNjAwMDUsDQo+
ICsgICAgICAgbW1DR1RTX0NVN19URF9UQ1BfQ1RSTF9SRUcsIDB4ZmZmZmZmZmYsIDB4MDAwOTAw
MDgsDQo+ICsgICAgICAgbW1DR1RTX1NNX0NUUkxfUkVHLCAgICAgICAgIDB4ZmZmZmZmZmYsIDB4
OTZlMDAyMDAsDQo+ICsgICAgICAgbW1DUF9SQl9XUFRSX1BPTExfQ05UTCwgICAgIDB4ZmZmZmZm
ZmYsIDB4MDA5MDAxMDAsDQo+ICsgICAgICAgbW1STENfQ0dDR19DR0xTX0NUUkwsICAgICAgIDB4
ZmZmZmZmZmYsIDB4MDAyMDAwM2MsDQo+ICsgICAgICAgbW1QQ0lFX0lOREVYLCAgICAgICAgICAg
ICAgIDB4ZmZmZmZmZmYsIDB4MDE0MDAwMWMsDQo+ICsgICAgICAgbW1QQ0lFX0RBVEEsICAgICAg
ICAgICAgICAgIDB4MDAwZjAwMDAsIDB4MDAwMDAwMDAsDQo+ICsgICAgICAgbW1TTUNfSU5EX0lO
REVYXzQsICAgICAgICAgIDB4ZmZmZmZmZmYsIDB4QzA2MDAwMEMsDQo+ICsgICAgICAgbW1TTUNf
SU5EX0RBVEFfNCwgICAgICAgICAgIDB4YzAwMDBmZmYsIDB4MDAwMDAxMDAsDQo+ICsgICAgICAg
bW1YRE1BX0NMT0NLX0dBVElOR19DTlRMLCAgIDB4ZmZmZmZmZmYsIDB4MDAwMDAxMDAsDQo+ICsg
ICAgICAgbW1YRE1BX01FTV9QT1dFUl9DTlRMLCAgICAgIDB4MDAwMDAxMDEsIDB4MDAwMDAwMDAs
DQo+ICsgICAgICAgbW1NQ19NRU1fUE9XRVJfTFMsICAgICAgICAgIDB4ZmZmZmZmZmYsIDB4MDAw
MDAxMDQsDQo+ICsgICAgICAgbW1DR1RUX0RSTV9DTEtfQ1RSTDAsICAgICAgIDB4ZmYwMDBmZmYs
IDB4MDAwMDAxMDAsDQo+ICsgICAgICAgbW1IRFBfWERQX0NHVFRfQkxLX0NUUkwsICAgIDB4YzAw
MDBmZmYsIDB4MDAwMDAxMDQsDQo+ICsgICAgICAgbW1DUF9NRU1fU0xQX0NOVEwsICAgICAgICAg
IDB4MDAwMDAwMDEsIDB4MDAwMDAwMDEsDQo+ICsgICAgICAgbW1TRE1BMF9DTEtfQ1RSTCwgICAg
ICAgICAgIDB4ZmYwMDBmZjAsIDB4MDAwMDAxMDAsDQo+ICsgICAgICAgbW1TRE1BMV9DTEtfQ1RS
TCwgICAgICAgICAgIDB4ZmYwMDBmZjAsIDB4MDAwMDAxMDAsDQo+ICt9Ow0KPiArDQo+ICtzdGF0
aWMgY29uc3QgdTMyIHhncHVfZ29sZGVuX3NldHRpbmdzX3RvbmdhX2ExMVtdID0gew0KPiArICAg
ICAgIG1tQ0JfSFdfQ09OVFJPTCwgMHhmZmZkZjNjZiwgMHgwMDAwNzIwOCwNCj4gKyAgICAgICBt
bUNCX0hXX0NPTlRST0xfMywgMHgwMDAwMDA0MCwgMHgwMDAwMDA0MCwNCj4gKyAgICAgICBtbURC
X0RFQlVHMiwgMHhmMDBmZmZmZiwgMHgwMDAwMDQwMCwNCj4gKyAgICAgICBtbURDSV9DTEtfQ05U
TCwgMHgwMDAwMDA4MCwgMHgwMDAwMDAwMCwNCj4gKyAgICAgICBtbUZCQ19ERUJVR19DT01QLCAw
eDAwMDAwMGYwLCAweDAwMDAwMDcwLA0KPiArICAgICAgIG1tRkJDX01JU0MsIDB4MWYzMTFmZmYs
IDB4MTIzMDAwMDAsDQo+ICsgICAgICAgbW1HQl9HUFVfSUQsIDB4MDAwMDAwMGYsIDB4MDAwMDAw
MDAsDQo+ICsgICAgICAgbW1IRE1JX0NPTlRST0wsIDB4MzEwMDAxMTEsIDB4MDAwMDAwMTEsDQo+
ICsgICAgICAgbW1NQ19BUkJfV1RNX0dSUFdUX1JELCAweDAwMDAwMDAzLCAweDAwMDAwMDAwLA0K
PiArICAgICAgIG1tTUNfSFVCX1JEUkVRX0RNSUZfTElNSVQsIDB4MDAwMDAwN2YsIDB4MDAwMDAw
MjgsDQo+ICsgICAgICAgbW1NQ19IVUJfV0RQX1VNQywgMHgwMDAwN2ZiNiwgMHgwMDAwMDk5MSwN
Cj4gKyAgICAgICBtbVBBX1NDX0VOSEFOQ0UsIDB4ZmZmZmZmZmYsIDB4MjAwMDAwMDEsDQo+ICsg
ICAgICAgbW1QQV9TQ19GSUZPX0RFUFRIX0NOVEwsIDB4MDAwMDAzZmYsIDB4MDAwMDAwZmMsDQo+
ICsgICAgICAgbW1QQV9TQ19MSU5FX1NUSVBQTEVfU1RBVEUsIDB4MDAwMGZmMGYsIDB4MDAwMDAw
MDAsDQo+ICsgICAgICAgbW1STENfQ0dDR19DR0xTX0NUUkwsIDB4MDAwMDAwMDMsIDB4MDAwMDAw
M2MsDQo+ICsgICAgICAgbW1TRE1BMF9DSElDS0VOX0JJVFMsIDB4ZmM5MTAwMDcsIDB4MDA4MTAw
MDcsDQo+ICsgICAgICAgbW1TRE1BMF9DTEtfQ1RSTCwgMHhmZjAwMGZmZiwgMHgwMDAwMDAwMCwN
Cj4gKyAgICAgICBtbVNETUEwX0dGWF9JQl9DTlRMLCAweDgwMGYwMTExLCAweDAwMDAwMTAwLA0K
PiArICAgICAgIG1tU0RNQTBfUkxDMF9JQl9DTlRMLCAweDgwMGYwMTExLCAweDAwMDAwMTAwLA0K
PiArICAgICAgIG1tU0RNQTBfUkxDMV9JQl9DTlRMLCAweDgwMGYwMTExLCAweDAwMDAwMTAwLA0K
PiArICAgICAgIG1tU0RNQTFfQ0hJQ0tFTl9CSVRTLCAweGZjOTEwMDA3LCAweDAwODEwMDA3LA0K
PiArICAgICAgIG1tU0RNQTFfQ0xLX0NUUkwsIDB4ZmYwMDBmZmYsIDB4MDAwMDAwMDAsDQo+ICsg
ICAgICAgbW1TRE1BMV9HRlhfSUJfQ05UTCwgMHg4MDBmMDExMSwgMHgwMDAwMDEwMCwNCj4gKyAg
ICAgICBtbVNETUExX1JMQzBfSUJfQ05UTCwgMHg4MDBmMDExMSwgMHgwMDAwMDEwMCwNCj4gKyAg
ICAgICBtbVNETUExX1JMQzFfSUJfQ05UTCwgMHg4MDBmMDExMSwgMHgwMDAwMDEwMCwNCj4gKyAg
ICAgICBtbVNRX1JBTkRPTV9XQVZFX1BSSSwgMHgwMDFmZmZmZiwgMHgwMDAwMDZmZCwNCj4gKyAg
ICAgICBtbVRBX0NOVExfQVVYLCAweDAwMGYwMDBmLCAweDAwMGIwMDAwLA0KPiArICAgICAgIG1t
VENDX0NUUkwsIDB4MDAxMDAwMDAsIDB4ZjMxZmZmN2YsDQo+ICsgICAgICAgbW1UQ0NfRVhFX0RJ
U0FCTEUsIDB4MDAwMDAwMDIsIDB4MDAwMDAwMDIsDQo+ICsgICAgICAgbW1UQ1BfQUREUl9DT05G
SUcsIDB4MDAwMDAzZmYsIDB4MDAwMDAyZmIsDQo+ICsgICAgICAgbW1UQ1BfQ0hBTl9TVEVFUl9I
SSwgMHhmZmZmZmZmZiwgMHgwMDAwNTQzYiwNCj4gKyAgICAgICBtbVRDUF9DSEFOX1NURUVSX0xP
LCAweGZmZmZmZmZmLCAweGE5MjEwODc2LA0KPiArICAgICAgIG1tVkdUX1JFU0VUX0RFQlVHLCAw
eDAwMDAwMDA0LCAweDAwMDAwMDA0LA0KPiArICAgICAgIG1tVk1fUFJUX0FQRVJUVVJFMF9MT1df
QUREUiwgMHgwZmZmZmZmZiwgMHgwZmZmZmZmZiwNCj4gKyAgICAgICBtbVZNX1BSVF9BUEVSVFVS
RTFfTE9XX0FERFIsIDB4MGZmZmZmZmYsIDB4MGZmZmZmZmYsDQo+ICsgICAgICAgbW1WTV9QUlRf
QVBFUlRVUkUyX0xPV19BRERSLCAweDBmZmZmZmZmLCAweDBmZmZmZmZmLA0KPiArICAgICAgIG1t
Vk1fUFJUX0FQRVJUVVJFM19MT1dfQUREUiwgMHgwZmZmZmZmZiwgMHgwZmZmZmZmZiwNCj4gK307
DQo+ICsNCj4gK3N0YXRpYyBjb25zdCB1MzIgeGdwdV90b25nYV9nb2xkZW5fY29tbW9uX2FsbFtd
ID0gew0KPiArICAgICAgIG1tR1JCTV9HRlhfSU5ERVgsICAgICAgICAgICAgICAgMHhmZmZmZmZm
ZiwgMHhlMDAwMDAwMCwNCj4gKyAgICAgICBtbVBBX1NDX1JBU1RFUl9DT05GSUcsICAgICAgICAg
IDB4ZmZmZmZmZmYsIDB4MTYwMDAwMTIsDQo+ICsgICAgICAgbW1QQV9TQ19SQVNURVJfQ09ORklH
XzEsICAgICAgICAweGZmZmZmZmZmLCAweDAwMDAwMDJBLA0KPiArICAgICAgIG1tR0JfQUREUl9D
T05GSUcsICAgICAgICAgICAgICAgMHhmZmZmZmZmZiwgMHgyMjAxMTAwMiwNCj4gKyAgICAgICBt
bVNQSV9SRVNPVVJDRV9SRVNFUlZFX0NVXzAsICAgIDB4ZmZmZmZmZmYsIDB4MDAwMDA4MDAsDQo+
ICsgICAgICAgbW1TUElfUkVTT1VSQ0VfUkVTRVJWRV9DVV8xLCAgICAweGZmZmZmZmZmLCAweDAw
MDAwODAwLA0KPiArICAgICAgIG1tU1BJX1JFU09VUkNFX1JFU0VSVkVfRU5fQ1VfMCwgMHhmZmZm
ZmZmZiwgMHgwMDAwN0ZCRiwNCj4gK307DQo+ICsNCj4gK3ZvaWQgYW1kZ3B1X3hncHVfaW5pdF9n
b2xkZW5fcmVnaXN0ZXJzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiArew0KPiArICAg
ICAgIHN3aXRjaCAoYWRldi0+YXNpY190eXBlKSB7DQo+ICsgICAgICAgY2FzZSBDSElQX0ZJSkk6
DQo+ICsgICAgICAgICAgICAgICBhbWRncHVfcHJvZ3JhbV9yZWdpc3Rlcl9zZXF1ZW5jZShhZGV2
LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgeGdw
dV9maWppX21nY2dfY2djZ19pbml0LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKGNvbnN0IHUzMilBUlJBWV9TSVpFKA0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgeGdwdV9maWppX21nY2dfY2djZ19p
bml0KSk7DQo+ICsgICAgICAgICAgICAgICBhbWRncHVfcHJvZ3JhbV9yZWdpc3Rlcl9zZXF1ZW5j
ZShhZGV2LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgeGdwdV9nb2xkZW5fc2V0dGluZ3NfZmlqaV9hMTAsDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoY29uc3QgdTMyKUFSUkFZX1NJWkUoDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB4Z3B1X2dvbGRl
bl9zZXR0aW5nc19maWppX2ExMCkpOw0KPiArICAgICAgICAgICAgICAgYW1kZ3B1X3Byb2dyYW1f
cmVnaXN0ZXJfc2VxdWVuY2UoYWRldiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHhncHVfZmlqaV9nb2xkZW5fY29tbW9uX2FsbCwNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChjb25zdCB1MzIpQVJS
QVlfU0laRSgNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHhncHVfZmlqaV9nb2xkZW5fY29tbW9uX2FsbCkpOw0KPiArICAgICAgICAgICAgICAgYnJl
YWs7DQo+ICsgICAgICAgY2FzZSBDSElQX1RPTkdBOg0KPiArICAgICAgICAgICAgICAgYW1kZ3B1
X3Byb2dyYW1fcmVnaXN0ZXJfc2VxdWVuY2UoYWRldiwNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHhncHVfdG9uZ2FfbWdjZ19jZ2NnX2luaXQsDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoY29uc3Qg
dTMyKUFSUkFZX1NJWkUoDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB4Z3B1X3RvbmdhX21nY2dfY2djZ19pbml0KSk7DQo+ICsgICAgICAgICAgICAg
ICBhbWRncHVfcHJvZ3JhbV9yZWdpc3Rlcl9zZXF1ZW5jZShhZGV2LA0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgeGdwdV9nb2xkZW5fc2V0dGluZ3Nf
dG9uZ2FfYTExLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKGNvbnN0IHUzMilBUlJBWV9TSVpFKA0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgeGdwdV9nb2xkZW5fc2V0dGluZ3NfdG9uZ2FfYTExKSk7
DQo+ICsgICAgICAgICAgICAgICBhbWRncHVfcHJvZ3JhbV9yZWdpc3Rlcl9zZXF1ZW5jZShhZGV2
LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgeGdw
dV90b25nYV9nb2xkZW5fY29tbW9uX2FsbCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIChjb25zdCB1MzIpQVJSQVlfU0laRSgNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHhncHVfdG9uZ2FfZ29sZGVu
X2NvbW1vbl9hbGwpKTsNCj4gKyAgICAgICAgICAgICAgIGJyZWFrOw0KPiArICAgICAgIGRlZmF1
bHQ6DQo+ICsgICAgICAgICAgICAgICBicmVhazsNCj4gKyAgICAgICB9DQo+ICt9DQoNCkNsZWFu
ZXIgdG8ganVzdCBwdXQgdGhpcyBpbiB2aS5jLg0KDQpBbGV4DQoNCj4gKw0KPiAgc3RhdGljIGlu
dCB4Z3B1X3ZpX2Vhcmx5X2luaXQodm9pZCAqaGFuZGxlKQ0KPiAgew0KPiAgICAgICAgIHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOw0K
PiAtLQ0KPiAyLjcuNA0KPg0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXw0KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZzxtYWlsdG86YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+DQo+IGh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA0K

--_000_BN6PR12MB1652C93B278BF7B731612169F7900BN6PR12MB1652namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:SimSun;
	mso-fareast-language:ZH-CN;}
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
	font-family:SimSun;
	mso-fareast-language:ZH-CN;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";
	mso-fareast-language:ZH-CN;}
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
	font-family:SimSun;
	mso-fareast-language:ZH-CN;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";
	mso-fareast-language:ZH-CN;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
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
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">I don't mind keeping the =
list together.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Alex<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> amd-gfx =
[mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org]
<b>On Behalf Of </b>Liu, Monk<br>
<b>Sent:</b> Monday, December 19, 2016 11:09 PM<br>
<b>To:</b> Alex Deucher; Yu, Xiangliang<br>
<b>Cc:</b> Min, Frank; dl.SRDC_SW_GPUVirtualization; amd-gfx list<br>
<b>Subject:</b> </span><span lang=3D"ZH-CN" style=3D"font-size:10.0pt">=B4=
=F0=B8=B4</span><span style=3D"font-size:10.0pt;font-family:&quot;Tahoma&qu=
ot;,&quot;sans-serif&quot;">: [PATCH 21/23] drm/amdgpu: change golden regis=
ter program sequence of virtualization<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div id=3D"x_divtagdefaultwrapper">
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">Hi Alex<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">I agree with you that this patch's GOLDEN setting programming sh=
ould be put in VI.C, but I found a hardware issue :<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">original linux logic is that we set golden setting registers sep=
arately within each IP's hw init routine, but for TONGA VF, it is really st=
range that we must set all GOLDEN setting value to chip
 in one shoot (means we use one routine to programing all IP's golden setti=
ng to registers), ortherwise we found TONGA vf&nbsp; just failed in RING TE=
ST.<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">and I admit I don't know why (I checked windows CAIL code, it is=
 also set all golden setting registers in one routine)<o:p></o:p></span></p=
>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">BR Monk<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span lang=3D"ZH-CN" style=3D"font-size:11.0pt;co=
lor:black">=B7=A2=BC=FE=C8=CB</span></b><b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">:</span=
></b><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;=
sans-serif&quot;;color:black">
 Alex Deucher &lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">alexdeucher@gmai=
l.com</a>&gt;<br>
</span><b><span lang=3D"ZH-CN" style=3D"font-size:11.0pt;color:black">=B7=
=A2=CB=CD=CA=B1=BC=E4</span></b><b><span style=3D"font-size:11.0pt;font-fam=
ily:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">:</span></b><sp=
an style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-ser=
if&quot;;color:black"> 2016</span><span lang=3D"ZH-CN" style=3D"font-size:1=
1.0pt;color:black">=C4=EA</span><span style=3D"font-size:11.0pt;font-family=
:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">12</span><span lan=
g=3D"ZH-CN" style=3D"font-size:11.0pt;color:black">=D4=C2</span><span style=
=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;=
;color:black">20</span><span lang=3D"ZH-CN" style=3D"font-size:11.0pt;color=
:black">=C8=D5</span><span style=3D"font-size:11.0pt;font-family:&quot;Cali=
bri&quot;,&quot;sans-serif&quot;;color:black">
 7:37:06<br>
</span><b><span lang=3D"ZH-CN" style=3D"font-size:11.0pt;color:black">=CA=
=D5=BC=FE=C8=CB</span></b><b><span style=3D"font-size:11.0pt;font-family:&q=
uot;Calibri&quot;,&quot;sans-serif&quot;;color:black">:</span></b><span sty=
le=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quo=
t;;color:black"> Yu, Xiangliang<br>
</span><b><span lang=3D"ZH-CN" style=3D"font-size:11.0pt;color:black">=B3=
=AD=CB=CD</span></b><b><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:black">:</span></b><span style=3D"=
font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;col=
or:black"> amd-gfx
 list; dl.SRDC_SW_GPUVirtualization; Min, Frank; Liu, Monk<br>
</span><b><span lang=3D"ZH-CN" style=3D"font-size:11.0pt;color:black">=D6=
=F7=CC=E2</span></b><b><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:black">:</span></b><span style=3D"=
font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;col=
or:black"> Re: [PATCH
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

--_000_BN6PR12MB1652C93B278BF7B731612169F7900BN6PR12MB1652namp_--

--===============0965081352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0965081352==--
