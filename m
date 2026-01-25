Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A908BC88E6B
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 08:09:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4314710E3C5;
	Mon, 26 Jan 2026 08:09:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Up4456Vq";
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA2A910E376
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 18:39:43 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-64b6f896689so546373a12.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 10:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769366382; x=1769971182; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pzpJ4RJ7cNME7CVFy7TynUsF3JEY3Q9X0Du26C0ArzQ=;
 b=Up4456Vq/+Fvb2dYeEnivJYQIFTCxZhVPSlgMkcxH5ed3g1aVk9lFBZ5Q+1U/+8A4v
 Vaha3iUUn/4qI8H4YURBAn71kyuCt2Vlu4NGJipt0CwA6SdFLucD6fx9epmsZIjFeDuO
 JzmXcJ1Ucv0dXLWhk/csXJTiBNgGYnKPKchQUPfYPtuGsIEEuWC+fVyi5gRZmN2+1cnw
 sKvOcJmkYAH+2w+KzoaNKqf0pY/lxGgG+7FeDUwYXj04++NAL14uSKuZg3NS1iOntyoJ
 YAV6O0+Y7xq3p0Jp1zrjCfAfe6uDX3QxGysleSYdBYCh8MNUSlDS6/nESLgaMgjvdo+x
 JZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769366382; x=1769971182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pzpJ4RJ7cNME7CVFy7TynUsF3JEY3Q9X0Du26C0ArzQ=;
 b=EyoAAwKhGgTzcUtWo+b+rntFXY5305bFfHvOty3C+ZYYAMtN7jwpONpWo6q0dvap42
 GGPCcj4jI4o6yDB9K+X44lHWqv8rfPRUBOcph70e6EH0pYBjciI62p+lpqmvmF+zKmk0
 xfMzmSoGBsA7wk7iAWRmZTLyXejHdhg/01S48TCx33zLobX+rrVyQKfXCL/0QIhPo/NA
 OslWOlsLp8EDp8hIOlXTSfcPpkWpxlzbg5ysnUa4Y59NmkOwIa/5wSH5iB5VogeSEH59
 x6Lu+Hl63I5hXMpuEH3kSv7cA8guyZrrv96B6xgXjCUSkOazJWRP5pnVjPgBDiIXfo1x
 HgkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV51VJmhrzr9uwIuaqs//nyhOyVdQX3s1F1AJyfmV2gjFDiiOI6IxBrf5AJC3IGFwwJ08g3wFaX@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw99KC4FR7QhneVUxO3HMnCs1Fe+bFbnbMkDh1z8PSwB+GQy2n4
 dV7KiqfNRD04+FQKDEougumFdP20k12bOJAv+gDWiKg0go8iDxH8LOJp
X-Gm-Gg: AZuq6aJUUtGS9AHxs931qaDEnpV0soUXgWtcAincFgRUB99iZKt8/JyZ397klFEUWkg
 irPxc/2YI+TECV5aQzJ+fa/6r41TMpAG5gfW2rV6qJE5n8WKtyO23NyzLEtFKuE88ML9kZ/WXu0
 aPQWqz/wKUu8nX6BLaaZiXZH1CjXNIBE6ev4MAMjXQbo0v5QJzQSLSQ25JyaXwRq8Tu1QsdxSia
 e1pZgwd42TIwUDMviTsXn3jynOs2WDZwMNsPI+74ORFJFsFnrRVw/uoGR1nOvqJhW78TxlmVdaW
 Yzq/fnNh8crZiNCDtVlYk1WetapzJNQtwPRptmFun7dsp2rMpnEqnxf7eF6YFCqGIixq4/Yjek7
 1iFixwk6DhlNWDSir1+v7q/0GHDLtcN3lRx3Sho3k6OSNnn+sAzy/Hkq2c3bpAaeHDlGEhlzdMY
 eG6FwT9xQcLSgOZz+fO19SgdIDrylcNTKKnBQ78X1FuA2W0YnRHWB6TLV/mZjY0Kyr
X-Received: by 2002:a17:906:c104:b0:b87:3087:54f0 with SMTP id
 a640c23a62f3a-b8d3fa9d567mr110207266b.3.1769366382183; 
 Sun, 25 Jan 2026 10:39:42 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b885b3dad3asm499133766b.12.2026.01.25.10.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 10:39:41 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v2 19/19] drm/amd/display: Add HDMI VRR desktop mode
Date: Sun, 25 Jan 2026 19:39:14 +0100
Message-ID: <20260125183914.459228-20-tomasz.pakula.oficjalny@gmail.com>
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
Many TVs and other HDMI sinks suffer from blanking and possibly other
glitches when VRR is toggled. With FreeSync present on such sinks, they
behave like the signal is always variable, even in fixed refresh rate
situations.

[How]
Keep HDMI VRR toggled if it's supported and not explicitly disabled.
Additionnally, add module parameter which allows users to configure HDMI
VRR triggering to only happen when the signal is truly asking for
variable state. This is useful if end user has a TV that automatically
toggles ALLM/Game mode when VRR is active and such user doesn't want
gaming mode in normal desktop usage.

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                 |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c             | 13 +++++++++++++
 .../amd/display/modules/info_packet/info_packet.c   | 10 ++++++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c9eab44ad5b3..dddd8ed361a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -269,6 +269,7 @@ extern int amdgpu_rebar;
 extern int amdgpu_wbrf;
 extern int amdgpu_user_queue;
 extern int amdgpu_allm_mode;
+extern bool amdgpu_hdmi_vrr_desktop_mode;
 
 extern uint amdgpu_hdmi_hpd_debounce_delay_ms;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3bdbb46e4d69..f4551450bf31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -249,6 +249,7 @@ int amdgpu_rebar = -1; /* auto */
 int amdgpu_user_queue = -1;
 uint amdgpu_hdmi_hpd_debounce_delay_ms;
 int amdgpu_allm_mode = 1;
+bool amdgpu_hdmi_vrr_desktop_mode = true;
 
 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
@@ -1146,6 +1147,18 @@ module_param_named(hdmi_hpd_debounce_delay_ms, amdgpu_hdmi_hpd_debounce_delay_ms
 MODULE_PARM_DESC(allm_mode, "Changes ALLM trigger mode (0 = disable, 1 = enable (default), 2 = force enable)");
 module_param_named(allm_mode, amdgpu_allm_mode, int, 0644);
 
+/**
+ * DOC: hdmi_vrr_on_dekstop (bool)
+ * Enables FreeSync behavior mimicking by keeping HDMI VRR signalling active in
+ * fixed refresh rate conditions like normal desktop work/web browsing.
+ * Possible values:
+ *
+ * -  false = HDMI VRR is only enabled if refresh rate is truly variable
+ * -  true  = Mimics FreeSync behavior and keeps HDMI VRR always active
+ */
+MODULE_PARM_DESC(hdmi_vrr_desktop_mode, "Changes HDMI VRR desktop mode (false = disable, true = enable (default))");
+module_param_named(hdmi_vrr_desktop_mode, amdgpu_hdmi_vrr_desktop_mode, bool, 0644);
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 38056b2d37b2..c61bbf912a8b 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -651,8 +651,14 @@ static void build_vtem_infopacket_data(const struct dc_stream_state *stream,
 	bool rb = false;
 
 	hdmi_vic_mode = is_hdmi_vic_mode(stream);
-	vrr_active = vrr->state == VRR_STATE_ACTIVE_VARIABLE ||
-		     vrr->state == VRR_STATE_ACTIVE_FIXED;
+
+	if (amdgpu_hdmi_vrr_desktop_mode) {
+		vrr_active = vrr->state != VRR_STATE_UNSUPPORTED &&
+			     vrr->state != VRR_STATE_DISABLED;
+	} else {
+		vrr_active = vrr->state == VRR_STATE_ACTIVE_VARIABLE ||
+			     vrr->state == VRR_STATE_ACTIVE_FIXED;
+	}
 
 	infopacket->sb[VTEM_MD0] = VTEM_M_CONST << VTEM_M_CONST_BIT;
 	infopacket->sb[VTEM_MD0] |= VTEM_FVA_FACTOR << VTEM_FVA_BIT;
-- 
2.52.0

