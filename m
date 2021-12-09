Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E17BC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 17:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92F1310F65A;
	Thu,  9 Dec 2021 16:55:41 +0000 (UTC)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29EE089F8B
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 15:47:56 +0000 (UTC)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4J8z2M6MYrzDyY3;
 Thu,  9 Dec 2021 07:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1639064876; bh=Bce+Cgg5/eL+kHuoYk5nU2r1IGIqkpbjI1f1d7mHk5Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=e2vkGYwhmUOjOX9lGuho6JpDMumjVx/0OBa0OeXSWL2Jt4yGKUjZ3AFYQ7V1io6P0
 N3GzbsHY9phikmZnmeCWB1mJ7DN8hmNK1wgIu68QIO3SD9CDnryzxb+M12Vc+nMcl8
 xYYWLH0LjnuN29XWv8oigvixW9u07nkOuroTMFC0=
X-Riseup-User-ID: 8039621E9C2A8F562FE41D5DBC472AAEF22B21EFEE3CAF8B871BC8C745FBEF3B
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews2.riseup.net (Postfix) with ESMTPSA id 4J8z2K3V7Qz1yT2;
 Thu,  9 Dec 2021 07:47:53 -0800 (PST)
From: Isabella Basso <isabbasso@riseup.net>
To: alexander.deucher@amd.com, christian.koenig@amd.com, daniel@ffwll.ch,
 harry.wentland@amd.com, Rodrigo.Siqueira@amd.com, Felix.Kuehling@amd.com
Subject: [PATCH v2 09/10] drm/amdgpu: remove unnecessary variables
Date: Thu,  9 Dec 2021 12:47:21 -0300
Message-Id: <20211209154722.4018279-4-isabbasso@riseup.net>
In-Reply-To: <20211209154722.4018279-1-isabbasso@riseup.net>
References: <20211209154722.4018279-1-isabbasso@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: ~lkcamp/patches@lists.sr.ht, Isabella Basso <isabbasso@riseup.net>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This fixes the warnings below, and also drops the display_count
variable, as it's unused.

 In function 'svm_range_map_to_gpu':
 warning: variable 'bo_va' set but not used [-Wunused-but-set-variable]
 1172 |         struct amdgpu_bo_va bo_va;
      |                             ^~~~~
 ...
 In function 'dcn201_update_clocks':
 warning: variable 'enter_display_off' set but not used [-Wunused-but-set-variable]
 132 |         bool enter_display_off = false;
     |              ^~~~~~~~~~~~~~~~~

Changes since v1:
- As suggested by Rodrigo Siqueira:
  1. Drop display_count variable.
- As suggested by Felix Kuehling:
  1. Remove block surrounding amdgpu_xgmi_same_hive.

Signed-off-by: Isabella Basso <isabbasso@riseup.net>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                       | 4 ----
 .../gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c | 7 +------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 82cb45e30197..835f202dc23d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1169,7 +1169,6 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		     unsigned long npages, bool readonly, dma_addr_t *dma_addr,
 		     struct amdgpu_device *bo_adev, struct dma_fence **fence)
 {
-	struct amdgpu_bo_va bo_va;
 	bool table_freed = false;
 	uint64_t pte_flags;
 	unsigned long last_start;
@@ -1182,9 +1181,6 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	pr_debug("svms 0x%p [0x%lx 0x%lx] readonly %d\n", prange->svms,
 		 last_start, last_start + npages - 1, readonly);
 
-	if (prange->svm_bo && prange->ttm_res)
-		bo_va.is_xgmi = amdgpu_xgmi_same_hive(adev, bo_adev);
-
 	for (i = offset; i < offset + npages; i++) {
 		last_domain = dma_addr[i] & SVM_RANGE_VRAM_DOMAIN;
 		dma_addr[i] &= ~SVM_RANGE_VRAM_DOMAIN;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
index 8c20a0fb1e4f..fbdd0a92d146 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
@@ -90,10 +90,8 @@ static void dcn201_update_clocks(struct clk_mgr *clk_mgr_base,
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
 	struct dc *dc = clk_mgr_base->ctx->dc;
-	int display_count;
 	bool update_dppclk = false;
 	bool update_dispclk = false;
-	bool enter_display_off = false;
 	bool dpp_clock_lowered = false;
 	bool force_reset = false;
 	bool p_state_change_support;
@@ -109,10 +107,7 @@ static void dcn201_update_clocks(struct clk_mgr *clk_mgr_base,
 		dcn2_read_clocks_from_hw_dentist(clk_mgr_base);
 	}
 
-	display_count = clk_mgr_helper_get_active_display_cnt(dc, context);
-
-	if (display_count == 0)
-		enter_display_off = true;
+	clk_mgr_helper_get_active_display_cnt(dc, context);
 
 	if (should_set_clock(safe_to_lower, new_clocks->phyclk_khz, clk_mgr_base->clks.phyclk_khz))
 		clk_mgr_base->clks.phyclk_khz = new_clocks->phyclk_khz;
-- 
2.34.1

