Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF93C433F5
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Oct 2022 23:50:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A26F810E2A5;
	Sun,  9 Oct 2022 23:50:21 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D972910E2A5;
 Sun,  9 Oct 2022 23:50:16 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 58F69B80DE3;
 Sun,  9 Oct 2022 23:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195DCC433D6;
 Sun,  9 Oct 2022 23:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1665359414;
 bh=IlbwxedBFgehkgmZM83YAvGzi/DzkHI0VCuiL4xBrZo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FRofkGLicyZH+CbdbD8TM+Y2+QANMubrkVFxUbs49VDxEx5pnFYVeF4jYFDihQcUF
 e7eXpxWmiOgyKkrdey5WYMeE8V7QGM6+c+NpQEQLYKzMcVgov+b/KvI0D7gKksVtiq
 0ix2hdWw5dTalgFtrP7NoMjgAwCc3ZtKZmMDEvxrwl8u5t/44IdJ/xCCLbdOupLfhJ
 1fq8b0Ndy6pVVci5EYOluIcaU8JduKxq9HvAOv01j6atlFwD7eYMdzyCA1GCKzLTX6
 sYchNZGhKFAV7DFwuAD30mbYvK2eOkz5ZEbX4/L4ltmCfJ7/IJk07h0izC5V7ov7i4
 gPNpkx5RXCQoQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.0 13/44] drm/amd/display: Fix variable dereferenced
 before check
Date: Sun,  9 Oct 2022 19:49:01 -0400
Message-Id: <20221009234932.1230196-13-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221009234932.1230196-1-sashal@kernel.org>
References: <20221009234932.1230196-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Brian.Chang@amd.com,
 kernel test robot <lkp@intel.com>, felipe.clark@amd.com, sunpeng.li@amd.com,
 airlied@gmail.com, dri-devel@lists.freedesktop.org, Xinhui.Pan@amd.com,
 Rodrigo.Siqueira@amd.com, amd-gfx@lists.freedesktop.org,
 aurabindo.pillai@amd.com, sunliming <sunliming@kylinos.cn>, Alvin.Lee2@amd.com,
 daniel@ffwll.ch, Alex Deucher <alexander.deucher@amd.com>, Jun.Lei@amd.com,
 harry.wentland@amd.com, christian.koenig@amd.com,
 Dan Carpenter <dan.carpenter@oracle.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: sunliming <sunliming@kylinos.cn>

[ Upstream commit 45a92f45f4578ff89da7dc5ef50bab4ef870f3b7 ]

Fixes the following smatch warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:311 dc_dmub_srv_p_state_delegate()
warn: variable dereferenced before check 'dc' (see line 309)

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 52a61b3e5a8b..2e243b70747f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -323,11 +323,13 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, stru
 	struct dmub_cmd_fw_assisted_mclk_switch_config *config_data = &cmd.fw_assisted_mclk_switch.config_data;
 	int i = 0;
 	int ramp_up_num_steps = 1; // TODO: Ramp is currently disabled. Reenable it.
-	uint8_t visual_confirm_enabled = dc->debug.visual_confirm == VISUAL_CONFIRM_FAMS;
+	uint8_t visual_confirm_enabled;
 
 	if (dc == NULL)
 		return false;
 
+	visual_confirm_enabled = dc->debug.visual_confirm == VISUAL_CONFIRM_FAMS;
+
 	// Format command.
 	cmd.fw_assisted_mclk_switch.header.type = DMUB_CMD__FW_ASSISTED_MCLK_SWITCH;
 	cmd.fw_assisted_mclk_switch.header.sub_type = DMUB_CMD__FAMS_SETUP_FW_CTRL;
-- 
2.35.1

