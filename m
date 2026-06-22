Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48435CDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:22:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8BFE10E51F;
	Mon, 22 Jun 2026 08:22:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="II3Qs6uh";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012050.outbound.protection.outlook.com [52.101.48.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7460E10E2C9
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:22:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=caBcte39Ex/GcPyT2t5VZLWaWIOzGYjY548d2ztdPi6rvqQRDKP+pzQpaSg4VIbszLIvcTZUaMqVMIUAJdckYXvwO8h5k5plwnN4o1uo3iO2QnJAmtgMvNH2r9sG2mJKR5p1/s/A6XHHIfyCiH3KnPyURmlvhPLdPRu1/ys6zvhj7MOIoIQPH6LK50bAhNbsySmM4B4OJl248GzR+8rEM9aEqpzgHD8joOKxuW2TWcRX9UbzDYaLKbhHPPfIZfZ4YIlOnCV0Afxy6cpTHYy7/ozpoat1gIlc1romCvlvSWGUtEs04h+puYhzTVVZFpLCsZcYTGZkah0Ny2SKbG2xNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xkUFSPUKPXJGtTRe7kXJgX9i5cWMWjYmUSLhADyp+w=;
 b=vV+Woim+UjlZKgvMIcjr7WWjmV28e0fe18+onV0uImJ6UDGpboxN7xIoI8L82puV8AvhDz6qD/sezk5f+jr8Q/ka3Ljw2c2Q+oWh3U4/O6PIyhP7cYgmhDP+S/VvuQl3sxo8JpZZjEXy5JKc51qLidkz/psQdyPQHjxo7n6PGMWFOdh28xPQBtJz/CEHtarT1tj6f31No9mpCCHD4PI/fysfcyhbs5+UMgpnsJH25Y4U6doDzTpgzxtHYGMjIpl9H4d9yFUu4+jWDMDQPXWl21gtiMpCR9ZlS1yIIZxWvnr5C2D1qOhai5uashVMSACjsDwxMFf0JdnU40J/ZVFdUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xkUFSPUKPXJGtTRe7kXJgX9i5cWMWjYmUSLhADyp+w=;
 b=II3Qs6uhNg76ChG1VfD5tEPTYIzUGV22GTV1chkBuZRWmMl6EA0SoWGA0JfDZ9KOfywsHxFVOlXalAPG2rr5gX8oQcyRfDCBTty7wiSQkL9P5kO7W4Ab9/3Frp3uIXkaFxMUaniLYnSHyg/VkHhuSvpVV5IL7NjiJRJoGwlIe1E=
Received: from DS1PR04CA0021.namprd04.prod.outlook.com (2603:10b6:8:243::16)
 by MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 08:22:52 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:8:243:cafe::1f) by DS1PR04CA0021.outlook.office365.com
 (2603:10b6:8:243::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 08:22:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:22:52 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:22:50 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v2 1/2] drm/amd/ras: add set_debug_mode function for uniras
Date: Mon, 22 Jun 2026 16:22:40 +0800
Message-ID: <6396c0ca408e0d8806a0f06467def1d69bf0bb75.1782116341.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|MN2PR12MB4357:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b6bf5bb-0802-4896-75f5-08ded037740b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: ck+IG7p76Rf41m398aWw9XUOWQoGIyz90D6s5L9fGDAWmKGo2bQ1WCWiuEUVHKOXckO7F69DbKywxAWP9X95OMa2fhpJz1ugJFd4t1JiUoUGs9UYc7VdfUj8nQ/9yH5zzT/oUanGVMPxeTmKGlSCOeHI3jB8DOBXcMgf9BXn+TQ4tn5YaxJCaTkzpaBSbu3QZmvFKb2kZR5YvfXazXDW0esS3R2RXGQzJgH13f/aX/EsDKySImgu1NqFoKNwPSQpny31yY2MQrDTkRXW070K5rRJX9zvKmYgv+Mv5jvC6z/uua6PE/kcqnW2n5QbucCcKZ00uRInfxaKb/In6MrwEfMY9Rqtx9wF42rc9cRnxbi7WcUHrhLnhadA8sQfHhZJITfswBhOORfmO1bOK5yh0lrxb5h15LhjTPAqND1XKBosBfcux2T+lp+dWTp8KNKoR9pZHWNzmDwhB57vHbdu5GXoItjRE0nHFmv2ANeGfmhsrJ0+TqOzpEnvx5K/NzZwxnI/pFJdWqFVOTrkCGJ4KM+dgHad7Gq3ZGmG8N0hDGVYXjODNuB/8HdiGvzHQ6mzI2dsNOxfh12AGD8Q7SLzstEQ1obNeGpI6o1ZRwrCYMly3UxoiuIvB2ag6PdLVzdjqVG5ux7uFF8SyO6OfQjsYqhLfJ5bEUIUfZs6BFJ6lUKsWUBElQzPiNVcIWPA6gavlT842guiiyvFoNonGXqxzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(11063799006)(56012099006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /vQji+ghmqavkkqfdZpSXtM69EPmLbemZiSw4uTiGw2Y0y5aM7rO8ETDljG3z2mgGO72DlB5lN/bR4rl2L6Gqur4YaHa2RQB/x6Fqjgzue8hQtQXe+6uvtaeAe5zKmOYshSjrocoQEzDPOlqExLkX5gFq/0p1kPqs6J8bk1fId+pZ+W7P88O43sEgWth1RfUZL0xbEu6sj21My2iiOE6b8emuuUbemz8o7+W1szOjZwpOMO/4Qge0VYmWhA93iUb3iM9J0lyt51panCCgL1eP71Wn4aK4btgfhC2cUyU/H5deatzmVxYZVGcwT+xlsrXVxwPWzjPBEHSmPJxWnAdGjBXjpETxWsQB0hnYfWkXRSPBLHET1IxUlUr6GaieJc3/ygPE5xZAbH8uR69rCsqCUDLf/a47BkSOThxSpXbMC8Tex4rQ6SsdwTbtmfBwVxc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:22:52.1298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6bf5bb-0802-4896-75f5-08ded037740b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4357
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

v2:
1.Add validation for mp1->ip_func and mp1->ip_func->set_debug_mode
2.Return -ENOTSUPP error code if the callback is missing

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  | 10 ++++++++++
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h  |  1 +
 .../amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c    | 14 ++++++++++++++
 drivers/gpu/drm/amd/ras/rascore/ras.h         |  3 +++
 drivers/gpu/drm/amd/ras/rascore/ras_core.c    |  5 +++++
 drivers/gpu/drm/amd/ras/rascore/ras_mp1.c     | 19 ++++++++++++++++++-
 drivers/gpu/drm/amd/ras/rascore/ras_mp1.h     |  3 +++
 .../gpu/drm/amd/ras/rascore/ras_mp1_v13_0.c   | 13 +++++++++++++
 8 files changed, 67 insertions(+), 1 deletion(-)

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
index f3321df85021..1fd807e50370 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_mp1.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_mp1.c
@@ -59,9 +59,20 @@ int ras_mp1_dump_bank(struct ras_core_context *ras_core,
 	return mp1->ip_func->dump_valid_bank(ras_core, type, idx, reg_idx, val);
 }
 
+int ras_mp1_set_debug_mode(struct ras_core_context *ras_core,bool enable)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+
+	if (!mp1->ip_func || !mp1->ip_func->set_debug_mode)
+		return -EOPNOTSUPP;
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
@@ -71,8 +82,14 @@ int ras_mp1_hw_init(struct ras_core_context *ras_core)
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

