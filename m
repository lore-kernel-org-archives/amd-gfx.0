Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B8DCCD185
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 08:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D758F10E3EC;
	Mon, 13 Oct 2025 08:02:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XYpa9T/F";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012024.outbound.protection.outlook.com
 [40.107.200.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A63A310E3EC
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 08:02:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yuGUCOsNzqkIO6kL4ACNvzm0mBdVB3AvmO65IBy50NQD57n34BN4J0WVEAQtoFE4GdihfrEis45vRe6CfXspfe6QCD2HJOK49iluJ9yUHBRUzbbY2/2Z186NutKimzcNqYr1sdr4+lexUJrgnxrhtK31BEZuDRegC0rYiDXodD3z9u3NLNXgZNtQS+ZIQNT0bQ5r3glhutZhp8tKAEoUfghnGktVHuo/mPKnbGsCfA69nFYA96j1XF7jm9g/XPmSeGvM+20nsPgj4vCn4udoiuk1KEWwSvkiid5Wo7HiwTXfE0aAURnWaLJrpm71sP/DXIwVene6Owo4hdKqVyC1zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAQaTRGjuv/6YBlV3ZwPjXKSRmiQ2yTU1WZrfuktvQc=;
 b=jhCVH/yzUH49cjI6hNRJjOkL6Mh4sx6Y4Mj89HOSQtga8yB8XgcohqFfDe6/wvkkK59sR24K3SkixyBvHVsqBBWmUlRKyjffAgeVkjW774pvk+dpKZ71xtAJym9TmZdy+Z1aVGmQeTGLOr7/9KSLKlPvdyQlR2aZcTY3BcQ2m6pCWylvnzghfCQjI2kxTBYPQISUj6osDeG0yyeg8xXbHYOT/aMhhSEHRNL/cnlDbGe+REJP16cjAGsuWWACry4a0tp7xSdg1SxrK1f1v7aXiix+anSYyULgPAG0DCj7iAGQtFACW8n9zmfDZpnx0lkf+kusGqfPaxlWXi+93Ym3qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAQaTRGjuv/6YBlV3ZwPjXKSRmiQ2yTU1WZrfuktvQc=;
 b=XYpa9T/FAzrd9tiMS1KAvqRzuXYv+7DqV3mC1fxwb1xkh4F5SEtej7tHHqkHkgT/fAFVfvsc1F8pX5MQ+t+qq0jkTlSYY1Fj5cVZUVItm3ONlbY/8/LF0lQ/CRfktJZubgB88nH+oZ+YF+lBlZugP+Vte11ki5yKnb3dsI+SLUI=
Received: from DS7PR03CA0339.namprd03.prod.outlook.com (2603:10b6:8:55::18) by
 DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.13; Mon, 13 Oct 2025 08:02:15 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:8:55:cafe::25) by DS7PR03CA0339.outlook.office365.com
 (2603:10b6:8:55::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 08:01:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 08:02:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 13 Oct
 2025 01:02:14 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 13 Oct
 2025 03:02:13 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Mon, 13 Oct 2025 01:02:12 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v4] drm/amdgpu: Fix NULL pointer dereference in VRAM logic for
 APU devices
Date: Mon, 13 Oct 2025 16:00:48 +0800
Message-ID: <20251013080212.1722494-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|DM4PR12MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a32ddb-4799-485f-03ed-08de0a2ed28d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmxnQWVlS1o2QkhuMlhjTERTNnBhcUFoVGlwZ0s3NS9pZUhvVDN0MHQ5R213?=
 =?utf-8?B?bVFTQzgyeVBTY1VWeE12SUJId0Nqd2c2bGxUZnJOZ0ZSbVNHT2RJRkN1Y3E3?=
 =?utf-8?B?YmtxWDZKdlRSQ1pNaVJzTHBnTk12MDd2YUZ4d3FBM1kybjZYTkc5TkVqdkZC?=
 =?utf-8?B?R3lReENTdE1ydklib3JjVHBwdUpxcUdzWlg5WXBUUFhEUFdMVkY5eXlQQWR2?=
 =?utf-8?B?TzMxcWNWK3J0T2ZNUmJ2alh4RVo2N25ZWHpqL09USE9jblY4MXQ0M0lyMWdJ?=
 =?utf-8?B?Q2t5bGhBaDZZUGlpamxwc0FUV0tQVHhlV1Y0U0tsU0tOc2FKcGdMZUIxUnBF?=
 =?utf-8?B?V3BmVEUwaGU3ejNFKzMzWGxpdGNTaUdrRWN6ak1NL3Zsa1JwUlVMd2lYSnVH?=
 =?utf-8?B?bk1jYmM4c2M5bloxSzlkemg3SitsRkxERlNvc0VVbGZWTFVoNHIwWXUyc2xX?=
 =?utf-8?B?ZSt6R2tTWnczTm5vME5YRWJsNEhZd0ltVnhBYjJpYzFEUk5xY0FPYUpsOHBX?=
 =?utf-8?B?QnpYZWxxaktvSkQvcENKY1V6bjBTV0FRNU9tTjNSZmdLU2hhRkVPd2FXREtj?=
 =?utf-8?B?Z3E1ZGlxZHVNYitnY01PYmNzNkFZUUFWWG5Gc2Z3dUthSFNRcUlHNmVHRXRi?=
 =?utf-8?B?M285azMxR3dYU3ZOS1VzOWIzS25zS25BRkVTS0FwQU16MmZRVjlXUnhhVFJ4?=
 =?utf-8?B?ODk4MXpSZEV5am51SFQ5c0lRZ3NFOXZPeGtnUkZnekxhSjBDNkh2N21qTXA1?=
 =?utf-8?B?NkZGN1JON2NaNlRsY1IxU1J1bkNyWjNKc0VDSUJhQkk3TUNrVnBYdkE5S0hp?=
 =?utf-8?B?cmhtdS9hVTZjL0pSb2ZUQXliTndkMEpsSkVxL1VzMk1TbG4xdXoyNHM1QXl6?=
 =?utf-8?B?QUc3U0crZTR1QjIyaitKUzBjTE9HTndIS3d1UE1IaGRlRGZobTl2NkgzL01v?=
 =?utf-8?B?YkZQWDA5NVZiZ0Npb0w3TlVyNmRvZlpiQWhVcE5YVzQrbTJwMDUzTkdhK0Ju?=
 =?utf-8?B?NzJZclRCQzB0bXNhQzhLV0NtTG5TaDVKQ0lyYWxRWmRjM2EzVWU2S05YazFU?=
 =?utf-8?B?Wllka3FMTDZEclR1S2ZHTm9oWFdhckxCN2txSjFKbG9hNlgzdU40ZXNyTjNk?=
 =?utf-8?B?cDZtOHlLTDhUelZ0WWc3MFlockFRTVEraXpCdkQyNEhXbm5RYUhwR1hUNEFZ?=
 =?utf-8?B?MEwyQVFMdnZnK0EzQkcwSlZRM0RtWEExeVJaTXgrdGVqMXhneXVBUmVKMGNZ?=
 =?utf-8?B?dDdBUHo2OXNBNDZmU1JzYlkrcldsc3Z3U3FReHQybmNLRkVza0RmVE1TNVI1?=
 =?utf-8?B?WTNtRFZJNXVrb01VZU1NU2ptWXVvUTU1T05OL1pQdzBJeEVWT0NYRkNBMWow?=
 =?utf-8?B?dXRUelNPY05BWllDMzFRZFd5bGRWNWkvbkNhRnZZb2RmSDE5Q3UwS0tRb0xk?=
 =?utf-8?B?VDM5SENTRHBwd1Y4ZDBZYVVFOEt4cjZrRHpNTmc5QUVESkVyRnhyZEFpM0Ry?=
 =?utf-8?B?alBXdlowTDkzTE5WbUdCWHAyQ3JRY2w1Vyt0QzFTR2NLUzFpNmpjVEd4Yjlt?=
 =?utf-8?B?TXhLdFA5NlJuMk1iTGRvVHhONUZUSGhGTWJSMmdodU9lNHVlL1FZWTFVZmw5?=
 =?utf-8?B?VTNhbEtJU1JmajJJV1pzMVlrbWtNZ3c3ZEFlSDAwanJoa3hMSEhkUTJhZHJ5?=
 =?utf-8?B?QVpBVGRTVmlxeHdPM3Z4ZkVMc1QvWHQ3a3QvMUt4YU5raldPTmdDb2Mzb2M5?=
 =?utf-8?B?N2QxU0h6cGdRMUwzaHBnaGZuTlJGaUFCTHZZQ01JL1FkV0FDVUhkWEk3RnZw?=
 =?utf-8?B?a3NYNDdKS1p4QmkySUUwZXh6L1Rkai9TdnJtamJiTUI0VTRlYk1GdkYrOVpx?=
 =?utf-8?B?ZUxSL0pOR3hCT244RER5cTdNTm5IMndKK0hyelN4YlJsYjZlajR5UktUS2I3?=
 =?utf-8?B?Zks2WnBrVzFkTDlnM3NVUW9vSXF2RVM3NHJOSmpLandJaVdQczBKaGFJQzBI?=
 =?utf-8?B?eFkyU3JjV1NxL2FrSXBTQXJZbEJ1R1pEeXdUTVZKRDZBVTNUQjl3VHpUS3Vl?=
 =?utf-8?B?WTBTRE1TZkx1Z3BTUWxtb2lHWlp6N0VodWc3S2Vld2JZNUZrZUZMS2lFcHV2?=
 =?utf-8?Q?hFlY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 08:02:14.9544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a32ddb-4799-485f-03ed-08de0a2ed28d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648
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

Previously, APU platforms (and other scenarios with uninitialized VRAM managers)
triggered a NULL pointer dereference in `ttm_resource_manager_usage()`. The root
cause is not that the `struct ttm_resource_manager *man` pointer itself is NULL,
but that `man->bdev` (the backing device pointer within the manager) remains
uninitialized (NULL) on APUs—since APUs lack dedicated VRAM and do not fully
set up VRAM manager structures. When `ttm_resource_manager_usage()` attempts to
acquire `man->bdev->lru_lock`, it dereferences the NULL `man->bdev`, leading to
a kernel OOPS.

1. **amdgpu_cs.c**: Extend the existing bandwidth control check in
   `amdgpu_cs_get_threshold_for_moves()` to include a check for
   `ttm_resource_manager_used()`. If the manager is not used (uninitialized
   `bdev`), return 0 for migration thresholds immediately—skipping VRAM-specific
   logic that would trigger the NULL dereference.

2. **amdgpu_kms.c**: Update the `AMDGPU_INFO_VRAM_USAGE` ioctl and memory info
   reporting to use a conditional: if the manager is used, return the real VRAM
   usage; otherwise, return 0. This avoids accessing `man->bdev` when it is
   NULL.

3. **amdgpu_virt.c**: Modify the vf2pf (virtual function to physical function)
   data write path. Use `ttm_resource_manager_used()` to check validity: if the
   manager is usable, calculate `fb_usage` from VRAM usage; otherwise, set
   `fb_usage` to 0 (APUs have no discrete framebuffer to report).

This approach is more robust than APU-specific checks because it:
- Works for all scenarios where the VRAM manager is uninitialized (not just APUs),
- Aligns with TTM's design by using its native helper function,
- Preserves correct behavior for discrete GPUs (which have fully initialized
  `man->bdev` and pass the `ttm_resource_manager_used()` check).

v4: use ttm_resource_manager_used(&adev->mman.vram_mgr.manager) instead of checking the adev->gmc.is_app_apu flag (Christian)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  | 7 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 4 ++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 5f515fdcc775..2fa931a20530 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -709,7 +709,7 @@ static void amdgpu_cs_get_threshold_for_moves(struct amdgpu_device *adev,
 	 */
 	const s64 us_upper_bound = 200000;
 
-	if (!adev->mm_stats.log2_max_MBps) {
+	if ((!adev->mm_stats.log2_max_MBps) || (!ttm_resource_manager_used(&adev->mman.vram_mgr.manager))) {
 		*max_bytes = 0;
 		*max_vis_bytes = 0;
 		return;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index a9327472c651..b3e6b3fcdf2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -758,7 +758,8 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		ui64 = atomic64_read(&adev->num_vram_cpu_page_faults);
 		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
 	case AMDGPU_INFO_VRAM_USAGE:
-		ui64 = ttm_resource_manager_usage(&adev->mman.vram_mgr.manager);
+		ui64 = ttm_resource_manager_used(&adev->mman.vram_mgr.manager) ?
+			ttm_resource_manager_usage(&adev->mman.vram_mgr.manager) : 0;
 		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
 	case AMDGPU_INFO_VIS_VRAM_USAGE:
 		ui64 = amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr);
@@ -804,8 +805,8 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		mem.vram.usable_heap_size = adev->gmc.real_vram_size -
 			atomic64_read(&adev->vram_pin_size) -
 			AMDGPU_VM_RESERVED_VRAM;
-		mem.vram.heap_usage =
-			ttm_resource_manager_usage(vram_man);
+		mem.vram.heap_usage = ttm_resource_manager_used(&adev->mman.vram_mgr.manager) ?
+				ttm_resource_manager_usage(vram_man) : 0;
 		mem.vram.max_allocation = mem.vram.usable_heap_size * 3 / 4;
 
 		mem.cpu_accessible_vram.total_heap_size =
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 3328ab63376b..f96beb96c75c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -598,8 +598,8 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
 	vf2pf_info->driver_cert = 0;
 	vf2pf_info->os_info.all = 0;
 
-	vf2pf_info->fb_usage =
-		ttm_resource_manager_usage(&adev->mman.vram_mgr.manager) >> 20;
+	vf2pf_info->fb_usage = ttm_resource_manager_used(&adev->mman.vram_mgr.manager) ?
+		 ttm_resource_manager_usage(&adev->mman.vram_mgr.manager) >> 20 : 0;
 	vf2pf_info->fb_vis_usage =
 		amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr) >> 20;
 	vf2pf_info->fb_size = adev->gmc.real_vram_size >> 20;
-- 
2.49.0

