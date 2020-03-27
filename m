Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BE4C43331
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 03:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46338206DB
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 03:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jMrirMWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46338206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E4E66E233;
	Fri, 27 Mar 2020 03:42:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BFAC6E233
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 03:42:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpOXp75bIV10BhLP+7Mx7CCuM/5epWxC4TiC2mkIx5FnhG447BX1TwAuSzK9TomtFcdac5shKFFgM/8Bx0i3vIGFkeBQskmkRDuJ6AgK7o9y2oc4Ay+RTTDVbHbSUepwxf22QIKgwwJNAH2TYM2YW7G90CPvBRJrymEFFs4ZRQdevedt9FuNTk5+RqVh69DO2UadDvfcFIRq+B7EPqUu0ByR5wjnIg3Xy461y54Osm4eNxxbNOtU3p85hJl0/uKsqu9TIGzmRAQeM6oIQ9pPIXyiSfjkhldpCFBNVsdMFR8SazWzfKqzs1ZNt8goU2utKm5Yp43rQyKH2yh1vkXMAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSW28Du2lfc7EVNZ+nPQ9te4pL9mCBIKHdLIGP2673M=;
 b=a7HbPxo7OCS3+TRVIVm60oeBj0wtxNwWoO8i2Nt3kjrm7UtI1FzNm7zC1nSjXsnpxjXJcSFDceoIGos4+EfVcHraQlm/+zPddRpkVu7bd7iN2TdrKRKgRoRrQTZv8z1W1xXHXYCf7JcOQcZgfpL+3P0gJy1+PhsmLP7D8ZxHTMpnAB0WEJcu+BHfuaPkQDdhL192Q9AkKRf4Z62KrzVVHSJIkugYyVt2IAungeDjcuJ/4WCAOrigVf+QmnfccW4630ItE20uigMlZU3MYzvsgv8OpkaOh9XkMrkVEmPHZqSpgZUyTB2oneRdlyisUzBvk/uUKUhU8GmEbPzcoy+9RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSW28Du2lfc7EVNZ+nPQ9te4pL9mCBIKHdLIGP2673M=;
 b=jMrirMWzy4ASox/nd1GkZWqcci5tsRBYbp+oOaLoZE+I48i8zurYNuTyAAqypgiMKdBwVZ4yhkBhy1MHLJ+An6+f7pjGcQEUd/KIL0NypnKTm2iREUem9y6eSMttRslakuhc1e/2WnYtajfO0JUUBwxeu4ORPCuW87OpiGG+bYk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 27 Mar
 2020 03:42:52 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2835.021; Fri, 27 Mar 2020
 03:42:52 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/9] drm/amd/powerplay: avoid calling SMU9 specific SMU
 message implemention
Date: Fri, 27 Mar 2020 11:41:34 +0800
Message-Id: <20200327034138.7653-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200327034138.7653-1-evan.quan@amd.com>
References: <20200327034138.7653-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR01CA0063.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::27) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK0PR01CA0063.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Fri, 27 Mar 2020 03:42:51 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ff4d1604-f806-4b1d-ea7e-08d7d200ed83
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:|MN2PR12MB4373:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB43731D1B6ED49A02853025E1E4CC0@MN2PR12MB4373.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(6666004)(6486002)(26005)(81156014)(8676002)(6916009)(81166006)(16526019)(956004)(4326008)(15650500001)(186003)(36756003)(44832011)(2616005)(8936002)(52116002)(478600001)(86362001)(66946007)(66556008)(316002)(7696005)(2906002)(5660300002)(1076003)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4373;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cSPjMN1OPjPXt1EQHldJDVCT0zsvu9GzzKpGhqPrUq3T8Vxl520ixJs7qvZ1qGwwYahdJTcG3zh63IH3xBLmrV2JqO0rHVGmC1nomtG7uc2YaC0Suue3cPpa6kjb8X9DxvDqoKtaga6pIssWUwGsW0YEfNRf8hHQUQm4UlMUj6KbVtaDQbyTaodaIh0YmXLDRkeG/DTdDvptA/L+pDc5fH5EbdxLVQItYT2P3dbrwA5pWndhmmtY6sJDczmVJBd2oDGU6pbaZXZNYu+KTLBVnXlmHjrJrHNpm9nezqaLyGS5M+m/jUkhRMPbkMpSwalic9Typ44NCn6oOv2LrX6UtRA+X73viF4H3cpGNrn7BC6kZ6C/Eq2MPYCljs1kpdge32tCRHfO8fWNa4mLcJOCLFuu+TpCue+h9JLE99O90wv0TgVUmJra6YAJzngGtP6S
X-MS-Exchange-AntiSpam-MessageData: 8uhbIppbniILUnV/lSj7qhRDLystuxcYcLOYIhnk7gnvNWNiCvN3FOiVY/rTtY5PvjOo67An0aebARlYOPhh4oFm/Aao1EvocgQNTB6IffBRGphlrr+0vRQMAi+jIk7QpOORyU7Bh4E7c+juz00fsA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4d1604-f806-4b1d-ea7e-08d7d200ed83
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 03:42:52.5641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: neTIsLoAiZhSv25843FxDH91KDytpaawZ/HJqER/VJAog5h1AWGgbmxU66Krugus
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Prepare for coming lock protection for SMU message issuing.

Change-Id: Id2c0504c60358e6ff2beee83058e36812962e934
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/powerplay/smumgr/vega10_smumgr.c  | 24 +++++++-------
 .../drm/amd/powerplay/smumgr/vega12_smumgr.c  | 32 +++++++++----------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
index 715564009089..1769dded4f74 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
@@ -47,13 +47,13 @@ static int vega10_copy_table_from_smc(struct pp_hwmgr *hwmgr,
 			"Invalid SMU Table version!", return -EINVAL);
 	PP_ASSERT_WITH_CODE(priv->smu_tables.entry[table_id].size != 0,
 			"Invalid SMU Table Length!", return -EINVAL);
-	smu9_send_msg_to_smc_with_parameter(hwmgr,
+	smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrHigh,
 			upper_32_bits(priv->smu_tables.entry[table_id].mc_addr));
-	smu9_send_msg_to_smc_with_parameter(hwmgr,
+	smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrLow,
 			lower_32_bits(priv->smu_tables.entry[table_id].mc_addr));
-	smu9_send_msg_to_smc_with_parameter(hwmgr,
+	smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_TransferTableSmu2Dram,
 			priv->smu_tables.entry[table_id].table_id);
 
@@ -90,13 +90,13 @@ static int vega10_copy_table_to_smc(struct pp_hwmgr *hwmgr,
 
 	amdgpu_asic_flush_hdp(adev, NULL);
 
-	smu9_send_msg_to_smc_with_parameter(hwmgr,
+	smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrHigh,
 			upper_32_bits(priv->smu_tables.entry[table_id].mc_addr));
-	smu9_send_msg_to_smc_with_parameter(hwmgr,
+	smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrLow,
 			lower_32_bits(priv->smu_tables.entry[table_id].mc_addr));
-	smu9_send_msg_to_smc_with_parameter(hwmgr,
+	smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_TransferTableDram2Smu,
 			priv->smu_tables.entry[table_id].table_id);
 
@@ -127,8 +127,8 @@ int vega10_get_enabled_smc_features(struct pp_hwmgr *hwmgr,
 	if (features_enabled == NULL)
 		return -EINVAL;
 
-	smu9_send_msg_to_smc(hwmgr, PPSMC_MSG_GetEnabledSmuFeatures);
-	*features_enabled = smu9_get_argument(hwmgr);
+	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetEnabledSmuFeatures);
+	*features_enabled = smum_get_argument(hwmgr);
 
 	return 0;
 }
@@ -150,10 +150,10 @@ static int vega10_set_tools_address(struct pp_hwmgr *hwmgr)
 	struct vega10_smumgr *priv = hwmgr->smu_backend;
 
 	if (priv->smu_tables.entry[TOOLSTABLE].mc_addr) {
-		smu9_send_msg_to_smc_with_parameter(hwmgr,
+		smum_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_SetToolsDramAddrHigh,
 				upper_32_bits(priv->smu_tables.entry[TOOLSTABLE].mc_addr));
-		smu9_send_msg_to_smc_with_parameter(hwmgr,
+		smum_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_SetToolsDramAddrLow,
 				lower_32_bits(priv->smu_tables.entry[TOOLSTABLE].mc_addr));
 	}
@@ -167,11 +167,11 @@ static int vega10_verify_smc_interface(struct pp_hwmgr *hwmgr)
 	uint32_t dev_id;
 	uint32_t rev_id;
 
-	PP_ASSERT_WITH_CODE(!smu9_send_msg_to_smc(hwmgr,
+	PP_ASSERT_WITH_CODE(!smum_send_msg_to_smc(hwmgr,
 			PPSMC_MSG_GetDriverIfVersion),
 			"Attempt to get SMC IF Version Number Failed!",
 			return -EINVAL);
-	smc_driver_if_version = smu9_get_argument(hwmgr);
+	smc_driver_if_version = smum_get_argument(hwmgr);
 
 	dev_id = adev->pdev->device;
 	rev_id = adev->pdev->revision;
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
index 275dbf65f1a0..34528a1285ac 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
@@ -50,16 +50,16 @@ static int vega12_copy_table_from_smc(struct pp_hwmgr *hwmgr,
 			"Invalid SMU Table version!", return -EINVAL);
 	PP_ASSERT_WITH_CODE(priv->smu_tables.entry[table_id].size != 0,
 			"Invalid SMU Table Length!", return -EINVAL);
-	PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc_with_parameter(hwmgr,
+	PP_ASSERT_WITH_CODE(smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrHigh,
 			upper_32_bits(priv->smu_tables.entry[table_id].mc_addr)) == 0,
 			"[CopyTableFromSMC] Attempt to Set Dram Addr High Failed!", return -EINVAL);
-	PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc_with_parameter(hwmgr,
+	PP_ASSERT_WITH_CODE(smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrLow,
 			lower_32_bits(priv->smu_tables.entry[table_id].mc_addr)) == 0,
 			"[CopyTableFromSMC] Attempt to Set Dram Addr Low Failed!",
 			return -EINVAL);
-	PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc_with_parameter(hwmgr,
+	PP_ASSERT_WITH_CODE(smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_TransferTableSmu2Dram,
 			table_id) == 0,
 			"[CopyTableFromSMC] Attempt to Transfer Table From SMU Failed!",
@@ -98,17 +98,17 @@ static int vega12_copy_table_to_smc(struct pp_hwmgr *hwmgr,
 
 	amdgpu_asic_flush_hdp(adev, NULL);
 
-	PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc_with_parameter(hwmgr,
+	PP_ASSERT_WITH_CODE(smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrHigh,
 			upper_32_bits(priv->smu_tables.entry[table_id].mc_addr)) == 0,
 			"[CopyTableToSMC] Attempt to Set Dram Addr High Failed!",
 			return -EINVAL;);
-	PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc_with_parameter(hwmgr,
+	PP_ASSERT_WITH_CODE(smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrLow,
 			lower_32_bits(priv->smu_tables.entry[table_id].mc_addr)) == 0,
 			"[CopyTableToSMC] Attempt to Set Dram Addr Low Failed!",
 			return -EINVAL);
-	PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc_with_parameter(hwmgr,
+	PP_ASSERT_WITH_CODE(smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_TransferTableDram2Smu,
 			table_id) == 0,
 			"[CopyTableToSMC] Attempt to Transfer Table To SMU Failed!",
@@ -126,20 +126,20 @@ int vega12_enable_smc_features(struct pp_hwmgr *hwmgr,
 	smu_features_high = (uint32_t)((feature_mask & SMU_FEATURES_HIGH_MASK) >> SMU_FEATURES_HIGH_SHIFT);
 
 	if (enable) {
-		PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc_with_parameter(hwmgr,
+		PP_ASSERT_WITH_CODE(smum_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_EnableSmuFeaturesLow, smu_features_low) == 0,
 				"[EnableDisableSMCFeatures] Attempt to enable SMU features Low failed!",
 				return -EINVAL);
-		PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc_with_parameter(hwmgr,
+		PP_ASSERT_WITH_CODE(smum_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_EnableSmuFeaturesHigh, smu_features_high) == 0,
 				"[EnableDisableSMCFeatures] Attempt to enable SMU features High failed!",
 				return -EINVAL);
 	} else {
-		PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc_with_parameter(hwmgr,
+		PP_ASSERT_WITH_CODE(smum_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_DisableSmuFeaturesLow, smu_features_low) == 0,
 				"[EnableDisableSMCFeatures] Attempt to disable SMU features Low failed!",
 				return -EINVAL);
-		PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc_with_parameter(hwmgr,
+		PP_ASSERT_WITH_CODE(smum_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_DisableSmuFeaturesHigh, smu_features_high) == 0,
 				"[EnableDisableSMCFeatures] Attempt to disable SMU features High failed!",
 				return -EINVAL);
@@ -156,17 +156,17 @@ int vega12_get_enabled_smc_features(struct pp_hwmgr *hwmgr,
 	if (features_enabled == NULL)
 		return -EINVAL;
 
-	PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc(hwmgr,
+	PP_ASSERT_WITH_CODE(smum_send_msg_to_smc(hwmgr,
 			PPSMC_MSG_GetEnabledSmuFeaturesLow) == 0,
 			"[GetEnabledSMCFeatures] Attempt to get SMU features Low failed!",
 			return -EINVAL);
-	smc_features_low = smu9_get_argument(hwmgr);
+	smc_features_low = smum_get_argument(hwmgr);
 
-	PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc(hwmgr,
+	PP_ASSERT_WITH_CODE(smum_send_msg_to_smc(hwmgr,
 			PPSMC_MSG_GetEnabledSmuFeaturesHigh) == 0,
 			"[GetEnabledSMCFeatures] Attempt to get SMU features High failed!",
 			return -EINVAL);
-	smc_features_high = smu9_get_argument(hwmgr);
+	smc_features_high = smum_get_argument(hwmgr);
 
 	*features_enabled = ((((uint64_t)smc_features_low << SMU_FEATURES_LOW_SHIFT) & SMU_FEATURES_LOW_MASK) |
 			(((uint64_t)smc_features_high << SMU_FEATURES_HIGH_SHIFT) & SMU_FEATURES_HIGH_MASK));
@@ -192,10 +192,10 @@ static int vega12_set_tools_address(struct pp_hwmgr *hwmgr)
 			(struct vega12_smumgr *)(hwmgr->smu_backend);
 
 	if (priv->smu_tables.entry[TABLE_PMSTATUSLOG].mc_addr) {
-		if (!smu9_send_msg_to_smc_with_parameter(hwmgr,
+		if (!smum_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_SetToolsDramAddrHigh,
 				upper_32_bits(priv->smu_tables.entry[TABLE_PMSTATUSLOG].mc_addr)))
-			smu9_send_msg_to_smc_with_parameter(hwmgr,
+			smum_send_msg_to_smc_with_parameter(hwmgr,
 					PPSMC_MSG_SetToolsDramAddrLow,
 					lower_32_bits(priv->smu_tables.entry[TABLE_PMSTATUSLOG].mc_addr));
 	}
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
