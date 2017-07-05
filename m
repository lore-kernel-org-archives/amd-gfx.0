From: Chih-Wei Huang <cwhuang-/Cx9OjMEmUl75Oa3hH2JBw@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: move asic id table to a separate file
Date: Wed, 5 Jul 2017 18:44:53 +0800
Message-ID: <CAKc24n3iT8mcBmaDM7KDJ_OweVtcyHQi0eCdbB6nFX7im2ffNA@mail.gmail.com>
References: <1496262170-4222-1-git-send-email-Samuel.Li@amd.com>
 <20170612095021.5711-1-michel@daenzer.net>
 <CAKc24n3Z50eUj3DGeH9sQJZyCRAiPx_=a+bKdA+hfP=j8=oaHQ@mail.gmail.com>
 <CACvgo50fDYbeQey54H2Yn7X=cwnExPPgziQqF2EQu2A79wXqWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CACvgo50fDYbeQey54H2Yn7X=cwnExPPgziQqF2EQu2A79wXqWA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, ML dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

MjAxNy0wNy0wNSAxNzozNSBHTVQrMDg6MDAgRW1pbCBWZWxpa292IDxlbWlsLmwudmVsaWtvdkBn
bWFpbC5jb20+Ogo+IE9uIDQgSnVseSAyMDE3IGF0IDA3OjQwLCBDaGloLVdlaSBIdWFuZyA8Y3do
dWFuZ0BhbmRyb2lkLXg4Ni5vcmc+IHdyb3RlOgo+Pgo+PiBVbmZvcnR1bmF0ZWx5IHRoaXMgcGF0
Y2ggYnJlYWtzIEFuZHJvaWQgYnVpbGQKPj4gc2luY2UgdGhlIHR3byBtYWNyb3MgYXJlIG5vdCBk
ZWZpbmVkLgo+Pgo+PiBBbnlvbmUgaXMgd29ya2luZyBvbiBhIGZpeD8KPj4gSWYgbm90LCBJJ2xs
IHRyeSB0byBwcm92aWRlIG9uZS4KPj4KPiBQbGVhc2Ugc2VuZCBhIHBhdGNoLiBJIGRvdWJ0IG1h
bnkgb2YgdGhlIEFNRCBkZXZzIGhhdmUgYW4gQW5kcm9pZCBzZXR1cC4KPiBEbyBlbnN1cmUgdGhh
dCB0aGUgYW1kZ3B1LmlkcyBmaWxlIGlzIGluc3RhbGxlZCBhbmQgYWNjZXNzaWJsZS4KClllcC4g
VGhlIGZpcnN0IHByb2JsZW0gdG8gcHJlcGFyZSB0aGUgcGF0Y2ggaXMsCndoZXJlIHRvIGluc3Rh
bGwgYW1kZ3B1LmlkcyBvbiBBbmRyb2lkPwpJcyAvc3lzdGVtL2V0Yy9hbWRncHUuaWRzIE9LPwoK
PiBKRllJOiBhIHNpbWlsYXIgd29yayBpcyBjb21pbmcgb24gdGhlIHJhZGVvbiBzaWRlLCBzbyBr
ZWVwIGFuIGV5ZSBvcGVuLgoKCgoKLS0gCkNoaWgtV2VpCkFuZHJvaWQteDg2IHByb2plY3QKaHR0
cDovL3d3dy5hbmRyb2lkLXg4Ni5vcmcKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
