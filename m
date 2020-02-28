Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AF2C3F2D2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 17:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D6BC2469F
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 17:51:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6BC2469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A72946E0DA;
	Fri, 28 Feb 2020 17:51:34 +0000 (UTC)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00DC26F445;
 Fri, 28 Feb 2020 13:16:08 +0000 (UTC)
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <colin.king@canonical.com>)
 id 1j7fUs-0000UF-L0; Fri, 28 Feb 2020 13:16:06 +0000
From: Colin King <colin.king@canonical.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH][next] drm/amd/display: fix indentation issue on a hunk of code
Date: Fri, 28 Feb 2020 13:16:06 +0000
Message-Id: <20200228131606.65041-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 28 Feb 2020 17:51:34 +0000
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Colin Ian King <colin.king@canonical.com>

There are multiple statements that are indented incorrectly. Add
in the missing tabs.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 .../gpu/drm/amd/display/dc/calcs/dce_calcs.c  | 46 +++++++++----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
index 5d081c42e81b..2c6db379afae 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
@@ -3265,33 +3265,33 @@ bool bw_calcs(struct dc_context *ctx,
 				bw_fixed_to_int(bw_mul(data->
 					stutter_exit_watermark[9], bw_int_to_fixed(1000)));
 
-		calcs_output->stutter_entry_wm_ns[0].b_mark =
-			bw_fixed_to_int(bw_mul(data->
-				stutter_entry_watermark[4], bw_int_to_fixed(1000)));
-		calcs_output->stutter_entry_wm_ns[1].b_mark =
-			bw_fixed_to_int(bw_mul(data->
-				stutter_entry_watermark[5], bw_int_to_fixed(1000)));
-		calcs_output->stutter_entry_wm_ns[2].b_mark =
-			bw_fixed_to_int(bw_mul(data->
-				stutter_entry_watermark[6], bw_int_to_fixed(1000)));
-		if (ctx->dc->caps.max_slave_planes) {
-			calcs_output->stutter_entry_wm_ns[3].b_mark =
+			calcs_output->stutter_entry_wm_ns[0].b_mark =
 				bw_fixed_to_int(bw_mul(data->
-					stutter_entry_watermark[0], bw_int_to_fixed(1000)));
-			calcs_output->stutter_entry_wm_ns[4].b_mark =
+					stutter_entry_watermark[4], bw_int_to_fixed(1000)));
+			calcs_output->stutter_entry_wm_ns[1].b_mark =
 				bw_fixed_to_int(bw_mul(data->
-					stutter_entry_watermark[1], bw_int_to_fixed(1000)));
-		} else {
-			calcs_output->stutter_entry_wm_ns[3].b_mark =
+					stutter_entry_watermark[5], bw_int_to_fixed(1000)));
+			calcs_output->stutter_entry_wm_ns[2].b_mark =
 				bw_fixed_to_int(bw_mul(data->
-					stutter_entry_watermark[7], bw_int_to_fixed(1000)));
-			calcs_output->stutter_entry_wm_ns[4].b_mark =
+					stutter_entry_watermark[6], bw_int_to_fixed(1000)));
+			if (ctx->dc->caps.max_slave_planes) {
+				calcs_output->stutter_entry_wm_ns[3].b_mark =
+					bw_fixed_to_int(bw_mul(data->
+						stutter_entry_watermark[0], bw_int_to_fixed(1000)));
+				calcs_output->stutter_entry_wm_ns[4].b_mark =
+					bw_fixed_to_int(bw_mul(data->
+						stutter_entry_watermark[1], bw_int_to_fixed(1000)));
+			} else {
+				calcs_output->stutter_entry_wm_ns[3].b_mark =
+					bw_fixed_to_int(bw_mul(data->
+						stutter_entry_watermark[7], bw_int_to_fixed(1000)));
+				calcs_output->stutter_entry_wm_ns[4].b_mark =
+					bw_fixed_to_int(bw_mul(data->
+						stutter_entry_watermark[8], bw_int_to_fixed(1000)));
+			}
+			calcs_output->stutter_entry_wm_ns[5].b_mark =
 				bw_fixed_to_int(bw_mul(data->
-					stutter_entry_watermark[8], bw_int_to_fixed(1000)));
-		}
-		calcs_output->stutter_entry_wm_ns[5].b_mark =
-			bw_fixed_to_int(bw_mul(data->
-				stutter_entry_watermark[9], bw_int_to_fixed(1000)));
+					stutter_entry_watermark[9], bw_int_to_fixed(1000)));
 
 			calcs_output->urgent_wm_ns[0].b_mark =
 				bw_fixed_to_int(bw_mul(data->
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
