Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E09C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 08:48:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF0A6109E
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 08:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9FF0A6109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54EA16ECF8;
	Fri, 15 Oct 2021 08:48:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C3416ECF8
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 08:48:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTmSbWmM8VUO+KImQoTE+iTtPWktwsHXLfZ8gxmtJFMyf2OrVwFlo5J+8Vrwb1BH/YB21vYSgrDzfs5pqXH4QS8AE50BQwEmRkIdVu1+TqTHbh03flA4M+1EbknHCgE1NCijOrSnBIP6ZJp+2depFmVHAiXuOWs2dWhQ/4hXST0gcI1Fm31LqG6RTylsd5IfN1Q2PaV4vglkLZ1PlpJiQfnxpUc8yNHed4hkG5Mk74t06idiePINLqbL1lm24y9QBddtwVhtpGRLfZKOVAAq2Bxd5A7PkfXgV6im91qyBbLDPLa7yyudCh2pEqjG/qSTwSXRtfRVIMxixwOB/jSFsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gV1TRiEW20VF/qe7NT0oSrzAQnbAIgzGiGKG7PMhFJQ=;
 b=WWGNje5+6E2QUdyIhUGExc5RlSDP6re/8bCvoKJCl93IGTWBNv/ksLkmuOZ18pKfxVQd+FcQ0HbyalZkZhjYpAutIOOnCS+FLn6ucZgdcGRvuah3ot9L9AO9CKunja6x89N8baNdqdWZRB41SwMF4XDNr00Fpnc1Nyrjtr0EzgJfELqKdtcy/KmmDN405XwbgayU86ueJfvL7XOtWO+0izD4qL3YNRPQp4bMLCC0Ndhobo7thjQMjPlqg7FeAH2dkWmonNm4TjpOAe5E62baYnslOJgATbMlPT6Yg+7Z3S+VOxAdtM7xbO3m7ObFqCMRq3zpuHgzPmmll+iXNygmTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gV1TRiEW20VF/qe7NT0oSrzAQnbAIgzGiGKG7PMhFJQ=;
 b=yTyW+ZHWALWLgza7gedafxmoNBkRhRmTTDLzgXNsyZOEuDRFCBPM4k5r6ViYBKvDBWACN+r6uySw3sTwxz3qyEvdoapvhBnFk14gphOc853ijftpti+iXKA53Ob8wPuaDvlPuybtTX1v2iaiTxxciSSfepbLzuwHZjweUhZTSes=
Received: from DS7PR03CA0323.namprd03.prod.outlook.com (2603:10b6:8:2b::12) by
 MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16; Fri, 15 Oct 2021 08:48:36 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::6a) by DS7PR03CA0323.outlook.office365.com
 (2603:10b6:8:2b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Fri, 15 Oct 2021 08:48:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 08:48:36 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 03:48:33 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>, Lang Yu
 <lang.yu@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: Remove cu mask from struct queue_properties
Date: Fri, 15 Oct 2021 16:48:07 +0800
Message-ID: <20211015084807.2062053-2-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015084807.2062053-1-lang.yu@amd.com>
References: <20211015084807.2062053-1-lang.yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04ebe57c-39a5-40e2-0c7e-08d98fb8937f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4269:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4269EFD97E8CFD22CB692F4DFBB99@MN2PR12MB4269.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0WVjVTJpt75BdTg3D4U8Ftp124OQT7rMKe5wUHnJpNi/MBzcXGe1xcQjctTe7KYP/a5UF4d46CAkk3TXNOQR1P/2eNOXbQWyeuoRHREo3JCpg9LTB6WTyiXGwhf8yo/mzsHnzVKf7Hj4QfL55PFBIOfgFMALDbpdSzjYoSFiHoolgYt/O4C3roHaepsAC3av4cx5SQCUDSc5wPgRbniGFZIC52EB5K7KwAxZWb187hy701t6Gqht9Y0wFBg4M4WlWKGxXGwcQ9d36BS1ps+cQobsHm9zH6IX2O84jtC+qNmqsDyc9W35W2ReRUUa47GYdR/N28pVivAxOZJybF/gTxb/CJmSfk4YvfcpNLvaw6O9oyLzEcYI5L0sXV4p4BE4aqMII7WBKQodF3TLowORY93+wFhLi99eDL/VY6PhoGGWmSl0DZGI0JcaS/gsoxLRW3hRrJ2XyeaCyGwZ97NfPcVO5Vuo9lM+QHnCTTcrB1f1kNmt84yWHSQsT1Xo1LHwJxH/xLbxtjjVY7iEtHk8flyHZxOPhcORRHAxEcKUYiNABm8zxGPP353wHPzyET6k0ceQgGJ1ERFEQyaQa6f0a6AwzpD/VQrMp9CSm8XI8labpEHBId4HweUwJiRp8XGNidIVj0YlFIOjHLYIh7Q7ScULKUyrC23BjKJrw1Iq/aPSVfQgQR6Y8R311cMyk5edGCahek080Njmqz144u5zMq5+TubaF3SjLp7X+IHEk8U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(4326008)(26005)(47076005)(82310400003)(316002)(356005)(70586007)(70206006)(6666004)(81166007)(1076003)(7696005)(6916009)(54906003)(30864003)(336012)(83380400001)(508600001)(5660300002)(86362001)(44832011)(2906002)(426003)(2616005)(36860700001)(36756003)(8676002)(186003)(8936002)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 08:48:36.0217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ebe57c-39a5-40e2-0c7e-08d98fb8937f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
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

Actually, cu_mask has been copied to mqd memory and
don't have to persist in queue_properties. Remove it
from queue_properties.

Use struct queue_update_info to wrap queue_properties
and cu mask, then pass it to update queue operation.

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 41 +++++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |  1 -
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  | 10 ++--
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  | 10 ++--
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 10 ++--
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   | 10 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         | 22 ++++++--
 .../amd/amdkfd/kfd_process_queue_manager.c    | 56 ++++++-------------
 8 files changed, 80 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 9317a2e238d0..baa5de9dd361 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -371,7 +371,7 @@ static int kfd_ioctl_update_queue(struct file *filp, struct kfd_process *p,
 {
 	int retval;
 	struct kfd_ioctl_update_queue_args *args = data;
-	struct queue_properties properties;
+	struct queue_update_info qinfo = {0};
 
 	if (args->queue_percentage > KFD_MAX_QUEUE_PERCENTAGE) {
 		pr_err("Queue percentage must be between 0 to KFD_MAX_QUEUE_PERCENTAGE\n");
@@ -395,17 +395,18 @@ static int kfd_ioctl_update_queue(struct file *filp, struct kfd_process *p,
 		return -EINVAL;
 	}
 
-	properties.queue_address = args->ring_base_address;
-	properties.queue_size = args->ring_size;
-	properties.queue_percent = args->queue_percentage;
-	properties.priority = args->queue_priority;
+	qinfo.properties.queue_address = args->ring_base_address;
+	qinfo.properties.queue_size = args->ring_size;
+	qinfo.properties.queue_percent = args->queue_percentage;
+	qinfo.properties.priority = args->queue_priority;
+	qinfo.update_flag = UPDATE_FLAG_PROPERTITY;
 
 	pr_debug("Updating queue id %d for pasid 0x%x\n",
 			args->queue_id, p->pasid);
 
 	mutex_lock(&p->mutex);
 
-	retval = pqm_update_queue(&p->pqm, args->queue_id, &properties);
+	retval = pqm_update_queue(&p->pqm, args->queue_id, &qinfo);
 
 	mutex_unlock(&p->mutex);
 
@@ -418,7 +419,7 @@ static int kfd_ioctl_set_cu_mask(struct file *filp, struct kfd_process *p,
 	int retval;
 	const int max_num_cus = 1024;
 	struct kfd_ioctl_set_cu_mask_args *args = data;
-	struct queue_properties properties;
+	struct queue_update_info qinfo = {0};
 	uint32_t __user *cu_mask_ptr = (uint32_t __user *)args->cu_mask_ptr;
 	size_t cu_mask_size = sizeof(uint32_t) * (args->num_cu_mask / 32);
 
@@ -428,8 +429,8 @@ static int kfd_ioctl_set_cu_mask(struct file *filp, struct kfd_process *p,
 		return -EINVAL;
 	}
 
-	properties.cu_mask_count = args->num_cu_mask;
-	if (properties.cu_mask_count == 0) {
+	qinfo.cu_mask.count = args->num_cu_mask;
+	if (qinfo.cu_mask.count == 0) {
 		pr_debug("CU mask cannot be 0");
 		return -EINVAL;
 	}
@@ -438,31 +439,33 @@ static int kfd_ioctl_set_cu_mask(struct file *filp, struct kfd_process *p,
 	 * limit of max_num_cus bits.  We can then just drop any CU mask bits
 	 * past max_num_cus bits and just use the first max_num_cus bits.
 	 */
-	if (properties.cu_mask_count > max_num_cus) {
+	if (qinfo.cu_mask.count > max_num_cus) {
 		pr_debug("CU mask cannot be greater than 1024 bits");
-		properties.cu_mask_count = max_num_cus;
+		qinfo.cu_mask.count = max_num_cus;
 		cu_mask_size = sizeof(uint32_t) * (max_num_cus/32);
 	}
 
-	properties.cu_mask = kzalloc(cu_mask_size, GFP_KERNEL);
-	if (!properties.cu_mask)
+	qinfo.cu_mask.ptr = kzalloc(cu_mask_size, GFP_KERNEL);
+	if (!qinfo.cu_mask.ptr)
 		return -ENOMEM;
 
-	retval = copy_from_user(properties.cu_mask, cu_mask_ptr, cu_mask_size);
+	retval = copy_from_user(qinfo.cu_mask.ptr, cu_mask_ptr, cu_mask_size);
 	if (retval) {
 		pr_debug("Could not copy CU mask from userspace");
-		kfree(properties.cu_mask);
-		return -EFAULT;
+		retval = -EFAULT;
+		goto out;
 	}
 
+	qinfo.update_flag = UPDATE_FLAG_CU_MASK;
+
 	mutex_lock(&p->mutex);
 
-	retval = pqm_set_cu_mask(&p->pqm, args->queue_id, &properties);
+	retval = pqm_update_queue(&p->pqm, args->queue_id, &qinfo);
 
 	mutex_unlock(&p->mutex);
 
-	if (retval)
-		kfree(properties.cu_mask);
+out:
+	kfree(qinfo.cu_mask.ptr);
 
 	return retval;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index a2b77d1df854..64b4ac339904 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -136,7 +136,6 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_dev *dev,
 	prop.write_ptr = (uint32_t *) kq->wptr_gpu_addr;
 	prop.eop_ring_buffer_address = kq->eop_gpu_addr;
 	prop.eop_ring_buffer_size = PAGE_SIZE;
-	prop.cu_mask = NULL;
 
 	if (init_queue(&kq->queue, &prop) != 0)
 		goto err_init_queue;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
index 8bb2fd4cba41..9b3bb8c5b41d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
@@ -42,16 +42,18 @@ static inline struct cik_sdma_rlc_registers *get_sdma_mqd(void *mqd)
 }
 
 static void update_cu_mask(struct mqd_manager *mm, void *mqd,
-			struct queue_properties *q)
+			void *args)
 {
 	struct cik_mqd *m;
 	uint32_t se_mask[4] = {0}; /* 4 is the max # of SEs */
+	struct queue_update_info *qinfo = args;
 
-	if (q->cu_mask_count == 0)
+	if (!qinfo || (qinfo->update_flag != UPDATE_FLAG_CU_MASK) ||
+	    !qinfo->cu_mask.ptr)
 		return;
 
 	mqd_symmetrically_map_cu_mask(mm,
-		q->cu_mask, q->cu_mask_count, se_mask);
+		qinfo->cu_mask.ptr, qinfo->cu_mask.count, se_mask);
 
 	m = get_mqd(mqd);
 	m->compute_static_thread_mgmt_se0 = se_mask[0];
@@ -214,7 +216,7 @@ static void __update_mqd(struct mqd_manager *mm, void *mqd,
 	if (q->format == KFD_QUEUE_FORMAT_AQL)
 		m->cp_hqd_pq_control |= NO_UPDATE_RPTR;
 
-	update_cu_mask(mm, mqd, q);
+	update_cu_mask(mm, mqd, args);
 	set_priority(m, q);
 
 	q->is_active = QUEUE_IS_ACTIVE(*q);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 6d468b6c8d7d..2f6c285caf70 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -42,16 +42,18 @@ static inline struct v10_sdma_mqd *get_sdma_mqd(void *mqd)
 }
 
 static void update_cu_mask(struct mqd_manager *mm, void *mqd,
-			   struct queue_properties *q)
+			   void *args)
 {
 	struct v10_compute_mqd *m;
 	uint32_t se_mask[4] = {0}; /* 4 is the max # of SEs */
+	struct queue_update_info *qinfo = args;
 
-	if (q->cu_mask_count == 0)
+	if (!qinfo || (qinfo->update_flag != UPDATE_FLAG_CU_MASK) ||
+	    !qinfo->cu_mask.ptr)
 		return;
 
 	mqd_symmetrically_map_cu_mask(mm,
-		q->cu_mask, q->cu_mask_count, se_mask);
+		qinfo->cu_mask.ptr, qinfo->cu_mask.count, se_mask);
 
 	m = get_mqd(mqd);
 	m->compute_static_thread_mgmt_se0 = se_mask[0];
@@ -218,7 +220,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	if (mm->dev->cwsr_enabled)
 		m->cp_hqd_ctx_save_control = 0;
 
-	update_cu_mask(mm, mqd, q);
+	update_cu_mask(mm, mqd, args);
 	set_priority(m, q);
 
 	q->is_active = QUEUE_IS_ACTIVE(*q);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index f6c10b1b5f8b..a95d061458b9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -43,16 +43,18 @@ static inline struct v9_sdma_mqd *get_sdma_mqd(void *mqd)
 }
 
 static void update_cu_mask(struct mqd_manager *mm, void *mqd,
-			struct queue_properties *q)
+			void *args)
 {
 	struct v9_mqd *m;
 	uint32_t se_mask[KFD_MAX_NUM_SE] = {0};
+	struct queue_update_info *qinfo = args;
 
-	if (q->cu_mask_count == 0)
+	if (!qinfo || (qinfo->update_flag != UPDATE_FLAG_CU_MASK) ||
+	    !qinfo->cu_mask.ptr)
 		return;
 
 	mqd_symmetrically_map_cu_mask(mm,
-		q->cu_mask, q->cu_mask_count, se_mask);
+		qinfo->cu_mask.ptr, qinfo->cu_mask.count, se_mask);
 
 	m = get_mqd(mqd);
 	m->compute_static_thread_mgmt_se0 = se_mask[0];
@@ -269,7 +271,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	if (mm->dev->cwsr_enabled && q->ctx_save_restore_area_address)
 		m->cp_hqd_ctx_save_control = 0;
 
-	update_cu_mask(mm, mqd, q);
+	update_cu_mask(mm, mqd, args);
 	set_priority(m, q);
 
 	q->is_active = QUEUE_IS_ACTIVE(*q);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index bddd6d8fdf32..fc9fdbb29a30 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -45,16 +45,18 @@ static inline struct vi_sdma_mqd *get_sdma_mqd(void *mqd)
 }
 
 static void update_cu_mask(struct mqd_manager *mm, void *mqd,
-			struct queue_properties *q)
+			void *args)
 {
 	struct vi_mqd *m;
 	uint32_t se_mask[4] = {0}; /* 4 is the max # of SEs */
+	struct queue_update_info *qinfo = args;
 
-	if (q->cu_mask_count == 0)
+	if (!qinfo || (qinfo->update_flag != UPDATE_FLAG_CU_MASK) ||
+	    !qinfo->cu_mask.ptr)
 		return;
 
 	mqd_symmetrically_map_cu_mask(mm,
-		q->cu_mask, q->cu_mask_count, se_mask);
+		qinfo->cu_mask.ptr, qinfo->cu_mask.count, se_mask);
 
 	m = get_mqd(mqd);
 	m->compute_static_thread_mgmt_se0 = se_mask[0];
@@ -230,7 +232,7 @@ static void __update_mqd(struct mqd_manager *mm, void *mqd,
 			atc_bit << CP_HQD_CTX_SAVE_CONTROL__ATC__SHIFT |
 			mtype << CP_HQD_CTX_SAVE_CONTROL__MTYPE__SHIFT;
 
-	update_cu_mask(mm, mqd, q);
+	update_cu_mask(mm, mqd, args);
 	set_priority(m, q);
 
 	q->is_active = QUEUE_IS_ACTIVE(*q);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 30f08f1606bb..fa7cb8bad0da 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -472,9 +472,6 @@ struct queue_properties {
 	uint32_t ctl_stack_size;
 	uint64_t tba_addr;
 	uint64_t tma_addr;
-	/* Relevant for CU */
-	uint32_t cu_mask_count; /* Must be a multiple of 32 */
-	uint32_t *cu_mask;
 };
 
 #define QUEUE_IS_ACTIVE(q) ((q).queue_size > 0 &&	\
@@ -482,6 +479,23 @@ struct queue_properties {
 			    (q).queue_percent > 0 &&	\
 			    !(q).is_evicted)
 
+enum queue_update_flag {
+	UPDATE_FLAG_PROPERTITY = 0,
+	UPDATE_FLAG_CU_MASK,
+};
+
+struct queue_update_info {
+	union {
+		struct queue_properties properties;
+		struct {
+			uint32_t count; /* Must be a multiple of 32 */
+			uint32_t *ptr;
+		} cu_mask;
+	};
+
+	enum queue_update_flag update_flag;
+};
+
 /**
  * struct queue
  *
@@ -1035,7 +1049,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			    uint32_t *p_doorbell_offset_in_process);
 int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid);
 int pqm_update_queue(struct process_queue_manager *pqm, unsigned int qid,
-			struct queue_properties *p);
+			void *args);
 int pqm_set_cu_mask(struct process_queue_manager *pqm, unsigned int qid,
 			struct queue_properties *p);
 int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 37529592457d..cc81fb36d278 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -394,8 +394,6 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 			pdd->qpd.num_gws = 0;
 		}
 
-		kfree(pqn->q->properties.cu_mask);
-		pqn->q->properties.cu_mask = NULL;
 		uninit_queue(pqn->q);
 	}
 
@@ -412,35 +410,14 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 }
 
 int pqm_update_queue(struct process_queue_manager *pqm, unsigned int qid,
-			struct queue_properties *p)
+			void *args)
 {
-	int retval;
+	int retval = 0;
 	struct process_queue_node *pqn;
+	struct queue_update_info *qinfo = args;
 
-	pqn = get_queue_by_qid(pqm, qid);
-	if (!pqn) {
-		pr_debug("No queue %d exists for update operation\n", qid);
-		return -EFAULT;
-	}
-
-	pqn->q->properties.queue_address = p->queue_address;
-	pqn->q->properties.queue_size = p->queue_size;
-	pqn->q->properties.queue_percent = p->queue_percent;
-	pqn->q->properties.priority = p->priority;
-
-	retval = pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
-							pqn->q, NULL);
-	if (retval != 0)
-		return retval;
-
-	return 0;
-}
-
-int pqm_set_cu_mask(struct process_queue_manager *pqm, unsigned int qid,
-			struct queue_properties *p)
-{
-	int retval;
-	struct process_queue_node *pqn;
+	if (!qinfo)
+		return -EINVAL;
 
 	pqn = get_queue_by_qid(pqm, qid);
 	if (!pqn) {
@@ -448,20 +425,19 @@ int pqm_set_cu_mask(struct process_queue_manager *pqm, unsigned int qid,
 		return -EFAULT;
 	}
 
-	/* Free the old CU mask memory if it is already allocated, then
-	 * allocate memory for the new CU mask.
-	 */
-	kfree(pqn->q->properties.cu_mask);
-
-	pqn->q->properties.cu_mask_count = p->cu_mask_count;
-	pqn->q->properties.cu_mask = p->cu_mask;
-
-	retval = pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
+	if (qinfo->update_flag == UPDATE_FLAG_PROPERTITY) {
+		pqn->q->properties.queue_address = qinfo->properties.queue_address;
+		pqn->q->properties.queue_size = qinfo->properties.queue_size;
+		pqn->q->properties.queue_percent = qinfo->properties.queue_percent;
+		pqn->q->properties.priority = qinfo->properties.priority;
+		retval = pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
 							pqn->q, NULL);
-	if (retval != 0)
-		return retval;
+	} else {
+		retval = pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
+							pqn->q, qinfo);
+	}
 
-	return 0;
+	return retval;
 }
 
 struct kernel_queue *pqm_get_kernel_queue(
-- 
2.25.1

