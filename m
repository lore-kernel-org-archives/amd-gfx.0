From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/9] drm/amdgpu: add new member in amdgpu_mc for zfb
 support
Date: Wed, 7 Feb 2018 13:42:28 +0100
Message-ID: <8dc98117-e9b5-b7dd-578a-36bb921357bb@gmail.com>
References: <1518006892-14121-1-git-send-email-Feifei.Xu@amd.com>
 <1518006892-14121-3-git-send-email-Feifei.Xu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1518006892-14121-3-git-send-email-Feifei.Xu-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Feifei Xu <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

QW0gMDcuMDIuMjAxOCB1bSAxMzozNCBzY2hyaWViIEZlaWZlaSBYdToKPiBDaGFuZ2UtSWQ6IEk0
M2FiMzFhNjhlOTNlZjI2NGZiOGQ4ZGQ4YTNkYmE1OWUyOTYyZmFkCj4gU2lnbmVkLW9mZi1ieTog
SGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgo+IEFja2VkLWJ5OiBKb2huIEJy
aWRnbWFuIDxqb2huLmJyaWRnbWFuQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZ21jLmggfCA1ICsrKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2dtYy5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oCj4g
aW5kZXggZjRiODJlZjcuLmZkNWY3NjcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2dtYy5oCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2dtYy5oCj4gQEAgLTEwNyw2ICsxMDcsMTEgQEAgc3RydWN0IGFtZGdwdV9nbWMgewo+
ICAgCWF0b21pY190ICAgICAgICAgICAgICAgIHZtX2ZhdWx0X2luZm9fdXBkYXRlZDsKPiAgIAo+
ICAgCWNvbnN0IHN0cnVjdCBhbWRncHVfZ21jX2Z1bmNzCSpnbWNfZnVuY3M7Cj4gKwo+ICsJLyog
emVybyBmcmFtZSBidWZmZXIgKi8KPiArCWJvb2wJCWVuYWJsZV96ZmI7CgpQbGVhc2UgZHJvcCB0
aGUgZW5hYmxlX3pmYiBtZW1iZXIsIHNldHRpbmcgc2l6ZSB0byB6ZXJvIHNob3VsZCBiZSBlbm91
Z2ggCnRvIG5vdGUgdGhhdC4KCkNocmlzdGlhbi4KCj4gKwl1NjQJCXpmYl9waHlzX2FkZHI7Cj4g
Kwl1NjQJCXpmYl9zaXplOwo+ICAgfTsKPiAgIAo+ICAgI2VuZGlmCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
