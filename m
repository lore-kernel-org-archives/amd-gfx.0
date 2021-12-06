Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED97C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 21:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED2906E871;
	Mon,  6 Dec 2021 21:19:17 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA3476E0E8;
 Mon,  6 Dec 2021 21:19:16 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id B76F0B81084;
 Mon,  6 Dec 2021 21:19:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4343EC341C6;
 Mon,  6 Dec 2021 21:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638825554;
 bh=ijfdEIMXipzfofjjcBwYmFaTIINZkUL3W1yDWk+poaM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kmzDBaV1ZZac8XmVsUL5rPz+HdXsBkXkhA2YMI1uHvienpy5l1H3LCL8BhY04PvCb
 UoiXPGWzPvFJWicApNe+06n127xZawWSYNxbYdw0qOqPjHUP+WyuOBJDvqW6JmD2Ga
 D0w2/lzUM74RCUuscWcNLZHqXGR2XhWinvazhaPDtKhRjh3w9uImZhYEPGKUUAD+gc
 tbNpDKhQrflMQzDw6ZZ78P4ERsSl57f2MjlKghKYIm809Q2shvhfGHZgZS1fXhv0Qg
 EYWqyM+0buEPnpIdFxPp2pVmbC+wPGC55M0kkwHmoGEY6dWdUY16ypKWh74DsKPQCo
 PfY5oImL4o6FA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 08/10] drm/amd/display: Fix for the no Audio bug
 with Tiled Displays
Date: Mon,  6 Dec 2021 16:17:27 -0500
Message-Id: <20211206211738.1661003-8-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211206211738.1661003-1-sashal@kernel.org>
References: <20211206211738.1661003-1-sashal@kernel.org>
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
 Mustapha Ghaddar <mustapha.ghaddar@amd.com>, liviu@dudau.co.uk,
 Xinhui.Pan@amd.com, vladimir.stempen@amd.com, daniel@ffwll.ch,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com
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
index f25ac17f47fa9..95a5310e9e661 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1546,6 +1546,10 @@ bool dc_is_stream_unchanged(
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

