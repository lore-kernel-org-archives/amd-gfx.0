Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621C4E728D7
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Sep 2023 18:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95E2D10E5EC;
	Fri, 29 Sep 2023 18:19:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91D5110E172
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Sep 2023 18:19:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aw+8nXhEjrUr+nxdlQFH73c3olfCEjDocbimrzTx5kGrl+bS+WaiNjeJ/lIUSKH+Bt5s+ksgOq9dPlo6T3qFm0KhRBnmQa9T0LTevPJWOzHf8cIXlbp/sKXKJ1xNrqfUS4JwFkyFKOxicvFcRhmyqpKUbqqKMSPnyN8tDKcuvg1/m4xOlCrQhlVVAjU/yKHSt9EKYK46tFXzWKZzWdWDDcvA7tJ6WOa2yEI2oOKVpxmN4yJ9XnBamPivhmVi7akpa89J320NYDw0c2DGKEQEcJ7Y7mL+JUz/GkgBWXpLuYahFBG5V9q2taAMUs3TxV1+aJKDVQOkOMhzAIfwb3gf9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrwLLuVou4EIrthN4KhpAoyTHNqODuAolT1xkOIFDc0=;
 b=XIZ8Ioi4PP5bsSk2ielFTTG1eziY4XiN8vUhTz9rPqZPS5cnk9G50+K5qZ1c7MFMfGcMxUrJQ3ntuBUcWhBXfXdfDMWaejruK/yDzDRTe3m3WgfDj1qVLml/4RKpk1bSRQ1Z9C3g+4M/6NcEWwdzp/U23HBaulxVnc/Q/V2wbO8rQyLHNKt+CV4R46HhJrMMV4Eu6E6A3RUWGrZNCRdDsIU5VFANFJr86cRB94Qln9NhFTOb4rppqrAkaZCKREOlu/KxpGu9wuDr7uamNDb0ZM+HR/MKLbQ+fcVGHj5QZQpXgigWBIeiDTnAToJMCmricu0pAYuGx7hQFtFvHZ+wbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrwLLuVou4EIrthN4KhpAoyTHNqODuAolT1xkOIFDc0=;
 b=uk9nvMXv3gmfWijX6VqGqMJ13uE2SwP99bhwA9AhIKRHCyll8rMHb/dzjA+0/bI8+7203pSFaOXYFzlAfGeTkBU73vGPDN7httm1qafKSWyLm73Y4T0n4ZeLRGQGyWKmvwMX358WQAzxYnCW27pPViK1WegtpdUiAe+KuBIYKXs=
Received: from MW4PR04CA0089.namprd04.prod.outlook.com (2603:10b6:303:6b::34)
 by PH7PR12MB5653.namprd12.prod.outlook.com (2603:10b6:510:132::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 29 Sep
 2023 18:19:12 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::25) by MW4PR04CA0089.outlook.office365.com
 (2603:10b6:303:6b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25 via Frontend
 Transport; Fri, 29 Sep 2023 18:19:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 29 Sep 2023 18:19:12 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 13:19:11 -0500
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: Use ttm_pages_limit to override vram reporting
Date: Fri, 29 Sep 2023 14:18:56 -0400
Message-ID: <20230929181856.2311515-3-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929181856.2311515-1-rajneesh.bhardwaj@amd.com>
References: <20230929181856.2311515-1-rajneesh.bhardwaj@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|PH7PR12MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 84bf3ebe-9927-4a4e-b403-08dbc1189509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: awrghpbry3ikgsMLwckYLXvTFd62OxRNaWmiNlxo5TLvi1+M5lt43NyFd9sQccbUgqqkwjT1/NkXImFnELOGjTiJwy61MEdKPPtMVFy1jb55rXi+LQR814ZQFiZZGidQkq3dsgCIJ8HH+yBEddjbjKD4++Kekq/k8CyB6P8KvAB9+2VXsAMX17uj9NkBwy7TPF+kUigkeCTx6ByJeSeSfI3YJBU6h9lx2ExVV04sMrKnDzqPFGJepD93lFkQbLXWvt0jxVDBleBsIFmP/0+vWyE1+ORNVxtX/09wilEQJrnLK/IF9glllckvRH95qBTiv8uh2YDuZvDH+0568Wxz2w6kuvAjHPT1LIpS7idAN8fX00hbuXWDnqL67YURzEoO4E7OYigHcsE3WxivFiJ3OOSoDTb29xyKpI+37STRnfhMifpW2qjxEE5Lc6QDNFROibe6kb1TpylU3wb3zrx1UtZ/TGs8In7F6P5napr56oKQbSIbRqf5hWAF6OVyUpdaHbwciS/eMRmB2rH7xGNrJIVDEta5SryqChZ0ihYmdECyHqsCZuAOvfbH42KhlCNPd3T4kLoMy7fvmI5OSQD5eoaKWGkVSlGQ7ptX7JwDpmxR2w3dIHP5Eklb6a0CMqVsu54pd42dICJ8z/eG4fQwT6GhN5QYB5W76vWFRal7VxRoq2yAPVW1bTNSbhvDsTQLOnVXL5bPWZXMXWryQGyI1j+DGdQKrty794jS616QabeEuFNbfrdMN/i9Bv1yeJASYUerVE/DfcqfDBydtDNIXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(82310400011)(36840700001)(46966006)(40470700004)(7696005)(2616005)(6666004)(40460700003)(81166007)(36756003)(86362001)(40480700001)(356005)(82740400003)(36860700001)(336012)(1076003)(26005)(426003)(2906002)(47076005)(478600001)(83380400001)(16526019)(4326008)(8676002)(316002)(8936002)(41300700001)(44832011)(54906003)(5660300002)(6916009)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 18:19:12.5467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84bf3ebe-9927-4a4e-b403-08dbc1189509
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5653
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
Cc: philip.yang@amd.com, felix.kuehling@amd.com, lijo.lazar@amd.com,
 christian.koenig@amd.com, Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On GFXIP9.4.3 APU, allow the memory reporting as per the ttm pages
limit in NPS1 mode.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 005ea719d2fd..fadc4d2ed071 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -25,6 +25,7 @@
 #include <linux/pci.h>
 
 #include <drm/drm_cache.h>
+#include <drm/ttm/ttm_tt.h>
 
 #include "amdgpu.h"
 #include "gmc_v9_0.h"
@@ -1896,7 +1897,8 @@ static void
 gmc_v9_0_init_acpi_mem_ranges(struct amdgpu_device *adev,
 			      struct amdgpu_mem_partition_info *mem_ranges)
 {
-	int num_ranges = 0, ret, mem_groups;
+	int num_ranges = 0, ret, num_nodes;
+	uint64_t node_size_ttm_override = 0;
 	struct amdgpu_numa_info numa_info;
 	int node_ids[MAX_MEM_RANGES];
 	int num_xcc, xcc_id;
@@ -1904,7 +1906,8 @@ gmc_v9_0_init_acpi_mem_ranges(struct amdgpu_device *adev,
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	xcc_mask = (1U << num_xcc) - 1;
-	mem_groups = hweight32(adev->aid_mask);
+	num_nodes = num_online_nodes();
+	node_size_ttm_override = (ttm_tt_pages_limit() << PAGE_SHIFT) / num_nodes;
 
 	for_each_inst(xcc_id, xcc_mask)	{
 		ret = amdgpu_acpi_get_mem_info(adev, xcc_id, &numa_info);
@@ -1912,7 +1915,6 @@ gmc_v9_0_init_acpi_mem_ranges(struct amdgpu_device *adev,
 			continue;
 
 		if (numa_info.nid == NUMA_NO_NODE) {
-			mem_ranges[0].size = numa_info.size;
 			mem_ranges[0].numa.node = numa_info.nid;
 			num_ranges = 1;
 			break;
@@ -1930,11 +1932,16 @@ gmc_v9_0_init_acpi_mem_ranges(struct amdgpu_device *adev,
 
 	adev->gmc.num_mem_partitions = num_ranges;
 
-	/* If there is only partition, don't use entire size */
-	if (adev->gmc.num_mem_partitions == 1) {
-		mem_ranges[0].size = mem_ranges[0].size * (mem_groups - 1);
-		do_div(mem_ranges[0].size, mem_groups);
-	}
+	/* In NPS1 mode, we should restrict the vram reporting
+	 * tied to the ttm_pages_limit which is 1/2 of the
+	 * system memory. For other partition modes, the HBM is
+	 * uniformly divided already per numa node reported. If
+	 * user wants to go beyond the default ttm limit and
+	 * maximize the ROCm allocations, they can go up to max
+	 * ttm and sysmem limits.
+	 */
+	if (adev->gmc.num_mem_partitions == 1)
+		mem_ranges[0].size = node_size_ttm_override;
 }
 
 static void
-- 
2.34.1

