Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B04C7115B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AC5510E411;
	Mon, 23 Jun 2025 16:15:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k4hANdWc";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0374110E408
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:15:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjBp+yLrRP2tFpfqBnluQbLS58UNptGPKFc5Z9qxrPFyp3JFm5ZTYj09sP5HLU93xOFK6Zef3SQM+gb9vcQHX7RyXLzXUU+eMp3NFNcR63Q3sy/034ZBVcQXNGbYUYkConUB0zlhrzV8nmnnH4J2QgIu3urV3uoWKdv7ChQB9oGIHHK8yBbNWMeJ2tI5NMuBziy1IpCY/1GcfTLoxI6zGffXIuZoRm8syPACq8vfR5QRgi03PTVvBvxj0t8Gle0WtKsGVThnoVoGpZyQbeZAZW+8P53JF7UCExkFeTJeD+E1bLxbogOvXfmJw5ndyUurgAI8OH2rfH3TWOS8y1fFsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faJ3KHc9MNwmooeKUyuCdfTg5tj+wEY5so9Ngpgz6i0=;
 b=i+fqve/6l/1ivFzOMoo8GRlI3aZ4qAShC3XZzflbMcGC81XryItKO6KpEUxv0aZ48dQt2PO5GcnYLR1GEGwcWLS4nMUwQ8fhyYFP6OFcgBYhZ7w18xh5RBW+S6E4fsc4VV2yc3joiWLBndwV6dVyd+budXQ6JIEfnRDaBJK5LXXYeUrI0PRg6Sqfj/21yREjCXvb4o+b84G4avxrbz9N2NU5mSh25Rq2Ol3GWFdz7aqwKAvWKchy8NY6hiLGxGFZcbWJsrL6C1E0IvM7YB9gdj0UjZFhw9JwECjJMiSZabwbbOxkDWiJ60OAPU62t7WUZj/3QbAcm8g9/tIgEVn7pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faJ3KHc9MNwmooeKUyuCdfTg5tj+wEY5so9Ngpgz6i0=;
 b=k4hANdWcW82BZ0AS4LL3QcFtm/yAc1puz7iNx7TAF1enTyDYjy7NozfU3fx5ftkmGK6eOULVR2bU3h4pRkB+O68Z98hAyqz94TapaTmdflgTpxGOBYM1TtjW/Mt/p1Q6LbYKm7eAHM1e5MJ29TeHBe4yxeIbQnd2nRLjRpTUuC8=
Received: from BN9PR03CA0072.namprd03.prod.outlook.com (2603:10b6:408:fc::17)
 by IA1PR12MB9531.namprd12.prod.outlook.com (2603:10b6:208:596::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Mon, 23 Jun
 2025 16:15:00 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::65) by BN9PR03CA0072.outlook.office365.com
 (2603:10b6:408:fc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Mon,
 23 Jun 2025 16:15:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 16:15:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:14:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/31] drm/amdgpu: move guilty handling into ring resets
Date: Mon, 23 Jun 2025 12:14:12 -0400
Message-ID: <20250623161438.124020-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623161438.124020-1-alexander.deucher@amd.com>
References: <20250623161438.124020-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|IA1PR12MB9531:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc0583d-bd98-44b1-36df-08ddb2711ae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHIwR3NMUHZMS21IS2dvNDBxUHg3WTF6enZlcG4vSjhSd2FSeHg2cEZFeTJx?=
 =?utf-8?B?cW1Ia0dGTkhMNUhJczZPMHRVNVk5bXpaZXY1OTVsNVJmU3U4UnprZVJEUTZN?=
 =?utf-8?B?dHpjRU80a3VudzJCWFBtWGc0VzR0LzJCU0YyaXNOQWNNdjZYcVJDeWNEeEdh?=
 =?utf-8?B?eUd5NTM5bTlzWkFKZGxSeEdLL2V0bXpCMFB6eFlscURxN2RZb21xVWxxR0RN?=
 =?utf-8?B?NWZiWmt4eGo5dXRVSUtTNksreW5aTyt1MUw0WXh5S0s5UUVUZmxJRjFTY0dy?=
 =?utf-8?B?WEI4NGs2L29TQzBNaGxSckJ0UUsrblZYZ2xJSXk1Wnk0TUlaM2tiL2JlWlRj?=
 =?utf-8?B?aE5iMGNKZG1kdEFCSXYzcmFlZ3YvOFFJendBLzh5RDY5OEpCU3M0dDhOVlRP?=
 =?utf-8?B?Smt1VlpJNE9OVnk0a2E1QytRb3RVeERvbmltTnlsK3VXUm1hN2syaFczU3pw?=
 =?utf-8?B?aWJ0Q0Z2b1k5SklkUG5OTkVaMUFPb3ZMYlhPcC8vRHAveTE3dUsyYlVuVEZM?=
 =?utf-8?B?MGI3N3MzUUhaSngvUTk2bjVTb2Y1Q2hCbmZwTDFybzBFOTBkdnJzdExNWjVG?=
 =?utf-8?B?L0poVktreVZjQnJJMzJDL01GaGZLSC9wckgvT3R2RDRZVkEvNzlVQlVUUHZz?=
 =?utf-8?B?VHY3dVZQRFVlRDhzWGZWM2xVcFNyOFIyVmhub3J2MWZzQzlRbkw0OGM5S2tY?=
 =?utf-8?B?aW5lMC9PVURURzIyZUxRVllCbE0yMVdUZHlJbGtDdmZNUnBhZXlUUGZWOE8v?=
 =?utf-8?B?RUo5a1hsZzAzZDc4cFVkWTdxMjhpL1dmVTc3NXlkV3hnU0IvZk95aVFFckhK?=
 =?utf-8?B?ZWIvK0t1c2pDM3Vjb3NTQys2WFJTbFU5d3M2ZC9HYmwwTWxoamMrbWVyTEkz?=
 =?utf-8?B?SWxFK1NVK2FUS2J4Vnh5QVdwK05sOEtmZDhMUWpnY1pCZEJKWGRhczJoblNG?=
 =?utf-8?B?Tk9hZkRlOTZ6WHVGbmYzOXJ1d0IvNWVIUXY1bjJaYzl0ZTJ3c3M4MWVBcTFG?=
 =?utf-8?B?RXVxT1lRWkZDMHdOZnNCUldWbk1uTHZMZWdIUld3RDZxOWwyekQ0TEdxR0ZN?=
 =?utf-8?B?WWdkZmJURy9GK09sbW43S3BCVVNZZ01SNWVlRDhVM25aZm5VWU4zWEFuc0tE?=
 =?utf-8?B?K2RnQXlKUVhxNU1idXU1OE91U1JGOSswSnRRSmgxUnhhM0x0SHZYUVp2Y0tH?=
 =?utf-8?B?R0QxOEhENlcwWHh3ODhiWThSTVRid2xZdTc4YzhXNWNaV3JKTG00NzNrRzc4?=
 =?utf-8?B?anFTUUo0ZDZSeVhidnVGR2NERk1OL2ttNzMrK25PL2JSOG1NNlhja0ttRVp5?=
 =?utf-8?B?MDZxTkxvSHQvVXVhVElTR2pXeUJvUkkvVWI3alNyaVllM0lqbnRDczFHT3l1?=
 =?utf-8?B?bUdDMm1xVndVQ1BWcHVPZVVITGxVMVlIQUdLcTA2M0pQTnBIRkdrRGhSQldB?=
 =?utf-8?B?bmZjRCttbFdPNU9MdWRHM3l3UFA5NmUveEFUbHV6TElDSjh3Q1RFMFlVLzdo?=
 =?utf-8?B?UmNhYk5aZ0dianVGaUZEb3VaN1VaMVNMRnMrL3ZWbXNFM1ZpZmRZbC9QUitU?=
 =?utf-8?B?eUJEOUo0Sk83bTlOd2FmQjh4Ykc0enhtazlPaFU3Y0t5K1h0VmdnTnNzR05W?=
 =?utf-8?B?cXg2Q2NyVDNmRHphek95K3c5Y003UFdHaFhub0RIVWo1cXkxSVpra0loL3JC?=
 =?utf-8?B?NUt1L3htaVkwTUdoMjFNOHJ3V1orU3lTWUdlUW0reStkaUF2NUgyNUprcU1h?=
 =?utf-8?B?bDJtK3BkTDJjdUcwS3c4czV5VGhZSW5JZTR0VlUwbDg3WW9wcGN2WVgxS1NC?=
 =?utf-8?B?OHlkcDNiRVVUdHJIZnVYRUkyNVREV01aNjlvZ0tZdmZtNkcxcHpaYW0xaFRh?=
 =?utf-8?B?cS9hcUVEVjVJRWNJTXRaMm5BdjcxYjZrQVBoOFdsNThrY1B6QkUrSDhZT0ZC?=
 =?utf-8?B?ajBOOE10YUxTRUpnaHVkN1RDZ24rbmVkMnZGSTR1ZWt6ZkJjWU9mcVFveW1x?=
 =?utf-8?B?ejFxK3plM1U1ZTBQSFMxa2N6TTZobEJoQWN1NXVQajVJckF4bld3SC9rRVFU?=
 =?utf-8?Q?GCr22s?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:15:00.8538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc0583d-bd98-44b1-36df-08ddb2711ae8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9531
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
index d34c20202bd1b..03de4293b9832 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1655,30 +1655,10 @@ static bool sdma_v4_4_2_is_queue_selected(struct amdgpu_device *adev, uint32_t i
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
@@ -1689,13 +1669,7 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
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
@@ -2180,7 +2154,6 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 	.reset = sdma_v4_4_2_reset_queue,
-	.is_guilty = sdma_v4_4_2_ring_is_guilty,
 };
 
 static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
@@ -2213,7 +2186,6 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 	.reset = sdma_v4_4_2_reset_queue,
-	.is_guilty = sdma_v4_4_2_page_ring_is_guilty,
 };
 
 static void sdma_v4_4_2_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.49.0

