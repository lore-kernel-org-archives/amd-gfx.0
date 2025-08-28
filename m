Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7DECA0FF9
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 15:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67FF810EA22;
	Thu, 28 Aug 2025 15:11:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wf+78k7K";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B48F110EA1C
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 15:11:24 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-45a1b00f23eso7111865e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 08:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756393883; x=1756998683; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=53viYgtRqQv0yJiNv8NKHp//Sbxzv10FH5H48TVizqk=;
 b=Wf+78k7KAV/SO4XcJGfUiSEHFfURhEpWBhZhSlzDkxDr12AjrM3zjKMecQEwSX9LUs
 V/CkVhqKCRwyaTRonE3eME3Rkt7n9icFn4MM521mZtDc3D12n9zCiCHiORSbCFwjE8Li
 +f3JRzLs+87hJeMRnXztl2GV9jYHUtllwII/vWr7KsC90DuabyITbjc4OGYDLD2my7Nu
 mOkXdrC1h4VdlRbtLghmFYQgD0jzIciGaqKb9tHDzSs+k+6QIDxwI2113OBuOiIT9/Fl
 v44hM1b5L0Syz0NrHV/vkpFwi2HRpYpFuS7eRebTu/pB+xIDnZZsVBZJ9l/Lm6/GC/IA
 jp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756393883; x=1756998683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=53viYgtRqQv0yJiNv8NKHp//Sbxzv10FH5H48TVizqk=;
 b=NYXkuKVUqBdIMnC6Djl46YUoRjrsI5xTdtyfaC17qzEwmLOoj0H+EXySAhxm7W8mJs
 rPQx14QbZszWY027VvjrDgDcFqOLkc+dNZXRQ72seT2KNFjGEVW7aeiUoQ/T7Edb6kAN
 yT04K+QjjHUY0y3KTe+tewrDCRbxk+6i5JqstEPerswSNVO0xnq+edlj9AhRCu+mtLMc
 z58k3UOC9TS/+oxywmZZ9Ge0cvj8Jbq+2wEAlPgp+848oT8PtleDYHBVFHvYtT5Hqyz6
 DTQt8Z0SRVM9H3jfQfYrZUbMXOWg25EENmqX281QRPnErs8bYsqDoW7zHrViVl8VNJic
 aopw==
X-Gm-Message-State: AOJu0YyLtJeHPNRZraLpBklxXQ7Xw3DZQoSN0B3qFzBafZ5qxGzHb6Sl
 GFVGkSofjwrODX2y8cdiA16AQ3Y6F/kiPpsDB8vXLxhm2xnj4RcTHUpqEGEjEg==
X-Gm-Gg: ASbGnctkGH/qlicBIKMKXo9I2GokCXPh4AFcojYI3jGfE9CC/BePPcponrP5feF0daC
 Rm1zqCSIkP6+gqN06J5kU7RnnkA4lcSEXPKUlIrL1X/odWay2PfiwsQTgVB2YsmwxUmhs2XnQII
 nqnnogkI6IPg6w+MrLUqcPJioCq3MGeb/dGwgdmIfebhPJzVMo2M1uoqHk/dNueh2jhB1LWdwaF
 2x965qHpaCJSr5riGtNh2LjGj66TxYTvvHdK+Tw3Q+oAyvfVdUn+JUaYnpJBa0PATInmzMEuzO0
 tp+P00LK+MycXWaJAWLuNyJXDg00j/NDUx5ImZ7fRyzmCuafcV/srfh62kOHQcE1Fdx/yiXp/qJ
 eFEZZv+wgXkIhLGHhWfYCquq+/W0jgzU8Vn3qnPSUQWU5eGd4tz+Vl6Rz5sSNzp3sv+wVp/trxv
 dCG62kA9PoKJfoRoARj1xY+ryLFZNxkXZaQa+T
X-Google-Smtp-Source: AGHT+IHO3HS2lH5uC0gJWA5iPbDhtowEXhdGLnpiPqjpK0AXhUJDRMy3PlvRMmuqZXmR/FdZ/hmCQA==
X-Received: by 2002:a05:600c:45ca:b0:45b:47e1:f5fa with SMTP id
 5b1f17b1804b1-45b517d8e37mr197573615e9.35.1756393883063; 
 Thu, 28 Aug 2025 08:11:23 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306bffsm77448875e9.16.2025.08.28.08.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 08:11:22 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 09/10] drm/amd/pm: Remove wm_low and wm_high fields from
 amdgpu_crtc (v2)
Date: Thu, 28 Aug 2025 17:11:11 +0200
Message-ID: <20250828151112.15965-10-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250828151112.15965-1-timur.kristof@gmail.com>
References: <20250828151112.15965-1-timur.kristof@gmail.com>
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
2.51.0

