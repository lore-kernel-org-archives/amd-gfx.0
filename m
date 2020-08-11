Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978F3C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 03:38:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DFA2206DA
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 03:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SynXG+t9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFA2206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E031D6E06B;
	Tue, 11 Aug 2020 03:38:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D5AF6E06B
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 03:38:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0+Hx3pIQTkjJNIlz0xINLG2/p7rj4tku5xhngRZuosWS3DDAJfnA9DkrtriB3rThV7qX/AroWBirEFMeu5TflHsYYVDc4H490HrZNhXWrScrI+EKg/qe/+wlFYGlN0z/LRnK7mVIyPGrEV59ldjUu13cG38xG1XnMeWGVKiURebMG+zemTJcwaKjHA5kr2RY7qT1EDIsAi6Qa8VFfAdFazyzTZ+obKYAqOonj8vSYAjBmXCaOblU7ulruL5jkGCRsuLH6QY7hUEy8r8MLBNh0QKulmtW0pnwi8DJC9sGJPW3zoMPeHyh+1euZ4sXRTduSHyXkHbC3tBHu/1AkNFfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWLfEN4oeQheeW632U6+Rj1I8UtuG2X674vt9owyU4g=;
 b=V2kV/Ub9Wnk7ORmN1HHFkv6i8OE5iSx6hfqRlx3PULFnvanIyxHPrst2wN1WxMg0SCMB5MGcGZ2g9vcrJYVmC7kj8A8B95l4sQCryKjxAy6mUCh+WKCdq193R/B/sLKvPDsnQgckiLIPypep0cCT1JU5ClQk0ey8FFJKase7QVFEbdQ+RZfhkXQXN3ILZcSxXIR8TE3kJbluPzU8tdPOkQcPh3J0BMlwO7BDzEySz+sp0kCc2uuegSQ2409Wfb4VZfAQcnZuA7bkQq9Z+BJgBRfndiBpJMqCSMm7Qy5pFYUo/4YVPu68ZWDxSLb5+LwUE+so7eFYSMTM3AC2AKe/sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWLfEN4oeQheeW632U6+Rj1I8UtuG2X674vt9owyU4g=;
 b=SynXG+t9HYOLMhBPiav0JHwgcNi7RJQPOZeUy66UjMd5VC51XM0LidTf4b67Yip8CcPQG4qFpnSE0RRV51gAdvSRrU+8/tKYstMWvW8NB6oZy8tkOU4pFizbQ1hRIGa4n0YaNfZkVQzNKMEDpOZSEiCeDxU2rlXerrebtJEIG4o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2891.namprd12.prod.outlook.com (2603:10b6:5:188::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.18; Tue, 11 Aug 2020 03:38:36 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3261.022; Tue, 11 Aug 2020
 03:38:36 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: minor cleanups
Date: Tue, 11 Aug 2020 11:38:13 +0800
Message-Id: <20200811033813.1236-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HK0PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:203:b0::36) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK0PR03CA0120.apcprd03.prod.outlook.com (2603:1096:203:b0::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.18 via Frontend Transport; Tue, 11 Aug 2020 03:38:34 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1d35d870-fe23-4be9-986b-08d83da80727
X-MS-TrafficTypeDiagnostic: DM6PR12MB2891:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB28911CE365CBA3FC9142D0A2E4450@DM6PR12MB2891.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:159;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hVAHo/d7OjfL/fq0oYyrL2QYcWU/25W2UxSjeoS2m9FNvycQj7Qvj0dz8CPrIZl47PPH3lI0sjBrbNG6r6uIm6ZXg8tHi6lBYAI+blTXKt1568NsZ37Dn/B3T6W21/uDzIgKPdkc3ab/baZfIBIlfmsTHjJ9GzmbPyeGIjqQukyVRW2rR40HKcaugWi1yA1ZS20kwgaCCQCaDKm/1vmWayPQPbqIFxsxGcAaXvcIRUSWkUDfjWW8C9d05KRfGNB6u9CKaCx71HgQfIfJMZ7VzccLAsb20pSBjoPfGwJ1V8GqaxJgsfexuD62rxv6RaZnRm1Ln52GcdgfU+i5ayGong==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(8676002)(16526019)(186003)(26005)(36756003)(478600001)(956004)(83380400001)(5660300002)(2616005)(52116002)(8936002)(7696005)(4326008)(44832011)(6486002)(316002)(1076003)(86362001)(6666004)(66946007)(66556008)(66476007)(6916009)(30864003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: R+0aJJNBOYoHDnT9UVAx8RGaYaH5o6GZC9hmja/b+h99fDPq1LUgR+ZwZKecZQIH19cAHxBuhL0xnOaTcP+4+olD6HaZjIVIRJtG7OLOaV3xa/Ucr6DY04YvdyH5cZY1gqbHqHZhnA2hN9H1wKMvOgbw5IHArAe3KDuA0oVCJafhdUh3SPZCTzBSBy4Ouf7ET8cxVothPmrmpvMODuT26pRVb/XkCd6gpsTBijgnWCHUAMZjDsoNGXQgV88Mvr56TDAFV4hUYrQ4+rLVhX2JmybsrCfsHCKr3LqPHHKo7HFLIrWzPacVZNNb9y2rQctoYaDX6ONTqi6e5TdfoONWAIgNnSx7FdBtz5ftBpXHbU1iwwdhPyDWw7Xp0wcSoEYhQCM1Zd/rQpKkFN2yEX2kESoHpAGu5Mcx5/fmGSCPNHNILq0O3DdgbrmRsPJVhNnqfQjfpvwj1x3nbP3KogsMV4qRP2Q5BpPEFCxWFjMGTVQaKT/5SDl7eywzmOEzJZ57KBvzZMzZFzKdFTjYiW5Q2aCd+G33NQ/0mZQunXKMalqBXYME/FZsiEUdbxxllfFRJD2oKzwEQpCu809Gvvviw1vGpYErgZapDEOkimGKkSLSgrqw2NPyZbDr/8mrAxqt5djIEsTLOztOCsX7wDkosg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d35d870-fe23-4be9-986b-08d83da80727
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 03:38:35.9599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djOuaWY4qFPs5a+xWpAm2wRcYtQ88yJYb1pCdwUl3/cm28x6Llg9Xn7zHZnlJkl3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2891
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

Drop unnecessary lock protections during hw setup which was confirmed
to have no race condition. Drop also unnecessary null pointer checker.

Change-Id: Ida301ae7bad1abae15285c4e019eda4f7dc6e297
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 20 --------
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  2 -
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  1 -
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  2 -
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    |  2 -
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  1 +
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 50 ++++---------------
 7 files changed, 11 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 1ffacc712e53..c70f94377644 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -361,20 +361,16 @@ static int smu_get_driver_allowed_feature_mask(struct smu_context *smu)
 	int ret = 0;
 	uint32_t allowed_feature_mask[SMU_FEATURE_MAX/32];
 
-	mutex_lock(&feature->mutex);
 	bitmap_zero(feature->allowed, SMU_FEATURE_MAX);
-	mutex_unlock(&feature->mutex);
 
 	ret = smu_get_allowed_feature_mask(smu, allowed_feature_mask,
 					     SMU_FEATURE_MAX/32);
 	if (ret)
 		return ret;
 
-	mutex_lock(&feature->mutex);
 	bitmap_or(feature->allowed, feature->allowed,
 		      (unsigned long *)allowed_feature_mask,
 		      feature->feature_num);
-	mutex_unlock(&feature->mutex);
 
 	return ret;
 }
@@ -576,9 +572,6 @@ static int smu_fini_fb_allocations(struct smu_context *smu)
 	struct smu_table *tables = smu_table->tables;
 	struct smu_table *driver_table = &(smu_table->driver_table);
 
-	if (!tables)
-		return 0;
-
 	if (tables[SMU_TABLE_PMSTATUSLOG].mc_address)
 		amdgpu_bo_free_kernel(&tables[SMU_TABLE_PMSTATUSLOG].bo,
 				      &tables[SMU_TABLE_PMSTATUSLOG].mc_address,
@@ -2250,19 +2243,6 @@ int smu_set_deep_sleep_dcefclk(struct smu_context *smu, int clk)
 	return ret;
 }
 
-int smu_set_active_display_count(struct smu_context *smu, uint32_t count)
-{
-	int ret = 0;
-
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
-	if (smu->ppt_funcs->set_active_display_count)
-		ret = smu->ppt_funcs->set_active_display_count(smu, count);
-
-	return ret;
-}
-
 int smu_get_clock_by_type(struct smu_context *smu,
 			  enum amd_pp_clock_type type,
 			  struct amd_pp_clocks *clocks)
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 8b1025dc54fd..25679d60f7b4 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -386,11 +386,9 @@ static int arcturus_check_powerplay_table(struct smu_context *smu)
 		table_context->power_play_table;
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
 
-	mutex_lock(&smu_baco->mutex);
 	if (powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_BACO ||
 	    powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_MACO)
 		smu_baco->platform_support = true;
-	mutex_unlock(&smu_baco->mutex);
 
 	table_context->thermal_controller_type =
 		powerplay_table->thermal_controller_type;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 23c2279bd500..8de39b31e7c2 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -698,7 +698,6 @@ int smu_set_fan_speed_percent(struct smu_context *smu, uint32_t speed);
 int smu_get_fan_speed_rpm(struct smu_context *smu, uint32_t *speed);
 
 int smu_set_deep_sleep_dcefclk(struct smu_context *smu, int clk);
-int smu_set_active_display_count(struct smu_context *smu, uint32_t count);
 
 int smu_get_clock_by_type(struct smu_context *smu,
 			  enum amd_pp_clock_type type,
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 42a60769c52f..61e2971be9f3 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -346,11 +346,9 @@ static int navi10_check_powerplay_table(struct smu_context *smu)
 	if (powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_HARDWAREDC)
 		smu->dc_controlled_by_gpio = true;
 
-	mutex_lock(&smu_baco->mutex);
 	if (powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_BACO ||
 	    powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_MACO)
 		smu_baco->platform_support = true;
-	mutex_unlock(&smu_baco->mutex);
 
 	table_context->thermal_controller_type =
 		powerplay_table->thermal_controller_type;
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index c5935f0a065b..f55dd0c2f3c8 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -294,11 +294,9 @@ static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
 		table_context->power_play_table;
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
 
-	mutex_lock(&smu_baco->mutex);
 	if (powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_CAP_BACO ||
 	    powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_CAP_MACO)
 		smu_baco->platform_support = true;
-	mutex_unlock(&smu_baco->mutex);
 
 	table_context->thermal_controller_type =
 		powerplay_table->thermal_controller_type;
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 264073d4e263..e44d705780b9 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -42,6 +42,7 @@
 #define smu_check_fw_version(smu)					smu_ppt_funcs(check_fw_version, 0, smu)
 #define smu_write_pptable(smu)						smu_ppt_funcs(write_pptable, 0, smu)
 #define smu_set_min_dcef_deep_sleep(smu, clk)				smu_ppt_funcs(set_min_dcef_deep_sleep, 0, smu, clk)
+#define smu_set_active_display_count(smu, count)			smu_ppt_funcs(set_active_display_count, 0, smu, count)
 #define smu_set_driver_table_location(smu)				smu_ppt_funcs(set_driver_table_location, 0, smu)
 #define smu_set_tool_table_location(smu)				smu_ppt_funcs(set_tool_table_location, 0, smu)
 #define smu_notify_memory_pool_location(smu)				smu_ppt_funcs(notify_memory_pool_location, 0, smu)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 580889a02a94..4b6162863ed6 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -453,9 +453,6 @@ int smu_v11_0_init_power(struct smu_context *smu)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 
-	if (smu_power->power_context || smu_power->power_context_size != 0)
-		return -EINVAL;
-
 	smu_power->power_context = kzalloc(sizeof(struct smu_11_0_dpm_context),
 					   GFP_KERNEL);
 	if (!smu_power->power_context)
@@ -469,9 +466,6 @@ int smu_v11_0_fini_power(struct smu_context *smu)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 
-	if (!smu_power->power_context || smu_power->power_context_size == 0)
-		return -EINVAL;
-
 	kfree(smu_power->power_context);
 	smu_power->power_context = NULL;
 	smu_power->power_context_size = 0;
@@ -700,18 +694,16 @@ int smu_v11_0_set_tool_table_location(struct smu_context *smu)
 
 int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count)
 {
-	int ret = 0;
 	struct amdgpu_device *adev = smu->adev;
 
 	/* Navy_Flounder do not support to change display num currently */
 	if (adev->asic_type == CHIP_NAVY_FLOUNDER)
 		return 0;
 
-	if (!smu->pm_enabled)
-		return ret;
-
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays, count, NULL);
-	return ret;
+	return smu_cmn_send_smc_msg_with_param(smu,
+					       SMU_MSG_NumOfDisplays,
+					       count,
+					       NULL);
 }
 
 
@@ -721,7 +713,6 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
 	int ret = 0;
 	uint32_t feature_mask[2];
 
-	mutex_lock(&feature->mutex);
 	if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) || feature->feature_num < 64)
 		goto failed;
 
@@ -738,7 +729,6 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
 		goto failed;
 
 failed:
-	mutex_unlock(&feature->mutex);
 	return ret;
 }
 
@@ -775,9 +765,6 @@ int smu_v11_0_notify_display_change(struct smu_context *smu)
 {
 	int ret = 0;
 
-	if (!smu->pm_enabled)
-		return ret;
-
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT) &&
 	    smu->adev->gmc.vram_type == AMDGPU_VRAM_TYPE_HBM)
 		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetUclkFastSwitch, 1, NULL);
@@ -1185,12 +1172,10 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
 int smu_v11_0_set_xgmi_pstate(struct smu_context *smu,
 				     uint32_t pstate)
 {
-	int ret = 0;
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					  SMU_MSG_SetXgmiMode,
-					  pstate ? XGMI_MODE_PSTATE_D0 : XGMI_MODE_PSTATE_D3,
+	return smu_cmn_send_smc_msg_with_param(smu,
+					       SMU_MSG_SetXgmiMode,
+					       pstate ? XGMI_MODE_PSTATE_D0 : XGMI_MODE_PSTATE_D3,
 					  NULL);
-	return ret;
 }
 
 static int smu_v11_0_set_irq_state(struct amdgpu_device *adev,
@@ -1421,11 +1406,7 @@ int smu_v11_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
 
 int smu_v11_0_set_azalia_d3_pme(struct smu_context *smu)
 {
-	int ret = 0;
-
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_BacoAudioD3PME, NULL);
-
-	return ret;
+	return smu_cmn_send_smc_msg(smu, SMU_MSG_BacoAudioD3PME, NULL);
 }
 
 static int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu, enum smu_v11_0_baco_seq baco_seq)
@@ -1436,13 +1417,8 @@ static int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu, enum smu_v
 bool smu_v11_0_baco_is_support(struct smu_context *smu)
 {
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
-	bool baco_support;
-
-	mutex_lock(&smu_baco->mutex);
-	baco_support = smu_baco->platform_support;
-	mutex_unlock(&smu_baco->mutex);
 
-	if (!baco_support)
+	if (!smu_baco->platform_support)
 		return false;
 
 	/* Arcturus does not support this bit mask */
@@ -1529,13 +1505,7 @@ int smu_v11_0_baco_enter(struct smu_context *smu)
 
 int smu_v11_0_baco_exit(struct smu_context *smu)
 {
-	int ret = 0;
-
-	ret = smu_v11_0_baco_set_state(smu, SMU_BACO_STATE_EXIT);
-	if (ret)
-		return ret;
-
-	return ret;
+	return smu_v11_0_baco_set_state(smu, SMU_BACO_STATE_EXIT);
 }
 
 int smu_v11_0_mode1_reset(struct smu_context *smu)
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
