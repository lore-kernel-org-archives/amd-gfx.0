Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5AEC25B7E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 01:35:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25F0511AB4E;
	Thu, 30 May 2024 01:35:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cJOOWggy";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0874711AB4E
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 01:35:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AM1kb85w0nOORg6CpDzQyErAT4JQXoDNseFRe/rumSYE/vszbpy3E8E5p1FbrGYt8HDRRX+5TWah5f5UrrGCLMfx04IMkuwLa98rGJIIUcPq/VP5LkKQLAzLcf9rPoTODuxzEfoguWtNEb7c12Ir0lkC40ANFE4LF4wnQOOtHNaMb5OFZrEYTU3xwmUcm3Dwcc21opMuwrKXCcIsWHW0hXvtSHe/MDXoXalYKqhYp4S/5jaeIhXdDc74QhrB7dHqTXBO7d83WBFAM/SWtUas3rsh1hw+hpou15SMtHuJAb8gsTk9QwHbP5z4s8OX7+nsL/INX+8q7tIoOTDOsHfSPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3VuxcoMDanCJyMofEpp90dJduqwt0e59rAT381mhbg=;
 b=k8a6cR0zCgXh5mN6t3mXZj8xGUCKYBOgcACpvE6TPJ0vnE2ydnGNgvZpjfvi+x4KykGihKQ02iIdc+UOrzgDZcNjgnVs9jQtah0F64IxbeJWD+4XCDsiHZ+HYzke1puQ9bP5ShwPuVpt8dJG35eNmz6NLSTNFcvdS5CYqKP4PQAeqHdhdXOKF0L7DmeBR2TbJdnA37SAcqKzvq/gsPpEz6hTUUgV4MGfYlXCBnWi+f0g7KG1zcPxsDbYf8fKEQFrhTTfvrk9DL59W+o507SjBsNEoUklKnz8K5J+zv+x9nwBbB99NBkxXr7xieqJ3ktxZ2+PwaCLTqeh0QBKBjuezQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3VuxcoMDanCJyMofEpp90dJduqwt0e59rAT381mhbg=;
 b=cJOOWggy9P6OBQbNjKjmGFNM9G4nLm8A8GZry7ujoCa2zL0P//QbXotcIzI6IkJZTH8evSy9/IUZ+Np7BPayUaxSP5v1CUiickO16HT6MkwFyG++giQmDnB2SBCPE+jT1Sugia2YmaeqjghdF0nFvmrGvuiBW9QziBU4IVexqFw=
Received: from CH0PR03CA0250.namprd03.prod.outlook.com (2603:10b6:610:e5::15)
 by DS0PR12MB7874.namprd12.prod.outlook.com (2603:10b6:8:141::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Thu, 30 May
 2024 01:35:04 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::e6) by CH0PR03CA0250.outlook.office365.com
 (2603:10b6:610:e5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Thu, 30 May 2024 01:35:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 01:35:04 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 May
 2024 20:34:41 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Pratap.Nirujogi@amd.com>,
 <Mario.Limonciello@amd.com>, <Bin.Du@amd.com>, Pratap Nirujogi
 <pratap.nirujogi@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 3/3] drm/amd/amdgpu: Enable MMHUB prefetch for ISP v4.1.0 and
 4.1.1
Date: Thu, 30 May 2024 09:33:37 +0800
Message-ID: <20240530013337.20776-3-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240530013337.20776-1-yifan1.zhang@amd.com>
References: <20240530013337.20776-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|DS0PR12MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f0bb2cf-8d47-49e4-e366-08dc8048bb5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B0hMguGGcmB/KLDRHqO5pVUv3qhXnnxrh8VFZTQSYodGHeHmWnIwhgEsT9oX?=
 =?us-ascii?Q?IB5jbMuGmCzWFyc7pqokRBxbaY+67bWyvJn1Z8o705t+VfHJog+teacQLviN?=
 =?us-ascii?Q?mLScaMi0QqREjpp2DqJJO00lglFio8zGY7saqExUVSBnSkNi0sC/yiSuCD1a?=
 =?us-ascii?Q?G58Rr71vqjxvtY+GnYVCSfccFKYITNthknIcxhgapPYBJajN5+CvuOLNCxp5?=
 =?us-ascii?Q?Gonyg5isp+o77cGANT2wkQERRvlwg1cPAtHATZI9Wc/2R3MpsZOYC89/8zk1?=
 =?us-ascii?Q?BOL+Q+5XL0/wXvbrgyIeAycSUDmNF3WFkveHwi9Y65bKDeuOvzIwpZY5asmk?=
 =?us-ascii?Q?cXjxJaxkYOYbUo1OxnL3/ujaE4f7uCYAx8Fa0uS6OWpAwcDRDjX8krtPUYAA?=
 =?us-ascii?Q?sKpltUSwLfbyRfqEKJ4gZZxTeP/EPTH21+HrCz04sZ+lpX+cXg1nbeun8WPr?=
 =?us-ascii?Q?DJF4fk3uP2pXWy1Pn6GACecz+zFNolablU1uiBoqgNLXnLO/q/dVud47Aavp?=
 =?us-ascii?Q?sls5/eT2VoxkFiAuqgPfhtJM7wbKUCLpFBPqU3RSR0yJwUjxrADUfVM/Vq/0?=
 =?us-ascii?Q?e2cff6dwmm4GJ9rM9+epMXbPtZZpCF0TQ14hrMlSCjdH/ICvFmQr/uh7jFuI?=
 =?us-ascii?Q?29Z6Xqk6ZnVSIZtfi8Fwu8HxJHiTpyjpLGGmKVQ7o6+KrIPMuPGE3dYN3ad/?=
 =?us-ascii?Q?PHWws3Qyn2Vn1JUTgxM+X/0tMRfj82ir5nvXSG0DdZ1nYFTuIyaeAE2eEQKG?=
 =?us-ascii?Q?fykaY/bND3QApz3clEGVD5mc97XiPsQsY9HbsdM68yad4mbUCz7sAs9VIJUX?=
 =?us-ascii?Q?pHQzqgBpYRTSFVY5mue/GdHOxHOAHbIImA2nLu34P5LZPw56Z3Oe4LhHGEtV?=
 =?us-ascii?Q?lg9aTojOiVBkuksZ69O0aT7VYQ+vFQ3Je8+h6Wgz6TcOlqrX3O0JWIozAoKh?=
 =?us-ascii?Q?9jiwiGujBS5SuITvmv/3XZFYB2gIzTZxFzl+bWJyFavX2CWXgyTfKtYA1+Pt?=
 =?us-ascii?Q?cBpV7IVj9FE3hOE3adz25xDGSPhGRgy9ub5gZI+QTbHOTTGnLlb9hDTVn2YB?=
 =?us-ascii?Q?61ThAF1uDB3v5VjgbCMEGB9WWxJxbV1Wp9L7ZbGcVOIDHD/U3V/OJSfNxgdd?=
 =?us-ascii?Q?u5T/t69HYXQ/wMvIBogYe9dHztNMF6P5KLYiyfNIPSuinmtJXRW1TEbnZHdd?=
 =?us-ascii?Q?EPQ0XDjT1oSEEThEyy+B6CTKhFtCoaGX+UK9YgSNN1H33cmgcU5xTuE9QKV8?=
 =?us-ascii?Q?ic83lAH51ok6ldXrKrwSh56RRDDDbOytUnia/8c3cdWK/XtMoVxleWDG/kDZ?=
 =?us-ascii?Q?pXGMNAVjPnqCcO2xH8oz/IofOCgtriys1YWoaqJZLz0aUQ5eI4hQOmwN+fs8?=
 =?us-ascii?Q?KkoHOqi01WrFlBQ+T6IRG5gE9Tp6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 01:35:04.8504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0bb2cf-8d47-49e4-e366-08dc8048bb5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7874
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

From: Pratap Nirujogi <pratap.nirujogi@amd.com>

Remove temporary WA to disable ISP prefetch as MMHUB SAW is initialized
to support ISP HW access GART memory using the TLSi path with prefetch
enabled.

Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c | 12 ------------
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h |  7 -------
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 12 ------------
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h |  7 -------
 4 files changed, 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c
index 962da37fb1f7..aac107898bae 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c
@@ -104,18 +104,6 @@ static int isp_v4_1_0_hw_init(struct amdgpu_isp *isp)
 		goto failure;
 	}
 
-	/*
-	 * Temporary WA added to disable MMHUB TLSi until the GART initialization
-	 * is ready to support MMHUB TLSi and SAW for ISP HW to access GART memory
-	 * using the TLSi path
-	 */
-	WREG32(mmDAGB0_WRCLI5_V4_1 >> 2, 0xFE5FEAA8);
-	WREG32(mmDAGB0_WRCLI9_V4_1 >> 2, 0xFE5FEAA8);
-	WREG32(mmDAGB0_WRCLI10_V4_1 >> 2, 0xFE5FEAA8);
-	WREG32(mmDAGB0_WRCLI14_V4_1 >> 2, 0xFE5FEAA8);
-	WREG32(mmDAGB0_WRCLI19_V4_1 >> 2, 0xFE5FEAA8);
-	WREG32(mmDAGB0_WRCLI20_V4_1 >> 2, 0xFE5FEAA8);
-
 	return 0;
 
 failure:
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h
index bd9e1f13c748..315f2822410c 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h
@@ -32,13 +32,6 @@
 
 #include "ivsrcid/isp/irqsrcs_isp_4_1.h"
 
-#define mmDAGB0_WRCLI5_V4_1	0x6811C
-#define mmDAGB0_WRCLI9_V4_1	0x6812C
-#define mmDAGB0_WRCLI10_V4_1	0x68130
-#define mmDAGB0_WRCLI14_V4_1	0x68140
-#define mmDAGB0_WRCLI19_V4_1	0x68154
-#define mmDAGB0_WRCLI20_V4_1	0x68158
-
 #define MAX_ISP410_INT_SRC 8
 
 void isp_v4_1_0_set_isp_funcs(struct amdgpu_isp *isp);
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
index 67f95f05ecca..4e17fa03f7b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
@@ -104,18 +104,6 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 		goto failure;
 	}
 
-	/*
-	 * Temporary WA added to disable MMHUB TLSi until the GART initialization
-	 * is ready to support MMHUB TLSi and SAW for ISP HW to access GART memory
-	 * using the TLSi path
-	 */
-	WREG32(mmDAGB1_WRCLI5_V4_1_1 >> 2, 0xFE5FEAA8);
-	WREG32(mmDAGB1_WRCLI9_V4_1_1 >> 2, 0xFE5FEAA8);
-	WREG32(mmDAGB1_WRCLI10_V4_1_1 >> 2, 0xFE5FEAA8);
-	WREG32(mmDAGB1_WRCLI14_V4_1_1 >> 2, 0xFE5FEAA8);
-	WREG32(mmDAGB1_WRCLI19_V4_1_1 >> 2, 0xFE5FEAA8);
-	WREG32(mmDAGB1_WRCLI20_V4_1_1 >> 2, 0xFE5FEAA8);
-
 	return 0;
 
 failure:
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h
index 6bfb1de191a0..dfb9522c9d6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h
@@ -32,13 +32,6 @@
 
 #include "ivsrcid/isp/irqsrcs_isp_4_1.h"
 
-#define mmDAGB1_WRCLI5_V4_1_1   0x68420
-#define mmDAGB1_WRCLI9_V4_1_1   0x68430
-#define mmDAGB1_WRCLI10_V4_1_1  0x68434
-#define mmDAGB1_WRCLI14_V4_1_1  0x68444
-#define mmDAGB1_WRCLI19_V4_1_1  0x68458
-#define mmDAGB1_WRCLI20_V4_1_1  0x6845C
-
 #define MAX_ISP411_INT_SRC 8
 
 void isp_v4_1_1_set_isp_funcs(struct amdgpu_isp *isp);
-- 
2.37.3

