From: Ilia Mirkin <imirkin@alum.mit.edu>
Subject: Re: [RfC PATCH] drm: fourcc byteorder: brings header file comments in
 line with reality.
Date: Tue, 18 Apr 2017 23:19:22 -0400
Message-ID: <CAKb7UvhREjZ9tqarrzYZuta3b66xqRMtBorWxRZN5ECOPyvHbw@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <4230c093-6a8a-76d6-dce8-f9b2300fa70f@daenzer.net>
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

T24gVHVlLCBBcHIgMTgsIDIwMTcgYXQgOTowMSBQTSwgTWljaGVsIETDpG56ZXIgPG1pY2hlbEBk
YWVuemVyLm5ldD4gd3JvdGU6Cj4gT24gMTgvMDQvMTcgMDc6MTQgUE0sIEdlcmQgSG9mZm1hbm4g
d3JvdGU6Cj4+ICAgSGksCj4+Cj4+Pj4gUXVpdGUgdHJ1ZSB0aGF0IHRoaXMgcHJvdmVzIG5vdGhp
bmcuIEhvd2V2ZXIgb25lIHNob3VsZCBub3RlIHRoYXQKPj4+PiBmYmNvbiAtPiBmYmRldiB3b3Jr
cywKPj4+Cj4+PiBCVFcsIHRoaXMgc3VwcG9ydHMgR2VyZCdzIHBhdGNoLCBzaW5jZSB0aGUgS01T
IGZiZGV2IGVtdWxhdGlvbiBjb2RlIHVzZXMKPj4+IGUuZy4gRFJNX0ZPUk1BVF9YUkdCODg4OCBm
b3IgZGVwdGgvYnBwIDI0LzMyLCBhbmQgdGhlIGZiZGV2IEFQSSB1c2VzCj4+PiBuYXRpdmUgZW5k
aWFuIHBhY2tlZCBjb2xvdXIgdmFsdWVzLgo+Pgo+PiBTYW1lIGlzIHRydWUgZm9yIERSTV9JT0NU
TF9NT0RFX0FEREZCLCB3aXRoIGRlcHRoL2JwcCAyNC8zMiB5b3UnbGwgZ2V0Cj4+IERSTV9GT1JN
QVRfWFJHQjg4ODggKG9ubHkgRFJNX0lPQ1RMX01PREVfQURERkIyIGFsbG93cyB1c2Vyc3BhY2Ug
c3BlY2lmeQo+PiBmb3VyY2MgZm9ybWF0cyBkaXJlY3RseSkuCj4KPiBSaWdodCwgYW5kIHNpbmNl
IGFsbCBtYWpvciBYb3JnIGRyaXZlcnMgdXNlIERSTV9JT0NUTF9NT0RFX0FEREZCLAo+IHRoZXkn
cmUgZWZmZWN0aXZlbHkgdXNpbmcgRFJNX0ZPUk1BVF9YUkdCODg4OCBhcyBuYXRpdmUgZW5kaWFu
bmVzcyBhcyB3ZWxsLgoKSW4gdGhlIG1lYW53aGlsZSwgaXQgaGFzIGJlZW4gcG9pbnRlZCBvdXQg
dG8gbWUgdGhhdCBwcmUtbnY1MCBkaXNwbGF5CmNvZGUgYWN0dWFsbHkgZG9lc24ndCB1c2UgRFJN
X0ZPUk1BVF8qIGF0IGFsbCAtLSBpdCB1c2VzIHNvbWUgaGVscGVycwp3aGljaCBlbmQgdXAgYWR2
ZXJ0aXNpbmcgWFIyNCAvIEFSMjQuIEhvd2V2ZXIgZnJvbSB3aGF0IEkgY2FuIHRlbGwsCnRoYXQn
cyBub3QgYSB3ZWxsLXJlYXNvbmVkIHNlbGVjdGlvbi4gRWl0aGVyIHdheSwgSSdtIGdvaW5nIHRv
IHRlc3QKR2VyZCdzIHBhdGNoLCBob3BlZnVsbHkgZHVyaW5nIHRoZSB3ZWVrLCBvciB3ZWVrZW5k
IGF0IHRoZSBsYXRlc3QuIE15CmN1cnJlbnQgc3VzcGljaW9uIGlzIHRoYXQgaXQgd2lsbCBoYXZl
IG5vIGVmZmVjdCBvbiBub3V2ZWF1IGVpdGhlcgp3YXkuIFdlJ2xsIGZpbmQgb3V0LgoKICAtaWxp
YQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2
ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
