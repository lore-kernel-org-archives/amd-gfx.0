From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Possible use_mm() mis-uses
Date: Wed, 22 Aug 2018 20:20:46 +0200
Message-ID: <e50816ec-cf5e-4848-93d0-dacc28f816fc@redhat.com>
References: <CA+55aFz+Unj0zVNd79vpd41mtee3DV6tp_Ozr7WaZscqCQc9hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <CA+55aFz+Unj0zVNd79vpd41mtee3DV6tp_Ozr7WaZscqCQc9hQ@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang <zhi.a.wang@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: KVM list <kvm@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, USB list <linux-usb@vger.kernel.org>, amd-gfx@lists.freedesktop.org, DRI <dri-devel@lists.freedesktop.org>, intel-gvt-dev@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

T24gMjIvMDgvMjAxOCAxODo0NCwgTGludXMgVG9ydmFsZHMgd3JvdGU6Cj4gQW4gZXhhbXBsZSBv
ZiBzb21ldGhpbmcgdGhhdCAqaXNuJ3QqIHJpZ2h0LCBpcyB0aGUgaTkxNSBrdm0gaW50ZXJmYWNl
LAo+IHdoaWNoIGRvZXMKPiAKPiAgICAgICAgIHVzZV9tbShrdm0tPm1tKTsKPiAKPiBvbiBhbiBt
bSB0aGF0IHdhcyBpbml0aWFsaXplZCBpbiB2aXJ0L2t2bS9rdm1fbWFpbi5jIHVzaW5nCj4gCj4g
ICAgICAgICBtbWdyYWIoY3VycmVudC0+bW0pOwo+ICAgICAgICAga3ZtLT5tbSA9IGN1cnJlbnQt
Pm1tOwo+IAo+IHdoaWNoIGlzICpub3QqIHJpZ2h0LiBVc2luZyAibW1ncmFiKCkiIGRvZXMgaW5k
ZWVkIGd1YXJhbnRlZSB0aGUKPiBsaWZldGltZSBvZiB0aGUgJ3N0cnVjdCBtbV9zdHJ1Y3QnIGl0
c2VsZiwgYnV0IGl0IGRvZXMgKm5vdCogZ3VhcmFudGVlCj4gdGhlIGxpZmV0aW1lIG9mIHRoZSBw
YWdlIHRhYmxlcy4gWW91IG5lZWQgdG8gdXNlICJtbWdldCgpIiBhbmQKPiAibW1wdXQoKSIsIHdo
aWNoIGdldCB0aGUgcmVmZXJlbmNlIHRvIHRoZSBhY3R1YWwgcHJvY2VzcyBhZGRyZXNzCj4gc3Bh
Y2UhCj4gCj4gTm93LCBpdCBpcyAqcG9zc2libGUqIHRoYXQgdGhlIGt2bSB1c2UgaXMgY29ycmVj
dCB0b28sIGJlY2F1c2Uga3ZtCj4gZG9lcyByZWdpc3RlciBhIG1tdV9ub3RpZmllciBjaGFpbiwg
YW5kIGluIHRoZW9yeSB5b3UgY2FuIGF2b2lkIHRoZQo+IHByb3BlciByZWZjb3VudGluZyBieSBq
dXN0IG1ha2luZyBzdXJlIHRoZSBtbXUgInJlbGVhc2UiIG5vdGlmaWVyCj4ga2lsbHMgYW55IGV4
aXN0aW5nIHVzZXMsIGJ1dCBJIGRvbid0IHJlYWxseSBzZWUga3ZtIGRvaW5nIHRoYXQuIEt2bQo+
IGRvZXMgcmVnaXN0ZXIgYSByZWxlYXNlIG5vdGlmaWVyLCBidXQgdGhhdCBqdXN0IGZsdXNoZXMg
dGhlIHNoYWRvdwo+IHBhZ2UgdGFibGVzLCBpdCBkb2Vzbid0IGtpbGwgYW55IHVzZV9tbSgpIHVz
ZSBieSBzb21lIGk5MTUgdXNlIGNhc2UuCgpZZXMsIEtWTSBpcyBjb3JyZWN0IGJ1dCB0aGUgaTkx
NSBiaXRzIGFyZSBhdCBsZWFzdCBmaXNoeS4gIEl0J3MgcHJvYmFibHkKYXMgc2ltcGxlIGFzIGFk
ZGluZyBhIG1tZ2V0L21tcHV0IHBhaXIgcmVzcGVjdGl2ZWx5IGluIGt2bWd0X2d1ZXN0X2luaXQK
YW5kIGt2bWd0X2d1ZXN0X2V4aXQsIG9yIG1heWJlIG1tZ2V0X25vdF96ZXJvLgoKUGFvbG8KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4IG1h
aWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
