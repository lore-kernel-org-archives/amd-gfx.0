Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8CDC83F1A
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jul 2025 13:43:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 205EA10E54F;
	Mon, 21 Jul 2025 13:43:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="exvffVbL";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 735F710E284
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jul 2025 13:43:55 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 688A7A5462B;
 Mon, 21 Jul 2025 13:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E5BC4CEED;
 Mon, 21 Jul 2025 13:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1753105434;
 bh=pro29KEPMRLoagSJ/fdxTVhSrn2ZnvtGDUaZZ6K9JMc=;
 h=From:To:Cc:Subject:Date:From;
 b=exvffVbLvOn/icKonyzlBO2iwXtKH6tcejjmx7keI7badUZ46ozVpvUZPnPMFMr4i
 2JS3uFQa78sYPlDGjfI87sbF4Sm9DBZAubuv3Ty37vO9NP5rTpH0BO5JFCPxy2TnTd
 h4+Nxn6ew3a08316GQIK+N9up06f/BnWtAk6Bj/CRRQZlcpFP8Zeon1HMJLiqkeUaS
 TnpBMIcRgJp+z2H0Ou7v4Sa6tlYHRLoAWrKTvP1m4E0t5tZM4Ns4ff90/yu+02kG6U
 ng+cXz0PmGaQbhS2I7lZUq8p9wMcOAm2LUpbxBk58gaz1WVM2BEl5m/qbP9CixHww9
 Fh/7eZaCIw/7A==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH] Revert "drm/amd/display: Fix AMDGPU_MAX_BL_LEVEL value"
Date: Mon, 21 Jul 2025 08:43:50 -0500
Message-ID: <20250721134350.4074047-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mario Limonciello <mario.limonciello@amd.com>

This reverts commit 66abb996999de0d440a02583a6e70c2c24deab45.
This broke custom brightness curves but it wasn't obvious because
of other related changes. Custom brightness curves are always
from a 0-255 input signal. The correct fix was to fix the default
value which was done by [1].

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4412
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/amd-gfx/0f094c4b-d2a3-42cd-824c-dc2858a5618d@kernel.org/T/#m69f875a7e69aa22df3370b3e3a9e69f4a61fdaf2
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8e1405e9025ba..f3e407f31de11 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4740,16 +4740,16 @@ static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 	return 1;
 }
 
-/* Rescale from [min..max] to [0..MAX_BACKLIGHT_LEVEL] */
+/* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */
 static inline u32 scale_input_to_fw(int min, int max, u64 input)
 {
-	return DIV_ROUND_CLOSEST_ULL(input * MAX_BACKLIGHT_LEVEL, max - min);
+	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max - min);
 }
 
-/* Rescale from [0..MAX_BACKLIGHT_LEVEL] to [min..max] */
+/* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
 static inline u32 scale_fw_to_input(int min, int max, u64 input)
 {
-	return min + DIV_ROUND_CLOSEST_ULL(input * (max - min), MAX_BACKLIGHT_LEVEL);
+	return min + DIV_ROUND_CLOSEST_ULL(input * (max - min), AMDGPU_MAX_BL_LEVEL);
 }
 
 static void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
@@ -4977,7 +4977,7 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 		drm_dbg(drm, "Backlight caps: min: %d, max: %d, ac %d, dc %d\n", min, max,
 			caps->ac_level, caps->dc_level);
 	} else
-		props.brightness = props.max_brightness = MAX_BACKLIGHT_LEVEL;
+		props.brightness = props.max_brightness = AMDGPU_MAX_BL_LEVEL;
 
 	if (caps->data_points && !(amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE))
 		drm_info(drm, "Using custom brightness curve\n");
-- 
2.43.0

