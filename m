Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204C1C88E6D
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 08:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 967B510E3C9;
	Mon, 26 Jan 2026 08:09:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LWZS2rBg";
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2264D10E378
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 18:39:40 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b8862767cf2so34951166b.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 10:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769366379; x=1769971179; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ecPuaGgfpB06f+q+wYbBx7hNGw3dVlBz9Vc5r6vMzJA=;
 b=LWZS2rBgSGjRIk0F6u/ESybPtyJnADL6iJCS5fuin0Ezyq20XlHO0LS2DBcy6sWwWS
 rYxhbqPE7g+PYRf0NUI4h5NFSvI8J3HL7iJQ8KvKkEmC5zUNBrs6acz39iKQjLLKUBuk
 DZR3vc+bcfd94cQZPI+z+CBxk05BN/Y3A3OEsg3vlP9RL5RB8mbq/EBYsDX1DrP9ECIi
 fMjm6NKRnSYhzFpmMZilZ6IxI7mwAMONjIoe7jXWQHeUEPkvY3gaMvNElDSzhC4mrWLF
 lasK8I128S1BDWfymEFn2ltMM4S2j2PPTgv25cotQRpemJqiatKUcn1K+4GeslFjsPtR
 Nn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769366379; x=1769971179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ecPuaGgfpB06f+q+wYbBx7hNGw3dVlBz9Vc5r6vMzJA=;
 b=S/PU4xYT81gBYxFaC4qhKCafIyICT7yJWLwpo3H/uPonUJmci5XGJKm/emWkUsZpeY
 5Rh7ZAuIT8MEYq92sqcF3U1XwPLpmfonlxublfaAaOTfDgy0JmJkKWiFDkl0kt4Nj6X+
 YE/Lprlqm5HHveHBeH2C1xTl0FttMciQ/iIo+Xc1a0kgKrvkgdVTK3iz73LdKOfiFHPw
 BbpKEg3yPoR7w+LNBwGiSpOcpvk+FvRlNmu886UWrmUevAW+9BcD8OPfqCDg8gAmuAyQ
 +5dFC+C5u33YGmaAllZjOO1tIkgJZJgWyCqoSnhlUwPWrpIWdZx8phW0RKGvYZ+PZPJJ
 46RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnT999otnAPtCvXkGSNqJlmbtbYv0KAVAOVo4kguC15MvuV+o4ij68evzJnitXTReF51AZ9f0x@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxUDkJdnqycUub5ELsgOc6XdvbnaFAwp+jcn+7opAitHgz5OBIu
 6hKV/Hfc0o5+ZG3WIqxKuv8CEkN4zyeGN3ZU/HTVu7VXNvqyqqaasqIM
X-Gm-Gg: AZuq6aKyycFndYJ8AJkcnsaayPSbFD3BrgeLIfK0U6xmBr4o1z43RIsGN3CbvI5SOSf
 EP6TbKaSXkQGGMonK//lMijY67kgHh2Vz6Ti9akGiK6bQHgNY9Y7wyn4SMZJejZW1LS522LQ39c
 95jSw9iEeHagKr1/5sYoJWAyufJJT0U20tkSi5o9sAO7IC53oWZMx7QmMCfR3674zwRUGr2c1L7
 vAOkcWqQUwMSyOXuvw2bJkxxjvhLPW5czKiy7p8/OCzVa8aESF0LaAtsbYO6CAYi9JvstvpfXKB
 4nrriwHXu13tvjuImlEIJ2pnkSmD9ck/eR6KCun5DK5IapzYfSGCgvVoVb6dvyj0Ld2zPN2haIR
 KKPvHw1XE3b90UmxS+vZexyKkUUdN9mCXnWjVhJKCFib8lyLuF4JmWUpbuZt6JVJxm8mPqptL40
 isjdowLgVbu4xUINJD9X63lsrH2Y+eQHvauH8bhGTrEBpkZonyk1/ZzXrsfwWBhR5P
X-Received: by 2002:a17:907:c28:b0:b87:106c:88eb with SMTP id
 a640c23a62f3a-b8d20d64cdcmr80438666b.0.1769366378380; 
 Sun, 25 Jan 2026 10:39:38 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b885b3dad3asm499133766b.12.2026.01.25.10.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 10:39:38 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v2 16/19] drm/amd/display: Add parameter to control ALLM
 behavior
Date: Sun, 25 Jan 2026 19:39:11 +0100
Message-ID: <20260125183914.459228-17-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260125183914.459228-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260125183914.459228-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Jan 2026 08:09:08 +0000
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
Since there isn't yet an API to control this, expose module paramter

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 14 ++++++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  7 +---
 .../amd/display/modules/inc/mod_info_packet.h |  1 +
 .../display/modules/info_packet/info_packet.c | 42 +++++++++++++++----
 5 files changed, 52 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9c11535c44c6..c9eab44ad5b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -268,6 +268,7 @@ extern int amdgpu_rebar;
 
 extern int amdgpu_wbrf;
 extern int amdgpu_user_queue;
+extern int amdgpu_allm_mode;
 
 extern uint amdgpu_hdmi_hpd_debounce_delay_ms;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 771c89c84608..3bdbb46e4d69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -248,6 +248,7 @@ int amdgpu_umsch_mm_fwlog;
 int amdgpu_rebar = -1; /* auto */
 int amdgpu_user_queue = -1;
 uint amdgpu_hdmi_hpd_debounce_delay_ms;
+int amdgpu_allm_mode = 1;
 
 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
@@ -1124,7 +1125,7 @@ module_param_named(rebar, amdgpu_rebar, int, 0444);
 MODULE_PARM_DESC(user_queue, "Enable user queues (-1 = auto (default), 0 = disable, 1 = enable, 2 = enable UQs and disable KQs)");
 module_param_named(user_queue, amdgpu_user_queue, int, 0444);
 
-/*
+/** */
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
+ * -  0 = ALLM disabled
+ * -  1 = ALLM dynamically triggered based on VRR state / Game Content Type Hint
+ * -  2 = ALLM forced always on
+ */
+MODULE_PARM_DESC(allm_mode, "Changes ALLM trigger mode (0 = disable, 1 = enable (default), 2 = force enable)");
+module_param_named(allm_mode, amdgpu_allm_mode, int, 0644);
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
index 0db2db7a197f..7516ab9a7554 100644
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
@@ -499,9 +506,30 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 	}
 }
 
-static bool is_hdmi_vic_mode(const struct dc_stream_state *stream)
+static bool is_hdmi_allm_mode(const struct dc_stream_state *stream)
 {
-	bool allm = stream->link->local_sink->edid_caps.allm;
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
+{
+	bool allm = is_hdmi_allm_mode(stream);
 	bool stereo = stream->view_format != VIEW_3D_FORMAT_NONE;
 
 	if (stream->timing.hdmi_vic == 0)
@@ -540,7 +568,7 @@ void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
 
 		info_packet->valid = false;
 
-		allm = stream->link->local_sink->edid_caps.allm;
+		allm = is_hdmi_allm_mode(stream);
 		format = stream->view_format == VIEW_3D_FORMAT_NONE ?
 			 TIMING_3D_FORMAT_NONE :
 			 stream->timing.timing_3d_format;
-- 
2.52.0

