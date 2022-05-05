Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90290C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 20:08:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5EBB10EAAB;
	Thu,  5 May 2022 20:08:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 230E610E7F1
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 20:08:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIbZimKG6hv56cymaWm94rsOtIKlvHg8qU3UbIH55LMq6jEBcsIilXAGlOs0nnewE7kBqcLIzcu6foV5b9QyYwu8TQA4i3x3HvfFiwHc6DrIktwsF6AlsDNXlUWhAB8s4wdCJYNrtCI+20q6ZrVR2c+lJuaAAs9UG9RZU6H0RxAyTYlEjmZTisDdBneSNA10DJzXEdYnNYcv6s+DR7Hg+tgVb0+4Ez6awJ5ell5/c8lZgKwzFuv6AqanCCsKpJ0NQtCun07xLD9eYjmGNJ6a37o1WgSB/uthdR2ppXmlOBviFnlpJ+byrtUhTwe4ZsHtktMl2t36r6AS1wmVOfs4dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJHGomImh5P0OrZTDGqKJsq6wEemI07ETKoaC/O9Mv0=;
 b=YGNb7df8T4FGQswhyAzLfvM+MX7CvaKgbyWsKIAvnWQqhx8/vBTzIyCDMIZkgr5QZTuB7KrZw7489K+YpoEjE+OiyPmjV7b0eZDOFFqolPjnq/TOspzWekRIOqlhkCby2cirCCnxDVh/SQxSfK2xb2NGxBEnLddjSvqDq4pJqJj/o9YpOEy1KyMSVtCl6+a07u45IXXuxU+3oFg29BcfVdiFeT/EhPSDp2Au4CfwODrcFSCgZxMsV7gkkQl9+YM6f3z+O+uYYaaTpOoxu47QN9wI3WO8iq0wr4LOGqf6MJYerNJn/jTN1qmwV7nU2ZSCTYGCrQyRVu2HDeit48Nazw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJHGomImh5P0OrZTDGqKJsq6wEemI07ETKoaC/O9Mv0=;
 b=0mAOe1ntvI0+v2mTxZBNpdXYyO7VHC90R2XVwXqVhzUUY47pk5WpfNsQi50X5fFo4lZqRmeBXc+FnjbzGtDDvD2mvPnrRY24+OCVM42SeDlXTKYNnlQn/iFbo8CwL+72YFug7Km8yw+2KzcqsklKIoK2pWHGOLZScQiJPkAXsTI=
Received: from DM6PR06CA0039.namprd06.prod.outlook.com (2603:10b6:5:54::16) by
 BYAPR12MB3080.namprd12.prod.outlook.com (2603:10b6:a03:de::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Thu, 5 May 2022 20:08:30 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::b) by DM6PR06CA0039.outlook.office365.com
 (2603:10b6:5:54::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25 via Frontend
 Transport; Thu, 5 May 2022 20:08:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 20:08:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 15:08:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: enable BACO support for SMU 13.0.0
Date: Thu, 5 May 2022 16:07:38 -0400
Message-ID: <20220505200750.1293725-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505200750.1293725-1-alexander.deucher@amd.com>
References: <20220505200750.1293725-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88f637f2-c2dc-487a-cb6c-08da2ed305db
X-MS-TrafficTypeDiagnostic: BYAPR12MB3080:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3080EB356C04F1ABAC2D757FF7C29@BYAPR12MB3080.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hUf5rKdm14qdVy5HLCsjvD/gJcGnKQsQ97iAZEkzhCX991HzJTX0jcpr630rwOp5UdG3BocUZkDrV9l5MpWagqLubGY83+2Onty2TTTyeGEIsTY4QdiInDFKaUFHKMci5xqr5K15Y5vI9D8ExI9Tm2R0rZM1CXy6gi1rxEuGDPgwQKoAS/EjgvCm3bOFQsMxm3R0BOxfC+tIcyPGuCG7f9PhjroETxgTpgZ3Qjnfro8mBRGnl3PatA5KRHaZ+YGTv1mK+kIZ+zME+JesoHExALh2yX/NgU9FRyjxIAuw2rgmlslZKrHOaefM1gngB65+wdZ5rGXTJns2Ds68Yw07cVSHzBoMwV9FCc6XAnaaHjtidz1qEZwIEG5pvPZxijJMPHrNQ9phv5HlPKDDlhQS8z0W7t+nO0ab7i1KJ09J4c05HRcqw3hpiph+NuNkuwK4uXf94Lvl/kNsuQbfZLnZcyMpqAfAsGmEnGWemfTX/P+/42EPc3ncTmOs/4cNjEmwKsRcduDvMbCZtiywhTP7ZOCwrWW0VUbDWuMTDcr8t9bdi47DSOLWbefrb73uX4XM+sAFxpdfPze9b+OErVovTAihhF8LOUS5KcK4+JLFQ4jZZS9wLF+0q6Sbr9gXjI6rn/BCgz6z/19BGICqEuOqz+sag6XHuIsHw+xa1ktG0g85EdGNyKqATkxE1oo+KA0X3tGv9LY9Bc/t75UAMROtDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(83380400001)(36756003)(508600001)(70586007)(70206006)(6916009)(4326008)(8676002)(6666004)(7696005)(54906003)(8936002)(5660300002)(316002)(47076005)(426003)(2616005)(336012)(186003)(26005)(16526019)(1076003)(2906002)(40460700003)(86362001)(356005)(81166007)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 20:08:29.6676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f637f2-c2dc-487a-cb6c-08da2ed305db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3080
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

Enable SMU 13.0.0 BACO support.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  | 11 +++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 75 +++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  7 ++
 3 files changed, 93 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 4a52ab737dd5..013be82db1f3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -282,5 +282,16 @@ int smu_v13_0_deep_sleep_control(struct smu_context *smu,
 int smu_v13_0_gfx_ulv_control(struct smu_context *smu,
 			      bool enablement);
 
+bool smu_v13_0_baco_is_support(struct smu_context *smu);
+
+enum smu_baco_state smu_v13_0_baco_get_state(struct smu_context *smu);
+
+int smu_v13_0_baco_set_state(struct smu_context *smu,
+			     enum smu_baco_state state);
+
+int smu_v13_0_baco_enter(struct smu_context *smu);
+
+int smu_v13_0_baco_exit(struct smu_context *smu);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 2c57bc573ee8..d73deb3e596f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2206,3 +2206,78 @@ int smu_v13_0_gfx_ulv_control(struct smu_context *smu,
 
 	return ret;
 }
+
+bool smu_v13_0_baco_is_support(struct smu_context *smu)
+{
+	struct smu_baco_context *smu_baco = &smu->smu_baco;
+
+	if (amdgpu_sriov_vf(smu->adev) ||
+	    !smu_baco->platform_support)
+		return false;
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_BACO_BIT) &&
+	    !smu_cmn_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT))
+		return false;
+
+	return true;
+}
+
+enum smu_baco_state smu_v13_0_baco_get_state(struct smu_context *smu)
+{
+	struct smu_baco_context *smu_baco = &smu->smu_baco;
+
+	return smu_baco->state;
+}
+
+int smu_v13_0_baco_set_state(struct smu_context *smu,
+			     enum smu_baco_state state)
+{
+	struct smu_baco_context *smu_baco = &smu->smu_baco;
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+
+	if (smu_v13_0_baco_get_state(smu) == state)
+		return 0;
+
+	if (state == SMU_BACO_STATE_ENTER) {
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+						      SMU_MSG_EnterBaco,
+						      0,
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
+int smu_v13_0_baco_enter(struct smu_context *smu)
+{
+	int ret = 0;
+
+	ret = smu_v13_0_baco_set_state(smu,
+				       SMU_BACO_STATE_ENTER);
+	if (ret)
+		return ret;
+
+	msleep(10);
+
+	return ret;
+}
+
+int smu_v13_0_baco_exit(struct smu_context *smu)
+{
+	return smu_v13_0_baco_set_state(smu,
+					SMU_BACO_STATE_EXIT);
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 71312ed26fb9..44da7e06a012 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -95,6 +95,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(UseDefaultPPTable,		PPSMC_MSG_UseDefaultPPTable,           0),
 	MSG_MAP(RunDcBtc,			PPSMC_MSG_RunDcBtc,                    0),
 	MSG_MAP(EnterBaco,			PPSMC_MSG_EnterBaco,                   0),
+	MSG_MAP(ExitBaco,			PPSMC_MSG_ExitBaco,                    0),
 	MSG_MAP(SetSoftMinByFreq,		PPSMC_MSG_SetSoftMinByFreq,            1),
 	MSG_MAP(SetSoftMaxByFreq,		PPSMC_MSG_SetSoftMaxByFreq,            1),
 	MSG_MAP(SetHardMinByFreq,		PPSMC_MSG_SetHardMinByFreq,            1),
@@ -150,6 +151,7 @@ static struct cmn2asic_mapping smu_v13_0_0_feature_mask_map[SMU_FEATURE_COUNT] =
 	[SMU_FEATURE_DS_MP0CLK_BIT] = {1, FEATURE_SOC_MPCLK_DS_BIT},
 	[SMU_FEATURE_DS_MP1CLK_BIT] = {1, FEATURE_BACO_MPCLK_DS_BIT},
 	[SMU_FEATURE_GFX_ULV_BIT] = {1, FEATURE_GFX_ULV_BIT},
+	[SMU_FEATURE_BACO_BIT] = {1, FEATURE_BACO_BIT},
 };
 
 static struct cmn2asic_mapping smu_v13_0_0_table_map[SMU_TABLE_COUNT] = {
@@ -1595,6 +1597,11 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.set_tool_table_location = smu_v13_0_set_tool_table_location,
 	.deep_sleep_control = smu_v13_0_deep_sleep_control,
 	.gfx_ulv_control = smu_v13_0_gfx_ulv_control,
+	.baco_is_support = smu_v13_0_baco_is_support,
+	.baco_get_state = smu_v13_0_baco_get_state,
+	.baco_set_state = smu_v13_0_baco_set_state,
+	.baco_enter = smu_v13_0_baco_enter,
+	.baco_exit = smu_v13_0_baco_exit,
 };
 
 void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
-- 
2.35.1

