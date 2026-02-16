Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB89E68150
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 08:05:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 766D610E488;
	Tue, 17 Feb 2026 08:05:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dqi4IxGE";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57E0B10E3CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 16:45:43 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-b8fa033d805so46895866b.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 08:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771260342; x=1771865142; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V3FLqJPrUOmwXQvUvRLSCbWo9qs/90WV/TQwHFimOx4=;
 b=dqi4IxGEpJSKGR2GlGwMJyEE24gerB3RQ1ZM9pvrPSaA9gUq7xf0r5mWdVFmZ2Vn9s
 UPdjMI8siKE11UwcxxgaA3qf3PeaYqJ2HdiTPw85yVJdzkevZJ8tiy9KHzswTW5OZ51U
 RTlLnNYvDjb2SwNntPkrP9TXTQC1caBahDWJVLl0tBl9u+bVcsLp9qCEPLbniQge1UL8
 BnJIbXyTkbGC+bIil1DQz26uBWxuJSACu4or0Wp+zXE17MYYXNitGQlA8kkLVpxYWwgu
 tMrT1+Aa5kfw9b2+BcTKBaDeFsrw2db6EPdh6zNXkRZy8jS/7ssNqLfNsh6WeDVr2umX
 N1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771260342; x=1771865142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V3FLqJPrUOmwXQvUvRLSCbWo9qs/90WV/TQwHFimOx4=;
 b=TioedxoU4EoCCLY2AfRQiheZZvN6xjoefh/oizlAdmUD3bNGxEPDOOSV7uk/+kGpex
 KE49/z5rY4dIWKoVPak21NvAB7DY7ocH4usJKNNWLcgrzXK8te7gp9oQfenJ5F2D1wwo
 tEfLXt0oAuRvhhTcI2KP/t1833EqNt8824WXVDymCHWIlUQB1Y0nd+PtuNZy6FtcO5IX
 S/nCpxJDSMKkAzun6xf9llmFO/wF4D8Jj0MSdOLzs0s3Vy1VemZf0gy+Vqsv4BBwPPQv
 rW6K4wWKGrTOvYQEdg5Qm0zRGYcJECULYs51V9xCgxbeMl9OnAMv4rf5WvDcoYIPDDc6
 9JqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfGGgPjkDF3C0ymQKbTuL3mmhoW0NooVcjKa6P6+3Z/veYvvLcibM4ywHXgYwiVDpkV5mQERpl@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwILsfqM1sOxSaU6cVNiq2ENW3NMVEc48UQRQDY+dk3iOxinYKU
 ZUIlScsMDZes9M3SAeAaKH30rfXsTIqMuaOEOFWMm5ef1aXUjxu+lIuc
X-Gm-Gg: AZuq6aLto5wCCYwbWcb9PDkRAFSWsc2dXCJo/RUqiRjNOwwRp2oEL/BRS2kSxuEtKl5
 4UbQ1IYECs8XijMTdHdDECt9MrkZdBrhX2XQURhanlwIFt0TyxYfgONnCOUYwo5ZTfabX0p96I0
 kC0rTg6JJyx+2AEOBXd5VkK4pC8UM49AmIOvBJaNAJeOhzmAh3doz+dqinG6LD3EfkOqi1H1Y7Q
 0Vwz7lPep+Zpe3IQKLhkR4mvbv9bT31pOAyKsDsZNsc+CzuToTyezXhwyeW1/+OM+ATVV6IZNK3
 x2x45oDJB+0WdkVkF11MjLXc1QkRlpyksTzFunSGVn7E512JvRmDaf4RTzdKY1S/mGxZEUaw3Xz
 iIsFo1m6PfbeQVdFmqzZ1n+HxJRvQOk/Y5bm6MHMegfMXYt1abtxNK29h0F5yLL79DdGDmFq0vv
 JpVt8O7g5DnIhT/tzaW/wJSYXaST5Q96TStBbhPV84+gH5clMqERbx82NNgWVCX93SUHE8byIAY
 /Hq
X-Received: by 2002:a17:907:72c6:b0:b8e:92e:d2ef with SMTP id
 a640c23a62f3a-b8facf879c6mr396937766b.5.1771260341718; 
 Mon, 16 Feb 2026 08:45:41 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc735d185sm264683866b.14.2026.02.16.08.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 08:45:41 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v4 17/27] drm/amd/display: Save HDMI gaming info to edid caps
Date: Mon, 16 Feb 2026 17:45:06 +0100
Message-ID: <20260216164516.36803-18-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216164516.36803-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260216164516.36803-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Feb 2026 08:05:08 +0000
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
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 7 ++++++-
 drivers/gpu/drm/amd/display/dc/dc_types.h                 | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 690558584a0f..c24476182fdf 100644
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
index bddb16bb76d4..2efca21a6561 100644
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
2.53.0

