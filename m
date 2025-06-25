Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D55C7EE32
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFD4010E806;
	Wed, 25 Jun 2025 21:07:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y4MjvWZ9";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CD7610E260
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:07:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSLza7gje4jRHiAdjg17DYHaYRfZGSEatKzEZJ/7MitJne1J4hTHlS8QX5opYTzJtlgHCxtMFkVaRL7UAvt5mlUR9tmCxXuWHFtBmr0wOmexYGC2RA+6PHnvQ2MI1j0pdTrtrHdvPG+FFn3Qab4A2+fNcov9ciULJArAuFEkKr3Oc5AAqBdO6gLp4GveVyJ3qkXH74/T+vVaKdLKQPQJrqDtZNbt2nciqxIhTgt+B7pObAAGfaqOqMmKkMJI0+4FVbBfwog4+qpDmmiXtHMpNYNRYkAFqB918iF4zf13mjEZ88KUxQdKzwv/Hd6ZYIrtEABQl8n2SPE6e11B/425QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzpC9LzmHcsLPuAgsTLIojQS53EcE2VyjWqtZhFDcYc=;
 b=KNbAGFDMvXD/EFJYQIqzXJeueKw7Q6bLb04RBF/YTkGi9byStnFP6L1g5EfLtDv1q7LwHAY2QYnb0oWzk+pF0p8IbUJIbHPD0p5+nMaByh4iIUejLZE40zy5/IjEWbl193WogJMIJRaXeFMeBUGvA02faBtDtk6tKaSnLo+/DJIZfkJNrcJwT9lNNA6SgC41+abQ39vxC1uErxfGK0JkTMNoJSMZXT0MClksszBYnzXml53L663VYTPapopQrnd6rmoEDK8PalMvWoAQpT0E2KisuEcGIz9LkGrg06dH62wUOE9TGP4y5wT/ZAeomNf2Ea+Mvh8FK3RTkv2KnOUQ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzpC9LzmHcsLPuAgsTLIojQS53EcE2VyjWqtZhFDcYc=;
 b=Y4MjvWZ9S4ARIa+M/u34HBSBQxZk0qGFlpJDE5Px1lANE21dKB/+AAennUjtpj8IU1EpnYA2bo8O/MGzzdpPymwSFj9OkgMv+4j1iQ0JrTrkbJh7ANsLsP0QGDfnS3LrL324Y/fSw9Y3daq4I8NuYERcz2dJqaPJPxWh2aIQA34=
Received: from BYAPR01CA0031.prod.exchangelabs.com (2603:10b6:a02:80::44) by
 PH0PR12MB8032.namprd12.prod.outlook.com (2603:10b6:510:26f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 21:06:59 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a02:80:cafe::ee) by BYAPR01CA0031.outlook.office365.com
 (2603:10b6:a02:80::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 21:07:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:06:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:06:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/30] drm/amdgpu: move scheduler wqueue handling into
 callbacks
Date: Wed, 25 Jun 2025 17:06:14 -0400
Message-ID: <20250625210638.422479-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625210638.422479-1-alexander.deucher@amd.com>
References: <20250625210638.422479-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|PH0PR12MB8032:EE_
X-MS-Office365-Filtering-Correlation-Id: d4cceefe-6e3a-4ada-b207-08ddb42c3957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8IxUCCHMix15qPwGpk6E/Eq3NOnwma9M4CYyy1liWIDKoWgkle/TCSQjgtWW?=
 =?us-ascii?Q?CS447uo1CxPqv7E+tR/9SMn2xcy+C8aYRBcuqDhszZ4DqI8u30qkq88pW8nV?=
 =?us-ascii?Q?Z8eZja1lh7MwpS18iH/c5NEKSJj5KIZMSjHnejzxHr8T8TO1cx7WLmrcXUuM?=
 =?us-ascii?Q?yMWWPJPFwZ2nUz82M7lBgAe2DPV+XqSxaoO41orpk/9WEjM6K53MYQlwedp1?=
 =?us-ascii?Q?HEVKy9xfB2WFhgtUTWornSJUGqpCXYsavjOlH/FaBMTEz4z/EIGWVxbu7oQb?=
 =?us-ascii?Q?L9lZFhYUMM0nn0IMe7Gq5iCT3fXxl5j8b6SrrhksmyqjEE3BDyDiPMC6lIgY?=
 =?us-ascii?Q?XQp9d5ksTJkpSH3bHkw1IRC08SPhrtXR4T59tL3h1NJIDEdy2aaXeFLW82hX?=
 =?us-ascii?Q?KZ/zSr8hHj+hYju5tdEl5juhiVEy7mCL0Ye/YORCwINDkhTZes+VOnDxjveV?=
 =?us-ascii?Q?be1cjr+65/Vrolz2zvwc66PtGsJHnzv2s/8yRXgDFJnfbcZUPKLgBtZAJ7gA?=
 =?us-ascii?Q?kca2fbJunYEc2M7PlgBr3O7AjZ9nUk0m6HbZ+Yb44DB44K8WB8Q7fLbZTlDy?=
 =?us-ascii?Q?/CmueepXnaqbff62IYBjMHUivDe7+FyD25Pgp0FojhhR4IKwrmzWAczXqeDv?=
 =?us-ascii?Q?tiUXB91ivGa8xzGKn6FFW69DPUq3lC9p257vGEOkfhPpPq+QXOm+dN9QnKy4?=
 =?us-ascii?Q?xc7qYntLtsj3wMuoAqI0WYytoSQBkECcCWNhuxodNMKQ5p3i7PFa/5FCWBg7?=
 =?us-ascii?Q?0xvIQkkfBItcUBu35V2zLB8xE/zTSmfGBnWh/SU6v2LOsO0uZYrYG9JEKGDV?=
 =?us-ascii?Q?Hpb5l9CHbOV+6jSJT4XmyWE62j0dZFl/0QJYdQmjJRaDU+iiuW3VXfs0g/Gn?=
 =?us-ascii?Q?X93v1dqfDfcYYkA0rhbQ4u9qDtC/DIy6IH6jEOqEAIIpCKmOYXJgFEESOw2g?=
 =?us-ascii?Q?wY/qnsbvsjPYWZZikTO9/oQnJ8ZVn+nMkF2XOjlnj0EYXHo2HO/Hzn7PxT1z?=
 =?us-ascii?Q?Et/eAGm+uKaJtmAc9Y6G3gX5ypDfudXVAa8XZtNOZbGX3h50C641scUlxXlW?=
 =?us-ascii?Q?JwLHyCatDxhxoPU1lrBCNOIDhTFS3EESGRsr2qUn52Kr/xSRuUQC+Pih9OgC?=
 =?us-ascii?Q?LPegMH1fpWFH/yAzi9pSTPSaMRuJotbL5AR1UnALLIdtvvJ37Vihj02gqNx5?=
 =?us-ascii?Q?0BuswNoussjGcDKhzew1t9whjwjmVBqe6N3DYYpAmQD0GDn1vK/KabYk++6N?=
 =?us-ascii?Q?KBMOa6YceIkTS3DBvYniYugopIG/MHgBOmM82X9zz7QTfnF0LejmveDArUyg?=
 =?us-ascii?Q?puty2ce23KYoxpV/HJmRfliqk+GObAHRuovJKH0LfknfEWMFFRQ1PakG0ew8?=
 =?us-ascii?Q?cUVPV1Y170hBlR6M76fntmI8ajErM4LzcsYU5lEJHfozmIiArMO4ts8aiFkJ?=
 =?us-ascii?Q?/+eusu+YrrdvtlAz8T22vWtmQ+eYFacQO1BiNKRXwERi9Apn0eUi9M+/qTIA?=
 =?us-ascii?Q?e8iasyXVUF/KqLv8c8mkSV5vE9E8qLDcT7FS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:06:58.8749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4cceefe-6e3a-4ada-b207-08ddb42c3957
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8032
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

Move the scheduler wqueue stopping and starting into
the ring reset callbacks.  On some IPs we have to reset
an engine which may have multiple queues.  Move the wqueue
handling into the backend so we can handle them as needed
based on the type of reset available.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  8 --------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 17 ++++-------------
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  3 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  3 +++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  2 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  2 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  2 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  2 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  3 +++
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  3 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  2 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  3 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  2 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  2 ++
 19 files changed, 55 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 3b7d3844a74bc..f0b7080dccb8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -135,17 +135,9 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	} else if (amdgpu_gpu_recovery && ring->funcs->reset) {
 		dev_err(adev->dev, "Starting %s ring reset\n",
 			s_job->sched->name);
-
-		/*
-		 * Stop the scheduler to prevent anybody else from touching the
-		 * ring buffer.
-		 */
-		drm_sched_wqueue_stop(&ring->sched);
-
 		r = amdgpu_ring_reset(ring, job->vmid, NULL);
 		if (!r) {
 			atomic_inc(&ring->adev->gpu_reset_counter);
-			drm_sched_wqueue_start(&ring->sched);
 			dev_err(adev->dev, "Ring %s reset succeeded\n",
 				ring->sched.name);
 			drm_dev_wedged_event(adev_to_drm(adev),
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index cf5733d5d26dd..7e26a44dcc1fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -554,22 +554,16 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
 	struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
 	struct amdgpu_ring *page_ring = &sdma_instance->page;
-	bool gfx_sched_stopped = false, page_sched_stopped = false;
 
 	mutex_lock(&sdma_instance->engine_reset_mutex);
 	/* Stop the scheduler's work queue for the GFX and page rings if they are running.
 	* This ensures that no new tasks are submitted to the queues while
 	* the reset is in progress.
 	*/
-	if (!amdgpu_ring_sched_ready(gfx_ring)) {
-		drm_sched_wqueue_stop(&gfx_ring->sched);
-		gfx_sched_stopped = true;
-	}
+	drm_sched_wqueue_stop(&gfx_ring->sched);
 
-	if (adev->sdma.has_page_queue && !amdgpu_ring_sched_ready(page_ring)) {
+	if (adev->sdma.has_page_queue)
 		drm_sched_wqueue_stop(&page_ring->sched);
-		page_sched_stopped = true;
-	}
 
 	if (sdma_instance->funcs->stop_kernel_queue) {
 		sdma_instance->funcs->stop_kernel_queue(gfx_ring);
@@ -596,12 +590,9 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 	 * to be submitted to the queues after the reset is complete.
 	 */
 	if (!ret) {
-		if (gfx_sched_stopped && amdgpu_ring_sched_ready(gfx_ring)) {
-			drm_sched_wqueue_start(&gfx_ring->sched);
-		}
-		if (page_sched_stopped && amdgpu_ring_sched_ready(page_ring)) {
+		drm_sched_wqueue_start(&gfx_ring->sched);
+		if (adev->sdma.has_page_queue)
 			drm_sched_wqueue_start(&page_ring->sched);
-		}
 	}
 	mutex_unlock(&sdma_instance->engine_reset_mutex);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 4d0ee3ffe9858..8c377ecbb8a75 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9540,6 +9540,8 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
+	drm_sched_wqueue_stop(&ring->sched);
+
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
 	if (amdgpu_ring_alloc(kiq_ring, 5 + 7 + 7 + kiq->pmf->map_queues_size)) {
@@ -9581,6 +9583,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
@@ -9600,6 +9603,8 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
+	drm_sched_wqueue_stop(&ring->sched);
+
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
@@ -9658,6 +9663,7 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 39f4dd18c277b..37dcec2d07841 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6821,6 +6821,8 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
+	drm_sched_wqueue_stop(&ring->sched);
+
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
 	if (r) {
 
@@ -6846,6 +6848,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
@@ -6989,6 +6992,8 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
+	drm_sched_wqueue_stop(&ring->sched);
+
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe reset\n", r);
@@ -7012,6 +7017,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 964fa3f2e2719..e4fc42470cf3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5317,6 +5317,8 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
+	drm_sched_wqueue_stop(&ring->sched);
+
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
 	if (r) {
 		dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
@@ -5341,6 +5343,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
@@ -5437,6 +5440,8 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
+	drm_sched_wqueue_stop(&ring->sched);
+
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq  and try pipe reset\n", r);
@@ -5460,6 +5465,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 95e319974f221..76ba664efecb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7187,6 +7187,8 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
+	drm_sched_wqueue_stop(&ring->sched);
+
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
@@ -7247,6 +7249,7 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 8bfee17a826e2..daed0f187bda5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3567,6 +3567,8 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
+	drm_sched_wqueue_stop(&ring->sched);
+
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
@@ -3625,6 +3627,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 6621a7b1f29fc..781a5a8a83614 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -770,12 +770,14 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
 {
 	int r;
 
+	drm_sched_wqueue_stop(&ring->sched);
 	jpeg_v2_0_stop(ring->adev);
 	jpeg_v2_0_start(ring->adev);
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 44a5c0e82ca43..5be9cdcae32c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -649,12 +649,14 @@ static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
 {
 	int r;
 
+	drm_sched_wqueue_stop(&ring->sched);
 	jpeg_v2_5_stop_inst(ring->adev, ring->me);
 	jpeg_v2_5_start_inst(ring->adev, ring->me);
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index e813af4eedd21..a24bd833d6442 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -561,12 +561,14 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
 {
 	int r;
 
+	drm_sched_wqueue_stop(&ring->sched);
 	jpeg_v3_0_stop(ring->adev);
 	jpeg_v3_0_start(ring->adev);
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 190f0742d7016..1d4edd77837d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -729,12 +729,14 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EINVAL;
 
+	drm_sched_wqueue_stop(&ring->sched);
 	jpeg_v4_0_stop(ring->adev);
 	jpeg_v4_0_start(ring->adev);
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 04755b7a62d9b..78441f8fce972 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1152,12 +1152,14 @@ static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
 
+	drm_sched_wqueue_stop(&ring->sched);
 	jpeg_v4_0_3_core_stall_reset(ring);
 	jpeg_v4_0_3_start_jrbc(ring);
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index e7f942dc714a7..6f8a16da9d608 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -843,12 +843,14 @@ static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
 
+	drm_sched_wqueue_stop(&ring->sched);
 	jpeg_v5_0_1_core_stall_reset(ring);
 	jpeg_v5_0_1_init_jrbc(ring);
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 4b6a799704f1f..103e5ec7aa63b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1586,6 +1586,8 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 		return -EINVAL;
 	}
 
+	drm_sched_wqueue_stop(&ring->sched);
+
 	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
 	if (r)
 		return r;
@@ -1594,6 +1596,7 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index b00c63812899d..99a080bad2a3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -822,6 +822,8 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 		return -EINVAL;
 	}
 
+	drm_sched_wqueue_stop(&ring->sched);
+
 	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
 	if (r)
 		return r;
@@ -830,6 +832,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 6c25e9fc4f0f9..eec9133e1b2c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1978,6 +1978,7 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
+	drm_sched_wqueue_stop(&ring->sched);
 	vcn_v4_0_stop(vinst);
 	vcn_v4_0_start(vinst);
 
@@ -1985,6 +1986,7 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 1e1dd61b774ec..d8fd32c1e38ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1609,6 +1609,8 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
+	drm_sched_wqueue_stop(&ring->sched);
+
 	vcn_inst = GET_INST(VCN, ring->me);
 	r = amdgpu_dpm_reset_vcn(adev, 1 << vcn_inst);
 
@@ -1626,6 +1628,7 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 9c02446bb1a54..7e37ddea63550 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1476,6 +1476,7 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
+	drm_sched_wqueue_stop(&ring->sched);
 	vcn_v4_0_5_stop(vinst);
 	vcn_v4_0_5_start(vinst);
 
@@ -1483,6 +1484,7 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index c8924f97cf58a..47c0bcc9e7d80 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1203,6 +1203,7 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
+	drm_sched_wqueue_stop(&ring->sched);
 	vcn_v5_0_0_stop(vinst);
 	vcn_v5_0_0_start(vinst);
 
@@ -1210,6 +1211,7 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
-- 
2.50.0

