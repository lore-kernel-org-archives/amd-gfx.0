Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44841606A329
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 20:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IlH4ZjtA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C52E010E15A;
	Mon,  2 Nov 2026 20:53:49 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010023.outbound.protection.outlook.com [52.101.85.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A651210F1EB
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 20:53:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFzwkRWEC7z459QYTUSpVaIL6ryTWZNPfUWsOeKZICRPC0RKlXduEVzRKrNboZMhyIwAmUAPpdBFdR//WUFR+pEqE2KA723MhEh8a3S6iIhB+crSV61ish+Ztv/0DYMaG5c27arLLC4PKxL8dRtcpfjGeuScvNIAcNrLRc7/isUs5S7UJtZrkruAy++rf06Z9OQ9dYs0Xylqa5xX5fSFL5u0C6wAv+JYm0u+YSj4ek4469CIwDA6VQueYdOFe14gqOLPJWZM+HdieXciRWa+TmGOvoDiIYpzmG9EYGwWXzUChQZOvEQRc9OJDU9ch2hne4QkNkwiNjOcEliuYOcYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0UWAI7d+EaQuazJrM8FBD4HSdu3/xOm1VT5JCAQP2E=;
 b=b+Rhh7Bf9s6mh4yeKe6+56FKwcGTwv8Wn0Cv8E/Nn40kfsfSE9DXZ9tQfKSprx8GIIKSqyoL3KYvyCksdVm+8oTFLGg1VcXFu3WIouwrQbkfu1HXE6RX7MHou2qwrpVVWDs0e1WhXhER+H/Z4cfh+N+tKpTDMTw2LNW8WXipLFeV911+dav+WqxOHN3C7OJPBMObuUkP/qVI0gB0SJE+CCGAmAL8ps8S86n5s/oAXb1UE/p9J2+CRinfyFmjMRkTL4zIPU21dYvG3iwJn2V0eLUBflVqESbfd9zrKqUTG81w/weiSC3cUFWTXMCOiJAv1ftjkpPpRMlUMuKnHPF2jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0UWAI7d+EaQuazJrM8FBD4HSdu3/xOm1VT5JCAQP2E=;
 b=IlH4ZjtA4OcVjmnOFQuHf2ZpV/MjLvhR7XoXspMk7wVcBinwV4py3SDBjfiFz5ZFUznanFGVmIpMcstS97gC+rHom4QzPRViBpSFiJgG5Pe1KUSMBc38W8wUzhhdkVTO9xsrLmmDH04ICYM0LSmQRm8RpRSKie4FYcwi9Rroh6E=
Received: from SJ0PR03CA0249.namprd03.prod.outlook.com (2603:10b6:a03:3a0::14)
 by MW6PR12MB8835.namprd12.prod.outlook.com (2603:10b6:303:240::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 20:53:39 +0000
Received: from CO1PEPF00012E83.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::69) by SJ0PR03CA0249.outlook.office365.com
 (2603:10b6:a03:3a0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 20:53:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E83.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 20:53:38 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 2 Nov
 2026 14:53:38 -0600
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, David Francis <David.Francis@amd.com>
Subject: [PATCH v3] drm/amdkfd: Acquire buffers in CRIU queue restore (again)
Date: Mon, 2 Nov 2026 15:53:24 -0500
Message-ID: <20261102205324.3148513-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E83:EE_|MW6PR12MB8835:EE_
X-MS-Office365-Filtering-Correlation-Id: 99036e34-4a1e-4cf3-e357-08df39235ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261028144727099003|261026140227099003|261026121527099003|11063799006|10067099003|56012099006|18002099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: fY4mRYcohYJsxuU7CRX5qsfqBEQFN6b3nhzEkPAi9r89xHzBFDH1KkDd8Zd5ai6YQO0+FMBdCverYSuLq7x1gb30hy0GqnyObZ4rOdpimt5WCvONrwm/uHQMdptkk8dDwH7qUfjV+B7lA1IiFW18crkPQVz1dlykdHFNvMKNj8VaInNpEAk+VZxuomSFiBTdS0sLczhnZAbrOBCcPIkO3JiRB8fB0nG3w1PRDrVIdPCySYBcvifXPar5ZM58Vs07tNBaddyoJ4gu7OqxvLlRiyQW88Yjw1DBYH0r22NZbkwum4t9OSY6KUwnT1D7HJd03g3hVEFjBRKIp6Xd+cUsi5XF8HFKIzOqs+6tr1HmbRSawff/pIF/kHh0DNBe9cZ2/wad1Z/zcWWcUzoOaa2ufeWOfziSJcRrwpMeeLnNNn2K5adE/PLafo2czt1aiSk4ho62tuMg4E0za/IYFJ3lyMdpwajZSJl7J498uQqFlPk/S/Wl8y77405jpCRAcJjFUPLunMuMoOHZzhg4UJVM2FhOAPvS8N0+do669eOd/DXa4mbJeiQfrJQjXQHrTSlkO4B3vDHtSkPbDbtLxZyGwJ8O9tOnziX7YJIspBLXILiro283mrBWK7O60UW6hUXWMUi0NkJSs1rzlYJLNzkf4q/wvGbnAYVdEzb3MFHer7fi+CUdjDExr6cQvWwn4d5J0NK6ClnoFtnMzixsYflbcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261028144727099003)(261026140227099003)(261026121527099003)(11063799006)(10067099003)(56012099006)(18002099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: L14ni7tohFuuGCe7bpqcUvkTHhAL+fM58i+wVPWmYA5tUCYHJkqqYFS7t/Uhj2LZOVd5MVqB5E1NKSPge0/M/7K6AaAun53XWstVsfIqse/xyMmDnZlG4/HFQ+w0opr0lZfW+8aaZBNp6h1qAk6DcO5gdqEjddeyyynsUtzzFnhOm1aFhFqNPzSIHh0cTh2b2Ht7EesAItChdcn5fbah9+WkGvecE3HsXS6nBfgnjEnldpdvFSGa/6zjoEsdlKWmd+O2iT0YO/czz7kS3exVST44teeFF0/EG5oPeRASRRObqaY7sxjaKsa/I3o6PjxG0JDZXu3PFXJNWyTa7Wit7iPKSFd2w9VUuZuXaelea8upYKotyCxKyF8D6U40je7cra/vBQpeEVdBexjMCZFHTvhzXKee4Kav8j92yHiRHWuB2do+3xvzmsaIY5QZ2XBX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 20:53:38.6789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99036e34-4a1e-4cf3-e357-08df39235ed4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E83.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8835
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

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c               | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                  | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 8 ++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c                 | 8 +++++++-
 4 files changed, 17 insertions(+), 3 deletions(-)

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
index 4c4a3a8587f46..6e19be9e89f57 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
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

