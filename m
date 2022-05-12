Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CD5C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 11:07:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFFAA10FEFA;
	Thu, 12 May 2022 11:07:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B637810FEFA
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 11:07:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imtf9YedWf8TuNZS4Yhkn52lahPcp5x3+BY5hWvLrK5TPrGnbsx7aiwTm/NyChNI8dhtCIWnP3iGxqng3rHdYWCD0chtSdaNhjbEBrkCCBysEI069wPwCIAmbeuT5iuLTfKbg3G292wGgxqsPBKerWPmQeAn/AeRPJprp/UWuMPSd4NfRZ/r5Z4Ou5v2lCse2lpfgu45tOHniR7e3opWCbGXQBUcf49P7/84+e6GgD3Z9/BmIfhtpmLGnT3y78Lnt2vYUK3tQTO0+pZZ7BdUYB19kfKj7+1AYP9I67O4NfeIyaehsp2mgP0EoXEW0S1QX8x9D6qn3vX3qrE0NhiYyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jyzd/iRK7dKP648GeUDoEx7q5AarGTrclUPnSbr19Zg=;
 b=ihcLg8JnXCxlkSPhSIOj5RXCCuFUhjn35SKaIcC1JS6pDlCVM3oHQQygUA5ThXtUy7hkNZ87IZO5ZA7l/ee80XIWtS8qvB81H4FhnkDQz9pvvwo2hXEZjgMU/p0DS8w+5C6XKk8ulL63p4zARWuqmrMJdn9rW6kSHdeCzWJaSpGTcoqxINqErwrFQw5b0F9mdVVWv0VZpdpUEhBHC6fKAcGK2PGn53+yxYyOFIIvKdqE6FcQ0Dx2tIx1EvLNHEfQysRTpnOEKm1B51GhByBlv6SpLXD+KB8KcFCobaEJ/TfjMNCy3IGDJjCssCHYa19Hg3xbAD5HbeGJciVVBNm8Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jyzd/iRK7dKP648GeUDoEx7q5AarGTrclUPnSbr19Zg=;
 b=YxtouBLDHgsIlNf6ORKbf6v48td08LRiiJwX7VmGE+0akZZ893YwLd3JIUUQ+tLxK+cnrWeq9+tRVZUN3jVWNJSb7VyomC5U3ypscDDh7bra/irHdiC3tixFeIXElwnUnbbGvF0QeZtQOOwls9ZhoOXpH6m720/A11peF5HwTXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Thu, 12 May
 2022 11:07:49 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f%5]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 11:07:49 +0000
Message-ID: <ee8d602e-ba20-e0d2-db20-603c65f4fa76@amd.com>
Date: Thu, 12 May 2022 16:37:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] drm/amd/pm: consistent approach for smartshift
Content-Language: en-US
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220512105652.3520817-1-sathishkumar.sundararaju@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220512105652.3520817-1-sathishkumar.sundararaju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::28) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39cbb1ff-deaa-49ef-29c6-08da3407a68c
X-MS-TrafficTypeDiagnostic: CH2PR12MB4296:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4296A22DF95A7F8A2DC1B49A97CB9@CH2PR12MB4296.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x5MU5ceImVZOgr7b8BfL1luUaGiQ1YLwwZILpiMRXGabl17gF3qatIRLiuTXD2yQH5XPJzc1XSy3CwxVUi705E/QskioVE4Da80cXQ52RPk4ftmpDhV1EfNS7ya3k9Bbd8VNGTHNoj6it61xOC/Kjo2z9CYc+4B6JQHUuR8aOeM9O9QW8fNjK15HyQddQkDs++FSZ9WhnkTEXC7ULL2vwJOLKrZWsqc8MtmcaB4EFYay8eSFm3ADGuOiZV1h+/YQULAwz6hskED2QeKlajNhoKMX0K4PXxiLoc6Z+iaF+5jj2miBnwFz+l5rvL8z9IEcDBCVTDiQOtGp7+Y6y35JCCFR15a+MBhlaqKlejTfZ2Rhme0IkOahtrGrN4PUKAhhAJ+11BPGL6ysMibBMFkoK1GPIz2DxMbJZ1Qjf8mGHOqWyZiDMZBbUldDEtGvkeRKeKla7mdg7FcWHfNySDLFmnOiOdde9SQAYuR33h5xTF3OYxnKN2wYidCo4JWsXdP2QT3mJyWw7+hLoW0pmJqc6MtRsf/mbzXqsv9jcb49Zwpf6Cf1R2ONp5p5HwpCanF3+c9I0OtNwCbYl1RqI3tPDDzl0H4Ip39rHiTqXsKhaG3gn3feAXoQ+SwmH0jrihQvc4p++hxrurKLcH56fCYI+XE1UXKpIl07ZP2VbIPvidxFEUCVWoKWCHqqHYePCy6oEZf5dfcD76VFhg1lm3vUkupHM5Rc/Jll50xA2skLT5aGGi/BMuBE0tqaZ5G9j9zA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(26005)(31686004)(2616005)(53546011)(31696002)(86362001)(316002)(38100700002)(6506007)(4326008)(6666004)(186003)(66946007)(66556008)(66476007)(8676002)(2906002)(36756003)(8936002)(508600001)(5660300002)(83380400001)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFRWenlxdkw2YWt4TEcvWk9ZcjZkdUVKaWw4QlVUNkVBczlTdmdQd0hYV0xM?=
 =?utf-8?B?WTVZcTBzZ2J6Ly9FN2pCOEpsemk3R0YvN3BXbm1MZkh1YW5hdXBHdHlTSGhD?=
 =?utf-8?B?OG5wemMrd1VPak95akUxVENXVERaUFNEWmNYYkVwU2kwSmhuRWdXQkRzSGpk?=
 =?utf-8?B?b0N4VlVDVEFSQWt3YkVJLzRYZ1RCU1IrWUgwR0pNTHZrS0ZkTHh1bjh0WEk1?=
 =?utf-8?B?UE5TVEM1VlI3cCtQWWIxQUNGWVFMWk81M29Nb0ZRM25VNDZhaVEyc29GS1N6?=
 =?utf-8?B?MUZkTzAwOHl5YzNIK3c2Qkh2NFNJN2MzZ25HeW05dGlPbGp6cytpNkovMlQv?=
 =?utf-8?B?aHVzTytCdmxqZTZlNlRtMmFNMkhCZWtjMElPM3pkOHA3V3BDMU9aWGlwaTY3?=
 =?utf-8?B?OEljM0xUSVRjQ1oyaXZvaW5Na0NHVHlSSm9ESjV4V2pMemxNR2NXK08xSWpI?=
 =?utf-8?B?dFN5Ym9tVm9mY1ZuTTJzdEtrcFdEd1dULy9MMkpsQVoyMFNtYld6Z2FaMnFo?=
 =?utf-8?B?ZlE1clptV1hQNXpZSlVVQ2pWdGVIQWRVdVJIa3RCQ1pCOGh3SFFQdklIVFdR?=
 =?utf-8?B?cGhTRVJrQkJvdlA4dVNUYUdzOVhIQVRxTTNrb3Uzclp6eXNlK0tiaHZyR0JX?=
 =?utf-8?B?RXhIS1ZXekg2elhjRC94Mk1aM0lmakcxU2hmQmlNK0VXRFczQjRvV1RXWWcx?=
 =?utf-8?B?YW1vTjZGVGp3M3ZvRnp2bVhTZktha0JPd0tXY0l6dHpGOGVzdWZKM2RGa1BI?=
 =?utf-8?B?VkpNNGpieXFJWS9GWkVMdlZoNEpCclJvMjVDb25uZHhZRS9POVNSRlZPdzNk?=
 =?utf-8?B?cTBKakxlOS9QSk55NWVaN3ZCaTdmSUZUSHJSMkpoRVZJNDNuRHFQYzNXZVJ1?=
 =?utf-8?B?K2o1N3B6UC9NVmZQWDFXS2xJZkNxZkFzYjNYTWVObERlVFVjZ0NQSGwrVU14?=
 =?utf-8?B?TXo2M3g5NFRCMFdPUHJDekZDaUFEQk9FWFNGVFVHQ2NlU1lUN09QUERUNnhP?=
 =?utf-8?B?ZHlLNDFxOFJEcFdJNXFESlpoa1B6UXVPYUVCNTVSRHN2RzNZcFlBMC9FWENt?=
 =?utf-8?B?YmF6UGNYSWd5TjI5aUdUSjdJRStGODN1c0djK0FURHpxS2x5VmxFN1A1S2JD?=
 =?utf-8?B?V2ozOC9wTjdPNXBjK084c0VvbjZzSFdBZTNtL2ZNMWNhdGlLby9VUEI5amNj?=
 =?utf-8?B?VUwxeUZBMnRvTVJZa082c3d0akIwUWYvTCtLUHVCbStkNS9TNW5ZOGdoTVd2?=
 =?utf-8?B?NVhrY29jTUluTnJQMzZPenZVMVY0aWlEVzBLc3kzQjlQRDd2MTZ6R2ZwdU90?=
 =?utf-8?B?QURNekVRNzVsa0pUNDZRajBvMnhvdUhINzU0bld6SnFNMyt4VkZBUkVVLytL?=
 =?utf-8?B?a09wL2dpTEZ2NHlENk9NT2l5d2dZOVlDTzg5ejUvKzN3enVGTXloVmhsSkNP?=
 =?utf-8?B?ZjRzTnBidWg2cmloaXhDdXBxdnIzUG52VHVJb3VVY3ZQNE1qa0JYU2hvSm13?=
 =?utf-8?B?QTY0cWlCSnAzZk9oYkFGcWxja0dQbTNUeVp6YTZZUEl5ZTUrdHpZSVkrOHU4?=
 =?utf-8?B?U2I1b1pwTTA4YUgyTVBsUnVVYnRWcWZycG5zMkozZ1NPcFlCR0NQeE5ZdjQz?=
 =?utf-8?B?S0xUR1pQZTc2b1RqVFVaTnJhOUxDTmRKalNkb2FaRmEvbXVIVHpROTcrYWVq?=
 =?utf-8?B?b2hZcXc3NVNTdkxYa2h5UlcwVVQ3eEI5N0QwSi8wdXRpbzVtZ0o0T2cxYXBy?=
 =?utf-8?B?V0N3c04wRHpKeHBDRWFmRFF0TzI5UGY5V0VSZE95YkR1SHFBcGRibkNDcHB5?=
 =?utf-8?B?WVFxTkhCdzJ1VHJqTEVlcnFqZjlNbUNzRGN3azUwWDVyT0dCQ3NmeGxlSjBO?=
 =?utf-8?B?UVlNU0xFK1Q2MG5URDRmeTBJeE03NVRjR0U1Wkh2bXRpL1phbmpYODdhTERV?=
 =?utf-8?B?UzlQSzJ1VHNqeDg0UlJmVFd0WFc4enBJYmtWOERObW1ZWldBVldrSW1FRXE3?=
 =?utf-8?B?OFk5NEZxWG1wL0dudU52VkNsQ0c0bEhaQmJQa1ZWYlYvakduamtrMTB5M2Fa?=
 =?utf-8?B?eWZuWXVITHFLK3Y5SUx2WjdyNWxFWDFqNkFseEwwTFhLTE1JMk5jLytISkRH?=
 =?utf-8?B?Tmt0V2w1SFNwVm0ydXZWcmtBYkZrSnBTcC9GR0w2WFpCQk5hUFV6Z0xoNzZu?=
 =?utf-8?B?K0hwWDJHQno3MitqUTRsUVVsL1Y4enExYUY2TjV1Wkc3L1MyT2pJbWpFUTJu?=
 =?utf-8?B?ZDNnSmY5THZqRm5aczh6a084YWFBMCt5ZFkxdE9oeWxBT0tCVE1hOCt0SXMr?=
 =?utf-8?B?ckoweFRITHBOVitXb0Q0NmZhb20ya2xpcE5MUFdodjV1SzFRWFZOQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39cbb1ff-deaa-49ef-29c6-08da3407a68c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 11:07:49.4808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkEMY1ZJSJFDv1Fu9iK+lgWLslpYD9bZSvxeMACMhku+9XJ3+iOGbiA7qqT25Bab
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
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



On 5/12/2022 4:26 PM, Sathishkumar S wrote:
> create smartshift sysfs attributes from dGPU device even
> on smartshift 1.0 platform to be consistent. Do not populate
> the attributes on platforms that have APU only but not dGPU
> or vice versa.
> 
> V2: avoid checking for the number of VGA/DISPLAY devices (Lijo)
> 
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 136 ++++++++++++++++-------------
>   1 file changed, 74 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index d3228216b2da..292e8c241597 100644
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
> @@ -1763,28 +1752,65 @@ static ssize_t amdgpu_get_smartshift_apu_power(struct device *dev, struct device
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
> +			r = amdgpu_read_powershift_percent(adev, &ss_power, false);
> +	}
> +
> +	if (!r)
> +		r = sysfs_emit(buf, "%u%%\n", ss_power);
> +

In v1 patch comment, I meant something like this
	return amdgpu_show_powershift_percent(adev, false);

And the above logic is kept in amdgpu_show_powershift_percent();

amdgpu_get_smartshift_dgpu_power():
return amdgpu_show_powershift_percent(adev, true);
		
Thanks,
Lijo

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
> @@ -1792,31 +1818,28 @@ static ssize_t amdgpu_get_smartshift_dgpu_power(struct device *dev, struct devic
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
> +	uint32_t ss_power = 0;
> +	int r = 0, i;
> +
> +	r = amdgpu_read_powershift_percent(adev, &ss_power, true);
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
> +			r = amdgpu_read_powershift_percent(adev, &ss_power, true);
>   	}
>   
> -	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
> -				   (void *)&ss_power, &size);
> -
> -	if (r)
> -		goto out;
> -
> -	r = sysfs_emit(buf, "%u%%\n", ss_power);
> +	if (!r)
> +		r = sysfs_emit(buf, "%u%%\n", ss_power);
>   
> -out:
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
>   	return r;
>   }
>   
> @@ -1884,18 +1907,7 @@ static ssize_t amdgpu_set_smartshift_bias(struct device *dev,
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
