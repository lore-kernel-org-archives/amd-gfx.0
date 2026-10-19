Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC23606A324
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 19:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YPLxLict
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D436C10EB19;
	Mon, 19 Oct 2026 19:57:36 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010042.outbound.protection.outlook.com [52.101.61.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29B1F10EB19
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 19:57:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gil3Z5DEx6eV5koZP/T73EVNOwRomX4ZQnQ3VbkcrxB0spjjflNxQR5j7msODksLMYKv1ONnfUiRw+nPik6DXdjrjaZQNvcUtnSsXpXl14Jpz3R/O5uZBcqzaKK0nV4ckxqWioCVKm/moj0t3UXGaqyD9jiL6GlL9c0ymU9GGttXxcmQCLU78NI6jIIMLpE4y+5QjKlWPfr5+fatpiXvi5yXMFEL9PATKLv/r/lkkQl88I5tW2vZIbS5kuwkMklgk+vedyBnzNXvg4GytPImho5ARh9VfwbgSvjETGPKDS0e1Snn76x6atVNP0ggnXQdVqKwEp34KMqqw1ygcYMbtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdyZrqI8HmEKLj10DjqdLXqWkQ2b13uRpElzw7QogWA=;
 b=kYE2NmncwLkchOO1ks21X0Ns1kVkZvkdGGUl38h6Wg4UPxEk88sHtcES5PW1KgZFiQ1qWEkmqSbHfkAOYH/LCW7dr5oLPoVy0N+7AVFCYaPUxpLcwEqU35umw7ss1vh/MIZcZISkBxU8tzyUoMM9uIGN6SIOdzswsHoMPt69o7uQpiXcGOVD8kMLUkSNgesnjYZtm1kvpi4O9lwXk6caBoYK9cfCk6sU0cMYwPD0NHQQOrOuzZfWKtarFtzKVLV1ye3HQO9itfCgEmlILfRZZsbAG43xIl9dQVq9iUUpdmN6DV0mRzBmayPP+JbLGlNE9E9Tapo5U9QhEV14G7Clkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdyZrqI8HmEKLj10DjqdLXqWkQ2b13uRpElzw7QogWA=;
 b=YPLxLictKIIfJo1gV1cnFwsh2LMe/ngBxNxNc9auVXf3K2qYzQ9350klxwsVyrYnr7nc7bfLAmiyvjgcryiY+2U7ALK6RHASf8s9+qJhSENeYWNTS3iehcufMCHuMjitrdJlzpZvIGlGEU47nDz0bMO4mTiGQ0mMelv5vdRjv9k=
Received: from BLAP220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::30)
 by DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 19:56:56 +0000
Received: from BN1PEPF00018074.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::4d) by BLAP220CA0025.outlook.office365.com
 (2603:10b6:208:32c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Mon,
 19 Oct 2026 19:56:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018074.mail.protection.outlook.com (10.167.245.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 19:56:56 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 14:56:57 -0500
From: William Palacek <William.Palacek@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <Felix.Kuehling@amd.com>, <William.Palacek@amd.com>
Subject: [PATCH] drm/amdkfd: Validate the control stack of a restored queue
Date: Mon, 19 Oct 2026 15:56:01 -0400
Message-ID: <20261019195601.2468302-1-William.Palacek@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018074:EE_|DS7PR12MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: abcd4618-3389-4928-4a02-08df2e1b2107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|261009223027099003|10067099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 2gHnSFYBnblBwskQ5aASNOStDbboDfwPiEtpDrKLIgOk/KhX3BYRgBfW0c69bFyNj1dj7xFbxLg1wPiLRWq7L1twL3YSzYoS46cg1O6jPqC70Fn02LWXBD5QlCo/m09Sd5vtwGq6jjG+cCoeKefmF5LL7FL3dAHX4NAsFakB2KvCPkPY8rGy9EqCg9zk6l//EvOUslAE2nolFJ5+8SRFT+4y3HasP4XnKTfuvI+O3t4QvwoIXX5rAZjMm3dlUo7gkOPWlFty8cId0l/08+m1YabFdGe6K+epISQFnZD2rVPK/1nG/shSEZ8AYIBY4Tt+I7Zr30IFJDdyugieJFHknMgBpumWXFV6WjTTmMqzl1eVlDtTIyFug59L9cDw6laBZPt9+bxrV8p8kUXvLvIZAhuKhoe9eQDUsfANIYJopCo7CfVH6Pv+LXEt/0eDg9z6QxnZysRgoV0ZsD/2rMfDmpweYlYz6Jz/1praKEBVOZ/NkvErO16DMPhRzbGtBH8HOdZ6jaESoCAOoqF9OnH8EcLlmt0EDYP/eg9XGW/9wcRJSIPgvseWCgygjLtsAQdoHui2IGMEtrD/Zc4kf7oxnSIWPqNiwO4ha9yvLcatNl2z5I8mHwAhouqXnbRn56X6EazC5FwuONnrT5WakvRfLaX32oroDRKUlPuxgFgpqo6sTF3cORK8kxU7pY316YLmnxq8ctG0GBeVxDRFLybXiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(261009223027099003)(10067099003)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JFgMRA5QFMS8t5ax9ZjImosrynlowTD7q3qtR4TJEmIWeRSZhGtvusVHU/BK4xMb9NcOZaCAj4UUz2+05wLxE3AUfCiSQASsr4cdOc7mgQjffS8Tw/IXuraOyNsFvN0Ho08VzaejcHXoWoG1ykR19ZEByEUtGWXJe13tJ6VIq7wNfd60EXKCx23cb/y/hFv6iuAf4l2/mioCgdXeGeUlZNLQBOhtUiuxkPPOl7WlEKt1HjLmjkjb/kv5hCuSMjwErxL0YTfPezpW6qxcwCsZIqoIJvHCsaQu1jNiKC2s5C56S+Lvp/YPvZXQ7thhdZ54uqmGa9KGF09aN4/CKcJvjphU5iX+T6zSuS6trBXwPMbI/3fK9JJ/xHjfen5ghuNWx8Quo0UQe+3eImZmYBC998h23YomSHzj2H5uqMElGtGE8cK0yX1HENqYda+XMBpB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 19:56:56.2573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abcd4618-3389-4928-4a02-08df2e1b2107
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8249
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

kfd_criu_restore_queue() takes the control stack size from the
checkpoint image without the topology check create-queue does in
kfd_queue_acquire_buffers(), which restore stopped calling in
commit ad770bbc9dbe ("drm/amdkfd: Don't acquire buffers
during CRIU queue restore."). An image size of 0x300000 is accepted and
sizes the MQD allocation, and 0xFFFFFFFF trips a page allocator warning
in kmalloc().

restore_mqd() also keeps the image's cp_hqd_cntl_stack_size,
cp_hqd_cntl_stack_offset and cp_hqd_wg_state_offset. With offset > size
or wave state offset < size, get_wave_state() returns wrapped sizes.

Take the per-XCC size from topology, 0 for queues without a control
stack, and reject larger images. In restore_mqd(), set the size to it
and bound both offsets as init_mqd() does.

Fixes: 626f7b3190b4 ("drm/amdkfd: CRIU add queues support")
Fixes: 42c6c48214b7 ("drm/amdkfd: CRIU checkpoint and restore queue mqds")
Signed-off-by: William Palacek <William.Palacek@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |  9 ++++++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |  2 ++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  2 ++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c  |  2 ++
 .../drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    |  2 ++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  2 ++
 .../amd/amdkfd/kfd_process_queue_manager.c    | 30 +++++++++++++------
 7 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
index 38b46b696243..d63f7e9fae30 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -138,6 +138,15 @@ struct mqd_manager {
 	uint32_t ctl_stack_size;
 };
 
+/* Keep offset <= size <= wave state offset, as init_mqd() and CP do */
+static inline void kfd_mqd_restore_ctl_stack(u32 *size, u32 *offset, u32 *wg_offset,
+					     u32 ctl_stack_size)
+{
+	*size = ctl_stack_size;
+	*offset = min(*offset, ctl_stack_size);
+	*wg_offset = max(*wg_offset, ctl_stack_size);
+}
+
 struct mqd_user_context_save_area_header {
 	/* Byte offset from start of user context
 	 * save area to the last saved top (lowest
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 4f8a8a1a6186..6c9bafa3962e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -305,6 +305,8 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
 	addr = mqd_mem_obj->gpu_addr;
 
 	memcpy(m, mqd_src, sizeof(*m));
+	kfd_mqd_restore_ctl_stack(&m->cp_hqd_cntl_stack_size, &m->cp_hqd_cntl_stack_offset,
+				  &m->cp_hqd_wg_state_offset, qp->ctl_stack_size);
 
 	*mqd = m;
 	if (gart_addr)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index bf015dc5b868..5709949de2eb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -340,6 +340,8 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
 	addr = mqd_mem_obj->gpu_addr;
 
 	memcpy(m, mqd_src, sizeof(*m));
+	kfd_mqd_restore_ctl_stack(&m->cp_hqd_cntl_stack_size, &m->cp_hqd_cntl_stack_offset,
+				  &m->cp_hqd_wg_state_offset, qp->ctl_stack_size);
 
 	*mqd = m;
 	if (gart_addr)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
index 6ea09b031caf..aea80266d254 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -393,6 +393,8 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
 
 	memset(m, 0, AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size));
 	memcpy(m, mqd_src, sizeof(*m));
+	kfd_mqd_restore_ctl_stack(&m->cp_hqd_cntl_stack_size, &m->cp_hqd_cntl_stack_offset,
+				  &m->cp_hqd_wg_state_offset, qp->ctl_stack_size);
 
 	/* Update MQD base address to the newly allocated location */
 	m->cp_mqd_base_addr_lo = lower_32_bits(addr);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index 2bbf5e63f615..15dbe8e5f286 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -692,6 +692,8 @@ static void restore_mqd_v12_1(struct mqd_manager *mm, void **mqd,
 	memset(m, 0, AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size) *
 		     NUM_XCC(mm->dev->xcc_mask));
 	memcpy(m, mqd_src, sizeof(*m));
+	kfd_mqd_restore_ctl_stack(&m->cp_hqd_cntl_stack_size, &m->cp_hqd_cntl_stack_offset,
+				  &m->cp_hqd_wg_state_offset, qp->ctl_stack_size);
 
 	/* Update MQD base address to the newly allocated location */
 	m->cp_mqd_base_addr_lo = lower_32_bits(addr);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 6e6bc1ec0b64..fca43017ee7e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -462,6 +462,8 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
 	addr = mqd_mem_obj->gpu_addr;
 
 	memcpy(m, mqd_src, sizeof(*m));
+	kfd_mqd_restore_ctl_stack(&m->cp_hqd_cntl_stack_size, &m->cp_hqd_cntl_stack_offset,
+				  &m->cp_hqd_wg_state_offset, qp->ctl_stack_size);
 
 	*mqd = m;
 	if (gart_addr)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index a15a826519ad..78ab759ad854 100644
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
@@ -1048,6 +1045,24 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 		goto exit;
 	}
 
+	memset(&qp, 0, sizeof(qp));
+	set_queue_properties_from_criu(&qp, q_data);
+
+	/* Per-XCC control stack size from topology, as create-queue requires */
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
 
@@ -1077,9 +1092,6 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 	mqd = q_extra_data;
 	ctl_stack = mqd + q_data->mqd_size;
 
-	memset(&qp, 0, sizeof(qp));
-	set_queue_properties_from_criu(&qp, q_data, NUM_XCC(pdd->dev->xcc_mask));
-
 	print_queue_properties(&qp);
 
 	ret = pqm_create_queue(&p->pqm, pdd->dev, &qp, &queue_id, q_data, mqd, ctl_stack, NULL);
-- 
2.43.0

