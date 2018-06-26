From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: allocate gart memory when it's required
Date: Tue, 26 Jun 2018 16:32:04 +0800
Message-ID: <5B31FA04.3050004@amd.com>
References: <1529992843-649-1-git-send-email-Jerry.Zhang@amd.com>
 <1529992843-649-2-git-send-email-Jerry.Zhang@amd.com>
 <87a2a6dc-e07c-d41f-0691-afa48d0f7925@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <87a2a6dc-e07c-d41f-0691-afa48d0f7925-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: christian.koenig-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDYvMjYvMjAxOCAwMzo0MiBQTSwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gT24gMjAxOC0w
Ni0yNiAwODowMCBBTSwgSnVud2VpIFpoYW5nIHdyb3RlOgo+PiBJbnN0ZWFkIG9mIGNhbGxpbmcg
Z2FydCBtZW1vcnkgb24gZXZlcnkgYm8gcGluLAo+PiBhbGxvY2F0ZXMgaXQgb24gZGVtYW5kCj4+
Cj4+IFNpZ25lZC1vZmYtYnk6IEp1bndlaSBaaGFuZyA8SmVycnkuWmhhbmdAYW1kLmNvbT4KPj4K
Pj4gWy4uLl0KPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kaXNwbGF5LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxh
eS5jCj4+IGluZGV4IDAzNmI2ZjcuLjBkMWM0YmUgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYwo+PiBAQCAtMTk0LDYgKzE5NCwxMiBAQCBpbnQg
YW1kZ3B1X2Rpc3BsYXlfY3J0Y19wYWdlX2ZsaXBfdGFyZ2V0KHN0cnVjdCBkcm1fY3J0YyAqY3J0
YywKPj4gICAJCWdvdG8gdW5yZXNlcnZlOwo+PiAgIAl9Cj4+Cj4+ICsJciA9IGFtZGdwdV90dG1f
YWxsb2NfZ2FydCgmbmV3X2Fiby0+dGJvKTsKPj4gKwlpZiAodW5saWtlbHkociAhPSAwKSkgewo+
PiArCQlEUk1fRVJST1IoIiVwIGJpbmQgZmFpbGVkXG4iLCBuZXdfYWJvKTsKPj4gKwkJZ290byB1
bnJlc2VydmU7Cj4+ICsJfQo+Cj4gVGhlIGVycm9yIGNhc2UgaGVyZSBhbHNvIG5lZWRzIHRvIHVu
cGluIHRoZSBCTywgb3RoZXJ3aXNlIHdlIGxlYWsgdGhlCj4gcGluLiBJIHN1c3BlY3QgdGhlIHNh
bWUgaXNzdWUgYXBwbGllcyB0byBhdCBsZWFzdCBzb21lIG9mIHRoZSBvdGhlcgo+IHBsYWNlcyBt
b2RpZmllZCBieSB0aGlzIHBhdGNoLgoKQWhhLCBJIGZlbHQgaW50byB0aGUgc2ltaWxhciBlcnJv
ci4KCndpbGwgdXBkYXRlIHYyIGFuZCBmaW5kIG9uZSBtb3JlIHVucGluIGlzc3VlIGZvciBibyBj
cmVhdGlvbiBpbiBwYXRjaCAzLgoKSmVycnkKPgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
