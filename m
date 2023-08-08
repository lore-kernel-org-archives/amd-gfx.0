Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB7DFC04A94
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 10:12:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AEC110E04E;
	Tue,  8 Aug 2023 10:12:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 495DB10E04E
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 10:12:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0+YdwJTl+AE7KpoQvnjfEx44g2WLj4r3felPMndedke5Sjo4c+VtzMfZUCQiUjMbLIWngQD4tVxXwdwj1oBalm9BaiwdgGttX3hziF2Lvr0wCKe1FlytNuUkYieopTbRdsD1HYle8GZRZsRWsoE1XzJX7bwiYGAV7fzvoX7jEqM+oN5n52Hv5Ca426tmUR/gTeVLpJcoslmWE7O9LmM8zpYyiYbq8VZ1gWvgumQKOyw8zS6i49X1QaGJoE/i+pS6lDn1hSo1BXv3C7/yf+HbhGiAmNt2r+Hg4Uz6CGSJ6dffVFyq9Hilp52tWKM4jgSaRp71I9K9c10YCw3OJMceQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMT6AOWO0mEdQ+BlQOCc+qWZxkfG2rgYTCTJrO8+UPw=;
 b=RrKhX3AD2jiO6ATsQ/iANJz3Urjkp9bjtjb2kIPEq0FZDpvJ081SGWEBCM/XWO2JBeZuVRnAwuLJ/00U5QBuc88w9AN/uBf/oG5UmyEHzFE38abaPgwhXrinqflzN13lbnj79Mhpw/rTWBqIV+fZMtWn7rF6DrMjk2XpAUueYQonz66XDXHMMCGwW3iJiw2mtsgwYEZqBbyXnJvkjd+h5tHPJHIf9498oQ1i1phGPvvRe4Ou3CtEzd5xUl+Nh8PMIgBUDDEurkHv4aTegX8cZsG91TU2fxZpRBy75E14ftXXVjGzvAg9T1nXk7MPzTmjw+YGzE+vkKdTBuLF1C4yZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMT6AOWO0mEdQ+BlQOCc+qWZxkfG2rgYTCTJrO8+UPw=;
 b=tooIF31zIPGSfmtXZcFcbJ2U3orkuxUPyMLtxlo1TGWfiETVE7s1NsgMKCR+ApNoCCvxGxy9OSnfOyLR4krnHJwQa2j4r7PUlsf6tocAe8fMtSPmJFV3KOpCtu0+/aB5cQ887cObJwCYOh4N4cRvWMVUlLzFr0PPsm6EgfsLV+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 10:12:24 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::ba40:7dba:9b00:ff16]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::ba40:7dba:9b00:ff16%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 10:12:26 +0000
Message-ID: <16b7e768-dbb6-9e6b-e6a4-80c683a11461@amd.com>
Date: Tue, 8 Aug 2023 15:42:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amd/pm: disallow the fan setting if there is no fan
 on smu13
Content-Language: en-US
To: Kenneth Feng <kenneth.feng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230808075150.227155-1-kenneth.feng@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230808075150.227155-1-kenneth.feng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0195.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::23) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|BY5PR12MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: e70b15b7-13a2-4831-48e0-08db97f7f6c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hV5Jl0UH6HYsvpIIrw/4x2GCwPY+SLiBtMMUPP9A1Ik8SFvgk9bEd8vv+VBsExL0qzfgq4if7yiMj1cCipT5Z9ATWv3EGJGv6FMoSEpa3VjRxf9UOSCGSzmCMFBSKESy+BqBPiQCLNanUw9wcfr1VNMtHN4pRRDhsJ1s4jMArioAz6kvDh/t1TURl3tVLPjhSv2uV+kIyf6jQYfblqfyIjG6tHcSfj1WqUDYLVAAMUeeKscUbjhjbWNsc8SqUtH6WMnC5kjAgXzzdF0MKL2brjf8hDIdl2f3XvQOt4AEl6ixgo/sP8X16mbL+apfzlfcwq60cvow6y8uj8txt/TCWEsh2EeJlulddp2ge2I8fT8im3t9FnIzPYk87Gp6ZV99riMIWj/lGfT3pRlWaJehx03Rlefe2l+fWhKbRW46ZKuKta9Wiwyjn8O6AGeUZszRPTi6ac1D5hyRe962sta4chkwgTq7puKmZC7Y71K5zsn2P5qcHMg/IySh6l6l/90qs+aXv0PCsh3FzpoC6KDvcbtxkFzgLC/EeZMRDJKJbz3yw5D0oCekAjsPn4T2xtMSZFMCmY0jdE+v+R1KfQgqCY/YYVxXD8AJitVf3EFlbnhfDCfSOnBd/XdZ8SriPSl/icflSjh1FL7Ei2y/Cn4Lew==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(1800799003)(186006)(451199021)(41300700001)(26005)(2906002)(5660300002)(31686004)(83380400001)(8676002)(8936002)(2616005)(316002)(53546011)(31696002)(478600001)(6506007)(38100700002)(6486002)(66476007)(66556008)(6666004)(86362001)(66946007)(6512007)(4326008)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzNzNm9KL1kxN0R2S1FhNHdBNjhJZG5yYm5NNE9GUUlrTDk4aHpNUHhhazM1?=
 =?utf-8?B?QlU0ZytSaFVsT2dYcTQvVkZmOXRDTytuUWxPeFRhNWU0NWIzUm8wVUJBOGVX?=
 =?utf-8?B?ODVkQ0lubTEvMllQS2I4MlhnaExNRCtpSERvbkZoalBYdU5kdU00RE9JTVYz?=
 =?utf-8?B?d1IyVkhiVVBBMS9BVWF0T0tyME94TzVzakx3OGJBNloxcGI5NGdYU1pNcVcr?=
 =?utf-8?B?SElXYzFRdnEwTGd2ZTRHa1VoQzNnZS9STXZoTVN4Yk94SzVtOXV1MkRlQThk?=
 =?utf-8?B?WkRwNUM5SHQwdVpqQ0p6TEsweWR3OU1tZXdNeG40Y1dKZS9aakFCb0hJZzcw?=
 =?utf-8?B?SjcwUzVsVE9md3c3bEFFdkZ6SnpXR2M1QjJKZkhEUVppYTdYV3dnb3A3S0NH?=
 =?utf-8?B?eXd2RGJqVXVrOWFaczRmaEtGWE1hR2hvV2xTNWNHRUF3OHIwNGw0OHJXSXI0?=
 =?utf-8?B?UkVPSnlmbDQ5OW9oZGVuanphUUJwcWI5TmVBN0VjUmU5aG9Ua3RTRHYwRFQr?=
 =?utf-8?B?ckZpTnFuQUh4VzlsTDI5Y0lkeS8rcDJTK2VTbENSOE01U1BuS1FsQTh4bEl2?=
 =?utf-8?B?MVMyZnc1dDRBUUFPZ1ZNQ3dqU2hpNkNYdnRidTBnL2Rld3dXMGRrVkZNUk14?=
 =?utf-8?B?SU9Kd0dvQ0piRFUzK3pSaTBqeW1sTW1NNTIwV1JZUkpjZVRjRkp0OFIwL3k3?=
 =?utf-8?B?Rm40emRONVVjZmxwQVFCYysrL1pUVUJwRGN4R2Y2bktqWEkrYnozZzJEUHFh?=
 =?utf-8?B?dWxBaitYZmZNZWc5SDBHRHVZNmM0RnRrVFkvR0cvSnhmTDlOUkM5a2g3aXJa?=
 =?utf-8?B?dVIwemROc2thZyt1NGxWSXNiU1JHVG1UY3lpdVlNdi93THArQzg4cHFzSlRK?=
 =?utf-8?B?d2t3MGZOOUVIREVSMnNSK21EaTY3YkxnWVBVeTYrWHk2eENxNEFKWWJoM3lE?=
 =?utf-8?B?WXFjZDFzbHhhYllzRUtWc0ZFK1hDMnlDSnI0amtuSW9OQ3ByaENXNHhiS2dh?=
 =?utf-8?B?dUlQZXU3SDM4bEV0Qmg4blhQTjNBZmxWK3ErSC84VGZJQjBqd2Z0TnRvS3lk?=
 =?utf-8?B?TTRLc1B6RmVHQ3EzcnptTTZoNnpPd3Y4cTFXVVlMOEFDdjZwc25FN2F4MHpZ?=
 =?utf-8?B?VUFxZmZlTk9yc2dLNTArNmJrYllmbFR0Z2hHNVpkU0FGTUhqRlhNWVhqTDg1?=
 =?utf-8?B?ZWQ0Rm5Ub3k0ZFdKM2owNTNaMFdMOERpSzBLRyt5Z0lJZzM5Q0hVN0Q0bWQy?=
 =?utf-8?B?Y2JEeUl5RitiRm5TVHYxMUcvSnFJa3FuRmNraEM4b0FHY0J4RkhBV1NvbUtP?=
 =?utf-8?B?aXNpUU1UaU50OEtnbkZBaGVSRG5IVlE2dEhpb2J4cTlDb0V4b3BxUkJNNzdS?=
 =?utf-8?B?b3ZMYmlmMTZ6bE1BUlc1c0hpUlNYZmV0bUJlZCs3YjhqUjNQTDRNRFJDMUFk?=
 =?utf-8?B?VVM5SGVZT290d1FFb0puNjZUTmdyQWNHT0t2ZVBKcnVxcTZFazl5TU9YR3pR?=
 =?utf-8?B?dlErVVpZQnNQN1pqOHcrYlFlSVQ3bllHV3N5Q1g2bzFvdXBvMmluZWljenJw?=
 =?utf-8?B?eitZSTErUXRQZytyUjVBbDQyTTQ2VXlXSVYxSCtlbHhkTHhPU3c0cGE4TXZL?=
 =?utf-8?B?d2cvb2dCRzVzN1AxaVFFTUlocm5OUTVnUTZOYzlMdy9zZ0hCMi9ySmlTSEcw?=
 =?utf-8?B?eVB1RXZaUCtKaE02YkI1RGZ5OERjK2NwRkU4OTloQ29IN2x3ZUxENEpsVTU2?=
 =?utf-8?B?aldYaW1JcVByQWgxNk9CM2dOTzhMeDVaQnBWRFBIeTMvVEdaTHhJMUZyZnhy?=
 =?utf-8?B?VVh1S0lVN3hLZ3pGZlNiRzl2UllEOEJEeUJMRHEycGh4YVFLNEd2SWxBS1Qz?=
 =?utf-8?B?SzFnNXFSZVBCVzZOMFJ2VURzK0syWXVwbGtINUFjbU1jVzRqa01yVTVDT2VV?=
 =?utf-8?B?a1dIcFJMdExjbjNkakNTdzVkaWxCWHBMU1lCNmZoZnAwK09YOHRoYm9UNG5r?=
 =?utf-8?B?VkRKandFL1g2S0FRbU1QT2JlQVh3MEx3TktXYzEzYlhGWWtIZkZ6NThQVko3?=
 =?utf-8?B?ejBRRGFTUUNDVFc5cm1ZRzNDRVVZU1dWaG9YQUtWMGYrN3kwRi82bHRkVTE5?=
 =?utf-8?Q?Npt97iBMthuDS1lX4Yp75LQ8Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e70b15b7-13a2-4831-48e0-08db97f7f6c5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 10:12:26.0661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zyJfKIj+Ljc+jn4jJr/sdORWERlZxtgc60evW2Lb2jKWMlkIHMZyezCFW9tvKmaA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275
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
Cc: maisam.arif@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 8/8/2023 1:21 PM, Kenneth Feng wrote:
> disallow the fan setting if there is no fan on smu13
> 
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 9b62b45ebb7f..09ef0a7e7679 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -1131,7 +1131,9 @@ smu_v13_0_display_clock_voltage_request(struct smu_context *smu,
>   
>   uint32_t smu_v13_0_get_fan_control_mode(struct smu_context *smu)
>   {
> -	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_FAN_CONTROL_BIT))
> +	if (!smu_cmn_feature_is_supported(smu, SMU_FEATURE_FAN_CONTROL_BIT))
> +		return AMD_FAN_CTRL_NONE;

If there is no PMFW fan control, isn't it better to set pm.no_fan?

Thanks,
Lijo

> +	else if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_FAN_CONTROL_BIT))
>   		return AMD_FAN_CTRL_MANUAL;
>   	else
>   		return AMD_FAN_CTRL_AUTO;
> @@ -1143,7 +1145,7 @@ smu_v13_0_auto_fan_control(struct smu_context *smu, bool auto_fan_control)
>   	int ret = 0;
>   
>   	if (!smu_cmn_feature_is_supported(smu, SMU_FEATURE_FAN_CONTROL_BIT))
> -		return 0;
> +		return -EINVAL;
>   
>   	ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_FAN_CONTROL_BIT, auto_fan_control);
>   	if (ret)
> @@ -1204,7 +1206,8 @@ smu_v13_0_set_fan_control_mode(struct smu_context *smu,
>   
>   	switch (mode) {
>   	case AMD_FAN_CTRL_NONE:
> -		ret = smu_v13_0_set_fan_speed_pwm(smu, 255);
> +		if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_FAN_CONTROL_BIT))
> +			ret = -EINVAL;
>   		break;
>   	case AMD_FAN_CTRL_MANUAL:
>   		ret = smu_v13_0_auto_fan_control(smu, 0);
