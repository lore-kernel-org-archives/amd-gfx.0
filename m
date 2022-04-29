Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709AAC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 13:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 219E810ECC5;
	Fri, 29 Apr 2022 13:03:55 +0000 (UTC)
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5DE310E120;
 Fri, 29 Apr 2022 01:51:35 +0000 (UTC)
X-UUID: 2ab20950c02e4493b64e1d83814cadc0-20220429
X-UUID: 2ab20950c02e4493b64e1d83814cadc0-20220429
Received: from cs2c.com.cn [(172.17.111.24)] by nksmu.kylinos.cn
 (envelope-from <pengfuyuan@kylinos.cn>) (Generic MTA)
 with ESMTP id 54080229; Fri, 29 Apr 2022 09:49:55 +0800
X-ns-mid: postfix-626B449E-3508122180
Received: from localhost.localdomain (unknown [172.20.4.120])
 by cs2c.com.cn (NSMail) with ESMTPA id 20BCC3848647;
 Fri, 29 Apr 2022 01:51:26 +0000 (UTC)
From: pengfuyuan <pengfuyuan@kylinos.cn>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] gpu/drm/radeon: Fix spelling typo in comments
Date: Fri, 29 Apr 2022 09:51:14 +0800
Message-Id: <20220429015114.29795-1-pengfuyuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 29 Apr 2022 13:03:53 +0000
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
Cc: David Airlie <airlied@linux.ie>, Xinhui.Pan@amd.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 pengfuyuan <pengfuyuan@kylinos.cn>, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix spelling typo in comments.

Signed-off-by: pengfuyuan <pengfuyuan@kylinos.cn>
---
 drivers/gpu/drm/radeon/atombios.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atombios.h b/drivers/gpu/drm/radeon/atombios.h
index bd5dc09e860f..da35a970fcc0 100644
--- a/drivers/gpu/drm/radeon/atombios.h
+++ b/drivers/gpu/drm/radeon/atombios.h
@@ -3599,7 +3599,7 @@ typedef struct  _ATOM_LCD_RTS_RECORD
   UCHAR     ucRTSValue;
 }ATOM_LCD_RTS_RECORD;
 
-//!! If the record below exits, it shoud always be the first record for easy use in command table!!! 
+//!! If the record below exists, it should always be the first record for easy use in command table!!!
 // The record below is only used when LVDS_Info is present. From ATOM_LVDS_INFO_V12, use ucLCDPanel_SpecialHandlingCap instead.
 typedef struct  _ATOM_LCD_MODE_CONTROL_CAP
 {
@@ -3823,7 +3823,7 @@ typedef struct _ATOM_DPCD_INFO
 // Note1: This table is filled by SetBiosReservationStartInFB in CoreCommSubs.asm
 //        at running time.   
 // note2: From RV770, the memory is more than 32bit addressable, so we will change 
-//        ucTableFormatRevision=1,ucTableContentRevision=4, the strcuture remains 
+//        ucTableFormatRevision=1,ucTableContentRevision=4, the structure remains
 //        exactly same as 1.1 and 1.2 (1.3 is never in use), but ulStartAddrUsedByFirmware 
 //        (in offset to start of memory address) is KB aligned instead of byte aligend.
 /***********************************************************************************/	
@@ -3858,7 +3858,7 @@ typedef struct _ATOM_VRAM_USAGE_BY_FIRMWARE
   ATOM_FIRMWARE_VRAM_RESERVE_INFO	asFirmwareVramReserveInfo[ATOM_MAX_FIRMWARE_VRAM_USAGE_INFO];
 }ATOM_VRAM_USAGE_BY_FIRMWARE;
 
-// change verion to 1.5, when allow driver to allocate the vram area for command table access. 
+// change version to 1.5, when allow driver to allocate the vram area for command table access.
 typedef struct _ATOM_FIRMWARE_VRAM_RESERVE_INFO_V1_5
 {
   ULONG   ulStartAddrUsedByFirmware;
@@ -5973,7 +5973,7 @@ typedef struct _ATOM_ASIC_INTERNAL_SS_INFO_V3
 #define CLEAR_ATOM_S7_DOS_8BIT_DAC_EN         ((ATOM_DOS_MODE_INFO_DEF << 8 )|ATOM_S7_DOS_8BIT_DAC_EN_SHIFT | ATOM_FLAG_CLEAR )
 
 /****************************************************************************/	
-//Portion II: Definitinos only used in Driver
+//Portion II: Definitions only used in Driver
 /****************************************************************************/
 
 // Macros used by driver
@@ -7162,7 +7162,7 @@ typedef struct _DP_ENCODER_SERVICE_PARAMETERS
 
 // ucAction
 #define ATOM_DP_ACTION_GET_SINK_TYPE							0x01
-/* obselete */
+/* obsolete */
 #define ATOM_DP_ACTION_TRAINING_START							0x02
 #define ATOM_DP_ACTION_TRAINING_COMPLETE					0x03
 #define ATOM_DP_ACTION_TRAINING_PATTERN_SEL				0x04
-- 
2.25.1

