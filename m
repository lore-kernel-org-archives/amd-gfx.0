Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E38C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jun 2022 14:50:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C32110E4D3;
	Wed, 22 Jun 2022 14:50:23 +0000 (UTC)
X-Greylist: delayed 438 seconds by postgrey-1.36 at gabe;
 Wed, 22 Jun 2022 14:31:18 UTC
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77EB210FB5F
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jun 2022 14:31:18 +0000 (UTC)
X-QQ-mid: bizesmtp75t1655907764tjha88os
Received: from ubuntu.localdomain ( [106.117.78.84])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 22 Jun 2022 22:22:39 +0800 (CST)
X-QQ-SSF: 01000000008000B0B000E00A0000000
X-QQ-FEAT: b/pVLV+mlKip3G7p5FLUdccNhNMJGNap4tmjqxhQsmY+xlWkotZM0d0aqBK+K
 lJAMsTjUe7vE5x0D7DMB+Z4I7e+B119gs7RsRUdmpMIaYn4tpqGQ7ZfPHDmAdeJP5MUb5Fs
 fqa1CprKk/UvQ1Wc732uV4P4xekdtdj5srB6vm8kele1ici2Cxl+h24WY/l0CfWBFOdlTVW
 mCg6BlsjbaV+5dOLhVx6dvq0dj1ECq3gId17RKqk8YYGFMw3fm39eAzySWqS2aQocU+8z4x
 Wdiudtw2c3pUWTN/FaQ0YjRvTfVl4YkOMimfC/783BdOQjk00a/3lNerlSuOmvrkP3nekdL
 4hxxxcWz3qBZd2CP1plSquggDaFqg==
X-QQ-GoodBg: 0
From: Jiang Jian <jiangjian@cdjrlc.com>
To: airlied@linux.ie,
	daniel@ffwll.ch
Subject: [PATCH] gpu/drm/radeon: Fix typo in comments
Date: Wed, 22 Jun 2022 22:22:37 +0800
Message-Id: <20220622142237.11492-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Mailman-Approved-At: Wed, 22 Jun 2022 14:50:22 +0000
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
Cc: Xinhui.Pan@amd.com, dri-devel@lists.freedesktop.org,
 Jiang Jian <jiangjian@cdjrlc.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove the repeated word 'and' from comments

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/gpu/drm/radeon/r300_reg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/r300_reg.h b/drivers/gpu/drm/radeon/r300_reg.h
index 60d5413bafa1..9d341cff63ee 100644
--- a/drivers/gpu/drm/radeon/r300_reg.h
+++ b/drivers/gpu/drm/radeon/r300_reg.h
@@ -1103,7 +1103,7 @@
  * The destination register index is in FPI1 (color) and FPI3 (alpha)
  * together with enable bits.
  * There are separate enable bits for writing into temporary registers
- * (DSTC_REG_* /DSTA_REG) and and program output registers (DSTC_OUTPUT_*
+ * (DSTC_REG_* /DSTA_REG) and program output registers (DSTC_OUTPUT_*
  * /DSTA_OUTPUT). You can write to both at once, or not write at all (the
  * same index must be used for both).
  *
-- 
2.17.1

