Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB16C52D6F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 08:39:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F9F810E5B3;
	Wed, 21 Aug 2024 08:39:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Os3PAPEO";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 289B010E5B2
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 08:39:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wk716lZJFlkqHcU3SpZ7GCcLlGfP8s99Czikr66OF9wFkyHcwMLtvZ3Dk5IKzqOvY+F/cVYH4r/0tQEeEqmXfcgJBIdRhkMVrVML6VKEMLHcHDks08myduezuK9ZFkj7oVJLbHL5Yl2nXvwWgwmQcVmIMmbr4jAlhojMTNiUABaEMNQIzlzY9SdyWa2Xzz9rAVotB9mLPuPILW7Hwh/OnxB+z/OuAsyi+Cc/Ls+TrOPu5C5v4Yp7soD3WnmxmzL0+tpfHbKppYUbZ2VGk8xlZw8EC0AimGf+AhmF3VQx4+HlA5cGikjh/bWn3xF4/TWz/3GrmX7dsTJhkUq8uSVrfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAmzTE9sGuloeMh43ao++L1xjDIwMzrKWczsBUBS9uQ=;
 b=kb2o/44VK2fuyysaibbm/53ySpkTwyK6sJRUfKe+MJ/v199FF+6nZTdLu47XafKnixEUJ+ZWKkBEZi/2DwHa2MDkmY8tw3Pcl/eprRTkVUlUwFT3XzsPpy85gBy+KJHBZspEa9zyVc3I66+vjLqt4Cevpwu1vJNSx0cCECjtGwMTz/nZTJuzkgTrZoEAAWN6udd5KfuqmK4vFSEyzpFpnGeB6Z8kM7yAXGxCJZ3OUhByis8jYJfekCgzd8jWxBM9QLHmw8LeOMZOp/fbHmnfsIev1i6+Aac+SoSnyfp/I2mH3jyjb+WL2vG1ApUJTHkLOQwEERtE9SyRiG7gfThd+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAmzTE9sGuloeMh43ao++L1xjDIwMzrKWczsBUBS9uQ=;
 b=Os3PAPEOSnKtMpmOQcQu9jDvs6WH4dpkpoemE6ZmVWdEkXBK3WbTbhqqm6aWRxUbDUwCIhwJjRks7mGEUdQQrAeNO6U4lusWEvIpiQlt3PKJa0dW6dzXTK5i7d2seARWS8ZRIwc7sdjIMLgD0/XSlCPXPdaLM2t3lYZFTfXEpKE=
Received: from DS7PR03CA0324.namprd03.prod.outlook.com (2603:10b6:8:2b::24) by
 PH8PR12MB6988.namprd12.prod.outlook.com (2603:10b6:510:1bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Wed, 21 Aug
 2024 08:39:48 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:8:2b:cafe::86) by DS7PR03CA0324.outlook.office365.com
 (2603:10b6:8:2b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16 via Frontend
 Transport; Wed, 21 Aug 2024 08:39:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 08:39:47 +0000
Received: from lps-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 03:39:45 -0500
From: <Trigger.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <sunil.khatri@amd.com>, <alexander.deucher@amd.com>, Trigger Huang
 <Trigger.Huang@amd.com>
Subject: [PATCH v4 2/2] drm/amdgpu: Do core dump immediately when job tmo
Date: Wed, 21 Aug 2024 16:38:41 +0800
Message-ID: <20240821083841.477392-3-Trigger.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821083841.477392-1-Trigger.Huang@amd.com>
References: <20240821083841.477392-1-Trigger.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|PH8PR12MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4a3b22-c1d9-44b2-a52f-08dcc1bcd0ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?raL9DeKZn/FjUtJSyLqA7YUJ6BndDuoy51B+zsw8JgmrSQqgDL8gqRuF27hP?=
 =?us-ascii?Q?bT6cEbadXLdPzfyz0c0D70TDa91CvWxIUQ6G2hyJtqY/a9/+AFoTbDVazNkn?=
 =?us-ascii?Q?U1Hk+lVmZuD50S56EWutuBlAjADhvLmzcIbzDSddLC3Twow00NPhTyA4Fvk/?=
 =?us-ascii?Q?i6A0moOLoRi8cJ6RGWYhM9XMb8MiIVCPUGbjOqkNFrd3ubW4UFWAXgI1wH3Y?=
 =?us-ascii?Q?6De9CFZuMFmn43FBQR6/9FNGZVRQD+n6+idhfXbMA7cegA6/d/nxUHEcmirS?=
 =?us-ascii?Q?sXlTlIqGwK6x3MKECdYoj2lOoPfDHeh/plkaTKec/ohFvkgHJbtCRzRRa+05?=
 =?us-ascii?Q?by0rFs9tXREl25t5ZvwOkinDA/h3r1+GXpb4+KOLRIh6QlkZCAw9bx8Emq/7?=
 =?us-ascii?Q?TH3OHQ8flkPb4vxIQxDlQYIW32Vv904uuIACeaA+/1yil4KfXEI8dmDsFqJT?=
 =?us-ascii?Q?q1L9Ca8XNJkxWjhMgQu0tXkIAyEDuIf9d/zAlXzdpS61y6vRb7n0ZBu7D95i?=
 =?us-ascii?Q?a9ng2zl642z1NPaxsKAK4+zbM8sorLQyTR/ImwB84AyxFZNVtMdpkGR/uZCo?=
 =?us-ascii?Q?fBAkeVavzE8PHdE6S5mMoGFaXqv5GB9doIj7Os2dePFPW0FQhKl9VRty0YUC?=
 =?us-ascii?Q?X0rqra9LG/nT0q3dqmfb4qSGLaX1JFz9s7pVT5JB27LEgRjga9YjfCFp+HuO?=
 =?us-ascii?Q?rYnYvQMdeuVjptPr7S+08E+XEaUeO1ELN3kZLdzZYL4Q4zbH02P0tr4ENBog?=
 =?us-ascii?Q?pXAZVtmcdiaWverfggnjPOdY6/dYjcqtMbeAftKUHtVfKyVHowTQMlAP6eCO?=
 =?us-ascii?Q?qKnrQ79apOA4xj9Grx+X5tysStY5psjWDc55L9VK3mbgfmGWoOfmuH0YK6w4?=
 =?us-ascii?Q?w1E8ZcsOgb8G5C/IJJjaPJrdbn7yVLe5TUsDdt1XNu2p43b0h+qF5gZueNmF?=
 =?us-ascii?Q?M2dFAY6HFmkIHCpGzL9Mtbigw0KyFT3Kz9CRhw4cUKJJAltYNYHOHTMEygR2?=
 =?us-ascii?Q?X0Ey798mtZ4JZ5PsRtwPql3HUbmir1hQp5XXfWAxOu0njpe5r+Gr8wAFUGck?=
 =?us-ascii?Q?f9z25pWJZ8xFcsLfZvuMsjxYKJ5dHdEKN/CSfp3Z5F3DNTGZBz5kPK77joL5?=
 =?us-ascii?Q?Uzcl7gyQps9nNNWuvo2qcZMn9lfFJ6BDDdp8j0Q2vrpg+Ru7FYVcyGC8EqMd?=
 =?us-ascii?Q?v6G5SZItnvN+7doSkaWMvPVYRAbAbkb7Su0OAWy9devT1JrnNaH8WK9pNtnP?=
 =?us-ascii?Q?ALOBNaTvcgjOD9/UpGwRwIu6MGnGePE1ddins3a3MgFw28Hw1IkEAxStMFUG?=
 =?us-ascii?Q?fe7aC2HlXZNSLFGaOEjAJx9BqR/dczMEkpQnOBx3tK7pfRS/ukjCoOC0c7+L?=
 =?us-ascii?Q?/o8Fg5iZrr5Av0UsBaDbLJYHsyWA/cWq+I0j0eVdqgQqAx/3aoZzsythHoFB?=
 =?us-ascii?Q?1J72IrmhlQK4e8QTlC7I8UzM2JD2nW1+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 08:39:47.8110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4a3b22-c1d9-44b2-a52f-08dcc1bcd0ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6988
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

From: Trigger Huang <Trigger.Huang@amd.com>

Do the coredump immediately after a job timeout to get a closer
representation of GPU's error status.

V2: This will skip printing vram_lost as the GPU reset is not
happened yet (Alex)

V3: Unconditionally call the core dump as we care about all the reset
functions(soft-recovery and queue reset and full adapter reset, Alex)

V4: Do the dump after adev->job_hang = true (Sunil)

Signed-off-by: Trigger Huang <Trigger.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 68 ++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index c6a1783fc9ef..3000a49b3e5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -30,6 +30,61 @@
 #include "amdgpu.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_reset.h"
+#include "amdgpu_dev_coredump.h"
+#include "amdgpu_xgmi.h"
+
+static void amdgpu_job_do_core_dump(struct amdgpu_device *adev,
+				    struct amdgpu_job *job)
+{
+	int i;
+
+	dev_info(adev->dev, "Dumping IP State\n");
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (adev->ip_blocks[i].version->funcs->dump_ip_state)
+			adev->ip_blocks[i].version->funcs
+				->dump_ip_state((void *)adev);
+		dev_info(adev->dev, "Dumping IP State Completed\n");
+	}
+
+	amdgpu_coredump(adev, true, false, job);
+}
+
+static void amdgpu_job_core_dump(struct amdgpu_device *adev,
+				 struct amdgpu_job *job)
+{
+	struct list_head device_list, *device_list_handle =  NULL;
+	struct amdgpu_device *tmp_adev = NULL;
+	struct amdgpu_hive_info *hive = NULL;
+
+	if (!amdgpu_sriov_vf(adev))
+		hive = amdgpu_get_xgmi_hive(adev);
+	if (hive)
+		mutex_lock(&hive->hive_lock);
+	/*
+	 * Reuse the logic in amdgpu_device_gpu_recover() to build list of
+	 * devices for code dump
+	 */
+	INIT_LIST_HEAD(&device_list);
+	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1) && hive) {
+		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head)
+			list_add_tail(&tmp_adev->reset_list, &device_list);
+		if (!list_is_first(&adev->reset_list, &device_list))
+			list_rotate_to_front(&adev->reset_list, &device_list);
+		device_list_handle = &device_list;
+	} else {
+		list_add_tail(&adev->reset_list, &device_list);
+		device_list_handle = &device_list;
+	}
+
+	/* Do the coredump for each device */
+	list_for_each_entry(tmp_adev, device_list_handle, reset_list)
+		amdgpu_job_do_core_dump(tmp_adev, job);
+
+	if (hive) {
+		mutex_unlock(&hive->hive_lock);
+		amdgpu_put_xgmi_hive(hive);
+	}
+}
 
 static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 {
@@ -48,9 +103,14 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		return DRM_GPU_SCHED_STAT_ENODEV;
 	}
 
-
 	adev->job_hang = true;
 
+	/*
+	 * Do the coredump immediately after a job timeout to get a very
+	 * close dump/snapshot/representation of GPU's current error status
+	 */
+	amdgpu_job_core_dump(adev, job);
+
 	if (amdgpu_gpu_recovery &&
 	    amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence->parent)) {
 		dev_err(adev->dev, "ring %s timeout, but soft recovered\n",
@@ -101,6 +161,12 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		reset_context.src = AMDGPU_RESET_SRC_JOB;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
 
+		/*
+		 * To avoid an unnecessary extra coredump, as we have already
+		 * got the very close representation of GPU's error status
+		 */
+		set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
+
 		r = amdgpu_device_gpu_recover(ring->adev, job, &reset_context);
 		if (r)
 			dev_err(adev->dev, "GPU Recovery Failed: %d\n", r);
-- 
2.34.1

