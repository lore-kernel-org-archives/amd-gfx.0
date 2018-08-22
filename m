From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Possible use_mm() mis-uses
Date: Wed, 22 Aug 2018 11:33:43 -0700
Message-ID: <CA+55aFyava7Q=1ZPqjHhAs88UZsmk+DD2ot5r9_CvH+TTMswWQ@mail.gmail.com>
References: <CA+55aFz+Unj0zVNd79vpd41mtee3DV6tp_Ozr7WaZscqCQc9hQ@mail.gmail.com>
 <e50816ec-cf5e-4848-93d0-dacc28f816fc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <e50816ec-cf5e-4848-93d0-dacc28f816fc@redhat.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Oded Gabbay <oded.gabbay@gmail.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, DRI <dri-devel@lists.freedesktop.org>, KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Dave Airlie <airlied@linux.ie>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, USB list <linux-usb@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Felipe Balbi <balbi@kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gV2VkLCBBdWcgMjIsIDIwMTggYXQgMTE6MjEgQU0gUGFvbG8gQm9uemluaSA8cGJvbnppbmlA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBZZXMsIEtWTSBpcyBjb3JyZWN0IGJ1dCB0aGUgaTkxNSBi
aXRzIGFyZSBhdCBsZWFzdCBmaXNoeS4gIEl0J3MgcHJvYmFibHkKPiBhcyBzaW1wbGUgYXMgYWRk
aW5nIGEgbW1nZXQvbW1wdXQgcGFpciByZXNwZWN0aXZlbHkgaW4ga3ZtZ3RfZ3Vlc3RfaW5pdAo+
IGFuZCBrdm1ndF9ndWVzdF9leGl0LCBvciBtYXliZSBtbWdldF9ub3RfemVyby4KCkRlZmluaXRl
bHkgbW1nZXRfbm90X3plcm8oKS4gSWYgaXQgd2FzIGp1c3QgbW1ncmFiKCknZWQgZWFybGllciwg
dGhlCmFjdHVhbCBwYWdlIHRhYmxlcyBtaWdodCBhbHJlYWR5IGJlIGdvbmUuCgogICAgICAgICAg
ICAgIExpbnVzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkludGVsLWdmeCBtYWlsaW5nIGxpc3QKSW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLWdmeAo=
