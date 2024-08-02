Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DFFC3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Aug 2024 15:29:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D523D10E16E;
	Fri,  2 Aug 2024 15:29:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NG/wYklG";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E956E10E16E
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Aug 2024 15:29:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtZ9D15oVf0/gGyfpG9brSxe6T8JgmBv/h85wEQTsmkBlknb9UXFl7559HfaDP5BvfI9fB1E3hqSG4nMyBeOKF2coXCPQ+3uBweFJk/GttOZkRNzuj1KLMHm0EfqVglTCZvn3UZ0VYxwAw0a2gW36zEXkPx0av3Kg5dK3vNI/bNyumZgA7o7A+3g9ZhG6WpCVTOn1Ew/0DQiNG4UunqFUI2BVLT6krDb+mqvZVCVUSONDb/xrLNhUrSZj1z8iyEZwPvZg/Fr6mUl3BI3IbAeV77dTzL3KBqHbNihs6qqHWthjNbaNrvXaNn7MUIewbZ4SjiuSbwiV+KciXa42uYNjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+Yt9sG9cPme8SFDZkYuVA6of36M6FqmfbeMJE9J+Fs=;
 b=GKGCAdEWuDapz/50+mXoze5yfrMY6VwUJu/ONbd5v9ks+1RMId26gjgJ5FzTXIOpWo3Qiz2pZPOGxngtMaQ/Zz+vks5Cn0yODhx9KpZ4RP1BDFR5OKVaDpwFd8N/WEhrcw299ECFkSiGgksW7zzri1uCo1ipbMBHjdI/4mvmq3gXbqgAAr0u79RR3uWyMEFO1gSBAqrUMunH7G5O7V5VlYwRNf18QkN+LlPQJjlqP3e8lmQazJqZ7ELAvpi8qNHgj7kIhxF55Gipcr7cD9i44yhgnkpWPxBfaunaB/CskEuXVZBg3xAFXRiQg9q7ZRO9/rFj2LJ0h5K8+Oo3co4qbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+Yt9sG9cPme8SFDZkYuVA6of36M6FqmfbeMJE9J+Fs=;
 b=NG/wYklGHBGg8ZEdIwYcu1UeQhVPdiewgqcNQx7J9yZzlg1QAziUx6shFmiBu+OAML51Msk0wdEUpNx8lr/wTeiJ8EjNHhkL4lJVUxZkChx1miXjwqp6udI2VBNvfmAVgjznPT3o+N7Z9u1BzFmNq5C/YrbaVy8STac6fkkouuE=
Received: from BN0PR04CA0072.namprd04.prod.outlook.com (2603:10b6:408:ea::17)
 by SA3PR12MB8763.namprd12.prod.outlook.com (2603:10b6:806:312::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Fri, 2 Aug
 2024 15:29:05 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:ea:cafe::58) by BN0PR04CA0072.outlook.office365.com
 (2603:10b6:408:ea::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23 via Frontend
 Transport; Fri, 2 Aug 2024 15:29:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.11 via Frontend Transport; Fri, 2 Aug 2024 15:29:05 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 2 Aug
 2024 10:29:04 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdkfd: Handle queue destroy buffer access race
Date: Fri, 2 Aug 2024 11:28:45 -0400
Message-ID: <20240802152845.7978-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|SA3PR12MB8763:EE_
X-MS-Office365-Filtering-Correlation-Id: 54aff75c-7d3b-4e85-1565-08dcb307d832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DqTMAXwphAUqyqTO+JBmPVxutcCN4qZURD5AByOLT2dp82w9VnpTSID9JwFH?=
 =?us-ascii?Q?k2wgVyjYi7JPw7ytLxxBHcMVGwHkjZ3vnxPz1ZPsNA7Lq4Ywm/N9d//50nfX?=
 =?us-ascii?Q?5pppHnROeahDtu55FZpefq90/qIm+IcN86h6gHWFZLST6JUaC3pMctczf1pw?=
 =?us-ascii?Q?0X8sY+hnfnGlFTo/uxMvnzCB19uU0wA3AxL23OTLkS502Ze7pU1ZpVcP+gHI?=
 =?us-ascii?Q?d5Vkl5DkBaY4ixJF+4xg7OuZz7HeP3ju4ZxXyRLCqLrTpUzeUT0UoJiU1AIU?=
 =?us-ascii?Q?JfaMG3FV5zsdnT4TKzodBoygiknqLMHV1zaNTXtgZjVQjf5CqM+Yx7HYSPJ/?=
 =?us-ascii?Q?9bxcy/3az+9wyKjxckFoYPL7RxeD4YlwiVXly7Eee3mWSLwt80BBolVfTizH?=
 =?us-ascii?Q?Ys7yyAgN/LJrNhGqYEYuttouswWeyKWqLF5rhhsZIFbEfpcT9Ox0NzNOm1af?=
 =?us-ascii?Q?fs3/zh7QmQ6ftzXpDe3AJ80SLCdWmxTDXKDYejJhDLXicyf0R2M40RPHmFSu?=
 =?us-ascii?Q?29sIMEaYZzVqQC6sMf6Pe9VuyyOJIUm1fi+QF2lwHOj6f8CukEmAsKsalOsQ?=
 =?us-ascii?Q?Fydr29iPck65xl9epuVeroRw4nKYPgSfogPgSU2zQzZYfmEgOF86pQCbNI9c?=
 =?us-ascii?Q?yTMGHBIhYjrVMk2OOpa+jDFt8EHm08St+mRAxEJsZkOnAtdmbNFHeLW2ocKH?=
 =?us-ascii?Q?c2MqtV455+882bllT/mhGEBscRnzfwFuJXa7Vm9O9Dr/GniQgv5WwvHyn6P0?=
 =?us-ascii?Q?/kx2PpgetnkS4N0aqn9e7J+4aGNZVkfLcysW50UOCMwoFpfc/EwDMBYkNKAt?=
 =?us-ascii?Q?k3KjugpPe4CSCPOXmDIsp/RUOXyWgRANBptzOh6EjfMG6v1U1a1rTvRNcpqQ?=
 =?us-ascii?Q?2oHozTOFqzVjIdHHqxHZ8qY5ty3Rni9QCgV5tKzbncnFW3VIJRIlVsMEHz9/?=
 =?us-ascii?Q?+/AL0aEyROOHNrUZF+yMhGhrnMYvMkPKwDlHtJ6suP+d7cZ4JwlGdIBihQH5?=
 =?us-ascii?Q?nps61r6cM71lqKLW3NAfLsrzlgoVkWbEvOkv1Ztl0audkvnLofjrKlhCPcfK?=
 =?us-ascii?Q?mwEFD87HdmeMJxXfIPtSDoqXiAtaWEqvHv5PwidJe4aQJT5Hg61vnTh0ZAmH?=
 =?us-ascii?Q?5dbdm6UYZ/MZj1ncLkcBJfBseQkrPfD6yN978sevw+5JYrIaJcPzpJ0+65cJ?=
 =?us-ascii?Q?P6K575BLcf9mI3JzjsiMkplsqwTFpr3vDYCJpkm5Kq851RjjwNMrUeWkVIKJ?=
 =?us-ascii?Q?vBxisz53T9HGdKj3F9mqORn2DY+zq2juzw4NM0UirKLuYF0YaH8iRdyAyttL?=
 =?us-ascii?Q?DfUvk0d3LuGHVitYz5AV6hfjvMViDOeqOU2IUQ7HZDJs0tVxCBM6wNZZzx8g?=
 =?us-ascii?Q?bvKTfguCAgbP9UMx5562lQg4eTQYm8YWRDHHWULoMcm8V/yRH3U5+gwLkPK3?=
 =?us-ascii?Q?uYGmpLATNFCjiljylo2eZSF64yup0x+5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 15:29:05.2446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54aff75c-7d3b-4e85-1565-08dcb307d832
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8763
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

Add helper function kfd_queue_unreference_buffers to reduce queue buffer
refcount, separate it from release queue buffers.

Because it is circular locking to hold dqm_lock to take vm lock,
kfd_ioctl_destroy_queue should take vm lock, unreference queue buffers
first, but not release queue buffers, to handle error in case failed to
hold vm lock. Then hold dqm_lock to remove queue from queue list and
then release queue buffers.

Restore process worker restore queue hold dqm_lock, will always find
the queue with valid queue buffers.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  5 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    |  8 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        | 62 ++++++++++++-------
 4 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 0622ebd7e8ef..10d6e29b23cb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -400,6 +400,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 	return 0;
 
 err_create_queue:
+	kfd_queue_unreference_buffers(pdd, &q_properties);
 	kfd_queue_release_buffers(pdd, &q_properties);
 err_acquire_queue_buf:
 err_sdma_engine_id:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 057d20446c31..e38484b40467 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1298,9 +1298,12 @@ void print_queue_properties(struct queue_properties *q);
 void print_queue(struct queue *q);
 int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_bo **pbo,
 			 u64 expected_size);
-void kfd_queue_buffer_put(struct amdgpu_vm *vm, struct amdgpu_bo **bo);
+void kfd_queue_buffer_put(struct amdgpu_bo **bo);
 int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
 int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
+void kfd_queue_unreference_buffer(struct amdgpu_vm *vm, struct amdgpu_bo **bo);
+int kfd_queue_unreference_buffers(struct kfd_process_device *pdd,
+				  struct queue_properties *properties);
 void kfd_queue_ctx_save_restore_size(struct kfd_topology_device *dev);
 
 struct mqd_manager *mqd_manager_init_cik(enum KFD_MQD_TYPE type,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index f732ee35b531..ef76a9cbc7e2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -217,6 +217,7 @@ void pqm_uninit(struct process_queue_manager *pqm)
 	list_for_each_entry_safe(pqn, next, &pqm->queues, process_queue_list) {
 		if (pqn->q) {
 			pdd = kfd_get_process_device_data(pqn->q->device, pqm->process);
+			kfd_queue_unreference_buffers(pdd, &pqn->q->properties);
 			kfd_queue_release_buffers(pdd, &pqn->q->properties);
 			pqm_clean_queue_resource(pqm, pqn);
 		}
@@ -512,7 +513,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 	}
 
 	if (pqn->q) {
-		retval = kfd_queue_release_buffers(pdd, &pqn->q->properties);
+		retval = kfd_queue_unreference_buffers(pdd, &pqn->q->properties);
 		if (retval)
 			goto err_destroy_queue;
 
@@ -526,7 +527,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 			if (retval != -ETIME)
 				goto err_destroy_queue;
 		}
-
+		kfd_queue_release_buffers(pdd, &pqn->q->properties);
 		pqm_clean_queue_resource(pqm, pqn);
 		uninit_queue(pqn->q);
 	}
@@ -579,7 +580,8 @@ int pqm_update_queue_properties(struct process_queue_manager *pqm,
 			return -EFAULT;
 		}
 
-		kfd_queue_buffer_put(vm, &pqn->q->properties.ring_bo);
+		kfd_queue_unreference_buffer(vm, &pqn->q->properties.ring_bo);
+		kfd_queue_buffer_put(&pqn->q->properties.ring_bo);
 		amdgpu_bo_unreserve(vm->root.bo);
 
 		pqn->q->properties.ring_bo = p->ring_bo;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index e0a073ae4a49..9ac15dff527f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -224,16 +224,8 @@ int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_
 	return -EINVAL;
 }
 
-void kfd_queue_buffer_put(struct amdgpu_vm *vm, struct amdgpu_bo **bo)
+void kfd_queue_buffer_put(struct amdgpu_bo **bo)
 {
-	if (*bo) {
-		struct amdgpu_bo_va *bo_va;
-
-		bo_va = amdgpu_vm_bo_find(vm, *bo);
-		if (bo_va)
-			bo_va->queue_refcount--;
-	}
-
 	amdgpu_bo_unref(bo);
 }
 
@@ -327,6 +319,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 out_err_unreserve:
 	amdgpu_bo_unreserve(vm->root.bo);
 out_err_release:
+	kfd_queue_unreference_buffers(pdd, properties);
 	kfd_queue_release_buffers(pdd, properties);
 	return err;
 }
@@ -334,22 +327,13 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
 {
 	struct kfd_topology_device *topo_dev;
-	struct amdgpu_vm *vm;
 	u32 total_cwsr_size;
-	int err;
-
-	vm = drm_priv_to_vm(pdd->drm_priv);
-	err = amdgpu_bo_reserve(vm->root.bo, false);
-	if (err)
-		return err;
-
-	kfd_queue_buffer_put(vm, &properties->wptr_bo);
-	kfd_queue_buffer_put(vm, &properties->rptr_bo);
-	kfd_queue_buffer_put(vm, &properties->ring_bo);
-	kfd_queue_buffer_put(vm, &properties->eop_buf_bo);
-	kfd_queue_buffer_put(vm, &properties->cwsr_bo);
 
-	amdgpu_bo_unreserve(vm->root.bo);
+	kfd_queue_buffer_put(&properties->wptr_bo);
+	kfd_queue_buffer_put(&properties->rptr_bo);
+	kfd_queue_buffer_put(&properties->ring_bo);
+	kfd_queue_buffer_put(&properties->eop_buf_bo);
+	kfd_queue_buffer_put(&properties->cwsr_bo);
 
 	topo_dev = kfd_topology_device_by_id(pdd->dev->id);
 	if (!topo_dev)
@@ -362,6 +346,38 @@ int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_prope
 	return 0;
 }
 
+void kfd_queue_unreference_buffer(struct amdgpu_vm *vm, struct amdgpu_bo **bo)
+{
+	if (*bo) {
+		struct amdgpu_bo_va *bo_va;
+
+		bo_va = amdgpu_vm_bo_find(vm, *bo);
+		if (bo_va && bo_va->queue_refcount)
+			bo_va->queue_refcount--;
+	}
+}
+
+int kfd_queue_unreference_buffers(struct kfd_process_device *pdd,
+				  struct queue_properties *properties)
+{
+	struct amdgpu_vm *vm;
+	int err;
+
+	vm = drm_priv_to_vm(pdd->drm_priv);
+	err = amdgpu_bo_reserve(vm->root.bo, false);
+	if (err)
+		return err;
+
+	kfd_queue_unreference_buffer(vm, &properties->wptr_bo);
+	kfd_queue_unreference_buffer(vm, &properties->rptr_bo);
+	kfd_queue_unreference_buffer(vm, &properties->ring_bo);
+	kfd_queue_unreference_buffer(vm, &properties->eop_buf_bo);
+	kfd_queue_unreference_buffer(vm, &properties->cwsr_bo);
+
+	amdgpu_bo_unreserve(vm->root.bo);
+	return 0;
+}
+
 #define SGPR_SIZE_PER_CU	0x4000
 #define LDS_SIZE_PER_CU		0x10000
 #define HWREG_SIZE_PER_CU	0x1000
-- 
2.43.2

