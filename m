Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B21AC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 16 May 2022 12:01:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C228C10E084;
	Mon, 16 May 2022 12:01:02 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E16D10E1B4
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 12:01:01 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id i8so264950plr.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 05:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id;
 bh=4zW7/IM45biovSAFxfr0e9jnSyoSEDs07sHgbcv8EKo=;
 b=FTVPj2555PWozfjz6MOg6i89SuUsGkyLrf6bLrnsLSPEM+KDVDydeee+Fq+4b1GCXQ
 mMUfhPfgIN0P7DdKfEO+VbK6mhQ13fa1Xf8gRsU5kg9u8eihnjaKbIdc10Wtq/NrEEG3
 ocSiuOPfqOnUlk07bmUxtB+252oqjxv1O9FVoLiPdrcRMSCi92LMyjIq1cJtR2YyquGI
 tlIIj74Ac7ZpldZi6q03nxCkVkS5wR1Oz4BxppXTB9/U8SVa9aQu8ZtEWVtcclbS5uTk
 Dqc4SybQ7QTcBhec8QpqXGcgmbpOg+yUUHsJ8YZ7N0TvwChsvyQRznI6yTFbM26tRoOh
 +kfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=4zW7/IM45biovSAFxfr0e9jnSyoSEDs07sHgbcv8EKo=;
 b=pKOi7VI30YFybvY4dVdj4GfrzjuHehjvpmTW6tPwuFaenjST3lCtIPzC8Dyc+a/auY
 OYx+Yiv2ckZKsDzPg4awRVU5zoCa9KtWuqd2UYlHDhloYGdFVMaGc71TUsTFG2Tt/I7f
 QPmEwJ+eFB5Pi9OmsrpJZhT625uOU6nZk1ixV+xn9BzOSiKyB6FXM8EMDfZaAZoc2LV4
 gwaaytW+2LQ5g6NbT2SNLZ8Zp66VqcnnldAKXuOTGDSa+dw0yWR8tg5aUrWSPHqll+Wj
 qXwpAn72GZjeNKCeXmUZ8oC13pluvxvbwWuV7wfj5yE9Fe/PksuHo5+jxUg0Ss3A/lmH
 iJcw==
X-Gm-Message-State: AOAM533C+DB+d0MKAiWY1ZFrI8zkstkXVfLDN7/n9zLE9GTvg/xqcR4E
 TX8lnWvYeIEXs6fh4IvepRFjWLIxD41H5DCZ
X-Google-Smtp-Source: ABdhPJzNKO0MSo1irBOgja7183pnOacvcvI/19XkwFONbPBCwuAexmItXivCIBzYruBh9C9hRsR49Q==
X-Received: by 2002:a17:902:864b:b0:15e:f9e0:20ca with SMTP id
 y11-20020a170902864b00b0015ef9e020camr17141784plt.122.1652702460952; 
 Mon, 16 May 2022 05:01:00 -0700 (PDT)
Received: from chachonne.lan ([2600:1700:8a10:4fd0::e])
 by smtp.gmail.com with ESMTPSA id
 b16-20020a62a110000000b005104c6d7941sm6658455pff.31.2022.05.16.05.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 May 2022 05:01:00 -0700 (PDT)
From: ricetons@gmail.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Clean up of initializing doorbells for gfx_v9 and
 gfx_v10
Date: Mon, 16 May 2022 05:00:53 -0700
Message-Id: <20220516120053.22963-1-ricetons@gmail.com>
X-Mailer: git-send-email 2.17.1
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
Cc: alexdeucher@gmail.com, ckoenig.leichtzumerken@gmail.com,
 Haohui Mai <ricetons@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Haohui Mai <ricetons@gmail.com>

Clean up redundant, copy-paste code blocks during the intialization of
the doorbells in mqd_init().

Signed-off-by: Haohui Mai <ricetons@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 17 -----------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 17 -----------------
 2 files changed, 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 4b66b9c93754..12f63d6aab12 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6919,23 +6919,6 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_hqd_pq_wptr_poll_addr_lo = wb_gpu_addr & 0xfffffffc;
 	mqd->cp_hqd_pq_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr) & 0xffff;
 
-	tmp = 0;
-	/* enable the doorbell if requested */
-	if (prop->use_doorbell) {
-		tmp = RREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL);
-		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
-				DOORBELL_OFFSET, prop->doorbell_index);
-
-		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
-				    DOORBELL_EN, 1);
-		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
-				    DOORBELL_SOURCE, 0);
-		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
-				    DOORBELL_HIT, 0);
-	}
-
-	mqd->cp_hqd_pq_doorbell_control = tmp;
-
 	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
 	mqd->cp_hqd_pq_rptr = RREG32_SOC15(GC, 0, mmCP_HQD_PQ_RPTR);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 83639b5ea6a9..f49a2dd89ee7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3535,23 +3535,6 @@ static int gfx_v9_0_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_hqd_pq_wptr_poll_addr_lo = wb_gpu_addr & 0xfffffffc;
 	mqd->cp_hqd_pq_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr) & 0xffff;
 
-	tmp = 0;
-	/* enable the doorbell if requested */
-	if (ring->use_doorbell) {
-		tmp = RREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL);
-		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
-				DOORBELL_OFFSET, ring->doorbell_index);
-
-		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
-					 DOORBELL_EN, 1);
-		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
-					 DOORBELL_SOURCE, 0);
-		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
-					 DOORBELL_HIT, 0);
-	}
-
-	mqd->cp_hqd_pq_doorbell_control = tmp;
-
 	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
 	ring->wptr = 0;
 	mqd->cp_hqd_pq_rptr = RREG32_SOC15(GC, 0, mmCP_HQD_PQ_RPTR);
-- 
2.25.1

