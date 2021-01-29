Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1B8C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 15:37:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 136B164E08
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 15:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136B164E08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E5AF6EB6A;
	Fri, 29 Jan 2021 15:37:56 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29A886EB68;
 Fri, 29 Jan 2021 15:37:53 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E400464E20;
 Fri, 29 Jan 2021 15:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611934673;
 bh=QHgxueEDRYVRGiS1NoUc2gkhOgR2nFDtfZVzB9GvPbU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HuNi6saVEGBnq5+DkgBQbJUEOnDi8+46aASy0gd/1g6Bl0O8vWdas6nU+gzVl+dJu
 bMjsNCRuwxiMbw2gzsFjT3F3fqL8YwbHi7g9djRwCTgOj+kHuaHoak++Z77UG5gD66
 FvBXfPPlEFZgFwRckEF5993MM2EnwcGGIh+JkBVV9rZywrtfS7wTwXkC6NhYWOIhDd
 tksgt6hopGYqAnC4fIhIMUmf3giADab3nuwn2+2rDaRiTG1Y+Ap1BPuu/uH4atbo7u
 B2dCnlYZ1a7JrD4cRBc38K3DYQXmnP6PCOsCEXoqn1X2OgTvP4DrjJsRIwhMZEtvRh
 uxqQWAcGQsQrg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 31/41] drm/amd/display: Change function
 decide_dp_link_settings to avoid infinite looping
Date: Fri, 29 Jan 2021 10:37:02 -0500
Message-Id: <20210129153713.1592185-31-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210129153713.1592185-1-sashal@kernel.org>
References: <20210129153713.1592185-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Anson Jacob <anson.jacob@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>, dri-devel@lists.freedesktop.org,
 Bing Guo <bing.guo@amd.com>, Jun Lei <Jun.Lei@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bing Guo <bing.guo@amd.com>

[ Upstream commit 4716a7c50c5c66d6ddc42401e1e0ba13b492e105 ]

Why:
Function decide_dp_link_settings() loops infinitely when required bandwidth
can't be supported.

How:
Check the required bandwidth against verified_link_cap before trying to
find a link setting for it.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Bing Guo <bing.guo@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <anson.jacob@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 98464886341f6..004e2b32e02fa 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2375,6 +2375,9 @@ static bool decide_dp_link_settings(struct dc_link *link, struct dc_link_setting
 			initial_link_setting;
 	uint32_t link_bw;
 
+	if (req_bw > dc_link_bandwidth_kbps(link, &link->verified_link_cap))
+		return false;
+
 	/* search for the minimum link setting that:
 	 * 1. is supported according to the link training result
 	 * 2. could support the b/w requested by the timing
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
