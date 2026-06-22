Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75923CDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:45:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F7BB10E574;
	Mon, 22 Jun 2026 08:45:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L11vFBml";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A23A10E564
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:45:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BipY5faJgsg4cIWV60hA/BlqRXV/p79JknstALMb8rUfcoZuamZbZJqc6uG15LNqIMtnJF3Pp4sWVLo0J+PxEkNKzq+GBmVNujGhupOe6cqg0RZN8T1ud/I3h1DSSGRa5r6OMSqwt59ntm0/S8rIP4VsUjEU/bVa0jUhbCp+TDvaK+7/8SuYa3HCjMcS9W/EQ4Z3JUcsP0XOSi4KozwuY3vY88LF3xSVhRE9EpeWpMZte4AU1GRpCLAp9VOjZKIDE2cDrLVk53TbgyXJwOTf+0RH0SoiVqzwacD78F1ZDuk/693QbienVR5ekbB9tWt4cTzQtuMG2tFSUqiavKoO5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBMdWhEcXABJdZaWwLvpPe5e4AlI17V5gkutM8jFrJU=;
 b=GlGl0ikiMIesjS5VCORPUVrxprxVfPi7BP8/YQkALPUwxmP5kKbGjP4vQyHVIAiRhifO41TnpG6GjzJJeLuQHbYx/PyEhUxHceEnOtbLYj73gZIk8tq9tGPkTF+affXZLHccsVUSZW+fpg90RXX34JNPU9IZgAKn95Aw7NGoNS59922/Cd4Eppwq3oI1ghP4SWZjSHQ5vW1AYPgh8VBNfWvxAWsPF7jQd/APtUB2Oy1Gv5QjvaaiGZVXMFWyh4A4lDJocMKO9zXFeSoWSHKaaxTdlYQ0oWazae3W43J+HHypI+PAnkAB6B6z1rKeMAerAKMnyZ+0eUx7sAKuPsl1PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBMdWhEcXABJdZaWwLvpPe5e4AlI17V5gkutM8jFrJU=;
 b=L11vFBmlpDEXyzuGZkynmZ56YTgTYWlclUcI42CO4Eg6+LvmPt/JuB0XaSKYMTXzcNtLOrbjtRRXVg1XQx/VYVMgHfxrB6it+JbL/AQP4SgWKSNB5gf6HCk1Tu5iGVUN3kRaMHEGuDrYtV9WOwaRRUmHVfFNU4iw26sNYp8ECzY=
Received: from DS7PR06CA0045.namprd06.prod.outlook.com (2603:10b6:8:54::26) by
 MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 08:45:50 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::1e) by DS7PR06CA0045.outlook.office365.com
 (2603:10b6:8:54::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 08:45:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:45:50 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:45:46 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 20/48] drm/amdgpu: retire legacy RAS reset/query operations
 for mmhub v1_8
Date: Mon, 22 Jun 2026 16:44:22 +0800
Message-ID: <138d8856db316adf62a8091e59424291c37fc621.1782117608.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
References: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|MN2PR12MB4470:EE_
X-MS-Office365-Filtering-Correlation-Id: 347d33be-de8f-49e0-6f86-08ded03aa981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: zRclAvD1oPe/6qo/lAGyGXfzjjENJF5iT6tnnIl+2mZApZwngbKKV/OAYloPf+qMb+Yme+DqtjavAYISuSL56GyXpOXYJZkmf3GiGILMXNfUMdwroRqENjvmSEgDD5j2/LyAv+8k7TvgqOBqjP8aoa+lPsW6PSSTOQ1rV+nbd9KN7xXUjyZSHaxwYbhbq0iRXV9hLX3lJm3Zt5zn8UMDVU/kvmjvJnTV4Z9mxMMzasA+G/NvDOM9mxgjcGST+cUno14tKdhGP4HZLu3oqk4OEv+mV4JIHsmyU8v3dJpC/w1SlIsup8CnX2JckNURB2kXhfyOTmt4DcshnqqqwZpbg4gIO/T+LSyLrq5v/hgc+UY4A+ngSaccKbLlobtI6zhJXMQ8PRXb8FpA2jFY2ClgSgaoDPgDTM8zuGt5DcZxv/uxOtDXV3yWwFYyhRvYvqBASowDaqsODFt13WISf4jOqjnlCAHxpaRZNAI9VzDs1e/AiGGxbNiZ8EqvaHKCL8WZPvjTB463sYz5YrMjqei0QHGYbdtXQ13NNLlVAtuli4ixjd9W+my4eS/vWAFGzhkcKKs66sX0ynKhlPjrmgiw60sXueZjGynvnRTfudXA1rwP8edRxPSEi17Um7K3hau9ttFtWBIRppyQCYcMYOg5agV9MxqCeC8jV14OXmVPmLo6fnAWPt/JqnFRIeiPrHiWXY3fgKlLKehgHlWaPxno1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f+S981jD4k9nm6LgRF0r8U23CcIM3yTe1LtQQDrdDrKeGq4T5K6KeK0ObzB5Q/1ieWENA7z5vH/q/36N3hpDDPN4S1KYau53dklqRSKPu6ao4XsDoFlr357e4xqTtN/AZo6nmKEJB/9EMJ/fY6+xRIPBg6QyTgFG43+30sB3CGvOclaP9QpwdGq/SI2vDDl/2J4kQMPm0Ix3poxAtfRg/vilZLU4gLa70MJGN0p1DkrD/uGU1Z8WIAV5ZyQ/AUiFTohDmujN5nwhJ56adS18+MTCWAaMpH0tpbz7oewicNUAmbQYGzHlOfdnygF6Xf8hlgJDELMBrSICSv7Z0oKQc5xDQDLqETv0N0W2iXR9dVPdO5CcfJXhvLxIleA/cyIhRJ7/JojGARrbS/Zuil7/q3gi/kVIxY5MPQ+EBI/zAt54pQLECQKdcgC42eaiCIkl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:45:50.2834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 347d33be-de8f-49e0-6f86-08ded03aa981
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
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

retire legacy RAS reset/query operations for mmhub v1_8

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h |  23 ----
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c   | 139 +---------------------
 2 files changed, 1 insertion(+), 161 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
index 6b8214650e5d..c5120ba51e24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
@@ -21,29 +21,6 @@
 #ifndef __AMDGPU_MMHUB_H__
 #define __AMDGPU_MMHUB_H__
 
-enum amdgpu_mmhub_ras_memory_id {
-	AMDGPU_MMHUB_WGMI_PAGEMEM = 0,
-	AMDGPU_MMHUB_RGMI_PAGEMEM = 1,
-	AMDGPU_MMHUB_WDRAM_PAGEMEM = 2,
-	AMDGPU_MMHUB_RDRAM_PAGEMEM = 3,
-	AMDGPU_MMHUB_WIO_CMDMEM = 4,
-	AMDGPU_MMHUB_RIO_CMDMEM = 5,
-	AMDGPU_MMHUB_WGMI_CMDMEM = 6,
-	AMDGPU_MMHUB_RGMI_CMDMEM = 7,
-	AMDGPU_MMHUB_WDRAM_CMDMEM = 8,
-	AMDGPU_MMHUB_RDRAM_CMDMEM = 9,
-	AMDGPU_MMHUB_MAM_DMEM0 = 10,
-	AMDGPU_MMHUB_MAM_DMEM1 = 11,
-	AMDGPU_MMHUB_MAM_DMEM2 = 12,
-	AMDGPU_MMHUB_MAM_DMEM3 = 13,
-	AMDGPU_MMHUB_WRET_TAGMEM = 19,
-	AMDGPU_MMHUB_RRET_TAGMEM = 20,
-	AMDGPU_MMHUB_WIO_DATAMEM = 21,
-	AMDGPU_MMHUB_WGMI_DATAMEM = 22,
-	AMDGPU_MMHUB_WDRAM_DATAMEM = 23,
-	AMDGPU_MMHUB_MEMORY_BLOCK_LAST,
-};
-
 struct amdgpu_mmhub_ras {
 	struct amdgpu_ras_block_object ras_block;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 2a6a5ac4f374..47d07cd25fc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -29,7 +29,6 @@
 
 #include "soc15_common.h"
 #include "soc15.h"
-#include "amdgpu_ras.h"
 #include "amdgpu_psp.h"
 
 #define regVM_L2_CNTL3_DEFAULT	0x80100007
@@ -636,144 +635,8 @@ const struct amdgpu_mmhub_funcs mmhub_v1_8_funcs = {
 	.get_clockgating = mmhub_v1_8_get_clockgating,
 };
 
-static const struct amdgpu_ras_err_status_reg_entry mmhub_v1_8_ce_reg_list[] = {
-	{AMDGPU_RAS_REG_ENTRY(MMHUB, 0, regMMEA0_CE_ERR_STATUS_LO, regMMEA0_CE_ERR_STATUS_HI),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "MMEA0"},
-	{AMDGPU_RAS_REG_ENTRY(MMHUB, 0, regMMEA1_CE_ERR_STATUS_LO, regMMEA1_CE_ERR_STATUS_HI),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "MMEA1"},
-	{AMDGPU_RAS_REG_ENTRY(MMHUB, 0, regMMEA2_CE_ERR_STATUS_LO, regMMEA2_CE_ERR_STATUS_HI),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "MMEA2"},
-	{AMDGPU_RAS_REG_ENTRY(MMHUB, 0, regMMEA3_CE_ERR_STATUS_LO, regMMEA3_CE_ERR_STATUS_HI),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "MMEA3"},
-	{AMDGPU_RAS_REG_ENTRY(MMHUB, 0, regMMEA4_CE_ERR_STATUS_LO, regMMEA4_CE_ERR_STATUS_HI),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "MMEA4"},
-	{AMDGPU_RAS_REG_ENTRY(MMHUB, 0, regMM_CANE_CE_ERR_STATUS_LO, regMM_CANE_CE_ERR_STATUS_HI),
-	1, 0, "MM_CANE"},
-};
-
-static const struct amdgpu_ras_err_status_reg_entry mmhub_v1_8_ue_reg_list[] = {
-	{AMDGPU_RAS_REG_ENTRY(MMHUB, 0, regMMEA0_UE_ERR_STATUS_LO, regMMEA0_UE_ERR_STATUS_HI),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "MMEA0"},
-	{AMDGPU_RAS_REG_ENTRY(MMHUB, 0, regMMEA1_UE_ERR_STATUS_LO, regMMEA1_UE_ERR_STATUS_HI),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "MMEA1"},
-	{AMDGPU_RAS_REG_ENTRY(MMHUB, 0, regMMEA2_UE_ERR_STATUS_LO, regMMEA2_UE_ERR_STATUS_HI),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "MMEA2"},
-	{AMDGPU_RAS_REG_ENTRY(MMHUB, 0, regMMEA3_UE_ERR_STATUS_LO, regMMEA3_UE_ERR_STATUS_HI),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "MMEA3"},
-	{AMDGPU_RAS_REG_ENTRY(MMHUB, 0, regMMEA4_UE_ERR_STATUS_LO, regMMEA4_UE_ERR_STATUS_HI),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "MMEA4"},
-	{AMDGPU_RAS_REG_ENTRY(MMHUB, 0, regMM_CANE_UE_ERR_STATUS_LO, regMM_CANE_UE_ERR_STATUS_HI),
-	1, 0, "MM_CANE"},
-};
-
-static const struct amdgpu_ras_memory_id_entry mmhub_v1_8_ras_memory_list[] = {
-	{AMDGPU_MMHUB_WGMI_PAGEMEM, "MMEA_WGMI_PAGEMEM"},
-	{AMDGPU_MMHUB_RGMI_PAGEMEM, "MMEA_RGMI_PAGEMEM"},
-	{AMDGPU_MMHUB_WDRAM_PAGEMEM, "MMEA_WDRAM_PAGEMEM"},
-	{AMDGPU_MMHUB_RDRAM_PAGEMEM, "MMEA_RDRAM_PAGEMEM"},
-	{AMDGPU_MMHUB_WIO_CMDMEM, "MMEA_WIO_CMDMEM"},
-	{AMDGPU_MMHUB_RIO_CMDMEM, "MMEA_RIO_CMDMEM"},
-	{AMDGPU_MMHUB_WGMI_CMDMEM, "MMEA_WGMI_CMDMEM"},
-	{AMDGPU_MMHUB_RGMI_CMDMEM, "MMEA_RGMI_CMDMEM"},
-	{AMDGPU_MMHUB_WDRAM_CMDMEM, "MMEA_WDRAM_CMDMEM"},
-	{AMDGPU_MMHUB_RDRAM_CMDMEM, "MMEA_RDRAM_CMDMEM"},
-	{AMDGPU_MMHUB_MAM_DMEM0, "MMEA_MAM_DMEM0"},
-	{AMDGPU_MMHUB_MAM_DMEM1, "MMEA_MAM_DMEM1"},
-	{AMDGPU_MMHUB_MAM_DMEM2, "MMEA_MAM_DMEM2"},
-	{AMDGPU_MMHUB_MAM_DMEM3, "MMEA_MAM_DMEM3"},
-	{AMDGPU_MMHUB_WRET_TAGMEM, "MMEA_WRET_TAGMEM"},
-	{AMDGPU_MMHUB_RRET_TAGMEM, "MMEA_RRET_TAGMEM"},
-	{AMDGPU_MMHUB_WIO_DATAMEM, "MMEA_WIO_DATAMEM"},
-	{AMDGPU_MMHUB_WGMI_DATAMEM, "MMEA_WGMI_DATAMEM"},
-	{AMDGPU_MMHUB_WDRAM_DATAMEM, "MMEA_WDRAM_DATAMEM"},
-};
-
-static void mmhub_v1_8_inst_query_ras_error_count(struct amdgpu_device *adev,
-						  uint32_t mmhub_inst,
-						  void *ras_err_status)
-{
-	struct ras_err_data *err_data = (struct ras_err_data *)ras_err_status;
-	unsigned long ue_count = 0, ce_count = 0;
-
-	/* NOTE: mmhub is converted by aid_mask and the range is 0-3,
-	 * which can be used as die ID directly */
-	struct amdgpu_smuio_mcm_config_info mcm_info = {
-		.socket_id = adev->smuio.funcs->get_socket_id(adev),
-		.die_id = mmhub_inst,
-	};
-
-	amdgpu_ras_inst_query_ras_error_count(adev,
-					mmhub_v1_8_ce_reg_list,
-					ARRAY_SIZE(mmhub_v1_8_ce_reg_list),
-					mmhub_v1_8_ras_memory_list,
-					ARRAY_SIZE(mmhub_v1_8_ras_memory_list),
-					mmhub_inst,
-					AMDGPU_RAS_ERROR__SINGLE_CORRECTABLE,
-					&ce_count);
-	amdgpu_ras_inst_query_ras_error_count(adev,
-					mmhub_v1_8_ue_reg_list,
-					ARRAY_SIZE(mmhub_v1_8_ue_reg_list),
-					mmhub_v1_8_ras_memory_list,
-					ARRAY_SIZE(mmhub_v1_8_ras_memory_list),
-					mmhub_inst,
-					AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
-					&ue_count);
-
-	amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, ce_count);
-	amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, ue_count);
-}
-
-static void mmhub_v1_8_query_ras_error_count(struct amdgpu_device *adev,
-					     void *ras_err_status)
-{
-	uint32_t inst_mask;
-	uint32_t i;
-
-	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB)) {
-		dev_warn(adev->dev, "MMHUB RAS is not supported\n");
-		return;
-	}
-
-	inst_mask = adev->aid_mask;
-	for_each_inst(i, inst_mask)
-		mmhub_v1_8_inst_query_ras_error_count(adev, i, ras_err_status);
-}
-
-static void mmhub_v1_8_inst_reset_ras_error_count(struct amdgpu_device *adev,
-						  uint32_t mmhub_inst)
-{
-	amdgpu_ras_inst_reset_ras_error_count(adev,
-					mmhub_v1_8_ce_reg_list,
-					ARRAY_SIZE(mmhub_v1_8_ce_reg_list),
-					mmhub_inst);
-	amdgpu_ras_inst_reset_ras_error_count(adev,
-					mmhub_v1_8_ue_reg_list,
-					ARRAY_SIZE(mmhub_v1_8_ue_reg_list),
-					mmhub_inst);
-}
-
-static void mmhub_v1_8_reset_ras_error_count(struct amdgpu_device *adev)
-{
-	uint32_t inst_mask;
-	uint32_t i;
-
-	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB)) {
-		dev_warn(adev->dev, "MMHUB RAS is not supported\n");
-		return;
-	}
-
-	inst_mask = adev->aid_mask;
-	for_each_inst(i, inst_mask)
-		mmhub_v1_8_inst_reset_ras_error_count(adev, i);
-}
-
-static const struct amdgpu_ras_block_hw_ops mmhub_v1_8_ras_hw_ops = {
-	.query_ras_error_count = mmhub_v1_8_query_ras_error_count,
-	.reset_ras_error_count = mmhub_v1_8_reset_ras_error_count,
-};
-
 struct amdgpu_mmhub_ras mmhub_v1_8_ras = {
 	.ras_block = {
-		.hw_ops = &mmhub_v1_8_ras_hw_ops,
+		.hw_ops = NULL,
 	},
 };
-- 
2.34.1

