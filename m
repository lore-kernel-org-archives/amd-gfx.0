Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126A3C5DF74
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52B1710F712;
	Fri, 14 Aug 2026 21:03:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="avEoeBjx";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6CF310F702
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJexyrJIIPvYA5qIlNdwWB3P0e49op2PMwpXsPNWWzeXESvXqV6sqYWlMCQ/FGUarR2+fSj45dNfFTJq8rIdGeorSVEhtlOE7/Ui638l+UJxmVs2jissnaFzT1oPkb3jlvvLb8hfplhhAW7SbG+kdJWoUepY4S5d3uuw0NYm+etLIyzsYLbjU/wh5y6GTsNy+f1wgm2gT9NLDHSIcQn6TpEMyo9+B/R9lu37f4VGx6jYCVIWpW5zca4TsxibGThF3urb+6EL4Ki3Y4PJjvQGzlW0JnlNCwsB1FL0Z6FsyHLBYcH6MKw4d0HJoqYUXRNVrT0nSVwc6TxVjUkkLz30mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXyJfSZKqOVvXhou2gPtxsrnVd60P/WHlsvvsrlp9sk=;
 b=akCDVqqfJgBDUiqWuY1xW4YBrovdN9eZaejmTwcS4nI8Vxod8GPRznAR2lNylU1SHCrFqYxIarr3lKtm24859KDzObnLzYlHvV2bg0eqILGu6jFQErRAR8gw5XPdv/X5NfWyXca03EfQilapmFQLR2lvSXEah/yz7GRfAacbisWsmhZ0pYyt/sb+L6hrCKiW+FOo7uxjblWUm2QwJ5zsFstuFyMhI0OSXRQKaJdLK2ymhNumlb1vNod0uz/WO8xXxiqH7QnmRIbQLlNZq5XOQUgFeb4FcPc4V3SWibFtz/AqIAo9/s8L2rgS0jIoblm8EImP+ymPiFeLmtmc0wtKGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXyJfSZKqOVvXhou2gPtxsrnVd60P/WHlsvvsrlp9sk=;
 b=avEoeBjxswPPWe/1auKUXOZhdL7um1rnk5V29cfX2bPb/7LfancviyX2nZUwcKIelAu6BD11pI9KJgd3znloxoCfbVMcERLxAIUEkov10mBSAc5u4i9XCrrfvsDl2SasiYZEPf9UZXe3yseBxfxQzVo1vm4QVKWOs1LELXCn4NA=
Received: from BN9P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::12)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:34 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::41) by BN9P223CA0007.outlook.office365.com
 (2603:10b6:408:10b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:31 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:30 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 055/109] drm/amdgpu: Add bad page preloading and
 pre-reservation support
Date: Fri, 14 Aug 2026 17:01:52 -0400
Message-ID: <20260814210246.3067612-56-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|SA0PR12MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: 357391d4-0912-46f1-538d-08defa478091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|56012099006|10067099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: jjT2aB2jzmNg7RzyHoQaUeDetKhxUO4RadWSzdP2Z4BSXQDq81LtkNA+bfENwIHDu7fs7hN0UiVUHdl7NaZoDRJVITFcEdjH3rfxaFACFz6b42FF6DepKPb/dGghBlrTMamf81X9hYls39zfjnCrubeWW68v/4hNVVooE//g6T0iBdqCoKPLnIpryHD/R4fP9bpFr9Sr9b3HHpvqIPLHvzDwctny3HEl7x+bqYUWca5bkADVfUstm1VrYopWhbY9Y2WqeCxOyADGwlIkd/wmJQZeQ5v0Oo1/XfZDDlDaRhKKSgOrThnKdO7udpfvk6cimfGwjBodce0nz6vWKtD7zwCyMsWmFW/7ZypfBTHoYFRgjIcvTl7b+wq+hsm1iGkAWFovOlQWU+ewRwmg7Sq5bZDmyHrT5S3Quku0B53jHuI0MRCFJowHkCNJ+bSjncpHBMP4MDmPg7azSNCv1MlWnYjEHzEAXJNMzjoxEArgA43wFRnvqW3bQKZbW3Ia1lV3rSe+/nKx8LoVyIMk5qaLtanwekcGwJnMF3wqKrMHvJ7FGHi1JGgUWFfjQP31uerMT9gIt0fnqA/BnL8jYKAsd7SQXe4B7kAUJNXLFHjYHs1DtwMR/OnOB+uYPny/xtttL9ozInkhqMHy7YVE64I/3BijTSVSCY5MRxyIdJQOMbM27KKGcutrbp8d1NR+l4g1YwSn8UdoLkHegC2jt3+1Kg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ryLw4o4tzBqp0kxh3sqQCTWh5FKTiiSVuEox06XyYNSb2+EK7MM8ZkYJpyGyo8migjD/ml6AIu8eCPcp2LIuB8bYortYUUNI1qOw7GySInHGI5CBDj8nTWsO0UjwhfJ3oOs6nIKyN5uJB4YJoLX2A74hZW4btrJl3fAOdYBL2dOgQy5kxkN2fFCwksGKkj1l36x7thWLGjTwMab7j7osNhwxiRX45/XB3sqFqocbP2/uTUo6GWZfF24WBUIl2IuQrZdLqdiIyVfr4ntO2S2guxyOV5pbWUC3j6lgLzJyaj3zTx7sBLn52zoNrlDJ9em9dWiT0UrjadPGLwR0EfJXJ3JqkKzA9XymZHy2Uns/1jKiXUdZ0j1eKMpg3gR1NaH9FfBgcfsLyAeTnDKU3Gjmtp9T5/jzv93zuRAxnoNtsN0EHx0mRDoFECgHdm9GyrdY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:33.9388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 357391d4-0912-46f1-538d-08defa478091
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Add bad page preloading and pre-reservation support.

v2:
  Add modification to ensure amdgpu_sw_init does not fail
  and remove deferred ras instance release.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c    | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c          | 7 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          | 4 ++++
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 8 ++------
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h | 2 ++
 5 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index a404d8aa13eee..c03d3c40b4587 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2840,6 +2840,7 @@ static int amdgpu_discovery_set_ras_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 12):
 	case IP_VERSION(13, 0, 14):
+	case IP_VERSION(15, 0, 8):
 		amdgpu_device_ip_block_add(adev, &ras_v1_0_ip_block);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 1cd12eeee12b6..d3872e4787460 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3590,7 +3590,10 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 
 	amdgpu_ras_check_supported(adev);
 
-	if (!adev->ras_enabled || adev->asic_type == CHIP_VEGA10) {
+	amdgpu_ras_mgr_sw_init(adev);
+
+	if (!con->uniras_enabled &&
+	    (!adev->ras_enabled || adev->asic_type == CHIP_VEGA10)) {
 		/* set gfx block ras context feature for VEGA20 Gaming
 		 * send ras disable cmd to ras ta during ras late init.
 		 */
@@ -3980,6 +3983,8 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
 	struct amdgpu_ras_block_object *obj = NULL;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
+	amdgpu_ras_mgr_sw_fini(adev);
+
 	if (!adev->ras_enabled || !con)
 		return 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 5bcb6a966941d..8edf1791fa4db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -56,6 +56,7 @@
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_sdma.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_ras_mgr.h"
 #include "amdgpu_hmm.h"
 #include "amdgpu_atomfirmware.h"
 #include "amdgpu_res_cursor.h"
@@ -2158,6 +2159,9 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
+	/* RAS loads and reserves bad pages */
+	amdgpu_ras_mgr_early_init_service(adev);
+
 	if (adev->mman.resv_region[AMDGPU_RESV_MEM_TRAIN].size) {
 		struct psp_memory_training_context *ctx =
 					&adev->psp.mem_train_ctx;
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 128a9bc1f2f09..525abb7e05474 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -277,9 +277,8 @@ static struct ras_core_context *amdgpu_ras_mgr_create_ras_core(struct amdgpu_dev
 	return ras_core_create(&init_config);
 }
 
-static int amdgpu_ras_mgr_sw_init(struct amdgpu_ip_block *ip_block)
+int amdgpu_ras_mgr_sw_init(struct amdgpu_device *adev)
 {
-	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct amdgpu_ras_mgr *ras_mgr;
 	int ret = 0;
@@ -346,9 +345,8 @@ static int amdgpu_ras_mgr_sw_init(struct amdgpu_ip_block *ip_block)
 	return ret;
 }
 
-static int amdgpu_ras_mgr_sw_fini(struct amdgpu_ip_block *ip_block)
+int amdgpu_ras_mgr_sw_fini(struct amdgpu_device *adev)
 {
-	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct amdgpu_ras_mgr *ras_mgr;
 
@@ -464,8 +462,6 @@ struct amdgpu_ras_mgr *amdgpu_ras_mgr_get_context(struct amdgpu_device *adev)
 
 static const struct amd_ip_funcs __maybe_unused ras_v1_0_ip_funcs = {
 	.name = "ras_v1_0",
-	.sw_init = amdgpu_ras_mgr_sw_init,
-	.sw_fini = amdgpu_ras_mgr_sw_fini,
 	.hw_init = amdgpu_ras_mgr_hw_init,
 	.hw_fini = amdgpu_ras_mgr_hw_fini,
 };
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
index cb98606306932..32416c9d6086e 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
@@ -61,6 +61,8 @@ struct amdgpu_ras_mgr {
 
 extern const struct amdgpu_ip_block_version ras_v1_0_ip_block;
 
+int amdgpu_ras_mgr_sw_init(struct amdgpu_device *adev);
+int amdgpu_ras_mgr_sw_fini(struct amdgpu_device *adev);
 int amdgpu_ras_mgr_early_init_service(struct amdgpu_device *adev);
 struct amdgpu_ras_mgr *amdgpu_ras_mgr_get_context(
 			struct amdgpu_device *adev);
-- 
2.55.0

