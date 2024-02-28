Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F87C47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 21:17:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95FEC10E314;
	Wed, 28 Feb 2024 21:17:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZDEyAs3C";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC25610E314
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 21:17:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1/dEIzBmBQSg499LUVpoDFm1Shlqa5mGITWmCvRiLw69/3DF+tDtYDw5SxofXYJe0rcQf0Eg1hKVtTvkzJ+cjQqyXBhN5gStTCLdcDhQ2wnUUummE5pehfMQ+TT21n8cptB8VirAvwKA/528EPObCDr0AUUuUK6uYnw0X+BcoKvxKS2f9YofYgTcSPM64UrO793L+veJiLo9Yd7xh3GL3j22tdhFuTKaiQyuC+e51S/GxCUQhDY/JU5EQQDxO20uKYacgdjTNCqJk3K3uBndBFwIeZqG8EsNBRZ4JMN3yo4S3imoSEdC2JNP6HxUgppUQtOi7el0BiPgmSDqu+c9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1ukRmS7bYlQcod6RPyjz5kADW+I+1+e2EwWAO2tDyQ=;
 b=LzufuhNkirQE6HTudd/C44ssq36mKWqisNZ7BgxtJ1/Lb1di3ROOEnSNfgWvAgP9whxmiwy3JolOc1YVqPs0L4zElRgNhlIo+rn70Feykff/7m1h5xSFCQkD6csOmFM5oah6Od66yB1WUp6rKArThQpv0lOX6+dKaPjITBMH2DUbXHDL7sI59QdV1J3elLnC1/kKIzfZOt4CynV95sluNhXir+beSO7gDuidh8pstoA1rWRFny3235ezRSrj/v98sQ0do2p9luHMw0+oMpdeppupkmuRRnJ6JmWf3WdseILoEaZhofzDX/79t1T9sgbQsGRK6OJkqNPc6rH43tl7eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1ukRmS7bYlQcod6RPyjz5kADW+I+1+e2EwWAO2tDyQ=;
 b=ZDEyAs3C3j2DrtehGR9cqmE4fYp3fDb0nHVkStzfA7prV2hWRFrc/0OFeRCLKh6IwO2hG/MMTeddCXBbxadAaZAyPB2A0zRqmkrEdc71bciivZD0naHtq+niMqSvWfN9oj+PzmKhB8rIy4Sp0pmx8Lsy+8pbRCHgzlR+hUxRpDw=
Received: from BN0PR04CA0008.namprd04.prod.outlook.com (2603:10b6:408:ee::13)
 by SA1PR12MB6679.namprd12.prod.outlook.com (2603:10b6:806:252::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 21:17:05 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com (2603:10b6:408:ee::4)
 by BN0PR04CA0008.outlook.office365.com (2603:10b6:408:ee::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.50 via Frontend Transport; Wed, 28 Feb 2024 21:17:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 21:17:05 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 15:17:01 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 3/6] drm/amd/display: add DMUB source files and changes for
 DCN351
Date: Wed, 28 Feb 2024 16:16:34 -0500
Message-ID: <20240228211638.36109-3-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228211638.36109-1-hamza.mahfooz@amd.com>
References: <20240228211638.36109-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|SA1PR12MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: af1b52dd-225d-4711-f321-08dc38a29d13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rJArvoulLmGEtW57CshchA8QCohTQFMLUA5yOg0U1qTvLu7oFJ+kDwrhMeNCD7qx8QznB+4E3v7gvm/8X0vgWhcqLUy5YSxQG+xZNdMH33kpYIf0bhR9UPbdRLJ4q1pRWR+9iRDjrE1ieG9zDRK7rV21yQCXEUxD8saaIaCwrHupoemrh6oXs43h4ZiKl2fE9lqFABVmaFIxFMvXXjrzmd96o5COcCrGv7t9VwApkvGDaRt51HW39KOf5RhcdUW6MVL/ZuqXMEp6v7Zsp62jn/gS3lcRtXfyikE7yg3PZkwgCsUkzVLzjIv7K6RqXo/ouoAR8ZAmWEb6oNYAOHDDVOU2nIXANqC8SRYPb/8VnC9YtjqopBVnE1eq/2EQdmNvX8JJCUD0hD4tZNFFfFg3UHzI3Jm1IWMN0CzYLuD+e4kjaZB6sltjwtL1nDGMVMiS5JkGexeih79j1gNLgBiLUbL+8kcvWmwR9poSG8U3vMaT5dzWyauEfT6U6MsU7+SxmpRm6avvTO+b0Xxvdk6v/r3Gkmrw5q/CJ04+dQDihHdOMVTmP3OJstt2G43t4SVG7GbvH2dRqMCmVH5yhXzFC3VolomJZ3V/uTZKOQp1JM3iYHAwxTzFWh3ZYTPmy+xmZQWBo+L40v7o3h//Zqq//dpveDTwXLXZVV3qoI755OBEtbaSLGd/1X9rd+z3RHPm/0eGiFXAuMFWfm+be4k9/jT/AsZAwRqy9pz25dVBSMYK0e2xmrYg1RLbHZjNiJ89
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 21:17:05.0486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af1b52dd-225d-4711-f321-08dc38a29d13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6679
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

DMUB support is required to light-up displays.

Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/Makefile |  1 +
 .../drm/amd/display/dmub/src/dmub_dcn351.c    | 34 +++++++++++++++++++
 .../drm/amd/display/dmub/src/dmub_dcn351.h    | 13 +++++++
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  4 +++
 4 files changed, 52 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn351.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn351.h

diff --git a/drivers/gpu/drm/amd/display/dmub/src/Makefile b/drivers/gpu/drm/amd/display/dmub/src/Makefile
index 08aaf84affaf..50a98448e2e8 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/Makefile
+++ b/drivers/gpu/drm/amd/display/dmub/src/Makefile
@@ -25,6 +25,7 @@ DMUB += dmub_dcn30.o dmub_dcn301.o dmub_dcn302.o dmub_dcn303.o
 DMUB += dmub_dcn31.o dmub_dcn314.o dmub_dcn315.o dmub_dcn316.o
 DMUB += dmub_dcn32.o
 DMUB += dmub_dcn35.o
+DMUB += dmub_dcn351.o
 
 AMD_DAL_DMUB = $(addprefix $(AMDDALPATH)/dmub/src/,$(DMUB))
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn351.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn351.c
new file mode 100644
index 000000000000..8f40b9f6706c
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn351.c
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright 2024 Advanced Micro Devices, Inc. */
+
+#include "../dmub_srv.h"
+#include "dmub_reg.h"
+#include "dmub_dcn351.h"
+
+#include "dcn/dcn_3_5_1_offset.h"
+#include "dcn/dcn_3_5_1_sh_mask.h"
+
+#define BASE_INNER(seg) ctx->dcn_reg_offsets[seg]
+#define CTX dmub
+#define REGS dmub->regs_dcn35
+#define REG_OFFSET_EXP(reg_name) BASE(reg##reg_name##_BASE_IDX) + reg##reg_name
+
+void dmub_srv_dcn351_regs_init(struct dmub_srv *dmub, struct dc_context *ctx)
+{
+	struct dmub_srv_dcn35_regs *regs = dmub->regs_dcn35;
+#define REG_STRUCT regs
+
+#define DMUB_SR(reg) REG_STRUCT->offset.reg = REG_OFFSET_EXP(reg);
+	DMUB_DCN35_REGS()
+	DMCUB_INTERNAL_REGS()
+#undef DMUB_SR
+
+#define DMUB_SF(reg, field) REG_STRUCT->mask.reg##__##field = FD_MASK(reg, field);
+	DMUB_DCN35_FIELDS()
+#undef DMUB_SF
+
+#define DMUB_SF(reg, field) REG_STRUCT->shift.reg##__##field = FD_SHIFT(reg, field);
+	DMUB_DCN35_FIELDS()
+#undef DMUB_SF
+#undef REG_STRUCT
+}
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn351.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn351.h
new file mode 100644
index 000000000000..4121fa1b301d
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn351.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright 2024 Advanced Micro Devices, Inc. */
+
+#ifndef _DMUB_DCN351_H_
+#define _DMUB_DCN351_H_
+
+#include "dmub_dcn35.h"
+
+struct dmub_srv;
+
+void dmub_srv_dcn351_regs_init(struct dmub_srv *dmub, struct dc_context *ctx);
+
+#endif /* _DMUB_DCN351_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index cd97983cf759..90e878195d95 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -37,6 +37,7 @@
 #include "dmub_dcn316.h"
 #include "dmub_dcn32.h"
 #include "dmub_dcn35.h"
+#include "dmub_dcn351.h"
 #include "os_types.h"
 /*
  * Note: the DMUB service is standalone. No additional headers should be
@@ -315,6 +316,7 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 		break;
 
 	case DMUB_ASIC_DCN35:
+	case DMUB_ASIC_DCN351:
 			dmub->regs_dcn35 = &dmub_srv_dcn35_regs;
 			funcs->configure_dmub_in_system_memory = dmub_dcn35_configure_dmub_in_system_memory;
 			funcs->send_inbox0_cmd = dmub_dcn35_send_inbox0_cmd;
@@ -351,6 +353,8 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 			funcs->get_diagnostic_data = dmub_dcn35_get_diagnostic_data;
 
 			funcs->init_reg_offsets = dmub_srv_dcn35_regs_init;
+			if (asic == DMUB_ASIC_DCN351)
+                                funcs->init_reg_offsets = dmub_srv_dcn351_regs_init;
 
 			funcs->is_hw_powered_up = dmub_dcn35_is_hw_powered_up;
 			funcs->should_detect = dmub_dcn35_should_detect;
-- 
2.43.0

