Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FA5D15DA1
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Dec 2025 15:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A011C10E171;
	Wed,  3 Dec 2025 15:42:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KzwHmfrs";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012036.outbound.protection.outlook.com [52.101.43.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D02C310E171
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Dec 2025 15:42:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNOrl4DU2V88EDBxuEn/+2S7eLzq4JwfMuZwEdMW+pqOreXNvauNDlUTze4N07ZQ81XbOsQi1vcu/IKHUTHBHz1zGD6EnLHnLDK0Hy/QjtKJ+xqAZ72IW9QQxVBY9ihSk1id7f0tY84+FmPDrC1hbK7jFBl10tTPaByg4CvEmUTXxcn3qsUcQ4pIcut/W3x8utrdOM/aV85DcQrr0I9Qyqq4d5nPR1xHX0oOhFEJU4drdPPW5t7BBei9ievl6AnaANkFjYLX8VPfk5C5rqd8htNma/rG3FKitTe0hl4/CVZuzpkTgAkmDgBaR7+RpgKnSKaQq7ir27O9XfUb2cUbxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2D/1NfR4yB+cX00b+hYB3MRdduv1cTPJGftcSnC6Bho=;
 b=cwGbLxhFXpqDO+HvyexsMYzQZcqsX2nk6sR8b5u1mOoyaYBBdJCIwm4/+A1UFE6o9PcSEQ/QPxVBiwpMgEVmLW5uyX5y0HPyjlsm7elizweFlcpq+ZRyqb2rvH57UlmxGDF0sF65iuIsZgMbjPEg1ptJbRHlOcakdlc2Wb3u+w0UgeY9Rm6syn1J8L1AiiIqspMn9p1vwyKCed8K1x2YptMvqvSV0Tj4vP01vC9qwCgbSVaLw3mBYzgmzqIgtU2285F+52NMqa3h4ypDzF6VIigfoXWYNzvZeFSyZctaOXb7SUrKiHQ2nFk7piYp3PfuVLACeGhROGcNGwnZOVj6Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2D/1NfR4yB+cX00b+hYB3MRdduv1cTPJGftcSnC6Bho=;
 b=KzwHmfrsZ1o98+Pujl4EVdVw2XFpU4tWXcDxE3dJG38AjLaH3mCjQMuhlS0CEd6xfDXK3kdH0eBJkI0+5Rheg7sydQAnmh1yWPTjGRfwklTF2bf1LO3tHNZIyd/wuXz9ev5g4XCIlHFXvv0qohHzOdnof1SPyYnaYwxmOy+jZPQ=
Received: from BL1P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::6)
 by SJ5PPFC41ACEE7B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 15:41:58 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::78) by BL1P223CA0001.outlook.office365.com
 (2603:10b6:208:2c4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Wed,
 3 Dec 2025 15:41:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 3 Dec 2025 15:41:57 +0000
Received: from amartin-dev-ubuntu.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Dec 2025 09:41:56 -0600
From: Andrew Martin <andrew.martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Andrew Martin <andrew.martin@amd.com>
Subject: [PATCH v4] drm/amdkfd: FORWARD NULL
Date: Wed, 3 Dec 2025 10:41:45 -0500
Message-ID: <20251203154145.63159-1-andrew.martin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|SJ5PPFC41ACEE7B:EE_
X-MS-Office365-Filtering-Correlation-Id: b5178de5-ae22-423a-9726-08de32827df0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TeeDbODJz4YDI6ErLIYpIHYRoupZxZhYSNiHUx3MhZB9lAzs9ARhkj1l7qyU?=
 =?us-ascii?Q?qErwM0OFhq9RJNDY7Ppk0U0v5vOuOOB7HeTz5juCjyRYngE3kztyXMq8Mo53?=
 =?us-ascii?Q?TUaaI+NMBVqOhe4hKoMjYVEWKePQ1+E6XKtf5NcadQ7O30OCMEERj2sljGs3?=
 =?us-ascii?Q?CO6aBs/KTkh8svCYKKBPz3CykE38tHm2dFFH6SgRWPAHaiRvuZJkCGzsMLAD?=
 =?us-ascii?Q?lH5v2gOsyoQKDURJNo8VPl+4pR6cSTOtXvutSbhP1ypUNUD2zLPYA28PdR42?=
 =?us-ascii?Q?HMWW3o8kfNUfJ8DxftJzGRNG6N3bzw6mNwpkzYWmLEG0ZWKnlHsHVfc53vpN?=
 =?us-ascii?Q?g/t0vBeYaxlGq0P7gZA1C4aj7z95LlZqxDl+zti2iumNxN6FIJO2V0UPFCDc?=
 =?us-ascii?Q?0Bw0rteccnXwBhhsI9ldTBSbEzFcLEyQQOJajukhkBXjVTnpr/AH9E501ONk?=
 =?us-ascii?Q?VaMn8GaNlYZ+VfrUPi+R6XH9DU460MJGtoVwaLRpkU8/3cRMR+8JXy0/l+Bn?=
 =?us-ascii?Q?UPsJeFMuaNYTBE2Tyrgou85fU0RQ8Lwu5RCfJoYcnuiiMfEgK5EX0yPyT69d?=
 =?us-ascii?Q?IVjB9dfS+EfMV3AB0TO7fzE2esWQM7LHKMd1SyQYYgTpPlbUc3yE+A9DI7OB?=
 =?us-ascii?Q?cXfwdeP3Wut9oD88hWyHrn21T8ik/p7j8dY5fqKnai8AalOIbOFj0nUnMUxy?=
 =?us-ascii?Q?HvT4uiFh7899vZxww9vHIPrUpo8QwQnVQ5HsdXk0x3urZOqkfsx+eWlyjYq5?=
 =?us-ascii?Q?O1tPOb9MLIt7WtXikHapusZBn0d2G9+fhlVvzdwREN6VfrtLP4OAiE9btyI2?=
 =?us-ascii?Q?EkM9fzueDMf2SEuyIK4K4hyiAablV9EeSYAUYbuvNDY8k1RXcMGNK5Sr58Fx?=
 =?us-ascii?Q?yrmSV5cHe9FHR55UOGwxKk7gZwLE3bCSYEeL3fqrRCwCMNAZm5EeyX+zhQP3?=
 =?us-ascii?Q?JQMKxTz5L4prTHzD9CkvdCTSsYuw1PZ5NIWKfj/vES6WB7frBj3j1YQvL9Sc?=
 =?us-ascii?Q?i0eNKxSogcQOJzamoFrdZ/AHSqWMDlsruvWbX4YVIo7E05cw8cXYFRepR82E?=
 =?us-ascii?Q?zkmiEsdY202tihrd9QYouBbyf3ZsGUQajPEoyBFQo9ce8ojrnXVK/s3tnTDB?=
 =?us-ascii?Q?RJ8DhTecWHftufy2ONyfFwVr6gDqw5mazInfbUPQfBmV13mMQ18k+zp2l8Lu?=
 =?us-ascii?Q?w/QFZ4cyaV0WvruT6/HZ8LJCdPjKN8Z0zSiETvHOqZ5uJ3N92BpzEexoN6Xy?=
 =?us-ascii?Q?uUUAuvY0HlpNXMHNbUsUom+70D80qHD13NqoSqdb202puclVZgbamt9eNvR+?=
 =?us-ascii?Q?41cxQO8EErObnEf0JgqLaUjdLnOUjgNLlKGHyjs3vpYQQvFwUjiVs8rjhQ4l?=
 =?us-ascii?Q?CG9r3uiz9JnwpWQoE5szISFNLJ8p+XjRmhQJ0/wLYNvJsec41e03KZAGLnxo?=
 =?us-ascii?Q?3oGM2xKcj1Qa2lBCDljcdF1QsYZ5eayYnXCMotunJFxGAT/Lk3DSEkdDjbYq?=
 =?us-ascii?Q?rRdoRVAXjt8BtWIXG3xzQamcwEVu9MWAdFlGbaNgpSLTytv2/qAf6GFYn423?=
 =?us-ascii?Q?pb1lzLKFU4baUhwf4qw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 15:41:57.2814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5178de5-ae22-423a-9726-08de32827df0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC41ACEE7B
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

This patch fixes issues when the code moves forward with a potential
NULL pointer, without checking.

Signed-off-by: Andrew Martin <andrew.martin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c            |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c           | 12 ++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_process.c         |  3 ---
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
index 193ed8becab8..31b8fa52b42f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -107,7 +107,7 @@ static const char *amdkfd_fence_get_timeline_name(struct dma_fence *f)
 {
 	struct amdgpu_amdkfd_fence *fence = to_amdgpu_amdkfd_fence(f);
 
-	return fence->timeline_name;
+	return fence ? fence->timeline_name : NULL;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 5f2dd378936e..d1d72cd332fc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -2358,7 +2358,7 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 	if (kdev->kfd->hive_id) {
 		for (nid = 0; nid < proximity_domain; ++nid) {
 			peer_dev = kfd_topology_device_by_proximity_domain_no_lock(nid);
-			if (!peer_dev->gpu)
+			if (!peer_dev || !peer_dev->gpu)
 				continue;
 			if (peer_dev->gpu->kfd->hive_id != kdev->kfd->hive_id)
 				continue;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index ba9a09b6589a..1cb24092b17e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -516,9 +516,13 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
 	int i, r = 0, rewind_count = 0;
 
 	for (i = 0; i < target->n_pdds; i++) {
+		uint32_t caps;
 		struct kfd_topology_device *topo_dev =
-				kfd_topology_device_by_id(target->pdds[i]->dev->id);
-		uint32_t caps = topo_dev->node_props.capability;
+			kfd_topology_device_by_id(target->pdds[i]->dev->id);
+		if (!topo_dev)
+			return -EINVAL;
+
+		caps = topo_dev->node_props.capability;
 
 		if (!(caps & HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &&
 			(*flags & KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP)) {
@@ -1071,6 +1075,10 @@ int kfd_dbg_trap_device_snapshot(struct kfd_process *target,
 	for (i = 0; i < tmp_num_devices; i++) {
 		struct kfd_process_device *pdd = target->pdds[i];
 		struct kfd_topology_device *topo_dev = kfd_topology_device_by_id(pdd->dev->id);
+		if (!topo_dev) {
+			r = -EINVAL;
+			break;
+		}
 
 		device_info.gpu_id = pdd->dev->id;
 		device_info.exception_status = pdd->exception_status;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index aec7522407db..47783803f56f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1763,9 +1763,6 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 	struct kfd_node *dev;
 	int ret;
 
-	if (!drm_file)
-		return -EINVAL;
-
 	if (pdd->drm_priv)
 		return -EBUSY;
 
-- 
2.43.0

