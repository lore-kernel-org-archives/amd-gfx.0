Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947CECDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:42:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 249C810E475;
	Mon, 22 Jun 2026 04:42:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ehSS8TsU";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012001.outbound.protection.outlook.com
 [40.93.195.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FABC10E471
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:42:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtYhBaz+8Fo1+6cPBhM+IhAj5QtdQyEIvBHBnCp6IavQwt3dtySVInjg+GKPWNezh0YAe459AjTJBMgIXlLE++fsEZKMKUsaeUSV0T1ax+aSrrUfgtDppRB6GqwKt+hcloL+1nwH7uI+nDo/R8/f7gprbgBrGPL362iEVD3FktR6GUIIpZpfDjb7DEvS1mTKNPovJ9gIlgCt5/Xm/3cJaePITcpfRH9cKzobssVWmeFHqeBYygWHFtq2lmhzFSPBU5MIN4jYzWeKG4gFr1KK8ty0R+wwpVTKFsvwRPPGr+YU0hyizVUchGkizfZstno4g5m/aoa76H/MW8MmdkAHyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBMdWhEcXABJdZaWwLvpPe5e4AlI17V5gkutM8jFrJU=;
 b=PmSO/CGoOx4TwVAuFJBvP7E93y5slaQuA9DpL2tWztJCoeA6xFohyEohrxk8Du5tu/wpJNsSPBCRKjhJzTHb4ghXmaBZw1etIUqpoKbO72AJ0JdrQzaRLaCdeQUg9/Hfuxf8bsmNDm37SpV0KkV6LnxJVwWfKcKRhnh/+Ahj9blyzuhU9kF8yYAxTLruiFZu5seg1gI8pXxnJqtWq4j53XhX2wb4qA9xxIuyEpJFvrY2DmSPgfFPbHpg3umnwaxXPOUyOFfjA9sQteV/Y8lDBJ6cMWDrwQJDNyiy9rLqBWQw3DoAASEPKYC4Dl5dj11ZWZwMWh/piqaYLnrGwE1Q9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBMdWhEcXABJdZaWwLvpPe5e4AlI17V5gkutM8jFrJU=;
 b=ehSS8TsUHJ+b/QqRBqtKR0OHVTmzbcH30xj1ZJwKXRiSJV8p7PWzggHOarzApABpPOxaZV9EwWHx83gxTI3hHf3CgIbBfNFybJ2JLGNajOEO16vfwvB5PtD4UKzNMSqi69DTjUWk91xck5/lzWgOdRrxI1H8yvdD8F6t8b4hP00=
Received: from MN2PR01CA0039.prod.exchangelabs.com (2603:10b6:208:23f::8) by
 MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.11; Mon, 22 Jun 2026 04:42:40 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::89) by MN2PR01CA0039.outlook.office365.com
 (2603:10b6:208:23f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Mon,
 22 Jun 2026 04:42:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:42:40 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:42:38 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 20/48] drm/amdgpu: retire legacy RAS reset/query operations
 for mmhub v1_8
Date: Mon, 22 Jun 2026 12:40:09 +0800
Message-ID: <2db63126c90cbb001d16e8bdcfa251f44d717221.1782103074.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782103073.git.cesun102@amd.com>
References: <cover.1782103073.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: 913383da-dd60-4ec8-ca60-08ded018b14a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qVaGvsjuc50pwt+g02PdZr+9ii+zZcgEK9O9NRlnmM/MkFe8nrOtoyU+cdJ610FyH6GHcKAJQRMQSbSTKQOnDtV/Xl/CHKw8LTuvJvfoeLNCoVBssygEIEr2NBTiMsXeCoUkzkLOw3yJZcDoQHb/dr47xU0n6D6PHLKSAyFVvMJMAIoi4AzQZfKosm+MNwYtxVwrJWuBX3EzeY9bm0/Twrpbxwqn+3MArfW12nkjJ/8zA7M1rz+iA7Z/01ay+EYLKZfS/OKtqo0bOFbr30PY0/le3eZD1ANOB8P5zYgIUUJMtBKAsOBzYu9YmbP3BaaotVRn+5P1qDcuDciuO1x8Q5f/vukDabK752S3mVm786U1XW2GSA+jOt8jxc1k//z+npJt7IzurQv4FYgDR6rOXq2J6kVfFaT1VY5kp9dJW5hs/CS3Csrkf7ES4gzBNljrHsosmQZ1/oqObo+vEywlmdltCZa2whwKbHVv/mtK52NDDNsJGZxKaTZUa0V4gOv1hJ1L14FVXjbGldOxcTmab/oVTUvJW2fxSYqy54DLWAYeN393yUjMF5Cr9iId1R6ATkrBHmqypjxPOJr0VtTEIFt9UFH5WmrS68Qj6vw51gQRKjy6IwKS4xBINu+zT9mCKrFcuecRyfe/KLTa3jw49Zhb6OIu4qRlkWOx9ntvLJV/GJNJ/6NFD1IvNgUK1E4GzvIoEIQq1AUwcof61+1XXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qBFvlRo+K7/qq6OMTE+YwPiWBtCv/Tw6na6zRdggnXweKqWjkGPl26jvp5wm5SQGg07JSPXPnAepPKRIyQAhZeVcM04Wwx0fs6p/rbozYOJwuFlI2teGgq+7P8k6WB33+aDu/iJwMmfG+j/6F0NMLROp0w9qQwDdoDpoVR/wQR/1FmJKvjZGNrAy7oc5BqWOaiqGudwMN8+6Jm7e2CJqqoLLk8g8Up8RyLX1X7KYyt/qh37NfaS/gUL06BxRtzmSo3nO1msC3vDRy76ltllUyOG1ffWT6fz8jWU16POgr7BVFYeSznnz10rjS6kwEVXW42zzhf2gygybSSLW/hCmePlFPujOM5Cxt1IXFweyOXvZQjLnhkxmQ49cg3U8Qwl4dWjaQf7as8BVIbei35r+z/3EbMlwfr77Vls3/3xxF1GRM/ijY7+Riwu/SVmcgM+G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:42:40.5011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 913383da-dd60-4ec8-ca60-08ded018b14a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714
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

