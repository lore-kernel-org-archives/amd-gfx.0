Return-Path: <SRS0=5bFg=L7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2B2C07E95
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 08:53:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5717161CBE
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 08:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5717161CBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 070506E84F;
	Wed,  7 Jul 2021 08:53:38 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2077.outbound.protection.outlook.com [40.107.212.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 486BB6E84F
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jul 2021 08:53:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PL4xop9W242J9BxYyoJ0uF3IFyKNuLzr/Nf7CBhlwjy7BqTBXiraS9jz2E6AX3LZZYPGrTW9COBe4NZPtN7ModgIOxj4Fft6UOBv3mprh+r91K6R9tqYDhqDN82miUX4ZxQ/U/eoHCN+6BfBvaMO9QOvipp/FNpkPS0XDqWCLGWemwNfIdPuYl9Y3DxFLibO4gUn+z2qxYcJPGLtxAA+7R8MRB9B3hb/8oTTh2jv0ea3Up3jV5u0B0EyOIGkyTFOctfsDEMLzWgsZHyqXIldsVVM/hXLmI43EIgul4zArG85HyKPjfxPOXTHm21S586o1P07WM+h71Nz88J5ilkzjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZMHPpG4G+LAotoLoS13o0cMpViz+NmUyCc/f5FhrFc=;
 b=Xc/PfDk4PXmKpL9N4IqNx48tNKbeLjudKPPJl2DFn3PULzjdjone+RQCr9BPi6LNCG7XwW8nBqAat8i4JBEq/+cOR3wyMPHl68p0Oanl+Ouaf9mCxbnkriYbsJosXiTwAyQ9VaFlTS+1Y/5/3l95i1TcuepKAum+mdlPbuHI0vLq+OQl1YVZ5o/CQ3UMLQ9XO+SyhYBfEMSU8ZtjbGk8u49UrG/LGC/Nz8uW0u3PVCYQscP6/23zH+fSNkt4yLlLbkDbJDwOGEOXa8bpwU/6KRkAT1ba83qpXfiPCkWCM3+u4sEOtORAQMyK2FgVMeL7XkeX7l2PeVsZ3a3YC5Icyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZMHPpG4G+LAotoLoS13o0cMpViz+NmUyCc/f5FhrFc=;
 b=R5wROYFWtqeNghTbPJq7ySyyEk+FwWTujGZYfgqt1tInPPmWVWqr1IogWd1Ry7c+2y2hJjWjiv3JrjeeKt7VADtVauId7cw4QhqwIjTv54guvLaRfWeIJwMgSVH05PwJJNPzBQhlWpXDgiR+MkvCqjSTEWSq8pAYimoLkINNl1I=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5316.namprd12.prod.outlook.com (2603:10b6:610:d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 08:53:35 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068%9]) with mapi id 15.20.4308.021; Wed, 7 Jul 2021
 08:53:35 +0000
Subject: Re: [PATCH 2/7] drm/amd/pm: record the RPM and PWM based fan speed
 settings
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210707015647.139127-1-evan.quan@amd.com>
 <20210707015647.139127-2-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <c7951185-d2f3-df94-e977-a0a632894ddf@amd.com>
Date: Wed, 7 Jul 2021 14:23:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210707015647.139127-2-evan.quan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: SG3P274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::24)
 To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 SG3P274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 08:53:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 752b6a4d-0cda-4fba-cb22-08d94124b489
X-MS-TrafficTypeDiagnostic: CH0PR12MB5316:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB5316424BE1736926D93A1BD2971A9@CH0PR12MB5316.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZDJJ7yz8xBQo7lHbmG4M1IxJJ2EhlSWh238plxVQCsCd2BAVdeLr/uTkcOkMg7DmPbZJ3WBw/w/b+r2Fq47GRA/YZu46Hu8TNBAajWJVJYVxah6c59C9f7aNmC/RclcUIovWPZfDrocCI2sxDCn7RRdk6ldtcbQ1UjZja5q8nZaVN29M2pkgwnfgq67xz9d7g2OkvCAuNsOfugV+qwc6ojFdYRXo3feSvDTHspZcpMC9wXGDuT/ghHwAikHlMqRdbjLG5/kMYR3FSqPWYsEMt9gdMP6R+R8xwPES/Wb71u4hLAQWPWiFepFi7itupJTetOehEpgmptRI8PviNZMvkhYsmtJjr/mLXhZKMPei8vWXNguyLZfhaorWKNpNhUFPK2H1n8hMMnNNqKgktql2+xa4seMGhMHmFEMLzMn4Wh3K4bEAZhx1LdkOe+yS4v6FXWdP/XcyyI3DUV1kfwRPp5zwGXEHr4nixXNxLpC6hHR438l1CbzmtQWg/xw00CbaOEMKYJ5MAXS3aeQNqRGilfsk7kTmryFQCCA6yIXu+3h4LRSc57g4+cbytEpHTFUDzTObzSbpSX9/Ci6OQhfLEhz1uHYtLIIA4MXz6jtA7n7H0EqPlHvzsaEtC+uEbucBvHUT15cd2NpQM/MjnHPd8EDultH5j33fEUfhcCopk7gOI4jGsPIWHRCsHUXDdy1a4BU+RkvkqsqLQ7OjkfPbLD66k9v0A3NX6NKCcAssRjw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(66476007)(36756003)(6666004)(53546011)(83380400001)(2906002)(66946007)(8936002)(8676002)(956004)(31686004)(6486002)(316002)(2616005)(26005)(16576012)(186003)(86362001)(4326008)(31696002)(5660300002)(66556008)(478600001)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVFzMVlLRVlYM09hNUJnekZ6SEdaLy9uUFcrWkVZYVAyR3pnWHY2MWdnWmFt?=
 =?utf-8?B?OU13WjlqeHB2dnVDUTBxdTJWZnU3YjlZQWFTODluWnNPZnBaVU5zQ0s2L3Yr?=
 =?utf-8?B?Z2UyVUpiZFZMTVEra1ZtR1hVd0lrbHFpLzczRTRZSlZIVmNkQTY4c1kzd1A0?=
 =?utf-8?B?T2Ricjk2S3YrZGdSN3FWQkJrZ3UwMnhpQ2JROHBsdGFnd3Vab2djRWM3L2Ji?=
 =?utf-8?B?M1lyV2Ztc2pMbEdMS3d5RmxDVzVoOUJCUzdYT0ZsdXlFeGtvU1Q2NTdBcWV1?=
 =?utf-8?B?YXI1TERvRkF4M3duUG5NZ2N0NWs0TGRJNzBId2Q2ZFJGbWoyaGZneGFSODdZ?=
 =?utf-8?B?aWEyTmtyLzFLM3BVVU5QVzhGTnozWnJwQml0SXhuSEVBZUdGdDRxdTBtZGlu?=
 =?utf-8?B?MmlFSStwNUoxZ1BNNGc1cTVYVFhnNDlVZUk2UjluUWYwNElXMnBYWXBlU1VT?=
 =?utf-8?B?cHIvM2YxYWpiOW5qNjJDOGZzOGNXV2lXSklVV0JOSDRYaFRXVjVJOGJJdTg5?=
 =?utf-8?B?dzFrU3VkZGpvcFR4RE1lVHVXUW5UOXNHNzhlKzZyelBZU0RmWHkvRlRrTmNH?=
 =?utf-8?B?VnRyclNXSlRVaDdqNHhKOUtVMWQ0eWJ2V1ErczVWczgwVlVDalJmaHRVRzY0?=
 =?utf-8?B?NXlEQXFScGg4L0ZZNUJvVGJ1dTh3OExRNjdwM0FnNEozT1h2Vy9QcGVNcXRQ?=
 =?utf-8?B?Y29OcFhzM05iN2MxOTNvRnJJaHlnQzkzQ3NQZ2Y4VzB2MTJuTXVUWVRFL0Yx?=
 =?utf-8?B?eVMra0N0R2NDVG9vcUJxUE1hZ3g1TFZRTTZkUllDYVB6OCtpaXNEbnBvSTBN?=
 =?utf-8?B?STZ3SlczUEsvVms3eE1rQkJGWEd0a01LMmRCZXJrUkEvOE85azhEb3hoZlRa?=
 =?utf-8?B?bXRqSGpUMmZLMHBWWHRPeTl1RlhOcjltZExvL29IcDZkaU10b0ZlZXRzRk9Y?=
 =?utf-8?B?SjA4MENKRjN2R0FKV0RKRnNTY2JnUURvREJDR0dUL3FLOTZuOXFnZ0JNYmpC?=
 =?utf-8?B?SjJLWlVVbVNqaTF1cG9vQnVsdkx0Qk0rbnlhRS93T2lCM3RyOHd1NDRGZEJl?=
 =?utf-8?B?M3RpTjVjMUp0M1VOdUkrNEtGZHZkMkFtNHc4bkpIbXR3bnlTZktOQU83bWlp?=
 =?utf-8?B?cGgzSkl4TVpOQ3d1b3BGTTY0eEdUQ2RFUkl1YkQzRGFiaW5nZGdlNmpXVXVF?=
 =?utf-8?B?UGpBbGRTTURJNTFzaHVaS0lHVlpCeWE5OG9rYVdLeFBJZGNYbHM3eXB2OTZX?=
 =?utf-8?B?dEdKT0NoRHpDSmNqYW5jYzFla0JlL2o0VGNTdjJDaHdmUmxDVkRGRzBneHY3?=
 =?utf-8?B?dndBaEliTEk1WXVJOVowOXhsbldnZ0t2Qk9sVkt4VzZFRmJ3SVN2WUpLcGww?=
 =?utf-8?B?YUNHSEQrMGNrcVpZRFZlQlZaYTQvRXRrcDU0amlkeTU2L0xBb2hWcG4wUjhG?=
 =?utf-8?B?NnF5ZkFtNFVkU1dLS09hak80Q2ZoR1dPK0dLekU4TGlDOWowRjRDaXg4Ryth?=
 =?utf-8?B?WGp5Q2NnNXZXUVZuc0xoR3IvMm5HUDdhMTNLRDRiWktDcisrNTdxRmZ4YUJR?=
 =?utf-8?B?UzRsVlpnVWVRRWE2WEhiUDN4ZFRGZlhyMDd1cFFVUWZ3ZnBTcysxUHE2cmdp?=
 =?utf-8?B?NWdZR2dSekFRNW9ieHg4Q2NSeE5idVFPNUhwSzBsdlQ1TjVSQmZKQlhPYmU2?=
 =?utf-8?B?YTJhL0RFdTFKa0wrQWJmRTN1SVJPdXhNTEtzYThCSElMaEV5Ym9DUDdxa3dU?=
 =?utf-8?Q?pIqe2Y/e4uCTqLv+9gX45xhiYQzsY6n5Q/rL7nO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 752b6a4d-0cda-4fba-cb22-08d94124b489
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 08:53:35.6946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEfyDE1/IhBAUuML7d+9/lzxerwIsYKlcHPuNQFm6FIWAmwg/BxM+Lbd1H8CVF0g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5316
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
Cc: Alexander.Deucher@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/7/2021 7:26 AM, Evan Quan wrote:
> As the relationship "PWM = RPM / smu->fan_max_rpm" between fan speed
> PWM and RPM is not true for SMU11 ASICs. So, both the RPM and PWM
> settings need to be saved.
> 
> Change-Id: I318c134d442273d518b805339cdf383e151b935d
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  8 ++++++++
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 20 +++++++++++++++-----
>   2 files changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index 6301e4cb3c2a..fa585f0be530 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -226,10 +226,18 @@ enum smu_memory_pool_size
>       SMU_MEMORY_POOL_SIZE_2_GB   = 0x80000000,
>   };
>   
> +enum custom_fan_speed_mode
> +{
> +	SMU_CUSTOM_FAN_SPEED_RPM = 1 << 0,
> +	SMU_CUSTOM_FAN_SPEED_PWM = 1 << 1,
> +};
> +
>   struct smu_user_dpm_profile {
>   	uint32_t fan_mode;
>   	uint32_t power_limit;
> +	uint32_t custom_fan_speed;

Use the flags field to indicate if custom mode uses PWM or RPM, no need 
to have a separate field.

Thanks,
Lijo

>   	uint32_t fan_speed_percent;
> +	uint32_t fan_speed_rpm;
>   	uint32_t flags;
>   
>   	/* user clock state information */
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 576e9ea68fd1..9a25443988e3 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -414,6 +414,12 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
>   			if (ret)
>   				dev_err(smu->adev->dev, "Failed to set manual fan speed\n");
>   		}
> +
> +		if (!ret && smu->user_dpm_profile.fan_speed_rpm) {
> +			ret = smu_set_fan_speed_rpm(smu, smu->user_dpm_profile.fan_speed_rpm);
> +			if (ret)
> +				dev_err(smu->adev->dev, "Failed to set manual fan speed\n");
> +		}
>   	}
>   
>   	/* Disable restore flag */
> @@ -2166,7 +2172,6 @@ static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled)
>   static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
>   {
>   	struct smu_context *smu = handle;
> -	u32 percent;
>   	int ret = 0;
>   
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
> @@ -2177,8 +2182,8 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
>   	if (smu->ppt_funcs->set_fan_speed_rpm) {
>   		ret = smu->ppt_funcs->set_fan_speed_rpm(smu, speed);
>   		if (!ret && smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE) {
> -			percent = speed * 100 / smu->fan_max_rpm;
> -			smu->user_dpm_profile.fan_speed_percent = percent;
> +			smu->user_dpm_profile.custom_fan_speed |= SMU_CUSTOM_FAN_SPEED_RPM;
> +			smu->user_dpm_profile.fan_speed_rpm = speed;
>   		}
>   	}
>   
> @@ -2539,8 +2544,11 @@ static int smu_set_fan_control_mode(struct smu_context *smu, int value)
>   
>   	/* reset user dpm fan speed */
>   	if (!ret && value != AMD_FAN_CTRL_MANUAL &&
> -			!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
> +			!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
>   		smu->user_dpm_profile.fan_speed_percent = 0;
> +		smu->user_dpm_profile.fan_speed_rpm = 0;
> +		smu->user_dpm_profile.custom_fan_speed = 0;
> +	}
>   
>   	return ret;
>   }
> @@ -2591,8 +2599,10 @@ static int smu_set_fan_speed_percent(void *handle, u32 speed)
>   		if (speed > 100)
>   			speed = 100;
>   		ret = smu->ppt_funcs->set_fan_speed_percent(smu, speed);
> -		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
> +		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
> +			smu->user_dpm_profile.custom_fan_speed |= SMU_CUSTOM_FAN_SPEED_PWM;
>   			smu->user_dpm_profile.fan_speed_percent = speed;
> +		}
>   	}
>   
>   	mutex_unlock(&smu->mutex);
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
