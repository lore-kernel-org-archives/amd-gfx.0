Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DDCE6BF30
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 17:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CAB810EA31;
	Fri, 30 Jan 2026 17:31:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mUFUPq/t";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013026.outbound.protection.outlook.com
 [40.93.196.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AE0F10EA28
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 17:31:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+9Nl/pRIbkIQabEudBgJirwjWHHGMOds0J6QXDu2ZyqNpdqWeO1UsqzXcwBKQkxtDpaBiLaLZs2J/Ibl7Mx1WgKZaJxSTtQFw5+37C/5uDFjTbBYFyn+c501d99OonlLW6SaBCxzjHvbNlpi2JV4+LuiqmlK1SiYemRNJa8ZmjAOaErmlmT2YqwX0K4TFVNLtWmAyXArxy4QmqLh0ehNS9uJGFAP9nFHjdK2weMQtnEhvrYJKDZ8wfBIPNcv9jIZoJz+2coG8qdmDwJ0R/wwrQtvkltDJ4iHLdfzuh2p3oZDiphLvVnEYlGiiP4wXrNpY0LXWgydBjmuN8Urswu3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0wAkcwbZWTKS+4FNf9cCS8yrez7zZOoDnVZQyX0qy4=;
 b=dYcu5CEIgbukUPLQWMiAcNcdim7CnGU+CJf1jjS8dCXpoAO7j1H3/Iuie8fbX/R7CfcvkiLeMs6ozC+H6KoXGrUq19O9/b0Jvey71FWYqJVeF6p/Hbmhrn3DtW21aagfYdxcEwZOGfyDn9OhyFD54MPcauy/ft41ex/xWdKKzv8T11/eF11RmUvrbK+G4kFBcd+jQcmiCnaINA0YL5aRwKWUaqTt+7uJiZGcoojKv67+2x5X2ex8lJB2YtMr0ni33X68rAyCCANtOP/FJ88ThZWVMzJyTPFQ5VRg21caw2ObP1rck72pcNBsJv0kDEZDGQirit82SdNyOaubq4hG9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0wAkcwbZWTKS+4FNf9cCS8yrez7zZOoDnVZQyX0qy4=;
 b=mUFUPq/tPfoQ5pj1vLWmlyDpenszEvgkAFkaVRFKeKmb44+R2WvEdvH8psfW3/1iwpHg2l9r+DFIGdJS1tMhalo4PIx8oC5FX2DVSrKIWW2P+FKnWULMnvP//S+f4J0YMKkC35t+51augspM8WqK+k/pEslbLUOd2i4ZK4Kgn0Q=
Received: from SJ0PR05CA0147.namprd05.prod.outlook.com (2603:10b6:a03:33d::32)
 by DS0PR12MB7677.namprd12.prod.outlook.com (2603:10b6:8:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 17:31:06 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::12) by SJ0PR05CA0147.outlook.office365.com
 (2603:10b6:a03:33d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.2 via Frontend Transport; Fri,
 30 Jan 2026 17:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 17:31:05 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 11:30:59 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 30 Jan 2026 09:30:58 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/12] drm/amdgpu: plumb timedout fence through to force
 completion
Date: Fri, 30 Jan 2026 12:30:37 -0500
Message-ID: <20260130173042.15008-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130173042.15008-1-alexander.deucher@amd.com>
References: <20260130173042.15008-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|DS0PR12MB7677:EE_
X-MS-Office365-Filtering-Correlation-Id: 108ce5c4-26d1-4ecd-ea1f-08de6025593f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjIwNng5Rm1aQXg5M0tndWV3THhsMFV6RWhQa0Z2SkZLTjF0Q2s2WTVGMEU3?=
 =?utf-8?B?S09HU2F2eGM3Sk9XY1pLMncwcUpySGEwWFZWYVJIVDFqdWI5N0gySnoxSHRP?=
 =?utf-8?B?cVB1c1lXWmcwSmFrNUtOMlprMHZVbVg2a1QwekV5RlJmVEJCNG9ZbC9LTGU0?=
 =?utf-8?B?WHRpV25TcDJ4Ry9KSm5wbVI0UVNEMmtOWTVaYzBiTTdmcmpFNTN6Q3RvU0Nz?=
 =?utf-8?B?eWpJMk1yY2xEMDZ0a1UydzJjYmZlTm13SkFpaXJmSUVQMm5YMkZlYW44TjhS?=
 =?utf-8?B?MGJON1dlSytwcW1xZFBtV2xLNm9IMWFob2dFdXNialJRZUpYdTVIa3AycVF5?=
 =?utf-8?B?Ty9seWQ0eUFsN2tjMkJXOEU1TXNSRlhQeDBqUHJGMjFGUEp4OHVQcnBCZTk2?=
 =?utf-8?B?UFkwYm9qVSswbTNuKzZoaDVDWlEyVHZZQk1zTXJpbWtWZVBKQTdvU1RSa1Iv?=
 =?utf-8?B?V1hpQlB5cWhlOVk4YThIeFlER1VsM1p3TWoya21MOUNlUXdxdjdMTDhWOFVT?=
 =?utf-8?B?eUdrdlVWNU16ZFVWRlZib1ExVzlkalVsVEVtdzZKQ1RKa3RRQlN6M1JNTEI0?=
 =?utf-8?B?ejZFWmx0VXVNL2Zvcm0vcStFUVdmd0ROaXhnS0pFK3B1YnhydG9INW1HNTFz?=
 =?utf-8?B?VlJQUE5Kam01WVN5NUZvS0hTKzNNZENrUHRNTVJUOEoxYnVHYTRiN1Y2amZ2?=
 =?utf-8?B?d2puK2ZReTBML01xd3YrWEFoUGsvc2NEVXNiTnIvMmJyZ1d3OU9KcFhrdmFm?=
 =?utf-8?B?Vm9RdlgzSTFwZEtsdGEwK3JyVDAvaWI5NWhuZ3ZXY2plNjRITERGQ0VYTkxN?=
 =?utf-8?B?R1lWOVBRcSt5T1hJTTRPa0t5SWJTYTdUQjJ2Rm92akxiMzdZNmNvVGtvejNt?=
 =?utf-8?B?Znl6cmRiSDQ2dm96a3lPbk9LUHdqNFVGUSt4TEJDMWd2SHhPRCsrRCtYVi9S?=
 =?utf-8?B?NHQ3cjNxN0puRklYUktQUzBuN3d2Qnc5TDBhZmd0OGxlTVc2Sy9MTkQwdlpk?=
 =?utf-8?B?OGJZekRmNS94eTlJbTRtekRBRzAwZUlEMTZmbGpRZnFLVnJxRHY1bm8va0xQ?=
 =?utf-8?B?cUZWUm5BclN1ZVo2MVJ0aWl0Mk1yWmtxK0NxaXVmdThyT1NMaVhWWGhRcTBP?=
 =?utf-8?B?SnBobVhIRnlKU1VhV2dXT015SjNjREw2aUdNMjNFd3QzSytVSVRyaGk5N2VL?=
 =?utf-8?B?QzRWdXRvSitxRjUrWk5wQ3Mwa21BdGlQOWZXdDdaRjhQMUtGN0tTM2h2a2p3?=
 =?utf-8?B?eVNUVFhyc05leG5CZS9HT1RCTXB1cnFiWGhONzkrc25ybDk2bjFmdFdtUlV1?=
 =?utf-8?B?RU0yTmRITUFCeWo1K0hSU2hraDNKb0VVZloxS28ybDBxdGkxdndjRUZ0WVZP?=
 =?utf-8?B?di9NcElFc2I2T3RhMGQ1UCtnOHFVSUVHVFk1ZnlMd1VYR0hnR1hqeEVHTWg1?=
 =?utf-8?B?T0ZjWWt4Y1hrRzZjQXJlSmpTQVVSb1U3bHdPTnVRclliRDlndXV5aXIxUFNa?=
 =?utf-8?B?R1hCcDFHRDNBczhtWXJGc0tpNnBDSGp4ajFEMzB4RUhKZzlzY1JLUXdCSDFn?=
 =?utf-8?B?WE9NVmZNQmJLYnd3U0R1SXppd2pOTm5qbjAwdUs0ZTVJYzZWajV6dzlucFVU?=
 =?utf-8?B?d0Rrc3lJQ0tJZXdGbWlUTG13bjdVQk41QmJnUlA2U3B5cjU0bDdjNlA3WFI1?=
 =?utf-8?B?WURqSWJQT0pEamF4TXdueVB0VTNoOGduTVhqVys3NnNxMExXZnFCSGRsc0NZ?=
 =?utf-8?B?Q3NFUTg1c0VZUXVsT3ZvZGFrTmsvZ2kwK1lQaEpiNnh6TFNTMU5LQUllNzlN?=
 =?utf-8?B?d1llNnk5TU90MkM4M0ZtWlRkVElGd1luaW1SZVljNTJUeFlHejUwbWFSeUl5?=
 =?utf-8?B?aDc4ZzExeFNIMkVQWW80VkJVcFRNa3M2dGx1dkw4N3Y0cFA1MkI4M3lPbXYr?=
 =?utf-8?B?bDhMMXlEdC9qN0NNYzgybHhIUlk0cUlBbXZ5elJVcVA0ZTVzZmJzWWluRkZK?=
 =?utf-8?B?YzJHUUJJZHh2SDVOOWptWDlrYkxRYllOWlVrSDNmYk1LMWxPVkRJK0ZmN3R4?=
 =?utf-8?B?Q2JTVFd3RWM4cVc0Z3ZqZVJWS3FWdkIwTDdCSXBQcnhEM1VSR2tuczc1TjN1?=
 =?utf-8?B?R2pZVzRJR1I0MEJuUVFpa3l1by9nV3dIWU1FcEVqZ3cwa0tqQjZ2aHFuNGxv?=
 =?utf-8?B?YUpHZTFlRlRZck5Gcmd1ZFB1bFI4VU5nbnB4QktNeWh2bXYyMmRCakEvYUs4?=
 =?utf-8?B?eUlSTWpLK2o5WnVhRE1MSHV1WVNRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 03gax8JaQi0OFfjIkou3TJ515GwIhSaguwdgCuSXHo3IoFo5CENlmxx9TY3h0LFEkmtbmIcZG1YcumyZTLkUcBSIMKdha7ELxjgfvcrEL2kaNTO11h0pG+Dv+RkwtDCusJznhOxagntwsLtiiFRK/41f2eJ5Ks0AZCrztSKeEzcsCRrmWTUKb2EAYRtmr/bQoWrlcqsuDRduCJInJ1V80fHGBFEyHb9TIjvRcG0lFEEodqW6Mz/Hcvg0JQZ1gBdW2UksteaWfbYVU84az0bY3aGWaohhz/6txLt9qTXln/LZryRzMtuBi0A7DE272tlMr3wNEHi9It+zgzwvLWuBWQD1xp522dQOtvtj/3TwbeUeOMwHLA4BNSQX0sOfNuCdYmwTZ19Jyhi7rvZbwPCmfLL3+uddMYYjc0TRmXglTogBDVU7y2pohQP2EiP/4w/k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 17:31:05.9241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 108ce5c4-26d1-4ecd-ea1f-08de6025593f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7677
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
index aeb90708f2293..663d115ab169c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1936,7 +1936,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 		/* swap out the old fences */
 		amdgpu_ib_preempt_fences_swap(ring, fences);
 
-		amdgpu_fence_driver_force_completion(ring);
+		amdgpu_fence_driver_force_completion(ring, NULL);
 
 		/* resubmit unfinished jobs */
 		amdgpu_ib_preempt_job_recovery(&ring->sched);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a5b43d57c7b05..fd1415625d756 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5795,6 +5795,7 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 {
 	int i, r = 0;
 	struct amdgpu_job *job = NULL;
+	struct dma_fence *fence = NULL;
 	struct amdgpu_device *tmp_adev = reset_context->reset_req_dev;
 	bool need_full_reset =
 		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
@@ -5807,6 +5808,9 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 
 	amdgpu_fence_driver_isr_toggle(adev, true);
 
+	if (job)
+		fence = &job->hw_fence->base;
+
 	/* block all schedulers and reset given job's ring */
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 		struct amdgpu_ring *ring = adev->rings[i];
@@ -5815,7 +5819,7 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 			continue;
 
 		/* after all hw jobs are reset, hw fence is meaningless, so force_completion */
-		amdgpu_fence_driver_force_completion(ring);
+		amdgpu_fence_driver_force_completion(ring, fence);
 	}
 
 	amdgpu_fence_driver_isr_toggle(adev, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 1054d66c54fac..3c38bf58fd3f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -567,7 +567,7 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
 			r = -ENODEV;
 		/* no need to trigger GPU reset as we are unloading */
 		if (r)
-			amdgpu_fence_driver_force_completion(ring);
+			amdgpu_fence_driver_force_completion(ring, NULL);
 
 		if (!drm_dev_is_unplugged(adev_to_drm(adev)) &&
 		    ring->fence_drv.irq_src &&
@@ -682,16 +682,34 @@ void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error)
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
@@ -752,7 +770,7 @@ void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af)
 
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
index e78526a4e521e..a6aa72ec8fb19 100644
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

