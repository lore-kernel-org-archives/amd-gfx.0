Return-Path: <SRS0=tiv0=75=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDF3C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 13:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C819E20B1F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 13:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ICrHPCaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C819E20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 705ED6E14C;
	Tue, 16 Jun 2020 13:02:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B36FF6E14C
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2020 13:02:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UN+Zg9cf1vY1z+4nbvY0xyDONbyJBllzD2zBNa5CW/yshbuod9JUXrvcxqN2Zs35pEwnm+TfMClq94dP2JNebh9mjALXESf5LGC9yAv/dPIq4skQsebC4CKC4gofrgLN2Fil9+fkr+YLzV4/00VVzq/DbLlxrk52KRM1UOTsXMrGJkwCnD8qBi5M/7dTO4AUgIk77iab3Zky7UzQM4cLjCGLV+Q/+e2exCQPRyN58KQ+JR/srZtfsEgGgJr2rt0OHyUQfOM8WjiXwTZfr3SmrbWoqHRHaWsWCm4V2vOZoOrh5wqcKUMWhU4bJRaF7mXQc30B1XyrCO/suimzvl7ayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+QttPShMkRBC4+pnYXs/P3h5LfZk3Pb3WwMabY/yHY=;
 b=Q/OJykyZDHHsAHntOlTrqfMyvtNnvEosJ3Nqd+sYCP6aAbiWPvoHSRPA8raVJbsUBEuK6vCclVd/E2eIoCO99Y3zdncd56GdiwqFMLyykC4B+MF8MYYfUhMZIU05OElrRcfpCz19FqyCR4mo2vWffzN+8xAyyAzCM/IA2rVz7yCMDfhEnb/YLTLyTas95UYj12Kga/NOGGiKEJ0AmCH2lcStmQO1SGuQPNYxtFCKkLeHkAxagc5rsoteH01nKGNiMyOkLnkA098Y7iqRIKmje07qk/mBwpcheXAdzQzD7a4XKVUUNzFBuPSG/NuisY42jQdaToFwIbIhetBr0Q9yUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+QttPShMkRBC4+pnYXs/P3h5LfZk3Pb3WwMabY/yHY=;
 b=ICrHPCafxwPM1BX5Mb8mW0Zb8QTzhjw+dW5xghEC2rZFMJQGrtuf5vJhUlJjKcu/g0fvOPPZtF2DoN6eF8DA6rNKEPnFikPVN7VAfTAessbzraLZ0+O5NTtwSuV++nx3GXJYZB9DJMxcWD9do82C+oVTobz0RJa4LrTG50JzQRg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.23; Tue, 16 Jun
 2020 13:02:15 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9ca1:81ba:bd45:53f4]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9ca1:81ba:bd45:53f4%5]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 13:02:15 +0000
Date: Tue, 16 Jun 2020 21:01:50 +0800
From: Huang Rui <ray.huang@amd.com>
To: Kevin Wang <kevin1.wang@amd.com>
Subject: Re: [PATCH v2] drm/amd/smu: unify smu ppt callback marcos
Message-ID: <20200616130150.GA4002469@hr-amd>
References: <20200616102937.12417-1-kevin1.wang@amd.com>
 <20200616102937.12417-2-kevin1.wang@amd.com>
Content-Disposition: inline
In-Reply-To: <20200616102937.12417-2-kevin1.wang@amd.com>
X-ClientProxiedBy: HK2PR03CA0053.apcprd03.prod.outlook.com
 (2603:1096:202:17::23) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.242) by
 HK2PR03CA0053.apcprd03.prod.outlook.com (2603:1096:202:17::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.9 via Frontend Transport; Tue, 16 Jun 2020 13:02:13 +0000
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 584b9835-9b0c-4226-c2dc-08d811f57da5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4110:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4110C020DCA4C95F1C079E29EC9D0@MN2PR12MB4110.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oBUhJpP4APledAMG4fIDyZDrdMaYcq5RATm5fEzY+wMdDNzfBZ9uCWzRCWT44iPYQEF4XnLIbDgsgMsVyonMVa9w2g9hnrLD0U2yLEzU91l9kh3MkRu5P0PdfjOrfM8QfDbb/f6vWSCB+8XsV3UsXAtoEMDEQxJaUBlADGch6e3WzLLOfWak4yxQFBg2gJJcWDzFEQF5HsyXzH7VXrF6g4wlytS+4qJMiGp0aXhw/CdOLueJoJheO55Qt1g/lSpM/gpYrkzRbwzc7S0sxMqUpmNLiDRUTSqhOSS9QJtZHQzJvfVMc2/+x3rT+lng3IlCquH001hq2BabeMd3u8hDuwwbMwLnEQ86L7lv2XjdkMrVKphmt5x8ZdXSMwC0U7e+W4YKVQRHuG3GljMq0YHzxtzcs3ykph8YQl16TbB8hs0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(6496006)(6636002)(86362001)(8936002)(956004)(8676002)(66556008)(66476007)(9686003)(1076003)(316002)(33716001)(6666004)(66946007)(33656002)(16526019)(55016002)(30864003)(45080400002)(5660300002)(478600001)(83380400001)(4326008)(26005)(66574015)(966005)(2906002)(186003)(6862004)(52116002)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: j6ibWPoP2H0jN7TMXYNwrBXcDKPOya7xKfpeAGsLaCvCwMrOqrP+Y0liLS4ZCXt2mVsFgFWFJCQzWSkEb0UP/Mh64TaG9vyEcnipmt6Ff1yC6vbeLPQy15vK2gtLd0BKySCPIrMdnt/13ErPftp64tPX1/3q1RDVEpHHt+2S2DhrNCYkxMd+U8Rl9ijOhQZLppJ35kcS+0g3aOhyizfRCULXqUqF8TK5FVxUu9XsKN4MevHCHaN60+zIWjbEjMMe+DUVTYbNbzJwMPq4j4Q+2cKKiBHdhRNyf0IpNs0X4/b4+NEMEnCaU0e/SpkVxFtbqgg35YWT8vvSPP2OfWA44h2TvOmKyeJHFsHT3MJJwJUabuJ8XE2Ce3oQeuCUqTN71nJavIFOs4Jicn0UbBu2URqLGbAGJvKw0gmgTnTgMp24u+R7t2+WSY6ogFW8aMLSMM9qZiNV0ypoRBAQ/LbV74uGd5/Y7PpS1ZNcqB7SnoVvgaMWASGsRwInrrQRcuIz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 584b9835-9b0c-4226-c2dc-08d811f57da5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 13:02:14.9827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3/DqTTj2I21UPBkvQdB6oM4xV5QZ5N243aZQ/Bgy/uYgMimjPes1GRQMNVbq0O5SmRwulje3eWmmm8Inew30Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
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
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 16, 2020 at 06:29:37PM +0800, Kevin Wang wrote:
> v1: add the new macro "smu_ppt_xxx()" to unify smu callback interfaces
> v2: rename the macro smu_ppt_xxx to smu_ppt_funcs.
> 
> Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
> ---

Series look good for me.

Reviewed-by: Huang Rui <ray.huang@amd.com>

>  drivers/gpu/drm/amd/powerplay/smu_internal.h | 267 ++++++-------------
>  1 file changed, 82 insertions(+), 185 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> index 880ef54884f8..afd786b6c0b4 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
> +++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> @@ -25,191 +25,88 @@
>  
>  #include "amdgpu_smu.h"
>  
> -#define smu_init_microcode(smu) \
> -	((smu)->ppt_funcs->init_microcode ? (smu)->ppt_funcs->init_microcode((smu)) : 0)
> -#define smu_fini_microcode(smu) \
> -	((smu)->ppt_funcs->fini_microcode ? (smu)->ppt_funcs->fini_microcode((smu)) : 0)
> -#define smu_init_smc_tables(smu) \
> -	((smu)->ppt_funcs->init_smc_tables ? (smu)->ppt_funcs->init_smc_tables((smu)) : 0)
> -#define smu_fini_smc_tables(smu) \
> -	((smu)->ppt_funcs->fini_smc_tables ? (smu)->ppt_funcs->fini_smc_tables((smu)) : 0)
> -#define smu_init_power(smu) \
> -	((smu)->ppt_funcs->init_power ? (smu)->ppt_funcs->init_power((smu)) : 0)
> -#define smu_fini_power(smu) \
> -	((smu)->ppt_funcs->fini_power ? (smu)->ppt_funcs->fini_power((smu)) : 0)
> -
> -#define smu_setup_pptable(smu) \
> -	((smu)->ppt_funcs->setup_pptable ? (smu)->ppt_funcs->setup_pptable((smu)) : 0)
> -#define smu_powergate_sdma(smu, gate) \
> -	((smu)->ppt_funcs->powergate_sdma ? (smu)->ppt_funcs->powergate_sdma((smu), (gate)) : 0)
> -
> -#define smu_get_vbios_bootup_values(smu) \
> -	((smu)->ppt_funcs->get_vbios_bootup_values ? (smu)->ppt_funcs->get_vbios_bootup_values((smu)) : 0)
> -#define smu_check_fw_version(smu) \
> -	((smu)->ppt_funcs->check_fw_version ? (smu)->ppt_funcs->check_fw_version((smu)) : 0)
> -#define smu_write_pptable(smu) \
> -	((smu)->ppt_funcs->write_pptable ? (smu)->ppt_funcs->write_pptable((smu)) : 0)
> -#define smu_set_min_dcef_deep_sleep(smu, clk) \
> -	((smu)->ppt_funcs->set_min_dcef_deep_sleep ? (smu)->ppt_funcs->set_min_dcef_deep_sleep((smu), (clk)) : 0)
> -#define smu_set_driver_table_location(smu) \
> -	((smu)->ppt_funcs->set_driver_table_location ? (smu)->ppt_funcs->set_driver_table_location((smu)) : 0)
> -#define smu_set_tool_table_location(smu) \
> -	((smu)->ppt_funcs->set_tool_table_location ? (smu)->ppt_funcs->set_tool_table_location((smu)) : 0)
> -#define smu_notify_memory_pool_location(smu) \
> -	((smu)->ppt_funcs->notify_memory_pool_location ? (smu)->ppt_funcs->notify_memory_pool_location((smu)) : 0)
> -#define smu_gfx_off_control(smu, enable) \
> -	((smu)->ppt_funcs->gfx_off_control ? (smu)->ppt_funcs->gfx_off_control((smu), (enable)) : 0)
> -
> -#define smu_set_last_dcef_min_deep_sleep_clk(smu) \
> -	((smu)->ppt_funcs->set_last_dcef_min_deep_sleep_clk ? (smu)->ppt_funcs->set_last_dcef_min_deep_sleep_clk((smu)) : 0)
> -#define smu_system_features_control(smu, en) \
> -	((smu)->ppt_funcs->system_features_control ? (smu)->ppt_funcs->system_features_control((smu), (en)) : 0)
> -#define smu_init_max_sustainable_clocks(smu) \
> -	((smu)->ppt_funcs->init_max_sustainable_clocks ? (smu)->ppt_funcs->init_max_sustainable_clocks((smu)) : 0)
> -#define smu_set_default_od_settings(smu) \
> -	((smu)->ppt_funcs->set_default_od_settings ? (smu)->ppt_funcs->set_default_od_settings((smu)) : 0)
> -
> -#define smu_send_smc_msg_with_param(smu, msg, param, read_arg) \
> -	((smu)->ppt_funcs->send_smc_msg_with_param? (smu)->ppt_funcs->send_smc_msg_with_param((smu), (msg), (param), (read_arg)) : 0)
> -
> -static inline int smu_send_smc_msg(struct smu_context *smu, enum smu_message_type msg, uint32_t *read_arg) {
> -	return smu_send_smc_msg_with_param(smu, msg, 0, read_arg);
> -}
> -
> -#define smu_alloc_dpm_context(smu) \
> -	((smu)->ppt_funcs->alloc_dpm_context ? (smu)->ppt_funcs->alloc_dpm_context((smu)) : 0)
> -#define smu_init_display_count(smu, count) \
> -	((smu)->ppt_funcs->init_display_count ? (smu)->ppt_funcs->init_display_count((smu), (count)) : 0)
> -#define smu_feature_set_allowed_mask(smu) \
> -	((smu)->ppt_funcs->set_allowed_mask? (smu)->ppt_funcs->set_allowed_mask((smu)) : 0)
> -#define smu_feature_get_enabled_mask(smu, mask, num) \
> -	((smu)->ppt_funcs->get_enabled_mask? (smu)->ppt_funcs->get_enabled_mask((smu), (mask), (num)) : 0)
> -#define smu_is_dpm_running(smu) \
> -	((smu)->ppt_funcs->is_dpm_running ? (smu)->ppt_funcs->is_dpm_running((smu)) : 0)
> -#define smu_notify_display_change(smu) \
> -	((smu)->ppt_funcs->notify_display_change? (smu)->ppt_funcs->notify_display_change((smu)) : 0)
> -#define smu_set_default_dpm_table(smu) \
> -	((smu)->ppt_funcs->set_default_dpm_table ? (smu)->ppt_funcs->set_default_dpm_table((smu)) : 0)
> -#define smu_populate_umd_state_clk(smu) \
> -	((smu)->ppt_funcs->populate_umd_state_clk ? (smu)->ppt_funcs->populate_umd_state_clk((smu)) : 0)
> -#define smu_set_default_od8_settings(smu) \
> -	((smu)->ppt_funcs->set_default_od8_settings ? (smu)->ppt_funcs->set_default_od8_settings((smu)) : 0)
> -
> -#define smu_get_current_clk_freq(smu, clk_id, value) \
> -	((smu)->ppt_funcs->get_current_clk_freq? (smu)->ppt_funcs->get_current_clk_freq((smu), (clk_id), (value)) : 0)
> -
> -#define smu_tables_init(smu, tab) \
> -	((smu)->ppt_funcs->tables_init ? (smu)->ppt_funcs->tables_init((smu), (tab)) : 0)
> -#define smu_set_thermal_fan_table(smu) \
> -	((smu)->ppt_funcs->set_thermal_fan_table ? (smu)->ppt_funcs->set_thermal_fan_table((smu)) : 0)
> -#define smu_enable_thermal_alert(smu) \
> -	((smu)->ppt_funcs->enable_thermal_alert? (smu)->ppt_funcs->enable_thermal_alert((smu)) : 0)
> -#define smu_disable_thermal_alert(smu) \
> -	((smu)->ppt_funcs->disable_thermal_alert? (smu)->ppt_funcs->disable_thermal_alert((smu)) : 0)
> -
> -#define smu_smc_read_sensor(smu, sensor, data, size) \
> -	((smu)->ppt_funcs->read_sensor? (smu)->ppt_funcs->read_sensor((smu), (sensor), (data), (size)) : -EINVAL)
> -
> -#define smu_pre_display_config_changed(smu) \
> -	((smu)->ppt_funcs->pre_display_config_changed ? (smu)->ppt_funcs->pre_display_config_changed((smu)) : 0)
> -#define smu_display_config_changed(smu) \
> -	((smu)->ppt_funcs->display_config_changed ? (smu)->ppt_funcs->display_config_changed((smu)) : 0)
> -#define smu_apply_clocks_adjust_rules(smu) \
> -	((smu)->ppt_funcs->apply_clocks_adjust_rules ? (smu)->ppt_funcs->apply_clocks_adjust_rules((smu)) : 0)
> -#define smu_notify_smc_display_config(smu) \
> -	((smu)->ppt_funcs->notify_smc_display_config ? (smu)->ppt_funcs->notify_smc_display_config((smu)) : 0)
> -#define smu_force_dpm_limit_value(smu, highest) \
> -	((smu)->ppt_funcs->force_dpm_limit_value ? (smu)->ppt_funcs->force_dpm_limit_value((smu), (highest)) : 0)
> -#define smu_unforce_dpm_levels(smu) \
> -	((smu)->ppt_funcs->unforce_dpm_levels ? (smu)->ppt_funcs->unforce_dpm_levels((smu)) : 0)
> +#define smu_ppt_funcs(intf, ret, smu, args...) \
> +	((smu)->ppt_funcs ? ((smu)->ppt_funcs->intf ? (smu)->ppt_funcs->intf(smu, ##args) : ret) : -EINVAL)
> +
> +#define smu_init_microcode(smu)						smu_ppt_funcs(init_microcode, 0, smu)
> +#define smu_fini_microcode(smu)						smu_ppt_funcs(fini_microcode, 0, smu)
> +#define smu_init_smc_tables(smu)					smu_ppt_funcs(init_smc_tables, 0, smu)
> +#define smu_fini_smc_tables(smu)					smu_ppt_funcs(fini_smc_tables, 0, smu)
> +#define smu_init_power(smu)						smu_ppt_funcs(init_power,	0, smu)
> +#define smu_fini_power(smu)						smu_ppt_funcs(fini_power, 0, smu)
> +#define smu_setup_pptable(smu)						smu_ppt_funcs(setup_pptable, 0, smu)
> +#define smu_powergate_sdma(smu, gate)					smu_ppt_funcs(powergate_sdma, 0, smu, gate)
> +#define smu_get_vbios_bootup_values(smu)				smu_ppt_funcs(get_vbios_bootup_values, 0, smu)
> +#define smu_check_fw_version(smu)					smu_ppt_funcs(check_fw_version, 0, smu)
> +#define smu_write_pptable(smu)						smu_ppt_funcs(write_pptable, 0, smu)
> +#define smu_set_min_dcef_deep_sleep(smu, clk)				smu_ppt_funcs(set_min_dcef_deep_sleep, 0, smu, clk)
> +#define smu_set_driver_table_location(smu)				smu_ppt_funcs(set_driver_table_location, 0, smu)
> +#define smu_set_tool_table_location(smu)				smu_ppt_funcs(set_tool_table_location, 0, smu)
> +#define smu_notify_memory_pool_location(smu)				smu_ppt_funcs(notify_memory_pool_location, 0, smu)
> +#define smu_gfx_off_control(smu, enable)				smu_ppt_funcs(gfx_off_control, 0, smu, enable)
> +#define smu_set_last_dcef_min_deep_sleep_clk(smu)			smu_ppt_funcs(set_last_dcef_min_deep_sleep_clk, 0, smu)
> +#define smu_system_features_control(smu, en)				smu_ppt_funcs(system_features_control, 0, smu, en)
> +#define smu_init_max_sustainable_clocks(smu)				smu_ppt_funcs(init_max_sustainable_clocks, 0, smu)
> +#define smu_set_default_od_settings(smu)				smu_ppt_funcs(set_default_od_settings, 0, smu)
> +#define smu_send_smc_msg_with_param(smu, msg, param, read_arg)		smu_ppt_funcs(send_smc_msg_with_param, 0, smu, msg, param, read_arg)
> +#define smu_send_smc_msg(smu, msg, read_arg)				smu_ppt_funcs(send_smc_msg_with_param, 0, smu, msg, 0, read_arg)
> +#define smu_alloc_dpm_context(smu)					smu_ppt_funcs(alloc_dpm_context, 0, smu)
> +#define smu_init_display_count(smu, count)				smu_ppt_funcs(init_display_count, 0, smu, count)
> +#define smu_feature_set_allowed_mask(smu)				smu_ppt_funcs(set_allowed_mask, 0, smu)
> +#define smu_feature_get_enabled_mask(smu, mask, num)			smu_ppt_funcs(get_enabled_mask, 0, smu, mask, num)
> +#define smu_is_dpm_running(smu)						smu_ppt_funcs(is_dpm_running, 0 , smu)
> +#define smu_notify_display_change(smu)					smu_ppt_funcs(notify_display_change, 0, smu)
> +#define smu_set_default_dpm_table(smu)					smu_ppt_funcs(set_default_dpm_table, 0, smu)
> +#define smu_populate_umd_state_clk(smu)					smu_ppt_funcs(populate_umd_state_clk, 0, smu)
> +#define smu_set_default_od8_settings(smu)				smu_ppt_funcs(set_default_od8_settings, 0, smu)
> +#define smu_get_current_clk_freq(smu, clk_id, value)			smu_ppt_funcs(get_current_clk_freq, 0, smu, clk_id, value)
> +#define smu_tables_init(smu, tab)					smu_ppt_funcs(tables_init, 0, smu, tab)
> +#define smu_set_thermal_fan_table(smu)					smu_ppt_funcs(set_thermal_fan_table, 0, smu)
> +#define smu_enable_thermal_alert(smu)					smu_ppt_funcs(enable_thermal_alert, 0, smu)
> +#define smu_disable_thermal_alert(smu)					smu_ppt_funcs(disable_thermal_alert, 0, smu)
> +#define smu_smc_read_sensor(smu, sensor, data, size)			smu_ppt_funcs(read_sensor, -EINVAL, smu, sensor, data, size)
> +#define smu_pre_display_config_changed(smu)				smu_ppt_funcs(pre_display_config_changed, 0, smu)
> +#define smu_display_config_changed(smu)					smu_ppt_funcs(display_config_changed, 0 , smu)
> +#define smu_apply_clocks_adjust_rules(smu)				smu_ppt_funcs(apply_clocks_adjust_rules, 0, smu)
> +#define smu_notify_smc_display_config(smu)				smu_ppt_funcs(notify_smc_display_config, 0, smu)
> +#define smu_force_dpm_limit_value(smu, highest)				smu_ppt_funcs(force_dpm_limit_value, 0, smu, highest)
> +#define smu_unforce_dpm_levels(smu)					smu_ppt_funcs(unforce_dpm_levels, 0, smu)
> +#define smu_set_cpu_power_state(smu)					smu_ppt_funcs(set_cpu_power_state, 0, smu)
> +#define smu_msg_get_index(smu, msg)					smu_ppt_funcs(get_smu_msg_index, -EINVAL, smu, msg)
> +#define smu_clk_get_index(smu, clk)					smu_ppt_funcs(get_smu_clk_index, -EINVAL, smu, clk)
> +#define smu_feature_get_index(smu, fea)					smu_ppt_funcs(get_smu_feature_index, -EINVAL, smu, fea)
> +#define smu_table_get_index(smu, tab)					smu_ppt_funcs(get_smu_table_index, -EINVAL, smu, tab)
> +#define smu_power_get_index(smu, src)					smu_ppt_funcs(get_smu_power_index, -EINVAL, smu, src)
> +#define smu_workload_get_type(smu, type)				smu_ppt_funcs(get_smu_power_index, -EINVAL, smu, type)
> +#define smu_run_btc(smu)						smu_ppt_funcs(run_btc, 0, smu)
> +#define smu_get_allowed_feature_mask(smu, feature_mask, num)		smu_ppt_funcs(get_allowed_feature_mask, 0, smu, feature_mask, num)
> +#define smu_store_cc6_data(smu, st, cc6_dis, pst_dis, pst_sw_dis)	smu_ppt_funcs(store_cc6_data, 0, smu, st, cc6_dis, pst_dis, pst_sw_dis)
> +#define smu_get_dal_power_level(smu, clocks)				smu_ppt_funcs(get_dal_power_level, 0, smu, clocks)
> +#define smu_get_perf_level(smu, designation, level)			smu_ppt_funcs(get_perf_level, 0, smu, designation, level)
> +#define smu_get_current_shallow_sleep_clocks(smu, clocks)		smu_ppt_funcs(get_current_shallow_sleep_clocks, 0, smu, clocks)
> +#define smu_dpm_set_vcn_enable(smu, enable)				smu_ppt_funcs(dpm_set_vcn_enable, 0, smu, enable)
> +#define smu_dpm_set_jpeg_enable(smu, enable)				smu_ppt_funcs(dpm_set_jpeg_enable, 0, smu, enable)
> +#define smu_set_watermarks_table(smu, tab, clock_ranges)		smu_ppt_funcs(set_watermarks_table, 0, smu, tab, clock_ranges)
> +#define smu_get_current_clk_freq_by_table(smu, clk_type, value)		smu_ppt_funcs(get_current_clk_freq_by_table, 0, smu, clk_type, value)
> +#define smu_thermal_temperature_range_update(smu, range, rw)		smu_ppt_funcs(thermal_temperature_range_update, 0, smu, range, rw)
> +#define smu_get_thermal_temperature_range(smu, range)			smu_ppt_funcs(get_thermal_temperature_range, 0, smu, range)
> +#define smu_register_irq_handler(smu)					smu_ppt_funcs(register_irq_handler, 0, smu)
> +#define smu_get_dpm_ultimate_freq(smu, param, min, max)			smu_ppt_funcs(get_dpm_ultimate_freq, 0, smu, param, min, max)
> +#define smu_asic_set_performance_level(smu, level)			smu_ppt_funcs(set_performance_level, -EINVAL, smu, level)
> +#define smu_dump_pptable(smu)						smu_ppt_funcs(dump_pptable, 0, smu)
> +#define smu_get_dpm_clk_limited(smu, clk_type, dpm_level, freq)		smu_ppt_funcs(get_dpm_clk_limited, -EINVAL, smu, clk_type, dpm_level, freq)
> +#define smu_set_soft_freq_limited_range(smu, clk_type, min, max)	smu_ppt_funcs(set_soft_freq_limited_range, -EINVAL, smu, clk_type, min, max)
> +#define smu_override_pcie_parameters(smu)				smu_ppt_funcs(override_pcie_parameters, 0, smu)
> +#define smu_update_pcie_parameters(smu, pcie_gen_cap, pcie_width_cap)	smu_ppt_funcs(update_pcie_parameters, 0, smu, pcie_gen_cap, pcie_width_cap)
> +#define smu_set_thermal_range(smu, range)				smu_ppt_funcs(set_thermal_range, 0, smu, range)
> +#define smu_disable_umc_cdr_12gbps_workaround(smu)			smu_ppt_funcs(disable_umc_cdr_12gbps_workaround, 0, smu)
> +#define smu_set_power_source(smu, power_src)				smu_ppt_funcs(set_power_source, 0, smu, power_src)
> +#define smu_i2c_eeprom_init(smu, control)				smu_ppt_funcs(i2c_eeprom_init, 0, smu, control)
> +#define smu_i2c_eeprom_fini(smu, control)				smu_ppt_funcs(i2c_eeprom_fini, 0, smu, control)
> +#define smu_get_unique_id(smu)						smu_ppt_funcs(get_unique_id, 0, smu)
> +#define smu_log_thermal_throttling(smu)					smu_ppt_funcs(log_thermal_throttling_event, 0, smu)
> +#define smu_get_asic_power_limits(smu)					smu_ppt_funcs(get_power_limit, 0, smu)
>  #define smu_get_profiling_clk_mask(smu, level, sclk_mask, mclk_mask, soc_mask) \
> -	((smu)->ppt_funcs->get_profiling_clk_mask ? (smu)->ppt_funcs->get_profiling_clk_mask((smu), (level), (sclk_mask), (mclk_mask), (soc_mask)) : 0)
> -#define smu_set_cpu_power_state(smu) \
> -	((smu)->ppt_funcs->set_cpu_power_state ? (smu)->ppt_funcs->set_cpu_power_state((smu)) : 0)
> -
> -#define smu_msg_get_index(smu, msg) \
> -	((smu)->ppt_funcs? ((smu)->ppt_funcs->get_smu_msg_index? (smu)->ppt_funcs->get_smu_msg_index((smu), (msg)) : -EINVAL) : -EINVAL)
> -#define smu_clk_get_index(smu, msg) \
> -	((smu)->ppt_funcs? ((smu)->ppt_funcs->get_smu_clk_index? (smu)->ppt_funcs->get_smu_clk_index((smu), (msg)) : -EINVAL) : -EINVAL)
> -#define smu_feature_get_index(smu, msg) \
> -	((smu)->ppt_funcs? ((smu)->ppt_funcs->get_smu_feature_index? (smu)->ppt_funcs->get_smu_feature_index((smu), (msg)) : -EINVAL) : -EINVAL)
> -#define smu_table_get_index(smu, tab) \
> -	((smu)->ppt_funcs? ((smu)->ppt_funcs->get_smu_table_index? (smu)->ppt_funcs->get_smu_table_index((smu), (tab)) : -EINVAL) : -EINVAL)
> -#define smu_power_get_index(smu, src) \
> -	((smu)->ppt_funcs? ((smu)->ppt_funcs->get_smu_power_index? (smu)->ppt_funcs->get_smu_power_index((smu), (src)) : -EINVAL) : -EINVAL)
> -#define smu_workload_get_type(smu, profile) \
> -	((smu)->ppt_funcs? ((smu)->ppt_funcs->get_workload_type? (smu)->ppt_funcs->get_workload_type((smu), (profile)) : -EINVAL) : -EINVAL)
> -#define smu_run_btc(smu) \
> -	((smu)->ppt_funcs? ((smu)->ppt_funcs->run_btc? (smu)->ppt_funcs->run_btc((smu)) : 0) : 0)
> -#define smu_get_allowed_feature_mask(smu, feature_mask, num) \
> -	((smu)->ppt_funcs? ((smu)->ppt_funcs->get_allowed_feature_mask? (smu)->ppt_funcs->get_allowed_feature_mask((smu), (feature_mask), (num)) : 0) : 0)
> -
> -
> -#define smu_store_cc6_data(smu, st, cc6_dis, pst_dis, pst_sw_dis) \
> -	((smu)->ppt_funcs->store_cc6_data ? (smu)->ppt_funcs->store_cc6_data((smu), (st), (cc6_dis), (pst_dis), (pst_sw_dis)) : 0)
> -
> -#define smu_get_dal_power_level(smu, clocks) \
> -	((smu)->ppt_funcs->get_dal_power_level ? (smu)->ppt_funcs->get_dal_power_level((smu), (clocks)) : 0)
> -#define smu_get_perf_level(smu, designation, level) \
> -	((smu)->ppt_funcs->get_perf_level ? (smu)->ppt_funcs->get_perf_level((smu), (designation), (level)) : 0)
> -#define smu_get_current_shallow_sleep_clocks(smu, clocks) \
> -	((smu)->ppt_funcs->get_current_shallow_sleep_clocks ? (smu)->ppt_funcs->get_current_shallow_sleep_clocks((smu), (clocks)) : 0)
> -
> -#define smu_dpm_set_vcn_enable(smu, enable) \
> -	((smu)->ppt_funcs->dpm_set_vcn_enable ? (smu)->ppt_funcs->dpm_set_vcn_enable((smu), (enable)) : 0)
> -#define smu_dpm_set_jpeg_enable(smu, enable) \
> -	((smu)->ppt_funcs->dpm_set_jpeg_enable ? (smu)->ppt_funcs->dpm_set_jpeg_enable((smu), (enable)) : 0)
> -
> -#define smu_set_watermarks_table(smu, tab, clock_ranges) \
> -	((smu)->ppt_funcs->set_watermarks_table ? (smu)->ppt_funcs->set_watermarks_table((smu), (tab), (clock_ranges)) : 0)
> -#define smu_get_current_clk_freq_by_table(smu, clk_type, value) \
> -	((smu)->ppt_funcs->get_current_clk_freq_by_table ? (smu)->ppt_funcs->get_current_clk_freq_by_table((smu), (clk_type), (value)) : 0)
> -#define smu_thermal_temperature_range_update(smu, range, rw) \
> -	((smu)->ppt_funcs->thermal_temperature_range_update? (smu)->ppt_funcs->thermal_temperature_range_update((smu), (range), (rw)) : 0)
> -#define smu_get_thermal_temperature_range(smu, range) \
> -	((smu)->ppt_funcs->get_thermal_temperature_range? (smu)->ppt_funcs->get_thermal_temperature_range((smu), (range)) : 0)
> -#define smu_register_irq_handler(smu) \
> -	((smu)->ppt_funcs->register_irq_handler ? (smu)->ppt_funcs->register_irq_handler(smu) : 0)
> -
> -#define smu_get_dpm_ultimate_freq(smu, param, min, max) \
> -		((smu)->ppt_funcs->get_dpm_ultimate_freq ? (smu)->ppt_funcs->get_dpm_ultimate_freq((smu), (param), (min), (max)) : 0)
> -
> -#define smu_asic_set_performance_level(smu, level) \
> -	((smu)->ppt_funcs->set_performance_level? (smu)->ppt_funcs->set_performance_level((smu), (level)) : -EINVAL);
> -#define smu_dump_pptable(smu) \
> -	((smu)->ppt_funcs->dump_pptable ? (smu)->ppt_funcs->dump_pptable((smu)) : 0)
> -#define smu_get_dpm_clk_limited(smu, clk_type, dpm_level, freq) \
> -		((smu)->ppt_funcs->get_dpm_clk_limited ? (smu)->ppt_funcs->get_dpm_clk_limited((smu), (clk_type), (dpm_level), (freq)) : -EINVAL)
> -
> -#define smu_set_soft_freq_limited_range(smu, clk_type, min, max) \
> -		((smu)->ppt_funcs->set_soft_freq_limited_range ? (smu)->ppt_funcs->set_soft_freq_limited_range((smu), (clk_type), (min), (max)) : -EINVAL)
> -
> -#define smu_override_pcie_parameters(smu) \
> -		((smu)->ppt_funcs->override_pcie_parameters ? (smu)->ppt_funcs->override_pcie_parameters((smu)) : 0)
> -
> -#define smu_update_pcie_parameters(smu, pcie_gen_cap, pcie_width_cap) \
> -		((smu)->ppt_funcs->update_pcie_parameters ? (smu)->ppt_funcs->update_pcie_parameters((smu), (pcie_gen_cap), (pcie_width_cap)) : 0)
> -
> -#define smu_set_thermal_range(smu, range) \
> -		((smu)->ppt_funcs->set_thermal_range ? (smu)->ppt_funcs->set_thermal_range((smu), (range)) : 0)
> -
> -#define smu_disable_umc_cdr_12gbps_workaround(smu) \
> -	((smu)->ppt_funcs->disable_umc_cdr_12gbps_workaround ? (smu)->ppt_funcs->disable_umc_cdr_12gbps_workaround((smu)) : 0)
> -
> -#define smu_set_power_source(smu, power_src) \
> -	((smu)->ppt_funcs->set_power_source ? (smu)->ppt_funcs->set_power_source((smu), (power_src)) : 0)
> -
> -#define smu_i2c_eeprom_init(smu, control) \
> -		((smu)->ppt_funcs->i2c_eeprom_init ? (smu)->ppt_funcs->i2c_eeprom_init((smu), (control)) : 0)
> -#define smu_i2c_eeprom_fini(smu, control) \
> -		((smu)->ppt_funcs->i2c_eeprom_fini ? (smu)->ppt_funcs->i2c_eeprom_fini((smu), (control)) : 0)
> -#define smu_get_unique_id(smu) \
> -		((smu)->ppt_funcs->get_unique_id ? (smu)->ppt_funcs->get_unique_id((smu)) : 0)
> -
> -#define smu_log_thermal_throttling(smu) \
> -		((smu)->ppt_funcs->log_thermal_throttling_event ? (smu)->ppt_funcs->log_thermal_throttling_event((smu)) : 0)
> -
> -#define smu_get_asic_power_limits(smu) \
> -		((smu)->ppt_funcs->get_power_limit ? (smu)->ppt_funcs->get_power_limit((smu)) : 0)
> +	smu_ppt_funcs(get_profiling_clk_mask, 0, smu, level, sclk_mask, mclk_mask, soc_mask)
>  
>  #endif
> -- 
> 2.17.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cray.huang%40amd.com%7C864b90ae5a4b4754a1e208d811e03af0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637279002062073696&amp;sdata=Ul%2FjXV%2BJx%2FHEjHn53Q%2B5VDOnvVu7z6QtOoSkrRczro4%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
