Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41184CCD18E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 18:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B683710EC7A;
	Fri, 10 Oct 2025 18:49:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FHSPk6gt";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012043.outbound.protection.outlook.com
 [40.107.200.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DB8710EC7B
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 18:49:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhRakq+G4jXt4GKfTPXLm+ndmepzY4NudCm+LCmJxprWydgbObl0Z/x4W8wD5WO2SLLV6W/jBra156Dq+iuGQWH7VoHT70Ehb/ZALFzRWKQ0FfyzGuhLxysFoI5qKI1I9SQxYHsSpHinevnfyfACR8QR/4L3pFp+et/EzCOtbe0bl3Poc9IIg0T+glKfCYlKBfcW9Xn5mtn/tbXFISayfOxs90DOoEY21SROp2wAQqiUsww8144n4kY21vZMvVLTuERV4qX8TkhC1pLcpNNpGsUzh69DfL4sPCCDqDnN6rtbTwSWK5UKKa6cstA4OEOBqngr6errnIHRu6NRx52cQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/MIt9adFAZS+sqd54UWoItO6Bhif+KW2xEKQ2EvM3s=;
 b=lZOPefKCNZs+fILvmrhPUeW1RiNpfDa7JKwlh5hkXKdstwlJuNhtRXOi9TssukpT/advb44Aq7nlZbFmf5AB41clbBPYcwW8xPxay0qJEUKQZEU2q1VtZggSDTcnGeET2oQctWgVWL8xfLAXOwVwvYYmhFjFTGF7UJ77z6NyhNM+wmEjvFtny1DH/euDb+vxoo4vNDB06Vnqg7P8OYB91/dYzUJRfUoL99oqMXLes5r5J0LyPa88vtrJ9nASy+Q1Hb/iOiaDUgxEwRGGo/OGPLDMjjesvyWRyjZhAIN6FQ0HIatZeXJh20ERW7pPKVT3GShXmWzxWfgPzauzg7Gc/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/MIt9adFAZS+sqd54UWoItO6Bhif+KW2xEKQ2EvM3s=;
 b=FHSPk6gtADq5CfPQTLiv/IWoJ6x3s5ipOR2OEpfne+1OCbbeXVoUkpgXfhtiKNKq3oUPsXbVG+jaAnVKiR5nSG1oAyPWd+EbtV+nfa1KN35vwRdWajtAlweMPME5h7Twh0gC8Yrqq9aSoRMWBVyAf6cn2i3bTO54hGB7C+EsFgU=
Received: from CH0PR04CA0077.namprd04.prod.outlook.com (2603:10b6:610:74::22)
 by IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 18:49:06 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::ef) by CH0PR04CA0077.outlook.office365.com
 (2603:10b6:610:74::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 18:49:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 18:49:06 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 10 Oct 2025 11:49:03 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Jeffrey.Chan@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH v3 4/6] drm/amdgpu: Reuse fw_vram_usage_* for dynamic critical
 region in SRIOV
Date: Fri, 10 Oct 2025 13:48:47 -0500
Message-ID: <20251010184849.9701-4-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010184849.9701-1-yunru.pan@amd.com>
References: <20251010184849.9701-1-yunru.pan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|IA1PR12MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: da243dd6-5644-463c-fe43-08de082db089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u2LummjSjPGKTD/GatPub/QJDt3Rt1MGyg+dQa4MtzoSzoo9W1ds7AyNOhxz?=
 =?us-ascii?Q?9eRazJNK/JsTACv1HADWoFlVpeC5I1i/8UxM5FHcIjnYWRB8jmeYLBd19y/Y?=
 =?us-ascii?Q?f3CKwPxlRVclp/UxubWdTEfg62saboNGhBrIUVj7QxqtXYeAvBfUMyPF3f3x?=
 =?us-ascii?Q?8yJ8iqnmNiMh+XoBgZctg36F29CXmgkxW7Htdj0TS1xH4itdYQwNU+QJHdEi?=
 =?us-ascii?Q?0DsZTJFAXw1+bUmQ7w6zgTWQXtXNuJawJrrD3mqG2Ye3mx5dzrra5XNd4vOz?=
 =?us-ascii?Q?QQ8bpNjYX/mRJvGZ1saBQpRacQXO5t2fTQXTUmkZwwDOgQ/xcmTQTDwwy6mQ?=
 =?us-ascii?Q?P8EURGt1PNIJ0EYNFEnmZphTvH4FznUL8z2jPkl8OVXzfqW9m6GvLK/PATlj?=
 =?us-ascii?Q?Pb7FPrZFQwaPj+2bfHrvWZoVnq2rGr4AqwemNvWi8ogQbHTH1spoPzbvp7vM?=
 =?us-ascii?Q?0DYNazvvFf4R83OkN9BXHg1eNwgd6JmEoxDKfw6pRDRE8YT54Tdz68Q/yAPn?=
 =?us-ascii?Q?TWw1RqoSTF7KkEJ4ueTftL3EyLEaGX5fYY2b6A0FUnVVAvI7Gqqtr1sr+sfW?=
 =?us-ascii?Q?HvVX7hTN91vj1dFZc5te/JFvnKayu5gcWhMiAM9MEIOesPKBLSi+kwisvWlm?=
 =?us-ascii?Q?XZCEQ1G4f+oNigIbyjiYMwtOjt2sNZnm3lrunO2A0J79nK5NGKy0eQ+8gMxX?=
 =?us-ascii?Q?be3Mv5A7rQodgwFnZu0lb94JXM+FZqwznEUwdcPNStCEyn554N+JpWUlDVCa?=
 =?us-ascii?Q?uFFo6HwtQBtXimuXXq3ybx9F8VlvnzYUF56QXWoC5H46g7WST9NgBonz4fWM?=
 =?us-ascii?Q?4urw4tdxn1BtPZ3qB84IcNPDsLuSbQE0KjTzUROBBpV4QQaWh+N/ugRsLp8r?=
 =?us-ascii?Q?VmkSY2XtZioYoIEaeiSGRu85enXySzxzSnFkfdbaqT+pTdTCel+3Cdd3EUcb?=
 =?us-ascii?Q?dzTOBYFjC/3wnWnHftJo5I8nfp/nWWcOZSzPJ6eczcFJyptNN3C87TNief7v?=
 =?us-ascii?Q?M65kl8C9KVx83bY8AKd0MwW4ypmhD+3XAEA4PQ8rzoeUo08iBfKxyiYklzVI?=
 =?us-ascii?Q?nraYwDkVBRdyi7G9i9cPC1mfi8Cp5EzNTFdKqjLDrtKIRRlixn0qJM+iaYOX?=
 =?us-ascii?Q?phfw6vssIQTM0F6C5sS3jD66GsrTfdjTtz9Cp6RkWNQmesODLrkEuSiJQx9l?=
 =?us-ascii?Q?rzj4LwTi+hDL8hGIgUWGFflOd7yzn9f8LcSYU6Wo8+c2CobvAJhltkYoa/2k?=
 =?us-ascii?Q?WT9mGrLO8ziQHyGddo9Wfxth2H2opUScqoO+Ndh0lN9cTHfi/oYiVM0NYoBD?=
 =?us-ascii?Q?L86x+XSYo7mo3nlUZuOzKFgK483Ol+XNBc6MyKsxL8oXQZ1Z/gPqjYwPkSka?=
 =?us-ascii?Q?+UsMhmMg9fv1tZcp4Y/htm0vK51HL3tgR2euCkCqcp0XTHdPoeSs9glmvDFb?=
 =?us-ascii?Q?Zv1QjW3nTC3T/LWb76QyrxFJyprUEH+lr2M1m20m/sBpR0dx2y9nCCBmzvpP?=
 =?us-ascii?Q?E7cV8mq2wkc9ogf86upi2cLnB1nDtsLZTJQNr64dfWZ12onprhNSyVp4w7/r?=
 =?us-ascii?Q?pgBPXr+BbfYv49hZgoM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 18:49:06.1010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da243dd6-5644-463c-fe43-08de082db089
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8517
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
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 29 ++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 12 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  9 ++++++
 3 files changed, 31 insertions(+), 19 deletions(-)

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
index 96bd0185f936..b5148a33b6f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1944,19 +1944,19 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 
 	/*
-	 *The reserved vram for driver must be pinned to the specified
-	 *place on the VRAM, so reserve it early.
+	 * The reserved VRAM for the driver must be pinned to a specific
+	 * location in VRAM, so reserve it early.
 	 */
 	r = amdgpu_ttm_drv_reserve_vram_init(adev);
 	if (r)
 		return r;
 
 	/*
-	 * only NAVI10 and onwards ASIC support for IP discovery.
-	 * If IP discovery enabled, a block of memory should be
-	 * reserved for IP discovey.
+	 * only NAVI10 and later ASICs support IP discovery.
+	 * If IP discovery is enabled, a block of memory should be
+	 * reserved for it.
 	 */
-	if (adev->mman.discovery_bin) {
+	if (adev->mman.discovery_bin && !adev->virt.is_dynamic_crit_regn_enabled) {
 		r = amdgpu_ttm_reserve_tmr(adev);
 		if (r)
 			return r;
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

