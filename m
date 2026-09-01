Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F056C61DD6
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:11:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 978E610EEFC;
	Tue,  1 Sep 2026 20:11:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OxlXuyE+";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010054.outbound.protection.outlook.com [52.101.85.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2140410EEF6
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:11:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6C7Gr4jpq0a1ly8V8E0c+NV8VCTXtbQ23b2eggX+tbInvxCkYjxgx5KYaJ977aNTpbyD3S++lBxghlX1ZYYwKNMHHYLgEttZLK7oEPpt48HJe+7PMjBYB0/DHx94//Km999mJN81o9FJljmaVthUxzwW4KhJS+6oCbM8X6xiXVeJx7Z8AeyVJ6IQ28Z2PB+zJ3Wc8i+awP/h3ItaRlx8E8BDb7S/VvFSJT6spso0tBJtEVw2Osk6UEwrxc4hJ/oRDjWccira8/46xoIN4GfcnOgQz+zou1ILbDhI3jW6hihtcLVBOdPyfGAaBSVRwl1lowmQPqNuNa5F2FD4oaTFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UO36y9d6us+fDXn/O6ICl7kFN1eXO/VSldKKBwnSHlI=;
 b=frxb9poBo+dXweb2S6pavS66i0qxTTonAMpfcUwM0kpCWaoOCscqo87u1/tPHNP4FLn0AEt681Z2TsorYEwhvuj+4sAgxBqslXs7Op3vxdm9xHQJNsg3F/kROp6z2USJsA6AGuGeWIjyg4vlUxxmJ8sRs3xakR3X+NgopkU7OmMC4yhRgPNkRluzD/DrmUbCwSwLZB7BnUTSmsVxHtOSNTZ0Z9Z+Pf8ivSl1zHW7HSF45XlRI2URaOvK1mw69rWg2rbg9pN489FYgO7jPhPaO3GaCfVIkqV19wTLC1J3+6qKOa9v5gXuZyRFVfuok1he1euRawxt11HL1rycin4rCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UO36y9d6us+fDXn/O6ICl7kFN1eXO/VSldKKBwnSHlI=;
 b=OxlXuyE+ZsAffAr3dmPckWZxwGWPKw6DkB6Q0JSg+oPZVT61oiJFKK39oQqJDsX2tD7/aPdphbHYtyUog7f7w+Q+Fc7xbITrVcVG/JmDoeou8ciM43VqBUN15IM+KmlnvwjRAtStaLP6asWLD+iZAGZjCEPMLjIJl1DWL7WbL7Y=
Received: from PH7PR02CA0008.namprd02.prod.outlook.com (2603:10b6:510:33d::27)
 by IA1PR12MB6385.namprd12.prod.outlook.com (2603:10b6:208:38b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:10:52 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:33d:cafe::a8) by PH7PR02CA0008.outlook.office365.com
 (2603:10b6:510:33d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:10:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:10:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:50 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:10:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/31] drm/amdgpu/gmc9: set vmhub funcs for gfxhub and mmhub
Date: Tue, 1 Sep 2026 16:10:08 -0400
Message-ID: <20260901201034.2960437-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|IA1PR12MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ceb01f8-f97a-4e12-473d-08df08651ef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|10067099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 4hZ8ARzxXkoOHnYIc4Olalw1M7ncN3qRmnmSBEjQgXXI25rdd4rTXeoTl24h72bGmO3HWm2hbbP1l5QxMBTHEAYSX++MSs14cnHystBQLTRiRrS1IZ4R7Ch34xaTvtQIRhNw3Vuoo9Sge6sI5bRWiGHyxwhMCy7aghMq1F1rG/wdGSQxrKRHFLAhs7Kif9Od+aTbrWT5qV/N8onU5DXFxDQCG1H3GDvsKiGIJTnEtbgZ1wYma36KGd53zESC+g0LlNAAyli+OmXgxJ4NE4Wmpm6raobmmmyzECzmXdpj8770dma11JDiYyR+AamfiLoZsPFiJ7XIoeKlLj7gTKY1T2delX+4u6t01IXS3agR6AaU+slPU50qF75OBTtweeoJSLuvXzt0ox3WTllRhme7xr0QlsSH5BDN7I3rVo74PBxi8PyUW1w4yZUudRRyfvg5OzZh6mUah60B8yscQZcKUghg/8Q932+bGKPPdDHSH374GlhBRILQ809gryO8184TRAvWwPUuCsPF38L68J25eU7tO3BBPwr7WRfCmAy9F4gWUjNPt7CR68Pf6XJmalfXauLoD9jl7PkDT8kG5b31aLQsOOS5FkRnF/HgkZ7sCTq3kd2vCw108Z4KnCYzdlEtPGdy11eD2qNFvId0aalC1HY9sUBF5StXn41NF5bG/cSYL2jwV1LsvpPy/8+H0miIRjzMbt72PgSzWbn+boewxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3w509QP09n3+a8wK2x7BQGNvt+RGkRoCqM/WlzLEE5TudBiUNMoHjCifY+60UWXjaZCMglcjVoOkcuD0+eO45SS1VJwB3xivb+hmQi/YIX2a89D+oCL/H6tES0sVIJLuU/S9VS6C6k974Lz9Yl/plbZwAbd6pt/Ppe4l9W6shw3yUhAryDyFm5cMoZq+xKnmCshkRha+qESX98FpQKOWQnzwLXdpnR0c4daViFlNe6wEEL2l9mzIXzeEbsNa3hFuFb6ATLtXPLxPnQShRg2VYT6HLvNY00s+W7kA/dMoYvDBFWv4yVHwnNGstTWOOWNLU18lrXbEqLBVaUIsDeHY3vm+k2jHMDl0a7DAAD3ohl8VfmBeCrLnbLhdWHVRwJronzJ44nPsx2vwMKCcH23p/K8XCIR24e1464cheNl0XRI/Vsl5HDzBqUAs54dzSSTl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:10:51.3000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ceb01f8-f97a-4e12-473d-08df08651ef3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6385
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

This was handled in gmc_v9_0 directly.  Set the pointers
so that we can use rely on the callbacks in the generic gmc
helpers.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 33 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 33 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 21 +--------------
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c  | 33 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c  | 32 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  | 32 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c  | 32 +++++++++++++++++++++++
 7 files changed, 196 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index bfe247b1a333c..f4e6c8b6c2cf9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -410,6 +410,37 @@ static void gfxhub_v1_0_set_fault_enable_default(struct amdgpu_device *adev,
 	WREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL, tmp);
 }
 
+static void
+gfxhub_v1_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
+					     uint32_t status)
+{
+	/* this is handled in gmc_v9_0.c already */
+}
+
+static uint32_t gfxhub_v1_0_get_invalidate_req(unsigned int vmid,
+					       uint32_t flush_type)
+{
+	u32 req = 0;
+
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
+			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flush_type);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE2, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PTES, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
+			    CLEAR_PROTECTION_FAULT_STATUS_ADDR,	0);
+
+	return req;
+}
+
+static const struct amdgpu_vmhub_funcs gfxhub_v1_0_vmhub_funcs = {
+	.print_l2_protection_fault_status = gfxhub_v1_0_print_l2_protection_fault_status,
+	.get_invalidate_req = gfxhub_v1_0_get_invalidate_req,
+};
+
 static void gfxhub_v1_0_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
@@ -439,6 +470,8 @@ static void gfxhub_v1_0_init(struct amdgpu_device *adev)
 	hub->eng_distance = mmVM_INVALIDATE_ENG1_REQ - mmVM_INVALIDATE_ENG0_REQ;
 	hub->eng_addr_distance = mmVM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
 		mmVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
+
+	hub->vmhub_funcs = &gfxhub_v1_0_vmhub_funcs;
 }
 
 const struct amdgpu_gfxhub_funcs gfxhub_v1_0_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index fbdf46070b38b..fd216e1670abe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -539,6 +539,37 @@ static void gfxhub_v1_2_set_fault_enable_default(struct amdgpu_device *adev,
 	gfxhub_v1_2_xcc_set_fault_enable_default(adev, value, xcc_mask);
 }
 
+static void
+gfxhub_v1_2_print_l2_protection_fault_status(struct amdgpu_device *adev,
+					     uint32_t status)
+{
+	/* this is handled in gmc_v9_0.c already */
+}
+
+static uint32_t gfxhub_v1_2_get_invalidate_req(unsigned int vmid,
+					       uint32_t flush_type)
+{
+	u32 req = 0;
+
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
+			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flush_type);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE2, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PTES, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
+			    CLEAR_PROTECTION_FAULT_STATUS_ADDR,	0);
+
+	return req;
+}
+
+static const struct amdgpu_vmhub_funcs gfxhub_v1_2_vmhub_funcs = {
+	.print_l2_protection_fault_status = gfxhub_v1_2_print_l2_protection_fault_status,
+	.get_invalidate_req = gfxhub_v1_2_get_invalidate_req,
+};
+
 static void gfxhub_v1_2_xcc_init(struct amdgpu_device *adev, uint32_t xcc_mask)
 {
 	struct amdgpu_vmhub *hub;
@@ -577,6 +608,8 @@ static void gfxhub_v1_2_xcc_init(struct amdgpu_device *adev, uint32_t xcc_mask)
 		hub->eng_addr_distance =
 				regVM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
 				regVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
+
+		hub->vmhub_funcs = &gfxhub_v1_2_vmhub_funcs;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 80f1cf1f21736..73b96efd45484 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -705,25 +705,6 @@ static void gmc_v9_0_set_irq_funcs(struct amdgpu_device *adev)
 	}
 }
 
-static uint32_t gmc_v9_0_get_invalidate_req(unsigned int vmid,
-					uint32_t flush_type)
-{
-	u32 req = 0;
-
-	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
-			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
-	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flush_type);
-	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);
-	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
-	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
-	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE2, 1);
-	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PTES, 1);
-	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
-			    CLEAR_PROTECTION_FAULT_STATUS_ADDR,	0);
-
-	return req;
-}
-
 /**
  * gmc_v9_0_use_invalidate_semaphore - judge whether to use semaphore
  *
@@ -785,7 +766,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	BUG_ON(vmhub >= AMDGPU_MAX_VMHUBS);
 
 	hub = &adev->vmhub[vmhub];
-	inv_req = gmc_v9_0_get_invalidate_req(vmid, flush_type);
+	inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
 	sem = hub->vm_inv_eng0_sem + hub->eng_distance * eng;
 	req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
 	ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 243eabda06077..46b0fc94007cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -464,6 +464,37 @@ static void mmhub_v1_0_set_fault_enable_default(struct amdgpu_device *adev, bool
 	WREG32_SOC15(MMHUB, 0, mmVM_L2_PROTECTION_FAULT_CNTL, tmp);
 }
 
+static uint32_t mmhub_v1_0_get_invalidate_req(unsigned int vmid,
+					      uint32_t flush_type)
+{
+	u32 req = 0;
+
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
+			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flush_type);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE2, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PTES, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
+			    CLEAR_PROTECTION_FAULT_STATUS_ADDR,	0);
+
+	return req;
+}
+
+static void
+mmhub_v1_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
+					     uint32_t status)
+{
+	/* this is handled in gmc_v9_0.c already */
+}
+
+static const struct amdgpu_vmhub_funcs mmhub_v1_0_vmhub_funcs = {
+	.print_l2_protection_fault_status = mmhub_v1_0_print_l2_protection_fault_status,
+	.get_invalidate_req = mmhub_v1_0_get_invalidate_req,
+};
+
 static void mmhub_v1_0_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
@@ -493,6 +524,8 @@ static void mmhub_v1_0_init(struct amdgpu_device *adev)
 	hub->eng_distance = mmVM_INVALIDATE_ENG1_REQ - mmVM_INVALIDATE_ENG0_REQ;
 	hub->eng_addr_distance = mmVM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
 		mmVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
+
+	hub->vmhub_funcs = &mmhub_v1_0_vmhub_funcs;
 }
 
 static void mmhub_v1_0_update_medium_grain_clock_gating(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 2adee2b94c37d..84d1dc32728bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -448,6 +448,37 @@ static void mmhub_v1_7_set_fault_enable_default(struct amdgpu_device *adev, bool
 	WREG32_SOC15(MMHUB, 0, regVM_L2_PROTECTION_FAULT_CNTL, tmp);
 }
 
+static void
+mmhub_v1_7_print_l2_protection_fault_status(struct amdgpu_device *adev,
+					     uint32_t status)
+{
+	/* this is handled in gmc_v9_0.c already */
+}
+
+static uint32_t mmhub_v1_7_get_invalidate_req(unsigned int vmid,
+					      uint32_t flush_type)
+{
+	u32 req = 0;
+
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
+			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flush_type);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE2, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PTES, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
+			    CLEAR_PROTECTION_FAULT_STATUS_ADDR,	0);
+
+	return req;
+}
+
+static const struct amdgpu_vmhub_funcs mmhub_v1_7_vmhub_funcs = {
+	.print_l2_protection_fault_status = mmhub_v1_7_print_l2_protection_fault_status,
+	.get_invalidate_req = mmhub_v1_7_get_invalidate_req,
+};
+
 static void mmhub_v1_7_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
@@ -476,6 +507,7 @@ static void mmhub_v1_7_init(struct amdgpu_device *adev)
 	hub->eng_addr_distance = regVM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
 		regVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
 
+	hub->vmhub_funcs = &mmhub_v1_7_vmhub_funcs;
 }
 
 static void mmhub_v1_7_update_medium_grain_clock_gating(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 47d07cd25fc41..4c9f41905b650 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -577,6 +577,37 @@ static void mmhub_v1_8_set_fault_enable_default(struct amdgpu_device *adev, bool
 	}
 }
 
+static void
+mmhub_v1_8_print_l2_protection_fault_status(struct amdgpu_device *adev,
+					     uint32_t status)
+{
+	/* this is handled in gmc_v9_0.c already */
+}
+
+static uint32_t mmhub_v1_8_get_invalidate_req(unsigned int vmid,
+					      uint32_t flush_type)
+{
+	u32 req = 0;
+
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
+			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flush_type);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE2, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PTES, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
+			    CLEAR_PROTECTION_FAULT_STATUS_ADDR,	0);
+
+	return req;
+}
+
+static const struct amdgpu_vmhub_funcs mmhub_v1_8_vmhub_funcs = {
+	.print_l2_protection_fault_status = mmhub_v1_8_print_l2_protection_fault_status,
+	.get_invalidate_req = mmhub_v1_8_get_invalidate_req,
+};
+
 static void mmhub_v1_8_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub;
@@ -610,6 +641,7 @@ static void mmhub_v1_8_init(struct amdgpu_device *adev)
 			regVM_INVALIDATE_ENG0_REQ;
 		hub->eng_addr_distance = regVM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
 			regVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
+		hub->vmhub_funcs = &mmhub_v1_8_vmhub_funcs;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index fe0710b55c3ac..af7958931b152 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -536,6 +536,37 @@ static void mmhub_v9_4_set_fault_enable_default(struct amdgpu_device *adev, bool
 	}
 }
 
+static void
+mmhub_v9_4_print_l2_protection_fault_status(struct amdgpu_device *adev,
+					    uint32_t status)
+{
+	/* this is handled in gmc_v9_0.c already */
+}
+
+static uint32_t mmhub_v9_4_get_invalidate_req(unsigned int vmid,
+					      uint32_t flush_type)
+{
+	u32 req = 0;
+
+	req = REG_SET_FIELD(req, VML2VC0_VM_INVALIDATE_ENG0_REQ,
+			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
+	req = REG_SET_FIELD(req, VML2VC0_VM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flush_type);
+	req = REG_SET_FIELD(req, VML2VC0_VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);
+	req = REG_SET_FIELD(req, VML2VC0_VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
+	req = REG_SET_FIELD(req, VML2VC0_VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
+	req = REG_SET_FIELD(req, VML2VC0_VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE2, 1);
+	req = REG_SET_FIELD(req, VML2VC0_VM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PTES, 1);
+	req = REG_SET_FIELD(req, VML2VC0_VM_INVALIDATE_ENG0_REQ,
+			    CLEAR_PROTECTION_FAULT_STATUS_ADDR,	0);
+
+	return req;
+}
+
+static const struct amdgpu_vmhub_funcs mmhub_v9_4_vmhub_funcs = {
+	.print_l2_protection_fault_status = mmhub_v9_4_print_l2_protection_fault_status,
+	.get_invalidate_req = mmhub_v9_4_get_invalidate_req,
+};
+
 static void mmhub_v9_4_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub[MMHUB_NUM_INSTANCES] = {
@@ -584,6 +615,7 @@ static void mmhub_v9_4_init(struct amdgpu_device *adev)
 			mmVML2VC0_VM_INVALIDATE_ENG0_REQ;
 		hub[i]->eng_addr_distance = mmVML2VC0_VM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
 			mmVML2VC0_VM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
+		hub[i]->vmhub_funcs = &mmhub_v9_4_vmhub_funcs;
 	}
 }
 
-- 
2.55.0

