Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5209FCD6E57
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 13:51:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC3B710F162;
	Tue,  2 Jun 2026 13:51:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AcLSjrzj";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013036.outbound.protection.outlook.com
 [40.93.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 740CF10F15D
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 13:51:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebEck7qIjvNPDLOXLOjsl9m+c9xzYKOPKAlSOct+r1DCQRnoGU1norUCtDMyTrMgx9Lu9BV9T/11sN786f/41zcjtelr0F1mGbMdAAry2/8XQfft4URodVizgyqCAOT/qdh6ZbTfhgzWPAAs07hR4g97qdL3IorqhMFM4MS2Tba7gjypvobZBeyXl+i9Dy7UcuCy7BK+QEiWDpp8rsG8El9klbO7JLDO7Lci6imWu1Q5Er72aJ51ELtjzUOr3gMkeWRbpxCmH9xm67i7s1Ek0vQPpIOVlwQoVp2yUy0XtmYkM3/qzi814+wk5c4ewtHJH2/k3EKpHGpmmxRCyD8f3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gf3mRXr4AmZtrkCgDuTSorad112BAnvrTUTInaTIAtw=;
 b=EeeArMHtORwzAtxgifA6hiMWPgbXPMWvVIUhmEsH/wRDE3xstBxwStxFjxB/2fRPsvTpTb6IievLpNn8wGuA9xjxKiSG6wFawlmLm4gGZlZIhq6+czYYxddxUQrHXkRQqYPD6A93xwiv5Q4rcIw1tC5AOaUnKP865EL8LvXwwJ6cwb8AhLvGbSvSMpfIoB7dDz2NZTpp51hayDmByb173JDKug7u9/7To50ctH7LrdTZ9VtJgoThMMSoDVGPdQkrH3IbnedF6TieWMpsYhTMUOFN7ul52BuHoW6h7kf9/jR03o9qRopueKYF95cdZYbbjFcKlSjCAe2WoeLbBsmhdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gf3mRXr4AmZtrkCgDuTSorad112BAnvrTUTInaTIAtw=;
 b=AcLSjrzjMFgELFtKyLuPlbOy/NfHz8MBvhuXfKr7/1l4/adSmUtHEOXCEkQs1MXeNTouG8xl5MXgBeDqgIGFDCjqQ/vAYmNgfaj6vOhvc0dEs6fqAw+B3ITPrDNLK1Shjf0htzLY8+NglRdzh06yOK/98Z1S0DNyibAEnMnkjL8=
Received: from CY5PR13CA0051.namprd13.prod.outlook.com (2603:10b6:930:11::13)
 by LV3PR12MB9403.namprd12.prod.outlook.com (2603:10b6:408:217::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 13:51:04 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:930:11:cafe::28) by CY5PR13CA0051.outlook.office365.com
 (2603:10b6:930:11::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.6 via Frontend Transport; Tue, 2
 Jun 2026 13:51:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 13:51:03 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 2 Jun 2026 08:51:01 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH] drm/amdkfd: clamp v9 CRIU control stack checkpoint copy to BO
 size
Date: Tue, 2 Jun 2026 09:50:49 -0400
Message-ID: <20260602135049.1054739-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|LV3PR12MB9403:EE_
X-MS-Office365-Filtering-Correlation-Id: 08033c59-fd49-463b-76e0-08dec0adfd0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: eAsIhZTdumSABa518nUQxCbz7npyXSWF8Cez0ipUvUlSVvDhv7k5oWbleXN3NkjyxZYE6WJ2lCPeCp2TrkveyYrx3ZL2hskdlQEZZX1VyN2bYFMXkzRhPmx0fuXLvFxwEGoZ76DGAjhn8GF87MmnG42liyihB7UOUaw8fuiyUy4GL7JKGgI7IR4zHGHcKy6qSOO+i/TY1DsslO9p2LdBTggPuzdfqdHQD3Ur3Gx2S25X6aqLiNnyZllPwHk5UkGz8tC3Sym9JFDyCdl7DKk3Rn9YsB8+gICzmdqNEKbJhtWt71sgATtWhqh0Is4qsQhKSE+T+q1B7X4cvSGpGAKtoG20Deyh0a3P9m3rZsGzYf6r/wL/lTJE5YQIIc/v70xqnCawRayv2lhOBgaKNt4Gmun1YwZWnszCN+Q+c4N/iMDJR8Job/HI/vL8hDpF0lQkocNhqi7qOO+SLPAsngOYaBgopmF7ZDVdft2xqEJfzCeD13zi+1JJPsp5wY9393YHMEqJU9bcZJRlbmy0Skv2hSujKDB1l/lM+1Bn9lWa2RVbaNTs8Z5parfQX400vGWKXOOCBXfXXExgjG6BnrPEGz4vhNWiSzS8dqhJxfn36Lyo4e5LQi+8hrY7jOqbUaPrEPXg+R0/vnh17EiPUJg0H1iNN95hSk+orcKjdhCsYgxJvqPXOMmGL+NB3TPepHfDOhOf0Wx4GIJORDKAOVD4o/7nT3UyI2ANlPMbMl6jiTE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1Jz3wimocnGM5z9cuqMExGjVPFqnm59JrWwPTg3FC0dDWA6gsoPg3YGFsJ96J35rAtb88rYthD/12MHYVOktqTLQBuRogKw2mdUUk08GBUvd0LOsGi6rdNp9qfD6xDEBUdIv2TRotrFj9GH8V+VwteIel4KHnYOxVtKT7vs9DfnD0jqNLnrLv0udQGFyFobwQHEJFO01LlwpXNVUVMD8/oTy+WRj8AGJ+Vi4oI64uNKC/8HUdXRlZM9nqvTVVY4GCYCWmAECWC5ufKd37RL8jzf3Yat+Yq3UcdWHq4RNEu1lVSeinF0gexox3TwyvblXjVPEncaYnirPhJQcIP1tEVbIhnMXTCLFT+8WB5DgetXZdja1Zp6v4mSzvjAEfYjmIYb8OqXY5W9JFanf+XlbHiI/gOn5fvAZ5lEabdt8bLEZFZ1/jIlutv4EDvJN5KDQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 13:51:03.9738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08033c59-fd49-463b-76e0-08dec0adfd0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9403
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
index 06ca6235ff1b..63ea70e5c0e6 100644
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
index a04102fd2fb7..741de3ded293 100644
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
@@ -411,8 +412,11 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
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
@@ -421,13 +425,15 @@ static int get_checkpoint_info(struct mqd_manager *mm, void *mqd, u32 *ctl_stack
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
@@ -436,15 +442,19 @@ static void checkpoint_mqd_v9_4_3(struct mqd_manager *mm,
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
 
@@ -998,6 +1008,15 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
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

