Return-Path: <SRS0=hFGi=CM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BE4C433E2
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 02:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76FA82072A
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 02:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76FA82072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 158EB6E13A;
	Thu,  3 Sep 2020 02:34:31 +0000 (UTC)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0910D6E12B
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2020 02:18:36 +0000 (UTC)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id E2CF72AD6BE6732AFC75;
 Thu,  3 Sep 2020 10:18:31 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Thu, 3 Sep 2020
 10:18:24 +0800
From: Ye Bin <yebin10@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gfx10: Delete some duplicated argument to '|'
Date: Thu, 3 Sep 2020 10:17:56 +0800
Message-ID: <20200903021756.316132-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 03 Sep 2020 02:34:29 +0000
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
Cc: Ye Bin <yebin10@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. gfx_v10_0_soft_reset GRBM_STATUS__SPI_BUSY_MASK
2. gfx_v10_0_update_gfx_clock_gating AMD_CG_SUPPORT_GFX_CGLS

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 2db195ec8d0c..d502e30f67d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7055,8 +7055,7 @@ static int gfx_v10_0_soft_reset(void *handle)
 		   GRBM_STATUS__BCI_BUSY_MASK | GRBM_STATUS__SX_BUSY_MASK |
 		   GRBM_STATUS__TA_BUSY_MASK | GRBM_STATUS__DB_BUSY_MASK |
 		   GRBM_STATUS__CB_BUSY_MASK | GRBM_STATUS__GDS_BUSY_MASK |
-		   GRBM_STATUS__SPI_BUSY_MASK | GRBM_STATUS__GE_BUSY_NO_DMA_MASK
-		   | GRBM_STATUS__BCI_BUSY_MASK)) {
+		   GRBM_STATUS__SPI_BUSY_MASK | GRBM_STATUS__GE_BUSY_NO_DMA_MASK)) {
 		grbm_soft_reset = REG_SET_FIELD(grbm_soft_reset,
 						GRBM_SOFT_RESET, SOFT_RESET_CP,
 						1);
@@ -7449,7 +7448,6 @@ static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 	    (AMD_CG_SUPPORT_GFX_MGCG |
 	     AMD_CG_SUPPORT_GFX_CGLS |
 	     AMD_CG_SUPPORT_GFX_CGCG |
-	     AMD_CG_SUPPORT_GFX_CGLS |
 	     AMD_CG_SUPPORT_GFX_3D_CGCG |
 	     AMD_CG_SUPPORT_GFX_3D_CGLS))
 		gfx_v10_0_enable_gui_idle_interrupt(adev, enable);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
