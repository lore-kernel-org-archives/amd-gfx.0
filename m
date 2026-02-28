Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301B3FEE4EC
	for <amd-gfx@archiver.kernel.org>; Sat, 28 Feb 2026 09:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0EA410E296;
	Sat, 28 Feb 2026 09:19:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l0yFnV7J";
	dkim-atps=neutral
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B23310E1F6
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Feb 2026 04:54:23 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-7986e538decso26900657b3.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 20:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772254462; x=1772859262; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EmSz6Ee1J0Z/MD/2JF/g5iVQIYrLtpWsPv+WCazK24Q=;
 b=l0yFnV7JKVw3/BuJzmr5K96J/0C7edJISAKcUQ7zW8X2996JKo1BC2KVhQe6duEuQL
 SFdzNCy7urU/RDzCImB+qLrZIHxzLh7DM/L0U/j+XBZug2qUt9wC3F1av6rqvXkG5T7w
 HwfSvK1VWHbDU2FlfhVVYpWkh8jC8spgZsYYjqJSnZmpYlEHOxhO0b3JmnSpXCFWvSu7
 ufebCJbVtWKTiDZKmXaGqNTg83i9PkACvYNyMhNSqsJNVfvH2jeXqu/o/XSeYLB38WRT
 rDvvMxLGK/oz4y6QrGlEjeJ3CEUvOVr2bQj7azkSTIlSCNA3FVGLPqt3L2knM9OHLWCn
 U2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772254462; x=1772859262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EmSz6Ee1J0Z/MD/2JF/g5iVQIYrLtpWsPv+WCazK24Q=;
 b=G7oquFOvUF5ZDrsittyzvHlQ/Q+Ip19iA/EQagHehak7CXrHr8itXiTUIQFZi0XvDi
 w5B9tl+9IHkz9RuKGhrArMelJVNZStZmYovB37oia8L0OEeAgfCARYtO5ro4VvlUI+J/
 hoICsbrUK6V94scDbd+v8NG4D9zljMRmS5S0he0njubC83CR4fZKhCfbApvUznZLkGM+
 4O1habntoREvwSN2Z79ZCIRdXTkaMguiBShgm2purtKxzjjL4yeWEWS3l5Etrot/5Pq0
 eCvMTlPG490iYTcZhMOKoi+fR+n7JuZOxCM65lJPi49aWBGMd56S0Kh8QQuAm+YZ6Bqr
 QAWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZWO08MMEMkZA7JzGiePw36OqMzCUteJmW4taDVob2bCyRrxrMEMbcfp1yF+9c9oLGe8HUrUVx@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy1oZieitPuzTxmupsnUWfVz05HjmjmY9qa796w4K460wz5L446
 jiPenocH3ssRPVhmVSXWFbjXthEWsjKa1Xor2ivFZsZRf0A14R3gRBv1
X-Gm-Gg: ATEYQzzQxejDo+DOqkU7lTh+Fn5gPW+KyKV4Cz+kmZXj6xP/7ExqJSkY7icJrONoxjl
 TR7QZguHlff1SaAtGOsIYM7NCJFYZX745F13JTqn4qJowBhNqyk0jKBTvGJt/HmuqnreBljJXaC
 +I9Z/PUcVaD5hvHGLEIkbX12VwlIJPKAdjQCstG5cFZH2kYsvlu+lxSi2lcvz3TvrDKieg8damh
 r+2gq0AxSq3KBrPwfjdHMBd4DqJ+E0PI8QnVRY7bubMTfCv5k8Ptc0U4czb0X2D9vS/YALMQ3EO
 BwLCS3/jyXQAWZ5f9cEZwIv+gb5eJ3d4rn+dmejuQ/br5o+FOugByMzfXt6hwdpcJpMWoAsu6AC
 2gy+F4axUmt+gBRwrGU7LQ07VlHb0IHEssDLUjyN3cbTcl3lNh2P4lZccqGJ0+eK1NCTezcbYic
 /wCUS+qJW+DlO3VEo9rAF+c70z+q+GWPBcrCPGf5Ecd9QmivbgwEWObg==
X-Received: by 2002:a05:690c:ed6:b0:798:6561:2a5e with SMTP id
 00721157ae682-7988549d803mr48648597b3.19.1772254461949; 
 Fri, 27 Feb 2026 20:54:21 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-79876bf8103sm29865967b3.27.2026.02.27.20.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 20:54:20 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kenneth Feng <kenneth.feng@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Hung <alex.hung@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Lijo Lazar <lijo.lazar@amd.com>, "chr[]" <chris@rudorff.com>,
 Sasha Levin <sashal@kernel.org>, Wentao Liang <vulab@iscas.ac.cn>,
 amd-gfx@lists.freedesktop.org (open list:AMD DISPLAY CORE),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 for 6.112 and 6.6 1/2] drm/amd/display: Add pixel_clock to
 amd_pp_display_configuration
Date: Fri, 27 Feb 2026 20:53:55 -0800
Message-ID: <20260228045356.3561-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260228045356.3561-1-rosenp@gmail.com>
References: <20260228045356.3561-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 28 Feb 2026 09:19:11 +0000
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
index 848c5b4bb301..016230896d0e 100644
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
index 13cf415e38e5..d50b9440210e 100644
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
index facf269c4326..b4eefe3ce7c7 100644
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
index acd1cef61b7c..349544504c93 100644
--- a/drivers/gpu/drm/amd/include/dm_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/dm_pp_interface.h
@@ -65,6 +65,7 @@ struct single_display_configuration {
 	uint32_t view_resolution_cy;
 	enum amd_pp_display_config_type displayconfigtype;
 	uint32_t vertical_refresh; /* for active display */
+	uint32_t pixel_clock; /* Pixel clock in KHz (for HDMI only: normalized) */
 };

 #define MAX_NUM_DISPLAY 32
--
2.53.0

