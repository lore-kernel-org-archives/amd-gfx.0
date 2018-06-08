From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 3/3] drm/v3d: Add a note about locking of
 v3d_fence_create().
Date: Fri, 08 Jun 2018 12:24:06 +0200
Message-ID: <1528453446.26356.12.camel@pengutronix.de>
References: <20180605190302.18279-1-eric@anholt.net>
 <20180605190302.18279-3-eric@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180605190302.18279-3-eric@anholt.net>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

QW0gRGllbnN0YWcsIGRlbiAwNS4wNi4yMDE4LCAxMjowMyAtMDcwMCBzY2hyaWViIEVyaWMgQW5o
b2x0Ogo+IFRoaXMgaXNuJ3QgdGhlIGZpcnN0IHRpbWUgSSd2ZSBoYWQgdG8gYXJndWUgdG8gbXlz
ZWxmIHdoeSB0aGUgJysrJyB3YXMKPiBzYWZlLgoKQW5kIG5vdyB5b3UgbmVlZCB0byBkbyB0aGUg
c2FtZSB0aGluZyB3aXRoIG1lLi4uCgo+IFNpZ25lZC1vZmYtYnk6IEVyaWMgQW5ob2x0IDxlcmlj
QGFuaG9sdC5uZXQ+Cj4gLS0tCj4gwqBkcml2ZXJzL2dwdS9kcm0vdjNkL3YzZF9mZW5jZS5jIHwg
MyArKysKPiDCoDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL3YzZC92M2RfZmVuY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS92M2Qv
djNkX2ZlbmNlLmMKPiBpbmRleCBiZmUzMWE4OTY2OGIuLjYyNjVlOWFiNGExMyAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vdjNkL3YzZF9mZW5jZS5jCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL3YzZC92M2RfZmVuY2UuYwo+IEBAIC0zLDYgKzMsOSBAQAo+IMKgCj4gwqAjaW5jbHVkZSAi
djNkX2Rydi5oIgo+IMKgCj4gKy8qIE5vdGUgdGhhdCBWM0QgZmVuY2VzIGFyZSBjcmVhdGVkIGR1
cmluZyB2M2Rfam9iX3J1bigpLCBzbyB3ZSdyZQo+ICsgKiBhbHJlYWR5IGltcGxpY3RseSBsb2Nr
ZWQuCj4gKyAqLwpJIGRvbid0IHNlZSB3aGVyZSB5b3Ugd291bGQgYmUgbG9ja2VkIGluIHRoZSBq
b2JfcnVuIHBhdGguIEkgdGhpbmsgd2hhdAp5b3UgbWVhbiBpcyB0aGF0IHRoaXMgcGF0aCBuZWVk
cyBubyBsb2NrcywgYXMgaXQgaXMgZHJpdmVuIGJ5IGEgc2luZ2xlCnNjaGVkdWxlciB0aHJlYWQs
IHJpZ2h0PwoKUmVnYXJkcywKTHVjYXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vZHJpLWRldmVsCg==
