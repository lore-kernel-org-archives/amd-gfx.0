From: Chih-Wei Huang <cwhuang-/Cx9OjMEmUl75Oa3hH2JBw@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: move asic id table to a separate file
Date: Wed, 19 Jul 2017 18:10:01 +0800
Message-ID: <CAKc24n3=MsKjBYc8HJ20qkoNvOrYC2G1muHWqfwEzAtOpRzz7g@mail.gmail.com>
References: <1496262170-4222-1-git-send-email-Samuel.Li@amd.com>
 <20170612095021.5711-1-michel@daenzer.net>
 <CAKc24n3Z50eUj3DGeH9sQJZyCRAiPx_=a+bKdA+hfP=j8=oaHQ@mail.gmail.com>
 <CACvgo50fDYbeQey54H2Yn7X=cwnExPPgziQqF2EQu2A79wXqWA@mail.gmail.com>
 <CAKc24n3iT8mcBmaDM7KDJ_OweVtcyHQi0eCdbB6nFX7im2ffNA@mail.gmail.com>
 <CACvgo53goXVskuOCMrL3jRjm_+Eh2OzaGh6a9k54aT+ZC=BEDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CACvgo53goXVskuOCMrL3jRjm_+Eh2OzaGh6a9k54aT+ZC=BEDA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

U29ycnkgZm9yIHJlcGx5IGxhdGUuCgoyMDE3LTA3LTA1IDE5OjA1IEdNVCswODowMCBFbWlsIFZl
bGlrb3YgPGVtaWwubC52ZWxpa292QGdtYWlsLmNvbT46Cj4gT24gNSBKdWx5IDIwMTcgYXQgMTE6
NDQsIENoaWgtV2VpIEh1YW5nIDxjd2h1YW5nQGFuZHJvaWQteDg2Lm9yZz4gd3JvdGU6Cj4+Cj4+
IFllcC4gVGhlIGZpcnN0IHByb2JsZW0gdG8gcHJlcGFyZSB0aGUgcGF0Y2ggaXMsCj4+IHdoZXJl
IHRvIGluc3RhbGwgYW1kZ3B1LmlkcyBvbiBBbmRyb2lkPwo+PiBJcyAvc3lzdGVtL2V0Yy9hbWRn
cHUuaWRzIE9LPwo+Pgo+IFBlcnNvbmFsbHkgSSdkIHN0aWNrIGl0IGFsb25nc2lkZSB0aGUgcGNp
Lmlkcy91c2IuaWRzLCBidXQgaXQncyB1cC10bwo+IHlvdSByZWFsbHkuCgpUaGFua3MhClRoZXJl
IGZpbGVzIGFyZSB1c3VhbGx5IGluIC91c3Ivc2hhcmUvaHdkYXRhLwpidXQgQW5kcm9pZCBoYXMg
bm8gc3VjaCBhIGRpcmVjdG9yeS4KU28gSSdtIGdvaW5nIHRvIHVzZSAvZXRjL2h3ZGF0YS8uCgo+
IFRoZSBsaWJyYXJ5IGRvZXMgbm90IGNhcmUgYWJvdXQgdGhlIGZpbGVuYW1lL3BhdGggLSBpdCdz
IHBhc3NlZCBhcyBhIGRlZmluZS4KCgotLSAKQ2hpaC1XZWkKQW5kcm9pZC14ODYgcHJvamVjdApo
dHRwOi8vd3d3LmFuZHJvaWQteDg2Lm9yZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
