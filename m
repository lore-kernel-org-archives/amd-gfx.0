Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB058C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 06:05:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A035660C3F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 06:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A035660C3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 303B86E171;
	Thu, 12 Aug 2021 06:05:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF65E6E171
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 06:05:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbS4bRdyJLHM795ia8mPlzg2IRL7TmIf318eLOuS6ssMxAPs1JEvKw/bMNUWAE/HNv+ak7xsxIKtXH9wIdIJJumIm6zHZDYcga7jhQqIoLAaXeL0t7IFsrB22O/660aJVH4RsSFa+evvpN88WpamABJGkTAnEstxbAM699kQiylnD2dz7BlNHJF8QQ/ACp/T1O2aZ0wffuz7i+efBMstIzonSW+8XGwqBi/T3O27FRoChFlzhGO51zj3m7EDW6ZEYYI55FBGO3PqYLPJVUHbq5jJQwN9mIbeJwzmp8U8HL05xc0lqU8umJ6HhfgYZ0bfYgIRYSMrnSKYoQBEhUHiNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35t45RgCTAvF3gplD9oRoD3qgPfKUNSyYj4TaHtSabM=;
 b=lmjRERGcC7mEcvkFcXzSxDoUdYPD82DxPU9vlV5L7524KxWx0Ab24hjynG4zX/Ex8H5HPNlMORgIFzqzCK4txn19LsTsQC5v7ZMcN4QxQDqtFeDu01Q/ftwE5ZHXq50TpvEdFpwTPy+UL4QFdQ3Ozl68yHwVHmtpAHrc8IplV9qKdyQz/VMk/Unx13Xgss8r3TK6vmhVhjs5/VumC/NRozCzzI3r5JjqZ5LXLewdz6dJ07pS+qEqaDvH/v4nEj8w51/OWxLhroguM0AyMMei3vtcTtHPkR+yBs5G3DuRMeMF6FjhThG/iDR/OQvnFwDMHuEPqRB8ZTgFZ7l4jlTHiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35t45RgCTAvF3gplD9oRoD3qgPfKUNSyYj4TaHtSabM=;
 b=IGVGXjVFK8LriHSOJYThQpqvniAAiJr/P7YUoxj13Kc33+SwBKIGJ5Rb4Q+2qEWkIhaTLH+JCQ0h7dBR3BShNYuSJTYvCNmEY84pIZi5F40sny5mwmwLOYfu0pH+sSGpYYyKZFDuRerM681qUMz38S2JbfTkyM2DlWlhAYjjTL4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23)
 by BN9PR12MB5367.namprd12.prod.outlook.com (2603:10b6:408:104::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 12 Aug
 2021 06:05:26 +0000
Received: from BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::4804:801b:71a:a8ed]) by BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::4804:801b:71a:a8ed%9]) with mapi id 15.20.4415.017; Thu, 12 Aug 2021
 06:05:26 +0000
Subject: Re: [PATCH V2 2/7] drm/amd/pm: record the RPM and PWM based fan speed
 settings
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: nils.wallmenius@gmail.com, Guchun.Chen@amd.com
References: <20210812040110.1293682-1-evan.quan@amd.com>
 <20210812040110.1293682-2-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <f63b688e-81bd-a6a7-4a27-f1d3140559bc@amd.com>
Date: Thu, 12 Aug 2021 11:35:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210812040110.1293682-2-evan.quan@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::26) To BN9PR12MB5356.namprd12.prod.outlook.com
 (2603:10b6:408:105::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN1PR0101CA0016.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend
 Transport; Thu, 12 Aug 2021 06:05:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3a91674-662c-4060-cbc3-08d95d572db9
X-MS-TrafficTypeDiagnostic: BN9PR12MB5367:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB53676A022874920FA0293F2097F99@BN9PR12MB5367.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gCj6Oj1HovQ0tmtkqoOJISjBY+bmqe9fKfCQ7ZPH8cc5HGz7J5ECzr0YMbZePSzyH9KTcZUCbf1mCeOrtFb+bU8Lqib19In6YUX92/ihmWMMW5RxZCZoh2aCVstsKQMNBU4cTFExsaFvVFn13KvUvPWx5RviPg+gbSMmxMAgZ7ijcW+ez0ibrD4MQW2+GZbtV/MCFFViokn09oUYtU9Kjzljn2j0g2Iia3dBXZFcVk7FNT1c3lJlDb211gGqPPPoua8kOKku8dkhpdrOe0ZxyR/d+0w2AUOB2e9gI2GdsfLICbh/5LU7S3eiRBSMjunSf3UX/VKfhZzSPNsdqmjnUELjIyJGLWs5BgecCApIKRF8deVVubhQkgFcpmRmJ2D/avhHod4BulVij+7waLEJxGqRjkmjrG4z9y15VjriVtWWdGtZCYTAMkKfgX9W+IRrUbTzXHSzdlC8SZCaXHlF+KScVHyyL8RksIZdprD8CzEFLjUPM+NWMQvhpy8fZV1dPGG64SGGMqrVuz+1fwUeZndM/xfTCb/XlwtkgbOUhNiKdKxJiiBhOUOutbtoSIW66j29DzjYREGAj5BoQrRenewyYwd+ODLa/+F4y/Ms0/82VN8U4SC2migp1726QnNzrB1OerGubscKkNn4qg0m4GezEseAlHKNd/G/xu9UuCEdk/47C0x96TGiYIJx2rOty+ZJOkVVe6maF3coCfrRQrwd8Qe3vpGZq1lVaFUmEbc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(6486002)(31696002)(83380400001)(31686004)(5660300002)(66946007)(86362001)(66556008)(66476007)(16576012)(316002)(38100700002)(956004)(2616005)(53546011)(186003)(2906002)(26005)(36756003)(478600001)(4326008)(6666004)(8936002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aklWMThWNHhEYk9RVE11cWVCK25rdUxYRXVlYnlZTUlFRDlEVGVOR3JCN21t?=
 =?utf-8?B?ZkhmNUF3Ums5Uyt6YXdhVUtldy91QTg0QWNQRG56VDJhK05tNTdERVZ6aFJv?=
 =?utf-8?B?MHZMWnI4RUJHN01CbDlNdGdsa2VDOE55L2pPSkNQMEpkRDdEMk1MYzdObENq?=
 =?utf-8?B?R0RYMzEweFhWYWF2b1dDSno2Snc5L2h1dDA2VlRRb0lwM2lpYWJibkVuRjR1?=
 =?utf-8?B?aUZPeC9SKzNxOEtTbFRBZnNsOUJ1bC90YlNoZ1paWDBCcUtjSzhETG1wejg1?=
 =?utf-8?B?M29zNmJDT0tQK01zRHJ1NFJobjY1Y0d2ajAvRHR4T24za2VORGhTT3VVOU5w?=
 =?utf-8?B?V0k4TS9WWm05NnRpWDR3Q1g5aDRVdmZweDIxQytTUUYxRU1MdTVoTnExV0tJ?=
 =?utf-8?B?bTNRZXZLd3Q2R256MDZLZ1pYS0JnRUg0RVVqT2pjN0dBWW5Ockk0dGI3QUN0?=
 =?utf-8?B?SGxmaFQ5blp3RlliS1Z0NzNja0hUWjhJeVhQRm8vU3ZYTWhFY0tubWJrK0JX?=
 =?utf-8?B?OEtyRFBnTHpZek1iRVNFWmFKZXlSbURLN3BMOE5WQmRib1ZvREhBKzlYbUI2?=
 =?utf-8?B?V2x0S210T0RTNGZBSnRwbGc2dURHSGJrWlUyRm4yVjJDQ0cySm1oOHRGRC81?=
 =?utf-8?B?NFJVa1lRRXhkS2toclEyMW5QenRwQ0U0R0J1cVRLcU5GcmlldGI2NkhvM1hQ?=
 =?utf-8?B?WFhKTVhBdE96bE5hUS84aHozZmN3MnBiczJyQisyeVk1a1FkaW0wQzF3aEQ1?=
 =?utf-8?B?cWNKQ2lYclAwNHNycTBJazUrZFpOL0FtR2FPTDVVUmxiV0pIK3hjMDJGRitj?=
 =?utf-8?B?QWdLWDhUUWNkVVBva2Foc1V6ck5laU9pQzNmV1gzVXY3bksxdmFOdHJSazRm?=
 =?utf-8?B?b1FqaDBVTXZlbDVERGNMWm44c0hFTHE1ak9GL2RFb3JqZEI5ZVR4SmtXNWRa?=
 =?utf-8?B?b09ISjlKSDE0SkFCdGhBQnFRUm12SXMzOERHcXNFWjlIcmxrZmNaTVJKZDRN?=
 =?utf-8?B?Z0Q5NmpoVm9rQytMQlpGVWsvdnFMZVdhejNydG5yalRveENxdlBLeGhkaFlO?=
 =?utf-8?B?T3M5VGUvcUZWSHJzd0lRb2ROMzFlclIxdnIwK1BRcmdaT1NLejlDQXFKa3Vs?=
 =?utf-8?B?U3M5OXM5VGlxZkcwQ01JL01YS0s0ejg1UDhFRlM0dG9wRGtKdEdpQ29PQkht?=
 =?utf-8?B?M2VKazdza21vRkJNQ25tU0pkd21ZOFpYSThRV2FOUVZQL2MyMXlnL2hHQ1BJ?=
 =?utf-8?B?OU9pcmpxVnZmMlBPdDBtWStmdzBTM1Vnd1Y1WUZQY3BXQ1FXLzVlV2o0QjY0?=
 =?utf-8?B?VnNwM3BTNDA5ZkRBdnZ6d3J0R2JNNkhlazdNbE80K0xHZFUvczRVZ2lVamdC?=
 =?utf-8?B?MG5xUmMxS0RYeWpqZU9XVGJOd0RibHJGbUpRSGg2RkxsdWhMWFJTaEJqa2lG?=
 =?utf-8?B?QnRqSXgwNi9CSDBNaEo4RUlxM0xJNVZPWWFGb1JYZzNmdUFsZ1l1QmdLVU5X?=
 =?utf-8?B?S1drSXkrQnBVSmhQMjNWajYvd1NyYkRaWUhGV1llWlllYUgydUxZS1RpOWlq?=
 =?utf-8?B?MjVNU3FBaVI4RktpVEJtQWlKNTg1cDFvY1VzdGVIZVVXMUl0K2FPdzY5Z1Z6?=
 =?utf-8?B?SS9oTFQrNmpibVgxVEhHZ1JoWFpEeVBQTThwTjZMck1qeitLMGVOK1RRVzhx?=
 =?utf-8?B?b2s4Z0Jqc3NkaFphK2ZaM3lvSTJWZE1oaEpUMzhLbUN4c0FnOXloMFZiTmZE?=
 =?utf-8?Q?T5QPqWuNiNE3anKht+EASjaz5+3Wux05ESDJyCB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a91674-662c-4060-cbc3-08d95d572db9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 06:05:26.3963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /F1rWWoYas0swMOUkxcVUAwgZZ3E1HwFSKCCkyU4QMdg8W9lArx+QacDLdyD339N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5367
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 8/12/2021 9:31 AM, Evan Quan wrote:
> As the relationship "PWM = RPM / smu->fan_max_rpm" between fan speed
> PWM and RPM is not true for SMU11 ASICs. So, both the RPM and PWM
> settings need to be saved.
> 
> Change-Id: I318c134d442273d518b805339cdf383e151b935d
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> --
> v1->v2:
>    - coding style and logging prints optimization (Guchun)
>    - reuse existing flags (Lijo)
> ---
>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  3 +++
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 22 ++++++++++++++++------
>   2 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index 183654f8b564..29934a5af44e 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -34,6 +34,8 @@
>   #define SMU_FW_NAME_LEN			0x24
>   
>   #define SMU_DPM_USER_PROFILE_RESTORE (1 << 0)
> +#define SMU_CUSTOM_FAN_SPEED_RPM     (1 << 1)
> +#define SMU_CUSTOM_FAN_SPEED_PWM     (1 << 2)
>   
>   // Power Throttlers
>   #define SMU_THROTTLER_PPT0_BIT			0
> @@ -230,6 +232,7 @@ struct smu_user_dpm_profile {
>   	uint32_t fan_mode;
>   	uint32_t power_limit;
>   	uint32_t fan_speed_percent;
> +	uint32_t fan_speed_rpm;
>   	uint32_t flags;
>   	uint32_t user_od;
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index e33e67310030..131ad0dfefbe 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -413,7 +413,13 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
>   		if (!ret && smu->user_dpm_profile.fan_speed_percent) {
>   			ret = smu_set_fan_speed_percent(smu, smu->user_dpm_profile.fan_speed_percent);
>   			if (ret)
> -				dev_err(smu->adev->dev, "Failed to set manual fan speed\n");
> +				dev_err(smu->adev->dev, "Failed to set manual fan speed in percent\n");
> +		}
> +
> +		if (!ret && smu->user_dpm_profile.fan_speed_rpm) {
> +			ret = smu_set_fan_speed_rpm(smu, smu->user_dpm_profile.fan_speed_rpm);
> +			if (ret)
> +				dev_err(smu->adev->dev, "Failed to set manual fan speed in rpm\n");
>   		}
>   	}
>   
> @@ -2179,7 +2185,6 @@ static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled)
>   static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
>   {
>   	struct smu_context *smu = handle;
> -	u32 percent;
>   	int ret = 0;
>   
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
> @@ -2190,8 +2195,8 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
>   	if (smu->ppt_funcs->set_fan_speed_rpm) {
>   		ret = smu->ppt_funcs->set_fan_speed_rpm(smu, speed);
>   		if (!ret && smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE) {
> -			percent = speed * 100 / smu->fan_max_rpm;
> -			smu->user_dpm_profile.fan_speed_percent = percent;
> +			smu->user_dpm_profile.flags |= SMU_CUSTOM_FAN_SPEED_RPM;
> +			smu->user_dpm_profile.fan_speed_rpm = speed;

Sorry, missed this when you posted v1. Either RPM or PWM mode is allowed 
at a time, is that right? If so, shall we make the pwm to 0 and reset 
PWM flag when RPM is set and vice versa? This helps during restore where 
one is not overwritten with the other.

Thanks,
Lijo

>   		}
>   	}
>   
> @@ -2552,8 +2557,11 @@ static int smu_set_fan_control_mode(struct smu_context *smu, int value)
>   
>   	/* reset user dpm fan speed */
>   	if (!ret && value != AMD_FAN_CTRL_MANUAL &&
> -			!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
> +			!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
>   		smu->user_dpm_profile.fan_speed_percent = 0;
> +		smu->user_dpm_profile.fan_speed_rpm = 0;
> +		smu->user_dpm_profile.flags &= ~(SMU_CUSTOM_FAN_SPEED_RPM | SMU_CUSTOM_FAN_SPEED_PWM);
> +	}
>   
>   	return ret;
>   }
> @@ -2604,8 +2612,10 @@ static int smu_set_fan_speed_percent(void *handle, u32 speed)
>   		if (speed > 100)
>   			speed = 100;
>   		ret = smu->ppt_funcs->set_fan_speed_percent(smu, speed);
> -		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
> +		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
> +			smu->user_dpm_profile.flags |= SMU_CUSTOM_FAN_SPEED_PWM;
>   			smu->user_dpm_profile.fan_speed_percent = speed;
> +		}
>   	}
>   
>   	mutex_unlock(&smu->mutex);
> 
