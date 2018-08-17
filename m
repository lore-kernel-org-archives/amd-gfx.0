From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix VM clearing for the root PD
Date: Fri, 17 Aug 2018 12:05:00 -0400
Message-ID: <c505bf70-5590-0315-e04b-7075bbda6d2a@amd.com>
References: <20180817122422.1384-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180817122422.1384-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wOC0xNyAwODoyNCBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBXZSBuZWVk
IHRvIGZpZ3VyZSBvdXQgdGhlIGFkZHJlc3MgYWZ0ZXIgdmFsaWRhdGluZyB0aGUgQk8sIG5vdCBi
ZWZvcmUuCj4KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+ClJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdA
YW1kLmNvbT4KCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5j
IHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gaW5kZXggNjYyZThhMzRk
NTJjLi42NjJhZWM1YzgxZDQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYwo+IEBAIC0zNjksNyArMzY5LDYgQEAgc3RhdGljIGludCBhbWRncHVfdm1fY2xlYXJfYm8o
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gIAl1aW50NjRfdCBhZGRyOwo+ICAJaW50IHI7
Cj4gIAo+IC0JYWRkciA9IGFtZGdwdV9ib19ncHVfb2Zmc2V0KGJvKTsKPiAgCWVudHJpZXMgPSBh
bWRncHVfYm9fc2l6ZShibykgLyA4Owo+ICAKPiAgCWlmIChwdGVfc3VwcG9ydF9hdHMpIHsKPiBA
QCAtNDAxLDYgKzQwMCw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2NsZWFyX2JvKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LAo+ICAJaWYgKHIpCj4gIAkJZ290byBlcnJvcjsKPiAgCj4gKwlh
ZGRyID0gYW1kZ3B1X2JvX2dwdV9vZmZzZXQoYm8pOwo+ICAJaWYgKGF0c19lbnRyaWVzKSB7Cj4g
IAkJdWludDY0X3QgYXRzX3ZhbHVlOwo+ICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
