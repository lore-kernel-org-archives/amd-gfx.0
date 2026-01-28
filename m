Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7DDD35693
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 11:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A447110E656;
	Wed, 28 Jan 2026 11:00:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hw/lU91X";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012032.outbound.protection.outlook.com [52.101.43.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00BC610E654
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 11:00:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqHS392BGBpd/FuflBmw5zNmvpUYHLftANg2Hta+HCuZhPIUf/zZRG/IANUxq62KtvkpUrKVZEsjsRsTdpKkZMvSsl3ymdOyPt7Tw1mHVkcOWTY7h//ICvdMuryRd6HHAzMsBlwX7GtgTLVsLo6YWFCMyurMtt0K1dfBuFBvNfUC6fJNLsf5cNGHs++vFS0jkCAJEi7lNHnmOjbZyfHnbDMR6NqdAXpRY+9+mOP4jOAfUnHiqiN2c9qScsD7L+wxvQ0E94ksiJ68mIMsUXG43fnIaIMfS7+kMEh4HvkV/GpEyakFVyi3sUZHhkN0r+nBOVk8oLfde84AGo3vlu8BrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fO908187YWO5W5uICJzXNJwPZ6WupCN4jDjf9WT/UGQ=;
 b=A57cegf4SQD21ic8QTxKDRASVSLpJky+Ve0h5i7d8fFz+uwrkhSx23Dy+FkR4hqONYcEAq52j7g54uy3Ge+updUIOdz17HbmGMr0YCfnmgvPBpLXH1Iywo8TAT2CG9lzpQCMXxfIHHTe5jeYJD3Mv5Qo4OZzsrQcRGdweuupckLukUoSysi0wN9yPVLU6yTtnaf9H04xWuoikjBxUgMGzUDBkSebwcUj+WLYogsWPARjdQJMaPC0Lz+4ZGfjUYSV4ouJ75m+IYI6p5hBs1NUd6n8xc+VznZ3M4J5hgZ1nyJFCMFm8OIPkAkDy2LtOwkmJUx64svPxLXtzCF+HCqoeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fO908187YWO5W5uICJzXNJwPZ6WupCN4jDjf9WT/UGQ=;
 b=Hw/lU91X2hpOfmPDqx3p0drAjW5XoclG9K2BTw2JXERImH0A638V489SRMKtQ6zbkRuxTtQ5g1nH/WG9Qq4et5O/frh5FbD3BZDLhmjQdioOlnhvR3tN2I3mNqrzH+2VGyGIgerx29ZmpwuovFMkE8XzpDsJO8/9h7rPD2NZ0OU=
Received: from CH5PR02CA0002.namprd02.prod.outlook.com (2603:10b6:610:1ed::14)
 by DM4PR12MB6064.namprd12.prod.outlook.com (2603:10b6:8:af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 11:00:01 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::2c) by CH5PR02CA0002.outlook.office365.com
 (2603:10b6:610:1ed::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Wed,
 28 Jan 2026 11:00:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 11:00:00 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 28 Jan
 2026 05:00:00 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 28 Jan
 2026 04:59:59 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 28 Jan 2026 02:59:48 -0800
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v4 6/6] drm/amdgpu: add MODIFY operation for compute queues
Date: Wed, 28 Jan 2026 18:58:29 +0800
Message-ID: <20260128105847.2898288-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260128105847.2898288-1-Jesse.Zhang@amd.com>
References: <20260128105847.2898288-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|DM4PR12MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c6d5da9-6287-42d6-49a9-08de5e5c61fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AbfMSRFp/kK27JqqnGWPyTnL5apE0O03BJPas6VJudf2WYusVHUqjWv8qWZ2?=
 =?us-ascii?Q?ctrHP1W8WUv/144HM61jTpOM1xvQ22JkXORC6H66uwwBUL1gUxKwHXMFV2/D?=
 =?us-ascii?Q?LO4HWioNS9zscNiENTZQS/Fyec2aV8vIaW4CMcTU8qbk8vZo5CPYrf1PmI5S?=
 =?us-ascii?Q?82QpJCFKDz/cNLYZ5bD8OARU8Jpzu3VHv5IdhqURM9lY28NOcwe1K/TSuyjj?=
 =?us-ascii?Q?oV1GZcAD+DtxryytvWCG9OBsrJcarFm5F4RA02gKxbTneBa+RWl8xW+hxk/A?=
 =?us-ascii?Q?jbukkp9dnnjUg89WqyMBmfbI0w0TNOV5hTG2j/Nnx1WP2qgAt0f3wQd9Vnq9?=
 =?us-ascii?Q?NyofffJ7DHu/8Ybu4nZJKqvmvp65DJJ3Etn9SsnLnMSgbuGQsF+4XfjLlAs0?=
 =?us-ascii?Q?hNCo0E+OJIsjX9ebWgRWlN4sm2rAlIBuaCDuEbnkfFSyPaKzstlOehRKJ2g7?=
 =?us-ascii?Q?T6CCQ1QhemN895m6HPqGeqcU10V+Sx6p7+XRc0LRpW6cILVu1deZv0kjThy8?=
 =?us-ascii?Q?2zqX/YIC/FatToInl+l9ccqiyvfN2lWQ3APqCeAYIDJdT27aew2qjaRi5DDW?=
 =?us-ascii?Q?WlDoHst3UW0abAmthiYyz2dcDQ2o2P/6qn45RwRVR+uFMBfTvPmfBhyEX9HD?=
 =?us-ascii?Q?JrMnkfPqMkNAOuMRnDAaC7c9YLjHZ2plMmeYsr7elM8TzOf/bQTxI0HyN24i?=
 =?us-ascii?Q?nD8spDRUnnOlU2c00JdrofW+2fXhg5cBO01zU6Owd5i7X94l/cP5KcuidlmN?=
 =?us-ascii?Q?ilXk+UdpIkE3aOUqXw0qoar9bMVVi+V2J98EvuHWSHfJBSJk5YhGdADjkTtC?=
 =?us-ascii?Q?Oxe4WheFgKHp+Y5EpPKTmdmAWb77Wr9Wyk2J0dJOfb9J+jvsr0CVKTO/34+q?=
 =?us-ascii?Q?7KffJd+yphoe3JvCsZrcQsHWCACcFfGA2iekXL8uhvVvQczSgc5c8Mu/VU32?=
 =?us-ascii?Q?IlMBzWmsQnjLdkIKnF8uMNm9h3gqZMIsKgOdbWYn8JEvDIoLDmwZjio90HsT?=
 =?us-ascii?Q?7AqEbvh8IooBZzcrFJ7F+aNQ5beListo4M6EPz6L5A+DPQER5IxRVH/fJ0l7?=
 =?us-ascii?Q?N9QbdKYPGnyNfTcmtcCssoGORe3FkrcOwb/abfY6vS/dSquiXg2azndaJhdo?=
 =?us-ascii?Q?sCrThFRuWS4HakaS4n5ULvAksRIYxeoo2zFvToyBleuzOqqR+DbmGu5QCIVe?=
 =?us-ascii?Q?nqnivAwsyFh3j1mlA1ZqU/zTph9ydMibEx8rmXHLAkM5veXSlpuHL50RInbB?=
 =?us-ascii?Q?vgWj/xY0YsW2w5jRuo2a83x4WSbW88VLRwTFyLcZhOeQXIQSmDc5yW2BVyBc?=
 =?us-ascii?Q?tkbyWZz8Qjqz3E0slpGqKffdIwOL7zixeNHwVr+95k5lWngDwoe1++Y68Mkx?=
 =?us-ascii?Q?Zt3XpEg2h191lKLexfmfgCLPGRhPwJF0oVwfNbcVqauzSwUTZs/UUDQcuhIW?=
 =?us-ascii?Q?nXCEUlkNE5NyjHQnXtFuLn+8aYjRTOSKuu+wddIoqcmWbB+ZMj1M9Kz/VT3Q?=
 =?us-ascii?Q?Iw0jbmyJtAvd629i+aheBal44gTwjSWW6l6uCY+bNZuK2KbWZO5ylLhkyjLb?=
 =?us-ascii?Q?M04NWrplxXK4uXH8QIl9zlj8gBpC6Z0+HV/Se6JZXK2mCEhaCf7t3mmfKyPf?=
 =?us-ascii?Q?l7/lr6JXoCJuQxJVsbfFcDaIrf9sqNONjJYv2qtSUC5c3isytHL2vW59KOl0?=
 =?us-ascii?Q?TGZ7lg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 11:00:00.6505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6d5da9-6287-42d6-49a9-08de5e5c61fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6064
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

Implement the AMDGPU_USERQ_OP_MODIFY ioctl operation to enable runtime updates
of compute queues.

v2: move queue size validate to a separate patch
    remove the check for AMDGPU_HW_IP_COMPUTE  (Alex)

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 61 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  3 ++
 include/uapi/drm/amdgpu_drm.h             |  1 +
 3 files changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 256ceca6d429..3003aba22e1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -837,6 +837,7 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 
 	switch (args->in.op) {
 	case AMDGPU_USERQ_OP_CREATE:
+	case AMDGPU_USERQ_OP_MODIFY:
 		if (args->in.flags & ~(AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK |
 				       AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE))
 			return -EINVAL;
@@ -901,6 +902,60 @@ bool amdgpu_userq_enabled(struct drm_device *dev)
 	return false;
 }
 
+static int amdgpu_modify_queue(struct drm_file *filp, union drm_amdgpu_userq *args)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_usermode_queue *queue;
+	const struct amdgpu_userq_funcs *userq_funcs;
+	int r;
+
+	mutex_lock(&uq_mgr->userq_mutex);
+	queue = amdgpu_userq_find(uq_mgr, args->in.queue_id);
+	if (!queue) {
+		drm_file_err(uq_mgr->file, "Queue %u not found\n", args->in.queue_id);
+		r = -EINVAL;
+		goto unlock;
+	}
+
+	userq_funcs = adev->userq_funcs[queue->queue_type];
+
+	/*
+	 * Unmap the queue if it's mapped or preempted to ensure a clean update.
+	 * If the queue is already unmapped or hung, we skip this step.
+	 */
+	if (queue->state == AMDGPU_USERQ_STATE_MAPPED ||
+	    queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
+		r = amdgpu_userq_unmap_helper(queue);
+		if (r) {
+			drm_file_err(uq_mgr->file, "Failed to unmap queue %llu\n",
+					queue->doorbell_index);
+			goto unlock;
+		}
+	}
+
+	r = userq_funcs->mqd_update(queue, &args->in);
+	if (r)
+		goto unlock;
+	/*
+	 * If the queue is considered active (has valid size, address, and percentage),
+	 * we attempt to map it. This effectively starts the queue or restarts it
+	 * if it was previously running.
+	 */
+	if (AMDGPU_USERQ_IS_ACTIVE(queue)) {
+		r = amdgpu_userq_map_helper(queue);
+		if (r)
+			drm_file_err(uq_mgr->file, "Failed to remap queue %llu after update\n",
+				queue->doorbell_index);
+	}
+
+unlock:
+	mutex_unlock(&uq_mgr->userq_mutex);
+
+	return r;
+}
+
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		       struct drm_file *filp)
 {
@@ -920,6 +975,12 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 			drm_file_err(filp, "Failed to create usermode queue\n");
 		break;
 
+
+	case AMDGPU_USERQ_OP_MODIFY:
+		r = amdgpu_modify_queue(filp, args);
+		if (r)
+			drm_file_err(filp, "Failed to modify usermode queue\n");
+		break;
 	case AMDGPU_USERQ_OP_FREE:
 		r = amdgpu_userq_destroy(filp, args->in.queue_id);
 		if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 833468b58603..7cd1ea94e368 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -31,6 +31,9 @@
 #define to_ev_fence(f) container_of(f, struct amdgpu_eviction_fence, base)
 #define uq_mgr_to_fpriv(u) container_of(u, struct amdgpu_fpriv, userq_mgr)
 #define work_to_uq_mgr(w, name) container_of(w, struct amdgpu_userq_mgr, name)
+#define AMDGPU_USERQ_IS_ACTIVE(q) ((q)->userq_prop->queue_size > 0 &&  \
+                           (q)->userq_prop->hqd_base_gpu_addr != 0 &&  \
+                           (q)->userq_prop->queue_percentage > 0)
 
 enum amdgpu_userq_state {
 	AMDGPU_USERQ_STATE_UNMAPPED = 0,
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index c52949ea8c1e..aa9b31578c6b 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -330,6 +330,7 @@ union drm_amdgpu_ctx {
 /* user queue IOCTL operations */
 #define AMDGPU_USERQ_OP_CREATE	1
 #define AMDGPU_USERQ_OP_FREE	2
+#define AMDGPU_USERQ_OP_MODIFY 3
 
 /* queue priority levels */
 /* low < normal low < normal high < high */
-- 
2.49.0

