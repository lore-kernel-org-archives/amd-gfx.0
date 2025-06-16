Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA26C71136
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 09:39:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C3F510E319;
	Mon, 16 Jun 2025 09:39:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ymZDRE5D";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06EBD10E319
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 09:39:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6JqE62oo/k5+qL0lkQlKhQK04omHyh9ZiMn6dhp/1BZtBWQkXzt7qyiaIt1QDMy1sx1dhoHxrvothJWqJWszRbIAoxwW/HvbyfthJzpIiExpR10O7EWSDK8OzTbZy+R8hYRabf0Ox+9sROgJ6BHuUdEBgcKE8S3sTaVo4A+/n3yt9s0oyeW5YRj1Y8OS7Jzx5gLbCB3ihPbBB0KwWXlTMbJFfpKHZodYef8KD7Zk1Ng7bHrx9FBVXLvAvrUO2AVOO8Uq2NLHwAXXvk8l67XdW8iQKYva1mlEF0yaU2PoWCvXObI95JjcQvEdi8pxH23Wz6l+BD3RgXZn60wMMnt4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NJF1FG/icLF9MdAiHVEtbzxEmSt5f695Ti4/+dDk4k=;
 b=sJa9wAC+aWWcWlWUQStwNoUqj69eYfi7Hux8zGoZc8X0X6W7sZxNVZ2oG6qFap2nnfSvJrcpPh1PnhDB6lD7EzhYky/LlHz4XR7pktnqmRNTlKXwPQPf6f/MzCCaGHABa7XrwmpesOtPZRntVWpwbzymjCntLIOpTQllAm17eYEK72oaUkV1pFmB0QLJLqNJtLN3XUbC52AojsvMykKX4t6XKvrEeXjamhgUlrtS1iO37OyG5HMwKkHFi5E1yZRRtw94oyK1MUzD8nj04eGsu8cimuKlJS/P3WT3z1NObFEioc5jeDXhD2EhduAGmLE3k/DcIakdJCltYwoMiucRWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NJF1FG/icLF9MdAiHVEtbzxEmSt5f695Ti4/+dDk4k=;
 b=ymZDRE5DHwMwtNuH5uu8X35zGwsk6ybNJ56b1uUq+qR0G9zdzTMwg2lMGQ7ZqKCBrC7AFnVmTjaomSvz8uBTw3tmSMoQIrEZtsfTUP+eeoKI8o9jx+JOtjjGcLJ8LMn1ZQP9oF3JMnRlA9R1hBx+G2lzClNQ0cz4BXWh1ouDyQ8=
Received: from CH0PR03CA0386.namprd03.prod.outlook.com (2603:10b6:610:119::29)
 by PH7PR12MB8595.namprd12.prod.outlook.com (2603:10b6:510:1b5::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.24; Mon, 16 Jun
 2025 09:39:21 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::37) by CH0PR03CA0386.outlook.office365.com
 (2603:10b6:610:119::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.22 via Frontend Transport; Mon,
 16 Jun 2025 09:39:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 09:39:20 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Jun 2025 04:39:17 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, Le Ma
 <Le.Ma@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 10/10] drm/amdgpu: Convert init_mem_ranges into common helpers
Date: Mon, 16 Jun 2025 17:37:56 +0800
Message-ID: <20250616093756.16200-11-Hawking.Zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|PH7PR12MB8595:EE_
X-MS-Office365-Filtering-Correlation-Id: 77da89c8-e06c-484b-ec1c-08ddacb9ab6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0M5wN34UH5baj/WBAmWB0d5ljeYtnTnhNsjda+jyfD2O8UCdgMdyXN1ljc8B?=
 =?us-ascii?Q?DxsVHofhWTlwzexKo3oo/mQ3Om2kVmU5B0zJHMCxvM1UtBW+SHjU+ruYJx6o?=
 =?us-ascii?Q?Gb+EgFYhGGugq8ymDg5NMVPDB5SS37dqU9hF8OiWlw8ySaAuJaw0FB1gi5No?=
 =?us-ascii?Q?8tSeQE5osTCxpE6857d7ptDRZL5H2xEySA3TFMR4MVyDeWL1PiYjnVX2DsbK?=
 =?us-ascii?Q?GDsycM7SstQB/TFT1QAAg0i1JuBO+1hPNL2BMN7fZ+tW+sAPBJoEg4zsq2Uw?=
 =?us-ascii?Q?vkTQAX8IT1TWaAIGzMspk4hCd8lhG79QCVyJHxguVveYHvVGxN6580DttMjZ?=
 =?us-ascii?Q?3769Voob2s80z0gCuAYPTn470Oivf1AUK6MXgg/8l2CRm/lQ0l4M5MzaMMVu?=
 =?us-ascii?Q?wcwmUV3VHTkH/L+jIAuptNQI+SkQsxEhpex4Ml6JjwDK39vzHzDw177fo9v5?=
 =?us-ascii?Q?Y7BqUfPQqbrI37sparnMVo7lJQgICxBqpMMbLBQkZogQpI+QhYuiGg6fXKQx?=
 =?us-ascii?Q?Q06/Hcqq/WO1i5asdQAy2Sbmq+EqrzPRQk1HmeongnNU3hK1ur/J+oKBwHIZ?=
 =?us-ascii?Q?vbX766p595rrufxfAr04q8f94kTMDWkMG7Aow6aCsXtWNDoWbZ6DeQ9MVWYr?=
 =?us-ascii?Q?PS+PYw2HCAG4Mzmp7hBTYkakqqxVJWJ55Z9bwhBPDHaZP9j+3N78//GolEXp?=
 =?us-ascii?Q?2EXc7zFUDKB8EKTU9JtAqzXnoZ291up+wcHsYLuAwduc5CSIYvQXzLbBOLe3?=
 =?us-ascii?Q?T7umSHhzKOSicWz6onCx3CweD82oT1YQGxlrQO7orN1krOjIAQIQITlfsYVB?=
 =?us-ascii?Q?hbDcuRz8x0b4ccVJn5VVsNomGuKLKbONnlD5joDDvGJKTungvm5MjEGbu/GT?=
 =?us-ascii?Q?j9A6d/NQuyEnbruOA0A8yIMLb17Dqs09lhYysjoN+l7ndexZXV0SBTOVqsez?=
 =?us-ascii?Q?2FP8H4rYgiQ1wO+diF+pqVJsAyU9uElN9/lMeHX33OVb4obCxg8xr8lLKJe6?=
 =?us-ascii?Q?B3IVhHTtx2wPRWhayPdT0EMZyFqDvuvoS/4GmlrtDGi4LFlodyoWfTJseW/i?=
 =?us-ascii?Q?CjMfhMLFg7djYnoasxiqHV39sO4xVHmOi//F66376df3pI8ckimWVXZ3OKII?=
 =?us-ascii?Q?MDrGCcW2PlZyGeuZFNjhCOpy0dBidUSWAOTURNwDCVSrdmXdQbyxQ523DI8o?=
 =?us-ascii?Q?iEMTd8ec3waXPpRWlx3TC9a+Px/ZhaJgK8X5j31hqAe6tJNd0BwsGINMIKFP?=
 =?us-ascii?Q?CHC8bx4jPRcs2ta/dmDzfpygSEvC5+lRDiA0UyAGBYyc7KrQKtFGah+/r5ME?=
 =?us-ascii?Q?026ve//cr4UDrREAIpuxfZDKGqz0LMa7/UweQG2Xasks5XRwnp6EOOYZ4uxO?=
 =?us-ascii?Q?lRAIt6BozHcCY2PBEEcUEEgpZ103TA7pr/0kwIjYRtnr7vAL8/JQMPDooTO/?=
 =?us-ascii?Q?cluDh9n40ejXTEY+F2vBPrfzhseu+vZQW3oAZHYAzLHVoggJq7xV1h/i0cBk?=
 =?us-ascii?Q?6dgJnllv/m+1UtjZhqaUAz5tyiijkbu1VU0R?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 09:39:20.0660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77da89c8-e06c-484b-ec1c-08ddacb9ab6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8595
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

They can be shared across multiple products

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 185 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |   3 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 186 +-----------------------
 3 files changed, 190 insertions(+), 184 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 7e69296cf9ac..c6c69f1a5bf6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1491,3 +1491,188 @@ amdgpu_gmc_query_memory_partition(struct amdgpu_device *adev)
         else
                 return amdgpu_gmc_get_memory_partition(adev, NULL);
 }
+
+static bool amdgpu_gmc_validate_partition_info(struct amdgpu_device *adev)
+{
+	enum amdgpu_memory_partition mode;
+	u32 supp_modes;
+	bool valid;
+
+	mode = amdgpu_gmc_get_memory_partition(adev, &supp_modes);
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
+	case AMDGPU_NPS8_PARTITION_MODE:
+		valid = (adev->gmc.num_mem_partitions == 8);
+		break;
+	default:
+		valid = false;
+	}
+
+	return valid;
+}
+
+static bool amdgpu_gmc_is_node_present(int *node_ids, int num_ids, int nid)
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
+static void amdgpu_gmc_init_acpi_mem_ranges(struct amdgpu_device *adev,
+					    struct amdgpu_mem_partition_info *mem_ranges)
+{
+	struct amdgpu_numa_info numa_info;
+	int node_ids[AMDGPU_MAX_MEM_RANGES];
+	int num_ranges = 0, ret;
+	int num_xcc, xcc_id;
+	uint32_t xcc_mask;
+
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	xcc_mask = (1U << num_xcc) - 1;
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
+		if (amdgpu_gmc_is_node_present(node_ids, num_ranges,
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
+}
+
+void amdgpu_gmc_init_sw_mem_ranges(struct amdgpu_device *adev,
+				   struct amdgpu_mem_partition_info *mem_ranges)
+{
+	enum amdgpu_memory_partition mode;
+	u32 start_addr = 0, size;
+	int i, r, l;
+
+	mode = amdgpu_gmc_query_memory_partition(adev);
+
+	switch (mode) {
+	case UNKNOWN_MEMORY_PARTITION_MODE:
+		adev->gmc.num_mem_partitions = 0;
+		break;
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
+	case AMDGPU_NPS8_PARTITION_MODE:
+		adev->gmc.num_mem_partitions = 8;
+		break;
+	default:
+		adev->gmc.num_mem_partitions = 1;
+		break;
+	}
+
+	/* Use NPS range info, if populated */
+	r = amdgpu_gmc_get_nps_memranges(adev, mem_ranges,
+					 &adev->gmc.num_mem_partitions);
+	if (!r) {
+		l = 0;
+		for (i = 1; i < adev->gmc.num_mem_partitions; ++i) {
+			if (mem_ranges[i].range.lpfn >
+			    mem_ranges[i - 1].range.lpfn)
+				l = i;
+		}
+
+	} else {
+		if (!adev->gmc.num_mem_partitions) {
+			dev_warn(adev->dev,
+				 "Not able to detect NPS mode, fall back to NPS1\n");
+			adev->gmc.num_mem_partitions = 1;
+		}
+		/* Fallback to sw based calculation */
+		size = (adev->gmc.real_vram_size + SZ_16M) >> AMDGPU_GPU_PAGE_SHIFT;
+		size /= adev->gmc.num_mem_partitions;
+
+		for (i = 0; i < adev->gmc.num_mem_partitions; ++i) {
+			mem_ranges[i].range.fpfn = start_addr;
+			mem_ranges[i].size =
+				((u64)size << AMDGPU_GPU_PAGE_SHIFT);
+			mem_ranges[i].range.lpfn = start_addr + size - 1;
+			start_addr += size;
+		}
+
+		l = adev->gmc.num_mem_partitions - 1;
+	}
+
+	/* Adjust the last one */
+	mem_ranges[l].range.lpfn =
+		(adev->gmc.real_vram_size >> AMDGPU_GPU_PAGE_SHIFT) - 1;
+	mem_ranges[l].size =
+		adev->gmc.real_vram_size -
+		((u64)mem_ranges[l].range.fpfn << AMDGPU_GPU_PAGE_SHIFT);
+}
+
+int amdgpu_gmc_init_mem_ranges(struct amdgpu_device *adev)
+{
+	bool valid;
+
+	adev->gmc.mem_partitions = kcalloc(AMDGPU_MAX_MEM_RANGES,
+					   sizeof(struct amdgpu_mem_partition_info),
+					   GFP_KERNEL);
+	if (!adev->gmc.mem_partitions)
+		return -ENOMEM;
+
+	if (adev->gmc.is_app_apu)
+		amdgpu_gmc_init_acpi_mem_ranges(adev, adev->gmc.mem_partitions);
+	else
+		amdgpu_gmc_init_sw_mem_ranges(adev, adev->gmc.mem_partitions);
+
+	if (amdgpu_sriov_vf(adev))
+		valid = true;
+	else
+		valid = amdgpu_gmc_validate_partition_info(adev);
+	if (!valid) {
+		/* TODO: handle invalid case */
+		dev_warn(adev->dev,
+			 "Mem ranges not matching with hardware config\n");
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 95a68e0eb96e..397c6ccdb903 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -464,4 +464,7 @@ enum amdgpu_memory_partition
 amdgpu_gmc_get_memory_partition(struct amdgpu_device *adev, u32 *supp_modes);
 enum amdgpu_memory_partition
 amdgpu_gmc_query_memory_partition(struct amdgpu_device *adev);
+int amdgpu_gmc_init_mem_ranges(struct amdgpu_device *adev);
+void amdgpu_gmc_init_sw_mem_ranges(struct amdgpu_device *adev,
+				   struct amdgpu_mem_partition_info *mem_ranges);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index fa897ced71e6..380b7b81ac1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1838,188 +1838,6 @@ static void gmc_v9_0_save_registers(struct amdgpu_device *adev)
 		adev->gmc.sdpif_register = RREG32_SOC15(DCE, 0, mmDCHUBBUB_SDPIF_MMIO_CNTRL_0);
 }
 
-static bool gmc_v9_0_validate_partition_info(struct amdgpu_device *adev)
-{
-	enum amdgpu_memory_partition mode;
-	u32 supp_modes;
-	bool valid;
-
-	mode = amdgpu_gmc_get_memory_partition(adev, &supp_modes);
-
-	/* Mode detected by hardware not present in supported modes */
-	if ((mode != UNKNOWN_MEMORY_PARTITION_MODE) &&
-	    !(BIT(mode - 1) & supp_modes))
-		return false;
-
-	switch (mode) {
-	case UNKNOWN_MEMORY_PARTITION_MODE:
-	case AMDGPU_NPS1_PARTITION_MODE:
-		valid = (adev->gmc.num_mem_partitions == 1);
-		break;
-	case AMDGPU_NPS2_PARTITION_MODE:
-		valid = (adev->gmc.num_mem_partitions == 2);
-		break;
-	case AMDGPU_NPS4_PARTITION_MODE:
-		valid = (adev->gmc.num_mem_partitions == 3 ||
-			 adev->gmc.num_mem_partitions == 4);
-		break;
-	default:
-		valid = false;
-	}
-
-	return valid;
-}
-
-static bool gmc_v9_0_is_node_present(int *node_ids, int num_ids, int nid)
-{
-	int i;
-
-	/* Check if node with id 'nid' is present in 'node_ids' array */
-	for (i = 0; i < num_ids; ++i)
-		if (node_ids[i] == nid)
-			return true;
-
-	return false;
-}
-
-static void
-gmc_v9_0_init_acpi_mem_ranges(struct amdgpu_device *adev,
-			      struct amdgpu_mem_partition_info *mem_ranges)
-{
-	struct amdgpu_numa_info numa_info;
-	int node_ids[AMDGPU_MAX_MEM_RANGES];
-	int num_ranges = 0, ret;
-	int num_xcc, xcc_id;
-	uint32_t xcc_mask;
-
-	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
-	xcc_mask = (1U << num_xcc) - 1;
-
-	for_each_inst(xcc_id, xcc_mask)	{
-		ret = amdgpu_acpi_get_mem_info(adev, xcc_id, &numa_info);
-		if (ret)
-			continue;
-
-		if (numa_info.nid == NUMA_NO_NODE) {
-			mem_ranges[0].size = numa_info.size;
-			mem_ranges[0].numa.node = numa_info.nid;
-			num_ranges = 1;
-			break;
-		}
-
-		if (gmc_v9_0_is_node_present(node_ids, num_ranges,
-					     numa_info.nid))
-			continue;
-
-		node_ids[num_ranges] = numa_info.nid;
-		mem_ranges[num_ranges].numa.node = numa_info.nid;
-		mem_ranges[num_ranges].size = numa_info.size;
-		++num_ranges;
-	}
-
-	adev->gmc.num_mem_partitions = num_ranges;
-}
-
-static void
-gmc_v9_0_init_sw_mem_ranges(struct amdgpu_device *adev,
-			    struct amdgpu_mem_partition_info *mem_ranges)
-{
-	enum amdgpu_memory_partition mode;
-	u32 start_addr = 0, size;
-	int i, r, l;
-
-	mode = amdgpu_gmc_query_memory_partition(adev);
-
-	switch (mode) {
-	case UNKNOWN_MEMORY_PARTITION_MODE:
-		adev->gmc.num_mem_partitions = 0;
-		break;
-	case AMDGPU_NPS1_PARTITION_MODE:
-		adev->gmc.num_mem_partitions = 1;
-		break;
-	case AMDGPU_NPS2_PARTITION_MODE:
-		adev->gmc.num_mem_partitions = 2;
-		break;
-	case AMDGPU_NPS4_PARTITION_MODE:
-		if (adev->flags & AMD_IS_APU)
-			adev->gmc.num_mem_partitions = 3;
-		else
-			adev->gmc.num_mem_partitions = 4;
-		break;
-	default:
-		adev->gmc.num_mem_partitions = 1;
-		break;
-	}
-
-	/* Use NPS range info, if populated */
-	r = amdgpu_gmc_get_nps_memranges(adev, mem_ranges,
-					 &adev->gmc.num_mem_partitions);
-	if (!r) {
-		l = 0;
-		for (i = 1; i < adev->gmc.num_mem_partitions; ++i) {
-			if (mem_ranges[i].range.lpfn >
-			    mem_ranges[i - 1].range.lpfn)
-				l = i;
-		}
-
-	} else {
-		if (!adev->gmc.num_mem_partitions) {
-			dev_err(adev->dev,
-				"Not able to detect NPS mode, fall back to NPS1");
-			adev->gmc.num_mem_partitions = 1;
-		}
-		/* Fallback to sw based calculation */
-		size = (adev->gmc.real_vram_size + SZ_16M) >> AMDGPU_GPU_PAGE_SHIFT;
-		size /= adev->gmc.num_mem_partitions;
-
-		for (i = 0; i < adev->gmc.num_mem_partitions; ++i) {
-			mem_ranges[i].range.fpfn = start_addr;
-			mem_ranges[i].size =
-				((u64)size << AMDGPU_GPU_PAGE_SHIFT);
-			mem_ranges[i].range.lpfn = start_addr + size - 1;
-			start_addr += size;
-		}
-
-		l = adev->gmc.num_mem_partitions - 1;
-	}
-
-	/* Adjust the last one */
-	mem_ranges[l].range.lpfn =
-		(adev->gmc.real_vram_size >> AMDGPU_GPU_PAGE_SHIFT) - 1;
-	mem_ranges[l].size =
-		adev->gmc.real_vram_size -
-		((u64)mem_ranges[l].range.fpfn << AMDGPU_GPU_PAGE_SHIFT);
-}
-
-static int gmc_v9_0_init_mem_ranges(struct amdgpu_device *adev)
-{
-	bool valid;
-
-	adev->gmc.mem_partitions = kcalloc(AMDGPU_MAX_MEM_RANGES,
-					   sizeof(struct amdgpu_mem_partition_info),
-					   GFP_KERNEL);
-	if (!adev->gmc.mem_partitions)
-		return -ENOMEM;
-
-	/* TODO : Get the range from PSP/Discovery for dGPU */
-	if (adev->gmc.is_app_apu)
-		gmc_v9_0_init_acpi_mem_ranges(adev, adev->gmc.mem_partitions);
-	else
-		gmc_v9_0_init_sw_mem_ranges(adev, adev->gmc.mem_partitions);
-
-	if (amdgpu_sriov_vf(adev))
-		valid = true;
-	else
-		valid = gmc_v9_0_validate_partition_info(adev);
-	if (!valid) {
-		/* TODO: handle invalid case */
-		dev_WARN(adev->dev,
-			 "Mem ranges not matching with hardware config");
-	}
-
-	return 0;
-}
-
 static void gmc_v9_4_3_init_vram_info(struct amdgpu_device *adev)
 {
 	adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
@@ -2192,7 +2010,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	amdgpu_gmc_get_vbios_allocations(adev);
 
 	if (amdgpu_is_multi_aid(adev)) {
-		r = gmc_v9_0_init_mem_ranges(adev);
+		r = amdgpu_gmc_init_mem_ranges(adev);
 		if (r)
 			return r;
 	}
@@ -2474,7 +2292,7 @@ static int gmc_v9_0_resume(struct amdgpu_ip_block *ip_block)
 	 * information again.
 	 */
 	if (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS) {
-		gmc_v9_0_init_sw_mem_ranges(adev, adev->gmc.mem_partitions);
+		amdgpu_gmc_init_sw_mem_ranges(adev, adev->gmc.mem_partitions);
 		adev->gmc.reset_flags &= ~AMDGPU_GMC_INIT_RESET_NPS;
 	}
 
-- 
2.17.1

