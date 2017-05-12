From: Chris Wilson <chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org>
Subject: Re: [PATCH 2/5] drm/syncobj: add sync obj wait interface. (v2)
Date: Fri, 12 May 2017 09:49:51 +0100
Message-ID: <20170512084951.GD12185@nuc-i3427.alporthouse.com>
References: <20170512003457.24936-1-airlied@gmail.com>
 <20170512003457.24936-3-airlied@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170512003457.24936-3-airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gRnJpLCBNYXkgMTIsIDIwMTcgYXQgMTA6MzQ6NTRBTSArMTAwMCwgRGF2ZSBBaXJsaWUgd3Jv
dGU6Cj4gK3N0YXRpYyBpbnQgZHJtX3N5bmNvYmpfd2FpdF9hbGxfZmVuY2VzKHN0cnVjdCBkcm1f
ZGV2aWNlICpkZXYsCj4gKwkJCQkgICAgICAgc3RydWN0IGRybV9maWxlICpmaWxlX3ByaXZhdGUs
Cj4gKwkJCQkgICAgICAgc3RydWN0IGRybV9zeW5jb2JqX3dhaXQgKndhaXQsCj4gKwkJCQkgICAg
ICAgdWludDMyX3QgKmhhbmRsZXMpCj4gK3sKPiArCXVpbnQzMl90IGk7Cj4gKwlpbnQgcmV0ID0g
MDsKPiArCXVuc2lnbmVkIGxvbmcgdGltZW91dCA9IG5zZWNzX3RvX2ppZmZpZXMod2FpdC0+dGlt
ZW91dF9ucyk7Cj4gKwo+ICsJZm9yIChpID0gMDsgaSA8IHdhaXQtPmNvdW50X2hhbmRsZXM7IGkr
Kykgewo+ICsJCXN0cnVjdCBkbWFfZmVuY2UgKmZlbmNlOwo+ICsKPiArCQlyZXQgPSBkcm1fc3lu
Y29ial9mZW5jZV9nZXQoZmlsZV9wcml2YXRlLCBoYW5kbGVzW2ldLAo+ICsJCQkJCSAgICAmZmVu
Y2UpOwo+ICsJCWlmIChyZXQpCj4gKwkJCXJldHVybiByZXQ7Cj4gKwo+ICsJCWlmICghZmVuY2Up
Cj4gKwkJCWNvbnRpbnVlOwo+ICsKPiArCQlyZXQgPSBkbWFfZmVuY2Vfd2FpdF90aW1lb3V0KGZl
bmNlLCB0cnVlLCB0aW1lb3V0KTsKCkRvZXNuJ3QgaGFuZGxlIC1FSU5UUiB5ZXQgd2l0aCB0aW1l
b3V0LiBJZiBoYXZpbmcgYSBkcm1Jb2N0bCgpIHRoYXQKY2FuJ3QgYmUgdHJpY2tlZCBpbnRvIHR1
cm5pbmcgYSBzaG9ydCB3YWl0aW5nIGludG8gYW4gaW5kZWZpbml0ZSBvbmUgaXMgYQpnb2FsLgot
Q2hyaXMKCi0tIApDaHJpcyBXaWxzb24sIEludGVsIE9wZW4gU291cmNlIFRlY2hub2xvZ3kgQ2Vu
dHJlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
