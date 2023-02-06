Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FDBC636D6
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 11:24:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5842910E372;
	Mon,  6 Feb 2023 11:24:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 238FF10E372
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 11:24:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2FyD9EmPC3Qm8/INTHwQJdwU9GpObamXgWlySbQ24WjmvN54Yk1+0cwL6Am+hfstcjfZc2fvtLAORTS/Slp/OzVlFqYqPoEkejaLefh73lFvYO+dtr2ucIbbk2eE9lU+S3/II/as9Xm/A9YZFwOCFcaFpC8m/SG3AzwEciVqthKTOwczaA2Hp+TV06fShlqIzSXn3Ixu5Gm+o0xC2cbKZn59KCDqFDsGU9Wj6+lMctm3Sq4BCnbstujluFAMnI2lw2cxeyNsAo/cdxhaO8buk2hnFvSiEEmvMv8ClnUFJPw3QOnxFCimrzt1UQnuwP45hi+pfTOrhle5ZmDHtm4pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykuLgQQ7sM+mCCJYZJX0Jp6bgSNrV88RDlDinEpTGSo=;
 b=n8Y5pQeiv9lIr4dXvS/ln5p0krG0DC4+izPQKn0HOs6LYNrWjzIpLqz9ND+vvWbj08k1dxZfnJucjhHpiEKPFShbpc6l6FwI+QD5jlv85Xqyv1dvwbJVukn5roMEYZJPhPpu7M1EgnvhGLf5EYnT6sKtgLRUgTaXOyjBnVLBWHDWOP0odSdx4aRSkiYWNC/IiqMvM7JtGUAzWXcd0eM4MO/EwxcQu3EaiTEa+IBjcIjHrheLDCJNcusbLU5N720IFxRTUT/jFT7SBdRsCWeNNx242iWxr2qDTA1xgSz6hLfmVd0Or9IJ6pVOOtteT+nUWEZHGAhJSFlo9w0H4AkQpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykuLgQQ7sM+mCCJYZJX0Jp6bgSNrV88RDlDinEpTGSo=;
 b=SEGaiiNq69gCo85AjPrXky10nWlLE2VvC6/B4orUYVDHIFphpA2DewXLL8UW1x717ALJf2lCkkRpBtI8PyfqxnNGGyL5WzbKrP5nmkO/zqVaruthwMUF8TrdhnzLptVk8hkbWjRUwhBraY8cLgojkGSjCXqzMRtTrzBpBH4OosQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW3PR12MB4508.namprd12.prod.outlook.com (2603:10b6:303:5b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 11:24:03 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 11:24:02 +0000
Message-ID: <0a21814c-74d0-7780-66c4-34eb78479f88@amd.com>
Date: Mon, 6 Feb 2023 12:23:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 07/13] drm/amdgpu: store doorbell info in gmc structure
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230203190836.1987-1-shashank.sharma@amd.com>
 <20230203190836.1987-8-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230203190836.1987-8-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::7) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MW3PR12MB4508:EE_
X-MS-Office365-Filtering-Correlation-Id: d6fdfa8f-e771-4e75-2341-08db0834a664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gNHLcuctxmqIGbt8uBcMu/b6zoacQXzw2U2+z8WwI9nlmANGl88eFemDSzC2fYMJGmmUpQiYn8YbnT5A6zkz7Jts0WZHpreIw5Ixu4FnpCBR9+TEYdv4NG9+EmfYIcUI/hH9sHX+0Ghz3TeI5yTQa7UfTpqb4veurG9XYarmO68LGbhUpHokSGv5wJh4SHZVdCLT+Au3C73CZUavkv0uirXcHCe0ZMa3lhmptVdsHctp0jVJjcstXipXrh/ybcC8Frr/PJ/DNwGvZgfTHAeetZS+hbXgU9/AugUSIIPKZONCu4U3IoVbXZQh/hq+uKPep72knEbv1lFeKuCUu8uwmGT57MulVx1DSfhijg9XqYHoYg63HOc/n8OSOot4wC99IPsgFfgjsN99SWwTE9IMTd5/OFx7d5TOHAVEMfWQbz7SfU2oJ49OaQOgKYKW3rGbu/98oFXIVgOxRVQ0oBOcfgHIUqq7C/9NZA77JRpct8eDu/FSIkotYAGEzq32QYFD8WmGD9hRF/V5RStRlFffT+uVZUdpwNpde8e4FOSW5LWOPvID5WGgOMSHdJNcXWiJYWWoWzqqjsO4T4NEOAr/KRwyBsRMXf9C4Q4seBr9gyXTUnyOtV0ZofwoxmvrY3lLi/CJH50AqLfMpcIHrnrXeFfJ9Qz0bCfQLCnWJy7EeRsA88nvpaUowWk6bXunuBUU95d9ZQcpA84rgkSeT4BJGy0iL470x3hicLJ1YVyfYc0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(451199018)(478600001)(316002)(6506007)(30864003)(2616005)(6666004)(26005)(6512007)(186003)(31686004)(31696002)(36756003)(6486002)(5660300002)(86362001)(38100700002)(83380400001)(66946007)(4326008)(8676002)(2906002)(8936002)(41300700001)(66556008)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmNxVnI3ZW1LeTQ4TzF1SDFEWWpyZmNpY0o5QVlCZm1LZjJSTXJlMUdyRHRS?=
 =?utf-8?B?bFhIR3RETXFQdmd3RHVtWEtGcVZOVGdsdmVkUVNRWWNlT0wzYUdBSDlnK0Yx?=
 =?utf-8?B?SmtSYjNJc0EyZGw5NnNOOU9LQVlLMmc2b3lOTlFXVXBCTHBnZWVkY2ZmS0Jp?=
 =?utf-8?B?Z3MvVDVzOEhKM3VPQS9mWFl1UUJZY1FHUW5pVjRyZUtZdUlGa3VkR1QrMHRo?=
 =?utf-8?B?KzI2bVZUOHIvUFkvMmVpL0xBYXZtVmF0MzNOZHFNcTJuUG1Ock5jOVNzYUtz?=
 =?utf-8?B?WnpJL3I5MlI2NnRYMFo2eGRVNzAwSS9CNlpCVGs1bXlXdWhHaGV0eDFnZlFu?=
 =?utf-8?B?YW9nU2FyVUZvc3JKTnM0VjMxb0d0NDJaUnBuMGFBREdrakI1TVg1ZkJQcUpZ?=
 =?utf-8?B?MUVMUlZlakdhRndINVdDNXRQd0J2MnJiL0dNbE9xMGd4M2FKcndrSzVpM2ZM?=
 =?utf-8?B?WFVXU1E0WVJueEc3Z0xpVEFKUUFmcWp1cFhralEweC8zclpVUDNUaVlQNTN4?=
 =?utf-8?B?WEdudEJDbFphMWRyblBNdjhCS0l6enJjcElFb3JDZ2UwVFRMS3NWLzRvMTdC?=
 =?utf-8?B?OEZaL1RlbElFaS9WQXlDWnVYbVhrd3BETHJxZ0NlcXJkcDFnSmQxOUppMm9L?=
 =?utf-8?B?ck42ZWRteGd5ekVMOXlFRDJ2ZklaNERiNElrSHZJVWgzbGVQMkhGY1E3WkU1?=
 =?utf-8?B?VjNBVm9TSndFcmJacHYrcmNzRnEvaG9Xdnp0ZW1XV1hlWHBvcjZLdnhvdUpG?=
 =?utf-8?B?QkZjRFhIelYvV2RjQkEwam15VjlzbERRYlczQWZ0UUQ2Q1JMOUZySjBwWVp6?=
 =?utf-8?B?TUd1a0hOZXdRMUQvb0dERU5LZUpoZkVVUVVnVmsvcnRub0hXcysyYW9HSElN?=
 =?utf-8?B?WnVjTGNGZkJFaFMzdDArR0VKNUJDNlowS1JSaGs2QkNXTjlON3F5VEFoeUNr?=
 =?utf-8?B?Q3YzcGwrd05oNVVjeW1tSGFJTFNMVTUvOHh6TEoweUtaV0Jxem5CTzhQUFNI?=
 =?utf-8?B?ZHRNczU1UVUrWVlXZGJxc20zVlhVTUdwMFhrZG9lZVMvR1M1ZkY2N0VPS0hQ?=
 =?utf-8?B?RGQyZFBWc0g5YWh0OU4vUVErOStNVHMzOUtPTWVoMzhJRnpwU1ErMFJTeGV2?=
 =?utf-8?B?MXovT3RHTHExcHlqV0IvVWY2WnVqbWFNdWVGeTFURW16STZMb3U5dlhkWEQz?=
 =?utf-8?B?WFJyU0xKdlhjTTVqUzJiRkN5dTBBc1FqY0ozZXIvR3IzV1diSjZIdGg2eCtQ?=
 =?utf-8?B?OTY1b1h3UGtScEh3cmcxVnd1MWhna0NCQzhsWlBzT0N2RlorQ3NBVDNPS1BI?=
 =?utf-8?B?SXdnVTFHSlF5WTFDRVVwbWVmdUhudlZRMzd2c1l3S2UxNTROdnp1My9wdzk3?=
 =?utf-8?B?b1EvTDJRV1JndE55Z0Z5dENEYnJoVXV0RHoyK0hrWGtaZlpLcDUxcHlVbjJ5?=
 =?utf-8?B?eG5ZRzcvTXBLcjF1WnU3dERkY2VlRmloYndYVWl2MDZ0UnFTVHRqT2c2UnlN?=
 =?utf-8?B?emcwN1dxLzFhVVFCSWNPZGd1YWxaditKNlR0OFo1dVRuRm1tVzdnZ0FTZjIx?=
 =?utf-8?B?OVg3T2FBbklWNCt0MkhuNXk0QUlwOURZTW8xV20vczFXSVpHbzhMMEhZbi9y?=
 =?utf-8?B?UnNLZ2ZGZERuNkVXb0kwUVlSbXd1MTUzUW4va1l4VHp5MGpnTm1ZR1E2K0dq?=
 =?utf-8?B?VFgrQmlqUnFMSWhnMnEzMWxsNG8rQXFNUnR1a3Myckk4U2F3b3ZBQWlTb1E2?=
 =?utf-8?B?UytkZkFvM2ZmTFYyTHJ1YWZrU245RytaMFYrT3pEZmdJM1hhOUlkVnZXbkxa?=
 =?utf-8?B?T1RubDNZaDZSSjZYT2pwSHZ4RXVNZHRoVDZwK0d2K0VVQVlZYjZROW9Ecmxh?=
 =?utf-8?B?N3hPRElsN05qWGtPQWRJSUZYOTF3bFRPWlJrb3pxWnpodTBaa3dNSVFzbmgz?=
 =?utf-8?B?QlE4MlpHalVBbU00bCt3K202N1RyMnVsMWZ6RTR2TnpIYndzNnk4MVFSazRB?=
 =?utf-8?B?NU1WZ1NlOUVYOVNEaGJodTV0Wnl4cC9HK1VpUWxxYlNyLzcxTFlmdllMVU9s?=
 =?utf-8?B?TzRwdzNjSSszLzExdWtKNjg2VDU1M0dUQWxURkNtRmw4KytWWi8zZjBoekIz?=
 =?utf-8?Q?jChO9TUE6urbORROnGgwu4tqX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fdfa8f-e771-4e75-2341-08db0834a664
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 11:24:02.7834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XqcnwvenF2PqH5ejftVqESHC+GbpOJJqulm0TjfweY2CkTN9FmdW/G587LIL6xXr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4508
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 03.02.23 um 20:08 schrieb Shashank Sharma:
> From: Alex Deucher <alexander.deucher@amd.com>
>
> This patch moves doorbell info into adev->gmc structure, to align
> with vram info. This will prepare structures for proper ttm management
> of the doorbell BAR.

Mhm, this is most likely not a good idea either.

The doorbell isn't managed by the GMC in any way. That are two 
completely different things in hw if I'm not completely mistaken.

Christian.

>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c   |  8 ++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c  |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 14 +++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h |  3 ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h      |  7 +++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c      |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c        |  2 +-
>   drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c       |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c       |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c       |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c       |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c       |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c       |  4 ++--
>   13 files changed, 34 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 58689b2a2d1c..28076da2258f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -106,13 +106,13 @@ static void amdgpu_doorbell_get_kfd_info(struct amdgpu_device *adev,
>   		 * not initialized as AMDGPU manages the whole
>   		 * doorbell space.
>   		 */
> -		*aperture_base = adev->doorbell.base;
> +		*aperture_base = adev->gmc.doorbell_aper_base;
>   		*aperture_size = 0;
>   		*start_offset = 0;
> -	} else if (adev->doorbell.size > adev->doorbell.num_doorbells *
> +	} else if (adev->gmc.doorbell_aper_size > adev->doorbell.num_doorbells *
>   						sizeof(u32)) {
> -		*aperture_base = adev->doorbell.base;
> -		*aperture_size = adev->doorbell.size;
> +		*aperture_base = adev->gmc.doorbell_aper_base;
> +		*aperture_size = adev->gmc.doorbell_aper_size;
>   		*start_offset = adev->doorbell.num_doorbells * sizeof(u32);
>   	} else {
>   		*aperture_base = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c
> index 3257da5c3a66..0656e5bb4f05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c
> @@ -209,7 +209,7 @@ static ssize_t amdgpu_mem_info_doorbell_total_show(struct device *dev,
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
>   
> -	return sysfs_emit(buf, "%llu\n", adev->doorbell.size);
> +	return sysfs_emit(buf, "%llu\n", adev->gmc.doorbell_aper_size);
>   }
>   
>   /**
> @@ -897,7 +897,7 @@ int amdgpu_bar_mgr_init(struct amdgpu_device *adev, u32 domain)
>   		size = adev->gmc.real_vram_size;
>   	} else if (domain == AMDGPU_PL_DOORBELL) {
>   		mgr = &adev->mman.doorbell_mgr;
> -		size = adev->doorbell.size;
> +		size = adev->gmc.doorbell_aper_size;
>   	} else {
>   		return -EINVAL;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 45588b7919fe..16580d9580d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1035,8 +1035,8 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>   
>   	/* No doorbell on SI hardware generation */
>   	if (adev->asic_type < CHIP_BONAIRE) {
> -		adev->doorbell.base = 0;
> -		adev->doorbell.size = 0;
> +		adev->gmc.doorbell_aper_base = 0;
> +		adev->gmc.doorbell_aper_size = 0;
>   		adev->doorbell.num_doorbells = 0;
>   		adev->doorbell.ptr = NULL;
>   		return 0;
> @@ -1048,15 +1048,15 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>   	amdgpu_asic_init_doorbell_index(adev);
>   
>   	/* doorbell bar mapping */
> -	adev->doorbell.base = pci_resource_start(adev->pdev, 2);
> -	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
> +	adev->gmc.doorbell_aper_base = pci_resource_start(adev->pdev, 2);
> +	adev->gmc.doorbell_aper_size = pci_resource_len(adev->pdev, 2);
>   
>   	if (adev->enable_mes) {
>   		adev->doorbell.num_doorbells =
> -			adev->doorbell.size / sizeof(u32);
> +			adev->gmc.doorbell_aper_size / sizeof(u32);
>   	} else {
>   		adev->doorbell.num_doorbells =
> -			min_t(u32, adev->doorbell.size / sizeof(u32),
> +			min_t(u32, adev->gmc.doorbell_aper_size / sizeof(u32),
>   			      adev->doorbell_index.max_assignment+1);
>   		if (adev->doorbell.num_doorbells == 0)
>   			return -EINVAL;
> @@ -1071,7 +1071,7 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>   			adev->doorbell.num_doorbells += 0x400;
>   	}
>   
> -	adev->doorbell.ptr = ioremap(adev->doorbell.base,
> +	adev->doorbell.ptr = ioremap(adev->gmc.doorbell_aper_base,
>   				     adev->doorbell.num_doorbells *
>   				     sizeof(u32));
>   	if (adev->doorbell.ptr == NULL)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> index 7199b6b0be81..c6324970eb79 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> @@ -25,9 +25,6 @@
>    * GPU doorbell structures, functions & helpers
>    */
>   struct amdgpu_doorbell {
> -	/* doorbell mmio */
> -	resource_size_t		base;
> -	resource_size_t		size;
>   	u32 __iomem		*ptr;
>   	u32			num_doorbells;	/* Number of doorbells actually reserved for amdgpu. */
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index bb7076ecbf01..2a6636a7f27b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -173,6 +173,13 @@ struct amdgpu_gmc {
>   	 * about vram size near mc fb location */
>   	u64			mc_vram_size;
>   	u64			visible_vram_size;
> +	/* DOORBELL's physical address in MMIO space (for CPU to
> +	 * map DOORBELL). This is different compared to the agp/
> +	 * gart/vram_start/end field as the later is from
> +	 * GPU's view and aper_base is from CPU's view.
> +	 */
> +	resource_size_t		doorbell_aper_size;
> +	resource_size_t		doorbell_aper_base;
>   	/* AGP aperture start and end in MC address space
>   	 * Driver find a hole in the MC address space
>   	 * to place AGP by setting MC_VM_AGP_BOT/TOP registers
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 0c546245793b..1e09c3267c8c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -126,7 +126,7 @@ static int amdgpu_mes_doorbell_init(struct amdgpu_device *adev)
>   		roundup(doorbell_start_offset,
>   			amdgpu_mes_doorbell_process_slice(adev));
>   
> -	doorbell_aperture_size = adev->doorbell.size;
> +	doorbell_aperture_size = adev->gmc.doorbell_aper_size;
>   	doorbell_aperture_size =
>   			rounddown(doorbell_aperture_size,
>   				  amdgpu_mes_doorbell_process_slice(adev));
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index f202b45c413c..ebc17884df1e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3526,7 +3526,7 @@ static int gfx_v9_0_kiq_init_register(struct amdgpu_ring *ring)
>   		 */
>   		if (check_if_enlarge_doorbell_range(adev))
>   			WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
> -					(adev->doorbell.size - 4));
> +					(adev->gmc.doorbell_aper_size - 4));
>   		else
>   			WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
>   					(adev->doorbell_index.userqueue_end * 2) << 2);
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> index aa761ff3a5fa..5969c159d7a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> @@ -173,9 +173,9 @@ static void nbio_v2_3_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
>   				    DOORBELL_SELFRING_GPA_APER_SIZE, 0);
>   
>   		WREG32_SOC15(NBIO, 0, mmBIF_BX_PF_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
> -			     lower_32_bits(adev->doorbell.base));
> +			     lower_32_bits(adev->gmc.doorbell_aper_base));
>   		WREG32_SOC15(NBIO, 0, mmBIF_BX_PF_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
> -			     upper_32_bits(adev->doorbell.base));
> +			     upper_32_bits(adev->gmc.doorbell_aper_base));
>   	}
>   
>   	WREG32_SOC15(NBIO, 0, mmBIF_BX_PF_DOORBELL_SELFRING_GPA_APER_CNTL,
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
> index 15eb3658d70e..5ff12887ffab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
> @@ -169,9 +169,9 @@ static void nbio_v4_3_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
>   				    DOORBELL_SELFRING_GPA_APER_SIZE, 0);
>   
>   		WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
> -			     lower_32_bits(adev->doorbell.base));
> +			     lower_32_bits(adev->gmc.doorbell_aper_base));
>   		WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
> -			     upper_32_bits(adev->doorbell.base));
> +			     upper_32_bits(adev->gmc.doorbell_aper_base));
>   	}
>   
>   	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
> index 37615a77287b..1465e74e9122 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
> @@ -121,9 +121,9 @@ static void nbio_v6_1_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
>   		      REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL, DOORBELL_SELFRING_GPA_APER_SIZE, 0);
>   
>   		WREG32_SOC15(NBIO, 0, mmBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
> -			     lower_32_bits(adev->doorbell.base));
> +			     lower_32_bits(adev->gmc.doorbell_aper_base));
>   		WREG32_SOC15(NBIO, 0, mmBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
> -			     upper_32_bits(adev->doorbell.base));
> +			     upper_32_bits(adev->gmc.doorbell_aper_base));
>   	}
>   
>   	WREG32_SOC15(NBIO, 0, mmBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL, tmp);
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> index 31776b12e4c4..33bc23564870 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> @@ -175,10 +175,10 @@ static void nbio_v7_2_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
>   
>   		WREG32_SOC15(NBIO, 0,
>   			regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
> -			lower_32_bits(adev->doorbell.base));
> +			lower_32_bits(adev->gmc.doorbell_aper_base));
>   		WREG32_SOC15(NBIO, 0,
>   			regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
> -			upper_32_bits(adev->doorbell.base));
> +			upper_32_bits(adev->gmc.doorbell_aper_base));
>   	}
>   
>   	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> index 19455a725939..4ce9d78aee1a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> @@ -223,9 +223,9 @@ static void nbio_v7_4_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
>   		      REG_SET_FIELD(tmp, DOORBELL_SELFRING_GPA_APER_CNTL, DOORBELL_SELFRING_GPA_APER_SIZE, 0);
>   
>   		WREG32_SOC15(NBIO, 0, mmDOORBELL_SELFRING_GPA_APER_BASE_LOW,
> -			     lower_32_bits(adev->doorbell.base));
> +			     lower_32_bits(adev->gmc.doorbell_aper_base));
>   		WREG32_SOC15(NBIO, 0, mmDOORBELL_SELFRING_GPA_APER_BASE_HIGH,
> -			     upper_32_bits(adev->doorbell.base));
> +			     upper_32_bits(adev->gmc.doorbell_aper_base));
>   	}
>   
>   	WREG32_SOC15(NBIO, 0, mmDOORBELL_SELFRING_GPA_APER_CNTL, tmp);
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
> index def89379b51a..1f1fa8cc4790 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
> @@ -132,10 +132,10 @@ static void nbio_v7_7_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
>   
>   		WREG32_SOC15(NBIO, 0,
>   			regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
> -			lower_32_bits(adev->doorbell.base));
> +			lower_32_bits(adev->gmc.doorbell_aper_base));
>   		WREG32_SOC15(NBIO, 0,
>   			regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
> -			upper_32_bits(adev->doorbell.base));
> +			upper_32_bits(adev->gmc.doorbell_aper_base));
>   	}
>   
>   	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,

