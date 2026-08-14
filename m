Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4170FC5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AA8F10F720;
	Fri, 14 Aug 2026 21:03:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u+wsrZ4f";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F9B110F70C
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIfjynexOaODwzaSn9PkqULvG+UW8UmGtj/9rC/O7gQWjvact1aiOqMIX6R3nUvnY60sC2Fh/ti4PhOmtRvoSgC7b5e/utb1LYJcrdxrH8chsPoDf/FmQ/ZZ7N7Q/X9GOYYkR++iJ4ppHQPW/IVN44Kr0WbeuhHGRdS62kHpQ4ug4Oaiew1VOBYFA+CbrXv2L5zEXDjcXDhjUV5QLL3QZqmic3izDhnR4FniwEk5q94mQMxZfEQvMckJiCn9xJ2tqjmJpU1K6P+GFpl/T2kctA8SaxPfKDazqsdh5JyTR20CBGdfwVavDPX1wwPnc1ZJhBczi2MFazXU13jxFKrMJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+mLqPJa8ZPLbgjHV3uA/7/aLz/9hih5WB21iQFkHVw=;
 b=hw25LFl8mQj0m6CCfpW5jz5id33UUzDTIfAtTmeTlt2RFRvNBp+ytiwuVjlOT5VEqN5D7Po+t8Xk3iAMimYy4qSYibRtJanrnQ12YRBaPTlzoJAjZa0Pq4rIfWivDa9+PJjyw64zofvCPM17h+8buL3ZWtPlLDdhRAhL5cHxz3C2nVctGKPoDuWXuuhDSboXDgOIrO5rkK81xCVKvz2E9Y2ZkHV96VGejOBi0cKoJUWE/aTZ+qSguOFoStnGIaJ1nfGUSSU0dSGGFG0JTKX3Mlv4aBaUL7zD6UnxPFZDe8zcE8iwgSpkRHUzm/g0CYXHVcrkL5S+/dsTJgp70pj2QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+mLqPJa8ZPLbgjHV3uA/7/aLz/9hih5WB21iQFkHVw=;
 b=u+wsrZ4fM/x26qS4/+RhFqLd+fLnLWuI8v8rq6sny6I2dkYRk4QjxaIHjyRGjdF5Xz5cVPigTQs5i9mEbjTbfQvYT+DhX+MzIRg5PWCl1UAoPDXmUTv3W4MQPSoCTOXSnVVnXRPrstEANC5nCXsJgvRZ48QYPOteZ+wtck88pr0=
Received: from DS7PR03CA0326.namprd03.prod.outlook.com (2603:10b6:8:2b::28) by
 DS5PPF5A66AFD1C.namprd12.prod.outlook.com (2603:10b6:f:fc00::64d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:35 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:8:2b:cafe::65) by DS7PR03CA0326.outlook.office365.com
 (2603:10b6:8:2b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:28 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:26 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 048/109] drm/amd/ras: preload and handle bad pages at boot time
Date: Fri, 14 Aug 2026 17:01:45 -0400
Message-ID: <20260814210246.3067612-49-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|DS5PPF5A66AFD1C:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e72c7f0-8f7e-4d1b-ef8a-08defa47819d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|56012099006|10067099003|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 1mOrC5m1fFR1RjtMfTiXNFlmFsAC/fpUiDF70DaonLh9dwMgS0pLjTL6bNxL6Nm2uoxURPoZ1a3YMkGffm2PXQk/ugyiWJ8uaPLHFb1/WrmBN63DLJox/MBkHXbZbuelDDEzdp/0RQA2TR1D/+pzHA2FiCza3rNYLCnb/lK0CRkstydGhERNDGhSNMy3NvqeH1fA4vKXMTYjBH2vcIrUkRLVZ5jfV9tUebsZzW6hVxGUHDqihii/h8uW1QwpbLxtLXlIT/dLjDD1Z/yOq0kzIsPV+QpCpzmcahl5fUWQs9k/H+CD9K75icyxC66R8+EVF31ScGJDacTGR5Sr3ltmgq9STuIh7w4ZwAuITR7AlI+WnLsGjGpwruaBQ5d+bBfNEnDQbXkQHMXr/9IzVAW7rabkrvmXlbWF8Qe09LRKvwDm1kyFZpyku59HLz7SqzLC1MJ76XlIUD2Q1zBjRfXRfodm1IazCETbP12yrTA5PZA1mnUXNiC7OyiQO61pAEdVkEXlHBV3+RmimFRra1CseS1lAnq0cVSHKbr7xrnLV6CjdY2zUNJElSsKCA0s8tP0lUYiGEqXDNBWuYOiqVfdEYiGEX8I3idvTRqCWhXre5l/QwsFRkMvkHfPH9orbvz2yMUHHnLr82Re0Y4/GOSGG2l7ocviOlVv/x29FeN51tg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: abtgbhn9sJJ4GxnK3nBfvf0SY6ID2rQ+noMGgkANGFyzhMNSBFy9gaOgyvmH4wc0C10PD2veeK5WD12d1BCAFSWNqSAzwLrajPIjTxDa+uNDd3MpN8pr90hO6fOFBGnGSnOYhQ6JSENGImLmPg6LnH0957VzZ2GGpZmU7hZCrnGBYPvmr4BnNAFhTcGx5pTLX82t0BKzSAiL2AO5XjY470AQarcLcNqc7Upy3q9E1yd3HD4bJZJXIXcIXd/T/TeG6SszdhWEaIEwZmuTAdiWQc0rDyuiwS66WUs6xp4zN9sG1QXTKJqbK7zF4pknil+ScrScVtbCaCzE2HvGYFvI6nVx0dDuRNq0cXK3PA4W0bQ1bXR0k+hplxvfkidRedFA9GVVxTYG3OXDZSZbQ18IBn4M6dE64NRdkOA+I8nsviBjxVCCwLuP46ibEwkv9Vnv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:35.6877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e72c7f0-8f7e-4d1b-ef8a-08defa47819d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5A66AFD1C
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Preload bad pages occur during the sw_init stage, so
the preload-related code in RAS module must be moved
to sw_init for proper initialization.

v2:
  Rename functions and variables.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/core.c           | 54 ++++++++++++++-----
 drivers/gpu/drm/amd/ras/core/eeprom.c         | 27 ++++++----
 drivers/gpu/drm/amd/ras/core/ras.h            |  7 +++
 drivers/gpu/drm/amd/ras/core/ras_mp1.c        |  7 ++-
 drivers/gpu/drm/amd/ras/core/ras_mp1.h        |  4 +-
 drivers/gpu/drm/amd/ras/core/ras_umc.c        | 17 +++---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  | 25 +++++++++
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h  |  1 +
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c  | 22 ++++++++
 9 files changed, 132 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/core.c b/drivers/gpu/drm/amd/ras/core/core.c
index fc399192713ec..8a8f5134fdac7 100644
--- a/drivers/gpu/drm/amd/ras/core/core.c
+++ b/drivers/gpu/drm/amd/ras/core/core.c
@@ -331,6 +331,12 @@ int ras_core_sw_init(struct ras_core_context *ras_core)
 		return -EINVAL;
 	}
 
+	ras_core->ras_eeprom_supported = ras_core->config->ras_eeprom_supported;
+	ras_core->poison_supported = ras_core->config->poison_supported;
+	ras_core->early_init_service_enabled = ras_core->config->early_init_service_supported;
+
+	ras_core->in_early_init = true;
+
 	ras_core->sys_fn = ras_core->config->sys_fn;
 	if (!ras_core->sys_fn)
 		return -EINVAL;
@@ -367,6 +373,14 @@ int ras_core_sw_init(struct ras_core_context *ras_core)
 	if (ret)
 		return ret;
 
+	ret = ras_mp1_sw_init(ras_core);
+	if (ret)
+		return ret;
+
+	ret = ras_eeprom_mgr_sw_init(ras_core);
+	if (ret)
+		return ret;
+
 	ret = ras_mce_sw_init(ras_core);
 	if (ret)
 		return ret;
@@ -383,7 +397,9 @@ int ras_core_sw_fini(struct ras_core_context *ras_core)
 	ras_log_ring_sw_fini(ras_core);
 	ras_cmd_fini(ras_core);
 	ras_umc_sw_fini(ras_core);
+	ras_mp1_sw_fini(ras_core);
 	ras_aca_sw_fini(ras_core);
+	ras_eeprom_mgr_sw_fini(ras_core);
 	ras_mce_sw_fini(ras_core);
 
 	return 0;
@@ -393,11 +409,6 @@ int ras_core_hw_init(struct ras_core_context *ras_core)
 {
 	int ret;
 
-	ras_core->ras_eeprom_supported =
-			ras_core->config->ras_eeprom_supported;
-
-	ras_core->poison_supported = ras_core->config->poison_supported;
-
 	ret = ras_psp_hw_init(ras_core);
 	if (ret)
 		return ret;
@@ -406,10 +417,6 @@ int ras_core_hw_init(struct ras_core_context *ras_core)
 	if (ret)
 		goto init_err1;
 
-	ret = ras_mp1_hw_init(ras_core);
-	if (ret)
-		goto init_err2;
-
 	ret = ras_nbio_hw_init(ras_core);
 	if (ret)
 		goto init_err3;
@@ -426,6 +433,8 @@ int ras_core_hw_init(struct ras_core_context *ras_core)
 	if (ret)
 		goto init_err6;
 
+	ras_core->in_early_init = false;
+
 	ret = ras_core_eeprom_recovery(ras_core);
 	if (ret) {
 		RAS_DEV_ERR(ras_core->dev,
@@ -450,8 +459,6 @@ int ras_core_hw_init(struct ras_core_context *ras_core)
 init_err4:
 	ras_nbio_hw_fini(ras_core);
 init_err3:
-	ras_mp1_hw_fini(ras_core);
-init_err2:
 	ras_aca_hw_fini(ras_core);
 init_err1:
 	ras_psp_hw_fini(ras_core);
@@ -467,7 +474,6 @@ int ras_core_hw_fini(struct ras_core_context *ras_core)
 	ras_gfx_hw_fini(ras_core);
 	ras_nbio_hw_fini(ras_core);
 	ras_umc_hw_fini(ras_core);
-	ras_mp1_hw_fini(ras_core);
 	ras_aca_hw_fini(ras_core);
 	ras_psp_hw_fini(ras_core);
 
@@ -782,3 +788,27 @@ bool ras_core_poison_supported(struct ras_core_context *ras_core)
 	return ras_core->poison_supported ? true :
 			ras_psp_poison_supported(ras_core);
 }
+
+bool ras_core_in_early_init(struct ras_core_context *ras_core)
+{
+	if (!ras_core)
+		return true;
+
+	return ras_core->in_early_init;
+}
+
+bool ras_core_early_init_service_enabled(struct ras_core_context *ras_core)
+{
+	return ras_core->early_init_service_enabled &&
+		ras_eeprom_mgr_early_init_service_supported(ras_core);
+}
+
+int ras_core_eeprom_early_init_service(struct ras_core_context *ras_core)
+{
+	if (!ras_core_early_init_service_enabled(ras_core))
+		return -EOPNOTSUPP;
+	else if (!ras_core_in_early_init(ras_core))
+		return -EACCES;
+
+	return ras_core_eeprom_recovery(ras_core);
+}
diff --git a/drivers/gpu/drm/amd/ras/core/eeprom.c b/drivers/gpu/drm/amd/ras/core/eeprom.c
index b261f11799f6c..01e4cde581f42 100644
--- a/drivers/gpu/drm/amd/ras/core/eeprom.c
+++ b/drivers/gpu/drm/amd/ras/core/eeprom.c
@@ -1085,7 +1085,7 @@ static int __read_table_ras_info(struct ras_eeprom_control *control)
 	return res == RAS_TABLE_V2_1_INFO_SIZE ? 0 : res;
 }
 
-static int __check_ras_table_status(struct ras_core_context *ras_core)
+static int __ras_table_init(struct ras_core_context *ras_core)
 {
 	struct ras_eeprom_control *control = ras_core->eeprom_mgr.ras_eeprom;
 	unsigned char buf[RAS_TABLE_HEADER_SIZE] = { 0 };
@@ -1102,7 +1102,6 @@ static int __check_ras_table_status(struct ras_core_context *ras_core)
 
 	control->ras_header_offset = RAS_HDR_START;
 	control->ras_info_offset = RAS_TABLE_V2_1_INFO_START;
-	mutex_init(&control->ras_tbl_mutex);
 
 	/* Read the table header from EEPROM address */
 	res = __eeprom_read(ras_core,
@@ -1284,18 +1283,26 @@ static int ras_eeprom_sw_init(struct ras_core_context *ras_core,
 	control->i2c_adapter = param->eeprom_i2c_adapter;
 	control->i2c_port = param->eeprom_i2c_port;
 	control->i2c_address = param->eeprom_i2c_addr;
+	control->record_threshold_count = param->record_threshold;
+	control->sys_func = param->sys_fn;
 
 	control->update_channel_flag = false;
 
+	mutex_init(&control->ras_tbl_mutex);
+
 	return 0;
 }
 
 static int ras_eeprom_sw_fini(struct ras_core_context *ras_core)
 {
-	if (!ras_core)
+	struct ras_eeprom_control *control = ras_core->eeprom_mgr.ras_eeprom;
+
+	if (!control)
 		return -EINVAL;
 
-	kfree(ras_core->eeprom_mgr.ras_eeprom);
+	mutex_destroy(&control->ras_tbl_mutex);
+
+	kfree(control);
 	ras_core->eeprom_mgr.ras_eeprom = NULL;
 
 	return 0;
@@ -1309,15 +1316,17 @@ static int ras_eeprom_hw_init(struct ras_core_context *ras_core,
 	if (!control)
 		return -EINVAL;
 
-	return __check_ras_table_status(ras_core);
+	control->max_read_len = param->max_i2c_read_len;
+	control->max_write_len = param->max_i2c_write_len;
+	control->i2c_adapter = param->eeprom_i2c_adapter;
+	control->i2c_port = param->eeprom_i2c_port;
+	control->i2c_address = param->eeprom_i2c_addr;
+
+	return __ras_table_init(ras_core);
 }
 
 static int ras_eeprom_hw_fini(struct ras_core_context *ras_core)
 {
-	struct ras_eeprom_control *control = ras_core->eeprom_mgr.ras_eeprom;
-
-	mutex_destroy(&control->ras_tbl_mutex);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index a08f83ed05857..ba656c82d4ee6 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -153,6 +153,7 @@ enum ras_notify_event {
 	RAS_EVENT_ID__RAS_EVENT_PROC_BEGIN,
 	RAS_EVENT_ID__RAS_EVENT_PROC_END,
 	RAS_EVENT_ID__UPDATE_ACA_DATA,
+	RAS_EVENT_ID__EARLY_INIT_RESERVE_PAGE,
 };
 
 enum ras_gpu_status {
@@ -359,6 +360,7 @@ struct ras_core_config {
 	u32 nbio_ip_version;
 	u32 psp_ip_version;
 
+	bool early_init_service_supported;
 	bool poison_supported;
 	bool ras_eeprom_supported;
 	uint ras_debug_mask;
@@ -402,6 +404,8 @@ struct ras_core_context {
 
 	bool is_rma;
 	bool is_initialized;
+	bool in_early_init;
+	bool early_init_service_enabled;
 
 	struct kfifo de_seqno_fifo;
 	struct kfifo consumption_seqno_fifo;
@@ -474,4 +478,7 @@ int ras_core_get_ip_version(struct ras_core_context *ras_core,
 	enum ras_unit_id unit_id, uint32_t *version);
 uint64_t ras_core_get_ras_caps(struct ras_core_context *ras_core);
 bool ras_core_poison_supported(struct ras_core_context *ras_core);
+bool ras_core_in_early_init(struct ras_core_context *ras_core);
+bool ras_core_early_init_service_enabled(struct ras_core_context *ras_core);
+int ras_core_eeprom_early_init_service(struct ras_core_context *ras_core);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1.c b/drivers/gpu/drm/amd/ras/core/ras_mp1.c
index 7a2a6da26ae38..7ba872732efd2 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_mp1.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_mp1.c
@@ -183,11 +183,14 @@ int ras_mp1_set_debug_mode(struct ras_core_context *ras_core, bool enable)
 	return mp1->ip_func->set_debug_mode(ras_core, enable);
 }
 
-int ras_mp1_hw_init(struct ras_core_context *ras_core)
+int ras_mp1_sw_init(struct ras_core_context *ras_core)
 {
 	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
 	int ret = 0;
 
+	if (!ras_core->config)
+		return -EINVAL;
+
 	mp1->mp1_ip_version = ras_core->config->mp1_ip_version;
 
 	if (ras_core->config && ras_core->config->mp1_cfg.mp1_sys_fn)
@@ -208,7 +211,7 @@ int ras_mp1_hw_init(struct ras_core_context *ras_core)
 	return ret;
 }
 
-int ras_mp1_hw_fini(struct ras_core_context *ras_core)
+int ras_mp1_sw_fini(struct ras_core_context *ras_core)
 {
 	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
 
diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1.h b/drivers/gpu/drm/amd/ras/core/ras_mp1.h
index 3b3d4cab1d0c9..6eac9488843e1 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_mp1.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_mp1.h
@@ -88,8 +88,8 @@ struct ras_mp1 {
 	struct mutex op_mutex;
 };
 
-int ras_mp1_hw_init(struct ras_core_context *ras_core);
-int ras_mp1_hw_fini(struct ras_core_context *ras_core);
+int ras_mp1_sw_init(struct ras_core_context *ras_core);
+int ras_mp1_sw_fini(struct ras_core_context *ras_core);
 
 int ras_mp1_get_bank_count(struct ras_core_context *ras_core,
 			    enum ras_err_type type, u32 *count);
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.c b/drivers/gpu/drm/amd/ras/core/ras_umc.c
index b9961796a5395..ee4ad9ffb50c0 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.c
@@ -187,8 +187,9 @@ static void ras_umc_reserve_eeprom_record(struct ras_core_context *ras_core,
 
 	/* Reserve memory */
 	for (i = 0; i < count; i++)
-		ras_core_event_notify(ras_core,
-			RAS_EVENT_ID__RESERVE_BAD_PAGE, &page_pfn[i]);
+		ras_core_event_notify(ras_core, ras_core_in_early_init(ras_core) ?
+			RAS_EVENT_ID__EARLY_INIT_RESERVE_PAGE : RAS_EVENT_ID__RESERVE_BAD_PAGE,
+			&page_pfn[i]);
 }
 
 /* When gpu reset is ongoing, ecc logging operations will be pended.
@@ -726,6 +727,13 @@ int ras_umc_sw_init(struct ras_core_context *ras_core)
 	mutex_init(&ras_umc->umc_lock);
 	mutex_init(&ras_umc->bank_log_lock);
 
+	ras_umc->umc_ip_version = ras_core->config->umc_ip_version;
+	ras_umc->ip_func = ras_umc_get_ip_func(ras_core, ras_umc->umc_ip_version);
+	if (!ras_umc->ip_func) {
+		RAS_DEV_ERR(ras_core->dev, "Failed to get umc ip function!\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -775,11 +783,6 @@ int ras_umc_hw_init(struct ras_core_context *ras_core)
 	struct ras_umc *ras_umc = &ras_core->ras_umc;
 	ras_umc->num_umc = ras_core->config->umc_cfg.num_umc;
 
-	ras_umc->umc_ip_version = ras_core->config->umc_ip_version;
-	ras_umc->ip_func = ras_umc_get_ip_func(ras_core, ras_umc->umc_ip_version);
-	if (!ras_umc->ip_func)
-		return -EINVAL;
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index d84cf9162e588..c08e573206bd2 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -257,6 +257,9 @@ static struct ras_core_context *amdgpu_ras_mgr_create_ras_core(struct amdgpu_dev
 	    init_config.umc_ip_version == IP_VERSION(12, 5, 0))
 		init_config.aca_ip_version = IP_VERSION(1, 0, 0);
 
+	if (init_config.mp1_ip_version == IP_VERSION(15, 0, 8))
+		init_config.early_init_service_supported = true;
+
 	init_config.sys_fn = &amdgpu_ras_sys_fn;
 	init_config.ras_eeprom_supported =
 		amdgpu_ras_mgr_eeprom_is_supported(adev);
@@ -738,3 +741,25 @@ bool amdgpu_ras_mgr_get_debug_mode(struct amdgpu_device *adev)
 
 	return ras_mgr->is_debug_mode;
 }
+
+int amdgpu_ras_mgr_early_init_service(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct amdgpu_ras_mgr *ras_mgr;
+	int ret;
+
+	if (!con->uniras_enabled)
+		return 0;
+
+	ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	if (!ras_mgr || !ras_mgr->ras_core) {
+		RAS_DEV_ERR(adev, "amdgpu ras sw is not ready!\n");
+		return -EPERM;
+	}
+
+	ret = ras_core_eeprom_early_init_service(ras_mgr->ras_core);
+	if (ret)
+		RAS_DEV_WARN(adev, "RAS early init service failure! ret:%d\n", ret);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
index 056d482644984..cb98606306932 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
@@ -61,6 +61,7 @@ struct amdgpu_ras_mgr {
 
 extern const struct amdgpu_ip_block_version ras_v1_0_ip_block;
 
+int amdgpu_ras_mgr_early_init_service(struct amdgpu_device *adev);
 struct amdgpu_ras_mgr *amdgpu_ras_mgr_get_context(
 			struct amdgpu_device *adev);
 int amdgpu_enable_uniras(struct amdgpu_device *adev, bool enable);
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
index 4744a7991757b..6115f241f13b4 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
@@ -110,6 +110,25 @@ static int amdgpu_ras_sys_gen_seqno(struct ras_core_context *ras_core,
 
 }
 
+static int amdgpu_ras_early_init_reserve_badpage(struct ras_core_context *ras_core,
+			uint64_t pfn)
+{
+	struct amdgpu_bo *bo;
+	void *va;
+	int ret;
+
+	ret = amdgpu_bo_create_kernel_at(ras_core->dev, RAS_PFN_TO_ADDR(pfn),
+			AMDGPU_GPU_PAGE_SIZE, &bo, &va);
+	if (ret) {
+		ras_core->is_rma = true;
+		RAS_DEV_ERR(ras_core->dev,
+			"Early init: RAS failed to reserve: offset=0x%llx size=0x%x ret=%d\n",
+			RAS_PFN_TO_ADDR(pfn), AMDGPU_GPU_PAGE_SIZE, ret);
+	}
+
+	return ret;
+}
+
 static int amdgpu_ras_sys_event_notifier(struct ras_core_context *ras_core,
 				   enum ras_notify_event event_id, void *data)
 {
@@ -126,6 +145,9 @@ static int amdgpu_ras_sys_event_notifier(struct ras_core_context *ras_core,
 	case RAS_EVENT_ID__RESERVE_BAD_PAGE:
 		ret = amdgpu_ras_reserve_page(ras_core->dev, *(uint64_t *)data);
 		break;
+	case RAS_EVENT_ID__EARLY_INIT_RESERVE_PAGE:
+		ret = amdgpu_ras_early_init_reserve_badpage(ras_core, *(uint64_t *)data);
+		break;
 	case RAS_EVENT_ID__FATAL_ERROR_DETECTED:
 		ret = amdgpu_ras_sys_detect_fatal_event(ras_core, data);
 		break;
-- 
2.55.0

