Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC1BC7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB2E410E413;
	Tue,  9 May 2023 22:14:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42B3110E3E4
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:14:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TK2aiRVGQiUxjH3i5BKCZGYP+Wm3hycA7sIKeJytjZu8JGwR7mGRUVMrFuV4XBe2X5WYIwfjyOjOFDulG5LfbWdgxf5V2pJ2pYsrlQ2r8mlC865ub2tBHGcZgMCeDW3K4uN8Sf8ssCbWFChSxxdVQf/M5Bi3NjueWN26QCbVbaSUsXU4ZQiooCBGrhwDbw1LQfudlfCx9/XmLw8yaXiLsZlwCTAmeA5uyspJHv7Vs0gIoG4Y3ZC8qXsHx3WDDlnEhCWu6cJPBD02d+y7svzVi0LR0DKd6F0wrsPwNpqjYoKrEN3OeEvtx+v9c2/mmdV1e+l2gXK8QFQTfQ+inQYNWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LEaeoIk95cXfXssyLz0JJfR19uaAnVxMdDaZ6MTsvM=;
 b=Iv1Sz/Q1c2NGP896UR3pmEk3JVpgAIJ7I6skMnSpu7EA1nHWQe9ENMiM+lPyQRSptf1F4b9f1G9ZUahAXHAwkGkwV4G/1n/jsJV4mxw4fP23vtqs7Y7EtbMb0V3nHm81iAiyHnX3qNlnCA5jhSijZM9sqX3hZWT8N514TkQuGI6+SH+8uxg6he33lqm40mhMtlUVdPgTUTFZpKW70O6isoC8hKHkWkk9j54cOUydnaq/lVIlEAmPmh04OSXCsDgxZST5hLUD3fZ9PAZX7IS8UkpNNfyYx55NeT0Y4O/1+F18w8gO01JBL417s23UxPvDqv+8Qg4Z8hNi3FnMO9afdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LEaeoIk95cXfXssyLz0JJfR19uaAnVxMdDaZ6MTsvM=;
 b=uJhHUQY6iWf/NF78U4xGFgp0x+6bt4MDrjOJvZeIWL7iM0ex45zIITVViYUbUeudh6ed96ecKdHDO14p4+1oqdbswokz1QpKzuLCX8oM1h1KDhHtsiBp35FUM2lv+GAby79Uku1aYQBMbgkSo+vbT/ZAqbylVBSfB+Tp5T43DJ0=
Received: from BN9PR03CA0598.namprd03.prod.outlook.com (2603:10b6:408:10d::33)
 by SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:14:26 +0000
Received: from BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::69) by BN9PR03CA0598.outlook.office365.com
 (2603:10b6:408:10d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:14:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT105.mail.protection.outlook.com (10.13.176.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:14:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:14:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/14] drm/amdgpu: Initialize memory ranges for GC 9.4.3
Date: Tue, 9 May 2023 18:14:01 -0400
Message-ID: <20230509221408.476829-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221408.476829-1-alexander.deucher@amd.com>
References: <20230509221408.476829-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT105:EE_|SN7PR12MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d7a28e4-2c84-4a7a-46b1-08db50dac05b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bhwiAQzb8VhABAuYK4zcc/sVFA/mEge8emyUW1Cu8v9HoEYir0PCsLklnmsO10+Di7eCxoyZjCX02lHqvOx0F76fFOm9yLb2mISaElQDgottH1naNrvmZ4mZQnTg41mDQOfwkvJ9ZZ7y8u6i+q2RPVHqzom/CIGQK5qMevIHNysw55RpO4C238dqh3W5N0WBoaM4dPfqfCaK2VkQjCi6GCZykXkky1Bq36k0IIbL5s8g6F8AXip+fr8mSV+PHzRLQ2fTpmJikVj08Tx9J15tNgVocjBGDkPNNXI8Y/RtUiJJm/KHYiZ98ePXCUaF0Xnh/qKAPZKgZ+04fiBmeRzXo2mn2k5x07Wf8tT9G0XXLoW5DD3rITzJBNowcM/dCuy+TR519XpX5YkMWTwB+jUJiiO704dne4GpATy/qy/0M7820M1z+7Qaa5FR3VCDQsabanRyoGYxbPEFPZpTbe5fLsjt/a4rba5xw4xOh1gvEXyYbrd5PGGZMfkSW8lZQhO5eHei/WhBuBdTFCabnley0x0gWbYg82tvltOEhoOonjmhoZdyqQYlGcTCa+0DugApX9WBJybnmf/2XHqUbtRGhciqi47lhK5u/crzw+OnryKUyWz7mI+Ls/kqfOVWHCbuOjE/lzWvih2r8vxXOJNvQs8Vc2eMdoYRNUHK20PRYtAj6S1RkTML1LYiP/71LnW6aFCYroSdbQ//4/Z64NXrCgr93xzmNNhhLn8Jl/IJLDY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(36840700001)(46966006)(40470700004)(426003)(40460700003)(47076005)(186003)(16526019)(83380400001)(336012)(2616005)(2906002)(36756003)(86362001)(82310400005)(82740400003)(81166007)(356005)(36860700001)(40480700001)(8936002)(7696005)(6666004)(8676002)(316002)(41300700001)(5660300002)(478600001)(54906003)(70586007)(70206006)(4326008)(6916009)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:14:26.2888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7a28e4-2c84-4a7a-46b1-08db50dac05b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

GC 9.4.3 ASICS may have memory split into multiple partitions.Initialize
the memory partition information for each range. The information may be
in the form of a numa node id or a range of pages.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 172 ++++++++++++++++++++++++++
 1 file changed, 172 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 59412b263dee..393e90d8b27f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -79,6 +79,7 @@
 #define mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION_DCN2                                                          0x05ea
 #define mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION_DCN2_BASE_IDX                                                 2
 
+#define MAX_MEM_RANGES 8
 
 static const char *gfxhub_client_ids[] = {
 	"CB",
@@ -1742,6 +1743,169 @@ static void gmc_v9_0_save_registers(struct amdgpu_device *adev)
 		adev->gmc.sdpif_register = RREG32_SOC15(DCE, 0, mmDCHUBBUB_SDPIF_MMIO_CNTRL_0);
 }
 
+static bool gmc_v9_0_validate_partition_info(struct amdgpu_device *adev)
+{
+	enum amdgpu_memory_partition mode;
+	u32 supp_modes;
+	bool valid;
+
+	mode = gmc_v9_0_get_memory_partition(adev, &supp_modes);
+
+	/* Mode detected by hardware not present in supported modes */
+	if ((mode != UNKNOWN_MEMORY_PARTITION_MODE) &&
+	    !(BIT(mode - 1) & supp_modes))
+		return false;
+
+	switch (mode) {
+	case UNKNOWN_MEMORY_PARTITION_MODE:
+	case AMDGPU_NPS1_PARTITION_MODE:
+		valid = (adev->gmc.num_mem_partitions == 1);
+		break;
+	case AMDGPU_NPS2_PARTITION_MODE:
+		valid = (adev->gmc.num_mem_partitions == 2);
+		break;
+	case AMDGPU_NPS4_PARTITION_MODE:
+		valid = (adev->gmc.num_mem_partitions == 3 ||
+			 adev->gmc.num_mem_partitions == 4);
+		break;
+	default:
+		valid = false;
+	}
+
+	return valid;
+}
+
+static bool gmc_v9_0_is_node_present(int *node_ids, int num_ids, int nid)
+{
+	int i;
+
+	/* Check if node with id 'nid' is present in 'node_ids' array */
+	for (i = 0; i < num_ids; ++i)
+		if (node_ids[i] == nid)
+			return true;
+
+	return false;
+}
+
+static void
+gmc_v9_0_init_acpi_mem_ranges(struct amdgpu_device *adev,
+			      struct amdgpu_mem_partition_info *mem_ranges)
+{
+	int num_ranges = 0, ret, mem_groups;
+	struct amdgpu_numa_info numa_info;
+	int node_ids[MAX_MEM_RANGES];
+	int num_xcc, xcc_id;
+	uint32_t xcc_mask;
+
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	xcc_mask = (1U << num_xcc) - 1;
+	mem_groups = hweight32(adev->aid_mask);
+
+	for_each_inst(xcc_id, xcc_mask)	{
+		ret = amdgpu_acpi_get_mem_info(adev, xcc_id, &numa_info);
+		if (ret)
+			continue;
+
+		if (numa_info.nid == NUMA_NO_NODE) {
+			mem_ranges[0].size = numa_info.size;
+			mem_ranges[0].numa.node = numa_info.nid;
+			num_ranges = 1;
+			break;
+		}
+
+		if (gmc_v9_0_is_node_present(node_ids, num_ranges,
+					     numa_info.nid))
+			continue;
+
+		node_ids[num_ranges] = numa_info.nid;
+		mem_ranges[num_ranges].numa.node = numa_info.nid;
+		mem_ranges[num_ranges].size = numa_info.size;
+		++num_ranges;
+	}
+
+	adev->gmc.num_mem_partitions = num_ranges;
+
+	/* If there is only partition, don't use entire size */
+	if (adev->gmc.num_mem_partitions == 1)
+		mem_ranges[0].size =
+			(mem_ranges[0].size * (mem_groups - 1) / mem_groups);
+}
+
+static void
+gmc_v9_0_init_sw_mem_ranges(struct amdgpu_device *adev,
+			    struct amdgpu_mem_partition_info *mem_ranges)
+{
+	enum amdgpu_memory_partition mode;
+	u32 start_addr = 0, size;
+	int i;
+
+	mode = gmc_v9_0_query_memory_partition(adev);
+
+	switch (mode) {
+	case UNKNOWN_MEMORY_PARTITION_MODE:
+	case AMDGPU_NPS1_PARTITION_MODE:
+		adev->gmc.num_mem_partitions = 1;
+		break;
+	case AMDGPU_NPS2_PARTITION_MODE:
+		adev->gmc.num_mem_partitions = 2;
+		break;
+	case AMDGPU_NPS4_PARTITION_MODE:
+		if (adev->flags & AMD_IS_APU)
+			adev->gmc.num_mem_partitions = 3;
+		else
+			adev->gmc.num_mem_partitions = 4;
+		break;
+	default:
+		adev->gmc.num_mem_partitions = 1;
+		break;
+	}
+
+	size = (adev->gmc.real_vram_size >> AMDGPU_GPU_PAGE_SHIFT) /
+	       adev->gmc.num_mem_partitions;
+
+	for (i = 0; i < adev->gmc.num_mem_partitions; ++i) {
+		mem_ranges[i].range.fpfn = start_addr;
+		mem_ranges[i].size = ((u64)size << AMDGPU_GPU_PAGE_SHIFT);
+		mem_ranges[i].range.lpfn = start_addr + size - 1;
+		start_addr += size;
+	}
+
+	/* Adjust the last one */
+	mem_ranges[adev->gmc.num_mem_partitions - 1].range.lpfn =
+		(adev->gmc.real_vram_size >> AMDGPU_GPU_PAGE_SHIFT) - 1;
+	mem_ranges[adev->gmc.num_mem_partitions - 1].size =
+		adev->gmc.real_vram_size -
+		((u64)mem_ranges[adev->gmc.num_mem_partitions - 1].range.fpfn
+		 << AMDGPU_GPU_PAGE_SHIFT);
+}
+
+static int gmc_v9_0_init_mem_ranges(struct amdgpu_device *adev)
+{
+	bool valid;
+
+	adev->gmc.mem_partitions = kzalloc(
+		MAX_MEM_RANGES * sizeof(struct amdgpu_mem_partition_info),
+		GFP_KERNEL);
+
+	if (!adev->gmc.mem_partitions)
+		return -ENOMEM;
+
+	/* TODO : Get the range from PSP/Discovery for dGPU */
+	if (adev->gmc.is_app_apu)
+		gmc_v9_0_init_acpi_mem_ranges(adev, adev->gmc.mem_partitions);
+	else
+		gmc_v9_0_init_sw_mem_ranges(adev, adev->gmc.mem_partitions);
+
+	valid = gmc_v9_0_validate_partition_info(adev);
+	if (!valid) {
+		/* TODO: handle invalid case */
+		dev_WARN(adev->dev,
+			 "Mem ranges not matching with hardware config");
+	}
+
+	return 0;
+}
+
 static int gmc_v9_0_sw_init(void *handle)
 {
 	int r, vram_width = 0, vram_type = 0, vram_vendor = 0, dma_addr_bits;
@@ -1888,6 +2052,12 @@ static int gmc_v9_0_sw_init(void *handle)
 
 	amdgpu_gmc_get_vbios_allocations(adev);
 
+	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3)) {
+		r = gmc_v9_0_init_mem_ranges(adev);
+		if (r)
+			return r;
+	}
+
 	/* Memory manager */
 	r = amdgpu_bo_init(adev);
 	if (r)
@@ -1932,6 +2102,8 @@ static int gmc_v9_0_sw_fini(void *handle)
 
 	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3))
 		amdgpu_gmc_sysfs_fini(adev);
+	adev->gmc.num_mem_partitions = 0;
+	kfree(adev->gmc.mem_partitions);
 
 	amdgpu_gmc_ras_fini(adev);
 	amdgpu_gem_force_release(adev);
-- 
2.40.1

