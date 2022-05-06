Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18882C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 05:02:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59D8F10FF65;
	Fri,  6 May 2022 05:02:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A77110FF65
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 05:02:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqH6/GsF3R4DerhqZvxilBhX1XHzIehrQ2p0p5seHMDRFTN4Ejl+AT0yC8363JlfzGM8P0ln7FazhedjPrXf9zRD7aosw7NVUPdl6Bwbs3nLCzLZ9UAE5fnAGCpwtipVrg6FVphvZjPqtY2mhQoHOxTMDqa4oSP56zgGjRY7niwLVNUMbwAP16rLaSFyJUj8R+MDIkZyfdukdYpq919JuUoNJNronQTC73m5jAF34pWEO1FSv8PzINYTrNZtTWhMvrCMCCj5N7pyQGB7tffj2z9+0uY2XtGhNVYJbxElHy3jp4Yg9jY1euKlIDQLyRr16EbWSw2L46tUpQsoY1vqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gz7fOynG4Xx0HTR3lL96bNwxf6M9W50W+zR6WvIJn8M=;
 b=ZMi/cydoyEDgLCMu0g4Y+r5lmr4GH1ickwuKH+8H6O+rnE89lHdcyz2vrRJTszPuStcfH0wLx08u3OPunIbcFOTYughkl6GqmxgwzTN/ywh/Kf0jfHxgbtNkkhSQ/gXsznYKwogevdtXr/UT11/ZYXTJ4HGKQI/tZgLHlpoSyMHXYYCiuegyhwcRz2Gd0RvdE5oZRL/gpvepckwBqu0gAilAln8jORwH9TwuYKxVnkxOW25/pRHRrxzP79hRckLNAlxLTL6YdjgfK7eSkjM626jBFPbmRLB1exHX1NEkT8hqUmFdtxyimpiPPsnoqsmb2tLDoAH+vKmIFz6hpTROmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gz7fOynG4Xx0HTR3lL96bNwxf6M9W50W+zR6WvIJn8M=;
 b=lIfFVZ/bj+QjC2kMPe/FRikArdNR34beby7AypC3vhR+HlLz/sUX1FfUcAtoyIYnXy4+Qa1nzoeGXhSYOWLruBGTnMo3lDCqn7V2u7VFgmYL/YM9sX2tgvtzTQiL7ErIfrOzJ5gRmAzPb/4nL4a5bXOapuGLgO0zIgtZMxGsJBM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DM6PR12MB4731.namprd12.prod.outlook.com (2603:10b6:5:35::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.18; Fri, 6 May 2022 05:02:32 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::588c:699c:71b:b6f2]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::588c:699c:71b:b6f2%6]) with mapi id 15.20.5206.025; Fri, 6 May 2022
 05:02:32 +0000
Message-ID: <ac0c55f7-20ee-9cf4-f52f-1a168cc4e8f8@amd.com>
Date: Fri, 6 May 2022 01:02:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/8] drm/amdgpu: support mem copy for LSDMA
Content-Language: en-CA
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220505200406.1293467-1-alexander.deucher@amd.com>
 <20220505200406.1293467-3-alexander.deucher@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20220505200406.1293467-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::14) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe55e40b-96a2-4579-e4a1-08da2f1da0ae
X-MS-TrafficTypeDiagnostic: DM6PR12MB4731:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB47319F498FD405860F4408B599C59@DM6PR12MB4731.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Drqx9SfPYeCbObBSVCgENTgPS46kLX63PJNAXkAZjg8ez70+v8Ar9jKgK0mgmh5k8pEHpRpgvaUcbsvV1j2hjqND4Q5RxKmUg95+q88ib8ZxWREOMDQfdAyfFEW+mk59LgK68Z3G8FsL/TnP36quN4SUsVy0eH2mvbLHJYQ1M6EBFujZU6JUHFPWtsvn0s4gLbTrqmPXqR5SSPjoHamGavbz1d6eLPfLctDyo0BOtjSoXnCCN5kaEQhnXpPPSnB0WBU1l6dskv+cVrx3ysTkJ8/sDVZwZgbaTMj9pUqTwJHOX+XQaCMdD3957OQGxBQSSl4zRcNwmxKIEdT+bRTniNM1ik4qDKWYSoA48WLXEZrXHyaVlCgzgkbpH0xNd7flqIDi/uRS91+2MJ6mZJqCMKZTB2sQdSdHcO2fS8tMFuKs/vV54jcAWKHEBXZw1kv315ce8+BoM5jOIL7Ou34KLV3xM7+6vRYsUut1naNliRGA555qiVxnXVZO1aN5+5Um3NZsUs523O1bfRSmHxNNpMm8UC+XiAsIP6NXHZet5KX9PHQ7O7k5nPhadCc9BrDQayWUulpcMJxkvrgUwna/M3P9cEllu0KLR4mPgnJjlJ1H0Gkx6hxkGFakDNSjCjRqKIw0Zgw6RYXx7KrIWTieqkwgDf1zebkTtEy+dseewHBZGt9Ok6HsddoTVFjjiN2tatEvpX6t3829lKfdhjMpr7VTele/V0reg9sWXE9fF9Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(31696002)(186003)(66476007)(66556008)(2616005)(4326008)(8676002)(66946007)(508600001)(26005)(6506007)(6666004)(6486002)(38100700002)(54906003)(6512007)(316002)(8936002)(53546011)(44832011)(2906002)(36756003)(83380400001)(5660300002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjVseVNJa0tuaTRkUHExQkFJZWFCcm5abkVHUEdhbTVCaCtDOUE1RGhnUFNG?=
 =?utf-8?B?c1M4d1VIbVFxYkMzSml0RmhKWW9yb0hFalNIMWNCeGNBVXVlQ3hMbnN2QVpW?=
 =?utf-8?B?RG9iM1J6bGVxWSt2VXk0aXZvdWlSUjJvWWNuanRrREtSU0tsYVQzNWJubHhN?=
 =?utf-8?B?ZDdMZ3EvYW1Da0pJcHVXUHdQVEp6OEZJMHdUZDdhdVZINWtKQnltalVoRWp1?=
 =?utf-8?B?eHNybEtrQ3hHdnlWTUtrK1ZmRTBlUWVQQlVUZGFoOUtlV0IyQW9RQmZmWGpP?=
 =?utf-8?B?K3plOGRrTHpnTnBvZVY2R0VicGhrVzl4bEh4NitraXZLUGNpR2NkR3N1U3Rt?=
 =?utf-8?B?RUVPd20vQjhxa1ZpSUo4eGo0TklMVHZ6aTkveGFqR25XZy9qRFpvL2p1ajNR?=
 =?utf-8?B?aWMxMS9QUkRZTGUvTWVyTENqVWNSVEZReGV3NkJEQXFDMUxUMCtUWVRoTlZn?=
 =?utf-8?B?emlJOE9lQVIrOUVTeER6bURYTHZrTXlPbEgrTnBsSHpqbEt4cnJpemV5OFFs?=
 =?utf-8?B?T1FURHh4ZmNGS0lNVFVubGJrai92OWs1MEt5NXlsRVJ6WXU1ZEJDNWFaejRQ?=
 =?utf-8?B?Q2RHemNNc2M3SVp4UlJqN2VCOFZHYXlxcTdXOTFrMDk5V0NSRDgzaXk4am1l?=
 =?utf-8?B?WHdHVWlYbEh4SEtxRWFRNmNaZk5hWFAxWEgzV05VN3ExZXhLZW1NYWgxRmp0?=
 =?utf-8?B?cm0xakFhc0N4M0xVb0JIZWh4ODlRUW00YXkxT05ZSTk2Z0VNOHN4aXhnRXRF?=
 =?utf-8?B?MFhtU3VCNzE2SktNaGVVS3Y2dEtrL0c1U2p6NkNPcEt5bWVUNDlsM21pdFlR?=
 =?utf-8?B?QWI3aWJ2d09OWVNtOTkrc2lZRm5jSXZ0Q2t2WkpjMjNKSUh1SUVLT3FNV2lm?=
 =?utf-8?B?Z0J4WlEwSDZsUzI0UmJUeWNSZDlQamxMUXZjSzV0YW41UGx6dmFEVlJkQk42?=
 =?utf-8?B?ZEduVFVJd3hFempEMWhOMmhaMUdiVTQ5Z2RVOS9kOEdUOGZKWU8rVzdOQ042?=
 =?utf-8?B?U3E0T3VXbC9LekFnN1ppRHc5dHV3TkE1V25XdlVzMDJtNUdoVzRjWWJCeEJj?=
 =?utf-8?B?WHBGMlArbFhoQnBYSWdmdGN5ZDd1RlBZMk93WDlCZXQ1aXZSQTkzaXRtUWdN?=
 =?utf-8?B?M1NqcVB2MkdERGh2eFZ4YldKUm5MR1ovUXlZNTVBdEtjdFhoUE03QkN5U25C?=
 =?utf-8?B?WW5sS2lwRXJ4L296a1puYS9QeDdTTTYzKzROdXkzNSs5THhrLzI4WXN6djlV?=
 =?utf-8?B?azRSTEprcDFmMWZrWlgrbXFlT1VvRXFjTUNmWFdGVUd0bHFISWpoM2p6OWR5?=
 =?utf-8?B?SGowNS9UR0JqZURjMk15TEJBR0JVUXRZZWIxb3EyWDRQcFVKUVlQQkJkTTlW?=
 =?utf-8?B?bGFOSytjdm9VTXlFMitRVnVsUVVwbDdabmdmeGorVDhqNWZWSERGZk1xVXho?=
 =?utf-8?B?dXJobE5GU3U4TXY3Sm12aksxUkhPdXVGSVlTMFBRWmRaRkFRcmN0WVlHNFdp?=
 =?utf-8?B?Vmo4WGxybjErdW5XRXo4aldVWTFMUEUzWHk0NDhzWjdkaVFOZlh4SWlRSXpo?=
 =?utf-8?B?bXRWVllZN2U3OUNYUUFTM2JRM2lFZ0l6SFlaYzNxUVNzZ2FUcmhJVXBXU1JG?=
 =?utf-8?B?LzdnZlpPcmJpd2liY1FNbnBuME9FMFVNaHBoS3lrVnBIOTRkTlFMZzVLcnMw?=
 =?utf-8?B?aDBQYkR6cU1qdnpQSGpwRUE2TzI1WnJKWlpvbVZVYlVYdDNUMWhSaE9XclB6?=
 =?utf-8?B?cDl2M0NJUE1JRjFNSTJyeENsYXJBay9hbHNyR0RrV2J1THd4V2N2WFlDcjE0?=
 =?utf-8?B?djVRazBqR3ErbkZjRU9NNkt5eGQ2Ny9OZ0twME1WRlg2YWlYU2Mxc055RTNS?=
 =?utf-8?B?N0h5K1V3MDZQdlhiY2R1K2lhNlFXVWdBbGM5VUxNTms2LzZoc2lmMmRuUEx4?=
 =?utf-8?B?ZTlHZ2syMm0zT2RyQyt1LzZ6c3hEY1dFaEtoektBTkpYd1NPTFRPVU9DZFRH?=
 =?utf-8?B?dnJWMVlSTGpSM05Db0RtOFNISVhsVUx4RnFvT1VsbHNCc01YVWVldVZkUG5J?=
 =?utf-8?B?OEZyQW5SRkRXYWlMK25qTDVYNnVNS1VIWXVXTmo4cVUzRnlpNVREblA1TTlS?=
 =?utf-8?B?WnJydjFjKy9UQXhjTUFZQjkrSndkU3pINzJzZWVuaHRsOGtvY1k0OXJUMkNn?=
 =?utf-8?B?ZElhclhjT0YvK2tFOWFjWmxaMHJwQ0pLMjhLa20rajcvTVVJdWVibWxhM2tn?=
 =?utf-8?B?L09JZTA2UWFKN0dCK1paMElvMGM1dEt6d1pYNy96MHIrdk81aDFVaVIyLzk2?=
 =?utf-8?B?ZW91K1NmQjZ6VkpxV1Z1ZS82M0xoNlAwYzVXbUwrMm04MERZUU5sQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe55e40b-96a2-4579-e4a1-08da2f1da0ae
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 05:02:32.5063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRM5ZXS6NVd2quCD1HiJCp+WwaO+Ky9EwnMhQrlmxQhHzPmnZqft9supRlHpScfX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4731
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
Cc: Likun Gao <Likun.Gao@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-05-05 16:04, Alex Deucher wrote:
> From: Likun Gao <Likun.Gao@amd.com>
> 
> Support memory to memory linear copy in PIO mode for LSDMA.
> 
> Signed-off-by: Likun Gao <Likun.Gao@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c | 26 ++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h |  5 +++
>  drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c   | 44 +++++++++++++++++++++++
>  3 files changed, 75 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
> index af00a66f8282..3f1c674afe41 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
> @@ -23,3 +23,29 @@
>  
>  #include "amdgpu.h"
>  #include "amdgpu_lsdma.h"
> +
> +#define AMDGPU_LSDMA_MAX_SIZE	0x2000000ULL
> +
> +int amdgpu_lsdma_copy_mem(struct amdgpu_device *adev,
> +			  uint64_t src_addr,
> +			  uint64_t dst_addr,
> +			  uint64_t mem_size)
> +{
> +	int ret;
> +
> +	if (mem_size == 0)
> +		return -EINVAL;
> +
> +	while(mem_size > 0) {

Kernel style requires a space after the "while" and before the "(".

> +		uint64_t current_copy_size = min(mem_size, AMDGPU_LSDMA_MAX_SIZE);
> +
> +		ret = adev->lsdma.funcs->copy_mem(adev, src_addr, dst_addr, current_copy_size);
> +		if (ret)
> +			return ret;
> +		src_addr += current_copy_size;
> +		dst_addr += current_copy_size;
> +		mem_size -= current_copy_size;
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
> index 4df4da423181..be397666e4c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
> @@ -30,6 +30,11 @@ struct amdgpu_lsdma {
>  
>  struct amdgpu_lsdma_funcs
>  {
> +	int (*copy_mem)(struct amdgpu_device *adev, uint64_t src_addr,
> +                    uint64_t dst_addr, uint64_t size);
>  };
>  
> +int amdgpu_lsdma_copy_mem(struct amdgpu_device *adev, uint64_t src_addr,
> +                          uint64_t dst_addr, uint64_t mem_size);
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
> index b611ade53be2..0d2bdd04bd76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
> @@ -29,5 +29,49 @@
>  #include "lsdma/lsdma_6_0_0_offset.h"
>  #include "lsdma/lsdma_6_0_0_sh_mask.h"
>  
> +static int lsdma_v6_0_copy_mem(struct amdgpu_device *adev,
> +			       uint64_t src_addr,
> +			       uint64_t dst_addr,
> +			       uint64_t size)
> +{
> +	uint32_t usec_timeout = 5000;  /* wait for 5ms */
> +	uint32_t tmp, expect_val;
> +	int i;
> +
> +	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_SRC_ADDR_LO, lower_32_bits(src_addr));
> +	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_SRC_ADDR_HI, upper_32_bits(src_addr));
> +
> +	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_DST_ADDR_LO, lower_32_bits(dst_addr));
> +	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_DST_ADDR_HI, upper_32_bits(dst_addr));
> +
> +	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_CONTROL, 0x0);
> +
> +	tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND);
> +	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, BYTE_COUNT, size);
> +	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, SRC_LOCATION, 0);
> +	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, DST_LOCATION, 0);
> +	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, SRC_ADDR_INC, 0);
> +	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, DST_ADDR_INC, 0);
> +	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, OVERLAP_DISABLE, 0);
> +	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, CONSTANT_FILL, 0);
> +	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND, tmp);
> +
> +	expect_val = LSDMA_PIO_STATUS__PIO_IDLE_MASK | LSDMA_PIO_STATUS__PIO_FIFO_EMPTY_MASK;
> +	for (i = 0; i < usec_timeout; i++) {
> +		tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_PIO_STATUS);
> +		if ((tmp & expect_val) == expect_val)
> +			break;
> +		udelay(1);
> +	}

Does the hardware specify a minimum delay after the write to the LSDMA_PIO_COMMAND,
and before we check the LSDMA_PIO_STATUS?

At the moment the code above checks the status immediately after writing to
LSDMA_PIO_COMMAND, and the copy wouldn't be completed.

If the poll timeout is 1 us, as the loop shows us, maybe the command completion
is larger than that (the time after writing to LSDMA_PIO_COMMAND and before
checking LSDMA_PIO_STATUS)?

> +
> +	if (i >= usec_timeout) {
> +		dev_err(adev->dev, "LSDMA PIO failed to copy memory!\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
>  const struct amdgpu_lsdma_funcs lsdma_v6_0_funcs = {
> +	.copy_mem = lsdma_v6_0_copy_mem
>  };

Regards,
-- 
Luben
