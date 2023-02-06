Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070F3C05027
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 11:21:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 896FC10E2B8;
	Mon,  6 Feb 2023 11:21:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7811010E2B8
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 11:21:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oz7TdYIpq6zPmQKn4O1JY/bFg57+OjiThRf9OJyMuRl8pGCgu2GEtZtmeOOZXQ2NeU/3+M5F1uVQusFxmk4JPp3WGgQps/xuM99V1X3bYT8o88uEA/C08+GNbOUblK+dz6bvruigoxDUBXCpP5p0Njm92IDBuAlG/Ir49cEsRrXf91HyQaKt55QnyMzsEXAYiKkXJP5jPQiAz4a6RcMTStiEcIunOWhpwLlepeSxilBKD3wQpwDLzTmmuqywAgXP595ekU64njr9lB6QeJIGH8NRHwUzf3kZCSr+PsL7v+uo9GIhpwQtkDSVWaOas4F9QeIfzdZAYBdLWBW4+Ap1xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zb2R8Bj7b3suXpb+0lqKAhj0lwJOAbyawoYw/4eDWjw=;
 b=RSK4GrfcwSTZGw65mJgVMPdryGVB6mlfJPoKbEJy413hxXlo6VtoRMmP3CLfTSXSZDU8+ykVzpywOMBZb4g6UKkOdVEYV1N+J32n/DBukLs3LJbJnD53bIYI20EpySDYZGUAnD1nbnSl0UPwx9VC8VYJm2VstmQ/ABZ5+iacw/mdlExBQz52Xp7CHMBK8kfIYH9A1XkhB+4r+Rp++0l1/bSl6zJvO7W4GVWGZpmwXEF17DjP7B9rRIF+B2V1lXA5fvGxBSpj2Z2jPFMNA9vk3IJJxwAC1+FvfJ6hlne6X9M2ooNOth4jorDNE7GdR453RaHuKDhfAJdsf3innhuA+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zb2R8Bj7b3suXpb+0lqKAhj0lwJOAbyawoYw/4eDWjw=;
 b=wcjqGS5znsUvg9ZiZGqn7Xooq+mAL3MrzmGQTfqkYmLsQvS4NQlxdGgefrycjU9mRrqVcGatqfCk6eqZywcna+KifNhOg3vnVL4cOfDPWQuPwE4JwHF7Z2JFWsojc//AT2uAYIqFwjgsIM3SvCVh7fYLjzzTnVdSx1T9TQCZvS4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS7PR12MB6144.namprd12.prod.outlook.com (2603:10b6:8:98::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.34; Mon, 6 Feb 2023 11:21:46 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 11:21:46 +0000
Message-ID: <7602a127-362f-beff-acc9-936df5b46c92@amd.com>
Date: Mon, 6 Feb 2023 12:21:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 04/13] drm/amdgpu: replace aper_base_kaddr with
 vram_aper_base_kaddr
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230203190836.1987-1-shashank.sharma@amd.com>
 <20230203190836.1987-5-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230203190836.1987-5-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::6) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DS7PR12MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: 04fe6ac2-84d1-4052-b726-08db08345549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IRlQ95NdayyAO4cF65XQEQpwEbbvtNur9ngke2TkJZeUliQNiK0Ud8QQjDRsEPdj5r7LGg0W6zaRW40mdK24jsf08uzzXObsqufPCWjQgZKuVmJUW6LVzWWQJzV2x6MOLd7XVX4Q7D1JFULiXzWbxEqwsGQKZu4HLQ/+8ZylF+Ww8JIm4EhuxjPW6cAdREzA22nqYpZEKQAhpt/Nzj011v1S9pC6+n2XEuGsCe6CPoCrWrwzAMlzR/fxfyuSV18BIMj7R6cW8Bo5Ex4lKNQiJL/dnCUed+PHwm6NAmMr3NNO/z/YlHX+a36DuyCGcdx/WBsbF2yA65zWwsBtixUEuyLkPSsDDkFtQ3PbmorCGFB997RevTcfQdFGfEfeEFRi0tFRJ4Y7ZqsQZavLHvo0IrKnieFHW8Dd2FeK21nvjm9+6hPj8sRLuF/DMHAaPdOQWoT0+Fe7M6be/hL2Lgt2057Rl4scPx//XWEGMIqVo5gop4FoUFoc+Qh7jNpomd8+MBWhwplbTgL/0fc577w8k9ZNIJLU886vzQgRD5mY2TuqM1g14qko9QWus5+XMgHrqH78Aokj9ulfdWJmbdnj69g1sgRrl9+kRzxYxXKZZBzCBheQhnXsbh+47ZvWQh5P1BZO5dgzyVt/l3XYEdGwhRJhd+hYWDiJtIa2Mj5tU059G3EKJM+HyMeEK8VW5pp1TDWW3D9Quhqpnr6g/uhgMPlQH9hKWIgr/uKqWXyt/RM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199018)(36756003)(316002)(6666004)(6506007)(8676002)(6486002)(5660300002)(66476007)(66556008)(2906002)(66946007)(41300700001)(4326008)(8936002)(26005)(6512007)(31696002)(38100700002)(86362001)(66574015)(478600001)(83380400001)(186003)(2616005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmZRWlhMWFFLSUR4Q0EzdlU0Smd2dTcydWdQRll2aXJqTU1JMWV6UWo3bzlk?=
 =?utf-8?B?WDBIbksvTlYyWTkxTURlT1dyS0hobTlLa3A5SnpWYi84b1k5M1NRUXZJRUpl?=
 =?utf-8?B?VmlzQ0lLRU1zUG5ia2E4dk1yeGh0Q3AzWFNTb1BvTUd1TE5PRExKMGE0MUJW?=
 =?utf-8?B?R2xtWTk0QnY2R0Q2dENFT3dOcTdaM3pJeFl2TlBva0l1UGVLQTZ1RTZUNFBQ?=
 =?utf-8?B?ZkJudzZMWnIxOFJQaUhoVGtNVnRlWWQ2V0ZiZmFVWUJnMm9PWHdIRWpYZzJj?=
 =?utf-8?B?MGw2SllzMzJxa2NLdFdSdmxManQ4QU85a2haZGFhZ0Zrd1dLR3hGQ3dENitO?=
 =?utf-8?B?MTlYYnc4dG5UVDIrZ1I4cCtTWGxJZkVOZWUwN2tWTFhvU3dPRC81Y1ZuMGEx?=
 =?utf-8?B?RjJuM2UyYXdHRFJwWENVN3N5WHh3UzZnc05BY05RQi82MENIVXMvTTRBL1RL?=
 =?utf-8?B?cE56OTR1TjVQWkg1SUUxNmRUdFJiUjZoZHlFZjB2d2s5Z0R1bXY5NFo0SHQ1?=
 =?utf-8?B?bnRYY2NMVVNiNVhPTkJ3TThsR2UwZm9oVnVtRW9ZNUNYQVRibFY1U1ltVjFi?=
 =?utf-8?B?K3l5cWFkRUJiSVZEQ0lwR3BHOWx2dXA4VnAwams5Q0tPTFI1TmVzZ2x5VnZR?=
 =?utf-8?B?V0c4ZndSZ3MxTjBza2hzeGVtODh1OG9pVFhoMlU1RWtOcnl5U1VtVTBtemtq?=
 =?utf-8?B?N3VBTlozY3YwN3lDT3cwNkdOUlo3ekhmRStPSXNyejUzOGF1UTl3NzY0Uk1I?=
 =?utf-8?B?RlVyYURsaytvdWVXUVk3Q1gycFZ6alBXaGdFUWd1SHJrSWZCN0M1Zk1Ibnkr?=
 =?utf-8?B?RjFMWWpCRDFockNkVTdQMk5QRXJFZkFVMWFNRFB4L0hibzM1OGhXS0wzMnI1?=
 =?utf-8?B?UEZkTGJqNjlWcGJLL0R5S1JwZkVYd1VUWDJtYXRBN2FVNE9oc2NiUlZZd29X?=
 =?utf-8?B?dVE3c3B6L0N5SzJpWHBaZGlaSzRwcll6OFhNVUlxTXNuZlRtb1VTL2dNZWJN?=
 =?utf-8?B?THBuYlhrKzhCSzNrdEg1cFc5TzdTMi81T3JLVUczWFpGYVR3a2p0cGJsbUlD?=
 =?utf-8?B?U3YyYkhMMkJaUjRGNitPcjZ2ODg0S3B4dWpUSndSYklJTWUzZHRvbGcwVE12?=
 =?utf-8?B?SnpRYlR5Z3htUVBUM2UrNzZlMUdMRjRTZ2UyT3YwZ3FsZnhjVjN4c0x2RURI?=
 =?utf-8?B?U1MxSEZMM0d6U0tOQlZJQXZINkJXb0FGbTBVSkdhRjk5TjllcG5TZWRQRDJr?=
 =?utf-8?B?Mkl5amxCb2p2RmdQb25qYUVocDQrbm9OTnd6MHRkTzQxQ3ZlS2FiY1Z2eUVw?=
 =?utf-8?B?dlB4MHlQMnVxWFNLczNkOER2bU1ucVZiTFp0aEloMEZvcmNsNUFIWWQzd1RX?=
 =?utf-8?B?eS9BVENVdndxNm40cUNvUll3QXFvcyswTnNMaWYrY1pWeCtmU2hScFNlWUMw?=
 =?utf-8?B?M3RHL1FXd1lKaFNBNXVEZElUSGxxblRtMjg1clVpbXhBZlpndXR6K0VOREh0?=
 =?utf-8?B?K25URTY1R3Y5akhaMTF6ZWgrUnNSamJCVXY5STBBUlM5Tk1KSmlOOEx6SGI0?=
 =?utf-8?B?eWNlMzBwRUw1czJqdXJIYUxMNHVRMCtLRzJLdzhOQnRVZ05aeW15ZFpUMUsr?=
 =?utf-8?B?KytMQ1FhU09jY1hNaFlFa1l4S1I3cHd6c3B5OS95R2ZNSi9lN21hK2g2RTVC?=
 =?utf-8?B?NWlURTVrUmtMRnIrd25ldU1ncXV6VlBKRmcrek8vNHUvRElSMGdHVmtVdEVF?=
 =?utf-8?B?RzVpenY3VmlRSmcvWGlyTEl1QW8wMVhGbDlMM0RBYnBpeFczeGFaVkhoaWdq?=
 =?utf-8?B?ZGNiRmpoeUE5Tk41UEdkTlkwK0Z0dlJ5N3VxbzJROXZ1RUxFclRnWmxQd1B2?=
 =?utf-8?B?M3Zlb0xpSUgrS3JGNW9GUzJjaGlHQThQYXlYMG1xYlRIQW1Mc1orZWU3enQ1?=
 =?utf-8?B?TUNpODg2ekFDNnRJMW1MT0JCdVFlbFlDaHB2Z1VFQmVscWhWSFllWGZ1YXpB?=
 =?utf-8?B?RkJBdHJuVFMvcVI0N0tGamprbFE0c2N5ZlE2SHQwRUNtWEJhRlNzWkR5V3pB?=
 =?utf-8?B?NkRtQ0wrMEdMcGpZaW9DdjdsYm5wdEd4Z0Z3djAyWXJPSkhqeENabXU2cGk5?=
 =?utf-8?Q?DJPwVx9RyUaZ7FTYzYPBQTd5c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fe6ac2-84d1-4052-b726-08db08345549
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 11:21:46.7148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2RRw9KxdazyXag3IOzNdasoNz7BUzpFTwiOB4Q02YWmC4XgktMxRFMqrR5q9lxd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6144
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
> To differentiate it from the doorbell BAR.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 14 +++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/psp_v11_0.c     | 10 +++++-----
>   drivers/gpu/drm/amd/amdgpu/psp_v13_0.c     | 10 +++++-----
>   5 files changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2f28a8c02f64..0b6a394e109b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -354,12 +354,12 @@ size_t amdgpu_device_aper_access(struct amdgpu_device *adev, loff_t pos,
>   	size_t count = 0;
>   	uint64_t last;
>   
> -	if (!adev->mman.aper_base_kaddr)
> +	if (!adev->mman.vram_aper_base_kaddr)
>   		return 0;
>   
>   	last = min(pos + size, adev->gmc.visible_vram_size);
>   	if (last > pos) {
> -		addr = adev->mman.aper_base_kaddr + pos;
> +		addr = adev->mman.vram_aper_base_kaddr + pos;
>   		count = last - pos;
>   
>   		if (write) {
> @@ -3954,9 +3954,9 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
>   
>   	iounmap(adev->rmmio);
>   	adev->rmmio = NULL;
> -	if (adev->mman.aper_base_kaddr)
> -		iounmap(adev->mman.aper_base_kaddr);
> -	adev->mman.aper_base_kaddr = NULL;
> +	if (adev->mman.vram_aper_base_kaddr)
> +		iounmap(adev->mman.vram_aper_base_kaddr);
> +	adev->mman.vram_aper_base_kaddr = NULL;
>   
>   	/* Memory manager related */
>   	if (!adev->gmc.xgmi.connected_to_cpu) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 668826653591..196ba62ef721 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -578,9 +578,9 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
>   		if ((mem->bus.offset + bus_size) > adev->gmc.visible_vram_size)
>   			return -EINVAL;
>   
> -		if (adev->mman.aper_base_kaddr &&
> +		if (adev->mman.vram_aper_base_kaddr &&
>   		    mem->placement & TTM_PL_FLAG_CONTIGUOUS)
> -			mem->bus.addr = (u8 *)adev->mman.aper_base_kaddr +
> +			mem->bus.addr = (u8 *)adev->mman.vram_aper_base_kaddr +
>   					mem->bus.offset;
>   
>   		mem->bus.offset += adev->gmc.aper_base;
> @@ -1752,12 +1752,12 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   #ifdef CONFIG_64BIT
>   #ifdef CONFIG_X86
>   	if (adev->gmc.xgmi.connected_to_cpu)
> -		adev->mman.aper_base_kaddr = ioremap_cache(adev->gmc.aper_base,
> +		adev->mman.vram_aper_base_kaddr = ioremap_cache(adev->gmc.aper_base,
>   				adev->gmc.visible_vram_size);
>   
>   	else
>   #endif
> -		adev->mman.aper_base_kaddr = ioremap_wc(adev->gmc.aper_base,
> +		adev->mman.vram_aper_base_kaddr = ioremap_wc(adev->gmc.aper_base,
>   				adev->gmc.visible_vram_size);
>   #endif
>   
> @@ -1904,9 +1904,9 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>   
>   	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>   
> -		if (adev->mman.aper_base_kaddr)
> -			iounmap(adev->mman.aper_base_kaddr);
> -		adev->mman.aper_base_kaddr = NULL;
> +		if (adev->mman.vram_aper_base_kaddr)
> +			iounmap(adev->mman.vram_aper_base_kaddr);
> +		adev->mman.vram_aper_base_kaddr = NULL;
>   
>   		drm_dev_exit(idx);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 1061447befc6..020ebba5a51a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -50,7 +50,7 @@ struct amdgpu_gtt_mgr {
>   struct amdgpu_mman {
>   	struct ttm_device		bdev;
>   	bool				initialized;
> -	void __iomem			*aper_base_kaddr;
> +	void __iomem			*vram_aper_base_kaddr;
>   
>   	/* buffer handling */
>   	const struct amdgpu_buffer_funcs	*buffer_funcs;
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index bd3e3e23a939..f39d4f593a2f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -611,10 +611,10 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
>   		 */
>   		sz = GDDR6_MEM_TRAINING_ENCROACHED_SIZE;
>   
> -		if (adev->gmc.visible_vram_size < sz || !adev->mman.aper_base_kaddr) {
> -			DRM_ERROR("visible_vram_size %llx or aper_base_kaddr %p is not initialized.\n",
> +		if (adev->gmc.visible_vram_size < sz || !adev->mman.vram_aper_base_kaddr) {
> +			DRM_ERROR("visible_vram_size %llx or vram_aper_base_kaddr %p is not initialized.\n",
>   				  adev->gmc.visible_vram_size,
> -				  adev->mman.aper_base_kaddr);
> +				  adev->mman.vram_aper_base_kaddr);
>   			return -EINVAL;
>   		}
>   
> @@ -625,7 +625,7 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
>   		}
>   
>   		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -			memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
> +			memcpy_fromio(buf, adev->mman.vram_aper_base_kaddr, sz);
>   			ret = psp_v11_0_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_TRAIN);
>   			if (ret) {
>   				DRM_ERROR("Send long training msg failed.\n");
> @@ -634,7 +634,7 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
>   				return ret;
>   			}
>   
> -			memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
> +			memcpy_toio(adev->mman.vram_aper_base_kaddr, buf, sz);
>   			adev->hdp.funcs->flush_hdp(adev, NULL);
>   			vfree(buf);
>   			drm_dev_exit(idx);
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> index e6a26a7e5e5e..9605c0971c11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> @@ -510,10 +510,10 @@ static int psp_v13_0_memory_training(struct psp_context *psp, uint32_t ops)
>   		 */
>   		sz = GDDR6_MEM_TRAINING_ENCROACHED_SIZE;
>   
> -		if (adev->gmc.visible_vram_size < sz || !adev->mman.aper_base_kaddr) {
> -			dev_err(adev->dev, "visible_vram_size %llx or aper_base_kaddr %p is not initialized.\n",
> +		if (adev->gmc.visible_vram_size < sz || !adev->mman.vram_aper_base_kaddr) {
> +			dev_err(adev->dev, "visible_vram_size %llx or vram_aper_base_kaddr %p is not initialized.\n",
>   				  adev->gmc.visible_vram_size,
> -				  adev->mman.aper_base_kaddr);
> +				  adev->mman.vram_aper_base_kaddr);
>   			return -EINVAL;
>   		}
>   
> @@ -524,7 +524,7 @@ static int psp_v13_0_memory_training(struct psp_context *psp, uint32_t ops)
>   		}
>   
>   		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -			memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
> +			memcpy_fromio(buf, adev->mman.vram_aper_base_kaddr, sz);
>   			ret = psp_v13_0_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_TRAIN);
>   			if (ret) {
>   				DRM_ERROR("Send long training msg failed.\n");
> @@ -533,7 +533,7 @@ static int psp_v13_0_memory_training(struct psp_context *psp, uint32_t ops)
>   				return ret;
>   			}
>   
> -			memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
> +			memcpy_toio(adev->mman.vram_aper_base_kaddr, buf, sz);
>   			adev->hdp.funcs->flush_hdp(adev, NULL);
>   			vfree(buf);
>   			drm_dev_exit(idx);

