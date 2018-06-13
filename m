From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix typo in amdgpu_mn.c comments
Date: Wed, 13 Jun 2018 17:01:23 +0200
Message-ID: <04485ce4-61e4-324f-5734-cd7c8fae7247@gmail.com>
References: <20180613145651.7352-1-slava.abramov@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180613145651.7352-1-slava.abramov-5C7GfCeVMHo@public.gmane.org>
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
To: Slava Abramov <slava.abramov-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTMuMDYuMjAxOCB1bSAxNjo1NiBzY2hyaWViIFNsYXZhIEFicmFtb3Y6Cj4gSW4gZG9jIGNv
bW1lbnRzIGZvciBzdHJ1Y3QgYW1kZ3B1X21uOiBkZXN0cnV0aW9uIC0+IGRlc3RydWN0aW9uCj4K
PiBTaWduZWQtb2ZmLWJ5OiBTbGF2YSBBYnJhbW92IDxzbGF2YS5hYnJhbW92QGFtZC5jb20+CgpH
b29kIGNhdGNoLCBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPi4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
bW4uYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9t
bi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21uLmMKPiBpbmRleCA0MTc5
MjNiYThkZTYuLmIyYTk3MTZmYTQxZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfbW4uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9tbi5jCj4gQEAgLTU4LDcgKzU4LDcgQEAKPiAgICAqIEBhZGV2OiBhbWRncHUgZGV2aWNl
IHBvaW50ZXIKPiAgICAqIEBtbTogcHJvY2VzcyBhZGRyZXNzIHNwYWNlCj4gICAgKiBAbW46IE1N
VSBub3RpZmllciBzdHJ1Y3R1cgo+IC0gKiBAd29yazogZGVzdHJ1dGlvbiB3b3JrIGl0ZW0KPiAr
ICogQHdvcms6IGRlc3RydWN0aW9uIHdvcmsgaXRlbQo+ICAgICogQG5vZGU6IGhhc2ggdGFibGUg
bm9kZSB0byBmaW5kIHN0cnVjdHVyZSBieSBhZGV2IGFuZCBtbgo+ICAgICogQGxvY2s6IHJ3IHNl
bWFwaG9yZSBwcm90ZWN0aW5nIHRoZSBub3RpZmllciBub2Rlcwo+ICAgICogQG9iamVjdHM6IGlu
dGVydmFsIHRyZWUgY29udGFpbmluZyBhbWRncHVfbW5fbm9kZXMKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
