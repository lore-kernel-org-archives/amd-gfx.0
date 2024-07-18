Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00821C3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 21:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6FBA10EB27;
	Thu, 18 Jul 2024 21:06:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s5UGAxOm";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE5D710EB25
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 21:06:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJy3nyKyml/1RXdbQDgNs8EIervsp6x7lIqcTFadaqPc+Li0+BUKx6iv83pXwWnwd5x/enO8lY4JDtUym5oY95alZ3SUq4ek6orh1Xrysi7koe7KwxCHQALYs3KcdzAKzPe3E7KFIkMlZ17JNSCVilFeL8W2SFWTeuD3Iy/XbuPmPVVZ75CcgT+MudHnzyzCQnz6Q2cSh+xcjj7/Thymscg18CMRgz4K07udUwgAaxvevfOqdA0LzFRd3VfnZhROGmnwzMr4s9y6ekhxmtwcoGp5LuwR7erE8wthdN0pEprOt64NF41/gXEi5GAE35JwJkzK/d5gcNF4hwcMf9A0nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDyh0khkcGY7JIJ9tdH6A1gygLuH2ryM1TQxb9dAhBM=;
 b=iElqRM7FfRbC7yndrcZNKbqlZNnFKazJcBDkkKD9HBxTEqrSrQdPYXAcDQHzdPuikivI9tyBmN7y8Bb6VvaKSAPCvggLtpsTZlMNuiPa4KNJC788jn4ChDiXUwO0U1wI3jWoipWsmTMW4NE2ftSgO49/gY4kNLhePhgVURL3WB+EwkCEE8FRCJc9z0z8s4e1JS0TMKHsw6wyVyjSmjZYrR9inIKKjvkSpgFPvav7m+PkwB/8plxbVYQSGeFIs8DmRjyqmA/kA7s7z7z/zUAz8nl/WrZPFvs+yAHd3Lvh++uNAnd++PhuJuIfsp7eo/wevEgFCAYc6V2/7FT23rijqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDyh0khkcGY7JIJ9tdH6A1gygLuH2ryM1TQxb9dAhBM=;
 b=s5UGAxOmYFOEsx2M2egaUoiBA16e5rc6lfOxps4yIS90FDkIxp8LkHHSSm2Bjzu9PE2ILWVqYI56qqOQbIDixyq9VprRWxxiY0kfsS4FhT/y6OSJsBwJhyEkO4L2OVXk+OpGx/QZF/LXEgMQEk+6EQDK9X6DrUASMbin4awv134=
Received: from SA9P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::8) by
 SJ0PR12MB6878.namprd12.prod.outlook.com (2603:10b6:a03:483::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.35; Thu, 18 Jul
 2024 21:06:17 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::e2) by SA9P223CA0003.outlook.office365.com
 (2603:10b6:806:26::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Thu, 18 Jul 2024 21:06:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 21:06:17 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 16:06:15 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>,
 <christian.koenig@amd.com>, Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH v2 8/9] drm/amdkfd: Store queue cwsr area size to node
 properties
Date: Thu, 18 Jul 2024 17:05:57 -0400
Message-ID: <20240718210558.26340-9-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240718210558.26340-1-Philip.Yang@amd.com>
References: <20240718210558.26340-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|SJ0PR12MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: 7917a580-25eb-4143-e982-08dca76d7751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LWyxX3tUDc9fU9EMDYuvcKQjfgvs5NJJ1A+cUkEOJAGcs2x9FDqhGcYFIPcX?=
 =?us-ascii?Q?Yrar+vZf4SLdRDKUhlwuJhGKuHUrIyZv8sbzCDNBoZwaEehnqa5zpjmp/Q80?=
 =?us-ascii?Q?Q+HCPV1kcRRz/VvfoPGriR9ahwJ88CTxQr7EZzl4GDSRjgnVzWwWPqQpbToN?=
 =?us-ascii?Q?7odEUiJoob6LmIJVsRLMPbo8GQQJrjG0yoMLXedcyf3VGI5mgRP7DL8qspO1?=
 =?us-ascii?Q?3NPELmF28aUUYjGtEq5z6vzSt+hDAwY+F3wLbIIQYnqzvvZt4yhOixyiFT1c?=
 =?us-ascii?Q?ii1ig+1ONNDa8KVtlywxumvoAW08KjB6p5Un+D3gQawiFJvKu7YhHBVI7bEr?=
 =?us-ascii?Q?zeLf1sBZfwrhkLk/HRBcUGx/puxSjy1oLpYsyYKhWJDXDSIjBcJWeH8yH7Bb?=
 =?us-ascii?Q?ExZ/nq3oLvEPj5YRbkFQsyM5zlYja9kTEKNRh+watrs83AZcCbUrIvMzEqVI?=
 =?us-ascii?Q?S7Wie7ab3NkyOzxynQuupKt2DG2ZXqw0002awDdzotd9Z64jvtO3wPN7hNwO?=
 =?us-ascii?Q?3GhEft8E2pvpiZ8dGzh8wEIWWmem0FJsOV8jTHP41vwVUd30dgRsb1sjjebI?=
 =?us-ascii?Q?m03ThbflYv6/b3QojhYKDjd2XIUxop7OGZNU9Votn0j01SrzU92mGnE1oNNO?=
 =?us-ascii?Q?hdCPOHUPIt4JAXnP0PbUyE2TGIGjJPN8bCFTszALM/oqMQtpKyPM5q8LYjy8?=
 =?us-ascii?Q?Pzb1Q2jfa9WH313ohbT2MhJ9102+1MiaYdSH5MD/76YR4aellrm1D5oB38GT?=
 =?us-ascii?Q?cYN0IULzieWuzIxfhiC/ADp1QCmKsZOrpyb/pHCTA1eof23uz3vcnycid/h1?=
 =?us-ascii?Q?kexBZtTjzPAUEfkNLTmfh2KSG4BYglEpaq/ZnuT1tbENY80Tl/PZOHlGZ/Cf?=
 =?us-ascii?Q?7rT5j1fOQKc2XnUVNN0K9ohm4i07xarSAf+Thmk7SNobV+oTk50Nv1Or5BvP?=
 =?us-ascii?Q?YDFrUWZyKhUVNIswTpuiUSBmQ/gG+GohrkXaXKgtqfLdnCfftk6qQOt0Z2SY?=
 =?us-ascii?Q?WlTfQGK9cdioDscYYxeqdvzRGyzRvmLTpJpTiLsbut58hOHycccT37xIC5r8?=
 =?us-ascii?Q?YeLez5VA4fv7Sptj0LET+SqUxwT44qYOxEZ9F7dXmUgkPm2OmdMXN92kW/GP?=
 =?us-ascii?Q?JynhxDsXWH9Os5CscbV/HiR12Urvo8l4ApC4Y85TYXvKCgT/N/KdaR83/19s?=
 =?us-ascii?Q?3sNTAeYomUgql/9rWQ+oi3bHD+2aFGUZ4IhZYPy8WktVANWx7t6zBXTHd/+/?=
 =?us-ascii?Q?j/qHZF+3TGoIxE12FIol3G9OXaZfMXZvL1qiRp0xjpmq+Ct30srWiw64782a?=
 =?us-ascii?Q?SN+v6UnWlBNrTbAGDQTFa3oU6QjCcpJgzVLviFviG3AhdcIs5yZ2MLqZ7jrN?=
 =?us-ascii?Q?UBier8/qe1yFw+fAT+QkqKodPm6S3cmtaPKT2tzkyJC7lWiqmkp8UgTtP/TC?=
 =?us-ascii?Q?GN4N5LHELKOzTL9UxvXT04uLxxQ0ceGn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 21:06:17.3804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7917a580-25eb-4143-e982-08dca76d7751
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6878
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

Use the queue eop buffer size, cwsr area size, ctl stack size
calculation from Thunk, store the value to KFD node properties.

Those will be used to validate queue eop buffer size, cwsr area size,
ctl stack size when creating KFD user compute queue.

Those will be exposed to user space via sysfs KFD node properties, to
remove the duplicate calculation code from Thunk.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c    | 75 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h |  4 ++
 4 files changed, 82 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index c31589043d5b..b5cae48dff66 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1295,6 +1295,7 @@ int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_
 void kfd_queue_buffer_put(struct amdgpu_vm *vm, struct amdgpu_bo **bo);
 int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
 int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
+void kfd_queue_ctx_save_restore_size(struct kfd_topology_device *dev);
 
 struct mqd_manager *mqd_manager_init_cik(enum KFD_MQD_TYPE type,
 		struct kfd_node *dev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 67242ce051b5..adcda9730c9f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -24,6 +24,7 @@
 
 #include <linux/slab.h>
 #include "kfd_priv.h"
+#include "kfd_topology.h"
 #include "kfd_svm.h"
 
 void print_queue_properties(struct queue_properties *q)
@@ -305,3 +306,77 @@ int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_prope
 				 properties->ctx_save_restore_area_size);
 	return 0;
 }
+
+#define SGPR_SIZE_PER_CU	0x4000
+#define LDS_SIZE_PER_CU		0x10000
+#define HWREG_SIZE_PER_CU	0x1000
+#define DEBUGGER_BYTES_ALIGN	64
+#define DEBUGGER_BYTES_PER_WAVE	32
+
+static u32 kfd_get_vgpr_size_per_cu(u32 gfxv)
+{
+	u32 vgpr_size = 0x40000;
+
+	if ((gfxv / 100 * 100) == 90400 ||	/* GFX_VERSION_AQUA_VANJARAM */
+	    gfxv == 90010 ||			/* GFX_VERSION_ALDEBARAN */
+	    gfxv == 90008)			/* GFX_VERSION_ARCTURUS */
+		vgpr_size = 0x80000;
+	else if (gfxv == 110000 ||		/* GFX_VERSION_PLUM_BONITO */
+		 gfxv == 110001 ||		/* GFX_VERSION_WHEAT_NAS */
+		 gfxv == 120000 ||		/* GFX_VERSION_GFX1200 */
+		 gfxv == 120001)		/* GFX_VERSION_GFX1201 */
+		vgpr_size = 0x60000;
+
+	return vgpr_size;
+}
+
+#define WG_CONTEXT_DATA_SIZE_PER_CU(gfxv)	\
+	(kfd_get_vgpr_size_per_cu(gfxv) + SGPR_SIZE_PER_CU +\
+	 LDS_SIZE_PER_CU + HWREG_SIZE_PER_CU)
+
+#define CNTL_STACK_BYTES_PER_WAVE(gfxv)	\
+	((gfxv) >= 100100 ? 12 : 8)	/* GFX_VERSION_NAVI10*/
+
+#define SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER 40
+
+void kfd_queue_ctx_save_restore_size(struct kfd_topology_device *dev)
+{
+	struct kfd_node_properties *props = &dev->node_props;
+	u32 gfxv = props->gfx_target_version;
+	u32 ctl_stack_size;
+	u32 wg_data_size;
+	u32 wave_num;
+	u32 cu_num;
+
+	if (gfxv < 80001)	/* GFX_VERSION_CARRIZO */
+		return;
+
+	cu_num = props->simd_count / props->simd_per_cu / NUM_XCC(dev->gpu->xcc_mask);
+	wave_num = (gfxv < 100100) ?	/* GFX_VERSION_NAVI10 */
+		    min(cu_num * 40, props->array_count / props->simd_arrays_per_engine * 512)
+		    : cu_num * 32;
+
+	wg_data_size = ALIGN(cu_num * WG_CONTEXT_DATA_SIZE_PER_CU(gfxv), PAGE_SIZE);
+	ctl_stack_size = wave_num * CNTL_STACK_BYTES_PER_WAVE(gfxv) + 8;
+	ctl_stack_size = ALIGN(SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER + ctl_stack_size,
+			       PAGE_SIZE);
+
+	if ((gfxv / 10000 * 10000) == 100000) {
+		/* HW design limits control stack size to 0x7000.
+		 * This is insufficient for theoretical PM4 cases
+		 * but sufficient for AQL, limited by SPI events.
+		 */
+		ctl_stack_size = min(ctl_stack_size, 0x7000);
+	}
+
+	props->ctl_stack_size = ctl_stack_size;
+	props->debug_memory_size = ALIGN(wave_num * DEBUGGER_BYTES_PER_WAVE, DEBUGGER_BYTES_ALIGN);
+	props->cwsr_size = ctl_stack_size + wg_data_size;
+
+	if (gfxv == 80002)	/* GFX_VERSION_TONGA */
+		props->eop_buffer_size = 0x8000;
+	else if ((gfxv / 100 * 100) == 90400)	/* GFX_VERSION_AQUA_VANJARAM */
+		props->eop_buffer_size = 4096;
+	else if (gfxv >= 80000)
+		props->eop_buffer_size = 4096;
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 6f89b06f89d3..a9b3eda65a2c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2120,6 +2120,8 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 		dev->gpu->adev->gmc.xgmi.connected_to_cpu)
 		dev->node_props.capability |= HSA_CAP_FLAGS_COHERENTHOSTACCESS;
 
+	kfd_queue_ctx_save_restore_size(dev);
+
 	kfd_debug_print_topology();
 
 	kfd_notify_gpu_change(gpu_id, 1);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index 2d1c9d771bef..43ba0d32e5bd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -74,6 +74,10 @@ struct kfd_node_properties {
 	uint32_t num_sdma_xgmi_engines;
 	uint32_t num_sdma_queues_per_engine;
 	uint32_t num_cp_queues;
+	uint32_t cwsr_size;
+	uint32_t ctl_stack_size;
+	uint32_t eop_buffer_size;
+	uint32_t debug_memory_size;
 	char name[KFD_TOPOLOGY_PUBLIC_NAME_SIZE];
 };
 
-- 
2.43.2

