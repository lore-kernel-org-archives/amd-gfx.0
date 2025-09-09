Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C15CAC587
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 05:50:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1042110E611;
	Tue,  9 Sep 2025 05:50:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OV7PuX6P";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 668A810E611
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 05:50:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmS+f7mMz4fkJ6X7IWXZUazLHJY2XkCNx+6ZkxAztRp3Wk5EFtZWhLiugST9q36JUqZclSfBM5iObZXcfCY1+kiNEcTefsN1SwRpotTqmutTb3jdnKp9JpxoaArJUkh+gKSfh8tLsXfBh+ppJXNtLP7z50vYfEWaAZBpLq7loTETy2zdTm4FCtS3oGYuiUzNBUaXoDaHsiZSpaU6I8JegZZB4x50neGx8PGh8tXQUxsEHlsIf3oK9Z3UjiI1eZYiLh0fiOUGXkSoCdp3iwhrqtCA/dxJMomWboop5UTI7JYYGeiDCPOd01g2JXsI+kTp29JEA1UUha+TnXfDEI0myQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKpNThBteXDfNviJkoichfI95hITAEe+SEOi5vcuZTU=;
 b=vkQ3s/z00Nk1n9fuoqXpU5NaXhm6wYtU8mZ+I904sI4tR4q4O1Hrq4N/krE9o3bLSZIOq/fzwuynG8t2k1VQWKObdHs8wFRdL0XhVHVDDTX8Y1cFsTtQciw4fUx5Se4xrmPIf5/Upu3NXgLRIfAZb3/h1sQe4+63w8N0amHAUE+LfxuHGE/wxRW1jyp8quqjFuK+RQcKMlUG/OlhqhcCfj7O1G619uGKwfKWDwInhcC88YsXiF4mi51rPtPnlUI6LhW6R5NvPnoSByg+n8sCf3fQlit2l5QO5/s9lMJoJ0EHgu24muQbCn/Zqguqmv2HyUZl/1zHwgkEYUbeo2p0bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKpNThBteXDfNviJkoichfI95hITAEe+SEOi5vcuZTU=;
 b=OV7PuX6PBNiYxOWkjBFczfYpSowJUX3fYw9UrsBzinyISqxKfpQAhv4IJEgzQj9P1QsYN/C8QmXnqrkh1zg9VC4AMIQb0QBKbAbquhMDeY6uEdWLILzwaRO11Anenl4cGcwopUzd0DYV9hfMMfS1SjIC1b/Y9T7OTTUtFDbPV8U=
Received: from BN8PR03CA0012.namprd03.prod.outlook.com (2603:10b6:408:94::25)
 by SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 05:50:11 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:94:cafe::71) by BN8PR03CA0012.outlook.office365.com
 (2603:10b6:408:94::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Tue,
 9 Sep 2025 05:50:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.0 via Frontend Transport; Tue, 9 Sep 2025 05:50:11 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 22:50:07 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH v3 6/7] drm/amd/pm: Update SMUv13.0.6 partition metrics
Date: Tue, 9 Sep 2025 11:17:36 +0530
Message-ID: <20250909054933.2911159-7-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250909054933.2911159-1-lijo.lazar@amd.com>
References: <20250909054933.2911159-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|SJ0PR12MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bf8438e-3ecf-4790-bfbf-08ddef64bd97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZT//k1KYzvAYWGb2pctGQ17LobqdjO95GMnydVYXYda1X8IZtjW1F3gNx06e?=
 =?us-ascii?Q?ELmkmf5z7pgMnbX3tySSMDv4o33jfnGlOEEvbh1Bf/IM+g643p6FcqdngQsU?=
 =?us-ascii?Q?nbDuHWQMworkPhMVf9XHZGM9qeQ67tGSGVgZOQD3JK02G3r8D9xQjowaqB5s?=
 =?us-ascii?Q?D2ZORVx/u95Ual7w/NvERJTIeZWYR2/ubkGd2uaYQXFdjRHUvePL2Ty7dE12?=
 =?us-ascii?Q?bawdoDdoe994awXNvtoNWGib85DdrnXKuOneYtzMdDu8mVVTVj/CEG3yuPKX?=
 =?us-ascii?Q?PkllzZXb+1RAq/1J/UbRSZaNkU5G1uqZjgVPxeLFIFjd2Tye5/uhKNE71oXY?=
 =?us-ascii?Q?7JlcBVqo19V5+ZGcUNei8eMgeV1eeWeT0wjxRDiHWJamUkRie7S8mUZSXM+M?=
 =?us-ascii?Q?Pjb6VSvvSgXPyo9wfdUa/owYvjteuBCOYiPTSE9PEvrGJGrASVoDRO95V80Z?=
 =?us-ascii?Q?yOFfaLGqV1kzI1cyKc09dz9ZcE2XtjFfJzCA7zBuBtwkGgmWZKq7F5mMsP3g?=
 =?us-ascii?Q?1dEzt8vHDZDuZV2vTLOVgMmwSOM2FBLGFkQh2bqA1TnufubQ3zsOF5DaZMG0?=
 =?us-ascii?Q?vfoigZS9iV+0JAJd/s7279aqDRleCmEaTsWHUV4k4aL9Tkundo665icnBHnZ?=
 =?us-ascii?Q?pQlRjiYp4Zto2YNGf0Ptc5fiPhfBtl2HvCHD+0pof0A0drQqTqfZMIwqVVSt?=
 =?us-ascii?Q?VLZQnbyMLg//uCRrbkHibo0xvxoAUgi4I9m+5bdgLP0qP09HT+CwerrcPhJ/?=
 =?us-ascii?Q?gmNiO1BekmJk56o2FP9qq3OOfujvDsqScaKqRP4uCEqESnZlefiOJC7P2Nfp?=
 =?us-ascii?Q?kDrlX/7wlztX8oAg5YSR+IK4Wb5so3WUWG1qtGCstlkz8rrxZyt4LQ7Kercg?=
 =?us-ascii?Q?LYrHGi5YvPzFhY5JJI1yuKkZpb2EFCwj7m77Qhyga1xrFEBassfkNBk1qkj7?=
 =?us-ascii?Q?Al9F6O0sFoHroTG79rhH9VArDvl7P/WHQka0WHEsRyFYR+GjnyiVS/E7WFdv?=
 =?us-ascii?Q?tvrqzC8zO+rZICCneFquYjAliQucc8Sdfla3VZ4dx8VzhPVpL5Xvpe3fEt8E?=
 =?us-ascii?Q?Peoyq5rE5M5Y1epu2UW7Ck5CnT1EEJS6iNOLFEP5LxXA6oymMFayVgj/yBqV?=
 =?us-ascii?Q?WvTEJRmQZpuNfA7NPwl6Frdf69oACSkeYNQdCDqEe2RZGdH6l3LypKTbIvYe?=
 =?us-ascii?Q?O7UUQk2/YPBm8zZSWa5O02IQm8dptYJnrg93BTut7iSnV0zI3sW9qvEKfVZi?=
 =?us-ascii?Q?3Ug1uewPmR3hiHdW1nRl0AbgLIdl/dVp1a4QG2XAvOLMjOf2udbg88yzwr2m?=
 =?us-ascii?Q?ibc4Td9odkagPUw5HJKE1yUWR77MQN5zDzjhlPwqAvYGgzMD6APHPsDANhk+?=
 =?us-ascii?Q?Iz2qWlzayVx3gP7xDGy76YuvKadyxKQcttUAoa6NbgD2vwE0Fb8P9Wk/b33E?=
 =?us-ascii?Q?0sBmENgzYS7OTgwgFCegwAWLFpk6E+zuxW1cQi0/Ugz8LhUCAurzT+KGFtbH?=
 =?us-ascii?Q?YxhSeSlQm3ItX2qAV3PCOhMSqlsbeuZuO1BL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 05:50:11.2703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf8438e-3ecf-4790-bfbf-08ddef64bd97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8614
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

For SMU v13.0.6 SOCs, move to partition metrics v1.1 schema

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  6 ++--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  | 34 +++++++++++++++++++
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 8eaa81dd7f0e..03cecf3da557 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2628,7 +2628,7 @@ static ssize_t smu_v13_0_6_get_xcp_metrics(struct smu_context *smu, int xcp_id,
 {
 	const u8 num_jpeg_rings = AMDGPU_MAX_JPEG_RINGS_4_0_3;
 	int version = smu_v13_0_6_get_metrics_version(smu);
-	struct amdgpu_partition_metrics_v1_0 *xcp_metrics;
+	struct smu_v13_0_6_partition_metrics *xcp_metrics;
 	MetricsTableV0_t *metrics_v0 __free(kfree) = NULL;
 	struct amdgpu_device *adev = smu->adev;
 	int ret, inst, i, j, k, idx;
@@ -2648,8 +2648,8 @@ static ssize_t smu_v13_0_6_get_xcp_metrics(struct smu_context *smu, int xcp_id,
 	if (i == adev->xcp_mgr->num_xcps)
 		return -EINVAL;
 
-	xcp_metrics = (struct amdgpu_partition_metrics_v1_0 *)table;
-	smu_cmn_init_partition_metrics(xcp_metrics, 1, 0);
+	xcp_metrics = (struct smu_v13_0_6_partition_metrics *)table;
+	smu_v13_0_6_partition_metrics_init(xcp_metrics, 1, 1);
 
 	metrics_v0 = kzalloc(METRICS_TABLE_SIZE, GFP_KERNEL);
 	if (!metrics_v0)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 1b449ab2d89f..ee1bc8535a9e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -213,6 +213,40 @@ void smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table,
 				  void *smu_metrics,
 				  struct smu_v13_0_6_gpu_metrics *gpu_metrics);
 
+#define SMU_13_0_6_PARTITION_METRICS_FIELDS(SMU_SCALAR, SMU_ARRAY)             \
+	SMU_ARRAY(SMU_MATTR(CURRENT_GFXCLK), SMU_MUNIT(CLOCK_1),               \
+		  SMU_MTYPE(U16), current_gfxclk, SMU_13_0_6_MAX_XCC)          \
+	SMU_ARRAY(SMU_MATTR(CURRENT_SOCCLK), SMU_MUNIT(CLOCK_1),               \
+		  SMU_MTYPE(U16), current_socclk, SMU_13_0_6_MAX_CLKS)         \
+	SMU_ARRAY(SMU_MATTR(CURRENT_VCLK0), SMU_MUNIT(CLOCK_1),                \
+		  SMU_MTYPE(U16), current_vclk0, SMU_13_0_6_MAX_CLKS)          \
+	SMU_ARRAY(SMU_MATTR(CURRENT_DCLK0), SMU_MUNIT(CLOCK_1),                \
+		  SMU_MTYPE(U16), current_dclk0, SMU_13_0_6_MAX_CLKS)          \
+	SMU_SCALAR(SMU_MATTR(CURRENT_UCLK), SMU_MUNIT(CLOCK_1),                \
+		   SMU_MTYPE(U16), current_uclk)                               \
+	SMU_ARRAY(SMU_MATTR(GFX_BUSY_INST), SMU_MUNIT(PERCENT),                \
+		  SMU_MTYPE(U32), gfx_busy_inst, SMU_13_0_6_MAX_XCC)           \
+	SMU_ARRAY(SMU_MATTR(JPEG_BUSY), SMU_MUNIT(PERCENT), SMU_MTYPE(U16),    \
+		  jpeg_busy, SMU_13_0_6_MAX_JPEG)                              \
+	SMU_ARRAY(SMU_MATTR(VCN_BUSY), SMU_MUNIT(PERCENT), SMU_MTYPE(U16),     \
+		  vcn_busy, SMU_13_0_6_MAX_VCN)                                \
+	SMU_ARRAY(SMU_MATTR(GFX_BUSY_ACC), SMU_MUNIT(PERCENT), SMU_MTYPE(U64), \
+		  gfx_busy_acc, SMU_13_0_6_MAX_XCC)                            \
+	SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_PPT_ACC), SMU_MUNIT(NONE),    \
+		  SMU_MTYPE(U64), gfx_below_host_limit_ppt_acc,                \
+		  SMU_13_0_6_MAX_XCC)                                          \
+	SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_THM_ACC), SMU_MUNIT(NONE),    \
+		  SMU_MTYPE(U64), gfx_below_host_limit_thm_acc,                \
+		  SMU_13_0_6_MAX_XCC)                                          \
+	SMU_ARRAY(SMU_MATTR(GFX_LOW_UTILIZATION_ACC), SMU_MUNIT(NONE),         \
+		  SMU_MTYPE(U64), gfx_low_utilization_acc, SMU_13_0_6_MAX_XCC) \
+	SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_TOTAL_ACC), SMU_MUNIT(NONE),  \
+		  SMU_MTYPE(U64), gfx_below_host_limit_total_acc,              \
+		  SMU_13_0_6_MAX_XCC)
+
+DECLARE_SMU_METRICS_CLASS(smu_v13_0_6_partition_metrics,
+			  SMU_13_0_6_PARTITION_METRICS_FIELDS);
+
 #endif /* SWSMU_CODE_LAYER_L2 */
 
 #endif
-- 
2.49.0

