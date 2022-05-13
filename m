Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE333C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 12:46:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 276A410EE5D;
	Fri, 13 May 2022 12:46:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EA2210EE5D
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 12:46:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wop/1Pv1wzV10rg979rjKstaqHCR5kP7rqtyrBpV3pR+10iCkDbQNirFHfYLBcglkK30OCK8UyoZaaG8UXix//jV4d+nYHt3p189f2YnNmhYEr771aG8jWnm5ZhFScC7t9VoiN6pPsdSu6N/dPvxkJL0bR/crueTTvOL/FrSCVKpL2s6o5jZiWNLfob7ak6M/9ZTZkmi+b68TXBQlPtjOyVOGpTiUeo9mcywu0+GCBb/13WxUp/BvUkiMMzBhayF4THNpJ/H11yFuT6Xw65un6Fh9BjyQ02vY0FIHbhzlAXS9eZcbJR8Xhfng+EB7NQgqSDa0vOMI/4H1Pm2PkjgKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sN6kDC5wY6KXu+lj8YP9ZWDtUhmpp+d/SzAh+MSXgYo=;
 b=c26DbSRXaqu7ikxq/ImgL7DvwefCXwCVV/JeM8VGnsh6RQ3f7sNHSyRWrCmPoLY2DLna1VclOVxbzEfQKVfuy3dmExhDxuPUPgL/cTHuAIAsI+jjKWYUyOEkm9KpkJ/RsCyq+OvKg5UM9s1rgPADZZsnoZX0+dQars8YAeQ41ZDKlcAEogSt3vXpcXCWhEsppmTieCu/CeOsoyDJ0hIM7RbB/RQcfbsnX8wu3OMhO+1UfYxtZd/vHsQptcN/k3kc37XxqEfJBAz5AjEDLEU/UGRGsX0MuZ//K7Xb4FqNSBTlAmJGvG75Co/95ke0AObAgkL7vXAgyfakKBZ50YnZBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sN6kDC5wY6KXu+lj8YP9ZWDtUhmpp+d/SzAh+MSXgYo=;
 b=qOog07h7h0D1jUoZAR4eiLhQ+/1AAsYQ3eqUdzJ7MxQEIgL7QfZO4z675/hRBD+wd65urJ7Axwknx0dsRIEcrb8IMdTRHalsWt1Eu4qlk056wmtKkN8v3ELfMyQnJsyw4wY33kMe/BWJN8Lcq4pKeDZkOvW6N7VnBJQC2AM9qn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BY5PR12MB4801.namprd12.prod.outlook.com (2603:10b6:a03:1b1::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 12:46:19 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f%5]) with mapi id 15.20.5227.023; Fri, 13 May 2022
 12:46:19 +0000
Message-ID: <2e7788af-0291-4e9e-c4db-bc4d3533c6e5@amd.com>
Date: Fri, 13 May 2022 18:16:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] drm/amd/pm: consistent approach for smartshift
Content-Language: en-US
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220513095913.512256-1-sathishkumar.sundararaju@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220513095913.512256-1-sathishkumar.sundararaju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::15) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e45453f4-2707-499f-caa2-08da34de93ab
X-MS-TrafficTypeDiagnostic: BY5PR12MB4801:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4801472035B1E41B14D7627F97CA9@BY5PR12MB4801.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m2O6QdMgR+38qan0/6YszqUyYHk5/QTwYvJK91qziZTBrCvWzi1fieDcpzLM4uPBjR/pPqrxCvFd+zccRN63nbwpmRnNLzh1iNa8peqMC03eOypGwG8d4+IoEXJAAsRQBT4d7pZtRrySN1GrtYiBoJcVUz7gCwqCfTftI8hi0a1FFa6SjNFlgNIrJFZ2O4xreeq8jPMwvG/wE9riLYXoVTUPBY3Z4owVJUS8yWUZ4/MJxRv08FYQvwLDZK/M2oVnbUntqrJm3IXFqrZXSjdXkqsxpj5aWUmZerbQG/xyh6CRCMcHwrKY3X1ENkSes+wxAs+j/NJ3eqrL4xZlXot/Htc8JBFKsZ4mUlKtQuS+PM34IHGyCTF6B5kpT7yjkdn2gza6QmtiBpKVWHBS2QSK5i09ILAT6Oqw2oK0ShAlJC6eniUk2a1i7x06EL2HnFy6/g+2RGnrjl5d1qjpGHe/xotrV4/3hylIzYk7j1fSw8I/EiayzpTYcr8V+bikgk9huxXti/+StwQE++dtI2UG23fFTqIIyI6d7Pv0zdkLUJJr52jGCC9deK4KUQ4gOdJ56SJKXsrj6rKEYfyYgKb6A8mZfcqFYB6yc7RaCzs/LafYdlilyYyYo/Pe3udDnvXvOfSk6rY9+chOM9U45/JMJChqt7ArniF1OfZyo25UciKAFb5Fx900ZAcWkdIeo7qd9+bTPh2hnW9F7WxHftOg5Q3OG6FBHji0hz0YdzLSEOjPIalpSQ/ur1pGGT8MvAjD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(36756003)(31686004)(2906002)(53546011)(6506007)(31696002)(86362001)(2616005)(26005)(38100700002)(6666004)(6512007)(8936002)(186003)(8676002)(66476007)(66556008)(83380400001)(508600001)(4326008)(66946007)(5660300002)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTNXMmU4STNtMlJ3d2FWQTJHTnI2SnlRZ3dVcnE5TUsxUWlpTDhyckZzVHhi?=
 =?utf-8?B?a2wwRWgwVlBSMUQ2MGRPc2hINitLRi85R0VyZFBzdjVPZVFZS1BxOG9IUUk5?=
 =?utf-8?B?blFnVElYN1YwU1lMSWdNSXY3dFlaclNVZXF3T2E3NGtFSTJVR09YZjFkMmFk?=
 =?utf-8?B?dm9JVlM1TmtvSitOcXA5QnVnNnZqZXZqMk1VbDYyejlIMFZaWkc0c25QNGxN?=
 =?utf-8?B?dFR0VmV4RHQwcm5kVzFlcFl2U1RNc2JYNWx4Nkt1M2ovU0MzT1llRlErRkRO?=
 =?utf-8?B?TTdhR04xYVNKZEpjY0M5cm02N3lQczZjZEFTSHhZK044Qi9MRXpSbjQrZFhC?=
 =?utf-8?B?RlVSYXVESU5nNU45SlhHbGc3MGJXais2Z1ZmS2RpWHcvczlEQW1hQnBrblQ3?=
 =?utf-8?B?dEN6YVRYbjYzYnRVWHJwbUtRTXhoMFFRd2VFNmttbnF6KzFhVVhxanNJcWxF?=
 =?utf-8?B?WjJaaUt1L0c0K3cycHhzeS9OT21PNStGc2NlK0N5QW1sVlRCY3M1MXFoYnJF?=
 =?utf-8?B?bmJJRVo4bm55QTZzeEYvTDRVMFVJUSs0b3l4QTZDNlF4QTRMY3hlRjJYcmFj?=
 =?utf-8?B?SnE3UnVQYVFNQlMzQU5PYjdUcVFKOTFPV25Dd3pkdElZMm5XcmI5b0pEU01X?=
 =?utf-8?B?cTlNOVZyZnVoY1FDOU9ZU1gwTzlaUXdDUXUzMHN2cURTN3BHK1hid2dQdUEv?=
 =?utf-8?B?cE5kZHU3bllVb2ptb3gyK25pVHBEOWRiRmRGS2poRmQ5VGdpM25xMVpTQ2J0?=
 =?utf-8?B?ME9qVUdqSVlFWDNVZVVkOE43T0NETnpHWnF0dUZNbytnQXVEZERTdEZhd1Bh?=
 =?utf-8?B?TUw3TDB2a0NiakZYeFJab1NqSmd6V2NLZWEydFd6cks4NUpmZVpESkx4WUxm?=
 =?utf-8?B?V2VaSTkyd0t0RUhPSFExVFQzd2lWcThXdVJTQ1BEdTl4Znc5SnFacDB5aHFT?=
 =?utf-8?B?czJhR2p0dktCeTdXNkhJQXJvdk8zNGkzalRnbHlnSVFpUWlEdGg3ZzBSL204?=
 =?utf-8?B?YmE3cUx4b0hlRlg3NDBIWGtGc3dyY0tEVHlPSUxtNXFuSWQzeHJ6b2ZObm0v?=
 =?utf-8?B?dDlCQXRmK21NTUROVTlPc2lOZUR3OWpXQ1MwaGVRSFNiS0FIZFltcXlCQnk4?=
 =?utf-8?B?bmJGNzM2S000SHJFQ05lZEFIb3NxVlhqaERvdi9tKzFhekd5bHIwL2FFWHhp?=
 =?utf-8?B?cWIwamFhK0FqKzhhWDFzclpFeEZTQUNDZGhtOUxZZlljeVdrQnFrM0V2b1Ux?=
 =?utf-8?B?eGt5UnJpcjVVRW5JNlRpRitwK3YxMmdUamt0TkZSa1JFMFowNjNrUmZSZFJR?=
 =?utf-8?B?REpSZGoxZDRINFdNWDZ2eDQzOGVsRXg3ZGprYStBNi9NMzNybGkzOGE4bkdW?=
 =?utf-8?B?cjVSY3VIUmNnbEUxeFl5cnM3MFV2R1FtQkh0bXI2U0JJeTE1M05oOXhXak52?=
 =?utf-8?B?MXBGNWI2bms0cktvTmwvSUI5UHBHdVAzOUhxdysxMDlhTzl3RjE0S2FBMmd0?=
 =?utf-8?B?M29UMUd5SVVPZ01HTHcyWFdJQkZWZUM2L0RVcE0wbFBVMHNwUGI3K010cEhP?=
 =?utf-8?B?MzB4STVwUndWYkh6K3FrZHZYenpna2J2SWZaYWpzZTROcDlFVE1yZlRGT1NJ?=
 =?utf-8?B?eG11a0lQZWlQMWp5Y2JqNkNpM3dGM1VzMEowR2hSQ1lVY2JOUy9DT05DcC9K?=
 =?utf-8?B?bDRIb1RuNkFhczVYYk9JN25sTzVNbVEzTUlhSXVTMm1iSFBrNlRSaFFndVE1?=
 =?utf-8?B?amtOTlZ4N3B6ZUVOdW9zeUJhV2xRbmNHR2pPckMrQTB1WTFvVE9jWHBoUlR1?=
 =?utf-8?B?K3VHUmlWc0VYN1ZQelZBeG5jaWhCRks0S2p3dmtMSXBXb0diRWMwYkEydlNX?=
 =?utf-8?B?cXZNMjlYTVZQbVp6Qm4xU2t6NDNlNVJZc2ZGa0VWU2pRRjdRRUNvK3haMXYy?=
 =?utf-8?B?dDBFbExUVEovVUNiM0RGR2RxVFdnMTdoRUVoaTM1eUM2TTc2cGk3ZkNUeXdr?=
 =?utf-8?B?RW9ySVVzUmRyZVJZMkw5SGppS1EyRHJDVlBqcEtXd05vbVRkdTUrc0Y3VE5U?=
 =?utf-8?B?WU9JeVJzVU41UFJnQXpHUk8zMDBRVUNOV2wrbXFpbjZYM0FvZlVMWlpnWXFD?=
 =?utf-8?B?TDdZWjlDbU5IaWZJOFNGZndjZHN4SzIxUitVTUlqUlFWUEd6dzRjYmFGZmhx?=
 =?utf-8?B?d1hZaE1Rb2tNUHpxUDZnWWpsMGVFWFhrNEl4VDY3RWlOTXhmREkrL3VpNFoy?=
 =?utf-8?B?Q3E3bVprVk9DVlBuWGdZTm1rWm5LT1d4amJScERsZ25Xcnk5RkpndlNHbFJz?=
 =?utf-8?B?bHZGZUozUW9nQWFZQkVVcDRwR240K0xpdHFSRjN6SHJFc3gxTXgvZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e45453f4-2707-499f-caa2-08da34de93ab
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 12:46:19.5458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4D3OQ6q2hFFoFebwDTMNWuCa0NPAr+G9YUf3eVraV9nse1ur3dVEnsxJKWbkvOT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4801
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/13/2022 3:29 PM, Sathishkumar S wrote:
> create smartshift sysfs attributes from dGPU device even
> on smartshift 1.0 platform to be consistent. Do not populate
> the attributes on platforms that have APU only but not dGPU
> or vice versa.
> 
> V2:
>   avoid checking for the number of VGA/DISPLAY devices (Lijo)
>   move code to read from dGPU or APU into a function and reuse (Lijo)
> 
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 130 ++++++++++++++---------------
>   1 file changed, 62 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index d3228216b2da..5e318b3f6c0f 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1734,22 +1734,11 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
>   	return size;
>   }
>   
> -/**
> - * DOC: smartshift_apu_power
> - *
> - * The amdgpu driver provides a sysfs API for reporting APU power
> - * share if it supports smartshift. The value is expressed as
> - * the proportion of stapm limit where stapm limit is the total APU
> - * power limit. The result is in percentage. If APU power is 130% of
> - * STAPM, then APU is using 30% of the dGPU's headroom.
> - */
> -
> -static ssize_t amdgpu_get_smartshift_apu_power(struct device *dev, struct device_attribute *attr,
> -					       char *buf)
> +static int amdgpu_device_read_powershift(struct amdgpu_device *adev,
> +						uint32_t *ss_power, bool dgpu_share)
>   {
> -	struct drm_device *ddev = dev_get_drvdata(dev);
> -	struct amdgpu_device *adev = drm_to_adev(ddev);
> -	uint32_t ss_power, size;
> +	struct drm_device *ddev = adev_to_drm(adev);
> +	uint32_t size;
>   	int r = 0;
>   
>   	if (amdgpu_in_reset(adev))
> @@ -1763,61 +1752,77 @@ static ssize_t amdgpu_get_smartshift_apu_power(struct device *dev, struct device
>   		return r;
>   	}
>   
> -	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_APU_SHARE,
> -				   (void *)&ss_power, &size);
> -	if (r)
> -		goto out;
> -
> -	r = sysfs_emit(buf, "%u%%\n", ss_power);
> +	if (dgpu_share)
> +		r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
> +				   (void *)ss_power, &size);
> +	else
> +		r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_APU_SHARE,
> +				   (void *)ss_power, &size);
>   
> -out:
>   	pm_runtime_mark_last_busy(ddev->dev);
>   	pm_runtime_put_autosuspend(ddev->dev);
>   	return r;
>   }
>   
> -/**
> - * DOC: smartshift_dgpu_power
> - *
> - * The amdgpu driver provides a sysfs API for reporting the dGPU power
> - * share if the device is in HG and supports smartshift. The value
> - * is expressed as the proportion of stapm limit where stapm limit
> - * is the total APU power limit. The value is in percentage. If dGPU
> - * power is 20% higher than STAPM power(120%), it's using 20% of the
> - * APU's power headroom.
> - */
> -
> -static ssize_t amdgpu_get_smartshift_dgpu_power(struct device *dev, struct device_attribute *attr,
> -						char *buf)
> +static int amdgpu_show_powershift_percent(struct device *dev,
> +					char *buf, bool dgpu_share)
>   {
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
> -	uint32_t ss_power, size;
> -	int r = 0;
> -
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
> -	r = pm_runtime_get_sync(ddev->dev);
> -	if (r < 0) {
> -		pm_runtime_put_autosuspend(ddev->dev);
> -		return r;
> +	uint32_t ss_power;
> +	int r = 0, i;
> +
> +	r = amdgpu_device_read_powershift(adev, &ss_power, dgpu_share);
> +	if (r == -EOPNOTSUPP) {
> +		/* sensor not available on dGPU, try to read from APU */
> +		adev = NULL;
> +		mutex_lock(&mgpu_info.mutex);
> +		for (i = 0; i < mgpu_info.num_gpu; i++) {
> +			if (mgpu_info.gpu_ins[i].adev->flags & AMD_IS_APU) {
> +				adev = mgpu_info.gpu_ins[i].adev;
> +				break;
> +			}
> +		}
> +		mutex_unlock(&mgpu_info.mutex);
> +		if (adev)
> +			r = amdgpu_device_read_powershift(adev, &ss_power, dgpu_share);
>   	}
>   
> -	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
> -				   (void *)&ss_power, &size);
> +	if (!r)
> +		r = sysfs_emit(buf, "%u%%\n", ss_power);
>   
> -	if (r)
> -		goto out;
> +	return r;
> +}
> +/**
> + * DOC: smartshift_apu_power
> + *
> + * The amdgpu driver provides a sysfs API for reporting APU power
> + * shift in percentage if platform supports smartshift. Value 0 means that
> + * there is no powershift and values between [1-100] means that the power
> + * is shifted to APU, the percentage of boost is with respect to APU power
> + * limit on the platform.
> + */
>   
> -	r = sysfs_emit(buf, "%u%%\n", ss_power);
> +static ssize_t amdgpu_get_smartshift_apu_power(struct device *dev, struct device_attribute *attr,
> +					       char *buf)
> +{
> +	return amdgpu_show_powershift_percent(dev, buf, false);
> +}
>   
> -out:
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
> -	return r;
> +/**
> + * DOC: smartshift_dgpu_power
> + *
> + * The amdgpu driver provides a sysfs API for reporting dGPU power
> + * shift in percentage if platform supports smartshift. Value 0 means that
> + * there is no powershift and values between [1-100] means that the power is
> + * shifted to dGPU, the percentage of boost is with respect to dGPU power
> + * limit on the platform.
> + */
> +
> +static ssize_t amdgpu_get_smartshift_dgpu_power(struct device *dev, struct device_attribute *attr,
> +						char *buf)
> +{
> +	return amdgpu_show_powershift_percent(dev, buf, true);
>   }
>   
>   /**
> @@ -1884,18 +1889,7 @@ static ssize_t amdgpu_set_smartshift_bias(struct device *dev,
>   static int ss_power_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
>   				uint32_t mask, enum amdgpu_device_attr_states *states)
>   {
> -	uint32_t ss_power, size;
> -
> -	if (!amdgpu_acpi_is_power_shift_control_supported())
> -		*states = ATTR_STATE_UNSUPPORTED;
> -	else if ((adev->flags & AMD_IS_PX) &&
> -		 !amdgpu_device_supports_smart_shift(adev_to_drm(adev)))
> -		*states = ATTR_STATE_UNSUPPORTED;
> -	else if (amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_APU_SHARE,
> -		 (void *)&ss_power, &size))
> -		*states = ATTR_STATE_UNSUPPORTED;
> -	else if (amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
> -		 (void *)&ss_power, &size))
> +	if (!amdgpu_device_supports_smart_shift(adev_to_drm(adev)))
>   		*states = ATTR_STATE_UNSUPPORTED;
>   
>   	return 0;
> 
