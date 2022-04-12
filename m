Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD15AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 00:47:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6674C10FACE;
	Tue, 12 Apr 2022 00:47:27 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20F2B10FACE;
 Tue, 12 Apr 2022 00:47:27 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 96F006181B;
 Tue, 12 Apr 2022 00:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C8BC385A4;
 Tue, 12 Apr 2022 00:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649724444;
 bh=6f46ygW4sXYYFSpSEOnkOKd5uLvlHXe/JGPWhFg61WA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=j15SGRXo/3DKfzq5oHZMMOobtZ7V8RdGAGp9MLEuNfpmdOBlO1hx/JmpQramEkZF5
 LyAtUgMc0lAU06qJzPgoZmeVXyDtyVLthTeFMqY6lzvG6ux6aN6DMpCfqECpGIVfGj
 xquqvrhneFIFHYVuInXk4lShs9UhJMcP2AX5QdYaqRy+NpxAoP0kIPnomRaq0V2kaO
 44928f2P+wFtuaOTlCUaQVp32WE9YDN7cGoQB6EnkpVjgbut3l0aIwWleIZSlMKPbl
 dUFGcWUQAOzV3rt4sEkxs27FV7OoC3lqaPosnScw0EV7AAY9j2gNb4BRullaQvWtKx
 hzCej1amCavwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 06/41] drm/amd/display: fix audio format not
 updated after edid updated
Date: Mon, 11 Apr 2022 20:46:18 -0400
Message-Id: <20220412004656.350101-6-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412004656.350101-1-sashal@kernel.org>
References: <20220412004656.350101-1-sashal@kernel.org>
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
Cc: aric.cyr@amd.com, airlied@linux.ie, Rodrigo.Siqueira@amd.com,
 dri-devel@lists.freedesktop.org, meenakshikumar.somasundaram@amd.com,
 Jun.Lei@amd.com, Jimmy.Kizito@amd.com, Sasha Levin <sashal@kernel.org>,
 Charlene Liu <Charlene.Liu@amd.com>, mario.kleiner.de@gmail.com,
 wenjing.liu@amd.com, amd-gfx@lists.freedesktop.org, sunpeng.li@amd.com,
 Jerry.Zuo@amd.com, eric.bernstein@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 harry.wentland@amd.com, Alex Hung <alex.hung@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>, Martin.Leung@amd.com,
 Xinhui.Pan@amd.com, christian.koenig@amd.com, Dmytro.Laktyushkin@amd.com,
 daniel@ffwll.ch, Alex Deucher <alexander.deucher@amd.com>,
 nicholas.kazlauskas@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[ Upstream commit 5e8a71cf13bc9184fee915b2220be71b4c6cac74 ]

[why]
for the case edid change only changed audio format.
driver still need to update stream.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 7ae409f7dcf8..8c285d585249 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1623,8 +1623,8 @@ bool dc_is_stream_unchanged(
 	if (old_stream->ignore_msa_timing_param != stream->ignore_msa_timing_param)
 		return false;
 
-	// Only Have Audio left to check whether it is same or not. This is a corner case for Tiled sinks
-	if (old_stream->audio_info.mode_count != stream->audio_info.mode_count)
+	/*compare audio info*/
+	if (memcmp(&old_stream->audio_info, &stream->audio_info, sizeof(stream->audio_info)) != 0)
 		return false;
 
 	return true;
-- 
2.35.1

