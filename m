From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: add FENCE_TO_HANDLE ioctl that returns
 syncobj or sync_file
Date: Fri, 29 Sep 2017 14:35:30 +0200
Message-ID: <CAAxE2A5GVuEjQkicig0odKDU7u0w0F=FaGxyGGiMT2T+q__PSA@mail.gmail.com>
References: <1505248934-1819-1-git-send-email-maraeo@gmail.com>
 <1505248934-1819-3-git-send-email-maraeo@gmail.com>
 <CAAxE2A5cKMxcfORnJPczRX=BaHm-n1h26rvCBZmd6iGsGk-RqQ@mail.gmail.com>
 <CAPM=9ty8YhG16QSE8OQTDaAPQxT7mXE=cRn1OJXXznUtcBaRSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAPM=9ty8YhG16QSE8OQTDaAPQxT7mXE=cRn1OJXXznUtcBaRSA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gRnJpLCBTZXAgMjksIDIwMTcgYXQgMTo0MiBBTSwgRGF2ZSBBaXJsaWUgPGFpcmxpZWRAZ21h
aWwuY29tPiB3cm90ZToKPiBPbiAyOSBTZXB0ZW1iZXIgMjAxNyBhdCAwNjo0MSwgTWFyZWsgT2zF
ocOhayA8bWFyYWVvQGdtYWlsLmNvbT4gd3JvdGU6Cj4+IENhbiBJIGdldCBSYiBmb3IgdGhpcyBz
ZXJpZXM/Cj4+Cj4KPiBGb3IgdGhlIHNlcmllcywKPgo+IFJldmlld2VkLWJ5OiBEYXZlIEFpcmxp
ZSA8YWlybGllZEByZWRoYXQuY29tPgo+Cj4gQWxleCwgcGxlYXNlIG1lcmdlIHRoZSB0d28gZHJt
IGNvcmUgcHJlY3Vyc29yIHdpdGggcGF0Y2ggMy4KCkFsZXgsIHRoaXMgaXMgZm9yIGRybS1uZXh0
LCB3aGVyZSBJIGNhbid0IHB1c2guCgpUaGFua3MsCk1hcmVrCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
