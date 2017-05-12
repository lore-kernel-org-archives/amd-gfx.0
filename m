From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 2/5] drm/syncobj: add sync obj wait interface. (v2)
Date: Fri, 12 May 2017 10:57:19 +0200
Message-ID: <99a75683-de4b-f46f-c27a-5f0774a8de8e@vodafone.de>
References: <20170512003457.24936-1-airlied@gmail.com>
 <20170512003457.24936-3-airlied@gmail.com>
 <20170512084951.GD12185@nuc-i3427.alporthouse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170512084951.GD12185-aII6DKEyn0pWYbfKqPwjAkR8Iwp7RQ6xAL8bYrjMMd8@public.gmane.org>
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
To: Chris Wilson <chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTIuMDUuMjAxNyB1bSAxMDo0OSBzY2hyaWViIENocmlzIFdpbHNvbjoKPiBPbiBGcmksIE1h
eSAxMiwgMjAxNyBhdCAxMDozNDo1NEFNICsxMDAwLCBEYXZlIEFpcmxpZSB3cm90ZToKPj4gK3N0
YXRpYyBpbnQgZHJtX3N5bmNvYmpfd2FpdF9hbGxfZmVuY2VzKHN0cnVjdCBkcm1fZGV2aWNlICpk
ZXYsCj4+ICsJCQkJICAgICAgIHN0cnVjdCBkcm1fZmlsZSAqZmlsZV9wcml2YXRlLAo+PiArCQkJ
CSAgICAgICBzdHJ1Y3QgZHJtX3N5bmNvYmpfd2FpdCAqd2FpdCwKPj4gKwkJCQkgICAgICAgdWlu
dDMyX3QgKmhhbmRsZXMpCj4+ICt7Cj4+ICsJdWludDMyX3QgaTsKPj4gKwlpbnQgcmV0ID0gMDsK
Pj4gKwl1bnNpZ25lZCBsb25nIHRpbWVvdXQgPSBuc2Vjc190b19qaWZmaWVzKHdhaXQtPnRpbWVv
dXRfbnMpOwo+PiArCj4+ICsJZm9yIChpID0gMDsgaSA8IHdhaXQtPmNvdW50X2hhbmRsZXM7IGkr
Kykgewo+PiArCQlzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZTsKPj4gKwo+PiArCQlyZXQgPSBkcm1f
c3luY29ial9mZW5jZV9nZXQoZmlsZV9wcml2YXRlLCBoYW5kbGVzW2ldLAo+PiArCQkJCQkgICAg
JmZlbmNlKTsKPj4gKwkJaWYgKHJldCkKPj4gKwkJCXJldHVybiByZXQ7Cj4+ICsKPj4gKwkJaWYg
KCFmZW5jZSkKPj4gKwkJCWNvbnRpbnVlOwo+PiArCj4+ICsJCXJldCA9IGRtYV9mZW5jZV93YWl0
X3RpbWVvdXQoZmVuY2UsIHRydWUsIHRpbWVvdXQpOwo+IERvZXNuJ3QgaGFuZGxlIC1FSU5UUiB5
ZXQgd2l0aCB0aW1lb3V0LiBJZiBoYXZpbmcgYSBkcm1Jb2N0bCgpIHRoYXQKPiBjYW4ndCBiZSB0
cmlja2VkIGludG8gdHVybmluZyBhIHNob3J0IHdhaXRpbmcgaW50byBhbiBpbmRlZmluaXRlIG9u
ZSBpcyBhCj4gZ29hbC4KClllYWgsIERhbmllbCBzdW1tYXJpemVkIHRoYXQgb25jZSBuaWNlbHkg
Ynkgbm90aW5nIHRoYXQgdGltZW91dHMgc2hvdWxkIApiZSBhYnNvbHV0ZSBub3QgcmVsYXRpdmUu
CgpDaHJpc3RpYW4uCgo+IC1DaHJpcwo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
