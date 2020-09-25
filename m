Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BFAC4727E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B1EC2399A
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tdA4WMkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1EC2399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D90A46ED71;
	Fri, 25 Sep 2020 20:11:32 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA7206ED71
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:31 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id w12so4115504qki.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=j61W1sTbqYsB7ON9dxz4Cue+l1AXPGYY6eAujRL/xxQ=;
 b=tdA4WMkdDPFu6SZ058IL35fwVedNXjr46UZpUY7FChjwwK1BTe/LbKTobdANbtBPld
 4ecg/w8EBxNQsaY4T9qExddXaoVNYExkVmrZgqwTFUSsNm9U244IMMr1xd02oFxAAAcT
 jXdMmFkQTjyXdbl+d1D+xaPQukTx60Wc69WtoJqsmaDyqyznmKTHOxWTZJI5KRsB3wP3
 S8Esg9KL8/pywvj71s4qPCpwaIcY8Qib8SpH6tpttANZmtxCCE+4KngNcKMRTqoloFTv
 JXXiB9kZtc7b+8LTTdkqnRFG1hzhvekWobSPPbdG32b0UZwERPqnc59VFaA5ivtkmxCx
 5xyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j61W1sTbqYsB7ON9dxz4Cue+l1AXPGYY6eAujRL/xxQ=;
 b=aQjaGzv1iCCDGbw0RlZlnhaDeazRNsib9pV6zzYXzSff9mbm/ghC2xEq1R4//FyzND
 D8QLSJ9eh256PJOH22oHpqC1u3IEBacyvvoVy+wftYycsjafRBdLMjtEYGaHE3yXarkW
 13rriokW1CigaeF0hSyPqySNBq+b95tQzvvits560ZSDF+DVCNRDiTtAalUr8C1BL0v4
 VnKhExNF2dc15lba+/Ce/hKz13Xpzb0l91xNPV3n5LMyNsruCKVcvHLCdXzi2OWNSryR
 mEd3NCfoKgyi+MmySDD1NOrd/4BBW02PkDwTlc5rHhQktlaSk+jbl9yxnCinimSEwj6K
 7KJQ==
X-Gm-Message-State: AOAM532Dqeh82sPB2p5oqkELpmp6jfaFzL/m/WdRHkTpFZV+mBmygVNE
 Yqmdj130Y93pHJLwpUniYRApRnlqjGE=
X-Google-Smtp-Source: ABdhPJyccLayYUKa2/2c0rGSaVJInHjNV2DF4cCxcaTpFTqjvYkgPl7qoIYGwJrAd+wiEZNud/ryfw==
X-Received: by 2002:a05:620a:39a:: with SMTP id
 q26mr1780947qkm.305.1601064690882; 
 Fri, 25 Sep 2020 13:11:30 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:30 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 26/45] drm/amdgpu/powerplay: add new smu messages and feature
 masks for vangogh (v2)
Date: Fri, 25 Sep 2020 16:10:10 -0400
Message-Id: <20200925201029.1738724-26-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200925201029.1738724-1-alexander.deucher@amd.com>
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Kevin Wang <kevin1.wang@amd.com>,
 Huang Rui <ray.huang@amd.com>, Xiaojian Du <xiaojian.du@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaojian Du <xiaojian.du@amd.com>

This patch is to add new smu messages and feature masks for vangogh.

v2: squash in updates and typo fixes

Signed-off-by: Xiaojian Du <xiaojian.du@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_types.h | 53 +++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index 35fc46d3c9c0..b1a18fbb7682 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -35,6 +35,7 @@
        __SMU_DUMMY_MAP(EnableSmuFeaturesHigh),        \
        __SMU_DUMMY_MAP(DisableSmuFeaturesLow),        \
        __SMU_DUMMY_MAP(DisableSmuFeaturesHigh),       \
+       __SMU_DUMMY_MAP(GetEnabledSmuFeatures),	      \
        __SMU_DUMMY_MAP(GetEnabledSmuFeaturesLow),     \
        __SMU_DUMMY_MAP(GetEnabledSmuFeaturesHigh),    \
        __SMU_DUMMY_MAP(SetWorkloadMask),              \
@@ -122,7 +123,7 @@
        __SMU_DUMMY_MAP(GetVoltageByDpm),              \
        __SMU_DUMMY_MAP(GetVoltageByDpmOverdrive),     \
        __SMU_DUMMY_MAP(PowerUpVcn0),                  \
-       __SMU_DUMMY_MAP(PowerDownVcn0),               \
+       __SMU_DUMMY_MAP(PowerDownVcn0),                \
        __SMU_DUMMY_MAP(PowerUpVcn1),                  \
        __SMU_DUMMY_MAP(PowerDownVcn1),                \
        __SMU_DUMMY_MAP(PowerUpGfx),                   \
@@ -165,18 +166,24 @@
 	__SMU_DUMMY_MAP(GpuChangeState),              \
 	__SMU_DUMMY_MAP(SetPowerLimitPercentage),     \
 	__SMU_DUMMY_MAP(ForceGfxContentSave),         \
-	__SMU_DUMMY_MAP(EnableTmdp48MHzRefclkPwrDown), \
+	__SMU_DUMMY_MAP(EnableTmdp48MHzRefclkPwrDown),\
 	__SMU_DUMMY_MAP(PowerGateAtHub),              \
 	__SMU_DUMMY_MAP(SetSoftMinJpeg),              \
 	__SMU_DUMMY_MAP(SetHardMinFclkByFreq),        \
-	__SMU_DUMMY_MAP(DFCstateControl), \
-	__SMU_DUMMY_MAP(GmiPwrDnControl), \
-	__SMU_DUMMY_MAP(DAL_DISABLE_DUMMY_PSTATE_CHANGE), \
+	__SMU_DUMMY_MAP(DFCstateControl),             \
+	__SMU_DUMMY_MAP(GmiPwrDnControl),              \
+	__SMU_DUMMY_MAP(DAL_DISABLE_DUMMY_PSTATE_CHANGE),\
 	__SMU_DUMMY_MAP(DAL_ENABLE_DUMMY_PSTATE_CHANGE), \
 	__SMU_DUMMY_MAP(SET_DRIVER_DUMMY_TABLE_DRAM_ADDR_HIGH), \
 	__SMU_DUMMY_MAP(SET_DRIVER_DUMMY_TABLE_DRAM_ADDR_LOW), \
 	__SMU_DUMMY_MAP(GET_UMC_FW_WA), \
 	__SMU_DUMMY_MAP(Mode1Reset), \
+	__SMU_DUMMY_MAP(Spare),                          \
+	__SMU_DUMMY_MAP(SetHardMinIspiclkByFreq),        \
+	__SMU_DUMMY_MAP(SetHardMinIspxclkByFreq),        \
+	__SMU_DUMMY_MAP(SetSoftMinSocclkByFreq),         \
+	__SMU_DUMMY_MAP(PowerUpCvip),                    \
+	__SMU_DUMMY_MAP(PowerDownCvip),                  \
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
@@ -265,7 +272,41 @@ enum smu_clk_type {
        __SMU_DUMMY_MAP(ATHUB_PG),                      	\
        __SMU_DUMMY_MAP(APCC_DFLL),                     	\
        __SMU_DUMMY_MAP(DPM_GFX_GPO),                    \
-       __SMU_DUMMY_MAP(WAFL_CG),
+       __SMU_DUMMY_MAP(WAFL_CG),                        \
+       __SMU_DUMMY_MAP(CCLK_DPM),                     	\
+       __SMU_DUMMY_MAP(FAN_CONTROLLER),                 \
+       __SMU_DUMMY_MAP(VCN_DPM),                     	\
+       __SMU_DUMMY_MAP(FCLK_DPM),                     	\
+       __SMU_DUMMY_MAP(SOCCLK_DPM),                     \
+       __SMU_DUMMY_MAP(MP0CLK_DPM),                     \
+       __SMU_DUMMY_MAP(LCLK_DPM),                     	\
+       __SMU_DUMMY_MAP(SHUBCLK_DPM),                    \
+       __SMU_DUMMY_MAP(DCFCLK_DPM),                     \
+       __SMU_DUMMY_MAP(GFX_DPM),                     	\
+       __SMU_DUMMY_MAP(DS_DCFCLK),                     	\
+       __SMU_DUMMY_MAP(S0I2),                     	\
+       __SMU_DUMMY_MAP(SMU_LOW_POWER),                  \
+       __SMU_DUMMY_MAP(GFX_DEM),                        \
+       __SMU_DUMMY_MAP(PSI),                     	\
+       __SMU_DUMMY_MAP(PROCHOT),                        \
+       __SMU_DUMMY_MAP(CPUOFF),                     	\
+       __SMU_DUMMY_MAP(STAPM),                          \
+       __SMU_DUMMY_MAP(S0I3),                     	\
+       __SMU_DUMMY_MAP(DF_CSTATES),                     \
+       __SMU_DUMMY_MAP(PERF_LIMIT),                     \
+       __SMU_DUMMY_MAP(CORE_DLDO),                     	\
+       __SMU_DUMMY_MAP(RSMU_LOW_POWER),                 \
+       __SMU_DUMMY_MAP(SMN_LOW_POWER),                  \
+       __SMU_DUMMY_MAP(THM_LOW_POWER),                  \
+       __SMU_DUMMY_MAP(SMUIO_LOW_POWER),                \
+       __SMU_DUMMY_MAP(MP1_LOW_POWER),                  \
+       __SMU_DUMMY_MAP(DS_VCN),                         \
+       __SMU_DUMMY_MAP(CPPC),                           \
+       __SMU_DUMMY_MAP(OS_CSTATES),                     \
+       __SMU_DUMMY_MAP(ISP_DPM),                        \
+       __SMU_DUMMY_MAP(A55_DPM),                        \
+       __SMU_DUMMY_MAP(CVIP_DSP_DPM),                   \
+       __SMU_DUMMY_MAP(MSMU_LOW_POWER),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(feature)	SMU_FEATURE_##feature##_BIT
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
