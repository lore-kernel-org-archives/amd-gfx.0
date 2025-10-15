Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678A3CCD193
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 21:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0146C10E2BA;
	Wed, 15 Oct 2025 21:49:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oauDCp5+";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013014.outbound.protection.outlook.com
 [40.93.196.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBFB310E2BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 21:49:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ot5gfO9D5gUatjMrP8rZmMartJXMPfGUmSF1JH5QV8wH/YiOaMRfrQMHR1H+F1hTWWuCsKvr9rTYYeVJRQpPlxukDWEKR5bHDIBk1EygpNHA+wN9iM4D/+3OaaDooskarfRy+KaDSOKKbSo9zgYBAQcrGrN8j302AW6mKmKsCqPUT+yvHLH2Cz6ED9NPMOCsaiXOBwEU+6BGQyRxR5hQYRrkDqrRufKLhkaPliO/xmvn/a/qxxGmCBEpwTn7Lwt1UpVrc0I48q+sS8iXhKOwF+gZ4dKoeEJag7Ca2PUgUJkq+b3On07GnikHdwJoaB6k4BsNu+Pq9zmUAg/LQbfgsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdYwTdQTwuHfrCMPe8pb/w5lotXmRWPQisk9h+OwqN0=;
 b=oE8vcPHoN+1T+UJGwgQEPkIVPGOSjyFCrgbZjNqumXNbWLJeD+ScNIjQ2ffXcusmTUgQSbdGtNXXBg97wUU9WCiZBWdB5KhkykKSLGanHkzc2RVROzUaL0WdipyVGgh2uCaj/6OZosQLA16q5jdJWjyqkreOEAFVX/GLmz2XsYbZk+fUhPWUC2XR0T+1HKrWefzH/vq4M3RAbCfo6fpwaY3CLYZ8jvsstIH2h9kqXWUNOkAJSK5aeUL2vWw53ZcIUOlVwAVVT/5bKbGbGP2tClSAAFKBNv9z8Ax93SHYnz6huQhb06slfoNuVA1IpF28eNKjjWwg5kKA5iLmhiq1UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdYwTdQTwuHfrCMPe8pb/w5lotXmRWPQisk9h+OwqN0=;
 b=oauDCp5+1JGjk2Yca5XJ6ew3+SXVr5IvS618YHr4umUbba4E5lkLngAWwGRSkxZTHoUXOqR+OHiD1qjX+cXxY2o1x+uUL5ujw+tegEY6jzIy6j56IkC53XG1stWnZ9B71GYSvUT22xmAVvr17YK+FtjzqEyLnXP0m1h5DjJFbeM=
Received: from BN0PR07CA0009.namprd07.prod.outlook.com (2603:10b6:408:141::8)
 by DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 21:48:59 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:408:141:cafe::87) by BN0PR07CA0009.outlook.office365.com
 (2603:10b6:408:141::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Wed,
 15 Oct 2025 21:48:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.0 via Frontend Transport; Wed, 15 Oct 2025 21:48:58 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Oct 2025 14:48:58 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Jeffrey.Chan@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH v5 1/6] drm/amdgpu: Updated naming of SRIOV critical region
 offsets/sizes with _V1 suffix
Date: Wed, 15 Oct 2025 16:48:44 -0500
Message-ID: <20251015214848.11580-1-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|DM4PR12MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: b21f0bc0-8f01-4009-a3a3-08de0c34a57f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e8xBIGqVlLciIA0SKok8wIk8pq5+j8enpTeHpVYDWMILxbCaOPYbBvG/Gi8a?=
 =?us-ascii?Q?tNY6lvkkzegLAqxovliqPijCcz5mTKnNei6BkmU5yZxYXoezCM+ht9eTZiWS?=
 =?us-ascii?Q?dNlj+eATo6HzzdZz8pkuQRBNG16oaz9m6CRTEYXs4oECNCpIfQkUjinK7BW0?=
 =?us-ascii?Q?gFosOYlzi0xGvvabXftNlLGlDj04B3kTtbT1rozMIxH4LFhE5lxIMgpAjggq?=
 =?us-ascii?Q?Nqg14ZHEltvoJ4lIcfROhxIiddFrdOfdleajrWJHQ2m4PuqxF2iJ1TEh1IWz?=
 =?us-ascii?Q?hPFzpxzxDrRXYuS93BqTFciT/LV5xBlk1t16q4Of0VCdZ7WICEhvx3nfSswp?=
 =?us-ascii?Q?rEAbf3FDSzUq4ln9ymbJy/nEmqR8Xbao2M/+x1EzQoSiLlYQZX8LfbT7DNsG?=
 =?us-ascii?Q?NIjwFyTmOpr/DXmghGc22UWbznsdhtLd0tjcMosMLhAwz/UHI0xr2GuZlTDq?=
 =?us-ascii?Q?3Mpcju0qV1ohoJYPejaaEi49nMdwGZTMJDUgXZa9d8u5eKbvOTa68HPOEd+I?=
 =?us-ascii?Q?wpPBFJxhd6lPSFDnCprAxa7ruK40SilK3UKZTRhXZVkF9NVMtjoSUmE11N+t?=
 =?us-ascii?Q?1ToDkA6Xv0qEnc2pA5pkNcO4NAWZlzyl33QO4ef+YUjt2SNyX57rX8AA+f4h?=
 =?us-ascii?Q?6yT69KPHZxdDyGY29WWVLQVPZm6xKsj88ndozmhslhIR+szR8i4/eESx3SiF?=
 =?us-ascii?Q?1I7qeAxNr0+6lby33d9e7mLZFXflp6ROi5swTjJUSznodfnCAcZ/k8vXUpnl?=
 =?us-ascii?Q?zyBFk30oPTzmfi6l+Y393hSxRomQQKaTA2Xpq0ugcIttIG66uoIQVN/jAdgu?=
 =?us-ascii?Q?KSGp/uqQd3FCcmD6fxtcW7KkuWu6k3A6UB4zqtPq/Gya2wZMpxDo/yy/fXSb?=
 =?us-ascii?Q?+uPU7taU+dUeDYjfXooyc5foAInNaOL1BPBcQT9aeF2KcjiBkfwx2TLACnWA?=
 =?us-ascii?Q?SnoqLRsQmahwxbppBIIWkdRxkWw5x9c8GCc/kqQ9fr3GvUqvkO5BWoBYANAt?=
 =?us-ascii?Q?MI3XOzW1Iu8DSLiMM74pQTvGfU6ZwfxGHohGDW7Rnz7TSuX9maGuY9+XXME6?=
 =?us-ascii?Q?t+9fdh0yJtHbqQcgYRC1o8+8RHQzhU6ShhPve/rVQ3Pqjoenl1+k7gRX1b9w?=
 =?us-ascii?Q?SyNyYsWFGfYNCHdxqTs/se6AeGDDhJ2OiEZkuWrMZSwzerZ635KLGQBz6z/9?=
 =?us-ascii?Q?6GIcc+IHVCCc9Lh5bquOvvDDFWOUlQSVAMs8KTuqmckuHyc4g/XpA3UdbLcJ?=
 =?us-ascii?Q?I+c92S1B0KEg9Hq/vybD7H5KmLeee9EXhKsySI7Z6C0cRfypG2HuAsm2CZ5D?=
 =?us-ascii?Q?Zmc7joiYsnl8DqOzOSKIR2CIxoyBoQ2YXQjUASCZ4K09iN8a75w/vQiQlX48?=
 =?us-ascii?Q?IrnJ/uCU35sAmC8Dggxhldy0QNoQmYePWCKwKDzk96MkDIgpH5cR0KabhTWK?=
 =?us-ascii?Q?aNgzZuAGadmhy1gLsjGAbKpNnkenkl47W0JowRyZgX0D61Z53kWAnbxQbr5V?=
 =?us-ascii?Q?+v+GhAV5cvYyb/StrWyietcvbmWOljQzLuQVwQZIFf03c6xz2q0gqDvgC+Xa?=
 =?us-ascii?Q?n+qp2ALdsb8uwrKrXS8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 21:48:58.7204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b21f0bc0-8f01-4009-a3a3-08de0c34a57f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748
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

 - This change prepares the later patches to intro  _v2 suffix to SRIOV critical regions

Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 20 ++++-----
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 50 +++++++++++++++------
 2 files changed, 46 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index f96beb96c75c..8cd02eb605c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -686,7 +686,7 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 		/* got through this logic in early init stage to get necessary flags, e.g. rlcg_acc related*/
 		adev->virt.fw_reserve.p_pf2vf =
 			(struct amd_sriov_msg_pf2vf_info_header *)
-			(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
+			(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
 
 		amdgpu_virt_read_pf2vf_data(adev);
 	}
@@ -703,21 +703,21 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
 		if (adev->mman.fw_vram_usage_va) {
 			adev->virt.fw_reserve.p_pf2vf =
 				(struct amd_sriov_msg_pf2vf_info_header *)
-				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
+				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
 			adev->virt.fw_reserve.p_vf2pf =
 				(struct amd_sriov_msg_vf2pf_info_header *)
-				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
+				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 << 10));
 			adev->virt.fw_reserve.ras_telemetry =
-				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB << 10));
+				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
 		} else if (adev->mman.drv_vram_usage_va) {
 			adev->virt.fw_reserve.p_pf2vf =
 				(struct amd_sriov_msg_pf2vf_info_header *)
-				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
+				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
 			adev->virt.fw_reserve.p_vf2pf =
 				(struct amd_sriov_msg_vf2pf_info_header *)
-				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
+				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 << 10));
 			adev->virt.fw_reserve.ras_telemetry =
-				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB << 10));
+				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
 		}
 
 		amdgpu_virt_read_pf2vf_data(adev);
@@ -1304,7 +1304,7 @@ static int amdgpu_virt_cache_host_error_counts(struct amdgpu_device *adev,
 	checksum = host_telemetry->header.checksum;
 	used_size = host_telemetry->header.used_size;
 
-	if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
+	if (used_size > (AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1 << 10))
 		return 0;
 
 	tmp = kmemdup(&host_telemetry->body.error_count, used_size, GFP_KERNEL);
@@ -1383,7 +1383,7 @@ amdgpu_virt_write_cpers_to_ring(struct amdgpu_device *adev,
 	checksum = host_telemetry->header.checksum;
 	used_size = host_telemetry->header.used_size;
 
-	if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
+	if (used_size > (AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1 << 10))
 		return -EINVAL;
 
 	cper_dump = kmemdup(&host_telemetry->body.cper_dump, used_size, GFP_KERNEL);
@@ -1515,7 +1515,7 @@ static int amdgpu_virt_cache_chk_criti_hit(struct amdgpu_device *adev,
 	checksum = host_telemetry->header.checksum;
 	used_size = host_telemetry->header.used_size;
 
-	if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
+	if (used_size > (AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1 << 10))
 		return 0;
 
 	tmp = kmemdup(&host_telemetry->body.chk_criti, used_size, GFP_KERNEL);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 3a79ed7d8031..7509756b9ac5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -23,26 +23,48 @@
 #ifndef AMDGV_SRIOV_MSG__H_
 #define AMDGV_SRIOV_MSG__H_
 
-/* unit in kilobytes */
-#define AMD_SRIOV_MSG_VBIOS_OFFSET	     0
-#define AMD_SRIOV_MSG_VBIOS_SIZE_KB	     64
-#define AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB AMD_SRIOV_MSG_VBIOS_SIZE_KB
-#define AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB   4
-#define AMD_SRIOV_MSG_TMR_OFFSET_KB	     2048
-#define AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB	     2
-#define AMD_SRIOV_RAS_TELEMETRY_SIZE_KB	     64
+#define AMD_SRIOV_MSG_SIZE_KB                           1
+
 /*
- * layout
+ * layout v1
  * 0           64KB        65KB        66KB           68KB                   132KB
  * |   VBIOS   |   PF2VF   |   VF2PF   |   Bad Page   | RAS Telemetry Region | ...
  * |   64KB    |   1KB     |   1KB     |   2KB        | 64KB                 | ...
  */
 
-#define AMD_SRIOV_MSG_SIZE_KB                   1
-#define AMD_SRIOV_MSG_PF2VF_OFFSET_KB           AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB
-#define AMD_SRIOV_MSG_VF2PF_OFFSET_KB           (AMD_SRIOV_MSG_PF2VF_OFFSET_KB + AMD_SRIOV_MSG_SIZE_KB)
-#define AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB        (AMD_SRIOV_MSG_VF2PF_OFFSET_KB + AMD_SRIOV_MSG_SIZE_KB)
-#define AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB   (AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB + AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB)
+/*
+ * layout v2 (offsets are dynamically allocated and the offsets below are examples)
+ * 0           1KB         64KB        65KB        66KB           68KB                   132KB
+ * |  INITD_H  |   VBIOS   |   PF2VF   |   VF2PF   |   Bad Page   | RAS Telemetry Region | ...
+ * |   1KB     |   64KB    |   1KB     |   1KB     |   2KB        | 64KB                 | ...
+ *
+ * Note: PF2VF + VF2PF + Bad Page = DataExchange region (allocated contiguously)
+ */
+
+/* v1 layout sizes */
+#define AMD_SRIOV_MSG_VBIOS_SIZE_KB_V1			64
+#define AMD_SRIOV_MSG_PF2VF_SIZE_KB_V1			1
+#define AMD_SRIOV_MSG_VF2PF_SIZE_KB_V1			1
+#define AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB_V1		2
+#define AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1		64
+#define AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB_V1		\
+	(AMD_SRIOV_MSG_PF2VF_SIZE_KB_V1 + AMD_SRIOV_MSG_VF2PF_SIZE_KB_V1 + \
+	 AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB_V1)
+
+/* v1 offsets */
+#define AMD_SRIOV_MSG_VBIOS_OFFSET_V1			0
+#define AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB_V1		AMD_SRIOV_MSG_VBIOS_SIZE_KB_V1
+#define AMD_SRIOV_MSG_TMR_OFFSET_KB			2048
+#define AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1		AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB_V1
+#define AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1		\
+	(AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 + AMD_SRIOV_MSG_SIZE_KB)
+#define AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB_V1		\
+	(AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 + AMD_SRIOV_MSG_SIZE_KB)
+#define AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1	\
+	(AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB_V1 + AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB_V1)
+#define AMD_SRIOV_MSG_INIT_DATA_TOT_SIZE_KB_V1		\
+	(AMD_SRIOV_MSG_VBIOS_SIZE_KB_V1 + AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB_V1 + \
+	 AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1)
 
 /*
  * PF2VF history log:
-- 
2.34.1

