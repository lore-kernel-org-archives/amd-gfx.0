From: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] [WIP]drm/ttm: add waiter list to prevent allocation
 not in order
Date: Fri, 26 Jan 2018 12:36:40 +0000
Message-ID: <45073.2861798771$1516970090@news.gmane.org>
References: <20180126102247.17923-1-david1.zhou@amd.com>,
 <2beeea26-9426-6956-fbc7-ada52088b6a6@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0660601885=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <2beeea26-9426-6956-fbc7-ada52088b6a6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, thomas <thomas-4+hqylr40dJg9hUCZPvPmw@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0660601885==
Content-Language: en-US
Content-Type: multipart/alternative; boundary="_000_smartisan1516970199102_"

--_000_smartisan1516970199102_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SSBhbSBvZmYgd29yaywgc28gcmVwbHkgbWFpbCBieSBwaG9uZSwgdGhlIGZvcm1hdCBjb3VsZCBu
b3QgYmUgdGV4dC4NCg0KYmFjayB0byB0b3BpYyBpdHNlbGY6DQp0aGUgcHJvYmxlbSBpbmRlZWQg
aGFwcGVuIG9uIGFtZGdwdSBkcml2ZXIsIHNvbWVvbmUgcmVwb3J0cyBtZSB0aGF0IGFwcGxpY2F0
aW9uIHJ1bnMgd2l0aCB0d28gaW5zdGFuY2VzLCB0aGUgcGVyZm9ybWFuY2UgYXJlIGRpZmZlcmVu
dC4NCkkgYWxzbyByZXByb2R1Y2VkIHRoZSBpc3N1ZSB3aXRoIHVuaXQgdGVzdChib19ldmljdGlv
bl90ZXN0KS4gVGhleSBhbHdheXMgdGhpbmsgb3VyIHNjaGVkdWxlciBpc24ndCB3b3JraW5nIGFz
IGV4cGVjdGVkLg0KDQpBZnRlciBteSBpbnZlc3RpZ2F0aW9uLCB0aGlzIGlzc3VlIHNob3VsZCBi
ZSBkZXRlY3Qgb2YgVFRNIGRlc2lnbiBzZWxmLCB3aGljaCBicmVha3Mgc2NoZWR1bGluZyBiYWxh
bmNlLg0KDQpGdXJ0aGVyLCBpZiB3ZSBydW4gY29udGFpbmVycyBmb3Igb3VyIGdwdSwgY29udGFp
bmVyIEEgY291bGQgcnVuIGhpZ2ggc2NvcmUsIGNvbnRhaW5lciBCIHJ1bnMgbG93IHNjb3JlIHdp
dGggc2FtZSBiZW5jaG1hcmsuDQoNClNvIHRoaXMgaXMgYnVnIHRoYXQgd2UgbmVlZCBmaXguDQoN
ClJlZ2FyZHMsDQpEYXZpZCBaaG91DQoNCg0Kt6LX1LzhufsgUHJvDQoNCkNocmlzdGlhbiBL9m5p
ZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+INPaIDIwMTjE6jHUwjI2yNUgz8LO
5zY6MzHQtLXAo7oNCg0KQW0gMjYuMDEuMjAxOCB1bSAxMToyMiBzY2hyaWViIENodW5taW5nIFpo
b3U6DQo+IHRoZXJlIGlzIGEgc2NoZWR1bGluZyBiYWxhbmNlIGlzc3VlIGFib3V0IGdldCBub2Rl
IGxpa2U6DQo+IGEuIHByb2Nlc3MgQSBhbGxvY2F0ZXMgZnVsbCBtZW1vcnkgYW5kIHVzZSBpdCBm
b3Igc3VibWlzc2lvbi4NCj4gYi4gcHJvY2VzcyBCIHRyaWVzIHRvIGFsbG9jYXRlcyBtZW1vcnks
IHdpbGwgd2FpdCBmb3IgcHJvY2VzcyBBIEJPIGlkbGUgaW4gZXZpY3Rpb24uDQo+IGMuIHByb2Nl
c3MgQSBjb21wbGV0ZXMgdGhlIGpvYiwgcHJvY2VzcyBCIGV2aWN0aW9uIHdpbGwgcHV0IHByb2Nl
c3MgQSBCTyBub2RlLA0KPiBidXQgaW4gdGhlIG1lYW50aW1lLCBwcm9jZXNzIEMgaXMgY29tbWlu
ZyB0byBhbGxvY2F0ZSBCTywgd2hpbGwgZGlyZWN0bHkgZ2V0IG5vZGUgc3VjY2Vzc2Z1bGx5LCBh
bmQgZG8gc3VibWlzc2lvbiwNCj4gcHJvY2VzcyBCIHdpbGwgYWdhaW4gd2FpdCBmb3IgcHJvY2Vz
cyBDIEJPIGlkbGUuDQo+IGQuIHJlcGVhdCB0aGUgYWJvdmUgc2V0cHMsIHByb2Nlc3MgQiBjb3Vs
ZCBiZSBkZWxheWVkIG11Y2ggbW9yZS4NCj4NCj4gbGF0ZXIgYWxsb2NhdGlvbiBtdXN0IG5vdCBi
ZSBhaGVhZCBvZiBmcm9udCBpbiBzYW1lIHBsYWNlLg0KDQpBZ2FpbiBOQUsgdG8gdGhlIHdob2xl
IGFwcHJvYWNoLg0KDQpBdCBsZWFzdCB3aXRoIGFtZGdwdSB0aGUgcHJvYmxlbSB5b3UgZGVzY3Jp
YmVkIGFib3ZlIG5ldmVyIG9jY3Vycw0KYmVjYXVzZSBldmljdGlvbnMgYXJlIHBpcGVsaW5lZCBv
cGVyYXRpb25zLiBXZSBjb3VsZCBvbmx5IGJsb2NrIGZvcg0KZGVsZXRlZCByZWdpb25zIHRvIGJl
Y29tZSBmcmVlLg0KDQpCdXQgaW5kZXBlbmRlbnQgb2YgdGhhdCBpbmNvbWluZyBtZW1vcnkgcmVx
dWVzdHMgd2hpbGUgd2UgbWFrZSByb29tIGZvcg0KZXZpY3Rpb24gYXJlIGludGVuZGVkIHRvIGJl
IHNlcnZlZCBmaXJzdC4NCg0KQ2hhbmdpbmcgdGhhdCBpcyBjZXJ0YWlubHkgYSBuby1nbyBjYXVz
ZSB0aGF0IHdvdWxkIGZhdm9yIG1lbW9yeSBodW5ncnkNCmFwcGxpY2F0aW9ucyBvdmVyIHNtYWxs
IGNsaWVudHMuDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoNCj4NCj4gQ2hhbmdlLUlkOiBJM2Rh
YTg5MmU1MGY4MjIyNmM1NTJjYzAwOGEyOWU1NTg5NGE5OGYxOA0KPiBTaWduZWQtb2ZmLWJ5OiBD
aHVubWluZyBaaG91IDxkYXZpZDEuemhvdUBhbWQuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dw
dS9kcm0vdHRtL3R0bV9iby5jICAgIHwgNjkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLS0NCj4gICBpbmNsdWRlL2RybS90dG0vdHRtX2JvX2FwaS5oICAgIHwgIDcgKysr
KysNCj4gICBpbmNsdWRlL2RybS90dG0vdHRtX2JvX2RyaXZlci5oIHwgIDcgKysrKysNCj4gICAz
IGZpbGVzIGNoYW5nZWQsIDgwIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+DQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jIGIvZHJpdmVycy9ncHUvZHJt
L3R0bS90dG1fYm8uYw0KPiBpbmRleCBkMzNhNmJiNzQyYTEuLjU1OGVjMmNmNDY1ZCAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vdHRtL3R0bV9iby5jDQo+IEBAIC04NDEsNiArODQxLDU4IEBAIHN0YXRpYyBpbnQgdHRt
X2JvX2FkZF9tb3ZlX2ZlbmNlKHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8sDQo+ICAgICAg
ICByZXR1cm4gMDsNCj4gICB9DQo+DQo+ICtzdGF0aWMgdm9pZCB0dG1fbWFuX2luaXRfd2FpdGVy
KHN0cnVjdCB0dG1fYm9fd2FpdGVyICp3YWl0ZXIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8sDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCB0dG1fcGxhY2UgKnBsYWNlKQ0KPiArew0KPiArICAg
ICB3YWl0ZXItPnRibyA9IGJvOw0KPiArICAgICBtZW1jcHkoKHZvaWQgKikmd2FpdGVyLT5wbGFj
ZSwgKHZvaWQgKilwbGFjZSwgc2l6ZW9mKCpwbGFjZSkpOw0KPiArICAgICBJTklUX0xJU1RfSEVB
RCgmd2FpdGVyLT5saXN0KTsNCj4gK30NCj4gKw0KPiArc3RhdGljIHZvaWQgdHRtX21hbl9hZGRf
d2FpdGVyKHN0cnVjdCB0dG1fbWVtX3R5cGVfbWFuYWdlciAqbWFuLA0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHN0cnVjdCB0dG1fYm9fd2FpdGVyICp3YWl0ZXIpDQo+ICt7DQo+ICsg
ICAgIGlmICghd2FpdGVyKQ0KPiArICAgICAgICAgICAgIHJldHVybjsNCj4gKyAgICAgc3Bpbl9s
b2NrKCZtYW4tPndhaXRfbG9jayk7DQo+ICsgICAgIGxpc3RfYWRkX3RhaWwoJndhaXRlci0+bGlz
dCwgJm1hbi0+d2FpdGVyX2xpc3QpOw0KPiArICAgICBzcGluX3VubG9jaygmbWFuLT53YWl0X2xv
Y2spOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCB0dG1fbWFuX2RlbF93YWl0ZXIoc3RydWN0
IHR0bV9tZW1fdHlwZV9tYW5hZ2VyICptYW4sDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc3RydWN0IHR0bV9ib193YWl0ZXIgKndhaXRlcikNCj4gK3sNCj4gKyAgICAgaWYgKCF3YWl0
ZXIpDQo+ICsgICAgICAgICAgICAgcmV0dXJuOw0KPiArICAgICBzcGluX2xvY2soJm1hbi0+d2Fp
dF9sb2NrKTsNCj4gKyAgICAgaWYgKCFsaXN0X2VtcHR5KCZ3YWl0ZXItPmxpc3QpKQ0KPiArICAg
ICAgICAgICAgIGxpc3RfZGVsKCZ3YWl0ZXItPmxpc3QpOw0KPiArICAgICBzcGluX3VubG9jaygm
bWFuLT53YWl0X2xvY2spOw0KPiArICAgICBrZnJlZSh3YWl0ZXIpOw0KPiArfQ0KPiArDQo+ICtp
bnQgdHRtX21hbl9jaGVja19ibyhzdHJ1Y3QgdHRtX21lbV90eXBlX21hbmFnZXIgKm1hbiwNCj4g
KyAgICAgICAgICAgICAgICAgIHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8sDQo+ICsgICAg
ICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3QgdHRtX3BsYWNlICpwbGFjZSkNCj4gK3sNCj4gKyAg
ICAgc3RydWN0IHR0bV9ib193YWl0ZXIgKndhaXRlciwgKnRtcDsNCj4gKw0KPiArICAgICBzcGlu
X2xvY2soJm1hbi0+d2FpdF9sb2NrKTsNCj4gKyAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZl
KHdhaXRlciwgdG1wLCAmbWFuLT53YWl0ZXJfbGlzdCwgbGlzdCkgew0KPiArICAgICAgICAgICAg
IGlmICgoYm8gIT0gd2FpdGVyLT50Ym8pICYmDQo+ICsgICAgICAgICAgICAgICAgICgocGxhY2Ut
PmZwZm4gPj0gd2FpdGVyLT5wbGFjZS5mcGZuICYmDQo+ICsgICAgICAgICAgICAgICAgICAgcGxh
Y2UtPmZwZm4gPD0gd2FpdGVyLT5wbGFjZS5scGZuKSB8fA0KPiArICAgICAgICAgICAgICAgICAg
KHBsYWNlLT5scGZuIDw9IHdhaXRlci0+cGxhY2UubHBmbiAmJiBwbGFjZS0+bHBmbiA+PQ0KPiAr
ICAgICAgICAgICAgICAgICAgIHdhaXRlci0+cGxhY2UuZnBmbikpKQ0KPiArICAgICAgICAgICAg
ICAgICBnb3RvIGxhdGVyX2JvOw0KPiArICAgICB9DQo+ICsgICAgIHNwaW5fdW5sb2NrKCZtYW4t
PndhaXRfbG9jayk7DQo+ICsgICAgIHJldHVybiB0cnVlOw0KPiArbGF0ZXJfYm86DQo+ICsgICAg
IHNwaW5fdW5sb2NrKCZtYW4tPndhaXRfbG9jayk7DQo+ICsgICAgIHJldHVybiBmYWxzZTsNCj4g
K30NCj4gICAvKioNCj4gICAgKiBSZXBlYXRlZGx5IGV2aWN0IG1lbW9yeSBmcm9tIHRoZSBMUlUg
Zm9yIEBtZW1fdHlwZSB1bnRpbCB3ZSBjcmVhdGUgZW5vdWdoDQo+ICAgICogc3BhY2UsIG9yIHdl
J3ZlIGV2aWN0ZWQgZXZlcnl0aGluZyBhbmQgdGhlcmUgaXNuJ3QgZW5vdWdoIHNwYWNlLg0KPiBA
QCAtODUzLDE3ICs5MDUsMjYgQEAgc3RhdGljIGludCB0dG1fYm9fbWVtX2ZvcmNlX3NwYWNlKHN0
cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8sDQo+ICAgew0KPiAgICAgICAgc3RydWN0IHR0bV9i
b19kZXZpY2UgKmJkZXYgPSBiby0+YmRldjsNCj4gICAgICAgIHN0cnVjdCB0dG1fbWVtX3R5cGVf
bWFuYWdlciAqbWFuID0gJmJkZXYtPm1hblttZW1fdHlwZV07DQo+ICsgICAgIHN0cnVjdCB0dG1f
Ym9fd2FpdGVyIHdhaXRlcjsNCj4gICAgICAgIGludCByZXQ7DQo+DQo+ICsgICAgIHR0bV9tYW5f
aW5pdF93YWl0ZXIoJndhaXRlciwgYm8sIHBsYWNlKTsNCj4gKyAgICAgdHRtX21hbl9hZGRfd2Fp
dGVyKG1hbiwgJndhaXRlcik7DQo+ICAgICAgICBkbyB7DQo+ICAgICAgICAgICAgICAgIHJldCA9
ICgqbWFuLT5mdW5jLT5nZXRfbm9kZSkobWFuLCBibywgcGxhY2UsIG1lbSk7DQo+IC0gICAgICAg
ICAgICAgaWYgKHVubGlrZWx5KHJldCAhPSAwKSkNCj4gKyAgICAgICAgICAgICBpZiAodW5saWtl
bHkocmV0ICE9IDApKSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICB0dG1fbWFuX2RlbF93YWl0
ZXIobWFuLCAmd2FpdGVyKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0K
PiAtICAgICAgICAgICAgIGlmIChtZW0tPm1tX25vZGUpDQo+ICsgICAgICAgICAgICAgfQ0KPiAr
ICAgICAgICAgICAgIGlmIChtZW0tPm1tX25vZGUpIHsNCj4gKyAgICAgICAgICAgICAgICAgICAg
IHR0bV9tYW5fZGVsX3dhaXRlcihtYW4sICZ3YWl0ZXIpOw0KPiAgICAgICAgICAgICAgICAgICAg
ICAgIGJyZWFrOw0KPiArICAgICAgICAgICAgIH0NCj4gICAgICAgICAgICAgICAgcmV0ID0gdHRt
X21lbV9ldmljdF9maXJzdChiZGV2LCBtZW1fdHlwZSwgcGxhY2UsIGN0eCk7DQo+IC0gICAgICAg
ICAgICAgaWYgKHVubGlrZWx5KHJldCAhPSAwKSkNCj4gKyAgICAgICAgICAgICBpZiAodW5saWtl
bHkocmV0ICE9IDApKSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICB0dG1fbWFuX2RlbF93YWl0
ZXIobWFuLCAmd2FpdGVyKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0K
PiArICAgICAgICAgICAgIH0NCj4gICAgICAgIH0gd2hpbGUgKDEpOw0KPiAgICAgICAgbWVtLT5t
ZW1fdHlwZSA9IG1lbV90eXBlOw0KPiAgICAgICAgcmV0dXJuIHR0bV9ib19hZGRfbW92ZV9mZW5j
ZShibywgbWFuLCBtZW0pOw0KPiBAQCAtMTQ1MCw2ICsxNTExLDggQEAgaW50IHR0bV9ib19pbml0
X21tKHN0cnVjdCB0dG1fYm9fZGV2aWNlICpiZGV2LCB1bnNpZ25lZCB0eXBlLA0KPiAgICAgICAg
bWFuLT51c2VfaW9fcmVzZXJ2ZV9scnUgPSBmYWxzZTsNCj4gICAgICAgIG11dGV4X2luaXQoJm1h
bi0+aW9fcmVzZXJ2ZV9tdXRleCk7DQo+ICAgICAgICBzcGluX2xvY2tfaW5pdCgmbWFuLT5tb3Zl
X2xvY2spOw0KPiArICAgICBzcGluX2xvY2tfaW5pdCgmbWFuLT53YWl0X2xvY2spOw0KPiArICAg
ICBJTklUX0xJU1RfSEVBRCgmbWFuLT53YWl0ZXJfbGlzdCk7DQo+ICAgICAgICBJTklUX0xJU1Rf
SEVBRCgmbWFuLT5pb19yZXNlcnZlX2xydSk7DQo+DQo+ICAgICAgICByZXQgPSBiZGV2LT5kcml2
ZXItPmluaXRfbWVtX3R5cGUoYmRldiwgdHlwZSwgbWFuKTsNCj4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvZHJtL3R0bS90dG1fYm9fYXBpLmggYi9pbmNsdWRlL2RybS90dG0vdHRtX2JvX2FwaS5oDQo+
IGluZGV4IDJjZDAyNWMyYWJlNy4uMGZjZTRkYmQwMmU3IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRl
L2RybS90dG0vdHRtX2JvX2FwaS5oDQo+ICsrKyBiL2luY2x1ZGUvZHJtL3R0bS90dG1fYm9fYXBp
LmgNCj4gQEAgLTQwLDYgKzQwLDcgQEANCj4gICAjaW5jbHVkZSA8bGludXgvbW0uaD4NCj4gICAj
aW5jbHVkZSA8bGludXgvYml0bWFwLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4L3Jlc2VydmF0aW9u
Lmg+DQo+ICsjaW5jbHVkZSA8ZHJtL3R0bS90dG1fcGxhY2VtZW50Lmg+DQo+DQo+ICAgc3RydWN0
IHR0bV9ib19kZXZpY2U7DQo+DQo+IEBAIC0yMzIsNiArMjMzLDEyIEBAIHN0cnVjdCB0dG1fYnVm
ZmVyX29iamVjdCB7DQo+ICAgICAgICBzdHJ1Y3QgbXV0ZXggd3VfbXV0ZXg7DQo+ICAgfTsNCj4N
Cj4gK3N0cnVjdCB0dG1fYm9fd2FpdGVyIHsNCj4gKyAgICAgc3RydWN0IHR0bV9idWZmZXJfb2Jq
ZWN0ICp0Ym87DQo+ICsgICAgIHN0cnVjdCB0dG1fcGxhY2UgcGxhY2U7DQo+ICsgICAgIHN0cnVj
dCBsaXN0X2hlYWQgbGlzdDsNCj4gK307DQo+ICsNCj4gICAvKioNCj4gICAgKiBzdHJ1Y3QgdHRt
X2JvX2ttYXBfb2JqDQo+ICAgICoNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL3R0bS90dG1f
Ym9fZHJpdmVyLmggYi9pbmNsdWRlL2RybS90dG0vdHRtX2JvX2RyaXZlci5oDQo+IGluZGV4IDli
NDE3ZWIyZGYyMC4uZGM2YjhiNGM5ZTA2IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2RybS90dG0v
dHRtX2JvX2RyaXZlci5oDQo+ICsrKyBiL2luY2x1ZGUvZHJtL3R0bS90dG1fYm9fZHJpdmVyLmgN
Cj4gQEAgLTI5Myw2ICsyOTMsMTAgQEAgc3RydWN0IHR0bV9tZW1fdHlwZV9tYW5hZ2VyIHsNCj4g
ICAgICAgIGJvb2wgaW9fcmVzZXJ2ZV9mYXN0cGF0aDsNCj4gICAgICAgIHNwaW5sb2NrX3QgbW92
ZV9sb2NrOw0KPg0KPiArICAgICAvKiB3YWl0ZXJzIGluIGxpc3QgKi8NCj4gKyAgICAgc3Bpbmxv
Y2tfdCB3YWl0X2xvY2s7DQo+ICsgICAgIHN0cnVjdCBsaXN0X2hlYWQgd2FpdGVyX2xpc3Q7DQo+
ICsNCj4gICAgICAgIC8qDQo+ICAgICAgICAgKiBQcm90ZWN0ZWQgYnkgQGlvX3Jlc2VydmVfbXV0
ZXg6DQo+ICAgICAgICAgKi8NCj4gQEAgLTc0OCw2ICs3NTIsOSBAQCBpbnQgdHRtX2JvX21lbV9z
cGFjZShzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLA0KPiAgICAgICAgICAgICAgICAgICAg
IHN0cnVjdCB0dG1fbWVtX3JlZyAqbWVtLA0KPiAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB0
dG1fb3BlcmF0aW9uX2N0eCAqY3R4KTsNCj4NCj4gK2ludCB0dG1fbWFuX2NoZWNrX2JvKHN0cnVj
dCB0dG1fbWVtX3R5cGVfbWFuYWdlciAqbWFuLA0KPiArICAgICAgICAgICAgICAgICAgc3RydWN0
IHR0bV9idWZmZXJfb2JqZWN0ICpibywNCj4gKyAgICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVj
dCB0dG1fcGxhY2UgKnBsYWNlKTsNCj4gICB2b2lkIHR0bV9ib19tZW1fcHV0KHN0cnVjdCB0dG1f
YnVmZmVyX29iamVjdCAqYm8sIHN0cnVjdCB0dG1fbWVtX3JlZyAqbWVtKTsNCj4gICB2b2lkIHR0
bV9ib19tZW1fcHV0X2xvY2tlZChzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB0dG1fbWVtX3JlZyAqbWVtKTsNCg0K

--_000_smartisan1516970199102_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>
<div name=3D"x_smartisanmessageid" id=3D"x_smartisan1516970199102"><font co=
lor=3D"#333333">I am off work, so reply mail by phone, the format could not=
 be text.<br>
</font><br>
back to topic itself:<br>
the problem indeed happen on amdgpu driver, someone reports me that applica=
tion runs with two instances, the performance are different.<br>
I also reproduced the issue with unit test(bo_eviction_test). They always t=
hink our scheduler isn't working as expected.<br>
<br>
After my investigation, this issue should be detect of TTM design self, whi=
ch breaks scheduling balance.<br>
<br>
Further, if we run containers for our gpu, container A could run high score=
, container B runs low score with same benchmark.<br>
<br>
So this is bug that we need fix.<br>
<br>
Regards,<br>
David Zhou<br>
<br>
<span id=3D"x_smartisan_signature" style=3D"font-size:0.8em; display:inline=
; color:#888888">
<p dir=3D"ltr">=B7=A2=D7=D4=BC=E1=B9=FB Pro</p>
</span><style type=3D"text/css">
<!--
* body
	{padding:0 16px 30px!important;
	margin:0!important;
	background-color:#ffffff;
	line-height:1.4;
	word-wrap:break-word;
	word-break:normal}
div
	{word-wrap:break-word;
	word-break:normal}
p
	{word-wrap:break-word;
	word-break:normal;
	text-indent:0pt!important}
span
	{word-wrap:break-word;
	word-break:normal}
a
	{word-wrap:break-word;
	word-break:normal}
td
	{word-wrap:break-word;
	word-break:break-all}
-->
</style>
<div class=3D"x_quote">
<div style=3D"margin:0 0px; font-size:105%"><font color=3D"#629140" style=
=3D"line-height:1.4"><span>Christian K=F6nig &lt;ckoenig.leichtzumerken@gma=
il.com&gt; =D3=DA 2018=C4=EA1=D4=C226=C8=D5 =CF=C2=CE=E76:31=D0=B4=B5=C0=A3=
=BA</span></font></div>
<br type=3D"attribution">
</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">Am 26.01.2018 um 11:22 schrieb Chunming Zhou:<br>
&gt; there is a scheduling balance issue about get node like:<br>
&gt; a. process A allocates full memory and use it for submission.<br>
&gt; b. process B tries to allocates memory, will wait for process A BO idl=
e in eviction.<br>
&gt; c. process A completes the job, process B eviction will put process A =
BO node,<br>
&gt; but in the meantime, process C is comming to allocate BO, whill direct=
ly get node successfully, and do submission,<br>
&gt; process B will again wait for process C BO idle.<br>
&gt; d. repeat the above setps, process B could be delayed much more.<br>
&gt;<br>
&gt; later allocation must not be ahead of front in same place.<br>
<br>
Again NAK to the whole approach.<br>
<br>
At least with amdgpu the problem you described above never occurs <br>
because evictions are pipelined operations. We could only block for <br>
deleted regions to become free.<br>
<br>
But independent of that incoming memory requests while we make room for <br=
>
eviction are intended to be served first.<br>
<br>
Changing that is certainly a no-go cause that would favor memory hungry <br=
>
applications over small clients.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;<br>
&gt; Change-Id: I3daa892e50f82226c552cc008a29e55894a98f18<br>
&gt; Signed-off-by: Chunming Zhou &lt;david1.zhou-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/ttm/ttm_bo.c&nbsp;&nbsp;&nbsp; | 69 &#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--<br>
&gt;&nbsp;&nbsp; include/drm/ttm/ttm_bo_api.h&nbsp;&nbsp;&nbsp; |&nbsp; 7 &=
#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; include/drm/ttm/ttm_bo_driver.h |&nbsp; 7 &#43;&#43;&#43;&=
#43;&#43;<br>
&gt;&nbsp;&nbsp; 3 files changed, 80 insertions(&#43;), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo=
.c<br>
&gt; index d33a6bb742a1..558ec2cf465d 100644<br>
&gt; --- a/drivers/gpu/drm/ttm/ttm_bo.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/ttm/ttm_bo.c<br>
&gt; @@ -841,6 &#43;841,58 @@ static int ttm_bo_add_move_fence(struct ttm_b=
uffer_object *bo,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;static void ttm_man_init_waiter(struct ttm_bo_waiter *waiter,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_buffer_object *bo,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct ttm_place *place)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; waiter-&gt;tbo =3D bo;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; memcpy((void *)&amp;waiter-&gt;place, (v=
oid *)place, sizeof(*place));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;waiter-&gt;list);<br=
>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static void ttm_man_add_waiter(struct ttm_mem_type_manager *man,<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; struct ttm_bo_waiter *waiter)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!waiter)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;man-&gt;wait_lock);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; list_add_tail(&amp;waiter-&gt;list, &amp=
;man-&gt;waiter_list);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;man-&gt;wait_lock);<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static void ttm_man_del_waiter(struct ttm_mem_type_manager *man,<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; struct ttm_bo_waiter *waiter)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!waiter)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;man-&gt;wait_lock);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!list_empty(&amp;waiter-&gt;list))<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; list_del(&amp;waiter-&gt;list);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;man-&gt;wait_lock);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfree(waiter);<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;int ttm_man_check_bo(struct ttm_mem_type_manager *man,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_buffer_object *bo,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct ttm_place *place)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_bo_waiter *waiter, *tmp;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;man-&gt;wait_lock);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(waiter, tmp, &a=
mp;man-&gt;waiter_list, list) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if ((bo !=3D waiter-&gt;tbo) &amp;&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((place-&gt;fpfn &gt;=3D waiter-&gt;place.f=
pfn &amp;&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; place-&gt;fpfn &lt;=3D waiter-&=
gt;place.lpfn) ||<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (place-&gt;lpfn &lt;=3D waiter-&gt;pl=
ace.lpfn &amp;&amp; place-&gt;lpfn &gt;=3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; waiter-&gt;place.fpfn)))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto later_bo;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;man-&gt;wait_lock);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt; &#43;later_bo:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;man-&gt;wait_lock);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; &#43;}<br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * Repeatedly evict memory from the LRU for @mem_type=
 until we create enough<br>
&gt;&nbsp;&nbsp;&nbsp; * space, or we've evicted everything and there isn't=
 enough space.<br>
&gt; @@ -853,17 &#43;905,26 @@ static int ttm_bo_mem_force_space(struct ttm=
_buffer_object *bo,<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_bo_device *bdev =
=3D bo-&gt;bdev;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_mem_type_manager =
*man =3D &amp;bdev-&gt;man[mem_type];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_bo_waiter waiter;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ttm_man_init_waiter(&amp;waiter, bo, pla=
ce);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ttm_man_add_waiter(man, &amp;waiter);<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D (*man-&gt;func-&gt;get_node)(man, bo, place, me=
m);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (unlikely(ret !=3D 0))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (unlikely(ret !=3D 0)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_man_del_waiter(=
man, &amp;waiter);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (mem-&gt;mm_node)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (mem-&gt;mm_node) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_man_del_waiter(=
man, &amp;waiter);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D ttm_mem_evict_first(bdev, mem_type, place, ctx)=
;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (unlikely(ret !=3D 0))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (unlikely(ret !=3D 0)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_man_del_waiter(=
man, &amp;waiter);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem-&gt;mem_type =3D mem_typ=
e;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ttm_bo_add_move_fence=
(bo, man, mem);<br>
&gt; @@ -1450,6 &#43;1511,8 @@ int ttm_bo_init_mm(struct ttm_bo_device *bde=
v, unsigned type,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; man-&gt;use_io_reserve_lru =
=3D false;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;man-&gt;io_r=
eserve_mutex);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_init(&amp;man-&gt;=
move_lock);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_init(&amp;man-&gt;wait_lock);<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;man-&gt;waiter_list)=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;man-&gt;=
io_reserve_lru);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D bdev-&gt;driver-&gt;=
init_mem_type(bdev, type, man);<br>
&gt; diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api=
.h<br>
&gt; index 2cd025c2abe7..0fce4dbd02e7 100644<br>
&gt; --- a/include/drm/ttm/ttm_bo_api.h<br>
&gt; &#43;&#43;&#43; b/include/drm/ttm/ttm_bo_api.h<br>
&gt; @@ -40,6 &#43;40,7 @@<br>
&gt;&nbsp;&nbsp; #include &lt;linux/mm.h&gt;<br>
&gt;&nbsp;&nbsp; #include &lt;linux/bitmap.h&gt;<br>
&gt;&nbsp;&nbsp; #include &lt;linux/reservation.h&gt;<br>
&gt; &#43;#include &lt;drm/ttm/ttm_placement.h&gt;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; struct ttm_bo_device;<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -232,6 &#43;233,12 @@ struct ttm_buffer_object {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex wu_mutex;<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;struct ttm_bo_waiter {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_buffer_object *tbo;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_place place;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head list;<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * struct ttm_bo_kmap_obj<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt; diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_=
driver.h<br>
&gt; index 9b417eb2df20..dc6b8b4c9e06 100644<br>
&gt; --- a/include/drm/ttm/ttm_bo_driver.h<br>
&gt; &#43;&#43;&#43; b/include/drm/ttm/ttm_bo_driver.h<br>
&gt; @@ -293,6 &#43;293,10 @@ struct ttm_mem_type_manager {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool io_reserve_fastpath;<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spinlock_t move_lock;<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* waiters in list */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; spinlock_t wait_lock;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head waiter_list;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Protected by @io_res=
erve_mutex:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; @@ -748,6 &#43;752,9 @@ int ttm_bo_mem_space(struct ttm_buffer_object =
*bo,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_mem_reg *mem,<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_operation_ctx =
*ctx);<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;int ttm_man_check_bo(struct ttm_mem_type_manager *man,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_buffer_object *bo,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct ttm_place *place);<br>
&gt;&nbsp;&nbsp; void ttm_bo_mem_put(struct ttm_buffer_object *bo, struct t=
tm_mem_reg *mem);<br>
&gt;&nbsp;&nbsp; void ttm_bo_mem_put_locked(struct ttm_buffer_object *bo,<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct ttm_mem_reg *mem);<br>
<br>
</div>
</span></font>
</body>
</html>

--_000_smartisan1516970199102_--

--===============0660601885==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0660601885==--
