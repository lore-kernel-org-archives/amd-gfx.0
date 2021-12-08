Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1089FC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 03:16:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B45FA6E210;
	Wed,  8 Dec 2021 03:16:43 +0000 (UTC)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 761E86E329
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 01:32:47 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4J7zz72KXTzF4nR;
 Tue,  7 Dec 2021 17:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1638926803; bh=0CNi84euItyXUOMyD8vpBFaZDqzvT0uSwQLfyFA4lMc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aeG9Tn7nL173WopkJXS/EA/zkczVBrFoXF/Kj9CXfNo0/NoEp+vNxUBTi6o+7MsSM
 SmWUBIAEVVL6GE6uRX5Y8+HEHQZXb1zr57IqIPJF39fPrMhACpy92i/Xm17KcoP+UU
 sFNbw8pj1MJ/JlYySUT7EGmU9DjLoiCTb0Lr+Dn0=
X-Riseup-User-ID: 06EB3C6F8C2BBD3B565D95F1E2E4236DD43675620618A05967B11F557DB06B3B
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4J7zz46LgVz5vkY;
 Tue,  7 Dec 2021 17:26:40 -0800 (PST)
From: Isabella Basso <isabbasso@riseup.net>
To: alexander.deucher@amd.com, christian.koenig@amd.com, daniel@ffwll.ch,
 harry.wentland@amd.com, Rodrigo.Siqueira@amd.com, Felix.Kuehling@amd.com
Subject: [PATCH 09/10] drm/amdgpu: remove unnecessary variables
Date: Tue,  7 Dec 2021 22:25:28 -0300
Message-Id: <20211208012529.372478-10-isabbasso@riseup.net>
In-Reply-To: <20211208012529.372478-1-isabbasso@riseup.net>
References: <20211208012529.372478-1-isabbasso@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Dec 2021 03:16:41 +0000
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

This fixes the warnings below:

 In function 'svm_range_map_to_gpu':
 warning: variable 'bo_va' set but not used [-Wunused-but-set-variable]
 1172 |         struct amdgpu_bo_va bo_va;
      |                             ^~~~~
 ...
 In function 'dcn201_update_clocks':
 warning: variable 'enter_display_off' set but not used [-Wunused-but-set-variable]
 132 |         bool enter_display_off = false;
     |              ^~~~~~~~~~~~~~~~~

Signed-off-by: Isabella Basso <isabbasso@riseup.net>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                          | 3 +--
 .../gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c    | 4 ----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 82cb45e30197..08b2130afa4c 100644
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
@@ -1183,7 +1182,7 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		 last_start, last_start + npages - 1, readonly);
 
 	if (prange->svm_bo && prange->ttm_res)
-		bo_va.is_xgmi = amdgpu_xgmi_same_hive(adev, bo_adev);
+		amdgpu_xgmi_same_hive(adev, bo_adev);
 
 	for (i = offset; i < offset + npages; i++) {
 		last_domain = dma_addr[i] & SVM_RANGE_VRAM_DOMAIN;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
index f7f46b886162..2ea813a56edf 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
@@ -128,7 +128,6 @@ static void dcn201_update_clocks(struct clk_mgr *clk_mgr_base,
 	int display_count;
 	bool update_dppclk = false;
 	bool update_dispclk = false;
-	bool enter_display_off = false;
 	bool dpp_clock_lowered = false;
 	bool force_reset = false;
 	bool p_state_change_support;
@@ -146,9 +145,6 @@ static void dcn201_update_clocks(struct clk_mgr *clk_mgr_base,
 
 	display_count = clk_mgr_helper_get_active_display_cnt(dc, context);
 
-	if (display_count == 0)
-		enter_display_off = true;
-
 	if (should_set_clock(safe_to_lower, new_clocks->phyclk_khz, clk_mgr_base->clks.phyclk_khz))
 		clk_mgr_base->clks.phyclk_khz = new_clocks->phyclk_khz;
 
-- 
2.34.1

