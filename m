From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amdgpu: fix VA hole handling on Vega10
Date: Thu, 9 Nov 2017 17:15:14 +0100
Message-ID: <51edee33-3b9c-ac62-84de-9e7b57dfac4a@gmail.com>
References: <20171109144925.2913-1-christian.koenig@amd.com>
 <20171109144925.2913-4-christian.koenig@amd.com>
 <ebc6ec8d-4ea5-9080-fb27-a18e46f3740f@daenzer.net>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ebc6ec8d-4ea5-9080-fb27-a18e46f3740f-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMDkuMTEuMjAxNyB1bSAxNTo1OSBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDA5LzEx
LzE3IDAzOjQ5IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBTaW1pbGFyIHRvIHRoZSBD
UFUgYWRkcmVzcyBzcGFjZSB0aGUgVkEgb24gVmVnYTEwIGhhcyBhIGhvbGUgaW4gaXQuCj4gWy4u
Ll0KPgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dl
bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCj4+IGluZGV4IDQ3
MTBlNTEwOTljMi4uODFjMzQxMzJmYmQ1IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2dlbS5jCj4+IEBAIC01NjEsNiArNTYxLDE3IEBAIGludCBhbWRncHVfZ2VtX3Zh
X2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEsCj4+ICAgCQlyZXR1cm4g
LUVJTlZBTDsKPj4gICAJfQo+PiAgIAo+PiArCWlmIChhcmdzLT52YV9hZGRyZXNzID49IEFNREdQ
VV9WQV9IT0xFX1NUQVJUICYmCj4+ICsJICAgIGFyZ3MtPnZhX2FkZHJlc3MgPCBBTURHUFVfVkFf
SE9MRV9FTkQpIHsKPj4gKwkJZGV2X2VycigmZGV2LT5wZGV2LT5kZXYsCj4+ICsJCQkidmFfYWRk
cmVzcyAweCVMWCBpcyBpbiBWQSBob2xlIDB4JUxYLTB4JUxYXG4iLAo+PiArCQkJYXJncy0+dmFf
YWRkcmVzcywgQU1ER1BVX1ZBX0hPTEVfU1RBUlQsCj4+ICsJCQlBTURHUFVfVkFfSE9MRV9FTkQp
Owo+PiArCQlyZXR1cm4gLUVJTlZBTDsKPj4gKwl9Cj4gVGhpcyBzaG91bGQgcHJvYmFibHkgYmUg
ZGV2X2RiZyBpbnN0ZWFkIG9mIGRldl9lcnIsIHRvIHByZXZlbnQgYnVnZ3kgKG9yCj4gbWFsaWNp
b3VzKSB1c2Vyc3BhY2UgZnJvbSBzcGFtbWluZyBkbWVzZy4KCkdvb2QgcG9pbnQsIGFuZCB5ZXMg
d2UgaGF2ZSBxdWl0ZSBhIG51bWJlciBvZiBvdGhlciBpc3N1ZXMgbGlrZSB0aGF0IG9uZS4KCkdv
aW5nIHRvIGZpeCB0aGlzIGluIHYyIG9mIHRoZSBwYXRjaGVzLgoKQ2hyaXN0aWFuLgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
