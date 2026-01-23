Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE7FD77893
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 17:20:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F4A210EB7A;
	Fri, 23 Jan 2026 17:20:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zdrwKjNh";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012013.outbound.protection.outlook.com
 [40.107.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 299FD10EB68
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 17:20:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eoSQrgxQzWgMtYQDLF1c5g7KiP7pwBRvp8R7miI8vjtr2158+3ArGxlorNHCy5e3txvRb6afgDN9A2j5mklp7uHT5bn3/opar2VcWzLRin4JUTN5FOCiT/p498ooJbDG/f0z5AH8+RQew6Dvir4vChO1kWnmEERiaTkAOZ2iodfLvvQ+XOekzZGCgpyx2Ner72jrdhU64zzJQvGVU/SObOhPbuDzY0Bn4P/wuVCWH3woXYAUoKtavTD38RLt49c3FHJINHiuIa0sJHIrHmFSuWS2Nl4LZuIUAbdcJU2pywkBwlT2mDtIicPADo+pHgHJstniz+XgE90Lu68msq+g/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIk9A8ym+QouXJcBGS7UDCP9kG4LbCTPLFPzv9aSmhg=;
 b=PLQdTQj0WNw5fWoui0eEaxd0kc5bUqjrs7NhAE/rn5/gParNnwFkOyrimBlIs3rnMQLnOtSWq9pu0k4ePDSZZsxK4ShF7sMWf8dq9wOCrBdAdPC1pXkBz3XANaBkqIL8xK//sn0HBGo3CcsGxXYxu/7wwm1MfoMzwKQwDOSfqmQ8MaD0G5bXh2JqTR7N4+6zazyQ+wxc0cRl+wYeOOhRqiZW3b+aN98An6TaYu2JK8qiyQ7Q7JIQ4jGgn7iQiXsmOs/kw0uRJaxuvwkPBKrKCVcv7DpC2AKwW7R7JwKU2cpKP36428BDwP/IA7VCEbQSklwoxfCXMvZDPbJ5yF0I3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIk9A8ym+QouXJcBGS7UDCP9kG4LbCTPLFPzv9aSmhg=;
 b=zdrwKjNhRF0hOx4wvc58t4icZtkERgYc+1G4SyOXR8m/u+Egpmid+3A2T3VqeP5aEo6ywuBys2Sl9+xbq6FDlWUu+QLD2pjs0jsKj1NZnCtoEvo6agkOW7HwIOZMgBq3WsrZAbE0ZPvUZg/OmVUqYS1vme1dQdT2wMTsr88VsQ0=
Received: from BL1PR13CA0324.namprd13.prod.outlook.com (2603:10b6:208:2c1::29)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 17:19:54 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::18) by BL1PR13CA0324.outlook.office365.com
 (2603:10b6:208:2c1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Fri,
 23 Jan 2026 17:19:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 17:19:49 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 11:19:48 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 23 Jan 2026 11:19:48 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 07/11] drm/amdgpu: plumb timedout fence through to force
 completion
Date: Fri, 23 Jan 2026 12:19:33 -0500
Message-ID: <20260123171938.16814-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123171938.16814-1-alexander.deucher@amd.com>
References: <20260123171938.16814-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 895be1df-2173-4900-0971-08de5aa39d3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amtEWjVTVlFVSjZiK2ZCOHhHRUpIa01yWFJtcUdudVE1cmw2NE9vTGFJbm5i?=
 =?utf-8?B?UGJLRDUvNVg5Vi9IbjNGZ2hYQ0M1QW9FV2lsZlF5WlpyU1U0WnFaRnluTmlz?=
 =?utf-8?B?MCt4RnRTaTFmMUE5a1VVVkhzWk1SejBuR1cwbENQWFBLdUxkVG1ROWpOQkRM?=
 =?utf-8?B?YUNwYVVlQ0U2dGZzNDNzUVYwbXVJSWY4dnNONnFreGtQM0RMbGZob0ZwNFBz?=
 =?utf-8?B?QzlXSFhaNk5mTlZvendBc1UvY095ZnlrT1JObTBXMkhPaStqQ1ZHSFZzYXhj?=
 =?utf-8?B?V1VHYTB3VUJHa0tDZTRJVFNZY0lHU3JMTUFXcVY5bVQzSW9ORDJSY3QrMU01?=
 =?utf-8?B?blhCNnhXVmtSU2tXeUx0YkEybjNzdTVMNStud2VUVzYrV0hvZG50bi9hTGRD?=
 =?utf-8?B?anRHeWJGMFJnRUp3a2R4Tjk5V3pOcWNjYUpmSEVSRGlGUUxVOXJ5L1Qzdzkv?=
 =?utf-8?B?cldlRktWamU2ZHJCQzdkYmVzaE5acFJIeTI1bXF4THM2VFdZWE5KSjVHMWtL?=
 =?utf-8?B?am1qUzdiS3pkRFFxckdmNWd4dmNGY2xmUi9zNzlDTkZHSnQvaDNkZldHdDVj?=
 =?utf-8?B?ZTVoVlIyNFJtd25qR0dEaVk2bHZtL0F3SFVKS0J3bjAwU0FHTDdMVFd2d2ty?=
 =?utf-8?B?M2tBTUNFdlErd2drcVFtd0pKa29NQVAzN3hjUkFjVTd6VFk1Y1Boc2xraEZs?=
 =?utf-8?B?bnkxc1dBOVNkUW4yM05JQ2dJZGZzeCtlU1psclZCZWhPREtxOThaTFFPL01E?=
 =?utf-8?B?MTlDcmZibGpkcFg5cEk4L0xBMHRFZ1pzVDBENGhYcTFGdG1UTmJ1MkdEM0pY?=
 =?utf-8?B?R3JhcTc2YmxpeW9OOWJzV1ZHWDM0WEExRVJKMGNFTVV0WnhJSzFYTXMrQWtn?=
 =?utf-8?B?UGhWTWNNYjlFbFlDWitzS0RKYW5jL2NudUVDOU1tcWJEMFp0TW9nZUFtQ1dT?=
 =?utf-8?B?TzFFOUx1K3NhNm93TThCaE5zRG1ZRm5TbkdLRTJPbEVGTFpSTFc3cU02MTdG?=
 =?utf-8?B?RWZYVUFUSllKTDM3R2NmU1VvWG5uYWhsZUtXMEU4S1QvU0Z6YjJnWnMxcGo2?=
 =?utf-8?B?bVRFQnRMQStFUkwzWHBtZEdNbEhVODdodGVEODltdEtLa2Jaci91V0duOVBN?=
 =?utf-8?B?NWVKQmpKeER2ZlR3eTg2Nk14UXRaQXNMdjFUeThHRFNNLzVaRzZoelUxNk1x?=
 =?utf-8?B?WkpzcGpIRDBJT3F5dTZJNEp5K1lFQ1l1M291VzNic2lRLzZSRHU1bHNET1lF?=
 =?utf-8?B?bWtvZkJ0eFdBRWJuNDVmL1MzaFMraVN1TkxmTTJ0V3piNmlSdnFuNHRjbU9S?=
 =?utf-8?B?UlRVcUQwc01CY2RqUnVFeFpZY2xkRXdJcWUzRk5kWkpYMExmeFVCcTJ6Nkg3?=
 =?utf-8?B?dkJMdStaOURxWHBoY093QkNoODR3dW1GVUJSSHFYNTk4KzIwSnRvRlZBZ0Jv?=
 =?utf-8?B?cnRsYUlDYW5mSmRxb29RanZGMzBhWmFSSTZLbE1LbkoxK21UajBqTEs3REV2?=
 =?utf-8?B?eGIzMXZMYnZUUHg2MTk1Z1F5clVHN1dTY3JKZUZ4bHg4d1F6VHN5dDlGYzJS?=
 =?utf-8?B?TlB5ZDlyMElZdVR2empLQkpYT1NiZjNnbXA4NXMvMkV1R0hSSmRBeWVUM2xm?=
 =?utf-8?B?OSt4U2xLZjlvVUJBRFV0S2lXY1ZVbFY3V1phM1ZWaHlZNU91N1VWSGxjUDc5?=
 =?utf-8?B?cUZkRnQ5emp6N3RhcnkyUjVoNk51U2RoQ0JFeDVjNzdWMStySjhYMlRHNFNZ?=
 =?utf-8?B?OUdGQStGaEduNnAzTTFFRTZNUUN1eDlQcEdVYzMwVG5lQ1dLaFJBdFl6cTlo?=
 =?utf-8?B?Y1VlM2laOENwcTMzR3hibkJGS0p6aGFiY3ZWVE1VL3lQRTdlakd6bmxNWXdS?=
 =?utf-8?B?YlFtbWliaWhqV3hna3dHbHVvVm1WVHVGMThiZkJNT3pqblhFbkFDbjB2SjRr?=
 =?utf-8?B?NC9JNXlGcG5lSjdkWU5TZ0lFSyt3bFUyenYrSlBaM2R2ZVl5ektsVTZQWTU0?=
 =?utf-8?B?cytlNitOUUcybVJvRW5XbHA4VVhoTzN4bzFzRG5wNlVVREllMk9DM2NWTncr?=
 =?utf-8?B?MDFTbVNhNkM2d3hwampNRlpLN0lGWFNMTmhiYitMY0VUR1Y0UUZZL09MdExQ?=
 =?utf-8?B?YUNaak5tRWtqK1daM3N4VkNudW1aRm5xRGZCbEswelhoMmpmckxoODY0MUpG?=
 =?utf-8?B?OFVSZ0lVYUUyQzkzQU1TK3hoMTIvc3dHTXlIaVhWTkFVSDlGeGh2bHo1L2Mz?=
 =?utf-8?B?UlJKZVhLNTA5ZU1OUmFVeitZdjBBPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 17:19:49.6830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 895be1df-2173-4900-0971-08de5aa39d3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974
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

v2: rebase

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
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c     |  2 +-
 9 files changed, 49 insertions(+), 21 deletions(-)

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
index 05efa31c3f6a0..52b90c9fef0dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5792,6 +5792,7 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 {
 	int i, r = 0;
 	struct amdgpu_job *job = NULL;
+	struct dma_fence *fence = NULL;
 	struct amdgpu_device *tmp_adev = reset_context->reset_req_dev;
 	bool need_full_reset =
 		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
@@ -5804,6 +5805,9 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 
 	amdgpu_fence_driver_isr_toggle(adev, true);
 
+	if (job)
+		fence = &job->hw_fence->base;
+
 	/* block all schedulers and reset given job's ring */
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 		struct amdgpu_ring *ring = adev->rings[i];
@@ -5812,7 +5816,7 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 			continue;
 
 		/* after all hw jobs are reset, hw fence is meaningless, so force_completion */
-		amdgpu_fence_driver_force_completion(ring);
+		amdgpu_fence_driver_force_completion(ring, fence);
 	}
 
 	amdgpu_fence_driver_isr_toggle(adev, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index c7a2dff33d80b..d48f61076c06a 100644
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
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index dd247abce1ab0..33ef48e2517de 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1669,7 +1669,7 @@ static int vcn_v4_0_3_reset_jpeg_post_helper(struct amdgpu_device *adev, int ins
 	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i) {
 		ring = &adev->jpeg.inst[inst].ring_dec[i];
 		/* Force completion of any remaining jobs */
-		amdgpu_fence_driver_force_completion(ring);
+		amdgpu_fence_driver_force_completion(ring, NULL);
 
 		if (ring->use_doorbell)
 			WREG32_SOC15_OFFSET(
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index c28c6aff17aaa..100ea1a914b4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -1332,7 +1332,7 @@ static int vcn_v5_0_1_reset_jpeg_post_helper(struct amdgpu_device *adev, int ins
 	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i) {
 		ring = &adev->jpeg.inst[inst].ring_dec[i];
 		/* Force completion of any remaining jobs */
-		amdgpu_fence_driver_force_completion(ring);
+		amdgpu_fence_driver_force_completion(ring, NULL);
 
 		if (ring->use_doorbell)
 			WREG32_SOC15_OFFSET(
-- 
2.52.0

