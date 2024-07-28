Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A98C3DA49
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Jul 2024 15:43:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E170B10E20C;
	Sun, 28 Jul 2024 15:43:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CHWLKxio";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A975610E206;
 Sun, 28 Jul 2024 15:43:55 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 9A219CE0917;
 Sun, 28 Jul 2024 15:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90A2C32782;
 Sun, 28 Jul 2024 15:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722181432;
 bh=4VFj1C+cmOKvrfeeMQBQMf8ONB392pwCRvakOWRT6mc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CHWLKxiov2VxaGqfBMSbsvXfQiblHJXgbftygYA55kH0AM8vx/rngjC3flHmq39HV
 PjDoXqtVhRGIh3Xohr+C4yhvBnPvFyuFm090hiaC8nU9HpohDfQJvlgB4/TglzNOoy
 1qHOp5dWu3A5+sWyy2lrzuGvqHGwb6jq2wKN4yOOX3PGhiyhSr7xVIp47CieXbAwLm
 uYfdjL1UI02tb6RYyxIrFBnWjgL3cPy3NoJakVmwmVKFi39cYp2JhCMA11d2Ju6HV0
 j0I/loTXfwdiUwZocHiGbb46dRI6ts++Dm2+swYP4TUUEn+wDfoDIDKh9oh6S/oMY+
 YBTW5QMlZOP2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Roman Li <roman.li@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Alex Hung <alex.hung@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 sunpeng.li@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, wayne.lin@amd.com, mwen@igalia.com,
 alvin.lee2@amd.com, dillon.varone@amd.com, hanghong.ma@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 14/34] drm/amd/display: Add null checks for
 'stream' and 'plane' before dereferencing
Date: Sun, 28 Jul 2024 11:40:38 -0400
Message-ID: <20240728154230.2046786-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154230.2046786-1-sashal@kernel.org>
References: <20240728154230.2046786-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 15c2990e0f0108b9c3752d7072a97d45d4283aea ]

This commit adds null checks for the 'stream' and 'plane' variables in
the dcn30_apply_idle_power_optimizations function. These variables were
previously assumed to be null at line 922, but they were used later in
the code without checking if they were null. This could potentially lead
to a null pointer dereference, which would cause a crash.

The null checks ensure that 'stream' and 'plane' are not null before
they are used, preventing potential crashes.

Fixes the below static smatch checker:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn30/dcn30_hwseq.c:938 dcn30_apply_idle_power_optimizations() error: we previously assumed 'stream' could be null (see line 922)
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn30/dcn30_hwseq.c:940 dcn30_apply_idle_power_optimizations() error: we previously assumed 'plane' could be null (see line 922)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index ed9141a67db37..5b09d95cc5b8f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -919,6 +919,9 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 			stream = dc->current_state->streams[0];
 			plane = (stream ? dc->current_state->stream_status[0].plane_states[0] : NULL);
 
+			if (!stream || !plane)
+				return false;
+
 			if (stream && plane) {
 				cursor_cache_enable = stream->cursor_position.enable &&
 						plane->address.grph.cursor_cache_addr.quad_part;
-- 
2.43.0

