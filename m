Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BD0C3ABD8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 May 2025 09:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01FF510EA0F;
	Fri, 16 May 2025 09:19:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l+kAn2Ns";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F37A10EA0D
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 09:19:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IeaKsHNSQ75P4+6085lq/q8uU0yLE8CRPpqPrVjFqLEJcCZiGQ0MTltu4zATM2plcB/Px4AlHMbNufUhXcboSLowzY4PZjRjAu8QNdNtq8Nv6Ksn9wxt4eMclOQIhAlEp9G5eKPoT79Fed9fygGxQFW7s06UrLEB28jvtxdKsreB+oDEU1jUFJR/qavvG8cVGJuuEMQYGcAkcsKlvuH2XO64q6zIPcdGeAYnkCCO3z7jAlRAobbQuQBUl+SZdvF9IGXaTlrQT3bsXzrGATamlmfGBej2CQdX2NYtV5U0MokfWqfbD5bfb9w0yfp2F9fT4GulMxnOYwHTnc/9zH1pCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+nQRUGCAhX/Rapbm5tnZzgcanEe9sTWVwwfs5B1RMs=;
 b=VcjZL7fJp1Jkjf8W8ojUmisa2wvaQkNAjxXoQR+ac/cBRGOvQF7CLNFb+QcvArC61jfNyqH61P4jul0vGFiicnIr1D8BaELKA7hbwreExGAJ6OpQpLCnpPbNLER/7JGIjauvqZJezoA6za3En5RUaf3ZiBPI/sIPdPRlL+2+8e8lsF7LrWpooxNYs01RaEKEazO5xFNRjBr572iJl0NVZIgaxSyn33mkjHuAjevza3r7eXSZ39L7B1w3RCkUwfqL/Xvyur08/3IHEFsAtRRtygNFpqzqlmKBT/uWuDxn4ZoFmcMREY1kKvJvCG82G/bx0j9Bv2tR7hG25mysSBK4xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+nQRUGCAhX/Rapbm5tnZzgcanEe9sTWVwwfs5B1RMs=;
 b=l+kAn2Ns4Zr++HJR6Bk0tw3L85OtjSNu6mL8FqHQuGkpVezH3fBjyYL6QIQ82dxPMZfnsi3eGGQ07OuIQ6r9G0w3TfeB98ow5ZWxbwhELnEN3jMPp2t6l+UjIKSK+xc1zDXbZbVj9gU7dMzCEecH+tL1pHzvw/UM22b13NGcUac=
Received: from CH2PR05CA0033.namprd05.prod.outlook.com (2603:10b6:610::46) by
 PH8PR12MB8608.namprd12.prod.outlook.com (2603:10b6:510:1bc::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.29; Fri, 16 May 2025 09:19:25 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:0:cafe::e8) by CH2PR05CA0033.outlook.office365.com
 (2603:10b6:610::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.10 via Frontend Transport; Fri,
 16 May 2025 09:19:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 16 May 2025 09:19:24 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 May
 2025 04:19:15 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, Asad Kamal <asad.kamal@amd.com>
Subject: [PATCH 4/4] drm/amd/pm: Fetch partition metrics on SMUv13.0.12
Date: Fri, 16 May 2025 14:48:52 +0530
Message-ID: <20250516091852.447786-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250516091852.447786-1-lijo.lazar@amd.com>
References: <20250516091852.447786-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|PH8PR12MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f6e375-859f-4675-dd35-08dd945ac033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?knUrwm/3+OuKoPwU0AMA8wPzLo9vzG1nh3dzvgjI7KpG/lhV0f+G6cxfDqq5?=
 =?us-ascii?Q?reUXYwEiTK4g+xRUJ5L75bw047+MfP/FUIgkf39ghLQevcx86YNAW153DXrc?=
 =?us-ascii?Q?33esxXUauScw468a6jOTwCnkR0KFCToIkp38g4945TqvfwCaLUFDWhXc9+fc?=
 =?us-ascii?Q?gZstGeLVaLhYXT1oisdc1V627QKQqTHJ5GdIytw6/e7Els3UJ2exIWHegLJk?=
 =?us-ascii?Q?AtcLi48tbYwWhgvtnokeWA0nUTEoIZQzzQUBFhVbymtQtXmXWIdyW277CsT4?=
 =?us-ascii?Q?KrBHwp3rJvgBhvyZzj6HHxfKnOUMjmsIfNNlnMiwbPHUwT44kvbyrv1/LlhA?=
 =?us-ascii?Q?cw/zzDXOt2soH+hMoFQuZTWHQ3HaSMmjrLEVuEDpV/BO8k7plOfsTU24l5rm?=
 =?us-ascii?Q?cryAl2f74JIPriBbFhBfBojZUWSrhjDnn9nleqjgOFfKx1Mf8Cven530qGBH?=
 =?us-ascii?Q?22QUSJ/Swx/zfMx9bdp/AyFtsX9PsMVuVMlxNFq2HzC1E87kJiTPSsOL2a0H?=
 =?us-ascii?Q?Fp7YAWogrJxOlRKRIhQ1dZYc7pCwhLTVFzFfbs62J23M03PdqyQprU7XAY3b?=
 =?us-ascii?Q?BRM5tkL0adSdQIkDiuLdEZP8HncDKPqbiSIQlhBZ/ItIXInvnKTuWodj2Khl?=
 =?us-ascii?Q?/JjOm6RS2ylenVSW0Mi+507eHiG2L+kM5bijInkyX34HoOINbNgUtBhVTt3C?=
 =?us-ascii?Q?yhjSU6LAqiJ5u/o3ymT0veJPpiQmKaZEi53ocALHSkuToLUIqgv0UijSpmBz?=
 =?us-ascii?Q?T5TDtCttkuEzEUl23jZcwPe9AE0Fj2omVkS8hgEmUMQl31R+/XgcZmd6bVrp?=
 =?us-ascii?Q?nXU62u1nqDnkxeexU5SK6gwbVpCQ5rVgby6/RZ+ya858eoWjbcYzZHAPloiS?=
 =?us-ascii?Q?QEL/yHJ5myGoklZLHOpAEqlELmyOQodLooxZtyuXSm/lSVDbJ1ETFzgUFOmX?=
 =?us-ascii?Q?rV7VYRMtoV3BoytbpEh7X3zBlux4emRgV6S6Sq08JKHxsTMLRXmxU3qXDTA8?=
 =?us-ascii?Q?xteDcWvj4cg/1PsloDDwBUwGc3XstXPuLVeL9Vxt0fjqUqKmJ8bnL+O9YA6n?=
 =?us-ascii?Q?V7qhpq+0gr0mH5ZGIsFegFQn5pgzFTFDBpBf0NleJwRtg3iqW9k9PlIMGlQ4?=
 =?us-ascii?Q?yY7p4BeYjibhUnew/603HCPMCnvEzO6mcxGTiEd6QKX8Cs+DKQSd7TWuoEAA?=
 =?us-ascii?Q?ZcvgqcwL2H199BxdKvrPDHQBAXJZY1h0uW9cVTf3NzrmNZ1SsTuAoFgerpZU?=
 =?us-ascii?Q?ZcsADEvxIKt6wb4UYZMLCO8+3vmuU/7zUwsmEPuhk7WAfF7lQawA/J6xQBfe?=
 =?us-ascii?Q?0aCydyvPz63+cizBi6cgnEdeXD4PLWc9i6qHEf5wvpwf1sdaiwxU+nlRMHy6?=
 =?us-ascii?Q?ZeQP+Q+iUk0ReJLD80RUCzg/ZNsWsET8B41EPisB0CJij19kGPHySnGqTJxi?=
 =?us-ascii?Q?gCOwkWNn656FDFA4U+oljCQSX15d3uk8rV2rOn+D4oXloplpZIQujccYRjMg?=
 =?us-ascii?Q?f/amIhTEdKLqeQ7NyZSXeLuQnGYIHzS1ppbb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 09:19:24.8521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f6e375-859f-4675-dd35-08dd945ac033
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8608
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

Add support to fetch compute partition related metrics in SMUv13.0.12 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 56 +++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  9 +++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  |  3 +
 3 files changed, 68 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 533d58e57d05..ac172b21f803 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -322,6 +322,62 @@ int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
 	return ret;
 }
 
+ssize_t smu_v13_0_12_get_xcp_metrics(struct smu_context *smu, struct amdgpu_xcp *xcp, void *table, void *smu_metrics)
+{
+	const u8 num_jpeg_rings = NUM_JPEG_RINGS_FW;
+	struct amdgpu_partition_metrics_v1_0 *xcp_metrics;
+	struct amdgpu_device *adev = smu->adev;
+	MetricsTable_t *metrics;
+	int inst, j, k, idx;
+	u32 inst_mask;
+
+	metrics = (MetricsTable_t *)smu_metrics;
+	xcp_metrics = (struct amdgpu_partition_metrics_v1_0 *) table;
+	smu_cmn_init_partition_metrics(xcp_metrics, 1, 0);
+	amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
+	idx = 0;
+	for_each_inst(k, inst_mask) {
+		/* Both JPEG and VCN has same instance */
+		inst = GET_INST(VCN, k);
+		for (j = 0; j < num_jpeg_rings; ++j) {
+			xcp_metrics->jpeg_busy[(idx * num_jpeg_rings) + j] =
+				SMUQ10_ROUND(metrics->
+					JpegBusy[(inst * num_jpeg_rings) + j]);
+		}
+		xcp_metrics->vcn_busy[idx] =
+			SMUQ10_ROUND(metrics->VcnBusy[inst]);
+		xcp_metrics->current_vclk0[idx] = SMUQ10_ROUND(
+			metrics->VclkFrequency[inst]);
+		xcp_metrics->current_dclk0[idx] = SMUQ10_ROUND(
+			metrics->DclkFrequency[inst]);
+		xcp_metrics->current_socclk[idx] = SMUQ10_ROUND(
+			metrics->SocclkFrequency[inst]);
+
+		idx++;
+	}
+
+	xcp_metrics->current_uclk =
+		SMUQ10_ROUND(metrics->UclkFrequency);
+
+	amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &inst_mask);
+	idx = 0;
+	for_each_inst(k, inst_mask) {
+		inst = GET_INST(GC, k);
+		xcp_metrics->current_gfxclk[idx] = SMUQ10_ROUND(metrics->GfxclkFrequency[inst]);
+		xcp_metrics->gfx_busy_inst[idx] = SMUQ10_ROUND(metrics->GfxBusy[inst]);
+		xcp_metrics->gfx_busy_acc[idx] = SMUQ10_ROUND(metrics->GfxBusyAcc[inst]);
+		if (smu_v13_0_6_cap_supported(smu, SMU_CAP(HST_LIMIT_METRICS))) {
+			xcp_metrics->gfx_below_host_limit_ppt_acc[idx] = SMUQ10_ROUND(metrics->GfxclkBelowHostLimitPptAcc[inst]);
+			xcp_metrics->gfx_below_host_limit_thm_acc[idx] = SMUQ10_ROUND(metrics->GfxclkBelowHostLimitThmAcc[inst]);
+			xcp_metrics->gfx_low_utilization_acc[idx] = SMUQ10_ROUND(metrics->GfxclkLowUtilizationAcc[inst]);
+			xcp_metrics->gfx_below_host_limit_total_acc[idx] = SMUQ10_ROUND(metrics->GfxclkBelowHostLimitTotalAcc[inst]);
+		}
+		idx++;
+	}
+
+	return sizeof(*xcp_metrics);
+}
+
 ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index b0997dd8e40b..5a7870c6d8e2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2596,6 +2596,14 @@ static ssize_t smu_v13_0_6_get_xcp_metrics(struct smu_context *smu, int xcp_id,
 		kfree(metrics_v0);
 		return ret;
 	}
+
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) ==
+		    IP_VERSION(13, 0, 12) &&
+	    smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS))) {
+		ret = smu_v13_0_12_get_xcp_metrics(smu, xcp, table, metrics_v0);
+		goto out;
+	}
+
 	metrics_v1 = (MetricsTableV1_t *)metrics_v0;
 	metrics_v2 = (MetricsTableV2_t *)metrics_v0;
 
@@ -2665,6 +2673,7 @@ static ssize_t smu_v13_0_6_get_xcp_metrics(struct smu_context *smu, int xcp_id,
 			idx++;
 		}
 	}
+out:
 	kfree(metrics_v0);
 
 	return sizeof(*xcp_metrics);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 1ccc150882eb..1a54675c576f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -81,6 +81,9 @@ int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu);
 int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
 				      MetricsMember_t member, uint32_t *value);
 ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table);
+ssize_t smu_v13_0_12_get_xcp_metrics(struct smu_context *smu,
+				     struct amdgpu_xcp *xcp, void *table,
+				     void *smu_metrics);
 extern const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[];
 extern const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[];
 #endif
-- 
2.25.1

