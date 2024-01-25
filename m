Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF76C47258
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jan 2024 07:04:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8885310F81B;
	Thu, 25 Jan 2024 07:04:27 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0F4510F81B
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 07:04:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFHnNDjCexNqomuVxP8qgZ3HWPmOouRW9djEz49rLkd0IQKqsthGYCUBE94X0X/D5++U0HqQVqi5b4+IkJiwC1qGwAk+AOwCjxYllykbnCVRWZEG0I925TkOmzVlnYu5sA5cZBFQoTbiyZfvFqvriI30vOhif9Wf8kDk1+DV+g0+r4gdxmWHz+9bGK/lpL84ZZV7d5wLXiiESUtypIRWprMLLzCILuIu7dbecJpS7vWoNU51QVlhW8WKaH6/5UHEICb9M1H6AyFGc/JQnjwFtUWXdd4OOR9MetdM5a6ZLZE2CoWrU2TlRHUWfh4bjiOoMy0CdpRAJWu2fqNTprqAvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4Ts1Kk84ITNZc95ij+Xxw/jxsU/QDL9nBsvEgKKAMI=;
 b=L9oIXJPQ5EJgXIT5obrsZRyMpjy6q0gHdykuGWfd2P/UbQtAUjSXPS4yFQt+ijC8J+hPmpv/lmwJS6sgq9VpkLv0geYsyxn1d3uk6eTg2MbNe/AcHg91ccDsTIcTc90IcHCV1qU9RU1sqPe+cZFGQi9WjuVgV9DDN2WosOiCkNoWfHkbQ5aJbolwC03N+c+3EONlf66eASzFvi4VJe6y/wP4RRMbKF/m4dNW8YNJ45l36dlmJRnWmDSfjb2PwalBv0f2T0V2L6UrX8LNmyU68PzHP5HJZUCq5Uy6McZEO+FoI+iTheExV8xoNly0I7BpYfaORw2wXQ2Av20N4B6auA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4Ts1Kk84ITNZc95ij+Xxw/jxsU/QDL9nBsvEgKKAMI=;
 b=4xa6lFtAxTAN+L1ShZHCSUKduN962U1XZR46Iog2KOGrGAxqX+WO6bAVZdFWM5VY0NyoEpBblUqHgU2pBYzB4mfPqiRn1GOr3ONHXAowfly3uGU5VxOAVbn+S3EZfEcgjHF+KFnjTcWtpqpnoH8fh3m5tlRdbQDTy8JFB/+exzA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by SN7PR12MB6910.namprd12.prod.outlook.com (2603:10b6:806:262::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 07:04:08 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8%7]) with mapi id 15.20.7202.031; Thu, 25 Jan 2024
 07:04:08 +0000
Message-ID: <71a535cd-c84f-40d9-8c10-c4f00e1fb9c4@amd.com>
Date: Thu, 25 Jan 2024 12:34:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amdgpu: move the drm client creation behind drm
 device registration
Content-Language: en-US
To: Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240125061831.28290-1-le.ma@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240125061831.28290-1-le.ma@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0150.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::8) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|SN7PR12MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: b99d2eb6-21e3-481f-c8cc-08dc1d73d30c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t9TRaGthbnllK2xcDsZNAtRXk8irunZ4gHDHsXeRWWx6HoyihBzvmZ75bnlfCLTOeomJ1Yaox/N8YlXMfsmAwx2QdeFjuihc9cugmhj4+elcQz2li6AUMUbClAYYpSZnRHsnzKOWor4HXKP3/znniRDUuJzR6VoJhN4je49xtwtlZWljrTN4FhBvGKpq4dT8FvtY4yra3NeRteDZVUcNDg/QJmSlDWgx+4rUCWqQULc+rmqjeMCjDVfdqz2hjbtwhL3FgZZz3ueaDJ8ZT5RnxXcOK7VGDF9/Ydr+cj2ByKblkwOdWVa1/JHTcwFtTSpfT+wEFiQlNobq+kWst+M2UNEpf+X2+30AT7zR9nggV2oZH5VcMtJXsBO1JRsHLqlyCVQvmVAZNvPdoVVEqV/250sMuq/PS+mXdEa7uhnxmwy6kYJVEtdvyniKRVs5u21Ll/Oo4e9WvhdZatBQUIbyJX3tMjlKaqgdmB5JdPDlmT8zKsPqElleXwN5sPNBNn7z0ppTp2eDP8QO7xejU4yHQptRUSGFF9dSqj0Mfz8usgT7ExiTbHv2boey3bxQyCrnzQ//nLSh4y7YuDwkwFDZvLTYUQiL+N2BNykxo17hrqgwT7ERAPdi6Nn/VFWT1PvohyRtBUsscidP69mfEp2CN0jeLdKZKOfraD7QJ6GMPJJ+BJgPWLYtFh/K0AGBb3Hv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39860400002)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(1800799012)(186009)(31686004)(66556008)(66476007)(66946007)(5660300002)(316002)(6666004)(8676002)(26005)(4326008)(8936002)(2616005)(83380400001)(6512007)(2906002)(478600001)(6506007)(36756003)(41300700001)(86362001)(31696002)(38100700002)(53546011)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDVxbHVBaWJGNkZQK1JRS3NtQlc1aCtRMkIzY1dPVWJDU2hqQSs2RGFON09P?=
 =?utf-8?B?cmdyZEMzNE9DdWF0UWZGNGxwTVhUWU1LNVV5V1NXUlk1Ym93dkhYNUxsL1A2?=
 =?utf-8?B?MnIvR2hlS3ZaWC9aYVJnUzkwSFk1RjQ3L3dzU1FKTmU4cUhlSFMyZmJiaG43?=
 =?utf-8?B?bHE0SFRnYmxWb2tpa1FrNExWam5IdEMyTllGajA5dHFPUDNzRUdhTHBBcS9v?=
 =?utf-8?B?eEJtblVxWDlMU3VpQ0FXbVZDMHhhN0RTbk56QXhIVnkzMlQ5TnhtMEc4RE15?=
 =?utf-8?B?Y3BvK3pna1hNV3lEaHBTMTZqMFE2bDJ3bEdUMUZQblhkTG9rdXRiSWgrZDUr?=
 =?utf-8?B?eUp4MHlkTmtXallDeG5CaE1nbm9oQVVXbjMyRUxnNjJPUWJpSWVNaFArOVgx?=
 =?utf-8?B?Q3QvbGd0YVFQaTliSk9rRXV1N2k0M3RpOEZ0ZGt5ekdzR2xOVEp3OG4xbDky?=
 =?utf-8?B?ODZ5SDdJMERxZ1FiT2p0dVk0Y0Y4WEhnNTdUcXR3U25FejlOVzF5OU5pWXp2?=
 =?utf-8?B?UWRsVjhWeDk4THBHWmpHYkh6emZlbFdCc3JoTTNhcDQ5ZmllU0x4OUVKUGR5?=
 =?utf-8?B?dzdCZGM4am1EK0Y0ajB5UTM3TCtNQVpCalAzc3ZoRDdkZzFvQVZ2NmlNSnhQ?=
 =?utf-8?B?MXZ2Q0NLSUlZbmg1T0xyOHEzN2hVNDhBQ0tEOHZwaGt0WmNibXJXNlhzVlVp?=
 =?utf-8?B?c1hSS1VLb2FHSjM4NnFLbE5OSTBzelRrZlJHQ1EyaG9FbEVzWGpiMW42YzJE?=
 =?utf-8?B?OWNTYVpSOXRXWE1tK3VKOFVwN2lremp5djkyK2I3WFlhU3dISmt5V3VWQnZB?=
 =?utf-8?B?TkhxcCtWc1hNaGVJUE9kT3MrUzZvbWFtSWgrWWZQYXNZNzZRdTg5RXBkUmdE?=
 =?utf-8?B?ckpyNy9CZFdkMFlTZGVsNWkxM3dRVVBacVlVVm9GSFlFV3U1WGZvVmpxdk0y?=
 =?utf-8?B?anJybXpxcEFjeDJpbFR5ZlI5NklFTUNJdnNMcUQwNWtrVllOOEtycjNHL2I3?=
 =?utf-8?B?RjI4WFRscGdFMTRodFFwWm1ocHBsK0tNQ1ljd0hRQXlKcUhXRnJVQW41dTZS?=
 =?utf-8?B?elRKRTJoZEdIWTdYQlRoL0NpdFhQcTFCWHE3cytGSzRsaUZDcGFDY05nMlh5?=
 =?utf-8?B?QThpZ2VRbDJuTi9PbVl0R24rQVRuMVdCcytSOGV1V2gyL2pOZW9RRlI3VTlN?=
 =?utf-8?B?OGF2L0NPOUdBblRsNkhmL090M3RXY2dvcTFRa3lxM1F6TWR2MGsxa0RPTkN4?=
 =?utf-8?B?K0Q2Rk44bXlWUnhZWFdBUVhwUDBsb0FCNWFjVklqeGcwTVFRb0JWbHprNE9h?=
 =?utf-8?B?TDJzTVBDWTZKRG5Nb2tvaEZjRUovNkxXaHRrTGVzWjZMOTlLUU9tcGVMT0Qy?=
 =?utf-8?B?ZGVWeGpRekRDWkZMMUtPUW5GL3d2VFgwbnhoM3E1bmJKbFNsV3hidG96L1dx?=
 =?utf-8?B?ZDk1Wmc5NVpFTDB4NDRuLzE4TTdYcGtOOU9MbzhLcW1mTUQ2akRJNHRIVzRr?=
 =?utf-8?B?T0lxV0RucTRRLzl2M2Q0VjFSL3lQemE1QXpPT2p4U3lQbWhaRmxicWRoRXN5?=
 =?utf-8?B?TXlNYllwN0Q0alVwT00yODY0T3JKYW5BRmZ1cnNGbEdLdDBNSzczaXNZU0g5?=
 =?utf-8?B?dnJIeUV1NE01N1ZMM3pNUGpXT2VUdGFKeVc4OG96dW9uTTdvTWx1TnQvNXUv?=
 =?utf-8?B?N0NmeWxEZHd4L1lXNytKdXVySWJ2TkdTYjkrOHI1VjJXanZHUXZSVDQyaStP?=
 =?utf-8?B?QnNRNXRPY2VUdTlsZUxrcFVhQkQ5WEpKc1RmZks2K1pGYzVhOE0wL25SdEpr?=
 =?utf-8?B?WFVrUDdyalpVQlprdHcwTGVwMlRVdGtPUlV0dFlPaWRIb25WMTJBM3prcU92?=
 =?utf-8?B?NzhPRHBtSWdlL1Nwelp5QTNHSGVNUGRhZEt6VTNoZ2VENGZkSDFqWVB6N1ZU?=
 =?utf-8?B?QzNBbGpYNDNLME5qUjN2ZTd3QTN2QklQaEs2N3lqemZOdWRZWkpkRHE1LzJh?=
 =?utf-8?B?S0NZSFUxRGkrbU1DdG9VdHFKQUJ1bFFjeGZWMHlXUG00WFptVHRPMmpQdXpU?=
 =?utf-8?B?d25FRXpnYm0rdUFpdjBmQmNleDhNSWY0MHpIbXRHWDBDay9iQlU2MC9rcUti?=
 =?utf-8?Q?19EZ1Zdy1IUaPzED9beooPcHZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99d2eb6-21e3-481f-c8cc-08dc1d73d30c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 07:04:08.2886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4X2Iz7/rgrM63xuZfYWEI4RywXf3TYvkf/DFVXR3raPGk3PG4ccN1BOaLWqhKEc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6910
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
Cc: alexander.deucher@amd.com, felix.kuehling@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/25/2024 11:48 AM, Le Ma wrote:
> This patch is to eliminate interrupt warning below:
> 
>   "[drm] Fence fallback timer expired on ring sdma0.0".
> 
> An early vm pt clearing job is sent to SDMA ahead of interrupt enabled,
> introduced by patch below:
> 
>   - drm/amdkfd: Export DMABufs from KFD using GEM handles
> 
> And re-locating the drm client creation following after drm_dev_register
> looks like a more proper flow.
> 
> Change-Id: I0fece177b78345187068f92a823d96b3b7581140
> Signed-off-by: Le Ma <le.ma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 13 +------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 11 +++++++++++
>  3 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index add315644773..69eb0f5574d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -139,14 +139,13 @@ static void amdgpu_amdkfd_reset_work(struct work_struct *work)
>  	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
>  }
>  
> -static const struct drm_client_funcs kfd_client_funcs = {
> +const struct drm_client_funcs kfd_client_funcs = {
>  	.unregister	= drm_client_release,
>  };
>  void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>  {
>  	int i;
>  	int last_valid_bit;
> -	int ret;
>  
>  	amdgpu_amdkfd_gpuvm_init_mem_limits();
>  
> @@ -165,12 +164,6 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>  			.enable_mes = adev->enable_mes,
>  		};
>  
> -		ret = drm_client_init(&adev->ddev, &adev->kfd.client, "kfd", &kfd_client_funcs);
> -		if (ret) {
> -			dev_err(adev->dev, "Failed to init DRM client: %d\n", ret);
> -			return;
> -		}
> -
>  		/* this is going to have a few of the MSBs set that we need to
>  		 * clear
>  		 */
> @@ -209,10 +202,6 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>  
>  		adev->kfd.init_complete = kgd2kfd_device_init(adev->kfd.dev,
>  							&gpu_resources);
> -		if (adev->kfd.init_complete)
> -			drm_client_register(&adev->kfd.client);
> -		else
> -			drm_client_release(&adev->kfd.client);
>  
>  		amdgpu_amdkfd_total_mem_size += adev->gmc.real_vram_size;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 00eed8c10cd4..b2c6f2b3c0fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -40,6 +40,8 @@
>  
>  extern uint64_t amdgpu_amdkfd_total_mem_size;
>  
> +extern const struct drm_client_funcs kfd_client_funcs;
> +
>  enum TLB_FLUSH_TYPE {
>  	TLB_FLUSH_LEGACY = 0,
>  	TLB_FLUSH_LIGHTWEIGHT,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 0d0aa4b798ac..d0b98343481d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2293,6 +2293,17 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>  			drm_fbdev_generic_setup(adev_to_drm(adev), 32);
>  	}
>  
> +	if (adev->kfd.init_complete) {
> +		ret = drm_client_init(&adev->ddev, &adev->kfd.client, "kfd",
> +				      &kfd_client_funcs);
> +		if (ret) {
> +			dev_err(adev->dev, "Failed to init DRM client: %d\n",
> +				ret);
> +			goto err_pci;
> +		}
> +		drm_client_register(&adev->kfd.client);
> +	}
> +

Maybe better to wrap this in amdgpu_amdkfd_drm_client_init() or similar

Thanks,
Lijo

>  	ret = amdgpu_debugfs_init(adev);
>  	if (ret)
>  		DRM_ERROR("Creating debugfs files failed (%d).\n", ret);
