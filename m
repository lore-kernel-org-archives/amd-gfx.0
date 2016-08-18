From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amdgpu: allow pagelist to be NULL for
 amdgpu_gart_bind
Date: Thu, 18 Aug 2016 10:02:15 +0200
Message-ID: <d40d0278-6b64-a9aa-bac2-30ce8eb4d974@vodafone.de>
References: <1471489102-31630-1-git-send-email-Flora.Cui@amd.com>
 <1471489102-31630-2-git-send-email-Flora.Cui@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1471489102-31630-2-git-send-email-Flora.Cui-5C7GfCeVMHo@public.gmane.org>
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

VGhpcyBmdW5jdGlvbiBpcyBuZXZlciBjYWxsZWQgd2l0aG91dCBhIHBhZ2VsaXN0IGF0IHRoZSBt
b21lbnQuCgpTbyB0aGVyZSBpcyBubyBqdXN0aWZpY2F0aW9uIGZvciB0aGlzIGNoYW5nZS4KCkNo
cmlzdGlhbi4KCkFtIDE4LjA4LjIwMTYgdW0gMDQ6NTggc2NocmllYiBGbG9yYSBDdWk6Cj4gU2ln
bmVkLW9mZi1ieTogRmxvcmEgQ3VpIDxGbG9yYS5DdWlAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nYXJ0LmMgfCAyICstCj4gICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2FydC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2dhcnQuYwo+IGluZGV4IDBmZWVhMzQuLjAzYjlmZDYgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dhcnQuYwo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nYXJ0LmMKPiBAQCAtMjg3LDcgKzI4Nyw3
IEBAIGludCBhbWRncHVfZ2FydF9iaW5kKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1aW50
NjRfdCBvZmZzZXQsCj4gICAKPiAgIAlmb3IgKGkgPSAwOyBpIDwgcGFnZXM7IGkrKywgcCsrKSB7
Cj4gICAjaWZkZWYgQ09ORklHX0FNREdQVV9HQVJUX0RFQlVHRlMKPiAtCQlhZGV2LT5nYXJ0LnBh
Z2VzW3BdID0gcGFnZWxpc3RbaV07Cj4gKwkJYWRldi0+Z2FydC5wYWdlc1twXSA9IHBhZ2VsaXN0
ID8gcGFnZWxpc3RbaV0gOiBOVUxMOwo+ICAgI2VuZGlmCj4gICAJCWlmIChhZGV2LT5nYXJ0LnB0
cikgewo+ICAgCQkJcGFnZV9iYXNlID0gZG1hX2FkZHJbaV07CgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
