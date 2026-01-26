Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F0CCF65D0
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 10:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B7CE10E3FB;
	Mon, 26 Jan 2026 10:26:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y0EWliaK";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013020.outbound.protection.outlook.com
 [40.93.196.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D48E10E3F8
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 10:26:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lL6k2kkZRbB1JhUrqtRycrt79jMCET0F91dvtRs75q8b1HDZJp3aa7YDXrR+KL9D4PpnrBK6pBPSN0sN8Jbz7z8u75iKwf7yhLV0yUOHx+nM7lwmtVqcP4In4PdZSvt6AxXkdO3YpdBLYXYdaWk+bwLlaud+VX9cMhv8tygh033oIoFQq5hWNSiheZ4m2/wiVEPu+0cnqhJlcjoX6Db5cFxfbufBXEIx1JPoP4EmAx92hnVK6KDqcsCWUDhVIgeYwgdQXcOTHy5YFtCpBZPBghPUnkK1asssYzFohkjEnth7AhzMizo0qagYkPlboPoIJXySodSDpFdIaQlIeQIhCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p71ItvTNPOTQOfqo58aqAm+v4zg+BuBg76MgwPH9nyo=;
 b=UFfliQWS0ySNlvQRZ826Egut25FrB8tDr0nPQd+6Nka9rLo8T0xCrGowOiM1uhsDJx4EvcK666fjU0KbV6y4ELTZ6j7SKI3qNaRWWvenkNWZJ/1l5d6m3dAQmQhY1T8wmw+f8h+evY91dP9zMpp7r8kf/6KWp/D05gp3EgkFxVS0XTeh0s7f7jrs+ETO22lSOET4g9ttjTFHx/KeY6zzndEPCy2yvMaRpc7TCpsBHUh6QKuHYa/kuLe50RxP63VbqcIoZUADH0POtyUMZ6b9/I44MlMJfXxvvWbcR3fUlqDg5EspZx7amLKQPG+Bm1+LppL4zqr0G2k8HxYfDx3Ofw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p71ItvTNPOTQOfqo58aqAm+v4zg+BuBg76MgwPH9nyo=;
 b=y0EWliaKt1m9CjruwG42y4Bf9UEvMRB2ycjYvb1kD+A6OHXwjQRaJikO3bJxTe3kwG46SAbYOCQgx2xdeNKVXJv4sks+/sV+aqewmoRIXg4DrQhIqvRYQlJVsMB0b2a+lhHXnvKQtWxwY/XNtNGcirm0qcBIdcuhIYpnDUc9g+Q=
Received: from BL1PR13CA0286.namprd13.prod.outlook.com (2603:10b6:208:2bc::21)
 by MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 10:25:55 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:2bc:cafe::1) by BL1PR13CA0286.outlook.office365.com
 (2603:10b6:208:2bc::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Mon,
 26 Jan 2026 10:25:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:25:55 +0000
Received: from lang-cezanne.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 26 Jan
 2026 04:25:53 -0600
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, "David
 Belanger" <david.belanger@amd.com>, Lang Yu <lang.yu@amd.com>
Subject: [PATCH 4/4] drm/amdkfd: Use AMDGPU_MQD_SIZE_ALIGN in gfx11+ kfd mqd
 manager
Date: Mon, 26 Jan 2026 18:25:14 +0800
Message-ID: <20260126102514.273891-4-lang.yu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126102514.273891-1-lang.yu@amd.com>
References: <20260126102514.273891-1-lang.yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|MN2PR12MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: 1395dd3e-2399-4830-8c04-08de5cc54a0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wpesbWg1UxmlRrkVVaZQ/0BypW7opEtGjCeEd1a+hMPoChy9ClvI9amARMKo?=
 =?us-ascii?Q?7OTibWBLHFxgz2QX/cUQc0xLBNEGsxJ0zFZfAzuDIM0CN9a9f48C5vbmd3Pj?=
 =?us-ascii?Q?jhpBVcZjdtq9ucwpQ3/SLv14jsyjxjE6v/Y+ZLgk8tMhfNqo3wTLTPH0yauQ?=
 =?us-ascii?Q?lOoHI9zzo2kWK2s+WCc2Dt3f6lWpdgb8ftbORtD3qCNHeuy/uzT0cFpLPcc+?=
 =?us-ascii?Q?Bp3fPiujMKlCRuZUdzVGMlsSWfVjbOOgG0fXzHmV/nBddzY30hkZDWfNRilf?=
 =?us-ascii?Q?bIrJbJBhoXR9aLPgXYyu6fY7o2MsgdRJl/ZoqRHqpGg2J+UJBx8svkQkph91?=
 =?us-ascii?Q?+DCn5hBmki6MpFUoZOpmoR0njfHOpgtbJ2linFa/Hb4Wg3InVepzvT7mpaeu?=
 =?us-ascii?Q?EunWPMQr4Cu5NZnACelc82srH1JMhBnz4MwH3isJ1PyExk8pQxZGySNM9ywz?=
 =?us-ascii?Q?r9b0grVEa00Trc9f1SacR5Zb6iUkZClLJdNOIMXj6Wx1v2ZCBeVr4EVQs5t2?=
 =?us-ascii?Q?ItHcZ7/6mAa+ok27xZURKCFrqn3EJAat30sgVLavxseczv/+Sy9vA6UdyBZJ?=
 =?us-ascii?Q?twITvcaHRbjvTNmR/lS4/8DtXdf4S+yxi7Cg6fGvHYA12TFAXb7DTWU9BV+8?=
 =?us-ascii?Q?6rE2j2FUmQwl67Y4rjqBZP66DiEVHwmwssT9R+aOvwQVUdxnEmhW+Td9PguW?=
 =?us-ascii?Q?PW+xduUVaC8qrjrKAYb3Vx1IbqTleplQgiXcgk2hHx96OUqEBmcLa/P/tZ0Q?=
 =?us-ascii?Q?CNq9xevxkN6Wd49QiMEgUuf2LzhOPMHMu9p9pogsg7mvMjuUI0QzUZY5qu/o?=
 =?us-ascii?Q?qcUFWj2ZbP24wiOzlW2dGrbvSdojYr8OGLCZ0eKOIr604/016nPws3n0JHyN?=
 =?us-ascii?Q?8/MoWT8QOAVSwp+5A8B/J9OzyuHbi+bptU7MdS1ykxLpSTm/dzQnSjokHUzZ?=
 =?us-ascii?Q?JBTWTVNR4coDfe4XZCySH8CNzGi4rf+PqlOzgFULIOP22UzjRkybdhgVLgTX?=
 =?us-ascii?Q?sfBGkMe1FfVfNOgnm9CN3Dgv77U393p04W2Woi7ah5TMYjUaWuLvf3gcehmM?=
 =?us-ascii?Q?uXBzQc+p2jGdLw0XQC4aC3DyAJmAMOa4qzTsr5ABVEcV7BQgcYufgJrX32hK?=
 =?us-ascii?Q?XwJ+6soNt9xb+N5cwas2s5nMSFtU1C9IYW6jjNIASowavtkIWabj17eoJqQL?=
 =?us-ascii?Q?DnMxDYvA/q4CqIY3HWCasxQFb0tT2azc+ajZHqkuQ4cduanmanT3RiYAhpkQ?=
 =?us-ascii?Q?ijVEm+uEryXaNmiPSzn3wjVgwV7jiEbrkvDTdn2UoEK3QpPzlewKk3xknUxO?=
 =?us-ascii?Q?z0N4nFsZoCjYL0aVkwpCg3NnfxVaWC+4nK1H7n4YC0oSE97AG1OIOUHKzUnq?=
 =?us-ascii?Q?luMlT5+CJL4FphfdbnAGVOro3zRxityxrnvr0NkozrfCRaLjEWQYVk3DFl17?=
 =?us-ascii?Q?ugXzH1A0xaPqjA39aNwx78iLwqrBoWC8BlFTzcfzY/TDQTzcvA3Cu8LXisRh?=
 =?us-ascii?Q?4E1p5IH2rkw2qInF3/HKtdYSigXw9Gi8eX1BkV88y/yB/+mwgyFKccfD2U8o?=
 =?us-ascii?Q?h6wG1coNlD2z5I9BkzhIzS9WfnjTLUS7Lw0bUGASpj2dM7JZWpmL0RcOn0P9?=
 =?us-ascii?Q?nuMs/U9blR87OUsrHY0tzqrmSXo1Sqd7wlQqQ26HQ7JfxGzmW3USPInGQxJT?=
 =?us-ascii?Q?aTFYcA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:25:55.3610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1395dd3e-2399-4830-8c04-08de5cc54a0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159
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

MES is enabled by default from gfx11+.

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  3 ++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  | 22 +++-----------
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c  | 10 +++----
 .../drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    | 29 ++++---------------
 4 files changed, 17 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index ceb6566ff3e1..d88d0de58edd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -292,6 +292,9 @@ void kfd_get_hiq_xcc_mqd(struct kfd_node *dev, struct kfd_mem_obj *mqd_mem_obj,
 uint64_t kfd_mqd_stride(struct mqd_manager *mm,
 			struct queue_properties *q)
 {
+	if (KFD_GC_VERSION(mm->dev) >= IP_VERSION(11, 0, 0))
+		return AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
+
 	return mm->mqd_size;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 5c44d0987737..7e5a7ab6d0c0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -102,20 +102,11 @@ static void set_priority(struct v11_compute_mqd *m, struct queue_properties *q)
 static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
 		struct queue_properties *q)
 {
+	u32 mqd_size = AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
 	struct kfd_node *node = mm->dev;
 	struct kfd_mem_obj *mqd_mem_obj;
-	int size;
-
-	/*
-	 * MES write to areas beyond MQD size. So allocate
-	 * 1 PAGE_SIZE memory for MQD is MES is enabled.
-	 */
-	if (node->kfd->shared_resources.enable_mes)
-		size = PAGE_SIZE;
-	else
-		size = sizeof(struct v11_compute_mqd);
 
-	if (kfd_gtt_sa_allocate(node, size, &mqd_mem_obj))
+	if (kfd_gtt_sa_allocate(node, mqd_size, &mqd_mem_obj))
 		return NULL;
 
 	return mqd_mem_obj;
@@ -127,18 +118,13 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 {
 	uint64_t addr;
 	struct v11_compute_mqd *m;
-	int size;
+	u32 mqd_size = AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
 	uint32_t wa_mask = q->is_dbg_wa ? 0xffff : 0xffffffff;
 
 	m = (struct v11_compute_mqd *) mqd_mem_obj->cpu_ptr;
 	addr = mqd_mem_obj->gpu_addr;
 
-	if (mm->dev->kfd->shared_resources.enable_mes)
-		size = PAGE_SIZE;
-	else
-		size = sizeof(struct v11_compute_mqd);
-
-	memset(m, 0, size);
+	memset(m, 0, mqd_size);
 
 	m->header = 0xC0310800;
 	m->compute_pipelinestat_enable = 1;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
index b7ac2dea8775..a51f217329db 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -83,14 +83,11 @@ static void set_priority(struct v12_compute_mqd *m, struct queue_properties *q)
 static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
 		struct queue_properties *q)
 {
+	u32 mqd_size = AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
 	struct kfd_node *node = mm->dev;
 	struct kfd_mem_obj *mqd_mem_obj;
 
-	/*
-	 * Allocate one PAGE_SIZE memory for MQD as MES writes to areas beyond
-	 * struct MQD size.
-	 */
-	if (kfd_gtt_sa_allocate(node, PAGE_SIZE, &mqd_mem_obj))
+	if (kfd_gtt_sa_allocate(node, mqd_size, &mqd_mem_obj))
 		return NULL;
 
 	return mqd_mem_obj;
@@ -102,11 +99,12 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 {
 	uint64_t addr;
 	struct v12_compute_mqd *m;
+	u32 mqd_size = AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
 
 	m = (struct v12_compute_mqd *) mqd_mem_obj->cpu_ptr;
 	addr = mqd_mem_obj->gpu_addr;
 
-	memset(m, 0, PAGE_SIZE);
+	memset(m, 0, mqd_size);
 
 	m->header = 0xC0310800;
 	m->compute_pipelinestat_enable = 1;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index 0b0d802a0917..d0776ba2cc99 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -32,17 +32,6 @@
 #include "amdgpu_amdkfd.h"
 #include "kfd_device_queue_manager.h"
 
-#define MQD_SIZE	(2 * PAGE_SIZE)
-
-static uint64_t mqd_stride_v12_1(struct mqd_manager *mm,
-				struct queue_properties *q)
-{
-	if (q->type == KFD_QUEUE_TYPE_COMPUTE)
-		return MQD_SIZE;
-	else
-		return PAGE_SIZE;
-}
-
 static inline struct v12_1_compute_mqd *get_mqd(void *mqd)
 {
 	return (struct v12_1_compute_mqd *)mqd;
@@ -148,21 +137,14 @@ static void set_priority(struct v12_1_compute_mqd *m, struct queue_properties *q
 static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
 		struct queue_properties *q)
 {
+	u32 mqd_size = AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
 	struct kfd_node *node = mm->dev;
 	struct kfd_mem_obj *mqd_mem_obj;
-	unsigned int size;
 
-	/*
-	 * Allocate two PAGE_SIZE memory for Compute MQD as MES writes to areas beyond
-	 * struct MQD size. Size of the Compute MQD is 1 PAGE_SIZE.
-	 * For SDMA MQD, we allocate 1 Page_size.
-	 */
 	if (q->type == KFD_QUEUE_TYPE_COMPUTE)
-		size = MQD_SIZE * NUM_XCC(node->xcc_mask);
-	else
-		size = PAGE_SIZE;
+		mqd_size *= NUM_XCC(node->xcc_mask);
 
-	if (kfd_gtt_sa_allocate(node, size, &mqd_mem_obj))
+	if (kfd_gtt_sa_allocate(node, mqd_size, &mqd_mem_obj))
 		return NULL;
 
 	return mqd_mem_obj;
@@ -174,11 +156,12 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 {
 	uint64_t addr;
 	struct v12_1_compute_mqd *m;
+	u32 mqd_size = AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
 
 	m = (struct v12_1_compute_mqd *) mqd_mem_obj->cpu_ptr;
 	addr = mqd_mem_obj->gpu_addr;
 
-	memset(m, 0, MQD_SIZE);
+	memset(m, 0, mqd_size);
 
 	m->header = 0xC0310800;
 	m->compute_pipelinestat_enable = 1;
@@ -681,7 +664,7 @@ struct mqd_manager *mqd_manager_init_v12_1(enum KFD_MQD_TYPE type,
 		mqd->is_occupied = kfd_is_occupied_cp;
 		mqd->mqd_size = sizeof(struct v12_1_compute_mqd);
 		mqd->get_wave_state = get_wave_state_v12_1;
-		mqd->mqd_stride = mqd_stride_v12_1;
+		mqd->mqd_stride = kfd_mqd_stride;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
-- 
2.34.1

