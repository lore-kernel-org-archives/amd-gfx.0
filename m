Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAF2CE8D6B
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Nov 2025 21:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EC9B89101;
	Mon, 17 Nov 2025 21:04:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o0n20y4l";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5582010E1CC
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Nov 2025 21:04:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8e6zhwMPyq/Kt7hvosqhLBh8htmygzNAUkyWah+oOtoEus7bq9WIRM8ncGlfTGpd/OmdzDXnwwYzQzcVZSFTY3vxFuhSyCDXz31dtsJgeANBjVy45xgkogMT1R74kimIQXPP9OTAVCuqFx5g6t1txB8rPRCBqwZHMyZ9ZZrd8f9mFkS3bCSd1mwbG/+f69ttkFrE+lqe2EVmgqf55osvluCsPdmf5+eyfX1Weki6bC6x+rt9Hmjmmc/SeumbSro5zuVhsycjLQiRpbN0FC298ZD/fksUquChcKi9JrB0ApvJkIcEh2aV42s3n0lgVkEmvU9RbO3RJkTEcC4486VnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjTuUTvPftX9vAsXwyGTbarkrZ5x0qGd0CNbuzS8I9I=;
 b=XZWojAFcFWdmukOn0J1aJIGmBOvU4SYLcvnbXWBDL2TpZYHgtW4i4azXHLVWfL/Kr1DtEepPC5YoEqravtKlvZqgpXD+CcPX43Y6f3K9XxSobQZigrO8HSEtt4dCNIBUDf0LbQL6F7M2rhuGSYK6cXmXp6+cVZmErpUWEfzrwrfmeSEUdWWK2THeNK1qDRmL5Ci7QPMCSnEb/T7VFD/cTVuOdIeNWbDmapVk0HlRY3yxlNIpzOtjldBcHT6UcwDfsQlnawJdVY3/lqIih7FV+TCbsdEumkBAcuyJmFK+cCq1YQELHa4XduBI+N+NbD+WFhntX6dttMUgUM9MXGlyuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjTuUTvPftX9vAsXwyGTbarkrZ5x0qGd0CNbuzS8I9I=;
 b=o0n20y4lWahShhoVMHw2PqL/Y8aY6TUc/kwuP07o/OtoFtgb2SWEzj3582drIyzZDIzKTteeVZeSz2F55LBpfxR0zevHxgVOmJ7ezb/4QgqzKmjqXfQDYCpTWjjOyawyLgvvqsetbMEMozKF1hoRP8SuVaPC70gAUvJxEy44tsg=
Received: from SA0PR11CA0110.namprd11.prod.outlook.com (2603:10b6:806:d1::25)
 by SJ5PPFABE38415D.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::99e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 21:04:19 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:d1:cafe::18) by SA0PR11CA0110.outlook.office365.com
 (2603:10b6:806:d1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 21:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 21:04:19 +0000
Received: from amartin-dev-ubuntu.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 17 Nov 2025 13:04:18 -0800
From: Andrew Martin <andrew.martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Andrew Martin <andrew.martin@amd.com>
Subject: [PATCH v2] drm/amdkfd: Uninitialized and Unused variables
Date: Mon, 17 Nov 2025 16:04:02 -0500
Message-ID: <20251117210402.2213429-1-andrew.martin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|SJ5PPFABE38415D:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d5195b6-798b-431a-9631-08de261ce012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8LUcRRRW0FBpMdwI0ULKTlxJsZBqPeljZ5U6kQC+kGoGMZDbxclSlYfwtRVA?=
 =?us-ascii?Q?WUiWoo73rVXkra7f4pfBaNohYMP9fGR7kaAoe4p5PaTlE84lOjzcNXTY5xs5?=
 =?us-ascii?Q?bS282G4ts4EQK46BNJblZIoqPC5JDxumymabcF621KDSZ9ZF9u7rR4pJd+kz?=
 =?us-ascii?Q?gWMVHZbIssu0v2jZtin2xdC7DfNWjDEtxc2Lw4tjeqCB0aQGuzimGfGuKhzD?=
 =?us-ascii?Q?fP79L8YGvU6msn4LArcuDD3GSyN4QaUAmM8q9nqbFoi7EhyrAadvaPSHzn5M?=
 =?us-ascii?Q?JSkb4BHJAuGkFPUipgZUAMOq2xlZ0SbbjjqrWv3E2t4r98xD3boeIgMXnQgn?=
 =?us-ascii?Q?Yphdx+a6pCaPfJt5xYJCzrry5+h4t7cXCW8+za9UULalD7C8cNWV1TFZ2nEV?=
 =?us-ascii?Q?METtILe56u+wSnkvNDd6WT+Rvc4taUBOSodCR6weNv941mLRt2UjdzfUkklk?=
 =?us-ascii?Q?fLnc7psI/G/Ej/8qxOJcuvc7bm7Z68eZBrhgDnwWvGluez94SDYNwhjqOsEH?=
 =?us-ascii?Q?cetUDzcqc84Hw73Q3a/FOgxs6Y9N2fJQHKd30x2ycKGACsJr7EBybCDUgDvj?=
 =?us-ascii?Q?Jzgbf2vvJNXNZebg+Kk/bXfTdw32/wSmZlch/aDR6KiA4fMRonUHUD5ScRK5?=
 =?us-ascii?Q?xuLj0S2RJzrKWBCIxBArFtF8llOpFLO6qMfQnRHxvHBqYp9IFVAV4Y9+KWeQ?=
 =?us-ascii?Q?RxQBwS6OuwVsb3umGkz3s1/x8eqDJvEi8HdRutan991uOMpVaivVxBeBS8QO?=
 =?us-ascii?Q?oy0UGDCkUy+78ycDn+l+BZ1otw6NsZrrqrpzrhsjSuboKKTQmGxgEXzI4a/N?=
 =?us-ascii?Q?X8X7/Vd14nJ+geJsHHEsD74EWLFYS0A8djQRvqz0foiuSAS7v1psbXQ4k5EW?=
 =?us-ascii?Q?k6bMyZrSKW2no4uRqxWKk9KFQYt8vaVqBOv+UXz0nhrMYVMmrB7vqba7+P7O?=
 =?us-ascii?Q?5Y374c+pz2VoAES2PTbn4wjTXjN4iC5+OHptvSCpb+xLxSCCHkzmsFh0xrKf?=
 =?us-ascii?Q?wk1ByvzJ8vcuejiFXCgB4uu07qVkh60jgyui/dW1sJnSPNRvIMUoTbW9Kq87?=
 =?us-ascii?Q?zSGOChs5LIsMYY83uUhYgJD7CoBGzW9RiNAluyXBe+uweSkrJ7W8dpVmh6cS?=
 =?us-ascii?Q?97yYLZFU6CC0OxGQopNQ0SVA+rHTQAE7uBUnrbTzDRmOBVaik5AvxZR+EdL6?=
 =?us-ascii?Q?lDOBz8TdJCPoPUOj5EXofS9UzxJas19C4LCDHexnDnQbEfLTIO8G7ZyjB4XR?=
 =?us-ascii?Q?6ki2uO59mAO7KiXTFllcCvdoJ+opdUKSaFU8DfhWgczixgCmaD9Yl2dZJDBp?=
 =?us-ascii?Q?9x/tawSw/xXOufI2IpK6Cf4gCJ11rA0q8R5Nlq0ExrOilEpqNZhcoly5QvyF?=
 =?us-ascii?Q?d6uOXlhIIwDH1mnP6g8ztgfEzoR3nyrUeSv8y8AfJNrQ3oEJEj0X6ykbhm9k?=
 =?us-ascii?Q?ECeFCRoHhfXZMmYgl1cDezdeVxmFiwMDHXK9aH2zpWAQGTgNI1h2AYJBk6rJ?=
 =?us-ascii?Q?EnwFN0vvS9CKb87Jy6hAAl+0pRC3qIAkubReEihN2Vz4npu8OQTm/l3JYmux?=
 =?us-ascii?Q?KSP4L+twKRsLAam3wQc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 21:04:19.2797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5195b6-798b-431a-9631-08de261ce012
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFABE38415D
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
 drivers/gpu/drm/amd/amdkfd/kfd_device.c         |  2 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c   | 17 +++++------------
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c |  8 ++++----
 .../gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c  |  1 -
 4 files changed, 10 insertions(+), 18 deletions(-)

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
index d7a2e7178ea9..57b3f7c7f422 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -624,7 +624,7 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
 				const void *restore_mqd, const void *restore_ctl_stack)
 {
 	struct mqd_manager *mqd_mgr;
-	int retval;
+	int retval = 0;
 
 	dqm_lock(dqm);
 
@@ -856,8 +856,7 @@ static int destroy_queue_nocpsch_locked(struct device_queue_manager *dqm,
 	int retval;
 	struct mqd_manager *mqd_mgr;
 
-	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
-			q->properties.type)];
+	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
 
 	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
 		deallocate_hqd(dqm, q);
@@ -1443,13 +1442,12 @@ static int register_process(struct device_queue_manager *dqm,
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
@@ -1479,7 +1477,7 @@ set_pasid_vmid_mapping(struct device_queue_manager *dqm, u32 pasid,
 			unsigned int vmid)
 {
 	uint32_t xcc_mask = dqm->dev->xcc_mask;
-	int xcc_id, ret;
+	int xcc_id, ret = 0;
 
 	for_each_inst(xcc_id, xcc_mask) {
 		ret = dqm->dev->kfd2kgd->set_pasid_vmid_mapping(
@@ -1831,8 +1829,6 @@ static int start_cpsch(struct device_queue_manager *dqm)
 	struct device *dev = dqm->dev->adev->dev;
 	int retval, num_hw_queue_slots;
 
-	retval = 0;
-
 	dqm_lock(dqm);
 
 	if (!dqm->dev->kfd->shared_resources.enable_mes) {
@@ -2784,7 +2780,7 @@ static int checkpoint_mqd(struct device_queue_manager *dqm,
 static int process_termination_cpsch(struct device_queue_manager *dqm,
 		struct qcm_process_device *qpd)
 {
-	int retval;
+	int retval = 0;
 	struct queue *q;
 	struct device *dev = dqm->dev->adev->dev;
 	struct kernel_queue *kq, *kq_next;
@@ -2794,8 +2790,6 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 		KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES;
 	bool found = false;
 
-	retval = 0;
-
 	dqm_lock(dqm);
 
 	/* Clean all kernel queues */
@@ -3464,7 +3458,6 @@ int suspend_queues(struct kfd_process *p,
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

