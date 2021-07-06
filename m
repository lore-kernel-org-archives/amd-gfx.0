Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5B4C47E4D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 11:16:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A57461C77
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 11:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A57461C77
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 408F96E0F2;
	Tue,  6 Jul 2021 11:16:15 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12C1D6E0E9;
 Tue,  6 Jul 2021 11:16:13 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAE9661C74;
 Tue,  6 Jul 2021 11:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625570172;
 bh=oWnmd/UJFwruZAvf/2/WizP7J0qUKfh90AqYVxpouk4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dZLGv4Y/uGS+56B1cjgiKDzl09781/8gFIun6G2cx2IfV8eVgBpjK1k3rBWfm/Glw
 heuwtrHdS6QxAoR2tvQn/4Xy1xTOkL2gGT4ucta8uYWJqEJL24vbbG29V70CpQ43kg
 kwrLTbgNeCGDOY0C7pNJB3cp44JrSXdo7+DNcJtnP2SURbI8HocrFwNP9KL9ha7I9T
 1FX/ezA9LEThImtVgq3ukY60LgXyzlsM/GY3XeIuvH1JS5+S+sh8H59DCjmaGj2wDA
 hITuGZGGVGAjKGiNH04XtfenDwOpCBPf6Pjze7vVD37Gl3uxtDok/g2P8dhC8v8/AO
 kyqlRks9hhNrw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 091/189] drm/amd/display: Release MST resources
 on switch from MST to SST
Date: Tue,  6 Jul 2021 07:12:31 -0400
Message-Id: <20210706111409.2058071-91-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210706111409.2058071-1-sashal@kernel.org>
References: <20210706111409.2058071-1-sashal@kernel.org>
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
Cc: Stylon Wang <stylon.wang@amd.com>, Sasha Levin <sashal@kernel.org>,
 Wenjing Liu <Wenjing.Liu@amd.com>, amd-gfx@lists.freedesktop.org,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Vladimir Stempen <vladimir.stempen@amd.com>, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Vladimir Stempen <vladimir.stempen@amd.com>

[ Upstream commit 3f8518b60c10aa96f3efa38a967a0b4eb9211ac0 ]

[why]
When OS overrides training link training parameters
for MST device to SST mode, MST resources are not
released and leak of the resource may result crash and
incorrect MST discovery during following hot plugs.

[how]
Retaining sink object to be reused by SST link and
releasing MST  resources.

Signed-off-by: Vladimir Stempen <vladimir.stempen@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 3ff3d9e90983..f26ed50a9660 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1784,6 +1784,8 @@ static void set_dp_mst_mode(struct dc_link *link, bool mst_enable)
 		link->type = dc_connection_single;
 		link->local_sink = link->remote_sinks[0];
 		link->local_sink->sink_signal = SIGNAL_TYPE_DISPLAY_PORT;
+		dc_sink_retain(link->local_sink);
+		dm_helpers_dp_mst_stop_top_mgr(link->ctx, link);
 	} else if (mst_enable == true &&
 			link->type == dc_connection_single &&
 			link->remote_sinks[0] != NULL) {
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
