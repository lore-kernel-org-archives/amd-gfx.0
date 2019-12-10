Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71608C2D0C4
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 21:17:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 471AE20652
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 21:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYsMBrNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 471AE20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9FDB6E96C;
	Tue, 10 Dec 2019 21:17:24 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60F9A6E96D
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 21:17:23 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 674B8246B6;
 Tue, 10 Dec 2019 21:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576012208;
 bh=osEMQ+qjmPG568bwq3Y3oZd6+35Cqc6/K7SPM9SAm24=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AYsMBrNUu4O6C739L78hFjOmDIrMbkl1orucS7TJCA0dHrdL34hC7zarEIo9Kuol9
 FRjOier54+NlUano2ImIwidcpO9bdtfaC1xSVIjn7eyGO3+EM03riGZdeJMBo/aaF5
 GWYpyVujBsQ4/+wUY702Nte8YPymU71B8Xz9U2vc=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 160/350] drm/amd/display: setting the DIG_MODE to
 the correct value.
Date: Tue, 10 Dec 2019 16:04:25 -0500
Message-Id: <20191210210735.9077-121-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Zhan liu <zhan.liu@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Zhan liu <zhan.liu@amd.com>

[ Upstream commit 967a3b85bac91c55eff740e61bf270c2732f48b2 ]

[Why]
This patch is for fixing Navi14 HDMI display pink screen issue.

[How]
Call stream->link->link_enc->funcs->setup twice. This is setting
the DIG_MODE to the correct value after having been overridden by
the call to transmitter control.

Signed-off-by: Zhan Liu <zhan.liu@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index efc1d30544bb6..067f5579f4523 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2769,6 +2769,15 @@ void core_link_enable_stream(
 					CONTROLLER_DP_TEST_PATTERN_VIDEOMODE,
 					COLOR_DEPTH_UNDEFINED);
 
+		/* This second call is needed to reconfigure the DIG
+		 * as a workaround for the incorrect value being applied
+		 * from transmitter control.
+		 */
+		if (!dc_is_virtual_signal(pipe_ctx->stream->signal))
+			stream->link->link_enc->funcs->setup(
+				stream->link->link_enc,
+				pipe_ctx->stream->signal);
+
 #ifdef CONFIG_DRM_AMD_DC_DSC_SUPPORT
 		if (pipe_ctx->stream->timing.flags.DSC) {
 			if (dc_is_dp_signal(pipe_ctx->stream->signal) ||
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
