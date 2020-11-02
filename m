Return-Path: <SRS0=PoT7=EI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1592C388F9
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 19:41:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8703D22268
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 19:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZL3CEeY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8703D22268
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13AE76EB95;
	Mon,  2 Nov 2020 19:41:39 +0000 (UTC)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C5BF6EB87;
 Mon,  2 Nov 2020 19:36:18 +0000 (UTC)
Received: by mail-pf1-x444.google.com with SMTP id b3so12051746pfo.2;
 Mon, 02 Nov 2020 11:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=s/DA9Kue9Ve8AC+uOhIa4hc4aaK5zLqpc50nqJdELt0=;
 b=aZL3CEeYk7iVAX0nfTGvMN0yre2qpny9PFNowwuO3SUgxkSiMTlFEb9wI/TaQDhwIP
 yK1l6mGwUoJI12pkoIJEzLUgOutjpgu8N7YR0bG9DGkkBm+JE1tEBdsqT2CXMyImLwUz
 nHH4Oq+Nbg2+ONavgNNYaJcIbFTlRxVehiMXerS39NPsVAznTdA0AvVNDK8E0u0O3kVn
 iSRFQzF3w5JoqoMEOTaZcfb8aWR+tbn/iRVF20L8agcCY7cxSUpwWr+1XYrmJwOIgkHT
 v7aV/za6H4URGmN0ExXJ+Sp6hQf6kFtB9g+pfvFIq64ad2Lv0z/L2qdSQ6b+cEnlTeyH
 FzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=s/DA9Kue9Ve8AC+uOhIa4hc4aaK5zLqpc50nqJdELt0=;
 b=Msi8qwTZEXuJdx1wvMECJpc2qYMlrpwYDWgPC6uEJI/FAbIt58oscSYf0RSGf3ynk3
 s7R9oOC6ct2sojLKJJOtUkAh0pISmG6NVwUKqaQzsGTP9E0o9xgoImkc1XM4958fQhe0
 ybNt8kNKWldrz5pEvrxJcUbC+J3czxHZkOstRkPPy0regP7NRt6l2B22vreKoS6rk+uM
 KR/hktNDRtg7WiX9D+cOlLkBDOK6kdsqvGAjZ0cEt2jnfp5PolJyURTVi0eXnOCpe3s+
 4LdAqFpuQ3WK85TxyCmeEnrfZR/aXgGrVGCwRLcHoHljZl62h7lJ0rjB/p8fhHXXus0l
 kxyQ==
X-Gm-Message-State: AOAM533LsPYEfMGmv4VkPu+4SWNvbxUvhwXs7Xjd/sYdCXq2kJj9KOcs
 9kdN3DOjsx0qP2hxuLZYaC0=
X-Google-Smtp-Source: ABdhPJxGtFsHxqpHVik0XMgKD5oDUq7RYiD8rabDGWVXAqIBZBXqVhXo4Th8ZmALaNcYTdhpQGbbhw==
X-Received: by 2002:aa7:8287:0:b029:142:2501:39ec with SMTP id
 s7-20020aa782870000b0290142250139ecmr22201598pfm.59.1604345777761; 
 Mon, 02 Nov 2020 11:36:17 -0800 (PST)
Received: from localhost ([160.202.157.3])
 by smtp.gmail.com with ESMTPSA id gb13sm241681pjb.55.2020.11.02.11.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 11:36:17 -0800 (PST)
Date: Tue, 3 Nov 2020 01:06:11 +0530
From: Deepak R Varma <mh12gx2825@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] drm/amdgpu/jpeg: use "*" adjacent to data name
Message-ID: <cc3d07cfc8480f9f812d801f66ee9dee5674c662.1604345594.git.mh12gx2825@gmail.com>
References: <6ad41a97d7805124d2e31c70d96c846cf0d21524.1604345594.git.mh12gx2825@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6ad41a97d7805124d2e31c70d96c846cf0d21524.1604345594.git.mh12gx2825@gmail.com>
X-Mailman-Approved-At: Mon, 02 Nov 2020 19:41:38 +0000
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
Cc: melissa.srw@gmail.com, gregkh@linuxfoundation.org, mh12gx2825@gmail.com,
 daniel.vetter@ffwll.ch
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When declaring pointer data, the "*" symbol should be used adjacent to
the data name as per the coding standards. This resolves following
issues reported by checkpatch script:
	ERROR: "foo *   bar" should be "foo *bar"
	ERROR: "foo * bar" should be "foo *bar"
	ERROR: "foo*            bar" should be "foo *bar"
	ERROR: "(foo*)" should be "(foo *)"

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 7b1a18cbafc4..6b80dcea80ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -247,7 +247,7 @@ static int jpeg_v2_0_disable_power_gating(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int jpeg_v2_0_enable_power_gating(struct amdgpu_device* adev)
+static int jpeg_v2_0_enable_power_gating(struct amdgpu_device *adev)
 {
 	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG) {
 		uint32_t data;
@@ -274,7 +274,7 @@ static int jpeg_v2_0_enable_power_gating(struct amdgpu_device* adev)
 	return 0;
 }
 
-static void jpeg_v2_0_disable_clock_gating(struct amdgpu_device* adev)
+static void jpeg_v2_0_disable_clock_gating(struct amdgpu_device *adev)
 {
 	uint32_t data;
 
@@ -297,7 +297,7 @@ static void jpeg_v2_0_disable_clock_gating(struct amdgpu_device* adev)
 	WREG32_SOC15(JPEG, 0, mmJPEG_CGC_GATE, data);
 }
 
-static void jpeg_v2_0_enable_clock_gating(struct amdgpu_device* adev)
+static void jpeg_v2_0_enable_clock_gating(struct amdgpu_device *adev)
 {
 	uint32_t data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 845306f63cdb..c6724a0e0c43 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -247,7 +247,7 @@ static int jpeg_v2_5_resume(void *handle)
 	return r;
 }
 
-static void jpeg_v2_5_disable_clock_gating(struct amdgpu_device* adev, int inst)
+static void jpeg_v2_5_disable_clock_gating(struct amdgpu_device *adev, int inst)
 {
 	uint32_t data;
 
@@ -276,7 +276,7 @@ static void jpeg_v2_5_disable_clock_gating(struct amdgpu_device* adev, int inst)
 	WREG32_SOC15(JPEG, inst, mmJPEG_CGC_CTRL, data);
 }
 
-static void jpeg_v2_5_enable_clock_gating(struct amdgpu_device* adev, int inst)
+static void jpeg_v2_5_enable_clock_gating(struct amdgpu_device *adev, int inst)
 {
 	uint32_t data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 3a0dff53654d..e8fbb2a0de34 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -213,7 +213,7 @@ static int jpeg_v3_0_resume(void *handle)
 	return r;
 }
 
-static void jpeg_v3_0_disable_clock_gating(struct amdgpu_device* adev)
+static void jpeg_v3_0_disable_clock_gating(struct amdgpu_device *adev)
 {
 	uint32_t data = 0;
 
@@ -243,7 +243,7 @@ static void jpeg_v3_0_disable_clock_gating(struct amdgpu_device* adev)
 	WREG32_SOC15(JPEG, 0, mmJPEG_CGC_CTRL, data);
 }
 
-static void jpeg_v3_0_enable_clock_gating(struct amdgpu_device* adev)
+static void jpeg_v3_0_enable_clock_gating(struct amdgpu_device *adev)
 {
 	uint32_t data = 0;
 
@@ -286,7 +286,7 @@ static int jpeg_v3_0_disable_static_power_gating(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int jpeg_v3_0_enable_static_power_gating(struct amdgpu_device* adev)
+static int jpeg_v3_0_enable_static_power_gating(struct amdgpu_device *adev)
 {
 	/* enable anti hang mechanism */
 	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, mmUVD_JPEG_POWER_STATUS),
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
