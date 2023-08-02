Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27642C04FDF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 07:20:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD0A510E505;
	Wed,  2 Aug 2023 07:20:18 +0000 (UTC)
Received: from out28-129.mail.aliyun.com (out28-129.mail.aliyun.com
 [115.124.28.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45DE410E496;
 Wed,  2 Aug 2023 06:16:48 +0000 (UTC)
X-Alimail-AntiSpam: AC=SUSPECT; BC=0.6541337|-1; BR=01201311R791b1; CH=blue;
 DM=|SUSPECT|false|; DS=CONTINUE|ham_alarm|0.028097-0.000655634-0.971247;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047203; MF=sunran001@208suo.com; NM=1;
 PH=DS; RN=5; RT=5; SR=0; TI=SMTPD_---.U6WzUYo_1690956999; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U6WzUYo_1690956999) by smtp.aliyun-inc.com;
 Wed, 02 Aug 2023 14:16:41 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amd/display: Clean up errors in dcn10_dpp_dscl.c
Date: Wed,  2 Aug 2023 06:16:35 +0000
Message-Id: <20230802061635.11243-1-sunran001@208suo.com>
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
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
index 7e140c35a0ce..5ca9ab8a76e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
@@ -197,8 +197,7 @@ static void dpp1_dscl_set_lb(
 			DITHER_EN, 0, /* Dithering enable: Disabled */
 			INTERLEAVE_EN, lb_params->interleave_en, /* Interleave source enable */
 			LB_DATA_FORMAT__ALPHA_EN, lb_params->alpha_en); /* Alpha enable */
-	}
-	else {
+	} else {
 		/* DSCL caps: pixel data processed in float format */
 		REG_SET_2(LB_DATA_FORMAT, 0,
 			INTERLEAVE_EN, lb_params->interleave_en, /* Interleave source enable */
-- 
2.17.1

