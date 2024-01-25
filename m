Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC92C47258
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jan 2024 13:16:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B05810E2AA;
	Thu, 25 Jan 2024 13:16:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46F5D10E277
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 13:16:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7xS4bXNTGwvOl6U0gwoisMP8vI0Boijdu0BFXtbK8+std1htV3LGglaLUZ3UOzgNACb4QYPX6/tl4w0fFdhdvVJZjnWReyRYaxSsErY/PvZf/jDB5XDRviFogTULsl0cQPwGcLMEndX7FdNH5V+mqVrKwo6yZthY9NDtjS1EmSqDU4H8Tou3NtkME+YmGnVnapoVDC3DzJLPm5nUskQJK90xCJ4svnPji9/dKanYS+WR813tt2cja7YYTku2oyNzIBGOhYGrze8KaNHHnCwIvdhhW9ce3biJv5Yfw2s4t5hVM98HbwD1a63c4WdUbvU8Vizl4isR0oJFfjZmZOH5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuJOXNCz5sYSb9S4l4BMFMnrxhfyvvOYTsJowKZ++yg=;
 b=AqO4VrzWaICi/Ze1oSmzwcIs9RUdTBSY45YNntay7z8Q5bLgyxChzz3xpE/HgCGDIn2uifOakznyZEs+fNGAOdkGetp4oNo6JE9sEAaXyYbZqR9VaZPJJtEhqDnl5HsCFTaXJ8gcecWyWG931GETyrBioaQhNiQwk5SzZZUG3IPjQ+r6EAvdPnrPjBPfJwDAlri06MeN3UGahLZcVdyaj9LQbMy7NeO5DqOwBWfH2RHZWAOjvU/ApbSaQu4pgNT69le1Onyg1s1p9XT/buRpfXzYsHLapWXQbWX43Ag7ZbB4zsmT5gwof1bt4PrHmESk2jdGFcFIzm7YM6i4L1H3Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuJOXNCz5sYSb9S4l4BMFMnrxhfyvvOYTsJowKZ++yg=;
 b=3++Uxb1esRQQL7ZVEdBZrHjgA7+MuDL0UY8n5U56/sgvKtEt+pcc+KevT+pPkIbk6wBAcyeWtjRMjlSS3SitufZIxezd0xpclFh9bOCYiowFai7fb+nlymeGk88Tckg8R6IV1w7AqWJVwKH3xdjjcd+OqXSb01T/Q20JEXMo1HU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Thu, 25 Jan
 2024 13:15:51 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8%7]) with mapi id 15.20.7202.031; Thu, 25 Jan 2024
 13:15:51 +0000
Message-ID: <fa78f5d6-4940-4180-87c0-46e229b3ebcf@amd.com>
Date: Thu, 25 Jan 2024 18:45:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: move the drm client creation behind drm
 device registration
Content-Language: en-US
To: Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240125080710.9091-1-le.ma@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240125080710.9091-1-le.ma@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::13) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|CH3PR12MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 1328f49a-10c3-4c6e-b57b-08dc1da7c08b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6d6e76YnhnDNhekeLmW+PK4MSalap646gY/gGgWwNmkf5y3s4/l62VwaCiCY/iT+3DVE42wm6oimboAEe+7DEL62/uS/XglFn4DUsDbYigg9EsB8ofHgr8pbARotn1KXgo9viOseFVX09BOtYb1pOpt82c/x/EOexnLRyeaQQSfKMSA+VbQrypamWH9xz2BjakpRNXMWpwFR9JwWyxZchgok3n0PJlIMC8K2u6a8NwwCrxKgtV7CkH5p7XJDESLtEFjyl93OcC8Bn5lZrK87Sk863ArJCNcDas7070zU4QtHwm4wXQGG5l0cJyvqH3SoUChX2V2I3guXmjEPXivE1g9+6xc8FUfnmyrqLYY6WVkoI4L2qnB8sQLqdEhgzwlH5d/nALHhSGwaxjWvUbye7zkONAl6BCCNH00b7ho1UA+sMyGpT2t+ziZM4bZYBbn1rQYHiVY+Tmar0NLAxdilcy4CZIuZbEx3pEMoB8lSbCNcc5k1nCLELweXuS+RDXFAk+uLNpbrYKl2HPTFFKY7f6Qq6BNaWcE1jIcvHgJo0eofBytusk9ZC1XiSVNOeMQYXxXhYCwaYtz7VYaDlCdJ6D2FT71AE69UH52Brobbwnm3rAlBIXZlmYIZOWQHdUVb1o4xzsGu6aO/tXTJAbLfJlw/KvTUA0uIjRuU3HKw3y06/y6vkMYAClCyPJ7sPOsn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(396003)(366004)(376002)(346002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(2906002)(4326008)(5660300002)(36756003)(41300700001)(38100700002)(6486002)(478600001)(6666004)(26005)(86362001)(2616005)(31696002)(66946007)(66556008)(66476007)(316002)(6512007)(8936002)(8676002)(53546011)(6506007)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnMvZ0o4OTBzUjdLNGduTUN6M0xubGZpSHh4VWJ5WkVVY2k4NWpHWHI5cGYv?=
 =?utf-8?B?Qjd4b0g0UWcyY2d0WkRpTm9wSW5zMnhzeitLekxLckI2MW9zWW04QXhsSmI2?=
 =?utf-8?B?NmNzb3JPSldsQ3FORWM0aE1aZ29qczRreWVaaXJXd0lXa1B0cGNQZWZhNXZH?=
 =?utf-8?B?T0d6L1Z5WGJqckg2T0ZoVEFtMnpIc0JnYUp4T2ZKYmhOOUZMYStRSy8vUUtj?=
 =?utf-8?B?ejVXUyt0RFBNTStiLzA2aWdVc3kyMUF4b3B3UGw0WnpKNEo0T2wrVjBEQk9T?=
 =?utf-8?B?Rmx0RmNvdjF0YTUxNXV0SDVmUlRCMzdRdUZaQUhDaTVzcGw0NTlRYXlVdXBo?=
 =?utf-8?B?MWQ5VXRoL01JZ0NWdUtSU2FrOWVudnpUQlpyNi9UdW5ldXBPM2RiRCs3MTBW?=
 =?utf-8?B?ZWQ2MEt0djQxOThKc1lwVlh0bUJxc3orL2x4VzR5TC9vTEdVelhKQXRoKzl5?=
 =?utf-8?B?eHhEMk1ZdFFTYStHQWlkTVZsamFSVllPR1NVejRWSU81QU83UTJrNERUazBR?=
 =?utf-8?B?NEZQTDBBUVdraVdCU2lwQk5QcXJqb1VKUnZDMjB2bjNJVEF2QytqVTJaOWV2?=
 =?utf-8?B?dzYwZWhNSThCSitNUG1aWWo1UW9mVDZEcFRzaUNVa1lxUWFuVVlXWHM0SWpt?=
 =?utf-8?B?NDRPRHlLdW5Eak1pK2d0UzFvamswNXdQWUo1YlRPVHNYSjI1Y2F4MnVYVm9o?=
 =?utf-8?B?Z2c2b0xMY0h1VWM3WjdES0ZUbzZTWFNzSUZTUzBCOXVLMm9XeFA3VWZSODZC?=
 =?utf-8?B?YUZFUXF5MW1YNENHYWR3UlVLazVuMi9HakloajFlNGN3Z3c1Q2Jva2QzVzFl?=
 =?utf-8?B?L3RmQXd5OHdoZlRkVE4zZjgwbnI0dUZKQmdjVjZTcWtwNjRyeldONis5cDhP?=
 =?utf-8?B?aFB5dVBRc0lCZEFtQythaDJRaWVkaDdBbnN3aTdvSFFCSXlHWGh1SnkzRWgy?=
 =?utf-8?B?VzFlbWhsRVFhY3VDamR3eU1GQ1NNYUVRU05kVUR6Uk92WU1XTkxrTE1sYkJ5?=
 =?utf-8?B?VTMwQnZxMndRcUtIdlR3WThFNzFVdis1akhjMXJvS0g4ZkdlUFpLTVY0UmNV?=
 =?utf-8?B?dTAra0d6TVlQMjZmVkYrYkQyQWZiSUVRcWgxZ3dvRFZsc3NlQUNYTVBLblFH?=
 =?utf-8?B?NXJRRHAwcGsvY1QzZnZLRk5reFY4QU1QcUFXL096bzVkeEtzcXNoWk5zQTVy?=
 =?utf-8?B?aHNaUEdibGR4L251emNBTG8yditoUjdkMC9TeVFtUDY2WWkxY09FL2RPTDhT?=
 =?utf-8?B?K0hYZmJTaXlJVkU3NFVkVmdTa2hzYVZoOE8xVFpMZ0laNTdRdGRZZEV4SXhx?=
 =?utf-8?B?ck9Pa0doM05RRUNZc3B2R2RkTXNFbUs0Z2ViSWFwZi9CenVZaUFqb1pyaTVH?=
 =?utf-8?B?VnBaS3o0UE5ka3lEZlZpZW5hRisvQ05yTnpuL2xwb0hCeGhieC9sV25wRFg0?=
 =?utf-8?B?eWQ4aVlNQTl5ZGtJMkQxWks3MGIwbExLZDVTblVvZnc3WTVFWGswdEtoN0lC?=
 =?utf-8?B?Y1JDUVd4SU5sT25LaDc0L2NxbXlQU0NibEkvelBWbWdrbUhYOWJSUVVMS1lu?=
 =?utf-8?B?WXdJQnFiRWpGdHdKa1ZkVERnVURZZ3dtUGdIUCtyWXNHczhRUWo2SkljYUZP?=
 =?utf-8?B?RTY5Z2w5WU1zSldQdlNpb29jaW15aW9CUUlYRmtNWTZkMW02QktDYkFEaTdW?=
 =?utf-8?B?Ujl3VFhYdThJUEc0T0JsVzF6SDRLZXFXK05YR2ZEOVVVckc1bEJtKzZNUUJp?=
 =?utf-8?B?bFd6RTFuNW5WUCt2RFg4MytwN1M2VS9EeWhqZTBpSnZ6NDk1ODZrcDkzRnZr?=
 =?utf-8?B?aXFJTUpIVTVSa1RmUzdld3hxZGN3NXZUUFV2SVlvTUpKZm9zZFVSQldNYWIv?=
 =?utf-8?B?ejRLK0QvdXBTV1B5S1VNOThGVlR5dUpFUi9FdFhkYU1Yb2xqdTNUSXpPNCs0?=
 =?utf-8?B?RjJseEU2UERmU0t5dU5aaG1yL2Y5NjFnZ1o0REUxMFJvUnhRSkkwYmpvVUlF?=
 =?utf-8?B?bUNwcktSYks3ZmxFQ3hHZUI2NjJZTy9mdGphMXhSNHBUVmptelBORHJLK2VB?=
 =?utf-8?B?THUvaVVsZE9nSFpQcTRpWlpseHd4SnUvb21sdEJlcTJmWDkrU0NRZlFQNEsw?=
 =?utf-8?Q?ep8LCOOxTiwWP/KGtlGjR6EBx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1328f49a-10c3-4c6e-b57b-08dc1da7c08b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 13:15:51.3406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3wZtBUdfDb3en41RK3hNivZMPYG6zlo5LcznTwf3vFDGODUczmczwMdObXYtybK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642
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



On 1/25/2024 1:37 PM, Le Ma wrote:
> This patch is to eliminate interrupt warning below:
> 
>   "[drm] Fence fallback timer expired on ring sdma0.0".
> 
> An early vm pt clearing job is sent to SDMA ahead of interrupt enabled,
> introduced by patch below:
> 
>   - drm/amdkfd: Export DMABufs from KFD using GEM handles
> 
The drm client creation logic in this patch won't work well for dynamic
partition switch cases. Better add a ''Fixes' tag also.

This looks fine to me, needs to be checked by Felix anyway.

Thanks,
Lijo

> And re-locating the drm client creation following after drm_dev_register
> looks like a more proper flow.
> 
> v2: wrap the drm client creation
> 
> Signed-off-by: Le Ma <le.ma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 32 ++++++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 +++
>  3 files changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 77e263660288..41db030ddc4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -141,11 +141,31 @@ static void amdgpu_amdkfd_reset_work(struct work_struct *work)
>  static const struct drm_client_funcs kfd_client_funcs = {
>  	.unregister	= drm_client_release,
>  };
> +
> +int amdgpu_amdkfd_drm_client_create(struct amdgpu_device *adev)
> +{
> +	int ret;
> +
> +	if (!adev->kfd.init_complete)
> +		return 0;
> +
> +	ret = drm_client_init(&adev->ddev, &adev->kfd.client, "kfd",
> +			      &kfd_client_funcs);
> +	if (ret) {
> +		dev_err(adev->dev, "Failed to init DRM client: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	drm_client_register(&adev->kfd.client);
> +
> +	return 0;
> +}
> +
>  void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>  {
>  	int i;
>  	int last_valid_bit;
> -	int ret;
>  
>  	amdgpu_amdkfd_gpuvm_init_mem_limits();
>  
> @@ -164,12 +184,6 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
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
> @@ -208,10 +222,6 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
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
> index 584a0cea5572..da175c384adf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -182,6 +182,8 @@ int amdgpu_queue_mask_bit_to_set_resource_bit(struct amdgpu_device *adev,
>  struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
>  				struct mm_struct *mm,
>  				struct svm_range_bo *svm_bo);
> +
> +int amdgpu_amdkfd_drm_client_create(struct amdgpu_device *adev);
>  #if defined(CONFIG_DEBUG_FS)
>  int kfd_debugfs_kfd_mem_limits(struct seq_file *m, void *data);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 475bd59c9ac2..91d5d9435067 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2255,6 +2255,10 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>  	if (ret)
>  		goto err_pci;
>  
> +	ret = amdgpu_amdkfd_drm_client_create(adev);
> +	if (ret)
> +		goto err_pci;
> +
>  	/*
>  	 * 1. don't init fbdev on hw without DCE
>  	 * 2. don't init fbdev if there are no connectors
