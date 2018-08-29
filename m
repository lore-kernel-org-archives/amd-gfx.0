From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: remove redundant memset
Date: Wed, 29 Aug 2018 17:05:56 +0200
Message-ID: <d310f46e-3c6d-175a-ca85-9c941c0f95f2@gmail.com>
References: <1535554880-1503-1-git-send-email-Philip.Yang@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1535554880-1503-1-git-send-email-Philip.Yang-5C7GfCeVMHo@public.gmane.org>
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

QW0gMjkuMDguMjAxOCB1bSAxNzowMSBzY2hyaWViIFBoaWxpcCBZYW5nOgo+IENoYW5nZS1JZDog
SWY5NGE1OWQzY2JmMjY5MGRkMmExZTJhZGQ3MWJjMzkzZGY2YTk2ODYKPiBTaWduZWQtb2ZmLWJ5
OiBQaGlsaXAgWWFuZyA8UGhpbGlwLllhbmdAYW1kLmNvbT4KCllvdSBuZWVkIHRvIGFkZCBhIGNv
bW1pdCBtZXNzYWdlLCBleHBsYWluaW5nIHdoeSB0aGF0IGNhbiBiZSByZW1vdmVkLgoKV2l0aCB0
aGF0IGRvbmUgdGhlIHBhdGNoIGlzIFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIAo8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPi4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4gLS0tCj4gICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDEgLQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bS5jCj4gaW5kZXggMTUzYzliZS4uMzNkOWNlMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jCj4gQEAgLTU0MCw3ICs1NDAsNiBAQCBzdGF0aWMgaW50IGFtZGdwdV92
bV9hbGxvY19sZXZlbHMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJCQkJCQkgICBH
RlBfS0VSTkVMIHwgX19HRlBfWkVSTyk7Cj4gICAJCWlmICghcGFyZW50LT5lbnRyaWVzKQo+ICAg
CQkJcmV0dXJuIC1FTk9NRU07Cj4gLQkJbWVtc2V0KHBhcmVudC0+ZW50cmllcywgMCAsIHNpemVv
ZihzdHJ1Y3QgYW1kZ3B1X3ZtX3B0KSk7Cj4gICAJfQo+ICAgCj4gICAJZnJvbSA9IHNhZGRyID4+
IHNoaWZ0OwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
