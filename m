Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BDA106F2EB
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 07:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01DE710E998;
	Thu, 26 Mar 2026 07:55:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YxrALh52";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010003.outbound.protection.outlook.com [52.101.61.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11EA410E986
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 07:55:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRYniAnzBbVogE5wdWv2B75QGAA8EtfMCHmBQxBu8p92R4pAFrHShLtiA6rDxXg+lMaDC2lhJGQHYN40AOQvsMFv4IyJxcSLzLjna7/M4gaq5hKgZ7yyKK8uzbrGO/9PowVFJ4yfN3plaIqDCan9zOby0HNfkSsNuhgoDkQlH/bNYkaP7+ntlmQqeisZJp0fLFyKL62IL6/U6IZ1BoNid6JzX6Lfw+IYTr+3zd9yHTBBDn8YJSKuwtuNcJkEKi4U9VZwMCbIdeXzEl9bNEFnahPhjcnvkbZflYnuNP3s26xQqfsiQebDTIOXgRAR7xRKIKHEUkYES+3Y2dce2XkgmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ns5zJnKGQI8tzovrtlluLD8qdqmfrOj91NA3wViAeyo=;
 b=tdlk/qsvjsry27+Dx/zbqghyphMRmLk/qz0N6iYIfUik3PNZniKDNPc374dgpLo3SgmwhlA3pHqRPhflmqRSYTSlwwLUXFMaBDpvkTo/dFvFq/buc+WlfYjSxYjqaj3JwWyPtTWzNrdgaa/zHVGJCL6HuyyKgpRhP6DKRDjjjVKlWg+dNG9iP4UkHhO+WqeZuD/dcn8Yw0o0Ml9I4VPwCcJG98HujfchuR6s3xD6qYHh23/Tm7oOpmf3tkjdDMI+/8clOJdz/mMVfVdmyU5+Gs7KBe5zOc1AcX2TK2EQDTIbG6PjSJW3hK8iD6t9sfTAaKNxcJCkCQD6NwNHeXRwMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ns5zJnKGQI8tzovrtlluLD8qdqmfrOj91NA3wViAeyo=;
 b=YxrALh52gUeeqsx0opZzByEgYir3JNRDNryvi9wRL5473tiGVYGf6B5OrlEopKvFZai4JNY3uX1fJSt6XxAyjhse1k5fnLswbvXL/O0jSfetQwgubO7iEfeXQUDcFG9m+CKDwNQ1PYx6smFP4nUoyiFZ3QqS1Pk4/65AKPve2jw=
Received: from BN1PR12CA0021.namprd12.prod.outlook.com (2603:10b6:408:e1::26)
 by SJ2PR12MB9115.namprd12.prod.outlook.com (2603:10b6:a03:55c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 07:55:07 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:e1:cafe::88) by BN1PR12CA0021.outlook.office365.com
 (2603:10b6:408:e1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 07:54:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 07:55:06 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 02:55:03 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Feifei.Xu@amd.com>
Subject: [PATCH 10/14] drm/amdgpu: Group filling reserve region details
Date: Thu, 26 Mar 2026 13:15:31 +0530
Message-ID: <20260326075412.1378411-11-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260326075412.1378411-1-lijo.lazar@amd.com>
References: <20260326075412.1378411-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|SJ2PR12MB9115:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ba4e0c-96d4-4124-936d-08de8b0cff1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: fjAL4V703HzSiP+qJJXZhkQHdrSw+dnUhNIjKI7EJlyfDc3PvrOy2UXvyCNr2u2M5XTlNvn0fF0N1Vcrc9UAxM4Vmc/uthrGPgdNu3o/KNl887UP6ZjAOFNZYFrGdVCVhjVW/lESqmDwf2h+yZkDqTk8Z/lvsCmyT+oD2PFUj6dyg2DYxyDN2fO9LFgzA0Av1kP3+THvyjfw7PVTZy1EGjJnBW0zF2Y/Jqey1XB+dQVJvf8kvAG7kGUMjhvfkLD/uWMxDyw6PDbQhFl5keOFnkEGrhF14KzSg9PmVfscXml8LdKt8PxFJnczHYXT4/youL0SYOU6I2jsKXxIIRh2ovArz97dhV3Vk4Xc8KsJOpIRlgq5LjoCcxsC4x1uaDin9cBivA9qteFg8+8CvqxQ2Pb+961WGXAQ+oiBaIkiO0CPbZiLl4OqudH5kwzPOmyV3k+4DIC5ad4GgX0FUaB1EYlmywaZqW0qvUIFYYihUY1kQgo55453+qFJ/I0Z3kE4cFDYDY+0l+eG9ZoSx+X75k0OuximmCSyNUCSKSbfAKtFlZCwv7upKvAYLU/ynInhJVFOglB22G7Y8HlMStq4KUjjTUTKKUuZA4HYF6cstKTUZ+MZDgTnQDI8OPGbP1CljITcxv52I41VMEd4FKd4dgVWAJP+ypq4EjVJQdSdtT4Aumsx95R3rWIEG4xZI6BI9PWldYNBKEdv7jSVUryRiPY+mEDqqSrQ4Io6ZlL+NSv99gbQOzzXbpZC8n9s0pC9SNjrox68zFViGbuSiHUERg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 74KPYf6MPDWDG+OZXpJluAVYMaf+yRN057py3aZKjii/udRsCl8PS+6Y5+a0pjgRYRvJUAO9KbTSvFf1H1pbGHy1Ul/OEVjIFWD6L2wNkoETy7OKgy20TESIz5J30ixG8hUnkmwZscVRMtc9JjOS+tdjKZoR1A84xr20tm/YGJoJ7lT67+ekJhJdVQOW7nFSTQjbM0QuibZO9EfQkN1r0G1gzIIBu33ahHvis47wk6UkxX4RoM4fUhMHWnivf3MhZIKl7RdzaZW5+fm7jfk1481UjWn0R4zW5SP3aKKUSOo3qEOI0Ic8LK3VeP0v+E0YJOo9i8yb2th3NJQ+MWolv5W48N8Lsl3BxmWSq62FdbXJ8Xk2qpHHVtDNUqMH2ohoYBQFJ4qeYbYRh6kjgI/iiLz5lwOk7OpPg7fIX/Lllw5/FaHQbBS9W6O6VQiCSmMz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:55:06.8555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ba4e0c-96d4-4124-936d-08de8b0cff1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9115
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

Add a function which groups filling of reserve region information. It
may not cover all as info on some regions are still filled outside like
those from atomfirmware tables.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  5 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 39 +++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  2 --
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |  2 --
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  |  2 --
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   |  2 --
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   |  2 --
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  2 --
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  2 --
 10 files changed, 26 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 2bbed5fe5121..18e459957041 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1032,10 +1032,13 @@ void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
 	}
 }
 
-void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
+void amdgpu_gmc_init_vga_resv_regions(struct amdgpu_device *adev)
 {
 	unsigned size;
 
+	if (adev->gmc.is_app_apu)
+		return;
+
 	/*
 	 * Some ASICs need to reserve a region of video memory to avoid access
 	 * from driver
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index b9fdc3276e81..7c5fffbbce35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -456,7 +456,7 @@ extern void
 amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
 			      bool enable);
 
-void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev);
+void amdgpu_gmc_init_vga_resv_regions(struct amdgpu_device *adev);
 
 void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev);
 uint64_t amdgpu_gmc_vram_mc2pa(struct amdgpu_device *adev, uint64_t mc_addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 3c1b03d3625a..d5bd6f1a307f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1693,6 +1693,16 @@ void amdgpu_ttm_init_vram_resv(struct amdgpu_device *adev,
 	resv->needs_cpu_map = needs_cpu_map;
 }
 
+static void amdgpu_ttm_init_vram_resv_regions(struct amdgpu_device *adev)
+{
+	/* Initialize memory reservations as required for VGA.
+	 * This is used for VGA emulation and pre-OS scanout buffers to
+	 * avoid display artifacts while transitioning between pre-OS
+	 * and driver.
+	 */
+	amdgpu_gmc_init_vga_resv_regions(adev);
+}
+
 int amdgpu_ttm_mark_vram_reserved(struct amdgpu_device *adev,
 				  enum amdgpu_resv_region_id id)
 {
@@ -2093,6 +2103,8 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 				adev->gmc.visible_vram_size);
 #endif
 
+	amdgpu_ttm_init_vram_resv_regions(adev);
+
 	/*
 	 *The reserved vram for firmware must be pinned to the specified
 	 *place on the VRAM, so reserve it early.
@@ -2130,26 +2142,17 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-	/* allocate memory as required for VGA
-	 * This is used for VGA emulation and pre-OS scanout buffers to
-	 * avoid display artifacts while transitioning between pre-OS
-	 * and driver.
-	 */
-	if (!adev->gmc.is_app_apu) {
-		r = amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_STOLEN_VGA);
-		if (r)
-			return r;
+	r = amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_STOLEN_VGA);
+	if (r)
+		return r;
 
-		r = amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_STOLEN_EXTENDED);
-		if (r)
-			return r;
+	r = amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_STOLEN_EXTENDED);
+	if (r)
+		return r;
 
-		r = amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_STOLEN_RESERVED);
-		if (r)
-			return r;
-	} else {
-		DRM_DEBUG_DRIVER("Skipped stolen memory reservation\n");
-	}
+	r = amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_STOLEN_RESERVED);
+	if (r)
+		return r;
 
 	dev_info(adev->dev, " %uM of VRAM memory ready\n",
 		 (unsigned int)(adev->gmc.real_vram_size / (1024 * 1024)));
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 2568eeaae945..039d52799357 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -860,8 +860,6 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_gmc_get_vbios_allocations(adev);
-
 	/* Memory manager */
 	r = amdgpu_bo_init(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 6349e239a367..fcf48e19d857 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -834,8 +834,6 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_gmc_get_vbios_allocations(adev);
-
 	/* Memory manager */
 	r = amdgpu_bo_init(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index f1079bd8cf00..577b3c68fb6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -924,8 +924,6 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_gmc_get_vbios_allocations(adev);
-
 #ifdef HAVE_ACPI_DEV_GET_FIRST_MATCH_DEV
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0)) {
 		r = amdgpu_gmc_init_mem_ranges(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 886bf77309a5..cc272a96fcef 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -854,8 +854,6 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_gmc_get_vbios_allocations(adev);
-
 	r = amdgpu_bo_init(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index b2e87d3aa203..fb5e33c8a5ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1034,8 +1034,6 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_gmc_get_vbios_allocations(adev);
-
 	/* Memory manager */
 	r = amdgpu_bo_init(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 1d5bd90ac57f..963d5b0fa87b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1149,8 +1149,6 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_gmc_get_vbios_allocations(adev);
-
 	/* Memory manager */
 	r = amdgpu_bo_init(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 1ca0202cfdea..e64a25f7d713 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2004,8 +2004,6 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_gmc_get_vbios_allocations(adev);
-
 	if (amdgpu_is_multi_aid(adev)) {
 		r = amdgpu_gmc_init_mem_ranges(adev);
 		if (r)
-- 
2.49.0

