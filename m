Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACA0C0218A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 06:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B30E910E013;
	Thu, 30 Jan 2025 06:45:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JXfFkgYX";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E064E10E013
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 06:45:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0PcyQWZ8uy87JLp+ujmfggXrs+SASpK5GdTRqRSeWKinKK525AwohALBduW9YdNqKNiUJ8lKgJE6g+rWfK/wUeLEtJwpTQ9zlMACfPhrArq2qg9dRhjTeZrpOFVPpdKgfHE9c1HaklzDFMCpURsOq5gY0LrWSS7yAjzDQhuEVE7onbSja9/5TZwgA8rHse9S0UDWiFptT77p+H8pjgJNf4/CwzqGeoHY/dAYnXiMfZfeOcLiIFWy6Rai34pV0ABPW1S2blQmwR6lqTSxZffc2vEKOleTjQ5/zeDxJjNFKSkecQukKNhL5m4FGjWL166bqW4tJQGTEMM0Hr02GdTHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKC9L4Ec/fsZwurvocb4DPo8ByG6n0dXOhlsKu6mn4k=;
 b=thSqZ+7ty9aX/1VQGzri/SZa3SmV/9YHntjn34KS3YuEK+BCp6GVrYtduF6/PIysQ0cjw8LO7hF2WJwx77jq0WXwEmhs2jY7nlJnHX5YfGTjiw8YKSbWcAl7ksHhr5NYFI1iCTdR9LfEpfryn1qxXfwVSjUFm0yQ9uFQiujyjo6B19bLR1SazaNrP11+3qqFMsBEPDvwFCSJXxzXO66OSEEJEYbJhW0yfPD8nIaLO3Ic6VEhejXeTKH+q9c+UkvmmlJIwUYbX3A6sbldfA0PXUB5n8wm5D1/r8ndSO8TdwUmutwsM61a6cs37BhYTX1ISc4vM5YXXFxbBHKNzOWTNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKC9L4Ec/fsZwurvocb4DPo8ByG6n0dXOhlsKu6mn4k=;
 b=JXfFkgYXpwGzvh+jo9ajTnKLdotIETbaaN1oaYS0ajQWxRB66dqfcvjpu7f4qCHW8QufMGxwT8Onlr0UQ8MdPYkRRDJ5cKFoOKDv4yLLsU2vZK8Ly0JtCKG50ATtSmffrSfI+HShhKJIAatQCdVu8Jz9SSU+ESEyaTVELnJwgQg=
Received: from BN0PR04CA0128.namprd04.prod.outlook.com (2603:10b6:408:ed::13)
 by CY8PR12MB7434.namprd12.prod.outlook.com (2603:10b6:930:52::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.28; Thu, 30 Jan
 2025 06:45:41 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:ed:cafe::93) by BN0PR04CA0128.outlook.office365.com
 (2603:10b6:408:ed::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Thu,
 30 Jan 2025 06:45:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 06:45:41 +0000
Received: from amd-mlse-mangesh.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 00:45:38 -0600
From: Mangesh Gadre <Mangesh.Gadre@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>
CC: Mangesh Gadre <Mangesh.Gadre@amd.com>, Shiwu Zhang <shiwu.zhang@amd.com>, 
 Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: update ip versioning for gmc
Date: Thu, 30 Jan 2025 14:44:26 +0800
Message-ID: <20250130064429.2215628-1-Mangesh.Gadre@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|CY8PR12MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: dde04063-35ee-4f5a-95a6-08dd40f9b6ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V3deffeDfhlisQkr088sF+bkQoP4SrVjYId2pGaAGaLvTA/ULKG8/sVqfPiK?=
 =?us-ascii?Q?8/BVJGvEfx//zNFohTXm1YcfGqwnQUfx287FBBZ39tTFdHxBSR1vuixxkQRX?=
 =?us-ascii?Q?hzvau68q/51fDPU5oWluhEOiMcXwsLMcTCDdN46FITYHTWe7ruiA+cEqOuAy?=
 =?us-ascii?Q?NhmrY+qAM0M75BMzBYxRX5ODYBTMi4c3pHMm4LsuvSxaGu5t/WkNWqqXluwm?=
 =?us-ascii?Q?DjVnzvvyJQTTeNS4Qsnr+fXYKG3ABpy9PAF7lOhYbV666AilVL7vB3bqkc85?=
 =?us-ascii?Q?9JxX3EhQ8hQsG9QI0+fvRfaAIFh6NphKjs+IQO8iWeBUFG5Wj9kRWpihUu9R?=
 =?us-ascii?Q?QGvgMLq0EeUxdjzwfU+DpbND3BZMCQ54FKjqpzLchoIndIcosWHDQoiIEb5r?=
 =?us-ascii?Q?3ONt3fnj/OfQRdWRLMYjxN7DD0VqDcJ0+4hN7eaY6z1FBD14ZBVgBGvwu+WM?=
 =?us-ascii?Q?bqvCJVndV05PG7lfCMp/kpMlP36NaIFbfJCK0fO8IRw+vkNdKxJcrOQnGjvp?=
 =?us-ascii?Q?Im0L9e80kP6iKlbpDadxbCyw6gKfzoakNgN/GxQa1ROeLkJe8GRTcU2FAoLY?=
 =?us-ascii?Q?YJglNkt1EZ11K2HO6UCE61JyfhsjDjsYtf3/jAXi8N2Mpox9IuEUI73drzvf?=
 =?us-ascii?Q?O6Nx8XzWzbDiOBeSih099cemRVE6fOPk7qk1bZO+T/Yqlb7z4wSVdO7i6ZW2?=
 =?us-ascii?Q?wpMaqXLhZEHw+RsHixCm82jwWjHVsZe4kvi+UYf/Ci0ZfxPl1N/b15rqATxM?=
 =?us-ascii?Q?pg/WlrYPlO6h9/tsx20sTOUHOOSLodknzjseJpBIP+RQnKVvVkkIGuyKVpm9?=
 =?us-ascii?Q?98nIpGPmxWNz2l56pRfwqZnxJNfP/rsoGTvaj21vQNIjuckLP8CYOOoFFViN?=
 =?us-ascii?Q?4coW/YU4pUoGjYhG2P5gFb9kSpGPkO+8/R23UwOS7U0ffVcjr+Zj2ES6K+rX?=
 =?us-ascii?Q?Y3UIZPCCHCmXx4073Niw+iylFq4ZZP7vWiLZki4iTilqGmw4Mged1uKnUaPJ?=
 =?us-ascii?Q?pDt3NYyx0ew/UfhebTjyCLcee6ujm8FT89dFPLM4wYJuvFatSQrwYaHRv6W8?=
 =?us-ascii?Q?4ppnB8M4Z8UrfIMtYAkFaM91pZ1+i7IEuHSG4cbCz1NGq0KOPERZZPMp40YU?=
 =?us-ascii?Q?gUzKJZzhetPZpDNkXc1a3cxry54DSEA4rO6j0DvMAih4JP06GIIvGMFWbUBh?=
 =?us-ascii?Q?zGjUz0bJEwGxwH4McDDQERF1+3gnQHCHODDW+KgHTimBwI1Xa1uamTXGp11a?=
 =?us-ascii?Q?fbbXXG5EwWgruxBQd+8HrPlDY8IJTSmbJ9/JnKIYEfNHNAp4VEmmm5GRZeVG?=
 =?us-ascii?Q?Rb8Z1hkhlFtu27aTRhvhQwTy/GVYC5OsvI+cE8r/qPUx02hvr9sgxQB2s8/y?=
 =?us-ascii?Q?MFzY8bcVPw3md+uYDZjzX8g8ODElShwEEcBkQlPmJPqWkliX2OX7fnOWxmJY?=
 =?us-ascii?Q?hTBNQBMhHq01Swjfqtm1tsYgQL4o7H4KRtGPLPUxgX0l/LsB3y0+f9QsgmKB?=
 =?us-ascii?Q?3hOt015sqa6cFkM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 06:45:41.1586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dde04063-35ee-4f5a-95a6-08dd40f9b6ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7434
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

support gmc ip versioning though ip discovery binary

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 71b8ae7f2194..31c4eb656d98 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1498,6 +1498,7 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 			adev->umc.channel_idx_tbl = &umc_v6_7_channel_idx_tbl_second[0][0];
 		break;
 	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 5, 0):
 		adev->umc.max_ras_err_cnt_per_query =
 			UMC_V12_0_TOTAL_CHANNEL_NUM(adev) * UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL;
 		adev->umc.channel_inst_num = UMC_V12_0_CHANNEL_INSTANCE_NUM;
@@ -1523,6 +1524,7 @@ static void gmc_v9_0_set_mmhub_funcs(struct amdgpu_device *adev)
 		adev->mmhub.funcs = &mmhub_v1_7_funcs;
 		break;
 	case IP_VERSION(1, 8, 0):
+	case IP_VERSION(1, 8, 1):
 		adev->mmhub.funcs = &mmhub_v1_8_funcs;
 		break;
 	default:
-- 
2.34.1

