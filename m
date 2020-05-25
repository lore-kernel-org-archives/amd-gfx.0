Return-Path: <SRS0=Ro4j=7H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DA6C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE63520723
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0ljlILjA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE63520723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F144489FFD;
	Mon, 25 May 2020 18:13:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2C7489C2C
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2020 18:13:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGed/nt0Tc5M2fdiQC5OsC/cfzywUwo+OMH71uKtDZPWdpgfwrLAaxv/u564LOcnIfwSPBHa6hL++QWlzp2S1YGjBU3t6OMOcJWNXEtvBujRbl5IdB0bLgvL9FSsX4Aql3xw0wdNEXFZdWgAvazb14XYFuXZqJbyZMMTJ+YWJ6ysKa+KXsizM2zBjU2nzwyom7+3qlLpvgv11Zf+Pr2ml993NlSRLJSWAWtK4FS2Ui0XR+jClGMkSXo9PkDFhw7MdJip/r7FcekzOaSu1v0VC+n0IdCTb9yTqHAj3LnUboNzcgguJsFuq8HTiPd6ijImbcS3PWMhkbxKcggGxrFh+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdGeLXGd+g6/niYwT01CUy7UDybwzq0ZFCaezzyvO1g=;
 b=Cx40RG8IDtpEyolCuOVasIVqWdbLpJoFSOeZ2VamhLVRmmZgyfEcOek+oza1EyhHCvfIlZyRGzhPJbuYzb7VvTwn3wEtsMWW51bMMi/r1a92+/Yu5QG+fNArPURyIC7xAUZ3LstNC8iJg/MDzzITuVTtUwkGqAD9o71aYwwjKvB4bU5Eh9gPs6xkA9Z3f0EtPesTNWZZqZiHh+AqgxXnb7OM3Jfa3nKOZdqiPTu3ggEP3ah33Lf4omBu8ujl278tDRvXRQQaRxVEhxbUHF3xwTiOuju2WwF9ZlPwQfNZFaeTZbcud5h9v3HF0lwkgayLCSKJopBHo/eKHpZRQ3/B3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdGeLXGd+g6/niYwT01CUy7UDybwzq0ZFCaezzyvO1g=;
 b=0ljlILjAFQ0hssrXr8tul7Ciih2JVkRhH2/6bfZgH2zeDzvUytl+3xJo6gdhYSsFx7D/dnvLr0VqO0lNn8nSLpaCAPl0e97wUX8lHNn0DoCJ1g4BZb6KH7eTqWpVv/xS9YexVQdb3gaFEUBER32MMCFPiuKkgRSfpRDzlqbc4/E=
Received: from MWHPR21CA0062.namprd21.prod.outlook.com (2603:10b6:300:db::24)
 by SN6SPR01MB0019.namprd12.prod.outlook.com (2603:10b6:805:ab::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Mon, 25 May
 2020 18:13:17 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:db:cafe::4b) by MWHPR21CA0062.outlook.office365.com
 (2603:10b6:300:db::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.2 via Frontend
 Transport; Mon, 25 May 2020 18:13:16 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3021.23 via Frontend Transport; Mon, 25 May 2020 18:13:16 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 25 May
 2020 13:13:15 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 25 May 2020 13:13:14 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/16] drm/amd/display: combine public interfaces into single
 header
Date: Mon, 25 May 2020 14:13:02 -0400
Message-ID: <20200525181306.3749-13-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525181306.3749-1-qingqing.zhuo@amd.com>
References: <20200525181306.3749-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(46966005)(6916009)(8676002)(2616005)(5660300002)(44832011)(30864003)(426003)(54906003)(8936002)(86362001)(316002)(478600001)(4326008)(26005)(1076003)(356005)(336012)(82310400002)(70206006)(186003)(70586007)(81166007)(47076004)(36756003)(82740400003)(2906002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 792f4795-5622-4b02-fb79-08d800d74bd2
X-MS-TrafficTypeDiagnostic: SN6SPR01MB0019:
X-Microsoft-Antispam-PRVS: <SN6SPR01MB0019DD4598EBD1CA1FBA3483FBB30@SN6SPR01MB0019.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pcPqmVvmqREIuJ9AO5iBUEBmGoNfZzAz6FkLz18KibUYOo6SHM3DCPvZRkCAsbSl0JXCu3RJyCjPb/8AYSmfsrrTDXGmr2KjZTBChxBNXeggnnBBi8+jKidclPWBzS1II/MOPqRJsLv7j6C4Tu9OXOWyV9LSztki5w7B8nTDxhiblyiwlrCVkiyah1MYn29Em0cmT7EDjBHtAwfe+ubryuokcIW12nuCeBgj0kcOUBEj45pFOr5QNndK1og7Q46eA9mX6J7fTwHGdDyDA701eZePe1w3P4UFlaAypupB8zpLvH0quQ7KCbiXzcqSzVaKn5cg+/VT8tSpI/aMq4q/x+FEm+dArWH6lqxhdw4GOj2Klh4eVxPcdgzMiQJJwsjGOgm7MP3o0cCZwa5PMJmA6w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 18:13:16.1422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 792f4795-5622-4b02-fb79-08d800d74bd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6SPR01MB0019
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Why]
We want to better encapsulate all driver-fw dependencies into a single
file.

[How]
Combine all the headers under inc folder into a single header

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   4 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 383 +++++++++++++++++-
 .../drm/amd/display/dmub/inc/dmub_cmd_dal.h   |  91 -----
 .../drm/amd/display/dmub/inc/dmub_cmd_vbios.h |  41 --
 .../drm/amd/display/dmub/inc/dmub_fw_meta.h   |  65 ---
 .../drm/amd/display/dmub/inc/dmub_gpint_cmd.h |  75 ----
 .../gpu/drm/amd/display/dmub/inc/dmub_rb.h    | 154 -------
 .../gpu/drm/amd/display/dmub/inc/dmub_types.h |  78 ----
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_reg.h   |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   2 +-
 .../amd/display/modules/power/power_helpers.c |   2 +-
 12 files changed, 374 insertions(+), 525 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h
 delete mode 100644 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_vbios.h
 delete mode 100644 drivers/gpu/drm/amd/display/dmub/inc/dmub_fw_meta.h
 delete mode 100644 drivers/gpu/drm/amd/display/dmub/inc/dmub_gpint_cmd.h
 delete mode 100644 drivers/gpu/drm/amd/display/dmub/inc/dmub_rb.h
 delete mode 100644 drivers/gpu/drm/amd/display/dmub/inc/dmub_types.h

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 73b5d500ccf6..0ea702eeddad 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -64,11 +64,7 @@
  * other component within DAL.
  */
 
-#include "inc/dmub_types.h"
 #include "inc/dmub_cmd.h"
-#include "inc/dmub_gpint_cmd.h"
-#include "inc/dmub_cmd_dal.h"
-#include "inc/dmub_rb.h"
 
 #if defined(__cplusplus)
 extern "C" {
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 7782b7fc1ce0..48baf92a1cb5 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -26,20 +26,188 @@
 #ifndef _DMUB_CMD_H_
 #define _DMUB_CMD_H_
 
-#include "dmub_types.h"
-#include "dmub_cmd_dal.h"
-#include "dmub_cmd_vbios.h"
+#include <asm/byteorder.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/delay.h>
+#include <stdarg.h>
+
 #include "atomfirmware.h"
 
-#define DMUB_RB_CMD_SIZE 64
-#define DMUB_RB_MAX_ENTRY 128
-#define DMUB_RB_SIZE (DMUB_RB_CMD_SIZE * DMUB_RB_MAX_ENTRY)
-#define REG_SET_MASK 0xFFFF
+
+//<DMUB_TYPES>==================================================================
+/* Basic type definitions. */
 
 #define SET_ABM_PIPE_GRADUALLY_DISABLE           0
 #define SET_ABM_PIPE_IMMEDIATELY_DISABLE         255
 #define SET_ABM_PIPE_NORMAL                      1
 
+/* Maximum number of streams on any ASIC. */
+#define DMUB_MAX_STREAMS 6
+
+/* Maximum number of planes on any ASIC. */
+#define DMUB_MAX_PLANES 6
+
+#ifndef PHYSICAL_ADDRESS_LOC
+#define PHYSICAL_ADDRESS_LOC union large_integer
+#endif
+
+#if defined(__cplusplus)
+extern "C" {
+#endif
+
+#ifndef dmub_memcpy
+#define dmub_memcpy(dest, source, bytes) memcpy((dest), (source), (bytes))
+#endif
+
+#ifndef dmub_memset
+#define dmub_memset(dest, val, bytes) memset((dest), (val), (bytes))
+#endif
+
+#ifndef dmub_udelay
+#define dmub_udelay(microseconds) udelay(microseconds)
+#endif
+
+union dmub_addr {
+	struct {
+		uint32_t low_part;
+		uint32_t high_part;
+	} u;
+	uint64_t quad_part;
+};
+
+union dmub_psr_debug_flags {
+	struct {
+		uint8_t visual_confirm : 1;
+	} bitfields;
+
+	unsigned int u32All;
+};
+
+#if defined(__cplusplus)
+}
+#endif
+
+
+
+//==============================================================================
+//</DMUB_TYPES>=================================================================
+//==============================================================================
+//< DMUB_META>==================================================================
+//==============================================================================
+#pragma pack(push, 1)
+
+/* Magic value for identifying dmub_fw_meta_info */
+#define DMUB_FW_META_MAGIC 0x444D5542
+
+/* Offset from the end of the file to the dmub_fw_meta_info */
+#define DMUB_FW_META_OFFSET 0x24
+
+/**
+ * struct dmub_fw_meta_info - metadata associated with fw binary
+ *
+ * NOTE: This should be considered a stable API. Fields should
+ *       not be repurposed or reordered. New fields should be
+ *       added instead to extend the structure.
+ *
+ * @magic_value: magic value identifying DMUB firmware meta info
+ * @fw_region_size: size of the firmware state region
+ * @trace_buffer_size: size of the tracebuffer region
+ * @fw_version: the firmware version information
+ */
+struct dmub_fw_meta_info {
+	uint32_t magic_value;
+	uint32_t fw_region_size;
+	uint32_t trace_buffer_size;
+	uint32_t fw_version;
+};
+
+/* Ensure that the structure remains 64 bytes. */
+union dmub_fw_meta {
+	struct dmub_fw_meta_info info;
+	uint8_t reserved[64];
+};
+
+#pragma pack(pop)
+//==============================================================================
+//</DMUB_META>==================================================================
+//==============================================================================
+//< DMUB_VBIOS>=================================================================
+//==============================================================================
+
+/*
+ * Command IDs should be treated as stable ABI.
+ * Do not reuse or modify IDs.
+ */
+
+enum dmub_cmd_vbios_type {
+	DMUB_CMD__VBIOS_DIGX_ENCODER_CONTROL = 0,
+	DMUB_CMD__VBIOS_DIG1_TRANSMITTER_CONTROL = 1,
+	DMUB_CMD__VBIOS_SET_PIXEL_CLOCK = 2,
+	DMUB_CMD__VBIOS_ENABLE_DISP_POWER_GATING = 3,
+};
+
+//==============================================================================
+//</DMUB_VBIOS>=================================================================
+//==============================================================================
+//< DMUB_GPINT>=================================================================
+//==============================================================================
+
+/**
+ * The shifts and masks below may alternatively be used to format and read
+ * the command register bits.
+ */
+
+#define DMUB_GPINT_DATA_PARAM_MASK 0xFFFF
+#define DMUB_GPINT_DATA_PARAM_SHIFT 0
+
+#define DMUB_GPINT_DATA_COMMAND_CODE_MASK 0xFFF
+#define DMUB_GPINT_DATA_COMMAND_CODE_SHIFT 16
+
+#define DMUB_GPINT_DATA_STATUS_MASK 0xF
+#define DMUB_GPINT_DATA_STATUS_SHIFT 28
+
+/**
+ * Command responses.
+ */
+
+#define DMUB_GPINT__STOP_FW_RESPONSE 0xDEADDEAD
+
+/**
+ * The register format for sending a command via the GPINT.
+ */
+union dmub_gpint_data_register {
+	struct {
+		uint32_t param : 16;
+		uint32_t command_code : 12;
+		uint32_t status : 4;
+	} bits;
+	uint32_t all;
+};
+
+/*
+ * Command IDs should be treated as stable ABI.
+ * Do not reuse or modify IDs.
+ */
+
+enum dmub_gpint_command {
+	DMUB_GPINT__INVALID_COMMAND = 0,
+	DMUB_GPINT__GET_FW_VERSION = 1,
+	DMUB_GPINT__STOP_FW = 2,
+	DMUB_GPINT__GET_PSR_STATE = 7,
+};
+
+//==============================================================================
+//</DMUB_GPINT>=================================================================
+//==============================================================================
+//< DMUB_CMD>===================================================================
+//==============================================================================
+
+#define DMUB_RB_CMD_SIZE 64
+#define DMUB_RB_MAX_ENTRY 128
+#define DMUB_RB_SIZE (DMUB_RB_CMD_SIZE * DMUB_RB_MAX_ENTRY)
+#define REG_SET_MASK 0xFFFF
+
 /*
  * Command IDs should be treated as stable ABI.
  * Do not reuse or modify IDs.
@@ -109,14 +277,12 @@ struct dmub_cmd_reg_field_update_sequence {
 };
 
 #define DMUB_REG_FIELD_UPDATE_SEQ__MAX		7
-
 struct dmub_rb_cmd_reg_field_update_sequence {
 	struct dmub_cmd_header header;
 	uint32_t addr;
 	struct dmub_cmd_reg_field_update_sequence seq[DMUB_REG_FIELD_UPDATE_SEQ__MAX];
 };
 
-
 /*
  * Burst write
  *
@@ -151,10 +317,6 @@ struct dmub_rb_cmd_reg_wait {
 	struct dmub_cmd_reg_wait_data reg_wait;
 };
 
-#ifndef PHYSICAL_ADDRESS_LOC
-#define PHYSICAL_ADDRESS_LOC union large_integer
-#endif
-
 struct dmub_cmd_PLAT_54186_wa {
 	uint32_t DCSURF_SURFACE_CONTROL;
 	uint32_t DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH;
@@ -218,6 +380,24 @@ struct dmub_rb_cmd_dpphy_init {
 	uint8_t reserved[60];
 };
 
+/*
+ * Command IDs should be treated as stable ABI.
+ * Do not reuse or modify IDs.
+ */
+
+enum dmub_cmd_psr_type {
+	DMUB_CMD__PSR_SET_VERSION		= 0,
+	DMUB_CMD__PSR_COPY_SETTINGS		= 1,
+	DMUB_CMD__PSR_ENABLE			= 2,
+	DMUB_CMD__PSR_DISABLE			= 3,
+	DMUB_CMD__PSR_SET_LEVEL			= 4,
+};
+
+enum psr_version {
+	PSR_VERSION_1				= 0,
+	PSR_VERSION_UNSUPPORTED			= 0xFFFFFFFF,
+};
+
 struct dmub_cmd_psr_copy_settings_data {
 	union dmub_psr_debug_flags debug;
 	uint16_t psr_level;
@@ -263,6 +443,50 @@ struct dmub_rb_cmd_psr_set_version {
 	struct dmub_cmd_psr_set_version_data psr_set_version_data;
 };
 
+enum dmub_cmd_abm_type {
+	DMUB_CMD__ABM_INIT_CONFIG	= 0,
+	DMUB_CMD__ABM_SET_PIPE		= 1,
+	DMUB_CMD__ABM_SET_BACKLIGHT	= 2,
+	DMUB_CMD__ABM_SET_LEVEL		= 3,
+	DMUB_CMD__ABM_SET_AMBIENT_LEVEL	= 4,
+	DMUB_CMD__ABM_SET_PWM_FRAC	= 5,
+};
+
+#define NUM_AMBI_LEVEL                  5
+#define NUM_AGGR_LEVEL                  4
+#define NUM_POWER_FN_SEGS               8
+#define NUM_BL_CURVE_SEGS               16
+
+/*
+ * Parameters for ABM2.4 algorithm.
+ * Padded explicitly to 32-bit boundary.
+ */
+struct abm_config_table {
+	/* Parameters for crgb conversion */
+	uint16_t crgb_thresh[NUM_POWER_FN_SEGS];                 // 0B
+	uint16_t crgb_offset[NUM_POWER_FN_SEGS];                 // 15B
+	uint16_t crgb_slope[NUM_POWER_FN_SEGS];                  // 31B
+
+	/* Parameters for custom curve */
+	uint16_t backlight_thresholds[NUM_BL_CURVE_SEGS];        // 47B
+	uint16_t backlight_offsets[NUM_BL_CURVE_SEGS];           // 79B
+
+	uint16_t ambient_thresholds_lux[NUM_AMBI_LEVEL];         // 111B
+	uint16_t min_abm_backlight;                              // 121B
+
+	uint8_t min_reduction[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];   // 123B
+	uint8_t max_reduction[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];   // 143B
+	uint8_t bright_pos_gain[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL]; // 163B
+	uint8_t dark_pos_gain[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];   // 183B
+	uint8_t hybrid_factor[NUM_AGGR_LEVEL];                   // 203B
+	uint8_t contrast_factor[NUM_AGGR_LEVEL];                 // 207B
+	uint8_t deviation_gain[NUM_AGGR_LEVEL];                  // 211B
+	uint8_t min_knee[NUM_AGGR_LEVEL];                        // 215B
+	uint8_t max_knee[NUM_AGGR_LEVEL];                        // 219B
+	uint8_t iir_curve[NUM_AMBI_LEVEL];                       // 223B
+	uint8_t pad3[3];                                         // 228B
+};
+
 struct dmub_cmd_abm_set_pipe_data {
 	uint8_t otg_inst;
 	uint8_t panel_inst;
@@ -348,4 +572,137 @@ union dmub_rb_cmd {
 
 #pragma pack(pop)
 
+
+//==============================================================================
+//</DMUB_CMD>===================================================================
+//==============================================================================
+//< DMUB_RB>====================================================================
+//==============================================================================
+
+#if defined(__cplusplus)
+extern "C" {
+#endif
+
+struct dmub_rb_init_params {
+	void *ctx;
+	void *base_address;
+	uint32_t capacity;
+	uint32_t read_ptr;
+	uint32_t write_ptr;
+};
+
+struct dmub_rb {
+	void *base_address;
+	uint32_t data_count;
+	uint32_t rptr;
+	uint32_t wrpt;
+	uint32_t capacity;
+
+	void *ctx;
+	void *dmub;
+};
+
+
+static inline bool dmub_rb_empty(struct dmub_rb *rb)
+{
+	return (rb->wrpt == rb->rptr);
+}
+
+static inline bool dmub_rb_full(struct dmub_rb *rb)
+{
+	uint32_t data_count;
+
+	if (rb->wrpt >= rb->rptr)
+		data_count = rb->wrpt - rb->rptr;
+	else
+		data_count = rb->capacity - (rb->rptr - rb->wrpt);
+
+	return (data_count == (rb->capacity - DMUB_RB_CMD_SIZE));
+}
+
+static inline bool dmub_rb_push_front(struct dmub_rb *rb,
+				      const union dmub_rb_cmd *cmd)
+{
+	uint64_t volatile *dst = (uint64_t volatile *)(rb->base_address) + rb->wrpt / sizeof(uint64_t);
+	const uint64_t *src = (const uint64_t *)cmd;
+	int i;
+
+	if (dmub_rb_full(rb))
+		return false;
+
+	// copying data
+	for (i = 0; i < DMUB_RB_CMD_SIZE / sizeof(uint64_t); i++)
+		*dst++ = *src++;
+
+	rb->wrpt += DMUB_RB_CMD_SIZE;
+
+	if (rb->wrpt >= rb->capacity)
+		rb->wrpt %= rb->capacity;
+
+	return true;
+}
+
+static inline bool dmub_rb_front(struct dmub_rb *rb,
+				 union dmub_rb_cmd  *cmd)
+{
+	uint8_t *rd_ptr = (uint8_t *)rb->base_address + rb->rptr;
+
+	if (dmub_rb_empty(rb))
+		return false;
+
+	dmub_memcpy(cmd, rd_ptr, DMUB_RB_CMD_SIZE);
+
+	return true;
+}
+
+static inline bool dmub_rb_pop_front(struct dmub_rb *rb)
+{
+	if (dmub_rb_empty(rb))
+		return false;
+
+	rb->rptr += DMUB_RB_CMD_SIZE;
+
+	if (rb->rptr >= rb->capacity)
+		rb->rptr %= rb->capacity;
+
+	return true;
+}
+
+static inline void dmub_rb_flush_pending(const struct dmub_rb *rb)
+{
+	uint32_t rptr = rb->rptr;
+	uint32_t wptr = rb->wrpt;
+
+	while (rptr != wptr) {
+		uint64_t volatile *data = (uint64_t volatile *)rb->base_address + rptr / sizeof(uint64_t);
+		//uint64_t volatile *p = (uint64_t volatile *)data;
+		uint64_t temp;
+		int i;
+
+		for (i = 0; i < DMUB_RB_CMD_SIZE / sizeof(uint64_t); i++)
+			temp = *data++;
+
+		rptr += DMUB_RB_CMD_SIZE;
+		if (rptr >= rb->capacity)
+			rptr %= rb->capacity;
+	}
+}
+
+static inline void dmub_rb_init(struct dmub_rb *rb,
+				struct dmub_rb_init_params *init_params)
+{
+	rb->base_address = init_params->base_address;
+	rb->capacity = init_params->capacity;
+	rb->rptr = init_params->read_ptr;
+	rb->wrpt = init_params->write_ptr;
+}
+
+#if defined(__cplusplus)
+}
+#endif
+
+//==============================================================================
+//</DMUB_RB>====================================================================
+//==============================================================================
+
 #endif /* _DMUB_CMD_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h
deleted file mode 100644
index 3ed77b6f0e44..000000000000
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h
+++ /dev/null
@@ -1,91 +0,0 @@
-/*
- * Copyright 2019 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- * Authors: AMD
- *
- */
-
-#ifndef _DMUB_CMD_DAL_H_
-#define _DMUB_CMD_DAL_H_
-
-#define NUM_AMBI_LEVEL                  5
-#define NUM_AGGR_LEVEL                  4
-#define NUM_POWER_FN_SEGS               8
-#define NUM_BL_CURVE_SEGS               16
-
-/*
- * Command IDs should be treated as stable ABI.
- * Do not reuse or modify IDs.
- */
-
-enum dmub_cmd_psr_type {
-	DMUB_CMD__PSR_SET_VERSION		= 0,
-	DMUB_CMD__PSR_COPY_SETTINGS		= 1,
-	DMUB_CMD__PSR_ENABLE			= 2,
-	DMUB_CMD__PSR_DISABLE			= 3,
-	DMUB_CMD__PSR_SET_LEVEL			= 4,
-};
-
-enum psr_version {
-	PSR_VERSION_1				= 0,
-	PSR_VERSION_UNSUPPORTED			= 0xFFFFFFFF,
-};
-
-enum dmub_cmd_abm_type {
-	DMUB_CMD__ABM_INIT_CONFIG	= 0,
-	DMUB_CMD__ABM_SET_PIPE		= 1,
-	DMUB_CMD__ABM_SET_BACKLIGHT	= 2,
-	DMUB_CMD__ABM_SET_LEVEL		= 3,
-	DMUB_CMD__ABM_SET_AMBIENT_LEVEL	= 4,
-	DMUB_CMD__ABM_SET_PWM_FRAC	= 5,
-};
-
-/*
- * Parameters for ABM2.4 algorithm.
- * Padded explicitly to 32-bit boundary.
- */
-struct abm_config_table {
-	/* Parameters for crgb conversion */
-	uint16_t crgb_thresh[NUM_POWER_FN_SEGS];                 // 0B
-	uint16_t crgb_offset[NUM_POWER_FN_SEGS];                 // 15B
-	uint16_t crgb_slope[NUM_POWER_FN_SEGS];                  // 31B
-
-	/* Parameters for custom curve */
-	uint16_t backlight_thresholds[NUM_BL_CURVE_SEGS];        // 47B
-	uint16_t backlight_offsets[NUM_BL_CURVE_SEGS];           // 79B
-
-	uint16_t ambient_thresholds_lux[NUM_AMBI_LEVEL];         // 111B
-	uint16_t min_abm_backlight;                              // 121B
-
-	uint8_t min_reduction[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];   // 123B
-	uint8_t max_reduction[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];   // 143B
-	uint8_t bright_pos_gain[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL]; // 163B
-	uint8_t dark_pos_gain[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];   // 183B
-	uint8_t hybrid_factor[NUM_AGGR_LEVEL];                   // 203B
-	uint8_t contrast_factor[NUM_AGGR_LEVEL];                 // 207B
-	uint8_t deviation_gain[NUM_AGGR_LEVEL];                  // 211B
-	uint8_t min_knee[NUM_AGGR_LEVEL];                        // 215B
-	uint8_t max_knee[NUM_AGGR_LEVEL];                        // 219B
-	uint8_t iir_curve[NUM_AMBI_LEVEL];                       // 223B
-	uint8_t pad3[3];                                         // 228B
-};
-
-#endif /* _DMUB_CMD_DAL_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_vbios.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_vbios.h
deleted file mode 100644
index b6deb8e2590f..000000000000
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_vbios.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * Copyright 2019 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- * Authors: AMD
- *
- */
-
-#ifndef _DMUB_CMD_VBIOS_H_
-#define _DMUB_CMD_VBIOS_H_
-
-/*
- * Command IDs should be treated as stable ABI.
- * Do not reuse or modify IDs.
- */
-
-enum dmub_cmd_vbios_type {
-	DMUB_CMD__VBIOS_DIGX_ENCODER_CONTROL = 0,
-	DMUB_CMD__VBIOS_DIG1_TRANSMITTER_CONTROL = 1,
-	DMUB_CMD__VBIOS_SET_PIXEL_CLOCK = 2,
-	DMUB_CMD__VBIOS_ENABLE_DISP_POWER_GATING = 3,
-};
-
-#endif /* _DMUB_CMD_VBIOS_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_fw_meta.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_fw_meta.h
deleted file mode 100644
index b657c51c9ac9..000000000000
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_fw_meta.h
+++ /dev/null
@@ -1,65 +0,0 @@
-/*
- * Copyright 2019 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- * Authors: AMD
- *
- */
-#ifndef _DMUB_META_H_
-#define _DMUB_META_H_
-
-#include "dmub_types.h"
-
-#pragma pack(push, 1)
-
-/* Magic value for identifying dmub_fw_meta_info */
-#define DMUB_FW_META_MAGIC 0x444D5542
-
-/* Offset from the end of the file to the dmub_fw_meta_info */
-#define DMUB_FW_META_OFFSET 0x24
-
-/**
- * struct dmub_fw_meta_info - metadata associated with fw binary
- *
- * NOTE: This should be considered a stable API. Fields should
- *       not be repurposed or reordered. New fields should be
- *       added instead to extend the structure.
- *
- * @magic_value: magic value identifying DMUB firmware meta info
- * @fw_region_size: size of the firmware state region
- * @trace_buffer_size: size of the tracebuffer region
- * @fw_version: the firmware version information
- */
-struct dmub_fw_meta_info {
-	uint32_t magic_value;
-	uint32_t fw_region_size;
-	uint32_t trace_buffer_size;
-	uint32_t fw_version;
-};
-
-/* Ensure that the structure remains 64 bytes. */
-union dmub_fw_meta {
-	struct dmub_fw_meta_info info;
-	uint8_t reserved[64];
-};
-
-#pragma pack(pop)
-
-#endif /* _DMUB_META_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_gpint_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_gpint_cmd.h
deleted file mode 100644
index 652d6fc061b6..000000000000
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_gpint_cmd.h
+++ /dev/null
@@ -1,75 +0,0 @@
-/*
- * Copyright 2019 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- * Authors: AMD
- *
- */
-
-#ifndef _DMUB_GPINT_CMD_H_
-#define _DMUB_GPINT_CMD_H_
-
-#include "dmub_types.h"
-
-/**
- * The register format for sending a command via the GPINT.
- */
-union dmub_gpint_data_register {
-	struct {
-		uint32_t param : 16;
-		uint32_t command_code : 12;
-		uint32_t status : 4;
-	} bits;
-	uint32_t all;
-};
-
-/**
- * The shifts and masks below may alternatively be used to format and read
- * the command register bits.
- */
-
-#define DMUB_GPINT_DATA_PARAM_MASK 0xFFFF
-#define DMUB_GPINT_DATA_PARAM_SHIFT 0
-
-#define DMUB_GPINT_DATA_COMMAND_CODE_MASK 0xFFF
-#define DMUB_GPINT_DATA_COMMAND_CODE_SHIFT 16
-
-#define DMUB_GPINT_DATA_STATUS_MASK 0xF
-#define DMUB_GPINT_DATA_STATUS_SHIFT 28
-
-/*
- * Command IDs should be treated as stable ABI.
- * Do not reuse or modify IDs.
- */
-
-enum dmub_gpint_command {
-	DMUB_GPINT__INVALID_COMMAND = 0,
-	DMUB_GPINT__GET_FW_VERSION = 1,
-	DMUB_GPINT__STOP_FW = 2,
-	DMUB_GPINT__GET_PSR_STATE = 7,
-};
-
-/**
- * Command responses.
- */
-
-#define DMUB_GPINT__STOP_FW_RESPONSE 0xDEADDEAD
-
-#endif /* _DMUB_GPINT_CMD_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_rb.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_rb.h
deleted file mode 100644
index 31f471f549a6..000000000000
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_rb.h
+++ /dev/null
@@ -1,154 +0,0 @@
-/*
- * Copyright 2019 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- * Authors: AMD
- *
- */
-
-#ifndef _DMUB_RB_H_
-#define _DMUB_RB_H_
-
-#include "dmub_types.h"
-#include "dmub_cmd.h"
-
-#if defined(__cplusplus)
-extern "C" {
-#endif
-
-struct dmub_rb_init_params {
-	void *ctx;
-	void *base_address;
-	uint32_t capacity;
-	uint32_t read_ptr;
-	uint32_t write_ptr;
-};
-
-struct dmub_rb {
-	void *base_address;
-	uint32_t data_count;
-	uint32_t rptr;
-	uint32_t wrpt;
-	uint32_t capacity;
-
-	void *ctx;
-	void *dmub;
-};
-
-
-static inline bool dmub_rb_empty(struct dmub_rb *rb)
-{
-	return (rb->wrpt == rb->rptr);
-}
-
-static inline bool dmub_rb_full(struct dmub_rb *rb)
-{
-	uint32_t data_count;
-
-	if (rb->wrpt >= rb->rptr)
-		data_count = rb->wrpt - rb->rptr;
-	else
-		data_count = rb->capacity - (rb->rptr - rb->wrpt);
-
-	return (data_count == (rb->capacity - DMUB_RB_CMD_SIZE));
-}
-
-static inline bool dmub_rb_push_front(struct dmub_rb *rb,
-				      const union dmub_rb_cmd *cmd)
-{
-	uint64_t volatile *dst = (uint64_t volatile *)(rb->base_address) + rb->wrpt / sizeof(uint64_t);
-	const uint64_t *src = (const uint64_t *)cmd;
-	int i;
-
-	if (dmub_rb_full(rb))
-		return false;
-
-	// copying data
-	for (i = 0; i < DMUB_RB_CMD_SIZE / sizeof(uint64_t); i++)
-		*dst++ = *src++;
-
-	rb->wrpt += DMUB_RB_CMD_SIZE;
-
-	if (rb->wrpt >= rb->capacity)
-		rb->wrpt %= rb->capacity;
-
-	return true;
-}
-
-static inline bool dmub_rb_front(struct dmub_rb *rb,
-				 union dmub_rb_cmd  *cmd)
-{
-	uint8_t *rd_ptr = (uint8_t *)rb->base_address + rb->rptr;
-
-	if (dmub_rb_empty(rb))
-		return false;
-
-	dmub_memcpy(cmd, rd_ptr, DMUB_RB_CMD_SIZE);
-
-	return true;
-}
-
-static inline bool dmub_rb_pop_front(struct dmub_rb *rb)
-{
-	if (dmub_rb_empty(rb))
-		return false;
-
-	rb->rptr += DMUB_RB_CMD_SIZE;
-
-	if (rb->rptr >= rb->capacity)
-		rb->rptr %= rb->capacity;
-
-	return true;
-}
-
-static inline void dmub_rb_flush_pending(const struct dmub_rb *rb)
-{
-	uint32_t rptr = rb->rptr;
-	uint32_t wptr = rb->wrpt;
-
-	while (rptr != wptr) {
-		uint64_t volatile *data = (uint64_t volatile *)rb->base_address + rptr / sizeof(uint64_t);
-		//uint64_t volatile *p = (uint64_t volatile *)data;
-		uint64_t temp;
-		int i;
-
-		for (i = 0; i < DMUB_RB_CMD_SIZE / sizeof(uint64_t); i++)
-			temp = *data++;
-
-		rptr += DMUB_RB_CMD_SIZE;
-		if (rptr >= rb->capacity)
-			rptr %= rb->capacity;
-	}
-}
-
-static inline void dmub_rb_init(struct dmub_rb *rb,
-				struct dmub_rb_init_params *init_params)
-{
-	rb->base_address = init_params->base_address;
-	rb->capacity = init_params->capacity;
-	rb->rptr = init_params->read_ptr;
-	rb->wrpt = init_params->write_ptr;
-}
-
-#if defined(__cplusplus)
-}
-#endif
-
-#endif /* _DMUB_RB_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_types.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_types.h
deleted file mode 100644
index f61af26fc73e..000000000000
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_types.h
+++ /dev/null
@@ -1,78 +0,0 @@
-/*
- * Copyright 2019 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- * Authors: AMD
- *
- */
-
-#ifndef _DMUB_TYPES_H_
-#define _DMUB_TYPES_H_
-
-/* Basic type definitions. */
-#include <asm/byteorder.h>
-#include <linux/types.h>
-#include <linux/string.h>
-#include <linux/delay.h>
-#include <stdarg.h>
-
-#if defined(__cplusplus)
-extern "C" {
-#endif
-
-#ifndef dmub_memcpy
-#define dmub_memcpy(dest, source, bytes) memcpy((dest), (source), (bytes))
-#endif
-
-#ifndef dmub_memset
-#define dmub_memset(dest, val, bytes) memset((dest), (val), (bytes))
-#endif
-
-#ifndef dmub_udelay
-#define dmub_udelay(microseconds) udelay(microseconds)
-#endif
-
-/* Maximum number of streams on any ASIC. */
-#define DMUB_MAX_STREAMS 6
-
-/* Maximum number of planes on any ASIC. */
-#define DMUB_MAX_PLANES 6
-
-union dmub_addr {
-	struct {
-		uint32_t low_part;
-		uint32_t high_part;
-	} u;
-	uint64_t quad_part;
-};
-
-union dmub_psr_debug_flags {
-	struct {
-		uint8_t visual_confirm : 1;
-	} bitfields;
-
-	unsigned int u32All;
-};
-
-#if defined(__cplusplus)
-}
-#endif
-
-#endif /* _DMUB_TYPES_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
index 7f046c73927e..a316f260f6ac 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
@@ -26,7 +26,7 @@
 #ifndef _DMUB_DCN20_H_
 #define _DMUB_DCN20_H_
 
-#include "../inc/dmub_types.h"
+#include "../inc/dmub_cmd.h"
 
 struct dmub_srv;
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.h
index c1f4030929a4..96603d07c23d 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.h
@@ -26,7 +26,7 @@
 #ifndef _DMUB_REG_H_
 #define _DMUB_REG_H_
 
-#include "../inc/dmub_types.h"
+#include "../inc/dmub_cmd.h"
 
 struct dmub_srv;
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index f50fc8a3344f..6bc65801a598 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -26,7 +26,7 @@
 #include "../dmub_srv.h"
 #include "dmub_dcn20.h"
 #include "dmub_dcn21.h"
-#include "dmub_fw_meta.h"
+#include "dmub_cmd.h"
 #include "os_types.h"
 /*
  * Note: the DMUB service is standalone. No additional headers should be
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index dbfdeed0b6e6..fe22dd223408 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -27,7 +27,7 @@
 #include "dc/inc/hw/abm.h"
 #include "dc.h"
 #include "core_types.h"
-#include "dmub_cmd_dal.h"
+#include "dmub_cmd.h"
 
 #define DIV_ROUNDUP(a, b) (((a)+((b)/2))/(b))
 #define bswap16_based_on_endian(big_endian, value) \
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
