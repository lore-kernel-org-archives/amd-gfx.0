From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Possible use_mm() mis-uses
Date: Wed, 22 Aug 2018 11:57:00 -0700
Message-ID: <CA+55aFwbdtiPNNwL47TB0b7oS5qfRo7CMYKBA9FQ150AUWE0ew@mail.gmail.com>
References: <CA+55aFz+Unj0zVNd79vpd41mtee3DV6tp_Ozr7WaZscqCQc9hQ@mail.gmail.com>
 <e50816ec-cf5e-4848-93d0-dacc28f816fc@redhat.com>
 <CA+55aFyava7Q=1ZPqjHhAs88UZsmk+DD2ot5r9_CvH+TTMswWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CA+55aFyava7Q=1ZPqjHhAs88UZsmk+DD2ot5r9_CvH+TTMswWQ@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: DRI <dri-devel@lists.freedesktop.org>, KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Dave Airlie <airlied@linux.ie>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, USB list <linux-usb@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Zhi Wang <zhi.a.wang@intel.com>, Felipe Balbi <balbi@kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gV2VkLCBBdWcgMjIsIDIwMTggYXQgMTE6MzMgQU0gTGludXMgVG9ydmFsZHMKPHRvcnZhbGRz
QGxpbnV4LWZvdW5kYXRpb24ub3JnPiB3cm90ZToKPgo+IE9uIFdlZCwgQXVnIDIyLCAyMDE4IGF0
IDExOjIxIEFNIFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4K
PiA+IFllcywgS1ZNIGlzIGNvcnJlY3QgYnV0IHRoZSBpOTE1IGJpdHMgYXJlIGF0IGxlYXN0IGZp
c2h5LiAgSXQncyBwcm9iYWJseQo+ID4gYXMgc2ltcGxlIGFzIGFkZGluZyBhIG1tZ2V0L21tcHV0
IHBhaXIgcmVzcGVjdGl2ZWx5IGluIGt2bWd0X2d1ZXN0X2luaXQKPiA+IGFuZCBrdm1ndF9ndWVz
dF9leGl0LCBvciBtYXliZSBtbWdldF9ub3RfemVyby4KPgo+IERlZmluaXRlbHkgbW1nZXRfbm90
X3plcm8oKS4gSWYgaXQgd2FzIGp1c3QgbW1ncmFiKCknZWQgZWFybGllciwgdGhlCj4gYWN0dWFs
IHBhZ2UgdGFibGVzIG1pZ2h0IGFscmVhZHkgYmUgZ29uZS4KClNpZGUgbm90ZTogd2UgX2NvdWxk
XyBkbyB0aGUgbW1nZXRfbm90X3plcm8oKSBpbnNpZGUgdXNlX21tKCkgaXRzZWxmLAppZiB3ZSBq
dXN0IGtuZXcgdGhhdCB0aGUgbW0gd2FzIGF0IGxlYXN0IG1tZ3JhYigpJ2VkIGNvcnJlY3RseS4K
CkJ1dCBmb3Igc29tZSBvZiB0aGUgdXNlcywgZXZlbiB0aGF0IGlzbid0IGNsZWFyLiBJdCdzIG5v
dCBlbnRpcmVseQpvYnZpb3VzIHRoYXQgdGhlICJzdHJ1Y3QgbW1fc3RydWN0IiBleGlzdHMgX2F0
X2FsbF8gYXQgdGhhdCBwb2ludCwgYW5kCnRoYXQgYSBtbWdldF9ub3RfemVybygpIHdvdWxkbid0
IGp1c3QgaGF2ZSBzb21lIHVzZS1hZnRlci1mcmVlIGFjY2Vzcy4KCkFnYWluLCBpbmRlcGVuZGVu
dCBsaWZldGltZSBydWxlcyBjb3VsZCBzaG93IHRoYXQgdGhpcyBpc24ndCB0aGUgY2FzZQooaWUg
ImV4aXRfYWlvKCkgaXMgYWx3YXlzIGNhbGxlZCBiZWZvcmUgZXhpdF9tbWFwKCksIGFuZCBraWxs
X2lvY3R4KCkKdGFrZXMgY2FyZSBvZiBpdCBhbGwiKSwgYnV0IGl0IHdvdWxkIGJlIGdvb2QgdG8g
aGF2ZSB0aGUgdXNlcnMgb2YKInVzZV9tbSgpIiBhY3R1YWxseSB2ZXJpZnkgdGhlaXIgbGlmZXRp
bWUgcnVsZXMgYXJlIGNvcnJlY3QgYW5kCmVuZm9yY2VkLgoKQmVjYXVzZSBxdWl0ZSBvZnRlbiwg
dGhlIGxpZmV0aW1lIHJ1bGUgbWlnaHQgbmJvdCBiZSBhIG1tdSBub3RpZmllciBvcgphaW9fZXhp
dCBhdCBhbGwsIGJ1dCBqdXN0IGJlICJvaCwgdGhlIHVzZXIgd29uJ3QgZXhpdCB1bnRpbCB0aGlz
IGlzCmFsbCBkb25lIi4gQnV0IGRvIHlvdSAqY29udHJvbCogdGhlIHVzZXI/IFdoYXQgaWYgdGhl
IHVzZXIgaXMgYnVnZ3k/CgogICAgICAgICAgICAgTGludXMKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
