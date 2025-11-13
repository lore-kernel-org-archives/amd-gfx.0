Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A598FCD8C9C
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 16:10:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 399E410E898;
	Thu, 13 Nov 2025 16:10:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GFLjcwPz";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010038.outbound.protection.outlook.com
 [40.93.198.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F14A10E88F
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 16:10:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQz6wHA9KTe8niLdnSpYIHQP4gykC095RLLpPjgZikcnEiKnPcEFZU4WUNxwZsrJHiM1fW7NR5jfwtwNknE21gcff+Pj+LCCJpMziYue+ug8wy6C5rW0swSfV5i+sjs9jQUowxBYtvswb706rqy6FNcy8Ja/p5NqUKZQwuTZJFI7f6YiQ3MAmJzMy98wEf4ZEZfqkAzKg5/VkinUPgsEF+t7Tlrps/q0AQMIIvtvR5FQHO4ZRCXtNUbP/UF5tlM1kvLSDRO/q3rPHJ7Qkn6UXQn+TXqlXLFd+9xXHyVLwnbw/9QKxhoLOtThNpYXlkwBotpFtaBe7wlTJGTggUB60Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCtLlMfvR425KFxQcyfTowuPB1N/mnztGhotSvwzRSc=;
 b=p9XCT/dlV9NW2IA30useNLVk3PHODqePBWrBQQ0b2QzC2dtNRartNmln1bQfI28o35zzfRnMEhz8WZz+Iycdzf1+URpCKJFAltjI7u/6LhqRVsK1J+/93F3Kyokxh38T6yw5ndABI+Oq8xWlMu7+1qLz3kZqeS6RU8ifxm0b5V2cX3a40rmaVctlYErPyOV45Gln873eaMju8C0Zx2uxizkJW7KouVtQu9YyTPbYQjYbDJVaboymvWxCQZZCXME6m9euSk5rN3KxVOFL2ieNI+973DHaE+59v70kG4udbHyi9RJxBzUWwejHq5BvNg43kattAFfb++AqdpamKe42Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCtLlMfvR425KFxQcyfTowuPB1N/mnztGhotSvwzRSc=;
 b=GFLjcwPzSTIuhBQr4Oc2WwW4//MYvyFJAfAkMlmaXd4Km9EZ5tDnvRTtekoqfxGZD7H2B8itbXgjZSNoABsGEYi5C4NbIn8R4Hnvq9Bi0CH3O4A1uf3GeYO1cjkMie3fAKOHmBCm8qlyY7mYvcuh3e1cEU6GnpcWc1LK0zlmB7Q=
Received: from BN9PR03CA0589.namprd03.prod.outlook.com (2603:10b6:408:10d::24)
 by DS0PR12MB8018.namprd12.prod.outlook.com (2603:10b6:8:149::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 16:10:29 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:408:10d:cafe::d0) by BN9PR03CA0589.outlook.office365.com
 (2603:10b6:408:10d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 16:10:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 16:10:28 +0000
Received: from amartin-dev-ubuntu.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 13 Nov 2025 08:10:28 -0800
From: Andrew Martin <andrew.martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Andrew Martin <andrew.martin@amd.com>
Subject: [PATCH] drm/amdkfd: Uninitialized and Unused variables
Date: Thu, 13 Nov 2025 11:10:14 -0500
Message-ID: <20251113161014.1118443-1-andrew.martin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|DS0PR12MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c510c70-52d7-4510-9789-08de22cf29ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VnWhaGG8GPYf3nd6GIXf5pxpXYDQAdYnIA7c8OezlV0tRt79acY8PDHCDzYl?=
 =?us-ascii?Q?85D4hxfh2ahSf+gpL/6D+GBRtwKKmqmhN+cR10E/HvJKb7iRJjbKvjMV1KQT?=
 =?us-ascii?Q?f8NICF9qiOYN5lJplCl1WG4Q7BvyNLgMt5y+q7STF1Ft1CMcf1RrRlGiz+/B?=
 =?us-ascii?Q?nVqBa3n9LBW8zvtI0ZmTSOS02ujvQe1xzCeD9ByypICpnEMzkD0bMLYxvpqv?=
 =?us-ascii?Q?GqfkavBWntlvEKpUye8jAdfjnHnE+7h91OgwXOTbM4aPb2fMg1eto3ZQxZhZ?=
 =?us-ascii?Q?keaKx+X7l0Or3IsKMCyUF5eVrKq/+ze1OvRf4Cpy2enjt0ko3AA/fy3aTPPX?=
 =?us-ascii?Q?vaFVUpe+Ic7FfXWFWPk8TN/Ioh3FG8TsR2x7avWn49itgy7xtHY3vW9YOeL0?=
 =?us-ascii?Q?p/VxmKDGRmpTJJht+4LY9mImRHpN5bV4Z5jAcjLoKqFntb9kIoAjjtYZPH+Q?=
 =?us-ascii?Q?+kH40DQqzYfIGbP+t7YawNcl/3c3/NWNrf7+gRUyyCNKyAOgYTiHgbVEVZit?=
 =?us-ascii?Q?oWXkUy+zQC760K6qKCkMHDJLo3jZK7dhK/9d0w/PyuoD0Pt1SnxXHrzlG/fe?=
 =?us-ascii?Q?3y8ziK2+VOpXfjcyG15lU7+dIpCK3StKPV3G1iDRbj4WWeJeUn00gDCvc59Q?=
 =?us-ascii?Q?k8DNI1YrtEiFOrXqMik+iJwWdMSd5d5BeTLjwUCEDV6fF6AEQj3/+z8E2tXf?=
 =?us-ascii?Q?mLs6A6vX3kuQ4K74ReKIP7v8v1VaZTzw3o6Fiz68qhcnCMHax8TOOzXF4hid?=
 =?us-ascii?Q?5fw2HUXe/mY+ddIvNexEGZBB3/zOMpfCNjAHsD8pqtcYTI7Hb9ReBpfyIK/4?=
 =?us-ascii?Q?7deOFbng6eweGH/XAveNv+iV3GgzFCcMcyA+NZR6mXQFQlmaESiJ0QMgN4fm?=
 =?us-ascii?Q?mapKlo3l0nHRsgYYfyvqhg4j+B3TVWUiT2oyxTFxcpp1j5VD/RczjtETWrWl?=
 =?us-ascii?Q?YfyNtAEzI/E/1ymzNeF6hPgum9Hnmph1EdTCImopJJTqbTmp/Prm0RwrtYHC?=
 =?us-ascii?Q?IDhPg3CVj6CXd+ATBwYI8h/hv9figzHUF/PD8oXBLqK4PQD/YrrlSApr1vwV?=
 =?us-ascii?Q?UkwJRgkcAYIRq4+ilDL8b2LSntd5bSkqUZaRn2O3nyEKRhjFNtgrBKdwY7oe?=
 =?us-ascii?Q?jF12JZMa77C/GIt+DU/JM1uYA3MPK4/iQDKMe1WmeAPFSpc5P5pIRWNETW6Q?=
 =?us-ascii?Q?pMufuphoisybEXq7bobVg7RT/uuO0n8z8xOLZYEfN0hgHi8A/KLR/xXxOfJ7?=
 =?us-ascii?Q?2nEYpYRJOJns1BsGzneLHX/ClElq6QR2x0F/v0OmNK9xFm0h7kcKnNDpC62f?=
 =?us-ascii?Q?xjPM37nKdaL5dNlpClzAUQiyu9BtHGIY7v3gdXfz6wLBgKfHIZj1xd1t6CFC?=
 =?us-ascii?Q?3UO+lNuGrDvMQui17n304nTx8ywKzRaEEgx5vIZcbiyYCqT51xk5yaWGCOol?=
 =?us-ascii?Q?3ypOFoX/dir3nCy84Kp9DVx3Uvilr/nZZE6jGqy378TfFiDPPj5Qq/xRUKA1?=
 =?us-ascii?Q?obHMzIuLB7Qhn+5OuaskFehFZt/w4Vc56tAFs02vYrsHMV6zHzwTWykVmxGW?=
 =?us-ascii?Q?pjk1qoMMbjWhYw2VggE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 16:10:28.9566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c510c70-52d7-4510-9789-08de22cf29ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8018
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

This patch initialize key variables and removed unused ones.

Signed-off-by: Andrew Martin <andrew.martin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  8 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  2 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 38 ++++++++-----------
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  8 ++--
 .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  1 -
 5 files changed, 24 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 22925df6a791..a72b242e2e73 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1506,12 +1506,12 @@ static int kfd_ioctl_get_dmabuf_info(struct file *filep,
 {
 	struct kfd_ioctl_get_dmabuf_info_args *args = data;
 	struct kfd_node *dev = NULL;
-	struct amdgpu_device *dmabuf_adev;
+	struct amdgpu_device *dmabuf_adev = NULL;
 	void *metadata_buffer = NULL;
-	uint32_t flags;
-	int8_t xcp_id;
+	uint32_t flags = 0;
+	int8_t xcp_id = 0;
 	unsigned int i;
-	int r;
+	int r = 0;
 
 	/* Find a KFD GPU device that supports the get_dmabuf_info query */
 	for (i = 0; kfd_topology_enum_kfd_devices(i, &dev) == 0; i++)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index e9cfb80bd436..43e97b5b3b5d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1059,7 +1059,7 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool suspend_proc)
 
 int kgd2kfd_resume(struct kfd_dev *kfd, bool resume_proc)
 {
-	int ret, i;
+	int ret = 0, i;
 
 	if (!kfd->init_complete)
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index d7a2e7178ea9..26f1d25538a4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -203,7 +203,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
 	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
 	struct mes_add_queue_input queue_input;
-	int r, queue_type;
+	int r = 0, queue_type;
 	uint64_t wptr_addr_off;
 
 	if (!dqm->sched_running || dqm->sched_halt)
@@ -273,7 +273,7 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 			struct qcm_process_device *qpd)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
-	int r;
+	int r = 0;
 	struct mes_remove_queue_input queue_input;
 
 	if (!dqm->sched_running || dqm->sched_halt)
@@ -624,7 +624,7 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
 				const void *restore_mqd, const void *restore_ctl_stack)
 {
 	struct mqd_manager *mqd_mgr;
-	int retval;
+	int retval = 0;
 
 	dqm_lock(dqm);
 
@@ -853,11 +853,9 @@ static int destroy_queue_nocpsch_locked(struct device_queue_manager *dqm,
 				struct qcm_process_device *qpd,
 				struct queue *q)
 {
-	int retval;
-	struct mqd_manager *mqd_mgr;
-
-	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
-			q->properties.type)];
+	int retval = 0;
+	struct mqd_manager *mqd_mgr =
+	  dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
 
 	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
 		deallocate_hqd(dqm, q);
@@ -912,7 +910,7 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
 				struct qcm_process_device *qpd,
 				struct queue *q)
 {
-	int retval;
+	int retval = 0;
 	uint64_t sdma_val = 0;
 	struct device *dev = dqm->dev->adev->dev;
 	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
@@ -1141,7 +1139,7 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
 	struct queue *q;
 	struct mqd_manager *mqd_mgr;
 	struct kfd_process_device *pdd;
-	int retval, ret = 0;
+	int retval = 0, ret = 0;
 
 	dqm_lock(dqm);
 	if (qpd->evicted++ > 0) /* already evicted, do nothing */
@@ -1266,7 +1264,7 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
 	struct kfd_process_device *pdd;
 	uint64_t pd_base;
 	uint64_t eviction_duration;
-	int retval, ret = 0;
+	int retval = 0, ret = 0;
 
 	pdd = qpd_to_pdd(qpd);
 	/* Retrieve PD base */
@@ -1443,13 +1441,12 @@ static int register_process(struct device_queue_manager *dqm,
 static int unregister_process(struct device_queue_manager *dqm,
 					struct qcm_process_device *qpd)
 {
-	int retval;
+	int retval = 0;
 	struct device_process_node *cur, *next;
 
 	pr_debug("qpd->queues_list is %s\n",
 			list_empty(&qpd->queues_list) ? "empty" : "not empty");
 
-	retval = 0;
 	dqm_lock(dqm);
 
 	list_for_each_entry_safe(cur, next, &dqm->queues, list) {
@@ -1479,7 +1476,7 @@ set_pasid_vmid_mapping(struct device_queue_manager *dqm, u32 pasid,
 			unsigned int vmid)
 {
 	uint32_t xcc_mask = dqm->dev->xcc_mask;
-	int xcc_id, ret;
+	int xcc_id, ret = 0;
 
 	for_each_inst(xcc_id, xcc_mask) {
 		ret = dqm->dev->kfd2kgd->set_pasid_vmid_mapping(
@@ -1831,8 +1828,6 @@ static int start_cpsch(struct device_queue_manager *dqm)
 	struct device *dev = dqm->dev->adev->dev;
 	int retval, num_hw_queue_slots;
 
-	retval = 0;
-
 	dqm_lock(dqm);
 
 	if (!dqm->dev->kfd->shared_resources.enable_mes) {
@@ -1981,7 +1976,7 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 			const struct kfd_criu_queue_priv_data *qd,
 			const void *restore_mqd, const void *restore_ctl_stack)
 {
-	int retval;
+	int retval = 0;
 	struct mqd_manager *mqd_mgr;
 
 	if (dqm->total_queue_count >= max_num_of_queues_per_device) {
@@ -2389,8 +2384,8 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 				bool reset)
 {
 	struct device *dev = dqm->dev->adev->dev;
-	struct mqd_manager *mqd_mgr;
-	int retval;
+	struct mqd_manager *mqd_mgr = NULL;
+	int retval = 0;
 
 	if (!dqm->sched_running)
 		return 0;
@@ -2784,7 +2779,7 @@ static int checkpoint_mqd(struct device_queue_manager *dqm,
 static int process_termination_cpsch(struct device_queue_manager *dqm,
 		struct qcm_process_device *qpd)
 {
-	int retval;
+	int retval = 0;
 	struct queue *q;
 	struct device *dev = dqm->dev->adev->dev;
 	struct kernel_queue *kq, *kq_next;
@@ -2794,8 +2789,6 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 		KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES;
 	bool found = false;
 
-	retval = 0;
-
 	dqm_lock(dqm);
 
 	/* Clean all kernel queues */
@@ -3464,7 +3457,6 @@ int suspend_queues(struct kfd_process *p,
 					else
 						per_device_suspended++;
 				} else if (err != -EBUSY) {
-					r = err;
 					queue_ids[q_idx] |= KFD_DBG_QUEUE_ERROR_MASK;
 					break;
 				}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index f2dee320fada..2e9b6bcf2704 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -596,7 +596,7 @@ static int hiq_load_mqd_kiq_v9_4_3(struct mqd_manager *mm, void *mqd,
 			struct queue_properties *p, struct mm_struct *mms)
 {
 	uint32_t xcc_mask = mm->dev->xcc_mask;
-	int xcc_id, err, inst = 0;
+	int xcc_id, err = 0, inst = 0;
 	void *xcc_mqd;
 	uint64_t hiq_mqd_size = kfd_hiq_mqd_stride(mm->dev);
 
@@ -620,7 +620,7 @@ static int destroy_hiq_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 			uint32_t pipe_id, uint32_t queue_id)
 {
 	uint32_t xcc_mask = mm->dev->xcc_mask;
-	int xcc_id, err, inst = 0;
+	int xcc_id, err = 0, inst = 0;
 	uint64_t hiq_mqd_size = kfd_hiq_mqd_stride(mm->dev);
 	struct v9_mqd *m;
 	u32 doorbell_off;
@@ -818,7 +818,7 @@ static int destroy_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 		   uint32_t pipe_id, uint32_t queue_id)
 {
 	uint32_t xcc_mask = mm->dev->xcc_mask;
-	int xcc_id, err, inst = 0;
+	int xcc_id, err = 0, inst = 0;
 	void *xcc_mqd;
 	struct v9_mqd *m;
 	uint64_t mqd_offset;
@@ -848,7 +848,7 @@ static int load_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 	/* AQL write pointer counts in 64B packets, PM4/CP counts in dwords. */
 	uint32_t wptr_shift = (p->format == KFD_QUEUE_FORMAT_AQL ? 4 : 0);
 	uint32_t xcc_mask = mm->dev->xcc_mask;
-	int xcc_id, err, inst = 0;
+	int xcc_id, err = 0, inst = 0;
 	void *xcc_mqd;
 	uint64_t mqd_stride_size = mm->mqd_stride(mm, p);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
index a1de5d7e173a..8321dd01b67a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
@@ -174,7 +174,6 @@ static int pm_map_queues_vi(struct packet_manager *pm, uint32_t *buffer,
 	case KFD_QUEUE_TYPE_SDMA_XGMI:
 		packet->bitfields2.engine_sel = q->properties.sdma_engine_id +
 				engine_sel__mes_map_queues__sdma0_vi;
-		use_static = false; /* no static queues under SDMA */
 		break;
 	default:
 		WARN(1, "queue type %d", q->properties.type);
-- 
2.43.0

