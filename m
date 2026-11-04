Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76B0606B2E4
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 20:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wirJzX0t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75EE410E182;
	Wed,  4 Nov 2026 20:49:48 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013019.outbound.protection.outlook.com
 [40.93.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4100D10E182
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 20:49:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1GQnUjDPrT24mrTpV7zqRH1tY2EKO3rHBl6KLXJwH3qdXiAYvj3SbXMP4SL1OBVzOYPqUBP7b7G/nm6ID5VJ+ogyKtQ0tMl0NBvSxmWwaqXWH81WKp73QGiuWRbuMLOmKHJ74vYBVpOzqE5fRV+qZtTx0MNeapIF15XPX/1bY0Uxs7PMRp7iBZOnpdotrpqD1Jj/mDivrStydrpknYSK5j1hKfkZXi3rt33oaNapp0Gdfh6t7r4oH4rQyDT53/93tL/jylwtFhY2N4iL3NUXviNhLGvs54Bn42IIcE3ONNqo45sONJkBJq16uhU9BbNkQ6H/1ffAWoiTPKzrVst9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0okaRbZq5vuaQ748m32s2traVjNnXvlf+BKEMnPmwGY=;
 b=TETaDx/BTQfqzejFKcNiF6ru7vj089qzmfFGFs2jSKTeJCCNFaXMVeTxSlraA60xv0nwMKxFokLlJllYgc6uYjK9NlnEd3SR7T04JlqhAoQpbAYLcfiAzSN93OHuKDakUZsPmM8tXQ3v/gP35F9Nk8coQYmE0CD/T3f+6ipuchdgdFpP8z05gxqYY4+zmEFmIJ86T+Tp61VQK9PyQRPkQZebB/AHCJbRBxgJ/KXnA99z3t14lCYUXW1lPzgMC1aRmGIlhktT12WqWCK1tHh6sL6oMYe1jttaV3ZY8oD5uSr9PfTcQ9iqntH75NXuphns3CNf/kJkm9paRii4cDWOzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0okaRbZq5vuaQ748m32s2traVjNnXvlf+BKEMnPmwGY=;
 b=wirJzX0tlBwtrUrDi0ZenO5hpoF5sWnzLfWZjZg1w2+sDnIJioZnC1XGjqOoHk5uF118SaK+aEKN8GpkD7YaIJ6PXUghDNqhE8ntevVMEysoFoEsE3OT+6+UJbbQ2323Wr9z8CXducjkNcbiqCIMgc3stEFEokdi50QJxQZvOJw=
Received: from MN2PR07CA0021.namprd07.prod.outlook.com (2603:10b6:208:1a0::31)
 by DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 20:49:37 +0000
Received: from BN3PEPF00022BC9.namprd05.prod.outlook.com
 (2603:10b6:208:1a0:cafe::59) by MN2PR07CA0021.outlook.office365.com
 (2603:10b6:208:1a0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 4
 Nov 2026 20:49:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC9.mail.protection.outlook.com (10.167.248.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 20:49:37 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 14:49:36 -0600
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, David Francis <David.Francis@amd.com>
Subject: [PATCH v5 1/2] drm/amdkfd: Acquire buffers in CRIU queue restore
 (again)
Date: Wed, 4 Nov 2026 15:49:22 -0500
Message-ID: <20261104204923.4011440-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC9:EE_|DM4PR12MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: e6af7b56-efd1-496d-390f-08df3ab523a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|261021121427099003|11063799006|56012099006|261021123027099003|261009223027099003|261028144727099003|261026121527099003|261022105027099003|261102123227099003|261026140227099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: VxkxPcV99rshtIe7zav0I7Z49tNHAtEcVHW97Apkk9pk8Yci7z2/v1hQwxyu6uQb0gxDKcyjnvyDQfGXi/lkX5K4JYmmlDhGOC0uEKcYgHS8SP4f+Ovr7j+iSwrP7BOmWCA63Hs0JdCIzz38Wlqh9BRqwa0JcWyKKuQuAJFNrLmp3ImtlWzBalkGPTnUmGw9ti3t+Hvk/Ama6eiUmWNh23SiqG1qY0zRcLH3PBvd+MVbnOglOBNRIxQ8BcuUadqtLB2bK+i1X8yo1H0RiTZjyVxjroigYnELsHl400ERRGApDtpLYsbpgbhBMnoCmh61HZBtsvElCfO/h0ldAMI2WX3oH4B2j3xHqUkvNi1qvtQdaPiAPeofnxYp8HipcU/F25FrdX8xOCoToFO56adCzeebtOnzjfefz+hy2lLnuR6x+UZNN7FsLhHGNLf2NT4spOfrvEHiaR9M2eovikAc6VL/UcMzVy140JqEYf0VZARVxTmZ54dVGbVvWhcYlI+3snY9hj/n8ZduKK6IXt+R35J4SUlUZ8Tm05NgfA0yw4HFTV1WkkAf+5J2LwrVBBasb4m3VP++hiHpxRbqoqu5pS/wy2kr9/j5bu7bHc7cJtx716AWSU1iG3eFVb1qI+F8EQEqaSl5NJP8H0zIYrMcX576Or5DYVLZzlh4gPJhxmw2j9HBt6DzW9IjD/wn7kXXkZbM+1Z6Ik/BZTaZWXkRhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(261021121427099003)(11063799006)(56012099006)(261021123027099003)(261009223027099003)(261028144727099003)(261026121527099003)(261022105027099003)(261102123227099003)(261026140227099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HIaLgizvo9s7eVCqM9BGlpmITvxGYddsYRtwk0xQnG1ZOYlna6ImQ3KvfcCAkxoJZw9fh09QvS+sGAttgKDrAvuf0xJz14s0MjrBeVTGJiT1NBh9mpB5eIcyhvHJnM9Wa7C5+NihaH7tArB3GOzC6yCcdDxBfWi0Xnl24UP7IY3vcnt3Z0kZqV7uimqpOHesl+htRn5d5ID/DyyoT7MYLhQfcPfemlGnbm8asdUyGGd/OI7KKhm/GZLJUINF5Nm+skpBBwZzmer1Fe46CdrazMSN8j7oLkNtrGOlpp+8dQcfyEkhkkOYODv8mK0eG5qQhEhdFlcX6F1DuXirt3cNEdrB4i1HFQyktzAwQeprRKSw6LilOcgsW7Zv6+16k8vmuMVCMg8I3aVdAugeRGE1R5wz5ZkziLjfhyXD0w1NJ5keDnNMyINb+U7GBAyVseLB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 20:49:37.0835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6af7b56-efd1-496d-390f-08df3ab523a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526
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

CRIU queue restore doesn't acquire the bo buffers in the same way
normal queue creation does. In normal queue creation, the driver
gets an additional reference on the queue's underlying buffers
that lasts until the queue is destroyed; this prevents the
queue's buffers from being removed from underneath it.

Acquire them, but don't get the svm bo. SVM isn't yet fully
restored by this point in CRIU and so there's no svm range to get.
This will be addressed in the next patch.

v2: Don't use checkpoint ctl_stack_size
v5: Also avoid cwsr in criu failure path

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c            |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h               |  4 ++--
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c  | 12 ++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c              | 13 ++++++++++---
 4 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 6c710e4a5220c..cae3767aec567 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -433,7 +433,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 		goto err_bind_process;
 	}
 
-	err = kfd_queue_acquire_buffers(pdd, &q_properties);
+	err = kfd_queue_acquire_buffers(pdd, &q_properties, false);
 	if (err) {
 		pr_debug("failed to acquire user queue buffers\n");
 		goto err_acquire_queue_buf;
@@ -478,7 +478,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 
 err_create_queue:
 	kfd_queue_unref_bo_vas(pdd, &q_properties);
-	kfd_queue_release_buffers(pdd, &q_properties);
+	kfd_queue_release_buffers(pdd, &q_properties, false);
 err_acquire_queue_buf:
 err_sdma_engine_id:
 err_bind_process:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index f0ce5fc4a138f..5f27ea7752349 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1381,8 +1381,8 @@ void print_queue(struct queue *q);
 int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_bo **pbo,
 			 u64 expected_size);
 void kfd_queue_buffer_put(struct amdgpu_bo **bo);
-int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
-int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
+int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties, bool is_criu);
+int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties, bool is_criu);
 void kfd_queue_unref_bo_va(struct amdgpu_vm *vm, struct amdgpu_bo **bo);
 int kfd_queue_unref_bo_vas(struct kfd_process_device *pdd,
 			   struct queue_properties *properties);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 4c4a3a8587f46..5741ed95c3817 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -227,7 +227,7 @@ void pqm_uninit(struct process_queue_manager *pqm)
 										     pqm->process);
 			if (pdd) {
 				kfd_queue_unref_bo_vas(pdd, &pqn->q->properties);
-				kfd_queue_release_buffers(pdd, &pqn->q->properties);
+				kfd_queue_release_buffers(pdd, &pqn->q->properties, false);
 			} else {
 				WARN_ON(!pdd);
 			}
@@ -572,7 +572,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 				goto err_destroy_queue;
 		}
 		kfd_procfs_del_queue(pqn->q);
-		kfd_queue_release_buffers(pdd, &pqn->q->properties);
+		kfd_queue_release_buffers(pdd, &pqn->q->properties, false);
 		pqm_clean_queue_resource(pqm, pqn);
 		uninit_queue(pqn->q);
 	}
@@ -1095,9 +1095,17 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 
 	print_queue_properties(&qp);
 
+	ret = kfd_queue_acquire_buffers(pdd, &qp, true);
+	if (ret) {
+		pr_err("Failed to acquire user queue buffers err:%d\n", ret);
+		goto exit;
+	}
+
 	ret = pqm_create_queue(&p->pqm, pdd->dev, &qp, &queue_id, q_data, mqd, ctl_stack, NULL);
 	if (ret) {
 		pr_err("Failed to create new queue err:%d\n", ret);
+		kfd_queue_unref_bo_vas(pdd, &qp);
+		kfd_queue_release_buffers(pdd, &qp, true);
 		goto exit;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 6010a5d7a7eb9..9dcf0134f35bc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -239,7 +239,7 @@ static void kfd_queue_put_bos(struct queue_properties *properties)
 	kfd_queue_buffer_put(&properties->cwsr_bo);
 }
 
-int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
+int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties, bool is_criu)
 {
 	struct kfd_topology_device *topo_dev;
 	u64 expected_queue_size;
@@ -334,6 +334,12 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 
 	amdgpu_bo_unreserve(vm->root.bo);
 
+	/* CRIU svm buffers are restored at a later stage than queues. They'll be in
+	 * before the queue is actually used, so no risk here
+	 */
+	if (is_criu)
+		return 0;
+
 	err = kfd_queue_buffer_svm_get(pdd, properties->ctx_save_restore_area_address,
 				       total_cwsr_size);
 	if (err)
@@ -362,7 +368,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 	return err;
 }
 
-int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
+int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties, bool is_criu)
 {
 	struct kfd_topology_device *topo_dev;
 	u64 total_cwsr_size;
@@ -380,7 +386,8 @@ int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_prope
 		return -EINVAL;
 	total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
 
-	kfd_queue_buffer_svm_put(pdd, properties->ctx_save_restore_area_address, total_cwsr_size);
+	if (!is_criu)
+		kfd_queue_buffer_svm_put(pdd, properties->ctx_save_restore_area_address, total_cwsr_size);
 	return 0;
 }
 
-- 
2.34.1

