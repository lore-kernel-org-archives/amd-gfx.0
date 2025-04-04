Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36AEC36010
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Apr 2025 18:42:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D92510E272;
	Fri,  4 Apr 2025 18:42:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RMGjSe8X";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 231CD10E272
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Apr 2025 18:42:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1wkl5WrQ6sdc+m/+dZsZNHIXAcT2UeajYOWYFOB4pg3PdFape9kwZB6SauDoYIJljcvPssS0n34RNRX1nLs0mxAxNvZgf/c/ui6DCIV7RnTsSz26rdP/Ssk2RNq3zteGmoOnfLrujA4BLC/2lOjBtdSB0KExoO9/NLe8Ms4sNZWZz3VYQxnaNEtn/bH789BS6fQ8hxs7SXMw04oroV3dYHkuX8vzWMyriKvs5pYHlwkkSOZOn07qmnXg5lQH/gcLvGPj08excCRJjcLA3S//PCAUjlLjPdCFGHW2nS1iygy/A/JkrSZ84MBufQue/R4cV/kdaORo3awe9WKAaJpAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0g1ax8qHfV6+R65/FYktKhXNuoE8BUJi9ZQTh5+icy0=;
 b=VEoGp+EwTrmtIWM8tJFIOGUPp8xOrh/6J0gqyDY46e9dniWumhK/JTrmQEd9u/RsRaVEiezqe0qOST5qGQHKn7f+G5SZg+QvCi3j4Gbhi9YOHeyOk/zC5OLs9awC+rS2T9KSxjsY+GYLkz92HgJjzPoLO+h1KxuGoA/0P3l1lg4H8wnQkyUA6TQpjyuFkIxwA1aVhMdhOQrV375LPX2mLjI1WstUyTszN9p6zg0ANBhz4aHrnA3VjzQ0oK7wFyEmIaFWdo+6y1Fafhj6rNUDLeKWPBd+/ckH2vqdlEj04HU2QM0/LJXGmhfgVNNndNOf5VwA6stf5AfBXi/Vr1wT2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0g1ax8qHfV6+R65/FYktKhXNuoE8BUJi9ZQTh5+icy0=;
 b=RMGjSe8XLToQ0Pg819mUet+X99yqXV9Bwgc4lUAF3RuROB6Vk7WnUt3uaCOYT4W4GpF+/svMfbtANoTp/yCyMo6GbP2rn5ngNPXW20JkdYe/JHxyjDBmwgyhGdKwTgY1cho65o8QIyPRGIdNaanl9b634aq1/xVc0fS/9bzLPbo=
Received: from SJ0PR13CA0229.namprd13.prod.outlook.com (2603:10b6:a03:2c1::24)
 by SA3PR12MB9107.namprd12.prod.outlook.com (2603:10b6:806:381::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.45; Fri, 4 Apr
 2025 18:42:33 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::6d) by SJ0PR13CA0229.outlook.office365.com
 (2603:10b6:a03:2c1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.8 via Frontend Transport; Fri, 4
 Apr 2025 18:42:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Fri, 4 Apr 2025 18:42:33 +0000
Received: from asrock-1e715-b03-3.mkm.dcgpu (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Apr 2025 13:42:32 -0500
From: Ahmad Rehman <Ahmad.Rehman@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Victor.Skvortsov@amd.com>, Ahmad Rehman <Ahmad.Rehman@amd.com>
Subject: [PATCH] drm/amdgpu: Modify register write via PSP
Date: Fri, 4 Apr 2025 14:41:59 -0400
Message-ID: <20250404184159.500250-1-Ahmad.Rehman@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|SA3PR12MB9107:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a3dfec-adbd-4c0c-357b-08dd73a87665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vVFAxkYvIyeWnjHeEu2cscqPcFts3ky9+3DOq96EensSHQSn5lpZoqJGmiV+?=
 =?us-ascii?Q?CRy0i0U5tNzEwSNLsjJibXblE1YdzBb9xzQ5jUVNPj2a5linH0GBJw2kT6p/?=
 =?us-ascii?Q?Odb5Iyg28OCJMgIzO4UXzkOY0gdEybhGbHjKJ3rT+cwXfr0rGMNe1muv4X1t?=
 =?us-ascii?Q?tQN3LkTnANhMhTXfu36bDzsCej8p/jW948cVYLNW8OnMkS5qSEk527nC/9nB?=
 =?us-ascii?Q?1/t2po4abYCEAjUPRSgldMVS6esut4Wd/9WT6WWRZAlyR16m5qGAUWFBxfMK?=
 =?us-ascii?Q?thDxRDESMLxS7Xp6DbiJ/D5xCpubro97X8+7MUy1oPn92HwUa9yqINDYqUm6?=
 =?us-ascii?Q?UROCXbPq0mozc2pcdV88/BCBpQTEOjYOmVlfsfDh6tKPMYUbbBxudFxot65f?=
 =?us-ascii?Q?nGKtUZGkXNOznUhsscPtol+Az8YquOXFkghhOCq2BNdjpcLYfd4uNSthQrnP?=
 =?us-ascii?Q?23q8hk7d5BXDFxTUO9y0LgJ4mWE8x5orV8LNiXZCTAd1l6C+HyrN1/iRKidY?=
 =?us-ascii?Q?TAOjoVeLdCO+BxqYuKw4Kxd6p/1pTwhTYn4zA1jegi3eVQ/wkhvIQNgFhrHc?=
 =?us-ascii?Q?dNleUdDDA842rydue6sGjZawgAoKoiCQhei8DOD6jXPFaxW2Bfo1mY8+CQHA?=
 =?us-ascii?Q?vnowc/0fJHHMJD+CAIA5aOz16UCpJOqRDacPzSrdogAeKWM/c4W90UJzZaaA?=
 =?us-ascii?Q?3S0wN22KTUSH/XDczXRqWa/rJ+/UkXeZ0Z6C5voY1D02jODpfrkPfEyfxRky?=
 =?us-ascii?Q?RNtu/q14kJcJMC5QGNjWw8PbGw9PZqariiyoBG9VIsRKW0+8M3JoaoZ6TFQa?=
 =?us-ascii?Q?sZARRDiaemAOH2CDnk6pfPm8H2C6dlAmVJO70HhIWzzzILY4ZOj3qqVMU+JP?=
 =?us-ascii?Q?rrAN/L61BtN+yARNmAJaTiGghFAi4ObODy+s/1xDgU7zuvPXdyxD3sVcJ1KO?=
 =?us-ascii?Q?UNNIH+zr0RWlAFUoIs09BjMmpmoZ8JnybitD0HGfAdYaex/IHRRHPtrud0W6?=
 =?us-ascii?Q?6wAscjiCP8Y2Cw52mNsrbPEYy8q/lPX2oVi54Nk2y94ra27HrE6BI2yr+Hu+?=
 =?us-ascii?Q?9cINhVQjhXrMt9JD4rU/xHbckPcNzo9NPJN8LXb2/edCP6mqJSkX/ty1ObaD?=
 =?us-ascii?Q?oo0y8JkRDY8ziXZKlokHSH0kUm5YrswKSTnBRceVGPfrMHnv0pSGPhcSY1lr?=
 =?us-ascii?Q?GhKq0EbpFycIJpM32iNbN2olMiLFtV00wsbfPA4DU7CtphJJnRAcDmZIfLaQ?=
 =?us-ascii?Q?QcrSR/tlPfKxPpQ5D1lw1DMdh8ISrItrfHbr93DeR8ZQFUeLt1bkkePrJ8cZ?=
 =?us-ascii?Q?+lnSalq6yb9wad+dMynmkC0Ou+6mmNcPCNSBrsL5VU5m3W8ybpSfgFuxEoIg?=
 =?us-ascii?Q?BC5ukh0e4fAEhNozVG+lHGhONjNhvYvPpFdiXWs5wwZf2dh00JT9y9BisCkr?=
 =?us-ascii?Q?ITdJE/vriFFhEexAY5wu1i5HsEMPkybvWvtI+YM5mqjQEdoj1Y7cHLLZiGwC?=
 =?us-ascii?Q?JpZyKIIRE2NuDTA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 18:42:33.3272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a3dfec-adbd-4c0c-357b-08dd73a87665
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9107
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

This patch enables the logic where if PSP ring has
initialized then submit the register write command
via ring.

Signed-off-by: Ahmad Rehman <Ahmad.Rehman@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 17 ++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c |  2 +-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index dbc3313fc141..8f34a277c821 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1189,15 +1189,22 @@ int psp_reg_program(struct psp_context *psp, enum psp_reg_prog_id reg,
 	if (reg >= PSP_REG_LAST)
 		return -EINVAL;
 
-	cmd = acquire_psp_cmd_buf(psp);
+	/* Check if psp ring has initialized */
+	if (psp->km_ring.ring_mem && psp->km_ring.ring_size) {
+		cmd = acquire_psp_cmd_buf(psp);
+
+		psp_prep_reg_prog_cmd_buf(cmd, reg, value);
+		ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
+
+		release_psp_cmd_buf(psp);
+	} else {
+		/* Program reg without ring via registers */
+		ret = psp_reg_program_no_ring(psp, value, reg);
+	}
 
-	psp_prep_reg_prog_cmd_buf(cmd, reg, value);
-	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
 	if (ret)
 		dev_err(psp->adev->dev, "PSP failed to program reg id %d\n", reg);
 
-	release_psp_cmd_buf(psp);
-
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 4a43c9ab95a2..05935b2c99b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -208,7 +208,7 @@ static void mmhub_v1_8_init_tlb_regs(struct amdgpu_device *adev)
 				    MTYPE, MTYPE_UC);/* XXX for emulation. */
 		tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ATC_EN, 1);
 
-		psp_reg_program_no_ring(&adev->psp, tmp, PSP_REG_MMHUB_L1_TLB_CNTL);
+		psp_reg_program(&adev->psp, PSP_REG_MMHUB_L1_TLB_CNTL, tmp);
 	} else {
 		inst_mask = adev->aid_mask;
 		for_each_inst(i, inst_mask) {
-- 
2.34.1

