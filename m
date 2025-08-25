Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF45CA0FE9
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 21:47:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B19BE10E583;
	Mon, 25 Aug 2025 21:47:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="heqoVhjq";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D954010E58F
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 21:47:02 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-3c68ac7e238so1665606f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 14:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756158421; x=1756763221; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SrAiVaQ5xzmXx77atjsH3THK+hr947UEd6LLsXMVZLs=;
 b=heqoVhjqtAyfocJnke9DnDVk8tTl4q3As7sU2J8lgR2ygLyyLm4glSq4+Xlmmp5HQt
 +LrK4fBp4FKbrzzda2lFiKCe8UTqZyCTcfnZlBM02LIUu0UJl36MmqVx6/0egaC4Oo8O
 yJYoFZX1hJHe40nBTo7jIwDtrkSyNFOrr7XwpUUBvsUlwiOEcLTfomiETvrvST/tq31E
 etxUoFvLbKDsFq9b/DKdooPn62AEsH3VkNTayPTZQeLTR0TpRcSafH/LAZBCFOrCamc7
 +PaJmlWtDduJf+x310jP8TKu/ZIopRd4d1CTcfI4mxg7x8jyWFT2m874GdDwu7k20gYx
 gqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756158421; x=1756763221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SrAiVaQ5xzmXx77atjsH3THK+hr947UEd6LLsXMVZLs=;
 b=FU5sYF4Tk/fh+HoHGp2sDSM9wUKR3UKFw+nK+OgpymvKg6U5V7eTkDdanDaRhJ2+9H
 x3rNc8nqq1IoaVhkuwCE7yIoIxKxD+2O8hUDl6KPzxQI3u1t6eokkfMnfe/TnsJ3FuDv
 iGyH0wEs869i9yaAWfHeUUIG9bsWWub3UxMy2oE4a3TEvbqlkmXxvssqrgv/N0s2nMlD
 bf0TAbGbRJ+WIlRl7VQ5amCvFwQL1dbE7FPoW/vPvci44D3dR+j8ptl5zdKJiFH3z2sj
 ttod39eWbzPd0TPSHeLrm394b35LaK7dphlcy0mnJnjJJo+iV+eOJA+fVyPIg510IN+Y
 aNdw==
X-Gm-Message-State: AOJu0YyzpkbAIoXhD49ndVM65OysAmg+SoC8ho6jwfHge1cqGUWB6qZE
 +66iffGVk13JTDT9/5/Yv8+WG2DJ4u/32oSkoN9iRPT6naQrDalDWhQjxa3xZw==
X-Gm-Gg: ASbGncvXfH7GK4RAGEcKOEXZ+A4WF+7Cbej8RzDRmh45es/oaIkuxcBVRBa3SC7nu7p
 JlPN9NO1kBarocs3pD03z9MF1Zrq0zt4pslAoKBilhaDvrAyUjRwzshazV0ByhrULSVpY2nksCY
 HDMgIUAAMed1WWpOfikuWH6JJatqFER0hUccE1z4iTmzjFC6VY6KYYY9gdU6JFUNktTlkVq8SS/
 RQzc7PCSmLgnY2VTo+XbAUwgi5FAjTcjT3vipFna/b4CtlaC41aKnhWbTPfoby9DjPspMtthzGV
 YaVjmh09p8OgJGUdr7c+UUKN70NRdeLqkSuBoGw1vPRgA+5Pffmkq7/4YtRSXtBau/B1p+Jwy30
 tjTkYeCdivm7Fb6BXdH/yLTOFwRwS/z1153MWnJF4UQv3a68xSFKF3PFtvbmcjHt4C6NrqxJeoM
 mX19u4sfrOt5ca9SWT4sIAOtUUUQ==
X-Google-Smtp-Source: AGHT+IEvyZ/Wcumcy/cdAJ77dz23tJT0xDgR+22VE2UnWM9px1Q6OD29tLnIMRNEfytwAXHuJkQVnQ==
X-Received: by 2002:a05:6000:2507:b0:3c3:a80d:2b98 with SMTP id
 ffacd0b85a97d-3c5db8aa404mr9453518f8f.6.1756158421235; 
 Mon, 25 Aug 2025 14:47:01 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c7117d5977sm13348110f8f.51.2025.08.25.14.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 14:47:00 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 alex.hung@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 8/8] drm/amd/pm: Remove wm_low and wm_high fields from
 amdgpu_crtc (v2)
Date: Mon, 25 Aug 2025 23:46:35 +0200
Message-ID: <20250825214635.621539-9-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825214635.621539-1-timur.kristof@gmail.com>
References: <20250825214635.621539-1-timur.kristof@gmail.com>
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

These fields were only used by si_dpm and are not necessary
anymore. They also may have been incorrect because:
- wm_high was set to the LOW_WATERMARK field of watermark A.
- wm_low was not set on DCE 6 and was always zero.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h | 2 --
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c   | 3 +--
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c   | 3 +--
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c    | 1 -
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c    | 3 +--
 5 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index 6da4f946cac0..20460cfd09bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -496,8 +496,6 @@ struct amdgpu_crtc {
 	struct drm_connector *connector;
 	/* for dpm */
 	u32 line_time;
-	u32 wm_low;
-	u32 wm_high;
 	u32 lb_vblank_lead_lines;
 	struct drm_display_mode hw_mode;
 	/* for virtual dce */
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index bf7c22f81cda..c7b104222a97 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -1141,8 +1141,7 @@ static void dce_v10_0_program_watermarks(struct amdgpu_device *adev,
 
 	/* save values for DPM */
 	amdgpu_crtc->line_time = line_time;
-	amdgpu_crtc->wm_high = latency_watermark_a;
-	amdgpu_crtc->wm_low = latency_watermark_b;
+
 	/* Save number of lines the linebuffer leads before the scanout */
 	amdgpu_crtc->lb_vblank_lead_lines = lb_vblank_lead_lines;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index 47e05783c4a0..fe8a4f70414a 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -1173,8 +1173,7 @@ static void dce_v11_0_program_watermarks(struct amdgpu_device *adev,
 
 	/* save values for DPM */
 	amdgpu_crtc->line_time = line_time;
-	amdgpu_crtc->wm_high = latency_watermark_a;
-	amdgpu_crtc->wm_low = latency_watermark_b;
+
 	/* Save number of lines the linebuffer leads before the scanout */
 	amdgpu_crtc->lb_vblank_lead_lines = lb_vblank_lead_lines;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 276c025c4c03..8ab1f08afcef 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -1034,7 +1034,6 @@ static void dce_v6_0_program_watermarks(struct amdgpu_device *adev,
 
 	/* save values for DPM */
 	amdgpu_crtc->line_time = line_time;
-	amdgpu_crtc->wm_high = latency_watermark_a;
 
 	/* Save number of lines the linebuffer leads before the scanout */
 	amdgpu_crtc->lb_vblank_lead_lines = lb_vblank_lead_lines;
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index e62ccf9eb73d..47ed5f1840fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -1096,8 +1096,7 @@ static void dce_v8_0_program_watermarks(struct amdgpu_device *adev,
 
 	/* save values for DPM */
 	amdgpu_crtc->line_time = line_time;
-	amdgpu_crtc->wm_high = latency_watermark_a;
-	amdgpu_crtc->wm_low = latency_watermark_b;
+
 	/* Save number of lines the linebuffer leads before the scanout */
 	amdgpu_crtc->lb_vblank_lead_lines = lb_vblank_lead_lines;
 }
-- 
2.50.1

