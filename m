Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE8CC19F53
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:34:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60EA010FEFE;
	Mon, 29 Apr 2024 14:34:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="btLOoHd5";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FA1710E37F
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:34:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0Wj1IKIZD0Lmlvsl3wcWfz7i2uF07gY9kvnHdUJDXVJrJnoDzJgVetizeS5vUh499eupLFyJ/wGmMNIwUqYNwnwfzmnD8Pu0sIw/1C3g82QZTm5CYISet0lqKEEhD6hljHPnreVfHROUTOq3SIF0CgFoKnaLUdFQ2S90pYp5IcwzLfaIObeI8TGBk+M2NAEGVaI31n0aD0tsZja+AfhqMy+2Ifgz9+eiwXwJ7TNB4dF6ZwSSaxkyYdHwtu/yxRUADAsThN+O7S66Ms/jx9RavEAEhTQXAX4p99wlkyoJecbzmrweu86yYz4Lug9+5+D3LbZLzFhtKjkW2h6m9/N3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/n3kd+FMzZbruLYF9HnzbyfF7QaGhOcSvel9q6gYePM=;
 b=EDEFGUbLaBRwDmg1RjmS3LS/i3iiL8EMBmcYfTScX64TP3f1qr3BfW7rMkOLJvt06MBTbmSgZFa3IXUPz7AepgrdeUgDn5d9NMkYWSS4F6pLU3oiq18NFIlcQJ4R/NS4IQkGeTjxFvtn+AV0GtBi6ThRN0/t+uPidhtcownWZeNS51N2vS7LUsBKtRQ7rGw9Gh1QfStpKoTYhep1oyKQ/V5qdjMiN8Y7eQlqaBEJTW1s3/y/Iqc1ZOsNmqnv+MdBqj6GorqogjreG5cVhWeFoeT7f/ufwDbKByZD5CErUPi/qmmGlwyGhsTWFpZkTe3ZSMxBn00kSTwlnbyu4kQwxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/n3kd+FMzZbruLYF9HnzbyfF7QaGhOcSvel9q6gYePM=;
 b=btLOoHd57wD64a6fLAx87s8NKoRxev87H/w6xs0dJMxReCmmdVBn746rMImf986apaaN8TeJCS7jHw3+0Qw2VHBvNeFkzvyiBbUYd+boaNpj9ZR2G7j28JkK6ssUYPIbU+hAtRjk3ov4SL3f5HyDaRaZfd/UWl9890ozUDZrO5M=
Received: from SJ0PR03CA0353.namprd03.prod.outlook.com (2603:10b6:a03:39c::28)
 by BL3PR12MB6546.namprd12.prod.outlook.com (2603:10b6:208:38d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:34:06 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::ef) by SJ0PR03CA0353.outlook.office365.com
 (2603:10b6:a03:39c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32 via Frontend
 Transport; Mon, 29 Apr 2024 14:34:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:34:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:34:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 05/31] drm/amdgpu: add rlc TOC header file for soc24
Date: Mon, 29 Apr 2024 10:33:13 -0400
Message-ID: <20240429143339.3450256-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429143339.3450256-1-alexander.deucher@amd.com>
References: <20240429143339.3450256-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|BL3PR12MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: 78253868-7cc9-4cd7-5f71-08dc68596c0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4ohj2LsDQyb55DkcLd6STMWbYrjD5+BTdCyoYZYoy4SNBw+oBiKWqZFA2rw9?=
 =?us-ascii?Q?ioLLp5uvq2WNw/0iIPfLQAsgQbUxfFPA3e9toBoiKlLH5RYLgLqABRcXXIob?=
 =?us-ascii?Q?HRZJqrb6a+wilhT2BNDrkqK0JW89lITjfxH7qK3AymuXYJhAK3JrEamGOHLv?=
 =?us-ascii?Q?xT6xD+5Ge2XmT/WnvFnpZ/XxJBZ4pHz92NaOKO1Rw7Gztpi5/y4z5co3abIj?=
 =?us-ascii?Q?oWhIfzbWDL1UGhnxSvI88WE+fu8IQ+NGow/VUYH+xTFFXd24PET49dG1ifrd?=
 =?us-ascii?Q?cA70VrJSt+BpTQuNr8o3Q3sd37tcTzaOwEWpp2JFNwS9jj0sKJBSvpeU4U4m?=
 =?us-ascii?Q?9dhmJnqOyItWA1hrYniL9lOPF6kZE+4wjYwfzsK1j6q48FVdxTIurbIqMAoQ?=
 =?us-ascii?Q?ZpUlorU+6j088GKxkch8UHJ/fQ78fX/7UGcD1erJmLp0xWwbnbPPLatTOql8?=
 =?us-ascii?Q?TBr1Fce5+B15eVR+I+bODIZMXrMTO0Xbqq2pDKbh8xpSiJlGO3rdggp3upsz?=
 =?us-ascii?Q?oVMI56s5RYgonx4tONbsTAmFsQ/3AXnDLuXR6MvUj8nZj5X/YQEQATav21hB?=
 =?us-ascii?Q?NkSrcl9qNENyaRv3PBZNGMm52k4Qz7LAlk3i+EC5eiWDIPkewIiCWMfvo3bp?=
 =?us-ascii?Q?PVSk9ZOIgH7qW5Dt4NQAyYGV7CARGMGpyw6j2g+BSsRDNV52XwYKCxrX8Uyl?=
 =?us-ascii?Q?Ilfm+oxKcn0vHOh1MHD1N2sIiQk8yO7WE3gYAvibVNGRQADzA9sbzMdQSXj7?=
 =?us-ascii?Q?YNhrs/OMIJKgcMRat7QxPy3P75Vi94uw9+umKlQvjNVUl98Uu6/33Ub1lMZE?=
 =?us-ascii?Q?akgPh26tufp/Hyc/aDYoMwliZqtBFEBM+DbNbTQAgJz6dmL/29w6SS8hO3HB?=
 =?us-ascii?Q?KG6mqNS4VxyXyqmBY5lO6movhpSytZ9y6cdUTE6M63bOl0BRi34T7shxEWW6?=
 =?us-ascii?Q?7y5tqwD0+skPESxlAYQyts3ZuO7q0m21o5bGHRP1ccrH07ub1WSFPc8tLbfv?=
 =?us-ascii?Q?+FP7mi4qas6w+CPxNqlcJub1cRu1HOXpLiD7kZLTvV+VDNe8VxjwS4+vhq+N?=
 =?us-ascii?Q?Hwt2aRU9lpkIwguqix+IgOYFniXWtjRImIpsOYO/QZ8srVJAN0PQ6FU4wqvi?=
 =?us-ascii?Q?bmvUQYAzAoLoWPQCXix98Z5v3+LHAx1Ll4lU9bRgHICXhNZxukufWdv9wMZl?=
 =?us-ascii?Q?7V+pbmd/7HMwyCW57up1K8bZzx7mb/N7RKq3iLsLCTDDxzvzzcQ9fSKWbdkx?=
 =?us-ascii?Q?ZAiNcd/EYjk6qOb4LMWIZreX8+mJCerTDSSkBDMHapdajHO01kftEnkYYbyW?=
 =?us-ascii?Q?jCKuAKo52/r6sFeqMu8bMzSMb4V/hC4e/NeHg26mHmlWkqqWadm7NdlN4fbn?=
 =?us-ascii?Q?IQSb0/s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:34:05.2777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78253868-7cc9-4cd7-5f71-08dc68596c0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6546
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

From: Likun Gao <Likun.Gao@amd.com>

Add RLC autoload TOC header file for soc24 ASIC.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h | 47 +++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 0614de6c122cb..fce22d3f816b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -112,6 +112,53 @@ typedef enum _SOC21_FIRMWARE_ID_ {
     SOC21_FIRMWARE_ID_MAX                         = 37
 } SOC21_FIRMWARE_ID;
 
+typedef enum _SOC24_FIRMWARE_ID_ {
+    SOC24_FIRMWARE_ID_INVALID                     = 0,
+    SOC24_FIRMWARE_ID_RLC_G_UCODE                 = 1,
+    SOC24_FIRMWARE_ID_RLC_TOC                     = 2,
+    SOC24_FIRMWARE_ID_RLCG_SCRATCH                = 3,
+    SOC24_FIRMWARE_ID_RLC_SRM_ARAM                = 4,
+    SOC24_FIRMWARE_ID_RLC_P_UCODE                 = 5,
+    SOC24_FIRMWARE_ID_RLC_V_UCODE                 = 6,
+    SOC24_FIRMWARE_ID_RLX6_UCODE                  = 7,
+    SOC24_FIRMWARE_ID_RLX6_UCODE_CORE1            = 8,
+    SOC24_FIRMWARE_ID_RLX6_DRAM_BOOT              = 9,
+    SOC24_FIRMWARE_ID_RLX6_DRAM_BOOT_CORE1        = 10,
+    SOC24_FIRMWARE_ID_SDMA_UCODE_TH0              = 11,
+    SOC24_FIRMWARE_ID_SDMA_UCODE_TH1              = 12,
+    SOC24_FIRMWARE_ID_CP_PFP                      = 13,
+    SOC24_FIRMWARE_ID_CP_ME                       = 14,
+    SOC24_FIRMWARE_ID_CP_MEC                      = 15,
+    SOC24_FIRMWARE_ID_RS64_MES_P0                 = 16,
+    SOC24_FIRMWARE_ID_RS64_MES_P1                 = 17,
+    SOC24_FIRMWARE_ID_RS64_PFP                    = 18,
+    SOC24_FIRMWARE_ID_RS64_ME                     = 19,
+    SOC24_FIRMWARE_ID_RS64_MEC                    = 20,
+    SOC24_FIRMWARE_ID_RS64_MES_P0_STACK           = 21,
+    SOC24_FIRMWARE_ID_RS64_MES_P1_STACK           = 22,
+    SOC24_FIRMWARE_ID_RS64_PFP_P0_STACK           = 23,
+    SOC24_FIRMWARE_ID_RS64_PFP_P1_STACK           = 24,
+    SOC24_FIRMWARE_ID_RS64_ME_P0_STACK            = 25,
+    SOC24_FIRMWARE_ID_RS64_ME_P1_STACK            = 26,
+    SOC24_FIRMWARE_ID_RS64_MEC_P0_STACK           = 27,
+    SOC24_FIRMWARE_ID_RS64_MEC_P1_STACK           = 28,
+    SOC24_FIRMWARE_ID_RS64_MEC_P2_STACK           = 29,
+    SOC24_FIRMWARE_ID_RS64_MEC_P3_STACK           = 30,
+    SOC24_FIRMWARE_ID_RLC_SRM_DRAM_SR             = 31,
+    SOC24_FIRMWARE_ID_RLCG_SCRATCH_SR             = 32,
+    SOC24_FIRMWARE_ID_RLCP_SCRATCH_SR             = 33,
+    SOC24_FIRMWARE_ID_RLCV_SCRATCH_SR             = 34,
+    SOC24_FIRMWARE_ID_RLX6_DRAM_SR                = 35,
+    SOC24_FIRMWARE_ID_RLX6_DRAM_SR_CORE1          = 36,
+    SOC24_FIRMWARE_ID_RLCDEBUGLOG                 = 37,
+    SOC24_FIRMWARE_ID_SRIOV_DEBUG                 = 38,
+    SOC24_FIRMWARE_ID_SRIOV_CSA_RLC               = 39,
+    SOC24_FIRMWARE_ID_SRIOV_CSA_SDMA              = 40,
+    SOC24_FIRMWARE_ID_SRIOV_CSA_CP                = 41,
+    SOC24_FIRMWARE_ID_UMF_ZONE_PAD                = 42,
+    SOC24_FIRMWARE_ID_MAX                         = 43
+} SOC24_FIRMWARE_ID;
+
 typedef struct _RLC_TABLE_OF_CONTENT {
 	union {
 		unsigned int	DW0;
-- 
2.44.0

