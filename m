From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH 02/13] fbdev: add remove_conflicting_pci_framebuffers()
Date: Mon, 11 Dec 2017 21:57:00 +0000
Message-ID: <20171211215700.GA4899@sudip-laptop>
References: <cover.1511544782.git.mirq-linux@rere.qmqm.pl>
 <1738dbed0239bffc886f126fd3091daa39cd14c9.1511544782.git.mirq-linux@rere.qmqm.pl>
 <20171127102758.y7c6yzyey6wfntxh@phenom.ffwll.local>
 <20171127205219.GA3537@sudip-laptop>
 <20171128102217.b7ynyqarwzkdvmdq@phenom.ffwll.local>
 <20171128113238.GA29456@kroah.com>
 <20171128123008.GA12986@sudip-tp>
 <20171129095634.ymeld4l7zaehbuvn@phenom.ffwll.local>
 <20171130234953.GA5542@sudip-laptop>
 <CACvgo52NmpWv4DdwMuu3b9fZx++Wd2zvCvtvN75LxPqmycpCtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <CACvgo52NmpWv4DdwMuu3b9fZx++Wd2zvCvtvN75LxPqmycpCtQ@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, David Airlie <airlied@linux.ie>, Greg KH <gregkh@linuxfoundation.org>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, ML dri-devel <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Gerd Hoffmann <kraxel@redhat.com>
List-Id: amd-gfx.lists.freedesktop.org

SGkgRW1pbCwKCk9uIEZyaSwgRGVjIDAxLCAyMDE3IGF0IDAyOjQwOjExUE0gKzAwMDAsIEVtaWwg
VmVsaWtvdiB3cm90ZToKPiBPbiAzMCBOb3ZlbWJlciAyMDE3IGF0IDIzOjQ5LCBTdWRpcCBNdWto
ZXJqZWUKPiA8c3VkaXBtLm11a2hlcmplZUBnbWFpbC5jb20+IHdyb3RlOgo+ID4gSGkgRGFuaWVs
LAo+ID4KPiA+IE9uIFdlZCwgTm92IDI5LCAyMDE3IGF0IDEwOjU2OjM0QU0gKzAxMDAsIERhbmll
bCBWZXR0ZXIgd3JvdGU6CjxzbmlwPgo+ID4gc3VibWl0IGl0IHRvIGRyaS1kZXZlbC4KPiA+Cj4g
QSBjcmF6eSBpZGVhLCBtb3N0bHkgdG93YXJkcyBUZWRkIGFuZCBTdWRpcDoKPiAKPiBTdGFydCBz
bWFsbCBhbmQgYnVpbGQgZ3JhZHVhbGx5LiBBbiBleGFtcGxlIHNwbGl0IGZvciBzZXBhcmF0ZSBw
YXRjaCBzZXJpZXM6Cj4gCj4gIC0gb25lIEhXLCBiYXNpYyBzZXR1cCArIGF0b21pYyBLTVMKPiAg
LSBhZGQgc2Vjb25kIEhXCj4gIC0gbW9yZSBLTVMgZmVhdHVyZXMKPiAgLSBmYW5jeSBtZW1vcnkg
bWFuYWdlbWVudAo+ICAtIDJELzNEL290aGVyIGFjY2VsZXJhdGlvbgo+IAo+IFRoZSBkcml2ZXIg
YXMgc2VlbiBhYm92ZSB0cmllcyB0byBkbyBhbGwgb2YgdGhlIGFib3ZlIChhbG1vc3QsIGl0J3Mg
bm90IGF0b21pYykKPiBhdCBvbmNlIC0gNDBrIGxvYy4KPiAKPiBTb21lb25lIGZhbWlsaWFyIHdp
dGggdGhlIGNvZGUgY2FuIHF1aWNrbHkgc3BsaXQgaXQgdXAgYW5kIHdoaWxlIGRvaW5nCj4gc28s
IGZlZWQgaXQgdGhyb3VnaCBjaGVja3BhdGNoLgoKSSBjYW4gdHJ5IGJ1dCB3aWxsIGJlIHZlcnkg
dG91Z2ggc2luY2UgSSBoYXZlIHRvIGdvIHRocm91Z2ggdGhlIGNvZGUgdG8KZ2V0IGZhbWlsaWFy
IHdpdGggaXQgYW5kLCBhcyBtZW50aW9uZWQgYmVmb3JlLCBpdHMgbm90IHBhcnQgb2YgbXkgZGF5
am9iLApzbyB0aW1lIHdpbGwgYmUgYSBwcm9ibGVtLiBEZXZlbG9waW5nIGZyb20gc2NyYXRjaCB0
YWtlcyBtdWNoIG1vcmUgdGltZQp0aGFuIGZpeGluZyBzb21ldGhpbmcuCgo+IEN1cnJlbnQgY29k
ZSBpcyBfdmVyeV8gZmFyIGZyb20ga2VybmVsIGNvZGluZyBzdHlsZSwgcGx1cyB0aGUKPiBjb3B5
cmlnaHQgYmx1cnAgaXMgdmVyeSBkaXN0dXJiaW5nOgoKSSB3aWxsIGZpeCB0aGUgY29kaW5nIHN0
eWxlIGJlZm9yZSBteSBmaXJzdCBzdWJtaXNzaW9uIHRvIGRyaS1kZXZlbCwKd2hpY2ggc2hvdWxk
IGJlIGluIEphbnVhcnkgYWZ0ZXIgSSBoYXZlIHNldHVwIG15IGRlc2t0b3Agd2l0aCB0aGUKaGFy
ZHdhcmUgZm9yIHRlc3RpbmcuCgpUaGUgY29weXJpZ2h0IHRoaW5nIC0gSSBhbSBzdXJlIFRlZGR5
IGNhbiB0YWxrIHRvIGhpcyBjb21wYW55IGFuZCB3aWxsCmNvbmZpcm0gdGhhdCB3ZSBjYW4gY2hh
bmdlIGl0IHRvIHRoZSB3YXkga2VybmVsIGNvZGUgaXMgZG9uZS4KCi0tClJlZ2FyZHMKU3VkaXAK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
