Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0733CA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 13:41:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72C4310EB1E;
	Fri, 22 Aug 2025 13:41:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=listout.xyz header.i=@listout.xyz header.b="s+jGAUic";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D354310E37A
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 13:09:24 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4c73Yv1V1cz9tJx;
 Thu, 21 Aug 2025 15:09:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
 t=1755781763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=52AW3vX2G/gONvQRliEmju8kdN4K7aQivHGiuzDOHmM=;
 b=s+jGAUic/ET4f3uS8kGl/sLr8obP/gvQlWLnXAU7A/5pRIpCSJuw48ObfQD4kqqOL2GWxy
 okDa/fq/dfTkmxuxZGxqfTW1YStwNU9pitzLoWRItb35yCYOeNZjMVn2U7C+KtwpKZgMAq
 SuG3NpGCf6zIegVozyX/xbCcj7kbngzhX3JZ1nmEgz8CTggPBDOYItayjbsGX6teJD2eKv
 NXl4JtrUYVAmDUkuKHWM28BE7A9uPGrsGUCpxXwCDGXkAuR79vu8/St1YARB8QhzRDcbPZ
 PTTLyADBSHraW+k936OhCXcYglKh8quexx+XSBhGvk4juDSYBxjSNqzk6W8jzg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of listout@listout.xyz designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=listout@listout.xyz
From: Brahmajit Das <listout@listout.xyz>
To: alexander.deucher@amd.com
Cc: Christian.Koenig@amd.com, Jun.Lei@amd.com, Qingqing.Zhuo@amd.com,
 alexdeucher@gmail.com, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, listout@listout.xyz
Subject: [PATCH v2] drm/amd/display: clean-up dead code in dml2_mall_phantom
Date: Thu, 21 Aug 2025 18:39:09 +0530
Message-ID: <20250821130909.25428-1-listout@listout.xyz>
In-Reply-To: <BL1PR12MB5144269A278EED9AC3CCEE7EF733A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <BL1PR12MB5144269A278EED9AC3CCEE7EF733A@BL1PR12MB5144.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4c73Yv1V1cz9tJx
X-Mailman-Approved-At: Fri, 22 Aug 2025 13:41:00 +0000
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

pipe_idx in funtion dml2_svp_validate_static_schedulabilit, although set
is never actually used. While building with GCC 16 this gives a warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_mall_phantom.c: In function ‘set_phantom_stream_timing’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_mall_phantom.c:657:25: warning: variable ‘pipe_idx’ set but not used [-Wunused-but-set-variable=]
  657 |         unsigned int i, pipe_idx;
      |                         ^~~~~~~~

Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
v1 -> v2: leaving declaration above
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c
index a56e75cdf712..c59f825cfae9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c
@@ -654,14 +654,14 @@ static void set_phantom_stream_timing(struct dml2_context *ctx, struct dc_state
 				     unsigned int svp_height,
 				     unsigned int svp_vstartup)
 {
-	unsigned int i, pipe_idx;
+	unsigned int i;
 	double line_time, fp_and_sync_width_time;
 	struct pipe_ctx *pipe;
 	uint32_t phantom_vactive, phantom_bp, pstate_width_fw_delay_lines;
 	static const double cvt_rb_vblank_max = ((double) 460 / (1000 * 1000));
 
 	// Find DML pipe index (pipe_idx) using dc_pipe_idx
-	for (i = 0, pipe_idx = 0; i < ctx->config.dcn_pipe_count; i++) {
+	for (i = 0; i < ctx->config.dcn_pipe_count; i++) {
 		pipe = &state->res_ctx.pipe_ctx[i];
 
 		if (!pipe->stream)
@@ -669,8 +669,6 @@ static void set_phantom_stream_timing(struct dml2_context *ctx, struct dc_state
 
 		if (i == dc_pipe_idx)
 			break;
-
-		pipe_idx++;
 	}
 
 	// Calculate lines required for pstate allow width and FW processing delays
-- 
2.51.0

