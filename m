From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: set the executable flag on unused Vega10
 PTEs
Date: Thu, 3 Jan 2019 09:19:18 +0100
Message-ID: <e99293f9-c7f3-4177-9343-fd6003e55402@gmail.com>
References: <20190102133506.110324-1-christian.koenig@amd.com>
 <20190102133506.110324-2-christian.koenig@amd.com>
 <28ccb2db-f54f-110a-dd7e-89c38a8bed81@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <28ccb2db-f54f-110a-dd7e-89c38a8bed81-5C7GfCeVMHo@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T2gsIGdvb2QgcG9pbnQuIENvbXBsZXRlbHkgZm9yZ290IGFib3V0IHRob3NlLgoKR29pbmcgdG8g
Zml4IHRoZSBwYXRjaCwKQ2hyaXN0aWFuLgoKQW0gMDIuMDEuMTkgdW0gMjE6MjYgc2NocmllYiBL
dWVobGluZywgRmVsaXg6Cj4gRG9uJ3QgeW91IG5lZWQgdG8gdXBkYXRlIGFtZGdwdV92bV9jbGVh
cl9mcmVlZCBhcyB3ZWxsPwo+Cj4gUmVnYXJkcywKPiAgwqAgRmVsaXgKPgo+IE9uIDIwMTktMDEt
MDIgODozNSBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBPdGhlcndpc2Ugd2UgcnVu
IGludG8gYSBub24tcmV0cnkgZmF1bHQgb24gYWNjZXNzLgo+Pgo+PiBJdCBzZWVtcyB0byBiZSBh
IGhhcmR3YXJlIGJ1ZyB0aGF0IHRoZSBleGVjdXRhYmxlIGJpdCBoYXMKPj4gaGlnaGVyIHByaW9y
aXR5IHRoYW4gdGhlIHZhbGlkIGJpdC4KPj4KPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvD
tm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+PiAtLS0KPj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDEwICsrKysrKysrLS0KPj4gICAxIGZpbGUgY2hh
bmdlZCwgOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+PiBpbmRleCBlNzNkMTUyNjU5YTIuLjAxYTY4ZjRlMTdk
NCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMK
Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4gQEAgLTc5
OSw5ICs3OTksMTUgQEAgc3RhdGljIGludCBhbWRncHVfdm1fY2xlYXJfYm8oc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsCj4+ICAgCQlhZGRyICs9IGF0c19lbnRyaWVzICogODsKPj4gICAJfQo+
PiAgIAo+PiAtCWlmIChlbnRyaWVzKQo+PiArCWlmIChlbnRyaWVzKSB7Cj4+ICsJCXVpbnQ2NF90
IHZhbHVlID0gMDsKPj4gKwo+PiArCQlpZiAobGV2ZWwgPT0gQU1ER1BVX1ZNX1BUQiAmJiBhZGV2
LT5hc2ljX3R5cGUgPj0gQ0hJUF9WRUdBMTApCj4+ICsJCQl2YWx1ZSA9IEFNREdQVV9QVEVfRVhF
Q1VUQUJMRTsKPj4gKwo+PiAgIAkJYW1kZ3B1X3ZtX3NldF9wdGVfcGRlKGFkZXYsICZqb2ItPmli
c1swXSwgYWRkciwgMCwKPj4gLQkJCQkgICAgICBlbnRyaWVzLCAwLCAwKTsKPj4gKwkJCQkgICAg
ICBlbnRyaWVzLCAwLCB2YWx1ZSk7Cj4+ICsJfQo+PiAgIAo+PiAgIAlhbWRncHVfcmluZ19wYWRf
aWIocmluZywgJmpvYi0+aWJzWzBdKTsKPj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
