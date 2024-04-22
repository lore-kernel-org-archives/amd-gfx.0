Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47AFC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 13:57:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ACAC112B0D;
	Mon, 22 Apr 2024 13:57:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JgphS9jZ";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A51B6112B0D
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 13:57:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXztEEtqJtByFfqUZYJ9VCOzBFRuiw0U1zbFrzjYj3nw+Kgg/KlTuyzzCBFllB5fNG9lNCuhnDKuT92KfRIjJl79YmkiXSaj7m8PfAxlnVnaKibku4arG8CO4qNF5Vl0UxCdAyOekLUSOnBIupya0uarjHWzMgfHVzhBrogqfZZCWAneJvuetigFdTWP38VM70aRiy0PzvjTUCw6tE98OpjxHSbfuc1hcZ1Xr546XPYtwJ0aWmO/eH18ojkdppP9Z8hqxbWpAklX/cUOzwSqpe6cEVQHijLa4GzZUasfwwwzLmzeYezIuBBcHdLkct7He23jLgi9Qe9gJWoBXsXqig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKUDDe9KirG2+gWOuw5cy6LoOZeXQLJth0ruXyfu8qM=;
 b=IDOQDbCIvv2uhq/lm5jmJ2ILPFYdqoV1RmLxm6hkQzqP5oRUGT/tbF3I2DONiDYUZ/wCprk2N17M7oDQWJpgHjPWyTUBmaVL3Ju0qd/jMZF2x1QfLGE4XcW13iUWTfjXdoAWwIhvFAOcykaTWSfx+px1JrcRA44czDeI8QejGNAQcX987y0hPv37pxuzkyKWy/IAtbLvaELHQwNJV7/2AFMkmjkI2AjeZ+jOSECTZE+nCwGmwzLDt68bHn++gJPtjty6M3n40H3zo1HwuCbcbzUxmA9Nzhpe7zBI8WMQwMiO2ET87EaLdE2JDQ+qHRZhmwWNL0auOADX2/YwXqbk6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKUDDe9KirG2+gWOuw5cy6LoOZeXQLJth0ruXyfu8qM=;
 b=JgphS9jZ58Efx0ihQTIMcOVK625Qe4DXUth3rncoemHSfOjVqdwGDv6WLJvvby8Yz/o/PaOcHuFDoCI3RMxeVUOriWTwl/ALtEjVaK4vKd0zVz1ragmgEj7I+l8DJeo6gQTdp0zUuVHX4bqbXNo9vc8S3Yt9T5VXhXj+xAAC7fQ=
Received: from DM6PR05CA0041.namprd05.prod.outlook.com (2603:10b6:5:335::10)
 by IA1PR12MB6308.namprd12.prod.outlook.com (2603:10b6:208:3e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 13:57:55 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:335:cafe::54) by DM6PR05CA0041.outlook.office365.com
 (2603:10b6:5:335::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20 via Frontend
 Transport; Mon, 22 Apr 2024 13:57:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 13:57:54 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 08:57:53 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3 1/7] drm/amdgpu: Support contiguous VRAM allocation
Date: Mon, 22 Apr 2024 09:57:19 -0400
Message-ID: <20240422135725.11898-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240422135725.11898-1-Philip.Yang@amd.com>
References: <20240422135725.11898-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|IA1PR12MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: cc53c937-f670-4c7d-4106-08dc62d4358d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R0s303wkaOu03MyfC9EIPNZ0G23HR4WUHmKuT5rkoudLZ1xj3AlV/ZdBReGh?=
 =?us-ascii?Q?P6GxD/TvFn5IAAJYgn+tcRSCGqBRI58B5GLc2Wp1oIwY0AckYA6ZOT9+G9JD?=
 =?us-ascii?Q?ZxBhLqfI6nEYxV3CNDc/7a2s5zTaHAQbChdtjwW+3pzTu8mttES2vrw/g7ZQ?=
 =?us-ascii?Q?/dbrI1Lw0TS1PNwQf8WaOv51KigChZCHTFV3yRAd/AfwqfyZy3Fu6MqcBm77?=
 =?us-ascii?Q?Gu8dIJfgubhiUN2AvuUsRgQHHgSIYu8PoJq5FWtOJYQQNJJjN3ErCgD2DNyt?=
 =?us-ascii?Q?Fw8fKZC7e+lUIO9mBGDd99u8cY6cq6ValzeqJ3EVt+CxhMR15IuXTu/5jITj?=
 =?us-ascii?Q?c2PCp6KrOkB6gCS3ztrRowx7DB2JvIj3mjB8vsjZPox3est4tv1ZAaMWghbG?=
 =?us-ascii?Q?CVldOHMuUPYX/Cz7KP9zQT8idgQOszX4NzhNJ3Nr8i8vIAJxkZ71f59greXi?=
 =?us-ascii?Q?nIi0AvCQp1og61r2jJJcS1AFdm3FFDLRi/o0cZbuUPm47fFbZW45sqzDyDsh?=
 =?us-ascii?Q?+nhb3K4zEqfNN88L7YEMthXVW9tAVG/Xogrs4aPSvR3H0bg0N2p/kptj+1so?=
 =?us-ascii?Q?vR5LQluCvF6FqAlXcIyJTp08zFKlTEK/1wkWHlYMw7oZS/UrDQCDqoCVNKJ9?=
 =?us-ascii?Q?dGTr+VeAKKn+fhf07mPjPtDhmBQQ0s7JyXAqvHoPiVfmIeZ7uhulYBBHXJZ+?=
 =?us-ascii?Q?CUn0OknwqGkNVz2toRlXGby3Wjdsf6ppmi6y0kZPWRTUVy3Fmg4es/460Ijg?=
 =?us-ascii?Q?9X8AFntxmS3vU8qzw3cZWEKMxGAH1PRLiKlMlTKqXeW7d7GcSLcxfiZBaQB+?=
 =?us-ascii?Q?wg8wnzZ0lXbChdjqTNaQYE4LMtLcrohccRa0V3uMbndQsZRgDzYgdzR5OFFm?=
 =?us-ascii?Q?Ujp4Yvnd6g1q9vn4airAKwP8SJnzuGS1sDbKsrB31AQVz7MvjNtXyzBF1S0A?=
 =?us-ascii?Q?2QomsG1rTv1IFwNAZfR5hGvPmhah+hUD9b0n4JutfBzcMV9+DL1DOsdCSL19?=
 =?us-ascii?Q?UwyxnJ+6EBS8Rh3oS4zBfZIZvEr+by/+/cf5WWkVAK9V4v/GhoWbbtOShGMj?=
 =?us-ascii?Q?YVsKKHSFnJZFYCHSnEd3m6FyYpwGYei3+/MOYCtPn+x9jRVIgJTenJFDafJB?=
 =?us-ascii?Q?QWXSqz8G6LCHHkhWsYtVS/Ipd/a8PbystrLfuVsnnGPja74Hpgvcq+ihiJtT?=
 =?us-ascii?Q?Ge42zIIt8J5hB2KtzuFb/SWLn0gyDeVhlO8fars40XCXQyLgJgomd8jnyOzY?=
 =?us-ascii?Q?Rw85DQ6SEPxouaJgiuE/85Gr3nM1yF5Y71AUwT+4Qa3BKrFwNyxnaZP+0vW/?=
 =?us-ascii?Q?nKoPKXMqPscrv+eXDggSIJ4PZlqBqeFQb856zK8bxm8Ke6CFGsuo8e+I3nT/?=
 =?us-ascii?Q?RjOjBAxcqnbN24OQ4eXpb11dL2sU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 13:57:54.8150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc53c937-f670-4c7d-4106-08dc62d4358d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6308
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

RDMA device with limited scatter-gather ability requires contiguous VRAM
buffer allocation for RDMA peer direct support.

Add a new KFD alloc memory flag and store as bo alloc flag
AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS. When pin this bo to export for RDMA
peerdirect access, this will set TTM_PL_FLAG_CONTIFUOUS flag, and ask
VRAM buddy allocator to get contiguous VRAM.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++++
 include/uapi/linux/kfd_ioctl.h                   | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 0ae9fd844623..ef9154043757 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1712,6 +1712,10 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 			alloc_flags = AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
 			alloc_flags |= (flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
 			AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED : 0;
+
+			/* For contiguous VRAM allocation */
+			if (flags & KFD_IOC_ALLOC_MEM_FLAGS_CONTIGUOUS_BEST_EFFORT)
+				alloc_flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 		}
 		xcp_id = fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION ?
 					0 : fpriv->xcp_id;
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 2040a470ddb4..c1394c162d4e 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -407,6 +407,7 @@ struct kfd_ioctl_acquire_vm_args {
 #define KFD_IOC_ALLOC_MEM_FLAGS_COHERENT	(1 << 26)
 #define KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED	(1 << 25)
 #define KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENT	(1 << 24)
+#define KFD_IOC_ALLOC_MEM_FLAGS_CONTIGUOUS_BEST_EFFORT	(1 << 23)
 
 /* Allocate memory for later SVM (shared virtual memory) mapping.
  *
-- 
2.43.2

