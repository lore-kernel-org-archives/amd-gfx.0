Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E743D0E6FB
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Nov 2025 15:08:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9C0510E432;
	Tue, 25 Nov 2025 15:08:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jBVntBlv";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013031.outbound.protection.outlook.com
 [40.107.201.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8952610E42D
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 15:08:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=faqmodJsP3zPNdnflcUBsGGaN1zvdNX0DfhJkGKUyy10HqreIEIhQsnxh046VFRKUIhadUPp8MSICWkCppJYFxepu6HPOovcmL5UWhkdrL34js1ceFRclMfp8T8T8508fZpiwt+abxMXp83fwcNhv95rdZpA+IMy2VQrGAz22PtGw7txt2c+YNnetQ5aZQm2otG/8fYX4ztxz108ST9VknnMFmwtdoMeTt0p9b2jvS7mdYRdOpUB88Py0VnVvUQAYpWosEcCmsVWusfKgsGTUS2U2dzv5Cb7Kmf7/oynKhxg3hiGj78V3sTF8VFKHMbMBs5t8nKWce9oOJKReUGpsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JF+FUduBl7HPrNiCNBjTLVdELkxplkTAvfAqQ3ovLCk=;
 b=uP7u32auMa/Zy1V9hTKxmZcOaxPYyN6J40FWu8ufeHXB8D2ScW4dBh/Slz1U/VGBxqc7Jkvru16KQbl9kcXOFfHpyAMt3bZ7wThTqV9dHVJMHq/YwFctjtajyX0cpeQBWROhgpBWg56gi8PZYeVX4JZl3os6PEkn6/kNeljHP5hlgsAB0oHSfkLT+ZJUvikzTDrzJ8gE5PcMa20VevUW69g+8NIHt+tNJDLKKOpqnl4RfL2YOosxCHMSY1V1xw+jP7mF8K8E9BJawlY85icTgvLCrrqIjcpOiIS+Syv7tkI7J4CyE5efBGIAovh5eWZyxwyEzIFhiNGsM+ATinklKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JF+FUduBl7HPrNiCNBjTLVdELkxplkTAvfAqQ3ovLCk=;
 b=jBVntBlvCDuJFLKc4RlTQxrLc0h76hmV7QliPhu+ddONL1N25H9Rh+bpcsBF97daYYSUDC15q+KCW4KiB5Sa08011Dd3A6NZxMlFAPmxLAYIKV9JN6Z62RkvEepXpJ5wCoFz3BdWrAZe0wu2ivC+KXJyT1FxZ3qTbi+AgaqeyLo=
Received: from BN1PR10CA0005.namprd10.prod.outlook.com (2603:10b6:408:e0::10)
 by PH0PR12MB7931.namprd12.prod.outlook.com (2603:10b6:510:289::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Tue, 25 Nov
 2025 15:08:33 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::92) by BN1PR10CA0005.outlook.office365.com
 (2603:10b6:408:e0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Tue,
 25 Nov 2025 15:08:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 15:08:32 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 09:08:28 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Add GFX 12.1.0 support in KFD
Date: Tue, 25 Nov 2025 10:08:10 -0500
Message-ID: <20251125150812.2046438-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251125150812.2046438-1-alexander.deucher@amd.com>
References: <20251125150812.2046438-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|PH0PR12MB7931:EE_
X-MS-Office365-Filtering-Correlation-Id: d713c27e-fc19-4335-d26e-08de2c347ff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dXo/MkWJlebTmSyUBHX69C3BYG7K1myhpL4khelPt1aOIdpJXYbaA7pClPMp?=
 =?us-ascii?Q?4GvYjtgtkeSh6FAsV8Vk3Wc/MsQsnVGKlbcAi4y6FHJ8LOEFwPgMwzVinh8C?=
 =?us-ascii?Q?VlqgZrNtAUmWdigESgZtl2i/n8PDaACS9BcxCQr4YA8iqkf70YLTE/GgI/kN?=
 =?us-ascii?Q?5v8ozp23QqzpaGqk4I4zbMd7afJbgdlhqMuViJAOXz9jbM9NfTaYZ2J6ZlM/?=
 =?us-ascii?Q?wxlNrJUzTE8QG+8z6DRj0phmxis1o4gMxZ3ol7+/etbTEhIN5u8SAxG0g7HH?=
 =?us-ascii?Q?27hOBaOOL9zjfl/LJjd32h+msGcb94EWoNM3x4OUiGK2Xq8o3sy87rI9EeKi?=
 =?us-ascii?Q?kNFaI843f3Ub6R8+WjFEggTKluQGaamYESFpUjTECcbnMLVMHtNmrQo1/KsS?=
 =?us-ascii?Q?4Rv5k4fgtpaj5JW8nnzXzow44dIKVr21v8Wig76vUDvF3lf+vzNstb/hqV/z?=
 =?us-ascii?Q?eF6BpNfWPL8aXqt3NmoZroR0KR0vY4KXk/8cpSsZx/O/7FO9LBkBt9kS9RVs?=
 =?us-ascii?Q?AMWrXhomkRfHUUROkenR5v0FNFq8CWwjiFECw0JMlvMWqVJPZLN2DXP4Ruom?=
 =?us-ascii?Q?chhV59e2SgusTPQHt0Py+c32/n5bMNv8e2xSXTLQ5yjvDxTl/QBabYWcVnYw?=
 =?us-ascii?Q?5v3JxLob9eg2NpAyy4XA51vrRC8+kNXQA/4Q8eTOK7bfWa915SHWCR4UQSqj?=
 =?us-ascii?Q?OS21Ffwm5c5+oPytPKruZx6K4i9O0z40PqUiH2oTCSrrOmjCmcwhAr555XlE?=
 =?us-ascii?Q?srQ8DlhtwlWq5ze2TmHl0GldpPemYfE00/jMb2881/g4GKizRRVIka4fhxOW?=
 =?us-ascii?Q?2fwo3Git1Ol56uS/LysjN6WahfC43egxbiJhreydXSAiwqJdH95kACApbNhU?=
 =?us-ascii?Q?x4zlvPvxz3F8zIi8CABIJYT50jei/xWndbzY6F+fIhTtIHQqHrlBdRFVZjf1?=
 =?us-ascii?Q?0tMm1nhD5mFLZ0TavRfZgCdiMzwPR3RW7b6VV5zKOcTZzEm26j/7+utCTq9j?=
 =?us-ascii?Q?/6bUDhrZzKSCCna8ApkL/eFh+abZByaRHMzw2jn6QGCtflSfBO8KgueJM3Iz?=
 =?us-ascii?Q?mE6hJpv0PeiBloCY1rxPd4M0icYrPf2ry9TensNLZjZov4cDCkSIne522803?=
 =?us-ascii?Q?cRQcxHIZd9QdrHIycb8gq8nqV3ROQaJeUyOA/O5EKpTiGTN65NGOcmSlnMe3?=
 =?us-ascii?Q?6oeh+RTrHZSZCqcX1VPpBnxrj8AnwkUih98zWnB6ty3RqU6hv40JaMa5jdbV?=
 =?us-ascii?Q?h80+ZyzqNPeBa8i19bbI2VXlyRLv2bXyiWZUlq0eQUHYXzWmBzkAX52N6D8K?=
 =?us-ascii?Q?5mr591bW+jJrbDUqVnGlp3Ufc/LfLzPkcPDsNDcHRVxI/d91pg5MXg3hLH/E?=
 =?us-ascii?Q?07jKc6IGnHceXdsGehl/8/kmdrYVQnKZG3hYzklOgkFcFayT/7AqBvS7lA/t?=
 =?us-ascii?Q?b91B1X6hVv7nr3HEqxAH/806ORWBo2Zf2Py6DhBqgCw0yGKZ8Zv1URgbUelV?=
 =?us-ascii?Q?U8ZyMWh5WdEJV2VsIQbfAIFM5KYR8JHd5UcwbCqiLeJ9oSIu7Xdq9Gp9V0ZA?=
 =?us-ascii?Q?58kHdaKxBMbdc/UBLI4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 15:08:32.9230 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d713c27e-fc19-4335-d26e-08de2c347ff1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7931
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

From: Mukul Joshi <mukul.joshi@amd.com>

Add support for GFX 12.1.0 in KFD.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c   | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 4a7180b46b719..5f2dd378936ed 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1712,6 +1712,7 @@ int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pc
 			fallthrough;
 		case IP_VERSION(12, 0, 0):
 		case IP_VERSION(12, 0, 1):
+		case IP_VERSION(12, 1, 0):
 			num_of_cache_types =
 				kfd_fill_gpu_cache_info_from_gfx_config(kdev->kfd,
 									cache_line_size_missing,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 9f183d27a0ef9..759b3cc814f95 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -445,6 +445,10 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			gfx_target_version = 120001;
 			f2g = &gfx_v12_kfd2kgd;
 			break;
+		case IP_VERSION(12, 1, 0):
+			gfx_target_version = 120500;
+			f2g = &gfx_v12_kfd2kgd;
+			break;
 		default:
 			break;
 		}
@@ -749,7 +753,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	 * If the VMID range changes for multi-partition capable GPUs, then
 	 * this code MUST be revisited.
 	 */
-	if (kfd->adev->xcp_mgr) {
+	if (kfd->adev->xcp_mgr && (KFD_GC_VERSION(kfd) != IP_VERSION(12, 1, 0))) {
 		partition_mode = amdgpu_xcp_query_partition_mode(kfd->adev->xcp_mgr,
 								 AMDGPU_XCP_FL_LOCKED);
 		if (partition_mode == AMDGPU_CPX_PARTITION_MODE &&
-- 
2.51.1

