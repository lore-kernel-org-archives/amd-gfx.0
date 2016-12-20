From: "Yu, Xiangliang" <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 11/23] drm/amdgpu: implement context save area(CSA) feature
Date: Tue, 20 Dec 2016 05:43:31 +0000
Message-ID: <CY4PR12MB1701351D6DCEA18714735B3DEB900@CY4PR12MB1701.namprd12.prod.outlook.com>
References: <1481991405-30422-1-git-send-email-Xiangliang.Yu@amd.com>
 <1481991405-30422-12-git-send-email-Xiangliang.Yu@amd.com>,
 <CADnq5_P1hOrd7Vk1G01Gj7aM1RjkyhgLGWV6CnTu9mvrGhtxsg@mail.gmail.com>
 <BY2PR12MB00547F38C7E612AE3A4D027184900@BY2PR12MB0054.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0324868073=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BY2PR12MB00547F38C7E612AE3A4D027184900-K//h7OWB4q7GdVlgMuSljQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
Cc: "dl.SRDC_SW_GPUVirtualization" <dl.SRDC_SW_GPUVirtualization-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0324868073==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1701351D6DCEA18714735B3DEB900CY4PR12MB1701namp_"

--_000_CY4PR12MB1701351D6DCEA18714735B3DEB900CY4PR12MB1701namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

VGhhbmsgbW9ua6GvcyBkZXRhaWwgZXhwYW5hdGlvbi4NCkFuZCBJIHRoaW5rIHRoaXMgcGF0Y2gg
aXMgb25seSBzdXBwb3J0IHZpcnR1YWxpemF0aW9uIHdvcmxkIHN3aXRjaCwgbm90IHRvdWNoIHdo
b2xlIGFtZHBndSBwcmVlbXB0aW9uLg0KDQpUaGFua3MhDQpYaWFuZ2xpYW5nIFl1DQoNCkZyb206
IExpdSwgTW9uaw0KU2VudDogVHVlc2RheSwgRGVjZW1iZXIgMjAsIDIwMTYgMTE6NTggQU0NClRv
OiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT47IFl1LCBYaWFuZ2xpYW5nIDxY
aWFuZ2xpYW5nLll1QGFtZC5jb20+DQpDYzogYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZz47IGRsLlNSRENfU1dfR1BVVmlydHVhbGl6YXRpb24gPGRsLlNSRENfU1df
R1BVVmlydHVhbGl6YXRpb25AYW1kLmNvbT4NClN1YmplY3Q6ILTwuLQ6IFtQQVRDSCAxMS8yM10g
ZHJtL2FtZGdwdTogaW1wbGVtZW50IGNvbnRleHQgc2F2ZSBhcmVhKENTQSkgZmVhdHVyZQ0KDQoN
CnRoZSBDU0EgaXMgdXNlZCBmb3Igd29ybGQgc3dpdGNoLCBhbmQgZWFjaCBhbWRncHUgZGV2aWNl
IHNob3VsZCBoYXZlIG9uZSBhbmQgb25seSBvbmUgQ1NBLA0KDQphbmQgdGhpcyBDU0Egd2lsbCBw
aW5lZCwgYW5kIG1hcHBlZCB0byBlYWNoIHZpcnR1YWwgbWVtb3J5IC9wcm9jZXNzLg0KDQoNCg0K
Q1AvUkxDViB3aWxsIHVzZSB0aGlzIENTQSBidWZmZXIgd2hlbiBwcmVlbXB0aW9uIG9jY3VycmVk
LCBhbmQgd2lsbCB3cml0ZSBzb21lIGhhcmR3YXJlIHN0YXR1cyBpbnRvIHRoaXMgQ1NBIGJ1ZmZl
ciwgd2l0aGluIHRoZSBjdXJyZW50IElCJ3MgY29udGV4dCAodGhhdCdzIHdoeSBuZWVkIGRvIG1h
cHBpbmcgZm9yIGVhY2ggdmlydHVhbCBtZW1vcnkgb24gQ1NBKQ0KDQoNCg0KQlIgTW9uaw0KDQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0Kt6K8/sjLOiBBbGV4IERldWNoZXIgPGFs
ZXhkZXVjaGVyQGdtYWlsLmNvbTxtYWlsdG86YWxleGRldWNoZXJAZ21haWwuY29tPj4NCreiy83K
sbzkOiAyMDE2xOoxMtTCMjDI1SA3OjIwOjA5DQrK1bz+yMs6IFl1LCBYaWFuZ2xpYW5nDQqzrcvN
OiBhbWQtZ2Z4IGxpc3Q7IGRsLlNSRENfU1dfR1BVVmlydHVhbGl6YXRpb247IExpdSwgTW9uaw0K
1vfM4jogUmU6IFtQQVRDSCAxMS8yM10gZHJtL2FtZGdwdTogaW1wbGVtZW50IGNvbnRleHQgc2F2
ZSBhcmVhKENTQSkgZmVhdHVyZQ0KDQpPbiBTYXQsIERlYyAxNywgMjAxNiBhdCAxMToxNiBBTSwg
WGlhbmdsaWFuZyBZdSA8WGlhbmdsaWFuZy5ZdUBhbWQuY29tPG1haWx0bzpYaWFuZ2xpYW5nLll1
QGFtZC5jb20+PiB3cm90ZToNCj4gQ1NBIGlzIG5lZWQgYnkgd29ybGQgc3dpdGNoLiBUaGlzIHBh
dGNoIGltcGxlbWVudCBDU0EgZmVhdHVyZSBhbmQNCj4gYmluZCBpdCB0byBlYWNoIFZNLCBzbyBo
YXJkd2FyZSBjYW4gc2F2ZSB0aGUgc3RhdGUgaW50byB0aGUgYXJlYQ0KPiBhbmQgcmVzdG9yZSBp
dCB3aGVuIHJ1bm5pbmcgYWdhaW4uDQo+DQo+IFNpZ25lZC1vZmYtYnk6IE1vbmsgTGl1IDxNb25r
LkxpdUBhbWQuY29tPG1haWx0bzpNb25rLkxpdUBhbWQuY29tPj4NCj4gU2lnbmVkLW9mZi1ieTog
WGlhbmdsaWFuZyBZdSA8WGlhbmdsaWFuZy5ZdUBhbWQuY29tPG1haWx0bzpYaWFuZ2xpYW5nLll1
QGFtZC5jb20+Pg0KDQpJc24ndCB0aGUgQ1NBIGFjdHVhbGx5IGZvciBwcmVlbXB0aW9uPyAgUHJl
ZW1wdGlvbiBpcyB1c2VmdWwgb3V0c2lkZQ0Kb2YgdGhlIFZGIGNhc2UgYXMgd2VsbCBzbyBpdCBz
aG91bGQgYmUgdW50YW5nbGVkIGZyb20gdGhlIG14Z3B1IGNvZGUNCnNvIGl0IGNhbiBiZSB1dGls
aXplZCBpbmRlcGVuZGVudGx5Lg0KDQpBbGV4DQoNCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdmlydC5oIHwgIDE0ICsrKw0KPiAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMgICB8ICAgOCArKw0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmggICB8ICAgNCArDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL214Z3B1
L2FtZF9teGdwdS5oICAgIHwgIDEyICsrDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL214Z3B1L214
Z3B1X2NzYS5jICAgIHwgMjA5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDUg
ZmlsZXMgY2hhbmdlZCwgMjQ3IGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL2dwdS9kcm0vYW1kL214Z3B1L214Z3B1X2NzYS5jDQo+DQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5oIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuaA0KPiBpbmRleCA4ZWU3MGY4Li5kZmYxMjQ4IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5oDQo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0LmgNCj4gQEAgLTI0LDYg
KzI0LDggQEANCj4gICNpZm5kZWYgQU1ER1BVX1ZJUlRfSA0KPiAgI2RlZmluZSBBTURHUFVfVklS
VF9IDQo+DQo+ICtzdHJ1Y3QgYW1kZ3B1X3ZtOw0KPiArDQo+ICAjZGVmaW5lIEFNREdQVV9TUklP
Vl9DQVBTX1NSSU9WX1ZCSU9TICAoMSA8PCAwKSAvKiB2QklPUyBpcyBzci1pb3YgcmVhZHkgKi8N
Cj4gICNkZWZpbmUgQU1ER1BVX1NSSU9WX0NBUFNfRU5BQkxFX0lPViAgICgxIDw8IDEpIC8qIHNy
LWlvdiBpcyBlbmFibGVkIG9uIHRoaXMgR1BVICovDQo+ICAjZGVmaW5lIEFNREdQVV9TUklPVl9D
QVBTX0lTX1ZGICAgICAgICAoMSA8PCAyKSAvKiB0aGlzIEdQVSBpcyBhIHZpcnR1YWwgZnVuY3Rp
b24gKi8NCj4gQEAgLTMzLDYgKzM1LDE0IEBAIHN0cnVjdCBhbWRncHVfdmlydHVhbGl6YXRpb24g
ew0KPiAgICAgICAgIHVpbnQzMl90IHZpcnR1YWxfY2FwczsNCj4gIH07DQo+DQo+ICtzdHJ1Y3Qg
YW1kZ3B1X2NzYSB7DQo+ICsgICAgICAgc3RydWN0IGFtZGdwdV9ib192YSAgICAgICAgICAgICAq
dmE7DQo+ICsgICAgICAgc3RydWN0IHR0bV92YWxpZGF0ZV9idWZmZXIgICAgICB0djsNCj4gKyAg
ICAgICB1aW50NjRfdCAgICAgICAgICAgICAgICAgICAgICAgIHJlc2VydmVkX3RvcDsNCj4gKyAg
ICAgICB1aW50NjRfdCAgICAgICAgICAgICAgICAgICAgICAgIGNzYV9hZGRyOw0KPiArICAgICAg
IHVpbnQ2NF90ICAgICAgICAgICAgICAgICAgICAgICAgZ2RzX2FkZHI7DQo+ICt9Ow0KPiArDQo+
ICAjZGVmaW5lIGFtZGdwdV9zcmlvdl9lbmFibGVkKGFkZXYpIFwNCj4gICgoYWRldiktPnZpcnR1
YWxpemF0aW9uLnZpcnR1YWxfY2FwcyAmIEFNREdQVV9TUklPVl9DQVBTX0VOQUJMRV9JT1YpDQo+
DQo+IEBAIC01NSw0ICs2NSw4IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBpc192aXJ0dWFsX21hY2hp
bmUodm9pZCkNCj4gIH0NCj4NCj4gIGludCBhbWRfeGdwdV9zZXRfaXBfYmxvY2tzKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KTsNCj4gKw0KPiArLyogQ29udGV4dCBTYXZlIEFyZWEgZnVuY3Rp
b25zICovDQo+ICtpbnQgYW1kZ3B1X3ZtX21hcF9jc2Eoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtKTsNCj4gK3ZvaWQgYW1kZ3B1X3ZtX3VubWFwX2NzYShz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0pOw0KPiAgI2Vu
ZGlmDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+IGluZGV4IGQwNTU0
NmUuLjk4NTQwZDkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5j
DQo+IEBAIC0xNTM5LDYgKzE1MzksOCBAQCBpbnQgYW1kZ3B1X3ZtX2luaXQoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtKQ0KPiAgICAgICAgIHBkX3NpemUg
PSBhbWRncHVfdm1fZGlyZWN0b3J5X3NpemUoYWRldik7DQo+ICAgICAgICAgcGRfZW50cmllcyA9
IGFtZGdwdV92bV9udW1fcGRlcyhhZGV2KTsNCj4NCj4gKyAgICAgICB2bS0+Y3NhLnJlc2VydmVk
X3RvcCA9IEFNREdQVV9WQV9SRVNFUlZFRF9TSVpFOw0KPiArDQo+ICAgICAgICAgLyogYWxsb2Nh
dGUgcGFnZSB0YWJsZSBhcnJheSAqLw0KPiAgICAgICAgIHZtLT5wYWdlX3RhYmxlcyA9IGRybV9j
YWxsb2NfbGFyZ2UocGRfZW50cmllcywgc2l6ZW9mKHN0cnVjdCBhbWRncHVfdm1fcHQpKTsNCj4g
ICAgICAgICBpZiAodm0tPnBhZ2VfdGFibGVzID09IE5VTEwpIHsNCj4gQEAgLTE1NzYsNiArMTU3
OCwxMCBAQCBpbnQgYW1kZ3B1X3ZtX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0
cnVjdCBhbWRncHVfdm0gKnZtKQ0KPiAgICAgICAgIHZtLT5sYXN0X2V2aWN0aW9uX2NvdW50ZXIg
PSBhdG9taWM2NF9yZWFkKCZhZGV2LT5udW1fZXZpY3Rpb25zKTsNCj4gICAgICAgICBhbWRncHVf
Ym9fdW5yZXNlcnZlKHZtLT5wYWdlX2RpcmVjdG9yeSk7DQo+DQo+ICsgICAgICAgciA9IGFtZGdw
dV92bV9tYXBfY3NhKGFkZXYsIHZtKTsNCj4gKyAgICAgICBpZiAocikNCj4gKyAgICAgICAgICAg
ICAgIGdvdG8gZXJyb3JfZnJlZV9wYWdlX2RpcmVjdG9yeTsNCj4gKw0KPiAgICAgICAgIHJldHVy
biAwOw0KPg0KPiAgZXJyb3JfZnJlZV9wYWdlX2RpcmVjdG9yeToNCj4gQEAgLTE2MDYsNiArMTYx
Miw4IEBAIHZvaWQgYW1kZ3B1X3ZtX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0
cnVjdCBhbWRncHVfdm0gKnZtKQ0KPiAgICAgICAgIHN0cnVjdCBhbWRncHVfYm9fdmFfbWFwcGlu
ZyAqbWFwcGluZywgKnRtcDsNCj4gICAgICAgICBpbnQgaTsNCj4NCj4gKyAgICAgICBhbWRncHVf
dm1fdW5tYXBfY3NhKGFkZXYsIHZtKTsNCj4gKw0KPiAgICAgICAgIGFtZF9zY2hlZF9lbnRpdHlf
ZmluaSh2bS0+ZW50aXR5LnNjaGVkLCAmdm0tPmVudGl0eSk7DQo+DQo+ICAgICAgICAgaWYgKCFS
Ql9FTVBUWV9ST09UKCZ2bS0+dmEpKSB7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdm0uaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92bS5oDQo+IGluZGV4IDQyYTYyOWIuLmQ5MDYzMGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5oDQo+IEBAIC0yOSw2ICsyOSw3IEBADQo+ICAjaW5jbHVkZSAi
Z3B1X3NjaGVkdWxlci5oIg0KPiAgI2luY2x1ZGUgImFtZGdwdV9zeW5jLmgiDQo+ICAjaW5jbHVk
ZSAiYW1kZ3B1X3JpbmcuaCINCj4gKyNpbmNsdWRlICJhbWRncHVfdmlydC5oIg0KPg0KPiAgc3Ry
dWN0IGFtZGdwdV9ib192YTsNCj4gIHN0cnVjdCBhbWRncHVfam9iOw0KPiBAQCAtMTA5LDYgKzEx
MCw5IEBAIHN0cnVjdCBhbWRncHVfdm0gew0KPiAgICAgICAgIC8qIFNjaGVkdWxlciBlbnRpdHkg
Zm9yIHBhZ2UgdGFibGUgdXBkYXRlcyAqLw0KPiAgICAgICAgIHN0cnVjdCBhbWRfc2NoZWRfZW50
aXR5IGVudGl0eTsNCj4NCj4gKyAgICAgICAvKiBDb250ZXh0IFNhdmUgQXJlYSAqLw0KPiArICAg
ICAgIHN0cnVjdCBhbWRncHVfY3NhICAgICAgIGNzYTsNCj4gKw0KPiAgICAgICAgIC8qIGNsaWVu
dCBpZCAqLw0KPiAgICAgICAgIHU2NCAgICAgICAgICAgICAgICAgICAgIGNsaWVudF9pZDsNCj4g
IH07DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL214Z3B1L2FtZF9teGdwdS5o
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9teGdwdS9hbWRfbXhncHUuaA0KPiBpbmRleCA2YWIxM2Jj
Li5hMjVlMDdmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL214Z3B1L2FtZF9t
eGdwdS5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvbXhncHUvYW1kX214Z3B1LmgNCj4g
QEAgLTI2LDEyICsyNiwyNCBAQA0KPg0KPiAgI2luY2x1ZGUgImFtZGdwdS5oIg0KPg0KPiArLyog
eGdwdSBzdHJ1Y3R1cmVzICovDQo+ICtzdHJ1Y3QgYW1kX3hncHVfY3NhIHsNCj4gKyAgICAgICBz
dHJ1Y3QgYW1kZ3B1X2JvICAgICAgICAgICAgKnJvYmo7DQo+ICsgICAgICAgdWludDY0X3QgICAg
ICAgICAgICAgICAgICAgIGdwdV9hZGRyOw0KPiArICAgICAgIHVpbnQ2NF90ICAgICAgICAgICAg
ICAgICAgICBnZHNfYWRkcjsNCj4gKyAgICAgICBpbnQzMl90ICAgICAgICAgICAgICAgICAgICAg
c2l6ZTsNCj4gK307DQo+ICsNCj4gIHN0cnVjdCBhbWRfeGdwdSB7DQo+ICAgICAgICAgc3RydWN0
IGFtZGdwdV9kZXZpY2UgICAgKmFkZXY7DQo+ICAgICAgICAgc3RydWN0IG11dGV4ICAgICAgICAg
ICAgbG9jazsNCj4gKyAgICAgICBzdHJ1Y3QgYW1kX3hncHVfY3NhICAgICBzYTsNCj4gICAgICAg
ICB1MzIgICAgICAgICAgICAgICAgICAgICByZWdfdmFsX29mZnM7DQo+ICB9Ow0KPg0KPiAgZXh0
ZXJuIGludCBhbWRfeGdwdV9hbGxvYyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7DQo+ICBl
eHRlcm4gdm9pZCBhbWRfeGdwdV9mcmVlKHN0cnVjdCBhbWRfeGdwdSAqeGdwdSk7DQo+ICsNCj4g
K2V4dGVybiBpbnQgeGdwdV9hbGxvY2F0ZV9jc2Eoc3RydWN0IGFtZF94Z3B1ICp4Z3B1KTsNCj4g
K2V4dGVybiB2b2lkIHhncHVfZGVzdHJveV9jc2Eoc3RydWN0IGFtZF94Z3B1X2NzYSAqY3NhKTsN
Cj4gICNlbmRpZg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9teGdwdS9teGdw
dV9jc2EuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvbXhncHUvbXhncHVfY3NhLmMNCj4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMC4uMjQ2YTc0Nw0KPiAtLS0gL2Rldi9udWxs
DQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvbXhncHUvbXhncHVfY3NhLmMNCj4gQEAgLTAs
MCArMSwyMDkgQEANCj4gKy8qDQo+ICsgKiBDb3B5cmlnaHQgMjAxNiBBZHZhbmNlZCBNaWNybyBE
ZXZpY2VzLCBJbmMuDQo+ICsgKg0KPiArICogUGVybWlzc2lvbiBpcyBoZXJlYnkgZ3JhbnRlZCwg
ZnJlZSBvZiBjaGFyZ2UsIHRvIGFueSBwZXJzb24gb2J0YWluaW5nIGENCj4gKyAqIGNvcHkgb2Yg
dGhpcyBzb2Z0d2FyZSBhbmQgYXNzb2NpYXRlZCBkb2N1bWVudGF0aW9uIGZpbGVzICh0aGUgIlNv
ZnR3YXJlIiksDQo+ICsgKiB0byBkZWFsIGluIHRoZSBTb2Z0d2FyZSB3aXRob3V0IHJlc3RyaWN0
aW9uLCBpbmNsdWRpbmcgd2l0aG91dCBsaW1pdGF0aW9uDQo+ICsgKiB0aGUgcmlnaHRzIHRvIHVz
ZSwgY29weSwgbW9kaWZ5LCBtZXJnZSwgcHVibGlzaCwgZGlzdHJpYnV0ZSwgc3VibGljZW5zZSwN
Cj4gKyAqIGFuZC9vciBzZWxsIGNvcGllcyBvZiB0aGUgU29mdHdhcmUsIGFuZCB0byBwZXJtaXQg
cGVyc29ucyB0byB3aG9tIHRoZQ0KPiArICogU29mdHdhcmUgaXMgZnVybmlzaGVkIHRvIGRvIHNv
LCBzdWJqZWN0IHRvIHRoZSBmb2xsb3dpbmcgY29uZGl0aW9uczoNCj4gKyAqDQo+ICsgKiBUaGUg
YWJvdmUgY29weXJpZ2h0IG5vdGljZSBhbmQgdGhpcyBwZXJtaXNzaW9uIG5vdGljZSBzaGFsbCBi
ZSBpbmNsdWRlZCBpbg0KPiArICogYWxsIGNvcGllcyBvciBzdWJzdGFudGlhbCBwb3J0aW9ucyBv
ZiB0aGUgU29mdHdhcmUuDQo+ICsgKg0KPiArICogVEhFIFNPRlRXQVJFIElTIFBST1ZJREVEICJB
UyBJUyIsIFdJVEhPVVQgV0FSUkFOVFkgT0YgQU5ZIEtJTkQsIEVYUFJFU1MgT1INCj4gKyAqIElN
UExJRUQsIElOQ0xVRElORyBCVVQgTk9UIExJTUlURUQgVE8gVEhFIFdBUlJBTlRJRVMgT0YgTUVS
Q0hBTlRBQklMSVRZLA0KPiArICogRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UgQU5E
IE5PTklORlJJTkdFTUVOVC4gIElOIE5PIEVWRU5UIFNIQUxMDQo+ICsgKiBUSEUgQ09QWVJJR0hU
IEhPTERFUihTKSBPUiBBVVRIT1IoUykgQkUgTElBQkxFIEZPUiBBTlkgQ0xBSU0sIERBTUFHRVMg
T1INCj4gKyAqIE9USEVSIExJQUJJTElUWSwgV0hFVEhFUiBJTiBBTiBBQ1RJT04gT0YgQ09OVFJB
Q1QsIFRPUlQgT1IgT1RIRVJXSVNFLA0KPiArICogQVJJU0lORyBGUk9NLCBPVVQgT0YgT1IgSU4g
Q09OTkVDVElPTiBXSVRIIFRIRSBTT0ZUV0FSRSBPUiBUSEUgVVNFIE9SDQo+ICsgKiBPVEhFUiBE
RUFMSU5HUyBJTiBUSEUgU09GVFdBUkUuDQo+ICsgKg0KPiArICogQXV0aG9yczogWGlhbmdsaWFu
Zy5ZdUBhbWQuY29tPG1haWx0bzpYaWFuZ2xpYW5nLll1QGFtZC5jb20+DQo+ICsgKiAgICAgICAg
IE1vbmsuTGl1QGFtZC5jb208bWFpbHRvOk1vbmsuTGl1QGFtZC5jb20+DQo+ICsgKg0KPiArICov
DQo+ICsjaW5jbHVkZSAiYW1kX214Z3B1LmgiDQo+ICsjaW5jbHVkZSAidmlkLmgiDQo+ICsNCj4g
K3N0YXRpYyBpbnQgeGdwdV9pbml0X2NzYShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3Ry
dWN0IGFtZF94Z3B1X2NzYSAqc2EpDQo+ICt7DQo+ICsgICAgICAgaW50IHIsIHNpemU7DQo+ICsg
ICAgICAgdm9pZCAqcHRyOw0KPiArDQo+ICsgICAgICAgLyogbWV0YSBkYXRhICg0aykgKyBnZHMt
Z2Z4ICg0aykqLw0KPiArICAgICAgIHNpemUgPSBQQUdFX1NJWkUgKyBhZGV2LT5nZHMubWVtLmdm
eF9wYXJ0aXRpb25fc2l6ZTsNCj4gKw0KPiArICAgICAgIHIgPSBhbWRncHVfYm9fY3JlYXRlKGFk
ZXYsIHNpemUsIFBBR0VfU0laRSwgdHJ1ZSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBBTURHUFVfR0VNX0RPTUFJTl9HVFQsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
QU1ER1BVX0dFTV9DUkVBVEVfQ1BVX0dUVF9VU1dDLA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIE5VTEwsIE5VTEwsICZzYS0+cm9iaik7DQo+ICsgICAgICAgaWYgKHIpIHsNCj4gKyAg
ICAgICAgICAgICAgIGRldl9lcnIoYWRldi0+ZGV2LCAiKCVkKSBmYWlsZWQgdG8gYWxsb2NhdGUg
Y3NhIGJvXG4iLCByKTsNCj4gKyAgICAgICAgICAgICAgIHJldHVybiByOw0KPiArICAgICAgIH0N
Cj4gKw0KPiArICAgICAgIHIgPSBhbWRncHVfYm9fcmVzZXJ2ZShzYS0+cm9iaiwgdHJ1ZSk7DQo+
ICsgICAgICAgaWYgKHVubGlrZWx5KHIgIT0gMCkpDQo+ICsgICAgICAgICAgICAgICBnb3RvIGVy
cm9yX2ZyZWU7DQo+ICsNCj4gKyAgICAgICByID0gYW1kZ3B1X2JvX3BpbihzYS0+cm9iaiwgQU1E
R1BVX0dFTV9ET01BSU5fR1RULCAmc2EtPmdwdV9hZGRyKTsNCj4gKyAgICAgICBpZiAocikNCj4g
KyAgICAgICAgICAgICAgIGdvdG8gZXJyb3JfdW5yZXNlcnZlOw0KPiArDQo+ICsgICAgICAgciA9
IGFtZGdwdV9ib19rbWFwKHNhLT5yb2JqLCAmcHRyKTsNCj4gKyAgICAgICBpZiAocikNCj4gKyAg
ICAgICAgICAgICAgIGdvdG8gZXJyb3JfdW5waW47DQo+ICsNCj4gKyAgICAgICBtZW1zZXQocHRy
LCAwLCBzaXplKTsNCj4gKyAgICAgICBhbWRncHVfYm9fdW5yZXNlcnZlKHNhLT5yb2JqKTsNCj4g
Kw0KPiArICAgICAgIHNhLT5zaXplID0gc2l6ZTsNCj4gKyAgICAgICBzYS0+Z2RzX2FkZHIgPSBz
YS0+Z3B1X2FkZHIgKyBQQUdFX1NJWkU7DQo+ICsNCj4gKyAgICAgICByZXR1cm4gMDsNCj4gKw0K
PiArZXJyb3JfdW5waW46DQo+ICsgICAgICAgYW1kZ3B1X2JvX3VucGluKHNhLT5yb2JqKTsNCj4g
K2Vycm9yX3VucmVzZXJ2ZToNCj4gKyAgICAgICBhbWRncHVfYm9fdW5yZXNlcnZlKHNhLT5yb2Jq
KTsNCj4gK2Vycm9yX2ZyZWU6DQo+ICsgICAgICAgYW1kZ3B1X2JvX3VucmVmKCZzYS0+cm9iaik7
DQo+ICsgICAgICAgcmV0dXJuIHI7DQo+ICt9DQo+ICsNCj4gK2ludCB4Z3B1X2FsbG9jYXRlX2Nz
YShzdHJ1Y3QgYW1kX3hncHUgKnhncHUpDQo+ICt7DQo+ICsgICAgICAgc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYgPSB4Z3B1LT5hZGV2Ow0KPiArICAgICAgIHN0cnVjdCBhbWRfeGdwdV9jc2Eg
KnNhID0gJnhncHUtPnNhOw0KPiArDQo+ICsgICAgICAgcmV0dXJuIHhncHVfaW5pdF9jc2EoYWRl
diwgc2EpOw0KPiArfQ0KPiArDQo+ICt2b2lkIHhncHVfZGVzdHJveV9jc2Eoc3RydWN0IGFtZF94
Z3B1X2NzYSAqc2EpDQo+ICt7DQo+ICsgICAgICAgYW1kZ3B1X2JvX3Jlc2VydmUoc2EtPnJvYmos
IHRydWUpOw0KPiArICAgICAgIGFtZGdwdV9ib191bnBpbihzYS0+cm9iaik7DQo+ICsgICAgICAg
YW1kZ3B1X2JvX3VucmVzZXJ2ZShzYS0+cm9iaik7DQo+ICsgICAgICAgYW1kZ3B1X2JvX3VucmVm
KCZzYS0+cm9iaik7DQo+ICsgICAgICAgc2EtPmdwdV9hZGRyID0gMDsNCj4gKyAgICAgICBzYS0+
Z2RzX2FkZHIgPSAwOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IHhncHVfdm1fbWFwX2NzYShz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0sDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBhbWRfeGdwdV9jc2EgKnNhKQ0KPiArew0KPiAr
ICAgICAgIGludCByOw0KPiArICAgICAgIHVpbnQ2NF90IHZhZGRyOw0KPiArICAgICAgIHN0cnVj
dCB3d19hY3F1aXJlX2N0eCB0aWNrZXQ7DQo+ICsgICAgICAgc3RydWN0IGxpc3RfaGVhZCBsaXN0
LCBkdXBsaWNhdGVzOw0KPiArICAgICAgIHN0cnVjdCBhbWRncHVfYm9fbGlzdF9lbnRyeSBwZDsN
Cj4gKyAgICAgICBzdHJ1Y3QgYW1kZ3B1X2JvX3ZhICpib192YTsNCj4gKw0KPiArICAgICAgIElO
SVRfTElTVF9IRUFEKCZsaXN0KTsNCj4gKyAgICAgICBJTklUX0xJU1RfSEVBRCgmZHVwbGljYXRl
cyk7DQo+ICsgICAgICAgSU5JVF9MSVNUX0hFQUQoJnZtLT5jc2EudHYuaGVhZCk7DQo+ICsgICAg
ICAgdm0tPmNzYS50di5ibyA9ICZzYS0+cm9iai0+dGJvOw0KPiArICAgICAgIHZtLT5jc2EudHYu
c2hhcmVkID0gdHJ1ZTsNCj4gKw0KPiArICAgICAgIGxpc3RfYWRkKCZ2bS0+Y3NhLnR2LmhlYWQs
ICZsaXN0KTsNCj4gKyAgICAgICBhbWRncHVfdm1fZ2V0X3BkX2JvKHZtLCAmbGlzdCwgJnBkKTsN
Cj4gKw0KPiArICAgICAgIHNwaW5fbG9jaygmdm0tPnN0YXR1c19sb2NrKTsNCj4gKyAgICAgICB2
bS0+Y3NhLnJlc2VydmVkX3RvcCAtPSBzYS0+c2l6ZTsNCj4gKyAgICAgICB2YWRkciA9IHZtLT5j
c2EucmVzZXJ2ZWRfdG9wOw0KPiArICAgICAgIHNwaW5fdW5sb2NrKCZ2bS0+c3RhdHVzX2xvY2sp
Ow0KPiArDQo+ICsgICAgICAgciA9IHR0bV9ldV9yZXNlcnZlX2J1ZmZlcnMoJnRpY2tldCwgJmxp
c3QsIHRydWUsICZkdXBsaWNhdGVzKTsNCj4gKyAgICAgICBpZiAocikgew0KPiArICAgICAgICAg
ICAgICAgRFJNX0VSUk9SKCJmYWlsZWQgdG8gcmVzZXJ2ZSBnbG9iYWwgQ1NBIGJ1ZmZlciglZCku
XG4iLCByKTsNCj4gKyAgICAgICAgICAgICAgIHJldHVybiByOw0KPiArICAgICAgIH0NCj4gKw0K
PiArICAgICAgIGJvX3ZhID0gYW1kZ3B1X3ZtX2JvX2FkZChhZGV2LCB2bSwgc2EtPnJvYmopOw0K
PiArICAgICAgIGlmICghYm9fdmEpIHsNCj4gKyAgICAgICAgICAgICAgIERSTV9FUlJPUigiZmFp
bGVkIHRvIGNyZWF0ZSBib192YSBmb3IgZ2xvYmFsIENTQSBidWZmZXIuXG4iKTsNCj4gKyAgICAg
ICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiArICAgICAgIH0NCj4gKw0KPiArDQo+ICsgICAg
ICAgciA9IGFtZGdwdV92bV9ib19tYXAoYWRldiwgYm9fdmEsIHZhZGRyLCAwLCBzYS0+c2l6ZSwN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBBTURHUFVfUFRFX1JFQURBQkxFIHwgQU1E
R1BVX1BURV9XUklURUFCTEUgfA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFNREdQ
VV9QVEVfRVhFQ1VUQUJMRSk7DQo+ICsgICAgICAgaWYgKHIpIHsNCj4gKyAgICAgICAgICAgICAg
IERSTV9FUlJPUigiZmFpbGVkIHRvIGRvIGJvX21hcCBvbiBnbG9iYWwgQ1NBIGJ1ZmZlciglZCku
XG4iLCByKTsNCj4gKyAgICAgICAgICAgICAgIGFtZGdwdV92bV9ib19ybXYoYWRldiwgYm9fdmEp
Ow0KPiArICAgICAgICAgICAgICAgdHRtX2V1X2JhY2tvZmZfcmVzZXJ2YXRpb24oJnRpY2tldCwg
Jmxpc3QpOw0KPiArICAgICAgICAgICAgICAga2ZyZWUoYm9fdmEpOw0KPiArICAgICAgICAgICAg
ICAgcmV0dXJuIHI7DQo+ICsgICAgICAgfQ0KPiArDQo+ICsgICAgICAgdHRtX2V1X2JhY2tvZmZf
cmVzZXJ2YXRpb24oJnRpY2tldCwgJmxpc3QpOw0KPiArICAgICAgIGFtZGdwdV9nZW1fdmFfdXBk
YXRlX3ZtKGFkZXYsIGJvX3ZhLCBBTURHUFVfVkFfT1BfTUFQKTsNCj4gKw0KPiArICAgICAgIHZt
LT5jc2EudmEgPSBib192YTsNCj4gKyAgICAgICB2bS0+Y3NhLmNzYV9hZGRyID0gdmFkZHI7DQo+
ICsgICAgICAgdm0tPmNzYS5nZHNfYWRkciA9IHZhZGRyICsgUEFHRV9TSVpFOw0KPiArDQo+ICsg
ICAgICAgcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK2ludCBhbWRncHVfdm1fbWFwX2NzYShzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0pDQo+ICt7DQo+ICsg
ICAgICAgc3RydWN0IGFtZF94Z3B1ICp4Z3B1ID0gKHN0cnVjdCBhbWRfeGdwdSAqKWFkZXYtPnBy
aXZfZGF0YTsNCj4gKyAgICAgICBzdHJ1Y3QgYW1kX3hncHVfY3NhICpzYSA9IE5VTEw7DQo+ICsN
Cj4gKyAgICAgICBpZiAoIXhncHUpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gKw0K
PiArICAgICAgIHNhID0gJnhncHUtPnNhOw0KPiArDQo+ICsgICAgICAgcmV0dXJuIHhncHVfdm1f
bWFwX2NzYShhZGV2LCB2bSwgc2EpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCB4Z3B1X3Zt
X3VubWFwX2NzYShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAq
dm0sDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBhbWRfeGdwdV9jc2Eg
KnNhKQ0KPiArew0KPiArICAgICAgIGludCByOw0KPiArICAgICAgIHN0cnVjdCB3d19hY3F1aXJl
X2N0eCB0aWNrZXQ7DQo+ICsgICAgICAgc3RydWN0IGxpc3RfaGVhZCBsaXN0LCBkdXBsaWNhdGVz
Ow0KPiArICAgICAgIHN0cnVjdCBhbWRncHVfYm9fbGlzdF9lbnRyeSBwZDsNCj4gKw0KPiArICAg
ICAgIGlmICghdm0tPmNzYS52YSkNCj4gKyAgICAgICAgICAgICAgIHJldHVybjsNCj4gKw0KPiAr
ICAgICAgIElOSVRfTElTVF9IRUFEKCZsaXN0KTsNCj4gKyAgICAgICBJTklUX0xJU1RfSEVBRCgm
ZHVwbGljYXRlcyk7DQo+ICsgICAgICAgbGlzdF9hZGQoJnZtLT5jc2EudHYuaGVhZCwgJmxpc3Qp
Ow0KPiArICAgICAgIGFtZGdwdV92bV9nZXRfcGRfYm8odm0sICZsaXN0LCAmcGQpOw0KPiArDQo+
ICsgICAgICAgciA9IHR0bV9ldV9yZXNlcnZlX2J1ZmZlcnMoJnRpY2tldCwgJmxpc3QsIHRydWUs
ICZkdXBsaWNhdGVzKTsNCj4gKyAgICAgICBpZiAocikgew0KPiArICAgICAgICAgICAgICAgRFJN
X0VSUk9SKCJmYWlsZWQgdG8gcmVzZXJ2ZSBnbG9iYWwgQ1NBIGJ1ZmZlciglZCkuXG4iLCByKTsN
Cj4gKyAgICAgICAgICAgICAgIHJldHVybjsNCj4gKyAgICAgICB9DQo+ICsNCj4gKyAgICAgICBh
bWRncHVfdm1fYm9fcm12KGFkZXYsIHZtLT5jc2EudmEpOw0KPiArICAgICAgIC8qIG1heWJlIHdl
IGRvbid0IG5lZWQgdG8gZG8gcmVhbCBjbGVhcmluZyBmb3IgdGhlIHZtIHdpbGwgZGllIHNvb24g
Ki8NCj4gKyAgICAgICByID0gYW1kZ3B1X3ZtX2NsZWFyX2ZyZWVkKGFkZXYsIHZtKTsNCj4gKyAg
ICAgICBpZiAocikgew0KPiArICAgICAgICAgICAgICAgRFJNX0VSUk9SKCJmYWlsZWQgdG8gY2xl
YXIgZ2xvYmFsIENTQSBibyglZCkuXG4iLCByKTsNCj4gKyAgICAgICAgICAgICAgIHJldHVybjsN
Cj4gKyAgICAgICB9DQo+ICsNCj4gKyAgICAgICB0dG1fZXVfYmFja29mZl9yZXNlcnZhdGlvbigm
dGlja2V0LCAmbGlzdCk7DQo+ICsgICAgICAgdm0tPmNzYS52YSA9IE5VTEw7DQo+ICsgICAgICAg
dm0tPmNzYS5jc2FfYWRkciA9IHZtLT5jc2EuZ2RzX2FkZHIgPSAwOw0KPiArfQ0KPiArDQo+ICt2
b2lkIGFtZGdwdV92bV91bm1hcF9jc2Eoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVj
dCBhbWRncHVfdm0gKnZtKQ0KPiArew0KPiArICAgICAgIHN0cnVjdCBhbWRfeGdwdSAqeGdwdSA9
IChzdHJ1Y3QgYW1kX3hncHUgKilhZGV2LT5wcml2X2RhdGE7DQo+ICsgICAgICAgc3RydWN0IGFt
ZF94Z3B1X2NzYSAqc2EgPSBOVUxMOw0KPiArDQo+ICsgICAgICAgaWYgKCF4Z3B1KQ0KPiArICAg
ICAgICAgICAgICAgcmV0dXJuOw0KPiArDQo+ICsgICAgICAgc2EgPSAmeGdwdS0+c2E7DQo+ICsg
ICAgICAgeGdwdV92bV91bm1hcF9jc2EoYWRldiwgdm0sIHNhKTsNCj4gK30NCj4gLS0NCj4gMi43
LjQNCj4NCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18N
Cj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QNCj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc8
bWFpbHRvOmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPg0KPiBodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngNCg==

--_000_CY4PR12MB1701351D6DCEA18714735B3DEB900CY4PR12MB1701namp_
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
libri&quot;,sans-serif;color:#1F497D">Thank monk=A1=AFs detail expanation.<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">And I think this patch is only suppor=
t virtualization world switch, not touch whole amdpgu preemption.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">Thanks!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">Xiangliang Yu<o:p></o:p></span></p>
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
<b>Sent:</b> Tuesday, December 20, 2016 11:58 AM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;; Yu, Xiangliang &lt;X=
iangliang.Yu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;; dl.SRDC_SW_G=
PUVirtualization &lt;dl.SRDC_SW_GPUVirtualization-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> </span><span lang=3D"ZH-CN" style=3D"font-size:11.0pt">=B4=
=F0=B8=B4</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&q=
uot;,sans-serif">: [PATCH 11/23] drm/amdgpu: implement context save area(CS=
A) feature<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div id=3D"x_divtagdefaultwrapper">
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">t=
he CSA is used for world switch, and each amdgpu device should have one and=
 only one CSA,<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">a=
nd this CSA will pined, and mapped to each virtual memory /process.<o:p></o=
:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"><=
o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">C=
P/RLCV will use this CSA buffer when preemption occurred, and will write so=
me hardware status into this CSA buffer, within the current IB's context (t=
hat's why need do mapping for each virtual memory
 on CSA)<o:p></o:p></span></p>
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
 7:20:09<br>
</span><b><span lang=3D"ZH-CN" style=3D"font-size:11.0pt;color:black">=CA=
=D5=BC=FE=C8=CB</span></b><b><span style=3D"font-size:11.0pt;font-family:&q=
uot;Calibri&quot;,sans-serif;color:black">:</span></b><span style=3D"font-s=
ize:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Yu, Xia=
ngliang<br>
</span><b><span lang=3D"ZH-CN" style=3D"font-size:11.0pt;color:black">=B3=
=AD=CB=CD</span></b><b><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black">:</span></b><span style=3D"font-size:11=
.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> amd-gfx list;
 dl.SRDC_SW_GPUVirtualization; Liu, Monk<br>
</span><b><span lang=3D"ZH-CN" style=3D"font-size:11.0pt;color:black">=D6=
=F7=CC=E2</span></b><b><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black">:</span></b><span style=3D"font-size:11=
.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Re: [PATCH
 11/23] drm/amdgpu: implement context save area(CSA) feature</span> <o:p></=
o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt">On Sat, Dec 17, 201=
6 at 11:16 AM, Xiangliang Yu &lt;<a href=3D"mailto:Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org">X=
iangliang.Yu-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br>
&gt; CSA is need by world switch. This patch implement CSA feature and<br>
&gt; bind it to each VM, so hardware can save the state into the area<br>
&gt; and restore it when running again.<br>
&gt;<br>
&gt; Signed-off-by: Monk Liu &lt;<a href=3D"mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">Monk.L=
iu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; Signed-off-by: Xiangliang Yu &lt;<a href=3D"mailto:Xiangliang.Yu@amd.c=
om">Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<br>
Isn't the CSA actually for preemption?&nbsp; Preemption is useful outside<b=
r>
of the VF case as well so it should be untangled from the mxgpu code<br>
so it can be utilized independently.<br>
<br>
Alex<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |&nbsp; 14 &#43;&#43;&#=
43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c&nbsp;&nbsp; |&nbsp;&nbsp;=
 8 &#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h&nbsp;&nbsp; |&nbsp;&nbsp;=
 4 &#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/mxgpu/amd_mxgpu.h&nbsp;&nbsp;&nbsp; |&nbsp; =
12 &#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/mxgpu/mxgpu_csa.c&nbsp;&nbsp;&nbsp; | 209 &#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;<br>
&gt;&nbsp; 5 files changed, 247 insertions(&#43;)<br>
&gt;&nbsp; create mode 100644 drivers/gpu/drm/amd/mxgpu/mxgpu_csa.c<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_virt.h<br>
&gt; index 8ee70f8..dff1248 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
&gt; @@ -24,6 &#43;24,8 @@<br>
&gt;&nbsp; #ifndef AMDGPU_VIRT_H<br>
&gt;&nbsp; #define AMDGPU_VIRT_H<br>
&gt;<br>
&gt; &#43;struct amdgpu_vm;<br>
&gt; &#43;<br>
&gt;&nbsp; #define AMDGPU_SRIOV_CAPS_SRIOV_VBIOS&nbsp; (1 &lt;&lt; 0) /* vB=
IOS is sr-iov ready */<br>
&gt;&nbsp; #define AMDGPU_SRIOV_CAPS_ENABLE_IOV&nbsp;&nbsp; (1 &lt;&lt; 1) =
/* sr-iov is enabled on this GPU */<br>
&gt;&nbsp; #define AMDGPU_SRIOV_CAPS_IS_VF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; (1 &lt;&lt; 2) /* this GPU is a virtual function */<br>
&gt; @@ -33,6 &#43;35,14 @@ struct amdgpu_virtualization {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t virtual_caps;=
<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt; &#43;struct amdgpu_csa {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_va&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *va;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_validate_buffer&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; tv;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reserved_top;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; csa_addr;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gds_addr;<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt;&nbsp; #define amdgpu_sriov_enabled(adev) \<br>
&gt;&nbsp; ((adev)-&gt;virtualization.virtual_caps &amp; AMDGPU_SRIOV_CAPS_=
ENABLE_IOV)<br>
&gt;<br>
&gt; @@ -55,4 &#43;65,8 @@ static inline bool is_virtual_machine(void)<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt;&nbsp; int amd_xgpu_set_ip_blocks(struct amdgpu_device *adev);<br>
&gt; &#43;<br>
&gt; &#43;/* Context Save Area functions */<br>
&gt; &#43;int amdgpu_vm_map_csa(struct amdgpu_device *adev, struct amdgpu_v=
m *vm);<br>
&gt; &#43;void amdgpu_vm_unmap_csa(struct amdgpu_device *adev, struct amdgp=
u_vm *vm);<br>
&gt;&nbsp; #endif<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm.c<br>
&gt; index d05546e..98540d9 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; @@ -1539,6 &#43;1539,8 @@ int amdgpu_vm_init(struct amdgpu_device *ade=
v, struct amdgpu_vm *vm)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pd_size =3D amdgpu_vm_=
directory_size(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pd_entries =3D amdgpu_=
vm_num_pdes(adev);<br>
&gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;csa.reserved_top =3D =
AMDGPU_VA_RESERVED_SIZE;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* allocate page table=
 array */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;page_tables =3D=
 drm_calloc_large(pd_entries, sizeof(struct amdgpu_vm_pt));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vm-&gt;page_tables=
 =3D=3D NULL) {<br>
&gt; @@ -1576,6 &#43;1578,10 @@ int amdgpu_vm_init(struct amdgpu_device *ad=
ev, struct amdgpu_vm *vm)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;last_eviction_c=
ounter =3D atomic64_read(&amp;adev-&gt;num_evictions);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(vm=
-&gt;page_directory);<br>
&gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vm_map_csa(adev=
, vm);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto error_free_page_directory;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;<br>
&gt;&nbsp; error_free_page_directory:<br>
&gt; @@ -1606,6 &#43;1612,8 @@ void amdgpu_vm_fini(struct amdgpu_device *ad=
ev, struct amdgpu_vm *vm)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_va_ma=
pping *mapping, *tmp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_unmap_csa(adev, vm=
);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd_sched_entity_fini(=
vm-&gt;entity.sched, &amp;vm-&gt;entity);<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!RB_EMPTY_ROOT(&am=
p;vm-&gt;va)) {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm.h<br>
&gt; index 42a629b..d90630a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
&gt; @@ -29,6 &#43;29,7 @@<br>
&gt;&nbsp; #include &quot;gpu_scheduler.h&quot;<br>
&gt;&nbsp; #include &quot;amdgpu_sync.h&quot;<br>
&gt;&nbsp; #include &quot;amdgpu_ring.h&quot;<br>
&gt; &#43;#include &quot;amdgpu_virt.h&quot;<br>
&gt;<br>
&gt;&nbsp; struct amdgpu_bo_va;<br>
&gt;&nbsp; struct amdgpu_job;<br>
&gt; @@ -109,6 &#43;110,9 @@ struct amdgpu_vm {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Scheduler entity fo=
r page table updates */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_sched_entit=
y entity;<br>
&gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Context Save Area */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_csa&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; csa;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* client id */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; client_id;<br>
&gt;&nbsp; };<br>
&gt; diff --git a/drivers/gpu/drm/amd/mxgpu/amd_mxgpu.h b/drivers/gpu/drm/a=
md/mxgpu/amd_mxgpu.h<br>
&gt; index 6ab13bc..a25e07f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/mxgpu/amd_mxgpu.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/mxgpu/amd_mxgpu.h<br>
&gt; @@ -26,12 &#43;26,24 @@<br>
&gt;<br>
&gt;&nbsp; #include &quot;amdgpu.h&quot;<br>
&gt;<br>
&gt; &#43;/* xgpu structures */<br>
&gt; &#43;struct amd_xgpu_csa {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *robj;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; gpu_addr;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; gds_addr;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32_t&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; size;<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt;&nbsp; struct amd_xgpu {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device&n=
bsp;&nbsp;&nbsp; *adev;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lock;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_xgpu_csa&nbsp;&nb=
sp;&nbsp;&nbsp; sa;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; reg_val_offs;<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; extern int amd_xgpu_alloc(struct amdgpu_device *adev);<br>
&gt;&nbsp; extern void amd_xgpu_free(struct amd_xgpu *xgpu);<br>
&gt; &#43;<br>
&gt; &#43;extern int xgpu_allocate_csa(struct amd_xgpu *xgpu);<br>
&gt; &#43;extern void xgpu_destroy_csa(struct amd_xgpu_csa *csa);<br>
&gt;&nbsp; #endif<br>
&gt; diff --git a/drivers/gpu/drm/amd/mxgpu/mxgpu_csa.c b/drivers/gpu/drm/a=
md/mxgpu/mxgpu_csa.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..246a747<br>
&gt; --- /dev/null<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/mxgpu/mxgpu_csa.c<br>
&gt; @@ -0,0 &#43;1,209 @@<br>
&gt; &#43;/*<br>
&gt; &#43; * Copyright 2016 Advanced Micro Devices, Inc.<br>
&gt; &#43; *<br>
&gt; &#43; * Permission is hereby granted, free of charge, to any person ob=
taining a<br>
&gt; &#43; * copy of this software and associated documentation files (the =
&quot;Software&quot;),<br>
&gt; &#43; * to deal in the Software without restriction, including without=
 limitation<br>
&gt; &#43; * the rights to use, copy, modify, merge, publish, distribute, s=
ublicense,<br>
&gt; &#43; * and/or sell copies of the Software, and to permit persons to w=
hom the<br>
&gt; &#43; * Software is furnished to do so, subject to the following condi=
tions:<br>
&gt; &#43; *<br>
&gt; &#43; * The above copyright notice and this permission notice shall be=
 included in<br>
&gt; &#43; * all copies or substantial portions of the Software.<br>
&gt; &#43; *<br>
&gt; &#43; * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY O=
F ANY KIND, EXPRESS OR<br>
&gt; &#43; * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHA=
NTABILITY,<br>
&gt; &#43; * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN=
 NO EVENT SHALL<br>
&gt; &#43; * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, =
DAMAGES OR<br>
&gt; &#43; * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTH=
ERWISE,<br>
&gt; &#43; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE=
 USE OR<br>
&gt; &#43; * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; &#43; *<br>
&gt; &#43; * Authors: <a href=3D"mailto:Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org">Xiangliang.Y=
u@amd.com</a><br>
&gt; &#43; *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"mai=
lto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">Monk.Liu-5C7GfCeVMHo@public.gmane.org</a><br>
&gt; &#43; *<br>
&gt; &#43; */<br>
&gt; &#43;#include &quot;amd_mxgpu.h&quot;<br>
&gt; &#43;#include &quot;vid.h&quot;<br>
&gt; &#43;<br>
&gt; &#43;static int xgpu_init_csa(struct amdgpu_device *adev, struct amd_x=
gpu_csa *sa)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, size;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *ptr;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* meta data (4k) &#43; gds-=
gfx (4k)*/<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =3D PAGE_SIZE &#43; ade=
v-&gt;gds.mem.gfx_partition_size;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_create(adev,=
 size, PAGE_SIZE, true,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_GTT,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_CREATE_CPU_GTT_USWC,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; NULL, NULL, &amp;sa-&gt;robj);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;(%d) failed to allocate csa=
 bo\n&quot;, r);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_reserve(sa-&=
gt;robj, true);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(r !=3D 0))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto error_free;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_pin(sa-&gt;r=
obj, AMDGPU_GEM_DOMAIN_GTT, &amp;sa-&gt;gpu_addr);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto error_unreserve;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_kmap(sa-&gt;=
robj, &amp;ptr);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto error_unpin;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(ptr, 0, size);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(sa-&gt;r=
obj);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sa-&gt;size =3D size;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sa-&gt;gds_addr =3D sa-&gt;g=
pu_addr &#43; PAGE_SIZE;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;<br>
&gt; &#43;error_unpin:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unpin(sa-&gt;robj)=
;<br>
&gt; &#43;error_unreserve:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(sa-&gt;r=
obj);<br>
&gt; &#43;error_free:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unref(&amp;sa-&gt;=
robj);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;int xgpu_allocate_csa(struct amd_xgpu *xgpu)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D xgpu-&gt;adev;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_xgpu_csa *sa =3D =
&amp;xgpu-&gt;sa;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return xgpu_init_csa(adev, s=
a);<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;void xgpu_destroy_csa(struct amd_xgpu_csa *sa)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_reserve(sa-&gt;rob=
j, true);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unpin(sa-&gt;robj)=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(sa-&gt;r=
obj);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unref(&amp;sa-&gt;=
robj);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sa-&gt;gpu_addr =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sa-&gt;gds_addr =3D 0;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static int xgpu_vm_map_csa(struct amdgpu_device *adev, struct amd=
gpu_vm *vm,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct amd_xgpu_csa *sa)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t vaddr;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ww_acquire_ctx ticket=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head list, dupli=
cates;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_list_entry =
pd;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_va *bo_va;<=
br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;list);<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;duplicat=
es);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;vm-&gt;c=
sa.tv.head);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;csa.tv.bo =3D &amp;sa=
-&gt;robj-&gt;tbo;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;csa.tv.shared =3D tru=
e;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add(&amp;vm-&gt;csa.tv.=
head, &amp;list);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_get_pd_bo(vm, &amp=
;list, &amp;pd);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;vm-&gt;status=
_lock);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;csa.reserved_top -=3D=
 sa-&gt;size;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vaddr =3D vm-&gt;csa.reserve=
d_top;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;vm-&gt;stat=
us_lock);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D ttm_eu_reserve_buffers=
(&amp;ticket, &amp;list, true, &amp;duplicates);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed to reserve global CSA buffer(%d)=
.\n&quot;, r);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_va =3D amdgpu_vm_bo_add(a=
dev, vm, sa-&gt;robj);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bo_va) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed to create bo_va for global CSA b=
uffer.\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vm_bo_map(adev,=
 bo_va, vaddr, 0, sa-&gt;size,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; AMDGPU_PTE_EXECUTABLE);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed to do bo_map on global CSA buffe=
r(%d).\n&quot;, r);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_vm_bo_rmv(adev, bo_va);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ttm_eu_backoff_reservation(&amp;ticket, &amp;list);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; kfree(bo_va);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_eu_backoff_reservation(&=
amp;ticket, &amp;list);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gem_va_update_vm(adev=
, bo_va, AMDGPU_VA_OP_MAP);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;csa.va =3D bo_va;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;csa.csa_addr =3D vadd=
r;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;csa.gds_addr =3D vadd=
r &#43; PAGE_SIZE;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;int amdgpu_vm_map_csa(struct amdgpu_device *adev, struct amdgpu_v=
m *vm)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_xgpu *xgpu =3D (s=
truct amd_xgpu *)adev-&gt;priv_data;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_xgpu_csa *sa =3D =
NULL;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!xgpu)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sa =3D &amp;xgpu-&gt;sa;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return xgpu_vm_map_csa(adev,=
 vm, sa);<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static void xgpu_vm_unmap_csa(struct amdgpu_device *adev, struct =
amdgpu_vm *vm,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_xgpu_csa *sa)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ww_acquire_ctx ticket=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head list, dupli=
cates;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_list_entry =
pd;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vm-&gt;csa.va)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;list);<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;duplicat=
es);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add(&amp;vm-&gt;csa.tv.=
head, &amp;list);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_get_pd_bo(vm, &amp=
;list, &amp;pd);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D ttm_eu_reserve_buffers=
(&amp;ticket, &amp;list, true, &amp;duplicates);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed to reserve global CSA buffer(%d)=
.\n&quot;, r);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_bo_rmv(adev, vm-&g=
t;csa.va);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* maybe we don't need to do=
 real clearing for the vm will die soon */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vm_clear_freed(=
adev, vm);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed to clear global CSA bo(%d).\n&qu=
ot;, r);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_eu_backoff_reservation(&=
amp;ticket, &amp;list);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;csa.va =3D NULL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;csa.csa_addr =3D vm-&=
gt;csa.gds_addr =3D 0;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;void amdgpu_vm_unmap_csa(struct amdgpu_device *adev, struct amdgp=
u_vm *vm)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_xgpu *xgpu =3D (s=
truct amd_xgpu *)adev-&gt;priv_data;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_xgpu_csa *sa =3D =
NULL;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!xgpu)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sa =3D &amp;xgpu-&gt;sa;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xgpu_vm_unmap_csa(adev, vm, =
sa);<br>
&gt; &#43;}<br>
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

--_000_CY4PR12MB1701351D6DCEA18714735B3DEB900CY4PR12MB1701namp_--

--===============0324868073==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0324868073==--
