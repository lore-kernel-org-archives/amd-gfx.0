Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC224CA9EC5
	for <amd-gfx@archiver.kernel.org>; Sun, 11 Oct 2026 02:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EA8110E223;
	Sun, 11 Oct 2026 02:50:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ik7bn7qw";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011070.outbound.protection.outlook.com [52.101.57.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 443F510E223
 for <amd-gfx@lists.freedesktop.org>; Sun, 11 Oct 2026 02:50:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIbxMYZiMwItvpgFw7LJ4HDYG56rcbT7E4NZHeqBwSpdBve6Vgu5Ob+MIvJWNYYP7uKuO4dEsEGZL56lChqt5Iamva8j2659BBEIq5Kc0iCbZwgLuflYo4OL+gtKg+/jrh5YtU2agiC+JLynmJ74cioPiSiuNiZ85/iI1lNd3mjTAZjuM8nDL1vfckjFkT6zG+vKjrhgVXQBZfE1/VBVuMnDETktVTebnkbDpu3OBV+lxE5dRr8zQv0neUE19yBo5n8jAMr5UYVNF+j3aOKUe8vrXuujcetoVNMaXXbdHMZaZqjjr3yH6gV9EtKPwDLKVCCfnkNGWBl222o2GnQA/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNUUwwaNECIz0ycXXGBgTY9erMT+mzWvAS5sfV2HMUU=;
 b=ABoeZYBeEphU4M1VBoBXC4uRvf2VIx//bQ2vjcCk+xDEeMfKNkn28ZeXgSf7oDrcQPnu+NbvkiE1eY6OFpFyVfF2/N+04EC5RPSO6jCnsmtFebqWXsN2aixIb1IDqyEfIPW7fuEyMqm9Q+HtTbCq3yfUDLgaN4Akhceb+p1QcjJJc2xdT1ujcGBr/swsz+QNC9JewOkR5tMqLbaSo7lECoMWk4fIOnCxklRwoVoq2gUozHodzVDcUN4TrQLUD/EpJ342N28aSnKJEwY7G+KX6pQCePt6TK4NfbXl1QiuLSkBKEJnKF6gDzDURejaEcRbyvO430OQIXxg3e5JriybJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNUUwwaNECIz0ycXXGBgTY9erMT+mzWvAS5sfV2HMUU=;
 b=ik7bn7qwcervG+wULavOwQsko5jO5delx18jwYt+ZdKZQAi9Cck0OLVH/EmvcmzQsN3+rU/44Ql4neTzKNe2TfQajgYxMjw/MxCSQwYBc8dhjMJwAMCXrMHXTIYyvudagxvQQqWPY9J1vPhboOmiRl1irSZ5QZSAJt2+x3ubypM=
Received: from DM6PR05CA0039.namprd05.prod.outlook.com (2603:10b6:5:335::8) by
 DS2PR12MB9773.namprd12.prod.outlook.com (2603:10b6:8:2b1::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.19; Sun, 11 Oct 2026 02:50:21 +0000
Received: from CY6PEPF0000004A.namprd03.prod.outlook.com
 (2603:10b6:5:335:cafe::57) by DM6PR05CA0039.outlook.office365.com
 (2603:10b6:5:335::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Sun, 11
 Oct 2026 02:50:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF0000004A.mail.protection.outlook.com (10.167.247.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Sun, 11 Oct 2026 02:50:20 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sat, 10 Oct
 2026 21:50:13 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 1/2] drm/amd/ras: Use MP1 feature status to select
 fw-managed EEPROM
Date: Sun, 11 Oct 2026 10:50:09 +0800
Message-ID: <1fbc1515d6cd8f36bb3f60b498b3fbdf6e7b4760.1791686882.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1791686882.git.cesun102@amd.com>
References: <cover.1791686882.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004A:EE_|DS2PR12MB9773:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ae57f49-888d-42d6-9f28-08df274263f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|261009223027099003|56012099006|11063799006|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info: WwixuMwt8FWWLSuhPkelfi0uGlA4SFvF1oO7JF3FaZsnG56v8BgB6nbNoA7FNi5caWH8m6xbsJafpF9Yd+DGpSsOVGGnIf61hjA9rqe0Iie9huaWpC+v/mMubAAdLDuM0GCcGd9lE5IMQBi7mgdUQKYbp8pUfMrNMgRJFytYvDt0FkJiYvx8A/1Pk5HLrNo7Yp6B2K+zZngf7tw3//P+P5pnYmYiFpsqJFlE5Laf+bvnIMXziGhLlJjkP3OcK/1R5ze/6T9s2yfL9p9LcLsTawYlyD2b/EcmnsD2UuAzdyWQ9RvX5cdjmvyKLrInTJyxx0hf/X8gicnMgw0m/AbDGsxcX7KvwKEn2/2rA9nnEqKPRzywDzWiTs1gERiTkdpvjRl37aUNljWsdVFfHUEEpOHWRBhcQlG23HmQkuPVxku75SWZQiqYbtyvmboEuxPC+DtB5sITJxwqYzkv1Cj6RKuqpZ5XALfI1RNT/NOvO6pRnubVvoa/n2XZcR96PcVFM/V1dFwGGkruwGXuMSeaAruVfapDmjj0G/MW1AX6SFbYSkFCVPxZ2AmX3Vwge6jaeG0KsUmkE3WZbR3EXLXknkP6jxnd1dIipRoPwbVOPGjunIhw+eCYTrlPtGzNkH0vrwLR19jMvUYngDH8zzBUFtAX1+wXhmilQLILTJCYDvGQ0Gsm7jTTgLEScoABZP8p/IFexfgOQpRSYhowC1SK3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(261009223027099003)(56012099006)(11063799006)(18002099003)(10067099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RPrVZ6bB1R+RficA8s/sHX9qT+vUDmf6i9nv/V/9iziZRUHbPR4RCGYJ4PcMioqp35hfGVi2ddQTmtmwIoHwvyWnFYTOxI+stxYO6194Izl6GNrwxAB3JCwkw5SYa9CuKmbOPy5VOQQr7CCQZHLhjk8bLKoPX+Y4x+9GJ1PRxZzGe3/FB6Beeq16CxJ0cs1h55cuEt1DNIaO24aoRyHxjOhUzz7lJbk25jGLxFsuQFcYxpm70KyA529sjNKa9QPBOF6Zzhe7UoAV03pKScmFa048tP4GVSW4aIKSEfkNjy9kA66fIyIeX5pQEzk8nrQKJct6C/57MC6TFuLWdtQ19D6RQMpslUdVy5Ra7xsPaiDfYCRrLmokm25rqYm4y/0gr6BSthcAlrOZsBYAMYkdsY273lltzuk3SWzKR3nk35bfl1lO+6/Hru1i2ZhM3lT1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 02:50:20.6894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae57f49-888d-42d6-9f28-08df274263f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY6PEPF0000004A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9773
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
 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c | 24 +++++++++++++------
 2 files changed, 18 insertions(+), 8 deletions(-)

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
index fe0e35357af1..c6869b4ef598 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
@@ -26,6 +26,7 @@
 #include "ras.h"
 #include "eeprom.h"
 #include "eeprom_fw.h"
+#include "ras_mp1.h"
 
 static bool __ras_eeprom_disabled(struct ras_core_context *ras_core)
 {
@@ -36,25 +37,34 @@ static const struct ras_eeprom_ops *ras_eeprom_mgr_get_ip_func(
 				struct ras_core_context *ras_core, uint32_t ip_version)
 {
 	struct ras_eeprom_mgr *mgr = &ras_core->eeprom_mgr;
+	int ret = 0;
+	u32 status = 0;
+
+	ret = ras_mp1_check_feature_status(ras_core, RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM, &status);
+	if (ret)
+		RAS_DEV_ERR(ras_core->dev, "Check RAS EEPROM feature failed, ret=%d", ret);
 
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

