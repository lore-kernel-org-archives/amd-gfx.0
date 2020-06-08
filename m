Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0696C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 10:53:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96C742072F
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 10:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2LUKzdMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C742072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60508897E7;
	Mon,  8 Jun 2020 10:53:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 353A58933D
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 10:53:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I24SIVpncE3xHjzC3bsRS4NV3t8jNyJIVtJP5zU7UTGd78BoLdVFj9Gm50QMiiFZMdgu83hXymevK4ibqi6v5QTNKSe2ehvAebVKCqClbFzRP8bjXHbhNMhy0BxqGSLG71sLjzBtz72fboVx81EPuMfu7a46Sfhw9//e3F6NRnGcuiYZw5VOugC4WIP+EAEfK9kKC0ko4wF08EDNYjvqMir4SKeJkqTltVCkhqZUsJ1CAwAgzc6G2B+XskHPWz1HTZUUKMa3JTZmTNbY0o6ansN+xgWxFpTZiuGbTimhM5a0VQ0fnV3RcUJ45zm4oI3IGt0Qior4Uy3pPt2XirfaTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzQOrRe/wc/Wu7bovXi8E+YNJXt1r08M+u66jYUQE5o=;
 b=bUQgZVv8Ey35ZK2/HjyfdwfSF5YmoqgXS+EiiY3/r2UNtTnSHcjbRA8A0qhWqdlJez0E2Ave0NY+Vzt0Fbkx+BjqMQmSYXXYoIMB0+Ux2MIlkYSYhs7vCIof+fbYD13DckuNz2+ijiHJhjGk44P06opMoCIT40xXkG7U9GKkaP6ZyCjBu0ZMX6bBHYNCBfHz8qBgTX4bYqxEh5lQnWP+2maXLVnDU5KtYZijuVNKyiyrAjwn+hOqa1iHBRP3jOFd2ZP86of6pr49QKSI4wqYFB6ZzaNs8GeMl/CCD3VeCEMcvjzJ7f/uBwYDHC8GO4LYerlKDkdq2oG3iSKM5XM9fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzQOrRe/wc/Wu7bovXi8E+YNJXt1r08M+u66jYUQE5o=;
 b=2LUKzdMiGxrKKLECLt+OWA3t7lbQ6RPmme3I8SaDkFruDMlO8Vd5qAq1lj1IBJh9Qgi5huCJtioG5hhOyQ0m+6e+BvV8iZBYRdQk6ScmX2X15puRAu+7stEAAJkm+QkYnvpwSLpjiZ1KleUDgG6NopT0zDSdcyVhFEDEHktfYAU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3546.namprd12.prod.outlook.com (2603:10b6:5:18d::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Mon, 8 Jun 2020 10:53:34 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 10:53:34 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/7] drm/amd/powerplay: drop unused code around power limit
Date: Mon,  8 Jun 2020 18:52:32 +0800
Message-Id: <20200608105234.29864-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200608105234.29864-1-evan.quan@amd.com>
References: <20200608105234.29864-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0189.apcprd02.prod.outlook.com
 (2603:1096:201:21::25) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0189.apcprd02.prod.outlook.com (2603:1096:201:21::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.19 via Frontend Transport; Mon, 8 Jun 2020 10:53:32 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c23434fe-fdd4-4235-1c6b-08d80b9a3073
X-MS-TrafficTypeDiagnostic: DM6PR12MB3546:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB354600D64DD7F90DD94F71DBE4850@DM6PR12MB3546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VerjQz+/7TOeIql1xISK+2I0KROxI/QigHMru8qXCovJhg4tgx803wyo6KrcwRbxt0gikAackwZFOiUpHGbSHxftjAyWzcKbW6+G5tvBBSP42WCez6lhLnCLT/SZv9UO7uHFPXHa3Wcyr6JGa2XsNUEV9mVuDUspy1w1uQwspz/IctOW0w6HlB4+LgRp1csNkQiEGB0aunyRR2WIe3yuZ96MHvSr0FnglNU/ojrKuSl4E3pIeE8onHyFL7qk5bwjq7fsw0t6OkynXZP2R2efgcnZrzjkvOaEwy4RwewukKKlKEhso1Cq3pMqdNLiE/vCL4kYl7Y23VFkmyRT6gs/Pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(66556008)(2906002)(66476007)(30864003)(6916009)(8676002)(956004)(66946007)(2616005)(8936002)(26005)(5660300002)(44832011)(4326008)(86362001)(6486002)(478600001)(83380400001)(316002)(186003)(52116002)(7696005)(36756003)(16526019)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ZhJc/NQzv9zV8W+dGGK/uzFpE19W1p25Pa7piLKLMZFdfh0d2Y6GDK9cOXA/K+toCccM+fSDXRu4sNPiSTh64z6GM5fqwFSzY2nrz0opLE1Jgj/tyNTxlc4qp+Vvutiz044GfTYYyxd1UlyKFpdsQrsXL7PeOk+v5kIEqxYdQogFzw8SNLIPrmT3FOaD3EFlwHGBar4M3I9ckpW73TxM2wIPp/9cLineX/LKeSHk7WN6c9jGZJX1SelVYRbZUaWhyVNo0urZtaK4N4u47KLZd9RYcoqkuhRIhcgY23y7CEZDlz+358wtW/1j7zanE5i22WTEcTMQPeZK/SGCe0i6b4wIDt0e06MqQy17BSn5xIsQQyA83LRKWpoqKbxThqoDcJoQg5KggYpabOZBPqj6Q1n7G+PEaTYH/EJzejOUEy8OdGemdEHmnvcB5Nja++w0v+Cp+Nz0UeibURI0cPgRvEzjw7XmG3yBcx8dogNQe1SXFYOVoRy60pv2XUemP9gf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c23434fe-fdd4-4235-1c6b-08d80b9a3073
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 10:53:34.0853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 184Hjzo9BmVAAy95vfJL5uiBNvyBmJpNeqHfbkzVvftzbvRJgF4AYjzWpCsR093f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3546
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

Drop unused APIs, variables and argument.

Change-Id: I59c99de30bf3fa0e5ed058aaa8ab95d0a9c748aa
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c        |  4 +--
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 20 ++++-------
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 35 -------------------
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  6 +---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 34 ------------------
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 34 ------------------
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  2 --
 7 files changed, 10 insertions(+), 125 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index b2cdc8a1268f..395ddbe2461c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -2739,7 +2739,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 		return r;
 
 	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit, true, true);
+		smu_get_power_limit(&adev->smu, &limit, true);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->get_power_limit) {
 		adev->powerplay.pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit, true);
@@ -2771,7 +2771,7 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 		return r;
 
 	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit, false,  true);
+		smu_get_power_limit(&adev->smu, &limit, false);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->get_power_limit) {
 		adev->powerplay.pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit, false);
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 7cde80c9614f..725ac90c0f36 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -2210,24 +2210,18 @@ int smu_set_fan_speed_rpm(struct smu_context *smu, uint32_t speed)
 
 int smu_get_power_limit(struct smu_context *smu,
 			uint32_t *limit,
-			bool def,
-			bool lock_needed)
+			bool max_setting)
 {
-	int ret = 0;
-
-	if (lock_needed) {
-		if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
-			return -EOPNOTSUPP;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
-		mutex_lock(&smu->mutex);
-	}
+	mutex_lock(&smu->mutex);
 
-	*limit = (def ? smu->max_power_limit : smu->current_power_limit);
+	*limit = (max_setting ? smu->max_power_limit : smu->current_power_limit);
 
-	if (lock_needed)
-		mutex_unlock(&smu->mutex);
+	mutex_unlock(&smu->mutex);
 
-	return ret;
+	return 0;
 }
 
 int smu_set_power_limit(struct smu_context *smu, uint32_t limit)
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 66b8f143cc46..c104844b28f1 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2411,13 +2411,6 @@ static bool arcturus_is_baco_supported(struct smu_context *smu)
 	return (val & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK) ? true : false;
 }
 
-static uint32_t arcturus_get_pptable_power_limit(struct smu_context *smu)
-{
-	PPTable_t *pptable = smu->smu_table.driver_pptable;
-
-	return pptable->SocketPowerLimitAc[PPT_THROTTLER_PPT0];
-}
-
 static int arcturus_set_df_cstate(struct smu_context *smu,
 				  enum pp_df_cstate state)
 {
@@ -2544,33 +2537,6 @@ static int arcturus_set_thermal_range(struct smu_context *smu,
 	return 0;
 }
 
-static uint32_t atcturus_get_max_power_limit(struct smu_context *smu) {
-	uint32_t od_limit, max_power_limit;
-	struct smu_11_0_powerplay_table *powerplay_table = NULL;
-	struct smu_table_context *table_context = &smu->smu_table;
-	powerplay_table = table_context->power_play_table;
-
-	max_power_limit = arcturus_get_pptable_power_limit(smu);
-
-	if (!max_power_limit) {
-		// If we couldn't get the table limit, fall back on first-read value
-		if (!smu->default_power_limit)
-			smu->default_power_limit = smu->power_limit;
-		max_power_limit = smu->default_power_limit;
-	}
-
-	if (smu->od_enabled) {
-		od_limit = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
-
-		dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_limit, smu->default_power_limit);
-
-		max_power_limit *= (100 + od_limit);
-		max_power_limit /= 100;
-	}
-
-	return max_power_limit;
-}
-
 static const struct pptable_funcs arcturus_ppt_funcs = {
 	/* translate smu index into arcturus specific index */
 	.get_smu_msg_index = arcturus_get_smu_msg_index,
@@ -2662,7 +2628,6 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.allow_xgmi_power_down = arcturus_allow_xgmi_power_down,
 	.log_thermal_throttling_event = arcturus_log_thermal_throttling_event,
 	.set_thermal_range = arcturus_set_thermal_range,
-	.get_max_power_limit = atcturus_get_max_power_limit,
 };
 
 void arcturus_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index db63ed057840..8eaa6338ad44 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -380,8 +380,6 @@ struct smu_context
 	uint32_t pstate_mclk;
 
 	bool od_enabled;
-	uint32_t power_limit;
-	uint32_t default_power_limit;
 	uint32_t current_power_limit;
 	uint32_t max_power_limit;
 
@@ -573,7 +571,6 @@ struct pptable_funcs {
 	int (*set_power_source)(struct smu_context *smu, enum smu_power_src_type power_src);
 	void (*log_thermal_throttling_event)(struct smu_context *smu);
 	int (*set_thermal_range)(struct smu_context *smu, struct smu_temperature_range range);
-	uint32_t (*get_max_power_limit)(struct smu_context *smu);
 };
 
 typedef enum {
@@ -616,8 +613,7 @@ int smu_set_fan_speed_rpm(struct smu_context *smu, uint32_t speed);
 
 int smu_get_power_limit(struct smu_context *smu,
 			uint32_t *limit,
-			bool def,
-			bool lock_needed);
+			bool max_setting);
 
 int smu_set_power_limit(struct smu_context *smu, uint32_t limit);
 int smu_print_clk_levels(struct smu_context *smu, enum smu_clk_type clk_type, char *buf);
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 2e0836976001..186cdf6696f8 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1916,12 +1916,6 @@ static int navi10_display_disable_memory_clock_switch(struct smu_context *smu,
 	return ret;
 }
 
-static uint32_t navi10_get_pptable_power_limit(struct smu_context *smu)
-{
-	PPTable_t *pptable = smu->smu_table.driver_pptable;
-	return pptable->SocketPowerLimitAc[PPT_THROTTLER_PPT0];
-}
-
 static int navi10_get_power_limit(struct smu_context *smu)
 {
 	struct smu_11_0_powerplay_table *powerplay_table =
@@ -2380,33 +2374,6 @@ static int navi10_set_thermal_range(struct smu_context *smu,
 	return 0;
 }
 
-static uint32_t navi10_get_max_power_limit(struct smu_context *smu) {
-	uint32_t od_limit, max_power_limit;
-	struct smu_11_0_powerplay_table *powerplay_table = NULL;
-	struct smu_table_context *table_context = &smu->smu_table;
-	powerplay_table = table_context->power_play_table;
-
-	max_power_limit = navi10_get_pptable_power_limit(smu);
-
-	if (!max_power_limit) {
-		// If we couldn't get the table limit, fall back on first-read value
-		if (!smu->default_power_limit)
-			smu->default_power_limit = smu->power_limit;
-		max_power_limit = smu->default_power_limit;
-	}
-
-	if (smu->od_enabled) {
-		od_limit = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
-
-		dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_limit, smu->default_power_limit);
-
-		max_power_limit *= (100 + od_limit);
-		max_power_limit /= 100;
-	}
-
-	return max_power_limit;
-}
-
 static const struct pptable_funcs navi10_ppt_funcs = {
 	.tables_init = navi10_tables_init,
 	.alloc_dpm_context = navi10_allocate_dpm_context,
@@ -2497,7 +2464,6 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.disable_umc_cdr_12gbps_workaround = navi10_disable_umc_cdr_12gbps_workaround,
 	.set_power_source = smu_v11_0_set_power_source,
 	.set_thermal_range = navi10_set_thermal_range,
-	.get_max_power_limit = navi10_get_max_power_limit,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 44719c110655..81cc04de9b06 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -1737,12 +1737,6 @@ static int sienna_cichlid_display_disable_memory_clock_switch(struct smu_context
 	return ret;
 }
 
-static uint32_t sienna_cichlid_get_pptable_power_limit(struct smu_context *smu)
-{
-	PPTable_t *pptable = smu->smu_table.driver_pptable;
-	return pptable->SocketPowerLimitAc[PPT_THROTTLER_PPT0];
-}
-
 static int sienna_cichlid_get_power_limit(struct smu_context *smu)
 {
 	struct smu_11_0_7_powerplay_table *powerplay_table =
@@ -1886,33 +1880,6 @@ static int sienna_cichlid_set_thermal_range(struct smu_context *smu,
 	return 0;
 }
 
-static uint32_t sienna_cichlid_get_max_power_limit(struct smu_context *smu) {
-	uint32_t od_limit, max_power_limit;
-	struct smu_11_0_7_powerplay_table *powerplay_table = NULL;
-	struct smu_table_context *table_context = &smu->smu_table;
-	powerplay_table = table_context->power_play_table;
-
-	max_power_limit = sienna_cichlid_get_pptable_power_limit(smu);
-
-	if (!max_power_limit) {
-		// If we couldn't get the table limit, fall back on first-read value
-		if (!smu->default_power_limit)
-			smu->default_power_limit = smu->power_limit;
-		max_power_limit = smu->default_power_limit;
-	}
-
-	if (smu->od_enabled) {
-		od_limit = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
-
-		dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_limit, smu->default_power_limit);
-
-		max_power_limit *= (100 + od_limit);
-		max_power_limit /= 100;
-	}
-
-	return max_power_limit;
-}
-
 static void sienna_cichlid_dump_pptable(struct smu_context *smu)
 {
 	struct smu_table_context *table_context = &smu->smu_table;
@@ -2664,7 +2631,6 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.set_soft_freq_limited_range = sienna_cichlid_set_soft_freq_limited_range,
 	.override_pcie_parameters = smu_v11_0_override_pcie_parameters,
 	.set_thermal_range = sienna_cichlid_set_thermal_range,
-	.get_max_power_limit = sienna_cichlid_get_max_power_limit,
 };
 
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 346aea9198e9..094db34ddbd1 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -194,8 +194,6 @@ static inline int smu_send_smc_msg(struct smu_context *smu, enum smu_message_typ
 
 #define smu_set_thermal_range(smu, range) \
 		((smu)->ppt_funcs->set_thermal_range ? (smu)->ppt_funcs->set_thermal_range((smu), (range)) : 0)
-#define smu_get_max_power_limit(smu) \
-		((smu)->ppt_funcs->get_max_power_limit ? (smu)->ppt_funcs->get_max_power_limit((smu)) : 0)
 
 #define smu_disable_umc_cdr_12gbps_workaround(smu) \
 	((smu)->ppt_funcs->disable_umc_cdr_12gbps_workaround ? (smu)->ppt_funcs->disable_umc_cdr_12gbps_workaround((smu)) : 0)
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
