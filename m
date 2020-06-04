Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76813C433E1
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:46:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C5892072E
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GBlKuaCA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5892072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 932CA89FA0;
	Thu,  4 Jun 2020 04:46:51 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1343489FA0
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 04:46:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmjO7Rh5I7xoCAWWXJN/NFKCECscO4HBFkNERxKZR+TBsaekU3ulQ4iKiXbMsq2Dc7IgEvTszL0+CR6fTPpKcV0k52QiKYcpCO4rteDbV8qEslMzwar3DTtDp94uhCnvz7ThWep8wrRdHOS/8KB0fS4an803+84b2TNfigcnosaWFinMSdedUq79FAJvu1xxszBryPYmKj1ds64cH49NHm3fdn5KnWaGRzSPTEz7LaGfp4RiQGjy7vN+DOPGYK7AnTDAc76nFs3LFqiF8QcSf+8FR1hJk3kzjAkS58ZpGXnFi+VSqpsPqeRu/fBOtVPHWh2OyO2B4exzgeYlR85tMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dV6+tt031sRJIlFQYOYAMCJDvERMnuzlo1biIX581dA=;
 b=TbxVvFgcJw/55yG+Mwjd9W7iBAkNuzpsCF0zdwhx7KZRlY1hQP5JlohM9WGOZURIRlnLYneRDNfc5bX8yun2GfE7Zbd4UVV6KF+/uKLjFUp5pZb+MjsUBUFZARu2BDE5gto3rtLKFH7ZMe6eBu5WfevlW1NaEa8Fj7bVFkc6BreYUJjPQ4Y8Kp+ikgwtnEC1yrsgHHVh2cddG/hTxF41BRI4nTEH2GqVFX/kBhvOjNu/v/A9/zfDrr3vlM4v2jtZoDiOZH+CcKU4sL2O2r0q56WdhQ6FX41RWltRC2gLbx3IU31cFXY3tRcn5kIMcbd/4GYrhNo5tC/vegXvfuK/Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dV6+tt031sRJIlFQYOYAMCJDvERMnuzlo1biIX581dA=;
 b=GBlKuaCAYvbLjubfeYxxyRMExg/DjCVIH5LlijalxlzswKgf9MMBOK19T6NUDGoK82S0Nn2Ee/8HgUfjVvR/rCbhuIIHZTeW6P9LhZvFF6jZ+BYVfkY/oIgReaUh4HyqcG3ABszF0qIQcObe1MbYsyz/gloqVmxdcgyQMTBlt9M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3002.namprd12.prod.outlook.com (2603:10b6:5:117::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Thu, 4 Jun 2020 04:46:50 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Thu, 4 Jun 2020
 04:46:49 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/16] drm/amd/powerplay: drop unused APIs and unnecessary
 checks
Date: Thu,  4 Jun 2020 12:46:05 +0800
Message-Id: <20200604044619.18658-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200604044619.18658-1-evan.quan@amd.com>
References: <20200604044619.18658-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR01CA0071.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::35) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK0PR01CA0071.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Thu, 4 Jun 2020 04:46:48 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d2075769-84ef-43d8-3bf3-08d808424b45
X-MS-TrafficTypeDiagnostic: DM6PR12MB3002:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB30028E8EE0B6DC255E2C2977E4890@DM6PR12MB3002.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:159;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +2wtsPKDm5Rhvw8m3PERF9sZcgoZxzDisrBrv5OKm4+DzFib5tVZvxoeN+//COLGDq7bG0hLfzg865HHUE905FXTKr+brLUAvTxmUDjIianqJLggsQLM/Ul/yPxsmcUbNGXGoWt32hPQdKDA+7RW8HGwtDwxbHnEizw6o6DPsdEjhJWj2tx8WxL8yhV96t34peizR7//FGnw989ykv20+oUUKc0/unPa59oM/Pl9pCxBojGCL90XoDyblT8eeLFuRf6Y2Fm1vIDctQC9V5AmEdYOhO3fz1OzsqxWkGt0VPZKQIKaGMfJ/dERB9ZMpM/ClCmrrQM3sx0TY//ztQ212g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(7696005)(1076003)(52116002)(36756003)(2616005)(26005)(316002)(16526019)(83380400001)(6666004)(6486002)(86362001)(5660300002)(186003)(956004)(6916009)(4326008)(66946007)(2906002)(44832011)(8936002)(66476007)(66556008)(478600001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: QNuNFJQAT//r5HdkH1PtLLItQxafyptUPVGBaoHbC78X2aEeAHPm6gGBKhUmUXxj5Cx7T9ondOk9jTta4dRcsh5BHeUMAJAO38ajvoqNv7v6q+vYovCthDr0VuuO9u8WPvK/kWs3g6I8KCxL+JB/F1Y73s/fahJH+2r6G2H0dLgYQsKNMTtllOQDtHhl0ufh6a6ic5VM7N8c38i6FmnggAPed6b5m9mKj79PadAP7tLyzrt6omWRPekZg95U9f1ShXscL0Rh9idIy7eg5T2+epWM/UREBI35GGW1G9Dh7jIWe3L92pE+tYXAZOFNvj0OHSqC/XXXzWBQ5D9Q1Sy3z0GbZMttswhS3XiYTwc9Qp/MlDsM0Z834eMIINdva7ZN6KNOL2Ic1IOCBKiJjYl+6Xyi1bdtA3fx0hjwwyZImSLM2VD8TqosKFb0mspljTsoGW8SKS4T+gyDQGBOXI77Ru8ILefSwkwZ+euGOcSzk3UBiKpg8ev9SmrcZHlR6LKr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2075769-84ef-43d8-3bf3-08d808424b45
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 04:46:49.8246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vskgZarGnG1ZTKfYUUxGHj/XsdPiMKMBY5LcHu55M4FmzF24VhBEm7jZGtgw59A3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3002
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Minor code cleanups.

Change-Id: I6d240241e78cae17288c1d49dbae6ab1796b1128
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 74 ++++---------------
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  2 -
 2 files changed, 16 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index b2c1ad95edf7..bd0fe71dffde 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -720,30 +720,6 @@ int smu_feature_is_supported(struct smu_context *smu, enum smu_feature_mask mask
 	return ret;
 }
 
-int smu_feature_set_supported(struct smu_context *smu,
-			      enum smu_feature_mask mask,
-			      bool enable)
-{
-	struct smu_feature *feature = &smu->smu_feature;
-	int feature_id;
-	int ret = 0;
-
-	feature_id = smu_feature_get_index(smu, mask);
-	if (feature_id < 0)
-		return -EINVAL;
-
-	WARN_ON(feature_id > feature->feature_num);
-
-	mutex_lock(&feature->mutex);
-	if (enable)
-		test_and_set_bit(feature_id, feature->supported);
-	else
-		test_and_clear_bit(feature_id, feature->supported);
-	mutex_unlock(&feature->mutex);
-
-	return ret;
-}
-
 static int smu_set_funcs(struct amdgpu_device *adev)
 {
 	struct smu_context *smu = &adev->smu;
@@ -823,22 +799,10 @@ int smu_get_atom_data_table(struct smu_context *smu, uint32_t table,
 	return 0;
 }
 
-static int smu_initialize_pptable(struct smu_context *smu)
-{
-	/* TODO */
-	return 0;
-}
-
 static int smu_smc_table_sw_init(struct smu_context *smu)
 {
 	int ret;
 
-	ret = smu_initialize_pptable(smu);
-	if (ret) {
-		pr_err("Failed to init smu_initialize_pptable!\n");
-		return ret;
-	}
-
 	/**
 	 * Create smu_table structure, and init smc tables such as
 	 * TABLE_PPTABLE, TABLE_WATERMARKS, TABLE_SMU_METRICS, and etc.
@@ -1137,19 +1101,16 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 		return ret;
 	}
 
-	if (smu->ppt_funcs->set_power_source) {
-		/*
-		 * For Navi1X, manually switch it to AC mode as PMFW
-		 * may boot it with DC mode.
-		 */
-		if (adev->pm.ac_power)
-			ret = smu_set_power_source(smu, SMU_POWER_SOURCE_AC);
-		else
-			ret = smu_set_power_source(smu, SMU_POWER_SOURCE_DC);
-		if (ret) {
-			pr_err("Failed to switch to %s mode!\n", adev->pm.ac_power ? "AC" : "DC");
-			return ret;
-		}
+	/*
+	 * For Navi1X, manually switch it to AC mode as PMFW
+	 * may boot it with DC mode.
+	 */
+	ret = smu_set_power_source(smu,
+				   adev->pm.ac_power ? SMU_POWER_SOURCE_AC :
+				   SMU_POWER_SOURCE_DC);
+	if (ret) {
+		pr_err("Failed to switch to %s mode!\n", adev->pm.ac_power ? "AC" : "DC");
+		return ret;
 	}
 
 	ret = smu_notify_display_change(smu);
@@ -2138,15 +2099,12 @@ int smu_set_ac_dc(struct smu_context *smu)
 		return 0;
 
 	mutex_lock(&smu->mutex);
-	if (smu->ppt_funcs->set_power_source) {
-		if (smu->adev->pm.ac_power)
-			ret = smu_set_power_source(smu, SMU_POWER_SOURCE_AC);
-		else
-			ret = smu_set_power_source(smu, SMU_POWER_SOURCE_DC);
-		if (ret)
-			pr_err("Failed to switch to %s mode!\n",
-			       smu->adev->pm.ac_power ? "AC" : "DC");
-	}
+	ret = smu_set_power_source(smu,
+				   smu->adev->pm.ac_power ? SMU_POWER_SOURCE_AC :
+				   SMU_POWER_SOURCE_DC);
+	if (ret)
+		pr_err("Failed to switch to %s mode!\n",
+		       smu->adev->pm.ac_power ? "AC" : "DC");
 	mutex_unlock(&smu->mutex);
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 13fc5773ba45..210432187ceb 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -670,8 +670,6 @@ extern int smu_feature_set_enabled(struct smu_context *smu,
 				   enum smu_feature_mask mask, bool enable);
 extern int smu_feature_is_supported(struct smu_context *smu,
 				    enum smu_feature_mask mask);
-extern int smu_feature_set_supported(struct smu_context *smu,
-				     enum smu_feature_mask mask, bool enable);
 
 int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int argument,
 		     void *table_data, bool drv2smu);
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
