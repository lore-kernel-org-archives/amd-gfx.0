Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B9ED25955
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 07:19:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6187410E4C3;
	Tue, 27 Jan 2026 07:19:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ohV5xr1E";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012026.outbound.protection.outlook.com [52.101.43.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3510710E4C3
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 07:19:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chjC/LgeLVh7fKB4rtEtrk+N4Cn95pmZpgHnyADXacsl3s1BFjwLLQ7M7e6nf1Kn+BkweUQbP+3CNpZrxHiBGVjS3mjBg95kFxVBHp2ze5esGyy+7HvCzA620yJn9BrXfuBJ31mLKk9l5cd8ykUjoUVQ9yRqSIdIMhCvrkQQTVXmtmZgKBBbpdvU/WrekT3+u6YyRfohUdJ6sJNeuAyRBWT21CKD8Tt5PsvcXJ22B1a9NoJkgO8R1xvwGhDNE0N/4YZ9X4qL/zsnKU0fE1foy16E3SbknThkxd1DxqOwSMz2pRfz2zkUbm97pFw/9wrpsU/j68gDt0FfzeFjIeWsWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTqFP2dGjc4058Paojkka2eLQeUgalWLAe409BzLjJc=;
 b=K+4COXWY/Ie9U55ejzrWokN/JKNu6TmV5XEkSbv8rGLJJI1ExZjC3yXSdLAXv3y6T9A1HQukYSCNFgu6XRyjLZcxmV+pKq2nBbg9c7rukwr+ceEBtnmXeYy+jaumQPmfda48h3ZvbUda2sO8t5/WCrkrmCC2tAOWNfUfXuouqjyzWZQD7bGLFWwDhDgGIvNvim7mzpD08OoBwvUAUo3fcTbdncOvNsS+bVOBy9lkiav2P9mEaqnNddRKN0nJXUqi8IPsbH8Oo6pRoGUIKeDoOEJxbRqEO+7/ftT6dqutPIN14uXoRmiVA/3coOUuP6rywYAotn4INn5Cl6zayN4M6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTqFP2dGjc4058Paojkka2eLQeUgalWLAe409BzLjJc=;
 b=ohV5xr1EDRKQXfNuwzKyMwM2rfQP2DDrtmJlCkPnmY0c02sdWlsV1ZNlm+wWkQWRElp2D4BwsGhcrDqz+L0HtLWKD1ajv5K0Ky4OZRqzpCx6rsuTvtc0L7aLoFfrr6Y+KRyJu22zFZIachHi699CtKc/9Gua3FlMUnOIFF6/6AM=
Received: from DM6PR21CA0025.namprd21.prod.outlook.com (2603:10b6:5:174::35)
 by MN2PR12MB4160.namprd12.prod.outlook.com (2603:10b6:208:19a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 07:19:15 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:174:cafe::b3) by DM6PR21CA0025.outlook.office365.com
 (2603:10b6:5:174::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.1 via Frontend Transport; Tue,
 27 Jan 2026 07:19:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 07:19:15 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 01:19:13 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 01:19:12 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Mon, 26 Jan 2026 23:19:01 -0800
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v3 6/6] drm/amdgpu: add MODIFY operation for compute queues
Date: Tue, 27 Jan 2026 15:17:28 +0800
Message-ID: <20260127071800.2395621-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127071800.2395621-1-Jesse.Zhang@amd.com>
References: <20260127071800.2395621-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|MN2PR12MB4160:EE_
X-MS-Office365-Filtering-Correlation-Id: 42877791-128b-42a5-96da-08de5d7460a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5jbDEAFiG6tnrxoih8bYAY2U9vbTB9s68YuV2lo0hJzAjBQplcJU7mupkbBp?=
 =?us-ascii?Q?nJUgYyn8SeXfIZcZ0SrlwHx1izHp3Y0Mb9lYVYRV9/goAj0oxmPpSsjJw+E9?=
 =?us-ascii?Q?uBDg/4QFxlvpvWDaz/90cCpx7KC7IkXWW3VNRJg+iJGVeNeQWcGgisfqKMMA?=
 =?us-ascii?Q?fm6QGIvyUsaU1szv8BvObRKTgbPAEVwHL+uoReVuIMUR+w+NX+xRigwZ4ErE?=
 =?us-ascii?Q?4Eo4BlV1oxXzaRM8yPaFluEd6OVIeO9n6+6tECzlZfDl/1jT5zthnPbCSn2l?=
 =?us-ascii?Q?r1WOt//1jHMPn4sytsMu9dyqPfHeQJggwhuR7QwnntgqhuYuOPTc8rS9zOnT?=
 =?us-ascii?Q?dVrvIk6uEVaavdffb/i5KlPUC+dCsECy29fNuw3HEOvLFeqWwQTOXcmftGfq?=
 =?us-ascii?Q?ws81Sp4+FTACY1g/NF2mMECys3x4woHc/qWagRIx8YJPajr4kpgNQKdCTQ5v?=
 =?us-ascii?Q?CJukFOVaMJnrTufsOlBU5MKYg270fZAsEU4mnQIb/SrhOmJ2vya9IYe4/wpn?=
 =?us-ascii?Q?M0ojC8LDPt23taLj+SaNYaUZJND46CqBPTno3G6D51yCmcfNJ6alnJmIYIOA?=
 =?us-ascii?Q?isydac24PT9LVXeMc105y6ltytCowPlg9NyuqGTI9tS4rGO6tb7xCQii18R0?=
 =?us-ascii?Q?JtsvmU0gJfPqXWSdhoSu1mMJ+M4VQiKQFkGth6wAsYQVND4fzbr0tOGjWFY2?=
 =?us-ascii?Q?7+6gzFe9FD3ll9X3H4sqqVKTFzowheHS/bn/tudgyG+zWtnyi2HKytIIsaXi?=
 =?us-ascii?Q?zgpS31ccoAKNfXnVElMeZo+zq0HvrXBUmPOIQk0ex7JQbYVgPID1oKC2faHM?=
 =?us-ascii?Q?I3qpK2DTM0U0QsAvdAhbmECvbKtfnb9whaRIlL5+bF5DDAK7ToerW4ogEuFA?=
 =?us-ascii?Q?DZiusxgTsLXuOAnrwNqoS/nUOrlCTb1jP13eevn32D2mYT/xRU6bxE96S4js?=
 =?us-ascii?Q?DFsaPabNhJAMD6T7JJw1tH1x6EnLKpkOesh0LdtwOW5+NlzDDdjADA8dtW58?=
 =?us-ascii?Q?WRhFY6uGdERK+RON7GtJnfij90TG67tb3kIoIefefELP129moJsxQnXR0wcv?=
 =?us-ascii?Q?HY79XM0jPM9JGN1+fc81VZGPeKHxpW2AJ6QK+ziiCCKgDP43z/TbfLbshE1t?=
 =?us-ascii?Q?wfIsWhQwI78thFOs5ql+PgRVjyyVPVYTl83PKsrDMVt2tx4uxr1aCZA3rVJ+?=
 =?us-ascii?Q?BP1PcuIZfDvcsSqQ/+orDjUlqRdfLKwDQGlG9LHuEyhTJ87PGn/O7fdDO7Nq?=
 =?us-ascii?Q?6pxQSNEOEqqo0WSSlOIBV++glcTcwXVFWbn6SZi9B41wcK2SGjWyPbwN8L3d?=
 =?us-ascii?Q?GQi5cYSSf9P1aHZr8pNjoch71Cpe6MSggX99gydZX8pPofVsJ2pzcjRulDhp?=
 =?us-ascii?Q?ONbZ9mm9BoOQ7kiwlU+n9T6Efk4uN30IK+v2l+FX9aC+WlJEnQu3/w7R+w+z?=
 =?us-ascii?Q?zqkQkYhSrW2JKp/8RuRYlScPEfK0GNsb8m9i56QvQ/eVBP74H0MpjgUntS/I?=
 =?us-ascii?Q?DQboMKudtvUVsYSu89Yu49MJOiCOPr993v6bOr24iPcEaoqT8pUhGt147kG6?=
 =?us-ascii?Q?whnspXhBz6MMNVxOUd6MpTbQZTi+537G8yKYuh5IB/3NYdm9LDVTLjl1rMw8?=
 =?us-ascii?Q?r8dmvgQR9HYkPmna6DEyLYktoqn5Ll533kQTwxmucGrltsBI6MvJTvt1QfYk?=
 =?us-ascii?Q?jBgwag=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 07:19:15.1435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42877791-128b-42a5-96da-08de5d7460a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4160
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

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 78 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  3 +
 2 files changed, 81 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 256ceca6d429..eb1e27c27bde 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -837,6 +837,7 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 
 	switch (args->in.op) {
 	case AMDGPU_USERQ_OP_CREATE:
+	case AMDGPU_USERQ_OP_MODIFY:
 		if (args->in.flags & ~(AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK |
 				       AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE))
 			return -EINVAL;
@@ -863,10 +864,29 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 			drm_file_err(filp, "invalidate userq queue va or size\n");
 			return -EINVAL;
 		}
+
+		if (!is_power_of_2(args->in.queue_size) && (args->in.queue_size != 0)) {
+			drm_file_err(filp, "Ring size must be a power of 2 or 0\n");
+			return -EINVAL;
+		}
+
+		if (args->in.queue_size > 0 && args->in.queue_size < AMDGPU_GPU_PAGE_SIZE) {
+			args->in.queue_size = AMDGPU_GPU_PAGE_SIZE;
+			drm_file_err(filp, "Size clamped to AMDGPU_GPU_PAGE_SIZE\n");
+		}
+
+		if ((args->in.queue_va) &&
+			(!access_ok((const void __user *) args->in.queue_va,
+				sizeof(uint64_t)))) {
+			drm_file_err(filp, "Can't access ring base address\n");
+			return -EFAULT;
+		}
+
 		if (!args->in.wptr_va || !args->in.rptr_va) {
 			drm_file_err(filp, "invalidate userq queue rptr or wptr\n");
 			return -EINVAL;
 		}
+
 		break;
 	case AMDGPU_USERQ_OP_FREE:
 		if (args->in.ip_type ||
@@ -901,6 +921,58 @@ bool amdgpu_userq_enabled(struct drm_device *dev)
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
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+
+	if (queue->queue_type != AMDGPU_HW_IP_COMPUTE)
+		return -EOPNOTSUPP;
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
+		if (r)
+			return r;
+	}
+
+	r = userq_funcs->mqd_update(queue, &args->in);
+	if (r)
+		return r;
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
+	mutex_unlock(&uq_mgr->userq_mutex);
+
+	return r;
+}
+
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		       struct drm_file *filp)
 {
@@ -920,6 +992,12 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
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
-- 
2.49.0

