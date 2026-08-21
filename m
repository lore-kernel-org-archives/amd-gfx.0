Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97EE0C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:16:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2181010F38B;
	Fri, 21 Aug 2026 16:16:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vq7w0P2z";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012064.outbound.protection.outlook.com
 [40.107.200.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF41710F38B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:16:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qroQqnBIA6cAvVlBIEQm5PnO/kDp+LGuZUU4XZGVFpHmcu3Rvo4FV2JkyaM77ElyyXjtuYNU6lwvmQKyC0K/UC5NlXIDU6/c9W2cjNGv6Zzb1CtQsFmACm3+SYki9RyoalcxPbfYCeYvyJf8Ia1JEGR59rGmPSJ2D1mHOAyHoKNbv1+QHqLrfReK7wl0+bavMwQbjfp3zeKje/WbWBDzgo39Tmt/0WC6Y3bV/OIOabgntvviud05/sOl6vBYGLMNbeoWbu4hbZBVXPbUscHRlHosx3ycSH+cIt6Peh4jomezQ4nk+h2wRBhXbAUVcvRhUqwPc8Vy/Rjnk6xjuDbfUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgV8t/hKX7JNzp8P4ZHWi5WQVvy2pZjgIHsIisRi/6g=;
 b=Y1ZMVEnZEt1859FhnSTQR3VuZxJuy+mS5kC6DeBjnnalnx6mnpXYxv7IfgWxBI+ejrXztQHx39+lS6k7CAcGQAUsIoJkWOSuaBjzH5/bQJRoAQmm7TxIZuZW3gcHLX/MGHA+QamXgt6MLtjijG8pQfvc0rvN4/sQuzbHbhgxuNas5C5cZHVyZOt5ww6hg41bvnwCcp1VI4X1Ku1MPqxZ6wwC67BNMVN47MLL0JreqQzDzbmE/vdgd2OF33UMgFdnnnGuRAG+nu1aEXZMZlPVEguxRoury1m3u8c230XqTXV3Di63iFfFRotqQqTv8Yz0lE7kZJJz8poivnq//6oetg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgV8t/hKX7JNzp8P4ZHWi5WQVvy2pZjgIHsIisRi/6g=;
 b=vq7w0P2zqzjQGHphVTyk84liDWKwjh06pMmd5RyDaMjeHC9+jS9aGhtARNizXfxWzvy+7BcN3pZDCNZN9Zm7MKFce5EV3ZdUsqqzBNoOcTJyyUHJZ7iZie1ZTbV6RUYwnyrXSlZHneD0YjoMg8y6wFvY2CLVqcpoSDRbRSW0k/Y=
Received: from MN0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:208:52f::23)
 by BL3PR12MB6546.namprd12.prod.outlook.com (2603:10b6:208:38d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:16:01 +0000
Received: from BN5PEPF0004698E.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::6f) by MN0PR03CA0026.outlook.office365.com
 (2603:10b6:208:52f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:16:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN5PEPF0004698E.mail.protection.outlook.com (10.167.245.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:16:00 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:15:52 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:15:52 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:15:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 1/7] drm/amdgpu: init NPS supported modes for GC 12.1.0
Date: Fri, 21 Aug 2026 12:15:40 -0400
Message-ID: <20260821161546.754333-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698E:EE_|BL3PR12MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: af6dd1d1-e4c9-4d44-a7cc-08deff9f7e2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: MHRVyBg++7H5y5MrGpOIhSF6Oy10sYIN8HK1z3HCq9LSALKJ7DucL8EtmYIVhXfk1NzjGJ870zgrUliMq80JWr/NcdTgRvKlzz8G8uJy7h6YiGo5nBOHppRVgmM4YHDgEvVLivt7BWUwdgUDbJtASGoTKcIOhbKmvjrCyDLKE7iRD3oBVfB/AcMQlRxwz7yvYJjnPfQl4GUv/eypdR/6KI2ckaDr8OMlKjDAmorM9ud2EpNBcTVZXIs1eVZjsQTJqzshl7rROkEnN9KpBIwj5i2h2RuyUjRPSZqeS1Z3HFeYXV4eioeulIwxrKjx1d14vnzhWYDyXtohFByRpKjccSwgvwGzUidgxIPXK631/tTryEoW4MNp5HhzCUAhwcp+NgFcIktfavsR9fwyGA9A1BSSYNB63vpL2r2TN7NTc+BCJZxm9Ww9Stdig/IDbbgYtFJ9QAFLyzpgIHkwLCg31yrvYIU1+ysRN34b/HOgdQliYL12V/PhUWckHz0P8IkLaDoG1+5DKcdvYyS71/HKIQ8FmbGutwXDm9Gj++J5IwvlxNN/VBC7Jjaw7R2uvdOGpNSUWRWryIwCxcHmlBN2UxZmKBbteG+q0RhBCZvoARbQSFh6QLWdxn1Dx1/vf4p1ogavun5LwmLlfb4NRkshglEPp2daP+jL2ecZXE9/g7BBiFJE7JzOhhQpyhg95xrm4uG/sYD01A7M49sUqse5Jg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 736K3a2vNxNk0oV5mGu4ZZ2m4UasQUgdjr4WUyAM7bhzXscFOsAy9sdbvAy0sn89qGiO7BQQFqegNgVJJAW0kBEC9d5huEkK9fXEWsZgXPGXSgmPmBGzkGYnePNgDktjzNN8Uh5WfATqvrja7K3LVOyp2RQlOsR2M13MnKGoS/Ad71YyQSF3JImKwqKZ3npHDi1vUFMxD27NrPf7p86z/ykMsbdSdEnTacNWBNdwg41miriW3iTkVurPrMnlG2UYqxBxvs1nFFSBtR7rHLvXXqDN0yEuYh0hfPbZ5t3hdLURVtUfHHaJMe2uZjo0G2OSTr4GYixoUxviquMjoNTTe7OzSKicXBAXiwS0FhrV6DTlSEfF81YdsThPTafiRCBbpMIFw7NuIZkd2lMf39w01A/42h7un3fYZu6itCyTKkaKmcD2+FBz+Vd4lnl2elUL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:16:00.2895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af6dd1d1-e4c9-4d44-a7cc-08deff9f7e2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF0004698E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6546
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

From: Le Ma <le.ma@amd.com>

Add nps supported modes init for gc 12.1.0

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c |  3 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 33 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h |  1 +
 3 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index e69cae39b5f75..27f9f6a4f3fa4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -945,6 +945,9 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0))
+		gmc_v12_1_init_nps_details(adev);
+
 	/*
 	 * number of VMs
 	 * VMID 0 is reserved for System
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index f9887cec9a6c3..a8e32ee93735d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -733,3 +733,36 @@ void gmc_v12_1_init_vram_info(struct amdgpu_device *adev)
 	adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM4;
 	adev->gmc.vram_width = 384 * 64;
 }
+
+void gmc_v12_1_init_nps_details(struct amdgpu_device *adev)
+{
+	enum amdgpu_memory_partition mode;
+	uint32_t supp_modes;
+	int i;
+
+	adev->gmc.supported_nps_modes = 0;
+
+	if (amdgpu_sriov_vf(adev) || (adev->flags & AMD_IS_APU))
+		return;
+
+	mode = amdgpu_gmc_get_memory_partition(adev, &supp_modes);
+
+	/* Mode detected by hardware and supported modes available */
+	if ((mode != UNKNOWN_MEMORY_PARTITION_MODE) && supp_modes) {
+		while ((i = ffs(supp_modes))) {
+			if (AMDGPU_ALL_NPS_MASK & BIT(i))
+				adev->gmc.supported_nps_modes |= BIT(i);
+			supp_modes &= supp_modes - 1;
+		}
+	} else {
+		switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+		case IP_VERSION(12, 1, 0):
+			adev->gmc.supported_nps_modes =
+				BIT(AMDGPU_NPS1_PARTITION_MODE) |
+				BIT(AMDGPU_NPS2_PARTITION_MODE);
+			break;
+		default:
+			break;
+		}
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h
index 2f08f4b8cd99e..22da84a1d5185 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h
@@ -27,4 +27,5 @@
 void gmc_v12_1_set_gmc_funcs(struct amdgpu_device *adev);
 void gmc_v12_1_set_irq_funcs(struct amdgpu_device *adev);
 void gmc_v12_1_init_vram_info(struct amdgpu_device *adev);
+void gmc_v12_1_init_nps_details(struct amdgpu_device *adev);
 #endif
-- 
2.55.0

