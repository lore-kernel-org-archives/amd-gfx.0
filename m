Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0207CCA0FED
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 14:18:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DC5610E24F;
	Tue,  9 Sep 2025 14:18:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="llBfW3/l";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E246010E24F
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 14:18:05 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-24b13313b1bso41471885ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Sep 2025 07:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757427485; x=1758032285; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eV8sA9gjNwtC5UpzAuvPrc+4g3QtpY4PBd24Y0CRxi0=;
 b=llBfW3/lRYr+bphEJAluh0HmIffPfH6LVTneS9y1xjS/86nD5GMMr2JxUZkQ2ewGGU
 I1AS+DinRSbpje3jcgG5kAICr7zbkj0xXS5BWlC6aDbxAK12kvHbsLXBF489UU2qSH9I
 5iA2vVIEGSklGxzpxC6qmTmeXbTBy8xOh4UyXn35402woQbjAjVjRzWs8kvQ6aN769qo
 uDiLqqhqyLolHXYqFnw4DQm8qSCSiebH/2TFadMEEvAYczkL32AUdxYNgvEAXB69IC3u
 nk2Pit38pT2EMye5PBbcz+rxNKmKiq6JZV198xF8HypLq1XdoeK9U8IMt2kFJL2Af6K2
 QZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757427485; x=1758032285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eV8sA9gjNwtC5UpzAuvPrc+4g3QtpY4PBd24Y0CRxi0=;
 b=rtFHH4w17/Q8fNUBZxvAJ7Pz3m56qvyjkq3FfJVbQABlhKmg2YNyn1i2EMWsPgnyZo
 aINpfV9iKj+XFgWU0shPJIfSNhtz6Ft96HFoHrdp1jl/l/0fJxb3c+EBhXc41FRQnkJh
 +0gboX4B9NnKnsEmUh36HREt4wJaFZN0ZkjxOA7qtpEu9rOL1HoE5mt82eA5UOLQJj8O
 20alpwu8AG5GJB2hW+LmYanKgkTjmOt7LEFTGwDop8xTrfz2pVYV4pPjCSXXDEUF72Nw
 By4+XX7+t1m0upYAJCZwDZjaNJ2BA61kFeXq6BIZfhg46y14hav8UaSQzl29vAf8eZyY
 Zyyw==
X-Gm-Message-State: AOJu0YyWAaEGhLYJfm6ojP1yQembldi8z5oyGbXq7l9S3lZ28DkS5RRw
 H/DQwG2RVjfBaA+GeFuFzcMi/rn8qmAke38O3vZOvm4w8Kw0xayAwgFkkfZ6nQ==
X-Gm-Gg: ASbGncvjBg1Qswn0kepBTtjT5pLJPv4eYjoPKE2kOjOK9RzfyPh24YJqeevZnJMoW8Y
 EYyfeLB8WCQuNNDxtuO4PNlRfpR0f6pa6A2Pt/436RWH5s8RMitU96M/aKSt7R+hEVs7/bUHnZZ
 CQr5AgB+pSHebQC4Le2xl1aYPhihfOdBJKDXb9TAeMbVmQnbTmoofN40y8IkFCpgdIz/Mclvzl+
 OvQ7KK/6oZhlXee9yRTdsr+W1JZE3wRcfwrORwHCJE3ksrklTPSaqwGvVHQigCqPCsOtsedNYKK
 VWgpoeSex5G3DOtuV8vU+326hlyKYBMA8q+ehTzjjM5TaRSaWY5TqIUY2P3Hw7V7PHI9V1qy5xq
 M6nthAyMfm5BFwjrp/prCqYe+9LHfCmZPfV/6+XqRT3CnK3Jf8uGynk75x61fPETbijD90ktRqi
 lyI0pknG595VWHL1sHgp/r+rWM1t4=
X-Google-Smtp-Source: AGHT+IFR9+fNdnPFqaucTOyzai1Wz2YmjSe0CKgtBa7IKMn+oonELLilPdW7hFeuGUOpYPRK2PWWRQ==
X-Received: by 2002:a17:903:350c:b0:246:648f:80a3 with SMTP id
 d9443c01a7336-251751e9e3cmr139351985ad.50.1757427485294; 
 Tue, 09 Sep 2025 07:18:05 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24D7A10085C74347BA908E23.dsl.pool.telekom.hu.
 [2001:4c4e:24d7:a100:85c7:4347:ba90:8e23])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24b1ba1718bsm196057255ad.39.2025.09.09.07.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 07:18:05 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/3] drm/amd/display: Add pixel_clock to
 amd_pp_display_configuration
Date: Tue,  9 Sep 2025 16:17:50 +0200
Message-ID: <20250909141752.9517-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909141752.9517-1-timur.kristof@gmail.com>
References: <20250909141752.9517-1-timur.kristof@gmail.com>
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
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c       | 1 +
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dm_services_types.h             | 2 +-
 drivers/gpu/drm/amd/include/dm_pp_interface.h                  | 1 +
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index e5771f490f2e..11b2ea6edf95 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -98,6 +98,7 @@ bool dm_pp_apply_display_requirements(
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
index bf63da266a18..3b093b8699ab 100644
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
2.51.0

