Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB534C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 06:11:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 842236191F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 06:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 842236191F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F18976E0A0;
	Mon, 22 Mar 2021 06:11:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65A456E0A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 06:11:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpkYKWBZqTVDFY81wajwt8o22UpUJRRKdVaOcM34xFJRhwFi5o7CUCmrx0UQUkra24jegjlGC0qmSdTXhTy9E+yCfNS7MYfvN8fi6o4t5G6xNeCes/Dhs1ytLpaoVgHnfex6cm+4z+JWvMkjITUHLsYk5YTgD7Jf5bl7TFcFu+OQlztb4TPJ8vVRLK76SVEXR8bmCmIorhnO1bd8DWs+6fE+5R2IsljYWUdSroS30pmoKroll14sGir+N2e0fvg5clvpCA11f1si9K/IozlP+PiPIADTNwBHMcaSSTc20SPDO3fbS4YK96FMTVSWkEVB2QP1kgtVg7a41X+hiWu3cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgPe/0V5mRNByUX+PSxfYDImMQbc3CoQflKVvVgJ+VQ=;
 b=DeWPgCo2fQIWgb6Xp2uSPelpdm9T2klYEjxBMdMDwgowJ882GcP3GeRveNuecUZC8sE9Zj+byByUgtQ3Nabq/HsyrjCc7IesnDPOsdgNv8fuA+Peq9GXPo8MEmKhbcq2lAmdcE2VVKL1Ckjj4SBiTgI/7quYocv3VxBn8gWtvfTmhE6FD+YWyid5o8P4b9k1lOeA18SuyYdEDP1LOYh7ukr/gornH3aKNZX8bmkGFYqwVC3Nn/yHbjyuHk8rI1xI9F4w+tsARu2YZp1VR55QoszS6DQgEB/+Nw6YkpceiEwYel5KzkXbyFL+AbQzVMxOcY2NJSxaoK90koRxD+FC7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgPe/0V5mRNByUX+PSxfYDImMQbc3CoQflKVvVgJ+VQ=;
 b=BD75P/Xju/sv8hga1dW2Y5qBLm+ZwOKD3oZE0VfGxeSN1zJZvlPRIFXnRZW9vieHpduO2rN9bHDD+lrITjrlo9NITxifHdPIrP7py45LDkqJ71EY7mj74wUssaJwHhXmwlF4B1eqqI58GH6Uzh9IJ8TYYsm2PSeDN/skwMMP+pc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3081.namprd12.prod.outlook.com (2603:10b6:5:38::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.24; Mon, 22 Mar 2021 06:11:29 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 06:11:29 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: drop redundant and unneeded BACO APIs V2
Date: Mon, 22 Mar 2021 14:11:10 +0800
Message-Id: <20210322061110.594178-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR04CA0074.apcprd04.prod.outlook.com
 (2603:1096:202:15::18) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR04CA0074.apcprd04.prod.outlook.com (2603:1096:202:15::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 06:11:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 411d4ce3-5de6-4650-0bf8-08d8ecf9551a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3081:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB308183EBA429E18CA857FCC5E4659@DM6PR12MB3081.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F1vm3smXq21AuxiKBQGz4A7FeYU86yOLhZEFGCBN3Nl2wHejT2kccdDwClg52abkX2+44qFa2TnFMZ45QiPZQSz5sr7QWQTDejzwVtSOKkmZfF4mVIK/Iz887f2cI8dVPDDiNJoHnhf7Z7ghIND3xsYe4tP0Bisw2/vLkfWBTpg5/s09sz0285EWgTTB28gguFvENuZypWpHT6E76TJ+Ow6N/GnrA9o3dfm9PmhQSjgyK2PFRivbN3fLNu2VLPgPcqfx6aMcvkfRfAA3GqJ3hq+IkyioPs/FrBaFXFbwJ3g++CPs1SYb6+sIG4KiUSDmeZp3i4/hnZfZHwPvq9/3yb93g0UBragGmle3h+k3QWxnjaveKQ6U8OCDz58h01hoYIgddCCLPxQYVmXpFN5w2fulzncqu/GrqpoxhrbNd0VSPSSyKFBpAIYAGJqUpwWiyI/9vX0SbnQ2+4B9YG1PtlxykBvr6t/HrBcppMlRN/2XdAtweAapnm24QjyC415MB9hLcWQtQFKPh+MQ1hywvPJ1qi5Ef6brHK8cy9RGueQ42vbX5XG246qsisp0CKe7N7aC2jkSFTM/vAR/gEzneOA8Pai437Jn7YB2ROeRiO5gF2DtcFzm8wOLnCvMpZuShIiEphcl/eiH2hMrAHwd+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(6486002)(38100700001)(83380400001)(6916009)(478600001)(7696005)(2906002)(86362001)(52116002)(186003)(316002)(26005)(6666004)(16526019)(44832011)(66556008)(8676002)(66476007)(66946007)(956004)(2616005)(1076003)(8936002)(36756003)(5660300002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7r4Hn1Fr7uZGNTFxe5ZQ4odafZmHY6gYznxJcueQiES9JbnTnWrFPEiBxQzz?=
 =?us-ascii?Q?ll9FdVwss/JvLfTiMmzBJZJ1jkAQCOp0o2GisdGyWhP64hNOeT/sV9bZLnUv?=
 =?us-ascii?Q?Q9od5jIV6xG+wZMoQeU7+dGT02R01DoldIPtu14Rg44JFNsN54FMBFKBinTc?=
 =?us-ascii?Q?oqPsFlfAkn8Txe86zu13//iAiifNBYj1HNxFDrovbYfebie9l7AFUYPmvL+3?=
 =?us-ascii?Q?muNMs2Ahr5QnDQBY5iJolMJpcybwZlpxrk1IQfw2W1dHFdeWGVhbbBs7LDyD?=
 =?us-ascii?Q?e2B8KQly8st+JNdzVJoe01GQNXHt2wWHPStqeTg9O5Wnes93XDE1Rl0Ro0cT?=
 =?us-ascii?Q?PZKWd7f0JW2RAK6fzaI4/g6JODYfUzOGnUBWo6lIw8D1PiDTMcDoB4Cg5/5S?=
 =?us-ascii?Q?9K9vTprEu1QUFRfBo/lULkyrP5f9/OcozG4Z8veyeoGQ9u/yR8fGUnElppzi?=
 =?us-ascii?Q?Ebe9P+SCT7S1CvMX/2iWGobcnOdUXUAhRbaj6XrMSZWB5dG2jhxWlTQjMPM1?=
 =?us-ascii?Q?DUdrOaV4ZjEcOy414NfUM721dPRhJ/phZ2b8/rmrLY272loqYZeHClxgwfVd?=
 =?us-ascii?Q?Ga3RF5bvu4OZxoyBJXwKmrEKCgk1GZ5RxSQSSSe8DKnZbTnaW/z+v3AIiTow?=
 =?us-ascii?Q?pPiRk9j2oq5wDfUYEbR0zo+lDrMTf05MAbIcDIgHx8s/KYsWh80wrii4L4uT?=
 =?us-ascii?Q?6dQN4Cyeor4AMXE5q6bPKh+Rb3CUZXAZGex5RkX/rd0pX+FUutVMaCI/VuLh?=
 =?us-ascii?Q?vLTKYwJI5aA+vPZXSzj4DOkokTiTPrucxnyTfpFOz5R1nURgj9wN8YuuSQFx?=
 =?us-ascii?Q?lLDnjrfg00RBEvKnj+qurdyYXhKD4t/GUny+bXwA4c6nTMphWi9bJ0Tev6Fn?=
 =?us-ascii?Q?2aSVUZng/RxYBHuoDJPyveY2uWZ+PY21B7k9UUH7vP3HnyVm4syANlWbKirY?=
 =?us-ascii?Q?lZIofuFDn8HnZEiWHXtWdGQO+7dAcXCHAIEDQqhHp9KJ//We9KPEMwErfU6S?=
 =?us-ascii?Q?c6is+qMlVvZ1wOfb6Fu0alukPS15cHCOy5lh41CFflXEqbwnX263Z9xbUzy3?=
 =?us-ascii?Q?JGdU2ygDpWR/j6zJa6Q8Zdm6QZ6jfTmSr1a3jdSLCYEgFnIHWKAKrUpeRtUc?=
 =?us-ascii?Q?wh0yKWFQRZ6tMIwo4i2Jtz94oZ1CoqTNXPy4yavBBn8zvii5x5WrIoUtWMJc?=
 =?us-ascii?Q?/lfX7EujoXFOZn3yowWoSDCfEkbHhMptmY9BJ7+kapoVhxzTecBnbpENrW08?=
 =?us-ascii?Q?oyNUervUO0IbqAMHP+u2Pn9ZX0hLd03QHUI0AhHB9nVUBINEjprUro7LD1mk?=
 =?us-ascii?Q?h5n+KzaE0Tc9/Jw8mal/2K8q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 411d4ce3-5de6-4650-0bf8-08d8ecf9551a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 06:11:29.4066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlhAjhjwG7ijNvG2HrJkw9mQYY0BjFTxl9HllHDRAPo7Ym7z22winooPTOtCPVSE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3081
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

Use other APIs which are with the same functionality but much
more clean.

V2: drop mediate unneeded interface

Change-Id: I5e9e0ab5d39b49b02434f18e12392b13931396be
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c           | 25 +-----
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  9 ---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 95 -----------------------
 3 files changed, 3 insertions(+), 126 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index e9cc3201054f..46d4bbabce75 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -515,21 +515,9 @@ static int nv_asic_mode2_reset(struct amdgpu_device *adev)
 	return ret;
 }
 
-static bool nv_asic_supports_baco(struct amdgpu_device *adev)
-{
-	struct smu_context *smu = &adev->smu;
-
-	if (smu_baco_is_support(smu))
-		return true;
-	else
-		return false;
-}
-
 static enum amd_reset_method
 nv_asic_reset_method(struct amdgpu_device *adev)
 {
-	struct smu_context *smu = &adev->smu;
-
 	if (amdgpu_reset_method == AMD_RESET_METHOD_MODE1 ||
 	    amdgpu_reset_method == AMD_RESET_METHOD_MODE2 ||
 	    amdgpu_reset_method == AMD_RESET_METHOD_BACO ||
@@ -548,7 +536,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 	case CHIP_DIMGREY_CAVEFISH:
 		return AMD_RESET_METHOD_MODE1;
 	default:
-		if (smu_baco_is_support(smu))
+		if (amdgpu_dpm_is_baco_supported(adev))
 			return AMD_RESET_METHOD_BACO;
 		else
 			return AMD_RESET_METHOD_MODE1;
@@ -558,7 +546,6 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 static int nv_asic_reset(struct amdgpu_device *adev)
 {
 	int ret = 0;
-	struct smu_context *smu = &adev->smu;
 
 	switch (nv_asic_reset_method(adev)) {
 	case AMD_RESET_METHOD_PCI:
@@ -567,13 +554,7 @@ static int nv_asic_reset(struct amdgpu_device *adev)
 		break;
 	case AMD_RESET_METHOD_BACO:
 		dev_info(adev->dev, "BACO reset\n");
-
-		ret = smu_baco_enter(smu);
-		if (ret)
-			return ret;
-		ret = smu_baco_exit(smu);
-		if (ret)
-			return ret;
+		ret = amdgpu_dpm_baco_reset(adev);
 		break;
 	case AMD_RESET_METHOD_MODE2:
 		dev_info(adev->dev, "MODE2 reset\n");
@@ -981,7 +962,7 @@ static const struct amdgpu_asic_funcs nv_asic_funcs =
 	.need_full_reset = &nv_need_full_reset,
 	.need_reset_on_init = &nv_need_reset_on_init,
 	.get_pcie_replay_count = &nv_get_pcie_replay_count,
-	.supports_baco = &nv_asic_supports_baco,
+	.supports_baco = &amdgpu_dpm_is_baco_supported,
 	.pre_asic_init = &nv_pre_asic_init,
 	.update_umd_stable_pstate = &nv_update_umd_stable_pstate,
 	.query_video_codecs = &nv_query_video_codecs,
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 517f333fbc4b..02675155028d 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1285,15 +1285,6 @@ int smu_get_power_limit(struct smu_context *smu,
 			uint32_t *limit,
 			enum smu_ppt_limit_level limit_level);
 
-int smu_set_azalia_d3_pme(struct smu_context *smu);
-
-bool smu_baco_is_support(struct smu_context *smu);
-
-int smu_baco_get_state(struct smu_context *smu, enum smu_baco_state *state);
-
-int smu_baco_enter(struct smu_context *smu);
-int smu_baco_exit(struct smu_context *smu);
-
 bool smu_mode1_reset_is_support(struct smu_context *smu);
 bool smu_mode2_reset_is_support(struct smu_context *smu);
 int smu_mode1_reset(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 4120d28f782b..1bb0c0966e3d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2682,48 +2682,6 @@ static int smu_set_xgmi_pstate(void *handle,
 	return ret;
 }
 
-int smu_set_azalia_d3_pme(struct smu_context *smu)
-{
-	int ret = 0;
-
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
-	mutex_lock(&smu->mutex);
-
-	if (smu->ppt_funcs->set_azalia_d3_pme)
-		ret = smu->ppt_funcs->set_azalia_d3_pme(smu);
-
-	mutex_unlock(&smu->mutex);
-
-	return ret;
-}
-
-/*
- * On system suspending or resetting, the dpm_enabled
- * flag will be cleared. So that those SMU services which
- * are not supported will be gated.
- *
- * However, the baco/mode1 reset should still be granted
- * as they are still supported and necessary.
- */
-bool smu_baco_is_support(struct smu_context *smu)
-{
-	bool ret = false;
-
-	if (!smu->pm_enabled)
-		return false;
-
-	mutex_lock(&smu->mutex);
-
-	if (smu->ppt_funcs && smu->ppt_funcs->baco_is_support)
-		ret = smu->ppt_funcs->baco_is_support(smu);
-
-	mutex_unlock(&smu->mutex);
-
-	return ret;
-}
-
 static int smu_get_baco_capability(void *handle, bool *cap)
 {
 	struct smu_context *smu = handle;
@@ -2744,59 +2702,6 @@ static int smu_get_baco_capability(void *handle, bool *cap)
 	return ret;
 }
 
-
-int smu_baco_get_state(struct smu_context *smu, enum smu_baco_state *state)
-{
-	if (smu->ppt_funcs->baco_get_state)
-		return -EINVAL;
-
-	mutex_lock(&smu->mutex);
-	*state = smu->ppt_funcs->baco_get_state(smu);
-	mutex_unlock(&smu->mutex);
-
-	return 0;
-}
-
-int smu_baco_enter(struct smu_context *smu)
-{
-	int ret = 0;
-
-	if (!smu->pm_enabled)
-		return -EOPNOTSUPP;
-
-	mutex_lock(&smu->mutex);
-
-	if (smu->ppt_funcs->baco_enter)
-		ret = smu->ppt_funcs->baco_enter(smu);
-
-	mutex_unlock(&smu->mutex);
-
-	if (ret)
-		dev_err(smu->adev->dev, "Failed to enter BACO state!\n");
-
-	return ret;
-}
-
-int smu_baco_exit(struct smu_context *smu)
-{
-	int ret = 0;
-
-	if (!smu->pm_enabled)
-		return -EOPNOTSUPP;
-
-	mutex_lock(&smu->mutex);
-
-	if (smu->ppt_funcs->baco_exit)
-		ret = smu->ppt_funcs->baco_exit(smu);
-
-	mutex_unlock(&smu->mutex);
-
-	if (ret)
-		dev_err(smu->adev->dev, "Failed to exit BACO state!\n");
-
-	return ret;
-}
-
 static int smu_baco_set_state(void *handle, int state)
 {
 	struct smu_context *smu = handle;
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
