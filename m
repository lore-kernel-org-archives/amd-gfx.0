From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: resvert "disable bulk moves for now"
Date: Thu, 12 Sep 2019 17:13:31 +0200
Message-ID: <df915c16-198d-502d-6eed-975a0471ec13@gmail.com>
References: <20190912101535.71686-1-christian.koenig@amd.com>
 <f0b19f35-5852-8cbe-2256-e769169d8884@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f0b19f35-5852-8cbe-2256-e769169d8884-5C7GfCeVMHo@public.gmane.org>
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
To: Chunming Zhou <zhoucm1-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SnVzdCB0byBkb3VibGUgY2hlY2s6IFdlIGRvIGhhdmUgdGhhdCBlbmFibGVkIGluIHRoZSBES01T
IHBhY2thZ2UgZm9yIGEgCndoaWxlIGFuZCBkb2Vzbid0IGVuY291bnRlciBhbnkgbW9yZSBwcm9i
bGVtcyB3aXRoIGl0LCBjb3JyZWN0PwoKVGhhbmtzLApDaHJpc3RpYW4uCgpBbSAxMi4wOS4xOSB1
bSAxNjowMiBzY2hyaWViIENodW5taW5nIFpob3U6Cj4gUkIgb24gaXQgdG8gZ28gYWhlYWQuCj4K
PiAtRGF2aWQKPgo+IOWcqCAyMDE5LzkvMTIgMTg6MTUsIENocmlzdGlhbiBLw7ZuaWcg5YaZ6YGT
Ogo+PiBUaGlzIHJldmVydHMgY29tbWl0IGEyMTNjMmM3ZTIzNWNmYzBlMGExNjFhNTU4ZjdmZGYy
ZmIzYTYyNGEuCj4+Cj4+IFRoZSBjaGFuZ2VzIHRvIGZpeCB0aGlzIHNob3VsZCBoYXZlIGxhbmRl
ZCBpbiA1LjEuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4KPj4gLS0tCj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bS5jIHwgMiAtLQo+PiAgICAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkK
Pj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4gaW5kZXggNDgzNDll
NGYwNzAxLi5mZDNmYmFhNzNmYTMgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jCj4+IEBAIC02MDMsMTQgKzYwMywxMiBAQCB2b2lkIGFtZGdwdV92bV9tb3ZlX3Rv
X2xydV90YWlsKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+PiAgICAJc3RydWN0IHR0bV9i
b19nbG9iYWwgKmdsb2IgPSBhZGV2LT5tbWFuLmJkZXYuZ2xvYjsKPj4gICAgCXN0cnVjdCBhbWRn
cHVfdm1fYm9fYmFzZSAqYm9fYmFzZTsKPj4gICAgCj4+IC0jaWYgMAo+PiAgICAJaWYgKHZtLT5i
dWxrX21vdmVhYmxlKSB7Cj4+ICAgIAkJc3Bpbl9sb2NrKCZnbG9iLT5scnVfbG9jayk7Cj4+ICAg
IAkJdHRtX2JvX2J1bGtfbW92ZV9scnVfdGFpbCgmdm0tPmxydV9idWxrX21vdmUpOwo+PiAgICAJ
CXNwaW5fdW5sb2NrKCZnbG9iLT5scnVfbG9jayk7Cj4+ICAgIAkJcmV0dXJuOwo+PiAgICAJfQo+
PiAtI2VuZGlmCj4+ICAgIAo+PiAgICAJbWVtc2V0KCZ2bS0+bHJ1X2J1bGtfbW92ZSwgMCwgc2l6
ZW9mKHZtLT5scnVfYnVsa19tb3ZlKSk7Cj4+ICAgIAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4
