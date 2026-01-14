Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD86CD29FE7
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 10:48:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CFA910E5F3;
	Wed, 14 Jan 2026 10:48:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MRV21N1M";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010061.outbound.protection.outlook.com [52.101.85.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90BC210E5F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 10:48:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qkWQACh7l9MgXjWXE/GKXKJoYFefD4FarCq03o5BrAYG6TOgIpBu+og+rX0OIxPO1pJA32MKGrVMU1n24eqS5U8JCKynDxs4DF6FYMh5nfGvLtXR/2fXwTKYn0xUZUIgOs2gqs6gWd3/ycPPNgxtkTdhgFr1ITJD1auEU1ugOf6bDlhvY7Sr9EM1wa85jb1x1C6YjPhMy94umfOO01wdlbphYs+KtPcYTs5l/YpcKqP2XOagAceE8BbjEBdgGhs4hSPIddzATpVOQb7LsqwD7TbZ3uhQYvaoH8HH9/xvrdIUwsaum8WDrrOCjf0AztaTLtyzBOxxtwAAMTO9UQaswA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvDshUZRru2oFIHNA6YIONGcSsjqCMbLVvPACzJ4so0=;
 b=itVDiPlZhyM//5lNv2HeGb0UxrD+fdTj04Nu5CaML/CZk/9pKb4VigKdbEeQo+NJjHV4qk0WK9JdL6ziOl/5gkt8/bj3+zV4/RBc7ejzkh4SdAm9qeFDzjDUxQKuVCxw2GTqbIthxm04ADhB0Vq0M1ch2iSrw3B1WiDe8wGCEsh2bw3zGKX5HHqpAhCB227jjlHa7BPznmqrkgy1nvLJasivm+j17f9S7dOm6ANng8OakAZHLcxaNQKBLG15hG5gjsEzJOqd2T/N478Q8jL3Lv9LZvRRHddAdcoVmlz2z8HyqqKvsEepYMR6YMVoluU5U6WmUZZJbUeljmP3tmNbHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvDshUZRru2oFIHNA6YIONGcSsjqCMbLVvPACzJ4so0=;
 b=MRV21N1MwrqsGD0lqkhqGswT5/Y6wwu+N8vjo50GtnoFy32/1sXrQ3MD1Mv3+EubRhTpiIvYzib9DPzMoKm+Ph0NBmH9UT8TIeJdtv0R1pFhsfYOJz5RjBXouox4thHlIcSVXoD0SkH58KZ7oNLsawvXsWssvDV8E5Zv8aI5V90=
Received: from MW3PR05CA0003.namprd05.prod.outlook.com (2603:10b6:303:2b::8)
 by DS0PR12MB8342.namprd12.prod.outlook.com (2603:10b6:8:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 10:48:38 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:2b:cafe::84) by MW3PR05CA0003.outlook.office365.com
 (2603:10b6:303:2b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Wed,
 14 Jan 2026 10:48:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.0 via Frontend Transport; Wed, 14 Jan 2026 10:48:37 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 14 Jan 2026 04:48:36 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu/userq: Fix fence reference leak on queue teardown
Date: Wed, 14 Jan 2026 16:18:20 +0530
Message-ID: <20260114104820.122612-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|DS0PR12MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: f45b5199-2f7a-47f0-19cf-08de535a794f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTNydng5aGpiSnFrR3Y4K2hpajhqZWZ5T0tWbG9kZDgyOVZWY1dpRnk1YWtF?=
 =?utf-8?B?UTlvKzROUXhWcXRSb2hCS0hlc3dlbmo2UXVxcmFOK2RCU295WnhQc2pwa3BW?=
 =?utf-8?B?SXdOWklsWDRISHV5dGlkM0ZIUWZnSGRtM3lIS0tFZElSRlpVV0R1UDlkeW0z?=
 =?utf-8?B?cnE4dkpIeUJGbWh1TEVLRjkrRFhwYURjR1RQdDg1TlpSSXJUQnZHL3JBZWkw?=
 =?utf-8?B?WThTSFZaS0lESDBQM3F1UG45S0pzSXY2U29YYkJFNjhSKzBOSTJtZm9Da1F6?=
 =?utf-8?B?dGxQeCt5YktrYThNTmJFZUlZZEx4NzJ3T0crSVg2WjNXVzhndjN4Vkt6K3o5?=
 =?utf-8?B?aVNCR2YvbGlYN20xSGlYYUgxOVBYa3BVMG9zNllITjVhQ2pVckpyZ2FtY1d4?=
 =?utf-8?B?WGIzZU1xQmlZVXp0cXRSNnl3Q1A4R3dRbG9Ta283Y09hanJpUGc4c1RCYys5?=
 =?utf-8?B?bUVRS3FmQS9reUgyRjZlRGQ2emg3c2ZONnQrcCtSeFlyaWdVNU9aZUZNU1dI?=
 =?utf-8?B?MmhNZ1ZsemFvdit0aDRzalU4SDl4T0c3KzBQaHBhYzJ2VU51Y240b0FlQVRL?=
 =?utf-8?B?ZmZmTXVMVWQ3Z2NtZ2g5V2NxYUVGZm5VOG4zS21LWnJMcHQvOXFRNkN4LzV4?=
 =?utf-8?B?cDRqelZTYUtRR3I1STBOZTNKclRkRjY4Q3BoOUxCekJVZUF1VUJDbjhUdW9m?=
 =?utf-8?B?R1lEUTZGMFFqclhyQmR3SW1VcHF4U3dJWEdqT1lBclNvSk5Sc3BoSERiM0tT?=
 =?utf-8?B?QUtSN043UjhDRzlmdkl4QS9rY1FRaENnb0l2Y09VczNNUGh4bHFFaDVicTVl?=
 =?utf-8?B?WVlpKzJ4UXRic3ErRndqWFpPakQ0R1I4V2lUeHVYT2kwRVI1ZnhNNzAxdjZu?=
 =?utf-8?B?UU8xRDZNTjNLMW1KTFlNcTkwdzJPWndSUGR0R3Urc2h3TnVlVDk3ZjlGeEFO?=
 =?utf-8?B?cXBua1BsYnU3dk9qeVdIakx1VlVlNHhzVEEwVXcvNkl6QWhVRGF3a0xYcndr?=
 =?utf-8?B?aE5jbGpSOFZUOWpUVDR1QlBXMGNyT2hpQVZPWXFobXl6QnUxYm9LWmEzN1o3?=
 =?utf-8?B?NFV1TG5LYnh3ZG12a1psSVNsRTgraHpQeVRJRXVacEJPYUsxYXFpSVFwS1k2?=
 =?utf-8?B?NEZLMXhuVWtIeElyMXJmcHhoMDJzNUFNS1IrdjFWRUlxQVhZei90bHNTbGVC?=
 =?utf-8?B?cmZ1aFNxK2dZQTA2aXM2eEFPYXpCVEd6emFoRHFjbSs4ZVYrZkhLTk0vYm5E?=
 =?utf-8?B?Y3BuV1l2cGVmZ24wc3pDRlNtWlFKNGVsSnUzUnl0V0NnbGJhaEhHVjJTUkhX?=
 =?utf-8?B?ZkwrTGRZOXZnbmp0SW9UNENxOVNMNldnTjVXd1FOMHN0WThMai9jNzd2K004?=
 =?utf-8?B?bEdyZElDWi9yNkJ0R2JsZ3M3VHF2dmFnelFVa29JdWhUWXluL2xHZW1Ra2p3?=
 =?utf-8?B?STA3Z0o0Y3dwYm5FWGNFSTZnd25Manp6b0dhODVRaXg2YkN6dE5BTnh2SlNn?=
 =?utf-8?B?aGIweWRFZEhkK0tKV0tIckw3U0RLZWNKY1RFRFVYWUROL1M2MURKejZZanVQ?=
 =?utf-8?B?djlvbjNINU05RmtvR3hVZGxzcmEzaTltU1VnaDFnUVF0VFNtNFBMN0plZ0ZQ?=
 =?utf-8?B?MXZDNXIxY3NRODVvZXp0RjZVQjlRQzVubVdiMkZUNkdscGxYQWtTUnlTeFR2?=
 =?utf-8?B?RnhtZTI4ZzFqeVh3N05lay9HMVVUOGx4M2l1ZzhZMkhSdWFEck1aTHNML2Fa?=
 =?utf-8?B?VWVpL0xuaWNsTnRsbUQxSVlINmh5U29qeHZVcUdHbVVmMmJZVU5ncTkyVEEz?=
 =?utf-8?B?QzByRTZwNGl3VjlUbjVkKy9TL1gvMnExTXNxaHpQelVMMEVQbXgwQ3ZzRklH?=
 =?utf-8?B?ZFdVU3MvbjFIYTB6V3RsVi9lMWVQNVc4bjh5c3NhY3lzVXMxeUV4b1NnTGh1?=
 =?utf-8?B?RXRHZ2x2ZHVsQWE1SGZucGZlbVN4QWxxZStvTXNneU96UmZ6MUVSUEx3bFRw?=
 =?utf-8?B?dG44aVNLRnpmRnJFOHlINWJ4TmhPaUs3ZVNubHFjMEU1YlhyNmU2Q0hZREth?=
 =?utf-8?B?ZmhDWk01N0NKTU9JWDZUWDRHTjczVVI4N2VBNENPZVpQU2tocnJia2JSaUdz?=
 =?utf-8?B?Z2NidzMvRjRvb1FuL1ZzQ0FYSkxCRUlMQmtEQ0lROEpuK1RQNlJKTXNaNFNK?=
 =?utf-8?B?QUlpbGx6MFFPUHU3bFNSOHRYNXNham14QnZqUllUU3lZUzRDcExQa1R5a3Ja?=
 =?utf-8?B?MlBCQWtPc1ZvREFnYzZMU29yMmJnPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 10:48:37.9742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f45b5199-2f7a-47f0-19cf-08de535a794f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8342
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

The user mode queue keeps a pointer to the most recent fence in
userq->last_fence. This pointer holds an extra dma_fence reference.

When the queue is destroyed, we free the fence driver and its xarray,
but we forgot to drop the last_fence reference.

Because of the missing dma_fence_put(), the last fence object can stay
alive when the driver unloads. This leaves an allocated object in the
amdgpu_userq_fence slab cache and triggers

This is visible during driver unload as:

  BUG amdgpu_userq_fence: Objects remaining on __kmem_cache_shutdown()
  kmem_cache_destroy amdgpu_userq_fence: Slab cache still has objects
  Call Trace:
    kmem_cache_destroy
    amdgpu_userq_fence_slab_fini
    amdgpu_exit
    __do_sys_delete_module

Fix this by putting userq->last_fence and clearing the pointer during
amdgpu_userq_fence_driver_free().

This makes sure the fence reference is released and the slab cache is
empty when the module exits.

Fixes: edc762a51c71 ("drm/amdgpu/userq: move some code around")
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 3c6bd5531627..b13cf5114121 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -50,8 +50,12 @@ int amdgpu_userq_fence_slab_init(void)
 
 void amdgpu_userq_fence_slab_fini(void)
 {
+	if (!amdgpu_userq_fence_slab)
+		return;
+
 	rcu_barrier();
 	kmem_cache_destroy(amdgpu_userq_fence_slab);
+	amdgpu_userq_fence_slab = NULL;
 }
 
 static inline struct amdgpu_userq_fence *to_amdgpu_userq_fence(struct dma_fence *f)
@@ -141,6 +145,12 @@ static void amdgpu_userq_walk_and_drop_fence_drv(struct xarray *xa)
 void
 amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
 {
+	/* Drop the last fence reference held by the queue */
+	if (userq->last_fence) {
+		dma_fence_put(userq->last_fence);
+		userq->last_fence = NULL;
+	}
+
 	amdgpu_userq_walk_and_drop_fence_drv(&userq->fence_drv_xa);
 	xa_destroy(&userq->fence_drv_xa);
 	/* Drop the fence_drv reference held by user queue */
-- 
2.34.1

