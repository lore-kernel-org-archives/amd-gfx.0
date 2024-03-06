Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3313DC5475B
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Mar 2024 10:27:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACAB7112BA1;
	Wed,  6 Mar 2024 10:27:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="znt3aKAx";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BB88112BA0
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Mar 2024 10:27:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDgw80U5LRRdskgbEcEwW8//OqLzqs5aAfVWaahnBYuaDnWRAaWKUBQXu9kY4FGbVy3RUQ3BFJreFIoonfOndUSr80xa6KVTmD7rNKSFZlgnqXzALCU8BlTg+rRt9na/j/PFBXHV2rFJ3uyIGvNC1OAjZAk3fnIX0aH4cdBr9KE1QfNrKtO9/IauaVH/2HXQfk7QD7suBpgqyUBIhLk38E5VT1f4G8GGW/bvJVg8ocnDPaHRlP1n8TerF3Jec28aOlT7y+tMaw3xvTwC9LD446B81oxp2oLSF87Z6fUAKUO7VWQl0FP5ycVVzC9BPF6zfRHNX9bsoOhvE3mF1FB8FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CafotgK122Y7jl66FaHO6F2VPIlto8CFvGU4lb4Q8o=;
 b=XAVKqVK+F95P3fDr4F7FaQ199lNNzA77iAy+D86XwSYoIaaJdVhgXF8A1Tdn31y497VSTaXXXPO21zoNZQENF2OEeNhCI3fRbw0hRoBDAc8JTKi0DaEv7Ca5ooXwSjQePCMeAISirjHkQVFmr4kURGYS49Hi0h6RO1S4qMO530DA8O49NqmON9cagUcmOScyvf+UHT091uDu+JRUXiOG20nALdXneLEsmqXBc6QIfUY3Uv+pWHIkMovAmiSKGHBDMAWC1Uqvh7eOasVn+tmypsNn5xxiZMMNW6HLVc+tgTR/ijd6pt0MbKI3DkRFuWkdeAVCGcGj9vH0TjROgHhzMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CafotgK122Y7jl66FaHO6F2VPIlto8CFvGU4lb4Q8o=;
 b=znt3aKAxf9bDHu1DrChIX5d7jKrRUjwmmKvoPnNq7v9BspHWASQ6XrUFm1i4hN/b/v5PsqR41G5ewW5DjH0oiUiP9sxOEMeAkymcUVYp4Bw0TvaE81nonLdrup3APj+05nRL8WjmEu7+aMbQognCaj5qlkOQ4Nx964waK4Fxj08=
Received: from CY5PR18CA0059.namprd18.prod.outlook.com (2603:10b6:930:13::22)
 by BL3PR12MB6569.namprd12.prod.outlook.com (2603:10b6:208:38c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Wed, 6 Mar
 2024 10:27:05 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:13:cafe::26) by CY5PR18CA0059.outlook.office365.com
 (2603:10b6:930:13::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Wed, 6 Mar 2024 10:27:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 10:27:03 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 04:26:43 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, Ma Jun <Jun.Ma2@amd.com>, Yin Zhenguo
 <zhenguo.yin@amd.com>
Subject: [PATCH] drm/amdgpu/pm: Fix NULL pointer dereference when set/get
 power limit
Date: Wed, 6 Mar 2024 18:26:15 +0800
Message-ID: <20240306102615.2117462-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|BL3PR12MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e1a8f29-064d-43c7-4908-08dc3dc7f72a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yacdNyUk61D34kdhAvVP+gTE/EOLxrb5no0kTBMJQAkpOjSe0wZomEy2t71B6XOFtZE7i63hxn/VNieR5ftO6AFC187VJMy44qK053Ov+iA04tU1vn+GNdgKZ5OBLGcTCnyBun6jfHy5W3GlhmPeIpUMJWLhUFuQxyq2Eli6xd0V4435sUxnYCs+ox+eHSslWsVIqE6373B5PQYA6JBAkbaGXH6Sr3mDHvBsyT6ozu5UfWKeCdYk0lyKwt+G2aBat6fxKCWvZMBrFJ49DaEjZjX9hECLtbKv/S31n8qkXtUBXCS6i9Wnm/pSydLXfDdWVSrlVGwxtqr1ymuvfEBNWp+WU5eO9SSuv9pmjN6cwyyccmcDknW4gD/pCRzi4RNBsgm/0LuK2QHpIypQIpHeLkiLKRzSgpsBI/Tv2Bg3p3zL0Qp4a11aPcsIMYct+Y683vDGPwhFbxfM7cfmMydmNNO5Ah42cz8P8x2NYMjeqtTZ2COTxWjq7j+6FRBkROw2WA7qkR46UC+lyqa0zVPq4HjjHaTrWiAGkadrYXgQYrG02L17sHKRCThbE1Xd8y1piFX9V2Uu64/e9bSoi28VlM3GJ8cUsN0c1wuRgO8hRUOJZDRFrOg/LTA6lr9uZaw7W80rrhei2Rrkhiw3B7FpGWsbUl40tsJrMC9VrxWL52ZkNqWj12rdImIXLqGcmXQvABrPWD03lfPuSKnRY78ZbcEHdXf7CKg0UTyQyaUdg4lOm6q6uVnE7JHC1m6zTkv+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 10:27:03.3360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1a8f29-064d-43c7-4908-08dc3dc7f72a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569
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

Because powerplay_table initialization is skipped under
sriov case, We set default lower and upper OD value to
avoid NULL pointer issue.

Fixes: 7968e9748fbb ("drm/amdgpu/pm: Fix the power1_min_cap value")
Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Reported-by: Yin Zhenguo <zhenguo.yin@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c    | 15 ++++++++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c  | 16 ++++++++++------
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c  | 15 ++++++++++-----
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 15 ++++++++++-----
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 15 ++++++++++-----
 5 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 1d96eb274d72..42c5e6b103e8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1303,12 +1303,17 @@ static int arcturus_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (smu->od_enabled)
-		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
-	else
-		od_percent_upper = 0;
+	if (powerplay_table) {
+		if (smu->od_enabled)
+			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+		else
+			od_percent_upper = 0;
 
-	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+	} else {
+		od_percent_upper = 0;
+		od_percent_lower = 10;
+	}
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
 							od_percent_upper, od_percent_lower, power_limit);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index ed189a3878eb..6cc2e2d27a0d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2356,13 +2356,17 @@ static int navi10_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (smu->od_enabled &&
-		    navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT))
-		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
-	else
-		od_percent_upper = 0;
+	if (powerplay_table) {
+		if (smu->od_enabled && navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT))
+			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+		else
+			od_percent_upper = 0;
 
-	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+	} else {
+		od_percent_upper = 0;
+		od_percent_lower = 10;
+	}
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
 					od_percent_upper, od_percent_lower, power_limit);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index e2ad2b972ab0..5daeac2e6239 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -640,12 +640,17 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (smu->od_enabled)
-		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
-	else
-		od_percent_upper = 0;
+	if (powerplay_table) {
+		if (smu->od_enabled)
+			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
+		else
+			od_percent_upper = 0;
 
-	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
+		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
+	} else {
+		od_percent_upper = 0;
+		od_percent_lower = 10;
+	}
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
 					od_percent_upper, od_percent_lower, power_limit);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 215f7c91ca73..271151c518e1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2369,12 +2369,17 @@ static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (smu->od_enabled)
-		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
-	else
-		od_percent_upper = 0;
+	if (powerplay_table) {
+		if (smu->od_enabled)
+			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
+		else
+			od_percent_upper = 0;
 
-	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
+		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
+	} else {
+		od_percent_upper = 0;
+		od_percent_lower = 10;
+	}
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
 					od_percent_upper, od_percent_lower, power_limit);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 3dc7b60cb075..533a3c1ba41e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2333,12 +2333,17 @@ static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (smu->od_enabled)
-		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
-	else
-		od_percent_upper = 0;
+	if (powerplay_table) {
+		if (smu->od_enabled)
+			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
+		else
+			od_percent_upper = 0;
 
-	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
+		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
+	} else {
+		od_percent_upper = 0;
+		od_percent_lower = 10;
+	}
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
 					od_percent_upper, od_percent_lower, power_limit);
-- 
2.34.1

