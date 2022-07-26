Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B7EC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 12:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BE028FA77;
	Tue, 26 Jul 2022 12:54:21 +0000 (UTC)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6678E11BE7C;
 Tue, 26 Jul 2022 07:27:21 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R481e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=jiapeng.chong@linux.alibaba.com; NM=1; PH=DS; RN=10; SR=0;
 TI=SMTPD_---0VKUPgsP_1658820434; 
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com
 fp:SMTPD_---0VKUPgsP_1658820434) by smtp.aliyun-inc.com;
 Tue, 26 Jul 2022 15:27:16 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: alexander.deucher@amd.com
Subject: [PATCH 13/20] drm/amd/display: Clean up some inconsistent indenting
Date: Tue, 26 Jul 2022 15:25:48 +0800
Message-Id: <20220726072555.91323-13-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220726072555.91323-1-jiapeng.chong@linux.alibaba.com>
References: <20220726072555.91323-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 26 Jul 2022 12:54:21 +0000
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
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, airlied@linux.ie,
 Xinhui.Pan@amd.com, Abaci Robot <abaci@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, daniel@ffwll.ch, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No functional modification involved.

smatch warnings:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_mpc.c:305 mpc20_get_ogam_current() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c  | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
index 15734db0cdea..3d307dd58e9a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
@@ -299,24 +299,24 @@ static enum dc_lut_mode mpc20_get_ogam_current(struct mpc *mpc, int mpcc_id)
 	uint32_t state_mode;
 	struct dcn20_mpc *mpc20 = TO_DCN20_MPC(mpc);
 
-	REG_GET(MPCC_OGAM_LUT_RAM_CONTROL[mpcc_id],
-			MPCC_OGAM_CONFIG_STATUS, &state_mode);
-
-		switch (state_mode) {
-		case 0:
-			mode = LUT_BYPASS;
-			break;
-		case 1:
-			mode = LUT_RAM_A;
-			break;
-		case 2:
-			mode = LUT_RAM_B;
-			break;
-		default:
-			mode = LUT_BYPASS;
-			break;
-		}
-		return mode;
+	REG_GET(MPCC_OGAM_LUT_RAM_CONTROL[mpcc_id], MPCC_OGAM_CONFIG_STATUS, &state_mode);
+
+	switch (state_mode) {
+	case 0:
+		mode = LUT_BYPASS;
+		break;
+	case 1:
+		mode = LUT_RAM_A;
+		break;
+	case 2:
+		mode = LUT_RAM_B;
+		break;
+	default:
+		mode = LUT_BYPASS;
+		break;
+	}
+
+	return mode;
 }
 
 static void mpc2_program_lutb(struct mpc *mpc, int mpcc_id,
-- 
2.20.1.7.g153144c

