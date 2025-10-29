Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DECCCF9EB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 17:52:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4240410E218;
	Wed, 29 Oct 2025 17:52:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yqDVVHUM";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010062.outbound.protection.outlook.com
 [40.93.198.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AB1A10E805
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 17:52:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMU3J7py2VfdwaA/fheShJHsNHH9tucfYK/n2vsEOPRlX7u9IdFtxlpbmO7dP08aOqnbA5yGlRpmZwnR2XrL2Cl21TkFNLGEH3k7QUHjPbHNZ5CXv7OTiMFUtyS4M9cQvTKF6G9sqVRnSpyTnZTvHMVBuecLXrk5AYgVb240792phm5MEI1pJfcSiTlJ9fJnFj2LRK+c9VmtEsdvOd+4S/VMrcAjxK1FE/rEbBddakR8Cu8Ayk22ClIDhmp6EIt2NFqFzSLPKv3v2B2047xSikz/BvOSaDKBIbET/XGWmlyXZMaXQgSQSxFRdRG4P9vGwTzvPGTqtM9EJy7dc7/xEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qrTYNOpNHBseWfmnb4/HAzQuWqEFpBl26jSwCvW8wk=;
 b=mg11EDN+zRl9jZySm+MMfShhkytOTvFu4L+algvF/gnCn/aU7EisrF8k91EWSH3emle76hRGMXK0elDBDHIExxPJdg/cVcOq5++/HGu+FCuzisDcx0g/gusIVxslL/mhg2U058HautBuCBL90iQLAqV2CQRO96qewDOy8vs+h3fqeLdbSxbtS5RYAfQtkP3HCOxADvSkyqlTihtqMrO/KecIP0do9+MdxEbagc/6Ins/sPx5fI0QZvMVUU/zWs/Cfwt3w9cNQk41jfPDmqErPbf4ZAWUZ0tQ0FQ4Yw3HWB0ln9yvmuZQMKgvCzIKSEEJCKVkhbv1SYR8mU4gmi3zXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qrTYNOpNHBseWfmnb4/HAzQuWqEFpBl26jSwCvW8wk=;
 b=yqDVVHUMAwFp5D0kE3uyJ8Gny+ayCMKiRmDXkTDl9tAoMnYGjpaCKVF+zvOOupxg18X6BwkwB4IQNZv/TP5j9fIbSOXAPQtuyutH1nLkPgQBvOsS9ouRdLOP4QajcLuaBLvlYn02BomBo6Gv9aJmbRoR+irnYxGmnwzxYb3ZG7A=
Received: from BN0PR08CA0008.namprd08.prod.outlook.com (2603:10b6:408:142::30)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 17:51:56 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::e9) by BN0PR08CA0008.outlook.office365.com
 (2603:10b6:408:142::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 17:51:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 17:51:56 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 10:51:54 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add hwid for ATU
Date: Wed, 29 Oct 2025 13:51:27 -0400
Message-ID: <20251029175137.2861556-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029175137.2861556-1-alexander.deucher@amd.com>
References: <20251029175137.2861556-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: 50aa297c-3580-4f45-e75e-08de1713d9e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iG+57zavIN+gngGPatz2xUaGgw1cr7vnB6nEq0XgBuFdco6QWdZZYEWg8vIK?=
 =?us-ascii?Q?sg1UnB/tdenCd49p/vwP/6tZoGvLh3aXzOSd7g4anSyylX8l++xRBAb5YHet?=
 =?us-ascii?Q?tbb/+t1e1X0pwo4t7aEg13n+1Xh6N+EHdt4lABWIhg1hw+Bp5bbqhz3wxQWi?=
 =?us-ascii?Q?HUxtUdCdcZIZDOoEN4frBeasj1I4gFty8Zct2o3d4tK2ltfdkZzmGSapDEVC?=
 =?us-ascii?Q?djem6cbnus8G+pSK5CMLcLmIea+1PzDWbOVPZJFfcUVhM/5G0viUbozM9LMt?=
 =?us-ascii?Q?5PsvTMm+DEBtZILXVWEl1d+4Kh96JKbpsvJJ05aBo5gXouUHCdDk2SDmN3JV?=
 =?us-ascii?Q?mOyFRwIdfzKRbLNg3do+hsd+MIspZc0VupjFlriIsutuQPMvvBVjXSBoe05e?=
 =?us-ascii?Q?d7rq7kSnu7HtEvdHGp43skGlSXprkKXtW+lLdkuC0hin5q+iRE5Eb8FhyYft?=
 =?us-ascii?Q?gvD5GxjbkfJILgPrUvEYjLzaikY6inTI3SAvOZfVsOdy1+Qz5xxYkDDTYT+e?=
 =?us-ascii?Q?CYoHNNUevbbI1Yaa2CgjxLAD9Aj8jFHe8HyTjLuPZL7WyiJ+TIZct+ndQJfq?=
 =?us-ascii?Q?rAkd1asZP+imOegzKLKrCOZlhTlynrw1b7Ug2ibVjc4yX+YiCirtBfFxSVce?=
 =?us-ascii?Q?AhHxKk0exmJjyzpaBkdlbqA0uZnY2fxHrkLjMQWJ10IgmwFfVgt+XfOin686?=
 =?us-ascii?Q?llu5lvpUO1DbWHkCbg7W6EbVekwhHD1Bs4VTeRd8iiPY+R1YY/Vnd+W3QQzQ?=
 =?us-ascii?Q?0Ut/LSxMSHa/eSL+CLY+G8AZkt6UlDqTE1Id3Yo3h7wzNT1Yyyw3MbgwXPw3?=
 =?us-ascii?Q?T9juvloJflRg7wqC44ko9Jlhg1dtY9BHp4Fscr4S1HAxbo773RKHZY0v5wld?=
 =?us-ascii?Q?b2MfxamsqT+PUBRLXyLXKV4zQlt9LTm/H3Lz2s4k5geu6xh84JYOlSwXwf6L?=
 =?us-ascii?Q?n0+7lEJARh/YcPrw+Bs3yXjHUOTdObbVjPewM2b15Scq0/1/tQ52rMynART3?=
 =?us-ascii?Q?KCUs89WO3iLYBf05LInJ3pbRsgRi3cCmXeaCbK/R5FcBz0lSrij6ndZ4+zVk?=
 =?us-ascii?Q?7h8fXfPJ4D8y35Y9UNPlxxP89KpqgwErddzw/ZtXzak8O8sjyAoFauS+1qBx?=
 =?us-ascii?Q?CvNKJZhBDMr914QjT8wSkeINXlJXNKa6sxtleSGPofUZTR+D0lPdkvuqZ+FV?=
 =?us-ascii?Q?jN01tJLyg8wYotVI5FF/TTiSxeeZOND0wLyiMcKgx2WTagf1R4pzTgmJnsYc?=
 =?us-ascii?Q?9d1ke3paVE/UghzQzUCtsxjZyX7+jjx3hTlTTJyBYd6iFZ0PZYR0qtHucEu0?=
 =?us-ascii?Q?AXZSVTz5PCush8Q4clL/CwTfYsHskW0ZZW1CI7DStezASrAiCAe0iYsio5Qc?=
 =?us-ascii?Q?Gg/cGtuR8/RfCIAPZETuZfdg5HJNf7Gi/AKErRloSaYsFvEVdP2e01tXEcbK?=
 =?us-ascii?Q?aBGlWNspViheDd9xPXqdTyw1bwwXEu90FYXJ6QU3J2wOdcBRONTKjkRKsbRT?=
 =?us-ascii?Q?FgaLF3eu36WQXI9BJnUubXbY0DRITshp4IF/RX0gqisM7IsJAUXh/WtaFWJV?=
 =?us-ascii?Q?CGrRd0KLwUIATw6Vh24=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:51:56.0034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50aa297c-3580-4f45-e75e-08de1713d9e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add hwid for Address Translation Unit (ATU)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++
 drivers/gpu/drm/amd/include/soc15_hw_ip.h     | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index af9c2b927a1ec..923f44ade3d38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -795,6 +795,7 @@ enum amd_hw_ip_block_type {
 	DCI_HWIP,
 	PCIE_HWIP,
 	ISP_HWIP,
+	ATU_HWIP,
 	MAX_HWIP
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index fa2a22dfa0487..00c1d73b9a0ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -209,6 +209,7 @@ static const char *hw_id_names[HW_ID_MAX] = {
 	[XGBE_HWID]		= "XGBE",
 	[MP0_HWID]		= "MP0",
 	[VPE_HWID]		= "VPE",
+	[ATU_HWID]		= "ATU",
 };
 
 static int hw_id_map[MAX_HWIP] = {
@@ -240,6 +241,7 @@ static int hw_id_map[MAX_HWIP] = {
 	[PCIE_HWIP]	= PCIE_HWID,
 	[VPE_HWIP]	= VPE_HWID,
 	[ISP_HWIP]	= ISP_HWID,
+	[ATU_HWIP]	= ATU_HWID,
 };
 
 static int amdgpu_discovery_read_binary_from_sysmem(struct amdgpu_device *adev, uint8_t *binary)
diff --git a/drivers/gpu/drm/amd/include/soc15_hw_ip.h b/drivers/gpu/drm/amd/include/soc15_hw_ip.h
index dad83037793aa..c2efc2d2bee1c 100644
--- a/drivers/gpu/drm/amd/include/soc15_hw_ip.h
+++ b/drivers/gpu/drm/amd/include/soc15_hw_ip.h
@@ -100,5 +100,6 @@
 #define XGMI_HWID                                        200
 #define XGBE_HWID                                        216
 #define MP0_HWID                                         255
+#define ATU_HWID                                         294
 
 #endif
-- 
2.51.0

