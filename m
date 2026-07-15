Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA24C4450B
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 07:47:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3CEC10EF44;
	Wed, 15 Jul 2026 07:47:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jcnd3vyS";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011050.outbound.protection.outlook.com [52.101.52.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82FCF10EF1D
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 07:47:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qnj6eUaYExANFPNzrSZZ4Z97uSNtLWvLFxGepFpAPHz6FE4xvXSL97JVupeIn6trYZ5CE9XraoQ0x+HBZocvZ1q3McKb1lluukRfyuKsYlJaujdfFwlUtQs4wvCc6k6sE3u9gwcYM2TwmbShB6um8+lmZYw2BmAlW21uJQTeTOOK0zZ/uawa8P29S8QWA2Cx/7BHe5c+i19phT1DNMB/r2Hgxi4m0anTYLIEmDoYqxk38RyfPSSpNWFUvvEcsYczng9oV24p5jsDElHV8e1HDGSEE/aHZ26nHbSBkKsD8lqfAFnaXDjpE1MFLiteMaiYZNsM4ipzTUFcVivCai3yMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C94jRG0YxB71fgUBwgKJn8+zjQxPUPCexadwbEJeZ4I=;
 b=eeENKu3hZUxigLm4fg6dEKj9f6bVUtzvr03+PPysk0Qax+yjZp6RVsiPLF/MPU5z8ykldzFxLp3hu2DVuDgOMkhSKUGTbxRkSUmHJ8NMqlBFpVk3QlLalunRc2wd5WJmawJjfiD78/lccdEhIIIs9g+EASks5nbWnmZ2bUJkXZTCMZVQVQjUgOWeYLBNyNu0/s40uU1mFYslIq3pY9q+mNFqAUZsE7yUjHD+MKAHXDYq4qHLSzDycIF9glWKPE9XqBUkscqL1EeBnziWoo2JvkVZn8ZczrpDOeh56ePqUlArKoB+zgyEpyB+zaWawnAjVD+h2Fqkj0btWZXYnkIojQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C94jRG0YxB71fgUBwgKJn8+zjQxPUPCexadwbEJeZ4I=;
 b=jcnd3vyS5d1UU/t5xxN7tlu2RTRdYuW9v+0rQ3W899eZ7W3UDq7kaN89EOYqmipwFNxNZhCjkkbEN6tc0o6KsDgSXUkeBhMGNkAoHw+E85MqjJ9NGkt6Lf9N5ooL5dBdZ4EhVUIUxNz7b+hgqaHfbdrbbMA3gNDp8dackzwq5rE=
Received: from MN0PR02CA0008.namprd02.prod.outlook.com (2603:10b6:208:530::10)
 by LV3PR12MB9215.namprd12.prod.outlook.com (2603:10b6:408:1a0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 07:47:51 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:530:cafe::15) by MN0PR02CA0008.outlook.office365.com
 (2603:10b6:208:530::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Wed,
 15 Jul 2026 07:47:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 07:47:51 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 02:47:50 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 5/5] drm/amd/ras: add ras ce log switch for uniras
Date: Wed, 15 Jul 2026 15:47:34 +0800
Message-ID: <20260715074734.2668631-5-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715074734.2668631-1-tao.zhou1@amd.com>
References: <20260715074734.2668631-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|LV3PR12MB9215:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c1d7123-3534-4a62-0d88-08dee2455f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: +sWQP1sLJvCUo2dGCtOZbzHPJltkD+cl4ofe/SMAD0OSUxELxMRHBoqXmk9co9Wc7XThwH80XJDJVjLbjP1M9jz3+Sa8HGfcYgSuk7ViQxVMMDL2vEQQ472etCKJsSsCW+R/Imtx6ApdHDLyFsG926wdbH5wmoYTacQQ6+yxAtZL/iznZh/G80MB3pk3riym6Kzrd5A+nqhCelC7u4LTFbTQuEvDjTfU12YfaIswCPFJa7KSUN1heb8HVrEpx3hME1BuaG/ilQyH2m9a1HkVfaq+YzEEe1pcaX84ztZpO/BLeBUGLZLNuh0pzPoP+po4IiZJcsQpPyF7Ez3CUPftkZt6C4hw21rdJA5lp9pWBCwyAxHtWcmBb0cP7wrJQWqQO9de5hfgTiYIQTMOCQy2Yz1HqEUp/Td1fqV7sgb/m8cfCkgDlB5Ruv8hogKp7BO/frHzigbUPhVVjtX3LIgEZYJBXGyYPukSOhYfH1EeyNPDvV06bibNwp+VZ7YJxlQo7IoouuTYTnbNrWvugU9F3ktGB2zKVuBmjyebJb4wViSf2OBKwY0OHZkes0IjAAoKFfyK0YbzRjYEc0sDIMyHEi/RijYSQZzudScEn7QD23MVyI/ImP9wV1VfXftcosE190UTEVkOC1Df5PsVnhHWfbtXTUb6F/aK6joJcPeFl+dSDItXaTvXu3VIrGqDamtXbWWBeZp9Cfd5nB4Ksm8LlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sHUS+ZVbySEcfW+ErUTkhQe4XRyNvuXyDS926ryMMRmD5u4INsfhNdJhjvfrniitZBGMoqgrJIW3gQT50W8+lWsrfILOlbJxXYcvpzisPmzqULMesejVpeIANuwroDm6MmSdyhEbdnjLwizFu3rQo2ZecfB/dmT6991AitgPmGgga56SDiyQtUoH15H1ONOEX8eHpvW3KMKZPzVSVcKSQC27vHyY2asKscjHUCIDsgAypUBPvwFnugDh05G0uCrpRZixd6lYgEtB13VtcLfvG8S8+jfUMB0G4R1ve60UdnzJd1whgPBN+VISjTJodYXEH429qH4n6wb6j8V3PGj+9Kgkzk/5cpGKCuS0gtm1K4tRK3NE09KhmKXL8p1JDP3ggy0k6uBk8bSF1zhKERnUSH9QAwzljD9eUah2wy4XL6Dd/9WQv4o7EB55EAGslb7o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 07:47:51.2067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1d7123-3534-4a62-0d88-08dee2455f4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9215
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

So we can disable ce log manually.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 1 +
 drivers/gpu/drm/amd/ras/rascore/ras.h            | 2 ++
 drivers/gpu/drm/amd/ras/rascore/ras_aca.c        | 7 ++++++-
 drivers/gpu/drm/amd/ras/rascore/ras_core.c       | 1 +
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index c55288c2df9a..1e95419989b4 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -310,6 +310,7 @@ static struct ras_core_context *amdgpu_ras_mgr_create_ras_core(struct amdgpu_dev
 		amdgpu_ras_mgr_eeprom_is_supported(adev);
 	init_config.poison_supported =
 		amdgpu_ras_is_poison_mode_supported(adev);
+	init_config.debug_disable_ce_logs = adev->debug_disable_ce_logs;
 
 	amdgpu_ras_mgr_init_aca_config(adev, &init_config);
 	amdgpu_ras_mgr_init_eeprom_config(adev, &init_config);
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ras.h
index 5719bc1b6167..9d538a07c50e 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -301,6 +301,7 @@ struct ras_core_config {
 
 	bool poison_supported;
 	bool ras_eeprom_supported;
+	bool debug_disable_ce_logs;
 	const struct ras_sys_func *sys_fn;
 
 	struct ras_aca_config aca_cfg;
@@ -348,6 +349,7 @@ struct ras_core_context {
 	bool ras_core_enabled;
 
 	u64 ras_fw_features;
+	bool debug_disable_ce_logs;
 };
 
 struct ras_core_context *ras_core_create(struct ras_core_config *init_config);
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
index 67a35409ff0e..9760894c4c66 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
@@ -98,7 +98,7 @@ static void aca_report_ecc_info(struct ras_core_context *ras_core,
 			blk_name(blk));
 	}
 
-	if (ecc_count.new_ce_count) {
+	if (ecc_count.new_ce_count && !ras_core->debug_disable_ce_logs) {
 		RAS_DEV_INFO(ras_core->dev,
 		"{%llu} socket: %d, die: %d, %u new correctable hardware errors detected in %s block\n",
 			seq_no, skt, aid, ecc_count.new_ce_count, blk_name(blk));
@@ -114,6 +114,11 @@ static void aca_bank_log(struct ras_core_context *ras_core,
 {
 	int i;
 
+	if (ras_core->debug_disable_ce_logs &&
+	    bank->ecc_type == RAS_ERR_TYPE__CE &&
+	    !bank_ecc->real_de_count)
+		return;
+
 	RAS_DEV_INFO(ras_core->dev,
 		"{%llu}" RAS_HW_ERR "Accelerator Check Architecture events logged\n",
 		bank->seq_no);
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index 2346918c7736..cdef7727decb 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -377,6 +377,7 @@ int ras_core_hw_init(struct ras_core_context *ras_core)
 			ras_core->config->ras_eeprom_supported;
 
 	ras_core->poison_supported = ras_core->config->poison_supported;
+	ras_core->debug_disable_ce_logs = ras_core->config->debug_disable_ce_logs;
 
 	ret = ras_psp_hw_init(ras_core);
 	if (ret)
-- 
2.34.1

