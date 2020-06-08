Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A4AC433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 10:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B70BE2072F
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 10:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NyVDW5om"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70BE2072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 773BB89708;
	Mon,  8 Jun 2020 10:53:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6276289708
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 10:53:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsQwS3jBJnv2OS4vXSUsQWuJNYi9GvWDjl5ThX+ZSbEGkE7hTsLvd2qOzjkmGtIFI99cW0JvjMCDBqzhluzAiPCmalPVyylLg1x6yvwoksKkdJg8Aq+scbQFIEGnLAz8+pY2Ife+HG848GmnyR4CehEG+byuCueLf7amWZajNTI0k1986EykMCxpP/tp+2WY8nDpIKf1UYiJGWiAPQUTic5YeTx05CwpCrg6Y07xPF38q49nvaHjbCM094NOMkjVVufrgO+jlrdxImNcOr1nxwVdiUAKn32zIs+chEDaQgcojr8JOCQXAyodZ/J8L84vnHVQ8vUhZcw90saXdBmsZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDYbh1ua+1C5CyVSvrYGOVlzk99cOcowSJhaBT9OBrQ=;
 b=YDVzlL3CeSX/orKCT4/FnHSyQOhUWZl3Fs1CYMufQ4I0geCw1D9PNZXaGveqea8ZZa+q6U4j8x7oeqmIB7wc16+ikFU2e4XCyQUvg+9Ln4dGf0qA7OzXYLqkN80kdCkH2bhgwj0/hMSx01UCrXRFjx3PQBBlta2/W0fshzGMcu6t2/oJOSRrUJWUyPvkSc++NCArxwOvNQnqX1sItHhxd0BEIIG/YS3OEljoKlvxuY9SFXu9N/+0ku+4FRa9wtXmHGPR2I8tn+VSGpcZz7vm+fQS6cXfvZTtVh8n0xc00zBSvtf/gx3Qn3+tjbG4ZrUoJ1CIALlSFrO3NRwFTmu1LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDYbh1ua+1C5CyVSvrYGOVlzk99cOcowSJhaBT9OBrQ=;
 b=NyVDW5om/lbRBCkJWWk1enA90RN+MeRZBXIWHjKxPzZorVa1atn4EPs3yXHSEawmr84JI/xjUwjoGcLxLq6xCHvADrg4E5zH6zCH2QRcrInjH2CTqtsi8a+66WzdLviSSjgx/ERU87ztx8KI1eAPPIsJjGnwl0RWccySQgcC3uc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3546.namprd12.prod.outlook.com (2603:10b6:5:18d::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Mon, 8 Jun 2020 10:53:28 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 10:53:28 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/7] drm/amd/powerplay: simplify the code around retrieving
 power limit
Date: Mon,  8 Jun 2020 18:52:30 +0800
Message-Id: <20200608105234.29864-3-evan.quan@amd.com>
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
 15.20.3066.19 via Frontend Transport; Mon, 8 Jun 2020 10:53:27 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 673370dc-da60-4dff-3161-08d80b9a2d0a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3546:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB354696819289C37E28C9F92EE4850@DM6PR12MB3546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:328;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VKnRT27ltu98qMKcsr/L9iKpK6V0V8yLY3TAK91UtlF5PBb3omps9w40KKYNdMaVG3KDeGZTb8ESlPV2Z8UJeEFBCxg/UUinorypElR7D6MTUmQyEQ2MYc574GJ16SnVuDqL+6rUoy7oi4jRh6vQxXBUiIUbUOBMDM/9Sd3RKXppG5jz0XSyx//uCuWxcgmaOS/xqH3hRmnAFYNBKjuX5bcPDtvYE3kkeJCbVEE3tcgSCqscKc8tHF3tEndBgTJ+8GFzADc3K/HmJIIEtKAFmnd/6uRZt+is3Lcu5wrYbqvFrIuKmgAdZfwX8+MW9uySwAHfPWcNbjx3CRqKDVGF/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(66556008)(2906002)(66476007)(6666004)(6916009)(8676002)(956004)(66946007)(2616005)(8936002)(26005)(5660300002)(44832011)(4326008)(86362001)(6486002)(478600001)(83380400001)(316002)(186003)(52116002)(7696005)(36756003)(16526019)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: bB6bK8in3w3sJaYDJbMs813MUuQ3N7t03l47HHv8fSKroyvmPdiY1xCkDbzg1KMb+pUb/ABQtccgkJNrnRhlVR/NysYjdA4zuGxXOUhhiIqPdfUhLdZRbQF7z+BnsVFjhCnlseDN/L93T17HauO9ctEHsc+eX5XIZtZAvT0nMKCNFYVbAF6JXo/owpyJ4jTIuHK/obvUjovc3fObrbUV7yfJ93kgs55pVzo6bRYtx2NJWzD8FR9u8TyG0NCHA2bzQina7aXzRImNlZyGWv8AcZOrrHVvvpZSiyqRZV+s2InqRq+8TygAq0bj680DNMrokaqVdi04lkITmTKymUWB3lJtoobQwbZMVWbQr+fUx0wULtR21rRRo5IHodYEFoLj+EfuD3trkleCXMwOkfzohxnQ47ehPKVc0BZypaG7CxmDNPSKcWHRxSWYs/n7LlyT80qgabPAQdO+nlUmA3Yof/R8MzbmSk8+nYHcZ7fZ5DOzAcJ2QdBZf9Tafqs4Dabd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673370dc-da60-4dff-3161-08d80b9a2d0a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 10:53:28.4815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D6adNR9+X7QCwoZove0epY12VpwT2wObkBmAxYJio2V6PIfW3SMpmwDYLSP+Y5Jt
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

Use the cached max/current power limit for other cases except
.late_init.

Change-Id: Ia4c063207faf051db27be1956f40554913c31c3b
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         | 7 +++----
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       | 6 +-----
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h     | 2 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         | 6 +-----
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 6 +-----
 drivers/gpu/drm/amd/powerplay/smu_internal.h       | 3 +++
 6 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index a5fd1284ff1c..6757f65fd87e 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -831,9 +831,9 @@ static int smu_late_init(void *handle)
 		return ret;
 	}
 
-	ret = smu_get_power_limit(smu, &smu->default_power_limit, false, false);
+	ret = smu_get_asic_power_limits(smu);
 	if (ret) {
-		dev_err(adev->dev, "Failed to get default power limit!\n");
+		dev_err(adev->dev, "Failed to get asic power limits!\n");
 		return ret;
 	}
 
@@ -2222,8 +2222,7 @@ int smu_get_power_limit(struct smu_context *smu,
 		mutex_lock(&smu->mutex);
 	}
 
-	if (smu->ppt_funcs->get_power_limit)
-		ret = smu->ppt_funcs->get_power_limit(smu, limit, def);
+	*limit = (def ? smu->max_power_limit : smu->current_power_limit);
 
 	if (lock_needed)
 		mutex_unlock(&smu->mutex);
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 2c78271123f7..66b8f143cc46 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -1409,9 +1409,7 @@ arcturus_get_profiling_clk_mask(struct smu_context *smu,
 	return 0;
 }
 
-static int arcturus_get_power_limit(struct smu_context *smu,
-				     uint32_t *limit,
-				     bool cap)
+static int arcturus_get_power_limit(struct smu_context *smu)
 {
 	struct smu_11_0_powerplay_table *powerplay_table =
 		(struct smu_11_0_powerplay_table *)smu->smu_table.power_play_table;
@@ -1439,8 +1437,6 @@ static int arcturus_get_power_limit(struct smu_context *smu,
 	}
 	smu->max_power_limit = power_limit;
 
-	*limit = (cap ? smu->max_power_limit : smu->current_power_limit);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 574a793b5d26..db63ed057840 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -487,7 +487,7 @@ struct pptable_funcs {
 	int (*set_performance_level)(struct smu_context *smu, enum amd_dpm_forced_level level);
 	int (*display_disable_memory_clock_switch)(struct smu_context *smu, bool disable_memory_clock_switch);
 	void (*dump_pptable)(struct smu_context *smu);
-	int (*get_power_limit)(struct smu_context *smu, uint32_t *limit, bool asic_default);
+	int (*get_power_limit)(struct smu_context *smu);
 	int (*get_dpm_clk_limited)(struct smu_context *smu, enum smu_clk_type clk_type,
 				   uint32_t dpm_level, uint32_t *freq);
 	int (*set_df_cstate)(struct smu_context *smu, enum pp_df_cstate state);
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index b867f94ba559..2e0836976001 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1922,9 +1922,7 @@ static uint32_t navi10_get_pptable_power_limit(struct smu_context *smu)
 	return pptable->SocketPowerLimitAc[PPT_THROTTLER_PPT0];
 }
 
-static int navi10_get_power_limit(struct smu_context *smu,
-				  uint32_t *limit,
-				  bool cap)
+static int navi10_get_power_limit(struct smu_context *smu)
 {
 	struct smu_11_0_powerplay_table *powerplay_table =
 		(struct smu_11_0_powerplay_table *)smu->smu_table.power_play_table;
@@ -1952,8 +1950,6 @@ static int navi10_get_power_limit(struct smu_context *smu,
 	}
 	smu->max_power_limit = power_limit;
 
-	*limit = (cap ? smu->max_power_limit : smu->current_power_limit);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index c427e233dfad..44719c110655 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -1743,9 +1743,7 @@ static uint32_t sienna_cichlid_get_pptable_power_limit(struct smu_context *smu)
 	return pptable->SocketPowerLimitAc[PPT_THROTTLER_PPT0];
 }
 
-static int sienna_cichlid_get_power_limit(struct smu_context *smu,
-				     uint32_t *limit,
-				     bool cap)
+static int sienna_cichlid_get_power_limit(struct smu_context *smu)
 {
 	struct smu_11_0_7_powerplay_table *powerplay_table =
 		(struct smu_11_0_7_powerplay_table *)smu->smu_table.power_play_table;
@@ -1773,8 +1771,6 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu,
 	}
 	smu->max_power_limit = power_limit;
 
-	*limit = (cap ? smu->max_power_limit : smu->current_power_limit);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 9c68c6c43f9d..346aea9198e9 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -213,4 +213,7 @@ static inline int smu_send_smc_msg(struct smu_context *smu, enum smu_message_typ
 #define smu_log_thermal_throttling(smu) \
 		((smu)->ppt_funcs->log_thermal_throttling_event ? (smu)->ppt_funcs->log_thermal_throttling_event((smu)) : 0)
 
+#define smu_get_asic_power_limits(smu) \
+		((smu)->ppt_funcs->get_power_limit ? (smu)->ppt_funcs->get_power_limit((smu)) : 0)
+
 #endif
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
