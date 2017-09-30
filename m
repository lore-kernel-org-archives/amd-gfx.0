From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Subject: Re: [PATCH 1/3] drm/syncobj: extract two helpers from
 drm_syncobj_create
Date: Sat, 30 Sep 2017 17:55:46 +0200
Message-ID: <CAAxE2A6gfDHWU73ji+KVbtZH8pG1f8-1Ts2_FUh9MjyYa+b=oA@mail.gmail.com>
References: <1505248934-1819-1-git-send-email-maraeo@gmail.com>
 <4ae21aee-0b51-8338-b205-25d8910e2b86@amd.com>
 <CAAxE2A42G4-eD4x6VunDe4rW2c_GuaChn0Df+HE7wbvQYK0QFA@mail.gmail.com>
 <CAAxE2A6ecZnArHSu8P_DuHPOGhz0+6TfXtQshKWvhU1=1V4Lyg@mail.gmail.com>
 <53eb9f85-e57f-fe8b-8bfb-967db2370c28@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <53eb9f85-e57f-fe8b-8bfb-967db2370c28@amd.com>
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

VGhlIGlkZWEgc291bmRzIGdvb2QuCgpNYXJlawoKT24gU2F0LCBTZXAgMzAsIDIwMTcgYXQgMzo1
NSBBTSwgQ2h1bm1pbmcgWmhvdSA8emhvdWNtMUBhbWQuY29tPiB3cm90ZToKPiBNeSBtZWFuIGlz
IGxpa2UgdGhlIGF0dGFjaGVkLCBJIHJldmVydCBwYXJ0IG9mIHlvdXJzLgo+Cj4gUmVnYXJkcywK
Pgo+IERhdmlkIHpob3UKPgo+Cj4KPiBPbiAyMDE35bm0MDnmnIgyOeaXpSAyMjoxNSwgTWFyZWsg
T2zFocOhayB3cm90ZToKPj4KPj4gT24gRnJpLCBTZXAgMjksIDIwMTcgYXQgNDoxMyBQTSwgTWFy
ZWsgT2zFocOhayA8bWFyYWVvQGdtYWlsLmNvbT4gd3JvdGU6Cj4+Pgo+Pj4gT24gRnJpLCBTZXAg
MjksIDIwMTcgYXQgNDo0NCBBTSwgQ2h1bm1pbmcgWmhvdSA8emhvdWNtMUBhbWQuY29tPiB3cm90
ZToKPj4+Pgo+Pj4+Cj4+Pj4gT24gMjAxN+W5tDA55pyIMTPml6UgMDQ6NDIsIE1hcmVrIE9sxaHD
oWsgd3JvdGU6Cj4+Pj4+Cj4+Pj4+IEZyb206IE1hcmVrIE9sxaHDoWsgPG1hcmVrLm9sc2FrQGFt
ZC5jb20+Cj4+Pj4+Cj4+Pj4+IEZvciBhbWRncHUuCj4+Pj4+Cj4+Pj4+IGRybV9zeW5jb2JqX2Ny
ZWF0ZSBpcyByZW5hbWVkIHRvIGRybV9zeW5jb2JqX2NyZWF0ZV9hc19oYW5kbGUsIGFuZCBuZXcK
Pj4+Pj4gaGVscGVycyBkcm1fc3luY29ial9jcmVhdGUgYW5kIGRybV9zeW5jb2JqX2dldF9oYW5k
bGUgYXJlIGFkZGVkLgo+Pj4+Pgo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBNYXJlayBPbMWhw6FrIDxt
YXJlay5vbHNha0BhbWQuY29tPgo+Pj4+PiAtLS0KPj4+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2Ry
bV9zeW5jb2JqLmMgfCA0OQo+Pj4+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0tCj4+Pj4+ICAgIGluY2x1ZGUvZHJtL2RybV9zeW5jb2JqLmggICAgIHwgIDQgKysr
Kwo+Pj4+PiAgICAyIGZpbGVzIGNoYW5nZWQsIDQ5IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pCj4+Pj4+Cj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJtX3N5bmNvYmou
Ywo+Pj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fc3luY29iai5jCj4+Pj4+IGluZGV4IDA0MjJi
OGMuLjBiYjE3NDEgMTAwNjQ0Cj4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fc3luY29i
ai5jCj4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fc3luY29iai5jCj4+Pj4+IEBAIC0y
NjIsOCArMjYyLDE0IEBAIHZvaWQgZHJtX3N5bmNvYmpfZnJlZShzdHJ1Y3Qga3JlZiAqa3JlZikK
Pj4+Pj4gICAgfQo+Pj4+PiAgICBFWFBPUlRfU1lNQk9MKGRybV9zeW5jb2JqX2ZyZWUpOwo+Pj4+
PiAgICAtc3RhdGljIGludCBkcm1fc3luY29ial9jcmVhdGUoc3RydWN0IGRybV9maWxlICpmaWxl
X3ByaXZhdGUsCj4+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHUzMiAqaGFuZGxl
LCB1aW50MzJfdCBmbGFncykKPj4+Pgo+Pj4+IFlvdSBjYW4gYWRkIGEgbmV3IHBhcmFtZXRlciBm
b3IgcGFzc2luZyBkbWEgZmVuY2UsIHRoZW4gaW4gcGF0Y2gzLCB5b3UKPj4+PiBjYW4KPj4+PiBk
aXJlY3RseSB1c2UgaXQgZm9yIEFNREdQVV9GRU5DRV9UTyBIQU5ETEVfR0VUX1NZTkNPQkouCj4+
Pj4KPj4+PiBvdGhlcndpc2UgdGhlIHNldCBsb29rcyBnb29kIHRvIG1lLgo+Pj4KPj4+IFNvcnJ5
IEkganVzdCBwdXNoZWQgdGhpcy4KPj4KPj4gQWN0dWFsbHksIHlvdSBjb21tZW50ZWQgb24gYSBk
ZWxldGVkIGxpbmUuIFRoZSBmdW5jdGlvbiBhbHJlYWR5IGhhcwo+PiBkbWFfZmVuY2UgYW1vbmcg
dGhlIHBhcmFtZXRlcnMuCj4+Cj4+IE1hcmVrCj4KPgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9kcmktZGV2ZWwK
