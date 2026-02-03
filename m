Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3B5E83EEE
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 08:10:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBD8210E50E;
	Wed,  4 Feb 2026 08:10:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UNAyfSXM";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85AA910E764
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 18:56:54 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-b8dd0168b90so64200466b.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Feb 2026 10:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770145013; x=1770749813; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r2h2wnsXtZ4g2BRwKy8/RzhvGTG6VzYgHk4FML1+grU=;
 b=UNAyfSXMHg78tm2q8xnGkWrqabfVvIkC4oUh8auxWwrXQSZCQLH7udgV+m5DL/4MbN
 +sC2i3Y7H7/tozm1jJF52ihvEqMFGyXr3C9dg8khAt7g2e9U26ssnRgX8T+R9lajU+HO
 PMI9YxpnVeoHuXJN2q5bGM+i8+oOTomF+/kIzXs0fyaJdvNPao5T57pw9b+YEzxXoA2c
 n0HiHLKS65cVWou6xD3+n0sJpKyNiDLYzspMr6/ECZ5oJpWBR4B7bbNO7MDCQwlQSkDJ
 rHQKiS8N2gaOopZCi+oJZ0yvBvaY13o4GcnXaC1idzwWFasKpD0C3CtgoVvboH4rUjxV
 RDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770145013; x=1770749813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r2h2wnsXtZ4g2BRwKy8/RzhvGTG6VzYgHk4FML1+grU=;
 b=swsRsZVukeo9ZsGAW9qEGSavnhkpJ8TO2oWAWHohxnFpgiBAEvTpiG6d84xgY+s10M
 hsEtimd5XUtyEXMK+qu2VqQcXNRnEuU6frfkUuTnZzP7MsYBI1BS94n5kstYP5GiHVyo
 KQAwr1ZAsySs6fThnJIPP7oVAemLbhs5o5gxEFvOinhogc5DBKCpuH6oQ1K3ENKuLy2+
 rTQ7FXHX3RVUbI7AOvfCqVtRff88Y9+O6armBIXsgPEQDCmZoIhgoQxxya6bBMOJ9Wuu
 tHtOwxuvAEiv4XxsmIy04mLBqdKlXpKfH6X20sxpzg78fjJWeD5YUkMnKbXEEqx/IkQ7
 SlcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfJxXQXVikn3i1t390SgMtFQclJXKfgv/3GOU+xe86fN5yVIjPKrtM2WdGGDVIDBsLaN+JfRHm@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzjzMxgxhsGvOLm4kOBKmdpPnBnH3rXgECnXHyMvimCBNd9f0r1
 O4KySuWzyddwaHvfSjJmkoVMZDcV0KqSjuMOf2uAmoQHu2RSdlf5jgjj
X-Gm-Gg: AZuq6aI6yMuDCeL4JdX1nk+h4PucXEKyK3R+LIZhv3tE3zM9w1eMIjT+4JzPfkeKiJz
 K1JjWZAelz+x/bKo1opY2rqtbOgd3J9vt8zhMcyRUNYXf3LB+uuMDMAHfzeR3ivxPsDuSz1TfL6
 bYkbg88EAclcAs0L6hZ5cmiVlmHvqD1G9mpBwHtsmw+PASiz9BIxwotDfKk8Csk/weYb3ueZkK1
 l42hqyl5nRc6rIq4SvD9LYa1zwqqTv/unWtBtli3Mvnaarq5ujYaQ7n64QrkyJaX4X2XkUvzsCZ
 e/EGpVzzGk5u+ThYdrgQtnQsdPAkR6xiYtXEb+ikzdJxrG2ABvJuzBwW+Yic+/mph4WyeSaxHWm
 MbG7hHWB1DiM0S6hGr/XKxUtG0ieV+FjFvKPMxb5vLb4707JrHv3RdKGR7mNqCKD5fj+LzRmOuK
 oD3SkiP3XMMl/Beb9mZEIvhMpFDzqESO9pJ7jqlYkK3DtVSvD72f8keI/MOGr5P01s
X-Received: by 2002:a17:907:3e0a:b0:b87:2780:1b2b with SMTP id
 a640c23a62f3a-b8e9f2f270bmr21095366b.4.1770145012928; 
 Tue, 03 Feb 2026 10:56:52 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8e9fad97a7sm16715766b.0.2026.02.03.10.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 10:56:52 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org,
 daniel@fooishbar.org, admin@ptr1337.dev
Subject: [PATCH v3 16/19] drm/amd/display: Add parameter to control ALLM
 behavior
Date: Tue,  3 Feb 2026 19:56:23 +0100
Message-ID: <20260203185626.55428-17-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203185626.55428-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260203185626.55428-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Feb 2026 08:10:21 +0000
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

[Why]
Some users prefer to always manually control ALLM/Gaming mode while
others might want it permanently forced on.

[How]
Since there isn't yet an API to control this, expose module parameter

Changes in v3:
- Include a fix for possible NULL pointer dereference by Peter

Closes: https://github.com/CachyOS/linux-cachyos/issues/680

Co-developed-by: Peter Jung <admin@ptr1337.dev>
Signed-off-by: Peter Jung <admin@ptr1337.dev>
Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 14 +++++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  7 +--
 .../amd/display/modules/inc/mod_info_packet.h |  1 +
 .../display/modules/info_packet/info_packet.c | 46 ++++++++++++++++---
 5 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 447e734c362b..312aa32064d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -268,6 +268,7 @@ extern int amdgpu_rebar;
 
 extern int amdgpu_wbrf;
 extern int amdgpu_user_queue;
+extern uint amdgpu_allm_mode;
 
 extern uint amdgpu_hdmi_hpd_debounce_delay_ms;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index d6d0a6e34c6b..4b038c8bbf9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -248,6 +248,7 @@ int amdgpu_umsch_mm_fwlog;
 int amdgpu_rebar = -1; /* auto */
 int amdgpu_user_queue = -1;
 uint amdgpu_hdmi_hpd_debounce_delay_ms;
+uint amdgpu_allm_mode = 1;
 
 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
@@ -1124,7 +1125,7 @@ module_param_named(rebar, amdgpu_rebar, int, 0444);
 MODULE_PARM_DESC(user_queue, "Enable user queues (-1 = auto (default), 0 = disable, 1 = enable, 2 = enable UQs and disable KQs)");
 module_param_named(user_queue, amdgpu_user_queue, int, 0444);
 
-/*
+/**
  * DOC: hdmi_hpd_debounce_delay_ms (uint)
  * HDMI HPD disconnect debounce delay in milliseconds.
  *
@@ -1134,6 +1135,17 @@ module_param_named(user_queue, amdgpu_user_queue, int, 0444);
 MODULE_PARM_DESC(hdmi_hpd_debounce_delay_ms, "HDMI HPD disconnect debounce delay in milliseconds (0 to disable (by default), 1500 is common)");
 module_param_named(hdmi_hpd_debounce_delay_ms, amdgpu_hdmi_hpd_debounce_delay_ms, uint, 0644);
 
+/**
+ * DOC: allm_mode (int)
+ * Changes ALLM triggering mode (if sink supports ALLM). Possible values:
+ *
+ * - 0 = ALLM disabled
+ * - 1 = ALLM dynamically triggered based on VRR state / Game Content Type Hint
+ * - 2 = ALLM forced always on
+ */
+MODULE_PARM_DESC(allm_mode, "Changes ALLM trigger mode (0 = disable, 1 = enable (default), 2 = force enable)");
+module_param_named(allm_mode, amdgpu_allm_mode, uint, 0644);
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 4a7c9f810e35..b779aac28dfa 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -44,6 +44,7 @@
 #include "clk_mgr.h"
 #include "dc_state_priv.h"
 #include "dc_stream_priv.h"
+#include "modules/inc/mod_info_packet.h"
 
 #include "virtual/virtual_link_hwss.h"
 #include "link/hwss/link_hwss_dio.h"
@@ -4503,8 +4504,6 @@ static void set_avi_info_frame(
 	unsigned int vic = pipe_ctx->stream->timing.vic;
 	unsigned int rid = pipe_ctx->stream->timing.rid;
 	unsigned int fr_ind = pipe_ctx->stream->timing.fr_index;
-	enum dc_timing_3d_format format;
-	bool allm;
 
 	if (stream->avi_infopacket.valid) {
 		*info_packet = stream->avi_infopacket;
@@ -4658,10 +4657,8 @@ static void set_avi_info_frame(
 	///VIC
 	if (pipe_ctx->stream->timing.hdmi_vic != 0)
 		vic = 0;
-	format = stream->timing.timing_3d_format;
-	allm = stream->link->local_sink->edid_caps.allm;
 	/*todo, add 3DStereo support*/
-	if ((format != TIMING_3D_FORMAT_NONE) || allm) {
+	if (!is_hdmi_vic_mode(pipe_ctx->stream)) {
 		// Based on HDMI specs hdmi vic needs to be converted to cea vic when 3D is enabled
 		switch (pipe_ctx->stream->timing.hdmi_vic) {
 		case 1:
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
index 306eb7355c25..9ec123ecc7c4 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
@@ -41,6 +41,7 @@ void set_vsc_packet_colorimetry_data(
 		enum dc_color_space cs,
 		enum color_transfer_func tf);
 
+bool is_hdmi_vic_mode(const struct dc_stream_state *stream);
 void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 		struct dc_info_packet *info_packet,
 		enum dc_color_space cs,
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 53e488fdb4ea..829cce9455db 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -23,12 +23,13 @@
  *
  */
 
-#include "mod_info_packet.h"
+#include "amdgpu.h"
 #include "core_types.h"
-#include "dc_types.h"
-#include "mod_shared.h"
-#include "mod_freesync.h"
 #include "dc.h"
+#include "dc_types.h"
+#include "mod_freesync.h"
+#include "mod_info_packet.h"
+#include "mod_shared.h"
 
 enum vsc_packet_revision {
 	vsc_packet_undefined = 0,
@@ -54,6 +55,12 @@ enum vsc_packet_revision {
 #define HF_VSIF_3D_BIT   0
 #define HF_VSIF_ALLM_BIT 1
 
+enum allm_trigger_mode {
+	ALLM_MODE_DISABLED        = 0,
+	ALLM_MODE_ENABLED_DYNAMIC = 1,
+	ALLM_MODE_ENABLED_FORCED  = 2,
+};
+
 // VTEM Byte Offset
 #define VTEM_PB0		0
 #define VTEM_PB1		1
@@ -499,7 +506,32 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 	}
 }
 
-static bool is_hdmi_vic_mode(const struct dc_stream_state *stream)
+static bool is_hdmi_allm_mode(const struct dc_stream_state *stream)
+{
+	/* No local sink */
+	if (!stream->link->local_sink)
+		return false;
+
+	/* Sink doesn't expose ALLM support in edid */
+	if (!stream->link->local_sink->edid_caps.allm)
+		return false;
+
+	switch (amdgpu_allm_mode) {
+	case ALLM_MODE_DISABLED:
+		return false;
+
+	case ALLM_MODE_ENABLED_DYNAMIC:
+		break;
+
+	case ALLM_MODE_ENABLED_FORCED:
+		return true;
+	}
+
+	return stream->content_type == DISPLAY_CONTENT_TYPE_GAME ||
+	       stream->vrr_active_variable;
+}
+
+bool is_hdmi_vic_mode(const struct dc_stream_state *stream)
 {
 	if (stream->timing.hdmi_vic == 0)
 		return false;
@@ -512,7 +544,7 @@ static bool is_hdmi_vic_mode(const struct dc_stream_state *stream)
 	if (stream->view_format != VIEW_3D_FORMAT_NONE)
 		return false;
 
-	if (stream->link->local_sink->edid_caps.allm)
+	if (is_hdmi_allm_mode(stream))
 		return false;
 
 	return true;
@@ -541,7 +573,7 @@ void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
 
 		info_packet->valid = false;
 
-		allm = stream->link->local_sink->edid_caps.allm;
+		allm = is_hdmi_allm_mode(stream);
 		format = stream->view_format == VIEW_3D_FORMAT_NONE ?
 			 TIMING_3D_FORMAT_NONE :
 			 stream->timing.timing_3d_format;
-- 
2.52.0

