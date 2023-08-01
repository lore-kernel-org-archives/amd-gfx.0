Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA407C001DF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 07:20:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE91010E4C8;
	Wed,  2 Aug 2023 07:20:08 +0000 (UTC)
Received: from out28-100.mail.aliyun.com (out28-100.mail.aliyun.com
 [115.124.28.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3C5F10E366;
 Tue,  1 Aug 2023 08:40:33 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436259|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_system_inform|0.167007-0.0010792-0.831913;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047187; MF=sunran001@208suo.com; NM=1;
 PH=DS; RN=7; RT=7; SR=0; TI=SMTPD_---.U5oPFEH_1690879225; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U5oPFEH_1690879225) by smtp.aliyun-inc.com;
 Tue, 01 Aug 2023 16:40:28 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch
Subject: [PATCH] drm/amd/pm: Clean up errors in vega10_pptable.h
Date: Tue,  1 Aug 2023 08:40:24 +0000
Message-Id: <20230801084024.6826-1-sunran001@208suo.com>
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

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 .../amd/pm/powerplay/hwmgr/vega10_pptable.h    | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
index 9c479bd9a786..8b0590b834cc 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
@@ -317,16 +317,14 @@ typedef struct _ATOM_Vega10_Thermal_Controller {
     UCHAR ucFlags;          /* to be defined */
 } ATOM_Vega10_Thermal_Controller;
 
-typedef struct _ATOM_Vega10_VCE_State_Record
-{
+typedef struct _ATOM_Vega10_VCE_State_Record {
     UCHAR  ucVCEClockIndex;         /*index into usVCEDependencyTableOffset of 'ATOM_Vega10_MM_Dependency_Table' type */
     UCHAR  ucFlag;                  /* 2 bits indicates memory p-states */
     UCHAR  ucSCLKIndex;             /* index into ATOM_Vega10_SCLK_Dependency_Table */
     UCHAR  ucMCLKIndex;             /* index into ATOM_Vega10_MCLK_Dependency_Table */
 } ATOM_Vega10_VCE_State_Record;
 
-typedef struct _ATOM_Vega10_VCE_State_Table
-{
+typedef struct _ATOM_Vega10_VCE_State_Table {
     UCHAR ucRevId;
     UCHAR ucNumEntries;
     ATOM_Vega10_VCE_State_Record entries[1];
@@ -361,8 +359,7 @@ typedef struct _ATOM_Vega10_PowerTune_Table {
 	USHORT usTemperatureLimitTedge;
 } ATOM_Vega10_PowerTune_Table;
 
-typedef struct _ATOM_Vega10_PowerTune_Table_V2
-{
+typedef struct _ATOM_Vega10_PowerTune_Table_V2 {
 	UCHAR  ucRevId;
 	USHORT usSocketPowerLimit;
 	USHORT usBatteryPowerLimit;
@@ -388,8 +385,7 @@ typedef struct _ATOM_Vega10_PowerTune_Table_V2
 	USHORT usTemperatureLimitTedge;
 } ATOM_Vega10_PowerTune_Table_V2;
 
-typedef struct _ATOM_Vega10_PowerTune_Table_V3
-{
+typedef struct _ATOM_Vega10_PowerTune_Table_V3 {
 	UCHAR  ucRevId;
 	USHORT usSocketPowerLimit;
 	USHORT usBatteryPowerLimit;
@@ -428,15 +424,13 @@ typedef struct _ATOM_Vega10_Hard_Limit_Record {
     USHORT usVddMemLimit;
 } ATOM_Vega10_Hard_Limit_Record;
 
-typedef struct _ATOM_Vega10_Hard_Limit_Table
-{
+typedef struct _ATOM_Vega10_Hard_Limit_Table {
     UCHAR ucRevId;
     UCHAR ucNumEntries;
     ATOM_Vega10_Hard_Limit_Record entries[1];
 } ATOM_Vega10_Hard_Limit_Table;
 
-typedef struct _Vega10_PPTable_Generic_SubTable_Header
-{
+typedef struct _Vega10_PPTable_Generic_SubTable_Header {
     UCHAR  ucRevId;
 } Vega10_PPTable_Generic_SubTable_Header;
 
-- 
2.17.1

