From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: calc addr with domain's gpu_offset
Date: Fri, 9 Sep 2016 09:18:47 +0200
Message-ID: <7b7de55b-a83c-618f-d91a-2174e850d521@vodafone.de>
References: <1473402651-2395-1-git-send-email-Flora.Cui@amd.com>
 <1473402651-2395-2-git-send-email-Flora.Cui@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1473402651-2395-2-git-send-email-Flora.Cui-5C7GfCeVMHo@public.gmane.org>
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
To: Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

TkFLLCB0aGF0IGlzIGNsZWFybHkgaW5jb3JyZWN0LiBUaGUgZ3B1X29mZnNldCBhcmUgTUMgYWRk
cmVzc2VzIHdoaWxlIAp0aGUgdnJhbV9iYXNlX29mZnNldCBpcyBhIGJ1ZCBhZGRyZXNzLgoKTW9z
dCBvZiB0aGUgdGltZSB0aGV5IGFyZSBib3RoIHplcm8sIGV4Y2VwdCBmb3IgQVBVcyB3aGljaCB3
b3VsZCBicmVhayAKd2l0aCB0aGlzIGNoYW5nZS4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCkFtIDA5
LjA5LjIwMTYgdW0gMDg6MzAgc2NocmllYiBGbG9yYSBDdWk6Cj4gQ2hhbmdlLUlkOiBJODExMmU5
ZDg1ODY2MTA0NTU5ZWNlZjc0NDlmNTBmYmI5NDE2NzM4Mgo+IFNpZ25lZC1vZmYtYnk6IEZsb3Jh
IEN1aSA8RmxvcmEuQ3VpQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm0uYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMK
PiBpbmRleCBhNTQ5YWJkLi4zZDdhM2FiIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZtLmMKPiBAQCAtMTE1MSw3ICsxMTUxLDcgQEAgaW50IGFtZGdwdV92bV9ib191cGRh
dGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJCQlicmVhazsKPiAgIAo+ICAgCQlj
YXNlIFRUTV9QTF9WUkFNOgo+IC0JCQlhZGRyICs9IGFkZXYtPnZtX21hbmFnZXIudnJhbV9iYXNl
X29mZnNldDsKPiArCQkJYWRkciArPSBib192YS0+Ym8tPnRiby5iZGV2LT5tYW5bbWVtLT5tZW1f
dHlwZV0uZ3B1X29mZnNldDsKPiAgIAkJCWJyZWFrOwo+ICAgCj4gICAJCWRlZmF1bHQ6CgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
