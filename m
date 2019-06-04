From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 01/13] drm/amdgpu: introduce and honour DRM_FORCE_AUTH
 workaround
Date: Tue, 4 Jun 2019 12:50:59 +0200
Message-ID: <ee1b8980-3d78-aa6d-fe46-2c0d45c2bbdd@daenzer.net>
References: <20190527081741.14235-1-emil.l.velikov@gmail.com>
 <3c9b5688-5e83-f173-00e3-6e139e05d466@amd.com>
 <20190527132041.GP21222@phenom.ffwll.local>
 <20190527132607.GH15067@arch-x1c3>
 <0426fb3e-e7bc-2464-cb42-4d5753956d23@amd.com>
 <CAKMK7uE_pRro8PxTwUq+pC_1GVVT7nUxan1T-kqSYT=BMHTf2g@mail.gmail.com>
 <d12a7dd4-595b-d0aa-a87d-527392fb0384@amd.com>
 <CAKMK7uE1ZWjCeg3q7qDrbcj89+DuPQwfjMqC8hTjDAMU5bhh-w@mail.gmail.com>
 <98c3d891-6966-2043-9709-4e718dbc6bac@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <98c3d891-6966-2043-9709-4e718dbc6bac-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOS0wNS0yOCAxMDowMyBhLm0uLCBLb2VuaWcsIENocmlzdGlhbiB3cm90ZToKPiAKPiBJ
IHJhdGhlciB0aGluayB0aGF0IHdlIHNob3VsZCBnbyBkb3duIHRoZSByb3V0ZSBvZiBjb21wbGV0
ZWx5IGRyb3BwaW5nIAo+IGNvbW1hbmQgc3VibWlzc2lvbiBhbmQgYnVmZmVyIGFsbG9jYXRpb24g
dGhyb3VnaCB0aGUgcHJpbWFyeSBub2RlIGZvciAKPiBub24gbWFzdGVyIGNsaWVudHMuIEFuZCB0
aGVuIGFzIG5leHQgc3RlcCBhdCBzb21lIHBvaW50IGRyb3Agc3VwcG9ydCBmb3IgCj4gYXV0aGVu
dGljYXRpb24vZmxpbmsuCgpLZWVwIGluIG1pbmQgdGhhdCBldmVuIGRpc3BsYXkgc2VydmVycyBh
cmVuJ3QgRFJNIG1hc3RlciB3aGlsZSB0aGVpciBWVAppc24ndCBhY3RpdmUsIHNvIHRoaXMgbWln
aHQgYmUgcHJvYmxlbWF0aWMgaWYgYSBkaXNwbGF5IHNlcnZlciBuZWVkcyB0bwpkbyBzb21lIGNv
bW1hbmQgc3VibWlzc2lvbiAvIGJ1ZmZlciBhbGxvY2F0aW9uIGR1cmluZyB0aGF0IHRpbWUuCgoK
LS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAg
IGh0dHBzOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAg
ICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeA==
