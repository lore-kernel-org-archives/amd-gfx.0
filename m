Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB6CEE49A0
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2687B10E44D;
	Wed, 23 Aug 2023 15:51:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B81E810E443
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdBHosbM3ZOC9MiRZ93lNIUzAh2guyPAnLi5TC9/mto8oulpVVFZFIbEGDAnekGHvi2lxhsQPw2IT81FOmVwxFwahx2qgCFcenWASG/PEHNYQQHcHPFAm+Y7/GU2qkdNBkZdDVarAh4HHky8EKqYUKKr2QupMDIRO4kVSiXQuWtpKO7/o0fJBoOr+/TLaFkd8amWb5Ybl1qA1AmaHWWyT06Jvh2gbHRIJ5aGys/6mjyLeH9uVlZwgKqmDq6hEUQdBf2xqFjaJL6OHYpEv69DIECyKceItzZ4ZeeQ1hRLgheFz9IgiTrQirrTRzTktDOnFa3Jw9fBfa1aF6rC5QbMUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDUeZGrrizViJqTDHtw6GTzxCaBrv9Xeh8jZA3pWZCc=;
 b=bt2B0EB9NdlUP8XstutnxK8PsSsE78wy18ewwa40NOPQbi/Nx3sxwCqqSsp3YRlV10RddeVLHNe7CiVTRFjUURHGvhqJyrT5KlpO2rFENk2n1YgszFuGPkPTYf0dHH4H5/U2sXabprVNBhJ5KKbFjIPo9dSX9pFsr3Y6xGHea6qZMhpgLIxpy45ieGk3eKhk0P3wjfm2IrNdPHPUtegd9op+0qMoBEx3a0ccgl+PulgY1k4QHPjqNhb5bM2YQ/dwtHg6RNt3I9tGR6YnWvwjUIo6PsxRsgKZFnOHslSwIMESvUB1Vp/zAEWtZrTXNKyWc+T4OMYGVuS54QPETBiqZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDUeZGrrizViJqTDHtw6GTzxCaBrv9Xeh8jZA3pWZCc=;
 b=BvL0UCn3JfmRcFsNKGkdiqHPms0gu+pEyFHlWoKbz5ViqscpcgZxP13gB2D2/guOmCgL2gx9ryfZxFABsBpXrIkouk5x0Wvr0f2wljThieRipEMAevT5eoCa0yK00uVuNjzbRu0h2dtyzd3HaNs9Fbx9/aTek25qZH37j9sTXQI=
Received: from DM6PR21CA0021.namprd21.prod.outlook.com (2603:10b6:5:174::31)
 by DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 15:51:16 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::78) by DM6PR21CA0021.outlook.office365.com
 (2603:10b6:5:174::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.8 via Frontend
 Transport; Wed, 23 Aug 2023 15:51:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 15:51:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 10:51:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/35] drm/amd/display: Add DCN35 PG_CNTL
Date: Wed, 23 Aug 2023 11:50:29 -0400
Message-ID: <20230823155048.2526343-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823155048.2526343-1-alexander.deucher@amd.com>
References: <20230823155048.2526343-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DM6PR12MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: cfd7f5c9-0566-4056-8696-08dba3f0c8f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /sWkwT7NzD8cZP08mNwdzkiBoeYlv80K4UO6dTuiaoW7NQE/WoE2iXZPbDRovzpSS4YLyyps3oNcvU1pUAxayatH7dRLw+mdAuorVnWZY42xVqujggon6dJeMothWc8U4ibt2inXPDv8OzTaphXKC9u2HWio9I86gzUm+p+mdgYE7klKzRdvdGUeaMdzjAq0juwkckXDqGVa7vN4a51id1Tzyk7JIdpO+oWoW7UnHJENBTCijLuatR42F30sj9JLwxrMbUomiclV3XAgJaBVmv3A7pHL08vkqXqV8OMYfCzrvUupyoJ8NOz7jd6UvxSDT7L4xqupav4CoY+DORLg5eaFETP2kuKGd24AfjMnupk1cnPXu82mHN5TBuY8OuWpXabnu+2159gaJapOi9KkROmRVqWHk1rC8D5/VkU/uLjFh52X/+CZQSBC3afJTj0Glw92h/HBqvZrtje4FcfQ3r/Ph5tKYle4+f1UbhC7uod2PxlWTVl93PVKGxu+vE+xG53iNmJ8GXMkF87hixE00a9WfXbqe6z2quQZPiYpen0IzU5VYuq6InR8VaEepkmJt1Hmfo8m/CVdOImN6Q4pTthHyMOlSiOMS//fD2KV749TYSaoTNmuxnpWWXUrWJ/2oddn4hy6f3mQxXuWrVZbhguY2Ga1+REe7Nlfw+mobEIUneNxu3iEUl3DaUXzazYxWD+HkWuqt0KyUlP75rtTy2cCwSRlkdBPI/IA7/tobLn2NagYmibVAVNqbZg7EEv8MQE7hGQDnXdV6ZuKa5216w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(186009)(451199024)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(2616005)(7696005)(316002)(6916009)(4326008)(8936002)(8676002)(40480700001)(70586007)(54906003)(70206006)(41300700001)(336012)(426003)(16526019)(26005)(1076003)(5660300002)(6666004)(478600001)(83380400001)(30864003)(40460700003)(47076005)(36860700001)(66899024)(36756003)(86362001)(2906002)(82740400003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:16.0779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd7f5c9-0566-4056-8696-08dba3f0c8f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4140
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>

[Why & How]
Add PG_CNTL handling for DCN35.

Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/display/dc/dcn35/dcn35_pg_cntl.c  | 553 ++++++++++++++++++
 .../drm/amd/display/dc/dcn35/dcn35_pg_cntl.h  | 193 ++++++
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   2 +
 .../gpu/drm/amd/display/dc/inc/hw/pg_cntl.h   |  52 ++
 4 files changed, 800 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
new file mode 100644
index 000000000000..8b487d15c8ec
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
@@ -0,0 +1,553 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include "reg_helper.h"
+#include "core_types.h"
+#include "dcn35_pg_cntl.h"
+#include "dccg.h"
+
+#define TO_DCN_PG_CNTL(pg_cntl)\
+	container_of(pg_cntl, struct dcn_pg_cntl, base)
+
+#define REG(reg) \
+	(pg_cntl_dcn->regs->reg)
+
+#undef FN
+#define FN(reg_name, field_name) \
+	pg_cntl_dcn->pg_cntl_shift->field_name, pg_cntl_dcn->pg_cntl_mask->field_name
+
+#define CTX \
+	pg_cntl_dcn->base.ctx
+#define DC_LOGGER \
+	pg_cntl->ctx->logger
+
+static bool pg_cntl35_dsc_pg_status(struct pg_cntl *pg_cntl, unsigned int dsc_inst)
+{
+	struct dcn_pg_cntl *pg_cntl_dcn = TO_DCN_PG_CNTL(pg_cntl);
+	uint32_t pwr_status = 0;
+
+	if (pg_cntl->ctx->dc->debug.ignore_pg)
+		return true;
+
+	switch (dsc_inst) {
+	case 0: /* DSC0 */
+		REG_GET(DOMAIN16_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, &pwr_status);
+		break;
+	case 1: /* DSC1 */
+		REG_GET(DOMAIN17_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, &pwr_status);
+		break;
+	case 2: /* DSC2 */
+		REG_GET(DOMAIN18_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, &pwr_status);
+		break;
+	case 3: /* DSC3 */
+		REG_GET(DOMAIN19_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, &pwr_status);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		break;
+	}
+
+	return pwr_status == 0;
+}
+
+void pg_cntl35_dsc_pg_control(struct pg_cntl *pg_cntl, unsigned int dsc_inst, bool power_on)
+{
+	struct dcn_pg_cntl *pg_cntl_dcn = TO_DCN_PG_CNTL(pg_cntl);
+	uint32_t power_gate = power_on ? 0 : 1;
+	uint32_t pwr_status = power_on ? 0 : 2;
+	uint32_t org_ip_request_cntl = 0;
+	bool block_enabled;
+
+	/*need to enable dscclk regardless DSC_PG*/
+	if (pg_cntl->ctx->dc->res_pool->dccg->funcs->enable_dsc && power_on)
+		pg_cntl->ctx->dc->res_pool->dccg->funcs->enable_dsc(
+				pg_cntl->ctx->dc->res_pool->dccg, dsc_inst);
+
+	if (pg_cntl->ctx->dc->debug.disable_dsc_power_gate)
+		return;
+
+	if (pg_cntl->ctx->dc->idle_optimizations_allowed)
+		return;
+
+	block_enabled = pg_cntl35_dsc_pg_status(pg_cntl, dsc_inst);
+	if (power_on) {
+		if (block_enabled)
+			return;
+	} else {
+		if (!block_enabled)
+			return;
+	}
+	if (pg_cntl->ctx->dc->debug.ignore_pg)
+		return;
+	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
+	if (org_ip_request_cntl == 0)
+		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);
+
+	switch (dsc_inst) {
+	case 0: /* DSC0 */
+		REG_UPDATE(DOMAIN16_PG_CONFIG,
+				DOMAIN_POWER_GATE, power_gate);
+
+		REG_WAIT(DOMAIN16_PG_STATUS,
+				DOMAIN_PGFSM_PWR_STATUS, pwr_status,
+				1, 1000);
+		break;
+	case 1: /* DSC1 */
+		REG_UPDATE(DOMAIN17_PG_CONFIG,
+				DOMAIN_POWER_GATE, power_gate);
+
+		REG_WAIT(DOMAIN17_PG_STATUS,
+				DOMAIN_PGFSM_PWR_STATUS, pwr_status,
+				1, 1000);
+		break;
+	case 2: /* DSC2 */
+		REG_UPDATE(DOMAIN18_PG_CONFIG,
+				DOMAIN_POWER_GATE, power_gate);
+
+		REG_WAIT(DOMAIN18_PG_STATUS,
+				DOMAIN_PGFSM_PWR_STATUS, pwr_status,
+				1, 1000);
+		break;
+	case 3: /* DSC3 */
+		REG_UPDATE(DOMAIN19_PG_CONFIG,
+				DOMAIN_POWER_GATE, power_gate);
+
+		REG_WAIT(DOMAIN19_PG_STATUS,
+				DOMAIN_PGFSM_PWR_STATUS, pwr_status,
+				1, 1000);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		break;
+	}
+
+	if (dsc_inst < MAX_PIPES)
+		pg_cntl->pg_pipe_res_enable[PG_DSC][dsc_inst] = power_on;
+
+	if (pg_cntl->ctx->dc->res_pool->dccg->funcs->disable_dsc && !power_on) {
+		/*this is to disable dscclk*/
+		pg_cntl->ctx->dc->res_pool->dccg->funcs->disable_dsc(
+			pg_cntl->ctx->dc->res_pool->dccg, dsc_inst);
+	}
+}
+
+static bool pg_cntl35_hubp_dpp_pg_status(struct pg_cntl *pg_cntl, unsigned int hubp_dpp_inst)
+{
+	struct dcn_pg_cntl *pg_cntl_dcn = TO_DCN_PG_CNTL(pg_cntl);
+	uint32_t pwr_status = 0;
+
+	switch (hubp_dpp_inst) {
+	case 0:
+		/* DPP0 & HUBP0 */
+		REG_GET(DOMAIN0_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, &pwr_status);
+		break;
+	case 1:
+		/* DPP1 & HUBP1 */
+		REG_GET(DOMAIN1_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, &pwr_status);
+		break;
+	case 2:
+		/* DPP2 & HUBP2 */
+		REG_GET(DOMAIN2_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, &pwr_status);
+		break;
+	case 3:
+		/* DPP3 & HUBP3 */
+		REG_GET(DOMAIN3_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, &pwr_status);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		break;
+	}
+
+	return pwr_status == 0;
+}
+
+void pg_cntl35_hubp_dpp_pg_control(struct pg_cntl *pg_cntl, unsigned int hubp_dpp_inst, bool power_on)
+{
+	struct dcn_pg_cntl *pg_cntl_dcn = TO_DCN_PG_CNTL(pg_cntl);
+	uint32_t power_gate = power_on ? 0 : 1;
+	uint32_t pwr_status = power_on ? 0 : 2;
+	uint32_t org_ip_request_cntl;
+	bool block_enabled;
+
+	if (!power_on)
+		return;
+	if (pg_cntl->ctx->dc->debug.disable_hubp_power_gate ||
+		pg_cntl->ctx->dc->debug.disable_dpp_power_gate)
+		return;
+
+	if (pg_cntl->ctx->dc->idle_optimizations_allowed)
+		return;
+
+	block_enabled = pg_cntl35_hubp_dpp_pg_status(pg_cntl, hubp_dpp_inst);
+	if (power_on) {
+		if (block_enabled)
+			return;
+	} else {
+		if (!block_enabled)
+			return;
+	}
+	if (pg_cntl->ctx->dc->debug.ignore_pg)
+		return;
+	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
+	if (org_ip_request_cntl == 0)
+		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);
+
+	switch (hubp_dpp_inst) {
+	case 0:
+		/* DPP0 & HUBP0 */
+		REG_UPDATE(DOMAIN0_PG_CONFIG, DOMAIN_POWER_GATE, power_gate);
+		REG_WAIT(DOMAIN0_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, pwr_status, 1, 1000);
+		break;
+	case 1:
+		/* DPP1 & HUBP1 */
+		REG_UPDATE(DOMAIN1_PG_CONFIG, DOMAIN_POWER_GATE, power_gate);
+		REG_WAIT(DOMAIN1_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, pwr_status, 1, 1000);
+		break;
+	case 2:
+		/* DPP2 & HUBP2 */
+		REG_UPDATE(DOMAIN2_PG_CONFIG, DOMAIN_POWER_GATE, power_gate);
+		REG_WAIT(DOMAIN2_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, pwr_status, 1, 1000);
+		break;
+	case 3:
+		/* DPP3 & HUBP3 */
+		REG_UPDATE(DOMAIN3_PG_CONFIG, DOMAIN_POWER_GATE, power_gate);
+		REG_WAIT(DOMAIN3_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, pwr_status, 1, 1000);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		break;
+	}
+
+	DC_LOG_DEBUG("HUBP DPP instance %d, power %s", hubp_dpp_inst,
+		power_on ? "ON" : "OFF");
+
+	if (hubp_dpp_inst < MAX_PIPES) {
+		pg_cntl->pg_pipe_res_enable[PG_HUBP][hubp_dpp_inst] = power_on;
+		pg_cntl->pg_pipe_res_enable[PG_DPP][hubp_dpp_inst] = power_on;
+	}
+}
+
+static bool pg_cntl35_hpo_pg_status(struct pg_cntl *pg_cntl)
+{
+	struct dcn_pg_cntl *pg_cntl_dcn = TO_DCN_PG_CNTL(pg_cntl);
+	uint32_t pwr_status = 0;
+
+	REG_GET(DOMAIN25_PG_STATUS,
+			DOMAIN_PGFSM_PWR_STATUS, &pwr_status);
+
+	return pwr_status == 0;
+}
+
+void pg_cntl35_hpo_pg_control(struct pg_cntl *pg_cntl, bool power_on)
+{
+	struct dcn_pg_cntl *pg_cntl_dcn = TO_DCN_PG_CNTL(pg_cntl);
+	uint32_t power_gate = power_on ? 0 : 1;
+	uint32_t pwr_status = power_on ? 0 : 2;
+	uint32_t org_ip_request_cntl;
+	bool block_enabled;
+
+	if (pg_cntl->ctx->dc->idle_optimizations_allowed)
+		return;
+
+	block_enabled = pg_cntl35_hpo_pg_status(pg_cntl);
+	if (power_on) {
+		if (block_enabled)
+			return;
+	} else {
+		if (!block_enabled)
+			return;
+	}
+	if (pg_cntl->ctx->dc->debug.ignore_pg)
+		return;
+	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
+	if (org_ip_request_cntl == 0)
+		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);
+
+	REG_UPDATE(DOMAIN25_PG_CONFIG, DOMAIN_POWER_GATE, power_gate);
+	REG_WAIT(DOMAIN25_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, pwr_status, 1, 1000);
+
+	pg_cntl->pg_res_enable[PG_HPO] = power_on;
+}
+
+static bool pg_cntl35_io_clk_status(struct pg_cntl *pg_cntl)
+{
+	struct dcn_pg_cntl *pg_cntl_dcn = TO_DCN_PG_CNTL(pg_cntl);
+	uint32_t pwr_status = 0;
+
+	REG_GET(DOMAIN22_PG_STATUS,
+		DOMAIN_PGFSM_PWR_STATUS, &pwr_status);
+
+	return pwr_status == 0;
+}
+
+void pg_cntl35_io_clk_pg_control(struct pg_cntl *pg_cntl, bool power_on)
+{
+	struct dcn_pg_cntl *pg_cntl_dcn = TO_DCN_PG_CNTL(pg_cntl);
+	uint32_t power_gate = power_on ? 0 : 1;
+	uint32_t pwr_status = power_on ? 0 : 2;
+	uint32_t org_ip_request_cntl;
+	bool block_enabled;
+
+	if (!power_on)
+		return;
+	if (pg_cntl->ctx->dc->idle_optimizations_allowed)
+		return;
+
+	block_enabled = pg_cntl35_io_clk_status(pg_cntl);
+	if (power_on) {
+		if (block_enabled)
+			return;
+	} else {
+		if (!block_enabled)
+			return;
+	}
+	if (pg_cntl->ctx->dc->debug.ignore_pg)
+		return;
+	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
+	if (org_ip_request_cntl == 0)
+		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);
+
+	/* DCCG, DIO, DCIO */
+	REG_UPDATE(DOMAIN22_PG_CONFIG, DOMAIN_POWER_GATE, power_gate);
+	REG_WAIT(DOMAIN22_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, pwr_status, 1, 1000);
+
+	pg_cntl->pg_res_enable[PG_DCCG] = power_on;
+	pg_cntl->pg_res_enable[PG_DIO] = power_on;
+	pg_cntl->pg_res_enable[PG_DCIO] = power_on;
+}
+
+static bool pg_cntl35_plane_otg_status(struct pg_cntl *pg_cntl)
+{
+	struct dcn_pg_cntl *pg_cntl_dcn = TO_DCN_PG_CNTL(pg_cntl);
+	uint32_t pwr_status = 0;
+
+	REG_GET(DOMAIN24_PG_STATUS,
+		DOMAIN_PGFSM_PWR_STATUS, &pwr_status);
+
+	return pwr_status == 0;
+}
+
+void pg_cntl35_mpcc_pg_control(struct pg_cntl *pg_cntl,
+	unsigned int mpcc_inst, bool power_on)
+{
+
+	if (pg_cntl->ctx->dc->idle_optimizations_allowed)
+		return;
+
+	if (mpcc_inst >= 0 && mpcc_inst < MAX_PIPES)
+		pg_cntl->pg_pipe_res_enable[PG_MPCC][mpcc_inst] = power_on;
+}
+
+void pg_cntl35_opp_pg_control(struct pg_cntl *pg_cntl,
+	unsigned int opp_inst, bool power_on)
+{
+
+	if (pg_cntl->ctx->dc->idle_optimizations_allowed)
+		return;
+
+	if (opp_inst >= 0 && opp_inst < MAX_PIPES)
+		pg_cntl->pg_pipe_res_enable[PG_OPP][opp_inst] = power_on;
+}
+
+void pg_cntl35_optc_pg_control(struct pg_cntl *pg_cntl,
+	unsigned int optc_inst, bool power_on)
+{
+
+	if (pg_cntl->ctx->dc->idle_optimizations_allowed)
+		return;
+
+	if (optc_inst >= 0 && optc_inst < MAX_PIPES)
+		pg_cntl->pg_pipe_res_enable[PG_OPTC][optc_inst] = power_on;
+}
+
+void pg_cntl35_plane_otg_pg_control(struct pg_cntl *pg_cntl, bool power_on)
+{
+	struct dcn_pg_cntl *pg_cntl_dcn = TO_DCN_PG_CNTL(pg_cntl);
+	uint32_t power_gate = power_on ? 0 : 1;
+	uint32_t pwr_status = power_on ? 0 : 2;
+	uint32_t org_ip_request_cntl;
+	int i;
+	bool block_enabled;
+	bool all_mpcc_disabled = true, all_opp_disabled = true;
+	bool all_optc_disabled = true, all_stream_disabled = true;
+
+	if (pg_cntl->ctx->dc->debug.disable_optc_power_gate)
+		return;
+
+	if (!power_on)
+		return;
+	if (pg_cntl->ctx->dc->idle_optimizations_allowed)
+		return;
+
+	block_enabled = pg_cntl35_plane_otg_status(pg_cntl);
+	if (power_on) {
+		if (block_enabled)
+			return;
+	} else {
+		if (!block_enabled)
+			return;
+	}
+
+	for (i = 0; i < pg_cntl->ctx->dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &pg_cntl->ctx->dc->current_state->res_ctx.pipe_ctx[i];
+
+		if (pipe_ctx) {
+			if (pipe_ctx->stream)
+				all_stream_disabled = false;
+		}
+
+		if (pg_cntl->pg_pipe_res_enable[PG_MPCC][i])
+			all_mpcc_disabled = false;
+
+		if (pg_cntl->pg_pipe_res_enable[PG_OPP][i])
+			all_opp_disabled = false;
+
+		if (pg_cntl->pg_pipe_res_enable[PG_OPTC][i])
+			all_optc_disabled = false;
+	}
+
+	if (!power_on) {
+		if (!all_mpcc_disabled || !all_opp_disabled || !all_optc_disabled
+			|| !all_stream_disabled || pg_cntl->pg_res_enable[PG_DWB])
+			return;
+	}
+	if (pg_cntl->ctx->dc->debug.ignore_pg)
+		return;
+	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
+	if (org_ip_request_cntl == 0)
+		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);
+
+	/* MPC, OPP, OPTC, DWB */
+	REG_UPDATE(DOMAIN24_PG_CONFIG, DOMAIN_POWER_GATE, power_gate);
+	REG_WAIT(DOMAIN24_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, pwr_status, 1, 1000);
+
+	for (i = 0; i < pg_cntl->ctx->dc->res_pool->pipe_count; i++) {
+		pg_cntl->pg_pipe_res_enable[PG_MPCC][i] = power_on;
+		pg_cntl->pg_pipe_res_enable[PG_OPP][i] = power_on;
+		pg_cntl->pg_pipe_res_enable[PG_OPTC][i] = power_on;
+	}
+	pg_cntl->pg_res_enable[PG_DWB] = power_on;
+}
+
+void pg_cntl35_dwb_pg_control(struct pg_cntl *pg_cntl, bool power_on)
+{
+	if (pg_cntl->ctx->dc->idle_optimizations_allowed)
+		return;
+
+	pg_cntl->pg_res_enable[PG_DWB] = power_on;
+}
+
+static bool pg_cntl35_mem_status(struct pg_cntl *pg_cntl)
+{
+	struct dcn_pg_cntl *pg_cntl_dcn = TO_DCN_PG_CNTL(pg_cntl);
+	uint32_t pwr_status = 0;
+
+	REG_GET(DOMAIN23_PG_STATUS,
+		DOMAIN_PGFSM_PWR_STATUS, &pwr_status);
+
+	return pwr_status == 0;
+}
+
+void pg_cntl35_init_pg_status(struct pg_cntl *pg_cntl)
+{
+	int i = 0;
+	bool block_enabled;
+
+	pg_cntl->pg_res_enable[PG_HPO] = pg_cntl35_hpo_pg_status(pg_cntl);
+
+	block_enabled = pg_cntl35_io_clk_status(pg_cntl);
+	pg_cntl->pg_res_enable[PG_DCCG] = block_enabled;
+	pg_cntl->pg_res_enable[PG_DIO] = block_enabled;
+	pg_cntl->pg_res_enable[PG_DCIO] = block_enabled;
+
+	block_enabled = pg_cntl35_mem_status(pg_cntl);
+	pg_cntl->pg_res_enable[PG_DCHUBBUB] = block_enabled;
+	pg_cntl->pg_res_enable[PG_DCHVM] = block_enabled;
+
+	for (i = 0; i < pg_cntl->ctx->dc->res_pool->pipe_count; i++) {
+		block_enabled = pg_cntl35_hubp_dpp_pg_status(pg_cntl, i);
+		pg_cntl->pg_pipe_res_enable[PG_HUBP][i] = block_enabled;
+		pg_cntl->pg_pipe_res_enable[PG_DPP][i] = block_enabled;
+
+		block_enabled = pg_cntl35_dsc_pg_status(pg_cntl, i);
+		pg_cntl->pg_pipe_res_enable[PG_DSC][i] = block_enabled;
+	}
+
+	block_enabled = pg_cntl35_plane_otg_status(pg_cntl);
+	for (i = 0; i < pg_cntl->ctx->dc->res_pool->pipe_count; i++) {
+		pg_cntl->pg_pipe_res_enable[PG_MPCC][i] = block_enabled;
+		pg_cntl->pg_pipe_res_enable[PG_OPP][i] = block_enabled;
+		pg_cntl->pg_pipe_res_enable[PG_OPTC][i] = block_enabled;
+	}
+	pg_cntl->pg_res_enable[PG_DWB] = block_enabled;
+}
+
+static const struct pg_cntl_funcs pg_cntl35_funcs = {
+	.init_pg_status = pg_cntl35_init_pg_status,
+	.dsc_pg_control = pg_cntl35_dsc_pg_control,
+	.hubp_dpp_pg_control = pg_cntl35_hubp_dpp_pg_control,
+	.hpo_pg_control = pg_cntl35_hpo_pg_control,
+	.io_clk_pg_control = pg_cntl35_io_clk_pg_control,
+	.plane_otg_pg_control = pg_cntl35_plane_otg_pg_control,
+	.mpcc_pg_control = pg_cntl35_mpcc_pg_control,
+	.opp_pg_control = pg_cntl35_opp_pg_control,
+	.optc_pg_control = pg_cntl35_optc_pg_control,
+	.dwb_pg_control = pg_cntl35_dwb_pg_control
+};
+
+struct pg_cntl *pg_cntl35_create(
+	struct dc_context *ctx,
+	const struct pg_cntl_registers *regs,
+	const struct pg_cntl_shift *pg_cntl_shift,
+	const struct pg_cntl_mask *pg_cntl_mask)
+{
+	struct dcn_pg_cntl *pg_cntl_dcn = kzalloc(sizeof(*pg_cntl_dcn), GFP_KERNEL);
+	struct pg_cntl *base;
+
+	if (pg_cntl_dcn == NULL) {
+		BREAK_TO_DEBUGGER();
+		return NULL;
+	}
+
+	base = &pg_cntl_dcn->base;
+	base->ctx = ctx;
+	base->funcs = &pg_cntl35_funcs;
+
+	pg_cntl_dcn->regs = regs;
+	pg_cntl_dcn->pg_cntl_shift = pg_cntl_shift;
+	pg_cntl_dcn->pg_cntl_mask = pg_cntl_mask;
+
+	memset(base->pg_pipe_res_enable, 0, PG_HW_PIPE_RESOURCES_NUM_ELEMENT * MAX_PIPES * sizeof(bool));
+	memset(base->pg_res_enable, 0, PG_HW_RESOURCES_NUM_ELEMENT * sizeof(bool));
+
+	return &pg_cntl_dcn->base;
+}
+
+void dcn_pg_cntl_destroy(struct pg_cntl **pg_cntl)
+{
+	struct dcn_pg_cntl *pg_cntl_dcn = TO_DCN_PG_CNTL(*pg_cntl);
+
+	kfree(pg_cntl_dcn);
+	*pg_cntl = NULL;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.h
new file mode 100644
index 000000000000..d073ce5cc6f3
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.h
@@ -0,0 +1,193 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef _DCN35_PG_CNTL_H_
+#define _DCN35_PG_CNTL_H_
+
+#include "pg_cntl.h"
+
+#define PG_CNTL_REG_LIST_DCN35()\
+	SR(DOMAIN0_PG_CONFIG), \
+	SR(DOMAIN1_PG_CONFIG), \
+	SR(DOMAIN2_PG_CONFIG), \
+	SR(DOMAIN3_PG_CONFIG), \
+	SR(DOMAIN16_PG_CONFIG), \
+	SR(DOMAIN17_PG_CONFIG), \
+	SR(DOMAIN18_PG_CONFIG), \
+	SR(DOMAIN19_PG_CONFIG), \
+	SR(DOMAIN22_PG_CONFIG), \
+	SR(DOMAIN23_PG_CONFIG), \
+	SR(DOMAIN24_PG_CONFIG), \
+	SR(DOMAIN25_PG_CONFIG), \
+	SR(DOMAIN0_PG_STATUS), \
+	SR(DOMAIN1_PG_STATUS), \
+	SR(DOMAIN2_PG_STATUS), \
+	SR(DOMAIN3_PG_STATUS), \
+	SR(DOMAIN16_PG_STATUS), \
+	SR(DOMAIN17_PG_STATUS), \
+	SR(DOMAIN18_PG_STATUS), \
+	SR(DOMAIN19_PG_STATUS), \
+	SR(DOMAIN22_PG_STATUS), \
+	SR(DOMAIN23_PG_STATUS), \
+	SR(DOMAIN24_PG_STATUS), \
+	SR(DOMAIN25_PG_STATUS), \
+	SR(DC_IP_REQUEST_CNTL)
+
+#define PG_CNTL_SF(reg_name, field_name, post_fix)\
+	.field_name = reg_name ## __ ## field_name ## post_fix
+
+#define PG_CNTL_MASK_SH_LIST_DCN35(mask_sh) \
+	PG_CNTL_SF(DOMAIN0_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
+	PG_CNTL_SF(DOMAIN0_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN1_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
+	PG_CNTL_SF(DOMAIN1_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN2_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
+	PG_CNTL_SF(DOMAIN2_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN3_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
+	PG_CNTL_SF(DOMAIN3_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN16_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
+	PG_CNTL_SF(DOMAIN16_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN17_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
+	PG_CNTL_SF(DOMAIN17_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN18_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
+	PG_CNTL_SF(DOMAIN18_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN19_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
+	PG_CNTL_SF(DOMAIN19_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN22_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
+	PG_CNTL_SF(DOMAIN22_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN23_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
+	PG_CNTL_SF(DOMAIN23_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN24_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
+	PG_CNTL_SF(DOMAIN24_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN25_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
+	PG_CNTL_SF(DOMAIN25_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN0_PG_STATUS, DOMAIN_DESIRED_PWR_STATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN0_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
+	PG_CNTL_SF(DOMAIN1_PG_STATUS, DOMAIN_DESIRED_PWR_STATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN1_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
+	PG_CNTL_SF(DOMAIN2_PG_STATUS, DOMAIN_DESIRED_PWR_STATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN2_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
+	PG_CNTL_SF(DOMAIN3_PG_STATUS, DOMAIN_DESIRED_PWR_STATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN3_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
+	PG_CNTL_SF(DOMAIN16_PG_STATUS, DOMAIN_DESIRED_PWR_STATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN16_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
+	PG_CNTL_SF(DOMAIN17_PG_STATUS, DOMAIN_DESIRED_PWR_STATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN17_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
+	PG_CNTL_SF(DOMAIN18_PG_STATUS, DOMAIN_DESIRED_PWR_STATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN18_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
+	PG_CNTL_SF(DOMAIN19_PG_STATUS, DOMAIN_DESIRED_PWR_STATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN19_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
+	PG_CNTL_SF(DOMAIN22_PG_STATUS, DOMAIN_DESIRED_PWR_STATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN22_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
+	PG_CNTL_SF(DOMAIN23_PG_STATUS, DOMAIN_DESIRED_PWR_STATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN23_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
+	PG_CNTL_SF(DOMAIN24_PG_STATUS, DOMAIN_DESIRED_PWR_STATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN24_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
+	PG_CNTL_SF(DOMAIN25_PG_STATUS, DOMAIN_DESIRED_PWR_STATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN25_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
+	PG_CNTL_SF(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, mask_sh)
+
+#define PG_CNTL_REG_FIELD_LIST(type) \
+	type IPS2;\
+	type IPS1;\
+	type IPS0;\
+	type IPS0_All
+
+#define PG_CNTL_DCN35_REG_FIELD_LIST(type) \
+	type IP_REQUEST_EN; \
+	type DOMAIN_POWER_FORCEON; \
+	type DOMAIN_POWER_GATE; \
+	type DOMAIN_DESIRED_PWR_STATE; \
+	type DOMAIN_PGFSM_PWR_STATUS
+
+struct pg_cntl_shift {
+	PG_CNTL_REG_FIELD_LIST(uint8_t);
+	PG_CNTL_DCN35_REG_FIELD_LIST(uint8_t);
+};
+
+struct pg_cntl_mask {
+	PG_CNTL_REG_FIELD_LIST(uint32_t);
+	PG_CNTL_DCN35_REG_FIELD_LIST(uint32_t);
+};
+
+struct pg_cntl_registers {
+	uint32_t LONO_STATE;
+	uint32_t DC_IP_REQUEST_CNTL;
+	uint32_t DOMAIN0_PG_CONFIG;
+	uint32_t DOMAIN1_PG_CONFIG;
+	uint32_t DOMAIN2_PG_CONFIG;
+	uint32_t DOMAIN3_PG_CONFIG;
+	uint32_t DOMAIN16_PG_CONFIG;
+	uint32_t DOMAIN17_PG_CONFIG;
+	uint32_t DOMAIN18_PG_CONFIG;
+	uint32_t DOMAIN19_PG_CONFIG;
+	uint32_t DOMAIN22_PG_CONFIG;
+	uint32_t DOMAIN23_PG_CONFIG;
+	uint32_t DOMAIN24_PG_CONFIG;
+	uint32_t DOMAIN25_PG_CONFIG;
+	uint32_t DOMAIN0_PG_STATUS;
+	uint32_t DOMAIN1_PG_STATUS;
+	uint32_t DOMAIN2_PG_STATUS;
+	uint32_t DOMAIN3_PG_STATUS;
+	uint32_t DOMAIN16_PG_STATUS;
+	uint32_t DOMAIN17_PG_STATUS;
+	uint32_t DOMAIN18_PG_STATUS;
+	uint32_t DOMAIN19_PG_STATUS;
+	uint32_t DOMAIN22_PG_STATUS;
+	uint32_t DOMAIN23_PG_STATUS;
+	uint32_t DOMAIN24_PG_STATUS;
+	uint32_t DOMAIN25_PG_STATUS;
+};
+
+struct dcn_pg_cntl {
+	struct pg_cntl base;
+	const struct pg_cntl_registers *regs;
+	const struct pg_cntl_shift *pg_cntl_shift;
+	const struct pg_cntl_mask *pg_cntl_mask;
+};
+
+void pg_cntl35_dsc_pg_control(struct pg_cntl *pg_cntl, unsigned int dsc_inst, bool power_on);
+void pg_cntl35_hubp_dpp_pg_control(struct pg_cntl *pg_cntl,
+	unsigned int hubp_dpp_inst, bool power_on);
+void pg_cntl35_hpo_pg_control(struct pg_cntl *pg_cntl, bool power_on);
+void pg_cntl35_io_clk_pg_control(struct pg_cntl *pg_cntl, bool power_on);
+void pg_cntl35_plane_otg_pg_control(struct pg_cntl *pg_cntl, bool power_on);
+void pg_cntl35_mpcc_pg_control(struct pg_cntl *pg_cntl,
+	unsigned int mpcc_inst, bool power_on);
+void pg_cntl35_opp_pg_control(struct pg_cntl *pg_cntl,
+	unsigned int opp_inst, bool power_on);
+void pg_cntl35_optc_pg_control(struct pg_cntl *pg_cntl,
+	unsigned int optc_inst, bool power_on);
+void pg_cntl35_dwb_pg_control(struct pg_cntl *pg_cntl, bool power_on);
+void pg_cntl35_init_pg_status(struct pg_cntl *pg_cntl);
+
+struct pg_cntl *pg_cntl35_create(
+	struct dc_context *ctx,
+	const struct pg_cntl_registers *regs,
+	const struct pg_cntl_shift *pg_cntl_shift,
+	const struct pg_cntl_mask *pg_cntl_mask);
+
+void dcn_pg_cntl_destroy(struct pg_cntl **pg_cntl);
+
+#endif /* DCN35_PG_CNTL */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index ce3cab30c0fd..68adfaf23475 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -38,6 +38,7 @@
 #include "mcif_wb.h"
 #include "panel_cntl.h"
 #include "dmub/inc/dmub_cmd.h"
+#include "pg_cntl.h"
 
 #define MAX_CLOCK_SOURCES 7
 #define MAX_SVP_PHANTOM_STREAMS 2
@@ -274,6 +275,7 @@ struct resource_pool {
 	struct audio_support audio_support;
 
 	struct dccg *dccg;
+	struct pg_cntl *pg_cntl;
 	struct irq_service *irqs;
 
 	struct abm *abm;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h b/drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h
new file mode 100644
index 000000000000..00ea3864dd4d
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h
@@ -0,0 +1,52 @@
+/* Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef __DC_PG_CNTL_H__
+#define __DC_PG_CNTL_H__
+
+#include "dc.h"
+#include "dc_types.h"
+#include "hw_shared.h"
+
+struct pg_cntl {
+	struct dc_context *ctx;
+	const struct pg_cntl_funcs *funcs;
+	bool pg_pipe_res_enable[PG_HW_PIPE_RESOURCES_NUM_ELEMENT][MAX_PIPES];
+	bool pg_res_enable[PG_HW_RESOURCES_NUM_ELEMENT];
+};
+
+struct pg_cntl_funcs {
+	void (*dsc_pg_control)(struct pg_cntl *pg_cntl, unsigned int dsc_inst, bool power_on);
+	void (*hubp_dpp_pg_control)(struct pg_cntl *pg_cntl, unsigned int hubp_dpp_inst, bool power_on);
+	void (*hpo_pg_control)(struct pg_cntl *pg_cntl, bool power_on);
+	void (*io_clk_pg_control)(struct pg_cntl *pg_cntl, bool power_on);
+	void (*plane_otg_pg_control)(struct pg_cntl *pg_cntl, bool power_on);
+	void (*mpcc_pg_control)(struct pg_cntl *pg_cntl, unsigned int mpcc_inst, bool power_on);
+	void (*opp_pg_control)(struct pg_cntl *pg_cntl, unsigned int opp_inst, bool power_on);
+	void (*optc_pg_control)(struct pg_cntl *pg_cntl, unsigned int optc_inst, bool power_on);
+	void (*dwb_pg_control)(struct pg_cntl *pg_cntl, bool power_on);
+	void (*init_pg_status)(struct pg_cntl *pg_cntl);
+};
+
+#endif //__DC_PG_CNTL_H__
-- 
2.41.0

