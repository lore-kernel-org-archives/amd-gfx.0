From: Flora Cui <flora.cui-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix gtt_mgr bo's offset
Date: Tue, 20 Sep 2016 19:16:32 +0800
Message-ID: <20160920111631.GC9691@flora>
References: <1474362552-9062-1-git-send-email-Flora.Cui@amd.com>
 <57E10D35.5040006@amd.com> <20160920104122.GB9691@flora>
 <b4bb5cc9-39de-aff6-ec12-2d97d0cc9fcd@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Transfer-Encoding: 8bit
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b4bb5cc9-39de-aff6-ec12-2d97d0cc9fcd-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
Cc: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Does this change make sense? 

On Tue, Sep 20, 2016 at 01:02:20PM +0200, Christian König wrote:
> Am 20.09.2016 um 12:41 schrieb Flora Cui:
> >On Tue, Sep 20, 2016 at 06:19:33PM +0800, zhoucm1 wrote:
> >>
> >>On 2016年09月20日 17:09, Flora Cui wrote:
> >>>Change-Id: I89e9be3d5c96d46655f3a977fb557b20b4d87609
> >>>Signed-off-by: Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org>
> >>>---
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 4 ++--
> >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> >>>index 262e872..b266cf7 100644
> >>>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> >>>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> >>>@@ -128,8 +128,8 @@ int amdgpu_gtt_mgr_alloc(struct ttm_mem_type_manager *man,
> >>>  	if (!r) {
> >>>  		mem->start = node->start;
> >>>-		tbo->offset = (tbo->mem.start << PAGE_SHIFT) +
> >>>-		    tbo->bdev->man[tbo->mem.mem_type].gpu_offset;
> >>>+		tbo->offset = (mem->start << PAGE_SHIFT) +
> >>>+		    tbo->bdev->man[mem->mem_type].gpu_offset;
> >>mem->mem_type seems not set yet as well if I am correct.
> >>IIRC, I feel it's better that tbo->offset is set out of this function after
> >>get_node successfully.
> >>
> >how about change to tbo->bdev->man[TTM_PL_TT].gpu_offset? since
> >gtt_mgr is for GTT only.
> 
> Not 100% correct either.
> 
> The problem is that sometimes a GTT MM node will be bound for a BO which is
> still in VRAM (e.g. on eviction for example).
> 
> So you need to check if (&tbo->mem == mem) and only then update the tbo's
> offset.
> 
> Regards,
> Christian.
> 
> >
> >>Regards,
> >>David Zhou
> >>
> >>>  	}
> >>>  	return r;
> >_______________________________________________
> >amd-gfx mailing list
> >amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> 
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--BXVAT5kNtrzKuDFl
Content-Type: text/x-diff; charset="us-ascii"
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-fix-gtt_mgr-bo-s-offset.patch"

>From 411f93d78e8f3691ce480146374c1e603c2c6db6 Mon Sep 17 00:00:00 2001
From: Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org>
Date: Tue, 20 Sep 2016 17:07:31 +0800
Subject: [PATCH] drm/amdgpu: fix gtt_mgr bo's offset

Change-Id: I89e9be3d5c96d46655f3a977fb557b20b4d87609
Signed-off-by: Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 262e872..f86c844 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -128,8 +128,9 @@ int amdgpu_gtt_mgr_alloc(struct ttm_mem_type_manager *man,
 
 	if (!r) {
 		mem->start = node->start;
-		tbo->offset = (tbo->mem.start << PAGE_SHIFT) +
-		    tbo->bdev->man[tbo->mem.mem_type].gpu_offset;
+		if (&tbo->mem == mem)
+			tbo->offset = (tbo->mem.start << PAGE_SHIFT) +
+			    tbo->bdev->man[tbo->mem.mem_type].gpu_offset;
 	}
 
 	return r;
-- 
2.7.4


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--BXVAT5kNtrzKuDFl--
