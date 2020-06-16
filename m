Return-Path: <SRS0=tiv0=75=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484D0C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 07:06:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19AEB208B3
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 07:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xpuwjbRr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19AEB208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C0786E7D7;
	Tue, 16 Jun 2020 07:06:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 480C06E7D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2020 07:06:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5SbilMcce52A5EasrGwVV2kqu73AGS55GQLSvcj34Bse8QsEPXvQzUkVa1ZQwaujcwl9vFV6pFbVx5Iss3n/ZFjX70vJ0FuwPtawxZBOgz+RdadS9DeP49VY/oMHc5DN+rgraCksTG/h2L9kUdL4MJPGFR1l9T2O4GSfz+bFTBL7xYRZ4zC1cOEVDu5xTiGrdBMTWEjpnDFJUZV8oZobqKvKqaLykDzr4wT4SO4QrhVAWQ3OxsHxGM3baM5qmSyWh2NPuGnLuhGGz05pSU164T5R5U9+TvOPJWMWEqQXd8J9HMScQmm/41c+Nasgx0HBVY6II20mGr96XBGwlJ0pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doJpTCtVk7fEatoWv04FKHYm9MYbdORMl94NsmLperw=;
 b=iOfVkqpNF22/fd2Djs4BaUlSpfgxiowH06R1XSFSjZ1wZ6GW8L3LPt5q5Lb7jpr/A/5B65oMvrypGoQNBbBhC1k+Ylehuo8cshEaqIyT6kuOy4iXpn5/Z8Vzha2mJZ/aYeeCpt5UFKWHyqEE2YgoXqNDbydM5/NrR9s142251z2A3UBkq+0Ny+C51DSXGcphpgF+QZUtFl2SlxNOui1c//N2nOyUnRlNnCx2O0cDQjo5+dMBnsJhKt1sgYZ8LQuPdCwHJE3zOB3fppmCrak3IkL8WY32r0QZRFqg2KGBMF1sjfjM0khfojbiY6FM0GqyqYTiWXlhGVbr+ZWzr//WAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doJpTCtVk7fEatoWv04FKHYm9MYbdORMl94NsmLperw=;
 b=xpuwjbRrPa+NumYSdHIWKqY2YwKPtqvGkHIM+NIrEnGEVPHG8h4L9py+x9STsY4L0pxgU4445kTxLxelfCVvmiN9mcQi9ETs7ZVBW99sDrHDxHD5xjLX0foie9h6naTdfRKTJq9NpnnwFIn27CV5UqIkwMI7OULf9ldwxlHPQZI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3485.namprd12.prod.outlook.com (2603:10b6:208:c9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Tue, 16 Jun
 2020 07:06:19 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::493c:9d42:501b:59d6]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::493c:9d42:501b:59d6%3]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 07:06:19 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/smu: unify smu ppt callback marcos
Date: Tue, 16 Jun 2020 15:05:46 +0800
Message-Id: <20200616070546.4190-2-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616070546.4190-1-kevin1.wang@amd.com>
References: <20200616070546.4190-1-kevin1.wang@amd.com>
X-ClientProxiedBy: HK2PR02CA0207.apcprd02.prod.outlook.com
 (2603:1096:201:20::19) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-u1804-kvm.amd.com (58.247.170.245) by
 HK2PR02CA0207.apcprd02.prod.outlook.com (2603:1096:201:20::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Tue, 16 Jun 2020 07:06:17 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 65d5d5b3-628b-4eec-8dad-08d811c3c4af
X-MS-TrafficTypeDiagnostic: MN2PR12MB3485:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB34856E10C3F76AF022226509A29D0@MN2PR12MB3485.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6sepe5J1sN4/8bN6HyAn+wNzPXGUtZPJqKNzpNm6k7+bfz4a77HaMj8nlkA9+SQDk23OsiFRm2cfmwVymIs3zhkz2nmLOeF2iuWyxtOnj8Jkd3HMZjvlSiTXTbrX9Fx0VnDAN+jpFY5yiSWRU6zH+gAWBChZAKIHuDemt470IleF0vmOxsL6ex/pI/bdU6zd1Lp1jCeog39qtKNCNJ0Ze0mqIWW7Xmy1FtgEsBPo1AOBuzMfEaVJFnVLlJ0GTxO49n96LknfG48/NZIngmrl+vs9EXr4FzpRoPSrXpSqjZAlenz56r0x49yDrt4H66L3PCY+szYVhsAfqsSlA7ywc7A+LBxFdkrtm3FjnRf1X4hqU/TFRqt6kAYgKscOK0xk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(36756003)(66946007)(2616005)(956004)(6666004)(66556008)(66476007)(1076003)(8676002)(6916009)(26005)(86362001)(478600001)(186003)(7696005)(52116002)(5660300002)(16526019)(8936002)(6486002)(30864003)(4326008)(316002)(2906002)(83380400001)(66574015)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: DDAKjeKmlatv0Kd4fnGGksPtoM/QYkJYtHiYmAZNDYaFdkslINk+8Y572ztIv58K8+GwLuoA8H0bU8Lj5A/wVXfDn3Jk4e/HHoHj58U5X1maA6L3scZOISrQhB4oxrjANrVuHbk13tBAzNPi5TG5PwVepM6U5bgaUlscOv1cDkSdjboPLXs66CjJ23uHnEBk766nON6aPL4THEWrCQMILCgkz6oGOwf1DJ6KjadLqOdEifCY6B59q23cAOLZO8ZFqm5L+0yPahahommQcgVs/pqrpo+jdT3rAS6mUMeQZTJ0S9yqRK7G8NPk5QQdM9QE5mhjMYwmweFyEOkNED2i6Jqis7lWY2xBnwgUBS9sd3UgIptmuoApTI7It2wpxJxW4ieMLmE6OwXR7LrQLerN9tmhafUY5MfqcDWDqc7zpStW7mpu2s/jwqF2yIaWFA0nxClbd51ynRPoIkblW0mhq4oUVRIalVgz5xQqQh8FgsV928W46sigCMoAMBns9khr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d5d5b3-628b-4eec-8dad-08d811c3c4af
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 07:06:19.1718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2SujE8MOiljWNHUQmRxEgIGMb++C028MIHRxDmOJjrOsgwppLSvRK/NsVLNYZcF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3485
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

add the new macro "smu_ppt_xxx()" to unify smu callback interfaces

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_internal.h | 266 ++++++-------------
 1 file changed, 82 insertions(+), 184 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 880ef54884f8..0f9841bcdcb8 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -25,191 +25,89 @@
 
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
+#define smu_ppt_xxx(intf, ret, smu, args...) \
+	((smu)->ppt_funcs ? ((smu)->ppt_funcs->intf ? (smu)->ppt_funcs->intf(smu, ##args) : ret) : -EINVAL)
+
+#define smu_init_microcode(smu)						smu_ppt_xxx(init_microcode, 0, smu)
+#define smu_fini_microcode(smu)						smu_ppt_xxx(fini_microcode, 0, smu)
+#define smu_init_smc_tables(smu)					smu_ppt_xxx(init_smc_tables, 0, smu)
+#define smu_fini_smc_tables(smu)					smu_ppt_xxx(fini_smc_tables, 0, smu)
+#define smu_init_power(smu)						smu_ppt_xxx(init_power,	0, smu)
+#define smu_fini_power(smu)						smu_ppt_xxx(fini_power, 0, smu)
+#define smu_setup_pptable(smu)						smu_ppt_xxx(setup_pptable, 0, smu)
+#define smu_powergate_sdma(smu, gate)					smu_ppt_xxx(powergate_sdma, 0, smu, gate)
+#define smu_get_vbios_bootup_values(smu)				smu_ppt_xxx(get_vbios_bootup_values, 0, smu)
+#define smu_check_fw_version(smu)					smu_ppt_xxx(check_fw_version, 0, smu)
+#define smu_write_pptable(smu)						smu_ppt_xxx(write_pptable, 0, smu)
+#define smu_set_min_dcef_deep_sleep(smu, clk)				smu_ppt_xxx(set_min_dcef_deep_sleep, 0, smu, clk)
+#define smu_set_driver_table_location(smu)				smu_ppt_xxx(set_driver_table_location, 0, smu)
+#define smu_set_tool_table_location(smu)				smu_ppt_xxx(set_tool_table_location, 0, smu)
+#define smu_notify_memory_pool_location(smu)				smu_ppt_xxx(notify_memory_pool_location, 0, smu)
+#define smu_gfx_off_control(smu, enable)				smu_ppt_xxx(gfx_off_control, 0, smu, enable)
+#define smu_set_last_dcef_min_deep_sleep_clk(smu)			smu_ppt_xxx(set_last_dcef_min_deep_sleep_clk, 0, smu)
+#define smu_system_features_control(smu, en)				smu_ppt_xxx(system_features_control, 0, smu, en)
+#define smu_init_max_sustainable_clocks(smu)				smu_ppt_xxx(init_max_sustainable_clocks, 0, smu)
+#define smu_set_default_od_settings(smu)				smu_ppt_xxx(set_default_od_settings, 0, smu)
+#define smu_send_smc_msg_with_param(smu, msg, param, read_arg)		smu_ppt_xxx(send_smc_msg_with_param, 0, smu, msg, param, read_arg)
+#define smu_send_smc_msg(smu, msg, read_arg)				smu_ppt_xxx(send_smc_msg_with_param, 0, smu, msg, 0, read_arg)
+#define smu_alloc_dpm_context(smu)					smu_ppt_xxx(alloc_dpm_context, 0, smu)
+#define smu_init_display_count(smu, count)				smu_ppt_xxx(init_display_count, 0, smu, count)
+#define smu_feature_set_allowed_mask(smu)				smu_ppt_xxx(set_allowed_mask, 0, smu)
+#define smu_feature_get_enabled_mask(smu, mask, num)			smu_ppt_xxx(get_enabled_mask, 0, smu, mask, num)
+#define smu_is_dpm_running(smu)						smu_ppt_xxx(is_dpm_running, 0 , smu)
+#define smu_notify_display_change(smu)					smu_ppt_xxx(notify_display_change, 0, smu)
+#define smu_set_default_dpm_table(smu)					smu_ppt_xxx(set_default_dpm_table, 0, smu)
+#define smu_populate_umd_state_clk(smu)					smu_ppt_xxx(populate_umd_state_clk, 0, smu)
+#define smu_set_default_od8_settings(smu)				smu_ppt_xxx(set_default_od8_settings, 0, smu)
+#define smu_get_current_clk_freq(smu, clk_id, value)			smu_ppt_xxx(get_current_clk_freq, 0, smu, clk_id, value)
+#define smu_tables_init(smu, tab)					smu_ppt_xxx(tables_init, 0, smu, tab)
+#define smu_set_thermal_fan_table(smu)					smu_ppt_xxx(set_thermal_fan_table, 0, smu)
+#define smu_enable_thermal_alert(smu)					smu_ppt_xxx(enable_thermal_alert, 0, smu)
+#define smu_disable_thermal_alert(smu)					smu_ppt_xxx(disable_thermal_alert, 0, smu)
+#define smu_smc_read_sensor(smu, sensor, data, size)			smu_ppt_xxx(read_sensor, -EINVAL, smu, sensor, data, size)
+#define smu_pre_display_config_changed(smu)				smu_ppt_xxx(pre_display_config_changed, 0, smu)
+#define smu_display_config_changed(smu)					smu_ppt_xxx(display_config_changed, 0 , smu)
+#define smu_apply_clocks_adjust_rules(smu)				smu_ppt_xxx(apply_clocks_adjust_rules, 0, smu)
+#define smu_notify_smc_display_config(smu)				smu_ppt_xxx(notify_smc_display_config, 0, smu)
+#define smu_force_dpm_limit_value(smu, highest)				smu_ppt_xxx(force_dpm_limit_value, 0, smu, highest)
+#define smu_unforce_dpm_levels(smu)					smu_ppt_xxx(unforce_dpm_levels, 0, smu)
+#define smu_set_cpu_power_state(smu)					smu_ppt_xxx(set_cpu_power_state, 0, smu)
+#define smu_msg_get_index(smu, msg)					smu_ppt_xxx(get_smu_msg_index, -EINVAL, smu, msg)
+#define smu_clk_get_index(smu, clk)					smu_ppt_xxx(get_smu_clk_index, -EINVAL, smu, clk)
+#define smu_feature_get_index(smu, fea)					smu_ppt_xxx(get_smu_feature_index, -EINVAL, smu, fea)
+#define smu_table_get_index(smu, tab)					smu_ppt_xxx(get_smu_table_index, -EINVAL, smu, tab)
+#define smu_power_get_index(smu, src)					smu_ppt_xxx(get_smu_power_index, -EINVAL, smu, src)
+#define smu_workload_get_type(smu, type)				smu_ppt_xxx(get_smu_power_index, -EINVAL, smu, type)
+#define smu_run_btc(smu)						smu_ppt_xxx(run_btc, 0, smu)
+#define smu_get_allowed_feature_mask(smu, feature_mask, num)		smu_ppt_xxx(get_allowed_feature_mask, 0, smu, feature_mask, num)
+#define smu_store_cc6_data(smu, st, cc6_dis, pst_dis, pst_sw_dis)	smu_ppt_xxx(store_cc6_data, 0, smu, st, cc6_dis, pst_dis, pst_sw_dis)
+#define smu_get_dal_power_level(smu, clocks)				smu_ppt_xxx(get_dal_power_level, 0, smu, clocks)
+#define smu_get_perf_level(smu, designation, level)			smu_ppt_xxx(get_perf_level, 0, smu, designation, level)
+#define smu_get_current_shallow_sleep_clocks(smu, clocks)		smu_ppt_xxx(get_current_shallow_sleep_clocks, 0, smu, clocks)
+#define smu_dpm_set_vcn_enable(smu, enable)				smu_ppt_xxx(dpm_set_vcn_enable, 0, smu, enable)
+#define smu_dpm_set_jpeg_enable(smu, enable)				smu_ppt_xxx(dpm_set_jpeg_enable, 0, smu, enable)
+#define smu_set_watermarks_table(smu, tab, clock_ranges)		smu_ppt_xxx(set_watermarks_table, 0, smu, tab, clock_ranges)
+#define smu_get_current_clk_freq_by_table(smu, clk_type, value)		smu_ppt_xxx(get_current_clk_freq_by_table, 0, smu, clk_type, value)
+#define smu_thermal_temperature_range_update(smu, range, rw)		smu_ppt_xxx(thermal_temperature_range_update, 0, smu, range, rw)
+#define smu_get_thermal_temperature_range(smu, range)			smu_ppt_xxx(get_thermal_temperature_range, 0, smu, range)
+#define smu_register_irq_handler(smu)					smu_ppt_xxx(register_irq_handler, 0, smu)
+#define smu_get_dpm_ultimate_freq(smu, param, min, max)			smu_ppt_xxx(get_dpm_ultimate_freq, 0, smu, param, min, max)
+#define smu_asic_set_performance_level(smu, level)			smu_ppt_xxx(set_performance_level, -EINVAL, smu, level)
+#define smu_dump_pptable(smu)						smu_ppt_xxx(dump_pptable, 0, smu)
+#define smu_get_dpm_clk_limited(smu, clk_type, dpm_level, freq)		smu_ppt_xxx(get_dpm_clk_limited, -EINVAL, smu, clk_type, dpm_level, freq)
+#define smu_set_soft_freq_limited_range(smu, clk_type, min, max)	smu_ppt_xxx(set_soft_freq_limited_range, -EINVAL, smu, clk_type, min, max)
+#define smu_override_pcie_parameters(smu)				smu_ppt_xxx(override_pcie_parameters, 0, smu)
+#define smu_update_pcie_parameters(smu, pcie_gen_cap, pcie_width_cap)	smu_ppt_xxx(update_pcie_parameters, 0, smu, pcie_gen_cap, pcie_width_cap)
+#define smu_set_thermal_range(smu, range)				smu_ppt_xxx(set_thermal_range, 0, smu, range)
+#define smu_disable_umc_cdr_12gbps_workaround(smu)			smu_ppt_xxx(disable_umc_cdr_12gbps_workaround, 0, smu)
+#define smu_set_power_source(smu, power_src)				smu_ppt_xxx(set_power_source, 0, smu, power_src)
+#define smu_i2c_eeprom_init(smu, control)				smu_ppt_xxx(i2c_eeprom_init, 0, smu, control)
+#define smu_i2c_eeprom_fini(smu, control)				smu_ppt_xxx(i2c_eeprom_fini, 0, smu, control)
+#define smu_get_unique_id(smu)						smu_ppt_xxx(get_unique_id, 0, smu)
+#define smu_log_thermal_throttling(smu)					smu_ppt_xxx(log_thermal_throttling_event, 0, smu)
+#define smu_get_asic_power_limits(smu)					smu_ppt_xxx(get_power_limit, 0, smu)
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
+	smu_ppt_xxx(get_profiling_clk_mask, 0, smu, level, sclk_mask, mclk_mask, soc_mask)
 
-#define smu_get_asic_power_limits(smu) \
-		((smu)->ppt_funcs->get_power_limit ? (smu)->ppt_funcs->get_power_limit((smu)) : 0)
 
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
