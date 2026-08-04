Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD09C55184
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 03:17:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FD0210E81C;
	Tue,  4 Aug 2026 03:17:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UH+YXnlY";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012000.outbound.protection.outlook.com [40.107.209.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0E2C10E572
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 03:17:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4Bh9umvZoM+JY4OdN3c4OKrASuWVd1e+stLN3mKtFvFyTnKOT0LvEMxfHo70qB1OPidST6xIwDGDBxUbJ0K57YjYjIcPfPDznv+I6/WJ3DOK4qfHSKEffKQG+AqjH2ouTIveG8M+WFabgoKWs6TnpqZgWmLm3Mwi7SOtIuew/VUVPGnfPi7+12MH3JEB9qdVjGXpKyRx2s6kb3UMbqDAv/qFcM1RvKLCfKOGqqrQ2oM4Q2n0Dem9RxGpR0hiNxnIvy8nWChSZgzFa9gfjXNg6BgzS0huLn2Xnk8qiVQ/ST4kPCgn4IFlLiAIeNwAKdX/CHPv7Sw8CN1+OwYV58tZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNYAlvRikm8bnYpq9soXI0FSElTO8mwPZFdJXtsGiiM=;
 b=UGLQJ4Xh2owrw/XZcmPX+8XhdXQinKFUEzNnSxY06+/+cIGfxZnpGdnPpOs0I0VsvHAqa7jMKIJ3G2HgBHiezbB+vOb1jQ3eAypRkgLLnmkiKnTRsmYbY1FPiWwPYtStzbvEsU6BQ6BD4uIQpN7atLyQJD4V2JfkMxGZLXl2LnbWJ4SKIbRmKIAUCpVeWGkKNKumu3t1ZFx9QM2ToAdwdKWPSBQFbxHQxeAlpljqi1DnWV3dlOBc0s6MkYggZd4NSx4ZQJL4ibCAe3VoT+JBeb2CXCJ9yHa77GTB7IonDgPj/Ei4o0HLADttAWf7pNzRy06k/RUOGpxeh8q+ryTV7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNYAlvRikm8bnYpq9soXI0FSElTO8mwPZFdJXtsGiiM=;
 b=UH+YXnlYrUCGOHU8VpZaOk4WUodigly/9oQ5vNqJ45+GOCpN/m9UAu6OylvX5DTx/2BwrCgtxZHmbPY0C5p4+p9GH8jkAJfZMUsWZug41SofpZkvzg6YKZKVEk6+gkdW/TfrhXo4I2CqXUCg0o7EKcZ7+uTDRTewwGoY1zKNVGQ=
Received: from SJ0PR03CA0044.namprd03.prod.outlook.com (2603:10b6:a03:33e::19)
 by BL3PR12MB6620.namprd12.prod.outlook.com (2603:10b6:208:38f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 03:16:58 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:a03:33e:cafe::19) by SJ0PR03CA0044.outlook.office365.com
 (2603:10b6:a03:33e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Tue, 4
 Aug 2026 03:16:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 03:16:57 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 22:16:54 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Michael.Chen@amd.com>, <Shaoyun.Liu@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v3 1/2] drm/amdgpu/mes: refactor the
 amdgpu_mes_alloc/free_proc|gang()
Date: Tue, 4 Aug 2026 11:16:45 +0800
Message-ID: <20260804031646.308213-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|BL3PR12MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c4bc95-5ff9-4d8e-603f-08def1d6d774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: v6XgQIAKFSiQCROKhnMIWg363D5q8bStX/MUoMKYVAXacSILurwGzLErwXMUhAiWfXXefeRe9T0jcve+ZlFY+kYM9lJqJlQuryIOYB3yjAbfEU0TUvDzWEq8kMpfBCNrTMXyV3aDbW5v8Mfehzh0Zv8tiC9G5NUrCTsIgZ2JrQ6bgbYU9AkybSFMzCpv15XTTO9srA+yGOcIjGVihIc51JMvyOwu24h9MtAMKHcJS9BrcloOpbCW1fq5TyhqnF7UKdjXrRI1FlZTq2Ab1l6UrSMTlMfVNVP+NHb1PrX3r1WYHb65TRSNESkcRlQiugut4KZX1sVAoJR7FZN3AHNKYwbrCiX68pjTY2y+kgYxGMbyrtKmrrs/pb8pps/wWfIUU0cMvsWX8D3zrC1FOlBXiUGnIiCXoIrB1b3Am2Y/CIm/zuq/6/PUyAQQHMg1WTtsnipyWqYBNVZi/kRsgkcpu6iV3EcSCdOZxeIP7utxjNlkhw4/sKsCKJfgLvt8FDd8LI30i735696zXvyDqQ47/wCd9HwTIyIGkCy2WxZa5VIJmUiSyYhFopYGJsSc992A6oeuaHzFzRQfSInVo+Umd6e/4iLk9jS5yXfU9kU7zV8mpORCfJG3dfhhtiSn66kDbhTGIoPYPeCSXzvtUIKbL4Oj3uk06/EeljafpIenb4ACgMbyZmJaE0LXEGGrfxfdGBPkEPV8bgl66BGwsoNzlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Cs+1nEeVu8Gr3zoyvcZ2fAFNVEpdZ55kPIDvhQIQ7A+UObqwWhmUNPmg5gnv0uIcbDE3/+a8rBS1FK71z7JRNsUYeGOsAQb7IvrV2APo7fsW6SXuy0qa58G9J0QFHM7mm2v4LFIRyvwdGvGCeGIBvctqdNgOXgCd9PNgQSpZfFvU3oMUTfdL0r/Jj3bhUkNbVLWMFx+Sjilp3LnlviBDO/xvPeJ3mqxiFL4LMKTQD3gtQ/6Fsx9GAR7TI5pJpbzpVS4Ru3t/1hu2RPdHX0mlY/MC3ehSRphmGRewXVfCbDjOUkiLVz3GryKq10K25Kh7h/DLIn2vnNA2YWYt4ct4hMWFTwcezBA+8xyh3GIBa09k+Z2hFxijRvzxspXGcdLpgchr86DXNCsh+7Sms9WJ6tvv9ZDTmimW47CLp9IRdquTMfWIQdC+K7+YM6xA75rV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 03:16:57.2472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c4bc95-5ff9-4d8e-603f-08def1d6d774
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6620
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
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 26 ++++++++++++++------
 5 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 9af7c97af5be..5998e05ecd79 100644
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
+  * @index: the allocated gang context index
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
+  * @index: gang context index is released
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
index 571413c9a611..5dd4fe258cdb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1244,6 +1244,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
 	xa_init_flags(&userq_mgr->userq_xa, XA_FLAGS_ALLOC);
 	userq_mgr->adev = adev;
 	userq_mgr->file = file_priv;
+	userq_mgr->proc_ctx_allocated = false;
 	mutex_init(&userq_mgr->proc_ctx_lock);
 
 	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
@@ -1272,6 +1273,7 @@ void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr)
 
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 {
+	struct amdgpu_mes *mes = &userq_mgr->adev->mes;
 	struct amdgpu_usermode_queue *queue;
 	unsigned long queue_id = 0;
 
@@ -1298,6 +1300,10 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
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
index 402dc2816f04..4dcf6151de6a 100644
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
index a914198a4d62..ae403bb89441 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -143,10 +143,24 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
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
+
+		r = amdgpu_mes_alloc_gang_ctx_index(mes, &queue->gang_ctx_array_index);
+		if (r) {
+			DRM_ERROR("Failed to allocate userq gang index err:%d\n", r);
+			amdgpu_mes_free_gang_ctx_index(mes, queue->gang_ctx_array_index);
+			return r;
+		}
+		queue_input.process_context_array_index = uq_mgr->proc_ctx_array_index;
 		queue_input.gang_context_array_index = queue->gang_ctx_array_index;
 	}
 	amdgpu_mes_lock(&adev->mes);
@@ -179,10 +193,8 @@ static int mes_userq_unmap(struct amdgpu_usermode_queue *queue)
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

