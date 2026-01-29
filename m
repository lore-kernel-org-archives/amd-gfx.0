Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09419D73E87
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 20:37:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 903F110E266;
	Thu, 29 Jan 2026 20:37:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O983l4yQ";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012033.outbound.protection.outlook.com [52.101.48.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC33710E07A
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 20:37:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LG782Q2yMjTSg/O1xPlroRdAK8yHFoMVXhAJ/Dr8lbmD2yQ2FMR3tQezcHQVY7VIl7U8RAo8csvSlYcghaZ44eTFeA3tAazda6A8ftOQjicBAxSNT5eTi8RUQ5hUX8qNQwGaCam0RVNkat7Xiz5WmLPR3IcSMuwaiGZVHAFX6dADdQlW2PfUbctI/klhU5OdDcMtg6NufjV+PG4dX3V9nvJWNEINzpEWbtkn1oZuafadfR392idRYYKfZ+SgrbFRarU2e+BCMproi8tGeKXh25fi9R1/YV/HYnR0ZNMnTZbHDgqYZzPs+D8wbfEJvu40+M0KXF4WoIjWq5xjzvUKbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJm0gqhhxSi0F/4RmHL3/m4EDtzI/KjqtdunzjJc1oo=;
 b=ksysSVqgSaFjFw5BOgnTjgwccdoOypVrJn0dbXxlcV4YXQv39pKdBJM0hsTlu1PPRB+yO6AU/95hQ8LNHQGMFhG+i/NMaPByOFB0cwYOYA00y7ETNMtFZY2eJacTEuFnoVXjIURgnk1ZLPbtZIN+AXngviCjDMMhP4dscKn1+ADwm0l4K08/bD6VAO/cjD2gGi2fU0EJauC1aqwwRwUdsyIX37RBGq/qpZOMcwc7h7Ex54zSEvu47JLpVmQtLc/zqpxRLklql3KfUkXDWWKld5mm75mBYDRSEOCkA7hiw6d6IiFfcFLwdGvW7pQSxAQp8eulenJsGSRjTznDUIeg6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJm0gqhhxSi0F/4RmHL3/m4EDtzI/KjqtdunzjJc1oo=;
 b=O983l4yQgdubgFlmGnT/7jhptBvGtkCLPJTJTRn8eYiVubVi0JYzyILoQsnL5YJk1AXgEJppEX+cY46dnCCOTijP3yoqJMgr13lsYjP9FFRR7sRmKDGhpjy4SpDf37IvICrByrX9gLI9LeGJevQiUB1AjSwnHx1BEvGiJ32SeOg=
Received: from CH2PR02CA0018.namprd02.prod.outlook.com (2603:10b6:610:4e::28)
 by CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Thu, 29 Jan
 2026 20:37:40 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:4e:cafe::78) by CH2PR02CA0018.outlook.office365.com
 (2603:10b6:610:4e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Thu,
 29 Jan 2026 20:37:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Thu, 29 Jan 2026 20:37:40 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 29 Jan
 2026 14:37:38 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 29 Jan
 2026 14:37:38 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 29 Jan 2026 12:37:38 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 01/12] drm/amdgpu: re-add the bad job to the pending list for
 ring resets
Date: Thu, 29 Jan 2026 15:37:20 -0500
Message-ID: <20260129203731.21506-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129203731.21506-1-alexander.deucher@amd.com>
References: <20260129203731.21506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|CYYPR12MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: 17190615-e08b-4ccf-ae8b-08de5f763f04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8zKrW6FZPA/3YzDkwXd9mVJZ8rSnPx3sKc+DGfCkp5WeAro73VfcS9ZujzdR?=
 =?us-ascii?Q?h6f9uvkEVwefTim+dLNlkCyD/EnRZ3pKUUp5ZLSSauCMlU8MAMH7e/hs69Uo?=
 =?us-ascii?Q?+nJb2jVyjrX0jD0agXsguwO0zMy9uxs36fpBfakB8aHSAp3ILn/Eppvl7oRr?=
 =?us-ascii?Q?UN3s2pJiIHcmasapcKCO2FOaRDPSFHo/JLe0Gmk37m4j5EitL/tPXgkktkbo?=
 =?us-ascii?Q?jlqkQMSQAPYsPoK8v2K0QTvjlMwbF1kjgScmmzqWyLTaliHx3KeCRWJ3/Y4Q?=
 =?us-ascii?Q?lFS3odkYc8O+bvBe/NXH4XD4Q0Kz+9bge5PxSfkUoMpmN7Pv439FNX6SstYT?=
 =?us-ascii?Q?wtucXfSm46ByQTrPFQh8O9wGZrf+NNGhisKL31Mzfl02oDImkDgp50KU3djV?=
 =?us-ascii?Q?Y4T5nyCCsLm8EyzRxQMoqGERXlv+ulLIWDwTkOYwszvc76w4LiGOP/qf5XG4?=
 =?us-ascii?Q?mYPfqo3Ww7onNp8mL6SqN0cQMyS51wufi19QV+b7orRqPbOLV76QQ8oa3wgk?=
 =?us-ascii?Q?o+rCADZVqDdxIHpoxDV6uy0N8N+qO5eDlQdnPf/KpAY/jJ4pBBsD9z095GyS?=
 =?us-ascii?Q?1HDyHbEXvSorCNUatA06uNwe5v1h2PcDA5ES+NcVBMjcB3SsuAwSSgg5ia/A?=
 =?us-ascii?Q?/0dX1+zhNWhRgW6IG3GHemTtNsWH3eqTiqH7eWXDKHENuKXVGJfwo8xytOKS?=
 =?us-ascii?Q?oicP9N0peSGKEQzLSPqL/4XeYITWaS7pCYIrF7TPqiF6zqFg9bCrKQ5XsM1U?=
 =?us-ascii?Q?2Zm6n+RZIRbY2kAVR+mNDOzg2sBI5y9sGvKhrGVUgXhDIRhknR8Q67brPr9z?=
 =?us-ascii?Q?OBV+vv+mi7KBv9xf5tbWK9dqq6O1t83k8X5+NcGIxKlY6/qDkeDA8fRptHNi?=
 =?us-ascii?Q?lxASOZpDmK/JIbGxWINwCa2rUsnpnAR2lBpRXHP3LPeAc8kL11VVYe7mR9Ta?=
 =?us-ascii?Q?uyiBQPMG8s0rnnzm2xpj7g50E0ItM+mC7leNl9V5en02S6o6M0XabGKYAJ5h?=
 =?us-ascii?Q?J2r5IY3qFXsjEaNNV4lDDJuJ9f61NuSeNqtgA3wUJL+Ia1po6GDOXHx5lUY1?=
 =?us-ascii?Q?vTA4uOwzEzmQVWmxD2QP4Yuqds0QyoiHH+k3oFTHOU5sBxvyBKgrnQhtjkdu?=
 =?us-ascii?Q?awKyTxPXkj9RhUhhvtpR9wsnjZauRUmb6DDGpUc+MWwLl/dep92epky2hNb1?=
 =?us-ascii?Q?YBiJyZVlQn/x80VG44EGXgTMNTwtm4IKbwQQSOnvZPMy/MxB24+K7I9JCiip?=
 =?us-ascii?Q?M56fI5QRY+B1A9v3CWZae9yxtFXqCrmeiyBJ+JrFx06dnzsgZo6N6uxlQAdj?=
 =?us-ascii?Q?+dEBex9/Hsu06J7Gfe3ZnuUBI4AKLUuR5i/BU1gOjxu0ZoRHXThHqwQRTnkt?=
 =?us-ascii?Q?eHSU1sLqxuuSNW6SZDhTDdh4JMuqwKKMdHsqGJpmAS+B7YmpFCHoXPkhumMB?=
 =?us-ascii?Q?N3fzcQA/HgQq8KqIECvJgplfwFLx3z0fl3qu60nhVPy+ColpoG8Xl+xlMqKj?=
 =?us-ascii?Q?ZIOJLVrCXHYGxycmi6Y0YDaaW4by5U9TfBcI1ZHA5KeSxPhhuN5g7RSRRH0+?=
 =?us-ascii?Q?nGKWsX4RHn2AsEspi1hJ1mvjlo8QjwLCMP21LYagCji1WOJ0wH2bIU+fIMtq?=
 =?us-ascii?Q?4VraXGba60cBV9Ezh5MVtG2fwsOudvpmRkb6ddfg0LGJlXQ17HLyu0VR89r/?=
 =?us-ascii?Q?1BiEIA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F5qLMkfSxp5Iu3EFEUXPcUiecQxYZBk69wlIIual3QUQVYhti0Po6i+krwGp8xDIHQk5hQjv4GGy+E0BqSCzr4pok4IfqQ5t5y5/Cx9/AnofjqaMxPOeSqAVixMNIQvXXomaEi58Me9l7J/VSdzGniaVpcJ1zw8B5M+j9q5v05znSyh4i/I4BZkXOsT3wt7IHnLioQibMzF99YgpwlkolOo6IMtLh/WfoxXrHpneYMusG6WOIJdGAtf1nqbs7bVNg27jHN8mzGb9Tr7RomQYDG1d/5kCkMipSkqmFMBaRwUBAP7w0rgappV1S+FcbTGzNREh9wkauU/xhxOAvgVSzXXQzPHYwAccp03BUpMIcEyF6IAG+QRM/8xGU4loPQhQ3lc6iTSW5Yk1kbrOlNQfa4lykEsNkO7LXRrgqjtRa8WPc5f2YFTMdc/Ia09wuypJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 20:37:40.0697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17190615-e08b-4ccf-ae8b-08de5f763f04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8750
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

Need to re-add the bad job to the pending list before we
restart the scheduler.

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 4 ----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index aaf5477fcd7ac..9b10470321be3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -135,8 +135,14 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	    ring->funcs->reset) {
 		dev_err(adev->dev, "Starting %s ring reset\n",
 			s_job->sched->name);
+		/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
+		drm_sched_wqueue_stop(&ring->sched);
 		r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
 		if (!r) {
+			/* add the job back to the pending list */
+			list_add(&s_job->list, &s_job->sched->pending_list);
+			/* Start the scheduler again */
+			drm_sched_wqueue_start(&ring->sched);
 			atomic_inc(&ring->adev->gpu_reset_counter);
 			dev_err(adev->dev, "Ring %s reset succeeded\n",
 				ring->sched.name);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index b82357c657237..129ad51386535 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -868,8 +868,6 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
 void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 				    struct amdgpu_fence *guilty_fence)
 {
-	/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
-	drm_sched_wqueue_stop(&ring->sched);
 	/* back up the non-guilty commands */
 	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
 }
@@ -895,8 +893,6 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 			amdgpu_ring_write(ring, ring->ring_backup[i]);
 		amdgpu_ring_commit(ring);
 	}
-	/* Start the scheduler again */
-	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
-- 
2.52.0

