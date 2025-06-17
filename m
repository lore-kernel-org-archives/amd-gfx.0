Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FD8C7115F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:08:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AB4910E48B;
	Tue, 17 Jun 2025 03:08:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r0p5Pqh7";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C54A10E480
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmntE2WtPhBDZ2nfAuA8fENi5iDoHCL8TjjsLSGCRlqBhqKRPVZRQs7mZIt8jPmnpgoJL/T/btrzklIC2T6FUQrtvZrGteZJOyo6ORafVrxnBieltVrb6ntaPRInJSf7jvYHAnYAY6HF0XTRIu9fNpKnklHXtPOfXzSTL7/Ev2uiL9ENBx3cLPKQQefo/JLTkt0Hr9DieDqanrzbPQ3Y81HKSiWf0uSsPYqtKBYWW5kavot/usNZrC45KuecEQRTek6lOyMf3cayDKeGEIMkCnx28mAeWEgbNwQSyx+e0/Zsy45Wm3fXYAHG6xksWBV23uHOjTx7kRmvY/MyPvg93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyqB4eUbNOA/pYp4g+0l1eGAqH49pUxGq0Y3Jahgavw=;
 b=AvvrleRsocKp3XQ3pb3e08nmH2hTv3JdFaHHBPiM6dctKnRuCsQ1ho4Vf+/s1gp92EqCLytAkZaDYNg2Gl752x5IfMI2UJRFgvou8upEMBJdwKiQRrjGZRS/miDPruomex9LIjOcGDfNWQBPQ69wikWeyCZHIPCf8NMa0kzl0i+5povDu6B4qTDD2CMMQBRlZcWWDzCQPNlrIec2NLkQsKDODYF+WPlhzsqPkdzPe0/26rx5QgVXLnWMCUYXeis9NLjiRF9pPqu8z99cAaKmvjksrnMLHSjB2HCGWntt7Q76py2IQwhHxrICAwhHvt3niTXREHh+mcbLPAA19HEjQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyqB4eUbNOA/pYp4g+0l1eGAqH49pUxGq0Y3Jahgavw=;
 b=r0p5Pqh7tucy3bcSnwpVAQzKzsczp8j2LK3CBargonE7d6X30r5XrdWvk1La6cFVgMzUq7ZDWa6aB7gGwn09t6Qoj+3JYcjvrWuLgxPgjXhI5ohqbrfZ5uV0z7xQ14VQt+ETZAJqMN1Z+Nw36SACxv8ExLZHBIKZ62sCFtaFDEw=
Received: from MW4PR03CA0020.namprd03.prod.outlook.com (2603:10b6:303:8f::25)
 by DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Tue, 17 Jun
 2025 03:08:40 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::6) by MW4PR03CA0020.outlook.office365.com
 (2603:10b6:303:8f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 17 Jun 2025 03:08:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/36] drm/amdgpu: rework queue reset scheduler interaction
Date: Mon, 16 Jun 2025 23:07:48 -0400
Message-ID: <20250617030815.5785-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|DM4PR12MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: 7449128e-48b5-4023-eefc-08ddad4c4268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWtpSXYza2lFTk8yZGs0MFpiSElvc2hpQU1iVDV0OW9jc3liQVJUYytSOFFY?=
 =?utf-8?B?ck8rQzZGVUhDb1BMU28wNWN6Y2IxY2lnS1pjUURzVDBKaWkxa0tMK0xDWTl0?=
 =?utf-8?B?RkdiTDJNdHV6OG5lb1BOMnMvenBJaThHQ0Q2UkhxdU11TmJLZ2RwRDdyR3hV?=
 =?utf-8?B?ZEwzV0RJclhOWHhwMldoUUVZd2prTFQ4a2lhYkh3ZFZhY3F5amN5TmtFRkpp?=
 =?utf-8?B?R0Fac1BJcUNXTFVRejlySG5BWVp0bzB3L0dZQ1BvdU9idzNub3Q5QUZzMjNl?=
 =?utf-8?B?OEFXeTBJWGl3ek1DMHJnWHFVYUNIQ0FxeE9ReGl4VVFUWSt1S1R4Z1ptT3Y4?=
 =?utf-8?B?d20xZ3V4WHVyMURFc3BrbVkyWVR6RFczeDJtUlVyNnMySDRnU0N5QUpnVDVJ?=
 =?utf-8?B?Sm1LL2FSNXFlK081UmdtZmhiZDVicjdvM2taek9oMUJhZS9GbVBnQWhzenNj?=
 =?utf-8?B?bkVjalQwZ2JWTHByQU5SU0R0NGwyR25LUm8xaWtjYzA4WEE5N3FFZHZzdUJ4?=
 =?utf-8?B?Q05KYVI1QnVocHhGTTlhS0VmT2dXMjdya1Z3RDhXUG1NcEluS0F4WHFleEt4?=
 =?utf-8?B?anRBaEU1L3g1NnVGQk84Z0lmTGt1aXk4TUJSaVYzKzdZWnVlTEtqWUdhMmsv?=
 =?utf-8?B?NzlWV05rcHlDUm5xNDluNCtNd2loaTg2Ukkzck9OUWRUUXJYVjJtT0J5dXcv?=
 =?utf-8?B?eEpSdCs1OWRHb005K3JrMUgrQjdsUTlFZlF1VWRleVowd2RaNkEzb29QV2t1?=
 =?utf-8?B?U3NLYVUyd3F0WWxkUlZNQUZUSHlFKy9KUEp4YkpQQ2VYZVV4d2phQUJPUnFo?=
 =?utf-8?B?cmZCaWVUNmt2K3VGZ3hzV1J4NHlzZUg5YTRxREFCbUpZYzQyUklhZ0Y0RXZt?=
 =?utf-8?B?VTZNRVgxOFpxd3VXamJEd3oxOWNQN2pHNE5uTmlSaUpOMkh3R0dwQU5DK2hX?=
 =?utf-8?B?d2tUa0wzb2w0eEFlSW4yREs5NDdYekJFdkcyV0RoSC9waDZ4Rm9FWWlLcHBR?=
 =?utf-8?B?RUloVDZQRFVqd1MxK1VSSDBwMWtxaUt2YkwyL2hYYkVSYTJzWUhqNnE1K2Yv?=
 =?utf-8?B?bWlOR2d5OFc3RVR1YXBGaUJUL0FjdzlXbHRTZ3B4MUxhbXBlZm8zeHUxdU12?=
 =?utf-8?B?UWpJckdFRTVmRUZSMFJ0VmppZ1R0WjdyK2dsZmZzMXFlbzNndlhWYnUveXFm?=
 =?utf-8?B?L1ZIaHFLeVVZamVGcFRuMHBMd0wyaG9ZMDhEK3BqdEFBSVRKaVlWUXpzdFd6?=
 =?utf-8?B?RmQ2T1hwV3UxQTNPWnk1azNtOHR4L2x6NGxPeE80RkdERnRCVzVBdlR0K3lt?=
 =?utf-8?B?RWxYL0ZsVjlQRFI2VW9MU0dYTWxmazBlc0lYYjdKdWZ3bUpCVzcxV3E3V05Q?=
 =?utf-8?B?cTZtYXMzRGhCSUJ5NjVvWHdXVmoydmhRbURtNWxFdlJVU2JIdW9YQjQrbkxt?=
 =?utf-8?B?cGsrc3ovL3dadjFKUk1pcDFMaUs4VzBjbUhFWmxXWXorV2xHdFErakQ1WEk2?=
 =?utf-8?B?SDlOMTJxM2hrRHUyait2cTRmSEx2UFRjZk5EUm5YbjRTai9XY2xxdE9VdUts?=
 =?utf-8?B?UjdXd2Q3a3VpZHlzU1BMa1o1eWJ4dTh1VWlOTTZPNGtJbTYzRzQySzdDVDN1?=
 =?utf-8?B?dXNWbGU3R3M1Z3NEazhxNkJqdGEvOHZ2NzAvRXBqbEtSQjlOSUZqQnN3eGVS?=
 =?utf-8?B?elB2bFM5dktZU0p3WmpRR1lycE94YUhZVm8yWWVJd3Z5cWdWM0RKOWxuNmJ2?=
 =?utf-8?B?cy9uN052eVMrREFzdmdVa0d1K3hYQmZGcCs4Ym0rOGMvZGtwMjBwNmZyUldz?=
 =?utf-8?B?Y2xNRFF4a2E1cXdvMXhDRTBvaHNhNGpuTzlhbVM3cTJwbHFpWTFWRFd4SFJo?=
 =?utf-8?B?Nzh5WEZwLzRVYkJ2Yk41WEpwZUdYS3hXTjJGZXd1WHRFM0VUWDlMdmpuREpw?=
 =?utf-8?B?L2d0TCtFVGI1V25JeDV1cmFLT2ljc2pzdnNFWVBoWGxSSS9qamNuZDUrdnpJ?=
 =?utf-8?B?em9YZGl0RFNid1dPRVRBODYzWFczZ0hEWDk4RmZKRDBRWklOTUVQM085NG9w?=
 =?utf-8?Q?rYlOf5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:39.8427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7449128e-48b5-4023-eefc-08ddad4c4268
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746
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
2.49.0

