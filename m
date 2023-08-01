Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F12AC04E69
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 07:20:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB24B10E4E8;
	Wed,  2 Aug 2023 07:20:11 +0000 (UTC)
Received: from out28-170.mail.aliyun.com (out28-170.mail.aliyun.com
 [115.124.28.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A03E10E368;
 Tue,  1 Aug 2023 09:14:36 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1113862|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_alarm|0.0177519-0.00266611-0.979582; FP=0|0|0|0|0|-1|-1|-1;
 HT=ay29a033018047212; MF=sunran001@208suo.com; NM=1; PH=DS; RN=7; RT=7; SR=0;
 TI=SMTPD_---.U5qtWqJ_1690881266; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U5qtWqJ_1690881266) by smtp.aliyun-inc.com;
 Tue, 01 Aug 2023 17:14:30 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch
Subject: [PATCH] drm/amd: Clean up errors in processpptables.c
Date: Tue,  1 Aug 2023 09:14:25 +0000
Message-Id: <20230801091425.7181-1-sunran001@208suo.com>
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

ERROR: open brace '{' following function definitions go on the next line
ERROR: code indent should use tabs where possible
ERROR: space required before the open parenthesis '('

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
index 1866fe20f9e2..f05f011c78be 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
@@ -676,7 +676,7 @@ static PP_StateClassificationFlags make_classification_flags(
 static int init_non_clock_fields(struct pp_hwmgr *hwmgr,
 						struct pp_power_state *ps,
 							    uint8_t version,
-			 const ATOM_PPLIB_NONCLOCK_INFO *pnon_clock_info) 
+			 const ATOM_PPLIB_NONCLOCK_INFO *pnon_clock_info)
 {
 	unsigned long rrr_index;
 	unsigned long tmp;
-- 
2.17.1

