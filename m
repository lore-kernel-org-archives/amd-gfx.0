Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D842ACCD185
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 18:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B71C10E2A2;
	Fri, 10 Oct 2025 18:49:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FYfvOWR9";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 794D510E2A2
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 18:49:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEizm3MVmsg9RdTjlw+7OrGHJvu5IyRa7EK7+esOhjLs5L21QrkRGV3nxe/zUF/ANBPdDJidtJ6s6KtphupV1uAcfHK7Fz5uO/n6RPEHwZmwqEst6GcIUomrd9+D0AX/hY7t3odE2dR9yEhuChGqDxc+aSgdCFsCcRpv+i5dHpk+sSNBdGF0Sewb/zosIezOu1e/RjgWAM7l/YWzmx9eA32vCQkf34AawfTxw79ej7vxK//k5lSBM4Rhgk/5giAXSRwGwaQL8rNOuHcrMDoEJpHu3XZV/pCXDf/zOqD80huav7IHLqAFUvl8tsC4Knf87EwXoFUGZF3eXwnxze8evA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jqn6yb6/7PLpjhbDBYniO+ZWyakEfOyEUhxx1ULeIdw=;
 b=fKunJnN/jy58WU2oe/1+aaI/hxZO/ZPvpSmL1lcX70tUtSfI+VTIWPZsG1KFQDMZCfeKob6hMps/sP7g/3dagZsRS2NQ/eOsaspsgz6wMT8Lt9e1uYTPZghppuzQFoEAjApni3sg8Kf9kL62TBL2NxXELILCoQfCMuVfsgXdUMuVd0tUz8CurLjbXjzH8JQdLN4qyITHJmOFYFHa8PWabo8a6OsWLHXS/D9dkEHWnj2X6qD+z0O3LVGU/WJtabMHjer1J1jKSeoSNGzSi8yVcxYCS3r38mpqPJL3Aqw8RAm0D+KA5/tf8f413p4E7mbSXBMSaAH6Clm7cYQnxT+j8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jqn6yb6/7PLpjhbDBYniO+ZWyakEfOyEUhxx1ULeIdw=;
 b=FYfvOWR9rF8guO10BbCtG9L5XJpHVLA0vzfbgR/WZdmQlMkog24WR00EXbV4h9+M7J+HWa2rfiSbhkxFZ2JEmkVHyxBzGnJd957nLZiUa1xQ6W+b3JhuSytz9DkDCw/R09TBerxwvav6ZJFClUKBoivV34e5Ce2iqNvUUNJl6oI=
Received: from CH0PR04CA0077.namprd04.prod.outlook.com (2603:10b6:610:74::22)
 by IA1PR12MB6356.namprd12.prod.outlook.com (2603:10b6:208:3e0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 18:49:01 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::ed) by CH0PR04CA0077.outlook.office365.com
 (2603:10b6:610:74::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 18:49:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 18:49:00 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 10 Oct 2025 11:48:59 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Jeffrey.Chan@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH v3 1/6] drm/amdgpu: Updated naming of SRIOV critical region
 offsets/sizes with _V1 suffix
Date: Fri, 10 Oct 2025 13:48:44 -0500
Message-ID: <20251010184849.9701-1-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|IA1PR12MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: 4008bc53-0425-46f9-3dea-08de082dad1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Bph3SG80FN/svacWBZnc61oHHaLEFBjoXItb+b87CeYlnIAS6tp9FuXBscKk?=
 =?us-ascii?Q?SKNt/4i5D5LT1VelIiARsQ6erHpVumJtingXlLw+iDPFaD44cE6FXUsT16/8?=
 =?us-ascii?Q?jSlCbRjEsP0o0H40BI2sjVPvfloJdQ9+qcwK6B85fHvSKZdR3LjCZuwCdsKi?=
 =?us-ascii?Q?wiXMutiFC7Vqi57topHexwD5mYQApSsCq5/A/Cil9tuRHNcJ3Ndmqt9rp4ey?=
 =?us-ascii?Q?YkuJ4t3KyuuC0BBUQAUNA+YQfhIYBDPKoDXpcgn2Y4N9RJ7YIOPMjYPTKCk1?=
 =?us-ascii?Q?3/qQE+g4sKdhP3LJYrB1tyr+WX5kjkU4hhjJKLuLT68KH4MwjcL86ioZPQXc?=
 =?us-ascii?Q?xYmb6jApa6F7EbXjDJNryV/ibr5oeCSf1lmsXcKv5tzXXoETXZGmLdtsnDA/?=
 =?us-ascii?Q?ZQ/qnrvFrog4m/Sv9uP0D1BteFtvm3TBbqSMuOGV4uiiecEJdeaZ9aX8O4Mm?=
 =?us-ascii?Q?rI/aXcTBDN4Wi8GPQBTVPOqqD+MefmrjwtgLWkqMl3YxwmcJhCSHKiHUOwz1?=
 =?us-ascii?Q?Q7LaFAiQFo+AGospJGeWrh3rhMRgFq269SYnjBcqXIDVx/1C41qLSouobqNF?=
 =?us-ascii?Q?geJ5XBbNNP6xLpM6TWQxjt7X+l2FpMEbbxg4o4efA+12kLR5Vy+XsReR/oNE?=
 =?us-ascii?Q?nmxrMJ0nyWS1OQA5CQH4sCkhTkhht5G1yinPLC305n7FJEzzqaAfVjadZuo1?=
 =?us-ascii?Q?ayjl8+ToTjW3TV6M2EuzI1fTRSNl5H4nUR4bnHA+lmVp9DFF665IYeJ/SHlC?=
 =?us-ascii?Q?a402Q4opEzoodj8aU/WX0TgBB3FWvwe7ymhk/UXBpWziy0dAGHABsbJIha6D?=
 =?us-ascii?Q?hAkFTI1lo4H7cL4oT9RVee7uGgCsmTBvP04YaujXEk2pLRvQjGCh74akvFJd?=
 =?us-ascii?Q?55xbbapIw9qBod4tpcKBLR1MuA1GX4b64tAVgiSL5oj5/9afk9EE7Cfwpzha?=
 =?us-ascii?Q?ey1/dhCSNIAjl+MUOZbZp9VOHueVAcGYiAzYCUnEJ4KxUJCO+smPP0it/4w/?=
 =?us-ascii?Q?ZrnJ09FcMvhLE9fmNqidiSbrUAStxvPeqDBClospjHDiJ29/UndRDV7b8pcq?=
 =?us-ascii?Q?SxtcHGVRvacfO/a09YfFtDAKLc3OKnKrKrTRquyBiLgrfn4Smk4fNi4jBobI?=
 =?us-ascii?Q?KV5H8231654eYU4xIXJMfHgsa2XwxlHGvogjB1WWPopYAXs7rMOCR8FZr2eJ?=
 =?us-ascii?Q?QrckeTZPgm+JNwiQPAwwks6OldlZ91njR79SgkjLm4T59zixAnVGNLDQrxfV?=
 =?us-ascii?Q?1RnouMImZGuzSVm81fN+g/utBYjT3paffuJn8hqIlCJorlhNjBHEVKeOPHzj?=
 =?us-ascii?Q?ex0L3VBrheE2bBHVdAcBl+eU2oENIZ2MgPOugDdMDZ0JrL73/fiBonHfarHi?=
 =?us-ascii?Q?yCeubMLnhF3Nk41rNc0fBdzgf39HxHsOphgyHIZ9+5FQWsIWxLZAvXqyGeSf?=
 =?us-ascii?Q?MeOKFVdz/gv7l+dzNWx7KP93NL+SE34qcPo+WVxRVy1zbPDkoXgrdbPMD9AM?=
 =?us-ascii?Q?2c4vko4sTNoWAppzjUMy+hPjUkoayO53m2DrBf5l4cPiq7zwN2PTPQmsOrz3?=
 =?us-ascii?Q?1B8BxUD/j+oQQDAP0EU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 18:49:00.3708 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4008bc53-0425-46f9-3dea-08de082dad1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6356
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

