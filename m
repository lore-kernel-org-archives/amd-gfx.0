Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFC9C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC54F10EE3B;
	Wed, 26 Aug 2026 23:20:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qfcqdYMc";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4B4610EE3B
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:20:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCwmXjgehARIkQHO3xrVGMDX0PlxusCRQKV9XdDloWEXAyBfZSJCmgP+k3C0PopRoLLBxIGmFVZ9WKB9LWJaWg3DzbBsqgkAudule4caBy+ugmoQIDTamWPKgDJ2RSpVPgijtMsDvr+vMl/5rJrnLtIIM2A2Y+I9Ozf0OFl/XryXHJ1dUoyHMJ3T8OfMPU8FvbO+F/I6qYH64WTapskdyZ09TMswO/IvxsnvZfzfE4omBGyXxFizQv+JNifSguU2uiS5LumWCeGzJpnNlF9K3F4jK8kKCna457nlZePNDsDMVp566m0R4ILu5ksRyrbLUXudm6rfQwy1nJS6AWlnOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECQ0g4h2oFGrjj+rQ83K97GL/tTh+zM6KptZ0xNKfSc=;
 b=Ms6vtsyfRVE8FJ+uyMZZzWGLv00d449MmxGW2zp7FYB+hSpEpo3oW4H9QWPH57ZIZSOrIRJ6/miOro9+XI4tFidh4RDbYAUonx7K9dxtT6tGqCmZ33EL95fN2G6uK/mWGbv11awSUdt1jSVR2q/A32RhvsOvAKW3OqIgSXkfH8hCAx7vVpLKamrMBqGKL0ue8/vSJU7AFoO14fcFeIysQWCI62w/84wLwMTw8rUXL67RPpPd8pVb4Kd2x+P9SBd8IixeV29Vx32vldrMqu266np2EOUA4KFBdD4VlEPZnrKlcAWPWkj3IJ3RgeezRcndeu2wxIieVdoMS+c+S0BE/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECQ0g4h2oFGrjj+rQ83K97GL/tTh+zM6KptZ0xNKfSc=;
 b=qfcqdYMcaEslX9abTxusPx0QLOzyeOTwaYYj/XDZxlLdTWDmSOrMnnl8QoyeLY9DUUBZmCLJCn1C6gVHeSOjZypTqVR/uc/KCEie/h55wrofrWsmATNJ1Y+utA/NFQvlLhVmGS6TkqfN0zR79SR8JCKnr3q+R3R2ZtQYI2SHXJ8=
Received: from PH8P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::6)
 by DS0PR12MB999080.namprd12.prod.outlook.com (2603:10b6:8:2fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Wed, 26 Aug
 2026 23:20:20 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:2db:cafe::40) by PH8P223CA0009.outlook.office365.com
 (2603:10b6:510:2db::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 23:20:20 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:20:19 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:20:15 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 13/59] drm/amd/display: Preparations To Move DML Wrapper Out
 Of DML
Date: Wed, 26 Aug 2026 17:04:44 -0600
Message-ID: <20260826231519.881949-14-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|DS0PR12MB999080:EE_
X-MS-Office365-Filtering-Correlation-Id: 452201a9-d5c4-4894-fa21-08df03c89885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: T8JBrb1KGoeg2XHBY/RTfXOYTEsKFJERfWGk/Qb6HLdffLR1fY5ixllsti0ZsJ7V4PaCPaIPV39NmEiBAg9IZdJFByFlqmcYLFy7fkV4gBgnDIStg3u3ZTlsrhEBIoBRffiL66Ze454QDR0o87njpzF/MNh1eXn2yOCbYIM87sC0PmcV+oD2F8XQLDsq3buKFqkpmxXKZCNMo1vwaqxMVveQaLTP/9MPz0b169o7sk460MEKGcn3+kQZh35F5pL4Th1CPVaMoGH/pc/3kghdewH6HMI4u4IzpHDvagVcq37ylJ38rLgzgrkxrUDrP7oJZlWSpxcv3dZ6Ns6xJR27K50R3INQBbw8tOvM2od2ed684r5CiDUfxIAD0g3MJ9WgtDfYdhs51QhdcaSSmU0sUmdtreikpJpz+4aUsrgQ4N2qWUxDSTj3zcfl3MogYy+uMZMl86O4TNk7CwtNto6Ue3l5mkeobHv8LFfbLqisKe9RUYB5JYH5pZBZwIeZHfrEc/fZqmM8hknrj9PJqtJPG7M1020yDsIh3uW5NOpn47stbzpOwaIbR2cf4aXWmQwQ0oB5hUTgla869XoAIoxpksGQpM/v3rjt09jB6dzQxCUU0k5RWplUHaUJXLnuHPVEY9rYTEUi6UwSgyNhj7LvH2WJbYVi+ucppwcbL8lw4bsK7lkwk9wC4QmyLN+WQijQXlVYpxB5R58Ky4ZMrTi+sA==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nLHkCFR31M2mJ7BDH9nh2JqC7faLP6XGEiEBG2TdfSWWnu5RSuMnbD3afhvbyMCcbdbDke+2UZuNdsodtNRtxeC37ZfbeReRCIpmlhUke4KS9ynfIlD9zBilRz99yB3jykf3BB+4XMFnIHomlEzEhKyEPzDWd+6tbUxcfItc8QHCWSj+tKK7v1pXOm+IYRgabbtj7rs1qg4vYg40fdWSN3WNCEJ1U7K79u3H3grIuyUA8CICGvytrCvx3zAPkbWQ6/ZfMedJAftOFmlcUTnz0WJiNX80Yz1dUZ6SWLK01C/kEulpEM0mPzAB4o9v/o3wQwgfGYjy56eJHVH0BU+FSrz1fvarlkUi8XMvSfWm15OwnPrygLPoR3Ovy5QQv1NP5pK1Ai2yivduGx8orWKPWVc9K2qHE58CIZajmpi5SCrz2UGPPN4266teabs1UBCL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:20:19.6316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 452201a9-d5c4-4894-fa21-08df03c89885
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999080
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

From: Austin Zheng <Austin.Zheng@amd.com>

[WHY/HOW]
DML wrapper has dependencies on both DC and DML.
Therefore it should be in its own component instead of under the
DML2 folder.

A series of changes are required to move the files without breaking
compilation

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    | 23 +++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
index b3e23dbf2ebf..f3427e83126e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
@@ -80,8 +80,15 @@ CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_pro
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_support.o := $(dml2_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.o := $(dml2_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.o := $(dml2_ccflags) $(frame_warn_flag)
+
+#Wrapper files are being moved to their own component. Use a flag to transition once files are moved.
+ifndef DML2_WRAPPER_STANDALONE
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml2_wrapper.o := $(dml2_rcflags)
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/dml21_wrapper.o := $(dml2_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml2_wrapper.o := $(dml2_ccflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/dml21_wrapper.o := $(dml2_ccflags)
+endif
+
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/display_mode_core.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.o := $(dml2_rcflags)
@@ -89,14 +96,18 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_m
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_support.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.o := $(dml2_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml2_wrapper.o := $(dml2_ccflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/dml21_wrapper.o := $(dml2_ccflags)
 
-DML2 = display_mode_core.o display_mode_util.o dml2_wrapper_fpu.o dml2_wrapper.o \
-		dml2_utils.o dml2_policy.o dml2_translation_helper.o dml2_dc_resource_mgmt.o dml2_mall_phantom.o \
+# DML2 library core files
+DML2 = display_mode_core.o display_mode_util.o \
 		dml_display_rq_dlg_calc.o
 DML2 += dml_frl_cap_chk.o
 
+#Wrapper files are being moved to their own component. Use a flag to transition once files are moved.
+ifndef DML2_WRAPPER_STANDALONE
+DML2 += dml2_wrapper_fpu.o dml2_wrapper.o \
+		dml2_utils.o dml2_policy.o dml2_translation_helper.o dml2_dc_resource_mgmt.o dml2_mall_phantom.o
+endif
+
 AMD_DAL_DML2 = $(addprefix $(AMDDALPATH)/dc/dml2_0/,$(DML2))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DML2)
@@ -141,10 +152,14 @@ DML21 += src/dml2_pmo/dml2_pmo_dcn6.o
 DML21 += src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.o
 DML21 += src/dml2_standalone_libraries/alternate_pstate_shared_lib.o
 DML21 += src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.o
+
+#Wrapper files are being moved to their own component. Use a flag to transition once files are moved.
+ifndef DML2_WRAPPER_STANDALONE
 DML21 += dml21_translation_helper.o
 DML21 += dml21_wrapper.o
 DML21 += dml21_wrapper_fpu.o
 DML21 += dml21_utils.o
+endif
 
 AMD_DAL_DML21 = $(addprefix $(AMDDALPATH)/dc/dml2_0/dml21/,$(DML21))
 
-- 
2.43.0

