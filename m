Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB90C4708D
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 23:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60E0B60FF0
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 23:06:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E0B60FF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 146216F632;
	Fri, 28 May 2021 23:06:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8551A6E57A
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 23:06:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3NF3lMQ8OxzQfYSlJ18ozSCg2H6N3kY13mhmU8aoBsAQdtQgoAJfK7p3ERJex17YuCvQrtj2XTXk5gDfH40mGXSnUDx6hXjEthffZe5knQsDmEl1BwcOv3wo7rpXUswYBDhAKAmCEZ/GJbBbf7ZeOP5ncVh91nlwd6+ygbAEVaK+ca8cm8Q9AuZe9AWwKjdIFKe+MvCOn1bQ1vGdfw/ZJeIhmVnkUvl+eVRciGOU/Sj6nYWCRI7mJrKuxzuL4ZO8p0+ugcLYG6N8T+ywzeobb2NPqp92/NkTYH2yWvJSqESPZb8cBtU8/hu8ioQYpZHzVqn7a6X22paD6JTaJ7/Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mp78AgrLTEBpmJGfhMP7Rz9/mrQNiLLbvNNhuvc6bJ8=;
 b=maqKw7d+YdPmn6AeX5ObwBBa8EDbkUdhlNcEzt7WmTs22fmeZjbUUZ0rsxtk8+CEZsvowd7ZF4WyT2WD2WzCzlallVFH5NObZnHXPF81gGYUm4aWiXp3PtRpyHXtuWZ4F2ZH6gXJDsddDciyK9H2Tuj+VkbPS2LUBR45t2BlDwKZgeUCF9sp75NDgHeCKQIzDkzvY1GKuYnLG5geU8CA7TMIEZuoFxevPTwniU8oErXA3Usy13/z/p1FIdLOP3zrrQIHO9cOaUX8RsMkbhCGlx64zftJRpc7Sxr3+Qox5dCfP9BB9vBzYRYy+0iLmlW7t2bst7tFCTnd2dunWYyIAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mp78AgrLTEBpmJGfhMP7Rz9/mrQNiLLbvNNhuvc6bJ8=;
 b=HR7d125N/jPOZbgLXW+94Kkzt7mP/f657eAwy0/LE9jpJRF5VSO78UorZENTgwfcRtAFcDAE472jm0o8HprHwHLZr8gRJ5EkY4NLfechdk127kGz6u8SQoeEnwCUFulgtDnGz8KydItMvqQYrdEvFfKvyLUrCrSOl+b/JPvF/p4=
Received: from MWHPR04CA0053.namprd04.prod.outlook.com (2603:10b6:300:6c::15)
 by BN6PR12MB1539.namprd12.prod.outlook.com (2603:10b6:405:6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Fri, 28 May
 2021 23:06:39 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::73) by MWHPR04CA0053.outlook.office365.com
 (2603:10b6:300:6c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Fri, 28 May 2021 23:06:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 23:06:38 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 28 May 2021 18:06:36 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/6] amdgpu/pm: reorder definition of swsmu_pm_funcs for
 readability
Date: Fri, 28 May 2021 19:06:16 -0400
Message-ID: <20210528230621.16468-2-darren.powell@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528230621.16468-1-darren.powell@amd.com>
References: <20210528230621.16468-1-darren.powell@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 502628cc-3123-44b6-897f-08d9222d3fce
X-MS-TrafficTypeDiagnostic: BN6PR12MB1539:
X-Microsoft-Antispam-PRVS: <BN6PR12MB15391C3DD0602223121E133AF0229@BN6PR12MB1539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bJIg4UoWTkaT1KRQ/R3whVyRq69LCayccIfr1U8uzNLHcByIpL1TP5KXJGgnq26iMbNgMiKP/GRjkzqsX+LXWIGi5HlaD3DIxrnADzI0t3w9jZENcc7urgsDAbefZKoV77fjQ/EHPUMtcHZy8qfJtlfMQTkpC8H37p1PIN671Gmt8PyXi/ShUEyju9T5VciygWm01y3bUSDB15eBreRH1+yO6jRlLC9sk37FMRjhI9Csw/XRUfQuXl0csyHkRfFQV6WwmRN7nD/85mgLUq5QfPIaf8AszjVpN6pTXG/e8PnJoOQR/WpiEbkkMUZb9Y4hbd91EiZsEBfP1PszZaR+eZMiQUqa9V0i/s9hdtxSazH9DldwOlsZjUWkb+7J/mJxbbyWe4LXQHsEqiwZPWhUNzBGzVoWS0vNw1Pp8ROss7ogG7ihoQo4SyfA+k9aj5WH56+bgJkNVhjvF5abXyLlhHYsfqqfuG0a6ahFLh9FVsfe9oK6hcQHwj1iTBsQVqjLZ65fN/CIUWo1UDqsyA1K7x6pD2FvgtUJ7h/YHr0JPqQoBP2FMGSdL7CUleEFEwFxeIBom3CMRxzrYpF/sCREw3OLAysy/jzObQtGfzEODAFcSFNsMvj0Iq82si+Tgsdl0aSlyEFfK8Wcvkfhe6MraQC2se7lw8BJwPa/YbiLoGjQvk5c4hW9RRmONTWh8k4o
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(36840700001)(46966006)(426003)(8936002)(356005)(81166007)(8676002)(4326008)(6666004)(83380400001)(186003)(1076003)(36860700001)(316002)(478600001)(36756003)(70586007)(70206006)(86362001)(82740400003)(16526019)(82310400003)(5660300002)(2616005)(26005)(7696005)(6916009)(47076005)(44832011)(336012)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 23:06:38.7359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 502628cc-3123-44b6-897f-08d9222d3fce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1539
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
index 285849cef9f2..8aff67a667fa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2962,6 +2962,8 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.get_fan_control_mode    = smu_get_fan_control_mode,
 	.set_fan_speed_percent   = smu_set_fan_speed_percent,
 	.get_fan_speed_percent   = smu_get_fan_speed_percent,
+	.force_clock_level       = smu_force_ppclk_levels,
+	.print_clock_levels      = smu_print_ppclk_levels,
 	.force_performance_level = smu_force_performance_level,
 	.read_sensor             = smu_read_sensor,
 	.get_performance_level   = smu_get_performance_level,
@@ -2974,38 +2976,36 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
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
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
