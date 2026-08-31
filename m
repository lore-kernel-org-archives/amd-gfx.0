Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7997C624D2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A62910EA78;
	Mon, 31 Aug 2026 18:29:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ftzKoAAy";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012064.outbound.protection.outlook.com
 [40.93.195.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F8E110EA66
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTefRiRMSBuZ5XBdXGhzoJ1ATBXfigjQPhSJvwNgKyzbbhH2Tx2ajMXuC/9LZwIzqqL7DbRYWrUWzEKkZpti4+ajau6nqDz0nmp0VO9n6t2bto1bt1UW4iK32I2cNeObt6u4tWkR7JJ2NimeY+x28n40QbBAoKlKX1DC5ksdOPBohIqWxD4QSeFM0O1VUUPNNnWl4fJEH6D2XyQ+/gSG5UV9AS1UnYuUrL8GQWcVvIAqCtPzvnFZ38HbzaqHMEwtuN/NXab+H1P9s4uW+CgG/Fho5koqPGiScAl7HKrDFTqm1nZcuW1YyuGHwnC9oJ+qjttpXuJPGn4rj2B+rsFhLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSpYNyC9afixRKyiB9r4AqKU39tW6MoR1LyBP/GmDTc=;
 b=UR6t6svDi8rUIgVeJK+uq4kMc/NAgRsQfU4mMfFeZN1E1RQsCbwvijm4m5UyJjocNLUuqqYS4zgIT7562F3dTzjnwXe63r8qPEr4swtYavam6oQuK/KrG37ruK4up2zfy1mdBgpGFe8i1PwkF8oYrwkb9EUvWMGths5tE2vwWs+Biaa/3Ab966fnywSyK+AYe/0fhuB3RKEum/+kRNn4tJQQiWM1aJ1DLmai5sZoK9lGi2CuAliGhXq0g47HYyr5fKyzePB50LTTmMEsoENRTtW7wOF4FuPS8nMAlGXnqmYJkRGVmk2CuPxLEyMEd34chlCyjzQg+M9/N6ya/9wdDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSpYNyC9afixRKyiB9r4AqKU39tW6MoR1LyBP/GmDTc=;
 b=ftzKoAAyx6EGgrIuAxH5Gl45g1sHbM5cmPIcCHQNZWkIj0QBsLcVjwnwApCLhBuTv5Kfcc4zBJB4Q/wAULl+BL+jJBD15jhfRCaXI33juCNLI95ykyUvkjnqGLIQtAFtnkkExJhfV7mKNvYoKt6ySDSLExi3LpqYbaQwMFV9wrg=
Received: from CH0PR04CA0094.namprd04.prod.outlook.com (2603:10b6:610:75::9)
 by SJ0PR12MB6968.namprd12.prod.outlook.com (2603:10b6:a03:47b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:12 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::4) by CH0PR04CA0094.outlook.office365.com
 (2603:10b6:610:75::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:29:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:11 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:56 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 78/95] drm/amdgpu: Assign accel state based on ASP config
Date: Mon, 31 Aug 2026 14:27:37 -0400
Message-ID: <20260831182754.1089811-79-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|SJ0PR12MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e41bd2-3935-4a16-74ab-08df078dc103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: CxpoCE6o91cu6SwESOCjwXdyKK1JX+b/ylwLK6GD7FtutL0WE97+0u0NDISOUaf/oZ7c2Cd9md45EzbwNQedjUcOY89+4aRhpTLPnkHl/PGbFbhIuTQ6C4ZxjFKVIl7uWzA2AN7sUN9+JRUDBiwzJ7e6brIjGP2jvKF7HviuILWrcb1EvCOXwbuk51mCKkEqpxKtJQT9GXcut3ap4gVWfX/P49mYDP5cswEhNxNmWJWGy8T+8wR1vdjk7SGfWvSgfFzefyoi2nTOrwk+rTlPQ7OMEFToOjyHeyzUivmWGvEV/odUTBkCdZFHKTorDYIJI4L0MVtrKn1CkSkpfbY75xtDSLgMx0M00iyHdPotvNTt7rnswlThx4JfC6qHts2dZyRaZF5FQSthbzS4ssG+wHT1mBflyso2BE58+O1aqrN43y5qT4vG2wiuiP94mb/uQBl/WvwG2+kT5JM9irxAQsWZda6wILcLDblPFEqXElnqmtqOZ1UCZBSPv9RaP9rcbC+jkw5DCXQoeII2zstpVX/utjayQ9EKeZ4uQkFUz72vWcpDOzXIbroyzWHTCzaxhG/nj+hHlKy8nVjqBPMGA9dSOj4DJ1Lsr7XXpZBiBrBTfC4TP5tbpdWV/CgOXJVOfuXk0uQc6vx1SYbxEiHSBnd9Er5oqFOjysozSBsGRzI1Q4f4iKsMnESm5PDev0exVmeL9YYxAdiHUOMmbS4IwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: evl3gzeapbzLEq69CpEsZqGtAxOfnEx6lJyxSz6CN3nvO5GIcO/Hjjpk85Pus2fCqQbnNR5cmKl2mDWDo4TnzhKWaSmpk6u+Ebo9lMp2H+tSHTSbLFgVbylD4kMF7ABwCYjpqXJEU0FZUtoSiLo71Gnw5gN8OHnPTCDFAFpaEPT2I0mSaeVorh4sws/5fC95QBc40w2EWSnx3MNDQNiyECFTsWYrWblk4t+0KIubZGQ0QGJnYgF2jVW0puxolVmYKvnSc6IaLtpE3yRvXA8fnbwmADH+Sec7aD2s+5xAPhW7JXMBbpL2Fmo9c5tdPfD12nsncSaOwgcwD813ejGJv2fCcujgGhWUT/QRs7EccIEQ2fP9lJJkmrHgIPzE3/wsBpi/jOHqxx9KXN/PevyD2rM1EWhp96nxMRz17RRULxZc90OQqU5ExlGskDMK5jCy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:11.9454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e41bd2-3935-4a16-74ab-08df078dc103
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6968
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

From: Lijo Lazar <lijo.lazar@amd.com>

Add explicit PPOD/VPOD states for clarity. Assign the state accordingly
as received from ASP during initialization.

UALink accel state transitions:

UNCONFIGURED -> PPOD_CONFIGURED -> VPOD_CONFIGURED -> READY -> ACTIVE

- PPOD: sysfs ppod commit/ ASP {UAL_CFG_PPOD}
- VPOD: sysfs vpod commit/ ASP {UAL_CFG_VPOD} | {UAL_CFG_STATION}
- READY: local vpod integrity + activate_accelerator()
- ACTIVE: all local gpus belonging to one vpod are configured and ready.

deactivate_accelerator(): READY -> PPOD_CONFIGURED
invalid vpod: -> ERROR

Query ualink info during late init phase. Add a local vpod integrity
check before activating devices in the vpod. Move the devices to active
state once integrity check passes.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 346 +++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |   3 +-
 4 files changed, 293 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index b8def8b7e1426..4fc7aed58bfc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1223,7 +1223,8 @@ int psp_ual_get_interface_version(struct psp_context *psp, uint32_t *intf_ver)
 }
 
 int psp_ual_query_info(struct psp_context *psp, uint32_t intf_ver,
-		       struct amdgpu_ualink_info *info)
+		       struct amdgpu_ualink_info *info,
+		       enum psp_gfx_ual_config_state *cfg_state)
 {
 	struct psp_gfx_get_config_ual_v1 *ual_config;
 	struct psp_gfx_cmd_resp *cmd;
@@ -1269,6 +1270,9 @@ int psp_ual_query_info(struct psp_context *psp, uint32_t intf_ver,
 		if (AMDGPU_UALINK_ACCEL_MAX > PSP_GFX_UAL_MAX_ACC_BIT_MASK*32)
 			bitmap_clear(info->vpod.active_accel_bits, PSP_GFX_UAL_MAX_ACC_BIT_MASK*32,
 				     AMDGPU_UALINK_ACCEL_MAX - PSP_GFX_UAL_MAX_ACC_BIT_MASK*32);
+
+		if (cfg_state)
+			*cfg_state = ual_config->config_state;
 	} else if (!ret) {
 		ret = -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index bb84f3a3dc54b..2ba7ced36b7cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -715,7 +715,8 @@ struct amdgpu_ualink_station_config;
 int psp_ual_get_interface_version(struct psp_context *psp, uint32_t *intf_ver);
 
 int psp_ual_query_info(struct psp_context *psp, uint32_t intf_ver,
-		       struct amdgpu_ualink_info *info);
+		       struct amdgpu_ualink_info *info,
+		       enum psp_gfx_ual_config_state *cfg_state);
 
 int psp_ual_set_ppod_config(struct psp_context *psp, uint32_t intf_ver,
 			    const struct amdgpu_ualink_ppod_setup *setup);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index ec34d5bc4dc03..3cae3f49bb31f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -29,10 +29,12 @@
 #include "amdgpu_ualink.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_dma_buf.h"
+#include "psp_gfx_if.h"
 #include <linux/math.h>
 #include <linux/sysfs.h>
 #include <linux/string.h>
 
+static void amdgpu_ualink_activate_vpod(struct amdgpu_device *adev);
 static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
 				u32 remote_accel_id, u32 dw0, u32 dw1,
 				u32 dw2, u32 dw3);
@@ -95,6 +97,113 @@ static void amdgpu_ualink_object_fini(struct amdgpu_device *adev)
 	adev->ualink.info = NULL;
 }
 
+static bool __check_ppod_info(struct amdgpu_device *adev,
+			      const struct amdgpu_ualink_info *info)
+{
+	const struct amdgpu_ualink_ppod_info *ppod = &info->ppod;
+
+	if (ppod->size <= 0 || ppod->size > AMDGPU_UALINK_ACCEL_MAX) {
+		dev_dbg(adev->dev, "pPod size %u out of range [1..%u]\n",
+			ppod->size, AMDGPU_UALINK_ACCEL_MAX);
+		return false;
+	}
+	if (ppod->accel_id >= ppod->size) {
+		dev_dbg(adev->dev,
+			"Accelerator ID %u greater or equal pPod size %u\n",
+			ppod->accel_id, ppod->size);
+		return false;
+	}
+
+	return true;
+}
+
+static bool __check_vpod_info(struct amdgpu_device *adev,
+			      const struct amdgpu_ualink_info *info)
+{
+	const struct amdgpu_ualink_ppod_info *ppod = &info->ppod;
+	const struct amdgpu_ualink_vpod_info *vpod = &info->vpod;
+	unsigned int weight;
+
+	if (vpod->size == 0 || vpod->size > ppod->size) {
+		dev_dbg(adev->dev, "vPod size %u out of range [1..%u]\n",
+			vpod->size, ppod->size);
+		return false;
+	}
+	if (vpod->addr_mode >= AMDGPU_UALINK_ADDR_MODE_MAX) {
+		dev_dbg(adev->dev, "Invalid addr mode %u\n", vpod->id);
+		return false;
+	}
+	weight =
+		bitmap_weight(vpod->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX);
+	if (weight != vpod->size) {
+		dev_dbg(adev->dev,
+			"vPod size doesn't match vpod_active_accels list: %u != %u\n",
+			vpod->size, weight);
+		return false;
+	}
+	if (!test_bit(ppod->accel_id, vpod->active_accel_bits)) {
+		dev_dbg(adev->dev,
+			"Accelerator ID %u not listed in vpod_active_accels\n",
+			ppod->accel_id);
+		return false;
+	}
+
+	return true;
+}
+
+static void
+amdgpu_ualink_info_set_accel_state(struct amdgpu_device *adev,
+				   struct amdgpu_ualink_info *info,
+				   enum psp_gfx_ual_config_state cfg_state)
+{
+	if (!info)
+		return;
+
+	switch (cfg_state) {
+	case UAL_CFG_IDLE:
+		break;
+	case UAL_CFG_PPOD:
+		if (!__check_ppod_info(adev, info)) {
+			info->accel_state =
+				AMDGPU_UALINK_ACCEL_STATE_UNCONFIGURED;
+			break;
+		}
+		info->accel_state = AMDGPU_UALINK_ACCEL_STATE_PPOD_CONFIGURED;
+		break;
+	case UAL_CFG_VPOD:
+	case UAL_CFG_STATION:
+		if (!__check_vpod_info(adev, info)) {
+			info->accel_state = AMDGPU_UALINK_ACCEL_STATE_ERROR;
+			dev_err(adev->dev,
+				"vpod configuration is invalid, setting to error state");
+			break;
+		}
+		info->accel_state = AMDGPU_UALINK_ACCEL_STATE_VPOD_CONFIGURED;
+		break;
+	case UAL_CFG_COMPLETE:
+		info->accel_state = AMDGPU_UALINK_ACCEL_STATE_READY;
+		break;
+	default:
+		dev_dbg(adev->dev, "invalid configuration state %u", cfg_state);
+		break;
+	}
+}
+
+static int amdgpu_ualink_query_info(struct amdgpu_device *adev)
+{
+	enum psp_gfx_ual_config_state cfg_state;
+	int r;
+
+	r = psp_ual_query_info(&adev->psp, adev->ualink.psp_if_ver,
+			       adev->ualink.info, &cfg_state);
+	if (r)
+		return r;
+
+	amdgpu_ualink_info_set_accel_state(adev, adev->ualink.info, cfg_state);
+
+	return 0;
+}
+
 int ualink_ip_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -103,6 +212,7 @@ int ualink_ip_hw_init(struct amdgpu_ip_block *ip_block)
 	if (!adev->ualink.info)
 		return 0;
 
+	adev->ualink.info->accel_state = AMDGPU_UALINK_ACCEL_STATE_UNCONFIGURED;
 	r = psp_ual_get_interface_version(&adev->psp, &adev->ualink.psp_if_ver);
 	if (r) {
 		adev->ualink.psp_if_ver = 0xffffffff;
@@ -114,19 +224,9 @@ int ualink_ip_hw_init(struct amdgpu_ip_block *ip_block)
 	dev_info(adev->dev, "Found UALink interface version 0x%x\n",
 		 adev->ualink.psp_if_ver);
 
-	r = psp_ual_query_info(&adev->psp, adev->ualink.psp_if_ver,
-			       adev->ualink.info);
-	if (r) {
-		dev_info(adev->dev,
-			 "UALink disabled, failed to query initial config: %d\n",
-			 r);
-		goto disable;
-	}
-
 	adev->ualink.mgr_state = AMDGPU_UALINK_INIT_HW;
 
 	return 0;
-
 disable:
 	adev->ualink.mgr_state = AMDGPU_UALINK_INIT_ERROR;
 	return 0;
@@ -140,6 +240,12 @@ int ualink_ip_late_init(struct amdgpu_ip_block *ip_block)
 	if (adev->ualink.mgr_state != AMDGPU_UALINK_INIT_HW)
 		return 0;
 
+	r = amdgpu_ualink_query_info(adev);
+	if (r)
+		return r;
+
+	amdgpu_ualink_activate_vpod(adev);
+
 	r = amdgpu_ualink_drm_client_create(adev);
 	if (r) {
 		dev_err(adev->dev, "Failed to create UALink DRM client: %d\n",
@@ -427,8 +533,15 @@ static const char * const ualink_addr_mode_values[] = {
 	"source-aliasing", "source-identification"
 };
 static const char * const ualink_accel_state_values[] = {
-	"unconfigured", "configured", "ready", "active", "error"
+	[AMDGPU_UALINK_ACCEL_STATE_UNCONFIGURED]	= "unconfigured",
+	[AMDGPU_UALINK_ACCEL_STATE_PPOD_CONFIGURED]	= "ppod_configured",
+	[AMDGPU_UALINK_ACCEL_STATE_VPOD_CONFIGURED]	= "vpod_configured",
+	[AMDGPU_UALINK_ACCEL_STATE_READY]		= "ready",
+	[AMDGPU_UALINK_ACCEL_STATE_ACTIVE]		= "active",
+	[AMDGPU_UALINK_ACCEL_STATE_ERROR]		= "error",
 };
+static_assert(ARRAY_SIZE(ualink_accel_state_values) ==
+	      AMDGPU_UALINK_ACCEL_STATE_MAX);
 
 UALINK_ENUM_SHOW(info, link_type, link_type);
 UALINK_VALUE_SHOW(info, accel_id,  ppod.accel_id,  "%u");
@@ -515,7 +628,7 @@ check_ppod_state(struct amdgpu_device *adev,
 			setup->ppod.accel_id, setup->ppod.size);
 		return AMDGPU_UALINK_ACCEL_STATE_UNCONFIGURED;
 	}
-	return AMDGPU_UALINK_ACCEL_STATE_CONFIGURED;
+	return AMDGPU_UALINK_ACCEL_STATE_PPOD_CONFIGURED;
 }
 
 static ssize_t ualink_ppod_setup_commit_store(struct kobject *kobj,
@@ -536,7 +649,7 @@ static ssize_t ualink_ppod_setup_commit_store(struct kobject *kobj,
 				    setup);
 	if (r)
 		return r;
-	r = psp_ual_query_info(&adev->psp, adev->ualink.psp_if_ver, info);
+	r = psp_ual_query_info(&adev->psp, adev->ualink.psp_if_ver, info, NULL);
 	if (r)
 		return r;
 
@@ -624,53 +737,14 @@ static bool amdgpu_ualink_is_local_accel(struct amdgpu_device *adev,
 }
 
 #ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
-UALINK_VALUE_SHOW(vpod_config, vpod_id,   vpod.id,   "%u");
-UALINK_VALUE_SHOW(vpod_config, vpod_size, vpod.size, "%u");
-UALINK_IDBITS_SHOW(vpod_config, vpod_active_accels, vpod.active_accel_bits);
-UALINK_ENUM_SHOW(vpod_config, addr_mode, vpod.addr_mode);
-
-UALINK_VALUE_STORE(vpod_config, vpod_id,   vpod.id,   u32, 10);
-UALINK_VALUE_STORE(vpod_config, vpod_size, vpod.size, u32, 10);
-UALINK_IDBITS_STORE(vpod_config, vpod_active_accels, vpod.active_accel_bits,
-		    AMDGPU_UALINK_ACCEL_MAX);
-UALINK_ENUM_STORE(vpod_config, addr_mode, vpod.addr_mode);
-
 static bool check_vpod_info(struct amdgpu_device *adev,
 			    const struct amdgpu_ualink_info *info)
 {
-	unsigned int weight;
-
-	if (info->accel_state < AMDGPU_UALINK_ACCEL_STATE_CONFIGURED) {
+	if (info->accel_state < AMDGPU_UALINK_ACCEL_STATE_PPOD_CONFIGURED) {
 		dev_dbg(adev->dev, "pPod is not yet configured\n");
 		return false;
 	}
-	if (info->vpod.id >= AMDGPU_UALINK_ACCEL_MAX) {
-		dev_dbg(adev->dev, "vPod ID %u out of range [0..%u]\n",
-			info->vpod.id, AMDGPU_UALINK_ACCEL_MAX - 1);
-		return false;
-	}
-	if (info->vpod.size == 0 || info->vpod.size > info->ppod.size) {
-		dev_dbg(adev->dev, "vPod size %u out of range [1..%u]\n",
-			info->vpod.size, info->ppod.size);
-		return false;
-	}
-	if (info->vpod.addr_mode >= AMDGPU_UALINK_ADDR_MODE_MAX) {
-		dev_dbg(adev->dev, "Invalid addr mode %u\n", info->vpod.id);
-		return false;
-	}
-	weight = bitmap_weight(info->vpod.active_accel_bits, AMDGPU_UALINK_ACCEL_MAX);
-	if (weight != info->vpod.size) {
-		dev_dbg(adev->dev, "vPod size doesn't match vpod_active_accels list: %u != %u\n",
-			info->vpod.size, weight);
-		return false;
-	}
-	if (!test_bit(info->ppod.accel_id, info->vpod.active_accel_bits)) {
-		dev_dbg(adev->dev, "Accelerator ID %u not listed in vpod_active_accels\n",
-			info->ppod.accel_id);
-		return false;
-	}
-
-	return true;
+	return __check_vpod_info(adev, info);
 }
 
 static bool check_local_vpod_integrity(struct amdgpu_device *adev)
@@ -782,12 +856,13 @@ static bool check_local_vpod_integrity(struct amdgpu_device *adev)
 	}
 	return true;
 }
+#endif
 
 static void activate_accelerator(struct amdgpu_device *adev)
 {
 	int r;
 
-	if (adev->ualink.info->accel_state >= AMDGPU_UALINK_ACCEL_STATE_READY)
+	if (adev->ualink.info->accel_state >= AMDGPU_UALINK_ACCEL_STATE_ACTIVE)
 		return;
 
 	/* Enable incoming NPA address translation with NPA VMID */
@@ -811,23 +886,26 @@ static void activate_accelerator(struct amdgpu_device *adev)
 		return;
 	}
 
-	adev->ualink.info->accel_state = AMDGPU_UALINK_ACCEL_STATE_READY;
+	adev->ualink.info->accel_state = AMDGPU_UALINK_ACCEL_STATE_ACTIVE;
 }
 
+#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
 static void deactivate_accelerator(struct amdgpu_device *adev)
 {
-	if (adev->ualink.info->accel_state < AMDGPU_UALINK_ACCEL_STATE_READY)
+	if (adev->ualink.info->accel_state < AMDGPU_UALINK_ACCEL_STATE_ACTIVE)
 		return;
 
 	/* Disable incoming NPA address translation with NPA VMID */
 	psp_ual_set_npa_config(&adev->psp, adev->ualink.psp_if_ver,
 			       adev->vm_manager.npa_vmid, false);
 	/* ignore return value */
-	adev->ualink.info->accel_state = AMDGPU_UALINK_ACCEL_STATE_CONFIGURED;
+	adev->ualink.info->accel_state =
+		AMDGPU_UALINK_ACCEL_STATE_PPOD_CONFIGURED;
 
 	amdgpu_ualink_sw_fini(adev);
 	amdgpu_ualink_manager_stop(adev);
 }
+#endif
 
 static void activate_local_vpod(struct amdgpu_device *adev)
 {
@@ -848,6 +926,150 @@ static void activate_local_vpod(struct amdgpu_device *adev)
 	}
 }
 
+static inline bool __is_vpod_peer(struct amdgpu_ualink_info *info,
+				  struct amdgpu_ualink_info *peer_info)
+{
+	return peer_info->vpod.id == info->vpod.id &&
+	       uuid_equal(&peer_info->ppod.id, &info->ppod.id);
+}
+
+static int __check_local_vpod_integrity(struct amdgpu_device *adev)
+{
+	DECLARE_BITMAP(local_accel_ids, AMDGPU_UALINK_ACCEL_MAX);
+	struct amdgpu_ualink_info *info = adev->ualink.info;
+	u32 local_accels[AMDGPU_UALINK_LOCAL_ACCELS_MAX];
+	struct amdgpu_ualink_info *peer_info;
+	struct amdgpu_device *peer_adev;
+	unsigned int i, n_local_accels;
+	unsigned int accel_id;
+	/* Check that all local accelerators listed in vpod_active_accels have
+	 * matching pod IDs
+	 */
+	bitmap_zero(local_accel_ids, AMDGPU_UALINK_ACCEL_MAX);
+	n_local_accels = 0;
+	__set_bit(info->ppod.accel_id, local_accel_ids);
+	local_accels[n_local_accels++] = info->ppod.accel_id;
+
+	for (i = 0; i < mgpu_info.num_gpu; i++) {
+		peer_adev = mgpu_info.gpu_ins[i].adev;
+		if (peer_adev == adev || !peer_adev->ualink.info)
+			continue;
+
+		peer_info = peer_adev->ualink.info;
+		/* peer device ppod not configured */
+		if (peer_info->accel_state <
+		    AMDGPU_UALINK_ACCEL_STATE_PPOD_CONFIGURED)
+			return -EAGAIN;
+
+		accel_id = peer_info->ppod.accel_id;
+		if (!test_bit(accel_id, info->vpod.active_accel_bits))
+			continue;
+		/* peer device vpod not configured */
+		if (peer_info->accel_state <
+		    AMDGPU_UALINK_ACCEL_STATE_VPOD_CONFIGURED)
+			return -EAGAIN;
+
+		if (!uuid_equal(&peer_info->ppod.id, &info->ppod.id)) {
+			dev_dbg(adev->dev,
+				"Peer %u ppod_id doesn't match: %pU != %pU",
+				peer_info->ppod.accel_id, &peer_info->ppod.id,
+				&info->ppod.id);
+			return -EINVAL;
+		}
+
+		if (peer_info->ppod.size != info->ppod.size) {
+			dev_dbg(adev->dev,
+				"Peer %u ppod_size doesn't match: %u != %u\n",
+				accel_id, peer_info->ppod.size,
+				info->ppod.size);
+			return -EINVAL;
+		}
+
+		if (peer_info->vpod.id != info->vpod.id) {
+			dev_dbg(adev->dev,
+				"Peer %u vpod_id doesn't match: %u != %u",
+				accel_id, peer_info->vpod.id, info->vpod.id);
+			return -EINVAL;
+		}
+		if (peer_info->vpod.size != info->vpod.size) {
+			dev_dbg(adev->dev,
+				"Peer %u vpod_size doesn't match: %u != %u\n",
+				accel_id, peer_info->vpod.size,
+				info->vpod.size);
+			return -EINVAL;
+		}
+		if (peer_info->vpod.addr_mode != info->vpod.addr_mode) {
+			dev_dbg(adev->dev,
+				"Peer %u addr_mode doesn't match: %u != %u\n",
+				accel_id, peer_info->vpod.addr_mode,
+				info->vpod.addr_mode);
+			return -EINVAL;
+		}
+		if (!bitmap_equal(peer_info->vpod.active_accel_bits,
+				  info->vpod.active_accel_bits,
+				  AMDGPU_UALINK_ACCEL_MAX)) {
+			dev_dbg(adev->dev,
+				"Peer %u vpod_active_accels don't match\n",
+				accel_id);
+			return -EINVAL;
+		}
+
+		if (__test_and_set_bit(accel_id, local_accel_ids)) {
+			dev_dbg(adev->dev,
+				"Duplicate accel_id %u among local vpod peers\n",
+				accel_id);
+			return -EINVAL;
+		}
+		local_accels[n_local_accels++] = accel_id;
+	}
+
+	for (i = 0; i < mgpu_info.num_gpu; i++) {
+		peer_adev = mgpu_info.gpu_ins[i].adev;
+		peer_info = peer_adev->ualink.info;
+
+		if (!peer_info)
+			continue;
+		if (peer_adev != adev && !__is_vpod_peer(info, peer_info))
+			continue;
+
+		peer_info->n_local_accels = n_local_accels;
+		memcpy(peer_info->local_accels, local_accels,
+		       sizeof(local_accels));
+	}
+
+	return 0;
+}
+
+static void amdgpu_ualink_activate_vpod(struct amdgpu_device *adev)
+{
+	int ret;
+
+	if (adev->ualink.info->accel_state < AMDGPU_UALINK_ACCEL_STATE_READY)
+		return;
+	mutex_lock(&mgpu_info.mutex);
+	ret = __check_local_vpod_integrity(adev);
+	if (ret && ret != -EAGAIN) {
+		dev_err(adev->dev, "Local vpod integrity check failed: %d\n",
+			ret);
+		return;
+	}
+	if (!ret)
+		activate_local_vpod(adev);
+	mutex_unlock(&mgpu_info.mutex);
+}
+
+#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
+UALINK_VALUE_SHOW(vpod_config, vpod_id,   vpod.id,   "%u");
+UALINK_VALUE_SHOW(vpod_config, vpod_size, vpod.size, "%u");
+UALINK_IDBITS_SHOW(vpod_config, vpod_active_accels, vpod.active_accel_bits);
+UALINK_ENUM_SHOW(vpod_config, addr_mode, vpod.addr_mode);
+
+UALINK_VALUE_STORE(vpod_config, vpod_id,   vpod.id,   u32, 10);
+UALINK_VALUE_STORE(vpod_config, vpod_size, vpod.size, u32, 10);
+UALINK_IDBITS_STORE(vpod_config, vpod_active_accels, vpod.active_accel_bits,
+		    AMDGPU_UALINK_ACCEL_MAX);
+UALINK_ENUM_STORE(vpod_config, addr_mode, vpod.addr_mode);
+
 static ssize_t ualink_vpod_config_commit_store(struct kobject *kobj,
 					       struct kobj_attribute *attr,
 					       const char *buf, size_t count)
@@ -861,7 +1083,7 @@ static ssize_t ualink_vpod_config_commit_store(struct kobject *kobj,
 
 	if (!sysfs_streq(buf, "true"))
 		return -EINVAL;
-	if (info->accel_state < AMDGPU_UALINK_ACCEL_STATE_CONFIGURED) {
+	if (info->accel_state < AMDGPU_UALINK_ACCEL_STATE_PPOD_CONFIGURED) {
 		dev_dbg(adev->dev, "Ualink ppod is not yet configured\n");
 		return -EINVAL;
 	}
@@ -870,7 +1092,7 @@ static ssize_t ualink_vpod_config_commit_store(struct kobject *kobj,
 				    config);
 	if (r)
 		return r;
-	r = psp_ual_query_info(&adev->psp, adev->ualink.psp_if_ver, info);
+	r = psp_ual_query_info(&adev->psp, adev->ualink.psp_if_ver, info, NULL);
 	if (r)
 		return r;
 
@@ -884,7 +1106,7 @@ static ssize_t ualink_vpod_config_commit_store(struct kobject *kobj,
 	mutex_lock(&mgpu_info.mutex);
 	if (check_local_vpod_integrity(adev))
 		activate_local_vpod(adev);
-	else if (info->accel_state >= AMDGPU_UALINK_ACCEL_STATE_CONFIGURED)
+	else if (info->accel_state >= AMDGPU_UALINK_ACCEL_STATE_PPOD_CONFIGURED)
 		deactivate_accelerator(adev);
 	mutex_unlock(&mgpu_info.mutex);
 
@@ -1016,7 +1238,7 @@ static ssize_t ualink_station_config_commit_store(struct kobject *kobj,
 	r = psp_ual_set_station_config(&adev->psp, adev->ualink.psp_if_ver, stations);
 	if (r)
 		return r;
-	r = psp_ual_query_info(&adev->psp, adev->ualink.psp_if_ver, info);
+	r = psp_ual_query_info(&adev->psp, adev->ualink.psp_if_ver, info, NULL);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index d4e727c9f98a0..6f522bcafa442 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -107,7 +107,8 @@ enum amdgpu_ualink_type {
 
 enum amdgpu_ualink_accel_state {
 	AMDGPU_UALINK_ACCEL_STATE_UNCONFIGURED = 0,
-	AMDGPU_UALINK_ACCEL_STATE_CONFIGURED,
+	AMDGPU_UALINK_ACCEL_STATE_PPOD_CONFIGURED,
+	AMDGPU_UALINK_ACCEL_STATE_VPOD_CONFIGURED,
 	AMDGPU_UALINK_ACCEL_STATE_READY,
 	AMDGPU_UALINK_ACCEL_STATE_ACTIVE,
 	AMDGPU_UALINK_ACCEL_STATE_ERROR,
-- 
2.55.0

