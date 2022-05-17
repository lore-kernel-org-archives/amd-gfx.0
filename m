Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F456C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 11:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D488410E349;
	Tue, 17 May 2022 11:24:42 +0000 (UTC)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B099110E349
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 11:24:41 +0000 (UTC)
Received: by mail-pg1-x52c.google.com with SMTP id h186so14021589pgc.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 04:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id;
 bh=3pp/XCauLjPTMdIAv4bWe5U3GzgmpHRIaLNWt1Zp+aA=;
 b=gh7TxZaXiQbVRACakD1r6xqEuqC4KCLTAW/uWOx9N36CapHNiDj83rzQguLSddlw6c
 /SzfcE3mc1UySA+M/nxJWzrQZ2jbpWZ65JrUOekYklwIYt1veCaFlizfnytcO35dVl4u
 w9sca9skC7JbvfVaoTKBwc8kINswAxnUnFjfcWjffx2MXqyO0KnymUM5RjEpCynxBp2P
 IqfbRzB/1BvxJPeQ1ARENscVO1Br6GfEwEMU4XmfKAqDX0jAt0ZZJV5kGuMeoVL+umlk
 60EchJNAlKqXRGOIvxTA2vjMDVgkM4ooEc11LlLRLiBmXiXXhG1gSP3qERhHCmYUNIaU
 r44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=3pp/XCauLjPTMdIAv4bWe5U3GzgmpHRIaLNWt1Zp+aA=;
 b=luzJlg2oc5jY38rH1p3xtig1HSrDzzbBp4e7LlCfCRHZ9QpRKIlJzCvsgZHP7gr7UG
 6p0xKwEX1/5UeDUCTUUw69OarVdNVVvYSgh8ufY/0nVX7hj20RgDuz7VdsSwOGTIqhMI
 C5FQqWgGoOLAAgZfl4tBhs8P1S/1leot7nJBh+DUhIA2GhQsWVfqWcP8IK8HaeIkrTda
 edii/9bIQsmJyRZS94UwBMSVu2arxdiDOafIubSeyIDFH97+jr/XNFHWQN7sID80Gnv4
 Rfbkk19fTH2HhUOwUsVz8OrQndEqYHMwzV5TRb6cZcTAVG+o/bRA7VVQ77+YY7QDmlA9
 Pqbw==
X-Gm-Message-State: AOAM531nBFWHWQDQue13S3QH+AXJKgCstDxPGcFHQQQ4i5dDTClLL2Hu
 d6UTMiylW4/16BTBpLoHeCYFvuQlrexP2mqfQPg=
X-Google-Smtp-Source: ABdhPJxRHV5mEDuJgEiPKXP5RrJKNKf7L0V1V2+lCzShyTbxnCUAbUMGqGWjnAE33GEk2GzuvsuqQQ==
X-Received: by 2002:a63:6b42:0:b0:3da:ebd8:2e38 with SMTP id
 g63-20020a636b42000000b003daebd82e38mr19225610pgc.273.1652786680769; 
 Tue, 17 May 2022 04:24:40 -0700 (PDT)
Received: from chachonne.lan ([2600:1700:8a10:4fd0::e])
 by smtp.gmail.com with ESMTPSA id
 i13-20020a17090a7e0d00b001deb3cbd8f1sm1417987pjl.27.2022.05.17.04.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 May 2022 04:24:40 -0700 (PDT)
From: ricetons@gmail.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fully disable the queues and doorbeels in gfx_v10
 before programing the kiq registers
Date: Tue, 17 May 2022 04:24:38 -0700
Message-Id: <20220517112438.5223-1-ricetons@gmail.com>
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

Signed-off-by: Haohui Mai <ricetons@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 27 +++++++++++++-------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index dd8f4344eeb8..9a1b42cc8500 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6956,20 +6956,6 @@ static int gfx_v10_0_kiq_init_register(struct amdgpu_ring *ring)
 	/* disable wptr polling */
 	WREG32_FIELD15(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 0);
 
-	/* write the EOP addr */
-	WREG32_SOC15(GC, 0, mmCP_HQD_EOP_BASE_ADDR,
-	       mqd->cp_hqd_eop_base_addr_lo);
-	WREG32_SOC15(GC, 0, mmCP_HQD_EOP_BASE_ADDR_HI,
-	       mqd->cp_hqd_eop_base_addr_hi);
-
-	/* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
-	WREG32_SOC15(GC, 0, mmCP_HQD_EOP_CONTROL,
-	       mqd->cp_hqd_eop_control);
-
-	/* enable doorbell? */
-	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL,
-	       mqd->cp_hqd_pq_doorbell_control);
-
 	/* disable the queue if it's active */
 	if (RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1) {
 		WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 1);
@@ -6988,6 +6974,19 @@ static int gfx_v10_0_kiq_init_register(struct amdgpu_ring *ring)
 		       mqd->cp_hqd_pq_wptr_hi);
 	}
 
+	/* disable doorbells */
+	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL, 0);
+
+	/* write the EOP addr */
+	WREG32_SOC15(GC, 0, mmCP_HQD_EOP_BASE_ADDR,
+	       mqd->cp_hqd_eop_base_addr_lo);
+	WREG32_SOC15(GC, 0, mmCP_HQD_EOP_BASE_ADDR_HI,
+	       mqd->cp_hqd_eop_base_addr_hi);
+
+	/* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
+	WREG32_SOC15(GC, 0, mmCP_HQD_EOP_CONTROL,
+	       mqd->cp_hqd_eop_control);
+
 	/* set the pointer to the MQD */
 	WREG32_SOC15(GC, 0, mmCP_MQD_BASE_ADDR,
 	       mqd->cp_mqd_base_addr_lo);
-- 
2.25.1

