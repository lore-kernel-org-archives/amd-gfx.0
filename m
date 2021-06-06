Return-Path: <SRS0=AYlF=LA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D842C47096
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Jun 2021 05:00:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2678561420
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Jun 2021 05:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2678561420
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 064006E520;
	Sun,  6 Jun 2021 05:00:49 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 631F66E514
 for <amd-gfx@lists.freedesktop.org>; Sun,  6 Jun 2021 05:00:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGOdTMVDoYBfFgUiRrJAarwvzwanCeeJZC2cz8RtdThq3/lrvEWQ+z5Py+Xp+px6f3BPnfzAqeFRWzGUPzzdWRlZ7eipu5IixQcD0guLFMp87/QOB9QKrlPbe7Ty1Kgh/lwK6GUa7poIjye5nEe1iMTFOF3+c8jeWyaOr2QQe+leE+oQRuaKQb5Z9gH6UwnsEGsQVKzpuHRQou5Mme+bd7L6d98AeTLYAZEoYx9wwDFIHHDaKvhWGyZvSLIIY4FQMZRfNCHswyfjordXTPAal97zrrBljONNmi7y26LBELJkzPYkUiPyosTIXrDGy8Wfp52P+7ipOv+qfcDN42IQ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1NocWZDz9i2hs3E3kak90RbWlXvdMJrfou54cgBt1A=;
 b=aCPZYCP7TtlWyJ6chwJkG5ijKHfja4UrPxMmy3iDNKoglezpZ6h00WGbOyHz360mNwQ+tDvgSXAya8zYrisBh9M/uZruni3ZeViI7z026UxwHUbtl3mHysCr5PNelJlCF0VlGGg3gtd2HsOs1ktyh1Nh/RfIfo+EjmFRAAkHBemf1anjm/F0sslLr0BFQOGUoWExMx73FdBS+t6XYBx6UATG1D7R+pkNMwQzpjVxMx0FAdVBy8gJJ8SAjZETJlyz3RAXLMbbJuyssEq+Z1Jb7eKdPzF//FjdykHMRQ+B1gm7LksLJPr5nFTOHxZDTS6gYl4AFJT15uhim1raVelN6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1NocWZDz9i2hs3E3kak90RbWlXvdMJrfou54cgBt1A=;
 b=T1vUTjP0zcVycDwXyqGOhz5CeiSFaht7UOlPAMEHxb6tO0anZ829dc4e6DyvX9VqNP2o14UQwQV4/dkny4wkTisXtphIk9ROgoGASPn+Wi/wZVe1SQkT5NzmX4IsFT/ZoyeZO7hZ5QoUk3NwvTUxy2fTDV5ae3ahUZ0fCGvtvSw=
Received: from CO2PR04CA0122.namprd04.prod.outlook.com (2603:10b6:104:7::24)
 by MN2PR12MB3471.namprd12.prod.outlook.com (2603:10b6:208:c8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Sun, 6 Jun
 2021 05:00:44 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::21) by CO2PR04CA0122.outlook.office365.com
 (2603:10b6:104:7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Sun, 6 Jun 2021 05:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Sun, 6 Jun 2021 05:00:43 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Sun, 6 Jun 2021 00:00:41 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/6] amdgpu/pm: reorder definition of swsmu_pm_funcs for
 readability
Date: Sun, 6 Jun 2021 01:00:18 -0400
Message-ID: <20210606050023.4124-2-darren.powell@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210606050023.4124-1-darren.powell@amd.com>
References: <20210606050023.4124-1-darren.powell@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4af8601e-dda9-40c6-2d3b-08d928a809b2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3471:
X-Microsoft-Antispam-PRVS: <MN2PR12MB34718F33801FAD2777902D10F0399@MN2PR12MB3471.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f91dgICZmaWU3X9etNj/ndm6oOBTfA3Z3/95QRhEbNiaNyC8YWWasbx+vBbziNJfQhQ5IhJV/gn1dMUX/ghY5bQ/4XSye3O419FVvAoCndcps1mq+txwji/A0YrJ3Jk6KFYiCUlY7yeZu4fmAjgUxiEHWhgFEiZlf2oOISV4pY5vSbuvFjwrL+IaHqZVICPWlj2g4nDSDcEkUwGtygO7HPV12qbSLyEjXr7VmklLqACyDSMas4Rd0rUo1izH1r9exZa1eWAqKySbTASv/bu7GHQH+iltOWtoutpRVaUkst1tX+4Za5hyHSS/2FO5NQ/Zf4PRUc5Wt8nYuogBw8F4qm2YCF3gF9cdPmjlocEOz9/EQdDDn1dr4c8tKpeTZTfDD3DpCcFZBPhGi9fXIo+vhlXAq8q9AworX9RlMQw1IDDhFyfdp2GOClyPeWAsbWAskRGV7YryqYRWfmVTCM9BVwQaIN0DFmuALW++EhXJUA4NnhxWqKxy69q6Igz6ozsLcIo49fsF2fRZUjZFmztBsqpl6BAXnxVGof99dJMtFU2umLhK85A9CpFkzop6skdv9dfFCKL1c5eLLU3nFQxLe7at3y+247XEIWprJF7limDwM5esqmreopRxz/8BMy5yFABP9E81unDBbsYQmmVc2VENEgsjpaI+Q143CW3QSLa1R4rlD0CfDG0wCFGGCloM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(36840700001)(46966006)(70206006)(316002)(16526019)(478600001)(47076005)(186003)(1076003)(8676002)(70586007)(7696005)(36860700001)(2906002)(336012)(5660300002)(6666004)(82740400003)(4326008)(82310400003)(81166007)(356005)(426003)(2616005)(26005)(44832011)(8936002)(36756003)(86362001)(83380400001)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2021 05:00:43.0365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af8601e-dda9-40c6-2d3b-08d928a809b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3471
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
Cc: Darren Powell <darren.powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Match the order of definition to the structure's declaration to
help with locating included and missing functions of the API

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 48 +++++++++++------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 6aab65c684ba..1b8321d12c8a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2969,6 +2969,8 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.get_fan_control_mode    = smu_get_fan_control_mode,
 	.set_fan_speed_percent   = smu_set_fan_speed_percent,
 	.get_fan_speed_percent   = smu_get_fan_speed_percent,
+	.force_clock_level       = smu_force_ppclk_levels,
+	.print_clock_levels      = smu_print_ppclk_levels,
 	.force_performance_level = smu_force_performance_level,
 	.read_sensor             = smu_read_sensor,
 	.get_performance_level   = smu_get_performance_level,
@@ -2981,38 +2983,36 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.switch_power_profile    = smu_switch_power_profile,
 	/* export to amdgpu */
 	.dispatch_tasks          = smu_handle_dpm_task,
+	.load_firmware           = smu_load_microcode,
 	.set_powergating_by_smu  = smu_dpm_set_power_gate,
 	.set_power_limit         = smu_set_power_limit,
+	.get_power_profile_mode  = smu_get_power_profile_mode,
+	.set_power_profile_mode  = smu_set_power_profile_mode,
 	.odn_edit_dpm_table      = smu_od_edit_dpm_table,
 	.set_mp1_state           = smu_set_mp1_state,
+	.gfx_state_change_set    = smu_gfx_state_change_set,
 	/* export to DC */
-	.get_sclk                = smu_get_sclk,
-	.get_mclk                = smu_get_mclk,
-	.enable_mgpu_fan_boost   = smu_enable_mgpu_fan_boost,
-	.get_asic_baco_capability = smu_get_baco_capability,
-	.set_asic_baco_state     = smu_baco_set_state,
-	.get_ppfeature_status    = smu_sys_get_pp_feature_mask,
-	.set_ppfeature_status    = smu_sys_set_pp_feature_mask,
-	.asic_reset_mode_2       = smu_mode2_reset,
-	.set_df_cstate           = smu_set_df_cstate,
-	.set_xgmi_pstate         = smu_set_xgmi_pstate,
-	.get_gpu_metrics         = smu_sys_get_gpu_metrics,
-	.set_power_profile_mode  = smu_set_power_profile_mode,
-	.get_power_profile_mode  = smu_get_power_profile_mode,
-	.force_clock_level       = smu_force_ppclk_levels,
-	.print_clock_levels      = smu_print_ppclk_levels,
-	.get_uclk_dpm_states     = smu_get_uclk_dpm_states,
-	.get_dpm_clock_table     = smu_get_dpm_clock_table,
-	.display_configuration_change        = smu_display_configuration_change,
-	.get_clock_by_type_with_latency      = smu_get_clock_by_type_with_latency,
-	.display_clock_voltage_request       = smu_display_clock_voltage_request,
-	.set_active_display_count            = smu_set_display_count,
-	.set_min_deep_sleep_dcefclk          = smu_set_deep_sleep_dcefclk,
+	.get_sclk                         = smu_get_sclk,
+	.get_mclk                         = smu_get_mclk,
+	.display_configuration_change     = smu_display_configuration_change,
+	.get_clock_by_type_with_latency   = smu_get_clock_by_type_with_latency,
+	.display_clock_voltage_request    = smu_display_clock_voltage_request,
+	.enable_mgpu_fan_boost            = smu_enable_mgpu_fan_boost,
+	.set_active_display_count         = smu_set_display_count,
+	.set_min_deep_sleep_dcefclk       = smu_set_deep_sleep_dcefclk,
+	.get_asic_baco_capability         = smu_get_baco_capability,
+	.set_asic_baco_state              = smu_baco_set_state,
+	.get_ppfeature_status             = smu_sys_get_pp_feature_mask,
+	.set_ppfeature_status             = smu_sys_set_pp_feature_mask,
+	.asic_reset_mode_2                = smu_mode2_reset,
+	.set_df_cstate                    = smu_set_df_cstate,
+	.set_xgmi_pstate                  = smu_set_xgmi_pstate,
+	.get_gpu_metrics                  = smu_sys_get_gpu_metrics,
 	.set_watermarks_for_clock_ranges     = smu_set_watermarks_for_clock_ranges,
 	.display_disable_memory_clock_switch = smu_display_disable_memory_clock_switch,
 	.get_max_sustainable_clocks_by_dc    = smu_get_max_sustainable_clocks_by_dc,
-	.load_firmware           = smu_load_microcode,
-	.gfx_state_change_set    = smu_gfx_state_change_set,
+	.get_uclk_dpm_states              = smu_get_uclk_dpm_states,
+	.get_dpm_clock_table              = smu_get_dpm_clock_table,
 	.get_smu_prv_buf_details = smu_get_prv_buffer_details,
 };
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
