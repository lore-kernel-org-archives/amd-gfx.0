Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910A6C04FFE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 May 2024 07:00:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B666510EDEF;
	Fri, 17 May 2024 07:00:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J6AxZ3Xm";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF4BE10EDEF
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 May 2024 07:00:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFGM/joVbhjO4SIqBc9CP0fGtdR1bTv5YBZN5DnU6TPgz7z8l6QbmLBkRuldmef9fwOZZdbdloHxp6fINWZ/GNSCW4u1WkXBa7+0KmPArb7KnT9tM//KSuBXMBI+6EfeFM+7h3oGC/vHoqTST2K0qNWrfudZeAyCUIDzJRaO2c8gZuXggD/XdxL9U8xOlHG1zCgzcilsU9uo6EsBDjOncJpn7u4ItHU1L6vVn13IfyuGPe4B5VNWw159ejBp7v/xlwq2G5Ubb+Y/EPDOxzBsAXD5oL/fF5dWZh3+lwogb5oZ8efTl+fbmLWuVIKyLTi7UIr24Rkauv/hD2MfPkaoSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEWYyBXl3UhAlFuS0XRLXydDDgWzV8opRwAvz+n+eCo=;
 b=cCIdJe4Ew7HjnIvEdCtMGlFRLfgaVQscLtONGCBDWMUqI22hSwDCm7e+0Bp4bTnFbWcPMMMU5etwpEwzpbBoLBKB1AEn7ULWosWZVOki/obn+zfX0XqE3hQW96GKKW5N9Bf7mykWPPRSa50+KUJiyhC6CYMogvXxRv7huuzyTVitc9ud8wGUO2S1smQh69hGb6wHjdio1ilP+O95a++fQ2bLSTRWlRnwpPGH3kEluX/xzobEZ6L4YRzj+dAYelRbUQX33CKyoHcABsdf0FtcX3/cpY01Zj+w7vZ9bixYgsO0YoheEqZL5/OWO0iE8LUsx3sPhowasudm1AtJeDHn4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEWYyBXl3UhAlFuS0XRLXydDDgWzV8opRwAvz+n+eCo=;
 b=J6AxZ3XmQC7p2lcSimVdPwpk47Vfu8hBvD27iUPAX8cvX850HWVsB8aERc+PhqNVoKew9++zfRhM4qqxpzNpnZh3R2spaUdhvH2jfLF0toUSnV7zNcR77jOshCse6BJXO8HfcXzYMM2TFHb//LPS3gh+oJhoigXP404sjcv1nT0=
Received: from CH5P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::27)
 by CY8PR12MB7561.namprd12.prod.outlook.com (2603:10b6:930:94::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 17 May
 2024 07:00:34 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::bd) by CH5P223CA0001.outlook.office365.com
 (2603:10b6:610:1f3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.31 via Frontend
 Transport; Fri, 17 May 2024 07:00:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Fri, 17 May 2024 07:00:33 +0000
Received: from shane-u20.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 17 May
 2024 02:00:31 -0500
From: Shane Xiao <shane.xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <felix.kuehling@amd.com>,
 <sreekant.somasekharan@amd.com>
CC: Aaron Liu <aaron.liu@amd.com>, Shane Xiao <shane.xiao@amd.com>, longlyao
 <Longlong.Yao@amd.com>
Subject: [PATCH] drm/amdkfd: Correct the GFX12 memory type setting
Date: Fri, 17 May 2024 15:00:11 +0800
Message-ID: <20240517070011.2253488-1-shane.xiao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|CY8PR12MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ae9317-8dba-4236-320c-08dc763f0c32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|82310400017|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aEXOs5yacsNVglwfKB5tMPFkohK4XLSqz4oTPRd02ANkPe75Du/zcd4UGX+q?=
 =?us-ascii?Q?re3lCmVJZlPQhv2M0GGmGdCh05LDKkor5WInYatVDWOTFv+JkpVli8fNAQwf?=
 =?us-ascii?Q?7ox5K2uXSILyaprGoFXXT/SaWIHtVIOHPfqt//DOc7khHztuPqFA095PDth3?=
 =?us-ascii?Q?YDfV9bpCLQHsMAcrn9J0QPrxvaDdtUcKWn9WNGHoN63Ur2NX7nnrP6tAR97+?=
 =?us-ascii?Q?OJ81utSP0fFAHmaVThBBZkuJKmEU2hO7kM6V1bBOr4coqHRFCjd3ryQticQe?=
 =?us-ascii?Q?3OEJU2hEMUTvoKazvRkTtAuDBznH4M3iyiVVxZ27aT7u1MEkZn7lDLc6Oi8A?=
 =?us-ascii?Q?ZsoUK7rhMLXhywQ8VhaR2oTXEAReUGN2nba+HH4v4WnUgnrVdxZepV1its0I?=
 =?us-ascii?Q?t/X3vWgBjlpi9DzL/ST4tUFInTU7FD3EeEuV1E8kF366b1O11y+ghcPksFt2?=
 =?us-ascii?Q?uh7N7v7mWSARspJR0I0R4bnM3ikshGR5YEJ4eXlRay139xUZ6k5feEd/c5SV?=
 =?us-ascii?Q?dzaT6f5ffZQKLXlW7EsV7+86+/dK5cN5P7J4JEnaPHirbCGPGhF+l4+Ye+Gp?=
 =?us-ascii?Q?PWPWA/LjrEpdc+dIyDfKiL1KpoMqgwAY7gmc408afgFB9xwGuSBzEwyx3Hus?=
 =?us-ascii?Q?UcQNmYRbTmO9/BKo6St35NBAr2bVT83KqeVzK/Jy2Xo+TEHEPnZ+pXw5DtOp?=
 =?us-ascii?Q?ZJjVfqJDpMhBRmvU3WZ2fqCybPeKpHvyPKJgYUp3VNN8Zu3+y9cSeqmOCenC?=
 =?us-ascii?Q?N4EhOmD8xzTDYzd6QgZdcTfULpHJGO+Kve1GszNhVtFoATgDdt5i+LKaAhkV?=
 =?us-ascii?Q?3fMjQxJoY/K0DRf6K4oBh6LNrCq5/G/EJr21s/RKBqkoJTzjka0OdFvexXUx?=
 =?us-ascii?Q?kYNLMhYpzXiaMRDjlDJVg2szWQLEOd0zb2OFmbIcWZm6lB6E+FIi/XPccICJ?=
 =?us-ascii?Q?koF6m71UI+2mHQe8KjfMDIQDyOs1+xUq8A3Z9TgrDLJ9BfFOyN6CldtrkqbN?=
 =?us-ascii?Q?tJfh460ovofQl+W64yrK3vktyexOqYBMVPwOivCYitr3z1vUZmVsyGKL2wKd?=
 =?us-ascii?Q?hoywxJdJxyGCrgQ0bmvfXLlVVlpazbhviG4FeE93J0F9stCPAe8Z3H7OkeZk?=
 =?us-ascii?Q?LJUf12CBc013jOGhIP49itK9N8hZPu+pZwwcp0icXsA/fM5xGnjo1hnsSNhk?=
 =?us-ascii?Q?KvDtj8PDoh/TufA0XSRIVHbmAkoUmsza68raBU+t7k2oavXu7m5mntPAxJp4?=
 =?us-ascii?Q?XmKcFOGBiBBvDTNijMGNrMA++9eDeFppPvoQu5ceNL4jobqPUrk5Ur1pTdli?=
 =?us-ascii?Q?c0DkSCWvVe0Q7CeTheQH9bVhFCZgitTZ6/cjRh23AxcySXY8C/us5H9vOhss?=
 =?us-ascii?Q?q6ZeoU5PmIlSnPIElGSNc2ECBCJ1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400017)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 07:00:33.8776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ae9317-8dba-4236-320c-08dc763f0c32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7561
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

This patch fixes the GFX12 memory type to NC. Since
the Memory type can be overwritten by the previous
operations, the GFX12 MTYPE bits need to be clear
before setting to NC.

Signed-off-by: longlyao <Longlong.Yao@amd.com>
Signed-off-by: Shane Xiao <shane.xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index e2c6ec3cc4f3..6246d1dc0d30 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -534,7 +534,8 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
 
 	/* WA for HW bug */
 	if (is_system || ((bo_adev != adev) && coherent))
-		*flags |= AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
+		*flags |= (*flags & ~AMDGPU_PTE_MTYPE_GFX12_MASK) |
+			AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
 
 }
 
-- 
2.25.1

