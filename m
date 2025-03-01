Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E91C282CD
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Mar 2025 02:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F2EE10ED71;
	Sat,  1 Mar 2025 02:22:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SqS51KJ9";
	dkim-atps=neutral
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD1CA10E0D8
 for <amd-gfx@lists.freedesktop.org>; Sat,  1 Mar 2025 02:22:20 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-7c08fc20194so451702085a.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 18:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740795738; x=1741400538; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3wCr/L7QbYsGzWARhoWJWUxybZOiTEyEuwU8KkgjnR4=;
 b=SqS51KJ9PZd85fHW00wdMuNdbDySl+tJIIdseK0+B8sjhK20pbbHF19M7oITD4GBh+
 QOshiJKNP7ptdmHqlZPG8ljxOHbAsbxVZZp8IK+hJJMglxkylB8yG7wLyf9k9bo8lXit
 6Jr9kuRPMneP1uai2vAwIJw29Q4ElM3Nmuy1EWXurRFJZcLPingfBoNkW6PmFF+FAD5W
 jSmf8h7hxtvN5VlN53RsBjR+3wHB6SJyhBMhBZqS83P9WmNgpTJR+QR4R31jXs4eOGEk
 J2Xkmpz/sj5j06gukASdijvLVuvH5OSSKtMz4gr2P1jjQUagqua2KwPItfw5pQDcghoj
 ByoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740795738; x=1741400538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3wCr/L7QbYsGzWARhoWJWUxybZOiTEyEuwU8KkgjnR4=;
 b=TtcPzDXub6EqyrZ05vb+wT9+zxaxbn3WufN935d4u/Sdqf2N8hDBrIOtN3mFYoNkIo
 gdRePypJ3uE7pm7AFahJjclwWGSQ+goC5mHLK1kuDD9h/rmKGQCLBr8lsyZAYdZcInPI
 1RUkbfeTGocw+uQBrqD282ibd6iT9OgPlQZOBZPNWmMIEOm4PjbLhvW5W9ycS6zVPo8B
 QPfIYSrIKwBPb89bkXDnRAzYjReFAO9GMSJojHKczx7aVfkpGxljVNdZY1CZxXn+l+c2
 NDrjLkQpjihXrHlsM+P4wq3EercMn9rZwYPn8sncb1Id4sWASWxMOB5EWbjBOsoqhOqg
 pgtQ==
X-Gm-Message-State: AOJu0Yz9b7Lcp5In+/pPNF9b9OgQdzBk19KiuWaHyOb+ZSjBFCevbbGC
 JuEd5IWNzG5eIE3BZ4wpWgO3P77z6ZxHx2//9+Wb7IfVwoa3WVshcJNYuA==
X-Gm-Gg: ASbGncslTzHYxV7iIzCyBxDpAnpY97VjcmHYlQOihCvT2oNUAhQ90hGSyetHeRBbdxq
 WmJrsdWzn7sRQQq8o48BtTxE6N1W9tYxLxaVSJBaoLUz2Z//56R7lj8x1YAy6PZC0zUwnSPORXO
 3SA3uGqRneiU5u7HEd9Bhi/pmZkUKsen481qF2J75f854ld+QIS7ro5lc7sPjL+hctaKf1/8LCR
 xEJb6UxWmcuaPf7ndOodcpMK3+YtNJrM8RnPj7ETVlkK6tT4FrCxtyG+HZVXKLKwKROOq3TNTxt
 wjJjcEQrqkBSlGYD+1a736dWFcimYDblYDXdVxkG9zDpV+509/hUJcLM1DwTytWG63Q=
X-Google-Smtp-Source: AGHT+IG2Y38lUqg0FjV+yyrKLkvyRbzboUmO1bNBgM0XVSAHFMGAlq91PKL2YlxG72vhU/dXKr4YDQ==
X-Received: by 2002:a05:620a:430c:b0:7c0:cc94:46ba with SMTP id
 af79cd13be357-7c39c4c54b7mr832090685a.27.1740795738145; 
 Fri, 28 Feb 2025 18:22:18 -0800 (PST)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8976537afsm28489106d6.43.2025.02.28.18.22.17
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 18:22:17 -0800 (PST)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 1/2] drm/amdgpu: add some comments in DCE6
Date: Fri, 28 Feb 2025 21:17:46 -0500
Message-ID: <20250301021747.28827-2-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250301021747.28827-1-alexandre.f.demers@gmail.com>
References: <20250301021747.28827-1-alexandre.f.demers@gmail.com>
MIME-Version: 1.0
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

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index eb7de9122d99..78402e7444db 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -206,9 +206,9 @@ static void dce_v6_0_page_flip(struct amdgpu_device *adev,
 	/* update the scanout addresses */
 	WREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS_HIGH + amdgpu_crtc->crtc_offset,
 	       upper_32_bits(crtc_base));
+	/* writing to the low address triggers the update */
 	WREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS + amdgpu_crtc->crtc_offset,
 	       (u32)crtc_base);
-
 	/* post the write */
 	RREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS + amdgpu_crtc->crtc_offset);
 }
@@ -218,11 +218,11 @@ static int dce_v6_0_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
 {
 	if ((crtc < 0) || (crtc >= adev->mode_info.num_crtc))
 		return -EINVAL;
+
 	*vbl = RREG32(mmCRTC_V_BLANK_START_END + crtc_offsets[crtc]);
 	*position = RREG32(mmCRTC_STATUS_POSITION + crtc_offsets[crtc]);
 
 	return 0;
-
 }
 
 /**
@@ -1006,6 +1006,18 @@ static void dce_v6_0_program_watermarks(struct amdgpu_device *adev,
 }
 
 /* watermark setup */
+/**
+ * dce_v6_0_line_buffer_adjust - Set up the line buffer
+ *
+ * @adev: amdgpu_device pointer
+ * @amdgpu_crtc: the selected display controller
+ * @mode: the current display mode on the selected display
+ * controller
+ *
+ * Setup up the line buffer allocation for
+ * the selected display controller (CIK).
+ * Returns the line buffer size in pixels.
+ */
 static u32 dce_v6_0_line_buffer_adjust(struct amdgpu_device *adev,
 				   struct amdgpu_crtc *amdgpu_crtc,
 				   struct drm_display_mode *mode,
@@ -1386,6 +1398,8 @@ static int dce_v6_0_audio_init(struct amdgpu_device *adev)
 		adev->mode_info.audio.pin[i].connected = false;
 		adev->mode_info.audio.pin[i].offset = pin_offsets[i];
 		adev->mode_info.audio.pin[i].id = i;
+		/* disable audio.  it will be set up later */
+		/* XXX remove once we switch to ip funcs */
 		dce_v6_0_audio_enable(adev, &adev->mode_info.audio.pin[i], false);
 	}
 
-- 
2.48.1

