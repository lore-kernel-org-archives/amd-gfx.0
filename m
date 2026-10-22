Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A151606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 02:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=weI+NYWw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD2FE1122D2;
	Thu, 22 Oct 2026 02:46:25 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013012.outbound.protection.outlook.com
 [40.93.201.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 549571122F0
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 02:46:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIOynQrdcpAnipxytZMlbG2Ce49Y/0ZFAyii4pUb3eTCrsFv1l9vOvcq/apQPvS0jR4kPw93X+RgmiuC6cGlN5VlWDGruP29xxoM3AqtQewOjovQlRTE2lBvzx37a8KUVrP6KqGShp40GYQwWc5h9bX4X5tpME7iag5lT5ymQYqGLQU97SABof9o+nu9mxaov6iQfqUsxzwfWgWB0cYhFfYy0s6Fo+UTqO2/PsHOfab89FqXxmqRO+8iIvzENgngIFMyWjbI86/Z3gWNuQvjWWWjgsXbnc0m/v5Dz1uF/uIEi8KpQWHncwboULLxNJkq2dVnn4ZlZHLFgUxDi4WGvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bpw+K5/wXTWXoVYKwBdCNu9SfdtuFahTV7DzWKAMpCE=;
 b=rD+qyVWSoeyTAia9adZK4ixDGOEcAGL/8S5j9uhUeXnJ7fCgpsnLADFSSo4RnxqVaEoGcWp5snenZVIfiDb/lixEGGw0on9Y/Z4MvTK3/n2hr5x7THGepmhNyPDPapQdiIlYL/r+fVPiY93KyHpQ89efYF8uY8v2GPV8n7ApejD1qXf9Suq5ClV1zqK1vdr3FDB72CyywDQ2aJI1ERAIpwDBYrKDKNXq5tDwkcYrWCWUNM9KVi3laSEToXMO0CC1/GlxxdoToTkOstdD8Ss5bJSqL+HjNE2asodvnTEXiuqb4prD2DlAKfV3GVAZJuSQ1e1BXpMzCpRVOEYtMuIoZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bpw+K5/wXTWXoVYKwBdCNu9SfdtuFahTV7DzWKAMpCE=;
 b=weI+NYWw+DbiX6ryCe2CngQTwfQRItB7IcKMRM1UYmCsAfHG9diB8pA83uO2esMhdmEN347DRNIAcRi5xppALx2R+5oLudD6vHBnePY+zx2wUgj9KevpeSlVLY7PNWI2AGYHs1kap5H/8O6nBxofJ195KxoBOrMB5Qqu8Ds2xSw=
Received: from BN1PR14CA0018.namprd14.prod.outlook.com (2603:10b6:408:e3::23)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 02:46:14 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:408:e3:cafe::83) by BN1PR14CA0018.outlook.office365.com
 (2603:10b6:408:e3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 02:46:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 02:46:14 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 21:46:12 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu/ras: Select EEPROM ops based on PSP IP version
Date: Thu, 22 Oct 2026 10:45:57 +0800
Message-ID: <20261022024557.272114-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|BL3PR12MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: 7635721c-89be-4b74-9529-08df2fe6a372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|261009223027099003|261021123027099003|56012099006|11063799006|10067099003|18002099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: RfMa6xKwVVkAtEyEery2duMyabb0LzYwHMnwvskbJdeDu7QoOidQX8K1hXlJ3HVtdP6Exy/y+HKDoybRqcC70CatV7u3wlnr1HXKweVRVXsAyKUJnQebRbXUlIssc5WBM7wAt4MZArvy3pCvLPlWnhqHMCRDTkeUq7+hX59F51r/dfTPFt1EiDfHdk1/0dWj3WLY6YdM/ouk/VFc74Da5G5zkmfS0hYMfDyF6ZENm4sJel56pTk2SQgey/XWJ5zssCG34ucBg0i0XfR88nl7LAh1eUw29/f6SzbLKXXschE6X1LoM96rsKUtZt4ISkZIz3I53yeITPJ12mvT7vOaozlEzA7zn/3j6R2qjaH4EBTKUh921/yE2+j7hA6sCGN+NWQkB41HC5b/K6YBAXam/c3HDAwToBxNkRPh+seORVQBasHbO9wvrGUwmsshS5uPcNcqZ1xzVxl0Cpa270bQVidDVuEIzZO0sWpNohxYF9zrZBazj5oMvrpNr5br8hn8ur8mj2J8VtWhzljbDYaIpxqJWPRwMLd5R7BJqY0W/Hi1ldzJZybKL/GbNlICtCJRcLJqoftkQU5mujNQjLG2Fx4+p2LSgRYgLk/wYt2MSPKjAO5rWIu6FfvrIg1oAYvMdXEX4QxDJoRtDJzD8UQ55nl1xmVpVNAk8yI5Ubt5nBOk+1xlSH5KMR9mzTVkHnBMOZefyuwj3rKFtRpfUH+YtQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(261009223027099003)(261021123027099003)(56012099006)(11063799006)(10067099003)(18002099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: G56BJVHu9he0eDDxvvjMyZ8lXeh9JNCEORj4n0VaOXZu/I3y0E7StGiQC7SvyX7NpIcYShPqeGe798HLOL9zztVt3UJGSipfx5z6lgleAsWnjKEJ6bMpsAKKXxbJ5wvv4HSm/96wU9b1HqNEucWpzlnFVf6RyBhuORTE1qSs1UV61fdH+Ajo3RxGDYfKWI78POlYY9rSBqyA3n4XAiWN+z8NbzSkb7JZZtCwsFVHxtGphgTs48pbjPMMAiGMBk03nuZPiZVsBP+MDP79PQTpFQ+IluCmbYcovB4F3yJC1dyi6krIFX562ShzFHxNZZ5h8c5g5UVZvQjc4IONHM3Yvw2kA7Wdcme2IfAPw1Yrz1+vGyEUEe+4eoxna9ZdLKOYYAUHN9jvxBKeP3NK8SFOtEB+XxKcwq53G/RLoEB7IqQeT2XUtw8WN1nuI5xitq/O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 02:46:14.0639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7635721c-89be-4b74-9529-08df2fe6a372
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace RAS EEPROM feature-status checking with PSP IP version
based EEPROM ops selection. Determine FW/DRV EEPROM support
according to the PSP IP version instead of querying
RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c | 24 ++++++-------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
index c6869b4ef598..0531ff35a299 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
@@ -26,7 +26,6 @@
 #include "ras.h"
 #include "eeprom.h"
 #include "eeprom_fw.h"
-#include "ras_mp1.h"
 
 static bool __ras_eeprom_disabled(struct ras_core_context *ras_core)
 {
@@ -37,34 +36,25 @@ static const struct ras_eeprom_ops *ras_eeprom_mgr_get_ip_func(
 				struct ras_core_context *ras_core, uint32_t ip_version)
 {
 	struct ras_eeprom_mgr *mgr = &ras_core->eeprom_mgr;
-	int ret = 0;
-	u32 status = 0;
-
-	ret = ras_mp1_check_feature_status(ras_core, RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM, &status);
-	if (ret)
-		RAS_DEV_ERR(ras_core->dev, "Check RAS EEPROM feature failed, ret=%d", ret);
 
 	switch (ip_version) {
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 12):
 	case IP_VERSION(13, 0, 14):
 		mgr->eeprom_early_init_service_supported = false;
-		break;
+		return &ras_drv_eeprom_ops;
+	case IP_VERSION(13, 0, 15):
 	case IP_VERSION(15, 0, 8):
 		mgr->eeprom_early_init_service_supported = true;
-		break;
+		mgr->fw_record_enabled = true;
+		return &ras_fw_eeprom_ops;
 	default:
 		RAS_DEV_ERR(ras_core->dev,
 			"EEPROM(MP1) ip version(0x%x) is not supported!\n", ip_version);
-		return NULL;
+		break;
 	}
 
-	if (status) {
-		mgr->fw_record_enabled = true;
-		return &ras_fw_eeprom_ops;
-	} else {
-		return &ras_drv_eeprom_ops;
-	}
+	return NULL;
 }
 
 int ras_eeprom_mgr_sw_init(struct ras_core_context *ras_core)
@@ -96,7 +86,7 @@ int ras_eeprom_mgr_sw_init(struct ras_core_context *ras_core)
 	mgr->ras_err_threshold = param_cfg.eeprom_record_threshold_count;
 	mgr->work_mode_over_thresh = param_cfg.work_mode_over_thresh;
 	mgr->eeprom_ip_version = param_cfg.eeprom_ip_version;
-	mgr->eeprom_ops = ras_eeprom_mgr_get_ip_func(ras_core, mgr->eeprom_ip_version);
+	mgr->eeprom_ops = ras_eeprom_mgr_get_ip_func(ras_core, ras_core->config->psp_ip_version);
 	if (!mgr->eeprom_ops)
 		return -ENODEV;
 
-- 
2.34.1

