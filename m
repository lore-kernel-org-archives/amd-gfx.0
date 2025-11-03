Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19530CCFA03
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 22:24:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6ED810E4C0;
	Mon,  3 Nov 2025 22:24:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qgw/o5vw";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC71910E4C5
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 22:24:10 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-b3c2c748bc8so631195766b.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Nov 2025 14:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762208649; x=1762813449; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cXhbeAMFRlK4iHDlRuDvXvJciu+OP9vuZ/hqKeviHqI=;
 b=Qgw/o5vwm7n0K+Xo786exiQUUQeayO6TnjWKkUXHxFOM40zMThu2xAmnSKXKunfd3r
 keWGE8pEVc+o+ZM0CMcUN0dKkP6JSikOousST4mpasZLStOtSKLZ6rEJJLbGifcKwbIp
 lVGfp4XIhH/+xRLDYk4nwvIX3Td02KXFxb/9vFKcah0QPWGd8KHmDZ46jeKRNNLCjk3M
 EeP/VcyfJL/pOJ9NdvqMcF76242Vqh5/rNa05lmOPaMcQXnvEh0qatU/Q2f75FJBDwha
 icKwCZBI9sIkXboS2rCYYhmcekeK6y1nZdvIT1mwuEPMgk+83eUPMFW02NtbYJGK9rqj
 kYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762208649; x=1762813449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cXhbeAMFRlK4iHDlRuDvXvJciu+OP9vuZ/hqKeviHqI=;
 b=NN0QiguBn3pv6LuapKpDecmgoGXyMh6xi4a+jhtnvP2JKt3aujzGbMsw6eCPkkrPKF
 4rsnafZ3nEO5SqEyjQkSl0UzNP6/QZHAjXbsN59HDE1bgBED26wLut4ZOE4wJHNzp8FT
 O+BLAz/A2Qcxeapmn+/MgQ5jMrxKm+xqvFncboRG05Um4RICLJqm1O9TUwMjUqfviUhM
 IuhqwTMHqp8Cvej4MKG6DdLa9AUdTpN0DTAPIVUlaNzW4nHcsHS6M9TtzJaH9jSyDneS
 BxWuzRnSCKItc8NpYD6KhQfIn/Dxg2PjRc/uk8Da1KjEEx/uQBufKDmcLGIOEJgcZZgm
 NsCg==
X-Gm-Message-State: AOJu0Yx34rEk9ML4UvMUau4BOrY8rZ/blEkDLbtqdprpriv2x1E2G2/N
 HOHFinU8TGc3UrEm9yq4MZviel5W7G+WKC2PrJ6v20Afo83u0SUyOz3YjapsLg6g
X-Gm-Gg: ASbGnctIddD2G9jSzQ9Fc1XXXVtFrvJ57VEJofU9SJD7yTvHkQxJnFgXZ4XggZCCD3c
 sfiSyDePWSnC4Yn6JrlM6TbYQzfeAkhAF8S5IL+lwm7nZIs5ispJNyGIiUMAe/+Sc5ySHKfn+JN
 IdlJxeVRnhVXzG699e8HUh3e1M2sK83Mb6HbURoIEl66oWGUgb1yCexX/2NDOblG/dbs+nrwvBz
 sMWKMMyBC67jjD4QhBARfP5xpwlTRG4rDAw6wJyzLZ0OxKAEb2cXcM5XoNPXXWCzn4wK55iLBLq
 TvnISzz4BjS542khiC85w49S37b5lMHYDW6nTjxjc63X+0P3yA0NnUCEauY/xHSdsBZszU9pseh
 BsFIKNLPjkmLJZKgwoAyf/I8wJeT5C1yySonUqAMLHpkI+LPm8x3a3WGiRdhTLOgWjC9trD/gDm
 LcsxcfcbcJQCM0BQZXmaE=
X-Google-Smtp-Source: AGHT+IGbKUhNqXfZFigzm8T6/qWX5Z9546ZrhffUFxKPs7sPG1PGfe1IDP2iR+ULpig23SUP7EdxTg==
X-Received: by 2002:a17:907:d29:b0:b33:b8bc:d1da with SMTP id
 a640c23a62f3a-b70701061d4mr1294747566b.1.1762208649145; 
 Mon, 03 Nov 2025 14:24:09 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e6a5cb5dsm486635a12.17.2025.11.03.14.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 14:24:08 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 09/16] drm/amdgpu/si, cik,
 vi: Verify IP block when querying video codecs (v2)
Date: Mon,  3 Nov 2025 23:23:26 +0100
Message-ID: <20251103222333.37817-10-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103222333.37817-1-timur.kristof@gmail.com>
References: <20251103222333.37817-1-timur.kristof@gmail.com>
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

Some harvested chips may not have any IP blocks,
or we may not have the firmware for the IP blocks.
In these cases, the query should return that no video
codec is supported.

v2:
- When codecs is NULL, treat that as empty codec list.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 7 +++++--
 drivers/gpu/drm/amd/amdgpu/cik.c        | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/si.c         | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/vi.c         | 6 ++++++
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index b3e6b3fcdf2c..71eceac58fb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1263,8 +1263,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			-EFAULT : 0;
 	}
 	case AMDGPU_INFO_VIDEO_CAPS: {
-		const struct amdgpu_video_codecs *codecs;
+		const struct amdgpu_video_codecs *codecs = NULL;
 		struct drm_amdgpu_info_video_caps *caps;
+		u32 codec_count;
 		int r;
 
 		if (!adev->asic_funcs->query_video_codecs)
@@ -1291,7 +1292,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		if (!caps)
 			return -ENOMEM;
 
-		for (i = 0; i < codecs->codec_count; i++) {
+		codec_count = codecs ? codecs->codec_count : 0;
+
+		for (i = 0; i < codec_count; i++) {
 			int idx = codecs->codec_array[i].codec_type;
 
 			switch (idx) {
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 9cd63b4177bf..b755238c2c3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -130,6 +130,12 @@ static const struct amdgpu_video_codecs cik_video_codecs_decode =
 static int cik_query_video_codecs(struct amdgpu_device *adev, bool encode,
 				  const struct amdgpu_video_codecs **codecs)
 {
+	const enum amd_ip_block_type ip =
+		encode ? AMD_IP_BLOCK_TYPE_VCE : AMD_IP_BLOCK_TYPE_UVD;
+
+	if (!amdgpu_device_ip_is_valid(adev, ip))
+		return 0;
+
 	switch (adev->asic_type) {
 	case CHIP_BONAIRE:
 	case CHIP_HAWAII:
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index e0f139de7991..9468c03bdb1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1003,6 +1003,12 @@ static const struct amdgpu_video_codecs hainan_video_codecs_decode =
 static int si_query_video_codecs(struct amdgpu_device *adev, bool encode,
 				 const struct amdgpu_video_codecs **codecs)
 {
+	const enum amd_ip_block_type ip =
+		encode ? AMD_IP_BLOCK_TYPE_VCE : AMD_IP_BLOCK_TYPE_UVD;
+
+	if (!amdgpu_device_ip_is_valid(adev, ip))
+		return 0;
+
 	switch (adev->asic_type) {
 	case CHIP_VERDE:
 	case CHIP_TAHITI:
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index a611a7345125..f0e4193cf722 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -256,6 +256,12 @@ static const struct amdgpu_video_codecs cz_video_codecs_decode =
 static int vi_query_video_codecs(struct amdgpu_device *adev, bool encode,
 				 const struct amdgpu_video_codecs **codecs)
 {
+	const enum amd_ip_block_type ip =
+		encode ? AMD_IP_BLOCK_TYPE_VCE : AMD_IP_BLOCK_TYPE_UVD;
+
+	if (!amdgpu_device_ip_is_valid(adev, ip))
+		return 0;
+
 	switch (adev->asic_type) {
 	case CHIP_TOPAZ:
 		if (encode)
-- 
2.51.0

