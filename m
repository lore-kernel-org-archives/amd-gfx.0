Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B39606A320
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qlKxfxkw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47890112837;
	Fri, 30 Oct 2026 14:06:22 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A369112830
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 14:06:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b11Em4YqUYpa8v3c5nszn0Xce3SN9eBuK60JW1ljfVex8tHSSPbNP53u6AqkKhmSty8L2kBooC77Wlv2QBH9X1ORLm88/Q29lZ47n5pCTVtpnr7tLUrrDzX8r1ah7QLyEnYe4DLfrwQOImaIkLb4pKnlqp8x5len5YlQ358wUBhNcZO+l2wGaPiqbCRgo8WKim0o+RPpbUh8YkQ4OzlcZDap2VtJ3HnFKWQG1UlLgMTJSTuhxDOxo8gA6S6nKemQ5mGBYP9MsiScxqSv+cteEDEX64Ix72Zn8P+4Z9Ia9D0S3m8kyfVh233LA3OivDEGq3xqgPHaQ6NZAUteexNnHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6rcLCxzWUQuR/ROPPmxjSPlUMkNjloAqgONl4cwsJ8=;
 b=Fr/y/ZfhpbPKRtFxT9LjydjmnUE/HixOlDCZrtPmQ1jRdeBRcrnM6aTJN4u9g/U6nhYMFhLEsTwxMXxzCaCXDDuLjIHxfZ0wnmYzvBiyq2KOuK7tG34jrHJBoSl6rgkiEKsw3q94t6cH65FAlUdchZ6tChqy73CW4B+NxKuRRtPwkqSl2Jh8hcUWtv/Gh4o0Xz/XsmdI/UhtWJTCxwBc6jd3s5npL1izyuDOt2edXsQud50TUUcWB+eYlW56WVMbQlOhzaMpGb5ny69gRYB/46NbnpyPhF9QVOtKQAh/3AJxSUX+pAJwrEEIoR5wvK6p4PCncFexpqmNICGe+TVT7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6rcLCxzWUQuR/ROPPmxjSPlUMkNjloAqgONl4cwsJ8=;
 b=qlKxfxkwP3CpVFufEKCQZY/rkygTlXlm2E0uHPRz+4xzADJHDH+OBYjHgfF1TGOr/OzIBecQ1y7QnXiBU71coE7U1R8dn1Qw1Ml8+cL99/E38DNCib7ZrKrueBOzsBSK28uxMpqmKe9+soEQ1Qr1Z0cL0QqzrrWGgNtJ70U1OjI=
Received: from SJ0PR03CA0287.namprd03.prod.outlook.com (2603:10b6:a03:39e::22)
 by DS0PR12MB8453.namprd12.prod.outlook.com (2603:10b6:8:157::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 14:06:09 +0000
Received: from BY1PEPF000264AF.namprd02.prod.outlook.com
 (2603:10b6:a03:39e:cafe::70) by SJ0PR03CA0287.outlook.office365.com
 (2603:10b6:a03:39e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.10 via Frontend Transport; Fri,
 30 Oct 2026 14:06:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264AF.mail.protection.outlook.com (10.167.242.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 14:06:09 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 09:06:08 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, David Francis
 <David.Francis@amd.com>
Subject: [PATCH v2 2/3] drm/amdkfd: Get reference to svm queue buffers during
 CRIU resume
Date: Fri, 30 Oct 2026 10:05:49 -0400
Message-ID: <20261030140550.2524662-3-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030140550.2524662-1-David.Francis@amd.com>
References: <20261030140550.2524662-1-David.Francis@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264AF:EE_|DS0PR12MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b0b702-a0fc-4c4e-5d25-08df368ef29e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|11063799006|56012099006|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261021123027099003|261022075727099003|261022105027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: FubkzoLV7mPfwek7wtLGo1c+KVCR4dqm1LVf8Oi3GnQEX+Wr5ZcPdqyGZjYMvkdey3JgfA8SgzJ429tYilaa2i/pUXwNdsfYvvF11CtujNS+wLOJM1hSKmCMVA0YIZhpCTtDGFC+t9s7DeuITfKfzAWUNW9/CgEYMdU18SSH6m5NKRFp2tj5ShODyD4+qEDt+zuiaIXpggRu4QFamq4/cWA7ZJT3BsSBAMDKeGp6Kzymea45SFXaIzMI3X0ZmruU/AITEB9MZPfxn3owxL6+eiOLz3S3PuWSp561Oq3QQyQSV/rO5QkcvyReDm0nsPKUsT9QvZnn96UkIl06VAHZg5WJQXjOwD9ou8qNVfI4/8UPZ2SeMeAdllGfsOmfnHTn/tPkYcE1M/RtI9G4YhoUre4fkiIM4Q7lF5+/6wmxXd5ap4RQE58so8OFmkxSmFOxMiKWWc8zcOzcQvU+0gg9HyWUVUNWLAsnTe14EByNmTA32uZ0iupQfDKCzyNhNFT5JQox+9KToAvyla/OTWb6w8x+C00rkE7fV9CMAlxhpzjkg+iCmYn1u4ODgMyozIOV3cSV8sY/J5zeEswpRRPRJ3018yRIJvBnbjFcNyV2lyvl+47B1hB4pABhPymz559UU8/OF7Gp54/nWVqen4MPpix8aYrjNSOP0DQphAGxFA3lKDYLwfWh1Gl93tZdhf23ngm2jYoQh+/LRm+3hlD+3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cYghyHkEcORZLL42PJwd7isg73d2C73JMZSn2ZSR1w7gmr+4iYxpVv3k+t9J8fGYLrWw2hrGtnsSE3JwOJHgWx5tCtxJPCBcGqZZzCC+kx/pXeDSwoSvM+Z52O0D7QvR5ZSzKG3bhw7IQwASDl5mTNMVQvU5LlNbTW0ch74M2t4oVKHRCF3/t7woo2U9SU9ELEVsxX+jS03PcnQlBPEuc+Y7YthbLUcjrCIeI5V2zVJw/dZ6wfxMyDYW89V0kY7BRH0cV0tQwFVPqy8qvShCErLcWA4RpgUopKCZmrhE49odV4JdeHFMTWRb5N15gzfqEFa1VogyEv0BcNZexHGhPYFOHkp2syUsT2IqnBxhV0/sPpcr1PmBvE9wLrkudHMP+pmMBMWJAbIyAJPC8/G+0wPDq+bcFFASrckQxXqj2f0ePV8cfVZWvbDsZEMYRryC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:06:09.2357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b0b702-a0fc-4c4e-5d25-08df368ef29e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264AF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a user queue is created through kfd, the driver normally
acquires a reference to each buffer backing the queue, to ensure
those buffers can't be freed from under the queue.

During CRIU restore, we weren't acquiring those buffers. One of them
(cwsr) is svm memory. During CRIU, svm memory is restored during RESUME
phase, after queues are restored.

During CRIU queue restore, keep a record of the svm buffer's address
and size, and then get a reference to it during RESUME phase.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  5 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  6 +++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  1 +
 .../amd/amdkfd/kfd_process_queue_manager.c    | 38 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |  4 +-
 5 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index d8233337b8d5e..8157f57e9e581 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2833,7 +2833,7 @@ static int criu_resume(struct file *filep,
 {
 	struct kfd_process *target = NULL;
 	struct pid *pid = NULL;
-	int ret = 0;
+	int i, ret = 0;
 
 	pr_debug("Inside %s, target pid for criu restore: %d\n", __func__,
 		 args->pid);
@@ -2861,6 +2861,9 @@ static int criu_resume(struct file *filep,
 		goto exit;
 	}
 
+	for (i = 0; i < target->n_pdds; i++)
+		kfd_criu_resume_pdd(target->pdds[i]);
+
 	ret =  amdgpu_amdkfd_criu_resume(target->kgd_process_info);
 	if (ret)
 		pr_err("amdgpu_amdkfd_criu_resume failed for %i\n", args->pid);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index eb4d35a42e917..79f7b126ebd0d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -895,6 +895,9 @@ struct kfd_process_device {
 	u32 pasid;
 	/* Indicates this process has requested PTL stay disabled */
 	bool ptl_disable_req;
+
+	/* CRIU data preserved between restore and resume */
+	struct list_head criu_pdd_metadata_list;
 };
 
 #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
@@ -1371,6 +1374,8 @@ int kfd_criu_restore_event(struct file *devkfd,
 			   uint8_t __user *user_priv_data,
 			   uint64_t *priv_data_offset,
 			   uint64_t max_priv_data_size);
+
+int kfd_criu_resume_pdd(struct kfd_process_device *pdd);
 /* CRIU - End */
 
 /* Queue Context Management */
@@ -1387,6 +1392,7 @@ void kfd_queue_unref_bo_va(struct amdgpu_vm *vm, struct amdgpu_bo **bo);
 int kfd_queue_unref_bo_vas(struct kfd_process_device *pdd,
 			   struct queue_properties *properties);
 void kfd_queue_ctx_save_restore_size(struct kfd_topology_device *dev);
+int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size);
 
 struct mqd_manager *mqd_manager_init_cik(enum KFD_MQD_TYPE type,
 		struct kfd_node *dev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index ac18c2be6ecb6..ded42532e6d9c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1801,6 +1801,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
 	pdd->dev = dev;
 	INIT_LIST_HEAD(&pdd->qpd.queues_list);
 	INIT_LIST_HEAD(&pdd->qpd.priv_queue_list);
+	INIT_LIST_HEAD(&pdd->criu_pdd_metadata_list);
 	mutex_init(&pdd->doorbell_mutex);
 	pdd->qpd.dqm = dev->dqm;
 	pdd->qpd.pqm = &p->pqm;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 509529af2dc3c..d3136f19238bb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -1018,6 +1018,12 @@ static void set_queue_properties_from_criu(struct queue_properties *qp,
 	qp->format = q_data->format;
 }
 
+struct criu_pdd_metadata {
+	struct list_head list;
+	uint64_t ctx_save_restore_area_address;
+	uint32_t ctx_save_restore_area_size;
+};
+
 int kfd_criu_restore_queue(struct kfd_process *p,
 			   uint8_t __user *user_priv_ptr,
 			   uint64_t *priv_data_offset,
@@ -1026,6 +1032,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 	uint8_t *mqd, *ctl_stack, *q_extra_data = NULL;
 	struct kfd_criu_queue_priv_data *q_data;
 	struct kfd_topology_device *topo_dev;
+	struct criu_pdd_metadata *resume_info;
 	struct kfd_process_device *pdd;
 	uint64_t q_extra_data_size;
 	struct queue_properties qp;
@@ -1131,6 +1138,11 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 		goto exit;
 	}
 
+	resume_info = kzalloc(sizeof(struct criu_pdd_metadata), GFP_KERNEL);
+	resume_info->ctx_save_restore_area_address = qp.ctx_save_restore_area_address;
+	resume_info->ctx_save_restore_area_size = qp.ctx_save_restore_area_size;
+	list_add_tail(&resume_info->list, &pdd->criu_pdd_metadata_list);
+
 	if (q_data->gws)
 		ret = pqm_set_gws(&p->pqm, q_data->q_id, pdd->dev->gws);
 
@@ -1146,6 +1158,32 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 	return ret;
 }
 
+int kfd_criu_resume_pdd(struct kfd_process_device *pdd)
+{
+	struct kfd_topology_device *topo_dev = kfd_topology_device_by_id(pdd->dev->id);
+	struct criu_pdd_metadata *resume_info;
+	struct criu_pdd_metadata *next = NULL;
+	u64 total_cwsr_size;
+	int ret = 0;
+
+	list_for_each_entry(resume_info, &pdd->criu_pdd_metadata_list, list) {
+		total_cwsr_size = resume_info->ctx_save_restore_area_size +
+			topo_dev->node_props.debug_memory_size;
+		total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
+
+		ret = kfd_queue_buffer_svm_get(pdd, resume_info->ctx_save_restore_area_address, total_cwsr_size);
+		if (ret)
+			break;
+	}
+
+	list_for_each_entry_safe(resume_info, next, &pdd->criu_pdd_metadata_list, list) {
+		list_del(&resume_info->list);
+		kfree(resume_info);
+	}
+
+	return ret;
+}
+
 int pqm_get_queue_checkpoint_info(struct process_queue_manager *pqm,
 				  unsigned int qid,
 				  uint32_t *mqd_size,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 18d24ddb455eb..78de556da056c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -88,7 +88,7 @@ void uninit_queue(struct queue *q)
 
 #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
 
-static int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size)
+int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size)
 {
 	struct kfd_process *p = pdd->process;
 	struct list_head update_list;
@@ -182,7 +182,7 @@ static void kfd_queue_buffer_svm_put(struct kfd_process_device *pdd, u64 addr, u
 }
 #else
 
-static int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size)
+int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size)
 {
 	return -EINVAL;
 }
-- 
2.34.1

