Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24729C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 07:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C8EF10E951;
	Fri, 21 Jan 2022 07:47:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B1AF10E940
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 07:47:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fY0HSz6lYR21IH2vhHIDC4+1tCRRx7vYmrneoHKOWdK6eMrUTaj8tSjZIkJyZ5tHig89rouX/IXNsIpO1unN7YfhvlNY9BdxB+9uy0/XkhhaWcwVn0My7lzauBXLEkREtuZ+8EuXaG3JyOirU74Oz9lG9Xcy3m1LZLwmO/kzxhtPzTXT+Uo4yhjW5gyBnzhDVpRyMAT29yb3uCzPmeU5OdtnLoWHpJoYQt3wOwYg53Yem2Cm6mL4OrZolbFAyHkL12yoy0AHI6SK+QpdIohk3c6Cb5mHp14Fj/L6T+zE0duZYl8Qtzjqps/AY4u6GXJ0651aLRs5JRwfMz4c8DnCvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6llcPJvbm4rfC9tNgGzq2Pt+LzXx6ftv4TJRuaYtnw=;
 b=lHYRoCqI+sEWPRnF5tBnXDsrfEnK/ytRyD19iHqTzZjIri1kkEN4EesSj+iBCo41IxTk68utd3ANsPe32k//YidUzyn15hOx83jtqKWCpgQYXuOK0MciJNkTqyvmuE3qap9S1DDa1pb/AcpccthDLc3FLEa8wx53FDw/yK1LYEU9DSgbPH75nTWR0priOIWZpJFKvMSM0XvG+4ZhaukxASak95iCsLVCjgG9312AGqCKTvIOj/JPGRX4cqVVkFM8AnhMc7NtxhNzYfY+nv1Rckyq4zwr2f6l7JWBoEEfFs0POnl2gzdrrG0M8uikUwXxfdxESU3sb999yj0VkaX96g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6llcPJvbm4rfC9tNgGzq2Pt+LzXx6ftv4TJRuaYtnw=;
 b=YCA/NNCuSBxWG7aCng+kHUlyCrUtSlestmCGnzVmKSRewBzBk9BW8wkwikSwKnjPWjlgcPQl1HoVHtsYPXH0L47t8SRICUI51xlMCs9zI9Smeic6uVzXvZS8O5lBAt+IeE+dAQjPlcD/fd55HOD1x5DcB6XGxOOE4wMHQhexyoY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BYAPR12MB3544.namprd12.prod.outlook.com (2603:10b6:a03:131::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Fri, 21 Jan
 2022 07:47:47 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda%6]) with mapi id 15.20.4888.014; Fri, 21 Jan 2022
 07:47:47 +0000
Message-ID: <35c92b1a-1010-d67d-b919-2b673eb9b256@amd.com>
Date: Fri, 21 Jan 2022 13:17:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V3 1/7] drm/amd/pm: drop unneeded lock protection
 smu->mutex
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220121070635.638212-1-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220121070635.638212-1-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0149.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::19) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 987a2f35-8a9a-45e0-8a06-08d9dcb250f6
X-MS-TrafficTypeDiagnostic: BYAPR12MB3544:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB35443F542A5B44EA97EA6876975B9@BYAPR12MB3544.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hpwhaa0P+10ahRh6iDFQJVDFz6eO+NMXBtMRLvDJYZQsNv2oO5O4RLBIXxDO81JgqlI6wiPqJCBtHHjHDUzTzZXVSJQgDQDjC9Ire2k6ZQe/7Gz8defYrsiRII3qRzONHg8fBet4VaSUeReFhvvOpzBe/NnjOzSwfxaH/bC6w0aLY1yeG1cLFGGgRgWteVIl/U9Ap7BDFxZux55KG9uiqP0mzV/BS8ADvtaZWx0FaO9T7ocTHT/N1Z/FCUyctb8qky+P3Nd8RCLd8pvqKMjGbLodcoPTWCn0KEvgYLPUEEpJlsc1e0PNld221MY4XBUwfgoyQaAGMEOYOiQYT1AuKA6gp5xXYtCFhz6rN83kSsyqHdVVEPrT34r12AAX82t1Xvs0RqkIKPZRdJ5A3uPHpceBv73aF2cOChjRRGW5d06TFS8rDOsa8IEHhj7+bcWJLdFYtVuG7XQPvVT08OytaJFwjylJeZQ1IKysTBUHgU18PS0P179jaObDJfXxa8paaoiP6kL7CwM9pm2W5MuIUiAHM17MXuYrOVCASt/zZZxM2jUUUXwlzO+/CsreGAGlYrtnmNroBLlBa1EHfJ9LLY+4iv7mG1SfLXTFSBvpdpsIhUQuV2M5vj9WKmRg5e4oXrzT1H1qkBXeQaPhNSbEvUszhzcOAUsPsvY9z6/3PmrOn6d+p4rECf87bN+XxMeKX4clfqr8RbNcYXqv1qJEiwb7jEtsPkKNG/fx0CetJxYhHb+EUZeDoZdVuW9gR35N/QOkBlqjwUhpm7q5X16TzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(6666004)(8676002)(66556008)(5660300002)(4326008)(53546011)(83380400001)(36756003)(316002)(31696002)(66476007)(2906002)(38100700002)(30864003)(66946007)(26005)(2616005)(86362001)(6512007)(508600001)(31686004)(186003)(6486002)(8936002)(45980500001)(43740500002)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym02Zi9VMHNxYjYrcjNQdmZsSGRDTWFIV205aFBybDNFWDB0dE1Qc2c5a2Q5?=
 =?utf-8?B?SEg2WUNWSWdVRlhuM3huMHZIUkY2eTFXTjFQQkJZbGpWSnNWSUd0NmZIVkVS?=
 =?utf-8?B?YWNoSE9YcUs4UFpXUTdxSUtIY3daMVFudWlVVUZJUG43Y0dSaEJOSmRYcG16?=
 =?utf-8?B?SFlYdjNtUmo1WHp3bDNUTkFiZ2Q3MW5reEdEbXgrclliU2MzS1BHQ1FJbWZt?=
 =?utf-8?B?UGE2czdHckpTS1JJQ1NoaHlJYW8zYmlVR3RwMjEzS2g4b1FXWnRDQlJhYUhU?=
 =?utf-8?B?L08vbFE3RVI0Qzd0bUJVZC9zemZEMGx5cWY1LzZMb0NBczBxczJZL2srTVdj?=
 =?utf-8?B?b1lLa2p5WFhNOWpaQXdEdjUvTGxOcXd1U3lTdGozREk1WWJ1bE9WS0xIUlhU?=
 =?utf-8?B?RGF6YUVvNFZFa0d6THorYXhRZ3RualdqSHN0TkVid1F5RDV4bU8rRVBzSUVV?=
 =?utf-8?B?azduVkN4S0dWa2orRGZLQVhiejdXdWtxeEVpUzRtWmtEQWRiL0ROdG5PeGlH?=
 =?utf-8?B?QU1QSUZwUWV0RzcxbU1XZi9acEcyS3pLVU9DUXZEdTVKSVpzUnhBckdDWVA5?=
 =?utf-8?B?cVM2NWpGd2NOeGIxL29tNmtZUW85a2FaRjBNS2pSdm9Hcy9nYTVwVi9FQlJk?=
 =?utf-8?B?Y1MrSXptd29LTDFHamhpaUR1S1UwRUNjZXcyQUVMVnJITlNPbisyKytBQ200?=
 =?utf-8?B?d0txVzVNcTdtbjYwOXdocWJsdnBUdXdTaUwvNXJpSkM2cG1lUkN3Mm1mUjRT?=
 =?utf-8?B?RHUvS1BGMDBjUXl4enhnSWpWK2NHaW1sVmJTdTFaVmU5YjdCTW1zVVVHbWF6?=
 =?utf-8?B?MVBvUTl2OU9EdmRwWmJ0bE4yQW03WGZFa1pTMnFVcVFTYXVGNENJNW42UjQx?=
 =?utf-8?B?aFZ2SWMvRW5FWUFCS3Z2VnA3a1NoMElaSHdLbWU1TzRic2ZFN1Zpd05LUVZM?=
 =?utf-8?B?elNUMW5UaThKajFBU1VwSEc4WDdrRlVtbWNsK3R5MXIvR0VKak96OHFldHhq?=
 =?utf-8?B?SlAxNXF4aWhGQlYxVDBocXl6TnIzdE01WTZJMXkvODdRMy9UT0QxLzlkTjBu?=
 =?utf-8?B?YWJzcHNKTnhWNTg1Tis2bHdoY2RxUDZZaEo0V0xjc1kwQkdMVXFENmJ3U3JE?=
 =?utf-8?B?T2tETGxyTm1oSlBHMVJDaEU5VnI5c04ydEJScnFpZndNYTNhdGI1czc0N3c3?=
 =?utf-8?B?Z21GY0ZGQmRPbTByVElwRGxUUnViWS9CNkhoQWZzL0xvU3lvS3lMWHU5dnFs?=
 =?utf-8?B?TEg0enM2SFg0MW14UytkV3JHU2N4NXRhWXhiWmdDY1J0azRPT1V0N1hOZFB1?=
 =?utf-8?B?Z2ZnQWxZQ2o4ZEVCdWJoU3RCRDBIbzc1eGdVeUZZOTJrdW9pZk1OSVBnQ2oz?=
 =?utf-8?B?MWF5WGFpZUhGUjZqMlU5SSs5NzdqclN4NWtGVEtzWHlOMmIxNTNkNStYU21u?=
 =?utf-8?B?TXdnTFdCQTZ1ZGpUclR0V2RsMXN3K0FOK3dzNC9NQUY3aGtmZHdnNlZxYWNh?=
 =?utf-8?B?WGJmdm5sUnRtTVNYbjJlU2tOazhkTnZoZ3hyc2ZlMXBhRnR6UUc4V29Bdjly?=
 =?utf-8?B?dGdKdWpQcDg2VjB0WkdxUy9RdzIvWWVTZUNjWEc1eEZGNkhkb3Q5MVpFU2FJ?=
 =?utf-8?B?QkNaL3RoUFJJbGtlQWZXWXl0Sms1V0FsTmpoRUhsaWpsT3NkTmpOSFRISWww?=
 =?utf-8?B?YVM4d01sdUpTbTdOUmtzTmlENnBDMitkaUhwd2RCYVdsQ2VGcjlWanZTdDlz?=
 =?utf-8?B?cDJYYkowbW9hSDAyT1drYlJ1WWlsNThib2Qyc0ppS012bjUvSmVtc3daSFVE?=
 =?utf-8?B?SFR3akptcG0wODdCUWkzZkVFS1NuRTJaVjRZeUFEc0FqVjkrK2VQdFdoOXdK?=
 =?utf-8?B?OFZBVXBheFFtU2ZiL2ovT1hyQkZMTFh2UlcyS1JhblYzTVpvcUVsZTM2aksx?=
 =?utf-8?B?aGJwS0ZSUUsrYkdZdkpqRm43MTRNRzU5dVAyS2FOL2hLaUo5QUFkZ3hMS0gr?=
 =?utf-8?B?MVBYcjh4eW4vTXdOZFdmeURha0NxU0NieFVMT3lpdTF4ZXFSTkpLZERjdzAr?=
 =?utf-8?B?cmh5eUlEL0t0RXJaOUZTWGw0MmFtUFU1d1M3cTJuK2NkNUFsdXFvT2NyZ0Q3?=
 =?utf-8?Q?wLoY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 987a2f35-8a9a-45e0-8a06-08d9dcb250f6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 07:47:47.5259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRH2PpixE9qRSm4YVWTiqgiqhHmKqxgJlFLuINlKZ5oS84G6osubj3/5dHSQqv+2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3544
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
Cc: Alexander.Deucher@amd.com, Guchun.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/21/2022 12:36 PM, Evan Quan wrote:
> As all those APIs are already protected either by adev->pm.mutex
> or smu->message_lock.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> Change-Id: I1db751fba9caabc5ca1314992961d3674212f9b0
> --
> v1->v2:
>    - optimize the "!smu_table->hardcode_pptable" check(Guchun)
>    - add the lock protection(adev->pm.mutex) for i2c transfer(Lijo)
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 316 ++----------------
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   1 -
>   .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |   4 +-
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |   4 +-
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |   4 +-
>   .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |   4 +-
>   6 files changed, 34 insertions(+), 299 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 828cb932f6a9..eaaa5b033d46 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -55,8 +55,7 @@ static int smu_force_smuclk_levels(struct smu_context *smu,
>   				   uint32_t mask);
>   static int smu_handle_task(struct smu_context *smu,
>   			   enum amd_dpm_forced_level level,
> -			   enum amd_pp_task task_id,
> -			   bool lock_needed);
> +			   enum amd_pp_task task_id);
>   static int smu_reset(struct smu_context *smu);
>   static int smu_set_fan_speed_pwm(void *handle, u32 speed);
>   static int smu_set_fan_control_mode(void *handle, u32 value);
> @@ -68,36 +67,22 @@ static int smu_sys_get_pp_feature_mask(void *handle,
>   				       char *buf)
>   {
>   	struct smu_context *smu = handle;
> -	int size = 0;
>   
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&smu->mutex);
> -
> -	size = smu_get_pp_feature_mask(smu, buf);
> -
> -	mutex_unlock(&smu->mutex);
> -
> -	return size;
> +	return smu_get_pp_feature_mask(smu, buf);
>   }
>   
>   static int smu_sys_set_pp_feature_mask(void *handle,
>   				       uint64_t new_mask)
>   {
>   	struct smu_context *smu = handle;
> -	int ret = 0;
>   
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&smu->mutex);
> -
> -	ret = smu_set_pp_feature_mask(smu, new_mask);
> -
> -	mutex_unlock(&smu->mutex);
> -
> -	return ret;
> +	return smu_set_pp_feature_mask(smu, new_mask);
>   }
>   
>   int smu_get_status_gfxoff(struct smu_context *smu, uint32_t *value)
> @@ -117,16 +102,12 @@ int smu_set_soft_freq_range(struct smu_context *smu,
>   {
>   	int ret = 0;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	if (smu->ppt_funcs->set_soft_freq_limited_range)
>   		ret = smu->ppt_funcs->set_soft_freq_limited_range(smu,
>   								  clk_type,
>   								  min,
>   								  max);
>   
> -	mutex_unlock(&smu->mutex);
> -
>   	return ret;
>   }
>   
> @@ -140,16 +121,12 @@ int smu_get_dpm_freq_range(struct smu_context *smu,
>   	if (!min && !max)
>   		return -EINVAL;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	if (smu->ppt_funcs->get_dpm_ultimate_freq)
>   		ret = smu->ppt_funcs->get_dpm_ultimate_freq(smu,
>   							    clk_type,
>   							    min,
>   							    max);
>   
> -	mutex_unlock(&smu->mutex);
> -
>   	return ret;
>   }
>   
> @@ -482,7 +459,6 @@ static int smu_sys_get_pp_table(void *handle,
>   {
>   	struct smu_context *smu = handle;
>   	struct smu_table_context *smu_table = &smu->smu_table;
> -	uint32_t powerplay_table_size;
>   
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
> @@ -490,18 +466,12 @@ static int smu_sys_get_pp_table(void *handle,
>   	if (!smu_table->power_play_table && !smu_table->hardcode_pptable)
>   		return -EINVAL;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	if (smu_table->hardcode_pptable)
>   		*table = smu_table->hardcode_pptable;
>   	else
>   		*table = smu_table->power_play_table;
>   
> -	powerplay_table_size = smu_table->power_play_table_size;
> -
> -	mutex_unlock(&smu->mutex);
> -
> -	return powerplay_table_size;
> +	return smu_table->power_play_table_size;
>   }
>   
>   static int smu_sys_set_pp_table(void *handle,
> @@ -521,12 +491,10 @@ static int smu_sys_set_pp_table(void *handle,
>   		return -EIO;
>   	}
>   
> -	mutex_lock(&smu->mutex);
> -	if (!smu_table->hardcode_pptable)
> -		smu_table->hardcode_pptable = kzalloc(size, GFP_KERNEL);
>   	if (!smu_table->hardcode_pptable) {
> -		ret = -ENOMEM;
> -		goto failed;
> +		smu_table->hardcode_pptable = kzalloc(size, GFP_KERNEL);
> +		if (!smu_table->hardcode_pptable)
> +			return -ENOMEM;
>   	}
>   
>   	memcpy(smu_table->hardcode_pptable, buf, size);
> @@ -545,8 +513,6 @@ static int smu_sys_set_pp_table(void *handle,
>   
>   	smu->uploading_custom_pp_table = false;
>   
> -failed:
> -	mutex_unlock(&smu->mutex);
>   	return ret;
>   }
>   
> @@ -633,7 +599,6 @@ static int smu_early_init(void *handle)
>   	smu->adev = adev;
>   	smu->pm_enabled = !!amdgpu_dpm;
>   	smu->is_apu = false;
> -	mutex_init(&smu->mutex);
>   	mutex_init(&smu->smu_baco.mutex);
>   	smu->smu_baco.state = SMU_BACO_STATE_EXIT;
>   	smu->smu_baco.platform_support = false;
> @@ -736,8 +701,7 @@ static int smu_late_init(void *handle)
>   
>   	smu_handle_task(smu,
>   			smu->smu_dpm.dpm_level,
> -			AMD_PP_TASK_COMPLETE_INIT,
> -			false);
> +			AMD_PP_TASK_COMPLETE_INIT);
>   
>   	smu_restore_dpm_user_profile(smu);
>   
> @@ -1013,12 +977,8 @@ static void smu_interrupt_work_fn(struct work_struct *work)
>   	struct smu_context *smu = container_of(work, struct smu_context,
>   					       interrupt_work);
>   
> -	mutex_lock(&smu->mutex);
> -
>   	if (smu->ppt_funcs && smu->ppt_funcs->interrupt_work)
>   		smu->ppt_funcs->interrupt_work(smu);
> -
> -	mutex_unlock(&smu->mutex);
>   }
>   
>   static int smu_sw_init(void *handle)
> @@ -1632,8 +1592,6 @@ static int smu_display_configuration_change(void *handle,
>   	if (!display_config)
>   		return -EINVAL;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	smu_set_min_dcef_deep_sleep(smu,
>   				    display_config->min_dcef_deep_sleep_set_clk / 100);
>   
> @@ -1642,8 +1600,6 @@ static int smu_display_configuration_change(void *handle,
>   			num_of_active_display++;
>   	}
>   
> -	mutex_unlock(&smu->mutex);
> -
>   	return 0;
>   }
>   
> @@ -1766,22 +1722,18 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
>   
>   static int smu_handle_task(struct smu_context *smu,
>   			   enum amd_dpm_forced_level level,
> -			   enum amd_pp_task task_id,
> -			   bool lock_needed)
> +			   enum amd_pp_task task_id)
>   {
>   	int ret = 0;
>   
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
> -	if (lock_needed)
> -		mutex_lock(&smu->mutex);
> -
>   	switch (task_id) {
>   	case AMD_PP_TASK_DISPLAY_CONFIG_CHANGE:
>   		ret = smu_pre_display_config_changed(smu);
>   		if (ret)
> -			goto out;
> +			return ret;
>   		ret = smu_adjust_power_state_dynamic(smu, level, false);
>   		break;
>   	case AMD_PP_TASK_COMPLETE_INIT:
> @@ -1792,10 +1744,6 @@ static int smu_handle_task(struct smu_context *smu,
>   		break;
>   	}
>   
> -out:
> -	if (lock_needed)
> -		mutex_unlock(&smu->mutex);
> -
>   	return ret;
>   }
>   
> @@ -1806,7 +1754,7 @@ static int smu_handle_dpm_task(void *handle,
>   	struct smu_context *smu = handle;
>   	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
>   
> -	return smu_handle_task(smu, smu_dpm->dpm_level, task_id, true);
> +	return smu_handle_task(smu, smu_dpm->dpm_level, task_id);
>   
>   }
>   
> @@ -1825,8 +1773,6 @@ static int smu_switch_power_profile(void *handle,
>   	if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
>   		return -EINVAL;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	if (!en) {
>   		smu->workload_mask &= ~(1 << smu->workload_prority[type]);
>   		index = fls(smu->workload_mask);
> @@ -1843,8 +1789,6 @@ static int smu_switch_power_profile(void *handle,
>   		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
>   		smu_bump_power_profile_mode(smu, &workload, 0);
>   
> -	mutex_unlock(&smu->mutex);
> -
>   	return 0;
>   }
>   
> @@ -1852,7 +1796,6 @@ static enum amd_dpm_forced_level smu_get_performance_level(void *handle)
>   {
>   	struct smu_context *smu = handle;
>   	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
> -	enum amd_dpm_forced_level level;
>   
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
> @@ -1860,11 +1803,7 @@ static enum amd_dpm_forced_level smu_get_performance_level(void *handle)
>   	if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
>   		return -EINVAL;
>   
> -	mutex_lock(&(smu->mutex));
> -	level = smu_dpm_ctx->dpm_level;
> -	mutex_unlock(&(smu->mutex));
> -
> -	return level;
> +	return smu_dpm_ctx->dpm_level;
>   }
>   
>   static int smu_force_performance_level(void *handle,
> @@ -1880,19 +1819,12 @@ static int smu_force_performance_level(void *handle,
>   	if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
>   		return -EINVAL;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	ret = smu_enable_umd_pstate(smu, &level);
> -	if (ret) {
> -		mutex_unlock(&smu->mutex);
> +	if (ret)
>   		return ret;
> -	}
>   
>   	ret = smu_handle_task(smu, level,
> -			      AMD_PP_TASK_READJUST_POWER_STATE,
> -			      false);
> -
> -	mutex_unlock(&smu->mutex);
> +			      AMD_PP_TASK_READJUST_POWER_STATE);
>   
>   	/* reset user dpm clock state */
>   	if (!ret && smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL) {
> @@ -1906,16 +1838,11 @@ static int smu_force_performance_level(void *handle,
>   static int smu_set_display_count(void *handle, uint32_t count)
>   {
>   	struct smu_context *smu = handle;
> -	int ret = 0;
>   
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&smu->mutex);
> -	ret = smu_init_display_count(smu, count);
> -	mutex_unlock(&smu->mutex);
> -
> -	return ret;
> +	return smu_init_display_count(smu, count);
>   }
>   
>   static int smu_force_smuclk_levels(struct smu_context *smu,
> @@ -1933,8 +1860,6 @@ static int smu_force_smuclk_levels(struct smu_context *smu,
>   		return -EINVAL;
>   	}
>   
> -	mutex_lock(&smu->mutex);
> -
>   	if (smu->ppt_funcs && smu->ppt_funcs->force_clk_levels) {
>   		ret = smu->ppt_funcs->force_clk_levels(smu, clk_type, mask);
>   		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
> @@ -1943,8 +1868,6 @@ static int smu_force_smuclk_levels(struct smu_context *smu,
>   		}
>   	}
>   
> -	mutex_unlock(&smu->mutex);
> -
>   	return ret;
>   }
>   
> @@ -2003,14 +1926,10 @@ static int smu_set_mp1_state(void *handle,
>   	if (!smu->pm_enabled)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	if (smu->ppt_funcs &&
>   	    smu->ppt_funcs->set_mp1_state)
>   		ret = smu->ppt_funcs->set_mp1_state(smu, mp1_state);
>   
> -	mutex_unlock(&smu->mutex);
> -
>   	return ret;
>   }
>   
> @@ -2026,14 +1945,10 @@ static int smu_set_df_cstate(void *handle,
>   	if (!smu->ppt_funcs || !smu->ppt_funcs->set_df_cstate)
>   		return 0;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	ret = smu->ppt_funcs->set_df_cstate(smu, state);
>   	if (ret)
>   		dev_err(smu->adev->dev, "[SetDfCstate] failed!\n");
>   
> -	mutex_unlock(&smu->mutex);
> -
>   	return ret;
>   }
>   
> @@ -2047,38 +1962,25 @@ int smu_allow_xgmi_power_down(struct smu_context *smu, bool en)
>   	if (!smu->ppt_funcs || !smu->ppt_funcs->allow_xgmi_power_down)
>   		return 0;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	ret = smu->ppt_funcs->allow_xgmi_power_down(smu, en);
>   	if (ret)
>   		dev_err(smu->adev->dev, "[AllowXgmiPowerDown] failed!\n");
>   
> -	mutex_unlock(&smu->mutex);
> -
>   	return ret;
>   }
>   
>   int smu_write_watermarks_table(struct smu_context *smu)
>   {
> -	int ret = 0;
> -
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&smu->mutex);
> -
> -	ret = smu_set_watermarks_table(smu, NULL);
> -
> -	mutex_unlock(&smu->mutex);
> -
> -	return ret;
> +	return smu_set_watermarks_table(smu, NULL);
>   }
>   
>   static int smu_set_watermarks_for_clock_ranges(void *handle,
>   					       struct pp_smu_wm_range_sets *clock_ranges)
>   {
>   	struct smu_context *smu = handle;
> -	int ret = 0;
>   
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
> @@ -2086,13 +1988,7 @@ static int smu_set_watermarks_for_clock_ranges(void *handle,
>   	if (smu->disable_watermark)
>   		return 0;
>   
> -	mutex_lock(&smu->mutex);
> -
> -	ret = smu_set_watermarks_table(smu, clock_ranges);
> -
> -	mutex_unlock(&smu->mutex);
> -
> -	return ret;
> +	return smu_set_watermarks_table(smu, clock_ranges);
>   }
>   
>   int smu_set_ac_dc(struct smu_context *smu)
> @@ -2106,14 +2002,12 @@ int smu_set_ac_dc(struct smu_context *smu)
>   	if (smu->dc_controlled_by_gpio)
>   		return 0;
>   
> -	mutex_lock(&smu->mutex);
>   	ret = smu_set_power_source(smu,
>   				   smu->adev->pm.ac_power ? SMU_POWER_SOURCE_AC :
>   				   SMU_POWER_SOURCE_DC);
>   	if (ret)
>   		dev_err(smu->adev->dev, "Failed to switch to %s mode!\n",
>   		       smu->adev->pm.ac_power ? "AC" : "DC");
> -	mutex_unlock(&smu->mutex);
>   
>   	return ret;
>   }
> @@ -2200,13 +2094,9 @@ static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled)
>   {
>   	int ret = 0;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	if (smu->ppt_funcs->set_gfx_cgpg)
>   		ret = smu->ppt_funcs->set_gfx_cgpg(smu, enabled);
>   
> -	mutex_unlock(&smu->mutex);
> -
>   	return ret;
>   }
>   
> @@ -2224,8 +2114,6 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
>   	if (speed == U32_MAX)
>   		return -EINVAL;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	ret = smu->ppt_funcs->set_fan_speed_rpm(smu, speed);
>   	if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
>   		smu->user_dpm_profile.flags |= SMU_CUSTOM_FAN_SPEED_RPM;
> @@ -2236,8 +2124,6 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
>   		smu->user_dpm_profile.fan_speed_pwm = 0;
>   	}
>   
> -	mutex_unlock(&smu->mutex);
> -
>   	return ret;
>   }
>   
> @@ -2293,8 +2179,6 @@ int smu_get_power_limit(void *handle,
>   		break;
>   	}
>   
> -	mutex_lock(&smu->mutex);
> -
>   	if (limit_type != SMU_DEFAULT_PPT_LIMIT) {
>   		if (smu->ppt_funcs->get_ppt_limit)
>   			ret = smu->ppt_funcs->get_ppt_limit(smu, limit, limit_type, limit_level);
> @@ -2328,8 +2212,6 @@ int smu_get_power_limit(void *handle,
>   		}
>   	}
>   
> -	mutex_unlock(&smu->mutex);
> -
>   	return ret;
>   }
>   
> @@ -2342,21 +2224,16 @@ static int smu_set_power_limit(void *handle, uint32_t limit)
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	limit &= (1<<24)-1;
>   	if (limit_type != SMU_DEFAULT_PPT_LIMIT)
> -		if (smu->ppt_funcs->set_power_limit) {
> -			ret = smu->ppt_funcs->set_power_limit(smu, limit_type, limit);
> -			goto out;
> -		}
> +		if (smu->ppt_funcs->set_power_limit)
> +			return smu->ppt_funcs->set_power_limit(smu, limit_type, limit);
>   
>   	if (limit > smu->max_power_limit) {
>   		dev_err(smu->adev->dev,
>   			"New power limit (%d) is over the max allowed %d\n",
>   			limit, smu->max_power_limit);
> -		ret = -EINVAL;
> -		goto out;
> +		return -EINVAL;
>   	}
>   
>   	if (!limit)
> @@ -2368,9 +2245,6 @@ static int smu_set_power_limit(void *handle, uint32_t limit)
>   			smu->user_dpm_profile.power_limit = limit;
>   	}
>   
> -out:
> -	mutex_unlock(&smu->mutex);
> -
>   	return ret;
>   }
>   
> @@ -2381,13 +2255,9 @@ static int smu_print_smuclk_levels(struct smu_context *smu, enum smu_clk_type cl
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	if (smu->ppt_funcs->print_clk_levels)
>   		ret = smu->ppt_funcs->print_clk_levels(smu, clk_type, buf);
>   
> -	mutex_unlock(&smu->mutex);
> -
>   	return ret;
>   }
>   
> @@ -2444,14 +2314,10 @@ static int smu_od_edit_dpm_table(void *handle,
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	if (smu->ppt_funcs->od_edit_dpm_table) {
>   		ret = smu->ppt_funcs->od_edit_dpm_table(smu, type, input, size);
>   	}
>   
> -	mutex_unlock(&smu->mutex);
> -
>   	return ret;
>   }
>   
> @@ -2475,8 +2341,6 @@ static int smu_read_sensor(void *handle,
>   	size_val = *size_arg;
>   	size = &size_val;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	if (smu->ppt_funcs->read_sensor)
>   		if (!smu->ppt_funcs->read_sensor(smu, sensor, data, size))
>   			goto unlock;
> @@ -2517,8 +2381,6 @@ static int smu_read_sensor(void *handle,
>   	}
>   
>   unlock:
> -	mutex_unlock(&smu->mutex);
> -
>   	// assign uint32_t to int
>   	*size_arg = size_val;
>   
> @@ -2528,7 +2390,6 @@ static int smu_read_sensor(void *handle,
>   static int smu_get_power_profile_mode(void *handle, char *buf)
>   {
>   	struct smu_context *smu = handle;
> -	int ret = 0;
>   
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
>   	    !smu->ppt_funcs->get_power_profile_mode)
> @@ -2536,13 +2397,7 @@ static int smu_get_power_profile_mode(void *handle, char *buf)
>   	if (!buf)
>   		return -EINVAL;
>   
> -	mutex_lock(&smu->mutex);
> -
> -	ret = smu->ppt_funcs->get_power_profile_mode(smu, buf);
> -
> -	mutex_unlock(&smu->mutex);
> -
> -	return ret;
> +	return smu->ppt_funcs->get_power_profile_mode(smu, buf);
>   }
>   
>   static int smu_set_power_profile_mode(void *handle,
> @@ -2550,19 +2405,12 @@ static int smu_set_power_profile_mode(void *handle,
>   				      uint32_t param_size)
>   {
>   	struct smu_context *smu = handle;
> -	int ret = 0;
>   
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
>   	    !smu->ppt_funcs->set_power_profile_mode)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&smu->mutex);
> -
> -	smu_bump_power_profile_mode(smu, param, param_size);
> -
> -	mutex_unlock(&smu->mutex);
> -
> -	return ret;
> +	return smu_bump_power_profile_mode(smu, param, param_size);
>   }
>   
>   
> @@ -2579,12 +2427,8 @@ static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
>   	if (!fan_mode)
>   		return -EINVAL;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	*fan_mode = smu->ppt_funcs->get_fan_control_mode(smu);
>   
> -	mutex_unlock(&smu->mutex);
> -
>   	return 0;
>   }
>   
> @@ -2602,8 +2446,6 @@ static int smu_set_fan_control_mode(void *handle, u32 value)
>   	if (value == U32_MAX)
>   		return -EINVAL;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	ret = smu->ppt_funcs->set_fan_control_mode(smu, value);
>   	if (ret)
>   		goto out;
> @@ -2620,8 +2462,6 @@ static int smu_set_fan_control_mode(void *handle, u32 value)
>   	}
>   
>   out:
> -	mutex_unlock(&smu->mutex);
> -
>   	return ret;
>   }
>   
> @@ -2639,12 +2479,8 @@ static int smu_get_fan_speed_pwm(void *handle, u32 *speed)
>   	if (!speed)
>   		return -EINVAL;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	ret = smu->ppt_funcs->get_fan_speed_pwm(smu, speed);
>   
> -	mutex_unlock(&smu->mutex);
> -
>   	return ret;
>   }
>   
> @@ -2662,8 +2498,6 @@ static int smu_set_fan_speed_pwm(void *handle, u32 speed)
>   	if (speed == U32_MAX)
>   		return -EINVAL;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	ret = smu->ppt_funcs->set_fan_speed_pwm(smu, speed);
>   	if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
>   		smu->user_dpm_profile.flags |= SMU_CUSTOM_FAN_SPEED_PWM;
> @@ -2674,8 +2508,6 @@ static int smu_set_fan_speed_pwm(void *handle, u32 speed)
>   		smu->user_dpm_profile.fan_speed_rpm = 0;
>   	}
>   
> -	mutex_unlock(&smu->mutex);
> -
>   	return ret;
>   }
>   
> @@ -2693,30 +2525,19 @@ static int smu_get_fan_speed_rpm(void *handle, uint32_t *speed)
>   	if (!speed)
>   		return -EINVAL;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	ret = smu->ppt_funcs->get_fan_speed_rpm(smu, speed);
>   
> -	mutex_unlock(&smu->mutex);
> -
>   	return ret;
>   }
>   
>   static int smu_set_deep_sleep_dcefclk(void *handle, uint32_t clk)
>   {
>   	struct smu_context *smu = handle;
> -	int ret = 0;
>   
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&smu->mutex);
> -
> -	ret = smu_set_min_dcef_deep_sleep(smu, clk);
> -
> -	mutex_unlock(&smu->mutex);
> -
> -	return ret;
> +	return smu_set_min_dcef_deep_sleep(smu, clk);
>   }
>   
>   static int smu_get_clock_by_type_with_latency(void *handle,
> @@ -2730,8 +2551,6 @@ static int smu_get_clock_by_type_with_latency(void *handle,
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	if (smu->ppt_funcs->get_clock_by_type_with_latency) {
>   		switch (type) {
>   		case amd_pp_sys_clock:
> @@ -2748,15 +2567,12 @@ static int smu_get_clock_by_type_with_latency(void *handle,
>   			break;
>   		default:
>   			dev_err(smu->adev->dev, "Invalid clock type!\n");
> -			mutex_unlock(&smu->mutex);
>   			return -EINVAL;
>   		}
>   
>   		ret = smu->ppt_funcs->get_clock_by_type_with_latency(smu, clk_type, clocks);
>   	}
>   
> -	mutex_unlock(&smu->mutex);
> -
>   	return ret;
>   }
>   
> @@ -2769,13 +2585,9 @@ static int smu_display_clock_voltage_request(void *handle,
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	if (smu->ppt_funcs->display_clock_voltage_request)
>   		ret = smu->ppt_funcs->display_clock_voltage_request(smu, clock_req);
>   
> -	mutex_unlock(&smu->mutex);
> -
>   	return ret;
>   }
>   
> @@ -2789,13 +2601,9 @@ static int smu_display_disable_memory_clock_switch(void *handle,
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	if (smu->ppt_funcs->display_disable_memory_clock_switch)
>   		ret = smu->ppt_funcs->display_disable_memory_clock_switch(smu, disable_memory_clock_switch);
>   
> -	mutex_unlock(&smu->mutex);
> -
>   	return ret;
>   }
>   
> @@ -2808,13 +2616,9 @@ static int smu_set_xgmi_pstate(void *handle,
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	if (smu->ppt_funcs->set_xgmi_pstate)
>   		ret = smu->ppt_funcs->set_xgmi_pstate(smu, pstate);
>   
> -	mutex_unlock(&smu->mutex);
> -
>   	if(ret)
>   		dev_err(smu->adev->dev, "Failed to set XGMI pstate!\n");
>   
> @@ -2824,21 +2628,16 @@ static int smu_set_xgmi_pstate(void *handle,
>   static int smu_get_baco_capability(void *handle, bool *cap)
>   {
>   	struct smu_context *smu = handle;
> -	int ret = 0;
>   
>   	*cap = false;
>   
>   	if (!smu->pm_enabled)
>   		return 0;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	if (smu->ppt_funcs && smu->ppt_funcs->baco_is_support)
>   		*cap = smu->ppt_funcs->baco_is_support(smu);
>   
> -	mutex_unlock(&smu->mutex);
> -
> -	return ret;
> +	return 0;
>   }
>   
>   static int smu_baco_set_state(void *handle, int state)
> @@ -2850,20 +2649,11 @@ static int smu_baco_set_state(void *handle, int state)
>   		return -EOPNOTSUPP;
>   
>   	if (state == 0) {
> -		mutex_lock(&smu->mutex);
> -
>   		if (smu->ppt_funcs->baco_exit)
>   			ret = smu->ppt_funcs->baco_exit(smu);
> -
> -		mutex_unlock(&smu->mutex);
>   	} else if (state == 1) {
> -		mutex_lock(&smu->mutex);
> -
>   		if (smu->ppt_funcs->baco_enter)
>   			ret = smu->ppt_funcs->baco_enter(smu);
> -
> -		mutex_unlock(&smu->mutex);
> -
>   	} else {
>   		return -EINVAL;
>   	}
> @@ -2882,13 +2672,9 @@ bool smu_mode1_reset_is_support(struct smu_context *smu)
>   	if (!smu->pm_enabled)
>   		return false;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	if (smu->ppt_funcs && smu->ppt_funcs->mode1_reset_is_support)
>   		ret = smu->ppt_funcs->mode1_reset_is_support(smu);
>   
> -	mutex_unlock(&smu->mutex);
> -
>   	return ret;
>   }
>   
> @@ -2899,13 +2685,9 @@ bool smu_mode2_reset_is_support(struct smu_context *smu)
>   	if (!smu->pm_enabled)
>   		return false;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	if (smu->ppt_funcs && smu->ppt_funcs->mode2_reset_is_support)
>   		ret = smu->ppt_funcs->mode2_reset_is_support(smu);
>   
> -	mutex_unlock(&smu->mutex);
> -
>   	return ret;
>   }
>   
> @@ -2916,13 +2698,9 @@ int smu_mode1_reset(struct smu_context *smu)
>   	if (!smu->pm_enabled)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	if (smu->ppt_funcs->mode1_reset)
>   		ret = smu->ppt_funcs->mode1_reset(smu);
>   
> -	mutex_unlock(&smu->mutex);
> -
>   	return ret;
>   }
>   
> @@ -2934,13 +2712,9 @@ static int smu_mode2_reset(void *handle)
>   	if (!smu->pm_enabled)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	if (smu->ppt_funcs->mode2_reset)
>   		ret = smu->ppt_funcs->mode2_reset(smu);
>   
> -	mutex_unlock(&smu->mutex);
> -
>   	if (ret)
>   		dev_err(smu->adev->dev, "Mode2 reset failed!\n");
>   
> @@ -2956,13 +2730,9 @@ static int smu_get_max_sustainable_clocks_by_dc(void *handle,
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	if (smu->ppt_funcs->get_max_sustainable_clocks_by_dc)
>   		ret = smu->ppt_funcs->get_max_sustainable_clocks_by_dc(smu, max_clocks);
>   
> -	mutex_unlock(&smu->mutex);
> -
>   	return ret;
>   }
>   
> @@ -2976,13 +2746,9 @@ static int smu_get_uclk_dpm_states(void *handle,
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	if (smu->ppt_funcs->get_uclk_dpm_states)
>   		ret = smu->ppt_funcs->get_uclk_dpm_states(smu, clock_values_in_khz, num_states);
>   
> -	mutex_unlock(&smu->mutex);
> -
>   	return ret;
>   }
>   
> @@ -2994,13 +2760,9 @@ static enum amd_pm_state_type smu_get_current_power_state(void *handle)
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	if (smu->ppt_funcs->get_current_power_state)
>   		pm_state = smu->ppt_funcs->get_current_power_state(smu);
>   
> -	mutex_unlock(&smu->mutex);
> -
>   	return pm_state;
>   }
>   
> @@ -3013,20 +2775,15 @@ static int smu_get_dpm_clock_table(void *handle,
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	if (smu->ppt_funcs->get_dpm_clock_table)
>   		ret = smu->ppt_funcs->get_dpm_clock_table(smu, clock_table);
>   
> -	mutex_unlock(&smu->mutex);
> -
>   	return ret;
>   }
>   
>   static ssize_t smu_sys_get_gpu_metrics(void *handle, void **table)
>   {
>   	struct smu_context *smu = handle;
> -	ssize_t size;
>   
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
> @@ -3034,13 +2791,7 @@ static ssize_t smu_sys_get_gpu_metrics(void *handle, void **table)
>   	if (!smu->ppt_funcs->get_gpu_metrics)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&smu->mutex);
> -
> -	size = smu->ppt_funcs->get_gpu_metrics(smu, table);
> -
> -	mutex_unlock(&smu->mutex);
> -
> -	return size;
> +	return smu->ppt_funcs->get_gpu_metrics(smu, table);
>   }
>   
>   static int smu_enable_mgpu_fan_boost(void *handle)
> @@ -3051,13 +2802,9 @@ static int smu_enable_mgpu_fan_boost(void *handle)
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&smu->mutex);
> -
>   	if (smu->ppt_funcs->enable_mgpu_fan_boost)
>   		ret = smu->ppt_funcs->enable_mgpu_fan_boost(smu);
>   
> -	mutex_unlock(&smu->mutex);
> -
>   	return ret;
>   }
>   
> @@ -3067,10 +2814,8 @@ static int smu_gfx_state_change_set(void *handle,
>   	struct smu_context *smu = handle;
>   	int ret = 0;
>   
> -	mutex_lock(&smu->mutex);
>   	if (smu->ppt_funcs->gfx_state_change_set)
>   		ret = smu->ppt_funcs->gfx_state_change_set(smu, state);
> -	mutex_unlock(&smu->mutex);
>   
>   	return ret;
>   }
> @@ -3079,10 +2824,8 @@ int smu_handle_passthrough_sbr(struct smu_context *smu, bool enable)
>   {
>   	int ret = 0;
>   
> -	mutex_lock(&smu->mutex);
>   	if (smu->ppt_funcs->smu_handle_passthrough_sbr)
>   		ret = smu->ppt_funcs->smu_handle_passthrough_sbr(smu, enable);
> -	mutex_unlock(&smu->mutex);
>   
>   	return ret;
>   }
> @@ -3091,11 +2834,9 @@ int smu_get_ecc_info(struct smu_context *smu, void *umc_ecc)
>   {
>   	int ret = -EOPNOTSUPP;
>   
> -	mutex_lock(&smu->mutex);
>   	if (smu->ppt_funcs &&
>   		smu->ppt_funcs->get_ecc_info)
>   		ret = smu->ppt_funcs->get_ecc_info(smu, umc_ecc);
> -	mutex_unlock(&smu->mutex);
>   
>   	return ret;
>   
> @@ -3112,12 +2853,10 @@ static int smu_get_prv_buffer_details(void *handle, void **addr, size_t *size)
>   
>   	*addr = NULL;
>   	*size = 0;
> -	mutex_lock(&smu->mutex);
>   	if (memory_pool->bo) {
>   		*addr = memory_pool->cpu_addr;
>   		*size = memory_pool->size;
>   	}
> -	mutex_unlock(&smu->mutex);
>   
>   	return 0;
>   }
> @@ -3181,11 +2920,8 @@ int smu_wait_for_event(struct smu_context *smu, enum smu_event_type event,
>   {
>   	int ret = -EINVAL;
>   
> -	if (smu->ppt_funcs->wait_for_event) {
> -		mutex_lock(&smu->mutex);
> +	if (smu->ppt_funcs->wait_for_event)
>   		ret = smu->ppt_funcs->wait_for_event(smu, event, event_arg);
> -		mutex_unlock(&smu->mutex);
> -	}
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 3fdab6a44901..00760f3c6da5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -488,7 +488,6 @@ struct smu_context
>   	const struct cmn2asic_mapping	*table_map;
>   	const struct cmn2asic_mapping	*pwr_src_map;
>   	const struct cmn2asic_mapping	*workload_map;
> -	struct mutex			mutex;
>   	struct mutex			sensor_lock;
>   	struct mutex			metrics_lock;
>   	struct mutex			message_lock;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index d3963bfe5c89..1b265b8c7996 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -2118,9 +2118,9 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
>   			}
>   		}
>   	}
> -	mutex_lock(&smu->mutex);
> +	mutex_lock(&adev->pm.mutex);
>   	r = smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
> -	mutex_unlock(&smu->mutex);
> +	mutex_unlock(&adev->pm.mutex);
>   	if (r)
>   		goto fail;
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 37e11716e919..5cdf88f3bb6c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2826,9 +2826,9 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
>   			}
>   		}
>   	}
> -	mutex_lock(&smu->mutex);
> +	mutex_lock(&adev->pm.mutex);
>   	r = smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
> -	mutex_unlock(&smu->mutex);
> +	mutex_unlock(&adev->pm.mutex);
>   	if (r)
>   		goto fail;
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index c29353e05fd2..5c0ad4dd6543 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -3497,9 +3497,9 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
>   			}
>   		}
>   	}
> -	mutex_lock(&smu->mutex);
> +	mutex_lock(&adev->pm.mutex);
>   	r = smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
> -	mutex_unlock(&smu->mutex);
> +	mutex_unlock(&adev->pm.mutex);
>   	if (r)
>   		goto fail;
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index ac8ba5e0e697..3085a07e70d2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1521,9 +1521,9 @@ static int aldebaran_i2c_xfer(struct i2c_adapter *i2c_adap,
>   			}
>   		}
>   	}
> -	mutex_lock(&smu->mutex);
> +	mutex_lock(&adev->pm.mutex);
>   	r = smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
> -	mutex_unlock(&smu->mutex);
> +	mutex_unlock(&adev->pm.mutex);
>   	if (r)
>   		goto fail;
>   
> 
