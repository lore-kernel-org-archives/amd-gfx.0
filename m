From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH libdrm 1/2] amdgpu: prevent an integer wraparound of
 cpu_map_count
Date: Tue, 30 Oct 2018 09:19:38 +0000
Message-ID: <95672c61-694f-1f12-4403-f150744bc712@amd.com>
References: <20181023190733.15251-1-maraeo@gmail.com>
 <7690cf4c-5eff-85e4-885c-2ecc9dc01c25@gmail.com>
 <CAAxE2A50X-XGvyx7GcZnnAC4p-bRnXrQpjQZ1D-8pD5ir3QdMQ@mail.gmail.com>
 <e8cf4264-f211-70b3-01ec-34d0eb5e7edb@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e8cf4264-f211-70b3-01ec-34d0eb5e7edb-otUistvHUpPR7s880joybQ@public.gmane.org>
Content-Language: en-US
Content-ID: <2C28279BB72F544A983B9B63A18934EB-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, =?utf-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMzAuMTAuMTggdW0gMDk6MjAgc2NocmllYiBNaWNoZWwgRMOkbnplcjoNCj4gT24gMjAxOC0x
MC0yOSAxMDoxNSBwLm0uLCBNYXJlayBPbMWhw6FrIHdyb3RlOg0KPj4gWW91IGFuZCBJIGRpc2N1
c3NlZCB0aGlzIGV4dGVuc2l2ZWx5IGludGVybmFsbHkgYSB3aGlsZSBhZ28uIEl0J3MgZXhwZWN0
ZWQNCj4+IGFuZCBjb3JyZWN0IGJlaGF2aW9yLiBNZXNhIGRvZXNuJ3QgdW5tYXAgc29tZSBidWZm
ZXJzIGFuZCBuZXZlciB3aWxsLg0KDQpBaCEgTm93IEkgYXQgbGVhc3QgcmVtZW1iZXIgd2hhdCBp
c3N1ZSB0aGF0IG9uZSB3YXMgZ29vZCBmb3IuDQoNCj4gSXQgZG9lc24ndCBuZWVkIHRvIGtlZXAg
bWFwcGluZyB0aGUgc2FtZSBidWZmZXIgb3ZlciBhbmQgb3ZlciBhZ2Fpbg0KPiB0aG91Z2gsIGRv
ZXMgaXQ/DQoNClllYWgsIHRoYXQncyBhIGJpdCB1bmNsZWFyIHRvIG1lIGFzIHdlbGwuDQoNCkNo
cmlzdGlhbi4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
