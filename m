From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: new KASAN running piglit
Date: Wed, 18 Jul 2018 18:39:03 +0200
Message-ID: <a446f9f0-a89b-0e74-46a7-ed5d5ceb4544@amd.com>
References: <2600416c-1f85-0d9d-06ad-a3d12e1fde70@amd.com>
 <94969afa-5d7c-b1c5-cee5-28df3d2c7226@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <94969afa-5d7c-b1c5-cee5-28df3d2c7226-5C7GfCeVMHo@public.gmane.org>
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
To: Tom St Denis <tstdenis-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

R29pbmcgdG8gaW52ZXN0aWdhdGUuCgpCdXQgYW55IGlkZWEgd2h5IHRoZSBiYWNrdHJhY2UgY29u
dGFpbnMgb25seSAiPyIgZW50cmllcz8KCkNocmlzdGlhbi4KCkFtIDE4LjA3LjIwMTggdW0gMTg6
MDkgc2NocmllYiBUb20gU3QgRGVuaXM6Cj4gSGVyZSdzIHRoZSBkbWVzZyBJIHNob3VsZCBoYXZl
IGF0dGFjaGVkIC4uLgo+Cj4gVG9tCj4KPiBPbiAwNy8xOC8yMDE4IDEyOjA1IFBNLCBUb20gU3Qg
RGVuaXMgd3JvdGU6Cj4+IEhpIENocmlzdGlhbiwKPj4KPj4gVGhpcyBwYXRjaDoKPj4KPj4gW3Jv
b3RAcmF2ZW4gbGludXhdIyBnaXQgYmlzZWN0IGJhZAo+PiA5MGYzNjJiZGYwZDBkMDZhMTI2YTVm
ZDM1YjA4NDQzNmRkODI1MGFkIGlzIHRoZSBmaXJzdCBiYWQgY29tbWl0Cj4+IGNvbW1pdCA5MGYz
NjJiZGYwZDBkMDZhMTI2YTVmZDM1YjA4NDQzNmRkODI1MGFkCj4+IEF1dGhvcjogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+PiBEYXRlOsKgwqAgTW9uIEp1bCAx
NiAxNDo1ODo0OCAyMDE4ICswMjAwCj4+Cj4+IMKgwqDCoMKgIGRybS9hbWRncHU6IGNoYW5nZSBy
aW5nIHByaW9yaXR5IGFmdGVyIHB1c2hpbmcgdGhlIGpvYgo+Pgo+PiDCoMKgwqDCoCBQdXNoaW5n
IGEgam9iIGNhbiBjaGFuZ2UgdGhlIHJpbmcgYXNzaWdubWVudCBvZiBhbiBlbnRpdHkuCj4+Cj4+
IMKgwqDCoMKgIFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4KPj4gwqDCoMKgwqAgUmV2aWV3ZWQtYnk6IENodW5taW5nIFpob3UgPGRhdmlk
MS56aG91QGFtZC5jb20+Cj4+Cj4+IDowNDAwMDAgMDQwMDAwIDlhMDlkM2U5ZDA1NWU0ZjUwMjQw
MTk4NjFjMzM0ZWU5Y2MwYmQxMWIgCj4+IDUyMjU0MGMzMWMzZDFhNGY0YTZmYmFjNzVlOTg1ZTlh
N2Y3ZTkzYzkgTcKgwqDCoMKgwqAgZHJpdmVycwo+Pgo+PiBjYXVzZXMgYSBLQVNBTiB3aGlsZSBy
dW5uaW5nIHBpZ2xpdC7CoCBJdCdzIHJlcHJvZHVjZWFibGUgMTAwJSBvZiB0aGUgCj4+IHRpbWUu
wqAgVGhlIGNvbW1pdCBiZWZvcmUgdGhpcyBkb2Vzbid0IG5vdCBjYXVzZSBhIEtBU0FOLgo+Pgo+
PiBUb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
