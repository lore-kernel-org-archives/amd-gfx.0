From: Chris Wilson <chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org>
Subject: Re: [PATCH 8/8] amdgpu: use sync file for shared semaphores (v3)
Date: Wed, 12 Apr 2017 11:18:55 +0100
Message-ID: <20170412101855.GJ4250@nuc-i3427.alporthouse.com>
References: <20170412045726.13689-1-airlied@gmail.com>
 <20170412045726.13689-9-airlied@gmail.com>
 <43ed515c-7278-3687-022b-9ecd650669fb@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <43ed515c-7278-3687-022b-9ecd650669fb-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: Christian =?iso-8859-1?Q?K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gV2VkLCBBcHIgMTIsIDIwMTcgYXQgMTE6NTU6MjRBTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPiBBbSAxMi4wNC4yMDE3IHVtIDA2OjU3IHNjaHJpZWIgRGF2ZSBBaXJsaWU6Cj4g
PitzdGF0aWMgaW50IGFtZGdwdV9zZW1fbG9va3VwX2FuZF9yZW1vdmUoc3RydWN0IGFtZGdwdV9j
c19wYXJzZXIgKnAsCj4gPisJCQkJICAgICAgdWludDMyX3QgaGFuZGxlKQo+ID4rewo+ID4rCWlu
dCByOwo+ID4rCXN0cnVjdCBkbWFfZmVuY2UgKm9sZF9mZW5jZTsKPiA+Kwo+ID4rCXIgPSBkcm1f
c3luY29ial9yZXBsYWNlX2ZlbmNlKHAtPmZpbHAsIGhhbmRsZSwgTlVMTCk7Cj4gPisJaWYgKHIp
Cj4gPisJCXJldHVybiByOwo+ID4rCWRtYV9mZW5jZV9wdXQob2xkX2ZlbmNlKTsKPiAKPiBBbSBJ
IHdyb25nIG9yIGlzIG9sZF9mZW5jZSBub3QgaW5pdGlhbGl6ZWQgaGVyZT8KPiAKPiBBZGRpdGlv
bmFsIHRvIHRoYXQgd2hhdCBoYXBwZW5zIHdoZW4gdGhlIGZlbmNlIGluIHRoZSBzeW5jIG9iamVj
dAo+IHdhcyBjaGFuZ2VkIHdoaWxlIHdlIGRvIHRoZSBDUz8gT3IgZXZlbiB3b3JzZSB0aGUgaGFu
ZGxlIGdvdAo+IGFzc2lnbmVkIHRvIGEgbmV3IHN5bmMgb2JqZWN0LgoKV2UgZWl0aGVyIHd3X211
dGV4IHRoZSBsb3QsIG9yIHJlZ2FyZCB0aGF0IGFzIGEgdXNlcnNwYWNlIHJhY2Ugd2hlcmUgdGhl
Cm9yZGVyIGJldHdlZW4gdGhlIHR3byBjb25jdXJyZW50IENTIGVtaXRzIGlzIHVuZGVmaW5lZCBh
bmQgd2hvIGdldHMgdGhlCmluLXNlbWFwaG9yZSBpcyBoYXBwZW5zdGFuY2UuCi1DaHJpcwoKLS0g
CkNocmlzIFdpbHNvbiwgSW50ZWwgT3BlbiBTb3VyY2UgVGVjaG5vbG9neSBDZW50cmUKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
