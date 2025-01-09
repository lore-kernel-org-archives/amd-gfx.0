Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B06E77188
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 03:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FC7110E981;
	Thu,  9 Jan 2025 03:04:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XpkznSQf";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 431FC10E97F
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 03:04:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIsPFyyn5Cg/u+5OLd0zT9t+oRShJeY+KX9gTfmlCdIWisVBlMuykB7gi9rfJSCH6s0oxuM0JBKe3/KW0H+9hEh1O3banK7C3EfQxN9rCiO38ht8hfu9WzpxTABqyGOS8/v9Ep92UQhfbQahEGPt1mqgMa1SlkhkyQjOdPEK3wfm7xZvfpgZIYiqD3a2NmA3otRn4gYsAtrwI3g8DPq1AF7+J7gro6chrKWGIvWIbPXhkwrGSPgnn2d4TgVa9zr/bq7+MQrd/WqvI1j/4mIF/d7lUHha2bZ9RJQXL55hJelUaBEpXBKYMrb2XjF4/m8/mJd8IQPir0oqbfB8+V6ZOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OL5pDAEgPtRCCnobBfhUunExa+Ve+/kX0O7qod/TO9s=;
 b=Av082Dac6/fbrXGN6bl+/HejmsB3VQmRNcGufVFB9cM9j7uVWi1B5Wjy8nj8qKCIuJzwB1oJKajrZG9zrr0WRBJvcQT7ZrnmDe/p8wwcze2q1NoaceGXRfxWk/+r+zpptwg4opo55cflA8IIesezDkgvQd4PtYeKUmmBZJ4I7bm6EeZSCtnO7TqGZrwh0W6EZ83qGmEMQpmJB3zu01xCREfzbcTaey0ugKeWokw9bA72xRmZBBZYGnwPsQBlwAjIh8adOOagy3jKBOw+4hmKAqsmHc165nm2UNKFoWGGKxq7VrOmjyS9mB0QyfcAfgG3TBp7aUI9vv8UsIM0G5jkfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OL5pDAEgPtRCCnobBfhUunExa+Ve+/kX0O7qod/TO9s=;
 b=XpkznSQfs/CgBSZWxfbYSSFHqyc60N+JQHe5m1tzgtUk4glByH0qwUGT7okyPQGNACZRdEVUxhgCf1jC8OsiKYQQduSL7hsePUG75/5658JytC/3xyIt/ZYrN+kOyzlX+QGAFik3d3AmqWFpGEMb1Xu24epZQNbvrrIMeaYqqEQ=
Received: from SA9P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::31)
 by LV8PR12MB9081.namprd12.prod.outlook.com (2603:10b6:408:188::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Thu, 9 Jan
 2025 03:04:07 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:26:cafe::2f) by SA9P223CA0026.outlook.office365.com
 (2603:10b6:806:26::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Thu,
 9 Jan 2025 03:04:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 03:04:07 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Jan
 2025 21:03:00 -0600
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>,
 <Xiaojian.Du@amd.com>, Tim Huang <tim.huang@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH 2/7] drm/amdgpu: add support for SDMA IP version 6.1.3
Date: Thu, 9 Jan 2025 11:01:28 +0800
Message-ID: <20250109030133.3887086-2-tim.huang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250109030133.3887086-1-tim.huang@amd.com>
References: <20250109030133.3887086-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|LV8PR12MB9081:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f397ab0-6c9f-4bab-8e4c-08dd305a4862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dDNvRs/sU/l1X1zz9vvU8ohCVxBHMkMmsrYzpzlgwIcRCT4tOvZgYqHKfBRp?=
 =?us-ascii?Q?YHRzkGF2oFoQMNjWoNfq2AVh4gEh4oDD01EjFNisQSlyGbdILI7Ljbi8qm+E?=
 =?us-ascii?Q?mV22KBlVi9ogyLlZ6zp3HN/TB6qzP2ID1S1Xb02GmNMyOkUApx8LomLWHt0H?=
 =?us-ascii?Q?WG110ti3uCMBaHLTANsa8U4WK1mBlsCIs/qC13cKzE2skZEl9lMolalZCqf0?=
 =?us-ascii?Q?f2oF/rK8dDmkF/hgZ+7X7h+Gtc+foloKyYi9mxdrAQStEYFVTRDt3HyuOM1D?=
 =?us-ascii?Q?fyOO90/R7GxuzQHdE/a0GZon4NAFOvLpTtDEMT1/37C81p1MAeDyvkbEZA/O?=
 =?us-ascii?Q?IwEYZVNQQPd8Bgn4i3+1GzZc6ld1r3ZO6VATLls9Lfp0HV1Rshb3TgAKLY7S?=
 =?us-ascii?Q?vypKen43SpYZLi4AK5PiwqW1Y1IS4krbfN8iXtz0Hr/DSmIuf1PEYtbAcFCU?=
 =?us-ascii?Q?kAwD07nfsY65FgzpmDp5V+YhlYUNWjh2G9acSt1p1TWLDMPRb6H7EaxDs9RZ?=
 =?us-ascii?Q?ogvSVN74HonmsGjTSOadr2fNVzxq+/04bn8MQjVUzQyCP6F4lg/nzVIHbaJ5?=
 =?us-ascii?Q?NgaZnQIZNA/b1mR86fsvFNTqlXzI6+phO5aCGZ3sRe/ES29JcTXWNPmCs6cm?=
 =?us-ascii?Q?cVS1WoQwE+D6vpJ7yX1M8DDzgJ6LUNSABcnNpDgHlnGAF2uXEihTEBs7OqIi?=
 =?us-ascii?Q?pt9Mv0dQe61qjRaE+mkCWp1GcixpY8mZLB/EOkzTBV3q8i+Wm4wSPj7evGIS?=
 =?us-ascii?Q?7FWUV56GD3PYTu+3cJWL1Blc99SIxINfl9wuV680/IjxR4cD81pAJ6V8aw3u?=
 =?us-ascii?Q?pgnqtvVWcw0MGNAAyiLVIC2206aq/PmMJ4xCn6Sh4fKa99Fb7Z2lADR21i//?=
 =?us-ascii?Q?IfY2DMTCD0zUBBCjzqCTXp0k1amLQGlrgUdjXlHDGzx98hk0ne46Bm2AGAMQ?=
 =?us-ascii?Q?bNz8zvZ6pv9Lg5Fvf/yH1Ano39RvOZsWFJJSfUtJOmq0EAKX6fBP1iXUKpZg?=
 =?us-ascii?Q?aUlbOiJV7XF9Qj01MA7pCEeZIx4sh4G/Oj7kcRKyqgNlHlIRmtUhXiNZFXQQ?=
 =?us-ascii?Q?hHpJV2rnpZZrSinF2NzmEIgKkOdIQllvz9VxCte6fLqZSpAx/gK6yqVoYfjC?=
 =?us-ascii?Q?opYRAfgfvfBYcWjY1irW9TRECs+B/l1ng4YkBJrWcN3mvsdgXGt8xb7F0z5G?=
 =?us-ascii?Q?lE4CZInbjlNqgkXuAPBCoYKTzg6L9G649gErP8kWnAfN03fd7YNZ2vVxd1H7?=
 =?us-ascii?Q?su8tXWue3bw7YUDUCYezgt6CaKa6ALfhgRMkKMSZOKcL8tchQURcSatgTxgH?=
 =?us-ascii?Q?Esi93htgS/kB7YrKCFTB1GcXcfN65Ca9A3W+y07+9BXElXx0nHws3cDqqWwA?=
 =?us-ascii?Q?YTty4paIkmkRPGLSPjN1Z5dGu5dORDoXykDDdjQo1JSyRLyDuTaAMpPEQtaP?=
 =?us-ascii?Q?IBnsoPWUIeXG+d8BQb7W59ZnKruepDNpRatLytuEcrjF48ELRRfnVLHtUUJe?=
 =?us-ascii?Q?N10whGaLIve7+xc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 03:04:07.5149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f397ab0-6c9f-4bab-8e4c-08dd305a4862
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9081
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

This initializes SDMA IP version 6.1.3.

Signed-off-by: Tim Huang <tim.huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index ea31418a479b..27b90fc7967e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2273,6 +2273,7 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(6, 1, 0):
 	case IP_VERSION(6, 1, 1):
 	case IP_VERSION(6, 1, 2):
+	case IP_VERSION(6, 1, 3):
 		amdgpu_device_ip_block_add(adev, &sdma_v6_0_ip_block);
 		break;
 	case IP_VERSION(7, 0, 0):
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index b0cce5270dba..b83a0a69ac5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -52,6 +52,7 @@ MODULE_FIRMWARE("amdgpu/sdma_6_0_3.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_1_0.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_1_1.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_1_2.bin");
+MODULE_FIRMWARE("amdgpu/sdma_6_1_3.bin");
 
 #define SDMA1_REG_OFFSET 0x600
 #define SDMA0_HYP_DEC_REG_START 0x5880
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index b5d70d803289..bd582ef4b935 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -101,6 +101,7 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 	case IP_VERSION(6, 1, 0):
 	case IP_VERSION(6, 1, 1):
 	case IP_VERSION(6, 1, 2):
+	case IP_VERSION(6, 1, 3):
 	case IP_VERSION(7, 0, 0):
 	case IP_VERSION(7, 0, 1):
 		kfd->device_info.num_sdma_queues_per_engine = 8;
@@ -122,6 +123,7 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 	case IP_VERSION(6, 1, 0):
 	case IP_VERSION(6, 1, 1):
 	case IP_VERSION(6, 1, 2):
+	case IP_VERSION(6, 1, 3):
 	case IP_VERSION(7, 0, 0):
 	case IP_VERSION(7, 0, 1):
 		/* Reserve 1 for paging and 1 for gfx */
-- 
2.43.0

