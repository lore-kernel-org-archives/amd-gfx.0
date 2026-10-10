Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28212CA6004
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Oct 2026 10:36:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A46110E066;
	Sat, 10 Oct 2026 10:36:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c7oazVd7";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012005.outbound.protection.outlook.com [52.101.48.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05C6110E066
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Oct 2026 10:36:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNAeivcLVhDOrGfnrjjYkN07uFICpOCl4X52CtdEHsAWPVe8vZaqKrqDrvN8iWpSETTDPUVZTcDZf6R+ITw92/CdXaNRj6euDass68JHs5yfzLnl1KY8PkChQFmDEhY0WsW1Crtk3zcQzCduTOcQsam/mQmDcN22/STgu4FcHjYpV2JlO0HHaK3hfHfxDLsFeGGNIxfalB+fy0XmdvsEMUUI2SpFUc560vH2cLe8fQIXBwRj0OPeutH0EFvjnuHNgAclUtUH4vCtLsfZ7GROg9mDDy7QtC4w9a/ITl7bdVoBJXeS6yL8G9ATDgKU5PcZzp7KV6LQb/Hp/KEaU3pNNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uj8hEbPyeZv9UPW7+2QinsANKN/nhQWaz/HiwQ43u7g=;
 b=P00YbSKBsDqz7jSb2hSwY46k1oYSjVU2xc6vmEB8TRp/xdy0teLWS2wyo+DoNHNqFISbrV/KRqDSJRWDvd5D9cdT8fIdqh5Ot55Yynh6bn5enLuuTn+XLFnBHq740evqmcoN/jEcLNDK+ie8DdxgEdpqfjpEvjCUO0RjdiXEECuvRzryb04H1uraXNLHXrO2VMCWo0bURv1VqPDQVZ/u1wn/ENILWHkHpCMPwXjXckOsUtoLoukrb7nb7d7Mzlvz9FP3hFs581xyWPgkKuaRPILbMTejdYk5iPql+yhtSiR8eigFpPIkGjlyRh4tdiUnJLqoQAbJP8pID9EXFfsUwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uj8hEbPyeZv9UPW7+2QinsANKN/nhQWaz/HiwQ43u7g=;
 b=c7oazVd7xATpbwkFW7sf9D/Q1Cvi1T/FFKzLlWxNH/mSm0E6/dkz8sq01L7V1vIP99j+KcsgV2sU5kZe6J8PbjPMulzynlH9ahYoRNngjjGzjAB4BBb7gIj6jiG15/5WGgFivLe78KV96gw176loQkUQpRX8HrjhtMYG5lr7RtY=
Received: from SJ0PR03CA0033.namprd03.prod.outlook.com (2603:10b6:a03:33e::8)
 by DM3PR12MB9436.namprd12.prod.outlook.com (2603:10b6:8:1af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Sat, 10 Oct
 2026 10:36:04 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::9a) by SJ0PR03CA0033.outlook.office365.com
 (2603:10b6:a03:33e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Sat, 10
 Oct 2026 10:36:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Sat, 10 Oct 2026 10:36:03 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sat, 10 Oct
 2026 05:35:55 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amd/ras: Use MP1 feature status to select fw-managed
 EEPROM
Date: Sat, 10 Oct 2026 18:35:51 +0800
Message-ID: <20261010103551.211173-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|DM3PR12MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f2e87d-8aae-4103-e82a-08df26ba48e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|10067099003|18002099003|11063799006|260925021911599003|260925022911599003|260925021311599003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: myr0N8zkEXTpNJ6fvm8dPC85ig8hy7Iepp8eBENdUN32sl1Nf/P4GhCSHbSkjZdS0NphaLFtMZoeW9kkZvPU6KE0UfrMkHDLDH7oDXyOD9hOVXeNjjdNL5PpCNCTuidvXzSbQuAEL3NT2QTlrppxZ9RFP6pDIlKOHkuC3/3TwKcEi2f2Cc/Dw2Z4kemzg7wettdTCX/vmtWWfDsSM3f9ld5cS6pHFewoEUc+oGlfNlzWLBneM/rlVmwx74y0OUdrCA0uAzrREcpyI8G3QPfdPhoO6ivgd6KGyCc/qLHe5buVI7XEsfi2mDoxxMCWmDekS0hBBshsamN1VPoY/mCTs9Z8vDLO0YrOVBtO0uc8yZKsGlsfQRkieKcl+to/GxmC2fJUEcdPsYtuVcT8vokhBbGTrzv7+jABYoO1ofaRYHzWAEeDy3w/yeo+S/eF01AwSvtEyPGBCUdz+WYeWh9ZWa1YafzQlvW1fTY6/l7bxlEku1ObkuwKMkWk5/offXGUrDF5/KziheI+/yotI7ZxJArd/3di3796UEotPqGFxJoAvqxxb+FPaWdepT3Kl1zZfvj8mVj0MwTzTzO88kL0PaWEft5JY6LCZfVfSitTeFkooFVgfumxqnoIrKacyo37J/nCnIpuQoNhfEjnaK7d4cpVcJZ4W1J81spmoavjtJp7ETU3SZUgunLF6dmuuRiaTI4H4HLn17yp83JW+Zgf1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(10067099003)(18002099003)(11063799006)(260925021911599003)(260925022911599003)(260925021311599003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FA1T5aTyj4JEnvAT1WN7bXcr6aWH3tiUTQF7kczkW14MdG/UumijR8EVXdgKkc3AAg0H5XFVz4oShekfjHf66ug/QT4i6WLKSG2dfYdnA4lcK8rbnMKAiqenyR0K8mx5bFrgXVcS8Y6Qutv1NTCPk06JwAn/wYjp540HCMlBU0BRzbcdv/Sjrc/n3wQppuwaz/ZUZ4qjeLIayeCgkqWZDyEfXVHjqi4QeoQ+oNEuBuK+FMHLjl0OeKA5Ev8TvadoktdPxS4kB4fIMvuIyuuEJ8Xu6w2syDsNw8/DkQlnKTehOtQAu6pk0EaQ4w+eUlnXKF/Q52hikXP+O4oTgz5ldznQ5mU71zvupLErzoU7hrh4IObHPUM08zR3TOU4uJt8bASTsYSYzz2TVbl+jpjpZYeXgdqoWIAMybyI8JuVr8DgwFaH1Enqq6XeGKYgMi14
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 10:36:03.7650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f2e87d-8aae-4103-e82a-08df26ba48e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9436
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

Read the feature status of RAS_CORE_FW_FEATURE_BIT_RAS_EEPROM
to determine whether to use firmware-managed EEPROM.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras.h            |  2 +-
 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c | 22 +++++++++++++------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index 73e3960c7c8e..1b724aa23594 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -60,7 +60,7 @@ enum ras_gpu_health_status {
 };
 
 enum ras_core_fw_feature_flags {
-	RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM = BIT_ULL(0),
+	RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM = 0,
 };
 
 enum ras_block_id {
diff --git a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
index fe0e35357af1..6b9661409534 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
@@ -26,6 +26,7 @@
 #include "ras.h"
 #include "eeprom.h"
 #include "eeprom_fw.h"
+#include "ras_mp1.h"
 
 static bool __ras_eeprom_disabled(struct ras_core_context *ras_core)
 {
@@ -36,25 +37,32 @@ static const struct ras_eeprom_ops *ras_eeprom_mgr_get_ip_func(
 				struct ras_core_context *ras_core, uint32_t ip_version)
 {
 	struct ras_eeprom_mgr *mgr = &ras_core->eeprom_mgr;
+	u32 status;
+
+	if (ras_mp1_check_feature_status(ras_core, RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM, &status))
+		return NULL;
 
 	switch (ip_version) {
 	case IP_VERSION(13, 0, 6):
-	case IP_VERSION(13, 0, 14):
 	case IP_VERSION(13, 0, 12):
-	case IP_VERSION(13, 0, 15):
+	case IP_VERSION(13, 0, 14):
 		mgr->eeprom_early_init_service_supported = false;
-		return &ras_drv_eeprom_ops;
+		break;
 	case IP_VERSION(15, 0, 8):
 		mgr->eeprom_early_init_service_supported = true;
-		mgr->fw_record_enabled = true;
-		return &ras_fw_eeprom_ops;
+		break;
 	default:
 		RAS_DEV_ERR(ras_core->dev,
 			"EEPROM(MP1) ip version(0x%x) is not supported!\n", ip_version);
-		break;
+		return NULL;
 	}
 
-	return NULL;
+	if (status) {
+		mgr->fw_record_enabled = true;
+		return &ras_fw_eeprom_ops;
+	} else {
+		return &ras_drv_eeprom_ops;
+	}
 }
 
 int ras_eeprom_mgr_sw_init(struct ras_core_context *ras_core)
-- 
2.34.1

