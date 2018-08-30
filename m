From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 1/5] drm: fix syncobj null_fence_enable_signaling
Date: Thu, 30 Aug 2018 09:26:34 +0200
Message-ID: <3d696306-713c-b783-49f1-96fba62a5bd5@gmail.com>
References: <20180830064831.5868-1-david1.zhou@amd.com>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180830064831.5868-1-david1.zhou@amd.com>
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
To: Chunming Zhou <david1.zhou@amd.com>, dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, Jason Ekstrand <jason@jlekstrand.net>
List-Id: amd-gfx.lists.freedesktop.org

QW0gMzAuMDguMjAxOCB1bSAwODo0OCBzY2hyaWViIENodW5taW5nIFpob3U6Cj4gVGhhdCBpcyBj
ZXJ0YWlubHkgdG90YWxseSBub25zZW5zZS4gZG1hX2ZlbmNlX2VuYWJsZV9zd19zaWduYWxpbmco
KQo+IGlzIHRoZSBmdW5jdGlvbiB3aG8gaXMgY2FsbGluZyB0aGlzIGNhbGxiYWNrLgo+Cj4gU2ln
bmVkLW9mZi1ieTogQ2h1bm1pbmcgWmhvdSA8ZGF2aWQxLnpob3VAYW1kLmNvbT4KPiBDYzogSmFz
b24gRWtzdHJhbmQgPGphc29uQGpsZWtzdHJhbmQubmV0Pgo+IFJldmlld2VkLWJ5OiBDaHJpc3Rp
YW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gQWNrZWQtYnk6IERhbmllbCBW
ZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KCklmIHRoZXJlIGFyZSBubyBvYmplY3Rpb25zIEknbSBn
b2luZyB0byBwdXNoIHBhdGNoZXMgIzEtIzQgdG8gZHJtLW1pc2MtbmV4dC4KCkluZGVwZW5kZW50
IG9mIHRoZSB0aW1lbGluZSBzeW5jIG9iamVjdCB3b3JrIHRoZXkgbG9vayBsaWtlIG5pY2UgCmNs
ZWFudXBzIHRvIG1lLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1
L2RybS9kcm1fc3luY29iai5jIHwgMSAtCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigt
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fc3luY29iai5jIGIvZHJpdmVy
cy9ncHUvZHJtL2RybV9zeW5jb2JqLmMKPiBpbmRleCAzYTg4MzdjNDk2MzkuLmQxN2VkNzVhYzdl
MiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX3N5bmNvYmouYwo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9kcm1fc3luY29iai5jCj4gQEAgLTE4NCw3ICsxODQsNiBAQCBzdGF0aWMg
Y29uc3QgY2hhciAqZHJtX3N5bmNvYmpfbnVsbF9mZW5jZV9nZXRfbmFtZShzdHJ1Y3QgZG1hX2Zl
bmNlICpmZW5jZSkKPiAgIAo+ICAgc3RhdGljIGJvb2wgZHJtX3N5bmNvYmpfbnVsbF9mZW5jZV9l
bmFibGVfc2lnbmFsaW5nKHN0cnVjdCBkbWFfZmVuY2UgKmZlbmNlKQo+ICAgewo+IC0gICAgZG1h
X2ZlbmNlX2VuYWJsZV9zd19zaWduYWxpbmcoZmVuY2UpOwo+ICAgICAgIHJldHVybiAhZG1hX2Zl
bmNlX2lzX3NpZ25hbGVkKGZlbmNlKTsKPiAgIH0KPiAgIAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
