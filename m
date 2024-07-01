Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F0AC30653
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jul 2024 10:44:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA99910E394;
	Mon,  1 Jul 2024 10:44:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FgPNnGmn";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 728AF10E394
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jul 2024 10:44:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8nyFzle3IrfnWbav0R0MjA585a63b/r2MjUDUP1vn49XFA5pEOQTseoxUveJl5vxxlwHkRkwOfMZ6D5UDteVKzxIoMmeZdJ/hbR9xrViCt5L2t8zFfnlHeKWRJR17bUKPXa19FACFJD1bi0knXco6WRBo3xnRkINChxuiDnVnUOLFg3Fb0b7TsFBCMVgqJ0Wwtmw8FAvGD/Xat/nmZs0GuI8hXAXNSUIYe9md95DrUpG9JYvaJnmo8YprSwjh+N0ZH+bv3HXgE6XjwkjduV0f2iG9n+Wct7mNUGnBJXId/coV0LdwUz78ttwUOrjFvn2/0b2fcu9WjnwWT/teBn3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVG21VfaTJQEPV/sGdGXuWZR+rFE1VpyADXwXee8Iak=;
 b=dr9fRfBngLZ/Gyvf4R41JhwDKGb4IJ4lWA+uUaYjmx6aeIy/0EPSby87ZKT7PKazLwR1mEeFxW8VI0PMrbKeJmcwjItNiQhJgDZrGlkoAC9BvG3Ejr4ZsumC7FcKlULs9VYB350TiRGHwiWXPaogu5XRgxYzVLZUQAwkTXA+/LBxQz4CejcjiKOIFNxMRv62X/OJomSgDjnCxmBw2BOggHcbH44xvjRmTEaDfHI+np9lFfLze+02euthTl5QXWmzipwn8UXToNf3T8wxm+aaOTwR9Lux+GTfoHwDTBd9Ayv0vkn/by4Nx9vc+pBVGUtThr2sdjsdJl53LwLHUvyebw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVG21VfaTJQEPV/sGdGXuWZR+rFE1VpyADXwXee8Iak=;
 b=FgPNnGmnSRQWF3vGRuYBwHKUFpVkOP123Ys9WTcvh+N4F1R6bLCMX9oDmsscf4+Z6Ar8Pl21hfO3+I/Zcu890z8qGKis1VBUGtOA7ofQBh7LpydNgmpLmgOMgsDpLx3Soavt8k0kfICqki/veFsRxkmzZBwInOM0segwWWp2JEk=
Received: from CH0P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::22)
 by MN0PR12MB6104.namprd12.prod.outlook.com (2603:10b6:208:3c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Mon, 1 Jul
 2024 10:44:40 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::a6) by CH0P220CA0026.outlook.office365.com
 (2603:10b6:610:ef::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26 via Frontend
 Transport; Mon, 1 Jul 2024 10:44:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Mon, 1 Jul 2024 10:44:40 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Jul
 2024 05:44:38 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <yifan1.zhang@amd.com>, <tim.huang@amd.com>, 
 Li Ma <li.ma@amd.com>
Subject: [PATCH v2] drm/amd/swsmu: enable more Pstates profile levels for SMU
 v14.0.0 and v14.0.1
Date: Mon, 1 Jul 2024 18:43:55 +0800
Message-ID: <20240701104354.507531-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|MN0PR12MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: 94a89537-5bbd-4261-fa36-08dc99bacf91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jqj1XBaa8XDp4nEPDI3ZEUYZVESFZHLzaRE9yRCuH39ll4fMZRp3oQzWdM5a?=
 =?us-ascii?Q?d4ZgZGv/ZxcJNN+84LhALqDczdkpEF903yvxPdc/CJBUpYymps9O5RYQlJvM?=
 =?us-ascii?Q?BNqlUqo30YAs2iyKdyUbV+fEAtCv6LB4cgysIIso8wdScshVlpPi3EpJ1r+3?=
 =?us-ascii?Q?hbLkX8mMnezIeM1ArKM+zNv05oR30hmqxTSmDCQYK1J5Ly+/JFJ/arrHd35o?=
 =?us-ascii?Q?5FgPisOo71C99fZ30PID83k0KBpcV8B3Ykwr9MtwX+cD8/TJ+SQZ4ZsqPKhL?=
 =?us-ascii?Q?Y4Wj4DQYkLKBW3OKfgcqYUav/jfuNFHw8OfJ+QvRAsCWieJgL/vzIMdOveUd?=
 =?us-ascii?Q?10QH1vMKrU830gZtTXzFGIqLFUIbcqu1oVkK7Fj1Kt12VUFC7tpo50bqNTti?=
 =?us-ascii?Q?GelMfAcJpWst5zjcuwMgfJl6AhVbHtQrIdOSwEforT5RFWWLpe3cYHlBcEwr?=
 =?us-ascii?Q?VfjN3JcDM1s+5g2TWHhSvqK+bvOQ5RgqlKcYlyUgkU61zRifVm/Aj6GJKSOQ?=
 =?us-ascii?Q?C4ntdOAkXHfCigCZPdq0+CjxBs/YOhwoEc4fb3ulqaGojvRYcSdJD0Jva11f?=
 =?us-ascii?Q?A51DadVvm83ijywBd6zMjzl7ab5+JcANx34+WIzpZGfYe20I6Hccq8Z6mqCH?=
 =?us-ascii?Q?KoQlv2dJkeuDyaX+aUZDo4CQy1uXlbeCj2n7z9vcH+dLyZySxWAOguVKHxpg?=
 =?us-ascii?Q?hLmVzV5/V5NeLhJJENtJRNvtQHoxGClOJuNSlFO48tYNVXBnF7pW86bb7CCX?=
 =?us-ascii?Q?dE3hMvblfMDmSUuVihpKKcS0OEmzhADsTY8CH2L/+qn3H9EnbFCKTy8zX5EQ?=
 =?us-ascii?Q?6bh2y5/Sav+9IjhV02/7eS43Mjwjq2eBnPbEXmSsgFyonOjeF15GIVzkZ+Xo?=
 =?us-ascii?Q?GPrmWX4Co/1XFXoDE+LVGai5/t9xCFQ5LSI2JkEga4sT3qhvUZmMAyN+9jP0?=
 =?us-ascii?Q?yEUOXQihfp0FQDGFve8kdGUOCahoCQsXzdUF/KAc6fneYZ9mQLHvwXss0lhY?=
 =?us-ascii?Q?EEPMqbcpkKMK1icKvYuAeiGb3k0mrVreq731zw5hqLncKV6rHBaGsrxgo+6X?=
 =?us-ascii?Q?QNneWhugund/LSvFWjfGhZF77ReLZoiJmr/oUeuKElu8rqt6S0v7jNqzrrzU?=
 =?us-ascii?Q?gyY0gTVpjvKaWqsq+/StUPUrAP0830VXVCU/q/AejwlSMdUhtgR0lYrIX5VU?=
 =?us-ascii?Q?cMbJip5ni07xVI4sFOlNkxhJAtAJR6dhFZWG0q9TdL7wA5hfa+rMUJ6ZHej1?=
 =?us-ascii?Q?0oTsIEKsKrSY3drcK0Q8Xsuvu4nMjogASSZ2/g6uKylNgefd5PXF0rCb4UoX?=
 =?us-ascii?Q?Mw2nQv8mOzUeGzfxtV9SHmb1u+cWRHB5NVHCsBXan4QAcFOLefP5ZtblB+d9?=
 =?us-ascii?Q?YxiseD5VCM3wU/M+PUGWom96il96gvEYyzbc7HsRsD9wJtjSA/H4r9GULqX0?=
 =?us-ascii?Q?I9b92w6HBuvWirR5HAGdP9FQyQuSH52c?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 10:44:40.4247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a89537-5bbd-4261-fa36-08dc99bacf91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6104
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
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 138 +++++++++++++++++-
 1 file changed, 131 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 3a9d58c036ea..72fca481dec1 100644
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

