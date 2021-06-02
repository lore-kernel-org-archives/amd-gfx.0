Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E88CC47092
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1310961C2E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1310961C2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3344B6ED7C;
	Wed,  2 Jun 2021 16:49:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66B226ED1E
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxNMr8aLEAlcbDlIaSa3GrspGNcsT9hNVGV+BKAl82tsnTQ0nY1qSOvXD8iZVb7kTAmvWtsv70lCixdbGGO15N4o0aP5KJV5p6JXAbIs+LK9VwjXluP0a8zgTTvgOT/VLoqo4xCn7HXS2881qQ8gdCbkny1NS2fEYFlxzzSWO0I9uXU7WJEgK2qWmXO60CEnUAv1hT+jf/LMCYkZhVqF4IVvGviuny4cBDPVLGx9efcU1Vavkyrr18YHlnqw7169emDub/naJ4Gh7ZvNlOae2I+yOtE2gWrRkBivfvMpUm7WrTx398w921FnU0MPDJu58Jww9rmbTTYhWsHrKrRuag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XREh2Ez7W/gnTV2eYrZBLbAbwi9D4efqEDas6IGvhA=;
 b=iYffMyR1ihAwnHWljWAbYJLFM7949lT8y5vsMRLwyz06Z6AE1/Y1qACZ2ZzQpDsTFdZ1/Bn+998I0UyMr7ulviXf3H7cHMoso3aGiZP7wFfuXWgzF9OxDFB5RLMiklLqrcilgTqZCrvH/MRWgYIgYVT2F18fIGBFbI/4BxyS7QvYygTuCw3JNzTlFzmiDQuaQfKD32/JY6LW4RuFST1uftPQBB74ajT1acYqgqeY2ZNFw71bg1+srx2okForGBWJhpC69qilcTiuKTJMQHjaxEI6WEM7t7NHzUbtGs4RnkLZFC3Oj4ezSyA36TKz5QMu8NECWGc3serM+cqtjmzEaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XREh2Ez7W/gnTV2eYrZBLbAbwi9D4efqEDas6IGvhA=;
 b=KNRO4Y1az7ZwxPWndBUmPG82fJlTizfuHqGFgqtBf86DMNw4xEP8odCai1oZqKZtFFzNSBVYiF6ZgV3emHPW/RHuKdOaAbXZSFb5tdHVh1K0asEgLoo175Usr/KTCOLWFkvv6TivJU3pfvXu6Y8rm9sIyqzxY1kIqxckLCof+FA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Wed, 2 Jun
 2021 16:49:37 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:49:37 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/89] drm/amdkfd: add yellow carp KFD support
Date: Wed,  2 Jun 2021 12:47:52 -0400
Message-Id: <20210602164908.2848791-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:49:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c49d187-617a-44e5-a219-08d925e6681e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4077:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40775B0C8094DA7B81749B45F73D9@MN2PR12MB4077.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:67;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WR96LFJzpwK1iUiN1ySnHZ2RMxATl1xzQ5HPPnTbUiyxiS4n9vcEhf8+LLtSE9tbkWSRLy5TVJBiXpuP7ccXky92Iwb95IcbQG5ReLE45pvuQCdKaBHkyBRAFprapW6Xu7MDzB6uqXavCDDHSzlfSfA3FK66Gc88eJfrBp5/w9YGpLlqBTOgopw3ssni2xIgNNUjiwu49zG1lBNuRaUUvPGGxUtoyWvAr0SUcqY6hgVLHGyNHRMx86qHKbMM0YETOY6XpyedI6tVHQMhIOBgE4I2G6Mh8NpUPxL8dHArcOZZ0+x/+QkIc84NyeAqI6NbH2ANC6ySV1pxvHdjlXl3MGcvLwAul+LxOb6LjhWUe339JDySHNEpumNisoBXb32DCmpwpYjZxSyS01fEWboHASJAF2rIms7fLin+Ng+FmIi0R5zjucY3riHP+cUkfc8g8KIHsOnTP8r1JejUnbLr2T7NBje2OtQZvi13LH3usyuwFd5mLAgiZqxGj5Rza1P3z08KXTVXdZI9H31iHmg6iojx7GR8pUK8ucw4Fz6c7U6+rlArvWy3TSKrr1cVyOyMrBBz0/0dxO+82QXygGT4JMMFT/pxYNmS8rVQBBWX9c2pMibS0DFgNf0SNuVM8WLQOrGT7T30JR4hcTOyqExPSk4lZbOXifOVmX1I6FiJOVpnVu91fHZ7RBKhE40ZuAT4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39850400004)(8676002)(54906003)(4326008)(5660300002)(8936002)(6666004)(478600001)(316002)(16526019)(1076003)(6506007)(956004)(2616005)(52116002)(66946007)(26005)(66476007)(66556008)(2906002)(6916009)(38100700002)(38350700002)(36756003)(86362001)(6512007)(186003)(6486002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LJPVyNoV9RU/FVVJV0QXo//PyZSakxhPrbnpmaDOf+c7kDGDOet66qIEqn7q?=
 =?us-ascii?Q?MJKDlSYvJOtgwxhM+aT6vzkbRU8TNf36sbpBGot/t64eDqnUMquggHhAp0OJ?=
 =?us-ascii?Q?px735EoaUs5zV/viksEryVRNfLTIJux4KFcT458WqF6NeelCWddzOrD+53dJ?=
 =?us-ascii?Q?I5Xdgm3kNW5BeuQLCMKvF1D6BmG3yNdqj0orwcoyoXcEAIpv0V4sDQuDnPtq?=
 =?us-ascii?Q?8rTcnaIzPGblgDaKV4Tko+BExpJpbZNof0uUcYxbV2aEutHD5ElMW39Qbldd?=
 =?us-ascii?Q?22bgsjqoN+m1ii/GS8A2A/ABFEU0HK8cz3ZMIn1lT1Bv/kEItd3e2cdkweHQ?=
 =?us-ascii?Q?nTQcDUCWmyGux/O5osIykoGNLJBk9P6i5wlwal0eEgwwo/DW/UpsuSRZ9hpG?=
 =?us-ascii?Q?ewTevMYhMLSVHcqtt8W4vdbSKmPlxah5PIXIryAHXxbCnJ2cKGdu4dvXQoBN?=
 =?us-ascii?Q?Nxsp7YbNE9KVbcDUu2b9fect5Sh1STpUJRpI88MgvukxXUzVKGUjZ1ACmmbT?=
 =?us-ascii?Q?G4Vt9lrbJ/VWZNsuqlf3aF9+SiWY2ZQh9gusJnDnaof8Wz4VBZHLDqrn4L5+?=
 =?us-ascii?Q?sd/FzdNiNQ5w4ikzzxN+On8AhlMLTsxyLvLQDTcuTPkk7eWbCH4XJD0ZANbQ?=
 =?us-ascii?Q?We2aHq86xiZ1rhJTRmvRxSbS/KKAiAc0TZbQ8TufPmandJS73oLb6jJVLYCH?=
 =?us-ascii?Q?RdR+SENqDqxevi0FC3BQdK2+/OUNv+qi252Qf0ZHQhNOvzGADtP+uD+hKVNd?=
 =?us-ascii?Q?sRWIuUePdJuvyDmkDCj4uriibtumWfymuqNUcTcprjB8xC45GilEyoUDztRh?=
 =?us-ascii?Q?JPfi390Eu/Ksitwxrniu1fanEDqCmf7B9hCjT3oL7z6uCei23AePPw4KudsJ?=
 =?us-ascii?Q?ZQqCyGRO5qlY/HNxujWaKZokKWFw8TNITsWd9c2GDuftJicaa7yvyas6QgaJ?=
 =?us-ascii?Q?TeEzSFMemg09K8modizmI5dwNFuZsNVSzV5ZATzWQx2MfmBBLhSDXhzTBXm7?=
 =?us-ascii?Q?QkyEQlBxtpvxZpdFs6DMOKjYSyvfBbahq56Jp2J31ll0zncIpYvITcTXaefg?=
 =?us-ascii?Q?0SvirHMngkCmPCC2BfvH9owK3GWY/jUJGmHqcjX/qAf3cKGHU1W7icelLVS9?=
 =?us-ascii?Q?S1HpB+4pPyfWaoNlwyZh/RP0ZvC0asJDyCB4/xLOstQCTf5RHXhSCghRhSQf?=
 =?us-ascii?Q?JN9uSAk4bsHt6s9u1pRGqEJggHG5vO5Xnlmishisub9Hlf4iuMhLjFSObio5?=
 =?us-ascii?Q?Lb1yuk5fyOKZfCBpYlwkvepglUliaxP7pF5AiTk4fsRWgFqTKvpjCJZxtOd4?=
 =?us-ascii?Q?pdaRoYm8fnZKXpmOOZbCJRto?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c49d187-617a-44e5-a219-08d925e6681e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:37.1290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bv06cdexCcmwJDlc6NCIQFdh+Nmm40alO0likKskmyeyWOfcWK6eH4aoBlvw6q6h38jSmZF8ANUePLVVNNwoxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

This patch is to add GFX10 based Yellow Carp KFD support.
We will bypass IOMMU v2.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         | 52 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 19 +++++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |  1 +
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  1 +
 6 files changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 3251fe224f86..c6b02aee4993 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -746,6 +746,54 @@ static struct kfd_gpu_cache_info beige_goby_cache_info[] = {
 	},
 };
 
+static struct kfd_gpu_cache_info yellow_carp_cache_info[] = {
+	{
+		/* TCP L1 Cache per CU */
+		.cache_size = 16,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 1,
+	},
+	{
+		/* Scalar L1 Instruction Cache per SQC */
+		.cache_size = 32,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_INST_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 2,
+	},
+	{
+		/* Scalar L1 Data Cache per SQC */
+		.cache_size = 16,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 2,
+	},
+	{
+		/* GL1 Data Cache per SA */
+		.cache_size = 128,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 6,
+	},
+	{
+		/* L2 Data Cache per GPU (Total Tex Cache) */
+		.cache_size = 2048,
+		.cache_level = 2,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 6,
+	},
+};
+
 static void kfd_populated_cu_info_cpu(struct kfd_topology_device *dev,
 		struct crat_subtype_computeunit *cu)
 {
@@ -1383,6 +1431,10 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
 		pcache_info = beige_goby_cache_info;
 		num_of_cache_types = ARRAY_SIZE(beige_goby_cache_info);
 		break;
+	case CHIP_YELLOW_CARP:
+		pcache_info = yellow_carp_cache_info;
+		num_of_cache_types = ARRAY_SIZE(yellow_carp_cache_info);
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 80015e866498..9e4a05e937f0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -83,6 +83,7 @@ static const struct kfd2kgd_calls *kfd2kgd_funcs[] = {
 	[CHIP_VANGOGH] = &gfx_v10_3_kfd2kgd,
 	[CHIP_DIMGREY_CAVEFISH] = &gfx_v10_3_kfd2kgd,
 	[CHIP_BEIGE_GOBY] = &gfx_v10_3_kfd2kgd,
+	[CHIP_YELLOW_CARP] = &gfx_v10_3_kfd2kgd,
 };
 
 #ifdef KFD_SUPPORT_IOMMU_V2
@@ -577,6 +578,23 @@ static const struct kfd_device_info beige_goby_device_info = {
 	.num_sdma_queues_per_engine = 8,
 };
 
+static const struct kfd_device_info yellow_carp_device_info = {
+	.asic_family = CHIP_YELLOW_CARP,
+	.asic_name = "yellow_carp",
+	.max_pasid_bits = 16,
+	.max_no_of_hqd  = 24,
+	.doorbell_size  = 8,
+	.ih_ring_entry_size = 8 * sizeof(uint32_t),
+	.event_interrupt_class = &event_interrupt_class_v9,
+	.num_of_watch_points = 4,
+	.mqd_size_aligned = MQD_SIZE_ALIGNED,
+	.needs_iommu_device = false,
+	.supports_cwsr = true,
+	.needs_pci_atomics = false,
+	.num_sdma_engines = 1,
+	.num_xgmi_sdma_engines = 0,
+	.num_sdma_queues_per_engine = 2,
+};
 
 /* For each entry, [0] is regular and [1] is virtualisation device. */
 static const struct kfd_device_info *kfd_supported_devices[][2] = {
@@ -606,6 +624,7 @@ static const struct kfd_device_info *kfd_supported_devices[][2] = {
 	[CHIP_VANGOGH] = {&vangogh_device_info, NULL},
 	[CHIP_DIMGREY_CAVEFISH] = {&dimgrey_cavefish_device_info, &dimgrey_cavefish_device_info},
 	[CHIP_BEIGE_GOBY] = {&beige_goby_device_info, &beige_goby_device_info},
+	[CHIP_YELLOW_CARP] = {&yellow_carp_device_info, NULL},
 };
 
 static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 5914e38a9f72..8e1696c29922 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1937,6 +1937,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_BEIGE_GOBY:
+	case CHIP_YELLOW_CARP:
 		device_queue_manager_init_v10_navi10(&dqm->asic_ops);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index 0e5f5c5daf76..91c50739b756 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -425,6 +425,7 @@ int kfd_init_apertures(struct kfd_process *process)
 			case CHIP_VANGOGH:
 			case CHIP_DIMGREY_CAVEFISH:
 			case CHIP_BEIGE_GOBY:
+			case CHIP_YELLOW_CARP:
 				kfd_init_apertures_v9(pdd, id);
 				break;
 			default:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 5f10dbfa58ee..d8e940f03102 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -250,6 +250,7 @@ int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm)
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_BEIGE_GOBY:
+	case CHIP_YELLOW_CARP:
 		pm->pmf = &kfd_v9_pm_funcs;
 		break;
 	case CHIP_ALDEBARAN:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 9be66ba24af9..f668b8cc2b57 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1399,6 +1399,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_BEIGE_GOBY:
+	case CHIP_YELLOW_CARP:
 		dev->node_props.capability |= ((HSA_CAP_DOORBELL_TYPE_2_0 <<
 			HSA_CAP_DOORBELL_TYPE_TOTALBITS_SHIFT) &
 			HSA_CAP_DOORBELL_TYPE_TOTALBITS_MASK);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
