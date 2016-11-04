From: Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH 2/3] drm/amdgpu: add the interface of waiting multiple
 fences (v3)
Date: Fri, 4 Nov 2016 11:14:40 -0600
Message-ID: <CAO_48GGkL2Jiwby6Wx3n1_vRNSpCBa9PSaAJxKGore9Rb7=6pg@mail.gmail.com>
References: <1478194871-29766-1-git-send-email-alexander.deucher@amd.com>
 <1478194871-29766-2-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1478194871-29766-2-git-send-email-alexander.deucher@amd.com>
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
Cc: Junwei Zhang <Jerry.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, DRI mailing list <dri-devel@lists.freedesktop.org>, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

SGkgQWxleCwKClRoYW5rcyBmb3IgdGhlIHBhdGNoIQoKT24gMyBOb3ZlbWJlciAyMDE2IGF0IDEx
OjQxLCBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4gd3JvdGU6Cj4gRnJvbTog
SnVud2VpIFpoYW5nIDxKZXJyeS5aaGFuZ0BhbWQuY29tPgo+Cj4gdjI6IGFnZDogcmViYXNlIGFu
ZCBzcXVhc2ggaW4gYWxsIHRoZSBwcmV2aW91cyBvcHRpbWl6YXRpb25zIGFuZAo+IGNoYW5nZXMg
c28gZXZlcnl0aGluZyBjb21waWxlcy4KPiB2Mzogc3F1YXNoIGluIFNsYXZhJ3MgMzJiaXQgYnVp
bGQgZml4Cj4KPiBTaWduZWQtb2ZmLWJ5OiBKdW53ZWkgWmhhbmcgPEplcnJ5LlpoYW5nQGFtZC5j
b20+Cj4gUmV2aWV3ZWQtYnk6IE1vbmsgTGl1IDxtb25rLmxpdUBhbWQuY29tPgo+IFJldmlld2Vk
LWJ5OiBKYW1teSBaaG91IDxKYW1teS5aaG91QGFtZC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCAgICAgfCAgIDIgKwo+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfY3MuYyAgfCAxNzEgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysKPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jIHwgICAxICsK
PiAgaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmggICAgICAgICAgIHwgIDI3ICsrKysrCj4g
IDQgZmlsZXMgY2hhbmdlZCwgMjAxIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdS5oCj4gaW5kZXggOGQwYzY4OS4uYzIwNTBjMCAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdS5oCjxzbmlwPgo+ICsKPiArICAgICAgIHIgPSBmZW5jZV93YWl0X2Fu
eV90aW1lb3V0KGFycmF5LCBmZW5jZV9jb3VudCwgdHJ1ZSwgdGltZW91dCk7CgpXaXRoIHRoZSBj
aGFuZ2UgcHJvcG9zZWQgYWJvdXQgcmV0dXJuaW5nIGluZGV4IG9mIHNpZ25hbGxlZCBmZW5jZSBp
bgpwYXRjaCAxLzMsIEkgZG9uJ3QgdGhpbmsgdGhpcyB3b3VsZCBidWlsZD8KCkJlc3QgcmVnYXJk
cywKU3VtaXQuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
