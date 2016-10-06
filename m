From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: initialize the context reset_counter in
 amdgpu_ctx_init
Date: Thu, 6 Oct 2016 11:22:33 -0400
Message-ID: <CADnq5_MMz9wdHdyu1TBNtFPenrVqB9R+1Sc+p4R_eLbXwqzKFQ@mail.gmail.com>
References: <1475567106-5818-1-git-send-email-nhaehnle@gmail.com>
 <2d749b1b-5d1b-f0bc-502b-358acf09e04a@vodafone.de>
 <CAAxE2A55JNWJ3hP5MtbHA=Jz_5bKQDnfvvTrwvW-g2LiDf8TrA@mail.gmail.com>
 <CADnq5_O8-D7hS5riU-7izo-jxh7fLTMYfpevcbBJqJHbKmKXjQ@mail.gmail.com>
 <CAAxE2A6FHmQhfzxAiq9-pMi+LkyJ6PAqvZi_-MV-xX1sZ_vv-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A6FHmQhfzxAiq9-pMi+LkyJ6PAqvZi_-MV-xX1sZ_vv-A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, =?UTF-8?Q?Nicolai_H=C3=A4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Nicolai_H=C3=A4hnle?= <nicolai.haehnle-5C7GfCeVMHo@public.gmane.org>

T24gVGh1LCBPY3QgNiwgMjAxNiBhdCAxMDo0MyBBTSwgTWFyZWsgT2zFocOhayA8bWFyYWVvQGdt
YWlsLmNvbT4gd3JvdGU6Cj4gT24gVGh1LCBPY3QgNiwgMjAxNiBhdCA0OjI0IFBNLCBBbGV4IERl
dWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4gd3JvdGU6Cj4+IE9uIFRodSwgT2N0IDYsIDIw
MTYgYXQgNjoyOCBBTSwgTWFyZWsgT2zFocOhayA8bWFyYWVvQGdtYWlsLmNvbT4gd3JvdGU6Cj4+
PiBEbyB3ZSBuZWVkIHRvIGJ1bXAgdGhlIERSTSB2ZXJzaW9uIGZvciB0aGlzIGJ1ZyBmaXg/Cj4+
Pgo+Pgo+PiBBbHRlcm5hdGl2ZWx5LCB3ZSBjb3VsZCBqdXN0IGNjIHN0YWJsZS4gIEJlaW5nIHRo
YXQgdGhlIHdob2xlIHJlc2V0Cj4+IGhhbmRsaW5nIGlzIG1lc2EgaXMgdGlsbCBraW5kIG9mIHVw
IGluIHRoZSBhaXIsIEknbSBub3Qgc3VyZSBob3cKPj4gY3JpdGljYWwgaXQgaXMuCj4KPiBUaGUg
TWVzYSBwYXJ0IGlzIGFjdHVhbGx5IGNvbXBsZXRlLiBUaGUgcHJvYmxlbSBpcyB0aGF0IGlmIGFu
Cj4gYXBwbGljYXRpb24gcmVxdWVzdHMgdGhlIEdMX0xPU0VfQ09OVEVYVF9PTl9SRVNFVCBzdHJh
dGVneSwgYW4KPiBpbmNvcnJlY3QgcmVzZXQgY291bnRlciByZXR1cm5lZCBieSB0aGUga2VybmVs
IHdpbGwgYXV0b21hdGljYWxseSBraWxsCj4gdGhlIE9wZW5HTCBjb250ZXh0IChieSBzZXR0aW5n
IHRoZSBuby1vcCBkaXNwYXRjaCksIHNvIGl0J3MgYSBwcmV0dHkKPiBzZXJpb3VzIGlzc3VlIGFu
ZCB0aGUga2VybmVsIHNob3VsZCByZXR1cm4gY29ycmVjdCB2YWx1ZXMgcmVnYXJkbGVzcwo+IG9m
IHRoZSBzdGF0ZSBvZiBHUFUgcmVzZXQgdGhlcmUuIElmIHRoZSBrZXJuZWwgcmV0dXJucyBhbiBp
bmNvcnJlY3QKPiByZXNldCBjb3VudGVyLCB3ZSBuZWVkIGEgdmVyc2lvbiBidW1wIGZvciB0aGUg
Zml4LgoKR1BVIHJlc2V0IGlzIGN1cnJlbnRseSBkaXNhYmxlZCBieSBkZWZhdWx0IHNvIHRoZSBj
b3VudGVyIHNob3VsZCBuZXZlcgpjaGFuZ2UgYXQgdGhpcyBwb2ludC4KCkFsZXgKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
