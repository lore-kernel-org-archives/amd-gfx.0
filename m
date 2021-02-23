Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60947C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 04:21:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D630560C41
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 04:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D630560C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6555289DC0;
	Tue, 23 Feb 2021 04:21:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2A4C89D67
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 04:21:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvH4p6h0byfiIoVkoNZEK2jrXYKvIhTIjGvRf+0M2r8NqgGXEXy2Qzl7iefd7XZrw7VimrYzOpwcNKLlTDQReryCI8E3NnvF8U3WGm6HBtoNvUpIQ9dMcCeFBdcPwUdKFnz4pJAftbg6V6fk2tPWE9Oy2l8cj2TIfY9Bv1uaRr+Nv+hVKq96F/FxHEfQvWbW+BLWpLqsV8D8i7aSTdZV5bqZ2Iy3Xp0f9t3dkpDu0GtjmrQIoKJ33Jr4Fn6QlPlsbrvgKb4yzB2st7I8hsC4iof6T6yL6SkeJeKVbJFJajEAE9/TEYgpHNUMbDiKNWVHA4VQIgTg3XnIDSKb9FGO5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mp18DmCGkP2ycn0G4mG7Ft20kfV9ChbkpAJd6WOeWXc=;
 b=n8PeN6fxJy3DmQud86hkfPoydlGAJUqWY47YVLqiUDt7CT4EsE0uYc4v82Yf+TAMukse9B4a+oTRh3qFpVN5+19bF/z1V0SW2lXZpWG20s4H/rNbpP+Mu0CMY94oHa89571GEQ5b9XoZKexlcVRZDFJzXtf6/LG4mT3ZGBUOFPbcobMRgYI05QOVtUlfXWWII70uwOTJVD4SjK2gPq6387DlksTi3xsOh836MghJA/FUxnl1XszFcjl82AOUwtry3wl5/7iMl4IgGDntWJ1F4ZXo+o9o/kUdbbvuu68QM7ohAn0e9i3MYAhCHtGoJRak0lGVxwljeAHrfGnXp3hITg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mp18DmCGkP2ycn0G4mG7Ft20kfV9ChbkpAJd6WOeWXc=;
 b=ljo0a45TGHDJwDoukgd6s+AeDRFmFkPdZT6TxHytdjSaGi4ndVxPQweVKP76sM87TYBKqLAixvB9SWQRMEW0z94hUh8FiJosJKg6n1aryQSgMQuApFxYFdoidqU5p7bbety/p9SWNbQltX9w92i9JFXbjYX2bW3bmK4HAy7P3tA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM6PR12MB4515.namprd12.prod.outlook.com (2603:10b6:5:2a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Tue, 23 Feb
 2021 04:21:32 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1%3]) with mapi id 15.20.3846.039; Tue, 23 Feb 2021
 04:21:32 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/8] amdgpu/pm: Powerplay API for smu ,
 added get_performance_level
Date: Mon, 22 Feb 2021 23:20:25 -0500
Message-Id: <20210223042032.3078-2-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210223042032.3078-1-darren.powell@amd.com>
References: <20210223042032.3078-1-darren.powell@amd.com>
X-Originating-IP: [142.126.154.129]
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To DM6PR12MB2954.namprd12.prod.outlook.com
 (2603:10b6:5:188::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.154.129) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.30 via Frontend Transport; Tue, 23 Feb 2021 04:21:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 51f23e6c-90e6-4c8e-9a72-08d8d7b27fc0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4515:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB45152EC36E5FB5521627DBA1F0809@DM6PR12MB4515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P7R/0SQdHeDYJ+zbYzAMRvrjGqHoKHjjPgeX+5Hmkf9LPs5s68tGURLwKCodDE4+v+/I9/oCWhUwNafTEUCQ3CqIOEqqElv56rbQ/SJseLNccZKnjU7ksosy1GLSXsIjTgKRZF578SlmpPJFcDvzJAQId49a867DdDxtIebdawJelqJrAQJIooZqwqcLc22IZcbqwVeK1o1K0OarOslmEhsG7F+BOfPiL00kKmEpGemhkvD4MF5ikuQ8mHoK+t1qEqLY/Gk2qIUx6Soa8f5QbnAOFMLTkRoW8HV4EvfOam6S24qd5vTBuEUdkFawVuoRszSibv5uAAjB3M90hAOQ+IwUCNyAHlgMXp5KHXQXM3Mg27qSLWJvXP8dIAc3cWuQ1TACHIoLDYv8+xL/gSPIjMk/E07Q0BwqSZtA4R3t+7Cb7yqbIq2wfCi9bo0PQbW1vbS7hKCw7PtSUfudXSQ07WJkNoh8XnYF5mfFbn5FZJR/NrWgllVoYbQXrZeqKTgWZXRSu1BWQAPhe1UECstIgmS8pNQ32zD847mk38JJBqobrdjYI8dRBOvljbGFDU9G3UZsZjzG0RU4r/+2qoCwqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(83380400001)(26005)(86362001)(54906003)(52116002)(5660300002)(66476007)(6486002)(66946007)(66556008)(69590400012)(478600001)(36756003)(1076003)(16526019)(186003)(6512007)(2906002)(6506007)(6666004)(8936002)(4326008)(316002)(8676002)(44832011)(956004)(6916009)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?B6X5ji4fFcmbPKdvlOwse3XCGAN1GOxJ8SCDh7r3EKM2zFb8XfbaKqgDuSJE?=
 =?us-ascii?Q?RtC4QyIhFh+0kgaYWGfMKBFMyCgaX2T89XqgEE6+FqKmdROdNnVSpuPOkpax?=
 =?us-ascii?Q?V/rRhBqHnmf5MHcIT/DGtwVv8BD5C0EckMPPmoT5eP6MgIr2UdcyP5+9EXDt?=
 =?us-ascii?Q?qn91XJaCMrSyp1v1E0Mso90ZwdvZAdKoN10bF5y9SlwPM4t1HG4N8+l1nfAs?=
 =?us-ascii?Q?3VOAah6wnNyakMk+2v29Jan/kTg6ypvd2Xq7iUQ+RiBqBUr63rbj5VCQcCtt?=
 =?us-ascii?Q?qnxTR3YJbM2EnjdQFIpRn8YlSB8MILe0n1UMk1ffJBpr4blhfDb/t7o1h4oG?=
 =?us-ascii?Q?M4GoEFxQL7C5aqf8Oc3GpC90wEVNbsckAEO/B6teGwNmiLkVZOCRmMKUBOQU?=
 =?us-ascii?Q?dbKU0Vnfn1yphCSfll4/GElALZSNnQLyNYq2nysWrAMWBieHMm7lxYusgzsS?=
 =?us-ascii?Q?cZHwyDAzG2lfM00RrehS7GlGa6TgvgovlQMHaW6rOsWjurYUfk2aByuOq77K?=
 =?us-ascii?Q?IFRdrl6RO10gSlDCMiI28+yTMorC+NzKRqass1nBBGD5IqMrNGgiZ549HG+r?=
 =?us-ascii?Q?ZnP08XpoWUWooBnLMq6RpwyEy4JTwnZYaLB67eofHcBq6EbN2x5sclnuStAT?=
 =?us-ascii?Q?qYL2v2Px5T/zSQZfvDbUizWmv0DyICioFc2jTH3fTn8COcfgUq23jLY7I+GY?=
 =?us-ascii?Q?zWNFD06kVwGbevIAx61tFIE87X6pRsR8KglMard/ezXCNH6zQpZhz9SDqRvK?=
 =?us-ascii?Q?sVB0XNxi36AyME94dMi0QRjNMW4H8qCZfP/QdSzw308B8Qj86ENoJvy8L1y9?=
 =?us-ascii?Q?xel5bmPWZTqzyUY17rvYsN4zE+uD+sN3My7J4ZeZH6GyzNNz+mJpo9V1Dfch?=
 =?us-ascii?Q?z1mHmrt8qGqD0MxkKqdoFpV/qWQiFKeqtkkem5lzdYVY6kisldhI5wQerkgF?=
 =?us-ascii?Q?tHUUCbYIajpGncGAGE99ngHWeO6446msJKVWux+vSUSMjzL7QNuMtq2HtWLs?=
 =?us-ascii?Q?zXyhfo1ctd7W5QaVxU35rj+ArvZ/FtXsV2E44xn2BSp5NV6GwIMr4Xeekd6B?=
 =?us-ascii?Q?td2MVOoHlbnA7/qdMlgkjLfsaycTpARVlBg9wtrvLMsABQEx+DKdfV0R/JJZ?=
 =?us-ascii?Q?p2cWF9F4w/5rHWUU/2Gla1K273Ds0knJ4LR7zkM4YpI3TTf1EPlVPmyk3Lbe?=
 =?us-ascii?Q?IHVpfc7vBOidYDuxO63xgyn5ASiunfzJWhZ/gCY0/qnf+x4Zg+PNWr6+LZaz?=
 =?us-ascii?Q?PgkK41XN1Ep08HIGkypN6OzceRFEI3rAPYLnqfq3B+a/GWjfkMp9TSpFNV3V?=
 =?us-ascii?Q?NbRYEOK9isTT5RQ3+XVpQktG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f23e6c-90e6-4c8e-9a72-08d8d7b27fc0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 04:21:32.2353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfE7g98HCYV9hHDFPeEdKmQPXTenjky7Y9uzyMAU4ZuJinyqakiFBZTbSDRb8F0a3cNVZXpoadrEw0PcxMUBMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4515
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Darren Powell <darren.powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

v2: updated the structure name to swsmu_pm_funcs

Modified Functions
  smu_get_performance_level() - modifed arg0 to match Powerplay API get_performance_level

Other Changes
  added a new structure swsmu_dpm_funcs to hold smu functions for Powerplay API
  removed special smu handling from amdgpu_get_power_dpm_force_performance_level

Signed-off-by: Darren Powell <darren.powell@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        |  4 +---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 12 +++++++++++-
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 5fa65f191a37..ab26915add47 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -281,9 +281,7 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev))
-		level = smu_get_performance_level(&adev->smu);
-	else if (adev->powerplay.pp_funcs->get_performance_level)
+	if (adev->powerplay.pp_funcs->get_performance_level)
 		level = amdgpu_dpm_get_performance_level(adev);
 	else
 		level = adev->pm.dpm.forced_level;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 10b0624ade65..f41be47fb125 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1320,7 +1320,7 @@ int smu_get_dpm_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			   uint32_t *min, uint32_t *max);
 int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			    uint32_t min, uint32_t max);
-enum amd_dpm_forced_level smu_get_performance_level(struct smu_context *smu);
+enum amd_dpm_forced_level smu_get_performance_level(void *handle);
 int smu_force_performance_level(struct smu_context *smu, enum amd_dpm_forced_level level);
 int smu_set_display_count(struct smu_context *smu, uint32_t count);
 int smu_set_ac_dc(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index d143ef1b460b..1c77444c75b5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -46,6 +46,8 @@
 #undef pr_info
 #undef pr_debug
 
+static const struct amd_pm_funcs swsmu_pm_funcs;
+
 size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf)
 {
 	size_t size = 0;
@@ -553,6 +555,9 @@ static int smu_early_init(void *handle)
 	smu->smu_baco.state = SMU_BACO_STATE_EXIT;
 	smu->smu_baco.platform_support = false;
 
+	adev->powerplay.pp_handle = smu;
+	adev->powerplay.pp_funcs = &swsmu_pm_funcs;
+
 	return smu_set_funcs(adev);
 }
 
@@ -1691,8 +1696,9 @@ int smu_switch_power_profile(struct smu_context *smu,
 	return 0;
 }
 
-enum amd_dpm_forced_level smu_get_performance_level(struct smu_context *smu)
+enum amd_dpm_forced_level smu_get_performance_level(void *handle)
 {
+	struct smu_context *smu = handle;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 	enum amd_dpm_forced_level level;
 
@@ -2723,3 +2729,7 @@ int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state)
 
 	return ret;
 }
+
+static const struct amd_pm_funcs swsmu_pm_funcs = {
+	.get_performance_level = smu_get_performance_level,
+};
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
