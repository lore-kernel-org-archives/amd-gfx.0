Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722A1C433E2
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 08:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4650220773
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 08:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pTuzZPgn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4650220773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 630BA6E13C;
	Wed,  2 Sep 2020 08:32:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B53746E13C
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 08:32:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ul4u7q5H+V8CVBgn7G51B2/IuznoLsuT69bR4rJOL4e+BRUgbdyOrT/fEOmROVw5z33jlOeefC2+jEG//Kq/fprqSS4MT9+NLpD1pw/GSdiO/l4zhZhJrsh3TNAi1EbPJ/XMEzm9i8h3YtWNQ6C5BW4ZUpoRQ8NPvHvjDs7QuZY8dM5++8PbA/hXcayo9sQf1lSzE+kmKiyy3s8JF3LAxkBlLC6NjKkErFVf4qcPyEWORH3U3/Un0c0QZD5GZABXiklKEUbESkKX+30HuwzltPcPkhB8L4UnQ4EQOHDy1LgbBOIJfekQP6TQI91FnwQyKEhcPvWkryizrWBRvvKrQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEZhzZYhOjAo9SnWNlPVXkBQmctoclj9vVGsuSn/s5o=;
 b=UTf6JVEekyRo3dp4HRzqaNcMx7g0jrRkuoJweHCp+VwLlnXySDvEid5kQY4ngUU1kcyg5JK6HrON1yozZ94lct+OjU1xZf+eXfx0l6ZyG3+92PhxVf/A5wJBhZX2NWmRIHA1DjkXlbBlWFc7XP3B2ClJtZZXbvOLNfFMiuZ/W/RJAEBclAHvXosl+2wDxOAAjWDAiexbKBRGkfbPEPCqe46Pib/esNevegzdrjJt4luE3kyaUSwQkh6A2BrF3XRE6t3hQYcmv7N8CH8/MR9cVClzaBRnk519fxPvUUnPHqwLACO/oQirHsjyZfNEF3fqg1zeJNPpFIV0Rv75bQ310Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEZhzZYhOjAo9SnWNlPVXkBQmctoclj9vVGsuSn/s5o=;
 b=pTuzZPgnemRoIQlkUU8uSMiDsVUiwu7AYgf94QXTbXIbDTqqh/+x+tW06q30ufow/f0Xfpw5Rurge/mNA2g1qV7MpRbAVlw5rbouQjoFAM/bQVkfsscDdnE9ipH+Exj1el7t1mECOb+72LqX2MrxbxgsxoJa1wc6BvohkYhYLxE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3868.namprd12.prod.outlook.com (2603:10b6:5:1c8::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.23; Wed, 2 Sep 2020 08:32:07 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 08:32:07 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/9] drm/amd/pm: put Navi1X umc cdr workaround in post_smu_init
Date: Wed,  2 Sep 2020 16:31:28 +0800
Message-Id: <20200902083134.25569-3-evan.quan@amd.com>
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
 15.20.3348.7 via Frontend Transport; Wed, 2 Sep 2020 08:32:06 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4f44d5e5-6d76-40e3-7ff5-08d84f1aad95
X-MS-TrafficTypeDiagnostic: DM6PR12MB3868:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB38680C0E79FC4F2C6373793FE42F0@DM6PR12MB3868.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uDpCKX+eACjYVjQZbzNqptWb5DT/tyQTzahK8HNu3c6dM7ZByI9LsGwWaR2asjAS7A31pJvLqF4XgSYCb7b1FX591I6lv5N4OxFCUbiKXa1n5tdsXp4e7qBoFhuZIKbxXyr+9HUain8RnBwwfkGbiR0S3zcIQ+p5C9IlaEJHiWsm1YJDf/2za0IraI+rzixBtzePZxeNSq6eelRjsdtp39L1X0CekqNbeBiqVx8KmmUp/lkyN9oQmtSTQ4FyMx4EXTQHl2gkFwVUHwQMEAse6ylzphsUCGBpevbpM3G77CFNWyE8TYdlW5d3jaMGF+s008opQr+0917dSdlC4dpg4CPsTGkML80FrWiTb85OKiaVj6TbIOnI+TiCPaZZt+2D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(83380400001)(66574015)(66946007)(2906002)(36756003)(16576012)(66556008)(4326008)(44832011)(316002)(186003)(66476007)(5660300002)(6486002)(8676002)(86362001)(6666004)(26005)(2616005)(956004)(6916009)(478600001)(52116002)(8936002)(1076003)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ylXi7lPRKMa2smLtGLi3llykay2lV5Gq2hsZvY0UmQfQcjDzuBYBkZaFO8HwdQA3UDYbNZZSi6K/UxeJvAg30kpNB1pJdUK+4HfN82E0Lb1P+qV6TMxJIhrHV9LyXxEFvoFHV/zQb1QlgMF5qqpqx0R7s+SUIp/+Qe/STI8CLcpZUSF5ECE3CIEvJor8ea0r2TiD+DqSPkHJYWQAYKsQzRwvUwIA3cattN1+qklW5xpD+2xtLObGHKvNzIrK4ZPzWTUg5vncM3n9i81nNhOgHm2jaD4ZGNZAnfzwrknU47k22rDRLljWEbtf4vimSD9c1a1li64T4/THEK4WYOzzvCVekpq2fBTkDVcTKgjEZAMJmXzl2bLGc6H5dgy2X0f7VKaeUhMx5tYFz9cT6iSzcevoqmYm+bRic3iTBpSleAErol3JX7e88yFrDlCbvqWagh0H2VP7p2ec7+j6nqZYI5lrMOEMLPbSLF9HGmY08T/UaerllOlQYl6mS+7FhdKzrM3wUm36Ijb/rGkLy/Rge+hvhPxzQgn4sDj9Jk98ytZ0WcQsQNF9CMhHruRB+1mZlfAlV4j84sLy6+pUQd4COHr58Z5Edt/KXmweLsYJVJUomq9BG4WIfMLg0r4+uwKvcCBeBsnhNbUgsJmJQDHneA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f44d5e5-6d76-40e3-7ff5-08d84f1aad95
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 08:32:07.4354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adIzmZbrQ0u0nKY2x96PK5QXQa0XjHEuB+kravxnjWUmme8pNatXG4WiTVCXAIBS
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

That's where the uclk dpm get enabled and then the
uclk cdr workaround can be applied.

Change-Id: I520ae0fbc1c3be68324377c7d8c6dc4a346d3a57
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h        |  1 -
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      |  6 ------
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    | 18 ++++++++++++++----
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h    |  1 -
 4 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 4acc3c4c4737..701a94d4b9f6 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -590,7 +590,6 @@ struct pptable_funcs {
 	int (*mode2_reset)(struct smu_context *smu);
 	int (*get_dpm_ultimate_freq)(struct smu_context *smu, enum smu_clk_type clk_type, uint32_t *min, uint32_t *max);
 	int (*set_soft_freq_limited_range)(struct smu_context *smu, enum smu_clk_type clk_type, uint32_t min, uint32_t max);
-	int (*disable_umc_cdr_12gbps_workaround)(struct smu_context *smu);
 	int (*set_power_source)(struct smu_context *smu, enum smu_power_src_type power_src);
 	void (*log_thermal_throttling_event)(struct smu_context *smu);
 	size_t (*get_pp_feature_mask)(struct smu_context *smu, char *buf);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8d7c75c51fe5..a9c0c20efddb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -975,12 +975,6 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		return ret;
 	}
 
-	ret = smu_disable_umc_cdr_12gbps_workaround(smu);
-	if (ret) {
-		dev_err(adev->dev, "Workaround failed to disable UMC CDR feature on 12Gbps SKU!\n");
-		return ret;
-	}
-
 	/*
 	 * For Navi1X, manually switch it to AC mode as PMFW
 	 * may boot it with DC mode.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 8180b7f99991..6674f3abd457 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2568,6 +2568,7 @@ static int navi10_post_smu_init(struct smu_context *smu)
 	struct smu_feature *feature = &smu->smu_feature;
 	struct amdgpu_device *adev = smu->adev;
 	uint64_t feature_mask = 0;
+	int ret = 0;
 
 	/* For Naiv1x, enable these features only after DAL initialization */
 	if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
@@ -2590,9 +2591,19 @@ static int navi10_post_smu_init(struct smu_context *smu)
 		  (unsigned long *)(&feature_mask),
 		  SMU_FEATURE_MAX);
 
-	return smu_cmn_feature_update_enable_state(smu,
-						   feature_mask,
-						   true);
+	ret = smu_cmn_feature_update_enable_state(smu,
+						  feature_mask,
+						  true);
+	if (ret) {
+		dev_err(adev->dev, "Failed to post uclk/socclk dpm enablement!\n");
+		return ret;
+	}
+
+	ret = navi10_disable_umc_cdr_12gbps_workaround(smu);
+	if (ret)
+		dev_err(adev->dev, "Failed to apply umc cdr workaround!\n");
+
+	return ret;
 }
 
 static const struct pptable_funcs navi10_ppt_funcs = {
@@ -2669,7 +2680,6 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.set_default_od_settings = navi10_set_default_od_settings,
 	.od_edit_dpm_table = navi10_od_edit_dpm_table,
 	.run_btc = navi10_run_btc,
-	.disable_umc_cdr_12gbps_workaround = navi10_disable_umc_cdr_12gbps_workaround,
 	.set_power_source = smu_v11_0_set_power_source,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index db903889f6a7..521b805c920e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -83,7 +83,6 @@
 #define smu_asic_set_performance_level(smu, level)			smu_ppt_funcs(set_performance_level, -EINVAL, smu, level)
 #define smu_dump_pptable(smu)						smu_ppt_funcs(dump_pptable, 0, smu)
 #define smu_update_pcie_parameters(smu, pcie_gen_cap, pcie_width_cap)	smu_ppt_funcs(update_pcie_parameters, 0, smu, pcie_gen_cap, pcie_width_cap)
-#define smu_disable_umc_cdr_12gbps_workaround(smu)			smu_ppt_funcs(disable_umc_cdr_12gbps_workaround, 0, smu)
 #define smu_set_power_source(smu, power_src)				smu_ppt_funcs(set_power_source, 0, smu, power_src)
 #define smu_i2c_init(smu, control)					smu_ppt_funcs(i2c_init, 0, smu, control)
 #define smu_i2c_fini(smu, control)					smu_ppt_funcs(i2c_fini, 0, smu, control)
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
