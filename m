Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F8AEE4993
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Aug 2023 19:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F315910E181;
	Mon, 21 Aug 2023 19:20:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D195910E175
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Aug 2023 19:20:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIkJ3wlQZNf5CA/xWLN1Zcv9Sj2G0WWNZSeloo2abTVFTb4CaK4pXvlQEVsJPpRuoXH4FThocLWQEjbpAGZ5OagfVZIVOxXYIwSgLaEHjGJZVkuQtzdtBVqCbpI8AKGg+zQ6abUB4opkSpH2vAOXkkAcS6ytd0JiQG6MY7fuYfd+hOKFkTBbu3/+xVDOU0ZoX55PiHNffncFUvQz9z9f8lsw2gpOWie2VTjaEty92KT7hqxsa5dMokUiLDi33J9dleM0lU52dDzK9MM85KDns9t63W6GrzQXga4XQ5dQJyk4xRxEKj7sco4Y7KmTcCjRtI/PnmhWJGRTxdSQLopH+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3g0zP2C6kubD/n/GSd9D8DivOnCCj5wuX1oTbcs99k=;
 b=fxEO+krm1iA3WWlVwQjjOxNQXeWrDfd1VqrYFxChviJ3dndGmgYlbIEUmO9PrNX6naoZyrk+AxKHWZg5Yht9Lk6yfnl2hEOqW20Cy1VGIHXVyZRjl0l1bDX63CUEYQDdTYBrHTNRGO4DzgU5K75nMjY2o38BZNimEfEf5AQI0X8SLzc4hbZjiygetTSr+4ps+TUtsDBgd3vgcQft++uVuY7/6nFMKQNQCHC+KK3dOT5bi017KnUrX9oTlXYDG7i2k09FNHpMlNWmAEjBejRIEFnfnO1fI97MEZICdA2rY84mb4atxgxNU8gLUaSA+wtU9CvtMurp5hvpjNZ4N5DS/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3g0zP2C6kubD/n/GSd9D8DivOnCCj5wuX1oTbcs99k=;
 b=0Zot1OCvrxv59tfrlWum/CiNub5IBbVzgtek96sl2FI/H0YvWnuJ2uO3mCjHGsF2F/1hXJ0hqSXSq9StpCU3PCCP4VDCPrKjWMJ8+qrHtuL1aaHRCTpai7hnhypLEsJkZ0MAHYacSEohR9XPdi+iWF/OFs/VmDcSwYRUJYem82g=
Received: from CY5PR22CA0108.namprd22.prod.outlook.com (2603:10b6:930:65::26)
 by DS0PR12MB8503.namprd12.prod.outlook.com (2603:10b6:8:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 19:20:16 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:65:cafe::84) by CY5PR22CA0108.outlook.office365.com
 (2603:10b6:930:65::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 19:20:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 19:20:16 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 14:20:15 -0500
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu:  Rework memory limits to allow big allocations
Date: Mon, 21 Aug 2023 15:20:01 -0400
Message-ID: <20230821192001.12370-1-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|DS0PR12MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: ff2baffd-74b9-4b77-403b-08dba27ba6ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RDn82onwTh3YZwXUGKE9w49aaUvdmPVloAG/VQmtzYjS/fT/OTMBU9i/zl/LgkBVkrPtoCQlbkaGN8QFOdzR3JcKGcsljNYlHmpqkGNw9YZHPfjQB8o29H+YPMda0nSoAequv+ZhPlGh21nr8v1NcQkS6hgDujaZkrm/wA8s6X/AttS/WKsKn/bMwWjJeOgTj4L9Gj95cPgMXFMr3r/gvoDhYdg/2y+zy3C6k4513h7S79ZFNR1Yj8CLn/PyvnOtE0lMpOSvlWjmAbyWoHokoA4sqDZkPHbzVYqRg4HOXwa8kt8tqSwEQwIoQmwEF/bfd6BiIukcfIWzmKBgco9M1adzlpvb9yKP2GnWm2+AG+y4iT4l+IR0B0H5F1o/Hxm4SmpfmOC5zyOrOZ7f3QGfZg0PCUNV+rf+jUSRDA2jYoEWO7v13aesJB5lHeWALvBAd0TjwXwdTjBwY8fJcCebcUnds0y2+jdnzg55QgYSGybBbGRQ+p2H0ucm7eVlNCRtkRbxUphyOY2x6173mdtUPr1LqlLu9nMJB9wXkx9WcsOO3/bxbTyhhaXe9/733dIeh+Dx66Uujxz96/j2ZeXLUwRFukzEnjSwAdFEZ46V82nAAkoLDFKHDnlQu45OfM/oWshvrKUxTbYXvCpKy0kXsLhKw5nBTMtMsFK3u3eoRt/7Lw7S1w1m2r0w3R/6Gog/Kqk2VO+T5N7EJjR7a4lPWLSFpVwBGDt9qzA6g+mWkRUIpNCEA+9/HO4kBxjb30q3c6TBPgm/dodSxjvQTqd59A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(82310400011)(451199024)(1800799009)(186009)(36840700001)(40470700004)(46966006)(2906002)(83380400001)(7696005)(40480700001)(5660300002)(44832011)(336012)(426003)(16526019)(26005)(36860700001)(47076005)(86362001)(8676002)(8936002)(2616005)(4326008)(70206006)(316002)(6916009)(54906003)(70586007)(478600001)(82740400003)(356005)(81166007)(6666004)(36756003)(41300700001)(40460700003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 19:20:16.2609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2baffd-74b9-4b77-403b-08dba27ba6ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8503
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
Cc: alexander.deucher@amd.com, felix.kuehling@amd.com, christian.koenig@amd.com,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rework the KFD max system memory and ttm limit to allow bigger
system memory allocations upto 63/64 of the available memory which is
controlled by ttm module params pages_limit and page_pool_size. Also for
NPS1 mode, report the max ttm limit as the available VRAM size. For max
system memory limit, leave 1GB exclusively outside ROCm allocations i.e.
on 16GB system, >14 GB can be used by ROCm still leaving some memory for
other system applications and on 128GB systems (e.g. GFXIP 9.4.3 APU in
NPS1 mode) nearly >120GB can be used by ROCm.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  5 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 25 +++++++++++++------
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 9e18fe5eb190..3387dcdf1bc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -44,6 +44,7 @@
  * changes to accumulate
  */
 #define AMDGPU_USERPTR_RESTORE_DELAY_MS 1
+#define ONE_GB			(1UL << 30)
 
 /*
  * Align VRAM availability to 2MB to avoid fragmentation caused by 4K allocations in the tail 2MB
@@ -117,11 +118,11 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
 		return;
 
 	si_meminfo(&si);
-	mem = si.freeram - si.freehigh;
+	mem = si.totalram - si.totalhigh;
 	mem *= si.mem_unit;
 
 	spin_lock_init(&kfd_mem_limit.mem_limit_lock);
-	kfd_mem_limit.max_system_mem_limit = mem - (mem >> 4);
+	kfd_mem_limit.max_system_mem_limit = mem - (mem >> 6) - (ONE_GB);
 	kfd_mem_limit.max_ttm_mem_limit = ttm_tt_pages_limit() << PAGE_SHIFT;
 	pr_debug("Kernel memory limit %lluM, TTM limit %lluM\n",
 		(kfd_mem_limit.max_system_mem_limit >> 20),
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 8447fcada8bb..4962e35df617 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -25,6 +25,7 @@
 #include <linux/pci.h>
 
 #include <drm/drm_cache.h>
+#include <drm/ttm/ttm_tt.h>
 
 #include "amdgpu.h"
 #include "gmc_v9_0.h"
@@ -1877,6 +1878,7 @@ static void
 gmc_v9_0_init_acpi_mem_ranges(struct amdgpu_device *adev,
 			      struct amdgpu_mem_partition_info *mem_ranges)
 {
+	uint64_t max_ttm_size = ttm_tt_pages_limit() << PAGE_SHIFT;
 	int num_ranges = 0, ret, mem_groups;
 	struct amdgpu_numa_info numa_info;
 	int node_ids[MAX_MEM_RANGES];
@@ -1913,8 +1915,17 @@ gmc_v9_0_init_acpi_mem_ranges(struct amdgpu_device *adev,
 
 	/* If there is only partition, don't use entire size */
 	if (adev->gmc.num_mem_partitions == 1) {
-		mem_ranges[0].size = mem_ranges[0].size * (mem_groups - 1);
-		do_div(mem_ranges[0].size, mem_groups);
+		if (max_ttm_size > mem_ranges[0].size || max_ttm_size <= 0) {
+			/* Report VRAM as 3/4th of available numa memory */
+			mem_ranges[0].size = mem_ranges[0].size * (mem_groups - 1);
+			do_div(mem_ranges[0].size, mem_groups);
+		} else {
+			/* Report VRAM as set by ttm.pages_limit or default ttm
+			 * limit which is 1/2 of system memory
+			 */
+			mem_ranges[0].size = max_ttm_size;
+		}
+		pr_debug("NPS1 mode, setting VRAM size = %llu\n", mem_ranges[0].size);
 	}
 }
 
@@ -2159,6 +2170,11 @@ static int gmc_v9_0_sw_init(void *handle)
 
 	amdgpu_gmc_get_vbios_allocations(adev);
 
+	/* Memory manager */
+	r = amdgpu_bo_init(adev);
+	if (r)
+		return r;
+
 #ifdef HAVE_ACPI_DEV_GET_FIRST_MATCH_DEV
 	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3)) {
 		r = gmc_v9_0_init_mem_ranges(adev);
@@ -2167,11 +2183,6 @@ static int gmc_v9_0_sw_init(void *handle)
 	}
 #endif
 
-	/* Memory manager */
-	r = amdgpu_bo_init(adev);
-	if (r)
-		return r;
-
 	r = gmc_v9_0_gart_init(adev);
 	if (r)
 		return r;
-- 
2.17.1

