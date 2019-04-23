From: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
Subject: Re: [PATCH v5 6/6] drm/amdgpu: Avoid HW reset if guilty job already
 signaled.
Date: Tue, 23 Apr 2019 14:12:34 +0000
Message-ID: <a5c97356-66d8-b79e-32ab-a03e4c4d3e39@amd.com>
References: <1555599624-12285-1-git-send-email-andrey.grodzovsky@amd.com>
 <1555599624-12285-6-git-send-email-andrey.grodzovsky@amd.com>
 <7a09bdb5-0acb-3df1-6691-4940920411ec@amd.com>
 <9774408b-cc4c-90dd-cbc7-6ef5c6fd8c46@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_003_a5c9735666d8b79e32aba03e4c4d3e39amdcom_"
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <9774408b-cc4c-90dd-cbc7-6ef5c6fd8c46@amd.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "eric@anholt.net" <eric@anholt.net>, "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>, "ckoenig.leichtzumerken@gmail.com" <ckoenig.leichtzumerken@gmail.com>
Cc: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

--_003_a5c9735666d8b79e32aba03e4c4d3e39amdcom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <921CDEB70613DF48AB9C4E20760356AC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64

T24gNC8yMy8xOSA4OjMyIEFNLCBLb2VuaWcsIENocmlzdGlhbiB3cm90ZToNCg0KPiBXZWxsIHlv
dSBhdCBsZWFzdCBoYXZlIHRvIGdpdmUgbWUgdGltZSB0aWxsIGFmdGVyIHRoZSBob2xpZGF5cyB0
byBnZXQNCj4gZ29pbmcgYWdhaW4gOikNCj4NCj4gTm90IHN1cmUgZXhhY3RseSBqZXQgd2h5IHdl
IG5lZWQgcGF0Y2ggbnVtYmVyIDUuDQoNClByb2JhYmx5IHlvdSBtaXNzZWQgdGhlIG1haWwgd2hl
cmUgSSBwb2ludGVkIG91dCBhIGJ1ZyBJIGZvdW5kIGR1cmluZyANCnRlc3RpbmcgLSBJIGFtwqAg
cmVhdHRhY2hpbmcgdGhlIG1haWwgYW5kIHRoZSBLQVNBTiBkdW1wLg0KDQpBbmRyZXkNCg0KDQo+
DQo+IEFuZCB3ZSBzaG91bGQgcHJvYmFibHkgY29tbWl0IHBhdGNoICMxIGFuZCAjMi4NCj4NCj4g
Q2hyaXN0aWFuLg0KPg0KPiBBbSAyMi4wNC4xOSB1bSAxMzo1NCBzY2hyaWViIEdyb2R6b3Zza3ks
IEFuZHJleToNCj4+IFBpbmcgZm9yIHBhdGNoZXMgMywgbmV3IHBhdGNoIDUgYW5kIHBhdGNoIDYu
DQo+Pg0KPj4gQW5kcmV5DQo+Pg0KPj4gT24gNC8xOC8xOSAxMTowMCBBTSwgQW5kcmV5IEdyb2R6
b3Zza3kgd3JvdGU6DQo+Pj4gQWxzbyByZWplY3QgVERScyBpZiBhbm90aGVyIG9uZSBhbHJlYWR5
IHJ1bm5pbmcuDQo+Pj4NCj4+PiB2MjoNCj4+PiBTdG9wIGFsbCBzY2hlZHVsZXJzIGFjcm9zcyBk
ZXZpY2UgYW5kIGVudGlyZSBYR01JIGhpdmUgYmVmb3JlDQo+Pj4gZm9yY2Ugc2lnbmFsaW5nIEhX
IGZlbmNlcy4NCj4+PiBBdm9pZCBwYXNzaW5nIGpvYl9zaWduYWxlZCB0byBoZWxwZXIgZm5jdGlv
bnMgdG8ga2VlcCBhbGwgdGhlIGRlY2lzaW9uDQo+Pj4gbWFraW5nIGFib3V0IHNraXBwaW5nIEhX
IHJlc2V0IGluIG9uZSBwbGFjZS4NCj4+Pg0KPj4+IHYzOg0KPj4+IEZpeCBTVyBzY2hlZC4gaGFu
ZyBhZnRlciBub24gSFcgcmVzZXQuIHNjaGVkLmh3X3JxX2NvdW50IGhhcyB0byBiZSBiYWxhbmNl
ZA0KPj4+IGFnYWluc3QgaXQncyBkZWNyZW1lbnQgaW4gZHJtX3NjaGVkX3N0b3AgaW4gbm9uIEhX
IHJlc2V0IGNhc2UuDQo+Pj4gdjQ6IHJlYmFzZQ0KPj4+IHY1OiBSZXZlcnQgdjMgYXMgd2UgZG8g
aXQgbm93IGluIHNjZWR1bGVyIGNvZGUuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkg
R3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lAYW1kLmNvbT4NCj4+PiAtLS0NCj4+PiAgICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMTQzICsrKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tDQo+Pj4gICAgIDEgZmlsZSBjaGFuZ2VkLCA5NSBpbnNlcnRp
b25zKCspLCA0OCBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4+PiBpbmRleCBhMGUxNjVjLi44NWY4NzkyIDEwMDY0NA0K
Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPj4+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPj4+IEBA
IC0zMzM0LDggKzMzMzQsNiBAQCBzdGF0aWMgaW50IGFtZGdwdV9kZXZpY2VfcHJlX2FzaWNfcmVz
ZXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+Pj4gICAgIAkJaWYgKCFyaW5nIHx8ICFy
aW5nLT5zY2hlZC50aHJlYWQpDQo+Pj4gICAgIAkJCWNvbnRpbnVlOw0KPj4+ICAgICANCj4+PiAt
CQlkcm1fc2NoZWRfc3RvcCgmcmluZy0+c2NoZWQsICZqb2ItPmJhc2UpOw0KPj4+IC0NCj4+PiAg
ICAgCQkvKiBhZnRlciBhbGwgaHcgam9icyBhcmUgcmVzZXQsIGh3IGZlbmNlIGlzIG1lYW5pbmds
ZXNzLCBzbyBmb3JjZV9jb21wbGV0aW9uICovDQo+Pj4gICAgIAkJYW1kZ3B1X2ZlbmNlX2RyaXZl
cl9mb3JjZV9jb21wbGV0aW9uKHJpbmcpOw0KPj4+ICAgICAJfQ0KPj4+IEBAIC0zMzQzLDYgKzMz
NDEsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9kZXZpY2VfcHJlX2FzaWNfcmVzZXQoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsDQo+Pj4gICAgIAlpZihqb2IpDQo+Pj4gICAgIAkJZHJtX3NjaGVk
X2luY3JlYXNlX2thcm1hKCZqb2ItPmJhc2UpOw0KPj4+ICAgICANCj4+PiArCS8qIERvbid0IHN1
c3BlbmQgb24gYmFyZSBtZXRhbCBpZiB3ZSBhcmUgbm90IGdvaW5nIHRvIEhXIHJlc2V0IHRoZSBB
U0lDICovDQo+Pj4gICAgIAlpZiAoIWFtZGdwdV9zcmlvdl92ZihhZGV2KSkgew0KPj4+ICAgICAN
Cj4+PiAgICAgCQlpZiAoIW5lZWRfZnVsbF9yZXNldCkNCj4+PiBAQCAtMzQ4MCwzNyArMzQ3OSwy
MSBAQCBzdGF0aWMgaW50IGFtZGdwdV9kb19hc2ljX3Jlc2V0KHN0cnVjdCBhbWRncHVfaGl2ZV9p
bmZvICpoaXZlLA0KPj4+ICAgICAJcmV0dXJuIHI7DQo+Pj4gICAgIH0NCj4+PiAgICAgDQo+Pj4g
LXN0YXRpYyB2b2lkIGFtZGdwdV9kZXZpY2VfcG9zdF9hc2ljX3Jlc2V0KHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KQ0KPj4+ICtzdGF0aWMgYm9vbCBhbWRncHVfZGV2aWNlX2xvY2tfYWRldihz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgYm9vbCB0cnlsb2NrKQ0KPj4+ICAgICB7DQo+Pj4g
LQlpbnQgaTsNCj4+PiAtDQo+Pj4gLQlmb3IgKGkgPSAwOyBpIDwgQU1ER1BVX01BWF9SSU5HUzsg
KytpKSB7DQo+Pj4gLQkJc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nID0gYWRldi0+cmluZ3NbaV07
DQo+Pj4gLQ0KPj4+IC0JCWlmICghcmluZyB8fCAhcmluZy0+c2NoZWQudGhyZWFkKQ0KPj4+IC0J
CQljb250aW51ZTsNCj4+PiAtDQo+Pj4gLQkJaWYgKCFhZGV2LT5hc2ljX3Jlc2V0X3JlcykNCj4+
PiAtCQkJZHJtX3NjaGVkX3Jlc3VibWl0X2pvYnMoJnJpbmctPnNjaGVkKTsNCj4+PiArCWlmICh0
cnlsb2NrKSB7DQo+Pj4gKwkJaWYgKCFtdXRleF90cnlsb2NrKCZhZGV2LT5sb2NrX3Jlc2V0KSkN
Cj4+PiArCQkJcmV0dXJuIGZhbHNlOw0KPj4+ICsJfSBlbHNlDQo+Pj4gKwkJbXV0ZXhfbG9jaygm
YWRldi0+bG9ja19yZXNldCk7DQo+Pj4gICAgIA0KPj4+IC0JCWRybV9zY2hlZF9zdGFydCgmcmlu
Zy0+c2NoZWQsICFhZGV2LT5hc2ljX3Jlc2V0X3Jlcyk7DQo+Pj4gLQl9DQo+Pj4gLQ0KPj4+IC0J
aWYgKCFhbWRncHVfZGV2aWNlX2hhc19kY19zdXBwb3J0KGFkZXYpKSB7DQo+Pj4gLQkJZHJtX2hl
bHBlcl9yZXN1bWVfZm9yY2VfbW9kZShhZGV2LT5kZGV2KTsNCj4+PiAtCX0NCj4+PiAtDQo+Pj4g
LQlhZGV2LT5hc2ljX3Jlc2V0X3JlcyA9IDA7DQo+Pj4gLX0NCj4+PiAtDQo+Pj4gLXN0YXRpYyB2
b2lkIGFtZGdwdV9kZXZpY2VfbG9ja19hZGV2KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0K
Pj4+IC17DQo+Pj4gLQltdXRleF9sb2NrKCZhZGV2LT5sb2NrX3Jlc2V0KTsNCj4+PiAgICAgCWF0
b21pY19pbmMoJmFkZXYtPmdwdV9yZXNldF9jb3VudGVyKTsNCj4+PiAgICAgCWFkZXYtPmluX2dw
dV9yZXNldCA9IDE7DQo+Pj4gICAgIAkvKiBCbG9jayBrZmQ6IFNSSU9WIHdvdWxkIGRvIGl0IHNl
cGFyYXRlbHkgKi8NCj4+PiAgICAgCWlmICghYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQ0KPj4+ICAg
ICAgICAgICAgICAgICAgICAgYW1kZ3B1X2FtZGtmZF9wcmVfcmVzZXQoYWRldik7DQo+Pj4gKw0K
Pj4+ICsJcmV0dXJuIHRydWU7DQo+Pj4gICAgIH0NCj4+PiAgICAgDQo+Pj4gICAgIHN0YXRpYyB2
b2lkIGFtZGdwdV9kZXZpY2VfdW5sb2NrX2FkZXYoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYp
DQo+Pj4gQEAgLTM1MzgsNDAgKzM1MjEsNDIgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2RldmljZV91
bmxvY2tfYWRldihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4+PiAgICAgaW50IGFtZGdw
dV9kZXZpY2VfZ3B1X3JlY292ZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+Pj4gICAg
IAkJCSAgICAgIHN0cnVjdCBhbWRncHVfam9iICpqb2IpDQo+Pj4gICAgIHsNCj4+PiAtCWludCBy
Ow0KPj4+ICsJc3RydWN0IGxpc3RfaGVhZCBkZXZpY2VfbGlzdCwgKmRldmljZV9saXN0X2hhbmRs
ZSA9ICBOVUxMOw0KPj4+ICsJYm9vbCBuZWVkX2Z1bGxfcmVzZXQsIGpvYl9zaWduYWxlZDsNCj4+
PiAgICAgCXN0cnVjdCBhbWRncHVfaGl2ZV9pbmZvICpoaXZlID0gTlVMTDsNCj4+PiAtCWJvb2wg
bmVlZF9mdWxsX3Jlc2V0ID0gZmFsc2U7DQo+Pj4gICAgIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
dG1wX2FkZXYgPSBOVUxMOw0KPj4+IC0Jc3RydWN0IGxpc3RfaGVhZCBkZXZpY2VfbGlzdCwgKmRl
dmljZV9saXN0X2hhbmRsZSA9ICBOVUxMOw0KPj4+ICsJaW50IGksIHIgPSAwOw0KPj4+ICAgICAN
Cj4+PiArCW5lZWRfZnVsbF9yZXNldCA9IGpvYl9zaWduYWxlZCA9IGZhbHNlOw0KPj4+ICAgICAJ
SU5JVF9MSVNUX0hFQUQoJmRldmljZV9saXN0KTsNCj4+PiAgICAgDQo+Pj4gICAgIAlkZXZfaW5m
byhhZGV2LT5kZXYsICJHUFUgcmVzZXQgYmVnaW4hXG4iKTsNCj4+PiAgICAgDQo+Pj4gKwloaXZl
ID0gYW1kZ3B1X2dldF94Z21pX2hpdmUoYWRldiwgZmFsc2UpOw0KPj4+ICsNCj4+PiAgICAgCS8q
DQo+Pj4gLQkgKiBJbiBjYXNlIG9mIFhHTUkgaGl2ZSBkaXNhbGxvdyBjb25jdXJyZW50IHJlc2V0
cyB0byBiZSB0cmlnZ2VyZWQNCj4+PiAtCSAqIGJ5IGRpZmZlcmVudCBub2Rlcy4gTm8gcG9pbnQg
YWxzbyBzaW5jZSB0aGUgb25lIG5vZGUgYWxyZWFkeSBleGVjdXRpbmcNCj4+PiAtCSAqIHJlc2V0
IHdpbGwgYWxzbyByZXNldCBhbGwgdGhlIG90aGVyIG5vZGVzIGluIHRoZSBoaXZlLg0KPj4+ICsJ
ICogSGVyZSB3ZSB0cnlsb2NrIHRvIGF2b2lkIGNoYWluIG9mIHJlc2V0cyBleGVjdXRpbmcgZnJv
bQ0KPj4+ICsJICogZWl0aGVyIHRyaWdnZXIgYnkgam9icyBvbiBkaWZmZXJlbnQgYWRldnMgaW4g
WEdNSSBoaXZlIG9yIGpvYnMgb24NCj4+PiArCSAqIGRpZmZlcmVudCBzY2hlZHVsZXJzIGZvciBz
YW1lIGRldmljZSB3aGlsZSB0aGlzIFRPIGhhbmRsZXIgaXMgcnVubmluZy4NCj4+PiArCSAqIFdl
IGFsd2F5cyByZXNldCBhbGwgc2NoZWR1bGVycyBmb3IgZGV2aWNlIGFuZCBhbGwgZGV2aWNlcyBm
b3IgWEdNSQ0KPj4+ICsJICogaGl2ZSBzbyB0aGF0IHNob3VsZCB0YWtlIGNhcmUgb2YgdGhlbSB0
b28uDQo+Pj4gICAgIAkgKi8NCj4+PiAtCWhpdmUgPSBhbWRncHVfZ2V0X3hnbWlfaGl2ZShhZGV2
LCAwKTsNCj4+PiAtCWlmIChoaXZlICYmIGFkZXYtPmdtYy54Z21pLm51bV9waHlzaWNhbF9ub2Rl
cyA+IDEgJiYNCj4+PiAtCSAgICAhbXV0ZXhfdHJ5bG9jaygmaGl2ZS0+cmVzZXRfbG9jaykpDQo+
Pj4gKw0KPj4+ICsJaWYgKGhpdmUgJiYgIW11dGV4X3RyeWxvY2soJmhpdmUtPnJlc2V0X2xvY2sp
KSB7DQo+Pj4gKwkJRFJNX0lORk8oIkJhaWxpbmcgb24gVERSIGZvciBzX2pvYjolbGx4LCBoaXZl
OiAlbGx4IGFzIGFub3RoZXIgYWxyZWFkeSBpbiBwcm9ncmVzcyIsDQo+Pj4gKwkJCSBqb2ItPmJh
c2UuaWQsIGhpdmUtPmhpdmVfaWQpOw0KPj4+ICAgICAJCXJldHVybiAwOw0KPj4+ICsJfQ0KPj4+
ICAgICANCj4+PiAgICAgCS8qIFN0YXJ0IHdpdGggYWRldiBwcmUgYXNpYyByZXNldCBmaXJzdCBm
b3Igc29mdCByZXNldCBjaGVjay4qLw0KPj4+IC0JYW1kZ3B1X2RldmljZV9sb2NrX2FkZXYoYWRl
dik7DQo+Pj4gLQlyID0gYW1kZ3B1X2RldmljZV9wcmVfYXNpY19yZXNldChhZGV2LA0KPj4+IC0J
CQkJCSBqb2IsDQo+Pj4gLQkJCQkJICZuZWVkX2Z1bGxfcmVzZXQpOw0KPj4+IC0JaWYgKHIpIHsN
Cj4+PiAtCQkvKlRPRE8gU2hvdWxkIHdlIHN0b3AgPyovDQo+Pj4gLQkJRFJNX0VSUk9SKCJHUFUg
cHJlIGFzaWMgcmVzZXQgZmFpbGVkIHdpdGggZXJyLCAlZCBmb3IgZHJtIGRldiwgJXMgIiwNCj4+
PiAtCQkJICByLCBhZGV2LT5kZGV2LT51bmlxdWUpOw0KPj4+IC0JCWFkZXYtPmFzaWNfcmVzZXRf
cmVzID0gcjsNCj4+PiArCWlmICghYW1kZ3B1X2RldmljZV9sb2NrX2FkZXYoYWRldiwgIWhpdmUp
KSB7DQo+Pj4gKwkJRFJNX0lORk8oIkJhaWxpbmcgb24gVERSIGZvciBzX2pvYjolbGx4LCBhcyBh
bm90aGVyIGFscmVhZHkgaW4gcHJvZ3Jlc3MiLA0KPj4+ICsJCQkJCSBqb2ItPmJhc2UuaWQpOw0K
Pj4+ICsJCXJldHVybiAwOw0KPj4+ICAgICAJfQ0KPj4+ICAgICANCj4+PiAgICAgCS8qIEJ1aWxk
IGxpc3Qgb2YgZGV2aWNlcyB0byByZXNldCAqLw0KPj4+IC0JaWYgIChuZWVkX2Z1bGxfcmVzZXQg
JiYgYWRldi0+Z21jLnhnbWkubnVtX3BoeXNpY2FsX25vZGVzID4gMSkgew0KPj4+ICsJaWYgIChh
ZGV2LT5nbWMueGdtaS5udW1fcGh5c2ljYWxfbm9kZXMgPiAxKSB7DQo+Pj4gICAgIAkJaWYgKCFo
aXZlKSB7DQo+Pj4gICAgIAkJCWFtZGdwdV9kZXZpY2VfdW5sb2NrX2FkZXYoYWRldik7DQo+Pj4g
ICAgIAkJCXJldHVybiAtRU5PREVWOw0KPj4+IEBAIC0zNTg4LDEzICszNTczLDU2IEBAIGludCBh
bWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPj4+
ICAgICAJCWRldmljZV9saXN0X2hhbmRsZSA9ICZkZXZpY2VfbGlzdDsNCj4+PiAgICAgCX0NCj4+
PiAgICAgDQo+Pj4gKwkvKiBibG9jayBhbGwgc2NoZWR1bGVycyBhbmQgcmVzZXQgZ2l2ZW4gam9i
J3MgcmluZyAqLw0KPj4+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeSh0bXBfYWRldiwgZGV2aWNlX2xp
c3RfaGFuZGxlLCBnbWMueGdtaS5oZWFkKSB7DQo+Pj4gKwkJZm9yIChpID0gMDsgaSA8IEFNREdQ
VV9NQVhfUklOR1M7ICsraSkgew0KPj4+ICsJCQlzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcgPSB0
bXBfYWRldi0+cmluZ3NbaV07DQo+Pj4gKw0KPj4+ICsJCQlpZiAoIXJpbmcgfHwgIXJpbmctPnNj
aGVkLnRocmVhZCkNCj4+PiArCQkJCWNvbnRpbnVlOw0KPj4+ICsNCj4+PiArCQkJZHJtX3NjaGVk
X3N0b3AoJnJpbmctPnNjaGVkLCAmam9iLT5iYXNlKTsNCj4+PiArCQl9DQo+Pj4gKwl9DQo+Pj4g
Kw0KPj4+ICsNCj4+PiArCS8qDQo+Pj4gKwkgKiBNdXN0IGNoZWNrIGd1aWx0eSBzaWduYWwgaGVy
ZSBzaW5jZSBhZnRlciB0aGlzIHBvaW50IGFsbCBvbGQNCj4+PiArCSAqIEhXIGZlbmNlcyBhcmUg
Zm9yY2Ugc2lnbmFsZWQuDQo+Pj4gKwkgKg0KPj4+ICsJICogam9iLT5iYXNlIGhvbGRzIGEgcmVm
ZXJlbmNlIHRvIHBhcmVudCBmZW5jZQ0KPj4+ICsJICovDQo+Pj4gKwlpZiAoam9iICYmIGpvYi0+
YmFzZS5zX2ZlbmNlLT5wYXJlbnQgJiYNCj4+PiArCSAgICBkbWFfZmVuY2VfaXNfc2lnbmFsZWQo
am9iLT5iYXNlLnNfZmVuY2UtPnBhcmVudCkpDQo+Pj4gKwkJam9iX3NpZ25hbGVkID0gdHJ1ZTsN
Cj4+PiArDQo+Pj4gKwlpZiAoIWFtZGdwdV9kZXZpY2VfaXBfbmVlZF9mdWxsX3Jlc2V0KGFkZXYp
KQ0KPj4+ICsJCWRldmljZV9saXN0X2hhbmRsZSA9ICZkZXZpY2VfbGlzdDsNCj4+PiArDQo+Pj4g
KwlpZiAoam9iX3NpZ25hbGVkKSB7DQo+Pj4gKwkJZGV2X2luZm8oYWRldi0+ZGV2LCAiR3VpbHR5
IGpvYiBhbHJlYWR5IHNpZ25hbGVkLCBza2lwcGluZyBIVyByZXNldCIpOw0KPj4+ICsJCWdvdG8g
c2tpcF9od19yZXNldDsNCj4+PiArCX0NCj4+PiArDQo+Pj4gKw0KPj4+ICsJLyogR3VpbHR5IGpv
YiB3aWxsIGJlIGZyZWVkIGFmdGVyIHRoaXMqLw0KPj4+ICsJciA9IGFtZGdwdV9kZXZpY2VfcHJl
X2FzaWNfcmVzZXQoYWRldiwNCj4+PiArCQkJCQkgam9iLA0KPj4+ICsJCQkJCSAmbmVlZF9mdWxs
X3Jlc2V0KTsNCj4+PiArCWlmIChyKSB7DQo+Pj4gKwkJLypUT0RPIFNob3VsZCB3ZSBzdG9wID8q
Lw0KPj4+ICsJCURSTV9FUlJPUigiR1BVIHByZSBhc2ljIHJlc2V0IGZhaWxlZCB3aXRoIGVyciwg
JWQgZm9yIGRybSBkZXYsICVzICIsDQo+Pj4gKwkJCSAgciwgYWRldi0+ZGRldi0+dW5pcXVlKTsN
Cj4+PiArCQlhZGV2LT5hc2ljX3Jlc2V0X3JlcyA9IHI7DQo+Pj4gKwl9DQo+Pj4gKw0KPj4+ICAg
ICByZXRyeToJLyogUmVzdCBvZiBhZGV2cyBwcmUgYXNpYyByZXNldCBmcm9tIFhHTUkgaGl2ZS4g
Ki8NCj4+PiAgICAgCWxpc3RfZm9yX2VhY2hfZW50cnkodG1wX2FkZXYsIGRldmljZV9saXN0X2hh
bmRsZSwgZ21jLnhnbWkuaGVhZCkgew0KPj4+ICAgICANCj4+PiAgICAgCQlpZiAodG1wX2FkZXYg
PT0gYWRldikNCj4+PiAgICAgCQkJY29udGludWU7DQo+Pj4gICAgIA0KPj4+IC0JCWFtZGdwdV9k
ZXZpY2VfbG9ja19hZGV2KHRtcF9hZGV2KTsNCj4+PiArCQlhbWRncHVfZGV2aWNlX2xvY2tfYWRl
dih0bXBfYWRldiwgZmFsc2UpOw0KPj4+ICAgICAJCXIgPSBhbWRncHVfZGV2aWNlX3ByZV9hc2lj
X3Jlc2V0KHRtcF9hZGV2LA0KPj4+ICAgICAJCQkJCQkgTlVMTCwNCj4+PiAgICAgCQkJCQkJICZu
ZWVkX2Z1bGxfcmVzZXQpOw0KPj4+IEBAIC0zNjE4LDkgKzM2NDYsMjggQEAgaW50IGFtZGdwdV9k
ZXZpY2VfZ3B1X3JlY292ZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+Pj4gICAgIAkJ
CWdvdG8gcmV0cnk7DQo+Pj4gICAgIAl9DQo+Pj4gICAgIA0KPj4+ICtza2lwX2h3X3Jlc2V0Og0K
Pj4+ICsNCj4+PiAgICAgCS8qIFBvc3QgQVNJQyByZXNldCBmb3IgYWxsIGRldnMgLiovDQo+Pj4g
ICAgIAlsaXN0X2Zvcl9lYWNoX2VudHJ5KHRtcF9hZGV2LCBkZXZpY2VfbGlzdF9oYW5kbGUsIGdt
Yy54Z21pLmhlYWQpIHsNCj4+PiAtCQlhbWRncHVfZGV2aWNlX3Bvc3RfYXNpY19yZXNldCh0bXBf
YWRldik7DQo+Pj4gKwkJZm9yIChpID0gMDsgaSA8IEFNREdQVV9NQVhfUklOR1M7ICsraSkgew0K
Pj4+ICsJCQlzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcgPSB0bXBfYWRldi0+cmluZ3NbaV07DQo+
Pj4gKw0KPj4+ICsJCQlpZiAoIXJpbmcgfHwgIXJpbmctPnNjaGVkLnRocmVhZCkNCj4+PiArCQkJ
CWNvbnRpbnVlOw0KPj4+ICsNCj4+PiArCQkJLyogTm8gcG9pbnQgdG8gcmVzdWJtaXQgam9icyBp
ZiB3ZSBkaWRuJ3QgSFcgcmVzZXQqLw0KPj4+ICsJCQlpZiAoIXRtcF9hZGV2LT5hc2ljX3Jlc2V0
X3JlcyAmJiAham9iX3NpZ25hbGVkKQ0KPj4+ICsJCQkJZHJtX3NjaGVkX3Jlc3VibWl0X2pvYnMo
JnJpbmctPnNjaGVkKTsNCj4+PiArDQo+Pj4gKwkJCWRybV9zY2hlZF9zdGFydCgmcmluZy0+c2No
ZWQsICF0bXBfYWRldi0+YXNpY19yZXNldF9yZXMpOw0KPj4+ICsJCX0NCj4+PiArDQo+Pj4gKwkJ
aWYgKCFhbWRncHVfZGV2aWNlX2hhc19kY19zdXBwb3J0KHRtcF9hZGV2KSAmJiAham9iX3NpZ25h
bGVkKSB7DQo+Pj4gKwkJCWRybV9oZWxwZXJfcmVzdW1lX2ZvcmNlX21vZGUodG1wX2FkZXYtPmRk
ZXYpOw0KPj4+ICsJCX0NCj4+PiArDQo+Pj4gKwkJdG1wX2FkZXYtPmFzaWNfcmVzZXRfcmVzID0g
MDsNCj4+PiAgICAgDQo+Pj4gICAgIAkJaWYgKHIpIHsNCj4+PiAgICAgCQkJLyogYmFkIG5ld3Ms
IGhvdyB0byB0ZWxsIGl0IHRvIHVzZXJzcGFjZSA/ICovDQo+Pj4gQEAgLTM2MzMsNyArMzY4MCw3
IEBAIGludCBhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LA0KPj4+ICAgICAJCWFtZGdwdV9kZXZpY2VfdW5sb2NrX2FkZXYodG1wX2FkZXYpOw0KPj4+
ICAgICAJfQ0KPj4+ICAgICANCj4+PiAtCWlmIChoaXZlICYmIGFkZXYtPmdtYy54Z21pLm51bV9w
aHlzaWNhbF9ub2RlcyA+IDEpDQo+Pj4gKwlpZiAoaGl2ZSkNCj4+PiAgICAgCQltdXRleF91bmxv
Y2soJmhpdmUtPnJlc2V0X2xvY2spOw0KPj4+ICAgICANCj4+PiAgICAgCWlmIChyKQ0KPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBhbWQtZ2Z4IG1h
aWxpbmcgbGlzdA0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngNCg==

--_003_a5c9735666d8b79e32aba03e4c4d3e39amdcom_
Content-Type: text/x-log; name="kasan.log"
Content-Description: kasan.log
Content-Disposition: attachment; filename="kasan.log"; size=3511;
	creation-date="Tue, 23 Apr 2019 14:12:34 GMT";
	modification-date="Tue, 23 Apr 2019 14:12:34 GMT"
Content-ID: <B6981D60B33A8541BA13AD70B61A2B40@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64

ICAxMjEuMTg5NzU3IDwgICAgMC4wMDAxNzE+XSBhbWRncHUgMDAwMDowMTowMC4wOiBHUFUgcmVz
ZXQoNSkgc3VjY2VlZGVkIQ0KcGFzc2VkWyAgMTIxLjE4OTg5NCA8ICAgIDAuMDAwMTM3Pl0gPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09DQoNCg0KWyAgMTIxLjE4OTk1MSA8ICAgIDAuMDAwMDU3Pl0gQlVHOiBLQVNBTjogdXNl
LWFmdGVyLWZyZWUgaW4gZHJtX3NjaGVkX2pvYl90aW1lZG91dCsweDdhLzB4ZjAgW2dwdV9zY2hl
ZF0NClJ1biBTdW1tYXJ5OiAgICBUeXBlICBUb3RhbCAgICBSYW4gUGFzc2VkIEZhaWxlZCBJbmFj
dGl2ZQ0KICAgICAgICAgICAgICBzdWl0ZXMgICAgICA4ICAgICAgMCAgICBuL2EgICAgICAwICAg
ICAgICAwDQogICAgICAgICAgICAgICB0ZXN0cyAgICAgMzkgICAgICAxICAgICAgMSAgICAgIDAg
ICAgICAgIDANCiAgICAgICAgICAgICBhc3NlcnRzICAgICAgOCAgICAgIDggICAgICA4ICAgICAg
MCAgICAgIG4vYQ0KDQpFbGFwc2VkIHRpbWUgPSAgICAwLjAwMSBzZWNvbmRzWyAgMTIxLjE4OTk1
NiA8ICAgIDAuMDAwMDA1Pl0gUmVhZCBvZiBzaXplIDggYXQgYWRkciBmZmZmODg4NDAzODlhOGIw
IGJ5IHRhc2sga3dvcmtlci8yOjIvMTE0MA0KDQoNClsgIDEyMS4xODk5NjkgPCAgICAwLjAwMDAx
Mz5dIENQVTogMiBQSUQ6IDExNDAgQ29tbToga3dvcmtlci8yOjIgVGFpbnRlZDogRyAgICAgICAg
ICAgT0UgICAgIDUuMS4wLXJjMi1taXNjKyAjMQ0KWyAgMTIxLjE4OTk3MiA8ICAgIDAuMDAwMDAz
Pl0gSGFyZHdhcmUgbmFtZTogU3lzdGVtIG1hbnVmYWN0dXJlciBTeXN0ZW0gUHJvZHVjdCBOYW1l
L1oxNzAtUFJPLCBCSU9TIDE5MDIgMDYvMjcvMjAxNg0KWyAgMTIxLjE4OTk3NyA8ICAgIDAuMDAw
MDA1Pl0gV29ya3F1ZXVlOiBldmVudHMgZHJtX3NjaGVkX2pvYl90aW1lZG91dCBbZ3B1X3NjaGVk
XQ0KWyAgMTIxLjE4OTk4MCA8ICAgIDAuMDAwMDAzPl0gQ2FsbCBUcmFjZToNClsgIDEyMS4xODk5
ODUgPCAgICAwLjAwMDAwNT5dICBkdW1wX3N0YWNrKzB4OWIvMHhmNQ0KWyAgMTIxLjE4OTk5MiA8
ICAgIDAuMDAwMDA3Pl0gIHByaW50X2FkZHJlc3NfZGVzY3JpcHRpb24rMHg3MC8weDI5MA0KWyAg
MTIxLjE4OTk5NyA8ICAgIDAuMDAwMDA1Pl0gID8gZHJtX3NjaGVkX2pvYl90aW1lZG91dCsweDdh
LzB4ZjAgW2dwdV9zY2hlZF0NClsgIDEyMS4xOTAwMDIgPCAgICAwLjAwMDAwNT5dICBrYXNhbl9y
ZXBvcnQrMHgxMzQvMHgxOTENClsgIDEyMS4xOTAwMDYgPCAgICAwLjAwMDAwND5dICA/IGRybV9z
Y2hlZF9qb2JfdGltZWRvdXQrMHg3YS8weGYwIFtncHVfc2NoZWRdDQpbICAxMjEuMTkwMDE0IDwg
ICAgMC4wMDAwMDg+XSAgPyBkcm1fc2NoZWRfam9iX3RpbWVkb3V0KzB4N2EvMHhmMCBbZ3B1X3Nj
aGVkXQ0KWyAgMTIxLjE5MDAxOSA8ICAgIDAuMDAwMDA1Pl0gIF9fYXNhbl9sb2FkOCsweDU0LzB4
OTANClsgIDEyMS4xOTAwMjQgPCAgICAwLjAwMDAwNT5dICBkcm1fc2NoZWRfam9iX3RpbWVkb3V0
KzB4N2EvMHhmMCBbZ3B1X3NjaGVkXQ0KWyAgMTIxLjE5MDAzNCA8ICAgIDAuMDAwMDEwPl0gIHBy
b2Nlc3Nfb25lX3dvcmsrMHg0NjYvMHhiMDANClsgIDEyMS4xOTAwNDYgPCAgICAwLjAwMDAxMj5d
ICA/IHF1ZXVlX3dvcmtfbm9kZSsweDE4MC8weDE4MA0KWyAgMTIxLjE5MDA2MSA8ICAgIDAuMDAw
MDE1Pl0gIHdvcmtlcl90aHJlYWQrMHg4My8weDZjMA0KWyAgMTIxLjE5MDA3NSA8ICAgIDAuMDAw
MDE0Pl0gIGt0aHJlYWQrMHgxYTkvMHgxZjANClsgIDEyMS4xOTAwNzkgPCAgICAwLjAwMDAwND5d
ICA/IHJlc2N1ZXJfdGhyZWFkKzB4NzYwLzB4NzYwDQpbICAxMjEuMTkwMDgxIDwgICAgMC4wMDAw
MDI+XSAgPyBrdGhyZWFkX2NhbmNlbF9kZWxheWVkX3dvcmtfc3luYysweDIwLzB4MjANClsgIDEy
MS4xOTAwODggPCAgICAwLjAwMDAwNz5dICByZXRfZnJvbV9mb3JrKzB4M2EvMHg1MA0KDQpbICAx
MjEuMTkwMTA1IDwgICAgMC4wMDAwMTc+XSBBbGxvY2F0ZWQgYnkgdGFzayAxNDIxOg0KWyAgMTIx
LjE5MDExMCA8ICAgIDAuMDAwMDA1Pl0gIHNhdmVfc3RhY2srMHg0Ni8weGQwDQpbICAxMjEuMTkw
MTEyIDwgICAgMC4wMDAwMDI+XSAgX19rYXNhbl9rbWFsbG9jKzB4YWIvMHhlMA0KWyAgMTIxLjE5
MDExNSA8ICAgIDAuMDAwMDAzPl0gIGthc2FuX2ttYWxsb2MrMHhmLzB4MjANClsgIDEyMS4xOTAx
MTcgPCAgICAwLjAwMDAwMj5dICBfX2ttYWxsb2MrMHgxNjcvMHgzOTANClsgIDEyMS4xOTAyMTAg
PCAgICAwLjAwMDA5Mz5dICBhbWRncHVfam9iX2FsbG9jKzB4NDcvMHgxNzAgW2FtZGdwdV0NClsg
IDEyMS4xOTAyODkgPCAgICAwLjAwMDA3OT5dICBhbWRncHVfY3NfaW9jdGwrMHg5YmQvMHgyZTcw
IFthbWRncHVdDQpbICAxMjEuMTkwMzEyIDwgICAgMC4wMDAwMjM+XSAgZHJtX2lvY3RsX2tlcm5l
bCsweDE3ZS8weDFkMCBbZHJtXQ0KWyAgMTIxLjE5MDMzNCA8ICAgIDAuMDAwMDIyPl0gIGRybV9p
b2N0bCsweDVlMS8weDY0MCBbZHJtXQ0KWyAgMTIxLjE5MDQwOSA8ICAgIDAuMDAwMDc1Pl0gIGFt
ZGdwdV9kcm1faW9jdGwrMHg3OC8weGQwIFthbWRncHVdDQpbICAxMjEuMTkwNDEzIDwgICAgMC4w
MDAwMDQ+XSAgZG9fdmZzX2lvY3RsKzB4MTUyLzB4YTMwDQpbICAxMjEuMTkwNDE1IDwgICAgMC4w
MDAwMDI+XSAga3N5c19pb2N0bCsweDZkLzB4ODANClsgIDEyMS4xOTA0MTggPCAgICAwLjAwMDAw
Mz5dICBfX3g2NF9zeXNfaW9jdGwrMHg0My8weDUwDQpbICAxMjEuMTkwNDI1IDwgICAgMC4wMDAw
MDc+XSAgZG9fc3lzY2FsbF82NCsweDdkLzB4MjQwDQpbICAxMjEuMTkwNDMwIDwgICAgMC4wMDAw
MDU+XSAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NDkvMHhiZQ0KDQpbICAxMjEu
MTkwNDQwIDwgICAgMC4wMDAwMTA+XSBGcmVlZCBieSB0YXNrIDEyNDI6DQpbICAxMjEuMTkwNDQ4
IDwgICAgMC4wMDAwMDg+XSAgc2F2ZV9zdGFjaysweDQ2LzB4ZDANClsgIDEyMS4xOTA0NTMgPCAg
ICAwLjAwMDAwNT5dICBfX2thc2FuX3NsYWJfZnJlZSsweDEzYy8weDFhMA0KWyAgMTIxLjE5MDQ1
OCA8ICAgIDAuMDAwMDA1Pl0gIGthc2FuX3NsYWJfZnJlZSsweGUvMHgxMA0KWyAgMTIxLjE5MDQ2
MiA8ICAgIDAuMDAwMDA0Pl0gIGtmcmVlKzB4ZmEvMHgyZTANClsgIDEyMS4xOTA1ODQgPCAgICAw
LjAwMDEyMj5dICBhbWRncHVfam9iX2ZyZWVfY2IrMHg3Zi8weDkwIFthbWRncHVdDQpbICAxMjEu
MTkwNTg5IDwgICAgMC4wMDAwMDU+XSAgZHJtX3NjaGVkX2NsZWFudXBfam9icy5wYXJ0LjEwKzB4
Y2YvMHgxYTAgW2dwdV9zY2hlZF0NClsgIDEyMS4xOTA1OTQgPCAgICAwLjAwMDAwNT5dICBkcm1f
c2NoZWRfbWFpbisweDM4YS8weDQzMCBbZ3B1X3NjaGVkXQ0KWyAgMTIxLjE5MDU5NiA8ICAgIDAu
MDAwMDAyPl0gIGt0aHJlYWQrMHgxYTkvMHgxZjANClsgIDEyMS4xOTA1OTkgPCAgICAwLjAwMDAw
Mz5dICByZXRfZnJvbV9mb3JrKzB4M2EvMHg1MA0KDQoNCg==

--_003_a5c9735666d8b79e32aba03e4c4d3e39amdcom_
Content-Type: message/rfc822
Content-Disposition: attachment;
	creation-date="Tue, 23 Apr 2019 14:12:34 GMT";
	modification-date="Tue, 23 Apr 2019 14:12:34 GMT"
Content-ID: <5DD603B3485334498D6637D1091749EB@namprd12.prod.outlook.com>

Received: from [172.27.231.243] (2603:10b6:b00:1::18) by
 MWHPR12MB1453.namprd12.prod.outlook.com (2603:10b6:301:e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.16 via Mailbox Transport; Wed, 17 Apr 2019 21:06:33 +0000
Subject: Re: [PATCH v3 1/5] drm/scheduler: rework job destruction
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 Eric Anholt <eric@anholt.net>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>
Cc: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
References: <1555357403-30813-1-git-send-email-andrey.grodzovsky@amd.com>
 <878swb6k9a.fsf@anholt.net> <b62ea5d8-1dbe-7e67-7e62-1f452ed860c2@gmail.com>
 <84200035-bb50-310d-7d48-20dbe072621c@amd.com>
 <4d7c99ae-eec4-f6af-6865-7c844475078c@amd.com>
 <e8255594-6a3f-ba83-e6ff-d6aae4e9e9ba@amd.com>
 <93c03b16-b01f-d17e-49d3-4cce515052aa@amd.com>
 <8344ae6b-03a8-0a9b-aa02-66b59b580f37@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <61f7737a-c5bb-0146-65ba-9a8e6ddeda30@amd.com>
Date: Wed, 17 Apr 2019 17:06:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <8344ae6b-03a8-0a9b-aa02-66b59b580f37@amd.com>
Content-Type: multipart/mixed;
 boundary="------------4DC97ED4954274D13D14ABA5"
Content-Language: en-US
X-MS-Exchange-Organization-ExpirationStartTime: 17 Apr 2019 21:06:34.1879
 (UTC)
X-MS-Exchange-Organization-ExpirationStartTimeReason: OriginalSubmit
X-MS-Exchange-Organization-ExpirationInterval: 2:00:00:00.0000000
X-MS-Exchange-Organization-ExpirationIntervalReason: OriginalSubmit
X-MS-Exchange-Organization-Network-Message-Id: d4a8147a-9b62-4dd7-94f0-08d6c378928f
X-MS-Exchange-Organization-AuthSource: MWHPR12MB1453.namprd12.prod.outlook.com
X-MS-Exchange-Organization-AuthAs: Internal
X-MS-Exchange-Organization-AuthMechanism: 06
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::18) To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
X-MS-Exchange-Organization-MessageDirectionality: Originating
Return-Path: Andrey.Grodzovsky@amd.com
MIME-Version: 1.0

--------------4DC97ED4954274D13D14ABA5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/16/19 12:00 PM, Koenig, Christian wrote:
> Am 16.04.19 um 17:42 schrieb Grodzovsky, Andrey:
>> On 4/16/19 10:58 AM, Grodzovsky, Andrey wrote:
>>> On 4/16/19 10:43 AM, Koenig, Christian wrote:
>>>> Am 16.04.19 um 16:36 schrieb Grodzovsky, Andrey:
>>>>> On 4/16/19 5:47 AM, Christian König wrote:
>>>>>> Am 15.04.19 um 23:17 schrieb Eric Anholt:
>>>>>>> Andrey Grodzovsky <andrey.grodzovsky@amd.com> writes:
>>>>>>>
>>>>>>>> From: Christian König <christian.koenig@amd.com>
>>>>>>>>
>>>>>>>> We now destroy finished jobs from the worker thread to make sure that
>>>>>>>> we never destroy a job currently in timeout processing.
>>>>>>>> By this we avoid holding lock around ring mirror list in drm_sched_stop
>>>>>>>> which should solve a deadlock reported by a user.
>>>>>>>>
>>>>>>>> v2: Remove unused variable.
>>>>>>>>
>>>>>>>> Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=109692
>>>>>>>>
>>>>>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>>>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>>>>> ---
>>>>>>>>        drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  17 ++--
>>>>>>>>        drivers/gpu/drm/etnaviv/etnaviv_dump.c     |   4 -
>>>>>>>>        drivers/gpu/drm/etnaviv/etnaviv_sched.c    |   9 +-
>>>>>>>>        drivers/gpu/drm/scheduler/sched_main.c     | 138
>>>>>>>> +++++++++++++++++------------
>>>>>>>>        drivers/gpu/drm/v3d/v3d_sched.c            |   9 +-
>>>>>>> Missing corresponding panfrost and lima updates.  You should probably
>>>>>>> pull in drm-misc for hacking on the scheduler.
>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c
>>>>>>>> b/drivers/gpu/drm/v3d/v3d_sched.c
>>>>>>>> index ce7c737b..8efb091 100644
>>>>>>>> --- a/drivers/gpu/drm/v3d/v3d_sched.c
>>>>>>>> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
>>>>>>>> @@ -232,11 +232,18 @@ v3d_gpu_reset_for_timeout(struct v3d_dev *v3d,
>>>>>>>> struct drm_sched_job *sched_job)
>>>>>>>>              /* block scheduler */
>>>>>>>>            for (q = 0; q < V3D_MAX_QUEUES; q++)
>>>>>>>> -        drm_sched_stop(&v3d->queue[q].sched);
>>>>>>>> +        drm_sched_stop(&v3d->queue[q].sched, sched_job);
>>>>>>>>              if(sched_job)
>>>>>>>>                drm_sched_increase_karma(sched_job);
>>>>>>>>        +    /*
>>>>>>>> +     * Guilty job did complete and hence needs to be manually removed
>>>>>>>> +     * See drm_sched_stop doc.
>>>>>>>> +     */
>>>>>>>> +    if (list_empty(&sched_job->node))
>>>>>>>> +        sched_job->sched->ops->free_job(sched_job);
>>>>>>> If the if (sched_job) is necessary up above, then this should clearly be
>>>>>>> under it.
>>>>>>>
>>>>>>> But, can we please have a core scheduler thing we call here instead of
>>>>>>> drivers all replicating it?
>>>>>> Yeah that's also something I noted before.
>>>>>>
>>>>>> Essential problem is that we remove finished jobs from the mirror list
>>>>>> and so need to destruct them because we otherwise leak them.
>>>>>>
>>>>>> Alternative approach here would be to keep the jobs on the ring mirror
>>>>>> list, but not submit them again.
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>> I really prefer to avoid this, it means adding extra flag to sched_job
>>>>> to check in each iteration of the ring mirror list.
>>>> Mhm, why actually? We just need to check if the scheduler fence is signaled.
>>> OK, i see it's equivalent but this still en extra check for all the
>>> iterations.
>>>
>>>>> What about changing
>>>>> signature of drm_sched_backend_ops.timedout_job to return drm_sched_job*
>>>>> instead of void, this way we can return the guilty job back from the
>>>>> driver specific handler to the generic drm_sched_job_timedout and
>>>>> release it there.
>>>> Well the timeout handler already has the job, so returning it doesn't
>>>> make much sense.
>>>>
>>>> The problem is rather that the timeout handler doesn't know if it should
>>>> destroy the job or not.
>>> But the driver specific handler does, and actually returning back either
>>> the pointer to the job or null will give an indication of that. We can
>>> even return bool.
>>>
>>> Andrey
>> Thinking a bit more about this - the way this check is done now "if
>> (list_empty(&sched_job->node)) then free the sched_job" actually makes
>> it possible to just move this as is from driver specific callbacks into
>> drm_sched_job_timeout without any other changes.
> Oh, well that sounds like a good idea off hand.
>
> Need to see the final code, but at least the best idea so far.
>
> Christian.

Unfortunately looks like it's not that good idea at the end, take a look 
at the attached KASAN print - sched thread's cleanup function races 
against TDR handler and removes the guilty job from mirror list and we 
have no way of differentiating if the job was removed from within the 
TDR handler or from the sched. thread's clean-up function. So looks like 
we either need 'keep the jobs on the ring mirror list, but not submit 
them again' as you suggested before or add a flag to sched_job to hint 
to drm_sched_job_timedout that guilty job requires manual removal. Your 
suggestion implies we will need an extra check in almost every place of 
traversal of the mirror ring to avoid handling signaled jobs while mine 
requires extra flag in sched_job struct . I feel that keeping completed 
jobs in the mirror list when they actually don't belong there any more 
is confusing and an opening for future bugs.

Andrey

>
>> Andrey
>>
>>>> Christian.
>>>>
>>>>> Andrey
>>>>>
>>>>>>>> +
>>>>>>>>            /* get the GPU back into the init state */
>>>>>>>>            v3d_reset(v3d);
>>>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx@lists.freedesktop.org
>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--------------4DC97ED4954274D13D14ABA5
Content-Type: text/x-log;
 name="kasan.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="kasan.log"

  121.189757 <    0.000171>] amdgpu 0000:01:00.0: GPU reset(5) succeeded!
passed[  121.189894 <    0.000137>] ==================================================================


[  121.189951 <    0.000057>] BUG: KASAN: use-after-free in drm_sched_job_timedout+0x7a/0xf0 [gpu_sched]
Run Summary:    Type  Total    Ran Passed Failed Inactive
              suites      8      0    n/a      0        0
               tests     39      1      1      0        0
             asserts      8      8      8      0      n/a

Elapsed time =    0.001 seconds[  121.189956 <    0.000005>] Read of size 8 at addr ffff88840389a8b0 by task kworker/2:2/1140


[  121.189969 <    0.000013>] CPU: 2 PID: 1140 Comm: kworker/2:2 Tainted: G           OE     5.1.0-rc2-misc+ #1
[  121.189972 <    0.000003>] Hardware name: System manufacturer System Product Name/Z170-PRO, BIOS 1902 06/27/2016
[  121.189977 <    0.000005>] Workqueue: events drm_sched_job_timedout [gpu_sched]
[  121.189980 <    0.000003>] Call Trace:
[  121.189985 <    0.000005>]  dump_stack+0x9b/0xf5
[  121.189992 <    0.000007>]  print_address_description+0x70/0x290
[  121.189997 <    0.000005>]  ? drm_sched_job_timedout+0x7a/0xf0 [gpu_sched]
[  121.190002 <    0.000005>]  kasan_report+0x134/0x191
[  121.190006 <    0.000004>]  ? drm_sched_job_timedout+0x7a/0xf0 [gpu_sched]
[  121.190014 <    0.000008>]  ? drm_sched_job_timedout+0x7a/0xf0 [gpu_sched]
[  121.190019 <    0.000005>]  __asan_load8+0x54/0x90
[  121.190024 <    0.000005>]  drm_sched_job_timedout+0x7a/0xf0 [gpu_sched]
[  121.190034 <    0.000010>]  process_one_work+0x466/0xb00
[  121.190046 <    0.000012>]  ? queue_work_node+0x180/0x180
[  121.190061 <    0.000015>]  worker_thread+0x83/0x6c0
[  121.190075 <    0.000014>]  kthread+0x1a9/0x1f0
[  121.190079 <    0.000004>]  ? rescuer_thread+0x760/0x760
[  121.190081 <    0.000002>]  ? kthread_cancel_delayed_work_sync+0x20/0x20
[  121.190088 <    0.000007>]  ret_from_fork+0x3a/0x50

[  121.190105 <    0.000017>] Allocated by task 1421:
[  121.190110 <    0.000005>]  save_stack+0x46/0xd0
[  121.190112 <    0.000002>]  __kasan_kmalloc+0xab/0xe0
[  121.190115 <    0.000003>]  kasan_kmalloc+0xf/0x20
[  121.190117 <    0.000002>]  __kmalloc+0x167/0x390
[  121.190210 <    0.000093>]  amdgpu_job_alloc+0x47/0x170 [amdgpu]
[  121.190289 <    0.000079>]  amdgpu_cs_ioctl+0x9bd/0x2e70 [amdgpu]
[  121.190312 <    0.000023>]  drm_ioctl_kernel+0x17e/0x1d0 [drm]
[  121.190334 <    0.000022>]  drm_ioctl+0x5e1/0x640 [drm]
[  121.190409 <    0.000075>]  amdgpu_drm_ioctl+0x78/0xd0 [amdgpu]
[  121.190413 <    0.000004>]  do_vfs_ioctl+0x152/0xa30
[  121.190415 <    0.000002>]  ksys_ioctl+0x6d/0x80
[  121.190418 <    0.000003>]  __x64_sys_ioctl+0x43/0x50
[  121.190425 <    0.000007>]  do_syscall_64+0x7d/0x240
[  121.190430 <    0.000005>]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

[  121.190440 <    0.000010>] Freed by task 1242:
[  121.190448 <    0.000008>]  save_stack+0x46/0xd0
[  121.190453 <    0.000005>]  __kasan_slab_free+0x13c/0x1a0
[  121.190458 <    0.000005>]  kasan_slab_free+0xe/0x10
[  121.190462 <    0.000004>]  kfree+0xfa/0x2e0
[  121.190584 <    0.000122>]  amdgpu_job_free_cb+0x7f/0x90 [amdgpu]
[  121.190589 <    0.000005>]  drm_sched_cleanup_jobs.part.10+0xcf/0x1a0 [gpu_sched]
[  121.190594 <    0.000005>]  drm_sched_main+0x38a/0x430 [gpu_sched]
[  121.190596 <    0.000002>]  kthread+0x1a9/0x1f0
[  121.190599 <    0.000003>]  ret_from_fork+0x3a/0x50



--------------4DC97ED4954274D13D14ABA5--

--_003_a5c9735666d8b79e32aba03e4c4d3e39amdcom_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--_003_a5c9735666d8b79e32aba03e4c4d3e39amdcom_--
