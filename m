From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/ttm: set ttm_buffer_object pointer as null after
 it's freed
Date: Mon, 10 Sep 2018 11:00:04 +0200
Message-ID: <d40314d2-f1c4-b353-bda6-50aed5dda8db@amd.com>
References: <1536569876-27262-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1536569876-27262-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom StDenis <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>

SGkgUmF5LAoKd2VsbCB0aG9zZSBwYXRjaGVzIGRvZXNuJ3QgbWFrZSBzZW5zZSwgdGhlIHBvaW50
ZXIgaXMgb25seSBsb2NhbCB0byB0aGUgCmZ1bmN0aW9uLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoK
QW0gMTAuMDkuMjAxOCB1bSAxMDo1NyBzY2hyaWViIEh1YW5nIFJ1aToKPiBJdCBhdm9pZHMgdG8g
YmUgcmVmZXJlZCBhZ2FpbiBhZnRlciBmcmVlZC4KPgo+IFNpZ25lZC1vZmYtYnk6IEh1YW5nIFJ1
aSA8cmF5Lmh1YW5nQGFtZC5jb20+Cj4gQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4KPiBDYzogVG9tIFN0RGVuaXMgPFRvbS5TdERlbmlzQGFtZC5jb20+Cj4g
LS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jIHwgMSArCj4gICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdHRt
L3R0bV9iby5jIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYwo+IGluZGV4IDEzOGM5ODku
LmQzZWY1ZjggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYwo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMKPiBAQCAtNTQsNiArNTQsNyBAQCBzdGF0
aWMgc3RydWN0IGF0dHJpYnV0ZSB0dG1fYm9fY291bnQgPSB7Cj4gICBzdGF0aWMgdm9pZCB0dG1f
Ym9fZGVmYXVsdF9kZXN0cm95KHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8pCj4gICB7Cj4g
ICAJa2ZyZWUoYm8pOwo+ICsJYm8gPSBOVUxMOwo+ICAgfQo+ICAgCj4gICBzdGF0aWMgaW5saW5l
IGludCB0dG1fbWVtX3R5cGVfZnJvbV9wbGFjZShjb25zdCBzdHJ1Y3QgdHRtX3BsYWNlICpwbGFj
ZSwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
