Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F75AC433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 07:31:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 548A02076B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 07:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xEIzV+S0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548A02076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D50A6E171;
	Mon,  1 Jun 2020 07:31:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53D5D6E171
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 07:30:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUnIxNXA+7E8YVyKOVhEJBzL14XpjWAMWTKwnwKOPKC0bm4Ql8wIAehK+wXDLY0YrCoR4d1J273sADj85mMP9pEvA6bRl77cblErFk5yFVIszRBg9eGUJAoSinngkAkZd1Ms8ezBPfxamkMmc6GVhksRMjVcD0pbxvSaGnC4HgLFGMJhOxvAOHI5Fv+xgB6amlBZnc8AnhzAEfy5htUJwZ9mHbzl6N/PS2qk5+LifZB5NlyduirR4L8ttQE4EM48v9U9fboURrMSDBfWtwQ9qlQe4uexcyrc9rmC7o3rH91WFysn74aGO3+JKwxXlqbKjFjeezindA53ZcJCqC6VuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3/qkPTln8Xby1vaQWRy+jwIsOHKFD0JYFsvFvhX0sU=;
 b=MP9DGSBiWVbu2k3MiFxyufZiDb7uVFg5wKvuups71s0fXXK+UEkF1j8Yn8NnkC/qD59ddS2i9VzpTTcOJ16WxyDUSmjKv+Cd0neEPnS62TFzl8Q+v0g7LpFx4rLO9OdhUzqztohNvTCPMmx3F+6FOVq+KXG0K2naYj0qlFB0q25ki4oKfO7iiPYSUlD/VyS2bo5nrHZSR9VeftydwIlDQnR5rNPq6P7k/r0AD88EBxQHVqiL1QTcOydaO2bcK4JxG7pGP1Hk7W1uA86cHuMycTLJ6gH8seAAHkdlRst/X6l1fR2hGpLfspurCdgtgRbWHDa69n3v2eAIXT7IB4fO6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3/qkPTln8Xby1vaQWRy+jwIsOHKFD0JYFsvFvhX0sU=;
 b=xEIzV+S0+lIS8z26X2wDozIqxb0zKvj+QjlpwlUPGVc7kPjp11Ra8NaPi9YASiuoHiUd54vzVYOLFAPVinbtVQ6DaP/1Mp+QSV7JQ1R74M5O3cB2iwQqA4nXuQ2cx719qctQL20uOwRb7CoTlGQdqYPa+Okwc/YiC+Lu65oZ9Pk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3803.namprd12.prod.outlook.com (2603:10b6:5:1ce::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Mon, 1 Jun 2020 07:30:58 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Mon, 1 Jun 2020
 07:30:58 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/9] drm/amd/powerplay: clean up the APIs for pptable setup
Date: Mon,  1 Jun 2020 15:29:59 +0800
Message-Id: <20200601073003.13044-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601073003.13044-1-evan.quan@amd.com>
References: <20200601073003.13044-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR0302CA0020.apcprd03.prod.outlook.com
 (2603:1096:202::30) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0020.apcprd03.prod.outlook.com (2603:1096:202::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.7 via Frontend Transport; Mon, 1 Jun 2020 07:30:56 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0adb7d3a-866f-4390-8596-08d805fdb9f1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3803:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3803828E8086E009A4BAE94AE48A0@DM6PR12MB3803.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NUFbaVj6ewqvfTB8dVpR7xfN1re6Zg88EkP3RFmrENE8+IHsG9YSNS00U8X2BveNL06oofNwYt1/I/1pKB79yD92FOPdApQcG4108mENtYc062wAFNR/vIGz5Jw9mFAAZmOrPT8ZtyAn2Hpfo1Tuej2cTIS+ikz6LovlL06YirS88Dq2NrayJPrmAQQ4u6Sz+byaPoH1es0NOPLGsrVJK381h79SneOO9soq2LoPNfQaOaFoDuOoqtR+zIVsckinDXlTY7dGLYTbxngdHUyvO6Oh3tUu//ZWUx38CxGqFavJ550rVcyaekCEZHyZdNTs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(52116002)(6916009)(1076003)(316002)(7696005)(8936002)(478600001)(30864003)(16526019)(83380400001)(2906002)(44832011)(6486002)(186003)(26005)(4326008)(66574014)(86362001)(2616005)(8676002)(956004)(36756003)(5660300002)(66946007)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 55nA2KA0sMcbEi7+0CkbjxVUtdVpdHvK8kezDWSGFi/mrbPgg7Mc1WoOvMFlD35s1zsNAP2Oa2YvFRBv0Jr2g3fI/5tmorHkBiAru3EAePr66k1bTglbLB41XGsGOs7sYAAn3YQo7t8dXILp7Tebr53AhNhsWBDXw1FwskY6lKf/0VaYDc0Eqa0tyn732tlJweuhPgimQD2pOYDXCHHIYRLjI986xz0VvRsxC7eKoYyOx4TTlfpqz9U6cZH9xpcpM4V0DEuouuCw1kxThKW/OseBJzlomHZPLRS2LSwOt0SRtkhGdJ1/GbQe5jb8jpoXrk3hLsDUrqG7IJ803u78Lr1NkHffYi1zSpRFiNPrB4XF9AhzqLdPNd5O0jBwtCsSERHJOssXiGT/3zMr5D2M3jtDZISB5v21/QH0Dfjr1odckUga+RfJgpywj4u8a+8cPf1hNzDNeNTNaiKARsKUIJVONFbxLR5BczhLBZOkFmgTBdhmGMKTxfRl0r9TrNYA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0adb7d3a-866f-4390-8596-08d805fdb9f1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 07:30:58.1850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkrG3yu6UjXqw3xme7VVCgJvPPAi4zVaniM+WT593K/59CctYdtsrOhOdoeyDOOY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3803
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

Combine and simplify the logics for setup pptable.

Change-Id: I062f15eab586050593afd960432c4c70fbdd5d41
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 17 ----
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 66 ++++++++-----
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  5 -
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  4 -
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 92 ++++++++++---------
 drivers/gpu/drm/amd/powerplay/smu_internal.h  | 10 --
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 21 -----
 7 files changed, 89 insertions(+), 126 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 9bafa6b3e123..b079ac6325d0 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1132,23 +1132,6 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 		if (ret)
 			return ret;
 
-		/*
-		 * check if the format_revision in vbios is up to pptable header
-		 * version, and the structure size is not 0.
-		 */
-		ret = smu_check_pptable(smu);
-		if (ret)
-			return ret;
-
-		/*
-		 * Parse pptable format and fill PPTable_t smc_pptable to
-		 * smu_table_context structure. And read the smc_dpm_table from vbios,
-		 * then fill it into smc_pptable.
-		 */
-		ret = smu_parse_pptable(smu);
-		if (ret)
-			return ret;
-
 		/*
 		 * Send msg GetDriverIfVersion to check if the return value is equal
 		 * with DRIVER_IF_VERSION of smc header.
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 902c8cfa4a3b..c5c23126ec2d 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -487,33 +487,33 @@ static int arcturus_set_default_dpm_table(struct smu_context *smu)
 
 static int arcturus_check_powerplay_table(struct smu_context *smu)
 {
+	struct smu_table_context *table_context = &smu->smu_table;
+	struct smu_11_0_powerplay_table *powerplay_table =
+		table_context->power_play_table;
+	struct smu_baco_context *smu_baco = &smu->smu_baco;
+
+	mutex_lock(&smu_baco->mutex);
+	if (powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_BACO ||
+	    powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_MACO)
+		smu_baco->platform_support = true;
+	mutex_unlock(&smu_baco->mutex);
+
+	table_context->thermal_controller_type =
+		powerplay_table->thermal_controller_type;
+
 	return 0;
 }
 
 static int arcturus_store_powerplay_table(struct smu_context *smu)
 {
-	struct smu_11_0_powerplay_table *powerplay_table = NULL;
 	struct smu_table_context *table_context = &smu->smu_table;
-	struct smu_baco_context *smu_baco = &smu->smu_baco;
-	int ret = 0;
-
-	if (!table_context->power_play_table)
-		return -EINVAL;
-
-	powerplay_table = table_context->power_play_table;
+	struct smu_11_0_powerplay_table *powerplay_table =
+		table_context->power_play_table;
 
 	memcpy(table_context->driver_pptable, &powerplay_table->smc_pptable,
 	       sizeof(PPTable_t));
 
-	table_context->thermal_controller_type = powerplay_table->thermal_controller_type;
-
-	mutex_lock(&smu_baco->mutex);
-	if (powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_BACO ||
-	    powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_MACO)
-		smu_baco->platform_support = true;
-	mutex_unlock(&smu_baco->mutex);
-
-	return ret;
+	return 0;
 }
 
 static int arcturus_append_powerplay_table(struct smu_context *smu)
@@ -544,6 +544,29 @@ static int arcturus_append_powerplay_table(struct smu_context *smu)
 	return 0;
 }
 
+static int arcturus_setup_pptable(struct smu_context *smu)
+{
+	int ret = 0;
+
+	ret = smu_v11_0_setup_pptable(smu);
+	if (ret)
+		return ret;
+
+	ret = arcturus_store_powerplay_table(smu);
+	if (ret)
+		return ret;
+
+	ret = arcturus_append_powerplay_table(smu);
+	if (ret)
+		return ret;
+
+	ret = arcturus_check_powerplay_table(smu);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
 static int arcturus_run_btc(struct smu_context *smu)
 {
 	int ret = 0;
@@ -2383,10 +2406,6 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	/* internal structurs allocations */
 	.tables_init = arcturus_tables_init,
 	.alloc_dpm_context = arcturus_allocate_dpm_context,
-	/* pptable related */
-	.check_powerplay_table = arcturus_check_powerplay_table,
-	.store_powerplay_table = arcturus_store_powerplay_table,
-	.append_powerplay_table = arcturus_append_powerplay_table,
 	/* init dpm */
 	.get_allowed_feature_mask = arcturus_get_allowed_feature_mask,
 	/* btc */
@@ -2421,10 +2440,9 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.init_power = smu_v11_0_init_power,
 	.fini_power = smu_v11_0_fini_power,
 	.check_fw_status = smu_v11_0_check_fw_status,
-	.setup_pptable = smu_v11_0_setup_pptable,
+	/* pptable related */
+	.setup_pptable = arcturus_setup_pptable,
 	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
-	.check_pptable = smu_v11_0_check_pptable,
-	.parse_pptable = smu_v11_0_parse_pptable,
 	.populate_smc_tables = smu_v11_0_populate_smc_pptable,
 	.check_fw_version = smu_v11_0_check_fw_version,
 	.write_pptable = smu_v11_0_write_pptable,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 223678e329a5..14f4a850b553 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -417,9 +417,6 @@ struct i2c_adapter;
 
 struct pptable_funcs {
 	int (*alloc_dpm_context)(struct smu_context *smu);
-	int (*store_powerplay_table)(struct smu_context *smu);
-	int (*check_powerplay_table)(struct smu_context *smu);
-	int (*append_powerplay_table)(struct smu_context *smu);
 	int (*get_smu_msg_index)(struct smu_context *smu, uint32_t index);
 	int (*get_smu_clk_index)(struct smu_context *smu, uint32_t index);
 	int (*get_smu_feature_index)(struct smu_context *smu, uint32_t index);
@@ -505,8 +502,6 @@ struct pptable_funcs {
 	int (*check_fw_status)(struct smu_context *smu);
 	int (*setup_pptable)(struct smu_context *smu);
 	int (*get_vbios_bootup_values)(struct smu_context *smu);
-	int (*check_pptable)(struct smu_context *smu);
-	int (*parse_pptable)(struct smu_context *smu);
 	int (*populate_smc_tables)(struct smu_context *smu);
 	int (*check_fw_version)(struct smu_context *smu);
 	int (*powergate_sdma)(struct smu_context *smu, bool gate);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 5b785816aa64..51868dc33238 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -161,10 +161,6 @@ int smu_v11_0_setup_pptable(struct smu_context *smu);
 
 int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu);
 
-int smu_v11_0_check_pptable(struct smu_context *smu);
-
-int smu_v11_0_parse_pptable(struct smu_context *smu);
-
 int smu_v11_0_populate_smc_pptable(struct smu_context *smu);
 
 int smu_v11_0_check_fw_version(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index bea6a96b5afb..db38fb10524d 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -417,6 +417,29 @@ navi10_get_allowed_feature_mask(struct smu_context *smu,
 
 static int navi10_check_powerplay_table(struct smu_context *smu)
 {
+	struct smu_table_context *table_context = &smu->smu_table;
+	struct smu_11_0_powerplay_table *powerplay_table =
+		table_context->power_play_table;
+	struct smu_baco_context *smu_baco = &smu->smu_baco;
+
+	if (powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_HARDWAREDC)
+		smu->dc_controlled_by_gpio = true;
+
+	mutex_lock(&smu_baco->mutex);
+	if (powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_BACO ||
+	    powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_MACO)
+		smu_baco->platform_support = true;
+	mutex_unlock(&smu_baco->mutex);
+
+	table_context->thermal_controller_type =
+		powerplay_table->thermal_controller_type;
+
+	/*
+	 * Instead of having its own buffer space and get overdrive_table copied,
+	 * smu->od_settings just points to the actual overdrive_table
+	 */
+	smu->od_settings = &powerplay_table->overdrive_table;
+
 	return 0;
 }
 
@@ -475,30 +498,37 @@ static int navi10_append_powerplay_table(struct smu_context *smu)
 
 static int navi10_store_powerplay_table(struct smu_context *smu)
 {
-	struct smu_11_0_powerplay_table *powerplay_table = NULL;
 	struct smu_table_context *table_context = &smu->smu_table;
-	struct smu_baco_context *smu_baco = &smu->smu_baco;
-
-	if (!table_context->power_play_table)
-		return -EINVAL;
-
-	powerplay_table = table_context->power_play_table;
+	struct smu_11_0_powerplay_table *powerplay_table =
+		table_context->power_play_table;
 
 	memcpy(table_context->driver_pptable, &powerplay_table->smc_pptable,
 	       sizeof(PPTable_t));
 
-	table_context->thermal_controller_type = powerplay_table->thermal_controller_type;
+	return 0;
+}
 
-	if (powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_HARDWAREDC)
-		smu->dc_controlled_by_gpio = true;
+static int navi10_setup_pptable(struct smu_context *smu)
+{
+	int ret = 0;
 
-	mutex_lock(&smu_baco->mutex);
-	if (powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_BACO ||
-	    powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_MACO)
-		smu_baco->platform_support = true;
-	mutex_unlock(&smu_baco->mutex);
+	ret = smu_v11_0_setup_pptable(smu);
+	if (ret)
+		return ret;
 
-	return 0;
+	ret = navi10_store_powerplay_table(smu);
+	if (ret)
+		return ret;
+
+	ret = navi10_append_powerplay_table(smu);
+	if (ret)
+		return ret;
+
+	ret = navi10_check_powerplay_table(smu);
+	if (ret)
+		return ret;
+
+	return ret;
 }
 
 static int navi10_tables_init(struct smu_context *smu, struct smu_table *tables)
@@ -1927,24 +1957,6 @@ static int navi10_overdrive_get_gfx_clk_base_voltage(struct smu_context *smu,
 	return 0;
 }
 
-static int navi10_setup_od_limits(struct smu_context *smu) {
-	struct smu_11_0_overdrive_table *overdrive_table = NULL;
-	struct smu_11_0_powerplay_table *powerplay_table = NULL;
-
-	if (!smu->smu_table.power_play_table) {
-		pr_err("powerplay table uninitialized!\n");
-		return -ENOENT;
-	}
-	powerplay_table = (struct smu_11_0_powerplay_table *)smu->smu_table.power_play_table;
-	overdrive_table = &powerplay_table->overdrive_table;
-	if (!smu->od_settings) {
-		smu->od_settings = kmemdup(overdrive_table, sizeof(struct smu_11_0_overdrive_table), GFP_KERNEL);
-	} else {
-		memcpy(smu->od_settings, overdrive_table, sizeof(struct smu_11_0_overdrive_table));
-	}
-	return 0;
-}
-
 static bool navi10_is_baco_supported(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -1968,11 +1980,6 @@ static int navi10_set_default_od_settings(struct smu_context *smu, bool initiali
 	od_table = (OverDriveTable_t *)smu->smu_table.overdrive_table;
 	boot_od_table = (OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
 	if (initialize) {
-		ret = navi10_setup_od_limits(smu);
-		if (ret) {
-			pr_err("Failed to retrieve board OD limits\n");
-			return ret;
-		}
 		if (od_table) {
 			if (!od_table->GfxclkVolt1) {
 				ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
@@ -2274,9 +2281,6 @@ static int navi10_disable_umc_cdr_12gbps_workaround(struct smu_context *smu)
 static const struct pptable_funcs navi10_ppt_funcs = {
 	.tables_init = navi10_tables_init,
 	.alloc_dpm_context = navi10_allocate_dpm_context,
-	.store_powerplay_table = navi10_store_powerplay_table,
-	.check_powerplay_table = navi10_check_powerplay_table,
-	.append_powerplay_table = navi10_append_powerplay_table,
 	.get_smu_msg_index = navi10_get_smu_msg_index,
 	.get_smu_clk_index = navi10_get_smu_clk_index,
 	.get_smu_feature_index = navi10_get_smu_feature_index,
@@ -2318,10 +2322,8 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.init_power = smu_v11_0_init_power,
 	.fini_power = smu_v11_0_fini_power,
 	.check_fw_status = smu_v11_0_check_fw_status,
-	.setup_pptable = smu_v11_0_setup_pptable,
+	.setup_pptable = navi10_setup_pptable,
 	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
-	.check_pptable = smu_v11_0_check_pptable,
-	.parse_pptable = smu_v11_0_parse_pptable,
 	.populate_smc_tables = smu_v11_0_populate_smc_pptable,
 	.check_fw_version = smu_v11_0_check_fw_version,
 	.write_pptable = smu_v11_0_write_pptable,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index a31df7f4e91a..33086f94267a 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -47,10 +47,6 @@
 
 #define smu_get_vbios_bootup_values(smu) \
 	((smu)->ppt_funcs->get_vbios_bootup_values ? (smu)->ppt_funcs->get_vbios_bootup_values((smu)) : 0)
-#define smu_check_pptable(smu) \
-	((smu)->ppt_funcs->check_pptable ? (smu)->ppt_funcs->check_pptable((smu)) : 0)
-#define smu_parse_pptable(smu) \
-	((smu)->ppt_funcs->parse_pptable ? (smu)->ppt_funcs->parse_pptable((smu)) : 0)
 #define smu_populate_smc_tables(smu) \
 	((smu)->ppt_funcs->populate_smc_tables ? (smu)->ppt_funcs->populate_smc_tables((smu)) : 0)
 #define smu_check_fw_version(smu) \
@@ -96,12 +92,6 @@ static inline int smu_send_smc_msg(struct smu_context *smu, enum smu_message_typ
 	((smu)->ppt_funcs->is_dpm_running ? (smu)->ppt_funcs->is_dpm_running((smu)) : 0)
 #define smu_notify_display_change(smu) \
 	((smu)->ppt_funcs->notify_display_change? (smu)->ppt_funcs->notify_display_change((smu)) : 0)
-#define smu_store_powerplay_table(smu) \
-	((smu)->ppt_funcs->store_powerplay_table ? (smu)->ppt_funcs->store_powerplay_table((smu)) : 0)
-#define smu_check_powerplay_table(smu) \
-	((smu)->ppt_funcs->check_powerplay_table ? (smu)->ppt_funcs->check_powerplay_table((smu)) : 0)
-#define smu_append_powerplay_table(smu) \
-	((smu)->ppt_funcs->append_powerplay_table ? (smu)->ppt_funcs->append_powerplay_table((smu)) : 0)
 #define smu_set_default_dpm_table(smu) \
 	((smu)->ppt_funcs->set_default_dpm_table ? (smu)->ppt_funcs->set_default_dpm_table((smu)) : 0)
 #define smu_populate_umd_state_clk(smu) \
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index be6dca8c6014..7a97a4510c6d 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -725,27 +725,6 @@ int smu_v11_0_notify_memory_pool_location(struct smu_context *smu)
 	return ret;
 }
 
-int smu_v11_0_check_pptable(struct smu_context *smu)
-{
-	int ret;
-
-	ret = smu_check_powerplay_table(smu);
-	return ret;
-}
-
-int smu_v11_0_parse_pptable(struct smu_context *smu)
-{
-	int ret;
-
-	ret = smu_store_powerplay_table(smu);
-	if (ret)
-		return -EINVAL;
-
-	ret = smu_append_powerplay_table(smu);
-
-	return ret;
-}
-
 int smu_v11_0_populate_smc_pptable(struct smu_context *smu)
 {
 	int ret;
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
