Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCE5C04AA5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 01:35:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 003C0D0793;
	Thu, 25 Aug 2022 01:35:09 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39AB8D076B;
 Thu, 25 Aug 2022 01:34:50 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D7430B826C8;
 Thu, 25 Aug 2022 01:34:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8B1C43144;
 Thu, 25 Aug 2022 01:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1661391288;
 bh=i1COp1f4gJML2gGVKdwNYJvhMuBqUIl9UnbdTbXOiqU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XRXjCTojLg0iY1OgxF0uIjHi+haSBH5Ky9JgLvHnvNiJZN77GQBexW3aq+ZKN+Y0U
 TELAeiGRuYvCDd8F2cca0lCXKsFxTo2rvPkRaLN5xC5oJJ+0p+rYK1uY4Q90TTHttG
 ktVXmz28x0U8S9j2u6cguGOKWUyYiHbG9PtMIDfehvChUfp5o3Btc3uz5vicpCqdwu
 aHvzISaIMCAXYARTc3hjYOshszSc9A7ZDCWK7IYEe8RTR8O/cRNg2vf4tDs9pK4W/X
 IefWvXRpNhlCjXC3pa7Cth4NBOMdz8A8OZfZAFbWP2n5H1o9tuiNGoBBL2gZtA8HQZ
 /Ve50wuxjOgPg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.19 07/38] drm/amd/display: Avoid MPC infinite loop
Date: Wed, 24 Aug 2022 21:33:30 -0400
Message-Id: <20220825013401.22096-7-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220825013401.22096-1-sashal@kernel.org>
References: <20220825013401.22096-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
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
Cc: Sasha Levin <sashal@kernel.org>, jiapeng.chong@linux.alibaba.com,
 Aric Cyr <aric.cyr@amd.com>, Alex Hung <alex.hung@amd.com>,
 harry.wentland@amd.com, airlied@linux.ie, Xinhui.Pan@amd.com,
 Rodrigo.Siqueira@amd.com, amd-gfx@lists.freedesktop.org, sunpeng.li@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, Alex Deucher <alexander.deucher@amd.com>,
 isabbasso@riseup.net, Jun Lei <Jun.Lei@amd.com>,
 Josip Pavic <Josip.Pavic@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Josip Pavic <Josip.Pavic@amd.com>

[ Upstream commit 8de297dc046c180651c0500f8611663ae1c3828a ]

[why]
In some cases MPC tree bottom pipe ends up point to itself.  This causes
iterating from top to bottom to hang the system in an infinite loop.

[how]
When looping to next MPC bottom pipe, check that the pointer is not same
as current to avoid infinite loop.

Reviewed-by: Josip Pavic <Josip.Pavic@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c | 6 ++++++
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
index 11019c2c62cc..8192f1967e92 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
@@ -126,6 +126,12 @@ struct mpcc *mpc1_get_mpcc_for_dpp(struct mpc_tree *tree, int dpp_id)
 	while (tmp_mpcc != NULL) {
 		if (tmp_mpcc->dpp_id == dpp_id)
 			return tmp_mpcc;
+
+		/* avoid circular linked list */
+		ASSERT(tmp_mpcc != tmp_mpcc->mpcc_bot);
+		if (tmp_mpcc == tmp_mpcc->mpcc_bot)
+			break;
+
 		tmp_mpcc = tmp_mpcc->mpcc_bot;
 	}
 	return NULL;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
index 15734db0cdea..f3c311d09319 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
@@ -531,6 +531,12 @@ static struct mpcc *mpc2_get_mpcc_for_dpp(struct mpc_tree *tree, int dpp_id)
 	while (tmp_mpcc != NULL) {
 		if (tmp_mpcc->dpp_id == 0xf || tmp_mpcc->dpp_id == dpp_id)
 			return tmp_mpcc;
+
+		/* avoid circular linked list */
+		ASSERT(tmp_mpcc != tmp_mpcc->mpcc_bot);
+		if (tmp_mpcc == tmp_mpcc->mpcc_bot)
+			break;
+
 		tmp_mpcc = tmp_mpcc->mpcc_bot;
 	}
 	return NULL;
-- 
2.35.1

