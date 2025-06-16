Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5DD3C7115A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 09:39:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78B8810E315;
	Mon, 16 Jun 2025 09:39:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sBrLEs3u";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E061410E315
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 09:39:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NClJARnb2s6dIRb4cujwT8mccqUz0UlUpRbskcufmz7/FvV76jdA3gKekud5pwZf8eq60M2FFuAAo6Jz3fiuYroXB41pWUw4xPv9Ej7NRg2oomXa5RSzbtvfSUqN+prfNzdeo6uNK6B+RQLdvmmX2WNFet7pdb9Q4a87ggNsGnDkuTLjxiZXdC/RnnxQNSdzSgAkU4+3CJfCVX5Ra5fVA4M1b02ZLnA9LGsWy60CN48Jar5X15y2CoxI6L67xTMzd8+5mgW1ATXCUPbox4gaFgi9SRybe6n2P121mtQ/hgUBeLybWgjRgT8qqxJpiwnIaznOws4/1/m6+iiKJtHq1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtG0KdEbPyTGKan3zF7DQn+xJijg553bZqZtrQYPz4E=;
 b=MP6nIzoCUyHj+VDX82LV5jlov49jDssNQ/M7eEw3gu3acyTarjUdo1BF4ryxnyKt/IjZnWDvMk7mqq6fiWVGD6p9k2nmqasUcmO5AfillWQXpPkcrcW2W6kwFIEFRTc35JvCSnL6009F0rOlFf72cSTTXyF6qXdGPIXNycBcuFkJ8VSyqETI/1ZBeml/ourSQYwZ7W5S+u84/RyOMThcAb2nScgbp2Yadm7gp0dZi1fHBw/HaHyXcTh5FY25oQ1WpoTLAJSJdXg/p5qLuQDP/PYObqcKBQqb9YlPUsxSsW6q+el3L8ZChwPmMDBdoAi1nYWLRVxiosbX5HyR3fJ5Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtG0KdEbPyTGKan3zF7DQn+xJijg553bZqZtrQYPz4E=;
 b=sBrLEs3u2JRLPKslnql+Jsqi1dbD6nDRcYJ94kXlx3J6Ru5QFzz4ei9I+6PbRp6kmR6zD4J/FVumjAyk9FFpKT5AwoulFcadWuMdPJxY8blSRiYw8CtIg9CqE33Umy2WMrCl6ukWpsZ5ZJ6uKywO4ogP6xSJWdWRYk5zgBxqe9A=
Received: from CH5P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::9)
 by DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 09:39:12 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::a0) by CH5P221CA0015.outlook.office365.com
 (2603:10b6:610:1f2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.26 via Frontend Transport; Mon,
 16 Jun 2025 09:39:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 09:39:11 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Jun 2025 04:39:09 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, Le Ma
 <Le.Ma@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 07/10] drm/amdgpu: Move MAX_MEM_RANGES to amdgpu_gmc.h
Date: Mon, 16 Jun 2025 17:37:53 +0800
Message-ID: <20250616093756.16200-8-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250616093756.16200-1-Hawking.Zhang@amd.com>
References: <20250616093756.16200-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|DM6PR12MB4353:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a9cdd56-afb7-4ada-afd8-08ddacb9a689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?crtOezu2aLG750XGQ1Ul4cIkd/ApNtyiGbRgUR98ig7EghTp4Zz0a1S5vGLk?=
 =?us-ascii?Q?vzZC+JAkWJlMatdDhNPBBUbbFMqQg8HyKQusjEwHfZBWLR72Lra7IncYru2G?=
 =?us-ascii?Q?9ktaP/vcQZjcllpukf0QlzK+N3kJF9IfCG//n4vUOa2J6rTJ9O3RcBpNjKLD?=
 =?us-ascii?Q?PWHjg9ajEkyebgMgPuoet3RQ8N+6Q10CivycsF8/xrue/c0rU3sKy9XBOCwK?=
 =?us-ascii?Q?M/fD9tFpxYtNxq29ZWlFDla9wSurKMB0SrrjM6PcmLSRdnuYiln1vBKDahv9?=
 =?us-ascii?Q?Unt+QN4CcY+Y6KPPMcUt0qUu2myoELBRFZD3m3whqjvkhjJrXUuK0x5lr2cM?=
 =?us-ascii?Q?lPJlgWJHNUiMpJX7ep4OllPZZtfB8GcZBaoNLTihBZsEldQouh3gUt1bCa1H?=
 =?us-ascii?Q?0dXAIiOC32LX5AH1mGHS8Yzf7CRKuz0VH5PNiluYndOa4Zq8viSnKC9EyFIC?=
 =?us-ascii?Q?U37/MELSGZ1TAGVPSXN4rgQhpVLGGhBbF468yUzNo+7FvGfJZCans6Et4nfB?=
 =?us-ascii?Q?iwJxKqCNuSJuBzueJ0OWCZwJbJOiBwdjplIk8XnfCM1cDFT92w1akzgd+/sY?=
 =?us-ascii?Q?Jt3JU2mQeC4yO8nh+Ap+edgVk9cU7NsvT7tHsErxyQVRaIur0PTuPsBvMgR6?=
 =?us-ascii?Q?Frji8f5wm1Nf1ADaTXAn/mekH4JM+ArbcMQR/NkNdbAmwNTaZQbcubojGB+5?=
 =?us-ascii?Q?iG1IOVrxUZ8/EYGJ+f0gzqTBIkSCR59CVBJ1zZMyoVJOkcvYhk7EZUpfvBI4?=
 =?us-ascii?Q?8B5TJswSxSBelZtsQ78RMM2C+jlhE87yfa0VE3GkrMxa0QA1Y8KDeD+289h9?=
 =?us-ascii?Q?i+O3YEtRot2rC+IYekYL2g5scYMCxBWHWmesndM6VhcKKg+Aef2p7Ro7nC2y?=
 =?us-ascii?Q?Wbzi4JwxiHwLVQsK3FXoJZZfYkpT1CFaBWRaW60lKaSHyCR2uUhUql1uzXIY?=
 =?us-ascii?Q?bhCHPX3HlWmXVFuH63sdi7wVjKc1oeMCdFE25r9h4HgPMDpBqqZjg67eihMy?=
 =?us-ascii?Q?znMiTvte1rL2nhirp+4wRisbMnAezpifeTf8q1rTBqq++qwImMP2npn0Z/e6?=
 =?us-ascii?Q?MyLuSJ8qfD2ewal03ko8nuTpYcf5L7qxhOQiVLkfrf+uiTzMXYNJ37n+cMKt?=
 =?us-ascii?Q?V6YE/ddjh0e+9D417RM/nR5muGqlY2oJL9vH3aF6jYKCF74VeZaLhuXoUsp8?=
 =?us-ascii?Q?37tCOrGqYoHArxrBKnTBlgIskxS1LH/F6HczMZERjahe/UP7gWtUKisl6xDP?=
 =?us-ascii?Q?dnc3cZanUvQNg0wFgKVj0pvH9YzANc8YWkJyunh7iibEgyyj5IhlGFLUcdSw?=
 =?us-ascii?Q?huvU2BCd6dKqFQpS9a5hvjwY+rD5oyVYoJ+sclX8pC2WHz3YRAeRQEbfkOE5?=
 =?us-ascii?Q?DIOmHlntoA8cMsTDvlbmLabNHZn3r7mrEnQZhKJeEoaSjZ5kiD49YSAyjkfK?=
 =?us-ascii?Q?0mdtCqqGCNqioI3Tno1stat3/kPZbX53fiezNejBA8ELy+nouhxA+B+T50kh?=
 =?us-ascii?Q?rnC4Zu2ijRUmClblfCcTE0DB9OtP+WOM4Fd4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 09:39:11.8638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9cdd56-afb7-4ada-afd8-08ddacb9a689
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
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

This relocation allows MAX_MEM_RANGES to be shared
across multiple products

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 2 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 6 ++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 46b2bcbd5025..5aa404390d68 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -84,6 +84,8 @@ enum amdgpu_memory_partition {
 
 #define AMDGPU_GMC_INIT_RESET_NPS  BIT(0)
 
+#define AMDGPU_MAX_MEM_RANGES 8
+
 /*
  * GMC page fault information
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index e691cc61ef6e..01b9374134f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -78,8 +78,6 @@
 #define mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION_DCN2                                                          0x05ea
 #define mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION_DCN2_BASE_IDX                                                 2
 
-#define MAX_MEM_RANGES 8
-
 static const char * const gfxhub_client_ids[] = {
 	"CB",
 	"DB",
@@ -1934,7 +1932,7 @@ gmc_v9_0_init_acpi_mem_ranges(struct amdgpu_device *adev,
 			      struct amdgpu_mem_partition_info *mem_ranges)
 {
 	struct amdgpu_numa_info numa_info;
-	int node_ids[MAX_MEM_RANGES];
+	int node_ids[AMDGPU_MAX_MEM_RANGES];
 	int num_ranges = 0, ret;
 	int num_xcc, xcc_id;
 	uint32_t xcc_mask;
@@ -2042,7 +2040,7 @@ static int gmc_v9_0_init_mem_ranges(struct amdgpu_device *adev)
 {
 	bool valid;
 
-	adev->gmc.mem_partitions = kcalloc(MAX_MEM_RANGES,
+	adev->gmc.mem_partitions = kcalloc(AMDGPU_MAX_MEM_RANGES,
 					   sizeof(struct amdgpu_mem_partition_info),
 					   GFP_KERNEL);
 	if (!adev->gmc.mem_partitions)
-- 
2.17.1

