Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BA6606A329
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Qrzk9gt7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 979A8112838;
	Fri, 30 Oct 2026 14:06:33 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013063.outbound.protection.outlook.com
 [40.107.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D227F112833
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 14:06:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xmXL1G0sJgV4T3wEIcY9137b4aZq6Z44ksHKQ97e0xEJ3bKcmsgQJl5WirwlxL6HcCvmAncrTUFPKQ3AT4gYvdYriiN+K6WE9RiV6LXEnm6UNt04iESBCX+M6h4149GUo3pJhr3n+ZjVky8jMnq3sgO5KCwK6oCtjAYz3H9ViaQnXNMsIyE4VtZtXGHlXZVeFsDj4H+n7TiGyR0p5YwerV7vun4/kuWBCwp3d7rAuq+OAEi0ZkHcNRQM+0SfeQORir1r8nKRaMWYNr/+kGCaPNJIIPs/1H+vY/k1su6w9+FJWji04mY/DlC+5tDnJQUmxX8gWtFT4H+WKLksD7Dzaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lH+4atkrKu0aJ1tW3DJ29hLql1ZIdW64/zexL+Gb8ts=;
 b=twL76pVzrB8Mnopay4PFEYZjY8gnAQHb7iF+4XKWooEGVKnnkOTlgXh6/PBfgtUa4/2m0Rz8eXw+t45ylhUbDNmNvw1YFiYs4pyyGmAU7Rr29HxuwDXhKjQB6nQ/ZvKLhWCnDFVj+a/plq+n9LrUW19mlJ6zFf0zvWf1CKNe9RXmiwSihFmMoRw0pOpz/GLVE4xK2i7+uUvODbfSwQwdUJRQSz9TDj6HtymQunhrkJHbAlPQiK2mO6g9EHngwVcuo0lnx3TGlHFPkKbDSlB7Er9jzZCIgQl0liLeWI8NtGbgHSDtH0Gy3y3+sxVr1p3ZQysqQPlBEIa/fIps2fJPxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lH+4atkrKu0aJ1tW3DJ29hLql1ZIdW64/zexL+Gb8ts=;
 b=Qrzk9gt7AqqP0TMnpHJMwidKO00u6HQQYpBBqGU3Q8KhzZuu4VVWUJ9WttINhMrFInn1QKkvGRKKIPJ4uhP4F+/ieWn9jt7VJypdr4OzOlh2fr4VYFM7EVNvxZnhR/rAYq0hu/A2LX2r1AagkIW49BWJsd745VbIYw3ygA4XQS0=
Received: from SJ0PR05CA0048.namprd05.prod.outlook.com (2603:10b6:a03:33f::23)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 14:06:08 +0000
Received: from BY1PEPF000264B4.namprd02.prod.outlook.com
 (2603:10b6:a03:33f:cafe::ad) by SJ0PR05CA0048.outlook.office365.com
 (2603:10b6:a03:33f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5 via Frontend Transport; Fri, 30
 Oct 2026 14:06:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B4.mail.protection.outlook.com (10.167.242.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 14:06:07 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 09:06:07 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, David Francis
 <David.Francis@amd.com>
Subject: [PATCH v2 1/3] drm/amdkfd: Acquire buffers in CRIU queue restore
 (again)
Date: Fri, 30 Oct 2026 10:05:48 -0400
Message-ID: <20261030140550.2524662-2-David.Francis@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B4:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: 9af81a65-57a0-44f9-7480-08df368ef1a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|56012099006|261009223027099003|261026121527099003|261028144727099003|261026140227099003|261021123027099003|261021121427099003|261022105027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nucmJQmCWw/mgne/F3sdMQXGJNvRMD/zfdEMNtmywAehluBKs7q49A0VCY1c1MgsLupFyzva9nZms5BHD8JQhwUu8lcCSAzfBRGbKwoyPg1PusUWzFl11VG6OvT7/h3C2S5ipx2CsWFpD7wD982rlAOphth7qRYv4nqWKFWo3DaYsM50XX6cX/jHfANY++7+08KcGeKwMnSMZvhttEiNsT666EavWpwCIe2yR+5Kt/bFxs+iklxAr3A/PUjz8jKv5+a8nQTx/dnq+HBeMQdKvcsL3VycmqSyN21iJWXHbu9DEMqrPkpiITX68uLPy2o20jLdA445CVa3fVWfdsDPfrGctIWr2fLSE9OPDK72IjEjy3/vmcsp5gueU885KCx6r8/F+IdUG42C/Ok5i9YVvedM1B42me7WYBbwFFZOdocxgIC2Wwx6vOAOrnMu7s5Jsfb2Sgd8TmKBlEJPk9fMq/XQfdmymGTvN1cRmPoA8w68n38ggnzhgSaY4ggODNsILUiGlZmwVHI+c0k81XSj5RBQs2SBGvIY2VaINaGskYvdYSY7mMhBwEBGCItdTEliJfk4kFwwGHH1ejnHy6FIAIDCqebiZOh2XHhXDXZGLbzx19Lq07m4wM0Bwl+sbFPhXfNtUvJ0tn/zxWhei6t7EDDnkTxFBftrSR11QaGlS2zRJsFTRppuDvb9hXGC8H+SnhxfrvtrC9eKv+AZG4drJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022105027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7J+hJN4XcQ32CAdKWPCq/VeyJwGCpIm3FM9QbR9+1T2R5xlTQVhNvqLgngAxbuBdzFOwOk0TJT54YtglGo6kcJlKAb9MWL3FYHu6ST3sP+5P/F1wXOaJMfrQJe8+I+NLgWT69ZVzxnGGY5v8cMz+fOrUfVHw9etqO5s4pR7zo+6aTeLpAT4vBQDvXC4kg0J09BbpjDR8zhxtkqTddyEsWXj4LMZo4umfiAXJV0EHcxpD0DLPAULXFNrTISwKCt9YqFXHh6j5d6yK/VoEFU7B3AYxudT2BCyrTjtf7imdU99+LqOf+cVyK4u41axKRn8tgR9JNu9h9aRWIVUYIEtIF7wyFdd3e9fXULwwyekszel7GB3YKVYn7mVfnz6uIMFoXwP+N1noj73jq+qNZsidQMibhD2H2Mr5Qxe1OKtLIeExyo/Cwb1UM5GAxXXjFb+R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:06:07.6492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af81a65-57a0-44f9-7480-08df368ef1a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264B4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8482
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

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    | 34 +++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |  8 ++++-
 4 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 6c710e4a5220c..d8233337b8d5e 100644
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
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index f0ce5fc4a138f..eb4d35a42e917 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1381,7 +1381,7 @@ void print_queue(struct queue *q);
 int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_bo **pbo,
 			 u64 expected_size);
 void kfd_queue_buffer_put(struct amdgpu_bo **bo);
-int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
+int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties, bool is_criu);
 int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
 void kfd_queue_unref_bo_va(struct amdgpu_vm *vm, struct amdgpu_bo **bo);
 int kfd_queue_unref_bo_vas(struct kfd_process_device *pdd,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 4c4a3a8587f46..509529af2dc3c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -985,8 +985,14 @@ int kfd_criu_checkpoint_queues(struct kfd_process *p,
 }
 
 static void set_queue_properties_from_criu(struct queue_properties *qp,
-					  struct kfd_criu_queue_priv_data *q_data)
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
@@ -998,6 +1004,16 @@ static void set_queue_properties_from_criu(struct queue_properties *qp,
 	qp->eop_ring_buffer_size = q_data->eop_ring_buffer_size;
 	qp->ctx_save_restore_area_address = q_data->ctx_save_restore_area_address;
 	qp->ctx_save_restore_area_size = q_data->ctx_save_restore_area_size;
+
+	if (q_data->type == KFD_QUEUE_TYPE_COMPUTE) {
+		if (q_data->ctl_stack_size)
+			qp->ctl_stack_size = q_data->ctl_stack_size / num_xcc;
+		else if (topo_dev)
+			qp->ctl_stack_size = topo_dev->node_props.ctl_stack_size;
+	} else {
+		qp->ctl_stack_size = q_data->ctl_stack_size;
+	}
+
 	qp->type = q_data->type;
 	qp->format = q_data->format;
 }
@@ -1047,7 +1063,13 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 	}
 
 	memset(&qp, 0, sizeof(qp));
-	set_queue_properties_from_criu(&qp, q_data);
+	set_queue_properties_from_criu(&qp, q_data, pdd);
+
+	if (q_data->type == KFD_QUEUE_TYPE_COMPUTE && !qp.ctl_stack_size) {
+		pr_err("Failed to determine ctl_stack_size for compute queue\n");
+		ret = -EINVAL;
+		goto exit;
+	}
 
 	/* Per-XCC control stack size from topology, as create-queue requires */
 	if (qp.type == KFD_QUEUE_TYPE_COMPUTE && pdd->dev->kfd->cwsr_enabled) {
@@ -1095,9 +1117,17 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 
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
index 6010a5d7a7eb9..18d24ddb455eb 100644
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
-- 
2.34.1

