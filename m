From: "Liu, Shaoyun" <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: disable MSI-X on APUs
Date: Thu, 3 Oct 2019 14:27:59 +0000
Message-ID: <97a4e63f-d141-e71e-a9d6-17eacbded5c2@amd.com>
References: <20191003141326.7600-1-alexander.deucher@amd.com>
 <20191003141326.7600-2-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191003141326.7600-2-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <99CAE4CAFDE48E48BF2E87ECD53DE52E-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "StDenis,
 Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>

VGhhbmtzIEFsZXggYW5kwqAgVG9tIHRvIGNhdGNoIGFuZMKgIHJldm9sdmUgdGhlIGlzc3VlIC7C
oCBJIGRpZG4ndCBkbyANCmVub3VnaCB0ZXN0IG9uIG9yaWdpbmFsIHRlc3QuDQoNCldlIGRvbid0
IG5lZWQgdG8gZW5hYmxlIG1zaXjCoCBvbiBBUFUgLiDCoCBUaGUgc2VyaWFscyBpcyByZXZpZXdl
ZCBieSANCnNoYW95dW4ubGl1IDxzaGFveXVuLmxpdUBhbWQuY29tPg0KDQoNClJlZ2FyZHMNCg0K
c2hhb3l1bi5saXUNCg0KDQoNCk9uIDIwMTktMTAtMDMgMTA6MTMgYS5tLiwgQWxleCBEZXVjaGVy
IHdyb3RlOg0KPiBSYXZlbiBjbGFpbXMgdG8gc3VwcG9ydCB0aGVtLCBidXQgc2VlbXMgdG8gaGF2
ZSBwcm9ibGVtcy4gIFN0aWNrDQo+IHdpdGggTVNJcyBmb3Igbm93IG9uIEFQVXMuDQo+DQo+IFRl
c3RlZC1ieTogVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPg0KPiBTaWduZWQtb2Zm
LWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IC0tLQ0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pcnEuYyB8IDMgKystDQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5jDQo+IGluZGV4IDk4YWEyOGVkYmE2YS4uOGYy
MjM2YmQ3ZDBlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfaXJxLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5j
DQo+IEBAIC0yNDgsNyArMjQ4LDggQEAgaW50IGFtZGdwdV9pcnFfaW5pdChzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldikNCj4gICAJCXVuc2lnbmVkIGludCBmbGFnczsNCj4gICAJCWludCBudmVj
ID0gcGNpX21zaXhfdmVjX2NvdW50KGFkZXYtPnBkZXYpOw0KPiAgIA0KPiAtCQlpZiAobnZlYyA8
PSAwKSB7DQo+ICsJCS8qIFJhdmVuIGNsYWltcyB0byBzdXBwb3J0IE1TSS1YLCBidXQgc2VlbXMg
dG8gaGF2ZSBwcm9ibGVtcyAqLw0KPiArCQlpZiAoKG52ZWMgPD0gMCkgfHwgKGFkZXYtPmZsYWdz
ICYgQU1EX0lTX0FQVSkpIHsNCj4gICAJCQlmbGFncyA9IFBDSV9JUlFfTVNJOw0KPiAgIAkJCW52
ZWMgPSAxOw0KPiAgIAkJfSBlbHNlIHsNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeA==
