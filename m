From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: Plan: BO move throttling for visible VRAM evictions
Date: Thu, 30 Mar 2017 19:03:33 +0900
Message-ID: <9220eda1-5176-36cd-e6b3-801c3e4f759a@daenzer.net>
References: <CAAxE2A4ap8BoOEg1tOF+Ec1vBfZRSANOebikYBaHUfXokY7EwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------0BFA0CF34943CF79333955AE"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A4ap8BoOEg1tOF+Ec1vBfZRSANOebikYBaHUfXokY7EwA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
--------------0BFA0CF34943CF79333955AE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 25/03/17 01:33 AM, Marek Olšák wrote:
> Hi,
> 
> I'm sharing this idea here, because it's something that has been
> decreasing our performance a lot recently, for example:
> http://openbenchmarking.org/prospect/1703011-RI-RADEONDIR06/7b7668cfc109d1c3dc27e871c8aea71ca13f23fa

The attached proof-of-concept patch (on top of Christian's "CPU mapping
of split VRAM buffers" series, ported from radeon) results in 145.05 fps
on my Tonga.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--------------0BFA0CF34943CF79333955AE
Content-Type: text/x-patch;
 name="amdgpu-visible-VRAM-evict.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="amdgpu-visible-VRAM-evict.diff"

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
index 7f9710502bcc..0bb9c0059497 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -205,6 +205,29 @@ static void amdgpu_evict_flags(struct ttm_buffer_obj=
ect *bo,
 	case TTM_PL_VRAM:
 		if (adev->mman.buffer_funcs_ring->ready =3D=3D false) {
 			amdgpu_ttm_placement_from_domain(abo, AMDGPU_GEM_DOMAIN_CPU);
+		} else if (adev->mc.visible_vram_size < adev->mc.real_vram_size &&
+			   bo->mem.start < (adev->mc.visible_vram_size >> PAGE_SHIFT)) {
+			unsigned fpfn =3D adev->mc.visible_vram_size >> PAGE_SHIFT;
+			int i;
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
 			amdgpu_ttm_placement_from_domain(abo, AMDGPU_GEM_DOMAIN_GTT);
 			for (i =3D 0; i < abo->placement.num_placement; ++i) {

--------------0BFA0CF34943CF79333955AE
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------0BFA0CF34943CF79333955AE--
