Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E3BC0015E
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Aug 2023 08:27:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55E4C10E339;
	Tue,  1 Aug 2023 08:27:48 +0000 (UTC)
Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com
 [115.124.28.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17B2010E30C;
 Tue,  1 Aug 2023 06:04:53 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07723793|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0904852-0.0047855-0.904729;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047194; MF=sunran001@208suo.com; NM=1;
 PH=DS; RN=7; RT=7; SR=0; TI=SMTPD_---.U5eilLU_1690869884; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U5eilLU_1690869884) by smtp.aliyun-inc.com;
 Tue, 01 Aug 2023 14:04:46 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch
Subject: [PATCH] drm/amd/pm: Clean up errors in vega12_pptable.h
Date: Tue,  1 Aug 2023 06:04:43 +0000
Message-Id: <20230801060443.6090-1-sunran001@208suo.com>
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

ERROR: open brace '{' following struct go on the same line
ERROR: space prohibited before open square bracket '['

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega12_pptable.h   | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_pptable.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_pptable.h
index bf4f5095b80d..9b8435a4d306 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_pptable.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_pptable.h
@@ -72,8 +72,7 @@ enum ATOM_VEGA12_PPCLOCK_ID {
 typedef enum ATOM_VEGA12_PPCLOCK_ID ATOM_VEGA12_PPCLOCK_ID;
 
 
-typedef struct _ATOM_VEGA12_POWERPLAYTABLE
-{
+typedef struct _ATOM_VEGA12_POWERPLAYTABLE {
       struct atom_common_table_header sHeader;
       UCHAR  ucTableRevision;
       USHORT usTableSize;
@@ -92,11 +91,11 @@ typedef struct _ATOM_VEGA12_POWERPLAYTABLE
       USHORT usODPowerSavePowerLimit;
       USHORT usSoftwareShutdownTemp;
 
-      ULONG PowerSavingClockMax  [ATOM_VEGA12_PPCLOCK_COUNT];
-      ULONG PowerSavingClockMin  [ATOM_VEGA12_PPCLOCK_COUNT];
+      ULONG PowerSavingClockMax[ATOM_VEGA12_PPCLOCK_COUNT];
+      ULONG PowerSavingClockMin[ATOM_VEGA12_PPCLOCK_COUNT];
 
-      ULONG ODSettingsMax [ATOM_VEGA12_ODSETTING_COUNT];
-      ULONG ODSettingsMin [ATOM_VEGA12_ODSETTING_COUNT];
+      ULONG ODSettingsMax[ATOM_VEGA12_ODSETTING_COUNT];
+      ULONG ODSettingsMin[ATOM_VEGA12_ODSETTING_COUNT];
 
       USHORT usReserve[5];
 
-- 
2.17.1

