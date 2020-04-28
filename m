Return-Path: <SRS0=QpD2=6M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39632C83008
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 12:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C28206D6
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 12:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C28206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A0696E46D;
	Tue, 28 Apr 2020 12:46:34 +0000 (UTC)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07D27894E0;
 Tue, 28 Apr 2020 06:31:48 +0000 (UTC)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id EFF1AB7B043C4871D755;
 Tue, 28 Apr 2020 14:31:44 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Apr 2020
 14:31:35 +0800
From: Jason Yan <yanaijie@huawei.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <Anthony.Koo@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/amd/display: remove duplicate assignment of dcn21_funcs
 members
Date: Tue, 28 Apr 2020 14:31:01 +0800
Message-ID: <20200428063101.25556-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Tue, 28 Apr 2020 12:46:32 +0000
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
Cc: Jason Yan <yanaijie@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following coccicheck warning:

drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c:31:51-52:
exit_optimized_pwr_state: first occurrence line 86, second occurrence
line 92
drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c:31:51-52:
optimize_pwr_state: first occurrence line 85, second occurrence line 91
drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c:31:51-52:
set_cursor_attribute: first occurrence line 71, second occurrence line
89
drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c:31:51-52:
set_cursor_position: first occurrence line 70, second occurrence line 88
drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c:31:51-52:
set_cursor_sdr_white_level: first occurrence line 72, second occurrence
line 90

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index 8410a6305a9a..fe64bcb49456 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -85,11 +85,6 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.optimize_pwr_state = dcn21_optimize_pwr_state,
 	.exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
-	.set_cursor_position = dcn10_set_cursor_position,
-	.set_cursor_attribute = dcn10_set_cursor_attribute,
-	.set_cursor_sdr_white_level = dcn10_set_cursor_sdr_white_level,
-	.optimize_pwr_state = dcn21_optimize_pwr_state,
-	.exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
 	.power_down = dce110_power_down,
 };
 
-- 
2.21.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
