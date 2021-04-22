Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7A9C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 02:24:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71AE0613D1
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 02:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71AE0613D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E4DE6EA12;
	Thu, 22 Apr 2021 02:24:44 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2057.outbound.protection.outlook.com [40.107.102.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BDEF6EA12
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 02:24:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qj80IU4t5x+bvoX9oV//mbJnZ8dFOJGwyzZuGQc25rzVROPKJegr84ySOE8v/cw12uZCtIbnbxzAQPtDDJ5sj5rEtknlK1ySX6gSYOKKoJDgIjyCGds4ExnBGHWlkxT0R6o2PAqTAbo28Ve532/Dk2hT9ONiV2uYCpJDrfh6AZAbTe5Yn/st8lCuMQXsfw6zz+LYu0lQWMcLpxs9Ju5eNTWqygvd/WGX1Y9uL9tXQwT9lRc4y+8rPNvSYV+vGiYJDU32Lot5Ee8ZZhapdOsW2yRkOCbIMZqe4QbN/2TIFoXCzwkpjHf4PlqYVk0mJvZWTm2dc7EFn4qZF5jtEwrASg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5IcHzoUBBhiYasxcP23yrvunMfx3sjfE2PmhVGw220=;
 b=SwUI3IHT7bQvG14MlZmMYpOWMuv/VNxwRpYVuUCqS1+ixKcN1XetAfsQZTCE0GnEpXS+yz+r7RTpEoeaUn3cFRnPKgMx+NtBNjbjDsPDxuPuI4IKij/CLjKUBrZh2rHZo5iYHhLqAItIpBVNJiUggzX4lQfuv6DGx2FV0Sar7M5VwaBNekmDPHSJwNmnTJEM8VcWAKbf+T6TYcNyB2Bi0xdW6yl/2Sp/BziyVCR5tCbn4PqvfTeUmYHQmizuBDQ5ZByud6paFZ7fvfuE0XzYmKXYOZpdLUiaiQh5ra4jCPB2Ze17fceMb1Xk1gjspCXX9Lz55+jRg37/QejsrCO5zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5IcHzoUBBhiYasxcP23yrvunMfx3sjfE2PmhVGw220=;
 b=KTB3DuFygK8wQXPjcOsrkbXzd2v4nqY1iNGG6KL3tt/Zf6oyiypIBQhP+/m5VKviLMRWifkgIbNxGaS7S17SZoCBdc5srYy+XXCzhRh+8JBoReKzDVVRtQned0ga910Hr53af3c3J2eDRBVBfdUUfCxglMF7xm8kzIpHKUHjngQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) by
 DM6PR12MB2986.namprd12.prod.outlook.com (2603:10b6:5:39::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.19; Thu, 22 Apr 2021 02:24:40 +0000
Received: from DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::8d0b:598b:27c2:4b58]) by DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::8d0b:598b:27c2:4b58%3]) with mapi id 15.20.4042.024; Thu, 22 Apr 2021
 02:24:40 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: add per-vmid-debug map_process_support
Date: Wed, 21 Apr 2021 22:24:15 -0400
Message-Id: <20210422022415.48407-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0093.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::32) To DM5PR12MB4680.namprd12.prod.outlook.com
 (2603:10b6:4:a6::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jonathan-KFD.amd.com (165.204.55.251) by
 YT1PR01CA0093.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.21 via Frontend Transport; Thu, 22 Apr 2021 02:24:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c8a9ecf-79d3-43c8-71e4-08d90535c878
X-MS-TrafficTypeDiagnostic: DM6PR12MB2986:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2986A15B65AA55D3715C853985469@DM6PR12MB2986.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SI28WEMsvrrNurQO+oY+NqpCp4u70B8t5QK1GSPnw2tc2XMjqrPXNiw3byUsswXFYlM/1YXQBFp/kzzM1H+dZ9nE1NpdtTP6Hi7+5uNj38Fqlvg410dWpiwwNAds7XOHMw1PipY3o3aK7HW0qVm1+S3fN/R6x1FAvGopWe8Hkafmc3+nK5AD7x3oOJT0LOuwjTuCtUA8DTzVDCYhM7PEKZyDuLNYOfFUWL+QPYsGuzJjZdqY+zgRSdZz6vbN6/m2f2yWJ3G7jUONkJFUoi8X4keYcoRK8UGBQHTwDh6W96oz9rec5Xw3O8sfl0D8Fb8B9NLYCq9gKdZeKtQ66pK9Cz0fGOc4ng1pdw6CQJQ0DXl1kA/DiO5Z3+Rraw4gw4+C0Kr1P4XI4nIC77+RZiXIZP4cinldtFom0EcqYzB68AAmDC2omjOyKj21WICYORb7IJ1Gp6LOed+VInW9T+i5gNBGEDABUN+m8ik3uzaWEB9IhGn4+K/00LxS50JPk+VqBWgAQOZAOIB3O7wL3cz1S+qlvsiVzZsvv0S6iZglW4NopwvNWqvkYb8UALwPS/n7gmHULGd6VJLgSaMICULLZXJfPf3O/SCmJKfW/jDO4fGKsn6NsxkDjiGjdbVhF7bLcU5UWGyom233uOsfzSj5VcjAn/8azclh4yvJDBEs2xE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4680.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(86362001)(6916009)(83380400001)(38350700002)(26005)(44832011)(2906002)(6486002)(66946007)(186003)(316002)(4326008)(16526019)(36756003)(6666004)(38100700002)(52116002)(1076003)(2616005)(7696005)(66476007)(5660300002)(8676002)(66556008)(956004)(8936002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OP/cnMzTZBaGzzdi3FeB0vSNpQYrl2dphXDEsiPG3Ytnfr8BI4r27j652rVf?=
 =?us-ascii?Q?xxPHWvPT7JP07+p/WcG035hOXZ/FlOf5iPy9brDWypYGLcNlE7FP93KlAJ+6?=
 =?us-ascii?Q?jT7aWj3EYVeJeWDHXajYeoeU++8ZMW91Ie2SMLeOaWkqkugEio6ndP9M1c3l?=
 =?us-ascii?Q?FcRtttyx9CeJ1d3TZmsSbBGk2l5yUPjn+kIC35C9qjZ8pcCgbLLs8YxnqLaM?=
 =?us-ascii?Q?5rSpHTteKtY8ArnvIvclxX5qmP5prazuf1Lk8TUv75VADfg0MTKyTCz6aAZ1?=
 =?us-ascii?Q?OzTcvmAwjyOZtpuk3IajAzq4uF8MwSAhnyAlkKeekjJ88ViOZrrWiWb2rsf5?=
 =?us-ascii?Q?dHojdINp3Z6sxKPEyPUepXR2Ja0Q+BdWx1L9vjM+J4EflsuxGNXplfCJ+7LU?=
 =?us-ascii?Q?lhB7nT9ejFSZk4yj9ViWLsQDZsHQdnIFxUrPhJSbSkwbRRz7+mZyNvSn2X1W?=
 =?us-ascii?Q?y8/N85E+xruocuQ0dCbnAN0gz6wOe5IVDTvE1hK+xyZPJqLJoPnRkn8X0piX?=
 =?us-ascii?Q?qv1qNTGx5gMWfrw757m/B60VJkRQ+odkUGzh2D+hTjMBhUSVbkvH36pSEiYT?=
 =?us-ascii?Q?nyVQObIqCkeAp3RcYLEJ1MhN1zHAI9xVrEbQRBTl4hIz0XLEmYjJYd3OMj3J?=
 =?us-ascii?Q?PGuWcttRZr/da0T0WMDGNn8vFRd/penapcAATs9kIBPzAdTuxUbi1+rpS+v/?=
 =?us-ascii?Q?YlolWynjH5s58czijDbjEYM9gkeMExKg1AqHzMnrlKW8zBDVvJwHEXqdmTsB?=
 =?us-ascii?Q?oMnSnKqAs+pFyZTKvTZJvGI6se4iixFVBguwnXiStk0XBsimrFKrMjmdTtbc?=
 =?us-ascii?Q?PEW2Oc1xcqgTcOoV444jgfwKc5/dMrWTK37meeMfixrOFUKmvgNrWh6mZuED?=
 =?us-ascii?Q?X6UTU7S3ElSmaQRAIO9p6fXkYjffJUoupfx+wNcuRnGQ4tIn/o5GdE8+IWdg?=
 =?us-ascii?Q?tHrd1Cyd+I/5/U/bvGBMRnEIwrMPTFkFsS00Tx+s/8qNhUksEX3u3LDrUKVC?=
 =?us-ascii?Q?q7ooD0kZawYDdmOLmp1LmX6xMB8znqBCWbLTdOyGxtc4W9ungP15puPVpkvi?=
 =?us-ascii?Q?WQtTIBSvllkngBjQLfRLvDIGvwtfLML8PoYXbRocchEosf3QAFdmyb7tFYeX?=
 =?us-ascii?Q?vrR49HvpCgLIZmrznHm8l7pIg5CJmrYh3hR9mU1jRC7Ux57ddNRG01mQiB4O?=
 =?us-ascii?Q?8gpm2OzZgVpN1f5McQSlQ/mXaP56Fj+k7CJ6iPhp2Sg1PC5t2k3+KkWukxRl?=
 =?us-ascii?Q?nZQ4fwgEZHPrtoCHLowhes6t7+hAlqRY7Iqglu1wJ5/V+sRAiDUZVXZWfCqw?=
 =?us-ascii?Q?VGn9eKwQKC6666x0P/1qj8YF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8a9ecf-79d3-43c8-71e4-08d90535c878
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 02:24:40.5476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/ezlPzO2/fdrP5UGed6jiiqTHjzvtl0ktKJUURBYTSwC99b0pTOeEeufVOvd+vZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2986
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In order to support multi-process debugging, HWS PM4 packet
MAP_PROCESS requires an extension of 5 DWORDS to support targeting of
per-vmid SPI debug control registers as well as watch points per process.

v2: align upstream with internal new MEC FW

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  9 +-
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  4 +-
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 58 +++++++++++-
 .../amd/amdkfd/kfd_pm4_headers_aldebaran.h    | 93 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
 5 files changed, 161 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_aldebaran.h

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index b31bae91fbd0..348fd3e49017 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -26,6 +26,7 @@
 #include "kfd_priv.h"
 #include "kfd_device_queue_manager.h"
 #include "kfd_pm4_headers_vi.h"
+#include "kfd_pm4_headers_aldebaran.h"
 #include "cwsr_trap_handler.h"
 #include "kfd_iommu.h"
 #include "amdgpu_amdkfd.h"
@@ -714,7 +715,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 			 struct drm_device *ddev,
 			 const struct kgd2kfd_shared_resources *gpu_resources)
 {
-	unsigned int size;
+	unsigned int size, map_process_packet_size;
 
 	kfd->ddev = ddev;
 	kfd->mec_fw_version = amdgpu_amdkfd_get_fw_version(kfd->kgd,
@@ -749,7 +750,11 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	 * calculate max size of runlist packet.
 	 * There can be only 2 packets at once
 	 */
-	size += (KFD_MAX_NUM_OF_PROCESSES * sizeof(struct pm4_mes_map_process) +
+	map_process_packet_size =
+			kfd->device_info->asic_family == CHIP_ALDEBARAN ?
+				sizeof(struct pm4_mes_map_process_aldebaran) :
+					sizeof(struct pm4_mes_map_process);
+	size += (KFD_MAX_NUM_OF_PROCESSES * map_process_packet_size +
 		max_num_of_queues_per_device * sizeof(struct pm4_mes_map_queues)
 		+ sizeof(struct pm4_mes_runlist)) * 2;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index e840dd581719..0ce507d7208a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -242,7 +242,6 @@ int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm)
 	case CHIP_RAVEN:
 	case CHIP_RENOIR:
 	case CHIP_ARCTURUS:
-	case CHIP_ALDEBARAN:
 	case CHIP_NAVI10:
 	case CHIP_NAVI12:
 	case CHIP_NAVI14:
@@ -252,6 +251,9 @@ int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm)
 	case CHIP_DIMGREY_CAVEFISH:
 		pm->pmf = &kfd_v9_pm_funcs;
 		break;
+	case CHIP_ALDEBARAN:
+		pm->pmf = &kfd_aldebaran_pm_funcs;
+		break;
 	default:
 		WARN(1, "Unexpected ASIC family %u",
 		     dqm->dev->device_info->asic_family);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index e3ba0cd3b6fa..7ea3f671b325 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -24,6 +24,7 @@
 #include "kfd_kernel_queue.h"
 #include "kfd_device_queue_manager.h"
 #include "kfd_pm4_headers_ai.h"
+#include "kfd_pm4_headers_aldebaran.h"
 #include "kfd_pm4_opcodes.h"
 #include "gc/gc_10_1_0_sh_mask.h"
 
@@ -35,7 +36,6 @@ static int pm_map_process_v9(struct packet_manager *pm,
 
 	packet = (struct pm4_mes_map_process *)buffer;
 	memset(buffer, 0, sizeof(struct pm4_mes_map_process));
-
 	packet->header.u32All = pm_build_pm4_header(IT_MAP_PROCESS,
 					sizeof(struct pm4_mes_map_process));
 	packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
@@ -73,6 +73,45 @@ static int pm_map_process_v9(struct packet_manager *pm,
 	return 0;
 }
 
+static int pm_map_process_aldebaran(struct packet_manager *pm,
+		uint32_t *buffer, struct qcm_process_device *qpd)
+{
+	struct pm4_mes_map_process_aldebaran *packet;
+	uint64_t vm_page_table_base_addr = qpd->page_table_base;
+
+	packet = (struct pm4_mes_map_process_aldebaran *)buffer;
+	memset(buffer, 0, sizeof(struct pm4_mes_map_process_aldebaran));
+	packet->header.u32All = pm_build_pm4_header(IT_MAP_PROCESS,
+			sizeof(struct pm4_mes_map_process_aldebaran));
+	packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
+	packet->bitfields2.process_quantum = 10;
+	packet->bitfields2.pasid = qpd->pqm->process->pasid;
+	packet->bitfields14.gds_size = qpd->gds_size & 0x3F;
+	packet->bitfields14.gds_size_hi = (qpd->gds_size >> 6) & 0xF;
+	packet->bitfields14.num_gws = (qpd->mapped_gws_queue) ? qpd->num_gws : 0;
+	packet->bitfields14.num_oac = qpd->num_oac;
+	packet->bitfields14.sdma_enable = 1;
+	packet->bitfields14.num_queues = (qpd->is_debug) ? 0 : qpd->queue_count;
+
+	packet->sh_mem_config = qpd->sh_mem_config;
+	packet->sh_mem_bases = qpd->sh_mem_bases;
+	if (qpd->tba_addr) {
+		packet->sq_shader_tba_lo = lower_32_bits(qpd->tba_addr >> 8);
+		packet->sq_shader_tma_lo = lower_32_bits(qpd->tma_addr >> 8);
+		packet->sq_shader_tma_hi = upper_32_bits(qpd->tma_addr >> 8);
+	}
+
+	packet->gds_addr_lo = lower_32_bits(qpd->gds_context_area);
+	packet->gds_addr_hi = upper_32_bits(qpd->gds_context_area);
+
+	packet->vm_context_page_table_base_addr_lo32 =
+			lower_32_bits(vm_page_table_base_addr);
+	packet->vm_context_page_table_base_addr_hi32 =
+			upper_32_bits(vm_page_table_base_addr);
+
+	return 0;
+}
+
 static int pm_runlist_v9(struct packet_manager *pm, uint32_t *buffer,
 			uint64_t ib, size_t ib_size_in_dwords, bool chain)
 {
@@ -324,3 +363,20 @@ const struct packet_manager_funcs kfd_v9_pm_funcs = {
 	.query_status_size	= sizeof(struct pm4_mes_query_status),
 	.release_mem_size	= 0,
 };
+
+const struct packet_manager_funcs kfd_aldebaran_pm_funcs = {
+	.map_process		= pm_map_process_aldebaran,
+	.runlist		= pm_runlist_v9,
+	.set_resources		= pm_set_resources_v9,
+	.map_queues		= pm_map_queues_v9,
+	.unmap_queues		= pm_unmap_queues_v9,
+	.query_status		= pm_query_status_v9,
+	.release_mem		= NULL,
+	.map_process_size	= sizeof(struct pm4_mes_map_process_aldebaran),
+	.runlist_size		= sizeof(struct pm4_mes_runlist),
+	.set_resources_size	= sizeof(struct pm4_mes_set_resources),
+	.map_queues_size	= sizeof(struct pm4_mes_map_queues),
+	.unmap_queues_size	= sizeof(struct pm4_mes_unmap_queues),
+	.query_status_size	= sizeof(struct pm4_mes_query_status),
+	.release_mem_size	= 0,
+};
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_aldebaran.h b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_aldebaran.h
new file mode 100644
index 000000000000..f795ec815e2a
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_aldebaran.h
@@ -0,0 +1,93 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+/*--------------------MES_MAP_PROCESS (PER DEBUG VMID)--------------------*/
+
+#ifndef PM4_MES_MAP_PROCESS_PER_DEBUG_VMID_DEFINED
+#define PM4_MES_MAP_PROCESS_PER_DEBUG_VMID_DEFINED
+
+struct pm4_mes_map_process_aldebaran {
+	union {
+		union PM4_MES_TYPE_3_HEADER header;	/* header */
+		uint32_t ordinal1;
+	};
+
+	union {
+		struct {
+			uint32_t pasid:16;	    /* 0 - 15  */
+			uint32_t single_memops:1;   /* 16      */
+			uint32_t reserved1:1;	    /* 17      */
+			uint32_t debug_vmid:4;	    /* 18 - 21 */
+			uint32_t new_debug:1;	    /* 22      */
+			uint32_t tmz:1;		    /* 23      */
+			uint32_t diq_enable:1;      /* 24      */
+			uint32_t process_quantum:7; /* 25 - 31 */
+		} bitfields2;
+		uint32_t ordinal2;
+	};
+
+	uint32_t vm_context_page_table_base_addr_lo32;
+
+	uint32_t vm_context_page_table_base_addr_hi32;
+
+	uint32_t sh_mem_bases;
+
+	uint32_t sh_mem_config;
+
+	uint32_t sq_shader_tba_lo;
+
+	uint32_t sq_shader_tba_hi;
+
+	uint32_t sq_shader_tma_lo;
+
+	uint32_t sq_shader_tma_hi;
+
+	uint32_t reserved6;
+
+	uint32_t gds_addr_lo;
+
+	uint32_t gds_addr_hi;
+
+	union {
+		struct {
+			uint32_t num_gws:7;
+			uint32_t sdma_enable:1;
+			uint32_t num_oac:4;
+			uint32_t gds_size_hi:4;
+			uint32_t gds_size:6;
+			uint32_t num_queues:10;
+		} bitfields14;
+		uint32_t ordinal14;
+	};
+
+	uint32_t spi_gdbg_per_vmid_cntl;
+
+	uint32_t tcp_watch_cntl[4];
+
+	uint32_t completion_signal_lo;
+
+	uint32_t completion_signal_hi;
+
+};
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index a1ddcf6446db..64552f6b8ba4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1088,6 +1088,7 @@ struct packet_manager_funcs {
 
 extern const struct packet_manager_funcs kfd_vi_pm_funcs;
 extern const struct packet_manager_funcs kfd_v9_pm_funcs;
+extern const struct packet_manager_funcs kfd_aldebaran_pm_funcs;
 
 int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm);
 void pm_uninit(struct packet_manager *pm, bool hanging);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
