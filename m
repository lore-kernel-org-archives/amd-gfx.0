Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C01CD98C7
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 09:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BECF10E894;
	Wed, 10 Jun 2026 09:52:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4XQpbzNi";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013061.outbound.protection.outlook.com
 [40.93.196.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D0D610E894
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 09:52:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSYjnLAokCKfRiqgPu33bDJ5A5DYh+IV2mNtFlXlZLjaB5E7WaprWFiJqWUaAdA6JADnt7yzPL7+yrL/y6yk8xrltVnXiGcjhU5IV+zdDCi3CKHkx+A5rlQTkeVPGb7TmTiP+xbb9hCWc1+oJqyCjZEiiuvPfthlpIb+qt5AYVZs+zam8JkvwCz0YWYDhvFZiDHt9ml2ekySmUJy5cVHkkKdl7LrgtZHhnhQ9idmG0RVCpnDC3vb1HXBYYU3lOS6O1jho9VcI7h+6U69C2T2azhQxqBB28R7iXewGDRPyQp7mX1h2Lmkuno6OTxk62gcQB4HuTDk+YsP0scJjrVoBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjxim8+qXXO1/7tmdNZmd0rvKhzaqkGWKCkHYUUEpgg=;
 b=GO2MRfq4HGILKh2qXAQuB3adunPZ68v/b7oOmrXUQQSpUe62Nhg5kLXy2OFZK0ZcTNT9SpVOedmG4g5bC6EhotGezz7oZflc/D8r+TR4Y96xIq/MRBOlor9SC7xY821DxVbsEBMtKSlrYTD5j6mAsAGNhqijXv08d2AktprUrVqh++Aegw8Za6UvsiwfoFs6eexEaGbVyRbg7CMToRT8uTAIrCvahoGX2eH2jnwVOCo+/rAwP4UmBtp3anlwYtISPBYjQ6g1i3zxNYQYy9j3Npq5nkiYQXah/MZI2fqy4HFYpM7qrYTZmOFw8cljxgrAsHEtGhZqllBSsOfkrdEUPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjxim8+qXXO1/7tmdNZmd0rvKhzaqkGWKCkHYUUEpgg=;
 b=4XQpbzNiSjDuZ2d/4KFaOPpN7YgMqckMQxPYnILKL0A2sMdugij9RX4RRcyYRAZe8K8DOBzGaxNjMorozGHmoJT6lkRQJdVn1vi4zlBIIZ/gkQrITy5ThrJJXnPXHYyUhS/qSMulcYPChr7BGIVie90W/9M9qzGwP2DYASSlCfA=
Received: from SA9PR13CA0048.namprd13.prod.outlook.com (2603:10b6:806:22::23)
 by BN7PPF62A0C9A68.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 09:52:42 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::2f) by SA9PR13CA0048.outlook.office365.com
 (2603:10b6:806:22::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7 via Frontend Transport; Wed, 10
 Jun 2026 09:52:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 09:52:42 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:52:42 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 02:52:42 -0700
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 04:52:33 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 31/32] drm/amd/display: [FW Promotion] Release 0.1.63.0
Date: Wed, 10 Jun 2026 17:45:15 +0800
Message-ID: <20260610094639.1965367-32-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610094639.1965367-1-chen-yu.chen@amd.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|BN7PPF62A0C9A68:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c486158-1b59-41bd-56e1-08dec6d60425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|22082099003|18002099003|3023799007|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: i/DlB3eplZKE4JvyNpOL1WImsunHNC4c/Pr8JJtx4touv/Pkzk+Lhaq3bN8u73WExn+vsC9i1/Y78GV9VxfMnVLDTghPtmQIk1FCOljVYYde5TuIGYVbaDohT497szsUi3q8Vs3HsGFYtsw5IohPsT9WukZxF3SnUP3WZIKVc7BynT09Ot4gn9zi8oBAodapfyaf53IcRd58A98SjSGElUEV3WhUJ0YLTtl5RHh5ljjJmiO/sOW2SwF6VQ5xoZAkh9TKOqYsI9G4fIksZoidwZlOfmN9C1txSQ/4HXV5ZIHpcxBz6GPnjjhmTVJk2olnMO/J4oC4teaPoc+QjWOTip28Cuy4cb1odR5dTMiah9Zh+bdebsjrGIEJzDZrry0gD0n2hil3Ie9YbqGKHaIbcIe1lb4lv8dI9gtYgSRgWmetpb8bsWyOldvOIFHqOFrbjIzdN3w0i89ZVIVmN/nY5it7qbogLcjNAOQWTQSljG4n/9+Npu6bujbeOuIsJWaIRETBD4dxKl4NLIJVla5UjgVr//1An09m1vK3IdUuGTaDgcLAqRm6jSNatFA+hb6t27717LQhGg3XXdQYRKpo7SWZQe1PjKS7ogI9YoKpkUown2iktdbGgzgIyqYQD+4KMkl9F5v1s19IUZ+KaoxiWYPWCZPHgI45HGaCFiDBvxsC7n0NAMK70BZTBlTrZmaaUF3JjdHhZR7ykMaXPHx7j+B/R4UlL54UP8qYyCrjbuo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(22082099003)(18002099003)(3023799007)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vzIRlXR9X77cJm3nQdaEaK34QsyARqeeIrBWBCI3eVRa6GKxiCqiyr4X+9czakFGy6FCi1CmL6rjkUTeWrTpf/q77DxyDhAC+H98gSKcOs+Ls+qfGqZjURAE7HlUX2R/fG2LrDtdrtujGofxzAH2z45BHhrh05AU4Axv5xiOLgP4W3igQVi4l+ze9C8Q0J/1AZfU3hE/8mOQTnPS8jVYegRdApjbUiq/xhN3a9gIxfpokOCDwgd4BspSOsF1eE48ZClyzDWsgS9APjgGpJNgnCyKamEB9+fLDbRMaCNGWuJZQrltwepk6jB3mKZJ8Pjs4E43fI9MWPN7M6vbBNlYezZsJH5RkzDquJmP+nlq/blvtIm01R3Gtxfh/RKfKnxwGeJWXcxYzJA3XvBLBPP8iqcx+0XU/lPPS4X1PKomGE/u1ONZZiEFIEHvGlF24WTd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:52:42.7694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c486158-1b59-41bd-56e1-08dec6d60425
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF62A0C9A68
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

From: Taimur Hassan <Syed.Hassan@amd.com>

[Why & How]
Add some CACP command and remove some unused struct and enum.

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 178 ++++--------------
 1 file changed, 35 insertions(+), 143 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 6f6a59a23495..57f30be6bc9c 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1800,28 +1800,13 @@ enum dmub_inbox0_command {
  *
  * Command IDs should be treated as stable ABI.
  * Do not reuse or modify IDs.
+ * Note that command IDs 1-4 have been deprecated.
  */
 enum dmub_cmd_type {
 	/**
 	 * Invalid command.
 	 */
 	DMUB_CMD__NULL = 0,
-	/**
-	 * Read modify write register sequence offload.
-	 */
-	DMUB_CMD__REG_SEQ_READ_MODIFY_WRITE = 1,
-	/**
-	 * Field update register sequence offload.
-	 */
-	DMUB_CMD__REG_SEQ_FIELD_UPDATE_SEQ = 2,
-	/**
-	 * Burst write sequence offload.
-	 */
-	DMUB_CMD__REG_SEQ_BURST_WRITE = 3,
-	/**
-	 * Reg wait sequence offload.
-	 */
-	DMUB_CMD__REG_REG_WAIT = 4,
 	/**
 	 * Workaround to avoid HUBP underflow during NV12 playback.
 	 */
@@ -2041,98 +2026,6 @@ struct dmub_cmd_header {
 	unsigned int reserved1 : 2; /**< reserved bits */
 };
 
-/*
- * struct dmub_cmd_read_modify_write_sequence - Read modify write
- *
- * 60 payload bytes can hold up to 5 sets of read modify writes,
- * each take 3 dwords.
- *
- * number of sequences = header.payload_bytes / sizeof(struct dmub_cmd_read_modify_write_sequence)
- *
- * modify_mask = 0xffff'ffff means all fields are going to be updated.  in this case
- * command parser will skip the read and we can use modify_mask = 0xffff'ffff as reg write
- */
-struct dmub_cmd_read_modify_write_sequence {
-	uint32_t addr; /**< register address */
-	uint32_t modify_mask; /**< modify mask */
-	uint32_t modify_value; /**< modify value */
-};
-
-/**
- * Maximum number of ops in read modify write sequence.
- */
-#define DMUB_READ_MODIFY_WRITE_SEQ__MAX 5
-
-/**
- * struct dmub_cmd_read_modify_write_sequence - Read modify write command.
- */
-struct dmub_rb_cmd_read_modify_write {
-	struct dmub_cmd_header header;  /**< command header */
-	/**
-	 * Read modify write sequence.
-	 */
-	struct dmub_cmd_read_modify_write_sequence seq[DMUB_READ_MODIFY_WRITE_SEQ__MAX];
-};
-
-/*
- * Update a register with specified masks and values sequeunce
- *
- * 60 payload bytes can hold address + up to 7 sets of mask/value combo, each take 2 dword
- *
- * number of field update sequence = (header.payload_bytes - sizeof(addr)) / sizeof(struct read_modify_write_sequence)
- *
- *
- * USE CASE:
- *   1. auto-increment register where additional read would update pointer and produce wrong result
- *   2. toggle a bit without read in the middle
- */
-
-struct dmub_cmd_reg_field_update_sequence {
-	uint32_t modify_mask; /**< 0xffff'ffff to skip initial read */
-	uint32_t modify_value; /**< value to update with */
-};
-
-/**
- * Maximum number of ops in field update sequence.
- */
-#define DMUB_REG_FIELD_UPDATE_SEQ__MAX 7
-
-/**
- * struct dmub_rb_cmd_reg_field_update_sequence - Field update command.
- */
-struct dmub_rb_cmd_reg_field_update_sequence {
-	struct dmub_cmd_header header; /**< command header */
-	uint32_t addr; /**< register address */
-	/**
-	 * Field update sequence.
-	 */
-	struct dmub_cmd_reg_field_update_sequence seq[DMUB_REG_FIELD_UPDATE_SEQ__MAX];
-};
-
-
-/**
- * Maximum number of burst write values.
- */
-#define DMUB_BURST_WRITE_VALUES__MAX  14
-
-/*
- * struct dmub_rb_cmd_burst_write - Burst write
- *
- * support use case such as writing out LUTs.
- *
- * 60 payload bytes can hold up to 14 values to write to given address
- *
- * number of payload = header.payload_bytes / sizeof(struct read_modify_write_sequence)
- */
-struct dmub_rb_cmd_burst_write {
-	struct dmub_cmd_header header; /**< command header */
-	uint32_t addr; /**< register start address */
-	/**
-	 * Burst write register values.
-	 */
-	uint32_t write_values[DMUB_BURST_WRITE_VALUES__MAX];
-};
-
 /**
  * struct dmub_rb_cmd_common - Common command header
  */
@@ -2144,24 +2037,6 @@ struct dmub_rb_cmd_common {
 	uint8_t cmd_buffer[DMUB_RB_CMD_SIZE - sizeof(struct dmub_cmd_header)];
 };
 
-/**
- * struct dmub_cmd_reg_wait_data - Register wait data
- */
-struct dmub_cmd_reg_wait_data {
-	uint32_t addr; /**< Register address */
-	uint32_t mask; /**< Mask for register bits */
-	uint32_t condition_field_value; /**< Value to wait for */
-	uint32_t time_out_us; /**< Time out for reg wait in microseconds */
-};
-
-/**
- * struct dmub_rb_cmd_reg_wait - Register wait command
- */
-struct dmub_rb_cmd_reg_wait {
-	struct dmub_cmd_header header; /**< Command header */
-	struct dmub_cmd_reg_wait_data reg_wait; /**< Register wait data */
-};
-
 /**
  * struct dmub_cmd_PLAT_54186_wa - Underflow workaround
  *
@@ -6439,10 +6314,43 @@ struct dmub_cmd_cacp_set_backlight_data {
 	 */
 	uint8_t panel_mask;
 
+	/**
+	 * AUX HW Instance.
+	 */
+	uint8_t aux_inst;
+
 	/**
 	 * Explicit padding to 4 byte boundary.
 	 */
-	uint8_t pad[2];
+	uint8_t pad[1];
+
+	/**
+	 * Backlight control type.
+	 * Value 0 is PWM backlight control.
+	 * Value 1 is VAUX backlight control.
+	 * Value 2 is AMD DPCD AUX backlight control.
+	 */
+	enum dmub_backlight_control_type backlight_control_type;
+
+	/**
+	 * Minimum luminance in nits.
+	 */
+	uint32_t min_luminance;
+
+	/**
+	 * Maximum luminance in nits.
+	 */
+	uint32_t max_luminance;
+
+	/**
+	 * Minimum backlight in pwm.
+	 */
+	uint32_t min_backlight_pwm;
+
+	/**
+	 * Maximum backlight in pwm.
+	 */
+	uint32_t max_backlight_pwm;
 };
 
 /**
@@ -7362,22 +7270,6 @@ union dmub_rb_cmd {
 	 * Elements shared with all commands.
 	 */
 	struct dmub_rb_cmd_common cmd_common;
-	/**
-	 * Definition of a DMUB_CMD__REG_SEQ_READ_MODIFY_WRITE command.
-	 */
-	struct dmub_rb_cmd_read_modify_write read_modify_write;
-	/**
-	 * Definition of a DMUB_CMD__REG_SEQ_FIELD_UPDATE_SEQ command.
-	 */
-	struct dmub_rb_cmd_reg_field_update_sequence reg_field_update_seq;
-	/**
-	 * Definition of a DMUB_CMD__REG_SEQ_BURST_WRITE command.
-	 */
-	struct dmub_rb_cmd_burst_write burst_write;
-	/**
-	 * Definition of a DMUB_CMD__REG_REG_WAIT command.
-	 */
-	struct dmub_rb_cmd_reg_wait reg_wait;
 	/**
 	 * Definition of a DMUB_CMD__VBIOS_DIGX_ENCODER_CONTROL command.
 	 */
-- 
2.43.0

