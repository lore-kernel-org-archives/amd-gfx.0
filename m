Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B281C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 09:12:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A56B464F18
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 09:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56B464F18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E2396E9B9;
	Fri, 19 Mar 2021 09:12:30 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690074.outbound.protection.outlook.com [40.107.69.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ED306E9A2
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 09:12:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gl+JZqV6yzVgD9MdgenFlcGpvZKjMGSKVagehSovCQVgzVcNRBhOO4kj1IdHbSum2YZU0B2GHhbioqDwymB/CFMT5AAjkuUfq4i6jMLLV7FZxzpZs55lLRyIYjjjnj3A0Wjl87FERZ+Zlgsc5RR7vKSNZqOlYy0LHM5pLRkTT+wwGTsLtRJaE8ckOM00MVKtX6C4TFlNE0i7j48874hqa6Gea71H8qDkVr8E0xmEN4uvraLDo1UUhBvfCR1GTZYaSkCrzDDBBdJxd8ET7sueqqPbwe/xw+sbJ/Xk85GkMjKlb/xtqXXJphTJJAIbUOIhp6VA07CvVhtBAwCX5U1oWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWJQnGre7vBnvrwAzNo6SVR7rqFVQ2ga3xv7p7muzI0=;
 b=aKFNqHTWoguuaLwU1jMDyLqh/r1oY3Xx4b3jKOFJEa7GCRHHLctuWH4UIaf7+n63wf3I8MyerPzi8ZmIbSk9epaQXx+NtbFRsF6lMSmH6n6HhC5ZviCwoWFl8Wyfb5S2jEkb/So4Wbk76H9D6zSQUBiuEZgLc7VphKb+QcDguRDZLyGsImOeHiZhesqXmGhHvbrAcEgo4YKHsNFY9KzlprKbaoH37Vvy3HHwFO0iQjipQ5TlFyJwg73Ny1HyCdpllK2Zijd/XtO2kHkNwkzLmN4Kowqg5Iy1kfW4XJvC7jJvPZ3a/qU6S/OSoQ0r/2bAHdDP++MBaudBa8afeLqbPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWJQnGre7vBnvrwAzNo6SVR7rqFVQ2ga3xv7p7muzI0=;
 b=utjPcQUkJMLhg5fXuEmDKZkdXPqHsNlv47li7QOfasoKLOoius4zqk4+4JYCjBlRVTq+1DDa66jVGhNdM+h70Sc4crqMse/TmwmlUnO2CrinJPJppehEaHLSMs8SKSlI6FNmg8thR3xSriU6z73dvX6MfbVHAn75dfS/1Vx31aI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4987.namprd12.prod.outlook.com (2603:10b6:5:163::31) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Fri, 19 Mar 2021 09:12:27 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3933.032; Fri, 19 Mar 2021
 09:12:27 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: drop redundant and unneeded BACO APIs
Date: Fri, 19 Mar 2021 17:11:54 +0800
Message-Id: <20210319091155.537787-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR0401CA0007.apcprd04.prod.outlook.com
 (2603:1096:202:2::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR0401CA0007.apcprd04.prod.outlook.com (2603:1096:202:2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Fri, 19 Mar 2021 09:12:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5aabe563-425e-4727-1185-08d8eab71ddd
X-MS-TrafficTypeDiagnostic: DM6PR12MB4987:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB49877699AE21069A3D338F36E4689@DM6PR12MB4987.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LtQAAT8g+lxMeexAAPmrjT7142tV2EMIL6UYmk5vI2mVdtjAJtWCDYiWjC6q+jkwru8/0nv2VIVNpOlIw7fNZgv4nbiIyKuIx+Xy4NBSaTRfdFA1VGjTVTfHL1E97KDgiRZjuvCyvm/IZrcWDuqGs2FREsBYdabumgogH5oVYbRIXP/gM7mglq27T4Zr/dZwe5F4nTClC3/O+qD4Lrcj6539zWyYJo/9UGiwxIFcpOCJO8cYoASvUstFNiOvYryJJOmDi9xag5bgzc/gw4Iya3fNnJaD378sRjfkJFs9ebV5hidaAq1V74LVa+D8T/W9qwLPRybH2YdYL1h0AZQC6q26sylPnzSaOGVFRNFGxEXEYtjIwWb6xMJZF65cJS5djBUDSpHDW2AuZ+NXdN4ypSQ5hetXxl6aONWAs+ojY05eHrg34pTnqPJRe2vSuCxWFefQCMEMF1PrHXmNLu8cbg23+d/Pzlcer1HUVYyWso6OiikMAU6Up1MB/7dXG/W6LiHcq+Vmth+qXpXg+4fKi/f58qWDJ2wZGuWmQ6kofvN1NfIRcmFRbD1Wo7TSJIiY19JVUz2MbJCcYC4ZuzSmIsrpDTwJJTKvCZHTWzzu52/r7J3VJX97DT9sDpXOGpnL9UnglcDJSacOKzlf4v3ptiPeGbCUubVBab7DXWu5Pys=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(66946007)(8936002)(66556008)(316002)(44832011)(1076003)(4326008)(26005)(38100700001)(186003)(6666004)(66476007)(16526019)(36756003)(2906002)(6916009)(956004)(8676002)(86362001)(83380400001)(7696005)(52116002)(2616005)(5660300002)(478600001)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?q/eo7nS/QSZyXmAbZwi7s4MehqdVpB2aaSSvcC43m3RQ47Wt8xB7RfPvFkrG?=
 =?us-ascii?Q?hk4b419WYVnKdKqgBq8oGNn9Ix6DA5sDnwq7rOQGzwxVve8Eun/qLVSkbYy+?=
 =?us-ascii?Q?QPlJrRH0s8wNVU7gD9DRVmPthmOccNy8nuQ5X158TjG6kL/L73G0TwkrJsg+?=
 =?us-ascii?Q?lsbNGNCJ5LtS36x+KY91ZUk+GMNOuys0mbUeZdbIUVaYa3Lk3ZieKuo9vLt7?=
 =?us-ascii?Q?OltCuHHFw3IKQi/G9g9fHyArNvHuAmosxj9u6Q2A5A+rZTY8sjHFncIBcYS4?=
 =?us-ascii?Q?p67p6zOuc7lpFWn0ytlZCSRbKTcCpkLlILpEFmYplyi1ZyIrZKgVFDyc6nGD?=
 =?us-ascii?Q?d3P4y/uDV/mq4PxztLjLNQTCogUpjAUhnRu+BEZruJYkoZstJBJMmxQrG6Db?=
 =?us-ascii?Q?VotM1VYy3a1rPjyDgfQKY4xQ0smH+dyt7cUG+nmUJeHso3YoIX6Caw+BH4RM?=
 =?us-ascii?Q?mT7tW3rFJvCk4ot+3DEWgtnafSq+g47GvIQeFpBJ2kglIBnQ+Qylr1pRO0Oo?=
 =?us-ascii?Q?dGIUh3wV2lEHGDekjUuetdXA08IxMuRYlxGFEGR2oQlNNYOFCCZ6LCsG+dhJ?=
 =?us-ascii?Q?cDd0L7td8h5+pNPQzCEBlRB56JKtI0+xw4BvlKN6+b14gQJHH1sVfF6TB6uK?=
 =?us-ascii?Q?qt/mjFvfRWkD9erqQxg91lHNkymixUbiM6uC3Xp5bB1l0pFshkCcH+ROxxXd?=
 =?us-ascii?Q?IY4L6gxb08DbGD/8mdj8OlJ5cFmUho7nUs27UojhP6y1HRXlod0+N33vulrk?=
 =?us-ascii?Q?D9PJV6Iq99CHyUGeO0jcKaLkGJI422iW/KOB+Ai4kED2yrpt1FECB1xaBkT2?=
 =?us-ascii?Q?kefi594bIlsXeyCDqUSrxUBhcqcNxKtINlJU2Jz5xLiPeD0VoLR2SpQx0cho?=
 =?us-ascii?Q?qRDO/77wg/eSMQUgTSaQlZfX7IqVw+EFMpsaZNvfBnKUUnSlJSUngH0jzCig?=
 =?us-ascii?Q?tzHjMTDy+n4bG0MFBLi9yarW5YBHesVj1PbVfhBGu64MXoWIsVFjygQyPbt6?=
 =?us-ascii?Q?BAF/u1FkOpKL3mg6u1vuCb08HsTDrqBWnz7GvXB2Z8urLzkjFvRsNyvN2OcC?=
 =?us-ascii?Q?dkycjnpI4xZ1Z1DKiUsewS1sMWYzeUZCVktj1nO6OmnobVuJ/DzHf2YiZkX8?=
 =?us-ascii?Q?nrZOnp3hJbjHFXCVyMxOhnEbbHwszrnQ1Tk5A1CYZkc6HI75JxcjhUtbe/Qv?=
 =?us-ascii?Q?h4AoikS6F9mYfi30RXxJxdalBTC2EJWznSe0gyQU+EBFiPy7uIr9Or4hDRx6?=
 =?us-ascii?Q?gBOHaHGhVjqetKGGfPSQAtJpZm6CoNSka0Bm6M/2xHdoC3gxY8Q6e26Gpowj?=
 =?us-ascii?Q?jcVY7kZFmhlq7nhkvovogXjg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aabe563-425e-4727-1185-08d8eab71ddd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 09:12:27.6225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/IGxia7PMrwnib0Puc/WQzIkHr3qOtRgd43NmpaJuejYPu6EufdWHsBr9DMujkH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4987
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

Change-Id: I5e9e0ab5d39b49b02434f18e12392b13931396be
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c           | 20 +----
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  9 ---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 95 -----------------------
 3 files changed, 3 insertions(+), 121 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index e9cc3201054f..2670ae00c2e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -517,19 +517,12 @@ static int nv_asic_mode2_reset(struct amdgpu_device *adev)
 
 static bool nv_asic_supports_baco(struct amdgpu_device *adev)
 {
-	struct smu_context *smu = &adev->smu;
-
-	if (smu_baco_is_support(smu))
-		return true;
-	else
-		return false;
+	return amdgpu_dpm_is_baco_supported(adev);
 }
 
 static enum amd_reset_method
 nv_asic_reset_method(struct amdgpu_device *adev)
 {
-	struct smu_context *smu = &adev->smu;
-
 	if (amdgpu_reset_method == AMD_RESET_METHOD_MODE1 ||
 	    amdgpu_reset_method == AMD_RESET_METHOD_MODE2 ||
 	    amdgpu_reset_method == AMD_RESET_METHOD_BACO ||
@@ -548,7 +541,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 	case CHIP_DIMGREY_CAVEFISH:
 		return AMD_RESET_METHOD_MODE1;
 	default:
-		if (smu_baco_is_support(smu))
+		if (amdgpu_dpm_is_baco_supported(adev))
 			return AMD_RESET_METHOD_BACO;
 		else
 			return AMD_RESET_METHOD_MODE1;
@@ -558,7 +551,6 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 static int nv_asic_reset(struct amdgpu_device *adev)
 {
 	int ret = 0;
-	struct smu_context *smu = &adev->smu;
 
 	switch (nv_asic_reset_method(adev)) {
 	case AMD_RESET_METHOD_PCI:
@@ -567,13 +559,7 @@ static int nv_asic_reset(struct amdgpu_device *adev)
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
