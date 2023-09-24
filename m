Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B75ECE7A8A
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Sep 2023 13:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D4C710E171;
	Sun, 24 Sep 2023 13:18:54 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 998C910E171;
 Sun, 24 Sep 2023 13:18:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id C1F66CE0B26;
 Sun, 24 Sep 2023 13:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74645C4339A;
 Sun, 24 Sep 2023 13:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695561513;
 bh=AFeVCQSAMJ19P9SVd3+4fK3hpmUw46XSFs2rfQTnPTA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rzRIdTcPL+QS8U2rJD17jeT+6PJYCaFILzH2eE2fM5wmQs2biaVgYB/us/fDeDLRk
 NHSAN5mWnyAeZzGL7dn/2ufJ+CEZeX/4wIX7i1OaZmvSciDgzBxb+ntnFYn7vAfF7b
 W1Ok0GJIn1Zy0cED3TM+NyOuJ18Isrd4mQ1GWrLPXOQvDIUcXsSgho39xlulBbc6tz
 SzJySC3lU35eLqTV9L4fkYgktaITHhU29BbO9YsqaG8MnnHU506IMgxTRlpq8nOGCv
 4aTC7CHu+4HNxEhogcNcAcvNC86SlKxRRKce6msIActq/RFRT6Nqgos2Rgsfs7M8kB
 A2kWwJbF8XC6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 20/28] drm/amd/display: Don't check registers,
 if using AUX BL control
Date: Sun, 24 Sep 2023 09:17:37 -0400
Message-Id: <20230924131745.1275960-20-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131745.1275960-1-sashal@kernel.org>
References: <20230924131745.1275960-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.55
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
 dri-devel@lists.freedesktop.org, Jun.Lei@amd.com, airlied@gmail.com,
 Sasha Levin <sashal@kernel.org>, charlene.liu@amd.com, sancchen@amd.com,
 Rodrigo.Siqueira@amd.com, syed.hassan@amd.com, amd-gfx@lists.freedesktop.org,
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
index 9378c98d02cfe..508f5fe268484 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -973,7 +973,9 @@ void dce110_edp_backlight_control(
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

