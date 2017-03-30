From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Regression caused by "drm/amdgpu: get display info from DC when
 DC enabled."
Date: Wed, 29 Mar 2017 23:21:27 -0400
Message-ID: <CADnq5_N8B2uc8JXZ-4vBTVg-iBFjwmktEAz9NKgpgNEfSW58VA@mail.gmail.com>
References: <4bf14806-e715-5206-bee1-2fb0ffb35e27@daenzer.net>
 <BN6PR12MB1652A69F5052FDBB3EE89D2EF7340@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1652A69F5052FDBB3EE89D2EF7340-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Zhu,
 Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, Andy Furniss <adf.lists-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gV2VkLCBNYXIgMjksIDIwMTcgYXQgMTE6MTkgUE0sIERldWNoZXIsIEFsZXhhbmRlcgo8QWxl
eGFuZGVyLkRldWNoZXJAYW1kLmNvbT4gd3JvdGU6Cj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tCj4+IEZyb206IGFtZC1nZnggW21haWx0bzphbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnXSBPbiBCZWhhbGYKPj4gT2YgTWljaGVsIETDpG56ZXIKPj4gU2VudDogV2VkbmVz
ZGF5LCBNYXJjaCAyOSwgMjAxNyAxMToxMSBQTQo+PiBUbzogWmh1LCBSZXgKPj4gQ2M6IEFuZHkg
RnVybmlzczsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gU3ViamVjdDogUmVncmVz
c2lvbiBjYXVzZWQgYnkgImRybS9hbWRncHU6IGdldCBkaXNwbGF5IGluZm8gZnJvbSBEQyB3aGVu
Cj4+IERDIGVuYWJsZWQuIgo+Pgo+Pgo+PiBIaSBSZXgsCj4+Cj4+Cj4+IEFuZHkgYmlzZWN0ZWQg
YSByZWdyZXNzaW9uIHRvIHlvdXIgY29tbWl0Cj4+IDkxNTYxYTM5ZmE3NGU3OWI4OGUwZTlkNzBm
MzA3MjUwMWM4ZGYyY2UsIHNlZQo+PiBodHRwczovL2J1Z3MuZnJlZWRlc2t0b3Aub3JnLzEwMDM5
NSAuIEFueSBpZGVhcz8KPgo+IGh0dHA6Ly9vbnRyYWNrLWludGVybmFsLmFtZC5jb20vYnJvd3Nl
L1NXREVWLTExNzA5NwoKV2hvb3BzLCBpbnRlcm5hbCBsaW5rLiAgQW55d2F5LCB0aGUgaXNzdWUg
aXMgZGFsIHdhc24ndCBmaWxsaW5nIGluCnNvbWUgaW5mbyBmb3Igb2xkZXIgYXNpY3MgZm9yIHRo
ZXkgZW5kZWQgdXAgc2V0IHRvIDAuCgpBbGV4Cgo+Cj4gQWxleAo+Cj4+Cj4+Cj4+IC0tCj4+IEVh
cnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRw
Oi8vd3d3LmFtZC5jb20KPj4gTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8
ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCj4+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
