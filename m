Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802CEC44501
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 08:22:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 176B610F21C;
	Thu, 16 Jul 2026 08:22:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dMDbtRFB";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012047.outbound.protection.outlook.com
 [40.93.195.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3194A10F21C
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 08:22:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4w/htl7tI/CvWRv9hIbIc1VLOP4E02JXjSSYn6VqQOIv/x/9fpLQSMg0gD8l+JrAYiuxfNGTETgDxcSJGcBhB48PzP+uOP0uy4hMTV5jirTJxdXb7FiT7xexx4GxjKDtdpxFGPhkhXz5Lxef+5Z/1jnvep64GIuftVu/Do8E3QfOD7+jQFu9brMyo37cCI4Qc4wk9HzLgH0EqKvRaSQxcIjv6x93qqKNXHlcBTdpSi9rBe7pRcIhRUTz6u+rqo4OWgEqIfYWRcp/cbFvC1T0eW1w4qhL9NIjspiCblEQqBb3Z6NBmc2yc4QglhNOx1HqJNIcuxky/hYi3SjU84T3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZH3lCoNYSrGJp2cMA4y7tshD/FJz1GNikD/1qE5Yw8=;
 b=FiQQs1YaNQc1KOf0cB791S5PgDJdFmBq/bTby+FyYbKF+VZ+faoA6nU990YZwWtX+EmVcTqLfMCNHd/5ZIXU+0MwTAU+AJCfM6Ce8YTEWY7pEId+DSSrh3KsciS229y24S/gNggiQYmIW3YSD0+ODE8dTbUaDInydQtqnSI5iV5AIg/VOsO/XPrT/l0EVmQWMJrDrNgSp+m99Y1FUGIVmXLGSwk0fSpXad7K9oVZptLRQZGELhAUZviTpQHaM3YP87eV2OvAC47eSJSELePKmxwqpRMvT7LdEMoPnk4y5fCRgjCY01ExZIhGhvX4wIBT3jUwAtQK5VCPCuemov3RPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZH3lCoNYSrGJp2cMA4y7tshD/FJz1GNikD/1qE5Yw8=;
 b=dMDbtRFBBNNw6MHf0RwWakmoM4LVcWqFwHfoPLepOZMjC7P+SdsdERuPYLKGitKVWPwqC8T3bTCwSmdVFnXJdqJOA9Gj95ST7jCnQDxGPVCEG0dE66qpNt0JOry0s0tY3I5amH+ZKBfdDTCCgTZsokNAeo7bT13R4wSPQXwr7cE=
Received: from CY5PR22CA0014.namprd22.prod.outlook.com (2603:10b6:930:16::34)
 by CH0PR12MB8487.namprd12.prod.outlook.com (2603:10b6:610:18c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 08:22:45 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:930:16:cafe::31) by CY5PR22CA0014.outlook.office365.com
 (2603:10b6:930:16::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 08:22:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Thu, 16 Jul 2026 08:22:45 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 16 Jul
 2026 03:22:43 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH V3] drm/amdgpu/ras: Add debug mask to disable CE logs for
 uniras
Date: Thu, 16 Jul 2026 16:22:33 +0800
Message-ID: <20260716082233.1056365-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|CH0PR12MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: fbdeab64-29a6-4ef4-28c6-08dee31369da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|56012099006|11063799006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 0IuHWw0JPtu0bTgQAAgalGaprup2MlZUn7XPpKUU0/I73ct/LuFh2m1qzGqmJmJky9YcPJD/Anc/aDvq+z3endCvU3tbpiXFz6NimMVAHWtO0XYsYxv9xbfHd7rJFMnlj8+/lzxjzm647+5RXi3rO8I2PuO+RnvXSzH3KvRZfaJ0f6lcX6svloedu9oyyJ/FDOPPSAaY8da9BXtTKP1Yv74Mz2+hRXhKRjjBwabvriPeQTaDiGQm3aJzhShFITOccsdCBNpReMO/vbF07Z4SaCAeG2GqZDlw57ttQU8s+zb2hDBxYC4HjmQxIHvdOIRKh00taXtpn5cmU9nx/lCOE1XeRM9jsOIfggCQTue9E1E3Fj6/AnRkd3quu7+nSMYAZgzIao46nW2/J0wzvjhDsTXtA4cr3tsW12Ls4nEEIHZnxuA6tifVDwOawNlKCN8QhSIglqMK3FgoDmMufmqCMpUO5GNXtuIfszgDsSIRzGHP/HM3bEiZ9PEem1KLQsbCzs0HYbTJ4iBhIUUjXrS3QnseTNV34hwIcHLViKwQm8trdH2ejdaz63AiJFAN+ZXQVl3pvKWY4PhdttFjBhis3xHQ5qWgSkEcmus4JgMuzuKXZYL3zYZNu1ASCFptETgJA8DG0uRLDJGVUNeyyWd/ong9I7bFr3cgPSJ3EkjOsw4JQiZbESSC0oWJfs3qYgP0btNT8s/y7oI+GZ6t3NSHWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uttEZLenE/2J/eDbw7jNY7G8heUfH9FwxW48HPvldlgB4cpYFPUExeIA8zxIOudmu5yrqkiPq8mHJK2vJU36JJ1mQArfB9aABmaB2QFIqF5X+joOELCm6RYPdvxGrD7k+Lb5aHn5VWi8i6l4XsWV+6ozIDMmw4EiD8Y3kY/riQOfHS1RaWBm/ibFbVNVxR3SBTQj5qRoXWa+7c56PxnbrSvTdFvg4c9u2vrZCpxPMUd9Nml0UM1xslUwMopphhqVuaiZ4EhqvoG4f1X9H6ltLaFvBm91EHC2YTVwgf/u2GUgjuQVxgnffSOYgrtiiIEP+XW9cR/CSUJu5vbnCb9F5kTBuY9cFV91nYNsvlik4OoV881vKOFlm0XfCejMeOzzKjBPVBmXVUQgxVELw9pQoGKF0mE5z+YNCQGMW1LeFU/a9+Wjs4NJCLvxhp+bbUV+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 08:22:45.2109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbdeab64-29a6-4ef4-28c6-08dee31369da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8487
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

Add debug mask to disable kernel logs of RAS correctable errors

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  |  1 +
 drivers/gpu/drm/amd/ras/rascore/ras.h         |  4 ++++
 drivers/gpu/drm/amd/ras/rascore/ras_aca.c     | 17 +++++++++-------
 .../gpu/drm/amd/ras/rascore/ras_aca_v1_0.c    |  2 +-
 drivers/gpu/drm/amd/ras/rascore/ras_core.c    | 20 +++++++++++++++++++
 6 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a3dafdca7eb3..bc6b7da3914f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -226,6 +226,7 @@ extern int amdgpu_use_xgmi_p2p;
 extern bool pcie_p2p;
 extern int amdgpu_mtype_local;
 extern int amdgpu_enforce_isolation;
+extern uint amdgpu_debug_mask;
 #ifdef CONFIG_HSA_AMD
 extern int sched_policy;
 extern bool debug_evictions;
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index ea95e0f93d1c..0db755ba7037 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -309,6 +309,7 @@ static struct ras_core_context *amdgpu_ras_mgr_create_ras_core(struct amdgpu_dev
 		amdgpu_ras_mgr_eeprom_is_supported(adev);
 	init_config.poison_supported =
 		amdgpu_ras_is_poison_mode_supported(adev);
+	init_config.ras_debug_mask = amdgpu_debug_mask;
 
 	amdgpu_ras_mgr_init_aca_config(adev, &init_config);
 	amdgpu_ras_mgr_init_eeprom_config(adev, &init_config);
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ras.h
index 878dfdfcb18a..53abf1a8600b 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -301,6 +301,7 @@ struct ras_core_config {
 
 	bool poison_supported;
 	bool ras_eeprom_supported;
+	uint ras_debug_mask;
 	const struct ras_sys_func *sys_fn;
 
 	struct ras_aca_config aca_cfg;
@@ -346,6 +347,8 @@ struct ras_core_context {
 	spinlock_t seqno_lock;
 
 	bool ras_core_enabled;
+	bool ras_ce_log_disabled;
+	uint ras_debug_mask;
 
 	u64 ras_fw_features;
 };
@@ -403,4 +406,5 @@ int ras_core_convert_soc_pa_to_cur_nps_pages(struct ras_core_context *ras_core,
 int ras_core_check_address_sanity(struct ras_core_context *ras_core, uint64_t addr);
 
 int ras_core_set_debug_mode(struct ras_core_context *ras_core, bool enable);
+bool ras_core_is_ce_log_disabled(struct ras_core_context *ras_core);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
index 67a35409ff0e..a1fb9a5f72cf 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
@@ -83,22 +83,20 @@ static void aca_report_ecc_info(struct ras_core_context *ras_core,
 			seq_no, skt, aid, ecc_count.total_ue_count, blk_name(blk));
 	}
 
-	if (ecc_count.new_de_count) {
+	if (ecc_count.new_de_count && blk == RAS_BLOCK_ID__UMC) {
 		RAS_DEV_INFO(ras_core->dev,
-		"{%llu} socket: %d, die: %d, %u new %s detected in %s block\n",
+		"{%llu} socket: %d, die: %d, %u new deferred hardware errors detected in %s block\n",
 			seq_no, skt, aid, ecc_count.new_de_count,
-			(blk == RAS_BLOCK_ID__UMC) ?
-				"deferred hardware errors" : "poison consumption",
 			blk_name(blk));
 		RAS_DEV_INFO(ras_core->dev,
-		"{%llu} socket: %d, die: %d, %u %s detected in total in %s block\n",
+		"{%llu} socket: %d, die: %d, %u deferred hardware errors detected in total in %s block\n",
 			seq_no, skt, aid, ecc_count.total_de_count,
-			(blk == RAS_BLOCK_ID__UMC) ?
-				"deferred hardware errors" : "poison consumption",
 			blk_name(blk));
 	}
 
 	if (ecc_count.new_ce_count) {
+		if (ras_core_is_ce_log_disabled(ras_core))
+			return;
 		RAS_DEV_INFO(ras_core->dev,
 		"{%llu} socket: %d, die: %d, %u new correctable hardware errors detected in %s block\n",
 			seq_no, skt, aid, ecc_count.new_ce_count, blk_name(blk));
@@ -114,6 +112,11 @@ static void aca_bank_log(struct ras_core_context *ras_core,
 {
 	int i;
 
+	if(ras_core_is_ce_log_disabled(ras_core) &&
+	   bank->ecc_type == RAS_ERR_TYPE__CE &&
+	   !bank_ecc->de_count)
+		return;
+
 	RAS_DEV_INFO(ras_core->dev,
 		"{%llu}" RAS_HW_ERR "Accelerator Check Architecture events logged\n",
 		bank->seq_no);
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
index 840610538c1f..288fad0862a2 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
@@ -265,7 +265,7 @@ static int aca_parse_bank_default(struct ras_core_context *ras_core,
 	ecc->bank_info.addr = bank->regs[ACA_REG_IDX__ADDR];
 
 	if (aca_check_bank_is_de(ras_core, status)) {
-		ecc->de_count = 0;
+		ecc->de_count = 1;
 	} else {
 		if (bank->ecc_type == RAS_ERR_TYPE__UE)
 			ecc->ue_count = 1;
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index 08e17a83ad5b..f3c6cbc7e05f 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -28,6 +28,10 @@
 
 #define IS_LEAP_YEAR(x) ((x % 4 == 0 && x % 100 != 0) || x % 400 == 0)
 
+enum RAS_DEBUG_MASK {
+	RAS_DEBUG_DISABLE_RAS_CE_LOG = BIT(9),
+};
+
 static const char * const ras_block_name[] = {
 	"umc",
 	"sdma",
@@ -374,6 +378,14 @@ int ras_core_sw_fini(struct ras_core_context *ras_core)
 	return 0;
 }
 
+static void ras_init_debug_options(struct ras_core_context *ras_core)
+{
+	if (ras_core->ras_debug_mask & RAS_DEBUG_DISABLE_RAS_CE_LOG) {
+		RAS_DEV_INFO(ras_core->dev, "debug: disable kernel logs of correctable errors\n");
+		ras_core->ras_ce_log_disabled = true;
+	}
+}
+
 int ras_core_hw_init(struct ras_core_context *ras_core)
 {
 	int ret;
@@ -382,6 +394,7 @@ int ras_core_hw_init(struct ras_core_context *ras_core)
 			ras_core->config->ras_eeprom_supported;
 
 	ras_core->poison_supported = ras_core->config->poison_supported;
+	ras_core->ras_debug_mask = ras_core->config->ras_debug_mask;
 
 	ret = ras_psp_hw_init(ras_core);
 	if (ret)
@@ -434,6 +447,8 @@ int ras_core_hw_init(struct ras_core_context *ras_core)
 	if (ret)
 		goto init_err7;
 
+	ras_init_debug_options(ras_core);
+
 	ras_core->is_initialized = true;
 
 	return 0;
@@ -545,6 +560,11 @@ bool ras_core_is_enabled(struct ras_core_context *ras_core)
 	return ras_core->ras_core_enabled;
 }
 
+bool ras_core_is_ce_log_disabled(struct ras_core_context *ras_core)
+{
+	return ras_core->ras_ce_log_disabled;
+}
+
 uint64_t ras_core_get_utc_second_timestamp(struct ras_core_context *ras_core)
 {
 	if (!ras_core)
-- 
2.34.1

