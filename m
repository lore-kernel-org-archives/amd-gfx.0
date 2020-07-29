Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0FFC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 17:34:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97FC5207F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 17:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7SaASRC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FC5207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E3356E5C6;
	Wed, 29 Jul 2020 17:34:56 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A6926E5C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 17:34:53 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id b25so18260939qto.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 10:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HXUUfvZg3A+0k35I18KyPavM36goxHWhIef6kRdBYng=;
 b=Y7SaASRCsxlTDr/qBglxXFRs9Fd7s2swIgHw8Xg1/PgP4MywkT5mAQEQUgRSNmzila
 /AxgMCalO5DW1IH5kr2bXS9FLjjG5sFDp3JiRoXugGHByRtQfFUiSHI4Dj0edzb97y/2
 BpaueSVEe5edStKeGK2uMpaD4RzasWEpg5h1A3nNOa6GjI+CpeQSQ8j3F+2XMe/oNEt0
 UVoPq1SKwFJn3/Hi+ZELIOqzuOY7mPXTXCryj0Gxg8GENK98oCgjPUXc9EOdoiodXvHG
 yRQvvNhZkmJl1V4va8O19BOp1qCRIe1HUwSfl5wrKHya8Jr90CsDls7v1Gk9pFx1o8Dr
 R+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HXUUfvZg3A+0k35I18KyPavM36goxHWhIef6kRdBYng=;
 b=YE5ph1uWEYYXI22UDLPkl5G2M3aawybMUb7vjdozZpRGlhOlNb3Qws1lkS10kNnOrj
 LSxFo0AWr2C0S8RktoZISat+l+Cd43O9VWr/hOl6wPaxQpO/Veprh3KPJB/VjNVjHxxT
 e8TFqkV62syz8OxZ2F7lOggp5HFSy8d+sZC89VuQ5BzMrsMLodrNPJ8PCXOtTk/pLIY1
 iHIPYHB66coF6Pl4Z3VWPOEBadrKy40WeqkCEYps0xHSHbzSEtxS/SWoXMyaFJvX+L+x
 zesGWu2SrOcFyVN2qxBViU0/SzZqZ1JUUsOM0YX5HwYRz7paa7XeIUQfR3bN/EYht8o7
 n5PA==
X-Gm-Message-State: AOAM532xv1e1p3kC8VyhG4RbZAuZCOFXaNdbnfG40Eaue6TlRUqYF1Uu
 jvpU8+HUY76i5oCqov+IGqiCDiZg
X-Google-Smtp-Source: ABdhPJzQJq1XYlIL1xLukWFnIphbPonuGWnvosYm8IzsZ1/AATPJz+DqII/p1nUJsaMZwpvEHM+llA==
X-Received: by 2002:aed:3789:: with SMTP id j9mr15117314qtb.251.1596044089537; 
 Wed, 29 Jul 2020 10:34:49 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id z72sm2132956qka.107.2020.07.29.10.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 10:34:49 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/17] drm/amdgpu: use a define for the memory size of the vga
 emulator
Date: Wed, 29 Jul 2020 13:34:25 -0400
Message-Id: <20200729173439.3698-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200729173439.3698-1-alexander.deucher@amd.com>
References: <20200729173439.3698-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rather than open coding it everywhere.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h    | 2 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 4 ++--
 6 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 58e39429395f..2a7fbe21619d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -212,6 +212,8 @@ extern int amdgpu_cik_support;
 #define AMDGPUFB_CONN_LIMIT			4
 #define AMDGPU_BIOS_NUM_SCRATCH			16
 
+#define AMDGPU_VBIOS_VGA_ALLOCATION		(9 * 1024 * 1024) /* reserve 8MB for vga emulator and 1 MB for FB */
+
 /* hard reset data */
 #define AMDGPU_ASIC_RESET_DATA                  0x39d5e86b
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 1a78073c2f05..040220e97cf3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -707,7 +707,7 @@ static unsigned gmc_v10_0_get_vbios_fb_size(struct amdgpu_device *adev)
 	unsigned size;
 
 	if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE)) {
-		size = 9 * 1024 * 1024; /* reserve 8MB for vga emulator and 1 MB for FB */
+		size = AMDGPU_VBIOS_VGA_ALLOCATION;
 	} else {
 		u32 viewport;
 		u32 pitch;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 538e7ee35cdf..4de996868d32 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -805,7 +805,7 @@ static unsigned gmc_v6_0_get_vbios_fb_size(struct amdgpu_device *adev)
 	unsigned size;
 
 	if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE)) {
-		size = 9 * 1024 * 1024; /* reserve 8MB for vga emulator and 1 MB for FB */
+		size = AMDGPU_VBIOS_VGA_ALLOCATION;
 	} else {
 		u32 viewport = RREG32(mmVIEWPORT_SIZE);
 		size = (REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_HEIGHT) *
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 0f8e8aff9114..4113f2d33b75 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -970,7 +970,7 @@ static unsigned gmc_v7_0_get_vbios_fb_size(struct amdgpu_device *adev)
 	unsigned size;
 
 	if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE)) {
-		size = 9 * 1024 * 1024; /* reserve 8MB for vga emulator and 1 MB for FB */
+		size = AMDGPU_VBIOS_VGA_ALLOCATION;
 	} else {
 		u32 viewport = RREG32(mmVIEWPORT_SIZE);
 		size = (REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_HEIGHT) *
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index abe64010f0d5..f29ff9afcc10 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1087,7 +1087,7 @@ static unsigned gmc_v8_0_get_vbios_fb_size(struct amdgpu_device *adev)
 	unsigned size;
 
 	if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE)) {
-		size = 9 * 1024 * 1024; /* reserve 8MB for vga emulator and 1 MB for FB */
+		size = AMDGPU_VBIOS_VGA_ALLOCATION;
 	} else {
 		u32 viewport = RREG32(mmVIEWPORT_SIZE);
 		size = (REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_HEIGHT) *
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index c5f94bab4a01..ac15d7678d24 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1077,11 +1077,11 @@ static unsigned gmc_v9_0_get_vbios_fb_size(struct amdgpu_device *adev)
 	 * Check related code in gmc_v9_0_sw_fini
 	 * */
 	if (gmc_v9_0_keep_stolen_memory(adev))
-		return 9 * 1024 * 1024;
+		return AMDGPU_VBIOS_VGA_ALLOCATION;
 
 	d1vga_control = RREG32_SOC15(DCE, 0, mmD1VGA_CONTROL);
 	if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE)) {
-		size = 9 * 1024 * 1024; /* reserve 8MB for vga emulator and 1 MB for FB */
+		size = AMDGPU_VBIOS_VGA_ALLOCATION;
 	} else {
 		u32 viewport;
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
