Return-Path: <SRS0=AWwP=FV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1ACC4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 19:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3231A239EB
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 19:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3231A239EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7C0C893E8;
	Thu, 17 Dec 2020 19:10:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C19C5893E8
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Dec 2020 19:10:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAoOQrsvKUIMscWiHUaRPsgbQZgeGYUg8M2mUK9gGyZzaQlHk0yDTQWcaWa0+Mn97uDHpfAVQjrGf6XZnaybd+1h5c/vYGBs0jG+UAqz/vnIgcJzM3agawICra6SDqzO+tBDRs+8PNS45BID34LuMzAI1vckMmQCXBEEIhOzyPmx4PGJhJCeOxkxgPAnkk/qX4S3kK/9YXH66Q0Sk0JPrrutfo6ncXSeREGMPzDp7XEMq5f3kfBAhKkqLH07ZgxWEhA5ZQe8hhZG5kN3OpCEAUNmgsCLqJBcZ0pg7tjLKRcFZ0sUYvRNqpXjiYiA/TiIM6XKiF0cbecrD5uk+S63Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93r0yJn+3FUUslkfjWfyPHTkKXMkhDQ7EgnkC4AOFIk=;
 b=JJ6FW6+JIFREk6vsluFvuof4doB6WIw59AF1NZSv4C5J1UWP275j6DFUYeszhMTLc9oCAYxQ8YMWLaLqhV/8wI2GV2EjOcCWLwH+oGzN6G87wxw4PvwtjmE0/yYRTMwGui61qCrBVBLAZtX9NGjXO8cymzQFvjkcXNDWuSxPPq/PDJPEQIRQ6Jmu58pmEt91oN9yVR9liJZ1SWEk0pvfqF6VtPno11RVhklu+OT9teT4qTmLC9sjfTI79M9mzjoZs2RHCVkWsTRUiCJIjpVhs9mqLacaARYldd9RtSouHaX2eZra4unzz1YwwbabKjM+OlMPcnecmb5PiNwm7YauXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93r0yJn+3FUUslkfjWfyPHTkKXMkhDQ7EgnkC4AOFIk=;
 b=q30BCI7bDXIv10aUK9WXK+UbbsKhKDCTmyme7AoQHNDfIV2bcGz141yLEB0SyCbCPnB5ojw8SIUtMacg4nQBvEHOna9b17l2ZhjntuUoi0BGksXn0e3/EnXXjF7N4Vd3WkCuiTZ8O9D2UudtsVDvWKQ8mvLoc26qaxD4Ftr2c3A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3221.namprd12.prod.outlook.com (2603:10b6:a03:135::29)
 by BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Thu, 17 Dec
 2020 19:10:21 +0000
Received: from BYAPR12MB3221.namprd12.prod.outlook.com
 ([fe80::f0b3:5ddc:5ec1:1728]) by BYAPR12MB3221.namprd12.prod.outlook.com
 ([fe80::f0b3:5ddc:5ec1:1728%4]) with mapi id 15.20.3654.027; Thu, 17 Dec 2020
 19:10:20 +0000
From: Ryan Taylor <Ryan.Taylor@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: add pptable_funcs documentation (v2)
Date: Thu, 17 Dec 2020 11:09:10 -0800
Message-Id: <20201217190910.193725-1-Ryan.Taylor@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [2600:1700:9260:7260::18]
X-ClientProxiedBy: BN6PR08CA0084.namprd08.prod.outlook.com
 (2603:10b6:404:b6::22) To BYAPR12MB3221.namprd12.prod.outlook.com
 (2603:10b6:a03:135::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from devbox.attlocal.net (2600:1700:9260:7260::18) by
 BN6PR08CA0084.namprd08.prod.outlook.com (2603:10b6:404:b6::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Thu, 17 Dec 2020 19:10:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ed2af6e9-359c-41a4-88ef-08d8a2bf6630
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB28691C7DAFB000B458547CFCEAC40@BYAPR12MB2869.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zGdUlT68Tj3ykfcRa5Ld0CCQbdgfhcMDwAzOkAiIRFifTgkWNwb2GRhrTGofAJadz/BWzIZRjME0O4MNzK6Izg5jG+8oWb7XT7MHsJKYoclu3JY+JweSMszAUZsxppy4fPNurOHxm3ZsR2WrzjTpP09rbNCkMhiGOgbo4+jkvGnTDKe9Qj0Pchx5arpldBet2vxQA4Q9COfekLBac3OimxDycQTugs/q0L90KbJesfqIPvZUys2sC6zw9BBzpZmYY/TI+ybapCksU2p9o2jdv1gVhF+aDNrT4QZvUprrBqw9qdHByelxTdDHVvbPF8mBY12lK0evtLw2Gw6GzY/dfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3221.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(6486002)(6916009)(6506007)(4326008)(86362001)(6666004)(66574015)(66556008)(66476007)(66946007)(52116002)(316002)(6512007)(1076003)(8676002)(83380400001)(30864003)(5660300002)(2616005)(8936002)(2906002)(186003)(16526019)(36756003)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NgUBQzsv9ICkBSFQSDTJtT3TA+qcu5OigyHqHz46Jc96zgKdMmCgdmgtAqz7?=
 =?us-ascii?Q?PNiXFAypCWBX79QrKg+zxOMp7ookj44kFZ+DTtHxdjU6nVMk+SesIULXwmQs?=
 =?us-ascii?Q?2DNCx+qQMgQ9oHxLGVZyuSXiVs4uVDzO8a4s/PzLJfhk0JLon6Ai/GRqatZ+?=
 =?us-ascii?Q?ehmW7nnysGX2RqMr2kEbwEq2loD2dc3T2CjkTMNcI42R9wAq40nZdjzVh/0I?=
 =?us-ascii?Q?sOwFFTwUpAC5xOMorHcEqgpXLuztzA6HmqjFavx4LoPKsEi/jbVk3XrOmC/L?=
 =?us-ascii?Q?W80QEnAy3cKwphVnfBOEBKhqnPTwFBaqfinOg4oOU+6uWlzblAdu0z5GVfIW?=
 =?us-ascii?Q?CNpocU5cjXlS6rdtLMdKOCvdh/dlTQvk62DsZETnMZ8CurwXFted9QZ4W9X/?=
 =?us-ascii?Q?nSXDO6MFWMbJtVaBZelxWxEZZXzrW6ciNN761sDb8aN19GTOPjQJt6nR2GBx?=
 =?us-ascii?Q?Kf7aVYBsbe7B9WshQQqGdoVacyoEZNnSGWDKT3Hi3UtR4J3H0g4ZGENfKRD4?=
 =?us-ascii?Q?/+Vnn4DfO35nnUqMuqWvCArDICikfzer0HtPycp9/iw8/HRF77w9lN89qkqr?=
 =?us-ascii?Q?5XkULVXfIcjK5NBiahbp34qWkU6YXiLPbSSxNFnSXUqR46cWO3vTniYB/qVa?=
 =?us-ascii?Q?MyBPF5RFMkHlPgUpu415NCZrBZrbqQfDjZQ60//A+KZFPC5L98gMJdkFdrZZ?=
 =?us-ascii?Q?4OiPVrs2Iiei+F0ElIpgLK1cLiZhj6s4HzAJ6oCV7jpFm+6rX1rjUIgZhloN?=
 =?us-ascii?Q?ePNec6DieHkTjIT/h7iYDIXy4UE4ZNKXPcK4d4XyzRxhm5BExCZqgAiOsIsL?=
 =?us-ascii?Q?5bM5H0YY2EUW3M4dbVKa7m7MT+9V4wWQNnjB3KH5uSMdoe4adpv85bEMlIme?=
 =?us-ascii?Q?IBovLxYHDROJUHWi8StzNq4myNgtAXMvljMEl3gcx+OIkNIjQ55ZPP4GDKMw?=
 =?us-ascii?Q?+stJzg1kr8VKlkP5HTZtsEoLi5Gu4u6+3lJ8ueiN77wl6K8mmLRFKmMEtS2q?=
 =?us-ascii?Q?T9TrhxwO66ixDd2j9gkkJs5+6w=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3221.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2020 19:10:20.8595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2af6e9-359c-41a4-88ef-08d8a2bf6630
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IR6c/F9XaHq+PVe4DB7hzcI6zNWuB/Ua1U8f7QOCjwqtGXUawnwz0KC+ggbyh9/+KhfiwFKD2EfByod/QIykWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2869
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
Cc: Ryan Taylor <Ryan.Taylor@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Documents the hooks in struct pptable_funcs.

v2: Improved documentation accuracy.
Signed-off-by: Ryan Taylor <Ryan.Taylor@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h | 525 ++++++++++++++++++++++++
 1 file changed, 525 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 4bdbcce7092d..b6578550da46 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -469,120 +469,645 @@ struct smu_context
 
 struct i2c_adapter;
 
+/**
+ * struct pptable_funcs - Callbacks used to interact with the SMU.
+ */
 struct pptable_funcs {
+	/**
+	 * @run_btc: Calibrate voltage/frequency curve to fit the system's
+	 *           power delivery and voltage margins. Required for adaptive
+	 *           voltage frequency scaling (AVFS).
+	 */
 	int (*run_btc)(struct smu_context *smu);
+
+	/**
+	 * @get_allowed_feature_mask: Get allowed feature mask.
+	 * &feature_mask: Array to store feature mask.
+	 * &num: Elements in &feature_mask.
+	 */
 	int (*get_allowed_feature_mask)(struct smu_context *smu, uint32_t *feature_mask, uint32_t num);
+
+	/**
+	 * @get_current_power_state: Get the current power state.
+	 *
+	 * Return: Current power state on success, negative errno on failure.
+	 */
 	enum amd_pm_state_type (*get_current_power_state)(struct smu_context *smu);
+
+	/**
+	 * @set_default_dpm_table: Populate the dpm table with defaults.
+	 */
 	int (*set_default_dpm_table)(struct smu_context *smu);
+
 	int (*set_power_state)(struct smu_context *smu);
+
+	/**
+	 * @populate_umd_state_clk: Populate the UMD power state table with
+	 *                          defaults.
+	 */
 	int (*populate_umd_state_clk)(struct smu_context *smu);
+
+	/**
+	 * @print_clk_levels: Print DPM clock levels for a clock domain
+	 *                    to buffer. Star current level.
+	 *
+	 * Used for sysfs interfaces.
+	 */
 	int (*print_clk_levels)(struct smu_context *smu, enum smu_clk_type clk_type, char *buf);
+
+	/**
+	 * @force_clk_levels: Set a range of allowed DPM levels for a clock
+	 *                    domain.
+	 * &clk_type: Clock domain.
+	 * &mask: Range of allowed DPM levels.
+	 */
 	int (*force_clk_levels)(struct smu_context *smu, enum smu_clk_type clk_type, uint32_t mask);
+
+	/**
+	 * @od_edit_dpm_table: Edit the custom overdrive DPM table.
+	 * &type: Type of edit.
+	 * &input: Edit parameters.
+	 * &size: Size of &input.
+	 */
 	int (*od_edit_dpm_table)(struct smu_context *smu,
 				 enum PP_OD_DPM_TABLE_COMMAND type,
 				 long *input, uint32_t size);
+
+	/**
+	 * @get_clock_by_type_with_latency: Get the speed and latency of a clock
+	 *                                  domain.
+	 */
 	int (*get_clock_by_type_with_latency)(struct smu_context *smu,
 					      enum smu_clk_type clk_type,
 					      struct
 					      pp_clock_levels_with_latency
 					      *clocks);
+	/**
+	 * @get_clock_by_type_with_voltage: Get the speed and voltage of a clock
+	 *                                  domain.
+	 */
+	int (*get_clock_by_type_with_voltage)(struct smu_context *smu,
+					      enum amd_pp_clock_type type,
+					      struct
+					      pp_clock_levels_with_voltage
+					      *clocks);
+
+	/**
+	 * @get_power_profile_mode: Print all power profile modes to
+	 *                          buffer. Star current mode.
+	 */
 	int (*get_power_profile_mode)(struct smu_context *smu, char *buf);
+
+	/**
+	 * @set_power_profile_mode: Set a power profile mode. Also used to
+	 *                          create/set custom power profile modes.
+	 * &input: Power profile mode parameters.
+	 * &size: Size of &input.
+	 */
 	int (*set_power_profile_mode)(struct smu_context *smu, long *input, uint32_t size);
+
+	/**
+	 * @dpm_set_vcn_enable: Enable/disable VCN engine dynamic power
+	 *                      management.
+	 */
 	int (*dpm_set_vcn_enable)(struct smu_context *smu, bool enable);
+
+	/**
+	 * @dpm_set_jpeg_enable: Enable/disable JPEG engine dynamic power
+	 *                       management.
+	 */
 	int (*dpm_set_jpeg_enable)(struct smu_context *smu, bool enable);
+
+	/**
+	 * @read_sensor: Read data from a sensor.
+	 * &sensor: Sensor to read data from.
+	 * &data: Sensor reading.
+	 * &size: Size of &data.
+	 */
 	int (*read_sensor)(struct smu_context *smu, enum amd_pp_sensors sensor,
 			   void *data, uint32_t *size);
+
+	/**
+	 * @pre_display_config_changed: Prepare GPU for a display configuration
+	 *                              change.
+	 *
+	 * Disable display tracking and pin memory clock speed to maximum. Used
+	 * in display component synchronization.
+	 */
 	int (*pre_display_config_changed)(struct smu_context *smu);
+
+	/**
+	 * @display_config_changed: Notify the SMU of the current display
+	 *                          configuration.
+	 *
+	 * Allows SMU to properly track blanking periods for memory clock
+	 * adjustment. Used in display component synchronization.
+	 */
 	int (*display_config_changed)(struct smu_context *smu);
+
 	int (*apply_clocks_adjust_rules)(struct smu_context *smu);
+
+	/**
+	 * @notify_smc_display_config: Applies display requirements to the
+	 *                             current power state.
+	 *
+	 * Optimize deep sleep DCEFclk and mclk for the current display
+	 * configuration. Used in display component synchronization.
+	 */
 	int (*notify_smc_display_config)(struct smu_context *smu);
+
+	/**
+	 * @is_dpm_running: Check if DPM is running.
+	 *
+	 * Return: True if DPM is running, false otherwise.
+	 */
 	bool (*is_dpm_running)(struct smu_context *smu);
+
+	/**
+	 * @get_fan_speed_rpm: Get the current fan speed in RPM.
+	 */
 	int (*get_fan_speed_rpm)(struct smu_context *smu, uint32_t *speed);
+
+	/**
+	 * @set_watermarks_table: Configure and upload the watermarks tables to
+	 *                        the SMU.
+	 */
 	int (*set_watermarks_table)(struct smu_context *smu,
 				    struct pp_smu_wm_range_sets *clock_ranges);
+
+	/**
+	 * @get_thermal_temperature_range: Get safe thermal limits in Celcius.
+	 */
 	int (*get_thermal_temperature_range)(struct smu_context *smu, struct smu_temperature_range *range);
+
+	/**
+	 * @get_uclk_dpm_states: Get memory clock DPM levels in kHz.
+	 * &clocks_in_khz: Array of DPM levels.
+	 * &num_states: Elements in &clocks_in_khz.
+	 */
 	int (*get_uclk_dpm_states)(struct smu_context *smu, uint32_t *clocks_in_khz, uint32_t *num_states);
+
+	/**
+	 * @set_default_od_settings: Set the overdrive tables to defaults.
+	 */
 	int (*set_default_od_settings)(struct smu_context *smu);
+
+	/**
+	 * @set_performance_level: Set a performance level.
+	 */
 	int (*set_performance_level)(struct smu_context *smu, enum amd_dpm_forced_level level);
+
+	/**
+	 * @display_disable_memory_clock_switch: Enable/disable dynamic memory
+	 *                                       clock switching.
+	 *
+	 * Disabling this feature forces memory clock speed to maximum.
+	 * Enabling sets the minimum memory clock capable of driving the
+	 * current display configuration.
+	 */
 	int (*display_disable_memory_clock_switch)(struct smu_context *smu, bool disable_memory_clock_switch);
+
+	/**
+	 * @dump_pptable: Print the power play table to the system log.
+	 */
 	void (*dump_pptable)(struct smu_context *smu);
+
+	/**
+	 * @get_power_limit: Get the device's power limits.
+	 */
 	int (*get_power_limit)(struct smu_context *smu);
+
+	/**
+	 * @set_df_cstate: Set data fabric cstate.
+	 */
 	int (*set_df_cstate)(struct smu_context *smu, enum pp_df_cstate state);
+
+	/**
+	 * @allow_xgmi_power_down: Enable/disable external global memory
+	 *                         interconnect power down.
+	 */
 	int (*allow_xgmi_power_down)(struct smu_context *smu, bool en);
+
+	/**
+	 * @update_pcie_parameters: Update and upload the system's PCIe
+	 *                          capabilites to the SMU.
+	 * &pcie_gen_cap: Maximum allowed PCIe generation.
+	 * &pcie_width_cap: Maximum allowed PCIe width.
+	 */
 	int (*update_pcie_parameters)(struct smu_context *smu, uint32_t pcie_gen_cap, uint32_t pcie_width_cap);
+
+	/**
+	 * @i2c_init: Initialize i2c.
+	 *
+	 * The i2c bus is used internally by the SMU voltage regulators and
+	 * other devices. The i2c's EEPROM also stores bad page tables on boards
+	 * with ECC.
+	 */
 	int (*i2c_init)(struct smu_context *smu, struct i2c_adapter *control);
+
+	/**
+	 * @i2c_fini: Tear down i2c.
+	 */
 	void (*i2c_fini)(struct smu_context *smu, struct i2c_adapter *control);
+
+	/**
+	 * @get_unique_id: Get the GPU's unique id. Used for asset tracking.
+	 */
 	void (*get_unique_id)(struct smu_context *smu);
+
+	/**
+	 * @get_dpm_clock_table: Get a copy of the DPM clock table.
+	 *
+	 * Used by display component in bandwidth and watermark calculations.
+	 */
 	int (*get_dpm_clock_table)(struct smu_context *smu, struct dpm_clocks *clock_table);
+
+	/**
+	 * @init_microcode: Request the SMU's firmware from the kernel.
+	 */
 	int (*init_microcode)(struct smu_context *smu);
+
+	/**
+	 * @load_microcode: Load firmware onto the SMU.
+	 */
 	int (*load_microcode)(struct smu_context *smu);
+
+	/**
+	 * @fini_microcode: Release the SMU's firmware.
+	 */
 	void (*fini_microcode)(struct smu_context *smu);
+
+	/**
+	 * @init_smc_tables: Initialize the SMU tables.
+	 */
 	int (*init_smc_tables)(struct smu_context *smu);
+
+	/**
+	 * @fini_smc_tables: Release the SMU tables.
+	 */
 	int (*fini_smc_tables)(struct smu_context *smu);
+
+	/**
+	 * @init_power: Initialize the power gate table context.
+	 */
 	int (*init_power)(struct smu_context *smu);
+
+	/**
+	 * @fini_power: Release the power gate table context.
+	 */
 	int (*fini_power)(struct smu_context *smu);
+
+	/**
+	 * @check_fw_status: Check the SMU's firmware status.
+	 *
+	 * Return: Zero if check passes, negative errno on failure.
+	 */
 	int (*check_fw_status)(struct smu_context *smu);
+
+	/**
+	 * @setup_pptable: Initialize the power play table and populate it with
+	 *                 default values.
+	 */
 	int (*setup_pptable)(struct smu_context *smu);
+
+	/**
+	 * @get_vbios_bootup_values: Get default boot values from the VBIOS.
+	 */
 	int (*get_vbios_bootup_values)(struct smu_context *smu);
+
+	/**
+	 * @check_fw_version: Print driver and SMU interface versions to the
+	 *                    system log.
+	 *
+	 * Interface mismatch is not a critical failure.
+	 */
 	int (*check_fw_version)(struct smu_context *smu);
+
+	/**
+	 * @powergate_sdma: Power up/down system direct memory access.
+	 */
 	int (*powergate_sdma)(struct smu_context *smu, bool gate);
+
+	/**
+	 * @set_gfx_cgpg: Enable/disable graphics engine course grain power
+	 *                gating.
+	 */
 	int (*set_gfx_cgpg)(struct smu_context *smu, bool enable);
+
+	/**
+	 * @write_pptable: Write the power play table to the SMU.
+	 */
 	int (*write_pptable)(struct smu_context *smu);
+
+	/**
+	 * @set_driver_table_location: Send the location of the driver table to
+	 *                             the SMU.
+	 */
 	int (*set_driver_table_location)(struct smu_context *smu);
+
+	/**
+	 * @set_tool_table_location: Send the location of the tool table to the
+	 *                           SMU.
+	 */
 	int (*set_tool_table_location)(struct smu_context *smu);
+
+	/**
+	 * @notify_memory_pool_location: Send the location of the memory pool to
+	 *                               the SMU.
+	 */
 	int (*notify_memory_pool_location)(struct smu_context *smu);
+
+	/**
+	 * @system_features_control: Enable/disable all SMU features.
+	 */
 	int (*system_features_control)(struct smu_context *smu, bool en);
+
+	/**
+	 * @send_smc_msg_with_param: Send a message with a parameter to the SMU.
+	 * &msg: Type of message.
+	 * &param: Message parameter.
+	 * &read_arg: SMU response (optional).
+	 */
 	int (*send_smc_msg_with_param)(struct smu_context *smu,
 				       enum smu_message_type msg, uint32_t param, uint32_t *read_arg);
+
+	/**
+	 * @send_smc_msg: Send a message to the SMU.
+	 * &msg: Type of message.
+	 * &read_arg: SMU response (optional).
+	 */
 	int (*send_smc_msg)(struct smu_context *smu,
 			    enum smu_message_type msg,
 			    uint32_t *read_arg);
+
+	/**
+	 * @init_display_count: Notify the SMU of the number of display
+	 *                      components in current display configuration.
+	 */
 	int (*init_display_count)(struct smu_context *smu, uint32_t count);
+
+	/**
+	 * @set_allowed_mask: Notify the SMU of the features currently allowed
+	 *                    by the driver.
+	 */
 	int (*set_allowed_mask)(struct smu_context *smu);
+
+	/**
+	 * @get_enabled_mask: Get a mask of features that are currently enabled
+	 *                    on the SMU.
+	 * &feature_mask: Array representing enabled feature mask.
+	 * &num: Elements in &feature_mask.
+	 */
 	int (*get_enabled_mask)(struct smu_context *smu, uint32_t *feature_mask, uint32_t num);
+
+	/**
+	 * @feature_is_enabled: Test if a feature is enabled.
+	 *
+	 * Return: One if enabled, zero if disabled.
+	 */
 	int (*feature_is_enabled)(struct smu_context *smu, enum smu_feature_mask mask);
+
+	/**
+	 * @disable_all_features_with_exception: Disable all features with
+	 *                                       exception to those in &mask.
+	 */
 	int (*disable_all_features_with_exception)(struct smu_context *smu, enum smu_feature_mask mask);
+
+	/**
+	 * @notify_display_change: Enable fast memory clock switching.
+	 *
+	 * Allows for fine grained memory clock switching but has more stringent
+	 * timing requirements.
+	 */
 	int (*notify_display_change)(struct smu_context *smu);
+
+	/**
+	 * @set_power_limit: Set power limit in watts.
+	 */
 	int (*set_power_limit)(struct smu_context *smu, uint32_t n);
+
+	/**
+	 * @init_max_sustainable_clocks: Populate max sustainable clock speed
+	 *                               table with values from the SMU.
+	 */
 	int (*init_max_sustainable_clocks)(struct smu_context *smu);
+
+	/**
+	 * @enable_thermal_alert: Enable thermal alert interrupts.
+	 */
 	int (*enable_thermal_alert)(struct smu_context *smu);
+
+	/**
+	 * @disable_thermal_alert: Disable thermal alert interrupts.
+	 */
 	int (*disable_thermal_alert)(struct smu_context *smu);
+
+	/**
+	 * @set_min_dcef_deep_sleep: Set a minimum display fabric deep sleep
+	 *                           clock speed in MHz.
+	 */
 	int (*set_min_dcef_deep_sleep)(struct smu_context *smu, uint32_t clk);
+
+	/**
+	 * @display_clock_voltage_request: Set a hard minimum frequency
+	 * for a clock domain.
+	 */
 	int (*display_clock_voltage_request)(struct smu_context *smu, struct
 					     pp_display_clock_request
 					     *clock_req);
+
+	/**
+	 * @get_fan_control_mode: Get the current fan control mode.
+	 */
 	uint32_t (*get_fan_control_mode)(struct smu_context *smu);
+
+	/**
+	 * @set_fan_control_mode: Set the fan control mode.
+	 */
 	int (*set_fan_control_mode)(struct smu_context *smu, uint32_t mode);
+
+	/**
+	 * @set_fan_speed_rpm: Set a static fan speed in RPM.
+	 */
 	int (*set_fan_speed_rpm)(struct smu_context *smu, uint32_t speed);
+
+	/**
+	 * @set_xgmi_pstate: Set inter-chip global memory interconnect pstate.
+	 * &pstate: Pstate to set. D0 if Nonzero, D3 otherwise.
+	 */
 	int (*set_xgmi_pstate)(struct smu_context *smu, uint32_t pstate);
+
+	/**
+	 * @gfx_off_control: Enable/disable graphics engine poweroff.
+	 */
 	int (*gfx_off_control)(struct smu_context *smu, bool enable);
+
+
+	/**
+	 * @get_gfx_off_status: Get graphics engine poweroff status.
+	 *
+	 * Return:
+	 * 0 - GFXOFF(default).
+	 * 1 - Transition out of GFX State.
+	 * 2 - Not in GFXOFF.
+	 * 3 - Transition into GFXOFF.
+	 */
 	uint32_t (*get_gfx_off_status)(struct smu_context *smu);
+
+	/**
+	 * @register_irq_handler: Register interupt request handlers.
+	 */
 	int (*register_irq_handler)(struct smu_context *smu);
+
+	/**
+	 * @set_azalia_d3_pme: Wake the audio decode engine from d3 sleep.
+	 */
 	int (*set_azalia_d3_pme)(struct smu_context *smu);
+
+	/**
+	 * @get_max_sustainable_clocks_by_dc: Get a copy of the max sustainable
+	 *                                    clock speeds table.
+	 *
+	 * Provides a way for the display component (DC) to get the max
+	 * sustainable clocks from the SMU.
+	 */
 	int (*get_max_sustainable_clocks_by_dc)(struct smu_context *smu, struct pp_smu_nv_clock_table *max_clocks);
+
+	/**
+	 * @baco_is_support: Check if GPU supports BACO (Bus Active, Chip Off).
+	 */
 	bool (*baco_is_support)(struct smu_context *smu);
+
+	/**
+	 * @baco_get_state: Get the current BACO state.
+	 *
+	 * Return: Current BACO state.
+	 */
 	enum smu_baco_state (*baco_get_state)(struct smu_context *smu);
+
+	/**
+	 * @baco_set_state: Enter/exit BACO.
+	 */
 	int (*baco_set_state)(struct smu_context *smu, enum smu_baco_state state);
+
+	/**
+	 * @baco_enter: Enter BACO.
+	 */
 	int (*baco_enter)(struct smu_context *smu);
+
+	/**
+	 * @baco_exit: Exit Baco.
+	 */
 	int (*baco_exit)(struct smu_context *smu);
+
+	/**
+	 * @mode1_reset_is_support: Check if GPU supports mode1 reset.
+	 */
 	bool (*mode1_reset_is_support)(struct smu_context *smu);
+
+	/**
+	 * @mode1_reset: Perform mode1 reset.
+	 *
+	 * Complete GPU reset.
+	 */
 	int (*mode1_reset)(struct smu_context *smu);
+
+	/**
+	 * @mode2_reset: Perform mode2 reset.
+	 *
+	 * Mode2 reset generally does not reset as many IPs as mode1 reset. The
+	 * IPs reset varies by asic.
+	 */
 	int (*mode2_reset)(struct smu_context *smu);
+
+	/**
+	 * @get_dpm_ultimate_freq: Get the hard frequency range of a clock
+	 *                         domain in MHz.
+	 */
 	int (*get_dpm_ultimate_freq)(struct smu_context *smu, enum smu_clk_type clk_type, uint32_t *min, uint32_t *max);
+
+	/**
+	 * @set_soft_freq_limited_range: Set the soft frequency range of a clock
+	 *                               domain in MHz.
+	 */
 	int (*set_soft_freq_limited_range)(struct smu_context *smu, enum smu_clk_type clk_type, uint32_t min, uint32_t max);
+
+	/**
+	 * @set_power_source: Notify the SMU of the current power source.
+	 */
 	int (*set_power_source)(struct smu_context *smu, enum smu_power_src_type power_src);
+
+	/**
+	 * @log_thermal_throttling_event: Print a thermal throttling warning to
+	 *                                the system's log.
+	 */
 	void (*log_thermal_throttling_event)(struct smu_context *smu);
+
+	/**
+	 * @get_pp_feature_mask: Print a human readable table of enabled
+	 *                       features to buffer.
+	 */
 	size_t (*get_pp_feature_mask)(struct smu_context *smu, char *buf);
+
+	/**
+	 * @set_pp_feature_mask: Request the SMU enable/disable features to
+	 *                       match those enabled in &new_mask.
+	 */
 	int (*set_pp_feature_mask)(struct smu_context *smu, uint64_t new_mask);
+
+	/**
+	 * @get_gpu_metrics: Get a copy of the GPU metrics table from the SMU.
+	 *
+	 * Return: Size of &table
+	 */
 	ssize_t (*get_gpu_metrics)(struct smu_context *smu, void **table);
+
+	/**
+	 * @enable_mgpu_fan_boost: Enable multi-GPU fan boost.
+	 */
 	int (*enable_mgpu_fan_boost)(struct smu_context *smu);
+
+	/**
+	 * @gfx_ulv_control: Enable/disable ultra low voltage.
+	 */
 	int (*gfx_ulv_control)(struct smu_context *smu, bool enablement);
+
+	/**
+	 * @deep_sleep_control: Enable/disable deep sleep.
+	 */
 	int (*deep_sleep_control)(struct smu_context *smu, bool enablement);
+
+	/**
+	 * @get_fan_parameters: Get fan parameters.
+	 *
+	 * Get maximum fan speed from the power play table.
+	 */
 	int (*get_fan_parameters)(struct smu_context *smu);
+
+	/**
+	 * @post_init: Helper function for asic specific workarounds.
+	 */
 	int (*post_init)(struct smu_context *smu);
+
+	/**
+	 * @interrupt_work: Work task scheduled from SMU interrupt handler.
+	 */
 	void (*interrupt_work)(struct smu_context *smu);
+
+	/**
+	 * @gpo_control: Enable/disable graphics power optimization if supported.
+	 */
 	int (*gpo_control)(struct smu_context *smu, bool enablement);
+
+	/**
+	 * @gfx_state_change_set: Send the current graphics state to the SMU.
+	 */
 	int (*gfx_state_change_set)(struct smu_context *smu, uint32_t state);
+
+	/**
+	 * @set_fine_grain_gfx_freq_parameters: Set fine grain graphics clock
+	 *                                      parameters to defaults.
+	 */
 	int (*set_fine_grain_gfx_freq_parameters)(struct smu_context *smu);
 };
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
