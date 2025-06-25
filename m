Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03784C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:07:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9C1510E804;
	Wed, 25 Jun 2025 21:07:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JriAU0Ta";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AC6310E260
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:07:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/GZdqLEi1peSrYErzfSv995VbtIVmA+IiX5Ijeg5VHLYJNAPOgB3uU/0tJyNFuP3Qb05aXVGsVd6u4GXCK3ZvKcbST2OPpWI945gFvOrETMSPGmU+vFymgah6ZnU+tjRm4VKcQizeUy9uEKU0lrAFzglqO1qMpdUGhKZHrEM2MLUi1IRhDhpdOstPhVIHkAYL5I6opHcdUDmfGLCq+38ubNxgYg86Azp3PQl5X7J7/B9aOzQ0JKHTXe2nfSuwsnCIi6CG0r0wg5LNs60BGpqWeqsUYucqEYh3fx1Pq8xehr8ZbIvI5t5j4AgNNwpIi0hgaNMaW9JQ3pQUdhcoDibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRjo71yZzFNiXBBpmxfif7MIgF1lq1xUEeKXpX11NhE=;
 b=Z9dlI2M00rKeY9yp95/mOSXl2DJZMYdfS0jM2/ydmYtUb4hFjJmK9dBPlQQQ76AKSuItvPcAKgojL7yOHoW8rEbK3dIWni14yy7Lo3/S26fAoWB/e1B+PUI+IzlWjs0NFWvm0TMWnQ0q5fBFb5qtK8zB419SSq/j44KQVv9aajzCkOBnIHw7M1ofcN76eLCVZDxdgknF1T5/FHsw9yG5mCSEYVv6d5oWYuZ11ghRnTP4H1XMs0pMtLgHqefhWJq5Nw/6muFSHExuiZB1ER5NkSPPSLq7TKOphv3pEJ22BmQaYn9VqwaurQvFPHkHzRigLkG4cHy0JZ70yFSOtp9g8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRjo71yZzFNiXBBpmxfif7MIgF1lq1xUEeKXpX11NhE=;
 b=JriAU0TamK58j5mRNyxQ597GTTrIqjQNP2GnNnJUmjqLE9py72jgxp2WYPsAonCiH2NCXE7H2oMlfY9uzhAz5mP98Enzn1pwQ/Z1KJNL5q9g2JkhyRdnMVtzi5dARZxZQdt4R/3g1UMS67iOQ3FFCMxgdSqAinNv2rl/CRaHRN8=
Received: from BYAPR01CA0001.prod.exchangelabs.com (2603:10b6:a02:80::14) by
 IA0PR12MB9047.namprd12.prod.outlook.com (2603:10b6:208:402::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.30; Wed, 25 Jun 2025 21:06:57 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a02:80:cafe::ba) by BYAPR01CA0001.outlook.office365.com
 (2603:10b6:a02:80::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 21:06:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:06:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:06:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/30] drm/amdgpu: rework queue reset scheduler interaction
Date: Wed, 25 Jun 2025 17:06:11 -0400
Message-ID: <20250625210638.422479-4-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|IA0PR12MB9047:EE_
X-MS-Office365-Filtering-Correlation-Id: 687a3682-14ee-44b5-0fa8-08ddb42c37da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFU1UFFsa29NUHY0TkZUWUNCbGZHaTdEL2M2S2dHRlNrVmViMXcyWDdEMjZ2?=
 =?utf-8?B?MkR3ODQ1a0pRRzVTVlZTeStGSTl6QzB2Snl2VnZBUVA1WHBUS3RNUUl6VkRz?=
 =?utf-8?B?YnMxK25Hc3BmeVBtRElGT21tSUxhSnZ6RTJnQVAzTFFIcFA4MzFXTDVSVU8y?=
 =?utf-8?B?NnRQb1pqUmFqUjNHUWhXLyt3RDdyaStoTDJiRC94VVhLL09Vb0tiMGx2bDVP?=
 =?utf-8?B?NkYyeWx4QkZBa28xaVYweXVta0Z4SHNVbjZ0MWNzcS9LaW8yZ3J6eWRKQlli?=
 =?utf-8?B?dHRDcUUrTEt4eEhVZ1BuYi96OHBia0psenZZUVMrZkNwOGxGVDNoY0pPcEZq?=
 =?utf-8?B?MVBjY2JsUTZ5cTVIaEw4RDB6bEtUYTZST2JlWE5ucCszS0w0a3hWYld1K2Jt?=
 =?utf-8?B?bkZmZVh2d0MrM2oySkE1TlVWc2hFUDB6MXN2NW0vZlJVazlaOENBYTZicmZK?=
 =?utf-8?B?MlAyM3phL0pTbHFLWXV6ZzA3T3NKclozTXhaWTJoc0NEc3J0NFNsNVZBVUE5?=
 =?utf-8?B?emRuWXJLWHA1R25EMVM5NFNjSVpJcE5za0IvUEo5aXZkTGpXY2E4NlV4NWY5?=
 =?utf-8?B?dFR2ZEdXdmhYMkVpMExTTkVKTGxXWm56dEhTNXVxWFUyNzFpYmdvS3NxV3pn?=
 =?utf-8?B?SlNCZDFLMENrakVRMCtQVHZhbWNzQzU5Z2ltNHZVeEV5WjNKbkVqL2Jpb1Vm?=
 =?utf-8?B?RCs5NjBYcVpMWHpFbHp5eHFQVFdmbUYzUmtVRkQycEZXVVpRYllVSlpJM2NW?=
 =?utf-8?B?WGtFMFhXZXdhUDBHUXR6SDBUR0s1TVA4c1A4Q1A2Y3VrMHJUOTVWMlJnSUV3?=
 =?utf-8?B?OHpiR2R5dFhVbWxKam1OMXNhYzV3VG5KVjk5a085aVFDQkpwUzZpMDFBSWxz?=
 =?utf-8?B?RnYvMHRyc3JYOVA2c3Q2WE1GcXdtb0xKRGZsREIxZEFrZ1MrRVR2TEd2MlFv?=
 =?utf-8?B?clhmc3kwUnV0QURwcnJBZ3JsV2NNK2NNSnRjdlVMVVpGRDNJM2wxVDFFYVA0?=
 =?utf-8?B?SDhzQkJEVnRmU1kwTGRYMDAvS3RoUFZNdkVhOEpoRFYzZzVnUzhCank5MzRX?=
 =?utf-8?B?RXYraWQyaTM5cy90K2ptUDdQWWFpcElRY1VnRXZYQkxMV0NDMEswR2N4cFpS?=
 =?utf-8?B?TlhlWXlUZHN3Z1Z4OHdIcTZveDErdDdBT3YvOFJPS0RBVG01UWtDcXVUU25J?=
 =?utf-8?B?Z0VsYnpWeUR6WHR0dGhTNVM1ejl2SWtNMHF4c1BSaTJDMzFlbkhybEhsdmtS?=
 =?utf-8?B?SlVWNXJwZGpEbGgwbnd3Y2RuV3o1MnVobkV2WlZCQS9XKzF3b1ZId3NYVmlj?=
 =?utf-8?B?Qy9yZ2licThhcmFBV01yZ1NLSklHaE5rcDIybElGcVlCT3pIMENyZllEYXRs?=
 =?utf-8?B?MUNRdHoyMUZGS3NsVjlRYkMrSXFlakNYakpiamp4WlJ5dWdZSy9JNkhsWUpY?=
 =?utf-8?B?bysvVEZhb0NHRGFOVmM0aXFhOERwcUc5V2oyR0FmKzVvNXF0TnZnamhPcjB2?=
 =?utf-8?B?S2FycGJIc1crSmJOek9TZ2p6ZmVPOTN2UVNSa01nVzByV1pYc01INzdONjFT?=
 =?utf-8?B?RnRFYklHMldrVVpBVmg3Y29hei9xQmtRVXFna0FiZG5qcWFGT01IS3BPcUNp?=
 =?utf-8?B?a2JWWWptNGFTQVB6cGM2bVV5WUlPMzRSaWxlenlhNzNmZEhBZitXYWlrb2pz?=
 =?utf-8?B?U05IWTdSN3Awelp2dlFOdTdkUTJscFN2MkpvMXBDT0NBdVAyY3lvYkN6UWk0?=
 =?utf-8?B?WlhvWWR4MHRoSms3THNGZlM5MmMyWTlybEVvR2pGTG1OVCtVMC9oTGRjdkdx?=
 =?utf-8?B?U0RCSkZoeitMRlp3cmQ5eFZTd1RjaVdoK2VtM2QyY3hROGxjVG1CemR4UVY4?=
 =?utf-8?B?dkpTaXBsL0Z0MjJPNTVPN2NGSFdOR0M1OVYvUzBkVHIzSkVhUGxZaUFodDVa?=
 =?utf-8?B?dUEwRElyM0VsQVdHZDI3dlFKb2NSNVBjVCtoaUc1b3did2U1SHJscjh6ZkZ5?=
 =?utf-8?B?RVU3U0VVcC9xSUdic2lPdnlhWHF5ZklDMmd0eDVXVmVjL0M2RXB6M1NabXAr?=
 =?utf-8?Q?pHrgZ1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:06:56.3731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 687a3682-14ee-44b5-0fa8-08ddb42c37da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9047
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

From: Christian König <ckoenig.leichtzumerken@gmail.com>

Stopping the scheduler for queue reset is generally a good idea because
it prevents any worker from touching the ring buffer.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 35 ++++++++++++++-----------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index a7ff1fa4c778e..93413be59e08f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -91,8 +91,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	struct amdgpu_job *job = to_amdgpu_job(s_job);
 	struct amdgpu_task_info *ti;
 	struct amdgpu_device *adev = ring->adev;
-	int idx;
-	int r;
+	bool set_error = false;
+	int idx, r;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
 		dev_info(adev->dev, "%s - device unplugged skipping recovery on scheduler:%s",
@@ -136,10 +136,12 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	} else if (amdgpu_gpu_recovery && ring->funcs->reset) {
 		bool is_guilty;
 
-		dev_err(adev->dev, "Starting %s ring reset\n", s_job->sched->name);
-		/* stop the scheduler, but don't mess with the
-		 * bad job yet because if ring reset fails
-		 * we'll fall back to full GPU reset.
+		dev_err(adev->dev, "Starting %s ring reset\n",
+			s_job->sched->name);
+
+		/*
+		 * Stop the scheduler to prevent anybody else from touching the
+		 * ring buffer.
 		 */
 		drm_sched_wqueue_stop(&ring->sched);
 
@@ -152,26 +154,29 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		else
 			is_guilty = true;
 
-		if (is_guilty)
+		if (is_guilty) {
 			dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
+			set_error = true;
+		}
 
 		r = amdgpu_ring_reset(ring, job->vmid, NULL);
 		if (!r) {
-			if (amdgpu_ring_sched_ready(ring))
-				drm_sched_stop(&ring->sched, s_job);
 			if (is_guilty) {
 				atomic_inc(&ring->adev->gpu_reset_counter);
 				amdgpu_fence_driver_force_completion(ring);
 			}
-			if (amdgpu_ring_sched_ready(ring))
-				drm_sched_start(&ring->sched, 0);
-			dev_err(adev->dev, "Ring %s reset succeeded\n", ring->sched.name);
-			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
+			drm_sched_wqueue_start(&ring->sched);
+			dev_err(adev->dev, "Ring %s reset succeeded\n",
+				ring->sched.name);
+			drm_dev_wedged_event(adev_to_drm(adev),
+					     DRM_WEDGE_RECOVERY_NONE);
 			goto exit;
 		}
-		dev_err(adev->dev, "Ring %s reset failure\n", ring->sched.name);
+		dev_err(adev->dev, "Ring %s reset failed\n", ring->sched.name);
 	}
-	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
+
+	if (!set_error)
+		dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 
 	if (amdgpu_device_should_recover_gpu(ring->adev)) {
 		struct amdgpu_reset_context reset_context;
-- 
2.50.0

