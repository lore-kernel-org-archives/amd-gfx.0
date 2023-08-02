Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C68C04A94
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 07:20:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9238E10E4FC;
	Wed,  2 Aug 2023 07:20:15 +0000 (UTC)
Received: from out28-93.mail.aliyun.com (out28-93.mail.aliyun.com
 [115.124.28.93])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03DBD10E1E2;
 Wed,  2 Aug 2023 01:48:10 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.2541763|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_alarm|0.0473417-0.000161502-0.952497; FP=0|0|0|0|0|-1|-1|-1;
 HT=ay29a033018047202; MF=sunran001@208suo.com; NM=1; PH=DS; RN=5; RT=5; SR=0;
 TI=SMTPD_---.U6Jxphb_1690940881; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U6Jxphb_1690940881) by smtp.aliyun-inc.com;
 Wed, 02 Aug 2023 09:48:03 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amd/pm: Clean up errors in hwmgr.h
Date: Wed,  2 Aug 2023 01:48:00 +0000
Message-Id: <20230802014800.8945-1-sunran001@208suo.com>
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

ERROR: open brace '{' following struct go on the same line
ERROR: Use C99 flexible arrays

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
index 612d66aeaab9..81650727a5de 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -190,8 +190,7 @@ struct phm_vce_clock_voltage_dependency_table {
 };
 
 
-enum SMU_ASIC_RESET_MODE
-{
+enum SMU_ASIC_RESET_MODE {
     SMU_ASIC_RESET_MODE_0,
     SMU_ASIC_RESET_MODE_1,
     SMU_ASIC_RESET_MODE_2,
@@ -516,7 +515,7 @@ struct phm_vq_budgeting_record {
 
 struct phm_vq_budgeting_table {
 	uint8_t numEntries;
-	struct phm_vq_budgeting_record entries[1];
+	struct phm_vq_budgeting_record entries[0];
 };
 
 struct phm_clock_and_voltage_limits {
@@ -607,8 +606,7 @@ struct phm_ppt_v2_information {
 	uint8_t  uc_dcef_dpm_voltage_mode;
 };
 
-struct phm_ppt_v3_information
-{
+struct phm_ppt_v3_information {
 	uint8_t uc_thermal_controller_type;
 
 	uint16_t us_small_power_limit1;
-- 
2.17.1

