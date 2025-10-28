Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D4ACCF9F2
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Oct 2025 22:07:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E53810E687;
	Tue, 28 Oct 2025 22:07:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YMyYOO7k";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97C8F10E68B
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 22:07:01 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-63e18829aa7so8780774a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 15:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761689220; x=1762294020; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W+Hwa01096g4k8k4G/RAHiiO4kZ6gTtCEy4tQftHz2Y=;
 b=YMyYOO7k2lo6rPVJvAbbR2b3l+u8tuMCKd0pG7wW+XvYZBEyuYDy74zpKCsDTkjqT/
 KDAAG/38sShdM5GT53X+paT8g3DviUNogDynLX9wDVyYASIrSH5UEhKkdgCCNfhOg8Cd
 LyDEZwCN+47nIX3yvaH/6f8zcVxiFzDo0bkCtDYNWkayXspn5+T9X1V1422c9a2R6PmG
 XeHvkGyfTqBaq0lFU5kEcWaSced4CIncfwI+zgaHKR+irRIW4iWKrIF4oJJ/m7kdOBFo
 MpCN3xj9b02/saAmKbMrFJlXsDMk7zW/x6BHGZ+j5iijQiNnv6RUNsqerR7JIhSeBX44
 kvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761689220; x=1762294020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W+Hwa01096g4k8k4G/RAHiiO4kZ6gTtCEy4tQftHz2Y=;
 b=Y99KDyuAZhwNy0rTMvVcDEYJMAFz67bv025qDHxUZg31Sl2xSx9OQfpV3bpsb3vFmh
 8zlnOeQ0XYg02csHN73rLh7jcX4zW/KAELJBIvWZoef2AZX75rnPpU+3flTe7lHkKciz
 yo32yvIF2bf0tl1cNyXCdBkb11iRCvu483P8q8U0+Lrceu34qFR6B3lctz3iRrMrTcIN
 WP6GHeWICt5VjGI0wXoEqoo2WwyfWlGfPLY8E2pxzvNI2NALtJwbMBZWfi1eITnE0/Yo
 9mAgwSnVfxXM8z0pHop31iX2MFnTeTyhTPsLKU0+xmzQ35gbN7w86KTp7iTgoaxcyCvs
 NUkA==
X-Gm-Message-State: AOJu0YxUMSG7gRLALMjEX5IY1KCMvJ6EkbouHKBGxN+s3EjIJPD1QG62
 9tOQRcELKesnmS8SeX5B99SamP1ax5TfH3WMF4mN2lmwbkK7mF3CPbRm0SbKXQ==
X-Gm-Gg: ASbGncsLjYLvkFTQPMnzBznbe1qHPbQxFkHY3VNffg2kMi+F+CBfN1iAKyFA9YH3X6t
 CLdrofQdfucXrLcjSC9cx2wcB6HdPGHokfpRUhquMg+6dBIins6Nd3iH7WGLath1hCT4Ca/6BPp
 TXgv3N+5LcXGUZ75YDKyP+KERPOnA2rkgF0m/9wsMeMD5K10oASNkRxV1YizVasiCSSLIzSim85
 +Q66V0Na1W0egVsmUqVlgv1qiqV0UGLlK2V3/zXzN9Alfc/q08jSEkclByHnL1wIrUl/YHMLoMw
 lCM5XLkjJCTnRIKHaZnJCSTVjFuV2B7LuGav5zoDUuyhjRJ5/pGVa8NqWLXbDpU/3kLJKieTgNd
 zagoskQwuT77995RkCwZk3mYsmKwft65Wt/tq/Ragdv7pAOk8LEqpYBxegPZ4MJclXkSb3oQNxl
 3QtGZ11caZoRaOKqVG430RDC7yFJK46jMW54n+UkHuAKMwpNrOP6L+VckKKgeVCGtJL4XEdr0wv
 DrbfR2m
X-Google-Smtp-Source: AGHT+IFJH0ZJSQbZ6X3sqT7Umn+Ysofw4bNWDjp+YkHmesENrCo7ZdbDTQ4ManFNwoZQw+HrWlI3Uw==
X-Received: by 2002:a05:6402:1e90:b0:63c:43e6:16f7 with SMTP id
 4fb4d7f45d1cf-6404425af01mr474564a12.26.1761689220018; 
 Tue, 28 Oct 2025 15:07:00 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24CBF70057E8101A3AD09709.dsl.pool.telekom.hu.
 [2001:4c4e:24cb:f700:57e8:101a:3ad0:9709])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640342e5acesm1881182a12.28.2025.10.28.15.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 15:06:58 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 14/14] drm/amdgpu/vce1: Tolerate VCE PLL timeout better
Date: Tue, 28 Oct 2025 23:06:28 +0100
Message-ID: <20251028220628.8371-15-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028220628.8371-1-timur.kristof@gmail.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
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

Sometimes the VCE PLL times out while we are programming it.
When it happens, the VCE still works, but much slower.
Observed on some Tahiti boards, but not all:
- FirePro W9000 has the issue
- Radeon R9 280X not affected
- Radeon HD 7990 not affected

Continue the complete VCE PLL programming sequence even when
it timed out. With this, the VCE will work fine and faster
after the timeout happened.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/si.c       |  6 +-----
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 10 +++++++++-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index f7b35b860ba3..ed3d4f9bf9d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1902,7 +1902,7 @@ static int si_vce_send_vcepll_ctlreq(struct amdgpu_device *adev)
 	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~UPLL_CTLREQ_MASK);
 
 	if (i == SI_MAX_CTLACKS_ASSERTION_WAIT) {
-		DRM_ERROR("Timeout setting VCE clocks!\n");
+		DRM_WARN("Timeout setting VCE clocks!\n");
 		return -ETIMEDOUT;
 	}
 
@@ -1954,8 +1954,6 @@ static int si_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
 	mdelay(1);
 
 	r = si_vce_send_vcepll_ctlreq(adev);
-	if (r)
-		return r;
 
 	/* Assert VCEPLL_RESET again */
 	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, VCEPLL_RESET_MASK, ~VCEPLL_RESET_MASK);
@@ -1988,8 +1986,6 @@ static int si_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
 	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~VCEPLL_BYPASS_EN_MASK);
 
 	r = si_vce_send_vcepll_ctlreq(adev);
-	if (r)
-		return r;
 
 	/* Switch VCLK and DCLK selection */
 	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL_2,
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
index 27f70146293d..fdc455797258 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
@@ -401,7 +401,7 @@ static int vce_v1_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 static int vce_v1_0_start(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring;
-	int r;
+	int r, i;
 
 	WREG32_P(mmVCE_STATUS, 1, ~1);
 
@@ -443,6 +443,14 @@ static int vce_v1_0_start(struct amdgpu_device *adev)
 	/* Clear VCE_STATUS, otherwise SRBM thinks VCE1 is busy. */
 	WREG32(mmVCE_STATUS, 0);
 
+	/* Wait for VCE_STATUS to actually clear.
+	 * This helps when there was a timeout setting the VCE clocks.
+	 */
+	for (i = 0; i < adev->usec_timeout && RREG32(mmVCE_STATUS); ++i) {
+		udelay(1);
+		WREG32(mmVCE_STATUS, 0);
+	}
+
 	if (r) {
 		dev_err(adev->dev, "VCE not responding, giving up!!!\n");
 		return r;
-- 
2.51.0

