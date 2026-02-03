Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82C2E83F00
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 08:10:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11D0610E516;
	Wed,  4 Feb 2026 08:10:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nVus1ujs";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FB1810E767
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 18:56:58 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-b8845a47e39so74862666b.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Feb 2026 10:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770145017; x=1770749817; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2gojVvtD4l2rkbiM/jdY+q69y3Uync3kYZ3kcuaObgo=;
 b=nVus1ujsjDMJ1w9929jQR6cbCdfFcaV4t9oXhxSSCrtEWn2Z8l/HnOR9EnZuyaGvYa
 GbqE4XQvcsg3qf6j40dPHbBXEzdRh+qYBmg5IgOldMiBTf96DWg5oTnE/cG78EMstNTN
 7DwkTOlTyj4/PedtrmHmp/p2l8HboawXEP9riFGi/VKlLEbzdGVnO0iVBJG6Q8Fg1ytc
 E7oe/O7Af1BhXI176PMt4UawX5TR2ItzoleIejcRH1kJM9ZLf7s6Dv8VXW507WHrgabw
 2HxzWB+P67d1XiWgBypjTEreSjHopAUuH8QChohVUnbApLMscqd25YZdqTswwOkgdEXu
 h8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770145017; x=1770749817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2gojVvtD4l2rkbiM/jdY+q69y3Uync3kYZ3kcuaObgo=;
 b=NnWlnzGygjTrcYiCEIgiVf0klMTBNw0CCb/AXY9owsIn+jszf04T3IYaoVlp82hs6e
 ziLaHkFhPWTQeUkN2rbX+tXohy+HB53pG8N+Aw2sHNPtRkjUgXXe95DGw63T72EH/KVJ
 a3PaEs/ukT6XHGySBp1CREE16Gg7zzztQBU8HIs881CXLVTFniGDDWOcc5eGRsb6SEHt
 5z9dCyh3z9u3SteUdBAgg4rua/vvHlQo/I3ZPPYLoL3wulb/uxFneYGpyBGYE+N9NBZj
 sUxu9XysFcPbMSjwMnFSSH0gJ389DJB+VqFuhbkur/wv8eOJFZb1w6xTqLGq1y1FlRiq
 OFKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7UIeVaHTKWmOyAeFap8oRyS9bDW2wYppbYes+KhNT8EOSqqEsaH1gibG0mcF8STJyW44MtH38@lists.freedesktop.org
X-Gm-Message-State: AOJu0YztrBCnfXlsh/f8g8kmvbTQ/Y8j1Yv2AtixUbqmfKJEPYklenA/
 SjdQJ2k3e0CsSCGYnCPuYLQEi7odtjH+VGTeBm/LEvcEtDd8SrA2b9w5
X-Gm-Gg: AZuq6aI3OlPQ1QM5hi+2LxpwoxJNPrR6O2m4azh7OcXbADLndmBvOBh0JX5OzRJgJ1e
 GFtE7UHkSkT5DwskSPPoHkTpfPPJGqA8PnudXL7U7+s3GAQ+WJ+YotTPLxbprfCNEMyzX8bCRCw
 sga2Y+VrRmjNE3XK7N1tEOyvs0EBwAlPOKDNRMNAcY2feNd4JhDC/7unNbpf4mIx4rsofDHvlsH
 RQLD9sInnBOgGgvfcS+LcxLq5kqQ6Kb0PDV+9s4CFA2ikvdkzrs8x1Xyh+koC8XVJqQN3q4ZEfm
 /Lmdf8BmiIGGfcvUW9DjiLiPxybQFAn2XQPEysqCgLMizQehUVCxyxHL3sSceRkgxZk6vqmvHvX
 YUeZ0zKx+AkYPsLo3eBjTdSgWnCatGaqsJ+S3EDDxZEIUCan7FVUxPPs/N+Vwzm+CM48NzFE2O4
 ScLd+kBW+ZMt1Rzt/VMFRvNi5ofvNvBH6kD3QH8PaSUgTBRTCc5aHcp5THJKhwIQTs
X-Received: by 2002:a17:907:1ca4:b0:b7f:fd9d:fff4 with SMTP id
 a640c23a62f3a-b8e9f173f18mr20497466b.1.1770145016990; 
 Tue, 03 Feb 2026 10:56:56 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8e9fad97a7sm16715766b.0.2026.02.03.10.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 10:56:56 -0800 (PST)
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
Subject: [PATCH v3 19/19] drm/amd/display: Add HDMI VRR desktop mode
Date: Tue,  3 Feb 2026 19:56:26 +0100
Message-ID: <20260203185626.55428-20-tomasz.pakula.oficjalny@gmail.com>
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
 .../amd/display/modules/info_packet/info_packet.c   |  9 +++++++--
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 312aa32064d5..d49cd55e0f35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -269,6 +269,7 @@ extern int amdgpu_rebar;
 extern int amdgpu_wbrf;
 extern int amdgpu_user_queue;
 extern uint amdgpu_allm_mode;
+extern bool amdgpu_hdmi_vrr_desktop_mode;
 
 extern uint amdgpu_hdmi_hpd_debounce_delay_ms;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 4b038c8bbf9f..f53c2ffeffa2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -249,6 +249,7 @@ int amdgpu_rebar = -1; /* auto */
 int amdgpu_user_queue = -1;
 uint amdgpu_hdmi_hpd_debounce_delay_ms;
 uint amdgpu_allm_mode = 1;
+bool amdgpu_hdmi_vrr_desktop_mode = true;
 
 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
@@ -1146,6 +1147,18 @@ module_param_named(hdmi_hpd_debounce_delay_ms, amdgpu_hdmi_hpd_debounce_delay_ms
 MODULE_PARM_DESC(allm_mode, "Changes ALLM trigger mode (0 = disable, 1 = enable (default), 2 = force enable)");
 module_param_named(allm_mode, amdgpu_allm_mode, uint, 0644);
 
+/**
+ * DOC: hdmi_vrr_on_dekstop (bool)
+ * Enables FreeSync behavior mimicking by keeping HDMI VRR signalling active in
+ * fixed refresh rate conditions like normal desktop work/web browsing.
+ * Possible values:
+ *
+ * - false = HDMI VRR is only enabled if refresh rate is truly variable
+ * - true  = Mimics FreeSync behavior and keeps HDMI VRR always active
+ */
+MODULE_PARM_DESC(hdmi_vrr_desktop_mode, "Changes HDMI VRR desktop mode (false = disable, true = enable (default))");
+module_param_named(hdmi_vrr_desktop_mode, amdgpu_hdmi_vrr_desktop_mode, bool, 0644);
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 5fd9e8aadc98..b41e2240e1ae 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -654,8 +654,13 @@ static void build_vtem_infopacket_data(const struct dc_stream_state *stream,
 	bool vrr_active = false;
 	bool rb = false;
 
-	vrr_active = vrr->state == VRR_STATE_ACTIVE_VARIABLE ||
-		     vrr->state == VRR_STATE_ACTIVE_FIXED;
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

