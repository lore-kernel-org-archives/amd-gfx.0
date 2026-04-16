Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C7BF433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 03:45:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91E1510E800;
	Thu, 16 Apr 2026 03:45:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uGR32YAx";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECFF010E80C
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 03:45:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3kgiSv0OsGqjbjgmkduCnDP1x95zamejL99MjASQvufqRmF5ymmMzejwg8wga9MN0NGrJhRUlKga0kHP72fZaifgF5aYiE67BOeKGpZcljWfqrUQrsz9V6Yk7aUTx60rJ5SyRpmCwaD/StNkuNP8afImf2pJbQ7GR1aI2tMaXd7KF0aTVCJWLuA/xaBftFjg86noZEXmWkHn8tjQwxH6YtIU1dfUdEOx2WNw5Rm969ErqoBx91ECTBcjEsUdvuXWgwQcXln4eq2BJQz2B/byy+s73s8/FRePfo9I21EthmK0WtenLYHFziuk9F0lbluJYVsHVGVBhFuAi40XiB7KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmwmOjmTDZY4TEcx/4Nl7X7RowKL40zERxakyrPDdpU=;
 b=YPFA5+89Z9Fzvv5CxaTFmJHbH36EYBlZlufr++0AERCUdNWRj3kxGUFArtNjZrH5AbdI6J7+7dLjPRdorRC222M3Wi+ts/f1HfzpO4tPcE58EYSnkPcHtxeUQCsDqS/6H3R2Kev55+5/bH7VOXM2Y49IdhiSjYV2o6E2hlf3EHey2pOiwCyTjA7l5BHc6tt2hXtgHENG7NjQe6kSck5B8e+cyyGFQcAStI0RW2DAf3eKCP7Fh9XsJ07+pC+EdCSDCkuBXRpayG3YvAbw+ZXRZtqcTdLAy35y3x8+Nw2YJg2njVqxSshnWjMPX2+cnNKisiWcc7infrl5OncEFpbxUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmwmOjmTDZY4TEcx/4Nl7X7RowKL40zERxakyrPDdpU=;
 b=uGR32YAxjYgfksoY/pDKMIGbAeav+pEy1f88xjt7A9h1RD4LsB1JoojoUEuNpSSgH7VImgXbVadvq613MnuqOdXwhxsBgWMCQ2fdOPEqA6sQs4DVSe22AMyVmnG0qMvhZY44PUX3yYkGjq8EWeKPVYzxqkrDDoyOS7gbqcsvK/k=
Received: from MN0P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::32)
 by IA0PR12MB7773.namprd12.prod.outlook.com (2603:10b6:208:431::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 03:44:57 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:52b:cafe::2a) by MN0P223CA0011.outlook.office365.com
 (2603:10b6:208:52b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.51 via Frontend Transport; Thu,
 16 Apr 2026 03:44:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 03:44:57 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 22:44:56 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v4 09/11] drm/amdgpu: Detect queue reset in WAIT_EVENT
Date: Thu, 16 Apr 2026 09:14:18 +0530
Message-ID: <20260416034420.2368152-10-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416034420.2368152-1-srinivasan.shanmugam@amd.com>
References: <20260416034420.2368152-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|IA0PR12MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f3a685-d412-4945-9177-08de9b6a87af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0eVhBjb9kOvXIWRg4aqJEePQkbyY4U5HAJ3ievaZWtR2bH+dBy+ZreeXIkTblSQ/cK5I4OqxnCPSLNz6dwYRbjkFI+NHGdtS5RaYwgRoyBV2Rezp9loToUH7QASTQLYmWLwKaEDiLFvsVvvdvMGPT4XFv3Ia7mneC2K0bPaNwO6LSDUsHAWKNBC7rcCn1XtMovtG8C2q53gkGhnNUmm4XPLE0llkkC9eJHI0+YZWKngHyLdTNfw7EwgDKzlFAiDZ8d3bmokQr1sPbUv3yAJBZrR9fKaVGQ6chLM5YwBg8whEbc4tdnD5ok7nnoXflrCUpPN8XZ9tKHGFQ+OUpM+Q7euzhe0r8w6TB7JFw63BsEqWzzY1N5SfHcWP9ZfE5ToR3TAv+muiE9X0yQba1gpu1c3YSk+0+ZYnyfe/oRttYO8bUfgrtt7yMaxUXTosDZVrq3+YGwaUuXPaIc+vDO09xDoCm6L4LJ1euUuhlqcc8jQTO8v+5GkRVMvZw3Oze7ZyH65CW63oBqehSI8XtGaUzZOKu8DI3ufBP+J9+ytRY7hlsSmPd7xZy21IS+GA48AoKisbzoO+Ml2II1gbKcLhXExc2MzfttVmc1BvYTOLNOgFfXqQJz2wIIftdlqMrZcP9++mShRxZyQhW8WPjvXTULAq+i8+NK+vIZo3inL56KrY1iun1O7nSpT3c57BUgkrF4TEdjf1WsyHr/IETMc2+nkPYL6buDhtUyA5UJB0KeOUAFQtlh1XyjRcd4gMkMYkRc5fqCIfq/69jb3ebFUmtQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F+cAT3eNL/D12X10AgUwuSdYxjK8ucvbA74N6s7n5Ly5IucEDFd9PGxEdk5zhacWqiyVCFY4hqBY9drkfLYiU9D72KfGg+dSkc5NJuviR0U8dTjkKSSTLik1gAytJqEX8YSoxlw3LLY82Nkv14NbB0JX8MIxd1KbsyhoNHlv9rDSxzZPZYuK5MSR6Cem4A+5AsEZqe7H7QOfLUfCBj6xs7RntzM13bkYb+yrTz9QIUlIV7fF9guLgoSNYxh0+sZpG69zreizYPyvV2mDK3oCXKeagcF7Z+Wru5h8SlfW0oVP0RfxGFc0e0uBumW1MGMP4vJCDxK0SsYsLNfXy66TfzdQ24cLA7ahTM7wJ8K9MiOzZnXEZH4YnxbELlkucDUhJ3Op0Xzr+ZrTFLahvZh2ERFhUsKipiQ2bCbgoiYRN+Bg1pZsf3n8kpJfG2cKEik0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 03:44:57.7949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f3a685-d412-4945-9177-08de9b6a87af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7773
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
index 29fd98b7ef50..1fe025785300 100644
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

