Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22C5C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 05:10:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AF8610FE8C;
	Fri,  6 May 2022 05:10:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB09910FE8C
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 05:10:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfRnF8B/Nk5g15+XtbKLgp4yNxXFQp4ss8dsgzm+PxsAysklKUCT6ODwQDYj8KjjEhANFHFg8mtdrUhbfpGfWJa7ixMylmUhq8ueroxSDJhoPeg0Xs06QjE4uwZVC3vnY53yzpFREvK8h5pQi1ZJFTfFiug9TdZ/O9w6mAypTTtjZafXdVZe1TKl9h+ctOofXau9hAlqPhZW7w0yy5X3RsLCDl3MOO+9DEu7gFErn1u8wZ2WAHFHWelhfSfl5Ge8442Y+qO5d0Tcj4yrZ8qPq5mmS1aNqbqTiwmAx5fcTI6nJkS3eVQ0XroZPg6b3ayh1iKprIDa34g82lerhs4D/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQXFEYThUlWlyvAlJ25KsEmOgKFfk29fu9qWfSypWVo=;
 b=A1NHbKrmjuG6fwUUr7mYS+MA72B8BSVAYHLRNLmPEN7d++InCUxOmsWyUfqeRXkvI6k0OaQYJq3QQ1PodBvuz04B18IOHp9X0KIxKZ3BZo4x4vLZZTtKaG9tEe0zaln9ZNiEhdyzqO1/qlUCyZRYPjMB9HtIvWXyPo3jhrSRMPPK+Ae1+f8nXk5Vi9RZ7mCL1O8W10P6WhGdJp/OjsPxRJI56ooeBo/9XOfSw1ULB7z+O+9OgOUomvAcEbQNL3HTYQUTFB6l2nTOZlNPu0GCBg6uJxllFY3+ht3rZl2c8RiCi0mHSIF1q/SixggLrJ3eyAYoVJGye+OhE4F+g6Os5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQXFEYThUlWlyvAlJ25KsEmOgKFfk29fu9qWfSypWVo=;
 b=fAg1Fd7ZTaWyxP9mOjha8NCgYFviGPnoq+fygWV3E92ahiwPv41ZkiT3C/GN7ctaSHA94pngt9qd+dJpvqzOvUBfuMMixiZdROgsmYNUR1AFVTKpq2Xp4VpkXMCNcIIYIc8DohfNV2rL6atQcKSGsz6nui2LiUnw8bB3NKBmkJc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MN0PR12MB5882.namprd12.prod.outlook.com (2603:10b6:208:37a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 6 May
 2022 05:10:14 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::588c:699c:71b:b6f2]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::588c:699c:71b:b6f2%6]) with mapi id 15.20.5206.025; Fri, 6 May 2022
 05:10:14 +0000
Message-ID: <df37562a-86d0-16e6-96f0-b9b43ba08ca2@amd.com>
Date: Fri, 6 May 2022 01:10:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 7/8] drm/amdgpu: support memory power gating for lsdma
Content-Language: en-CA
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220505200406.1293467-1-alexander.deucher@amd.com>
 <20220505200406.1293467-7-alexander.deucher@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20220505200406.1293467-7-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::18) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59e74aa6-6e19-4228-64b3-08da2f1eb42f
X-MS-TrafficTypeDiagnostic: MN0PR12MB5882:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB58829CDC612824430A39C4E899C59@MN0PR12MB5882.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4mhfySlOXEwSOKlyML1Fr6k7/ZqTpSoK6H5vR20Lf4F6h6zMjd2/htS1csKoSNM4kSeuZCeilSzRAl0LZ/HhdP+DOAOoMgCbKzg25OOgivnmOYe16+ZLEQYAx3Ji6UAaBXEmbCM+y6eq6qUIwPoiIXBz0V9XxilFFNHrQGtRNz8AWFV/1jEcH+kL47QhZCk7Slv7JFEx1GtwVN3SCwV8Jou9/5HFuJ8PJNo39HN5Z8/y+8LK7kKk4FmHYEwnQmAkOcT1XUO7f6D8d21Iu9CUqQh1Er4YZ//N0BHcqbBK6iOtJaSNZwKcFfHDvXua7Y66Ozaz9fGMSxSmcXHOK+AajA0kYmygKWMDb0zjr+B7BEo24uc3/76UFnnUY+lAbXjj4hiGPNdb1hgKm4kIq+FRSngOBtsKFOrqAH0IjvxeZzasMvBKjxve2fYbrhEiZ0qaOWWMsfoiXNKvtmNzM8pfJFn2mBo5C63sxrrwF+WUsMyAgAp3/8P8i7Leto+ZeMCYZvKDmgjlnPdwPeUT1BYm5Jzp4EvTKZU8GcWK9z0c3LUS7LJQpIv9JWl0HH0Zt8wPMXlBDxFqwyeGm0gLONRAlSll6wGUhQDgwFtul9grbPiKFTDpj49IuFARUTvwLrYfRKd4DLGZSJ7qW7+ttiVqzoZ1oT4nwr3wQxmBlKZLXMRb64ulMJENIZM0y7Cb6lYWAVd0fp+qju9uHQD4TWJZcmw3Q+MbxPTWtlpEx62QzFk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(316002)(8936002)(186003)(2616005)(6486002)(83380400001)(38100700002)(5660300002)(31696002)(6506007)(6512007)(53546011)(26005)(31686004)(54906003)(44832011)(6666004)(36756003)(2906002)(66556008)(4326008)(66946007)(66476007)(86362001)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWdqUTVxY2dEYzlZVEdWQjJKelZmZExWVDBMeGYzYm95elRlYVpRRkE5MENp?=
 =?utf-8?B?Y2c4aHdldlFNMmFXTEloekdlNXJmOW40Y1ZiSGZ0VXhrT2JadkZvdDVMbjZq?=
 =?utf-8?B?SFIybkJXMVhyUnZybkVmMldRNkFXRjVSTVZkNGh6T0VUSnB3WTNsRVQ3ZUN0?=
 =?utf-8?B?ZGxSWCtGbnZxKzMzdGJ5UDZscHRQZEJQSWxNZjFMdmx3MzRGYklpYndVOURJ?=
 =?utf-8?B?c2ZNcmZaUitpeHNwWkJ2aFNUaEhqNG9RY3lGWnI3cWpKYldXNTNKYUExQ05X?=
 =?utf-8?B?TldkVUhGYjdmb0lPZnFOMktZOEdQVlF6ZDNTbXlTVnNrT1VWeTZoL3BZRFR1?=
 =?utf-8?B?NjBPS0xEMHJpTlp3ZWtraUNrbkF1K3FTUVNURVd3QVJaRTQvd0N4UE9GSmlk?=
 =?utf-8?B?Q2Y4WGlqMDhGWk9VVjJzTEgrRk03SXpOTjVaMmF5aVUrWUlMRjlacDZsOVJI?=
 =?utf-8?B?NHB6N01Ib0tsYXFaaTNRZVJKRFdYd3RRbmE1ZU1PREkvTG5wcVNxTGF4blJm?=
 =?utf-8?B?N1RrYXRxLzgrRmViYSt0SnZqNWVJQlJybnJsWndXSmV4NWFSWGczN3FiVXp4?=
 =?utf-8?B?eDBQbm5kRkJwMlRvQmdUVUFUU1pKRDhUeUpRTFZlSHpqQTJmU1dDVjM3THV4?=
 =?utf-8?B?eU1QYnljR21DOVdkbVNOeDFTUnI0ZXRGWFVyL1AySWkzNlErM1FXNTZHT0Er?=
 =?utf-8?B?RFRUcjNYNmFBWDl2cytoM3l2K1k3Z3FlWXpNOStjQU0vUmpTSXo1bjlubDF5?=
 =?utf-8?B?cG4xY2cyTFNJWTlSQ1B3YTlZaisvRmx2WUlNV3VlMENXTEtBVVNUbTJlS3dR?=
 =?utf-8?B?UWhsdkZiU0w4T3FGWmdrZVdZZWRLZHRPdkU4SnZWMm9xNVRRM1orclFhbGJR?=
 =?utf-8?B?Y1B3dm83Zk1oeWFvU1ZrZndjWTFBRTZxbnBMMEQ5WXZZSnY0djZCUGpjTCtx?=
 =?utf-8?B?ZDRhWDJ4ZHVzOENXQnBrTmw3VGhjYWVwTlF1RmIzdnR1dVJkWjJCbDhLVFdH?=
 =?utf-8?B?OGtxL0RzUWhPeEtVVlpmSnBFVVV4dlVaeFJZbmRYaWh3Y3BKaHhqUTJVck5G?=
 =?utf-8?B?bUZlUWNJVkk0ZEw0aE9BQnJQbGp1MGZ2MlZiVkpSb3d2NnNGZ0tDRlV5Ni84?=
 =?utf-8?B?YzN1eElvS29HQVpEZUU3NzZ0RnF4Y1VVdE1IK3FPTjVyL2tuMFlrRWdZTTdm?=
 =?utf-8?B?ZWg4aTg0aTNTeHI0aUNmN2hrU0hhRGN5ZHFXb0pvQ2l2M0gzV1Z4VSswNFZE?=
 =?utf-8?B?S2lXWUZOM2xtWllwd3hKVGFXd29uanUzeG1YZFN3ekRkcnpMcFMvSlcxenpz?=
 =?utf-8?B?R3dMTVFPZTd3UGtYejR4V0g5dmhmSUxsaGdDaXY4aGFzck1IZm8wcUpZQ0Z1?=
 =?utf-8?B?TTFaY2pna3MyZ0xrenpxWHdnOFgvT3RFdGMydEIydWlvTnNBN0RhOFJXOURB?=
 =?utf-8?B?UVZjYndYa3FzYlVSWWIwRDVRTlpta1hqYmQ0cDk2MDUzYjUzU1hiakxGRGxm?=
 =?utf-8?B?eVUwZk9SblR0ODZ6NUM1Sm5TYXQ4RFZtajNiSWR4c0xVMXVFeHNCTC9HS3di?=
 =?utf-8?B?d2NzN1Z3UTFBRjllZkhBSFl6S2Zrdkk0NnlaY3ZOdjhid3AxdVkvL3VvK3RS?=
 =?utf-8?B?QUl6T0NBWk1iRTB2K09NZFIrOGNoRHpkU3FoSUZUSzhidytnSWdDTWs1UmpI?=
 =?utf-8?B?Mnh5RTRlNFc5SHBZMW9HUDFNSTNQNVN4d080NUJITm1raGx2RVFOWkJDVlBT?=
 =?utf-8?B?RVRwcjRmcVN0NytnYXpkeHZmSFlKTmFuY2F6bmttWm5nd2NCTEZnSGZlSEgx?=
 =?utf-8?B?dnNBVWVxVGtnNm02YWpMUElKcGFNS0pRcjkzQ1Z0UEFjakMwUTdKYUZUSFFp?=
 =?utf-8?B?bjBZZUtNZGczcVZ2T0ZmMk91cVpnUW5xS0tNMks1OTJWekpPaG1tT0pDQ05k?=
 =?utf-8?B?Yy9sK2lNMWsrMDVoeDl4UFZyNzE5TVlaaDQyZTFWNWc0aU5MaVpHYlpiRDdm?=
 =?utf-8?B?VGhjbGYxdkhYT2J2WEJhSEhSdkFmWEk5RzBmazBMMWFHemhLRWlXTU10ZVJX?=
 =?utf-8?B?OUhuMVcycndNakNoZFFrbkJZWUdyNmRoM2dOQnVJem0zTG9GaGtyNjJjN0xC?=
 =?utf-8?B?cVBSTC9UT0dteTZDOXo1SFU2UDcveWkra01GZXhRcGNZNFZVajFOVkhucGZU?=
 =?utf-8?B?TEZTMmZxd0Q0OU80aGxKZ2ZzcmpBakp2RldRODE3SDRxQ2JtdTZ2cG50Witj?=
 =?utf-8?B?UDU3VmFFZkY0dFRDZGl5TUhhM2U4MEx1RXE5RC9KY3lQMW9Vcm5SU1hmbUJY?=
 =?utf-8?B?K29JMHRvNkFXY2ZVL2FxcTlHWTFEbGZoWnpnc3lKbENzd2VCa0JLUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e74aa6-6e19-4228-64b3-08da2f1eb42f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 05:10:14.6125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQlpYtbcZB8N+FEvB/sLhqpyniay4ESO1zhz8MhOXR+cRvBA74o4NBFLgJ6+6KqS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5882
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
Cc: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-05-05 16:04, Alex Deucher wrote:
> From: Likun Gao <Likun.Gao@amd.com>
> 
> Support memory power gating control for LSDMA.
> 
> Signed-off-by: Likun Gao <Likun.Gao@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c   | 16 +++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/soc21.c        | 12 +++++++++++-
>  3 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
> index 9a29f18407b8..7ec7598e7dec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
> @@ -34,6 +34,7 @@ struct amdgpu_lsdma_funcs
>                      uint64_t dst_addr, uint64_t size);
>  	int (*fill_mem)(struct amdgpu_device *adev, uint64_t dst_addr,
>                      uint32_t data, uint64_t size);
> +	void (*update_memory_power_gating)(struct amdgpu_device *adev, bool enable);
>  };
>  
>  int amdgpu_lsdma_copy_mem(struct amdgpu_device *adev, uint64_t src_addr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
> index b4adb94a080b..1a285b531881 100644
> --- a/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
> @@ -101,7 +101,21 @@ static int lsdma_v6_0_fill_mem(struct amdgpu_device *adev,
>  	return ret;
>  }
>  
> +static void lsdma_v6_0_update_memory_power_gating(struct amdgpu_device *adev,
> +						 bool enable)
> +{
> +	uint32_t tmp;
> +
> +	tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_MEM_POWER_CTRL);
> +	tmp = REG_SET_FIELD(tmp, LSDMA_MEM_POWER_CTRL, MEM_POWER_CTRL_EN, 0);
> +	WREG32_SOC15(LSDMA, 0, regLSDMA_MEM_POWER_CTRL, tmp);
> +
> +	tmp = REG_SET_FIELD(tmp, LSDMA_MEM_POWER_CTRL, MEM_POWER_CTRL_EN, enable);
> +	WREG32_SOC15(LSDMA, 0, regLSDMA_MEM_POWER_CTRL, tmp);
> +}
> +

Do we need to disable it first before updating?

What if we're updating it to the same value it currently is (on the first read)?
Shouldn't we just skip the subsequent writes?

>  const struct amdgpu_lsdma_funcs lsdma_v6_0_funcs = {
>  	.copy_mem = lsdma_v6_0_copy_mem,
> -	.fill_mem = lsdma_v6_0_fill_mem
> +	.fill_mem = lsdma_v6_0_fill_mem,
> +	.update_memory_power_gating = lsdma_v6_0_update_memory_power_gating
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 741ed3ba84d6..3303e02f85d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -676,7 +676,17 @@ static int soc21_common_set_clockgating_state(void *handle,
>  static int soc21_common_set_powergating_state(void *handle,
>  					   enum amd_powergating_state state)
>  {
> -	/* TODO */
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +
> +	switch (adev->ip_versions[LSDMA_HWIP][0]) {
> +	case IP_VERSION(6, 0, 0):
> +		adev->lsdma.funcs->update_memory_power_gating(adev,
> +				state == AMD_PG_STATE_GATE);
> +		break;
> +	default:
> +		break;
> +	}
> +
>  	return 0;
>  }
>  

Regards,
-- 
Luben
