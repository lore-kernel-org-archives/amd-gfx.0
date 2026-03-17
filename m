Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695B6FD707A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 20:13:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10F5A10E48F;
	Tue, 17 Mar 2026 20:13:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e3b/mMYa";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F9E110E647
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 20:13:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRkIuNv5d6OvQP5C71ByMegS0Jopuz7QmwXzeFftWODrYpNNCki256/6+hRaRicqmewl/tTOhPnw/br9WQGqcGqWMOdN9hieEUdIqEDZywUv3nfRm1++GFTfz1jnscAekRCeZDaia4rT6D3z5RjTaH/NE18AgaCMQLQWpMEXvKYucG7P0HoKVgTjXed1MKDfO7OoGb04aSM2Uzngo8f7AjK5QW5Eurf9KSKnhsilH0GaeMg7L2yVeA0iVcYAUrb1Z9B2Ve7fMKbcpD8HvVe/HERTJMHIZOT/i4T0i6O/Rd+XOxHI+DU8Oqn1xwMv8j7FGziZAgR4qFURd2AMVLfr0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rREVsXmsNoFcaRraFjy1sz2xcw4vBAsWAHo1+7KFiKE=;
 b=ZheYMdID/3V4lF6g0yk9NkStHdLZPD0wAZQWulbtntIO7TPbqV9oUt9XiY6RiQNZcAdwEFNG8MD39qMiwYgJyvr7D5qWnQIi2yANG0NGTfr+eBNztHpdYAK7z4q8HNH4bjyvNjXyxALS7WdzqXH8zr34R5+xycCLAzSYDdWbPdgxhTa7c9znvXKFgw+1MyZAt8bF1/dVrZIgCnN6YstwOgL6BI0oUK3+BHR8JdH34cIT1MYDCP7K0E4pSJE4IWKJD0B501mdTiLY6Vl7EFjWhJq9eDaqQhrULwdFEVX7y8A1K/hTw0R+EOofR76rL1dN1mxfSiQpFahb6PGLRNJ1Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rREVsXmsNoFcaRraFjy1sz2xcw4vBAsWAHo1+7KFiKE=;
 b=e3b/mMYa5mUMovGbU89LlYfYdCb2/QjLffHto09GB7z4mPR1BP6qmSXz+IrITai1p2i3U49JcpPMD3H2BNChNMrQqs1IQrn1ZOaPV+fOHVOahvtzCbcz9ScYBzN4JxUfSrmqUjLAYhMyqQYxPyTXGR1wDtDAEKCxHK70Gvm2sNQ=
Received: from BY1P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::16)
 by SJ1PR12MB6076.namprd12.prod.outlook.com (2603:10b6:a03:45d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 20:13:12 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::fa) by BY1P220CA0021.outlook.office365.com
 (2603:10b6:a03:5c3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 20:13:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 20:13:12 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 15:13:01 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 13:13:01 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 15:13:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 09/25] drm/amd/pm: Add default dpm table support for smu 15.0.8
Date: Tue, 17 Mar 2026 16:12:25 -0400
Message-ID: <20260317201242.3808136-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317201242.3808136-1-alexander.deucher@amd.com>
References: <20260317201242.3808136-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|SJ1PR12MB6076:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f72e32b-63b4-4127-04e5-08de84619da4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: KYFZvSXiNAJ7vFhj/iqFtn3vlI5fyrEE27yuv49sZFrA0QUgiBOrWWL3+YVpTAEASg18FYBR7uy5qRsvh11sIaRG3AGKBDOxMZJnZLekABH7OwB+PBNP8KrurRe8lB9+U6MKX8AnSzFswTQZID6TR46OY9T3DiadNSQ/hlMf66Ut7VJRqeMliqUrtT8igTNk29hJSdD1pzDx8pFzP4Z9CNJEyh/spCi28XbHnjdau/O5Qwqr1w7SuOwcmuFuAJvpmBH5/8QGp3mOphlf8Tzqw7urRfJzAWeatuBD59u4NLJEBy1vsbLZdEoBihzHzYqc+g6d0cbWQOnDAJJjYDwrQiRwRGEZVKohnPygV1eHV97pQ1UJ+gACePyai2eupeqxGXTxK9/SVfUItoPorE9OIVRMJc2BBGITXHiYUk2uhdrc+XmAQ0KcqDlJyk7BMZqf9dfmVCfBr/If2sJuWNKpI5dx+vFFCJIiQmjBRRSTqlCZQf4/e/k1Dt695xorqO6HCU+hPWbWFRvBeEV7nf6JxbxImmtSZ84OfLj5WBw3dWsENJocjOdvYOklJFv8hC0GhBXMUKFR5KiEhADpjPeXQGRKKAl2az4/X8hzafQwGNDLSD4g20k7e80uuI2NqdHoBuBGmvuGpz771YBpS4yS0wMF2PB5Hhle2fTNk+Gqfjb2dh7x9Ao4A/VerQ40myB1LHZvWvDYbazfYRGLq+bG8Tu6Mh9AQP88gqAo1X7TiWB0hwvu+gz6DugWaiSFYhuiSv64nQdou9jBHGFEhWUICQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZNfG8VeNLoYTa2hZIvOQTcHusqiiJlpnhoKnexytQgHo/+A5gR72umhsgIjv+/9HTdns8ge8v9EarsPR2drG6g8f+Ynsus21QWCyXUu1VnhXf0qrF9uvx3vB2hNH3/aT1csMgZnqqExaz24jyO/Sj0Wn+cczgRWre0w8Mx8eVuTsVYTCHpTu5hrr6rLDlGYbCDPhrU3N5RoryFRkCMYK3nBblMjNUlTa5CmuH9x2fXL4hc1gD8i/jp8UHcECAgwuQs+RhO6SF5EtYNSt5Zk/GovZKSMBKp8qE5pEVwbKOuGV8eE0JBOSQuc8heph8/RaKit2jt6URiONF9hUhtIYt3tgJcttB2jk8M5otcClYGLMV40CzmPj9YxzmkFO2xzZUI8kr0tU710TszX6Lv/pFowoLZzzNqlACRE8DHjnW6Btz4v7uwUYCu+v6upHp2cC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 20:13:12.3392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f72e32b-63b4-4127-04e5-08de84619da4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6076
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

From: Asad Kamal <asad.kamal@amd.com>

Add default dpm table support for smu 15.0.8

v2: Remove lclk, move pptable check up, add missing clk (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   1 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h  |   1 +
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 211 ++++++++++++++++++
 3 files changed, 213 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 5f77749998e32..d4801a5ebc30c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -339,6 +339,7 @@ enum smu_clk_type {
 	SMU_OD_FAN_MINIMUM_PWM,
 	SMU_OD_FAN_ZERO_RPM_ENABLE,
 	SMU_OD_FAN_ZERO_RPM_STOP_TEMP,
+	SMU_GL2CLK,
 	SMU_CLK_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
index 3c8c086f0f9d8..e6fd8be2cc4a0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
@@ -81,6 +81,7 @@ struct smu_15_0_dpm_tables {
 	struct smu_dpm_table        phy_table;
 	struct smu_dpm_table        fclk_table;
 	struct smu_pcie_table       pcie_table;
+	struct smu_dpm_table        gl2_table;
 };
 
 struct smu_15_0_dpm_context {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 82b09fe7fccd5..149421b1c6cbf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -263,6 +263,212 @@ static int smu_v15_0_8_init_allowed_features(struct smu_context *smu)
 	return 0;
 }
 
+static int smu_v15_0_8_get_dpm_ultimate_freq(struct smu_context *smu,
+					     enum smu_clk_type clk_type,
+					     uint32_t *min, uint32_t *max)
+{
+	struct smu_15_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+	struct smu_table_context *smu_table = &smu->smu_table;
+	PPTable_t *pptable = (PPTable_t *)smu_table->driver_pptable;
+	struct smu_dpm_table *dpm_table;
+	uint32_t min_clk = 0, max_clk = 0;
+
+	if (!pptable->init)
+		return -EINVAL;
+
+	/* Try cached DPM tables first */
+	if (dpm_context) {
+		switch (clk_type) {
+		case SMU_MCLK:
+		case SMU_UCLK:
+			dpm_table = &dpm_context->dpm_tables.uclk_table;
+			break;
+		case SMU_GFXCLK:
+		case SMU_SCLK:
+			dpm_table = &dpm_context->dpm_tables.gfx_table;
+			break;
+		case SMU_SOCCLK:
+			dpm_table = &dpm_context->dpm_tables.soc_table;
+			break;
+		case SMU_FCLK:
+			dpm_table = &dpm_context->dpm_tables.fclk_table;
+			break;
+		case SMU_GL2CLK:
+			dpm_table = &dpm_context->dpm_tables.gl2_table;
+			break;
+		case SMU_VCLK:
+			dpm_table = &dpm_context->dpm_tables.vclk_table;
+			break;
+		case SMU_DCLK:
+			dpm_table = &dpm_context->dpm_tables.dclk_table;
+			break;
+		default:
+			dpm_table = NULL;
+			break;
+		}
+
+		if (dpm_table && dpm_table->count > 0) {
+			min_clk = SMU_DPM_TABLE_MIN(dpm_table);
+			max_clk = SMU_DPM_TABLE_MAX(dpm_table);
+
+			if (min_clk && max_clk) {
+				if (min)
+					*min = min_clk;
+				if (max)
+					*max = max_clk;
+				return 0;
+			}
+		}
+	}
+
+	/* Fall back to pptable */
+	switch (clk_type) {
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+		min_clk = pptable->MinGfxclkFrequency;
+		max_clk = pptable->MaxGfxclkFrequency;
+		break;
+	case SMU_FCLK:
+		min_clk = pptable->MinFclkFrequency;
+		max_clk = pptable->MaxFclkFrequency;
+		break;
+	case SMU_GL2CLK:
+		min_clk = pptable->MinGl2clkFrequency;
+		max_clk = pptable->MaxGl2clkFrequency;
+		break;
+	case SMU_MCLK:
+	case SMU_UCLK:
+		min_clk = pptable->UclkFrequencyTable[0];
+		max_clk = pptable->UclkFrequencyTable[ARRAY_SIZE(pptable->UclkFrequencyTable) - 1];
+		break;
+	case SMU_SOCCLK:
+		min_clk = pptable->SocclkFrequency;
+		max_clk = pptable->SocclkFrequency;
+		break;
+	case SMU_VCLK:
+		min_clk = pptable->VclkFrequency;
+		max_clk = pptable->VclkFrequency;
+		break;
+	case SMU_DCLK:
+		min_clk = pptable->DclkFrequency;
+		max_clk = pptable->DclkFrequency;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (min)
+		*min = min_clk;
+	if (max)
+		*max = max_clk;
+
+	return 0;
+}
+
+static int smu_v15_0_8_set_dpm_table(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_15_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+	struct smu_dpm_table *dpm_table;
+	PPTable_t *pptable = (PPTable_t *)smu_table->driver_pptable;
+	int i, ret;
+	uint32_t gfxclkmin, gfxclkmax;
+
+	/* gfxclk dpm table setup - fine-grained */
+	dpm_table = &dpm_context->dpm_tables.gfx_table;
+	dpm_table->clk_type = SMU_GFXCLK;
+	dpm_table->flags = SMU_DPM_TABLE_FINE_GRAINED;
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT)) {
+		ret = smu_v15_0_8_get_dpm_ultimate_freq(smu, SMU_GFXCLK,
+							&gfxclkmin, &gfxclkmax);
+		if (ret)
+			return ret;
+
+		dpm_table->count = 2;
+		dpm_table->dpm_levels[0].value = gfxclkmin;
+		dpm_table->dpm_levels[0].enabled = true;
+		dpm_table->dpm_levels[1].value = gfxclkmax;
+		dpm_table->dpm_levels[1].enabled = true;
+	} else {
+		dpm_table->count = 1;
+		dpm_table->dpm_levels[0].value = pptable->MinGfxclkFrequency;
+		dpm_table->dpm_levels[0].enabled = true;
+	}
+
+	/* fclk dpm table setup - fine-grained */
+	dpm_table = &dpm_context->dpm_tables.fclk_table;
+	dpm_table->clk_type = SMU_FCLK;
+	dpm_table->flags = SMU_DPM_TABLE_FINE_GRAINED;
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_FCLK_BIT)) {
+		dpm_table->count = 2;
+		dpm_table->dpm_levels[0].value = pptable->MinFclkFrequency;
+		dpm_table->dpm_levels[0].enabled = true;
+		dpm_table->dpm_levels[1].value = pptable->MaxFclkFrequency;
+		dpm_table->dpm_levels[1].enabled = true;
+	} else {
+		dpm_table->count = 1;
+		dpm_table->dpm_levels[0].value = pptable->MinFclkFrequency;
+		dpm_table->dpm_levels[0].enabled = true;
+	}
+
+	/* gl2clk dpm table setup - fine-grained */
+	dpm_table = &dpm_context->dpm_tables.gl2_table;
+	dpm_table->flags = SMU_DPM_TABLE_FINE_GRAINED;
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GL2CLK_BIT)) {
+		dpm_table->count = 2;
+		dpm_table->dpm_levels[0].value = pptable->MinGl2clkFrequency;
+		dpm_table->dpm_levels[0].enabled = true;
+		dpm_table->dpm_levels[1].value = pptable->MaxGl2clkFrequency;
+		dpm_table->dpm_levels[1].enabled = true;
+	} else {
+		dpm_table->count = 1;
+		dpm_table->dpm_levels[0].value = pptable->MinGl2clkFrequency;
+		dpm_table->dpm_levels[0].enabled = true;
+	}
+
+	/* uclk dpm table setup - discrete levels */
+	dpm_table = &dpm_context->dpm_tables.uclk_table;
+	dpm_table->clk_type = SMU_UCLK;
+	dpm_table->flags = 0;
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
+		dpm_table->count = ARRAY_SIZE(pptable->UclkFrequencyTable);
+		for (i = 0; i < dpm_table->count; ++i) {
+			dpm_table->dpm_levels[i].value = pptable->UclkFrequencyTable[i];
+			dpm_table->dpm_levels[i].enabled = true;
+		}
+	} else {
+		dpm_table->count = 1;
+		dpm_table->dpm_levels[0].value = pptable->UclkFrequencyTable[0];
+		dpm_table->dpm_levels[0].enabled = true;
+	}
+
+	/* socclk dpm table setup - single boot-time value */
+	dpm_table = &dpm_context->dpm_tables.soc_table;
+	dpm_table->clk_type = SMU_SOCCLK;
+	dpm_table->flags = 0;
+	dpm_table->count = 1;
+	dpm_table->dpm_levels[0].value = pptable->SocclkFrequency;
+	dpm_table->dpm_levels[0].enabled = true;
+
+	/* vclk dpm table setup - single boot-time value */
+	dpm_table = &dpm_context->dpm_tables.vclk_table;
+	dpm_table->clk_type = SMU_VCLK;
+	dpm_table->flags = 0;
+	dpm_table->count = 1;
+	dpm_table->dpm_levels[0].value = pptable->VclkFrequency;
+	dpm_table->dpm_levels[0].enabled = true;
+
+	/* dclk dpm table setup - single boot-time value */
+	dpm_table = &dpm_context->dpm_tables.dclk_table;
+	dpm_table->clk_type = SMU_DCLK;
+	dpm_table->flags = 0;
+	dpm_table->count = 1;
+	dpm_table->dpm_levels[0].value = pptable->DclkFrequency;
+	dpm_table->dpm_levels[0].enabled = true;
+
+	return 0;
+}
+
 static int smu_v15_0_8_setup_pptable(struct smu_context *smu)
 {
 	struct smu_table_context *table_context = &smu->smu_table;
@@ -455,6 +661,10 @@ static int smu_v15_0_8_set_default_dpm_table(struct smu_context *smu)
 	if (ret)
 		return ret;
 
+	ret = smu_v15_0_8_set_dpm_table(smu);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -714,6 +924,7 @@ static const struct pptable_funcs smu_v15_0_8_ppt_funcs = {
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.wait_for_event = smu_v15_0_wait_for_event,
 	.mode2_reset = smu_v15_0_8_mode2_reset,
+	.get_dpm_ultimate_freq = smu_v15_0_8_get_dpm_ultimate_freq,
 };
 
 static void smu_v15_0_8_init_msg_ctl(struct smu_context *smu,
-- 
2.53.0

