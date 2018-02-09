From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/5] drm/amdgpu: replace iova debugfs file with iomem
Date: Fri, 9 Feb 2018 14:56:12 +0100
Message-ID: <5f37bea8-a6a3-c879-e8ec-f24948647a3e@gmail.com>
References: <20180202190948.2654-1-christian.koenig@amd.com>
 <20180202190948.2654-5-christian.koenig@amd.com>
 <9b2c3354-ea82-722d-a6d2-42e2cf1e6540@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <9b2c3354-ea82-722d-a6d2-42e2cf1e6540-5C7GfCeVMHo@public.gmane.org>
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
To: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMDkuMDIuMjAxOCB1bSAxNDozMiBzY2hyaWViIFRvbSBTdCBEZW5pczoKPiBPbiAwMi8wMi8x
OCAwMjowOSBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gW1NOSVBdCj4+ICvCoMKgwqDC
oMKgwqDCoCBpZiAocC0+bWFwcGluZyAhPSBhZGV2LT5tbWFuLmJkZXYuZGV2X21hcHBpbmcpCj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRVBFUk07Cj4KPiBUaGlzIGNvbXBhcmlz
b24gZmFpbHMgZm9yIGJvdGggSU9NTVUgYW5kIG5vbi1JT01NVSBkZXZpY2VzIGluIG15IAo+IGNh
cnJpem8rcG9sYXJpczEwIGJveC4KPgo+IFRoZSBhZGRyZXNzIGJlaW5nIHJlYWQgZnJvbSBpcyB3
aGF0IHRoZSBWTSBkZWNvZGVzIHRvIChjaGVja2VkIHdpdGggCj4gc3RyYWNlKS4KCkhhdmUgeW91
IGFwcGxpZWQgdGhlIHdob2xlIHNlcmllcz8gVGhhdCBwYXRjaGVzIGJlZm9yZSB0aGlzIG9uZSBh
cmUgCm5lY2Vzc2FyeSB0byBpbml0aWFsaXplIHAtPm1hcHBpbmcgd2hlbiB0aGVyZSBpc24ndCBh
bnkgdXNlcnNwYWNlIAptYXBwaW5nIGZvciB0aGUgcGFnZS4KCkNocmlzdGlhbi4KCj4KPiBUb20K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
