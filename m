From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: remove redundant memset
Date: Wed, 29 Aug 2018 17:15:49 +0200
Message-ID: <1905af18-697d-edb6-584c-412d8be963e8@gmail.com>
References: <1535555623-2177-1-git-send-email-Philip.Yang@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1535555623-2177-1-git-send-email-Philip.Yang-5C7GfCeVMHo@public.gmane.org>
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
To: Philip Yang <Philip.Yang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjkuMDguMjAxOCB1bSAxNzoxMyBzY2hyaWViIFBoaWxpcCBZYW5nOgo+IGt2bWFsbG9jX2Fy
cmF5IHVzZXMgX19HRlBfWkVSTyBmbGFnIGVuc3VyZXMgdGhhdCB0aGUgcmV0dXJuZWQgYWRkcmVz
cwo+IGlzIHplcm9lZCBhbHJlYWR5LCBtZW1zZXQgaXQgdG8gemVybyBhZ2FpbiBhZnRlcndhcmRz
IGlzIHVubmVjZXNzYXJ5CgphbmQgaW4gdGhpcyBjYXNlIGJ1Z2d5IGJlY2F1c2Ugd2Ugb25seSBj
bGVhciB0aGUgZmlyc3QgZW50cnkuCgo+Cj4gQ2hhbmdlLUlkOiBJZjk0YTU5ZDNjYmYyNjkwZGQy
YTFlMmFkZDcxYmMzOTNkZjZhOTY4Ngo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcCBZYW5nIDxQaGls
aXAuWWFuZ0BhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdm0uYyB8IDEgLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gaW5kZXggMTUzYzliZS4uMzNkOWNl
MiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gQEAgLTU0MCw3
ICs1NDAsNiBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9hbGxvY19sZXZlbHMoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsCj4gICAJCQkJCQkgICBHRlBfS0VSTkVMIHwgX19HRlBfWkVSTyk7Cj4g
ICAJCWlmICghcGFyZW50LT5lbnRyaWVzKQo+ICAgCQkJcmV0dXJuIC1FTk9NRU07Cj4gLQkJbWVt
c2V0KHBhcmVudC0+ZW50cmllcywgMCAsIHNpemVvZihzdHJ1Y3QgYW1kZ3B1X3ZtX3B0KSk7Cj4g
ICAJfQo+ICAgCj4gICAJZnJvbSA9IHNhZGRyID4+IHNoaWZ0OwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
