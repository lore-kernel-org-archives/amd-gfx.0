Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666FCC982D0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF54610ED1D;
	Wed, 16 Sep 2026 17:53:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VtRXGr/5";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010039.outbound.protection.outlook.com
 [40.93.198.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFD4810EBD2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wI83nCkKjySpgLlKtsEVo9onN+6ZNNhdgtvTqonFS5ulvJbjqQOzuzgF0qNhdwSQ9wshrKzfDDYHq0KkTY1f+iVUU25HkPiTpX1OGXGRdpEoBTR1pvsYKIolOzNN2nVyEyokL3ZYCDirECgxG3Wud8kAQ55vBMOLadIf2M+pCaS5grZRT47CWNBK0aWVzs57aMdrazV5KjtILPPBxFM6CJIvO5eR2pHcQpuuTLDCDFeiXoxEUrL8FJjFHOOsIH28yzmIqgY/dJRgRZnw7ThCyAZXmHJB3ZdSXl6dlg4zga3gKe/ClMLNZUsIwdJGyrB+oEhquu/ihKkvuKQZdhNG4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUzr5luD40WHrXY4f5xs9wwBe2vcN2jP/4jt8wwMZI0=;
 b=ly0BMvmjW5QnJPa4hNhjlGd4iRpHRH100p2glJjFxAEbSpYdN6XPVy5lMPlRkXYo/AxslId0OmwCpuPMyPIjR0vTwhRMKxLA03SL/LHFPQ1kV3qaqveRz7P4Q0P6esxQ+H65/PU4i7kQaxwbBp1lb5tknlvT6dVn31jZLJzpv4R+cPrtWhSRg3hbNmgKpH05k1lhAUMDOcc6NfxN20u1FAdDq+WoQIOe807L0pEwtqdZC/NJ2h64ClEAkL4zK8vR/AbT47Oen1mZcFV229ckiXK0OeERw0G59bYbg7hpEv8NU9OtVdgF8WqnYywWr1AyFN3812nHWsQmMopy6TxQdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUzr5luD40WHrXY4f5xs9wwBe2vcN2jP/4jt8wwMZI0=;
 b=VtRXGr/5m5x9STiRIpthvIFG/kxXXpdjuIlQK50BO3lJnNQGQiMMh0XSRMbO1zGqG5dOMVqLL9QYmX9TVWUgVTDZvKVT/zDiVi8///G6F3cW3L2gB26DK6FY+GFU/1aExQSW/MazbUgCJJztqPdLGwjGQ+Dm2jhDU5QHJmuSbak=
Received: from CH2PR10CA0009.namprd10.prod.outlook.com (2603:10b6:610:4c::19)
 by CH3PR12MB9170.namprd12.prod.outlook.com (2603:10b6:610:199::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 17:53:12 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::13) by CH2PR10CA0009.outlook.office365.com
 (2603:10b6:610:4c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.11 via Frontend Transport; Wed,
 16 Sep 2026 17:53:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:53:12 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:53:01 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Qi <Haoming.Qi@amd.com>, George Zhang
 <george.zhang@amd.com>
Subject: [PATCH 61/64] drm/amd/display: Revert "request DMUB HW cursor offload"
Date: Wed, 16 Sep 2026 13:52:16 -0400
Message-ID: <20260916175301.368306-62-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|CH3PR12MB9170:EE_
X-MS-Office365-Filtering-Correlation-Id: 290d989f-0e5e-48e3-8a07-08df141b6046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: z2dCDwbyPnwsl3RLOm41ypMj+qgfJgm247WfLmGBzoJ+0o0uF5cN/Uka8ZliHyyh40BZ3czyp1xyfUyuwxIN3AeMpuVb0r5Q6fkpjTU11E2EChqGnCXLHA47NE8AOf42nsJFjeoow7UhmL7VExteEHESjno6t/NBbKEB+qi6/k7yQZ1llnHXetElD9IPkBT/sq07K6tcUYwMnDC3mtg4W9TTzYrcYtUJFZELnG4FbhWn4RyBunQby7IAAJI+B88O4HT/Hasqoty5W6w8O8J1SXqyHHxQAbLh72I4RZ7/OQZIopEFbK3t9/AEhXBLh2fwN8eWV1vAQ1HwECAuL+fbsPhoj8cEgmc7zLdvFJmPukY0Vb1x8JsVQQncadIN5iXzw8J7KBPGOfPuAMxL2eg/ZhsndEqJ103NfRp0cFYfGe9qWDQ1rSp52k0mYuW2qfLpVDeCFwQIa7crnEBEzgUEAqpXw5ZVcNosJT+31faRZQp43Kj3St8Y7ZMguGEJt/87/BroG//u6CKRWx9VlxFbWSheEvPxNZf9X5huApIhSPDx0iBekR4NwP/zZfyOjYpHe7FOcAoNJlWQeZlbGc8wDFAcGAAIJqaZKedOv7BGNyFpgui1kuPA7ckoiHX6u2F19iNjyQuEGfyHOJaRupKx08D9p/9LSjL+1cLEf9wBfXAQTnoDPRjtgoE/AAiasOd5HEtm1P9wcC0NvY/HGNKWmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OA50217CMek73GfesR6n3oVcL30A1sG0yG34C29zDC0r4n+xXiYNnj/VmGxT7GCrEnqiQOCuajMnUJCm7CdgfEt+uu+qYh2EGIPyQ69jOX3wmYBH5pHJB3vA95kHFDSHqrlSUf5xxvrNBoYHLjY1ypjVBa4ZGboOUIAtL2fX9mUSzwge2Do/nM8Ai1abcmiBNpyz2V5YBLlS2eVdh0ns2GniqM423D2L68f6Jt3+X8x98yxE5fosgfuWVPbp05REf8YNibjNg3utNqNATfXza1pU0jPPJEoBVA6ynlYDmpEfeT3tp2Oa100U9/sQqPCKp94Zd5UEU/BN0XZGyb9DssC6caUrXqofGG0Gi+sWnbkoHj24hmgTO5lmSCgYxuPdr1KDTSR/o7g5yVsrb0wkd0vl+3Y295gsXF622Nac9typg9ZxO17rYf87F6ITETBM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:53:12.1491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 290d989f-0e5e-48e3-8a07-08df141b6046
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9170
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

From: Tony Qi <Haoming.Qi@amd.com>

This reverts commit 6624a33b3807 ("Request DMUB HW cursor offload).

[WHY]
This commit causes the following failures on DCN42:

igt@kms_plane_cursor@viewport
igt@kms_plane_cursor@overlay

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tony Qi <Haoming.Qi@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ----------
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c      |  9 +--------
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ca795cda8084..623ef81a0231 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -606,13 +606,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	init_data.flags.enable_mipi_converter_optimization = true;
 
-	/*
-	 * Request HW cursor offload so DMUB programs the cursor; cursor
-	 * updates then avoid the DMUB inbox0 HW lock during mclk switches.
-	 * dc_dmub_srv_cursor_offload_init() self-gates on FW capability.
-	 */
-	init_data.flags.enable_cursor_offload = true;
-
 	init_data.dcn_reg_offsets = adev->reg_offset[DCE_HWIP][0];
 	init_data.nbio_reg_offsets = adev->reg_offset[NBIO_HWIP][0];
 	init_data.clk_reg_offsets = adev->reg_offset[CLK_HWIP][0];
@@ -730,9 +723,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	dc_hardware_init(adev->dm.dc);
 
-	/* Enable cursor offload if the DMUB firmware supports it. */
-	dc_dmub_srv_cursor_offload_init(adev->dm.dc);
-
 	/* GOP/vBIOS may leave an OPTC enabled for a display present at power-on
 	 * but no longer driven (e.g. an external DP unplugged at boot). Such a
 	 * dangling pipe keeps DCN out of idle and blocks s0i3. Power it down
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 37248ecc3c08..d9af53f720f7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1250,16 +1250,9 @@ void dc_dmub_srv_subvp_save_surf_addr(const struct dc_dmub_srv *dc_dmub_srv, con
 void dc_dmub_srv_cursor_offload_init(struct dc *dc)
 {
 	struct dmub_rb_cmd_cursor_offload_init *init;
-	struct dc_dmub_srv *dc_dmub_srv;
+	struct dc_dmub_srv *dc_dmub_srv = dc->ctx->dmub_srv;
 	union dmub_rb_cmd cmd;
 
-	if (!dc || !dc->ctx)
-		return;
-
-	dc_dmub_srv = dc->ctx->dmub_srv;
-	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
-		return;
-
 	if (!dc->config.enable_cursor_offload)
 		return;
 
-- 
2.55.0

