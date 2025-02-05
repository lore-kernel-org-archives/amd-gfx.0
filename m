Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AB2C02196
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 03:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B32A910E723;
	Wed,  5 Feb 2025 03:13:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FKlc6hYe";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6119110E722
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 03:11:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qf33mAo3f5n8kbUnIrJS/XK7JkHdo6a+jLw3c6OKFmvfPZxbv1KVoJUTig1H8pJrUwlgjTZwk2jQ6oKcLRFyt/tbspb8z7UZyaybjlNwLH68z8PlJJDC0TxD8kDvxlv1RZNS0A2WVlk7sD1qZbo22QFMHNYdm8hzbL/0T9DYQkOuwwJRaOgfFXFdGbWC2CD6ADAV+afLEiOotTmoqyGSx6GRd+t+AW4K7FtAYtso1yk7Yw9q2RG9ftABx29caDL/Xaqn0Yaw8rvkQpwAF3yvF9DSQ9K0r/9A1MPvulb3XVE8Rfhs01aUFtBu8Kdz4iUX8a8m8JF0D0z0DX+iG7Q+nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VfuY9ifTRDn6T2ApSnGzODnqll+hjW9Ty+wFun9aQ0=;
 b=u8RWVSIAAr8Sk8M6hM7q2b4vtcSEcYk6QiwPXYsfgRa/MEx6ENhPa/isccvavmN/SLsR4oCKjtkdQ7ZBqgsaiW8jBqiDqc6FzrwzaJ31TmUS86r2kvEqZyxNkMVqbGb2/lf/1+fOAo5NgDTQEmQ+tPklPhNWjZdZ5W6yDNC7H7OmTaXESh1FrRbbVCnKeBEym8MyiZBNJWldyPRjHvYHvgL93+LLGfXMsnLCgYuGTtsKP1Jki7v+kvJvYNPYRkeQ4PStseuZgszoPb7Sr5ZhPFUCRPOdRndciJxGpKQ1+hVN+fuzPWJh9FvATDf3NNggJeev5axSIqrbYW3T8jROwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VfuY9ifTRDn6T2ApSnGzODnqll+hjW9Ty+wFun9aQ0=;
 b=FKlc6hYeVnHigCXePBs5/A6QbrqZlxDXupUJjeU8BelannokjixKHZaffbElqmlcd5P/YwrvjgUAP1TPnHfhgHklCviaJYuNZWOpOiW1B392fs/fFWtwZCPKiFhjJkwLBSiiOCingQ5O0y5SWG4spCEb7vFqXIQQLsC8B/8oLH8=
Received: from CH2PR20CA0018.namprd20.prod.outlook.com (2603:10b6:610:58::28)
 by PH7PR12MB7211.namprd12.prod.outlook.com (2603:10b6:510:206::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 03:11:52 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::46) by CH2PR20CA0018.outlook.office365.com
 (2603:10b6:610:58::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 03:11:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 03:11:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 21:11:42 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 21:11:24 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Feb 2025 21:11:20 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, "Leo
 Li" <sunpeng.li@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Tom
 Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem
 Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Wayne
 Lin <Wayne.Lin@amd.com>, Martin Leung <martin.leung@amd.com>, "Taimur Hassan"
 <Syed.Hassan@amd.com>
Subject: [PATCH 08/12] drm/amd/display: Add DCN36 DMCUB
Date: Wed, 5 Feb 2025 11:08:53 +0800
Message-ID: <20250205030857.2608094-9-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250205030857.2608094-1-Wayne.Lin@amd.com>
References: <20250205030857.2608094-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|PH7PR12MB7211:EE_
X-MS-Office365-Filtering-Correlation-Id: 98a86b29-e18e-4fa6-beb4-08dd4592d6a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/LvzDXuvQcht0ElQFCxXn78hwSiOKkagSLcjo2zsgV8Y/CPPKgkUmO1NJHO2?=
 =?us-ascii?Q?oCUyrj9mEfMTjK7XZO5tQqcNkX8o6arECphasP0xGHKqDvaN2WnHMCio5rZi?=
 =?us-ascii?Q?YQa3Lw4CHJ+16XyudL54e3HN2zKlYbqwrJ7nxDxCyILTV0SZTVTGvrwDMoKn?=
 =?us-ascii?Q?VMT747SP+eK4CXQaA3nuhmXsPhPHSzUUs6OS5ZFU8MBd/685srOkmfc2fcRu?=
 =?us-ascii?Q?BvU7Pom96UyB8bTjSzXebCwt1udo2+36zF8A9BkF7SuAFn5Kupu+k2kPQAY4?=
 =?us-ascii?Q?YNJonJVT58uqCTqdfmq9zxVEW8MilEYcLQknvEPCWkmpqWQHYjMyPpZqICt1?=
 =?us-ascii?Q?SywFgOURxUVYAaKTBdLe3uAR0vRXQMcn4jb7leSetZM0ZBziQn1lfmgrecX4?=
 =?us-ascii?Q?GEYDwDV+Hfh4WOAjpH6Ffjah845FTmg+EBnwRq9sGwCkkVDMSkeJNAdX/YAx?=
 =?us-ascii?Q?QORRmMhts9fWb0KqpJ3qOlEJ8mJY/v8v+JqK2al82QdHvGEqArLQ+YHhjf03?=
 =?us-ascii?Q?0pvoCbG8pBcEPxk5x+esGVKZSd0OwAs4Tt+nLrJu9/g0JDM5AqhpBp3JanAv?=
 =?us-ascii?Q?+7aJ/qb9bXdjOfwwbisZoA4+2uVFX3TrZLWVRT9FC1L3/vzAzP7EYrrGpuxd?=
 =?us-ascii?Q?qQckWtXAX0Q22gm0RCKWS0+9r8xinc4ebXb/EEPPXCwmpDPDNxIlqkOM/xgu?=
 =?us-ascii?Q?t81wB34fN7VH8ZQS+KveKlvnqXFupQ7gxUVLFgaABwGR/GLqSLGZPZ7Oi59j?=
 =?us-ascii?Q?KMqZkDEyYGxQcDAo5EyNJOXgYCOXtWNSGzm8DLhfW0XkPM5sVoMekZ/tc27S?=
 =?us-ascii?Q?HfzsT1exHkBLukV7XuTJKtAaB2k7Lm5hcUYdpoMrTNeS2uiPZgavd3LxifN7?=
 =?us-ascii?Q?N05cKfQwYMZSNoAy0aE8GTiC7hjCVZG+Qle+qtkrTfvLqpsobRTOHsgiWIoa?=
 =?us-ascii?Q?r9CQ/h26WCFvFyiLdOlnPthTwp6OGGqkZk+KrGVOUfpMzIM235OlUw9FT46s?=
 =?us-ascii?Q?viTwPizfvl1Mcxgm7Q81jniQ3l0bCDYIGg5ln4mznKGJ74My6AR/TMhShJgT?=
 =?us-ascii?Q?/zRGONWIbnc1+WRslxCpVFRGbVg8Dqtrj+3b66UL8QlnrS+q/Dc9Yd8xVAC2?=
 =?us-ascii?Q?h/W02edAbHlDaPvyucBJZkK2ExHsJnQsEXNDgthv1KHSOVCjjxscMdKaz2Fh?=
 =?us-ascii?Q?mVMjw1G8G423ScfwN7zwSjExSPLm1K6KvBYkFSzLEy93LFAeY0WK2KQ6DDux?=
 =?us-ascii?Q?amBou2cLkuvh7i6uRN3/z4O86Bt/c5ffMM8rx3PKgmvBg8PvyCICyQdhY4LN?=
 =?us-ascii?Q?BK5MyxP+bkKpcxxunS43N2WIMdvzFDapttemBs4DW/J6jsynLpzyEfuCMoUD?=
 =?us-ascii?Q?0szGpfb55Vzq4JhL6ztRvnngxJiIdw5TDZsz9TI4/6jeFuTzUSZKthS6Ksyo?=
 =?us-ascii?Q?Za0586/5YQctBHLX98V5U4q9vavOTCWTW0nnpo6RSGfFG78PHxpzuqfbnlWw?=
 =?us-ascii?Q?QiaOlcObuMhhajo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 03:11:52.3941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a86b29-e18e-4fa6-beb4-08dd4592d6a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7211
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

DMCU-B (Display Micro-Controller Unit B) is a display microcontroller
used for shared display functionality with BIOS and for advanced
power saving display features.

Add case to support DCN3.6 as well.

V2: adjust copyright license text

Acked-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/Makefile |  1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn36.c | 34 +++++++++++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn36.h | 13 +++++++
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  4 +++
 4 files changed, 52 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn36.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn36.h

diff --git a/drivers/gpu/drm/amd/display/dmub/src/Makefile b/drivers/gpu/drm/amd/display/dmub/src/Makefile
index a00b9e992292..468b768c11ae 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/Makefile
+++ b/drivers/gpu/drm/amd/display/dmub/src/Makefile
@@ -26,6 +26,7 @@ DMUB += dmub_dcn31.o dmub_dcn314.o dmub_dcn315.o dmub_dcn316.o
 DMUB += dmub_dcn32.o
 DMUB += dmub_dcn35.o
 DMUB += dmub_dcn351.o
+DMUB += dmub_dcn36.o
 DMUB += dmub_dcn401.o
 
 AMD_DAL_DMUB = $(addprefix $(AMDDALPATH)/dmub/src/,$(DMUB))
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn36.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn36.c
new file mode 100644
index 000000000000..b1ce09d48920
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn36.c
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright 2025 Advanced Micro Devices, Inc. */
+
+#include "../dmub_srv.h"
+#include "dmub_reg.h"
+#include "dmub_dcn36.h"
+
+#include "dcn/dcn_3_6_0_offset.h"
+#include "dcn/dcn_3_6_0_sh_mask.h"
+
+#define BASE_INNER(seg) ctx->dcn_reg_offsets[seg]
+#define CTX dmub
+#define REGS dmub->regs_dcn35
+#define REG_OFFSET_EXP(reg_name) BASE(reg##reg_name##_BASE_IDX) + reg##reg_name
+
+void dmub_srv_dcn36_regs_init(struct dmub_srv *dmub, struct dc_context *ctx)
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
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn36.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn36.h
new file mode 100644
index 000000000000..57850550f682
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn36.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright 2025 Advanced Micro Devices, Inc. */
+
+#ifndef _DMUB_DCN36_H_
+#define _DMUB_DCN36_H_
+
+#include "dmub_dcn35.h"
+
+struct dmub_srv;
+
+void dmub_srv_dcn36_regs_init(struct dmub_srv *dmub, struct dc_context *ctx);
+
+#endif /* _DMUB_DCN36_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 15ea216e903d..6133d25da301 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -38,6 +38,7 @@
 #include "dmub_dcn32.h"
 #include "dmub_dcn35.h"
 #include "dmub_dcn351.h"
+#include "dmub_dcn36.h"
 #include "dmub_dcn401.h"
 #include "os_types.h"
 /*
@@ -314,6 +315,7 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 
 	case DMUB_ASIC_DCN35:
 	case DMUB_ASIC_DCN351:
+	case DMUB_ASIC_DCN36:
 			dmub->regs_dcn35 = &dmub_srv_dcn35_regs;
 			funcs->configure_dmub_in_system_memory = dmub_dcn35_configure_dmub_in_system_memory;
 			funcs->send_inbox0_cmd = dmub_dcn35_send_inbox0_cmd;
@@ -352,6 +354,8 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 			funcs->init_reg_offsets = dmub_srv_dcn35_regs_init;
 			if (asic == DMUB_ASIC_DCN351)
                                 funcs->init_reg_offsets = dmub_srv_dcn351_regs_init;
+			if (asic == DMUB_ASIC_DCN36)
+				funcs->init_reg_offsets = dmub_srv_dcn36_regs_init;
 
 			funcs->is_hw_powered_up = dmub_dcn35_is_hw_powered_up;
 			funcs->should_detect = dmub_dcn35_should_detect;
-- 
2.37.3

