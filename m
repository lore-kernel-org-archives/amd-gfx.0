From: Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RfC PATCH] drm: fourcc byteorder: brings header file comments
 in line with reality.
Date: Tue, 18 Apr 2017 12:14:00 +0200
Message-ID: <1492510440.27392.27.camel@redhat.com>
References: <20170410101202.19229-1-kraxel@redhat.com>
 <20170410161214.305f5daf@eldfell> <1491833847.30990.77.camel@redhat.com>
 <20170410180941.43922e25@eldfell>
 <CAKb7UvhbgSGwx-2EsrQrHmghzYqO9AhRQ10bDWKfdcXHc3fJeQ@mail.gmail.com>
 <20170411103101.0497fe08@eldfell>
 <CAKb7UviNeLJAHtBQt2NgbEMOSz1sYneiB7i0CUDOBQRt=8OqNw@mail.gmail.com>
 <CAKb7UvgVD3Uf79noXMOcBjJYeeF6st21R3JBNvT-VVSNb8EH+Q@mail.gmail.com>
 <e94bde35-d3f5-fa98-cc64-6d48b37ec21f@daenzer.net>
 <CAKb7UviAoSh6F1v9kCThayVwnWKKi+w1KDLTHHGsLeS95o+Pjg@mail.gmail.com>
 <fe944ecc-3ca4-26d8-77bc-873a53dcbb3f@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <fe944ecc-3ca4-26d8-77bc-873a53dcbb3f-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: Daniel Vetter <daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Ilia Mirkin <imirkin-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

ICBIaSwKCj4gPiBRdWl0ZSB0cnVlIHRoYXQgdGhpcyBwcm92ZXMgbm90aGluZy4gSG93ZXZlciBv
bmUgc2hvdWxkIG5vdGUgdGhhdAo+ID4gZmJjb24gLT4gZmJkZXYgd29ya3MsCj4gCj4gQlRXLCB0
aGlzIHN1cHBvcnRzIEdlcmQncyBwYXRjaCwgc2luY2UgdGhlIEtNUyBmYmRldiBlbXVsYXRpb24g
Y29kZSB1c2VzCj4gZS5nLiBEUk1fRk9STUFUX1hSR0I4ODg4IGZvciBkZXB0aC9icHAgMjQvMzIs
IGFuZCB0aGUgZmJkZXYgQVBJIHVzZXMKPiBuYXRpdmUgZW5kaWFuIHBhY2tlZCBjb2xvdXIgdmFs
dWVzLgoKU2FtZSBpcyB0cnVlIGZvciBEUk1fSU9DVExfTU9ERV9BRERGQiwgd2l0aCBkZXB0aC9i
cHAgMjQvMzIgeW91J2xsIGdldApEUk1fRk9STUFUX1hSR0I4ODg4IChvbmx5IERSTV9JT0NUTF9N
T0RFX0FEREZCMiBhbGxvd3MgdXNlcnNwYWNlIHNwZWNpZnkKZm91cmNjIGZvcm1hdHMgZGlyZWN0
bHkpLgoKY2hlZXJzLAogIEdlcmQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
