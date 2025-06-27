Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4B1C83013
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F236210E953;
	Fri, 27 Jun 2025 03:40:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vdsG1aow";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E2A810E944
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOyrS56J+hsYzDE38Uvl0hdqsnHOkYgC3Uw2wkf1ypf54PdT3QBokFG4sZZcAUfydDVLqGACluaQiPjv/LH+XQUV7Dz/W0i1Hiz8LiXIWSLPA0ehoDQkYdU/5st5M2QHm+Lw63LXrL2/ngF+/Xd4/PqWhUuaEiI7wpcpM++lWPEALaLok0BL4SXDsI+fNX54lijSiVwzU66LMDGQp+uFP0WOfN2n/Cjb9guOBJvcnw5cGL1eAyg+koGobEpR/BFwNj7amqVsjhX4AKHe6lEUXPyDDGM9GqMtuYjmzvglf3B+Ou7BBk4MYgL1ooFxHIcXvCj+bzG1l4bU6HbjV+83lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqklPXV9ZwwFOEi8iGogzjUC6dcnIRffEL7tLVPHshU=;
 b=mkodFbqRBwl77X+r5/PJwUkyU/wnApVfLjWLOr/4YtXDPS090Vv4CSCO/x1svUx/Sh/XMFhtfzfST2eMVBcpj7+pa19tutSEx+3+rMlxNyOkRnbvDSExrBuoFOjkH/Xmd7flm5Yfxi2QfQCoZlZ7sVjA0hfvxOxXxKKKh0DiqkUjYbP3KB2R8eQX4pq9IV5akDclLW7HyUMIIWK9kgeYnN5JUmxpic0Ls+sboOCkzNnTHrFbSa8SmAmz4apad1l7xTQObev8x9UFS7kAVN/wH8+xANma5NZ4ndaMxNZYFOe4vp8tSxxVuMiKviaWkGXm7ZKXCqRnfZcNLEzZp8EpAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqklPXV9ZwwFOEi8iGogzjUC6dcnIRffEL7tLVPHshU=;
 b=vdsG1aowTtTQ8r+aJJhJarchAlv5ruroNYl0kDTJbaBuVvAzpatbrY1mQR523VvwxzMNUZs/pen2dnFYabYsIqzSi25LTlv9oflOHemdTRCayYJE762TRb9iOwoTUoO7x0Jreyx+ncjgG/mgXvmmPKkcbarz10TRxhYnHAMqxkk=
Received: from BL1PR13CA0183.namprd13.prod.outlook.com (2603:10b6:208:2be::8)
 by BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Fri, 27 Jun
 2025 03:40:41 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::51) by BL1PR13CA0183.outlook.office365.com
 (2603:10b6:208:2be::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.10 via Frontend Transport; Fri,
 27 Jun 2025 03:40:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 30/33] drm/amdgpu/vcn: add a helper framework for engine resets
Date: Thu, 26 Jun 2025 23:39:59 -0400
Message-ID: <20250627034002.5590-31-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627034002.5590-1-alexander.deucher@amd.com>
References: <20250627034002.5590-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|BL1PR12MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b337d91-c4da-4b0d-029e-08ddb52c640d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pzfB+Qv6v1xyvhK9KGmjQOwuSNcDaUxsLIsijOxmE7iK/ItzukXHq6dh48hh?=
 =?us-ascii?Q?cvzzImtgcR2RtSqTTwV3JCdA6ysLYweAkPFNVcTb4bX1+duYAddvvWvpUzmv?=
 =?us-ascii?Q?JSK6bKewBQU3v9Va+NK3aVQzZMv1k6aN6dzCCw+0IJ7LBTPvu41eVhyrpmAE?=
 =?us-ascii?Q?+UDi8y/C5mgJPMG2YGwUmi5o7a9YE4J+XMOHncjXdl7RPm/WaPWDbBako41c?=
 =?us-ascii?Q?+H7kMQCM1ru85/X1HjlIwfKNVhzSqArb+7HA/Y0Ma+PIND5xhxTr5iybZGPP?=
 =?us-ascii?Q?94OZRXKrn+FlwYZmPkF+QLwKvryxheK8Dm6tOXa8NcfTtYkvbjW6qk5zo0NV?=
 =?us-ascii?Q?rom+WPWAlKCtgmOMEgWskbxPfyhdND5OB2fzl6vjMFjRWKDevdWGCA56LdPx?=
 =?us-ascii?Q?cYiXHk2+JlPUMwdwxQzrBFrnLCSUn3V8j0NT67FAdwl6G2nbHFqvtKEc8W3y?=
 =?us-ascii?Q?KNyVMc2AtWNc81EIl8ij4aU+QXEMOHziLWNHUNZqEp5YDPKTopi+L9yjJ57U?=
 =?us-ascii?Q?MAsbo6+SvN2abXzlopJ2ydX9hJloZNytiI6OPBRFilMSZfr0uuJ9hK1PuQBl?=
 =?us-ascii?Q?+P1CDbECTa5fQa1C/AHk3ox1NRJnwzYg2OBHpxfiOf9C4KNtzUoHhRkoBB7g?=
 =?us-ascii?Q?s7XoMd2b5y/qJ2zWpT0jEyoPjPd7Cwp1Of+zQCGCnmKkceVlcyxFU+CpoFdP?=
 =?us-ascii?Q?oPWWzN5fofaf447Z1VCdcZd2VYW1MFg3rT+gb5B3s2LhFv+6VzuYR3zmOU3r?=
 =?us-ascii?Q?s7biL6SrF8bktrJeQ1q7Bq3InCY8IeQbFFB4/ldWvj9rjaYZQsk6vQAAaMEx?=
 =?us-ascii?Q?MYZ6LSvXKodRvmHQuwFlEjmeBqlnM0dUenG9Ut3tY9w71mOHOsknEAjTGu58?=
 =?us-ascii?Q?ugAQEj7bPvhiNzgg7K/7C9MFuD5T/6KRGUCu8qkA0K8YMQ1c8Z9hBRBy2lHW?=
 =?us-ascii?Q?RHCf5k9sY3FfM6qpJTnzJkFfC8nV7PKpLKCvL2FlZFKVZtfXdEf5/4AubRgy?=
 =?us-ascii?Q?vmVYEpbnHs9AnJ8a6bV0VhHdZEW71mGiGslBHQbcZWQfb9m+R3i0YwW5U0rU?=
 =?us-ascii?Q?88Yw9u6dfEByXFPvvDB19HKPHhpXxK2uLreY4OY7v7QpIh7GcUjdrwxB/foq?=
 =?us-ascii?Q?NCMdRxFDmuUTpbVuBCaERjd4ykOAV+vcGa9Z6EINVX+L9bNxT7/j1B3Cojcz?=
 =?us-ascii?Q?TXbzBje+tDJ7y5zosGuyEUoRfCJbxhztof3gvyQllV5/VkPPHi/dtsxx0eM+?=
 =?us-ascii?Q?GXAXpRSy/XvccwH6oTb32RTcuqm3VFMDj7xbBaTOCUSejqTF8p/saidhpXSH?=
 =?us-ascii?Q?lRTrTzZsrHCBvCv+9+cyCveVlZXjzL1dRiVFez8TYG7TcpiHF09fdFUtphX/?=
 =?us-ascii?Q?Tgbl4+p3TLIwXqYyLzT6wE7yU9pWQmRGuixpH0f+U0vIBsOM5WJCmrwx/iJe?=
 =?us-ascii?Q?AayRTleMD8vnseeMB+1s1s6PEMHKPILS+4TC985rsXSvWSSr7M0dRlOYOMU9?=
 =?us-ascii?Q?/3QbWqdOO0Uj2VP3ryzQvFwf+cl5edqBMksa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:41.7802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b337d91-c4da-4b0d-029e-08ddb52c640d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5804
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

