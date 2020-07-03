Return-Path: <SRS0=khk6=AO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F80C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:34:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3DF3207FF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ktTm9FKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3DF3207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D1276EB3A;
	Fri,  3 Jul 2020 08:34:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 522076EB3A
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2020 08:34:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AznoRCLa1GRjR/wsDzWvH60svngLhPLwkt9PWMLQoIk/eFctcdV0/P9Y0fzGzvcqKvQ7ahYvvMQaDF6/9dXTAjdrKuPPwA3gD7L6G+fPBnb1U6CkfMnswYU+wJtEDSh+ytKfx1QQzYed4ZRVkswKWyZ2fl8BuIrCH99ZHObnmGzqFSEsBSk/N46cV3AX+5oKOUCHQdSZFvOZlvxpQ+B5bgKPjqBU0BjSG3ton48CdSf6r8rGluHtJc/1Kn/FCkkHb52dfJqIEQuosbielJC0uvjkbDYE/DcO9A9Bogdy7koGJL9pt509nYwAuKNe5dHPRJcp2xu9JjBIbDNhz555og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAzelHUhQmNzwrJyKXxADkeQb4HB5voDOakQhY1uQc4=;
 b=OExa59TdUDnBvqh1GlLUiPRdfBDC9dx5oeQfw5tQlMQCUTpJ96TbcQQwxgusC450eW7rXogq0w8yUb2iiVdUsty5GJZ7YvyBPROBBW9TCnt9EONug3r+F/c6+AD2REeaNNRVCv5wMKmz2LSIxSr1HeCaet+xcj3npcTZAXeu1fRPpTG+APRnIHlBp6GjPBmfEvgy+y0wB/TF4fnerMZhCGpjXsrjP2Aq4CkZ5WU83WKU25G2lAyRHvHpDBGZm2c+eX2dxsVv2eXgvheibZrxUM4IWCB6kK0kgnJWLEE5FB7W599wFdyPUANKrMSOgjc2WnJKPXN3+aZfXJalWHS1Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAzelHUhQmNzwrJyKXxADkeQb4HB5voDOakQhY1uQc4=;
 b=ktTm9FKlgGk/T3Z1OqqDU2mT9wbiMAuDdtCE+aPJFIips/zmcPM/+06wwa2rRLpma7oLYbpkTZt8qkT/b4buOxBlegXfwPYM1ZzCHFeuYNTnYi8A1Ckc7Ml84VfUnJX0syP4lOH9CG53InIqIT3TWSGGd+Lvk3cvbbo762nIh+0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.27; Fri, 3 Jul 2020 08:34:10 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 08:34:10 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/14] drm/amd/powerplay: drop smu_v12_0.c unnecessary wrapper
Date: Fri,  3 Jul 2020 16:33:02 +0800
Message-Id: <20200703083303.478-13-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200703083303.478-1-evan.quan@amd.com>
References: <20200703083303.478-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0139.apcprd02.prod.outlook.com
 (2603:1096:202:16::23) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0139.apcprd02.prod.outlook.com (2603:1096:202:16::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.22 via Frontend Transport; Fri, 3 Jul 2020 08:34:08 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b00c5bcb-d222-430c-19de-08d81f2bdb7c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3962:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB39620F4353A42CC985005BEFE46A0@DM6PR12MB3962.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yT4sQZGNCZgzcb4q9pJZLAgS8xzvdzAum473vULFMJ0+/HY53KVphCbmPtbvXpUwpBJ+WSytP/fPhqpAwwOWvnJFzglEuKq3ZgCDvnyVHsjHBeWHidhApiFtKjV219QA+pGfSnC827KzR9HDSzDnNonXvj1TeXsefoU1BB+VTvVQ84yD3F4UB786cB5yhpbd5EsENh2Zq35iSghNRHfWBCqE8+Ty2wwOULZXB21ZrbnLaDGmS4WfiUQfCEyfpK1kL/L2FeOsfKZFPCIhDq9uo32Ipqxk59yw17ROrZJvh/8QN2YytFEOE9GptyxKoAFEJi2pdGGYVIhc9ddgT0sMPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(83380400001)(44832011)(4326008)(36756003)(8936002)(7696005)(956004)(2616005)(6486002)(52116002)(478600001)(6666004)(66946007)(16526019)(26005)(186003)(66476007)(30864003)(5660300002)(1076003)(66556008)(8676002)(316002)(86362001)(6916009)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 2fHeNzgpqhDGv5gnu3wUe6Jmx1C8QO170K8cJ7/9E9aBG00aP9am4eUGEHLXV1zw57iR0HHzGWk4RJtl9Z49ds8zMPdyNu+WsLqaSgGHgm7UyM8NIZXsWjGB5rQJVr3TJ6fZzgpDpKOqhZ+EtIvQPT5CbsZ7pjDwATOxOjngzCHHYaLp+3vm4ZfXEZQw7RKfHdm350P0hG/QRo9ELX2HNY4cZRVL/7oDiTdePrkXIVh1DSVg8aWeuIKq251EdmW2y1J6uy4K4feCtoBWAui+RucZvy8rIjltk9q9p5lkoN7m/2C1p1du3eCh2bzQkIM5vs+n89dE30Kn8EkwQ/NYzRNrbuORL5gTFfF4ZV+PIptbmCo6+kBIymvIYfxkTsO0S6TyMl+oxZ2ZNPb/Db1DSQ0i4XG+/P0wOS4w8BeLMWpb97WLLOo/iu75JMBwN7cGVyrtlRc5pE3+ESVCiu8IKYF7e8fGwjstwpJr44YcdQqlo4GhDJMcGuf5vw9lqUcx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b00c5bcb-d222-430c-19de-08d81f2bdb7c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 08:34:10.2441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7HMFtRcHZdRRU5rX+MQ+MEkrXuNUTl35Oi4IDbxwZBUK1HsDFZAFoxTBsLyDePJR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3962
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

By moving the implemention to renoir_ppt.c considering
it's really ASIC specific.

Change-Id: I6f7a594235dffdf75b56d1de5b9dc6d49833d7e8
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h |   3 -
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    | 172 ++++++++++++++----
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c     | 100 ----------
 3 files changed, 138 insertions(+), 137 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
index 0c1e1455c68f..fd83a723f32c 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
@@ -73,9 +73,6 @@ int smu_v12_0_set_default_dpm_tables(struct smu_context *smu);
 int smu_v12_0_get_enabled_mask(struct smu_context *smu,
 				      uint32_t *feature_mask, uint32_t num);
 
-int smu_v12_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type clk_type,
-						 uint32_t *min, uint32_t *max);
-
 int smu_v12_0_mode2_reset(struct smu_context *smu);
 
 int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_type clk_type,
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 49a8d636ef4d..5b76d67d03d7 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -241,6 +241,137 @@ static int renoir_get_dpm_clk_limited(struct smu_context *smu, enum smu_clk_type
 	return 0;
 }
 
+static int renoir_get_profiling_clk_mask(struct smu_context *smu,
+					 enum amd_dpm_forced_level level,
+					 uint32_t *sclk_mask,
+					 uint32_t *mclk_mask,
+					 uint32_t *soc_mask)
+{
+
+	if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK) {
+		if (sclk_mask)
+			*sclk_mask = 0;
+	} else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK) {
+		if (mclk_mask)
+			*mclk_mask = 0;
+	} else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK) {
+		if(sclk_mask)
+			/* The sclk as gfxclk and has three level about max/min/current */
+			*sclk_mask = 3 - 1;
+
+		if(mclk_mask)
+			*mclk_mask = NUM_MEMCLK_DPM_LEVELS - 1;
+
+		if(soc_mask)
+			*soc_mask = NUM_SOCCLK_DPM_LEVELS - 1;
+	}
+
+	return 0;
+}
+
+static int renoir_get_dpm_ultimate_freq(struct smu_context *smu,
+					enum smu_clk_type clk_type,
+					uint32_t *min,
+					uint32_t *max)
+{
+	int ret = 0;
+	uint32_t mclk_mask, soc_mask;
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
+
+	if (max) {
+		ret = renoir_get_profiling_clk_mask(smu,
+						    AMD_DPM_FORCED_LEVEL_PROFILE_PEAK,
+						    NULL,
+						    &mclk_mask,
+						    &soc_mask);
+		if (ret)
+			goto failed;
+
+		switch (clk_type) {
+		case SMU_GFXCLK:
+		case SMU_SCLK:
+			ret = smu_send_smc_msg(smu, SMU_MSG_GetMaxGfxclkFrequency, max);
+			if (ret) {
+				dev_err(smu->adev->dev, "Attempt to get max GX frequency from SMC Failed !\n");
+				goto failed;
+			}
+			break;
+		case SMU_UCLK:
+		case SMU_FCLK:
+		case SMU_MCLK:
+			ret = renoir_get_dpm_clk_limited(smu, clk_type, mclk_mask, max);
+			if (ret)
+				goto failed;
+			break;
+		case SMU_SOCCLK:
+			ret = renoir_get_dpm_clk_limited(smu, clk_type, soc_mask, max);
+			if (ret)
+				goto failed;
+			break;
+		default:
+			ret = -EINVAL;
+			goto failed;
+		}
+	}
+
+	if (min) {
+		switch (clk_type) {
+		case SMU_GFXCLK:
+		case SMU_SCLK:
+			ret = smu_send_smc_msg(smu, SMU_MSG_GetMinGfxclkFrequency, min);
+			if (ret) {
+				dev_err(smu->adev->dev, "Attempt to get min GX frequency from SMC Failed !\n");
+				goto failed;
+			}
+			break;
+		case SMU_UCLK:
+		case SMU_FCLK:
+		case SMU_MCLK:
+			ret = renoir_get_dpm_clk_limited(smu, clk_type, 0, min);
+			if (ret)
+				goto failed;
+			break;
+		case SMU_SOCCLK:
+			ret = renoir_get_dpm_clk_limited(smu, clk_type, 0, min);
+			if (ret)
+				goto failed;
+			break;
+		default:
+			ret = -EINVAL;
+			goto failed;
+		}
+	}
+failed:
+	return ret;
+}
+
 static int renoir_print_clk_levels(struct smu_context *smu,
 			enum smu_clk_type clk_type, char *buf)
 {
@@ -264,7 +395,7 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 	case SMU_SCLK:
 		/* retirve table returned paramters unit is MHz */
 		cur_value = metrics.ClockFrequency[CLOCK_GFXCLK];
-		ret = smu_v12_0_get_dpm_ultimate_freq(smu, SMU_GFXCLK, &min, &max);
+		ret = renoir_get_dpm_ultimate_freq(smu, SMU_GFXCLK, &min, &max);
 		if (!ret) {
 			/* driver only know min/max gfx_clk, Add level 1 for all other gfx clks */
 			if (cur_value  == max)
@@ -434,7 +565,7 @@ static int renoir_force_dpm_limit_value(struct smu_context *smu, bool highest)
 
 	for (i = 0; i < ARRAY_SIZE(clks); i++) {
 		clk_type = clks[i];
-		ret = smu_v12_0_get_dpm_ultimate_freq(smu, clk_type, &min_freq, &max_freq);
+		ret = renoir_get_dpm_ultimate_freq(smu, clk_type, &min_freq, &max_freq);
 		if (ret)
 			return ret;
 
@@ -468,7 +599,7 @@ static int renoir_unforce_dpm_levels(struct smu_context *smu) {
 
 		clk_type = clk_feature_map[i].clk_type;
 
-		ret = smu_v12_0_get_dpm_ultimate_freq(smu, clk_type, &min_freq, &max_freq);
+		ret = renoir_get_dpm_ultimate_freq(smu, clk_type, &min_freq, &max_freq);
 		if (ret)
 			return ret;
 
@@ -552,33 +683,6 @@ static int renoir_get_workload_type(struct smu_context *smu, uint32_t profile)
 	return pplib_workload;
 }
 
-static int renoir_get_profiling_clk_mask(struct smu_context *smu,
-					 enum amd_dpm_forced_level level,
-					 uint32_t *sclk_mask,
-					 uint32_t *mclk_mask,
-					 uint32_t *soc_mask)
-{
-
-	if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK) {
-		if (sclk_mask)
-			*sclk_mask = 0;
-	} else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK) {
-		if (mclk_mask)
-			*mclk_mask = 0;
-	} else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK) {
-		if(sclk_mask)
-			/* The sclk as gfxclk and has three level about max/min/current */
-			*sclk_mask = 3 - 1;
-
-		if(mclk_mask)
-			*mclk_mask = NUM_MEMCLK_DPM_LEVELS - 1;
-
-		if(soc_mask)
-			*soc_mask = NUM_SOCCLK_DPM_LEVELS - 1;
-	}
-
-	return 0;
-}
 
 /**
  * This interface get dpm clock table for dc
@@ -633,7 +737,7 @@ static int renoir_force_clk_levels(struct smu_context *smu,
 			return -EINVAL;
 		}
 
-		ret = smu_v12_0_get_dpm_ultimate_freq(smu, SMU_GFXCLK, &min_freq, &max_freq);
+		ret = renoir_get_dpm_ultimate_freq(smu, SMU_GFXCLK, &min_freq, &max_freq);
 		if (ret)
 			return ret;
 		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk,
@@ -716,7 +820,7 @@ static int renoir_set_peak_clock_by_device(struct smu_context *smu)
 	int ret = 0;
 	uint32_t sclk_freq = 0, uclk_freq = 0;
 
-	ret = smu_v12_0_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &sclk_freq);
+	ret = renoir_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &sclk_freq);
 	if (ret)
 		return ret;
 
@@ -724,7 +828,7 @@ static int renoir_set_peak_clock_by_device(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = smu_v12_0_get_dpm_ultimate_freq(smu, SMU_UCLK, NULL, &uclk_freq);
+	ret = renoir_get_dpm_ultimate_freq(smu, SMU_UCLK, NULL, &uclk_freq);
 	if (ret)
 		return ret;
 
@@ -961,7 +1065,7 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 	.fini_smc_tables = smu_v12_0_fini_smc_tables,
 	.set_default_dpm_table = smu_v12_0_set_default_dpm_tables,
 	.get_enabled_mask = smu_v12_0_get_enabled_mask,
-	.get_dpm_ultimate_freq = smu_v12_0_get_dpm_ultimate_freq,
+	.get_dpm_ultimate_freq = renoir_get_dpm_ultimate_freq,
 	.mode2_reset = smu_v12_0_mode2_reset,
 	.set_soft_freq_limited_range = smu_v12_0_set_soft_freq_limited_range,
 	.set_driver_table_location = smu_v12_0_set_driver_table_location,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
index 6400a0acad63..4e1b11d07438 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -316,106 +316,6 @@ int smu_v12_0_get_enabled_mask(struct smu_context *smu,
 	return ret;
 }
 
-int smu_v12_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type clk_type,
-						 uint32_t *min, uint32_t *max)
-{
-	int ret = 0;
-	uint32_t mclk_mask, soc_mask;
-	uint32_t clock_limit;
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
-
-		/* clock in Mhz unit */
-		if (min)
-			*min = clock_limit / 100;
-		if (max)
-			*max = clock_limit / 100;
-
-		return 0;
-	}
-
-	if (max) {
-		ret = smu_get_profiling_clk_mask(smu, AMD_DPM_FORCED_LEVEL_PROFILE_PEAK,
-						 NULL,
-						 &mclk_mask,
-						 &soc_mask);
-		if (ret)
-			goto failed;
-
-		switch (clk_type) {
-		case SMU_GFXCLK:
-		case SMU_SCLK:
-			ret = smu_send_smc_msg(smu, SMU_MSG_GetMaxGfxclkFrequency, max);
-			if (ret) {
-				dev_err(smu->adev->dev, "Attempt to get max GX frequency from SMC Failed !\n");
-				goto failed;
-			}
-			break;
-		case SMU_UCLK:
-		case SMU_FCLK:
-		case SMU_MCLK:
-			ret = smu_get_dpm_clk_limited(smu, clk_type, mclk_mask, max);
-			if (ret)
-				goto failed;
-			break;
-		case SMU_SOCCLK:
-			ret = smu_get_dpm_clk_limited(smu, clk_type, soc_mask, max);
-			if (ret)
-				goto failed;
-			break;
-		default:
-			ret = -EINVAL;
-			goto failed;
-		}
-	}
-
-	if (min) {
-		switch (clk_type) {
-		case SMU_GFXCLK:
-		case SMU_SCLK:
-			ret = smu_send_smc_msg(smu, SMU_MSG_GetMinGfxclkFrequency, min);
-			if (ret) {
-				dev_err(smu->adev->dev, "Attempt to get min GX frequency from SMC Failed !\n");
-				goto failed;
-			}
-			break;
-		case SMU_UCLK:
-		case SMU_FCLK:
-		case SMU_MCLK:
-			ret = smu_get_dpm_clk_limited(smu, clk_type, 0, min);
-			if (ret)
-				goto failed;
-			break;
-		case SMU_SOCCLK:
-			ret = smu_get_dpm_clk_limited(smu, clk_type, 0, min);
-			if (ret)
-				goto failed;
-			break;
-		default:
-			ret = -EINVAL;
-			goto failed;
-		}
-	}
-failed:
-	return ret;
-}
-
 int smu_v12_0_mode2_reset(struct smu_context *smu){
 	return smu_v12_0_send_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset, SMU_RESET_MODE_2, NULL);
 }
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
