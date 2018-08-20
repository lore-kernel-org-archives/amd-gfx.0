From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix VM clearing for the root PD
Date: Mon, 20 Aug 2018 09:25:25 +0800
Message-ID: <5B7A1885.2060703@amd.com>
References: <20180817122422.1384-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180817122422.1384-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDgvMTcvMjAxOCAwODoyNCBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBXZSBuZWVk
IHRvIGZpZ3VyZSBvdXQgdGhlIGFkZHJlc3MgYWZ0ZXIgdmFsaWRhdGluZyB0aGUgQk8sIG5vdCBi
ZWZvcmUuCj4KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+ClJldmlld2VkLWJ5OiBKdW53ZWkgWmhhbmcgPEplcnJ5LlpoYW5nQGFtZC5j
b20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCAy
ICstCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gaW5kZXggNjYyZThhMzRkNTJj
Li42NjJhZWM1YzgxZDQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
Ywo+IEBAIC0zNjksNyArMzY5LDYgQEAgc3RhdGljIGludCBhbWRncHVfdm1fY2xlYXJfYm8oc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJdWludDY0X3QgYWRkcjsKPiAgIAlpbnQgcjsK
Pgo+IC0JYWRkciA9IGFtZGdwdV9ib19ncHVfb2Zmc2V0KGJvKTsKPiAgIAllbnRyaWVzID0gYW1k
Z3B1X2JvX3NpemUoYm8pIC8gODsKPgo+ICAgCWlmIChwdGVfc3VwcG9ydF9hdHMpIHsKPiBAQCAt
NDAxLDYgKzQwMCw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2NsZWFyX2JvKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2LAo+ICAgCWlmIChyKQo+ICAgCQlnb3RvIGVycm9yOwo+Cj4gKwlhZGRy
ID0gYW1kZ3B1X2JvX2dwdV9vZmZzZXQoYm8pOwo+ICAgCWlmIChhdHNfZW50cmllcykgewo+ICAg
CQl1aW50NjRfdCBhdHNfdmFsdWU7Cj4KPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
