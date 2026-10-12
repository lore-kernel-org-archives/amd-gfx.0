Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B12ACA9EBD
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 01:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A492310E19F;
	Mon, 12 Oct 2026 01:40:53 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010052.outbound.protection.outlook.com
 [52.101.193.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40CBD10E19F
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 01:40:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkYLV5qXjrtf1seTP6y7zfNalIaaZrPf77Pmted1E8bV99ya2SWId/47/KBIO3hFPbw3XLJXPPtxF9v6eZCUtEc/bQ8Otj4DlSdsoVHJ9qTpiq81EOXbpO78T+whqqYoAtWpcFdn7h9g470cuwcc6y5AU17vxI6xUbKJsn4LKPI36ZuUGziT+FvTGYW2553pLrG/2lz5MwWdAtL1x8SOnS4dYC+w7+6rXmmHe7ADALYhIz7LnIAeS4qnIACuLDBY6GTx3pdKC+PebXS/7BDmF9q3Z0s851hJoXClL41sh5Inf/nsWdnOJH4rI3WWBOdpOHlP+KT6cke2/RmE63LSew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSoJUQJKBesITHQFQBRl4rU85lAtLuSrXQSFNw0A6cc=;
 b=vZcTX8ZCKsGGZBMQT3Z+NfM+4fA+Q+G2eKZTHUQ2u4uJhS+PCoIZAmzZ0evD5URNXTTW/IsJbQak5IzhUWeUc9DTCffMaVkklUEdALatvbRgwDfC9nPOBbjbZtcJEt5Rsrp4aPQTRjUeCZl9vO3ysc/gXyyX2au2Bd3OzFV80nUb6dRDARFVAZkrYD6kHtHjpkUXklapZNlomc/B+eCZ6pr6Ib+voEL2uR9mj+xm/a0WK0w9u9Z3mMGo4FITDMC/ZOAUxsg43agHWwkn7fqoD1WEfa8i9S3Ku71vu5IOApo6Y3gSLmvZLPzSaFFBvUVvOil/Ya7teY65/VBTHNqYaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSoJUQJKBesITHQFQBRl4rU85lAtLuSrXQSFNw0A6cc=;
 b=xesJd6jmSk8qYSX45PaVigeToe7+fqdAP2/PFmG3/hPZ7Z+Sbn7Kx4jRXmVPZSRoTNE9vM9jaYirw8BQVBlKQw8ax/BPdlojmbP+DWtk7Y8IDUJHq6ptlmUxCxGRBdXeQvXOOR31S+LCS+ypwqj4yNSUGj56ojaCM9OC9W/QupE=
Received: from SJ0PR03CA0063.namprd03.prod.outlook.com (2603:10b6:a03:331::8)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 01:40:43 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:331:cafe::88) by SJ0PR03CA0063.outlook.office365.com
 (2603:10b6:a03:331::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon,
 12 Oct 2026 01:40:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 01:40:42 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 11 Oct
 2026 20:40:34 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3] drm/amd/ras: Use MP1 feature status to select fw-managed
 EEPROM
Date: Mon, 12 Oct 2026 09:40:25 +0800
Message-ID: <56d3bbcf940024032faf81b5bf0732e9a45db483.1791769175.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ae8817-ecd0-47d4-1035-08df2801d3f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ZpNidqYGJpCaQbNPm8Vz7+e4cJC6WVrSHM5e62iXh/l048Pr08q2CBfBikjQvbDK2oyD48fauCEmFm7N+a+Vmz3YcuetvFIQirjtB5FQheOtD/MfH9ZdJJSQbo437oU+CkuG7XfOFi39ODIk3yCDMFSatOqLBht2LAOTL0tPDHJ3L5TSzPDr1houJI1ZsZk7dGXsLf9wXNMp2dNWeqOejYe86eF01Woer8JQOveLwBjpeSGrBnVw1M4iuSjKOus1OLfezW7HReO8Mv7TIs10cE1glZt9eHATySIagR8JMTOibnsrhKROHMyKxtSFP6PllorO1nbTuVy1nhaevKZWmA8b0YFMHgG/7lS9cpE9x4qTAnsMMW2J/z+xP47uDlGtL8YkK0eBQAybmXwTRAvpUwt13NRE9Ud/rOep9ol1ZYDDRjss/Nyc+JtxTWkkm9IsUN8G2L1y9l+MXKBUMt9goX3PN/F0isXwotnPQwRGMa8K7yHlhK8LK6UMZcwDWEpWjGfzXLDFIRJxptmZmw1NByTx+xn9vtd0+UCm+IMN7LuylZvjXb/sRhbjNZzqmFmurr7K03E2rKeF6YoRaoth1YU47wXbBdALZ1Zm4kFnChGpTcVk8DOth/uCfxYBtcuuRNQCRD671iHUsR3meMDbt7eKsUenb5IXH8thHQSa77vdbJx53FglJ9bsnnCbVL35hCwBVoGbPqy8X3YEqXgPXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NYfuY9cSUm5W0WiMwyjZOmLAR8od/bb4u0khXz8l0LldJ6M0ZV3hC+5sImBzz6oV3kgdIih7wTCbUEF0Sf+k0JoyjG7jxJ7pHIo+L/K9h1ppknQ4diuCFzjNk+HeVDRoyGFEuDa39KcD3Ffc47VahPW8e/w+uZe+gJuG4wUN7lU+MR79QlV0HTJ6I2ZUk7ftYQR1DbHjyc/wh71KfHM/VNboUTSJIrLHad2EDWYCynCltoY9bKo9rAz0tkBHx+jXHj9o8yl5QsfE1Px9flrtNjCjWdZPBpwpUQfLU5UjcH/HtKJVLLzE8XE3V9owTC+8NGX6viHvLXqQFK7NdSp5ko+BzNF0EgSZmwtPo75+uFzkbWCxH8+z4U5LJ3Cf8c5cJ4jYejGSwCZzhxMeAI9L+8keH46sVCRIvC1r3x3zuxcfZRCTN0/dk1XWjrrt8Y/o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 01:40:42.4674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ae8817-ecd0-47d4-1035-08df2801d3f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702
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
 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c | 23 ++++++++++++++-----
 2 files changed, 18 insertions(+), 7 deletions(-)

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
index fe0e35357af1..e1b70dd7b819 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
@@ -26,6 +26,7 @@
 #include "ras.h"
 #include "eeprom.h"
 #include "eeprom_fw.h"
+#include "ras_mp1.h"
 
 static bool __ras_eeprom_disabled(struct ras_core_context *ras_core)
 {
@@ -36,25 +37,35 @@ static const struct ras_eeprom_ops *ras_eeprom_mgr_get_ip_func(
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
+	case IP_VERSION(13, 0, 14):
 	case IP_VERSION(13, 0, 15):
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

