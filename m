Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D017C0219B
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 07:32:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABCF010E4BE;
	Mon, 10 Feb 2025 07:32:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZZlww0Dx";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FEBE10E4BE
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 07:32:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUCb7Wzt5WdlYY7Mg+Cne6d6BgTtEu+e7JXYzp2LhDYJ+8R7JdxV1vuAWyz08U/KvnaFQRcezksXttYpx9/aX6PVdx1ki8Yp+LYbzZwHmHeGGesULvA1njeMGrcRZc5pPTx0iHHAralnZxO/BQvVG6WIViVLsPI1wp/pG2xZa4GhNxla1tZ0kMsuCZDPh/8Vdi7ZJVGhKQagSk2SjNtuBBqNT4vDwn9FjJp2RCNuaJBWB+NlNVCbFOAfVal+CU/PnD7XwHHP/VFvz3uu/CIoP1NMfW3n/Zo/1pJ1l7og5px+kSdqaq6588unE4yyWUUI0AobNYqHimjFIio1LI3DKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euWWzAkp3AQbkkWpZvDO5tzDV6imQaxG7r7MJw4pgv4=;
 b=t6V/tCj0jmk5f/JAEFItI18gdVIVrWDDAiZ7Oc7BozsbPOBPP8efRLnlOb1snPVnAnMSGvbn0pGmR6xlvLnzLp4moF0jqxIyyfi/cVKx+g5v5hmSIdncMye4t9hvtUYiA877dLyy3M2dCjA0PxgpZ6eM6tMfSccL1WvR8DF3a4RJEnfiXMLqwL/q2Uv6nRCxMAAS2kaGhATjWBMLqUbktQO70FF4RR4CuNmzTY6pOuurCnp2LhkB7deDhH9PvmFFDrhKG1/kDW+M67eLe5BBfWseFvBSxF/2cKeyBOVA+SPQkKjUrBJkaf8yiTK82LDcC7Lh+ztrecQYFM99t+3x0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euWWzAkp3AQbkkWpZvDO5tzDV6imQaxG7r7MJw4pgv4=;
 b=ZZlww0DxnLTPL9a0Sz6cJivKphZHQt8RQdjozr0Q0LDqprJftkzhIw2Qe8Jswmdjc5R7AgWKWk3b0ERDNSLGmLzf4xEpQNK+1pAepGNFcV8EVuoQYdBNp+P8FyshbIxLue+CAqFCQKBlCQ10JOqRAVf0xPZQ1hs6IYz0289l7lI=
Received: from SJ0PR03CA0190.namprd03.prod.outlook.com (2603:10b6:a03:2ef::15)
 by PH0PR12MB7080.namprd12.prod.outlook.com (2603:10b6:510:21d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 07:32:32 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::7d) by SJ0PR03CA0190.outlook.office365.com
 (2603:10b6:a03:2ef::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 07:32:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 07:32:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 01:32:30 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 01:32:29 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 10 Feb 2025 01:32:17 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>, Jonathan Kim
 <Jonathan.Kim@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Improve SDMA reset logic with guilty queue
 tracking
Date: Mon, 10 Feb 2025 15:31:45 +0800
Message-ID: <20250210073145.2681082-4-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250210073145.2681082-1-jesse.zhang@amd.com>
References: <20250210073145.2681082-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|PH0PR12MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: dd417f60-7b54-49db-7df6-08dd49a514ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PnyMUSTYxRGbGkJW3Vgy57RBvJ3Kx6ofixXg1qcN0SJ79WSgtCxnazVvs3YE?=
 =?us-ascii?Q?2t+44zAp2vwR0sB6Z9XnJHPYAjxHLx2RnSbgFo7eiKBTinoc+0sLhz5nWNvc?=
 =?us-ascii?Q?885JYjbnjPbt5iTXH+exFvaDRG84YmxikBnOwwnh0dZ5pqPvoatRGTixK/Nh?=
 =?us-ascii?Q?iDQeYsVA6sUhzPe+ZqmPNU2PzVfnWZHyvO2z/vsHIgCZfCpSClqjpPOX13uU?=
 =?us-ascii?Q?kbLa/8BoYR/qHGqMtR1JxgEd6l0u1On9aiiHzkD0msxFo+knPzT/4lUn7ZI9?=
 =?us-ascii?Q?LnhDjgjgmX/F/bVEXFr4bfKf8S+yCmNesVFHvdpfxB7+TQ5SaT+QCs9bdWAY?=
 =?us-ascii?Q?0gEXYE9j5i7++3SPKjpnVoug5GHT4IjfQnqQfT+QRX9rhpMpo+YB6Gl6ofOO?=
 =?us-ascii?Q?VJCq9q5/BCpYaLRju2+3vI4AEyPy7AM17YgaOIa4Ng+i+mKJS4MtXOoaq3Fk?=
 =?us-ascii?Q?jMAVW48f/rpgM3VKQbxZG4OY/QUV2fjZgeq9y4PrvMSApxXHZvKPKozWkvKU?=
 =?us-ascii?Q?DIxJRXA8hNOKmzKIpmb3707NYn5ep4wM6gfFMEBWVsYBSx0WXkr7wdvBrBXy?=
 =?us-ascii?Q?UrjBFxf/rpWATQJ0L2LBzkdQyFkGrYC+7qw3iMulwE2+W0pMlT7OvZFF9bYf?=
 =?us-ascii?Q?O0R9eAOVn5xt9tUksRFlOa0qdtrV7hkPKXtYciSnLxF7y1ReQWpQTB798BBC?=
 =?us-ascii?Q?hXaKeJU2PsLYoXsBVFlcBZzl5kgxK8q6UvWo4TtbHAq6T63Gt02UXk4b6h4J?=
 =?us-ascii?Q?Xm4JUAsKEkCyvZWxpX9gN4z9HGEdDcg8Kf/Y+Q54Y6VcUgc+9hIjeP5mfcUi?=
 =?us-ascii?Q?jIGsdOuA9roGTPj92gCPTGtgApD/Okg8Ana99kWgmalCxZo4OyYPM6YZPcti?=
 =?us-ascii?Q?KzwKY8dTXyoghA0YJyGXTys8ZzaBgFijxb1BuzF3cO9m6fsXZdjnrcToqkSD?=
 =?us-ascii?Q?Tf2dM4M1/whhXX4OhAYaXdhPO//l+R9JFUGfi91u3jN65VwbJIgflU3Cctm/?=
 =?us-ascii?Q?c9T/PPAjXj6hb2VyXQF0Wuhi0cWW8SCUmKw8aqbsg3bP4ZMCdNdA1Izpp374?=
 =?us-ascii?Q?cSJ43YScXRdFgtX9hKDk//WtqrWtqiJmE+y6wBqo8SOvYjmW8H0/kO2PIFMt?=
 =?us-ascii?Q?1L/W0CVf0+WC2w18nPX13RLS9gt+f1ac48vFgTKTWMvA/YdKYvD3jqJIQdW5?=
 =?us-ascii?Q?MmERjg6oXmxNzL66egzrv9C7rxyj+kHU4ledzyF0UFctyIo5aUp/7XQ/JCyT?=
 =?us-ascii?Q?dTOSZKhm+X4aFLZ6AuiGRj1bdmNnNAUhkLZnVaHJLQx9E0ElXp+pift3Ee2U?=
 =?us-ascii?Q?kvk7aCOsB+afWOj1LNSdcnc1le1MIKYyCisL7/TBLKn9D7dT8fskxMH7pAcC?=
 =?us-ascii?Q?xAMhJPsPQOG3+ZdTj0MMinMmo4LmqwclqFHlxvjJPw3tccbt2YMN8pHbAxSm?=
 =?us-ascii?Q?tnOmYjIxXMe4ubf7yWWO+aHd86M/0wgnFS10rem/ndSdgcqsNPqnyehts4D1?=
 =?us-ascii?Q?Ptn9Z8GbfULXJQI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 07:32:32.0196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd417f60-7b54-49db-7df6-08dd49a514ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7080
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

This commit introduces several improvements to the SDMA reset logic:

1. Added `cached_rptr` to the `amdgpu_ring` structure to store the read pointer
   before a reset, ensuring proper state restoration after reset.

2. Introduced `gfx_guilty` and `page_guilty` flags in the `amdgpu_sdma` structure
   to track which queue (GFX or PAGE) caused a timeout or error.

3. Replaced the `caller` parameter with a `guilty` boolean in the reset and resume
   functions to simplify the logic and handle resets based on the guilty state.

4. Added a helper function `sdma_v4_4_2_is_queue_selected` to check the
   `SDMA*_*_CONTEXT_STATUS.SELECTED` register and determine if a queue is guilty.

v2:
   1.replace the caller with a guilty bool.
   If the queue is the guilty one, set the rptr and wptr  to the saved wptr value,
   else, set the rptr and wptr to the saved rptr value. (Alex)
   2. cache the rptr before the reset. (Alex)

v3: add a new ring callback, is_guilty(), which will get called to check if
    the ring in amdgpu_job_timedout() is actually the guilty ring. If it's not,
    we can return goto exit(Alex)

v4: cache the rptr for page ring

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 10 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 96 ++++++++++++++++++++----
 6 files changed, 106 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 100f04475943..ce3e7a9d6688 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -102,6 +102,16 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		return DRM_GPU_SCHED_STAT_ENODEV;
 	}
 
+	/* Check if the ring is actually guilty of causing the timeout.
+	 * If not, skip error handling and fence completion.
+	 */
+	if (amdgpu_gpu_recovery && ring->funcs->is_guilty) {
+		if (!ring->funcs->is_guilty(ring)) {
+			dev_err(adev->dev, "ring %s timeout, but not guilty\n",
+				s_job->sched->name);
+			goto exit;
+		}
+	}
 	/*
 	 * Do the coredump immediately after a job timeout to get a very
 	 * close dump/snapshot/representation of GPU's current error status
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index a6e28fe3f8d6..20cd21df38ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -342,6 +342,8 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	ring->buf_mask = (ring->ring_size / 4) - 1;
 	ring->ptr_mask = ring->funcs->support_64bit_ptrs ?
 		0xffffffffffffffff : ring->buf_mask;
+	/*  Initialize cached_rptr to 0 */
+	ring->cached_rptr = 0;
 
 	/* Allocate ring buffer */
 	if (ring->is_mes_queue) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 04af26536f97..182aa535d395 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -237,6 +237,7 @@ struct amdgpu_ring_funcs {
 	void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
 	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid);
 	void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
+	bool (*is_guilty)(struct amdgpu_ring *ring);
 };
 
 struct amdgpu_ring {
@@ -306,6 +307,8 @@ struct amdgpu_ring {
 
 	bool            is_sw_ring;
 	unsigned int    entry_index;
+	/* store the cached rptr to restore after reset */
+	uint64_t cached_rptr;
 
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 8864a9d7455b..02d3685d10fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -474,6 +474,10 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct
 	if (!funcs)
 		return;
 
+	/* Ensure the reset_callback_list is initialized */
+	if (!adev->sdma.reset_callback_list.next) {
+		INIT_LIST_HEAD(&adev->sdma.reset_callback_list);
+	}
 	/* Initialize the list node in the callback structure */
 	INIT_LIST_HEAD(&funcs->list);
 
@@ -513,7 +517,7 @@ int amdgpu_sdma_reset_instance(struct amdgpu_device *adev, uint32_t instance_id,
 	*/
 	if (!amdgpu_ring_sched_ready(gfx_ring)) {
 		drm_sched_wqueue_stop(&gfx_ring->sched);
-		gfx_sched_stopped = true;;
+		gfx_sched_stopped = true;
 	}
 
 	if (adev->sdma.has_page_queue && !amdgpu_ring_sched_ready(page_ring)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index df5c9f7a4374..d84c3eccc510 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -126,6 +126,9 @@ struct amdgpu_sdma {
 	uint32_t		*ip_dump;
 	uint32_t 		supported_reset;
 	struct list_head	reset_callback_list;
+	/* track guilty state of GFX and PAGE queues */
+	bool gfx_guilty;
+	bool page_guilty;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index c297b4a13680..8ad37e058438 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -671,11 +671,12 @@ static uint32_t sdma_v4_4_2_rb_cntl(struct amdgpu_ring *ring, uint32_t rb_cntl)
  * @adev: amdgpu_device pointer
  * @i: instance to resume
  * @restore: used to restore wptr when restart
+ * @guilty: boolean indicating whether this queue is the guilty one (caused the timeout/error)
  *
  * Set up the gfx DMA ring buffers and enable them.
  * Returns 0 for success, error for failure.
  */
-static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, bool restore)
+static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, bool restore, bool guilty)
 {
 	struct amdgpu_ring *ring = &adev->sdma.instance[i].ring;
 	u32 rb_cntl, ib_cntl, wptr_poll_cntl;
@@ -710,10 +711,19 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, b
 
 	/* Initialize the ring buffer's read and write pointers */
 	if (restore) {
-		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->wptr << 2));
-		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring->wptr << 2));
-		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->wptr << 2));
-		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring->wptr << 2));
+		if (guilty) {
+			/* for the guilty queue, set RPTR to the current wptr to skip bad commands */
+			WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->wptr << 2));
+			WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring->wptr << 2));
+			WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->wptr << 2));
+			WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring->wptr << 2));
+		} else {
+			/* not the guilty queue, restore the cache_rptr to continue execution */
+			WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->cached_rptr << 2));
+			WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring->cached_rptr << 2));
+			WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->cached_rptr << 2));
+			WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring->cached_rptr << 2));
+		}
 	} else {
 		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, 0);
 		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, 0);
@@ -768,11 +778,12 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, b
  * @adev: amdgpu_device pointer
  * @i: instance to resume
  * @restore: boolean to say restore needed or not
+ * @guilty: boolean indicating whether this queue is the guilty one (caused the timeout/error)
  *
  * Set up the page DMA ring buffers and enable them.
  * Returns 0 for success, error for failure.
  */
-static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i, bool restore)
+static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i, bool restore, bool guilty)
 {
 	struct amdgpu_ring *ring = &adev->sdma.instance[i].page;
 	u32 rb_cntl, ib_cntl, wptr_poll_cntl;
@@ -789,10 +800,19 @@ static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i,
 
 	/* Initialize the ring buffer's read and write pointers */
 	if (restore) {
-		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->wptr << 2));
-		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring->wptr << 2));
-		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->wptr << 2));
-		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring->wptr << 2));
+		if (guilty) {
+			/* for the guilty queue, set RPTR to the current wptr to skip bad commands */
+			WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->wptr << 2));
+			WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring->wptr << 2));
+			WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->wptr << 2));
+			WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring->wptr << 2));
+		} else {
+			/* not the guilty queue, restore the cached_rptr to continue execution */
+			WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->cached_rptr << 2));
+			WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring->cached_rptr << 2));
+			WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->cached_rptr << 2));
+			WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring->cached_rptr << 2));
+		}
 	} else {
 		WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, 0);
 		WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, 0);
@@ -968,9 +988,9 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
 		uint32_t temp;
 
 		WREG32_SDMA(i, regSDMA_SEM_WAIT_FAIL_TIMER_CNTL, 0);
-		sdma_v4_4_2_gfx_resume(adev, i, restore);
+		sdma_v4_4_2_gfx_resume(adev, i, restore, adev->sdma.gfx_guilty);
 		if (adev->sdma.has_page_queue)
-			sdma_v4_4_2_page_resume(adev, i, restore);
+			sdma_v4_4_2_page_resume(adev, i, restore, adev->sdma.page_guilty);
 
 		/* set utc l1 enable flag always to 1 */
 		temp = RREG32_SDMA(i, regSDMA_CNTL);
@@ -1480,7 +1500,9 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
 	if (r)
 		return r;
-	INIT_LIST_HEAD(&adev->sdma.reset_callback_list);
+	/* Initialize guilty flags for GFX and PAGE queues */
+	adev->sdma.gfx_guilty = false;
+	adev->sdma.page_guilty = false;
 
 	return r;
 }
@@ -1606,6 +1628,34 @@ static int sdma_v4_4_2_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static bool sdma_v4_4_2_is_queue_selected(struct amdgpu_device *adev, uint32_t instance_id, bool is_page_queue)
+{
+	uint32_t reg_offset = is_page_queue ? regSDMA_PAGE_CONTEXT_STATUS : regSDMA_GFX_CONTEXT_STATUS;
+	uint32_t context_status = RREG32(sdma_v4_4_2_get_reg_offset(adev, instance_id, reg_offset));
+
+	/* Check if the SELECTED bit is set */
+	return (context_status & SDMA_GFX_CONTEXT_STATUS__SELECTED_MASK) != 0;
+}
+
+static bool sdma_v4_4_2_ring_is_guilty(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t instance_id = ring->me;
+
+	return sdma_v4_4_2_is_queue_selected(adev, instance_id, false);
+}
+
+static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t instance_id = ring->me;
+
+	if (adev->sdma.has_page_queue)
+		return false;
+
+	return sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
+}
+
 static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -1616,11 +1666,29 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t instance_id, int src)
 {
 	u32 inst_mask;
+	uint64_t rptr;
 	struct amdgpu_ring *ring = &adev->sdma.instance[instance_id].ring;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
+	/* Check if this queue is the guilty one */
+	adev->sdma.gfx_guilty = sdma_v4_4_2_is_queue_selected(adev, instance_id, false);
+	if (adev->sdma.has_page_queue)
+		adev->sdma.page_guilty = sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
+
+	/* Cache the rptr before reset, after the reset,
+	* all of the registers will be reset to 0
+	*/
+	rptr = amdgpu_ring_get_rptr(ring);
+	ring->cached_rptr = rptr;
+	/* Cache the rptr for the page queue if it exists */
+	if (adev->sdma.has_page_queue) {
+		struct amdgpu_ring *page_ring = &adev->sdma.instance[instance_id].page;
+		rptr = amdgpu_ring_get_rptr(page_ring);
+		page_ring->cached_rptr = rptr;
+	}
+
 	/* stop queue */
 	inst_mask = 1 << ring->me;
 	sdma_v4_4_2_inst_gfx_stop(adev, inst_mask);
@@ -2055,6 +2123,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 	.reset = sdma_v4_4_2_reset_queue,
+	.is_guilty = sdma_v4_4_2_ring_is_guilty,
 };
 
 static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
@@ -2086,6 +2155,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
 	.emit_wreg = sdma_v4_4_2_ring_emit_wreg,
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.is_guilty = sdma_v4_4_2_page_ring_is_guilty,
 };
 
 static void sdma_v4_4_2_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

