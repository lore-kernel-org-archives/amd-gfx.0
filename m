From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 1/1] drm: Prefer pcie_capability_read_word()
Date: Thu, 21 Nov 2019 07:55:05 -0600
Message-ID: <20191121135505.GA37567@google.com>
References: <CADnq5_PJ+1bPQneqQpyoTGas3Je28SkmQdkMLnBADybMMuJxnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <CADnq5_PJ+1bPQneqQpyoTGas3Je28SkmQdkMLnBADybMMuJxnQ@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Frederick Lawler <fred@fredlawl.com>, Dave Airlie <airlied@linux.ie>, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gTW9uLCBOb3YgMTgsIDIwMTkgYXQgMTI6NDI6MjVQTSAtMDUwMCwgQWxleCBEZXVjaGVyIHdy
b3RlOgo+IE9uIE1vbiwgTm92IDE4LCAyMDE5IGF0IDM6MzcgQU0gRnJlZGVyaWNrIExhd2xlciA8
ZnJlZEBmcmVkbGF3bC5jb20+IHdyb3RlOgo+ID4KPiA+IENvbW1pdCA4YzBkM2EwMmMxMzAgKCJQ
Q0k6IEFkZCBhY2Nlc3NvcnMgZm9yIFBDSSBFeHByZXNzIENhcGFiaWxpdHkiKQo+ID4gYWRkZWQg
YWNjZXNzb3JzIGZvciB0aGUgUENJIEV4cHJlc3MgQ2FwYWJpbGl0eSBzbyB0aGF0IGRyaXZlcnMg
ZGlkbid0Cj4gPiBuZWVkIHRvIGJlIGF3YXJlIG9mIGRpZmZlcmVuY2VzIGJldHdlZW4gdjEgYW5k
IHYyIG9mIHRoZSBQQ0kKPiA+IEV4cHJlc3MgQ2FwYWJpbGl0eS4KPiA+Cj4gPiBSZXBsYWNlIHBj
aV9yZWFkX2NvbmZpZ193b3JkKCkgYW5kIHBjaV93cml0ZV9jb25maWdfd29yZCgpIGNhbGxzIHdp
dGgKPiA+IHBjaWVfY2FwYWJpbGl0eV9yZWFkX3dvcmQoKSBhbmQgcGNpZV9jYXBhYmlsaXR5X3dy
aXRlX3dvcmQoKS4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBGcmVkZXJpY2sgTGF3bGVyIDxmcmVk
QGZyZWRsYXdsLmNvbT4KPiA+Cj4gPiAtLS0KPiA+IFYyCj4gPiAtIFNxdWFzaCBib3RoIGRybSBj
b21taXRzIGludG8gb25lCj4gPiAtIFJlYmFzZSBvbnRvcCBvZiBkNDZlYWMxZTY1OGIKPiA+IC0t
LQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Npay5jIHwgNjMgKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2kuYyAgfCA3
MSArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tCj4gPiAgZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9jaWsuYyAgICAgfCA3MCArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0KPiA+ICBk
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpLmMgICAgICB8IDczICsrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tCj4gCj4gQ2FuIHlvdSBzcGxpdCB0aGlzIGludG8gdHdvIHBhdGNoZXM/ICBP
bmUgZm9yIGFtZGdwdSBhbmQgb25lIGZvciByYWRlb24/CgpJIHNwbGl0IHRoaXMsIGFuZCBJIGFs
c28gd2VudCBiYWNrIGFuZCBzcGxpdCB0aGUgcmVsYXRlZCBwYXRjaGVzIHRoYXQKcHJlY2VkZWQg
dGhpcyBvbmUuICBJJ2xsIHBvc3QgdGhlIHJlc3VsdGluZyBzZXJpZXMgZm9yIHJlZmVyZW5jZS4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
