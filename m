Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6207ECA0FF5
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Sep 2023 19:04:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D416C10E1E7;
	Fri,  1 Sep 2023 19:03:55 +0000 (UTC)
Received: from out30-111.freemail.mail.aliyun.com
 (out30-111.freemail.mail.aliyun.com [115.124.30.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65AB410E70D;
 Fri,  1 Sep 2023 01:29:36 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R481e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=yang.lee@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0VqzgJqc_1693531771; 
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com
 fp:SMTPD_---0VqzgJqc_1693531771) by smtp.aliyun-inc.com;
 Fri, 01 Sep 2023 09:29:31 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch,
 harry.wentland@amd.com, Rodrigo.Siqueira@amd.com
Subject: [PATCH -next 3/5] drm/amd/display: clean up some inconsistent
 indentings
Date: Fri,  1 Sep 2023 09:29:22 +0800
Message-Id: <20230901012924.120196-3-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20230901012924.120196-1-yang.lee@linux.alibaba.com>
References: <20230901012924.120196-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 01 Sep 2023 19:03:54 +0000
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
Cc: Yang Li <yang.lee@linux.alibaba.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn35/dcn35_hwseq.c:159 dcn35_init_hw() warn: inconsistent indentig

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 .../drm/amd/display/dc/dcn35/dcn35_hwseq.c    | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.c
index 666e2809d9dc..025849143254 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.c
@@ -155,22 +155,22 @@ void dcn35_init_hw(struct dc *dc)
 		res_pool->ref_clocks.xtalin_clock_inKhz =
 				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
 
-			if (res_pool->dccg && res_pool->hubbub) {
-
-				(res_pool->dccg->funcs->get_dccg_ref_freq)(res_pool->dccg,
-						dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency,
-						&res_pool->ref_clocks.dccg_ref_clock_inKhz);
-
-				(res_pool->hubbub->funcs->get_dchub_ref_freq)(res_pool->hubbub,
-						res_pool->ref_clocks.dccg_ref_clock_inKhz,
-						&res_pool->ref_clocks.dchub_ref_clock_inKhz);
-			} else {
-				// Not all ASICs have DCCG sw component
-				res_pool->ref_clocks.dccg_ref_clock_inKhz =
-						res_pool->ref_clocks.xtalin_clock_inKhz;
-				res_pool->ref_clocks.dchub_ref_clock_inKhz =
-						res_pool->ref_clocks.xtalin_clock_inKhz;
-			}
+		if (res_pool->dccg && res_pool->hubbub) {
+
+			(res_pool->dccg->funcs->get_dccg_ref_freq)(res_pool->dccg,
+				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency,
+				&res_pool->ref_clocks.dccg_ref_clock_inKhz);
+
+			(res_pool->hubbub->funcs->get_dchub_ref_freq)(res_pool->hubbub,
+				res_pool->ref_clocks.dccg_ref_clock_inKhz,
+				&res_pool->ref_clocks.dchub_ref_clock_inKhz);
+		} else {
+			// Not all ASICs have DCCG sw component
+			res_pool->ref_clocks.dccg_ref_clock_inKhz =
+				res_pool->ref_clocks.xtalin_clock_inKhz;
+			res_pool->ref_clocks.dchub_ref_clock_inKhz =
+				res_pool->ref_clocks.xtalin_clock_inKhz;
+		}
 	} else
 		ASSERT_CRITICAL(false);
 
-- 
2.20.1.7.g153144c

