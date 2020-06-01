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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A047C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F7982073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUC0+4EH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7982073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 342336E340;
	Mon,  1 Jun 2020 18:22:16 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE2D76E340
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:15 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id k22so8471808qtm.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UXHOxcIJmbAOnb/jwRZNAbAnz6nau0dmg5xvAGrszxM=;
 b=KUC0+4EHa2cWgOxwkZQ/V+HOP1K6wYFRngZMecaJ5qPIEHQ1C2XdYTZfBqkM8t0fX3
 qF4S2W7oGMMdmhDvUAwktvoyb0MqDCpGHMO4Nm6AQXntdSEUDmHY29YOgz4lH/WAO9wg
 CckdibuDD6HGMNQDADOYVag+u+DtEsInSl9YR8G3W2ybLPgIYFQx1DHuFuNqVlcuQtdv
 4p43pMVOcHVKLRMCcMNWfIQMwjJ0suGo8P0qYU/rioyd+r+ZLCGnfS9KS7saMhCIN2DX
 JAovUxjbvnTKgrQpQ34p+9b45V/aKEcWIc8S87vg8XYGAxKUc7ZX6COhL2I4y0YmBPES
 5FoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UXHOxcIJmbAOnb/jwRZNAbAnz6nau0dmg5xvAGrszxM=;
 b=Lg30x4uLPcOPmqgd6KFf397KfJN8dgnMphSPm+/lwONEeLCtE8bYx4SKKeBDczNsN6
 YdCfXsYTussr5YAqH723KKaNOVJAEJSCh79hlIVCspZOGfSBY8e89f5XK1gmtdQTj8UC
 MThypX3kVedZZ5AmTYMgtiyH5ZaY0sz2hQrGzJZiwH73cVJ3EEBqrB5+qj8TbE9q1wAH
 5+FVN7qdT2cXYqhAYa1b4mENIKMRPdgkta3+ewSfQJohdmaE7REn2DOZUpnWZ42Sxods
 0A1g81COrzy+dyZTnRsRGyz4qG5H/ULucJdSz2ipYue+whq493Sc+IBK0zSLvQRBCUzk
 mj4A==
X-Gm-Message-State: AOAM533t/7RIxZw1/HIGWFVveNWiAtDu8c5y5CRwfWZs8fN4QTvPbloo
 Bizipl3TXSIp1Otp+5SU3awPi8ps
X-Google-Smtp-Source: ABdhPJyWTog/09Yq9urquo7qW8a/LAV8ao0/Na7xMpUurO0Jggk7JQUErLL44D8Hxx0n+Z4Clpy+7Q==
X-Received: by 2002:ac8:32dc:: with SMTP id a28mr15947279qtb.158.1591035734832; 
 Mon, 01 Jun 2020 11:22:14 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:14 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 144/207] drm/amdgpu: add pause DPG mode for VCN3.0
Date: Mon,  1 Jun 2020 14:19:51 -0400
Message-Id: <20200601182054.1267858-55-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
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
 Boyuan Zhang <boyuan.zhang@amd.com>, James Zhu <james.zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Boyuan Zhang <boyuan.zhang@amd.com>

Add vcn_v3_0_pause_dpg_mode to pause/unpause DPG mode for VCN3.0

V2: update description.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Reviewed-by: James Zhu <james.zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 66 +++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index c1aaa9423f5d..f47136d9bfe8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -53,6 +53,8 @@ static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v3_0_set_powergating_state(void *handle,
 			enum amd_powergating_state state);
+static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
+			int inst_idx, struct dpg_pause_state *new_state);
 
 static int amdgpu_ih_clientid_vcns[] = {
 	SOC15_IH_CLIENTID_VCN,
@@ -189,6 +191,9 @@ static int vcn_v3_0_sw_init(void *handle)
 		}
 	}
 
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
+		adev->vcn.pause_dpg_mode = vcn_v3_0_pause_dpg_mode;
+
 	return 0;
 }
 
@@ -1232,6 +1237,67 @@ static int vcn_v3_0_stop(struct amdgpu_device *adev)
 	return 0;
 }
 
+static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
+		   int inst_idx, struct dpg_pause_state *new_state)
+{
+	struct amdgpu_ring *ring;
+	uint32_t reg_data = 0;
+	int ret_code;
+
+	/* pause/unpause if state is changed */
+	if (adev->vcn.inst[inst_idx].pause_state.fw_based != new_state->fw_based) {
+		DRM_DEBUG("dpg pause state changed %d -> %d",
+			adev->vcn.inst[inst_idx].pause_state.fw_based,	new_state->fw_based);
+		reg_data = RREG32_SOC15(VCN, inst_idx, mmUVD_DPG_PAUSE) &
+			(~UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
+
+		if (new_state->fw_based == VCN_DPG_STATE__PAUSE) {
+			ret_code = 0;
+			SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 0x1,
+				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
+
+			if (!ret_code) {
+				/* pause DPG */
+				reg_data |= UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
+				WREG32_SOC15(VCN, inst_idx, mmUVD_DPG_PAUSE, reg_data);
+
+				/* wait for ACK */
+				SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_DPG_PAUSE,
+					UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK,
+					UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK, ret_code);
+
+				/* Restore */
+				ring = &adev->vcn.inst[inst_idx].ring_enc[0];
+				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_BASE_LO, ring->gpu_addr);
+				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
+				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_SIZE, ring->ring_size / 4);
+				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
+				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
+
+				ring = &adev->vcn.inst[inst_idx].ring_enc[1];
+				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_BASE_LO2, ring->gpu_addr);
+				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
+				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_SIZE2, ring->ring_size / 4);
+				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
+				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
+
+				WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_WPTR,
+					RREG32_SOC15(VCN, inst_idx, mmUVD_SCRATCH2) & 0x7FFFFFFF);
+
+				SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS,
+					UVD_PGFSM_CONFIG__UVDM_UVDU_PWR_ON, UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
+			}
+		} else {
+			/* unpause dpg, no need to wait */
+			reg_data &= ~UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
+			WREG32_SOC15(VCN, inst_idx, mmUVD_DPG_PAUSE, reg_data);
+		}
+		adev->vcn.inst[inst_idx].pause_state.fw_based = new_state->fw_based;
+	}
+
+	return 0;
+}
+
 /**
  * vcn_v3_0_dec_ring_get_rptr - get read pointer
  *
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
