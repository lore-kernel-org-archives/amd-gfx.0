From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu/virt: fix double kfree on bo_va
Date: Wed, 8 Feb 2017 21:07:41 -0500
Message-ID: <CADnq5_MWcg7qXiFj5=MUqZhAJLH++he3JViNoeLP8fSbcUv8Gw@mail.gmail.com>
References: <20170203202342.13128-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170203202342.13128-1-colin.king@canonical.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Colin King <colin.king@canonical.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Xiangliang Yu <Xiangliang.Yu@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Monk Liu <Monk.Liu@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gRnJpLCBGZWIgMywgMjAxNyBhdCAzOjIzIFBNLCBDb2xpbiBLaW5nIDxjb2xpbi5raW5nQGNh
bm9uaWNhbC5jb20+IHdyb3RlOgo+IEZyb206IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNh
bm9uaWNhbC5jb20+Cj4KPiBib192YSBpcyBiZWluZyBrZnJlZSdkIHR3aWNlLCBvbmNlIGluIHRo
ZSBjYWxsIHRvIGFtZGdwdV92bV9ib19ybXYKPiBhbmQgdGhlbiBhIHNob3J0IHdoaWxlIGxhdGVy
LiBGaXggdGhpcyBkb3VibGUgZnJlZSBieSByZW1vdmluZwo+IHRoZSAybmQga2ZyZWUuCj4KPiBE
ZXRlY3RlZCBieSBDb3Zlcml0eVNjYW4sIENJRCMxMzk5NTI0ICgiRG91YmxlIEZyZWUiKQo+Cj4g
U2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4K
CkFwcGxpZWQuICB0aGFua3MhCgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdmlydC5jIHwgMSAtCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCj4KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0LmMKPiBpbmRleCAzZmQ5NTFjLi5k
Y2ZiN2RmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
aXJ0LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jCj4g
QEAgLTgzLDcgKzgzLDYgQEAgaW50IGFtZGdwdV9tYXBfc3RhdGljX2NzYShzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0pCj4gICAgICAgICAgICAgICAgIERS
TV9FUlJPUigiZmFpbGVkIHRvIGRvIGJvX21hcCBvbiBzdGF0aWMgQ1NBLCBlcnI9JWRcbiIsIHIp
Owo+ICAgICAgICAgICAgICAgICBhbWRncHVfdm1fYm9fcm12KGFkZXYsIGJvX3ZhKTsKPiAgICAg
ICAgICAgICAgICAgdHRtX2V1X2JhY2tvZmZfcmVzZXJ2YXRpb24oJnRpY2tldCwgJmxpc3QpOwo+
IC0gICAgICAgICAgICAgICBrZnJlZShib192YSk7Cj4gICAgICAgICAgICAgICAgIHJldHVybiBy
Owo+ICAgICAgICAgfQo+Cj4gLS0KPiAyLjEwLjIKPgo+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4gZHJpLWRldmVsIG1haWxpbmcgbGlzdAo+IGRyaS1k
ZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9kcmktZGV2ZWwK
