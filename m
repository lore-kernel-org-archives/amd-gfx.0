Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AFED637AE
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 21:10:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EC9710E3AE;
	Tue, 16 Dec 2025 21:10:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jLLwLVYn";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010044.outbound.protection.outlook.com [52.101.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 771D210E3AE
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 21:10:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9acoUQDuif+5PfzH05f/4IZeztFB9eOD78QZI+gI/UjoXh/lt56D6CVrGhB0LiirQExSvxS3FJjZomUTj0lMTfIDysmACW40850EifxzeB0rAOyBtD1StkXuwMFPZ+RxPEzLhIkoC9Np5crtTBo6Sl7SRd/xuZ0m7/UlWhUe5YluqKdJ8I/PGhmI3b2C2aaOr02xv+mpjrO+T4dAnXcBywwvonkOrHa9WkAfUM90qwq/YRU7MvITlP1P/pfKchzZAhnm5g0i9VXhH0ez8vai+mFA1ku5j8LFD0xQ1SrV4KBvF1zYbSqXvzJyjb29g7N5QAtK2VZGCaYmycCxtd7zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QO+dezCYcClMQQD6KyehvL/Ox0pplv9mNk7kI3s3bqI=;
 b=axIMWIihM2SLdFho4W8YixfDZVsSDt4He5KoVo+BjWBOjRckaFXjAXF6flvsZhI7KOg2kd7dbQoX33ivroCgh7HvHhtS/TFD4wRllxGMJTCLD3jRhiXEriMe/Ij5tvr3vDPCeLfp/PygypkQI3p0jD69zCl00ThKxB5P+BFiAcAOkD+YEl8USfDfg7JcHXS0hs5BQXAzaX+p/FTl0mtydUGlnJm6VCy3kKWgC8Mu9a0BnDzaq07VFTXpsuqTxMmhZ7r/IYw0/rLVsLO/j9+raIWPQnohHjDHwJfuI4Vrg+BTIhXzNropdpfofvdT3N2NNFlU8JcfKCkNnXmiSX/ePA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QO+dezCYcClMQQD6KyehvL/Ox0pplv9mNk7kI3s3bqI=;
 b=jLLwLVYnZn7ihelRXNsnVpX4bDq9apWscAXY/QniTrIxQjoOn83iqHzFN1Y8d65Iw5i9MH/fWgbSZ6XgGZCj4wbDVigum8B0AMRcREQF7IOlYjMN3i69hc7U49OUXFR71Q/KSB+W3Bu8yuKmxcq1DW3AOQBMAFJxIpWqCJkprmM=
Received: from BN9PR03CA0942.namprd03.prod.outlook.com (2603:10b6:408:108::17)
 by IA0PPF1D04084C7.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bca) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 21:10:23 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::1e) by BN9PR03CA0942.outlook.office365.com
 (2603:10b6:408:108::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 21:10:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 21:10:22 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 15:10:22 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tim Huang <tim.huang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add support for SDMA IP version 6.1.4
Date: Tue, 16 Dec 2025 16:10:05 -0500
Message-ID: <20251216211009.1963990-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|IA0PPF1D04084C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 1885c6bd-91cf-4ecd-f7ee-08de3ce7869c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z9EbuwXbftNnkA05JtfsQo4pAT3PC7WMAcEQrdYSOvpN1u56cLM22coJz1nO?=
 =?us-ascii?Q?yn0KojENyyDsJOyDbgtG+wSprwrjONM8Ag8jcF8WlGIFAX7zKu6y9vSvbKh7?=
 =?us-ascii?Q?CQofGF1+tZXoMPjcCPG8RPX0ED7LjRooFs4ckVA6AhcNE/wtb96nKFSfe4bh?=
 =?us-ascii?Q?10Uq1LzJbS5hZT8DL4kpW7C1v70BGeo2G3zL3J24qtJqs3sKBGuQ8kTnxkdm?=
 =?us-ascii?Q?NfTOYvEJrV1QqmC77OYXT3MHsJ369cG9OlL6tAXN4uT948K4z4V69sMYDO9U?=
 =?us-ascii?Q?cOHlYtk5CxBykfT117g3nwLRnfyB/KT+vzs9OWKpPOhddqd/EtGGjONHCiEK?=
 =?us-ascii?Q?SxrgH/yBMFo2q9OFsB+M1PPN69uUimS/gRsHzFmwcIVE/t7v+jsTSpA8RKpv?=
 =?us-ascii?Q?E5HbT4waxe9CzCnjtrgj/ODu3F34/6xuOwfJwqmtbBk64/yMmCa3HRN/nLJM?=
 =?us-ascii?Q?w35AKjxadLiQ+1h39w5kNL8EkhJ0r458hVQDH9JcBsOn2Yh09BabQavkhS7V?=
 =?us-ascii?Q?6IYx5WUN6r8PYVlIiDf666VHwkTWyy6OxT/EQDnmNrfhToBGJo+T1TP4UX9P?=
 =?us-ascii?Q?JIELqKmAA8vk4lU/2vucQo7IrKO0pd7LcnEq371vg5YStO58W7/VxO4Inl6v?=
 =?us-ascii?Q?4HExGLSGPhSZc6vw3XO4UL6uzThzW8NknADDL2kE3G/PqLwxCCoBfJ6UZXaa?=
 =?us-ascii?Q?nj90qxg0kEfL110+CEmcH/ALgsl5d+HeGs6eY0A4hApwjvKDKjCyl/Fj2nA0?=
 =?us-ascii?Q?igZXTv/LZVp6rhcuydk5EtBVy/TCSNrHmEWxAZUZof5moMmbIvBLl8qFpOmJ?=
 =?us-ascii?Q?QbyL/N42TQinuZiZztccoaAPw3T2K8Y+5ZevB4h7eXUSmOt3nHW4392XT6vs?=
 =?us-ascii?Q?KMQ/ORSVCR7Tt0Zg4y16H5021oBX+2/xM2YDGeR/YlQgSGLSp6AX6ozUQ7oC?=
 =?us-ascii?Q?vT33vfe3TVSqRDhw3GSaEOE3CLSxCvdw9nSGT/isygkB49Zedpr6LTyFPBhC?=
 =?us-ascii?Q?ron5EdD5z7VcipW01cF9IwHUHy9DCHHd967+GdbcJVylMLVCmRMl9ETevDJQ?=
 =?us-ascii?Q?rqkc9EfBdecVu9jkKayqQXCc7h0LmaGptsyGXiaHbc6VzPy/EBNzk7UTWHWh?=
 =?us-ascii?Q?30hUQnOfhmDagZtyCGUmImtGIC1A8U6eAZkQenWM3ltKGZ2C1qREG1fi7rBc?=
 =?us-ascii?Q?pCsxDT1+qs44Wj+IxkA0ifX1M3LlUBlcDl27YH6zFfBffLq3z72bXSSo38Kv?=
 =?us-ascii?Q?OeB9cSuEFjjpppOvU6QG6WJoN4bA+JPV3M9CQ/+EJgvQ9hmYp7tBe/eON2oJ?=
 =?us-ascii?Q?bSXsojPVXTwW1oAFyIAMz7M0VOY8PT8RqCVtNkHDU+yMa5vnzP44PeD0fNr5?=
 =?us-ascii?Q?0Gd6gCdKKFp8SZ9F276PJNf3glzFiBYW/D54f8Hpb8bPdZKAZhIK7Fa+wQia?=
 =?us-ascii?Q?iRCOsQpR0vwVdONPjizSMu81z+89OpGPw+JGY20Y+fpqB6W6PVUPXveIVQuw?=
 =?us-ascii?Q?s3LYSRGTMRO3MRblVPX49QPrjzqke1Q4/EADYJflVemFAz4Ug9PH/yVNwSlr?=
 =?us-ascii?Q?zLFuxEFbATjn+FuH6O4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:10:22.6367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1885c6bd-91cf-4ecd-f7ee-08de3ce7869c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF1D04084C7
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

From: Tim Huang <tim.huang@amd.com>

This initializes SDMA IP version 6.1.4.

Signed-off-by: Tim Huang <tim.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 116cb437c81bb..ba3a1eb116dfe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2420,6 +2420,7 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(6, 1, 1):
 	case IP_VERSION(6, 1, 2):
 	case IP_VERSION(6, 1, 3):
+	case IP_VERSION(6, 1, 4):
 		amdgpu_device_ip_block_add(adev, &sdma_v6_0_ip_block);
 		break;
 	case IP_VERSION(7, 0, 0):
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index f38c2bdd01e3c..651fdfc94a0a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -54,6 +54,7 @@ MODULE_FIRMWARE("amdgpu/sdma_6_1_0.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_1_1.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_1_2.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_1_3.bin");
+MODULE_FIRMWARE("amdgpu/sdma_6_1_4.bin");
 
 #define SDMA1_REG_OFFSET 0x600
 #define SDMA0_HYP_DEC_REG_START 0x5880
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 01e5b3416716f..b7647324ea821 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -104,6 +104,7 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 	case IP_VERSION(6, 1, 1):
 	case IP_VERSION(6, 1, 2):
 	case IP_VERSION(6, 1, 3):
+	case IP_VERSION(6, 1, 4):
 	case IP_VERSION(7, 0, 0):
 	case IP_VERSION(7, 0, 1):
 	case IP_VERSION(7, 1, 0):
-- 
2.52.0

