Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F198C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 413362072E
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fXeLQIL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413362072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 008346E170;
	Thu,  4 Jun 2020 04:47:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D1F76E170
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 04:47:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUQcvLg0UiwQ+uzraXYFRAyNJ0q2dR7l/SiEZP5NAAdNoI9cfnhYHh37jO1PHF3bAQKw8ekzXCmTbbafHuCAnRoT8JsIQjlIPyB9FlP55FdHKQ1sv5z0ULm5OFATemRDisUBOYDz0uLGXhIPmqzdb8YUaymL4G969njfs5YWC47qDRcD5RE6kvhMZ6u6w7gdNTq97598HlKVHbB2AbHmKYOw9rK6jSPZm2gUhMj9wh6PqrWQEy8cu1IQ4kfLS9N5MHpy5S1AVps7QEEGMvOU0dJozgdrCP96qlbqowdDWgUCvVElKWj4KQLXO6h6nmRrxF9YbJOcurVNwJBHJOz+ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37ZqZsVamGFEAJ0d6wmPs9Rm8TrNoZXuDOdQqlhenqU=;
 b=Wq2hhpntyPSn8rMQzcD1mPBCdWXD6LJZkMM4ZBobqlgERiu4XoXCZ3jcwCljlg8jKz0MtR0XG036VIw8x/Cr8f9K4igZiPXXYinjexFebe0upv3pIl03IwX4yI/KvqLO7c0yKlnvK+ZZPn6cmY+EVu+vkjlZqDZ7H9N/iRTSUUoJSKNbhnOs82kfHZsVPls2LQcia4JJeSJA+G9sUA8XyyObYYFEki7DQoBRqOPDxE/NfWKrTtJRNoh/Qx37hYLcASN9OddSR0qT6gzocgEfKogGfrQKo+Mp/WxnrpT43rOd9TdT7NDYghqr8buF6RaU806RQNUmYcl1UQVsplPcIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37ZqZsVamGFEAJ0d6wmPs9Rm8TrNoZXuDOdQqlhenqU=;
 b=fXeLQIL9MwZVrUdAuaIR8wzEpv8KX1mHWIinbQbMKeYb16Ll1qJosSbS12aEngE1VqTPDAuexvjXUDW/VcOFFE6J5cRWexrsVFBsRjJMIm8MM0iUCxeawZg0+gsHsuzXLwHN7ZJ+BdkNUbhhi9FhH/TbI7KiA6vAoIAp/f1nmII=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3002.namprd12.prod.outlook.com (2603:10b6:5:117::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Thu, 4 Jun 2020 04:47:03 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Thu, 4 Jun 2020
 04:47:03 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/16] drm/amd/powerplay: clean up the APIs for pptable setup
Date: Thu,  4 Jun 2020 12:46:09 +0800
Message-Id: <20200604044619.18658-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200604044619.18658-1-evan.quan@amd.com>
References: <20200604044619.18658-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR01CA0071.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::35) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK0PR01CA0071.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Thu, 4 Jun 2020 04:47:02 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 12a5011e-b445-4ad3-a488-08d808425392
X-MS-TrafficTypeDiagnostic: DM6PR12MB3002:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3002986F6EEBE876210439CBE4890@DM6PR12MB3002.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vt+X2/qBQGXAYnRoUzWllQQShxkpyfo5gIkv9PmIt0Jdugmjum9MCu5pIPWCjr/ERQUqLAdb5HXRgoxTHx/SNRXZtZbi/ZaYjI7snAQ1R85E82VB5NPDDnYyJ6T+FYygLVW/5knK0yBCXh7j7SABMKxBJAzSzEXpSiOO5HqmyRK7RFXUtWIw2B56MN5T1frGSRvFnWlzq6AdTRVIFv16sBTAhxPTTPkU2A7Ujao933feK/mIJy8R0XRBDlS57liY3nFY259xHf2nSa57EJBkCd7++MCieP+hDsh6mVN7jI/8f5doLkFDAo2h2beVaPnv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(7696005)(1076003)(52116002)(36756003)(66574014)(2616005)(30864003)(26005)(316002)(16526019)(83380400001)(6486002)(86362001)(5660300002)(186003)(956004)(6916009)(4326008)(66946007)(2906002)(44832011)(8936002)(66476007)(66556008)(478600001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: kae6WK/QGv7Ditrdyzk3dt7qRVmMKTQxHTjIv0lIWm4bNlBnjl5xRlP9c/CcG9EIZ/Qk0vBlAuixso5cszZqTj/YgxQoNRHlUFBDpShA8SmaQBHthv/vZLWM61HP55tO429l+wxDCKp3wsx1kiFShWW1lC4Hv06wslhOT47puxxCInbZxijJb7Aaw9b74fA41DTEiUDZ5a7w8ONA4sPhZF3gYX03kB8Stmd+q4qdrTQxe7OmdsBu0y31mhEwSsAmTfkIveEB+hNzIClJx/A5EqURd7Qn61uRUIBeQldBvP/rAC1ItaYeZl1gsi3+e0tRXLPrElJUl3JNMgDodE9OydoTmVPaeFo7B9QGqpgBC+BYUGxSK5vdCDmw2a73HBNbZ8IvQkqpgiR53GxQsqjBLK8/ijSkviyRKSUgpgtdPfle1ehmGwWEfypZ+MJHExNBRfJJqpt3whDfRjbAxU1NNceyLeBYv9Ut0QO0uvTkYlecPe4nlZ5flhF0ijCB58Xb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a5011e-b445-4ad3-a488-08d808425392
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 04:47:03.7997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jtaw9h+4USCGVg0TbxdsWSI92F2KE3ZBzjeyfYfFXM/MJYesN/VHopE0hZW649vy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3002
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
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 17 ----
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 66 ++++++++-----
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  5 -
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  4 -
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 92 ++++++++++---------
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 59 ++++++++----
 drivers/gpu/drm/amd/powerplay/smu_internal.h  | 10 --
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 21 -----
 8 files changed, 128 insertions(+), 146 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index b2dad4d09d88..de9e52ad9e25 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1114,23 +1114,6 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
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
index 747fdd315575..9eb57bec27e1 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -489,33 +489,33 @@ static int arcturus_set_default_dpm_table(struct smu_context *smu)
 
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
@@ -546,6 +546,29 @@ static int arcturus_append_powerplay_table(struct smu_context *smu)
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
@@ -2416,10 +2439,6 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
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
@@ -2455,10 +2474,9 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
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
index cab64f896c4b..69ad51161635 100644
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
@@ -506,8 +503,6 @@ struct pptable_funcs {
 	int (*check_fw_status)(struct smu_context *smu);
 	int (*setup_pptable)(struct smu_context *smu);
 	int (*get_vbios_bootup_values)(struct smu_context *smu);
-	int (*check_pptable)(struct smu_context *smu);
-	int (*parse_pptable)(struct smu_context *smu);
 	int (*populate_smc_tables)(struct smu_context *smu);
 	int (*check_fw_version)(struct smu_context *smu);
 	int (*powergate_sdma)(struct smu_context *smu, bool gate);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 79736b1e3506..e9c71e5a8093 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -162,10 +162,6 @@ int smu_v11_0_setup_pptable(struct smu_context *smu);
 
 int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu);
 
-int smu_v11_0_check_pptable(struct smu_context *smu);
-
-int smu_v11_0_parse_pptable(struct smu_context *smu);
-
 int smu_v11_0_populate_smc_pptable(struct smu_context *smu);
 
 int smu_v11_0_check_fw_version(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 85c7cceef9dc..110845922724 100644
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
@@ -2273,9 +2280,6 @@ static int navi10_disable_umc_cdr_12gbps_workaround(struct smu_context *smu)
 static const struct pptable_funcs navi10_ppt_funcs = {
 	.tables_init = navi10_tables_init,
 	.alloc_dpm_context = navi10_allocate_dpm_context,
-	.store_powerplay_table = navi10_store_powerplay_table,
-	.check_powerplay_table = navi10_check_powerplay_table,
-	.append_powerplay_table = navi10_append_powerplay_table,
 	.get_smu_msg_index = navi10_get_smu_msg_index,
 	.get_smu_clk_index = navi10_get_smu_clk_index,
 	.get_smu_feature_index = navi10_get_smu_feature_index,
@@ -2317,10 +2321,8 @@ static const struct pptable_funcs navi10_ppt_funcs = {
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
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 3405bdcbfbd9..d637fc4b72ac 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -359,6 +359,20 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 
 static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
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
 
@@ -470,27 +484,37 @@ static int sienna_cichlid_append_powerplay_table(struct smu_context *smu)
 
 static int sienna_cichlid_store_powerplay_table(struct smu_context *smu)
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
 
-	mutex_lock(&smu_baco->mutex);
-	if (powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_BACO ||
-	    powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_MACO)
-		smu_baco->platform_support = true;
-	mutex_unlock(&smu_baco->mutex);
+static int sienna_cichlid_setup_pptable(struct smu_context *smu)
+{
+	int ret = 0;
 
-	return 0;
+	ret = smu_v11_0_setup_pptable(smu);
+	if (ret)
+		return ret;
+
+	ret = sienna_cichlid_store_powerplay_table(smu);
+	if (ret)
+		return ret;
+
+	ret = sienna_cichlid_append_powerplay_table(smu);
+	if (ret)
+		return ret;
+
+	ret = sienna_cichlid_check_powerplay_table(smu);
+	if (ret)
+		return ret;
+
+	return ret;
 }
 
 static int sienna_cichlid_tables_init(struct smu_context *smu, struct smu_table *tables)
@@ -2411,9 +2435,6 @@ static void sienna_cichlid_dump_pptable(struct smu_context *smu)
 static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.tables_init = sienna_cichlid_tables_init,
 	.alloc_dpm_context = sienna_cichlid_allocate_dpm_context,
-	.store_powerplay_table = sienna_cichlid_store_powerplay_table,
-	.check_powerplay_table = sienna_cichlid_check_powerplay_table,
-	.append_powerplay_table = sienna_cichlid_append_powerplay_table,
 	.get_smu_msg_index = sienna_cichlid_get_smu_msg_index,
 	.get_smu_clk_index = sienna_cichlid_get_smu_clk_index,
 	.get_smu_feature_index = sienna_cichlid_get_smu_feature_index,
@@ -2455,10 +2476,8 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.init_power = smu_v11_0_init_power,
 	.fini_power = smu_v11_0_fini_power,
 	.check_fw_status = smu_v11_0_check_fw_status,
-	.setup_pptable = smu_v11_0_setup_pptable,
+	.setup_pptable = sienna_cichlid_setup_pptable,
 	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
-	.check_pptable = smu_v11_0_check_pptable,
-	.parse_pptable = smu_v11_0_parse_pptable,
 	.populate_smc_tables = smu_v11_0_populate_smc_pptable,
 	.check_fw_version = smu_v11_0_check_fw_version,
 	.write_pptable = smu_v11_0_write_pptable,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 496a401615c6..d2b0b9b2f841 100644
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
index ef825327974c..377986a1d492 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -732,27 +732,6 @@ int smu_v11_0_notify_memory_pool_location(struct smu_context *smu)
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
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
