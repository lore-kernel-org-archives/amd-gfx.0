Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32861C7EE32
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:07:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D9AA10E823;
	Wed, 25 Jun 2025 21:07:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rtXSTPV0";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C622910E260
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:07:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8uf2NapZHqB2oxUQhCJg+Iiawxp8SjcdFuY42ukpammXATk7WHLyA1xibzlXj9wbFCvmPq3Z6VgulFlQAI6i79rZAooc/EUItRm58K+5vHNw5q0/IjzuSVXgxcur82noNMv5DDF9LI4KwAixVEFBiyQQGFARBWH+xymtDHAXbiy4YD1TvLP6XrGmflUsLMUyPLo3UGwYg8GgpUKK8GVRZb40+BfE12napAERLUzN+Cwk6iGGUeQXZiA2tGP8p7olAJmQmtfykJRqcSWcEbF0wk4jPpE7z714cmxztOq4K4b4yVeWPVislfbpcr5YkEM2e7jZ21hXbKUfYycGIphoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gDp/RnAzpGu6pwOhcEod7lj2figp5i3YzMRbi4e6Vc=;
 b=Ucj1pIYN1qoaE/FEYuEVEt19jdeDRcZ/o3xMYTv8X5RWV0FL3aHZNxQTScBjFlch9jACd5+AF1bQzR5YmuIA6ZLdqK9uxQhwZrv9GC+SDwhPqNqiRU5PZhNbd4uiLA8StvTGZmvtKg9e+Oua1/4qT5wDBPmm90/ovVbGK4R7KO80/mqjdeZeXzqjRTHA3p3j8LKWp+RIMPpPkdbY60DzTyo6MlaYvtyOmdbaC7sRMt5mtIqYRuhOOAfAmKfyvJkbGC/laynBrqRe/hNpOFlJFex8CBvEji4keHGDf8bngEC9h1YB/IkfCPqHhdYqVK/acWjaomOOCcSJRcB6drMuPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gDp/RnAzpGu6pwOhcEod7lj2figp5i3YzMRbi4e6Vc=;
 b=rtXSTPV0i6MK2hD2yOtf1OKozPve5z1SI//xPOikSQoOkCNMGS3PIb3aN3nhioHIGNAif+NJiOpJaPjMuNTERBANI1GU43y7+V6X8Chay82/8APSIDfA1U4GUe2THg2XQl00FGZr+wI7zRqdATGPfuUh8r8bLeoBPddmlatW0I4=
Received: from SJ0P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::26)
 by IA0PR12MB8696.namprd12.prod.outlook.com (2603:10b6:208:48f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Wed, 25 Jun
 2025 21:06:59 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::c4) by SJ0P220CA0020.outlook.office365.com
 (2603:10b6:a03:41b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 21:06:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:06:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:06:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/30] drm/amdgpu: move guilty handling into ring resets
Date: Wed, 25 Jun 2025 17:06:13 -0400
Message-ID: <20250625210638.422479-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625210638.422479-1-alexander.deucher@amd.com>
References: <20250625210638.422479-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|IA0PR12MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a1521cc-9ec1-4d90-a115-08ddb42c396e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clMyS1BZdFdNSHFZR3YxZUJ6NFd3c3lMM3JONXRINXpLRmdJUHdaQWVxWERq?=
 =?utf-8?B?ZWpUTGtDN2U0Si9mNHp3dWEzSTNXN1I0ME9xQXUvaHFUTXAvR0JYOE9MaExs?=
 =?utf-8?B?K2svSktvMUNodkNMS0hQWjMyWmlIdCtKelQrRldWWU9mWlB6NjBhcHMvQjRP?=
 =?utf-8?B?NlNvZnB0V1JRWWUxc1VhOURrcVFxdlBuUzdxWmhPYzJWS2psRG1kcnZnUHRT?=
 =?utf-8?B?NFUyWDB3eXVlNGlkRTJVQ1pJQk5YdEZPOUZudmk5Z05CYXpPY0RlUWQyalRG?=
 =?utf-8?B?dnBNbVlPcVUvMkNsM0kzMkl3NDF3VlNHWGtNb3IzUEczdEdDNHFUUzJMMzhD?=
 =?utf-8?B?eDhGeHUxRTJGalNVbTF4TlFlQjd3dnZCTE0rUnBtMTZVQklTeHpZUVNRMkZ3?=
 =?utf-8?B?ajlHVEZUMXV4WGJYK2lPdE9RdGZ0RC9zamEzT0ZEd0hFdEVXaXlNWHljSmJi?=
 =?utf-8?B?bk92ZVRXenV0YVpQckI2Ly8wMHZUUk9xRjR2aXVuYzdzVzBrMEh4T1N6ZlpO?=
 =?utf-8?B?NURwa1NHdVc1RW9kcjd0SHVaT2VtVDdlQzV1cS95QlpRbHFUVmhtWTFhTlVF?=
 =?utf-8?B?bzAxN2hieDBOK2x5akRkVlJQZnBMNE1ZdFpBNFZ4RmUyL242WnhLK05zWEt5?=
 =?utf-8?B?MnJQeTJ0NXp1U2lPdlo2ZklGcWR1TlJYYXVCZnN4RWp3dXRVb0VsTCt5bkFr?=
 =?utf-8?B?TW5SZUNNenpBUUUrN3lPKzZlWlJNT0lSbGJpSzlQSmJaUVdSZUgvakxreTl5?=
 =?utf-8?B?MkhuTDRFUTEzeXZpSjl1TXFJMEhJUGFQRXZ2TGdaTFZEZjROWXlxWHhkTUYy?=
 =?utf-8?B?TGU1SE1YMnJBUXhmUG1kSDljTTNlUjJCcEpGNi9WU3c2NmFRd25YMTVJNy9w?=
 =?utf-8?B?b0hXMk8wWVR3OW9ZR2VTK0NWRG96cU4rSEtQK2Q0UkEyRVBEQmZJWXl5MFBO?=
 =?utf-8?B?NzVlZVBoTEhzMktzYzlPRlVOZVpxRFhmRjhwckNMWW1FT2VxMzN4V3hxNThI?=
 =?utf-8?B?QUpqbm8rbHk3aDBJTzlIWmM2WFZOZW9PMnZJbm1WSE03NndISzlyc2xYUkI2?=
 =?utf-8?B?MVFNbGNETllUZlJmOTNNVmo1ZGZKRVNFSDljcU5hV3doaFY3RnNEWXFyVGtB?=
 =?utf-8?B?V2NYcmQ0RndBM0szZUtkWjZqKzZwRWZCVCt1aXRUd1BpaXhtS0QxL2Z6S01Y?=
 =?utf-8?B?SjdrNEJrajFtL3hmOHFEb3dZUlF5eFYwcTgwb3dXSHpNaGxWRUd3L01DdEFy?=
 =?utf-8?B?WGhQL1FHeTV6REZ2R0FNcnNBMjNQR1g1YU9rNDRHZ0N3QzV0VVNjT0h5V1lM?=
 =?utf-8?B?MW1DTjhnVWpGVXhIRFREYktZNGdHS0hQUUZqRkdhTWt0ZDFQbjJJaklZdUtQ?=
 =?utf-8?B?OWZzOGFMY1lKdTE2c0hWOVJOaTdrZGFJcFJJRjdLdEhPejZBRjl4SnBGU0Ny?=
 =?utf-8?B?YUZGUGRJVXI0UW9WNDMxcjRTK2kwTUw0STBPREI2bUpHYkVmSEw4NVFENFVp?=
 =?utf-8?B?WktlVGhEWWtDeWo2QXFxREptZ3lCTUZpNHFPZmd4em5MdFE3Wk9QeXd3ZmtM?=
 =?utf-8?B?cHY5RVN5TUxrVTYyN3hxaEMxaG9WL1ZJQlpEd3JyRGlDU1ZKSDZNa1RPclp5?=
 =?utf-8?B?MWRiMTJVTjUyQUxQVVFLNWFESU9LbEgrTkZUa2tVWU5Ca2JQbWxWU2ZURDk4?=
 =?utf-8?B?d1U2WDRkdkJVSjQ2Q01INjRHZ2xxWlFkV2N6Y2RjTTh2aEhseC9CUWhzdlpo?=
 =?utf-8?B?dHZuUjZORkEzZVMxN2dGSjhUSTRhc2hqMTZiWmVSNGRoTUhqSkNCNGlqTmY4?=
 =?utf-8?B?R2EvYURxUCtTa1hSaFgxUkdCaWYrdFFlZ3kybHB0WDk1S0pSc1F5eHppSHVP?=
 =?utf-8?B?cVlvdGZjaGxWbHBYVkk3dW16bTh3RzQrWFQxYnBZYjU1Wk9EZjFVa3VwRFIw?=
 =?utf-8?B?NnIrYXZ4eGFBemkwUjl6aEROVzRQZmhqUlBnWmthZVNnZlRuZGJWcmdGcU50?=
 =?utf-8?B?VVdJQS9FSis0bkxPUGFGOE93eTYra1QrTm1JZDVrcXUwcDdnczVUaklLNzlX?=
 =?utf-8?Q?ngjhDa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:06:59.0251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1521cc-9ec1-4d90-a115-08ddb42c396e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8696
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

Move guilty logic into the ring reset callbacks.  This
allows each ring reset callback to better handle fence
errors and force completions in line with the reset
behavior for each IP.  It also allows us to remove
the ring guilty callback since that logic now lives
in the reset callback.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 23 ++----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 -
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 30 +-----------------------
 3 files changed, 3 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 177f04491a11b..3b7d3844a74bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -91,7 +91,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	struct amdgpu_job *job = to_amdgpu_job(s_job);
 	struct amdgpu_task_info *ti;
 	struct amdgpu_device *adev = ring->adev;
-	bool set_error = false;
 	int idx, r;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
@@ -134,8 +133,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
 		dev_err(adev->dev, "Ring reset disabled by debug mask\n");
 	} else if (amdgpu_gpu_recovery && ring->funcs->reset) {
-		bool is_guilty;
-
 		dev_err(adev->dev, "Starting %s ring reset\n",
 			s_job->sched->name);
 
@@ -145,24 +142,9 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		 */
 		drm_sched_wqueue_stop(&ring->sched);
 
-		/* for engine resets, we need to reset the engine,
-		 * but individual queues may be unaffected.
-		 * check here to make sure the accounting is correct.
-		 */
-		if (ring->funcs->is_guilty)
-			is_guilty = ring->funcs->is_guilty(ring);
-		else
-			is_guilty = true;
-
-		if (is_guilty) {
-			dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
-			set_error = true;
-		}
-
 		r = amdgpu_ring_reset(ring, job->vmid, NULL);
 		if (!r) {
-			if (is_guilty)
-				atomic_inc(&ring->adev->gpu_reset_counter);
+			atomic_inc(&ring->adev->gpu_reset_counter);
 			drm_sched_wqueue_start(&ring->sched);
 			dev_err(adev->dev, "Ring %s reset succeeded\n",
 				ring->sched.name);
@@ -173,8 +155,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		dev_err(adev->dev, "Ring %s reset failed\n", ring->sched.name);
 	}
 
-	if (!set_error)
-		dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
+	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 
 	if (amdgpu_device_should_recover_gpu(ring->adev)) {
 		struct amdgpu_reset_context reset_context;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index de972f69d96e7..784ba2ec354c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -271,7 +271,6 @@ struct amdgpu_ring_funcs {
 	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid,
 		     struct amdgpu_fence *timedout_fence);
 	void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
-	bool (*is_guilty)(struct amdgpu_ring *ring);
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index c13ae87d4e648..d3072bca43e3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1656,30 +1656,10 @@ static bool sdma_v4_4_2_is_queue_selected(struct amdgpu_device *adev, uint32_t i
 	return (context_status & SDMA_GFX_CONTEXT_STATUS__SELECTED_MASK) != 0;
 }
 
-static bool sdma_v4_4_2_ring_is_guilty(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t instance_id = ring->me;
-
-	return sdma_v4_4_2_is_queue_selected(adev, instance_id, false);
-}
-
-static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t instance_id = ring->me;
-
-	if (!adev->sdma.has_page_queue)
-		return false;
-
-	return sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
-}
-
 static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
 				   unsigned int vmid,
 				   struct amdgpu_fence *timedout_fence)
 {
-	bool is_guilty = ring->funcs->is_guilty(ring);
 	struct amdgpu_device *adev = ring->adev;
 	u32 id = ring->me;
 	int r;
@@ -1690,13 +1670,7 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
 	amdgpu_amdkfd_suspend(adev, true);
 	r = amdgpu_sdma_reset_engine(adev, id);
 	amdgpu_amdkfd_resume(adev, true);
-	if (r)
-		return r;
-
-	if (is_guilty)
-		amdgpu_fence_driver_force_completion(ring);
-
-	return 0;
+	return r;
 }
 
 static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
@@ -2181,7 +2155,6 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 	.reset = sdma_v4_4_2_reset_queue,
-	.is_guilty = sdma_v4_4_2_ring_is_guilty,
 };
 
 static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
@@ -2214,7 +2187,6 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 	.reset = sdma_v4_4_2_reset_queue,
-	.is_guilty = sdma_v4_4_2_page_ring_is_guilty,
 };
 
 static void sdma_v4_4_2_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.50.0

