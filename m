Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FCDD2ECFD
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 01:34:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FF7C10E292;
	Tue, 20 Jan 2026 01:34:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N+/R6hsu";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012036.outbound.protection.outlook.com [52.101.43.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F9D410E1D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 01:34:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqOMRNLdXtAzrp/IjGGi38tt5R5jCZT9GghXwhAeTBYN4EhLmRiEjZVbqNB6A3T0ArRB0HHtUTv2j7Q+a8/uDr1bFGKxR4GaYw2zVUkkPDSg92NYHHiN/R+yzA6o7twoC/t2C/m4M/6/H/C7Z64L8qBkS/NLzYO7l/Xa78qtiuqtS3FUEgRkjb+nKkB5q9B8Wf8n4v6b2wCr5hnWhityJvH+WPg4WKoFFUCYegodWMOEtH4G4qJJDrmLw0y7kSRwkrSrBsukO2jM18nmKwfg/T2k8zG708kYE+Ad0/+P56Cq2ijkc0oE4v6c11Mv03bcaqzZtAKuxT2BrQ753mgGBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xUdxQcWIv/CavEZWhaPXMrmtdaPjaom8ozLngeWF1g=;
 b=w/56Df2+jfu/3wCBBn3hiywqJtAHlZ2W+M8lX/BxnlqixGMwYCU90ZGr2zgXG6NIhQVrW8i+gLnV6Vi3rOPDUjiq1DFsSHl77B45UTz40UzlpazetGTbDwlaCIlrBrOEWwLbKxRlgugiSXalMkYVAMV4fxAsVtX3Xds/c566p1U7IXxGVODHD4jYzAk0zIc1aNGzlo4bSU2SD7pLwxdkkpteUhIdzP9M9YKOKLa7nmfVAapyWNiwKf5c1LxxeTcrBkY41xAsanVhsY4TsHFWBI5AMIF5MfzW6HtEZqucluIx13AM1QCC7Zsdo7fgIESAaKnhMtOON6Vav7cCIuUaeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xUdxQcWIv/CavEZWhaPXMrmtdaPjaom8ozLngeWF1g=;
 b=N+/R6hsuXpN7oQM6ub0pNZt85jDIPG9ZgX5TEdsxmYY77HOCtc/vKUT3oViS1gKRgIG3dHKab1RisV3L+x4hbglhYvkgGER1CCeuN1sfJsanWgGIwsEKar7I7zp/eTMCdCozH1XxDU6YuIS+KWZYt/Ge/kL+hOVUH8iT4ux/8yM=
Received: from BN0PR02CA0053.namprd02.prod.outlook.com (2603:10b6:408:e5::28)
 by LV5PR12MB9778.namprd12.prod.outlook.com (2603:10b6:408:300::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 01:34:23 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:e5:cafe::9c) by BN0PR02CA0053.outlook.office365.com
 (2603:10b6:408:e5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 01:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 01:34:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 19 Jan
 2026 19:34:22 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 Jan
 2026 19:34:21 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 19 Jan 2026 17:34:21 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 07/10] drm/amdgpu: plumb timedout fence through to force
 completion
Date: Mon, 19 Jan 2026 20:34:08 -0500
Message-ID: <20260120013411.15659-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120013411.15659-1-alexander.deucher@amd.com>
References: <20260120013411.15659-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|LV5PR12MB9778:EE_
X-MS-Office365-Filtering-Correlation-Id: d701e56a-f20b-4e4b-8793-08de57c40a1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q09DS3RIa3BEM2tsNEFHT2IwZGhRRHd2bFNsNXlYSUE2RHlHbnRrT08vZklq?=
 =?utf-8?B?YUlYbjc3aTMzTjV6R1UwbGpKOHh2OW9yLzgxbXNKaGd4SlR1Z1Uyemh0NTBl?=
 =?utf-8?B?ZlNiOVhOclQ1Zm5LR2hNWXVDZEJQYXQ2c1ZVNTMvc3U3OW9YWHRndHc4U1hu?=
 =?utf-8?B?M21BMGtSVDFMT2VnRFY2UFpEckV3bjRUYmdwdS9oRnBpd0s0cEpxN056UTAz?=
 =?utf-8?B?ZXJsR01PdmQyRCtzdjkzd0Z3NVlEZFRTQ1B0RGFibWJQVFh2Y09nRTdaczdo?=
 =?utf-8?B?cDBhbTYrR1FBRzJ3VUNmVFlod1ZLRHdNQTJpaC8zOGEvYzRSVXlxK2x4VC92?=
 =?utf-8?B?WkVXMGliUzFkNUlCbjJON3FUZmdTQXAveUczUzd2RmFzcWJxWklKOHp3MTRV?=
 =?utf-8?B?VFUyZUgyS0JsRFQxNTc1MFhFK2V4cGNvV1d1UExQYnk5MHJEcnY5NjlvQVJN?=
 =?utf-8?B?SU9PbnJMWE1JTzFEbDU3ZjF4YllWcmNqM0xUWVBuS2NOQzVCaDcvOWlrQVAx?=
 =?utf-8?B?NFAzTTdYYzFxSEJxb0J6ZXhEUThMRFluNk5rZldSM2xBbzZ3ZXlzbXdJdmxF?=
 =?utf-8?B?ZGNYZ3k1d2gxZnpGMWxtRndjWGh4dmJWL29vNm5PV3RYN2UzakZvZU5CUmlS?=
 =?utf-8?B?REZqcVUwaVE5Q3RSVUw3bVovemFzRmZtbzhkblU4ckZqTEFlWG4rTHNsRUhk?=
 =?utf-8?B?eVB1VkU4Uldpa0wrWXNLTzlGeXFHTlAvOHBVRXlteTRJa0U5aU5LN3NEaldU?=
 =?utf-8?B?cnZXa0lyTVlrQnkrZk5zNnFvSEozODBGOW9QK0ZiZDVVMW94TDNiYysrZWFY?=
 =?utf-8?B?OFVnMG4wQ0Q3U0dPa2ZKZk5kQ2kxakJ5aVlidXRLK05OVzJNVXpVTGtPbytk?=
 =?utf-8?B?Vytzc2ovL2tFVmphd2o4SFdDSGtyQUFBZlJ5ODVZT3JhZWI3ZE9ka1VpZEVR?=
 =?utf-8?B?ZW9LZjN5RXhkbmhtVEREdExWcHVVN2J6R2NncWN0UXpaVS90Q09mZ2xmK3ZJ?=
 =?utf-8?B?enQ2VGJTK2RTcEtzS0dNZGV5N2tnNkJyb1Z0U2dNYVh1T1lXd1poTGpjVU96?=
 =?utf-8?B?YlRSTDBya1V6c3F0cjU3K1FRZVBrZTBvSFhIQ1g4YWZjeVF3UEZmUmtzTXRt?=
 =?utf-8?B?NGRkbEhCVk4waWJ5aFdyeGk2K0RnY09DVUxoZ3IydzFFS2R6cFlPWjY5RWFy?=
 =?utf-8?B?K1owZXBlOFFXUlN0K3hTSVJvMlNKOUdYTjhtTmNscEorVHlUZG85M3V2Zjlm?=
 =?utf-8?B?c2Z6dmJoVkY5dVN4QUtuaUpTOHdROFA1bmFCYWRhT1ZUNVFNUDRja3JXeXp2?=
 =?utf-8?B?bUpFclJBNmZ0cG1iaUlCa1g0UG9kZkVSQ0wvK0RKanUvV2V5MERVeDc3UDZK?=
 =?utf-8?B?cnA4ak51d1gxNG52MUZhQ20rQ2ZObzZvc0NmS2gvajhXZVpieGpaWVlKdkM3?=
 =?utf-8?B?ajJOVXZlam5jcysxZGtMYnowcGZpZWtPaGNETUhIRnloaXY2QW52Nlp3Y1BV?=
 =?utf-8?B?czJXM09oYkZ4N0s1QUJ4VDhPMm92Qlg0ZGhDbVRqQ214SWRuZTJQZm5MWjlF?=
 =?utf-8?B?dnVOQk9XSWFUeThVcDhVQ3pFMUxGVDRrMnVhM0N2blBWbGJ5YVVGdXBFa09u?=
 =?utf-8?B?U3RkazFiUXR6eFhQNXdzQ2ZJUU1nVlE4YlZRbWhTWlQra3NvYnFuZWpOZWNy?=
 =?utf-8?B?Snp2K3BKU0hyaXZjNWpLcUYzN1pmWHZ6VGJoSnBwekgrU0tPYlNiS2JZeno2?=
 =?utf-8?B?RjdiTHF6OWlDdDlPYmFRNFZ4NlAxNVdXL1NRNnJZdlBSbWJaNWJJYzRXTXkr?=
 =?utf-8?B?OTJHdnRHTitXY3FKM1BMRlN6RUMwb2poaVdKYm5uVW1pVmxubFdkYnVGaG5D?=
 =?utf-8?B?MkcwdW02eVJQVDlpSG40dTJERm54K1R4UW1nK3NiVjREVCtQSnhxSFJheDIz?=
 =?utf-8?B?dVZuZjgvUlZuMFRNcys2Z0ZITndoOGtCdXF3a0JzUXAzUmFWczBSM3ErdUI2?=
 =?utf-8?B?SWtCOVNjblVHeEpWRXJRWGcxUTdDaGdvY3ZCaEpRSVFxemdtdllYRmFyYnVt?=
 =?utf-8?B?M1dYbFRjT3grSG1LSThjREFOZmQ5VUsrd09KV2tIQURrMEp2VXFFUDdmZFBt?=
 =?utf-8?B?MG50dFRFbmh2azJSVzJwUGV2V2RrY0hRSGhtamI4eUE1M1hWVzIyTmRJZmlT?=
 =?utf-8?B?NElWQmZDWnBFVElRaUV2ZHBSL2dIZy91Szc0WlEyTjBaeDk2bjRZRXJBY2dz?=
 =?utf-8?B?WDRYNEdVUXlhamx1ampLd0lNSTdnPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 01:34:22.7820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d701e56a-f20b-4e4b-8793-08de57c40a1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9778
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
-- 
2.52.0

