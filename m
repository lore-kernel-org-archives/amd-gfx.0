Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D47CE7A90
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Sep 2023 13:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C551910E1A8;
	Sun, 24 Sep 2023 13:19:37 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 631CC10E1A7;
 Sun, 24 Sep 2023 13:19:28 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id DEE6260C3A;
 Sun, 24 Sep 2023 13:19:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB25C433CB;
 Sun, 24 Sep 2023 13:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695561567;
 bh=1Pyq3dncUK8p5J2LPF3VavG5lJ4d4b1IdIUVjw46iZY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Kx+tsrqUyR1MyguijuksonPVK8T56GMC/pgm5OFIDOYVdOSdXz7QzAv3bQ1+uoW89
 CuPMXE2GyeEaa+c7LFl7IQruexAxZP+G8TfjjJoGf0FLVDd7jM0UK5pNuOgc42N3zr
 RPCn2WksU3iPpU86dUauq9SZ0IxXaZJONKSkJzkYIznDp3neCYKntvqzvApWVtvob6
 YhgPH3gz9goBDl7s+CR/9F/ECxvtHMv/BQjlB1GVM7VRi+xKLEb4ANFi6cXiMFiCEi
 YpgXZ0+9hfMYYcanf+6IWefg6+DD2cpgvZjBxSaC08fKHSmX6HAXsCanZY/Mn3sqX5
 ch19nwEqVtt6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 13/18] drm/amd/display: Don't check registers,
 if using AUX BL control
Date: Sun, 24 Sep 2023 09:18:50 -0400
Message-Id: <20230924131857.1276330-13-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131857.1276330-1-sashal@kernel.org>
References: <20230924131857.1276330-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.133
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
Cc: aric.cyr@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 dri-devel@lists.freedesktop.org, mario.limonciello@amd.com, Jun.Lei@amd.com,
 airlied@gmail.com, Sasha Levin <sashal@kernel.org>, charlene.liu@amd.com,
 Rodrigo.Siqueira@amd.com, amd-gfx@lists.freedesktop.org,
 tony.tascioglu@amd.com, harry.wentland@amd.com,
 Stylon Wang <stylon.wang@amd.com>, ahmed.ahmed@amd.com, Jingwen.Zhu@amd.com,
 sunpeng.li@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Swapnil Patel <swapnil.patel@amd.com>, Xinhui.Pan@amd.com, daniel@ffwll.ch,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Swapnil Patel <swapnil.patel@amd.com>

[ Upstream commit f5b2c10b57615828b531bb0ae56bd6325a41167e ]

[Why]
Currently the driver looks DCN registers to access if BL is on or not.
This check is not valid if we are using AUX based brightness control.
This causes driver to not send out "backlight off" command during power off
sequence as it already thinks it is off.

[How]
Only check DCN registers if we aren't using AUX based brightness control.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Swapnil Patel <swapnil.patel@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 52142d272c868..87825818d43ec 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -980,7 +980,9 @@ void dce110_edp_backlight_control(
 		return;
 	}
 
-	if (link->panel_cntl) {
+	if (link->panel_cntl && !(link->dpcd_sink_ext_caps.bits.oled ||
+		link->dpcd_sink_ext_caps.bits.hdr_aux_backlight_control == 1 ||
+		link->dpcd_sink_ext_caps.bits.sdr_aux_backlight_control == 1)) {
 		bool is_backlight_on = link->panel_cntl->funcs->is_panel_backlight_on(link->panel_cntl);
 
 		if ((enable && is_backlight_on) || (!enable && !is_backlight_on)) {
-- 
2.40.1

