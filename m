Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C34F43857
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 16:08:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC4DC10E721;
	Wed, 15 Apr 2026 16:07:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5efCFq3Q";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010020.outbound.protection.outlook.com
 [40.93.198.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D6DF10E71A
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 16:07:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDGCiUd/HSVvrKvu64g+X3KrOm+Vv4a5bloDkBZzbw3QJX4xAc/ttw7Pz44Tndw1zJXgPn+10Wmk2qWqdUzcambFR4S9y7iaKLp2wvU29MH8SM3M1fRMlQ1sM214d6pFFCOZUlWgnDZuCttgMkSzTpuEWDz54hx+gw5RWG3fYhEGTHT09UBBksu+G/GPR4Sj2zwb54odkTuZZCXNLFceOTVupgSzH+lkMdz4aT7QIJVVOb4WzQFqU7sv9mn2bEaQ6wksQaI+QsL1v48LNMKD2bWMb3CKJNaN2xg31Gd+PHlb9E+2aV20loWSnKZqUjsOeBrr3mIvIAjxVDHC67sfRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbPGtVuwIXBgvM63rx/hwBmd8uqKlFG0w/Jmb+Npa+Q=;
 b=rTdl2aGgCYEQJxNYsHA3qDR0+0Q75QcI6l1FKH8Fva4od3RN4t/42JT6XLSDgAxlOG6sycOHyF5P+SUsOMyfMOS6XtyLvbhflIfmMmPkozl+3eu8yGd6g63J9ni0X5rLj3t5Ga7nTtGnUYMX79dhR23gEUlMrwgJ/q6De+iZK1uGKc6RhTtf4NuNBL1IfKhqHFBgp3NXVj/DV9cT3CDtff7tcugguVpeAW1Q3tOajZ5YgVuKDwPy0upsVjk1Ofs9qt7BimlqJy8BahmIz2DRO7HkoHV1ZvKVnILW5brGoeCVt+noqOop3RclTUU0IuF2Yyr7sF6x9XzONB5J3yup1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbPGtVuwIXBgvM63rx/hwBmd8uqKlFG0w/Jmb+Npa+Q=;
 b=5efCFq3QHJjpZ2YwdoNRnTBzGqLbJPv2RxR3JOS6CuO0XmzC4OITCat8aM/a+xagMgPr3MZ9KDwAQidWMTydEPAP6Eof35gg6q3KrgCsxmVgvs9Hrlw144uzWFbUeUtkB92+61afvp4Z+RzcdeaRJz+ODGc7mONzQWJFhjwTC1c=
Received: from SA1P222CA0184.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::29)
 by SJ2PR12MB8884.namprd12.prod.outlook.com (2603:10b6:a03:547::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 16:07:52 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::a7) by SA1P222CA0184.outlook.office365.com
 (2603:10b6:806:3c4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.44 via Frontend Transport; Wed,
 15 Apr 2026 16:07:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 16:07:50 +0000
Received: from rtg-navi32.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 11:07:48 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v3 09/10] drm/amdgpu: Detect queue reset in WAIT_EVENT
Date: Wed, 15 Apr 2026 21:37:10 +0530
Message-ID: <20260415160711.261553-10-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415160711.261553-1-srinivasan.shanmugam@amd.com>
References: <20260415160711.261553-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|SJ2PR12MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: 10574969-355d-4cb4-ee12-08de9b0924a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gygn9ot/DK5m2hzJBAdGJOqKGmgu77XcEgRTTSpmdSTPTt3V+RZh1Z6vG9nz8aOfHkByKUvlxPHIfZIquQ0DrEY6+8ycGTsBTLJPv9ZiVBecDdK4xMecgOeJ2tCp5tvY3+c9Khm34Ew77uTJ2g0Cm2t0sUAVw9kcsceM+Lwqa62puvFVs4XiDqcf+/R+lWTMrWico/wDjg/gakguJ26pLw74f5B4FO88QODWemwS4n2ggqR5K/HaThEam2oQVfJHnBi5/AcnjPEcVtlmr5ukuSO1v4bP+pi3Ip1MsRdyY9ov9YWzq+I2WzJE+qMuYGdzy8/lY+B4d9vcfWEY8/1bXN5H8XjkUsAgGjD5nsRbTQGJ/kzj7NE1Vk02uu4rmb5huw0mwrvzBbSOqCwAvMG4L0d/KLEAvBCxBH1SZFoIaUPSBJQsFk2Do1qYv7bRukmr5ytsusXKpE57jIEshCVMiCxSdjnNv2/Rts9yhRlz7uzkdDIDYV5hIE/LMH63gMh49Kh5o7EzqEPq/T09BxMjOoxdC6eHaHy6ya5LZ9MYJ1DC6MDDA+AHATV+s70ET2hYb8yoyzlT/hvFQ3OT6EvO2PgfoxJpPsDQJFPc5aF2DoV2Op7BiCSUwRMBY4Fpddv+evTlO8EGaPri6KYHUGH5waFzBNbNmy/v3omRNQBJCekqYclySJ3wKYgIvqSu0TOZ2LTOq3YiXjtqUwbUUQDn+8DN+OZif8owHviMOYXSGlGeqr+yMli0Iqz/KI2a9znITR8qeV0ny5b49hbugs1GHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1AI1pTJtPTkRydeiL+WEcAJfslXehwWLFKJ+pV6e2mURe40X1Pj3ZKizs3fxsw5OSE83CZQX29ABdWv7gJMa0VgqaZTf/DvnIVXm20J+l5PTYCzf7UxCnWFkyllDf74G/nYZDfR3rVKfOKrB9mBKkVrc500SOxZ7Wmu2LLkgmfWnHr87AZ5FKDe09o/JDpxAPPDz0OSjwNUqUDoqnJ59FNb//5Hif+MUPdJrQvtdSQLTFvKwYZLcvZpyNkUJblosk8wSPH+lY0Cjr+kCI9VevLq0T0U6QxCy7S7gCEKP3m+UJcwGrEcWDjePou9X8nAbU9l8HjCA1pEj2UzcSzv6RtpVYqdVyGKJXcaeNmyOUoGl5sHRkUvLEUI+VL7F38q3XeQ0+ewRLmvBXpg0RSsOXxaQos3UQA8xYtibG+EiQQbZhd0zRluIryF2oQsOpGv5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 16:07:50.4413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10574969-355d-4cb4-ee12-08de9b0924a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8884
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

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  3 +++
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.c    | 14 ++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index d3c2cce44db3..a6588eceb365 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -170,6 +170,25 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 	mutex_unlock(&uq_mgr->userq_mutex);
 }
 
+int amdgpu_userq_wait_event_check_queue_reset(struct drm_file *file_priv,
+					      u32 queue_id)
+{
+	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_usermode_queue *queue;
+
+	rcu_read_lock();
+	queue = xa_load(&adev->userq_doorbell_xa, queue_id);
+	if (queue && queue->state == AMDGPU_USERQ_STATE_HUNG) {
+		rcu_read_unlock();
+		return -EIO;
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+
 /*
  * Start hang detection for a user queue fence. A delayed work will be scheduled
  * to check if the fence is still pending after the timeout period.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 725c33ab5c44..4f3e7807e561 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -159,6 +159,9 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
 int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
 void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue);
 
+int amdgpu_userq_wait_event_check_queue_reset(struct drm_file *file_priv,
+					      u32 queue_id);
+
 int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 				   struct amdgpu_usermode_queue *queue,
 				   u64 addr, u64 expected_size);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
index f900a7f5f90e..3bdf5b4e40ca 100644
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
@@ -282,6 +285,13 @@ void amdgpu_wait_event_push_gpu_reset(struct amdgpu_wait_event_mgr *mgr,
 	amdgpu_wait_event_push_common(mgr, &data);
 }
 
+static int amdgpu_wait_event_check_queue_reset(struct drm_file *file_priv,
+					       const struct drm_amdgpu_wait_event *args)
+{
+	return amdgpu_userq_wait_event_check_queue_reset(file_priv,
+							 args->queue_id);
+}
+
 int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *file_priv)
 {
@@ -348,6 +358,10 @@ int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
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

