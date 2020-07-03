Return-Path: <SRS0=khk6=AO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAC2C433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0CA620836
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xSPQatkV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0CA620836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 817296E093;
	Fri,  3 Jul 2020 08:33:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5DF16E093
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2020 08:33:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0DuNJO7uGTo6O9XLbli6JlWij3yGemqGC8tQrdy0VcQIbAbtTcEyG5VMrfpwgmCmy7ciy5c43RDn9LLDmwzWuUA0LrlFiTYFKqNH6Ksyou+W6boxA838n4Ct32i2F38nUGyQkg0qbkCEEO7HKliYULLhNRzb3gU2qCRmBQ3QA056qA6OG/t5pa1c9Y26Sb5XJowa6cMjDcYIDWjDf4wBufE0Scr4iQusu6ziwCzjKN8Dtv0ttl+9Ie9AG4N1Akdw+QuKrm6DPxTcfDjOkIzCrC7Q/gjfBxFW1MQkIE0eGxEZhi+lbbkqdbfC3eyY28o7b4LM2izCfgAoPnS+Otq2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3yF3F+QBuJ8f7hKYTz65ZD2lITCa/0Icb/jNieoIec=;
 b=EFNFXZBwfCGTLUxSAmNmoFvJvwoM7Slq4zSnlXOwX17/wOjWj0tLngMpzFgGo464sYZiA5corFhC1XOLXR1M66Lu3cAxvwweCU/X7JetJu22peX/lIFqzTEiwkM7z9aquva+g51CyLX3umLRLgOfgK7m8LkWhrgwuAUlvtIXkKv4reTRq3KFjWIcYs5GEI0+dTek0wWhu1qtBhU4067ZwA3snWONQCG1Fl3ioWm2QfYwlaRV1M8LoJn7vzaZi9PAybmh06EDY6s+vKYjpEpzPzA2c9WwKKkFrsEGEs7RP1pbs+gswo6E+fx8RrI/QkWYoF03bCn3aI6BM3f5+qAu3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3yF3F+QBuJ8f7hKYTz65ZD2lITCa/0Icb/jNieoIec=;
 b=xSPQatkVE57KsCykqNgyJ+NPxM8kiLOoLmZNTNy89GR0RZUKo+cFTl096ziVUDFIo5DB/wY6VCL4VJZ6U+5g2c3kykahJXTMI/B1kg8crf1xhUqAV7HKITSjVJqYwvPkkj1bHu4ITlwCRvAFDBzX/08BWVzMmCH98p1pJPKA4Uo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.27; Fri, 3 Jul 2020 08:33:33 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 08:33:33 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/14] drm/amd/powerplay: update Arcturus default dpm table
 setting
Date: Fri,  3 Jul 2020 16:32:51 +0800
Message-Id: <20200703083303.478-2-evan.quan@amd.com>
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
 15.20.3153.22 via Frontend Transport; Fri, 3 Jul 2020 08:33:31 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 60a0cc44-d6d0-4c70-9fe3-08d81f2bc55e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3962:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3962A707C306E9DBDE545A9BE46A0@DM6PR12MB3962.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:198;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xyXwsdzpQjMJmTOEh+tKXeucrsjvao4esRWqyU+8a5YA7fzRYbsZ5JdtUmwZfEhW3Y5CZSsmw1MjA+uf68jdEXEgtIGZcRejOfB7NBLyKE7cX9CIcOZNZnI1an9lkN58qVelhn+TujG8THflO1LQJhgHWTFSaMNVYItFEl0UJ0jFbR9WVEbnPwJ6mF3cLbnSJvWAwP+n9AGFtCLDXR+alOcTI5ddQZWhWq+mNijn5gW1eKx3XdKz1wX+mkA863PaIBWejPC3FTVDB/TSoj6/5faeeEhMou8kptH6YqDxkBejf2IeDqLsPksKKqDxOiPeTHsxCmi/i2NS7L8StqzrOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(83380400001)(44832011)(4326008)(36756003)(8936002)(7696005)(956004)(2616005)(6486002)(52116002)(478600001)(6666004)(66946007)(16526019)(26005)(186003)(66476007)(30864003)(5660300002)(1076003)(66556008)(8676002)(316002)(86362001)(6916009)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: rytmiX7lDFJhM5ghlLZYeWQVXAA8t2FUk5hYOZo+IqXrecbt79kunjPq0bwFVXuetFzLDt069sqcJPMK0kFrTCl4LDlgb4czdNEtYz9CjgK8gI/VT0fHWgL8KtE9bxbYwNVy+CjTPBtfdDEjb+cdwJHDOZXz3jK5wb/WniuicdkpWMHbeDCEKRzkIe5OZMN90ZiLVUDH8NzOeoFvQA6leDvpopHgUI1XhPNsWKGrVdNUjcmxlZMFxka8EE2AjOtYWwK871x9FYt+HuCCL54D3OllnFkc5HIixSHpKpIVVjS/zf55IFgR7NXx2QmaRnIGon8I+C6uZb3G8ieWDKQ6KCJ7tccomZ41vTfJ7h59Vf6VjbhMRy4SRqgzC9gwFk0tUcXVBT8Fz7pVAl4wHrbjQIOQHSIV/eTqd19S6qe9vVIzLfiDEksWI25uHh8eZQkqz2t06mEIh/FW+drNHeownXKnAGCl1sAR2bDpqyylrozYknJVsT6GlTJp9/NUQAJu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a0cc44-d6d0-4c70-9fe3-08d81f2bc55e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 08:33:33.3679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMbm20vUk55560CbmPTjln78FpmEJkf2dvwJ+BsT3yLuSNbhnb/II1UeZNmrprUP
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

Preparing for coming code sharing around performance level
setting.

Change-Id: Ie32b6af39f22d05c08096959bab0e02e53856170
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 297 +++++++-----------
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |   4 +
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     |  38 +++
 3 files changed, 161 insertions(+), 178 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 5b793e354704..a3747ab4af32 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -291,7 +291,6 @@ static int arcturus_get_pwr_src_index(struct smu_context *smc, uint32_t index)
 	return mapping.map_to;
 }
 
-
 static int arcturus_get_workload_type(struct smu_context *smu, enum PP_SMC_POWER_PROFILE profile)
 {
 	struct smu_11_0_cmn2aisc_mapping mapping;
@@ -338,23 +337,11 @@ static int arcturus_allocate_dpm_context(struct smu_context *smu)
 {
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 
-	if (smu_dpm->dpm_context)
-		return -EINVAL;
-
-	smu_dpm->dpm_context = kzalloc(sizeof(struct arcturus_dpm_table),
+	smu_dpm->dpm_context = kzalloc(sizeof(struct smu_11_0_dpm_context),
 				       GFP_KERNEL);
 	if (!smu_dpm->dpm_context)
 		return -ENOMEM;
-
-	if (smu_dpm->golden_dpm_context)
-		return -EINVAL;
-
-	smu_dpm->golden_dpm_context = kzalloc(sizeof(struct arcturus_dpm_table),
-					      GFP_KERNEL);
-	if (!smu_dpm->golden_dpm_context)
-		return -ENOMEM;
-
-	smu_dpm->dpm_context_size = sizeof(struct arcturus_dpm_table);
+	smu_dpm->dpm_context_size = sizeof(struct smu_11_0_dpm_context);
 
 	smu_dpm->dpm_current_power_state = kzalloc(sizeof(struct smu_power_state),
 				       GFP_KERNEL);
@@ -382,119 +369,84 @@ arcturus_get_allowed_feature_mask(struct smu_context *smu,
 	return 0;
 }
 
-static int
-arcturus_set_single_dpm_table(struct smu_context *smu,
-			    struct arcturus_single_dpm_table *single_dpm_table,
-			    PPCLK_e clk_id)
-{
-	int ret = 0;
-	uint32_t i, num_of_levels = 0, clk;
-
-	ret = smu_send_smc_msg_with_param(smu,
-			SMU_MSG_GetDpmFreqByIndex,
-			(clk_id << 16 | 0xFF),
-			&num_of_levels);
-	if (ret) {
-		dev_err(smu->adev->dev, "[%s] failed to get dpm levels!\n", __func__);
-		return ret;
-	}
-
-	single_dpm_table->count = num_of_levels;
-	for (i = 0; i < num_of_levels; i++) {
-		ret = smu_send_smc_msg_with_param(smu,
-				SMU_MSG_GetDpmFreqByIndex,
-				(clk_id << 16 | i),
-				&clk);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] failed to get dpm freq by index!\n", __func__);
-			return ret;
-		}
-		single_dpm_table->dpm_levels[i].value = clk;
-		single_dpm_table->dpm_levels[i].enabled = true;
-	}
-	return 0;
-}
-
-static void arcturus_init_single_dpm_state(struct arcturus_dpm_state *dpm_state)
-{
-	dpm_state->soft_min_level = 0x0;
-	dpm_state->soft_max_level = 0xffff;
-        dpm_state->hard_min_level = 0x0;
-        dpm_state->hard_max_level = 0xffff;
-}
-
 static int arcturus_set_default_dpm_table(struct smu_context *smu)
 {
-	int ret;
-
-	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
-	struct arcturus_dpm_table *dpm_table = NULL;
-	struct arcturus_single_dpm_table *single_dpm_table;
-
-	dpm_table = smu_dpm->dpm_context;
+	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+	PPTable_t *driver_ppt = smu->smu_table.driver_pptable;
+	struct smu_11_0_dpm_table *dpm_table = NULL;
+	int ret = 0;
 
-	/* socclk */
-	single_dpm_table = &(dpm_table->soc_table);
+	/* socclk dpm table setup */
+	dpm_table = &dpm_context->dpm_tables.soc_table;
 	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
-		ret = arcturus_set_single_dpm_table(smu, single_dpm_table,
-						  PPCLK_SOCCLK);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] failed to get socclk dpm levels!\n", __func__);
+		ret = smu_v11_0_set_single_dpm_table(smu,
+						     SMU_SOCCLK,
+						     dpm_table);
+		if (ret)
 			return ret;
-		}
+		dpm_table->is_fine_grained =
+			!driver_ppt->DpmDescriptor[PPCLK_SOCCLK].SnapToDiscrete;
 	} else {
-		single_dpm_table->count = 1;
-		single_dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.socclk / 100;
+		dpm_table->count = 1;
+		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.socclk / 100;
+		dpm_table->dpm_levels[0].enabled = true;
+		dpm_table->min = dpm_table->dpm_levels[0].value;
+		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
-	arcturus_init_single_dpm_state(&(single_dpm_table->dpm_state));
 
-	/* gfxclk */
-	single_dpm_table = &(dpm_table->gfx_table);
+	/* gfxclk dpm table setup */
+	dpm_table = &dpm_context->dpm_tables.gfx_table;
 	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT)) {
-		ret = arcturus_set_single_dpm_table(smu, single_dpm_table,
-						  PPCLK_GFXCLK);
-		if (ret) {
-			dev_err(smu->adev->dev, "[SetupDefaultDpmTable] failed to get gfxclk dpm levels!");
+		ret = smu_v11_0_set_single_dpm_table(smu,
+						     SMU_GFXCLK,
+						     dpm_table);
+		if (ret)
 			return ret;
-		}
+		dpm_table->is_fine_grained =
+			!driver_ppt->DpmDescriptor[PPCLK_GFXCLK].SnapToDiscrete;
 	} else {
-		single_dpm_table->count = 1;
-		single_dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.gfxclk / 100;
+		dpm_table->count = 1;
+		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.gfxclk / 100;
+		dpm_table->dpm_levels[0].enabled = true;
+		dpm_table->min = dpm_table->dpm_levels[0].value;
+		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
-	arcturus_init_single_dpm_state(&(single_dpm_table->dpm_state));
 
-	/* memclk */
-	single_dpm_table = &(dpm_table->mem_table);
+	/* memclk dpm table setup */
+	dpm_table = &dpm_context->dpm_tables.uclk_table;
 	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
-		ret = arcturus_set_single_dpm_table(smu, single_dpm_table,
-						  PPCLK_UCLK);
-		if (ret) {
-			dev_err(smu->adev->dev, "[SetupDefaultDpmTable] failed to get memclk dpm levels!");
+		ret = smu_v11_0_set_single_dpm_table(smu,
+						     SMU_UCLK,
+						     dpm_table);
+		if (ret)
 			return ret;
-		}
+		dpm_table->is_fine_grained =
+			!driver_ppt->DpmDescriptor[PPCLK_UCLK].SnapToDiscrete;
 	} else {
-		single_dpm_table->count = 1;
-		single_dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.uclk / 100;
+		dpm_table->count = 1;
+		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.uclk / 100;
+		dpm_table->dpm_levels[0].enabled = true;
+		dpm_table->min = dpm_table->dpm_levels[0].value;
+		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
-	arcturus_init_single_dpm_state(&(single_dpm_table->dpm_state));
 
-	/* fclk */
-	single_dpm_table = &(dpm_table->fclk_table);
+	/* fclk dpm table setup */
+	dpm_table = &dpm_context->dpm_tables.fclk_table;
 	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_FCLK_BIT)) {
-		ret = arcturus_set_single_dpm_table(smu, single_dpm_table,
-						  PPCLK_FCLK);
-		if (ret) {
-			dev_err(smu->adev->dev, "[SetupDefaultDpmTable] failed to get fclk dpm levels!");
+		ret = smu_v11_0_set_single_dpm_table(smu,
+						     SMU_FCLK,
+						     dpm_table);
+		if (ret)
 			return ret;
-		}
+		dpm_table->is_fine_grained =
+			!driver_ppt->DpmDescriptor[PPCLK_FCLK].SnapToDiscrete;
 	} else {
-		single_dpm_table->count = 1;
-		single_dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.fclk / 100;
+		dpm_table->count = 1;
+		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.fclk / 100;
+		dpm_table->dpm_levels[0].enabled = true;
+		dpm_table->min = dpm_table->dpm_levels[0].value;
+		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
-	arcturus_init_single_dpm_state(&(single_dpm_table->dpm_state));
-
-	memcpy(smu_dpm->golden_dpm_context, dpm_table,
-	       sizeof(struct arcturus_dpm_table));
 
 	return 0;
 }
@@ -622,7 +574,7 @@ static int arcturus_populate_umd_state_clk(struct smu_context *smu)
 
 static int arcturus_get_clk_table(struct smu_context *smu,
 			struct pp_clock_levels_with_latency *clocks,
-			struct arcturus_single_dpm_table *dpm_table)
+			struct smu_11_0_dpm_table *dpm_table)
 {
 	int i, count;
 
@@ -824,14 +776,14 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 	int i, now, size = 0;
 	int ret = 0;
 	struct pp_clock_levels_with_latency clocks;
-	struct arcturus_single_dpm_table *single_dpm_table;
+	struct smu_11_0_dpm_table *single_dpm_table;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
-	struct arcturus_dpm_table *dpm_table = NULL;
+	struct smu_11_0_dpm_context *dpm_context = NULL;
 
 	if (amdgpu_ras_intr_triggered())
 		return snprintf(buf, PAGE_SIZE, "unavailable\n");
 
-	dpm_table = smu_dpm->dpm_context;
+	dpm_context = smu_dpm->dpm_context;
 
 	switch (type) {
 	case SMU_SCLK:
@@ -841,7 +793,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 			return ret;
 		}
 
-		single_dpm_table = &(dpm_table->gfx_table);
+		single_dpm_table = &(dpm_context->dpm_tables.gfx_table);
 		ret = arcturus_get_clk_table(smu, &clocks, single_dpm_table);
 		if (ret) {
 			dev_err(smu->adev->dev, "Attempt to get gfx clk levels Failed!");
@@ -868,7 +820,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 			return ret;
 		}
 
-		single_dpm_table = &(dpm_table->mem_table);
+		single_dpm_table = &(dpm_context->dpm_tables.uclk_table);
 		ret = arcturus_get_clk_table(smu, &clocks, single_dpm_table);
 		if (ret) {
 			dev_err(smu->adev->dev, "Attempt to get memory clk levels Failed!");
@@ -891,7 +843,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 			return ret;
 		}
 
-		single_dpm_table = &(dpm_table->soc_table);
+		single_dpm_table = &(dpm_context->dpm_tables.soc_table);
 		ret = arcturus_get_clk_table(smu, &clocks, single_dpm_table);
 		if (ret) {
 			dev_err(smu->adev->dev, "Attempt to get socclk levels Failed!");
@@ -914,7 +866,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 			return ret;
 		}
 
-		single_dpm_table = &(dpm_table->fclk_table);
+		single_dpm_table = &(dpm_context->dpm_tables.fclk_table);
 		ret = arcturus_get_clk_table(smu, &clocks, single_dpm_table);
 		if (ret) {
 			dev_err(smu->adev->dev, "Attempt to get fclk levels Failed!");
@@ -937,20 +889,19 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 	return size;
 }
 
-static int arcturus_upload_dpm_level(struct smu_context *smu, bool max,
-				     uint32_t feature_mask)
+static int arcturus_upload_dpm_level(struct smu_context *smu,
+				     bool max,
+				     uint32_t feature_mask,
+				     uint32_t level)
 {
-	struct arcturus_single_dpm_table *single_dpm_table;
-	struct arcturus_dpm_table *dpm_table =
+	struct smu_11_0_dpm_context *dpm_context =
 			smu->smu_dpm.dpm_context;
 	uint32_t freq;
 	int ret = 0;
 
 	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &&
 	    (feature_mask & FEATURE_DPM_GFXCLK_MASK)) {
-		single_dpm_table = &(dpm_table->gfx_table);
-		freq = max ? single_dpm_table->dpm_state.soft_max_level :
-			single_dpm_table->dpm_state.soft_min_level;
+		freq = dpm_context->dpm_tables.gfx_table.dpm_levels[level].value;
 		ret = smu_send_smc_msg_with_param(smu,
 			(max ? SMU_MSG_SetSoftMaxByFreq : SMU_MSG_SetSoftMinByFreq),
 			(PPCLK_GFXCLK << 16) | (freq & 0xffff),
@@ -964,9 +915,7 @@ static int arcturus_upload_dpm_level(struct smu_context *smu, bool max,
 
 	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT) &&
 	    (feature_mask & FEATURE_DPM_UCLK_MASK)) {
-		single_dpm_table = &(dpm_table->mem_table);
-		freq = max ? single_dpm_table->dpm_state.soft_max_level :
-			single_dpm_table->dpm_state.soft_min_level;
+		freq = dpm_context->dpm_tables.uclk_table.dpm_levels[level].value;
 		ret = smu_send_smc_msg_with_param(smu,
 			(max ? SMU_MSG_SetSoftMaxByFreq : SMU_MSG_SetSoftMinByFreq),
 			(PPCLK_UCLK << 16) | (freq & 0xffff),
@@ -980,9 +929,7 @@ static int arcturus_upload_dpm_level(struct smu_context *smu, bool max,
 
 	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT) &&
 	    (feature_mask & FEATURE_DPM_SOCCLK_MASK)) {
-		single_dpm_table = &(dpm_table->soc_table);
-		freq = max ? single_dpm_table->dpm_state.soft_max_level :
-			single_dpm_table->dpm_state.soft_min_level;
+		freq = dpm_context->dpm_tables.soc_table.dpm_levels[level].value;
 		ret = smu_send_smc_msg_with_param(smu,
 			(max ? SMU_MSG_SetSoftMaxByFreq : SMU_MSG_SetSoftMinByFreq),
 			(PPCLK_SOCCLK << 16) | (freq & 0xffff),
@@ -1000,8 +947,8 @@ static int arcturus_upload_dpm_level(struct smu_context *smu, bool max,
 static int arcturus_force_clk_levels(struct smu_context *smu,
 			enum smu_clk_type type, uint32_t mask)
 {
-	struct arcturus_dpm_table *dpm_table;
-	struct arcturus_single_dpm_table *single_dpm_table;
+	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+	struct smu_11_0_dpm_table *single_dpm_table = NULL;
 	uint32_t soft_min_level, soft_max_level;
 	uint32_t smu_version;
 	int ret = 0;
@@ -1021,12 +968,9 @@ static int arcturus_force_clk_levels(struct smu_context *smu,
 	soft_min_level = mask ? (ffs(mask) - 1) : 0;
 	soft_max_level = mask ? (fls(mask) - 1) : 0;
 
-	dpm_table = smu->smu_dpm.dpm_context;
-
 	switch (type) {
 	case SMU_SCLK:
-		single_dpm_table = &(dpm_table->gfx_table);
-
+		single_dpm_table = &(dpm_context->dpm_tables.gfx_table);
 		if (soft_max_level >= single_dpm_table->count) {
 			dev_err(smu->adev->dev, "Clock level specified %d is over max allowed %d\n",
 					soft_max_level, single_dpm_table->count - 1);
@@ -1034,18 +978,19 @@ static int arcturus_force_clk_levels(struct smu_context *smu,
 			break;
 		}
 
-		single_dpm_table->dpm_state.soft_min_level =
-			single_dpm_table->dpm_levels[soft_min_level].value;
-		single_dpm_table->dpm_state.soft_max_level =
-			single_dpm_table->dpm_levels[soft_max_level].value;
-
-		ret = arcturus_upload_dpm_level(smu, false, FEATURE_DPM_GFXCLK_MASK);
+		ret = arcturus_upload_dpm_level(smu,
+						false,
+						FEATURE_DPM_GFXCLK_MASK,
+						soft_min_level);
 		if (ret) {
 			dev_err(smu->adev->dev, "Failed to upload boot level to lowest!\n");
 			break;
 		}
 
-		ret = arcturus_upload_dpm_level(smu, true, FEATURE_DPM_GFXCLK_MASK);
+		ret = arcturus_upload_dpm_level(smu,
+						true,
+						FEATURE_DPM_GFXCLK_MASK,
+						soft_max_level);
 		if (ret)
 			dev_err(smu->adev->dev, "Failed to upload dpm max level to highest!\n");
 
@@ -1256,8 +1201,7 @@ static int arcturus_get_fan_speed_percent(struct smu_context *smu,
 	return ret;
 }
 
-
-static uint32_t arcturus_find_lowest_dpm_level(struct arcturus_single_dpm_table *table)
+static uint32_t arcturus_find_lowest_dpm_level(struct smu_11_0_dpm_table *table)
 {
 	uint32_t i;
 
@@ -1274,7 +1218,7 @@ static uint32_t arcturus_find_lowest_dpm_level(struct arcturus_single_dpm_table
 }
 
 static uint32_t arcturus_find_highest_dpm_level(struct smu_context *smu,
-						struct arcturus_single_dpm_table *table)
+						struct smu_11_0_dpm_table *table)
 {
 	int i = 0;
 
@@ -1299,34 +1243,33 @@ static uint32_t arcturus_find_highest_dpm_level(struct smu_context *smu,
 	return i;
 }
 
-
-
 static int arcturus_force_dpm_limit_value(struct smu_context *smu, bool highest)
 {
-	struct arcturus_dpm_table *dpm_table =
-		(struct arcturus_dpm_table *)smu->smu_dpm.dpm_context;
+	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(smu->adev, 0);
 	uint32_t soft_level;
 	int ret = 0;
 
 	/* gfxclk */
 	if (highest)
-		soft_level = arcturus_find_highest_dpm_level(smu, &(dpm_table->gfx_table));
+		soft_level = arcturus_find_highest_dpm_level(smu, &(dpm_context->dpm_tables.gfx_table));
 	else
-		soft_level = arcturus_find_lowest_dpm_level(&(dpm_table->gfx_table));
+		soft_level = arcturus_find_lowest_dpm_level(&(dpm_context->dpm_tables.gfx_table));
 
-	dpm_table->gfx_table.dpm_state.soft_min_level =
-		dpm_table->gfx_table.dpm_state.soft_max_level =
-		dpm_table->gfx_table.dpm_levels[soft_level].value;
-
-	ret = arcturus_upload_dpm_level(smu, false, FEATURE_DPM_GFXCLK_MASK);
+	ret = arcturus_upload_dpm_level(smu,
+					false,
+					FEATURE_DPM_GFXCLK_MASK,
+					soft_level);
 	if (ret) {
 		dev_err(smu->adev->dev, "Failed to upload boot level to %s!\n",
 				highest ? "highest" : "lowest");
 		return ret;
 	}
 
-	ret = arcturus_upload_dpm_level(smu, true, FEATURE_DPM_GFXCLK_MASK);
+	ret = arcturus_upload_dpm_level(smu,
+					true,
+					FEATURE_DPM_GFXCLK_MASK,
+					soft_level);
 	if (ret) {
 		dev_err(smu->adev->dev, "Failed to upload dpm max level to %s!\n!",
 				highest ? "highest" : "lowest");
@@ -1345,27 +1288,29 @@ static int arcturus_force_dpm_limit_value(struct smu_context *smu, bool highest)
 
 static int arcturus_unforce_dpm_levels(struct smu_context *smu)
 {
-	struct arcturus_dpm_table *dpm_table =
-		(struct arcturus_dpm_table *)smu->smu_dpm.dpm_context;
+	struct smu_11_0_dpm_context *dpm_context =
+		(struct smu_11_0_dpm_context *)smu->smu_dpm.dpm_context;
 	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(smu->adev, 0);
 	uint32_t soft_min_level, soft_max_level;
 	int ret = 0;
 
 	/* gfxclk */
-	soft_min_level = arcturus_find_lowest_dpm_level(&(dpm_table->gfx_table));
-	soft_max_level = arcturus_find_highest_dpm_level(smu, &(dpm_table->gfx_table));
-	dpm_table->gfx_table.dpm_state.soft_min_level =
-		dpm_table->gfx_table.dpm_levels[soft_min_level].value;
-	dpm_table->gfx_table.dpm_state.soft_max_level =
-		dpm_table->gfx_table.dpm_levels[soft_max_level].value;
-
-	ret = arcturus_upload_dpm_level(smu, false, FEATURE_DPM_GFXCLK_MASK);
+	soft_min_level = arcturus_find_lowest_dpm_level(&(dpm_context->dpm_tables.gfx_table));
+	soft_max_level = arcturus_find_highest_dpm_level(smu, &(dpm_context->dpm_tables.gfx_table));
+
+	ret = arcturus_upload_dpm_level(smu,
+					false,
+					FEATURE_DPM_GFXCLK_MASK,
+					soft_min_level);
 	if (ret) {
 		dev_err(smu->adev->dev, "Failed to upload DPM Bootup Levels!");
 		return ret;
 	}
 
-	ret = arcturus_upload_dpm_level(smu, true, FEATURE_DPM_GFXCLK_MASK);
+	ret = arcturus_upload_dpm_level(smu,
+					true,
+					FEATURE_DPM_GFXCLK_MASK,
+					soft_max_level);
 	if (ret) {
 		dev_err(smu->adev->dev, "Failed to upload DPM Max Levels!");
 		return ret;
@@ -1388,18 +1333,15 @@ arcturus_get_profiling_clk_mask(struct smu_context *smu,
 				uint32_t *mclk_mask,
 				uint32_t *soc_mask)
 {
-	struct arcturus_dpm_table *dpm_table =
-		(struct arcturus_dpm_table *)smu->smu_dpm.dpm_context;
-	struct arcturus_single_dpm_table *gfx_dpm_table;
-	struct arcturus_single_dpm_table *mem_dpm_table;
-	struct arcturus_single_dpm_table *soc_dpm_table;
+	struct smu_11_0_dpm_context *dpm_context =
+		(struct smu_11_0_dpm_context *)smu->smu_dpm.dpm_context;
+	struct smu_11_0_dpm_table *gfx_dpm_table;
+	struct smu_11_0_dpm_table *mem_dpm_table;
+	struct smu_11_0_dpm_table *soc_dpm_table;
 
-	if (!smu->smu_dpm.dpm_context)
-		return -EINVAL;
-
-	gfx_dpm_table = &dpm_table->gfx_table;
-	mem_dpm_table = &dpm_table->mem_table;
-	soc_dpm_table = &dpm_table->soc_table;
+	gfx_dpm_table = &dpm_context->dpm_tables.gfx_table;
+	mem_dpm_table = &dpm_context->dpm_tables.uclk_table;
+	soc_dpm_table = &dpm_context->dpm_tables.soc_table;
 
 	*sclk_mask = 0;
 	*mclk_mask = 0;
@@ -2153,7 +2095,6 @@ static int arcturus_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 	return ret;
 }
 
-
 static void arcturus_fill_eeprom_i2c_req(SwI2cRequest_t  *req, bool write,
 				  uint8_t address, uint32_t numbytes,
 				  uint8_t *data)
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 289c571d6e4e..14d6eef8cf17 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -285,6 +285,10 @@ int smu_v11_0_get_dpm_level_count(struct smu_context *smu,
 				  enum smu_clk_type clk_type,
 				  uint32_t *value);
 
+int smu_v11_0_set_single_dpm_table(struct smu_context *smu,
+				   enum smu_clk_type clk_type,
+				   struct smu_11_0_dpm_table *single_dpm_table);
+
 int smu_v11_0_get_dpm_level_range(struct smu_context *smu,
 				  enum smu_clk_type clk_type,
 				  uint32_t *min_value,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 1de53d6b59f0..8f6e0291d560 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1951,6 +1951,44 @@ int smu_v11_0_get_dpm_level_count(struct smu_context *smu,
 					       value);
 }
 
+int smu_v11_0_set_single_dpm_table(struct smu_context *smu,
+				   enum smu_clk_type clk_type,
+				   struct smu_11_0_dpm_table *single_dpm_table)
+{
+	int ret = 0;
+	uint32_t clk;
+	int i;
+
+	ret = smu_v11_0_get_dpm_level_count(smu,
+					    clk_type,
+					    &single_dpm_table->count);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] failed to get dpm levels!\n", __func__);
+		return ret;
+	}
+
+	for (i = 0; i < single_dpm_table->count; i++) {
+		ret = smu_v11_0_get_dpm_freq_by_index(smu,
+						      clk_type,
+						      i,
+						      &clk);
+		if (ret) {
+			dev_err(smu->adev->dev, "[%s] failed to get dpm freq by index!\n", __func__);
+			return ret;
+		}
+
+		single_dpm_table->dpm_levels[i].value = clk;
+		single_dpm_table->dpm_levels[i].enabled = true;
+
+		if (i == 0)
+			single_dpm_table->min = clk;
+		else if (i == single_dpm_table->count - 1)
+			single_dpm_table->max = clk;
+	}
+
+	return 0;
+}
+
 int smu_v11_0_get_dpm_level_range(struct smu_context *smu,
 				  enum smu_clk_type clk_type,
 				  uint32_t *min_value,
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
