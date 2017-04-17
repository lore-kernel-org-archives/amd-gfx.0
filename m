From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: Plan: BO move throttling for visible VRAM evictions
Date: Mon, 17 Apr 2017 18:55:20 +0900
Message-ID: <c343b89c-318f-d3af-d02e-4e6843c422f6@daenzer.net>
References: <CAAxE2A4ap8BoOEg1tOF+Ec1vBfZRSANOebikYBaHUfXokY7EwA@mail.gmail.com>
 <9220eda1-5176-36cd-e6b3-801c3e4f759a@daenzer.net>
 <78989271-9812-f891-3a00-0d5b39a06b7c@daenzer.net>
 <CAAxE2A60hubc8jbZkO101sxqVZKR8iub=GsfRovj17+P2zKDKQ@mail.gmail.com>
 <aee1e2b7-dd00-e24b-bcfc-e2299e31908b@daenzer.net>
 <CAAxE2A5g7tJG+94XxPr-mdGXkeL1GPMNMaYgc7ATEk7pxsiXfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------6D84DB0C5A01F7AEFD31B50F"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A5g7tJG+94XxPr-mdGXkeL1GPMNMaYgc7ATEk7pxsiXfA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--------------6D84DB0C5A01F7AEFD31B50F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 17/04/17 07:58 AM, Marek Olšák wrote:
> On Fri, Apr 14, 2017 at 12:14 PM, Michel Dänzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org> wrote:
>> On 04/04/17 05:11 AM, Marek Olšák wrote:
>>> On Fri, Mar 31, 2017 at 5:24 AM, Michel Dänzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org> wrote:
>>>> On 30/03/17 07:03 PM, Michel Dänzer wrote:
>>>>> On 25/03/17 01:33 AM, Marek Olšák wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I'm sharing this idea here, because it's something that has been
>>>>>> decreasing our performance a lot recently, for example:
>>>>>> http://openbenchmarking.org/prospect/1703011-RI-RADEONDIR06/7b7668cfc109d1c3dc27e871c8aea71ca13f23fa
>>>>>
>>>>> The attached proof-of-concept patch (on top of Christian's "CPU mapping
>>>>> of split VRAM buffers" series, ported from radeon) results in 145.05 fps
>>>>> on my Tonga.
>>>>
>>>> I get the same result without my or Christian's patches though, with
>>>> 4.11 based DRM or amd-staging-4.9. So I guess I just can't reproduce the
>>>> problem with this test. Are there any other tests for it?
>>>
>>> It's random. Sometimes the benchmark runs OK, other times it's slow.
>>> You can easily see the difference but observing how smooth it is. The
>>> visible VRAM evictions result in constant 100-200ms stalls but not
>>> every frame, which feels like the frame rate is much lower than it
>>> actually is.
>>>
>>> Make sure your graphics details are maxed out. The best score I can
>>> get with my rig is 70 fps. (Fiji & Core i5 3570)
>>
>> I'm getting around 53-54 fps at Ultra with Tonga, both with Mesa 13.0.6
>> and Git.
>>
>> Have you tried if Christian's patches for CPU access to split VRAM
>> buffers help? I can imagine that forcing contiguous VRAM buffers for CPU
>> access could cause lots of other BOs to be unnecessarily evicted from
>> VRAM, if at least one of their fragments happens to be in the CPU
>> visible part of VRAM.
> 
> I've finally tested latest amd-staging-4.9 and I'm very pleased. For
> the first time, the Deus Ex benchmark has almost no hiccups. I've
> never seen it so smooth. At one point, the MB/s BO move rate increase
> to 200MB/s, stayed there for a couple of seconds, and then it dropped
> to 0 again. The frame rate was OK-ish, so I guess the moves didn't
> happen all at once. I also tested DiRT Rally and I haven't been able
> to reproduce the low FPS with the consistently-high BO move rate that
> I saw several months ago.
> 
> We could do some move throttling there for sure, but it's much better
> than it ever was.

That's great to hear. If you get a chance, it would be interesting if
the attached updated patch improves things even more for you. (The patch
I attached previously couldn't work as intended, this one at least might :)


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--------------6D84DB0C5A01F7AEFD31B50F
Content-Type: text/x-patch;
 name="amdgpu-visible-VRAM-evict.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="amdgpu-visible-VRAM-evict.diff"

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
index 7f9710502bcc..78362e09cc51 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -205,7 +205,44 @@ static void amdgpu_evict_flags(struct ttm_buffer_obj=
ect *bo,
 	case TTM_PL_VRAM:
 		if (adev->mman.buffer_funcs_ring->ready =3D=3D false) {
 			amdgpu_ttm_placement_from_domain(abo, AMDGPU_GEM_DOMAIN_CPU);
+		} else if (adev->mc.visible_vram_size < adev->mc.real_vram_size) {
+			unsigned fpfn =3D adev->mc.visible_vram_size >> PAGE_SHIFT;
+			int i;
+
+			if (bo->mem.start >=3D fpfn) {
+				struct drm_mm_node *node =3D bo->mem.mm_node;
+				unsigned long pages_left;
+
+				for (pages_left =3D bo->mem.num_pages; pages_left;
+				     pages_left -=3D node->size, node++) {
+					if (node->start < fpfn)
+						break;
+				}
+
+				if (!pages_left)
+					goto gtt;
+			}
+
+			/* Try evicting to the CPU inaccessible part of VRAM
+			 * first, but only set GTT as busy placement, so this
+			 * BO will be evicted to GTT rather than causing other
+			 * BOs to be evicted from VRAM
+			 */
+			amdgpu_ttm_placement_from_domain(abo, AMDGPU_GEM_DOMAIN_VRAM |
+							 AMDGPU_GEM_DOMAIN_GTT);
+			abo->placement.num_busy_placement =3D 0;
+			for (i =3D 0; i < abo->placement.num_placement; i++) {
+				if (abo->placements[i].flags & TTM_PL_FLAG_VRAM) {
+					if (abo->placements[i].fpfn < fpfn)
+						abo->placements[i].fpfn =3D fpfn;
+				} else {
+					abo->placement.busy_placement =3D
+						&abo->placements[i];
+					abo->placement.num_busy_placement =3D 1;
+				}
+			}
 		} else {
+gtt:
 			amdgpu_ttm_placement_from_domain(abo, AMDGPU_GEM_DOMAIN_GTT);
 			for (i =3D 0; i < abo->placement.num_placement; ++i) {
 				if (!(abo->placements[i].flags &

--------------6D84DB0C5A01F7AEFD31B50F
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------6D84DB0C5A01F7AEFD31B50F--
