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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0B5C433E2
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22DE821508
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oj9TQ7mC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DE821508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C81596E26F;
	Mon,  1 Jun 2020 18:03:42 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C4F56E286
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:41 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id c14so8915879qka.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9eTunRPepr9YGDRAynb6dpVupFAeSkTSAakKJjdnLRU=;
 b=oj9TQ7mCSYn1QqifPQ2SFUjU9MJn1TdvTI7lbDzMZRzC3cM/rLc+Xs6kHrW7xAxHpE
 ngWVbzM5beHJbPqFtytuKNf2m7qyNLyeFY0C93WrqIsNaxxqCRdwm15qRj08fFeJ4Oc7
 KWSGXrjOcXAL70fAcsM3TC5vl2MjFQk4rCEze/xftqcUZ9lVy/DXJuYm6UQgoDGyHaMm
 1PkHPWDApuirlDcVIhGDVYn9B74B9xEcDYxTdKZJX7pwXWHXC9L6HGqxyelBmpGLgh0Y
 BhQJaEbwUs+odWs7Pz/RU9qUUmZdzPLJ3ICQUzynmb6FP6rK5aZAXJ7BYRJB6+74WL9P
 XFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9eTunRPepr9YGDRAynb6dpVupFAeSkTSAakKJjdnLRU=;
 b=jRgCx0zqA2SOoChG+6xZLwc1OL6HhkakVhjOSI1vHrg3nmZF8iBGSd6264h8gZaKCq
 VPMdrjcn8WgU5PhL8rnFGiX3QFjvLFrasyrOgyhmOjdPmUBKh1/wnmVu5t9m9HhRBHsf
 03Rk8/gAtT1xZa64WoSFitUO79QJAm+usXkkTzHvlQ71R3q66sunjDbVvPGGi3T3HWvh
 KlziGL+GX94xziVBdYAs9gQdmrnhH6FsMTvIKiEmFDi0Gf2/daOGY1aTS/8vQDhzMuz6
 Pb06WhwmRvUGw4So4bto5uA5lxE8ZJbJw1ydodO3ZpMTzXDJCt6lRewHjKnuMbgcbi3o
 l21A==
X-Gm-Message-State: AOAM533zfxoWVKYSjm3GjU3vlu+fV+OKUnp1dM0seco6kThtu6LeOe0Y
 htxWrPW7Ua4nYiTHyF0XAvv8TBi2
X-Google-Smtp-Source: ABdhPJyFkgzpLgt9Vy+1k/zIdsL6rWHNdh0tSdvAxV6/BrxEBJ874l6T3OdDlZwK8ME6ncUogsMSFA==
X-Received: by 2002:a05:620a:2287:: with SMTP id
 o7mr20490294qkh.238.1591034620239; 
 Mon, 01 Jun 2020 11:03:40 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:39 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 037/207] drm/amd/powerplay: support pcie value set and update
 for sienna_cichlid
Date: Mon,  1 Jun 2020 13:59:49 -0400
Message-Id: <20200601180239.1267430-34-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
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

Add support to set default pcie parameters for sienna_cichlid.
Add support to update pcie parameters for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 852c364fd7a3..5b4319b0da6c 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -407,6 +407,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 	struct smu_table_context *table_context = &smu->smu_table;
 	struct smu_11_0_dpm_context *dpm_context = smu_dpm->dpm_context;
 	PPTable_t *driver_ppt = NULL;
+	int i;
 
         driver_ppt = table_context->driver_pptable;
 
@@ -437,6 +438,11 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
         dpm_context->dpm_tables.phy_table.min = driver_ppt->FreqTablePhyclk[0];
         dpm_context->dpm_tables.phy_table.max = driver_ppt->FreqTablePhyclk[NUM_PHYCLK_DPM_LEVELS - 1];
 
+	for (i = 0; i < MAX_PCIE_CONF; i++) {
+		dpm_context->dpm_tables.pcie_table.pcie_gen[i] = driver_ppt->PcieGenSpeed[i];
+		dpm_context->dpm_tables.pcie_table.pcie_lane[i] = driver_ppt->PcieLaneCount[i];
+	}
+
 	return 0;
 }
 
@@ -1430,6 +1436,41 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu,
 	return 0;
 }
 
+static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
+					 uint32_t pcie_gen_cap,
+					 uint32_t pcie_width_cap)
+{
+	PPTable_t *pptable = smu->smu_table.driver_pptable;
+	int ret, i;
+	uint32_t smu_pcie_arg;
+
+	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
+	struct smu_11_0_dpm_context *dpm_context = smu_dpm->dpm_context;
+
+	for (i = 0; i < NUM_LINK_LEVELS; i++) {
+		smu_pcie_arg = (i << 16) |
+			((pptable->PcieGenSpeed[i] <= pcie_gen_cap) ?
+					(pptable->PcieGenSpeed[i] << 8) :
+					(pcie_gen_cap << 8)) |
+			((pptable->PcieLaneCount[i] <= pcie_width_cap) ?
+					pptable->PcieLaneCount[i] :
+					pcie_width_cap);
+
+		ret = smu_send_smc_msg_with_param(smu,
+						  SMU_MSG_OverridePcieParameters,
+						  smu_pcie_arg, NULL);
+		if (ret)
+			return ret;
+
+		if (pptable->PcieGenSpeed[i] > pcie_gen_cap)
+			dpm_context->dpm_tables.pcie_table.pcie_gen[i] = pcie_gen_cap;
+		if (pptable->PcieLaneCount[i] > pcie_width_cap)
+			dpm_context->dpm_tables.pcie_table.pcie_lane[i] = pcie_width_cap;
+	}
+
+	return 0;
+}
+
 static void sienna_cichlid_dump_pptable(struct smu_context *smu)
 {
 	struct smu_table_context *table_context = &smu->smu_table;
@@ -2134,6 +2175,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_thermal_temperature_range = sienna_cichlid_get_thermal_temperature_range,
 	.display_disable_memory_clock_switch = sienna_cichlid_display_disable_memory_clock_switch,
 	.get_power_limit = sienna_cichlid_get_power_limit,
+	.update_pcie_parameters = sienna_cichlid_update_pcie_parameters,
 	.dump_pptable = sienna_cichlid_dump_pptable,
 	.init_microcode = smu_v11_0_init_microcode,
 	.load_microcode = smu_v11_0_load_microcode,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
