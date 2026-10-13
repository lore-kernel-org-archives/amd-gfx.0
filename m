Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FDDCC6B1A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 19:47:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 611C610E921;
	Tue, 13 Oct 2026 19:47:42 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012025.outbound.protection.outlook.com
 [40.107.200.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E039C10E94E
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 19:47:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CoToiqDvZQAipBELmKU7EpqJ8uAeMDk3JMkh62F2/2aOLfUwsARrBiDOS/B0R3zX2kqxv4l6fkhI762SrQLZJ/bsJJSJdqOfbq5vTLHTJmBFur1S5Mru6GYHzJyurNokoaraNxtywnUIt3FmkcgbN1AGkR8hfB555BfrG2mVPpdYWQNCWFccJSVJvUiYTFyps7BkTovbvXhl1HDr589d6x3BUGqjHk4GywQZnTqly5Z7sL2msl6bv3jgHpz0gSzqV0xAa2E1k0h7iThIOC5AQm9K64dLI9/gaV+7OabeEJeHPtVWkznH9AIcTy35BcSBiV2KuHNgkY0AXVzmyA3Ldw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTNdRG+lLI0jRg1RWsLghRiWQjwe9h1oRKN60hrq5wM=;
 b=KxuPwtUJ1u+e0AjxNfuYLDJSNq8npZi/f88rH/s3n824IEemm1xhZcbxlhhd8Mg2zNljIJ9tDGbqxumHTKHYjsnjBZx4SzraygMKN+0XtfnjaLw8f6Zdsejtl8aE1kKgWIVJ/ddioL2f2ncrjDvTI25YxlzO/wpZNwttufBhLj2Zmv/PT9xWzxYZlKco5qNlyfnYEef7NTK156Q4vvtweWG+vhPx3fAX+CTTnvdTA4DW5weQSmAjNqlrBrOJ2sDYybe6qeQjmw+G1qsmtKWf4WAMje3Q2h/xn2VKwS8IVyKy8p6PB1nJib23cvIqah7gSNoRJuTosIos5dK6dNiTfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTNdRG+lLI0jRg1RWsLghRiWQjwe9h1oRKN60hrq5wM=;
 b=R5BDbjg9FjL6O96IK4oN+U4lq/IfY06GZC2UBZrh7cSLNa88aOUCftHJkEFcUqnJrJx2f65wLmFGQTVVg1SKW00YHD+Nk4ki59Wjj4J10ig7H3653Fsx4yIytZoX2p+rCtbhOAHjK7zKNm9RaquymyGj+6TMbcehobjxCnJEcTo=
Received: from MN0PR03CA0010.namprd03.prod.outlook.com (2603:10b6:208:52f::7)
 by SJ0PR12MB6965.namprd12.prod.outlook.com (2603:10b6:a03:448::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 13 Oct
 2026 19:47:28 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::8a) by MN0PR03CA0010.outlook.office365.com
 (2603:10b6:208:52f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue,
 13 Oct 2026 19:47:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 19:47:28 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 14:47:20 -0500
From: William Palacek <William.Palacek@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <William.Palacek@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 1/4] drm/amdkfd: Size restored queues from topology
Date: Tue, 13 Oct 2026 15:47:02 -0400
Message-ID: <20261013194705.3687960-2-William.Palacek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013194705.3687960-1-William.Palacek@amd.com>
References: <20261013194705.3687960-1-William.Palacek@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|SJ0PR12MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: 87393185-eee8-43d4-15c3-08df2962cff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|11063799006|56012099006|10067099003|18002099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: IB0nCb5BiyeaWdhqytVbEAqa5YXxUf6H/vSVcMOh2KLUz3OA45smSojaXVpOOYg3+dv/g43v6U6n4qV5P403k7omezD54ZlywF5b6/ZPZJv+VQkLpXQCFzQwh8uXilURgbpPSCZqpAkxX0malJZsQ2Zmp4gexdvnHfDcNSsuHZG1fgOeZvuP7ueOFXuM41WkvLJarDLqpeWL6UBN3r4DytO+FDYUR6fez0k7g6b/8d5Ic2yYM4DBbu0Xlunt7pHTsF8ZaLjDHaMSBCHBmzYUUUQ54O2Sk+wnpjnJhDf5A81EfnW7VmdAYcthzRfpf9JLIbEBMIo2Utb3PaE6O3rG6DbZdqAfKDELw32MHda+It1MuQjL2aUVVyzzTEXjp0upvfFVik10gQmrtZvL73/zab2f97YlT+d/JK8K+YvH0W0984gtW8FGfwSaOWgeYFgXp7nOX+w78Vr+N3nO1/RTvWje24xK5k61RPiGFLF1qvTaapcbonVblAP9KQ7bjVZSuG2/F0ad2Nus2CKVIxj4WlE8i6+WSoh7YdSfnyoVJtgyrugvftAlrb4uRcTE2k5lxglCfyIx+wr/2IitGr5ynsQ9zca8GglnP4Ui8ukRg/Q+7Rh3b1QFLNsdvnuqrX4P+8slKLO11b3BNBTf+Ywf5lFwP94f+EHl3SPb5fNzD5cKRGJC2Wnjp7r7lqWOZ9V/kNYDMbVIIxfc1v2UbHjvSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DnV20n7xfHYeCJRfRROEvMhJ2Kpc2I+KvsGLXQK2eK058J9hj3mSiT24bvVygmHGmWOdOe84XryyvkShnJtLLOwPb40vMgXde621h9CAgMVclJQgQahpsJszfLPrWqO61l1t2jU7nfZ5BCg1BFazLzEP3hfgrkVEbEGSgAp3kdKO8wA5oviPoPOpUkXONJeKGOzypG736M35JZRSqKThLmKnIYFjgEMN0W6xlade8qJQ8i/yXqH9hV0CWWbUX1hpcyuPzcULsoJ5xqBb7wTLSvOvTk8k+5Yk48UdjggY0RsS7pzCxX3s0mC7ZpaQ1EM4vtoA9rDHjagRvseceINIvZWnaNSLoSQCvbmRxd6QOhKUhNI2/radqGK882Zdr1OSIiAPDNjjGg6e8A1+niDxVaesNgw0nWZm7/oEcCpUw7S1nB/3tCzpEQNshRQrvubz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 19:47:28.1601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87393185-eee8-43d4-15c3-08df2962cff0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6965
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

kfd_criu_restore_queue() takes the control stack size of a restored
queue from the checkpoint image, without the check create-queue does in
kfd_queue_acquire_buffers(). On gfx9 with CWSR, that size, per XCC,
sizes the MQD buffer in allocate_mqd() and is the ceiling
get_wave_state() uses to bound its copy of the control stack. A value of
0xFFFFFFFF reaches a kmalloc() above KMALLOC_MAX_SIZE and trips a page
allocator warning. Without CWSR the MQD comes from the GTT
sub-allocator, sized for the MQD alone, yet restore_mqd() still copies
the image's control stack one page after it.

Take the per-XCC control stack size from topology instead, as
create-queue requires, and 0 for queues without a control stack
(non-compute, or CWSR disabled). Reject an image that carries more
control stack than that per XCC.

The MQD in the image keeps its own cp_hqd_cntl_stack_size and
cp_hqd_cntl_stack_offset, which CWSR uses to place the control stack
after the MQD. Set the size to the allocated size in the gfx9
restore_mqd(), as init_mqd() does, and keep the offset within it, so
CWSR cannot access past the control stack of the new allocation.

Fixes: 3a9822d7bd62 ("drm/amdkfd: CRIU checkpoint and restore queue control stack")
Signed-off-by: William Palacek <William.Palacek@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  3 ++
 .../amd/amdkfd/kfd_process_queue_manager.c    | 33 ++++++++++++++-----
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 6e6bc1ec0b64..c02dd9abc3ad 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -462,6 +462,9 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
 	addr = mqd_mem_obj->gpu_addr;
 
 	memcpy(m, mqd_src, sizeof(*m));
+	/* CWSR must not access past the control stack of this allocation */
+	m->cp_hqd_cntl_stack_size = qp->ctl_stack_size;
+	m->cp_hqd_cntl_stack_offset = min(m->cp_hqd_cntl_stack_offset, qp->ctl_stack_size);
 
 	*mqd = m;
 	if (gart_addr)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index a15a826519ad..b41494775767 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -26,6 +26,7 @@
 #include <linux/list.h>
 #include "kfd_device_queue_manager.h"
 #include "kfd_priv.h"
+#include "kfd_topology.h"
 #include "kfd_kernel_queue.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_reset.h"
@@ -983,7 +984,7 @@ int kfd_criu_checkpoint_queues(struct kfd_process *p,
 }
 
 static void set_queue_properties_from_criu(struct queue_properties *qp,
-					  struct kfd_criu_queue_priv_data *q_data, uint32_t num_xcc)
+					  struct kfd_criu_queue_priv_data *q_data)
 {
 	qp->is_interop = false;
 	qp->queue_percent = q_data->q_percent;
@@ -996,11 +997,6 @@ static void set_queue_properties_from_criu(struct queue_properties *qp,
 	qp->eop_ring_buffer_size = q_data->eop_ring_buffer_size;
 	qp->ctx_save_restore_area_address = q_data->ctx_save_restore_area_address;
 	qp->ctx_save_restore_area_size = q_data->ctx_save_restore_area_size;
-	if (q_data->type == KFD_QUEUE_TYPE_COMPUTE)
-		qp->ctl_stack_size = q_data->ctl_stack_size / num_xcc;
-	else
-		qp->ctl_stack_size = q_data->ctl_stack_size;
-
 	qp->type = q_data->type;
 	qp->format = q_data->format;
 }
@@ -1012,6 +1008,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 {
 	uint8_t *mqd, *ctl_stack, *q_extra_data = NULL;
 	struct kfd_criu_queue_priv_data *q_data;
+	struct kfd_topology_device *topo_dev;
 	struct kfd_process_device *pdd;
 	uint64_t q_extra_data_size;
 	struct queue_properties qp;
@@ -1048,6 +1045,27 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 		goto exit;
 	}
 
+	memset(&qp, 0, sizeof(qp));
+	set_queue_properties_from_criu(&qp, q_data);
+
+	/*
+	 * Size the control stack as create-queue does, not from the image.
+	 * Only compute queues with CWSR have one, one per XCC.
+	 */
+	if (qp.type == KFD_QUEUE_TYPE_COMPUTE && pdd->dev->kfd->cwsr_enabled) {
+		topo_dev = kfd_topology_device_by_id(pdd->dev->id);
+		if (!topo_dev) {
+			ret = -EINVAL;
+			goto exit;
+		}
+		qp.ctl_stack_size = topo_dev->node_props.ctl_stack_size;
+	}
+
+	if (q_data->ctl_stack_size > (u64)qp.ctl_stack_size * NUM_XCC(pdd->dev->xcc_mask)) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
 	*priv_data_offset += sizeof(*q_data);
 	q_extra_data_size = (uint64_t)q_data->ctl_stack_size + q_data->mqd_size;
 
@@ -1077,9 +1095,6 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 	mqd = q_extra_data;
 	ctl_stack = mqd + q_data->mqd_size;
 
-	memset(&qp, 0, sizeof(qp));
-	set_queue_properties_from_criu(&qp, q_data, NUM_XCC(pdd->dev->xcc_mask));
-
 	print_queue_properties(&qp);
 
 	ret = pqm_create_queue(&p->pqm, pdd->dev, &qp, &queue_id, q_data, mqd, ctl_stack, NULL);
-- 
2.43.0

