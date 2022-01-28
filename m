Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A16C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 07:05:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76F3C10FA88;
	Fri, 28 Jan 2022 07:05:44 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2061.outbound.protection.outlook.com [40.107.95.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A859710FA8E
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 07:05:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8ZwZISz9VC5W8cSYNCyORxi8PKXUoJ/SnPX/0jpCV+uh2d8Ze7IKfTpkVscejBHyXVBiubVtE/3Ei73HNS1yP2XKbuFVq/vqYQt+Ts8ZWpDTeYm0cSujRnVh89bQ8jQxGSC4JFtirTApNeaMAbhZbmx7pKJLRailwYbVHvDZiUJGFJCsRQQyd5AiBvkGK2uQ3HJLWzRG//vd5ZMRPeMHJunISg9ZgP2IQTduWciVYDzkr2xEWKikr9ApqsJ1/k3V4C9zGQuGDxY3V2bQQItZSJT5+b5iUkIIgWKIxlLd8TgtdPWEwtoVfV78LV5PjLoVHXsuQcREJ4z7zxlKXIQLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1vTfMDu/EPxNfGRmOCUcp7gkpjqaJjrLOWUIc3oBnA=;
 b=nIA9VPOuIwMyQKuPR4eDsDbNXHp8qcQTCdUHSQnTuzuGPzq8FDV/KpFZRkb4zIxyOQE2wsu2Iceo2YJYOvEy9imYMvpUlhMHB9DcxIosx6ItgendDIbThnvQRwoOtRKKq0QID0pY88H2SiQ7oyUtKj/fN0472T8UYWnqFYC/CY/KOCIkcDCqpqo60a7fResJHjX+GcbqyiNbiZiMA7uhGfUZmdsx+ZOrWF7NZmWh7VvhRMdbPlXqHnaWW/E5CKw7HHYU2PeGA4c7SR/xE26wfF25qaynjrpwz3XdqJUg2Re9zC5aI+wJLzpkH4jZb0RZP/y52hSzVnkz06w6cXIl5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1vTfMDu/EPxNfGRmOCUcp7gkpjqaJjrLOWUIc3oBnA=;
 b=GiwWtFetrV6j/XtjJrd8kKE4IZWYdXhwNBmhjzCat5oFNfFuBhS/Mj2bj6Vz0P1rY9KkaGoktQ29QjppickZ4p4zm3xDt7uMkFTR6Qi4GV1FYndelI9ML8xTi/RcmifpMBmZsThKGFjJWBdVWc0KeDBcC3yF2YM2ICySzsB554k=
Received: from MW4PR03CA0182.namprd03.prod.outlook.com (2603:10b6:303:b8::7)
 by DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.15; Fri, 28 Jan 2022 07:05:37 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::12) by MW4PR03CA0182.outlook.office365.com
 (2603:10b6:303:b8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 07:05:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 07:05:36 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 01:05:33 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 5/7] drm/amd/pm: drop the cache for enabled ppfeatures
Date: Fri, 28 Jan 2022 15:04:53 +0800
Message-ID: <20220128070455.202014-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220128070455.202014-1-evan.quan@amd.com>
References: <20220128070455.202014-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca86dda8-285a-476d-77fa-08d9e22c95a7
X-MS-TrafficTypeDiagnostic: DM8PR12MB5399:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB5399AA2E4373BF6238234862E4229@DM8PR12MB5399.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T+O87gAXqt5TyIr5gdz48IWm+qaq0Uf+9kUQpFPgKzdnqUSL2Qa1wns6tGpnfiU5uPWpVe/v04oWAoU9OThzTOiEPf2oEzr276fHXjsHLyBTSJDu98BWcjVkhO1r8sznuqFaDAtSax18XacfgLsjFRU1pQTddTqZMdTDNKpxxDD0CCPQTP6PWftL7NYAsjv2/D57u2hAm67Y8skVG94U3GLUXhLzg7WZitKnLo3LqXyF2HZKAPrMTLAzJq4x+su12/wJS5aqEO2RG8WMABu1vqBy2bQw9uTxpDEOgb2+nTU4Z3j5hOqVH/9NVO3Ljz9uPTFluz7/DU/EaKhumedSqbStX6Wkstkw/2MqVMQrKepCcvZkw/BYslRoYpk2V46l8QtCsch6fhaY/mUz6xwTMWmTti87NFGEEgQp9X1dx0IMD/AMqbnyU3+9VESMPO/J1METtoslUQNDGFDwybzGS271fz/9UekEvmWDleyX1dlwdbNK+n+2o2QD4mPikTjV/mo4uSMNjb1F/M1srgU2L0HjW2fkbxCex8WzHpqi7ZtnAMfT1VvR1pMlouhEoVPYUmslhvlqi3nUfCTF8IToDvI+OIeClcxiT52/2LjSxfd/YMn/mSpRjpCtM12Iezrnt4QXDMtaERgsbsR5CtrjrKxsO4E7t0NQI/FywW3BU8Bz/kiTmvrnOGzgXLF8QS8OLBnj0v71s4ES3WjJ76m4Pg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(508600001)(1076003)(426003)(2906002)(82310400004)(86362001)(16526019)(26005)(336012)(2616005)(36860700001)(83380400001)(186003)(47076005)(36756003)(70586007)(6916009)(7696005)(356005)(40460700003)(30864003)(54906003)(8936002)(5660300002)(4326008)(44832011)(6666004)(8676002)(81166007)(316002)(70206006)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 07:05:36.5136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca86dda8-285a-476d-77fa-08d9e22c95a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5399
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The following scenarios make the driver cache for enabled ppfeatures
outdated and invalid:
  - Other tools interact with PMFW to change the enabled ppfeatures.
  - PMFW may enable/disable some features behind driver's back. E.g.
    for sienna_cichild, on gfxoff entering, PMFW will disable gfx
    related DPM features. All those are performed without driver's
    notice.
Also considering driver does not actually interact with PMFW such
frequently, the benefit brought by such cache is very limited.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I20ed58ab216e930c7a5d223be1eb99146889f2b3
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  1 -
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 -
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 23 +---------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 16 +------
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 23 +---------
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 16 +------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 46 +++++--------------
 7 files changed, 17 insertions(+), 109 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 803068cb5079..59be1c822b2c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -950,7 +950,6 @@ static int smu_sw_init(void *handle)
 	smu->pool_size = adev->pm.smu_prv_buffer_size;
 	smu->smu_feature.feature_num = SMU_FEATURE_MAX;
 	bitmap_zero(smu->smu_feature.supported, SMU_FEATURE_MAX);
-	bitmap_zero(smu->smu_feature.enabled, SMU_FEATURE_MAX);
 	bitmap_zero(smu->smu_feature.allowed, SMU_FEATURE_MAX);
 
 	mutex_init(&smu->message_lock);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 8cd1c3bb595a..721b4080d3e6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -390,7 +390,6 @@ struct smu_feature
 	uint32_t feature_num;
 	DECLARE_BITMAP(supported, SMU_FEATURE_MAX);
 	DECLARE_BITMAP(allowed, SMU_FEATURE_MAX);
-	DECLARE_BITMAP(enabled, SMU_FEATURE_MAX);
 };
 
 struct smu_clocks {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index d36b64371492..d71155a66f97 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -798,27 +798,8 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
 int smu_v11_0_system_features_control(struct smu_context *smu,
 					     bool en)
 {
-	struct smu_feature *feature = &smu->smu_feature;
-	uint64_t feature_mask;
-	int ret = 0;
-
-	ret = smu_cmn_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
-				     SMU_MSG_DisableAllSmuFeatures), NULL);
-	if (ret)
-		return ret;
-
-	bitmap_zero(feature->enabled, feature->feature_num);
-
-	if (en) {
-		ret = smu_cmn_get_enabled_mask(smu, &feature_mask);
-		if (ret)
-			return ret;
-
-		bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
-			    feature->feature_num);
-	}
-
-	return ret;
+	return smu_cmn_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
+					  SMU_MSG_DisableAllSmuFeatures), NULL);
 }
 
 int smu_v11_0_notify_display_change(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 478151e72889..96a5b31f708d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1947,27 +1947,13 @@ static int vangogh_get_dpm_clock_table(struct smu_context *smu, struct dpm_clock
 static int vangogh_system_features_control(struct smu_context *smu, bool en)
 {
 	struct amdgpu_device *adev = smu->adev;
-	struct smu_feature *feature = &smu->smu_feature;
-	uint64_t feature_mask;
 	int ret = 0;
 
 	if (adev->pm.fw_version >= 0x43f1700 && !en)
 		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_RlcPowerNotify,
 						      RLC_STATUS_OFF, NULL);
 
-	bitmap_zero(feature->enabled, feature->feature_num);
-
-	if (!en)
-		return ret;
-
-	ret = smu_cmn_get_enabled_mask(smu, &feature_mask);
-	if (ret)
-		return ret;
-
-	bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
-		    feature->feature_num);
-
-	return 0;
+	return ret;
 }
 
 static int vangogh_post_smu_init(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 92b5c1108a2e..f0ab1dc3ca59 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -764,27 +764,8 @@ int smu_v13_0_gfx_off_control(struct smu_context *smu, bool enable)
 int smu_v13_0_system_features_control(struct smu_context *smu,
 				      bool en)
 {
-	struct smu_feature *feature = &smu->smu_feature;
-	uint64_t feature_mask;
-	int ret = 0;
-
-	ret = smu_cmn_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
-					 SMU_MSG_DisableAllSmuFeatures), NULL);
-	if (ret)
-		return ret;
-
-	bitmap_zero(feature->enabled, feature->feature_num);
-
-	if (en) {
-		ret = smu_cmn_get_enabled_mask(smu, &feature_mask);
-		if (ret)
-			return ret;
-
-		bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
-			    feature->feature_num);
-	}
-
-	return ret;
+	return smu_cmn_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
+					  SMU_MSG_DisableAllSmuFeatures), NULL);
 }
 
 int smu_v13_0_notify_display_change(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index d89e8a03651b..e90387a84cbb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -195,27 +195,13 @@ static int yellow_carp_fini_smc_tables(struct smu_context *smu)
 
 static int yellow_carp_system_features_control(struct smu_context *smu, bool en)
 {
-	struct smu_feature *feature = &smu->smu_feature;
 	struct amdgpu_device *adev = smu->adev;
-	uint64_t feature_mask;
 	int ret = 0;
 
 	if (!en && !adev->in_s0ix)
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
 
-	bitmap_zero(feature->enabled, feature->feature_num);
-
-	if (!en)
-		return ret;
-
-	ret = smu_cmn_get_enabled_mask(smu, &feature_mask);
-	if (ret)
-		return ret;
-
-	bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
-		    feature->feature_num);
-
-	return 0;
+	return ret;
 }
 
 static int yellow_carp_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index aae08ce62b80..3d263b27b6c2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -496,8 +496,8 @@ int smu_cmn_feature_is_supported(struct smu_context *smu,
 int smu_cmn_feature_is_enabled(struct smu_context *smu,
 			       enum smu_feature_mask mask)
 {
-	struct smu_feature *feature = &smu->smu_feature;
 	struct amdgpu_device *adev = smu->adev;
+	uint64_t enabled_features;
 	int feature_id;
 
 	if (smu->is_apu && adev->family < AMDGPU_FAMILY_VGH)
@@ -509,9 +509,12 @@ int smu_cmn_feature_is_enabled(struct smu_context *smu,
 	if (feature_id < 0)
 		return 0;
 
-	WARN_ON(feature_id > feature->feature_num);
+	if (smu_cmn_get_enabled_mask(smu, &enabled_features)) {
+		dev_err(adev->dev, "Failed to retrieve enabled ppfeatures!\n");
+		return 0;
+	}
 
-	return test_bit(feature_id, feature->enabled);
+	return test_bit(feature_id, (unsigned long *)&enabled_features);
 }
 
 bool smu_cmn_clk_dpm_is_enabled(struct smu_context *smu,
@@ -544,7 +547,6 @@ bool smu_cmn_clk_dpm_is_enabled(struct smu_context *smu,
 int smu_cmn_get_enabled_mask(struct smu_context *smu,
 			     uint64_t *feature_mask)
 {
-	struct smu_feature *feature = &smu->smu_feature;
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t *feature_mask_high;
 	uint32_t *feature_mask_low;
@@ -553,13 +555,6 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
 	if (!feature_mask)
 		return -EINVAL;
 
-	if (!bitmap_empty(feature->enabled, feature->feature_num)) {
-		bitmap_copy((unsigned long *)feature_mask,
-			     feature->enabled,
-			     feature->feature_num);
-		return 0;
-	}
-
 	feature_mask_low = &((uint32_t *)feature_mask)[0];
 	feature_mask_high = &((uint32_t *)feature_mask)[1];
 
@@ -616,7 +611,6 @@ int smu_cmn_feature_update_enable_state(struct smu_context *smu,
 					uint64_t feature_mask,
 					bool enabled)
 {
-	struct smu_feature *feature = &smu->smu_feature;
 	int ret = 0;
 
 	if (enabled) {
@@ -630,8 +624,6 @@ int smu_cmn_feature_update_enable_state(struct smu_context *smu,
 						  SMU_MSG_EnableSmuFeaturesHigh,
 						  upper_32_bits(feature_mask),
 						  NULL);
-		if (ret)
-			return ret;
 	} else {
 		ret = smu_cmn_send_smc_msg_with_param(smu,
 						  SMU_MSG_DisableSmuFeaturesLow,
@@ -643,17 +635,8 @@ int smu_cmn_feature_update_enable_state(struct smu_context *smu,
 						  SMU_MSG_DisableSmuFeaturesHigh,
 						  upper_32_bits(feature_mask),
 						  NULL);
-		if (ret)
-			return ret;
 	}
 
-	if (enabled)
-		bitmap_or(feature->enabled, feature->enabled,
-				(unsigned long *)(&feature_mask), SMU_FEATURE_MAX);
-	else
-		bitmap_andnot(feature->enabled, feature->enabled,
-				(unsigned long *)(&feature_mask), SMU_FEATURE_MAX);
-
 	return ret;
 }
 
@@ -661,7 +644,6 @@ int smu_cmn_feature_set_enabled(struct smu_context *smu,
 				enum smu_feature_mask mask,
 				bool enable)
 {
-	struct smu_feature *feature = &smu->smu_feature;
 	int feature_id;
 
 	feature_id = smu_cmn_to_asic_specific_index(smu,
@@ -670,8 +652,6 @@ int smu_cmn_feature_set_enabled(struct smu_context *smu,
 	if (feature_id < 0)
 		return -EINVAL;
 
-	WARN_ON(feature_id > feature->feature_num);
-
 	return smu_cmn_feature_update_enable_state(smu,
 					       1ULL << feature_id,
 					       enable);
@@ -793,7 +773,6 @@ int smu_cmn_disable_all_features_with_exception(struct smu_context *smu,
 						bool no_hw_disablement,
 						enum smu_feature_mask mask)
 {
-	struct smu_feature *feature = &smu->smu_feature;
 	uint64_t features_to_disable = U64_MAX;
 	int skipped_feature_id;
 
@@ -807,15 +786,12 @@ int smu_cmn_disable_all_features_with_exception(struct smu_context *smu,
 		features_to_disable &= ~(1ULL << skipped_feature_id);
 	}
 
-	if (no_hw_disablement) {
-		bitmap_andnot(feature->enabled, feature->enabled,
-				(unsigned long *)(&features_to_disable), SMU_FEATURE_MAX);
+	if (no_hw_disablement)
 		return 0;
-	} else {
-		return smu_cmn_feature_update_enable_state(smu,
-							   features_to_disable,
-							   0);
-	}
+
+	return smu_cmn_feature_update_enable_state(smu,
+						   features_to_disable,
+						   0);
 }
 
 int smu_cmn_get_smc_version(struct smu_context *smu,
-- 
2.29.0

