Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AEDCC282EC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 07:33:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8568F10E2F0;
	Fri, 14 Mar 2025 07:33:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ck5n7We6";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19E5110E2F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 07:33:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQqNa/ogwIxD9EeUJPP4c9i6hgIbRAf0zSsNAUaHLk9ps5WUgHV5Xk/dPwoUlr6igS6+En9OfToK48f+sClBZdPkHpUsyHaOSMAgx4jACi0hSsOY29omNpbD+qg8Efm17cYOfW/zLK9NETmG4Q62I7M43rvkQdWp8euGYXPE0nMcgRph8dkddA3pcFoSMRQshbh2WEk2w3/LAbkgRugKK4HKQ9rWI23JujaIMx0zw3Vfq0/2xd76RwPcqRDBQFDfEBJnLSGasH82NuIMwGBmEk0b/oie0jvKiWq93QP05VeLYG29R4lLPkncr0xLydiiGG2h5OtObMA6IQgKFC/c+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuuSDErD/nxlxxP+D3LeQ8XZjs8TlDR88JWzNr7ibl0=;
 b=AeNQ1v/UXYp7UElSGRw8Dq8aMRBpwOgpCamK8OUFoiheJjbaNY4UAn+ZJH3PYXFdUywHfCpTiFGfa7euXXRL3/tgbCOHTjTf53xc6qdWDh7MMMFWXzTCTQqwsXc47TGe8RiBCggYQNmjSExrIEa3hJD1EtRfLNatJuEib9U/6l6bJg4nR9HRqd1NTjSkWXWfu+uMIrDsxBuVhA5cu6CvF0kDMlTsbUewPaOgvIANrvYmGrjHPUQNFH73nGhU3F3AkI2Ap4gw1DevNVSEwhFynV5iHiGsXQ1KSV0NHfRoBrYZIOe1N2j6qqidX2vLLyRjuElCu0ux/tNb3PlZ/q7CNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuuSDErD/nxlxxP+D3LeQ8XZjs8TlDR88JWzNr7ibl0=;
 b=ck5n7We6Yghi4Trsrf6+wotYEVzqieHHsOz6h9/fPwI9f8b7pMBQil22VzcV1xWKsEZ9f2InzwBDwLzePcgrIDSG0Dkkr1u5Y9hCNwWYidUtEtq9PeyN+i5j1dNnUT2hhgcS0Fey9X/Y9inSVnIkbEPx4DxGRYjZwvqViQlqVkM=
Received: from BN9P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::28)
 by SN7PR12MB6816.namprd12.prod.outlook.com (2603:10b6:806:264::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 07:33:40 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:13e:cafe::82) by BN9P220CA0023.outlook.office365.com
 (2603:10b6:408:13e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Fri,
 14 Mar 2025 07:33:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 07:33:39 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Mar
 2025 02:33:37 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: Add active_umc_mask to ras init_flags
Date: Fri, 14 Mar 2025 15:33:17 +0800
Message-ID: <20250314073317.641951-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|SN7PR12MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: ca1bd300-2f59-4ae2-2da2-08dd62ca8a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zoacGGNhkREiRdxC/cowuawGqeSVo8ZIdrh65etRwgp2qFx9zyMEoHoKxBaE?=
 =?us-ascii?Q?ddgQswaoP4kxcYKvOzsTyy8Fo8Ge54ZTIMZ80ZmNhnZ+n9pM18YEP+yBQBGZ?=
 =?us-ascii?Q?+oo+gAQT8gSfpkmNLrGLn4dC/q68zd97gryarlWXwd7GsLhOuDahg8inmXXH?=
 =?us-ascii?Q?piXZyJbGUEKg9bgNsiZW8uA547VXtNeoiwcvKx8YF2AiM9JzPMl2Xv/gMD+k?=
 =?us-ascii?Q?Og0GTjDyGAe7BvafkS/CoUR8CdsM4ICx4Qevuav8ZhPpJldr2uLQWagW2/uY?=
 =?us-ascii?Q?jwsWXobQYlMEFAlpZMc/hovE+uk/iFFTBpWDgknA4MmC11HIqw+r4o8m3k2M?=
 =?us-ascii?Q?hddtCyCF++exjZO3/4mBKrhUdtf5zPwOQIMWu81b7tU/yfP9wdz0GRo9a97f?=
 =?us-ascii?Q?cvAQmrVRIaQ9SMLRXV31dXofNVnMDCbTG2tMla2c4t1kQ/zUR+0I8DBjMyix?=
 =?us-ascii?Q?FP3VcVaiiVRd8MGu2IRYf3nsJJnJpy7SvWmkLBYeojj15OErROM+xgKA5qCF?=
 =?us-ascii?Q?2sLYO5LOe0dTic0NaqwbCM30yPcoHU9XaPl+IjJXiVIBeW+XHodqZ3tZy9dL?=
 =?us-ascii?Q?UN+RE2gK0Z8DTMa7we1zYaUD4yk9XKnF/+zdgqVrHVTT/DMN7HEE37A0Qqli?=
 =?us-ascii?Q?DTVeqDidin/f8JYsLaMjBH8pGSna+z60utR2jJbGy4E9wYU4k0m8Z4kSpxgS?=
 =?us-ascii?Q?8Rqxn5FU5X3s+td+Pl+MYfeo7TTWYpC5LmTKgAGXvNam+rPez+73qKxMnN2l?=
 =?us-ascii?Q?CL0Lqsay3AqPUxK3EYB/oBA0EBW55EzIf/HV6/3wkOXA4Nuc9I8BqI+bsjOS?=
 =?us-ascii?Q?rltz6Cqchw/q/B87tL0zNYuJTRK2kVekJiOUGd1IvckrAtRDFsVE85lq3kj5?=
 =?us-ascii?Q?BAgI14c3tNYABLRjByaVzol/qJBGCmTnu2dmiwBoRezprvs61i1KZGDGmjaZ?=
 =?us-ascii?Q?HnYNYa0x1R3THkhh6wqYV66kypHXFDM9mV3QOlwyxqwN0YSUENsCIdCnakFC?=
 =?us-ascii?Q?QbwdXBRBvpC9TR9IZUiXfvWRn7aNiuUWYVMhMKcxuctHLgHcg1A6uDXO4pnM?=
 =?us-ascii?Q?gCdtMYuDTx1zIyphfHoIcZNG17TgWEjpSogDAu1q/Nb9hwr5UXRUi3GnYXYT?=
 =?us-ascii?Q?OQP3UBz8DRSi+JBGRYIFQAas3Ns8QJBwHpAHT3wCGktpsz8mmdgKgLEobTQ9?=
 =?us-ascii?Q?0SlQsLGJJliRs2UVedQsyNKyWts+7AQb9qQBhz9YXeeWOPUGqjsdhXNPsT/u?=
 =?us-ascii?Q?VR1yTFbq43AWEOYskG8BmGKtdrliSt7HMpt5C4mxlxII1C6KK6mV10S/fWsv?=
 =?us-ascii?Q?Y2O242H4GVlIv7zyX7JN1x36AE6BUBid7asSAFZS3jIPKMeZaSipMH8xJTB0?=
 =?us-ascii?Q?BPCWIO3kyesBZBxacEMS08eVvevdIYYSpe6lZi9fwgx+GI4IJephQrllqj9w?=
 =?us-ascii?Q?+9pjQNXbyAKdCrCyQ3V9W7LZnMM1WkVjR7f9o9Px5dvFeF5JfQYrCWSUlEF5?=
 =?us-ascii?Q?auIcAVP+Xlk4M2Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 07:33:39.6774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1bd300-2f59-4ae2-2da2-08dd62ca8a25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6816
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

Add active_umc_mask to ras init_flags.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 1 +
 drivers/gpu/drm/amd/amdgpu/ta_ras_if.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 79dad75bd0e79f..d3b05b7020c84d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1861,6 +1861,7 @@ int psp_ras_initialize(struct psp_context *psp)
 	if (adev->gmc.gmc_funcs->query_mem_partition_mode)
 		ras_cmd->ras_in_message.init_flags.nps_mode =
 			adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
+	ras_cmd->ras_in_message.init_flags.active_umc_mask = adev->umc.active_mask;
 
 	ret = psp_ta_load(psp, &psp->ras_context.context);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
index 64891f0993666e..a3b5fda224328b 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
@@ -151,6 +151,7 @@ struct ta_ras_init_flags {
 	uint16_t xcc_mask;
 	uint8_t channel_dis_num;
 	uint8_t nps_mode;
+	uint32_t active_umc_mask;
 };
 
 struct ta_ras_mca_addr {
-- 
2.25.1

