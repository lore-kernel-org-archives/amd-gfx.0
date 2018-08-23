From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Possible use_mm() mis-uses
Date: Thu, 23 Aug 2018 11:03:19 -0700
Message-ID: <CA+55aFw7cbyB3CKGbzvdgavy7f3-SXsRKAJZJGcvSP4Wuu+ymQ@mail.gmail.com>
References: <CA+55aFz+Unj0zVNd79vpd41mtee3DV6tp_Ozr7WaZscqCQc9hQ@mail.gmail.com>
 <e50816ec-cf5e-4848-93d0-dacc28f816fc@redhat.com>
 <20180823060726.GY3674@zhen-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20180823060726.GY3674@zhen-hp.sh.intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Oded Gabbay <oded.gabbay@gmail.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, DRI <dri-devel@lists.freedesktop.org>, KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Dave Airlie <airlied@linux.ie>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, USB list <linux-usb@vger.kernel.org>, amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, intel-gvt-dev@lists.freedesktop.org, intel-gfx <intel-gfx@lists.freedesktop.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Felipe Balbi <balbi@kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gV2VkLCBBdWcgMjIsIDIwMTggYXQgMTE6MTYgUE0gWmhlbnl1IFdhbmcgPHpoZW55dXdAbGlu
dXguaW50ZWwuY29tPiB3cm90ZToKPgo+IHllYWgsIHRoYXQncyB0aGUgY2xlYXIgd2F5IHRvIGZp
eCB0aGlzIGltby4gV2Ugb25seSBkZXBlbmQgb24gZ3Vlc3QKPiBsaWZlIGN5Y2xlIHRvIGFjY2Vz
cyBndWVzdCBtZW1vcnkgcHJvcGVybHkuIEhlcmUncyBwcm9wb3NlZCBmaXgsIHdpbGwKPiB2ZXJp
ZnkgYW5kIGludGVncmF0ZSBpdCBsYXRlci4KClRoYW5rcywgdGhpcyBsb29rcyBzYW5lIHRvIG1l
LAoKICAgICAgICAgICAgICAgIExpbnVzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkludGVsLWdmeCBtYWlsaW5nIGxpc3QKSW50ZWwtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2ludGVsLWdmeAo=
