Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90C2C001DE
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Aug 2023 16:08:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6130410E0D9;
	Sun, 13 Aug 2023 16:08:54 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21F6910E0A8;
 Sun, 13 Aug 2023 16:08:53 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8808B639A6;
 Sun, 13 Aug 2023 16:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3180C433C9;
 Sun, 13 Aug 2023 16:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1691942932;
 bh=Ad+VPTzUqsuGL7Qu7taz1hNn7yO2oPcIzjn5aVcNT3o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=f/lVmbwPE8oW8ZC+ODgdC5axdHogxfaL2QUHYh+HfT38NZ8o6bRD/8lNjlR2IhBiH
 h7wFteJqasg4GoYgIhFN2S4aYyYnBKdXfSfkFIGCAH539cqo7nthA12X3GUvnuV/f6
 BE4e22vAeS+ZmzwleXoKNzpMALRzI7CAgAqQQM4A09L6WkPCRqNxXsplaLe+Tiy/UA
 kIyZT/FxnvZB8LZKEmDOYKNOqHK9aCF7fJOoHaqRC7TocdEzlejA263XZMkePVJ6xc
 dB0poJI3R1u5VF2l8fEfKDCEgNyW+SA9AeIiNrSuIOWOhcnvpUYS9aErFJwQ99jvvM
 DV8DOyDgW5Nhg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 25/31] drm/amd/display: Exit idle optimizations
 before attempt to access PHY
Date: Sun, 13 Aug 2023 12:05:58 -0400
Message-Id: <20230813160605.1080385-25-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160605.1080385-1-sashal@kernel.org>
References: <20230813160605.1080385-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.126
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
Cc: aric.cyr@amd.com, Iswara.Nagulendran@amd.com, wenjing.liu@amd.com,
 dri-devel@lists.freedesktop.org, Jun.Lei@amd.com, airlied@gmail.com,
 Jingwen.Zhu@amd.com, Sasha Levin <sashal@kernel.org>, Charlene.Liu@amd.com,
 Leo Chen <sancchen@amd.com>, Rodrigo.Siqueira@amd.com,
 amd-gfx@lists.freedesktop.org, tony.tascioglu@amd.com, sunpeng.li@amd.com,
 harry.wentland@amd.com, daniel@ffwll.ch, Alex Hung <alex.hung@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>, Xinhui.Pan@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, zhikai.zhai@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Chen <sancchen@amd.com>

[ Upstream commit de612738e9771bd66aeb20044486c457c512f684 ]

[Why & How]
DMUB may hang when powering down pixel clocks due to no dprefclk.

It is fixed by exiting idle optimization before the attempt to access PHY.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Leo Chen <sancchen@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 46d7e75e4553e..52142d272c868 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1744,10 +1744,13 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 			hws->funcs.edp_backlight_control(edp_link_with_sink, false);
 		}
 		/*resume from S3, no vbios posting, no need to power down again*/
+		clk_mgr_exit_optimized_pwr_state(dc, dc->clk_mgr);
+
 		power_down_all_hw_blocks(dc);
 		disable_vga_and_power_gate_all_controllers(dc);
 		if (edp_link_with_sink && !keep_edp_vdd_on)
 			dc->hwss.edp_power_control(edp_link_with_sink, false);
+		clk_mgr_optimize_pwr_state(dc, dc->clk_mgr);
 	}
 	bios_set_scratch_acc_mode_change(dc->ctx->dc_bios, 1);
 }
-- 
2.40.1

