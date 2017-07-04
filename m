From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: set firmware loading type as direct by default
 for raven
Date: Tue, 4 Jul 2017 18:11:44 +0800
Message-ID: <595B69E0.2020500@amd.com>
References: <1499157314-28393-1-git-send-email-ray.huang@amd.com>
 <595B6267.9040600@amd.com> <20170704095902.GA25844@hr-amur2>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170704095902.GA25844@hr-amur2>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

T24gMDcvMDQvMjAxNyAwNTo1OSBQTSwgSHVhbmcgUnVpIHdyb3RlOgo+IE9uIFR1ZSwgSnVsIDA0
LCAyMDE3IGF0IDA1OjM5OjUxUE0gKzA4MDAsIFpoYW5nLCBKZXJyeSB3cm90ZToKPj4gSGkgUmF5
LAo+Pgo+PiBUaGFua3MgZm9yIHlvdXIgaW5pdGlhbCBwYXRjaCB0byBlbmFibGUgUFNQIG9wdGlv
biBmb3IgUmF2ZW4uCj4+Cj4+IFRvIHNpbXBsaWZ5IGl0LCB3ZSBtYXkgbGV2ZXJhZ2UgVkVHQTEw
IGNhc2UgZm9yIFJhdmVuIGRpcmVjdGx5Lgo+PiBBbmQgcmVtb3ZlIGFsbCBSYXZlbiBleGlzdGlu
ZyBjb2RlIHVuZGVyICJjYXNlIENISVBfUkFWRU4iCj4+IEhvdyBkbyB5b3UgdGhpbmsgYWJvdXQg
aXQ/Cj4+Cj4KPiBQcm9iYWJseSBub3QuIFZlZ2ExMCBlbmFibGVkIHBzcCBmdyBsb2FkaW5nIGJ5
IGRlZmF1bHQsIGJ1dCBub3QgZm9yIHJhdmVuLgo+Cj4gTXkgbWFpbmx5IGlkZWEgaGVyZSBpcwo+
Cj4gZGVmYXVsdDoKPiBtb2Rwcm9iZSBhbWRncHUgLT4gdXNlIGRpcmVjdCBmdyBsb2FkaW5nLgo+
Cj4gZGVidWdnaW5nIHBzcDoKPiBtb2Rwcm9iZSBhbWRncHUgZndfbG9hZF90eXBlPTIgLT4gdXNl
IHBzcCBmdyBsb2FkaW5nLgo+Cj4gSXQgZG9lc24ndCBpbXBhY3Qgb3RoZXIgZ3V5cyB1c2UgYW5k
IHdlIGNhbiBkZWJ1ZyBpdCBtb3JlIHNtb290aGx5LiA6LSkKClRoYW5rcyB0byBleHBsYWluIGl0
IGluIGRldGFpbC4KR290IGl0LgoKRmVlbCBmcmVlIHRvIGFkZCBteSBSQiBhbmQgd2UgY2FuIGlt
cHJvdmUgaXQgd2hlbiBldmVyeXRoaW5nIGlzIHNldHRsZWQgZG93bi4KUmV2aWV3ZWQtYnk6IEp1
bndlaSBaaGFuZyA8SmVycnkuWmhhbmdAYW1kLmNvbT4KCj4KPiBUaGFua3MsCj4gUmF5Cj4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
