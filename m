Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F686C43217
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 02:23:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64D5C1128C1;
	Tue, 18 Jan 2022 02:23:13 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D25011128C0;
 Tue, 18 Jan 2022 02:23:11 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 9B111B81238;
 Tue, 18 Jan 2022 02:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B8AC36AEF;
 Tue, 18 Jan 2022 02:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642472590;
 bh=hJKdXQWfWwBSSe/OAz93I6pyit1rwGkzkVXJHlxjV9o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=E9sInTcSnZ5ubonUSFLlj/MzF9cPoFAb2cp/nBMZzSii7wW3MZwZIXVZP1PKjj9cf
 yDRdqmXBee7v419Iq31jhQkljGkxOXx6LJyUeSvhD9tnGoHu8YkWKlqtBr6aH1sTVm
 R1xlomMO6sqByFoS2gs10c4iaHcu4/qS9Av4Iw27On6T74dzrO6p5FNzmMg6bkXMIp
 hJBucgDKxMnl1FUtWHDqN2lYiRZCM/q4bwt13C9T9UYifbBae8peAwwLBwS4ao0Etp
 CjD47hlMbsh5XPVYjt2UQ//VI3By5EvJpSy2CG4wvPfBaHtu6kiKw80B6IWf+orPlX
 ux7mBD6ynHW2g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.16 061/217] drm/amdgpu/display: set
 vblank_disable_immediate for DC
Date: Mon, 17 Jan 2022 21:17:04 -0500
Message-Id: <20220118021940.1942199-61-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220118021940.1942199-1-sashal@kernel.org>
References: <20220118021940.1942199-1-sashal@kernel.org>
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
Cc: Yong.Zhao@amd.com, andrey.grodzovsky@amd.com, airlied@linux.ie,
 lijo.lazar@amd.com, dri-devel@lists.freedesktop.org, isabbasso@riseup.net,
 Sasha Levin <sashal@kernel.org>, Rodrigo.Siqueira@amd.com,
 amd-gfx@lists.freedesktop.org, sunpeng.li@amd.com, aurabindo.pillai@amd.com,
 qingqing.zhuo@amd.com, Harry Wentland <harry.wentland@amd.com>,
 Philip.Yang@amd.com, daniel@ffwll.ch, Anson.Jacob@amd.com,
 nikola.cornij@amd.com, Emily.Deng@amd.com, shenshih@amd.com,
 Felix.Kuehling@amd.com, Xinhui.Pan@amd.com, Roman.Li@amd.com,
 christian.koenig@amd.com, tzimmermann@suse.de, Wayne.Lin@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, nicholas.kazlauskas@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 92020e81ddbeac351ea4a19bcf01743f32b9c800 ]

Disable vblanks immediately to save power.  I think this was
missed when we merged DC support.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1781
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c           | 1 -
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index cc2e0c9cfe0a1..4f3c62adccbde 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -333,7 +333,6 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
 	if (!amdgpu_device_has_dc_support(adev)) {
 		if (!adev->enable_virtual_display)
 			/* Disable vblank IRQs aggressively for power-saving */
-			/* XXX: can this be enabled for DC? */
 			adev_to_drm(adev)->vblank_disable_immediate = true;
 
 		r = drm_vblank_init(adev_to_drm(adev), adev->mode_info.num_crtc);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e727f1dd2a9a7..e08ac474e9d59 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1597,6 +1597,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	adev_to_drm(adev)->mode_config.cursor_width = adev->dm.dc->caps.max_cursor_size;
 	adev_to_drm(adev)->mode_config.cursor_height = adev->dm.dc->caps.max_cursor_size;
 
+	/* Disable vblank IRQs aggressively for power-saving */
+	adev_to_drm(adev)->vblank_disable_immediate = true;
+
 	if (drm_vblank_init(adev_to_drm(adev), adev->dm.display_indexes_num)) {
 		DRM_ERROR(
 		"amdgpu: failed to initialize sw for display support.\n");
-- 
2.34.1

