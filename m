From: Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH 1/4] dma-buf/fence: make timeout handling in
 fence_default_wait consistent (v2)
Date: Wed, 9 Nov 2016 01:05:35 +0530
Message-ID: <CAO_48GEYmw5VcuFg0natrorSBRVTyuYfH014iFUD30-EWyqhYg@mail.gmail.com>
References: <1478553376-18575-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1478553376-18575-1-git-send-email-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, DRI mailing list <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

SGkgQWxleCwgQ2hyaXN0aWFuLAoKT24gOCBOb3ZlbWJlciAyMDE2IGF0IDAyOjQ2LCBBbGV4IERl
dWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4gd3JvdGU6Cj4gS2VybmVsIGZ1bmN0aW9ucyB0
YWtpbmcgYSB0aW1lb3V0IHVzdWFsbHkgcmV0dXJuIDEgb24gc3VjY2VzcyBldmVuCj4gd2hlbiB0
aGV5IGdldCBhIHplcm8gdGltZW91dC4KPgo+IHYyOiBhZ2Q6IHJlYmFzZSBvbiBkcm0tbmV4dAo+
Cj4gUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4K
PiBTaWduZW4tb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+Cj4gUmV2aWV3ZWQtYnk6IENodW5taW5nIFpob3UgPGRhdmlkMS56aG91QGFtZC5jb20+Cj4g
U2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+
IC0tLQo+Cj4gVGhlc2UgYXJlIHRoZSBzYW1lIHBhdGNoZXMgQ2hyaXN0aWFuIHNlbnQgb3V0IHBy
ZXZpb3VzbHksIGp1c3QKPiByZWJhc2VkIG9uIHRoZSBmZW5jZSBuYW1pbmcgY2hhbmdlcyBpbiBk
cm0tbmV4dC4KPgpTZXJpZXMgYXBwbGllZCB0byBkcm0tbWlzYzsgVGhhbmtzIQoKQmVzdCwKU3Vt
aXQuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1k
ZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
