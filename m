Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85816CDB466
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:20:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 168E010F185;
	Thu, 25 Jun 2026 08:20:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XkwhGKdN";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012015.outbound.protection.outlook.com [40.107.209.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BB0C10F181
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:20:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHCmobdPcyOpMQ3hGXbn32+AgNrvb8KmVQqOE0NFSJdr6wc/dwMkRzHbmItb2QFHZxbHKJn4KakdtZ2vJlwNnqIW6kPrSgP+6a9Oh1Rl8MyjCYApmTSW+E4KqzWRkeLmnMt2iL4ZEEF+rz8SaTQXuccJt9LdBsd13RLl4Id/V+jcN1B/9x9UTitVf2BpQDvl2wK7kQOz4RjbkL1snCWW8tstN7BLBU4G7Yv9of9gHQrYYS4ttA19lh7HY/3azwN2oxyjTss9T1mGFZiAtpPbPQV/nx7modYCFgxyvlM8YzNsdlXdincPpM8Zxh+MAHvgqSLHxcP/CVkFsmsgIDdWcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBMdWhEcXABJdZaWwLvpPe5e4AlI17V5gkutM8jFrJU=;
 b=dwJjfyd7SWHbYwg+56iTjK3vpGn4fLL577QljerhCfMR/ZSUUXY7WF0tMTkNcDd7wkrOrrIWgZDFD6TbbjPAnOrYfojzATrWwJw7O2jxS6xASFXj2uPNZlxMg2eXqK6W4RWFLml8Yjb9B9/zdGvETCSTZb7WbuJ/9YY0/dClq4X/56K7dZQdgQy8wfKzaOE9A2ZZIwwHsWt1gY2X5b4wxCvXcys/pH5s2y/K4IuZ3AgltfRQibZ5gIi+B73gf6uU+8Yz2qz1VZ6vznOAIn5cpPfvW6IPweM0laLQBIf2bjHanrs4HHS3taMvVKZz1W6yJhib6srZzLSHSSxeeCysfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBMdWhEcXABJdZaWwLvpPe5e4AlI17V5gkutM8jFrJU=;
 b=XkwhGKdNMhbCcPTh23yi0Uj6MsYY5UhjmwOqxd6SuDaEybUgjE0ZBE5Lzu8csfvs+nTt/A1TluFdULcYTpFQ8lsW9RqUBW4ukhmW/vf+wweCO0pwdvnZ5wx3oGM5vfbNPojkIdRfeHn7rS90EkW8345s2rSwqZukAyvV/bAaAvM=
Received: from CYZPR14CA0001.namprd14.prod.outlook.com (2603:10b6:930:8f::11)
 by SN7PR12MB8772.namprd12.prod.outlook.com (2603:10b6:806:341::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Thu, 25 Jun
 2026 08:20:50 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:8f:cafe::66) by CYZPR14CA0001.outlook.office365.com
 (2603:10b6:930:8f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 08:20:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:20:49 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:20:47 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 20/44] drm/amdgpu: retire legacy RAS reset/query operations
 for mmhub v1_8
Date: Thu, 25 Jun 2026 16:19:13 +0800
Message-ID: <46114b25d00f4e4f1b42508f174d4629695d72bf.1782373702.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
References: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|SN7PR12MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f3442bc-94a0-4116-85f0-08ded292aa75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vYftsPLGZRx4wDSSyg6k7QdBrA3ty4UfQaCdzyzBWp44ATeFOZi2PPLGSIoOiTSLPLSB0Fuw560SVejRoJZns6bF3dZKdTpj+MWy6M2ttU9N4s4Q7KRDJQLNBy3JCFRzJS+UX7b1frkZjOWjGLs0qR/EYFsmWypeDXj+J3OZqZEk5xElvelSwekrbnHSZ6hWSvkH+sC/X5CgKy2N1riT/Y4Pzi/YjrI/XYm0FhxYrPYQABzJ7IxWYCJDI6Yzy+BEPfkZb3OGDAAPp00ls8qta87TPl2hfydhdBKIOR87qz3XRHZDNxeU5W9o8hmaVTszRqhGXdrS5FKyqJ4fpH0UYfVMyvrfTrxB53Mq5TgMtD554A4GJX+u4nnpvMYU3emJ6X2M/pyk6EjFfSBfT+wyfESqH78rQKOmB5YUxfvaA/C7fharnoTAK22g+rrxgkmtCe3lJX0gV/0206DK1aL9+GCljc1+vyrNn9mYKOARqLOnutlfpT8VLwZag5mLananZN72pzmPsjzLjFeTWRUdUlyAxj7MV16GciXmejntPmK0M0w4S5iGFgfdaMRPp9j+I3emnCXAcjnPHeuexH4fQHSC1HiJPGW3debNMC9gXmjvmUG8Re9vFyzjZUkwZBULN+jtpr5rya/l6InrhqEcdvNNI7IU3MA9NFt0b7txeqeT3Hj0NDDBHwxw0HWgFXnKUg/raXV4/tj7fMQuMIV5nA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: msM2Igi+TJ7J9kRNMqJX8lYuiWkI3DRelpcRkjuXIc7W9S3B2lqTnMyXFUk/aSt73qjUfBPmRSKYiZW9BZILdbh5XF+QTgm1P1xIIkWQkBzFcviN4/7HWGRxHPMg2TMWG+8rl29xIYiL7+qnQaBabuWCVmeN+/kGff5LsgjTIqVewOre7qXE6bxa99wVwDfo3ZF+4HvCqEC3bttKUlm6nQWMbPa1nZBe11Cc3VVPV52UJ/2Xs6YYUT1Hjh9AQrupKrcYRNSkn3bY+CYKVJ7O7bgaGNFN1UAhTfAzgTg5g49nHfe1WaH8mbkK+6WInOF/feGXGDOtp/ONWu6F8TPiS41g0bGWcY8Msh0j0UaOSbVUaca0BF38Hp129BLsSjHoYMQeXUXQrxw6tbfnpRPC1NB9Ec6Alx0sRdRa1WactAHEi2jp1j4XbUY5oolentrC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:20:49.9173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3442bc-94a0-4116-85f0-08ded292aa75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8772
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

