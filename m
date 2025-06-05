Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65912C67861
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA5FA10E87D;
	Thu,  5 Jun 2025 01:46:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bBS1QXg2";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EADD910E87D
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekTtduHlKzG7L3fYNvmHzGum8xKjv7Bs9tw2ll//znaj8m+DWDrvTk+uT0ceEyiaM4v6MyTQJ68Zf/iwkErU6mtiiN7J5x4ToBDRth4Eb49laOFWEa1DwFOSHerqjnqMUbhMoBaAbukqmUK1rFBepxWX0xjs8XLRCpgxRDtFzZFWS7iZWHYwJnRCOFPz7A+FvqtWZwvvR6/Jqi3TS9grN/gn9W6A2HqbL/0iOvqzQgC7BPNTq61OncE8Kg5aQxjnmbC0uX2YEnf4rSmdRCNK+KdVx5cF++jncU8XXTBOu25kJa9vGt/IR/kx+j2HdFlr263YFL4WsIbsKPckbJeWwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NARKpbyNx8bO6+j6rC+azDWHC3EOMUeDnz4EgzOWRnc=;
 b=WhIjEmVad9SQesrx3MrA628dm+fyh+wzozz63hA0U5VT/anSjY+S2f+CXTo31zek092Rj/u2V9v+xg6G9CmscE09CQ8etC/x2ZvHt3VMjmd0evJjVEKFq/4vtActXQI2uBp2Qbss7mekemYv64zE9EHKsQHt+ICm0tnMRAQ9Q/PvICtJg48cPf6Vo84tQf12J94ElBibplb/RqaV8Z6khQ1Cjaz4lpCGVkRR4Qz+egfK3917AuPT2mu0r7Sz3OZmontZElonkcIUjcKFHM6z7OiR/J69gh0tqi6Lj4FdJlUOkUzIirFmqDjxiHd40i0JyDMAvd/An5c5gIW1egirig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NARKpbyNx8bO6+j6rC+azDWHC3EOMUeDnz4EgzOWRnc=;
 b=bBS1QXg2fSuorXWvt0l0Aq8r+qegN76CtFWxNTeZR2V2W4VLyhF7pXA1Qv7a+45p/aabDQJ6EgXnzACc8Eot77+uEFvE0G/XFCjYL8RJCrnWnEFMMuE9e/0N2rX1mEzmwyZFXgupUPC0zZsFENUoz43lDgMYKpqG9xZaY5EiX6E=
Received: from SJ0PR03CA0136.namprd03.prod.outlook.com (2603:10b6:a03:33c::21)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Thu, 5 Jun
 2025 01:46:25 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::ad) by SJ0PR03CA0136.outlook.office365.com
 (2603:10b6:a03:33c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.33 via Frontend Transport; Thu,
 5 Jun 2025 01:46:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/31] drm/amdgpu: rework queue reset scheduler interaction
Date: Wed, 4 Jun 2025 21:45:36 -0400
Message-ID: <20250605014602.5915-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605014602.5915-1-alexander.deucher@amd.com>
References: <20250605014602.5915-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|IA0PR12MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: e91c84ba-0cb0-4ee4-6121-08dda3d2c7f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eW53VmlTTEtFVmFrYTB6UmZuZUI1UFhGbUZDY3BWWWl5eWFuTmltR1ZtQk4x?=
 =?utf-8?B?VGJubDFQWEpEcWRWTEZiNDJldWF2ME9GQmF0enE5bWg3SFVtMFpSdWhEY0dE?=
 =?utf-8?B?U2dpRTk0YUptNVdkK2grT0JDWnRyNWNWT280WU9rVHFuS1ZmcmJrQVhwZ05K?=
 =?utf-8?B?UWxLV3U1OEpoaldRQ1FkOGhpbU9iNVJFK3VYN0ZtUmJiUE5yS1RGOFhUTkEx?=
 =?utf-8?B?K0dQN2RYUnMzME9vdlF3bGZVcGhMZWdTV0k4UmRsOEdRajlxQmFYWnpPM3Vk?=
 =?utf-8?B?NTk4N2haU2ZuTE9UeFBJUlFwYVh2engrUzBBbzI3VHBiUzc3ellPZVZBMElG?=
 =?utf-8?B?Q1FwUElZUkZHUU5WU2lRaXVmSVdNNEMzMVArNWhkNXJvazdQcUcwMEhnQzVm?=
 =?utf-8?B?YUtIcjFaUXZrZDZCcUxlUDdKcGNwYVNQRmhrSDZWTVdFVWdKTk0rVWp4V3FO?=
 =?utf-8?B?QWhrSmdvNmgyNTNncTBlVllaRzB2R1U5Q09URkh0MElxMmFIV1FVQWRzWFVi?=
 =?utf-8?B?cTBjS0tpeTd6ZVd5djdsK1RIM3VZcEY4OEdPeTNEbWtyVGZBUHE2SGZRVG45?=
 =?utf-8?B?QVBZcVZkVDlIZTdQOWd0cDBqVHQ3RWx3d3lTTlRMMU9yTDZtU2g0SkY5QlVC?=
 =?utf-8?B?NCtJakpnMWJqVWQzc1dYVmNzUUF1ODVVTTF4bUJaU0ZkNUJsVGZ4Nm9icHZ6?=
 =?utf-8?B?K05PM1V0OVowSDhEN0dtTkhoZ1dXK1lpd1JGNEFWWjdwbmdDSTMwMkptQ0tZ?=
 =?utf-8?B?RE0xVUZ4Q0JMQ2dKYmxvNC9UMmo0L05pemZ6K3BVVWR1eDRuMVdXa1hxQ21E?=
 =?utf-8?B?VTd1UG4rNmdydXFOSWFuTCtUYU00b00zWnBzSW5kVGRyYlRvS3lEeFpmS1FZ?=
 =?utf-8?B?MUFHYnlwZmo5R2p5UWhTblBsbGhlTUhqL2FoV1MwTUlqT0RuUG1sRGgyYzlY?=
 =?utf-8?B?cWk5QUpoUXFRSzFkdkU2aG42UVVRLy8yOGViU0wyTkJrUEJoYTQ1dmxYWWs5?=
 =?utf-8?B?SkFwTkkyeHc5VWRIaXlBNThPZDBieVJlcVJNcTBwNlFjNjdDdm9KNnhXaG5H?=
 =?utf-8?B?NGtQcmEzeWI0YjNLZEIyVHRVaGZnYmpZQU9iK05udi9Cd2lCa1I5aGJLbmFr?=
 =?utf-8?B?dUZlbnBqaFJaM21UQlJ2NTIwd2FKSmMyQTQ4eU00eWk4cE9Eallsa3lNWHIx?=
 =?utf-8?B?UnNxMmt0TjRHUDh2eGJKUjloalpRSXJ0eGJSNVhScWVGQTlDSFU1TGVPVlQ2?=
 =?utf-8?B?ajFLSTNSVUY0SHFYTDZGVGgzOGlYVWoxTDl3dzZOMm1FYU9uVVRyUWVSSndQ?=
 =?utf-8?B?dTh2L1VsazFqdWRNc2U5S091OFVrZjQ1OTFqOGNMMXgyVTZJeDV0bXhMWWpl?=
 =?utf-8?B?QWtxT0p4RUYyS2hRMG5XZXVNbW15bm1sVUw3aFBHVlYzY0s1MHZvODlNSm9p?=
 =?utf-8?B?UEhmQitJd2xESU5aUm9QSSsvSWxjdlhwaHZRemNGNlN4bFY4WG1aSkcrMHhW?=
 =?utf-8?B?YmQvcDNvNEp0NFQ5Vmt4c2VCR2tYZW5FTEZ3aCtRS1BzQUQwMkV4SnhUcmhs?=
 =?utf-8?B?L0o4RTZWbTRobmtod0dobFk0bWQ5aC9wOFVtUnRQdzduSE53cGFsS3I4MDZr?=
 =?utf-8?B?cDRPdHdxd1F6em9xQnpoeUdJem1rOFMySkJOcWhLTVhSc2NROXhrOGxGUGQ4?=
 =?utf-8?B?MEZKMFA3ZTI0SGI3U3R0aFRRRVRiZy9SUitLdlBSdGxSVE5WWmFwL01jQTR2?=
 =?utf-8?B?cUtzWFRMLzVnVkZXSmxFMFBmV3FWNjlYNmswVlZPSnNpZFF6eDg3M2NSemp0?=
 =?utf-8?B?MU9pSW1aZG9MOEZicTFZSTQrSWU2NzBZekRVRFhUbXcwc1NDdFdzSXlmUXd2?=
 =?utf-8?B?N01OTFNqM0hjamV1T2lIcHhDck5aay9lcXZrbUk4QVhSOHNqMXZoSks2c2lO?=
 =?utf-8?B?U3NVbXRiNGRscHhETXdIQWtUMzFSeHJRMlAxUGloa04yMW83SmtxUlpaNTRq?=
 =?utf-8?B?N01lQUwwTkJIYlBkZkZTd042dmxaenVqWTNYbGFLaW4zTFo1cGJlbUdzcXE3?=
 =?utf-8?Q?CGENVT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:24.9081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e91c84ba-0cb0-4ee4-6121-08dda3d2c7f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352
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

But using amdgpu_fence_driver_force_completion() before restarting it was
a really bad idea because it marked fences as failed while the work was
potentially still running.

Stop doing that and cleanup the comment a bit.

v2: keep amdgpu_fence_driver_force_completion() for non-gfx rings
v3: drop amdgpu_fence_driver_force_completion() for compute ring
v4: avoid a warning when setting an error on the fence

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 37 +++++++++++++++----------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index ddb9d3269357c..821f88b64f3f6 100644
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
 
@@ -154,24 +156,29 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 
 		if (is_guilty)
 			dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
+			set_error = true;
+		}
 
 		r = amdgpu_ring_reset(ring, job->vmid);
 		if (!r) {
-			if (amdgpu_ring_sched_ready(ring))
-				drm_sched_stop(&ring->sched, s_job);
 			if (is_guilty) {
 				atomic_inc(&ring->adev->gpu_reset_counter);
-				amdgpu_fence_driver_force_completion(ring);
+				if ((ring->funcs->type != AMDGPU_RING_TYPE_GFX) &&
+				    (ring->funcs->type != AMDGPU_RING_TYPE_COMPUTE))
+					amdgpu_fence_driver_force_completion(ring);
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

