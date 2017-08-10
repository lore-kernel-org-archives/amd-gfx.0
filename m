From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 2/2] dma-buf: fix reservation_object_wait_timeout_rcu to
 wait correctly v2
Date: Thu, 10 Aug 2017 18:11:26 +0100
Message-ID: <150238508616.26524.9935181193137231431@mail.alporthouse.com>
References: <1502384509-10465-1-git-send-email-alexander.deucher@amd.com>
 <1502384509-10465-3-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1502384509-10465-3-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: Alex Deucher <alexander.deucher@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

UXVvdGluZyBBbGV4IERldWNoZXIgKDIwMTctMDgtMTAgMTg6MDE6NDkpCj4gRnJvbTogQ2hyaXN0
aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IAo+IFdpdGggaGFyZHdhcmUg
cmVzZXRzIGluIG1pbmQgaXQgaXMgcG9zc2libGUgdGhhdCBhbGwgc2hhcmVkIGZlbmNlcyBhcmUK
PiBzaWduYWxlZCwgYnV0IHRoZSBleGx1c2l2ZSBpc24ndC4gRml4IHdhaXRpbmcgZm9yIGV2ZXJ5
dGhpbmcgaW4gdGhpcyBzaXR1YXRpb24uCgpJJ20gc3RpbGwgcHV6emxpbmcgb3ZlciB0aGlzIG9u
ZS4KClNldHRpbmcgYW4gZXhjbHVzaXZlIGZlbmNlIHdpbGwgY2xlYXIgYWxsIHNoYXJlZCwgc28g
d2UgbXVzdCBoYXZlIGFkZGVkCnRoZSBzaGFyZWQgZmVuY2VzIGFmdGVyIHRoZSBleGNsdXNpdmUg
ZmVuY2UuIEJ1dCB0aG9zZSBzaGFyZWQgZmVuY2VzIG11c3QKZm9sbG93IHRoZSBleGNsdXNpdmUg
ZmVuY2UsIHlvdSBzaG91bGQgbm90IGJlIGFibGUgdG8gcmVvcmRlciB0aGUgc2hhcmVkCmZlbmNl
cyBhaGVhZCBvZiB0aGUgZXhjbHVzaXZlLiBJZiB5b3UgaGF2ZSBjb21wbGV0ZWQgc2hhcmVkIGZl
bmNlcywgYnV0CmluY29tcGxldGUgZXhjbHVzaXZlLCBkb2Vzbid0IHRoYXQgaW1wbHkgeW91IGhh
dmUgYW4gb3JkZXJpbmcgaXNzdWU/Ci1DaHJpcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9kcmktZGV2ZWwK
