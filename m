Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 112981094465
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Mar 2026 09:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83B3B10E2B1;
	Sat, 21 Mar 2026 09:47:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SrDW3CGk";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF76D10E2E1
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Mar 2026 05:45:18 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-c70fb6aa323so1022411a12.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 22:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774071918; x=1774676718; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o1e3VlB8M6gxe/ov0H5wYQTMPrywihYmSqb8em+k4zw=;
 b=SrDW3CGkTAw0CBIsrrr66VRBZP4fSY1nVa/9x+ujDlYGYlOGdxA9HijUIkXeCebD+S
 OPR770DkjOc12foATwwSNcMPugOlSpIJotDkHLGapSUl4CsG6iHkMklal/j5G0aoTkzu
 HNA22Vb1tYY+QzwugJcKJiHXYRxGudKgSv+xFvh268iINRjTI6eAgX8BhQzhFY8+3VuL
 Mnp3pbirTRTaSUhx1Y+W/BM0vD3XxZrFsJOYfFm+R77xCFsbSdTIUZw9R8dTtcVxMiei
 KkzINH/Y7LN8NrMnhh8NF+iDPzP5pSbqgVnXfUzoyx3g4BLNQkeKX1LfzpGNhaUlwcKl
 39SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774071918; x=1774676718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o1e3VlB8M6gxe/ov0H5wYQTMPrywihYmSqb8em+k4zw=;
 b=n2t3YWQREHLHTAGydvA2rbwGhZwQEWIS+26l5GgZg5F2sGRo8ktrHpkKjYPy3plI+S
 yPdImmowyqfNCl3ldVIrCfoPs4CR8WVYiTi8jlxDZuO2d1rs1FfiMsbSb0YYI30ntDcG
 rQ2r4uJS33v2YGuumgn+lhESiRw+gl03Wu+10vvZNgMqpTp6Rvwpq2uza83pU8TREdj7
 P45YA89lhDhNsH6U/6Y0sSN5pXxhjOP6GPYbJQByX9adxWeXFqTT30aQbua3IPNxEIl/
 q+nyBD3/8YGyf5lAHp23J8TqBTFkegt+SenYhLeJ07McZ8ZPNDtavvfVdlSuNGyWRib9
 IUMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZGGu65MtQqp3dHHEB5Y01m5PHDwmSb6vgg17FFvonMVPuKN2fOjeDuMUIGpw2ac89Lm9CZ5DK@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+yGfHo9KWxJXEqMb6bko5RCeHCbMniR6MUhnT9bRBmN9en8jq
 YfMcXsM982v00gmr6ky2qyH0S7a1ck6G+jI4MefDKozinparUu8y2eBh
X-Gm-Gg: ATEYQzzswycVzcRZrFPo3eIOH+LiW7UzrwFzolNS4m9+vHVs3rtlvM9H5XyxcgWTE5/
 P1T38j7189oPP+bMxwJ8n5ycYiT8nVpplCI2ie4XByXwNBYBd+gn1scVwFX+OkiBu9MVfCP4xh4
 5R1xe+ar2wcoMiPm0X5+S+3KoCipdQxbQesscAoZ6rt183M6rpIlv2g9OxTNm/+8gSWPTya7mdU
 2crDe8qgwM8MMSSIAJhmi2znF25pESaKHyqZyXccSqUjEkEhfjsv3VHfY8wk4b2TBzmYe0KUcgC
 FDQUa/qhwhx6oYVozPefckXuQAP2bcD/UFZXobhkvlFNrMlyojt5HOycrvjHtzWOsX7q8uhUUqL
 bv8RneBDx370n+5Zie8BW6tEAhKrrDiYJn64oYLfEAz2ANOSqWpH10+1W1b9LJ3iRh6BYy32OF+
 1rDKtOSsjDS5vipqABgY6Sgnf/3/0ZZP9xx3A9/bVRnC/srB4540tOVuQ=
X-Received: by 2002:a05:6a21:6d99:b0:398:7357:bb81 with SMTP id
 adf61e73a8af0-39bce9f0d74mr5250717637.15.1774071918403; 
 Fri, 20 Mar 2026 22:45:18 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b0409c681sm4338783b3a.37.2026.03.20.22.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 22:45:17 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Evan Quan <evan.quan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Sasha Levin <sashal@kernel.org>, Rosen Penev <rosenp@gmail.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Zhigang Luo <Zhigang.Luo@amd.com>, Bert Karwatzki <spasswolf@web.de>,
 Ray Wu <ray.wu@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Roman Li <Roman.Li@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Hung <alex.hung@amd.com>, decce6 <decce6@proton.me>,
 Wentao Liang <vulab@iscas.ac.cn>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 for 6.1 3/4] drm/amd/display: Add pixel_clock to
 amd_pp_display_configuration
Date: Fri, 20 Mar 2026 22:44:52 -0700
Message-ID: <20260321054453.19683-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321054453.19683-1-rosenp@gmail.com>
References: <20260321054453.19683-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Mar 2026 09:47:17 +0000
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

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit b515dcb0dc4e85d8254f5459cfb32fce88dacbfb ]

This commit adds the pixel_clock field to the display config
struct so that power management (DPM) can use it.

We currently don't have a proper bandwidth calculation on old
GPUs with DCE 6-10 because dce_calcs only supports DCE 11+.
So the power management (DPM) on these GPUs may need to make
ad-hoc decisions for display based on the pixel clock.

Also rename sym_clock to pixel_clock in dm_pp_single_disp_config
to avoid confusion with other code where the sym_clock refers to
the DisplayPort symbol clock.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c       | 1 +
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dm_services_types.h             | 2 +-
 drivers/gpu/drm/amd/include/dm_pp_interface.h                  | 1 +
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index 75284e2cec74..c4e7d9212cd4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -97,6 +97,7 @@ bool dm_pp_apply_display_requirements(
 			const struct dm_pp_single_disp_config *dc_cfg =
 						&pp_display_cfg->disp_configs[i];
 			adev->pm.pm_display_cfg.displays[i].controller_id = dc_cfg->pipe_idx + 1;
+			adev->pm.pm_display_cfg.displays[i].pixel_clock = dc_cfg->pixel_clock;
 		}

 		amdgpu_dpm_display_configuration_change(adev, &adev->pm.pm_display_cfg);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
index fb2f154f4fda..bce53ab36f3e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
@@ -164,7 +164,7 @@ void dce110_fill_display_configs(
 			stream->link->cur_link_settings.link_rate;
 		cfg->link_settings.link_spread =
 			stream->link->cur_link_settings.link_spread;
-		cfg->sym_clock = stream->phy_pix_clk;
+		cfg->pixel_clock = stream->phy_pix_clk;
 		/* Round v_refresh*/
 		cfg->v_refresh = stream->timing.pix_clk_100hz * 100;
 		cfg->v_refresh /= stream->timing.h_total;
diff --git a/drivers/gpu/drm/amd/display/dc/dm_services_types.h b/drivers/gpu/drm/amd/display/dc/dm_services_types.h
index b52ba6ffabe1..954b3aa65adb 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_services_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_services_types.h
@@ -127,7 +127,7 @@ struct dm_pp_single_disp_config {
 	uint32_t src_height;
 	uint32_t src_width;
 	uint32_t v_refresh;
-	uint32_t sym_clock; /* HDMI only */
+	uint32_t pixel_clock; /* Pixel clock in KHz (for HDMI only: normalized) */
 	struct dc_link_settings link_settings; /* DP only */
 };

diff --git a/drivers/gpu/drm/amd/include/dm_pp_interface.h b/drivers/gpu/drm/amd/include/dm_pp_interface.h
index 1d93a0c574c9..ee4212cc93d1 100644
--- a/drivers/gpu/drm/amd/include/dm_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/dm_pp_interface.h
@@ -66,6 +66,7 @@ struct single_display_configuration
 	uint32_t view_resolution_cy;
 	enum amd_pp_display_config_type displayconfigtype;
 	uint32_t vertical_refresh; /* for active display */
+	uint32_t pixel_clock; /* Pixel clock in KHz (for HDMI only: normalized) */
 };

 #define MAX_NUM_DISPLAY 32
--
2.53.0

