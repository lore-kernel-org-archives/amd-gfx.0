Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F89EB64DD
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Aug 2023 08:28:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33C4B10E355;
	Tue,  1 Aug 2023 08:28:08 +0000 (UTC)
Received: from out28-121.mail.aliyun.com (out28-121.mail.aliyun.com
 [115.124.28.121])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D58210E316;
 Tue,  1 Aug 2023 07:55:19 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.3847548|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_alarm|0.00255057-0.000655741-0.996794; FP=0|0|0|0|0|-1|-1|-1;
 HT=ay29a033018047199; MF=sunran001@208suo.com; NM=1; PH=DS; RN=7; RT=7; SR=0;
 TI=SMTPD_---.U5l-U8X_1690876509; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U5l-U8X_1690876509) by smtp.aliyun-inc.com;
 Tue, 01 Aug 2023 15:55:11 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch
Subject: [PATCH] drm/amdgpu: Clean up errors in common_baco.c
Date: Tue,  1 Aug 2023 07:55:07 +0000
Message-Id: <20230801075507.6377-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Tue, 01 Aug 2023 08:27:46 +0000
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

ERROR: code indent should use tabs where possible

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/common_baco.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/common_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/common_baco.c
index 1c73776bd606..fd79337a3536 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/common_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/common_baco.c
@@ -42,7 +42,7 @@ static bool baco_wait_register(struct pp_hwmgr *hwmgr, u32 reg, u32 mask, u32 va
 }
 
 static bool baco_cmd_handler(struct pp_hwmgr *hwmgr, u32 command, u32 reg, u32 mask,
-			        u32 shift, u32 value, u32 timeout)
+				u32 shift, u32 value, u32 timeout)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
 	u32 data;
-- 
2.17.1

