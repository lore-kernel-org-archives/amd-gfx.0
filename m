Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F39BC5CFCF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D166710F70D;
	Fri, 14 Aug 2026 21:03:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xIFHoAaL";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010044.outbound.protection.outlook.com
 [52.101.193.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55EE410F6FD
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbRsRWLemVMVmGz1NZ5ZPqaIWSMJ4+H0zzIPtLDqqk9aPbnr3g4RCdYxRHttpMhiVf09hDpTJ2/klm8SH/E/Pm+vbuTPeTf8V3Sw2eT9VOYCSL0hfHUM0j7SbRVs+jGwe8a2Lj5zmakafLyytdZ/3mYoB7YAFj+AHs2i1Bzgom7+lmN4uGcCRMIEag8leoHb80uM33J0Xa6Yh8Q+MOU22HsvAwCG1uWmy7rfvbjqQvZZ3u2n+ecWcsFzlUNjRJ2z6uXSdNOf4Z+yN2k+YXk1USzOx+MLuauxzwUvEQnH7vbifrLouYT8wag+gkUk0E/ms/aRvMoO1pSEUey7yoppsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mx+j/nXiI8rx/c/iwsTe6DQzJOP5QIAUI1mczBq9Nh8=;
 b=jvmP6GFxHYgrfaBxoJ/21B9kf2zLVIV8eiy2oOrnBtQL1PuhlY4z2604ntodkTTp8jw1VaTulEDDCky9fwdl7a2vXqqkWHEwMtnPkPBsBL9JvUPXHzpXL/KlowKglUNYMnCcs7yvFmctHQVefjowYBHSGOAcFhMVSzvbX2zvfMok/TLTzuJ4udZMxVRbQ/LjzDlG7QjGoGjpFLeudjEZ6nVaHp5o1ym1jzy4tzVRwkrDlPXvCWqc7WIVeJ3LNDtrTiWSA04cooAZHf602D+gF6tmNDnP2PNRj8ypexovF0AKoNvgzdGEPUVaf4ynh1a2WEV41ZbeEDLucBgPL97GiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mx+j/nXiI8rx/c/iwsTe6DQzJOP5QIAUI1mczBq9Nh8=;
 b=xIFHoAaLPaoIb4ovVeukGxQ1Y9vxnz8SqVzPuGhvjp3nsqNDOmqdK/cnkBkBNsfgD3P3aEZx1AI96C3/hQR0Asd8HjVwM75/7be3R88DQoi58ap5OySLbw60dBKGocz7PQA8DKznBUHbSWitl5ISayD9t4jlVYZDOOdBkb+dMcE=
Received: from CH2PR10CA0025.namprd10.prod.outlook.com (2603:10b6:610:4c::35)
 by CH2PR12MB4229.namprd12.prod.outlook.com (2603:10b6:610:a5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:30 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:4c:cafe::2f) by CH2PR10CA0025.outlook.office365.com
 (2603:10b6:610:4c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Fri,
 14 Aug 2026 21:03:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:30 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:22 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 042/109] drm/amd/ras: Refactor EEPROM parameter config to
 support multiple ras EEPROMs
Date: Fri, 14 Aug 2026 17:01:39 -0400
Message-ID: <20260814210246.3067612-43-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|CH2PR12MB4229:EE_
X-MS-Office365-Filtering-Correlation-Id: c14843d7-d219-49b2-d2b4-08defa477e5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|3023799007|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /yytvQht8oAi2r9PrPkM+Y83fZ14GOFehfD/dUh7tK/7VTsxLQDXIglgkWenhJk2mPesNtFcUilQZGZaTbzY2huCk+GeDQIHaQvrYmoJ5unkqp9cJeOtmoD9Mz798s4HIh9MTPet76UtRszTlGLVb/S6idRHB3/IrMClk9LmB6wq2xbkziQhw/thLUqdJrdrh82ZBu0OobTENYvLgav0RAPb+5U7nj7umqBcQKYuJeDA64ekdD1ILB14IFDT7yIDk23OZbcNZDTzoepf9hFyIrXzIyh1RrwUY5GsYjk2yH6JRSX7w+8Pouwq2FBHkjHMvqoiIJBO9QnJYR2nE2NSlBexjoo1UcZMgNnWLuTPMFeWDc8Hv5hDzrkb1kdZJhhrE9ARBlvog+fqtNnFB5w1gQj0QXFvjMql/1zhn4nijDouLux+CQype/ww4yxlK0qLTV4XABpjiRb59sBYZeC+JmE4yMPP9Oc9+IBBTKatTiSHFhT6VDB2TWOErPwpbbitZoGoGS5IBYezEFbZZk4N1DLg3yyyVNkMTN/HbH/FQRZgrZsYpvnvrrmyvNI3ye32FstfvYR3yBJH6lcG5HfqPHSLvwJd32MMsv6fUtcbYJlOD1jg++gkreg23wAGGoQB7cF10mk2d83lznaVkd++tTjR1qioEIcy8IuFz0AwaRw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(3023799007)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 608HIoEysaHIJdGU6KA7sLXF2XUODDvL5unkBTh1svITjyi5yJzpTLi7MOiaZBxRxGaqhE5PbTK4DDhaeVsYzPYUVsOaVJjOe16ILtwNANPodr32zPaXFyFrmcZGTbh0BiZwDL60nZaFzZx7HpDeYd2XsTimczRMpAFl7fxlYtdzO5O0r6FQ6dQaLksb1McBTcW4UgUe/AVMQT8/R2I4gA8ibQZUd1AUxqZSrlKCNVOL6q7UTLSTJMqgeEzWZd2wInDSM3kWJI+v3S55VmOKSz6FZ0VI2rSUoFz88KLjlp+YZnRfidxtwS4F7vd7XSSAtlVULlL/IjmJLe+puBLW+x3z7S2OcsQw/+ooXzd/vBcDURWtBxzeI3OaOEKjMk4jiIYXC2YDzKnwxaX3Ag54lPlxw9i0BxsqQcixRTS7kpJFnGfC3LM87/TPwyPUBD6e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:30.2392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c14843d7-d219-49b2-d2b4-08defa477e5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4229
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

- Refactor EEPROM parameter config to support multiple ras EEPROMs.
- Convert bad page count to record count as EEPROM threshold.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/eeprom.c         |  48 ++++---
 drivers/gpu/drm/amd/ras/core/ras.h            |  26 +++-
 .../amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c   | 117 +++++++++++++++---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  |  67 ----------
 4 files changed, 154 insertions(+), 104 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/eeprom.c b/drivers/gpu/drm/amd/ras/core/eeprom.c
index 1bc409048e732..7913cdbdb8b0a 100644
--- a/drivers/gpu/drm/amd/ras/core/eeprom.c
+++ b/drivers/gpu/drm/amd/ras/core/eeprom.c
@@ -161,16 +161,12 @@ static bool __is_ras_eeprom_supported(struct ras_core_context *ras_core)
 static bool __get_eeprom_i2c_addr(struct ras_core_context *ras_core,
 				  struct ras_eeprom_control *control)
 {
-	int ret = -EINVAL;
-
-	if (control->sys_func &&
-		control->sys_func->update_eeprom_i2c_config)
-		ret = control->sys_func->update_eeprom_i2c_config(ras_core);
-	else
-		RAS_DEV_WARN(ras_core->dev,
-			"No eeprom i2c system config!\n");
+	if (!control->i2c_address) {
+		RAS_DEV_WARN(ras_core->dev, "Not config eeprom i2c address!\n");
+		return false;
+	}
 
-	return !ret ? true : false;
+	return true;
 }
 
 static int __ras_eeprom_xfer(struct ras_core_context *ras_core, u32 eeprom_addr,
@@ -1286,6 +1282,8 @@ int ras_eeprom_hw_init(struct ras_core_context *ras_core)
 {
 	struct ras_eeprom_control *control;
 	struct ras_eeprom_config *eeprom_cfg;
+	struct ras_eeprom_param_config  param_config = {0};
+	int ret;
 
 	if (!ras_core)
 		return -EINVAL;
@@ -1297,21 +1295,35 @@ int ras_eeprom_hw_init(struct ras_core_context *ras_core)
 	memset(control, 0, sizeof(*control));
 
 	eeprom_cfg = &ras_core->config->eeprom_cfg;
+	if (!eeprom_cfg || !eeprom_cfg->eeprom_sys_fn ||
+		!eeprom_cfg->eeprom_sys_fn->get_eeprom_config) {
+		RAS_DEV_ERR(ras_core->dev, "Ras eeprom not configured!\n");
+		return -EINVAL;
+	}
+
+	control->sys_func = eeprom_cfg->eeprom_sys_fn;
+
+	ret = eeprom_cfg->eeprom_sys_fn->get_eeprom_config(ras_core,
+				&param_config);
+	if (ret) {
+		RAS_DEV_ERR(ras_core->dev, "Failed to get ras eeprom config!\n");
+		return -EPERM;
+	}
+
 	control->record_threshold_config =
-		eeprom_cfg->eeprom_record_threshold_config;
+		param_config.eeprom_record_threshold_config;
 
 	control->record_threshold_count = ras_eeprom_max_record_count(ras_core);
-	if (eeprom_cfg->eeprom_record_threshold_count <
+	if (param_config.eeprom_record_threshold_count <
 		control->record_threshold_count)
 		control->record_threshold_count =
-			eeprom_cfg->eeprom_record_threshold_count;
+			param_config.eeprom_record_threshold_count;
 
-	control->sys_func = eeprom_cfg->eeprom_sys_fn;
-	control->max_read_len = eeprom_cfg->max_i2c_read_len;
-	control->max_write_len = eeprom_cfg->max_i2c_write_len;
-	control->i2c_adapter = eeprom_cfg->eeprom_i2c_adapter;
-	control->i2c_port = eeprom_cfg->eeprom_i2c_port;
-	control->i2c_address = eeprom_cfg->eeprom_i2c_addr;
+	control->max_read_len = param_config.max_i2c_read_len;
+	control->max_write_len = param_config.max_i2c_write_len;
+	control->i2c_adapter = param_config.eeprom_i2c_adapter;
+	control->i2c_port = param_config.eeprom_i2c_port;
+	control->i2c_address = param_config.eeprom_i2c_addr;
 
 	control->update_channel_flag = false;
 
diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index 10fa7068fc7a4..9c87037454d5c 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -27,7 +27,7 @@
 #include "ras_sys.h"
 #include "ras_umc.h"
 #include "aca.h"
-#include "eeprom.h"
+#include "ras_eeprom_mgr.h"
 #include "core_status.h"
 #include "ras_process.h"
 #include "ras_gfx.h"
@@ -185,6 +185,13 @@ enum ras_unit_id {
 	RAS_UNIT_ID_MAX
 };
 
+enum ras_work_mode_over_thresh {
+	RAS_WORK_MODE_OVER_THRESH_STRICT,
+	RAS_WORK_MODE_OVER_THRESH_NORMAL,
+	RAS_WORK_MODE_OVER_THRESH_DEBUG,
+	RAS_WORK_MODE_OVER_THRESH_RMA,
+};
+
 struct ras_core_context;
 struct ras_bank_ecc;
 struct ras_umc;
@@ -193,6 +200,7 @@ struct ras_process;
 struct ras_nbio;
 struct ras_log_ring;
 struct ras_psp;
+struct ras_eeprom_mgr;
 
 struct ras_mp1_sys_func {
 	int (*mp1_get_valid_bank_count)(struct ras_core_context *ras_core,
@@ -206,10 +214,23 @@ struct ras_mp1_sys_func {
 	int (*mp1_set_debug_mode)(struct ras_core_context *ras_core, bool enable);
 };
 
+struct ras_eeprom_param_config {
+	int eeprom_record_threshold_config;
+	u32 eeprom_ip_version;
+	u64 eeprom_record_threshold_count;
+	enum ras_work_mode_over_thresh work_mode_over_thresh;
+	void *eeprom_i2c_adapter;
+	u32 eeprom_i2c_addr;
+	u32 eeprom_i2c_port;
+	u16 max_i2c_read_len;
+	u16 max_i2c_write_len;
+};
+
 struct ras_eeprom_sys_func {
 	int (*eeprom_i2c_xfer)(struct ras_core_context *ras_core,
 			u32 eeprom_addr, u8 *eeprom_buf, u32 buf_size, bool read);
-	int (*update_eeprom_i2c_config)(struct ras_core_context *ras_core);
+	int (*get_eeprom_config)(struct ras_core_context *ras_core,
+			struct ras_eeprom_param_config *param_cfg);
 };
 
 struct ras_nbio_sys_func {
@@ -363,6 +384,7 @@ struct ras_core_context {
 
 	bool ras_eeprom_supported;
 	struct ras_eeprom_control ras_eeprom;
+	struct ras_eeprom_mgr eeprom_mgr;
 	struct ras_fw_eeprom_control ras_fw_eeprom;
 
 	struct ras_psp ras_psp;
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
index aa97b58c94227..14817de696a39 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
@@ -26,6 +26,7 @@
 #include "amdgpu_ras_eeprom.h"
 #include "amdgpu_ras_mgr.h"
 #include "amdgpu_ras_eeprom_i2c.h"
+#include "ras.h"
 #include "eeprom.h"
 
 /* These are memory addresses as would be seen by one or more EEPROM
@@ -61,11 +62,30 @@
 
 #define EEPROM_OFFSET_SIZE 2
 
-static int ras_eeprom_i2c_config(struct ras_core_context *ras_core)
+/* typical ras bad page rate is 1 bad page per 100MB VRAM */
+#define ESTIMATE_BAD_PAGE_THRESHOLD(size) div64_u64(size, 100ULL * SZ_1M)
+
+#define COUNT_BAD_PAGE_THRESHOLD(size) (((size) >> 21) << 4)
+
+/* Reserve 8 physical dram row for possible retirement.
+ * In worst cases, it will lose 8 * 2MB memory in vram domain
+ */
+#define RAS_RESERVED_VRAM_SIZE_DEFAULT	(16ULL << 20)
+
+#define RAS_PAGES_TO_EEPROM_RECORDS(pages, ratio)  div64_u64(pages, ratio)
+
+#define BAD_PAGE_NUM_PER_EEPROM_RECORD_V13  16
+#define BAD_PAGE_NUM_PER_EEPROM_RECORD_V15  128
+
+static int ras_eeprom_i2c_config(struct ras_core_context *ras_core,
+		struct ras_eeprom_param_config *cfg)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
-	struct ras_eeprom_control *control = &ras_core->ras_eeprom;
+	u64 badpages, badpages_per_record = 0;
 	u8 i2c_addr;
+	u32 ip_version;
+
+	ip_version = amdgpu_ip_version(adev, MP1_HWIP, 0);
 
 	if (adev->bios && amdgpu_atomfirmware_ras_rom_addr(adev, &i2c_addr)) {
 		/* The address given by VBIOS is an 8-bit, wire-format
@@ -77,28 +97,91 @@ static int ras_eeprom_i2c_config(struct ras_core_context *ras_core)
 		 * amdgpu_eeprom.c.
 		 */
 		i2c_addr = (i2c_addr & 0x0F) >> 1;
-		control->i2c_address = ((u32) i2c_addr) << 16;
-		return 0;
+		cfg->eeprom_i2c_addr = ((u32) i2c_addr) << 16;
+	} else {
+		switch (ip_version) {
+		case IP_VERSION(13, 0, 5):
+		case IP_VERSION(13, 0, 6):
+		case IP_VERSION(13, 0, 10):
+		case IP_VERSION(13, 0, 12):
+		case IP_VERSION(13, 0, 14):
+			cfg->eeprom_i2c_addr = EEPROM_I2C_MADDR_4;
+			badpages_per_record = BAD_PAGE_NUM_PER_EEPROM_RECORD_V13;
+			break;
+		case IP_VERSION(15, 0, 8):
+			cfg->eeprom_i2c_addr = EEPROM_I2C_MADDR_4;
+			badpages_per_record = BAD_PAGE_NUM_PER_EEPROM_RECORD_V15;
+			break;
+		default:
+			RAS_DEV_ERR(adev, "IP version(0x%x) is not supported!\n", ip_version);
+			return -ENODATA;
+		}
 	}
 
-	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
-	case IP_VERSION(13, 0, 5):
-	case IP_VERSION(13, 0, 6):
-	case IP_VERSION(13, 0, 10):
-	case IP_VERSION(13, 0, 12):
-	case IP_VERSION(13, 0, 14):
-		control->i2c_address = EEPROM_I2C_MADDR_4;
-		return 0;
-	default:
-		return -ENODATA;
+	if (!badpages_per_record || !cfg->eeprom_i2c_addr) {
+		RAS_DEV_ERR(adev, "EEPROM parameters are not configured!\n");
+		return -EINVAL;
 	}
-	return -ENODATA;
+
+	cfg->eeprom_ip_version = ip_version;
+
+	cfg->eeprom_i2c_adapter = adev->pm.ras_eeprom_i2c_bus;
+	if (cfg->eeprom_i2c_adapter) {
+		const struct i2c_adapter_quirks *quirks =
+			((struct i2c_adapter *)cfg->eeprom_i2c_adapter)->quirks;
+
+		if (quirks) {
+			cfg->max_i2c_read_len = quirks->max_read_len;
+			cfg->max_i2c_write_len = quirks->max_write_len;
+		}
+	}
+
+	/*
+	 * amdgpu_bad_page_threshold is used to config
+	 * the threshold for the number of bad pages.
+	 * -1:  Threshold is set to default value
+	 *      Driver will issue a warning message when threshold is reached
+	 *      and continue runtime services.
+	 * 0:   Disable bad page retirement
+	 *      Driver will not retire bad pages
+	 *      which is intended for debugging purpose.
+	 * -2:  Threshold is determined by a formula
+	 *      that assumes 1 bad page per 100M of local memory.
+	 *      Driver will continue runtime services when threhold is reached.
+	 * 0 < threshold < max number of bad page records in EEPROM,
+	 *      A user-defined threshold is set
+	 *      Driver will halt runtime services when this custom threshold is reached.
+	 */
+	if (amdgpu_bad_page_threshold == NONSTOP_OVER_THRESHOLD) {
+		cfg->work_mode_over_thresh = RAS_WORK_MODE_OVER_THRESH_NORMAL;
+		badpages = ESTIMATE_BAD_PAGE_THRESHOLD(adev->gmc.mc_vram_size);
+	} else if (amdgpu_bad_page_threshold == WARN_NONSTOP_OVER_THRESHOLD) {
+		cfg->work_mode_over_thresh = RAS_WORK_MODE_OVER_THRESH_STRICT;
+		badpages = COUNT_BAD_PAGE_THRESHOLD(RAS_RESERVED_VRAM_SIZE_DEFAULT);
+	} else if (!amdgpu_bad_page_threshold) {
+		cfg->work_mode_over_thresh = RAS_WORK_MODE_OVER_THRESH_DEBUG;
+		badpages = 128;
+	} else if (amdgpu_bad_page_threshold > 0) {
+		cfg->work_mode_over_thresh = RAS_WORK_MODE_OVER_THRESH_RMA;
+		badpages = amdgpu_bad_page_threshold;
+	} else {
+		RAS_DEV_ERR(adev, "Invalid amdgpu_bad_page_threshold value(%d)\n",
+			amdgpu_bad_page_threshold);
+		return -EINVAL;
+	}
+
+	/* Convert bad page count to record count as the threshold value */
+	cfg->eeprom_record_threshold_count =
+		RAS_PAGES_TO_EEPROM_RECORDS(badpages, badpages_per_record);
+
+	return 0;
 }
 
 static int ras_eeprom_i2c_xfer(struct ras_core_context *ras_core, u32 eeprom_addr,
 				u8 *eeprom_buf, u32 buf_size, bool read)
 {
-	struct i2c_adapter *i2c_adap = ras_core->ras_eeprom.i2c_adapter;
+	struct ras_eeprom_control *control = ras_core->eeprom_mgr.ras_eeprom;
+	struct i2c_adapter *i2c_adap = control->i2c_adapter;
 	u8 eeprom_offset_buf[EEPROM_OFFSET_SIZE];
 	struct i2c_msg msgs[] = {
 		{
@@ -178,5 +261,5 @@ static int ras_eeprom_i2c_xfer(struct ras_core_context *ras_core, u32 eeprom_add
 
 const struct ras_eeprom_sys_func amdgpu_ras_eeprom_i2c_sys_func = {
 	.eeprom_i2c_xfer = ras_eeprom_i2c_xfer,
-	.update_eeprom_i2c_config = ras_eeprom_i2c_config,
+	.get_eeprom_config = ras_eeprom_i2c_config,
 };
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index c71bd447d1b2c..348b0412e5d90 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -43,17 +43,11 @@
 #define MAX_AID_NUM_PER_SOCKET_GFX12    2
 #define MAX_XCD_NUM_PER_AID_GFX12       4
 
-/* typical ECC bad page rate is 1 bad page per 100MB VRAM */
-#define TYPICAL_ECC_BAD_PAGE_RATE (100ULL * SZ_1M)
-
-#define COUNT_BAD_PAGE_THRESHOLD(size) (((size) >> 21) << 4)
-
 /* Reserve 8 physical dram row for possible retirement.
  * In worst cases, it will lose 8 * 2MB memory in vram domain
  */
 #define RAS_RESERVED_VRAM_SIZE_DEFAULT	(16ULL << 20)
 
-
 static void ras_mgr_init_event_mgr(struct ras_event_manager *mgr)
 {
 	struct ras_event_state *event_state;
@@ -114,73 +108,12 @@ static int amdgpu_ras_mgr_init_aca_config(struct amdgpu_device *adev,
 	return 0;
 }
 
-static uint64_t amdgpu_ras_mgr_reserved_vram_size(struct amdgpu_device *adev)
-{
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	uint64_t reserved_pages_in_bytes = 0;
-
-	if (!con || (adev->flags & AMD_IS_APU))
-		return 0;
-
-	switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
-	case IP_VERSION(13, 0, 6):
-	case IP_VERSION(13, 0, 12):
-		reserved_pages_in_bytes = RAS_RESERVED_VRAM_SIZE_DEFAULT;
-		break;
-	case IP_VERSION(13, 0, 14):
-		reserved_pages_in_bytes = (RAS_RESERVED_VRAM_SIZE_DEFAULT << 1);
-		break;
-	default:
-		break;
-	}
-	return reserved_pages_in_bytes;
-}
-
 static int amdgpu_ras_mgr_init_eeprom_config(struct amdgpu_device *adev,
 		struct ras_core_config *config)
 {
 	struct ras_eeprom_config *eeprom_cfg = &config->eeprom_cfg;
-	uint64_t ras_reserved_vram_size;
 
-	ras_reserved_vram_size = amdgpu_ras_mgr_reserved_vram_size(adev);
 	eeprom_cfg->eeprom_sys_fn = &amdgpu_ras_eeprom_i2c_sys_func;
-	eeprom_cfg->eeprom_i2c_adapter = adev->pm.ras_eeprom_i2c_bus;
-	if (eeprom_cfg->eeprom_i2c_adapter) {
-		const struct i2c_adapter_quirks *quirks =
-			((struct i2c_adapter *)eeprom_cfg->eeprom_i2c_adapter)->quirks;
-
-		if (quirks) {
-			eeprom_cfg->max_i2c_read_len = quirks->max_read_len;
-			eeprom_cfg->max_i2c_write_len = quirks->max_write_len;
-		}
-	}
-
-	/*
-	 * amdgpu_bad_page_threshold is used to config
-	 * the threshold for the number of bad pages.
-	 * -1:  Threshold is set to default value
-	 *      Driver will issue a warning message when threshold is reached
-	 *      and continue runtime services.
-	 * 0:   Disable bad page retirement
-	 *      Driver will not retire bad pages
-	 *      which is intended for debugging purpose.
-	 * -2:  Threshold is determined by a formula
-	 *      that assumes 1 bad page per 100M of local memory.
-	 *      Driver will continue runtime services when threhold is reached.
-	 * 0 < threshold < max number of bad page records in EEPROM,
-	 *      A user-defined threshold is set
-	 *      Driver will halt runtime services when this custom threshold is reached.
-	 */
-	if (amdgpu_bad_page_threshold == NONSTOP_OVER_THRESHOLD)
-		eeprom_cfg->eeprom_record_threshold_count =
-			div64_u64(adev->gmc.mc_vram_size, TYPICAL_ECC_BAD_PAGE_RATE);
-	else if (amdgpu_bad_page_threshold == WARN_NONSTOP_OVER_THRESHOLD)
-		eeprom_cfg->eeprom_record_threshold_count =
-				COUNT_BAD_PAGE_THRESHOLD(ras_reserved_vram_size);
-	else
-		eeprom_cfg->eeprom_record_threshold_count = amdgpu_bad_page_threshold;
-
-	eeprom_cfg->eeprom_record_threshold_config = amdgpu_bad_page_threshold;
 
 	return 0;
 }
-- 
2.55.0

