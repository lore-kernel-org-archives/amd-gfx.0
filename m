Return-Path: <SRS0=uuOW=AN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4461C433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2020 09:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7929C20760
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2020 09:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="j28/yDw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7929C20760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 474D06EABE;
	Thu,  2 Jul 2020 09:47:35 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760078.outbound.protection.outlook.com [40.107.76.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A13ED6EABE
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2020 09:47:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvR+bllusrv9E706T2XRv4dfWPCBB1lE2OTbIUBbGqes4t+yDwVbsJnPTm0KJX1MKo4tY5NpSFdXzqd4UOqbfKPO3F+yccHGqNv36GZFrL/HLeHipYxE1mnUalItSgaDS/8PQHRvwVqEMnnXjjv83B+jvYBprJA9LffzXZcVuN8HL71mPAEkiyRjwFf2d5owjWgYp8xcbg9ZzrZNDT5SvZHE2g5urJcQ1HDP4dgwnaXMM87GAAusCi5DG8QAx+o3NmqaF7bHdNm4oTQK0x45Lv/S/3aYOoks4lcfhoesWHK4Tg+5OfjPo8QXA5+2pUInQTraB1tQGAFJVK+XZO5ExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtGW8uuX3FlI9PswGFrJ778OkJn2/1hHICC8O53j1uA=;
 b=iwlhYeqyaa2rZww7tUK7rgxd8Gy6leC2XTKYgeGgpuXRh0TdNvqygDjeNqhV+892HGVCsl/qjQbM2Ke0RGxv8m7yah6kVTm8sUkBoW1EhKTnz7WBZHNt9yH5S2NLjtxrZ+7AU1RWx6pQjZvmAPbvnAaEc+sJDGfi9l5sMNQpmrgtj0B542H5B8iMjwp5XgVZeAUXBjiIvpQae1xPUWTHuNfgMzIWPl4+C2khlrNQPFR17F7yeW3AIq+T5avNOR7kpuGe57bvXuNB6jYvRhVkewPaLCqPALsC4PKAIAbLpbM2JD1WuBmREjYMD3rB3aEJxF2URggp5BUGvOmDaJ0CCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtGW8uuX3FlI9PswGFrJ778OkJn2/1hHICC8O53j1uA=;
 b=j28/yDw6arNC3IuzLzItVP1yuHwlHo33oIZ2HQl/UnD41oT8Tt/9h7zJgE8gV67MjAmjoEa7H1sS9ryu3KXuMixAOa1vydkaHP8Y3gzRrIu4nCAdfjNTsITxWbgUyUvBpjBVIN1z60vXWqDa6IM3tiEF112ueXOdvG0mw7fU8wo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0219.namprd12.prod.outlook.com (2603:10b6:4:56::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21; Thu, 2 Jul 2020 09:47:33 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.023; Thu, 2 Jul 2020
 09:47:33 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amd/powerplay: revise calling chain on retrieving
 frequency range
Date: Thu,  2 Jul 2020 17:47:01 +0800
Message-Id: <20200702094702.8223-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702094702.8223-1-evan.quan@amd.com>
References: <20200702094702.8223-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR04CA0051.apcprd04.prod.outlook.com
 (2603:1096:202:14::19) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0051.apcprd04.prod.outlook.com (2603:1096:202:14::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.23 via Frontend Transport; Thu, 2 Jul 2020 09:47:31 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e6b7d256-390c-4359-3f17-08d81e6cf179
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB021963AAF876E3018FE20B5EE46D0@DM5PR1201MB0219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uf6tUlXCOI7HiiVfdoi+fhK1JNOIm5xBcYKHtEiY70KOxI2iiAJ1o9/ewjaKWrBRHWwW8Kv43cCwMg76JP9vPNd7Jo2tY4TNUrPrFsFtQ576auXzuNGMdOovM+2v4s1qkdGcarJfGLH1izbhfeHWrG6DhG6vkYE73YSdbTDP7jwJ1m33YEVx/W/0CPQ8d/Kk5nUqGWKDdGS8ddWgx4JJEVqARNT017+1fAfM7eqCj0IdWsK5Ltmxv5n1I4i0KufRqFaPMK0OKevUU8EpQUCPLvrCoCQuJQdg6J6HtdMS/O/TfFJ28R1kd9OrSoLkIpZVct65nIKnZlP5ueRCajXxSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(66476007)(66556008)(2906002)(66946007)(1076003)(44832011)(8936002)(4326008)(30864003)(6666004)(478600001)(26005)(186003)(16526019)(8676002)(7696005)(52116002)(5660300002)(83380400001)(6486002)(956004)(36756003)(316002)(86362001)(6916009)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: qTW8wyPiLF1z5jWulQj5Yg9lJmYJ+Ee5vDfV49q9vXIAK4Rpb2wpZ1xJBJtuCHZ2guuyYMlVuGhrGamblcjo5aJeL1047rTrbmQCMhYfza0gFMDxiNAqHOq2MHYtMtWsiHtSjOBK2qdt6iuHJgyNq4v+Txhkqe7ebzRqpxVdbbYQEp0GGGRsvolpSQse1B9ii2pYnAKDqSIY8WUYlzgCso33wOimvTZ3CxTbOvfkQ0zZr0SqvtZcxG6dfCK8aY6dyxfsUWse7f1jpwsbx3xkeNNFY4u/vs0wAG4S5hq8VkcjurIZ/Gzq08Bvxvw5xT9LbW1GfdzzeCJz85Lj9AnN8SnYVJ6FnmoIDZkMYjfgKtnpwI+AhrPvHANTBai0qAj8C4HQa1U+NKjlaZ2a/EDPwGk+GjmNgSLPaRp+el9j3MAYNvGRmSPQo9019yZve4x1XxW22FKUvJzdxjfqUe2Af1pk81kpk32ZONh9u+RR1FQ3UkLOFx0w/gdfVVV/zwYm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b7d256-390c-4359-3f17-08d81e6cf179
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 09:47:33.2359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HufE9A7D8dvQRHIOETeP6zPscPfVRPd1lPbvpUL34S3hzsNZj6ERjK4qBRSE+zNz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0219
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

This helps to maintain clear code layers and drop unnecessary
parameter.

Change-Id: I2250a014759a0c855e476bbfa9642c1efc47ae26
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c       |  6 +--
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 48 +++++--------------
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  2 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 10 ++--
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    | 12 ++---
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 10 ++--
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 28 +++++++++++
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c     | 28 +++++++++++
 9 files changed, 87 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index fb89204c0070..e16e58ede1ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1461,7 +1461,7 @@ static int amdgpu_debugfs_sclk_set(void *data, u64 val)
 	}
 
 	if (is_support_sw_smu(adev)) {
-		ret = smu_get_dpm_freq_range(&adev->smu, SMU_SCLK, &min_freq, &max_freq, true);
+		ret = smu_get_dpm_freq_range(&adev->smu, SMU_SCLK, &min_freq, &max_freq);
 		if (ret || val > max_freq || val < min_freq)
 			return -EINVAL;
 		ret = smu_set_soft_freq_range(&adev->smu, SMU_SCLK, (uint32_t)val, (uint32_t)val);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
index 65472b3dd815..829715aa1e5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
@@ -911,8 +911,7 @@ int amdgpu_dpm_get_sclk(struct amdgpu_device *adev, bool low)
 	if (is_support_sw_smu(adev)) {
 		ret = smu_get_dpm_freq_range(&adev->smu, SMU_GFXCLK,
 					     low ? &clk_freq : NULL,
-					     !low ? &clk_freq : NULL,
-					     true);
+					     !low ? &clk_freq : NULL);
 		if (ret)
 			return 0;
 		return clk_freq * 100;
@@ -929,8 +928,7 @@ int amdgpu_dpm_get_mclk(struct amdgpu_device *adev, bool low)
 	if (is_support_sw_smu(adev)) {
 		ret = smu_get_dpm_freq_range(&adev->smu, SMU_UCLK,
 					     low ? &clk_freq : NULL,
-					     !low ? &clk_freq : NULL,
-					     true);
+					     !low ? &clk_freq : NULL);
 		if (ret)
 			return 0;
 		return clk_freq * 100;
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 560df8593d32..95685bb9582a 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -261,51 +261,25 @@ int smu_set_soft_freq_range(struct smu_context *smu,
 	return ret;
 }
 
-int smu_get_dpm_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
-			   uint32_t *min, uint32_t *max, bool lock_needed)
+int smu_get_dpm_freq_range(struct smu_context *smu,
+			   enum smu_clk_type clk_type,
+			   uint32_t *min,
+			   uint32_t *max)
 {
-	uint32_t clock_limit;
 	int ret = 0;
 
 	if (!min && !max)
 		return -EINVAL;
 
-	if (lock_needed)
-		mutex_lock(&smu->mutex);
-
-	if (!smu_clk_dpm_is_enabled(smu, clk_type)) {
-		switch (clk_type) {
-		case SMU_MCLK:
-		case SMU_UCLK:
-			clock_limit = smu->smu_table.boot_values.uclk;
-			break;
-		case SMU_GFXCLK:
-		case SMU_SCLK:
-			clock_limit = smu->smu_table.boot_values.gfxclk;
-			break;
-		case SMU_SOCCLK:
-			clock_limit = smu->smu_table.boot_values.socclk;
-			break;
-		default:
-			clock_limit = 0;
-			break;
-		}
+	mutex_lock(&smu->mutex);
 
-		/* clock in Mhz unit */
-		if (min)
-			*min = clock_limit / 100;
-		if (max)
-			*max = clock_limit / 100;
-	} else {
-		/*
-		 * Todo: Use each asic(ASIC_ppt funcs) control the callbacks exposed to the
-		 * core driver and then have helpers for stuff that is common(SMU_v11_x | SMU_v12_x funcs).
-		 */
-		ret = smu_get_dpm_ultimate_freq(smu, clk_type, min, max);
-	}
+	if (smu->ppt_funcs->get_dpm_ultimate_freq)
+		ret = smu->ppt_funcs->get_dpm_ultimate_freq(smu,
+							    clk_type,
+							    min,
+							    max);
 
-	if (lock_needed)
-		mutex_unlock(&smu->mutex);
+	mutex_unlock(&smu->mutex);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index ceabce4b4a5f..ae16cc4c2b2d 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -720,7 +720,7 @@ int smu_get_dpm_freq_by_index(struct smu_context *smu, enum smu_clk_type clk_typ
 int smu_get_dpm_level_count(struct smu_context *smu, enum smu_clk_type clk_type,
 			    uint32_t *value);
 int smu_get_dpm_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
-			   uint32_t *min, uint32_t *max, bool lock_needed);
+			   uint32_t *min, uint32_t *max);
 int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			    uint32_t min, uint32_t max);
 int smu_get_dpm_level_range(struct smu_context *smu, enum smu_clk_type clk_type,
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 1da4f6fc3e7a..d88b2f200d94 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1082,13 +1082,13 @@ static int navi10_populate_umd_state_clk(struct smu_context *smu)
 	int ret = 0;
 	uint32_t min_sclk_freq = 0, min_mclk_freq = 0;
 
-	ret = smu_get_dpm_freq_range(smu, SMU_SCLK, &min_sclk_freq, NULL, false);
+	ret = smu_v11_0_get_dpm_ultimate_freq(smu, SMU_SCLK, &min_sclk_freq, NULL);
 	if (ret)
 		return ret;
 
 	smu->pstate_sclk = min_sclk_freq * 100;
 
-	ret = smu_get_dpm_freq_range(smu, SMU_MCLK, &min_mclk_freq, NULL, false);
+	ret = smu_v11_0_get_dpm_ultimate_freq(smu, SMU_MCLK, &min_mclk_freq, NULL);
 	if (ret)
 		return ret;
 
@@ -1143,7 +1143,7 @@ static int navi10_pre_display_config_changed(struct smu_context *smu)
 		return ret;
 
 	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
-		ret = smu_get_dpm_freq_range(smu, SMU_UCLK, NULL, &max_freq, false);
+		ret = smu_v11_0_get_dpm_ultimate_freq(smu, SMU_UCLK, NULL, &max_freq);
 		if (ret)
 			return ret;
 		ret = smu_v11_0_set_hard_freq_limited_range(smu, SMU_UCLK, 0, max_freq);
@@ -1185,7 +1185,7 @@ static int navi10_force_dpm_limit_value(struct smu_context *smu, bool highest)
 
 	for (i = 0; i < ARRAY_SIZE(clks); i++) {
 		clk_type = clks[i];
-		ret = smu_get_dpm_freq_range(smu, clk_type, &min_freq, &max_freq, false);
+		ret = smu_v11_0_get_dpm_ultimate_freq(smu, clk_type, &min_freq, &max_freq);
 		if (ret)
 			return ret;
 
@@ -1212,7 +1212,7 @@ static int navi10_unforce_dpm_levels(struct smu_context *smu)
 
 	for (i = 0; i < ARRAY_SIZE(clks); i++) {
 		clk_type = clks[i];
-		ret = smu_get_dpm_freq_range(smu, clk_type, &min_freq, &max_freq, false);
+		ret = smu_v11_0_get_dpm_ultimate_freq(smu, clk_type, &min_freq, &max_freq);
 		if (ret)
 			return ret;
 
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 0da8dc3fb7b9..d4aa01a05c54 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -264,7 +264,7 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 	case SMU_SCLK:
 		/* retirve table returned paramters unit is MHz */
 		cur_value = metrics.ClockFrequency[CLOCK_GFXCLK];
-		ret = smu_get_dpm_freq_range(smu, SMU_GFXCLK, &min, &max, false);
+		ret = smu_v12_0_get_dpm_ultimate_freq(smu, SMU_GFXCLK, &min, &max);
 		if (!ret) {
 			/* driver only know min/max gfx_clk, Add level 1 for all other gfx clks */
 			if (cur_value  == max)
@@ -434,7 +434,7 @@ static int renoir_force_dpm_limit_value(struct smu_context *smu, bool highest)
 
 	for (i = 0; i < ARRAY_SIZE(clks); i++) {
 		clk_type = clks[i];
-		ret = smu_get_dpm_freq_range(smu, clk_type, &min_freq, &max_freq, false);
+		ret = smu_v12_0_get_dpm_ultimate_freq(smu, clk_type, &min_freq, &max_freq);
 		if (ret)
 			return ret;
 
@@ -468,7 +468,7 @@ static int renoir_unforce_dpm_levels(struct smu_context *smu) {
 
 		clk_type = clk_feature_map[i].clk_type;
 
-		ret = smu_get_dpm_freq_range(smu, clk_type, &min_freq, &max_freq, false);
+		ret = smu_v12_0_get_dpm_ultimate_freq(smu, clk_type, &min_freq, &max_freq);
 		if (ret)
 			return ret;
 
@@ -633,7 +633,7 @@ static int renoir_force_clk_levels(struct smu_context *smu,
 			return -EINVAL;
 		}
 
-		ret = smu_get_dpm_freq_range(smu, SMU_GFXCLK, &min_freq, &max_freq, false);
+		ret = smu_v12_0_get_dpm_ultimate_freq(smu, SMU_GFXCLK, &min_freq, &max_freq);
 		if (ret)
 			return ret;
 		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk,
@@ -716,7 +716,7 @@ static int renoir_set_peak_clock_by_device(struct smu_context *smu)
 	int ret = 0;
 	uint32_t sclk_freq = 0, uclk_freq = 0;
 
-	ret = smu_get_dpm_freq_range(smu, SMU_SCLK, NULL, &sclk_freq, false);
+	ret = smu_v12_0_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &sclk_freq);
 	if (ret)
 		return ret;
 
@@ -724,7 +724,7 @@ static int renoir_set_peak_clock_by_device(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = smu_get_dpm_freq_range(smu, SMU_UCLK, NULL, &uclk_freq, false);
+	ret = smu_v12_0_get_dpm_ultimate_freq(smu, SMU_UCLK, NULL, &uclk_freq);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 3a2f8c696ac0..dfe192ce33ab 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -929,13 +929,13 @@ static int sienna_cichlid_populate_umd_state_clk(struct smu_context *smu)
 	int ret = 0;
 	uint32_t min_sclk_freq = 0, min_mclk_freq = 0;
 
-	ret = smu_get_dpm_freq_range(smu, SMU_SCLK, &min_sclk_freq, NULL, false);
+	ret = smu_v11_0_get_dpm_ultimate_freq(smu, SMU_SCLK, &min_sclk_freq, NULL);
 	if (ret)
 		return ret;
 
 	smu->pstate_sclk = min_sclk_freq * 100;
 
-	ret = smu_get_dpm_freq_range(smu, SMU_MCLK, &min_mclk_freq, NULL, false);
+	ret = smu_v11_0_get_dpm_ultimate_freq(smu, SMU_MCLK, &min_mclk_freq, NULL);
 	if (ret)
 		return ret;
 
@@ -958,7 +958,7 @@ static int sienna_cichlid_pre_display_config_changed(struct smu_context *smu)
 #endif
 
 	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
-		ret = smu_get_dpm_freq_range(smu, SMU_UCLK, NULL, &max_freq, false);
+		ret = smu_v11_0_get_dpm_ultimate_freq(smu, SMU_UCLK, NULL, &max_freq);
 		if (ret)
 			return ret;
 		ret = smu_v11_0_set_hard_freq_limited_range(smu, SMU_UCLK, 0, max_freq);
@@ -1002,7 +1002,7 @@ static int sienna_cichlid_force_dpm_limit_value(struct smu_context *smu, bool hi
 
 	for (i = 0; i < ARRAY_SIZE(clks); i++) {
 		clk_type = clks[i];
-		ret = smu_get_dpm_freq_range(smu, clk_type, &min_freq, &max_freq, false);
+		ret = smu_v11_0_get_dpm_ultimate_freq(smu, clk_type, &min_freq, &max_freq);
 		if (ret)
 			return ret;
 
@@ -1029,7 +1029,7 @@ static int sienna_cichlid_unforce_dpm_levels(struct smu_context *smu)
 
 	for (i = 0; i < ARRAY_SIZE(clks); i++) {
 		clk_type = clks[i];
-		ret = smu_get_dpm_freq_range(smu, clk_type, &min_freq, &max_freq, false);
+		ret = smu_v11_0_get_dpm_ultimate_freq(smu, clk_type, &min_freq, &max_freq);
 		if (ret)
 			return ret;
 
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 6763b17d11ea..6c8b4230cbe2 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1693,6 +1693,34 @@ int smu_v11_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type c
 {
 	int ret = 0, clk_id = 0;
 	uint32_t param = 0;
+	uint32_t clock_limit;
+
+	if (!smu_clk_dpm_is_enabled(smu, clk_type)) {
+		switch (clk_type) {
+		case SMU_MCLK:
+		case SMU_UCLK:
+			clock_limit = smu->smu_table.boot_values.uclk;
+			break;
+		case SMU_GFXCLK:
+		case SMU_SCLK:
+			clock_limit = smu->smu_table.boot_values.gfxclk;
+			break;
+		case SMU_SOCCLK:
+			clock_limit = smu->smu_table.boot_values.socclk;
+			break;
+		default:
+			clock_limit = 0;
+			break;
+		}
+
+		/* clock in Mhz unit */
+		if (min)
+			*min = clock_limit / 100;
+		if (max)
+			*max = clock_limit / 100;
+
+		return 0;
+	}
 
 	clk_id = smu_clk_get_index(smu, clk_type);
 	if (clk_id < 0) {
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
index e46fc6178235..6400a0acad63 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -321,6 +321,34 @@ int smu_v12_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type c
 {
 	int ret = 0;
 	uint32_t mclk_mask, soc_mask;
+	uint32_t clock_limit;
+
+	if (!smu_clk_dpm_is_enabled(smu, clk_type)) {
+		switch (clk_type) {
+		case SMU_MCLK:
+		case SMU_UCLK:
+			clock_limit = smu->smu_table.boot_values.uclk;
+			break;
+		case SMU_GFXCLK:
+		case SMU_SCLK:
+			clock_limit = smu->smu_table.boot_values.gfxclk;
+			break;
+		case SMU_SOCCLK:
+			clock_limit = smu->smu_table.boot_values.socclk;
+			break;
+		default:
+			clock_limit = 0;
+			break;
+		}
+
+		/* clock in Mhz unit */
+		if (min)
+			*min = clock_limit / 100;
+		if (max)
+			*max = clock_limit / 100;
+
+		return 0;
+	}
 
 	if (max) {
 		ret = smu_get_profiling_clk_mask(smu, AMD_DPM_FORCED_LEVEL_PROFILE_PEAK,
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
