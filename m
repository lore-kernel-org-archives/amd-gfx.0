From: Chunming Zhou <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: release the VM shadow in the error path
 as well
Date: Mon, 5 Feb 2018 11:03:45 +0800
Message-ID: <989b5c50-85c4-d226-5292-5b86e9316439@amd.com>
References: <20180202201737.12266-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180202201737.12266-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

VGhlIHNlcmllcyBpcyBSZXZpZXdlZC1ieTogQ2h1bm1pbmcgWmhvdSA8ZGF2aWQxLnpob3VAYW1k
LmNvbT4KCgpPbiAyMDE45bm0MDLmnIgwM+aXpSAwNDoxNywgQ2hyaXN0aWFuIEvDtm5pZyB3cm90
ZToKPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8
IDIgKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gaW5kZXggNjFjZjkzODY3YjhlLi5iNDMwOThmMDJh
NDAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+IEBAIC00MTEs
NiArNDExLDcgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYWxsb2NfbGV2ZWxzKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2LAo+ICAgCj4gICAJCQlyID0gYW1kZ3B1X3ZtX2NsZWFyX2JvKGFkZXYs
IHZtLCBwdCwgbGV2ZWwsIGF0cyk7Cj4gICAJCQlpZiAocikgewo+ICsJCQkJYW1kZ3B1X2JvX3Vu
cmVmKCZwdC0+c2hhZG93KTsKPiAgIAkJCQlhbWRncHVfYm9fdW5yZWYoJnB0KTsKPiAgIAkJCQly
ZXR1cm4gcjsKPiAgIAkJCX0KPiBAQCAtNDE4LDYgKzQxOSw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1
X3ZtX2FsbG9jX2xldmVscyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgIAkJCWlmICh2
bS0+dXNlX2NwdV9mb3JfdXBkYXRlKSB7Cj4gICAJCQkJciA9IGFtZGdwdV9ib19rbWFwKHB0LCBO
VUxMKTsKPiAgIAkJCQlpZiAocikgewo+ICsJCQkJCWFtZGdwdV9ib191bnJlZigmcHQtPnNoYWRv
dyk7Cj4gICAJCQkJCWFtZGdwdV9ib191bnJlZigmcHQpOwo+ICAgCQkJCQlyZXR1cm4gcjsKPiAg
IAkJCQl9CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
