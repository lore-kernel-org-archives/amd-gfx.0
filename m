Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68AC5D1951E
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 21:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDA4310E4B1;
	Mon, 26 Jan 2026 21:08:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fpZz5R7B";
	dkim-atps=neutral
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D05D10E4AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 21:08:51 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id
 ffacd0b85a97d-432d2c96215so4357771f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 13:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769461730; x=1770066530; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=72O6qoU4sDQE58hAIYzcICyqzsr2ChrCP5KxX8cohqQ=;
 b=fpZz5R7BZqdWfib7ZJAbosa48KFNw3/AKswD3J9BGqPJpygl2m7RjaEU3ZsElmE3wC
 tIoN1Sy3eGbYbd7MBnYRMcHEl60u5Vyn0/BiNiOvHcd7Vriql80641w+Pp6HPPOtKM1U
 m5lLlzC4hQQHJL1ZSH0YZH9Val6LXKg36FLeXx61hPrc7rjO4Z4IjRn8yj1eT8Xj+OVt
 m+zSjKCcx8wg0J3tlod+B6y/AB1r3Fo+bJTtdu67qmVPAryfxyYzp+gML6M6LM3gVDbF
 4orKI2vbn+KxoJuRnkZrYTjV8L7Smg83CF238LTcQV6hCv6wZTMY9LqVvQ0n/jA0YZZA
 sKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769461730; x=1770066530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=72O6qoU4sDQE58hAIYzcICyqzsr2ChrCP5KxX8cohqQ=;
 b=bWUILIp1SKDQSJAP7AP3P9q9J9BD7gTYG2ccXo7Vs+09guzA1KF7Xz94NWAsX7Iob7
 H949lfWk+njWARrr5mgoXvDx1A1sGccJUI232u+y+4NSg92nwx0Bdtpjw+7N9fS6FkEA
 AF4ttW6YPDFZqiVFhojvg+P3Julllx4cV0JDa3fchD1WoUMHgKXS/BG3Ns2ZzUQB7nlp
 3o9o3rKSzWAxaOR9+MBerJHVrc4+XaU393cD1ICLT89zJQNky4FTX9dDOZflTj4g01rH
 hjYbf6EMfooXWlBuUJybV3+ThnK0gz+bpVAU8Y2gj0E2XSqJ2gexH5SZXsOFSRfhwmme
 G/7A==
X-Gm-Message-State: AOJu0YzT0y1wQcZ1wF5YqEE8s9fSrM6+yVam1D60Jir4VCL85ks55mlP
 gXi6/OZkDz3uVbSHdzM7MPeoier8W5HCLfv1s4R4a+n6lH0gYEWaUvC/XOyjdksZ
X-Gm-Gg: AZuq6aK/xfMxRR6EgENA8kXk4xhuJEsrVm9SGpRBiJdHdZr3kdkMIvojTC0az7Ep5EO
 Lz9h2lwgfp9TqmNZxxg0hPAZ8TuBwx6ZG1qFcMYcih7owKFkNxKklPbxu+JQWRr6bkGr6uKiL8X
 xYJd+HED44wnUbUw5O1MMxy33XWyfmpmDSvBQLL0XfjtjAEc0cFRvFMXCEDhoSZ3mfNc+/wpoim
 3zOm/Zg93HiehZuivq/KiMHlTORBWwi/JEBZGz4bXHFvUp1P/vfpEHuF5PCvtUN40TN/e7OqRnw
 IdDOJLkOzKvDodnC/lAOCsBD9Xxa8sXlTVVQf+MRLMPs0aAvRVMTvwC8BkxDtJEcGKBqUvFNEos
 oF0Z7OqdnxE2TFC2vi8X6/cneaI3tDSyfE/Uv8GG5oRFHlA7IN+3tw1MnKHx8hFUMUB3Kq9XJrL
 bT401X9B2fIh6I8+OPDdqdYErUVaO+2wkfRHmwaTlA14i9QVb0SJzV
X-Received: by 2002:a05:6000:400d:b0:431:1ae:a3ca with SMTP id
 ffacd0b85a97d-435ca0e2adbmr10339134f8f.11.1769461730029; 
 Mon, 26 Jan 2026 13:08:50 -0800 (PST)
Received: from Timur-Hyperion.home (54001FF2.dsl.pool.telekom.hu.
 [84.0.31.242]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24acdsm33940275f8f.13.2026.01.26.13.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 13:08:49 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Prike Liang <Prike.Liang@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, siqueira@igalia.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 11/14] drm/amd/display: Link detection for external DP bridge
 encoders
Date: Mon, 26 Jan 2026 22:08:34 +0100
Message-ID: <20260126210837.21885-12-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126210837.21885-1-timur.kristof@gmail.com>
References: <20260126210837.21885-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Deal with some minor idiosyncracies of TRAVIS and NUTMEG chips.

- Always use DP signal type with these chips so that the
  normal DP code paths can work with them without a major
  refactor of the code base. Properly set this.

- NUTMEG seems to only work with HBR, not RBR, so set a
  preferred link rate for this chip.
  See amdgpu_atombios_dp_get_dp_link_config() for reference.

- NUTMEG is recognized as a DP branch device but reports 0 sinks,
  which is wrong and confuses DC (it hits an early return).
  Fix that by hardcoding the sink count to 1.

- Fixup old DC code selecting a special panel mode necessary
  for NUTMEG and TRAVIS.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../drm/amd/display/dc/link/link_detection.c  | 20 +++++++++++--------
 .../link/protocols/link_edp_panel_control.c   |  8 ++------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 2ccbca570c77..aa3df3a090d5 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -150,14 +150,6 @@ static enum signal_type get_basic_signal_type(struct graphics_object_id encoder,
 		default:
 			return SIGNAL_TYPE_NONE;
 		}
-	} else if (downstream.type == OBJECT_TYPE_ENCODER) {
-		switch (downstream.id) {
-		case ENCODER_ID_EXTERNAL_NUTMEG:
-		case ENCODER_ID_EXTERNAL_TRAVIS:
-			return SIGNAL_TYPE_DISPLAY_PORT;
-		default:
-			return SIGNAL_TYPE_NONE;
-		}
 	}
 
 	return SIGNAL_TYPE_NONE;
@@ -174,6 +166,10 @@ static enum signal_type link_detect_sink_signal_type(struct dc_link *link,
 	struct audio_support *aud_support;
 	struct graphics_object_id enc_id;
 
+	/* External DP bridges should use DP signal regardless of connector type. */
+	if (link->ext_enc_id.id)
+		return SIGNAL_TYPE_DISPLAY_PORT;
+
 	if (link->is_dig_mapping_flexible)
 		enc_id = (struct graphics_object_id){.id = ENCODER_ID_UNKNOWN};
 	else
@@ -620,6 +616,14 @@ static bool detect_dp(struct dc_link *link,
 		link->dpcd_caps.usb4_dp_tun_info.dp_tun_cap.raw = 0;
 	}
 
+	if (link->ext_enc_id.id) {
+		/* Fix number of connected sinks reported by external DP bridge */
+		link->dpcd_caps.sink_count.bits.SINK_COUNT = 1;
+		/* NUTMEG requires that we use HBR, doesn't work with RBR. */
+		if (link->dpcd_caps.branch_dev_id == DP_BRANCH_DEVICE_ID_00001A)
+			link->preferred_link_setting.link_rate = LINK_RATE_HIGH;
+	}
+
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index aa02b38e183a..5b2c1a4911cf 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -100,11 +100,7 @@ void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode)
 
 enum dp_panel_mode dp_get_panel_mode(struct dc_link *link)
 {
-	/* We need to explicitly check that connector
-	 * is not DP. Some Travis_VGA get reported
-	 * by video bios as DP.
-	 */
-	if (link->connector_signal != SIGNAL_TYPE_DISPLAY_PORT) {
+	if (link->ext_enc_id.id) {
 
 		switch (link->dpcd_caps.branch_dev_id) {
 		case DP_BRANCH_DEVICE_ID_0022B9:
@@ -124,7 +120,7 @@ enum dp_panel_mode dp_get_panel_mode(struct dc_link *link)
 			}
 			break;
 		case DP_BRANCH_DEVICE_ID_00001A:
-			/* alternate scrambler reset is required for Travis
+			/* alternate scrambler reset is required for NUTMEG
 			 * for the case when external chip does not provide
 			 * sink device id, alternate scrambler scheme will
 			 * be overriden later by querying Encoder feature
-- 
2.52.0

