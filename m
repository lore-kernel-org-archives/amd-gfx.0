From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: When to kmap PT BOs?
Date: Thu, 30 Aug 2018 12:49:25 +0800
Message-ID: <5B877755.3090402@amd.com>
References: <7a9aa339-e771-c667-4eb8-6f30c7c37c15@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <7a9aa339-e771-c667-4eb8-6f30c7c37c15-5C7GfCeVMHo@public.gmane.org>
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
To: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, =?UTF-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gMDgvMzAvMjAxOCAwNjozMCBBTSwgRmVsaXggS3VlaGxpbmcgd3JvdGU6Cj4gSGksCj4KPiBD
dXJyZW50bHkgUFQgQk9zIGFyZSBrbWFwcGVkIGluIGFtZGdwdV92bV91cGRhdGVfZGlyZWN0b3Jp
ZXMuIFRoYXQKPiBtZWFucywgdG8gYXZvaWQga2VybmVsIG9vcHNlcyBhZnRlciBwYWdlIHRhYmxl
IGV2aWN0aW9ucywgSSBuZWVkIHRvIGNhbGwKPiBhbWRncHVfdm1fdXBkYXRlX2RpcmVjdG9yaWVz
IGJlZm9yZSBjYWxsaW5nIGFtZGdwdV92bV9ib191cGRhdGUuCj4KPiBCdXQgYW1kZ3B1X3ZtX2Jv
X3VwZGF0ZSBjYW4gYWxzbyBtb3ZlIFBUcyBvbiB0aGUgdm0tPnJlbG9jYXRlZCBsaXN0Cj4gZHVy
aW5nIGh1Z2UgcGFnZSBoYW5kbGluZy4gVGhhdCBtZWFucyBJIGFsc28gbmVlZCB0byBjYWxsCj4g
YW1kZ3B1X3ZtX3VwZGF0ZV9kaXJlY3RvcmllcyBhZnRlciBhbWRncHVfdm1fYm9fdXBkYXRlLgoK
Tm90IHZlcnkgZmFtaWxpYXIgd2l0aCBodWdlIHBhZ2UgaGFuZGxpbmcuCgpCdXQgZnJvbSBjb2Rl
LCBtYXliZSB3ZSBjYW4ga21hcCB0aGUgUFRFIGVudHJ5IHJpZ2h0IGhlcmUuClRoZW4gaXQgd2ls
bCB1cGRhdGUgY3VycmVudCBub24taHVnZSBwYWdlIFBURSBsYXRlciBpbiBhbWRncHVfdm1fdXBk
YXRlX3B0ZXMoKS4KClJlZ2FyZHMsCkplcnJ5Cgo+Cj4gSSB0aGluayBhIGJldHRlciBzb2x1dGlv
biBpcyB0byBtb3ZlIGttYXBwaW5nIG91dCBvZgo+IGFtZGdwdV92bV91cGRhdGVfZGlyZWN0b3Jp
ZXMuIEJ1dCBJJ20gbm90IHN1cmUgd2hhdCdzIHRoZSByaWdodCBwbGFjZQo+IGZvciBpdC4gQW55
IHN1Z2dlc3Rpb25zPyBGb3IgYSBxdWljayBmaXggZm9yIGtlcm5lbCBvb3BzZXMgYWZ0ZXIgcGFn
ZQo+IHRhYmxlIGV2aWN0aW9ucyBpbiB0aGUgUk9DbSAxLjkgcmVsZWFzZSBJJ2xsIGNhbGwKPiBh
bWRncHVfdm1fdXBkYXRlX2RpcmVjdG9yaWVzIHR3aWNlLiBJZiB0aGVyZSBhcmUgbm8gbmV3IGVu
dHJpZXMgb24gdGhlCj4gdm0tPnJlbG9jYXRlZCBsaXN0cywgdGhlIHNlY29uZCBjYWxsIHdvbid0
IGFkZCBtdWNoIG92ZXJoZWFkIGFueXdheS4KPgo+IFRoYW5rcywKPiAgICBGZWxpeAo+Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
