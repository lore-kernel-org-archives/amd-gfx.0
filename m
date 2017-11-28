From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 02/13] fbdev: add remove_conflicting_pci_framebuffers()
Date: Tue, 28 Nov 2017 11:22:17 +0100
Message-ID: <20171128102217.b7ynyqarwzkdvmdq@phenom.ffwll.local>
References: <cover.1511544782.git.mirq-linux@rere.qmqm.pl>
 <1738dbed0239bffc886f126fd3091daa39cd14c9.1511544782.git.mirq-linux@rere.qmqm.pl>
 <20171127102758.y7c6yzyey6wfntxh@phenom.ffwll.local>
 <20171127205219.GA3537@sudip-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20171127205219.GA3537@sudip-laptop>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, virtualization@lists.linux-foundation.org, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Gerd Hoffmann <kraxel@redhat.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gTW9uLCBOb3YgMjcsIDIwMTcgYXQgMDg6NTI6MTlQTSArMDAwMCwgU3VkaXAgTXVraGVyamVl
IHdyb3RlOgo+IE9uIE1vbiwgTm92IDI3LCAyMDE3IGF0IDExOjI3OjU5QU0gKzAxMDAsIERhbmll
bCBWZXR0ZXIgd3JvdGU6Cj4gPiBPbiBGcmksIE5vdiAyNCwgMjAxNyBhdCAwNjo1MzozMVBNICsw
MTAwLCBNaWNoYcWCIE1pcm9zxYJhdyB3cm90ZToKPiA+ID4gQWxtb3N0IGFsbCBkcml2ZXJzIHVz
aW5nIHJlbW92ZV9jb25mbGljdGluZ19mcmFtZWJ1ZmZlcnMoKSB3cmFwIGl0IHdpdGgKPiA+ID4g
dGhlIHNhbWUgY29kZS4gRXh0cmFjdCBjb21tb24gcGFydCBmcm9tIFBDSSBkcml2ZXJzIGludG8g
c2VwYXJhdGUKPiA+ID4gcmVtb3ZlX2NvbmZsaWN0aW5nX3BjaV9mcmFtZWJ1ZmZlcnMoKS4KPiA+
ID4gCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE1pY2hhxYIgTWlyb3PFgmF3IDxtaXJxLWxpbnV4QHJl
cmUucW1xbS5wbD4KPiA+IAo+ID4gU2luY2UgdGhlIG9ubHkgZHJpdmVyIHRoYXQgc2VlbXMgdG8g
dXNlIHRoaXMgaXMgdGhlIHN0YWdpbmcgb25lLCB3aGljaCBpbW8KPiA+IGlzIGEgRE9BIHByb2pl
Y3QsIG5vdCBzdXJlIGl0J3Mgd29ydGggdG8gYm90aGVyIHdpdGggdGhpcyBoZXJlLgo+IAo+IGFm
YWlrLCB0aGlzIGRldmljZSBpcyB1c2VkIGluIHByb2R1Y3Rpb24gYnkgZmV3IG1hbnVmYWN0dXJl
cnMgYW5kIGl0IGlzCj4gdXNlZnVsbCBmb3IgdGhlbSB0byBoYXZlIGl0IGluIHRoZSB0cmVlIGFu
ZCB0aGUgb25seSByZWFzb24gaXQgaXMgc3RpbGwKPiBpbiBzdGFnaW5nIGlzIGJlY2F1c2UgVG9t
aSBhbm5vdW5jZWQgaGUgd2lsbCBub3QgdGFrZSBhbnkgbmV3IGRyaXZlcnMgaW4KPiBmYmRldi4g
QW5kLCBzbyBJIGhhdmUgbm90IHRha2VuIHRoZSBpbml0aWF0aXZlIHRvIHByb3Blcmx5IG1vdmUg
aXQgb3V0Cj4gb2Ygc3RhZ2luZy4gSSB0aGluayBCYXJ0bG9taWVqIHdpbGwgYWxzbyBub3QgYWNj
ZXB0IG5ldyBkcml2ZXJzIGluIGZiZGV2LgoKSW1vLCBpZiBubyBvbmUgY2FyZXMgYWJvdXQgcG9y
dGluZyBpdCB0byBrbXMgKHdoaWNoIHdpbGwgZ2l2ZSB5b3UgYW4gZmJkZXYKZHJpdmVyIGZvciBm
cmVlKSwgdGhlbiB3ZSBzaG91bGQgdGhyb3cgaXQgb3V0LiBBdCBsZWFzdCBJIHRob3VnaHQgc3Rh
Z2luZwp3YXMgb25seSBmb3Igc3R1ZmYgdGhhdCBoYWQgYSByZWFzb25hYmxlIGNoYW5jZSB0byBn
ZXQgbWFpbmxpbmVkLiBOb3QgYXMgYQpkdW1waW5nIGdyb3VuZCBmb3IgZHJpdmVycyB0aGF0IHBl
b3BsZSB1c2UsIGJ1dCBkb24ndCBib3RoZXIgdG8gZ2V0IHJlYWR5CmZvciBtYWlubGluZS4KCkdy
ZWc/Ci1EYW5pZWwKLS0gCkRhbmllbCBWZXR0ZXIKU29mdHdhcmUgRW5naW5lZXIsIEludGVsIENv
cnBvcmF0aW9uCmh0dHA6Ly9ibG9nLmZmd2xsLmNoCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2RyaS1kZXZlbAo=
