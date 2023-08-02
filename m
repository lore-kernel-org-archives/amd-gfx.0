Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E920C04E69
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 07:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A607D10E4F0;
	Wed,  2 Aug 2023 07:20:12 +0000 (UTC)
Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com
 [115.124.28.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A24910E49B;
 Wed,  2 Aug 2023 06:26:11 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.6958764|0.7372184; CH=green;
 DM=|SPAM|false|; DS=CONTINUE|ham_alarm|0.067393-0.00265674-0.92995;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047211; MF=sunran001@208suo.com; NM=1;
 PH=DS; RN=5; RT=5; SR=0; TI=SMTPD_---.U6XebAJ_1690957561; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U6XebAJ_1690957561) by smtp.aliyun-inc.com;
 Wed, 02 Aug 2023 14:26:02 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amd/display: Clean up errors in dce_clk_mgr.c
Date: Wed,  2 Aug 2023 06:25:59 +0000
Message-Id: <20230802062559.11421-1-sunran001@208suo.com>
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

ERROR: spaces required around that '?' (ctx:VxE)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c
index 07359eb89efc..e7acd6eec1fd 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c
@@ -640,7 +640,7 @@ static void dce11_pplib_apply_display_requirements(
 	 * on power saving.
 	 *
 	 */
-	pp_display_cfg->min_dcfclock_khz = (context->stream_count > 4)?
+	pp_display_cfg->min_dcfclock_khz = (context->stream_count > 4) ?
 			pp_display_cfg->min_engine_clock_khz : 0;
 
 	pp_display_cfg->min_engine_clock_deep_sleep_khz
-- 
2.17.1

