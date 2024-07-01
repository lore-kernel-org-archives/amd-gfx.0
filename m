Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7DCC2BD09
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jul 2024 08:24:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA70110E346;
	Mon,  1 Jul 2024 08:24:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QqU4yHTc";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E165510E346
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jul 2024 08:23:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofPm3hNSe9bEzmqUuNxPBaapUS+XyuQzVi44T/mfQmzUayqOsahFEjygf3ZtztsvGSB+A25Ff8uzdpAdbnnVGsz6Dljgrjlj6grivUT0CffZ1cjpSZtRQmb764kDbfoaeDUtcf4zngncXWWeA5eIuUg+NKA4mhhQKdQuNVRGFka/sPFNQv6K6BGTtXL/lUecs2vf3ADOQ+JxqUDrHm4oZ2O3LM2iYSCpwRUw4PYpNIKhTqWxnM3xvAAv0hJExkTE8n4H9mdYamnqFktZfftn8h4h0hu1uRkJSC6Q0BomK2ZQHwYl/871sVmm5uDfO7/dLX35k+tYLTGYEe3hcnyrng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCesYUXaDOQDcr1m3hcQW51W7UxGHNM6QFfuTr9iEig=;
 b=ZYmQGLNdfclxHefN1NDYxAl40cmHvaenjHDCoLPL5jjvYxVka/LdEiXq4TT77dcvIah5wUfZgqponGMF2u7Q+IB7oD61QakD+GDcqEbndrEDU31n3Px9Q/vc2CsPikPdmV5HMc0enNbepmdGKBh5vhszLm3iJtP/FUQgHOma7dmmdnE/h93BP9o019C8BThotsOwh+BLXM06eoBJZ/BMzYgorVhwod1KQxE3KPWQMxrc1LYiVPVQupOsZR1WM04Ucgxd6v71VYCbmD+Q92qzXPrgcGVJn7j2/AN6AqB/EHmYcWz/ysd4XKHfMw9/d0k3xirTGFOkaXJ9ksAwcopqmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCesYUXaDOQDcr1m3hcQW51W7UxGHNM6QFfuTr9iEig=;
 b=QqU4yHTcUvVnboOCzLpdoJyubI35psFF8qqcMXZz89OUoRuJZ7Dy7tvTzlp8oymMEDT+1eR+OAesgKooYa9TrNruRRJhsoqMG/6ZNYUjx2Nv0uKSzKflDjLjhKnzoNUZW5QxtjviP3+Wrf9noL/m8yWJsO1xr7lVlz6kKCtx0NI=
Received: from DS7PR03CA0086.namprd03.prod.outlook.com (2603:10b6:5:3bb::31)
 by SA1PR12MB8741.namprd12.prod.outlook.com (2603:10b6:806:378::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 08:23:56 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:5:3bb:cafe::7) by DS7PR03CA0086.outlook.office365.com
 (2603:10b6:5:3bb::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33 via Frontend
 Transport; Mon, 1 Jul 2024 08:23:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Mon, 1 Jul 2024 08:23:56 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Jul
 2024 03:23:53 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <yifan1.zhang@amd.com>, <tim.huang@amd.com>, 
 Li Ma <li.ma@amd.com>
Subject: [PATCH] drm/amd/swsmu: enable more Pstates profile levels for SMU
 v14.0.0 and v14.0.1
Date: Mon, 1 Jul 2024 16:22:54 +0800
Message-ID: <20240701082253.497435-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|SA1PR12MB8741:EE_
X-MS-Office365-Filtering-Correlation-Id: 952f315d-cbab-4fbc-1c04-08dc99a7267c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EUD/7393OcII5ON6M4aOtvgUYuA7Uu4MWCGjShjG/RFl4GEOuNyI48t6GS1u?=
 =?us-ascii?Q?upeF/tY4NAqtgPV0M9U3hJosDWji3QKpSNfMxebOCRCXz5F1pJ8BK1+Vpx5Q?=
 =?us-ascii?Q?pqxxgskb2DUDxqH7oRmueQl8ydse9+/ZrUt0DhgmtEouTKQ9xPw0H6Td/bn6?=
 =?us-ascii?Q?qwDCESd2pulwn08aiQZ+zAjnQ2hDX0Lnv1HLniICBfMVJzUUs6Vy16bzwmdL?=
 =?us-ascii?Q?XSwTK3nqaT2ITId9TPTlCrDZHDq7nVr0cd6qHf8e4HQdq77DFuISIYs+21t0?=
 =?us-ascii?Q?wvVwq0w3MnjM/CuZkrofZwQ6LHNlS701VWUPiRUo+pGERvdALPFm0dVLMY5c?=
 =?us-ascii?Q?i3qU6OhPOXfCgl6fn/5OVj+5j+xGYdMxyFa/zfs0aS1QrUVZXFOmQ0PG0BJO?=
 =?us-ascii?Q?djZdTrg+aBmjDTpYr4YIBkAU4PCgFQOo4GofwW7EZ8yrai7qn1aLfqY5QpmX?=
 =?us-ascii?Q?+9Am2r+0/4Awwgw9JLhITULY9sH3/UjRTsZQNZY3fPbGvibBN8kmKqPGgNPU?=
 =?us-ascii?Q?ryrUQlMhHhwarfcn9ZomQIMCUOhHQIEXxWu+hFI5mIK/JpRBXwLkbfEVywbq?=
 =?us-ascii?Q?q0X4Wwz0jN3wxgOZxCe1LFqS9q0EWfsEnrdlcRiIobg5AWx1VtRsG4GF318K?=
 =?us-ascii?Q?Qn1f7Uv0K+Oc7JGrqhrldiQBptcjyDxe4/A1NL9dat8I2knGTNJ9jbg3WR3S?=
 =?us-ascii?Q?avVkL158ZM3ECXflbVemPzRHsprPfsSr+bnHQMPsxutQibJCKz4YiVYUFX3d?=
 =?us-ascii?Q?Kcin3SvpCH5U8cz9ROvxFnEtILL1DLtQ60pF1idqzU9v0M/xbyVPXAkRStI2?=
 =?us-ascii?Q?sAfap8eabAdEYBC5nhT3xeM6wfbqcatfJyB44xYRxHMnmfqtYPnJ3k8tDjz3?=
 =?us-ascii?Q?P3oWNvBuslY43fEhQNGv32wi4f08FZtq8MLqq7SfMD+VaMFepnvAyLITUXHk?=
 =?us-ascii?Q?aDB1LCZwlNgw9VcxEMBoiEkAGBsGWBR2Lx6qGSJrnBorU3Wl+MJWSu6WgfS2?=
 =?us-ascii?Q?a/FLJ5VGLKi6+6PXc9bPpiYI6dYvJZzqWBxfC96HsJ1FdocJ596HFazGl61E?=
 =?us-ascii?Q?2nLssa/xXISKy4Wzzr03cNaq7JGv4t3qeLXvWvP/4VECfYpgHfsTmapi3fNE?=
 =?us-ascii?Q?oEy0F2bj3dGzZ3goy01z8g74NKokLqOAbc6aqp1fx5pB4N5jg7ekvlT8OZP+?=
 =?us-ascii?Q?Z2db5bppIetdFvy/UATxGMcVXrPQePafXHQKqHEdTtM7OgsRMwr1aMClaT9r?=
 =?us-ascii?Q?Xvpm5ER62KHC07K7wVug+jrOT30Kv2cwOj0jGnMYlw3Cp7Tnedla8yezA3Jg?=
 =?us-ascii?Q?97BDCa0bhnaBJZUWL3iMMYu+ibgfKSGXmcH0J2km73aiusVi0lXQHNrapt2y?=
 =?us-ascii?Q?IvTOCLVuMh074km1gguiS6K7W8Bw2j94wIlH0Z1qqB0gCv1uVOilL6g871A5?=
 =?us-ascii?Q?5se6DeMOAm6xlCq1JA0WQKfPUa+xDL+W?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 08:23:56.2930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 952f315d-cbab-4fbc-1c04-08dc99a7267c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8741
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

This patch enables following UMD stable Pstates profile
levels for power_dpm_force_performance_level interface.

- profile_peak
- profile_min_mclk
- profile_min_sclk
- profile_standard

Signed-off-by: Li Ma <li.ma@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 150 ++++++++++++++++--
 1 file changed, 137 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 18abfbd6d059..d999e3b23173 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -65,6 +65,10 @@
 
 #define SMU_MALL_PG_CONFIG_DEFAULT SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_ON
 
+#define SMU_14_0_0_UMD_PSTATE_GFXCLK			700
+#define SMU_14_0_0_UMD_PSTATE_SOCCLK			678
+#define SMU_14_0_0_UMD_PSTATE_FCLK			1800
+
 #define FEATURE_MASK(feature) (1ULL << feature)
 #define SMC_DPM_FEATURE ( \
 	FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \
@@ -723,10 +727,10 @@ static int smu_v14_0_common_get_dpm_freq_by_index(struct smu_context *smu,
 						uint32_t dpm_level,
 						uint32_t *freq)
 {
-	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0))
-		smu_v14_0_0_get_dpm_freq_by_index(smu, clk_type, dpm_level, freq);
-	else if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1))
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1))
 		smu_v14_0_1_get_dpm_freq_by_index(smu, clk_type, dpm_level, freq);
+	else
+		smu_v14_0_0_get_dpm_freq_by_index(smu, clk_type, dpm_level, freq);
 
 	return 0;
 }
@@ -818,9 +822,11 @@ static int smu_v14_0_1_get_dpm_ultimate_freq(struct smu_context *smu,
 			break;
 		case SMU_MCLK:
 		case SMU_UCLK:
-		case SMU_FCLK:
 			max_dpm_level = 0;
 			break;
+		case SMU_FCLK:
+			max_dpm_level = clk_table->NumFclkLevelsEnabled - 1;
+			break;
 		case SMU_SOCCLK:
 			max_dpm_level = clk_table->NumSocClkLevelsEnabled - 1;
 			break;
@@ -855,7 +861,7 @@ static int smu_v14_0_1_get_dpm_ultimate_freq(struct smu_context *smu,
 			min_dpm_level = clk_table->NumMemPstatesEnabled - 1;
 			break;
 		case SMU_FCLK:
-			min_dpm_level = clk_table->NumFclkLevelsEnabled - 1;
+			min_dpm_level = 0;
 			break;
 		case SMU_SOCCLK:
 			min_dpm_level = 0;
@@ -936,9 +942,11 @@ static int smu_v14_0_0_get_dpm_ultimate_freq(struct smu_context *smu,
 			break;
 		case SMU_MCLK:
 		case SMU_UCLK:
-		case SMU_FCLK:
 			max_dpm_level = 0;
 			break;
+		case SMU_FCLK:
+			max_dpm_level = clk_table->NumFclkLevelsEnabled - 1;
+			break;
 		case SMU_SOCCLK:
 			max_dpm_level = clk_table->NumSocClkLevelsEnabled - 1;
 			break;
@@ -969,7 +977,7 @@ static int smu_v14_0_0_get_dpm_ultimate_freq(struct smu_context *smu,
 			min_dpm_level = clk_table->NumMemPstatesEnabled - 1;
 			break;
 		case SMU_FCLK:
-			min_dpm_level = clk_table->NumFclkLevelsEnabled - 1;
+			min_dpm_level = 0;
 			break;
 		case SMU_SOCCLK:
 			min_dpm_level = 0;
@@ -999,10 +1007,10 @@ static int smu_v14_0_common_get_dpm_ultimate_freq(struct smu_context *smu,
 							uint32_t *min,
 							uint32_t *max)
 {
-	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0))
-		smu_v14_0_0_get_dpm_ultimate_freq(smu, clk_type, min, max);
-	else if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1))
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1))
 		smu_v14_0_1_get_dpm_ultimate_freq(smu, clk_type, min, max);
+	else if (clk_type != SMU_VCLK1 && clk_type != SMU_DCLK1)
+		smu_v14_0_0_get_dpm_ultimate_freq(smu, clk_type, min, max);
 
 	return 0;
 }
@@ -1268,13 +1276,67 @@ static int smu_v14_0_0_force_clk_levels(struct smu_context *smu,
 	return ret;
 }
 
-static int smu_v14_0_0_set_performance_level(struct smu_context *smu,
+static int smu_v14_0_common_get_dpm_profile_freq(struct smu_context *smu,
+					enum amd_dpm_forced_level level,
+					enum smu_clk_type clk_type,
+					uint32_t *min_clk,
+					uint32_t *max_clk)
+{
+	uint32_t clk_limit = 0;
+	int ret = 0;
+
+	switch (clk_type) {
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+		clk_limit = SMU_14_0_0_UMD_PSTATE_GFXCLK;
+		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+			smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &clk_limit);
+		else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK)
+			smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK, &clk_limit, NULL);
+		break;
+	case SMU_SOCCLK:
+		clk_limit = SMU_14_0_0_UMD_PSTATE_SOCCLK;
+		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+			smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &clk_limit);
+		break;
+	case SMU_FCLK:
+		clk_limit = SMU_14_0_0_UMD_PSTATE_FCLK;
+		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+			smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL, &clk_limit);
+		else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK)
+			smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK, &clk_limit, NULL);
+		break;
+	case SMU_VCLK:
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK, NULL, &clk_limit);
+		break;
+	case SMU_VCLK1:
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK1, NULL, &clk_limit);
+		break;
+	case SMU_DCLK:
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK, NULL, &clk_limit);
+		break;
+	case SMU_DCLK1:
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK1, NULL, &clk_limit);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	*min_clk = *max_clk = clk_limit;
+	return ret;
+}
+
+static int smu_v14_0_common_set_performance_level(struct smu_context *smu,
 					     enum amd_dpm_forced_level level)
 {
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t sclk_min = 0, sclk_max = 0;
 	uint32_t fclk_min = 0, fclk_max = 0;
 	uint32_t socclk_min = 0, socclk_max = 0;
+	uint32_t vclk_min = 0, vclk_max = 0;
+	uint32_t dclk_min = 0, dclk_max = 0;
+	uint32_t vclk1_min = 0, vclk1_max = 0;
+	uint32_t dclk1_min = 0, dclk1_max = 0;
 	int ret = 0;
 
 	switch (level) {
@@ -1282,28 +1344,54 @@ static int smu_v14_0_0_set_performance_level(struct smu_context *smu,
 		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &sclk_max);
 		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL, &fclk_max);
 		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &socclk_max);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK, NULL, &vclk_max);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK, NULL, &dclk_max);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK1, NULL, &vclk1_max);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK1, NULL, &dclk1_max);
 		sclk_min = sclk_max;
 		fclk_min = fclk_max;
 		socclk_min = socclk_max;
+		vclk_min = vclk_max;
+		dclk_min = dclk_max;
+		vclk1_min = vclk1_max;
+		dclk1_min = dclk1_max;
 		break;
 	case AMD_DPM_FORCED_LEVEL_LOW:
 		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min, NULL);
 		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk_min, NULL);
 		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &socclk_min, NULL);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK, &vclk_min, NULL);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK, &dclk_min, NULL);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK1, &vclk1_min, NULL);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK1, &dclk1_min, NULL);
 		sclk_max = sclk_min;
 		fclk_max = fclk_min;
 		socclk_max = socclk_min;
+		vclk_max = vclk_min;
+		dclk_max = dclk_min;
+		vclk1_max = vclk1_min;
+		dclk1_max = dclk1_min;
 		break;
 	case AMD_DPM_FORCED_LEVEL_AUTO:
 		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min, &sclk_max);
 		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk_min, &fclk_max);
 		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &socclk_min, &socclk_max);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK, &vclk_min, &vclk_max);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK, &dclk_min, &dclk_max);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK1, &vclk1_min, &vclk1_max);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK1, &dclk1_min, &dclk1_max);
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
-		/* Temporarily do nothing since the optimal clocks haven't been provided yet */
+		smu_v14_0_common_get_dpm_profile_freq(smu, level, SMU_SCLK, &sclk_min, &sclk_max);
+		smu_v14_0_common_get_dpm_profile_freq(smu, level, SMU_FCLK, &fclk_min, &fclk_max);
+		smu_v14_0_common_get_dpm_profile_freq(smu, level, SMU_SOCCLK, &socclk_min, &socclk_max);
+		smu_v14_0_common_get_dpm_profile_freq(smu, level, SMU_VCLK, &vclk_min, &vclk_max);
+		smu_v14_0_common_get_dpm_profile_freq(smu, level, SMU_DCLK, &dclk_min, &dclk_max);
+		smu_v14_0_common_get_dpm_profile_freq(smu, level, SMU_VCLK1, &vclk1_min, &vclk1_max);
+		smu_v14_0_common_get_dpm_profile_freq(smu, level, SMU_DCLK1, &dclk1_min, &dclk1_max);
 		break;
 	case AMD_DPM_FORCED_LEVEL_MANUAL:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
@@ -1343,6 +1431,42 @@ static int smu_v14_0_0_set_performance_level(struct smu_context *smu,
 			return ret;
 	}
 
+	if (vclk_min && vclk_max) {
+		ret = smu_v14_0_0_set_soft_freq_limited_range(smu,
+							      SMU_VCLK,
+							      vclk_min,
+							      vclk_max);
+		if (ret)
+			return ret;
+	}
+
+	if (vclk1_min && vclk1_max) {
+		ret = smu_v14_0_0_set_soft_freq_limited_range(smu,
+							      SMU_VCLK1,
+							      vclk1_min,
+							      vclk1_max);
+		if (ret)
+			return ret;
+	}
+
+	if (dclk_min && dclk_max) {
+		ret = smu_v14_0_0_set_soft_freq_limited_range(smu,
+							      SMU_DCLK,
+							      dclk_min,
+							      dclk_max);
+		if (ret)
+			return ret;
+	}
+
+	if (dclk1_min && dclk1_max) {
+		ret = smu_v14_0_0_set_soft_freq_limited_range(smu,
+							      SMU_DCLK1,
+							      dclk1_min,
+							      dclk1_max);
+		if (ret)
+			return ret;
+	}
+
 	return ret;
 }
 
@@ -1520,7 +1644,7 @@ static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.od_edit_dpm_table = smu_v14_0_od_edit_dpm_table,
 	.print_clk_levels = smu_v14_0_0_print_clk_levels,
 	.force_clk_levels = smu_v14_0_0_force_clk_levels,
-	.set_performance_level = smu_v14_0_0_set_performance_level,
+	.set_performance_level = smu_v14_0_common_set_performance_level,
 	.set_fine_grain_gfx_freq_parameters = smu_v14_0_common_set_fine_grain_gfx_freq_parameters,
 	.set_gfx_power_up_by_imu = smu_v14_0_set_gfx_power_up_by_imu,
 	.dpm_set_vpe_enable = smu_v14_0_0_set_vpe_enable,
-- 
2.25.1

