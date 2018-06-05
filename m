From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix clear_all and replace handling in the VM
Date: Tue, 5 Jun 2018 17:01:03 +0800
Message-ID: <5B16514F.8070806@amd.com>
References: <20180604105952.72796-1-christian.koenig@amd.com>
 <96ad02c2-4792-a12e-3002-385f30140971@daenzer.net>
 <c9988a0c-9166-fb64-87d5-d848995e3e6d@gmail.com> <5B164E24.6080004@amd.com>
 <5c0183aa-115b-f9c9-4159-5aaaa9a871c2@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5c0183aa-115b-f9c9-4159-5aaaa9a871c2-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDYvMDUvMjAxOCAwNDo1NCBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAwNS4w
Ni4yMDE4IHVtIDEwOjQ3IHNjaHJpZWIgWmhhbmcsIEplcnJ5IChKdW53ZWkpOgo+PiBPbiAwNi8w
NS8yMDE4IDA0OjQ1IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4gQW0gMDQuMDYuMjAx
OCB1bSAxMzowMiBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+Pj4+IE9uIDIwMTgtMDYtMDQgMTI6
NTkgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+Pj4+IFdlIG5lZWQgdG8gcHV0IHRoZSBs
b3NlIGVuZHMgb24gdGhlIGludmFsaWQgbGlzdCBiZWNhdXNlIGl0IGlzIHBvc3NpYmxlCj4+Pj4+
IHRoYXQgd2UgbmVlZCB0byBzcGxpdCB1cCBodWdlIHBhZ2VzIGZvciB0aGVtLgo+Pj4+Pgo+Pj4+
PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+Cj4+Pj4gRG9lcyB0aGlzIG5lZWQgdG8gZ28gdG8gc3RhYmxlPwo+Pj4KPj4+IFllcywgZ29v
ZCBwb2ludC4gSmVycnkgaWYgeW91IGhhdmVuJ3QgYWxyZWFkeSBjb21taXR0ZWQgeW91ciBmb2xs
b3cgdXAgcGF0Y2gKPj4+IHRoZW4gcGxlYXNlIGFkZCBhICJDQzogc3RhYmxlQHZnZXIua2VybmVs
Lm9yZyIgdGFnIHRvIGl0Lgo+Pgo+PiBTb3JyeSwgaXQgd2FzIGxhbmRlZCBpbiBkcm0tbmV4dC4K
Pj4gSG93IGNhbiBJIHNhdmUgdGhhdD8KPgo+IEluIHRoaXMgY2FzZSBBbGV4IG5lZWRzIHRvIGFk
ZCBpdCB3aGVuIGhlIHByZXBhcmVzIHRoZSBwYXRjaCBmb3IgcHVzaGluZyBpdCBvdXQKPiBhcyBm
aXguCj4KPiBPbmx5IGFsdGVybmF0aXZlIGlzIHRoYXQgeW91IHJldmVydCBhbiByZXB1c2ggdGhl
IHBhdGNoLgoKT0ssIEkgcHJlZmVyIHRvIHJldmVydCBhbmQgcmVwdXNoLCBhdm9pZGluZyB0byBp
bmNyZWFzZSBtb3JlIHRvZG8gaXRlbXMgZm9yIEFsZXggCmdvaW5nIHVwc3RyZWFtLgoKSmVycnkK
Cj4KPiBDaHJpc3RpYW4uCj4KPj4KPj4gSmVycnkKPj4KPj4+Cj4+PiBUaGFua3MsCj4+PiBDaHJp
c3RpYW4uCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
