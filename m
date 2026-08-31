Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E717C624D4
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:30:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57AFC10EAA6;
	Mon, 31 Aug 2026 18:30:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1CcMr7Wv";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7F6D10EA6E
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kp8qmZY24svofuXe8pliqb4IesDXdsX1yLVWQWyZzGOg0fY4rKm1njxNMiLgRxXpKoyv6VHML1MOLWUimmG1oBf9ZP/9Z3NNP7mNGlH3ZpGwo2f3PmZNPHDJC7KZpw5sP7K5CQcbqI8N9xMhnjTedzcMVZEGkcGTXlbVRMPIw1D8sHlp6pZElYmBcJmaaeqZFMi0vxlUo4rm+pYYbEBq4tztSmq8OSfOtGcrnfG3c/lMwjfzk9SgzBOTZy64BpnFsFzfBZ7V1XrFKZyVwyo8NJBmay+doBYJH4X0zxASs8uRNZz4rtcZDafjeFzYZlpwEWT3OKnSNYdAxGLF7jKUqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxEVgqzJOT7jpOuY2cfC9UxNVgBzOdg/J5W8FmesFtI=;
 b=fL4X5sGcjRwd5GiuZ9IkWsGbzZCWpv2+83izqtdTKtPZH3Aw4u/l40zX2nwcueJALGdyOSSWXXFWtf4voyiG4gWVF0NUrFEy9HcU/5qUTXGCdBOxxXci2YE0EFNqbENDMKJowMXrTORxPkOFB5B8FD0MYyPRppATRBoCsEIc731yHPTTL4jJkjBQPte3ksTyUxtdiexeg76LTLE0DA3+Z4HTXmtJwEKjPOg6ElpL2hACC217jepxxOGiWbivYwxSGh0Xqu/42+77f9F4beNZS2ggEl8e+crHbECHcGWW4xUNhjMWtRopuECLJgVNWYKJE43ZajvDzrGR0rBZEXh1RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxEVgqzJOT7jpOuY2cfC9UxNVgBzOdg/J5W8FmesFtI=;
 b=1CcMr7Wvo3b0fOmObvBnKXI61jq29LCRn8lcXxXQ0+fY8rnlztaA3kIcZWqbHboQNlDZV1dH4KbLIdoYP7hguA8REbPeHdPQFiUByNvgGzQyV9idDfbhZMhu3/x5slXcjw0J2N1U0ucGt4yeKYd0NllwmqC1HLvF2sfwJdncycs=
Received: from BN9PR03CA0679.namprd03.prod.outlook.com (2603:10b6:408:10e::24)
 by CY1PR12MB9700.namprd12.prod.outlook.com (2603:10b6:930:108::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:08 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::9e) by BN9PR03CA0679.outlook.office365.com
 (2603:10b6:408:10e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:29:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:07 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:55 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:55 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 76/95] drm/amdgpu: Add ualink as separate ip block
Date: Mon, 31 Aug 2026 14:27:35 -0400
Message-ID: <20260831182754.1089811-77-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|CY1PR12MB9700:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a344e24-7abb-41a1-1431-08df078dbe77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 0zDA/Fwivem4uUSC8C7n+7dDttFxFI15b5T/9owDVUtvmYsvNaN6Iodu5/7zsYl6CIlzJFq4bNtQ8b+pRSYv5AWjwmpGy4HtboyKF4GuiPTxJFj+rhgCr1aMRS2Z5zHD6qrmGI5eG5ewN1RsmFiT15IqhG9nrZ+pnpm8Sy7T0z2QMN7C/NyOE4rVsZUhTJpFEr3mWbzlQmq8mD+qvwubPivtuQpS1gqMzuv4nr1TVZ5Srqw9VlcsQ8vezZ6yYfQ+3ODn+Ytkvn4jMWnUd+tbiEPNpPrCwT0/v7SfDeVaVcKe3WkcjxxXUXTVgpnRBVpkrcd7ASFXDjlEJUVOrUam/rpO0UYCpd7GKkqiePKVhiuljR7itxe0YOnWu1MNds3a8FdBc/rOxwjDhPyOgklwrda/Jre07hk0upsnGzapSqiCyIgBn/+ibU+0OtHjbfkuFQiJyP0A1YHRqHEe3fmZWhDHGBJ9OmbAYc8Y8CKViByT5eGa1IAHDxgt/XaarCa1J/nBUkZPqHYhWlaZ0KJsUULeMvVtcHggqKrzv6HowyLQiqkBFWzKHRf6IntyGbeuKo45D/IUHVUz814gnJmiIqf+aXKQvLkB16kYZipIzNMJdNMaMw93/dVUyg9lQFdfkJfo0L3FiezaeCKkn6s+RGW9ROtFuNzDYDuQBrin9Ux0bB4pnd0QOUZTJnd7uqjKsxUEelFPWTvPCPnmXDaluQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iVQi7lRVQAdoJ8TeA1JjSj7YGciyxDYo5QtW/WxYaq897B3k+G10k5NPVortWGlkbOfkIUyETLQa92pK9QDef6nmlWLgKjd7MZylVRKE6PpZLGFHiQXfSe0/3D+WNrBz+sQ1RiHbZo0s+9HWh5/Ilue7dXckx2WrU6UavFYYzchsWEjJ6s9d6W6IdgYWVdfSKept+JWzMb1crfL03cXSIbegIFS5MZWSvEL6V4RQOk6MWaNja88jqcSRyMFDpF9JDi2h2mJSDC5vHm9o4Tlbf0wvXl7bbJ/73t+NCNL0tboSTfhvHJmVhEXEfGKyTmrtUv5hzUgcTiX+KFuGBN7dLgF/StJk85na1+xUD3WauOlSniawnNIrlwGcUrF9Duu0E/0GKE7pIxASKeFZ1RUls/PYVq/kMcE01eP1pS1GfQsik1Rjesj4jK8G4V+S1MT4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:07.6771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a344e24-7abb-41a1-1431-08df078dbe77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9700
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

From: Lijo Lazar <lijo.lazar@amd.com>

Manage ualink lifecycle as a separate IP block. For now, use GC version
to add specific ualink ip block.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  8 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 21 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c    | 44 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h    |  6 +--
 drivers/gpu/drm/amd/include/amd_shared.h      |  2 +
 5 files changed, 50 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 02c4d6956d6e2..44091ac12fa9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2459,8 +2459,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 		}
 	}
 
-	amdgpu_ualink_mgr_sw_init(adev);
-
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_init_data_exchange(adev);
 
@@ -2487,8 +2485,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (r)
 		goto init_failed;
 
-	amdgpu_ualink_mgr_hw_init(adev);
-
 	/*
 	 * retired pages will be loaded from eeprom and reserved here,
 	 * it should be called after amdgpu_device_ip_hw_init_phase2  since
@@ -2772,8 +2768,6 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 		adev->ip_blocks[i].status.late_initialized = true;
 	}
 
-	amdgpu_ualink_mgr_late_init(adev);
-
 	r = amdgpu_ras_late_init(adev);
 	if (r) {
 		dev_err(adev->dev, "amdgpu_ras_late_init failed %d", r);
@@ -2966,8 +2960,6 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 
 	amdgpu_amdkfd_device_fini_sw(adev);
 
-	amdgpu_ualink_mgr_sw_fini(adev);
-
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
 		if (!adev->ip_blocks[i].status.sw)
 			continue;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 81c3cdba4caf5..7710a8ed3d44d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -26,6 +26,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_discovery.h"
+#include "amdgpu_ualink.h"
 #include "soc15_hw_ip.h"
 #include "discovery.h"
 #include "amdgpu_ras.h"
@@ -3359,6 +3360,22 @@ static int amdgpu_discovery_set_isp_ip_blocks(struct amdgpu_device *adev)
 	return 0;
 }
 
+static int amdgpu_discovery_set_ualink_ip_blocks(struct amdgpu_device *adev)
+{
+	/* TODO: no dedicated IP discovery version for UALink yet; key off the
+	 * GC IP version for now.
+	 */
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(12, 1, 0):
+		amdgpu_device_ip_block_add(adev, &ualink_v1_0_ip_block);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 {
 	int r;
@@ -4008,6 +4025,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		return r;
 
 	r = amdgpu_discovery_set_isp_ip_blocks(adev);
+	if (r)
+		return r;
+
+	r = amdgpu_discovery_set_ualink_ip_blocks(adev);
 	if (r)
 		return r;
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index d24bd447c93cd..2772d99233615 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -80,17 +80,6 @@ static int amdgpu_ualink_drm_client_create(struct amdgpu_device *adev)
 	return 0;
 }
 
-static bool amdgpu_ualink_supported(struct amdgpu_device *adev)
-{
-	if (!amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP))
-		return false;
-
-	if (amdgpu_ip_version(adev, MP0_HWIP, 0) != IP_VERSION(15, 0, 8))
-		return false;
-
-	return true;
-}
-
 static void amdgpu_ualink_object_fini(struct amdgpu_device *adev)
 {
 	if (!adev->ualink.info)
@@ -106,8 +95,9 @@ static void amdgpu_ualink_object_fini(struct amdgpu_device *adev)
 	adev->ualink.info = NULL;
 }
 
-int amdgpu_ualink_mgr_hw_init(struct amdgpu_device *adev)
+static int ualink_ip_hw_init(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
 	if (!adev->ualink.info)
@@ -142,8 +132,9 @@ int amdgpu_ualink_mgr_hw_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-int amdgpu_ualink_mgr_late_init(struct amdgpu_device *adev)
+static int ualink_ip_late_init(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
 	if (adev->ualink.mgr_state != AMDGPU_UALINK_INIT_HW)
@@ -1059,18 +1050,16 @@ static const struct kobj_type ualink_station_config_ktype = {
 	.sysfs_ops = &kobj_sysfs_ops
 };
 
-int amdgpu_ualink_mgr_sw_init(struct amdgpu_device *adev)
+static int ualink_ip_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
 	struct amdgpu_ualink_station_config *stations;
 	struct amdgpu_ualink_vpod_config *vpod_config;
 	struct amdgpu_ualink_ppod_setup *ppod_setup;
+	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ualink_info *info;
 
-	if (!amdgpu_ualink_supported(adev))
-		return 0;
-
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	ppod_setup = kzalloc(sizeof(*ppod_setup), GFP_KERNEL);
 	vpod_config = kzalloc(sizeof(*vpod_config), GFP_KERNEL);
@@ -1113,9 +1102,10 @@ int amdgpu_ualink_mgr_sw_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-void amdgpu_ualink_mgr_sw_fini(struct amdgpu_device *adev)
+static int ualink_ip_sw_fini(struct amdgpu_ip_block *ip_block)
 {
-	amdgpu_ualink_object_fini(adev);
+	amdgpu_ualink_object_fini(ip_block->adev);
+	return 0;
 }
 
 static int ualink_kobj_add(struct kobject *kobj, struct kobject *parent,
@@ -5599,3 +5589,19 @@ int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev)
 	return r;
 }
 
+const struct amd_ip_funcs ualink_ip_funcs = {
+	.name = "ualink",
+	.late_init = ualink_ip_late_init,
+	.sw_init = ualink_ip_sw_init,
+	.sw_fini = ualink_ip_sw_fini,
+	.hw_init = ualink_ip_hw_init,
+};
+
+const struct amdgpu_ip_block_version ualink_v1_0_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_UALINK,
+	.major = 1,
+	.minor = 0,
+	.rev = 0,
+	.funcs = &ualink_ip_funcs,
+};
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 90116ed532d16..64ebdf943aa72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -375,10 +375,6 @@ void amdgpu_ualink_sw_fini(struct amdgpu_device *adev);
 
 int ualink_send_hello(struct amdgpu_device *adev, u32 remote_accel_id);
 
-int amdgpu_ualink_mgr_sw_init(struct amdgpu_device *adev);
-void amdgpu_ualink_mgr_sw_fini(struct amdgpu_device *adev);
-int amdgpu_ualink_mgr_hw_init(struct amdgpu_device *adev);
-int amdgpu_ualink_mgr_late_init(struct amdgpu_device *adev);
 
 int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_ualink_sysfs_fini(struct amdgpu_device *adev);
@@ -391,4 +387,6 @@ int amdgpu_ualink_import_handle(struct drm_device *dev,
 				const struct amdgpu_ualink_handle *ualink_handle,
 				int *fd_out);
 void amdgpu_ualink_revoke_exported_memory(struct amdgpu_bo *bo);
+
+extern const struct amdgpu_ip_block_version ualink_v1_0_ip_block;
 #endif
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 7e29fe312ac69..e81ce9d790097 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -90,6 +90,7 @@ enum amd_apu_flags {
 * @AMD_IP_BLOCK_TYPE_UMSCH_MM: User Mode Scheduler for Multimedia
 * @AMD_IP_BLOCK_TYPE_ISP: Image Signal Processor
 * @AMD_IP_BLOCK_TYPE_RAS: Reliability, Availability, Serviceability
+* @AMD_IP_BLOCK_TYPE_UALINK: Ultra Accelerator Link
 * @AMD_IP_BLOCK_TYPE_NUM: Total number of IP block types
 */
 enum amd_ip_block_type {
@@ -111,6 +112,7 @@ enum amd_ip_block_type {
 	AMD_IP_BLOCK_TYPE_UMSCH_MM,
 	AMD_IP_BLOCK_TYPE_ISP,
 	AMD_IP_BLOCK_TYPE_RAS,
+	AMD_IP_BLOCK_TYPE_UALINK,
 	AMD_IP_BLOCK_TYPE_NUM,
 };
 
-- 
2.55.0

