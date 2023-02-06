Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B372EC05027
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 11:22:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3328010E385;
	Mon,  6 Feb 2023 11:22:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01F6210E37F
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 11:22:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzroPZejn1L+g+JZxtddrWs4egdwWP4ntZ/3RgKbtIkPKebFN8RNgtSKJik8CD/50GvNxiydsnwdP5FvSWHwz2bXd+zaKua2gKI38HINS4KSmHhLXI0uT4iitOKB+XVKhgGVGLBntVCWUzVaoIWA+MRA5Ttjl+Pad6NmXVsfy5ooU/LL/INlg+bgi1fwZdCvgLSpqAWaDvD/gefaIPGyZX4sWPl2/fDYMouCTHd4AJHUnypCF9efMY4waCOgWiIl84OQDXj8Ao8nVBPN6fqeRLQjuhJb/d1hfXL0AvDD9PKZnvT7EjjAOq1HUt1csswb/W94d3OfNTZAVarUeotLgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgRtVgweeHIQsL79Koy0GkVijsNOYBi6+FAj2NqMcqI=;
 b=Fr1uG5yH0hy3FFa64h5JzjNYF1xartrk55JwT9RUc2MsBubo6Ddj+MPL3keVhDZXI0He+U/Qah1l508ly2yWLYbJPF26U4vQDxCjpW0n4M95j3K7y6D2Pfp/5J9mIgX4h26ZJ1h0e7Xkj5317rAGDry6YFePltk5JLxwTpytSIpJUcdArBOxVQVwtP/mt7IuM+xlRxJx1k9d+hEMkUIw6NWrEavVrPeWr0AxC7XW7BS8QLbF8GBXxzO2RpTNSX+jnw0qcOYrlYWnqhefBh5t3+xn2Y+Tgo3jUMyw/2LZfAYgJcOqbDTWktHGmvYICwjrp/d692Xxk1tHfg5xtWSRKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgRtVgweeHIQsL79Koy0GkVijsNOYBi6+FAj2NqMcqI=;
 b=hPgBIK5kzzpBYfyqhKhVaYMES6+osvBIw5b6rebzYJ0jkVBfTetDUdgpICPM5zQYgSTyub65KaLZqB96kwUwnvB2xsgqAe/kDNe3LVryRWXTpHike0SSVuOvlqezY8jh1CHq9c3RsBToIDrVZm8yYstjA9NpU50WIbjUgfHOIkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH2PR12MB4858.namprd12.prod.outlook.com (2603:10b6:610:67::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Mon, 6 Feb
 2023 11:22:45 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 11:22:45 +0000
Message-ID: <441e81fd-8c52-382a-bf4b-99f061e37a4c@amd.com>
Date: Mon, 6 Feb 2023 12:22:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 06/13] drm/amdgpu: rename gmc.aper_base/size
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230203190836.1987-1-shashank.sharma@amd.com>
 <20230203190836.1987-7-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230203190836.1987-7-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::7) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CH2PR12MB4858:EE_
X-MS-Office365-Filtering-Correlation-Id: 19609906-2937-44d9-b120-08db0834787f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LTFIq6J6mw34t0ZhzuIIp4YdcDaHhNFbn7R7lrjWaKkj/N1TwS1sXlAn8fT1Thw3vDHZzq63s2xnsjMdaiqbTSRXp4erdoSqCDSb/wjf26v0vypTlTyiXDbAzBjK14e/sIWgLhgkyegi4qnQBuFvIxE2iv4ug4ILP6U6sTPO/sget+ALK0S2jtIHa/M72I4GeFm1tgssefNzm13hLvYbeZtcFpj9VH6ed/jEzjs0Gm9+0IQM0S75rU/YYYoydy07yhOiCnIQ4QfyKgO2nvlj7T0G7jNZk4ijSMNt34SWiaQpFkwPC2q4A2p6utZIslMdVxldYLFUXfIps4/yahLrhXKL75goMbwDDmzaTTFhnluFoMteSdKKPlN7yot3zTWWggqvpzQ7dxcDbhaF4tlRFJYGsYfEWH8weoHbEE7H34aoCrk6jDyliSkGdgEHXJ9e/WQvx1MOxyFtzLONtnCdxl4x+bZSqp1JIUj/emWVg9DveNf+Wlg8qq27JUypU3UnOulQRXgvey1ieMALQyqaaA45cT48ZfNWybrlcItYkZ2r/WQeiWP7mVySKViJlkg7UIvf+yhRGsMJgq1o7VCridW6fGxjQfaYa59/z02fHZMzqbtpn7cB7t2o5oHg1q6MtGHzIq/JvDLCjczfsqTEb6EGr9MKI/AJCOzqNi/Q4uEvEjvYQ1MG5GE/l0tVXkQk3LzD9py5edQfr/4J+a4lH8TLGC24EMAQkYBDZ0YMRJE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199018)(83380400001)(478600001)(6486002)(186003)(38100700002)(8936002)(26005)(6506007)(41300700001)(36756003)(6512007)(2616005)(66476007)(66946007)(316002)(66574015)(86362001)(31696002)(66556008)(4326008)(8676002)(6666004)(2906002)(31686004)(30864003)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1hwQ25QZy9OZ1RGL0xYS2hncC9FNmhpc3RmSU5SbFdMSWR1OVgyNkZ1azNF?=
 =?utf-8?B?Z0NqV2d3WitLU0JzOTZMRjd1bU96eFZqMVhXTnpJQmtGTGNKenRLRHdPYWhp?=
 =?utf-8?B?RFlZQS9rTCtzQWhtS2tmTlhYN0JlclRiVDgvSVFnWVdXN2NBKzE2WEVOTjVp?=
 =?utf-8?B?c1JQWlVFV2FmQUNyaERZTy9rNnlWNUwxTnFHM1lHSUMrdnJmMjZCTFJuOExN?=
 =?utf-8?B?WGxpSVlsd0pQM2F0YkJhLy9YTnJsa1pkcjZ1dmFJN3lNVU5DWVBuWC9iRlZM?=
 =?utf-8?B?Um1UWmlDbzVjYlVuMHcyYjNYblFjRTlKcDVtTUNFMEtlalNIWjQ4MGhOcTQ3?=
 =?utf-8?B?OTFqazByZGRKaVdFeFVDcTIwMlRWUEhOeThjQXpGOGFhTmdsMzhoVTVRYndt?=
 =?utf-8?B?aVY1QjJ3YXgrMTZwZ3hTbTJKUjAzenB2bElhS2ViVXRwMXJsdGRmRGNkRzFh?=
 =?utf-8?B?NWdUQUlBWjBpUGZocTN6TzhmSHhXQ2tYbVpmdG42ZWN3VmJtY0duM1JreXNr?=
 =?utf-8?B?dzNzS0JBckliTDd0Y3E4aGFnbXAwaFYxM3YwTHdOY0JrUkZYWDJRenU2TFd6?=
 =?utf-8?B?NHU0bUUxUHIwb1gvY1R5MWdoQlNxRkRsYTVMRy9wbVRPUzJKZktsWXpTMTRk?=
 =?utf-8?B?enM5ZzlqNnlIcE4wMGw2U011cXFIR1AxVVBtV0VXWGN3cFNnVW16ZnQzbDVI?=
 =?utf-8?B?elQwVEdZQjJNNEluSDZOblIvNWxyQ2FuMkw3akVNcVNKdFVTKzYxUkdJZUhK?=
 =?utf-8?B?eHV3Uy9LTGN2UVZEMEFnb0NnUFcyR2ErTDBSYVFlc2owRHZZWnFoR0djN1py?=
 =?utf-8?B?UVVXaGppRWQwN2diZTN0OTNtNWYvOXMrcDRxUTMwQ1JsSTBTa3pIcGJ0cFNo?=
 =?utf-8?B?MVVmdDZOczV4SlZPem5ERTNMN3VCYStaYm5uTFV0RjVoZXNDTGU4UU9BSVhs?=
 =?utf-8?B?cXNhcTQvMnE5QUpyMDV4VGNhWFl2Tk1hQlIyMzZJWmlORStjRStIM0pudVpk?=
 =?utf-8?B?NXhMc2FhUHpVbFpyeWJYT1orMlNENGxNbHZKZXpBanVHdjNxUVFaZ2tlUGNL?=
 =?utf-8?B?RVNhVitoemZNNzFFTGM2NFNaTHp1WUMyaHZoMUpkZkVicExPcDJ5VDNSQ2hB?=
 =?utf-8?B?VStyRElqRENxVE5lL20vUEZDV0tXdlNpc1YyU0pGMTFLUHNjY1Z4cFhiSzE1?=
 =?utf-8?B?Mkx3MXN1aU0xODZJUmNYdmdvbURQTmtnUFRDTEVHTUtHclpGQXRVQldmaHhZ?=
 =?utf-8?B?dVpXZjRLUnBSSm1ZTXZwNDFDSklLcWdIYUUrS3N0RjRoSzI5THF2cVZZazlz?=
 =?utf-8?B?eThQelBFVUNtd3U4UUx2cnJFVDV1WGNXRTJPaXo3REcySVJPZTJJT2ZqMFBq?=
 =?utf-8?B?a2tXd3NCRjlQL0FiNEJpano4STNGUXhleVlGbGQ2NlpjUFpCUk5XYVhSeTZU?=
 =?utf-8?B?OUQ2aUxOWFRxS01GN1FBazd0QXRKZmZSWDdiTGNORFlwZmg2M0NQdHNId2hX?=
 =?utf-8?B?VmRLSXA4RXhpbmZieGpaQVhxSS9XcWpOYUJtdnkyZVN3d0p3RXNSeUNaOGp6?=
 =?utf-8?B?VkhRSS8rVmR6WU5UejVjb1FaOVRiUU9Bd1BEcDNVYkUwdzVkWkIyRXlvRHls?=
 =?utf-8?B?cC9Jb0EwVHErTm9obXF0c0JSam9FaFArcVJwSEdmeFdtU2ttNXcwRzBFK2V4?=
 =?utf-8?B?cVZYbVZTd1h5Znc0RXhkRFdXMmN2ZGVtZHFQSGdIclhrSUZqNVdFajRTdnpF?=
 =?utf-8?B?R1ZUVHNMWXVlSlZZaVQ0QW1lUVhPNFZ6aDE3UHFkMlRzZERnNVJ6amwyQUpt?=
 =?utf-8?B?NjFMckovaDNDZGRRSVV1a25NbXZUOGFoSWw4UUlXQUdnVGRhaXE0UWNkcE8y?=
 =?utf-8?B?SjdBNWplYU5wWGJMaldZQzlPRGhqOGcyLzdXRE04T1E4ZHR2YUR5anMvaWt6?=
 =?utf-8?B?SGZ5YnIvUzVQMnNoMzJrc1RTcXN2SjFiYnRkYXZHNGd6OEtGZ3RYbThRZkxD?=
 =?utf-8?B?SUtJNVRKcnlYdU9XaDhyMnZxM0JJOUM0ZEZ2MzB5elk5VnFmRkZCQ1BhS3po?=
 =?utf-8?B?NnZnQW9zTTNHL1BQVURKV2IxenlXSnpYV1hWN3ZEWHJiMDFIa0JaRVFEZXFS?=
 =?utf-8?Q?yauh5xYu5duoQ77eQ/bXo/cPm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19609906-2937-44d9-b120-08db0834787f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 11:22:45.7106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbcbbYkUcQh02IqTMo5qaxLROkZaNdILVXq9rgQnpy1XEJLWpaYG0cvtyeMzCscH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4858
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
> This patch renames aper_base and aper_size parameters (in adev->gmc),
> to vram_aper_base and vram_aper_size, to differentiate it from the
> doorbell BAR.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c     |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h     |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 12 ++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  8 ++++----
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c      | 10 +++++-----
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      | 10 +++++-----
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c       |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c       | 12 ++++++------
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c       | 10 +++++-----
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       | 10 +++++-----
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    |  4 ++--
>   14 files changed, 49 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index f99d4873bf22..58689b2a2d1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -438,7 +438,7 @@ void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
>   	mem_info->vram_width = adev->gmc.vram_width;
>   
>   	pr_debug("Address base: %pap public 0x%llx private 0x%llx\n",
> -			&adev->gmc.aper_base,
> +			&adev->gmc.vram_aper_base,
>   			mem_info->local_mem_size_public,
>   			mem_info->local_mem_size_private);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c
> index 0e0f212bd71c..3257da5c3a66 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c
> @@ -701,7 +701,7 @@ int amdgpu_bar_mgr_alloc_sgt(struct amdgpu_device *adev,
>   	 */
>   	amdgpu_res_first(res, offset, length, &cursor);
>   	for_each_sgtable_sg((*sgt), sg, i) {
> -		phys_addr_t phys = cursor.start + adev->gmc.aper_base;
> +		phys_addr_t phys = cursor.start + adev->gmc.vram_aper_base;
>   		size_t size = cursor.size;
>   		dma_addr_t addr;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 0b6a394e109b..45588b7919fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3961,7 +3961,7 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
>   	/* Memory manager related */
>   	if (!adev->gmc.xgmi.connected_to_cpu) {
>   		arch_phys_wc_del(adev->gmc.vram_mtrr);
> -		arch_io_free_memtype_wc(adev->gmc.aper_base, adev->gmc.aper_size);
> +		arch_io_free_memtype_wc(adev->gmc.vram_aper_base, adev->gmc.vram_aper_size);
>   	}
>   }
>   
> @@ -5562,14 +5562,14 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
>   	uint64_t address_mask = peer_adev->dev->dma_mask ?
>   		~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
>   	resource_size_t aper_limit =
> -		adev->gmc.aper_base + adev->gmc.aper_size - 1;
> +		adev->gmc.vram_aper_base + adev->gmc.vram_aper_size - 1;
>   	bool p2p_access =
>   		!adev->gmc.xgmi.connected_to_cpu &&
>   		!(pci_p2pdma_distance(adev->pdev, peer_adev->dev, false) < 0);
>   
>   	return pcie_p2p && p2p_access && (adev->gmc.visible_vram_size &&
>   		adev->gmc.real_vram_size == adev->gmc.visible_vram_size &&
> -		!(adev->gmc.aper_base & address_mask ||
> +		!(adev->gmc.vram_aper_base & address_mask ||
>   		  aper_limit & address_mask));
>   #else
>   	return false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 02a4c93673ce..c7e64e234de6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -775,7 +775,7 @@ uint64_t amdgpu_gmc_vram_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo)
>    */
>   uint64_t amdgpu_gmc_vram_cpu_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo)
>   {
> -	return amdgpu_bo_gpu_offset(bo) - adev->gmc.vram_start + adev->gmc.aper_base;
> +	return amdgpu_bo_gpu_offset(bo) - adev->gmc.vram_start + adev->gmc.vram_aper_base;
>   }
>   
>   int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 0305b660cd17..bb7076ecbf01 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -167,8 +167,8 @@ struct amdgpu_gmc {
>   	 * gart/vram_start/end field as the later is from
>   	 * GPU's view and aper_base is from CPU's view.
>   	 */
> -	resource_size_t		aper_size;
> -	resource_size_t		aper_base;
> +	resource_size_t		vram_aper_size;
> +	resource_size_t		vram_aper_base;
>   	/* for some chips with <= 32MB we need to lie
>   	 * about vram size near mc fb location */
>   	u64			mc_vram_size;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index ca85d64a72c2..887fc53a7d16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1046,8 +1046,8 @@ int amdgpu_bo_init(struct amdgpu_device *adev)
>   	/* On A+A platform, VRAM can be mapped as WB */
>   	if (!adev->gmc.xgmi.connected_to_cpu) {
>   		/* reserve PAT memory space to WC for VRAM */
> -		int r = arch_io_reserve_memtype_wc(adev->gmc.aper_base,
> -				adev->gmc.aper_size);
> +		int r = arch_io_reserve_memtype_wc(adev->gmc.vram_aper_base,
> +				adev->gmc.vram_aper_size);
>   
>   		if (r) {
>   			DRM_ERROR("Unable to set WC memtype for the aperture base\n");
> @@ -1055,13 +1055,13 @@ int amdgpu_bo_init(struct amdgpu_device *adev)
>   		}
>   
>   		/* Add an MTRR for the VRAM */
> -		adev->gmc.vram_mtrr = arch_phys_wc_add(adev->gmc.aper_base,
> -				adev->gmc.aper_size);
> +		adev->gmc.vram_mtrr = arch_phys_wc_add(adev->gmc.vram_aper_base,
> +				adev->gmc.vram_aper_size);
>   	}
>   
>   	DRM_INFO("Detected VRAM RAM=%lluM, BAR=%lluM\n",
>   		 adev->gmc.mc_vram_size >> 20,
> -		 (unsigned long long)adev->gmc.aper_size >> 20);
> +		 (unsigned long long)adev->gmc.vram_aper_size >> 20);
>   	DRM_INFO("RAM width %dbits %s\n",
>   		 adev->gmc.vram_width, amdgpu_vram_names[adev->gmc.vram_type]);
>   	return amdgpu_ttm_init(adev);
> @@ -1083,7 +1083,7 @@ void amdgpu_bo_fini(struct amdgpu_device *adev)
>   
>   		if (!adev->gmc.xgmi.connected_to_cpu) {
>   			arch_phys_wc_del(adev->gmc.vram_mtrr);
> -			arch_io_free_memtype_wc(adev->gmc.aper_base, adev->gmc.aper_size);
> +			arch_io_free_memtype_wc(adev->gmc.vram_aper_base, adev->gmc.vram_aper_size);
>   		}
>   		drm_dev_exit(idx);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 196ba62ef721..bb2230d14ea6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -583,7 +583,7 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
>   			mem->bus.addr = (u8 *)adev->mman.vram_aper_base_kaddr +
>   					mem->bus.offset;
>   
> -		mem->bus.offset += adev->gmc.aper_base;
> +		mem->bus.offset += adev->gmc.vram_aper_base;
>   		mem->bus.is_iomem = true;
>   		break;
>   	default:
> @@ -600,7 +600,7 @@ static unsigned long amdgpu_ttm_io_mem_pfn(struct ttm_buffer_object *bo,
>   
>   	amdgpu_res_first(bo->resource, (u64)page_offset << PAGE_SHIFT, 0,
>   			 &cursor);
> -	return (adev->gmc.aper_base + cursor.start) >> PAGE_SHIFT;
> +	return (adev->gmc.vram_aper_base + cursor.start) >> PAGE_SHIFT;
>   }
>   
>   /**
> @@ -1752,12 +1752,12 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   #ifdef CONFIG_64BIT
>   #ifdef CONFIG_X86
>   	if (adev->gmc.xgmi.connected_to_cpu)
> -		adev->mman.vram_aper_base_kaddr = ioremap_cache(adev->gmc.aper_base,
> +		adev->mman.vram_aper_base_kaddr = ioremap_cache(adev->gmc.vram_aper_base,
>   				adev->gmc.visible_vram_size);
>   
>   	else
>   #endif
> -		adev->mman.vram_aper_base_kaddr = ioremap_wc(adev->gmc.aper_base,
> +		adev->mman.vram_aper_base_kaddr = ioremap_wc(adev->gmc.vram_aper_base,
>   				adev->gmc.visible_vram_size);
>   #endif
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 21e46817d82d..b2e4f4f06bdb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -825,18 +825,18 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
>   		if (r)
>   			return r;
>   	}
> -	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
> -	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
> +	adev->gmc.vram_aper_base = pci_resource_start(adev->pdev, 0);
> +	adev->gmc.vram_aper_size = pci_resource_len(adev->pdev, 0);
>   
>   #ifdef CONFIG_X86_64
>   	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
> -		adev->gmc.aper_base = adev->gfxhub.funcs->get_mc_fb_offset(adev);
> -		adev->gmc.aper_size = adev->gmc.real_vram_size;
> +		adev->gmc.vram_aper_base = adev->gfxhub.funcs->get_mc_fb_offset(adev);
> +		adev->gmc.vram_aper_size = adev->gmc.real_vram_size;
>   	}
>   #endif
>   
>   	/* In case the PCI BAR is larger than the actual amount of vram */
> -	adev->gmc.visible_vram_size = adev->gmc.aper_size;
> +	adev->gmc.visible_vram_size = adev->gmc.vram_aper_size;
>   	if (adev->gmc.visible_vram_size > adev->gmc.real_vram_size)
>   		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 4326078689cd..f993ce264c3f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -692,17 +692,17 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
>   		if (r)
>   			return r;
>   	}
> -	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
> -	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
> +	adev->gmc.vram_aper_base = pci_resource_start(adev->pdev, 0);
> +	adev->gmc.vram_aper_size = pci_resource_len(adev->pdev, 0);
>   
>   #ifdef CONFIG_X86_64
>   	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
> -		adev->gmc.aper_base = adev->mmhub.funcs->get_mc_fb_offset(adev);
> -		adev->gmc.aper_size = adev->gmc.real_vram_size;
> +		adev->gmc.vram_aper_base = adev->mmhub.funcs->get_mc_fb_offset(adev);
> +		adev->gmc.vram_aper_size = adev->gmc.real_vram_size;
>   	}
>   #endif
>   	/* In case the PCI BAR is larger than the actual amount of vram */
> -	adev->gmc.visible_vram_size = adev->gmc.aper_size;
> +	adev->gmc.visible_vram_size = adev->gmc.vram_aper_size;
>   	if (adev->gmc.visible_vram_size > adev->gmc.real_vram_size)
>   		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index ec291d28edff..cd159309e9e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -324,9 +324,9 @@ static int gmc_v6_0_mc_init(struct amdgpu_device *adev)
>   		if (r)
>   			return r;
>   	}
> -	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
> -	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
> -	adev->gmc.visible_vram_size = adev->gmc.aper_size;
> +	adev->gmc.vram_aper_base = pci_resource_start(adev->pdev, 0);
> +	adev->gmc.vram_aper_size = pci_resource_len(adev->pdev, 0);
> +	adev->gmc.visible_vram_size = adev->gmc.vram_aper_size;
>   
>   	/* set the gart size */
>   	if (amdgpu_gart_size == -1) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index 979da6f510e8..8ee9731a0c8c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -377,20 +377,20 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *adev)
>   		if (r)
>   			return r;
>   	}
> -	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
> -	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
> +	adev->gmc.vram_aper_base = pci_resource_start(adev->pdev, 0);
> +	adev->gmc.vram_aper_size = pci_resource_len(adev->pdev, 0);
>   
>   #ifdef CONFIG_X86_64
>   	if ((adev->flags & AMD_IS_APU) &&
> -	    adev->gmc.real_vram_size > adev->gmc.aper_size &&
> +	    adev->gmc.real_vram_size > adev->gmc.vram_aper_size &&
>   	    !amdgpu_passthrough(adev)) {
> -		adev->gmc.aper_base = ((u64)RREG32(mmMC_VM_FB_OFFSET)) << 22;
> -		adev->gmc.aper_size = adev->gmc.real_vram_size;
> +		adev->gmc.vram_aper_base = ((u64)RREG32(mmMC_VM_FB_OFFSET)) << 22;
> +		adev->gmc.vram_aper_size = adev->gmc.real_vram_size;
>   	}
>   #endif
>   
>   	/* In case the PCI BAR is larger than the actual amount of vram */
> -	adev->gmc.visible_vram_size = adev->gmc.aper_size;
> +	adev->gmc.visible_vram_size = adev->gmc.vram_aper_size;
>   	if (adev->gmc.visible_vram_size > adev->gmc.real_vram_size)
>   		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 382dde1ce74c..259d797358f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -577,18 +577,18 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
>   		if (r)
>   			return r;
>   	}
> -	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
> -	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
> +	adev->gmc.vram_aper_base = pci_resource_start(adev->pdev, 0);
> +	adev->gmc.vram_aper_size = pci_resource_len(adev->pdev, 0);
>   
>   #ifdef CONFIG_X86_64
>   	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
> -		adev->gmc.aper_base = ((u64)RREG32(mmMC_VM_FB_OFFSET)) << 22;
> -		adev->gmc.aper_size = adev->gmc.real_vram_size;
> +		adev->gmc.vram_aper_base = ((u64)RREG32(mmMC_VM_FB_OFFSET)) << 22;
> +		adev->gmc.vram_aper_size = adev->gmc.real_vram_size;
>   	}
>   #endif
>   
>   	/* In case the PCI BAR is larger than the actual amount of vram */
> -	adev->gmc.visible_vram_size = adev->gmc.aper_size;
> +	adev->gmc.visible_vram_size = adev->gmc.vram_aper_size;
>   	if (adev->gmc.visible_vram_size > adev->gmc.real_vram_size)
>   		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 08d6cf79fb15..a7074995d97e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1509,8 +1509,8 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
>   		if (r)
>   			return r;
>   	}
> -	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
> -	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
> +	adev->gmc.vram_aper_base = pci_resource_start(adev->pdev, 0);
> +	adev->gmc.vram_aper_size = pci_resource_len(adev->pdev, 0);
>   
>   #ifdef CONFIG_X86_64
>   	/*
> @@ -1528,16 +1528,16 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
>   	if (((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) ||
>   	    (adev->gmc.xgmi.supported &&
>   	     adev->gmc.xgmi.connected_to_cpu)) {
> -		adev->gmc.aper_base =
> +		adev->gmc.vram_aper_base =
>   			adev->gfxhub.funcs->get_mc_fb_offset(adev) +
>   			adev->gmc.xgmi.physical_node_id *
>   			adev->gmc.xgmi.node_segment_size;
> -		adev->gmc.aper_size = adev->gmc.real_vram_size;
> +		adev->gmc.vram_aper_size = adev->gmc.real_vram_size;
>   	}
>   
>   #endif
>   	/* In case the PCI BAR is larger than the actual amount of vram */
> -	adev->gmc.visible_vram_size = adev->gmc.aper_size;
> +	adev->gmc.visible_vram_size = adev->gmc.vram_aper_size;
>   	if (adev->gmc.visible_vram_size > adev->gmc.real_vram_size)
>   		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 10048ce16aea..c86c6705b470 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -1002,8 +1002,8 @@ int svm_migrate_init(struct amdgpu_device *adev)
>   	 */
>   	size = ALIGN(adev->gmc.real_vram_size, 2ULL << 20);
>   	if (adev->gmc.xgmi.connected_to_cpu) {
> -		pgmap->range.start = adev->gmc.aper_base;
> -		pgmap->range.end = adev->gmc.aper_base + adev->gmc.aper_size - 1;
> +		pgmap->range.start = adev->gmc.vram_aper_base;
> +		pgmap->range.end = adev->gmc.vram_aper_base + adev->gmc.vram_aper_size - 1;
>   		pgmap->type = MEMORY_DEVICE_COHERENT;
>   	} else {
>   		res = devm_request_free_mem_region(adev->dev, &iomem_resource, size);

