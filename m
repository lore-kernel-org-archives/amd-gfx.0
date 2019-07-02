From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: extend AMDGPU_CTX_PRIORITY_NORMAL comment
Date: Tue, 2 Jul 2019 18:15:55 +0100
Message-ID: <CACvgo51LkcF6LydoH8BCaKwK4trfrm0EQkjMricQ3b0RXcrhrA@mail.gmail.com>
References: <20190614173335.30907-1-emil.l.velikov@gmail.com>
 <b3b4b6d8-1b64-7860-88e5-ec91b9d2f711@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <b3b4b6d8-1b64-7860-88e5-ec91b9d2f711-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Bas Nieuwenhuizen <bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org>

T24gRnJpLCAxNCBKdW4gMjAxOSBhdCAxOTowMiwgS29lbmlnLCBDaHJpc3RpYW4KPENocmlzdGlh
bi5Lb2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4KPiBBbSAxNC4wNi4xOSB1bSAxOTozMyBzY2hyaWVi
IEVtaWwgVmVsaWtvdjoKPiA+IEZyb206IEVtaWwgVmVsaWtvdiA8ZW1pbC52ZWxpa292QGNvbGxh
Ym9yYS5jb20+Cj4gPgo+ID4gQ3VycmVudGx5IHRoZSBBTURHUFVfQ1RYX1BSSU9SSVRZXyogZGVm
aW5lcyBhcmUgdXNlZCBpbiBib3RoCj4gPiBkcm1fYW1kZ3B1X2N0eF9pbjo6cHJpb3JpdHkgYW5k
IGRybV9hbWRncHVfc2NoZWRfaW46OnByaW9yaXR5Lgo+ID4KPiA+IEV4dGVuZCB0aGUgY29tbWVu
dCB0byBtZW50aW9uIHRoZSBDQVBfU1lTX05JQ0Ugb3IgRFJNX01BU1RFUiByZXF1aXJlbWVudAo+
ID4gaXMgb25seSBhcHBsaWNhYmxlIHdpdGggdGhlIGZvcm1lci4KPiA+Cj4gPiBDYzogQmFzIE5p
ZXV3ZW5odWl6ZW4gPGJhc0BiYXNuaWV1d2VuaHVpemVuLm5sPgo+ID4gQ2M6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiA+IENjOiBBbGV4IERldWNoZXIgPGFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBFbWlsIFZlbGlrb3Yg
PGVtaWwudmVsaWtvdkBjb2xsYWJvcmEuY29tPgo+ID4gLS0tCj4gPiBNaWxkbHkgY3VyaW91czog
d2h5IGRpZG4ndCBvbmUgZXh0ZW5kIGN0eF9hbWRncHVfY3R4IGluc3RlYWQgb2YgYWRkaW5nCj4g
PiBkcm1fYW1kZ3B1X3NjaGVkPyBOZXcgZmxhZyArIF91MzIgZmQgYXQgdGhlIGVuZCAoZm9yIHRo
ZSBmb3JtZXIpIHdvdWxkCj4gPiBoYXZlIGJlZW4gZW5vdWdoIChhbmQgdHdlYWtpbmcgdGhlIGlv
Y3RsIHBlcm1pc3Npb24gdGhpbmd5KS4KPgo+IFRoZSBkcm1fYW1kZ3B1X3NjaGVkIGlzIG9ubHkg
YWxsb3dlZCBmb3IgRFJNX01BU1RFUi4KPgpGYWlyIGVub3VnaC4KCklzIHRoZSBwYXRjaCB3cm9u
ZyBvciBkaWQgaXQgc2xpcCB0aHJvdWdoIHRoZSBjcmFja3M/IEkgY2Fubm90IHNlZSBpdAppbiBB
bGV4J3MgdHJlZS4KCi1FbWlsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eA==
