Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D91C369D3
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 11:50:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE4C110E965;
	Wed, 25 Sep 2024 11:50:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Iszu7F+E";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86C3B10E965;
 Wed, 25 Sep 2024 11:50:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 061CA5C24E1;
 Wed, 25 Sep 2024 11:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F23C4CEC3;
 Wed, 25 Sep 2024 11:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727265007;
 bh=VJBmzmVZjguK9yZxJVmRm4Om2UlXipfP5VwcfOCKubQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Iszu7F+E9Kj2LV+ozRPIoGfJV9gVIYDqewFlDYCGwXR5w6a8ScIs7yMZgEqX1Mun+
 CMX55XdOtl8AuhOpGjCHen0uQejqGsyK3S4eH2j8KpwPsM01glFQ5aCSW1KW1wTDlr
 d6TNWCJhbsBJcxAlX8tptzoqzB+HoU+Dh5bqxjFfKNCx84Xee4SsrL9mx3d2KmAkIs
 +M/3BtQJM5csFGgE9xpI2WeU/Rycd9paDDoCYiCADHvcEBk4P3DmSdJW3ZHWHtVAYM
 IpAbS4uAn75AFfvF5ujJh8isHevTFKb1MeZlWeaYxLlZAEGjdepHySPKyV8/Uyh4Ki
 LuRv93GiP9yqg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 daniel@ffwll.ch, alvin.lee2@amd.com, wenjing.liu@amd.com,
 sungjoon.kim@amd.com, aurabindo.pillai@amd.com, dillon.varone@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 193/244] drm/amd/display: Check stream_status
 before it is used
Date: Wed, 25 Sep 2024 07:26:54 -0400
Message-ID: <20240925113641.1297102-193-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
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

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 58a8ee96f84d2c21abb85ad8c22d2bbdf59bd7a9 ]

[WHAT & HOW]
dc_state_get_stream_status can return null, and therefore null must be
checked before stream_status is used.

This fixes 1 NULL_RETURNS issue reported by Coverity.

Signed-off-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 81fab62ef38eb..9e05d77453ac3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3739,7 +3739,7 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 				surface_count,
 				stream,
 				context);
-	} else {
+	} else if (stream_status) {
 		build_dmub_cmd_list(dc,
 				srf_updates,
 				surface_count,
-- 
2.43.0

