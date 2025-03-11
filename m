Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4BD4C28B30
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 14:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A6E110E243;
	Tue, 11 Mar 2025 14:17:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q96ZnZag";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6021310E243
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 14:17:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oaqmKRp5HJTTfFyaT2f3cRHJ/n/3+c39uQgxDSQVtvPOhRbCS9+nf900E6rNdLDhdxmTjJDpbcZt4/qcsZeKgiLNFwtmdVQwCWyZ45swiTqhL4JpuAMvsrmtB+ylrEQ6eRwdv/ARSYthIzHi5/OYoh+l0dJL6+PzKsjcRSRZDy/ZSXOF2mheRbumbSSbNg35WP2erZVCt6VsTuc+hdbh5plIMu1tQxlM0DH/EzDVrEh6/XHTJl+V036BJDKx+GWtCiV0Sy5Diwpgv1DdAwsbNaXKUQJ1GoOd/KVh8N/sWBlU8Pdh6fMFQf5MGhQfX5swCnQSsQ0al79Bn5qN2mPHmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58B1nUSrRrprbCTI0p8mlMTyqyNomlxetgkCtkoLQ00=;
 b=sBX703q/rPBqtmpUGXnKyBkAcjc75k7mHd0MsU49ApBOEY3fRUiKQLUPMsHWlOM5zVUlAs24Xk79LEfxAa7wMKuLkIvNK8Ot//0OCuqcug7HEdI08xJT5ZkFl8ElpZbvFMHMcfF5MGAJuQB5jAp33+n3+5Qv0PItu3lpHfiHMBIqhLD7OC4wvPI+OooaNP2+kw37lvgNxi5FnMss0YofEl7t6RyawCwQlImTetYRDhWqgn2NJzHGFlHZaCI+kb1Wxse6bvUw+DIS6+3yyxhsTTJ81ToRdk5/HhTFnt76CLoVW60XbAF0P3uWswrxCrVMOKUQ+WDYXTqyS67i+BqyXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58B1nUSrRrprbCTI0p8mlMTyqyNomlxetgkCtkoLQ00=;
 b=Q96ZnZagCLSpqGHQ0z/iIzYVjP2puXjE5NDDmEGXmsHIQ8L/ktnGFNznbZtwXEdHtyM3XXJ4mr4MsmdXHOy71alrta0xldf1RrOB6x8tGkBFu1Ig56XY4Oc3pjOJJ41vlcH3EESFAdTXf9A2u4iXiXbyma+R2Zt5erMIOMitPmM=
Received: from MW4PR03CA0011.namprd03.prod.outlook.com (2603:10b6:303:8f::16)
 by DS7PR12MB6006.namprd12.prod.outlook.com (2603:10b6:8:7d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 14:17:30 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::6d) by MW4PR03CA0011.outlook.office365.com
 (2603:10b6:303:8f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Tue,
 11 Mar 2025 14:17:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 14:17:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 09:17:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yang Wang
 <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/gfx: fix ref counting for ring based profile
 handling
Date: Tue, 11 Mar 2025 10:17:09 -0400
Message-ID: <20250311141711.1911564-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|DS7PR12MB6006:EE_
X-MS-Office365-Filtering-Correlation-Id: 91baf0cd-b0c9-432b-4b56-08dd60a7750e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVJVcllqWk1ENGN0czQyOUFhelN4bDVHVzNFMDM1U0tRaHpIMGhSVlIvNFZN?=
 =?utf-8?B?bXZUZzlic0JCUWNBR0RlaDd5cWpGMzI1MUVGVmVzbjdOMXFsVWsyR1dDWkht?=
 =?utf-8?B?NXFZVyt3UUFzWTU4Ky9UWGNYaFRBbStRRFdKSnB0NytuRW0yc3VoWlZXaGt0?=
 =?utf-8?B?TFcxT1AvR2FIWWNSTXhKcUE5bFkwS09odkJLTkduM24vdHlQNFo1c05jREU5?=
 =?utf-8?B?OEp1ZUtFYkx0L0dldWVmRURtNjN6SGQ5Qk1zYTJkdDhNSDluQlQ5ZTk4NEZ2?=
 =?utf-8?B?Y2VRaHl6VUNiaWJHRlczYlkvR0U2WGFGWkhCMzJ3czJobCtjcVcvMm1NUjQw?=
 =?utf-8?B?R3VaK2FMbDR0THVEUW52NFZhS1V0aDRvRTN5SXZLRDZyR050S0VYVnhObDNu?=
 =?utf-8?B?bVBRYS8wdE1mSWFadUs2SHZOa3NTVnFLTnp3Q1hQY3pkSUVGVmEzV2lIZ3ZJ?=
 =?utf-8?B?a2JTa2I3OU5jeVhUZ1VnRnUwQzhjZWhhSEpJaEhNNERJM09Rb0gxL1E1Z09D?=
 =?utf-8?B?bWwrZjJBcFFISytoLzI5TU4waS9mNmdtdlgwRDBmZnJvOFBUdmtaLzQ0QXly?=
 =?utf-8?B?QktxcFJvQkdZY01QN1dnQnpxUGNYclkvOHNmZDc0d25RTUVHQVBQRmlLZmpK?=
 =?utf-8?B?TjhVNjNkZmNzV0RmK2duN24yVWJVSU1Jb0N1cGR5cEF5SFlBU2xVdkdKUHZC?=
 =?utf-8?B?bkhXNEZBT0xFUDV6cmo5QU5UMmhIbzk3SzdRQWFzVXU2emNWRWhzWmNjQmZ1?=
 =?utf-8?B?Yjd5Z3VqUEhrOGtlQkJETi80S1FndkFXQWtDUFk3aldwSWJ2ditwc25PL1hW?=
 =?utf-8?B?L1J3by9sbldycm1mTUZzQWJZeFNqZXdiTEU1aGZHQU5DK2w0RHpvZjNvOW5s?=
 =?utf-8?B?c3BrZTVUMDZzQTFZNDhoR0s2eVdoZCs2VkZuOTFnYk5EQnMyMGhRM1BZbWR6?=
 =?utf-8?B?T2tSRlZlNUY2VGFvYktGV1NyNnZnS1QwNUMxYTM1dWdvMFh2NWRLQ3JnVFFv?=
 =?utf-8?B?cmFoMERnWjh5akxNeG1NdDdGdjNBMWRLcWxxYzhvYkxsSjREbExHU0V5QmEx?=
 =?utf-8?B?NExyQ2xmRUViZlNKb01RM1ZodzhDR055bHR4MUdtSHRBQlJKOW92V0wvQXFj?=
 =?utf-8?B?SGVFUFFpWElCcTJEOVFYSVYvSTA3dUpYSlZoWkMwaWh1NzBmdFpRbUF4c2Na?=
 =?utf-8?B?amp4N0FXcGgrSmx1STYwdnA1THNJaWUzZ1hZY0xsVmdRQzRvV3hEdUEva0xQ?=
 =?utf-8?B?MU1jUllOTEowZklYOC8yQi9kbGxkVjR3ejBPZlVYSWdvc3B2aFpRZ3dxbEky?=
 =?utf-8?B?S0l3Y1haT3huY0ZxRjk2UjZ4Rm9sUGhmK2RDOVAwVm5ENnNNMXllOWpuSEZV?=
 =?utf-8?B?Sm90aERYYUplTXhFK1BYSzFCZVZMMDBtaFpKcmsyMUhJLzRtek1CY1NWQkRw?=
 =?utf-8?B?dUQxeUJVeGRSYUVkTWFReU5wOGZPcTJjWmI3SHlNN0pNdkZEMWpiQ1VaMytu?=
 =?utf-8?B?SkVoZUMxUUNYR0lJTmNqWXVCdXpFY1Bid3BCRW1LME90akFrd0hENVg5YTcz?=
 =?utf-8?B?SkZkd3IzdHZOWjhVL09reGxPS2RzaDc1bG9zcWFQMWlUU3ZtZkhHbnZJQ0hy?=
 =?utf-8?B?R1RRcGxwU3lUaFp6ZTBXdXNsMkZKYVZrekF5UktrQldRK2Z5bmh0cmhDVTht?=
 =?utf-8?B?U3ZERUVqMjRTeHNkaThzUTkzQjQwaklPK2liMUhFWjZ1azgwUzNwQWt1ZkJv?=
 =?utf-8?B?eWM2YjdwV0t3NUdoMzNjRjQ2d203TXlud3dSQklIdC9UU2FXTU0wMTV2VXRW?=
 =?utf-8?B?ckdFK0xGZ3dUaFBPV0Fsb0JpSFhlbitROXVRSnVOejRvUzZ5eHNPMnhHL2h0?=
 =?utf-8?B?bHgrRmJYMXgwR2JkN0VlaHJkTThMTnovb1FyVk5sYThiR0wxei83MHprVVBw?=
 =?utf-8?B?dHVuTXY1RkkxWEZNbnJadXZDa01TU1QvdG5XWGNjWkR3UC83VVZsZWlKTnRx?=
 =?utf-8?Q?Y3NiPO3TuKiYdWgPI9t52BmYMwvofI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 14:17:29.4435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91baf0cd-b0c9-432b-4b56-08dd60a7750e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6006
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

Only increment the power profile on the first submission.
Since the decrement may end up being pushed out as new
submissions come in, we only need to increment it once.

Fixes: 1443dd3c67f6 ("drm/amd/pm: fix and simplify workload handling”)
Cc: Yang Wang <kevinyang.wang@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 28 ++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 984e6ff6e4632..90396aa8ec9f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2142,12 +2142,25 @@ void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring)
 		amdgpu_gfx_kfd_sch_ctrl(adev, idx, true);
 }
 
+static unsigned int
+amdgpu_gfx_get_kernel_ring_fence_counts(struct amdgpu_device *adev)
+{
+	unsigned int i, fences = 0;
+
+	for (i = 0; i < AMDGPU_MAX_GFX_RINGS; ++i)
+		fences += amdgpu_fence_count_emitted(&adev->gfx.gfx_ring[i]);
+	for (i = 0; i < (AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTANCES); ++i)
+		fences += amdgpu_fence_count_emitted(&adev->gfx.compute_ring[i]);
+
+	return fences;
+}
+
 void amdgpu_gfx_profile_idle_work_handler(struct work_struct *work)
 {
 	struct amdgpu_device *adev =
 		container_of(work, struct amdgpu_device, gfx.idle_work.work);
 	enum PP_SMC_POWER_PROFILE profile;
-	u32 i, fences = 0;
+	unsigned int fences = 0;
 	int r;
 
 	if (adev->gfx.num_gfx_rings)
@@ -2155,10 +2168,8 @@ void amdgpu_gfx_profile_idle_work_handler(struct work_struct *work)
 	else
 		profile = PP_SMC_POWER_PROFILE_COMPUTE;
 
-	for (i = 0; i < AMDGPU_MAX_GFX_RINGS; ++i)
-		fences += amdgpu_fence_count_emitted(&adev->gfx.gfx_ring[i]);
-	for (i = 0; i < (AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTANCES); ++i)
-		fences += amdgpu_fence_count_emitted(&adev->gfx.compute_ring[i]);
+	fences = amdgpu_gfx_get_kernel_ring_fence_counts(adev);
+
 	if (!fences && !atomic_read(&adev->gfx.total_submission_cnt)) {
 		r = amdgpu_dpm_switch_power_profile(adev, profile, false);
 		if (r)
@@ -2174,6 +2185,7 @@ void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	enum PP_SMC_POWER_PROFILE profile;
+	unsigned int fences = 0;
 	int r;
 
 	if (adev->gfx.num_gfx_rings)
@@ -2181,15 +2193,17 @@ void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring)
 	else
 		profile = PP_SMC_POWER_PROFILE_COMPUTE;
 
-	atomic_inc(&adev->gfx.total_submission_cnt);
+	fences = amdgpu_gfx_get_kernel_ring_fence_counts(adev);
 
-	if (!cancel_delayed_work_sync(&adev->gfx.idle_work)) {
+	if (!cancel_delayed_work_sync(&adev->gfx.idle_work) && !fences &&
+	    !atomic_read(&adev->gfx.total_submission_cnt)) {
 		r = amdgpu_dpm_switch_power_profile(adev, profile, true);
 		if (r)
 			dev_warn(adev->dev, "(%d) failed to disable %s power profile mode\n", r,
 				 profile == PP_SMC_POWER_PROFILE_FULLSCREEN3D ?
 				 "fullscreen 3D" : "compute");
 	}
+	atomic_inc(&adev->gfx.total_submission_cnt);
 }
 
 void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring)
-- 
2.48.1

