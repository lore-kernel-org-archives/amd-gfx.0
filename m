Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F62CA0EFF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 05:43:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8D2610E6FA;
	Wed, 27 Aug 2025 05:43:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UU8/2hiW";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48C1610E6FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 05:43:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oaeXCdQhMH0qWddAfSsycbKx9aWMIxtPSfolOi3epxqT/yHDZsHYGV1nkUvumkD/XLqXzOqWuTG6w1ucc32zz1iUnl5fKCQCOAPZnjgk8RHlb6LzhJ+Q0NxwM0As131qcYL8nWkQcPfiznhbAMkSPwJBSEIutTcL08X0x7EBXqn300PCrY/1dbjCpQNnGGLOSC8ffcu3n1hOlrRcUc/5c+/bh1JYN4EwP+h3IAgVWi9UW0cgOwi3J5XRkDySxK2V0snR3GlZRb3FAPRcGTTbKYHP3VRJx1dm8meKfKCkcxqmpzR2W1Q6CKaY9elxhcEhAwWFN8Bq9T/twiDTaeMcUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLIb/H/+ekzl+ljKXxoBwbz4wkEvMmlLpRO6Z24aHYQ=;
 b=RzmCdbkM6yJlq4p+YZoP3PO6SpMWigw+jP9dmfqqNnoGbfF9HBZrnb/im4j2YfbAjDQJkxPqCX7BrtWS0gqebn4Xxi50jxwYYaKrJ4xF2UbB5rBNLyhGnUwu+pW2l1MOdaiqHL8reBms1uFoOv27VAqmXr8cHl+0xuwNBaEDxF252983LwCqdQmGfXEf2qWSEO4hRSL4o6bXxwYL0GOpY/PLz/IzvfpJZrvvAVrdNoVOm6s/uWmT1Zx3BllUHJm+lj1cKhrwbnu0qt2+Odn/ugrw6Pakv1JiQNtqrOj5CSKLjJ29ZfLdtYBXdfVVF1/ZgMJDvqqQHlzJLLqUwa3AKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLIb/H/+ekzl+ljKXxoBwbz4wkEvMmlLpRO6Z24aHYQ=;
 b=UU8/2hiWYPWMr2IyHZBS4Rrjg62gf/+cwGOiKKBkMj/aB3L76wyDRaztG0bmsuDEaOU29NJcwMCon1gsI5eSyKJrg6yP9H19SbI46lQ5YUUEhMafJ+40cl9V0ZOiWDdVdhsb0Mstd9wdNcmFjVpaZrCD8TDjnuTW3T6kOYcnZkM=
Received: from CH0PR03CA0323.namprd03.prod.outlook.com (2603:10b6:610:118::6)
 by CYYPR12MB8921.namprd12.prod.outlook.com (2603:10b6:930:c7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 05:43:38 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::6e) by CH0PR03CA0323.outlook.office365.com
 (2603:10b6:610:118::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.13 via Frontend Transport; Wed,
 27 Aug 2025 05:43:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 27 Aug 2025 05:43:38 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Aug
 2025 00:43:37 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 26 Aug
 2025 22:43:37 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 27 Aug 2025 00:43:36 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/sdma: bump firmware version checks for user queue
 support
Date: Wed, 27 Aug 2025 13:43:05 +0800
Message-ID: <20250827054330.1791207-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|CYYPR12MB8921:EE_
X-MS-Office365-Filtering-Correlation-Id: 4749ce37-35d0-4a44-bf4e-08dde52cabf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bavZg2LOC1+SiIuP0UmmqQTanKXhdCdyNCE4OXzZoiH2tmTmof0yJMNR7yCa?=
 =?us-ascii?Q?njuSNfAm8PoHovTN7NCLHEimt68YUKf6Nyi1rZGcOxnB/bh8axCtntBLrMLZ?=
 =?us-ascii?Q?Zo08HnSkAtcs+1WB6iQFEmfmPlEQG1DH2rKp9bdVYDqHxHdKq0Co17fQup4P?=
 =?us-ascii?Q?v7/5wGCfQSZcJzJX+3tj3W10lo1FnDcNh5F31plz6EmkeXla3s0voYIOAOt7?=
 =?us-ascii?Q?+b+kJ8Tc9Aac6BgJ/+fIyWYcp8ief1N/RrrI2dDFfjxzYfpTBl0Sj5oA/unQ?=
 =?us-ascii?Q?XLuwTzerGZIXK3at7BqKi2G6GL8oEYrmifcXOegU63P4p1yKMiqzxlfkNART?=
 =?us-ascii?Q?9ftEDaxBSCN28C9YpdZ951W7i/1cGbKUNJ+Kf9d3AAsxmzP7rmc7WyPq29/o?=
 =?us-ascii?Q?IVXibXDuDmv30eIDurt6N8v5x9Sq9gD1rER2L320sYTqfBFA5SbgQDplVeYN?=
 =?us-ascii?Q?z1tn7MEYaXtdd4h726PLDSAU6QY9v/VQYfohZQnk4TmKmM2WlefqyBW/DRqH?=
 =?us-ascii?Q?e/zgQdWpfuuhYk/NxsHEdnkTD/cJmycVzc0qxImgczd5csIcdHSQamUzFraz?=
 =?us-ascii?Q?MyzhOZATckTSS809J5ATDQdGX+2VmkAaVBJVynOmGVmmgWTZ1XNSRuOPtd/X?=
 =?us-ascii?Q?ViDjqJa7q+ra/q4/HzjdlYBJDZuUL/NuupP5vqw5qh1tkUGarXH4m03aN3oL?=
 =?us-ascii?Q?XayQguHw96BYduSqgOAf5z3gnYZmsNEmV+1jVZs1eMFyBeDZRdCxpS7Z6rH9?=
 =?us-ascii?Q?STwgmnTHk2gXQQszNDtc2NCvnGJy14uuJwLbJFUyzEv8Fvrof4WIAyG0tTeB?=
 =?us-ascii?Q?tJjTkiDRu/1I+ztt8o4jnIx1b4YmEhEF6ajuRES1WqZTiXVkIybKgr7z4MQB?=
 =?us-ascii?Q?JrKyFCSuCiMG0eTC0u77aSczVr4bQUz+ZpyKnDCDUpUhSuA4AFFJuDp8/AB/?=
 =?us-ascii?Q?2rm2fLAy2fwEobLlQxEBPen4+pgV2sCZlJ39Ays+PKLWoasdcvKjjSeNNfdr?=
 =?us-ascii?Q?V7JExq92kLSDrUUxoZYR//nWDbyfj/0sNRDIWMX62rIvQLkX5d97LdekZILM?=
 =?us-ascii?Q?hhodFf/qCJ3HMxpgi+zCnByvmYDMkME4aSsXhTEiXcoNg+M2WnfrVx5v3NVZ?=
 =?us-ascii?Q?iRPL49iSEbhboXf64pcj5hSWFiUdv2ZchfdGvwRoTQND/t4eJ/WU5fzXn45d?=
 =?us-ascii?Q?O0/k2QiZtrOxoOc1+2Xs6JwmZNUbsS0Abvg1eav/cHGY7r4TkLaY1Ya6uKYq?=
 =?us-ascii?Q?zyAOCX0C8qSg0D1P8FN5sOnuD2iV7tOiwD6blDdA0JEpDsHdF0GpE1os+uA3?=
 =?us-ascii?Q?2O3r23DzV2Dqmx95NKoHbzUpJGU6FcPZY2uBbczhhSvMNECj7Ek5lQTC1v8V?=
 =?us-ascii?Q?PMJf7CiC9/fGjopsPJzTl31XkVuBsMyoH23GSvNn4eBPHFtaNRObN6NUBYhd?=
 =?us-ascii?Q?w7ZARM/BjNeFCEo44ZRx21OxMbfg7lrrsJkZDf3sBxqiu9jVlble/Zylz5on?=
 =?us-ascii?Q?VCxabj0b6ytU2/O2bpJenhGXvNG5jykXTpiG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 05:43:38.2450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4749ce37-35d0-4a44-bf4e-08dde52cabf8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8921
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

Using the previous firmware could lead to problems with
PROTECTED_FENCE_SIGNAL commands, specifically causing register
conflicts between MCU_DBG0 and MCU_DBG1.

The updated firmware versions ensure proper alignment
and unification of the SDMA_SUBOP_PROTECTED_FENCE_SIGNAL value with SDMA 7.x,
resolving these hardware coordination issues

Fixes: 604d44879707 ("drm/amdgpu/sdma6: add ucode version checks for userq support")

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index e6d8eddda2bf..db6e41967f12 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1377,7 +1377,7 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
 	case IP_VERSION(6, 0, 0):
-		if ((adev->sdma.instance[0].fw_version >= 24) && !adev->sdma.disable_uq)
+		if ((adev->sdma.instance[0].fw_version >= 27) && !adev->sdma.disable_uq)
 			adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
 		break;
 	case IP_VERSION(6, 0, 1):
@@ -1385,11 +1385,11 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 			adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
 		break;
 	case IP_VERSION(6, 0, 2):
-		if ((adev->sdma.instance[0].fw_version >= 21) && !adev->sdma.disable_uq)
+		if ((adev->sdma.instance[0].fw_version >= 23) && !adev->sdma.disable_uq)
 			adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
 		break;
 	case IP_VERSION(6, 0, 3):
-		if ((adev->sdma.instance[0].fw_version >= 25) && !adev->sdma.disable_uq)
+		if ((adev->sdma.instance[0].fw_version >= 27) && !adev->sdma.disable_uq)
 			adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
 		break;
 	case IP_VERSION(6, 1, 0):
-- 
2.49.0

