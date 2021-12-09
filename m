Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DD7C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 16:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8103D10EA3F;
	Thu,  9 Dec 2021 16:54:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA28689FFD
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 12:37:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xd80Vibtj85OUsFeKBlri950dVIw639ZOrfEA9ktGTCTZOBisbbhfVWsOGp+c5rdAK+GtP+zrVa12FckNzpZ/QaL+w6BDe6+Shy9XfhSMMQpiLyBJbHGKIldXipQ57CpAXfs5H/B76p1qgE3VAfqA4VNJCTZImwrUm/yTQg2x/ZGRdXUB8eq0CRRCdqixsVuuTXWQG4MLaqj7TAa5XMQWyqxJ4N64QnUaCFKHZNLDS1EZ/fGxr7RFULVzhgwzBYDjo7eQA+aS9tTRjzQlxeGW7W1Hp+nlMIJB1uDouyEeyNjpSBOPnh2QNsi3hTC7niCZQ3wfCQenkegYGwre8Lhug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlT3dSWFzamKqzqEjiZ3tmygBFD/YVCxSknmGyoxY3Y=;
 b=INQuClShOY2X4BXbq3xflHoMHix2uCW9RyH3Bja8Nquz0G0R1ABkjulbwJ6IPRvvJbSzcud/UuF25fYURwGDZnmGlO0Y7aWOjthXQprgRd8mM9eBwi1cO+hxBkzfUgrgxC5F7OTP0pzeSv8zuLsAkHAeAis55bTCjGTviRuiq6uj7q6T6fDI8cONmrfj4wVGaSP7QUvWlFs4u+0zfmuHuk1mPds4i3UwQzpb6w2/HJqGcgt5iZVqlhef7PCbN4PsjHDjn3kIYiVO7a/hNJ/+5cfgj5NlQUWNFAeOFUh4MzCN0MUxZ7UPolnWhnBcIJz2b0Y0Yrc/6NL5lTmjCYgQ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlT3dSWFzamKqzqEjiZ3tmygBFD/YVCxSknmGyoxY3Y=;
 b=kmePcQ/swdaGdBK3V4xP7xoL1YJsredBja91JPZdg690elyrrByk6c+rE2DGE4s+AwDV0rpzo9t5ystAPMkyc7regO3O89gwXl+e5P5+T+Dr2QQ58/HIrKluhAlFPKD8cwh1Kbp/kB1LTGWZGxAGTga4AlaBKW9T4x6mquNPQ7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3929.namprd12.prod.outlook.com (2603:10b6:5:148::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Thu, 9 Dec
 2021 12:37:17 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4778.013; Thu, 9 Dec 2021
 12:37:16 +0000
Message-ID: <de6fa79a-9c32-3365-9f8b-7c9fc56d0277@amd.com>
Date: Thu, 9 Dec 2021 18:07:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V4 11/17] drm/amd/pm: correct the usage for
 amdgpu_dpm_dispatch_task()
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211203030540.1710564-1-evan.quan@amd.com>
 <20211203030540.1710564-11-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211203030540.1710564-11-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0107.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::23)
 To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 253a1af6-9575-460e-2cb9-08d9bb10a232
X-MS-TrafficTypeDiagnostic: DM6PR12MB3929:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB39290A161CD4FEA9D4BCE94997709@DM6PR12MB3929.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gMxscDE9caxWGZQ/aIZR2vEyaIsxNh42wgoOTTLjeXiqRkKi6k7nJUbGdlo5BZNAppkRpkCVVFISbnQ66ZyfFcq481zX8725Y/apkZzCDEETRNYNIo2+npalIIEWttevhyTf6druH3+OSqaSjNfPn9K+9Ih6AODftbyhGwWrMv+IrSki6ELAPlY/kQlLPx6bqnn3rlAM8Wv12ulJaDYymOPai5UacjQqI5i3tEVC62k1dukDnMAWtIJbx6QJ1JyvD8+P2lURy1ZvVjQOMka/T+kRue/sPWd4TgzaxKPWp8l/U4UBn9Vs8ah3mhoOxyCpMMfNJ96///Z2fADW5rXc8nlyQc6xD3Ya36k0+zlCKoryTOHHwTXJc5es3iRnSgM6OuhR1uJGuH/qmnjS3CHOV9/Zv9y/agd32OLO+ROhaf5N31UVdBYszIWAONblopgvLoAeo1iivqgAnQGGi1jXcR8VIsHfcirH5dS7DBE+0FvrqQ8kfu1EEvweDDCRu1XmRI72FcwmkrwI5RZbW1vKzpfjp27y//JzekEKVikdeSr3Pkz37nh5FV4QBtU6+U7hs9+zJ5sSIPcrCSNMlp/gr+BWqZ9VQpj6E2PWrkjKNhP5IexUcX6NQ/GKINLvf2GhBC3L2V2I5En1x83qQUId99mhC5P7GculQfP23Nq3XN36mAbjOD6j+A9LI2CnOdT6IYHnDT9KrbCWbtwyf94kE30lSmtRF64VNQpjxRGmRxY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(31696002)(508600001)(86362001)(4326008)(8936002)(53546011)(6506007)(2906002)(316002)(26005)(31686004)(83380400001)(186003)(6486002)(66556008)(6666004)(66476007)(66946007)(2616005)(38100700002)(8676002)(6512007)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm92MlJwR3FGck5sSWlKc3Y3dHgwTi80bHNwcWpscW0rR290VWdieDB3RTIy?=
 =?utf-8?B?aElhTWU2K1NldFk5aWxiM2tJaTB0MlhVQ3lUQS9oeTAwRSsyY2ZtSURyaWxM?=
 =?utf-8?B?R1BwVDJNdUlLNEJmWk1pc1ZYOTFnVU5GMEE5ZXhKeHVnc0NyZXZmcW44NFF1?=
 =?utf-8?B?ZXZCcFd1dDJKRzJKdFF0RFJCRFhidDZKT2t1Y1RsUGtLdG93a05SOUVEcWpj?=
 =?utf-8?B?RGpqMUhRQklIUnMySXE0V0tIekx5dXczYm1wcGJ3cjlPWTN5MVBjM3N0Mlhl?=
 =?utf-8?B?aUp6VzdVT1VkV1ZOS3V4cmxYK1BudmJrL1ZLSGphajFHajBoYmh2SGMxdi8x?=
 =?utf-8?B?Z3NxaXhGeDRrcXB0cTJ5dEs5bUsyWGNNaXNXS2krYVYraGZVVDlVb3dEWk1I?=
 =?utf-8?B?SktSWXEvZ2Vpc2IxeTQrUHllaks2cDJxVGxWWThPRWdpK1VBamJNT3BIZ1hG?=
 =?utf-8?B?Ly96bWUwWHQzR3poeVJ1N0RMYm1HWm1yVERIMXNkMTEwR3VCd2hVdFBianZW?=
 =?utf-8?B?UEl5S241ejI4SDJEN2ZPV2JvM0twR0dsUkZmckg5K3lVWDcwQXNKWERIZGw0?=
 =?utf-8?B?N1hUWEJSaXB6Y2h2UnFsYjJ3aHFtejlsbU5iVTFkMUlsaEs0Wk9HOEpMNytH?=
 =?utf-8?B?YjRlVlJmbW9GemhHZ3dFSWsyU21jbHpUR29TRUxsVXNnZTBvalMrb0FXS0Qx?=
 =?utf-8?B?WnFCMkxnQ1Ezb0l2SDQ1L0VtakJDU0FUa1pRYmJtcmhCdmpGN21oZXduSXJ5?=
 =?utf-8?B?eHRpUnRqbVluaFFsMHNncExkSjNjQ2xaUzZpRjVqQ0dlU3NsaE9VWStvOVlu?=
 =?utf-8?B?cEdQNUdyTlF1V0hvYUJGeW1KWElJZjRzZ0VIZDdjK3ltdkxYUEx1VHprdlJQ?=
 =?utf-8?B?SEVGZmdPeE44Wk9rRU5tZ0NxancxU1owMGRla2ZuVDRMNWRiUVhibWxyYTIw?=
 =?utf-8?B?cGlKblZERDFjdzArd2JVNFFIVkI2ckk3VGVrVFIxYU5rK3U0ZWlpZ2RSVzU3?=
 =?utf-8?B?VllpWDhyZE92dFNVbnlvMDdVSHpac2NwdmRjeU1acDlLcTdNZldESElMVVVY?=
 =?utf-8?B?cEt0Mktwa3JHSVV4MnVrdEFucHNuK1lGUWdma1hFY1hjbXo4cUtQK1FvN1ZV?=
 =?utf-8?B?VHVOUmpjeDM4V2ZTUzZYZnJVaktaVjg5MEZmd1dCdFlqSVN5NURwM3MxL1pZ?=
 =?utf-8?B?RlFjRzlNQlZNU1o3elV1RHZyRkgySWdyQVJyVVd4MVZCZFU4SWhlQlJONFFM?=
 =?utf-8?B?SkZYM1RpVjIwR3NGTFZabU44RTdscXVnV0xFcUhBVW02YTc5Qjg2QUY2MGF3?=
 =?utf-8?B?RjlkNzVsNUlnSDJtUm5TVzl1SEEwaXNXbmx1WGpUSTJGOUhBRGNXVUpqZkU5?=
 =?utf-8?B?MUU5WisvZzJITHQrR3Y4SkVNWGNqT0YxRGdRNGI2M0NuRnJLaDVtWkxWKzM2?=
 =?utf-8?B?elpxSW51MmJNQ2c2VXJEWEorZXBvY0RWSktGcDNVREFHQTJia3VYV1lnaU1k?=
 =?utf-8?B?RnZQSHQ5N1RISDRJRlErNE9qTGdZOCtRaEFLUzB5K2t4UDNFNUxqWjQyajM1?=
 =?utf-8?B?bWZhZTZmMGgwV2lwSVNiSlNZLzVoeFh6UU8vKzQ4aURoTVlNczVJVzJUMEpU?=
 =?utf-8?B?VVBOTkhDRTMrODhoZWF0LzZiQ1dkbUxpTm04SDBqVUk2bFZnZHFldEFUZFBN?=
 =?utf-8?B?VFI4SnBmd0w5dWxXcnZwbGNBWWRqcHNoWTNHNFZZaHFwMUE2K3Zab0cyTkJh?=
 =?utf-8?B?SkMxMEFJWHlwR0hWOXZ3aEZzbVkzeWtHd0FSOFEzd1FhTWs1a3NWVmhTRVFs?=
 =?utf-8?B?K1V5MklwWVlrNDVyR3R2VVlkV0IvaWVWQ1pubWRIK1g3NndWWG1ZajcvTm5y?=
 =?utf-8?B?MWxrdlljYjhaeGFuR3JHZUdQLzJKaWRNbkZONnpMR0xBYUhkVHByTS9qRk5m?=
 =?utf-8?B?by9GT2RNWS9FNXJaZkVtWVpYbEErWGJIbm5hZDRJdjg2bEZNeU9CUlRicHFK?=
 =?utf-8?B?Q2V3YmFPZjFYZCsySzJnRXh1YS9pczlCZ04zSUZsTmVIdjJHR2g1cmRsTzdi?=
 =?utf-8?B?QlMrODZtbEtpUTFEa3Y2eWF4NHNGemwvL2FlV1NwaUdLQ3grRUJCbE1Ud1pT?=
 =?utf-8?Q?G7nE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253a1af6-9575-460e-2cb9-08d9bb10a232
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 12:37:16.8151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZ9asGJ+FP+e0zS3id5+VO63Rlz0UCcI9O60LsfPFmM8nAPDL9Qk87j1uIGgFj24
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3929
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
Cc: Alexander.Deucher@amd.com, Kenneth.Feng@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/3/2021 8:35 AM, Evan Quan wrote:
> We should avoid having multi-function APIs. It should be up to the caller
> to determine when or whether to call amdgpu_dpm_dispatch_task().
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I78ec4eb8ceb6e526a4734113d213d15a5fbaa8a4
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 18 ++----------------
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c  | 26 ++++++++++++++++++++++++--
>   2 files changed, 26 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 6d9db2e2cbd3..32bf1247fb60 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -554,8 +554,6 @@ void amdgpu_dpm_set_power_state(struct amdgpu_device *adev,
>   				enum amd_pm_state_type state)
>   {
>   	adev->pm.dpm.user_state = state;
> -
> -	amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_ENABLE_USER_STATE, &state);
>   }
>   
>   enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device *adev)
> @@ -723,13 +721,7 @@ int amdgpu_dpm_set_sclk_od(struct amdgpu_device *adev, uint32_t value)
>   	if (!pp_funcs->set_sclk_od)
>   		return -EOPNOTSUPP;
>   
> -	pp_funcs->set_sclk_od(adev->powerplay.pp_handle, value);
> -
> -	amdgpu_dpm_dispatch_task(adev,
> -				 AMD_PP_TASK_READJUST_POWER_STATE,
> -				 NULL);
> -
> -	return 0;
> +	return pp_funcs->set_sclk_od(adev->powerplay.pp_handle, value);
>   }
>   
>   int amdgpu_dpm_get_mclk_od(struct amdgpu_device *adev)
> @@ -749,13 +741,7 @@ int amdgpu_dpm_set_mclk_od(struct amdgpu_device *adev, uint32_t value)
>   	if (!pp_funcs->set_mclk_od)
>   		return -EOPNOTSUPP;
>   
> -	pp_funcs->set_mclk_od(adev->powerplay.pp_handle, value);
> -
> -	amdgpu_dpm_dispatch_task(adev,
> -				 AMD_PP_TASK_READJUST_POWER_STATE,
> -				 NULL);
> -
> -	return 0;
> +	return pp_funcs->set_mclk_od(adev->powerplay.pp_handle, value);
>   }
>   
>   int amdgpu_dpm_get_power_profile_mode(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index fa2f4e11e94e..89e1134d660f 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -187,6 +187,10 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
>   
>   	amdgpu_dpm_set_power_state(adev, state);
>   
> +	amdgpu_dpm_dispatch_task(adev,
> +				 AMD_PP_TASK_ENABLE_USER_STATE,
> +				 &state);
> +
>   	pm_runtime_mark_last_busy(ddev->dev);
>   	pm_runtime_put_autosuspend(ddev->dev);
>   
> @@ -1278,7 +1282,16 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
>   		return ret;
>   	}
>   
> -	amdgpu_dpm_set_sclk_od(adev, (uint32_t)value);
> +	ret = amdgpu_dpm_set_sclk_od(adev, (uint32_t)value);

amdgpu_set_pp_sclk_od has a verbatim API like amdgpu_dpm_set_sclk_od and 
one would expect that to handle everything required to set the clock.

If locking is the problem, then it should be handled differently. This 
kind of mixing is not the right way.

Thanks,
Lijo

> +	if (ret) {
> +		pm_runtime_mark_last_busy(ddev->dev);
> +		pm_runtime_put_autosuspend(ddev->dev);
> +		return ret;
> +	}
> +
> +	amdgpu_dpm_dispatch_task(adev,
> +				 AMD_PP_TASK_READJUST_POWER_STATE,
> +				 NULL);
>   
>   	pm_runtime_mark_last_busy(ddev->dev);
>   	pm_runtime_put_autosuspend(ddev->dev);
> @@ -1340,7 +1353,16 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
>   		return ret;
>   	}
>   
> -	amdgpu_dpm_set_mclk_od(adev, (uint32_t)value);
> +	ret = amdgpu_dpm_set_mclk_od(adev, (uint32_t)value);
> +	if (ret) {
> +		pm_runtime_mark_last_busy(ddev->dev);
> +		pm_runtime_put_autosuspend(ddev->dev);
> +		return ret;
> +	}
> +
> +	amdgpu_dpm_dispatch_task(adev,
> +				 AMD_PP_TASK_READJUST_POWER_STATE,
> +				 NULL);
>   
>   	pm_runtime_mark_last_busy(ddev->dev);
>   	pm_runtime_put_autosuspend(ddev->dev);
> 
