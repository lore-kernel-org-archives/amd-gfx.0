From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add the interface of waiting multiple fences
 (v3)
Date: Tue, 27 Sep 2016 05:54:35 +1000
Message-ID: <CAPM=9txFw=iotyTrJyHGcxxWkYjDK4WyB5mcSPALxzRn6yUHfA@mail.gmail.com>
References: <1473698408-17817-1-git-send-email-alexander.deucher@amd.com>
 <CAP+8YyGL9C9rM0c5r5R0GuRQhQptE=3baaeLB71PLGYMJuNS+A@mail.gmail.com>
 <d1d8996e-88af-4ea1-4659-e0bc8e190898@vodafone.de>
 <BN6PR12MB16839DB76854145B5D00E505F7FF0@BN6PR12MB1683.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB16839DB76854145B5D00E505F7FF0-/b2+HYfkarTZ9ihocuPUdQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Bas Nieuwenhuizen <bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org>

T24gMTMgU2VwdGVtYmVyIDIwMTYgYXQgMDQ6NDgsIERldWNoZXIsIEFsZXhhbmRlcgo8QWxleGFu
ZGVyLkRldWNoZXJAYW1kLmNvbT4gd3JvdGU6Cj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
Cj4+IEZyb206IGFtZC1nZnggW21haWx0bzphbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnXSBPbiBCZWhhbGYKPj4gT2YgQ2hyaXN0aWFuIEvDtm5pZwo+PiBTZW50OiBNb25kYXks
IFNlcHRlbWJlciAxMiwgMjAxNiAyOjQ2IFBNCj4+IFRvOiBCYXMgTmlldXdlbmh1aXplbjsgQWxl
eCBEZXVjaGVyCj4+IENjOiBaaGFuZywgSmVycnk7IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGFkZCB0aGUgaW50ZXJmYWNl
IG9mIHdhaXRpbmcgbXVsdGlwbGUKPj4gZmVuY2VzICh2MykKPj4KPj4gWWVhaCwgd2UgYWRkZWQg
dGhhdCBsYXRlciBvbi4KPj4KPj4gTG9va3MgbGlrZSBBbGV4IChvciBzb21lYm9keSBlbHNlKSBz
cXVhc2hlZCB0aGUgb3JpZ2luYWwgYW5kIGZvbGxvdyB1cAo+PiBwYXRjaCBmb3IgbGliZHJtIHRv
Z2V0aGVyLCBidXQgZm9yZ290IHRvIGRvIHNvIGZvciB0aGUga2VybmVsIHNpZGUuCj4+Cj4+IEp1
c3Qgd2FpdCBhIG1vbWVudCwgaWYgQWxleCBjYW4ndCBmaW5kIHRoYXQgb2YgaGFuZCBJJ20gZ29p
bmcgdG8gdGFrZSBhCj4+IGxvb2sgdGhyb3VnaCB0aGUgYnJhbmNoZXMgdG9tb3Jyb3cuCj4KPiBJ
IGZvdW5kIGl0LiAgTG9va3MgbGlrZSB0aGUgY29tbWl0IG1lc3NhZ2UgZ290IG1lc3NlZCB1cC4g
IEknbGwgZml4IGl0IHVwIGFuZCBzZW5kIGl0IG91dCBzaG9ydGx5Lgo+CgpJcyB0aGlzIGFsc28g
bWlzc2luZyBhbiBpbnRlcmZhY2UgdmVyc2lvbiBidW1wIHNvIHdlIGtub3cgd2UgY2FuIHVzZSBp
dD8KCkRhdmUuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
