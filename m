Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492E1E9E31B
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Feb 2026 01:10:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBB5610E6A6;
	Thu, 12 Feb 2026 01:10:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F49GpyWd";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012059.outbound.protection.outlook.com [52.101.43.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38BE710E6A6
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Feb 2026 01:10:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGzyOJmwhzV2nnK8ol0FAb+JRqunuEXs3TuIV7pWs5cyjQPEejWGzNtik/J6WSXm/XzxWlp3ze9/Bj8xsstjKjv0nJoVjEe11zK2AvqL5L0VOCOJ4lYlXY4Gazt2VZH38uR6gp9ffGB9Mg8t4B9MTCtku/ZaVIR1dhcKISdpG+Hq8aD91V22ovnI0dcwfBpedz88LD1VFt0a5uBm1yVW3TxxBU0Iqtl9G6RRVPUIYdjOEckQiBRUwbNUvG4+Jksb/c+3gESFvX0ANo3A00zbtmMyCIh/B14eD4wAVHYhbrRQN/1/vAgtUyhv/TcxCGaGyWz4Qk0RAAeJcLJsB+nsWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORRlsGAIz7IhvqluMux1XQOOnhWaBX7UCZ4oLDH2Ngc=;
 b=GmGhhHpmhbeRNCyY/gVkJrmLdEqFP3ZuErJe3rNmsdRgaG6073S/BGhKLofhH2fzP4LECF36nXNA7XUimm8xPwVTnTa1kmOe3bk8/nEGIJkfmdYFg+oMpn57p0iycToGP66R05Alij42vacbJBPw/Qt8EXgu183XyzA+KbjrJbmi1753Xc94cSgSioMieHyjLpJ1T4/55j9N7nBZbal3vfohwhI7mmGQGbJXX8Cre7DMwl7vYQPn94jeBBResxfKf5QTS7vpGRCvzZGQ2qdJo0KA8R6J8SQhJQIFUh8bis4Xu988AOpJqLRdk+JrT+VSoJkIvTfhCLS/f65yM9a2mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORRlsGAIz7IhvqluMux1XQOOnhWaBX7UCZ4oLDH2Ngc=;
 b=F49GpyWdMS6jwGc6bIAmHbHDkjskGuMUDMZ/yykILKgF9+dvphRVe2Dxf4qr+QsvXIkJ3Z2xfRF+CkTEWLGkZlgdO7KNPTwnr4ivMFbYEdRGcWXL4m+qbyyufm+cUDGPZycSw5wXa3P4WNFJdFTwiwVcTGcmtEs+00AL14Gpw8U=
Received: from DM5PR07CA0087.namprd07.prod.outlook.com (2603:10b6:4:ae::16) by
 SJ2PR12MB9209.namprd12.prod.outlook.com (2603:10b6:a03:558::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 01:10:02 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:4:ae:cafe::5a) by DM5PR07CA0087.outlook.office365.com
 (2603:10b6:4:ae::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Thu,
 12 Feb 2026 01:10:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Thu, 12 Feb 2026 01:10:00 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Feb
 2026 19:10:00 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 11 Feb 2026 19:10:00 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>, Roman Li
 <Roman.Li@amd.com>
Subject: [PATCH 4/7] drm/amd/display: Add DMUB support for dcn42
Date: Wed, 11 Feb 2026 20:09:46 -0500
Message-ID: <20260212010949.654686-5-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260212010949.654686-1-Roman.Li@amd.com>
References: <20260212010949.654686-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|SJ2PR12MB9209:EE_
X-MS-Office365-Filtering-Correlation-Id: 978f01ca-2f8e-482d-7652-08de69d37248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0sDcFeSsVn48aCiCkH7Ek6pNYRdj8pYf4HeFzsZ/+tUVkgURs2lD0zymji+F?=
 =?us-ascii?Q?b5zsx/AFZpD+5MbdR2GOf0cuJGz1lpmPBGjnIitF6SJfBtObMtyIQGavRxsD?=
 =?us-ascii?Q?S1hkT9Mys2jY/JwFHDvkQLnmHBJaDaT2k+UGxi+pdtDYRxy1l8uhd/nhhYW1?=
 =?us-ascii?Q?hVklRtnMZ6ipt85Bj7AN9h5sypNMIPiGkWx/zyjZGNiMgA7m7rSsx7McqTRk?=
 =?us-ascii?Q?Nlpt6ynMYpjip4c7avCoqo+lWzdYn9NvaK67PK0QdGS+mMB953Vmh+dZ9FHc?=
 =?us-ascii?Q?ipPpMRXZpXvT1pgAfNptyDWWOIt+RjKgOwPGxRszSh5pjnHNKm3u0Xaz+yea?=
 =?us-ascii?Q?pBkujDpecGMquKWzR2gRth3B2kcUG3XJaHlD+XNG4ya1ZnsYz4H9t0Bg0klE?=
 =?us-ascii?Q?iLpLpa/VNcS0mshnB2ApRNubKsRbEViUEf+4ahFYS4OrvASZ/o0BTk8HogVs?=
 =?us-ascii?Q?1T3bUFF2XCGanUDD16hkS9pUqE2UGjWUwmQcIrVGjg2J3+cdJkodjsqr6cv2?=
 =?us-ascii?Q?ezP1FooujEY3yUP/2OOYSdlUpHZFnehVZyXbuPkglZtLyZJ+NijMYLyCc3z+?=
 =?us-ascii?Q?+kUQufNCDHKJ+Ryz7JqFp3cM+I3xFDTD1u4C7xYcdKVw9L9BVoTXy8FJTaLS?=
 =?us-ascii?Q?eyh0Issms37BIN4Dn9CLmB9ftKRwh6BMLEtn+ZmIDS7i5zWmxH8b6q0Q0Afr?=
 =?us-ascii?Q?CeWButI2/EwR5BLReblmjqhYAoM+43wpY87iIsukjL98qhj/vbsZjcoTk5Bq?=
 =?us-ascii?Q?snefQd8gKwq+OvMnxz+qJ5xSkP0iLW+IVXPWCQMil1qNYyMaYR+pgIpgz4IB?=
 =?us-ascii?Q?NuLjdT3Otwig3xHrxpCTt/aWMfKE5ZbTVNbvp4iIHEUY4NW6RW1y7IfgOCzT?=
 =?us-ascii?Q?hH5EK6oNSv/Y9j4sKv0M5v3niOI5T32dxYu3jez5iWGSfxtUBH2zQ08d6b5a?=
 =?us-ascii?Q?SbN4zilvV8Gv58ZcKcDYUPvd8HnhfliaMskwPQdqWQE+DAAB3aRYmXFP29k+?=
 =?us-ascii?Q?G0fHHgwQkLMAUvCYlWNgrgNTVzoTFQYlsaPSmjMB+TGREmTHttL1HlaVCeBf?=
 =?us-ascii?Q?GFbny1WE9uiT4GTlE/aQhrz/YFL2kypFROCf9hlFwKNcqsaxzJzq33/S7Ayl?=
 =?us-ascii?Q?+/hKRsStBtC0v6ZlaW1x2oDZ4THS34nzYnZgjIwjcAWrXMRlnExPgpqeJDEd?=
 =?us-ascii?Q?6WDC2B7iz8XKYqNwTSziXE1H18Hh/VvDYYJOMbKdb9XUL95VcBih/GVpti9q?=
 =?us-ascii?Q?V0lYNnmxTuHPjPWiutBYM4RIhQRWoJB8QD6UsjVjBKO3MrR8NeCS7Co9+A0u?=
 =?us-ascii?Q?Ztz9a8dHLwL/tytJlVrlah7HMrhUEOglEWGDANXXFwLT2adE360SQMCaTZy0?=
 =?us-ascii?Q?joiAwa3bFVYKnJnmlZH/CzhARgoa3RvlMGiBVOWXmRANFvPMT0JVoUOjC2f2?=
 =?us-ascii?Q?VY1YgR6TibaJEmZm1TwOOW1hKyh0H9MAzkGPwfdIDbB1gdo915ttLRyFOelC?=
 =?us-ascii?Q?zC/nJcKyf9AwrM9Yz3cRbC+dB1CpSU1AqG4248xExidpCFnIkVBLpWNUwtul?=
 =?us-ascii?Q?0r+gj82xxU+75uFI1x0xnK5e7L6JjDi4gk4/JZoKnsTZ0PhDkUrA5/UHeQub?=
 =?us-ascii?Q?6xg6h036KDq0YVtwbA3kRqfTg2FOiGUA8MifF8a9JoOKYtvp6TJYoMgJ2GcW?=
 =?us-ascii?Q?7861Gg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RCX4WCUYop6rDBncBGrzB77c//9PXN2fzv5uQGx8cLAyiYDcCGf/lktq1UiN2jjUG/wsYxqJ91bdJFd+l78OQRqcZUypxKsWID9CiD0BcPQm/N6QKqaBsxO6F5ABqWjbIJXQvn4yRteJiFBU0wSwmfwtP6g9fqsIyOrPCVKc7TPJDEpceos5wr8GXEy62aP+s/B4SWuMQS/auMytElh/3zQmsBKb9DhFS1CGPNyRvtTKT2Q5ikrbQTzWCZDV6PbH8e3OBWJYUYFFIoiJoXqhIa7g4RyrVmkmnPmDPvWnJLkN4tCGyv1qfs5ZL6C/++XSGVmAy9342v6Bw6SkYYl7+gnsVrL9FETgpngnuUuaEwxVp5efLmTkv8/8PFAv3IP0ujOr3VLv/2hB4cf0xiAZhehBk8xSI/MfGX69OmchkRcc8nMUmM14rFbIvRUQIJFm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 01:10:00.9288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 978f01ca-2f8e-482d-7652-08de69d37248
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9209
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

From: Roman Li <Roman.Li@amd.com>

DMUB support for DCN 4.2

Signed-off-by: Roman Li <Roman.Li@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 .../gpu/drm/amd/display/dmub/src/dmub_dcn42.c | 752 ++++++++++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn42.h | 171 ++++
 2 files changed, 923 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.h

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
new file mode 100644
index 000000000000..4d274b7034e8
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
@@ -0,0 +1,752 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2026 Advanced Micro Devices, Inc.
+
+#include "../dmub_srv.h"
+#include "dmub_reg.h"
+#include "dmub_dcn35.h"
+#include "dmub_dcn401.h"
+#include "dmub_dcn42.h"
+
+#include "dcn/dcn_4_2_0_offset.h"
+#include "dcn/dcn_4_2_0_sh_mask.h"
+
+#define BASE_INNER(seg) ctx->dcn_reg_offsets[seg]
+#define CTX dmub
+#define REGS dmub->regs_dcn42
+#define REG_OFFSET_EXP(reg_name) (BASE(reg##reg_name##_BASE_IDX) + reg##reg_name)
+
+void dmub_srv_dcn42_regs_init(struct dmub_srv *dmub, struct dc_context *ctx)
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
+
+void dmub_dcn42_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmub_srv_hw_params *params)
+{
+	union dmub_fw_boot_options boot_options = {0};
+	union dmub_fw_boot_options cur_boot_options = {0};
+
+	cur_boot_options = dmub_dcn42_get_fw_boot_option(dmub);
+
+	boot_options.bits.z10_disable = params->disable_z10;
+	boot_options.bits.dpia_supported = params->dpia_supported;
+	boot_options.bits.enable_dpia = cur_boot_options.bits.enable_dpia && !params->disable_dpia;
+	boot_options.bits.usb4_cm_version = params->usb4_cm_version;
+	boot_options.bits.dpia_hpd_int_enable_supported = params->dpia_hpd_int_enable_supported;
+	boot_options.bits.power_optimization = params->power_optimization;
+	boot_options.bits.disable_clk_ds = params->disallow_dispclk_dppclk_ds;
+	boot_options.bits.disable_clk_gate = params->disable_clock_gate;
+	boot_options.bits.ips_disable = params->disable_ips;
+	boot_options.bits.ips_sequential_ono = params->ips_sequential_ono;
+	boot_options.bits.disable_sldo_opt = params->disable_sldo_opt;
+	boot_options.bits.enable_non_transparent_setconfig = params->enable_non_transparent_setconfig;
+	boot_options.bits.lower_hbr3_phy_ssc = params->lower_hbr3_phy_ssc;
+	boot_options.bits.skip_phy_access = params->disallow_phy_access;
+	boot_options.bits.disable_dpia_bw_allocation = params->disable_dpia_bw_allocation;
+
+	REG_WRITE(DMCUB_SCRATCH14, boot_options.all);
+}
+
+static void dmub_dcn42_get_fb_base_offset(struct dmub_srv *dmub,
+					  uint64_t *fb_base,
+					  uint64_t *fb_offset)
+{
+	uint32_t tmp;
+
+	/*
+	if (dmub->soc_fb_info.fb_base || dmub->soc_fb_info.fb_offset) {
+		*fb_base = dmub->soc_fb_info.fb_base;
+		*fb_offset = dmub->soc_fb_info.fb_offset;
+		return;
+	}
+	*/
+
+	REG_GET(DCN_VM_FB_LOCATION_BASE, FB_BASE, &tmp);
+	*fb_base = (uint64_t)tmp << 24;
+
+	REG_GET(DCN_VM_FB_OFFSET, FB_OFFSET, &tmp);
+	*fb_offset = (uint64_t)tmp << 24;
+}
+
+static inline void dmub_dcn42_translate_addr(const union dmub_addr *addr_in,
+					     uint64_t fb_base,
+					     uint64_t fb_offset,
+					     union dmub_addr *addr_out)
+{
+	addr_out->quad_part = addr_in->quad_part - fb_base + fb_offset;
+}
+
+void dmub_dcn42_reset(struct dmub_srv *dmub)
+{
+	union dmub_gpint_data_register cmd;
+	const uint32_t timeout = 100000;
+	uint32_t in_reset, is_enabled, scratch, i, pwait_mode;
+
+	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &in_reset);
+	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_enabled);
+
+	if (in_reset == 0 && is_enabled != 0) {
+		cmd.bits.status = 1;
+		cmd.bits.command_code = DMUB_GPINT__STOP_FW;
+		cmd.bits.param = 0;
+
+		dmub->hw_funcs.set_gpint(dmub, cmd);
+
+		for (i = 0; i < timeout; ++i) {
+			if (dmub->hw_funcs.is_gpint_acked(dmub, cmd))
+				break;
+
+			udelay(1);
+		}
+
+		for (i = 0; i < timeout; ++i) {
+			scratch = REG_READ(DMCUB_SCRATCH7);
+			if (scratch == DMUB_GPINT__STOP_FW_RESPONSE)
+				break;
+
+			udelay(1);
+		}
+
+		for (i = 0; i < timeout; ++i) {
+			REG_GET(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS, &pwait_mode);
+			if (pwait_mode & (1 << 0))
+				break;
+
+			udelay(1);
+		}
+		/* Force reset in case we timed out, DMCUB is likely hung. */
+	}
+
+	if (is_enabled) {
+		REG_UPDATE(DMCUB_CNTL2, DMCUB_SOFT_RESET, 1);
+		udelay(1);
+		REG_UPDATE(DMCUB_CNTL, DMCUB_ENABLE, 0);
+	}
+
+	REG_WRITE(DMCUB_INBOX1_RPTR, 0);
+	REG_WRITE(DMCUB_INBOX1_WPTR, 0);
+	REG_WRITE(DMCUB_OUTBOX1_RPTR, 0);
+	REG_WRITE(DMCUB_OUTBOX1_WPTR, 0);
+	REG_WRITE(DMCUB_OUTBOX0_RPTR, 0);
+	REG_WRITE(DMCUB_OUTBOX0_WPTR, 0);
+	REG_WRITE(DMCUB_SCRATCH0, 0);
+
+	/* Clear the GPINT command manually so we don't send anything during boot. */
+	cmd.all = 0;
+	dmub->hw_funcs.set_gpint(dmub, cmd);
+}
+
+void dmub_dcn42_reset_release(struct dmub_srv *dmub)
+{
+	REG_WRITE(DMCUB_SCRATCH15, dmub->psp_version & 0x001100FF);
+
+	REG_UPDATE_3(DMU_CLK_CNTL,
+		     LONO_DISPCLK_GATE_DISABLE, 1,
+		     LONO_SOCCLK_GATE_DISABLE, 1,
+		     LONO_DMCUBCLK_GATE_DISABLE, 1);
+
+	REG_UPDATE_2(DMCUB_CNTL, DMCUB_ENABLE, 1, DMCUB_TRACEPORT_EN, 1);
+	REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 0);
+	REG_UPDATE(DMCUB_CNTL2, DMCUB_SOFT_RESET, 0);
+}
+
+void dmub_dcn42_backdoor_load(struct dmub_srv *dmub,
+			      const struct dmub_window *cw0,
+			      const struct dmub_window *cw1)
+{
+	union dmub_addr offset;
+	uint64_t fb_base, fb_offset;
+
+	dmub_dcn42_get_fb_base_offset(dmub, &fb_base, &fb_offset);
+
+	dmub_dcn42_translate_addr(&cw0->offset, fb_base, fb_offset, &offset);
+
+	REG_WRITE(DMCUB_REGION3_CW0_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW0_OFFSET_HIGH, offset.u.high_part);
+	REG_WRITE(DMCUB_REGION3_CW0_BASE_ADDRESS, cw0->region.base);
+	REG_SET_2(DMCUB_REGION3_CW0_TOP_ADDRESS, 0,
+		  DMCUB_REGION3_CW0_TOP_ADDRESS, cw0->region.top,
+		  DMCUB_REGION3_CW0_ENABLE, 1);
+
+	dmub_dcn42_translate_addr(&cw1->offset, fb_base, fb_offset, &offset);
+
+	REG_WRITE(DMCUB_REGION3_CW1_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW1_OFFSET_HIGH, offset.u.high_part);
+	REG_WRITE(DMCUB_REGION3_CW1_BASE_ADDRESS, cw1->region.base);
+	REG_SET_2(DMCUB_REGION3_CW1_TOP_ADDRESS, 0,
+		  DMCUB_REGION3_CW1_TOP_ADDRESS, cw1->region.top,
+		  DMCUB_REGION3_CW1_ENABLE, 1);
+
+	/* TODO: Do we need to set DMCUB_MEM_UNIT_ID? */
+	REG_UPDATE(DMCUB_SEC_CNTL, DMCUB_SEC_RESET, 0);
+}
+
+void dmub_dcn42_backdoor_load_zfb_mode(struct dmub_srv *dmub,
+		      const struct dmub_window *cw0,
+		      const struct dmub_window *cw1)
+{
+	union dmub_addr offset;
+
+	REG_UPDATE(DMCUB_SEC_CNTL, DMCUB_SEC_RESET, 1);
+	offset = cw0->offset;
+	REG_WRITE(DMCUB_REGION3_CW0_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW0_OFFSET_HIGH, offset.u.high_part);
+	REG_WRITE(DMCUB_REGION3_CW0_BASE_ADDRESS, cw0->region.base);
+	REG_SET_2(DMCUB_REGION3_CW0_TOP_ADDRESS, 0,
+			DMCUB_REGION3_CW0_TOP_ADDRESS, cw0->region.top,
+			DMCUB_REGION3_CW0_ENABLE, 1);
+	offset = cw1->offset;
+	REG_WRITE(DMCUB_REGION3_CW1_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW1_OFFSET_HIGH, offset.u.high_part);
+	REG_WRITE(DMCUB_REGION3_CW1_BASE_ADDRESS, cw1->region.base);
+	REG_SET_2(DMCUB_REGION3_CW1_TOP_ADDRESS, 0,
+			DMCUB_REGION3_CW1_TOP_ADDRESS, cw1->region.top,
+			DMCUB_REGION3_CW1_ENABLE, 1);
+	REG_UPDATE_2(DMCUB_SEC_CNTL, DMCUB_SEC_RESET, 0, DMCUB_MEM_UNIT_ID,
+			0x20);
+}
+void dmub_dcn42_setup_windows(struct dmub_srv *dmub,
+			      const struct dmub_window *cw2,
+			      const struct dmub_window *cw3,
+			      const struct dmub_window *cw4,
+			      const struct dmub_window *cw5,
+			      const struct dmub_window *cw6,
+			      const struct dmub_window *region6)
+{
+	union dmub_addr offset;
+
+	offset = cw3->offset;
+
+	REG_WRITE(DMCUB_REGION3_CW3_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW3_OFFSET_HIGH, offset.u.high_part);
+	REG_WRITE(DMCUB_REGION3_CW3_BASE_ADDRESS, cw3->region.base);
+	REG_SET_2(DMCUB_REGION3_CW3_TOP_ADDRESS, 0,
+		  DMCUB_REGION3_CW3_TOP_ADDRESS, cw3->region.top,
+		  DMCUB_REGION3_CW3_ENABLE, 1);
+
+	offset = cw4->offset;
+
+	REG_WRITE(DMCUB_REGION3_CW4_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW4_OFFSET_HIGH, offset.u.high_part);
+	REG_WRITE(DMCUB_REGION3_CW4_BASE_ADDRESS, cw4->region.base);
+	REG_SET_2(DMCUB_REGION3_CW4_TOP_ADDRESS, 0,
+		  DMCUB_REGION3_CW4_TOP_ADDRESS, cw4->region.top,
+		  DMCUB_REGION3_CW4_ENABLE, 1);
+
+	offset = cw5->offset;
+
+	REG_WRITE(DMCUB_REGION3_CW5_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW5_OFFSET_HIGH, offset.u.high_part);
+	REG_WRITE(DMCUB_REGION3_CW5_BASE_ADDRESS, cw5->region.base);
+	REG_SET_2(DMCUB_REGION3_CW5_TOP_ADDRESS, 0,
+		  DMCUB_REGION3_CW5_TOP_ADDRESS, cw5->region.top,
+		  DMCUB_REGION3_CW5_ENABLE, 1);
+
+	REG_WRITE(DMCUB_REGION5_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION5_OFFSET_HIGH, offset.u.high_part);
+	REG_SET_2(DMCUB_REGION5_TOP_ADDRESS, 0,
+		  DMCUB_REGION5_TOP_ADDRESS,
+		  cw5->region.top - cw5->region.base - 1,
+		  DMCUB_REGION5_ENABLE, 1);
+
+	offset = cw6->offset;
+
+	REG_WRITE(DMCUB_REGION3_CW6_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW6_OFFSET_HIGH, offset.u.high_part);
+	REG_WRITE(DMCUB_REGION3_CW6_BASE_ADDRESS, cw6->region.base);
+	REG_SET_2(DMCUB_REGION3_CW6_TOP_ADDRESS, 0,
+		  DMCUB_REGION3_CW6_TOP_ADDRESS, cw6->region.top,
+		  DMCUB_REGION3_CW6_ENABLE, 1);
+
+	offset = region6->offset;
+
+	REG_WRITE(DMCUB_REGION6_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION6_OFFSET_HIGH, offset.u.high_part);
+	REG_SET_2(DMCUB_REGION6_TOP_ADDRESS, 0,
+		  DMCUB_REGION6_TOP_ADDRESS,
+		  region6->region.top - region6->region.base - 1,
+		  DMCUB_REGION6_ENABLE, 1);
+}
+
+uint32_t dmub_dcn42_get_inbox1_wptr(struct dmub_srv *dmub)
+{
+	return REG_READ(DMCUB_INBOX1_WPTR);
+}
+
+uint32_t dmub_dcn42_get_inbox1_rptr(struct dmub_srv *dmub)
+{
+	return REG_READ(DMCUB_INBOX1_RPTR);
+}
+
+void dmub_dcn42_setup_out_mailbox(struct dmub_srv *dmub,
+			      const struct dmub_region *outbox1)
+{
+	REG_WRITE(DMCUB_OUTBOX1_BASE_ADDRESS, outbox1->base);
+	REG_WRITE(DMCUB_OUTBOX1_SIZE, outbox1->top - outbox1->base);
+}
+
+uint32_t dmub_dcn42_get_outbox1_wptr(struct dmub_srv *dmub)
+{
+	/**
+	 * outbox1 wptr register is accessed without locks (dal & dc)
+	 * and to be called only by dmub_srv_stat_get_notification()
+	 */
+	return REG_READ(DMCUB_OUTBOX1_WPTR);
+}
+
+void dmub_dcn42_set_outbox1_rptr(struct dmub_srv *dmub, uint32_t rptr_offset)
+{
+	/**
+	 * outbox1 rptr register is accessed without locks (dal & dc)
+	 * and to be called only by dmub_srv_stat_get_notification()
+	 */
+	REG_WRITE(DMCUB_OUTBOX1_RPTR, rptr_offset);
+}
+
+bool dmub_dcn42_is_supported(struct dmub_srv *dmub)
+{
+	uint32_t supported = 0;
+
+	REG_GET(CC_DC_PIPE_DIS, DC_DMCUB_ENABLE, &supported);
+
+	return supported;
+}
+
+union dmub_fw_boot_options dmub_dcn42_get_fw_boot_option(struct dmub_srv *dmub)
+{
+	union dmub_fw_boot_options option;
+
+	option.all = REG_READ(DMCUB_SCRATCH14);
+	return option;
+}
+
+void dmub_dcn42_setup_outbox0(struct dmub_srv *dmub,
+			      const struct dmub_region *outbox0)
+{
+	REG_WRITE(DMCUB_OUTBOX0_BASE_ADDRESS, outbox0->base);
+
+	REG_WRITE(DMCUB_OUTBOX0_SIZE, outbox0->top - outbox0->base);
+}
+
+bool dmub_dcn42_should_detect(struct dmub_srv *dmub)
+{
+	uint32_t fw_boot_status = REG_READ(DMCUB_SCRATCH0);
+	bool should_detect = (fw_boot_status & DMUB_FW_BOOT_STATUS_BIT_DETECTION_REQUIRED) != 0;
+	return should_detect;
+}
+
+void dmub_dcn42_send_inbox0_cmd(struct dmub_srv *dmub, union dmub_inbox0_data_register data)
+{
+	REG_WRITE(DMCUB_INBOX0_WPTR, data.inbox0_cmd_common.all);
+}
+
+uint32_t dmub_dcn42_read_inbox0_ack_register(struct dmub_srv *dmub)
+{
+	return REG_READ(DMCUB_SCRATCH17);
+}
+
+bool dmub_dcn42_is_hw_powered_up(struct dmub_srv *dmub)
+{
+	union dmub_fw_boot_status status;
+	uint32_t is_enable;
+
+	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_enable);
+	if (is_enable == 0)
+		return false;
+
+	status.all = REG_READ(DMCUB_SCRATCH0);
+
+	return (status.bits.dal_fw && status.bits.hw_power_init_done && status.bits.mailbox_rdy) ||
+	       (!status.bits.dal_fw && status.bits.mailbox_rdy);
+}
+
+void dmub_dcn42_set_inbox1_wptr(struct dmub_srv *dmub, uint32_t wptr_offset)
+{
+	REG_WRITE(DMCUB_INBOX1_WPTR, wptr_offset);
+}
+
+bool dmub_dcn42_is_hw_init(struct dmub_srv *dmub)
+{
+	union dmub_fw_boot_status status;
+	uint32_t is_hw_init;
+
+	status.all = REG_READ(DMCUB_SCRATCH0);
+	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_hw_init);
+
+	return is_hw_init != 0 && status.bits.dal_fw;
+}
+
+union dmub_fw_boot_status dmub_dcn42_get_fw_boot_status(struct dmub_srv *dmub)
+{
+	union dmub_fw_boot_status status;
+
+	status.all = REG_READ(DMCUB_SCRATCH0);
+	return status;
+}
+
+void dmub_dcn42_skip_dmub_panel_power_sequence(struct dmub_srv *dmub, bool skip)
+{
+	union dmub_fw_boot_options boot_options;
+	boot_options.all = REG_READ(DMCUB_SCRATCH14);
+	boot_options.bits.skip_phy_init_panel_sequence = skip;
+	REG_WRITE(DMCUB_SCRATCH14, boot_options.all);
+}
+
+void dmub_dcn42_configure_dmub_in_system_memory(struct dmub_srv *dmub)
+{
+	/* DMCUB_REGION3_TMR_AXI_SPACE values:
+	 * 0b011 (0x3) - FB physical address
+	 * 0b100 (0x4) - GPU virtual address
+	 *
+	 * Default value is 0x3 (FB Physical address for TMR). When programming
+	 * DMUB to be in system memory, change to 0x4. The system memory allocated
+	 * is accessible by both GPU and CPU, so we use GPU virtual address.
+	 */
+	REG_WRITE(DMCUB_REGION3_TMR_AXI_SPACE, 0x4);
+}
+
+void dmub_dcn42_clear_inbox0_ack_register(struct dmub_srv *dmub)
+{
+	REG_WRITE(DMCUB_SCRATCH17, 0);
+}
+
+void dmub_dcn42_send_reg_inbox0_cmd_msg(struct dmub_srv *dmub,
+		union dmub_rb_cmd *cmd)
+{
+	uint32_t *dwords = (uint32_t *)cmd;
+	int32_t payload_size_bytes = cmd->cmd_common.header.payload_bytes;
+	uint32_t msg_index;
+	static_assert(sizeof(*cmd) == 64, "DMUB command size mismatch");
+
+	/* read remaining data based on payload size */
+	for (msg_index = 0; msg_index < 15; msg_index++) {
+		if (payload_size_bytes <= msg_index * 4) {
+			break;
+		}
+
+		switch (msg_index) {
+		case 0:
+			REG_WRITE(DMCUB_REG_INBOX0_MSG0, dwords[msg_index + 1]);
+			break;
+		case 1:
+			REG_WRITE(DMCUB_REG_INBOX0_MSG1, dwords[msg_index + 1]);
+			break;
+		case 2:
+			REG_WRITE(DMCUB_REG_INBOX0_MSG2, dwords[msg_index + 1]);
+			break;
+		case 3:
+			REG_WRITE(DMCUB_REG_INBOX0_MSG3, dwords[msg_index + 1]);
+			break;
+		case 4:
+			REG_WRITE(DMCUB_REG_INBOX0_MSG4, dwords[msg_index + 1]);
+			break;
+		case 5:
+			REG_WRITE(DMCUB_REG_INBOX0_MSG5, dwords[msg_index + 1]);
+			break;
+		case 6:
+			REG_WRITE(DMCUB_REG_INBOX0_MSG6, dwords[msg_index + 1]);
+			break;
+		case 7:
+			REG_WRITE(DMCUB_REG_INBOX0_MSG7, dwords[msg_index + 1]);
+			break;
+		case 8:
+			REG_WRITE(DMCUB_REG_INBOX0_MSG8, dwords[msg_index + 1]);
+			break;
+		case 9:
+			REG_WRITE(DMCUB_REG_INBOX0_MSG9, dwords[msg_index + 1]);
+			break;
+		case 10:
+			REG_WRITE(DMCUB_REG_INBOX0_MSG10, dwords[msg_index + 1]);
+			break;
+		case 11:
+			REG_WRITE(DMCUB_REG_INBOX0_MSG11, dwords[msg_index + 1]);
+			break;
+		case 12:
+			REG_WRITE(DMCUB_REG_INBOX0_MSG12, dwords[msg_index + 1]);
+			break;
+		case 13:
+			REG_WRITE(DMCUB_REG_INBOX0_MSG13, dwords[msg_index + 1]);
+			break;
+		case 14:
+			REG_WRITE(DMCUB_REG_INBOX0_MSG14, dwords[msg_index + 1]);
+			break;
+		}
+	}
+
+	/* writing to INBOX RDY register will trigger DMUB REG INBOX0 RDY
+	 * interrupt.
+	 */
+	REG_WRITE(DMCUB_REG_INBOX0_RDY, dwords[0]);
+}
+
+uint32_t dmub_dcn42_read_reg_inbox0_rsp_int_status(struct dmub_srv *dmub)
+{
+	uint32_t status;
+
+	REG_GET(HOST_INTERRUPT_CSR, HOST_REG_INBOX0_RSP_INT_STAT, &status);
+	return status;
+}
+
+void dmub_dcn42_read_reg_inbox0_cmd_rsp(struct dmub_srv *dmub,
+		union dmub_rb_cmd *cmd)
+{
+	uint32_t *dwords = (uint32_t *)cmd;
+
+	static_assert(sizeof(*cmd) == 64, "DMUB command size mismatch");
+
+	dwords[0] = REG_READ(DMCUB_REG_INBOX0_RSP);
+	dwords[1] = REG_READ(DMCUB_REG_INBOX0_MSG0);
+	dwords[2] = REG_READ(DMCUB_REG_INBOX0_MSG1);
+	dwords[3] = REG_READ(DMCUB_REG_INBOX0_MSG2);
+	dwords[4] = REG_READ(DMCUB_REG_INBOX0_MSG3);
+	dwords[5] = REG_READ(DMCUB_REG_INBOX0_MSG4);
+	dwords[6] = REG_READ(DMCUB_REG_INBOX0_MSG5);
+	dwords[7] = REG_READ(DMCUB_REG_INBOX0_MSG6);
+	dwords[8] = REG_READ(DMCUB_REG_INBOX0_MSG7);
+	dwords[9] = REG_READ(DMCUB_REG_INBOX0_MSG8);
+	dwords[10] = REG_READ(DMCUB_REG_INBOX0_MSG9);
+	dwords[11] = REG_READ(DMCUB_REG_INBOX0_MSG10);
+	dwords[12] = REG_READ(DMCUB_REG_INBOX0_MSG11);
+	dwords[13] = REG_READ(DMCUB_REG_INBOX0_MSG12);
+	dwords[14] = REG_READ(DMCUB_REG_INBOX0_MSG13);
+	dwords[15] = REG_READ(DMCUB_REG_INBOX0_MSG14);
+}
+
+void dmub_dcn42_write_reg_inbox0_rsp_int_ack(struct dmub_srv *dmub)
+{
+	REG_UPDATE(HOST_INTERRUPT_CSR, HOST_REG_INBOX0_RSP_INT_ACK, 1);
+}
+
+void dmub_dcn42_clear_reg_inbox0_rsp_int_ack(struct dmub_srv *dmub)
+{
+	REG_UPDATE(HOST_INTERRUPT_CSR, HOST_REG_INBOX0_RSP_INT_ACK, 0);
+}
+
+void dmub_dcn42_enable_reg_inbox0_rsp_int(struct dmub_srv *dmub, bool enable)
+{
+	REG_UPDATE(HOST_INTERRUPT_CSR, HOST_REG_INBOX0_RSP_INT_EN, enable ? 1:0);
+}
+
+void dmub_dcn42_write_reg_outbox0_rdy_int_ack(struct dmub_srv *dmub)
+{
+	REG_UPDATE(HOST_INTERRUPT_CSR, HOST_REG_OUTBOX0_RDY_INT_ACK, 1);
+	REG_UPDATE(HOST_INTERRUPT_CSR, HOST_REG_OUTBOX0_RDY_INT_ACK, 0);
+}
+
+void dmub_dcn42_read_reg_outbox0_msg(struct dmub_srv *dmub, uint32_t *msg)
+{
+	*msg = REG_READ(DMCUB_REG_OUTBOX0_MSG0);
+}
+
+
+void dmub_dcn42_enable_reg_outbox0_rdy_int(struct dmub_srv *dmub, bool enable)
+{
+	REG_UPDATE(HOST_INTERRUPT_CSR, HOST_REG_OUTBOX0_RDY_INT_EN, enable ? 1:0);
+}
+
+uint32_t dmub_dcn42_read_reg_outbox0_rdy_int_status(struct dmub_srv *dmub)
+{
+	uint32_t status;
+
+	REG_GET(HOST_INTERRUPT_CSR, HOST_REG_OUTBOX0_RDY_INT_STAT, &status);
+	return status;
+}
+
+void dmub_dcn42_setup_mailbox(struct dmub_srv *dmub,
+		const struct dmub_region *inbox1)
+{
+	REG_WRITE(DMCUB_INBOX1_BASE_ADDRESS, inbox1->base);
+	REG_WRITE(DMCUB_INBOX1_SIZE, inbox1->top - inbox1->base);
+}
+
+void dmub_dcn42_set_gpint(struct dmub_srv *dmub,
+		union dmub_gpint_data_register reg)
+{
+	REG_WRITE(DMCUB_GPINT_DATAIN1, reg.all);
+}
+
+bool dmub_dcn42_is_gpint_acked(struct dmub_srv *dmub,
+		union dmub_gpint_data_register reg)
+{
+	union dmub_gpint_data_register test;
+
+	reg.bits.status = 0;
+	test.all = REG_READ(DMCUB_GPINT_DATAIN1);
+
+	return test.all == reg.all;
+}
+
+uint32_t dmub_dcn42_get_gpint_response(struct dmub_srv *dmub)
+{
+	return REG_READ(DMCUB_SCRATCH7);
+}
+
+uint32_t dmub_dcn42_get_gpint_dataout(struct dmub_srv *dmub)
+{
+	uint32_t dataout = REG_READ(DMCUB_GPINT_DATAOUT);
+
+	REG_UPDATE(DMCUB_INTERRUPT_ENABLE, DMCUB_GPINT_IH_INT_EN, 0);
+
+	REG_WRITE(DMCUB_GPINT_DATAOUT, 0);
+	REG_UPDATE(DMCUB_INTERRUPT_ACK, DMCUB_GPINT_IH_INT_ACK, 1);
+	REG_UPDATE(DMCUB_INTERRUPT_ACK, DMCUB_GPINT_IH_INT_ACK, 0);
+
+	REG_UPDATE(DMCUB_INTERRUPT_ENABLE, DMCUB_GPINT_IH_INT_EN, 1);
+
+	return dataout;
+}
+
+uint32_t dmub_dcn42_get_outbox0_wptr(struct dmub_srv *dmub)
+{
+	return REG_READ(DMCUB_OUTBOX0_WPTR);
+}
+
+void dmub_dcn42_set_outbox0_rptr(struct dmub_srv *dmub, uint32_t rptr_offset)
+{
+	REG_WRITE(DMCUB_OUTBOX0_RPTR, rptr_offset);
+}
+
+uint32_t dmub_dcn42_get_current_time(struct dmub_srv *dmub)
+{
+	return REG_READ(DMCUB_TIMER_CURRENT);
+}
+
+void dmub_dcn42_get_diagnostic_data(struct dmub_srv *dmub)
+{
+	uint32_t is_dmub_enabled, is_soft_reset, is_sec_reset, is_pwait;
+	uint32_t is_traceport_enabled, is_cw0_enabled, is_cw6_enabled;
+	struct dmub_timeout_info timeout = {0};
+
+	if (!dmub)
+		return;
+
+	/* timeout data filled externally, cache before resetting memory */
+	timeout = dmub->debug.timeout_info;
+	memset(&dmub->debug, 0, sizeof(dmub->debug));
+	dmub->debug.timeout_info = timeout;
+
+	dmub->debug.dmcub_version = dmub->fw_version;
+
+	dmub->debug.scratch[0] = REG_READ(DMCUB_SCRATCH0);
+	dmub->debug.scratch[1] = REG_READ(DMCUB_SCRATCH1);
+	dmub->debug.scratch[2] = REG_READ(DMCUB_SCRATCH2);
+	dmub->debug.scratch[3] = REG_READ(DMCUB_SCRATCH3);
+	dmub->debug.scratch[4] = REG_READ(DMCUB_SCRATCH4);
+	dmub->debug.scratch[5] = REG_READ(DMCUB_SCRATCH5);
+	dmub->debug.scratch[6] = REG_READ(DMCUB_SCRATCH6);
+	dmub->debug.scratch[7] = REG_READ(DMCUB_SCRATCH7);
+	dmub->debug.scratch[8] = REG_READ(DMCUB_SCRATCH8);
+	dmub->debug.scratch[9] = REG_READ(DMCUB_SCRATCH9);
+	dmub->debug.scratch[10] = REG_READ(DMCUB_SCRATCH10);
+	dmub->debug.scratch[11] = REG_READ(DMCUB_SCRATCH11);
+	dmub->debug.scratch[12] = REG_READ(DMCUB_SCRATCH12);
+	dmub->debug.scratch[13] = REG_READ(DMCUB_SCRATCH13);
+	dmub->debug.scratch[14] = REG_READ(DMCUB_SCRATCH14);
+	dmub->debug.scratch[15] = REG_READ(DMCUB_SCRATCH15);
+	dmub->debug.scratch[16] = REG_READ(DMCUB_SCRATCH16);
+
+	dmub->debug.undefined_address_fault_addr = REG_READ(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR);
+	dmub->debug.inst_fetch_fault_addr = REG_READ(DMCUB_INST_FETCH_FAULT_ADDR);
+	dmub->debug.data_write_fault_addr = REG_READ(DMCUB_DATA_WRITE_FAULT_ADDR);
+
+	dmub->debug.inbox1_rptr = REG_READ(DMCUB_INBOX1_RPTR);
+	dmub->debug.inbox1_wptr = REG_READ(DMCUB_INBOX1_WPTR);
+	dmub->debug.inbox1_size = REG_READ(DMCUB_INBOX1_SIZE);
+
+	dmub->debug.inbox0_rptr = REG_READ(DMCUB_INBOX0_RPTR);
+	dmub->debug.inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
+	dmub->debug.inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
+
+	dmub->debug.outbox1_rptr = REG_READ(DMCUB_OUTBOX1_RPTR);
+	dmub->debug.outbox1_wptr = REG_READ(DMCUB_OUTBOX1_WPTR);
+	dmub->debug.outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
+
+	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
+	dmub->debug.is_dmcub_enabled = is_dmub_enabled;
+
+	REG_GET(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS, &is_pwait);
+	dmub->debug.is_pwait = is_pwait;
+
+	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &is_soft_reset);
+	dmub->debug.is_dmcub_soft_reset = is_soft_reset;
+
+	REG_GET(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS, &is_sec_reset);
+	dmub->debug.is_dmcub_secure_reset = is_sec_reset;
+
+	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
+	dmub->debug.is_traceport_en  = is_traceport_enabled;
+
+	REG_GET(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE, &is_cw0_enabled);
+	dmub->debug.is_cw0_enabled = is_cw0_enabled;
+
+	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
+	dmub->debug.is_cw6_enabled = is_cw6_enabled;
+
+	dmub->debug.gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
+}
+
+bool dmub_dcn42_get_preos_fw_info(struct dmub_srv *dmub)
+{
+	uint64_t region3_cw5_offset;
+	uint32_t top_addr, top_addr_enable, offset_low;
+	uint32_t offset_high, base_addr, fw_version;
+	bool is_vbios_fw = false;
+
+	memset(&dmub->preos_info, 0, sizeof(dmub->preos_info));
+
+	fw_version = REG_READ(DMCUB_SCRATCH1);
+	is_vbios_fw = ((fw_version >> 6) & 0x01) ? true : false;
+	if (!is_vbios_fw)
+		return false;
+
+	dmub->preos_info.boot_status = REG_READ(DMCUB_SCRATCH0);
+	dmub->preos_info.fw_version = REG_READ(DMCUB_SCRATCH1);
+	dmub->preos_info.boot_options = REG_READ(DMCUB_SCRATCH14);
+	REG_GET(DMCUB_REGION3_CW5_TOP_ADDRESS,
+		DMCUB_REGION3_CW5_ENABLE, &top_addr_enable);
+	if (top_addr_enable) {
+		dmub_dcn42_get_fb_base_offset(dmub,
+			&dmub->preos_info.fb_base, &dmub->preos_info.fb_offset);
+		offset_low = REG_READ(DMCUB_REGION3_CW5_OFFSET);
+		offset_high = REG_READ(DMCUB_REGION3_CW5_OFFSET_HIGH);
+		region3_cw5_offset = ((uint64_t)offset_high << 32) | offset_low;
+		dmub->preos_info.trace_buffer_phy_addr = region3_cw5_offset
+			- dmub->preos_info.fb_base + dmub->preos_info.fb_offset;
+
+		REG_GET(DMCUB_REGION3_CW5_TOP_ADDRESS,
+			DMCUB_REGION3_CW5_TOP_ADDRESS, &top_addr);
+		base_addr = REG_READ(DMCUB_REGION3_CW5_BASE_ADDRESS) & 0x1FFFFFFF;
+		dmub->preos_info.trace_buffer_size =
+			(top_addr > base_addr) ? (top_addr - base_addr + 1) : 0;
+	}
+
+	return true;
+}
+
+void dmub_dcn42_write_reg_outbox0_rsp(struct dmub_srv *dmub, uint32_t *rsp)
+{
+	REG_WRITE(DMCUB_REG_OUTBOX0_RSP, *rsp);
+}
+
+uint32_t dmub_dcn42_read_reg_outbox0_rsp_int_status(struct dmub_srv *dmub)
+{
+	uint32_t status;
+
+	REG_GET(DMCUB_INTERRUPT_STATUS, DMCUB_REG_OUTBOX0_RSP_INT_STAT, &status);
+	return status;
+}
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.h
new file mode 100644
index 000000000000..a49d88ab0455
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.h
@@ -0,0 +1,171 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+#ifndef _DMUB_DCN42_H_
+#define _DMUB_DCN42_H_
+
+#include "dmub_dcn35.h"
+#include "dmub_dcn401.h"
+
+
+struct dmub_srv;
+
+/* DCN42 register definitions. */
+
+#define DMUB_DCN42_REGS() \
+	DMUB_DCN35_REGS() \
+	DMUB_SR(DMCUB_INTERRUPT_STATUS) \
+	DMUB_SR(DMCUB_REG_INBOX0_RDY) \
+	DMUB_SR(DMCUB_REG_INBOX0_MSG0) \
+	DMUB_SR(DMCUB_REG_INBOX0_MSG1) \
+	DMUB_SR(DMCUB_REG_INBOX0_MSG2) \
+	DMUB_SR(DMCUB_REG_INBOX0_MSG3) \
+	DMUB_SR(DMCUB_REG_INBOX0_MSG4) \
+	DMUB_SR(DMCUB_REG_INBOX0_MSG5) \
+	DMUB_SR(DMCUB_REG_INBOX0_MSG6) \
+	DMUB_SR(DMCUB_REG_INBOX0_MSG7) \
+	DMUB_SR(DMCUB_REG_INBOX0_MSG8) \
+	DMUB_SR(DMCUB_REG_INBOX0_MSG9) \
+	DMUB_SR(DMCUB_REG_INBOX0_MSG10) \
+	DMUB_SR(DMCUB_REG_INBOX0_MSG11) \
+	DMUB_SR(DMCUB_REG_INBOX0_MSG12) \
+	DMUB_SR(DMCUB_REG_INBOX0_MSG13) \
+	DMUB_SR(DMCUB_REG_INBOX0_MSG14) \
+	DMUB_SR(DMCUB_REG_INBOX0_RSP) \
+	DMUB_SR(DMCUB_REG_OUTBOX0_RDY) \
+	DMUB_SR(DMCUB_REG_OUTBOX0_MSG0) \
+	DMUB_SR(DMCUB_REG_OUTBOX0_RSP) \
+	DMUB_SR(HOST_INTERRUPT_CSR)
+
+#define DMUB_DCN42_FIELDS() \
+	DMUB_DCN35_FIELDS() \
+	DMUB_SF(DMCUB_INTERRUPT_STATUS, DMCUB_REG_OUTBOX0_RSP_INT_STAT) \
+	DMUB_SF(HOST_INTERRUPT_CSR, HOST_REG_INBOX0_RSP_INT_ACK) \
+	DMUB_SF(HOST_INTERRUPT_CSR, HOST_REG_INBOX0_RSP_INT_STAT) \
+	DMUB_SF(HOST_INTERRUPT_CSR, HOST_REG_INBOX0_RSP_INT_EN) \
+	DMUB_SF(HOST_INTERRUPT_CSR, HOST_REG_OUTBOX0_RDY_INT_ACK) \
+	DMUB_SF(HOST_INTERRUPT_CSR, HOST_REG_OUTBOX0_RDY_INT_STAT) \
+	DMUB_SF(HOST_INTERRUPT_CSR, HOST_REG_OUTBOX0_RDY_INT_EN)
+
+struct dmub_srv_dcn42_reg_offset {
+#define DMUB_SR(reg) uint32_t reg;
+	DMUB_DCN42_REGS()
+	DMCUB_INTERNAL_REGS()
+#undef DMUB_SR
+};
+
+struct dmub_srv_dcn42_reg_shift {
+#define DMUB_SF(reg, field) uint8_t reg##__##field;
+	DMUB_DCN42_FIELDS()
+#undef DMUB_SF
+};
+
+struct dmub_srv_dcn42_reg_mask {
+#define DMUB_SF(reg, field) uint32_t reg##__##field;
+	DMUB_DCN42_FIELDS()
+#undef DMUB_SF
+};
+
+struct dmub_srv_dcn42_regs {
+	struct dmub_srv_dcn42_reg_offset offset;
+	struct dmub_srv_dcn42_reg_mask mask;
+	struct dmub_srv_dcn42_reg_shift shift;
+};
+
+/* Function declarations */
+
+/* Initialization and configuration */
+void dmub_srv_dcn42_regs_init(struct dmub_srv *dmub, struct dc_context *ctx);
+void dmub_dcn42_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmub_srv_hw_params *params);
+void dmub_dcn42_skip_dmub_panel_power_sequence(struct dmub_srv *dmub, bool skip);
+void dmub_dcn42_configure_dmub_in_system_memory(struct dmub_srv *dmub);
+
+/* Reset and control */
+void dmub_dcn42_reset(struct dmub_srv *dmub);
+void dmub_dcn42_reset_release(struct dmub_srv *dmub);
+
+/* Firmware loading */
+void dmub_dcn42_backdoor_load(struct dmub_srv *dmub, const struct dmub_window *cw0, const struct dmub_window *cw1);
+void dmub_dcn42_backdoor_load_zfb_mode(struct dmub_srv *dmub, const struct dmub_window *cw0, const struct dmub_window *cw1);
+void dmub_dcn42_setup_windows(struct dmub_srv *dmub, const struct dmub_window *cw2, const struct dmub_window *cw3, const struct dmub_window *cw4, const struct dmub_window *cw5, const struct dmub_window *cw6, const struct dmub_window *region6);
+
+/* Mailbox operations - Inbox1 */
+void dmub_dcn42_setup_mailbox(struct dmub_srv *dmub, const struct dmub_region *inbox1);
+uint32_t dmub_dcn42_get_inbox1_wptr(struct dmub_srv *dmub);
+uint32_t dmub_dcn42_get_inbox1_rptr(struct dmub_srv *dmub);
+void dmub_dcn42_set_inbox1_wptr(struct dmub_srv *dmub, uint32_t wptr_offset);
+
+/* Mailbox operations - Outbox1 */
+void dmub_dcn42_setup_out_mailbox(struct dmub_srv *dmub, const struct dmub_region *outbox1);
+uint32_t dmub_dcn42_get_outbox1_wptr(struct dmub_srv *dmub);
+void dmub_dcn42_set_outbox1_rptr(struct dmub_srv *dmub, uint32_t rptr_offset);
+
+/* Mailbox operations - Outbox0 */
+void dmub_dcn42_setup_outbox0(struct dmub_srv *dmub, const struct dmub_region *outbox0);
+uint32_t dmub_dcn42_get_outbox0_wptr(struct dmub_srv *dmub);
+void dmub_dcn42_set_outbox0_rptr(struct dmub_srv *dmub, uint32_t rptr_offset);
+
+/* Mailbox operations - Inbox0 */
+void dmub_dcn42_send_inbox0_cmd(struct dmub_srv *dmub, union dmub_inbox0_data_register data);
+void dmub_dcn42_clear_inbox0_ack_register(struct dmub_srv *dmub);
+uint32_t dmub_dcn42_read_inbox0_ack_register(struct dmub_srv *dmub);
+
+/* REG Inbox0/Outbox0 operations */
+void dmub_dcn42_send_reg_inbox0_cmd_msg(struct dmub_srv *dmub, union dmub_rb_cmd *cmd);
+uint32_t dmub_dcn42_read_reg_inbox0_rsp_int_status(struct dmub_srv *dmub);
+void dmub_dcn42_read_reg_inbox0_cmd_rsp(struct dmub_srv *dmub, union dmub_rb_cmd *cmd);
+void dmub_dcn42_write_reg_inbox0_rsp_int_ack(struct dmub_srv *dmub);
+void dmub_dcn42_clear_reg_inbox0_rsp_int_ack(struct dmub_srv *dmub);
+void dmub_dcn42_enable_reg_inbox0_rsp_int(struct dmub_srv *dmub, bool enable);
+
+void dmub_dcn42_write_reg_outbox0_rdy_int_ack(struct dmub_srv *dmub);
+void dmub_dcn42_read_reg_outbox0_msg(struct dmub_srv *dmub, uint32_t *msg);
+void dmub_dcn42_write_reg_outbox0_rsp(struct dmub_srv *dmub, uint32_t *rsp);
+uint32_t dmub_dcn42_read_reg_outbox0_rsp_int_status(struct dmub_srv *dmub);
+void dmub_dcn42_enable_reg_outbox0_rdy_int(struct dmub_srv *dmub, bool enable);
+uint32_t dmub_dcn42_read_reg_outbox0_rdy_int_status(struct dmub_srv *dmub);
+
+/* GPINT operations */
+void dmub_dcn42_set_gpint(struct dmub_srv *dmub, union dmub_gpint_data_register reg);
+bool dmub_dcn42_is_gpint_acked(struct dmub_srv *dmub, union dmub_gpint_data_register reg);
+uint32_t dmub_dcn42_get_gpint_response(struct dmub_srv *dmub);
+uint32_t dmub_dcn42_get_gpint_dataout(struct dmub_srv *dmub);
+
+/* Status and detection */
+bool dmub_dcn42_is_hw_init(struct dmub_srv *dmub);
+bool dmub_dcn42_is_supported(struct dmub_srv *dmub);
+bool dmub_dcn42_is_hw_powered_up(struct dmub_srv *dmub);
+bool dmub_dcn42_should_detect(struct dmub_srv *dmub);
+
+
+/* Firmware boot status and options */
+union dmub_fw_boot_status dmub_dcn42_get_fw_boot_status(struct dmub_srv *dmub);
+union dmub_fw_boot_options dmub_dcn42_get_fw_boot_option(struct dmub_srv *dmub);
+
+/* Timing and diagnostics */
+uint32_t dmub_dcn42_get_current_time(struct dmub_srv *dmub);
+void dmub_dcn42_get_diagnostic_data(struct dmub_srv *dmub);
+bool dmub_dcn42_get_preos_fw_info(struct dmub_srv *dmub);
+
+#endif /* _DMUB_DCN42_H_ */
-- 
2.34.1

