Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9129AC3F6B0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 01:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68B32D10B6;
	Thu, 25 Aug 2022 01:40:22 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFDA2D100B;
 Thu, 25 Aug 2022 01:39:56 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5F11A61AE9;
 Thu, 25 Aug 2022 01:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D44C433B5;
 Thu, 25 Aug 2022 01:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1661391594;
 bh=cWtP4DjNF9uuGOFmJLowltSk4Vz/PPcG3NBhgTmkfsA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=R/ITFKDPW0oawaZBKDQH5OEzzSBCh00ksyb10VmBC++jKVReKJ/mlYRxzhFqcFNkL
 6cgnYglsh9tCZ6x/Wj8GawGjKlc3x20BVlPDrFfGEgH2w8zgCZZ8MWQIBiJzlEs/yc
 WEbgI5ZTAnfgFgYvjzTmDPVyf9JRIot0HO40F4h7C/wY4oqqtvZHu0pCpNutGU47rD
 tl6DnaqfYPFEJa4q0DFOtpfvMzN21ol8W53Fr0cJDxpPXtedshAwQqhNUfe/bfyjB9
 qulXAokFKZgVuXKapAUbfxplLDd2KtnBL2zfeMmFyky7HTSRzoDo+gyKo+wTzFURMF
 io1l/+m7NrpdQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 5/8] drm/amd/display: Fix pixel clock programming
Date: Wed, 24 Aug 2022 21:39:24 -0400
Message-Id: <20220825013932.23467-5-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220825013932.23467-1-sashal@kernel.org>
References: <20220825013932.23467-1-sashal@kernel.org>
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
Cc: HaoPing.Liu@amd.com, Aric Cyr <Aric.Cyr@amd.com>, airlied@linux.ie,
 dri-devel@lists.freedesktop.org, Sasha Levin <sashal@kernel.org>,
 Brian Chang <Brian.Chang@amd.com>, baihaowen@meizu.com,
 Rodrigo.Siqueira@amd.com, amd-gfx@lists.freedesktop.org, alex.hung@amd.com,
 michael.strauss@amd.com, harry.wentland@amd.com,
 Ilya Bakoulin <Ilya.Bakoulin@amd.com>, Charlene.Liu@amd.com,
 sunpeng.li@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 dillon.varone@amd.com, Hansen.Dsouza@amd.com, David.Galiffi@amd.com,
 Xinhui.Pan@amd.com, daniel@ffwll.ch, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[ Upstream commit 04fb918bf421b299feaee1006e82921d7d381f18 ]

[Why]
Some pixel clock values could cause HDMI TMDS SSCPs to be misaligned
between different HDMI lanes when using YCbCr420 10-bit pixel format.

BIOS functions for transmitter/encoder control take pixel clock in kHz
increments, whereas the function for setting the pixel clock is in 100Hz
increments. Setting pixel clock to a value that is not on a kHz boundary
will cause the issue.

[How]
Round pixel clock down to nearest kHz in 10/12-bpc cases.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index eca67d5d5b10..721be82ccebe 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -546,9 +546,11 @@ static void dce112_get_pix_clk_dividers_helper (
 		switch (pix_clk_params->color_depth) {
 		case COLOR_DEPTH_101010:
 			actual_pixel_clock_100hz = (actual_pixel_clock_100hz * 5) >> 2;
+			actual_pixel_clock_100hz -= actual_pixel_clock_100hz % 10;
 			break;
 		case COLOR_DEPTH_121212:
 			actual_pixel_clock_100hz = (actual_pixel_clock_100hz * 6) >> 2;
+			actual_pixel_clock_100hz -= actual_pixel_clock_100hz % 10;
 			break;
 		case COLOR_DEPTH_161616:
 			actual_pixel_clock_100hz = actual_pixel_clock_100hz * 2;
-- 
2.35.1

