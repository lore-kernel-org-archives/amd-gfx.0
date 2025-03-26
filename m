Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819A4C36008
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 08:14:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23FD510E558;
	Wed, 26 Mar 2025 08:14:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S08x2s2+";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEE4010E558
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 08:14:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMnTTvSJHlO13gm8PibwmpLOtwzzmwpe/7RKnXAO0SRYYilaHlu7ppirEd2dtkvNmZ9UzQsX3aR5afHRRJTsjl4R1ful+r6R/E7CPK95l4qT7d0RudKVqoiCC46d24vedpWJhXZoi47w1KynGVSL4boJjkDzdhzlzB2qltzrIbTwDRkP66Rs5/3L8kmCLJpQFMCEMgLHcJhxPo+1GjVLGsN+R4GA2RXHdULZva7Vt8c2zGcYbll63d0jtIhZ4gg+xqowI2UbvcVi4yvCMsiIYdR7fquDslIeemgeSlR45O6JRLuLwLfrPdGvoYTu2gtarb0+InzvXvhuexqTsqBnDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJY4PLeBzGwwpWvlWn6HFQ7Bk5iNQ9hBvVi/yMvo99k=;
 b=nIHBko2zykTg+jrRBOOCJPsBSEgYFjSbSeIuzhYZalnvs3Adt4Ad91H5nGfvg+ooUX/EeRgNNEy/EKKNba92zmMKz4MC6e3B3059/p2xFFVB5CuABWEf6a6FPGcyatx0+j2eSgsL+834pxNq03sT5pnEzFnoDWKWnDvNHxiU9Rgmq7KSD2yjQSX7hSzd6l/oAmh9i62aO+fOiWpHPUoCcvhoigo//dpDabdnAidV5D5JAKzzwVPYQTXyxLvxOflREcpDIGi9JiwEyZ3/eCF/hJc7INV5gnAAgkWtG8k3wwgVw7oZickEuHSrPUJeciAOFKhT4tDEUMcMDbyVrW96tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJY4PLeBzGwwpWvlWn6HFQ7Bk5iNQ9hBvVi/yMvo99k=;
 b=S08x2s2+VAIryd0GJ5h7AVFfPGH1KFbFsb+MyS9+W3mcY2qsSwPKhzwG57uPJGCk4dmpAKAaQt8kXwjEV12fBmJBq20OiWb/aJeAf+uuRYHPERA5ZhzfxcWeeySc2Orlv/Ub/dR+aBP6SXNftQQl5wY4qCEn6qqwoOrbDmTBceE=
Received: from DM6PR18CA0007.namprd18.prod.outlook.com (2603:10b6:5:15b::20)
 by CY5PR12MB6275.namprd12.prod.outlook.com (2603:10b6:930:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Wed, 26 Mar
 2025 08:14:16 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::58) by DM6PR18CA0007.outlook.office365.com
 (2603:10b6:5:15b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Wed,
 26 Mar 2025 08:14:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 08:14:16 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 03:14:13 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 1/6] drm/amd/pm: Remove host limit metrics support
Date: Wed, 26 Mar 2025 16:13:55 +0800
Message-ID: <20250326081400.1305136-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|CY5PR12MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: ea08dcb0-8795-42c4-8049-08dd6c3e3368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TVHc6itgqtxbT2X0hncbcRAkaxq04uwkILPB4kCouyeoK/rNDJRT4HNh786d?=
 =?us-ascii?Q?/1a8RmTVR8hPmAEuRdJu0Gz7vvtXiLzd4V6TJdO4Ofay06KzVmDalCZnAbBP?=
 =?us-ascii?Q?cbilyz9UftsiXY3BPxh7uLEDA+YRJ3NiGKQx9d9sUB1ys5XXT7C0yKpaApt9?=
 =?us-ascii?Q?1dGChyQZPtgZMSCYUJLcKWZewUwutEcGVdh2403a/rOPKxMTZ+iU8KMH0oCe?=
 =?us-ascii?Q?3B3K+YJm5ajZu6hdnxRQBG25UiBl5kUwlA64zSOWbjpLvj+XTVibcnMqOFkI?=
 =?us-ascii?Q?Wt/1ccwGoaeAv9dZ4QK/HZ6biiLgV1ObuM1Utd/dnmy5G+9LQvted8YVrGWr?=
 =?us-ascii?Q?tYPAHo/6gPWXyf8GtA3DK89aaj0KZ63EFoeWVH/C5HVVtQ4Q8C0I3SUzFvZO?=
 =?us-ascii?Q?RDHGDgT9evjVZKSsh5kU8G79BhdS2DsSGtlUqiaZvKD4HUHWcQSOxf7hhXuY?=
 =?us-ascii?Q?PtMosJwt2zmIV5Beo8xBliaw0DopeNHUxdN586DSqkqR0WxUSxL7na5DVflr?=
 =?us-ascii?Q?tofKWOsouZqLCV+6WKDJxoDljoznt0tWzXk+DusLh9UWtv+Of3hC+k3S0wLu?=
 =?us-ascii?Q?V9bQa9TRPcyodEikhaE2mHU7QaT0RtwWpcf2COOe/5LuOaBDneY5ke1LXS1+?=
 =?us-ascii?Q?F1NeMPNwg7VMUtZH9Jm0vjmUzGfaGaqeZlH7n73ZzUrnVJj83jr3aKYlTREW?=
 =?us-ascii?Q?baqnQmc2RnwRS4lMWLvwP+hAm1/2zTpUA72IkF2tWUb1BgKwpUR0rlPoB/7/?=
 =?us-ascii?Q?uXTA+jo0753nQevUu0yHwEIn5wi7t2c65Ozr9aIIOthzMAA6DaNigJc45oD6?=
 =?us-ascii?Q?kKg4RglCGnhuDyCHoHBx23YfD6g+QMJ5NKco194z+GgAl9OBV3tCfYFyVeAN?=
 =?us-ascii?Q?Kans7rivioYletcLk87AEyrfPU52KDr82vt4Zz4gzF2a8yD6dQ38PgDGREqB?=
 =?us-ascii?Q?wH4C/7ubJEJq8z1YlZhjb86o5K2OEEZC380rVJochz4403fQ3RyJjjPdXdnP?=
 =?us-ascii?Q?/c6pX8kjc76/xJ1cJS+Eiee95SEcqS8Y2YK84wZDWZ+2kdVQIR0q8Xj9DYIy?=
 =?us-ascii?Q?eV7tSWU59RNwex9ZpIXLW8tBU5lxfz1hCf0SrAEdF6DyI1SVUROuwTZ8s24O?=
 =?us-ascii?Q?VXvc2xbaItXBfma67mudd9HHCMxaYJjjX9xKRglJ6Z4aSB6/7ZsjEBhwILNN?=
 =?us-ascii?Q?iY2dkJeIA3pZ1MiaFJmtdtqNhJXgSSoG9lwHCYkXRRtItzDlLFZKQUzkT/u1?=
 =?us-ascii?Q?lkVFaCj8SWvQ+9wuys3Cv5pW5MdDxUB53b078iu16TOj3FYBM1d55V9YoQpO?=
 =?us-ascii?Q?8Um1eoZvX429qlUg9B95a1Vnj3R0gdVXThvr7gxEvdZXQtCZvQVpyp7H0C7M?=
 =?us-ascii?Q?0eXXl79gogTg3Z6yzvdOD1GcxZN8IDXRtDB3WIRrTHD6YAuY9g1iHSwOXUlb?=
 =?us-ascii?Q?KNGqsDzDstc6GADKRhRGmWvAoaRH0sUDzGdBYQYCVscSAF8Y8Kgqo+xKwt/w?=
 =?us-ascii?Q?8WVPly+IWhVJXnqE9CYg0XsxUkquGkNsCkFE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 08:14:16.1174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea08dcb0-8795-42c4-8049-08dd6c3e3368
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6275
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

Firmware algorithm changed and the values in this version
are not accurate thereby remove host limit metric support
for smu_v13_0_6, smu_v13_0_12 & smu_v13_0_14

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 6fc8f5f7fef8..9264dc33ee7e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -109,7 +109,6 @@ enum smu_v13_0_6_caps {
 	SMU_CAP(OTHER_END_METRICS),
 	SMU_CAP(SET_UCLK_MAX),
 	SMU_CAP(PCIE_METRICS),
-	SMU_CAP(HST_LIMIT_METRICS),
 	SMU_CAP(MCA_DEBUG_MODE),
 	SMU_CAP(PER_INST_METRICS),
 	SMU_CAP(CTF_LIMIT),
@@ -325,8 +324,6 @@ static void smu_v13_0_14_init_caps(struct smu_context *smu)
 
 	if (fw_ver >= 0x05550E00)
 		smu_v13_0_6_cap_set(smu, SMU_CAP(OTHER_END_METRICS));
-	if (fw_ver >= 0x05551000)
-		smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS));
 	if (fw_ver >= 0x05550B00)
 		smu_v13_0_6_cap_set(smu, SMU_CAP(PER_INST_METRICS));
 	if (fw_ver >= 0x5551200)
@@ -342,7 +339,6 @@ static void smu_v13_0_12_init_caps(struct smu_context *smu)
 						     SMU_CAP(RMA_MSG),
 						     SMU_CAP(ACA_SYND),
 						     SMU_CAP(OTHER_END_METRICS),
-						     SMU_CAP(HST_LIMIT_METRICS),
 						     SMU_CAP(PER_INST_METRICS) };
 	uint32_t fw_ver = smu->smc_fw_version;
 
@@ -387,8 +383,6 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
 		smu_v13_0_6_cap_clear(smu, SMU_CAP(RMA_MSG));
 		smu_v13_0_6_cap_clear(smu, SMU_CAP(ACA_SYND));
 
-		if (fw_ver >= 0x04556F00)
-			smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS));
 		if (fw_ver >= 0x04556A00)
 			smu_v13_0_6_cap_set(smu, SMU_CAP(PER_INST_METRICS));
 	} else {
@@ -408,8 +402,6 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
 			smu_v13_0_6_cap_clear(smu, SMU_CAP(RMA_MSG));
 		if (fw_ver < 0x00555600)
 			smu_v13_0_6_cap_clear(smu, SMU_CAP(ACA_SYND));
-		if (pgm == 0 && fw_ver >= 0x557900)
-			smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS));
 	}
 	if (((pgm == 7) && (fw_ver >= 0x7550700)) ||
 	    ((pgm == 0) && (fw_ver >= 0x00557900)) ||
@@ -2674,13 +2666,6 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 				gpu_metrics->xcp_stats[i].gfx_busy_acc[idx] =
 					SMUQ10_ROUND(GET_GPU_METRIC_FIELD(GfxBusyAcc,
 									  version)[inst]);
-
-				if (smu_v13_0_6_cap_supported(
-					    smu, SMU_CAP(HST_LIMIT_METRICS)))
-					gpu_metrics->xcp_stats[i].gfx_below_host_limit_acc[idx] =
-						SMUQ10_ROUND(GET_GPU_METRIC_FIELD
-								(GfxclkBelowHostLimitAcc, version)
-								[inst]);
 				idx++;
 			}
 		}
-- 
2.46.0

