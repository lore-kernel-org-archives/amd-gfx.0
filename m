Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECFEC43462
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DA3361132
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA3361132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D98F46EC70;
	Wed, 12 May 2021 17:31:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 294B16EC6E
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:31:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLlINw1OJKRaUL4yzWoaNTSXrknaa1vDMwsPBzO0QjWkj2QKR69vvmiKFg94eNfZGC2R61xKSO7/QDlgXcNzKnumVoEsJZXPQ4ZukF2Tiz8iSrBYm+425I9bkVhP4kVZzSS8VSBANJEDUFPPwTZ5f+XeaaJ5QLaSW1FZirzAsHJML3XJzWBNOqF4Hibvz2kM60jlBubjwjv/V2nHtpZomPWOTaIVFqrWeg2vhppIsMDuKKHoQsmU0FOmCmFTasJ7COCBQdeT4zC0A6/PuZaBmcgfjsvu0SpRjVHNFYTcZczg+U44fvwhBtEkWaICdnIReBkGVcrso3u0/av1dQLXSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxbQgrmtV+gjbicFoI7oJh0gtJwoBAntRZFrlUxzsjE=;
 b=ULrliWXN7e2Y6YQwluuNC/8Dk6TPtYxJ3hF/hJqJve3N0g1l4wlKyL+hwnrg1h0b+OemSWrcuJ5Ct3gG420oDuXDF01K4SHW2paefA9BquM+vsoHzQI6MGioOwcuuSnWRQF8TED1mz5SK8fcrxomNnE63WFsWoDjASIEyWXKVh6O4p2WydikpMr1hQ7uRaZWHdPmj+y/HAbEmkKls0EUrVKnRqxbI98erLTTuaz9EsJGljMjPRf79psJuYscZQLLeFKi9zyNSZGlRMGzhnObvdMMc34xEih5H7AkxNGHJlKT05F9ehVRC0xpp5GdJzaSPn0To0D+qpIEVUz7ohZlTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxbQgrmtV+gjbicFoI7oJh0gtJwoBAntRZFrlUxzsjE=;
 b=kxUqjhKWMM+VrOhZ5iSz6zU7PTHY+6SYsErzWV3CCxk4hhJonR9qgWEOBPWMZM5JZnReTmVKV4TNFgW2jRB0VZQ8UnC+dQqxljH9rGwnM82tegXZv0uIaWGE1NmRpTsE7kBLfRPr3rnUqMPGJWFWPqfhAqPFIOHLDlCEs2oQpG4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2340.namprd12.prod.outlook.com (2603:10b6:207:4d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 17:31:25 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:31:25 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 18/49] drm/amdkfd: support beige_goby KFD
Date: Wed, 12 May 2021 13:30:23 -0400
Message-Id: <20210512173053.2347842-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a922542-7d15-4696-375f-08d9156bc432
X-MS-TrafficTypeDiagnostic: BL0PR12MB2340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB234004415C8D6EC2F21B9945F7529@BL0PR12MB2340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:142;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S0jJuWfq33sol1U+Ow/pt5e72xBw8v3h2lPYPScIVz4hhaJ9lcWHTZytsCvJ2Ljd05JNbvhnMS6IUGqaw9fmYvwXdiNP05OsGnF1o1heaNCMBwOFe2tdKXA8jirVYLnj3EwPush9tk6XKLdrexjYlVhCbarhdJoca87djVjXfngBBoHL49uWv1gk9K21OsreXNF2IHFfkC0kGGfWU+UCTAc1eMXDZRL7dr9NXV5YFb9IhkQbwmVwVNq3j7b0lb3ePicJt3iojfttf99zmD5JQISi9GcozCLeVawXg9d2VD36ckSm6sugvORWC8J8/UlylBq7yK7t/yjLrb/slmXknF6C/YGGPLyvw60+cffyws94siytT/7pz4Yukf44KYBysXzflo8haQZlmCEF1nXSqrfm87/Kvzw9IGM52DkPI3AIJ3+CivwVwY8q5S3INOZzL4+kjANIcy7SA+yES+SqlDK/8prPzfjvNEzyYGaCG6Jbfm/cetVPtWgCvYjLLEbfPoQ8gfoM9P3W3ITwGEbTcP6LHqUeMSpeKyHF1ibRFbMpv4B9v1VucIwKQsPfMIGBgJ4Tz9fghY5Ju7pKk9lAQ8B/puls94ekn+kO8ds9ateNfThMjNL+sv5jTSvweJpAksoxkGfZE7IFS7K8rje+O/N/s2i5FVn5d7TuRthSoioY7awp4+HOGIRL2woH8mpg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(366004)(396003)(136003)(376002)(6506007)(26005)(38350700002)(66476007)(38100700002)(86362001)(4326008)(316002)(478600001)(2906002)(8676002)(52116002)(66946007)(66556008)(36756003)(5660300002)(54906003)(6916009)(2616005)(956004)(6486002)(8936002)(16526019)(1076003)(83380400001)(6512007)(186003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?E9ajYTfCVyeS8xa16QIAVZ0sjNaLaFZcetFH6n8tSQWbc8F/6Uew8PRdpq8+?=
 =?us-ascii?Q?8jBENutE47kRs6jTb04cHkVFol7sfBkwSFEeHpwCNDYr4pXZLXLYYWnzdasA?=
 =?us-ascii?Q?qZJ/zDc7Rgh4YrY+NsMxkUC4GOzoV79U2x1eE9kuSpt3H47qxIuneZJ7/CcR?=
 =?us-ascii?Q?EV7LeRJiDcmJHDezzT+IvR6SPUpdkSn5aQc8Sbd0ucxJ9ReSxMHiQHOCHAVp?=
 =?us-ascii?Q?rLTBimliz8fkOvtW8klSEDZrdZNdYI7n1NyxdrKqBKNY76BN4fl73K1qWnce?=
 =?us-ascii?Q?b/v4GEgaZoD8AyIbHsOL9gjrIugK2colFdqL1k+Qi+FZ/AYG0kg3hS7y5g1T?=
 =?us-ascii?Q?eGHRokQqvO7X0XpsHmGwjfzczyFBin9qEgk8Um0h66+R1tayavwbfMJEYjmz?=
 =?us-ascii?Q?QJSVREVf08sno1RVw9FW5RABeT/CZNRGNR4oCcggEiTEeFL5F1zEOhaMteKB?=
 =?us-ascii?Q?DTZoG0dbkfOw+X+Gr1GG/ZnbdvX6Wv+uF8Igx+5uy/wXdfdJXLqfurZ1eMd+?=
 =?us-ascii?Q?HXr+T/ccfJRJ2N75NbYPfBeqA4EWrIMx2Gy7hhs6Jj4e/WY5R3bN28JoCBtC?=
 =?us-ascii?Q?NkelgLCXC1c/CTb0iSEBqHJmxXWW8Y1sjPVCgpUz4NipM1PKdzUlElcVOtbT?=
 =?us-ascii?Q?TOQBFULkywo4clAUoQ1/P20jATZd2ziQc2t5MrKeesUkJtNx7gDAmFJREU/Z?=
 =?us-ascii?Q?2dO+GZLJj+7P1L6Kig1yii8oB1+Z8iGJg6GpOpAGxlIrRWqDQVbAopponGPI?=
 =?us-ascii?Q?E5nHVczJnr+EvFxDuxGZZUcu27k5wODwiWTSks9ReAzJAQ2DFS9MY/XXR1p5?=
 =?us-ascii?Q?JzlcyDwUSWtB3a5JjowZXXmS30PqUBRWnmvQD3NmN68RSHp3uW2cDJ0g+JUr?=
 =?us-ascii?Q?r0/KVQu7VtninD5IVTrGLNDUi+DkKf93DcaA86E/ynltLCUEAu7GqDStwQDe?=
 =?us-ascii?Q?U2ome7lS3P+S8Nfbt5IDa7+ctBU/VrD7U/US949XhKaLMPtHSU7m1/sTRPqC?=
 =?us-ascii?Q?U3KfvQHcsC/AvhVzqX4T9rWltNc8+UK8NGTcKUhuCiwixitbMo/X0gibu7yX?=
 =?us-ascii?Q?sBe2cJ8ITDeQGQdwyj3/u1q4iLxrw2jb1e7I50mG5XJI5XE9USAAgqFd8GG4?=
 =?us-ascii?Q?qpZh7ekUNUM3HIi6RvTBRhw/XIMbZeeRBWhgV8MIVIszkSBfto72/VhKX6/x?=
 =?us-ascii?Q?rVC2WxQJPcpXQUUmrmD/NV0dHre029HZriAXnai/bCt2CWmDPVUqh/zr+O36?=
 =?us-ascii?Q?kESPaLjIgUKGVAV2Z7FQAjMfA/Epq0C73DWnwbWMxGuZYL1XhY2wbXQcKJfh?=
 =?us-ascii?Q?VL7oJSI/8A6N7oi/zsIM3e+Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a922542-7d15-4696-375f-08d9156bc432
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:24.8607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HohT5dYfDXuoRYjNsLPdNABp38Gh2X3lYLqZ2wHX9vqSuB4EFwmO2T8h96L6ZJZEndMEulllUKTZ6ATOT4A+Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2340
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Chengming Gui <Jack.Gui@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chengming Gui <Jack.Gui@amd.com>

Add KFD support for beige_goby
v2: fix asic name typo
v3: squash in updates (Alex)

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         | 61 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 19 ++++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |  1 +
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  1 +
 6 files changed, 84 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index ca90b710d76a..0805dbc968e7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -689,6 +689,63 @@ static struct kfd_gpu_cache_info dimgrey_cavefish_cache_info[] = {
 	},
 };
 
+static struct kfd_gpu_cache_info beige_goby_cache_info[] = {
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
+		.num_cu_shared = 8,
+	},
+	{
+		/* L2 Data Cache per GPU (Total Tex Cache) */
+		.cache_size = 1024,
+		.cache_level = 2,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 8,
+	},
+	{
+		/* L3 Data Cache per GPU */
+		.cache_size = 16*1024,
+		.cache_level = 3,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 8,
+	},
+};
+
 static void kfd_populated_cu_info_cpu(struct kfd_topology_device *dev,
 		struct crat_subtype_computeunit *cu)
 {
@@ -1322,6 +1379,10 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
 		pcache_info = vangogh_cache_info;
 		num_of_cache_types = ARRAY_SIZE(vangogh_cache_info);
 		break;
+	case CHIP_BEIGE_GOBY:
+		pcache_info = beige_goby_cache_info;
+		num_of_cache_types = ARRAY_SIZE(beige_goby_cache_info);
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index dedb8e33b953..776333a10bd0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -558,6 +558,24 @@ static const struct kfd_device_info dimgrey_cavefish_device_info = {
 	.num_sdma_queues_per_engine = 8,
 };
 
+static const struct kfd_device_info beige_goby_device_info = {
+	.asic_family = CHIP_BEIGE_GOBY,
+	.asic_name = "beige_goby",
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
+	.num_sdma_queues_per_engine = 8,
+};
+
 
 /* For each entry, [0] is regular and [1] is virtualisation device. */
 static const struct kfd_device_info *kfd_supported_devices[][2] = {
@@ -586,6 +604,7 @@ static const struct kfd_device_info *kfd_supported_devices[][2] = {
 	[CHIP_NAVY_FLOUNDER] = {&navy_flounder_device_info, &navy_flounder_device_info},
 	[CHIP_VANGOGH] = {&vangogh_device_info, NULL},
 	[CHIP_DIMGREY_CAVEFISH] = {&dimgrey_cavefish_device_info, &dimgrey_cavefish_device_info},
+	[CHIP_BEIGE_GOBY] = {&beige_goby_device_info, &beige_goby_device_info},
 };
 
 static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 98c2046c7331..5914e38a9f72 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1936,6 +1936,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		device_queue_manager_init_v10_navi10(&dqm->asic_ops);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index 72815e86a3b8..0e5f5c5daf76 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -424,6 +424,7 @@ int kfd_init_apertures(struct kfd_process *process)
 			case CHIP_NAVY_FLOUNDER:
 			case CHIP_VANGOGH:
 			case CHIP_DIMGREY_CAVEFISH:
+			case CHIP_BEIGE_GOBY:
 				kfd_init_apertures_v9(pdd, id);
 				break;
 			default:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index f688451cb299..5f10dbfa58ee 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -249,6 +249,7 @@ int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm)
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		pm->pmf = &kfd_v9_pm_funcs;
 		break;
 	case CHIP_ALDEBARAN:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 30430aefcfc7..ed7aabe96919 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1385,6 +1385,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		dev->node_props.capability |= ((HSA_CAP_DOORBELL_TYPE_2_0 <<
 			HSA_CAP_DOORBELL_TYPE_TOTALBITS_SHIFT) &
 			HSA_CAP_DOORBELL_TYPE_TOTALBITS_MASK);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
