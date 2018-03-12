From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re:
 linux-4.16-rc5/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c:1723]:
 (warning) Possible null pointer dereference: pipe_ctx
Date: Mon, 12 Mar 2018 18:23:22 -0400
Message-ID: <8b55ac58-ae20-7662-10bb-c446701cd67e@amd.com>
References: <HE1PR0802MB2331D43DAFA4EDDE964F0CC69CD30@HE1PR0802MB2331.eurprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <HE1PR0802MB2331D43DAFA4EDDE964F0CC69CD30-TrivKwPZaC5w3/+SPhngUEdOKmgb957onBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: David Binderman <dcb314-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, "alexander.deucher-5C7GfCeVMHo@public.gmane.org" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "David1.Zhou-5C7GfCeVMHo@public.gmane.org" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "airlied-cv59FeDIM0c@public.gmane.org" <airlied-cv59FeDIM0c@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, "Li, Roman" <Roman.Li-5C7GfCeVMHo@public.gmane.org>

CgpPbiAwMy8xMi8yMDE4IDA2OjIyIEFNLCBEYXZpZCBCaW5kZXJtYW4gd3JvdGU6Cj4gaGVsbG8g
dGhlcmUsCj4KPiBTb3VyY2UgY29kZSBpcwo+Cj4KPiAgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBk
Yy0+cmVzX3Bvb2wtPnBpcGVfY291bnQ7IGkrKykgewo+ICDCoMKgwqDCoMKgwqDCoCBpZiAocmVz
X2N0eC0+cGlwZV9jdHhbaV0uc3RyZWFtKSB7Cj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGlw
ZV9jdHggPSAmcmVzX2N0eC0+cGlwZV9jdHhbaV07Cj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
KnBpcGVfaWR4ID0gaTsKPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiAgwqDCoMKg
wqDCoMKgwqAgfQo+ICDCoMKgwqAgfQoKSW5kZWVkIHNvbWV0aGluZyBsaWtlCgppZiAoIXBpcGVf
Y3R4KQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOwoKc2VlbXMgdGhl
IHJpZ2h0IHRoaW5nIGhlcmUuCgpIYXJyeSwgUm9tYW4gLCB5b3VyIG9waW5pb24gPwoKQW5kcmV5
Cgo+Cj4gIMKgwqDCoCAvKiBPbmx5IHN1cHBvcnRzIGVEUCAqLwo+ICDCoMKgwqAgaWYgKHBpcGVf
Y3R4LT5zdHJlYW0tPnNpbmstPmxpbmstPmNvbm5lY3Rvcl9zaWduYWwgIT0gU0lHTkFMX1RZUEVf
RURQKQo+ICDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7Cj4KPiBTdWdnZXN0IGFkZCBzb21l
IGNvZGUgdG8gZGVhbCB3aXRoIHRoZSBjYXNlIHRoYXQgdGhlIGZvciBsb29wIGRvZXNuJ3QgZmlu
ZAo+IHdoYXQgaXQgaXMgbG9va2luZyBmb3IgYW5kIHNvIHBpcGVfY3R4IGlzIE5VTEwuCj4KPiBS
ZWdhcmRzCj4KPiBEYXZpZCBCaW5kZXJtYW4KPiAgICAgIAo+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
