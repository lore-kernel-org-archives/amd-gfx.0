Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E917FEA817
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 07:10:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C81D710E7AF;
	Wed, 25 Mar 2026 07:10:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L9m+HOn7";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010006.outbound.protection.outlook.com [52.101.201.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EA0D10E7AF
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 07:10:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMycVvnrPF2B2vy3tWeNaisGCcF853DbO5B1pTHIULycppPDtOxRxjVRNIlkPzXRCqoetUgISzM9g/EQ5HVqdWr/e5HvXKVEVy8L1cJWUzdqrnMD4U5IASInqpafhIq2Hs7eeIyYOGVDbYpaODiwQvJ+cXEYTFb612Or0dWlnNyYalqX2DhOQ9qPxAxJnb67c/SJarmTUh6WK5ab0nxbBhCBZfwc6/viGc0V8Okar46dehIxVoRLpM/6l63huLeFrNENO6Zon53G/Orkjqxu04dVEijD2Vruz80f1IbpumGE0Z4wB+0zcb+NY4qL4NhQEAQTxU2hHBaNGszhOll6uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hpFkCYckAqIoYWbg0MfmvVGtVqGMyMlsWppqMxFhuc=;
 b=GMqHYrtm80hO/ndLTXOG+PuUcykOtBD23hfIBcpBSDthidqEeQI5bDvT8CdtVQOBi+KBO2j0vX6kEVfRksRGMF9t/B82ESf0PhjJJReoDi4vMadCduoOqR12VKMtFVMrYe5aFtMA0zRz9DQBxqcvd4qOc2iGBbqeewTyTD17Y2qXMJAV4XMVbpADob1QSW5M60M/8+FTpzqo6rM9fR2fC1thsPEX1EoBJn1NHupsfn7WzJsWk3Yqa/3Y2hIKz7AP0Z18slXuunLj5eyf9UzXZQ+Jx0suhO3cbdQHuQWMbZm5PUTDcLdghL5lHKSqjo0DD9reNfFwVRYISd0MJwQg5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hpFkCYckAqIoYWbg0MfmvVGtVqGMyMlsWppqMxFhuc=;
 b=L9m+HOn7gzONBPXHEyljL9dqSZqNV+uUImStDjM+TFtTEUv5PkhkrfUjp06uchnvdxFY1HYudHwPoD4EfuR74pOWv9e2owxA6pyJoaxLQAs+Bf52GhkjZcgDRTPmqo7tIQncEQ8Vwl/IH3Q+obDV+g6UzuW8l4LD+2TtU/9XC6E=
Received: from BLAPR03CA0055.namprd03.prod.outlook.com (2603:10b6:208:32d::30)
 by PH7PR12MB7019.namprd12.prod.outlook.com (2603:10b6:510:1b9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 07:10:15 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::fe) by BLAPR03CA0055.outlook.office365.com
 (2603:10b6:208:32d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 07:10:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 07:10:15 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 02:10:04 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Rafal Ostrowski <rafal.ostrowski@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>
Subject: [PATCH 23/29] drm/amd/display: Move FPU Guards From DML To DC - Part 2
Date: Wed, 25 Mar 2026 15:06:29 +0800
Message-ID: <20260325071003.4022594-24-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
References: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|PH7PR12MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: caeb600c-63f0-4620-ea5e-08de8a3d904e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003|20052099010;
X-Microsoft-Antispam-Message-Info: AYfUAh5Pz0ZCP+NY/fVPB1LaH/SqdNyKo/egjdmKpO94xMR/OjnLmvw6cW9iDEftzxWBU/2htFgaZ8MzKlwwA4LpNP0AKVDu61vLOjIh+EpV7HCgIApMz32rkO4Dlnl5WhzZG/nemg7RJNnBPCiRMj+eqYpDM4sa5eCXZsBZN/lZX+KnbyELmUVCtILThteKtNs7lVttq+UOppqY9oYYe32HHoVtU95d/H1k+3Ibs35T6f1NebAqhcR9n/XqX9lF2xs63A2JqelcV+8rVN4yEkVRAk2ncRqtOMlQ0gPMRCngBKghKUH2tVppdMrFR/NlSpPbP6L0n0OTQuUSwmHF33/bp+wlWslkat1i9xEEDCjWvuJZA4+frM9pczioaO7zknYnLqERFJhUcaVPlWV1849+jWxvSp1Lcf+qNh4p+780pMC5gjF4qEbLOI5NRxiDjxDQaU4tuNXZ3YPeK77+qgPADz3eviv4V1tspHD4TU6FQKwLOalF/ZtUkgpQwPXGw5Jv+N8M2K9w+ohfYKX704LEeG+LgDXFkQtIt4gH2tOSlyProogukU81rL9ti7j5k9LU9fqoivsWaAVv8NRyCXgYubQ4o/k2OXqO1Hv3Fa/sKUK+UDBtYJJ3qBhADQWCM4ypNWo+zvr40GU7vVid8QTDEdpsaW6u+TVOS3WbC/lUfm50zZNZ5I9Dm2x5IJTbKhR5zF3l3W45LT+NVcIo47GPeCOmC6ynRUIu/b2GIOqCI6xWYSlaj7pwT0LZ9ZOtMs0sMUAzkaIVKBMbUrp8FQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003)(20052099010);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1Hg+zkbWCbGOSeXgXTQH4RVJKqtCCDogrzoI1Py7NN+VmRL9ue7w+cYK/r4sjZjkoDqXqBGwJOZ7v/Ipglff6vokLUFooIIEQGomoNndplA1cC7eiQAlOc/CgefxPGo6FjoFzY5ngaqZAcnrSyVNcEUwFch6/Z6cFgvo/sA2GP/w5B/cl2eue6DjjA3au2V49G7819cbCzpCBsobIuTbxR8rVA0uYUuaCNh4TO2gVao2Y2PEHt6kpudki9lnprZOGs0FsVp1TUi+4IHr4ZAntfSyPyUZed89jeds7NCdFN7Vdptp/zdDxt0dafeHbWOIWTVn0UpL6dmE3N6Q63pevCTBmeyAlZwa5Evye2y0NbhNOjNMrK7qMumTcnR5J6gQlIbRsoyDC3exQpmsk3VFW45Uxz57Pls5PCBqjNWfQAN4uK60yGhfLYzJbRT2cUyX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:10:15.1462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caeb600c-63f0-4620-ea5e-08de8a3d904e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7019
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

From: Rafal Ostrowski <rafal.ostrowski@amd.com>

[Why]
FPU guards (DC_FP_START/DC_FP_END) are required to wrap around code that
can manipulates floats. To do this properly, the FPU guards must be used
in a file that is not compiled as a FPU unit. If the guards are used in
a file that is a FPU unit, other sections in the file that aren't guarded
may be end up being compiled to use FPU operations.

[How]
Removed DC_FP_START and DC_FP_END.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chuanyu Tseng <Chuanyu.Tseng@amd.com>
---
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    |  75 +---
 .../display/dc/dml2_0/dml21/dml21_wrapper.c   | 379 +----------------
 .../display/dc/dml2_0/dml21/dml21_wrapper.h   |  30 --
 .../dc/dml2_0/dml21/dml21_wrapper_fpu.c       | 381 ++++++++++++++++++
 .../dc/dml2_0/dml21/dml21_wrapper_fpu.h       |  60 +++
 .../drm/amd/display/dc/dml2_0/dml2_wrapper.c  |  21 +-
 .../amd/display/dc/dml2_0/dml2_wrapper_fpu.c  |   9 +-
 7 files changed, 484 insertions(+), 471 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.h

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
index 70d9f2cd0b60..5cb3035b814c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
@@ -53,25 +53,29 @@ subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dml2_0/dml21/src/inc
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dml2_0/dml21/inc
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dml2_0/dml21/
 
-CFLAGS_$(AMDDALPATH)/dc/dml2_0/display_mode_core.o := $(dml2_ccflags) $(frame_warn_flag)
-CFLAGS_$(AMDDALPATH)/dc/dml2_0/display_mode_util.o := $(dml2_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml2_wrapper_fpu.o := $(dml2_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml2_utils.o := $(dml2_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml2_policy.o := $(dml2_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml2_translation_helper.o := $(dml2_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml2_mall_phantom.o := $(dml2_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml_display_rq_dlg_calc.o := $(dml2_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml2_dc_resource_mgmt.o := $(dml2_ccflags)
+# Add FPU flags to all dml2 files by default, remove NO_FPU flags.
+# FPU flags step 1: Find all .c files in dal/dc/dml2_0 and it's subfolders
+DML2_ABS_PATH := $(FULL_AMD_DISPLAY_PATH)/dc/dml2_0
+DML2_C_FILES := $(shell find $(DML2_ABS_PATH) -name '*.c' -type f)
+
+# FPU flags step 2: Convert to .o and make paths relative to $(AMDDALPATH)/dc/dml2_0/
+DML2_RELATIVE_O_FILES := $(patsubst $(DML2_ABS_PATH)/%,dc/dml2_0/%,$(patsubst %.c,%.o,$(DML2_C_FILES)))
 
+# FPU flags step 3: Apply FPU flags to all .o files from dal/dc/dml2_0 and it's subfolders
+$(foreach obj,$(DML2_RELATIVE_O_FILES),$(eval CFLAGS_$(AMDDALPATH)/$(obj) := $(dml2_ccflags)))
+$(foreach obj,$(DML2_RELATIVE_O_FILES),$(eval CFLAGS_REMOVE_$(AMDDALPATH)/$(obj) := $(dml2_rcflags)))
+
+# FPU flags step 4: Replace CFLAGS per file for files with additional flags beyond dml2_ccflags and dml2_rcflags
+CFLAGS_$(AMDDALPATH)/dc/dml2_0/display_mode_core.o := $(dml2_ccflags) $(frame_warn_flag)
+CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.o := $(dml2_ccflags) $(frame_warn_flag)
+CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.o := $(dml2_ccflags) $(frame_warn_flag)
+CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml2_wrapper.o := $(dml2_rcflags)
+CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/dml21_wrapper.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/display_mode_core.o := $(dml2_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/display_mode_util.o := $(dml2_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml2_wrapper_fpu.o := $(dml2_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml2_utils.o := $(dml2_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml2_policy.o := $(dml2_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml2_translation_helper.o := $(dml2_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml2_mall_phantom.o := $(dml2_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml_display_rq_dlg_calc.o := $(dml2_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml2_dc_resource_mgmt.o := $(dml2_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.o := $(dml2_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.o := $(dml2_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml2_wrapper.o := $(dml2_ccflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/dml21_wrapper.o := $(dml2_ccflags)
 
 DML2 = display_mode_core.o display_mode_util.o dml2_wrapper_fpu.o dml2_wrapper.o \
 		dml2_utils.o dml2_policy.o dml2_translation_helper.o dml2_dc_resource_mgmt.o dml2_mall_phantom.o \
@@ -81,42 +85,6 @@ AMD_DAL_DML2 = $(addprefix $(AMDDALPATH)/dc/dml2_0/,$(DML2))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DML2)
 
-CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.o := $(dml2_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.o := $(dml2_ccflags) $(frame_warn_flag)
-CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.o := $(dml2_ccflags) $(frame_warn_flag)
-CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_top/dml2_top_interfaces.o := $(dml2_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_top/dml2_top_soc15.o := $(dml2_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_factory.o := $(dml2_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.o := $(dml2_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.o := $(dml2_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.o := $(dml2_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.o := $(dml2_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.o := $(dml2_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn3.o := $(dml2_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.o := $(dml2_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.o := $(dml2_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_standalone_libraries/lib_float_math.o := $(dml2_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/dml21_translation_helper.o := $(dml2_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/dml21_utils.o := $(dml2_ccflags)
-
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.o := $(dml2_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.o := $(dml2_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_factory.o := $(dml2_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.o := $(dml2_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_top/dml2_top_interfaces.o := $(dml2_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_top/dml2_top_soc15.o := $(dml2_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.o := $(dml2_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.o := $(dml2_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.o := $(dml2_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.o := $(dml2_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.o := $(dml2_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn3.o := $(dml2_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.o := $(dml2_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.o := $(dml2_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_standalone_libraries/lib_float_math.o := $(dml2_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/dml21_translation_helper.o := $(dml2_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/dml21_utils.o := $(dml2_rcflags)
-
 DML21 := src/dml2_top/dml2_top_interfaces.o
 DML21 += src/dml2_top/dml2_top_soc15.o
 DML21 += src/dml2_core/dml2_core_dcn4.o
@@ -134,6 +102,7 @@ DML21 += src/dml2_pmo/dml2_pmo_dcn4_fams2.o
 DML21 += src/dml2_standalone_libraries/lib_float_math.o
 DML21 += dml21_translation_helper.o
 DML21 += dml21_wrapper.o
+DML21 += dml21_wrapper_fpu.o
 DML21 += dml21_utils.o
 
 AMD_DAL_DML21 = $(addprefix $(AMDDALPATH)/dc/dml2_0/dml21/,$(DML21))
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
index 2623e917ec28..1a98578f223c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
@@ -9,6 +9,10 @@
 #include "dml21_utils.h"
 #include "dml21_translation_helper.h"
 #include "dml2_dc_resource_mgmt.h"
+#include "dml2_wrapper.h"
+#include "dml2_wrapper_fpu.h"
+#include "dml21_wrapper.h"
+#include "dml21_wrapper_fpu.h"
 #include "dc_fpu.h"
 
 #if !defined(DC_RUN_WITH_PREEMPTION_ENABLED)
@@ -40,44 +44,11 @@ static bool dml21_allocate_memory(struct dml2_context **dml_ctx)
 	return true;
 }
 
-static void dml21_populate_configuration_options(const struct dc *in_dc,
-		struct dml2_context *dml_ctx,
-		const struct dml2_configuration_options *config)
-{
-	dml_ctx->config = *config;
-
-	/* UCLK P-State options */
-	if (in_dc->debug.dml21_force_pstate_method) {
-		dml_ctx->config.pmo.force_pstate_method_enable = true;
-		for (int i = 0; i < MAX_PIPES; i++)
-			dml_ctx->config.pmo.force_pstate_method_values[i] = in_dc->debug.dml21_force_pstate_method_values[i];
-	} else {
-		dml_ctx->config.pmo.force_pstate_method_enable = false;
-	}
-}
-
-static void dml21_init(const struct dc *in_dc, struct dml2_context *dml_ctx, const struct dml2_configuration_options *config)
-{
-
-	dml_ctx->architecture = dml2_architecture_21;
-
-	dml21_populate_configuration_options(in_dc, dml_ctx, config);
-
-	DC_FP_START();
-
-	dml21_populate_dml_init_params(&dml_ctx->v21.dml_init, &dml_ctx->config, in_dc);
-
-	dml2_initialize_instance(&dml_ctx->v21.dml_init);
-
-	DC_FP_END();
-}
-
 bool dml21_create(const struct dc *in_dc, struct dml2_context **dml_ctx, const struct dml2_configuration_options *config)
 {
 	/* Allocate memory for initializing DML21 instance */
-	if (!dml21_allocate_memory(dml_ctx)) {
+	if (!dml21_allocate_memory(dml_ctx))
 		return false;
-	}
 
 	dml21_init(in_dc, *dml_ctx, config);
 
@@ -90,337 +61,6 @@ void dml21_destroy(struct dml2_context *dml2)
 	vfree(dml2->v21.mode_programming.programming);
 }
 
-static void dml21_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_state *context, struct resource_context *out_new_hw_state,
-	struct dml2_context *in_ctx, unsigned int pipe_cnt)
-{
-	unsigned int dml_prog_idx = 0, dc_pipe_index = 0, num_dpps_required = 0;
-	struct dml2_per_plane_programming *pln_prog = NULL;
-	struct dml2_per_stream_programming *stream_prog = NULL;
-	struct pipe_ctx *dc_main_pipes[__DML2_WRAPPER_MAX_STREAMS_PLANES__];
-	struct pipe_ctx *dc_phantom_pipes[__DML2_WRAPPER_MAX_STREAMS_PLANES__] = {0};
-	int num_pipes;
-	unsigned int dml_phantom_prog_idx;
-
-	context->bw_ctx.bw.dcn.clk.dppclk_khz = 0;
-
-	/* copy global DCHUBBUB arbiter registers */
-	memcpy(&context->bw_ctx.bw.dcn.arb_regs, &in_ctx->v21.mode_programming.programming->global_regs.arb_regs, sizeof(struct dml2_display_arb_regs));
-
-	/* legacy only */
-	context->bw_ctx.bw.dcn.compbuf_size_kb = (int)in_ctx->v21.mode_programming.programming->global_regs.arb_regs.compbuf_size * 64;
-
-	context->bw_ctx.bw.dcn.mall_ss_size_bytes = 0;
-	context->bw_ctx.bw.dcn.mall_ss_psr_active_size_bytes = 0;
-	context->bw_ctx.bw.dcn.mall_subvp_size_bytes = 0;
-
-	/* phantom's start after main planes */
-	dml_phantom_prog_idx = in_ctx->v21.mode_programming.programming->display_config.num_planes;
-
-	for (dml_prog_idx = 0; dml_prog_idx < DML2_MAX_PLANES; dml_prog_idx++) {
-		pln_prog = &in_ctx->v21.mode_programming.programming->plane_programming[dml_prog_idx];
-
-		if (!pln_prog->plane_descriptor)
-			continue;
-
-		stream_prog = &in_ctx->v21.mode_programming.programming->stream_programming[pln_prog->plane_descriptor->stream_index];
-		num_dpps_required = pln_prog->num_dpps_required;
-
-		if (num_dpps_required == 0) {
-			continue;
-		}
-		num_pipes = dml21_find_dc_pipes_for_plane(dc, context, in_ctx, dc_main_pipes, dc_phantom_pipes, dml_prog_idx);
-
-		if (num_pipes <= 0)
-			continue;
-
-		/* program each pipe */
-		for (dc_pipe_index = 0; dc_pipe_index < num_pipes; dc_pipe_index++) {
-			dml21_program_dc_pipe(in_ctx, context, dc_main_pipes[dc_pipe_index], pln_prog, stream_prog);
-
-			if (pln_prog->phantom_plane.valid && dc_phantom_pipes[dc_pipe_index]) {
-				dml21_program_dc_pipe(in_ctx, context, dc_phantom_pipes[dc_pipe_index], pln_prog, stream_prog);
-			}
-		}
-
-		/* copy per plane mcache allocation */
-		memcpy(&context->bw_ctx.bw.dcn.mcache_allocations[dml_prog_idx], &pln_prog->mcache_allocation, sizeof(struct dml2_mcache_surface_allocation));
-		if (pln_prog->phantom_plane.valid) {
-			memcpy(&context->bw_ctx.bw.dcn.mcache_allocations[dml_phantom_prog_idx],
-					&pln_prog->phantom_plane.mcache_allocation,
-					sizeof(struct dml2_mcache_surface_allocation));
-
-			dml_phantom_prog_idx++;
-		}
-	}
-
-	/* assign global clocks */
-	context->bw_ctx.bw.dcn.clk.bw_dppclk_khz = context->bw_ctx.bw.dcn.clk.dppclk_khz;
-	context->bw_ctx.bw.dcn.clk.bw_dispclk_khz = context->bw_ctx.bw.dcn.clk.dispclk_khz;
-	if (in_ctx->v21.dml_init.soc_bb.clk_table.dispclk.num_clk_values > 1) {
-		context->bw_ctx.bw.dcn.clk.max_supported_dispclk_khz =
-			in_ctx->v21.dml_init.soc_bb.clk_table.dispclk.clk_values_khz[in_ctx->v21.dml_init.soc_bb.clk_table.dispclk.num_clk_values] * 1000;
-	} else {
-		context->bw_ctx.bw.dcn.clk.max_supported_dispclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.dispclk.clk_values_khz[0] * 1000;
-	}
-
-	if (in_ctx->v21.dml_init.soc_bb.clk_table.dppclk.num_clk_values > 1) {
-		context->bw_ctx.bw.dcn.clk.max_supported_dppclk_khz =
-			in_ctx->v21.dml_init.soc_bb.clk_table.dppclk.clk_values_khz[in_ctx->v21.dml_init.soc_bb.clk_table.dppclk.num_clk_values] * 1000;
-	} else {
-		context->bw_ctx.bw.dcn.clk.max_supported_dppclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.dppclk.clk_values_khz[0] * 1000;
-	}
-
-	/* get global mall allocation */
-	if (dc->res_pool->funcs->calculate_mall_ways_from_bytes) {
-		context->bw_ctx.bw.dcn.clk.num_ways = dc->res_pool->funcs->calculate_mall_ways_from_bytes(dc, context->bw_ctx.bw.dcn.mall_subvp_size_bytes);
-	} else {
-		context->bw_ctx.bw.dcn.clk.num_ways = 0;
-	}
-}
-
-static void dml21_prepare_mcache_params(struct dml2_context *dml_ctx, struct dc_state *context, struct dc_mcache_params *mcache_params)
-{
-	int dc_plane_idx = 0;
-	int dml_prog_idx, stream_idx, plane_idx;
-	struct dml2_per_plane_programming *pln_prog = NULL;
-
-	for (stream_idx = 0; stream_idx < context->stream_count; stream_idx++) {
-		for (plane_idx = 0; plane_idx < context->stream_status[stream_idx].plane_count; plane_idx++) {
-			dml_prog_idx = map_plane_to_dml21_display_cfg(dml_ctx, context->streams[stream_idx]->stream_id, context->stream_status[stream_idx].plane_states[plane_idx], context);
-			if (dml_prog_idx == INVALID) {
-				continue;
-			}
-			pln_prog = &dml_ctx->v21.mode_programming.programming->plane_programming[dml_prog_idx];
-			mcache_params[dc_plane_idx].valid = pln_prog->mcache_allocation.valid;
-			mcache_params[dc_plane_idx].num_mcaches_plane0 = pln_prog->mcache_allocation.num_mcaches_plane0;
-			mcache_params[dc_plane_idx].num_mcaches_plane1 = pln_prog->mcache_allocation.num_mcaches_plane1;
-			mcache_params[dc_plane_idx].requires_dedicated_mall_mcache = pln_prog->mcache_allocation.requires_dedicated_mall_mcache;
-			mcache_params[dc_plane_idx].last_slice_sharing.plane0_plane1 = pln_prog->mcache_allocation.last_slice_sharing.plane0_plane1;
-			memcpy(mcache_params[dc_plane_idx].mcache_x_offsets_plane0,
-				pln_prog->mcache_allocation.mcache_x_offsets_plane0,
-				sizeof(int) * (DML2_MAX_MCACHES + 1));
-			memcpy(mcache_params[dc_plane_idx].mcache_x_offsets_plane1,
-				pln_prog->mcache_allocation.mcache_x_offsets_plane1,
-				sizeof(int) * (DML2_MAX_MCACHES + 1));
-			dc_plane_idx++;
-		}
-	}
-}
-
-static bool dml21_mode_check_and_programming(const struct dc *in_dc, struct dc_state *context, struct dml2_context *dml_ctx)
-{
-	bool result = false;
-	struct dml2_build_mode_programming_in_out *mode_programming = &dml_ctx->v21.mode_programming;
-	struct dc_mcache_params mcache_params[MAX_PLANES] = {0};
-
-	memset(&dml_ctx->v21.display_config, 0, sizeof(struct dml2_display_cfg));
-	memset(&dml_ctx->v21.dml_to_dc_pipe_mapping, 0, sizeof(struct dml2_dml_to_dc_pipe_mapping));
-	memset(&dml_ctx->v21.mode_programming.dml2_instance->scratch.build_mode_programming_locals.mode_programming_params, 0, sizeof(struct dml2_core_mode_programming_in_out));
-
-	if (!context)
-		return true;
-
-	if (context->stream_count == 0) {
-		dml21_init_min_clocks_for_dc_state(dml_ctx, context);
-		dml21_build_fams2_programming(in_dc, context, dml_ctx);
-		return true;
-	}
-
-	/* scrub phantom's from current dc_state */
-	dml_ctx->config.svp_pstate.callbacks.remove_phantom_streams_and_planes(in_dc, context);
-	dml_ctx->config.svp_pstate.callbacks.release_phantom_streams_and_planes(in_dc, context);
-
-	/* Populate stream, plane mappings and other fields in display config. */
-	result = dml21_map_dc_state_into_dml_display_cfg(in_dc, context, dml_ctx);
-	if (!result)
-		return false;
-
-	DC_FP_START();
-	result = dml2_build_mode_programming(mode_programming);
-	DC_FP_END();
-	if (!result)
-		return false;
-
-	/* Check and map HW resources */
-	if (result && !dml_ctx->config.skip_hw_state_mapping) {
-		dml21_map_hw_resources(dml_ctx);
-		dml2_map_dc_pipes(dml_ctx, context, NULL, &dml_ctx->v21.dml_to_dc_pipe_mapping, in_dc->current_state);
-		/* if subvp phantoms are present, expand them into dc context */
-		dml21_handle_phantom_streams_planes(in_dc, context, dml_ctx);
-
-		if (in_dc->res_pool->funcs->program_mcache_pipe_config) {
-			//Prepare mcache params for each plane based on mcache output from DML
-			dml21_prepare_mcache_params(dml_ctx, context, mcache_params);
-
-			//populate mcache regs to each pipe
-			dml_ctx->config.callbacks.allocate_mcache(context, mcache_params);
-		}
-	}
-
-	/* Copy DML CLK, WM and REG outputs to bandwidth context */
-	if (result && !dml_ctx->config.skip_hw_state_mapping) {
-		dml21_calculate_rq_and_dlg_params(in_dc, context, &context->res_ctx, dml_ctx, in_dc->res_pool->pipe_count);
-		dml21_copy_clocks_to_dc_state(dml_ctx, context);
-		dml21_extract_watermark_sets(in_dc, &context->bw_ctx.bw.dcn.watermarks, dml_ctx);
-		dml21_build_fams2_programming(in_dc, context, dml_ctx);
-	}
-
-	return true;
-}
-
-static bool dml21_check_mode_support(const struct dc *in_dc, struct dc_state *context, struct dml2_context *dml_ctx)
-{
-	bool is_supported = false;
-	struct dml2_initialize_instance_in_out *dml_init = &dml_ctx->v21.dml_init;
-	struct dml2_check_mode_supported_in_out *mode_support = &dml_ctx->v21.mode_support;
-
-	memset(&dml_ctx->v21.display_config, 0, sizeof(struct dml2_display_cfg));
-	memset(&dml_ctx->v21.dml_to_dc_pipe_mapping, 0, sizeof(struct dml2_dml_to_dc_pipe_mapping));
-	memset(&dml_ctx->v21.mode_programming.dml2_instance->scratch.check_mode_supported_locals.mode_support_params, 0, sizeof(struct dml2_core_mode_support_in_out));
-
-	if (!context || context->stream_count == 0)
-		return true;
-
-	/* Scrub phantom's from current dc_state */
-	dml_ctx->config.svp_pstate.callbacks.remove_phantom_streams_and_planes(in_dc, context);
-	dml_ctx->config.svp_pstate.callbacks.release_phantom_streams_and_planes(in_dc, context);
-
-	mode_support->dml2_instance = dml_init->dml2_instance;
-	dml21_map_dc_state_into_dml_display_cfg(in_dc, context, dml_ctx);
-	dml_ctx->v21.mode_programming.dml2_instance->scratch.build_mode_programming_locals.mode_programming_params.programming = dml_ctx->v21.mode_programming.programming;
-	DC_FP_START();
-	is_supported = dml2_check_mode_supported(mode_support);
-	DC_FP_END();
-	if (!is_supported)
-		return false;
-
-	return true;
-}
-
-bool dml21_validate(const struct dc *in_dc, struct dc_state *context, struct dml2_context *dml_ctx,
-	enum dc_validate_mode validate_mode)
-{
-	bool out = false;
-
-	/* Use dml21_check_mode_support for DC_VALIDATE_MODE_ONLY and DC_VALIDATE_MODE_AND_STATE_INDEX path */
-	if (validate_mode != DC_VALIDATE_MODE_AND_PROGRAMMING)
-		out = dml21_check_mode_support(in_dc, context, dml_ctx);
-	else
-		out = dml21_mode_check_and_programming(in_dc, context, dml_ctx);
-
-	return out;
-}
-
-void dml21_prepare_mcache_programming(struct dc *in_dc, struct dc_state *context, struct dml2_context *dml_ctx)
-{
-	unsigned int dml_prog_idx, dml_phantom_prog_idx, dc_pipe_index;
-	int num_pipes;
-	struct pipe_ctx *dc_main_pipes[__DML2_WRAPPER_MAX_STREAMS_PLANES__];
-	struct pipe_ctx *dc_phantom_pipes[__DML2_WRAPPER_MAX_STREAMS_PLANES__] = {0};
-
-	struct dml2_per_plane_programming *pln_prog = NULL;
-	struct dml2_plane_mcache_configuration_descriptor *mcache_config = NULL;
-	struct prepare_mcache_programming_locals *l = &dml_ctx->v21.scratch.prepare_mcache_locals;
-
-	if (context->stream_count == 0) {
-		return;
-	}
-
-	memset(&l->build_mcache_programming_params, 0, sizeof(struct dml2_build_mcache_programming_in_out));
-	l->build_mcache_programming_params.dml2_instance = dml_ctx->v21.dml_init.dml2_instance;
-
-	/* phantom's start after main planes */
-	dml_phantom_prog_idx = dml_ctx->v21.mode_programming.programming->display_config.num_planes;
-
-	/* Build mcache programming parameters per plane per pipe */
-	for (dml_prog_idx = 0; dml_prog_idx < dml_ctx->v21.mode_programming.programming->display_config.num_planes; dml_prog_idx++) {
-		pln_prog = &dml_ctx->v21.mode_programming.programming->plane_programming[dml_prog_idx];
-
-		mcache_config = &l->build_mcache_programming_params.mcache_configurations[dml_prog_idx];
-		memset(mcache_config, 0, sizeof(struct dml2_plane_mcache_configuration_descriptor));
-		mcache_config->plane_descriptor = pln_prog->plane_descriptor;
-		mcache_config->mcache_allocation = &context->bw_ctx.bw.dcn.mcache_allocations[dml_prog_idx];
-		mcache_config->num_pipes = pln_prog->num_dpps_required;
-		l->build_mcache_programming_params.num_configurations++;
-
-		if (pln_prog->num_dpps_required == 0) {
-			continue;
-		}
-
-		num_pipes = dml21_find_dc_pipes_for_plane(in_dc, context, dml_ctx, dc_main_pipes, dc_phantom_pipes, dml_prog_idx);
-		if (num_pipes <= 0 || dc_main_pipes[0]->stream == NULL ||
-		    dc_main_pipes[0]->plane_state == NULL)
-			continue;
-
-		/* get config for each pipe */
-		for (dc_pipe_index = 0; dc_pipe_index < num_pipes; dc_pipe_index++) {
-			ASSERT(dc_main_pipes[dc_pipe_index]);
-			dml21_get_pipe_mcache_config(context, dc_main_pipes[dc_pipe_index], pln_prog, &mcache_config->pipe_configurations[dc_pipe_index]);
-		}
-
-		/* get config for each phantom pipe */
-		if (pln_prog->phantom_plane.valid &&
-				dc_phantom_pipes[0] &&
-				dc_main_pipes[0]->stream &&
-				dc_phantom_pipes[0]->plane_state) {
-			mcache_config = &l->build_mcache_programming_params.mcache_configurations[dml_phantom_prog_idx];
-			memset(mcache_config, 0, sizeof(struct dml2_plane_mcache_configuration_descriptor));
-			mcache_config->plane_descriptor = pln_prog->plane_descriptor;
-			mcache_config->mcache_allocation = &context->bw_ctx.bw.dcn.mcache_allocations[dml_phantom_prog_idx];
-			mcache_config->num_pipes = pln_prog->num_dpps_required;
-			l->build_mcache_programming_params.num_configurations++;
-
-			for (dc_pipe_index = 0; dc_pipe_index < num_pipes; dc_pipe_index++) {
-				ASSERT(dc_phantom_pipes[dc_pipe_index]);
-				dml21_get_pipe_mcache_config(context, dc_phantom_pipes[dc_pipe_index], pln_prog, &mcache_config->pipe_configurations[dc_pipe_index]);
-			}
-
-			/* increment phantom index */
-			dml_phantom_prog_idx++;
-		}
-	}
-
-	/* Call to generate mcache programming per plane per pipe for the given display configuration */
-	dml2_build_mcache_programming(&l->build_mcache_programming_params);
-
-	/* get per plane per pipe mcache programming */
-	for (dml_prog_idx = 0; dml_prog_idx < dml_ctx->v21.mode_programming.programming->display_config.num_planes; dml_prog_idx++) {
-		pln_prog = &dml_ctx->v21.mode_programming.programming->plane_programming[dml_prog_idx];
-
-		num_pipes = dml21_find_dc_pipes_for_plane(in_dc, context, dml_ctx, dc_main_pipes, dc_phantom_pipes, dml_prog_idx);
-		if (num_pipes <= 0 || dc_main_pipes[0]->stream == NULL ||
-		    dc_main_pipes[0]->plane_state == NULL)
-			continue;
-
-		/* get config for each pipe */
-		for (dc_pipe_index = 0; dc_pipe_index < num_pipes; dc_pipe_index++) {
-			ASSERT(dc_main_pipes[dc_pipe_index]);
-			if (l->build_mcache_programming_params.per_plane_pipe_mcache_regs[dml_prog_idx][dc_pipe_index]) {
-				memcpy(&dc_main_pipes[dc_pipe_index]->mcache_regs,
-						l->build_mcache_programming_params.per_plane_pipe_mcache_regs[dml_prog_idx][dc_pipe_index],
-						sizeof(struct dml2_hubp_pipe_mcache_regs));
-			}
-		}
-
-		/* get config for each phantom pipe */
-		if (pln_prog->phantom_plane.valid &&
-				dc_phantom_pipes[0] &&
-				dc_main_pipes[0]->stream &&
-				dc_phantom_pipes[0]->plane_state) {
-			for (dc_pipe_index = 0; dc_pipe_index < num_pipes; dc_pipe_index++) {
-				ASSERT(dc_phantom_pipes[dc_pipe_index]);
-				if (l->build_mcache_programming_params.per_plane_pipe_mcache_regs[dml_phantom_prog_idx][dc_pipe_index]) {
-					memcpy(&dc_phantom_pipes[dc_pipe_index]->mcache_regs,
-							l->build_mcache_programming_params.per_plane_pipe_mcache_regs[dml_phantom_prog_idx][dc_pipe_index],
-							sizeof(struct dml2_hubp_pipe_mcache_regs));
-				}
-			}
-			/* increment phantom index */
-			dml_phantom_prog_idx++;
-		}
-	}
-}
-
 void dml21_copy(struct dml2_context *dst_dml_ctx,
 	struct dml2_context *src_dml_ctx)
 {
@@ -446,12 +86,8 @@ void dml21_copy(struct dml2_context *dst_dml_ctx,
 
 	dst_dml_ctx->v21.mode_programming.programming = dst_dml2_programming;
 
-	DC_FP_START();
-
 	/* need to initialize copied instance for internal references to be correct */
 	dml2_initialize_instance(&dst_dml_ctx->v21.dml_init);
-
-	DC_FP_END();
 }
 
 bool dml21_create_copy(struct dml2_context **dst_dml_ctx,
@@ -466,8 +102,3 @@ bool dml21_create_copy(struct dml2_context **dst_dml_ctx,
 	return true;
 }
 
-void dml21_reinit(const struct dc *in_dc, struct dml2_context *dml_ctx, const struct dml2_configuration_options *config)
-{
-	dml21_init(in_dc, dml_ctx, config);
-}
-
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.h
index b508bbcc0e16..c4813c51251b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.h
@@ -34,36 +34,6 @@ void dml21_copy(struct dml2_context *dst_dml_ctx,
 	struct dml2_context *src_dml_ctx);
 bool dml21_create_copy(struct dml2_context **dst_dml_ctx,
 	struct dml2_context *src_dml_ctx);
-void dml21_reinit(const struct dc *in_dc, struct dml2_context *dml_ctx, const struct dml2_configuration_options *config);
-
-/**
- * dml21_validate - Determines if a display configuration is supported or not.
- * @in_dc: dc.
- * @context: dc_state to be validated.
- * @dml_ctx: dml21 context.
- * @validate_mode: DC_VALIDATE_MODE_ONLY and DC_VALIDATE_MODE_AND_STATE_INDEX
- *           will not populate context.res_ctx.
- *
- * Based on fast_validate option internally would call:
- *
- * -dml21_mode_check_and_programming - for DC_VALIDATE_MODE_AND_PROGRAMMING option
- * Calculates if dc_state can be supported on the input display
- * configuration. If supported, generates the necessary HW
- * programming for the new dc_state.
- *
- * -dml21_check_mode_support - for DC_VALIDATE_MODE_ONLY and DC_VALIDATE_MODE_AND_STATE_INDEX option
- * Calculates if dc_state can be supported for the input display
- * config.
- *
- * Context: Two threads may not invoke this function concurrently unless they reference
- *          separate dc_states for validation.
- * Return: True if mode is supported, false otherwise.
- */
-bool dml21_validate(const struct dc *in_dc, struct dc_state *context, struct dml2_context *dml_ctx,
-	enum dc_validate_mode validate_mode);
-
-/* Prepare hubp mcache_regs for hubp mcache ID and split coordinate programming */
-void dml21_prepare_mcache_programming(struct dc *in_dc, struct dc_state *context, struct dml2_context *dml_ctx);
 
 /* Structure for inputting external SOCBB and DCNIP values for tool based debugging. */
 struct socbb_ip_params_external {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
new file mode 100644
index 000000000000..d5885bbd14c4
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
@@ -0,0 +1,381 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2024 Advanced Micro Devices, Inc.
+
+#include "dml2_internal_types.h"
+#include "dml_top.h"
+#include "dml2_core_dcn4_calcs.h"
+#include "dml2_internal_shared_types.h"
+#include "dml21_utils.h"
+#include "dml21_translation_helper.h"
+#include "dml2_dc_resource_mgmt.h"
+#include "dml2_wrapper.h"
+#include "dml2_wrapper_fpu.h"
+#include "dml21_wrapper.h"
+#include "dml21_wrapper_fpu.h"
+
+#define INVALID -1
+
+static void dml21_populate_configuration_options(const struct dc *in_dc,
+		struct dml2_context *dml_ctx,
+		const struct dml2_configuration_options *config)
+{
+	dml_ctx->config = *config;
+
+	/* UCLK P-State options */
+	if (in_dc->debug.dml21_force_pstate_method) {
+		dml_ctx->config.pmo.force_pstate_method_enable = true;
+		for (int i = 0; i < MAX_PIPES; i++)
+			dml_ctx->config.pmo.force_pstate_method_values[i] = in_dc->debug.dml21_force_pstate_method_values[i];
+	} else {
+		dml_ctx->config.pmo.force_pstate_method_enable = false;
+	}
+}
+
+void dml21_init(const struct dc *in_dc, struct dml2_context *dml_ctx, const struct dml2_configuration_options *config)
+{
+	dml_ctx->architecture = dml2_architecture_21;
+
+	dml21_populate_configuration_options(in_dc, dml_ctx, config);
+
+	dml21_populate_dml_init_params(&dml_ctx->v21.dml_init, &dml_ctx->config, in_dc);
+
+	dml2_initialize_instance(&dml_ctx->v21.dml_init);
+}
+
+void dml21_reinit(const struct dc *in_dc, struct dml2_context *dml_ctx, const struct dml2_configuration_options *config)
+{
+	dml21_init(in_dc, dml_ctx, config);
+}
+
+static void dml21_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_state *context, struct resource_context *out_new_hw_state,
+	struct dml2_context *in_ctx, unsigned int pipe_cnt)
+{
+	unsigned int dml_prog_idx = 0, dc_pipe_index = 0, num_dpps_required = 0;
+	struct dml2_per_plane_programming *pln_prog = NULL;
+	struct dml2_per_stream_programming *stream_prog = NULL;
+	struct pipe_ctx *dc_main_pipes[__DML2_WRAPPER_MAX_STREAMS_PLANES__];
+	struct pipe_ctx *dc_phantom_pipes[__DML2_WRAPPER_MAX_STREAMS_PLANES__] = {0};
+	int num_pipes;
+	unsigned int dml_phantom_prog_idx;
+
+	context->bw_ctx.bw.dcn.clk.dppclk_khz = 0;
+
+	/* copy global DCHUBBUB arbiter registers */
+	memcpy(&context->bw_ctx.bw.dcn.arb_regs, &in_ctx->v21.mode_programming.programming->global_regs.arb_regs, sizeof(struct dml2_display_arb_regs));
+
+	/* legacy only */
+	context->bw_ctx.bw.dcn.compbuf_size_kb = (int)in_ctx->v21.mode_programming.programming->global_regs.arb_regs.compbuf_size * 64;
+
+	context->bw_ctx.bw.dcn.mall_ss_size_bytes = 0;
+	context->bw_ctx.bw.dcn.mall_ss_psr_active_size_bytes = 0;
+	context->bw_ctx.bw.dcn.mall_subvp_size_bytes = 0;
+
+	/* phantom's start after main planes */
+	dml_phantom_prog_idx = in_ctx->v21.mode_programming.programming->display_config.num_planes;
+
+	for (dml_prog_idx = 0; dml_prog_idx < DML2_MAX_PLANES; dml_prog_idx++) {
+		pln_prog = &in_ctx->v21.mode_programming.programming->plane_programming[dml_prog_idx];
+
+		if (!pln_prog->plane_descriptor)
+			continue;
+
+		stream_prog = &in_ctx->v21.mode_programming.programming->stream_programming[pln_prog->plane_descriptor->stream_index];
+		num_dpps_required = pln_prog->num_dpps_required;
+
+		if (num_dpps_required == 0) {
+			continue;
+		}
+		num_pipes = dml21_find_dc_pipes_for_plane(dc, context, in_ctx, dc_main_pipes, dc_phantom_pipes, dml_prog_idx);
+
+		if (num_pipes <= 0)
+			continue;
+
+		/* program each pipe */
+		for (dc_pipe_index = 0; dc_pipe_index < num_pipes; dc_pipe_index++) {
+			dml21_program_dc_pipe(in_ctx, context, dc_main_pipes[dc_pipe_index], pln_prog, stream_prog);
+
+			if (pln_prog->phantom_plane.valid && dc_phantom_pipes[dc_pipe_index]) {
+				dml21_program_dc_pipe(in_ctx, context, dc_phantom_pipes[dc_pipe_index], pln_prog, stream_prog);
+			}
+		}
+
+		/* copy per plane mcache allocation */
+		memcpy(&context->bw_ctx.bw.dcn.mcache_allocations[dml_prog_idx], &pln_prog->mcache_allocation, sizeof(struct dml2_mcache_surface_allocation));
+		if (pln_prog->phantom_plane.valid) {
+			memcpy(&context->bw_ctx.bw.dcn.mcache_allocations[dml_phantom_prog_idx],
+					&pln_prog->phantom_plane.mcache_allocation,
+					sizeof(struct dml2_mcache_surface_allocation));
+
+			dml_phantom_prog_idx++;
+		}
+	}
+
+	/* assign global clocks */
+	context->bw_ctx.bw.dcn.clk.bw_dppclk_khz = context->bw_ctx.bw.dcn.clk.dppclk_khz;
+	context->bw_ctx.bw.dcn.clk.bw_dispclk_khz = context->bw_ctx.bw.dcn.clk.dispclk_khz;
+	if (in_ctx->v21.dml_init.soc_bb.clk_table.dispclk.num_clk_values > 1) {
+		context->bw_ctx.bw.dcn.clk.max_supported_dispclk_khz =
+			in_ctx->v21.dml_init.soc_bb.clk_table.dispclk.clk_values_khz[in_ctx->v21.dml_init.soc_bb.clk_table.dispclk.num_clk_values] * 1000;
+	} else {
+		context->bw_ctx.bw.dcn.clk.max_supported_dispclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.dispclk.clk_values_khz[0] * 1000;
+	}
+
+	if (in_ctx->v21.dml_init.soc_bb.clk_table.dppclk.num_clk_values > 1) {
+		context->bw_ctx.bw.dcn.clk.max_supported_dppclk_khz =
+			in_ctx->v21.dml_init.soc_bb.clk_table.dppclk.clk_values_khz[in_ctx->v21.dml_init.soc_bb.clk_table.dppclk.num_clk_values] * 1000;
+	} else {
+		context->bw_ctx.bw.dcn.clk.max_supported_dppclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.dppclk.clk_values_khz[0] * 1000;
+	}
+
+	/* get global mall allocation */
+	if (dc->res_pool->funcs->calculate_mall_ways_from_bytes) {
+		context->bw_ctx.bw.dcn.clk.num_ways = dc->res_pool->funcs->calculate_mall_ways_from_bytes(dc, context->bw_ctx.bw.dcn.mall_subvp_size_bytes);
+	} else {
+		context->bw_ctx.bw.dcn.clk.num_ways = 0;
+	}
+}
+
+static void dml21_prepare_mcache_params(struct dml2_context *dml_ctx, struct dc_state *context, struct dc_mcache_params *mcache_params)
+{
+	int dc_plane_idx = 0;
+	int dml_prog_idx, stream_idx, plane_idx;
+	struct dml2_per_plane_programming *pln_prog = NULL;
+
+	for (stream_idx = 0; stream_idx < context->stream_count; stream_idx++) {
+		for (plane_idx = 0; plane_idx < context->stream_status[stream_idx].plane_count; plane_idx++) {
+			dml_prog_idx = map_plane_to_dml21_display_cfg(dml_ctx, context->streams[stream_idx]->stream_id, context->stream_status[stream_idx].plane_states[plane_idx], context);
+			if (dml_prog_idx == INVALID) {
+				continue;
+			}
+			pln_prog = &dml_ctx->v21.mode_programming.programming->plane_programming[dml_prog_idx];
+			mcache_params[dc_plane_idx].valid = pln_prog->mcache_allocation.valid;
+			mcache_params[dc_plane_idx].num_mcaches_plane0 = pln_prog->mcache_allocation.num_mcaches_plane0;
+			mcache_params[dc_plane_idx].num_mcaches_plane1 = pln_prog->mcache_allocation.num_mcaches_plane1;
+			mcache_params[dc_plane_idx].requires_dedicated_mall_mcache = pln_prog->mcache_allocation.requires_dedicated_mall_mcache;
+			mcache_params[dc_plane_idx].last_slice_sharing.plane0_plane1 = pln_prog->mcache_allocation.last_slice_sharing.plane0_plane1;
+			memcpy(mcache_params[dc_plane_idx].mcache_x_offsets_plane0,
+				pln_prog->mcache_allocation.mcache_x_offsets_plane0,
+				sizeof(int) * (DML2_MAX_MCACHES + 1));
+			memcpy(mcache_params[dc_plane_idx].mcache_x_offsets_plane1,
+				pln_prog->mcache_allocation.mcache_x_offsets_plane1,
+				sizeof(int) * (DML2_MAX_MCACHES + 1));
+			dc_plane_idx++;
+		}
+	}
+}
+
+static bool dml21_check_mode_support(const struct dc *in_dc, struct dc_state *context, struct dml2_context *dml_ctx)
+{
+	bool is_supported = false;
+	struct dml2_initialize_instance_in_out *dml_init = &dml_ctx->v21.dml_init;
+	struct dml2_check_mode_supported_in_out *mode_support = &dml_ctx->v21.mode_support;
+
+	memset(&dml_ctx->v21.display_config, 0, sizeof(struct dml2_display_cfg));
+	memset(&dml_ctx->v21.dml_to_dc_pipe_mapping, 0, sizeof(struct dml2_dml_to_dc_pipe_mapping));
+	memset(&dml_ctx->v21.mode_programming.dml2_instance->scratch.check_mode_supported_locals.mode_support_params, 0, sizeof(struct dml2_core_mode_support_in_out));
+
+	if (!context || context->stream_count == 0)
+		return true;
+
+	/* Scrub phantom's from current dc_state */
+	dml_ctx->config.svp_pstate.callbacks.remove_phantom_streams_and_planes(in_dc, context);
+	dml_ctx->config.svp_pstate.callbacks.release_phantom_streams_and_planes(in_dc, context);
+
+	mode_support->dml2_instance = dml_init->dml2_instance;
+	dml21_map_dc_state_into_dml_display_cfg(in_dc, context, dml_ctx);
+	dml_ctx->v21.mode_programming.dml2_instance->scratch.build_mode_programming_locals.mode_programming_params.programming = dml_ctx->v21.mode_programming.programming;
+
+	is_supported = dml2_check_mode_supported(mode_support);
+
+	if (!is_supported)
+		return false;
+
+	return true;
+}
+
+static bool dml21_mode_check_and_programming(const struct dc *in_dc, struct dc_state *context, struct dml2_context *dml_ctx)
+{
+	bool result = false;
+	struct dml2_build_mode_programming_in_out *mode_programming = &dml_ctx->v21.mode_programming;
+	struct dc_mcache_params mcache_params[MAX_PLANES] = {0};
+
+	memset(&dml_ctx->v21.display_config, 0, sizeof(struct dml2_display_cfg));
+	memset(&dml_ctx->v21.dml_to_dc_pipe_mapping, 0, sizeof(struct dml2_dml_to_dc_pipe_mapping));
+	memset(&dml_ctx->v21.mode_programming.dml2_instance->scratch.build_mode_programming_locals.mode_programming_params, 0, sizeof(struct dml2_core_mode_programming_in_out));
+
+	if (!context)
+		return true;
+
+	if (context->stream_count == 0) {
+		dml21_init_min_clocks_for_dc_state(dml_ctx, context);
+		dml21_build_fams2_programming(in_dc, context, dml_ctx);
+		return true;
+	}
+
+	/* scrub phantom's from current dc_state */
+	dml_ctx->config.svp_pstate.callbacks.remove_phantom_streams_and_planes(in_dc, context);
+	dml_ctx->config.svp_pstate.callbacks.release_phantom_streams_and_planes(in_dc, context);
+
+	/* Populate stream, plane mappings and other fields in display config. */
+	result = dml21_map_dc_state_into_dml_display_cfg(in_dc, context, dml_ctx);
+	if (!result)
+		return false;
+
+	result = dml2_build_mode_programming(mode_programming);
+
+	if (!result)
+		return false;
+
+	/* Check and map HW resources */
+	if (result && !dml_ctx->config.skip_hw_state_mapping) {
+		dml21_map_hw_resources(dml_ctx);
+		dml2_map_dc_pipes(dml_ctx, context, NULL, &dml_ctx->v21.dml_to_dc_pipe_mapping, in_dc->current_state);
+		/* if subvp phantoms are present, expand them into dc context */
+		dml21_handle_phantom_streams_planes(in_dc, context, dml_ctx);
+
+		if (in_dc->res_pool->funcs->program_mcache_pipe_config) {
+			//Prepare mcache params for each plane based on mcache output from DML
+			dml21_prepare_mcache_params(dml_ctx, context, mcache_params);
+
+			//populate mcache regs to each pipe
+			dml_ctx->config.callbacks.allocate_mcache(context, mcache_params);
+		}
+	}
+
+	/* Copy DML CLK, WM and REG outputs to bandwidth context */
+	if (result && !dml_ctx->config.skip_hw_state_mapping) {
+		dml21_calculate_rq_and_dlg_params(in_dc, context, &context->res_ctx, dml_ctx, in_dc->res_pool->pipe_count);
+		dml21_copy_clocks_to_dc_state(dml_ctx, context);
+		dml21_extract_watermark_sets(in_dc, &context->bw_ctx.bw.dcn.watermarks, dml_ctx);
+		dml21_build_fams2_programming(in_dc, context, dml_ctx);
+	}
+
+	return true;
+}
+
+bool dml21_validate(const struct dc *in_dc, struct dc_state *context, struct dml2_context *dml_ctx,
+	enum dc_validate_mode validate_mode)
+{
+	bool out = false;
+
+	/* Use dml21_check_mode_support for DC_VALIDATE_MODE_ONLY and DC_VALIDATE_MODE_AND_STATE_INDEX path */
+	if (validate_mode != DC_VALIDATE_MODE_AND_PROGRAMMING)
+		out = dml21_check_mode_support(in_dc, context, dml_ctx);
+	else
+		out = dml21_mode_check_and_programming(in_dc, context, dml_ctx);
+
+	return out;
+}
+
+void dml21_prepare_mcache_programming(struct dc *in_dc, struct dc_state *context, struct dml2_context *dml_ctx)
+{
+	unsigned int dml_prog_idx, dml_phantom_prog_idx, dc_pipe_index;
+	int num_pipes;
+	struct pipe_ctx *dc_main_pipes[__DML2_WRAPPER_MAX_STREAMS_PLANES__];
+	struct pipe_ctx *dc_phantom_pipes[__DML2_WRAPPER_MAX_STREAMS_PLANES__] = {0};
+
+	struct dml2_per_plane_programming *pln_prog = NULL;
+	struct dml2_plane_mcache_configuration_descriptor *mcache_config = NULL;
+	struct prepare_mcache_programming_locals *l = &dml_ctx->v21.scratch.prepare_mcache_locals;
+
+	if (context->stream_count == 0) {
+		return;
+	}
+
+	memset(&l->build_mcache_programming_params, 0, sizeof(struct dml2_build_mcache_programming_in_out));
+	l->build_mcache_programming_params.dml2_instance = dml_ctx->v21.dml_init.dml2_instance;
+
+	/* phantom's start after main planes */
+	dml_phantom_prog_idx = dml_ctx->v21.mode_programming.programming->display_config.num_planes;
+
+	/* Build mcache programming parameters per plane per pipe */
+	for (dml_prog_idx = 0; dml_prog_idx < dml_ctx->v21.mode_programming.programming->display_config.num_planes; dml_prog_idx++) {
+		pln_prog = &dml_ctx->v21.mode_programming.programming->plane_programming[dml_prog_idx];
+
+		mcache_config = &l->build_mcache_programming_params.mcache_configurations[dml_prog_idx];
+		memset(mcache_config, 0, sizeof(struct dml2_plane_mcache_configuration_descriptor));
+		mcache_config->plane_descriptor = pln_prog->plane_descriptor;
+		mcache_config->mcache_allocation = &context->bw_ctx.bw.dcn.mcache_allocations[dml_prog_idx];
+		mcache_config->num_pipes = pln_prog->num_dpps_required;
+		l->build_mcache_programming_params.num_configurations++;
+
+		if (pln_prog->num_dpps_required == 0) {
+			continue;
+		}
+
+		num_pipes = dml21_find_dc_pipes_for_plane(in_dc, context, dml_ctx, dc_main_pipes, dc_phantom_pipes, dml_prog_idx);
+		if (num_pipes <= 0 || dc_main_pipes[0]->stream == NULL ||
+		    dc_main_pipes[0]->plane_state == NULL)
+			continue;
+
+		/* get config for each pipe */
+		for (dc_pipe_index = 0; dc_pipe_index < num_pipes; dc_pipe_index++) {
+			ASSERT(dc_main_pipes[dc_pipe_index]);
+			dml21_get_pipe_mcache_config(context, dc_main_pipes[dc_pipe_index], pln_prog, &mcache_config->pipe_configurations[dc_pipe_index]);
+		}
+
+		/* get config for each phantom pipe */
+		if (pln_prog->phantom_plane.valid &&
+				dc_phantom_pipes[0] &&
+				dc_main_pipes[0]->stream &&
+				dc_phantom_pipes[0]->plane_state) {
+			mcache_config = &l->build_mcache_programming_params.mcache_configurations[dml_phantom_prog_idx];
+			memset(mcache_config, 0, sizeof(struct dml2_plane_mcache_configuration_descriptor));
+			mcache_config->plane_descriptor = pln_prog->plane_descriptor;
+			mcache_config->mcache_allocation = &context->bw_ctx.bw.dcn.mcache_allocations[dml_phantom_prog_idx];
+			mcache_config->num_pipes = pln_prog->num_dpps_required;
+			l->build_mcache_programming_params.num_configurations++;
+
+			for (dc_pipe_index = 0; dc_pipe_index < num_pipes; dc_pipe_index++) {
+				ASSERT(dc_phantom_pipes[dc_pipe_index]);
+				dml21_get_pipe_mcache_config(context, dc_phantom_pipes[dc_pipe_index], pln_prog, &mcache_config->pipe_configurations[dc_pipe_index]);
+			}
+
+			/* increment phantom index */
+			dml_phantom_prog_idx++;
+		}
+	}
+
+	/* Call to generate mcache programming per plane per pipe for the given display configuration */
+	dml2_build_mcache_programming(&l->build_mcache_programming_params);
+
+	/* get per plane per pipe mcache programming */
+	for (dml_prog_idx = 0; dml_prog_idx < dml_ctx->v21.mode_programming.programming->display_config.num_planes; dml_prog_idx++) {
+		pln_prog = &dml_ctx->v21.mode_programming.programming->plane_programming[dml_prog_idx];
+
+		num_pipes = dml21_find_dc_pipes_for_plane(in_dc, context, dml_ctx, dc_main_pipes, dc_phantom_pipes, dml_prog_idx);
+		if (num_pipes <= 0 || dc_main_pipes[0]->stream == NULL ||
+		    dc_main_pipes[0]->plane_state == NULL)
+			continue;
+
+		/* get config for each pipe */
+		for (dc_pipe_index = 0; dc_pipe_index < num_pipes; dc_pipe_index++) {
+			ASSERT(dc_main_pipes[dc_pipe_index]);
+			if (l->build_mcache_programming_params.per_plane_pipe_mcache_regs[dml_prog_idx][dc_pipe_index]) {
+				memcpy(&dc_main_pipes[dc_pipe_index]->mcache_regs,
+						l->build_mcache_programming_params.per_plane_pipe_mcache_regs[dml_prog_idx][dc_pipe_index],
+						sizeof(struct dml2_hubp_pipe_mcache_regs));
+			}
+		}
+
+		/* get config for each phantom pipe */
+		if (pln_prog->phantom_plane.valid &&
+				dc_phantom_pipes[0] &&
+				dc_main_pipes[0]->stream &&
+				dc_phantom_pipes[0]->plane_state) {
+			for (dc_pipe_index = 0; dc_pipe_index < num_pipes; dc_pipe_index++) {
+				ASSERT(dc_phantom_pipes[dc_pipe_index]);
+				if (l->build_mcache_programming_params.per_plane_pipe_mcache_regs[dml_phantom_prog_idx][dc_pipe_index]) {
+					memcpy(&dc_phantom_pipes[dc_pipe_index]->mcache_regs,
+							l->build_mcache_programming_params.per_plane_pipe_mcache_regs[dml_phantom_prog_idx][dc_pipe_index],
+							sizeof(struct dml2_hubp_pipe_mcache_regs));
+				}
+			}
+			/* increment phantom index */
+			dml_phantom_prog_idx++;
+		}
+	}
+}
+
+
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.h
new file mode 100644
index 000000000000..2972c6eed21a
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.h
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2024 Advanced Micro Devices, Inc.
+
+#ifndef _DML21_WRAPPER_FPU_H_
+#define _DML21_WRAPPER_FPU_H_
+
+#include "os_types.h"
+#include "dml_top_soc_parameter_types.h"
+#include "dml_top_display_cfg_types.h"
+
+struct dc;
+struct dc_state;
+struct dml2_configuration_options;
+struct dml2_context;
+enum dc_validate_mode;
+
+/**
+ * dml21_init - Initialize DML21 context
+ * @in_dc: dc.
+ * @dml_ctx: DML21 context to initialize.
+ * @config: dml21 configuration options.
+ *
+ * Performs FPU-requiring initialization. Must be called with FPU protection.
+ */
+void dml21_init(const struct dc *in_dc, struct dml2_context *dml_ctx, const struct dml2_configuration_options *config);
+
+/**
+ * dml21_validate - Determines if a display configuration is supported or not.
+ * @in_dc: dc.
+ * @context: dc_state to be validated.
+ * @dml_ctx: dml21 context.
+ * @validate_mode: DC_VALIDATE_MODE_ONLY and DC_VALIDATE_MODE_AND_STATE_INDEX
+ *           will not populate context.res_ctx.
+ *
+ * Based on fast_validate option internally would call:
+ *
+ * -dml21_mode_check_and_programming - for DC_VALIDATE_MODE_AND_PROGRAMMING option
+ * Calculates if dc_state can be supported on the input display
+ * configuration. If supported, generates the necessary HW
+ * programming for the new dc_state.
+ *
+ * -dml21_check_mode_support - for DC_VALIDATE_MODE_ONLY and DC_VALIDATE_MODE_AND_STATE_INDEX option
+ * Calculates if dc_state can be supported for the input display
+ * config.
+ *
+ * Context: Two threads may not invoke this function concurrently unless they reference
+ *          separate dc_states for validation.
+ * Return: True if mode is supported, false otherwise.
+ */
+
+void dml21_reinit(const struct dc *in_dc, struct dml2_context *dml_ctx,
+		  const struct dml2_configuration_options *config);
+bool dml21_validate(const struct dc *in_dc, struct dc_state *context, struct dml2_context *dml_ctx,
+	enum dc_validate_mode validate_mode);
+
+/* Prepare hubp mcache_regs for hubp mcache ID and split coordinate programming */
+void dml21_prepare_mcache_programming(struct dc *in_dc, struct dc_state *context, struct dml2_context *dml_ctx);
+
+#endif /* _DML21_WRAPPER_FPU_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
index 408559d6fb2d..f8250c80be02 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
@@ -6,7 +6,20 @@
  */
 
 #include "dml2_internal_types.h"
+#include "dml2_wrapper.h"
 #include "dml2_wrapper_fpu.h"
+#include "dml21_wrapper.h"
+#include "dml21_wrapper_fpu.h"
+
+#include "dc_fpu.h"
+
+struct dml2_context *dml2_allocate_memory(void)
+{
+	struct dml2_context *dml2;
+
+	DC_RUN_WITH_PREEMPTION_ENABLED(dml2 = vzalloc(sizeof(struct dml2_context)));
+	return dml2;
+}
 
 bool dml2_validate(const struct dc *in_dc, struct dc_state *context, struct dml2_context *dml2,
 	enum dc_validate_mode validate_mode)
@@ -23,16 +36,12 @@ bool dml2_validate(const struct dc *in_dc, struct dc_state *context, struct dml2
 		return out;
 	}
 
-	DC_FP_START();
-
 	/* Use dml_validate_only for DC_VALIDATE_MODE_ONLY and DC_VALIDATE_MODE_AND_STATE_INDEX path */
 	if (validate_mode != DC_VALIDATE_MODE_AND_PROGRAMMING)
 		out = dml2_validate_only(context, validate_mode);
 	else
 		out = dml2_validate_and_build_resource(in_dc, context, validate_mode);
 
-	DC_FP_END();
-
 	return out;
 }
 
@@ -70,15 +79,11 @@ static void dml2_init(const struct dc *in_dc, const struct dml2_configuration_op
 		break;
 	}
 
-	DC_FP_START();
-
 	initialize_dml2_ip_params(*dml2, in_dc, &(*dml2)->v20.dml_core_ctx.ip);
 
 	initialize_dml2_soc_bbox(*dml2, in_dc, &(*dml2)->v20.dml_core_ctx.soc);
 
 	initialize_dml2_soc_states(*dml2, in_dc, &(*dml2)->v20.dml_core_ctx.soc, &(*dml2)->v20.dml_core_ctx.states);
-
-	DC_FP_END();
 }
 
 bool dml2_create(const struct dc *in_dc, const struct dml2_configuration_options *config, struct dml2_context **dml2)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c
index 203eef747262..66624cfc27b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c
@@ -31,8 +31,10 @@
 #include "dml2_translation_helper.h"
 #include "dml2_mall_phantom.h"
 #include "dml2_dc_resource_mgmt.h"
-#include "dml21_wrapper.h"
+#include "dml2_wrapper.h"
 #include "dml2_wrapper_fpu.h"
+#include "dml21_wrapper.h"
+#include "dml21_wrapper_fpu.h"
 
 void initialize_dml2_ip_params(struct dml2_context *dml2, const struct dc *in_dc, struct ip_params_st *out)
 {
@@ -546,11 +548,6 @@ void dml2_apply_debug_options(const struct dc *dc, struct dml2_context *dml2)
 	}
 }
 
-inline struct dml2_context *dml2_allocate_memory(void)
-{
-	return (struct dml2_context *) vzalloc(sizeof(struct dml2_context));
-}
-
 void dml2_destroy(struct dml2_context *dml2)
 {
 	if (!dml2)
-- 
2.43.0

