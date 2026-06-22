Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F9ECDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:50:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CE0A10E494;
	Mon, 22 Jun 2026 04:50:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cVYC9kDc";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012008.outbound.protection.outlook.com [52.101.48.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A47E310E494
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:50:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/tVEJ2+1UPQh3QYxSSlDBt7IRK8A7fZQgPEBpP+5WFUKLof0mWlucM9av6BP9m4UDrX4zFFQ0BB/Z1EVEmWVfy1cpB0NG+qKu01AqJXfQOl2pwiss8ibHf84/bmSlc/C3iLpPmA0vzTkk9K0iot+JLyXJajSSfPr69wXt5JmulaxvzugHCMBaGT4Qu8bLtorXv+69OOH2GKYFOGAZ/JzNVawaSTWiT8kivrKNAp10ouTJlX3oyaKJKu2XKI59F+VmAwQhHeh5uNtNd3taMMCR5/4K1tQNuPt2PDym78YOF9PWi7AmgzE2f1kfpDjYELwJc+Cw0T9LS2aAOhQp5S/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWwnYRFXMalwddH57QgI5xNrqcVvrpnRTARWETwLX8c=;
 b=kSJIk9GZHYztMVui0yh7T8PQTjWE7h6W7tjCU7qHhjFwc+NUgNCOUdty/89iA9OSDsr0b02URlQiXu1BTfABuyvIOON6E0I1eSNoYCVLTvMYXKe9ttx8puZsXQWcjm7uSSv69JunNEoTMycdkRXi8otPbD/OmCl122CFjAhf110ZFXvFKRtGX/8qKvwn0JP8QCVsdH7JsE7mT0WDyg/xmFskF0dLQge+DTMEdQGoo9v70GG0kLnn2Dqi7lb5kCE61yUPGFBEqDyXVMvyUQ9BuHlppOZHtjbQRosuanKflBLfEi4m4PYGxvpkyHtJDSmrAAH6EeKujEPcy/lFFfda1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWwnYRFXMalwddH57QgI5xNrqcVvrpnRTARWETwLX8c=;
 b=cVYC9kDcDm3AzlwYSVrAw6LEW6MHUsI86cR3r8nyJNTRmQ3BxqQSv7P0wFjxATareeQ8zAYmwd85AWpYJMsXOsaVN/8onnmoB4kNzuY9DfIPXbi28mZPCBeVsUbK6MwGdkFDkQCJeluUmIKpULR7U6Xd6DiLuoDPG1dcoCOz5Sw=
Received: from MN0PR04CA0006.namprd04.prod.outlook.com (2603:10b6:208:52d::23)
 by SAVPR12MB999119.namprd12.prod.outlook.com (2603:10b6:806:4e9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 04:50:26 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:52d:cafe::ab) by MN0PR04CA0006.outlook.office365.com
 (2603:10b6:208:52d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Mon,
 22 Jun 2026 04:50:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:50:26 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:50:24 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 1/2] drm/amd/ras: add set_debug_mode function for uniras
Date: Mon, 22 Jun 2026 12:50:14 +0800
Message-ID: <eea07a6f8d3a846baeea3e6d27f4d3d092fc643f.1782103766.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782103766.git.cesun102@amd.com>
References: <cover.1782103766.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|SAVPR12MB999119:EE_
X-MS-Office365-Filtering-Correlation-Id: df9967bf-f085-41a0-2436-08ded019c6c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: NzR5PrQ/l1o/CPfd2m+d983A1eC7FiQXh1JbkVzotggGEkYxQduKmcOGncq7LGHLUz3bFag5aJPMme/hr7ZghyD1faM6ajLUiD2jMFpiTFbGOnitMopko84YiHooNb8sYe2sDqZmW/kXSnDK2wnf5qdDotHLE83wuvkUCvEXu9EigMZRO5HYnFujmNzdHErqg7cJWd1fil1Xc30XJpC65E3PYJxQsGhYV/wDw5+7n6FgC/RT8SKq9rhf9xpyUBEwH5mzrvXqxTRA3JV2ojW/YgY85PIjjXSl8kq5vTpgWX0pS4nPTECBSsU5vbFDINHR5GUByQP+y0no8Km0Bg35dj1ubuvy8teTnyL8npemQcO9JOH7XoT1s8wKgcHlui+mxmikTvTgCaWFFgNKMbX/NDgGIr7qjYBXkFqNBXkAhiKWP7L2DKoRmb6h05lp/cAbzBZcQTd4F1W0NPwUtz1n4+nm3cHg3DpQf/EFlCYLg1UbESNYwfyJwsKOYmz98df4oOqR/2PgyRbGM/SHAsvX+tlC/8vflrTcY6bCkxGlGlcdgJyUDpoZ5mMTZ6Gmp279LIYWt1K8K9x82hHZF24kalY2aT5PBwtO0R5xcoreHKVFBlp240qQQh9UKdhivsGm4858Ay98gsHVgLBPf7gIZhvh7F9g5XFhpW33Wj9V2YCBFV/ZDoJhjIc1zdDqzg/Fr+m/xxTGVaxIOjmZdarHVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X5ob+CZL7Wzvs0+4ukIC2XfFETXyBKLu6hfs/+o+DH+m5GD1NpjpnnuR7LFrDEYsrkvSJsKwBkqzK2JHz/y6uyXGgMhY1NwxTyXNzEYNnXR9Y+gLUMzpFEqwVTE0teHm7Ait3F9TfrhLx2di1PJv0hWLdSr8GVBIjGqkLIPSoK0yzUXbty9G6HGNeu4EUb2aJKD4RhfA8JpmeGHCDYof10RVVBgxOXYeSCBqQDq15m0oNeUWmT/E+4En3DDyCdBNhfF85oEeJIVKODio+8KBmuDWrEztGGiiwJYTuWo8WoWDs2SIe6qnb56Q8xwBQOK3OFgImhWvMR6RaHuvPSVLNFPkmjNkc1OGZ/ClEUUzUS3DHh8jaTLdTOFKRiI2FZ4SCe3VnPdPpCjQqE81t8IAx+SWcYc+d4MPx3GfkYk1nDqCuFqbpfeHDy3bSfeuoabY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:50:26.0455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df9967bf-f085-41a0-2436-08ded019c6c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999119
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

add set_debug_mode function for uniras

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 10 ++++++++++
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h |  1 +
 .../drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c   | 14 ++++++++++++++
 drivers/gpu/drm/amd/ras/rascore/ras.h            |  3 +++
 drivers/gpu/drm/amd/ras/rascore/ras_core.c       |  5 +++++
 drivers/gpu/drm/amd/ras/rascore/ras_mp1.c        | 16 +++++++++++++++-
 drivers/gpu/drm/amd/ras/rascore/ras_mp1.h        |  3 +++
 drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.c  | 13 +++++++++++++
 8 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index f627a97797ed..2ce7b88544c3 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -773,3 +773,13 @@ int amdgpu_ras_mgr_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
 	return ras_core_convert_soc_pa_to_cur_nps_pages(ras_mgr->ras_core,
 			addr, nps_page_addr, max_page_count);
 }
+
+int amdgpu_ras_mgr_set_debug_mode(struct amdgpu_device *adev, bool enable)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+
+	if (!ras_mgr || !ras_mgr->ras_core || !ras_mgr->ras_is_ready)
+		return false;
+
+	return ras_core_set_debug_mode(ras_mgr->ras_core, enable);
+}
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
index 4f44a917d48b..a757ec15125e 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
@@ -84,4 +84,5 @@ int amdgpu_ras_mgr_pre_reset(struct amdgpu_device *adev);
 int amdgpu_ras_mgr_post_reset(struct amdgpu_device *adev);
 int amdgpu_ras_mgr_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
 		uint64_t addr, uint64_t *nps_page_addr, uint32_t max_page_count);
+int amdgpu_ras_mgr_set_debug_mode(struct amdgpu_device *adev, bool enable);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
index 2098f24d4940..ee59184f7eee 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
@@ -24,6 +24,7 @@
 #include "amdgpu_smu.h"
 #include "amdgpu_reset.h"
 #include "amdgpu_ras_mp1_v13_0.h"
+#include "smu13_driver_if_v13_0_6.h"
 
 #define RAS_MP1_MSG_QueryValidMcaCeCount  0x3A
 #define RAS_MP1_MSG_McaBankCeDumpDW       0x3B
@@ -131,10 +132,23 @@ static int mp1_v13_0_get_ras_enabled_mask(struct ras_core_context *ras_core,
 	return ret;
 }
 
+static int mp1_v13_0_set_debug_mode(struct ras_core_context *ras_core, bool enable)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	int ret;
+	u32 smu_msg = SMU_MSG_ClearMcaOnRead;
+
+	ret = amdgpu_smu_ras_send_msg(adev, smu_msg,
+				      enable ? 0 : ClearMcaOnRead_UE_FLAG_MASK | ClearMcaOnRead_CE_POLL_MASK,
+				      NULL);
+	return ret;
+}
+
 const struct ras_mp1_sys_func amdgpu_ras_mp1_sys_func_v13_0 = {
 	.mp1_get_valid_bank_count = mp1_v13_0_get_valid_bank_count,
 	.mp1_dump_valid_bank = mp1_v13_0_dump_valid_bank,
 	.mp1_send_eeprom_msg = mp1_v13_0_eeprom_send_msg,
 	.mp1_get_ras_enabled_mask = mp1_v13_0_get_ras_enabled_mask,
+	.mp1_set_debug_mode = mp1_v13_0_set_debug_mode,
 };
 
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ras.h
index 5869bad978b0..371d1061d8f4 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -167,6 +167,7 @@ struct ras_mp1_sys_func {
 			enum ras_fw_eeprom_cmd index, uint32_t param, uint32_t *read_arg);
 	int (*mp1_get_ras_enabled_mask)(struct ras_core_context *ras_core,
 			uint64_t *enabled_mask);
+	int (*mp1_set_debug_mode)(struct ras_core_context *ras_core, bool enable);
 };
 
 struct ras_eeprom_sys_func {
@@ -400,4 +401,6 @@ int ras_core_get_device_system_info(struct ras_core_context *ras_core,
 int ras_core_convert_soc_pa_to_cur_nps_pages(struct ras_core_context *ras_core,
 		uint64_t soc_pa, uint64_t *page_pfn, uint32_t max_pages);
 int ras_core_check_address_sanity(struct ras_core_context *ras_core, uint64_t addr);
+
+int ras_core_set_debug_mode(struct ras_core_context *ras_core,bool enable);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index 61d100b074b9..08e17a83ad5b 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -151,6 +151,11 @@ bool ras_core_gpu_is_rma(struct ras_core_context *ras_core)
 	return ras_core->is_rma;
 }
 
+int ras_core_set_debug_mode(struct ras_core_context *ras_core, bool enable)
+{
+	return ras_mp1_set_debug_mode(ras_core, enable);
+}
+
 static int ras_core_seqno_fifo_write(struct ras_core_context *ras_core,
 		enum ras_seqno_fifo fifo_type, uint64_t seqno)
 {
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_mp1.c b/drivers/gpu/drm/amd/ras/rascore/ras_mp1.c
index f3321df85021..15b605a23aa5 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_mp1.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_mp1.c
@@ -59,9 +59,17 @@ int ras_mp1_dump_bank(struct ras_core_context *ras_core,
 	return mp1->ip_func->dump_valid_bank(ras_core, type, idx, reg_idx, val);
 }
 
+int ras_mp1_set_debug_mode(struct ras_core_context *ras_core,bool enable)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+
+	return mp1->ip_func->set_debug_mode(ras_core, enable);
+}
+
 int ras_mp1_hw_init(struct ras_core_context *ras_core)
 {
 	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+	int ret = 0;
 
 	mp1->mp1_ip_version = ras_core->config->mp1_ip_version;
 	mp1->sys_func = ras_core->config->mp1_cfg.mp1_sys_fn;
@@ -71,8 +79,14 @@ int ras_mp1_hw_init(struct ras_core_context *ras_core)
 	}
 
 	mp1->ip_func = ras_mp1_get_ip_funcs(ras_core, mp1->mp1_ip_version);
+	if (!mp1->ip_func)
+		return -EINVAL;
+
+	ret = ras_mp1_set_debug_mode(ras_core, false);
+	if (ret)
+		return -EINVAL;
 
-	return mp1->ip_func ? RAS_CORE_OK : -EINVAL;
+	return ret;
 }
 
 int ras_mp1_hw_fini(struct ras_core_context *ras_core)
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_mp1.h b/drivers/gpu/drm/amd/ras/rascore/ras_mp1.h
index de1d08286f41..0b618f6b8b9e 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_mp1.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_mp1.h
@@ -31,6 +31,7 @@ struct ras_mp1_ip_func {
 			enum ras_err_type type, u32 *count);
 	int (*dump_valid_bank)(struct ras_core_context *ras_core,
 		enum ras_err_type type, u32 idx, u32 reg_idx, u64 *val);
+	int (*set_debug_mode)(struct ras_core_context *ras_core,bool enable);
 };
 
 struct ras_mp1 {
@@ -47,4 +48,6 @@ int ras_mp1_get_bank_count(struct ras_core_context *ras_core,
 
 int ras_mp1_dump_bank(struct ras_core_context *ras_core,
 		u32 ecc_type, u32 idx, u32 reg_idx, u64 *val);
+
+int ras_mp1_set_debug_mode(struct ras_core_context *ras_core,bool enable);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.c b/drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.c
index 310d39fc816b..1fcfc1995ad3 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.c
@@ -99,7 +99,20 @@ static int mp1_v13_0_dump_bank(struct ras_core_context *ras_core,
 	return sys_func->mp1_dump_valid_bank(ras_core, msg, idx, reg_idx, val);
 }
 
+static int mp1_v13_0_set_debug_mode(struct ras_core_context *ras_core, bool enable)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
+
+	if (!sys_func || !sys_func->mp1_set_debug_mode)
+		return -RAS_CORE_NOT_SUPPORTED;
+
+	return sys_func->mp1_set_debug_mode(ras_core, enable);
+}
+
+
 const struct ras_mp1_ip_func mp1_ras_func_v13_0 = {
 	.get_valid_bank_count = mp1_v13_0_get_bank_count,
 	.dump_valid_bank = mp1_v13_0_dump_bank,
+	.set_debug_mode = mp1_v13_0_set_debug_mode,
 };
-- 
2.34.1

