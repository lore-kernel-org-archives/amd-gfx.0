From: Tom St Denis <tom.stdenis@amd.com>
Subject: Re: [PATCH 2/2] drm/ttm: Fix trace include path
Date: Fri, 1 Sep 2017 12:13:22 -0400
Message-ID: <cc5877da-6fb7-5a32-ef22-e63cc2f51c3b@amd.com>
References: <20170901161043.6383-1-tom.stdenis@amd.com>
 <20170901161043.6383-2-tom.stdenis@amd.com>
 <BN6PR12MB1652BB39F322648E5E3B1FABF7920@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <BN6PR12MB1652BB39F322648E5E3B1FABF7920@BN6PR12MB1652.namprd12.prod.outlook.com>
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
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gMDEvMDkvMTcgMTI6MTIgUE0sIERldWNoZXIsIEFsZXhhbmRlciB3cm90ZToKPj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0KPj4gRnJvbTogYW1kLWdmeCBbbWFpbHRvOmFtZC1nZngtYm91
bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmddIE9uIEJlaGFsZgo+PiBPZiBUb20gU3QgRGVuaXMK
Pj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMDEsIDIwMTcgMTI6MTEgUE0KPj4gVG86IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+IENjOiBTdERlbmlzLCBUb207IGRyaS1kZXZlbEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gU3ViamVjdDogW1BBVENIIDIvMl0gZHJtL3R0bTogRml4
IHRyYWNlIGluY2x1ZGUgcGF0aAo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBUb20gU3QgRGVuaXMgPHRv
bS5zdGRlbmlzQGFtZC5jb20+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3Ry
YWNlLmggfCAyICstCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV90cmFjZS5o
Cj4+IGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fdHJhY2UuaAo+PiBpbmRleCAyMzI3OWI5Yjhl
NjQuLjcxNWNlNjhiN2IzMyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1f
dHJhY2UuaAo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV90cmFjZS5oCj4+IEBAIC04
Miw2ICs4Miw2IEBAIFRSQUNFX0VWRU5UKHR0bV9kbWFfdW5tYXAsCj4+Cj4+ICAgLyogVGhpcyBw
YXJ0IG11c3QgYmUgb3V0c2lkZSBwcm90ZWN0aW9uICovCj4+ICAgI3VuZGVmIFRSQUNFX0lOQ0xV
REVfUEFUSAo+PiAtI2RlZmluZSBUUkFDRV9JTkNMVURFX1BBVEggLgo+PiArI2RlZmluZSBUUkFD
RV9JTkNMVURFX1BBVEggLi4vLi4vZHJpdmVycy9ncHUvZHJtL3R0bS8KPj4gICAjaW5jbHVkZSA8
dHJhY2UvZGVmaW5lX3RyYWNlLmg+Cj4gCj4gSSB0aGluayB5b3UgY2FuIGRyb3AgdGhlIE1ha2Vm
aWxlIGNoYW5nZSBhcyB3ZWxsLgoKWXVwLgoKVG9tCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2RyaS1kZXZlbAo=
