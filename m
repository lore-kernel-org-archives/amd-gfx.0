Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58F2C636C8
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CAB5610CC
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CAB5610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFAFB6E431;
	Tue, 20 Jul 2021 15:44:19 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2086.outbound.protection.outlook.com [40.107.95.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14D316E436
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:44:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yqntg+HPDi3tTaeayEvaWDNI/++GyqFaksg95wWWIe6/OiW9spiVRa8c+DKAehAYUeqpej7z7vsjoVNRLL8r5HRvPFvInuInC/sTBXti5C/cx7mbmobXYtLm5J2L3j6OqeS1oG2CV4uvMweT40hWid99jTyMFGjGLc7q2768zAMWF9WNRRNRvssdje6lUKcza+YLLtYICZKZlW7kVnNcfp/mQ7VnMOlO52+jz8d5miN5gejVdgMqSiP3AC08cLfkbk1K5tcBcEhUSj2zAs8qYouDsD22D+pFLfDeg4l/T6H47oteqsGAHtTxR+hLTxEDt1RdETnY/B6+aTUYHlFcHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lz5lkowF4mYVr97SGuNIpMOLA1A8qFzJSSGO0ojTlg=;
 b=QUUNzFivohqZaKC1Mo6/97OH783VCBRjRlR4G1RXk13qy1SJ1BEvloYhu3LaJshbOx7taExLzDbcOEH+olfacQ4ISAkDokSU1/8nkwf6OPBfI/Sf16dg9EPw9mq3TS9oXp/HjECm861Ukl2Kn3eRMx1qnM2jxyG/S9dYZmq73C7tElTDfKrLUAkFV9sitaUavHwxRcq3HBURvlW1BbAAVYQvmPB6LSEJPMMCC4yQEOGh/0nbK05a2kI43XSliYIwKhvhxcxlkq+PBHG5kNwnhp2sC2DrXmco2I2FEHY3DCh+jPXVApyLuxUMdijA9O70gC/EO9vHJpS7HIwnx/os7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lz5lkowF4mYVr97SGuNIpMOLA1A8qFzJSSGO0ojTlg=;
 b=wUJJWgFdFLhtsXTTSO83ooq1pLJkY+FKtQwstRT8MPh9kbL7y8lE68xaPwCPep/lCw/dzc2bU5ykJS5zTghe3xVKNpBhSWJx/pPuR7G8v1GdkN+hbq+oRH1uuw3pvRs861lN5qO613g4HZX8ZEV1jzN3O+HfhVmKm7+1TCPjUfw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Tue, 20 Jul
 2021 15:44:16 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:44:16 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/29] drm/amdkfd: enable cyan_skillfish KFD
Date: Tue, 20 Jul 2021 11:43:34 -0400
Message-Id: <20210720154349.1599827-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720154349.1599827-1-alexander.deucher@amd.com>
References: <20210720154349.1599827-1-alexander.deucher@amd.com>
X-ClientProxiedBy: MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37)
 To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:44:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63ea8157-eb2f-4589-e5cf-08d94b953b07
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5349D11B666F976C2A55E7B7F7E29@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:142;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZydUzmRZ+mhh8KDTNt4qqC9tRYqBF/+iFIg6jFyjzM4EPJK3YYbWtXHCxXAb4zIuHmv5WBxQuRZzFQVQTcVFr34VBOucgMRJlLuSmcGQFbmxf7VTLSRHr/QgNwtiiTcp162Lt4C9dBNjsq2TokDYoG+ecIVh/9ye3l9IV/Ef8H2s4cuyFReIYUp36s+o0zECLeH+ho0kInfkYwovWrktNZyK2D4Ojbsa+WEDsHSTtO3tY31I1+uLKf2cJFuDMn3qDNTu6+oFWRxxmxSEL3H9wpWT5u3yPgcjOa2FNjAktYISZBUIuc9F5N9OEJ5L8m2ldhpWULyyKTGCOk0F+vXA0O+PGy8IvJgCu3Hz4WCAo/SDBnJsuCSS398eruj2tfYFKQ3B6AVHm8g//VlBLn6ivfdFT/+BMtYRPLtPTZCjnKT5hAuZGR3vqDcQKsxSnVPfj1dRb8Enu77H9J3/PUT/2oABDy3ceIfzBTTZw4yYlXl5VXsG7g7k23dhgh0oaYt+66w9biL3+ox9vbHDPzCAJfT7nmJ0AIPRGEqhC366KMRZ9U3RwEVq0hEk5IqsiZOerL6R0InipeeNHSlh3XC3m73OYSpKE2BnwqVcq23Usfl6S4nQPefnTlTIUP08j5xifehWoDojU9McZp8okr1U3wh1BQd8LpJbflxf5NhNGyyrj2uZx4pC/a3qGR1kPiSL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(2616005)(86362001)(6916009)(38100700002)(6486002)(54906003)(6666004)(956004)(478600001)(316002)(1076003)(4326008)(52116002)(2906002)(66946007)(38350700002)(66476007)(5660300002)(8936002)(36756003)(7696005)(66556008)(8676002)(26005)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9ZzPe47fVoIDA34ZKo1eywxTSllWJZM+JWDYW7ZrGuBOApSGR0WFfCdimLbL?=
 =?us-ascii?Q?llgZ+lNPPpFElfz34lC86U8Gh9hoGqcD2kuomUwbBWC6qSguueQSjjoLHR7/?=
 =?us-ascii?Q?LblP4ZV3el8BmS3+xPjevOOI/gOJ7CLRsnHpQ46SQr3fVJGP+ockuLyNAnup?=
 =?us-ascii?Q?rGV/3bYlGFfaZXZZglTiL+0mgjwRVYw3xth+SdtbtluadX4CnC0vur3xbe5v?=
 =?us-ascii?Q?56gVJC03FhetEfy22GsRfxsvzzWurTy1biaLSotIuTk4XC8qNwFEkwPIT7t3?=
 =?us-ascii?Q?DOXn7licKYou9lxp7dcEnXeNQNg2EtTIHOJwQY+aN2hsah2REfphVxxPctCa?=
 =?us-ascii?Q?YsWhR2XSWnaG8uNMUE0BInSr0YyfeBzJrirqSVKSkCAsGfyngpsDaS1iEtsm?=
 =?us-ascii?Q?7rGUGpU+f2/4cMSyd2mHHOVkNyP5xXFZ4Psl4SXGMLP5CbP4VPqFgrhSLibq?=
 =?us-ascii?Q?Hl6dBIpbsjUbGHbsC/js/NCtzxTR63PKdwBBnObC+eAFCHQgGiVmLIWtiezS?=
 =?us-ascii?Q?fCNwRZJ/hsvCv6EtaqvqxRVlzI3WaNudG5dmWWnnDRtqjqQoUJB1cVgHmAAj?=
 =?us-ascii?Q?6N4d8WeM6keXG2eQU/gT9/TNUszl1PiU66w8qNdCpbA9jdj5KLyBjQrMahxO?=
 =?us-ascii?Q?/xvuB9dqUgagpvBSal+b2BXKYVPvsrTbNRPAY6W3e0+GmnBMYJNqW0eQ/ob6?=
 =?us-ascii?Q?5RbbLI4tp767a2xv3LL4tYR9IWLx6v4RzM2WQXHXIH4B0+Pnaj8xig4SOGxl?=
 =?us-ascii?Q?K7nnnLx3U2lAtTvswbfAmp9jpgcVN1/PWKi9UgmpWPZZR+Yy3rnev0ZrtzEM?=
 =?us-ascii?Q?NkkXmdr8TKQBfohSorebzAY9zlCId0gyMwu2G2HloDOIyiAGhDKO/tiZdgdy?=
 =?us-ascii?Q?sypLOm9njsPCpHuAlBWOQQx89ejcuGkxKYewEgfTuq7glmbIXpzxJ2VUpeA+?=
 =?us-ascii?Q?zpMJXUNWHD+5dLFLHYdCpZ3ORlp/OuHuAvN7w6FXXMGKF8cXCt9ABxuPxkLa?=
 =?us-ascii?Q?qbX7kCARj75dq/iGf7WsLZ/mrt7hj9GF8NYUpMa3WGIs49JeJ16PqjTGjM0X?=
 =?us-ascii?Q?ZIjZpKXWWhjfgPNn/3IzvU1hzM1Ls7fYTbcNGnOCpIV7EbKjF1WTygr9nI8X?=
 =?us-ascii?Q?YFGMSob81tNWnUzuuUrU5hzRSjlks5WMLYKC8J9TB/SJUjSC/QS6CMxBXEuX?=
 =?us-ascii?Q?CmKdn8BdPoAREuAuASSjdf4LI2woMJEuKb1XX7UhgSpQvP/5loEmpqQ67wlG?=
 =?us-ascii?Q?hxwq3v2/EO+8ADhG2Gba9zMrogaiYgvzek+MCsb19uDhglRK1/skreEsvRoH?=
 =?us-ascii?Q?MfVKsgbP+AqjuXhzkHt8IEqB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ea8157-eb2f-4589-e5cf-08d94b953b07
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:44:16.4250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApqaiHdAcjCUqAMVptD3Jwp1QjkB3aC1dlvwdEb8wOTS+LSa1f83BFhCIoObljlkQoAGd3tCwQhBI+3ewUB/dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Add KFD support for cyan_skillfish.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 20 +++++++++++++++++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |  1 +
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  1 +
 6 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index c6b02aee4993..6c381367ac87 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1404,6 +1404,7 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
 		break;
 	case CHIP_NAVI10:
 	case CHIP_NAVI12:
+	case CHIP_CYAN_SKILLFISH:
 		pcache_info = navi10_cache_info;
 		num_of_cache_types = ARRAY_SIZE(navi10_cache_info);
 		break;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 9e4a05e937f0..dc6fbca1826d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -84,6 +84,7 @@ static const struct kfd2kgd_calls *kfd2kgd_funcs[] = {
 	[CHIP_DIMGREY_CAVEFISH] = &gfx_v10_3_kfd2kgd,
 	[CHIP_BEIGE_GOBY] = &gfx_v10_3_kfd2kgd,
 	[CHIP_YELLOW_CARP] = &gfx_v10_3_kfd2kgd,
+	[CHIP_CYAN_SKILLFISH] = &gfx_v10_kfd2kgd,
 };
 
 #ifdef KFD_SUPPORT_IOMMU_V2
@@ -596,6 +597,24 @@ static const struct kfd_device_info yellow_carp_device_info = {
 	.num_sdma_queues_per_engine = 2,
 };
 
+static const struct kfd_device_info cyan_skillfish_device_info = {
+        .asic_family = CHIP_CYAN_SKILLFISH,
+        .asic_name = "cyan_skillfish",
+        .max_pasid_bits = 16,
+        .max_no_of_hqd  = 24,
+        .doorbell_size  = 8,
+        .ih_ring_entry_size = 8 * sizeof(uint32_t),
+        .event_interrupt_class = &event_interrupt_class_v9,
+        .num_of_watch_points = 4,
+        .mqd_size_aligned = MQD_SIZE_ALIGNED,
+        .needs_iommu_device = false,
+        .supports_cwsr = true,
+        .needs_pci_atomics = true,
+        .num_sdma_engines = 2,
+        .num_xgmi_sdma_engines = 0,
+        .num_sdma_queues_per_engine = 8,
+};
+
 /* For each entry, [0] is regular and [1] is virtualisation device. */
 static const struct kfd_device_info *kfd_supported_devices[][2] = {
 #ifdef KFD_SUPPORT_IOMMU_V2
@@ -625,6 +644,7 @@ static const struct kfd_device_info *kfd_supported_devices[][2] = {
 	[CHIP_DIMGREY_CAVEFISH] = {&dimgrey_cavefish_device_info, &dimgrey_cavefish_device_info},
 	[CHIP_BEIGE_GOBY] = {&beige_goby_device_info, &beige_goby_device_info},
 	[CHIP_YELLOW_CARP] = {&yellow_carp_device_info, NULL},
+	[CHIP_CYAN_SKILLFISH] = {&cyan_skillfish_device_info, NULL},
 };
 
 static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 16a1713808c2..08c4070c73dc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1946,6 +1946,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_BEIGE_GOBY:
 	case CHIP_YELLOW_CARP:
+	case CHIP_CYAN_SKILLFISH:
 		device_queue_manager_init_v10_navi10(&dqm->asic_ops);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index a9b329f0f862..2e86692def19 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -422,6 +422,7 @@ int kfd_init_apertures(struct kfd_process *process)
 			case CHIP_DIMGREY_CAVEFISH:
 			case CHIP_BEIGE_GOBY:
 			case CHIP_YELLOW_CARP:
+			case CHIP_CYAN_SKILLFISH:
 				kfd_init_apertures_v9(pdd, id);
 				break;
 			default:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index d8e940f03102..34a864fecd5f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -251,6 +251,7 @@ int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm)
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_BEIGE_GOBY:
 	case CHIP_YELLOW_CARP:
+	case CHIP_CYAN_SKILLFISH:
 		pm->pmf = &kfd_v9_pm_funcs;
 		break;
 	case CHIP_ALDEBARAN:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index b1ce072aa20b..f934a1883a7d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1424,6 +1424,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_BEIGE_GOBY:
 	case CHIP_YELLOW_CARP:
+	case CHIP_CYAN_SKILLFISH:
 		dev->node_props.capability |= ((HSA_CAP_DOORBELL_TYPE_2_0 <<
 			HSA_CAP_DOORBELL_TYPE_TOTALBITS_SHIFT) &
 			HSA_CAP_DOORBELL_TYPE_TOTALBITS_MASK);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
