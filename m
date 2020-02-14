Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D8CC2BA83
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 16:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58CBF2467D
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 16:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wp3t7+az"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58CBF2467D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D4396FA38;
	Fri, 14 Feb 2020 16:04:51 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 169066FA27;
 Fri, 14 Feb 2020 16:04:49 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EBB6C24686;
 Fri, 14 Feb 2020 16:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581696288;
 bh=F9utqGAEcYP3X2vuo08iikomNkD88aKTD16XoJ4MORM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=wp3t7+az6yRVhTj3xtkD9PxObdv1ZnF80DLyc5SkOklnmwrFm8/yH4RjfoTsTDPsr
 +kUwklST/M4rxAt+lgb1DnxNP+Ci1UQWyqfrsnUTg5xgkN3OCyY25uC6RlCnqDPj/K
 du6UsCN5x+RFSt5tDWBaXiR5Tab4664GSd0LloUw=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 136/459] drm/amd/display: remove set but not used
 variable 'old_plane_crtc'
Date: Fri, 14 Feb 2020 10:56:26 -0500
Message-Id: <20200214160149.11681-136-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
 zhengbin <zhengbin13@huawei.com>, Hulk Robot <hulkci@huawei.com>,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: zhengbin <zhengbin13@huawei.com>

[ Upstream commit d3b65841b31c0192f997e0f9bc64dccbfaa97bcc ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c: In function dm_determine_update_type_for_commit:
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:6516:36: warning: variable old_plane_crtc set but not used [-Wunused-but-set-variable]

It is introduced by commit a87fa9938749 ("drm/amd/display:
Build stream update and plane updates in dm"), but never used,
so remove it.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 360c87ba45956..10cf645a77fb7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7040,7 +7040,7 @@ dm_determine_update_type_for_commit(struct amdgpu_display_manager *dm,
 	int i, j, num_plane, ret = 0;
 	struct drm_plane_state *old_plane_state, *new_plane_state;
 	struct dm_plane_state *new_dm_plane_state, *old_dm_plane_state;
-	struct drm_crtc *new_plane_crtc, *old_plane_crtc;
+	struct drm_crtc *new_plane_crtc;
 	struct drm_plane *plane;
 
 	struct drm_crtc *crtc;
@@ -7086,7 +7086,6 @@ dm_determine_update_type_for_commit(struct amdgpu_display_manager *dm,
 			uint64_t tiling_flags;
 
 			new_plane_crtc = new_plane_state->crtc;
-			old_plane_crtc = old_plane_state->crtc;
 			new_dm_plane_state = to_dm_plane_state(new_plane_state);
 			old_dm_plane_state = to_dm_plane_state(old_plane_state);
 
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
