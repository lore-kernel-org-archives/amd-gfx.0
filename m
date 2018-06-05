From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix clear_all and replace handling in the VM
Date: Tue, 5 Jun 2018 16:47:32 +0800
Message-ID: <5B164E24.6080004@amd.com>
References: <20180604105952.72796-1-christian.koenig@amd.com>
 <96ad02c2-4792-a12e-3002-385f30140971@daenzer.net>
 <c9988a0c-9166-fb64-87d5-d848995e3e6d@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c9988a0c-9166-fb64-87d5-d848995e3e6d-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, =?UTF-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDYvMDUvMjAxOCAwNDo0NSBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAwNC4w
Ni4yMDE4IHVtIDEzOjAyIHNjaHJpZWIgTWljaGVsIETDpG56ZXI6Cj4+IE9uIDIwMTgtMDYtMDQg
MTI6NTkgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBXZSBuZWVkIHRvIHB1dCB0aGUg
bG9zZSBlbmRzIG9uIHRoZSBpbnZhbGlkIGxpc3QgYmVjYXVzZSBpdCBpcyBwb3NzaWJsZQo+Pj4g
dGhhdCB3ZSBuZWVkIHRvIHNwbGl0IHVwIGh1Z2UgcGFnZXMgZm9yIHRoZW0uCj4+Pgo+Pj4gU2ln
bmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+
PiBEb2VzIHRoaXMgbmVlZCB0byBnbyB0byBzdGFibGU/Cj4KPiBZZXMsIGdvb2QgcG9pbnQuIEpl
cnJ5IGlmIHlvdSBoYXZlbid0IGFscmVhZHkgY29tbWl0dGVkIHlvdXIgZm9sbG93IHVwIHBhdGNo
Cj4gdGhlbiBwbGVhc2UgYWRkIGEgIkNDOiBzdGFibGVAdmdlci5rZXJuZWwub3JnIiB0YWcgdG8g
aXQuCgpTb3JyeSwgaXQgd2FzIGxhbmRlZCBpbiBkcm0tbmV4dC4KSG93IGNhbiBJIHNhdmUgdGhh
dD8KCkplcnJ5Cgo+Cj4gVGhhbmtzLAo+IENocmlzdGlhbi4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
