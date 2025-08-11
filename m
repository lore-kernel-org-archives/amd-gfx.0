Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A488DC87FDA
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 01:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 463EB10E2C6;
	Mon, 11 Aug 2025 01:05:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TsHHUEH5";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01DA910E2C6
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 01:04:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXqjrVEldyBenXYmUbnV+ou9bys3AGRBtcBr8bQx4B7rr5Rfa/sb0tGpEOsH4rBWFLEgt1+RvW+D4EK8pARawbF2Ke1dea4VPpWJmQQksGg0VvWTyu95H/tAAqIMaTnj0mUHDAD1S9zi90BoKlAMCDcKmv2Tucybx91as5Osn7xOB2uq7O9A/jlrqQXG9vxp21kH1NC3l+RP+gmCcSVcV6QlyM37rwvClZvNkwZXQfaTKpiWJE8qLzsWAFXSp8HjKN2R83i4hyO2kw6g7n0P28D/6jwpWGS85lOmJGZUQoeaHyfh72ZKT8cbGPfTkV5dxWWgdEiyVUQbBRxxLutweA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IiEqDg0+P+EQ1QMna/Zk7/vtqrGj2ALhj5W44mU0i8=;
 b=uGQhvnlvYr/8qz8BBrChPrbKn1A7btAui75Gnw6Cl7XGyByLHAcgHGOL1pui0aHAMOZQ3QjW/fcLSiWDw3fdD5ojnHIi1mUcirncqHbjdfUV28xLTFIJpJTd4/DeGZxamKMzELvT0AEZOPaMXCWmZSdrABr/OWaFf4ouPB0+PjLAN6v/wjpObNFHyKY+qqrQ/F9m2HyU+cF3a8D9j1+1D0ykFnNbVtP/LXFOLBP6qkKgWMhMKDvm7AcfDF+L8j59ODGfqsZGDmysgxiJejXO2HfygHNpAME5G0nYTKxrplRlAjfnbzoVm967zypqrrst48bzlDQe7MWi3Ztkw5LxHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IiEqDg0+P+EQ1QMna/Zk7/vtqrGj2ALhj5W44mU0i8=;
 b=TsHHUEH5ruyI3f0vbWbJv9KrUZeyLSJONPRGGQ3zvzGZkfHU3I2lFIo/tZJUC0iLDbJKuoX23AWlqFkoB+rDsSXzJO9xopcCzoqSl9x882M+PCPGp9KEVKhk07tNP4OyfK0LWaWT4ng1JDT5EEPZT3xf2Hfpi4KLn1q9rbwIQNk=
Received: from SN7PR04CA0213.namprd04.prod.outlook.com (2603:10b6:806:127::8)
 by DS2PR12MB9710.namprd12.prod.outlook.com (2603:10b6:8:276::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 01:04:52 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::1c) by SN7PR04CA0213.outlook.office365.com
 (2603:10b6:806:127::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Mon,
 11 Aug 2025 01:04:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 01:04:51 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 10 Aug
 2025 20:04:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 10 Aug
 2025 20:04:51 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Sun, 10 Aug 2025 20:04:44 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Ruili Ji <ruiliji2@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 "Jesse Zhang" <Jesse.Zhang@amd.com>
Subject: [v2 2/2] drm/amd/vcn: Add late_init callback for VCN v4.0.3 reset
 handling
Date: Mon, 11 Aug 2025 09:03:52 +0800
Message-ID: <20250811010437.1895121-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811010437.1895121-1-Jesse.Zhang@amd.com>
References: <20250811010437.1895121-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|DS2PR12MB9710:EE_
X-MS-Office365-Filtering-Correlation-Id: d48107e0-7534-40f7-78a3-08ddd87313b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RPOkeAAduEYPObDsVF52rHaErnkggUrmQz7Dwb88re2qX7xtGjGV4BsrKKov?=
 =?us-ascii?Q?Y7AzHhPQj3GxyAVkouK2sjs8crVfv23ngG5/Qq/lhzTYjyC5dLm1m13PJUAl?=
 =?us-ascii?Q?pSS31Q63ZERF4dqbwT+nuwRJDwX+r1S5Pp++mMbuGDNs9TqhzV3o8EpiAWW1?=
 =?us-ascii?Q?1pKYnJfMpgl9Aisli211IV2G47lhzu5Bqz/QvtG8OnV7eu2zoxeualpix5BH?=
 =?us-ascii?Q?rBXjOXmiNSF+jB45dtdxi2wk2jKp3Sar9aVoQjENSvCCc1Ye+k922osTnACl?=
 =?us-ascii?Q?2EjaTZoSnVqDW+yP+Grd7ev4uQn7gCoz2Qee5Qa+yoBuIISdHoz97NV4p2OV?=
 =?us-ascii?Q?oSyctPtw03h/ILmpKaZqS6vTq6RBqpVoRzH/I0Wa/qruwRKZQaD0kNqGu108?=
 =?us-ascii?Q?yAbiT2c7BKWhU8f4nPavobf9GViXdiPp8aZsVs6kQnaaSaGxpn8AyPolx32N?=
 =?us-ascii?Q?HYJh3X/D96dxkM6EHHt6Md5ficF/EuM6wlbgsQv4uQzKDYR57jvAwSnC0Uwn?=
 =?us-ascii?Q?o77apA6N+P7eFjXOo7lCq99ODDBpIvSlKr3U4j1HyUted6UKBFJcfauiEkCf?=
 =?us-ascii?Q?gMJf6FvLB2P8bPyTVbsm5UiJSOTAYtAr0ZAzPf1hGAKPXzDs3fEmGrFnmH92?=
 =?us-ascii?Q?rKLSqqoYJIhQ6mJyxW6vFXM0bv4JC+H0/kYckcpnqeGGbFRKsxvuiqhPXaCT?=
 =?us-ascii?Q?J139T2MH188pxqk/WkH5WdG4kqbwpvc8JryMeCYcCf/sYRmm30S6ajES497y?=
 =?us-ascii?Q?+FcBY5pvVw6fgLOkBaQcRqvNeSnrLzQOdFYH8lp1tTjtWFAUAbeay+iWYe72?=
 =?us-ascii?Q?ZAZetfSFEoh74O+b1T0+SaqkrNyaVP3gV9FoJ7Vfs0ZobTgAE5GrjMbcptjW?=
 =?us-ascii?Q?VdrbcAv/x7j0A26GMfMIwtLPCjlctSzWMS/ubtk6/QUcGVein5KFNdmgClYP?=
 =?us-ascii?Q?pwIy1zc0xnpVEkaMQH3iz89vDtkuUEmiGhEeK1yjtmSVlufSSeN98l2RT53k?=
 =?us-ascii?Q?uoqmcKHYYhNTKBlUfFbGF9uIqz8qgu7ZU6dV1qjH+YtUh1bfsIo9+ZSgEIel?=
 =?us-ascii?Q?u0kbfGONW2ngwecYbNswFFIOMTvuzxMbvpwXihM82sAHTU3XYGm5zgWIWB6k?=
 =?us-ascii?Q?l4HvZXgqN/Fcnhe0YG59M/PeFPCloPhZkZNTg9W6IhGggZKw7EGdSRyYKoyk?=
 =?us-ascii?Q?rvBlkGzf21AyTFj0szjH5P1rNQLpxMX9dgkPzsxp1t1aVBx3thkevVclckmU?=
 =?us-ascii?Q?LysPgTOfaE9TT2EAPEHvRyBPd3sb++ExxVecnrmB8WEn3SKLyeUHveV6XnCF?=
 =?us-ascii?Q?6LBhIXbREoYXNvMBFhQTfU0t1i5Qs/BucdijerXj5B3CYm1n499aytG1rQLy?=
 =?us-ascii?Q?Zuw8bg3ghX3+e+XGluknl+rQCvi4wz0ZlkJqZc98kU2LLqv4JU4b0I6O2hkN?=
 =?us-ascii?Q?zz+R9PN6FC0PJ0M1wsD8D7ZOtRlkh5J+TI9O5YfkrfBeXQKegqQBR+h0B2J8?=
 =?us-ascii?Q?w2R4fcDrF9F0dWMkkTvlarwIeXfL8+wBotPs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 01:04:51.9311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d48107e0-7534-40f7-78a3-08ddd87313b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9710
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

From: Ruili Ji <ruiliji2@amd.com>

This change reorganizes VCN reset capability detection by:

1. Moving reset mask configuration from sw_init to new late_init phase
2. Adding vcn_v4_0_3_late_init() to properly check for per-queue reset support
3. Only setting soft full reset mask as fallback when per-queue reset isn't supported
4. Removing TODO comment now that queue reset support is implemented

V2: Removed unrelated changes. Keep amdgpu_get_soft_full_reset_mask in place
    and remove TODO comment. (ALex)

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Ruili Ji <ruiliji2@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 019bd362edb2..03fcd6833c26 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -134,6 +134,16 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static int vcn_v4_0_3_late_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	if (amdgpu_dpm_reset_vcn_is_supported(adev))
+		adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+
+	return 0;
+}
+
 static int vcn_v4_0_3_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
 {
 	struct amdgpu_vcn4_fw_shared *fw_shared;
@@ -211,7 +221,6 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 			adev->vcn.inst[i].pause_dpg_mode = vcn_v4_0_3_pause_dpg_mode;
 	}
 
-	/* TODO: Add queue reset mask when FW fully supports it */
 	adev->vcn.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
 
@@ -1871,6 +1880,7 @@ static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev)
 static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
 	.name = "vcn_v4_0_3",
 	.early_init = vcn_v4_0_3_early_init,
+	.late_init = vcn_v4_0_3_late_init,
 	.sw_init = vcn_v4_0_3_sw_init,
 	.sw_fini = vcn_v4_0_3_sw_fini,
 	.hw_init = vcn_v4_0_3_hw_init,
-- 
2.49.0

