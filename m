Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6BCCDB471
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 19:40:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1C8E10EC5B;
	Tue, 23 Jun 2026 19:40:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aVX3xTs9";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BC9C10EC5B
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 19:40:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqDy5IPTur6PZmb4H2lv5GeSoaYacnRjJ0nh8JhjBd3dZp2G0irk8iGNjrGcxSRgulKzjg1per2TuPXVwDrosnO0fsAs8wR+tk8ANuTAd7QKSj0HB+QDj6yq7rbhlda5ZYHKD95rqSxDRZPm+2X8PI3LdZRjHScZuMHPuoVLbyrwzGLnHpkCD3gvSXOePZmTG9WNQsMoGGzmyG5KPSAO2+7PQ9KSMldhNj7Rwnm1Ku+K8+g8Wq3IPN0wrySWdECwVbVLWwsMCzjJo3J5Dzf6Eq5AIKqvsKnVjYHyHP6PtW+S5bCNP4StCltVWMqIsUEzYaWTqPgG6LMmL50uKs7gqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xdzcAhEcwciTGlrm103G0vAJF54Tz5HVbfwT1bvfjw=;
 b=s7wKr0Ez7Rf8PxqVi912d1SOOWbXMfMS+/IJVLrZDi9ekS/JY06Ybm81hcb1i23FBP4ay8mBx3wVSkEUkpkUrB9s8/wybeU6wmMcZccnpNq7vXu3u7wSKO0IxFbONpJSMpRpxnVMDwlaE/cFtg84nnGQ6IhlD0Ea+fx/fWgT0UGZuuEUCNzOGGc77IqozSK2mn8iz9CHmnSi/nnoZ6vBASkWCrtXLxgGjG4VizXkUAolh65wd3ZP2RC8qoBLBxQUVAVwS6GIJsQOHDyl1QHXtO5FqtqZLapT3fX31Wkk+xh1HlAa+cKeFh7GpvuQsozlv6bOXgH8RlS9SH4262gYgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xdzcAhEcwciTGlrm103G0vAJF54Tz5HVbfwT1bvfjw=;
 b=aVX3xTs9T2fMb4da3+yMR6kSbgwjIQhvowP5xLBYnI6ldTSlCUtUPrT0ZiMipH3IiCZ3CTVz0HpfiDhks9eKJpjdaxwGwrp53+1yBzw45LixGx5bXJMpx0z3LQt5lh13R51BYBB7xkPXg7UplLpv+kRQaiOj/Q/Qkmb5xh3P3YM=
Received: from SN7PR04CA0221.namprd04.prod.outlook.com (2603:10b6:806:127::16)
 by CH3PR12MB8073.namprd12.prod.outlook.com (2603:10b6:610:126::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 19:40:03 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:127:cafe::4e) by SN7PR04CA0221.outlook.office365.com
 (2603:10b6:806:127::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Tue,
 23 Jun 2026 19:40:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 19:40:02 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 23 Jun 2026 14:40:00 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH] drm/amdkfd: bound v9 CRIU control stack restore to allocated
 MQD region
Date: Tue, 23 Jun 2026 15:39:49 -0400
Message-ID: <20260623193949.4184400-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|CH3PR12MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: 1428c495-0db0-40a1-763b-08ded15f3801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|56012099006|6133799003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: vL9PC3xFwbl+H1SIktlaTC7rhmMr0FhnjMgTHuCUZJiHPbPTqZsy5G+y+CIYPN5Br2jnI44feBTQJyDVejAvMR6rc013m2SN8Jdoccvr7UXlu5p3Lz9qZHOQY+wuqIpjcuyzGOdE5OQ3VXFqwfRXqMICgFmgks9xwQlqSekce2cyfMz4DZvvrv2S+hy8hLfnDP04IUT4DqefP08AklD34PiQ6I1jiP/Iwg78aZwViRQUyg3M8qRTkvtQyfdpNMmC5cQUvWbsupWjqz1T2dweIYY8JS1jQ4//PL+v6QRNqyXTvkyL0jucjJ0PHmzTrLf+h7M/Ts/H2lS1rS2EPVea5jYGh4Enc56pUzNEYtTqtDxzwINIuu1+g218GNyfirQT4nwZQD1FW38ZQ+Fn1X5Vqvm46+/gE/hJVF3nFUahlFKDoVT7eqC1yifXY/AhBwOXFhFApwJ+2Xw6FM8TkwXGoUvbN8mS32G0W8nCjBL8P8wDQizkrD2Te1rYRlphhAJHTIjXwAUB5xNVIC+op6LyrOdjgMqK8Dafcc5/ehiwgmL+sAs+Vd1g84KDsIeIxbyriWvn953mp03j1Ar/13ZGW62EwszME/q3vknCwUS+aKJdRCvKv23kXPCHTMdi2kdA0mwTR68bBMJnztwl7Lq4Y9fAgNgM6sbnFDTSjLsCLlmwfvfkhj27QbVeDWqDISwD1tgMjXQbUYuXOzIf1L5U4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(6133799003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JM4kiqYgfvL8dbzVnYxt4fqLgEI5obZ/9s6v1v6XPdTIXmqT/KLwj8JaOSYoP08NyPVzC42D6wodnPH5gBSryoH0PuCP0nzx3c4PrzvBSFT/Gq4D983Rlr9jCFidyer1ZCEw5tqAXZ45LbK7KH+TyUjHwqgsx7ga2tTFMUKHTkYtuN9LhqjzpUrMvA5O8Oa9EINE6W9z5aaLxBSSqfLoqZeOA/QlPf6/WZFvehGWBhcLDUD3tUSfr8ugHMnN7RMgOWi+EXdB4XNLzqnFSTgqILVf5I78Rrc7Bo8mBW1Go8srAJTM+wiNP6DQkj7UypZaZaNSlwG/6Enrjccn4sZ+5lINadJbV2NXmVWsAJNhiSMYg5QZZf3uQlmBIkGfP4NHISlLp1ldkr13HrhRwh4PH8Xxi4P4VmR2rnACL76w97NcrNOOWQRVH52BN/y88Vj1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 19:40:02.4218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1428c495-0db0-40a1-763b-08ded15f3801
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8073
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

During CRIU restore, restore_mqd() copies the MQD control stack using a
size derived from the untrusted, user-supplied q_data->ctl_stack_size. On
multi-XCC GFX9.4.3 parts the divisor used to size the MQD allocation can
differ from the one used for the copy, so the memcpy at the fixed
+AMDGPU_GPU_PAGE_SIZE offset can write attacker-controlled bytes past the
TTM/BO-backed MQD buffer into adjacent kernel memory, allowing local
privilege escalation (requires CAP_CHECKPOINT_RESTORE and /dev/kfd).

Clamp the control stack copy in restore_mqd() to qp->ctl_stack_size, the
page-aligned region allocate_mqd() actually reserves, and reject oversized
q_data->ctl_stack_size early in kfd_criu_restore_queue() by bounding the
per-XCC size to the node's advertised control stack size.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 16 +++++++++++-
 .../amd/amdkfd/kfd_process_queue_manager.c    | 26 +++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index ce379ab17916..9117fbae0a1a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -453,8 +453,22 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
 	if (gart_addr)
 		*gart_addr = addr;
 
-	/* Control stack is located one page after MQD. */
+	/*
+	 * Control stack is located one page after the MQD. allocate_mqd()
+	 * sized this region from qp->ctl_stack_size (page aligned). On the
+	 * CRIU restore path ctl_stack_size is derived from the untrusted,
+	 * user-supplied q_data->ctl_stack_size and, on multi-XCC parts, from
+	 * a divisor that may not match the one used to size the allocation.
+	 * Bound the copy to the allocated region so a malicious checkpoint
+	 * cannot write past the MQD buffer object into adjacent kernel
+	 * (TTM/GTT) memory.
+	 */
 	ctl_stack = (void *)((uintptr_t)*mqd + AMDGPU_GPU_PAGE_SIZE);
+	if (ctl_stack_size > qp->ctl_stack_size) {
+		pr_err_ratelimited("ctl_stack_size 0x%x exceeds allocated 0x%x, clamping\n",
+				   ctl_stack_size, qp->ctl_stack_size);
+		ctl_stack_size = qp->ctl_stack_size;
+	}
 	memcpy(ctl_stack, ctl_stack_src, ctl_stack_size);
 
 	m->cp_hqd_pq_doorbell_control =
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 071f956f183c..7c4f89cf283c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -27,6 +27,7 @@
 #include "kfd_device_queue_manager.h"
 #include "kfd_priv.h"
 #include "kfd_kernel_queue.h"
+#include "kfd_topology.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_reset.h"
 
@@ -984,7 +985,9 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 {
 	uint8_t *mqd, *ctl_stack, *q_extra_data = NULL;
 	struct kfd_criu_queue_priv_data *q_data;
+	struct kfd_topology_device *topo_dev;
 	struct kfd_process_device *pdd;
+	uint32_t max_ctl_stack_size, num_xcc;
 	uint64_t q_extra_data_size;
 	struct queue_properties qp;
 	unsigned int queue_id;
@@ -1032,6 +1035,29 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 		goto exit;
 	}
 
+	/*
+	 * q_data->ctl_stack_size is user-supplied and is consumed across all
+	 * XCCs of the node when restoring the MQD control stack. Reject sizes
+	 * that could not have come from a valid checkpoint before sizing any
+	 * allocation or copy, so a bogus value can never drive an
+	 * out-of-bounds control stack write during MQD restore.
+	 */
+	num_xcc = NUM_XCC(pdd->dev->xcc_mask);
+	topo_dev = kfd_topology_device_by_id(pdd->dev->id);
+	if (!num_xcc || !topo_dev) {
+		ret = -EINVAL;
+		goto exit;
+	}
+	max_ctl_stack_size = ALIGN(topo_dev->node_props.ctl_stack_size, PAGE_SIZE);
+	if (q_data->type == KFD_QUEUE_TYPE_COMPUTE &&
+	    q_data->ctl_stack_size > (uint64_t)max_ctl_stack_size * num_xcc) {
+		pr_err("CRIU restore ctl_stack_size 0x%x exceeds max 0x%llx\n",
+		       q_data->ctl_stack_size,
+		       (uint64_t)max_ctl_stack_size * num_xcc);
+		ret = -EINVAL;
+		goto exit;
+	}
+
 	/*
 	 * data stored in this order:
 	 * mqd[xcc0], mqd[xcc1],..., ctl_stack[xcc0], ctl_stack[xcc1]...
-- 
2.43.0

