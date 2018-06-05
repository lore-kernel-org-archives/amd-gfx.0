From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix clear_all and replace handling in the VM
Date: Tue, 5 Jun 2018 10:54:48 +0200
Message-ID: <5c0183aa-115b-f9c9-4159-5aaaa9a871c2@amd.com>
References: <20180604105952.72796-1-christian.koenig@amd.com>
 <96ad02c2-4792-a12e-3002-385f30140971@daenzer.net>
 <c9988a0c-9166-fb64-87d5-d848995e3e6d@gmail.com> <5B164E24.6080004@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5B164E24.6080004-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMDUuMDYuMjAxOCB1bSAxMDo0NyBzY2hyaWViIFpoYW5nLCBKZXJyeSAoSnVud2VpKToKPiBP
biAwNi8wNS8yMDE4IDA0OjQ1IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBbSAwNC4w
Ni4yMDE4IHVtIDEzOjAyIHNjaHJpZWIgTWljaGVsIETDpG56ZXI6Cj4+PiBPbiAyMDE4LTA2LTA0
IDEyOjU5IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4+IFdlIG5lZWQgdG8gcHV0IHRo
ZSBsb3NlIGVuZHMgb24gdGhlIGludmFsaWQgbGlzdCBiZWNhdXNlIGl0IGlzIAo+Pj4+IHBvc3Np
YmxlCj4+Pj4gdGhhdCB3ZSBuZWVkIHRvIHNwbGl0IHVwIGh1Z2UgcGFnZXMgZm9yIHRoZW0uCj4+
Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+Cj4+PiBEb2VzIHRoaXMgbmVlZCB0byBnbyB0byBzdGFibGU/Cj4+Cj4+IFllcywg
Z29vZCBwb2ludC4gSmVycnkgaWYgeW91IGhhdmVuJ3QgYWxyZWFkeSBjb21taXR0ZWQgeW91ciBm
b2xsb3cgCj4+IHVwIHBhdGNoCj4+IHRoZW4gcGxlYXNlIGFkZCBhICJDQzogc3RhYmxlQHZnZXIu
a2VybmVsLm9yZyIgdGFnIHRvIGl0Lgo+Cj4gU29ycnksIGl0IHdhcyBsYW5kZWQgaW4gZHJtLW5l
eHQuCj4gSG93IGNhbiBJIHNhdmUgdGhhdD8KCkluIHRoaXMgY2FzZSBBbGV4IG5lZWRzIHRvIGFk
ZCBpdCB3aGVuIGhlIHByZXBhcmVzIHRoZSBwYXRjaCBmb3IgcHVzaGluZyAKaXQgb3V0IGFzIGZp
eC4KCk9ubHkgYWx0ZXJuYXRpdmUgaXMgdGhhdCB5b3UgcmV2ZXJ0IGFuIHJlcHVzaCB0aGUgcGF0
Y2guCgpDaHJpc3RpYW4uCgo+Cj4gSmVycnkKPgo+Pgo+PiBUaGFua3MsCj4+IENocmlzdGlhbi4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
