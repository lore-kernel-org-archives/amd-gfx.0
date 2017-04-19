From: Ilia Mirkin <imirkin@alum.mit.edu>
Subject: Re: [RfC PATCH] drm: fourcc byteorder: brings header file comments in
 line with reality.
Date: Tue, 18 Apr 2017 23:28:06 -0400
Message-ID: <CAKb7Uvhscffke3xGT24VZffgUFCFn0paiO3KK50pHH-Jbq6XLA@mail.gmail.com>
References: <20170410101202.19229-1-kraxel@redhat.com>
 <20170410161214.305f5daf@eldfell>
 <1491833847.30990.77.camel@redhat.com> <20170410180941.43922e25@eldfell>
 <CAKb7UvhbgSGwx-2EsrQrHmghzYqO9AhRQ10bDWKfdcXHc3fJeQ@mail.gmail.com>
 <20170411103101.0497fe08@eldfell>
 <CAKb7UviNeLJAHtBQt2NgbEMOSz1sYneiB7i0CUDOBQRt=8OqNw@mail.gmail.com>
 <CAKb7UvgVD3Uf79noXMOcBjJYeeF6st21R3JBNvT-VVSNb8EH+Q@mail.gmail.com>
 <e94bde35-d3f5-fa98-cc64-6d48b37ec21f@daenzer.net>
 <CAKb7UviAoSh6F1v9kCThayVwnWKKi+w1KDLTHHGsLeS95o+Pjg@mail.gmail.com>
 <fe944ecc-3ca4-26d8-77bc-873a53dcbb3f@daenzer.net>
 <1492510440.27392.27.camel@redhat.com>
 <4230c093-6a8a-76d6-dce8-f9b2300fa70f@daenzer.net>
 <CAKb7UvhREjZ9tqarrzYZuta3b66xqRMtBorWxRZN5ECOPyvHbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAKb7UvhREjZ9tqarrzYZuta3b66xqRMtBorWxRZN5ECOPyvHbw@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: Daniel Vetter <daniel.vetter@intel.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Gerd Hoffmann <kraxel@redhat.com>, amd-gfx@lists.freedesktop.org, open list <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gVHVlLCBBcHIgMTgsIDIwMTcgYXQgMTE6MTkgUE0sIElsaWEgTWlya2luIDxpbWlya2luQGFs
dW0ubWl0LmVkdT4gd3JvdGU6Cj4gT24gVHVlLCBBcHIgMTgsIDIwMTcgYXQgOTowMSBQTSwgTWlj
aGVsIETDpG56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD4gd3JvdGU6Cj4+IE9uIDE4LzA0LzE3IDA3
OjE0IFBNLCBHZXJkIEhvZmZtYW5uIHdyb3RlOgo+Pj4gICBIaSwKPj4+Cj4+Pj4+IFF1aXRlIHRy
dWUgdGhhdCB0aGlzIHByb3ZlcyBub3RoaW5nLiBIb3dldmVyIG9uZSBzaG91bGQgbm90ZSB0aGF0
Cj4+Pj4+IGZiY29uIC0+IGZiZGV2IHdvcmtzLAo+Pj4+Cj4+Pj4gQlRXLCB0aGlzIHN1cHBvcnRz
IEdlcmQncyBwYXRjaCwgc2luY2UgdGhlIEtNUyBmYmRldiBlbXVsYXRpb24gY29kZSB1c2VzCj4+
Pj4gZS5nLiBEUk1fRk9STUFUX1hSR0I4ODg4IGZvciBkZXB0aC9icHAgMjQvMzIsIGFuZCB0aGUg
ZmJkZXYgQVBJIHVzZXMKPj4+PiBuYXRpdmUgZW5kaWFuIHBhY2tlZCBjb2xvdXIgdmFsdWVzLgo+
Pj4KPj4+IFNhbWUgaXMgdHJ1ZSBmb3IgRFJNX0lPQ1RMX01PREVfQURERkIsIHdpdGggZGVwdGgv
YnBwIDI0LzMyIHlvdSdsbCBnZXQKPj4+IERSTV9GT1JNQVRfWFJHQjg4ODggKG9ubHkgRFJNX0lP
Q1RMX01PREVfQURERkIyIGFsbG93cyB1c2Vyc3BhY2Ugc3BlY2lmeQo+Pj4gZm91cmNjIGZvcm1h
dHMgZGlyZWN0bHkpLgo+Pgo+PiBSaWdodCwgYW5kIHNpbmNlIGFsbCBtYWpvciBYb3JnIGRyaXZl
cnMgdXNlIERSTV9JT0NUTF9NT0RFX0FEREZCLAo+PiB0aGV5J3JlIGVmZmVjdGl2ZWx5IHVzaW5n
IERSTV9GT1JNQVRfWFJHQjg4ODggYXMgbmF0aXZlIGVuZGlhbm5lc3MgYXMgd2VsbC4KPgo+IElu
IHRoZSBtZWFud2hpbGUsIGl0IGhhcyBiZWVuIHBvaW50ZWQgb3V0IHRvIG1lIHRoYXQgcHJlLW52
NTAgZGlzcGxheQo+IGNvZGUgYWN0dWFsbHkgZG9lc24ndCB1c2UgRFJNX0ZPUk1BVF8qIGF0IGFs
bCAtLSBpdCB1c2VzIHNvbWUgaGVscGVycwo+IHdoaWNoIGVuZCB1cCBhZHZlcnRpc2luZyBYUjI0
IC8gQVIyNC4gSG93ZXZlciBmcm9tIHdoYXQgSSBjYW4gdGVsbCwKPiB0aGF0J3Mgbm90IGEgd2Vs
bC1yZWFzb25lZCBzZWxlY3Rpb24uIEVpdGhlciB3YXksIEknbSBnb2luZyB0byB0ZXN0Cj4gR2Vy
ZCdzIHBhdGNoLCBob3BlZnVsbHkgZHVyaW5nIHRoZSB3ZWVrLCBvciB3ZWVrZW5kIGF0IHRoZSBs
YXRlc3QuIE15Cj4gY3VycmVudCBzdXNwaWNpb24gaXMgdGhhdCBpdCB3aWxsIGhhdmUgbm8gZWZm
ZWN0IG9uIG5vdXZlYXUgZWl0aGVyCj4gd2F5LiBXZSdsbCBmaW5kIG91dC4KCihBbmQgYXMgTWlj
aGVsIHBvaW50cyBvdXQsIHRoZSBwYXRjaCBkb2Vzbid0IGFjdHVhbGx5IHRvdWNoIGFueXRoaW5n
LApqdXN0IGNvbW1lbnRzLiBJIG9yaWdpbmFsbHkgdGhvdWdodCBpdCBjaGFuZ2VkIGZvcm1hdCAt
PiBmb3VyY2MKbWFwcGluZy4pCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ry
aS1kZXZlbAo=
