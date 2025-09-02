Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F41CA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 14:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67F8610E781;
	Tue,  2 Sep 2025 14:56:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="afQdAw/6";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22B5010E043
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 14:56:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xaz2Ja1aMib7ztM3quvbZZPfROwLuM4w9bcqfsmBS2UkeA/InyLLP7K9kIe7rCEAnfCTS4szfqyWKpa2eldmUHLSboROeaHyGxl6gRtLlGa0ZRIFSDYl7sxhEDq1ET/hxU+kBd2RwndkUuvWiucXdD1XYdWBZEcwtiD2qMpG8AzKFWEBUyVmUMuXudyKz1EHdFZ5YA8QeNl5YXeJSQP7y9DxOuR64RgfX6IGAl9b8jy5b/n7POFIPiRvt3y/pt+haamF8T8mSavJxhWgoMkUrVGmjARnKB0mzB4wviyltvpjYQxx6+1LQEzOXjU5ZKG02aBmyNm7NlyhtF44c1E3PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FnOY8/Sf36v4GlAuVK1T0izAkCx47aVREdedllIIlU=;
 b=g1TN7QS1nXpr+rI5MtsVuTGCZYinnCVDEhu5sUQJP3EODpD4bByHl0ugybXon2NG/k7QdwPLIuSMZo+XYZmqmgL7eI3fRl/uD3cI+J+FZ/Js8wR5JYRO2TYf51mS0AztPeawZKtzbYY7Ny9M2CikFyRVcBCBaK+L90kW39Er9P8IhQraAKT/5T0cIq+/S14LqN4TE9auU+MNiuVDL5LFVNekJ43e9lkxygUZcHFsNMSBk3/wimgRrVFL9FfHzX8GGh9pe4gaMNtQZ1uuI8DcdEbgfDRCGz89teo6YjJGdw/bbO2/WRK3EFeYbJ50cMUzTd0Cd9JTRQS2MugUGnm9PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FnOY8/Sf36v4GlAuVK1T0izAkCx47aVREdedllIIlU=;
 b=afQdAw/6eB/7a4whOq8mXCVYYef0URTBb4PD0x+p7f4lXC7ut0uEQ4K++Y9dQGcYc+tsCKzygLMuaHjyrprhho3f/pYetBElzM3Do6ak6IE/EFaaC76G0fVs476BZU7hOOvouA8BqQEBkun1yyyIFhQb9Qd6Fd7FE/6D6Lj5pUE=
Received: from BLAPR03CA0165.namprd03.prod.outlook.com (2603:10b6:208:32f::9)
 by DS0PR12MB7583.namprd12.prod.outlook.com (2603:10b6:8:13f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 14:55:58 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::cd) by BLAPR03CA0165.outlook.office365.com
 (2603:10b6:208:32f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 14:55:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 14:55:58 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 09:55:57 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Tue, 2 Sep 2025 07:55:55 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v7 3/8] drm/amdgpu/ttm: Add New AMDGPU_PL_MMIO_REMAP Placement
Date: Tue, 2 Sep 2025 20:22:08 +0530
Message-ID: <20250902145213.486199-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902145213.486199-1-srinivasan.shanmugam@amd.com>
References: <20250902145213.486199-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|DS0PR12MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: b327b35f-3586-4746-7cac-08ddea30d35c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TG8wMFBQYU8vZHBkS1JGV0J6TE11L0pFZ0FzN0FPUnhpdFVrUnE3amxEMnZk?=
 =?utf-8?B?VHg3d2IwQkJyNjBBSFo5T29OcmsraWVkTjI3MzJmMzdhZEVtM0l3eFo5TVZh?=
 =?utf-8?B?NHJNMEt5WjF4ZnFrcUdEVzZNTFFkRmNySzRyRnF0amVsUHd1UXZQK0lWTWFL?=
 =?utf-8?B?TVFZUThvcy9UZ0NzTE8weUU2cU9OZ0lqd2JHV1JHTWN0M2g1ajNRT0RiN1Zu?=
 =?utf-8?B?OEdCamR3V3RDTDZUMUdQNkdVU1VUNmh6ckdndis2UkhzcDB6ZjNaWjZUUzR4?=
 =?utf-8?B?RHVCYjRDNlpzN2JlNThVK1pkalpBZXYyOFVyaXlnWjFNRDVGVm5LYVBKNFk0?=
 =?utf-8?B?OGYyMjBVS1RHeE8vdFh1NzdsRnFQcmN2QmY2T0RRVmkxUmVWb3hScWxZQjNk?=
 =?utf-8?B?ejlnaXhyNFh3aFBPdUJDdDlFb05xQlpZTm1PNXdCWmNyMGwxNUNYVkU1RUV2?=
 =?utf-8?B?K3JmN0ZFREhxY3lRdEtIMU1iQUxWV0h1a29laW5ON0xTeStrM1NzZTJpYXRq?=
 =?utf-8?B?RWgzZlgyZ1J5akE2YW8rNHNZN3M2K3c3TEhsQ2xRMWFwdzFiYzlpU0hOMEpV?=
 =?utf-8?B?YUFXbng2bTJ5REtPNGZBUUQxRXJqT2xOZHRDT1R3TGhZekJZRVB2b2Y1VGJN?=
 =?utf-8?B?NUpXSkYwbzQ4dXBybFlTd3JNaTVNNkRwcExYZk9mRjBkSHpZM0U0eDR3eGFo?=
 =?utf-8?B?T0JuMk1uMTYyNGdEcnpPOGtFTkQvOHd6NkVWWTZtQVJGeGwyNWFCT1dYWXUw?=
 =?utf-8?B?R3ZrM3VHNE1jaC9NcFY2cE44eFE4WGFUODVJaVZ2OHhNS1huYzVTVWRQclNu?=
 =?utf-8?B?MlBFR3RFWTdQWUJMTGdaeERQdXd6ZHFOZm9DMVJ6YlNiRGZoTkJkMUJNREQ4?=
 =?utf-8?B?Rks1dTJUbmN4U29ZcWcvdndZTnJ5WUhPdkNJWjkyVlhUUEFVOXQ4ZlgrZ1ZS?=
 =?utf-8?B?NDRnWGNuTmtSN1Vkd0hHRUJRZytwVzJSaE5UeHdOUlRNa0ZGNlBoS2gvM3Ir?=
 =?utf-8?B?aE5TcStBMFRXczF2YUZiajNiRUk1VW1MMnhWa3N3Y1ovVWVHQWpZKy9yL1Ay?=
 =?utf-8?B?cmVVa3RVZHQ2OEtNeEtnL3hrOFM1NnNPZTlTM0MrcEZmNEdrUHVRaFg1Q01D?=
 =?utf-8?B?K3lUME14Zk9aVFFER0dXbUFnK3F1TGpjU1hGR0FHemNmRUF1eGgyQktTT2E2?=
 =?utf-8?B?TVE2V2RqVlJSQm13MklEZmVZeGhmcnlsT0NFSU0zbDhVdFg4TGd2Nmk5ZGkx?=
 =?utf-8?B?UTY1elBsUjZFa3NqWnBmbHg4aWpnN0NFS1RPZDlTbjMxYitiNkx5Z2FVQTRH?=
 =?utf-8?B?cHlhbTd2bmN1WWNLT3k0QVB6OUhQNFFPNXdPNi9KZVZqT3FnTi9TQjRuNXF4?=
 =?utf-8?B?NjQyQ3k2bkhPR3o0aERmNFZvYUc2R00rTVZHT280QTYyenJMK0pkUUVUcVNt?=
 =?utf-8?B?aERkYTNCVHBiTXNtZ0RHQkZFYUVESTh2b1Vvc1BNT0JNMS81WXpjbmtzOU5U?=
 =?utf-8?B?MHF1RUJpS2FIS1hFREV2U0NIVjgyeHJYcWd0MVFLdEhlNHJkV3dRdzhMcTR2?=
 =?utf-8?B?T1dmc1JyZXgwRkFUL2duL0VpVWIyRDF5VXVhZHdldWVVZ2Y1OHB6SUhjRTZF?=
 =?utf-8?B?c2E5anRTKy9WM05xcWpIcy9kcWVsVFo4aExxU0FuMGJjSGRwMlRSMXA4bEgy?=
 =?utf-8?B?UUJmYjJXajNUU05PbG40U004QnZYand1a0NKeTVzS0poTE5KOUJHS3AvNFhP?=
 =?utf-8?B?R0tHcWlxVms5emVMUXFCeGpRRlpOV29UMFV1T0ZUS1k3ZWltY3dNUUpGbVpF?=
 =?utf-8?B?cENsWUp1TTZRWXcrZXBMdi91VllsNjM1SkFzdEdSeUFWQkg2eDd2UHh3dU4w?=
 =?utf-8?B?Tmk0YVVsY2J5MHBBQmdlZTVOekRvQVFmRlluS1htSm80LzNtZjU3S1dKM01O?=
 =?utf-8?B?ZGEwQ1F5S1JPaHhiV0htWVFwY3Jmemt4U21OaXhRb2JYdlJWTlJyMkpHR2N5?=
 =?utf-8?B?THp1cGVOUmkrSUpLdmxkUUdTc1hWajdpNHBybG5Pcm5sa0ZIOW5nOFNGakc5?=
 =?utf-8?Q?HBHUdO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 14:55:58.1435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b327b35f-3586-4746-7cac-08ddea30d35c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7583
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

Introduce a kernel-internal TTM placement type AMDGPU_PL_MMIO_REMAP
for the HDP flush MMIO remap page

Plumbing added:
- amdgpu_res_cursor.{first,next}: treat MMIO_REMAP like DOORBELL
- amdgpu_ttm_io_mem_reserve(): return BAR bus address + offset
  for MMIO_REMAP, mark as uncached I/O
- amdgpu_ttm_io_mem_pfn(): PFN from register BAR
- amdgpu_res_cpu_visible(): visible to CPU
- amdgpu_evict_flags()/amdgpu_bo_move(): non-migratable
- amdgpu_ttm_tt_pde_flags(): map as SYSTEM
- amdgpu_bo_mem_stats_placement(): report AMDGPU_PL_MMIO_REMAP
- amdgpu_fdinfo: print “mmioremap” bucket label

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 2309df3f68a9..bb17987f0447 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -34,7 +34,8 @@
 #define AMDGPU_PL_OA		(TTM_PL_PRIV + 2)
 #define AMDGPU_PL_PREEMPT	(TTM_PL_PRIV + 3)
 #define AMDGPU_PL_DOORBELL	(TTM_PL_PRIV + 4)
-#define __AMDGPU_PL_NUM	(TTM_PL_PRIV + 5)
+#define AMDGPU_PL_MMIO_REMAP	(TTM_PL_PRIV + 5)
+#define __AMDGPU_PL_NUM	(TTM_PL_PRIV + 6)
 
 #define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
 #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2
-- 
2.34.1

