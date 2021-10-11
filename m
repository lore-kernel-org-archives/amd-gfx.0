Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8C9C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 15:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36D5E60F3A
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 15:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 36D5E60F3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA8B46E503;
	Mon, 11 Oct 2021 15:04:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56AF76E503
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 15:04:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4T/dUGe4rmC9Ck4h+epvJLG2RfwMqK5Z4EGogcYFeARsPZZAcY6yxr1kXmhR8heWTxHVIKi7n/L3qML8Coj3HU2A+Uc431D8jymUKdg3injDOz/76tpTpfj6r2Wm0QAROqahMMiwhftqGoXlY+xSMBipJWyBHaS+T8BFeQHzk7CM3eSS4NeLkUE678j3jF8d5JcKcDk/LrENejNBTiSTkDtedwCuWJMyqX3sjasH3zXSkma46/uvBdG67TOd46/sz/EWp0nRCTySs9vYzKgCmYd5peLVQQ9yGiVKWeXf/i0fARIatEStwRbvrqPVYKFnxJVRuXglfbrlN8DxeR2/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYjrrFU4ndtcljLfaOiPwn5A+VsN5x3cNbzSXBkZcjM=;
 b=OOp004gm7f0X/IwaepRx9pD8gEUYW/SuyLEDN4HsptqZFxqFdGpGgRaSR19SyzNL8zdL2vhhS4ombaqY8uFr0tv+mMfxCVVRUqWLZj5IYiBIIWwHynaCnrD+B+H6QHv0PL6dsQSleoka6FVns4CQroo/Cm/y8A4UVv0viBhRq+BSbOep8eoZp2WXIO4nnTfpdvw9tkIh8vxNraEq3cJpdfmHonjZ4uUxRerPiV5LPwxrkoaGLLJzOWD9vqcs1bF8nj/7rYUOkG/Gj9aTjFqAK8hBWo6VLX77dM9bHfLvpg13npyjv7QwBHyS5Em7q/OyQ4PzKZNjBq4gpBbGeR5yRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYjrrFU4ndtcljLfaOiPwn5A+VsN5x3cNbzSXBkZcjM=;
 b=tXgTb9ybYZFOHtCWkoAxsNLRtPQoRmXt5AMPulo7OwUFI46wX1rNuX4T9n/dgSHAWKhd7Wxk7aQZk0nErV6KMW3g4vJlM54DfwOJgQaUfjSlIJT/Hic3RD4cF9GY71Q6z168fNyqYE+tL4IghO0BjA8X4vyYnIY9x0hMkEIDnTU=
Received: from BN6PR13CA0035.namprd13.prod.outlook.com (2603:10b6:404:13e::21)
 by MN2PR12MB4797.namprd12.prod.outlook.com (2603:10b6:208:a4::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Mon, 11 Oct
 2021 15:03:59 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::3e) by BN6PR13CA0035.outlook.office365.com
 (2603:10b6:404:13e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.12 via Frontend
 Transport; Mon, 11 Oct 2021 15:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 15:03:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 10:03:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/pm: properly handle sclk for profiling modes on
 vangogh
Date: Mon, 11 Oct 2021 11:03:40 -0400
Message-ID: <20211011150340.165831-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41ef7e4c-259f-40ae-e546-08d98cc85abc
X-MS-TrafficTypeDiagnostic: MN2PR12MB4797:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4797A2263E3715F630ED52CFF7B59@MN2PR12MB4797.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dd1csdBgyHMG3jkJH8XK/5+Hw07e1gyJPqZ1WJEO6wlgPB9XHrJDfaaWfMpTO7276YCA+qdYynRjTas0M7ZCITAI9mu7HVbDZDVEYvMuY+Vu6ZKWBXNMUEvKn14oOmD7Q7/v3pY9ZrJKWe8D92SNWnqM7TvFbOg8FFyqQTc9eUVA+FMNdQGtN1yAp2hIjz2NI92INLyJAzZh6qg2xUXBkK36Iqh7Waci3fQHeX4XU8839AAMLsfEh/LpjcF7RJlrZ+Vs+WH1DR8tdNRA5gAYb9R5sUB28wgJbasrY18vMAI2kJ//ELBN7Z0YiIhXT/jou/6H6IDws8XJxf5XL7EGje0TjhOm1rxd4YJvBZ2otfUflnmy4Q8PuN3xF08+iAbtTZZagzAdAvqaSdd3ILlo7nlxe9D+ENbY6V3t4zDLBfZuRT7oFICMb9pUe1jERppcKM9jUXtCbRsAg9XUSKSBeSXQthjmZJDK07Hdmm7FmCCxuUmZgr9tE2YAQ8n0jdzj8GRlhwRRPs6PXrqn8GJy9OSRdEd5/2/cxxXZDtJp7RfsJc5gsHBW9zMOqDZ7D3hm/248ifhmeNcB4xbvKNZUgD8y6lD/0eBpC8pKuRvK6hv+vxyc82UdP5YooFv39i7mgae2VPzWVmbrPzPrRMW0Nu5cfrhK6rqR0fcu9gYlnzwFAuMy1w67w+Eky0lqkZ9V/QEfolv8ThJXTj4PsjoE/BbpZ0ZN6abmvZxx6jKwsQ4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(7696005)(6666004)(47076005)(966005)(5660300002)(4326008)(26005)(508600001)(2616005)(1076003)(81166007)(356005)(36756003)(336012)(6916009)(426003)(8676002)(8936002)(82310400003)(83380400001)(16526019)(70586007)(36860700001)(70206006)(2906002)(316002)(186003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 15:03:59.2493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ef7e4c-259f-40ae-e546-08d98cc85abc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4797
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

When selecting between levels in the force performance levels interface
sclk (gfxclk) was not set correctly for all levels.  Select the proper
sclk settings for all levels.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1726
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 89 ++++++-------------
 1 file changed, 29 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index bdd1a01e27b4..8d5f32807821 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1386,52 +1386,38 @@ static int vangogh_set_performance_level(struct smu_context *smu,
 	uint32_t soc_mask, mclk_mask, fclk_mask;
 	uint32_t vclk_mask = 0, dclk_mask = 0;
 
+	smu->cpu_actual_soft_min_freq = smu->cpu_default_soft_min_freq;
+	smu->cpu_actual_soft_max_freq = smu->cpu_default_soft_max_freq;
+
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_HIGH:
-		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
+		smu->gfx_actual_hard_min_freq = smu->gfx_default_soft_max_freq;
 		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
 
-		smu->cpu_actual_soft_min_freq = smu->cpu_default_soft_min_freq;
-		smu->cpu_actual_soft_max_freq = smu->cpu_default_soft_max_freq;
 
 		ret = vangogh_force_dpm_limit_value(smu, true);
+		if (ret)
+			return ret;
 		break;
 	case AMD_DPM_FORCED_LEVEL_LOW:
 		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
-		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
-
-		smu->cpu_actual_soft_min_freq = smu->cpu_default_soft_min_freq;
-		smu->cpu_actual_soft_max_freq = smu->cpu_default_soft_max_freq;
+		smu->gfx_actual_soft_max_freq = smu->gfx_default_hard_min_freq;
 
 		ret = vangogh_force_dpm_limit_value(smu, false);
+		if (ret)
+			return ret;
 		break;
 	case AMD_DPM_FORCED_LEVEL_AUTO:
 		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
 		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
 
-		smu->cpu_actual_soft_min_freq = smu->cpu_default_soft_min_freq;
-		smu->cpu_actual_soft_max_freq = smu->cpu_default_soft_max_freq;
-
 		ret = vangogh_unforce_dpm_levels(smu);
-		break;
-	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
-		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
-		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
-
-		smu->cpu_actual_soft_min_freq = smu->cpu_default_soft_min_freq;
-		smu->cpu_actual_soft_max_freq = smu->cpu_default_soft_max_freq;
-
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-					SMU_MSG_SetHardMinGfxClk,
-					VANGOGH_UMD_PSTATE_STANDARD_GFXCLK, NULL);
-		if (ret)
-			return ret;
-
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-					SMU_MSG_SetSoftMaxGfxClk,
-					VANGOGH_UMD_PSTATE_STANDARD_GFXCLK, NULL);
 		if (ret)
 			return ret;
+		break;
+	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
+		smu->gfx_actual_hard_min_freq = VANGOGH_UMD_PSTATE_STANDARD_GFXCLK;
+		smu->gfx_actual_soft_max_freq = VANGOGH_UMD_PSTATE_STANDARD_GFXCLK;
 
 		ret = vangogh_get_profiling_clk_mask(smu, level,
 							&vclk_mask,
@@ -1446,32 +1432,15 @@ static int vangogh_set_performance_level(struct smu_context *smu,
 		vangogh_force_clk_levels(smu, SMU_SOCCLK, 1 << soc_mask);
 		vangogh_force_clk_levels(smu, SMU_VCLK, 1 << vclk_mask);
 		vangogh_force_clk_levels(smu, SMU_DCLK, 1 << dclk_mask);
-
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
 		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
-		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
-
-		smu->cpu_actual_soft_min_freq = smu->cpu_default_soft_min_freq;
-		smu->cpu_actual_soft_max_freq = smu->cpu_default_soft_max_freq;
-
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinVcn,
-								VANGOGH_UMD_PSTATE_PEAK_DCLK, NULL);
-		if (ret)
-			return ret;
-
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxVcn,
-								VANGOGH_UMD_PSTATE_PEAK_DCLK, NULL);
-		if (ret)
-			return ret;
+		smu->gfx_actual_soft_max_freq = smu->gfx_default_hard_min_freq;
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
 		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
 		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
 
-		smu->cpu_actual_soft_min_freq = smu->cpu_default_soft_min_freq;
-		smu->cpu_actual_soft_max_freq = smu->cpu_default_soft_max_freq;
-
 		ret = vangogh_get_profiling_clk_mask(smu, level,
 							NULL,
 							NULL,
@@ -1484,29 +1453,29 @@ static int vangogh_set_performance_level(struct smu_context *smu,
 		vangogh_force_clk_levels(smu, SMU_FCLK, 1 << fclk_mask);
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
-		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
-		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
-
-		smu->cpu_actual_soft_min_freq = smu->cpu_default_soft_min_freq;
-		smu->cpu_actual_soft_max_freq = smu->cpu_default_soft_max_freq;
-
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
-				VANGOGH_UMD_PSTATE_PEAK_GFXCLK, NULL);
-		if (ret)
-			return ret;
+		smu->gfx_actual_hard_min_freq = VANGOGH_UMD_PSTATE_PEAK_GFXCLK;
+		smu->gfx_actual_soft_max_freq = VANGOGH_UMD_PSTATE_PEAK_GFXCLK;
 
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk,
-				VANGOGH_UMD_PSTATE_PEAK_GFXCLK, NULL);
+		ret = vangogh_set_peak_clock_by_device(smu);
 		if (ret)
 			return ret;
-
-		ret = vangogh_set_peak_clock_by_device(smu);
 		break;
 	case AMD_DPM_FORCED_LEVEL_MANUAL:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
 	default:
-		break;
+		return 0;
 	}
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
+					      smu->gfx_actual_hard_min_freq, NULL);
+	if (ret)
+		return ret;
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk,
+					      smu->gfx_actual_soft_max_freq, NULL);
+	if (ret)
+		return ret;
+
 	return ret;
 }
 
-- 
2.31.1

