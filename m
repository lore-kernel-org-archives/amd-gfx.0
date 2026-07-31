Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C7AC55172
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C421110E245;
	Fri, 31 Jul 2026 21:15:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D/ZLOF5q";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010042.outbound.protection.outlook.com [52.101.46.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C63F310E245
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:15:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KEJ5G7d1m7qZk38vSm5QMxMdzcngr88Wblw8riBQHtXeg3cf5XZXC2olCsaCV/HQTpaFEJTaajSOxwYccArKFfgi94yLUgEDCxpyLNUdhRqtUUZ/8NOXryxp+PAkt8tHPzp1FoqbrIdHtXfw2exfpfCB3t+UuCZO2oIW2RrBVfJKktBPOoazNqxVUjYFrPoEqSeL32UF4/l8oqUY6DmFpf8zTfia99nZezwiMvwdLCntKkOIcfn6qsKU4FzY2G66UqaqHzfEmbA/mHP2YvNK3s5pblgpFxl7n4++PTOCfOJr22rgSf002lRp+GOnAQKpZ5DF8U+IwEAs+01Ua2zRDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFRVKtWgTDl+1kzmeXm5JyWPa3gW7qSSlMGUE/z6MAI=;
 b=mRvKO7cxm/74fbzABjJLG53t22MGOhdEcf8Gu3+X0PL5FA3BLnPFWx9lmnxknOT57uq0u5x4NQ1mO/6bE/HWtRNsBcbV2OpVcB3MiUfnQUXZuHINWcezlDFYEpdfWLeJcTVDMdzAXaiTSMN5tDnBfsIs+GHsPnizwqyUpZIKbsa7M40a2LzkzHKTs/6yjnGfKFJQIVW8ZYp7eGi4+pUTyZVA/+ZQAVG3Jvd+vFjZdkrXhCBHi6x8EZQ2Kz1g+q7P7otUG/n6xBZ+wX8WETn0of5cEoltCpJNXT5mnkYJl/cOhjqVU0xiTzD2HnbJAywXpikQYZLBCj52c6gNVElEJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFRVKtWgTDl+1kzmeXm5JyWPa3gW7qSSlMGUE/z6MAI=;
 b=D/ZLOF5qSQNcdmBiGpD3ZQ7kcfdt391FfJnjqe+GWKYrGR0d+/ilUVpERUAZsBhIJIKgL+jdCetf9A6nJNHGV2LiZ3yqRF4C5ooPMEXc43WcukCyum3ouVdaGQajQ8UdOIgYO7UvIjueGNSNOaqgBsj9NooCgWFxTrKcXVd+DdI=
Received: from CH2PR16CA0016.namprd16.prod.outlook.com (2603:10b6:610:50::26)
 by LV8PR12MB9618.namprd12.prod.outlook.com (2603:10b6:408:2a0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 21:15:27 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::45) by CH2PR16CA0016.outlook.office365.com
 (2603:10b6:610:50::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 21:15:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:15:26 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:25 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:25 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:15:19 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Roman Li <Roman.Li@amd.com>
Subject: [PATCH 05/41] drm/amd/display: Enable DCN6 sources compilation
Date: Fri, 31 Jul 2026 17:12:26 -0400
Message-ID: <20260731211302.3040343-6-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|LV8PR12MB9618:EE_
X-MS-Office365-Filtering-Correlation-Id: 43fd504d-bf48-42ab-8539-08deef48d75d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1Xn2MGWBPBQwJR0tUBgRT2MyA/LB/UmI+TOUQnsjwMlWuvg0tqGjceWTn6uNkvypG7f6vD8lc6bIB6Kic8gJ8F5aZPDppYuy4zA6JzkvbwesUFhbgqljuZdRzHbr48PKnKRaL+67tJfFy7N3Sj+Yw7+hJtmOb0ViNAGMZPnpJozdioGNZj2Z/VClOi+lQd3bH4ZiSTibeHtw0g3OG9T0xuJ2fFtDF3A6EzHYpvqLcwTjuQYtDdiTe8FgKRA1u3foMp3yKY93XQ0nVVHtmWAOyyRoG/liyI+b0sBzq1Hql0ouDyWUbLjDDrwTKn412icalnEUBvhcNmuJAKJ2IyqT9ODH/69+BYFXv9Ax3GkzIwedmSbE9pgqI8g4q/2xcfofnLHFLmRE2I7oyhTJ6gvzZtLZ2d+iFS2wZ0DKkMAYT31EhSAdB20/rdz6sjSQkBMsMKYt/wU5j9oY96KHvnItIbiPFXlVdV9Nq8hv3j/WxPGMvDPAYtdhzBiBmPfsY9ocHxgHC192zIYrfO7BdAAa2ur7ptNm8/jBLWZOWID/bd/IPrvWLESviy3jPAGvNtIDmT61vg5srAMQ3lThF8HdC+wYfnVYYp+SQzkl0joA+7zmUnsYZuUJ9XVYDNDdjnk1YIN3gywEThfKJsU/Oat4wZppfxtBpGN3bLiUTnAx5dlgoI3Z2ObPMaIQbu4bpQijRuYJCCCrfxnyfniX/Mok6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XwoOsmZt2GbndlzvxpGIBPB0AiP+wB0JWJkHKFOC8TMJg68Np9HWzxxWxAON7SPxzmqsLUDK//NLKRppqyEc/pyCn+iB77n+MzCGGrPTHcbWA1T+fJm4bRq7hZhEvr9Am+vPUw6e9O8jMpnJ4WYOl6uOENzXLvJ/+35Qw2LofGk7jCXjs5vB3BYMcq06LkbL4Kv9XEFc3cL2dTSyloOjJnyO2bLvCe/tNz7WhvVsDqK07hgqdI3mUFdyDG2G/U3ORrGnK62EikaME1v0QDSIsI1Zt+JSlIMmoDqUkITzUjB8hgXisADbo3wmajtX0Db0X4OIPLaIYxkr6GowSHX6r1ewy1DlDrRgYw5tUbcZD0muOpD1ya2Dz+cHQmCsiEazoZ4kunS2XdXpnS73g8XjDjMcH7aEckUPNv+BWKSa2zC/eSDef1DxsmtYy9rQgDlV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:15:26.2553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43fd504d-bf48-42ab-8539-08deef48d75d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9618
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

Update the Makefiles so that DCN6 related newly added sources are compiled

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Reviewed-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |  9 +++++++
 drivers/gpu/drm/amd/display/dc/dccg/Makefile  |  8 ++++++
 drivers/gpu/drm/amd/display/dc/dio/Makefile   |  8 ++++++
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    | 25 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dpp/Makefile   | 17 +++++++++++++
 drivers/gpu/drm/amd/display/dc/dsc/Makefile   |  7 ++++++
 drivers/gpu/drm/amd/display/dc/gpio/Makefile  | 10 ++++++++
 drivers/gpu/drm/amd/display/dc/hpo/Makefile   |  8 ++++++
 .../gpu/drm/amd/display/dc/hubbub/Makefile    |  8 ++++++
 drivers/gpu/drm/amd/display/dc/hubp/Makefile  | 16 ++++++++++++
 drivers/gpu/drm/amd/display/dc/hwss/Makefile  | 16 ++++++++++++
 drivers/gpu/drm/amd/display/dc/irq/Makefile   |  9 +++++++
 drivers/gpu/drm/amd/display/dc/mpc/Makefile   |  8 ++++++
 drivers/gpu/drm/amd/display/dc/opp/Makefile   |  8 ++++++
 drivers/gpu/drm/amd/display/dc/optc/Makefile  |  9 +++++++
 .../gpu/drm/amd/display/dc/resource/Makefile  | 10 ++++++++
 .../display/dc/soc_and_ip_translator/Makefile |  3 +++
 drivers/gpu/drm/amd/display/dmub/src/Makefile |  1 +
 18 files changed, 180 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
index fb234a729bdc..8cfd7bf57fbe 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
@@ -195,4 +195,13 @@ AMD_DAL_CLK_MGR_DCN42B = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn42b/,$(CLK_MGR_
 
 AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCN42B)
 
+
+###############################################################################
+# DCN60
+###############################################################################
+CLK_MGR_DCN60 = dcn60_clk_mgr.o dcn60_clk_mgr_smu_msg.o
+
+AMD_DAL_CLK_MGR_DCN60 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn60/,$(CLK_MGR_DCN60))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCN60)
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/Makefile b/drivers/gpu/drm/amd/display/dc/dccg/Makefile
index bf7e71166b5e..5a1ce0e7cd70 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dccg/Makefile
@@ -109,4 +109,12 @@ DCCG_DCN42 = dcn42_dccg.o
 AMD_DAL_DCCG_DCN42 = $(addprefix $(AMDDALPATH)/dc/dccg/dcn42/,$(DCCG_DCN42))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DCCG_DCN42)
+###############################################################################
+# DCN60
+###############################################################################
+DCCG_DCN60 = dcn60_dccg.o
+
+AMD_DAL_DCCG_DCN60 = $(addprefix $(AMDDALPATH)/dc/dccg/dcn60/,$(DCCG_DCN60))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DCCG_DCN60)
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/dio/Makefile b/drivers/gpu/drm/amd/display/dc/dio/Makefile
index 4832533b9514..d6e715c37989 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dio/Makefile
@@ -132,4 +132,12 @@ DIO_DCN42 = dcn42_dio_link_encoder.o dcn42_dio_stream_encoder.o
 AMD_DAL_DIO_DCN42 = $(addprefix $(AMDDALPATH)/dc/dio/dcn42/,$(DIO_DCN42))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DIO_DCN42)
+###############################################################################
+# DCN60
+###############################################################################
+DIO_DCN60 = dcn60_dio_link_encoder.o dcn60_dio_stream_encoder.o
+
+AMD_DAL_DIO_DCN60 = $(addprefix $(AMDDALPATH)/dc/dio/dcn60/,$(DIO_DCN60))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DIO_DCN60)
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
index e9ce7813b0f5..35d697872a9a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
@@ -52,6 +52,9 @@ subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dml2_0/dml21/src/dml2_standalo
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dml2_0/dml21/src/inc
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dml2_0/dml21/inc
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dml2_0/dml21/
+subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dml2_0/dml21/inc/bounding_boxes/
+subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dml2_0/dml21/src/dml2_utm_soc_bb/
+subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dml2_0/dml21/src/dml2_cga/
 
 # Add FPU flags to all dml2 files by default, remove NO_FPU flags.
 # FPU flags step 1: Find all .c files in dal/dc/dml2_0 and it's subfolders
@@ -107,6 +110,28 @@ DML21 += src/dml2_pmo/dml2_pmo_dcn4_fams2.o
 DML21 += src/dml2_pmo/dml2_pmo_dcn42.o
 DML21 += src/dml2_standalone_libraries/lib_float_math.o
 DML21 += src/dml2_standalone_libraries/lib_frl_cap_check.o
+DML21 += src/dml2_top/dml2_top_utm.o
+DML21 += src/dml2_core/dml2_core_dcn5_calcs_dchub.o
+DML21 += src/dml2_core/dml2_core_dcn5_calcs_display_pipe.o
+DML21 += src/dml2_core/dml2_core_dcn5_calcs_dsc_latency.o
+DML21 += src/dml2_core/dml2_core_dcn5_funcs_initialize.o
+DML21 += src/dml2_core/dml2_core_dcn5_funcs_mode_programming.o
+DML21 += src/dml2_core/dml2_core_dcn5_funcs_mode_support.o
+DML21 += src/dml2_dpmm/dml2_dpmm_dcn5.o
+DML21 += src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn5.o
+DML21 += src/dml2_utm_soc_bb/dml2_utm_soc_bb_factory.o
+DML21 += src/dml2_cga/dml2_cga_dcn6.o
+DML21 += src/dml2_cga/dml2_cga_factory.o
+DML21 += src/dml2_core/dml2_core_dcn6_calcs_dchub.o
+DML21 += src/dml2_core/dml2_core_dcn6_funcs_initialize.o
+DML21 += src/dml2_core/dml2_core_dcn6_funcs_mode_programming.o
+DML21 += src/dml2_core/dml2_core_dcn6_funcs_mode_support.o
+DML21 += src/dml2_pmo/dml2_pmo_dcn5.o
+DML21 += src/dml2_pmo/dml2_pmo_dcn5_stage_optimizers.o
+DML21 += src/dml2_pmo/dml2_pmo_dcn6.o
+DML21 += src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.o
+DML21 += src/dml2_standalone_libraries/alternate_pstate_shared_lib.o
+DML21 += src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.o
 DML21 += dml21_translation_helper.o
 DML21 += dml21_wrapper.o
 DML21 += dml21_wrapper_fpu.o
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/Makefile b/drivers/gpu/drm/amd/display/dc/dpp/Makefile
index 2595b2504f9d..f5da45aacfca 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dpp/Makefile
@@ -88,4 +88,21 @@ DPP_DCN42 = dcn42_dpp.o
 AMD_DAL_DPP_DCN42 = $(addprefix $(AMDDALPATH)/dc/dpp/dcn42/,$(DPP_DCN42))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DPP_DCN42)
+
+###############################################################################
+
+DPP_DCN50 = dcn50_dpp.o
+
+AMD_DAL_DPP_DCN50 = $(addprefix $(AMDDALPATH)/dc/dpp/dcn50/,$(DPP_DCN50))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DPP_DCN50)
+
+###############################################################################
+
+DPP_DCN60 = dcn60_dpp.o dcn60_dpp_dscl.o
+
+AMD_DAL_DPP_DCN60 = $(addprefix $(AMDDALPATH)/dc/dpp/dcn60/,$(DPP_DCN60))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DPP_DCN60)
+
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/Makefile b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
index 94883c4e4c61..47dbc6140808 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
@@ -29,6 +29,13 @@ DSC_DCN401 += dcn401_dsc.o
 
 AMD_DISPLAY_FILES += $(addprefix $(AMDDALPATH)/dc/dsc/dcn401/,$(DSC_DCN401))
 
+###############################################################################
+# DCN60
+###############################################################################
+
+DSC_DCN60 += dcn60_dsc.o
+
+AMD_DISPLAY_FILES += $(addprefix $(AMDDALPATH)/dc/dsc/dcn60/,$(DSC_DCN60))
 endif
 
 DSC = dc_dsc.o rc_calc.o rc_calc_dpi.o
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/Makefile b/drivers/gpu/drm/amd/display/dc/gpio/Makefile
index 3a860b016b7a..3deb34cd260f 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/gpio/Makefile
@@ -151,3 +151,13 @@ GPIO_DCN42B = hw_translate_dcn42b.o hw_factory_dcn42b.o
 AMD_DAL_GPIO_DCN42B = $(addprefix $(AMDDALPATH)/dc/gpio/dcn42b/,$(GPIO_DCN42B))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_GPIO_DCN42B)
+
+###############################################################################
+# DCN 6.0
+###############################################################################
+
+GPIO_DCN60 = hw_translate_dcn60.o hw_factory_dcn60.o
+
+AMD_DAL_GPIO_DCN60 = $(addprefix $(AMDDALPATH)/dc/gpio/dcn60/,$(GPIO_DCN60))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_GPIO_DCN60)
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/Makefile b/drivers/gpu/drm/amd/display/dc/hpo/Makefile
index db60564b9cfd..b5df5c569806 100644
--- a/drivers/gpu/drm/amd/display/dc/hpo/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/hpo/Makefile
@@ -66,4 +66,12 @@ HPO_DCN42 += dcn42_hpo_frl_stream_encoder.o
 AMD_DAL_HPO_DCN42 = $(addprefix $(AMDDALPATH)/dc/hpo/dcn42/,$(HPO_DCN42))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_HPO_DCN42)
+###############################################################################
+# DCN60
+###############################################################################
+HPO_DCN60 = dcn60_hpo_frl_stream_encoder.o dcn60_hpo_frl_link_encoder.o
+
+AMD_DAL_HPO_DCN60 = $(addprefix $(AMDDALPATH)/dc/hpo/dcn60/,$(HPO_DCN60))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HPO_DCN60)
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/Makefile b/drivers/gpu/drm/amd/display/dc/hubbub/Makefile
index 29c8e2651442..e20f6067977e 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/Makefile
@@ -109,4 +109,12 @@ AMD_DAL_HUBBUB_DCN42 = $(addprefix $(AMDDALPATH)/dc/hubbub/dcn42/,$(HUBBUB_DCN42
 
 AMD_DISPLAY_FILES += $(AMD_DAL_HUBBUB_DCN42)
 
+###############################################################################
+HUBBUB_DCN60 = dcn60_hubbub.o
+
+AMD_DAL_HUBBUB_DCN60 = $(addprefix $(AMDDALPATH)/dc/hubbub/dcn60/,$(HUBBUB_DCN60))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HUBBUB_DCN60)
+
+
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/Makefile b/drivers/gpu/drm/amd/display/dc/hubp/Makefile
index e0799bb873e6..6bfd302ba9c2 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/hubp/Makefile
@@ -96,10 +96,26 @@ AMD_DISPLAY_FILES += $(AMD_DAL_HUBP_DCN401)
 
 ###############################################################################
 
+HUBP_DCN50 = dcn50_hubp.o
+
+AMD_DAL_HUBP_DCN50 = $(addprefix $(AMDDALPATH)/dc/hubp/dcn50/,$(HUBP_DCN50))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HUBP_DCN50)
+
+###############################################################################
+
 HUBP_DCN42 = dcn42_hubp.o
 
 AMD_DAL_HUBP_DCN42 = $(addprefix $(AMDDALPATH)/dc/hubp/dcn42/,$(HUBP_DCN42))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_HUBP_DCN42)
 
+###############################################################################
+
+HUBP_DCN60 = dcn60_hubp.o
+
+AMD_DAL_HUBP_DCN60 = $(addprefix $(AMDDALPATH)/dc/hubp/dcn60/,$(HUBP_DCN60))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HUBP_DCN60)
+
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/Makefile b/drivers/gpu/drm/amd/display/dc/hwss/Makefile
index df3101ce1784..9769ec9a32df 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/hwss/Makefile
@@ -201,6 +201,14 @@ AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN401)
 
 ###############################################################################
 
+HWSS_DCN50 = dcn50_hwseq.o
+
+AMD_DAL_HWSS_DCN50 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn50/,$(HWSS_DCN50))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN50)
+
+###############################################################################
+
 HWSS_DCN42 = dcn42_hwseq.o dcn42_init.o
 
 AMD_DAL_HWSS_DCN42 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn42/,$(HWSS_DCN42))
@@ -215,4 +223,12 @@ AMD_DAL_HWSS_DCN42B = $(addprefix $(AMDDALPATH)/dc/hwss/dcn42b/,$(HWSS_DCN42B))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN42B)
 
+###############################################################################
+
+HWSS_DCN60 = dcn60_hwseq.o dcn60_init.o
+
+AMD_DAL_HWSS_DCN60 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn60/,$(HWSS_DCN60))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN60)
+
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/irq/Makefile b/drivers/gpu/drm/amd/display/dc/irq/Makefile
index 807b73c2a758..bbec53719c5d 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/irq/Makefile
@@ -207,3 +207,12 @@ IRQ_DCN42 = irq_service_dcn42.o
 AMD_DAL_IRQ_DCN42= $(addprefix $(AMDDALPATH)/dc/irq/dcn42/,$(IRQ_DCN42))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_IRQ_DCN42)
+
+###############################################################################
+# DCN 60
+###############################################################################
+IRQ_DCN60 = irq_service_dcn60.o
+
+AMD_DAL_IRQ_DCN60 = $(addprefix $(AMDDALPATH)/dc/irq/dcn60/,$(IRQ_DCN60))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_IRQ_DCN60)
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/Makefile b/drivers/gpu/drm/amd/display/dc/mpc/Makefile
index cc23aae3728a..65926e7c6611 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/mpc/Makefile
@@ -77,4 +77,12 @@ MPC_DCN42 = dcn42_mpc.o
 AMD_DAL_MPC_DCN42 = $(addprefix $(AMDDALPATH)/dc/mpc/dcn42/,$(MPC_DCN42))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_MPC_DCN42)
+###############################################################################
+# DCN60
+###############################################################################
+MPC_DCN60 = dcn60_mpc.o
+
+AMD_DAL_MPC_DCN60 = $(addprefix $(AMDDALPATH)/dc/mpc/dcn60/,$(MPC_DCN60))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_MPC_DCN60)
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/opp/Makefile b/drivers/gpu/drm/amd/display/dc/opp/Makefile
index 1be76754db30..7ac7cae268c8 100644
--- a/drivers/gpu/drm/amd/display/dc/opp/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/opp/Makefile
@@ -48,4 +48,12 @@ OPP_DCN35 = dcn35_opp.o
 AMD_DAL_OPP_DCN35 = $(addprefix $(AMDDALPATH)/dc/opp/dcn35/,$(OPP_DCN35))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_OPP_DCN35)
+###############################################################################
+# DCN60
+###############################################################################
+OPP_DCN60 = dcn60_opp.o
+
+AMD_DAL_OPP_DCN60 = $(addprefix $(AMDDALPATH)/dc/opp/dcn60/,$(OPP_DCN60))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_OPP_DCN60)
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/optc/Makefile b/drivers/gpu/drm/amd/display/dc/optc/Makefile
index 06c98d70eabc..4861ae265cf1 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/optc/Makefile
@@ -118,5 +118,14 @@ AMD_DAL_OPTC_DCN42 = $(addprefix $(AMDDALPATH)/dc/optc/dcn42/,$(OPTC_DCN42))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_OPTC_DCN42)
 
+###############################################################################
+
+OPTC_DCN60 = dcn60_optc.o
+
+AMD_DAL_OPTC_DCN60 = $(addprefix $(AMDDALPATH)/dc/optc/dcn60/,$(OPTC_DCN60))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_OPTC_DCN60)
+
+###############################################################################
 endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/Makefile b/drivers/gpu/drm/amd/display/dc/resource/Makefile
index fe02ed39a3e9..b29986266888 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/resource/Makefile
@@ -246,5 +246,15 @@ RESOURCE_DCN42B = dcn42b_resource.o
 AMD_DAL_RESOURCE_DCN42B = $(addprefix $(AMDDALPATH)/dc/resource/dcn42b/,$(RESOURCE_DCN42B))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCN42B)
+
+
+###############################################################################
+
+RESOURCE_DCN60 = dcn60_resource.o
+
+AMD_DAL_RESOURCE_DCN60 = $(addprefix $(AMDDALPATH)/dc/resource/dcn60/,$(RESOURCE_DCN60))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCN60)
+###############################################################################
 endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/Makefile b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/Makefile
index 8a9bb0aef9b7..41de93f2659f 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/Makefile
@@ -10,15 +10,18 @@ soc_and_ip_translator_rcflags := $(CC_FLAGS_NO_FPU)
 CFLAGS_$(AMDDALPATH)/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.o := $(soc_and_ip_translator_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.o := $(soc_and_ip_translator_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/soc_and_ip_translator/dcn42b/dcn42b_soc_and_ip_translator.o := $(soc_and_ip_translator_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/soc_and_ip_translator/dcn60/dcn60_soc_and_ip_translator.o := $(soc_and_ip_translator_ccflags)
 
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.o := $(soc_and_ip_translator_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.o := $(soc_and_ip_translator_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/soc_and_ip_translator/dcn42b/dcn42b_soc_and_ip_translator.o := $(soc_and_ip_translator_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/soc_and_ip_translator/dcn60/dcn60_soc_and_ip_translator.o := $(soc_and_ip_translator_rcflags)
 
 soc_and_ip_translator := soc_and_ip_translator.o
 soc_and_ip_translator += dcn401/dcn401_soc_and_ip_translator.o
 soc_and_ip_translator += dcn42/dcn42_soc_and_ip_translator.o
 soc_and_ip_translator += dcn42b/dcn42b_soc_and_ip_translator.o
+soc_and_ip_translator += dcn60/dcn60_soc_and_ip_translator.o
 
 AMD_DAL_soc_and_ip_translator := $(addprefix $(AMDDALPATH)/dc/soc_and_ip_translator/, $(soc_and_ip_translator))
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/Makefile b/drivers/gpu/drm/amd/display/dmub/src/Makefile
index b6f7477ada22..2c5ec1fc0c5f 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/Makefile
+++ b/drivers/gpu/drm/amd/display/dmub/src/Makefile
@@ -30,6 +30,7 @@ DMUB += dmub_dcn36.o
 DMUB += dmub_dcn401.o
 DMUB += dmub_dcn42.o
 DMUB += dmub_dcn42b.o
+DMUB += dmub_dcn60.o
 
 AMD_DAL_DMUB = $(addprefix $(AMDDALPATH)/dmub/src/,$(DMUB))
 
-- 
2.34.1

