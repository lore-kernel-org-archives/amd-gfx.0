Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C32C433E7
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 08:32:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B5ED20773
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 08:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bUZfVaR6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5ED20773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0A4C6E301;
	Wed,  2 Sep 2020 08:32:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 374FB6E2DC
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 08:32:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3r4V7jAzaB435UGtDC5+jweNoV4BM67EQJhiR5pEehItHNhAVVBYUelE7tAlhKl3OgPLNDRLXBpaBhEGjljNu5BLLbJSLLxUHoCmzn4xSlcsYi5xk+l5I/if7GbfUkr0zTrtyMBYiGr8R2VyxhOGfvvJx72F/tTrMTIy7dRcsTsYK0m9Tx+GGqHuD0+wxlfSM74IZEj/c2J5511fOx5c1zxV/gl96f1n+ow9J9+KkADeICV0qW64aKPGlL/7nu7U234XfYM3vzbGyz5oIqEdxTjaW6KslaVEmzjrpbR66Kpb913NUHBzOAi3XElqtq7YmxyVkOjx4dhYLUn4htHxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTv/38xzbXMVW6FRwvd44ohJYRkKZYW1JJoNyIgTkpw=;
 b=cuTDakvTcj5yy/YwvKJ1znGLrGju82CiQK64VIs9cRWDp64cW39ksyk+nGulPGuJ0mMmA6W6+Up1jTBE7sN5FVur7zZmnEDBDOzwQhdzH5o6t2mxLX7SkyTRSqmn3wy5/BP4XIgxXzw5fsmFPWdSWKvr/8VH6zl/9+pOmeVLg0IKfnzaTBwUYdhSArBqvdu0aCBbIn189CK/vsDrPwtA1JObSSEgfDfF9HcpClMu8lenRDRA7PftVR6JGJ6NgJk0MI8KGqgfHwCY0SzhejTd0IMq1qzXWLsw2DdTIXu3dIMBqIslY71mqbQO8KkPH9lKqJJKXlAyo6vZXHEoYgIF5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTv/38xzbXMVW6FRwvd44ohJYRkKZYW1JJoNyIgTkpw=;
 b=bUZfVaR6TBS008uifG/AjMSushXh2+/nUrd/R5HPecSaSnuEtMniYDC0XiW2mNhHEqmps1kvy2T8LVR91W7Qspnh3AJNnwSA1zC906ertL/8Jgq+AHpAoGNkdZJKxyB+lNEquXULYkWOoEabRwP2LA8kuwrYD/EoCnXD7mwSUd4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3868.namprd12.prod.outlook.com (2603:10b6:5:1c8::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.23; Wed, 2 Sep 2020 08:32:09 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 08:32:09 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/9] drm/amd/pm: revise the umc hybrid cdr workaround
Date: Wed,  2 Sep 2020 16:31:29 +0800
Message-Id: <20200902083134.25569-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902083134.25569-1-evan.quan@amd.com>
References: <20200902083134.25569-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR0302CA0004.apcprd03.prod.outlook.com
 (2603:1096:202::14) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 HK2PR0302CA0004.apcprd03.prod.outlook.com (2603:1096:202::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.7 via Frontend Transport; Wed, 2 Sep 2020 08:32:07 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1de0acb3-6c89-4e18-afb2-08d84f1aae8e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3868:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3868DD563E57B3A84BC194F0E42F0@DM6PR12MB3868.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xHjXJUwuyEQzZcjuWP29oKSKNZpgpvqa75zdriZg7Q7K0uJlOEBC+5AsS9D2GSPVVOr99YsjRyyEtCwKZwU1hw9jsuJwv56DNJ+HPzNddytYTOY0lGlviYiFhyoL7r9Djvm0a2MqnLJLCBoFAvsqz0omUhg6mBixwVEbtfwsi5bk/i75u477EzD14Z7EeiazW0ANlDQsVUujdx6lZzdo/3wh/UGDnubJoGCXpUhC25CF43ETR+CipRV/2gWsuBKK4oxTkn2B4KWZ9pFTYPnwWlybi06HJxGTib33Vh9rFu8+6tMxRawESwUqz5ucS+fN9SeC4C4P1tGjxMcuNtQB8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(83380400001)(66574015)(66946007)(2906002)(36756003)(16576012)(66556008)(4326008)(44832011)(316002)(186003)(66476007)(5660300002)(6486002)(8676002)(86362001)(6666004)(26005)(2616005)(956004)(6916009)(478600001)(52116002)(8936002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: FBq3EsOGzGrECct+OAYrFedZarb4k9xwS7ks6UYAqK9T6Jxqf97Adr7jx6W4hurXM8mJtcLDqYO9DULMLqFOTGPHIgJL3oaQEuHmZDhQ13ZdTJY4rJMCqIP0LUszDd1Swxow5ffXaY4qubbrf/WshrcHQ7OISBBh2BjbHuTiM+yMmJCrCX3x9W/xA1wcYoT1w/vK9TiimHksRW3tVmsLJKz7ukzqOe0LL+RSrX5ph2J6mNjq/oLWMee1+ida5HrTqrARb6JtIrufPnOEdQPcDsVmSJfYHqHYaJr4aokXbx6ahn9gKKnoQI7uY6s9Th3sR76FL63NDTE/8K1YWrX2wYLcuXugebEIKIx4Ws4TC6H2xUG8RLSnnH8pY85lNAeSU6w8XLkesdr0QdrIonw1Y21FnAFh+sCxIZpGqE6VxRd5/47XBpaZkUC5FXvrD0CYjzoIPJ+2g7g6iY+PMARyBW7Gx0SEsTnEPXGN+/3CtoJ7j422Cs7Bi7Oo2h5aJ6ilVddh4ywQwls9ooq9/Hi3upokdORQC9ctq0tJhmybtVAxbgFel0vqVmY61Kcvyx6riltY/cu4AQPYklxSE4W8497Pr00TmwGkzybIt4PW9asUGswqnV5jA3+lMnPsVyRbJAXgJjer8xJxQngJOOXsRg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de0acb3-6c89-4e18-afb2-08d84f1aae8e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 08:32:09.0505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUU1f1RSWbSd4ocbl7feZtbqCUjo5YQ0grlgOEX7HuIgeGwkpMLX511r8fagKMqp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3868
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

Drop the unused message(SMU_MSG_DAL_DISABLE_DUMMY_PSTATE_CHANGE).
And do not apply this workaround when the max uclk frequency
is greater than 750Mhz.

Change-Id: I862e80cc96424c82f34aff0fa85b3d37f4dbcb2b
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 61 +++++++++++--------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 6674f3abd457..79cd17d6bfaa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2181,18 +2181,6 @@ static int navi10_run_btc(struct smu_context *smu)
 	return ret;
 }
 
-static int navi10_dummy_pstate_control(struct smu_context *smu, bool enable)
-{
-	int result = 0;
-
-	if (!enable)
-		result = smu_cmn_send_smc_msg(smu, SMU_MSG_DAL_DISABLE_DUMMY_PSTATE_CHANGE, NULL);
-	else
-		result = smu_cmn_send_smc_msg(smu, SMU_MSG_DAL_ENABLE_DUMMY_PSTATE_CHANGE, NULL);
-
-	return result;
-}
-
 static inline bool navi10_need_umc_cdr_12gbps_workaround(struct amdgpu_device *adev)
 {
 	if (adev->asic_type != CHIP_NAVI10)
@@ -2208,32 +2196,32 @@ static inline bool navi10_need_umc_cdr_12gbps_workaround(struct amdgpu_device *a
 		return false;
 }
 
-static int navi10_disable_umc_cdr_12gbps_workaround(struct smu_context *smu)
+static int navi10_umc_hybrid_cdr_workaround(struct smu_context *smu)
 {
 	uint32_t uclk_count, uclk_min, uclk_max;
-	uint32_t smu_version;
 	int ret = 0;
 
-	if (!navi10_need_umc_cdr_12gbps_workaround(smu->adev))
-		return 0;
-
-	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
-	if (ret)
-		return ret;
-
-	/* This workaround is available only for 42.50 or later SMC firmwares */
-	if (smu_version < 0x2A3200)
+	/* This workaround can be applied only with uclk dpm enabled */
+	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT))
 		return 0;
 
 	ret = smu_v11_0_get_dpm_level_count(smu, SMU_UCLK, &uclk_count);
 	if (ret)
 		return ret;
 
-	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK, (uint16_t)0, &uclk_min);
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK, (uint16_t)(uclk_count - 1), &uclk_max);
 	if (ret)
 		return ret;
 
-	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK, (uint16_t)(uclk_count - 1), &uclk_max);
+	/*
+	 * The NAVI10_UMC_HYBRID_CDR_WORKAROUND_UCLK_THRESHOLD is 750Mhz.
+	 * This workaround is needed only when the max uclk frequency
+	 * not greater than that.
+	 */
+	if (uclk_max > 0x2EE)
+		return 0;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK, (uint16_t)0, &uclk_min);
 	if (ret)
 		return ret;
 
@@ -2250,8 +2238,27 @@ static int navi10_disable_umc_cdr_12gbps_workaround(struct smu_context *smu)
 	/*
 	 * In this case, SMU already disabled dummy pstate during enablement
 	 * of UCLK DPM, we have to re-enabled it.
-	 * */
-	return navi10_dummy_pstate_control(smu, true);
+	 */
+	return smu_cmn_send_smc_msg(smu, SMU_MSG_DAL_ENABLE_DUMMY_PSTATE_CHANGE, NULL);
+}
+
+static int navi10_disable_umc_cdr_12gbps_workaround(struct smu_context *smu)
+{
+	uint32_t smu_version;
+	int ret = 0;
+
+	if (!navi10_need_umc_cdr_12gbps_workaround(smu->adev))
+		return 0;
+
+	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
+	if (ret)
+		return ret;
+
+	/* This workaround is available only for 42.50 or later SMC firmwares */
+	if (smu_version < 0x2A3200)
+		return 0;
+
+	return navi10_umc_hybrid_cdr_workaround(smu);
 }
 
 static void navi10_fill_i2c_req(SwI2cRequest_t  *req, bool write,
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
