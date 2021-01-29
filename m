Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB21C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7B064E0B
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7B064E0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 431AC6EC2D;
	Fri, 29 Jan 2021 21:28:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE20C6EC2A
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 21:28:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epGhoD9l8Paxm21eVlLDzwvJCwkdRLVpAI1LR6xqYMvs/Ayp3mTZBnCCEFZuLInEHfZ/kIu2bXaWd+YqywCTjhtiWBmbAyCajDFC/olfwjXhM7i0KDTrKhWFvmjMh8PXmTb/1iYKneCG8vBqhUUF8xc9CdOfiRfETWivyc94sNhX292vDCsOA0ViRkd6+M9cp06nfQzwVsYqNLN5vnHT+eWkCLrjoTuXPgYZQ+j45JmSymPyArDqAhxPPhCHbmAplUt9ZPr2SdQR/HBOTYm23sdDMWljhWnjoS6NeJUNBcT0+uZyJin7nCh17LJguY8rtSWK8Nmtb+7Mxr0AjQFWww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7sj7UEKChwk1aCQwLOLc4pX7wSCwh/dTungITuQQGg=;
 b=OlZprvPeiQ7L4saE6uqLfpJ/2nLpyzSw4cA2t3+lUhiSlnIJm4bcPkuSJpjIzD+t00TztLyKt7fUYPykaSjhD8FNZTf+dMz+ZS4X1l95vnOYAlvdZGxcLh4OqlpERt4fYNL+KuqBAfJNMV4ZECXt3Elk5Jkn5JFqcqx5KifG90XQDWJdgX7teA8iBmT4/rLIyPnaqs9xYX1bCmDMvho/2zKLRBcs1cDwaxGlW+j/r1jGQlt+TPrNpxkViRB/l2ZC2NEMTsuGKjT6SwAyx5jCOMlXT+l5uVltXgJvPG1aauJRn7+kMGtA8psqDj8JgwEsLZVseLzQuXPdBuCO9jH59Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7sj7UEKChwk1aCQwLOLc4pX7wSCwh/dTungITuQQGg=;
 b=G/nKDII+E3LBsxUPEY5wMgofJ1/SBd59+2qC1gQDwOFvkJD29bu42JM1rNZKALovHXZrCkhYpfchH+LKtCAuwriRaKAKpRNZ3WYxeL0gXvJg5J30AKOndQlPfxerrX/sM+HCWIiEOE7JyqdMk71enpbLrfgccdBKd2Ewuwa0wbQ=
Received: from MW4PR03CA0245.namprd03.prod.outlook.com (2603:10b6:303:b4::10)
 by MN2PR12MB3278.namprd12.prod.outlook.com (2603:10b6:208:ac::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Fri, 29 Jan
 2021 21:28:24 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::c0) by MW4PR03CA0245.outlook.office365.com
 (2603:10b6:303:b4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend
 Transport; Fri, 29 Jan 2021 21:28:24 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 29 Jan 2021 21:28:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:22 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:22 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 29 Jan 2021 15:28:21 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/27] drm/amd/display: Add Freesync HDMI support to DMCU
Date: Fri, 29 Jan 2021 16:27:44 -0500
Message-ID: <20210129212752.38865-20-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129212752.38865-1-Anson.Jacob@amd.com>
References: <20210129212752.38865-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b74dc937-62a9-47c8-226c-08d8c49ccedc
X-MS-TrafficTypeDiagnostic: MN2PR12MB3278:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3278392C146B9A628944586FEBB99@MN2PR12MB3278.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M+quS7YWkQzFbxIRVSxp8nSqTuUG6mpzr90whOPNpLnEAKdGMRLWz/mr8CDZvHZLkDsiYTxtAUo7h6Z0kdlkXmib21cQSwq8sCrnJ9LhAW8oQvfqLvCavrEC58I3Q/Gya0iX4b9xatSOeVYUpWxzE+ZXt2tn483t2D6nIXnTXirFCd89WbIPwwKTzknblcalCalfoCyjSsAWwrP2VOczzEpLm8v8CQAb7J+skqklr0iLlikbMffMh6zxyszLQosdF81U1CdGS4W6NsrJ6MUPby7uyyKdEg6DC9OIyDXo1HvJx5czNrcHV7cDUGXqzFjZ4WAPsaiYDsSVMZn3oI9Gt2RCYfuZ2/3fRsKeseb09cwXMnEfLQvq1xERqB0hIaA24ncliEktM0wjb9FjMWwgSzItOxBJBR9Ef+4j4kzFIvARvWEzgsd92UnXxTt8Vj/MZmaeSy2PvqQNEjGae0qlG626qSvHjXgRPWoTUaKpBGJUZXH5JIXDPUyz05KFIG/Q1tOfcgRLMR1TKSYHtTMfK3xnwowBEUYs0FvT2ExE51a5D3C7OWYFr9GXKq5GHd+RbiHRGCakj2je1zoN/nEyKTPWB1cSv7gWYCbXFKxF7DQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(46966006)(83380400001)(26005)(316002)(2906002)(81166007)(6916009)(186003)(4326008)(70586007)(336012)(426003)(70206006)(86362001)(2616005)(478600001)(7696005)(82740400003)(36756003)(82310400003)(6666004)(30864003)(356005)(8936002)(5660300002)(1076003)(47076005)(8676002)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 21:28:23.5781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b74dc937-62a9-47c8-226c-08d8c49ccedc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3278
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Hersen Wu <hersenxs.wu@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

[Why]
Adding support for Freesync HDMI to DC and DMCU

[How]
Create DC interface and implementation on top of DMCU to support
parsing CEA blocks in DMCU.

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile       |   4 +-
 .../gpu/drm/amd/display/dc/dc_edid_parser.c   |  80 ++++++++++++
 .../gpu/drm/amd/display/dc/dc_edid_parser.h   |  44 +++++++
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c | 120 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h |  11 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h  |  10 ++
 6 files changed, 268 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_edid_parser.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_edid_parser.h

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index bf8fe0471b8f..5bf2f2375b40 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -69,5 +69,7 @@ AMD_DISPLAY_FILES += $(AMD_DISPLAY_CORE)
 AMD_DISPLAY_FILES += $(AMD_DM_REG_UPDATE)
 
 DC_DMUB += dc_dmub_srv.o
+DC_EDID += dc_edid_parser.o
 AMD_DISPLAY_DMUB = $(addprefix $(AMDDALPATH)/dc/,$(DC_DMUB))
-AMD_DISPLAY_FILES += $(AMD_DISPLAY_DMUB)
+AMD_DISPLAY_EDID = $(addprefix $(AMDDALPATH)/dc/,$(DC_EDID))
+AMD_DISPLAY_FILES += $(AMD_DISPLAY_DMUB) $(AMD_DISPLAY_EDID)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_edid_parser.c b/drivers/gpu/drm/amd/display/dc/dc_edid_parser.c
new file mode 100644
index 000000000000..0db5b49e9d5e
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dc_edid_parser.c
@@ -0,0 +1,80 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
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
+#include "dce/dce_dmcu.h"
+#include "dc_edid_parser.h"
+
+bool dc_edid_parser_send_cea(struct dc *dc,
+		int offset,
+		int total_length,
+		uint8_t *data,
+		int length)
+{
+	struct dmcu *dmcu = dc->res_pool->dmcu;
+
+	if (dmcu &&
+	    dmcu->funcs->is_dmcu_initialized(dmcu) &&
+	    dmcu->funcs->send_edid_cea) {
+		return dmcu->funcs->send_edid_cea(dmcu,
+				offset,
+				total_length,
+				data,
+				length);
+	}
+
+	return false;
+}
+
+bool dc_edid_parser_recv_cea_ack(struct dc *dc, int *offset)
+{
+	struct dmcu *dmcu = dc->res_pool->dmcu;
+
+	if (dmcu &&
+	    dmcu->funcs->is_dmcu_initialized(dmcu) &&
+	    dmcu->funcs->recv_edid_cea_ack) {
+		return dmcu->funcs->recv_edid_cea_ack(dmcu, offset);
+	}
+
+	return false;
+}
+
+bool dc_edid_parser_recv_amd_vsdb(struct dc *dc,
+		int *version,
+		int *min_frame_rate,
+		int *max_frame_rate)
+{
+	struct dmcu *dmcu = dc->res_pool->dmcu;
+
+	if (dmcu &&
+	    dmcu->funcs->is_dmcu_initialized(dmcu) &&
+	    dmcu->funcs->recv_amd_vsdb) {
+		return dmcu->funcs->recv_amd_vsdb(dmcu,
+				version,
+				min_frame_rate,
+				max_frame_rate);
+	}
+
+	return false;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_edid_parser.h b/drivers/gpu/drm/amd/display/dc/dc_edid_parser.h
new file mode 100644
index 000000000000..da67ec06f0a2
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dc_edid_parser.h
@@ -0,0 +1,44 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
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
+#ifndef _DC_EDID_PARSER_H_
+#define _DC_EDID_PARSER_H_
+
+#include "core_types.h"
+
+bool dc_edid_parser_send_cea(struct dc *dc,
+		int offset,
+		int total_length,
+		uint8_t *data,
+		int length);
+
+bool dc_edid_parser_recv_cea_ack(struct dc *dc, int *offset);
+
+bool dc_edid_parser_recv_amd_vsdb(struct dc *dc,
+		int *version,
+		int *min_frame_rate,
+		int *max_frame_rate);
+
+#endif /* _DC_EDID_PARSER_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
index 30264fc151a2..ddc789daf3b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
@@ -57,6 +57,9 @@
 #define MCP_SYNC_PHY_LOCK 0x90
 #define MCP_SYNC_PHY_UNLOCK 0x91
 #define MCP_BL_SET_PWM_FRAC 0x6A  /* Enable or disable Fractional PWM */
+#define MCP_SEND_EDID_CEA 0xA0
+#define EDID_CEA_CMD_ACK 1
+#define EDID_CEA_CMD_NACK 2
 #define MASTER_COMM_CNTL_REG__MASTER_COMM_INTERRUPT_MASK   0x00000001L
 
 // PSP FW version
@@ -811,6 +814,120 @@ static bool dcn20_unlock_phy(struct dmcu *dmcu)
 	return true;
 }
 
+static bool dcn10_send_edid_cea(struct dmcu *dmcu,
+		int offset,
+		int total_length,
+		uint8_t *data,
+		int length)
+{
+	struct dce_dmcu *dmcu_dce = TO_DCE_DMCU(dmcu);
+	uint32_t header, data1, data2;
+
+	/* If microcontroller is not running, do nothing */
+	if (dmcu->dmcu_state != DMCU_RUNNING)
+		return false;
+
+	if (length > 8 || length <= 0)
+		return false;
+
+	header = ((uint32_t)offset & 0xFFFF) << 16 | (total_length & 0xFFFF);
+	data1 = (((uint32_t)data[0]) << 24) | (((uint32_t)data[1]) << 16) |
+		(((uint32_t)data[2]) << 8) | ((uint32_t)data[3]);
+	data2 = (((uint32_t)data[4]) << 24) | (((uint32_t)data[5]) << 16) |
+		(((uint32_t)data[6]) << 8) | ((uint32_t)data[7]);
+
+	/* waitDMCUReadyForCmd */
+	REG_WAIT(MASTER_COMM_CNTL_REG, MASTER_COMM_INTERRUPT, 0, 1, 10000);
+
+	/* setDMCUParam_Cmd */
+	REG_UPDATE(MASTER_COMM_CMD_REG, MASTER_COMM_CMD_REG_BYTE0, MCP_SEND_EDID_CEA);
+
+	REG_WRITE(MASTER_COMM_DATA_REG1, header);
+	REG_WRITE(MASTER_COMM_DATA_REG2, data1);
+	REG_WRITE(MASTER_COMM_DATA_REG3, data2);
+
+	/* notifyDMCUMsg */
+	REG_UPDATE(MASTER_COMM_CNTL_REG, MASTER_COMM_INTERRUPT, 1);
+
+	/* waitDMCUReadyForCmd */
+	REG_WAIT(MASTER_COMM_CNTL_REG, MASTER_COMM_INTERRUPT, 0, 1, 10000);
+
+	return true;
+}
+
+static bool dcn10_get_scp_results(struct dmcu *dmcu,
+		uint32_t *cmd,
+		uint32_t *data1,
+		uint32_t *data2,
+		uint32_t *data3)
+{
+	struct dce_dmcu *dmcu_dce = TO_DCE_DMCU(dmcu);
+
+	/* If microcontroller is not running, do nothing */
+	if (dmcu->dmcu_state != DMCU_RUNNING)
+		return false;
+
+	*cmd = REG_READ(SLAVE_COMM_CMD_REG);
+	*data1 =  REG_READ(SLAVE_COMM_DATA_REG1);
+	*data2 =  REG_READ(SLAVE_COMM_DATA_REG2);
+	*data3 =  REG_READ(SLAVE_COMM_DATA_REG3);
+
+	/* clear SCP interrupt */
+	REG_UPDATE(SLAVE_COMM_CNTL_REG, SLAVE_COMM_INTERRUPT, 0);
+
+	return true;
+}
+
+static bool dcn10_recv_amd_vsdb(struct dmcu *dmcu,
+		int *version,
+		int *min_frame_rate,
+		int *max_frame_rate)
+{
+	uint32_t data[4];
+	int cmd, ack, len;
+
+	if (!dcn10_get_scp_results(dmcu, &data[0], &data[1], &data[2], &data[3]))
+		return false;
+
+	cmd = data[0] & 0x3FF;
+	len = (data[0] >> 10) & 0x3F;
+	ack = data[1];
+
+	if (cmd != MCP_SEND_EDID_CEA || ack != EDID_CEA_CMD_ACK || len != 12)
+		return false;
+
+	if ((data[2] & 0xFF)) {
+		*version = (data[2] >> 8) & 0xFF;
+		*min_frame_rate = (data[3] >> 16) & 0xFFFF;
+		*max_frame_rate = data[3] & 0xFFFF;
+		return true;
+	}
+
+	return false;
+}
+
+static bool dcn10_recv_edid_cea_ack(struct dmcu *dmcu, int *offset)
+{
+	uint32_t data[4];
+	int cmd, ack;
+
+	if (!dcn10_get_scp_results(dmcu,
+				&data[0], &data[1], &data[2], &data[3]))
+		return false;
+
+	cmd = data[0] & 0x3FF;
+	ack = data[1];
+
+	if (cmd != MCP_SEND_EDID_CEA)
+		return false;
+
+	if (ack == EDID_CEA_CMD_ACK)
+		return true;
+
+	*offset = data[2]; /* nack */
+	return false;
+}
+
 #endif //(CONFIG_DRM_AMD_DC_DCN)
 
 static const struct dmcu_funcs dce_funcs = {
@@ -833,6 +950,9 @@ static const struct dmcu_funcs dcn10_funcs = {
 	.get_psr_state = dcn10_get_dmcu_psr_state,
 	.set_psr_wait_loop = dcn10_psr_wait_loop,
 	.get_psr_wait_loop = dcn10_get_psr_wait_loop,
+	.send_edid_cea = dcn10_send_edid_cea,
+	.recv_amd_vsdb = dcn10_recv_amd_vsdb,
+	.recv_edid_cea_ack = dcn10_recv_edid_cea_ack,
 	.is_dmcu_initialized = dcn10_is_dmcu_initialized
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h
index cefb7f5bf42c..ff726b35ef6a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h
@@ -40,6 +40,10 @@
 	SR(MASTER_COMM_DATA_REG3), \
 	SR(MASTER_COMM_CMD_REG), \
 	SR(MASTER_COMM_CNTL_REG), \
+	SR(SLAVE_COMM_DATA_REG1), \
+	SR(SLAVE_COMM_DATA_REG2), \
+	SR(SLAVE_COMM_DATA_REG3), \
+	SR(SLAVE_COMM_CMD_REG), \
 	SR(DMCU_IRAM_RD_CTRL), \
 	SR(DMCU_IRAM_RD_DATA), \
 	SR(DMCU_INTERRUPT_TO_UC_EN_MASK), \
@@ -112,6 +116,7 @@
 	DMCU_SF(MASTER_COMM_CMD_REG, \
 			MASTER_COMM_CMD_REG_BYTE0, mask_sh), \
 	DMCU_SF(MASTER_COMM_CNTL_REG, MASTER_COMM_INTERRUPT, mask_sh), \
+	DMCU_SF(SLAVE_COMM_CNTL_REG, SLAVE_COMM_INTERRUPT, mask_sh), \
 	DMCU_SF(DMCU_INTERRUPT_TO_UC_EN_MASK, \
 			STATIC_SCREEN1_INT_TO_UC_EN, mask_sh), \
 	DMCU_SF(DMCU_INTERRUPT_TO_UC_EN_MASK, \
@@ -179,6 +184,7 @@
 	type UC_IN_RESET; \
 	type MASTER_COMM_CMD_REG_BYTE0; \
 	type MASTER_COMM_INTERRUPT; \
+	type SLAVE_COMM_INTERRUPT; \
 	type DPHY_RX_FAST_TRAINING_CAPABLE; \
 	type DPHY_LOAD_BS_COUNT; \
 	type STATIC_SCREEN1_INT_TO_UC_EN; \
@@ -211,6 +217,11 @@ struct dce_dmcu_registers {
 	uint32_t MASTER_COMM_DATA_REG3;
 	uint32_t MASTER_COMM_CMD_REG;
 	uint32_t MASTER_COMM_CNTL_REG;
+	uint32_t SLAVE_COMM_DATA_REG1;
+	uint32_t SLAVE_COMM_DATA_REG2;
+	uint32_t SLAVE_COMM_DATA_REG3;
+	uint32_t SLAVE_COMM_CMD_REG;
+	uint32_t SLAVE_COMM_CNTL_REG;
 	uint32_t DMCU_IRAM_RD_CTRL;
 	uint32_t DMCU_IRAM_RD_DATA;
 	uint32_t DMCU_INTERRUPT_TO_UC_EN_MASK;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h
index 69d9fbfb4bec..cd1c0dc32bf8 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h
@@ -74,6 +74,16 @@ struct dmcu_funcs {
 	bool (*is_dmcu_initialized)(struct dmcu *dmcu);
 	bool (*lock_phy)(struct dmcu *dmcu);
 	bool (*unlock_phy)(struct dmcu *dmcu);
+	bool (*send_edid_cea)(struct dmcu *dmcu,
+			int offset,
+			int total_length,
+			uint8_t *data,
+			int length);
+	bool (*recv_amd_vsdb)(struct dmcu *dmcu,
+			int *version,
+			int *min_frame_rate,
+			int *max_frame_rate);
+	bool (*recv_edid_cea_ack)(struct dmcu *dmcu, int *offset);
 };
 
 #endif
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
