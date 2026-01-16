Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B1DD4A60D
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jan 2026 08:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4593B10E82F;
	Fri, 16 Jan 2026 08:02:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ENigbdhj";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AE4210E824
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 08:02:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLSE1ZKdEjUyum0K8NG/5bHOXnhP09pP6hXJ6O5p81ckPWCtw3c/Jqd97GPHRhuz+izzERkOs4UaTXugcMEQH82BjffPpRkCGQAYvXwtd/XwGvDHP4piY03dG9FApdjiTo8tQX8JN9ViQrR0LM0ZBKum4VaWNWxbTsTQOFLyf8NHNorbcj9w+9wEyikd999wbiyfFDJHNINvNUlExsBp54au+43/r3sWeoY+PT8uY9ypQoDQoaCqDZodG8Yb5SGS3GCOhcUA+rEgWEv26B1Y+V63lNHTVLgJ01i44yix4VQRXsbM6J23PKp+wGAcXg1TWQZoOqNEKxk0qqLsbBNfxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/MWi5Xd/IhCLKryknnOfZkZLeYWxv396DFE6dOUY6E=;
 b=qiEJwUg6bYoQviYJ8Xdeazmpy4FvElPrTv7QmlZJXEgn/GmBQeLUxdx1ogCISJj1Cfd38douyrCHOZOcgE4zr6ZQWpXZC3ybM6W29YUvNIe5oNpR37w3cFMdf8Aq3nx1TNtHfc25FwV3mEA0VHJPc17w1xFr62WSXaewe38vv6s0tFsCXb9ZLP+nO1YePGqxnT6eZ27xHSADnIObXjWh0ifo7F0y5NlTIXpeP3h4r2xY/+sKBs8jSJeTFMrredwrUap9UdLzsteFUXqE6zl5ZBlYZ6iL/WyB34BqyVb3OQxv76Oe712tDXOrAGPU6gx4qTrsLhZ+Koth7jLkbTdLVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/MWi5Xd/IhCLKryknnOfZkZLeYWxv396DFE6dOUY6E=;
 b=ENigbdhjuziC87q0SW6huCGF8Fdpma2Iai8qSpXeVm3+8t/ZhAiVyej4Gq49riHNG9yQ7M0ZR59/3zWVo3yDeWumCQZgcU8huoVJdIuEgPcHaYOQDsGqaI8pCiK6U6d2oZqPLwRVVvdQyoRKbvp4vQEJ0LWQ5bzoy8BnMzw/ktI=
Received: from PH8PR02CA0013.namprd02.prod.outlook.com (2603:10b6:510:2d0::14)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 08:02:39 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:510:2d0:cafe::7e) by PH8PR02CA0013.outlook.office365.com
 (2603:10b6:510:2d0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.7 via Frontend Transport; Fri,
 16 Jan 2026 08:02:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.0 via Frontend Transport; Fri, 16 Jan 2026 08:02:37 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 02:02:35 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: initialize the smu dpm table by pptable on smu
 14.0.2
Date: Fri, 16 Jan 2026 16:02:23 +0800
Message-ID: <20260116080223.3014638-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|MN2PR12MB4470:EE_
X-MS-Office365-Filtering-Correlation-Id: b4f48a33-03e1-48d1-7a18-08de54d59d19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b2XNGiZ71gsbKkRUazNWJnyUpRqWARmM1RVQAgzY9g66Cu5+C1Q/h+4cRWf9?=
 =?us-ascii?Q?haMWjKhF0WBnNNsbLXIxgzk0Rld3SJTEYEd72vGKehJhOnrN3Z654zrJjrhF?=
 =?us-ascii?Q?8S1xJRDp8dsOr8SAWzoTT6txiJaK+EPCe2YceMTk1O/+i5PFRCfticYn+BPC?=
 =?us-ascii?Q?1sOAg1VlftShMVgOQXRkiCS4f8Gm3Kaz1AB16mTYhCvltPWqmCwrnyX+fLdK?=
 =?us-ascii?Q?v2DT4+BopaqpwI67i06Y74/Q2x3WdBGQ0XrQt+yZFBTDrVZ9Mc6JaInrcn69?=
 =?us-ascii?Q?c1WPui/9+9nAVNqqymO3xSAFcbTQRaFKrobFrXkgCby9L1vFb/XE+88NKOVG?=
 =?us-ascii?Q?/bohvco9vO9BQh8uCA6mpghSJ4jpHgS7u9HC1KSuySCZQ9B0z7bvsMTjrtgU?=
 =?us-ascii?Q?9Q7Kj4Q9klPDkl8DQkEkCnD4T60tJ8BC6UT+/SfDHNd6uq+9evveiluo8cV6?=
 =?us-ascii?Q?waquC83KrEKFMilxEqZWWVxJ2y8HiSfQ8hNsUD9mIIGOLTM/25gIgHD2hQUs?=
 =?us-ascii?Q?dB/C4a8SqGRMPAmj6fJQIMoJ/Jxo1G5VE0zVukbSnbD9Nc638jfk3BmtTLAV?=
 =?us-ascii?Q?4Q7lCSeXpacyFu3fB5SrqDEHOeN0lIii0kjVObDOJlDdVATh5rB03smagQlg?=
 =?us-ascii?Q?VqNlt5BR8CJ4585SSRa784BzKhYus7UskFfD690+bwMpEr++M2I5EJgUGbMp?=
 =?us-ascii?Q?C+lKSifxRxGZic0oBXXrEbnKnZFuM5OF6taQwQVpssJgDLozCGW9Kb2PA5mR?=
 =?us-ascii?Q?tQRfTtUUoL2w37k0YsX2muHa1m7SNmmLPVUc6cC30UUKT6km4oVLCTKCRwUo?=
 =?us-ascii?Q?Qr+ONLF4o2X6neqXIAyy0Qihin9RuDnx5vTu9PKQYXgrRGyZXoXJ0EqugRUq?=
 =?us-ascii?Q?06jxjnIPGS9yNP0qi3inqSZMCXxoQoOLqOpjT6p+OWsSvG5k5Kh3mopQ1Ckx?=
 =?us-ascii?Q?iVyOYvX9XolyURNoUUWe3ebwCgcaKW63BvFpOtPd9j2ip06ph6zvOdcOeIMD?=
 =?us-ascii?Q?MldpirB1Wico7/diMN9/etruGjmICcx0lyYjtHRP+bu37iNae3F3O1jAMJeD?=
 =?us-ascii?Q?exya02ep7dA9ZliDOVZNCszMEjnmLj3vWOws23H6EKnWsspW4iVTUpbQm+6E?=
 =?us-ascii?Q?Y6riQYafGOa44lw16P2AQzab1bW4D6X7+CKUw9s8kswllezK/Xqd0git2413?=
 =?us-ascii?Q?5InJkrPfnBYGuBfDYYrRwMJ1G5DutJ2BWfJhAsYdMQJav58e5RFMxnueK+7s?=
 =?us-ascii?Q?a4E6wNpVFgSoNF+lUylVs2CT2TDPOLzeA/1ySYcZ/S2LOUdtmHS1MD6QqBSf?=
 =?us-ascii?Q?w40nJU+YbUDIzf3k9QP6Xj/s74eciE15LsUPv3IvhLtFraQuTrvyE98cEXws?=
 =?us-ascii?Q?GfqsfNgR9Y/qX9BeGnHzKfBywDswv4COzv4sRLz729xtdswo1xSpcI8WJ988?=
 =?us-ascii?Q?P0/qHWfLd9qndKQVZID+49v7xT+3xof1fncAPrjQq2apAkVgflcEPYqA2NgT?=
 =?us-ascii?Q?1Y8aEZAdt4t3HnP+P6v+tmXtIQbfVx05ZGICFXMFAhk8KErYFLLAeg/0pj9I?=
 =?us-ascii?Q?L3kcxXxWcYGgSUQmW29tqpwWsF2YEW7pyQ8QoTGIP5+eG2zcKtLOu+11uZo7?=
 =?us-ascii?Q?km9elCH+IoGXAe/7+BM1ygT1ZPBtR3pX004VU6vfiVE0OuAaqpDd4aNHys7x?=
 =?us-ascii?Q?uemKDQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 08:02:37.2858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f48a33-03e1-48d1-7a18-08de54d59d19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
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

Use PPTable to initialize the dpm table to avoid loss of frequency precision
when using SMU message PPSMC_MSG_GetDpmFreqByIndex.

e.g: uclk dpm on smu 14.0.2
- by SMU MSG: 96, 456, 772, 875, 1124, 1258
- by PPTable: 97, 457, 773, 875, 1125, 1259

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 112 ++++++++++++++----
 1 file changed, 91 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index faae1da81bd4..03246455d727 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -497,6 +497,76 @@ static int smu_v14_0_2_init_smc_tables(struct smu_context *smu)
 	return smu_v14_0_init_smc_tables(smu);
 }
 
+static int smu_v14_0_2_set_dpm_table(struct smu_context *smu,
+				     enum smu_clk_type clk_type,
+				     struct smu_dpm_table *dpm_table,
+				     DpmDescriptor_t *dpm_desc, uint16_t *freqtable)
+{
+	int i;
+
+	for (i = 0; i < dpm_desc->NumDiscreteLevels; i++) {
+		dpm_table->dpm_levels[i].enabled = true;
+		dpm_table->dpm_levels[i].value = freqtable[i];
+	}
+
+	dpm_table->count = dpm_desc->NumDiscreteLevels;
+	dpm_table->clk_type = clk_type;
+	if (!dpm_desc->SnapToDiscrete)
+		dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
+
+	return 0;
+}
+
+static int smu_v14_0_2_set_dpm_table_by_pptable(struct smu_context *smu,
+						enum smu_clk_type clk_type,
+						struct smu_dpm_table *dpm_table)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	PPTable_t *pptable = table_context->driver_pptable;
+	SkuTable_t *skutable = &pptable->SkuTable;
+	DpmDescriptor_t *dpm_desc;
+	uint16_t *freqtable;
+
+	switch (clk_type) {
+	case SMU_SCLK:
+	case SMU_GFXCLK:
+		dpm_desc = &skutable->DpmDescriptor[PPCLK_GFXCLK];
+		freqtable = skutable->FreqTableGfx;
+		break;
+	case SMU_SOCCLK:
+		dpm_desc = &skutable->DpmDescriptor[PPCLK_SOCCLK];
+		freqtable = skutable->FreqTableSocclk;
+		break;
+	case SMU_UCLK:
+	case SMU_MCLK:
+		dpm_desc = &skutable->DpmDescriptor[PPCLK_UCLK];
+		freqtable = skutable->FreqTableUclk;
+		break;
+	case SMU_FCLK:
+		dpm_desc = &skutable->DpmDescriptor[PPCLK_FCLK];
+		freqtable = skutable->FreqTableFclk;
+		break;
+	case SMU_VCLK:
+		dpm_desc = &skutable->DpmDescriptor[PPCLK_VCLK_0];
+		freqtable = skutable->FreqTableVclk;
+		break;
+	case SMU_DCLK:
+		dpm_desc = &skutable->DpmDescriptor[PPCLK_DCLK_0];
+		freqtable = skutable->FreqTableDclk;
+		break;
+	case SMU_DCEFCLK:
+		dpm_desc = &skutable->DpmDescriptor[PPCLK_DCFCLK];
+		freqtable = skutable->FreqTableDcfclk;
+		break;
+	default:
+		dev_dbg(smu->adev->dev, "[%s] Unsupported smu clock type: %d!",
+			__func__, clk_type);
+		return -EINVAL;
+	}
+
+	return smu_v14_0_2_set_dpm_table(smu, clk_type, dpm_table, dpm_desc, freqtable);
+}
+
 static int smu_v14_0_2_set_default_dpm_table(struct smu_context *smu)
 {
 	struct smu_14_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
@@ -510,9 +580,9 @@ static int smu_v14_0_2_set_default_dpm_table(struct smu_context *smu)
 	dpm_table = &dpm_context->dpm_tables.soc_table;
 	dpm_table->clk_type = SMU_SOCCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
-		ret = smu_v14_0_set_single_dpm_table(smu,
-						     SMU_SOCCLK,
-						     dpm_table);
+		ret = smu_v14_0_2_set_dpm_table_by_pptable(smu,
+							   SMU_SOCCLK,
+							   dpm_table);
 		if (ret)
 			return ret;
 	} else {
@@ -525,9 +595,9 @@ static int smu_v14_0_2_set_default_dpm_table(struct smu_context *smu)
 	dpm_table = &dpm_context->dpm_tables.gfx_table;
 	dpm_table->clk_type = SMU_GFXCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT)) {
-		ret = smu_v14_0_set_single_dpm_table(smu,
-						     SMU_GFXCLK,
-						     dpm_table);
+		ret = smu_v14_0_2_set_dpm_table_by_pptable(smu,
+							   SMU_GFXCLK,
+							   dpm_table);
 		if (ret)
 			return ret;
 
@@ -556,9 +626,9 @@ static int smu_v14_0_2_set_default_dpm_table(struct smu_context *smu)
 	dpm_table = &dpm_context->dpm_tables.uclk_table;
 	dpm_table->clk_type = SMU_UCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
-		ret = smu_v14_0_set_single_dpm_table(smu,
-						     SMU_UCLK,
-						     dpm_table);
+		ret = smu_v14_0_2_set_dpm_table_by_pptable(smu,
+							   SMU_UCLK,
+							   dpm_table);
 		if (ret)
 			return ret;
 	} else {
@@ -571,9 +641,9 @@ static int smu_v14_0_2_set_default_dpm_table(struct smu_context *smu)
 	dpm_table = &dpm_context->dpm_tables.fclk_table;
 	dpm_table->clk_type = SMU_FCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_FCLK_BIT)) {
-		ret = smu_v14_0_set_single_dpm_table(smu,
-						     SMU_FCLK,
-						     dpm_table);
+		ret = smu_v14_0_2_set_dpm_table_by_pptable(smu,
+							   SMU_FCLK,
+							   dpm_table);
 		if (ret)
 			return ret;
 	} else {
@@ -586,9 +656,9 @@ static int smu_v14_0_2_set_default_dpm_table(struct smu_context *smu)
 	dpm_table = &dpm_context->dpm_tables.vclk_table;
 	dpm_table->clk_type = SMU_VCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_VCLK_BIT)) {
-		ret = smu_v14_0_set_single_dpm_table(smu,
-						     SMU_VCLK,
-						     dpm_table);
+		ret = smu_v14_0_2_set_dpm_table_by_pptable(smu,
+							   SMU_VCLK,
+							   dpm_table);
 		if (ret)
 			return ret;
 	} else {
@@ -601,9 +671,9 @@ static int smu_v14_0_2_set_default_dpm_table(struct smu_context *smu)
 	dpm_table = &dpm_context->dpm_tables.dclk_table;
 	dpm_table->clk_type = SMU_DCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCLK_BIT)) {
-		ret = smu_v14_0_set_single_dpm_table(smu,
-						     SMU_DCLK,
-						     dpm_table);
+		ret = smu_v14_0_2_set_dpm_table_by_pptable(smu,
+							   SMU_DCLK,
+							   dpm_table);
 		if (ret)
 			return ret;
 	} else {
@@ -616,9 +686,9 @@ static int smu_v14_0_2_set_default_dpm_table(struct smu_context *smu)
 	dpm_table = &dpm_context->dpm_tables.dcef_table;
 	dpm_table->clk_type = SMU_DCEFCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCN_BIT)) {
-		ret = smu_v14_0_set_single_dpm_table(smu,
-						     SMU_DCEFCLK,
-						     dpm_table);
+		ret = smu_v14_0_2_set_dpm_table_by_pptable(smu,
+							   SMU_DCEFCLK,
+							   dpm_table);
 		if (ret)
 			return ret;
 	} else {
-- 
2.34.1

