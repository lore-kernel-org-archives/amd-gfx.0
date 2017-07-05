From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: move asic id table to a separate file
Date: Wed, 5 Jul 2017 12:05:06 +0100
Message-ID: <CACvgo53goXVskuOCMrL3jRjm_+Eh2OzaGh6a9k54aT+ZC=BEDA@mail.gmail.com>
References: <1496262170-4222-1-git-send-email-Samuel.Li@amd.com>
 <20170612095021.5711-1-michel@daenzer.net>
 <CAKc24n3Z50eUj3DGeH9sQJZyCRAiPx_=a+bKdA+hfP=j8=oaHQ@mail.gmail.com>
 <CACvgo50fDYbeQey54H2Yn7X=cwnExPPgziQqF2EQu2A79wXqWA@mail.gmail.com>
 <CAKc24n3iT8mcBmaDM7KDJ_OweVtcyHQi0eCdbB6nFX7im2ffNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAKc24n3iT8mcBmaDM7KDJ_OweVtcyHQi0eCdbB6nFX7im2ffNA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Chih-Wei Huang <cwhuang-/Cx9OjMEmUl75Oa3hH2JBw@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, ML dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gNSBKdWx5IDIwMTcgYXQgMTE6NDQsIENoaWgtV2VpIEh1YW5nIDxjd2h1YW5nQGFuZHJvaWQt
eDg2Lm9yZz4gd3JvdGU6Cj4gMjAxNy0wNy0wNSAxNzozNSBHTVQrMDg6MDAgRW1pbCBWZWxpa292
IDxlbWlsLmwudmVsaWtvdkBnbWFpbC5jb20+Ogo+PiBPbiA0IEp1bHkgMjAxNyBhdCAwNzo0MCwg
Q2hpaC1XZWkgSHVhbmcgPGN3aHVhbmdAYW5kcm9pZC14ODYub3JnPiB3cm90ZToKPj4+Cj4+PiBV
bmZvcnR1bmF0ZWx5IHRoaXMgcGF0Y2ggYnJlYWtzIEFuZHJvaWQgYnVpbGQKPj4+IHNpbmNlIHRo
ZSB0d28gbWFjcm9zIGFyZSBub3QgZGVmaW5lZC4KPj4+Cj4+PiBBbnlvbmUgaXMgd29ya2luZyBv
biBhIGZpeD8KPj4+IElmIG5vdCwgSSdsbCB0cnkgdG8gcHJvdmlkZSBvbmUuCj4+Pgo+PiBQbGVh
c2Ugc2VuZCBhIHBhdGNoLiBJIGRvdWJ0IG1hbnkgb2YgdGhlIEFNRCBkZXZzIGhhdmUgYW4gQW5k
cm9pZCBzZXR1cC4KPj4gRG8gZW5zdXJlIHRoYXQgdGhlIGFtZGdwdS5pZHMgZmlsZSBpcyBpbnN0
YWxsZWQgYW5kIGFjY2Vzc2libGUuCj4KPiBZZXAuIFRoZSBmaXJzdCBwcm9ibGVtIHRvIHByZXBh
cmUgdGhlIHBhdGNoIGlzLAo+IHdoZXJlIHRvIGluc3RhbGwgYW1kZ3B1LmlkcyBvbiBBbmRyb2lk
Pwo+IElzIC9zeXN0ZW0vZXRjL2FtZGdwdS5pZHMgT0s/Cj4KUGVyc29uYWxseSBJJ2Qgc3RpY2sg
aXQgYWxvbmdzaWRlIHRoZSBwY2kuaWRzL3VzYi5pZHMsIGJ1dCBpdCdzIHVwLXRvCnlvdSByZWFs
bHkuClRoZSBsaWJyYXJ5IGRvZXMgbm90IGNhcmUgYWJvdXQgdGhlIGZpbGVuYW1lL3BhdGggLSBp
dCdzIHBhc3NlZCBhcyBhIGRlZmluZS4KCi1FbWlsCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
