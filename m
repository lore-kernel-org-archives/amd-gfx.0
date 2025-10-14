Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5623CCCD184
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 20:14:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4AB410E68C;
	Tue, 14 Oct 2025 20:14:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XXr/q4jF";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012028.outbound.protection.outlook.com
 [40.93.195.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2BA310E68C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 20:14:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5YGZk7DL9KeC1gcbzYwAYMT4SCBmpfOQDd1UbizDqufSkfGVV4/5uqgh9BAwfga6ji5YA6S7B0O3GqkkEJca148W8oUIjG5VE1vGFjIw6z3GG/1ZrjSGRgSTzKL58FCLqP66FOO0K7Kk2QfsvwAsiCnxEMnRJxHzP2y81ZcW025eLw4gnK+zM2jvcqdpL9CXf9oFUUYYJrVHGNj/q1RUWVogIn1263e6ZwMuE1r62GrL3EEMaJHl65glKjqie9LtVamfxLZO2zkAQkNLY7DqqbQNQt22YF4BRNyF55utZR+xaR3D7NFlMfbw3ENHOnG51TEFD1gBgp/yeRjAwXTaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jqn6yb6/7PLpjhbDBYniO+ZWyakEfOyEUhxx1ULeIdw=;
 b=j3/3ovISzSQXdaLwoDVkO53TYyGWuWVgv+pwlmYWJ8MKIfAyJxeHRbkw5hhS2jV41KdXTu6Y2Kk4lQ1O3gcK0YDkpu6PVGnSxT7l4FZh/b13/A0bGYz59LF3mKlKZwgLGc3qTn4x9pPbakxyjgC3jpnPmvHE67zsBJHk+rgCO1sVfPDKS40cwatdV9ucFFlj1CugAWGTx2bcWEkbIY1JSPumzCdvwuOLrzepwJhq05FwDusMM7oDVJoKsVBggzImqeVsE2ZZ1fcgrt5lFjgcvgb+Ra6p9aDU6KPOf6scgs7jlWwEn0IbCcnDJCZ6kYOKoGluC0VCPRLWB8FPttX4Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jqn6yb6/7PLpjhbDBYniO+ZWyakEfOyEUhxx1ULeIdw=;
 b=XXr/q4jFUQO2j2oQ5upmeyXpypdl+QPANySKYH6RsBLU1IX/11afxswWEQRbSUmYV4OkWyTWPsSEU1DrRjc5GkV/4BY5Nx1HXONjFqS58exYJhrgXI5WwhgwprwJqlkDslYXyPTtTagsPRJNQbGFjS+zxiM9O06oAdABXo47M58=
Received: from SA1PR05CA0004.namprd05.prod.outlook.com (2603:10b6:806:2d2::29)
 by SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 20:13:58 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:2d2:cafe::5f) by SA1PR05CA0004.outlook.office365.com
 (2603:10b6:806:2d2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Tue,
 14 Oct 2025 20:13:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Tue, 14 Oct 2025 20:13:57 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Oct 2025 13:13:56 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Jeffrey.Chan@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH v3 1/6] drm/amdgpu: Updated naming of SRIOV critical region
 offsets/sizes with _V1 suffix
Date: Tue, 14 Oct 2025 15:13:41 -0500
Message-ID: <20251014201346.9422-1-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|SN7PR12MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e48bf6-01c6-469d-151a-08de0b5e34f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6yYFry37UNIFuWUn2NFVMXKzsJCu4n+fjUmgSGmSV/AxxRFi9RiSuuPFRxlT?=
 =?us-ascii?Q?PRPuO1Bec3G17BLdv9+ROwTChE/ilimF2lrYhyLb9YSp0SxW41Flv52XD6or?=
 =?us-ascii?Q?R/2DjlYEb6gQU1SSU3FjSG0ytMlyd43GOvBfg9bMXBv0uSa9RY3o1nPS/Ma+?=
 =?us-ascii?Q?QSjj+KEFRK+Du4r4TM/jaT4FO1h/WGH8F5bQpbrh6pmVRL1fxehYF4JsrLO1?=
 =?us-ascii?Q?PabJKc58Ggb4upo/5tOAB2iyilB7IcCzaZ6GeCIDyJzZfBDNA8yADd4XtBVz?=
 =?us-ascii?Q?TAnehuDMBU/LLmVSyCfoAOpeoIdfO5VzBRunVFCReu2GP4ehsrdOYxvgPTAg?=
 =?us-ascii?Q?Sb7dHmCnwTXMkH1CISuutaFqd8KX79bwiqIGLhD6Nqqj2l+4Co4T6o3zExrM?=
 =?us-ascii?Q?a0o6oy6ygHDdC3WdxJBGOniSerHcm2dklTUTQHhImj7zG3FY/EekMb5+k8fu?=
 =?us-ascii?Q?WUrpuc1KPBxo6kDjF22P7jrQAgSixjEI3Ta094AWuiPWz2yvX387H+IM+KBf?=
 =?us-ascii?Q?42p6HAFWvyxrze0daVGcYQwLnaScnLuLBuel80TiP2eEI7uz15McO4Aj/SCW?=
 =?us-ascii?Q?e0LUrxUev4DTMGCMPUaE2wyFIY8Gr8qODsZAxQas1ffvTm+gvHZc8by+7Obg?=
 =?us-ascii?Q?4pGJUG7AhdSESQaHM7STTAjyJMBC4tb8xz0Upx2sMRsBiQpjHNq6Yg/YX6Zx?=
 =?us-ascii?Q?9J+VjhAmxtspSyvS0rG7PhMqQ8hDW1f2/CsAlJ51LcOwzLXp7DgniNFfILVR?=
 =?us-ascii?Q?CGloWmOdPar08OqIpLYOL97hy0iUaAbHsSTjmf6jz9Y9sZaL5YH5dAV25KS8?=
 =?us-ascii?Q?AsGD43gwPWxxJ6knljWDxTvNbe7I4gXB/Sxa7939RZO8spn6hZcdpw1bRO+S?=
 =?us-ascii?Q?EEZTM9n/ByK/Juwbz+OypTN69DcvQBD2TaIctF4t5p5NdknNiseeW3RD14C8?=
 =?us-ascii?Q?WsAFZFtl4zEKjs9jiZnmhuA4T33/6r1tShmU/GnrWsEyj/Clrv3cTqv2VNGj?=
 =?us-ascii?Q?/S+WZsv+RapzfyaUF5MReu4sJWN03ahJYtEGmgdJO8t0wtHK+j28vQzuF1QP?=
 =?us-ascii?Q?HHYuOIfYOeg7aQQrA9WeS21q02A8Zlh896UgRnFqMB+JfFuai6XDrhUMIQdN?=
 =?us-ascii?Q?iVH/k6T1ADQC46kMcFkcElnodffOhl6gacoq64T52MPtYa+ZzGPBTwxJR/Yn?=
 =?us-ascii?Q?CwwDxNGUeHz4sAFh2ZX8Z4lNKXsMt+QJrYxGs/PjE2Hfe4S9ipAjs96IcaSG?=
 =?us-ascii?Q?Qt5EeJHbHQqQZF1GbsTU3Sy7dKylPCVTIcrDnr421btYOuohgUEwFa+6HR3z?=
 =?us-ascii?Q?iODSpSVfVnsi9/g0/BalzPGoYblj2LSyWBkIxZHiQgBcs9+Hsjd1eQYM1aT3?=
 =?us-ascii?Q?W51VvtEZA52ZflU1yv4DD0Eh7hbf3n1vISD3WMCiebRdU4ck4sdn+luTORXN?=
 =?us-ascii?Q?umZlAlKaNpIV28RjftSWjHNRxg5ryZQjE4L9JzJa3aoKmdE0+ggGHVQBwYR+?=
 =?us-ascii?Q?wcxph9jEjXV3s2npgGRYYe9ifTlq15prlL8x+1V5wES3495vHBcxijX4BNOH?=
 =?us-ascii?Q?1Tia0zl51oWob1Ikw1Q=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 20:13:57.5817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e48bf6-01c6-469d-151a-08de0b5e34f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8059
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

