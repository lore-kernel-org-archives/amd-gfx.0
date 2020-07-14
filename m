Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B728C433E5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:06:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70ECD21582
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jvNB2atO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70ECD21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CB538931E;
	Tue, 14 Jul 2020 08:06:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 917D58931E
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 08:06:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvYQUDzAZV8VrOJ0M3t9z+5BfNpbwG/Vt7eFkWH9Basv5X8IAbvtVmimhw2Qrhxh6knccHGZluvvxtspTv9r/rmDOHcL+OeAfcOFcGeda1HvHd0OxaHI7ETVlDkcQKvsHnY6++PcUSKQDIaPMKBVsTenkCPLvfLcc/3zAIw/aGB3uxFC+uoXDcXhkXHKds/CwHJUEfg8WhPwq2OspH/QuKTGSraQx0vQcHEQONiQ2nMgxyCmu3xfukhopwMoL/A7cyorkNS+CB+ht/k6H6TJuR07WN45V5svwfBIAdOksOHfmi+eu2uX3x8PUT7W9wQe76cyqyPw65McDrIG7s4IGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J23xLHknN/1GO+K/64vulyxgh/XLfKH49ocWwBCm+Mo=;
 b=ffmLlph+eg5NWKTc+3o7xw1b2wRwld2GYPIOBRvqT2ROLAdlyWS2+eMRwDHu6+E198UuLamDhT5IegrLlAt0fdvLgp/b3BziKrsTUa0+pWyYqXM57k+xlib21l4tE/PeonYqPAJQQ4DAXioiqLay01OSNe0P1k62KqfI7nAjU+MYryhjTr8k+D4NMwoP8TgtuPiYld3NmoRXL3N3fpGey59hdJOMAGIGHV9weXlEdFmQgFrk/Jr3H5q5HrP9CHnb7GwnnF3rHmARSpxIqVjFX5cP3yjkwRwUs8e9Dl9TpAQR3fSe6C2gJK+IaktlX+u/pIr8lNEt+NtbV/mekNLirw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J23xLHknN/1GO+K/64vulyxgh/XLfKH49ocWwBCm+Mo=;
 b=jvNB2atOjZIxaS2aael8dunNzJLRdPGDAh0nDR/7+lgRbks1cdV+jZY/rzHjhTgVI5PBam3p17cI5rhgt+SxZtq60OrfVOcCsK0Npqm5JY/WURWbpmLGad8c2JMfkwAab1nCbglkTFztol7OHx9bf27UThiNoYTvExqbRvYVJI0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Tue, 14 Jul 2020 08:06:35 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 08:06:35 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/17] drm/amd/powerplay: drop unused code
Date: Tue, 14 Jul 2020 16:04:02 +0800
Message-Id: <20200714080416.6506-3-evan.quan@amd.com>
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
 15.20.3174.22 via Frontend Transport; Tue, 14 Jul 2020 08:06:34 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 51718fe0-206b-49b2-e6fe-08d827ccd3ce
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4355F9514C3F546C59163C1EE4610@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:225;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QTJO3W/9fOsR4+UYtzF+O9dWsbF3gWW5BuElic2OT9YisA3ebXGFY/c35b6/ekvBrcF9ZGo7PV33yjDd9lU4J0pCXzBe7EqIPFXHzuGFlN0aHa79SYWU1G5ZtRMaG7q0uivY4OzsiOwcZAZlffph5LW/O3DUrLssdCYPEA8B0yznhPwrh9zqPUXZPlCvAjHo7netAeRrgEYfG7IEpdqV0Ox1OycETnI0BhtV9Gmz+s9qmV8GxKzLq8pg4KsB+nra/891VDxFGtGbI+qPKmtiA/8fAM8NYyyV3oDgJ71vCwPaljFcRH6J4RHTvnT2edSy1mwZlsIppcLkfTkDle6O8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(478600001)(83380400001)(316002)(4326008)(2616005)(8936002)(8676002)(66574015)(36756003)(66946007)(66556008)(1076003)(44832011)(2906002)(956004)(66476007)(6486002)(5660300002)(52116002)(6666004)(186003)(30864003)(86362001)(7696005)(16526019)(26005)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0tcElhBD4uEFjGbO21ojnmQZ/mIvRiZnAGfzEjpUbrLEumAwKNIryVrOfOlFZZa63Yl/EeeUZSjxDqy35sYueF/Rofr6aLiD80JX4TeT+ylp/aWd9snwOpsqJj3tGBPqrgI+R2OGRUkUTilLIvKFQrqvcRbmIw5gzLRM9oCAvmSpCJxBOiMg9e5Lvh5/mqPs21wT85JBZYMMSt2MXbvV//Wpd8HJRPqxF3xSSJRRJAodnpBqa5JtmsKkarlatwOqPe/nbS1bQpUXvUgVvcTTGWMvPDmIIeo4J3LB6hhj9f959kgNXHk7PyCdNjvOS+/AMJbrTWZK/kNwrmmSrQD+p35D+Rg3f5ef2Fx6ACI3aDqKLz0YWFKXDUooULNb9Y7zT9buqDPXszjaEKSuBuQDnecUsPmTA1nYZ9yNRw+/PqaKVTcCUtsEeHAmQvy5RdA+hSlRJ6ADDex81WEx7FMt177V7fM9KiX3OR1bMIyoqxPXl8NKHwvvrpM6owA/AwNk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51718fe0-206b-49b2-e6fe-08d827ccd3ce
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 08:06:35.5087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BO778yd70tobMQGMwJoprutNd5d1aeio/ptzteiz1waWxCBNWplsBfvDTRgAnUMk
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

Those code were obsoleted by new common API
smu_cmn_to_asic_specific_index().

Change-Id: I4c284c291c2a4bf25736d54f8ffa2892cb25395b
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 119 ------------------
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |   6 -
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  11 --
 drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h |   6 -
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 118 -----------------
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    |  85 -------------
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 114 -----------------
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |   6 -
 8 files changed, 465 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 53bac77d0f9e..7a9793663c61 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -206,118 +206,6 @@ static const struct cmn2asic_mapping arcturus_workload_map[PP_SMC_POWER_PROFILE_
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
 };
 
-static int arcturus_get_smu_msg_index(struct smu_context *smc, uint32_t index)
-{
-#if 0
-	struct smu_11_0_msg_mapping mapping;
-
-	if (index >= SMU_MSG_MAX_COUNT)
-		return -EINVAL;
-
-	mapping = arcturus_message_map[index];
-	if (!(mapping.valid_mapping))
-		return -EINVAL;
-
-	if (amdgpu_sriov_vf(smc->adev) && !mapping.valid_in_vf)
-		return -EACCES;
-
-	return mapping.map_to;
-#endif
-	return 0;
-}
-
-static int arcturus_get_smu_clk_index(struct smu_context *smc, uint32_t index)
-{
-#if 0
-	struct smu_11_0_cmn2aisc_mapping mapping;
-
-	if (index >= SMU_CLK_COUNT)
-		return -EINVAL;
-
-	mapping = arcturus_clk_map[index];
-	if (!(mapping.valid_mapping)) {
-		dev_warn(smc->adev->dev, "Unsupported SMU clk: %d\n", index);
-		return -EINVAL;
-	}
-
-	return mapping.map_to;
-#endif
-	return 0;
-}
-
-static int arcturus_get_smu_feature_index(struct smu_context *smc, uint32_t index)
-{
-#if 0
-	struct smu_11_0_cmn2aisc_mapping mapping;
-
-	if (index >= SMU_FEATURE_COUNT)
-		return -EINVAL;
-
-	mapping = arcturus_feature_mask_map[index];
-	if (!(mapping.valid_mapping)) {
-		return -EINVAL;
-	}
-
-	return mapping.map_to;
-#endif
-	return 0;
-}
-
-static int arcturus_get_smu_table_index(struct smu_context *smc, uint32_t index)
-{
-#if 0
-	struct smu_11_0_cmn2aisc_mapping mapping;
-
-	if (index >= SMU_TABLE_COUNT)
-		return -EINVAL;
-
-	mapping = arcturus_table_map[index];
-	if (!(mapping.valid_mapping)) {
-		dev_warn(smc->adev->dev, "Unsupported SMU table: %d\n", index);
-		return -EINVAL;
-	}
-
-	return mapping.map_to;
-#endif
-	return 0;
-}
-
-static int arcturus_get_pwr_src_index(struct smu_context *smc, uint32_t index)
-{
-#if 0
-	struct smu_11_0_cmn2aisc_mapping mapping;
-
-	if (index >= SMU_POWER_SOURCE_COUNT)
-		return -EINVAL;
-
-	mapping = arcturus_pwr_src_map[index];
-	if (!(mapping.valid_mapping)) {
-		dev_warn(smc->adev->dev, "Unsupported SMU power source: %d\n", index);
-		return -EINVAL;
-	}
-
-	return mapping.map_to;
-#endif
-	return 0;
-}
-
-static int arcturus_get_workload_type(struct smu_context *smu, enum PP_SMC_POWER_PROFILE profile)
-{
-#if 0
-	struct smu_11_0_cmn2aisc_mapping mapping;
-
-	if (profile > PP_SMC_POWER_PROFILE_CUSTOM)
-		return -EINVAL;
-
-	mapping = arcturus_workload_map[profile];
-	if (!(mapping.valid_mapping))
-		return -EINVAL;
-
-	return mapping.map_to;
-#endif
-	return 0;
-}
-
 static int arcturus_tables_init(struct smu_context *smu, struct smu_table *tables)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -2338,13 +2226,6 @@ static void arcturus_log_thermal_throttling_event(struct smu_context *smu)
 }
 
 static const struct pptable_funcs arcturus_ppt_funcs = {
-	/* translate smu index into arcturus specific index */
-	.get_smu_msg_index = arcturus_get_smu_msg_index,
-	.get_smu_clk_index = arcturus_get_smu_clk_index,
-	.get_smu_feature_index = arcturus_get_smu_feature_index,
-	.get_smu_table_index = arcturus_get_smu_table_index,
-	.get_smu_power_index= arcturus_get_pwr_src_index,
-	.get_workload_type = arcturus_get_workload_type,
 	/* internal structurs allocations */
 	.tables_init = arcturus_tables_init,
 	.alloc_dpm_context = arcturus_allocate_dpm_context,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 5bcc52ee579e..9efbeb2e99aa 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -452,12 +452,6 @@ struct i2c_adapter;
 
 struct pptable_funcs {
 	int (*alloc_dpm_context)(struct smu_context *smu);
-	int (*get_smu_msg_index)(struct smu_context *smu, uint32_t index);
-	int (*get_smu_clk_index)(struct smu_context *smu, uint32_t index);
-	int (*get_smu_feature_index)(struct smu_context *smu, uint32_t index);
-	int (*get_smu_table_index)(struct smu_context *smu, uint32_t index);
-	int (*get_smu_power_index)(struct smu_context *smu, uint32_t index);
-	int (*get_workload_type)(struct smu_context *smu, enum PP_SMC_POWER_PROFILE profile);
 	int (*run_btc)(struct smu_context *smu);
 	int (*get_allowed_feature_mask)(struct smu_context *smu, uint32_t *feature_mask, uint32_t num);
 	enum amd_pm_state_type (*get_current_power_state)(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 739f4cd83b91..df4d7633b04b 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -61,17 +61,6 @@ static const struct smu_temperature_range smu11_thermal_policy[] =
 	{ 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000},
 };
 
-struct smu_11_0_msg_mapping {
-	int	valid_mapping;
-	int	map_to;
-	int	valid_in_vf;
-};
-
-struct smu_11_0_cmn2aisc_mapping {
-	int	valid_mapping;
-	int	map_to;
-};
-
 struct smu_11_0_max_sustainable_clocks {
 	uint32_t display_clock;
 	uint32_t phy_clock;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
index fd83a723f32c..20652b38f96d 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
@@ -31,12 +31,6 @@
 #define MP1_Public			0x03b00000
 #define MP1_SRAM			0x03c00004
 
-
-struct smu_12_0_cmn2aisc_mapping {
-	int	valid_mapping;
-	int	map_to;
-};
-
 int smu_v12_0_send_msg_without_waiting(struct smu_context *smu,
 					      uint16_t msg);
 
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index ad2618dde837..978d9762678a 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -226,118 +226,6 @@ static struct cmn2asic_mapping navi10_workload_map[PP_SMC_POWER_PROFILE_COUNT] =
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
 };
 
-static int navi10_get_smu_msg_index(struct smu_context *smc, uint32_t index)
-{
-#if 0
-	struct smu_11_0_msg_mapping mapping;
-
-	if (index >= SMU_MSG_MAX_COUNT)
-		return -EINVAL;
-
-	mapping = navi10_message_map[index];
-	if (!(mapping.valid_mapping)) {
-		return -EINVAL;
-	}
-
-	if (amdgpu_sriov_vf(smc->adev) && !mapping.valid_in_vf)
-		return -EACCES;
-
-	return mapping.map_to;
-#endif
-	return 0;
-}
-
-static int navi10_get_smu_clk_index(struct smu_context *smc, uint32_t index)
-{
-#if 0
-	struct smu_11_0_cmn2aisc_mapping mapping;
-
-	if (index >= SMU_CLK_COUNT)
-		return -EINVAL;
-
-	mapping = navi10_clk_map[index];
-	if (!(mapping.valid_mapping)) {
-		return -EINVAL;
-	}
-
-	return mapping.map_to;
-#endif
-	return 0;
-}
-
-static int navi10_get_smu_feature_index(struct smu_context *smc, uint32_t index)
-{
-#if 0
-	struct smu_11_0_cmn2aisc_mapping mapping;
-
-	if (index >= SMU_FEATURE_COUNT)
-		return -EINVAL;
-
-	mapping = navi10_feature_mask_map[index];
-	if (!(mapping.valid_mapping)) {
-		return -EINVAL;
-	}
-
-	return mapping.map_to;
-#endif
-	return 0;
-}
-
-static int navi10_get_smu_table_index(struct smu_context *smc, uint32_t index)
-{
-#if 0
-	struct smu_11_0_cmn2aisc_mapping mapping;
-
-	if (index >= SMU_TABLE_COUNT)
-		return -EINVAL;
-
-	mapping = navi10_table_map[index];
-	if (!(mapping.valid_mapping)) {
-		return -EINVAL;
-	}
-
-	return mapping.map_to;
-#endif
-	return 0;
-}
-
-static int navi10_get_pwr_src_index(struct smu_context *smc, uint32_t index)
-{
-#if 0
-	struct smu_11_0_cmn2aisc_mapping mapping;
-
-	if (index >= SMU_POWER_SOURCE_COUNT)
-		return -EINVAL;
-
-	mapping = navi10_pwr_src_map[index];
-	if (!(mapping.valid_mapping)) {
-		return -EINVAL;
-	}
-
-	return mapping.map_to;
-#endif
-	return 0;
-}
-
-
-static int navi10_get_workload_type(struct smu_context *smu, enum PP_SMC_POWER_PROFILE profile)
-{
-#if 0
-	struct smu_11_0_cmn2aisc_mapping mapping;
-
-	if (profile > PP_SMC_POWER_PROFILE_CUSTOM)
-		return -EINVAL;
-
-	mapping = navi10_workload_map[profile];
-	if (!(mapping.valid_mapping)) {
-		return -EINVAL;
-	}
-
-	return mapping.map_to;
-#endif
-	return 0;
-}
-
 static bool is_asic_secure(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -2367,12 +2255,6 @@ static int navi10_disable_umc_cdr_12gbps_workaround(struct smu_context *smu)
 static const struct pptable_funcs navi10_ppt_funcs = {
 	.tables_init = navi10_tables_init,
 	.alloc_dpm_context = navi10_allocate_dpm_context,
-	.get_smu_msg_index = navi10_get_smu_msg_index,
-	.get_smu_clk_index = navi10_get_smu_clk_index,
-	.get_smu_feature_index = navi10_get_smu_feature_index,
-	.get_smu_table_index = navi10_get_smu_table_index,
-	.get_smu_power_index = navi10_get_pwr_src_index,
-	.get_workload_type = navi10_get_workload_type,
 	.get_allowed_feature_mask = navi10_get_allowed_feature_mask,
 	.set_default_dpm_table = navi10_set_default_dpm_table,
 	.dpm_set_vcn_enable = navi10_dpm_set_vcn_enable,
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index cff855d2997f..61560192e73c 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -127,58 +127,6 @@ static struct cmn2asic_mapping renoir_workload_map[PP_SMC_POWER_PROFILE_COUNT] =
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
 };
 
-static int renoir_get_smu_msg_index(struct smu_context *smc, uint32_t index)
-{
-#if 0
-	struct smu_12_0_cmn2aisc_mapping mapping;
-
-	if (index >= SMU_MSG_MAX_COUNT)
-		return -EINVAL;
-
-	mapping = renoir_message_map[index];
-	if (!(mapping.valid_mapping))
-		return -EINVAL;
-
-	return mapping.map_to;
-#endif
-	return 0;
-}
-
-static int renoir_get_smu_clk_index(struct smu_context *smc, uint32_t index)
-{
-#if 0
-	struct smu_12_0_cmn2aisc_mapping mapping;
-
-	if (index >= SMU_CLK_COUNT)
-		return -EINVAL;
-
-	mapping = renoir_clk_map[index];
-	if (!(mapping.valid_mapping)) {
-		return -EINVAL;
-	}
-
-	return mapping.map_to;
-#endif
-	return 0;
-}
-
-static int renoir_get_smu_table_index(struct smu_context *smc, uint32_t index)
-{
-#if 0
-	struct smu_12_0_cmn2aisc_mapping mapping;
-
-	if (index >= SMU_TABLE_COUNT)
-		return -EINVAL;
-
-	mapping = renoir_table_map[index];
-	if (!(mapping.valid_mapping))
-		return -EINVAL;
-
-	return mapping.map_to;
-#endif
-	return 0;
-}
-
 static int renoir_get_metrics_table(struct smu_context *smu,
 				    SmuMetrics_t *metrics_table)
 {
@@ -663,35 +611,6 @@ static int renoir_get_current_activity_percent(struct smu_context *smu,
 	return 0;
 }
 
-static int renoir_get_workload_type(struct smu_context *smu, uint32_t profile)
-{
-
-	uint32_t  pplib_workload = 0;
-
-	switch (profile) {
-	case PP_SMC_POWER_PROFILE_FULLSCREEN3D:
-		pplib_workload = WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT;
-		break;
-	case PP_SMC_POWER_PROFILE_CUSTOM:
-		pplib_workload = WORKLOAD_PPLIB_COUNT;
-		break;
-	case PP_SMC_POWER_PROFILE_VIDEO:
-		pplib_workload = WORKLOAD_PPLIB_VIDEO_BIT;
-		break;
-	case PP_SMC_POWER_PROFILE_VR:
-		pplib_workload = WORKLOAD_PPLIB_VR_BIT;
-		break;
-	case PP_SMC_POWER_PROFILE_COMPUTE:
-		pplib_workload = WORKLOAD_PPLIB_COMPUTE_BIT;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return pplib_workload;
-}
-
-
 /**
  * This interface get dpm clock table for dc
  */
@@ -1048,16 +967,12 @@ static bool renoir_is_dpm_running(struct smu_context *smu)
 }
 
 static const struct pptable_funcs renoir_ppt_funcs = {
-	.get_smu_msg_index = renoir_get_smu_msg_index,
-	.get_smu_clk_index = renoir_get_smu_clk_index,
-	.get_smu_table_index = renoir_get_smu_table_index,
 	.tables_init = renoir_tables_init,
 	.set_power_state = NULL,
 	.print_clk_levels = renoir_print_clk_levels,
 	.get_current_power_state = renoir_get_current_power_state,
 	.dpm_set_vcn_enable = renoir_dpm_set_vcn_enable,
 	.dpm_set_jpeg_enable = renoir_dpm_set_jpeg_enable,
-	.get_workload_type = renoir_get_workload_type,
 	.force_clk_levels = renoir_force_clk_levels,
 	.set_power_profile_mode = renoir_set_power_profile_mode,
 	.set_performance_level = renoir_set_performance_level,
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 39712574e656..cbd6f492cbb8 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -205,114 +205,6 @@ static struct cmn2asic_mapping sienna_cichlid_workload_map[PP_SMC_POWER_PROFILE_
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
 };
 
-static int sienna_cichlid_get_smu_msg_index(struct smu_context *smc, uint32_t index)
-{
-#if 0
-	struct smu_11_0_cmn2aisc_mapping mapping;
-
-	if (index >= SMU_MSG_MAX_COUNT)
-		return -EINVAL;
-
-	mapping = sienna_cichlid_message_map[index];
-	if (!(mapping.valid_mapping)) {
-		return -EINVAL;
-	}
-
-	return mapping.map_to;
-#endif
-	return 0;
-}
-
-static int sienna_cichlid_get_smu_clk_index(struct smu_context *smc, uint32_t index)
-{
-#if 0
-	struct smu_11_0_cmn2aisc_mapping mapping;
-
-	if (index >= SMU_CLK_COUNT)
-		return -EINVAL;
-
-	mapping = sienna_cichlid_clk_map[index];
-	if (!(mapping.valid_mapping)) {
-		return -EINVAL;
-	}
-
-	return mapping.map_to;
-#endif
-	return 0;
-}
-
-static int sienna_cichlid_get_smu_feature_index(struct smu_context *smc, uint32_t index)
-{
-#if 0
-	struct smu_11_0_cmn2aisc_mapping mapping;
-
-	if (index >= SMU_FEATURE_COUNT)
-		return -EINVAL;
-
-	mapping = sienna_cichlid_feature_mask_map[index];
-	if (!(mapping.valid_mapping)) {
-		return -EINVAL;
-	}
-
-	return mapping.map_to;
-#endif
-	return 0;
-}
-
-static int sienna_cichlid_get_smu_table_index(struct smu_context *smc, uint32_t index)
-{
-#if 0
-	struct smu_11_0_cmn2aisc_mapping mapping;
-
-	if (index >= SMU_TABLE_COUNT)
-		return -EINVAL;
-
-	mapping = sienna_cichlid_table_map[index];
-	if (!(mapping.valid_mapping)) {
-		return -EINVAL;
-	}
-
-	return mapping.map_to;
-#endif
-	return 0;
-}
-
-static int sienna_cichlid_get_pwr_src_index(struct smu_context *smc, uint32_t index)
-{
-#if 0
-	struct smu_11_0_cmn2aisc_mapping mapping;
-
-	if (index >= SMU_POWER_SOURCE_COUNT)
-		return -EINVAL;
-
-	mapping = sienna_cichlid_pwr_src_map[index];
-	if (!(mapping.valid_mapping)) {
-		return -EINVAL;
-	}
-
-	return mapping.map_to;
-#endif
-	return 0;
-}
-
-static int sienna_cichlid_get_workload_type(struct smu_context *smu, enum PP_SMC_POWER_PROFILE profile)
-{
-#if 0
-	struct smu_11_0_cmn2aisc_mapping mapping;
-
-	if (profile > PP_SMC_POWER_PROFILE_CUSTOM)
-		return -EINVAL;
-
-	mapping = sienna_cichlid_workload_map[profile];
-	if (!(mapping.valid_mapping)) {
-		return -EINVAL;
-	}
-
-	return mapping.map_to;
-#endif
-	return 0;
-}
-
 static int
 sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 				  uint32_t *feature_mask, uint32_t num)
@@ -2483,12 +2375,6 @@ static void sienna_cichlid_dump_pptable(struct smu_context *smu)
 static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.tables_init = sienna_cichlid_tables_init,
 	.alloc_dpm_context = sienna_cichlid_allocate_dpm_context,
-	.get_smu_msg_index = sienna_cichlid_get_smu_msg_index,
-	.get_smu_clk_index = sienna_cichlid_get_smu_clk_index,
-	.get_smu_feature_index = sienna_cichlid_get_smu_feature_index,
-	.get_smu_table_index = sienna_cichlid_get_smu_table_index,
-	.get_smu_power_index = sienna_cichlid_get_pwr_src_index,
-	.get_workload_type = sienna_cichlid_get_workload_type,
 	.get_allowed_feature_mask = sienna_cichlid_get_allowed_feature_mask,
 	.set_default_dpm_table = sienna_cichlid_set_default_dpm_table,
 	.dpm_set_vcn_enable = sienna_cichlid_dpm_set_vcn_enable,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index afb3ef874fc5..729eb3895307 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -68,12 +68,6 @@
 #define smu_apply_clocks_adjust_rules(smu)				smu_ppt_funcs(apply_clocks_adjust_rules, 0, smu)
 #define smu_notify_smc_display_config(smu)				smu_ppt_funcs(notify_smc_display_config, 0, smu)
 #define smu_set_cpu_power_state(smu)					smu_ppt_funcs(set_cpu_power_state, 0, smu)
-#define smu_msg_get_index(smu, msg)					smu_ppt_funcs(get_smu_msg_index, -EINVAL, smu, msg)
-#define smu_clk_get_index(smu, clk)					smu_ppt_funcs(get_smu_clk_index, -EINVAL, smu, clk)
-#define smu_feature_get_index(smu, fea)					smu_ppt_funcs(get_smu_feature_index, -EINVAL, smu, fea)
-#define smu_table_get_index(smu, tab)					smu_ppt_funcs(get_smu_table_index, -EINVAL, smu, tab)
-#define smu_power_get_index(smu, src)					smu_ppt_funcs(get_smu_power_index, -EINVAL, smu, src)
-#define smu_workload_get_type(smu, type)				smu_ppt_funcs(get_workload_type, -EINVAL, smu, type)
 #define smu_run_btc(smu)						smu_ppt_funcs(run_btc, 0, smu)
 #define smu_get_allowed_feature_mask(smu, feature_mask, num)		smu_ppt_funcs(get_allowed_feature_mask, 0, smu, feature_mask, num)
 #define smu_store_cc6_data(smu, st, cc6_dis, pst_dis, pst_sw_dis)	smu_ppt_funcs(store_cc6_data, 0, smu, st, cc6_dis, pst_dis, pst_sw_dis)
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
