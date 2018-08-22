From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Possible use_mm() mis-uses
Date: Wed, 22 Aug 2018 13:07:34 -0700
Message-ID: <CA+55aFxWqg-t19i70mk-Y_dLVkjAjxV6jHnBZCTv0kg=MR8L7A@mail.gmail.com>
References: <CA+55aFz+Unj0zVNd79vpd41mtee3DV6tp_Ozr7WaZscqCQc9hQ@mail.gmail.com>
 <744b92cb-133b-4c05-1416-06deb69e1e2c@amd.com>
 <e2f11cb5-33b0-b157-9703-95fe71a63c79@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <e2f11cb5-33b0-b157-9703-95fe71a63c79@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: Oded Gabbay <oded.gabbay@gmail.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, DRI <dri-devel@lists.freedesktop.org>, KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Dave Airlie <airlied@linux.ie>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, USB list <linux-usb@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Felipe Balbi <balbi@kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gV2VkLCBBdWcgMjIsIDIwMTggYXQgMTI6NDQgUE0gRmVsaXggS3VlaGxpbmcgPGZlbGl4Lmt1
ZWhsaW5nQGFtZC5jb20+IHdyb3RlOgo+Cj4gWW91J3JlIHJpZ2h0LCBidXQgdGhhdCdzIGEgYml0
IGZyYWdpbGUgYW5kIGNvbnZvbHV0ZWQuIEknbGwgZml4IEtGRCB0bwo+IGhhbmRsZSB0aGlzIG1v
cmUgcm9idXN0bHkuIFNlZSB0aGUgYXR0YWNoZWQgKHVudGVzdGVkKSBwYXRjaC4KClllcywgdGhp
cyBwYXRjaCB0aGF0IG1ha2VzIHRoZSB3aG9sZSAiaGFzIHRvIHVzZSBjdXJyZW50IG1tIiBvciB1
c2VzCiJnZXRfdGFza19tbSgpIiBsb29rcyBnb29kIGZyb20gYSBWTTwgd29ycnkgc3RhbmRwb2lu
dC4KClRoYW5rcy4KCj4gQW5kCj4gb2J2aW91c2x5IHRoYXQgb3BhcXVlIHBvaW50ZXIgZGlkbid0
IHdvcmsgYXMgaW50ZW5kZWQuIEl0IGp1c3QgZ2V0cwo+IHByb21vdGVkIHRvIGFuIG1tX3N0cnVj
dCAqIHdpdGhvdXQgYSB3YXJuaW5nIGZyb20gdGhlIGNvbXBpbGVyLiBNYXliZSBJCj4gc2hvdWxk
IGNoYW5nZSB0aGF0IHRvIGEgbG9uZyB0byBtYWtlIGFidXNlIGVhc2llciB0byBzcG90LgoKVXNp
bmcgYSAidm9pZCAqIiBpcyBhY3R1YWxseSBqdXN0IGFib3V0IHRoZSB3b3JzdCBwb3NzaWJsZSB0
eXBlIGZvcgpzb21ldGhpbmcgdGhhdCBzaG91bGQgYmUgYSBjb29raWUsIGJlY2F1c2UgaXQgc2ls
ZW50bHkgdHJhbnNsYXRlcyB0bwphbnkgcG9pbnRlci4KCiJsb25nIiBpcyBhY3R1YWxseSBub3Qg
bXVjaCBiZXR0ZXIsIGJlY3Vhc2UgaXQgd2lsbCBzaWxlbnRseSBjb252ZXJ0CnRvIGFueSBpbnRl
Z2VyIHR5cGUuCgpBIGdvb2QgZmFpcmx5IHR5cGUtc2FmZSBjb29raWUgdHlwZSBpcyBhY3R1YWxs
eSB0aGlzOgoKICAgIHR5cGVkZWYgdm9sYXRpbGUgY29uc3Qgc3RydWN0IG5vX3N1Y2hfc3RydWN0
ICpjb29raWVfcHRyX3Q7CgphbmQgbm93IHNvbWV0aGluZyBvZiB0eXBlICJjb29raWVfcHRyX3Qi
IGlzIGFjdHVhbGx5IHZlcnkgIGhhcmQgdG8KY29udmVydCB0byBvdGhlciB0eXBlcyBieSBtaXN0
YWtlLgoKTm90ZSB0aGF0IHRoZSAidm9sYXRpbGUgY29uc3QiIGlzIG5vdCBqdXN0IHJhbmRvbSBu
b2lzZSAtIGl0J3Mgc28gdGhhdAppdCB3b24ndCBldmVuIGNvbnZlcnQgd2l0aG91dCB3YXJuaW5n
cyB0byB0aGluZ3MgdGhhdCB0YWtlIGEgImNvbnN0CnZvaWQgKiIgYXMgYW4gYXJndW1lbnQgKGxp
a2UsIHNheSwgdGhlIHNvdXJjZSBvZiAnbWVtY3B5KCknKS4KClNvIHlvdSBhbG1vc3QgX2hhdmVf
IHRvIGV4cGxpY2l0bHkgY2FzdCBpdCB0byB1c2UgaXQuCgogICAgICAgICAgIExpbnVzCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkludGVsLWdmeCBtYWls
aW5nIGxpc3QKSW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLWdmeAo=
