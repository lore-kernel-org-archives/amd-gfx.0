Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4091C47074
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Dec 2023 00:21:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5233110E18C;
	Tue, 26 Dec 2023 00:21:52 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1107D10E18C;
 Tue, 26 Dec 2023 00:21:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 66193B80B6A;
 Tue, 26 Dec 2023 00:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30A2C433C7;
 Tue, 26 Dec 2023 00:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1703550107;
 bh=l1bu6sJvkRQeESXtDmr6quCUcJlzaRI0yOcXoP+DPj8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mbUOtfqEiGNuLYkY1TEZy9u50za3PdLHr2+5RpVdMbZ56FZbSoXjUHpAyoA0PKOnl
 QRO7J2zHK1tDwCXBVbt70UriK0tiqT5i/kJavdQu4a7ONWqP8cS0gdH1aOlH+sssTk
 0il35JKQvlcCKYD14L5GLhNSxpT5BFlw23qG23zPCGXHP5U/oyDvFxrPyolww92yc3
 bHbkRQZ9qfkvOJStgzaB2PycgJpSFh9i1l8B8TzwaWv3ZJX1ormIspylAIIEucQGG9
 uGOz8xa3txx2qXM90PgfVT4TXx2HeT3NMtQDZB+BYhqxa+CaJ6Yt42CXomi8rIDC85
 mlvziXFlmkn3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 33/39] drm/amd/display: Add case for dcn35 to
 support usb4 dmub hpd event
Date: Mon, 25 Dec 2023 19:19:23 -0500
Message-ID: <20231226002021.4776-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002021.4776-1-sashal@kernel.org>
References: <20231226002021.4776-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.8
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
Cc: aric.cyr@amd.com, wenjing.liu@amd.com, dri-devel@lists.freedesktop.org,
 Jun Lei <jun.lei@amd.com>, airlied@gmail.com, Sasha Levin <sashal@kernel.org>,
 Rodrigo.Siqueira@amd.com, amd-gfx@lists.freedesktop.org, alvin.lee2@amd.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, chiawen.huang@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, samson.tam@amd.com,
 Qingqing.Zhuo@amd.com, Xinhui.Pan@amd.com, Roman Li <roman.li@amd.com>,
 gabe.teeger@amd.com, daniel@ffwll.ch, Wayne Lin <wayne.lin@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <wayne.lin@amd.com>

[ Upstream commit 989824589f793120833bef13aa4e21f5a836a707 ]

[Why & how]
Refactor dc_is_dmub_outbox_supported() a bit and add case for dcn35 to
register dmub outbox notification irq to handle usb4 relevant hpd event.

Reviewed-by: Roman Li <roman.li@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 26 ++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index a1be93f6385c6..8cdf380bf3665 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4865,18 +4865,28 @@ void dc_mclk_switch_using_fw_based_vblank_stretch_shut_down(struct dc *dc)
  */
 bool dc_is_dmub_outbox_supported(struct dc *dc)
 {
-	/* DCN31 B0 USB4 DPIA needs dmub notifications for interrupts */
-	if (dc->ctx->asic_id.chip_family == FAMILY_YELLOW_CARP &&
-	    dc->ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0 &&
-	    !dc->debug.dpia_debug.bits.disable_dpia)
-		return true;
+	switch (dc->ctx->asic_id.chip_family) {
 
-	if (dc->ctx->asic_id.chip_family == AMDGPU_FAMILY_GC_11_0_1 &&
-	    !dc->debug.dpia_debug.bits.disable_dpia)
-		return true;
+	case FAMILY_YELLOW_CARP:
+		/* DCN31 B0 USB4 DPIA needs dmub notifications for interrupts */
+		if (dc->ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0 &&
+		    !dc->debug.dpia_debug.bits.disable_dpia)
+			return true;
+	break;
+
+	case AMDGPU_FAMILY_GC_11_0_1:
+	case AMDGPU_FAMILY_GC_11_5_0:
+		if (!dc->debug.dpia_debug.bits.disable_dpia)
+			return true;
+	break;
+
+	default:
+		break;
+	}
 
 	/* dmub aux needs dmub notifications to be enabled */
 	return dc->debug.enable_dmub_aux_for_legacy_ddc;
+
 }
 
 /**
-- 
2.43.0

