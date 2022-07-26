Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE7FC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 12:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAB5D8FAE5;
	Tue, 26 Jul 2022 12:54:44 +0000 (UTC)
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35D5D11BBE3;
 Tue, 26 Jul 2022 07:27:10 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=jiapeng.chong@linux.alibaba.com; NM=1; PH=DS; RN=10; SR=0;
 TI=SMTPD_---0VKUIM7m_1658820425; 
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com
 fp:SMTPD_---0VKUIM7m_1658820425) by smtp.aliyun-inc.com;
 Tue, 26 Jul 2022 15:27:07 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: alexander.deucher@amd.com
Subject: [PATCH 11/20] drm/amd/display: Clean up some inconsistent indenting
Date: Tue, 26 Jul 2022 15:25:46 +0800
Message-Id: <20220726072555.91323-11-jiapeng.chong@linux.alibaba.com>
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

smatch warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_optc.c:186 optc3_set_dsc_config() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
index 80136b5d7e48..d072997477dd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
@@ -180,11 +180,8 @@ void optc3_set_dsc_config(struct timing_generator *optc,
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
-	optc2_set_dsc_config(optc, dsc_mode, dsc_bytes_per_pixel,
-		dsc_slice_width);
-
-		REG_UPDATE(OTG_V_SYNC_A_CNTL, OTG_V_SYNC_MODE, 0);
-
+	optc2_set_dsc_config(optc, dsc_mode, dsc_bytes_per_pixel, dsc_slice_width);
+	REG_UPDATE(OTG_V_SYNC_A_CNTL, OTG_V_SYNC_MODE, 0);
 }
 
 void optc3_set_vrr_m_const(struct timing_generator *optc,
-- 
2.20.1.7.g153144c

