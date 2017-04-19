From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [RfC PATCH] drm: fourcc byteorder: brings header file comments in
 line with reality.
Date: Wed, 19 Apr 2017 10:01:47 +0900
Message-ID: <4230c093-6a8a-76d6-dce8-f9b2300fa70f@daenzer.net>
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
 <1492510440.27392.27.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1492510440.27392.27.camel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Daniel Vetter <daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

T24gMTgvMDQvMTcgMDc6MTQgUE0sIEdlcmQgSG9mZm1hbm4gd3JvdGU6Cj4gICBIaSwKPiAKPj4+
IFF1aXRlIHRydWUgdGhhdCB0aGlzIHByb3ZlcyBub3RoaW5nLiBIb3dldmVyIG9uZSBzaG91bGQg
bm90ZSB0aGF0Cj4+PiBmYmNvbiAtPiBmYmRldiB3b3JrcywKPj4KPj4gQlRXLCB0aGlzIHN1cHBv
cnRzIEdlcmQncyBwYXRjaCwgc2luY2UgdGhlIEtNUyBmYmRldiBlbXVsYXRpb24gY29kZSB1c2Vz
Cj4+IGUuZy4gRFJNX0ZPUk1BVF9YUkdCODg4OCBmb3IgZGVwdGgvYnBwIDI0LzMyLCBhbmQgdGhl
IGZiZGV2IEFQSSB1c2VzCj4+IG5hdGl2ZSBlbmRpYW4gcGFja2VkIGNvbG91ciB2YWx1ZXMuCj4g
Cj4gU2FtZSBpcyB0cnVlIGZvciBEUk1fSU9DVExfTU9ERV9BRERGQiwgd2l0aCBkZXB0aC9icHAg
MjQvMzIgeW91J2xsIGdldAo+IERSTV9GT1JNQVRfWFJHQjg4ODggKG9ubHkgRFJNX0lPQ1RMX01P
REVfQURERkIyIGFsbG93cyB1c2Vyc3BhY2Ugc3BlY2lmeQo+IGZvdXJjYyBmb3JtYXRzIGRpcmVj
dGx5KS4KClJpZ2h0LCBhbmQgc2luY2UgYWxsIG1ham9yIFhvcmcgZHJpdmVycyB1c2UgRFJNX0lP
Q1RMX01PREVfQURERkIsCnRoZXkncmUgZWZmZWN0aXZlbHkgdXNpbmcgRFJNX0ZPUk1BVF9YUkdC
ODg4OCBhcyBuYXRpdmUgZW5kaWFubmVzcyBhcyB3ZWxsLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVs
IETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29t
CkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNh
IGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
