Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3D1CD6E6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 16:35:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36E661120D3;
	Wed,  3 Jun 2026 16:35:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nroQ1fmR";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012059.outbound.protection.outlook.com [52.101.43.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A41101120D3
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 16:35:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LX9T4vYiV6LhtJh1R8PyIo3X2YkKGOcKNefiXsYtLdix3K4CMCf7Bx92dcBzP46FC7O92b7yD4Eyu5y5odUcn8jHS/E+HqosDfLs18GdZ0Ouxf04e8bLrmPyx0PGc8a6yQ2CDgKEImV54D3xttgJjZ7Qq4cFfE7xFFroaW230tA/NJT1L7sa4QfhLIIstD4Gzj8GfQkj+IbPrGIm/JZfqTuMMR+q0SQW3GutYQCH6gKNRvQA3lEHgdC7NfON7ZEVMiZqoNeeuOrSPrVT6HMD2n1ddgC6gr/0xu0pH9HfqnBnuckwi3vRQGJNjS17CITQPkFe4xG/pyVN++WQMMLZPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5aiSyLGiIA1UqXRJRpw4BYgHBfcCfdbFeDuCQYqwTs=;
 b=VTj0/A3/gDqWKXreVteBy868uqbIe29Pbv2/TaY48xcx394Z8JYeKjTVa7ILFD69LNJfiyrREKKdpNGLmhLaEaixTRzghiWf3ODLNye9HgwJnWa+ERu2AIJuIRpsaM+C4zOkIIpzK/DOlqP6PnGNru9vvXk25Sxb8Gtk3SHlcljw4Xh4sLDrOkNgKeMW4OY16LA/nOh0AXtJM9lCW3qeBgNiCLyqC8fVi6+MjZDxvPz5vwFl844uzn1S1LvyFoOG6jRvYrzxEL83+tamvcjSm8dTiV8kQ9q6X7fQHS6U7fHwOs4TT5IaXIJ4RVoQTT7n5LN5Bii9d1w9JlUGa6EZEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5aiSyLGiIA1UqXRJRpw4BYgHBfcCfdbFeDuCQYqwTs=;
 b=nroQ1fmRyJgMuK9b/x8F5lgAKvFuGT3ihznD8fnNhfsD+zCzT2EjEwkyCZTECrZTfKIlXM9nPwi9G1KqqwV0/bSBGc1RRNqA7dO9rQJF0Fw49uLfcC/1iSSnQoSY1DqW7iGfhA59/ytySqdLOHnzF0pPe7LnTev6X8+9qn9OSJw=
Received: from BN9PR03CA0312.namprd03.prod.outlook.com (2603:10b6:408:112::17)
 by SJ0PR12MB6879.namprd12.prod.outlook.com (2603:10b6:a03:484::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 16:35:22 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::41) by BN9PR03CA0312.outlook.office365.com
 (2603:10b6:408:112::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 16:35:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 16:35:22 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 3 Jun 2026 11:35:20 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v6 09/11] drm/amdgpu: Detect queue reset in WAIT_EVENT
Date: Wed, 3 Jun 2026 22:04:48 +0530
Message-ID: <20260603163450.2678374-10-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603163450.2678374-1-srinivasan.shanmugam@amd.com>
References: <20260603163450.2678374-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|SJ0PR12MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: ba4ff734-6282-4baa-7ec2-08dec18e1b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: WJUraNXHJz9kj9iuSo8dBc7hoUwcrt9kO4B8HDFGScBd4iOhPOULMd+xBAV71wH+qw7v2fAJRUANivPc+Zzulhz9431igrLtJBo4zl1rRH8QRYf648YG2EoaZNzJweVYzi9qcAHVjsB5Fk75kzlFAHYVxyc/U1qx5RZhlwyFn6AfKamh1J77R2XUZZE2vzAk/F3oN6VQhykEquqYnsx8/9KQNDbYSW+LSX/N2IMd6SC1DNHHh5iuvF5cI92k+qG5H7GcZPMuk4MuDz3xjpWb4HUeBb1gLiAtr3+TCJ7bxCFY8A6hfCLVOgbPHsEg8Ojf/RrbCsAmoiwDHYd+jOTBZARwYyK7smnaNME+xrjOD5wqmf6BhbLCeGovqNZHclI88kxTT3kYMgl9hzBOzj5CfolYmbjojIQk9MSYqXwmz1Qc6kQsmzJ+X50vWoxcLzW/cY+m3nts8fsbulwwmsHdAybzLjLhK/wLi57k8d1lfO591g+2J8ky+f5pY4Z6TgpTMMpFv57nSsdbpBYuM6DQvFph6KppJOgijoq7W94MXf6eZhLKf2bhuRJcihU4HfXfHnYT/7+862x9rZZoxz6nu0OvAsz83MvPmQmKW9LckU90EubWHaDO7YNvsVrAFDL/ykMp19eBcF7qf1TAnulFMsD0ZiQ5OpRWHvpF1PKzB6sMaGU7HQJ713/bUrO/wpvTrsIhCRKm3GOszbVXdNYn4VhNqMzB1Db7e9tIHoZt940=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5mNotxB9e3Rm/PKX8TfpxriMN8yBY53eSNLa1FR9h81JP7MSMLXdJyZ0dynSWokeVTERsEraCWAxTGqmwtBkTE2yjVSv09OTtALXWjCOz4B5GY/NS7WZu4UeXuIZ7vexpHoVXuFcZzezPzf2XsRvvjUJjv0yTezspZt6vasLkmz7zafka9bvOLOvuwR8DHcLeD2VQWD9X54yApqFR4RctXLMrpNLSiEyicHaMMANwOzhxRNKDXx781vQsuJUYm/DxS/dwclkROuKygYRLgNLk0JO0YpcSwTdau5llIHhWm5TDmgYsIJCRAUbqhvuSM1tu+Vwgfzqwsb0LDi1I+mklHMrGtCLZoVRy5VmE5FDgNy2ZLnhA4pzwt1vwQfEffm5tYSdu03pnbuJqur99tn2EaCMpj9IS88KqHJHk7hVdqoZmC0N99CkQpO4p2LUROep
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:35:22.0869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4ff734-6282-4baa-7ec2-08dec18e1b54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6879
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

Detect queue reset while a queue-scoped WAIT_EVENT waiter is blocked.

If the selected queue enters the AMDGPU_USERQ_STATE_HUNG state while a
queue-scoped WAIT_EVENT wait is in progress, return -EIO instead of
waiting indefinitely.

The queue lookup uses the same doorbell-index keyed user queue mapping
used by the existing USERQ_EOP path.

This does not change WAIT_EVENT UAPI semantics.

Changes in v5:
- Use queue->qid instead of doorbell_index for queue-scoped event
  handling (Alex)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 20 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  2 ++
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.c    | 15 ++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 7d737d55c817..1dd0d5f152af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -160,6 +160,26 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 	amdgpu_userq_mgr_reset_work(&queue->userq_mgr->reset_work);
 }
 
+int amdgpu_userq_wait_event_check_queue_reset(struct drm_file *file_priv,
+					      u32 queue_id)
+{
+	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	struct amdgpu_usermode_queue *queue;
+
+	rcu_read_lock();
+
+	queue = xa_load(&uq_mgr->userq_xa, queue_id);
+	if (queue && queue->state == AMDGPU_USERQ_STATE_HUNG) {
+		rcu_read_unlock();
+		return -EIO;
+	}
+
+	rcu_read_unlock();
+
+	return 0;
+}
+
 /*
  * Start hang detection for a user queue fence. A delayed work will be scheduled
  * to reset the queues when the fence doesn't signal in time.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 66ef69311205..8a4d517e5247 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -178,6 +178,8 @@ void amdgpu_userq_reset_work(struct work_struct *work);
 void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
 int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
 void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue);
+int amdgpu_userq_wait_event_check_queue_reset(struct drm_file *file_priv,
+					      u32 queue_id);
 void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell);
 
 int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
index f900a7f5f90e..8ecc4e40a95c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
@@ -29,6 +29,9 @@
 #include "amdgpu.h"
 #include "amdgpu_wait_event.h"
 
+int amdgpu_userq_wait_event_check_queue_reset(struct drm_file *file_priv,
+					      u32 queue_id);
+
 static int amdgpu_wait_event_do_compare(u64 addr, u64 value, u64 mask, u16 op)
 {
 	u64 rvalue;
@@ -282,6 +285,14 @@ void amdgpu_wait_event_push_gpu_reset(struct amdgpu_wait_event_mgr *mgr,
 	amdgpu_wait_event_push_common(mgr, &data);
 }
 
+static int amdgpu_wait_event_check_queue_reset(
+				struct drm_file *file_priv,
+				const struct drm_amdgpu_wait_event *args)
+{
+	return amdgpu_userq_wait_event_check_queue_reset(file_priv,
+							 args->queue_id);
+}
+
 int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *file_priv)
 {
@@ -348,6 +359,10 @@ int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
 		if (signal_pending(current))
 			return -ERESTARTSYS;
 
+		ret = amdgpu_wait_event_check_queue_reset(file_priv, args);
+		if (ret)
+			return ret;
+
 		if (!timeout) {
 			rec = amdgpu_wait_event_peek_match(mgr, args);
 			if (rec) {
-- 
2.34.1

