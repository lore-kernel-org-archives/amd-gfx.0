Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C8ACA5FFC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 13:18:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31D4710F59D;
	Wed,  7 Oct 2026 13:18:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qAZJOdmk";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011036.outbound.protection.outlook.com [52.101.62.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F379510F5B3
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 13:18:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVuEAsWPEvh3GClq5RUdXr7SHDJGA7Tc4zx1jLdnqL1R5ontK0JvwFOIktgnyfJVMMWT6zt9zKcbVVZN//NGqB/MXqtuW9E0tMrzLFcU5/58px/bnA8oOb5rCeojLFc6tocfyMTOB/T7xRci2pdhfSjw3MDzxhVLqHbiJtPhWgbEvipjlT9cfbD6xYCIFR26q715cTZmiaO7LuRZH7xeB/x6zY7J2YUopRL0/z/BKVvwuaqxcebZqLVpFGBwOuANAFuPcLISbgZ5FoN3RebUwLKyRqyk+1uecaIIE4OKfGCjRYnp2qN7Th75dHVh5SjwbVsZ1BxH83y7uhUmbicwGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/p5j6AgJMx06adsdQIJCcZidHhz64ujKdYBHE4b3Lc8=;
 b=JqEgrNUGuNG9dsO5klp09Ng/mkaoYHsSyL5LFUsLgoxLTRMXbHl+YeEznc0v9Om/lcqOsznzUmVaHtEqfTb0CEVK+MpR5TBv3Nz1pKW2xk7U2ViNPdXgA+ORtomL4btuSpQJTikiB9/oMj5WxzxuTpbeQ9IDSCBeyms+L+EmQgcsaoKWJG2OuliXkP2R/laQDSHTNfN/JEzVDV4KBvlxUvvh00m6dv77oyqv0pYGXhB/DfwL/knzDVq8BvpPeez+xmVZDpkvx6omZ9o296cv6RWXIjSDHtab018mWJADHroln1801yNlaDbh4Jm7alTvHGuCJr6GIitezqig3MPy2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/p5j6AgJMx06adsdQIJCcZidHhz64ujKdYBHE4b3Lc8=;
 b=qAZJOdmksWr+yvw6QfI/EGAk2vRmlC6+QokyrUfXkBO199YuRipVrny/9W0EhUIBTAAYz6evMDPsCoz6//johD3f7AzRUZ2F9/GWSRlRZHWiIhkOtEqKOpiSdKY2tZCTRZSXlOYSVRsG2afJKGz8Zti1EAV0cOq3q5Oc1CiajgI=
Received: from MN0PR02CA0005.namprd02.prod.outlook.com (2603:10b6:208:530::26)
 by CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.21; Wed, 7 Oct
 2026 13:17:58 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:530:cafe::67) by MN0PR02CA0005.outlook.office365.com
 (2603:10b6:208:530::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 13:17:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 13:17:58 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:17:42 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <Kevin.Wang@amd.com>,
 <asad.kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Notify node unload during driver unload
Date: Wed, 7 Oct 2026 21:17:29 +0800
Message-ID: <20261007131729.354578-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|CH3PR12MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: 583f0110-e74b-415a-004e-08df247567fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: HsVKlTVKxPNk4E7OMMJWPdwvnPjHZzOtoAnm555d3FGEUULRXuilvsE/v9D7uH5Roz90V2auAGXW9viKBZ/iw3NLM3EcyEOUk0poQObQVWh7Y0wwnzOS5U6GDzIZfd/Rt7vuApIoS+8/DYJDcKAWEkbZA8xGneLMYfoe6hU6oKqs9i2kSSucer9z1dBE+nSKChhV1g8agFiWfNQCyYYcOtwnvbn6RQE9jg7lBaSb5UlgOKelDe22Mo30MrRN63cY3I2wPFAOyD/WntqUeI9G29O+IIvIURT5hg4cNXaWoY3HAv+cuSGIxXVqU4RTEe3SwsnMCW8q+kpLq7H+TGVaF30izfMhsAd7iihDRs9mBxrfWga1OxOWgkqE0Q1jDG7XCD5KJQZxX34e2BU6dnf+tvICPC3ag/1CkgFj7+Ejkg2UR7w/TXUzX0bgIIsEpl5CEmJKbhjMLkrJ97Y/btinYLMxsazgKCMwFSRrAkE7Xxh9+oUYObnuHEZwmwJbNKc15CuFr0HxlWaVNhCjifkZUZHZ+JRHBg81UVsy35ZfbPGkBl57FqczldZn4vjnU+1NkETaS2Vzbv1ILN2rQh+ksJl32Jl4UC7vFbm9/Eb1fkeh6gM03nXAbZs1glCkQ5sNoMaoivquC3AwyuG2XVX66banUVd6r9o/zbyCqz+IVh1ZSRRT/08X8J+9KuDY8+PF2ioUKZ1n7rsC9b00hzbWgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lzGW1GPnzsKddXaRjrIXSazbWTgS17RtXdk3Zf+2wKv7MtCu0moKBzSzWv8Szhh5dTNgMQ+T+bLOysacp/Iq/PecsBQBwApi25dRmJNJ/V96afz0R3E07nm/K9DcwWeisKFD2EgMVUtMrcvefYicJ+BKLqZhiQSVV+wQ3TQ2J9GMMis+CD8+IQMZvj0PySZ5Vh6Xtxjp1+nZJB6rXjj0hfSI3dhLh+LVPKSQt6z5pYRqKogLUhe3SPe6iQ+X51xCTDlfhyxmzwYbq7MeglY8+dpDgwwApaEt3H2wkaPSUC+mjEAf0Ajbm3SkNcTId8BM89WdmYUWGLIxz7IuKZy6TzcbqsRU3o86oreolX6M/qeoQr5KHDH7YEr7xlKIpJQqeuvnyMPNdWgrTMMPC8iHoDtnb/d5r9ZaFGAuVXkNVHCbYgH/sOcN+uS7fvHTqYi4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:17:58.3878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 583f0110-e74b-415a-004e-08df247567fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212
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

Notify node unload on smu_v15_0_8 during driver unload

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v15_0_8_ppsmc.h  |  3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h  |  1 +
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 60 +++++++++++++++++++
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h  |  2 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 26 ++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  2 +
 7 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_ppsmc.h
index bf73d10c0ce7..888261c26409 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_ppsmc.h
@@ -85,7 +85,8 @@
 #define PPSMC_MSG_SetSoftMaxFclk	                0x34
 /* NPM limit setter; NPM reads are served from the SystemMetricsTable. */
 #define PPSMC_MSG_SetNpmLimit                       0x40
-#define PPSMC_Message_Count                         0x41
+#define PPSMC_MSG_PrepareNodeForUnload              0x41
+#define PPSMC_Message_Count                         0x42
 
 /* PSMC Reset Types for driver msg argument */
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index f86201764814..31b4ef025351 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -306,7 +306,8 @@
 	__SMU_DUMMY_MAP(SetSoftMaxGl2clk), \
 	__SMU_DUMMY_MAP(SetSoftMinGl2clk), \
 	__SMU_DUMMY_MAP(GetSystemMetricsVersion), \
-	__SMU_DUMMY_MAP(SetNpmLimit),
+	__SMU_DUMMY_MAP(SetNpmLimit), \
+	__SMU_DUMMY_MAP(PrepareNodeForUnload),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
index 0c97bee2c4bb..f443000ba657 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
@@ -89,6 +89,7 @@ struct smu_15_0_dpm_context {
 	uint32_t                    workload_policy_mask;
 	uint32_t                    dcef_min_ds_clk;
 	uint64_t                    caps;
+	bool			    node_unload;
 	uint32_t		    board_volt;
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index e7213f3ebf63..82c2a379ba4b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -25,6 +25,7 @@
 
 #include <linux/firmware.h>
 #include "amdgpu.h"
+#include "amdgpu_xgmi.h"
 #include "amdgpu_smu.h"
 #include "smu_v15_0_8_pmfw.h"
 #include "smu15_driver_if_v15_0_8.h"
@@ -138,6 +139,7 @@ static const struct cmn2asic_msg_mapping smu_v15_0_8_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(SetSoftMinFclk,                      PPSMC_MSG_SetSoftMinFclk,			0),
 	MSG_MAP(SetSoftMaxFclk,                      PPSMC_MSG_SetSoftMaxFclk,			0),
 	MSG_MAP(SetNpmLimit,                         PPSMC_MSG_SetNpmLimit,			0),
+	MSG_MAP(PrepareNodeForUnload,                PPSMC_MSG_PrepareNodeForUnload,		0),
 };
 
 /* TODO: Update the clk map once enum PPCLK is updated in smu15_driver_if_v15_0_8.h */
@@ -635,9 +637,22 @@ static void smu_v15_0_8_init_npm_cap(struct smu_context *smu)
 	smu_v15_0_8_cap_set(smu, SMU_15_0_8_CAP_NPM);
 }
 
+static void smu_v15_0_8_init_node_unload_cap(struct smu_context *smu)
+{
+	uint32_t fw_ver = smu->smc_fw_version;
+	uint32_t pgm = (fw_ver >> 24) & 0xFF;
+
+	if (smu_v15_0_8_cap_supported(smu, SMU_15_0_8_CAP_NODE_UNLOAD))
+		return;
+
+	if (pgm == 2 && fw_ver >= SMU_15_0_8_NODE_UNLOAD_MIN_FW_VERSION)
+		smu_v15_0_8_cap_set(smu, SMU_15_0_8_CAP_NODE_UNLOAD);
+}
+
 static void smu_v15_0_8_init_caps(struct smu_context *smu)
 {
 	smu_v15_0_8_init_npm_cap(smu);
+	smu_v15_0_8_init_node_unload_cap(smu);
 }
 
 static u64 smu_v15_0_8_get_npm_cap(struct smu_context *smu)
@@ -1366,8 +1381,46 @@ static int smu_v15_0_8_register_irq_handler(struct smu_context *smu)
 	return ret;
 }
 
+static void smu_v15_0_8_notify_node_unload(struct smu_context *smu)
+{
+	if (!smu_v15_0_8_cap_supported(smu, SMU_15_0_8_CAP_NODE_UNLOAD))
+		return;
+
+	smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PrepareNodeForUnload, 0, NULL);
+}
+
+static void smu_v15_0_8_mark_node_unload(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	struct amdgpu_hive_info *hive;
+	struct amdgpu_device *peer;
+	struct smu_context *peer_smu;
+	struct smu_15_0_dpm_context *dpm;
+
+	hive = amdgpu_get_xgmi_hive(adev);
+	if (!hive) {
+		dpm = smu->smu_dpm.dpm_context;
+		if (dpm)
+			dpm->node_unload = true;
+		return;
+	}
+
+	list_for_each_entry(peer, &hive->device_list, gmc.xgmi.head) {
+		peer_smu = peer->powerplay.pp_handle;
+		if (!peer_smu)
+			continue;
+		dpm = peer_smu->smu_dpm.dpm_context;
+		if (dpm)
+			dpm->node_unload = true;
+	}
+
+	amdgpu_put_xgmi_hive(hive);
+}
+
 static int smu_v15_0_8_notify_unload(struct smu_context *smu)
 {
+	struct smu_context *primary_smu;
+	struct smu_15_0_dpm_context *dpm = smu->smu_dpm.dpm_context;
 	struct smu_msg_ctl *ctl = &smu->msg_ctl;
 	struct smu_msg_args args = {
 		.msg     = SMU_MSG_PrepareMp1ForUnload,
@@ -1377,6 +1430,13 @@ static int smu_v15_0_8_notify_unload(struct smu_context *smu)
 	if (amdgpu_in_reset(smu->adev))
 		return 0;
 
+	if (dpm && !dpm->node_unload) {
+		primary_smu = smu_get_primary_dev(smu);
+		if (primary_smu)
+			smu_v15_0_8_notify_node_unload(primary_smu);
+		smu_v15_0_8_mark_node_unload(smu);
+	}
+
 	dev_dbg(smu->adev->dev, "Notify PMFW about driver unload");
 	/* Ignore return, just intimate FW that driver is not going to be there */
 	ctl->ops->send_msg(ctl, &args);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
index bc0f20e43e0a..dff601bc0f9a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
@@ -33,6 +33,8 @@
 #define SMU_15_0_8_MAX_MID 2
 #define SMU_15_0_8_MAX_HBM_STACKS 12
 #define SMU_15_0_8_CAP_NPM			1
+#define SMU_15_0_8_CAP_NODE_UNLOAD		2
+#define SMU_15_0_8_NODE_UNLOAD_MIN_FW_VERSION	0x027d0c00u /* 2.125.12.0 */
 extern void smu_v15_0_8_set_ppt_funcs(struct smu_context *smu);
 
 typedef struct {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 2bd3ea17e789..ff59bf19c3e7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -27,6 +27,32 @@
 #include "smu_cmn.h"
 #include "soc15_common.h"
 
+#include "amdgpu_xgmi.h"
+
+struct smu_context *smu_get_primary_dev(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	struct amdgpu_hive_info *hive;
+	struct amdgpu_device *peer;
+
+	if (adev->gmc.xgmi.physical_node_id == 0)
+		return smu;
+
+	hive = amdgpu_get_xgmi_hive(adev);
+	if (!hive)
+		return NULL;
+
+	list_for_each_entry(peer, &hive->device_list, gmc.xgmi.head) {
+		if (peer->gmc.xgmi.physical_node_id == 0) {
+			amdgpu_put_xgmi_hive(hive);
+			return peer->powerplay.pp_handle;
+		}
+	}
+
+	amdgpu_put_xgmi_hive(hive);
+	return NULL;
+}
+
 /*
  * DO NOT use these for err/warn/info/debug messages.
  * Use dev_err, dev_warn, dev_info and dev_dbg instead.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index ae6742f5298f..6d7f47c934f2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -249,6 +249,8 @@ int smu_cmn_dpm_pcie_gen_idx(int gen);
 int smu_cmn_dpm_pcie_width_idx(int width);
 int smu_cmn_check_fw_version(struct smu_context *smu);
 
+struct smu_context *smu_get_primary_dev(struct smu_context *smu);
+
 int smu_cmn_get_pptable_from_firmware(struct smu_context *smu, void **table,
 				      uint32_t *size, uint32_t pptable_id);
 
-- 
2.46.0

