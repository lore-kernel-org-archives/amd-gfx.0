Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C03C04E69
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 07:20:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A707610E4FD;
	Wed,  2 Aug 2023 07:20:15 +0000 (UTC)
Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com
 [115.124.28.146])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16FDB10E14E;
 Wed,  2 Aug 2023 01:23:12 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436496|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.00356363-8.25022e-05-0.996354;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047201; MF=sunran001@208suo.com; NM=1;
 PH=DS; RN=5; RT=5; SR=0; TI=SMTPD_---.U6IxzhY_1690939383; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U6IxzhY_1690939383) by smtp.aliyun-inc.com;
 Wed, 02 Aug 2023 09:23:05 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amd/pm: Clean up errors in smu71.h
Date: Wed,  2 Aug 2023 01:23:02 +0000
Message-Id: <20230802012302.8498-1-sunran001@208suo.com>
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
ERROR: space prohibited before open square bracket '['

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/powerplay/inc/smu71.h | 22 +++++++-------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/smu71.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu71.h
index 71c9b2d28640..b5f177412769 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/smu71.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/smu71.h
@@ -118,8 +118,7 @@ typedef struct {
 
 #endif
 
-struct SMU71_PIDController
-{
+struct SMU71_PIDController {
     uint32_t Ki;
     int32_t LFWindupUpperLim;
     int32_t LFWindupLowerLim;
@@ -133,8 +132,7 @@ struct SMU71_PIDController
 
 typedef struct SMU71_PIDController SMU71_PIDController;
 
-struct SMU7_LocalDpmScoreboard
-{
+struct SMU7_LocalDpmScoreboard {
     uint32_t PercentageBusy;
 
     int32_t  PIDError;
@@ -179,8 +177,8 @@ struct SMU7_LocalDpmScoreboard
     uint8_t  DteClampMode;
     uint8_t  FpsClampMode;
 
-    uint16_t LevelResidencyCounters [SMU71_MAX_LEVELS_GRAPHICS];
-    uint16_t LevelSwitchCounters [SMU71_MAX_LEVELS_GRAPHICS];
+    uint16_t LevelResidencyCounters[SMU71_MAX_LEVELS_GRAPHICS];
+    uint16_t LevelSwitchCounters[SMU71_MAX_LEVELS_GRAPHICS];
 
     void     (*TargetStateCalculator)(uint8_t);
     void     (*SavedTargetStateCalculator)(uint8_t);
@@ -200,8 +198,7 @@ typedef struct SMU7_LocalDpmScoreboard SMU7_LocalDpmScoreboard;
 
 #define SMU7_MAX_VOLTAGE_CLIENTS 12
 
-struct SMU7_VoltageScoreboard
-{
+struct SMU7_VoltageScoreboard {
     uint16_t CurrentVoltage;
     uint16_t HighestVoltage;
     uint16_t MaxVid;
@@ -325,8 +322,7 @@ typedef struct SMU7_PowerScoreboard SMU7_PowerScoreboard;
 
 // --------------------------------------------------------------------------------------------------
 
-struct SMU7_ThermalScoreboard
-{
+struct SMU7_ThermalScoreboard {
    int16_t  GpuLimit;
    int16_t  GpuHyst;
    uint16_t CurrGnbTemp;
@@ -360,8 +356,7 @@ typedef struct SMU7_ThermalScoreboard SMU7_ThermalScoreboard;
 #define SMU7_VCE_SCLK_HANDSHAKE_DISABLE                  0x00020000
 
 // All 'soft registers' should be uint32_t.
-struct SMU71_SoftRegisters
-{
+struct SMU71_SoftRegisters {
     uint32_t        RefClockFrequency;
     uint32_t        PmTimerPeriod;
     uint32_t        FeatureEnables;
@@ -413,8 +408,7 @@ struct SMU71_SoftRegisters
 
 typedef struct SMU71_SoftRegisters SMU71_SoftRegisters;
 
-struct SMU71_Firmware_Header
-{
+struct SMU71_Firmware_Header {
     uint32_t Digest[5];
     uint32_t Version;
     uint32_t HeaderSize;
-- 
2.17.1

