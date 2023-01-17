Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56498C3DA78
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jan 2023 08:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC0AD10E2E2;
	Tue, 17 Jan 2023 08:12:48 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00ED710E2DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jan 2023 08:12:44 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id b7so3706973wrt.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jan 2023 00:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vs0V50N8JPFXlKlrVTAGXK35hqLC+XbAHH0alD8jGHM=;
 b=OVBczFLanhOMwgtEBsLfswBHdlBa7IBSDgnEuDckzjdi2ZcxcS5c7z3r8kBrU6tBOV
 Y4DcFsnF7sG+d1HcV4snR5pZgZBfCVF4Pxtd34AWxc7Natw5dUelJRahKcfgUi4WeiO9
 rEg3P2BkzME49C6n4FjU0uHOcSRzWs2O2XW6wJ3st80a7kybM44GkQO68XqPOx3CP+bu
 02rfx68k3DtNeX6Gf6qznNM5Vgu4GsAGS1adubEBABoAL+FPiF8kIasb1uWqm8vh6vry
 TKQQuNjdnDQnJ4qAutvmEbVK4ga6m0GcUoxsvVVqGRa5BrQNL4/9FDs++VbuowWxoLgr
 EEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vs0V50N8JPFXlKlrVTAGXK35hqLC+XbAHH0alD8jGHM=;
 b=Y5G1bklCmBw20T+uV7C0K0Xx6lGGSCWTUiOscvZh8lvEiXPz0dJhwkuX5Ljw8GuhN7
 xZDR2ZxJGwvbjxP9rB11OafdemBheRTBqQqbCmtPnTeSI2S5OOekTfcA1SVT35oWmhP2
 lf78pOn+DCSMu/0z1Avfp4muAsuLa2rsDfGDJD8Qy3Cd1QGs1lszaVMVMx0ZacCfrBuZ
 ZjIyKJ3Vew50Qrhl1uXHog1o+7VHjcLAZa4xfUdO9KvL/ErpbUl3yG30tkV7p3vYL6Wy
 /E8tPXtn7hf/aQZrjXHIkRVdDhDhNGgKODtGZc7YYSiaFvftXwqpC2r2wkSUe+68MB48
 Cn4w==
X-Gm-Message-State: AFqh2kreY1p3n/F1W0L1dH33g/pndsvX0FV6uhWYUPvHCpM5YWWdJK4d
 67j0Hl+BjgGgNnMtxHU5+1LXuyL3J+I=
X-Google-Smtp-Source: AMrXdXtHJ3NPZVi+MLsool83aIEnB0Tse1LtnGcFRLpsJW5AAOYLfKMFmHi2sZ7irqeEZaXIrOujBw==
X-Received: by 2002:a05:6000:1706:b0:2bd:dfbe:c17f with SMTP id
 n6-20020a056000170600b002bddfbec17fmr2304980wrc.58.1673943163495; 
 Tue, 17 Jan 2023 00:12:43 -0800 (PST)
Received: from able.fritz.box (p5b0ea2e7.dip0.t-ipconnect.de. [91.14.162.231])
 by smtp.gmail.com with ESMTPSA id
 i10-20020adff30a000000b0024228b0b932sm33917822wro.27.2023.01.17.00.12.42
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jan 2023 00:12:43 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: simplify amdgpu_uvd_send_msg
Date: Tue, 17 Jan 2023 09:12:40 +0100
Message-Id: <20230117081240.13669-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230117081240.13669-1-christian.koenig@amd.com>
References: <20230117081240.13669-1-christian.koenig@amd.com>
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

We only need one offset and not an array of it.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index dd0894c9740d..229419c0c031 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -1118,29 +1118,26 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct dma_fence *f = NULL;
+	uint32_t offset, data[4];
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
-	uint32_t data[4];
 	uint64_t addr;
 	int i, r;
-	unsigned offset_idx = 0;
-	unsigned offset[3] = { UVD_BASE_SI, 0, 0 };
 
 	r = amdgpu_job_alloc_with_ib(adev, 64, direct ? AMDGPU_IB_POOL_DIRECT :
 				     AMDGPU_IB_POOL_DELAYED, &job);
 	if (r)
 		return r;
 
-	if (adev->asic_type >= CHIP_VEGA10) {
-		offset_idx = 1 + ring->me;
-		offset[1] = adev->reg_offset[UVD_HWIP][0][1];
-		offset[2] = adev->reg_offset[UVD_HWIP][1][1];
-	}
+	if (adev->asic_type >= CHIP_VEGA10)
+		offset = adev->reg_offset[UVD_HWIP][ring->me][1];
+	else
+		offset = UVD_BASE_SI;
 
-	data[0] = PACKET0(offset[offset_idx] + UVD_GPCOM_VCPU_DATA0, 0);
-	data[1] = PACKET0(offset[offset_idx] + UVD_GPCOM_VCPU_DATA1, 0);
-	data[2] = PACKET0(offset[offset_idx] + UVD_GPCOM_VCPU_CMD, 0);
-	data[3] = PACKET0(offset[offset_idx] + UVD_NO_OP, 0);
+	data[0] = PACKET0(offset + UVD_GPCOM_VCPU_DATA0, 0);
+	data[1] = PACKET0(offset + UVD_GPCOM_VCPU_DATA1, 0);
+	data[2] = PACKET0(offset + UVD_GPCOM_VCPU_CMD, 0);
+	data[3] = PACKET0(offset + UVD_NO_OP, 0);
 
 	ib = &job->ibs[0];
 	addr = amdgpu_bo_gpu_offset(bo);
-- 
2.34.1

