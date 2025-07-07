Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D751BC8303C
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 759EA10E53D;
	Mon,  7 Jul 2025 19:04:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jkkSUMk9";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBF7F10E53B
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcqnjHCElhF6Xihc5ENyk5vp2g/aQLMakADBhucrJOCqh3hc5NE8MlRKFGt016fa5l7gdaL4beDQL3v4G4D6VLz2M+5jciFiZSHItFz87JIIERGTkg4L8zzjJiU5lnxAczP1ay2yLJnwN7pe+vB+cHsH0S8KdrLPhQh1M99y+nCTvvwHY7y2cTZspSRbvfIj2fjF1srRUXIVW3kNvrhjzeFNsSO/sjy2JbHKi+9t/DA9Yl+kcQ9zY6Z86FD3EYLoIJnKJxcxz15Nar+0UUfdtjPmRyG7Pna7JIxZ2a7Um8w+VlrpZaVeUySDVOdyHpHTNw5KBGknqry4+hsEY53HZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqklPXV9ZwwFOEi8iGogzjUC6dcnIRffEL7tLVPHshU=;
 b=wp3gd8eYs9KCZi/xDEkRRSjiYhbcb+dIallFP+I+tQTUA8aAoOiEFdUafLq0tf2t4IKAhyzDzOKUT/aZ6P+9qwcq7DPXwqp8dQILJLICLwQJAmeN79youksZU8S9HI2m5aYDm61kiRSILpe+sO6eoxfYVnQ4wlQuSsVFS+WBNU7ov90uAV1csvKmpPP1F4pWwg2fvkTS5xcKmGOiYAI3imJcYtv/hu37+SpdASzwxu+RScxkHN5seJfCFgPL5lLeLcC21nxjWKiZjFkJWuzwEjxTxtqXdrMq8WGAHMLvKrevhrtm6XfDbz0PZK3sZ9aQHZIDaPJI19drVto/77x3oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqklPXV9ZwwFOEi8iGogzjUC6dcnIRffEL7tLVPHshU=;
 b=jkkSUMk9PiJzROxeobG1LI7zS6EcEUtH4zKOKQsrhFoLMA2EpGZKebu0QuzaD+49nQN7RARrCqFZPQ0LwWqyrCL6GYt0EaoYInLjr4iHK5iTyedIlOVh8vvJWt3clAN0UJsMy+aE4laq4LrcRU3zxHcNidwSag1t2hrRVcrLhXw=
Received: from PH7P221CA0081.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::33)
 by LV8PR12MB9136.namprd12.prod.outlook.com (2603:10b6:408:18e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Mon, 7 Jul
 2025 19:04:34 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::e8) by PH7P221CA0081.outlook.office365.com
 (2603:10b6:510:328::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 33/36] drm/amdgpu/vcn: add a helper framework for engine resets
Date: Mon, 7 Jul 2025 15:03:52 -0400
Message-ID: <20250707190355.837891-34-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707190355.837891-1-alexander.deucher@amd.com>
References: <20250707190355.837891-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|LV8PR12MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f3e9f3-a60c-419f-1566-08ddbd891c9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kLJlJPHqx54NH0k0cD9tsZDrVZtVGPuVw3Y9RnjsOef5YpezhF6yKiVo1TrR?=
 =?us-ascii?Q?6RqUfxSqo9nTKRWYq1U9BImuBB1nnbdiu8OQtWkOk42Vk2g70aatweGh6iUi?=
 =?us-ascii?Q?1HSzgxW1ZAjlpwbbVKNJSJYXFDOxUr7mOFK+PS1sWqTVAtVPSGeViY/7q4Sk?=
 =?us-ascii?Q?ZZWkqP3Sucg3rjYfocTqjhOv+RvDtMJhOeUr5Ca/PHgjSa682PJOLBHwT/bQ?=
 =?us-ascii?Q?iYCCITi1aX3S6pucx99C2ZDblmndOZsjh6KpxbylKpdZ2DuG+P/HP4xrNp8z?=
 =?us-ascii?Q?K1qvvhHGOf8jAfcPx9INa/KD3f34mnKlf5TjxDT5VY1zyCfBYGhSSMTZNf6g?=
 =?us-ascii?Q?o9148y+gN1JnVSJ2Z7fjf0cLKCz7akl3oYuDJ7LMfSSMWtTPei67W17EfZwN?=
 =?us-ascii?Q?pL0FjIp+E+5gi3U+AmThKEM8VfOyOITXD4fW2JLQAHLPnfwTlwI3uQdHwJwf?=
 =?us-ascii?Q?h7sZ90qYgL/vsZGiO4hcN1phV97mReuJPBeY4DnGlOlapu0dMnRjyX2SL85w?=
 =?us-ascii?Q?9G3eEYdvGQ5zWDwl/uSnR5pt3eM+FOYq55zO/Rah17GTY/OlXkhoEIyzNtdK?=
 =?us-ascii?Q?8G4GLVx22+nYIqhLf6/pl4eK2h2ZsT/Fq43A5dnGrOvnalR0kXxQ+tUO4tGx?=
 =?us-ascii?Q?YKU6s8MPzhPtUYf+Lyy2t1zLG9X9InWGPFy06w+PYiB+L909R6LGVqiRHMBF?=
 =?us-ascii?Q?Fo28Omnljljj9fPm1quIlfYtusI3vXmzCh2Z2mi7pZORfzHDAWrfVEarzvVM?=
 =?us-ascii?Q?ahUT02eIycZ0M56D5/+i0D955rB2Pt2E3dYKvsL9J8qsjf8/3YNIerrvga6k?=
 =?us-ascii?Q?LZMHOfd/hRqRruXS45FxKZctj73fHPwks5Kp08dFwSew+pNy1lgtIIQv4ToT?=
 =?us-ascii?Q?OTyYiHCzo5DQQlA0CpiPH15jlANhgF2VKP2AjzFafY7+fNU2aWqdEyqyF2FK?=
 =?us-ascii?Q?AOMItHfFBj0NIOLvZUNdIsbN9+Wa7bDkmCwopqLFGJ3VM7g9zMnR2UA5faIz?=
 =?us-ascii?Q?Z2+pSE2OYH+sw7B6gKlR05/rD6/EalWknU0JJYzSlAEBgHRyMiI3mIsmNM6I?=
 =?us-ascii?Q?8BL3dEY0IX/qQCmymkd+1ZxVxyo9EMBuUsVJb5iO1C693wCIA24QW08zz6yF?=
 =?us-ascii?Q?sH5P3+C+/iY5yR0qPF59BauhuqrO80KJ3TVZIq96Z6tg+7OUghVjaZyzwdZ1?=
 =?us-ascii?Q?Bsiy1zEJ+epSJRCxNGjC3iBrtr34QaG+E6ROVucJJyfv9YYPcaAUxUnrJ8fJ?=
 =?us-ascii?Q?n988kdiSSIW71ey+mmXNMkGF9kdIwkJKTcJ6onKbyPSo6MAtAkj+9GCnmHKb?=
 =?us-ascii?Q?nkd+9vTwj+mcZFPUo9Kpqh4YpaeheS/35qQ064KC/a6It2P7JzKrSU8DaUA8?=
 =?us-ascii?Q?tXCtA03sKPCpmXdJkHEgnf71nqxvxI4IG10DzudQ28Jn3+gbR8lnuF/mA/yi?=
 =?us-ascii?Q?l+uuvLYAQ3MYnMFMEZGlq/a46/4F27IdScSoijirIVurw7IV1z9QjVokpWIG?=
 =?us-ascii?Q?UPU4Q4r+QzIny0IUy5X4ZBZH5WkLKnj5q1wZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:34.3819 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f3e9f3-a60c-419f-1566-08ddbd891c9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9136
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

With engine resets we reset all queues on the engine rather
than just a single queue.  Add a framework to handle this
similar to SDMA.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 76 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  6 +-
 2 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index c8885c3d54b33..f1f67521c29ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -134,6 +134,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i)
 
 	mutex_init(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
 	mutex_init(&adev->vcn.inst[i].vcn_pg_lock);
+	mutex_init(&adev->vcn.inst[i].engine_reset_mutex);
 	atomic_set(&adev->vcn.inst[i].total_submission_cnt, 0);
 	INIT_DELAYED_WORK(&adev->vcn.inst[i].idle_work, amdgpu_vcn_idle_work_handler);
 	atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
@@ -1451,3 +1452,78 @@ int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
 
 	return ret;
 }
+
+/**
+ * amdgpu_vcn_reset_engine - Reset a specific VCN engine
+ * @adev: Pointer to the AMDGPU device
+ * @instance_id: VCN engine instance to reset
+ *
+ * Returns: 0 on success, or a negative error code on failure.
+ */
+static int amdgpu_vcn_reset_engine(struct amdgpu_device *adev,
+				   uint32_t instance_id)
+{
+	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[instance_id];
+	int r, i;
+
+	mutex_lock(&vinst->engine_reset_mutex);
+	/* Stop the scheduler's work queue for the dec and enc rings if they are running.
+	 * This ensures that no new tasks are submitted to the queues while
+	 * the reset is in progress.
+	 */
+	drm_sched_wqueue_stop(&vinst->ring_dec.sched);
+	for (i = 0; i < vinst->num_enc_rings; i++)
+		drm_sched_wqueue_stop(&vinst->ring_enc[i].sched);
+
+	/* Perform the VCN reset for the specified instance */
+	r = vinst->reset(vinst);
+	if (r)
+		goto unlock;
+	r = amdgpu_ring_test_ring(&vinst->ring_dec);
+	if (r)
+		goto unlock;
+	for (i = 0; i < vinst->num_enc_rings; i++) {
+		r = amdgpu_ring_test_ring(&vinst->ring_enc[i]);
+		if (r)
+			goto unlock;
+	}
+	amdgpu_fence_driver_force_completion(&vinst->ring_dec);
+	for (i = 0; i < vinst->num_enc_rings; i++)
+		amdgpu_fence_driver_force_completion(&vinst->ring_enc[i]);
+
+	/* Restart the scheduler's work queue for the dec and enc rings
+	 * if they were stopped by this function. This allows new tasks
+	 * to be submitted to the queues after the reset is complete.
+	 */
+	drm_sched_wqueue_start(&vinst->ring_dec.sched);
+	for (i = 0; i < vinst->num_enc_rings; i++)
+		drm_sched_wqueue_start(&vinst->ring_enc[i].sched);
+
+unlock:
+	mutex_unlock(&vinst->engine_reset_mutex);
+
+	return r;
+}
+
+/**
+ * amdgpu_vcn_ring_reset - Reset a VCN ring
+ * @ring: ring to reset
+ * @vmid: vmid of guilty job
+ * @timedout_fence: fence of timed out job
+ *
+ * This helper is for VCN blocks without unified queues because
+ * resetting the engine resets all queues in that case.  With
+ * unified queues we have one queue per engine.
+ * Returns: 0 on success, or a negative error code on failure.
+ */
+int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
+			  unsigned int vmid,
+			  struct amdgpu_fence *timedout_fence)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (adev->vcn.inst[ring->me].using_unified_queue)
+		return -EINVAL;
+
+	return amdgpu_vcn_reset_engine(adev, ring->me);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 83adf81defc71..0bc0a94d7cf0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -330,7 +330,9 @@ struct amdgpu_vcn_inst {
 			      struct dpg_pause_state *new_state);
 	int (*set_pg_state)(struct amdgpu_vcn_inst *vinst,
 			    enum amd_powergating_state state);
+	int (*reset)(struct amdgpu_vcn_inst *vinst);
 	bool using_unified_queue;
+	struct mutex		engine_reset_mutex;
 };
 
 struct amdgpu_vcn_ras {
@@ -552,5 +554,7 @@ void amdgpu_debugfs_vcn_sched_mask_init(struct amdgpu_device *adev);
 
 int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
 			      enum amd_powergating_state state);
-
+int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
+			  unsigned int vmid,
+			  struct amdgpu_fence *guilty_fence);
 #endif
-- 
2.50.0

