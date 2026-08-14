Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14045C5DF6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 230E810F703;
	Fri, 14 Aug 2026 21:03:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aZfy2c+g";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9F7B10F70A
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcdgccinVMZUXJ9V8lMCdhSrYh/irz1Es+Hl+rcjYlhyY4kSkgC0WGyoSZV4X/19z1hqKl4wCyivuhz4HTJ99VjL0MNfWly14p+hNzY7mPaEabyWL1wmfdsMesuICwGdRXcGfc0BUBqAuHxYExlhGIDdqdu8NY/JRjY30uBDMI7huyJy0Csr8A8IS9sQ3Tp4ePxCjMCeHJaahHPNmGIYYJwcIifVFeRDyQ+6SpVg325uzbY6VrSYmGYgj1oGtjo98wa758tj6EeqpZS9vt+kPt20EfbACIGRyHfiqvnOpHoF8vGMwPWi7+iyRw9/IrCc+//HVzQ5Qys26rnS8ut0Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3lHETjoHFagInxf1P1ddq9kL8yn0v/LwnQFnseKlis=;
 b=BfyODfX+1ipGdcuqquZNdiNrMPqLr0339UyeXul/tXNINHVoDVQgdsD9stzN+SwueSKNEE/NzakMhTPQjWK0nrWBL3HdnGA7sPTVwVBcXZnc/ZXghchgbL/G2zhlUihOnFuivf9Fc7RThn7sH38ew4W6s4xgLSXu7+tMslDw1E69+eBM7TkxfMWu/3G9s4N9i0pPOoYKRVL7w/dXM2YuERDfgY4S6nbjHv/2Z203isJOFr/hSdkVVA6z/qAI9j4LuJjY4ltgatmd5yL28U0X/SngVu3IsTcVVijfOmg6NWkrh0ihoYFHJ7X5K6KSlBqV4kS3bbvXZTiTM5IPv2zEKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3lHETjoHFagInxf1P1ddq9kL8yn0v/LwnQFnseKlis=;
 b=aZfy2c+gO+R5JMKAYICZ0KGTvuYvpQxefexXFjUvU39o3mJEDXd1mkB5xExz1bEOCUi2boldbsPp2SFwc9NiQYyXtfCEiZ3hpeW9zhiHqgQ+DFFCm7Zym/6oahiyx+0YwQXpKQQkH03bCUCdA8oAFyHNZ59f52yi3YOeh5GGhvg=
Received: from DSZP220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::9) by
 CY5PR12MB6228.namprd12.prod.outlook.com (2603:10b6:930:20::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.15; Fri, 14 Aug 2026 21:03:28 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:5:280:cafe::79) by DSZP220CA0008.outlook.office365.com
 (2603:10b6:5:280::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:27 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:21 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 039/109] drm/amd/ras: ras mp1 introduces common interfaces
Date: Fri, 14 Aug 2026 17:01:36 -0400
Message-ID: <20260814210246.3067612-40-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|CY5PR12MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: d2144ee8-7eb3-49d9-820b-08defa477cfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|10067099003|56012099006|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cCryXRREDyQB9m5XM0B60dMBYu0g8IfZjMKt+o+2ZwQFn7Bvyij9S5UZvTEyc03HosDTS04bVkAjx+J6n7hz/khg0NoMoePdhmuFGpiyqh3p6z7grP1+7DC4Ud1cImsE/nrioOKqRzlpqVRWUWJt0GJdlvptl6ngGwlfSsHTSEmjoxZPEqbPNxZTwrwxi5x2bMRt9jK9UDpQEsz3YouqtBcQ+PZa8AXUKkfOzx2k5GgKGcfT4F4iHHDF31dMYHNhji/8REeHAdH6XR84EedZ8irJnuh/znHJBNi32uDYwobX4AMlfi8izDdKutAvpimxYNMjC2f/b+l6tXDTg3mIj/n6Yl5RpWQ6whNXJUlBaIj+JaxyDhXFSIruG2LL+wyGTx+LAjV/gdWye82xUZ9d+2AsHTY6gG/WH/7o5cMnqgF+EN995EUinsTm+KTmohcf0AH2lLxODGKlPCd36JZZLxrVJYqcUl3Qy2uYXinSCEBNmbVbvhh+hpXYdfcRO94FEL0QqPnXqUuUuBkKJ0Fvq1s4DBm1GPvfv6ScPHLIdycpNqlCkMW1xb1dl56575Ci+2MEyIzzBxgnwzqQ0bPyTSao0CKyG6e1lv2GE+qybE55juDU3Oau5efVytXZzCN78TCxMMBrUxi/aSYpKXZxYSBDadTN5Stb56jSxLmGH+o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(10067099003)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BcjJ+b4bubt130+JhuQrd2qruMeBfkylYjDcf94u+czWUYKMoLDN/IcFMruBP0a6utyZcIHJt441BbHUEy7ZP0yjLUZ9pI59WGaclNWiukOPKGotGcePG0mLgj8m1tRYsXWOLhmT8gm7aUs38UtsVVnPdplT1xS3Vy6EPAlq4EDwZYIQI9qheMJs2lWin6FCMopkiTNc21gIAyzzsGfED+RhwyJciXL0LhC7wUz+GGSE2pzltpxAVeDioiaWe/f8KPTLSSZgKZxp5FwgLt9CClBmhjnXq6ICM6h6RuTyHazL8F1L9i1AgOFOQqKbnTStrbW5x14hOZOj9nS7dxvaIgcTl8AG6D8eEDCAh7dQmb2dEnaQ8C/dsuG1rVhk/UX7iuDmcIt9b9NVdUMD3meR5ybVou7dZ3OYEBTfanXR0wzl+rcKPkJZsmoURJTy0OoK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:27.9409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2144ee8-7eb3-49d9-820b-08defa477cfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6228
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

Ras mp1 introduces common interfaces to manage mp1 data
obtained from different ASICs.

v2:
  Add mutex to ensure complete data transactions with MP1.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_mp1.c | 122 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/ras/core/ras_mp1.h |  44 +++++++++
 2 files changed, 161 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1.c b/drivers/gpu/drm/amd/ras/core/ras_mp1.c
index 12c9e20098c43..eccd6f16c35a7 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_mp1.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_mp1.c
@@ -50,23 +50,127 @@ int ras_mp1_get_bank_count(struct ras_core_context *ras_core,
 			    enum ras_err_type type, u32 *count)
 {
 	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+	int ret;
 
 	if (!mp1->ip_func || !mp1->ip_func->get_valid_bank_count)
 		return 0;
 
-	return mp1->ip_func->get_valid_bank_count(ras_core, type, count);
+	mutex_lock(&mp1->op_mutex);
+	ret = mp1->ip_func->get_valid_bank_count(ras_core, type, count);
+	mutex_unlock(&mp1->op_mutex);
+
+	return ret;
 }
 
 int ras_mp1_dump_bank(struct ras_core_context *ras_core,
 		u32 type, u32 idx, u64 *regs, u32 regs_sz)
 {
 	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+	int ret;
 
 	if (!mp1->ip_func || !mp1->ip_func->dump_valid_bank)
 		return 0;
 
-	return mp1->ip_func->dump_valid_bank(ras_core,
+	mutex_lock(&mp1->op_mutex);
+	ret = mp1->ip_func->dump_valid_bank(ras_core,
 				type, idx, regs, regs_sz);
+	mutex_unlock(&mp1->op_mutex);
+
+	return ret;
+}
+
+int ras_mp1_get_table_version(struct ras_core_context *ras_core,
+		u32 *table_version)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+	int ret;
+
+	if (!mp1->ip_func || !mp1->ip_func->get_table_version)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&mp1->op_mutex);
+	ret = mp1->ip_func->get_table_version(ras_core, table_version);
+	mutex_unlock(&mp1->op_mutex);
+
+	return ret;
+}
+
+bool ras_mp1_rma_detected(struct ras_core_context *ras_core)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+	int ret;
+
+	if (!mp1->ip_func || !mp1->ip_func->rma_detected)
+		return false;
+
+	mutex_lock(&mp1->op_mutex);
+	ret = mp1->ip_func->rma_detected(ras_core);
+	mutex_unlock(&mp1->op_mutex);
+
+	return ret;
+}
+
+int ras_mp1_set_timestamp(struct ras_core_context *ras_core,
+		u32 timestamp)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+	int ret;
+
+	if (!mp1->ip_func || !mp1->ip_func->set_timestamp)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&mp1->op_mutex);
+	ret = mp1->ip_func->set_timestamp(ras_core, timestamp);
+	mutex_unlock(&mp1->op_mutex);
+
+	return ret;
+}
+
+int ras_mp1_reset_ras_table(struct ras_core_context *ras_core,
+		u32 *result)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+	int ret;
+
+	if (!result || !mp1->ip_func || !mp1->ip_func->reset_ras_table)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&mp1->op_mutex);
+	ret = mp1->ip_func->reset_ras_table(ras_core, result);
+	mutex_unlock(&mp1->op_mutex);
+
+	return ret;
+}
+
+int ras_mp1_get_record_count(struct ras_core_context *ras_core, u32 *count)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+	int ret;
+
+	if (!count || !mp1->ip_func || !mp1->ip_func->get_record_count)
+		return 0;
+
+	mutex_lock(&mp1->op_mutex);
+	ret = mp1->ip_func->get_record_count(ras_core, count);
+	mutex_unlock(&mp1->op_mutex);
+
+	return ret;
+}
+
+int ras_mp1_get_record(struct ras_core_context *ras_core,
+		u32 idx, struct eeprom_err_record *rec)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+	int ret;
+
+	if (!rec || !mp1->ip_func || !mp1->ip_func->get_record)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&mp1->op_mutex);
+	ret = mp1->ip_func->get_record(ras_core, idx, rec);
+	mutex_unlock(&mp1->op_mutex);
+
+	return ret;
 }
 
 int ras_mp1_set_debug_mode(struct ras_core_context *ras_core, bool enable)
@@ -86,21 +190,29 @@ int ras_mp1_hw_init(struct ras_core_context *ras_core)
 
 	mp1->mp1_ip_version = ras_core->config->mp1_ip_version;
 
-	if (ras_core->config->mp1_cfg.mp1_sys_fn)
+	if (ras_core->config && ras_core->config->mp1_cfg.mp1_sys_fn)
 		mp1->sys_func = ras_core->config->mp1_cfg.mp1_sys_fn;
 
 	mp1->ip_func = ras_mp1_get_ip_funcs(ras_core, mp1->mp1_ip_version);
 	if (!mp1->ip_func)
 		return -EINVAL;
 
+	mutex_init(&mp1->op_mutex);
+
 	ret = ras_mp1_set_debug_mode(ras_core, false);
-	if (ret)
-		return -EINVAL;
+	if (ret) {
+		mutex_destroy(&mp1->op_mutex);
+		return ret;
+	}
 
 	return ret;
 }
 
 int ras_mp1_hw_fini(struct ras_core_context *ras_core)
 {
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+
+	mutex_destroy(&mp1->op_mutex);
+
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1.h b/drivers/gpu/drm/amd/ras/core/ras_mp1.h
index 17499e1c9c54b..a00eb8117885b 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_mp1.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_mp1.h
@@ -25,6 +25,26 @@
 #define __RAS_MP1_H__
 #include "ras.h"
 
+struct eeprom_err_record {
+	u32 timestamp;
+
+	union {
+		struct {
+			u32 mca_addr_low;
+			u32 mca_addr_high;
+		};
+		u64 mca_addr;
+	};
+
+	union {
+		struct {
+			u32 ipid_low;
+			u32 ipid_high;
+		};
+		u64 ipid;
+	};
+};
+
 enum ras_err_type;
 struct ras_mp1_ip_func {
 	int (*get_valid_bank_count)(struct ras_core_context *ras_core,
@@ -32,12 +52,26 @@ struct ras_mp1_ip_func {
 	int (*dump_valid_bank)(struct ras_core_context *ras_core,
 		enum ras_err_type type, u32 idx, u64 *regs, u32 regs_sz);
 	int (*set_debug_mode)(struct ras_core_context *ras_core, bool enable);
+
+	/* The following is used for firmware management of EEPROM */
+	int (*get_table_version)(struct ras_core_context *ras_core,
+			u32 *table_version);
+	bool (*rma_detected)(struct ras_core_context *ras_core);
+	int (*set_timestamp)(struct ras_core_context *ras_core,
+			u32 timestamp);
+	int (*reset_ras_table)(struct ras_core_context *ras_core,
+			u32 *result);
+	int (*get_record_count)(struct ras_core_context *ras_core,
+			u32 *count);
+	int (*get_record)(struct ras_core_context *ras_core,
+			u32 idx, struct eeprom_err_record *rec);
 };
 
 struct ras_mp1 {
 	uint32_t mp1_ip_version;
 	const struct ras_mp1_ip_func *ip_func;
 	const struct ras_mp1_sys_func *sys_func;
+	struct mutex op_mutex;
 };
 
 int ras_mp1_hw_init(struct ras_core_context *ras_core);
@@ -50,4 +84,14 @@ int ras_mp1_dump_bank(struct ras_core_context *ras_core,
 		u32 ecc_type, u32 idx, u64 *regs, u32 regs_sz);
 
 int ras_mp1_set_debug_mode(struct ras_core_context *ras_core, bool enable);
+int ras_mp1_get_table_version(struct ras_core_context *ras_core,
+		u32 *table_version);
+bool ras_mp1_rma_detected(struct ras_core_context *ras_core);
+int ras_mp1_set_timestamp(struct ras_core_context *ras_core,
+		u32 timestamp);
+int ras_mp1_reset_ras_table(struct ras_core_context *ras_core,
+		u32 *result);
+int ras_mp1_get_record_count(struct ras_core_context *ras_core, u32 *count);
+int ras_mp1_get_record(struct ras_core_context *ras_core,
+		u32 idx, struct eeprom_err_record *rec);
 #endif
-- 
2.55.0

