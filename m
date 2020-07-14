Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395DDC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:06:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A1A021582
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="o26maw5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A1A021582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6198896B5;
	Tue, 14 Jul 2020 08:06:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54783896B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 08:06:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFiH+GnmwhF9wbMZy26ftrZ3yMIO74j8W+20WIHe7GO7nKxbsvK8MWb4uJJzt7x8Wpo3SVxg2ITSMBhA4YJmmJldG6KYtXomZ5jKX0cycG5LLYw+iI6g7UUESY6LhhAA3AKughI7itZrX65cfgJnCkZIptvqS82X+njlPWhXEm+WZ0I9GctUcTR/3tRcxz68q3HLdcqsUMXQUcS4yXqvXWvfQiNnibCniiPP3Mtk9EyTb/5Rq62fd95OczZBs/pzZhgTXoAUxROx8aIRMyfDPCrAuOv6NWfiCGN1ZrwpWwZL8+vFcpsMD9AHgeJjJlxQRJyCagSHdPe+04IQCHcBEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJCUzzj5OatJkx3FZmt4Yql9bDjqlWk5vYy+xFgDr+4=;
 b=IVdVMcIsTAqwzqbhFYyMqNYgCf2DUoxbmMkCt8TRfPYDCNl9kcrqzXBzNyJHOaN0nGt3kqquD4fkYLTUQedoarFCLx3lKWc25TqVdoMgxZa0NLm+lve+SOI2msHEmItInihuynMg4eeYZe/y84Qzuu9hemL7ydGo0rn2N4UIcHUTLHaDZAkbjhPbKSzKqE78kcNfCeDRSuxpzetJ91Y01jiLOXSxQ53awYONTqYQdZLjY7zyq8Qu05CZow/yW6dclh8QobdvBMph/E6h1XEgFvhH8Uf8GWKOLMJWJn67dLdIkUBjRqpvl4L9Jv4SJiUS7eO2FRz08pMJBd1Zj1PonQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJCUzzj5OatJkx3FZmt4Yql9bDjqlWk5vYy+xFgDr+4=;
 b=o26maw5laSb02w0/4Bp0MTwDo4VC5u4CxNHRKAmBM346wEHhHx8uGywdfRovNXE2Mz9QwxAQ/MSObcHvRBeZw+P7azsN91dC78ZuHFmiQ/3Y39y2Bm3o6KcwcSShlcwkQZaKveZKwSJ/2uV6tyGsWYljFqqdQHaRife6oONrPrA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Tue, 14 Jul 2020 08:06:44 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 08:06:44 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/17] drm/amd/powerplay: move dpm feature support checking to
 smu_cmn.c
Date: Tue, 14 Jul 2020 16:04:04 +0800
Message-Id: <20200714080416.6506-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714080416.6506-1-evan.quan@amd.com>
References: <20200714080416.6506-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR04CA0078.apcprd04.prod.outlook.com
 (2603:1096:202:15::22) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0078.apcprd04.prod.outlook.com (2603:1096:202:15::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22 via Frontend Transport; Tue, 14 Jul 2020 08:06:43 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a9f62270-d913-4a89-2e4d-08d827ccd911
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4355B45529EB79B13D901FA9E4610@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9EETT1hZcc+r2JkJytYF8mDIa6aOklmn79wcvEDk+VT4xZLzW/wTQlLT5RjI/rYLdpdzpUK+QBdS+jd+MMnPth60ljwSUoOuTABm/FHeaW6twKB/rG2RMHZAwFTSWwCc8DISNNy6xEGVFVHDlryFKlNueynfDzCehjNOxBxYn0WS57AQ0BcNGAGAfngdFf0f9ja4dB6E3yv2n+kyXup95rq1hlGwl6RtbtMqD5AS/g2MqEoPS4PS7VkRg78IAo+g2GUP129J7pwdDJ8DBlNsOeWri3oHKFxysQj2DUzF7nKwAQJiu8bG2ie0xaPFr7RiEO0GvDR75ZzdSn9carXw1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(478600001)(83380400001)(316002)(4326008)(2616005)(8936002)(8676002)(36756003)(66946007)(66556008)(1076003)(44832011)(2906002)(956004)(66476007)(6486002)(5660300002)(52116002)(6666004)(186003)(86362001)(7696005)(16526019)(26005)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: INoGJCHU6poBa+9YQAPgIlC6sMNd5AyBuYXJaBg+tffodIrGbhNB8v6we0ihTLZL4o6JaXcGL6nFo7LZDngl7EG8acWlvY5P6C2S1gT0IiGTwU56fJWQMoGCYEL4hpUH95/PPtq3DhUGhchzP+h+8QaTk8IapUJCMJASm83HgKrEBied7jg85+0EtKYDctnnqHlx55HkO2l6eqcFsMMqDEpxmw+4L84Ii/ORSwhAHrOG5G6wgVvvzZlg7BAJ3aoPspbCM55LVud0oU4ExNEq4tO3oBdOY0dVnkLFoVkxFjIFgFY+9dQnF4LYHNWkK2bKXWk6l5PiRWl7gmSve2iGiQmdA/xYA0zurFxd3p0VZQC/LlKqBqUVOb5iiK8+l4lGbIdlW3LxoZvp4XSQaEvKzj3F3zBx88lH+Up9pR19Qml+v2/bKhEKwcZAg0zcB2cve2m666Q3TjG5ABn/tevRCKZ7w2jcaoyPgngdlKRibZHvR95LPLB2SuVIEa+gdisJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f62270-d913-4a89-2e4d-08d827ccd911
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 08:06:44.3587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c02MEd7pGJ/paWeIxUJgAuY/5qY5K9cBz2iGKdYNSnMoHm3kRHW0L0qto7iW4SJ6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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

Considering it is shared by all ASICs and smu_cmn.c should be
the right place.

Change-Id: Ia006db546842f450669ee9752d962a8d296c03c3
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 21 ------------------
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  2 --
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  8 +++----
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    |  8 +++----
 drivers/gpu/drm/amd/powerplay/smu_cmn.c       | 22 +++++++++++++++++++
 drivers/gpu/drm/amd/powerplay/smu_cmn.h       |  3 +++
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     |  4 ++--
 7 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index cb0aef840d1b..2e030a2c0910 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -569,27 +569,6 @@ int smu_feature_set_enabled(struct smu_context *smu, enum smu_feature_mask mask,
 					       enable);
 }
 
-int smu_feature_is_supported(struct smu_context *smu, enum smu_feature_mask mask)
-{
-	struct smu_feature *feature = &smu->smu_feature;
-	int feature_id;
-	int ret = 0;
-
-	feature_id = smu_cmn_to_asic_specific_index(smu,
-						    CMN2ASIC_MAPPING_FEATURE,
-						    mask);
-	if (feature_id < 0)
-		return 0;
-
-	WARN_ON(feature_id > feature->feature_num);
-
-	mutex_lock(&feature->mutex);
-	ret = test_bit(feature_id, feature->supported);
-	mutex_unlock(&feature->mutex);
-
-	return ret;
-}
-
 static int smu_set_funcs(struct amdgpu_device *adev)
 {
 	struct smu_context *smu = &adev->smu;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 9efbeb2e99aa..771a9b37265b 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -727,8 +727,6 @@ extern int smu_feature_is_enabled(struct smu_context *smu,
 				  enum smu_feature_mask mask);
 extern int smu_feature_set_enabled(struct smu_context *smu,
 				   enum smu_feature_mask mask, bool enable);
-extern int smu_feature_is_supported(struct smu_context *smu,
-				    enum smu_feature_mask mask);
 
 int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int argument,
 		     void *table_data, bool drv2smu);
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 978d9762678a..1626c0dfdcd3 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1265,8 +1265,8 @@ static int navi10_display_config_changed(struct smu_context *smu)
 	int ret = 0;
 
 	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
-	    smu_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
-	    smu_feature_is_supported(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
+	    smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
+	    smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
 		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays,
 						  smu->display_config->num_display,
 						  NULL);
@@ -1543,13 +1543,13 @@ static int navi10_notify_smc_display_config(struct smu_context *smu)
 	min_clocks.dcef_clock_in_sr = smu->display_config->min_dcef_deep_sleep_set_clk;
 	min_clocks.memory_clock = smu->display_config->min_mem_set_clock;
 
-	if (smu_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
 		clock_req.clock_type = amd_pp_dcef_clock;
 		clock_req.clock_freq_in_khz = min_clocks.dcef_clock * 10;
 
 		ret = smu_v11_0_display_clock_voltage_request(smu, &clock_req);
 		if (!ret) {
-			if (smu_feature_is_supported(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {
+			if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {
 				ret = smu_send_smc_msg_with_param(smu,
 								  SMU_MSG_SetMinDeepSleepDcefclk,
 								  min_clocks.dcef_clock_in_sr/100,
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index cbd6f492cbb8..c785065da855 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -1056,8 +1056,8 @@ static int sienna_cichlid_display_config_changed(struct smu_context *smu)
 	int ret = 0;
 
 	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
-	    smu_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
-	    smu_feature_is_supported(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
+	    smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
+	    smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
 #if 0
 		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays,
 						  smu->display_config->num_display,
@@ -1336,13 +1336,13 @@ static int sienna_cichlid_notify_smc_display_config(struct smu_context *smu)
 	min_clocks.dcef_clock_in_sr = smu->display_config->min_dcef_deep_sleep_set_clk;
 	min_clocks.memory_clock = smu->display_config->min_mem_set_clock;
 
-	if (smu_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
 		clock_req.clock_type = amd_pp_dcef_clock;
 		clock_req.clock_freq_in_khz = min_clocks.dcef_clock * 10;
 
 		ret = smu_v11_0_display_clock_voltage_request(smu, &clock_req);
 		if (!ret) {
-			if (smu_feature_is_supported(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {
+			if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {
 				ret = smu_send_smc_msg_with_param(smu,
 								  SMU_MSG_SetMinDeepSleepDcefclk,
 								  min_clocks.dcef_clock_in_sr/100,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.c b/drivers/gpu/drm/amd/powerplay/smu_cmn.c
index 5a76b6b1ac84..f67e12fc95d9 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_cmn.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_cmn.c
@@ -116,3 +116,25 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
 		return -EINVAL;
 	}
 }
+
+int smu_cmn_feature_is_supported(struct smu_context *smu,
+				 enum smu_feature_mask mask)
+{
+	struct smu_feature *feature = &smu->smu_feature;
+	int feature_id;
+	int ret = 0;
+
+	feature_id = smu_cmn_to_asic_specific_index(smu,
+						    CMN2ASIC_MAPPING_FEATURE,
+						    mask);
+	if (feature_id < 0)
+		return 0;
+
+	WARN_ON(feature_id > feature->feature_num);
+
+	mutex_lock(&feature->mutex);
+	ret = test_bit(feature_id, feature->supported);
+	mutex_unlock(&feature->mutex);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.h b/drivers/gpu/drm/amd/powerplay/smu_cmn.h
index fc70645196cc..6e0bd711403a 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_cmn.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_cmn.h
@@ -29,4 +29,7 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
 				   enum smu_cmn2asic_mapping_type type,
 				   uint32_t index);
 
+int smu_cmn_feature_is_supported(struct smu_context *smu,
+				 enum smu_feature_mask mask);
+
 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 979fd3f46c1c..5f2e56f4dc35 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1230,7 +1230,7 @@ smu_v11_0_auto_fan_control(struct smu_context *smu, bool auto_fan_control)
 {
 	int ret = 0;
 
-	if (!smu_feature_is_supported(smu, SMU_FEATURE_FAN_CONTROL_BIT))
+	if (!smu_cmn_feature_is_supported(smu, SMU_FEATURE_FAN_CONTROL_BIT))
 		return 0;
 
 	ret = smu_feature_set_enabled(smu, SMU_FEATURE_FAN_CONTROL_BIT, auto_fan_control);
@@ -1598,7 +1598,7 @@ bool smu_v11_0_baco_is_support(struct smu_context *smu)
 		return false;
 
 	/* Arcturus does not support this bit mask */
-	if (smu_feature_is_supported(smu, SMU_FEATURE_BACO_BIT) &&
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_BACO_BIT) &&
 	   !smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT))
 		return false;
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
