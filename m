Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABDEC433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:20:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30DF52068D
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wef0uF+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30DF52068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B730A6E2E0;
	Mon,  1 Jun 2020 18:19:59 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D68866E2E0
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:19:58 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id ec10so485972qvb.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XaugCSxyFvz7DVjsYiuRee8p7K5mX9+DeG2e7gCVfec=;
 b=Wef0uF+/BigXk6quXewFue7sApBX6al4KaWE4fwLlijVHzSWsd+GoUs5G8QqmJpSPT
 Gc1diJwARD9mlTk7J60jh6RtCLOf3meI8+ksofSTv6Lt/ggstgwrXjPHBN+oQyctC4kn
 wRvpon1ZlOp2YVXqP80nLOorFS+fJXIhwDmd1TBOFtnDlUX5T+26yZ4svyLg19ragPWT
 wNzDqFaQAhU8Gei/IssE4/9e1wvV6oqxAmsEBkdL8kNOLITH1EcN0O4FrGOKc8/wOjkr
 TRmP4nXM1p8T1Ka1YSViDYBdxmH0C0AJRz7vkOnq+euCucbdlrr3ko0sqfzNplul3GKi
 9H5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XaugCSxyFvz7DVjsYiuRee8p7K5mX9+DeG2e7gCVfec=;
 b=JC7R0KbIcbKvOliTzkvTmvhdY+DyF9Ye7OajkoQBbTdLqy/PJZ0pAems3t5w+ZfsJ2
 KjNvngrK83gEXIrgq2A4hSmveD+kuskEcHa/R5YC8TP7MUhdDFbDX+kliL7bS+NKZOZt
 EMLARcCqsHorgxPpqmsm+UhIgQDA5mTPzfpv/WGJ0ZuBBSVgBaypWeBbepX3M2GHEJd7
 0StDPQTkzXwp306D0YDzVHuAk5+mKS9Ejxp8QS1PwezKelBxu5R6ZRDzODy0Md8LMZMX
 kR7+vDImwrNOvCP17cid172dlHfGT5wjoIKsW4W4ZC9t+y5KJpW6QZin7/hqhSGHPeEF
 FFFg==
X-Gm-Message-State: AOAM531YxCX5LBYW1NrXS2Y2B9YtJVIil5rIM6a5SHO7TBOHkNhsds1o
 ZOWuRhRSd/gER25dehS0ExYdfQdg
X-Google-Smtp-Source: ABdhPJzOIhA0OdYFw5LLh9GbwAGnSFib+kojGL+2XaPefMdJqDTqkdFd3VR9MxXdb9tjgMPdIyJLqA==
X-Received: by 2002:a0c:99c7:: with SMTP id y7mr21815100qve.188.1591035597710; 
 Mon, 01 Jun 2020 11:19:57 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id r14sm15156760qke.62.2020.06.01.11.19.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:19:57 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 088/207] drm/amdgpu: add Sienna_Cichlid JPEG PG and CG support
Date: Mon,  1 Jun 2020 14:19:48 -0400
Message-Id: <20200601181949.1267800-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Liu <leo.liu@amd.com>

This is for static powergating and clockgating

Signed-off-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: James Zhu <James.Zhu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 129 +++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index af70aea0205c..2fc778cad91a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -214,6 +214,106 @@ static int jpeg_v3_0_resume(void *handle)
 	return r;
 }
 
+static void jpeg_v3_0_disable_clock_gating(struct amdgpu_device* adev)
+{
+	uint32_t data = 0;
+
+	data = RREG32_SOC15(JPEG, 0, mmJPEG_CGC_CTRL);
+	if (adev->cg_flags & AMD_CG_SUPPORT_JPEG_MGCG)
+		data |= 1 << JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	else
+		data &= ~JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+
+	data |= 1 << JPEG_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
+	data |= 4 << JPEG_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
+	WREG32_SOC15(JPEG, 0, mmJPEG_CGC_CTRL, data);
+
+	data = RREG32_SOC15(JPEG, 0, mmJPEG_CGC_GATE);
+	data &= ~(JPEG_CGC_GATE__JPEG_DEC_MASK
+		| JPEG_CGC_GATE__JPEG2_DEC_MASK
+		| JPEG_CGC_GATE__JPEG_ENC_MASK
+		| JPEG_CGC_GATE__JMCIF_MASK
+		| JPEG_CGC_GATE__JRBBM_MASK);
+	WREG32_SOC15(JPEG, 0, mmJPEG_CGC_GATE, data);
+
+	data = RREG32_SOC15(JPEG, 0, mmJPEG_CGC_CTRL);
+	data &= ~(JPEG_CGC_CTRL__JPEG_DEC_MODE_MASK
+		| JPEG_CGC_CTRL__JPEG2_DEC_MODE_MASK
+		| JPEG_CGC_CTRL__JMCIF_MODE_MASK
+		| JPEG_CGC_CTRL__JRBBM_MODE_MASK);
+	WREG32_SOC15(JPEG, 0, mmJPEG_CGC_CTRL, data);
+}
+
+static void jpeg_v3_0_enable_clock_gating(struct amdgpu_device* adev)
+{
+	uint32_t data = 0;
+
+	data = RREG32_SOC15(JPEG, 0, mmJPEG_CGC_GATE);
+	data |= (JPEG_CGC_GATE__JPEG_DEC_MASK
+		|JPEG_CGC_GATE__JPEG2_DEC_MASK
+		|JPEG_CGC_GATE__JPEG_ENC_MASK
+		|JPEG_CGC_GATE__JMCIF_MASK
+		|JPEG_CGC_GATE__JRBBM_MASK);
+	WREG32_SOC15(JPEG, 0, mmJPEG_CGC_GATE, data);
+}
+
+static int jpeg_v3_0_disable_static_power_gating(struct amdgpu_device *adev)
+{
+	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG) {
+		uint32_t data = 0;
+		int r = 0;
+
+		data = 1 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT;
+		WREG32(SOC15_REG_OFFSET(JPEG, 0, mmUVD_PGFSM_CONFIG), data);
+
+		SOC15_WAIT_ON_RREG(JPEG, 0,
+			mmUVD_PGFSM_STATUS, UVD_PGFSM_STATUS_UVDJ_PWR_ON,
+			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK, r);
+
+		if (r) {
+			DRM_ERROR("amdgpu: JPEG disable power gating failed\n");
+			return r;
+		}
+	}
+
+	/* disable anti hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, mmUVD_JPEG_POWER_STATUS), 0,
+		~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
+
+	/* keep the JPEG in static PG mode */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, mmUVD_JPEG_POWER_STATUS), 0,
+		~UVD_JPEG_POWER_STATUS__JPEG_PG_MODE_MASK);
+
+	return 0;
+}
+
+static int jpeg_v3_0_enable_static_power_gating(struct amdgpu_device* adev)
+{
+	/* enable anti hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, mmUVD_JPEG_POWER_STATUS),
+		UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
+		~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
+
+	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG) {
+		uint32_t data = 0;
+		int r = 0;
+
+		data = 2 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT;
+		WREG32(SOC15_REG_OFFSET(JPEG, 0, mmUVD_PGFSM_CONFIG), data);
+
+		SOC15_WAIT_ON_RREG(JPEG, 0, mmUVD_PGFSM_STATUS,
+			(2 << UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT),
+			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK, r);
+
+		if (r) {
+			DRM_ERROR("amdgpu: JPEG enable power gating failed\n");
+			return r;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * jpeg_v3_0_start - start JPEG block
  *
@@ -224,10 +324,19 @@ static int jpeg_v3_0_resume(void *handle)
 static int jpeg_v3_0_start(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring = &adev->jpeg.inst->ring_dec;
+	int r;
 
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_jpeg(adev, true);
 
+	/* disable power gating */
+	r = jpeg_v3_0_disable_static_power_gating(adev);
+	if (r)
+		return r;
+
+	/* JPEG disable CGC */
+	jpeg_v3_0_disable_clock_gating(adev);
+
 	/* MJPEG global tiling registers */
 	WREG32_SOC15(JPEG, 0, mmJPEG_DEC_GFX10_ADDR_CONFIG,
 		adev->gfx.config.gb_addr_config);
@@ -267,11 +376,20 @@ static int jpeg_v3_0_start(struct amdgpu_device *adev)
  */
 static int jpeg_v3_0_stop(struct amdgpu_device *adev)
 {
+	int r;
+
 	/* reset JMI */
 	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, mmUVD_JMI_CNTL),
 		UVD_JMI_CNTL__SOFT_RESET_MASK,
 		~UVD_JMI_CNTL__SOFT_RESET_MASK);
 
+	jpeg_v3_0_enable_clock_gating(adev);
+
+	/* enable power gating */
+	r = jpeg_v3_0_enable_static_power_gating(adev);
+	if (r)
+		return r;
+
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_jpeg(adev, false);
 
@@ -357,6 +475,17 @@ static int jpeg_v3_0_wait_for_idle(void *handle)
 static int jpeg_v3_0_set_clockgating_state(void *handle,
 					  enum amd_clockgating_state state)
 {
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
+
+	if (enable) {
+		if (jpeg_v3_0_is_idle(handle))
+			return -EBUSY;
+		jpeg_v3_0_enable_clock_gating(adev);
+	} else {
+		jpeg_v3_0_disable_clock_gating(adev);
+	}
+
 	return 0;
 }
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
