Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEACC5DF93
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:04:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EFF310F337;
	Fri, 21 Aug 2026 16:04:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xTgu9lTa";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012060.outbound.protection.outlook.com [52.101.53.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29D8B10F339
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVkFYgX5DylnGvZv8lK4b+QwfF2zHjo4w80fh1ktTxHZ6ayAaDBmevlN+KQOSe6XI0M2Uxl/jqNcZHtu3IldMdi6cZj0jSAq+uLtGuywQHCB35wVKy+pRgZ2S5tJZqfVoURNs3DfwP6pmA/6Ef2IuSgYWrbnoEuDd6YmL1oO4rfXqKO756thz6kah/KCFHArpuj08G5fdRMM1gKLboTI25owX0vwGJa2sbEzBJ2bn1/dFgWK7sJcqsn3iItPMA234tp8VzOWv8aLwTkyfolatO4AjI9yfp5DulqfRqn0DcH2TRk8n1oFB4lo8LjXC0BTxLb1kJtGOxSYbxEAr/G/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OP8mTxDdcrpXUkM5o/EbPztzOqrgTXy9JvG2zG1FTkc=;
 b=tXCzAB+mOEb7PQ0IAZTQNpKmg7lh/jAyqNw125yXIUgBw83PFopn7T9nT+5r/t+JrZl6sXVPH83gtYWSbxTAizz7e05JxDgI56Vd9icvjTKjQaMxuqLOMUpi9rmkVF2o/eUOgiPL5xJXGGKgh+fNa6odS2/v+NitzGYA2AuCCCKLXbynO6wzxiNNwgdtUaG7mkY9PTVh3GZgg4rxnlCOxS8P0wTVuXfFOityt7jBOMjKsVaYCy0BxCb+vNKbn0zekkmxETHAYxGFXjiWtABxXVARojmGgHd6n3hdeIKeFCpxORE6NoddfBIbi0wxFkZpYYymvatfatrmddToKYNmog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OP8mTxDdcrpXUkM5o/EbPztzOqrgTXy9JvG2zG1FTkc=;
 b=xTgu9lTatr10q2fBdN3FVjS99timrqFODpoFbwZFSMmNHcuztu5lZ2j3P4sS/dz7OqfWHa5Pnq81EPQJ4IKFWEcZ+QjVLR4CVNR1WwGTZpAcK3vxfN5Ql4hoNYqZeDblxVxeL2dhp9bJC5dA5qysqoNfXXBDAFmIUY+ketaumMY=
Received: from MW4PR03CA0091.namprd03.prod.outlook.com (2603:10b6:303:b7::6)
 by PH7PR12MB5807.namprd12.prod.outlook.com (2603:10b6:510:1d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 16:04:04 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:303:b7:cafe::13) by MW4PR03CA0091.outlook.office365.com
 (2603:10b6:303:b7::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Fri,
 21 Aug 2026 16:04:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:04:03 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:04:02 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:04:02 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:04:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: add sdma debug parameter
Date: Fri, 21 Aug 2026 12:03:52 -0400
Message-ID: <20260821160354.751604-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|PH7PR12MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: 031a01a6-e667-452e-d815-08deff9dd202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: B1ci6QnA7fgayzbXXaWFErC9BJC6TAqPz6epK2qQ2lUbZujbi10tcdHC8CkK8mZwvU+DIbAEiLeCMHncRZzuGSK/2yDAkNaIvhXUJdfvuY5GkL0yU0Rim67YiXC4ZrRg/cuoDhnOedW/uangfEqiCOzlrvhH17B1rRHaEo6wPzVDZD4pa/iC4n4Jiabd3R+OdD13OCpNcUGyMvV7YnyT9W9ufXj0XWCDzhUnAR2AbIk1UZ5UOBEqIyLnjmrmpJk/BjVthlx74UguC44pcK+2a3qDnseEBAvQnrBRxxRfVtq3b8swhAZrPFRbDR5FBF/htrMGYRKyp5ghxrzV++0aZLTRgH5Ow5Unc7f5kSC8aJDb7TFVzuUsc2/Z+KnZQt6zs2P4MENhlfqfWitfs0Zszw+T6CsUWez/WkUZKh6o9MmFxj+B34f69pLP+VBQ56err+a3WbuEhKuUgdycftbWKWvIO3kW2b06evwCdyZnhmSpcDOX1TUIVJUljtFSHhCDbJ6ra/1p3MgPyV+jGkI9CAdASnfSHLTOG3knuynp98cKboEs14DOmkVWtNAcxw/SqEdMWOSYEyV+mcs/FeGSnkeirRLXxYcPb9QoiQ9iIHVVLENIcAS+nEJ9C2/W49gcXUexAY4S0eUhuiHElIpeN8E3plRk2RuCfu4nS0bgY8Fb7p9difkCnxfsTrIj+1mhbaXT8BDMUEQtY++rZophDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C/Xpl40oe2ERIYoe0/QVc5s8snzxxJdyzOCbpNxnib+P66muBXAeCf7MdKnb2fwppw8s3IokI86eyHZID8Gk4ZRfUxk4Kpr1oJfZlI83dg1VekQNMplq1TsXJZJbfSDZeKQPuEK5uPx3N7ZXdFINrXCmg0lAqb+IB1tm88dRSErVneh8E7GEzy4fVbClkFjeNG92WK439K8AwnGKVI6X6tQOaYkQhVtE3AkgpdOeIr6yVYAD9+tO+ZxfyEf9RgnefjPi1VeEd7e/IXR59AaGfoL2WCnzwZZAGQESpXJO+RCYlw0gQ4+zBc/BpijztTssEtlG4cvHFdvGFYGTeJL4yuAkTUstbm9+wAC/7NiLnosFXhN5UWJo0OWso28RM2aHEDSwo+VH18Bph+oqQJ0gubIuoc6QVi83EB4rMm07LY5X7emY3tl46Csz1n1qJApp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:04:03.0539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 031a01a6-e667-452e-d815-08deff9dd202
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5807
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

From: Likun Gao <Likun.Gao@amd.com>

Add parameter to switch sdma RB CMD for sdma v7.1.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c   | 18 ++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 395235272339b..53738b40c97f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -148,6 +148,7 @@ enum AMDGPU_DEBUG_MASK {
 	AMDGPU_DEBUG_ENABLE_CE_CS = BIT(10),
 	AMDGPU_DEBUG_HIBERNATION_THAW_RESUME_GPU = BIT(11),
 	AMDGPU_DEBUG_DISABLE_IP_BLOCK_SOFT_RESET = BIT(12),
+	AMDGPU_DEBUG_SDMA_RB_CMD = BIT(13),
 };
 
 unsigned int amdgpu_vram_limit = UINT_MAX;
@@ -2301,6 +2302,11 @@ static void amdgpu_init_debug_options(struct amdgpu_device *adev)
 		pr_info("debug: IP block soft reset disabled\n");
 		adev->debug_disable_ip_block_soft_reset = true;
 	}
+
+	if (amdgpu_debug_mask & AMDGPU_DEBUG_SDMA_RB_CMD) {
+		pr_info("debug: enable SDMA RB command switch\n");
+		adev->sdma.sdma_debug = true;
+	}
 }
 
 static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned long flags)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 4f4e56022c970..671cfbb67b7a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -103,6 +103,7 @@ struct amdgpu_sdma {
 
 	int			num_instances;
 	uint32_t 		sdma_mask;
+	bool    		sdma_debug;
 	union {
 	    int			num_inst_per_aid;
 	    int			num_inst_per_xcc;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index e9a3bcfd7775c..645f8b446652b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -1365,6 +1365,22 @@ static int sdma_v7_1_sw_fini(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+#define regSDMA0_SDMA_FE_CNTL0			0x10
+#define regSDMA0_SDMA_FE_CNTL0_BASE_IDX		0
+static void sdma_v7_1_rb_cmd_switch(struct amdgpu_device *adev,
+				    uint32_t inst_mask)
+{
+	int i, fe_cntl;
+	
+	if (adev->sdma.sdma_debug) {
+		for_each_inst(i, inst_mask) {
+			fe_cntl = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_FE_CNTL0));
+			fe_cntl &= 0x7fffffff;
+			WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_FE_CNTL0), fe_cntl);
+		}
+	}
+}
+
 static int sdma_v7_1_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -1373,6 +1389,8 @@ static int sdma_v7_1_hw_init(struct amdgpu_ip_block *ip_block)
 
 	inst_mask = GENMASK(adev->sdma.num_instances - 1, 0);
 
+	sdma_v7_1_rb_cmd_switch(adev, inst_mask);
+
 	r = sdma_v7_1_inst_start(adev, inst_mask);
 	if (r)
 		return r;
-- 
2.55.0

