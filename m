Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EBCCD4F26
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 13:32:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C85AD10F5F3;
	Fri, 19 Jun 2026 13:32:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S1/L5Qlt";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012045.outbound.protection.outlook.com
 [40.107.200.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D749D10F5EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 13:32:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bB0ykIkTUff+X0NCjfC+pTlIF0Y21HxDXBgwzrD7KBo2iCMpKFX8s7Wj1j94gjBLqoJfrjWdcjnoBR39tiVByID2VQ3WpsRekmkwSM1BwmB31OCUFaKf8HDthlXNv1l6oyNhOmWNWTsbJylL720ZIKBFQof8pI5AmDpVNJk8whERWCorRZ63nZz+IboT3gRZ8+CaXO2mrgzSqcLfyo9/rlzQkjNfCnbuPOIaLZq30UF4/KympIBVsBoH160SBi0U+TbMV041VQKkjLhR5AP0n+/QfOSWWwKRUmqfrgVatHfbRY1k6wWMv3Te8gWeubx5WYBW2Bz8DUNz6vlkWknTLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgWiC3iHpvXvKoQZOPn6RAnbDVRqZNxiv9+2PapdNsw=;
 b=XltXaG3FSiE9Ep5EHTUq6taHNtHcjKWIHNQptahVFaH9HMdYk3enrPu/SsvYfA5KNjrUS4OHQiPHJnWbxc3W6jbd6WcCDtlOWdkAZShhzySuRg4+PsAXGHVc8dHf85abEOeA3CZ7XzDbWHgM9pgoNDyjinRkomVuI4KyFeDtgb0dWDKFghVU3WKv13/TRWfoLVxSAc7Kdh3KQxGwVEceYbHLfPIYIpw2fUnp3ioFaVBnLpqPW/ljEn8qDTFAd60Tqb/PjNRbdHCYTHHBzjBCpJOGeFjN9/Z5EKmmI74mgGX+4ESKlfh1S2DUoD2lqi4en7nIiDFoiRupSwieEA178g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgWiC3iHpvXvKoQZOPn6RAnbDVRqZNxiv9+2PapdNsw=;
 b=S1/L5QltibdnkKC1z9XYWCbD2IYefkKG0w/JSCYYoMOH/2uQD9g/0FW9NCch/ERqOrWZxWE5PUQrFRtGODlLXfQwDd93BL4VhrPhsSPOEU+A9ORo+IhHhwRmdVZxddGqHcxf3FIVPvFvLDp7odgLZFve/eyGsuEz+dpb1m4SgfA=
Received: from BLAPR03CA0105.namprd03.prod.outlook.com (2603:10b6:208:32a::20)
 by DS5PPFA3734E4BA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65c)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Fri, 19 Jun
 2026 13:32:36 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::62) by BLAPR03CA0105.outlook.office365.com
 (2603:10b6:208:32a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Fri,
 19 Jun 2026 13:32:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 13:32:36 +0000
Received: from georzhanmkm (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 08:32:33 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Leo Chen <leo.chen@amd.com>, "Ovidiu (Ovi) Bunea"
 <ovidiu.bunea@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 20/24] drm/amd/display: Refactor Driver PG's skip PG logic
Date: Fri, 19 Jun 2026 09:21:35 -0400
Message-ID: <20260619133154.116746-21-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|DS5PPFA3734E4BA:EE_
X-MS-Office365-Filtering-Correlation-Id: fd064756-26fc-4ba4-723b-08dece0739af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: JEhqIDhVPCit/BL35SSoqNdGqf30MWrOfFpazqiXK64UJjzRdzNJCnTfur42FlubOqILQmAVGGkdkqjX19ARVT4ou9ECGGZ59eNGAWAz0UvrT+0Np3vjqTIPuzv8SIBQoduBHU3QXQuUQ3GP9pCdz2Pu6VT1iC3zT9WUDKcijnysMMAbjo91k1kbBwHM1zoJX7GMNL4OghuOvGImAdk3GPI1q0yG9umiNCX/lz7VbjELs3pE6GjzTKuLZ4QcEOnLYhbfJd9lOUJe+lkRp2Go62I3/5ibg+ZYGEKM58HibNh2il8gffz4w96r7bov2LHgMtU72YDq6Y7v+Lbhttxc+e4KKaVm7qpZ0RsGmLHcl/scuvBpqJdJX/+7ug++x/m/e4/k2+Z7PTiwi7PVag+342J4sdvsv0kg54PVV70rn2rc4H5z4aH/pc1QVcp35DAZ6zZA6sV1xq6vBs4Jc2otQ5F/eljC74SFrRs7V3+guUB+juebnZURNzw1RJz9ldohnBpgcjywJMOLXbKuxZ4nIIZssF6sau8Fq3+TjadqDLkNYBUvajWZKXDdgNKmZzMZVoGpZZF69w17WoDYZ8InunHrNYwtn4qt0DY7iqBGJpGNog2N07JwdvojPpQwc0qHdUnjIK+xdmkBqnXHTGrrJmHmIbOuaQuXYYAK4qYeUaxGDsb7AxJiZ6WDI49acWCYK5LaCwoKpdjEUdTWog4GiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ANMG8/eaBv5k4rQbx0BKLe3ZIu1+V998kH0lx5nQXITnJtiz+iEVCCJge7ar23zX7dXacZxu8athkKWCQaYE9SGueJfhNujN0rlilprXGcT+dRVmn0DfJ3MiYY29kkUXPMvuaqk5feQ7D0i6RoTJaUvX/NhBSehUcgRsHApsEstB5vm+KFB2ZHEovRb7yOddDjVT0/x+66LbBK2HQlFvuUz83ja0/qr+cbFa9XUuxacrEyV/+d4AN6HILVuNEYvcSIqi+4ft54cnTaR5N1W2J4rmCRaYUxXSbtHg62W7SbxFibOxEbrKq8NzCcRPyJyWYO61WJPK/n1zM3PXHrX7u3EErKPkUh8fkDmU2wsLFREyW6gWJBvft/XtpwrKb41AcUy5w4IpvqVU45Iebrzyc32P6dEkXmvDcq8wd0BADUXn7qPYq3kCW/8hNLbNPnUW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:32:36.0657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd064756-26fc-4ba4-723b-08dece0739af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA3734E4BA
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

From: Leo Chen <leo.chen@amd.com>

[Why & How]
When driver allows idle optimization, no HW state should be modified further
by DC. Refactor the skip PG logic in pg_cntl in DCN42.

Reviewed-by: Ovidiu (Ovi) Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amd/display/dc/pg/dcn42/dcn42_pg_cntl.c   | 150 +++++++-----------
 1 file changed, 60 insertions(+), 90 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c b/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c
index 2fc17dc510df..78b33b2dbae8 100644
--- a/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c
@@ -61,6 +61,21 @@ static void pg_cntl42_restore_global_fgcg_rep(struct pg_cntl *pg_cntl,
 	REG_UPDATE(AZ_CLOCK_CNTL, AZ_GLOBAL_FGCG_REP_DIS, state->az_rep_fgcg);
 }

+static bool should_skip_pg_control(bool dc_in_idle_opt, bool power_on, bool block_enabled)
+{
+	if (dc_in_idle_opt)
+		return true;
+
+	if (power_on && block_enabled)
+		return true;
+
+	if (!power_on && !block_enabled)
+		return true;
+
+	return false;
+}
+
+
 static bool pg_cntl42_dsc_pg_status(struct pg_cntl *pg_cntl, unsigned int dsc_inst)
 {
 	struct dcn_pg_cntl *pg_cntl_dcn = TO_DCN_PG_CNTL(pg_cntl);
@@ -94,23 +109,14 @@ void pg_cntl42_dsc_pg_control(struct pg_cntl *pg_cntl, unsigned int dsc_inst, bo
 	uint32_t pwr_status = power_on ? 0 : 2;
 	uint32_t org_ip_request_cntl = 0;
 	struct dcn42_global_fgcg_rep_state fgcg_rep_state = {0};
-	bool block_enabled;
-
-    bool skip_pg = pg_cntl->ctx->dc->debug.ignore_pg ||
-			pg_cntl->ctx->dc->debug.disable_dsc_power_gate ||
-			pg_cntl->ctx->dc->idle_optimizations_allowed;
+	bool block_pg_disabled = pg_cntl->ctx->dc->debug.ignore_pg || pg_cntl->ctx->dc->debug.disable_dsc_power_gate;

-	if (skip_pg && !power_on)
+	if (block_pg_disabled && !power_on)
 		return;

-	block_enabled = pg_cntl42_dsc_pg_status(pg_cntl, dsc_inst);
-	if (power_on) {
-		if (block_enabled)
-			return;
-	} else {
-		if (!block_enabled)
-			return;
-	}
+	bool block_enabled = pg_cntl42_dsc_pg_status(pg_cntl, dsc_inst);
+	if (should_skip_pg_control(pg_cntl->ctx->dc->idle_optimizations_allowed, power_on, block_enabled))
+		return;

 	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
 	if (org_ip_request_cntl == 0)
@@ -201,23 +207,16 @@ void pg_cntl42_hubp_dpp_pg_control(struct pg_cntl *pg_cntl, unsigned int hubp_dp
 	uint32_t pwr_status = power_on ? 0 : 2;
 	uint32_t org_ip_request_cntl;
 	struct dcn42_global_fgcg_rep_state fgcg_rep_state = {0};
-	bool block_enabled;
-	bool skip_pg = pg_cntl->ctx->dc->debug.ignore_pg ||
-		       pg_cntl->ctx->dc->debug.disable_hubp_power_gate ||
-		       pg_cntl->ctx->dc->debug.disable_dpp_power_gate ||
-		       pg_cntl->ctx->dc->idle_optimizations_allowed;
+	bool block_pg_disabled = pg_cntl->ctx->dc->debug.ignore_pg ||
+			pg_cntl->ctx->dc->debug.disable_hubp_power_gate ||
+			pg_cntl->ctx->dc->debug.disable_dpp_power_gate;

-	if (skip_pg && !power_on)
+	if (block_pg_disabled && !power_on)
 		return;

-	block_enabled = pg_cntl42_hubp_dpp_pg_status(pg_cntl, hubp_dpp_inst);
-	if (power_on) {
-		if (block_enabled)
-			return;
-	} else {
-		if (!block_enabled)
-			return;
-	}
+	bool block_enabled = pg_cntl42_hubp_dpp_pg_status(pg_cntl, hubp_dpp_inst);
+	if (should_skip_pg_control(pg_cntl->ctx->dc->idle_optimizations_allowed, power_on, block_enabled))
+		return;

 	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
 	if (org_ip_request_cntl == 0)
@@ -283,22 +282,17 @@ void pg_cntl42_hpo_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 	uint32_t org_ip_request_cntl;
 	uint32_t power_forceon;
 	struct dcn42_global_fgcg_rep_state fgcg_rep_state = {0};
-	bool block_enabled;

-	bool skip_pg = pg_cntl->ctx->dc->debug.ignore_pg ||
-			pg_cntl->ctx->dc->debug.disable_hpo_power_gate ||
-			pg_cntl->ctx->dc->idle_optimizations_allowed;
+	bool block_pg_disabled = pg_cntl->ctx->dc->debug.ignore_pg ||
+			pg_cntl->ctx->dc->debug.disable_hpo_power_gate;

-	if (skip_pg && !power_on)
+	if (block_pg_disabled && !power_on)
+		return;
+
+	bool block_enabled = pg_cntl42_hpo_pg_status(pg_cntl);
+
+	if (should_skip_pg_control(pg_cntl->ctx->dc->idle_optimizations_allowed, power_on, block_enabled))
 		return;
-	block_enabled = pg_cntl42_hpo_pg_status(pg_cntl);
-	if (power_on) {
-		if (block_enabled)
-			return;
-	} else {
-		if (!block_enabled)
-			return;
-	}

 	REG_GET(DOMAIN25_PG_CONFIG, DOMAIN_POWER_FORCEON, &power_forceon);
 	if (power_forceon)
@@ -337,23 +331,17 @@ void pg_cntl42_io_clk_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 	uint32_t pwr_status = power_on ? 0 : 2;
 	uint32_t org_ip_request_cntl;
 	uint32_t power_forceon;
-	bool block_enabled;

-	bool skip_pg = pg_cntl->ctx->dc->debug.ignore_pg ||
-			pg_cntl->ctx->dc->idle_optimizations_allowed ||
+	bool block_pg_disabled = pg_cntl->ctx->dc->debug.ignore_pg ||
 			pg_cntl->ctx->dc->debug.disable_io_clk_power_gate;

-	if (skip_pg && !power_on)
+	if (block_pg_disabled && !power_on)
 		return;

-	block_enabled = pg_cntl42_io_clk_status(pg_cntl);
-	if (power_on) {
-		if (block_enabled)
-			return;
-	} else {
-		if (!block_enabled)
-			return;
-	}
+	bool block_enabled = pg_cntl42_io_clk_status(pg_cntl);
+
+	if (should_skip_pg_control(pg_cntl->ctx->dc->idle_optimizations_allowed, power_on, block_enabled))
+		return;

 	REG_GET(DOMAIN22_PG_CONFIG, DOMAIN_POWER_FORCEON, &power_forceon);
 	if (power_forceon)
@@ -435,24 +423,16 @@ void pg_cntl42_mem_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 	uint32_t pwr_status = power_on ? 0 : 2;
 	uint32_t org_ip_request_cntl;
 	uint32_t power_forceon;
-	bool block_enabled;

-	bool skip_pg = pg_cntl->ctx->dc->debug.ignore_pg ||
-			pg_cntl->ctx->dc->idle_optimizations_allowed ||
+	bool block_pg_disabled = pg_cntl->ctx->dc->debug.ignore_pg ||
 			pg_cntl->ctx->dc->debug.disable_mem_power_gate;

-	if (skip_pg && !power_on)
+	if (block_pg_disabled && !power_on)
 		return;

-	block_enabled = pg_cntl42_mem_status(pg_cntl);
-	if (power_on) {
-		if (block_enabled)
-			return;
-	} else {
-		if (!block_enabled)
-			return;
-	}
-
+	bool block_enabled = pg_cntl42_mem_status(pg_cntl);
+	if (should_skip_pg_control(pg_cntl->ctx->dc->idle_optimizations_allowed, power_on, block_enabled))
+		return;
 	REG_GET(DOMAIN23_PG_CONFIG, DOMAIN_POWER_FORCEON, &power_forceon);
 	if (power_forceon)
 		return;
@@ -490,22 +470,16 @@ void pg_cntl42_dio_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 	uint32_t pwr_status = power_on ? 0 : 2;
 	uint32_t org_ip_request_cntl;
 	struct dcn42_global_fgcg_rep_state fgcg_rep_state = {0};
-	bool block_enabled;

-	bool skip_pg = pg_cntl->ctx->dc->debug.ignore_pg ||
-			pg_cntl->ctx->dc->idle_optimizations_allowed ||
+	bool block_pg_disabled = pg_cntl->ctx->dc->debug.ignore_pg ||
 			pg_cntl->ctx->dc->debug.disable_dio_power_gate;
-	if (skip_pg && !power_on)
+
+	if (block_pg_disabled && !power_on)
 		return;

-	block_enabled = pg_cntl42_dio_pg_status(pg_cntl);
-	if (power_on) {
-		if (block_enabled)
-			return;
-	} else {
-		if (!block_enabled)
-			return;
-	}
+	bool block_enabled = pg_cntl42_dio_pg_status(pg_cntl);
+	if (should_skip_pg_control(pg_cntl->ctx->dc->idle_optimizations_allowed, power_on, block_enabled))
+		return;

 	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
 	if (org_ip_request_cntl == 0)
@@ -531,23 +505,19 @@ void pg_cntl42_plane_otg_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 	uint32_t pwr_status = power_on ? 0 : 2;
 	uint32_t org_ip_request_cntl;
 	unsigned int i;
-	bool block_enabled;
 	bool all_mpcc_disabled = true, all_opp_disabled = true;
 	bool all_optc_disabled = true, all_stream_disabled = true;

-	if (pg_cntl->ctx->dc->debug.ignore_pg ||
-		pg_cntl->ctx->dc->debug.disable_optc_power_gate ||
-		pg_cntl->ctx->dc->idle_optimizations_allowed)
+	bool block_pg_disabled = pg_cntl->ctx->dc->debug.ignore_pg ||
+			pg_cntl->ctx->dc->debug.disable_optc_power_gate;
+
+	if (block_pg_disabled && !power_on)
 		return;

-	block_enabled = pg_cntl42_plane_otg_status(pg_cntl);
-	if (power_on) {
-		if (block_enabled)
-			return;
-	} else {
-		if (!block_enabled)
-			return;
-	}
+	bool block_enabled = pg_cntl42_plane_otg_status(pg_cntl);
+
+	if (should_skip_pg_control(pg_cntl->ctx->dc->idle_optimizations_allowed, power_on, block_enabled))
+		return;

 	for (i = 0; i < pg_cntl->ctx->dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe_ctx = &pg_cntl->ctx->dc->current_state->res_ctx.pipe_ctx[i];
--
2.54.0

