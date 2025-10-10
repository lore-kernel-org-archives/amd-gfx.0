Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD2FCCA476
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 04:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BBA810E266;
	Fri, 10 Oct 2025 04:43:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MxNQCHq2";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011038.outbound.protection.outlook.com
 [40.93.194.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ADE210E266
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 04:43:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDEvsjaHaPPObVGb/I+gd4rMQTD1fo/HMhWIdPw8W/84NtuElvHFtyB8NKoqcsuk0twX+LlUj8FTd3uKUU1CIIgNnAHbUbXfqI3KFq2SdG8/XZfGEDnb1Azsij3jF9//2gV5iMGX2nOXHVEFbi+BoNmSVCNowgBNPY3ygWLtoGecn0OiqXPviqlO4g4Wm/HMW7MWVP5Ck/ZFbYzp+SNUtkbAIZYZV/rOiuwUifLltLvnd4rVu0ZSJQY7EcoO1Yz11B5D9ZHOLA9JXcpTAKrcsCV+GvQUYkUV0xNLTJsdA8UPJO7W/JipPaHhRHw1uVrKT4FNzR4Uha8L002jRtDS2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chiU8OTHY39k2NutBXzoorZytL/anleE85LDpcUPrCI=;
 b=ngH3CrULXQnl8A/Xu5quYTSAtpgMmD6H3D5Hcmhz4bbFEK8heV6uv3Uok5CpbgVWZwr1olvs/8EiNC3cASMCd0EjHy1lOsqW5I0Q3apaZMMjJh3ja0T+v9jhqdaOzIVp5tD5MJoNYYwJgVCXX997xnVEdV74RaP8S7xo4/GQS1Y1R6eUMsxW2hIt/ggwJ2UXOA0agow91p3SR4CiPtDFZGBP0S9e0hHTqb/8ym21FtVK+MRMX1Oxat1NI2r4iNyeXxLahaZfvd+CxUtUR47AHRHz4bYZargUJqytl1Jg5/KGqzM/6LCUpbg05G7VpXBiqxL7mf3N0gzJYI71CXIKFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chiU8OTHY39k2NutBXzoorZytL/anleE85LDpcUPrCI=;
 b=MxNQCHq2/IxLQfHLp5rd33DzdTo4eYdcqB5jt5DdRvYjh/zwD1DtgfBzMNPyCnjDZXG4Lkcyinc4DMsOMZhI2Zxk0elhrUSHKbK3hH0bgCPhLuLK8bBqMx5aOSAEE+oDdQWnAgmiQ6v2LwEZ6uPEAL5Gu91k9tDlPCa75DMc4bI=
Received: from MN2PR15CA0015.namprd15.prod.outlook.com (2603:10b6:208:1b4::28)
 by CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 04:43:28 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:1b4:cafe::45) by MN2PR15CA0015.outlook.office365.com
 (2603:10b6:208:1b4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Fri,
 10 Oct 2025 04:43:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 04:43:28 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Oct 2025 21:43:27 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Jeffrey.Chan@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH 4/6] drm/amdgpu: Reuse fw_vram_usage_* for dynamic critical
 region in SRIOV
Date: Thu, 9 Oct 2025 23:43:07 -0500
Message-ID: <20251010044309.11822-4-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010044309.11822-1-yunru.pan@amd.com>
References: <20251010044309.11822-1-yunru.pan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|CY8PR12MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f50d487-cd5b-46c9-2de0-08de07b78e5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1apaam+T2e4gibY5mAePCWn0+194eNoEtP/fznrhbjkPL8IUWggyFF3Mkulq?=
 =?us-ascii?Q?ajttTzaFn1VBa7PiUJs9R1576pkXPYl+bwBdh/DH6IYrf9cIkkoEihCQDf0A?=
 =?us-ascii?Q?M0K0enUEKXN3vNspnNfzXpXZL+ZIolWa6KKAC0XrR3kRb0pSCl5z9M2VkJrX?=
 =?us-ascii?Q?nlGRBmDjrZ7CcGuocNAFcsP6qb6gaDyZDMe4lTQuirOzvrfhYLhCU4W3IaGh?=
 =?us-ascii?Q?eDSEvSveJom7/UTIGKMJsFmR4QOW8McDYEmwEkZvfnt45bX6fXnO9vcdLjcn?=
 =?us-ascii?Q?AbEt9d4RK+cBT7+I6EcUnSZsDDGYos+mXCeACtBFJG9GFckkvRZHo6xnGya+?=
 =?us-ascii?Q?hkSn8Ux+78coYxLLN1OYSENvpcxXGkgJ5TKdGfVG58qHVnxRlyhYmNiILU7V?=
 =?us-ascii?Q?QmuN9/8jSZybvaMDR6JZ3LPyR/Io36slqE6kMhwFp7LogBqCNUIu1RF72d9I?=
 =?us-ascii?Q?AnvXWbaYd1H1R4v219dm8gSsn2JgHq5I0FKXKU2HJ1JH3jztKYj3Zg9CGdMH?=
 =?us-ascii?Q?WphjfYWKE8q8ARoZiZx70M6VmsHZ74nN1Uvl3U6eO+rJ4P8Dk8yrZz9FNxi4?=
 =?us-ascii?Q?t+1lHl1vAY9iNuEc7qtknz5bR91NZfmqgeR47u7U/phAEpO5hQfaexBw0TTp?=
 =?us-ascii?Q?GrFzfksjftwI5I3AX6ndlzMhzvX833oKnLkdFhMeMdQ2PfeV6vHHlC57LTDm?=
 =?us-ascii?Q?FRhToH7CnWhCR+hnElNo/svEqpnb/88FSJZO8hDenuK4B0l4pkEcsX9WMXeh?=
 =?us-ascii?Q?uSB49cj+NKokZDNbxhRAineuOxf8qPXpfe9NhKR8aPhhbZOcOwStqvrPdER6?=
 =?us-ascii?Q?Doyf83yhMP/4cd9QXXm66oxB0k3SfnXRIDYaflEnWk5eMpaZrJrk5oYJIUcu?=
 =?us-ascii?Q?UjELvlOlT/QmVJwGFz+JRi4D1vlVpoBvg7TsMcifxDcaC40cMV/1JRCRxId/?=
 =?us-ascii?Q?oVOAdHZXdDXt5pa2nvqoDuSoeBpMA1n06361adk/rCSmLjXre5qqyjnEBXns?=
 =?us-ascii?Q?46m637+/4ffUb6TAFHzN6stiFIGsEYpzi+QmQqmymQrgHK9t/XnJ2/uNwIjA?=
 =?us-ascii?Q?gLyIRSONcDMPp8AYn1NeJUiZnv/VwgHOztXPEmkUW7qlq8zWznIxxdieUb+f?=
 =?us-ascii?Q?YXFCw62d2RSVugpt/zq9rhXin/YubbcgCTNR2gfVJ/CUZRGf8nUXn2U19Y7R?=
 =?us-ascii?Q?lTGcoPvImqIrt4rd4ZRHPgDUYDIZMtwNygYfwmleCbAepiJdPQdauh44dP81?=
 =?us-ascii?Q?r+SBiInvN4Lu202prYpfWNsAeY0fZJvYHvMv6xMpDSocWgTp1kaURFNHDCFU?=
 =?us-ascii?Q?WLQdTpqV4dnF1BdnosJyzrmzVvTftZwjzUpdXWgFEt6bF6zchKpe4ekwHp39?=
 =?us-ascii?Q?+rqlLV2b+SmwMc+tEDHVPhrMsFH4017E044eZj5/7JcMmt7VYh/WoS1GT2be?=
 =?us-ascii?Q?juKF3C6oxqWXtveaBveSJAlH3YYMkhZmfxsVsA9XhJanf2xpi00FLNq8InLB?=
 =?us-ascii?Q?WHC6JrgJKafqN3/325jUoiqnJ2sgxbN/tjedWGHQgQZwaTLWuJTVkmy9Hy/p?=
 =?us-ascii?Q?bFca3Z/WyUECpHJf1ok=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 04:43:28.1487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f50d487-cd5b-46c9-2de0-08de07b78e5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7491
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

- During guest driver init, asa VFs receive PF msg to
	init dynamic critical region(v2), VFs reuse fw_vram_usage_*
	 from ttm to store critical region tables in a 5MB chunk.

Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 29 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 33 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  9 +++++
 3 files changed, 44 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index c7d32fb216e4..636385c80f64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -181,19 +181,22 @@ int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev)
 	u8 frev, crev;
 	int usage_bytes = 0;
 
-	if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev, &data_offset)) {
-		if (frev == 2 && crev == 1) {
-			fw_usage_v2_1 =
-				(struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
-			amdgpu_atomfirmware_allocate_fb_v2_1(adev,
-					fw_usage_v2_1,
-					&usage_bytes);
-		} else if (frev >= 2 && crev >= 2) {
-			fw_usage_v2_2 =
-				(struct vram_usagebyfirmware_v2_2 *)(ctx->bios + data_offset);
-			amdgpu_atomfirmware_allocate_fb_v2_2(adev,
-					fw_usage_v2_2,
-					&usage_bytes);
+	/* Skip atomfirmware allocation for SRIOV VFs when dynamic crit regn is enabled */
+	if (!(amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabled)) {
+		if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev, &data_offset)) {
+			if (frev == 2 && crev == 1) {
+				fw_usage_v2_1 =
+					(struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
+				amdgpu_atomfirmware_allocate_fb_v2_1(adev,
+						fw_usage_v2_1,
+						&usage_bytes);
+			} else if (frev >= 2 && crev >= 2) {
+				fw_usage_v2_2 =
+					(struct vram_usagebyfirmware_v2_2 *)(ctx->bios + data_offset);
+				amdgpu_atomfirmware_allocate_fb_v2_2(adev,
+						fw_usage_v2_2,
+						&usage_bytes);
+			}
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 96bd0185f936..c0810c53703c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1943,23 +1943,28 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	/*
-	 *The reserved vram for driver must be pinned to the specified
-	 *place on the VRAM, so reserve it early.
-	 */
-	r = amdgpu_ttm_drv_reserve_vram_init(adev);
-	if (r)
-		return r;
-
-	/*
-	 * only NAVI10 and onwards ASIC support for IP discovery.
-	 * If IP discovery enabled, a block of memory should be
-	 * reserved for IP discovey.
+	/* For VFs with dynamic critical regions (v2), fw_reserve_vram is already
+	 * reserved, so no additional memory reservation is required below.
 	 */
-	if (adev->mman.discovery_bin) {
-		r = amdgpu_ttm_reserve_tmr(adev);
+	if (!amdgpu_sriov_vf(adev) || (adev->virt.req_init_data_ver != GPU_CRIT_REGION_V2)) {
+		/*
+		 * The reserved VRAM for the driver must be pinned to a specific
+		 * location in VRAM, so reserve it early.
+		 */
+		r = amdgpu_ttm_drv_reserve_vram_init(adev);
 		if (r)
 			return r;
+
+		/*
+		 * only NAVI10 and later ASICs support IP discovery.
+		 * If IP discovery is enabled, a block of memory should be
+		 * reserved for it.
+		 */
+		if (adev->mman.discovery_bin) {
+			r = amdgpu_ttm_reserve_tmr(adev);
+			if (r)
+				return r;
+		}
 	}
 
 	/* allocate memory as required for VGA
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 6eca5e8a7375..461e83728594 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -940,6 +940,15 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].size_kb =
 			init_data_hdr->bad_page_size_in_kb;
 
+		/* reserved memory starts from crit region base offset with the size of 5MB */
+		adev->mman.fw_vram_usage_start_offset = adev->virt.crit_regn.offset;
+		adev->mman.fw_vram_usage_size = adev->virt.crit_regn.size_kb << 10;
+		dev_info(adev->dev,
+			"critical region v%d requested to reserve memory start at %08x with %d KB.\n",
+			  init_data_hdr->version,
+			  adev->mman.fw_vram_usage_start_offset,
+			  adev->mman.fw_vram_usage_size >> 10);
+
 		adev->virt.is_dynamic_crit_regn_enabled = true;
 		break;
 	default:
-- 
2.34.1

