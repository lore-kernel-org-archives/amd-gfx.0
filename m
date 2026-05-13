Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95012CD4F21
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:33:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E23B10EF03;
	Wed, 13 May 2026 14:33:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="40WXGkHD";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011049.outbound.protection.outlook.com [52.101.52.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6AF310EED0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:33:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUxWVuOq9APHBmxPASpMuMi+5mNwYkNn7PB7+mXqRfGi7mroNz9vY8+0K4VjyrKD9pfUJmZa6njtLOU4U2UpS2bYAZpJphtCl3/yFXdqzZh7cEk/ByVrksZ+s+dpsPvdnI5B5Z5J2sPHZIhbPJ+/9O7v1LB52Qcx34PVPknbqyp5xR9FPx952zVtnl6ITGa4Z3TvZgmen/Bw0s3RWMg5Hn4HBN9pu7hUgABBsbKsfomV6noWWyeFJ2WAGt5rxLU+ZXl2qbg8Pd27qnv7ZZj01L9lB4MCv3x53jPrFdFltsBAxE8LSMO13Dcmu3a1HPafDecrWf2GgQLaCqEp55WoJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgzsqYWK4jn0jZsRSDNmBdk26SgLM+a+i5yejrdiXmA=;
 b=v2Gi10mpeEJhF/IIkTi56UkWQLzX8erqByhh/tJGSSxCw2ZYxQkWtzm1p/0STjwqtqydMiMcfCN6YxI5V2SMRvec7EsrLdvYhxi/YwRdPaQDY25EydiJXxD7KCsZfS0AfTfKUYYA+R8VX9zlLfvKQcHOdjoa1V/C0GTHRVmcFdu/lw1DdXcV7VcUtxqEe+jxcLYaJYNgsSDhnAADBtNG+dQt26dxisdHxH+xHfjwyuEI+oomX0yct+yFfZ7q8qQcwqVxggmyAZ6a/PXxE49UWt/LeWYK3V2bOFzLdSXVxA13dJ7jWpwP9JXFWixQPD2ERD5aZeBIiSmZtMeXFgloAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgzsqYWK4jn0jZsRSDNmBdk26SgLM+a+i5yejrdiXmA=;
 b=40WXGkHDQU76qoHoB2RhoVnVuHboc1yp/QRuNEd/Et//kwG34qImb2IdtM5HIK9lOaFqQuLK50TwrT2Fun/S76bhhD098v9AlUsbdZRt70TdRzgK1qMJ+inkvvA4PBkPnihM2RU2vzu5L1HPRgM3YhfkUOXkVdteeF2AXGCJspA=
Received: from CH5PR03CA0004.namprd03.prod.outlook.com (2603:10b6:610:1f1::6)
 by SA0PR12MB4494.namprd12.prod.outlook.com (2603:10b6:806:94::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 14:33:40 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::4c) by CH5PR03CA0004.outlook.office365.com
 (2603:10b6:610:1f1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 14:33:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:33:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Wed, 13 May
 2026 09:33:38 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 May
 2026 09:33:37 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 09:33:37 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Leo Chen
 <leo.chen@amd.com>
Subject: [PATCH 20/28] drm/amd/display: Allow power up when PG disallowed in
 driver
Date: Wed, 13 May 2026 10:29:42 -0400
Message-ID: <20260513143213.1852892-22-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
References: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|SA0PR12MB4494:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d9d48d5-69f0-4f43-9146-08deb0fca021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|22082099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info: v5r5CBGhD95ihpxijrJD8m1lUHsoNEsS9EFe7ij/uLxFtX2VFKIBSGN6K6BD6jD1pi2WWqxx72WgBaRN1jn9QsKJM+8sGyUQ6/Ku27zEY6CroMUotn5awjbtXC+65+93cl2o6RK8CQ27PyZHZYguyAs6SCWKR3wyZUW3znb/n6me41dmj1f9yv0gLTvE7ySlHY0oMDV8XGWWvUrwtlSZawpWck+rpIfjpZMNX9A1CoKp9HHmrBjz+GePo/RlNLVltUIJMyJY60VY8nTicsS0s/IMP3KyXIf6+R3KauWT6OPjKeEcBttaMr2P5uz3+6eNJJUVgqW73h0qKgBnfqPoLOsqaHYjNWLjwZyE5RFvDeQLXz1rdZdyIw4DEN7Fr5ds/4HURXWH8x4CkOB6is2tkG0C/xA4zwjr3TQwdOQ1dRUrmkv+qIw3/cKyAUpMxaaYbxJAAAvb8UltN1UFRKcE65/LBIai7HrqyIdtjVHa0JdBkj3PBmeHDl59VXF9bXKVPB4VfRxu9vDZpyXP6iTyFpzwC4M97DsLYRTGJYDi5bn0KmiXvh/1A/raoWdy9Mc+Ta4znnMin23o8IlGYpHdi9Smm2AOQu01JqMdMOYlZg6N6dSBDG253ksox5xw+qWInE3SgFwOhWN/8MH2D9630CgXgaH103HE3Yu1pcSLHkVBoK64uuLR3oagRagk3521kJ7gW9JL4TzNpDH43RO50xJxOrC3SszXScwH5KQAI+E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(22082099003)(11063799003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dchxxd/aoizEKphVD3yztGNlV/AbyXbPa6t52kj3ILHwnDTW3xbPfUP/Dgj/QIj8tAgd5b2x6952MSkiiA4JlS9iamdpfMCoE988SsTjvorSZc04JRZxsPs3Utftgu3TK5tpQcA+J7QiBJK9ZarHdMAy5yysjNVsqV2bSP4cWUGg7D5+zd7HBu6sV6hvFxku1mEodHzNNAWWB5ikPv13b+90guyBAF3pUnmQnT5yP0di7oW05q+G6XSxOwKCf7JRtEt97jJ7iyFGRH6JsukF+E6r9WcxLGd43JyCaSXxu+EJrq6lLIXt/twhxTLxFruWO2zUgkbMxOqfkmaY1d4KqIMRCL8faUY6ciJdkFgcc330hd0oYNfEytuqQTzbUsdOPFH7Z0pxbZIWfIBjPEn5BPFaKhV2zaSWnXkGGMJz56SFstdN7cpAYL0cPKlG0PdO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:33:39.7459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9d48d5-69f0-4f43-9146-08deb0fca021
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4494
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

[Why]
Do not exit early dcn42 pg control functions on power up for pipe PG
failsafe.

Reviewed-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amd/display/dc/pg/dcn42/dcn42_pg_cntl.c   | 43 +++++++++++--------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c b/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c
index 4a096fa3fc10..729c2b653161 100644
--- a/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c
@@ -27,9 +27,6 @@ static bool pg_cntl42_dsc_pg_status(struct pg_cntl *pg_cntl, unsigned int dsc_in
 	struct dcn_pg_cntl *pg_cntl_dcn = TO_DCN_PG_CNTL(pg_cntl);
 	uint32_t pwr_status = 0;
 
-	if (pg_cntl->ctx->dc->debug.ignore_pg)
-		return true;
-
 	switch (dsc_inst) {
 	case 0: /* DSC0 */
 		REG_GET(DOMAIN16_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, &pwr_status);
@@ -64,9 +61,11 @@ void pg_cntl42_dsc_pg_control(struct pg_cntl *pg_cntl, unsigned int dsc_inst, bo
 		pg_cntl->ctx->dc->res_pool->dccg->funcs->enable_dsc(
 				pg_cntl->ctx->dc->res_pool->dccg, dsc_inst);
 
-	if (pg_cntl->ctx->dc->debug.ignore_pg ||
-		pg_cntl->ctx->dc->debug.disable_dsc_power_gate ||
-		pg_cntl->ctx->dc->idle_optimizations_allowed)
+    bool skip_pg = pg_cntl->ctx->dc->debug.ignore_pg ||
+			pg_cntl->ctx->dc->debug.disable_dsc_power_gate ||
+			pg_cntl->ctx->dc->idle_optimizations_allowed;
+
+	if (skip_pg && !power_on)
 		return;
 
 	block_enabled = pg_cntl42_dsc_pg_status(pg_cntl, dsc_inst);
@@ -261,11 +260,12 @@ void pg_cntl42_hpo_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 	uint32_t power_forceon;
 	bool block_enabled;
 
-	if (pg_cntl->ctx->dc->debug.ignore_pg ||
-		pg_cntl->ctx->dc->debug.disable_hpo_power_gate ||
-		pg_cntl->ctx->dc->idle_optimizations_allowed)
-		return;
+	bool skip_pg = pg_cntl->ctx->dc->debug.ignore_pg ||
+			pg_cntl->ctx->dc->debug.disable_hpo_power_gate ||
+			pg_cntl->ctx->dc->idle_optimizations_allowed;
 
+	if (skip_pg && !power_on)
+		return;
 	block_enabled = pg_cntl42_hpo_pg_status(pg_cntl);
 	if (power_on) {
 		if (block_enabled)
@@ -316,9 +316,11 @@ void pg_cntl42_io_clk_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 	uint32_t power_forceon;
 	bool block_enabled;
 
-	if (pg_cntl->ctx->dc->debug.ignore_pg ||
-		pg_cntl->ctx->dc->idle_optimizations_allowed ||
-		pg_cntl->ctx->dc->debug.disable_io_clk_power_gate)
+	bool skip_pg = pg_cntl->ctx->dc->debug.ignore_pg ||
+			pg_cntl->ctx->dc->idle_optimizations_allowed ||
+			pg_cntl->ctx->dc->debug.disable_io_clk_power_gate;
+
+	if (skip_pg && !power_on)
 		return;
 
 	block_enabled = pg_cntl42_io_clk_status(pg_cntl);
@@ -412,9 +414,11 @@ void pg_cntl42_mem_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 	uint32_t power_forceon;
 	bool block_enabled;
 
-	if (pg_cntl->ctx->dc->debug.ignore_pg ||
-		pg_cntl->ctx->dc->idle_optimizations_allowed ||
-		pg_cntl->ctx->dc->debug.disable_mem_power_gate)
+	bool skip_pg = pg_cntl->ctx->dc->debug.ignore_pg ||
+			pg_cntl->ctx->dc->idle_optimizations_allowed ||
+			pg_cntl->ctx->dc->debug.disable_mem_power_gate;
+
+	if (skip_pg && !power_on)
 		return;
 
 	block_enabled = pg_cntl42_mem_status(pg_cntl);
@@ -464,9 +468,10 @@ void pg_cntl42_dio_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 	uint32_t org_ip_request_cntl;
 	bool block_enabled;
 
-	if (pg_cntl->ctx->dc->debug.ignore_pg ||
-		pg_cntl->ctx->dc->idle_optimizations_allowed ||
-		pg_cntl->ctx->dc->debug.disable_dio_power_gate)
+	bool skip_pg = pg_cntl->ctx->dc->debug.ignore_pg ||
+			pg_cntl->ctx->dc->idle_optimizations_allowed ||
+			pg_cntl->ctx->dc->debug.disable_dio_power_gate;
+	if (skip_pg && !power_on)
 		return;
 
 	block_enabled = pg_cntl42_dio_pg_status(pg_cntl);
-- 
2.43.0

