Return-Path: <SRS0=uuOW=AN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C99C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2020 09:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC73020760
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2020 09:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cqlL9DrU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC73020760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B64C06EAB9;
	Thu,  2 Jul 2020 09:47:24 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760045.outbound.protection.outlook.com [40.107.76.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CDD66EAB9
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2020 09:47:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZ6HyzshyeioVmpPtrUYP3+D8Z6l8vq0R5Coa49RXr496d0XPLW/gDnBRLMIKMGK/RqGLAwIQR9X8i/hoj2LilHggRT4kqtYrx1COMHgXregtDaQ9yp+09X84/jC2FpbwKx1P6n1bHo08u/wpbEWqh8EXOKx4sf4n4r+hSlyjHNoj0BhcNHsc5XnISyTRvc/ExvPXUtxBlkMBRqB+Oc5QFExuEzMqykxEhLpJu4bCWx3Ux3b5uHjwwTDb78kEtBNUlcEoEwZi/b7os/fAv7YeCy4oARzq0VP/Iw940CifT+u+MziKzfZOZCnAnXsW7DGGMr/DkVaUJmVvEoyyEODMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXCYs/J8ELSND4nUmtt8ldUZA5jIYda6lcOHm31exY0=;
 b=SM13HqyjpQdZTas/aiBqGaj8TykcjkACGrypnn2rtpa2PHNarmjZtDpOl/Bvpn1f3FPQ5q4S2NcthOcJ9cvgYYnJqhksLAHYxTq3K4FStEDCbi3c+2TJQ8itRtpuyPdXE/T0nJSbqgvoy8R5CvvpOVxbFxjw9o1VFReklyS/N4cTaMgB5K0DWX2HvGMxTvYDAuc6BMFmMOYupCJZOqNCsKVMG8dinR4qdlLKZlEwP/dWYXj6nZhMzyD0oJzmmP0V7ct6sZ7Om/aPvcEyXtuX7z9kwdvycdrEAvGQXNOC8VJ8LPWUv2X6BB569+XRiFm95VLCp9Pmrw6RKt/3UhYp1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXCYs/J8ELSND4nUmtt8ldUZA5jIYda6lcOHm31exY0=;
 b=cqlL9DrUGDPhI7p1VaKIBMGM/qDrijEJn45/1qCtdSt8ius+vgUxHK6DyYMs8lSOWXN6P9xao0fR5Mp0lr4bXiY0jL8DNX8eHf92dPzu9aV/4LKfwGudi0hYoNNDwjtZSXiKrD7pKqP91jWzxqe2gWnOKXOcp2dXCY7eVz0844s=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0219.namprd12.prod.outlook.com (2603:10b6:4:56::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21; Thu, 2 Jul 2020 09:47:23 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.023; Thu, 2 Jul 2020
 09:47:22 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amd/powerplay: put setting hard limit common code in
 smu_v11_0.c
Date: Thu,  2 Jul 2020 17:46:59 +0800
Message-Id: <20200702094702.8223-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: HK2PR04CA0051.apcprd04.prod.outlook.com
 (2603:1096:202:14::19) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0051.apcprd04.prod.outlook.com (2603:1096:202:14::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.23 via Frontend Transport; Thu, 2 Jul 2020 09:47:21 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0360ee07-dde7-4eb7-8ff8-08d81e6ceb33
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02193FEE7190E3499D342CB1E46D0@DM5PR1201MB0219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:255;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IG9IP9hpcrh82n5QpDHfefamMN+AFUJKmQ+vpWeHPHi4bSUcHca/hRunc4VUs8Vwv6GBCjKH59oN+h/3egz6mYtXK3xt2n7MncVpfpnERtOavtsXY3zrgi6CUenNTPmjC1KQTLqbGN7w7weUSOBbfUyqKPj+HjlTyiuUsBk5+nWZwA5RFRkGm6Y7aXOJ4Ibone3vrn3K+JLcgwThvEKfSmWvFW8rYXyCLrv0KMLE2o901gm4bTVdjJztcLlI/YTk6xYwRikatDT2A40+9MGIRO5PHlP6Nm2tAextSpT9m/7LalCH2c5qHwhRaib5/nhIKXrARhcr8vA1CIL5TJqemw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(66476007)(66556008)(2906002)(66946007)(1076003)(44832011)(8936002)(4326008)(6666004)(478600001)(26005)(186003)(16526019)(8676002)(7696005)(52116002)(5660300002)(83380400001)(6486002)(956004)(36756003)(316002)(86362001)(6916009)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: KhUejXiggcSBbw7eKBUOwan6rzNyaQ8RTIiquM9KAuDhprYAm8KWzO7wtrPZB/bMXRkPzvZQbeowTNZVKkGyziK18pSUNKeIvvljqUHbRFHvcp8b/0CuQt57P0rw6icRmA9kTmr3ettiCCT2rUfAezGgJGfsrvt7rGzmuf2NRKQJghtJk8ThrwE+3EWzmRLLaZPUqvdZNqNzmLz/TXyVBNuF5Mok304Xdw15eybaRG62mEbonbLsPZSl+AF3hKRPC3NYA9wAXoFalTg+GckSfrQwIumHJ2TXvsNGi0laLBjr8OYg7UmKXGbpdBLIjfPU4ZuudntPeeOr8GsKWfFyGIi8A9lR2TaL1wUkJm3nexAONxwg8rrf0KCjAx5g+1m3gevHo75ZYzK4wU/lVZDG9Lbpo24LS57NHAneAmjUVnulfsa4opeBzgtLTQt+lgYTdeME3pmLiwsejbxpJd2jiv79655n78KcJYX88SyhzaO3sf1A0DkatxJUH3cJLUGF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0360ee07-dde7-4eb7-8ff8-08d81e6ceb33
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 09:47:22.8588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBjCesJ41658iEyGjqzdH51KxbgnT2dqg22P3pwBZ+0Hvvuu2T1qtR76t1Vbj0kk
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

As designed the common code shared among all smu v11 ASCIs go to
smu_v11_0.c. This helps to maintain clear code layers.

Change-Id: Ib5bd4b40702f1442a4b094d927aa5fc101b960c5
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 36 -----------------
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  2 -
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  5 +++
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 12 +++---
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    |  8 ++--
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 39 ++++++++++++++++++-
 6 files changed, 53 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index fe4948aa662f..fac5288f1502 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -255,42 +255,6 @@ int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 	return ret;
 }
 
-int smu_set_hard_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
-			    uint32_t min, uint32_t max)
-{
-	int ret = 0, clk_id = 0;
-	uint32_t param;
-
-	if (min <= 0 && max <= 0)
-		return -EINVAL;
-
-	if (!smu_clk_dpm_is_enabled(smu, clk_type))
-		return 0;
-
-	clk_id = smu_clk_get_index(smu, clk_type);
-	if (clk_id < 0)
-		return clk_id;
-
-	if (max > 0) {
-		param = (uint32_t)((clk_id << 16) | (max & 0xffff));
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetHardMaxByFreq,
-						  param, NULL);
-		if (ret)
-			return ret;
-	}
-
-	if (min > 0) {
-		param = (uint32_t)((clk_id << 16) | (min & 0xffff));
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinByFreq,
-						  param, NULL);
-		if (ret)
-			return ret;
-	}
-
-
-	return ret;
-}
-
 int smu_get_dpm_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			   uint32_t *min, uint32_t *max, bool lock_needed)
 {
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 43b4a31b0ffd..1070fa414f70 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -723,8 +723,6 @@ int smu_get_dpm_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			   uint32_t *min, uint32_t *max, bool lock_needed);
 int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			    uint32_t min, uint32_t max, bool lock_needed);
-int smu_set_hard_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
-			    uint32_t min, uint32_t max);
 int smu_get_dpm_level_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			    uint32_t *min_value, uint32_t *max_value);
 enum amd_dpm_forced_level smu_get_performance_level(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index f2f0b738fb4c..070f1f0f9926 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -252,6 +252,11 @@ int smu_v11_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type c
 int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			    uint32_t min, uint32_t max);
 
+int smu_v11_0_set_hard_freq_limited_range(struct smu_context *smu,
+					  enum smu_clk_type clk_type,
+					  uint32_t min,
+					  uint32_t max);
+
 int smu_v11_0_override_pcie_parameters(struct smu_context *smu);
 
 int smu_v11_0_set_performance_level(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 1f96a8ac3fa8..47c708cc6817 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1146,7 +1146,7 @@ static int navi10_pre_display_config_changed(struct smu_context *smu)
 		ret = smu_get_dpm_freq_range(smu, SMU_UCLK, NULL, &max_freq, false);
 		if (ret)
 			return ret;
-		ret = smu_set_hard_freq_range(smu, SMU_UCLK, 0, max_freq);
+		ret = smu_v11_0_set_hard_freq_limited_range(smu, SMU_UCLK, 0, max_freq);
 		if (ret)
 			return ret;
 	}
@@ -1549,7 +1549,7 @@ static int navi10_notify_smc_display_config(struct smu_context *smu)
 	}
 
 	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
-		ret = smu_set_hard_freq_range(smu, SMU_UCLK, min_clocks.memory_clock/100, 0);
+		ret = smu_v11_0_set_hard_freq_limited_range(smu, SMU_UCLK, min_clocks.memory_clock/100, 0);
 		if (ret) {
 			dev_err(smu->adev->dev, "[%s] Set hard min uclk failed!", __func__);
 			return ret;
@@ -1921,9 +1921,9 @@ static int navi10_display_disable_memory_clock_switch(struct smu_context *smu,
 		return 0;
 
 	if(disable_memory_clock_switch)
-		ret = smu_set_hard_freq_range(smu, SMU_UCLK, max_memory_clock, 0);
+		ret = smu_v11_0_set_hard_freq_limited_range(smu, SMU_UCLK, max_memory_clock, 0);
 	else
-		ret = smu_set_hard_freq_range(smu, SMU_UCLK, min_memory_clock, 0);
+		ret = smu_v11_0_set_hard_freq_limited_range(smu, SMU_UCLK, min_memory_clock, 0);
 
 	if(!ret)
 		smu->disable_uclk_switch = disable_memory_clock_switch;
@@ -2344,12 +2344,12 @@ static int navi10_disable_umc_cdr_12gbps_workaround(struct smu_context *smu)
 		return ret;
 
 	/* Force UCLK out of the highest DPM */
-	ret = smu_set_hard_freq_range(smu, SMU_UCLK, 0, uclk_min);
+	ret = smu_v11_0_set_hard_freq_limited_range(smu, SMU_UCLK, 0, uclk_min);
 	if (ret)
 		return ret;
 
 	/* Revert the UCLK Hardmax */
-	ret = smu_set_hard_freq_range(smu, SMU_UCLK, 0, uclk_max);
+	ret = smu_v11_0_set_hard_freq_limited_range(smu, SMU_UCLK, 0, uclk_max);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 7078afbd9a6b..1684a364f2e2 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -945,7 +945,7 @@ static int sienna_cichlid_pre_display_config_changed(struct smu_context *smu)
 		ret = smu_get_dpm_freq_range(smu, SMU_UCLK, NULL, &max_freq, false);
 		if (ret)
 			return ret;
-		ret = smu_set_hard_freq_range(smu, SMU_UCLK, 0, max_freq);
+		ret = smu_v11_0_set_hard_freq_limited_range(smu, SMU_UCLK, 0, max_freq);
 		if (ret)
 			return ret;
 	}
@@ -1353,7 +1353,7 @@ static int sienna_cichlid_notify_smc_display_config(struct smu_context *smu)
 	}
 
 	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
-		ret = smu_set_hard_freq_range(smu, SMU_UCLK, min_clocks.memory_clock/100, 0);
+		ret = smu_v11_0_set_hard_freq_limited_range(smu, SMU_UCLK, min_clocks.memory_clock/100, 0);
 		if (ret) {
 			dev_err(smu->adev->dev, "[%s] Set hard min uclk failed!", __func__);
 			return ret;
@@ -1657,9 +1657,9 @@ static int sienna_cichlid_display_disable_memory_clock_switch(struct smu_context
 		return 0;
 
 	if(disable_memory_clock_switch)
-		ret = smu_set_hard_freq_range(smu, SMU_UCLK, max_memory_clock, 0);
+		ret = smu_v11_0_set_hard_freq_limited_range(smu, SMU_UCLK, max_memory_clock, 0);
 	else
-		ret = smu_set_hard_freq_range(smu, SMU_UCLK, min_memory_clock, 0);
+		ret = smu_v11_0_set_hard_freq_limited_range(smu, SMU_UCLK, min_memory_clock, 0);
 
 	if(!ret)
 		smu->disable_uclk_switch = disable_memory_clock_switch;
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 560ddf382e4f..6763b17d11ea 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1192,7 +1192,7 @@ smu_v11_0_display_clock_voltage_request(struct smu_context *smu,
 		if (clk_select == SMU_UCLK && smu->disable_uclk_switch)
 			return 0;
 
-		ret = smu_set_hard_freq_range(smu, clk_select, clk_freq, 0);
+		ret = smu_v11_0_set_hard_freq_limited_range(smu, clk_select, clk_freq, 0);
 
 		if(clk_select == SMU_UCLK)
 			smu->hard_min_uclk_req_from_dal = clk_freq;
@@ -1746,6 +1746,43 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
 	return ret;
 }
 
+int smu_v11_0_set_hard_freq_limited_range(struct smu_context *smu,
+					  enum smu_clk_type clk_type,
+					  uint32_t min,
+					  uint32_t max)
+{
+	int ret = 0, clk_id = 0;
+	uint32_t param;
+
+	if (min <= 0 && max <= 0)
+		return -EINVAL;
+
+	if (!smu_clk_dpm_is_enabled(smu, clk_type))
+		return 0;
+
+	clk_id = smu_clk_get_index(smu, clk_type);
+	if (clk_id < 0)
+		return clk_id;
+
+	if (max > 0) {
+		param = (uint32_t)((clk_id << 16) | (max & 0xffff));
+		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetHardMaxByFreq,
+						  param, NULL);
+		if (ret)
+			return ret;
+	}
+
+	if (min > 0) {
+		param = (uint32_t)((clk_id << 16) | (min & 0xffff));
+		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinByFreq,
+						  param, NULL);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
 int smu_v11_0_override_pcie_parameters(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
