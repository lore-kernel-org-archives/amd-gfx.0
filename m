Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C995C3DA5D
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 12:36:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9379E10E396;
	Mon, 15 Jul 2024 12:36:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5KVVeY/B";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31E1910E37C
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 12:36:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7lf4KUJsljrYQNZNx1kpv4as02dL0jPpxSb/0DALzpaf2hyQZqLwHLUkf0GGdoC2SQ4HyhFBmkrEe+qbEy8VrRwWUQO884oKr94vSuL04R2PN63GEXA+cvijSBUAlMGtdlSQNy5gvRmaZzgbL7jj3G3KXZ/8czrToTtq0K5R8rPPXTN0KWYgsf9QO63iD5yk9Udcmgb0XhBt/p4E780vsQIiydSf6GOdYfei3YG0fv/Yx5kvqlY09mhAjZgxwqJyr96Ak/7rVMuxE0aN41UjqekPFpjzT1e220g8kVExdYPFCK+SiDgYuGeIphKnE/yJjCyJ8d4ehIhBvAg5aYk8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtbOLJdqF5HwuS25BvFswyt3JtP0EVsPYpeNJCsGYcU=;
 b=k1xbCHwPuJjxD21UWJ+LWEw7AyqHcn9HRiMI2W294ODWdGbBP2IBEZ4kfPkFhGyjllt5QiSCfdjzp+frYCosEIQ0dxqGteFD06xZrqqcByEY2+FB6I8tZFgNn3XuWwxYd0OAW4kAmayDNNtzCz+eO7Y0wa9TfQDwlYIueSE1NtGjpdHdyUVKsZDk+RyXwl+EB5koYQ+0zjjTbn1I+6iF7LpDSPoPRTV1Vjb5dzVJU+7OcRCStAL3hXQClrEgVn3ayPZK8GnrIkw+QfWC5u80qLAuid+NXlgiq1Hn03NDQ8aYDnnWkYArprnlVWLCVTeUeYXnQSAJt9/ZlvF/yKABUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtbOLJdqF5HwuS25BvFswyt3JtP0EVsPYpeNJCsGYcU=;
 b=5KVVeY/BcrcUoj7XdJ5YoYUf2nToi+E29npazujbd4Ma2gI9aXYdIuzA+rTDBkfs9aUX3XobkbXqGTb7ssloPXFqWmN8Enpqln4QUimCGpWGg85YCm+9EXz2M8Q3PXOeZVEnOlzQ94S5m1t8VaI4SSB9ypWYjUBx3AgCn5DTRC8=
Received: from BL1PR13CA0326.namprd13.prod.outlook.com (2603:10b6:208:2c1::31)
 by CY5PR12MB6036.namprd12.prod.outlook.com (2603:10b6:930:2c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 12:36:32 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::29) by BL1PR13CA0326.outlook.office365.com
 (2603:10b6:208:2c1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.13 via Frontend
 Transport; Mon, 15 Jul 2024 12:36:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 12:36:31 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 07:36:29 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>,
 <christian.koenig@amd.com>, Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH 8/9] drm/amdkfd: Store queue cwsr area size to node properties
Date: Mon, 15 Jul 2024 08:35:01 -0400
Message-ID: <20240715123502.7013-9-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240715123502.7013-1-Philip.Yang@amd.com>
References: <20240715123502.7013-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|CY5PR12MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: d9d34924-7c66-49ac-1de5-08dca4cac1ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/svtzf9g3OtEPDJ6Kvc3YgUnWU//G9Xrzzec9EkLPh1FSOb8I90QWdxVeqHK?=
 =?us-ascii?Q?tAiospADgdymepJBaxeWpboYQyoASUoiHvmpg1WzMFuV8NUHGO3q1yXC4p4G?=
 =?us-ascii?Q?Xo+GJQGoFN93QvPBdn/UM1ATckzB2bnffMAunC5GlMr/I1Rb+339q2l3JRO7?=
 =?us-ascii?Q?1vg7BT4NwHB08JvbnBgjNQ8iiAQkFnzh/f6A3GCZfLknTx1rZTuHWlEH4XY+?=
 =?us-ascii?Q?sTcqgfdatAmNRYPkLBBTGe/YOtUljZwYOy79hmQTgND5oMMcHztFTMQPElXB?=
 =?us-ascii?Q?Ay7wD0SuQ5CvY1/XjeDIehyQAJXhDsv8E9ZwSpJmhT5RyDPeDac+XYzm3ed3?=
 =?us-ascii?Q?YYRwaE52ZFv9UvemnUML/fnud/0Gw2ta2PDZRwbWl++D2SlEzb8adj71xLKH?=
 =?us-ascii?Q?7WSS08UKsBkMOuoDge67AiQHHG/nrhR3wlNs36RmuFGcgp4q14frYXnuhvVb?=
 =?us-ascii?Q?IpitHD3WVoSjCCd58S049H+Kg+mnbqKsNY2bDs1TU1gP4cWO4q8aogpN4HA1?=
 =?us-ascii?Q?R7e1Bx9tasFVMG7tR2717ahZO71Zdj1yTRoydk3utQU/pF/s98Mq/+r4TVQ0?=
 =?us-ascii?Q?v6VYBe4u9lQvSi2i99ReCnO0V7CBb2YvRyHUs3n6/aacUEy6cObU1mwzixzY?=
 =?us-ascii?Q?WuJzMB4ZQXt0QrJti+O5XPn71LuKghYaHrhUJq99Mzigj+CnCA94NxUCUvLJ?=
 =?us-ascii?Q?i1zQQw9L0QvsbJqIo0QeqLMqU75glLXl6TkDvD6WqAe2wRh4PDklY8YhOQcv?=
 =?us-ascii?Q?xfExujYJAtS1c33vlKLVKjKRC+OKSs7T7/Biax9HtgWzlRG8KMKf0tUc4521?=
 =?us-ascii?Q?NwnOv0TOSfFR8dTJAM2aztH5ne7KwPp26FWFIAmwRVdjdZj2WWzKxYzv1AbA?=
 =?us-ascii?Q?qRy0zZn8b8XUTeA2S174vkhSdJw7UmMPlPDUspLNAfqNhTQTTEgIDOQrRl+Q?=
 =?us-ascii?Q?cvHHYwrNz+oKPNell0z9FCVGa26jUyD8SuGOjVaRIBODqwEH2Six/m4ltLv0?=
 =?us-ascii?Q?vtTaZMqgrMYuK5H3h1Yo3jhYo9NE+KTp4ej0OoVA/uMTGVEsrxySLH8MlLha?=
 =?us-ascii?Q?onJpRFsdoRVurX6CYDZyyrmzsbuRykLneNG2QSKMT4o119BOwsHlYxiUtBUo?=
 =?us-ascii?Q?EAx2rHEHzSxZ1A00Whevj/jMTEF3yxHY8YrQI5Vs6bv4bfqI/HaBc671lovj?=
 =?us-ascii?Q?ETOdwDFelj+cOyvk0juCcKVHq4mIP0ukgk0AopDqxNzG1Ov1pSsqdEjMd60/?=
 =?us-ascii?Q?hPZHlQUwdOtyk7XDVvWwELmnr/IFkB92EgLv4hpEZal9Y5Q/ObRm8SNxOAlB?=
 =?us-ascii?Q?RChfBIjn1tcVbass35bQczR2vGglsvskSdA4RsVsYSxSFLOA5c1zcV2doNFa?=
 =?us-ascii?Q?tQOrDKl4tFwRSA5us7eaJ39JXdrykPJ8RScneO/Op8FMkYJdn7EZX0AasHu7?=
 =?us-ascii?Q?6PZJUW4BD1dPWmdcvzT40+O2FGnPDGBh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 12:36:31.8124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d34924-7c66-49ac-1de5-08dca4cac1ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6036
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
index 95fbdb12beb1..58f5bc021ea9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1294,6 +1294,7 @@ int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_
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

