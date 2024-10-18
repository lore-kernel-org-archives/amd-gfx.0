Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F769D2127B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 08:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4EF010E378;
	Fri, 18 Oct 2024 08:19:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O1cmma1j";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 228F210E378
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 08:19:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNP4osbMZdCUYGEP0JdrUDl6m0wyNAwsVa0GQfLMXSeZfIKZFjvTZfjEiARekaCAh29AJSbYie427Xc79H7NqDE5GzkQAwPUJjsadtGAG6ySZIzEo8c32Xxpm/S9w487v4Kiob15KGRtrOZhMp36idk1CGlQrrgm8FsTTjNUYtrZF7HWxNF0n9T9NQfkiibima6jJj54R9enf/ZJMc7wpIV5rbnApGsNdK3loK/VrTrMrGNzUjCSk8AzLV/eIdhFvrc22pvRPuJVH81zZWHmR3xppGapVO3NUnMIcXWEv5ackMxyDu0jO1yGkocXHQOQfXAJG76uH6fx1jsGyxSkCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bb6uLH+Tz86mbqkYRP8n48RRH11jfE9d3wriSyxorbk=;
 b=gqmUW5KvxGR7Wc2zpZMV8oVGkZyQ2UefIwOWcxNAGzlBPtyLaLhDqtdBPzT+kj1BfTk1H13vxHqwsAR6eHPCdQCMkYU1ivxVw6FiDctE2HscTvwI55J42qu2LhaSnocfoYSjRxs5qdrKj5rROs55gmNeYEG5EfwG9bOQaMGRax6MDnhx0+Ga8BS+HT77Q6dV53QldtvV1hIfJyC6wg11gZ66mDe6fiRERT/AtpmS3JVUpj6XnoghrqQR9GVK4hAJjoS39BMRtMdIvYPTTR7xOSJPoTsUlufkg89C5ngG3O7KT3FYevsphBprmpu+Hfl4bOsYDF8GX8KHvm44y3X+Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bb6uLH+Tz86mbqkYRP8n48RRH11jfE9d3wriSyxorbk=;
 b=O1cmma1j9sRSi4WqAoie5AfTxqDttiFq1bX9CctGZP1XKp3XHmyM1PrtHuwNApCaLrJ3p8FiCBtyYgyVQctcOwfMYU7vRUUSHJF1aRUSPe6DZPPGiu9T1MJvBzD0PrZe9iS1AjnskMmSVnSTt8XUm4mmzmnnvGa+LG/PLwpPT+g=
Received: from CH0PR13CA0028.namprd13.prod.outlook.com (2603:10b6:610:b1::33)
 by SJ1PR12MB6147.namprd12.prod.outlook.com (2603:10b6:a03:45a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 08:19:37 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::66) by CH0PR13CA0028.outlook.office365.com
 (2603:10b6:610:b1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.9 via Frontend
 Transport; Fri, 18 Oct 2024 08:19:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 08:19:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Oct
 2024 03:19:36 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Oct
 2024 03:19:36 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 18 Oct 2024 03:19:35 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: add the command AMDGPU_INFO_QUEUE_RESET to query
 queue reset
Date: Fri, 18 Oct 2024 16:19:34 +0800
Message-ID: <20241018081934.2185681-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|SJ1PR12MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dffd16d-0cb6-40d1-6246-08dcef4d9b04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0WBC2UL72p+cnWSLDpWR4pRITbF05fmyr5rZBAE3s3BcGx22XDVcgLm1QLRq?=
 =?us-ascii?Q?JUAoM3jEqklhLrwOVzb3Uqaw40PM9UqH6dVSkaqPiauXbVcm3gA+kp3udKDq?=
 =?us-ascii?Q?q4nSfNjukNcVsV4JyN1jCJy1J4UaS+2VxM3V96BgRVErbJhwfEvfA2Hx/wyP?=
 =?us-ascii?Q?o/qXQIGVQ3xd/JluRW9myIj6g6pffEDQ8OkK97Md9rl5UrauMSd/5kQMUBSM?=
 =?us-ascii?Q?bb/28dSpm4/8Qww7QTaYSy3wBxjGCD4GkA5KSqcbnmHX7EHWRx7N1J4K0O43?=
 =?us-ascii?Q?896DXs4PYAOjp860g0sAVQLrjEGs16uZxLHLVCulS4wKpzP8y3m70KVIoePE?=
 =?us-ascii?Q?MyuRmrfnCwtpfWhKKKknFOYFQImGUiadcb3sfqUdmru2wOVSaxb6obxddQrr?=
 =?us-ascii?Q?vRrCcQY4CpVZFP3U0lL+tQMV8CLIFyuhARlHThyFIJg1hbNxqpAZIOa590L5?=
 =?us-ascii?Q?de/GpjnD0ORLFlLjJVx+37AzdaOfP3VLUnZko77Qkk02xwPs/D0srNVbMv5M?=
 =?us-ascii?Q?CUVW912kieBJdSQilKHQIn9FPJESG/ZvLA18nRsJyBhwUp2p7Zdd5FYGPuby?=
 =?us-ascii?Q?kJDTLUosdU4MWdiKbQOFuKqvzPjErmzMyYyhFV/Il4NkIE7yibdaUNJ6S2Mi?=
 =?us-ascii?Q?OZYGRwE7UlT1zRRbr/f8W/eLSfa1uZ4Szwr/mkxr1iMDI/7mvuWL4mrToAzx?=
 =?us-ascii?Q?+sjBN9DGNMlTARAOt40Zu2Qgc+sfmF/6BNILD++re2mi0rKChVcFFvp5RZqc?=
 =?us-ascii?Q?plXgBUGjsS+eZFSKtmxqVJKjBI1UwYA2oC3oW445Tt2UYOQ1OK17yIdz8Wg0?=
 =?us-ascii?Q?f0e2eKuBVK2g9mtkMQJvwwyl7arR/hWn9i+hewEJ+7GT+wOA5iq+WqktuMU0?=
 =?us-ascii?Q?MEUIT9RJxAJPydN8dideHXho1MArlrtn46V7VLz/Pbk6j8ThQ7NOXriUDk7D?=
 =?us-ascii?Q?4YDntiVQMB3PzCDSovoKSZK3B9wMecMM8GiMF/Pzx5AiGIoFJoAfwsEKphGD?=
 =?us-ascii?Q?+qXPVfdgW5Y4u9nOfiWxGr5yClqALIk0RZw7Zn6OTXswv7cmfGSWK7eDNRh6?=
 =?us-ascii?Q?qWD2YH6FcCTFXzO3hZE7hHgriJLtg7YMXhBMzF/QVDZK7fv3ZzynVQHeWGkH?=
 =?us-ascii?Q?50zh/Apylx3XMzOlpthvCaKXw/4OlsyBwnbEMa8VV2tCNAw+HCpPXoG8AZ0h?=
 =?us-ascii?Q?eJmA7c5TjJHzUNf+4lLxGM2G58rp5dsOKPxxBYgG1wLROxvsBYcQ3FgDeSR5?=
 =?us-ascii?Q?8UwiZOdGcdhYSiwAqSa2zVsizjOKX8D8E2ODjO9VIp2sW0yogvxqr14TGKk0?=
 =?us-ascii?Q?/Uv0tkgborw+HshM9CfyIbThMr1ThUF6llEOk085oZCa4o8NVXpT/mZsiJNP?=
 =?us-ascii?Q?34C79GFcpWJo4+E1BOF9WxRi0LmZYQS5nFRpva/YTgojISPfsA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 08:19:37.1262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dffd16d-0cb6-40d1-6246-08dcef4d9b04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147
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

Not all ASICs support the queue reset feature.
Therefore, userspace can query this feature
via AMDGPU_INFO_QUEUE_RESET before validating a queue reset.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 27 +++++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index b53c35992152..87dee858fb4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -577,6 +577,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	uint64_t ui64 = 0;
 	int i, found, ret;
 	int ui32_size = sizeof(ui32);
+	bool queue_reset;
 
 	if (!info->return_size || !info->return_pointer)
 		return -EINVAL;
@@ -1282,6 +1283,32 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		return copy_to_user(out, &gpuvm_fault,
 				    min((size_t)size, sizeof(gpuvm_fault))) ? -EFAULT : 0;
 	}
+	case AMDGPU_INFO_QUEUE_RESET: {
+		fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
+		type = amdgpu_ip_get_block_type(adev, info->query_hw_ip.type);
+		ip_block = amdgpu_device_ip_get_ip_block(adev, type);
+
+		if (!ip_block || !ip_block->status.valid)
+			return -EINVAL;
+
+		switch (info->query_hw_ip.type) {
+		case AMDGPU_HW_IP_GFX:
+			queue_reset = adev->gfx.gfx_ring[0].funcs->reset ? true : false;
+			break;
+		case AMDGPU_HW_IP_COMPUTE:
+			queue_reset = adev->gfx.compute_ring[0].funcs->reset ? true : false;
+			break;
+		case AMDGPU_HW_IP_DMA:
+			queue_reset = adev->sdma.instance[0].ring.funcs->reset ? true : false;
+			break;
+		case AMDGPU_HW_IP_UVD_ENC:
+		case AMDGPU_HW_IP_VCN_DEC:
+		default:
+			queue_reset = false;
+		}
+
+		return copy_to_user(out, &queue_reset, min(size, 4u)) ? -EFAULT : 0;
+	}
 	default:
 		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
 		return -EINVAL;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index d9bff1c3b326..3b17d82fd1ee 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1052,6 +1052,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 #define AMDGPU_INFO_MAX_IBS			0x22
 /* query last page fault info */
 #define AMDGPU_INFO_GPUVM_FAULT			0x23
+/* query queue reset */
+#define AMDGPU_INFO_QUEUE_RESET			0x24
 
 #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
 #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff
-- 
2.25.1

