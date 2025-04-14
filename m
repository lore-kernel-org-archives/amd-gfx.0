Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F0EC369B4
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 17:13:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53EBE10E636;
	Mon, 14 Apr 2025 17:13:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cd1ILpPz";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58D6810E634
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 17:13:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Io7cDRQ1RVckj6IjvF2h9AD/GAwieJlynYzfy4xe36KNhbkb8kdochdIQkcUGj33+rsSZuNggalJJ5r6Ofnefy9p0mEWmzbaSOdkRr9FrQmv1gkkEqSF/dlHFhJoBCsRaguILLpzlMwgmaWmi/LQb9gG/yeF0JU17zj5lMIVF2tsupZOxt1ANsj421fW/7Uzrydy6sN1AYOrP0UzU8KyuLh7ZKRaOL77rM1yzTZyWq08j/KG4MPR5pMG1y7iMpBbBIfPcGl4Xa5UobCI+w6kW4aRNK2rfRZCVRQAMbkZO/G/FLbT3Q4+2PySFtXyPtYKZUQY4osC3L0NxnB7Reh9bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4m58mAFfIu8UTc66Xkb8fTZ8Rb/vP6W7HoVZvybeLmM=;
 b=A+10VxE4Ksi9WsYnnj9eDxoRjLJprnCU32Fd6fOr78wi7dTmHNF97ic4XOgmBDlLh7Gxa9WH1iPJ5eIjBzYHElx3atmx5VwnjXefxoIqAe4fhVUfkK7OjOzkSVaX8rPu260Qss31HbWLhlo/cbe7k89CG9csqIIkYpyGB8nBmZxXcEUDMdfiP9opMo3KjRxuXpFJUzVlL+neng7c0T2xrE1bmkH3c3cqJAidJ+EXcjFldIC4KGnAqpL9yfHMd/QGhiuBQXfrgmU9pbbfI0cUzcI8Ko3SSKz5/ydPh/q+QQBU7POr0lWt3wD0P7qH0ED7JE24DahFwgogQmHUB5+f5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4m58mAFfIu8UTc66Xkb8fTZ8Rb/vP6W7HoVZvybeLmM=;
 b=cd1ILpPzSCkNURB0LAB5X6qKE39UH9HNoKWhI9GJYshNomEM0B1IzXwKxlBjxeXZiZk+a/dop0TUFILK6MnxOCGEB1Q30VyjyKarcdvUEsYSUIETvUkfwQiDkluR/fdYeK6xbzqiLg7HGsJK8beb5pqhQevq5oZqiOkadzzCWr0=
Received: from BL1PR13CA0322.namprd13.prod.outlook.com (2603:10b6:208:2c1::27)
 by CYXPR12MB9340.namprd12.prod.outlook.com (2603:10b6:930:e4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.30; Mon, 14 Apr
 2025 17:13:14 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::78) by BL1PR13CA0322.outlook.office365.com
 (2603:10b6:208:2c1::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.8 via Frontend Transport; Mon,
 14 Apr 2025 17:13:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 17:13:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 12:13:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 2/4] drm/amdgpu/userq: add helpers to start/stop scheduling
Date: Mon, 14 Apr 2025 13:12:57 -0400
Message-ID: <20250414171259.2996574-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414171259.2996574-1-alexander.deucher@amd.com>
References: <20250414171259.2996574-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|CYXPR12MB9340:EE_
X-MS-Office365-Filtering-Correlation-Id: f92bf878-374d-485b-1edf-08dd7b77a439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5nLi0A3ag9ZTgyamUhzmP5HVGaOZBXzpvb8KaaVaBdcRDY6Si5IayN1Lbfup?=
 =?us-ascii?Q?eUPGTo9RqXCrTujSvDNrpt7/3axDdJnYbY15HrPzA/E2GOuF8DcyufdZb3F8?=
 =?us-ascii?Q?OqNZVCJ8Qss6CfKBQN6DmEzPkCgCgydzf5vu2z1830/p6hAxHxRxmxqf35Or?=
 =?us-ascii?Q?OK0gclD1HdAS6Xq3gncPY2ZmQMfbU3I8SnfQEN64nYUuoHE3zH7yAMbHnMbi?=
 =?us-ascii?Q?BsWY5uKcldE5/IecXCqfuYEh0ysGeahUz+P8kzrVckjVcs53LVB89NJFXmEr?=
 =?us-ascii?Q?3stH+XTUjvkv5BBUprGjnBTAtgG43yxRSHVfBMaihG0EVVLlnaaYy8h8DLJY?=
 =?us-ascii?Q?62IetbyLnviBryAbfuET0qaxE5jI2cd3svsC24dV6ae8FVDBNwXa4dz41x3I?=
 =?us-ascii?Q?QlsJ7kbKGkfCS1UHyr7s+eybApy1sldEY1QbUyrFOE472dnHFlKwP2huuImY?=
 =?us-ascii?Q?vFm2ZujY/c7icLhlju7b5gtADSfDICboTb6LLD3oPh/rFDnrTO+kgg8y0snA?=
 =?us-ascii?Q?mhkP1QzNq5JZ8GEP7XaSw6+Q8fH5wWAkekZJ5jdUkxPHK+n9QnDf9DiKrIHS?=
 =?us-ascii?Q?TGUxnQvAk6AYLQNtowGwu1ARPlmzY8OlY/JbdI06xPr/qPtuDmRHOK5eDyi1?=
 =?us-ascii?Q?pOM3n6PLOWPMwYCWPNneHdgSkyBPGi9KoUGi/LRseh3aSEtl6c7S+EpMzqaU?=
 =?us-ascii?Q?CROsVEzEtTBINg4qNBRGmHcHQIlyfKbMtG4cUneQqttlE39CZF0ygtxEFRmN?=
 =?us-ascii?Q?6vGcfYM88E4MRc1Uf2UT+Kp7123qpjo5rzLp5j3NkCbo9iINerNWYS+PNjFh?=
 =?us-ascii?Q?IisM5gHnG7pAFKZAD0+60S/SW90anQyQ6yCxSeX9PUMMEkvUksJTpg2ZhXlg?=
 =?us-ascii?Q?kxaXdvtFGzg2mv8WWnUjf8tOptkwkR8FxBlJAz4hY1yHEFfWDhNdPybKaTzZ?=
 =?us-ascii?Q?rxO/txQ4s4by8cfToU6muWhIxYi6J7+RRg+90CzlQB2J24uTTXXaS1xvJPtH?=
 =?us-ascii?Q?3tkN7bZsJALLoxJu4GgFXE8TtKzhmS5jWrFmCK/K1F3CPY0UCTEb87R+E+hT?=
 =?us-ascii?Q?Ypku3UXh1ZJE+Q0WIW7OtcNJrQhnlLmItFJFv+b5Zm1RF+6uX5ajO1/AiAIE?=
 =?us-ascii?Q?+QmVFJhwVLMxlIg5Sx1XUI1skjB1VHu7n5nl6ousM+t0N77+MhpjdwI/YbyZ?=
 =?us-ascii?Q?yHlV8K70HV5860HqtxsTFNRjDWE2EqKotE9xs3wxtsgCEDhpr6w2j+kqs7vH?=
 =?us-ascii?Q?cBbztUj0YKwLm6CdS6yuQLG6uaA1hUkrBqX4t/b549YQH5iJWe3CTrWZV4EC?=
 =?us-ascii?Q?DKcaLpEEpwmx9VICOrBu/0sIpO3gYWTGx/+ZQKcviqm35XyfyISqL/xv1dDe?=
 =?us-ascii?Q?K1S4xNeQB7csFEMWJmfN5IFdvoWbNDoonEyUevc8/X/yAXCsDNnOVcHCHnc9?=
 =?us-ascii?Q?nMtjYZJ6iGEkgWN9r8oJVCdiBhH3/O5DyAsXF0vBz3La10LtigfJR5Pmhgg6?=
 =?us-ascii?Q?W2D1gllQ25rG7Srbjd0V/3nYMWVPA5cZbxzm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 17:13:14.2541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f92bf878-374d-485b-1edf-08dd7b77a439
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9340
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

This will be used to stop/start user queue scheduling for
example when switching between kernel and user queues when
enforce isolation is enabled.

v2: use idx

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 72 ++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h |  3 +
 3 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index b156e31ac86ac..30c485f529d17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1249,6 +1249,7 @@ struct amdgpu_device {
 
 	struct list_head		userq_mgr_list;
 	struct mutex                    userq_mutex;
+	bool                            userq_halt;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 1867520ba258e..9bcf81aa34f61 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -348,6 +348,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
+
 	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
 	if (qid < 0) {
 		DRM_ERROR("Failed to allocate a queue id\n");
@@ -358,15 +359,21 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
-	r = uq_funcs->map(uq_mgr, queue);
-	if (r) {
-		DRM_ERROR("Failed to map Queue\n");
-		idr_remove(&uq_mgr->userq_idr, qid);
-		amdgpu_userq_fence_driver_free(queue);
-		uq_funcs->mqd_destroy(uq_mgr, queue);
-		kfree(queue);
-		goto unlock;
+	/* don't map the queue if scheduling is halted */
+	mutex_lock(&adev->userq_mutex);
+	if (!adev->userq_halt) {
+		r = uq_funcs->map(uq_mgr, queue);
+		if (r) {
+			DRM_ERROR("Failed to map Queue\n");
+			mutex_unlock(&adev->userq_mutex);
+			idr_remove(&uq_mgr->userq_idr, qid);
+			amdgpu_userq_fence_driver_free(queue);
+			uq_funcs->mqd_destroy(uq_mgr, queue);
+			kfree(queue);
+			goto unlock;
+		}
 	}
+	mutex_unlock(&adev->userq_mutex);
 
 	args->out.queue_id = qid;
 
@@ -733,3 +740,52 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
 	mutex_unlock(&adev->userq_mutex);
 	return ret;
 }
+
+int amdgpu_userq_stop_sched(struct amdgpu_device *adev, u32 idx)
+{
+	const struct amdgpu_userq_funcs *userq_funcs;
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_mgr *uqm, *tmp;
+	int queue_id;
+	int ret = 0;
+
+	mutex_lock(&adev->userq_mutex);
+	if (adev->userq_halt)
+		dev_warn(adev->dev, "userq scheduling already stopped!\n");
+	adev->userq_halt = true;
+	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+		cancel_delayed_work_sync(&uqm->resume_work);
+		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
+			if (queue->xcp_id == idx) {
+				userq_funcs = adev->userq_funcs[queue->queue_type];
+				ret |= userq_funcs->unmap(uqm, queue);
+			}
+		}
+	}
+	mutex_unlock(&adev->userq_mutex);
+	return ret;
+}
+
+int amdgpu_userq_start_sched(struct amdgpu_device *adev, u32 idx)
+{
+	const struct amdgpu_userq_funcs *userq_funcs;
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_mgr *uqm, *tmp;
+	int queue_id;
+	int ret = 0;
+
+	mutex_lock(&adev->userq_mutex);
+	if (!adev->userq_halt)
+		dev_warn(adev->dev, "userq scheduling already started!\n");
+	adev->userq_halt = false;
+	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
+			if (queue->xcp_id == idx) {
+				userq_funcs = adev->userq_funcs[queue->queue_type];
+				ret |= userq_funcs->map(uqm, queue);
+			}
+		}
+	}
+	mutex_unlock(&adev->userq_mutex);
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
index db79141e1c1e0..f9e6c4b728930 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
@@ -115,4 +115,7 @@ uint64_t amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 int amdgpu_userq_suspend(struct amdgpu_device *adev);
 int amdgpu_userq_resume(struct amdgpu_device *adev);
 
+int amdgpu_userq_stop_sched(struct amdgpu_device *adev, u32 idx);
+int amdgpu_userq_start_sched(struct amdgpu_device *adev, u32 idx);
+
 #endif
-- 
2.49.0

