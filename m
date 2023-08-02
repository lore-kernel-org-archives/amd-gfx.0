Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760EFC04FE0
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 07:20:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB90010E4F1;
	Wed,  2 Aug 2023 07:20:17 +0000 (UTC)
Received: from out28-173.mail.aliyun.com (out28-173.mail.aliyun.com
 [115.124.28.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18CF710E498;
 Wed,  2 Aug 2023 06:20:35 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.3399406|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_alarm|0.0739442-0.00121786-0.924838; FP=0|0|0|0|0|-1|-1|-1;
 HT=ay29a033018047206; MF=sunran001@208suo.com; NM=1; PH=DS; RN=5; RT=5; SR=0;
 TI=SMTPD_---.U6Y2FoY_1690957226; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U6Y2FoY_1690957226) by smtp.aliyun-inc.com;
 Wed, 02 Aug 2023 14:20:29 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amd/display: Clean up errors in display_mode_vba_30.c
Date: Wed,  2 Aug 2023 06:20:25 +0000
Message-Id: <20230802062025.11332-1-sunran001@208suo.com>
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

ERROR: else should follow close brace '}'

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c  | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 9af1a43c042b..ad741a723c0e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -784,8 +784,7 @@ static unsigned int dscComputeDelay(enum output_format_class pixelFormat, enum o
 		Delay = Delay + 1;
 		//   sft
 		Delay = Delay + 1;
-	}
-	else {
+	} else {
 		//   sfr
 		Delay = Delay + 2;
 		//   dsccif
@@ -3489,8 +3488,7 @@ static double TruncToValidBPP(
 		if (Format == dm_n422) {
 			MinDSCBPP = 7;
 			MaxDSCBPP = 2 * DSCInputBitPerComponent - 1.0 / 16.0;
-		}
-		else {
+		} else {
 			MinDSCBPP = 8;
 			MaxDSCBPP = 3 * DSCInputBitPerComponent - 1.0 / 16.0;
 		}
-- 
2.17.1

