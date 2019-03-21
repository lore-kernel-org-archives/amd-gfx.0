From: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: Fix double unlock bug in
 smu_sys_set_pp_table()
Date: Thu, 21 Mar 2019 09:26:44 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1903210925400.5292@hadrien>
References: <20190321062822.GD21489@kadam>
 <MN2PR12MB3309B7C391B32EB8F5F87676EC420@MN2PR12MB3309.namprd12.prod.outlook.com>
 <alpine.DEB.2.20.1903210920230.5292@hadrien> <20190321082329.GV2227@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190321082329.GV2227@kadam>
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
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Gui,
 Jack" <Jack.Gui-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "Wang,
 Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, "kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Gao, Likun" <Likun.Gao-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

CgpPbiBUaHUsIDIxIE1hciAyMDE5LCBEYW4gQ2FycGVudGVyIHdyb3RlOgoKPiBPbiBUaHUsIE1h
ciAyMSwgMjAxOSBhdCAwOToyMDozOEFNICswMTAwLCBKdWxpYSBMYXdhbGwgd3JvdGU6Cj4gPgo+
ID4KPiA+IE9uIFRodSwgMjEgTWFyIDIwMTksIEh1YW5nLCBSYXkgd3JvdGU6Cj4gPgo+ID4gPiA+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gPiA+ID4gRnJvbTogRGFuIENhcnBlbnRlciBb
bWFpbHRvOmRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbV0KPiA+ID4gPiBTZW50OiBUaHVyc2RheSwg
TWFyY2ggMjEsIDIwMTkgMjoyOCBQTQo+ID4gPiA+IFRvOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFs
ZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBXYW5nLCBLZXZpbihZYW5nKQo+ID4gPiA+IDxLZXZp
bjEuV2FuZ0BhbWQuY29tPgo+ID4gPiA+IENjOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFu
LktvZW5pZ0BhbWQuY29tPjsgWmhvdSwgRGF2aWQoQ2h1bk1pbmcpCj4gPiA+ID4gPERhdmlkMS5a
aG91QGFtZC5jb20+OyBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+OyBEYW5pZWwgVmV0
dGVyCj4gPiA+ID4gPGRhbmllbEBmZndsbC5jaD47IEh1YW5nLCBSYXkgPFJheS5IdWFuZ0BhbWQu
Y29tPjsgR2FvLCBMaWt1bgo+ID4gPiA+IDxMaWt1bi5HYW9AYW1kLmNvbT47IEd1aSwgSmFjayA8
SmFjay5HdWlAYW1kLmNvbT47IGFtZC0KPiA+ID4gPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
OyBrZXJuZWwtamFuaXRvcnNAdmdlci5rZXJuZWwub3JnCj4gPiA+ID4gU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kL3Bvd2VycGxheTogRml4IGRvdWJsZSB1bmxvY2sgYnVnIGluCj4gPiA+ID4gc211
X3N5c19zZXRfcHBfdGFibGUoKQo+ID4gPiA+Cj4gPiA+ID4gV2UgYWxyZWFkeSB1bmxvY2tlZCBh
IGZldyBsaW5lcyBlYXJsaWVyIHNvIHRoaXMgY29kZSB1bmxvY2tzIHR3aWNlIG9uIHRoZQo+ID4g
PiA+IHN1Y2Nlc3MgcGF0aC4KPiA+ID4gPgo+ID4gPiA+IEZpeGVzOiA1ODA5ZDc0MjBmOTcgKCJk
cm0vYW1kL3Bvd2VycGxheTogaW1wbGVtZW50IHN5c2ZzIG9mIHBwX3RhYmxlIGZvcgo+ID4gPiA+
IHNtdTExICh2MikiKQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5j
YXJwZW50ZXJAb3JhY2xlLmNvbT4KPiA+ID4KPiA+ID4gTmljZSBjYXRjaCEgIFRoYW5rcywgRGFu
Lgo+ID4gPiBLZXZpbiwgY291bGQgeW91IHBsZWFzZSB2ZXJpZnkgdGhpcyBwYXRjaC4KPiA+ID4g
UmV2aWV3ZWQtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+Cj4gPiA+Cj4gPiA+ID4g
LS0tCj4gPiA+ID4gSSdtIG5vdCBzdXJlIHdoYXQgdGhpcyBidWcgbG9va3MgbGlrZSBhdCBydW50
aW1lLCBidXQgaXQncyBzbGlnaHRseSB3ZWlyZCB0aGF0IG5vCj4gPiA+ID4gb25lIG5vdGljZWQu
ICBUaGlzIGlzIGZyb20gc3RhdGljIGFuYWx5c2lzIGFuZCBJIGhhdmVuJ3QgdGVzdGVkIGl0IG15
c2VsZi4KPiA+ID4gPgo+ID4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRn
cHVfc211LmMgfCAyICsrCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykK
PiA+ID4gPgo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxh
eS9hbWRncHVfc211LmMKPiA+ID4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2Ft
ZGdwdV9zbXUuYwo+ID4gPiA+IGluZGV4IDAwYjdjODg1NzcyYi4uN2U4Yzc0ZGE2YTc0IDEwMDY0
NAo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUu
Ywo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUu
Ywo+ID4gPiA+IEBAIC0xODcsNiArMTg3LDggQEAgaW50IHNtdV9zeXNfc2V0X3BwX3RhYmxlKHN0
cnVjdCBzbXVfY29udGV4dCAqc211LAo+ID4gPiA+IHZvaWQgKmJ1Ziwgc2l6ZV90IHNpemUpCj4g
PiA+ID4gIAlpZiAocmV0KQo+ID4gPiA+ICAJCXByX2luZm8oInNtdSByZXNldCBmYWlsZWQsIHJl
dCA9ICVkXG4iLCByZXQpOwo+ID4gPiA+Cj4gPiA+ID4gKwlyZXR1cm4gcmV0Owo+ID4KPiA+IFdo
eSBub3QgcmV0dXJuIDA/Cj4KPiBJdCdzIG5vdCBuZWNlc3NhcmlseSB6ZXJvLgoKT29wcywgSSB3
YXMgbG9va2luZyBhdCB0aGUgaW52aXNibGUgZ290byBhZnRlciB0aGUgcHJfaW5mbyA6KQoKanVs
aWEKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
