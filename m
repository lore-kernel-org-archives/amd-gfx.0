Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1688C433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C4EC60233
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4EC60233
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 990A189E9B;
	Wed, 24 Feb 2021 22:19:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADA8689DD2
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:19:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtElsNJhJU+V25P3yZODrPqHxR9qujr5ZgqHroHBWSDmLjtpxv1ogNeXwd/YTWd/MHA1oxSd62AqssXBX4TB/OAbg4cGglzpi652HGXyCj0DSmwgy9glTvDGiv4JOrYwopMSYAWN2/EVH0gMIjLGzBAINXf5CRdxhNA0ffdZ3j5fsPPhEKlxXhMOzss1NQXLuixV8FY5ZZdEMVmkeephThMV0SncxmCy0qD3jkI+C7xjgrxiw/agimV1NxrmQLZgBGt2clL1NU3eTTGx6CuV/EqTNvZaKmTl0HtpPeThz4yfwidkBSnoWo6oMZVYG+LlRX55LLraIBNQfYHX2qogaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaQccDEYkL3n1cro67rF/RzK2zniid88Z487s2d3lRc=;
 b=NvMdZ4FoOMK5/hHDelxmTq+kHwuGJCBuZ3qVgU4Ll2PJd8R+NmhYrnLAThZPxoCWhWp72rXjWcgN/deZMU8ibW3nNpBOL+gqtEw6bc5ExSyFqP++PkSIVN6mq/7KJ84/O2+SwDW9+Qvye5lKtv+EJg5x7+znaw9Jo6L/Gnuq6UrNuCu5Kz7JiVKxKddlFMdUBmmkzyX7+vXipSBgRCKDZyu4BEbO1nhSw08l09X5Egp7cQ8k8EnU/4jkhAAMQ9atOsFczhFidrqDdzezNyxf9w4bGLW0yZXhPy4z/LtGov6hfoKk4ddzKxNrOV4aaJvaKbt+bcplP8rAaRCy1sk00g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaQccDEYkL3n1cro67rF/RzK2zniid88Z487s2d3lRc=;
 b=24kgRwfR2di8tciorgxZtS89hl/REzr4vJ4/KUtcOmeeoQcXML+iuRC9bN4M07L2+2bEB1XFBex6yJkFPXcevnFGZohfsLhcJjqB3OpaBhxdEx9P5OWRDe0CExyWbY95Q8K1uWdCXZ6za67UcxvnDZqbKyAWh7k8a6zc7biNya4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4174.namprd12.prod.outlook.com (2603:10b6:208:15f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Wed, 24 Feb
 2021 22:19:33 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:19:33 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 021/159] drm/amdkfd: Add Aldebaran KFD support
Date: Wed, 24 Feb 2021 17:16:41 -0500
Message-Id: <20210224221859.3068810-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:19:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dfce75aa-346f-4e88-97cc-08d8d91242eb
X-MS-TrafficTypeDiagnostic: MN2PR12MB4174:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4174BD5F1F384E97C86CDFE5F79F9@MN2PR12MB4174.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:65;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cezsEz+2w9gjJZJh+bSQ3puO8QJ6xXcF9yFZ4iWGfy5tWt16I1U/CoXRZABJKhBXK1GzOcpAwLpzbFPJin2O28NYQYOT98HqUQr20jwwqPczjxWX2uON/9AwS5ogroHikZWeTJ6KkcQmGNAOeHVeF/Eb9U4UK2iL+szegSR9UDOMCuVjcu9BZwA5XwMCJSuZxRtWdIhBw+V+a2Zv7u38m+eY4wB7bFyafqsJGQJX7/8TeedRR7dO9GUyYKU9YKMpWcdAAJMotq4qk6xXErAhW5rrc5DysBS9jQLvv9008hZVcclt7AH2UMUIu359V6OoDqUnng661rAJFtHe0VK+X6JBXLMxmI55J/jwG08mL7IKnzP1iyOXx0TLtjETHbkSUxSxSLmuw4asZwJGVMIdI3H9bj1tg0xKjuGamen6MzrpEqZ8nyi7+tplvAi+X06BuOBrkXPjKjDNZpLZ6Nm1g7CRs9EIq/Y7Iyi9lOOmIkIvnJv9+z6pudojaZffG/I3cqd+Co4dygYFecYBLdYnGPZklCsSPcX6xMBOwcBFCMfnJ6dDxk3WrgBCCoKKaKEY4Fn5Sk4tKKrpQ72HEYHRuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(8936002)(52116002)(4326008)(186003)(2616005)(83380400001)(1076003)(956004)(6506007)(26005)(6486002)(6512007)(54906003)(66556008)(316002)(2906002)(86362001)(66476007)(66946007)(6916009)(16526019)(6666004)(69590400012)(36756003)(5660300002)(478600001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9dgt6XHaSJ5oXKA99hxXjp/+4cdWssa9OsYiCEDjxD3S6TymIxTlwPHaxrs4?=
 =?us-ascii?Q?Gdao8mTaDglHHoRnCOuSK7mnNcnoZw5RLXKUoS/5xLpZgCglk1DDtSfvw9p8?=
 =?us-ascii?Q?/fkXGdk43wLui057WbX4KFhzS5nMbBCP1ZoEHUqKmQMb6Mt1LuwRvj7nCGMd?=
 =?us-ascii?Q?f5LTwR85dp3oAbPIjGL5bFDSGoyD/3N/wSVOLxrMVAdbI9nipj9Qv/QvfhVK?=
 =?us-ascii?Q?24tO9xJeQVDQYYA+FeDI5L/mJIy18bJGqAwlWmvlHBEz2IZspm2igvWLyd87?=
 =?us-ascii?Q?+/sc7uB2SHPKxZiocXPRu/dRQlhJgMyCyt+4UHcRkvlWe48SU25PYxkOXnGL?=
 =?us-ascii?Q?xnJX+tRc2jVdLDbZ7WVqaLUYRJhkLqdYKC/RPM79g3h7jcuUGUCI5hzsSBoA?=
 =?us-ascii?Q?yR0tLWvPy/ekHyE1NxnL2K2LsqrsX1E5lrTn3WMpCW5JrsLrmyxMl/JoARFq?=
 =?us-ascii?Q?oZOn3jHgLj1eI1rR2x172xyyt4LRRRKJnmj3tp7yt4A89y4enP2OYqvPzeXt?=
 =?us-ascii?Q?19AvvquLA2Crq8XltacELyj6CvjDPA8H3EGGNTxl81slU/GZn6MshQssM+a1?=
 =?us-ascii?Q?4cDnP9VhmN5fjBwoo98THk0jILbtjGQVUSb/DHljEXnMyn6kU6iejTiwdnGC?=
 =?us-ascii?Q?DSsJZjXmRqy3mf42SconQkmSbd0mq6SPJMjnSayQu0otaCjKfDv1XxzbeYif?=
 =?us-ascii?Q?9dFP4awxYy+A0CeyN11bntWELKJl3DXJ7dri9KfX7F/irGkzBLwT5wX800Ty?=
 =?us-ascii?Q?mekdHqzYlX5AmjmZHjXQ6TIQOcKB439+C5ORATSbivQSeLt6JlLDH3PQWzt5?=
 =?us-ascii?Q?JR6BVvAvvFJeWNi9Vi6yCB4GgcQWsr57mVeoYggTwvkC18hGMuDMgg8Pe3pP?=
 =?us-ascii?Q?vzglHNW79Zp97HmmDYzng/zim5tLKMKdlufZ/zxADjGQ3qC6+J/SEQ3ag5Vm?=
 =?us-ascii?Q?xurSTLzlwR0tTQdjxOF5rX69XgWS/YqhicXkkNArooE+StaXexzreBQyJaxe?=
 =?us-ascii?Q?gLSORlrqtm94jdO3yiHGga8ve225NkJ84CutB9WgVTVHgO46xQrIoZsw/fUV?=
 =?us-ascii?Q?pgcJpuGPsjHi1jv9MbQLmy39DxL6O3CaGlwqzlVwKwOA4AoZFYPZ9K8MBLdv?=
 =?us-ascii?Q?E7C5C8OPKpbD1bZad51gLYfK02lDR2/vvzFCTkkHpzXJecUOdC+YMZwnw3vi?=
 =?us-ascii?Q?QRXY/xHQ1bdqc4whs43LnhfZr+TpyiAlXcIlZyiZPQRzs0Jpr9vd2H//XPHh?=
 =?us-ascii?Q?kAxDq1ovebKnfT/0y9SXgrQm7tTZWxrNE/Y+0TmEAr6/qyY9t2xLZfzUwu5g?=
 =?us-ascii?Q?a2cb/FibTC0h5kZL6c8VptVp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfce75aa-346f-4e88-97cc-08d8d91242eb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:33.0341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fj47CXZyM+V9Vg/v8trRrA965tt0RQi9LCgjJZe7JILAyfKLSWcNg/dKVxRIgepB/Din0jqNz8YLaRoGMKYjRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4174
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yong Zhao <Yong.Zhao@amd.com>

Add initial KFD support.

Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 23 ++++++++++++++++++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |  1 +
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  1 +
 8 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 604757a1e440..6f6dfd950e01 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -47,6 +47,7 @@
 #include "amdgpu_amdkfd_gfx_v9.h"
 #include "gfxhub_v1_0.h"
 #include "mmhub_v9_4.h"
+#include "mmhub_v1_7.h"
 
 #define HQD_N_REGS 56
 #define DUMP_REG(addr) do {				\
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 99ad4e1d0896..8781051afb69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -413,6 +413,7 @@ static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
 
 	switch (adev->asic_type) {
 	case CHIP_ARCTURUS:
+	case CHIP_ALDEBARAN:
 		if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
 			if (bo_adev == adev)
 				mapping_flags |= coherent ?
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index a5640a6138cf..533df07964ec 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -665,6 +665,7 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
 	case CHIP_VEGA12:
 	case CHIP_VEGA20:
 	case CHIP_ARCTURUS:
+	case CHIP_ALDEBARAN:
 		pcache_info = vega10_cache_info;
 		num_of_cache_types = ARRAY_SIZE(vega10_cache_info);
 		break;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 72c893fff61a..f0b5ac4eb849 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -71,6 +71,7 @@ static const struct kfd2kgd_calls *kfd2kgd_funcs[] = {
 	[CHIP_VEGA20] = &gfx_v9_kfd2kgd,
 	[CHIP_RENOIR] = &gfx_v9_kfd2kgd,
 	[CHIP_ARCTURUS] = &arcturus_kfd2kgd,
+	[CHIP_ALDEBARAN] = &arcturus_kfd2kgd,
 	[CHIP_NAVI10] = &gfx_v10_kfd2kgd,
 	[CHIP_NAVI12] = &gfx_v10_kfd2kgd,
 	[CHIP_NAVI14] = &gfx_v10_kfd2kgd,
@@ -392,6 +393,24 @@ static const struct kfd_device_info arcturus_device_info = {
 	.num_sdma_queues_per_engine = 8,
 };
 
+static const struct kfd_device_info aldebaran_device_info = {
+	.asic_family = CHIP_ALDEBARAN,
+	.asic_name = "aldebaran",
+	.max_pasid_bits = 16,
+	.max_no_of_hqd	= 24,
+	.doorbell_size	= 8,
+	.ih_ring_entry_size = 8 * sizeof(uint32_t),
+	.event_interrupt_class = &event_interrupt_class_v9,
+	.num_of_watch_points = 4,
+	.mqd_size_aligned = MQD_SIZE_ALIGNED,
+	.supports_cwsr = true,
+	.needs_iommu_device = false,
+	.needs_pci_atomics = false,
+	.num_sdma_engines = 2,
+	.num_xgmi_sdma_engines = 3,
+	.num_sdma_queues_per_engine = 8,
+};
+
 static const struct kfd_device_info renoir_device_info = {
 	.asic_family = CHIP_RENOIR,
 	.asic_name = "renoir",
@@ -556,6 +575,7 @@ static const struct kfd_device_info *kfd_supported_devices[][2] = {
 	[CHIP_VEGA20] = {&vega20_device_info, NULL},
 	[CHIP_RENOIR] = {&renoir_device_info, NULL},
 	[CHIP_ARCTURUS] = {&arcturus_device_info, &arcturus_device_info},
+	[CHIP_ALDEBARAN] = {&aldebaran_device_info, NULL},
 	[CHIP_NAVI10] = {&navi10_device_info, NULL},
 	[CHIP_NAVI12] = {&navi12_device_info, &navi12_device_info},
 	[CHIP_NAVI14] = {&navi14_device_info, NULL},
@@ -636,7 +656,8 @@ static void kfd_cwsr_init(struct kfd_dev *kfd)
 			BUILD_BUG_ON(sizeof(cwsr_trap_gfx8_hex) > PAGE_SIZE);
 			kfd->cwsr_isa = cwsr_trap_gfx8_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx8_hex);
-		} else if (kfd->device_info->asic_family == CHIP_ARCTURUS) {
+		} else if (kfd->device_info->asic_family == CHIP_ARCTURUS
+			|| kfd->device_info->asic_family == CHIP_ALDEBARAN) {
 			BUILD_BUG_ON(sizeof(cwsr_trap_arcturus_hex) > PAGE_SIZE);
 			kfd->cwsr_isa = cwsr_trap_arcturus_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_arcturus_hex);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c37e9c4b1fb4..a0daf0ebbe78 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1918,6 +1918,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 	case CHIP_RAVEN:
 	case CHIP_RENOIR:
 	case CHIP_ARCTURUS:
+	case CHIP_ALDEBARAN:
 		device_queue_manager_init_v9(&dqm->asic_ops);
 		break;
 	case CHIP_NAVI10:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index 98a5e1d719c8..a2c9063076cc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -412,6 +412,7 @@ int kfd_init_apertures(struct kfd_process *process)
 			case CHIP_RAVEN:
 			case CHIP_RENOIR:
 			case CHIP_ARCTURUS:
+			case CHIP_ALDEBARAN:
 			case CHIP_NAVI10:
 			case CHIP_NAVI12:
 			case CHIP_NAVI14:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 5d541e0cc8ca..d903f694acba 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -242,6 +242,7 @@ int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm)
 	case CHIP_RAVEN:
 	case CHIP_RENOIR:
 	case CHIP_ARCTURUS:
+	case CHIP_ALDEBARAN:
 	case CHIP_NAVI10:
 	case CHIP_NAVI12:
 	case CHIP_NAVI14:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 0be72789ccbc..cdef608db4f4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1370,6 +1370,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	case CHIP_RAVEN:
 	case CHIP_RENOIR:
 	case CHIP_ARCTURUS:
+	case CHIP_ALDEBARAN:
 	case CHIP_NAVI10:
 	case CHIP_NAVI12:
 	case CHIP_NAVI14:
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
