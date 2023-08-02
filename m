Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E59C04A6A
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 07:20:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3453010E4F8;
	Wed,  2 Aug 2023 07:20:14 +0000 (UTC)
Received: from out28-102.mail.aliyun.com (out28-102.mail.aliyun.com
 [115.124.28.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B02FC10E47F;
 Wed,  2 Aug 2023 01:59:52 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1085532|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_system_inform|0.0392941-0.000118786-0.960587;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047199; MF=sunran001@208suo.com; NM=1;
 PH=DS; RN=5; RT=5; SR=0; TI=SMTPD_---.U6KNjwR_1690941582; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U6KNjwR_1690941582) by smtp.aliyun-inc.com;
 Wed, 02 Aug 2023 09:59:44 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amd/pm: Clean up errors in smu75.h
Date: Wed,  2 Aug 2023 01:59:41 +0000
Message-Id: <20230802015941.9124-1-sunran001@208suo.com>
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

ERROR: space prohibited before open square bracket '['
ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/powerplay/inc/smu75.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/smu75.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu75.h
index 771523001533..7d5ed7751976 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/smu75.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/smu75.h
@@ -224,8 +224,8 @@ struct SMU7_LocalDpmScoreboard {
 	uint8_t  DteClampMode;
 	uint8_t  FpsClampMode;
 
-	uint16_t LevelResidencyCounters [SMU75_MAX_LEVELS_GRAPHICS];
-	uint16_t LevelSwitchCounters [SMU75_MAX_LEVELS_GRAPHICS];
+	uint16_t LevelResidencyCounters[SMU75_MAX_LEVELS_GRAPHICS];
+	uint16_t LevelSwitchCounters[SMU75_MAX_LEVELS_GRAPHICS];
 
 	void     (*TargetStateCalculator)(uint8_t);
 	void     (*SavedTargetStateCalculator)(uint8_t);
@@ -316,7 +316,7 @@ struct SMU7_VoltageScoreboard {
 
 	VoltageChangeHandler_t functionLinks[6];
 
-	uint16_t * VddcFollower1;
+	uint16_t *VddcFollower1;
 	int16_t  Driver_OD_RequestedVidOffset1;
 	int16_t  Driver_OD_RequestedVidOffset2;
 };
@@ -677,9 +677,9 @@ typedef struct SCS_CELL_t SCS_CELL_t;
 
 struct VFT_TABLE_t {
 	VFT_CELL_t    Cell[TEMP_RANGE_MAXSTEPS][NUM_VFT_COLUMNS];
-	uint16_t      AvfsGbv [NUM_VFT_COLUMNS];
-	uint16_t      BtcGbv  [NUM_VFT_COLUMNS];
-	int16_t       Temperature [TEMP_RANGE_MAXSTEPS];
+	uint16_t      AvfsGbv[NUM_VFT_COLUMNS];
+	uint16_t      BtcGbv[NUM_VFT_COLUMNS];
+	int16_t       Temperature[TEMP_RANGE_MAXSTEPS];
 
 #ifdef SMU__FIRMWARE_SCKS_PRESENT__1
 	SCS_CELL_t    ScksCell[TEMP_RANGE_MAXSTEPS][NUM_VFT_COLUMNS];
-- 
2.17.1

