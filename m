From: Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: Add modeset module option
Date: Tue, 03 Apr 2018 12:53:30 +0300
Message-ID: <87r2nwaa5h.fsf@intel.com>
References: <20180330204512.16863-1-tiwai@suse.de>
 <20180330204512.16863-2-tiwai@suse.de>
 <c95f9e61-c921-42de-9e03-851d785ab5fc@amd.com>
 <CAKb7Uvh_CxE=Zg_F0tentwXK64_baxs0TCQ-K9Mh_Mjf+NV_DA@mail.gmail.com>
 <7260680d-8c4c-8b92-8049-83e556f823e8@daenzer.net>
 <781c3a0b-e199-c637-410a-521fe5fd5170@amd.com> <s5hpo3g1x4m.wl-tiwai@suse.de>
 <e4933491-65be-4b31-95de-cf1147dd312c@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e4933491-65be-4b31-95de-cf1147dd312c-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: Michel =?utf-8?Q?D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Christian K6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gVHVlLCAwMyBBcHIgMjAxOCwgTWljaGVsIETDpG56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD4g
d3JvdGU6Cj4gT24gMjAxOC0wNC0wMyAxMTowMiBBTSwgVGFrYXNoaSBJd2FpIHdyb3RlOgo+PiBB
Z3JlZWQgd2l0aCB0aGUgbmFtaW5nIG1lc3MuICBCdXQgT1RPSCwgaXQncyBhbHJlYWR5IGEgdGhp
bmcgdGhhdCBpcwo+PiB0b28gcG9wdWxhciB0byBraWxsLiAgWW91IGNhbiBhZGQgYSBtb3JlIHN1
aXRhYmxlIG9wdGlvbiBuYW1lLCBidXQgeW91Cj4+IGNhbm5vdCBkcm9wIHRoZXNlIGV4aXN0aW5n
IG9uZXMgZWFzaWx5LiAgSXQncyBhbHJlYWR5IGluIGEgZ3JheSB6b25lCj4+IG9mIHRoZSBnb2xk
ZW4gImRvbid0IGJyZWFrIHVzZXItc3BhY2UiIHJ1bGUuCj4KPiBUaGF0J3MgcXVpdGUgYSBzdHJl
dGNoIGFyZ3VtZW50LCBnaXZlbiB0aGF0IGFtZGdwdSBoYXMgbmV2ZXIgc3VwcG9ydGVkCj4gdGhl
IG1vZGVzZXQgcGFyYW1ldGVyLgoKVGhhdCBtdWNoIGlzIGNsZWFyLgoKPiBBbHNvLCBtb2R1bGUg
cGFyYW1ldGVycyBhcmVuJ3QgVUFQSS4KCltjaXRhdGlvbiBuZWVkZWRdLiBJIGFncmVlIHdpdGgg
VGFrYXNoaSBpdCdzIGEgZ3JheSBhcmVhLgoKWW91IGNhbiBoYXZlICJ1bnNhZmUiIG1vZHVsZSBw
YXJhbWV0ZXJzIHRoYXQgdGFpbnQgdGhlIGtlcm5lbCB3aGVuIHNldCwKc2VlIG1vZHVsZV9wYXJh
bV91bnNhZmUgYW5kIG1vZHVsZV9wYXJhbV9uYW1lZF91bnNhZmUuIFVzaW5nIHRob3NlCnNob3Vs
ZCBtYWtlIGl0IGNsZWFyIGFsbCBiZXRzIGFyZSBvZmYuCgpCUiwKSmFuaS4KCi0tIApKYW5pIE5p
a3VsYSwgSW50ZWwgT3BlbiBTb3VyY2UgVGVjaG5vbG9neSBDZW50ZXIKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
