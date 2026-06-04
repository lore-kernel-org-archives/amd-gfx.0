Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B668CCD6E77
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 14:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F98E112848;
	Thu,  4 Jun 2026 14:55:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kxv9Vj1W";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011043.outbound.protection.outlook.com [40.107.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F6F1112851
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 14:55:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/HATCz9PZ1uQUIOoHqgBADu2FDkyP5kd3LCv8UjvC3Wv6nykxHjwvHHKSMgz5oWH7sE3DiU6aRxvyreSZHqJzm2CFccBQnDvUnqov3dZ4v3r0BWOuc+/aJXi2uf+L1llGlUQF9nMFZ3C2erxFvgNIK4eoUzuk7alW/YtrXFM01iKkJ5zMuaY5B16DaLozPDFFhxDMaTqpPQELwm1OKx0gPUe/qWVRwjlFMiSaYTucGA8e+2Y458ddPZ43hYEDyqoHksM13RMXS2VEToUXffaJkXESLY30hW1KzLhXPz3rSkqazL6qX5dknNGhW43fX2MfPQgwRcm0d9Be0UfiEruQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3WpWmD72l177eDmZq7liq83w/oKgniuBHjGyjBgUTg=;
 b=x2helRNp51Wbqv8Uk+VhOTNkVElEzFZiCOnG/4dax3ZsaE1L9Tm0IMME9+MiTccF9rBpABtHgQ8ClVKYYgxy+7M11edyQhamUgOmL1bdGZ9e5ABkXMvIzo3Ods83zVKS3JoMoGTbHE4sGxUTi8OOXCWahyZwBxyCXS8lGg4PumjZPjFxaXAmTMcn9Q91W6eqR467enKS4bUqqx7iTp23juImidLNowSH2MhbSHO9l8Sp+t0eWi41IyAZ0Cntbb1Py1tGy10hX/QEuNsl4PkenA14z5XHZUoMvCU/MVc/WBaCfzdGiD1KBAAqLpgFsanmeumH9xJNRGHjbffw5lmCjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3WpWmD72l177eDmZq7liq83w/oKgniuBHjGyjBgUTg=;
 b=kxv9Vj1WL/Czt6ehL21EgwAxfPUKNn0Oi/u8ZC//SMeEVdCToWny2KDsc79yIF8bVHP1j/zgYxFUTGgbb0R0XgE0ddSgmF5oYz/qX1NukYBZLjHNwpOtubAy6qo8piGYlrfPvF9C/DLfX8/FfBSwoQqU4UK1rW8LTbv6UT3eBe4=
Received: from BN0PR07CA0014.namprd07.prod.outlook.com (2603:10b6:408:141::7)
 by SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 14:54:57 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:141:cafe::50) by BN0PR07CA0014.outlook.office365.com
 (2603:10b6:408:141::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 14:54:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 14:54:57 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:54:49 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 07:54:49 -0700
Received: from aaurabin-tumbleweed.king-squeaker.ts.net (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 4 Jun 2026 09:54:48 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Subject: [PATCH 07/24] drm/amd/display: fix max dispclk_khz/dppclk_khz double
 1000
Date: Thu, 4 Jun 2026 10:52:01 -0400
Message-ID: <20260604145428.809959-8-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604145428.809959-1-aurabindo.pillai@amd.com>
References: <20260604145428.809959-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|SA3PR12MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ecec67-0704-46e8-6613-08dec2493f06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|20052099010|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Dv5c15l+M6BUAgsKsC2UJAeSWv0iN2R8N3FtyTrXno7t8bnaD9eOVUMJMmU+Fs/Bq42nHjAMUlIxcz7gGkuJHGqewhcrLKLERfsgdA6ICJk/jTrrKoOkaWA+/CP7p/bEKZXfnXpn9Ud9GcLMpH5K8oHDPFEaFbfue+EuCx61m7b6aOMARVAnoY+YJr1NnMhfoJMT8aQAADIFpTw1/hWGnxTJs8dzRoh7Hqf/wfDqHO3sBDzRwr9JhitqMsRx4dIOVchkppCGrnW7EBlIJ2djl4GyRuwY6uGwG2T1ylMpVD2eUUqtefHAd/MhXbUgBgaAkrnufBKH+cXGfIQEdKwSA/eTNoYfdubghWRd6KdJAm8kTi0xAZ32dYs4M5SFUpfmKJ9HWvWD64ypmhd6XmmtRX+JrlACTi5MajFzwXqsOZTaUTY7UCuFrCl0sZSfSJlvz1VBr15j+cU7vusF5d29h/YC/5igIwifUDGs9w2v4b17H6fhusbPLZjRo8alYrOoDPMA4bMh2jeyz6pw7mi+nD7x5fw9JTqbvAINVaC3eTZs5xgLrRVl3k/Gr8t4O85Ga/oKGDeyY0hLaPG8TFcpa2i/McMxla54QL14QTixwXat0qg67PeNUzS6e+qImr9X2p2ia0wbkDqNsEiQ6KKqL1EhCQhEECXNic5+DNEJFTH6sbsbAdghJ+OAEKGz0cU/JgKxPrxAeYrCR9DWNCipWwy/SseoVPHttORdgxDj5xo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(20052099010)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f9f0fXN64KBTNOtcdnubMfdIwc0I2qDTJymeuwsQPWraR/AjM5jdpoBK5xFu/sCRyEgBqjsaUORNzrNBEbnfFjz6BnB9+XVCmkNCPkO/5fOBoRw4ZnLvf0zIUA3e8Ff7eQojLR0+t+Yn++54aOzBA2BHqJnHQnvXwahAr4G6Oqff2jFfaf9bw/0vtC/C4XVlFQ7O5OcKkkyIQb7Z4+6k3/PRnbhY5XR9DEleG+8LRJcL6yWW/H30ljjiANEc6Mf9mk8jL/NiITwlp/8bErJdzju85ulQuQtl/GDvA3sXvvbEJAt2lJWn80+k2HcGkjJVXFicpYfFD54fxtgGMepCrPhzyn7Crj/4n26xQMlNQCttxaiMxVOvnMLA/PDBp9BE0DT/0zQkFlYhHBUS2OS5H6r8LbiRJBsVoy0NEHE1R95USQqdWtGkdc3ubBOj/wti
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 14:54:57.8577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ecec67-0704-46e8-6613-08dec2493f06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
Fix regresson caused by double roundup and index out of range

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Reviewed-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c   | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
index de40d7bae252..11fc0b1cd152 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
@@ -118,16 +118,16 @@ static void dml21_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_sta
 	context->bw_ctx.bw.dcn.clk.bw_dispclk_khz = context->bw_ctx.bw.dcn.clk.dispclk_khz;
 	if (in_ctx->v21.dml_init.soc_bb.clk_table.dispclk.num_clk_values > 1) {
 		context->bw_ctx.bw.dcn.clk.max_supported_dispclk_khz =
-			in_ctx->v21.dml_init.soc_bb.clk_table.dispclk.clk_values_khz[in_ctx->v21.dml_init.soc_bb.clk_table.dispclk.num_clk_values] * 1000;
+			in_ctx->v21.dml_init.soc_bb.clk_table.dispclk.clk_values_khz[in_ctx->v21.dml_init.soc_bb.clk_table.dispclk.num_clk_values - 1];
 	} else {
-		context->bw_ctx.bw.dcn.clk.max_supported_dispclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.dispclk.clk_values_khz[0] * 1000;
+		context->bw_ctx.bw.dcn.clk.max_supported_dispclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.dispclk.clk_values_khz[0];
 	}
 
 	if (in_ctx->v21.dml_init.soc_bb.clk_table.dppclk.num_clk_values > 1) {
 		context->bw_ctx.bw.dcn.clk.max_supported_dppclk_khz =
-			in_ctx->v21.dml_init.soc_bb.clk_table.dppclk.clk_values_khz[in_ctx->v21.dml_init.soc_bb.clk_table.dppclk.num_clk_values] * 1000;
+			in_ctx->v21.dml_init.soc_bb.clk_table.dppclk.clk_values_khz[in_ctx->v21.dml_init.soc_bb.clk_table.dppclk.num_clk_values - 1];
 	} else {
-		context->bw_ctx.bw.dcn.clk.max_supported_dppclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.dppclk.clk_values_khz[0] * 1000;
+		context->bw_ctx.bw.dcn.clk.max_supported_dppclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.dppclk.clk_values_khz[0];
 	}
 
 	/* get global mall allocation */
-- 
2.54.0

