Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133F6C54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Mar 2024 11:57:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6088210FAD6;
	Thu, 14 Mar 2024 11:57:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dbUSywhj";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5A1810FABD
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 11:57:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFDLmZLg5i2DQaQcLBuQHu540JaFiWOSydt6Vs/HHztOSWjZt9FckN77VZZ5mMv1BP9HLXk9Ziwc5PFhMNGnI45IYBktdJ28yUtjhHb/CtM0TU0hVvGLvHQ91DBtWCO7bWtD1bt+OSTOrHjtSxb0N+3KKMdVIlfqLUlKEFXh5kdsj8306rBMIClehhU4pxDCFDowohbRBZVvR5zdU03iGFEkdSatx7yTH+cbh17Kt3BPEANuFhfsf17yWyC+R6pDYnhDfeLdkIhOk8ekToracbvetHB9Jn1RIB20nZFIlNxKmQRIjRf9iXcvdOFs444PiSEevX0F7tibeD/mRVc2qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzeLPfgf528ra4xpecByWMrjfMDE56vwnc67NEr62BQ=;
 b=TRPX3ruGPtcSEo8cN14J2DihTosmptbYYfBbyHuql5oTFvZ7nO80/tE1BepJ+Fkz2rRngJTiuktkW2dNCg2L2prqr66teTvpwUH+8zubhMSl6LaqFfjHrAVtciL+ShCtc/xMX5LyTlEuRaXObkR0cspCEvIJzPfZUdDIU3GCUWzdYIV5q9L5VCHYfcJaSaPCT2PNRirx/LhKgWQOFt8EEnV9FlgB2tjyplV67zsytkLmaEOO0heAsuI5BKaTlKssDTK5VH9LH64L9DP87MTtcUgy4tYal5vURo4DJFDYHyAaeHv0P9JPrCmjgwcqZV5WNHQw716S68OySsmlLLkKgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzeLPfgf528ra4xpecByWMrjfMDE56vwnc67NEr62BQ=;
 b=dbUSywhjiwFgyE5kLiTiZSb6uarSzzlzvm3uOIyEZMON4qYM7dH7VNV0KOGaGccuTMMsAVHWDjqNBY84Wyby6VW6pejS90Y6wJrfkNGWMNIuToK/siQt/E49QbcFajq1Ooi8/KTmfov2b2ftNLcob9B4MVpKJmapxdd9c7VxEio=
Received: from CH5PR05CA0015.namprd05.prod.outlook.com (2603:10b6:610:1f0::20)
 by CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Thu, 14 Mar
 2024 11:57:20 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::ec) by CH5PR05CA0015.outlook.office365.com
 (2603:10b6:610:1f0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.7 via Frontend
 Transport; Thu, 14 Mar 2024 11:57:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Thu, 14 Mar 2024 11:57:19 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Mar
 2024 06:57:18 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <shuzhou.liu@amd.com>
Subject: [PATCH v2 2/9] drm/amd/pm: Update PMFW messages for SMUv13.0.6
Date: Thu, 14 Mar 2024 17:26:23 +0530
Message-ID: <20240314115630.682937-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240314115630.682937-1-lijo.lazar@amd.com>
References: <20240314115630.682937-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|CY5PR12MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: 1614f8f1-cd85-421f-412f-08dc441de701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QrrUrAQRlJiLeib8mM6Grso+B+nO/Wpim3Ie+iJ+BFYHQcE1y/xvpaURbwZeWNSWUhFl/IOt6sQCNaV97SmFZJD6j5ZPxG9E+4RQy22uB/vdms+kII1OfOiLbVV/zecQtgmJ9nufSZRil7JDFbC9MKFrnh3P0yJMZHivAO+ZEpL5e1Ioj5rgCXC9CFLdoy3jls9JyejlUpC6QVLTjxRzgqINQDR/40KccO8uTx6Xywso4fQ+oq7qdXn23RiVp8Frd4B0u9bKMOqN+Mk5BR7X9YO8SFyQa1onTlF/6Xmf4Lho+ew1KPbscKVakudPs86vntVGTB3KE796X6IKWcYzCS8o/DFI0/yXR4rXIrq+14qJyriQ9IS8y5QvFBO5cQiRpY4J2NpLjj+FX126VffylPflyDa6Odp+qgjzeLEQ92Et15ceqCxslLejg+Xqh6nc54s/VMLhYqhanQJEmlKJ8pRmYFUdm1n2fZnFNJCu6hgkJ2r5X8qRSYVHbo3+y+OW1xHIv8i8Tzq3nATy48GyYPbjU8ZJfNnwx1JAHXIVs1KqBotqichbogBdAAlMT4JR2HXajUvKA0s+Hnxtfr8ZsYS7WerVUFPUGLMP2km3NFpwjIbwIEhAO0ZygWx349/AxzuooTiLfDLj4ZbxvKCK27E6FzT33RqmE4MLu/kFc0aIZBZCv4+QhBgCy9WoIT3h0Q4g9zEiZsUF+9IIQQrU0qJgm9BlgAE5Vtt0GpbPuiKPhHnpRtqGgc/BX7Z3kTI8
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 11:57:19.9658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1614f8f1-cd85-421f-412f-08dc441de701
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204
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

Add PMF message to select a Pstate policy in SOCs with SMU v13.0.6.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h                 | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 86758051cb93..41cb681927e2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -92,7 +92,8 @@
 #define PPSMC_MSG_McaBankCeDumpDW                   0x3B
 #define PPSMC_MSG_SelectPLPDMode                    0x40
 #define PPSMC_MSG_RmaDueToBadPageThreshold          0x43
-#define PPSMC_Message_Count                         0x44
+#define PPSMC_MSG_SelectPstatePolicy                0x44
+#define PPSMC_Message_Count                         0x45
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index a941fdbf78b6..dadbacde32ab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -262,7 +262,8 @@
 	__SMU_DUMMY_MAP(SetSoftMinVpe), \
 	__SMU_DUMMY_MAP(GetMetricsVersion), \
 	__SMU_DUMMY_MAP(EnableUCLKShadow), \
-	__SMU_DUMMY_MAP(RmaDueToBadPageThreshold),
+	__SMU_DUMMY_MAP(RmaDueToBadPageThreshold),\
+	__SMU_DUMMY_MAP(SelectPstatePolicy),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
-- 
2.25.1

