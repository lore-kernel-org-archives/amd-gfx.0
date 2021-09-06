Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5DBC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 07:18:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DCBD6109D
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 07:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3DCBD6109D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E895889D02;
	Tue,  7 Sep 2021 07:18:32 +0000 (UTC)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA528898ED;
 Mon,  6 Sep 2021 09:42:49 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426;
 MF=jiapeng.chong@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0UnPH424_1630921355; 
Received: from
 j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com
 fp:SMTPD_---0UnPH424_1630921355) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 06 Sep 2021 17:42:47 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: alexander.deucher@amd.com
Cc: christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
 daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 chongjiapeng <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] drm/amd/display: make configure_lttpr_mode_transparent and
 configure_lttpr_mode_non_transparent static
Date: Mon,  6 Sep 2021 17:42:27 +0800
Message-Id: <1630921347-122646-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Mailman-Approved-At: Tue, 07 Sep 2021 07:18:31 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: chongjiapeng <jiapeng.chong@linux.alibaba.com>

This symbols is not used outside of dc_link_dp.c, so marks it static.

Fix the following sparse warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:1766:16:
warning: symbol 'configure_lttpr_mode_non_transparent' was not declared.
Should it be static?

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:1755:16:
warning: symbol 'configure_lttpr_mode_transparent' was not declared.
Should it be static?

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: chongjiapeng <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index a666401..4e2cf8f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1752,7 +1752,7 @@ uint8_t dp_convert_to_count(uint8_t lttpr_repeater_count)
 	return 0; // invalid value
 }
 
-enum dc_status configure_lttpr_mode_transparent(struct dc_link *link)
+static enum dc_status configure_lttpr_mode_transparent(struct dc_link *link)
 {
 	uint8_t repeater_mode = DP_PHY_REPEATER_MODE_TRANSPARENT;
 
@@ -1763,7 +1763,7 @@ enum dc_status configure_lttpr_mode_transparent(struct dc_link *link)
 			sizeof(repeater_mode));
 }
 
-enum dc_status configure_lttpr_mode_non_transparent(
+static enum dc_status configure_lttpr_mode_non_transparent(
 		struct dc_link *link,
 		const struct link_training_settings *lt_settings)
 {
-- 
1.8.3.1

