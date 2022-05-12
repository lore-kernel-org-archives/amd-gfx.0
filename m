Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250D6C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 08:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C145910E2C2;
	Thu, 12 May 2022 08:21:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67B9B10E2C2
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 08:21:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCKI87jGOhbz38TX4qNHQT92HszqHexs8iJ7MqJ5U6QAAAtF5Z+pg/ogEn5rvEnXTbrFxEs0U80JEDOEevMynYxJcGfJUBqlsLhfSDXMEZd0tFgfvDyKk5H+R4v2BWY13o2TrsLk6PM7QcTCqkRi3nB/JkNoAnFJ6MKZF8ztqgRDTFZJmE5IY7OSccuXMldPACTHTznz9EcwTFs4xpkEPHZeRbsYQtt5LObGicd40aqzosf5yJumhyn7Jx83qtfsqtK6HTGJr3QICtSCiMIbE8A7KzXjvi+CU6d5i6jFB52U3NJUDo11vyzYaHnHn31CGF+JBx0rt87gv2YZ8MHQJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+idrlA9P5tcRfW501FK9ZCKPJ+F3wTR+L20MMA8epG0=;
 b=k+5M5CWrHLMxzte+TNi89Wn5E0+DVUoUB8kfmK0xOU/bx6kA7f8sR8pfEK+vMuSq93ONrl9anv7dJ2dKlo9ZuMnEWj//fGzmHF7wUKQuFxCRizcd+9HiiRezpvcRLtAvaJ3Wj2vil0pOtdlgnA9Ylby1DI2gppuFS40FJMmCM2eqlhLAvJnHXFVCaXSxA5JZBDUHaRvKJt3Yayvxybnwds9f+cAU7YlUQULcwiAYqOf8NoHa9t39Ko5F9EFx/ccb4kFp4E6yKdeU14zLJC5/coZBrBIbva4eQ3Tfs3VoIN+zaklDscrALN1ZVtQZVkVl92w413GHV042snvU3LkU0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+idrlA9P5tcRfW501FK9ZCKPJ+F3wTR+L20MMA8epG0=;
 b=RTJMC5uSnxy+8xdYwFGEDjzI2VRhsXM2NXhGzYWEpq/KMqFJdfLa1YEQgbjsUuclE0NLw0w1oJg6q/NoicNsNubs29nYcHjBCCkypf7we45RuVntntZLKiRKVipwdv1/SFd/Po+1RpDkECGji722x1XyALc/J1IPwVnsskhAzIo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM6PR12MB2796.namprd12.prod.outlook.com (2603:10b6:5:50::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Thu, 12 May
 2022 08:21:05 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f%5]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 08:21:04 +0000
Message-ID: <1ba333ef-cb03-10a5-abf3-ef02b7ed2d47@amd.com>
Date: Thu, 12 May 2022 13:50:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/pm: consistent approach for smartshift
Content-Language: en-US
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220511122517.2546133-1-sathishkumar.sundararaju@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220511122517.2546133-1-sathishkumar.sundararaju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::6) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f2b9cb4-f5fc-491e-a9b8-08da33f05b23
X-MS-TrafficTypeDiagnostic: DM6PR12MB2796:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB27963176BFFC96268901DC2F97CB9@DM6PR12MB2796.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mpMrF3TnjIWtPAICZratSrXtXafYLaDEVOJUf6Shw/BsekCu/OaNN7K2xVJrg0kWPxi9cJgYp/+VRFGkrO6UpyWukU8R+5VeHRoJLO+QQ37H2UBEKdvV7Qr8gzbfMyiIzazV6bRULdY4ri9crHo+zZTAYeJKlnCbiFbCdizaSqwmceWTUiBzOYZO0PLwvIKWNiVZ5M1fCF8/oaVjP9VakIJSqYqsOPSY2wwdihDWpBs3e8YNWD3ueQ/vdXW9oziwHUuPoXhkcQh8ovqMzKgOUU4ToBYRFOEy2QACSoD/rLKCNeOC980KacvUGX4Km3yzk9gYyhSfuGhC1Q7rUdDNDis0HDxsJGFVNYP602gAiC9O/f0zhMl/VKQNZSWSlTxkSln2DomBsSIZR9UGQ0gbII+MvxyAdDz1IwukjSwDdpCEgv/9ordwG5J0ari23OsIkRiaHFpxJ2CdCy8ZpV1wWTjvPWBgaoNHobuKSuf8kc6MsXkCfzF9wMAX/Ls6NE3bBA5IBFtNXl+QZd2EOmWtzF4y33g1GTu50AlP9jJQZynplIzIIGcnFdAVut5805NFy31TcaF2emcPLjQJ+36EwcVyN61NByGD6bsQZwzAhBs9MzU+dSDzirYXWh2qmsTOdezIjAzPt0c3qbzhru/B0iYx/sDXqqqm08a+VCCMzFewU2K71sLujzR3CMHyRxs0Oh/z3Hf7mHqLQ2VLKRDg8uemKwnFQm8D5lV1G1V9IVoSkN6ysmwsJ6ljJs6SM/X5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(5660300002)(26005)(31696002)(6486002)(38100700002)(508600001)(316002)(8936002)(2906002)(31686004)(6512007)(36756003)(6666004)(186003)(2616005)(4326008)(66556008)(66946007)(53546011)(8676002)(83380400001)(66476007)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHI5NjBoMEpWVjRTUHBUb3llNlFISDVVWjlMN3ZucEYyVUMvTzhST1FMSEQ4?=
 =?utf-8?B?K3UrL2dldk1pYXkzaEtybFphMEdZUlFzbDd6MUhCb0pCbmNYdHVod3pWUGNC?=
 =?utf-8?B?UjBxK0dmU0N2ZE4zaHdDUG9XVmFSbUNVNmNoMHpEYUVhRE5rS1p1ZjR5b1Fu?=
 =?utf-8?B?MEZ4NkdQUkFVSDdjeUI4YlJlRUtzVkxsZWIzaWcwdXZtelQ4WlFiWG40WUgr?=
 =?utf-8?B?U3Z6YmZIYnR3azRoTGlmL3FFa2l4K1dQNHltNHpDRVNNL2RlUWo2OEpKYldi?=
 =?utf-8?B?SnJBd1JWeEV1WVpTWlU2V0tISDJteEhlNEpJUWN1Q21kYng0MHVwSUhiMTRC?=
 =?utf-8?B?Mm56TjBUeHljRHY0ZjJ3TTNaajNxV2hCY0lMcVg3TU1WbjZpN25pQ21HRFZ0?=
 =?utf-8?B?VDJsTXhNMEJrT0NwTmsvU2I4WUNQREFMSkNsR2pkeXhyWG5wWDBlVU5YdzEw?=
 =?utf-8?B?YXFma2hBUnZwbTNaTHM5UG82VFpSN3o1K05pYnRTeTlIU3ZWWHIwa3lSdTk5?=
 =?utf-8?B?dEd2WFZ3VTl1eDg5U2lsZHZGUlBnd2RwRFJtUEZxNjJFeVhzY2dyd3pHRGZK?=
 =?utf-8?B?d3Y2K0J1YVErVTYvd2syY0k2aHBpUFV2bnJPUm9sbGtxbVJ2dUhBTytGVDNh?=
 =?utf-8?B?b0ViaStnbEJaTDk5ZzQybEttaEhaZFB1THJVYWZLc1oxUzhJM2VQSTFRQzNt?=
 =?utf-8?B?RVhMR2tjS01MN1VtRk1kekc0UjZaTzZlSTJ2TXZJbjFaRXBPUU1yYWdhOTNu?=
 =?utf-8?B?OWp0VlBmcGZWQjl5UTA3cDVma1VHT21FWnRGQ3lCNmZQUDFiTWpRTUQxbnZ4?=
 =?utf-8?B?ZXVQeHFaaDI4NndsTDAwalZGbG1XWkp3SFVuelFDaWFPOGZFN0YrbUt2bDdh?=
 =?utf-8?B?TGY3elMyYyszOWhGd3paU1NKUGhiZW5HSFh5VlRiWXhYSGNpTVhQVXUyMHU2?=
 =?utf-8?B?Q3hkc2JiRGYyK0hFSHloYnVVNVhYYXB6a0R3Mks2OStHblpBSWlETlM0cUdD?=
 =?utf-8?B?dGJqZGNwcXJhUTNwVUgrRjJ5em9QMklDVUMzd1A2RityaDdOTXhlbjNOV21V?=
 =?utf-8?B?MXhKZWJyT2FsUk5CODUrRkZJd0ZweU96WDRxWlc3ckJiUXZEak5aVHM3UmtE?=
 =?utf-8?B?UUVuTlJqQUV2V3VMdkhQN2ZnUW9teVRtOHZ6dno3RXVhSTlRVDVEYTQvSk5L?=
 =?utf-8?B?Q2w2bzNFRmRiT2NMM0FzQ3F0TzhiZzNVME1nSGV1Vm1ENVgwSHRrZHBXL2N6?=
 =?utf-8?B?YWFrbUNHeTg3cHZoWWVBU3o3TERLMHFhOHdYUnVTSjRJUXFKUVVHZUxxbTBo?=
 =?utf-8?B?NEJwcGZ1Qy8xcklnT2tnNnlwZGdoL0pGV3Y1bWVDakVLMFBJV09qUThRUFBa?=
 =?utf-8?B?TENPNHE0L0tQbEQwcHAxRXFDYmR3VTVDRW1PRVVQdkNaR3dCSHh0dmZWVSsy?=
 =?utf-8?B?SjVvMVNiTmY2OFAvVk5TRmNrNUVsNE5NM2s0ZlR0VGt6L0NNTGVQRmhXL3hC?=
 =?utf-8?B?MHJCd0F6ZC8xYU90UDFmS0RJcFAxUmYzdTJIWHZXSnpZcWVMeHhTQWlXbUVo?=
 =?utf-8?B?QnQrdkthV1E3Y0lqSmwzNWFsUVRnSSt3Y1gvZkVkN0grb2xtcHl2NnBzS01o?=
 =?utf-8?B?TUdhSjRBcWJ4TnNWekRsNGc3bDRhcTFKUVJXdDZYSVBaVTB4VFg1YzNxRWM4?=
 =?utf-8?B?OGVFVzRDcFpmMkp1RFBYNnZtd3JtWnRJNFZKZ254OTVpaytJZG5GRXVhQmdo?=
 =?utf-8?B?bEdkRFRaaDVocW92WFZ0Vk1hSWI5L293aGlmVWx6ZjVZdW9wY3pjUk5iVGoy?=
 =?utf-8?B?dXljWkxyamNNaGMxbTZrQmZpWWhuOWo2bjhXcUpncVRTSk9vQi9PU2dNQk5j?=
 =?utf-8?B?Z2g2TU80QU1TaUJDdEd2YkNsRlJBRnhQQmNvZmgwL2xPVytHS0RRcFAzWnBQ?=
 =?utf-8?B?cWQyWVhIcDYzc1VQUVZZZEZqZmhqN2d6QTV2NFZXRWJJSmFLbUhsYU9wUFdq?=
 =?utf-8?B?ZEFnTm5SSVdyZTh2UE13a1ZsU1dKOHZqYUxYVUFRczYrcnUyWVlKUUVSZHYx?=
 =?utf-8?B?RktjTnlwZnJMZmhxMkx1UG9haXpsU3JIYUNRazNCWlVzVDhSL0VNNFBWSUNm?=
 =?utf-8?B?TjMyUUREU3I5S1VReXNTMWVSa0Fsc01NSUNyTkFmOFh5MDlKcmJ1bVQ3VDdI?=
 =?utf-8?B?K21rL2hMNzZnMDlNeDhUYldUR3REcnJYUkR3NzlkWmFtTXZPTjJqdEh6WUFH?=
 =?utf-8?B?aWVHSUNYbmlienNlaW5sb3dDbFRDbFd2MERoNjF5S0NFbHhNdWp4dUhiWUhV?=
 =?utf-8?B?MjNNRkV6NzdaMXc1NVJYTW5UTjJOQW9hZHlRY2ZDRkd3dkdqVmtGQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2b9cb4-f5fc-491e-a9b8-08da33f05b23
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 08:21:04.4327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbHUS9Bt9mXJ6Mt/9OEyZl0KowMfPq8fXq14VgkwrtSZ5xcFeYmS0MkDJfEi8oP4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2796
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/11/2022 5:55 PM, Sathishkumar S wrote:
> create smartshift sysfs attributes from dGPU device even
> on smartshift 1.0 platform to be consistent. Do not populate
> the attributes on platforms that have APU only but not dGPU
> or vice versa.
> 
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 146 +++++++++++++++++------------
>   1 file changed, 86 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index d3228216b2da..c2406baeef93 100644
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
> +static int amdgpu_read_powershift_percent(struct amdgpu_device *adev,
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
> @@ -1763,28 +1752,64 @@ static ssize_t amdgpu_get_smartshift_apu_power(struct device *dev, struct device
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
> +/**
> + * DOC: smartshift_apu_power
> + *
> + * The amdgpu driver provides a sysfs API for reporting APU power
> + * shift in percentage if platform supports smartshift. Value 0 means that
> + * there is no powershift and values between [1-100] means that the power
> + * is shifted to APU, the percentage of boost is with respect to APU power
> + * limit on the platform.
> + */
> +
> +static ssize_t amdgpu_get_smartshift_apu_power(struct device *dev, struct device_attribute *attr,
> +					       char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +	uint32_t ss_power = 0;
> +	int r = 0, i;
> +
> +	r = amdgpu_read_powershift_percent(adev, &ss_power, false);
> +	if (!r)
> +		r = sysfs_emit(buf, "%u%%\n", ss_power);
> +	else if (r == -EOPNOTSUPP) {
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
> +		if (adev && !amdgpu_read_powershift_percent(adev, &ss_power, false))
> +			r = sysfs_emit(buf, "%u%%\n", ss_power);
> +	}
> +

Instead of repeating, the above logic also may be kept common and used 
in APU and dGPU power with true/false flags.

> +	return r;
> +}
>   
>   /**
>    * DOC: smartshift_dgpu_power
>    *
> - * The amdgpu driver provides a sysfs API for reporting the dGPU power
> - * share if the device is in HG and supports smartshift. The value
> - * is expressed as the proportion of stapm limit where stapm limit
> - * is the total APU power limit. The value is in percentage. If dGPU
> - * power is 20% higher than STAPM power(120%), it's using 20% of the
> - * APU's power headroom.
> + * The amdgpu driver provides a sysfs API for reporting dGPU power
> + * shift in percentage if platform supports smartshift. Value 0 means that
> + * there is no powershift and values between [1-100] means that the power is
> + * shifted to dGPU, the percentage of boost is with respect to dGPU power
> + * limit on the platform.
>    */
>   
>   static ssize_t amdgpu_get_smartshift_dgpu_power(struct device *dev, struct device_attribute *attr,
> @@ -1792,31 +1817,27 @@ static ssize_t amdgpu_get_smartshift_dgpu_power(struct device *dev, struct devic
>   {
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
> -	uint32_t ss_power, size;
> -	int r = 0;
> +	uint32_t ss_power = 0;
> +	int r = 0, i;
>   
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
> -	r = pm_runtime_get_sync(ddev->dev);
> -	if (r < 0) {
> -		pm_runtime_put_autosuspend(ddev->dev);
> -		return r;
> +	r = amdgpu_read_powershift_percent(adev, &ss_power, true);
> +	if (!r)
> +		r = sysfs_emit(buf, "%u%%\n", ss_power);
> +	else if (r == -EOPNOTSUPP) {
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
> +		if (adev && !amdgpu_read_powershift_percent(adev, &ss_power, true))
> +			r = sysfs_emit(buf, "%u%%\n", ss_power);
>   	}
>   
> -	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
> -				   (void *)&ss_power, &size);
> -
> -	if (r)
> -		goto out;
> -
> -	r = sysfs_emit(buf, "%u%%\n", ss_power);
> -
> -out:
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
>   	return r;
>   }
>   
> @@ -1884,18 +1905,23 @@ static ssize_t amdgpu_set_smartshift_bias(struct device *dev,
>   static int ss_power_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
>   				uint32_t mask, enum amdgpu_device_attr_states *states)
>   {
> -	uint32_t ss_power, size;
> +	struct pci_dev *pdev = NULL;
> +	unsigned short devices = 0;
>   
> -	if (!amdgpu_acpi_is_power_shift_control_supported())
> -		*states = ATTR_STATE_UNSUPPORTED;
> -	else if ((adev->flags & AMD_IS_PX) &&
> -		 !amdgpu_device_supports_smart_shift(adev_to_drm(adev)))
> -		*states = ATTR_STATE_UNSUPPORTED;
> -	else if (amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_APU_SHARE,
> -		 (void *)&ss_power, &size))
> +	if (!amdgpu_device_supports_smart_shift(adev_to_drm(adev)))
>   		*states = ATTR_STATE_UNSUPPORTED;

No need to continue if ACPI indicates unsupported.

> -	else if (amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
> -		 (void *)&ss_power, &size))
> +
> +	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev)) != NULL) {
> +		if (pdev->vendor == 0x1002)
> +			devices++;
> +	}
> +	pdev = NULL;
> +	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_OTHER << 8, pdev)) != NULL) {
> +		if (pdev->vendor == 0x1002)
> +			devices++;
> +	}
> +

Do we need this enumeration check now? Now the node needs to appear only 
in dGPU. Isn't ACPI function expected to indicate platform support? Or, 
could you try that on non-smartshift platforms?

Thanks,
Lijo

> +	if (devices < 2)
>   		*states = ATTR_STATE_UNSUPPORTED;
>   
>   	return 0;
> 
