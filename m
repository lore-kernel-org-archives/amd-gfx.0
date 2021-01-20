Return-Path: <SRS0=ixe6=GX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBB8C433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 01:26:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32ABB23109
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 01:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32ABB23109
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49B9689BBD;
	Wed, 20 Jan 2021 01:26:48 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E23AE89BBD;
 Wed, 20 Jan 2021 01:26:46 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F7E222472;
 Wed, 20 Jan 2021 01:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611106006;
 bh=9SutWEmC6H5K10bDfM/3ZW3pS0nEj9/MpovzFvWZN8Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sjpBpIKd5jnquEarxu/SLI84s01APmGU/UQYUj9s7aJ660wbuD8tJEjCVQ8ErnjND
 Tguz6uMb2H9lSizaOX4GF+oUA4u/zrffP76HwQWrfnuPgHe1r4W6JE3kFi+9rw/bJp
 3Zvw5pv5MhqtI7hDmsD1ERn9z57UdOQMT91ZK9BWH/7JVN2Dniy1ULMCmxEpHitOKX
 03kaqBLmqvy5Pbg3onOhdfnwA73mxv4TpQ4te2rI4DtXWHHPjsJuRX0H330Nbbi1mg
 U1HSDo+5SyYU2zOsfYfMPcp7+Fn47VJUbWf/pRVSylizU4ti/XD3Q+LK2XWMrGUz/Z
 82mpYSH6UYEjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 33/45] drm/amd/display: disable dcn10 pipe split
 by default
Date: Tue, 19 Jan 2021 20:25:50 -0500
Message-Id: <20210120012602.769683-33-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210120012602.769683-1-sashal@kernel.org>
References: <20210120012602.769683-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, "Li, Roman" <Roman.Li@amd.com>,
 amd-gfx@lists.freedesktop.org, Daniel Wheeler <daniel.wheeler@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Li, Roman" <Roman.Li@amd.com>

[ Upstream commit 9d03bb102028b4a3f4a64d6069b219e2e1c1f306 ]

[Why]
The initial purpose of dcn10 pipe split is to support some high
bandwidth mode which requires dispclk greater than max dispclk. By
initial bring up power measurement data, it showed power consumption is
less with pipe split for dcn block. This could be reason for enable pipe
split by default. By battery life measurement of some Chromebooks,
result shows battery life is longer with pipe split disabled.

[How]
Disable pipe split by default. Pipe split could be still enabled when
required dispclk is greater than max dispclk.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Reviewed-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index a78712caf1244..0524d6f1adba6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -608,8 +608,8 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.disable_pplib_clock_request = false,
 		.disable_pplib_wm_range = false,
 		.pplib_wm_report_mode = WM_REPORT_DEFAULT,
-		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
-		.force_single_disp_pipe_split = true,
+		.pipe_split_policy = MPC_SPLIT_AVOID,
+		.force_single_disp_pipe_split = false,
 		.disable_dcc = DCC_ENABLE,
 		.voltage_align_fclk = true,
 		.disable_stereo_support = true,
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
