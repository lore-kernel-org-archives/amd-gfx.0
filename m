Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DAFC531DC
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 00:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24AA910E328;
	Thu, 15 Aug 2024 00:05:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="upiwFWZB";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C06AD10E349
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 00:05:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMfemIY2G82HRhMT4smITgoB7R3SSjqLBRYH2PnWe7O1N/z7Lsryt4tBOeIJhPnuLu/o2Iw1ySrr8H0xfh3Jbj/+PGgPVLUoUrzq4APvK30T3am0Cf1aIvBSZyH2oGit1akhoVoYHyMdbpYwWhvukUbXxHOrp1qtcFEjEYiCI+6rNqeC+t+o2S+Bj5RxHsh8DVIcQgOI4CjM54jBDvAFPhPCOZ2a8/by0py8IZt48lC0J7iAAAWPL3DNtdidxzjzFz55UOVRscHSeQIXT1loGZVmLjpv65iqDF48OkMKG4JrwRi7UJ2GRxG5Vbrue0DOnnp4W8MW6rEfjccUSev+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0XMpygo56MOaFz3WQRPLCP6i1jJt1UVUSY0d+TgKJk=;
 b=ChDTYm/TcZxUv+QVRUKdE6GwvqVhbMXa2Z+QsI4EtQMDQjTpin9KEnaHPsny8dPXHhRY1dgF2YSUNDrEqe6Sms+MtUK6lDWuoHydePTW9aODoTdF+OUmtI3py99ML7ZQ7rFMaH8at8cKMPxedm19lmsRIWNKsgQoKXk/8/M0KOZeg+51L+QOKIlS14w573l8+AGtT6/p6Wv6b4yu6iQtFhhRtnXRS9aLorKF5q2OoeN1PpIK/y+w1gV3vORKau+fv5V2tYsG74YT241xdRXsrhJsyKNuhny6V2A7Ww2je1jxACHOazT7zNEPh0CL4/QbMeaSbgYeGAvtqqkJ2hYkCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0XMpygo56MOaFz3WQRPLCP6i1jJt1UVUSY0d+TgKJk=;
 b=upiwFWZBu81JctgjOW06SOVLy5EqdOQpn8iAc7dQdjBv6CnfuACXvxCkUKh+GhZZZV9fsbKk3G2bo6ibc5/gCf8wLvXrJjcHkkTCfMFn2dukY+VDwgSTxnLdiz1iVbdwz73N2r+0SlKPKp7qbZd/U+pGmoFx+b92rICKnDnYvUg=
Received: from MN2PR04CA0005.namprd04.prod.outlook.com (2603:10b6:208:d4::18)
 by BL1PR12MB5948.namprd12.prod.outlook.com (2603:10b6:208:39b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23; Thu, 15 Aug
 2024 00:05:28 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:d4:cafe::a5) by MN2PR04CA0005.outlook.office365.com
 (2603:10b6:208:d4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Thu, 15 Aug 2024 00:05:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 00:05:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 19:05:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Amber Lin <Amber.Lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/17] drm/amdkfd: APIs to stop/start KFD scheduling
Date: Wed, 14 Aug 2024 20:04:57 -0400
Message-ID: <20240815000501.1845226-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815000501.1845226-1-alexander.deucher@amd.com>
References: <20240815000501.1845226-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|BL1PR12MB5948:EE_
X-MS-Office365-Filtering-Correlation-Id: dcee4f7c-a15c-4762-55fc-08dcbcbdf74a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0A4KS7dq652PomNXIJDeXMBzyf6jLnAhQVNI+DaYjePHs5AsJY9SvrzQX+ML?=
 =?us-ascii?Q?QuhgAc4sov0und/cayJ5LHf52X+8z7VXYva3jQt9dJCwIizgxElaEzD1ov55?=
 =?us-ascii?Q?5S7kvL8ILODtKpEnfxEdGdbyVxounFD/vpa01r4/Dq2nRMvZrFgI+MxsfIMb?=
 =?us-ascii?Q?oXdWgFUqW6RIdwd6T/kiOj6GIyQk7Lco/xGKIUdhAPLvS9TmReyckxxrN+Lx?=
 =?us-ascii?Q?k0u7b7r0tppXhuMJLMb6eBPqFvE+OYA1NL0oiaWGZ8xb+UVnOmUuxHzy9AAh?=
 =?us-ascii?Q?mWFNs6xIN9g4heuM7nvdD27r95ndQLz0e1kyg1IwPwdwLzwlJO+AkvUr/uzp?=
 =?us-ascii?Q?qN8WTEFkZ3Hs23XnIjYJXG9Pc/vvBwfE8whBB15da5/5sXD6ksYeIWxPzcUR?=
 =?us-ascii?Q?aaG8kX3KuzOzgpDr5mvpTO6+JlJAAIM8U9egPVBxsnY8rzl65m/9jikcx58g?=
 =?us-ascii?Q?3z7QsM5gQKTkKlfx8XWe6N3MWe/Iv25rszv9s1j3pTCD1to122Zs7gMZnW4X?=
 =?us-ascii?Q?qsdF4MrSAJqaO/pjMXFaomuCqTGO7UJXzvl1XglAX/9xLcIv+A9JbzVCA2hk?=
 =?us-ascii?Q?ZdmOSIXhf9p42HfALVk/abnVu57ZZwOY4exbpH6qsVObB+GwY2yWbQ6Bi7Kc?=
 =?us-ascii?Q?9XVUsKov0COlTPoQyZK6yMXLpWVGSCEUmc5qCoF29YGGsQOJWTZlNBv0bF+t?=
 =?us-ascii?Q?lW9QKj6+af3PF1twuDvoCoRtOdQX1QHWrtf9BFHR3BCNgxTG5qEgJ1B+sJXv?=
 =?us-ascii?Q?Bl2UpwIZjpo/lupnIBXq6YvBvIz89BoIScvSc7Dr2SRwuXzLAvaLX6XV1rWS?=
 =?us-ascii?Q?dD5Y+rCzZ4mcXZOpryUVFfzdmjRGU/e7hKsqXvu+gutntD46SVt0ducQ5jE8?=
 =?us-ascii?Q?UsKPCwvIfdiGz5WylmdomK0CZ4axacw1iTIlzhNWgA/rsMF6UfBeAOnvdD6j?=
 =?us-ascii?Q?l2W9nk45qGQq/lVvQfxsCc1iED2QXt+p9kD6f8L460Cf4FmRmT7SiojwM0fV?=
 =?us-ascii?Q?mfhluhgE9x/4QedgTILPAGAB0dkSm2MgNUhHzk45dI01vPTqCaHb6PrbvgMb?=
 =?us-ascii?Q?5P2Oy5OzR0DF6gnm9nHYY/GHeyK9QsztBz0FO/iQRRBzTyVKsQL+hmoKa7wf?=
 =?us-ascii?Q?Sink4V8/vcNYGSEWovDHvLQETwxR9kTByy8GgPFKz640qwFOG7tYr41x2Ozd?=
 =?us-ascii?Q?eS2qEvogrHoHrUGZo0qq70RetMyYkCSKg/ivHLlXxtoNlB0aIp9CSZprOvIA?=
 =?us-ascii?Q?Y9KiJ60bwYYBvJFQiClNyJgtCs64zr7RQOwuyEBn9W9zS37pP7akoKX8Upqn?=
 =?us-ascii?Q?4N8hPXxbmkQu7Yy5D42HCDUx3IpCZhb0tiwI2L6xbVxUuhsqTayWDoYMCotc?=
 =?us-ascii?Q?LtpZMv1K7VUK+JBJ8i6+wKcoJJnbdtoim2IFgvUMdYkxDrkmw2oCSTIqcZp0?=
 =?us-ascii?Q?T0q/px5odCy+EhYP98aqxmjLEhgSmSJD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:05:26.2827 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcee4f7c-a15c-4762-55fc-08dcbcbdf74a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5948
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

From: Amber Lin <Amber.Lin@amd.com>

Provide amdgpu_amdkfd_stop_sched() for amdgpu to stop KFD scheduling
compute work on HIQ. amdgpu_amdkfd_start_sched() resumes the scheduling.
When amdgpu_amdkfd_stop_sched is called, KFD will unmap queues from
runlist. If users send ioctls to KFD to create queues, they'll be added
but those queues won't be mapped to runlist (so not scheduled) until
amdgpu_amdkfd_start_sched is called.

v2: fix build (Alex)

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 18 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 14 +++++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 39 +++++++++++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 58 ++++++++++++++++++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  9 +++
 5 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index c272461d70a9..64a989cbc301 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -887,3 +887,21 @@ int amdgpu_amdkfd_unmap_hiq(struct amdgpu_device *adev, u32 doorbell_off,
 
 	return r;
 }
+
+/* Stop scheduling on KFD */
+int amdgpu_amdkfd_stop_sched(struct amdgpu_device *adev, uint32_t node_id)
+{
+	if (!adev->kfd.init_complete)
+		return 0;
+
+	return kgd2kfd_stop_sched(adev->kfd.dev, node_id);
+}
+
+/* Start scheduling on KFD */
+int amdgpu_amdkfd_start_sched(struct amdgpu_device *adev, uint32_t node_id)
+{
+	if (!adev->kfd.init_complete)
+		return 0;
+
+	return kgd2kfd_start_sched(adev->kfd.dev, node_id);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 4ed49265c764..825c7ffe4bc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -264,6 +264,8 @@ int amdgpu_amdkfd_send_close_event_drain_irq(struct amdgpu_device *adev,
 					uint32_t *payload);
 int amdgpu_amdkfd_unmap_hiq(struct amdgpu_device *adev, u32 doorbell_off,
 				u32 inst);
+int amdgpu_amdkfd_start_sched(struct amdgpu_device *adev, uint32_t node_id);
+int amdgpu_amdkfd_stop_sched(struct amdgpu_device *adev, uint32_t node_id);
 
 /* Read user wptr from a specified user address space with page fault
  * disabled. The memory must be pinned and mapped to the hardware when
@@ -426,6 +428,8 @@ void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd);
 void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint64_t throttle_bitmask);
 int kgd2kfd_check_and_lock_kfd(void);
 void kgd2kfd_unlock_kfd(void);
+int kgd2kfd_start_sched(struct kfd_dev *kfd, uint32_t node_id);
+int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id);
 #else
 static inline int kgd2kfd_init(void)
 {
@@ -496,5 +500,15 @@ static inline int kgd2kfd_check_and_lock_kfd(void)
 static inline void kgd2kfd_unlock_kfd(void)
 {
 }
+
+static inline int kgd2kfd_start_sched(struct kfd_dev *kfd, uint32_t node_id)
+{
+	return 0;
+}
+
+static inline int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id)
+{
+	return 0;
+}
 #endif
 #endif /* AMDGPU_AMDKFD_H_INCLUDED */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index c2d2598f776c..fad1c8f2bc83 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1446,6 +1446,45 @@ void kgd2kfd_unlock_kfd(void)
 	mutex_unlock(&kfd_processes_mutex);
 }
 
+int kgd2kfd_start_sched(struct kfd_dev *kfd, uint32_t node_id)
+{
+	struct kfd_node *node;
+	int ret;
+
+	if (!kfd->init_complete)
+		return 0;
+
+	if (node_id >= kfd->num_nodes) {
+		dev_warn(kfd->adev->dev, "Invalid node ID: %u exceeds %u\n",
+			 node_id, kfd->num_nodes - 1);
+		return -EINVAL;
+	}
+	node = kfd->nodes[node_id];
+
+	ret = node->dqm->ops.unhalt(node->dqm);
+	if (ret)
+		dev_err(kfd_device, "Error in starting scheduler\n");
+
+	return ret;
+}
+
+int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id)
+{
+	struct kfd_node *node;
+
+	if (!kfd->init_complete)
+		return 0;
+
+	if (node_id >= kfd->num_nodes) {
+		dev_warn(kfd->adev->dev, "Invalid node ID: %u exceeds %u\n",
+			 node_id, kfd->num_nodes - 1);
+		return -EINVAL;
+	}
+
+	node = kfd->nodes[node_id];
+	return node->dqm->ops.halt(node->dqm);
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 /* This function will send a package to HIQ to hang the HWS
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index f6e211070299..d23388ea8181 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1679,6 +1679,60 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
 	return 0;
 }
 
+/* halt_cpsch:
+ * Unmap queues so the schedule doesn't continue remaining jobs in the queue.
+ * Then set dqm->sched_halt so queues don't map to runlist until unhalt_cpsch
+ * is called.
+ */
+static int halt_cpsch(struct device_queue_manager *dqm)
+{
+	int ret = 0;
+
+	dqm_lock(dqm);
+	if (!dqm->sched_running) {
+		dqm_unlock(dqm);
+		return 0;
+	}
+
+	WARN_ONCE(dqm->sched_halt, "Scheduling is already on halt\n");
+
+	if (!dqm->is_hws_hang) {
+		if (!dqm->dev->kfd->shared_resources.enable_mes)
+			ret = unmap_queues_cpsch(dqm,
+						 KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0,
+				USE_DEFAULT_GRACE_PERIOD, false);
+		else
+			ret = remove_all_queues_mes(dqm);
+	}
+	dqm->sched_halt = true;
+	dqm_unlock(dqm);
+
+	return ret;
+}
+
+/* unhalt_cpsch
+ * Unset dqm->sched_halt and map queues back to runlist
+ */
+static int unhalt_cpsch(struct device_queue_manager *dqm)
+{
+	int ret = 0;
+
+	dqm_lock(dqm);
+	if (!dqm->sched_running || !dqm->sched_halt) {
+		WARN_ONCE(!dqm->sched_halt, "Scheduling is not on halt.\n");
+		dqm_unlock(dqm);
+		return 0;
+	}
+	dqm->sched_halt = false;
+	if (!dqm->dev->kfd->shared_resources.enable_mes)
+		ret = execute_queues_cpsch(dqm,
+					   KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES,
+			0, USE_DEFAULT_GRACE_PERIOD);
+	dqm_unlock(dqm);
+
+	return ret;
+}
+
 static int start_cpsch(struct device_queue_manager *dqm)
 {
 	struct device *dev = dqm->dev->adev->dev;
@@ -1984,7 +2038,7 @@ static int map_queues_cpsch(struct device_queue_manager *dqm)
 	struct device *dev = dqm->dev->adev->dev;
 	int retval;
 
-	if (!dqm->sched_running)
+	if (!dqm->sched_running || dqm->sched_halt)
 		return 0;
 	if (dqm->active_queue_count <= 0 || dqm->processes_count <= 0)
 		return 0;
@@ -2727,6 +2781,8 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
 		dqm->ops.initialize = initialize_cpsch;
 		dqm->ops.start = start_cpsch;
 		dqm->ops.stop = stop_cpsch;
+		dqm->ops.halt = halt_cpsch;
+		dqm->ops.unhalt = unhalt_cpsch;
 		dqm->ops.destroy_queue = destroy_queue_cpsch;
 		dqm->ops.update_queue = update_queue;
 		dqm->ops.register_process = register_process;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index dfb36a246637..08b40826ad1e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -106,6 +106,12 @@ union GRBM_GFX_INDEX_BITS {
  * @uninitialize: Destroys all the device queue manager resources allocated in
  * initialize routine.
  *
+ * @halt: This routine unmaps queues from runlist and set halt status to true
+ * so no more queues will be mapped to runlist until unhalt.
+ *
+ * @unhalt: This routine unset halt status to flase and maps queues back to
+ * runlist.
+ *
  * @create_kernel_queue: Creates kernel queue. Used for debug queue.
  *
  * @destroy_kernel_queue: Destroys kernel queue. Used for debug queue.
@@ -153,6 +159,8 @@ struct device_queue_manager_ops {
 	int	(*start)(struct device_queue_manager *dqm);
 	int	(*stop)(struct device_queue_manager *dqm);
 	void	(*uninitialize)(struct device_queue_manager *dqm);
+	int     (*halt)(struct device_queue_manager *dqm);
+	int     (*unhalt)(struct device_queue_manager *dqm);
 	int	(*create_kernel_queue)(struct device_queue_manager *dqm,
 					struct kernel_queue *kq,
 					struct qcm_process_device *qpd);
@@ -264,6 +272,7 @@ struct device_queue_manager {
 	struct work_struct	hw_exception_work;
 	struct kfd_mem_obj	hiq_sdma_mqd;
 	bool			sched_running;
+	bool			sched_halt;
 
 	/* used for GFX 9.4.3 only */
 	uint32_t		current_logical_xcc_start;
-- 
2.46.0

