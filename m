Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6BCC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 07:29:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F30E892B0;
	Tue, 18 Jan 2022 07:29:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A85710F2DF
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 07:29:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HycgQzp2dJMv0QMY/97Gi0sek2VmLzdpO60BDucYUZI6A4zz11zX5EqeC3e13fz8epk1QQTu0ynv0KrNuw3LAINJCiLYOR3oB9l4EOSPR9dlMp1cUT0BKLdC/ukkk+f6aJjv0dZmjN68NtiSBmZANk4InQ8pbT0Pfd/9De42P7vAUFkrdWJQICXDeO9T2s/4Se3sFZ0WsnbloS06ybomnecPvwsd/B8/qR632Ww44TELNTAtPpkrRnbsx4bHjfgNP0KblO3JIpHmlroDUk1h26eytyqxDxrX6eKgA8LKi1fqnSug6NUllW02djc68F9CjThgcXwVaKTjJi0aOrh1ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gej8g2oGqHw8SwLskKc+a2b6RXxDxt+QrbvIr9tv6bU=;
 b=dwoHG6S0H75z75U9yD/wMzFPK9GjcA+sC2O/qzuUKS8/P9Q62e3EIuYYYmirQo82ziJP4yezXbshjeb2HmLP8q1JnbeLQNJSpaJpGyJHqeXgXA/qub/OWFvmgbntvAUKJ1Q1OCcZb0t9ZsWDfLqLnOQ5DvhrOX+l5/L2MCqxKIMZnk3F6spHuzq+MnULi3uYlD99IALYB/lfcOGk/blZn89KdRbaM3a4aiSGvrDIetGoaE8lqPixfKRHFYsAz+diLhCgE51bvpJLRZ4IhUJXg+S8teXn03ZOhbge8tmCFD/nd3OcDprLdwflnza98d8s5nt+U66eOGQciQPAnTuHkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gej8g2oGqHw8SwLskKc+a2b6RXxDxt+QrbvIr9tv6bU=;
 b=rXu5XOi5fru3gjbdIsxByX0zw+Md6y3ZBXyK0BPPQNKC4nrMg7Wd6L14zCR9/HWD+j3aPNDCPlrzNcC3UEPClwcPTzUSAP0TO+hS8OF0/1aZZjaS0qOXgGDQfJJj2C9lrmpr1KQkgCi5JiTNCXi64IMG6RDW/Io96hkyG22BEuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB2905.namprd12.prod.outlook.com (2603:10b6:5:181::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 07:29:43 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::b03b:7df9:d733:13b2]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::b03b:7df9:d733:13b2%5]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 07:29:43 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: fix build up and tear down of debug vram
 access bounce buffer
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220117234307.3820143-1-jonathan.kim@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <88f0e304-c17c-bc50-14ce-37c05d76a3b4@amd.com>
Date: Tue, 18 Jan 2022 08:29:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220117234307.3820143-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AS9PR06CA0046.eurprd06.prod.outlook.com
 (2603:10a6:20b:463::29) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72568f64-8a71-451b-d48b-08d9da544bd5
X-MS-TrafficTypeDiagnostic: DM6PR12MB2905:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB29058F9C1B945DF0FD2F0FA383589@DM6PR12MB2905.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o8dLifh91jgHprScz7TSPcpA5OvR6owRnvyaFWcUF6F2fqC5J5/j2ydZSmJiDuhDAvobTOpGVKqfUtl5SVFexT9s/oj+yRnk8SsrzV6zsh8lFxV1gN9KRACBZXPpF77t8rD9csFEJS+UwHtWTvR20UhbTBxgZymag8ykuXl5j0xXZ7SBSPAFMpAmxlxAD/2Yi6b8elq9vqCzIV3JhxVPNILp+QcmmezleKnJdyYwuetloF9BYUbDmPUrpK3M0+K1Ye8/BCZ3H2a0Muktl3dZwjXSVsKYvzIl5X8L3z6ybNtsnaDlMyI5Admlg+wx0bUgB6XI+/TibE8gZB5bYwnmxs4Wq+pcGqjGUztKNGDYl9+YuBc0Dc9UYh/HAigtLbOwNdEvIpiHJjNYXJSpI9arYFNI+QGsm384EO9OzVQ2L20ygOX2pUGIemiNDuLhHTilvSRmpGP+Q4wRz/B/njQexrZ/ka92CthzKtNoaIJHDWm8ECp7XDmadNoWKazCshWZ/rT4f8mwjQbUhikagrFjmflFBZzPqlwwe60a05Em/m08XroEaA5nXXX8lGtaLhruNhmHWD1nnl2ef65qhotybVg/rJYTNc8lVhOUOl3VPVH1U1oL7SXwUmCLuqz46xYRz99n6PFWPoRvEYWAw6+/Y8RibW5P/6oHS+ki1EDgdWM7/q/ymuCKN9reKzhxJ4KlnLgTwjVj7i7h9OiBHXjJDGBqC4b9iwJjdt5A4/BM5k3+fUgf8V4JUh0d07HEEoRX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(6512007)(31696002)(8936002)(31686004)(86362001)(36756003)(186003)(2906002)(66556008)(66946007)(5660300002)(316002)(38100700002)(6486002)(8676002)(4326008)(66476007)(6506007)(6666004)(2616005)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXBOUFBza1V6RjdMTWJzS00yVVdCMVl3dHpmYWdQdCt0Qmtnd1p5ZG55M0Fv?=
 =?utf-8?B?WUtaTU5qS2h2a1lSNVNzNzAybmkxbkQ3dTJhZWdKQ2ZPc2NpdHdEdmxTNmQx?=
 =?utf-8?B?T3BoWG1sNkh1VS95Tjl0UmxjOWVsaGYxM0dLZ3dXV25FVlpRUDBzdk11NW9M?=
 =?utf-8?B?V1hRSW4wdy9vcVpVa2NFSFpvdHUwYm5xUDJYdldxajgybEtHNnB6WTQ0Y0lj?=
 =?utf-8?B?QVhYa003dlNaeFdrdXhpVnVwckFjYldTbytBaUU3ZlJKL2NuZnAzSHFGRHA0?=
 =?utf-8?B?NnpuY1JWcnNyTzdrZjVsdU0vdy9lNStaOFlpRHQySW5DcVJFMk04Z2NSc0FR?=
 =?utf-8?B?bFpHczUxNy9HSkNhSlZVT1o3aU5oSEdBaE93KzBDQ1FRVDl2Mk0rQUJvelVu?=
 =?utf-8?B?UU5nOGJaMUlCY3UzWm0vU2ZXSTlKbE03dzh3RWlJWGNNcklNdzVUdW55M3Fr?=
 =?utf-8?B?VFNVa2h0RU5MeWYyQXYwZS9TVlNEckRiZ0t1T0FvdjRjeWcwbVFvWTV6eHFj?=
 =?utf-8?B?ZUFNSG5jdWI3OHIvVmhhV0xYdTBPcEpvSFhpZnQ3ekZVZXdybk5LeUxSbWRM?=
 =?utf-8?B?aWh3VDZUa2FrZHExMC9mZGZtM1pVVWRyUkZQQUZZamJGL2NiL0VGVWpIKzBj?=
 =?utf-8?B?UldHUGtvMlJsaEN4alkxeWt0NVFKemkraG1yQ0ZCVlpsRm1ORXB2U2JzT2FI?=
 =?utf-8?B?V0UxdEpjWlR5clhNUHh5ZW5qbjVSZlgwZTJEYVFTQ2dLOTcxRk1BZ3k0emJ6?=
 =?utf-8?B?RlVSMk1FZk5pVTJhM09zT2hBNmZlVExxRTROV1drZ0htOEdod2hRWjBJMU9S?=
 =?utf-8?B?cENML3hFclFJbVl2VFpJck9KVjRlcDNsWUQyNjNLdWRtK1hwaHB6V0V4QVRl?=
 =?utf-8?B?SkZTQ3BKOTVoZ1hvWHdFb3BIU3ZIMmE1dUplVWZEQmRNYSt5dzE3aSs3bWZs?=
 =?utf-8?B?dTlmZlJMTTVEVURsOG9zMHZwb0drNDI2aGh5M0gxc01ma0hQNUM5M3lJVThM?=
 =?utf-8?B?WkFZalhhamd2SE0zeE9ZMHN1ZDFmZFZSKzU2UVdXZ3VxUWxjQmo5ZWFZa3BJ?=
 =?utf-8?B?MG54RFpSTmJJcDIyb1BscFYxemtsajNYVXR2SXJyQk5yM3M4cjVhZ1VHMTZr?=
 =?utf-8?B?a1kwQ2sxVVg0dkZBZ0VJRzZrQjhRb1dUT3pzWEZHL2NoQktsbjlyaFEyelhD?=
 =?utf-8?B?TkNST0c1eE1QMll6UEdoTGtrN3pINTJEZEFHdGc1QS9SdDFzQ0RnQTBRS1FV?=
 =?utf-8?B?ZUFnc2p5ZlFLaVcwWHcrZUd2TVA1UVI5QXlyY3l4ekdjQXEySHl3M0QydFda?=
 =?utf-8?B?cjd6aXpFeWxnNkE4eGd6OFRleS9GKzRJOTIzT0JxZlZsVktOV1NCMzBDeXRS?=
 =?utf-8?B?QnBHWWZtSS9BRytHaXdQSDJxZTYxSGRHOW5RLyt6SnVmRnE5RWhLaW1WNkFk?=
 =?utf-8?B?c1kzU2p2Q3VuSGhSQmNMQU9hQ0dZZ3djRW9YeDNlU3Jsb0JBMDhIazJhbGlp?=
 =?utf-8?B?eEM3KzNUbERMSUxIT0hTNHBDejNQK3Y1aGNjRkVsVW4zT0FGbkwvUjNyeWV6?=
 =?utf-8?B?MXBvYy9GanRHWVh5RWhPbFFxR01LeXAzRE5sSXBWa2xMQkVOSlpMaDJBUVVk?=
 =?utf-8?B?VUVUbWxhaERJVnhPSjVxcW5IMmVQNE9jNEE0YnBGc0RtaWE1bVVsVkdYYjQ3?=
 =?utf-8?B?L3dVUDJ4Q2NEMGtJdE5QbCtYUHVqU2lVK2xoNU1WVmltZW9meERRekZBQ1hG?=
 =?utf-8?B?MkhSZnQzV1Zib081MWVleDkzb09LUWp1TVNYRllKY1RLL0t4QUhJbjF1TS9s?=
 =?utf-8?B?c0tSWUI3ck1VdG44NWtaYW5sODNsMXlCSWNobkdpUlZrbXNoaG1XMHhLdms0?=
 =?utf-8?B?a1lZMVFNS01BQVRlOFZ1ODNRQVZHUEdaSndWWlovV3pXZG9yT1VhSHFtVGJG?=
 =?utf-8?B?SDlvYm9LMVI3VHl0TlYwOXZxLzJIbGxXdHNFdzRYbzI1OFRiNzdaWktucDll?=
 =?utf-8?B?d1JGK0RZQTZaTHA5Q05CVkFtRWxDbEZ6TEZPa2plSExydjR3RWJUZDdUT3cr?=
 =?utf-8?B?anh1YnlRVnRLS3JTRmR2SUo4d1Nwb1ZGSW5ZV0VlYVFtV0xYQnZVb3JMVGdw?=
 =?utf-8?B?bUhhMWR3U01PZDhQc0R3SzJsNnVOdkxvZnZpKy9MWTBNZGhKaVZsRUQ4NUdq?=
 =?utf-8?Q?uXoY+J3GSARqAtxmhijEYnU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72568f64-8a71-451b-d48b-08d9da544bd5
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 07:29:43.5767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPVNOGJCmM3Onx5QSAuE42bWM5TpHDL21p7pysH2+2mCKAP0wttGRwD1An0/pbBn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2905
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
Cc: Felix.Kuehling@amd.com, Guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 18.01.22 um 00:43 schrieb Jonathan Kim:
> Move the debug sdma vram bounce buffer GART map on device init after when
> GART is ready to avoid warnings and non-access to SDMA.

Well that doesn't seem to make sense the GART is initialized by the code 
around the allocation so that should work fine.

Freeing the BO indeed needs to be moved up, but that can still be in the 
same function.

Also please don't move TTM related code outside of the TTM code in amdgpu.

Regards,
Christian.

>
> Also move bounce buffer tear down after the memory manager has flushed
> queued work for safety.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 +++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  8 --------
>   2 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index da3348fa7b0e..099460d15258 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2378,6 +2378,13 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>   	if (r)
>   		goto init_failed;
>   
> +	/* GTT bounce buffer for debug vram access over sdma. */
> +	if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
> +				AMDGPU_GEM_DOMAIN_GTT,
> +				&adev->mman.sdma_access_bo, NULL,
> +				&adev->mman.sdma_access_ptr))
> +		DRM_WARN("Debug VRAM access will use slowpath MM access\n");
> +
>   	/*
>   	 * retired pages will be loaded from eeprom and reserved here,
>   	 * it should be called after amdgpu_device_ip_hw_init_phase2  since
> @@ -3872,6 +3879,10 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   	}
>   	adev->shutdown = true;
>   
> +	/* remove debug vram sdma access bounce buffer. */
> +	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
> +					&adev->mman.sdma_access_ptr);
> +
>   	/* make sure IB test finished before entering exclusive mode
>   	 * to avoid preemption on IB test
>   	 * */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index b489cd8abe31..6178ae7ba624 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1855,12 +1855,6 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   		return r;
>   	}
>   
> -	if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
> -				AMDGPU_GEM_DOMAIN_GTT,
> -				&adev->mman.sdma_access_bo, NULL,
> -				adev->mman.sdma_access_ptr))
> -		DRM_WARN("Debug VRAM access will use slowpath MM access\n");
> -
>   	return 0;
>   }
>   
> @@ -1901,8 +1895,6 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>   	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
>   	ttm_device_fini(&adev->mman.bdev);
>   	adev->mman.initialized = false;
> -	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
> -					&adev->mman.sdma_access_ptr);
>   	DRM_INFO("amdgpu: ttm finalized\n");
>   }
>   

