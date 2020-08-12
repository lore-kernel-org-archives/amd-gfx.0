Return-Path: <SRS0=Jh+1=BW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B74C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 06:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBB7C206C3
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 06:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jqL+WnlN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB7C206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7851B89CD9;
	Wed, 12 Aug 2020 06:05:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4244589CD9
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2020 06:05:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DL39UKUiVyaJBjpIEYL6/iN3937GlOqYLWzyNqk4iE6e0NMsic2QFWcG6zw+OsTtcWB0kCpqsk994JpAZABQ2JuQoWo1/CuXIgFjK6Kg9Cnb0DTN1N5MH3ZckEzee1BsiM0967KYwtvcI2s9HvEe5/E7dbK3F1TMU9mR45qYzVf/i8mrBsLGaaolNALXPSrVuM50JUCHTQwxyvDH/iWdKS/4CzEi+sPL+hXYMuuV/vVXxDnL4USMSxIC/DzhRybMtaxzJnoHp5dBu+zfoO6PGbcRsDTUFt7GcW4xJLaLyTVsE1EHpx3qG1SJZYNT2z4vnHdwObuMpZptoNKzo/zmsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6RR3Eg7h382elqFiaPDUDdOX5MBP6skQVAR1a/FE8A=;
 b=SRoZsw5Gjn8EQg3M1D8a1U1TPMuT2RGDLSRr/vYi4g7G6HovDIe2xxGiAkAG02l66ZNRzuKnJGKi5TWFnDirG/HjZkHD3UliDPmrKgqkJmcx/p+bs1U5mLZkvtdMugLIRQv91ADccGWXWHwaN0e+71J8l9tFPZcvhmlNDjFbfAED09dwh0Qd6mGGwnuMV1bfdNHNcRyXpnIepClkskWIhlcrczHheNtfmn+XzRx/9kExXL72jeolWPBUpKY0s/g4qnhta9SYkm1/wj/1PWq/4TkD8q99KfyXSsptgD+UrsNtCkV3gSpoSC+/JS6+owy/kC0cC3zl2ffWrHVs5+ucsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6RR3Eg7h382elqFiaPDUDdOX5MBP6skQVAR1a/FE8A=;
 b=jqL+WnlNC3CRjQSgoxEzvZqpCO0h9JNkMj7ki1erMfjIhui5nZ/vAvt0ySc/VKLKljFz3Ky6hwuTB1blq/7ADRdwp37WylwUWwHIa0LLo2IrIlBVEX5qOPJWgA9dXJg61tRRsrfnFKW4IeFrEyCFyaZ3OuOMq+C8XYWdxgGhgGU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Wed, 12 Aug
 2020 06:05:51 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d%4]) with mapi id 15.20.3261.024; Wed, 12 Aug 2020
 06:05:51 +0000
Subject: Re: [PATCH 3/4] drm/amd/powerplay: enable Navi1X mgpu fan boost
 feature
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200812045647.20541-1-evan.quan@amd.com>
 <20200812045647.20541-3-evan.quan@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <c7c65f6c-aca0-be33-7f73-23c172bb565e@amd.com>
Date: Wed, 12 Aug 2020 08:09:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200812045647.20541-3-evan.quan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR16CA0037.namprd16.prod.outlook.com
 (2603:10b6:405:14::23) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.4.236] (165.204.84.11) by
 BN6PR16CA0037.namprd16.prod.outlook.com (2603:10b6:405:14::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Wed, 12 Aug 2020 06:05:50 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2b762730-bdc4-4620-a620-08d83e85c3bd
X-MS-TrafficTypeDiagnostic: DM6PR12MB4401:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44017523DF06F879C77C27C48B420@DM6PR12MB4401.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2jQjvEVTh3y31FloliS3yb2zRFFlvBdO9xV23VUQyR3pMYXJxM+F6hIs+AV7ZwLfOqZVqD6XAdLOwimQQTmSevhsdfHhU3T3nQ1ChreWhuKsLfwAI5nvx7qTxy17yA5u9JObx4cMQa/L9YtFnJhEq6qobkf902I2TpTLnQIjvNl1kMbtbNIa7fPP4dn1uLU+DPneyXBS5pKKYT7mD8N7EV6rll2K+nOjaaxvyzrZb1QG2x9qBNmAX1QQj7s4184cyi7LEd0gSCwe+6Ik1JbgeZ7WBHSB6DdPq4gmReqMiYAYj8RolUCi/W3ZyJuC18pFepGOs1ilfVTzmWsa5SEM5ICP2RCq9xgeNuV8R/PUKUXe5bJZaiAyqBOq4XHiKZc+YQQBQgnRcN/L3uFQVG5wnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(478600001)(6486002)(4326008)(52116002)(316002)(186003)(16526019)(16576012)(5660300002)(31686004)(83380400001)(53546011)(2906002)(2616005)(8676002)(956004)(8936002)(66946007)(66556008)(6666004)(66476007)(26005)(31696002)(36756003)(32563001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: lwXleNXadfZnm/xK9kYXaUP0+/6jdIW/+c1YgakOVcqA1tVKyk2wu/poSSQAFSoenVjlQQY3UhzDyqP0Z+ISwsemvbaR5tCQb7gu0kZzVOnmdAP4blZqwsiS/z/pg8Dht2Fo17GpH7zq2hIcOBGdiF7gf3ly/SeNUW1m8SBibBVP9/QB2c5vSS+RSleHjjYpOOkpAC44m8MhuCiUKpun2083cyF2FtH0worrsZ6b71yho3MVy8SCxgjPSH3NSQznxnU39WIRN6zNRxXOA7kFHyV/UDFZ+I5U537eXLm0EgC3TM3oH5x6LIP2izbuYz353mdoUkI5IZDUNE5BIuISOCiz8Ojfm5WvmZisWtlXmIxx+kCCUBCfR+bMp0wJ+UQAGgxnBJ3VQrRO0kcMsusxRavMriOocuGHy2CEgWsZuckC7/3ILI0/3w3wCbhFRLE+SiVACUBJIOlYur3xa9BAQ/rWXfhA1Qg+rdnsh/fSnqi/HmOls8Htu/siE0TTT22U2KbYSdbarLgXijrFOT9XHVw4MtWV0ekphhVAvNtCWVVxeR6Cdy0zCckb1OaizggAJ9lwcoBqLrhhU3Vzt5xIq7vK5btRBsNtv0pLGZHxVAT9xzL3H1eRWWyVlobj5Z1/+1CT9xLYsJavF4vDAGq7Xg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b762730-bdc4-4620-a620-08d83e85c3bd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 06:05:51.0222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1Nv8i+uNf27SrNWpYrfsoJyhmmrzo55A+5NUZCezulxAPvbYDnwG/ELZuX2SRXmcNGnCnTutR6h8DqME6psGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4401
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
Cc: alexander.deucher@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 8/12/20 6:56 AM, Evan Quan wrote:
> Support Navi1X mgpu fan boost enablement.
>
> Change-Id: Iafbf07c56462120d2db578b6af45dd7f985a4cc1
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>   .../drm/amd/powerplay/inc/smu_v11_0_ppsmc.h   |  4 +++-
>   drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 21 +++++++++++++++++++
>   2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_ppsmc.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_ppsmc.h
> index 406bfd187ce8..fa0174dc7e0e 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_ppsmc.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_ppsmc.h
> @@ -123,7 +123,9 @@
>   #define PPSMC_MSG_DALDisableDummyPstateChange    0x49
>   #define PPSMC_MSG_DALEnableDummyPstateChange     0x4A
>   
> -#define PPSMC_Message_Count                      0x4B
> +#define PPSMC_MSG_SetMGpuFanBoostLimitRpm        0x4C
> +
> +#define PPSMC_Message_Count                      0x4D
>   
>   typedef uint32_t PPSMC_Result;
>   typedef uint32_t PPSMC_Msg;
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index 61e2971be9f3..a86cd819b44b 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -138,6 +138,7 @@ static struct cmn2asic_msg_mapping navi10_message_map[SMU_MSG_MAX_COUNT] = {
>   	MSG_MAP(DAL_ENABLE_DUMMY_PSTATE_CHANGE,	PPSMC_MSG_DALEnableDummyPstateChange,	0),
>   	MSG_MAP(GetVoltageByDpm,		PPSMC_MSG_GetVoltageByDpm,		0),
>   	MSG_MAP(GetVoltageByDpmOverdrive,	PPSMC_MSG_GetVoltageByDpmOverdrive,	0),
> +	MSG_MAP(SetMGpuFanBoostLimitRpm,	PPSMC_MSG_SetMGpuFanBoostLimitRpm,	0),
>   };
>   
>   static struct cmn2asic_mapping navi10_clk_map[SMU_CLK_COUNT] = {
> @@ -2555,6 +2556,25 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
>   	return sizeof(struct gpu_metrics_v1_0);
>   }
>   
> +static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)
> +{
> +	struct amdgpu_device *adev = smu->adev;
> +	uint32_t param = 0;
> +
> +	/* Navi12 does not support this */
> +	if (adev->asic_type == CHIP_NAVI12)
> +		return 0;
> +
> +	if (adev->pdev->device == 0x7312 &&
> +	    adev->external_rev_id == 0)
> +		param = 0xD188;


Can you please add a comment explaining above condition?

Apart from that, the series is Acked-by: Nirmoy Das <nirmoy.das@amd.com>


> +
> +	return smu_cmn_send_smc_msg_with_param(smu,
> +					       SMU_MSG_SetMGpuFanBoostLimitRpm,
> +					       param,
> +					       NULL);
> +}
> +
>   static const struct pptable_funcs navi10_ppt_funcs = {
>   	.get_allowed_feature_mask = navi10_get_allowed_feature_mask,
>   	.set_default_dpm_table = navi10_set_default_dpm_table,
> @@ -2636,6 +2656,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
>   	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
>   	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
>   	.get_gpu_metrics = navi10_get_gpu_metrics,
> +	.enable_mgpu_fan_boost = navi10_enable_mgpu_fan_boost,
>   };
>   
>   void navi10_set_ppt_funcs(struct smu_context *smu)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
