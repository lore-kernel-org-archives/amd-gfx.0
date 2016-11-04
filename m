From: Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH 1/2] dma-buf: return index of the first signaled fence (v2)
Date: Fri, 4 Nov 2016 16:03:34 -0600
Message-ID: <CAO_48GGiBXFFqxWg1fUKMVUR13QvwaH5a8eiGrOgeCbUyY0WnA@mail.gmail.com>
References: <1478290570-30982-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1478290570-30982-1-git-send-email-alexander.deucher@amd.com>
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
Cc: "monk.liu" <monk.liu@amd.com>, Alex Deucher <alexander.deucher@amd.com>, DRI mailing list <dri-devel@lists.freedesktop.org>, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

SGkgQWxleCwKClRoYW5rcyBmb3IgdGhlIHBhdGNoZXMuCgpPbiA0IE5vdmVtYmVyIDIwMTYgYXQg
MTQ6MTYsIEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPiB3cm90ZToKPiBGcm9t
OiAibW9uay5saXUiIDxtb25rLmxpdUBhbWQuY29tPgo+Cj4gUmV0dXJuIHRoZSBpbmRleCBvZiB0
aGUgZmlyc3Qgc2lnbmFsZWQgZmVuY2UuICBUaGlzIGluZm9ybWF0aW9uCj4gaXMgdXNlZnVsIGlu
IHNvbWUgQVBJcyBsaWtlIFZ1bGthbi4KPgo+IHYyOiByZWJhc2Ugb24gZHJtLW5leHQgKGZlbmNl
IC0+IGRtYV9mZW5jZSkKPgo+IFNpZ25lZC1vZmYtYnk6IG1vbmsubGl1IDxtb25rLmxpdUBhbWQu
Y29tPgo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1k
LmNvbT4KPiBDYzogU3VtaXQgU2Vtd2FsIDxzdW1pdC5zZW13YWxAbGluYXJvLm9yZz4KPiAtLS0K
Pgo+IFRoaXMgaXMgdGhlIHNhbWUgcGF0Y2ggc2V0IEkgc2VuZCBvdXQgeWVzdGVyZGF5LCBJIGp1
c3QKPiBzcXVhc2hlZCB0aGUgYW1kZ3B1IHBhdGNoZXMgdG9nZXRoZXIgYW5kIHJlYmFzZWQgZXZl
cnl0aGluZyBvbgo+IHRoZSBmZW5jZSAtPiBkbWFfZmVuY2UgcmVuYW1pbmcuICBUaGlzIGlzIHVz
ZWQgYnkgb3VyIFZLIGRyaXZlcgo+IGFuZCB3ZSBhcmUgcGxhbm5pbmcgdG8gdXNlIGl0IGluIG1l
c2EgYXMgd2VsbC4KPgoKV291bGQgeW91IGJlIG9rIGlmIEkgYXBwbHkgdGhpcyBhbmQgdGhlIGFt
ZGdwdSBwYXRjaCBib3RoIHRvZ2V0aGVyIHZpYQpkcm0tbWlzYywgb3Igd291bGQgeW91IGxpa2Ug
bWUgdG8gbm90aWZ5IHlvdSBvbmNlIEkgbWVyZ2UgdGhpcyBmb3IgeW91CnRvIHRha2UgdGhlIGFt
ZGdwdSBwYXRjaCB2aWEgeW91ciB0cmVlPyBJJ20gZmluZSBlaXRoZXIgd2F5cywgYnV0CnBlcmhh
cHMgZHJtLW1pc2Mgd291bGQgYmUgYSBiaXQgbmVhdGVyLgoKPiBkcml2ZXJzL2RtYS1idWYvZG1h
LWZlbmNlLmMgfCAyMCArKysrKysrKysrKysrKystLS0tLQo+ICBpbmNsdWRlL2xpbnV4L2RtYS1m
ZW5jZS5oICAgfCAgMiArLQo+ICAyIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDYg
ZGVsZXRpb25zKC0pCj4KCkJlc3QgcmVnYXJkcywKU3VtaXQuCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRl
dmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
