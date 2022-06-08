Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E725C43334
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 09:06:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA37610E346;
	Wed,  8 Jun 2022 09:06:05 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF4E410E2D5
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 09:06:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIeD0fYfVsM1wbk2fQA38hz9/ZXcYlHcMs/skvnkUYim61lbgpCCSmC9kJcnvjovWeS6/uTNxUIFcU1ERRpZ4sP/RuvELPI5/z1GT63Z+ogGDtRh+3rFmysM2Hun2zpFTBgLimkZoML7EAq6KYnTq0FLLoe+4Oqc/KJI3s6hv1IfLQHaS+08JlvsWjmnXB+5YZUsOntmcXeFkNfIKzSNQkboxO5EO2Go2wr29j5L2CG6OghoZBFJox6ITvAS1uJKZj429lSjLkLP6D8LQNKYY/zYTNLQ1L6Wu6g+X4vAkeDDvJVniADy7o1Kg/6iNfRbjoKsAf5kG/tfML/Rrm5g3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSsleR2yaJoG5wB7pDghTx6TgB6TJ77k9RCz5b4+P38=;
 b=FMC/6Pgs2AWUzRxYj/k4jRHWRaIDoGtuIH1sLDPT1D324dpb5l+tU1cS3FNFSDkrQj3jtuRRmzjjgb9eUsAiAmClo76gjqZqoy7UsMisw/ngYRA/GYLvh7IQXPbDg74j84kRcw5CTe5/Cwfmzgo6HtznBvQg4LgStW+70HlVxRRfNZL4J99e3+9v1v+H5pb2bVD+8F3jx+GbBri9GqksTpedC7Nc7UdeZfki9/Z+dMOqKACciELR1c5D/hsIvOPKWk9z35ZcaXO7ro2uH8GdPNPSh78bztrijfqQZV+9RCVrwYdGUyg3ytnjQ5gxryugyb5VZwR7ZXgBkgb9TXfVEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSsleR2yaJoG5wB7pDghTx6TgB6TJ77k9RCz5b4+P38=;
 b=F0QOvqNB9jsRV9+J7qal0InNDz/tNWQ+gLGy3Xf3p7UTAqZmAtCQyDYf9EIE8rJ0RsTkCLZRWoa7M+8spKs7sBXhlVXm02/Ikoptw90QVefPfghY5CWKulyfhMnq8z0RBmocOEqLll76oNUquk3hnIZzQ17+3TuMa/OwFB4Wnec=
Received: from MW4PR04CA0367.namprd04.prod.outlook.com (2603:10b6:303:81::12)
 by BN9PR12MB5365.namprd12.prod.outlook.com (2603:10b6:408:102::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 09:06:03 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::41) by MW4PR04CA0367.outlook.office365.com
 (2603:10b6:303:81::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Wed, 8 Jun 2022 09:06:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 8 Jun 2022 09:06:02 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 8 Jun
 2022 04:06:02 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 8 Jun
 2022 02:06:01 -0700
Received: from kenneth-u2004-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Wed, 8 Jun 2022 04:06:00 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amd/pm: support BAMACO reset on smu_v13_0_7
Date: Wed, 8 Jun 2022 17:05:36 +0800
Message-ID: <20220608090536.1969621-5-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220608090536.1969621-1-kenneth.feng@amd.com>
References: <20220608090536.1969621-1-kenneth.feng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc8a5e4b-6316-474d-1636-08da492e1cc6
X-MS-TrafficTypeDiagnostic: BN9PR12MB5365:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB536539A1F9AD0D93174589CE8EA49@BN9PR12MB5365.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4RNykNj4slBKjyo0XJPSXoGjb2PJy6v3jpCpJe87TYogWPfSmOHVeT4Iin0RPtspwIl2Uyrt7KTP2uoTYcbt+Ugj5ZWn7E18YbHgkdGJhPEYVsJzIfsXgrQJl4AmdtGdqSECNAVg2iFLP5FO9T/KgHtCXp43t6Dg4W0auUul0AhqPacd33GhkSYhagI9GNODQ/fFHT00Wvq3rq0RvR9VvmR0zSv0X+rrd3JvG2K/v9Ll4uFqVPmXG0Qhhz62ll76ysk9XNrFOWlm75rxOzoF8by9DG4wfuWWFk5C/4fUArPxw5ZbDb07W5uk/I8pdC2dFsV2ZsGr3CzxcxICLiizm0yT3ZIuka6K489HfK24mlnsEnnygPikw+lm3ua2Pl8o3TUSZHDvReAPdPzBcm7g9ThozR9eZRS5KGpOwEtYnF7eY/A2ZIxczBxi0kis3Sbi5srM2zHnZcHGQBGapJ8mk9ZIDsRru9eRyIla/JocXNJGWEMPR3dFom7Y/mAWKzgIVmSbWOliAJJTY+Nn8WYp0OyS7Q+Y4WFJxCKDDx0pXsMnuJVjAAttK9gmZroD4wJ5mpa+Hc5fKdFJqj97Vk+b4etN0gG5zjB49rMvVpdUOiMQCcbIus59/CPfSrsbKHBtE0kWzWuU4MxGWYR1x+m3k0zTQINE8pVbQT2/FDaZMhoPolfVj0Ed8fOtu6SdYPeejb8EBzc12GB741+hKyEWFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(4326008)(8936002)(508600001)(36860700001)(70586007)(86362001)(36756003)(44832011)(356005)(6666004)(5660300002)(70206006)(2616005)(8676002)(82310400005)(81166007)(426003)(336012)(47076005)(83380400001)(2906002)(186003)(7696005)(40460700003)(26005)(316002)(6916009)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 09:06:02.4694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8a5e4b-6316-474d-1636-08da492e1cc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5365
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

support BAMACO reset on smu_v13_0_7, take BAMACO as a subset of BACO
for the low latency, and it only happens on specific platforms.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 57 ++++++++++++++++++-
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 6d51e4340aad..b81c657c7386 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -432,6 +432,7 @@ struct smu_baco_context
 {
 	uint32_t state;
 	bool platform_support;
+	bool maco_support;
 };
 
 struct smu_freq_info {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index b635c2b4f81c..369e84fef5a6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -303,6 +303,8 @@ static int smu_v13_0_7_check_powerplay_table(struct smu_context *smu)
 	struct smu_13_0_7_powerplay_table *powerplay_table =
 		table_context->power_play_table;
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
+	PPTable_t *smc_pptable = table_context->driver_pptable;
+	BoardTable_t *BoardTable = &smc_pptable->BoardTable;
 
 	if (powerplay_table->platform_caps & SMU_13_0_7_PP_PLATFORM_CAP_HARDWAREDC)
 		smu->dc_controlled_by_gpio = true;
@@ -311,6 +313,9 @@ static int smu_v13_0_7_check_powerplay_table(struct smu_context *smu)
 	    powerplay_table->platform_caps & SMU_13_0_7_PP_PLATFORM_CAP_MACO)
 		smu_baco->platform_support = true;
 
+	if (smu_baco->platform_support && (BoardTable->HsrEnabled || BoardTable->VddqOffEnabled))
+		smu_baco->maco_support = true;
+
 	table_context->thermal_controller_type =
 		powerplay_table->thermal_controller_type;
 
@@ -1537,6 +1542,54 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
 	return ret;
 }
 
+static int smu_v13_0_7_baco_set_state(struct smu_context *smu,
+			     enum smu_baco_state state)
+{
+	struct smu_baco_context *smu_baco = &smu->smu_baco;
+	struct amdgpu_device *adev = smu->adev;
+	bool is_maco_support = smu_baco->maco_support;
+	int ret = 0;
+
+	if (smu_v13_0_baco_get_state(smu) == state)
+		return 0;
+
+	if (state == SMU_BACO_STATE_ENTER) {
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+						      SMU_MSG_EnterBaco,
+						      (is_maco_support ? 2 : 0),
+						      NULL);
+	} else {
+		ret = smu_cmn_send_smc_msg(smu,
+					   SMU_MSG_ExitBaco,
+					   NULL);
+		if (ret)
+			return ret;
+
+		/* clear vbios scratch 6 and 7 for coming asic reinit */
+		WREG32(adev->bios_scratch_reg_offset + 6, 0);
+		WREG32(adev->bios_scratch_reg_offset + 7, 0);
+	}
+
+	if (!ret)
+		smu_baco->state = state;
+
+	return ret;
+}
+
+static int smu_v13_0_7_baco_enter(struct smu_context *smu)
+{
+	int ret = 0;
+
+	ret = smu_v13_0_7_baco_set_state(smu,
+				       SMU_BACO_STATE_ENTER);
+	if (ret)
+		return ret;
+
+	msleep(10);
+
+	return ret;
+}
+
 static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_7_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_7_set_default_dpm_table,
@@ -1591,8 +1644,8 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 	.baco_is_support = smu_v13_0_baco_is_support,
 	.baco_get_state = smu_v13_0_baco_get_state,
-	.baco_set_state = smu_v13_0_baco_set_state,
-	.baco_enter = smu_v13_0_baco_enter,
+	.baco_set_state = smu_v13_0_7_baco_set_state,
+	.baco_enter = smu_v13_0_7_baco_enter,
 	.baco_exit = smu_v13_0_baco_exit,
 };
 
-- 
2.25.1

