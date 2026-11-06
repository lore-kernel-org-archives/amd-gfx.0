Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD5B606A326
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 22:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oWWVVBln
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E091410E4A6;
	Fri,  6 Nov 2026 22:46:30 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A690610E4A6
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 22:46:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufIIs3R9RKI+7TyL7+ITWF+te0v2Q3szk5n+VAW54rHX+ThZ1BCGAU9dkoolZaUylZG4zAcBHAt4+FMDADsYEpXYF+agr8NHf+4DOpYag1EitFJ25z19B3zftgj7Pif0qmdNixvh3xd4MCvniU3UW771lV1E1+RGon3zQzCC7yMq69piqLWJWJZSaEo0ac1WCHHKRvOaTozJUssb1i2EW2HtsNyYhVNR/6zrKeyP59ETykztIIzqtdqF4IYK6IDF5DNfYBCj2zxJt0YoHQNUOnCbwAogLbOR3XA0fml64mVW9QrCBMSZzwItVr4/VKfknheLapbX4HM+Un+9BRfa6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f41TXHqwJLam7Dz1z715dI7vqkMLSiGO0r5nGSrDhNs=;
 b=Ec4pj0W+wY3ISRQ6asRxF24QeXte4dmBsEA5Oi2rO1j2tfR1P0zhMeAs6kRdLLr866xI6QJC7q8LNa5ly1beeibVBdbzBaZcgZDdC1Cf9jjaYcdFByogj0NKSQhu1QOw5giGoweY5+7B6rst4LtdPRWv2cQvw8CZTRa9RQ1lm8SfbHYSOtm7kgJwQ2rj3OJA7fL6/Bf5XAaGKEJL6pOeRsNHb8b1i1Hsd9gni5ncDQzL/vCnO8QTwp2CXzjH92ZYdt+E9L14WYGNAQyD3NnM2vGIZ3To3rM7ePrxH0MMRepiGAgtbvJm2KUqwF3Ggss8GKfYLOjQ7hGAvNSs1Uo03Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f41TXHqwJLam7Dz1z715dI7vqkMLSiGO0r5nGSrDhNs=;
 b=oWWVVBlnhuKigNvxJ5vB56QkEIo2XinJvdvfZ9reEzUe0W8M8IX9hjhzj1so/+sTOhXt4XjrKKqKJZks2SaM3ggFQ9MOzA0kqMXuUAh7Sm6tAFerFV2T+8u7TJW7W6QZgOP4HHliTpBoEC87RkYaAWcQLaevghN9hcWCch4/JPQ=
Received: from DS1PR06CA0021.namprd06.prod.outlook.com (2603:10b6:8:23e::6) by
 CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 22:45:39 +0000
Received: from DM3PEPF000265AD.namprd02.prod.outlook.com
 (2603:10b6:8:23e:cafe::6e) by DS1PR06CA0021.outlook.office365.com
 (2603:10b6:8:23e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri, 6
 Nov 2026 22:45:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM3PEPF000265AD.mail.protection.outlook.com (10.167.23.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 22:45:38 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 16:45:36 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 16:45:36 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 6 Nov 2026 16:45:35 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Frank Min <Frank.Min@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: use is_sos_alive func for sOS sol on soc v2.0
Date: Fri, 6 Nov 2026 17:45:20 -0500
Message-ID: <20261106224521.3568803-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106224521.3568803-1-alexander.deucher@amd.com>
References: <20261106224521.3568803-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265AD:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: e63c2e45-a49c-43f1-aa99-08df3c57ae0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|18002099003|22082099003|10067099003|11063799006|261026121527099003|261026140227099003|261102123227099003|261028144727099003|261022105027099003|261021123027099003|56012099006|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: L5cfVh9UwmrsxLb78Gv4+joR5mahtbs68lQspTitp3dJeDBsTDI8jMqaMElrUbgZ37US00HI6aASmdtajJKQcqeO4r3sj5ex/jtU36jV+rq6HoqWKSmwYFk8FeMhXU+bOWA63cVsnW3WOy1yvsn6qpe4Jk6crXqqVC2vvNy/EG1+vFwN3TCG9k9TbwC7W1ueTYpLl8Bc3e6hWLj6UTyUphvUGgOxe/hE7r022Qhnm8PX5lEJcOkiP2EX7kUu27MH19dHJqyvA16nlzpNeXrQctIHwjkaVRtM7/X6GWRKnFWrcAvW5pAkJnXme8F2f1AhpWSvL44N/g/MNsL9Qx1q1tQLoNu+MRlWBNOmk72Q6w4QA0pTKPbKKFHm27bdR0Hn2ZbXv/MqvjaQexH41W6Un4dterp0KFoLLh4gq1itDp4/INlmWLBPpLsLyp2X0hfqoe3/M6p8ANQK1yJHPDGqjttCp5A980BKF3oFPls9sB05iksapXgKHC1I+4XpgzkfLm2A1GqkxTOT812ofHNDaLL1GZjzPqOUNz4aqkYQirnEezwILpj21rI98KDJI8epL/hi8LW5d2T8gH6Vsh+kPtBfczH2DMGpVTWxy0WsVJG/ohKaRf1hrGVovH38hBA9nFMJ8Vx/7sNy3VJAyuu01/VwKI+2kgLCszV3wo3y4uRvAbLCPkRox4+DOTlEyPs5MRp/l8n2VMgtNFJsOuwo6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(10067099003)(11063799006)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(261022105027099003)(261021123027099003)(56012099006)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ixzoMB4VUIFtJDjXMBtGMOR54iTuGHpsXKrAGrrrc/jE1svxyPrIDyt4RV3h+xrVxSM/y64tXPh5VC+SIM+ewyZsLevL3OiLYhFyGYiIFrvtUP0K4qb2ZV6eTcXps9GicKsS488ddkWzX7QPLprMbBrV4tOKF1lx6VK2avohJ6GCE/PYWacvWHaJDhjharlOFmRes6gHoxkXkofcbl4+0maAPquwQ1wFkkjT4qKiH7jbgjJO9sFnsjbKOzq4EQAOfTKx+vJE2IXKtmneaGnCnBl6YkjxP4fH4BDqlazyhgI3w6gzVnNzAzr/v+gQo+tjAt7CL3Xr/Mv1jNI0juYVdYRaGwbxNcLQkeZp2VH8VwqNuToVjRSsI2gy2eJ2dPO38j7rJoZJ7fWSoxi3XxsluQje343DdF+UIFlUqfwVFnNM9dxiUyN7FzKHdz8npHyY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 22:45:38.9125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e63c2e45-a49c-43f1-aa99-08df3c57ae0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265AD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488
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

From: Frank Min <Frank.Min@amd.com>

Use is_sos_alive function to judge sOS sign of life on soc v2.0.

Signed-off-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h  |  3 +++
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c |  1 +
 drivers/gpu/drm/amd/amdgpu/soc_v2_0.c    | 10 +---------
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 975d123593588..7eb8a2d4a4cdd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -143,6 +143,7 @@ struct amdgpu_psp_irq_mgr;
 
 struct psp_funcs {
 	int (*init_microcode)(struct psp_context *psp);
+	bool (*is_sos_alive)(struct psp_context *psp);
 	int (*wait_for_bootloader)(struct psp_context *psp);
 	int (*bootloader_load_kdb)(struct psp_context *psp);
 	int (*bootloader_load_spl)(struct psp_context *psp);
@@ -528,6 +529,8 @@ struct amdgpu_psp_funcs {
 #define psp_ring_destroy(psp, type) ((psp)->funcs->ring_destroy((psp), (type)))
 #define psp_init_microcode(psp) \
 		((psp)->funcs->init_microcode ? (psp)->funcs->init_microcode((psp)) : 0)
+#define psp_is_sos_alive(psp) \
+		((psp)->funcs->is_sos_alive ? (psp)->funcs->is_sos_alive((psp)) : false)
 #define psp_bootloader_load_kdb(psp) \
 		((psp)->funcs->bootloader_load_kdb ? (psp)->funcs->bootloader_load_kdb((psp)) : 0)
 #define psp_bootloader_load_spl(psp) \
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
index ff3a25e270c3a..4d494eb5ac3f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
@@ -837,6 +837,7 @@ static int psp_v15_0_3_get_fw_type(struct amdgpu_firmware_info *ucode,
 
 static const struct psp_funcs psp_v15_0_3_funcs = {
 	.init_microcode = psp_v15_0_3_init_microcode,
+	.is_sos_alive = psp_v15_0_3_is_sos_alive,
 	.bootloader_load_kdb = psp_v15_0_3_bootloader_load_kdb,
 	.bootloader_load_spl = psp_v15_0_3_bootloader_load_spl,
 	.bootloader_load_sysdrv = psp_v15_0_3_bootloader_load_sysdrv,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v2_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v2_0.c
index 095d298f68675..92a3965df426e 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v2_0.c
@@ -35,7 +35,6 @@
 
 #include "gc/gc_13_0_1_offset.h"
 #include "gc/gc_13_0_1_sh_mask.h"
-#include "mp/mp_15_0_3_offset.h"
 
 #include "soc15.h"
 #include "soc15_common.h"
@@ -206,8 +205,6 @@ const struct amdgpu_ip_block_version soc_v2_0_common_ip_block = {
 
 static bool soc_v2_0_need_reset_on_init(struct amdgpu_device *adev)
 {
-	u32 sol_reg;
-
 	if (adev->flags & AMD_IS_APU)
 		return false;
 
@@ -216,12 +213,7 @@ static bool soc_v2_0_need_reset_on_init(struct amdgpu_device *adev)
 	 * driver and sOS are already loaded.
 	 */
 
-	sol_reg = RREG32_SOC15(MP0, 0,
-				regMPASP_PCRU0_MPASP_C2PMSG_81);
-	if (sol_reg)
-		return true;
-
-	return false;
+	return psp_is_sos_alive(&adev->psp);
 }
 
 static void soc_v2_0_init_doorbell_index(struct amdgpu_device *adev)
-- 
2.56.0

