Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42827C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 13:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE5F261154
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 13:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5F261154
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76DF26E489;
	Mon, 10 May 2021 13:57:54 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13AD46E46B;
 Mon, 10 May 2021 12:16:36 +0000 (UTC)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Ff0Mk3xNfzCrB0;
 Mon, 10 May 2021 20:13:54 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 20:16:26 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx
 <amd-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amd/display: Delete several unneeded bool conversions
Date: Mon, 10 May 2021 20:16:21 +0800
Message-ID: <20210510121621.3692-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 10 May 2021 13:57:54 +0000
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
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The result of an expression consisting of a single relational operator is
already of the bool type and does not need to be evaluated explicitly.

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c
index 8dc3d1f7398422e..2feb051a200294a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c
@@ -482,7 +482,7 @@ bool dpp20_program_blnd_lut(
 		next_mode = LUT_RAM_A;
 
 	dpp20_power_on_blnd_lut(dpp_base, true);
-	dpp20_configure_blnd_lut(dpp_base, next_mode == LUT_RAM_A ? true:false);
+	dpp20_configure_blnd_lut(dpp_base, next_mode == LUT_RAM_A);
 
 	if (next_mode == LUT_RAM_A)
 		dpp20_program_blnd_luta_settings(dpp_base, params);
@@ -893,7 +893,7 @@ bool dpp20_program_shaper(
 	else
 		next_mode = LUT_RAM_A;
 
-	dpp20_configure_shaper_lut(dpp_base, next_mode == LUT_RAM_A ? true:false);
+	dpp20_configure_shaper_lut(dpp_base, next_mode == LUT_RAM_A);
 
 	if (next_mode == LUT_RAM_A)
 		dpp20_program_shaper_luta_settings(dpp_base, params);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
index 910c17fd4278932..950c9bfd53de516 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
@@ -874,7 +874,7 @@ bool mpc3_program_shaper(
 	else
 		next_mode = LUT_RAM_A;
 
-	mpc3_configure_shaper_lut(mpc, next_mode == LUT_RAM_A ? true:false, rmu_idx);
+	mpc3_configure_shaper_lut(mpc, next_mode == LUT_RAM_A, rmu_idx);
 
 	if (next_mode == LUT_RAM_A)
 		mpc3_program_shaper_luta_settings(mpc, params, rmu_idx);
-- 
2.26.0.106.g9fadedd


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
