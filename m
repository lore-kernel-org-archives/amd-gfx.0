Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AC9C982EE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 19:22:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC6DB10E228;
	Mon, 21 Sep 2026 19:22:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bh/n7RhA";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8690110E228
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 19:22:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyC0cO8dgetjMqduzN1WFwMEDXiM5qCcS/9JyQbwYc1Lxe+/2vziZQqE8BdU5pLckkXXXf3tfhVHH/1yedWSBCAzac0akTTdu13PiRoPoIdCrkiGHDUkd/d8SuSFrZKWWy5gNX0tZ2/vG+scGsvj4NFzH6nkPVLKY8tX9+Rvu4NQt8VuL5gb6b7Oe0Xsi2dnKgUoGzmMDR5ahBuFu+nXx2HMp63Pbk0Xf7G9Xac/6CjgPTK5utaXjq1eYUt7CbJW6lMC2PxSGESZnnjXT/m7+ocW7YuDTNsaB9L5lpoGw/lpI/jDq8JFeDLMHt/pO9edSWJD7thQW7oyjaGYaN0auw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQzapz3kXLeONzk6ZXzpDDSotGAcaHp6HgLN9scaxZo=;
 b=sigkgkioTnK4SNcrQUh3XdmQaDAVEMTIWLOX1puyLHGjOT/SoEsezGIVIQGemxD4JFUk/knyUbpBlwtgM9oYIQ/fWC3dHP/O/JRp/ngKyp6/HHb4n+pdC2Q1dZN6HN69keRjND020oETBRQlN2c0oIK8KlJ08BhahkTLDtzreKACrVw4f1eYRw34t03Q456sUdMrPYQ6l2cPW9tcocoB0+DrCp99FtAlfIB6xwnVdIXZGsPCCXhui/XuzIKWfu2IdNElmIQ8uTxP+SvLc0MLeMSIdFxGYcxzr63K8S1/NsMnlmOA9ywg5aUds4sgUaGJpx+hIOM5GxsUhFXsmoVgnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQzapz3kXLeONzk6ZXzpDDSotGAcaHp6HgLN9scaxZo=;
 b=Bh/n7RhA9SVYlpSV8nFQ3GTebbLSegu1Ukklc/CQ6aosSMnfui7RA5IaA0RV4iU0Ph6jGbTXcwpwX8WwgRDtopa6IVQMvW+3rn9Iz5SyEaTK+aHDtMJPmSletTpv88jgiLI2MB+P73p1x6jkwp0+XwaKzBky5/mnEtyi748gIQQ=
Received: from SJ0PR05CA0084.namprd05.prod.outlook.com (2603:10b6:a03:332::29)
 by SA1PR12MB8857.namprd12.prod.outlook.com (2603:10b6:806:38d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 19:22:48 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::8b) by SJ0PR05CA0084.outlook.office365.com
 (2603:10b6:a03:332::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7 via Frontend Transport; Mon, 21
 Sep 2026 19:22:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 19:22:47 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 14:22:45 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <David.YatSin@amd.com>, David Francis
 <David.Francis@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: Acquire buffers in CRIU queue restore (again)
Date: Mon, 21 Sep 2026 15:22:31 -0400
Message-ID: <20260921192232.665113-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|SA1PR12MB8857:EE_
X-MS-Office365-Filtering-Correlation-Id: 227c9126-1c74-4363-9605-08df1815b889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 1e+TN3ljrezYdCsBrS3vQs1WErPYldipUyJr/dRA0KYrTQvjabZKNb3Ik/F+AAT2AKx1qIONTv+FbjMiDhE5CSFZYQ9mysD0zQulnjh7U//mzr3R9STF1mhkVjTNjHhTFWFr5kCWbLkdApqfI9XlXi6qwprKMPTMfq9Du/umQ5f3xkCyBoEV6DR2rgjzJjnRhUHWl4yXYvevfCyYedfZ9OWqcqGM52vxIBk2dPko0msroCbAvAnG9WtKd5S3No8ICSMT3t3U6qUyXQwaUEuwRHxpxBO0ToKpCeSL0+LoK3XD/qkLbtTAwRRmBTyz+/l+RV1YRTBjz6Da3/E5fwF1kWwUfNPr3zUfinhbbLatm4qp9QKIx7yjw2MqZaYh58KM+OxzaL6441/ulQ3csIgOIktLedY1EhBnMrafAGtiArLEGik72fftSMSFKCV3y/San5GJT28q5gG3WhgXtA1Q0IpJJNMOn+TEqZ5C5VSCVteLUx9yM0fkFkO8ifAg7RCPzpPk5B88hegqGRbkjXRrOweAAr6G5CFngKhh+Sf6VcqE5DiN4X0ilOtGk+tt4PdFxrMmiBJPCvIsECnelz1w3Rc32pzx0f3Eb1BI4UNRloll2KOpwi+zUrehdRkuTVLHS52c58FT8Jh+J5hE0fxCGc/EvBM7g9rzo0BD2lvrVSAb+EaYXa0AYImcLJj8l1HL41R3MsCyVAo2EGszND/gYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: x0/Uok1EjN2+O3AplmX2TjRUS56FBlfsv1SzPaJ009oZYlaoIkr0mC/OIwPDcNnRzMNOZgpfC3Q3rmlKZQ0zM9Twud1WpUD/XX1uezlJakuf1w1jH3kQCEcX0P0FWKKBHzW9dCoTwPSw/nk7pCk4bTSPEHfSeA8K9OqO4XOmHgb2QombvVM8gP/ygoQxTCugmIxhVTGW2gXH2nRWeMYCbsaPCkJrfY69cQCJvL3JCvJXLa2FhCVAzUGj0aYElwUOiR3KPEECIcm9wl8X2SLDnSudJRoZbFIsKsWmI0w4M3JOsMlvoz+gK6kAKxBNCKIxCGhLIGQbE48gK/U6FGtjZJQK0UJTX/oOySfCeW0VLrfcourcPdV3/+cPLTykOBmsCgv9Ps27R+XdsDA2VLpkXeLu2RRccmNrevpaHhOCnrCgfxpTFrt81GVBQVU2VmfV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 19:22:47.8020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 227c9126-1c74-4363-9605-08df1815b889
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8857
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

CRIU queue restore doesn't acquire the bo buffers in the same way
normal queue creation does, which results in it failing a check
in init_user_queue when its wptr_bo is null.

Acquire them, but don't get the svm bo. SVM isn't yet fully
restored by this point in CRIU and so there's no svm range to get.
By the time the queue is actually in use the svm range will
be there.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    | 34 ++++++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |  8 ++++-
 4 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 7fcfc150a7fc..ed6e0f817e7c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -392,7 +392,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 		}
 	}
 
-	err = kfd_queue_acquire_buffers(pdd, &q_properties);
+	err = kfd_queue_acquire_buffers(pdd, &q_properties, false);
 	if (err) {
 		pr_debug("failed to acquire user queue buffers\n");
 		goto err_acquire_queue_buf;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index d8631847f0eb..59267f8c5840 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1377,7 +1377,7 @@ void print_queue(struct queue *q);
 int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_bo **pbo,
 			 u64 expected_size);
 void kfd_queue_buffer_put(struct amdgpu_bo **bo);
-int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
+int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties, bool is_criu);
 int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
 void kfd_queue_unref_bo_va(struct amdgpu_vm *vm, struct amdgpu_bo **bo);
 int kfd_queue_unref_bo_vas(struct kfd_process_device *pdd,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index a15a826519ad..55569d555758 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -983,8 +983,14 @@ int kfd_criu_checkpoint_queues(struct kfd_process *p,
 }
 
 static void set_queue_properties_from_criu(struct queue_properties *qp,
-					  struct kfd_criu_queue_priv_data *q_data, uint32_t num_xcc)
+					   struct kfd_criu_queue_priv_data *q_data,
+					   struct kfd_process_device *pdd)
 {
+	struct kfd_topology_device *topo_dev;
+	uint32_t num_xcc = NUM_XCC(pdd->dev->xcc_mask);
+
+	topo_dev = kfd_topology_device_by_id(pdd->dev->id);
+
 	qp->is_interop = false;
 	qp->queue_percent = q_data->q_percent;
 	qp->priority = q_data->priority;
@@ -996,10 +1002,14 @@ static void set_queue_properties_from_criu(struct queue_properties *qp,
 	qp->eop_ring_buffer_size = q_data->eop_ring_buffer_size;
 	qp->ctx_save_restore_area_address = q_data->ctx_save_restore_area_address;
 	qp->ctx_save_restore_area_size = q_data->ctx_save_restore_area_size;
-	if (q_data->type == KFD_QUEUE_TYPE_COMPUTE)
-		qp->ctl_stack_size = q_data->ctl_stack_size / num_xcc;
-	else
+	if (q_data->type == KFD_QUEUE_TYPE_COMPUTE) {
+		if (q_data->ctl_stack_size)
+			qp->ctl_stack_size = q_data->ctl_stack_size / num_xcc;
+		else if (topo_dev)
+			qp->ctl_stack_size = topo_dev->node_props.ctl_stack_size;
+	} else {
 		qp->ctl_stack_size = q_data->ctl_stack_size;
+	}
 
 	qp->type = q_data->type;
 	qp->format = q_data->format;
@@ -1078,13 +1088,27 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 	ctl_stack = mqd + q_data->mqd_size;
 
 	memset(&qp, 0, sizeof(qp));
-	set_queue_properties_from_criu(&qp, q_data, NUM_XCC(pdd->dev->xcc_mask));
+	set_queue_properties_from_criu(&qp, q_data, pdd);
+
+	if (q_data->type == KFD_QUEUE_TYPE_COMPUTE && !qp.ctl_stack_size) {
+		pr_err("Failed to determine ctl_stack_size for compute queue\n");
+		ret = -EINVAL;
+		goto exit;
+	}
 
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
+		kfd_queue_release_buffers(pdd, &qp);
 		goto exit;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index ae3e7c54014a..0e8833716381 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -230,7 +230,7 @@ void kfd_queue_buffer_put(struct amdgpu_bo **bo)
 	amdgpu_bo_unref(bo);
 }
 
-int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
+int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties, bool is_criu)
 {
 	struct kfd_topology_device *topo_dev;
 	u64 expected_queue_size;
@@ -325,6 +325,12 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 
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
-- 
2.34.1

