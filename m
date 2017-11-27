From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH 02/13] fbdev: add remove_conflicting_pci_framebuffers()
Date: Mon, 27 Nov 2017 20:52:19 +0000
Message-ID: <20171127205219.GA3537@sudip-laptop>
References: <cover.1511544782.git.mirq-linux@rere.qmqm.pl>
 <1738dbed0239bffc886f126fd3091daa39cd14c9.1511544782.git.mirq-linux@rere.qmqm.pl>
 <20171127102758.y7c6yzyey6wfntxh@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20171127102758.y7c6yzyey6wfntxh@phenom.ffwll.local>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Gerd Hoffmann <kraxel@redhat.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gTW9uLCBOb3YgMjcsIDIwMTcgYXQgMTE6Mjc6NTlBTSArMDEwMCwgRGFuaWVsIFZldHRlciB3
cm90ZToKPiBPbiBGcmksIE5vdiAyNCwgMjAxNyBhdCAwNjo1MzozMVBNICswMTAwLCBNaWNoYcWC
IE1pcm9zxYJhdyB3cm90ZToKPiA+IEFsbW9zdCBhbGwgZHJpdmVycyB1c2luZyByZW1vdmVfY29u
ZmxpY3RpbmdfZnJhbWVidWZmZXJzKCkgd3JhcCBpdCB3aXRoCj4gPiB0aGUgc2FtZSBjb2RlLiBF
eHRyYWN0IGNvbW1vbiBwYXJ0IGZyb20gUENJIGRyaXZlcnMgaW50byBzZXBhcmF0ZQo+ID4gcmVt
b3ZlX2NvbmZsaWN0aW5nX3BjaV9mcmFtZWJ1ZmZlcnMoKS4KPiA+IAo+ID4gU2lnbmVkLW9mZi1i
eTogTWljaGHFgiBNaXJvc8WCYXcgPG1pcnEtbGludXhAcmVyZS5xbXFtLnBsPgo+IAo+IFNpbmNl
IHRoZSBvbmx5IGRyaXZlciB0aGF0IHNlZW1zIHRvIHVzZSB0aGlzIGlzIHRoZSBzdGFnaW5nIG9u
ZSwgd2hpY2ggaW1vCj4gaXMgYSBET0EgcHJvamVjdCwgbm90IHN1cmUgaXQncyB3b3J0aCB0byBi
b3RoZXIgd2l0aCB0aGlzIGhlcmUuCgphZmFpaywgdGhpcyBkZXZpY2UgaXMgdXNlZCBpbiBwcm9k
dWN0aW9uIGJ5IGZldyBtYW51ZmFjdHVyZXJzIGFuZCBpdCBpcwp1c2VmdWxsIGZvciB0aGVtIHRv
IGhhdmUgaXQgaW4gdGhlIHRyZWUgYW5kIHRoZSBvbmx5IHJlYXNvbiBpdCBpcyBzdGlsbAppbiBz
dGFnaW5nIGlzIGJlY2F1c2UgVG9taSBhbm5vdW5jZWQgaGUgd2lsbCBub3QgdGFrZSBhbnkgbmV3
IGRyaXZlcnMgaW4KZmJkZXYuIEFuZCwgc28gSSBoYXZlIG5vdCB0YWtlbiB0aGUgaW5pdGlhdGl2
ZSB0byBwcm9wZXJseSBtb3ZlIGl0IG91dApvZiBzdGFnaW5nLiBJIHRoaW5rIEJhcnRsb21pZWog
d2lsbCBhbHNvIG5vdCBhY2NlcHQgbmV3IGRyaXZlcnMgaW4gZmJkZXYuCgoKLS0KUmVnYXJkcwpT
dWRpcCAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJp
LWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
