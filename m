Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F50EA8127
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 14:55:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8636210E5A7;
	Tue, 10 Feb 2026 14:55:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YArwEzWp";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010059.outbound.protection.outlook.com
 [52.101.193.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D80C510E5A9
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 14:55:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAUcVaC6yfW+xTOeDr49NG32XXks/bprXJqhig85qHJOw5GbLrWDm3z5M0U9q93YzEbPRyCqJhT9Y4zjXjM0D60JeVZYnj6THz5x4hbTZkOpCItdFVpLHFiSunF8MWQhlLcFKJUtYl3Wy+ylbLHtifVR6j+6ico5FLqHMqoGEXkT7syaMQKHi1nHUAnFWEvxNlevwa/grL8HgUJPlEtb0mw3+HuI4IZzFd0Q1aPio0EdYK0l/7NCu+vkPHM695CpJVTLbu2jENJTBl3tqbYQ1qsNPYIceQiibTQBZftdtszhhUGmsWEgaN/cMEi97vtAXYIrveHTWa4iqR73EAmEMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wg4HZ1lBBUIDc1zLnRVaRKO1UvKItdnbyiewOsfA29c=;
 b=HXUjstelB5MxoG2hyig2Kbpp/VtN9r39lwId6fovGZVna+xDgSWVlZih1njSUGS9mV/m4cxcviS19STeUv8u0doCQTCBFuwtfWphS9mDUDqu6vMC3ZMGtlHQXUFqEaJ0vZFwtQ9jzzQZGek2BVgP7VSEga24e12mPClrH6Ud4qVy6sTtyAGcmLHx39I45j2yjm0eGJ+NvswJeg9iTaGtDXyVGFMHeVg15LEWwgq2KZ8hlJePLev5u+hgT7pA9MnQxsbLiFT4cb/GsxVqtmr28hPfzSFM7imTBu4Hq4xgO8aRumfO5dYX1V6tjmwlnNPh4m90pabwXI7X2A8FfnDJWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wg4HZ1lBBUIDc1zLnRVaRKO1UvKItdnbyiewOsfA29c=;
 b=YArwEzWpxI3uVSctS1IPK2LeMVjvQiG4MQsYpiApqPf6meUpxnyraxowDgH3bXN11lJMrNgfvJUDn3eXtrzCl0jEHnXs8wt4lBEjqHUpMGHzAfb67QuZbPaW5UD9a7/LZgRQSpTz9pQ7Qppt8R2ODMKaO5rGoHVc6GSGsIPfhj0=
Received: from PH7PR17CA0027.namprd17.prod.outlook.com (2603:10b6:510:323::13)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Tue, 10 Feb
 2026 14:55:39 +0000
Received: from MW1PEPF00016159.namprd21.prod.outlook.com
 (2603:10b6:510:323:cafe::1) by PH7PR17CA0027.outlook.office365.com
 (2603:10b6:510:323::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 14:55:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00016159.mail.protection.outlook.com (10.167.249.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.0 via Frontend Transport; Tue, 10 Feb 2026 14:55:38 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 10 Feb 2026 08:55:36 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu: Make amdgpu_fence_emit() non-failing
Date: Tue, 10 Feb 2026 20:25:05 +0530
Message-ID: <20260210145506.1539775-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00016159:EE_|DM6PR12MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: 18171736-e2bb-4f8a-6e51-08de68b47429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akJMRDQ0c0Z0cVZoTjZaRm1UL09zUkp2dU1xd01HdkpGSEdhTEFORzNjdHJM?=
 =?utf-8?B?eHF4TDhCVHQwUERTSXZwVGgrd3pGd1daVU5YeTVPOTdGanRLVGRqaXMzY3Rp?=
 =?utf-8?B?TU00NGZ5N2pkeExMckxweGRrUFdCbm9oNzlkT1NZNUZkOWZpT1NQMC9wNGFP?=
 =?utf-8?B?NkF1eDRHaTdtV1JXQkdJZzZ0ZHV1MEZYdDhPWDlGWTBPT0pidW5IL09tMVNr?=
 =?utf-8?B?UlVRTVZmR2hwZUdqR0Q0cEVJTHdydmF3K0hteTBBaEdZVEZCKzUxNDM5QXE5?=
 =?utf-8?B?Vm4yMERGVHJ2TFNUbU5keWJtVk5XMHBrTXlwUmVsSHZqZk1iUXVTNHhHWDVW?=
 =?utf-8?B?N2VOdFRHS2xwanYyYk93VjFob256RWRmL2xLU3JqZnFpbkpqMnJBUlJlVmR6?=
 =?utf-8?B?NW9RKzdqcG5KcjB5aDQwMk4zTFZmdlhvUm84aDV3QmpGam1nR0I0dXQvWXZN?=
 =?utf-8?B?c3U1bTh4Qk9OWnAxT1M1Skh4allycnZ3QmovekttUGNjanR4eDJ5ZlJIM0ZT?=
 =?utf-8?B?TkRQbGFqTys0WSt1MHplSjZ2ZWdnZEJSVUJyOUp4dVBiSTlKNkZPVHpTa01x?=
 =?utf-8?B?Mzc2NVRXcUFlSWk5MmJqMVQzdlNwKzd3OXBTbkRGTk1RaUU2emJraVRhcFBW?=
 =?utf-8?B?QUczNFZTZ29JTkVQY0NodzllbHB4M3NWVVJqbHVmcmdRYVJiWjRITEZNSHhG?=
 =?utf-8?B?NkdyMjdwb3ZvVTdTSGZCRmNyT1N6a1hPTkdqS1RleTc4Q2NCblRxK0JnUU5N?=
 =?utf-8?B?N1U4YlRacE1naklubUN2OVIzSWFUNFVGV3hqSms0RlA4WHFyRjNOYktlN2RL?=
 =?utf-8?B?K2E0dmdFV3NHRmZHK21EK1NmcXl4cHZHTlhZYnd3OE9jSGVqMWpFRzVKK25i?=
 =?utf-8?B?Z0ZjUWpNNEFpN1c4VnRmVHpMRURkYlZKQmd2OSswdjNqZ1VkUVV4clVscjVL?=
 =?utf-8?B?NngvdHpxZ2ppdnBOMFRVdDNSK3hZZHYyMWYrNUFZdzlueE1BNExLeE8vRE5Z?=
 =?utf-8?B?dVRCZ3VmbEk2dC9HU1V6enQ5UzJtV3RHN3grTjYwUTVPcTFsWXhhZlFQSThE?=
 =?utf-8?B?QW5yMTFPTXIzbjF4eVFGTXZlQXZDZU1TZ0pkbFh0TUVaSExFYjgrU1Z4V2R4?=
 =?utf-8?B?MzUrbURaZnh2a0RUTDNyd1hRcnA1SW52NzhSNWVkeWlndDk1ODNLZXcxclpE?=
 =?utf-8?B?Yy9FdG90TDZaeVlDN2Q5MmZ6WHRCU0FiN2FHV2tLQ2RnaXdHNVVzZ0tZN0Vm?=
 =?utf-8?B?d0JjSi9qWjAxVHhOalJCeERtR05PVERvQmIrSHFlaDVZcEdtby9jZHc1NjVx?=
 =?utf-8?B?L2hKQ1JCOVorakFnVm40Q25JZXVUbnFHeVBsamlMWDNIV3ZjcnR6R2p5ZGI4?=
 =?utf-8?B?NzN6QVU5R1VuZFZxbys2TlhlbmRueWdRaWpmQjdJaGFNeDNyQlZGZ2MxQ0ZF?=
 =?utf-8?B?Z2t4M0xDWURrbmlFNXZHNXRseEMvbW9RM0drMWZDTzZUb29hOXZCaE4rVHcx?=
 =?utf-8?B?T1lGQWttYnpBZ0NzRnhJclJWSUdlN2NGeUEyZ2o5YVo4aXZTR29IMCtjMEZP?=
 =?utf-8?B?TzhGZGxRNHlzejFpRGNsQ0tyYWhQYWpqVHp3S0ZSWG42Z3ZTS0VQL3VyMlhN?=
 =?utf-8?B?MUZIWmtnR0tDZTJBU2lNcGFPQ3lZaTE3eGRqMkU4NDh0cjl5enUwNDg1akNW?=
 =?utf-8?B?SW9qWXNRd2hWY3k3Y01ydGdQY21HWldMQU1aVG1GaytNcm5yclBIQWZlc0F2?=
 =?utf-8?B?aWw0UzR6Q1VrazR0TVI3WlZ2U1VOQk5SZzNob21MWStpT0pJc2IyWXdZMUJO?=
 =?utf-8?B?MS9oT01PR2ZnbHo4OTlqOTFFN3pjZmZTeGpYRVd0YzcwMlhWd0VUSHFCTjhJ?=
 =?utf-8?B?cXZyUW1nY0hpQWo1clhjRm1ESlcxYjBkR3JGRTJ1a21XVUhUc2pjd0tyZ0RK?=
 =?utf-8?B?dHg3cG1mbDVBMWJUNVZMNXNxd0RuUHZtbHNhZXAwbUF4aUx2TXJ6bWZnejRL?=
 =?utf-8?B?b3NUZG80T3lzWDUzZnB4SmhQMFNPM0JlWUtJRkhNdUxOQ0NYTDdJTmZGNEtY?=
 =?utf-8?B?aDVnbytoMG1acTBIK1h0S053cFo5bnFlTFBPb0RWbXZLc0tlY0tTS2x6Uk1L?=
 =?utf-8?B?V2w2NVhsZUlrbFpvTnV2c1d3RW9jNUFDbjNVYTk3dlNrL1pWYU82RHhLOEdu?=
 =?utf-8?B?cC8yWUVJWDVSMC9vODRVbHJDbTE2TjVjaUViSDFsNmtLQ1psbTJZNXdSdTRr?=
 =?utf-8?B?ZnB2NndmdDQ3dDN4K3FFcVhTd1hRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: s5G9qHxatiBB05Bm/5CZdf/VMYEY2XqpHDYb2OXo1xjIu+YO3zD1+pg2YWmNNlH6LTuendbEC8ttfnMStyWzy4eKf7V3oOu8+2f2H8nfhdTeMAOasceoFVcYBgAobMl9v6Jbqt/YQq20LN9J5eZQM1H85+W7HKAO3uXBF+xI4JlcC+f2tJoXUJQTVsI/rTcYYsnhhvuI4xZnzh4GltItpnxYvH4fIoE3kgdp1ueogSEcC+fHiWHe/ZekTBunEE4EpCxtQb6fDa9oC1xyVNYl4qwIUqcHNogUc9EuZXQ1waWxXXYa7v8YHwKgyL9pucgbr8s3A1w6Scbvd/QFE7vaOyq2VtcuRt4Pf3+pmuSg9qp/4/XmX02CZ6zhB5VdkiMLUxh0VBEGDA/PDrp8+Pj/a1z04VtImppSBLAZpixpZcjnJGh6Q6nND4+D7m1WqHcL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 14:55:38.4759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18171736-e2bb-4f8a-6e51-08de68b47429
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00016159.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267
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

dma_fence_wait(old, false) is not interruptible and cannot return an
error. Drop the unreachable error handling in amdgpu_fence_emit().

Since the function can no longer fail, convert amdgpu_fence_emit() to
return void and remove return value handling from all callers.

Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 12 ++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  9 +--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  7 ++-----
 4 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 1054d66c54fa..4d2052347aa1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -107,16 +107,14 @@ static void amdgpu_fence_save_fence_wptr_end(struct amdgpu_fence *af)
  * @flags: flags to pass into the subordinate .emit_fence() call
  *
  * Emits a fence command on the requested ring (all asics).
- * Returns 0 on success, -ENOMEM on failure.
  */
-int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
-		      unsigned int flags)
+void amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
+		       unsigned int flags)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct dma_fence *fence;
 	struct dma_fence __rcu **ptr;
 	uint32_t seq;
-	int r;
 
 	fence = &af->base;
 	af->ring = ring;
@@ -141,10 +139,8 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
 		rcu_read_unlock();
 
 		if (old) {
-			r = dma_fence_wait(old, false);
+			dma_fence_wait(old, false);
 			dma_fence_put(old);
-			if (r)
-				return r;
 		}
 	}
 
@@ -155,7 +151,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
 	 */
 	rcu_assign_pointer(*ptr, dma_fence_get(fence));
 
-	return 0;
+	return;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index bfa64cd7a62d..07b43a498592 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -297,14 +297,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_addr);
 	}
 
-	r = amdgpu_fence_emit(ring, af, fence_flags);
-	if (r) {
-		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
-		if (job && job->vmid)
-			amdgpu_vmid_reset(adev, ring->vm_hub, job->vmid);
-		amdgpu_ring_undo(ring);
-		goto free_fence;
-	}
+	amdgpu_fence_emit(ring, af, fence_flags);
 	*f = &af->base;
 	/* get a ref for the job */
 	if (job)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 1abd8fdb5cef..5a82db0888f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -172,8 +172,8 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
 void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
 int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
 void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
-int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
-		      unsigned int flags);
+void amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
+		       unsigned int flags);
 int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
 			      uint32_t timeout);
 bool amdgpu_fence_process(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 807f8bcc7de5..2be65bd6b39c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -783,8 +783,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	bool cleaner_shader_needed = false;
 	bool pasid_mapping_needed = false;
 	struct dma_fence *fence = NULL;
-	unsigned int patch;
-	int r;
+	unsigned int patch = 0;
 
 	if (amdgpu_vmid_had_gpu_reset(adev, id)) {
 		gds_switch_needed = true;
@@ -845,9 +844,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	}
 
 	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
-		r = amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
-		if (r)
-			return r;
+		amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
 		fence = &job->hw_vm_fence->base;
 		/* get a ref for the job */
 		dma_fence_get(fence);
-- 
2.34.1

