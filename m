Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C15CFA466
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Nov 2025 08:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20B9B10E1EF;
	Mon, 24 Nov 2025 08:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HDCXuydy";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010052.outbound.protection.outlook.com [52.101.85.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F011B10E1EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Nov 2025 08:58:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pEQyRbNXw2os6Gq8tnwG8BnqBd7b+8xTG0WG2dsW2w1GOX9Z8xoYkQoUVc1HfQwEoIKxulbg2IlN3sS64doQe6z+Sie0YUlHXTDeBEmrVjj+PStX4ICNohPpJYDL2K1qJ64+LhGFVpGaFkm9lZ7JaP+71/Om/Ca+bTirc9D2gNSWUVWkgxcwebmZXiMpV+gnWVcrV1S9psgogPT47MjP9+zjeyS2talMuiVICrLuzSMdvflZ5beM1+8IZWXfro+XTGtMoIhat+UwdE8/Wy5SljlzCwAQFX4D8P7JeYRIQrt7WaFyGXDJI8ba8JR4Qi1yiBTsOLg8wkHGsVar8wTx/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ph4EBY5VIU3okIU07C6bNdU8wdTPVqi4cMK8xG9duSU=;
 b=Or0xATex2T9HrdqIdBvxLr/Nm74OsDEzG0J67ZmeLF3p1FveipZhrl9XRm7q+XFjX7jBQd8uk5M8dhgbd8f5ESGqTXyViGFlik7ME/woqAw31jj8FItoLVTheszfMzDpHHbh445MgvTALC1WeOstXxr9iEqAAG6CqcZWbg6vraL/HEv8iJ1oW0nHP2obZpngk+rF5I0uukd5YeKA/xckA1pLes/hMnmUczxrnnM9e4suHnMPNvqEXRvEEsusOB+UB6k0H88n/dWaFFBkZGKqwq2CeMv0amSBnxMI09eXEKksCx3yzRpZOYkDXrKlpkbY6LOGbrHAAiudKX6C8yvRMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ph4EBY5VIU3okIU07C6bNdU8wdTPVqi4cMK8xG9duSU=;
 b=HDCXuydyzgCjenMwkW7sV6wTT8bGD86mnFl7Qm1ISBo+U+Qeq2TkGfb8BVbZSS0L1jweD+Sl2MIbio9SnGJJavZIYM+0lw1UvsRfLBGX3ipchFpd3GtiJ8BmK1RoX2OIz+RIjZGKd9bEFI1iIh3XLJQSkTtwa2wtom7AcXSjtpY=
Received: from BY3PR03CA0021.namprd03.prod.outlook.com (2603:10b6:a03:39a::26)
 by DM6PR12MB4187.namprd12.prod.outlook.com (2603:10b6:5:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 08:58:51 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::19) by BY3PR03CA0021.outlook.office365.com
 (2603:10b6:a03:39a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 08:58:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 08:58:50 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 24 Nov
 2025 02:58:48 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Rename userq_mgr_xa to userq_xa
Date: Mon, 24 Nov 2025 14:28:17 +0530
Message-ID: <20251124085821.2759840-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251124085821.2759840-1-lijo.lazar@amd.com>
References: <20251124085821.2759840-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|DM6PR12MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: e4ebf02c-815a-4d6b-ff98-08de2b37affd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlZyelZDb2dweXF6cW94WGpVVHN4MXFOSDFzWXYwd2pFdjZTVnRTMngvNDgz?=
 =?utf-8?B?UUFPcHgrenJvQWpEZXRCenBQSTVPazlBSDdMT0xUaUpWOEdtTGc4dytSaGs2?=
 =?utf-8?B?bGw5VEtJaUJWQWNMZW1kcytXNWd4S21IZFFmbEFhQ2lxNC9wc3hwVFFGSUFG?=
 =?utf-8?B?TCsyQ1FXZEVOeC9UZGxkbE5RN0RHUXJCNzA3TEJ0K3hIZEN6cHpNeHpmeTA3?=
 =?utf-8?B?SDdBUGlOTHh4OEdHcDlqTFdUVGIzYkREWGY5TE5WcVJaSk5NTlRnZXlTMGdJ?=
 =?utf-8?B?UEhCR3hROUwwMXl1Q2Q2ckwxZlpMQ3plOFJZVEdjVVdmT1ZNUzVwVGx2RVdQ?=
 =?utf-8?B?a1cxNzhIUGEwWGlqUXdTdHRGdk83WmozcEppNWM5ajVsU08wYmU5cVpBYXlx?=
 =?utf-8?B?Mm13RnZPS0hYK3NyU0pYZDZacGtNbjF4SjRoeUJWVmo2MHdHS1N3RzJWdkUy?=
 =?utf-8?B?K0NzSWhGWVcwMFZ2aEtheUdxOWRhZ0FBUGdEWjkvbVBtUmh5TmhIc0VWd3Z6?=
 =?utf-8?B?UkJPWkNsYkNpTnhTL1F6L29KRjNwTXA2MVI3UnhMSmZ0Sm9yQ1JoVzVHTklX?=
 =?utf-8?B?OGswWmNHU3dFOG85OGFJUjhBbmFVQm5NaGlPa01vYnNpYkZqbEVjRWc4alBW?=
 =?utf-8?B?RTdSUkd5UzhuUXJyOUZqczcvTDhaOGNteThNQnVXVVBhaWRFSTcwUlJqMGtX?=
 =?utf-8?B?Snpsd0tiNEo2OHVCU1V4c1VKRTA0QVlHdVJocFFqK0Y4RnVWbE5nT1ZNSDdz?=
 =?utf-8?B?OTRSUmw5QmZvVUd0K1RkMXdxL3V3L21JdDREc01yMjNhSGgzMUFRd050QjFE?=
 =?utf-8?B?UGJ3Yk10ckZsVERMK3Vyd2wxdEtMdlB0Y0Y4UTR3TzVhOS9YNkdFNjVXc0RD?=
 =?utf-8?B?cExNZzI4UTNLWW5kSlZIWU1TZlZmYy9Vck13cmpMUGUyNGZSUjMrdEczNWNQ?=
 =?utf-8?B?dEhqb0tzN2JKZk9xY00zODRZcTNpclNIbThrV2lFek1Zak11alhpM3FzZFJj?=
 =?utf-8?B?YUJXMkNnQkwrOGdsaEhpcEpNbjBaVnBTQnhkdVp1QW91M0pUeFVaSDZMeUxj?=
 =?utf-8?B?L1d6VzhRTy9yYzJoVEhpL2dXQVM0dFpabGJ0TnJNcDd1SWkwcm1ZREdmR1NZ?=
 =?utf-8?B?Z0xGV01teHpmS0N0OXNCem50OTdkMEw4eVRLZGFDQXU2elZQN3FXS1I3a0FF?=
 =?utf-8?B?emJEZWFnSEo0K05wWU85ZGZENCs3b3krU0VmVFNnM3FxZGZDMzdQYkdyZjBa?=
 =?utf-8?B?TXkrRVlyWmxEYzJvRUhKUGc4UnRQby93OWdvTCtFd3NsK25GeitZeHdYVXZP?=
 =?utf-8?B?WlJ0Lzc1TnVORUlBVWYyT0N4T1dsVW5lcW1pa1lxMUd2bXFsdXdwbXVjL2lV?=
 =?utf-8?B?Tmp1QW1xcUJVMTdDM1VQdS92L25uVzZFeU1xT2xMWG1kaVQzMFg4NVplYkZZ?=
 =?utf-8?B?dlNMREVXODNsRGNUam1rVHR4Rllndi9vYS9LMUNhTWVJUFVFV1B3RzlhSW5n?=
 =?utf-8?B?WFpLZGQwVXRYQUV5Nm90cG9OaTFhYzExQ3lmVjhPWnV0aDYzVnorMy96U1JY?=
 =?utf-8?B?WDlZa0l4cFQ2VDZSRG81Yy9FZDZhMnFJU0NkTFhuTnNlVzRQUkdYcGhJVmUz?=
 =?utf-8?B?STM0MlMraFdBZVIySkxZRmVSTjVwRmwrUTNHendKc1FpSTBqRnlFRER4QWxT?=
 =?utf-8?B?bmxaVU1yUEZUakx1M041eXgyd293dXVubHZUQnFqRWVvZE1GTWZRNFQrZmhj?=
 =?utf-8?B?VVJsUTRMQlBqcDJxZFBETFQwOEhSTGtBZW1mOFFITzRaUzBvbHdLaXlRN3dP?=
 =?utf-8?B?OUNKRnNOQUIxTUZ1UkRsekdkMytMWldjajduMkRUK3dESjBhN041ZGozKzlZ?=
 =?utf-8?B?bWJraFQzd0l1emZCUW4wS0lNeG9KdG9jMUhFdEF3VUQzdkVaSkplV3JwR1Ft?=
 =?utf-8?B?aitFZ045bUpQRktwdm9oYnNkK0t1enVQY0ZDYko2S3N6NTRSRVExdTRkMnRZ?=
 =?utf-8?B?dlN6ZHorbDNwL3JBTHUwcHdnRWgzL1pTU25XVnJUczc1WnZiL1BSVUZ5elNG?=
 =?utf-8?B?dGpaWWtwbU1teTl0b1NTOGtpU2QxeWcxaW1pQT09?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 08:58:50.7711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ebf02c-815a-4d6b-ff98-08de2b37affd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4187
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

Rename since it is an xarray of userq pointers

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 22 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  4 ++--
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  4 ++--
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index f765c481aada..2f97f35e0af5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -398,7 +398,7 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
 	uq_funcs->mqd_destroy(queue);
 	amdgpu_userq_fence_driver_free(queue);
 	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
-	xa_erase_irq(&uq_mgr->userq_mgr_xa, (unsigned long)queue_id);
+	xa_erase_irq(&uq_mgr->userq_xa, (unsigned long)queue_id);
 	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
 	queue->userq_mgr = NULL;
 	list_del(&queue->userq_va_list);
@@ -410,7 +410,7 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
 static struct amdgpu_usermode_queue *
 amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
 {
-	return xa_load(&uq_mgr->userq_mgr_xa, qid);
+	return xa_load(&uq_mgr->userq_xa, qid);
 }
 
 void
@@ -769,7 +769,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
-	r = xa_alloc(&uq_mgr->userq_mgr_xa, &qid, queue, XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
+	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue,
+		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
 		amdgpu_userq_fence_driver_free(queue);
@@ -792,7 +793,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		r = amdgpu_userq_map_helper(queue);
 		if (r) {
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
-			xa_erase(&uq_mgr->userq_mgr_xa, qid);
+			xa_erase(&uq_mgr->userq_xa, qid);
 			amdgpu_userq_fence_driver_free(queue);
 			uq_funcs->mqd_destroy(queue);
 			kfree(queue);
@@ -917,8 +918,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 	int ret = 0, r;
 
 	/* Resume all the queues for this process */
-	xa_for_each(&uq_mgr->userq_mgr_xa, queue_id, queue) {
-
+	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
 		if (!amdgpu_userq_buffer_vas_mapped(queue)) {
 			drm_file_err(uq_mgr->file,
 				     "trying restore queue without va mapping\n");
@@ -1161,7 +1161,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	amdgpu_userq_detect_and_reset_queues(uq_mgr);
 	/* Try to unmap all the queues in this process ctx */
-	xa_for_each(&uq_mgr->userq_mgr_xa, queue_id, queue) {
+	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
 		r = amdgpu_userq_preempt_helper(queue);
 		if (r)
 			ret = r;
@@ -1196,7 +1196,7 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
 	unsigned long queue_id;
 	int ret;
 
-	xa_for_each(&uq_mgr->userq_mgr_xa, queue_id, queue) {
+	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
 		struct dma_fence *f = queue->last_fence;
 
 		if (!f || dma_fence_is_signaled(f))
@@ -1246,7 +1246,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
 			  struct amdgpu_device *adev)
 {
 	mutex_init(&userq_mgr->userq_mutex);
-	xa_init_flags(&userq_mgr->userq_mgr_xa, XA_FLAGS_ALLOC);
+	xa_init_flags(&userq_mgr->userq_xa, XA_FLAGS_ALLOC);
 	userq_mgr->adev = adev;
 	userq_mgr->file = file_priv;
 
@@ -1263,13 +1263,13 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 
 	mutex_lock(&userq_mgr->userq_mutex);
 	amdgpu_userq_detect_and_reset_queues(userq_mgr);
-	xa_for_each(&userq_mgr->userq_mgr_xa, queue_id, queue) {
+	xa_for_each(&userq_mgr->userq_xa, queue_id, queue) {
 		amdgpu_userq_wait_for_last_fence(queue);
 		amdgpu_userq_unmap_helper(queue);
 		amdgpu_userq_cleanup(queue, queue_id);
 	}
 
-	xa_destroy(&userq_mgr->userq_mgr_xa);
+	xa_destroy(&userq_mgr->userq_xa);
 	mutex_unlock(&userq_mgr->userq_mutex);
 	mutex_destroy(&userq_mgr->userq_mutex);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 7c6dfc0e27a8..1eaa94f8a291 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -91,11 +91,11 @@ struct amdgpu_userq_funcs {
 /* Usermode queues for gfx */
 struct amdgpu_userq_mgr {
 	/**
-	 * @userq_mgr_xa: Per-process user queue map (queue ID → queue)
+	 * @userq_xa: Per-process user queue map (queue ID → queue)
 	 * Key: queue_id (unique ID within the process's userq manager)
 	 * Value: struct amdgpu_usermode_queue
 	 */
-	struct xarray			userq_mgr_xa;
+	struct xarray			userq_xa;
 	struct mutex			userq_mutex;
 	struct amdgpu_device		*adev;
 	struct delayed_work		resume_work;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index f44cb17b1e2f..25f178536469 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -542,7 +542,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	}
 
 	/* Retrieve the user queue */
-	queue = xa_load(&userq_mgr->userq_mgr_xa, args->queue_id);
+	queue = xa_load(&userq_mgr->userq_xa, args->queue_id);
 	if (!queue) {
 		r = -ENOENT;
 		goto put_gobj_write;
@@ -904,7 +904,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		 */
 		num_fences = dma_fence_dedup_array(fences, num_fences);
 
-		waitq = xa_load(&userq_mgr->userq_mgr_xa, wait_info->waitq_id);
+		waitq = xa_load(&userq_mgr->userq_xa, wait_info->waitq_id);
 		if (!waitq) {
 			r = -EINVAL;
 			goto free_fences;
-- 
2.49.0

