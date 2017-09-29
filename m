From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Subject: Re: [PATCH 1/3] drm/syncobj: extract two helpers from
 drm_syncobj_create
Date: Fri, 29 Sep 2017 16:13:40 +0200
Message-ID: <CAAxE2A42G4-eD4x6VunDe4rW2c_GuaChn0Df+HE7wbvQYK0QFA@mail.gmail.com>
References: <1505248934-1819-1-git-send-email-maraeo@gmail.com>
 <4ae21aee-0b51-8338-b205-25d8910e2b86@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <4ae21aee-0b51-8338-b205-25d8910e2b86@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Chunming Zhou <zhoucm1@amd.com>
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gRnJpLCBTZXAgMjksIDIwMTcgYXQgNDo0NCBBTSwgQ2h1bm1pbmcgWmhvdSA8emhvdWNtMUBh
bWQuY29tPiB3cm90ZToKPgo+Cj4gT24gMjAxN+W5tDA55pyIMTPml6UgMDQ6NDIsIE1hcmVrIE9s
xaHDoWsgd3JvdGU6Cj4+Cj4+IEZyb206IE1hcmVrIE9sxaHDoWsgPG1hcmVrLm9sc2FrQGFtZC5j
b20+Cj4+Cj4+IEZvciBhbWRncHUuCj4+Cj4+IGRybV9zeW5jb2JqX2NyZWF0ZSBpcyByZW5hbWVk
IHRvIGRybV9zeW5jb2JqX2NyZWF0ZV9hc19oYW5kbGUsIGFuZCBuZXcKPj4gaGVscGVycyBkcm1f
c3luY29ial9jcmVhdGUgYW5kIGRybV9zeW5jb2JqX2dldF9oYW5kbGUgYXJlIGFkZGVkLgo+Pgo+
PiBTaWduZWQtb2ZmLWJ5OiBNYXJlayBPbMWhw6FrIDxtYXJlay5vbHNha0BhbWQuY29tPgo+PiAt
LS0KPj4gICBkcml2ZXJzL2dwdS9kcm0vZHJtX3N5bmNvYmouYyB8IDQ5Cj4+ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0KPj4gICBpbmNsdWRlL2RybS9kcm1fc3lu
Y29iai5oICAgICB8ICA0ICsrKysKPj4gICAyIGZpbGVzIGNoYW5nZWQsIDQ5IGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJt
X3N5bmNvYmouYyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fc3luY29iai5jCj4+IGluZGV4IDA0MjJi
OGMuLjBiYjE3NDEgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fc3luY29iai5j
Cj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fc3luY29iai5jCj4+IEBAIC0yNjIsOCArMjYy
LDE0IEBAIHZvaWQgZHJtX3N5bmNvYmpfZnJlZShzdHJ1Y3Qga3JlZiAqa3JlZikKPj4gICB9Cj4+
ICAgRVhQT1JUX1NZTUJPTChkcm1fc3luY29ial9mcmVlKTsKPj4gICAtc3RhdGljIGludCBkcm1f
c3luY29ial9jcmVhdGUoc3RydWN0IGRybV9maWxlICpmaWxlX3ByaXZhdGUsCj4+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHUzMiAqaGFuZGxlLCB1aW50MzJfdCBmbGFncykKPgo+IFlv
dSBjYW4gYWRkIGEgbmV3IHBhcmFtZXRlciBmb3IgcGFzc2luZyBkbWEgZmVuY2UsIHRoZW4gaW4g
cGF0Y2gzLCB5b3UgY2FuCj4gZGlyZWN0bHkgdXNlIGl0IGZvciBBTURHUFVfRkVOQ0VfVE8gSEFO
RExFX0dFVF9TWU5DT0JKLgo+Cj4gb3RoZXJ3aXNlIHRoZSBzZXQgbG9va3MgZ29vZCB0byBtZS4K
ClNvcnJ5IEkganVzdCBwdXNoZWQgdGhpcy4KCk1hcmVrCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVs
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
