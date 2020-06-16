Return-Path: <SRS0=tiv0=75=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34991C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 10:30:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F18192074D
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 10:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SnmKuG+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18192074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C68B6E878;
	Tue, 16 Jun 2020 10:30:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 421516E878
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2020 10:30:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2r6VCzqrcQpiEddf4H70IHyzLGz9BKaCBt5ZoDXsiXyW5fbx4V4kZWN0AnCK96qTbXXjKKvlxW/NBLqjsZ1SCMwFG7mVDeDMe3MKuQjqSuQIRkWTdZpiKMarZfNfNNVBSafTmxU5QZvVzxTWlIdYcm9Nfsr5GoKqs4fTy5Gu+M1UPCVMRiQ1DLVyH/F4/u4doVTpVt0ItMTqRJ8qDVpFkfgrzMvo5otPx2/byjnXvz1MnMaGdF95rMzQakaHPC2DQLbw50/HsZuj5pF6JArIw84q+qhgu1YmCVfKU4aQn/Geo0GleVqnyz1LUj7G53peydciqQzUb+95gDDNzyxMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PB2dIsDh+cwxeVPe/fKuvLYJfPQV2L/Yu3Wd5AMlX3k=;
 b=EI+i+YONn/ObwBoI6JRW0fea4OMkOXuX6erBXm3F7C5WJ20HvHlDDS152eSjYjsPrnHtaLXbz1jPTE7XlAYPxNI+JvCtkao9lAyl7qit/hvv86gnVeasePHhLMhEJRlB+FOxe4AeYMUF47zhfngqJC0XMwgsSSxVZeHdb4f0be7f/5I3wjwi5b3ylU2QOJjUKk7e4IJgonUsA5lfbvn48EABN/z6zGQp3bZVqwhjmaDqA99G1Fr5fp0+xFTrAXcwH2+lPuWnA0P7uGAgL/CS5fZRl6mkEaAUfQc+rv7JNnaUsmyiymxRiY+kZfz0yyae5cDNCAEdZ5jtiqpUC1R9sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PB2dIsDh+cwxeVPe/fKuvLYJfPQV2L/Yu3Wd5AMlX3k=;
 b=SnmKuG+JBbnXODSk6SwCZbyJ6P+pLUA5vENY6ByH9Or3TZy+ZGau0tfNIORVY//nEBlgkmTVl7DkBKwlYAFyBLJc+cRoUKo1nC4botJbHKnxcI9AAGwR/gJ96xJV19nbpMPpnNfVBhJXuLU8c1DTpq6Y6dlSQ/sioXGYvwIw0jM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3165.namprd12.prod.outlook.com (2603:10b6:208:ac::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Tue, 16 Jun
 2020 10:29:55 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::493c:9d42:501b:59d6]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::493c:9d42:501b:59d6%3]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 10:29:55 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amd/smu: unify smu ppt callback marcos
Date: Tue, 16 Jun 2020 18:29:37 +0800
Message-Id: <20200616102937.12417-2-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616102937.12417-1-kevin1.wang@amd.com>
References: <20200616102937.12417-1-kevin1.wang@amd.com>
X-ClientProxiedBy: HK2PR06CA0021.apcprd06.prod.outlook.com
 (2603:1096:202:2e::33) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-u1804-kvm.amd.com (58.247.170.245) by
 HK2PR06CA0021.apcprd06.prod.outlook.com (2603:1096:202:2e::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21 via Frontend Transport; Tue, 16 Jun 2020 10:29:53 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 36f20773-5bd8-4d32-e26a-08d811e035e6
X-MS-TrafficTypeDiagnostic: MN2PR12MB3165:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3165A8778389D71A95C776C5A29D0@MN2PR12MB3165.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EZRIxAxw/BHgE2GJTr7jR+FU1x95ffH8ndwJRS7B0saXEsjvAsHJoLkqZV8yAGaBZfXS71k4ZuqaTIferZex9bbocunTM3Wsz+Htb738TxBjZTRehw0S+g/D+8Zr3bOVnMm6Cy9XK7qG5ekonelDqIlGsqQiXaMlexaUKCmDc3bM/hQns4exVlITmJegIIWXwbv6YJBWmEEQq5TsJWONn2nayyd7R1TxJVjP9520dACldPgvxIEtmrEUccW8H4XHAXo6aiCC25Pg/yOC86f80yB8QsZcHTmTVBU9sVaIm9VSl3SSD8rHkZYLy7wJSevIHQqEBps/528oQCXy2iRutlpmt8OFo7G6Kwpb65XYRRpA5p4JJgaECE5fStPK54M6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(66946007)(6666004)(66476007)(86362001)(66556008)(316002)(36756003)(8936002)(16526019)(186003)(66574015)(8676002)(2906002)(7696005)(6486002)(26005)(52116002)(5660300002)(4326008)(83380400001)(478600001)(956004)(2616005)(30864003)(6916009)(1076003)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Qq8BDqtvUur5iTsCsyG0vumGky/jT1OhjdV1ZQpZwmxftqQIyToplgZkfbojlaLAMXfnDI27zY/hM6Hr/AzgabVb3QCgm1SwZaQm5HFHiRDbu9GMF6/0sbtITQFcTVi1xNocg/pYUHh4u4fktCcpH3mjYkeTUiomhpVf2mLIQtLhZab5Q0RP27MR3mzCkK/KRhVSvHu1GBcwmkxCcrXP5/CRvOmGH01YOx0eo7F3jI/DwTMVOnZLy4/DXoZDvumlWZBO1IiG7pxkRhKH0N+kbgStahBy/kYTWXrMFZIEc6+l5ygIt+Qtq2uUDhiPAnmRhUqZ08z5/PxpZQREclwO+gh8SXI6thqf3464u1nR6is05G+v6yywJjJaTzIS+6Me3oai88P6VtiPuZmbcjgtdLGtPPYZi8j1pG1EcvaUY0LozdKc/7MAwUXKQnDnJNHdtIi+4Qd1EgzyHkWbFBV8e4M8XN2vEPuafFO1Xrm2P7dSWGyobYCIeV8hXyosxRwU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f20773-5bd8-4d32-e26a-08d811e035e6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 10:29:54.9854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnDKi9BvNcQy28UfbaBrzruPRl8UddS2Hbrgn/sqxwu798aegowC99WJQNhryMPv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3165
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
Cc: alexander.deucher@amd.com, Kevin Wang <kevin1.wang@amd.com>,
 hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

v1: add the new macro "smu_ppt_xxx()" to unify smu callback interfaces
v2: rename the macro smu_ppt_xxx to smu_ppt_funcs.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_internal.h | 267 ++++++-------------
 1 file changed, 82 insertions(+), 185 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 880ef54884f8..afd786b6c0b4 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -25,191 +25,88 @@
 
 #include "amdgpu_smu.h"
 
-#define smu_init_microcode(smu) \
-	((smu)->ppt_funcs->init_microcode ? (smu)->ppt_funcs->init_microcode((smu)) : 0)
-#define smu_fini_microcode(smu) \
-	((smu)->ppt_funcs->fini_microcode ? (smu)->ppt_funcs->fini_microcode((smu)) : 0)
-#define smu_init_smc_tables(smu) \
-	((smu)->ppt_funcs->init_smc_tables ? (smu)->ppt_funcs->init_smc_tables((smu)) : 0)
-#define smu_fini_smc_tables(smu) \
-	((smu)->ppt_funcs->fini_smc_tables ? (smu)->ppt_funcs->fini_smc_tables((smu)) : 0)
-#define smu_init_power(smu) \
-	((smu)->ppt_funcs->init_power ? (smu)->ppt_funcs->init_power((smu)) : 0)
-#define smu_fini_power(smu) \
-	((smu)->ppt_funcs->fini_power ? (smu)->ppt_funcs->fini_power((smu)) : 0)
-
-#define smu_setup_pptable(smu) \
-	((smu)->ppt_funcs->setup_pptable ? (smu)->ppt_funcs->setup_pptable((smu)) : 0)
-#define smu_powergate_sdma(smu, gate) \
-	((smu)->ppt_funcs->powergate_sdma ? (smu)->ppt_funcs->powergate_sdma((smu), (gate)) : 0)
-
-#define smu_get_vbios_bootup_values(smu) \
-	((smu)->ppt_funcs->get_vbios_bootup_values ? (smu)->ppt_funcs->get_vbios_bootup_values((smu)) : 0)
-#define smu_check_fw_version(smu) \
-	((smu)->ppt_funcs->check_fw_version ? (smu)->ppt_funcs->check_fw_version((smu)) : 0)
-#define smu_write_pptable(smu) \
-	((smu)->ppt_funcs->write_pptable ? (smu)->ppt_funcs->write_pptable((smu)) : 0)
-#define smu_set_min_dcef_deep_sleep(smu, clk) \
-	((smu)->ppt_funcs->set_min_dcef_deep_sleep ? (smu)->ppt_funcs->set_min_dcef_deep_sleep((smu), (clk)) : 0)
-#define smu_set_driver_table_location(smu) \
-	((smu)->ppt_funcs->set_driver_table_location ? (smu)->ppt_funcs->set_driver_table_location((smu)) : 0)
-#define smu_set_tool_table_location(smu) \
-	((smu)->ppt_funcs->set_tool_table_location ? (smu)->ppt_funcs->set_tool_table_location((smu)) : 0)
-#define smu_notify_memory_pool_location(smu) \
-	((smu)->ppt_funcs->notify_memory_pool_location ? (smu)->ppt_funcs->notify_memory_pool_location((smu)) : 0)
-#define smu_gfx_off_control(smu, enable) \
-	((smu)->ppt_funcs->gfx_off_control ? (smu)->ppt_funcs->gfx_off_control((smu), (enable)) : 0)
-
-#define smu_set_last_dcef_min_deep_sleep_clk(smu) \
-	((smu)->ppt_funcs->set_last_dcef_min_deep_sleep_clk ? (smu)->ppt_funcs->set_last_dcef_min_deep_sleep_clk((smu)) : 0)
-#define smu_system_features_control(smu, en) \
-	((smu)->ppt_funcs->system_features_control ? (smu)->ppt_funcs->system_features_control((smu), (en)) : 0)
-#define smu_init_max_sustainable_clocks(smu) \
-	((smu)->ppt_funcs->init_max_sustainable_clocks ? (smu)->ppt_funcs->init_max_sustainable_clocks((smu)) : 0)
-#define smu_set_default_od_settings(smu) \
-	((smu)->ppt_funcs->set_default_od_settings ? (smu)->ppt_funcs->set_default_od_settings((smu)) : 0)
-
-#define smu_send_smc_msg_with_param(smu, msg, param, read_arg) \
-	((smu)->ppt_funcs->send_smc_msg_with_param? (smu)->ppt_funcs->send_smc_msg_with_param((smu), (msg), (param), (read_arg)) : 0)
-
-static inline int smu_send_smc_msg(struct smu_context *smu, enum smu_message_type msg, uint32_t *read_arg) {
-	return smu_send_smc_msg_with_param(smu, msg, 0, read_arg);
-}
-
-#define smu_alloc_dpm_context(smu) \
-	((smu)->ppt_funcs->alloc_dpm_context ? (smu)->ppt_funcs->alloc_dpm_context((smu)) : 0)
-#define smu_init_display_count(smu, count) \
-	((smu)->ppt_funcs->init_display_count ? (smu)->ppt_funcs->init_display_count((smu), (count)) : 0)
-#define smu_feature_set_allowed_mask(smu) \
-	((smu)->ppt_funcs->set_allowed_mask? (smu)->ppt_funcs->set_allowed_mask((smu)) : 0)
-#define smu_feature_get_enabled_mask(smu, mask, num) \
-	((smu)->ppt_funcs->get_enabled_mask? (smu)->ppt_funcs->get_enabled_mask((smu), (mask), (num)) : 0)
-#define smu_is_dpm_running(smu) \
-	((smu)->ppt_funcs->is_dpm_running ? (smu)->ppt_funcs->is_dpm_running((smu)) : 0)
-#define smu_notify_display_change(smu) \
-	((smu)->ppt_funcs->notify_display_change? (smu)->ppt_funcs->notify_display_change((smu)) : 0)
-#define smu_set_default_dpm_table(smu) \
-	((smu)->ppt_funcs->set_default_dpm_table ? (smu)->ppt_funcs->set_default_dpm_table((smu)) : 0)
-#define smu_populate_umd_state_clk(smu) \
-	((smu)->ppt_funcs->populate_umd_state_clk ? (smu)->ppt_funcs->populate_umd_state_clk((smu)) : 0)
-#define smu_set_default_od8_settings(smu) \
-	((smu)->ppt_funcs->set_default_od8_settings ? (smu)->ppt_funcs->set_default_od8_settings((smu)) : 0)
-
-#define smu_get_current_clk_freq(smu, clk_id, value) \
-	((smu)->ppt_funcs->get_current_clk_freq? (smu)->ppt_funcs->get_current_clk_freq((smu), (clk_id), (value)) : 0)
-
-#define smu_tables_init(smu, tab) \
-	((smu)->ppt_funcs->tables_init ? (smu)->ppt_funcs->tables_init((smu), (tab)) : 0)
-#define smu_set_thermal_fan_table(smu) \
-	((smu)->ppt_funcs->set_thermal_fan_table ? (smu)->ppt_funcs->set_thermal_fan_table((smu)) : 0)
-#define smu_enable_thermal_alert(smu) \
-	((smu)->ppt_funcs->enable_thermal_alert? (smu)->ppt_funcs->enable_thermal_alert((smu)) : 0)
-#define smu_disable_thermal_alert(smu) \
-	((smu)->ppt_funcs->disable_thermal_alert? (smu)->ppt_funcs->disable_thermal_alert((smu)) : 0)
-
-#define smu_smc_read_sensor(smu, sensor, data, size) \
-	((smu)->ppt_funcs->read_sensor? (smu)->ppt_funcs->read_sensor((smu), (sensor), (data), (size)) : -EINVAL)
-
-#define smu_pre_display_config_changed(smu) \
-	((smu)->ppt_funcs->pre_display_config_changed ? (smu)->ppt_funcs->pre_display_config_changed((smu)) : 0)
-#define smu_display_config_changed(smu) \
-	((smu)->ppt_funcs->display_config_changed ? (smu)->ppt_funcs->display_config_changed((smu)) : 0)
-#define smu_apply_clocks_adjust_rules(smu) \
-	((smu)->ppt_funcs->apply_clocks_adjust_rules ? (smu)->ppt_funcs->apply_clocks_adjust_rules((smu)) : 0)
-#define smu_notify_smc_display_config(smu) \
-	((smu)->ppt_funcs->notify_smc_display_config ? (smu)->ppt_funcs->notify_smc_display_config((smu)) : 0)
-#define smu_force_dpm_limit_value(smu, highest) \
-	((smu)->ppt_funcs->force_dpm_limit_value ? (smu)->ppt_funcs->force_dpm_limit_value((smu), (highest)) : 0)
-#define smu_unforce_dpm_levels(smu) \
-	((smu)->ppt_funcs->unforce_dpm_levels ? (smu)->ppt_funcs->unforce_dpm_levels((smu)) : 0)
+#define smu_ppt_funcs(intf, ret, smu, args...) \
+	((smu)->ppt_funcs ? ((smu)->ppt_funcs->intf ? (smu)->ppt_funcs->intf(smu, ##args) : ret) : -EINVAL)
+
+#define smu_init_microcode(smu)						smu_ppt_funcs(init_microcode, 0, smu)
+#define smu_fini_microcode(smu)						smu_ppt_funcs(fini_microcode, 0, smu)
+#define smu_init_smc_tables(smu)					smu_ppt_funcs(init_smc_tables, 0, smu)
+#define smu_fini_smc_tables(smu)					smu_ppt_funcs(fini_smc_tables, 0, smu)
+#define smu_init_power(smu)						smu_ppt_funcs(init_power,	0, smu)
+#define smu_fini_power(smu)						smu_ppt_funcs(fini_power, 0, smu)
+#define smu_setup_pptable(smu)						smu_ppt_funcs(setup_pptable, 0, smu)
+#define smu_powergate_sdma(smu, gate)					smu_ppt_funcs(powergate_sdma, 0, smu, gate)
+#define smu_get_vbios_bootup_values(smu)				smu_ppt_funcs(get_vbios_bootup_values, 0, smu)
+#define smu_check_fw_version(smu)					smu_ppt_funcs(check_fw_version, 0, smu)
+#define smu_write_pptable(smu)						smu_ppt_funcs(write_pptable, 0, smu)
+#define smu_set_min_dcef_deep_sleep(smu, clk)				smu_ppt_funcs(set_min_dcef_deep_sleep, 0, smu, clk)
+#define smu_set_driver_table_location(smu)				smu_ppt_funcs(set_driver_table_location, 0, smu)
+#define smu_set_tool_table_location(smu)				smu_ppt_funcs(set_tool_table_location, 0, smu)
+#define smu_notify_memory_pool_location(smu)				smu_ppt_funcs(notify_memory_pool_location, 0, smu)
+#define smu_gfx_off_control(smu, enable)				smu_ppt_funcs(gfx_off_control, 0, smu, enable)
+#define smu_set_last_dcef_min_deep_sleep_clk(smu)			smu_ppt_funcs(set_last_dcef_min_deep_sleep_clk, 0, smu)
+#define smu_system_features_control(smu, en)				smu_ppt_funcs(system_features_control, 0, smu, en)
+#define smu_init_max_sustainable_clocks(smu)				smu_ppt_funcs(init_max_sustainable_clocks, 0, smu)
+#define smu_set_default_od_settings(smu)				smu_ppt_funcs(set_default_od_settings, 0, smu)
+#define smu_send_smc_msg_with_param(smu, msg, param, read_arg)		smu_ppt_funcs(send_smc_msg_with_param, 0, smu, msg, param, read_arg)
+#define smu_send_smc_msg(smu, msg, read_arg)				smu_ppt_funcs(send_smc_msg_with_param, 0, smu, msg, 0, read_arg)
+#define smu_alloc_dpm_context(smu)					smu_ppt_funcs(alloc_dpm_context, 0, smu)
+#define smu_init_display_count(smu, count)				smu_ppt_funcs(init_display_count, 0, smu, count)
+#define smu_feature_set_allowed_mask(smu)				smu_ppt_funcs(set_allowed_mask, 0, smu)
+#define smu_feature_get_enabled_mask(smu, mask, num)			smu_ppt_funcs(get_enabled_mask, 0, smu, mask, num)
+#define smu_is_dpm_running(smu)						smu_ppt_funcs(is_dpm_running, 0 , smu)
+#define smu_notify_display_change(smu)					smu_ppt_funcs(notify_display_change, 0, smu)
+#define smu_set_default_dpm_table(smu)					smu_ppt_funcs(set_default_dpm_table, 0, smu)
+#define smu_populate_umd_state_clk(smu)					smu_ppt_funcs(populate_umd_state_clk, 0, smu)
+#define smu_set_default_od8_settings(smu)				smu_ppt_funcs(set_default_od8_settings, 0, smu)
+#define smu_get_current_clk_freq(smu, clk_id, value)			smu_ppt_funcs(get_current_clk_freq, 0, smu, clk_id, value)
+#define smu_tables_init(smu, tab)					smu_ppt_funcs(tables_init, 0, smu, tab)
+#define smu_set_thermal_fan_table(smu)					smu_ppt_funcs(set_thermal_fan_table, 0, smu)
+#define smu_enable_thermal_alert(smu)					smu_ppt_funcs(enable_thermal_alert, 0, smu)
+#define smu_disable_thermal_alert(smu)					smu_ppt_funcs(disable_thermal_alert, 0, smu)
+#define smu_smc_read_sensor(smu, sensor, data, size)			smu_ppt_funcs(read_sensor, -EINVAL, smu, sensor, data, size)
+#define smu_pre_display_config_changed(smu)				smu_ppt_funcs(pre_display_config_changed, 0, smu)
+#define smu_display_config_changed(smu)					smu_ppt_funcs(display_config_changed, 0 , smu)
+#define smu_apply_clocks_adjust_rules(smu)				smu_ppt_funcs(apply_clocks_adjust_rules, 0, smu)
+#define smu_notify_smc_display_config(smu)				smu_ppt_funcs(notify_smc_display_config, 0, smu)
+#define smu_force_dpm_limit_value(smu, highest)				smu_ppt_funcs(force_dpm_limit_value, 0, smu, highest)
+#define smu_unforce_dpm_levels(smu)					smu_ppt_funcs(unforce_dpm_levels, 0, smu)
+#define smu_set_cpu_power_state(smu)					smu_ppt_funcs(set_cpu_power_state, 0, smu)
+#define smu_msg_get_index(smu, msg)					smu_ppt_funcs(get_smu_msg_index, -EINVAL, smu, msg)
+#define smu_clk_get_index(smu, clk)					smu_ppt_funcs(get_smu_clk_index, -EINVAL, smu, clk)
+#define smu_feature_get_index(smu, fea)					smu_ppt_funcs(get_smu_feature_index, -EINVAL, smu, fea)
+#define smu_table_get_index(smu, tab)					smu_ppt_funcs(get_smu_table_index, -EINVAL, smu, tab)
+#define smu_power_get_index(smu, src)					smu_ppt_funcs(get_smu_power_index, -EINVAL, smu, src)
+#define smu_workload_get_type(smu, type)				smu_ppt_funcs(get_smu_power_index, -EINVAL, smu, type)
+#define smu_run_btc(smu)						smu_ppt_funcs(run_btc, 0, smu)
+#define smu_get_allowed_feature_mask(smu, feature_mask, num)		smu_ppt_funcs(get_allowed_feature_mask, 0, smu, feature_mask, num)
+#define smu_store_cc6_data(smu, st, cc6_dis, pst_dis, pst_sw_dis)	smu_ppt_funcs(store_cc6_data, 0, smu, st, cc6_dis, pst_dis, pst_sw_dis)
+#define smu_get_dal_power_level(smu, clocks)				smu_ppt_funcs(get_dal_power_level, 0, smu, clocks)
+#define smu_get_perf_level(smu, designation, level)			smu_ppt_funcs(get_perf_level, 0, smu, designation, level)
+#define smu_get_current_shallow_sleep_clocks(smu, clocks)		smu_ppt_funcs(get_current_shallow_sleep_clocks, 0, smu, clocks)
+#define smu_dpm_set_vcn_enable(smu, enable)				smu_ppt_funcs(dpm_set_vcn_enable, 0, smu, enable)
+#define smu_dpm_set_jpeg_enable(smu, enable)				smu_ppt_funcs(dpm_set_jpeg_enable, 0, smu, enable)
+#define smu_set_watermarks_table(smu, tab, clock_ranges)		smu_ppt_funcs(set_watermarks_table, 0, smu, tab, clock_ranges)
+#define smu_get_current_clk_freq_by_table(smu, clk_type, value)		smu_ppt_funcs(get_current_clk_freq_by_table, 0, smu, clk_type, value)
+#define smu_thermal_temperature_range_update(smu, range, rw)		smu_ppt_funcs(thermal_temperature_range_update, 0, smu, range, rw)
+#define smu_get_thermal_temperature_range(smu, range)			smu_ppt_funcs(get_thermal_temperature_range, 0, smu, range)
+#define smu_register_irq_handler(smu)					smu_ppt_funcs(register_irq_handler, 0, smu)
+#define smu_get_dpm_ultimate_freq(smu, param, min, max)			smu_ppt_funcs(get_dpm_ultimate_freq, 0, smu, param, min, max)
+#define smu_asic_set_performance_level(smu, level)			smu_ppt_funcs(set_performance_level, -EINVAL, smu, level)
+#define smu_dump_pptable(smu)						smu_ppt_funcs(dump_pptable, 0, smu)
+#define smu_get_dpm_clk_limited(smu, clk_type, dpm_level, freq)		smu_ppt_funcs(get_dpm_clk_limited, -EINVAL, smu, clk_type, dpm_level, freq)
+#define smu_set_soft_freq_limited_range(smu, clk_type, min, max)	smu_ppt_funcs(set_soft_freq_limited_range, -EINVAL, smu, clk_type, min, max)
+#define smu_override_pcie_parameters(smu)				smu_ppt_funcs(override_pcie_parameters, 0, smu)
+#define smu_update_pcie_parameters(smu, pcie_gen_cap, pcie_width_cap)	smu_ppt_funcs(update_pcie_parameters, 0, smu, pcie_gen_cap, pcie_width_cap)
+#define smu_set_thermal_range(smu, range)				smu_ppt_funcs(set_thermal_range, 0, smu, range)
+#define smu_disable_umc_cdr_12gbps_workaround(smu)			smu_ppt_funcs(disable_umc_cdr_12gbps_workaround, 0, smu)
+#define smu_set_power_source(smu, power_src)				smu_ppt_funcs(set_power_source, 0, smu, power_src)
+#define smu_i2c_eeprom_init(smu, control)				smu_ppt_funcs(i2c_eeprom_init, 0, smu, control)
+#define smu_i2c_eeprom_fini(smu, control)				smu_ppt_funcs(i2c_eeprom_fini, 0, smu, control)
+#define smu_get_unique_id(smu)						smu_ppt_funcs(get_unique_id, 0, smu)
+#define smu_log_thermal_throttling(smu)					smu_ppt_funcs(log_thermal_throttling_event, 0, smu)
+#define smu_get_asic_power_limits(smu)					smu_ppt_funcs(get_power_limit, 0, smu)
 #define smu_get_profiling_clk_mask(smu, level, sclk_mask, mclk_mask, soc_mask) \
-	((smu)->ppt_funcs->get_profiling_clk_mask ? (smu)->ppt_funcs->get_profiling_clk_mask((smu), (level), (sclk_mask), (mclk_mask), (soc_mask)) : 0)
-#define smu_set_cpu_power_state(smu) \
-	((smu)->ppt_funcs->set_cpu_power_state ? (smu)->ppt_funcs->set_cpu_power_state((smu)) : 0)
-
-#define smu_msg_get_index(smu, msg) \
-	((smu)->ppt_funcs? ((smu)->ppt_funcs->get_smu_msg_index? (smu)->ppt_funcs->get_smu_msg_index((smu), (msg)) : -EINVAL) : -EINVAL)
-#define smu_clk_get_index(smu, msg) \
-	((smu)->ppt_funcs? ((smu)->ppt_funcs->get_smu_clk_index? (smu)->ppt_funcs->get_smu_clk_index((smu), (msg)) : -EINVAL) : -EINVAL)
-#define smu_feature_get_index(smu, msg) \
-	((smu)->ppt_funcs? ((smu)->ppt_funcs->get_smu_feature_index? (smu)->ppt_funcs->get_smu_feature_index((smu), (msg)) : -EINVAL) : -EINVAL)
-#define smu_table_get_index(smu, tab) \
-	((smu)->ppt_funcs? ((smu)->ppt_funcs->get_smu_table_index? (smu)->ppt_funcs->get_smu_table_index((smu), (tab)) : -EINVAL) : -EINVAL)
-#define smu_power_get_index(smu, src) \
-	((smu)->ppt_funcs? ((smu)->ppt_funcs->get_smu_power_index? (smu)->ppt_funcs->get_smu_power_index((smu), (src)) : -EINVAL) : -EINVAL)
-#define smu_workload_get_type(smu, profile) \
-	((smu)->ppt_funcs? ((smu)->ppt_funcs->get_workload_type? (smu)->ppt_funcs->get_workload_type((smu), (profile)) : -EINVAL) : -EINVAL)
-#define smu_run_btc(smu) \
-	((smu)->ppt_funcs? ((smu)->ppt_funcs->run_btc? (smu)->ppt_funcs->run_btc((smu)) : 0) : 0)
-#define smu_get_allowed_feature_mask(smu, feature_mask, num) \
-	((smu)->ppt_funcs? ((smu)->ppt_funcs->get_allowed_feature_mask? (smu)->ppt_funcs->get_allowed_feature_mask((smu), (feature_mask), (num)) : 0) : 0)
-
-
-#define smu_store_cc6_data(smu, st, cc6_dis, pst_dis, pst_sw_dis) \
-	((smu)->ppt_funcs->store_cc6_data ? (smu)->ppt_funcs->store_cc6_data((smu), (st), (cc6_dis), (pst_dis), (pst_sw_dis)) : 0)
-
-#define smu_get_dal_power_level(smu, clocks) \
-	((smu)->ppt_funcs->get_dal_power_level ? (smu)->ppt_funcs->get_dal_power_level((smu), (clocks)) : 0)
-#define smu_get_perf_level(smu, designation, level) \
-	((smu)->ppt_funcs->get_perf_level ? (smu)->ppt_funcs->get_perf_level((smu), (designation), (level)) : 0)
-#define smu_get_current_shallow_sleep_clocks(smu, clocks) \
-	((smu)->ppt_funcs->get_current_shallow_sleep_clocks ? (smu)->ppt_funcs->get_current_shallow_sleep_clocks((smu), (clocks)) : 0)
-
-#define smu_dpm_set_vcn_enable(smu, enable) \
-	((smu)->ppt_funcs->dpm_set_vcn_enable ? (smu)->ppt_funcs->dpm_set_vcn_enable((smu), (enable)) : 0)
-#define smu_dpm_set_jpeg_enable(smu, enable) \
-	((smu)->ppt_funcs->dpm_set_jpeg_enable ? (smu)->ppt_funcs->dpm_set_jpeg_enable((smu), (enable)) : 0)
-
-#define smu_set_watermarks_table(smu, tab, clock_ranges) \
-	((smu)->ppt_funcs->set_watermarks_table ? (smu)->ppt_funcs->set_watermarks_table((smu), (tab), (clock_ranges)) : 0)
-#define smu_get_current_clk_freq_by_table(smu, clk_type, value) \
-	((smu)->ppt_funcs->get_current_clk_freq_by_table ? (smu)->ppt_funcs->get_current_clk_freq_by_table((smu), (clk_type), (value)) : 0)
-#define smu_thermal_temperature_range_update(smu, range, rw) \
-	((smu)->ppt_funcs->thermal_temperature_range_update? (smu)->ppt_funcs->thermal_temperature_range_update((smu), (range), (rw)) : 0)
-#define smu_get_thermal_temperature_range(smu, range) \
-	((smu)->ppt_funcs->get_thermal_temperature_range? (smu)->ppt_funcs->get_thermal_temperature_range((smu), (range)) : 0)
-#define smu_register_irq_handler(smu) \
-	((smu)->ppt_funcs->register_irq_handler ? (smu)->ppt_funcs->register_irq_handler(smu) : 0)
-
-#define smu_get_dpm_ultimate_freq(smu, param, min, max) \
-		((smu)->ppt_funcs->get_dpm_ultimate_freq ? (smu)->ppt_funcs->get_dpm_ultimate_freq((smu), (param), (min), (max)) : 0)
-
-#define smu_asic_set_performance_level(smu, level) \
-	((smu)->ppt_funcs->set_performance_level? (smu)->ppt_funcs->set_performance_level((smu), (level)) : -EINVAL);
-#define smu_dump_pptable(smu) \
-	((smu)->ppt_funcs->dump_pptable ? (smu)->ppt_funcs->dump_pptable((smu)) : 0)
-#define smu_get_dpm_clk_limited(smu, clk_type, dpm_level, freq) \
-		((smu)->ppt_funcs->get_dpm_clk_limited ? (smu)->ppt_funcs->get_dpm_clk_limited((smu), (clk_type), (dpm_level), (freq)) : -EINVAL)
-
-#define smu_set_soft_freq_limited_range(smu, clk_type, min, max) \
-		((smu)->ppt_funcs->set_soft_freq_limited_range ? (smu)->ppt_funcs->set_soft_freq_limited_range((smu), (clk_type), (min), (max)) : -EINVAL)
-
-#define smu_override_pcie_parameters(smu) \
-		((smu)->ppt_funcs->override_pcie_parameters ? (smu)->ppt_funcs->override_pcie_parameters((smu)) : 0)
-
-#define smu_update_pcie_parameters(smu, pcie_gen_cap, pcie_width_cap) \
-		((smu)->ppt_funcs->update_pcie_parameters ? (smu)->ppt_funcs->update_pcie_parameters((smu), (pcie_gen_cap), (pcie_width_cap)) : 0)
-
-#define smu_set_thermal_range(smu, range) \
-		((smu)->ppt_funcs->set_thermal_range ? (smu)->ppt_funcs->set_thermal_range((smu), (range)) : 0)
-
-#define smu_disable_umc_cdr_12gbps_workaround(smu) \
-	((smu)->ppt_funcs->disable_umc_cdr_12gbps_workaround ? (smu)->ppt_funcs->disable_umc_cdr_12gbps_workaround((smu)) : 0)
-
-#define smu_set_power_source(smu, power_src) \
-	((smu)->ppt_funcs->set_power_source ? (smu)->ppt_funcs->set_power_source((smu), (power_src)) : 0)
-
-#define smu_i2c_eeprom_init(smu, control) \
-		((smu)->ppt_funcs->i2c_eeprom_init ? (smu)->ppt_funcs->i2c_eeprom_init((smu), (control)) : 0)
-#define smu_i2c_eeprom_fini(smu, control) \
-		((smu)->ppt_funcs->i2c_eeprom_fini ? (smu)->ppt_funcs->i2c_eeprom_fini((smu), (control)) : 0)
-#define smu_get_unique_id(smu) \
-		((smu)->ppt_funcs->get_unique_id ? (smu)->ppt_funcs->get_unique_id((smu)) : 0)
-
-#define smu_log_thermal_throttling(smu) \
-		((smu)->ppt_funcs->log_thermal_throttling_event ? (smu)->ppt_funcs->log_thermal_throttling_event((smu)) : 0)
-
-#define smu_get_asic_power_limits(smu) \
-		((smu)->ppt_funcs->get_power_limit ? (smu)->ppt_funcs->get_power_limit((smu)) : 0)
+	smu_ppt_funcs(get_profiling_clk_mask, 0, smu, level, sclk_mask, mclk_mask, soc_mask)
 
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
