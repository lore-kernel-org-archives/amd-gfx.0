Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F22CC3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jul 2024 14:31:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8050510E74C;
	Tue, 16 Jul 2024 14:31:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B1WiCmqF";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55C7710E74C;
 Tue, 16 Jul 2024 14:30:15 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id A62FCCE12A4;
 Tue, 16 Jul 2024 14:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1676DC116B1;
 Tue, 16 Jul 2024 14:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1721140213;
 bh=U+xuZ+SSYRANK4+OprKoEHOV9pVEOFuelFsbBJh26Us=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=B1WiCmqFX8uZxL1dZF/IwRnnq5Hq2Ix82vGfVZvRqDQvsRxMhCZC3JQE/wZfCAUGJ
 BD2L3htuvQzK0VrlUKaBKpgfuonjFEhDsMqCpDUQ0D0Q2mnhKQBRJivKRhCPpADJUN
 70MTA3T/aMoa5ZW6/kNEmxlWlgMuC59sYRq24LVfRrGRAZnftnJldFB7l1OZtvl5Bi
 jxiJX3Njz/5SxwoIF+cDZQfVUBFqz6feuXwCOMKArp7d1WyDahUX7RLJaqfkmMLJGP
 TuhJOwifMdk3vBEdyJ9CtHynAJNvz/nfSrFXU5bSB3lT81Bs83c1Q9bKH4s6ESlVqr
 9WOYNdpEAutBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tom Chung <chiahsuan.chung@amd.com>, Sun peng Li <sunpeng.li@amd.com>,
 Jerry Zuo <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 harry.wentland@amd.com, Rodrigo.Siqueira@amd.com, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch, alex.hung@amd.com,
 hamza.mahfooz@amd.com, roman.li@amd.com, mario.limonciello@amd.com,
 joshua@froggi.es, wayne.lin@amd.com, srinivasan.shanmugam@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 6/7] drm/amd/display: Reset freesync config
 before update new state
Date: Tue, 16 Jul 2024 10:29:46 -0400
Message-ID: <20240716142953.2714154-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142953.2714154-1-sashal@kernel.org>
References: <20240716142953.2714154-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.221
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tom Chung <chiahsuan.chung@amd.com>

[ Upstream commit 6b8487cdf9fc7bae707519ac5b5daeca18d1e85b ]

[Why]
Sometimes the new_crtc_state->vrr_infopacket did not sync up with the
current state.
It will affect the update_freesync_state_on_stream() does not update
the state correctly.

[How]
Reset the freesync config before get_freesync_config_for_crtc() to
make sure we have the correct new_crtc_state for VRR.

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 29ef0ed44d5f4..c957ef1283f68 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8385,6 +8385,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	}
 
 	/* Update Freesync settings. */
+	reset_freesync_config_for_crtc(dm_new_crtc_state);
 	get_freesync_config_for_crtc(dm_new_crtc_state,
 				     dm_new_conn_state);
 
-- 
2.43.0

