From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 1/3] drm: add func to get max iomem address
Date: Thu, 8 Feb 2018 10:09:14 +0100
Message-ID: <ba2e0c80-ca21-7969-8fd3-45c00e1c3254@daenzer.net>
References: <20180208083238.8291-1-david1.zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180208083238.8291-1-david1.zhou@amd.com>
Content-Language: en-CA
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Chunming Zhou <david1.zhou@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, christian.koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

T24gMjAxOC0wMi0wOCAwOTozMiBBTSwgQ2h1bm1pbmcgWmhvdSB3cm90ZToKPiBpdCB3aWxsIGJl
IHVzZWQgdG8gY2hlY2sgaWYgdGhlIGRyaXZlciBuZWVkcyBzd2lvdGxiCj4gCj4gQ2hhbmdlLUlk
OiBJZGJlNDdhZjhmMTIwMzJkNDgwM2JiM2Q0NzI3M2U4MDdmMTkxNjljMwo+IFNpZ25lZC1vZmYt
Ynk6IENodW5taW5nIFpob3UgPGRhdmlkMS56aG91QGFtZC5jb20+Cj4gUmV2aWV3ZWQtYnk6IE1v
bmsgTGl1IDxtb25rLmxpdUBhbWQuY29tPgo+IC0tLQo+ICBpbmNsdWRlL2RybS9kcm1fY2FjaGUu
aCB8IDEzICsrKysrKysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykK
PiAKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kcm0vZHJtX2NhY2hlLmggYi9pbmNsdWRlL2RybS9k
cm1fY2FjaGUuaAo+IGluZGV4IGJlYWIwZjBkMGNmYi4uNDQyYzliYTYzZDAzIDEwMDY0NAo+IC0t
LSBhL2luY2x1ZGUvZHJtL2RybV9jYWNoZS5oCj4gKysrIGIvaW5jbHVkZS9kcm0vZHJtX2NhY2hl
LmgKPiBAQCAtMzksNiArMzksMTkgQEAgdm9pZCBkcm1fY2xmbHVzaF9wYWdlcyhzdHJ1Y3QgcGFn
ZSAqcGFnZXNbXSwgdW5zaWduZWQgbG9uZyBudW1fcGFnZXMpOwo+ICB2b2lkIGRybV9jbGZsdXNo
X3NnKHN0cnVjdCBzZ190YWJsZSAqc3QpOwo+ICB2b2lkIGRybV9jbGZsdXNoX3ZpcnRfcmFuZ2Uo
dm9pZCAqYWRkciwgdW5zaWduZWQgbG9uZyBsZW5ndGgpOwo+ICAKPiArc3RhdGljIGlubGluZSB1
NjQgZHJtX2dldF9tYXhfaW9tZW0odm9pZCkKPiArewo+ICsJc3RydWN0IHJlc291cmNlICp0bXA7
Cj4gKwl1NjQgbWF4X2lvbWVtID0gMDsKPiArCj4gKwlmb3IgKHRtcCA9IGlvbWVtX3Jlc291cmNl
LmNoaWxkOyB0bXA7IHRtcCA9IHRtcC0+c2libGluZykgewo+ICsJCW1heF9pb21lbSA9IG1heCht
YXhfaW9tZW0sICB0bXAtPmVuZCk7Cj4gKwl9Cj4gKwo+ICsJcmV0dXJuIG1heF9pb21lbTsKPiAr
fQoKSSBkb24ndCB0aGluayB0aGlzIG5lZWRzIHRvIGJlIGFuIGlubGluZSBmdW5jdGlvbiwgZG9l
cyBpdD8KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAg
ICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAg
ICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlz
dApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
