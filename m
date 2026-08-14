Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B397C5DF6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEBAA10F6EF;
	Fri, 14 Aug 2026 21:03:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l58jvMqH";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013049.outbound.protection.outlook.com
 [40.93.196.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6782D10F6DB
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUo61dkWZPowYPYBMc3H8tFpI3WtVEqJKhnI6JA8o22N3MPaWxskXiZZPx/VxruQNncWsTm6eySWEkrDdhvKR1uHFhcIa6LgW4C3OJ8p9Z9qyCLd22EtR1DiClHl0NDrZ49Xln28fgIlcsMVSaoezqMaqhJre763ZsbMEX9NuUdZcB7bSNvoHKHXcsuVJlvgRk+PeYcx01hGNyg0unVrxtnywKI2GS7+skSC+NRnW7HrcuAjDluXfcOkpTrcTSf8ph+AeXXhmCC0IqUaPImxFflm6NFquOXqPsvKzjmgWKGhIXb+waVT58lnCH3UK7ZbJaRduMSu0Z562LgAZ+ql/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsHcWfBLb174hVX97BVOcPjibAXrh75muRr2lltSJng=;
 b=q+T7Gx8PQW5aThdSyv1vJUBXfvOYGzsgLTJRKsb9E5SRkYg7ON4UOOKd06/wJ3N1NvMls3RXCCPdVu1nejvxzSTV/dTb8yx1U7gNlQbdbH9CPPjR4Qw0OBSrRfEmsxs6PXpz8gB9ri8LVplPWkgEXyHPKEu8kZCzlNDIU4FYKV5Eoer8xSJkd+MdfuotAQUQtak9sv+yeeSUtqzBVKjVRxZjm9vwPrC+FIRQvjdXPG13ZOtVyTStf7UTzS9D3uCMPFK83xRSw8Gcaw2WgYza5wiPcCoGF9FnkiL102q2trJR4qsu0N/cUeAu2PcTHzX78mwz77NUAVI1aKm0QT9cPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsHcWfBLb174hVX97BVOcPjibAXrh75muRr2lltSJng=;
 b=l58jvMqHT4bsNpGtM99oGXZ3VTPkXbymx7qJQR5xfgfDC3BHt3ZTLIH1m6P/Dcy3sVKDiRmPL5EK8CJ3z4IjeZqBrJXlFfc3pPPNF23DF9QNcdV6MNhi1u6EpPzYmhKx+C9yRTRCpDYTiYk5L+aEC0HhRH6zVa++/Ep05Kt0c3Q=
Received: from DS1PR07CA0028.namprd07.prod.outlook.com (2603:10b6:8:44d::17)
 by MW6PR12MB9019.namprd12.prod.outlook.com (2603:10b6:303:23f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:03:18 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:8:44d:cafe::42) by DS1PR07CA0028.outlook.office365.com
 (2603:10b6:8:44d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:13 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 027/109] drm/amdgpu: Support obtaining ras capabilities
Date: Fri, 14 Aug 2026 17:01:24 -0400
Message-ID: <20260814210246.3067612-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|MW6PR12MB9019:EE_
X-MS-Office365-Filtering-Correlation-Id: 43ef98ef-4ab7-4427-6344-08defa47776e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|56012099006|10067099003|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: DD0xVaGzwVNV8p27wFfjqz4POSMO3RnEB1d9VYBsrGPy1hhj+MjKC2Qyxwz/TVVF7izGxMXmnq+hTm3lb21ijyYjAimWPpp412yYBJdOtAzvTnGN8Q9/XsC6yv93ASeHRrABE3xuuaKGAtnvKaY0R/VNeKdsYgFvYfR6pqZryzlq7Pf2xPtZrFaIQeP5JzfHdveIHH7rmcrrEqOprK0h4TcqjEl01Mgq9jJjBDi0fi+ULLEesAyeGW7MTEy6wH3R1otlVVz/Mg2/+I51Z+/0mzhHI2EJMrj0zh6Ee1oWwtJAZFORxRSeAIcXR7O5hunSx0SAJGIBbRYodxSBiCGRVgitqSomnVGDn2d7EhMsyRFbiGfZqePqmFhUxi3JB/blOp3sKOWhQlJ4yZRgOIry72/y48vCMelO8TsrpKLsf0zSoRE0mBYttpws8YFTmWZx2rgQEzw2Xuar6gpPRLoHSl2cB/B/13UrVk8GkhfrYxY/TByRU1OMmq7glb3rOvGqPHs9vaZ+FIG3F9XQr624rHlaNkmnmelI4tGmx61EI4Ns05ksvoJiTYWAMkPKAXspENQwIkULtI1WNX+FNB3RMwlOBW+Yrjdk0qWkXm2a99lON+l2wCC0+jVctbNQcd7/45GzIm+oJwOxnKHLMbgzdOqJ8GXAg1W7UQzcOBMacxRbwJxX4oaMWnTxE7xoh/DwT2YmR2utle/f8WfdPV7vKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YE+ANhzk0COjhNU+4x/GUMufYh4HARrHq2Wz7hVavp9oevqFdTDhQTGPGsrvzXOADWKIJMfa+awaEqIGMcjAK1qeX/0oTTx/CbYadBe/4DN91bmfMenfVR3z/JPPLIKf0HWm0CPJMBod0TYbnDGCqVDBmtEUD+r80+rvnvPIc07nyBhRFD0QgEsk4mC7gX85yWAJ7cXuZUYkhZ/uPTMJUswKMIRxhp6fphvvkzSOaJYAQ7NLsQJSzZOSXum8ZWbAOTunlismpOsRjLGDDehEbyhh1YhL5wkK12k+7sRRF7k/W8AO7VRbRVS41JdAfAXJrA2tGpXdEhfnBgJX8dhsx17+XAio/4wzAqRfM5GTpSQDbj6NMhkgXLKfTCRrvfMCzAslMeSQej/BQmKmkMyS1RBCP0+lfvV+NHvDEWS/tRYULLahJiZBMiPwJlOZT/5c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:18.6085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ef98ef-4ab7-4427-6344-08defa47776e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9019
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

Support obtaining ras capabilities.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  7 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 25 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 242c48e85912f..ad58d422204e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -47,6 +47,7 @@
 #include "amd_pcie.h"
 #include "amdgpu_userq.h"
 #include "amdgpu_video_codecs.h"
+#include "amdgpu_ras_mgr.h"
 
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
 {
@@ -1290,7 +1291,11 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 
 		if (!ras)
 			return -EINVAL;
-		ras_mask = (uint64_t)adev->ras_enabled << 32 | ras->features;
+
+		if (amdgpu_uniras_enabled(adev))
+			ras_mask = amdgpu_uniras_get_ras_caps(adev);
+		else
+			ras_mask = (uint64_t)adev->ras_enabled << 32 | ras->features;
 
 		return copy_to_user(out, &ras_mask,
 				min_t(u64, size, sizeof(ras_mask))) ?
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 378921a53b9a7..1cd12eeee12b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1820,8 +1820,12 @@ static ssize_t amdgpu_ras_sysfs_features_read(struct device *dev,
 {
 	struct amdgpu_ras *con =
 		container_of(attr, struct amdgpu_ras, features_attr);
+	u64 ras_features;
 
-	return sysfs_emit(buf, "feature mask: 0x%x\n", con->features);
+	ras_features = amdgpu_uniras_enabled(con->adev) ?
+		amdgpu_uniras_get_ras_caps(con->adev) : con->features;
+
+	return sysfs_emit(buf, "feature mask: 0x%llx\n", ras_features);
 }
 
 static bool amdgpu_ras_get_version_info(struct amdgpu_device *adev, u32 *major,
@@ -5003,3 +5007,22 @@ int amdgpu_ras_resume_after_reset(struct amdgpu_device *adev)
 
 	return amdgpu_cper_deferred_init(adev);
 }
+
+uint64_t amdgpu_uniras_get_ras_caps(struct amdgpu_device *adev)
+{
+	struct ras_cmd_get_ras_cap_req req = {0};
+	struct ras_cmd_get_ras_cap_rsp rsp = {0};
+	union ras_feature feature = {0};
+
+	if (amdgpu_ras_mgr_handle_ras_cmd(adev, RAS_CMD__GET_RAS_CAP,
+			&req, sizeof(struct ras_cmd_get_ras_cap_req),
+			&rsp, sizeof(struct ras_cmd_get_ras_cap_rsp)))
+		return 0;
+
+	feature.block_mask = rsp.ras_block_mask;
+	feature.en = adev->ras_enabled;
+	if (adev->smuio.funcs && adev->smuio.funcs->get_socket_id)
+		feature.tag = adev->smuio.funcs->get_socket_id(adev);
+
+	return feature.value;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index c53f911d5729f..63ea7d39b84e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -981,4 +981,5 @@ void amdgpu_ras_pre_reset(struct amdgpu_device *adev,
 void amdgpu_ras_post_reset(struct amdgpu_device *adev,
 					  struct list_head *device_list);
 int amdgpu_ras_resume_after_reset(struct amdgpu_device *adev);
+uint64_t amdgpu_uniras_get_ras_caps(struct amdgpu_device *adev);
 #endif
-- 
2.55.0

