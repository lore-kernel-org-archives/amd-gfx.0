Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7D8C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 07:45:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E452510E92D;
	Fri, 21 Jan 2022 07:45:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2340C10E92D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 07:45:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAvYHBvir7e/Sg4wAGJmk1DVWm7R2pEA2/2Drh1zVk2W0uM3zF+Vqi3osAblkOTpi9OG2sGaif30yilgg5GUWeqvd8xl10sIKSgQHbq0HRZGbVBANMQ06pwxU3CJkw7XNutO72/Qyu6sC6JnxlfYHc88uYRtDco+GZWYTzC+enTtISfTnqXWqnr2npKLI8M0iggCmqvXO9vWcuXEyqzOkCp5x5w6T2dNVdjKT+PFEj9IDI7MO5nvpZRC63KkdHAcUu5sVbGhYDMbS7L/HkJVzE+fvrxbb8CRSNR4npTmksogbYBmhHkdthqKVjef7LiSNoDi2xS75bcCzMB0e4IJYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8T5G/43xloqZc42i9oJ3xGk7tV7gYgctZ+61EPA3hE=;
 b=ako2l85O76OSAG4H/LK0Qg7Rfi+LQdFnV8QfyeGj8Blrduu6f8sgrFmmde85rzrgabE06+dooIRAPLqKb7p2eXjICQTUmYUbhsFEzhIL+A9jXUbM9eHpAOChwsvIT+8dh/WfHbclqiEgXpJUMCX0+sfVAm55WDxMnbtEGgf36cURN/Craeb5ubjBMgkqYKj6/Kje2TQOZKqN1vvFolDHVH45LYa0c3FdUE6EQbYdnz4RFyBQnzF3jbQhLOUa6D5ZJZqucirG59NxVQHecpzZcV1leFeDYSayulkZJcvY6XChFX5bThqVSfsLEvLmSSYYh7kxl40oIGaXuFzPmAe2+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8T5G/43xloqZc42i9oJ3xGk7tV7gYgctZ+61EPA3hE=;
 b=lYodajsrmMa0ZNMvKB8kDEpaT9VOlHVvLPf59atnJp1Dxy/Tp5iKuslb8LJipFwWy462wpzMJp7xYg0ux0LK2HHJ/LmVZ5zIWdtkxa6kBnb483JKJqdgI3d8/5AMGF7PGEwsrey0fRJTBjSf7N5zTISFxrf+b5fq2/m5vdZ4SsQ=
Received: from MWHPR12CA0060.namprd12.prod.outlook.com (2603:10b6:300:103::22)
 by CY4PR12MB1877.namprd12.prod.outlook.com (2603:10b6:903:11c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Fri, 21 Jan
 2022 07:45:14 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::34) by MWHPR12CA0060.outlook.office365.com
 (2603:10b6:300:103::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Fri, 21 Jan 2022 07:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Fri, 21 Jan 2022 07:45:14 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 21 Jan
 2022 01:45:11 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/7] drm/amd/pm: update the data type for retrieving enabled
 ppfeatures
Date: Fri, 21 Jan 2022 15:44:40 +0800
Message-ID: <20220121074443.639392-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220121074443.639392-1-evan.quan@amd.com>
References: <20220121074443.639392-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30e7695b-2bb3-4779-a533-08d9dcb1f617
X-MS-TrafficTypeDiagnostic: CY4PR12MB1877:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1877890AC76E432D725EDB74E45B9@CY4PR12MB1877.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DgjcSBCPDcHRNDNnNHGeJimT0dsEAOGzRtvba4GO3xXBr8tanTLCvUvTcOMYFB5IcZMzS1FLgIRmWdPBDpx9Aa4yUBLDYvxnneghL83A86NrkSvqWZge0kU7ZyICgZGAmjUXky7k5X22ysTtzajVUA+1lnhWFu5dTp5lFkeQNoeDd7eG/WWQ7HRbCoWuHwIG5+ZYW9uHma7sTweyq1BLoLtzspqqYVPkXeixeCW9BIvIMosXAlgvc5dEraRHk4I3KQR+AJQehar602zAe0RFzJcilm9K2fLztSha11r/wRHW40NU3WltVZYgouthAvX3AHM0bujv45zZ/0CcgeDQ1uAtG9y5C8+7d8nE717dvAhvqDCoNp1W4NlL9Q77kDBiLGi974qzCsE8GmOAh5NtUoZs52o0mHYyXuat1hAIknDIpJxjG7/946EHigkXQafS88ZE0AqRQ4AOR+lohnTqBmEoK7pZ4IPNut/G3pDwEdtbq7fLTHmHZKpL1osARWHMUb1g6ckMNo1xEh/H5ikCP8k34faAiDPIZmj9d/DjO8saKJpjguixp60Sre2IwwNEgmBfQCdSlVW5edLfFiN2Jm5kLTo2LoMEGzXL92g+i9leJVf/jGdSIMcy3x7sdcRwvG0qlThqPgZOVk13GEqROcx/E+0s5cJ+YJ2vpvLXUG+oAWFxRFI7aAKqKeUP+pAICdJgDOp6EkDHCeNL1PuX2NTfA0j7e/1qhm3klulB3nq3A2CNPAFffy0ioDoVarSMLRr5u1VpczTBCvfP7QQPd6FiUsH4COnOPjZlWm9g4jc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(70586007)(4326008)(1076003)(40460700001)(70206006)(83380400001)(82310400004)(356005)(36860700001)(81166007)(15650500001)(8676002)(26005)(44832011)(508600001)(6666004)(8936002)(2616005)(16526019)(86362001)(186003)(30864003)(2906002)(47076005)(36756003)(6916009)(426003)(336012)(7696005)(5660300002)(316002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 07:45:14.4140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e7695b-2bb3-4779-a533-08d9dcb1f617
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1877
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, ray.huang@amd.com,
 Evan Quan <evan.quan@amd.com>, Guchun.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use uint64_t instead of an array of uint32_t. This can avoid
some non-necessary intermediate uint32_t -> uint64_t conversions.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I4e217357203a23440f058d7e25f55eaebd15c5ef
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 ++--
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  5 +---
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  6 +---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  5 +---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  5 +---
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  4 +--
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 10 ++-----
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  7 ++---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  4 +--
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  9 ++----
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 29 +++++++------------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  3 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  2 +-
 14 files changed, 32 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index d3237b89f2c5..5aff66103da2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2309,7 +2309,7 @@ static int smu_read_sensor(void *handle,
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_ENABLED_SMC_FEATURES_MASK:
-		ret = smu_feature_get_enabled_mask(smu, (uint32_t *)data, 2);
+		ret = smu_feature_get_enabled_mask(smu, (uint64_t *)data);
 		*size = 8;
 		break;
 	case AMDGPU_PP_SENSOR_UVD_POWER:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 3c0360772822..46496bed5f61 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -974,10 +974,9 @@ struct pptable_funcs {
 	/**
 	 * @get_enabled_mask: Get a mask of features that are currently enabled
 	 *                    on the SMU.
-	 * &feature_mask: Array representing enabled feature mask.
-	 * &num: Elements in &feature_mask.
+	 * &feature_mask: Enabled feature mask.
 	 */
-	int (*get_enabled_mask)(struct smu_context *smu, uint32_t *feature_mask, uint32_t num);
+	int (*get_enabled_mask)(struct smu_context *smu, uint64_t *feature_mask);
 
 	/**
 	 * @feature_is_enabled: Test if a feature is enabled.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 2c78d04d5611..dda36942cfb6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2022,15 +2022,12 @@ static void arcturus_dump_pptable(struct smu_context *smu)
 static bool arcturus_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
-	uint32_t feature_mask[2];
 	uint64_t feature_enabled;
 
-	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
+	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 	if (ret)
 		return false;
 
-	feature_enabled = (uint64_t)feature_mask[1] << 32 | feature_mask[0];
-
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index cabea4eb1566..844d931da6f6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -366,20 +366,16 @@ static bool cyan_skillfish_is_dpm_running(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
-	uint32_t feature_mask[2];
 	uint64_t feature_enabled;
 
 	/* we need to re-init after suspend so return false */
 	if (adev->in_suspend)
 		return false;
 
-	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
+	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 	if (ret)
 		return false;
 
-	feature_enabled = (uint64_t)feature_mask[0] |
-				((uint64_t)feature_mask[1] << 32);
-
 	/*
 	 * cyan_skillfish specific, query default sclk inseted of hard code.
 	 */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 9fb290f9aaeb..4a41cd6c5ea4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1640,15 +1640,12 @@ static int navi10_display_config_changed(struct smu_context *smu)
 static bool navi10_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
-	uint32_t feature_mask[2];
 	uint64_t feature_enabled;
 
-	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
+	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 	if (ret)
 		return false;
 
-	feature_enabled = (uint64_t)feature_mask[1] << 32 | feature_mask[0];
-
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index d568d6137a00..bea22eeb6073 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1298,15 +1298,12 @@ static int sienna_cichlid_display_config_changed(struct smu_context *smu)
 static bool sienna_cichlid_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
-	uint32_t feature_mask[2];
 	uint64_t feature_enabled;
 
-	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
+	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 	if (ret)
 		return false;
 
-	feature_enabled = (uint64_t)feature_mask[1] << 32 | feature_mask[0];
-
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index b69c2ecc8e25..b30885f4ca8e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -799,7 +799,7 @@ int smu_v11_0_system_features_control(struct smu_context *smu,
 					     bool en)
 {
 	struct smu_feature *feature = &smu->smu_feature;
-	uint32_t feature_mask[2];
+	uint64_t feature_mask;
 	int ret = 0;
 
 	ret = smu_cmn_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
@@ -810,7 +810,7 @@ int smu_v11_0_system_features_control(struct smu_context *smu,
 	bitmap_zero(feature->enabled, feature->feature_num);
 
 	if (en) {
-		ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
+		ret = smu_cmn_get_enabled_mask(smu, &feature_mask);
 		if (ret)
 			return ret;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index e72831aa4859..478151e72889 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -500,21 +500,17 @@ static bool vangogh_is_dpm_running(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
-	uint32_t feature_mask[2];
 	uint64_t feature_enabled;
 
 	/* we need to re-init after suspend so return false */
 	if (adev->in_suspend)
 		return false;
 
-	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
+	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 
 	if (ret)
 		return false;
 
-	feature_enabled = (unsigned long)((uint64_t)feature_mask[0] |
-				((uint64_t)feature_mask[1] << 32));
-
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
@@ -1952,7 +1948,7 @@ static int vangogh_system_features_control(struct smu_context *smu, bool en)
 {
 	struct amdgpu_device *adev = smu->adev;
 	struct smu_feature *feature = &smu->smu_feature;
-	uint32_t feature_mask[2];
+	uint64_t feature_mask;
 	int ret = 0;
 
 	if (adev->pm.fw_version >= 0x43f1700 && !en)
@@ -1964,7 +1960,7 @@ static int vangogh_system_features_control(struct smu_context *smu, bool en)
 	if (!en)
 		return ret;
 
-	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
+	ret = smu_cmn_get_enabled_mask(smu, &feature_mask);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 8c02adbf446a..97762e997644 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1451,14 +1451,11 @@ static int aldebaran_usr_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_
 static bool aldebaran_is_dpm_running(struct smu_context *smu)
 {
 	int ret;
-	uint32_t feature_mask[2];
-	unsigned long feature_enabled;
+	uint64_t feature_enabled;
 
-	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
+	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 	if (ret)
 		return false;
-	feature_enabled = (unsigned long)((uint64_t)feature_mask[0] |
-					  ((uint64_t)feature_mask[1] << 32));
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index c5d354175675..c1caf61c2bbc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -765,7 +765,7 @@ int smu_v13_0_system_features_control(struct smu_context *smu,
 				      bool en)
 {
 	struct smu_feature *feature = &smu->smu_feature;
-	uint32_t feature_mask[2];
+	uint64_t feature_mask;
 	int ret = 0;
 
 	ret = smu_cmn_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
@@ -776,7 +776,7 @@ int smu_v13_0_system_features_control(struct smu_context *smu,
 	bitmap_zero(feature->enabled, feature->feature_num);
 
 	if (en) {
-		ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
+		ret = smu_cmn_get_enabled_mask(smu, &feature_mask);
 		if (ret)
 			return ret;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index e9172622c0c4..d89e8a03651b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -197,7 +197,7 @@ static int yellow_carp_system_features_control(struct smu_context *smu, bool en)
 {
 	struct smu_feature *feature = &smu->smu_feature;
 	struct amdgpu_device *adev = smu->adev;
-	uint32_t feature_mask[2];
+	uint64_t feature_mask;
 	int ret = 0;
 
 	if (!en && !adev->in_s0ix)
@@ -208,7 +208,7 @@ static int yellow_carp_system_features_control(struct smu_context *smu, bool en)
 	if (!en)
 		return ret;
 
-	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
+	ret = smu_cmn_get_enabled_mask(smu, &feature_mask);
 	if (ret)
 		return ret;
 
@@ -252,16 +252,13 @@ static int yellow_carp_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 static bool yellow_carp_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
-	uint32_t feature_mask[2];
 	uint64_t feature_enabled;
 
-	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
+	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 
 	if (ret)
 		return false;
 
-	feature_enabled = (uint64_t)feature_mask[1] << 32 | feature_mask[0];
-
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 49bcabe9d708..ece6ec230a89 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -525,8 +525,7 @@ bool smu_cmn_clk_dpm_is_enabled(struct smu_context *smu,
 }
 
 int smu_cmn_get_enabled_mask(struct smu_context *smu,
-			     uint32_t *feature_mask,
-			     uint32_t num)
+			     uint64_t *feature_mask)
 {
 	struct smu_feature *feature = &smu->smu_feature;
 	struct amdgpu_device *adev = smu->adev;
@@ -534,7 +533,7 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
 	uint32_t *feature_mask_low;
 	int ret = 0;
 
-	if (!feature_mask || num < 2)
+	if (!feature_mask)
 		return -EINVAL;
 
 	if (!bitmap_empty(feature->enabled, feature->feature_num)) {
@@ -544,8 +543,8 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
 		return 0;
 	}
 
-	feature_mask_low = &feature_mask[0];
-	feature_mask_high = &feature_mask[1];
+	feature_mask_low = &((uint32_t *)feature_mask)[0];
+	feature_mask_high = &((uint32_t *)feature_mask)[1];
 
 	switch (adev->asic_type) {
 	case CHIP_CYAN_SKILLFISH:
@@ -676,7 +675,7 @@ static const char *smu_get_feature_name(struct smu_context *smu,
 size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 				   char *buf)
 {
-	uint32_t feature_mask[2] = { 0 };
+	uint64_t feature_mask;
 	int feature_index = 0;
 	uint32_t count = 0;
 	int8_t sort_feature[SMU_FEATURE_COUNT];
@@ -684,13 +683,12 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 	int ret = 0, i;
 
 	ret = smu_cmn_get_enabled_mask(smu,
-				       feature_mask,
-				       2);
+				       &feature_mask);
 	if (ret)
 		return 0;
 
 	size =  sysfs_emit_at(buf, size, "features high: 0x%08x low: 0x%08x\n",
-			feature_mask[1], feature_mask[0]);
+			upper_32_bits(feature_mask), lower_32_bits(feature_mask));
 
 	memset(sort_feature, -1, sizeof(sort_feature));
 
@@ -726,22 +724,17 @@ int smu_cmn_set_pp_feature_mask(struct smu_context *smu,
 				uint64_t new_mask)
 {
 	int ret = 0;
-	uint32_t feature_mask[2] = { 0 };
+	uint64_t feature_mask;
 	uint64_t feature_2_enabled = 0;
 	uint64_t feature_2_disabled = 0;
-	uint64_t feature_enables = 0;
 
 	ret = smu_cmn_get_enabled_mask(smu,
-				       feature_mask,
-				       2);
+				       &feature_mask);
 	if (ret)
 		return ret;
 
-	feature_enables = ((uint64_t)feature_mask[1] << 32 |
-			   (uint64_t)feature_mask[0]);
-
-	feature_2_enabled  = ~feature_enables & new_mask;
-	feature_2_disabled = feature_enables & ~new_mask;
+	feature_2_enabled  = ~feature_mask & new_mask;
+	feature_2_disabled = feature_mask & ~new_mask;
 
 	if (feature_2_enabled) {
 		ret = smu_cmn_feature_update_enable_state(smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 19919182260a..98190ed5360f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -55,8 +55,7 @@ bool smu_cmn_clk_dpm_is_enabled(struct smu_context *smu,
 				enum smu_clk_type clk_type);
 
 int smu_cmn_get_enabled_mask(struct smu_context *smu,
-			     uint32_t *feature_mask,
-			     uint32_t num);
+			     uint64_t *feature_mask);
 
 uint64_t smu_cmn_get_indep_throttler_status(
 					const unsigned long dep_status,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index 59f9cfff3d61..2f9aff89f667 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -55,7 +55,7 @@
 #define smu_send_smc_msg(smu, msg, read_arg)				smu_ppt_funcs(send_smc_msg, 0, smu, msg, read_arg)
 #define smu_init_display_count(smu, count)				smu_ppt_funcs(init_display_count, 0, smu, count)
 #define smu_feature_set_allowed_mask(smu)				smu_ppt_funcs(set_allowed_mask, 0, smu)
-#define smu_feature_get_enabled_mask(smu, mask, num)			smu_ppt_funcs(get_enabled_mask, 0, smu, mask, num)
+#define smu_feature_get_enabled_mask(smu, mask)				smu_ppt_funcs(get_enabled_mask, 0, smu, mask)
 #define smu_feature_is_enabled(smu, mask)				smu_ppt_funcs(feature_is_enabled, 0, smu, mask)
 #define smu_disable_all_features_with_exception(smu, no_hw_disablement, mask)		smu_ppt_funcs(disable_all_features_with_exception, 0, smu, no_hw_disablement, mask)
 #define smu_is_dpm_running(smu)						smu_ppt_funcs(is_dpm_running, 0 , smu)
-- 
2.29.0

