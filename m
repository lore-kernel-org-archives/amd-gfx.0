From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH xf86-video-ati 5/6] Make all active CRTCs scan out an
 all-black framebuffer in LeaveVT
Date: Tue, 29 Aug 2017 11:56:58 +0100
Message-ID: <CACvgo52+5yVkKdwDMSdGnbM2C-Z-wUt3NdewP8oystW6=LVn2Q@mail.gmail.com>
References: <20170828092343.27742-1-michel@daenzer.net>
 <20170828092343.27742-6-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170828092343.27742-6-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SGkgTWljaGVsLAoKT24gMjggQXVndXN0IDIwMTcgYXQgMTA6MjMsIE1pY2hlbCBEw6RuemVyIDxt
aWNoZWxAZGFlbnplci5uZXQ+IHdyb3RlOgo+IEZyb206IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwu
ZGFlbnplckBhbWQuY29tPgo+Cj4gQW5kIGRlc3Ryb3kgYWxsIG90aGVyIEZCcy4gVGhpcyBpcyBz
byB0aGF0IG90aGVyIERSTSBtYXN0ZXJzIGNhbiBvbmx5Cj4gZ2V0IGFjY2VzcyB0byB0aGlzIGFs
bC1ibGFjayBGQiwgbm90IHRvIGFueSBvdGhlciBGQiB3ZSBjcmVhdGVkLCB3aGlsZQo+IHdlJ3Jl
IHN3aXRjaGVkIGF3YXkgYW5kIG5vdCBEUk0gbWFzdGVyLgo+Cklzbid0IHRoZSBpc3N1ZSBhcHBs
aWNhYmxlIG92ZXJhbGwgLSBiZSB0aGF0IGluIFgsIHdheWxhbmQgY29tcG9zaXRvcnMsIG90aGVy
PwoKSUlSQyB0aGUgdm13Z2Z4J3Mga2VybmVsIGRyaXZlciwgd2hpY2ggaGFzIGV4dHJhIGxvY2tp
bmcgWzFdIGluIG9yZGVyCnRvIGFkZHJlc3MgdGhhdC4KV291bGQgYSBzaW1pbGFyIGFwcHJvYWNo
IGxpa2UgdGhhdCBiZSBhcHBsaWNhYmxlIGZvciByYWRlb24vYW1kZ3B1PwoKSSdtIG5vdCBzYXlp
bmcgdGhhdCB0aGlzIGlzIGJhZC9ub3QgbmVlZGVkLiBKdXN0IHdvbmRlcmluZyBvbiBhCiJwZXJm
ZWN0IiBsb25nIHRlcm0gc29sdXRpb24uClRoYXQgaXMsIHVubGVzcyBJJ3ZlIGxvc3QgdGhlIHBs
b3QgYW5kIHRoZSB0d28gYXJlIGNvbXBsZXRlbHkgdW5yZWxhdGVkLgoKVGhhbmtzCkVtaWwKCmh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xp
bnV4LmdpdC90cmVlL2RyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X2Rydi5jP2g9djQuMTMt
cmM3I24xMDU0Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
