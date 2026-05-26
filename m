Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C659ACD5BB4
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:20:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DF5C10E50F;
	Tue, 26 May 2026 07:20:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sv+ZC5su";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010062.outbound.protection.outlook.com
 [40.93.198.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD32110E50F
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:20:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbER6c08omyqxPzjUU/y6+Ga7NHCqKgvoCul7QelWpZ2L5VjfvIifTLrHVEbSiT3/Jp0rYzkMYbwk/vUoxeT9Bif1nsKmjgYjFZA+hwOTwTukrw3I5pv9M32ihp3PPOzg3mMcHAiElr5ufU4NidMi6CIsS+XgmpOpROI7LFskCdE3T5T6LeNDVOcGgp2QJEolKfNz9bQZNPC32Xwyms4Apupu4lTxpqmYEDofQq4c7m4XiufuJ3KsrT/UWKzNJXB0bBkfOBp9s+crg+lap8EpfYg2oERoG1mgkpOyprVLTsfDk3sADSbtqxdc8ZcjlFfJW9h9GDlGyhDvI10mrkZ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NXB2BsRCkOhUnePAANXXowV/b0XfaE4H4AAIpeUsrk=;
 b=EmSu/w2QQLnOsxiNhS+8b8Uy7KeOpDkStuoyTSzXtrtMXok8jDsAHx3br+uwHifGTcL6K5XDJCgJmzk8rkA+FDnQGDlex5PZJ5tqjb63C0CLKkEjJ31+5LNAjqVlWL4448J0Vp+AbO6C6ab/yOF99Fb8hBai+57aaOgAwPXwGDC4t4prNNsirQbJBfZzoAse74MxoOagODI0GoEr5ckn+BrMhsuc50BfJoI5uC8JXLLUAVpHsPYCrB3/SKzpCY2IgTaWk7rHXlojNtXG9oKcEyEoigTOTaJc1N46POpacyb/9O2VQl4RAjU6LoB7Dc7gq0cp9iVMJD0ytgqmTrywuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NXB2BsRCkOhUnePAANXXowV/b0XfaE4H4AAIpeUsrk=;
 b=Sv+ZC5suP/CdEUF9C2X9X30nnPE0siBL7R2Qz84YsoAa3tAOpln7WntlPiwQjzbJMBGjWZDwTuRAfp60zCKM1wBsfdHhz0TLQjf6vBEnmwWRUdYS9fLkpnh0Nl/yjsxg00uL55WQioVeek67uuQ/hy2zWvAPIzAiJWXFejqklIA=
Received: from BN9PR03CA0297.namprd03.prod.outlook.com (2603:10b6:408:f5::32)
 by DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 07:20:29 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::1b) by BN9PR03CA0297.outlook.office365.com
 (2603:10b6:408:f5::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Tue, 26
 May 2026 07:20:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:20:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:20:21 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:20:20 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:20:07 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Matthew Stewart <Matthew.Stewart2@amd.com>, "Matthew
 Stewart" <matthew.stewart2@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 37/41] drm/amd/display: Add DCN42B DMUB support
Date: Tue, 26 May 2026 15:02:00 +0800
Message-ID: <20260526071413.2181251-38-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c1d3a46-aaf1-4667-91b5-08debaf74361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9HiWQKR89i7x0FeMuKJuNMJ4g7vBqobhg6zaqM8r50iTuPTWNJ597P5ABTs1upCz74oYa+vhYJ2NBY3SW9u6lNmZT9uvkvE5g+0ogYjTDxPh2VmKWtUIeX1iCLRyYkCSutXhY0vdHLQn+8wdZC6b1VWQ8TjoUPgxbjhDARZd7QbGocYyzi/hwOiPt639Ueg12Kk1jE8B+G821tpwGmpoJENAU0jvGfp4DpM4MoGWycHIOMZXXs8ZiVfnEK92BHmuPac9ja1wShf3/L3hBfOvNSfMa/LxaodoJYYui9RUBfz+DYItyoVbg/RURgtnom1vtDa0kJcKMsx7ndrMwOxNX/QaO0XQezTlh+wmE1Y9wZ9EBjv5+4eFl+dZl88lKu/TwYQ5qbnB6cwadyMkPjzzElZ/9C4O3vwu+a/JbSAOf1+qfLlI4iW5EsbumFYk7EJclCoU005e5fdK2fXTQ93GC1V2reUBhHU5bafbS67mL9M+TnTd8jn1DodeAfbqASy5FyaoQElMUoyZyaSnwufJsLzhwhFqyOYniatgyiZiVwQHmlF4aR44NzJ1hxU01M8yAgds8uLamOKMm91vIx34WZoDmdkrjs9ZkRGX/C94qHk79nfXQG2u5k0baak97ULVk8G4R/UXPy8d1m74+d7o96VKKUSL0mJegU/SdvTBgNzeKGzFrVMoOi/p+jPdgfVm643KKC+q/y0ZTDngxzCKNANo+pKfUKiv0OAinMshhrs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(11063799006)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xgdvMvD1crhoQl8t+AQ0R59dHjZ4XrdBzGxWE5u5UCudfiQ4lcU69haurPGB64Ym8NwbZmC50/lvOEUZOemU8MRbqpRZXD0Ry/cSVyKZiHW2qKz4q8H2j6c6S6hbUgOa41tjtTv0uOq2rKp8mybqDU72PbatKHKZOGNVm11UZecMOBzyao4pPLUFDGjiJDCIwLoEBnlrlncYaS1xcUxx/trwOBLnpkjstRymMy2xI5fCY8HBJW86IJcIqPCTwci0Y0Io2Zj4ompfU5rxippe57AaEoA7LkjCgEY7LWgn6NjYNchxp/LNQwIYwnf1vJ2SeruJcq/ZobiGT9cBWCeKxM9dHIK7P2Maar25aX2yqo1ItxZ5Kle1PTGJDLAXV5+ivOLpzMpkeDch0mCirdYq9MVtJhANf+y8eCUcSkJaUQR6sLwvlxhZqfq0Uua0Rw1Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:20:28.2933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1d3a46-aaf1-4667-91b5-08debaf74361
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909
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

[Why & How]
Add DMUB support for DCN42B

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  1 +
 drivers/gpu/drm/amd/display/dmub/src/Makefile |  1 +
 .../drm/amd/display/dmub/src/dmub_dcn42b.c    | 34 +++++++++++++++++++
 .../drm/amd/display/dmub/src/dmub_dcn42b.h    | 13 +++++++
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  4 +++
 5 files changed, 53 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42b.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42b.h

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index c18ff8f00bb8..f4d05dcfef29 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -121,6 +121,7 @@ enum dmub_asic {
 	DMUB_ASIC_DCN36,
 	DMUB_ASIC_DCN401,
 	DMUB_ASIC_DCN42,
+	DMUB_ASIC_DCN42B,
 	DMUB_ASIC_MAX,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/Makefile b/drivers/gpu/drm/amd/display/dmub/src/Makefile
index ac7b17d8fb0f..b6f7477ada22 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/Makefile
+++ b/drivers/gpu/drm/amd/display/dmub/src/Makefile
@@ -29,6 +29,7 @@ DMUB += dmub_dcn351.o
 DMUB += dmub_dcn36.o
 DMUB += dmub_dcn401.o
 DMUB += dmub_dcn42.o
+DMUB += dmub_dcn42b.o
 
 AMD_DAL_DMUB = $(addprefix $(AMDDALPATH)/dmub/src/,$(DMUB))
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42b.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42b.c
new file mode 100644
index 000000000000..97eb022b837b
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42b.c
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright 2026 Advanced Micro Devices, Inc. */
+
+#include "../dmub_srv.h"
+#include "dmub_reg.h"
+#include "dmub_dcn42b.h"
+
+#include "dcn/dcn_4_2_1_offset.h"
+#include "dcn/dcn_4_2_1_sh_mask.h"
+
+#define BASE_INNER(seg) ctx->dcn_reg_offsets[seg]
+#define CTX dmub
+#define REGS dmub->regs_dcn42
+#define REG_OFFSET_EXP(reg_name) BASE(reg##reg_name##_BASE_IDX) + reg##reg_name
+
+void dmub_srv_dcn42b_regs_init(struct dmub_srv *dmub, struct dc_context *ctx)
+{
+	struct dmub_srv_dcn42_regs *regs = dmub->regs_dcn42;
+#define REG_STRUCT regs
+
+#define DMUB_SR(reg) REG_STRUCT->offset.reg = REG_OFFSET_EXP(reg);
+	DMUB_DCN42_REGS()
+	DMCUB_INTERNAL_REGS()
+#undef DMUB_SR
+
+#define DMUB_SF(reg, field) REG_STRUCT->mask.reg##__##field = FD_MASK(reg, field);
+	DMUB_DCN42_FIELDS()
+#undef DMUB_SF
+
+#define DMUB_SF(reg, field) REG_STRUCT->shift.reg##__##field = FD_SHIFT(reg, field);
+	DMUB_DCN42_FIELDS()
+#undef DMUB_SF
+#undef REG_STRUCT
+}
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42b.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42b.h
new file mode 100644
index 000000000000..cc89f177bf09
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42b.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright 2026 Advanced Micro Devices, Inc. */
+
+#ifndef _DMUB_DCN42B_H_
+#define _DMUB_DCN42B_H_
+
+#include "dmub_dcn42.h"
+
+struct dmub_srv;
+
+void dmub_srv_dcn42b_regs_init(struct dmub_srv *dmub, struct dc_context *ctx);
+
+#endif /* _DMUB_DCN42B_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 10d23f5f5d94..7463d2ae5055 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -41,6 +41,7 @@
 #include "dmub_dcn36.h"
 #include "dmub_dcn401.h"
 #include "dmub_dcn42.h"
+#include "dmub_dcn42b.h"
 #include "os_types.h"
 /*
  * Note: the DMUB service is standalone. No additional headers should be
@@ -413,6 +414,7 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 			funcs->should_detect = dmub_dcn35_should_detect;
 			break;
 	case DMUB_ASIC_DCN42:
+	case DMUB_ASIC_DCN42B:
 			dmub->regs_dcn42 = &dmub_srv_dcn42_regs;
 			funcs->configure_dmub_in_system_memory = dmub_dcn42_configure_dmub_in_system_memory;
 			funcs->send_inbox0_cmd = dmub_dcn42_send_inbox0_cmd;
@@ -466,6 +468,8 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 			funcs->enable_reg_inbox0_rsp_int = dmub_dcn42_enable_reg_inbox0_rsp_int;
 			funcs->enable_reg_outbox0_rdy_int = dmub_dcn42_enable_reg_outbox0_rdy_int;
 			funcs->init_reg_offsets = dmub_srv_dcn42_regs_init;
+			if (asic == DMUB_ASIC_DCN42B)
+				funcs->init_reg_offsets = dmub_srv_dcn42b_regs_init;
 
 			funcs->is_hw_powered_up = dmub_dcn42_is_hw_powered_up;
 			funcs->should_detect = dmub_dcn42_should_detect;
-- 
2.43.0

