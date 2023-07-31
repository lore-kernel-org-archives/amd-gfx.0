Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E16DC001DE
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jul 2023 08:35:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A20110E228;
	Mon, 31 Jul 2023 08:35:24 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEE5D10E1E0;
 Mon, 31 Jul 2023 08:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3GMROXAYbCav4LW+EhvTx54QB702D8drF7pIbguM9xo=; b=GYLFvrlXtHfHMzwzC23FaDRyMa
 bvrzg8gD63VYYujE29l5xw6JQ3H7sc01Q+u7scVXNO8tW/do/LdppY3aI+3bu14gH4z6AttRyBnQ5
 Jdz4mlj2ozxo3xTE/HqRKRYCUgL1qUiYRt5HZFPNHt3ZCZLeFQK95+ThezjE7SWmlsbpTz3maYQg6
 H5/utcbtV5WaMVNf4LfnoWHLeSF/RD7aF9iFRb02XYlIJqDB98mu93qcwTYm1+o1jb+wEO7Hkvt4k
 6rq8AHbgRuB9vNCUKSnrqEoTOinc+xxCuD2xPYChpUwItYStX8IS4XJsCNmLEXM6x18+WsZof6w+R
 hfSqhp4A==;
Received: from [38.44.68.151] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1qQOMt-007N1E-O1; Mon, 31 Jul 2023 10:35:07 +0200
From: Melissa Wen <mwen@igalia.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, Bhawanpreet.Lakha@amd.com
Subject: [PATCH] drm/amd/display: check attr flag before set cursor degamma on
 DCN3+
Date: Mon, 31 Jul 2023 07:35:05 -0100
Message-Id: <20230731083505.1500965-1-mwen@igalia.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
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
Cc: Krunoslav Kovac <krunoslav.kovac@amd.com>, Alex Hung <alex.hung@amd.com>,
 Simon Ser <contact@emersion.fr>, Xaver Hugl <xaver.hugl@gmail.com>,
 amd-gfx@lists.freedesktop.org, Michel Danzer <mdaenzer@redhat.com>,
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 Nicholas.Kazlauskas@amd.com, Joshua Ashton <joshua@froggi.es>,
 sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Don't set predefined degamma curve to cursor plane if the cursor
attribute flag is not set. Applying a degamma curve to the cursor by
default breaks userspace expectation. Checking the flag before
performing any color transformation prevents too dark cursor gamma in
DCN3+ on many Linux desktop environment (KDE Plasma, GNOME,
wlroots-based, etc.) as reported at:
- https://gitlab.freedesktop.org/drm/amd/-/issues/1513

This is the same approach followed by DCN2 drivers where the issue is
not present.

Fixes: 03f54d7d3448 ("drm/amd/display: Add DCN3 DPP")
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
index e5b7ef7422b8..50dc83404644 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
@@ -357,8 +357,11 @@ void dpp3_set_cursor_attributes(
 	int cur_rom_en = 0;
 
 	if (color_format == CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA ||
-		color_format == CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA)
-		cur_rom_en = 1;
+		color_format == CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA) {
+		if (cursor_attributes->attribute_flags.bits.ENABLE_CURSOR_DEGAMMA) {
+			cur_rom_en = 1;
+		}
+	}
 
 	REG_UPDATE_3(CURSOR0_CONTROL,
 			CUR0_MODE, color_format,
-- 
2.40.1

