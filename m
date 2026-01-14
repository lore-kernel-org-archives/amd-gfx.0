Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD738D38FEC
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:48:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76D2110E647;
	Wed, 14 Jan 2026 16:48:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m6jvl0Lk";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 975CA10E654
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:48:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICfMIBQEaCQr5/eB2ACXu/1UzXUeNAFSjYqKwZEI9fmM5qpA7yMotHi0kohIZne3lmrF3SLrMnztylLu8o6GgNRWMokIKwIJbkFyQL5EnMxxVFF4VMiVnfoI8Fth74BRqDp35xQjaAs/fzn2VcBZ97p30YN+BauoF3ZmxrZvTSJCcpiyaZhJ4cfzUVJ67w0AKjNiZK/lFzXB56gG/UD1O3GDniZhwOVhzeYEGV1Ge/IiP/5kpMPREp+5ogWd/36WCb/IaKShDpPn0bNCszqu/WdZFei/4qpAwbmcxiJzvPDzRxUr4DlJE+3w6jAAKGiPVlP57SkNbufEGlLiRZzlUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8tcCxO6hDsXw48tsHvRfcwpNoMWWGXXRq9k0oAvxYM=;
 b=TAt7ADLZyKTsZphaSLS9e9Rxy1kaTtFy9zJ7alCux3NQ6xBl55bJ/tpOOA/mgryDq3S9+PD7soJtuOnbaMLYMvS7hrZJSR/lg4kfjioqd/Rp5Z0WvgkHzoHIwPghnj807xCqKxUKnKN1JSlDHE4/u98D37TON+Lc0fW6alpo14Tf+2gFqY59Fya7RKwBDfHgxE/PvH3WVL3/YPVXXWr9ppuc3jVkjSdb1qpA8Gv4QK3lYrIU+fpbwzxfTKu3Z1nDGvOqEJX+tj9udSNj1hWErh5QylX9NQ1p9nQB5DoLIoWbgtXVPpJNmfslQKrUMgW0dwjQy79zEL/dbuP90ZXB/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8tcCxO6hDsXw48tsHvRfcwpNoMWWGXXRq9k0oAvxYM=;
 b=m6jvl0LkHwJ0jDE2QdXQPz7pJEZy3N/bk00YbynX352hvpuCah8VtPYKm/NI3FWVvfngtW5CaudzxOuzqVRye6B9e2SOB+KlQM5TunRjR0TuNML3owh77u/dxLesPCUXUIksmO2e1j+7vAjG+m4XbsZxWivD4DIDGeNjfWcxSEo=
Received: from SJ0PR03CA0232.namprd03.prod.outlook.com (2603:10b6:a03:39f::27)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 16:47:59 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::7c) by SJ0PR03CA0232.outlook.office365.com
 (2603:10b6:a03:39f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:47:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:47:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:49 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:49 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 29/42] drm/amdgpu: plumb timedout fence through to force
 completion
Date: Wed, 14 Jan 2026 11:47:14 -0500
Message-ID: <20260114164727.15367-30-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|SA0PR12MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: 07aa6746-5b06-4097-cddd-08de538cac78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkZzMktaM1lQbFA1czNxWVFXOWs3WVJUQnYxTW5hVktlWnNYUkxZWWpMK1BT?=
 =?utf-8?B?ZVdycEY4Y3hOc1BENFI3S01DOEVBV3RBMUJHZEpSV2Fidjk4QUJxT2NCSkRw?=
 =?utf-8?B?Y0prOFdWVEpvSGV3NW94TjBxL0RwSE5nZWxDL2xreUU2NldPc091SWpoSTU5?=
 =?utf-8?B?clB2dlFDbk9LME1RdEt3TVI1Tys1ZGFPcngwalZRaWpDb0Y1NVl3N2UyR2I2?=
 =?utf-8?B?SWtIeDFjYk1XaGdPL1FZU0IwaEcxSU9LeklncFVCd0cwQStLcTltV3NqejJk?=
 =?utf-8?B?OTJtRmVWZlprdWdpMFk1OTFVOXFicWUrOStNdGZVUm80UTdLNERyUy9mMWww?=
 =?utf-8?B?NGR6aW1ZcGtmZTVJRE00Rm8wTms4c1Z1Smg3YjV6dEpZTWgra214RzM2aHZa?=
 =?utf-8?B?a2JMK0x0TUd0Wk10bktSdkZaUk52YmY1NVJ4Skd1eVlCd3h2cm5QbTdxS0Nu?=
 =?utf-8?B?cDh5UmdwVnU4WUoyM3FBa0oybnlFMWZoNzcwU01NNXE0M2tsdmk3NDV4YUhm?=
 =?utf-8?B?K1lGYkFmY2VPYTExeTY3N295VlNBNjhjNzEzeWNzRXhSTFFvS0lZTFU5VENq?=
 =?utf-8?B?TjM4eUFWTnlpMWNZUG1INUVsNXdXTzUzaXphMlJ5emhocEtyK1BnTjFKdVdm?=
 =?utf-8?B?RGwyMmJjM0xuV2h1ZFA2VUhpTngxM1BzMEgrV2ZnUEZUUG1JN0YrUm5pWG9t?=
 =?utf-8?B?bGxaTUlDd1FCNGIzcmRua3paNThuTVFRRnUwNVp2SWtOaHc0RzQ3ZkxCK2NO?=
 =?utf-8?B?cWRmQXkyVkZrSzhCbmF6MzJiL3UxR3pLdnJQWVlKdzdFalQ3SldoMlU0QnlZ?=
 =?utf-8?B?UjV1bE0zdUo3T05RY2kvTmxwbDJxcGhDc2xkVlU0SG5LTVhrQ053MXRlZGQy?=
 =?utf-8?B?Y0JaWDllRktxaURMMlJJdlJvcHNOb3VDUUpvUXRHK2plY3NON2NhUkdaNEJx?=
 =?utf-8?B?ZGVsZWJFNlNvak5KUEFEb3Y1RXgzYUlaUTlKSk8rc3d1eDVGb1NNdFJ5UFRM?=
 =?utf-8?B?TzN3Y3lmSzQ1MC9yRlVJZytmUDduV0VFR0lvdnBtck9tQ1lVeUlDN0JXa3NO?=
 =?utf-8?B?aDdwM0ViMHRXYy9keC9WczhFT1dBbGpxbWR0aXZIVzhBejZRUFNTVUpTRU5W?=
 =?utf-8?B?cG1abEp3a3E2Mk50YmxoVUVDeHp2djJPTlRFbm5NUGNKcjF1R2pBK2FMa29J?=
 =?utf-8?B?WE5uNEFXZ3JKVjR4ZVlrWS9OYjBaRkMyb2RpVUFqU2x3ejI5YXlXZXA3UzVE?=
 =?utf-8?B?UnVrYmN1cUd4dlNYcHVRTG5Dai9JYzVMOWNjUkdHOVQ5R09HcGVSWUEvcGVO?=
 =?utf-8?B?ZlJTdUV2RFI0QS9DakNCc0xYRUZWUGxJQjlCcmRiMCtkVFpsSnhnZ0dZOExi?=
 =?utf-8?B?bStNMVlWU2ZlamxTL2Vad1ZCYzREc05zU0t6d3NIVmhYV0hzOVRCRE5rWDRm?=
 =?utf-8?B?TVdheGZzN0MwdXhPVnMwWlMvMTZvSWpqb05iRWNQZytuM2N1NUdIS1hXNXN6?=
 =?utf-8?B?UGxMNFZzT25TaVZlL2hDNldmNUxHVlJnOHVoUjMyNS9ZMlVod1BoTkdlUHNy?=
 =?utf-8?B?R0JCMEo5NjNJS0xrTGt5NHM1d3Z2UDNjNnBzR09JUXBPQ0JXZmNXMjY3T3lp?=
 =?utf-8?B?QUY1UitrTlYrbHpYU1plNW9ybEhDN3RvVkViZml6c0liSU1zVjlEQlBjSGtn?=
 =?utf-8?B?NmcwazNQK1I1Zng1WXF5dkxWSjdSQlFSMi9kVkpTanF2RHR6Z0NiYVlkUnp1?=
 =?utf-8?B?ZlR3b1ZKTS9MRlMzWTBrMDBtK0dEZU04NlQycDBwdVB2b0FYYjNKZ2x3UWxU?=
 =?utf-8?B?T0lPdlBHZG4zVnBsUzZUOGpPb28zQU4xc1d3Z0t6TENQRll6cEp0TDlxaVZm?=
 =?utf-8?B?enBNakNIeWdJbjFZQlVTMnBFUkpMZWViNHZ3STJuaW5JcTI2U3RKQTFGdkxN?=
 =?utf-8?B?dEJYaC9XNUpkeldnSDZRNlhsT25iTGU3alpucHVHc3kyd25PMmpxRnNQUWd1?=
 =?utf-8?B?N0kvVGpSdUU5elBpUUEvYWVzVDZGQ290dnJSWCtVcWRGS0ludmFOdUVMYTdo?=
 =?utf-8?B?cktFb2dTcEtiUDV0anB6UHdPTVFSM01TdWZwMTBmMVNEaG14RTUvd2xNZFA0?=
 =?utf-8?B?L2hrbEVnUTUxNWdabVh5Z09zVGxPQTN4WGJvMnIxUGtKeEt3ajZxNWg4Y2dC?=
 =?utf-8?B?QisrN1VsVUZMUzRqVmNVd3d6WkJvZEs1RzkyeXJIcVR6eWI3WFpGdzNCd2Rv?=
 =?utf-8?B?L09meGc0VnVrUk5IcVJYOVRBYWJBPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:47:58.6492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07aa6746-5b06-4097-cddd-08de538cac78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416
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

When we do a full adapter reset, if we know the timedout fence
mark the fence with -ETIME rather than -ECANCELED so it
gets properly handled by userspace.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  6 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 28 +++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     | 21 ++++++++++------
 7 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 1f3e52637326b..e36c8e3cfb0f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1960,7 +1960,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 		/* swap out the old fences */
 		amdgpu_ib_preempt_fences_swap(ring, fences);
 
-		amdgpu_fence_driver_force_completion(ring);
+		amdgpu_fence_driver_force_completion(ring, NULL);
 
 		/* resubmit unfinished jobs */
 		amdgpu_ib_preempt_job_recovery(&ring->sched);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4a16001434ea1..559a1160b7c4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5791,6 +5791,7 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 {
 	int i, r = 0;
 	struct amdgpu_job *job = NULL;
+	struct dma_fence *fence = NULL;
 	struct amdgpu_device *tmp_adev = reset_context->reset_req_dev;
 	bool need_full_reset =
 		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
@@ -5803,6 +5804,9 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 
 	amdgpu_fence_driver_isr_toggle(adev, true);
 
+	if (job)
+		fence = &job->hw_fence->base;
+
 	/* block all schedulers and reset given job's ring */
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 		struct amdgpu_ring *ring = adev->rings[i];
@@ -5811,7 +5815,7 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 			continue;
 
 		/* after all hw jobs are reset, hw fence is meaningless, so force_completion */
-		amdgpu_fence_driver_force_completion(ring);
+		amdgpu_fence_driver_force_completion(ring, fence);
 	}
 
 	amdgpu_fence_driver_isr_toggle(adev, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 6f37fc45458a3..b1cf9550c259b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -568,7 +568,7 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
 			r = -ENODEV;
 		/* no need to trigger GPU reset as we are unloading */
 		if (r)
-			amdgpu_fence_driver_force_completion(ring);
+			amdgpu_fence_driver_force_completion(ring, NULL);
 
 		if (!drm_dev_is_unplugged(adev_to_drm(adev)) &&
 		    ring->fence_drv.irq_src &&
@@ -683,16 +683,34 @@ void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error)
  * amdgpu_fence_driver_force_completion - force signal latest fence of ring
  *
  * @ring: fence of the ring to signal
+ * @timedout_fence: fence of the timedout job
  *
  */
-void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
+void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring,
+					  struct dma_fence *timedout_fence)
 {
-	amdgpu_fence_driver_set_error(ring, -ECANCELED);
+	struct amdgpu_fence_driver *drv = &ring->fence_drv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&drv->lock, flags);
+	for (unsigned int i = 0; i <= drv->num_fences_mask; ++i) {
+		struct dma_fence *fence;
+
+		fence = rcu_dereference_protected(drv->fences[i],
+						  lockdep_is_held(&drv->lock));
+		if (fence && !dma_fence_is_signaled_locked(fence)) {
+			if (fence == timedout_fence)
+				dma_fence_set_error(fence, -ETIME);
+			else
+				dma_fence_set_error(fence, -ECANCELED);
+		}
+	}
+	spin_unlock_irqrestore(&drv->lock, flags);
+
 	amdgpu_fence_write(ring, ring->fence_drv.sync_seq);
 	amdgpu_fence_process(ring);
 }
 
-
 /*
  * Kernel queue reset handling
  *
@@ -753,7 +771,7 @@ void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af)
 
 	if (reemitted) {
 		/* if we've already reemitted once then just cancel everything */
-		amdgpu_fence_driver_force_completion(af->ring);
+		amdgpu_fence_driver_force_completion(af->ring, &af->base);
 		af->ring->ring_backup_entries_to_copy = 0;
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 86a788d476957..ce095427611fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -160,7 +160,8 @@ struct amdgpu_fence {
 extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 
 void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
-void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
+void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring,
+					  struct dma_fence *timedout_fence);
 void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af);
 void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 8b8a04138711c..c270a40de5e5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -597,10 +597,10 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 		 * to be submitted to the queues after the reset is complete.
 		 */
 		if (!ret) {
-			amdgpu_fence_driver_force_completion(gfx_ring);
+			amdgpu_fence_driver_force_completion(gfx_ring, NULL);
 			drm_sched_wqueue_start(&gfx_ring->sched);
 			if (adev->sdma.has_page_queue) {
-				amdgpu_fence_driver_force_completion(page_ring);
+				amdgpu_fence_driver_force_completion(page_ring, NULL);
 				drm_sched_wqueue_start(&page_ring->sched);
 			}
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 9d5cca7da1d9e..3a3bc0d370fa6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -512,7 +512,7 @@ int amdgpu_uvd_resume(struct amdgpu_device *adev)
 			}
 			memset_io(ptr, 0, size);
 			/* to restore uvd fence seq */
-			amdgpu_fence_driver_force_completion(&adev->uvd.inst[i].ring);
+			amdgpu_fence_driver_force_completion(&adev->uvd.inst[i].ring, NULL);
 		}
 	}
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 75ae9b429420e..d22c8980fa42b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1482,15 +1482,16 @@ int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
 
 /**
  * amdgpu_vcn_reset_engine - Reset a specific VCN engine
- * @adev: Pointer to the AMDGPU device
- * @instance_id: VCN engine instance to reset
+ * @ring: Pointer to the VCN ring
+ * @timedout_fence: fence that timed out
  *
  * Returns: 0 on success, or a negative error code on failure.
  */
-static int amdgpu_vcn_reset_engine(struct amdgpu_device *adev,
-				   uint32_t instance_id)
+static int amdgpu_vcn_reset_engine(struct amdgpu_ring *ring,
+				   struct amdgpu_fence *timedout_fence)
 {
-	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[instance_id];
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
 	int r, i;
 
 	mutex_lock(&vinst->engine_reset_mutex);
@@ -1514,9 +1515,13 @@ static int amdgpu_vcn_reset_engine(struct amdgpu_device *adev,
 		if (r)
 			goto unlock;
 	}
-	amdgpu_fence_driver_force_completion(&vinst->ring_dec);
+	amdgpu_fence_driver_force_completion(&vinst->ring_dec,
+					     (&vinst->ring_dec == ring) ?
+					     &timedout_fence->base : NULL);
 	for (i = 0; i < vinst->num_enc_rings; i++)
-		amdgpu_fence_driver_force_completion(&vinst->ring_enc[i]);
+		amdgpu_fence_driver_force_completion(&vinst->ring_enc[i],
+						     (&vinst->ring_enc[i] == ring) ?
+						     &timedout_fence->base : NULL);
 
 	/* Restart the scheduler's work queue for the dec and enc rings
 	 * if they were stopped by this function. This allows new tasks
@@ -1552,7 +1557,7 @@ int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
 	if (adev->vcn.inst[ring->me].using_unified_queue)
 		return -EINVAL;
 
-	return amdgpu_vcn_reset_engine(adev, ring->me);
+	return amdgpu_vcn_reset_engine(ring, timedout_fence);
 }
 
 int amdgpu_vcn_reg_dump_init(struct amdgpu_device *adev,
-- 
2.52.0

