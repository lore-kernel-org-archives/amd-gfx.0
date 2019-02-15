From: Mathias =?ISO-8859-1?Q?Fr=F6hlich?= <Mathias.Froehlich-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Fix reference counting for struct
 dc_sink.
Date: Fri, 15 Feb 2019 08:01:06 +0100
Message-ID: <5359191.OdTp4tEFDK@notebook.internal>
References: <20190210101301.5940-1-Mathias.Froehlich@gmx.net>
 <CADnq5_OvyMPZ-QogBbCWLBA=Ez39tt5hb1Hh2jNJt0Rw+MkuCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_OvyMPZ-QogBbCWLBA=Ez39tt5hb1Hh2jNJt0Rw+MkuCw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Daenzer, Michel" <michel.daenzer-5C7GfCeVMHo@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>

QWxleCwKCk9uIFdlZG5lc2RheSwgMTMgRmVicnVhcnkgMjAxOSAyMTozODowMyBDRVQgQWxleCBE
ZXVjaGVyIHdyb3RlOgo+IEFkZCBhbWQtZ2Z4IGFuZCBzb21lIERDIHBlb3BsZS4KClRoYW5rcyEh
CldoZW4gSSBzZW50LCBJIGRpZCBub3QgcmVtZW1iZXIgdGhhdCB0aGVyZSBpcyBhbiBvdGhlciBs
aXN0IGZvciBhbWQhClVwIHRvIG5vdyBJIGFtIG11Y2ggbW9yZSBvbiB0aGUgTUVTQSBzaWRlIC4u
LgoKTWF0aGlhcwoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
