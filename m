Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DDACA5FFC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 13:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FC0310F589;
	Wed,  7 Oct 2026 13:14:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c1MAdw3b";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013020.outbound.protection.outlook.com
 [40.93.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17B4710F58A
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 13:14:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llkCli984R4Kx4Ip8kbLnYzdzIjYy425kKXRrrGhaIw40VNU1BbFNLSp38T6xF/S16kiU/ktwWyuso+ai1XNBqJvjbt2yUXZKm39slPW32YQd6ypc1nUCpQM/Xyr+QXNRrmacFmgcoZH9e/azuG1ArmmeYnrI8Rz9NNCH+rdx0kr1sstIrSS4pwyEETihXVWSEyxswNaYPu+mkXQ07ymvCa6OXZeQvVpcfsg5q8utEdyWaF5hp/44FEAKhZf6FLcoBJTrUre4T1vcBG8ay+c5py0sqmjdB6OfIjg8mSGD67WReJDOaMv1vz7qT8lPwsM3mxXOJKi1ri5AZeNx7wQ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qldb/bAEQZyU1x1pranerEw15hzBWZEmNc56AM+sO2Y=;
 b=MDLbwuLNVgC7pN5nt+zsbmXJ5VUpH0a790kyakgZiKqUJOGUal6jwfLWgkxQHSTqmWRvDAfD5XVmRuO+u7OLPofwi0bx2l/bfNf4nsY28miZx8IQSHIxaPiFlW5+65mKA+R1BWPedzmS1jAc+aHw7WAnDfZQxiId9KOtUDMw1ayupCFjml5u2wYI7oNw44Rb3tEePThGHe0eqVQzWOx1o+flS6LuzVxFR/SxmbkvGdqYHVkGCHDFJ1ACzavmAzQYLVh6ByLZqxdk5XKk0Ni8eVlm0EtqURUvLlh+ALhJ06pqZHdifO8yunYIOZshLUj1aXxenhq4KGglo3ioUyh5wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qldb/bAEQZyU1x1pranerEw15hzBWZEmNc56AM+sO2Y=;
 b=c1MAdw3bBqW/ooSSzs9aMMf54t3zVUPd/BTp3h5wvZFfdEpcae7dKMM912/GU1NVihBj+6taoR9FyaohUDdWMli9QAobEoHIQJTyXGcV6cHJEsJ4ZHXM9dwrmT88vngu9t4hs/16WkO00Ujc7P+WieJsvODsWGq+Vl9g3PBTf/I=
Received: from BY5PR03CA0029.namprd03.prod.outlook.com (2603:10b6:a03:1e0::39)
 by SJ0PR12MB6925.namprd12.prod.outlook.com (2603:10b6:a03:483::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 13:14:45 +0000
Received: from SJ1PEPF000037AB.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::88) by BY5PR03CA0029.outlook.office365.com
 (2603:10b6:a03:1e0::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Wed, 7
 Oct 2026 13:14:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AB.mail.protection.outlook.com (10.167.244.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 13:14:44 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:14:40 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <Kevin.Wang@amd.com>,
 <asad.kamal@amd.com>
Subject: [PATCH 1/4] drm/amd/pm: Update smu_v15_0_8 PMFW headers
Date: Wed, 7 Oct 2026 21:14:25 +0800
Message-ID: <20261007131428.351196-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AB:EE_|SJ0PR12MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: 39637668-faa6-4dcb-d9b3-08df2474f47b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|11063799006|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: yeF4POsjiwTcMfFpiZc5AkEQK8ZiOIrZgNQt8gdepDeCHw+2dhNOz0igKW5ZcnfYYF8XIjuQNAEKg2mB8d3G2yTf6+3Ni4IEl5qobm4cbIqTa5dMAL+XJ3zJogusMRpE8FL9eBGM6hFSaRBY3fpytMU8E0gqaq3g7QsdF90FEIwdx0qt0QkmlIdHDksyX3Pz+8wCrVahPfaHFlOTRHXyJOI/WTy1ehEd16hiiRFOuk83GRFJNs29G2ABRMhGsMlGDHjVxafI16w0rd0lA9UC6vzq7N0pDt4a83u7j0q000BfJyMEDqb+WBgVvvGsEOo9nXS8nbvD2Ky3LGQk0nS8VSnKk3/R2JF4XMJ99RjA+3E+9yOfkxwRivQE3lWFsh7FiWnc1vRzMxw3J4XAASKhX+/tLNsCem44MtivuRh4p+AzfgdtsmGRp2SgkL74cPjbh7Wo4pHhi24Cznz2ZR7FdqbBQ3tRGGpid3fOnH3E2l8caudL2XN2ZDW5ei70YN234pwBpxe+o6Bf1M25S5Uj2Y3O/i9AAzR0RxD+cpn9kdY3P7U3hzeeaMFXKa9FGqSL7bK0mxOMq+uZLZZMsjH0O9+/mxwQQzw2D7aKe8LctEWLVIW1h6sYis+UgTCQQzpKCknjxXlg051mFBFAKXuT1UqPDGxhO+6Vtu/buM2B5ddQSzjcCZK6eLKGvnGw6xNzVE3DqRuc34fRM4+CqXrahQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(11063799006)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RQEHy/GHvkEcU0UA2xiUl8ZRSV63OMbQ0NqYJQFyHgaDX/Gd050pIjvLx3e35vN+ZvfFTknfkHjw2wQgDFF6u9V9o7OT+Nz5Yh3mR0C/VO9MIo0aE95gRnhrwa8wnpYxldO622Fk1+0XmKqyHAfWv2E5pFxN2zPlx2LczFK3vP7EwPoRfnBJLe97CxKpyL9y6q2y9ZLrxJ53AftTTNlq57JDadIJD72cIwP7+HU6tS3p3gzMwcHJItx6llgBDjErvBkwVeqZHzpdRegTV/oQMYiHo9qpktyJEZnb+ZlGGhOGDgXB6wHE8wZ8WhXekXxzCHfcTLtf7iRuuBqXTrVQEGa53U+JjrvijtmcIAiVD+r7XNq2X0CgaMIrqZOrqBObatmedZmdVH1TjCjjE6irVVsGUiPRuxJpayn9j3JogJtgBwRIW5gNnTfkCmRPGMki
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:14:44.5426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39637668-faa6-4dcb-d9b3-08df2474f47b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6925
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

Update smu_v15_0_8 PMFW headers to include NPM metrics

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_pmfw.h  | 12 +++++++++---
 .../drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_ppsmc.h |  4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c |  2 +-
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_pmfw.h
index a3401c4cc20b..61d76ebfdbd4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_pmfw.h
@@ -328,7 +328,7 @@ typedef struct __attribute__((packed, aligned(4))) {
   uint64_t GfxclkLowUtilizationAcc[8];
 } MetricsTable_t;
 
-#define SMU_SYSTEM_METRICS_TABLE_VERSION 0x1
+#define SMU_SYSTEM_METRICS_TABLE_VERSION 0x2
 
 #pragma pack(push, 4)
 typedef struct {
@@ -343,9 +343,13 @@ typedef struct {
   //NPM: NODE POWER MANAGEMENT
   uint32_t NodePowerLimit;
   uint32_t NodePower;
-  uint32_t GlobalPPTResidencyAcc;
+  uint32_t NPMResidencyAcc;
 
   uint16_t SystemPower[SYSTEM_POWER_MAX_ENTRIES];           // UBB Current Power and Power Threshold
+
+  // NPM flags
+  uint32_t NpmSupported;
+  uint32_t NpmEnabled;
 } SystemMetricsTable_t;
 #pragma pack(pop)
 
@@ -368,7 +372,7 @@ typedef struct __attribute__((aligned(4))) {
   uint8_t  FruId[PRODUCT_FRU_ID_LEN];
 } FRUProductInfo_t;
 
-#define SMU_STATIC_METRICS_TABLE_VERSION 0x1
+#define SMU_STATIC_METRICS_TABLE_VERSION 0x2
 
 #pragma pack(push, 4)
 typedef struct {
@@ -421,6 +425,8 @@ typedef struct {
   uint32_t PPT1Max;
   uint32_t PPT1Min;
   uint32_t PPT1Default;
+
+  uint32_t MaxNodePowerLimit;
 } StaticMetricsTable_t;
 #pragma pack(pop)
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_ppsmc.h
index 7ffb445f4c0c..bf73d10c0ce7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_ppsmc.h
@@ -83,7 +83,9 @@
 #define PPSMC_MSG_SetSoftMaxGl2clk	                0x32
 #define PPSMC_MSG_SetSoftMinFclk	                0x33
 #define PPSMC_MSG_SetSoftMaxFclk	                0x34
-#define PPSMC_Message_Count                         0x35
+/* NPM limit setter; NPM reads are served from the SystemMetricsTable. */
+#define PPSMC_MSG_SetNpmLimit                       0x40
+#define PPSMC_Message_Count                         0x41
 
 /* PSMC Reset Types for driver msg argument */
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 1b5a31163f3c..a013ae2a877e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -622,7 +622,7 @@ static int smu_v15_0_8_get_npm_data(struct smu_context *smu,
 		*value = !!SMUQ10_ROUND(metrics->NodePower);
 		break;
 	case AMDGPU_PP_SENSOR_GPPTRESIDENCY:
-		*value = SMUQ10_ROUND(metrics->GlobalPPTResidencyAcc);
+		*value = SMUQ10_ROUND(metrics->NPMResidencyAcc);
 		break;
 	default:
 		return -EINVAL;
-- 
2.46.0

