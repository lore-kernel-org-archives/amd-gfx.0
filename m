Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25244C982FA
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 09:31:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A478F10E862;
	Wed, 23 Sep 2026 09:31:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SDFPBEEg";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C13210E862
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 09:31:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dnZCPfJQ5Kk5Uy0DIDX7XEIeUiiBT1SKD2ZBBxyxheO2dSJVVX5wZ41BdxB5G0GfK/OLiei4MgbRtkE1hYQzxBNr8aBeRS71UhOeDCcycUOOTq6nSissQi2fGfZzSjL/+0bHW/E3dlVl23uuxOq5ucBvNA+tyCQkY4IaARGuRAMp8zFLM+OUtWMmAXEVY+eckbcYX+6nQYvvHn70tn15l5Her6DLD1VTwn94d/JK/cMbQe6l0tbsPfBKtAM2/U0zoPzXQAjYT13QTS2K5vC6j7a62/+d3/u8oTZKVUpoJjQQQNPrmF1+il51sgS4488v7rCxxDXL7YjXkFbSzJ3Usg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6HAwY7lybA5M2dQ0q+jOaqNjgod0OIRurSI5gTcmPM=;
 b=j6qSo9KKqtip2TvZi2szggZF6EZegR0wRlNiJ6qq4tm/yMKs68hw6HeNfo8MUO3X2yxTnLcU1hYhg6qgaSIqNgU78pH79W2MKGzcAufBElcOrhNAPzC3p0SbpE2X/lqS4sWvhuxea33TKrr7xaMpGZyJC89p1L5IRjm0Zhp7K2bDFoAsB7qHpUNLkFOs5BNj9C5gr765Jc81qLyLGsmt1ytE3FnySiXG4CaOJ3VlwZ6stUFzK6w0DRI326QeZ0D08eIFk8s/yDP739PU9G3E/nQvLqWETm5g18by3vJbutEOpU9TuIvPvcf7FtiuYnU54hTHG5SNbtuxMZR4igWnzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6HAwY7lybA5M2dQ0q+jOaqNjgod0OIRurSI5gTcmPM=;
 b=SDFPBEEg4yFzxPb6lo9QUBeYr6D8R1EdaNeS2GSJNfSqXzcbMDYKpbBRd8PawZgBCHKLeJJnUu3gR3ZwaPjuqJ+Tar4+PYYMKErSN4jlmC9JTjFuQtGTqyemcw0CAtsNaUR/ufsG7OVqQyBJNifj+EXMnDYDEXcFkov38OFW8/4=
Received: from BL1PR13CA0132.namprd13.prod.outlook.com (2603:10b6:208:2bb::17)
 by BN7PPFA8145BD40.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6de) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 09:31:52 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:208:2bb:cafe::81) by BL1PR13CA0132.outlook.office365.com
 (2603:10b6:208:2bb::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 23
 Sep 2026 09:31:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 09:31:52 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 04:31:48 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu/ras : Update psp 13_0_15 ip block support for
 uniras
Date: Wed, 23 Sep 2026 17:31:39 +0800
Message-ID: <20260923093139.140456-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|BN7PPFA8145BD40:EE_
X-MS-Office365-Filtering-Correlation-Id: 087ccf23-b762-4b3f-0292-08df19558048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: v0ewL/B/dFOjPdQnVH0/GrTpl46vL6Vdl+uy6D5IDpnKjzwk+nvj/xOez1TXKR1IwonkzeFsUBMg2N2fcoxLEB+t6GP0Sa0EdGpVRlQzYQPRpgUWfdiPlW402eoD3eI2dMZ/OXr4Sgj3Xc9t6QsGNauP65RshXw612HEvTnC6WP3BPKpvaFyisYuXlaKp+JOJURWVEfyfOloS7Kmt08BdFgTWANvkHMi8lCQamKBZTORBHPZJU7HUwZfqQjbRKu8jqW3nq6pJ1Od0T4sO8Fg9gBSLvKXBBon36/Q5I6qTensQJLcMjIl53l4AqafmtXd3TkO9lTgXObZT9rudkPp+Io4WMx1HdBXQOVeV8KKIzILw+zEim52nyUVVTFR9+q72Qy3Khby3kNbQ6hON0QZZ75o8JpcZxaqSBsB0MIntxS1N+WDzdDVDeGZ18AHTOJG11SJ4+6O3Eg/iwkDJOWNGYakI0QH/HQLVwjc5H2GM94Pd0rVgw3zfBvBlYXQNQSE3EmSNsOt49iCm5NWPdNXb0UnQGD0X1ffIJKnAoXCK/ukMA8yYdHQVQfnl4wfC4gGpjCYRDbhuWAEj9cP2g0P9NIBcELnaj1KttfPMLkAxXrkYwZgvgrFJFCdBoX0PlLa/pHX9fTCaVNmDRo1Von2ZNS/gPkBPfT1VMilhp6tBSiD+aOc3rj+uw5AwmNoMqIKivhWCpf6qk0WdhH51REebQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: okxoHIt3yxIx4qpQTWEF6XzSxir9U4sxmQkoAJiJAWFGjNeBcpOCmQxdHkRipCdVDCm2yy6j9l+nnsc0HFABY7yltY4pJO5dYthMK6rK8EuicYOyIbFi9LWnrFnr3+EEZVIH5mEhSx778SCRIXTOTASg+iNFhCNoLVF14wM62ZxyGHQzz7ruIZjqPjtPfZ5CG2mILwW5dHhPNq0Ez8HRT1xQ/2XiyoLpf4TLbvSwivQhvBgWdpConOyj7wh7Pl7rhndZ7Yaf8zKPrPxOQRRRdXJDGEzdaMrhhp2na60L2IYmb1idLpjAioskKqGf+6ZlP5I99X1oTX+uILJicXgd32yqm2OxfXxEZ/V5nUrvmIfAkL1T18oINuyuzY/XrL/dPj/Qgzkkre1ebnaugu8Sm65PQxpP9R/j8K1eVeMSYIxWrIK9UrXuSeCsUD8hN1sh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 09:31:52.4638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 087ccf23-b762-4b3f-0292-08df19558048
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFA8145BD40
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

Included psp_13_0_15 ip block for uniras

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c           | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c                 | 3 ++-
 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c           | 1 +
 drivers/gpu/drm/amd/ras/core/ras_mp1.c                  | 1 +
 drivers/gpu/drm/amd/ras/core/ras_psp.c                  | 1 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c | 1 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c        | 3 +++
 7 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 1420bb60e015..69a998e09556 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -3130,6 +3130,7 @@ static int amdgpu_discovery_set_ras_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 12):
 	case IP_VERSION(13, 0, 14):
+	case IP_VERSION(13, 0, 15):
 	case IP_VERSION(15, 0, 8):
 		amdgpu_device_ip_block_add(adev, &ras_v1_0_ip_block);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 6b2b8acdbf9b..47e852c15c36 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3822,7 +3822,8 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
 	    ras_obj->hw_ops->query_ras_error_status)) ||
 	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14) ||
 	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 12) ||
-	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6)) {
+	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6)  ||
+	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 15)) {
 		r = amdgpu_ras_sysfs_create(adev, ras_block);
 		if (r)
 			goto interrupt;
diff --git a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
index 1781d037ef13..fe0e35357af1 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
@@ -41,6 +41,7 @@ static const struct ras_eeprom_ops *ras_eeprom_mgr_get_ip_func(
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 14):
 	case IP_VERSION(13, 0, 12):
+	case IP_VERSION(13, 0, 15):
 		mgr->eeprom_early_init_service_supported = false;
 		return &ras_drv_eeprom_ops;
 	case IP_VERSION(15, 0, 8):
diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1.c b/drivers/gpu/drm/amd/ras/core/ras_mp1.c
index 4c180027850f..49ce6ec7993f 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_mp1.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_mp1.c
@@ -34,6 +34,7 @@ static const struct ras_mp1_ip_func *ras_mp1_get_ip_funcs(
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 14):
 	case IP_VERSION(13, 0, 12):
+	case IP_VERSION(13, 0, 15):
 		return &mp1_ras_func_v13_0;
 	case IP_VERSION(15, 0, 8):
 		return &mp1_ras_func_v15_0;
diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp.c b/drivers/gpu/drm/amd/ras/core/ras_psp.c
index ed53cd25d6bd..23ceec04a82a 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp.c
@@ -46,6 +46,7 @@ static const struct ras_psp_ip_func *ras_psp_get_ip_funcs(
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 14):
 	case IP_VERSION(13, 0, 12):
+	case IP_VERSION(13, 0, 15):
 		return &ras_psp_v13_0;
 	case IP_VERSION(15, 0, 8):
 		return &ras_psp_v15_0;
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
index a56d3116c5fd..5f550abd8dbf 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
@@ -121,6 +121,7 @@ static int ras_eeprom_i2c_config(struct ras_core_context *ras_core,
 		case IP_VERSION(13, 0, 10):
 		case IP_VERSION(13, 0, 12):
 		case IP_VERSION(13, 0, 14):
+		case IP_VERSION(13, 0, 15):
 			cfg->eeprom_i2c_addr = EEPROM_I2C_MADDR_4;
 			badpages_per_record = BAD_PAGE_NUM_PER_EEPROM_RECORD_V13;
 			break;
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index eb5722a59786..109c47eb002a 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -141,6 +141,7 @@ static bool amdgpu_ras_mgr_eeprom_is_supported(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 12):
 	case IP_VERSION(13, 0, 14):
+	case IP_VERSION(13, 0, 15):
 		return (adev->gmc.is_app_apu) ? false : true;
 	default:
 		return false;
@@ -156,6 +157,7 @@ static int amdgpu_ras_mgr_init_mp1_config(struct amdgpu_device *adev,
 	switch (config->mp1_ip_version) {
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 14):
+	case IP_VERSION(13, 0, 15):
 	case IP_VERSION(13, 0, 12):
 	case IP_VERSION(15, 0, 8):
 		mp1_cfg->mp1_sys_fn = &amdgpu_ras_mp1_sys_func;
@@ -325,6 +327,7 @@ int amdgpu_ras_mgr_sw_init(struct amdgpu_device *adev, struct ras_module_param *
 		return 0;
 	else if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14) ||
 	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 12) ||
+	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 15) ||
 	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6) ||
 	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(15, 0, 8))
 		con->uniras_enabled = true;
-- 
2.34.1

