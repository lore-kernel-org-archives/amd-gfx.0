From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 2/2] dma-buf: try to replace a signaled fence in
 reservation_object_add_shared_inplace
Date: Tue, 14 Nov 2017 14:41:10 +0000
Message-ID: <151067047076.20436.4299445738327371642@mail.alporthouse.com>
References: <20171114142436.1360-1-christian.koenig@amd.com>
 <20171114142436.1360-2-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20171114142436.1360-2-christian.koenig@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

UXVvdGluZyBDaHJpc3RpYW4gS8O2bmlnICgyMDE3LTExLTE0IDE0OjI0OjM2KQo+IFRoZSBhbWRn
cHUgaXNzdWUgdG8gYWxzbyBuZWVkIHNpZ25hbGVkIGZlbmNlcyBpbiB0aGUgcmVzZXJ2YXRpb24g
b2JqZWN0cyBzaG91bGQKPiBiZSBmaXhlZCBieSBub3cuCj4gCj4gT3B0aW1pemUgdGhlIGhhbmRs
aW5nIGJ5IHJlcGxhY2luZyBhIHNpZ25hbGVkIGZlbmNlIHdoZW4gYWRkaW5nIGEgbmV3Cj4gc2hh
cmVkIG9uZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXMgV2lsc29uIDxjaHJpc0BjaHJpcy13
aWxzb24uY28udWs+CgpEb2VzIHdoYXQgeW91IHNheSwgYnV0IG5vdCBxdWl0ZSB0aGUgc2FtZSBw
YXRjaCBJJ3ZlIGJlZW4gdGVzdGluZy4KLUNocmlzCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2RyaS1kZXZlbAo=
