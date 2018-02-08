From: Chunming Zhou <zhoucm1@amd.com>
Subject: Re: [PATCH 1/3] drm: add func to get max iomem address
Date: Thu, 8 Feb 2018 17:15:12 +0800
Message-ID: <70747416-c6ff-106b-2957-7387d2e74ca0@amd.com>
References: <20180208083238.8291-1-david1.zhou@amd.com>
 <ba2e0c80-ca21-7969-8fd3-45c00e1c3254@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <ba2e0c80-ca21-7969-8fd3-45c00e1c3254@daenzer.net>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>, Chunming Zhou <david1.zhou@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, christian.koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

CgpPbiAyMDE45bm0MDLmnIgwOOaXpSAxNzowOSwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gT24g
MjAxOC0wMi0wOCAwOTozMiBBTSwgQ2h1bm1pbmcgWmhvdSB3cm90ZToKPj4gaXQgd2lsbCBiZSB1
c2VkIHRvIGNoZWNrIGlmIHRoZSBkcml2ZXIgbmVlZHMgc3dpb3RsYgo+Pgo+PiBDaGFuZ2UtSWQ6
IElkYmU0N2FmOGYxMjAzMmQ0ODAzYmIzZDQ3MjczZTgwN2YxOTE2OWMzCj4+IFNpZ25lZC1vZmYt
Ynk6IENodW5taW5nIFpob3UgPGRhdmlkMS56aG91QGFtZC5jb20+Cj4+IFJldmlld2VkLWJ5OiBN
b25rIExpdSA8bW9uay5saXVAYW1kLmNvbT4KPj4gLS0tCj4+ICAgaW5jbHVkZS9kcm0vZHJtX2Nh
Y2hlLmggfCAxMyArKysrKysrKysrKysrCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlv
bnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL2RybV9jYWNoZS5oIGIvaW5jbHVk
ZS9kcm0vZHJtX2NhY2hlLmgKPj4gaW5kZXggYmVhYjBmMGQwY2ZiLi40NDJjOWJhNjNkMDMgMTAw
NjQ0Cj4+IC0tLSBhL2luY2x1ZGUvZHJtL2RybV9jYWNoZS5oCj4+ICsrKyBiL2luY2x1ZGUvZHJt
L2RybV9jYWNoZS5oCj4+IEBAIC0zOSw2ICszOSwxOSBAQCB2b2lkIGRybV9jbGZsdXNoX3BhZ2Vz
KHN0cnVjdCBwYWdlICpwYWdlc1tdLCB1bnNpZ25lZCBsb25nIG51bV9wYWdlcyk7Cj4+ICAgdm9p
ZCBkcm1fY2xmbHVzaF9zZyhzdHJ1Y3Qgc2dfdGFibGUgKnN0KTsKPj4gICB2b2lkIGRybV9jbGZs
dXNoX3ZpcnRfcmFuZ2Uodm9pZCAqYWRkciwgdW5zaWduZWQgbG9uZyBsZW5ndGgpOwo+PiAgIAo+
PiArc3RhdGljIGlubGluZSB1NjQgZHJtX2dldF9tYXhfaW9tZW0odm9pZCkKPj4gK3sKPj4gKwlz
dHJ1Y3QgcmVzb3VyY2UgKnRtcDsKPj4gKwl1NjQgbWF4X2lvbWVtID0gMDsKPj4gKwo+PiArCWZv
ciAodG1wID0gaW9tZW1fcmVzb3VyY2UuY2hpbGQ7IHRtcDsgdG1wID0gdG1wLT5zaWJsaW5nKSB7
Cj4+ICsJCW1heF9pb21lbSA9IG1heChtYXhfaW9tZW0sICB0bXAtPmVuZCk7Cj4+ICsJfQo+PiAr
Cj4+ICsJcmV0dXJuIG1heF9pb21lbTsKPj4gK30KPiBJIGRvbid0IHRoaW5rIHRoaXMgbmVlZHMg
dG8gYmUgYW4gaW5saW5lIGZ1bmN0aW9uLCBkb2VzIGl0PwpJZiBubyBpbmxpbmUsIHdpbGwgcmVw
b3J0IGJ1aWxkaW5nIHdhcm5pbmcgdGhhdCB0aGlzIGZ1bmN0aW9uIGlzIGRlZmluZWQgCmJ1dCBu
b3QgdXNlZCBpbiBzb21lIGZpbGVzIGluY2x1ZGluZyBkcm1fY2FjaGUuaAoKUmVnYXJkcywKRGF2
aWQgWmhvdQo+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZl
bAo=
