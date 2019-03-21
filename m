From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: Fix double unlock bug in
 smu_sys_set_pp_table()
Date: Thu, 21 Mar 2019 11:23:29 +0300
Message-ID: <20190321082329.GV2227@kadam>
References: <20190321062822.GD21489@kadam>
 <MN2PR12MB3309B7C391B32EB8F5F87676EC420@MN2PR12MB3309.namprd12.prod.outlook.com>
 <alpine.DEB.2.20.1903210920230.5292@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1903210920230.5292@hadrien>
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
To: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Gui,
 Jack" <Jack.Gui-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "Wang,
 Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, "kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Huang,
 Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Gao, Likun" <Likun.Gao-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

T24gVGh1LCBNYXIgMjEsIDIwMTkgYXQgMDk6MjA6MzhBTSArMDEwMCwgSnVsaWEgTGF3YWxsIHdy
b3RlOgo+IAo+IAo+IE9uIFRodSwgMjEgTWFyIDIwMTksIEh1YW5nLCBSYXkgd3JvdGU6Cj4gCj4g
PiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gPiA+IEZyb206IERhbiBDYXJwZW50ZXIg
W21haWx0bzpkYW4uY2FycGVudGVyQG9yYWNsZS5jb21dCj4gPiA+IFNlbnQ6IFRodXJzZGF5LCBN
YXJjaCAyMSwgMjAxOSAyOjI4IFBNCj4gPiA+IFRvOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+OyBXYW5nLCBLZXZpbihZYW5nKQo+ID4gPiA8S2V2aW4xLldh
bmdAYW1kLmNvbT4KPiA+ID4gQ2M6IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmln
QGFtZC5jb20+OyBaaG91LCBEYXZpZChDaHVuTWluZykKPiA+ID4gPERhdmlkMS5aaG91QGFtZC5j
b20+OyBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+OyBEYW5pZWwgVmV0dGVyCj4gPiA+
IDxkYW5pZWxAZmZ3bGwuY2g+OyBIdWFuZywgUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT47IEdhbywg
TGlrdW4KPiA+ID4gPExpa3VuLkdhb0BhbWQuY29tPjsgR3VpLCBKYWNrIDxKYWNrLkd1aUBhbWQu
Y29tPjsgYW1kLQo+ID4gPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBrZXJuZWwtamFuaXRv
cnNAdmdlci5rZXJuZWwub3JnCj4gPiA+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZC9wb3dlcnBs
YXk6IEZpeCBkb3VibGUgdW5sb2NrIGJ1ZyBpbgo+ID4gPiBzbXVfc3lzX3NldF9wcF90YWJsZSgp
Cj4gPiA+Cj4gPiA+IFdlIGFscmVhZHkgdW5sb2NrZWQgYSBmZXcgbGluZXMgZWFybGllciBzbyB0
aGlzIGNvZGUgdW5sb2NrcyB0d2ljZSBvbiB0aGUKPiA+ID4gc3VjY2VzcyBwYXRoLgo+ID4gPgo+
ID4gPiBGaXhlczogNTgwOWQ3NDIwZjk3ICgiZHJtL2FtZC9wb3dlcnBsYXk6IGltcGxlbWVudCBz
eXNmcyBvZiBwcF90YWJsZSBmb3IKPiA+ID4gc211MTEgKHYyKSIpCj4gPiA+IFNpZ25lZC1vZmYt
Ynk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4KPiA+Cj4gPiBOaWNl
IGNhdGNoISAgVGhhbmtzLCBEYW4uCj4gPiBLZXZpbiwgY291bGQgeW91IHBsZWFzZSB2ZXJpZnkg
dGhpcyBwYXRjaC4KPiA+IFJldmlld2VkLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29t
Pgo+ID4KPiA+ID4gLS0tCj4gPiA+IEknbSBub3Qgc3VyZSB3aGF0IHRoaXMgYnVnIGxvb2tzIGxp
a2UgYXQgcnVudGltZSwgYnV0IGl0J3Mgc2xpZ2h0bHkgd2VpcmQgdGhhdCBubwo+ID4gPiBvbmUg
bm90aWNlZC4gIFRoaXMgaXMgZnJvbSBzdGF0aWMgYW5hbHlzaXMgYW5kIEkgaGF2ZW4ndCB0ZXN0
ZWQgaXQgbXlzZWxmLgo+ID4gPgo+ID4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkv
YW1kZ3B1X3NtdS5jIHwgMiArKwo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KQo+ID4gPgo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkv
YW1kZ3B1X3NtdS5jCj4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1
X3NtdS5jCj4gPiA+IGluZGV4IDAwYjdjODg1NzcyYi4uN2U4Yzc0ZGE2YTc0IDEwMDY0NAo+ID4g
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMKPiA+ID4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jCj4gPiA+IEBA
IC0xODcsNiArMTg3LDggQEAgaW50IHNtdV9zeXNfc2V0X3BwX3RhYmxlKHN0cnVjdCBzbXVfY29u
dGV4dCAqc211LAo+ID4gPiB2b2lkICpidWYsIHNpemVfdCBzaXplKQo+ID4gPiAgCWlmIChyZXQp
Cj4gPiA+ICAJCXByX2luZm8oInNtdSByZXNldCBmYWlsZWQsIHJldCA9ICVkXG4iLCByZXQpOwo+
ID4gPgo+ID4gPiArCXJldHVybiByZXQ7Cj4gCj4gV2h5IG5vdCByZXR1cm4gMD8KCkl0J3Mgbm90
IG5lY2Vzc2FyaWx5IHplcm8uCgpyZWdhcmRzLApkYW4gY2FycGVudGVyCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
