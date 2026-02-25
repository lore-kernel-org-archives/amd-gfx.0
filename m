Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F380FCE084
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 13:55:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FBB110E943;
	Thu, 26 Feb 2026 13:55:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V5QZMxbz";
	dkim-atps=neutral
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com
 [209.85.219.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63EC710E0A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Feb 2026 23:50:35 +0000 (UTC)
Received: by mail-qv1-f67.google.com with SMTP id
 6a1803df08f44-896ff127650so4575126d6.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Feb 2026 15:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772063434; x=1772668234; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+BkblkEJs+X0mWovyrEaETuHy2IBYlQP27IPZgkim9E=;
 b=V5QZMxbzFEW1CPMuBH7IHaocJ2MTLhddOZtWhRoEe/SsIS6c8HHMk2BQZzd+8GeXny
 cM5/iLQiFkiV/1nVhQpXXKjn0AJg0qHIj1LiA1jj6qbMr3wNAlD/kJZ9LuZ56kEIhJpA
 +lngXJbWxHsYrrHxqSqdn23CnxJeu9tr8c7LnBZHSBMDXQD1DZQHxaJTsItdOuvY5+FI
 zTqxhtSFGfWLL9hfnk12N2L+eOrVbe48m4JJlUqxwmhWnAaItwXIm/VJNS/bpS1UXVdZ
 uOHF708Zv7FBisnokbyvWWk0OXznQcIB6XtSpSbfD3nLQfQN+m725Eqvu1gXmxrXt/q/
 RTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772063434; x=1772668234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+BkblkEJs+X0mWovyrEaETuHy2IBYlQP27IPZgkim9E=;
 b=PbiuYFTt6yqkCNysrtJQiqr1M0MP/nQ5nYMRpz9KpF/gG3h5CASKc0xCQOx6kwpF4n
 9e0qNJ4N3n7ROYh9T2KPqPL39Uosp57GZ0GlNF3wAUS8c+FUI6cURHZWQeIRIN6GGX+6
 OWIMcrrvhasJ//8bnFMdwrcWd13cM0f/pIOScnmQWxa5Y+Oa47rq1SskNaTeY8Vtmhy6
 8iZdPq0b4kOIMk0uZ3aVglxDbEF56DSM8iXGgDiyv2T2dAlDYLamwjLslXSa7Mr0vjuE
 7fzp8Z0xxd87OoGxIeYOGbPDWtEvXPMlWXo3LZUa/+NL+sMKjXXOXopUjWOO2LG3UmDZ
 Cc3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFLO0XQ1WVHIdLPzjaSj/8+7KH7XfeOsJaZTZs0OdTDw0P+JLyDoRrfEiZ5kHuUATCN1vAdXKV@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxbyKpCgDIZHkRazLzdrD6dL9t4JAwrdeM5mOcx8lA4InSWHfAy
 AK1TImAeVpnVLrB0qC8HMAlZc7gP6iaXLRw8AoNIitsw2GZGOf7ftaxv
X-Gm-Gg: ATEYQzxF5tCxWUBbxPoCCZ4e425xrbjeO+ZzsU9gXNs7RQ4Vg2gfUrBxt/ZPF8VmHNl
 UZWfejDfWLbtp2/pIl/9amZg4lr4TpdYCTf+12czqjeZprrOFnluqirekFyqjhPrurW2W/urYgl
 eDQqX1SV017o6BLPXz5oJYYzVk1LKcAiLF+v5O6iZ0ecGm4oluzTRDnG3/F/D7LcuvVVIDlwFOB
 NHY2EQtN4XVZBL7zp/ZzCiI1jwKjEBH2geipJkOFufQOShoFbJ//FcYePQhqUwjH5pLrXZpFhII
 cu1q/lpyZV6v/EvvHZeG7PlM36mXeHYjO5JnxIpuvkdfgAIxak8w0qa2AsvrM37ORpp2UDbyCOp
 LzrOvaBO2GC5U7h+pLlUf6GfZFnifi9HBT/wS09zQDHq0LZRCeE2xVHfmXR/P9rqXCFV+No4q7B
 QN4a/rvc893DmG1cxTXVSlKKKcnsbw30aE6SI5XMIM/m5nOcJ9NEvnRg==
X-Received: by 2002:a05:6a20:6a15:b0:394:a026:4c60 with SMTP id
 adf61e73a8af0-395ad0f204fmr1569006637.32.1772056234431; 
 Wed, 25 Feb 2026 13:50:34 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c70fa8059bcsm11990a12.18.2026.02.25.13.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 13:50:33 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kenneth Feng <kenneth.feng@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Hung <alex.hung@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 "chr[]" <chris@rudorff.com>, Sasha Levin <sashal@kernel.org>,
 Wentao Liang <vulab@iscas.ac.cn>,
 amd-gfx@lists.freedesktop.org (open list:AMD DISPLAY CORE),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/amd/display: Add pixel_clock to
 amd_pp_display_configuration
Date: Wed, 25 Feb 2026 13:50:12 -0800
Message-ID: <20260225215013.11224-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225215013.11224-1-rosenp@gmail.com>
References: <20260225215013.11224-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Feb 2026 13:55:07 +0000
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

commit b515dcb0dc4e85d8254f5459cfb32fce88dacbfb upstream.

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

