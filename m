Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14529C04A6A
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 07:20:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F4FA10E4D2;
	Wed,  2 Aug 2023 07:20:09 +0000 (UTC)
Received: from out28-149.mail.aliyun.com (out28-149.mail.aliyun.com
 [115.124.28.149])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CE0410E489;
 Wed,  2 Aug 2023 02:54:52 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.6822839|0.6520798; CH=green;
 DM=|SPAM|false|; DS=CONTINUE|ham_alarm|0.168779-0.00358723-0.827634;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047202; MF=sunran001@208suo.com; NM=1;
 PH=DS; RN=5; RT=5; SR=0; TI=SMTPD_---.U6NGrmo_1690944884; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U6NGrmo_1690944884) by smtp.aliyun-inc.com;
 Wed, 02 Aug 2023 10:54:46 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amd/display: Clean up errors in dce112_hw_sequencer.c
Date: Wed,  2 Aug 2023 02:54:43 +0000
Message-Id: <20230802025443.10458-1-sunran001@208suo.com>
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

ERROR: space required before the open brace '{'

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/display/dc/dce112/dce112_hw_sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_hw_sequencer.c
index 690caaaff019..0ef9ebb3c1e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_hw_sequencer.c
@@ -127,7 +127,7 @@ static bool dce112_enable_display_power_gating(
 	else
 		cntl = ASIC_PIPE_DISABLE;
 
-	if (power_gating != PIPE_GATING_CONTROL_INIT || controller_id == 0){
+	if (power_gating != PIPE_GATING_CONTROL_INIT || controller_id == 0) {
 
 		bp_result = dcb->funcs->enable_disp_power_gating(
 						dcb, controller_id + 1, cntl);
-- 
2.17.1

