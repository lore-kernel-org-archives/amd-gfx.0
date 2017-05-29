From: "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH libdrm v3 1/1] amdgpu: move asic id table to a separate
 file
Date: Mon, 29 May 2017 21:03:53 +0000
Message-ID: <CY1PR1201MB1033382E4796FCFBCF9F9123F5F30@CY1PR1201MB1033.namprd12.prod.outlook.com>
References: <1495826598-4545-1-git-send-email-Samuel.Li@amd.com>
 <d51d3233-510f-6a3e-bd5c-20f0afd21315@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d51d3233-510f-6a3e-bd5c-20f0afd21315-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Yuan,
 Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>

UmVjZW50bHkgdGhlcmUgYXJlIHNvbWUgY2hhbmdlcyBpbnRlcm5hbGx5LCBJIGNhbiBpbnRlZ3Jh
dGUgdGhlbSBpbnRvIHRoaXMgb25lLg0KVGhlcmUgYXJlIHN0aWxsIGRpc2N1c3Npb25zIG9uIGdv
aW5nIHJlZ2FyZGluZyB0aGUgZm9ybWF0Lg0KDQpTYW0NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IE1pY2hlbCBEw6RuemVyIFttYWlsdG86bWljaGVsQGRhZW56ZXIubmV0XSAN
ClNlbnQ6IFN1bmRheSwgTWF5IDI4LCAyMDE3IDEwOjExIFBNDQpUbzogTGksIFNhbXVlbCA8U2Ft
dWVsLkxpQGFtZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFl1YW4s
IFhpYW9qaWUgPFhpYW9qaWUuWXVhbkBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCBsaWJk
cm0gdjMgMS8xXSBhbWRncHU6IG1vdmUgYXNpYyBpZCB0YWJsZSB0byBhIHNlcGFyYXRlIGZpbGUN
Cg0KT24gMjcvMDUvMTcgMDQ6MjMgQU0sIFNhbXVlbCBMaSB3cm90ZToNCj4gDQo+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2RybS9hbWRncHUuaWRzIGIvaW5jbHVkZS9kcm0vYW1kZ3B1LmlkcyBuZXcg
ZmlsZSANCj4gbW9kZSAxMDA2NDQgaW5kZXggMDAwMDAwMC4uMWIwMGI2MA0KPiAtLS0gL2Rldi9u
dWxsDQo+ICsrKyBiL2luY2x1ZGUvZHJtL2FtZGdwdS5pZHMNCj4gQEAgLTAsMCArMSwxNTQgQEAN
Cj4gKzEuMC4wDQo+ICs2NjAwLDAsQU1EIFJhZGVvbiBIRCA4NjAwLzg3MDBNDQoNClRoaXMgZG9l
c24ndCBsb29rIGxpa2UgdGhlIGN1cnJlbnQgZm9ybWF0IHdlJ3ZlIHNldHRsZWQgb24gaW50ZXJu
YWxseS4NClRoZXJlIGFyZSBzdXBwb3NlZCB0byBiZSB0YWJzIGFmdGVyIHRoZSBjb21tYXMgdG8g
YWxpZ24gdGhlIGNvbHVtbnMuDQoNCg0KLS0gDQpFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAg
ICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tDQpMaWJyZSBzb2Z0
d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZl
bG9wZXINCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
