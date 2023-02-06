Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BDAC61DA4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 11:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DE5710E388;
	Mon,  6 Feb 2023 11:30:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD90E10E38F
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 11:30:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpUFEWaJoUyY+CUlyHjgYvtDbcA0AN2X2wr1brz+KfRyNlk/RlnXGKo5smiIOhLznhSCumTEWGDOzoOMn6MwcIndmr9CCO29d0vQN6NjB3R0eg/IGvJ5K8wg0ZTTvm6Rfqa1D5jXdEJLG5pal3pR9muoE/vOZWl3BEpjrxEhNF8OEqBE878hnJmvpj/Woi9jMgw2jZML/KJHQHY3pRGcnH1bYV6+JvrjMnHNqsig0Ff82/Rgfr4El10iJNsFHLN+4pOCsfBBqGecrFObwAiX0I5W1GwXNmnsGTk5soosFurd9GxWv2j7f0iJIqnEMgCyPmx6JlatMUk/1WBj7Eso9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mex3sVN5C+rH4bXFHybT2gTwzl6Hay6oef9h4A0P3dI=;
 b=fj1YhZ0lbwuDvYyyn3RvqTNIGB+uAWUbAMEdozu7rMKcspIsK+796PChke2zBMjVgTgyk5omlKMHgA4yGpfl+mmtd3n2rZg90hdKcymtaT8yg1/kl7NXniyUZhV76ioyvx5NMj9lKPPnOBhjO4cylJ3IIzrJY26hFgwzNWnBZ3Re41Mdcv5QL6Nq6m09ydJMSAbCX744BhXE7Ijq7JBboyUVZhKFVJbazkasjzvQraHoBeP1HVDM1w5Xv8eM9tm0AlzeMu37XDBspJlxZOeeuiJK37h1qhaJTZjSe3zwGXNeiSnBkdwR8aMyYNhtksRN9wgTffaV3YQjJklIEbqbIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mex3sVN5C+rH4bXFHybT2gTwzl6Hay6oef9h4A0P3dI=;
 b=WdlhCblUTIuz3upegN2SoWyJt5y4Qy1ou42prH46xdhCPZblInWB4xY4J//N5632gRCw5Rs2amlzF++KojZO33Pj6VB5DMRdFso4ZbKLFg8vkwaqNLws/poGuNgw3V9DHH0gc1yyCwbM+KZoCdisEsynNePJokFoSViftJ9xTUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 11:30:50 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 11:30:50 +0000
Message-ID: <ba704ad1-b4e4-e376-ee93-dc9b9e4e97a2@amd.com>
Date: Mon, 6 Feb 2023 12:30:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 09/13] drm/amdgpu: accommodate DOMAIN/PL_DOORBELL
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230203190836.1987-1-shashank.sharma@amd.com>
 <20230203190836.1987-10-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230203190836.1987-10-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::6) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MN0PR12MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: 31af426c-7279-41fb-4c44-08db0835994f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sIZdPKtfX8g4eKuJEyDukMF+aA5Q9Sgi7wmOIdZ1EbjpSeMb48VI5O7IHJQ4cnBMTClczio5iOemE6yG0K1Yv+djaLK9/LdljZ+6zJYwZIjWaCsOwE//NejA6znSATJq6f2Fm/F3LmBZKmuLpNmW4BBwsVmeaGuyrVYKb7ypdORnKKP/KUb1tvytK5Vk2EzMCc4MQPv3y8PT9fBz0yDCcTL0Y/J3fNt25e+QVPHh/4dcGbaEd23sBp5pu6glckgNcQ8ZbBKy4p3USuf3/B9PHkMibEPirGzVtyrZZN7xr2YWfTspae7Jv0u+AKBmPCfI0cXL3HtE5aHTTgyKzIR36HCnIm7G+/aWoOB7q4WH/ZGbiuAw8hSQIeMjwAeaqYbl+f51oIsHzsYJWVxDdlIlInfW0dMBvIX5aOLIuYYYatusWsE86AWU0i7dqWPVTXKBkclhFvz16tArxhDYD34HZYxi3WoTXUwhiZKLfzwY7ESpYKnjWaTswMzsGqfOFjsoNV1n1Am8TwygQ1HQoWL54f8xMFYZSR/deGYArfmH0QC0HARKGfWi8B5fKfWNvgcZnZvZr9Vm68qOfVX1XCW9+0bwt2BhC8Q0lYB6hfihjMLrvrjpLbvafKi8R8S1jYXbAiLuvlYYPrceXHp0rBYK90tXAaCyrOhi1kveC+6D5ixuBUhefuFI5uXybFit0eHuUBIbMI0+9wZvFru6IdZ66WUV7qDfF3/YFkHI4SQXvgU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199018)(5660300002)(8936002)(41300700001)(83380400001)(31686004)(2906002)(66556008)(316002)(66476007)(66946007)(26005)(8676002)(6512007)(186003)(4326008)(31696002)(36756003)(38100700002)(86362001)(478600001)(6486002)(2616005)(6506007)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0xMenZpanBYSkN3UEoxOHNUYlhZN21kdnhiLzVHa0tjOUo1T0lpeEVXTzJU?=
 =?utf-8?B?dXZBYVI1MFVPUkJyQ3J0YzV2TlY3QncvU0dNcTFSMmZlTkw0TW5POXFhdXAx?=
 =?utf-8?B?VFloblU1WUkvUkUzdU5WaTRMRVFrT3RXdm4wRFFBSHB5bzNIaEFyWnNESDhT?=
 =?utf-8?B?a0g2UC9iaGVlc1o1bWlzKzk1L29ZSVUxVG1KMUo4VW9wcWdBS245S2ZEM2dH?=
 =?utf-8?B?OVZ4c0tnSEdaRmQ2aTVpTzZac2FWRlFGSmxMamRLUTRsTmlwemZpYWZmVFVn?=
 =?utf-8?B?WmZFTEYzb3lSMllIOWdIT1plK1pVaVQ2KzdVVkk2Yy82Vi9SWjFydnZwK1hG?=
 =?utf-8?B?QzNsNFNwVjhXZWplVktKTUJ5bTczK3J1K0I3UExOVGExWjQ0bDdGMG5WQXUx?=
 =?utf-8?B?NzNHbFhLcVE4S08xN01Nd1lVSUFBT0FnM3ZsNXYrY3NiZExTREhaOVJvREk3?=
 =?utf-8?B?ZFB3WmlUT2lRU0JNN0cxMHlZMHJYSmUvdmVKRk5qRUJpalpoUVRFT1J0ZFpS?=
 =?utf-8?B?MTJyRCtWWjF1dE9VME9PTnRaaEVLOWRVNHFZT3lkbUdDdVdza0hJQUg2NlNR?=
 =?utf-8?B?YlgrVVNML0tObW82TE12RUtvd0ExOHY5eDVBZDRnNE1KTjFXMWpzbUtBU2gz?=
 =?utf-8?B?anIwWjQxMUF2cFRWTTJOMEpJbnUweFZndW1vR1R4VzlOaVN5R2JaV0hqNjBj?=
 =?utf-8?B?QWFOOUFWN0F2L2I4SXFVeEtzSXl3eEJueGttV1pYOWl1ODRzdXA5aVhKdXBs?=
 =?utf-8?B?QTZKM3czeGptS3VtdEt4aG5kZXA4QjZXTllGcTdOeVNWRjQ5K0x1L013K0l2?=
 =?utf-8?B?dlRVQVE1QnFhVG1FL040ZVV5TmZYQkh2c3NFbHJJTlFiYStMUkJiMmxCbFU1?=
 =?utf-8?B?WDJBUFYzVnBYRGh1ekVHSzRrR3Q2ZG4wcFB1ZDArS3BXUG1TdzBzNmFubUo4?=
 =?utf-8?B?SG5ENENwMzNUaDZCL2I2MndnejVOaVJ4L1NCbzB3MmM5UlVuN0xoSDF1R21T?=
 =?utf-8?B?VmI5MllaeHl5aURuREZxUE9YY1FmeTRyV3ZXZlpIVVN2RW9CYzc3U3loZnln?=
 =?utf-8?B?TFArcWdlRWNpQXhCY3RCOTRZMkxzQ2JFQWVSdUFrc2JybXRWVkVNQmtEQnpY?=
 =?utf-8?B?RlJBVVo3NTQvT3o0M3pER3NzdXNOelpnUHNZOWNMUlBIT0U3Y0ZMOU5OOGxE?=
 =?utf-8?B?TndSS0dvRDUrcEFaTTdweHpiRVJTVGpyVVIwWUJNMms1T2ZHN3VrMHpqUmlI?=
 =?utf-8?B?WDR5SVJIbk5uWk8xNzBGdDFsNWllZ3Y1emdxaE1qY0tmTnNiY0JXT1AyVWNZ?=
 =?utf-8?B?bytUTEkxRVBKM1RaaXJJRmQ0Qk9udWlFOVFBVGNsSkI2djdnemJTT2NxVDZC?=
 =?utf-8?B?aVovWVAyVkZaNWFTSXUvejdlWGUrL0ZFd0lpSlAyYkQzS2tqRHI5dkxVeEJa?=
 =?utf-8?B?bC9ISTd0YkZyc2UrNnA2a1pNV2x2RGdpa3JFWVBnUGVmdk50SHRSV052U3NL?=
 =?utf-8?B?ZE9IaDFvaFBEUzVQREExRWs5c1JzTmZSL2RkMmJuSWd1Tk9mRElnbWg4UGlG?=
 =?utf-8?B?YzFvOFJZbWIxbVlXeHNseHl6UGlUNW84eXJ4SFl5cUtsTFphdWdHOGRFeDdH?=
 =?utf-8?B?clkrSFR5UGd4bG9ob2lRdE80bFJXVzNRelJoYlJMMXJYOWZSdG5DZXY1VkY5?=
 =?utf-8?B?VlYzWVVzaUNMNkExZ2lnandKVndRTzk3dk0ybnY2bXBBTTZuNlZNZHRKbVVx?=
 =?utf-8?B?ZVJpbUZ3SkROS1pwWDk3Z01iSUE4MmJpaVkwSUFtWUZXUkJkSUFBeU05ZTVW?=
 =?utf-8?B?RzQwVFR0MnVReGwxaWhmNXZFOCtVODVjVjFocTdxQWZBUHd6M1hXRWZNM3BZ?=
 =?utf-8?B?NHNuQXBiNnhYQ3JKbzBNY0hGZjJicVhwQzkySVhETm5vQlptT0trQmczR21B?=
 =?utf-8?B?R3hmS0dqaEMxUERpTGJvbVhEcTNqUFJrQUxWNjZWSm8wQlVmdnpjemNDWGVL?=
 =?utf-8?B?MTY3L3lNa3dmbmkra3lvLzFhMVpGOGZJaTdvK3FZMmVyMDNrdncwT1ZmTUs0?=
 =?utf-8?B?dXBxaU8wNGVPRFhMTVNGeiswVVdRZXdwYnh6TmZkOFhoT1VEZUVZT0ZwSEdH?=
 =?utf-8?Q?Y+OotKZEUs5DGaAikgiOgVnsh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31af426c-7279-41fb-4c44-08db0835994f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 11:30:50.3488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkRBddNySfMnfeRggX+fnJxeeODp5xmzCBDl0HZcYLZNmbI/88ZWw++d9myiERke
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905
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
> This patch adds changes to accommodate the new GEM/TTM domain
> for doorbell memory.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c | 19 ++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 24 ++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 17 ++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  3 ++-
>   7 files changed, 58 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index e3e2e6e3b485..e1c1a360614e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -974,6 +974,7 @@ struct amdgpu_device {
>   	atomic64_t vram_pin_size;
>   	atomic64_t visible_pin_size;
>   	atomic64_t gart_pin_size;
> +	atomic64_t doorbell_pin_size;

Please drop that, the amount of pinned doorbells is not needed as far as 
I can see.

>   
>   	/* soc15 register offset based on ip, instance and  segment */
>   	uint32_t		*reg_offset[MAX_HWIP][HWIP_MAX_INSTANCE];
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c
> index 0656e5bb4f05..43a3137019b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c
> @@ -659,15 +659,17 @@ static void amdgpu_bar_mgr_del(struct ttm_resource_manager *man,
>    * @dev: the other device
>    * @dir: dma direction
>    * @sgt: resulting sg table
> + * @mem_type: memory type
>    *
>    * Allocate and fill a sg table from a VRAM allocation.
>    */
>   int amdgpu_bar_mgr_alloc_sgt(struct amdgpu_device *adev,
> -			      struct ttm_resource *res,
> -			      u64 offset, u64 length,
> -			      struct device *dev,
> -			      enum dma_data_direction dir,
> -			      struct sg_table **sgt)
> +			     struct ttm_resource *res,
> +			     u64 offset, u64 length,
> +			     struct device *dev,
> +			     enum dma_data_direction dir,
> +			     struct sg_table **sgt,
> +			     u32 mem_type)

And again that doesn't make any sense at all.

For now we don't want to export doorbells through DMA-buf.

>   {
>   	struct amdgpu_res_cursor cursor;
>   	struct scatterlist *sg;
> @@ -701,10 +703,15 @@ int amdgpu_bar_mgr_alloc_sgt(struct amdgpu_device *adev,
>   	 */
>   	amdgpu_res_first(res, offset, length, &cursor);
>   	for_each_sgtable_sg((*sgt), sg, i) {
> -		phys_addr_t phys = cursor.start + adev->gmc.vram_aper_base;
> +		phys_addr_t phys = cursor.start;
>   		size_t size = cursor.size;
>   		dma_addr_t addr;
>   
> +		if (mem_type == TTM_PL_VRAM)
> +			phys += adev->gmc.vram_aper_base;
> +		else
> +			phys += adev->gmc.doorbell_aper_base;
> +
>   		addr = dma_map_resource(dev, phys, size, dir,
>   					DMA_ATTR_SKIP_CPU_SYNC);
>   		r = dma_mapping_error(dev, addr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index c48ccde281c3..c645bdc49f34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -179,9 +179,10 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>   		break;
>   
>   	case TTM_PL_VRAM:
> +	case AMDGPU_PL_DOORBELL:
>   		r = amdgpu_bar_mgr_alloc_sgt(adev, bo->tbo.resource, 0,
>   					     bo->tbo.base.size, attach->dev,
> -					     dir, &sgt);
> +					     dir, &sgt, bo->tbo.resource->mem_type);
>   		if (r)
>   			return ERR_PTR(r);
>   		break;

That stuff can be dropped as well as far as I can see.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 887fc53a7d16..b2cfd46c459b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -147,6 +147,18 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
>   		c++;
>   	}
>   
> +	if (domain & AMDGPU_GEM_DOMAIN_DOORBELL) {
> +		places[c].fpfn = 0;
> +		places[c].lpfn = 0;
> +		places[c].mem_type = AMDGPU_PL_DOORBELL;
> +		places[c].flags = 0;
> +		places[c].flags |= TTM_PL_FLAG_TOPDOWN;
> +
> +		if (flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
> +			places[c].flags |= TTM_PL_FLAG_CONTIGUOUS;
> +		c++;
> +	}
> +
>   	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
>   		places[c].fpfn = 0;
>   		places[c].lpfn = 0;
> @@ -464,6 +476,13 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>   		if (man && size < man->size)
>   			return true;
>   		goto fail;
> +	} else if (domain & AMDGPU_GEM_DOMAIN_DOORBELL) {
> +		man = ttm_manager_type(&adev->mman.bdev, AMDGPU_PL_DOORBELL);
> +
> +		if (size < man->size)
> +			return true;
> +		else
> +			goto fail;

Do we ever want userspace to allocate more than one doorbell page at a time?

>   	}
>   
>   	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU */
> @@ -962,8 +981,9 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>   			     &adev->visible_pin_size);
>   	} else if (domain == AMDGPU_GEM_DOMAIN_GTT) {
>   		atomic64_add(amdgpu_bo_size(bo), &adev->gart_pin_size);
> +	} else if (domain == AMDGPU_GEM_DOMAIN_DOORBELL) {
> +		atomic64_add(amdgpu_bo_size(bo), &adev->doorbell_pin_size);

Can be dropped.

>   	}
> -
>   error:
>   	return r;
>   }
> @@ -1013,6 +1033,8 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
>   			     &adev->visible_pin_size);
>   	} else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
>   		atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
> +	} else if (bo->tbo.resource->mem_type == AMDGPU_PL_DOORBELL) {
> +		atomic64_sub(amdgpu_bo_size(bo), &adev->doorbell_pin_size);

Dito.

>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 93207badf83f..082f451d26f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -326,7 +326,7 @@ int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr);
>   u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
>   u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
>   void amdgpu_bo_get_memory(struct amdgpu_bo *bo, uint64_t *vram_mem,
> -				uint64_t *gtt_mem, uint64_t *cpu_mem);
> +			  uint64_t *gtt_mem, uint64_t *cpu_mem);
>   void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo_vm *vmbo);
>   int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow,
>   			     struct dma_fence **fence);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index bb2230d14ea6..71eff2f195a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -128,6 +128,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
>   	case AMDGPU_PL_GDS:
>   	case AMDGPU_PL_GWS:
>   	case AMDGPU_PL_OA:
> +	case AMDGPU_PL_DOORBELL:
>   		placement->num_placement = 0;
>   		placement->num_busy_placement = 0;
>   		return;
> @@ -500,9 +501,11 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>   	if (old_mem->mem_type == AMDGPU_PL_GDS ||
>   	    old_mem->mem_type == AMDGPU_PL_GWS ||
>   	    old_mem->mem_type == AMDGPU_PL_OA ||
> +	    old_mem->mem_type == AMDGPU_PL_DOORBELL ||
>   	    new_mem->mem_type == AMDGPU_PL_GDS ||
>   	    new_mem->mem_type == AMDGPU_PL_GWS ||
> -	    new_mem->mem_type == AMDGPU_PL_OA) {
> +	    new_mem->mem_type == AMDGPU_PL_OA ||
> +	    new_mem->mem_type == AMDGPU_PL_DOORBELL) {
>   		/* Nothing to save here */
>   		ttm_bo_move_null(bo, new_mem);
>   		goto out;
> @@ -586,6 +589,17 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
>   		mem->bus.offset += adev->gmc.vram_aper_base;
>   		mem->bus.is_iomem = true;
>   		break;
> +	case AMDGPU_PL_DOORBELL:
> +		mem->bus.offset = mem->start << PAGE_SHIFT;

That here won't work if we ever allow allocating more than one page for 
a doorbell.

> +
> +		if (adev->mman.doorbell_aper_base_kaddr &&
> +		    mem->placement & TTM_PL_FLAG_CONTIGUOUS)
> +			mem->bus.addr = (u8 *)adev->mman.doorbell_aper_base_kaddr +
> +					mem->bus.offset;

This doesn't make any sense at all. TTM_PL_FLAG_CONTIGUOUS should 
probably be completely ignored for doorbells.

Regards,
Christian.

> +
> +		mem->bus.offset += adev->gmc.doorbell_aper_base;
> +		mem->bus.is_iomem = true;
> +		break;
>   	default:
>   		return -EINVAL;
>   	}
> @@ -1267,6 +1281,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem)
>   		flags |= AMDGPU_PTE_VALID;
>   
>   	if (mem && (mem->mem_type == TTM_PL_TT ||
> +		    mem->mem_type == AMDGPU_PL_DOORBELL ||
>   		    mem->mem_type == AMDGPU_PL_PREEMPT)) {
>   		flags |= AMDGPU_PTE_SYSTEM;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 243deb1ffc54..9971665d7d99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -124,7 +124,8 @@ int amdgpu_bar_mgr_alloc_sgt(struct amdgpu_device *adev,
>   			     u64 offset, u64 size,
>   			     struct device *dev,
>   			     enum dma_data_direction dir,
> -			     struct sg_table **sgt);
> +			     struct sg_table **sgt,
> +			     u32 mem_type);
>   void amdgpu_bar_mgr_free_sgt(struct device *dev,
>   			     enum dma_data_direction dir,
>   			     struct sg_table *sgt);

