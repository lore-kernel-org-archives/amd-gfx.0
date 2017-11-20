From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: regression in suspend/resume on Polaris
Date: Mon, 20 Nov 2017 08:40:22 -0500
Message-ID: <9e24f233-0c70-0523-669c-3f7fc60585b7@amd.com>
References: <abd84787-4ba4-0a98-d17e-86a1e1467d8c@amd.com>
 <d558b4ac-d533-ca09-3bf1-918a0f41370b@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d558b4ac-d533-ca09-3bf1-918a0f41370b-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Liu, Monk" <monk.liu-5C7GfCeVMHo@public.gmane.org>

VGhhdCBwYXRjaCBzZWVtcyB0byB3b3JrIGZvciBtZS4KCk9uIDIwLzExLzE3IDA4OjIxIEFNLCBD
aHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IFllYWgsIGtub3duIGlzc3VlLiBTZWUgdGhlIHByb3Bv
c2VkIHBhdGNoIGZyb20gTW9uayBhYm91dCBwYXJ0aWFsbHkgCj4gcmV2ZXJ0aW5nIHRoaXMgY29t
bWl0Lgo+IAo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+IAo+IEFtIDIwLjExLjIwMTcgdW0gMTQ6
MTggc2NocmllYiBUb20gU3QgRGVuaXM6Cj4+IEhpLAo+Pgo+PiBUaGlzIGNvbW1pdCBjYXVzZXMg
YSBmYWlsdXJlIChhdHRhY2hlZCkgb24gcmVzdW1lIHdpdGggYSBQb2xhcmlzMTAgCj4+IGRldmlj
ZSBpbnN0YWxsZWQgKGR1cmluZyB1dmQgdmlkZW8gcGxheWJhY2spLgo+Pgo+PiBjb21taXQgMWNm
ZDhlMjM3ZjAzMThlMzMwMTkwYWMyMWQ2M2M1OGFlNmExZjY2YyAoSEVBRCwgcmVmcy9iaXNlY3Qv
YmFkKQo+PiBBdXRob3I6IE1vbmsgTGl1IDxNb25rLkxpdUBhbWQuY29tPgo+PiBEYXRlOsKgwqAg
VHVlIE5vdiAxNCAxMTo1MjozNSAyMDE3ICswODAwCj4+Cj4+IMKgwqDCoCBkcm0vYW1kZ3B1OmNs
ZWFudXAgR01DICYgZ2FydCBnYXJiYWdlIGZ1bmN0aW9uCj4+Cj4+IMKgwqDCoCBmb3IgZ2FydF9y
YW1fYWxsb2MvZnJlZSwgdGhleSBhcmUgbmV2ZXIgdXNlZCBpbiBkcml2ZXIgdGh1cwo+PiDCoMKg
wqAgcmlwZSB0aGVtIG91dCB0b3RhbGx5Lgo+Pgo+PiDCoMKgwqAgZm9yIGdhcnRfdnJhbV9waW4v
dW5waW4sIHRoZXkgYXJlIG5vdCBuZWVkZWQgYmVjdWFzZSB3ZSBjYW4KPj4gwqDCoMKgIHVzZSBi
b19jcmVhdF9rZXJuZWwvZnJlZSB0byByZXBsYWNlIHRoZSBvcmlnaW5hbCBtYW51YWwgd2F5Cj4+
IMKgwqDCoCBpbiB0aGUgZ2FydF92cmFtX2FsbG9jL2ZyZWUsIHRodXMgZ2FydF92cmFtX3Bpbi91
bnBpbiBjYW4KPj4gwqDCoMKgIGFsc28gYmUgcmlwZWQgb3V0Lgo+Pgo+PiDCoMKgwqAgQ2hhbmdl
LUlkOiBJYzYwOTQ5YjU5ZDhiMzYzZTUxOTlmNmMxMWQ5ZWE0YTE1ZWM1NzUxOQo+PiDCoMKgwqAg
U2lnbmVkLW9mZi1ieTogTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+Cj4+IMKgwqDCoCBSZXZp
ZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+Pgo+
PiBDaGVlcnMsCj4+IFRvbQo+IAo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
