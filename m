Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744061093177
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 06:04:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F19DC10EA7E;
	Fri, 20 Mar 2026 06:04:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hw7vn/AW";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E6DD10E9B9
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 06:04:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKYdh6MSvNWWsMXU/044rw0ICD4LhTHzvm4LFExSAkijrILZ3TXR5F8r0dwjUBvrcak6PWRlW8LHYZqNzEtn98WCkyF5N+ijt2J7A4AdhIM54EGUoAXiW35qaQZ5ZuoQQkNn+u12fc6Ho6yuyhRqdohiSLrGojdWSy57fJdwLLPNhfo5aGkQW9LY/+E+9vjHMkRpoTT37TFQa3P9FA5Euy3F1CxXDAW9wrd/Aeok068dHhEvz7e3BEeDoq066Tvjk7k8Wc9EEG3pKUAhI3SF2609AWDH/pfdkR5T45VNp4kAuLN8RopckQd6M2QmqyZbsBugPPJoAk/YYIKgjGb/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+V7Yyx87t/qGS22qOwhSU90JB+cGPrpciuo8v7Ymv0=;
 b=tosDPqiYKeyXZd6CI2KOFkLqyxvoTeLHraO2CNvYbOO+LRZ+unQ6p2mvKalFFId2M7GsNUT8jtCRLixeW1nISF9yXotaDF3ros9imY3yJkE2EPyuxf7lXUcZboWau+xx5cenvPOy6pygXRUVhO1kPc03+LnBw5kVywYrDVNNeVs0FBeVDv0J/tqSRmD+DPgoZHUORZpzVDF59MtPqxu3qXen27Dtb9ml0bFwqG9x06vUcAYETuaia8hKKkcJ0SdtNux/gZJxdlSqCEhqj3Q1XqX6aORIfvNqsTLfz7Qy2rdlpC4+3dc9j+fNpALtMvsuYzhgNQouwNy9Wyo6zGcCew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+V7Yyx87t/qGS22qOwhSU90JB+cGPrpciuo8v7Ymv0=;
 b=hw7vn/AWfLet7Owm9ui9oEYdRgoZmH6V8EuzMWbdu7bRH7012ihJPVYEdYLeyTR2tkONou4ckM5uRy//1p2mEg1vVItkNpSFHDuBw++sXCDqeUHMXXpCTPN6T0s0il6Vpk6rDw/z9Te0cI5NhnUfNHjJ4iI/mj1Bkv3YRcXTTr4=
Received: from SJ0PR03CA0046.namprd03.prod.outlook.com (2603:10b6:a03:33e::21)
 by MN2PR12MB4125.namprd12.prod.outlook.com (2603:10b6:208:1d9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 06:04:30 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:a03:33e:cafe::e8) by SJ0PR03CA0046.outlook.office365.com
 (2603:10b6:a03:33e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Fri,
 20 Mar 2026 06:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 06:04:30 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 01:04:27 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 2/3] drm/amd/pm: Unify version check in SMUv12
Date: Fri, 20 Mar 2026 11:34:08 +0530
Message-ID: <20260320060409.616702-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260320060409.616702-1-lijo.lazar@amd.com>
References: <20260320060409.616702-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|MN2PR12MB4125:EE_
X-MS-Office365-Filtering-Correlation-Id: e7465180-2f0d-4c94-5211-08de86468cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Es3vM7Bfobkirg99cYhCTYg28XJjevfiutfghNEX1TtXftVmDR9U1KH0eM3WHtjU76u6ikOaY9FO7rh0Clv6BSjLiP6owDl37GC7O6fYMgKjvdg1IFQcHDDjBqvw9CaAKSKW0a7a1GCjr9cP1DGkvV4TueSjhEvxz0hLXWGQibdpyKoVGKhc3ZIulDW2Aa7gwixihpeKw9k9Rg+/gH5PSZPnk2PAKsFU4tGVJPYFBQpTWFVthdPnpJ1R0RvGf8dsgLLtfJq4R+UviA47YpP7t9vVfNfe1HGAX9236NwRmPDUe42rbXzD8VrCsU+3wl8otqO1ifI090lgjY0nPaMTYfc9PozpPNT/RvWgnD8Gj+VbJiZ1Iydz6pr+/ldpPMyHLBPX4kOXDmfF6pALDmeyx43X2Huc+qWyl33uHZEglLEIq2DG4mrLfxlTm3yZXOy4VNJJVYcEHqhwHeBtLB8GXtFADUj0pIslHsA21HMcqbYRsigFccL+me5+stZaI15/Eu2vimeLjiSM6HLHQgPclTluub5b4/dB4ZL3BO/OZK3IaFVK9MKjh2yq1TPB/LF5mOxwuJ5xGcNHfR1/vFpOzSscS8EyZ1FvFC0k+uEyvsE7czjjnxR9ScszEx+uRi1ovA8d4w5W0PSbmmb3pGlmpl9NLIsiV9mfcitcEtn//cY7/QXUXm8AQJ6pIB+sjCfb4WkLRLBEjecfVLH8K8b7/ts9BkPuRbAnzSqIRKIRVf6Tt5oiaU1OongbUFY8du5AroAbO7XCwzxdVuvd2Qx0Yg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ud/Zn6EQGCdmMLXxbnYDyVpmdQRJ8WuFtzFAzLG1fmwB6uQ+qRJ0RPzw8wAgs2maLaBWXHHPijbgXAC5r6iSu9fxMZbYqo0NEJsntY/a4DRCikQWWZuUe78qdHO+J7Cy+8uCyvjAVRvSblcb1mjROXIHmObdirv8S394y9+Tr89w5Cy3+zLlR7ueLTQEMoBkfs+bGecs/BfWYsuAGt+kk7BR2gokXkwavc/YO30m+bT8hXNgVuNKCv4ytFROykwdaZ/a6SaAxeFgHFzvMU7Wn3ecgdtMQEIJIJYjEA4+pcoVR7xWqiO6YT1V6BNXDK8l3cLMPLLgVPcoVdM/6vFf8/1HW2Ifza0QdFybrt4LUw2CdUNB6GwtOccz885F9/f+n0oZj0s1yMPKz/k4csaDjDdLKhbn26CZioC8Eu6QWc6HVIIjiE8MALfuHz5zA/8X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 06:04:30.0326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7465180-2f0d-4c94-5211-08de86468cd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4125
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

Use common helper function for firmware version check and logging in
SMUv12.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h  |  2 --
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c    | 36 -------------------
 3 files changed, 1 insertion(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h
index fd3937b08662..2346d9c6e162 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h
@@ -35,8 +35,6 @@
 
 int smu_v12_0_check_fw_status(struct smu_context *smu);
 
-int smu_v12_0_check_fw_version(struct smu_context *smu);
-
 int smu_v12_0_powergate_sdma(struct smu_context *smu, bool gate);
 
 int smu_v12_0_powergate_vcn(struct smu_context *smu, bool gate);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 31e21ff8859a..0349dba2503a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1457,7 +1457,7 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 	.get_power_profile_mode = renoir_get_power_profile_mode,
 	.read_sensor = renoir_read_sensor,
 	.check_fw_status = smu_v12_0_check_fw_status,
-	.check_fw_version = smu_v12_0_check_fw_version,
+	.check_fw_version = smu_cmn_check_fw_version,
 	.powergate_sdma = smu_v12_0_powergate_sdma,
 	.set_gfx_cgpg = smu_v12_0_set_gfx_cgpg,
 	.gfx_off_control = smu_v12_0_gfx_off_control,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
index ac5e44dff6c9..f09da4d14510 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
@@ -70,42 +70,6 @@ int smu_v12_0_check_fw_status(struct smu_context *smu)
 	return -EIO;
 }
 
-int smu_v12_0_check_fw_version(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-	uint32_t if_version = 0xff, smu_version = 0xff;
-	uint8_t smu_program, smu_major, smu_minor, smu_debug;
-	int ret = 0;
-
-	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
-	if (ret)
-		return ret;
-
-	smu_program = (smu_version >> 24) & 0xff;
-	smu_major = (smu_version >> 16) & 0xff;
-	smu_minor = (smu_version >> 8) & 0xff;
-	smu_debug = (smu_version >> 0) & 0xff;
-	if (smu->is_apu)
-		adev->pm.fw_version = smu_version;
-
-	/*
-	 * 1. if_version mismatch is not critical as our fw is designed
-	 * to be backward compatible.
-	 * 2. New fw usually brings some optimizations. But that's visible
-	 * only on the paired driver.
-	 * Considering above, we just leave user a verbal message instead
-	 * of halt driver loading.
-	 */
-	if (if_version != smu->smc_driver_if_version) {
-		dev_info(smu->adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
-			"smu fw program = %d, smu fw version = 0x%08x (%d.%d.%d)\n",
-			smu->smc_driver_if_version, if_version,
-			smu_program, smu_version, smu_major, smu_minor, smu_debug);
-	}
-
-	return ret;
-}
-
 int smu_v12_0_powergate_sdma(struct smu_context *smu, bool gate)
 {
 	if (!smu->is_apu)
-- 
2.49.0

