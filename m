From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/amdgpu: fix evicted VRAM bo adjudgement
 condition
Date: Thu, 2 Nov 2017 18:35:56 +0100
Message-ID: <c392cfda-cad9-047c-7b36-4eed11063b59@gmail.com>
References: <1509618340-4524-1-git-send-email-Hongbo.He@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1509618340-4524-1-git-send-email-Hongbo.He-5C7GfCeVMHo@public.gmane.org>
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
To: Roger He <Hongbo.He-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMDIuMTEuMjAxNyB1bSAxMToyNSBzY2hyaWViIFJvZ2VyIEhlOgo+IENoYW5nZS1JZDogSWFj
MTNiMTNmYTEzNmQwY2U0ZmMyYTQwZDAxMGYwN2FhNWQxMWUzZjQKPiBTaWduZWQtb2ZmLWJ5OiBS
b2dlciBIZSA8SG9uZ2JvLkhlQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV90dG0uYyB8IDUgKy0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgNCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdHRtLmMKPiBpbmRleCBjN2NjZDZmLi5iZDdjNDI0IDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+IEBAIC0xMTY3LDkgKzExNjcsNiBAQCBzdGF0aWMg
Ym9vbCBhbWRncHVfdHRtX2JvX2V2aWN0aW9uX3ZhbHVhYmxlKHN0cnVjdCB0dG1fYnVmZmVyX29i
amVjdCAqYm8sCj4gICAJdW5zaWduZWQgbG9uZyBudW1fcGFnZXMgPSBiby0+bWVtLm51bV9wYWdl
czsKPiAgIAlzdHJ1Y3QgZHJtX21tX25vZGUgKm5vZGUgPSBiby0+bWVtLm1tX25vZGU7Cj4gICAK
PiAtCWlmIChiby0+bWVtLnN0YXJ0ICE9IEFNREdQVV9CT19JTlZBTElEX09GRlNFVCkKPiAtCQly
ZXR1cm4gdHRtX2JvX2V2aWN0aW9uX3ZhbHVhYmxlKGJvLCBwbGFjZSk7Cj4gLQo+ICAgCXN3aXRj
aCAoYm8tPm1lbS5tZW1fdHlwZSkgewo+ICAgCWNhc2UgVFRNX1BMX1RUOgo+ICAgCQlyZXR1cm4g
dHJ1ZTsKPiBAQCAtMTE4NCw3ICsxMTgxLDcgQEAgc3RhdGljIGJvb2wgYW1kZ3B1X3R0bV9ib19l
dmljdGlvbl92YWx1YWJsZShzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLAo+ICAgCQkJbnVt
X3BhZ2VzIC09IG5vZGUtPnNpemU7Cj4gICAJCQkrK25vZGU7Cj4gICAJCX0KPiAtCQlicmVhazsK
PiArCQlyZXR1cm4gZmFsc2U7Cj4gICAKPiAgIAlkZWZhdWx0Ogo+ICAgCQlicmVhazsKCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
