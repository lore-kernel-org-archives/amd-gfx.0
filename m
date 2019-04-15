From: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Subject: Re: [PATCH 2/9] drm/syncobj: add new drm_syncobj_add_point interface
 v4
Date: Mon, 15 Apr 2019 21:06:42 +0200
Message-ID: <CAKMK7uFjsn8ChvSYdONr0kdTuJaPsPZ_UnS80dL=FyS06i_e1g@mail.gmail.com>
References: <20190325083224.2983-1-david1.zhou@amd.com>
 <20190325083224.2983-2-david1.zhou@amd.com>
 <1e6783f1-8db6-47b5-2083-724257a53f84@intel.com>
 <5a435812-41f9-c2a6-d2cd-0b2ee1c76e52@gmail.com>
 <5f93be6c-5038-3409-d98d-55d50a62854c@intel.com>
 <MN2PR12MB2910AAA9FDB0E827C6D0D94DB4550@MN2PR12MB2910.namprd12.prod.outlook.com>
 <f8e0e0af-c917-af05-9aa8-cecbbfcf73f9@intel.com>
 <0674a0a5-7311-55c9-3634-2e96b89e2caa@amd.com>
 <5dd6ae07-24d4-db2b-cc3f-80150e1b0ea6@intel.com>
 <617d8c52-d394-3d99-cbd8-37ede18eb9de@amd.com>
 <CAPM=9tybViaRubzO1C=s0RtUsS=Z4bKtX40Ue0yo_hXg0UySBw@mail.gmail.com>
 <01c86eb6-0e76-86c7-7437-f1d88419b4ae@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <01c86eb6-0e76-86c7-7437-f1d88419b4ae-5C7GfCeVMHo@public.gmane.org>
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
Cc: "jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org" <jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Hector,
 Tobias" <Tobias.Hector-5C7GfCeVMHo@public.gmane.org>

T24gTW9uLCBBcHIgMTUsIDIwMTkgYXQgODo1NiBQTSBLb2VuaWcsIENocmlzdGlhbgo8Q2hyaXN0
aWFuLktvZW5pZ0BhbWQuY29tPiB3cm90ZToKPgo+IEFtIDE1LjA0LjE5IHVtIDIwOjU0IHNjaHJp
ZWIgRGF2ZSBBaXJsaWU6Cj4gPj4gV2VsbCwgSSd2ZSBnb3QgY29tbWl0IHJpZ2h0cyBhcyB3ZWxs
Lgo+ID4+Cj4gPj4gR29pbmcgdG8gcmVtb3ZlIHRoZSB3YXJuaW5nLCBhZGQgeW91ciByYiBhbmQg
cHVzaCBldmVyeXRoaW5nIGlmIG5vYm9keQo+ID4+IG9iamVjdHMgaW4gdGhlIG5leHQgaG91ciBv
ciBzby4KPiA+IFNvIHRoaXMgZ290IGNvbW1pdHRlZCBhbmQgaXMgaW4gbXkgLW5leHQgdHJlZSwg
YnV0IHdoZXJlIGlzIHRoZQo+ID4gdXNlcnNwYWNlIGFuZCBpZ3QgdGVzdHM/Cj4KPiBJIHdhcyB3
YWl0aW5nIGZvciB0aGlzIHRvIGxhbmQgaW4gLW5leHQgYmVmb3JlIHB1c2hpbmcgdGhlIGxpYmRy
bQo+IGNoYW5nZXMgd2l0aCBhbWRncHUgdGVzdCBjYXNlcy4KPgo+IEFzIHNvb24gYXMgdGhvc2Ug
YXJlIGNvbW1pdHRlZCBMaW9uZWwgYW5kIERhdmlkIHdhbnRlZCB0byBjb21taXQgdGhlIGlndAo+
IHRlc3RzLgoKVGVzdGNhc2VzIGFyZSBvZmMgZ3JlYXQsIGJ1dCB0aGF0J3Mgbm90IHRoZSB1c2Vy
c3BhY2Ugd2UncmUgbG9va2luZwpmb3IgOi0pIEFsbCBzdGlsbCBraHIgZW1iYXJnbz8gRXZlbiBp
ZiB0aGF0J3MgYWxsIGF2YWlsYWJsZSBhdCB1bmRlcgpraHIgbmRhLCBhbmQgcmV2aWV3ZWQgYnkg
cmVsZXZhbnQgZm9sa3MgSSdtIG5vdCBzdXJlIHdlJ3JlIHNldHRpbmcgYQpncmVhdCBwcmVjZWRl
bmNlIGhlcmUgLSBpZiBraHIgc3RpbGwgd2FudHMgdG8gYmUgYWJsZSB0byBjaGFuZ2UgdGhlCmlu
dGVyZmFjZSBzcGVjLCBjYXN0aW5nIHRoZSBrZXJuZWwgdWFwaSBpbnRvIHN0b25lIGlzIGEgYml0
IHByZW1hdHVyZS4KQXNpZGUgZnJvbSB0aGF0IHRoaXMgZXhjbHVkZXMgZXZlcnlvbmUgd2l0aG91
dCBraHIgbmRhLCB3aGljaCBpc24ndCBhCm5pY2UgbW92ZSByZWFsbHkuIE5vdGU6IFBpY2t5IGJl
Y2F1c2UgdGhpcyBpcyB3aW5zeXMgc3R1ZmYsIHNvCnJlbGV2YW50IGJleW9uZCBqdXN0IGEgc2lu
Z2xlIGRyaXZlciAtIGZvciBkcml2ZXIvaHcgc3BlY2lmaWMgc3R1ZmYgaXQKbWFrZXMgc2Vuc2Ug
dG8gYWxsb3cgcGxlbnR5IG9mIGxlZXdheSB0byB3b3JrIGFyb3VuZCB2YXJpb3VzIGVtYmFyZ29z
LgotRGFuaWVsCi0tIApEYW5pZWwgVmV0dGVyClNvZnR3YXJlIEVuZ2luZWVyLCBJbnRlbCBDb3Jw
b3JhdGlvbgorNDEgKDApIDc5IDM2NSA1NyA0OCAtIGh0dHA6Ly9ibG9nLmZmd2xsLmNoCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
