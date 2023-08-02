Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AB5C0729B
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 07:20:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A0A210E50B;
	Wed,  2 Aug 2023 07:20:20 +0000 (UTC)
Received: from out28-126.mail.aliyun.com (out28-126.mail.aliyun.com
 [115.124.28.126])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7EEB10E183;
 Wed,  2 Aug 2023 02:15:16 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.4795925|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_alarm|0.198135-0.00156503-0.8003; FP=0|0|0|0|0|-1|-1|-1;
 HT=ay29a033018047188; MF=sunran001@208suo.com; NM=1; PH=DS; RN=5; RT=5; SR=0;
 TI=SMTPD_---.U6L.8nL_1690942507; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U6L.8nL_1690942507) by smtp.aliyun-inc.com;
 Wed, 02 Aug 2023 10:15:09 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amd/pm: Clean up errors in r600_dpm.h
Date: Wed,  2 Aug 2023 02:15:04 +0000
Message-Id: <20230802021504.9439-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Wed, 02 Aug 2023 07:20:04 +0000
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
Cc: Ran Sun <sunran001@208suo.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following errors reported by checkpatch:

ERROR: that open brace { should be on the previous line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/r600_dpm.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/r600_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/r600_dpm.h
index 055321f61ca7..3e7caa715533 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/r600_dpm.h
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/r600_dpm.h
@@ -117,8 +117,7 @@ enum r600_display_watermark {
 	R600_DISPLAY_WATERMARK_HIGH = 1,
 };
 
-enum r600_display_gap
-{
+enum r600_display_gap {
     R600_PM_DISPLAY_GAP_VBLANK_OR_WM = 0,
     R600_PM_DISPLAY_GAP_VBLANK       = 1,
     R600_PM_DISPLAY_GAP_WATERMARK    = 2,
-- 
2.17.1

