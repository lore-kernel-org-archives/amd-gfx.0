Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8FDC36008
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 08:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F64410E662;
	Wed, 26 Mar 2025 08:14:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m5XthwuE";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D3FF10E65D
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 08:14:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HB2XcSNqJz0WQHJ/0BRLq1eKYONsrRjYSi49T0g1tbgGZVTx+wD+KoFZdRXiWNhAqrAi/c7fb5Gf5agnUf1l69RZiVdJVO1T42ASlGcGKnNYlIIv5GCzxqeOV+k1jbA1IcvF7CB3h/iflVe/A9x/iPbgLHbN6oUJrva7+Mh4ECTMjqw7C1dPYaskLtc2G9uM5mg1/0njkifR1OewtZyMg6NTDXo2J1layS1ID6yQOeMLdNhla3FtYwBFc5/QdLWO2gYxCA63RRIyRzYONlLw5EkJO5lwLR+qigxYdrBUHJ4UWXJKe2MymhLckBK3UrEpGDUIeXI5YGW0qD8yjnxJEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMhb0Xx9Wn+7NaeyCmPyQaCNcC7c5/WD9E9Cz1KMKMs=;
 b=eup/m//4w+7dUae9eHC5fpTtOfcrRYzz9WwIWkuLGA5uRrTKv8onqBK5BCuXKZ2nCpBnYT8cNcjGSqtgr/MvZzIfGicVPnX5BV1Ud92r/1dIG7br1aAvpWjcYJ0JNZPbzjs8NfKlhHAvDjNBGDtv41hBlKnMh/3D3pkDUaXcdVKsti7M6BLj14mTEhHudXEF7Ct/O/UT6X4f909qhDsM8c4QEC6ogvGa0HZWdOlZ1gvNBC1in9LPo8vDKo4iaCm8FeAIduWSh9SPIQoQ3YkIjvxPvuM5Sij3gekBZpJbyrC/WHmTHK/k0grNnYZl1TYVig0P1iHuI8Di7VrifiMp7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMhb0Xx9Wn+7NaeyCmPyQaCNcC7c5/WD9E9Cz1KMKMs=;
 b=m5XthwuEAWpMjDGzC7RCHmv2wesoNlPNT+hnYpGCT5E+Uxe9j2sIBH6/OLDXxy+bz/2cinPhbx7jFE5X0mkzmiUg2XMG6cEnAoN9M+6PE8kkhAMXf0p9JuvosJZqHRb3RXQrSev9VWT0ORPlvbdJx9n3ygMC1UU3oodU/77i79M=
Received: from PH7P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::33)
 by PH8PR12MB6985.namprd12.prod.outlook.com (2603:10b6:510:1bc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 08:14:25 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:32a:cafe::d6) by PH7P221CA0003.outlook.office365.com
 (2603:10b6:510:32a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.37 via Frontend Transport; Wed,
 26 Mar 2025 08:14:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 08:14:25 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 03:14:22 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 5/6] drm/amd/pm: Use gpu_metrics_v1_8 for smu_v13_0_6
Date: Wed, 26 Mar 2025 16:13:59 +0800
Message-ID: <20250326081400.1305136-5-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250326081400.1305136-1-asad.kamal@amd.com>
References: <20250326081400.1305136-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|PH8PR12MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: eba31336-c5f2-444a-539c-08dd6c3e38bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Io60RGWGMuUGBeUxqWEFCMPkCT1Wln7gWBhSJ3oZZ9hq5adXg9Ff5/3U+ibd?=
 =?us-ascii?Q?+xTQoFOAOW7WaSNOOmSAQ377Zj+7jiFo1FOl/7yW/94mvdYtjjzo5SrvGohT?=
 =?us-ascii?Q?u0dwrW4IG59JJnMOIwPkqY69uV4OacpPao9qU0s8sOHfa1FmHFG2uuqb10vq?=
 =?us-ascii?Q?1aVcA9OBPIxGqe1yErepBEQ5yeKCIJq9hnpoNxsaJ52tQXLspv9Qou1IExtf?=
 =?us-ascii?Q?+wmIsBZ33FMjo/7Wlcpwy50942BDiSDWjuqlY9Ls57IUQmSQ0zcuieoUztj0?=
 =?us-ascii?Q?1jvLakmdaYaIrzAb0DSUkAuYDOc1sAbekNAsMtOKJploqg78d2q/IM5SxT+R?=
 =?us-ascii?Q?AwjhXOTk9ORXDMx/yra0G/L4O+++zBWrdKfYvVRtYdrWsZClemwmg21E4A33?=
 =?us-ascii?Q?lBSbH8UinttSmOZEVi8ofl7/IUltI7JWKwQR9odnu2eKJmGSqLMjK5D9ploC?=
 =?us-ascii?Q?trVt8wHB87kYH5Qa45v2PGevx5JPB/lfgxEp5uLe0r0EJKkydNm3PENsRB8A?=
 =?us-ascii?Q?7fAYpfXFCDW9rD2JwMfL1sXLHQmbxpHN82Dte0pxbdlNKRdQ8jvfgohAgkH3?=
 =?us-ascii?Q?5mwvo32YVE57xLy+kPBL9mi1YEt/dQPNXD7kKkghZfeyngcoxWaFMw/vHgT9?=
 =?us-ascii?Q?V2ALjIjvjgzyvm16DnBYukwY12n2yWQ/4M2/frMsLPcM9367W/6dSkC2GKJS?=
 =?us-ascii?Q?xszBVuFK5RpI10KjSsC9tv0NOko4+PrpOdjVU2A+Kz+fOaKBdNPgi5HvYXPc?=
 =?us-ascii?Q?fBByUoJSkmyF01TdSXioy5yMI5J0aZ9YfjvfL0T1g6u8znyNM24a074KI7fd?=
 =?us-ascii?Q?8/EAUnFVzDAiCt76npHeaP5y/N9KetEj1soWt2NOvkxAL56ZSqPRk+iTqUhk?=
 =?us-ascii?Q?g9u1hnu/P+0KGRdUrziQfrbEFEbaDC74XAEBAOOKQyftwFHBUAX3aKL154jg?=
 =?us-ascii?Q?aHjMJgldrED/60fRi7RYGXj0Ya8xtyZoO5+O5sVSMvmhUZ5YaLdcDQGfjeky?=
 =?us-ascii?Q?ZAjl+O9Dfjao3DjMeEOvZ/fXOUZojpYtTeUspJBf8TxaBDAOlOJb68gaD2TW?=
 =?us-ascii?Q?5E1YR+qQRBzmpT0ePUiJW0v1goU1CcyfZ8DQziCQb62UJR8WD7jk6WS0tL7o?=
 =?us-ascii?Q?M8TAHjg/B6XLfm59I2EROtPyCPg3AiveWGmb/u2DnLlR0uXYCin+XhuiFV/d?=
 =?us-ascii?Q?d8WMdMEXOs+ioISvmuKAmMxppylVXFrL3WAScr7bja0rRDp04xY5OzzUrJ/6?=
 =?us-ascii?Q?TBqM6z+W6auR0hv40lQXWvVx4+BW3Zy7NP7rp0kF4gtvr2jXXALt39tGSbs2?=
 =?us-ascii?Q?wmJlT2UR6z5M49p9QqU0ZGUjmV7HjSN+gGU9fep5QojJ+R688ybbMzRNhOYh?=
 =?us-ascii?Q?+R8Pz7aiaX+cyO58jjAVytFWAi2NrPEvWDL/SQ/t9IpPn+L4oubAZx+h9ex+?=
 =?us-ascii?Q?Xg9V3pwWiX+5J0KszjkVHKntfyulh5kWZmqEAHvp70BLpbqaSwyX1A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 08:14:25.0463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eba31336-c5f2-444a-539c-08dd6c3e38bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6985
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

Use gpu_metrics_v1_8 for smu_v13_0_6 to fill metrics data

v2: Move exposing caps to separate patch, move smu_v13.0.12 gpu metrics
1.8 usage to separate patch (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 22 +++++++++++++++----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  |  1 +
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index f8489ebbd2ad..4f767948b172 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -507,7 +507,7 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_7);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_8);
 	smu_table->gpu_metrics_table =
 		kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table) {
@@ -2468,8 +2468,8 @@ static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *smu)
 static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_7 *gpu_metrics =
-		(struct gpu_metrics_v1_7 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_8 *gpu_metrics =
+		(struct gpu_metrics_v1_8 *)smu_table->gpu_metrics_table;
 	int version = smu_v13_0_6_get_metrics_version(smu);
 	int ret = 0, xcc_id, inst, i, j, k, idx;
 	struct amdgpu_device *adev = smu->adev;
@@ -2495,7 +2495,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	metrics_v1 = (MetricsTableV1_t *)metrics_v0;
 	metrics_v2 = (MetricsTableV2_t *)metrics_v0;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 7);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 8);
 
 	gpu_metrics->temperature_hotspot =
 		SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature, version));
@@ -2648,6 +2648,20 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 				gpu_metrics->xcp_stats[i].gfx_busy_acc[idx] =
 					SMUQ10_ROUND(GET_GPU_METRIC_FIELD(GfxBusyAcc,
 									  version)[inst]);
+				if (smu_v13_0_6_cap_supported(smu, SMU_CAP(HST_LIMIT_METRICS))) {
+					gpu_metrics->xcp_stats[i].gfx_below_host_limit_ppt_acc[idx] =
+						SMUQ10_ROUND
+						(metrics_v0->GfxclkBelowHostLimitPptAcc[inst]);
+					gpu_metrics->xcp_stats[i].gfx_below_host_limit_thm_acc[idx] =
+						SMUQ10_ROUND
+						(metrics_v0->GfxclkBelowHostLimitThmAcc[inst]);
+					gpu_metrics->xcp_stats[i].gfx_low_utilization_acc[idx] =
+						SMUQ10_ROUND
+						(metrics_v0->GfxclkLowUtilizationAcc[inst]);
+					gpu_metrics->xcp_stats[i].gfx_below_host_limit_total_acc[idx] =
+						SMUQ10_ROUND
+						(metrics_v0->GfxclkBelowHostLimitTotalAcc[inst]);
+				}
 				idx++;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index f28b1401fc76..2a8f42dbd9f5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -65,6 +65,7 @@ enum smu_v13_0_6_caps {
 	SMU_CAP(ACA_SYND),
 	SMU_CAP(SDMA_RESET),
 	SMU_CAP(STATIC_METRICS),
+	SMU_CAP(HST_LIMIT_METRICS),
 	SMU_CAP(ALL),
 };
 
-- 
2.46.0

