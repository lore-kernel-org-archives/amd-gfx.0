Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A012BC43461
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 16:37:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F3C061369
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 16:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3C061369
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D2F06E950;
	Mon,  3 May 2021 16:37:16 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D09416E94D;
 Mon,  3 May 2021 16:37:14 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8944D613CB;
 Mon,  3 May 2021 16:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620059834;
 bh=gAVXaa3NI2xdJ61efYa5M26EA5yeVATgEjR2hwATB8U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=T3Va7bcDHBjhfLiBmhi9ohYStHmbqqExKqSqKnQLylBnUnnYLZdFIMgqyIk/cwk/R
 HqSZIVuFIBH8cymdawaiFP4XtRWBgFey6Uo+hI9/wtLDNjISq8XM9ml3hrvSL7f0F3
 cwgJJ+MBKQnJ2GihgNS66Mvce8nl65pxUUHspuYhGqyiqXvjPx4BroeejzONKPszU0
 CrBShnfzuR4LeaL9haR/pV/etD0wpLHJdujUL6Fbg2GMOKToAJqKl8Z1i380pYsNRO
 h0s7s1Bq9lvnuDE87WNoHdWtLK+4N65nKNa67MHTKlF+DrMpus/xFHcjoaUVhm5dtP
 qJ+QEzdbbiftA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.11 009/115] drm/amd/display: Don't optimize
 bandwidth before disabling planes
Date: Mon,  3 May 2021 12:35:13 -0400
Message-Id: <20210503163700.2852194-9-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210503163700.2852194-1-sashal@kernel.org>
References: <20210503163700.2852194-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Aric Cyr <aric.cyr@amd.com>,
 amd-gfx@lists.freedesktop.org, Daniel Wheeler <daniel.wheeler@amd.com>,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Bindu Ramamurthy <bindu.r@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[ Upstream commit 6ad98e8aeb0106f453bb154933e8355849244990 ]

[Why]
There is a window of time where we optimize bandwidth due to no streams
enabled will enable PSTATE changing but HUBPs are not disabled yet.
This results in underflow counter increasing in some hotplug scenarios.

[How]
Set the optimize-bandwidth flag for later processing once all the HUBPs
are properly disabled.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 58eb0d69873a..ccac86347315 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2380,7 +2380,8 @@ static void commit_planes_do_stream_update(struct dc *dc,
 					if (pipe_ctx->stream_res.audio && !dc->debug.az_endpoint_mute_only)
 						pipe_ctx->stream_res.audio->funcs->az_disable(pipe_ctx->stream_res.audio);
 
-					dc->hwss.optimize_bandwidth(dc, dc->current_state);
+					dc->optimized_required = true;
+
 				} else {
 					if (dc->optimize_seamless_boot_streams == 0)
 						dc->hwss.prepare_bandwidth(dc, dc->current_state);
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
