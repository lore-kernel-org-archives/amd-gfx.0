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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB90FC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 865A02073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tYryil6d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865A02073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48A6C6E357;
	Mon,  1 Jun 2020 18:22:33 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A948D6E358
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:31 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id c185so10009466qke.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XxuaFK/I1zuwrGBSgOOXB8SkyuzRXsLIaysejvpMOME=;
 b=tYryil6ds0NaKgCzqhGp7rCkRwnBmYFFoz240CUisOca93JxV9hvKs6Z0ltsz+tQNe
 HoaauH/iarGXICJdBxxUThIdEgif8tBeLrUMmFnJEVQoG1oe1BPVte598VCYJK8RXAu/
 z2vWtpfqZQf25e14NNTcAEYIvghJYF5UD6K2cDxjVXPAGYCfGSXCICHPLNtAMnohhcjb
 utBhXelWSz1vepmlLdKJ3kLtHA2rle6v539X6kvoLLRl2aDXblzPJvMtt3LJcy/dv8kd
 8pnFEKr67q7D1i7p5V52JEC36SUrmc/anSTQ6dwD4YT5v2SNl1sB8d1hRdItMjr7/Shn
 XBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XxuaFK/I1zuwrGBSgOOXB8SkyuzRXsLIaysejvpMOME=;
 b=mCvg95AQ32V8uKwTU+skdv/tslVVkCQUeyocTv7HyR1mqhRGYoROg/SucAYICOTc8+
 PXd+UT+LHP1xPqm5/9KRwnHtQ1+E6Sg4/AAzwPPvhimqnpMC4/CGqsa7uLelRsP3R1CU
 fe6tvfS/JRypGCZIlBaF62z9WMgV59SBImASWllNF6evFnVrz1CKxdUIouMJtGggxxHu
 92eXw5L1vZ2kGKvw+Hy3B3j3PnF8vYclG/EaRXSQPXYeu4ockM+f6tjukBGdIL0GieZq
 hYzKeFQSliVTH2aJjEM9OT1YwpKFIwedlTQejtc8f+9cvNgTHavXbwr9oyypf/4i6M76
 +WDQ==
X-Gm-Message-State: AOAM532yuILetiPoIvX9083Rjh3kRW3JqJ8Ir56v5wtlFKMS0EU0OdMT
 tABfyDyAf9svAqPagyOoXb2y0R8t
X-Google-Smtp-Source: ABdhPJwiTaljLGzt/XgSSnU2Gi39Nrv8ocyy6Bwq325qruVFeYD870+GGIChgKN9Gpq0+f1Zt68Hvg==
X-Received: by 2002:a37:6851:: with SMTP id d78mr20960096qkc.86.1591035750548; 
 Mon, 01 Jun 2020 11:22:30 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:30 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 156/207] drm/amd/powerplay: append pptable for sienna_cichlid
 (v2)
Date: Mon,  1 Jun 2020 14:20:03 -0400
Message-Id: <20200601182054.1267858-67-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Add function to append powerplay table from vbios for sienna_cichlid.

v2: squash in warning fix

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 8e3fe192e50a..5589838a2238 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -358,6 +358,107 @@ static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
 
 static int sienna_cichlid_append_powerplay_table(struct smu_context *smu)
 {
+	struct smu_table_context *table_context = &smu->smu_table;
+	PPTable_t *smc_pptable = table_context->driver_pptable;
+	struct atom_smc_dpm_info_v4_9 *smc_dpm_table;
+	int index, ret;
+	int i;
+
+	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
+					    smc_dpm_info);
+
+	ret = smu_get_atom_data_table(smu, index, NULL, NULL, NULL,
+				      (uint8_t **)&smc_dpm_table);
+	if (ret)
+		return ret;
+
+	memcpy(smc_pptable->I2cControllers, smc_dpm_table->I2cControllers,
+	       sizeof(I2cControllerConfig_t) * NUM_I2C_CONTROLLERS);
+
+	/* SVI2 Board Parameters */
+	smc_pptable->VddGfxVrMapping = smc_dpm_table->VddGfxVrMapping;
+	smc_pptable->VddSocVrMapping = smc_dpm_table->VddSocVrMapping;
+	smc_pptable->VddMem0VrMapping = smc_dpm_table->VddMem0VrMapping;
+	smc_pptable->VddMem1VrMapping = smc_dpm_table->VddMem1VrMapping;
+	smc_pptable->GfxUlvPhaseSheddingMask = smc_dpm_table->GfxUlvPhaseSheddingMask;
+	smc_pptable->SocUlvPhaseSheddingMask = smc_dpm_table->SocUlvPhaseSheddingMask;
+	smc_pptable->VddciUlvPhaseSheddingMask = smc_dpm_table->VddciUlvPhaseSheddingMask;
+	smc_pptable->MvddUlvPhaseSheddingMask = smc_dpm_table->MvddUlvPhaseSheddingMask;
+
+	/* Telemetry Settings */
+	smc_pptable->GfxMaxCurrent = smc_dpm_table->GfxMaxCurrent;
+	smc_pptable->GfxOffset = smc_dpm_table->GfxOffset;
+	smc_pptable->Padding_TelemetryGfx = smc_dpm_table->Padding_TelemetryGfx;
+	smc_pptable->SocMaxCurrent = smc_dpm_table->SocMaxCurrent;
+	smc_pptable->SocOffset = smc_dpm_table->SocOffset;
+	smc_pptable->Padding_TelemetrySoc = smc_dpm_table->Padding_TelemetrySoc;
+	smc_pptable->Mem0MaxCurrent = smc_dpm_table->Mem0MaxCurrent;
+	smc_pptable->Mem0Offset = smc_dpm_table->Mem0Offset;
+	smc_pptable->Padding_TelemetryMem0 = smc_dpm_table->Padding_TelemetryMem0;
+	smc_pptable->Mem1MaxCurrent = smc_dpm_table->Mem1MaxCurrent;
+	smc_pptable->Mem1Offset = smc_dpm_table->Mem1Offset;
+	smc_pptable->Padding_TelemetryMem1 = smc_dpm_table->Padding_TelemetryMem1;
+	smc_pptable->MvddRatio = smc_dpm_table->MvddRatio;
+
+	/* GPIO Settings */
+	smc_pptable->AcDcGpio = smc_dpm_table->AcDcGpio;
+	smc_pptable->AcDcPolarity = smc_dpm_table->AcDcPolarity;
+	smc_pptable->VR0HotGpio = smc_dpm_table->VR0HotGpio;
+	smc_pptable->VR0HotPolarity = smc_dpm_table->VR0HotPolarity;
+	smc_pptable->VR1HotGpio = smc_dpm_table->VR1HotGpio;
+	smc_pptable->VR1HotPolarity = smc_dpm_table->VR1HotPolarity;
+	smc_pptable->GthrGpio = smc_dpm_table->GthrGpio;
+	smc_pptable->GthrPolarity = smc_dpm_table->GthrPolarity;
+
+	/* LED Display Settings */
+	smc_pptable->LedPin0 = smc_dpm_table->LedPin0;
+	smc_pptable->LedPin1 = smc_dpm_table->LedPin1;
+	smc_pptable->LedPin2 = smc_dpm_table->LedPin2;
+	smc_pptable->LedEnableMask = smc_dpm_table->LedEnableMask;
+	smc_pptable->LedPcie = smc_dpm_table->LedPcie;
+	smc_pptable->LedError = smc_dpm_table->LedError;
+	smc_pptable->LedSpare1[0] = smc_dpm_table->LedSpare1[0];
+	smc_pptable->LedSpare1[1] = smc_dpm_table->LedSpare1[1];
+
+	/* GFXCLK PLL Spread Spectrum */
+	smc_pptable->PllGfxclkSpreadEnabled = smc_dpm_table->PllGfxclkSpreadEnabled;
+	smc_pptable->PllGfxclkSpreadPercent = smc_dpm_table->PllGfxclkSpreadPercent;
+	smc_pptable->PllGfxclkSpreadFreq = smc_dpm_table->PllGfxclkSpreadFreq;
+
+	/* GFXCLK DFLL Spread Spectrum */
+	smc_pptable->DfllGfxclkSpreadEnabled = smc_dpm_table->DfllGfxclkSpreadEnabled;
+	smc_pptable->DfllGfxclkSpreadPercent = smc_dpm_table->DfllGfxclkSpreadPercent;
+	smc_pptable->DfllGfxclkSpreadFreq = smc_dpm_table->DfllGfxclkSpreadFreq;
+
+	/* UCLK Spread Spectrum */
+	smc_pptable->UclkSpreadEnabled = smc_dpm_table->UclkSpreadEnabled;
+	smc_pptable->UclkSpreadPercent = smc_dpm_table->UclkSpreadPercent;
+	smc_pptable->UclkSpreadFreq = smc_dpm_table->UclkSpreadFreq;
+
+	/* FCLK Spred Spectrum */
+	smc_pptable->FclkSpreadEnabled = smc_dpm_table->FclkSpreadEnabled;
+	smc_pptable->FclkSpreadPercent = smc_dpm_table->FclkSpreadPercent;
+	smc_pptable->FclkSpreadFreq = smc_dpm_table->FclkSpreadFreq;
+
+	/* Memory Config */
+	smc_pptable->MemoryChannelEnabled = smc_dpm_table->MemoryChannelEnabled;
+	smc_pptable->DramBitWidth = smc_dpm_table->DramBitWidth;
+	smc_pptable->PaddingMem1[0] = smc_dpm_table->PaddingMem1[0];
+	smc_pptable->PaddingMem1[1] = smc_dpm_table->PaddingMem1[1];
+	smc_pptable->PaddingMem1[2] = smc_dpm_table->PaddingMem1[2];
+
+	/* Total board power */
+	smc_pptable->TotalBoardPower = smc_dpm_table->TotalBoardPower;
+	smc_pptable->BoardPowerPadding = smc_dpm_table->BoardPowerPadding;
+
+	/* XGMI Training */
+	for (i = 0; i < NUM_XGMI_PSTATE_LEVELS; i++) {
+		smc_pptable->XgmiLinkSpeed[i] = smc_dpm_table->XgmiLinkSpeed[i];
+		smc_pptable->XgmiLinkWidth[i] = smc_dpm_table->XgmiLinkWidth[i];
+		smc_pptable->XgmiFclkFreq[i] = smc_dpm_table->XgmiFclkFreq[i];
+		smc_pptable->XgmiSocVoltage[i] = smc_dpm_table->XgmiSocVoltage[i];
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
