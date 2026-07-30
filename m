Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16298C54FCD
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 02:09:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D98F10ED19;
	Thu, 30 Jul 2026 02:09:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nk0wv7P+";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57FD010ED19
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 02:09:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSO5oAZrSGNH02ku84vLvEdjqETqL1Gu8foo9YmwVJTy26jdYTlmiA/d4F9J7mCnFscumN99cQBwBPt6151an9MeMIUcNQmVGldBUUGmX5IneZq+CCjutNj5+115JaXmk4bCcmiP0ni5BRNP21TCsfCGGviSqJd1K2R/31hdzCJQkCE2VR8mxZxxVpLpu7RnTc+Qq5bMGPMM/zS5DnWZnbZSaNDsAg1iMNVv4bIjg5RjqhjnE3iQ/sLloRdy84kcmkRVM49Zn9++GoMIJIima/GUH+PuXwT6dkigkrydXIa5Se5MBSeazBE1gFbsXhjhyQltap95CM7fX+EC3cK8NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEfVCEVhV4udqz8ZwhNjXDjW7iPoJ59auTqtegrJ10g=;
 b=hFW9zhgcZab9Do5Bp6qDBL4XjCkyrh0bN6Yi6xb/BPAYNzC/D8nnRYfsE76bYI0qyUwUzLPj/UAZLb3A8iGOZ8EHTNoj6oH8rD93QnKre3eGrBlUDvEm7wKc+czwWcGKsg3TCSm75s7Q7m6PyTo4JO4oEWl+XwKIP5Dyl6HeMEPEP/JUbHof9aTPHrVtomIp4OLHFcf2nyQ7J0tmBqp56h8uC2ffnp8VbfVudzcECRbwVAFX44qrOMC3/qq3VheGBPapnkYWy+8FrDiQDJmwkiw4nDmH/hZEJAa6V3P7YeTHZgcHl/7aWcYKx3YSo5rRmpOWrqBsmI9JOj1AdBdNxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEfVCEVhV4udqz8ZwhNjXDjW7iPoJ59auTqtegrJ10g=;
 b=nk0wv7P+FL5wQMV81nARyyWunfpJCaNBILyAXBvJf8NUfmC8A/WVssw2iJJ0cflXwOdbS5sPVy1efRz2u1FsNF5Dw6sU1nzGITQHohkeqRYaGRyO2ncVHQ+9CVLfJ+E0M2zN2YFtBH5rTBBq9fz1MGIu0zQwlujaAIsIiYR4iq4=
Received: from BY3PR05CA0002.namprd05.prod.outlook.com (2603:10b6:a03:254::7)
 by DS2PR12MB9591.namprd12.prod.outlook.com (2603:10b6:8:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 02:09:23 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::a6) by BY3PR05CA0002.outlook.office365.com
 (2603:10b6:a03:254::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Thu,
 30 Jul 2026 02:09:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 30 Jul 2026 02:09:22 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 21:09:20 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Michael.Chen@amd.com>, <Shaoyun.Liu@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu/mes: refactor the
 amdgpu_mes_alloc/free_proc|gang()
Date: Thu, 30 Jul 2026 10:09:10 +0800
Message-ID: <20260730020911.234193-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|DS2PR12MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e96663-0e64-4adf-b999-08deeddf92d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 61y8iPYKf/YTmediD/Q+K9guk0Vin8T4Zg768j4KJ+ftCqvLH1iOb27z2O4HxQFPk2PtQ+3YT8tF1vdoqOUxAU3WJl2+RvuokDS28QqkYt+BKdPOVS7wrruA5srm+npHFMqxqdhszdgSlgA8NN6Z+cyvCDKqEzmwWzpjC6ARCExdj84GPFZxQtQccAI/I1p+9sYn6QFrg4GcHkH+Hoi/7IoREPBcuYvbz47mFwvwCGXYhaHVDCU27f4cG2WdG1ZRMYnnE0Li8Uhtam44KfATrjmghFzUvOSl5M61i3KqVavgtLsJAurve98VlPPtCzYA6vIaXSICa8eMcQq/wMh9/7MmbnDNJLHrjykoaEm4TlXr30/KifYg+QBzZI5p/wL6LPsWwGq38Gv0ChjGvF2pqz2q7iksH4OvgC9Ec360pXm/2qha2+KQMat4MD3I2b5gnkGa5y/nlw3LtzZOdw5Z5VqAXrNhccH5XM5kPRjTJX7Ssox5gL+aegRSGHjQjkDOf8AK90Ji0+Vm8hIy6DlGBWBeoekr8GNbSOeo43Aw/R6h99KndIk9xX/h3oCO+NOtuyuZjayN0L6B3xZUaKsY2iCR5MKjQMek3pQJDkFO1aiSLJ/LuK/durYhE8voilORZ5eJeg+inBHKRZhhov2L4p/BziT7AjpCMqQo1M2bSwC0e9dADIbjVMBtnivyDLs9tMSKzC44DI9cAdzUPs5beQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wMMw2e9uQyZv5ksIQmhYbc2Et3mIek81srgvhFxuMheZiO4yuSFKnA9sEi1/k7+T//x5VoRdcPL0kNy+ckX1+HnQEWkIzEu1XI10CAsQ85u6kF+2GTywR6TcOGNHXCFI8419dWVEp0Xu7KclixE4hSBOqFBZpPLFPbMqCiwzekL39hveoK0zFcODYjVHrO837wOc4MYBJYqOJOU1AttD450H80qqLQRNB/EfbAJdClOPbyeXdP03yDu0Of+bV+cjyRUtSFh24LP1/YkA/EHohcyam2Sn5rJ5uYhmHg5f4xjKpxEvlv6S5ydW+fnMRSjyl+7MCZlOYniFHD8Thes67Z6OJ6ow/VH/XMkghepwo5egavmLtaae3V3X5GYu2r6R6pe1oEHroHasFzvEuPordYXB8mndqoquqbF29hj64/F6WNLH3Y5lvMHBZwEBzpTc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 02:09:22.9505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e96663-0e64-4adf-b999-08deeddf92d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9591
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

- Unify amdgpu_mes_alloc/free_proc|gang_ctx_index to provide
  centralized RS64mem bitmap management for both KGD and KFD.
- Retrieve the bitmap bit for userq contex index based on a
  per process granularity.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    | 28 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |  8 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  6 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  3 ++-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 20 ++++++++++------
 5 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 9af7c97af5be..e3862095ff99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1040,13 +1040,13 @@ int amdgpu_mes_rs64mem_setup_bitmaps(struct amdgpu_mes *mes)
  * amdgpu_mes_alloc_proc_ctx_index - allocate a process context slot
  *
  * @mes: MES instance
- * @queue: Usermode queue receiving the allocated process context index
+ * @index: the allocated process context index
  *
  * Returns 0 on success, -ENOSPC if all slots are used, or
  * -EOPNOTSUPP if RS64 local memory is unavailable.
  */
 int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_mes *mes,
-				    struct amdgpu_usermode_queue *queue)
+				    uint32_t *index)
 {
 	unsigned long bit;
 
@@ -1061,7 +1061,7 @@ int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_mes *mes,
 		return -ENOSPC;
 	}
 	set_bit(bit, mes->proc_ctx_bitmap);
-	queue->proc_ctx_array_index = (uint32_t)bit;
+	*index = (uint32_t)bit;
 	amdgpu_mes_unlock(mes);
 
 	return 0;
@@ -1071,18 +1071,18 @@ int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_mes *mes,
   * amdgpu_mes_free_proc_ctx_index - free a process context slot
   *
   * @mes: MES instance
-  * @queue: Usermode queue whose process context index is released
+  * @index: process context index is released
   */
 void amdgpu_mes_free_proc_ctx_index(struct amdgpu_mes *mes,
-				    struct amdgpu_usermode_queue *queue)
+				    uint32_t index)
 {
 	if (!mes->use_rs64mem || !mes->proc_ctx_bitmap)
 		return;
-	if (queue->proc_ctx_array_index >= mes->proc_ctx_array_size)
+	if (index >= mes->proc_ctx_array_size)
 		return;
 
 	amdgpu_mes_lock(mes);
-	clear_bit(queue->proc_ctx_array_index, mes->proc_ctx_bitmap);
+	clear_bit(index, mes->proc_ctx_bitmap);
 	amdgpu_mes_unlock(mes);
 }
 
@@ -1090,13 +1090,13 @@ void amdgpu_mes_free_proc_ctx_index(struct amdgpu_mes *mes,
   * amdgpu_mes_alloc_gang_ctx_index - allocate a gang context slot
   *
   * @mes: MES instance
-  * @queue: Usermode queue receiving the allocated gang context index
+  * @queue: the allocated gang context index
   *
   * Returns 0 on success, -ENOSPC if all slots are used, or
   * -EOPNOTSUPP if RS64 local memory is unavailable.
   */
 int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes *mes,
-				    struct amdgpu_usermode_queue *queue)
+				    uint32_t *index)
 {
 	unsigned long bit;
 
@@ -1111,7 +1111,7 @@ int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes *mes,
 		return -ENOSPC;
 	}
 	set_bit(bit, mes->gang_ctx_bitmap);
-	queue->gang_ctx_array_index = bit;
+	*index = bit;
 	amdgpu_mes_unlock(mes);
 
 	return 0;
@@ -1121,18 +1121,18 @@ int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes *mes,
   * amdgpu_mes_free_gang_ctx_index - free a gang context slot
   *
   * @mes: MES instance
-  * @queue: Usermode queue whose gang context index is released
+  * @queue: gang context index is released
   */
 void amdgpu_mes_free_gang_ctx_index(struct amdgpu_mes *mes,
-				    struct amdgpu_usermode_queue *queue)
+				    uint32_t index)
 {
 	if (!mes->use_rs64mem || !mes->gang_ctx_bitmap)
 		return;
-	if (queue->gang_ctx_array_index >= mes->gang_ctx_array_size)
+	if (index >= mes->gang_ctx_array_size)
 		return;
 
 	amdgpu_mes_lock(mes);
-	clear_bit(queue->gang_ctx_array_index, mes->gang_ctx_bitmap);
+	clear_bit(index, mes->gang_ctx_bitmap);
 	amdgpu_mes_unlock(mes);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index c67db2d6e122..977c057dcce8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -636,11 +636,11 @@ int amdgpu_mes_rs64mem_init(struct amdgpu_mes *mes);
 void amdgpu_mes_rs64mem_fini(struct amdgpu_mes *mes);
 int amdgpu_mes_rs64mem_setup_bitmaps(struct amdgpu_mes *mes);
 int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_mes *mes,
-				    struct amdgpu_usermode_queue *queue);
+				    uint32_t *index);
 void amdgpu_mes_free_proc_ctx_index(struct amdgpu_mes *mes,
-				    struct amdgpu_usermode_queue *queue);
+				    uint32_t index);
 int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes *mes,
-				    struct amdgpu_usermode_queue *queue);
+				    uint32_t *index);
 void amdgpu_mes_free_gang_ctx_index(struct amdgpu_mes *mes,
-				    struct amdgpu_usermode_queue *queue);
+				    uint32_t index);
 #endif /* __AMDGPU_MES_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index a1f19888dc55..0e9657f2dbe7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1249,6 +1249,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
 	xa_init_flags(&userq_mgr->userq_xa, XA_FLAGS_ALLOC);
 	userq_mgr->adev = adev;
 	userq_mgr->file = file_priv;
+	userq_mgr->proc_ctx_allocated = false;
 	mutex_init(&userq_mgr->proc_ctx_lock);
 
 	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
@@ -1277,6 +1278,7 @@ void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr)
 
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 {
+	struct amdgpu_mes *mes = &userq_mgr->adev->mes;
 	struct amdgpu_usermode_queue *queue;
 	unsigned long queue_id = 0;
 
@@ -1303,6 +1305,10 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 	 */
 	cancel_work_sync(&userq_mgr->reset_work);
 
+	if (userq_mgr->proc_ctx_allocated) {
+		amdgpu_mes_free_proc_ctx_index(mes, userq_mgr->proc_ctx_array_index);
+		userq_mgr->proc_ctx_allocated = false;
+	}
 	amdgpu_bo_free_kernel(&userq_mgr->proc_ctx_obj.obj,
 			      &userq_mgr->proc_ctx_obj.gpu_addr,
 			      &userq_mgr->proc_ctx_obj.cpu_ptr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 8333bab537d4..6412a7f7b6ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -101,7 +101,6 @@ struct amdgpu_usermode_queue {
 		u64 va_array[6];
 	} userq_vas;
 
-	uint32_t	proc_ctx_array_index;
 	uint32_t	gang_ctx_array_index;
 };
 
@@ -133,6 +132,8 @@ struct amdgpu_userq_mgr {
 	struct mutex			proc_ctx_lock;
 	struct amdgpu_userq_obj		proc_ctx_obj;
 
+	bool				proc_ctx_allocated;
+	uint32_t			proc_ctx_array_index;
 	/**
 	 * @reset_work:
 	 *
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index a914198a4d62..1fd72f18e9a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -143,10 +143,18 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 	queue_input.doorbell_offset = userq_props->doorbell_index;
 	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
 	queue_input.wptr_mc_addr = queue->wptr_obj.gpu_addr;
+
 	if (mes->use_rs64mem) {
-		amdgpu_mes_alloc_proc_ctx_index(mes, queue);
-		queue_input.process_context_array_index = queue->proc_ctx_array_index;
-		amdgpu_mes_alloc_gang_ctx_index(mes, queue);
+		 if (!uq_mgr->proc_ctx_allocated) {
+			r = amdgpu_mes_alloc_proc_ctx_index(mes, &uq_mgr->proc_ctx_array_index);
+			if (r) {
+				DRM_ERROR("Failed to allocate userq process index err:%d\n", r);
+				return r;
+			}
+			uq_mgr->proc_ctx_allocated = true;
+		}
+		amdgpu_mes_alloc_gang_ctx_index(mes, &queue->gang_ctx_array_index);
+		queue_input.process_context_array_index = uq_mgr->proc_ctx_array_index;
 		queue_input.gang_context_array_index = queue->gang_ctx_array_index;
 	}
 	amdgpu_mes_lock(&adev->mes);
@@ -179,10 +187,8 @@ static int mes_userq_unmap(struct amdgpu_usermode_queue *queue)
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
 	amdgpu_mes_unlock(&adev->mes);
-	if (mes->use_rs64mem) {
-		amdgpu_mes_free_proc_ctx_index(mes, queue);
-		amdgpu_mes_free_gang_ctx_index(mes, queue);
-	}
+	if (mes->use_rs64mem)
+		amdgpu_mes_free_gang_ctx_index(mes, queue->gang_ctx_array_index);
 	if (r)
 		DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
 	return r;
-- 
2.34.1

