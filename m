Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D245C001DF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 07:20:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 905E889561;
	Wed,  2 Aug 2023 07:20:06 +0000 (UTC)
Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com
 [115.124.28.221])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40DA610E36F;
 Tue,  1 Aug 2023 09:19:14 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1145429|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_alarm|0.0510493-0.00536844-0.943582; FP=0|0|0|0|0|-1|-1|-1;
 HT=ay29a033018047198; MF=sunran001@208suo.com; NM=1; PH=DS; RN=7; RT=7; SR=0;
 TI=SMTPD_---.U5r7xrd_1690881546; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U5r7xrd_1690881546) by smtp.aliyun-inc.com;
 Tue, 01 Aug 2023 17:19:08 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch
Subject: [PATCH] drm/amd: Clean up errors in vega10_processpptables.c
Date: Tue,  1 Aug 2023 09:19:06 +0000
Message-Id: <20230801091906.7270-1-sunran001@208suo.com>
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

ERROR: "foo* bar" should be "foo *bar"
ERROR: space required before the open brace '{'
ERROR: space required before the open parenthesis '('

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
index bb90d8abf79b..3be616af327e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
@@ -372,9 +372,9 @@ static int get_mm_clock_voltage_table(
 	return 0;
 }
 
-static void get_scl_sda_value(uint8_t line, uint8_t *scl, uint8_t* sda)
+static void get_scl_sda_value(uint8_t line, uint8_t *scl, uint8_t *sda)
 {
-	switch(line){
+	switch (line) {
 	case Vega10_I2CLineID_DDC1:
 		*scl = Vega10_I2C_DDC1CLK;
 		*sda = Vega10_I2C_DDC1DATA;
@@ -954,7 +954,7 @@ static int init_powerplay_extended_tables(
 	if (!result && powerplay_table->usPixclkDependencyTableOffset)
 		result = get_pix_clk_voltage_dependency_table(hwmgr,
 				&pp_table_info->vdd_dep_on_pixclk,
-				(const ATOM_Vega10_PIXCLK_Dependency_Table*)
+				(const ATOM_Vega10_PIXCLK_Dependency_Table *)
 				pixclk_dep_table);
 
 	if (!result && powerplay_table->usPhyClkDependencyTableOffset)
-- 
2.17.1

