From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 1/5] drm: fix syncobj null_fence_enable_signaling
Date: Thu, 23 Aug 2018 11:02:30 +0200
Message-ID: <031985ce-bdae-c04d-5fd4-e4ec2416e878@gmail.com>
References: <20180823082542.2998-1-david1.zhou@amd.com>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180823082542.2998-1-david1.zhou@amd.com>
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

QW0gMjMuMDguMjAxOCB1bSAxMDoyNSBzY2hyaWViIENodW5taW5nIFpob3U6Cj4gVGhhdCBpcyBj
ZXJ0YWlubHkgdG90YWxseSBub25zZW5zZS4gZG1hX2ZlbmNlX2VuYWJsZV9zd19zaWduYWxpbmco
KQo+IGlzIHRoZSBmdW5jdGlvbiB3aG8gaXMgY2FsbGluZyB0aGlzIGNhbGxiYWNrLgo+Cj4gU2ln
bmVkLW9mZi1ieTogQ2h1bm1pbmcgWmhvdSA8ZGF2aWQxLnpob3VAYW1kLmNvbT4KPiBDYzogSmFz
b24gRWtzdHJhbmQgPGphc29uQGpsZWtzdHJhbmQubmV0PgoKRm9yIHRoaXMgb25lOiBSZXZpZXdl
ZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9kcm1fc3luY29iai5jIHwgMSAtCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fc3lu
Y29iai5jIGIvZHJpdmVycy9ncHUvZHJtL2RybV9zeW5jb2JqLmMKPiBpbmRleCAzYTg4MzdjNDk2
MzkuLmQxN2VkNzVhYzdlMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX3N5bmNv
YmouYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fc3luY29iai5jCj4gQEAgLTE4NCw3ICsx
ODQsNiBAQCBzdGF0aWMgY29uc3QgY2hhciAqZHJtX3N5bmNvYmpfbnVsbF9mZW5jZV9nZXRfbmFt
ZShzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZSkKPiAgIAo+ICAgc3RhdGljIGJvb2wgZHJtX3N5bmNv
YmpfbnVsbF9mZW5jZV9lbmFibGVfc2lnbmFsaW5nKHN0cnVjdCBkbWFfZmVuY2UgKmZlbmNlKQo+
ICAgewo+IC0gICAgZG1hX2ZlbmNlX2VuYWJsZV9zd19zaWduYWxpbmcoZmVuY2UpOwo+ICAgICAg
IHJldHVybiAhZG1hX2ZlbmNlX2lzX3NpZ25hbGVkKGZlbmNlKTsKPiAgIH0KPiAgIAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxp
bmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
