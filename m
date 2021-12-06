Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DAFC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 21:15:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 978F66EACC;
	Mon,  6 Dec 2021 21:15:01 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BEFB6EA41;
 Mon,  6 Dec 2021 21:15:00 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 860E4CE185C;
 Mon,  6 Dec 2021 21:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FBEC341C1;
 Mon,  6 Dec 2021 21:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638825294;
 bh=pQE60b+PjcLVTwWbBbEUh82jS+EsMmj4rNuXKiHL/qY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EYf8yVwvjcLqutbM/MO7tCVNjUdcyWzX0UiV8v1abWVgoFnYJ+PvQiiSXhyW4baWP
 SCZUga0qpt6ccdYKvQCMh91a27/iXT0f0H8DVuwpDSeXnuNUFhRSRNwZoIy+nWILBx
 XuGGg2eNBYTSphwzyNoMdEITck2z/uEC7/iDxLKAGkzT9G69LEFbl23EFsy1W1WV6p
 p7YUziP+9XzN5+LT1kq7K6PprTxv9V1MwVMf5SpY9e6V7ezbQm8mpb0xaxXF/XBwcY
 EFNipwEakfuNttUAP6+GAnWDfzEfcc6xMMLsvIAnekZU1bV0fbJ4iImgdIEnLqn1Gd
 cfKKP5JhiaHZg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 19/24] drm/amd/display: Fix for the no Audio bug
 with Tiled Displays
Date: Mon,  6 Dec 2021 16:12:24 -0500
Message-Id: <20211206211230.1660072-19-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211206211230.1660072-1-sashal@kernel.org>
References: <20211206211230.1660072-1-sashal@kernel.org>
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
Cc: aric.cyr@amd.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
 Jun Lei <Jun.Lei@amd.com>, lee.jones@linaro.org,
 Mustapha Ghaddar <mghaddar@amd.com>, Sasha Levin <sashal@kernel.org>,
 mario.kleiner.de@gmail.com, Rodrigo.Siqueira@amd.com,
 amd-gfx@lists.freedesktop.org, Jerry.Zuo@amd.com, Dmytro.Laktyushkin@amd.com,
 Jimmy.Kizito@amd.com, harry.wentland@amd.com, sunpeng.li@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Mustapha Ghaddar <mustapha.ghaddar@amd.com>, Xinhui.Pan@amd.com,
 christian.koenig@amd.com, vladimir.stempen@amd.com, daniel@ffwll.ch,
 Alex Deucher <alexander.deucher@amd.com>, nicholas.kazlauskas@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mustapha Ghaddar <mghaddar@amd.com>

[ Upstream commit 5ceaebcda9061c04f439c93961f0819878365c0f ]

[WHY]
It seems like after a series of plug/unplugs we end up in a situation
where tiled display doesnt support Audio.

[HOW]
The issue seems to be related to when we check streams changed after an
HPD, we should be checking the audio_struct as well to see if any of its
values changed.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Mustapha Ghaddar <mustapha.ghaddar@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index a60396d5be445..e94546187cf15 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1623,6 +1623,10 @@ bool dc_is_stream_unchanged(
 	if (old_stream->ignore_msa_timing_param != stream->ignore_msa_timing_param)
 		return false;
 
+	// Only Have Audio left to check whether it is same or not. This is a corner case for Tiled sinks
+	if (old_stream->audio_info.mode_count != stream->audio_info.mode_count)
+		return false;
+
 	return true;
 }
 
-- 
2.33.0

