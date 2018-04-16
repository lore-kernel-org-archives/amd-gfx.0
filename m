From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 4/8] dma-buf: add peer2peer flag
Date: Mon, 16 Apr 2018 05:39:37 -0700
Message-ID: <20180416123937.GA9073@infradead.org>
References: <20180325110000.2238-1-christian.koenig@amd.com>
 <20180325110000.2238-4-christian.koenig@amd.com>
 <20180329065753.GD3881@phenom.ffwll.local>
 <8b823458-8bdc-3217-572b-509a28aae742@gmail.com>
 <20180403090909.GN3881@phenom.ffwll.local>
 <20180403170645.GB5935@redhat.com>
 <20180403180832.GZ3881@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20180403180832.GZ3881@phenom.ffwll.local>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jerome Glisse <jglisse@redhat.com>, christian.koenig@amd.com, linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

T24gVHVlLCBBcHIgMDMsIDIwMTggYXQgMDg6MDg6MzJQTSArMDIwMCwgRGFuaWVsIFZldHRlciB3
cm90ZToKPiBJIGRpZCBub3QgbWVhbiB5b3Ugc2hvdWxkIGRtYV9tYXBfc2cvcGFnZS4gSSBqdXN0
IG1lYW50IHRoYXQgdXNpbmcKPiBkbWFfbWFwX3Jlc291cmNlIHRvIGZpbGwgb25seSB0aGUgZG1h
IGFkZHJlc3MgcGFydCBvZiB0aGUgc2cgdGFibGUgc2VlbXMKPiBwZXJmZWN0bHkgc3VmZmljaWVu
dC4KCkJ1dCB0aGF0IGlzIG5vdCBob3cgdGhlIGludGVyZmFjZSB3b3JrLCBlc3BlY2lhbGx5IGZh
Y2luZyBzZ19kbWFfbGVuLgoKPiBBc3N1bWluZyB5b3UgZ2V0IGFuIHNnIHRhYmxlIHRoYXQncyBi
ZWVuIG1hcHBpbmcgYnkgY2FsbGluZyBkbWFfbWFwX3NnIHdhcwo+IGFsd2F5cyBhIGJpdCBhIGNh
c2Ugb2YgYmVuZGluZyB0aGUgYWJzdHJhY3Rpb24gdG8gYXZvaWQgdHlwaW5nIGNvZGUuIFRoZQo+
IG9ubHkgdGhpbmcgYW4gaW1wb3J0ZXIgZXZlciBzaG91bGQgaGF2ZSBkb25lIGlzIGxvb2sgYXQg
dGhlIGRtYSBhZGRyZXNzZXMKPiBpbiB0aGF0IHNnIHRhYmxlLCBub3RoaW5nIGVsc2UuCgpUaGUg
c2NhdHRlcmxpc3QgaXMgbm90IGEgdmVyeSBnb29kIGFic3RyYWN0aW9uIHVuZm9ydHVuYXRlbHks
IGJ1dCBpdAppdCBpcyBzcHJlYWQgYWxsIG92ZXIgdGhlIGtlcm5lbC4gIEFuZCB3ZSBkbyBleHBl
Y3QgdGhhdCBhbnlvbmUgd2hvCmdldHMgcGFzc2VkIGEgc2NhdHRlcmxpc3QgY2FuIHVzZSBzZ19w
YWdlKCkgb3Igc2dfdmlydCgpICh3aGljaCBjYWxscwpzZ19wYWdlKCkpIG9uIGl0LiAgWW91ciBj
aGFuZ2VzIHdvdWxkIGJyZWFrIHRoYXQsIGFuZCB3aWxsIGNhdXNlIG1ham9yCnRyb3VibGUgYmVj
YXVzZSBvZiB0aGF0LgoKSWYgeW91IHdhbnQgdG8gZXhwb3NlIHAycCBtZW1vcnkgcmV0dXJuZWQg
ZnJvbSBkbWFfbWFwX3Jlc291cmNlIGluCmRtYWJ1ZiBkbyBub3QgdXNlIHNjYXR0ZXJsaXN0cyBm
b3IgdGhpcyBwbGVhc2UsIGJ1dCB3aXRoIGEgbmV3IGludGVyZmFjZQp0aGF0IGV4cGxpY2l0bHkg
cGFzc2VzIGEgdmlydHVhbCBhZGRyZXNzLCBhIGRtYSBhZGRyZXNzIGFuZCBhIGxlbmd0aAphbmQg
bWFrZSBpdCB2ZXJ5IGNsZWFyIHRoYXQgdmlydF90b19wYWdlIHdpbGwgbm90IHdvcmsgb24gdGhl
IHZpcnR1YWwKYWRkcmVzcy4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJp
LWRldmVsCg==
