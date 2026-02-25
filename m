Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646C8FCE085
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 13:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E64AD10E940;
	Thu, 26 Feb 2026 13:55:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TJy2YF0T";
	dkim-atps=neutral
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ED0C10E840
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Feb 2026 23:38:38 +0000 (UTC)
Received: by mail-qk1-f194.google.com with SMTP id
 af79cd13be357-8cb7edbcde6so17899085a.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Feb 2026 15:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772062717; x=1772667517; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+BkblkEJs+X0mWovyrEaETuHy2IBYlQP27IPZgkim9E=;
 b=TJy2YF0TVRqig7iZvm3GAtPYajR13w0FbNSYgJ6uOampUlyWfP31ziQbSg/SgRu9oS
 L6IamUqaamDwkabJBgc5MUzDh2ahiDt9kNg5uYnsq+gazCbdasx8upOsCJOCmOuN7AYO
 5g/dW7tK339F5X2K0LBERGY6WOMFCX77Ubol8ivsSFWekWQUsHqep1TF0lQl5lnBRkAu
 yYFW/ReEJ4YnLkYhMenA1Lzbkf1S5wV8bufz2kMAtKigCwuKBvpJt7KP4Pa1o32qM1WD
 PBty46z5mTkuMvAunRvnbUfbHv39vqcRNpUFm7l56m6XUp+GsSreJIOi3rqYf6QekWmc
 bu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772062717; x=1772667517;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+BkblkEJs+X0mWovyrEaETuHy2IBYlQP27IPZgkim9E=;
 b=fOZEHBn8vaaZQ8aGEuxkEiLZhLJBXHpZWADDrPddeTAiwS0pmRxV+TCBHSq6BVp0Du
 NBwCuKy4Tf7IF6duGf7hPhQo9B64XQ4BPlDFftGvDZr3FBgi90mPPikVGGzBboyKhMK+
 /BmLB+dCx6lST6vGhc1Sw/EAO5mQOuGaeGzEP2cUVrVsJj4qRz29IBrtElv6U97ITBod
 RRGsVP4xfbuTSudbsfXam343mLPE0pbjhpeoXFfQWzw7/v1f8xM417Mz4HhT04p/mHx0
 hx2wedNZMobPt9m0h9H43ZwpUClgkg0CQ3hAK5eGD9eBclIyWer3IfRk1H3+q77T+AIg
 04jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5hceQq9mypdSQCBReV41/+uUsSNociSZVNDYcDYcRqB4vzIXRcRntUmXT8iVWxvchepDW+uzv@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw554D2prY0imiq0HvOoI0lUQCMXF1t8T4Exbg20l+d6pB39D+G
 2SJQI0nv5fV/XpW5kYwBIVAXzSxb0BOHfoIdbMzMScCUR8kBJps16fgYU8qJS3Wiwvo=
X-Gm-Gg: ATEYQzxyNIgWVuzpfH221HQVHULa00BN+8ER7pOEgB2C+idL9yWvZSOhBZ8BzMgHGhK
 xbxmViCQNA62W4q5z7ExAFeZMvLRY8vFB2xI+Bczuua/q/ClJvwI9jaLo8DVH08PYwabuzpvRhd
 E6Z2EwiuQjDkpFOaiba1dmRGa7dXBbHQkzDBjDVRAh0wOgIp9JjP53SwsOJ1G2ej19HNcMEhXsj
 yAc7gar7DkwoNlEofRiX5rZzkhTW1SE0e/6hV6qBJYQ5qcYVOG7PEvX5hqkOQ1p8e0Y4lFd9PVw
 tlTcMdpACsYiBjYhxarsPpIunMzh8TtTZV55g3Z9puOLmwLbYOyt1KMZm2nxP49VpzBGS17/6v3
 zQIe+Y9bR02m+kCpClldiALXjBVxwh4XE101UjnaZF0xegdIFPKJifbrnwNoGGTM8n/60NTl6i+
 4tgIx7WTntoIHkLBm3paJ3WEAUwWxjIn28ouF21anIGwJIXy6yAD816yB7QG2gvNc7
X-Received: by 2002:a05:6a00:3d16:b0:823:9e5:855e with SMTP id
 d2e1a72fcca58-8273ba1d7cbmr73184b3a.0.1772056703193; 
 Wed, 25 Feb 2026 13:58:23 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739db3ab8sm229151b3a.27.2026.02.25.13.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 13:58:22 -0800 (PST)
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
Subject: [PATCH for 6.12 and 6.6 1/2] drm/amd/display: Add pixel_clock to
 amd_pp_display_configuration
Date: Wed, 25 Feb 2026 13:58:03 -0800
Message-ID: <20260225215804.11398-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
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

