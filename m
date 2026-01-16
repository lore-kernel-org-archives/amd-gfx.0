Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41F1C982D8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jan 2026 16:20:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D1EA10E8DF;
	Fri, 16 Jan 2026 16:20:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tZaDX5Sx";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3298610E8DF
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 16:20:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hty/oPMbdWQvOGrzVpXDWV6XaTYf25HQQQdXmCeucT5FXO8wE9C/oBRL90DGOpRyctUS6fzyXN5Y0Z3V5ZtegROsgzzC+W9Tji0tE56sdqsAWq0fGT0U+rzw32OKBAZVKRv9frgJGbWDHE0rFtpKQkg8QwEQZsI/Rubw09lLnRJOqhmwEAW8ihBUeO2X4mH40ihR3Pk74krIkRCxeztioLoR8SP2slGSuInvvv4FAFobaCgEmP15BT1vLaT81yeLd5qCAiBgB8SwLv/KDjJAHSAA1oanewsVjoBZCAoayrLHPaCtWAeYio07vP57xCfoH+fzp1JZd81oEDV+EfU+yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YS7Oir2ORtvZ8vBE/hm9iJqTyNl0yjEdINvmbUVHmU=;
 b=YyUT8ENjQTqn73OxF9o/5jO1k6e+uKEimejcdg8go03fql5Fmo20QI8LsHLGBYSipvLNVfWR/xTRbhc78FUp3yeiyrh6JUTXknEeM9KpLepFhJof2oHdrRq8AMXC6GTRFsvQDIgOX+0hOalNfZEFeJvBRtV44pIhGPP54hjZ9tzUzDx7VKpyChR9RVSXKyQuK3mERwB/j0uXkltqrvIbSosQK09yBTsj7NyiQkHeXqY3gEqED2qq6n4LMO2wW2Wv+ZQRELLyLEO8sBM29+cdVtMgU32rotHELItzq6uJjMgVCfRFN4743A63bx+PcbiB9sA4w6P+HDJ7b9KotncYhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YS7Oir2ORtvZ8vBE/hm9iJqTyNl0yjEdINvmbUVHmU=;
 b=tZaDX5Sx6OvJie46M6H16fRE+JMexg62DVi4HZ+kjAxyOOx/6QmfShRkFgzGcICzZXPcMnH42AbLPoBsXaJWosnq3FlJxZm3rVX+BepPUPD7eP+yTD1yciPBT7oBpJKidMJBl9BCc0xLMSmxKQyqnDtL3YTbRBOZ+ygHMn3tP6k=
Received: from BL1PR13CA0337.namprd13.prod.outlook.com (2603:10b6:208:2c6::12)
 by SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Fri, 16 Jan
 2026 16:20:48 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:2c6:cafe::ff) by BL1PR13CA0337.outlook.office365.com
 (2603:10b6:208:2c6::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Fri,
 16 Jan 2026 16:20:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 16:20:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 16 Jan
 2026 10:20:44 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Jan
 2026 10:20:44 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 16 Jan 2026 10:20:44 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 08/10] drm/amdgpu: plumb timedout fence through to force
 completion
Date: Fri, 16 Jan 2026 11:20:25 -0500
Message-ID: <20260116162027.21550-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116162027.21550-1-alexander.deucher@amd.com>
References: <20260116162027.21550-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|SA1PR12MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a8b11c5-abc4-4f05-af12-08de551b3535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2dXR1RhVWlmNnhmbGhoVTVBY2luYlBVWUNKNkhwMnNPL2tCVDYzeEpaSjFv?=
 =?utf-8?B?NHVacTRIUnJCWkZDM2dTWGxnTDFDcFplVElJZW53S205bkh3L3ZMckEyc1pi?=
 =?utf-8?B?dEN1dXduYTBTNFpObVFXWWZFclhiRldvTVZ3U0VlWG55QXhxdDZ1Q3lwN3Ra?=
 =?utf-8?B?eDhEYjF2YXR6d2lEOUFVdWJrekVjMnNtU1RXazloNmVHTmVXSTNMRms1dzlj?=
 =?utf-8?B?UkhSM2Iyc3ZBWk45d213ZExkOWd5cjRKR28zN2dVeWJKZlFacVFrbW9GdmxR?=
 =?utf-8?B?OWFFWUp2REhzWkxsT09xa1pTdG5FNXlDSllsbThLQTNzNlJnN0puWmd1c3Vm?=
 =?utf-8?B?OHVnQm91WUxPYkZlQ1VpeEV2SmlPZ3pjUjRtTUh5KzBxUEI4NUphclVQTVZn?=
 =?utf-8?B?R3h4aE80dVZ6SW9qUk5VKzZvTTcveDFJVWd5bURoTE1IZmVvTUJGdGZyVEI1?=
 =?utf-8?B?VmIwclFhQ2tiRGJOc3pwbUFIcUQxdHlraWFpMVlvMnZYbFRzMnBJMk9kd1lH?=
 =?utf-8?B?NnRBbDJLaWlMQ0xWVVdCWTRobEJWVjBTc3pzbXJNZ1ozd21rK0VwdDVKdjZL?=
 =?utf-8?B?ZWhaQW9OWDZhckk3WC94RnI3eE9HOHkraHB0cDhtT3lRS05YNE1iUzdwQkY3?=
 =?utf-8?B?SldqSkhoVTcyRkNJanNkbkcrbGM5STBzSytzZ094NTNnODBSdk5vTnZvamtM?=
 =?utf-8?B?L1lGRVgyQ2pZR1d5QmVlaGpFZk84eThSOHh0R2wreDZLV3BNK0c3d1ZTdWpI?=
 =?utf-8?B?cks5TkZ5dU1JTGxOMWk3TkdNN042WE12VDg5QkludUlZWG9ZMzNzeldtVGVx?=
 =?utf-8?B?R3IzOURCdG1KMm90V2YxTVFMNWhmajdSK2loK3BFc05NVENGelRrejQrZldw?=
 =?utf-8?B?V1NXSlFPaERMb1o5dEtWM2pNY1pkMW0yZzhoWUZDYTNmcHorMUV3dWRDcGNG?=
 =?utf-8?B?bjhUNjF1ZFVKYkxPdk1JbmV0RnhQSkNBVjc5dGFZQUx5TmEwdlFaZ28xQVQ1?=
 =?utf-8?B?Vjlvam1KL1dkbWZiNHQzbTIyemh4WFFTbVRPZk4vclR3UmVBSnF4Z1VRNGQ3?=
 =?utf-8?B?QldRSmtXS2FseHZuK3Vmek9EZUp0OXArSzFJWjAwcTNuZ3YxRlV4aWxtRGhJ?=
 =?utf-8?B?OWJaelJqbXIweG85Tmx6UHZKajZoZDdYdTlVbFY4ZmJqbytrdU16UW85ZEtk?=
 =?utf-8?B?MVdkVFR2V1Rra3kwVml4U3U2dWp1bEw3VTZSYUZsQkFtU1I5MGk1MmJsbzBB?=
 =?utf-8?B?NFJ3UEpzN0dOeUtwWllkdVNpUzdHZmNFTnRlN056NHFwaGpLcUhLVHRNZEh0?=
 =?utf-8?B?MUpHMWtJYkNtNktxWitWbStYSFNsN3YzTXlRMmRpdnBUSmR2SmtDVE1uQkhU?=
 =?utf-8?B?OEtWZjBOVGEremc5YTFSbndDU2xHZ0V6UTA4elVoQktTaElpSkhKdkJSdmZD?=
 =?utf-8?B?ek5STHNuMENJZ2Vkd3VvRnAvMk5pN3lYOGZMcHAyaExTTFVRb3JGZWZsN0xl?=
 =?utf-8?B?ZW1SY3ZNemozM1c1WlpCR3hFV3M5S2ttdTFIQjJ4UEpkTnhOeFdnR0QzUlY5?=
 =?utf-8?B?UkU4Q3Uzck5TbWpkTytVMlJiaGdVRWZMWExpNXZEaVJDcytxTzlJR0FzcDJK?=
 =?utf-8?B?aGx4TnlNbFU5QVZVbFhLVC80c2F4MFgrbFcrSUN2MEZYcnBBNEtQV244R0Zy?=
 =?utf-8?B?UU5sU0pTTldvZzN3U0ZzVzJQKzVyMUlhL1czdklQV2ZZSW9PVGRxWEx0Zm9h?=
 =?utf-8?B?UUVnMEU3c1ZTdXdxL1hzRlN1TVpvb1NRMmxUTjZjcjJ3dDN2Q2hkNWRPM0p6?=
 =?utf-8?B?aGNxYUlrT0hrM1UwaDdoZE52SXZENWN3NjQvcytKVE9oRDZWQmhJSjFiWFJz?=
 =?utf-8?B?eWR1RFNLY0p0Si9XdFdOa3RaUkI4bHBVSE1vV0Y0dXNMeHlTUG9zRXd5Q1o2?=
 =?utf-8?B?cFhLWEdnclp4MFlPYjIzcThlTUoyN0E3SThvbHIybTFyUzhvTkdPQ21VRmpm?=
 =?utf-8?B?VFNBS2UzN1ZIRW93VVZXSnVMdFUwQXRTTDRsYStVcnVKZStxY0ROamdCZU9G?=
 =?utf-8?B?MlUybTA5b1JjcWY4RkZTTE0wY2EzTVZsUGNjemhZcEdseDBSTnU2VzgydVdl?=
 =?utf-8?B?dFYrelg0c2g4UWNYWmp4c3JORVRZVlpjU1NFeG8rRW04MzVybnZ0Ylppdmk3?=
 =?utf-8?B?UFZ5UUVlcVE0aTVtd2VwVEw3SzcwRXY4U1JOc1hUR20vMlk4RFlwK1padm5j?=
 =?utf-8?B?UjgzQVRXWXI2UkRHcmpIR0JONFd3PT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 16:20:47.7931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8b11c5-abc4-4f05-af12-08de551b3535
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723
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
index 70faf914b4f0b..2daf8cd55e74f 100644
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

