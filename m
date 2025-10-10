Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7E3CAC5BB
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 04:43:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 808A410E261;
	Fri, 10 Oct 2025 04:43:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LPGuVk1I";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010023.outbound.protection.outlook.com [52.101.61.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0E8F10E261
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 04:43:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPzmIzeoPcQWxv5r1rkAUb/el5wy0s4F3iMDRWrwL3pbFFbqv2ZLauQK3pzhBt5mVcW3gy9jOiZw5ziPMIw32EAMjl8Etypf2qmz7+L3ckJmVrTyIihDuo0JnJNjyydLsEizqhg4YZpydJlLvMt0KxqI7MwAOkC1lHxHD8vsFnkMin1y5s32/6kzEfX6NMO3vxtl8Gyfo4gMb2SMDyRgUde3Qk34WGlf4Qk7GT3duS2Rqg45z+bljJxckyZRa0XO5RzrrobHGGrDK3mEHUlllUHC8/WH/FAGm/TXHyIqQJ+r2TymiqXb5FYTc3GkFv7UtP5K9i1E2qom5BMLeqA5HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jqn6yb6/7PLpjhbDBYniO+ZWyakEfOyEUhxx1ULeIdw=;
 b=wHs4LBldoYZ/gZdAi1+Pi2Dw+erBksusYR8PkBMf/ZU92lingcyeYysE90iDeTkrzW+ss/QaeH8ZcN1yRteEPwe1w4xi37Q+atpJXh/3dVBTDSSUYei+Clu+Q9PbYi/w6tCNILG+SvqCCYOtYVAR/9RYcKgND8XinGkeipFoVMmqjNFTa/nYRXv1NJoD505X2YUkAwxiKSQAvFzZes2aRzpC2VEzYXYZD+mp8bGkSfVzoA6hQSACEYAbh+LefcZT3FPo68L7vLFsgNu4P/9ZrWrOL0iIrrnW2haM01uhzCyOz1OqvgpaDrbaUVVpemd42IvrCMyW7136GRcDLZuWUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jqn6yb6/7PLpjhbDBYniO+ZWyakEfOyEUhxx1ULeIdw=;
 b=LPGuVk1IZ4ZCqD4ENolEzuVDCKAFggBji5eOclSqfHPdXIV6RPBvdG5Sadk0c8PRBKnUY7kfgnBbGygkCkBfZR2dhcVo8nSvQ1S17TCVnskeV3SvtAK7kShoQhcbpkCnTwP0H/aL4GEXz5nSeM+wT4uCqreJUgqT3v9yXlrDQ5E=
Received: from MN2PR15CA0031.namprd15.prod.outlook.com (2603:10b6:208:1b4::44)
 by MW6PR12MB8708.namprd12.prod.outlook.com (2603:10b6:303:242::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 04:43:22 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:1b4:cafe::ba) by MN2PR15CA0031.outlook.office365.com
 (2603:10b6:208:1b4::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 04:43:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 04:43:21 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Oct 2025 21:43:20 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Jeffrey.Chan@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH 1/6] drm/amdgpu: Updated naming of SRIOV critical region
 offsets/sizes with _V1 suffix
Date: Thu, 9 Oct 2025 23:43:04 -0500
Message-ID: <20251010044309.11822-1-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|MW6PR12MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c10515-5377-4471-8e01-08de07b78a38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u4d4kmmcZvEeBrVNpWIhwWObYvkfJJ5VAJaubZepdHQTNDkqvf1sfm6YOyQY?=
 =?us-ascii?Q?eMMJANqyhEHZcCCYlzoBF7guVnwi0j/wPVr4HDlCF+oYkiHVxJVLJfH99EDq?=
 =?us-ascii?Q?EArY+V+uR1UOwq60hVmHRADH4XaAlErmjflDDtgBfljmsI+ZTpINa64qliR5?=
 =?us-ascii?Q?Y4HCOMgjJg6l+Ud6jDd+XwWuzunega6mPXLAK61i4alP4nAikaNyO2Hq8GpI?=
 =?us-ascii?Q?yRzo8Vvt4C9oXBAWGnE12EZ0jwVe2fF7l2Xq1VKHufa2NcFJHjfwmbDADMwm?=
 =?us-ascii?Q?ntS3oGK6CKMKl6G412tFif5J5LGi1uXYoON4R71VfhFzUy/AzFIzvrJa4DUP?=
 =?us-ascii?Q?h2DNlEYQeSG33TeUo7QcRDPglEYhv7Xmq+1gnSDM3lbrkoBH0Kokiaoc9bKW?=
 =?us-ascii?Q?rZB6bp8PvOTOSPsLJRJx7IrVRjE9lSm3crU8buCLQCulSsVGRDR4ossZNUBj?=
 =?us-ascii?Q?WP/U4GOZ3sVWxYbG1yqrI/g0vxSLmdHWzM4sDvzTHFYdk6CUE0vfZWmQaX8O?=
 =?us-ascii?Q?k77R1ZPMDQL0cm1kG74q0NM3JwDE0bRrHoO7pFTsL0Pw6PqNFtXgjAK7PB0n?=
 =?us-ascii?Q?sGHX2duZmVSahNc3nWX5h5UZo5JKNnvzBdpKNEurSRVxRrqWaI7tcXJkDlb/?=
 =?us-ascii?Q?OnesJHrAWjaH75pKqesws8ZY7JlBqhL6BZze9OdBEJC+aNFA7TEew6ubNBvJ?=
 =?us-ascii?Q?9LGIJeJ2X2nF+RuZoeXOF2WNi9cPVe59cIzD3ZA7uGaKdbpLgo+h21WcWpg5?=
 =?us-ascii?Q?iEHuuA9+DaxxrPAJIJgIFfYWLMKZu9X8bpWKajNyB8YNszRVfwxrJ7b9Jqcw?=
 =?us-ascii?Q?UDb0KcUOidtTuQYwE8dilM6NfXdR9fwfu4u0tVxcY4qrUkTLkmdzNNG7V+5K?=
 =?us-ascii?Q?IkFuGoT4SGOxjt0AXNIG1pzCWcSDXb+gJARqIK3YAUldUchFFXkTERWnbXRH?=
 =?us-ascii?Q?71lo3PIDY5iVUuPHsbIvz0l7W+tWXiWStssQmMoFjkt72UcM+/ehLz0wG09v?=
 =?us-ascii?Q?4fpKIuu24gibdop/W+IY2fq+d/DpELR2dDrlRgOBdBgPwjKBri1icyqyp1vW?=
 =?us-ascii?Q?jOhG50WzEed1/EM8d/ZTmyUiMLAB3jVPKBn4n9cU0D0Y5Y0nwqPMrgK8yQD7?=
 =?us-ascii?Q?M7rSJOBHR5Fvcz3GHcWTRxDoL2ad+Xj4/Ey6O91ZTm+d+4g8cH9saabaztKI?=
 =?us-ascii?Q?cvNC3P3TeDnK7rivg6wwVnuhs3iFTWwM1fC36wGTzRci/G9IbIfW9f+sRMQG?=
 =?us-ascii?Q?49CIgjQ27YRLjXTNh/FVaYGzJw+oIKKeHphBlPFcDEsyxFqVtRG5KGyapyPB?=
 =?us-ascii?Q?qznXSsEEHOP6wzSGurZlGYnp78rvC1i8Wh+sHtQobtsD8P9napdHOh+ZSTzI?=
 =?us-ascii?Q?u/1TLTFXRYgr5jZBW2LUYTKHydnabxrOPj5wOow31ERC7O7fKdYUe/iAveAT?=
 =?us-ascii?Q?CLC7t8vlUEbv5s7tVOHi+u6Ge8z7LIoG1Owkv2UucJAxS8irPGVTsqFtbk6v?=
 =?us-ascii?Q?z5PRaPHteDXdGDAX+DmX9un4mYvPJ9LmL+YE9aef/xjv1JW9T3m33GPeDSQx?=
 =?us-ascii?Q?Ber3jKY/J+nLvYBnCY8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 04:43:21.2105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c10515-5377-4471-8e01-08de07b78a38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8708
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 20 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 57 ++++++++++++++-------
 2 files changed, 49 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 3328ab63376b..e95adf0407a0 100644
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
index 3a79ed7d8031..3b35154e2df6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -23,26 +23,47 @@
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
+#define AMD_SRIOV_MSG_SIZE_KB_V1			1
+#define AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1		AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB_V1
+#define AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1		\
+	(AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 + AMD_SRIOV_MSG_SIZE_KB_V1)
+#define AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB_V1		\
+	(AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 + AMD_SRIOV_MSG_SIZE_KB_V1)
+#define AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1	\
+	(AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB_V1 + AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB_V1)
+#define AMD_SRIOV_MSG_INIT_DATA_TOT_SIZE_KB_V1		\
+	(AMD_SRIOV_MSG_VBIOS_SIZE_KB_V1 + AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB_V1 + \
+	 AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1)
 
 /*
  * PF2VF history log:
@@ -436,12 +457,12 @@ unsigned int amd_sriov_msg_checksum(void *obj, unsigned long obj_size, unsigned
 #define _stringification(s) #s
 
 _Static_assert(
-	sizeof(struct amd_sriov_msg_vf2pf_info) == AMD_SRIOV_MSG_SIZE_KB << 10,
-	"amd_sriov_msg_vf2pf_info must be " stringification(AMD_SRIOV_MSG_SIZE_KB) " KB");
+	sizeof(struct amd_sriov_msg_vf2pf_info) == AMD_SRIOV_MSG_SIZE_KB_V1 << 10,
+	"amd_sriov_msg_vf2pf_info must be " stringification(AMD_SRIOV_MSG_SIZE_KB_V1) " KB");
 
 _Static_assert(
-	sizeof(struct amd_sriov_msg_pf2vf_info) == AMD_SRIOV_MSG_SIZE_KB << 10,
-	"amd_sriov_msg_pf2vf_info must be " stringification(AMD_SRIOV_MSG_SIZE_KB) " KB");
+	sizeof(struct amd_sriov_msg_pf2vf_info) == AMD_SRIOV_MSG_SIZE_KB_V1 << 10,
+	"amd_sriov_msg_pf2vf_info must be " stringification(AMD_SRIOV_MSG_SIZE_KB_V1) " KB");
 
 _Static_assert(AMD_SRIOV_MSG_RESERVE_UCODE % 4 == 0,
 	       "AMD_SRIOV_MSG_RESERVE_UCODE must be multiple of 4");
-- 
2.34.1

