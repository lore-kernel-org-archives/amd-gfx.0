Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1D4D7236A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 10:11:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB3BF10EA90;
	Fri, 23 Jan 2026 10:11:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CsV2MqmF";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012028.outbound.protection.outlook.com [52.101.53.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 321AC10EA8E
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 10:11:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMfdz4YgRBpaCwSKTp8ybPibG+RkGQ/o+Y0VCGb/f/Zim4QPMAkZy1lH9w/1oXZ1VCsjc1zQQ2CjEQlj5S8QHwUDNlFtr7NNw51u/oEbsZO5Pxht8OY8mukS0vLW1kWKvhAUbWtzG6HAmUNdt3fJz9TD6qJKTvNWuenjljuORDFh/Z3Z4+qz/LHoJLF6HwUs80tOVW+J9RFPEetKmf+tk9ze8lFmTX/Ka4EYozuYbRMceoF2VKc2eWGeyGFz5iW5xOPeZTisjRsNiBjgwPByc4YYYYovObX2YX3cwjEi/mU5MheWhWU0fm4HV5wqEtqm+XZJyyE5WSyPQ5aXJm06Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9450cl5rxqjGMxpBQUgUG8G/ylXO6b5Pi6ihbcRUt/U=;
 b=r0Wj+piKJdx62/2z0NH6TPcO5X1cB3MENHBiF4F3hhJRah9W9UMuLyayzFv6cyCQ4jJJ+NXN8kb1WCzrd6OrrsvwulkrUP8a5NIo4Y2oJtDca/HpSK6B3c+m5fGi2bRlMXK0BI9q3IDnqY4TvHR1rFxO/hMGH/ENJtHe5fRAxOIg+SxWiveaP6Vn4OL96qeEqaEByDGLmFAj3CkSlNBbolhe66l5HA3TsV2A99qGGQao05uQn5CaMuvIJiylAtnrnJDXDMSiYbbZlV2XMABd1Ne92FPD1ie1DbSMqUtCmRfW+lhpJHCn/cld0mi4zViREQFb175GTa/In9DOhs7xkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9450cl5rxqjGMxpBQUgUG8G/ylXO6b5Pi6ihbcRUt/U=;
 b=CsV2MqmFWNxJjJJ1zN1W/trKwv39YiqNRBeJ6X98Lk0krwRDqDqKj9YITeoAQeS0EXDtaMy7Znn/K4+nNPPlzyRoL0/h1+fF9NeaQ0Bnici4o+gVBmoMHYS1NQKFmBBuTFA6xvawy14hqcpXqRcsjbqeF+KcA9FlPXPVAvNFr2U=
Received: from BLAPR03CA0092.namprd03.prod.outlook.com (2603:10b6:208:32a::7)
 by MW6PR12MB8661.namprd12.prod.outlook.com (2603:10b6:303:23f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Fri, 23 Jan
 2026 10:11:02 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:208:32a:cafe::5b) by BLAPR03CA0092.outlook.office365.com
 (2603:10b6:208:32a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Fri,
 23 Jan 2026 10:10:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Fri, 23 Jan 2026 10:11:01 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 04:10:59 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 02:03:28 -0800
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 23 Jan 2026 02:03:17 -0800
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 7/7] drm/amdgpu: add queue modification support to
 AMDGPU_USERQ ioctl
Date: Fri, 23 Jan 2026 18:01:25 +0800
Message-ID: <20260123100219.1693990-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260123100219.1693990-1-Jesse.Zhang@amd.com>
References: <20260123100219.1693990-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|MW6PR12MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: 26bf5d5e-9625-4966-d5c8-08de5a67b615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fBSi3/ZS7+l/XGau2ts5tKZJhDfzt6fEX7JZ1uqeXWGyEjHk9k+6lR9H6FQ7?=
 =?us-ascii?Q?12iZ++toCVg4NtoINeGCVSpT33aQJ7ILT7dWsWrZJEvR13DO6ojR/qCRjkpq?=
 =?us-ascii?Q?7tKH9VBF6HdFR+ceStvhs0f9cmHWyUbKvCbvlw2spHFN6APFJAMmKb7axr1L?=
 =?us-ascii?Q?9w8WxmEj3X5B8GtfloamwzuiUCNtfBLSRlB7mqF9O8ryeKUMI0T6x042Yd5r?=
 =?us-ascii?Q?3OxtvzGmD75U6y5Xsz/pr2eazX7sdcxRqvEYF1j3lHBr+UVoz4VzjYzuFFs4?=
 =?us-ascii?Q?HAMGu2w9XkQqawa5Z4gJZ9dAmDhQ7iSSPydtgOSJ98wXqyeP+OFf34njrMYh?=
 =?us-ascii?Q?LXZ1mYr3RcpUls4mT5Pr9wPwjCfcOu9M6dcqN7Wzj8/pZ/Ze+6TYN94WaPCC?=
 =?us-ascii?Q?YaH5JXQXH8oV6+2cax3Eht9rQHX8tzvvSIGL7gQack4rxC3xqY3UcFLO1vzf?=
 =?us-ascii?Q?PGxWN7kNiXpqjVCn6B8YHy47DL+kw725iLH/GmIv6gI+bKPDkVRKK4ZuUjhY?=
 =?us-ascii?Q?ybqyPnuI7bC/CaphIQfzRBvb7lTIx4Icl3WASIaQWjgiDK0dwVs8Nrk8Hi8t?=
 =?us-ascii?Q?I2fgYDVtRyQI6/uLXvo5X8PCZKSQ+toirE3JKBcdeTLYPUJfnXEIO75dEpnt?=
 =?us-ascii?Q?HjLlXWlJ8gs/KJNT5mpGJAyNkDwbReJlUGQuVeRLYbuPzIzfQLZOkmzbvvhl?=
 =?us-ascii?Q?JRrPGC8mE8Xeg5dCUniay1emUCoqcC2SnBp1jC0Fc9FcbCdMp5dNbzm0zz/l?=
 =?us-ascii?Q?hFXaSpjC14079hFZ8x3YbF3d7J9EbaxBw+T1Bb0W2ztZePrbIaLx6oD/2Te8?=
 =?us-ascii?Q?9gFYEoIaTuZssch+h3vei/RPQBG6dN6NaGrD+0XLomRhU517mLeWgcoKQZws?=
 =?us-ascii?Q?1A6HLmL/irdtz7oozD9JqBUs2lXHGPU/ijUENOIxZhkC7kSb6xrpifjIjVST?=
 =?us-ascii?Q?Q0xIEH8JVr/ozWWJQJ+sf+g2GGequcEZIraM+kqiNYGiztcGho0Uk3rQjA5M?=
 =?us-ascii?Q?KQODTWO7YjTLTLWK1sK7mVdsPqWYre0/mx1A+F6icE6KADSDstGaBtNLhnj+?=
 =?us-ascii?Q?TaUzxvi0LGtjS3k1fq9XW7MAxT+I71CzI/noTSPVyk2IQ1s93wqcypSe6sQs?=
 =?us-ascii?Q?Lu+LYEFj0JloHmThbiSUd42cG9q3B8atZlE1O3vHi/ag4L/5gSUbUNm80z5n?=
 =?us-ascii?Q?jTB2vy/Ponzj15usVb/jTStQSq8fXXsxnIjoiHm5kaz16ZxI8TiiieefDwjh?=
 =?us-ascii?Q?mkoIfNS6qH/1A1ncjZGoQS5KNHPojWS1uHo7eiXkJ9BgjmQUBh3UA5XdKxkQ?=
 =?us-ascii?Q?dQr8yrT4cmBByu99Q6zGSBZt0UrK/2/ZNLuz3CpXLHUUvCuBF0QAOmURzpzq?=
 =?us-ascii?Q?dstKMXvdlAUfAqVTIjp2DZoI4FToLoz/1Uz9UwfITWBmFXxEiYOB1TJ8oMEa?=
 =?us-ascii?Q?0z/P2UT2j88KqzTWDVvSn4doWqaNogVjHDAl6CI6ND4Lb8FEfZHm0fxERAOl?=
 =?us-ascii?Q?qdfNfyAvs3o+2lQVzvQa279s3Zm1n9NcmYeu9L5935AHhVwt63KtPPeMnfvj?=
 =?us-ascii?Q?h5dNsk40q/RU7aq5XiRO1Tk/sFAVdIxghSDW9kJ5bTU7DwBvECdvX/LIdwoE?=
 =?us-ascii?Q?Fp68BKvQpeNFvU4FSOm40vZZWzVhVed8sIa4btomibIyZvVOWsRAv9cBBLtv?=
 =?us-ascii?Q?UG1GXg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:11:01.5793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26bf5d5e-9625-4966-d5c8-08de5a67b615
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8661
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

Extend the AMDGPU_USERQ ioctl to support dynamic modification of
existing user mode queues after creation. This provides userspace
with the ability to update queue attributes without requiring
destruction and recreation of queues.

v2: add a new op for AMDGPU_USERQ. E.g., AMDGPU_USERQ_OP_MODIFY. (Alex)
   make the target xcc an explicit parameter. (Alex)

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 96 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  3 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  1 +
 include/uapi/drm/amdgpu_drm.h              | 17 ++++
 5 files changed, 116 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a8f4f73fa0ce..ad136145316b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -819,6 +819,9 @@ struct amdgpu_mqd_prop {
 	uint32_t cu_mask_count;
 	uint32_t cu_flags;
 	bool is_user_cu_masked;
+	uint32_t queue_percentage;
+	/* used in gfx9 and gfx12.1 */
+	uint32_t pm4_target_xcc;
 };
 
 struct amdgpu_mqd {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 4d7841f47dd3..de267135af69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -34,6 +34,26 @@
 #include "amdgpu_hmm.h"
 #include "amdgpu_userq_fence.h"
 
+/* Mapping queue priority to pipe priority, indexed by queue priority */
+int amdgpu_userq_pipe_priority_map[] = {
+	AMDGPU_RING_PRIO_0,
+	AMDGPU_RING_PRIO_0,
+	AMDGPU_RING_PRIO_0,
+	AMDGPU_RING_PRIO_0,
+	AMDGPU_RING_PRIO_0,
+	AMDGPU_RING_PRIO_0,
+	AMDGPU_RING_PRIO_0,
+	AMDGPU_RING_PRIO_1,
+	AMDGPU_RING_PRIO_1,
+	AMDGPU_RING_PRIO_1,
+	AMDGPU_RING_PRIO_1,
+	AMDGPU_RING_PRIO_2,
+	AMDGPU_RING_PRIO_2,
+	AMDGPU_RING_PRIO_2,
+	AMDGPU_RING_PRIO_2,
+	AMDGPU_RING_PRIO_2
+};
+
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 {
 	int i;
@@ -906,7 +926,6 @@ static int amdgpu_userq_update_queue(struct amdgpu_usermode_queue *queue)
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *uq_funcs;
-	bool unmap_queue = false;
 	int r;
 
 	uq_funcs = adev->userq_funcs[queue->queue_type];
@@ -922,12 +941,17 @@ static int amdgpu_userq_update_queue(struct amdgpu_usermode_queue *queue)
 		r = amdgpu_userq_unmap_helper(queue);
 		if (r)
 			return r;
-		unmap_queue = true;
 	}
 
 	r = uq_funcs->mqd_update(queue);
-
-	if (unmap_queue) {
+	if (r)
+		return r;
+	/*
+	 * If the queue is considered active (has valid size, address, and percentage),
+	 * we attempt to map it. This effectively starts the queue or restarts it
+	 * if it was previously running.
+	 */
+	if (AMDGPU_USERQ_IS_ACTIVE(queue)) {
 		r = amdgpu_userq_map_helper(queue);
 		if (r)
 			drm_file_err(uq_mgr->file, "Failed to remap queue %llu after update\n",
@@ -937,6 +961,65 @@ static int amdgpu_userq_update_queue(struct amdgpu_usermode_queue *queue)
 	return r;
 }
 
+static int amdgpu_modify_queue(struct drm_file *filp, union drm_amdgpu_userq *args)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_mqd_prop *props;
+	int r;
+
+	if (args->in.queue_percentage > AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE) {
+		drm_file_err(uq_mgr->file, "Queue percentage must be between 0 to AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE\n");
+		return -EINVAL;
+	}
+
+	/* Validate priority */
+	if (args->in.hqd_queue_priority > AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM) {
+		drm_file_err(uq_mgr->file, "Queue priority must be between 0 to KFD_MAX_QUEUE_PRIORITY\n");
+		return -EINVAL;
+	}
+
+	/* Validate ring size */
+	if (!is_power_of_2(args->in.queue_size) && (args->in.queue_size != 0)) {
+		drm_file_err(uq_mgr->file, "Ring size must be a power of 2 or 0\n");
+		return -EINVAL;
+	}
+
+	if (args->in.queue_size > 0 && args->in.queue_size < AMDGPU_GPU_PAGE_SIZE) {
+		args->in.queue_size = AMDGPU_GPU_PAGE_SIZE;
+		drm_file_err(uq_mgr->file, "Size clamped to AMDGPU_GPU_PAGE_SIZE\n");
+	}
+
+	if ((args->in.queue_va) &&
+		(!access_ok((const void __user *) args->in.queue_va,
+			sizeof(uint64_t)))) {
+		drm_file_err(uq_mgr->file, "Can't access ring base address\n");
+		return -EFAULT;
+	}
+
+	mutex_lock(&uq_mgr->userq_mutex);
+	queue = amdgpu_userq_find(uq_mgr, args->in.queue_id);
+	if (!queue) {
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+
+	props = queue->userq_prop;
+	props->queue_size = args->in.queue_size;
+	props->hqd_base_gpu_addr = args->in.queue_va;
+	props->queue_percentage = args->in.queue_percentage;
+	props->pm4_target_xcc = args->in.pm4_target_xcc;
+	props->hqd_pipe_priority = amdgpu_userq_pipe_priority_map[args->in.hqd_queue_priority];
+	props->hqd_queue_priority = args->in.hqd_queue_priority;
+
+	r = amdgpu_userq_update_queue(queue);
+
+	mutex_unlock(&uq_mgr->userq_mutex);
+
+	return r;
+}
+
 static int amdgpu_userq_set_cu_mask(struct drm_file *filp,  union drm_amdgpu_userq *args)
 {
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
@@ -1031,6 +1114,11 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		amdgpu_userq_set_cu_mask(filp, args);
 		break;
 
+	case AMDGPU_USERQ_OP_MODIFY:
+		r = amdgpu_modify_queue(filp, args);
+		if (r)
+			drm_file_err(filp, "Failed to modify usermode queue\n");
+		break;
 	case AMDGPU_USERQ_OP_FREE:
 		r = amdgpu_userq_destroy(filp, args->in.queue_id);
 		if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index c80d69368196..078f424e9415 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -31,6 +31,9 @@
 #define to_ev_fence(f) container_of(f, struct amdgpu_eviction_fence, base)
 #define uq_mgr_to_fpriv(u) container_of(u, struct amdgpu_fpriv, userq_mgr)
 #define work_to_uq_mgr(w, name) container_of(w, struct amdgpu_userq_mgr, name)
+#define AMDGPU_USERQ_IS_ACTIVE(q) ((q)->userq_prop->queue_size > 0 &&	\
+			    (q)->userq_prop->hqd_base_gpu_addr != 0 &&	\
+			    (q)->userq_prop->queue_percentage > 0)
 
 enum amdgpu_userq_state {
 	AMDGPU_USERQ_STATE_UNMAPPED = 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 0565986949bd..1a0079a2b47c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -304,6 +304,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	userq_props->use_doorbell = true;
 	userq_props->doorbell_index = queue->doorbell_index;
 	userq_props->fence_address = queue->fence_drv->gpu_addr;
+	userq_props->queue_percentage = AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE;
 
 	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
 		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index cfc3a9313229..fab2914ac25c 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -331,6 +331,7 @@ union drm_amdgpu_ctx {
 #define AMDGPU_USERQ_OP_CREATE	1
 #define AMDGPU_USERQ_OP_FREE	2
 #define AMDGPU_USERQ_OP_MODIFY_CU_MASK	3
+#define AMDGPU_USERQ_OP_MODIFY 4
 
 /* queue priority levels */
 /* low < normal low < normal high < high */
@@ -342,6 +343,7 @@ union drm_amdgpu_ctx {
 #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH 3 /* admin only */
 /* for queues that need access to protected content */
 #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE  (1 << 2)
+#define AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE	100
 
 /*
  * This structure is a container to pass input configuration
@@ -423,6 +425,21 @@ struct drm_amdgpu_userq_in {
 	 * represents 32 CUs/WGPs)
 	 */
 	__u32 cu_mask_count;
+	/**
+	 * @queue_percentage: Queue resource allocation percentage (0-100)
+	 * Defines the percentage of GPU resources allocated to this queue
+	 */
+	__u32 queue_percentage;
+	/**
+	 * @hqd_queue_priority: Hqd Queue priority (0-15)
+	 * Higher values indicate higher scheduling priority for the queue
+	 */
+	__u32 hqd_queue_priority;
+	/**
+	 * @pm4_target_xcc: PM4 target XCC identifier (for gfx9/gfx12.1)
+	 * Specifies the target XCC (Cross Compute Complex) for PM4 commands
+	 */
+	__u32 pm4_target_xcc;
 };
 
 /* The structure to carry output of userqueue ops */
-- 
2.49.0

