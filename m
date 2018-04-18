From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/scheduler: always put last_sched fence in
 entity_fini
Date: Wed, 18 Apr 2018 10:56:24 +0200
Message-ID: <dafee649-0172-bdb3-3077-89e9408374ba@gmail.com>
References: <1524041119-5610-1-git-send-email-Pixel.Ding@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1524041119-5610-1-git-send-email-Pixel.Ding-5C7GfCeVMHo@public.gmane.org>
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
To: Pixel Ding <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTguMDQuMjAxOCB1bSAxMDo0NSBzY2hyaWViIFBpeGVsIERpbmc6Cj4gRml4IHRoZSBwb3Rl
bnRpYWwgbWVtbGVhayBzaW5jZSBzY2hlZHVsZXIgbWFpbiB0aHJlYWQgYWx3YXlzCj4gaG9sZCBv
bmUgbGFzdF9zY2hlZCBmZW5jZS4KPgo+IFNpZ25lZC1vZmYtYnk6IFBpeGVsIERpbmcgPFBpeGVs
LkRpbmdAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+IGZvciB0aGUgd2hvbGUgCnNlcmllcy4KCj4gLS0tCj4gICBkcml2ZXJz
L2dwdS9kcm0vc2NoZWR1bGVyL2dwdV9zY2hlZHVsZXIuYyB8IDYgKysrLS0tCj4gICAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvZ3B1X3NjaGVkdWxlci5jIGIvZHJpdmVycy9ncHUv
ZHJtL3NjaGVkdWxlci9ncHVfc2NoZWR1bGVyLmMKPiBpbmRleCA0NGQyMTk4MWJmM2IuLjQ5Njg4
NjdkYTdhNiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL2dwdV9zY2hl
ZHVsZXIuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvZ3B1X3NjaGVkdWxlci5j
Cj4gQEAgLTI3NiwxMCArMjc2LDEwIEBAIHZvaWQgZHJtX3NjaGVkX2VudGl0eV9jbGVhbnVwKHN0
cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAqc2NoZWQsCj4gICAJCQllbHNlIGlmIChyKQo+ICAgCQkJ
CURSTV9FUlJPUigiZmVuY2UgYWRkIGNhbGxiYWNrIGZhaWxlZCAoJWQpXG4iLCByKTsKPiAgIAkJ
fQo+IC0KPiAtCQlkbWFfZmVuY2VfcHV0KGVudGl0eS0+bGFzdF9zY2hlZHVsZWQpOwo+IC0JCWVu
dGl0eS0+bGFzdF9zY2hlZHVsZWQgPSBOVUxMOwo+ICAgCX0KPiArCj4gKwlkbWFfZmVuY2VfcHV0
KGVudGl0eS0+bGFzdF9zY2hlZHVsZWQpOwo+ICsJZW50aXR5LT5sYXN0X3NjaGVkdWxlZCA9IE5V
TEw7Cj4gICB9Cj4gICBFWFBPUlRfU1lNQk9MKGRybV9zY2hlZF9lbnRpdHlfY2xlYW51cCk7Cj4g
ICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
