Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B7AC5DF8E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 20:00:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 265EC10F3C9;
	Fri, 21 Aug 2026 19:41:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5naopuwW";
	dkim-atps=neutral
X-Greylist: delayed 344 seconds by postgrey-1.36 at gabe;
 Fri, 21 Aug 2026 19:41:31 UTC
Received: from PH8PR06CU001.outbound.protection.outlook.com (unknown
 [40.107.209.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55C7910F3A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:41:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFl/JBPN0VkdV8fjY1di1oQ0LoTZufNMqoUwJ8gCrqvHap2k2z0DWWJw0LRd6GWf3jn9h1zk8tl+mt5oElxdxBTs6QikdTRwLA+W3LQQ9vkD3U6YBJh8QBVXaLJj//SyzogUq3aO/XrkrADQEZtUc1WZDJtEkQNFBKFDO5sQxYDqEBkt7+LBVA7y7o61PEmLTpYvGbK0Xh8KVaPAzlf4WZPvvZIggwp2EhLgfhU5z0G1sv43Dym9k6qUof6OcdErp4KMvZn1ZzXUOJF9vNOjSMKgdRh11Exs7VuMSyesTIl0dpsgShewTtmdgOuYwsUSVCcTBRLJZ/INAIZh5mqtlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rY2jdbVjlWFRD4eLZJ/61ngItRxs5dy0hh//tVxkQqQ=;
 b=cid91C2PAsbZXhCBjULzE1JG5PIusq5MROk6moTLbyE0ap52SxT2DX0967o8qkArKh/yFJkN6PJtkY4OOaCuHZlvXqP3tz9fbxY0Tqfhf+mLsgyYxYmFn2pneAvtOpHTAnTlfXlOcNoj4gEazG69kNdJ+b12jQ7GBE+ZGBkzxvpDFjiJuAOSKXBQIRxj1adPVcdQxCQJZ2nV7+qm8yhFt1o5RaFUIdWSYsyW4QtYWian+jCiWTCndMJZ0JgOjHRgxB5aPowlfq8Uyc/rahnXr9EzDsvf2x/qNpCTr7lrZrTleLjUqHItFzn7dhrpdZLmE5J4FYmB3qK4NRtyvKV3Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rY2jdbVjlWFRD4eLZJ/61ngItRxs5dy0hh//tVxkQqQ=;
 b=5naopuwWrtkK43fqO63FJ9IOIuKRwBGJ016mvbLHmdF8kYuCi5naPYRcvA6s4UIYubTV7UteGacRG6sExJWaVuyI7m1T8+PxT0PBYhxNED+1XT6OLhJ/a8HWwfA7HFqYzFN7cRV7n7pBcc/0vlefWisyA+dL4Oc9NJZPJ8kP3z4=
Received: from CY5PR19CA0083.namprd19.prod.outlook.com (2603:10b6:930:69::21)
 by IA0PPF52B16157D.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bce) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 19:36:02 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:69:cafe::1) by CY5PR19CA0083.outlook.office365.com
 (2603:10b6:930:69::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:36:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:36:02 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:59 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:58 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 76/95] drm/amdgpu: Add ualink as separate ip block
Date: Fri, 21 Aug 2026 15:34:39 -0400
Message-ID: <20260821193458.808626-77-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|IA0PPF52B16157D:EE_
X-MS-Office365-Filtering-Correlation-Id: b57068c3-f663-4792-815d-08deffbb6f5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: cI1lWBjmqP/36DIxcND+qnLvjc4yoYXC7StrJpqZ7DEDPfkWiwPqlRi9o2/tEFOybTX1AiMp+qwOQ3XzHwF3NhvpANVb3+0+fyXIvtI8LxSqUuEqYR5b8bLbjaw3ldZtVKagApIUrvs+gMPk/6JxrTioJtPKsNLcypbu4fxbn5gM+dtq9UsVx+WtNyL8RFKHiVC42jNgZeSKCf0ENEXB9glxbnA7SCoXtq12DMeJGLqsnZVXw9yEoRbsHdKGxIJZnqWsiPHrZiloHKtldKUKn7dU2Aos4b1ATMLrJMAl4CBC3vWMu3XeO0N/lVDP2zCHDbzJ8g2D8PliOLvawoIi7lix4makY7elUb5YeGw9XGdaEs2yVIasMZdmOhtjKkhBuw5VoHYVMPae50ZQVfYQ8Gjc6jTo8E1Y3wdnUOBvACFe8Z+NjsKhJnIhuQDTCSDvTPvtQDgq2hi1z2CxCXZhpOFhOZFM7sohoFgb5MgWwbgpNNhhWSatxaTw0u/kkVo/NqdNAD4qBHvK95iueNPprwgJ0ed/oJUNFfd8nDFDAI1fs0rs6Oe2O9K0Uq55IRERrAQnEbSUN7//AeNs1e4EKJWZidJTvKGZqtJYpicAELehWYSa0r8Mc1qnKvZJNcHe1bDn1vU+ddL/HbnXaONCSJDr9iwLzTBRxtsZcH3rhokYL2cGR6HXFoWPyPCRuCmDo7vS+5F1ww1wvIGaMicGcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Qx1Srs7JMG/24rYkKPkn0yFpCEsFLVUg2glRjx/75TPDsJTvSfn3Rotw7hj9tQjhID6ou8UWarSvS8Y8tdLVWAJUNgEfs9e0If437fCdTYlNoE5Upj8vusaJEzmc1lHrnh2aXL9nOnuc3AlSAV41VKvj3Ln9pbsGsoD4bHPVe5jB8gTq1eW0RWadRV1uus+qHCqk3djDn5DZB1C/UzkVfDb+y5Ztz7TpyqxoxEgymdthN7+eqEvIPrU8UUVBylkcD9wA69cl+asMw4XYBlwFYbJxObxtyiiUSAGP5vHer7JktmmdLc2Y98+rJXjBLtkaHI12dPx7lcKCZjLD4GgJ/edqqauiFrKkoWWv5GbLjLeq0Pz0+7ZYw+3y2KfCLsi9wFMt4PyYYzhwG8OZIkXyGWrdlKE7NEMoxd/dXUBuJAQEXg3cHv0UsDAIKHxBnNye
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:36:02.4709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b57068c3-f663-4792-815d-08deffbb6f5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF52B16157D
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
index 715cc2e85105c..28841fdb3798f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2456,8 +2456,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 		}
 	}
 
-	amdgpu_ualink_mgr_sw_init(adev);
-
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_init_data_exchange(adev);
 
@@ -2484,8 +2482,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (r)
 		goto init_failed;
 
-	amdgpu_ualink_mgr_hw_init(adev);
-
 	/*
 	 * retired pages will be loaded from eeprom and reserved here,
 	 * it should be called after amdgpu_device_ip_hw_init_phase2  since
@@ -2769,8 +2765,6 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 		adev->ip_blocks[i].status.late_initialized = true;
 	}
 
-	amdgpu_ualink_mgr_late_init(adev);
-
 	r = amdgpu_ras_late_init(adev);
 	if (r) {
 		dev_err(adev->dev, "amdgpu_ras_late_init failed %d", r);
@@ -2963,8 +2957,6 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 
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
index bc53d37534222..afcb5ef84bd48 100644
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
@@ -1030,18 +1021,16 @@ static const struct kobj_type ualink_station_config_ktype = {
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
@@ -1084,9 +1073,10 @@ int amdgpu_ualink_mgr_sw_init(struct amdgpu_device *adev)
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
@@ -5550,3 +5540,19 @@ int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev)
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
index 3c5bfdd3af5bb..3c043167f948e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -371,10 +371,6 @@ void amdgpu_ualink_sw_fini(struct amdgpu_device *adev);
 
 int ualink_send_hello(struct amdgpu_device *adev, u32 remote_accel_id);
 
-int amdgpu_ualink_mgr_sw_init(struct amdgpu_device *adev);
-void amdgpu_ualink_mgr_sw_fini(struct amdgpu_device *adev);
-int amdgpu_ualink_mgr_hw_init(struct amdgpu_device *adev);
-int amdgpu_ualink_mgr_late_init(struct amdgpu_device *adev);
 
 int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_ualink_sysfs_fini(struct amdgpu_device *adev);
@@ -387,4 +383,6 @@ int amdgpu_ualink_import_handle(struct drm_device *dev,
 				const struct amdgpu_ualink_handle *ualink_handle,
 				int *fd_out);
 void amdgpu_ualink_revoke_exported_memory(struct amdgpu_bo *bo);
+
+extern const struct amdgpu_ip_block_version ualink_v1_0_ip_block;
 #endif
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index e3baef809cd11..fa6caf8e04b5e 100644
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

