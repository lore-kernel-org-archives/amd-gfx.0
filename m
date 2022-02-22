Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509ECC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 14:06:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF54210E83E;
	Tue, 22 Feb 2022 14:06:58 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D586810E646
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 13:18:45 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 j9-20020a9d7d89000000b005ad5525ba09so7291113otn.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 05:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=usp.br; s=usp-google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m7m0+PF7saTzmzCja9hykhB/MRHQ+aIAgZTpGlXhHzw=;
 b=ubi5Nm/hc13TZrLP09ZiZRLp3a2ho4dHP2ehi7CFHPZ2s6iZ0e3mlYsRva1Lo79rof
 meuN9eLCrtEoUc2bmNz8XfqhPigO2am6hz09EKWPa5tYM4mkQjkHmB4qmkgP6wysKRSp
 MYcDxon4lPSJgg20sSlxVY/SDgzPwLvjUDgt3YmbkhU8/u3rhab/RurOUlKHmgC50WKg
 FVi5Zyc72Oxho4L2Rqgl1V2Q8nWaSRqR7Yqu9aZdVQcu8hvak1SgPfdx1yxVpsGKtzJM
 UXec4VOo7nf+J0oBnWsFRjoIEKP2D37OAkq6NiDruGUON4PMb3jdr1chSd9Z5zSf6E0k
 u7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m7m0+PF7saTzmzCja9hykhB/MRHQ+aIAgZTpGlXhHzw=;
 b=3tE9YCFc532sDKWDnZqfrqLXBPhj++/znVfelJfB+if38OFhaFOJf5egPK7ZIU+qZX
 4Z3aAeP3Ovo2G8b7+oIUdf7ggK+YeMB1jcwPGAWp69Iyad/I9Aa3IpVKcwJzFtTjR2ad
 /I0ZvSUEM306KF7qHj5oyINoRmKBuoWDsyqDuR6Mls8G8ocbMGlA3MPsrOZwcifF4Vc4
 kNeJt7iDd35iINXqvSWDvn2eniMI7+zECPJBLHILVdioe5zpvbE+IEsEjLvO+q6LGtjS
 qHL8mW4H9mU/ICf9PhpLGn7ZuMhLR8+xVEXhKz6bLp9lEJQqD0y2UIDq0viTycfUFcLu
 1PZw==
X-Gm-Message-State: AOAM533oDpgBjDQ7LFRI2kbkZGRI3lJTEF9X0+RVfse1mxAjhvfJj9hk
 5gLGfgJ/yf91jB4JHi9rTn2B5Q==
X-Google-Smtp-Source: ABdhPJwXb2Ih6ABCM4wFKq+J7EONDr5AujGDHaz2bmBm8K1zfSsUX01jAP2smZyZy7rVzqADpM/0Dg==
X-Received: by 2002:a05:6830:40c6:b0:5a0:4cee:1e7d with SMTP id
 h6-20020a05683040c600b005a04cee1e7dmr8308902otu.121.1645535925058; 
 Tue, 22 Feb 2022 05:18:45 -0800 (PST)
Received: from fedora.. ([187.36.236.204])
 by smtp.gmail.com with ESMTPSA id c9sm6325050otd.26.2022.02.22.05.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Feb 2022 05:18:44 -0800 (PST)
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 Hawking.Zhang@amd.com, john.clements@amd.com, tao.zhou1@amd.com,
 YiPeng.Chai@amd.com, luben.tuikov@amd.com, Stanley.Yang@amd.com,
 Dennis.Li@amd.com, mukul.joshi@amd.com, harry.wentland@amd.com,
 sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, Anthony.Koo@amd.com
Subject: [PATCH 10/10] drm/amd/display: Turn global functions into static
 functions
Date: Tue, 22 Feb 2022 10:17:01 -0300
Message-Id: <20220222131701.356117-11-maira.canal@usp.br>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222131701.356117-1-maira.canal@usp.br>
References: <20220222131701.356117-1-maira.canal@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 22 Feb 2022 14:06:42 +0000
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
Cc: magalilemes00@gmail.com,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, mwen@igalia.com,
 amd-gfx@lists.freedesktop.org, isabbasso@riseup.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Turn previously global functions into static functions to avoid
-Wmissing-prototype warnings, such as:

drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn30/irq_service_dcn30.c:50:20:
warning: no previous prototype for function 'to_dal_irq_source_dcn30'
[-Wmissing-prototypes]
enum dc_irq_source to_dal_irq_source_dcn30(
                   ^
drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn30/irq_service_dcn30.c:50:1:
note: declare 'static' if the function is not intended to be used outside
of this translation unit
enum dc_irq_source to_dal_irq_source_dcn30(
^
static
1 warning generated.

drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c:488:6:
warning: no previous prototype for function
'dcn316_clk_mgr_helper_populate_bw_params' [-Wmissing-prototypes]
void dcn316_clk_mgr_helper_populate_bw_params(
     ^
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c:488:1:
note: declare 'static' if the function is not intended to be used outside
of this translation unit
void dcn316_clk_mgr_helper_populate_bw_params(
^
static
1 warning generated.

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c             | 4 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c   | 2 +-
 .../drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c  | 3 ++-
 .../gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c    | 2 +-
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c    | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c             | 2 +-
 drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c  | 2 +-
 drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c  | 2 +-
 8 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c9ca328d34e3..a99b92526b55 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6362,7 +6362,7 @@ static bool is_freesync_video_mode(const struct drm_display_mode *mode,
 		return true;
 }
 
-struct dc_stream_state *
+static struct dc_stream_state *
 create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 		       const struct drm_display_mode *drm_mode,
 		       const struct dm_connector_state *dm_state,
@@ -10189,7 +10189,7 @@ static void set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state) {
 	dm_new_crtc_state->freesync_config.fixed_refresh_in_uhz = res;
 }
 
-int dm_update_crtc_state(struct amdgpu_display_manager *dm,
+static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 			 struct drm_atomic_state *state,
 			 struct drm_crtc *crtc,
 			 struct drm_crtc_state *old_crtc_state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 389b0cb37995..05573f073b21 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -213,7 +213,7 @@ static bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnecto
 	return true;
 }
 
-bool retrieve_downstream_port_device(struct amdgpu_dm_connector *aconnector)
+static bool retrieve_downstream_port_device(struct amdgpu_dm_connector *aconnector)
 {
 	union dp_downstream_port_present ds_port_present;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
index 06bab24d8e27..450eaead4f20 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
@@ -101,7 +101,8 @@ static uint32_t rv1_smu_wait_for_response(struct clk_mgr_internal *clk_mgr, unsi
 	return res_val;
 }
 
-int rv1_vbios_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr, unsigned int msg_id, unsigned int param)
+static int rv1_vbios_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
+		unsigned int msg_id, unsigned int param)
 {
 	uint32_t result;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index ffd3d5cb9871..02a59adff90d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -485,7 +485,7 @@ static unsigned int find_clk_for_voltage(
 	return clock;
 }
 
-void dcn316_clk_mgr_helper_populate_bw_params(
+static void dcn316_clk_mgr_helper_populate_bw_params(
 		struct clk_mgr_internal *clk_mgr,
 		struct integrated_info *bios_info,
 		const DpmClocks_316_t *clock_table)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
index fd6497fd2dc5..128614dff108 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
@@ -111,7 +111,7 @@ static uint32_t dcn316_smu_wait_for_response(struct clk_mgr_internal *clk_mgr, u
 	return res_val;
 }
 
-int dcn316_smu_send_msg_with_param(
+static int dcn316_smu_send_msg_with_param(
 		struct clk_mgr_internal *clk_mgr,
 		unsigned int msg_id, unsigned int param)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 19b56f9acf84..29ab67f42d92 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1622,7 +1622,7 @@ bool dc_add_all_planes_for_stream(
 	return add_all_planes_for_stream(dc, stream, &set, 1, context);
 }
 
-bool is_timing_changed(struct dc_stream_state *cur_stream,
+static bool is_timing_changed(struct dc_stream_state *cur_stream,
 		       struct dc_stream_state *new_stream)
 {
 	if (cur_stream == NULL)
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
index c4b067d01895..93c31111500b 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
@@ -40,7 +40,7 @@
 
 #include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
 
-enum dc_irq_source to_dal_irq_source_dcn20(
+static enum dc_irq_source to_dal_irq_source_dcn20(
 		struct irq_service *irq_service,
 		uint32_t src_id,
 		uint32_t ext_id)
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
index 0b68c08fac3f..ac0c6a62d17b 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
@@ -47,7 +47,7 @@
 
 #include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
 
-enum dc_irq_source to_dal_irq_source_dcn30(
+static enum dc_irq_source to_dal_irq_source_dcn30(
 		struct irq_service *irq_service,
 		uint32_t src_id,
 		uint32_t ext_id)
-- 
2.35.1

