From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: Refactor flip into prepare submit and
 submit. (v2)
Date: Sat, 14 Jan 2017 08:36:12 +0100
Message-ID: <d8aa133c-f3fd-9b0f-03da-e52f410c99d3@vodafone.de>
References: <1484332005-12910-1-git-send-email-alexander.deucher@amd.com>
 <1484332005-12910-2-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1484332005-12910-2-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>

QW0gMTMuMDEuMjAxNyB1bSAxOToyNiBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBGcm9tOiBBbmRy
ZXkgR3JvZHpvdnNreSA8QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNvbT4KPgo+IE1ha2UgcGZsaXAg
YXRvbWljIGZyaWVuZGx5LiBTcGxpdCB0aGUgZnVpbmN0aW9uIGludG8KPiB3aGF0ZXZlciBjYW4g
ZmFpbCBwYXJ0IGFuZCB0aGUgYWN0dWFsIGZsaXAgc3VibWl0IHBhcnQuCj4gQ2FsbCB0aGUgcHJl
LXN1Ym1pdCBmdW5jdGlvbiBiZWZvcmUgYXRvbWljIHN0YXRlcwo+IGFyZSBzd2FwcGVkIHNvIGlu
IGNhc2Ugb2YgZXJyb3Igd2UgY2FuIGZhaWwgdGhlCj4gSU9DVEwuCj4KPiB2MjoKPiBVcGRhdGUg
ZHVlIHRvICB0YXJnZXRfdmJsYW5rIGNvZGUgY2hhbmdlLgo+IEZpeCBpZGVudGV0YXRpb24uCj4g
Q2hhbmdlIHJldHVybiB0eXBlIGZvciBhbWRncHVfY3J0Y19zdWJtaXRfZmxpcCB0byB2b2lkCj4K
PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgR3JvZHpvdnNreSA8QW5kcmV5Lkdyb2R6b3Zza3lAYW1k
LmNvbT4KPiBSZXZpZXdlZC1ieSBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNv
bT4KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CgpUaGUgY29kaW5nIHN0eWxlIG9uIGEgY291cGxlIG9mIGZ1bmN0aW9ucyBoZWFkZXJzIGlz
IGluY29ycmVjdCwgaGVyZSBmb3IgCmV4YW1wbGU6Cj4gdm9pZCBhbWRncHVfY3J0Y19jbGVhbnVw
X2ZsaXBfY3R4KAo+IAkJc3RydWN0IGFtZGdwdV9mbGlwX3dvcmsgKndvcmssCj4gCQlzdHJ1Y3Qg
YW1kZ3B1X2JvICpuZXdfYWJvKQoKVGhhdCBzaG91bGQgbG9vayBsaWtlOgo+IHZvaWQgYW1kZ3B1
X2NydGNfY2xlYW51cF9mbGlwX2N0eChzdHJ1Y3QgYW1kZ3B1X2ZsaXBfd29yayAqd29yaywKPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGFtZGdwdV9ibyAqbmV3X2Fi
bykKClJlZ2FyZHMsCkNocmlzdGlhbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
