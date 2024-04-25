Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50B2C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 09:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3677410FA6D;
	Thu, 25 Apr 2024 09:48:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mu6U4Pr0";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4602F10FBCF
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 09:48:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rf70QC0LGOlnaGwq7GLArvoIwJ+YeXcjfsSC6FexFZYu/f4E4wkMyPx4zEiU995lFKb0yFnlzy2twGl2Uw/bvi5/se0RzOzlxd14MhhKRIZUwMtjAICAf8t+dALjDW/Hukwn7ZRT9D1gy7rydH/h9whE7Sxf2GN2ZjWakt6VUpBqAYVO2tpvkN5WUb54a7hHyrCObwWEQHLwEYhjQtaWTOn4Su4+ymRdghQoaZyv6Rx9WNOUCmpx8+xU+662sF924UhfMXBE0a0NYtiIdOkDe3NDT22wXXTWLunmGCvtrxBKhGs9+vICBqL9LtLc5DOfynFLG0KhcytlNOOcWb+D4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZ/JM0mF6wiPSxxpLlmuN6hsDZQd3PSjtcf92eZaKmU=;
 b=cS6mWsiLWr3A6h98BnGxIOd3qmIGj4KVIoNZcQToGcdv3sPafmFYqmsA659SxXgIdI/dkeMYwiigv9vT8aFPuaEK4lL8KR/Xfs2aiikoD6RQn+DM08JNyBpcqPpZcAxf4ivogx3S0P/IOXw/XR9/27XZlNUO4zsEPqwf9VaZOE3EkVNZE9qab7A/G0kpwSJa6c1yr1NyQXkARM3p3mquUchcByL+ls3DHNB5Y2iE4ACD2IZKAZRB2X7kAshQ4S0Bm5rOdc1ivW/C9YFWFSHflQVGWVF07ocxjTh4Ucq1HCM0WKhXJnIQQx7ZfvR5/OrBdLYp1CtJNNzwxjjpvTk/Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZ/JM0mF6wiPSxxpLlmuN6hsDZQd3PSjtcf92eZaKmU=;
 b=Mu6U4Pr0AbI5KVEtZMqg1Gx1b+z7lGghGj3XNQP1Sibpy0ZpV99/nSVrhnx9mKcydPuQzqlpreIsMY2sFAGwJgZzn9f6fXReYvTEk9gwAEuOn/iAdFWhqkjPaPxDsD9kYYXb8BQYEffMyqXugHtAJLTc1LVUNx2G/GiMGxAudO0=
Received: from BN1PR13CA0013.namprd13.prod.outlook.com (2603:10b6:408:e2::18)
 by MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 09:48:14 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:e2:cafe::67) by BN1PR13CA0013.outlook.office365.com
 (2603:10b6:408:e2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.10 via Frontend
 Transport; Thu, 25 Apr 2024 09:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 09:48:14 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 04:48:12 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>, <Christian.Koenig@amd.com>, <Likun.Gao@amd.com>
CC: Jack Xiao <Jack.Xiao@amd.com>
Subject: [PATCH 1/5] drm/amdgpu/mes: add mes mapping legacy queue support
Date: Thu, 25 Apr 2024 17:47:39 +0800
Message-ID: <20240425094743.134248-2-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240425094743.134248-1-Jack.Xiao@amd.com>
References: <20240425094743.134248-1-Jack.Xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|MW4PR12MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: c8434726-4676-4b0f-f65f-08dc650cd3a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|82310400014|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SSf10Uipyme2F9KhsIe/xW3VUdqZG0KxTx/yWsSNbkD7IUITbILCdmATXODv?=
 =?us-ascii?Q?2L3pqUjE6pMMOROMC8a0Nrgm59Y0/sKS1U6y8QZEJALlM7ADKK9FAhgS/wb2?=
 =?us-ascii?Q?18tnTqAlyGPNYeI2uFTqQLJxe9vad7Kxg9w5QGXNcfWbM3saxe3F/XnojOrv?=
 =?us-ascii?Q?xYODgW2fNh+MtxQJtY2NAzRbsijDPxlIe2EgJRN9UK+C15AuhJGBXQSc+HYG?=
 =?us-ascii?Q?KwsNOHaQyOLrKEvKgBso24QwM7S6QdV4cwV+g2wkl2pAD5bHpCwdRXHKfPqr?=
 =?us-ascii?Q?Hjze60Fxgtssuh0F3iJeBnOuqmj0bMIfflzGLrnQCUJhxxZ1afw7NTqgFsbd?=
 =?us-ascii?Q?fNrjeGC4gG1N3AKkfLX+5yiUu2JCc3ukEhX4ppganktVoPMasGm4P4NJiMYj?=
 =?us-ascii?Q?MZl/aXhnxYGP/WAyuyhT20SDgqU0KeuCmdp7Zt4kJghn7pZZiiAV4+97zLfC?=
 =?us-ascii?Q?eKZej1d/MRHCl1jmPuPcaDFTZe/b1OQjTBxCThr52v0514pDl7GACip7MDZ6?=
 =?us-ascii?Q?ucem5j/8DNlBTOcMZVcePiCiPtlmkpsDrKKCLZDx14Q/Bci3Wh2MCaWboJ8l?=
 =?us-ascii?Q?gnLIkJPUR88b2/yNam7R5rqIAjp0xmujU1Qtwt5kw71r9WDPe/Th9+uNpmgV?=
 =?us-ascii?Q?ON0eRChNpJ5/yjJWtcfn2XgYQctK5HKTizMzWuT9wlrEfUisGirx844NBXYL?=
 =?us-ascii?Q?gkq6qmdBdOawG46BjWab12N6FgiVTcC1hCWSx1QWR/l+b+EeQwPcle3C8wxW?=
 =?us-ascii?Q?ZOqHMJ3FbMPjFgv8cVyysnClOSMx/Pw+W+vQaWPeRv5RblJMVkOZKrfH2mCa?=
 =?us-ascii?Q?eEWx5zr/CTIFoEqtObB6RNo9t1V/mnzNKz8usBb5raQyJIZopbYAcd1NC0jP?=
 =?us-ascii?Q?yA8X0tdeMOkFkLkbqFCOyC/Q8+P2Bzh0X9o5Ac+2e1HYecAqGhTLuGzs/tbG?=
 =?us-ascii?Q?jaxI3sT7PKgKUU88HSycsW59MwdaKxu2RiqVQqBB3JWxk8aLpo58GKVepMj5?=
 =?us-ascii?Q?Qr/KEqp4hmi5MXfisALg62DyFvXWfI4fSUmNdt4Ep/yG7BYQhVGgRUgyrpZf?=
 =?us-ascii?Q?7xbMaiHGRiHUj3iOCwMxd9WAjATVjGj4lyiBXpEhcH+d1xB0K5SawTxqdg1/?=
 =?us-ascii?Q?6ZPnxbRiqArSq8rQRJYBbrsNLNRo/wz7QuFkZ77DMknCVqKAhBktj1mwTCZq?=
 =?us-ascii?Q?rTdkw2SRZ0CcT95H8YDiV4gRqt7VTxOEa7xrGdyJwNcvbMBdHZ9bYL6y0I4m?=
 =?us-ascii?Q?IYNsDzFvNF+0IifOMBT2p2779WimhyaatMGGGpU7359wbWDet0GWx7uqDW5Q?=
 =?us-ascii?Q?Rbc/fF7blZ2IU6TB+JUasAqFkQQ+f5dKqFtL2Ds85jYuEewaxcJdD2w2E2UR?=
 =?us-ascii?Q?rDE9hWc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 09:48:14.4181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8434726-4676-4b0f-f65f-08dc650cd3a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168
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

Add mes mapping legacy queue framework support.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 22 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 14 ++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 8783b339066f..b22d50653899 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -786,6 +786,28 @@ int amdgpu_mes_remove_hw_queue(struct amdgpu_device *adev, int queue_id)
 	return 0;
 }
 
+int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
+				struct amdgpu_ring *ring)
+{
+	struct mes_map_legacy_queue_input queue_input;
+	int r;
+
+	memset(&queue_input, 0, sizeof(queue_input));
+
+	queue_input.queue_type = ring->funcs->type;
+	queue_input.doorbell_offset = ring->doorbell_index;
+	queue_input.pipe_id = ring->pipe;
+	queue_input.queue_id = ring->queue;
+	queue_input.mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
+	queue_input.wptr_addr = ring->wptr_gpu_addr;
+
+	r = adev->mes.funcs->map_legacy_queue(&adev->mes, &queue_input);
+	if (r)
+		DRM_ERROR("failed to map legacy queue\n");
+
+	return r;
+}
+
 int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
 				  struct amdgpu_ring *ring,
 				  enum amdgpu_unmap_queues_action action,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index b99a2b3cffe3..df9f0404d842 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -248,6 +248,15 @@ struct mes_remove_queue_input {
 	uint64_t	gang_context_addr;
 };
 
+struct mes_map_legacy_queue_input {
+	uint32_t                           queue_type;
+	uint32_t                           doorbell_offset;
+	uint32_t                           pipe_id;
+	uint32_t                           queue_id;
+	uint64_t                           mqd_addr;
+	uint64_t                           wptr_addr;
+};
+
 struct mes_unmap_legacy_queue_input {
 	enum amdgpu_unmap_queues_action    action;
 	uint32_t                           queue_type;
@@ -324,6 +333,9 @@ struct amdgpu_mes_funcs {
 	int (*remove_hw_queue)(struct amdgpu_mes *mes,
 			       struct mes_remove_queue_input *input);
 
+	int (*map_legacy_queue)(struct amdgpu_mes *mes,
+				struct mes_map_legacy_queue_input *input);
+
 	int (*unmap_legacy_queue)(struct amdgpu_mes *mes,
 				  struct mes_unmap_legacy_queue_input *input);
 
@@ -367,6 +379,8 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
 			    int *queue_id);
 int amdgpu_mes_remove_hw_queue(struct amdgpu_device *adev, int queue_id);
 
+int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
+				struct amdgpu_ring *ring);
 int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
 				  struct amdgpu_ring *ring,
 				  enum amdgpu_unmap_queues_action action,
-- 
2.41.0

