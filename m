Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84510C19F32
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 05:23:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D0C110EA43;
	Thu, 27 Feb 2025 05:23:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FuM2qvud";
	dkim-atps=neutral
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 686BE10EA32
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 05:23:01 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-7c0b24cc566so47073385a.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 21:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740633780; x=1741238580; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qGOHr5ULhOBPV9Alz2A4RAFeCam54LXS5UMalk5Xx88=;
 b=FuM2qvudN45MoCGUaGJ4Wgy1bCggOBpEIUGVxYGDO9LsgE1zdvsVRx2A9fAZ7xgU9d
 oWtTrVsbXm/fpwu/EmRvkc9ErDQgDdQdybyKleqXA/tsNc8hl3obL6H5F6b2H4aOLfAv
 d5xCRlkQn9nA1Uw58BznwZJkR6KhAtpT9kxE39c1ls2Lup9myc3y5IBdzN/b2HGfG61Z
 chowlYDT+/k3/XhVzxPHBqQKaaraYLVNsU0A4fuyTBhRk0kcRYZPZE9rc33z5m9gJ+1g
 T15ENydt7dDVWnR2MDReKYwwGZT8fuBQnikgBvRz6l+7HvWNHtaYbCGKWfDcrfdsXwIL
 BYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740633780; x=1741238580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qGOHr5ULhOBPV9Alz2A4RAFeCam54LXS5UMalk5Xx88=;
 b=Dc/P8fGqN/AgUF0oEPECw2RbodM4ix+SWU1fk92wZkC1ZqVi6RtwPX44wZTBJNgdcj
 wrxgHPVVKioQTWMsxACHgyDN7koZJvlGG347FqC/Wv2rSY1uHJtCEzZfkekLmOjtCLoI
 E8RkXl4Ldik0Yyuw9rAJwnHQXfZfcuN9igSIeXPCDQ280IJlBUzkA3artvUWnm8SD8a3
 Sk6khsWNwM9qoRwlafvweFOzOv0jZr1eBq9Qg6NtHNReDYDWsf/M9DQeX6Lnn/9QqrNV
 6j4VPyqw7QtbOcwwKNnI/IqEp+KSSOHpl/vD6+qKAdCQz/eS0VsEy5DCyioRlIU2o3se
 jwaQ==
X-Gm-Message-State: AOJu0Yxl8e3HIE89+Vp1Rk5DsIRY4aAIRC7fhqneVKRT9qQayWAvJ5wg
 QXpRa8FEVktGZo+GIThFoqdVNdEY09wDCnEORtZfJr21AiNWue5txdDRcg==
X-Gm-Gg: ASbGncu1VFH1IN77KMhKASorV2v+dFLOmltKnV7Gpf9cQ5kkU14m/Vt5x5L9OZtwq98
 hDsvfn2A3pe7SGWVluAnTqY5c/EV8nUbMa0ylUDj82ulwrXuN3xgYRu+MBn0FCH1kLIehbH74+t
 LCzYV0UBqP0LCRyg/tHJMTOpTV9n+PvAPXqx5OrPxZdIq6vDEr7e0PTok1MYMlo/rJrWa3EcjBj
 5ARMNFqUI75Qo206aEEALFyJu3r0z8HU/+Gm6lElptuHA6nLomPC7Lpe/uv+tx7Fj6F+p3mHTYF
 XWGN5dysE13eYxdksuk6Sluv/0LwzXCeM31s0orTYQWOf2km
X-Google-Smtp-Source: AGHT+IHJGpzmPO9nYJo8wIiEKLcqZHgxlwY9itDDU2KOcbUBkt+ycgXfRBTVnt3+2ldpow3xoJ45XA==
X-Received: by 2002:a05:620a:4247:b0:7c0:a075:3d93 with SMTP id
 af79cd13be357-7c247e0ac60mr826076585a.0.1740633780258; 
 Wed, 26 Feb 2025 21:23:00 -0800 (PST)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c378dab64asm65670085a.100.2025.02.26.21.22.59
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 21:22:59 -0800 (PST)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/6] drm/amdgpu: add some comments in DCE6
Date: Thu, 27 Feb 2025 00:22:39 -0500
Message-ID: <20250227052241.171102-5-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227052241.171102-1-alexandre.f.demers@gmail.com>
References: <20250227052241.171102-1-alexandre.f.demers@gmail.com>
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
index e805c4f9222c..fd2eb454a5d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -207,9 +207,9 @@ static void dce_v6_0_page_flip(struct amdgpu_device *adev,
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
@@ -219,11 +219,11 @@ static int dce_v6_0_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
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
@@ -1038,6 +1038,18 @@ static void dce_v6_0_program_watermarks(struct amdgpu_device *adev,
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
@@ -1418,6 +1430,8 @@ static int dce_v6_0_audio_init(struct amdgpu_device *adev)
 		adev->mode_info.audio.pin[i].connected = false;
 		adev->mode_info.audio.pin[i].offset = pin_offsets[i];
 		adev->mode_info.audio.pin[i].id = i;
+		/* disable audio.  it will be set up later */
+		/* XXX remove once we switch to ip funcs */
 		dce_v6_0_audio_enable(adev, &adev->mode_info.audio.pin[i], false);
 	}
 
-- 
2.48.1

