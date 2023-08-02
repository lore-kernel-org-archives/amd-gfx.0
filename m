Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8F6C04A94
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 07:20:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CC0D10E4D5;
	Wed,  2 Aug 2023 07:20:10 +0000 (UTC)
Received: from out28-133.mail.aliyun.com (out28-133.mail.aliyun.com
 [115.124.28.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 066CE10E485;
 Wed,  2 Aug 2023 02:40:05 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.4055942|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_alarm|0.00105794-0.000121474-0.998821; FP=0|0|0|0|0|-1|-1|-1;
 HT=ay29a033018047199; MF=sunran001@208suo.com; NM=1; PH=DS; RN=5; RT=5; SR=0;
 TI=SMTPD_---.U6N4oZg_1690943996; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U6N4oZg_1690943996) by smtp.aliyun-inc.com;
 Wed, 02 Aug 2023 10:39:58 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amd/display: Clean up errors in color_gamma.c
Date: Wed,  2 Aug 2023 02:39:55 +0000
Message-Id: <20230802023955.10014-1-sunran001@208suo.com>
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

ERROR: trailing whitespace
ERROR: else should follow close brace '}'

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index 67a062af3ab0..ff8e5708735d 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -359,7 +359,7 @@ static struct fixed31_32 translate_from_linear_space(
 		scratch_1 = dc_fixpt_add(one, args->a3);
 		/* In the first region (first 16 points) and in the
 		 * region delimited by START/END we calculate with
-		 * full precision to avoid error accumulation. 
+		 * full precision to avoid error accumulation.
 		 */
 		if ((cal_buffer->buffer_index >= PRECISE_LUT_REGION_START &&
 			cal_buffer->buffer_index <= PRECISE_LUT_REGION_END) ||
@@ -379,8 +379,7 @@ static struct fixed31_32 translate_from_linear_space(
 		scratch_1 = dc_fixpt_sub(scratch_1, args->a2);
 
 		return scratch_1;
-	}
-	else
+	} else
 		return dc_fixpt_mul(args->arg, args->a1);
 }
 
-- 
2.17.1

