Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAD4CD4F26
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 13:32:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9488310F5DE;
	Fri, 19 Jun 2026 13:32:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gVtEx+Yx";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012044.outbound.protection.outlook.com [52.101.53.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DFA310F5D9
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 13:32:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3gySwfvFBfvdJzkflflsFjQnxaghwZbNI+JcWEMhHZt9TdPW515pVaEXpk4ACGvow4P7hHOzEB13Y4QW5PLdGgLJub1wwe/wp6S7js/Hb7uWliUtMasHeg7WnK8Q+SoaAMpHaIJCGcJb0TAlIBOO+Pb7GPdNkvDs6gT67vL9QPwhArmq3z6T/4+iKk4u8uros68f1wItTSevFLcSUarqeNjPkSjkvfkEFIJnyktzsb8DlPlTJ+gWEtvUTqTL1qZS5s3CuOtMJ5rXY3FikLQe/jcH2Vz9p1/G0l+SvsUIqnJdktHNJJBQY2jCfa+wqAfhGltVjxTIazVgSR1L1NV1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97v49TMkURYz5LvXpCBlrErsM+r42YIXTp0DdzXUVS8=;
 b=N1BKa39iR/ChqhAey/b+qNst79SkepmRFHOUWVyUFMb1/UOPegqo8XS12NGSCuXJkwjwpXpVfAhnVJqIUpXJku7uTz8t+AIMVUAZFmDbgnt8KiUqrkvqJvCsRQk5bhUIesNpGx19ls1v1EcqbgxmiYHpLzGC3R9LbzgYzI17qfeUmAv14kF8OSVNgEYXr9gNG4zd/hsTiapGBtO+jXS6nQqd547SGSleF+OUeTnYnlNNvISIDwPKTaie11FoMH4xQx+YGJMdCb+z7b9E58+cvUvwzdreyL5tR9RgDs+rTjRC9NCPUt2NTv0vKVLbflgLN7WI1osyOD7riH8+WHtRrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97v49TMkURYz5LvXpCBlrErsM+r42YIXTp0DdzXUVS8=;
 b=gVtEx+YxIflsSmBtG6uuwPCqPl+wExXtwi66WLgA4umkgdH2iVHSyNQ9ughBsMvlusbgxPMm5iiWXsrylXN47biN7p1E0Xe4ZGQcwIzJZ/1v9WmMtgfhuSRn7+4yX270nxilKS4mnHNYXIUliAF4mX2NgnWqTNOpgp2jZAZd2Rg=
Received: from BN0PR03CA0022.namprd03.prod.outlook.com (2603:10b6:408:e6::27)
 by SA1PR12MB8093.namprd12.prod.outlook.com (2603:10b6:806:335::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Fri, 19 Jun
 2026 13:32:26 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::4f) by BN0PR03CA0022.outlook.office365.com
 (2603:10b6:408:e6::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Fri,
 19 Jun 2026 13:32:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 13:32:26 +0000
Received: from georzhanmkm (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 08:32:25 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Matthew Stewart <Matthew.Stewart2@amd.com>, "Ovidiu
 (Ovi) Bunea" <ovidiu.bunea@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 09/24] drm/amd/display: Remove DCCG registers not needed in
 DCN42
Date: Fri, 19 Jun 2026 09:21:24 -0400
Message-ID: <20260619133154.116746-10-george.zhang@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619133154.116746-1-george.zhang@amd.com>
References: <20260619133154.116746-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|SA1PR12MB8093:EE_
X-MS-Office365-Filtering-Correlation-Id: 50e821ff-5f17-44dd-6898-08dece0733ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: g2EnJKHgkRVO8CMMnOjDFacobvFznbbKRjKUb9jSAb+9FcC+ngpFmqX1BAh3Bce96LD/S42zlskQpHNQ6YGIDYRUwbNNp8oTTAPXEXG6Ke49aBwqXESkqW6QupsSenFiGNu+fjFgtJ2bZrzsiiNj0TDVSzfYYp+8F3+hox29NfUlUEhpNWGWyc0PMY7FlFlYDmobblvnImMEoHTFsRL1vO9BpMh/+tWO9U95ozlW/xFfN+RBt38CqvmjZkVLxmkjUUVkLN9noVzvjFZwUYNo5QCVndkD6J+Nx1l1mcUPiaWMTkyI1weAqtGcZZFM1LBqqebSgfxphXxwtuc9solW8PtkQPvRK3rpNf9XXrS/4xvDRCFYoj5A3ghKd0cqw/+yo/8MfFg0Vi8zFIa6Wmo9f40CZOAAb5OCHd7xO/spbjlKNOJimby9ByRB0kOj/LkSHN712xZEtwn5w04eg42emeMJHjoL40gpG7WgpbZNtP3auzHPDMFPTeMGGNf5Hc9YkHGV4xuPNxaTnSjJtW0dpoznVGF81+KfdkFAmR35/cRnmyl7yPFA7/D/hedY7pY07xOtbiQI/+aa7Nm7xpr+HUiZghqBtP7vwU3QaXeHLY7MMpM9IdxgASqiSwFVNo4SJy8ipQtbirQnH6LciXtq42ieqX5IW/LamCgOJ3NECu+UDhgiRf30J+Qb+piZ+fPD4IWH4hjrMKuBdGmxNKTcTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zR2YXocYSG9xgaX4Ovzr5lkKb169LAIZzmR9v8E1jKzDqOinQlhq3aRGi8pg/wloSmwrT2uG9FZxvOux+1/TG6C5hWGuHdm76VaW7KvLTNgGT2iDN4vEAjMJ6CSNHorfqrYwhp7CKCqBwlpeYdtUUjbyk1JcNwWXNvO9MUpgi5fuHpnCFaP8YkJgiBZPgd5Rxj/+yrhahnC+e2GQZKcSUa+F8HpjToHA08PkiBnNmw0jN8dBy6eStKP7GbDb9FtaCa7Ew2tZU53D5qwH7MtxF5GlXrkvvIBM0nLOw/KTsIb+1aiUCkTcTowrnCaP6sqC5A6wuWx/BkCnQWne7UPgdPXl3J3IHuQZJvwx+01aIriiBdStOQ4d9YJgg67Km3bV0ool1RSBaG75nP8OZAvp+j5QlMYds46u6vuOUy4m3WbCVTd83VP65O71FGfaxbSy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:32:26.2025 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e821ff-5f17-44dd-6898-08dece0733ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8093
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

From: Matthew Stewart <Matthew.Stewart2@amd.com>

[why]

Some resources that exist in the DCN block are not needed and shouldn't
be used.

[how]

Remove defines from register lists.

Reviewed-by: Ovidiu (Ovi) Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Matthew Stewart <Matthew.Stewart2@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.h    | 62 +++++++++----------
 1 file changed, 30 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h
index d45e3af77aad..a2b17ed11bdb 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h
@@ -57,34 +57,24 @@
 	DCCG_SF(PHYBSYMCLK_CLOCK_CNTL, PHYBSYMCLK_SRC_SEL, mask_sh),\
 	DCCG_SF(PHYCSYMCLK_CLOCK_CNTL, PHYCSYMCLK_EN, mask_sh),\
 	DCCG_SF(PHYCSYMCLK_CLOCK_CNTL, PHYCSYMCLK_SRC_SEL, mask_sh),\
-	DCCG_SF(PHYDSYMCLK_CLOCK_CNTL, PHYDSYMCLK_EN, mask_sh),\
-	DCCG_SF(PHYDSYMCLK_CLOCK_CNTL, PHYDSYMCLK_SRC_SEL, mask_sh),\
 	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK0_EN, mask_sh),\
 	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK1_EN, mask_sh),\
 	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK2_EN, mask_sh),\
-	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK3_EN, mask_sh),\
 	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK0_SRC_SEL, mask_sh),\
 	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK1_SRC_SEL, mask_sh),\
 	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK2_SRC_SEL, mask_sh),\
-	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK3_SRC_SEL, mask_sh),\
 	DCCG_SF(HDMISTREAMCLK_CNTL, HDMISTREAMCLK0_EN, mask_sh),\
 	DCCG_SF(HDMISTREAMCLK_CNTL, HDMISTREAMCLK0_SRC_SEL, mask_sh),\
 	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE0_SRC_SEL, mask_sh),\
 	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE1_SRC_SEL, mask_sh),\
 	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE2_SRC_SEL, mask_sh),\
-	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE3_SRC_SEL, mask_sh),\
 	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE0_EN, mask_sh),\
 	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE1_EN, mask_sh),\
 	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE2_EN, mask_sh),\
-	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE3_EN, mask_sh),\
 	DCCG_SF(SYMCLK32_LE_CNTL, SYMCLK32_LE0_SRC_SEL, mask_sh),\
 	DCCG_SF(SYMCLK32_LE_CNTL, SYMCLK32_LE1_SRC_SEL, mask_sh),\
-	DCCG_SF(SYMCLK32_LE_CNTL, SYMCLK32_LE2_SRC_SEL, mask_sh),\
-	DCCG_SF(SYMCLK32_LE_CNTL, SYMCLK32_LE3_SRC_SEL, mask_sh),\
 	DCCG_SF(SYMCLK32_LE_CNTL, SYMCLK32_LE0_EN, mask_sh),\
 	DCCG_SF(SYMCLK32_LE_CNTL, SYMCLK32_LE1_EN, mask_sh),\
-	DCCG_SF(SYMCLK32_LE_CNTL, SYMCLK32_LE2_EN, mask_sh),\
-	DCCG_SF(SYMCLK32_LE_CNTL, SYMCLK32_LE3_EN, mask_sh),\
 	DCCG_SFII(OTG, PIXEL_RATE_CNTL, PIPE, DTO_SRC_SEL, 0, mask_sh),\
 	DCCG_SFII(OTG, PIXEL_RATE_CNTL, PIPE, DTO_SRC_SEL, 1, mask_sh),\
 	DCCG_SFII(OTG, PIXEL_RATE_CNTL, PIPE, DTO_SRC_SEL, 2, mask_sh),\
@@ -122,7 +112,6 @@
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYASYMCLK_ROOT_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYBSYMCLK_ROOT_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYCSYMCLK_ROOT_GATE_DISABLE, mask_sh),\
-	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYDSYMCLK_ROOT_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GLOBAL_FGCG_REP_CNTL, DCCG_GLOBAL_FGCG_REP_DIS, mask_sh),\
 	DCCG_SFII(OTG, PIXEL_RATE_CNTL, DP_DTO, ENABLE, 0, mask_sh),\
 	DCCG_SFII(OTG, PIXEL_RATE_CNTL, DP_DTO, ENABLE, 1, mask_sh),\
@@ -135,7 +124,6 @@
 	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK0_EN, mask_sh),\
 	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK1_EN, mask_sh),\
 	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK2_EN, mask_sh),\
-	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK3_EN, mask_sh),\
 	DCCG_SF(DSCCLK0_DTO_PARAM, DSCCLK0_DTO_PHASE, mask_sh),\
 	DCCG_SF(DSCCLK0_DTO_PARAM, DSCCLK0_DTO_MODULO, mask_sh),\
 	DCCG_SF(DSCCLK1_DTO_PARAM, DSCCLK1_DTO_PHASE, mask_sh),\
@@ -148,36 +136,26 @@
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, SYMCLKA_FE_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, SYMCLKB_FE_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, SYMCLKC_FE_GATE_DISABLE, mask_sh),\
-	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, SYMCLKD_FE_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, SYMCLKA_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, SYMCLKB_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, SYMCLKC_GATE_DISABLE, mask_sh),\
-	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, SYMCLKD_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYASYMCLK_ROOT_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYBSYMCLK_ROOT_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYCSYMCLK_ROOT_GATE_DISABLE, mask_sh),\
-	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYDSYMCLK_ROOT_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_SE0_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_SE1_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_SE2_GATE_DISABLE, mask_sh),\
-	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_SE3_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_LE0_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_LE1_GATE_DISABLE, mask_sh),\
-	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_LE2_GATE_DISABLE, mask_sh),\
-	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_LE3_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_SE0_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_SE1_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_SE2_GATE_DISABLE, mask_sh),\
-	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_SE3_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_LE0_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_LE1_GATE_DISABLE, mask_sh),\
-	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_LE2_GATE_DISABLE, mask_sh),\
-	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_LE3_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL4, HDMICHARCLK0_ROOT_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL4, PHYA_REFCLK_ROOT_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL4, PHYB_REFCLK_ROOT_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL4, PHYC_REFCLK_ROOT_GATE_DISABLE, mask_sh),\
-	DCCG_SF(DCCG_GATE_DISABLE_CNTL4, PHYD_REFCLK_ROOT_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DTBCLK_P0_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DTBCLK_P1_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DTBCLK_P2_GATE_DISABLE, mask_sh),\
@@ -185,19 +163,15 @@
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, SYMCLKA_FE_ROOT_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, SYMCLKB_FE_ROOT_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, SYMCLKC_FE_ROOT_GATE_DISABLE, mask_sh),\
-	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, SYMCLKD_FE_ROOT_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, SYMCLKA_ROOT_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, SYMCLKB_ROOT_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, SYMCLKC_ROOT_GATE_DISABLE, mask_sh),\
-	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, SYMCLKD_ROOT_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DPSTREAMCLK0_ROOT_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DPSTREAMCLK1_ROOT_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DPSTREAMCLK2_ROOT_GATE_DISABLE, mask_sh),\
-	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DPSTREAMCLK3_ROOT_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DPSTREAMCLK0_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DPSTREAMCLK1_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DPSTREAMCLK2_GATE_DISABLE, mask_sh),\
-	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DPSTREAMCLK3_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL6, DSCCLK0_ROOT_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL6, DSCCLK1_ROOT_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL6, DSCCLK2_ROOT_GATE_DISABLE, mask_sh),\
@@ -209,26 +183,38 @@
 	DCCG_SF(SYMCLKA_CLOCK_ENABLE, SYMCLKA_CLOCK_ENABLE, mask_sh),\
 	DCCG_SF(SYMCLKB_CLOCK_ENABLE, SYMCLKB_CLOCK_ENABLE, mask_sh),\
 	DCCG_SF(SYMCLKC_CLOCK_ENABLE, SYMCLKC_CLOCK_ENABLE, mask_sh),\
-	DCCG_SF(SYMCLKD_CLOCK_ENABLE, SYMCLKD_CLOCK_ENABLE, mask_sh),\
 	DCCG_SF(SYMCLKA_CLOCK_ENABLE, SYMCLKA_FE_EN, mask_sh),\
 	DCCG_SF(SYMCLKB_CLOCK_ENABLE, SYMCLKB_FE_EN, mask_sh),\
 	DCCG_SF(SYMCLKC_CLOCK_ENABLE, SYMCLKC_FE_EN, mask_sh),\
-	DCCG_SF(SYMCLKD_CLOCK_ENABLE, SYMCLKD_FE_EN, mask_sh),\
 	DCCG_SF(SYMCLKA_CLOCK_ENABLE, SYMCLKA_FE_SRC_SEL, mask_sh),\
 	DCCG_SF(SYMCLKB_CLOCK_ENABLE, SYMCLKB_FE_SRC_SEL, mask_sh),\
-	DCCG_SF(SYMCLKC_CLOCK_ENABLE, SYMCLKC_FE_SRC_SEL, mask_sh),\
-	DCCG_SF(SYMCLKD_CLOCK_ENABLE, SYMCLKD_FE_SRC_SEL, mask_sh)
+	DCCG_SF(SYMCLKC_CLOCK_ENABLE, SYMCLKC_FE_SRC_SEL, mask_sh)

 #define DCCG_MASK_SH_LIST_DCN42(mask_sh) \
 	DCCG_MASK_SH_LIST_DCN42_COMMON(mask_sh),\
+	DCCG_SF(PHYDSYMCLK_CLOCK_CNTL, PHYDSYMCLK_EN, mask_sh),\
+	DCCG_SF(PHYDSYMCLK_CLOCK_CNTL, PHYDSYMCLK_SRC_SEL, mask_sh),\
 	DCCG_SF(PHYESYMCLK_CLOCK_CNTL, PHYESYMCLK_EN, mask_sh),\
 	DCCG_SF(PHYESYMCLK_CLOCK_CNTL, PHYESYMCLK_SRC_SEL, mask_sh),\
 	DCCG_SF(HDMISTREAMCLK0_DTO_PARAM, HDMISTREAMCLK0_DTO_PHASE, mask_sh),\
 	DCCG_SF(HDMISTREAMCLK0_DTO_PARAM, HDMISTREAMCLK0_DTO_MODULO, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYDSYMCLK_ROOT_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYESYMCLK_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, SYMCLKD_FE_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, SYMCLKD_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DSCCLK3_DTO_PARAM, DSCCLK3_DTO_PHASE, mask_sh),\
 	DCCG_SF(DSCCLK3_DTO_PARAM, DSCCLK3_DTO_MODULO, mask_sh),\
-	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYESYMCLK_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_SE3_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_LE2_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_LE3_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_SE3_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_LE2_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_LE3_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, SYMCLKD_FE_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, SYMCLKD_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DPSTREAMCLK3_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DPSTREAMCLK3_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL4, PHYD_REFCLK_ROOT_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL4, PHYE_REFCLK_ROOT_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, SYMCLKE_FE_ROOT_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, SYMCLKE_ROOT_GATE_DISABLE, mask_sh),\
@@ -237,10 +223,22 @@
 	DCCG_SF(SYMCLKB_CLOCK_ENABLE, SYMCLKB_SRC_SEL, mask_sh),\
 	DCCG_SF(SYMCLKC_CLOCK_ENABLE, SYMCLKC_SRC_SEL, mask_sh),\
 	DCCG_SF(SYMCLKD_CLOCK_ENABLE, SYMCLKD_SRC_SEL, mask_sh),\
+	DCCG_SF(SYMCLKD_CLOCK_ENABLE, SYMCLKD_CLOCK_ENABLE, mask_sh),\
+	DCCG_SF(SYMCLKD_CLOCK_ENABLE, SYMCLKD_FE_EN, mask_sh),\
+	DCCG_SF(SYMCLKD_CLOCK_ENABLE, SYMCLKD_FE_SRC_SEL, mask_sh),\
 	DCCG_SF(SYMCLKE_CLOCK_ENABLE, SYMCLKE_SRC_SEL, mask_sh),\
 	DCCG_SF(SYMCLKE_CLOCK_ENABLE, SYMCLKE_CLOCK_ENABLE, mask_sh),\
 	DCCG_SF(SYMCLKE_CLOCK_ENABLE, SYMCLKE_FE_EN, mask_sh),\
-	DCCG_SF(SYMCLKE_CLOCK_ENABLE, SYMCLKE_FE_SRC_SEL, mask_sh)
+	DCCG_SF(SYMCLKE_CLOCK_ENABLE, SYMCLKE_FE_SRC_SEL, mask_sh),\
+	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE3_SRC_SEL, mask_sh),\
+	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE3_EN, mask_sh),\
+	DCCG_SF(SYMCLK32_LE_CNTL, SYMCLK32_LE2_SRC_SEL, mask_sh),\
+	DCCG_SF(SYMCLK32_LE_CNTL, SYMCLK32_LE3_SRC_SEL, mask_sh),\
+	DCCG_SF(SYMCLK32_LE_CNTL, SYMCLK32_LE2_EN, mask_sh),\
+	DCCG_SF(SYMCLK32_LE_CNTL, SYMCLK32_LE3_EN, mask_sh),\
+	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK3_EN, mask_sh),\
+	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK3_SRC_SEL, mask_sh),\
+	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK3_EN, mask_sh)


 void dccg42_otg_add_pixel(struct dccg *dccg,
--
2.54.0

