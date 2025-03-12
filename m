Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD3DC2BA1B
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 18:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E18B310E70F;
	Wed, 12 Mar 2025 18:57:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UO6JzpHB";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0CE310E341
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 18:57:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6pnaPHgXVaQwodjruwyrqptz+7sYVj+T5j6Ts8HUwkkyN8jwnYmwp6kJbsV9tCb4HbIUs8kSwTr03N9v4TNDpz6/hmbSgbLxm2VclewPIquCcegclF07hxCIfGzEmOgmGhAFVSHxetDGNMSVOE4rCopSukSdCepSEiQJBK8DMYVLJiJrxkiL8uhFUnMqa4bCWPJXcxJvf6a0FSB6v8Amg16Jx7slN4noPaC+aWxs4J5zXe5cwsLcmKzue2PPLpjWFNmBWKVxS2VjFSF1yagSsycY8pjcOLHdMBJKtAz7cQu3j76DlFnMhCFtAurkP8RoC6alcUlQPBnWRQYK0qfmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OX4tFpYhVZCP+mzspCJDly5vhKM/YINwNWl83/cP9hI=;
 b=lCI72agBAMHfeR11cbQEsNBCsTjYSfscT+9dqoJGog59Wgvcf3vcxFc9E8zTOJTwr8jNi8xBWgze/iewGjGx0HXSgIwNbRRAuugPmbj+vEN/g2Bz+BgUHJQKmuXAnfzsYfUDOj8SkyHI8Yd1nuJs8hfuk/30BQQtR4olaEAuz3MDrwDGzoHte/Vfo+Z44f03DaGnlx+wXnuuoDkcW9DHFDnbapEL6JOuQ4NCvdHnjxO8J6TR3oqJ+iaa1g8qjZWGfIYWKwBgxGWhYOtzYAylZxfBT/i7L9JVjspDz+dFZIvJFHu8yDLYrhWVh+q8fmrHdbnrtIhzRWFSYhsABObmUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OX4tFpYhVZCP+mzspCJDly5vhKM/YINwNWl83/cP9hI=;
 b=UO6JzpHBZaMytTdzzLNQy96rOzQpttDNZMWY91OtZyUHyXfth14rjbOenz69GRQPkjsbx/RnOacUBP5K+BgODgnyNcz5eqaVqRV1UgxlWZZSYE8bz/j/CIvKjq2h7ynmTiw0ESAoNr7Vg3QYIzOe/K8Rv5l1XR0ObWxIEDtnvtg=
Received: from DS7PR03CA0226.namprd03.prod.outlook.com (2603:10b6:5:3ba::21)
 by SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 18:57:50 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:5:3ba:cafe::98) by DS7PR03CA0226.outlook.office365.com
 (2603:10b6:5:3ba::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Wed,
 12 Mar 2025 18:57:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8558.0 via Frontend Transport; Wed, 12 Mar 2025 18:57:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 13:57:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 04/11] drm/amdgpu/mes: centralize gfx_hqd mask management
Date: Wed, 12 Mar 2025 14:57:24 -0400
Message-ID: <20250312185731.211350-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312185731.211350-1-alexander.deucher@amd.com>
References: <20250312185731.211350-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|SJ2PR12MB9161:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e50ee7a-26d2-44da-a880-08dd6197c953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kCiDYlldAUBXcEwgf4JBo8C709DlknNvTVJDTN4Rtbr3Buh+C+XQ1iQK4V9+?=
 =?us-ascii?Q?Tnxyo01ZFSkFI4UVdO2epRrLwMehZ8JL/BctWXf/mGVvasnE453t3qL7oBtL?=
 =?us-ascii?Q?fbARM4hNuAjH0bRflMiDajbsRK+Df2o75Hh03p1RiW02TaYb3LhO/GwB5cBY?=
 =?us-ascii?Q?3w2PRR9pzHkx8NGWHW1AdXljQ4gLIhAXubj64XxJFhNaAyDvIVpEWDVbz7k3?=
 =?us-ascii?Q?Oki4w7aJY+QlwcZvaT7QIucKiZN06DYGMv/NUhFhtevOsyoNuPGMGd0YLKSb?=
 =?us-ascii?Q?OlJ9uYP8yNVJ4FnWTIkpPB50imyMi3TJBuibHY8qpaXLIUqjUNwSBuNZaAtu?=
 =?us-ascii?Q?Y4k7gg0eOUjbtRKJVKiZ7AGpmJF2OK8JevPgFrO+s3YWHqXYM8uRpTgVMn9F?=
 =?us-ascii?Q?x4OZ4cDni1CwPS7tcyJIuCU7F3XIUsF7LLdtueEwChYsGj8rC2FqKGG7zGJm?=
 =?us-ascii?Q?1BtQJ8w+J+AmnrZEVc9/DWebnlU/PiNVbtHMm6phQ6cs5BNqlRp5sOqQAYVr?=
 =?us-ascii?Q?i9CqlDuXU/DVmPA6ybzzGNG49bKy2ae7+hBRWJUSG5pB+sC/VQUT+lzk5yZT?=
 =?us-ascii?Q?Iz7CWYfnP01Ts4jhxeP57MAS32UMneHJtmIl3rlr8aCrP5/NtXu00BZSbbIx?=
 =?us-ascii?Q?y0MDzeJyA7RwAZJlbnnTNwDdQxDNuziRiIQMq+kdj6LJ6NcTRHE/vYWpfP12?=
 =?us-ascii?Q?1GpYGABy6KVo6wzDW/PGzZNIm4SKNqXtFckjCAADReCis/wFRjS87jx4cAGD?=
 =?us-ascii?Q?AJmJZzydJdYPE7dDwhSmNh3jgcNUjiK8sQOgoYrmloNZymUW4H1bXcvxi3Ze?=
 =?us-ascii?Q?lrdPWc+G9N6XHD3zQO3OiqMoD2U/dKz9RJXCaOPdSWtacf31EyW1++5RfK7c?=
 =?us-ascii?Q?4pZULjLbaDMPhDDFEK37ms0s608twRfdPinHqQsidstsblpLfyLKdbxI5yfg?=
 =?us-ascii?Q?QCy10FUsdRIhI70BQZO3xgktWNR2DBDFoMKg18qQIrA0nZdxjdvnW62/xLiT?=
 =?us-ascii?Q?txvTTO8bbNnrIeyQkOpOcHwRBxu/LW4uHRBnLlVdWemIQ/+2LUo5zbQ2nUVS?=
 =?us-ascii?Q?LyA2tYaHucP2dCNDleE5FrpFf9q0JTdfWB/NRWVfloZEBNOSY7jViKtofsOe?=
 =?us-ascii?Q?IDSAObcQL9S2uCdwCnZJRToLzx5nmNP48z1lNSNllwa97OvworAIo8lWIdIq?=
 =?us-ascii?Q?gx7VTZCV9+4W9W0EgSsojRtCwf3k7Fq9Qp1TaoX56Mj23ep0r9cj5vm0mv61?=
 =?us-ascii?Q?B/33lIt6oCY6MxCjh5mTaWHSmbvcG79T+6O5SsKyYc7VWfwhdTnBh/00+Vk7?=
 =?us-ascii?Q?sDJZbLJclK6tGVCiE7AOOg65VyGzF4TwZ2WjJAhSkrCpgM7af2OW8AEFVY70?=
 =?us-ascii?Q?N3cxsl8i6JS1lY/P4vB6Kwi01tILHIV5tbmAgSKiuCIXXeIwSane25rNGEzn?=
 =?us-ascii?Q?e6xKhFyVB02kU/qYkFqxseUEItSWmRVmbhORrq0zL9Ym6sEHCCrUCuOuqwuP?=
 =?us-ascii?Q?uY5WVWuh8SlYgFM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 18:57:50.1512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e50ee7a-26d2-44da-a880-08dd6197c953
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9161
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

Move it to amdgpu_mes to align with the compute and
sdma hqd masks. No functional change.

v2: rebase on new changes

Reviewed-by: Sunil Khatri<sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 22 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 16 +++-------------
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 15 +++------------
 3 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 6f5e272d7ded3..5abc1ca0fee98 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -108,6 +108,28 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	adev->mes.vmid_mask_mmhub = 0xffffff00;
 	adev->mes.vmid_mask_gfxhub = 0xffffff00;
 
+	for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++) {
+		/* use only 1st ME pipe */
+		if (i >= adev->gfx.me.num_pipe_per_me)
+			continue;
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) >=
+		    IP_VERSION(12, 0, 0))
+			/*
+			 * GFX V12 has only one GFX pipe, but 8 queues in it.
+			 * GFX pipe 0 queue 0 is being used by Kernel queue.
+			 * Set GFX pipe 0 queue 1-7 for MES scheduling
+			 * mask = 1111 1110b
+			 */
+			adev->mes.gfx_hqd_mask[i] = 0xFE;
+		else
+			/*
+			 * GFX pipe 0 queue 0 is being used by Kernel queue.
+			 * Set GFX pipe 0 queue 1 for MES scheduling
+			 * mask = 10b
+			 */
+			adev->mes.gfx_hqd_mask[i] = 0x2;
+	}
+
 	for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
 		/* use only 1st MEC pipes */
 		if (i >= adev->gfx.mec.num_pipe_per_mec)
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index a569d09a1a748..39b45d8b5f049 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -669,18 +669,6 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__MISC, api_status));
 }
 
-static void mes_v11_0_set_gfx_hqd_mask(union MESAPI_SET_HW_RESOURCES *pkt)
-{
-	/*
-	 * GFX pipe 0 queue 0 is being used by Kernel queue.
-	 * Set GFX pipe 0 queue 1 for MES scheduling
-	 * mask = 10b
-	 * GFX pipe 1 can't be used for MES due to HW limitation.
-	 */
-	pkt->gfx_hqd_mask[0] = 0x2;
-	pkt->gfx_hqd_mask[1] = 0;
-}
-
 static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 {
 	int i;
@@ -705,7 +693,9 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 		mes_set_hw_res_pkt.compute_hqd_mask[i] =
 			mes->compute_hqd_mask[i];
 
-	mes_v11_0_set_gfx_hqd_mask(&mes_set_hw_res_pkt);
+	for (i = 0; i < MAX_GFX_PIPES; i++)
+		mes_set_hw_res_pkt.gfx_hqd_mask[i] =
+			mes->gfx_hqd_mask[i];
 
 	for (i = 0; i < MAX_SDMA_PIPES; i++)
 		mes_set_hw_res_pkt.sdma_hqd_mask[i] = mes->sdma_hqd_mask[i];
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 96336652d14c5..519f054bec60d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -694,17 +694,6 @@ static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe)
 			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
 }
 
-static void mes_v12_0_set_gfx_hqd_mask(union MESAPI_SET_HW_RESOURCES *pkt)
-{
-	/*
-	 * GFX V12 has only one GFX pipe, but 8 queues in it.
-	 * GFX pipe 0 queue 0 is being used by Kernel queue.
-	 * Set GFX pipe 0 queue 1-7 for MES scheduling
-	 * mask = 1111 1110b
-	 */
-	pkt->gfx_hqd_mask[0] = 0xFE;
-}
-
 static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 {
 	int i;
@@ -727,7 +716,9 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 			mes_set_hw_res_pkt.compute_hqd_mask[i] =
 				mes->compute_hqd_mask[i];
 
-		mes_v12_0_set_gfx_hqd_mask(&mes_set_hw_res_pkt);
+		for (i = 0; i < MAX_GFX_PIPES; i++)
+			mes_set_hw_res_pkt.gfx_hqd_mask[i] =
+				mes->gfx_hqd_mask[i];
 
 		for (i = 0; i < MAX_SDMA_PIPES; i++)
 			mes_set_hw_res_pkt.sdma_hqd_mask[i] =
-- 
2.48.1

