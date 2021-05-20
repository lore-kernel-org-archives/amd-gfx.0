Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5C1C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 03:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A517B60FDC
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 03:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A517B60FDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21F5F6E96B;
	Thu, 20 May 2021 03:58:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C9A26E843
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 03:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/ArAsLhQnmQRExljqNMBcrbjyady3xm5BaIQp0IBx+K3nmrhcfhTm3TYA61sQc5ek9iyJ8+PZ21CHaFLhcrsIcy/3eaYmrlt/C8VTkl5g9bqcNbgyGPU6JTUJ0MtyfpVTpCTiHjNj+EG348WQxaUzKadLOzQinNtOg7GSm9DHgD/besQneT93XIh7glLLlB48yuSMYzyiXox+GE0ityWkur0egu0EqhnBxEienyZizd5BRi644VBmL4E9lZ3urH5nrlZMGDw6t44zK5tm8xauBLq2aeLzAY96aW/2eBe5gWncYenpIGYclWStIJ9s4oxgTzhhDM5MrwdvWIXanR4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mp78AgrLTEBpmJGfhMP7Rz9/mrQNiLLbvNNhuvc6bJ8=;
 b=N88n8NZLlAHI6KQcuC4wEeDbyzzo8BBUIqzg7Ypd8Z/bu19zYgAe2xcE6rtPtszmAHCD1j0k6YQw6lk35cRnAnNLYAOH4B/MKBkBmm1MbZ1b/U+QKCVb7t6R4Xai+KdJnKVNKgYU5BZTLPT7ckilqUdI9TzM0VVcpzONGaDU0AOz68ROtOzllHlW0WPaAU5986ZiZRN/xCqeQBYgpKHou0Q6a9bfsZdZVqz1tN1lV2qFUL3ehTdetZKieKUtyJuOuaOdHbEb9+s2peBfrqqiBaSWs1ZoqQVDQ2f/7SKIzHVv0a9w5EHJJWKjgvIn6/GmkogUPY0Y20f/nMtKPuenWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mp78AgrLTEBpmJGfhMP7Rz9/mrQNiLLbvNNhuvc6bJ8=;
 b=asdK0E7grifVJFt9H4gsWQchy1nrFtDm78euSl9W0wiOHdemaJYFANBtax6oDsvB10ymjlqdx4rZNhETfem7Gy7GX6xi+hidsm1lK6YxBXKfA1Z/XJLWtWMBfT9tOCRfHjkuHDJv296E0I262IGU0h/UBQOCUu8qKjUPJer+qao=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM5PR12MB1612.namprd12.prod.outlook.com (2603:10b6:4:a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25; Thu, 20 May 2021 03:57:55 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::4c0:7a8d:d41:dba0]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::4c0:7a8d:d41:dba0%4]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 03:57:55 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/5] amdgpu/pm: reorder definition of swsmu_pm_funcs for
 readability
Date: Wed, 19 May 2021 23:57:18 -0400
Message-Id: <20210520035722.4877-2-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210520035722.4877-1-darren.powell@amd.com>
References: <20210520035722.4877-1-darren.powell@amd.com>
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: YTOPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::20) To DM6PR12MB2954.namprd12.prod.outlook.com
 (2603:10b6:5:188::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dapowell-ubuntu-200400-1.amd.com (165.204.54.211) by
 YTOPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.31 via Frontend
 Transport; Thu, 20 May 2021 03:57:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b8ca797-82d6-4ee3-ba8f-08d91b43721d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1612:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1612938A001FC204573DE2E4F02A9@DM5PR12MB1612.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eia8r+U5hMuS+8ZXPoZ2kMLoOwklSyf13PLIp3cO8qAftPuSdxtZbPN2c97sRJacv4URZNTnzdWeAFIUY0jBBE1NYYqNXBkAeWgaY+trTI9jCySiief2FPjrlLl+jdCjYrfGFipcvEttcO7r1S2chC+hUNKo+tOYN9yO3dnP+Vqcj7sy8fJIReB1OAHIe+kkBur1BZ5nzbEqdGZBYn3AED2MS3zbwEh4LSkxRJkvp/NnONYmZ0KNWTbN0KZPtTeDtTx4VsrQDt4rqxU1LA0y8xjQPG1sORsdVKXes+YQOFFgqr3Q5fvkhjP1UWpSrqcPKn0aCI9Y9PnZ1OjKCji/BQkU5st7HDkT2IuGTTTFB8fUxeHLlfkwPEFfRoEP33slz65t6U0dBg722lVsN/usTQfnSxKDFifykwZ6lhqJRpT6mjNDHSsQPWxKQqwk69aDr/8OjouAHsPixWlxYwTjVI7yU8Hzh96Opb4j0aT7e/ZmbKXxm0GOk/AO0FOiYC+oZpXgLTNgPgA0L691WYHO5ZWLEi9DA+ETx3ikPJJ7xukhtAJTENZOLAEltnVwtFWB+KM5uT4qzu+S/6DScWO8u3UeZEvTKFxbSY/e78pMkwUi+PntnISSJ/HCIOpJb9noG0Vaz+7Ujf+sZo+mCZP2DA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(66476007)(66556008)(2616005)(66946007)(16526019)(86362001)(186003)(4326008)(316002)(478600001)(956004)(52116002)(6916009)(7696005)(6666004)(26005)(2906002)(6486002)(44832011)(8676002)(36756003)(5660300002)(8936002)(38100700002)(38350700002)(83380400001)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?avy/QPwlvauHTrcODBZGsYZIzxstwzbjbM6/sfaNDL+SnDqRM6uquReKLQzD?=
 =?us-ascii?Q?GEUvz92gpttV63mojliqodb1NhgkqVQY+zoJnNQk+yq9YJgqHit9j8YAzhah?=
 =?us-ascii?Q?Pihw9BvR6ikSAfnMkGKD99demsbr3YRzqHq0y9kmDKyPRZibhJzHjCzmp/V+?=
 =?us-ascii?Q?isZJc650DZNAuUHK8YdQK8SLNQPWf88Q2YX1Sr34BFdAEu5h3+ivvD58xj3f?=
 =?us-ascii?Q?UkHYkxq+TGOw3+RGslsNqtwFMUv6ykGKfHlwMOq79ho9jPsO29tK+HHSoQET?=
 =?us-ascii?Q?o3iABLneZx6JgNOL9UBQ02A8AU/r5+Mk8AbXvCGUUPjZJjhNmEozI78aH0IV?=
 =?us-ascii?Q?IlS8zem7q9YxDLDrk7OOVqpaxT+cfRqJuVMAtK11anTyzsSyw/j+ud+O+SXd?=
 =?us-ascii?Q?k93LnVL0QwkANGKHIb5vMYahLYqyEKAZ8Hxtt8RiDpZAJnsKpRRgqbxMevro?=
 =?us-ascii?Q?zXcEGtel+9yR+/+OL7vxzjR902fM38IILvZ1t7kDBzcF9sZ2Q1YL2PM64XXi?=
 =?us-ascii?Q?/PgKpkKdd6rWFUho50w2bLid+MXlkxJbbfh9jawmsGDioWUB5OnKkmGW5eis?=
 =?us-ascii?Q?UFX33ulHkNp9CwnaIWvSPJ0hCuHtKiZxl9gDXOhafH5N5+DHt9tGw4hZH3d1?=
 =?us-ascii?Q?OQpDqk7FvT9/woHt0meN5k9eTTguySZYy3Zxaj4Q6vA3X740z1e7suGQ4sxn?=
 =?us-ascii?Q?8aBh8ykhVZ7dhdoSRbOZC9mHVhrrmGPjnTV/tfDDhT0uXfczBjlTzRdfo7Gw?=
 =?us-ascii?Q?gf4ir5vdyZ4m4Cat47fppD9A2blsAcwwjWtIE59boxz5bdFZsqBZSAkynVZ2?=
 =?us-ascii?Q?vDir1I7jUPXAxUdLFNYYm21XZ4G5HaFGNljaQ7ZgrMBi8v3ZKBRw+vVtmAkl?=
 =?us-ascii?Q?VFCEfaF4POG5BVq1TFJ+7pzqI9XFPonbImpkmcKJtYVwGsngBjJpReqXNIsa?=
 =?us-ascii?Q?9U/YczZoZ+/2FwM4Wzztdr5/8cdpJOer0Zgt5v8cxM3RS/oi2/6uOVpUCv13?=
 =?us-ascii?Q?/w4D1qApQndLPbOsVytQAW/pMueejhSdAdvswtlletyjCjQgwmVf+tyWYkb7?=
 =?us-ascii?Q?ShMem7Uc2I/hNnpGi3v2Bvgmr/xiiH6pCt5x/Tehh8j+Z3q6BVY0uPmEdFpz?=
 =?us-ascii?Q?6L+KV4O/8EjrTOP6xxJYzOZF8X1FKU2u5XCjK9xVJrZjC00hYkXODfbp0jgR?=
 =?us-ascii?Q?aMWY6d9I3VgAwiNxXsnLHyGcmE2wOM47E675cK5p+2Oztgb/gfUhpbrkdbnu?=
 =?us-ascii?Q?3FYBVCAyxS+l6qkUalR+q49JKeFhP8khcQN+ZLF430iPvMOBhKCdUWhDnuBF?=
 =?us-ascii?Q?7vUzJ+Z8+h1d/u0hquMFCz/5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8ca797-82d6-4ee3-ba8f-08d91b43721d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 03:57:54.3653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFqNSiHyxTgOcW2GwW166WkXKiXuzTWLMgI+wkwyFBiHrx/LjzxW5udKu5P+1tScCBPFQFlFdL5BUGqssItjbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1612
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
