Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41893CA0EE4
	for <amd-gfx@archiver.kernel.org>; Sat, 23 Aug 2025 07:20:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFD1710E1B3;
	Sat, 23 Aug 2025 07:20:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FtAjWzge";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A659210E1B3
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 Aug 2025 07:20:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTyHg1PMfuXaKyob2suSG2rxmxKT9srqtmdn0xQx7jUPQIdSiobhd2MlBQzBJUOUUHfJMLy5YsVgiQeggVhsabrNTpgCsz7emoGiRl0GjomlsvKCOpMUqSMDhcZBCffPWgMUvOe0pPQhN9FsEpnmD9b6MYKQk08AWiJAuDA+M2PIzywFnnJC89OsIhJa1NB2z66s+jDx67W0UXR//mjPVFXX0ODYc9XYGIzYPP9uwpyczwY8Dy7/Z9NXPm4NrCM9Yiv1zRZckVVKMZwGctDR1Tm2VSxq2Q4kfieQFZML6uDZtfsDoL/qWjc7H1syFydDx+y42fFvZvY4KW25j9zwfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bP0ncrUN7AvRFd7NA91zkjDnHuoNPWLrT6dUQmYuLYY=;
 b=PnO1c8JammznDsafTMjVP5R+ZVy7rEFV6tUEOjoIC6itky7IJiZrPA7f+RcLqDzv3Oel6MLq83XJrtTJ8NYSV351eJfFsJ+Q6Fx/t7t1mKjLf74dFmu21jWqWzBv1PJ7qAwW9/MZfduYSkZDhnXklsyvSB/ntCwj5EtfYY3vcBg26MTh1CL/RWSUp27EjxaRx9SuK5Xhq1DwyhNjGGh2OwQuhb/fsHdAWyIcLjkKRy/1aqV+HpjEf5dP1yHnHDWqrRbhHTbO2ySbh9KZ31TFTu/Yah6sV+ffB0MSos/rLtIewdYxbbgl5eXj6p4bbqvpRZw4j1JKvL97jViSwfHlcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bP0ncrUN7AvRFd7NA91zkjDnHuoNPWLrT6dUQmYuLYY=;
 b=FtAjWzgeX0MemwVcttA43g9i9k1cIQXAPxZ1gIjPNEDKMhrWPKX1pVSzfzIGpNDygK8YWI0xSOP8nPm27kqVH5ZGPDrfZyMjGykppRra52VquT5mo3fVeY5zdEnK5XUu+FHI/7F5StiW5ElXhWQ7T5v3/1jgjg3Gd1Hml3WgKW8=
Received: from SA1PR04CA0018.namprd04.prod.outlook.com (2603:10b6:806:2ce::23)
 by IA1PR12MB8493.namprd12.prod.outlook.com (2603:10b6:208:447::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Sat, 23 Aug
 2025 07:20:37 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:2ce:cafe::da) by SA1PR04CA0018.outlook.office365.com
 (2603:10b6:806:2ce::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Sat,
 23 Aug 2025 07:20:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Sat, 23 Aug 2025 07:20:37 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 23 Aug 2025 02:20:35 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v2 2/8] drm/amdgpu/ttm: Add New AMDGPU_PL_MMIO_REMAP
 Placement
Date: Sat, 23 Aug 2025 12:50:10 +0530
Message-ID: <20250823072016.1272328-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250823072016.1272328-1-srinivasan.shanmugam@amd.com>
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
 <20250823072016.1272328-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|IA1PR12MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: b3606364-28bc-4d81-8dbc-08dde2158ed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y05Mci91dWo2Z2RKOWYxYU5QQkdMWm5TUEpWR1lFQkc4cEpTVlZrWlBrOEND?=
 =?utf-8?B?WTJiOUg4b04xd21Dd1EzMytld0VoVXpxMXkwOE5pNlJYRGlsKzErT0l1VmhC?=
 =?utf-8?B?emJDYWFDejZGZ3pDVW1UNXIxcm5mR0p0Q3JCVkdGL0gwcm1TWEdUSmc3bjd1?=
 =?utf-8?B?NVhuS3Z1N1lqQmZYQVI5UVAvODBDcVZYajhveDUvUE85OHhtQ1RJK1lJZmVZ?=
 =?utf-8?B?OGNEcUNiNHVCTVRyd1VkT0dHVE5xcUlmdVJ2NDVxZUVIamVmSi9PampPRGd3?=
 =?utf-8?B?TzVFQnNuOTFFZ2VzMTc2L0VhYXNmOFFLNndiSmptRE9zMlBFKzA1T2FrY0hj?=
 =?utf-8?B?SHk5SmFLTlZyZC9Bek9SRUdkOVVNUnczSXNWWmlSc1AyOG5VakNKM3pYUXBO?=
 =?utf-8?B?cDBIT3dIMlFDanR1cWw0ZUpJd3c5c0g0cGMzZVplZGQ2UDlQZ2lFb3dhOHVo?=
 =?utf-8?B?Ly95WmpERzlHQVJCTG54SWg5UjlVdlpvR05nNFRsM0pCcUpSVDBsRDVNaXc0?=
 =?utf-8?B?bVU0cjNNTkc2dkRVVnZteUVLOUpYeFpzTjVyZHlzQWMvUlJLT2dPSHBCeTJJ?=
 =?utf-8?B?blhMN1ZrUlhGNUMxUVpCZVVVVk5CYjYwUFF0UTdYOGk2OHBJWlhXRkVQd1lr?=
 =?utf-8?B?dmRsaW1PWEVWU3pmdHAwL1puV2NFcjJQR3VZZFFEMEVCZElGY1l0NDZIL0pV?=
 =?utf-8?B?eTF1YzVvQ250Vmw4UThqNTJoM0NaNkJoYmwwNUIvNlpIaDRPSDN0UnFHNEZn?=
 =?utf-8?B?bTJaZi9ZdU42OFphcWdIVkZoR3hrRE5TSFI5bGJHVVBzTmVaOXR0S29JTnpS?=
 =?utf-8?B?bitTckRKWTRFaUc2K3lFOUQ5d2FKOERicUNPRU1QNkZwbzlzTjFrNWtIcEp0?=
 =?utf-8?B?alY1THV6aDBWWERDd0ttWVRVbm9CNU4zR3AwUnFZRldEWTYxZUl5SWc5L0ly?=
 =?utf-8?B?WjE5OThMMmlqa2lzeTJSQy94WVFVSGJXNjlDOVpIczVicUpZc2h6QXNZTzBt?=
 =?utf-8?B?aFdydVNhSWcyUjhJVm5lTndzZ081RUwvN2dnbTNFT0duSER0QVJ2eEliQVlW?=
 =?utf-8?B?MFBlUTFSdzBSWHJKcG9xdlFBb284MU5GdW9JZDdURld0OGY3cDlVK2E4L1dC?=
 =?utf-8?B?UWIza1VLK3A3UGNvYnVWWGhFYTVYanlIYzA5bzBJN3hQdWcxeXpmc1o2K1pJ?=
 =?utf-8?B?aHdlNmVOSG1tZmNIUVdmVXE3bWJVd0F6cHZxVVYxbE1JTWFXZjZLREFQYmhx?=
 =?utf-8?B?WGRpK2NJOFAvdDhBTkNPZUIwd3dzekNvMmtSb1JpRWw5T2NIRkxTZllJaUl6?=
 =?utf-8?B?d0RKU3MxTy9uSEMwYlo2VE16RnZsZGNFMytaNmFrdkswUE9TQXJQbnlLenQv?=
 =?utf-8?B?QnBRdU4vYkhDTWg2R1hYTlg3aVJLTlErVUtraE5FaFRudTZlTEV3ZHBXMFZH?=
 =?utf-8?B?bHp2NVdnWmQ3RE4ycHBEcS9rSWVRay9Ud1llWTVZTjBFbHJ3cUhiWUlkU21T?=
 =?utf-8?B?QjFXNENpYy9YRXBMS0tGYk9WclpoWEdESGVzKzJvc05iaGI1Tll6UENQU0Fn?=
 =?utf-8?B?K0p2a0FqUkQwRjFWbDd0MkdzRWdEdHlrbG9zSlJ2MWFGbmI0Tnd0a3hWZUpn?=
 =?utf-8?B?WWtJYWZoR2x2dVNLMzUvRno4ZzNuOGZPS245bndtVzBiZWN4UkVTWmNxMHhG?=
 =?utf-8?B?N3dQTFpwQmRpTHE0RFd6ZVYyUjRNbEJMUHpLa2NaVGt6YVpLMjJzdHg1WVhF?=
 =?utf-8?B?VElMNW1Dd3hodUVaelNtdFFoRzRtb1hBWVFEVFk2M1kzR3BCRG1hSkFaKzYv?=
 =?utf-8?B?WDEwd1JKS1VYUjB5NFRvelNZWHlqd210Q1YvUElKZ0gzeGlwU3FveVBKOFVo?=
 =?utf-8?B?aDBuUjJjSEhkOU1MelJZWTB3Z3BGeFVZLzRvMnh3ZWFaN1NQbWVuWk1NSDdk?=
 =?utf-8?B?alM4MmJUMXVERVlZOWtSanVZbW1lV1NHUFdLRWRJckI4K3JnMi8zWkxBY3ZT?=
 =?utf-8?B?dnFpN244cjdGVVlxUFpTdDRmZ05OQjBMUTV6elVCV0d6ak8zS3hNWVNDcHR0?=
 =?utf-8?Q?Bl6NAX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 07:20:37.4506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3606364-28bc-4d81-8dbc-08dde2158ed7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8493
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

Introduce a kernel-internal TTM placement type AMDGPU_PL_MMIO_REMAP
for the HDP flush MMIO remap page

Plumbing added:
- amdgpu_res_cursor.{first,next}: treat MMIO_REMAP like DOORBELL
- amdgpu_ttm_io_mem_reserve(): return BAR bus address + offset
  for MMIO_REMAP, mark as uncached I/O
- amdgpu_ttm_io_mem_pfn(): PFN from register BAR
- amdgpu_res_cpu_visible(): visible to CPU
- amdgpu_evict_flags()/amdgpu_bo_move(): non-migratable
- amdgpu_ttm_tt_pde_flags(): map as SYSTEM
- amdgpu_bo_mem_stats_placement(): report AMDGPU_PL_MMIO_REMAP
- amdgpu_fdinfo: print “mmioremap” bucket label

Notes:
- This patch bumps __AMDGPU_PL_NUM and (for now) TTM_NUM_MEM_TYPES to
  avoid compile-time guards.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 3 ++-
 include/drm/ttm/ttm_resource.h          | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 2309df3f68a9..bb17987f0447 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -34,7 +34,8 @@
 #define AMDGPU_PL_OA		(TTM_PL_PRIV + 2)
 #define AMDGPU_PL_PREEMPT	(TTM_PL_PRIV + 3)
 #define AMDGPU_PL_DOORBELL	(TTM_PL_PRIV + 4)
-#define __AMDGPU_PL_NUM	(TTM_PL_PRIV + 5)
+#define AMDGPU_PL_MMIO_REMAP	(TTM_PL_PRIV + 5)
+#define __AMDGPU_PL_NUM	(TTM_PL_PRIV + 6)
 
 #define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
 #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2
diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
index e52bba15012f..f49daa504c36 100644
--- a/include/drm/ttm/ttm_resource.h
+++ b/include/drm/ttm/ttm_resource.h
@@ -36,7 +36,7 @@
 #include <drm/ttm/ttm_kmap_iter.h>
 
 #define TTM_MAX_BO_PRIORITY	4U
-#define TTM_NUM_MEM_TYPES 8
+#define TTM_NUM_MEM_TYPES 9
 
 struct dmem_cgroup_device;
 struct ttm_device;
-- 
2.34.1

