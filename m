Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84361C43331
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 03:43:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55119206DB
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 03:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="q8XJkF32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55119206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26B8F6E369;
	Fri, 27 Mar 2020 03:43:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B6F76E369
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 03:43:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTq0pUm5UDnBQCDP7V4eJvmfSQhzcC68pOuD3RBFTUSaH2Dvu2EkWYIwwrAUZp3T5n4iMPlrbrCE1TKBJKdBwXSOdEw7Pk5B/mp4GGhzRp3ZiJjuv5DXOz22zK6GeAnXdGQGjGNcd3xYnVGV0bJW5fLTfNXb3q2Yy6aSoePoq6NHStA226ksJNdUZhgfLjEbP+qb9rkYxZuy2UxTarGdDRfTMB84RH2OVu5/6BlQTRyDc27x3HKsAHirbxxWsXJcrf8kJtYIVDNU87uzcmXuiEdfvrQjsQaAWpoIqOeKBbcyXAa6gVq1yXHiCJywZf9+uHJSR8MnglmE2AHEgXcOOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNM0xviasaFvj1POjlatgjnYR72qDbFK/l37Nu61C2o=;
 b=cO9ldPcuyzeXQn8X4LusVXsVr1Xi7vTETsCn6doDTnOmEbYlabMGSfTdEO/EPQtlosTzEqgZ6lZXB1vky5n1Pc8pMk4cNuW3xZtApj/SQcP4VOzGKSGwnWCkIetNnovbLtwzdKNwZ39HvenTE4AzDUUAFcrt/m67/V8fFQGX4ZVtnxnLme9ChcxFJmYR9QipT8UHgxMkD4r2X7AvUEtUIiE6ocgBOO9do3KLj9gaf+/niZuVZuZNR9qB0LBZAWYvACvmO/Y2+Wgndo827n360h8GMBOSf25t9wZqU2wyk8aAgRhtdl2SgCdVJn+RrqOXYCkqeu1Qa3aZhwPPulymew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNM0xviasaFvj1POjlatgjnYR72qDbFK/l37Nu61C2o=;
 b=q8XJkF32hxtWnRTlWPMvw/HZ4pBlsBvZ6lYHCF+3TXdrlVTIR114+cekdpLFR5c5L2Zop6tOf2H3v9coLKScw4Af1whcQdscfs4AudTgjULnPCBOaMstQ/2BcL5UvA3tpGmwXMGDXKHg3cApue31KKgGZuZSEYAs8AV5NN1qQxU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 27 Mar
 2020 03:42:59 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2835.021; Fri, 27 Mar 2020
 03:42:59 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/9] drm/amd/powerplay: avoid calling Vega20 specific SMU
 message implemention
Date: Fri, 27 Mar 2020 11:41:36 +0800
Message-Id: <20200327034138.7653-7-evan.quan@amd.com>
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
 Transport; Fri, 27 Mar 2020 03:42:58 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 61d152f3-f650-4c38-4b09-08d7d200f1c4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:|MN2PR12MB4373:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB437355F06FB47B6EF0E4EA9BE4CC0@MN2PR12MB4373.namprd12.prod.outlook.com>
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
X-Microsoft-Antispam-Message-Info: U4Pizb62UYiCPekSpLM9ptOpTO0dtJZ0/3ELd/oLCXNaTsC7T5Zfagcp/GCMoCc/8YWp2Gbzz1faCutCAGuPGNfywLeRgSvEpYsczDdIy1prcbRAKhlXH8Yuy7cYkonxBwhpESN39LoQOOJ59yoJ54H+ZO68vrKIwgzx82bBbIcWDNy4z8NmbQQCk7gRLQ35jQaefrRdi9UOXHu1OAwkwH9NGYO1zmzaxoqXhmmAot8Sx//n/geZ0vNtIB6dtTm4j3ituGeX3weU8AffQTY1BcN1rpNc1gq3wKJ/0B4CReLh0g+DPEtxuNWWJdLMw9M0goOh98whf2YJ94kMFoDFbCW+WGOVY9c2nTZTw8lWT0s18ZWsdoIKNYi8j8UuR8w2YudbqlEC4TlZM/8IJ0biMfZQo2ZWmzen6ik6L8IOfb4ViZjjj7Sj5F2QhO1GnQSY
X-MS-Exchange-AntiSpam-MessageData: DT9tNvY+hz/yCPixq9ZtUO9gdSoSLz8gNPYdIvbmdghyw+8LfGX3WO5cOxGx/ePit2L3vxTD7JfOdALq3MWcSmgVNh99vbLp5py8T+ukWbC8/ElWzUFfmiQ+K1fJ8DIM9Amy0E4gT2dSJr10jRmrZQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d152f3-f650-4c38-4b09-08d7d200f1c4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 03:42:59.7348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/f0NB9WBqZC2z18Ao7xvxNf2XNhOdNDZrwYWzh2OJFLlDA9pH7OHkJYgh9AXfRs
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

Change-Id: Ie5656cdc036cc21c6cc079bce2a43b05f3e167a8
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/powerplay/smumgr/vega20_smumgr.c  | 48 +++++++++----------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
index 16aa171971d3..2a9bf78e32bd 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
@@ -175,17 +175,17 @@ static int vega20_copy_table_from_smc(struct pp_hwmgr *hwmgr,
 	PP_ASSERT_WITH_CODE(priv->smu_tables.entry[table_id].size != 0,
 			"Invalid SMU Table Length!", return -EINVAL);
 
-	PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
+	PP_ASSERT_WITH_CODE((ret = smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrHigh,
 			upper_32_bits(priv->smu_tables.entry[table_id].mc_addr))) == 0,
 			"[CopyTableFromSMC] Attempt to Set Dram Addr High Failed!",
 			return ret);
-	PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
+	PP_ASSERT_WITH_CODE((ret = smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrLow,
 			lower_32_bits(priv->smu_tables.entry[table_id].mc_addr))) == 0,
 			"[CopyTableFromSMC] Attempt to Set Dram Addr Low Failed!",
 			return ret);
-	PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
+	PP_ASSERT_WITH_CODE((ret = smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_TransferTableSmu2Dram, table_id)) == 0,
 			"[CopyTableFromSMC] Attempt to Transfer Table From SMU Failed!",
 			return ret);
@@ -224,17 +224,17 @@ static int vega20_copy_table_to_smc(struct pp_hwmgr *hwmgr,
 
 	amdgpu_asic_flush_hdp(adev, NULL);
 
-	PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
+	PP_ASSERT_WITH_CODE((ret = smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrHigh,
 			upper_32_bits(priv->smu_tables.entry[table_id].mc_addr))) == 0,
 			"[CopyTableToSMC] Attempt to Set Dram Addr High Failed!",
 			return ret);
-	PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
+	PP_ASSERT_WITH_CODE((ret = smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrLow,
 			lower_32_bits(priv->smu_tables.entry[table_id].mc_addr))) == 0,
 			"[CopyTableToSMC] Attempt to Set Dram Addr Low Failed!",
 			return ret);
-	PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
+	PP_ASSERT_WITH_CODE((ret = smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_TransferTableDram2Smu, table_id)) == 0,
 			"[CopyTableToSMC] Attempt to Transfer Table To SMU Failed!",
 			return ret);
@@ -255,17 +255,17 @@ int vega20_set_activity_monitor_coeff(struct pp_hwmgr *hwmgr,
 
 	amdgpu_asic_flush_hdp(adev, NULL);
 
-	PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
+	PP_ASSERT_WITH_CODE((ret = smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrHigh,
 			upper_32_bits(priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].mc_addr))) == 0,
 			"[SetActivityMonitor] Attempt to Set Dram Addr High Failed!",
 			return ret);
-	PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
+	PP_ASSERT_WITH_CODE((ret = smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrLow,
 			lower_32_bits(priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].mc_addr))) == 0,
 			"[SetActivityMonitor] Attempt to Set Dram Addr Low Failed!",
 			return ret);
-	PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
+	PP_ASSERT_WITH_CODE((ret = smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_TransferTableDram2Smu, TABLE_ACTIVITY_MONITOR_COEFF | (workload_type << 16))) == 0,
 			"[SetActivityMonitor] Attempt to Transfer Table To SMU Failed!",
 			return ret);
@@ -281,17 +281,17 @@ int vega20_get_activity_monitor_coeff(struct pp_hwmgr *hwmgr,
 	struct amdgpu_device *adev = hwmgr->adev;
 	int ret = 0;
 
-	PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
+	PP_ASSERT_WITH_CODE((ret = smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrHigh,
 			upper_32_bits(priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].mc_addr))) == 0,
 			"[GetActivityMonitor] Attempt to Set Dram Addr High Failed!",
 			return ret);
-	PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
+	PP_ASSERT_WITH_CODE((ret = smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrLow,
 			lower_32_bits(priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].mc_addr))) == 0,
 			"[GetActivityMonitor] Attempt to Set Dram Addr Low Failed!",
 			return ret);
-	PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
+	PP_ASSERT_WITH_CODE((ret = smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_TransferTableSmu2Dram,
 			TABLE_ACTIVITY_MONITOR_COEFF | (workload_type << 16))) == 0,
 			"[GetActivityMonitor] Attempt to Transfer Table From SMU Failed!",
@@ -316,20 +316,20 @@ int vega20_enable_smc_features(struct pp_hwmgr *hwmgr,
 	smu_features_high = (uint32_t)((feature_mask & SMU_FEATURES_HIGH_MASK) >> SMU_FEATURES_HIGH_SHIFT);
 
 	if (enable) {
-		PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
+		PP_ASSERT_WITH_CODE((ret = smum_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_EnableSmuFeaturesLow, smu_features_low)) == 0,
 				"[EnableDisableSMCFeatures] Attempt to enable SMU features Low failed!",
 				return ret);
-		PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
+		PP_ASSERT_WITH_CODE((ret = smum_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_EnableSmuFeaturesHigh, smu_features_high)) == 0,
 				"[EnableDisableSMCFeatures] Attempt to enable SMU features High failed!",
 				return ret);
 	} else {
-		PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
+		PP_ASSERT_WITH_CODE((ret = smum_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_DisableSmuFeaturesLow, smu_features_low)) == 0,
 				"[EnableDisableSMCFeatures] Attempt to disable SMU features Low failed!",
 				return ret);
-		PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
+		PP_ASSERT_WITH_CODE((ret = smum_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_DisableSmuFeaturesHigh, smu_features_high)) == 0,
 				"[EnableDisableSMCFeatures] Attempt to disable SMU features High failed!",
 				return ret);
@@ -347,16 +347,16 @@ int vega20_get_enabled_smc_features(struct pp_hwmgr *hwmgr,
 	if (features_enabled == NULL)
 		return -EINVAL;
 
-	PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc(hwmgr,
+	PP_ASSERT_WITH_CODE((ret = smum_send_msg_to_smc(hwmgr,
 			PPSMC_MSG_GetEnabledSmuFeaturesLow)) == 0,
 			"[GetEnabledSMCFeatures] Attempt to get SMU features Low failed!",
 			return ret);
-	smc_features_low = vega20_get_argument(hwmgr);
-	PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc(hwmgr,
+	smc_features_low = smum_get_argument(hwmgr);
+	PP_ASSERT_WITH_CODE((ret = smum_send_msg_to_smc(hwmgr,
 			PPSMC_MSG_GetEnabledSmuFeaturesHigh)) == 0,
 			"[GetEnabledSMCFeatures] Attempt to get SMU features High failed!",
 			return ret);
-	smc_features_high = vega20_get_argument(hwmgr);
+	smc_features_high = smum_get_argument(hwmgr);
 
 	*features_enabled = ((((uint64_t)smc_features_low << SMU_FEATURES_LOW_SHIFT) & SMU_FEATURES_LOW_MASK) |
 			(((uint64_t)smc_features_high << SMU_FEATURES_HIGH_SHIFT) & SMU_FEATURES_HIGH_MASK));
@@ -371,11 +371,11 @@ static int vega20_set_tools_address(struct pp_hwmgr *hwmgr)
 	int ret = 0;
 
 	if (priv->smu_tables.entry[TABLE_PMSTATUSLOG].mc_addr) {
-		ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
+		ret = smum_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_SetToolsDramAddrHigh,
 				upper_32_bits(priv->smu_tables.entry[TABLE_PMSTATUSLOG].mc_addr));
 		if (!ret)
-			ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
+			ret = smum_send_msg_to_smc_with_parameter(hwmgr,
 					PPSMC_MSG_SetToolsDramAddrLow,
 					lower_32_bits(priv->smu_tables.entry[TABLE_PMSTATUSLOG].mc_addr));
 	}
@@ -389,12 +389,12 @@ int vega20_set_pptable_driver_address(struct pp_hwmgr *hwmgr)
 			(struct vega20_smumgr *)(hwmgr->smu_backend);
 	int ret = 0;
 
-	PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
+	PP_ASSERT_WITH_CODE((ret = smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrHigh,
 			upper_32_bits(priv->smu_tables.entry[TABLE_PPTABLE].mc_addr))) == 0,
 			"[SetPPtabeDriverAddress] Attempt to Set Dram Addr High Failed!",
 			return ret);
-	PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
+	PP_ASSERT_WITH_CODE((ret = smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrLow,
 			lower_32_bits(priv->smu_tables.entry[TABLE_PPTABLE].mc_addr))) == 0,
 			"[SetPPtabeDriverAddress] Attempt to Set Dram Addr Low Failed!",
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
