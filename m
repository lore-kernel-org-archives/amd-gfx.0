Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5710CD4F26
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 19:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CE5110E0FD;
	Fri, 19 Jun 2026 19:00:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qIVaK//S";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012013.outbound.protection.outlook.com [52.101.53.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5680D10E0FD
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 19:00:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkhNJi9RprPo1dEPsJlQDlreIX3fwVxb6BBr6fmlS0CwjEIvUyJy5VlmcTnVcLvIbFFSwU+JTW8oKmhx4yI3QfA90os53D1ur0KM8hb/pS/wYvPDD32BrJ90tawuc92YkzC9pinQH4fhkNxN0OqbwYeyurFuYPy+4aZ0dlzLaRcRLQpeQvLLqL21HZFQ2qksfLLZapJA6GCP5Rl8NFrb/wSfxE4exkI8SlMFE/kd4FHoQ4XkIOxNORGIPl0TQ5U2QI4+4mSk8r5Lt6Cu/Vzlcd/bIfWoxGc+f3zvv75xrReQwEDYJTywBuc4jU0EnEZmqhRgMdseAZuyTCdWyKxgeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8810RYZlUlAv0LrsUjOrn9BISaL7e7072L71G4BA8OY=;
 b=JfvHgo8GzXr1lXVpgT3MkC1GbrdIAtGSdab+pA5amnbiUfztO6NYUjIHfSGby1JW0L22cc1jyK8488cYQfXRtYW9EzKD4ae9NalsUOJvOJpkaTpp9hHbWXvuFbLHzEJAKLxJdgF4apbnqe0nh433QpZKnG5OJrQrl9hp8nUk8/Uluv+B3yMF5FaRgcOD5SCoyTb4vRpWsg1jwCMcp9ZD+KvOYp1jCOOP6G/X0zG/kUCan55GYzo4+iMok21cZRT0YFrSuveLlQye9uH+i+oJy5KxkHHMyyJom8AIJ8cofxtXSerneT60p5litZ8zfzP9ilJpiJtALRE2yYAkckxkJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8810RYZlUlAv0LrsUjOrn9BISaL7e7072L71G4BA8OY=;
 b=qIVaK//Sg7NVeEb59+MQY4qXYGJkHhZYCRs2JKcWwyFeCWPR/RjlMBtEIgNREsO58JQS5MHC4jsoj1q53OqCPGjWIbpFBBcGIiDzhbc77FyMNBdCNrH0MWjG642PvXNs1qwKY1PcbTzv4rdbJ0yKUI5H+46U0WfsEnbmz+UEAIg=
Received: from MN2PR03CA0016.namprd03.prod.outlook.com (2603:10b6:208:23a::21)
 by CH3PR12MB7595.namprd12.prod.outlook.com (2603:10b6:610:14c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 19:00:00 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::3d) by MN2PR03CA0016.outlook.office365.com
 (2603:10b6:208:23a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Fri,
 19 Jun 2026 19:00:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 19:00:00 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 19 Jun 2026 13:59:59 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH] drm/amdkfd: clamp v9 CRIU control stack checkpoint copy to BO
 size
Date: Fri, 19 Jun 2026 14:59:47 -0400
Message-ID: <20260619185947.2667338-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|CH3PR12MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cdaead9-38c7-4680-62f6-08dece34f664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: QOFGrOggv6Ra2ca0/E+LUDCGKJ6hyMYwoIIcnhbb2WY3cfc5WkA6ZzOSL3UOmDaRuyAF6hwQ62FzHbvBsS1tmIXGsQ12/jbcuZD+oDg7Yw/m7H4PD6HarZLFuF0/GzT/XJzgnlNjtFDErc8gCGa0qxr/vqwyb1CpnMpuvHEYbn+Hdct5i5MZUrSyOC+pUtezJGVvweeea9J5mDb+bx5WI+9vHg9EQ+qa6wSqzdDkaNA7K4KK/VIU0lCXBNtMU6dl4eUbBF1/OSt3dBlA8gPQxx/isT05ePBXqXsqUWqkvHaSHArs+SsiJaBGaZT5xP3R3lzGhkmMNJUNDHZe6W9rJT/CFgZDusMt6/ALuEeLA6esPA2QQdQTIQa50X9jSy8VKau4g0sejEci4wQAQcKuw5AlgAVVTfo0+Vhma9q/N5YJ7NS0HQZbFvbQ/0uImoKIBMmBj1rfaaaGDYgA0UrFmPxDhAhU5VmhEE9cDGY9cwJ12lfu9kgzEbLbaKWVIT0m1e8+VDSfPF21fvkUeqqJjodcY6LWDZFc+aZ+G7fd6424aqCTt9C3+V6Xww20OMPgWLkvIO7E6elpApsGi3InMgxvkAyuQ7eQ78sHhDtHgvIJwPB9olczsTshlMSPlQ8/kbrzKWJOzLbo2/ttxHKXVfsByesVigXGgD6oThYiV90I3hURsqL82CXYBftb3/F4IuHFcwaw+I2jP131Bph0bQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZpUTaBkL1xTZCqiLYetAlb0VB+rHysJnl2XAev1RzAlWCrlWM7F26id56mtDey75bni7oqrpyx7xnrs+/sekPD6aCPZzoMYXP3XJ3tEWE4KfWkxLBMhXNvYMqES3OhgwlBpBwmnNlo9OPO3Wu+rx+XcturT8P6MWur9M0C91MdmB10pADLM4HzDI5bqv8Pv1hf23S9GjzkEkUXi9lG8LJyLIZnswtNeYXan0C+ON+eYBdr+q1WOcVmnD6SiRALuMY8RGe3FNca73yD3YabddmiCy4Md3txLiyQOoRRth4fC+7UhswHQTSF9VtH3b58Ukj/a99gY7qjIfkPpBJ4AzkPByEmKUuE4ErA+pih34ULCeOyPS0qacVb6zaPgRNGQRWFMQpaF80YoaKTe/xflBYb5xetAZXI2csEVtgsW3jN914KgndydcL+i958FrghJU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 19:00:00.0145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cdaead9-38c7-4680-62f6-08dece34f664
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7595
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

CRIU checkpoint copies the MQD control stack using cp_hqd_cntl_stack_size
from hardware without bounding it to the allocated BO region. If the HW
field is larger than the queue's control stack allocation, memcpy reads
past the BO into adjacent GTT memory and can leak kernel data to userspace.

Store the page-aligned control stack BO size in mqd_manager and clamp
checkpoint copies and reported checkpoint sizes to
min(cp_hqd_cntl_stack_size, mm->ctl_stack_size). Apply the same bound
for multi-XCC v9.4.3 checkpoint layout.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |  1 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 25 ++++++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
index 140ee1fc5d81..59eff3389d39 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -127,6 +127,7 @@ struct mqd_manager {
 	struct mutex	mqd_mutex;
 	struct kfd_node	*dev;
 	uint32_t mqd_size;
+	uint32_t ctl_stack_size;
 };
 
 struct mqd_user_context_save_area_header {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index ce379ab17916..415e9d8130cf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -27,6 +27,7 @@
 #include <linux/uaccess.h>
 #include "kfd_priv.h"
 #include "kfd_mqd_manager.h"
+#include "kfd_topology.h"
 #include "v9_structs.h"
 #include "gc/gc_9_0_offset.h"
 #include "gc/gc_9_0_sh_mask.h"
@@ -397,8 +398,11 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 static int get_checkpoint_info(struct mqd_manager *mm, void *mqd, u32 *ctl_stack_size)
 {
 	struct v9_mqd *m = get_mqd(mqd);
+	u32 per_xcc_size;
 
-	if (check_mul_overflow(m->cp_hqd_cntl_stack_size, NUM_XCC(mm->dev->xcc_mask), ctl_stack_size))
+	per_xcc_size = min_t(u32, m->cp_hqd_cntl_stack_size, mm->ctl_stack_size);
+
+	if (check_mul_overflow(per_xcc_size, NUM_XCC(mm->dev->xcc_mask), ctl_stack_size))
 		return -EINVAL;
 
 	return 0;
@@ -407,13 +411,15 @@ static int get_checkpoint_info(struct mqd_manager *mm, void *mqd, u32 *ctl_stack
 static void checkpoint_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst, void *ctl_stack_dst)
 {
 	struct v9_mqd *m;
+	u32 ctl_stack_copy_size;
 	/* Control stack is located one page after MQD. */
 	void *ctl_stack = (void *)((uintptr_t)mqd + AMDGPU_GPU_PAGE_SIZE);
 
 	m = get_mqd(mqd);
+	ctl_stack_copy_size = min_t(u32, m->cp_hqd_cntl_stack_size, mm->ctl_stack_size);
 
 	memcpy(mqd_dst, m, sizeof(struct v9_mqd));
-	memcpy(ctl_stack_dst, ctl_stack, m->cp_hqd_cntl_stack_size);
+	memcpy(ctl_stack_dst, ctl_stack, ctl_stack_copy_size);
 }
 
 static void checkpoint_mqd_v9_4_3(struct mqd_manager *mm,
@@ -422,15 +428,19 @@ static void checkpoint_mqd_v9_4_3(struct mqd_manager *mm,
 								  void *ctl_stack_dst)
 {
 	struct v9_mqd *m;
+	u32 ctl_stack_stride;
 	int xcc;
 	uint64_t size = get_mqd(mqd)->cp_mqd_stride_size;
 
+	ctl_stack_stride = min_t(u32, get_mqd(mqd)->cp_hqd_cntl_stack_size,
+				 mm->ctl_stack_size);
+
 	for (xcc = 0; xcc < NUM_XCC(mm->dev->xcc_mask); xcc++) {
 		m = get_mqd(mqd + size * xcc);
 
 		checkpoint_mqd(mm, m,
 				(uint8_t *)mqd_dst + sizeof(*m) * xcc,
-				(uint8_t *)ctl_stack_dst + m->cp_hqd_cntl_stack_size * xcc);
+				(uint8_t *)ctl_stack_dst + ctl_stack_stride * xcc);
 	}
 }
 
@@ -984,6 +994,15 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 		mqd->is_occupied = kfd_is_occupied_cp;
 		mqd->get_checkpoint_info = get_checkpoint_info;
 		mqd->mqd_size = sizeof(struct v9_mqd);
+		if (dev->kfd->cwsr_enabled) {
+			struct kfd_topology_device *topo_dev;
+
+			topo_dev = kfd_topology_device_by_id(dev->id);
+			if (topo_dev)
+				mqd->ctl_stack_size =
+					ALIGN(topo_dev->node_props.ctl_stack_size,
+					      AMDGPU_GPU_PAGE_SIZE);
+		}
 		mqd->mqd_stride = mqd_stride_v9;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
-- 
2.43.0

