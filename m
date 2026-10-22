Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB2D606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iJNAonnn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E2F91125EC;
	Thu, 22 Oct 2026 13:04:14 +0000 (UTC)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com
 [209.85.217.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D04D811252C
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 11:48:20 +0000 (UTC)
Received: by mail-vs1-f54.google.com with SMTP id
 ada2fe7eead31-7cc603a168fso541698137.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 04:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792669700; x=1793274500; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cG+5kIyh0kWAXD1Yf0rWfPRytbtZEq2h4IvreLdn/S4=;
 b=iJNAonnnzXgm40q8uQj4Ij/lO7pqaigYIXUWgD2UT1/S+86wnyZjf9bwL6AD67qm2P
 px8iOu/diRKkKzdySlXWnTEL8S1m7prGOX0wb2NPuVbq1J7VV1kYExf/yncl5pxW0Z2A
 TvLEAjEmemF7p/eSyRR7P67xK9BN1TQ6nxv6AeFRCIdGLx6GaVXZRV/PuyHzoSazf2eV
 GxFmU6apg9puxZjS3Ih3PyNHSqUorVTzr1Yq8ILNYCFwYj9zzBsUO0qqvX/rs9wNs2d4
 Y7+5jcTyCZfvE8XJiHxRWC4C4sb/AESWoky40vylUYmBP3lTzsAb0oFmUO6mhHo/l9ms
 5UBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792669700; x=1793274500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cG+5kIyh0kWAXD1Yf0rWfPRytbtZEq2h4IvreLdn/S4=;
 b=WNh5ZtcV5YQmYoIklQhe7ErKBxw2shnIZLqinVSolLLiahb/V8glV+3iwFakbCzMfU
 176QguQQ8DMLq/1YYXsOdNksaKrqY+qYMYylOS6PsTJ0VcEiE8qAiZ4X7KynpauQtt1w
 jBKCRRNxmYi5dTk2/nnZrrp08yaiamvCrUYRmna9DH04FYLxaxxak8Ee3AeYCu3288op
 /RC7B7Rxsm7f/6BIfmhiPajlxSdbgITvJFFr6AFRoZ9mPpy6M0MC4bnTYzKk7IiM0Y2b
 zIX8uTQRe0LeKSoFvGMsUc9nUHxv3u0IGtUuiHuqjbiMClnSeUitrppRd5qOi8uEPZ+J
 HWsQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJIkq7MDU6h960Hml3JelzHwbFezWlpgMH1U5ELUeVnhvwh2o2Cw9GQ+Cp6eW6GSj2qJJ3Vbld@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJmEH6yAohErwZs+j6J6GG8kn0znABG2T31g4biolbilRPC7WR5
 WXcfZllqrt1duygJ3YddrfNKxkruSHHP2C/OvR4cU1niStjAXqmLFyM7
X-Gm-Gg: AYBFou3sqk06rVQlv2ujUg+ghwOGKnzH2V4aPnesoOkGQSD70oXMqtk9RLu9mGlIWRy
 YyoGZNi0Y3dI3FG6m9A5DnpJYiTNHzaR1GHomPHYrbwG5gF9ZeWQhe9WswNtTm5mTwGmW6uMIat
 mVfIioWrePOMpR6GZJNLG8zIyVDHVJ+veYDZsXMrJNcxwOxWiIK3s8mRTXhsMLi8xwu5aIvBUoD
 sb9uq6ZvZLRsiuqGygibaOwl+5Izc7QKDCQHzVoFQp5gsabGfnk9CJ1WfwMIUW3RXLl0uU2l25W
 5UkSgvM30TgZdJ/qKqnkpqzOltYwn/tBX18swsKzL25XVMjvxOxwIZ+uHYPncg6/mVjeM+Giu9g
 Cn1imgiDCsVTI/VFDqRXFGbp6XQ538vnkDVglaEyTv+ZqSiLMzfqIfTVtNzoPYliIQQqP9RbO3W
 yR/a1CMsbut/IolldOFTX+zdXorbZ2EOnlJOxw6MtyNR6pNZlRteVfQdUjK9wOuJ/Gui8ESH/2Q
 yrcunoHtgkgHDnqdeS5UvIB3wHKxypM/tbyuyBexDs2Nth8yN0MfEnxatMaB6EUhcNpdwE=
X-Received: by 2002:a67:e711:0:b0:7a1:fa0f:1106 with SMTP id
 ada2fe7eead31-7cc927ffae5mr1735239137.36.1792669699746; 
 Thu, 22 Oct 2026 04:48:19 -0700 (PDT)
Received: from localhost.localdomain ([177.155.254.104])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-990d117c005sm6177793241.9.2026.10.22.04.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 04:48:19 -0700 (PDT)
From: Matheus Tagliari <mptagliari@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: Matheus Tagliari <mptagliari@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drm/radeon/vce1: enable the VCE trap interrupt
Date: Thu, 22 Oct 2026 08:47:47 -0300
Message-ID: <20261022114754.865669-3-mptagliari@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022114754.865669-1-mptagliari@gmail.com>
References: <20261022114754.865669-1-mptagliari@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 22 Oct 2026 13:04:11 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vce_v2_0 sets VCE_SYS_INT_TRAP_INTERRUPT_EN in VCE_SYS_INT_EN so that
the VCE_CMD_TRAP emitted after each fence raises an interrupt.  The
VCE1 code, used by SI and Trinity/Richland, never does, and amdgpu's
vce_v1_0 does (mmVCE_SYS_INT_EN, 0x8340, i.e. byte offset 0x20d00 on
SI).  VCE fences are therefore never processed from the interrupt
handler and are only noticed when a fence wait times out.

Enable the trap interrupt at the end of vce_v1_0_start().  CIK also
goes through vce_v1_0_start() (via vce_v1_0_init() and kv_dpm), but has
VCE_SYS_INT_EN at a different offset and already enables it in
vce_v2_0_resume(), so only do it for VCE1, i.e. before CHIP_BONAIRE.

Observed on a Radeon HD 8870M (Cape Verde, 1002:6821) with VCE firmware
50.0.1, Mesa 25.0.7 radeonsi and ffmpeg h264_vaapi on Debian 6.12.113:

 - Stock driver: the encode hangs after a few dozen frames ("ring 0
   stalled", "ring 3 stalled", "GPU lockup"), and the reset does not
   recover ("failed VCE resume (-22)", "ring 0 test failed").
 - With the hardware ring semaphores of the VCE ring disabled as a
   workaround, the hang is gone but encoding runs at 3.9 fps
   (~256 ms per frame), consistent with fences being noticed only by
   timeouts.
 - With this series: 640x360 for 1800 frames, 1280x720 for 900 frames
   and 1920x1080 for 600 frames, all in real time with no decode
   errors, and 191 fps at 720p / 91 fps at 1080p unthrottled.  Four
   runtime suspend/resume cycles with an encode in between also
   worked.  No lockup, reset, WARNING or error in the kernel log, with
   DPM and runtime PM enabled.

Trinity/Richland takes the same path and is covered by the previous
patch, but I have no such hardware to test.  CIK is not affected.

Fixes: a918efab631a ("drm/radeon: add VCE 1.0 support v4")
Cc: stable@vger.kernel.org
Signed-off-by: Matheus Tagliari <mptagliari@gmail.com>
---
 drivers/gpu/drm/radeon/sid.h      | 2 ++
 drivers/gpu/drm/radeon/vce_v1_0.c | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/radeon/sid.h b/drivers/gpu/drm/radeon/sid.h
index f9267b026..ba322de84 100644
--- a/drivers/gpu/drm/radeon/sid.h
+++ b/drivers/gpu/drm/radeon/sid.h
@@ -1878,6 +1878,8 @@
 #define	DMA_PACKET_NOP					  0xf
 
 #define VCE_STATUS					0x20004
+#define VCE_SYS_INT_EN					0x20d00
+#define		VCE_SYS_INT_TRAP_INTERRUPT_EN		(1 << 3)
 #define VCE_VCPU_CNTL					0x20014
 #define		VCE_CLK_EN				(1 << 0)
 #define VCE_VCPU_CACHE_OFFSET0				0x20024
diff --git a/drivers/gpu/drm/radeon/vce_v1_0.c b/drivers/gpu/drm/radeon/vce_v1_0.c
index bdfbcf14b..09fc1572a 100644
--- a/drivers/gpu/drm/radeon/vce_v1_0.c
+++ b/drivers/gpu/drm/radeon/vce_v1_0.c
@@ -350,6 +350,15 @@ int vce_v1_0_start(struct radeon_device *rdev)
 		return r;
 	}
 
+	/*
+	 * Enable the trap interrupt so that VCE fences are processed.
+	 * CIK also gets here but has VCE_SYS_INT_EN elsewhere and enables
+	 * it in vce_v2_0_resume().
+	 */
+	if (rdev->family < CHIP_BONAIRE)
+		WREG32_P(VCE_SYS_INT_EN, VCE_SYS_INT_TRAP_INTERRUPT_EN,
+			 ~VCE_SYS_INT_TRAP_INTERRUPT_EN);
+
 	return 0;
 }
 
-- 
2.47.3

