Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C8DC3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Aug 2024 07:55:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CEEE10E5C7;
	Fri, 16 Aug 2024 07:55:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gXmin3Vg";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5480710E5CA
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 07:55:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fE7M5A2dBLk7JjUGGS62V1wk1UGpYnfZN5lOrHqUEZ23gSbm3a4hSXNAuuw43PyV4U+O29dKd899NrCpp8qH1YU4i0IrW5QVH1THvsZuvxdmq63zvFbnhy3EBpINNX5IbDrAeTNzw4onlk28yC8XRRr1MmUMGQgMzdfCeHOkCjS6iYXapGsGgjIF8DpNOOV5PgwhtgV+ExB+is84xYRLTh2NP0Ouf6RVZ5CVh4X6UPhRPzRQeBo2le6wVSz0rklz6k4E94NDft1R9KtxMqiZhmh9F5NkLkSmgBr6U6+UvuwI8R2k2FAPXBR00aqueGAnm/hC6RVeEkFpHZtEN5CqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVwP0nuEDBF2FPl6wVspvLawthKUkZwLAEJizPzcL3Q=;
 b=qJ10hkYhLw4NIf7Q/mGUk2Er1ivX+x3Gn32P1nMHr/EQRSRgS8PBw4pUecUYKJfvCbI/82yD4od7IBWLNupoi124wLtcnS7otTNFS6Fj0qWVVXhXzJIAfFG/pAhsO0tk9yr0Fs+/gSwHEeCHArvIA3yxs5qy2rYOCNgNnQS1a3F8CTk9vvqgOKkZQkyqRrRA448tpRN8ymDGo3vMifiVAsCteYUm+3vZOJN9v50/96+7yZj8SN3u+MIDk/2hAqHQdFJ7zLiQq9u9ULDk05obYqkF2qDPi4bnzO5ffAwXObVyTq7VCOnTBKkyxSU5nLIf1hpnmiIdnD42VxKVEgP40Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVwP0nuEDBF2FPl6wVspvLawthKUkZwLAEJizPzcL3Q=;
 b=gXmin3VgHfDMoS85PdmYB6azbuAgAHTrnuCNvF6k+ui9awes22xfswEEGIG2NlcOYjkqTAfCPN1GAgwbXxB6/Gc7A+BHIv/WBA82wlBJShTxPZLhuqc8QQanKDWKEXBomDHdBJUVEm+jv8lIDVFr40BM4OQzPkbNNWuvirh0SjI=
Received: from DS7PR07CA0018.namprd07.prod.outlook.com (2603:10b6:5:3af::27)
 by DS0PR12MB6631.namprd12.prod.outlook.com (2603:10b6:8:d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 07:55:09 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::2c) by DS7PR07CA0018.outlook.office365.com
 (2603:10b6:5:3af::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Fri, 16 Aug 2024 07:55:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 07:55:09 +0000
Received: from lps-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 02:55:07 -0500
From: <Trigger.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <sunil.khatri@amd.com>, <alexander.deucher@amd.com>, Trigger Huang
 <Trigger.Huang@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Do core dump immediately when job tmo
Date: Fri, 16 Aug 2024 15:54:47 +0800
Message-ID: <20240816075447.442983-5-Trigger.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816075447.442983-1-Trigger.Huang@amd.com>
References: <20240816075447.442983-1-Trigger.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|DS0PR12MB6631:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cea0f04-39ba-46a3-3141-08dcbdc8c02d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tnojCv0rhwFdVc0oAfFE0+gN7PZvvxcFNSimMKwzGsY7d/DiSaBZECLs9AAA?=
 =?us-ascii?Q?pM5nSiONwxLwXCrh7oWSKmxEtv9v+WY5xk9CqjbvmExbHmI6+R+Ygjuytijw?=
 =?us-ascii?Q?+XMUIPaErt0zVVdOmvbK2srv4JaN8yMKHbqe9xCnn8nh2lhD+bHwO/op4b3c?=
 =?us-ascii?Q?iWvLgz5jG9rtN9nfQa1Nv3GajCvrXwIzA2Nbg3BnE69Y8V/fLnX7ES43tmSm?=
 =?us-ascii?Q?MHoFXtfw8EX2bl+UiX03re0D5MfacHQhvd9+DKvKrnEa968Lucr+yD9i+vSa?=
 =?us-ascii?Q?OvcYo6p6U6iqJ2v5Nhl44AZYtHP16e4lkruRcYjqyf16PI7K1qTJYnrHVEYD?=
 =?us-ascii?Q?45m62AznAPxTndLcie23ODnsQf19BihKkpE6vQf9lAJiGve4nJpH3Yds8GEu?=
 =?us-ascii?Q?kavBjbMY1giL1xKxiUghmiUG4FQ1CRn4VOYrfaZJ96F5ffUEesnehsCMmz2L?=
 =?us-ascii?Q?goLwr8qp4l54VwRD2QMncV3HukkLAGaK/1oPP8JHRVa56jkiLDKVK0Yp/8e/?=
 =?us-ascii?Q?+5nCkq/rw04tAV/ex0ZXeXFbZfV259pm0PTZuqdZTK+T7Ho0MoM5P2Lt9CNm?=
 =?us-ascii?Q?bfi0zlSP4yZ7eL15C2Gwxim2AM1EX4gYlVv8UP3WfXkwOfHRvhClxtRnCGZX?=
 =?us-ascii?Q?8+hClQ9qUsTBI9cQwYuNlGcNRpW6eABCzwkeuR/zVJIiC6mJq5n5rc4tQGiO?=
 =?us-ascii?Q?v7wHq/E2c4uXLZpbE8kK/qAFbSOm6PCHr9ugsE1Ss6wEJ2PoJwfoz6Jv7mT0?=
 =?us-ascii?Q?VzLbkLtVoUcnFryS8fDChvSO0vSXj2xRWdpTSQu8bVHsX+6X8imJwufMrTNB?=
 =?us-ascii?Q?takk8/QCNddFf+QYcN12sjtOBJQPTI/biRDeFrH7OJmtcVNRTfAruylJXPW0?=
 =?us-ascii?Q?sr93dok/RXxhjrCtjShJi1SZ/kA/ZsP91Yx/VEPuRjwKZ8dPTct6xjfyV6aJ?=
 =?us-ascii?Q?cYp+bIwJqZg1IYvK+PET66CdNK7YHoIj4ZzA3IIe8wfOBD5uc5xgwJF9LZEz?=
 =?us-ascii?Q?L5P3Jsagp05kHcC8PJ2s4mGaM565UlQRFb3cQ4qtDDPqaoS4Cuao8mSIMnwf?=
 =?us-ascii?Q?6LFKs8Qn66qhblvLw3+iFLVPUjZDEy8l86vbedJbrU17qj3kKdQC6fS7Jn9H?=
 =?us-ascii?Q?j0J3DWfbiG7Z20Y7hxQzK4s7kXr3FVqtJ5vwoBOJ62aoQElfqIpqFXBoBsG6?=
 =?us-ascii?Q?d1gsp0My9NJjpGTpdfTElqnbkQQLwTLy3DUKdUAUOafIvF5XzGeUzQ68eekA?=
 =?us-ascii?Q?FA3VPR8WPPcGFSrC093A3GqnEcoUt1gKr1Lxk8wWQRwwyMX+Mu1RaNgQdXy3?=
 =?us-ascii?Q?E84gpc21E0G/7zztRUEBUoWREe+Ow8m/Nh7sIZ+LU/lYhfq9sv9phqqgkfz4?=
 =?us-ascii?Q?Y85m8IZW3G7GRsUGzE//CWWxyAy1ENLC98OEtM+e4CJN6Ge+CDrQBqOMOV0t?=
 =?us-ascii?Q?3BDdioAgJU59DPQdJ4a/5QiO/9EdR4bh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 07:55:09.4282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cea0f04-39ba-46a3-3141-08dcbdc8c02d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6631
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

Signed-off-by: Trigger Huang <Trigger.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 64 +++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index c6a1783fc9ef..009551335d05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -28,9 +28,63 @@
 #include <drm/drm_drv.h>
 
 #include "amdgpu.h"
+#include "amdgpu_dev_coredump.h"
+#include "amdgpu_xgmi.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_reset.h"
 
+static void amdgpu_job_do_core_dump(struct amdgpu_device *adev,
+			       struct amdgpu_job *job)
+{
+	int i = 0;
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
+static void amdgpu_job_core_dump(struct amdgpu_device *adev, struct amdgpu_job *job)
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
+
 static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 {
 	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
@@ -48,6 +102,12 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		return DRM_GPU_SCHED_STAT_ENODEV;
 	}
 
+	/*
+	 * Do the coredump immediately after a job timeout to get a closer
+	 * representation of GPU's error status.
+	 */
+	if (amdgpu_gpu_coredump)
+		amdgpu_job_core_dump(adev, job);
 
 	adev->job_hang = true;
 
@@ -101,6 +161,10 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		reset_context.src = AMDGPU_RESET_SRC_JOB;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
 
+		/* To avoid a double coredump, as we have already done it */
+		if (amdgpu_gpu_coredump)
+			set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
+
 		r = amdgpu_device_gpu_recover(ring->adev, job, &reset_context);
 		if (r)
 			dev_err(adev->dev, "GPU Recovery Failed: %d\n", r);
-- 
2.34.1

