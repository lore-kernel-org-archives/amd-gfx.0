Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856D3EE6454
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Sep 2024 07:12:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADB9210E036;
	Thu, 12 Sep 2024 07:12:09 +0000 (UTC)
X-Greylist: delayed 1048 seconds by postgrey-1.36 at gabe;
 Thu, 12 Sep 2024 02:10:13 UTC
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6D3110E9D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Sep 2024 02:10:13 +0000 (UTC)
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X40nG5CmLz20nDL;
 Thu, 12 Sep 2024 09:52:34 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (unknown [7.185.36.200])
 by mail.maildlp.com (Postfix) with ESMTPS id 634E81401F1;
 Thu, 12 Sep 2024 09:52:41 +0800 (CST)
Received: from huawei.com (10.44.142.84) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Sep
 2024 09:52:41 +0800
From: Yu Liao <liaoyu15@huawei.com>
To: <alexander.deucher@amd.com>
CC: <liaoyu15@huawei.com>, <xiexiuqi@huawei.com>,
 <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
 <sunpeng.li@amd.com>, <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: remove unneeded semicolon
Date: Thu, 12 Sep 2024 09:48:50 +0800
Message-ID: <20240912014850.1016005-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.44.142.84]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-Mailman-Approved-At: Thu, 12 Sep 2024 07:12:08 +0000
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

Remove unneeded semicolon.

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
index 92238ff333a4..7595355281c2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
@@ -421,7 +421,7 @@ unsigned int dml2_calc_max_scaled_time(
 
 void dml2_extract_writeback_wm(struct dc_state *context, struct display_mode_lib_st *dml_core_ctx)
 {
-	int i, j = 0;;
+	int i, j = 0;
 	struct mcif_arb_params *wb_arb_params = NULL;
 	struct dcn_bw_writeback *bw_writeback = NULL;
 	enum mmhubbub_wbif_mode wbif_mode = PACKED_444_FP16; /*for now*/
-- 
2.33.0

