From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: use ttm pool first
Date: Wed, 24 Jan 2018 10:53:07 +0100
Message-ID: <f0637266-655f-836e-44c5-6e906f934c72@amd.com>
References: <20180124091707.32059-1-david1.zhou@amd.com>
 <36db7c3c-aa12-d11f-ef5d-63fc40c395ba@amd.com>
 <ce0c7a1f-3c94-c450-a6ab-7b5a65ca1c09@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ce0c7a1f-3c94-c450-a6ab-7b5a65ca1c09-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Cc: alexander.deucher-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjQuMDEuMjAxOCB1bSAxMDo0OSBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTgt
MDEtMjQgMTA6NDMgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDI0LjAxLjIwMTgg
dW0gMTA6MTcgc2NocmllYiBDaHVubWluZyBaaG91Ogo+Pj4gZG1hIHBhdGggaXMgbG93IHRoYW4g
dHRtIHBvb2wuCj4+IFRoYXQgd29uJ3Qgd29yayBjb3JyZWN0bHkgaW4gc29tZSBjYXNlcy4KPj4K
Pj4+IFF1ZXN0aW9uOgo+Pj4gQnV0IHdoeSBuZWVkIHR3byBwYXRoPyBXaGF0IHNwaWNpZmljIHBy
b2JsZW0gY2FuIGJlIHNvbHZlZCBieSBkbWEgcGF0aD8KPj4gVGhhdCBpcyBtb3N0bHkgZm9yIEFS
TSBhbmQgc29tZSAocmFyZSkgeDg2IHBsYXRmb3JtcyB3aXRob3V0IElPTU1VIHdoZXJlCj4+IHNv
bWUgbWVtb3J5IGlzIGFib3ZlIHRoZSA0MGJpdCBsaW1pdCBpbiB0aGUgUENJZSBhZGRyZXNzIHNw
YWNlLgo+Pgo+PiBPdXIgR1BVcyBjYW4gdW5mb3J0dW5hdGVseSBvbmx5IGRlYWwgd2l0aCA0MGJp
dHMgb2YgYWRkcmVzcyBzcGFjZSwgc28gb24KPj4gdGhvc2Ugc3lzdGVtcyB3ZSBuZWVkIHRvIGdv
IHRoZSBzbG93IHBhdGggYW5kIG1ha2Ugc3VyZSB0aGF0IHdlIGRvbid0Cj4+IHRyeSB0byB0b3Vj
aCB0aGF0IGhpZ2ggbWVtb3J5Lgo+Pgo+PiBXaGF0IHdlIGNvdWxkIHJlYWxseSBpbXByb3ZlIGlz
IHRoZSBkZXRlY3Rpb24gdXNpbmcgc3dpb3RsYl9ucl90YmwoKSwKPj4gY2F1c2UgdGhhdCBpcyBh
Y3R1YWxseSBjb21wbGV0ZWx5IHdyb25nLgo+IEZXSVcsIHRoZXJlIGFyZSBvdGhlciBjYXNlcyB3
aGVyZSBTV0lPVExCIGlzIG5lZWRlZCwgZS5nLiBTZWN1cmUgTWVtb3J5Cj4gRW5jcnlwdGlvbjog
aHR0cHM6Ly9idWdzLmZyZWVkZXNrdG9wLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTA0NDM3CgpPaCEg
R29vZCBwb2ludCwgZGlkbid0IG5vdGljZWQgdGhhdCBidWcgYmVmb3JlLiBCdXQgeWVzIHRoZSBy
YXRpb25hbCAKbWFrZXMgcGVyZmVjdCBzZW5zZS4KClJlZ2FyZHMsCkNocmlzdGlhbi4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
