Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC468CA600B
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 08:18:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 489FB10E3B0;
	Mon, 19 Jan 2026 08:18:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zwavm+dR";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B8F310E30E
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 01:12:09 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-650854d9853so725150a12.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 17:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768785128; x=1769389928; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JoGhByEn91FpZkY9+HAr/2lnyy1yobmuVs/gaZ80X2o=;
 b=Zwavm+dR743BmGR4IShCRt4L6zlrdAyZbnMtEnzF1DMfxTKjZJhJ3ROhXyeNpZwu4J
 5aJ256OWzfdq9D7gekwmmc3ofjtOf7eeznnGIXxj3PxTjn/zodvKjYdcFpmQxnwTbmuj
 f6mImfekrkFAOGQoJthtef7QvAIIU4XM5BXay9U+0qCO9j6jlrhgzt7kmQy3y8gM9O38
 o9EZBmKIecNtgVIR2/4YbB819V6qQct6KQh7/JIth59iWxOKjMre5I+L58xTb0alZsZ1
 txwQr72005mV3yGYkKFc+00p4HMFLZRVbkN1lD0kJfZzhWxl/cS5+GD6xcnD5md2siGU
 YqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768785128; x=1769389928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JoGhByEn91FpZkY9+HAr/2lnyy1yobmuVs/gaZ80X2o=;
 b=g9T50xJovRxxi5N+fTnal9OlGeaaOswpfGtcgnTQLe1X9Jr044OVGChEWn5tGyOJg9
 TgBMUvJqrzGAWlTRN2uETEPVVYDT+4BvW9yGgyiXuWjRe7WCLVNPXvGq7yFYtiu5W6XW
 2taBCtYrP3ytcWfe0THU91Zg/I3dDPj1wRoDL7w63147mhQAmkp6e8mnXhtxoT6QW6gm
 +5WEUt7FpXpyqgLMwbCGA9vG+SoZSY55nRJqbmKLOLQOieaYNJKXEZIh8VwVFoIR6hvs
 sL/p8K04jNePrIjwIEDDytar1JfWYtj4ocJT4yvpxtSTTuc1APfRn/IsfF8C47smd5Z8
 rhOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1Mk5dUUKBIQsmQeWypUh1KPYKp1f/2Y9e/WbUVVt/PfYftX8JNND8LomcQapp8Tw4Oa8PM25N@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywj2nqIpONt4/om9TLE0OOpK/xEY0j3Dqm0RILxMLpAOk8ks6no
 65UOopGE3bK/IJQbI5p01NLdW+CuyKr/d0ribHWh1luBYeOsQh6g0paa
X-Gm-Gg: AY/fxX47N1ZkE2jW0x12wvs/1K58YThLHi9j5643nugc99e+HmsbX0kiUP6j+rbYgoI
 gkerE1vq1wY3wwaDQkqUuCDJwXaZ90atFkhRbCd7cGSDut0Kld/hzUrVDf0yjeCMwJQTzOJfD7p
 Kkz3woqO84PTnPA0lFejMvy60VnXmNt7IbqFOk9wsJZC/9fSNBLoMpJtX2RBdCbhD+X811foEkN
 PaQKqTHrYhRH3/WL84eLJVoECnvo/ZFJTMrb3u1Mi9Mbxxnj4yu/eU5unQCPBbZ/2NdNuwFMH+r
 xA5+ZjIpcAsZNyX26gQ22kQppEZF3vEZe5pf+ucpVC81obB0U2B4MqTTThlmzL9ur2ce/7XY1Pt
 S9GeKDVwCP9xv/EubN0WdI/kj3IFU6WA48j5EFG9W+GtFJrYo4CWzsVexH7QVONYSXMdX5Qhtcu
 EPB7Ss1irUXVO9+uHfe/gOvXdA1yPpH/thJUrYcoNR0GqWzgYFiDSPnPBaL4V1xkBx
X-Received: by 2002:a05:6402:2684:b0:64b:76cb:5521 with SMTP id
 4fb4d7f45d1cf-654524cf81cmr4046398a12.2.1768785128060; 
 Sun, 18 Jan 2026 17:12:08 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654535c4912sm8989806a12.30.2026.01.18.17.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 17:12:07 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com
Subject: [PATCH 13/17] drm/amd/display: Save HDMI gaming info to edid caps
Date: Mon, 19 Jan 2026 02:11:42 +0100
Message-ID: <20260119011146.62302-14-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119011146.62302-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260119011146.62302-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Jan 2026 08:18:28 +0000
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
We need info about these features in parts of the driver where fishing
for drm_connector struct is infeasible.

[How]
Add three new fields to dc_edid_caps and fill them if connected device
is HDMI based on it's EDID

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 7 ++++++-
 drivers/gpu/drm/amd/display/dc/dc_types.h                 | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 37747f87b55a..6413f2a587d5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -137,7 +137,12 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 				  edid_caps->display_name,
 				  AUDIO_INFO_DISPLAY_NAME_SIZE_IN_CHARS);
 
-	edid_caps->edid_hdmi = connector->display_info.is_hdmi;
+	if (connector->display_info.is_hdmi) {
+		edid_caps->edid_hdmi = true;
+		edid_caps->allm = connector->display_info.hdmi.allm;
+		edid_caps->fva = connector->display_info.hdmi.vrr_cap.fva;
+		edid_caps->hdmi_vrr = connector->display_info.hdmi.vrr_cap.supported;
+	}
 
 	if (edid_caps->edid_hdmi)
 		populate_hdmi_info_from_connector(&connector->display_info.hdmi, edid_caps);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index bb1387233bd8..acc6db52f5d8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -210,9 +210,14 @@ struct dc_edid_caps {
 
 	uint32_t max_tmds_clk_mhz;
 
-	/*HDMI 2.0 caps*/
+	/* HDMI 2.0 caps */
 	bool lte_340mcsc_scramble;
 
+	/* HDMI 2.1 caps */
+	bool allm;
+	bool fva;
+	bool hdmi_vrr;
+
 	bool edid_hdmi;
 	bool hdr_supported;
 	bool rr_capable;
-- 
2.52.0

