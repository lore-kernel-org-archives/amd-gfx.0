Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80945F513E9
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 03:27:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25AB310E30C;
	Fri,  6 Mar 2026 03:27:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K7XUuOrf";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012014.outbound.protection.outlook.com [52.101.43.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CA2010E30C
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 03:27:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvJsOI2R+BS9z9LiIMODy1zYDl1rfwqb2MommKbuaXNdZUi20wg+WouF0F63owFMD69r5foolK/QcphB4DDtWoOYDuSpQCbp8KM4/S3ZfK/2PiAKPhAGQ4fK7EMvsZt68kVmYTGiVa/oq/yO4vk388aE4OugmJBHH4pWf0DN6nFIvx2CARL+xDNzvV5cxSXXDpIaJhDDvvWrXqerAtuPipDa3nElsiH8JzVE5LXHOUc05njsWUuKSPfCy88w9PklJ7/LvGFqVSyFHNNlVM/O6OvBXDc9K41U0h1OUdw9gvKdlyFe9qcKUn1ZMTuFpIQ+xbzWzrFd/IS0dV8Ngshg4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nocNaPC1aZrs1peoRafaXjFvMF/U4lb3OADo2KtWVgQ=;
 b=qbVo0ML7WtnZlZMSM3cm2sPlBD0VPG66lG3lStuhpMYIRFLuyGM2k3wXQy4OI3pqoB9WykxbBWTOyOipriI94XzRjZm0/b7oAFhYAxONNfES8TXUfXbQJDiMcvHuteBfbLuTqHoKKNN8a3wU5j0A7JoFt8DJNBgC2QcN2ijSd29uJt9HIAnRGjedwxrIP5mAHS/ZeIxssCCt8Ot/brT42MPPKWHbBZXPBDO2heE1I/qLbYeJW1gPvOcdqqdBXuGI6NTJ2kPDDJ3FgyCLHkdtkS96lqu2bMXhSzmSzfxezjEJRmtkCe4/oBNumetTDpelgPwMhPqsruhfUM7b33vz2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nocNaPC1aZrs1peoRafaXjFvMF/U4lb3OADo2KtWVgQ=;
 b=K7XUuOrfC44E+T53uYh6HF8t0UhroiJ1bYidgSLRPapDBvh1+13k+HF27iPjKWjnGpBkRQ83/+yNpwLTklsa1dn7Y31VIs4Mu1lwbJvvo0hQ2lHCHvfKTQ36cp/eYFZEz1D65v9LQmgo1byU+d/+5IVGmwo5Nq+MqlPKaRJUToQ=
Received: from BLAPR03CA0006.namprd03.prod.outlook.com (2603:10b6:208:32b::11)
 by BN7PPF9C6E5285F.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6db) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 03:27:48 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::21) by BLAPR03CA0006.outlook.office365.com
 (2603:10b6:208:32b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Fri,
 6 Mar 2026 03:27:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 03:27:48 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Mar
 2026 21:27:46 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>
Subject: [PATCH 18/21] drm/amd/display: Add DML support for dcn42
Date: Thu, 5 Mar 2026 20:13:44 -0700
Message-ID: <20260306031932.136179-19-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306031932.136179-1-alex.hung@amd.com>
References: <20260306031932.136179-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|BN7PPF9C6E5285F:EE_
X-MS-Office365-Filtering-Correlation-Id: 73536d7c-27b7-4d45-74f6-08de7b305747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016; 
X-Microsoft-Antispam-Message-Info: AP3Y6YNsaTNrSNKkxiAUwMOhByvPD8/1nlXCZhWBf8yxyo8cUiaA4NmmBjUNpG2goTfXUw1aWON9wTtClG/OG+P2SwrnS+UTFxI8MDzS1NpBoFHmE9qjKEmry2HQoLI6mi4vDWSQetPx7D0WsanBhll92W3BtZ4vDiIWMqIPDzQw4SImg13QR6pPHNxuSXIO5zdOnzWulHDMf/CJfSjiL3VYQvhoFtA/Jhy2Wj0SSK6U5HzrAtb1i3VxP+wjcIjZina3UxKG6VrQj+dtYwNrSUV4W954Kpqfti1sGIRp7hbT0Bz+WRirOlYawc6mXlcAxrbECFq9rOljFcDYk6Y6j448wAE/m8ZOn9jk8sKTKwtBXGhVDMb9P3Ho7aivn8NKz5dWXL/+7B36qNPm5qHEMBX3AAnxam2CVzw+0WrMqjEO9Mtrplwl4JqXovLg0E2QVmQbMcl8rK6OWc6kWPB69k6MmaPi9FPhszrvimZf2nOK5EZevC0YInflWro3sUd2+IQL4sXlE16cgWl+9LFBQvR6OPBJA2iREhm5/o77sGdT4NmtABOvVCuNzYZF11LTmlT/47B7ZJuTITXvDo2QCE8QD9m1rL4E2E55YrJPAHLLiuwCznt69XIAKIt+eSH1Rvc6criWy83zzuq44xJ+ohpyVpbD6CppAI+B/tweNBndshYKbhLSbYvo3vrZV82XBI6L/g444tlroO2Shsid/nPIYBxXa2Nxubg3XMbyzk6tCWrwaGQVm+TM+Pw46l1wefECUl8bq7wIyDjtZX2+MQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7KNGVsbB6IsFJCtlqofp7Wx+Rbdkgv3bqYuWCmDM7jah7GsFVJl4CgXBYGgEui2JGAj7yfuCcUY8D0y280o4gbXnhWIP8xlOVlB9bjZovTPhk7A7yCupX8ClIjEWgzreyTudLqcVVCE5J2kwNr81CLO4HCsC3gE1cRlHCn5TknOeBWtfifr0vPl1SxhuoUPSrFtFEka0dz0dFe2oHEj9S6lBcn0FYvt0gBk4Bt3Pynq8s3O8xHCjmQF31cIw9Xre65tp80HLvLoUOH9J+cL2yI/doISzennkXLgosEwqNMqkkHo/9yQVDY9/CVtoTF0Cw7schcPseW7eUtDFcUbcN67Konlki97PdKJ7UUwl/KceSAub2tUyQ6lEANiLIeJtMArNKiluy5QePpFJcyXnoprVGtrl6FHpjtg+zeY41IhfNAKipOZXCe5jbCQoTwYT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:27:48.5704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73536d7c-27b7-4d45-74f6-08de7b305747
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9C6E5285F
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

DML support for DCN 4.2

Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    |   3 +
 .../dml2_0/dml21/dml21_translation_helper.c   |  13 ++
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |   1 +
 .../dml21/src/dml2_core/dml2_core_dcn4.c      | 111 ++++++++++++++++++
 .../dml21/src/dml2_core/dml2_core_dcn4.h      |   1 +
 .../dml21/src/dml2_core/dml2_core_factory.c   |   8 ++
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c      |  34 ++++++
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.h      |   1 +
 .../dml21/src/dml2_dpmm/dml2_dpmm_factory.c   |   5 +
 .../dml21/src/dml2_mcg/dml2_mcg_dcn42.c       |  76 ++++++++++++
 .../dml21/src/dml2_mcg/dml2_mcg_dcn42.h       |  11 ++
 .../dml21/src/dml2_mcg/dml2_mcg_factory.c     |   5 +
 .../dml21/src/dml2_top/dml2_top_interfaces.c  |   1 +
 13 files changed, 270 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.h

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
index 30cfc0848792..70d9f2cd0b60 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
@@ -90,6 +90,7 @@ CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_factory.o := $(dml2
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.o := $(dml2_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.o := $(dml2_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.o := $(dml2_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.o := $(dml2_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.o := $(dml2_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn3.o := $(dml2_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.o := $(dml2_ccflags)
@@ -107,6 +108,7 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_top/dml2_top_soc15.o := $(d
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.o := $(dml2_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn3.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.o := $(dml2_rcflags)
@@ -124,6 +126,7 @@ DML21 += src/dml2_core/dml2_core_dcn4_calcs.o
 DML21 += src/dml2_dpmm/dml2_dpmm_dcn4.o
 DML21 += src/dml2_dpmm/dml2_dpmm_factory.o
 DML21 += src/dml2_mcg/dml2_mcg_dcn4.o
+DML21 += src/dml2_mcg/dml2_mcg_dcn42.o
 DML21 += src/dml2_mcg/dml2_mcg_factory.o
 DML21 += src/dml2_pmo/dml2_pmo_dcn3.o
 DML21 += src/dml2_pmo/dml2_pmo_factory.o
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
index cd12b7a6da65..6cc03391fff6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
@@ -45,6 +45,9 @@ static enum dml2_project_id dml21_dcn_revision_to_dml2_project_id(enum dce_versi
 	case DCN_VERSION_4_01:
 		project_id = dml2_project_dcn4x_stage2_auto_drr_svp;
 		break;
+	case DCN_VERSION_4_2:
+		project_id = dml2_project_dcn42;
+		break;
 	default:
 		project_id = dml2_project_invalid;
 		DC_ERR("unsupported dcn version for DML21!");
@@ -615,6 +618,13 @@ static void populate_dml21_plane_config_from_plane_state(struct dml2_context *dm
 		case DC_CM2_GPU_MEM_SIZE_171717:
 			plane->tdlut.tdlut_width_mode = dml2_tdlut_width_17_cube;
 			break;
+		case DC_CM2_GPU_MEM_SIZE_333333:
+			plane->tdlut.tdlut_width_mode = dml2_tdlut_width_33_cube;
+			break;
+		// handling when use case and HW support available
+		case DC_CM2_GPU_MEM_SIZE_454545:
+		case DC_CM2_GPU_MEM_SIZE_656565:
+			break;
 		case DC_CM2_GPU_MEM_SIZE_TRANSFORMED:
 		default:
 			//plane->tdlut.tdlut_width_mode = dml2_tdlut_width_flatten; // dml2_tdlut_width_flatten undefined
@@ -824,6 +834,9 @@ void dml21_copy_clocks_to_dc_state(struct dml2_context *in_ctx, struct dc_state
 	context->bw_ctx.bw.dcn.clk.subvp_prefetch_fclk_khz = in_ctx->v21.mode_programming.programming->min_clocks.dcn4x.svp_prefetch_no_throttle.fclk_khz;
 	context->bw_ctx.bw.dcn.clk.stutter_efficiency.base_efficiency = in_ctx->v21.mode_programming.programming->stutter.base_percent_efficiency;
 	context->bw_ctx.bw.dcn.clk.stutter_efficiency.low_power_efficiency = in_ctx->v21.mode_programming.programming->stutter.low_power_percent_efficiency;
+	context->bw_ctx.bw.dcn.clk.stutter_efficiency.z8_stutter_efficiency = in_ctx->v21.mode_programming.programming->informative.power_management.z8.stutter_efficiency;
+	context->bw_ctx.bw.dcn.clk.stutter_efficiency.z8_stutter_period = in_ctx->v21.mode_programming.programming->informative.power_management.z8.stutter_period;
+	context->bw_ctx.bw.dcn.clk.zstate_support = in_ctx->v21.mode_programming.programming->z8_stutter.supported_in_blank; /*ignore meets_eco since it is not used*/
 }
 
 static struct dml2_dchub_watermark_regs *wm_set_index_to_dc_wm_set(union dcn_watermark_set *watermarks, const enum dml2_dchub_watermark_reg_set_index wm_index)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
index 943fd3f040c3..c854515b49a3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
@@ -19,6 +19,7 @@ enum dml2_project_id {
 	dml2_project_dcn4x_stage1,
 	dml2_project_dcn4x_stage2,
 	dml2_project_dcn4x_stage2_auto_drr_svp,
+	dml2_project_dcn42,
 };
 
 enum dml2_pstate_change_support {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
index eba948e187c1..23ede1107340 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
@@ -78,6 +78,86 @@ struct dml2_core_ip_params core_dcn4_ip_caps_base = {
 	.subvp_swath_height_margin_lines = 16,
 };
 
+struct dml2_core_ip_params core_dcn42_ip_caps_base = {
+.vblank_nom_default_us = 668,
+.remote_iommu_outstanding_translations = 256,
+.rob_buffer_size_kbytes = 64,
+.config_return_buffer_size_in_kbytes = 1792,
+.config_return_buffer_segment_size_in_kbytes = 64,
+.compressed_buffer_segment_size_in_kbytes = 64,
+.dpte_buffer_size_in_pte_reqs_luma = 68,
+.dpte_buffer_size_in_pte_reqs_chroma = 36,
+.pixel_chunk_size_kbytes = 8,
+.alpha_pixel_chunk_size_kbytes = 4,
+.min_pixel_chunk_size_bytes = 1024,
+.writeback_chunk_size_kbytes = 8,
+.line_buffer_size_bits = 1171920,
+.max_line_buffer_lines = 32,
+.writeback_interface_buffer_size_kbytes = 90,
+
+//Number of pipes after DCN Pipe harvesting
+.max_num_dpp = 4,
+.max_num_otg = 4,
+.max_num_opp = 4,
+.max_num_wb = 1,
+.max_dchub_pscl_bw_pix_per_clk = 4,
+.max_pscl_lb_bw_pix_per_clk = 2,
+.max_lb_vscl_bw_pix_per_clk = 4,
+.max_vscl_hscl_bw_pix_per_clk = 4,
+.max_hscl_ratio = 6,
+.max_vscl_ratio = 6,
+.max_hscl_taps = 8,
+.max_vscl_taps = 8,
+.dispclk_ramp_margin_percent = 1,
+.dppclk_delay_subtotal = 47,
+.dppclk_delay_scl = 50,
+.dppclk_delay_scl_lb_only = 16,
+.dppclk_delay_cnvc_formatter = 28,
+.dppclk_delay_cnvc_cursor = 6,
+.cursor_buffer_size = 42,
+.cursor_chunk_size = 2,
+.dispclk_delay_subtotal = 125,
+.max_inter_dcn_tile_repeaters = 8,
+.writeback_max_hscl_ratio = 1,
+.writeback_max_vscl_ratio = 1,
+.writeback_min_hscl_ratio = 1,
+.writeback_min_vscl_ratio = 1,
+.writeback_max_hscl_taps = 1,
+.writeback_max_vscl_taps = 1,
+.writeback_line_buffer_buffer_size = 0,
+.num_dsc = 4,
+.maximum_dsc_bits_per_component = 12,
+.maximum_pixels_per_line_per_dsc_unit = 5760,
+.dsc422_native_support = true,
+.dcc_supported = true,
+.ptoi_supported = false,
+
+.cursor_64bpp_support = true,
+.dynamic_metadata_vm_enabled = false,
+
+.max_num_hdmi_frl_outputs = 0,
+.max_num_dp2p0_outputs = 2,
+.max_num_dp2p0_streams = 4,
+.imall_supported = 1,
+.max_flip_time_us = 110,
+.max_flip_time_lines = 50,
+.words_per_channel = 16,
+
+.subvp_fw_processing_delay_us = 15,
+.subvp_pstate_allow_width_us = 20,
+.subvp_swath_height_margin_lines = 16,
+
+.dcn_mrq_present = 1,
+.zero_size_buffer_entries = 512,
+.compbuf_reserved_space_zs = 64,
+.dcc_meta_buffer_size_bytes = 6272,
+.meta_chunk_size_kbytes = 2,
+.min_meta_chunk_size_bytes = 256,
+
+.dchub_arb_to_ret_delay = 102,
+.hostvm_mode = 1,
+};
+
 static void patch_ip_caps_with_explicit_ip_params(struct dml2_ip_capabilities *ip_caps, const struct dml2_core_ip_params *ip_params)
 {
 	ip_caps->pipe_count = ip_params->max_num_dpp;
@@ -153,6 +233,37 @@ bool core_dcn4_initialize(struct dml2_core_initialize_in_out *in_out)
 	return true;
 }
 
+bool core_dcn42_initialize(struct dml2_core_initialize_in_out *in_out)
+{
+struct dml2_core_instance *core = in_out->instance;
+
+if (!in_out->minimum_clock_table)
+return false;
+
+core->minimum_clock_table = in_out->minimum_clock_table;
+
+if (in_out->explicit_ip_bb && in_out->explicit_ip_bb_size > 0) {
+memcpy(&core->clean_me_up.mode_lib.ip, in_out->explicit_ip_bb, in_out->explicit_ip_bb_size);
+
+// FIXME_STAGE2:
+// DV still uses stage1 ip_param_st for each variant, need to patch the ip_caps with ip_param info
+// Should move DV to use ip_caps but need move more overrides to ip_caps
+patch_ip_caps_with_explicit_ip_params(in_out->ip_caps, in_out->explicit_ip_bb);
+core->clean_me_up.mode_lib.ip.subvp_pstate_allow_width_us = core_dcn4_ip_caps_base.subvp_pstate_allow_width_us;
+core->clean_me_up.mode_lib.ip.subvp_fw_processing_delay_us = core_dcn4_ip_caps_base.subvp_pstate_allow_width_us;
+core->clean_me_up.mode_lib.ip.subvp_swath_height_margin_lines = core_dcn4_ip_caps_base.subvp_swath_height_margin_lines;
+} else {
+memcpy(&core->clean_me_up.mode_lib.ip, &core_dcn42_ip_caps_base, sizeof(struct dml2_core_ip_params));
+patch_ip_params_with_ip_caps(&core->clean_me_up.mode_lib.ip, in_out->ip_caps);
+core->clean_me_up.mode_lib.ip.imall_supported = false;
+}
+
+memcpy(&core->clean_me_up.mode_lib.soc, in_out->soc_bb, sizeof(struct dml2_soc_bb));
+memcpy(&core->clean_me_up.mode_lib.ip_caps, in_out->ip_caps, sizeof(struct dml2_ip_capabilities));
+
+return true;
+}
+
 static void create_phantom_stream_from_main_stream(struct dml2_stream_parameters *phantom, const struct dml2_stream_parameters *main,
 	const struct dml2_implicit_svp_meta *meta)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.h
index a68bb001a346..5c26d819a673 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.h
@@ -5,6 +5,7 @@
 #ifndef __DML2_CORE_DCN4_H__
 #define __DML2_CORE_DCN4_H__
 bool core_dcn4_initialize(struct dml2_core_initialize_in_out *in_out);
+bool core_dcn42_initialize(struct dml2_core_initialize_in_out *in_out);
 bool core_dcn4_mode_support(struct dml2_core_mode_support_in_out *in_out);
 bool core_dcn4_mode_programming(struct dml2_core_mode_programming_in_out *in_out);
 bool core_dcn4_populate_informative(struct dml2_core_populate_informative_in_out *in_out);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_factory.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_factory.c
index cc4f0663c6d6..67e307fa4310 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_factory.c
@@ -30,6 +30,14 @@ bool dml2_core_create(enum dml2_project_id project_id, struct dml2_core_instance
 		out->calculate_mcache_allocation = &core_dcn4_calculate_mcache_allocation;
 		result = true;
 		break;
+	case dml2_project_dcn42:
+		out->initialize = &core_dcn42_initialize;
+		out->mode_support = &core_dcn4_mode_support;
+		out->mode_programming = &core_dcn4_mode_programming;
+		out->populate_informative = &core_dcn4_populate_informative;
+		out->calculate_mcache_allocation = &core_dcn4_calculate_mcache_allocation;
+		result = true;
+		break;
 	case dml2_project_invalid:
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
index 9d7741fd0adb..037272d2c2e6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
@@ -802,3 +802,37 @@ bool dpmm_dcn4_map_watermarks(struct dml2_dpmm_map_watermarks_params_in_out *in_
 
 	return true;
 }
+
+bool dpmm_dcn42_map_watermarks(struct dml2_dpmm_map_watermarks_params_in_out *in_out)
+{
+	const struct dml2_display_cfg *display_cfg = &in_out->display_cfg->display_config;
+	const struct dml2_core_internal_display_mode_lib *mode_lib = &in_out->core->clean_me_up.mode_lib;
+	struct dml2_dchub_global_register_set *dchubbub_regs = &in_out->programming->global_regs;
+
+	double refclk_freq_in_mhz = (display_cfg->overrides.hw.dlg_ref_clk_mhz > 0) ? (double)display_cfg->overrides.hw.dlg_ref_clk_mhz : mode_lib->soc.dchub_refclk_mhz;
+
+	/* set A */
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].fclk_pstate = (int unsigned)(mode_lib->mp.Watermark.FCLKChangeWatermark * refclk_freq_in_mhz);
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].sr_enter = (int unsigned)(mode_lib->mp.Watermark.StutterEnterPlusExitWatermark * refclk_freq_in_mhz);
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].sr_exit = (int unsigned)(mode_lib->mp.Watermark.StutterExitWatermark * refclk_freq_in_mhz);
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].sr_enter_z8 = (int unsigned)(mode_lib->mp.Watermark.Z8StutterEnterPlusExitWatermark * refclk_freq_in_mhz);
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].sr_exit_z8 = (int unsigned)(mode_lib->mp.Watermark.Z8StutterExitWatermark * refclk_freq_in_mhz);
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].temp_read_or_ppt = (int unsigned)(mode_lib->mp.Watermark.temp_read_or_ppt_watermark_us * refclk_freq_in_mhz);
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].uclk_pstate = (int unsigned)(mode_lib->mp.Watermark.DRAMClockChangeWatermark * refclk_freq_in_mhz);
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].urgent = (int unsigned)(mode_lib->mp.Watermark.UrgentWatermark * refclk_freq_in_mhz);
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].usr = (int unsigned)(mode_lib->mp.Watermark.USRRetrainingWatermark * refclk_freq_in_mhz);
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].refcyc_per_trip_to_mem = (unsigned int)(mode_lib->mp.Watermark.UrgentWatermark * refclk_freq_in_mhz);
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].refcyc_per_meta_trip_to_mem = (unsigned int)(mode_lib->mp.Watermark.UrgentWatermark * refclk_freq_in_mhz);
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].frac_urg_bw_flip = (unsigned int)(mode_lib->mp.FractionOfUrgentBandwidthImmediateFlip * 1000);
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].frac_urg_bw_nom = (unsigned int)(mode_lib->mp.FractionOfUrgentBandwidth * 1000);
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].frac_urg_bw_mall = (unsigned int)(mode_lib->mp.FractionOfUrgentBandwidthMALL * 1000);
+
+	/* set B */
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_B] = dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A];
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_C] = dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A];
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_D] = dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A];
+
+	dchubbub_regs->num_watermark_sets = 4;
+
+	return true;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.h
index e7b58f2efda4..5fbd07e238a8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.h
@@ -10,5 +10,6 @@
 bool dpmm_dcn3_map_mode_to_soc_dpm(struct dml2_dpmm_map_mode_to_soc_dpm_params_in_out *in_out);
 bool dpmm_dcn4_map_mode_to_soc_dpm(struct dml2_dpmm_map_mode_to_soc_dpm_params_in_out *in_out);
 bool dpmm_dcn4_map_watermarks(struct dml2_dpmm_map_watermarks_params_in_out *in_out);
+bool dpmm_dcn42_map_watermarks(struct dml2_dpmm_map_watermarks_params_in_out *in_out);
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c
index dfd01440737d..80d4932bf154 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c
@@ -41,6 +41,11 @@ bool dml2_dpmm_create(enum dml2_project_id project_id, struct dml2_dpmm_instance
 		out->map_watermarks = &dpmm_dcn4_map_watermarks;
 		result = true;
 		break;
+	case dml2_project_dcn42:
+		out->map_mode_to_soc_dpm = &dpmm_dcn4_map_mode_to_soc_dpm;
+		out->map_watermarks = &dpmm_dcn42_map_watermarks;
+		result = true;
+		break;
 	case dml2_project_invalid:
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.c
new file mode 100644
index 000000000000..1f67cbc2c236
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2026 Advanced Micro Devices, Inc.
+
+#include "dml2_mcg_dcn42.h"
+#include "dml_top_soc_parameter_types.h"
+
+static unsigned long long uclk_to_dram_bw_kbps(unsigned long uclk_khz, const struct dml2_dram_params *dram_config, unsigned long wck_ratio)
+{
+	unsigned long long bw_kbps = 0;
+
+	bw_kbps = (unsigned long long) uclk_khz * dram_config->channel_count * dram_config->channel_width_bytes * wck_ratio * 2;
+	return bw_kbps;
+}
+
+static bool build_min_clk_table_coarse_grained(const struct dml2_soc_bb *soc_bb, struct dml2_mcg_min_clock_table *min_table)
+{
+	int i;
+
+	for (i = 0; i < soc_bb->clk_table.fclk.num_clk_values; i++) {
+		if (i < soc_bb->clk_table.uclk.num_clk_values) {
+			min_table->dram_bw_table.entries[i].pre_derate_dram_bw_kbps =
+					uclk_to_dram_bw_kbps(soc_bb->clk_table.uclk.clk_values_khz[i], &soc_bb->clk_table.dram_config, soc_bb->clk_table.wck_ratio.clk_values_khz[i]);
+			min_table->dram_bw_table.entries[i].min_uclk_khz = soc_bb->clk_table.uclk.clk_values_khz[i];
+		} else {
+			min_table->dram_bw_table.entries[i].pre_derate_dram_bw_kbps = min_table->dram_bw_table.entries[soc_bb->clk_table.uclk.num_clk_values - 1].pre_derate_dram_bw_kbps;
+			min_table->dram_bw_table.entries[i].min_uclk_khz = soc_bb->clk_table.uclk.clk_values_khz[soc_bb->clk_table.uclk.num_clk_values - 1];
+		}
+
+		min_table->dram_bw_table.entries[i].min_dcfclk_khz = soc_bb->clk_table.dcfclk.clk_values_khz[i];
+		min_table->dram_bw_table.entries[i].min_fclk_khz = soc_bb->clk_table.fclk.clk_values_khz[i];
+	}
+	min_table->dram_bw_table.num_entries = soc_bb->clk_table.fclk.num_clk_values;
+
+	return true;
+}
+
+static bool build_min_clock_table(const struct dml2_soc_bb *soc_bb, struct dml2_mcg_min_clock_table *min_table)
+{
+	bool result;
+
+	if (!soc_bb || !min_table)
+		return false;
+
+
+	if (soc_bb->clk_table.uclk.num_clk_values > DML_MCG_MAX_CLK_TABLE_SIZE)
+		return false;
+
+	min_table->fixed_clocks_khz.amclk = 0;
+	min_table->fixed_clocks_khz.dprefclk = soc_bb->dprefclk_mhz * 1000;
+	min_table->fixed_clocks_khz.pcierefclk = soc_bb->pcie_refclk_mhz * 1000;
+	min_table->fixed_clocks_khz.dchubrefclk = soc_bb->dchub_refclk_mhz * 1000;
+	min_table->fixed_clocks_khz.xtalclk = soc_bb->xtalclk_mhz * 1000;
+
+	min_table->max_clocks_khz.dispclk = soc_bb->clk_table.dispclk.clk_values_khz[soc_bb->clk_table.dispclk.num_clk_values - 1];
+	min_table->max_clocks_khz.dppclk = soc_bb->clk_table.dppclk.clk_values_khz[soc_bb->clk_table.dppclk.num_clk_values - 1];
+	min_table->max_clocks_khz.dscclk = soc_bb->clk_table.dscclk.clk_values_khz[soc_bb->clk_table.dscclk.num_clk_values - 1];
+	min_table->max_clocks_khz.dtbclk = soc_bb->clk_table.dtbclk.clk_values_khz[soc_bb->clk_table.dtbclk.num_clk_values - 1];
+	min_table->max_clocks_khz.phyclk = soc_bb->clk_table.phyclk.clk_values_khz[soc_bb->clk_table.phyclk.num_clk_values - 1];
+
+	min_table->max_ss_clocks_khz.dispclk = (unsigned int)((double)min_table->max_clocks_khz.dispclk / (1.0 + soc_bb->dcn_downspread_percent / 100.0));
+	min_table->max_ss_clocks_khz.dppclk = (unsigned int)((double)min_table->max_clocks_khz.dppclk / (1.0 + soc_bb->dcn_downspread_percent / 100.0));
+	min_table->max_ss_clocks_khz.dtbclk = (unsigned int)((double)min_table->max_clocks_khz.dtbclk / (1.0 + soc_bb->dcn_downspread_percent / 100.0));
+
+	min_table->max_clocks_khz.dcfclk = soc_bb->clk_table.dcfclk.clk_values_khz[soc_bb->clk_table.dcfclk.num_clk_values - 1];
+	min_table->max_clocks_khz.fclk = soc_bb->clk_table.fclk.clk_values_khz[soc_bb->clk_table.fclk.num_clk_values - 1];
+
+	result = build_min_clk_table_coarse_grained(soc_bb, min_table);
+
+	return result;
+}
+
+bool mcg_dcn42_build_min_clock_table(struct dml2_mcg_build_min_clock_table_params_in_out *in_out)
+{
+	return build_min_clock_table(in_out->soc_bb, in_out->min_clk_table);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.h
new file mode 100644
index 000000000000..ad8a847a0a17
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright 2026 Advanced Micro Devices, Inc. */
+
+#ifndef __DML2_MCG_DCN42_H__
+#define __DML2_MCG_DCN42_H__
+
+#include "dml2_internal_shared_types.h"
+
+bool mcg_dcn42_build_min_clock_table(struct dml2_mcg_build_min_clock_table_params_in_out *in_out);
+
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c
index c60b8fe90819..1cff62b63e72 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c
@@ -4,6 +4,7 @@
 
 #include "dml2_mcg_factory.h"
 #include "dml2_mcg_dcn4.h"
+#include "dml2_mcg_dcn42.h"
 #include "dml2_external_lib_deps.h"
 
 static bool dummy_build_min_clock_table(struct dml2_mcg_build_min_clock_table_params_in_out *in_out)
@@ -30,6 +31,10 @@ bool dml2_mcg_create(enum dml2_project_id project_id, struct dml2_mcg_instance *
 		out->build_min_clock_table = &mcg_dcn4_build_min_clock_table;
 		result = true;
 		break;
+	case dml2_project_dcn42:
+		out->build_min_clock_table = &mcg_dcn42_build_min_clock_table;
+		result = true;
+		break;
 	case dml2_project_invalid:
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_interfaces.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_interfaces.c
index 5a33e2f357f4..04860b6790df 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_interfaces.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_interfaces.c
@@ -17,6 +17,7 @@ bool dml2_initialize_instance(struct dml2_initialize_instance_in_out *in_out)
 	case dml2_project_dcn4x_stage1:
 	case dml2_project_dcn4x_stage2:
 	case dml2_project_dcn4x_stage2_auto_drr_svp:
+	case dml2_project_dcn42:
 		return dml2_top_soc15_initialize_instance(in_out);
 	case dml2_project_invalid:
 	default:
-- 
2.43.0

