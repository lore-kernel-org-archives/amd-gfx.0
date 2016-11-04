From: Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH 1/3] dma-buf: return index of the first signaled fence
Date: Fri, 4 Nov 2016 11:37:15 -0600
Message-ID: <CAO_48GGpTT-7=zC_CA3=0Cwr4670d5Q+28sbuC_3yKBrqRft0A@mail.gmail.com>
References: <1478194871-29766-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1478194871-29766-1-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexdeucher@gmail.com>, Gustavo Padovan <gustavo@padovan.org>
Cc: "monk.liu" <monk.liu@amd.com>, Alex Deucher <alexander.deucher@amd.com>, DRI mailing list <dri-devel@lists.freedesktop.org>, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

SGkgQWxleCwKClRoYW5rcyBmb3IgdGhpcyBwYXRjaC4gQWRkaW5nIEd1c3Rhdm8gYXMgd2VsbC4K
Ck9uIDMgTm92ZW1iZXIgMjAxNiBhdCAxMTo0MSwgQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBn
bWFpbC5jb20+IHdyb3RlOgo+IEZyb206ICJtb25rLmxpdSIgPG1vbmsubGl1QGFtZC5jb20+Cj4K
PiBSZXR1cm4gdGhlIGluZGV4IG9mIHRoZSBmaXJzdCBzaWduYWxlZCBmZW5jZS4gIFRoaXMgaW5m
b3JtYXRpb24KPiBpcyB1c2VmdWwgaW4gc29tZSBBUElzIGxpa2UgVnVsa2FuLgo+Cj4gU2lnbmVk
LW9mZi1ieTogbW9uay5saXUgPG1vbmsubGl1QGFtZC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IENjOiBTdW1pdCBTZW13YWwg
PHN1bWl0LnNlbXdhbEBsaW5hcm8ub3JnPgo+IC0tLQo+ICBkcml2ZXJzL2RtYS1idWYvZmVuY2Uu
YyB8IDE5ICsrKysrKysrKysrKysrLS0tLS0KPiAgaW5jbHVkZS9saW51eC9mZW5jZS5oICAgfCAg
MiArLQo+ICAyIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0p
Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEtYnVmL2ZlbmNlLmMgYi9kcml2ZXJzL2RtYS1i
dWYvZmVuY2UuYwo+IGluZGV4IDY0NDc4ZjkuLjMyZmRjZTEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9kbWEtYnVmL2ZlbmNlLmMKPiArKysgYi9kcml2ZXJzL2RtYS1idWYvZmVuY2UuYwo+IEBAIC0z
OTcsMTQgKzM5NywxNyBAQCBvdXQ6Cj4gIEVYUE9SVF9TWU1CT0woZmVuY2VfZGVmYXVsdF93YWl0
KTsKPgo+ICBzdGF0aWMgYm9vbAo+IC1mZW5jZV90ZXN0X3NpZ25hbGVkX2FueShzdHJ1Y3QgZmVu
Y2UgKipmZW5jZXMsIHVpbnQzMl90IGNvdW50KQo+ICtmZW5jZV90ZXN0X3NpZ25hbGVkX2FueShz
dHJ1Y3QgZmVuY2UgKipmZW5jZXMsIHVpbnQzMl90IGNvdW50LCB1aW50MzJfdCAqaWR4KQo+ICB7
Ckxvb2tzIHNhbmUgdG8gbWU7IEd1c3Rhdm8sIGNvbW1lbnRzPwoKQmVzdCByZWdhcmRzLApTdW1p
dC4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRl
dmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
