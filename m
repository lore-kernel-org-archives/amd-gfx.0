Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBA3CA5FA1
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 03:47:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E65110EC8B;
	Tue, 29 Sep 2026 03:47:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aus0Rkj1";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011030.outbound.protection.outlook.com
 [40.93.194.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8222110EC8B
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 03:47:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhVPJeN7MiQHUNmIjOVm6KHF1uqVHWv7FVquyI4GLlkULsj2Ee0lDZEBCfOIAV5ucZQ8QOFCYoo9GpgDQ3Ahy0914rn/0a2nw5RpOIaympFYfEUawDWstQCealh/10FvE2Eitz5Tw6sJGTYiglwY7Vc4HlHuuwVL0gqcn+4jedFe8M6JJA2SMk21N2WeWf0l9dFuiC9xSA5TCNJBut7iCZ0x+9+Bpq8BXSs6cPrQYTNzOPttSfWel0BsqqeMriBc+m39eMwy0JJxY7wcKIyeL6MTUc7fr1ZAhqKBq4B5RbpQl7XIh9Q8J0BsC70eIpfob+DNA5Ocrh3zvicYZTt2Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdbCkjABerfju0pDp6cwn9ssl3KS/vWFkx7hBDrzadA=;
 b=pY8qFFSLEpMO6Sec+GaWqde8Xa1Qv9aKNjaz/evslNyEAocGeKrOFrOUzDigKAf6EPwcwDKQwgpWdmll8EoWeGMPzGHc/fX8MKEm6C8NWRgrVX4wHhEy1SshqEorKftH+l7tyL8++/WSlTDErNb2yg44m5LTXVLY8o72sCyQo8W0FiqYPTkl2ImA9I6ba8kNXZhKbB8F/wF2IpD0YDAyMh+kYCGhpKxPFXIfEaBTlmMqpsvKtHP/NpB5+W9RLXk4tAMh8R12KDB2CzNGIvlhRY6vuv1g0dK0KTwQEMllgSE/sm2zcryUdJkljumFAybr9Sx4blY/TNleQCG88cPKaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdbCkjABerfju0pDp6cwn9ssl3KS/vWFkx7hBDrzadA=;
 b=aus0Rkj19Bdm7ke4EUUzzXRj5oCYYPdkHCaXy5gjmsHu5vRlGV8MLVj9JwyruLdzUl8R4NP3FZA9zimz/CTv1jOko9s4viZpE8yyB2C4E3ucDSUQc6hv3rCkxOaWmcXvo49RRfs8PgffHgUdUOEsQNKR5Wz2TDeJgsKK63dOL7g=
Received: from BN9PR03CA0071.namprd03.prod.outlook.com (2603:10b6:408:fc::16)
 by DS6PR12MB324412.namprd12.prod.outlook.com (2603:10b6:8:498::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 03:47:15 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::78) by BN9PR03CA0071.outlook.office365.com
 (2603:10b6:408:fc::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.19 via Frontend Transport; Tue,
 29 Sep 2026 03:47:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 03:47:15 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 22:47:11 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v2 08/14] drm/amdgpu: drop userq_mutex before waiting for GPU
 reset
Date: Tue, 29 Sep 2026 11:46:44 +0800
Message-ID: <20260929034650.2393125-8-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929034650.2393125-1-Prike.Liang@amd.com>
References: <20260929034650.2393125-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|DS6PR12MB324412:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f4291c-c06e-4d12-a084-08df1ddc5a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xxIg9fkxqQD8Zyy731DIJ0sl7pN50m7Zo8Ybfcw90JK/ODRRIXAce53tVBmAsMbfqLEO6vvQmEiAvmQ/6IyOcVpz1OL0IIdqLNwkVi1IYZGBKIOYpozIBxz6LyqnNW3EtVjVukMriaKnAIxUPDGSxfIUA5fvYnRJSzQW+lyBkXqL7puIiEAptFBKk7BIWmpvSVsA17HQ9gbrZ/aHcMINomUMKaEWcUVYpSrJuCW/9h9x06JvP3H7DJp0REGKF6zGsMm9JJfTKpxOCDJUECHeZhs2tc4FbWzVkMu6071E22zuQS2UUBjn3oABxLJmie8Vfgusq3MYNBtS51pdYi5IyItcof4BUblaLCDX9NRPIHY/ANaJpPjS78jJ9Fc9Qzr3euHut2MFf2LhL84QUQKkMd9IvXlgIWZkehDgKzDbOtNS6svxZU9ePUTw4ZS0kk8Zr8OzYffQszQNRtsxmQwo2MBVfV4iSr8vHLgR8+UUt+KHY2JJdRJQOGOJGUrxkplSwnezBLjSRCqkq8F3X8qitH5b4MQ5i6z+NIduMV50qN/pLELMz2qP7kKCTHVULwNclCQM5rpOre9hD4yJ/PGhL6tmVtEOrpfCjrFCosGA8OYY6WFl/YVf2PbCB1wdA8sVEEG9avEvDWn+JOkiWUKI2+q1UYXiXghkDg+unOhM5WRtQbs6CLhNRDcmf5XgM4/jafWL2D3Sx/tLvZar0PzVTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sqy48tfgcr0nt3QdLVYZsRHFrJ7UKdppFsCNM15iM3gNLjPkHwSeJ6q8rK+VbnDvHc7YGs2enIO5Nhtl2ukd9WkLvmvPWJIMNe/RxU2QBlYlJNZ0Jyw/dxpMbd6UBW+7nDBbp3n8NKz2KJInFosSxVJfuY8UNLoNEYnDXuDIA/iz3aEcpQrW6eBUcLBskiAM7iEXFvetNChEO4BO6T2ZGw/MznYNFlAE39PgFgePDVXu3mEVj2TFuqErOw6k1WndyLxWzXRJg5FvmwxeRIBEUezyeE4cTPdkGAl8P5OKk4c/JX+ex1MywrLhGX1/1LulHqoDOH4FjYkBcWhAnrGXoeu16zmu8wyKIcRCbqLSGG4FPj5lPviWpqaBR0rXoUYoK9Sk4YH9znvtKKJx3NpIvqmURJiT4waSbOr4m7ttYFZRx9a6obkWO8/pr88g1jWG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 03:47:15.2061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f4291c-c06e-4d12-a084-08df1ddc5a27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB324412
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

Use a reset-domain read trylock for queue mapping and teardown. On
contention, drop userq_mutex, wait for reset, then retry. Doorbell removal
requires that read lock from its caller instead of acquiring it inside
the queue mutex. Disabling the work prevents an IRQ from rearming it between the
initial cancellation and removal from the doorbell xarray. Apply the same
drain to creation's error path after unpublishing the doorbell.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 60 ++++++++++++++++++-----
 1 file changed, 49 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 322c95201494..a745c752f459 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -428,9 +428,12 @@ static void amdgpu_userq_detach_doorbell(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_device *adev = queue->userq_mgr->adev;
 
-	down_read(&adev->reset_domain->sem);
+	/*
+	 * The caller serializes doorbell removal against an in-progress GPU
+	 * reset by holding adev->reset_domain->sem for read.
+	 */
+	lockdep_assert_held_read(&adev->reset_domain->sem);
 	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
-	up_read(&adev->reset_domain->sem);
 }
 
 /**
@@ -549,13 +552,32 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	trace_amdgpu_userq_destroy_start(queue);
 
 	cancel_delayed_work_sync(&uq_mgr->resume_work);
-	/* Cancel before taking userq_mutex: cancel_delayed_work_sync() waits
-	 * for any running instance, which itself takes userq_mutex.
+	/* Keep hang recovery available until the last submission completes. */
+	amdgpu_userq_wait_for_last_fence(queue);
+	/*
+	 * Disable IRQ requeueing before draining hang detection. The worker
+	 * may take userq_mutex and trigger recovery, so neither that mutex nor
+	 * the reset semaphore may be held while waiting for it.
 	 */
-	cancel_delayed_work_sync(&queue->hang_detect_work);
-
+	disable_delayed_work_sync(&queue->hang_detect_work);
+retry:
 	mutex_lock(&uq_mgr->userq_mutex);
-	amdgpu_userq_wait_for_last_fence(queue);
+
+	/*
+	 * Serialize queue teardown (doorbell detach and MES unmap) against an
+	 * in-progress GPU reset. Do not block on the reset semaphore while
+	 * holding userq_mutex: recovery takes the semaphore for write and then
+	 * (transitively) userq_mutex, so blocking here would invert that order
+	 * and deadlock. If the trylock fails, drop userq_mutex, wait for
+	 * recovery to finish, and retry.
+	 */
+	if (!down_read_trylock(&adev->reset_domain->sem)) {
+		mutex_unlock(&uq_mgr->userq_mutex);
+
+		down_read(&adev->reset_domain->sem);
+		up_read(&adev->reset_domain->sem);
+		goto retry;
+	}
 
 	amdgpu_userq_detach_doorbell(queue);
 
@@ -566,6 +588,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
 	amdgpu_userq_fence_driver_free(queue);
 	queue->fence_drv = NULL;
+	up_read(&adev->reset_domain->sem);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
 	/*
@@ -761,16 +784,28 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	if (r)
 		goto clean_mqd;
 
+map_retry:
 	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
 
 	/* don't map the queue if scheduling is halted */
 	if (!adev->userq_halt_for_enforce_isolation ||
 	    ((queue->queue_type != AMDGPU_HW_IP_GFX) &&
 	     (queue->queue_type != AMDGPU_HW_IP_COMPUTE))) {
-		/* Serialize the map against an in-progress GPU reset (MES is
-		 * unresponsive during recovery), matching amdgpu_userq_detach_doorbell().
+		/*
+		 * Serialize the map against an in-progress GPU reset (MES is
+		 * unresponsive during recovery). Do not block on the reset
+		 * semaphore while holding userq_mutex: recovery takes the
+		 * semaphore for write and then (transitively) userq_mutex, so
+		 * blocking here would invert that order and deadlock. If the
+		 * trylock fails, drop userq_mutex, wait for recovery, and retry.
 		 */
-		down_read(&adev->reset_domain->sem);
+		if (!down_read_trylock(&adev->reset_domain->sem)) {
+			mutex_unlock(&uq_mgr->userq_mutex);
+
+			down_read(&adev->reset_domain->sem);
+			up_read(&adev->reset_domain->sem);
+			goto map_retry;
+		}
 		r = amdgpu_userq_map_helper(queue);
 		up_read(&adev->reset_domain->sem);
 		if (r) {
@@ -803,7 +838,10 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	return 0;
 
 erase_doorbell:
-	xa_erase_irq(&adev->userq_doorbell_xa, index);
+	down_read(&adev->reset_domain->sem);
+	amdgpu_userq_detach_doorbell(queue);
+	up_read(&adev->reset_domain->sem);
+	disable_delayed_work_sync(&queue->hang_detect_work);
 clean_mqd:
 	uq_funcs->mqd_destroy(queue);
 clean_doorbell_bo:
-- 
2.34.1

