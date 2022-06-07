Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7F9C43334
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 22:36:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5845D10F2CD;
	Tue,  7 Jun 2022 22:36:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F0A310F2D2
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 22:36:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYQngEu33432nQIRP8ql2kDOlhz18KRj0N2UwOPd3Shg9OVg4TKygD+S2OjwwEuzoZriLOIVhkoZGP+FYoUBKX3TCYYSb3uBpuCb1Vt292oGyZZiMPdDVssYcQnF68i1MkPKZyFqeg5h6JiNabcn79xBneYJt6H4MQ99Nrf7LA1zQmP0Np/M3/COisNltHxoWxZxMl6I0KUUatpj75ilRjvLcXStGplOmtGQskRhqKVB7Uoy6jQdBU9wQ2im84a5dET/uFSNH0PEFR0KLRnAfdJWYPa7pYNBN739LjSvI7nyFMoEHqrvQ+levfXc84jgySbJGt1nrk4No2rpniNp9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lMplVlw+OQonkeyw/LePKRGEaulb8+H/5iZmQWAD0c=;
 b=nJ3ToPRZZaopkJHuXn6icXj7ceNyPkDIPmAEp3eO1fMwKn89fhUiiZ0DW02W23r3fe7RBRfa2/C/HWZHF53/mMs35z7BlXpLqjQjkVYECXFoeHtwW1ctWYkAoi0lmvcqiGmAjV3YpgPiFTNd7mh1c23CmcOt8x1dV6hjUNkUR2Q3p8Yi+TKeWrCsMqKdeH1EHYOcl+VK+hBKfpR/8gwglO+my0SAfd9lnAQxJpUGHDsaI+1Ux/p/2lGo8CRfSGVe1YTC724Sclfw0CWj9VKXdpAF64gP0p9/YXzTJE5QaI9j/ldc5A1NyV5ZNYeEVhadNGP5Q0HQPiTergkhSYUCCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lMplVlw+OQonkeyw/LePKRGEaulb8+H/5iZmQWAD0c=;
 b=YWuLKVOmpYeHYD0yinPfajEHujafVrztCaNVwNL1TP2lMwl254KwvLSlu0hlgGM282uM2+W1mNtYKwT5DuIE+dXa5JYdrQHz6IWm5ZxSZMoNcYXm4bOwgOkDRhjauIOxAFa31Pd9XxnFP0+YObDWej9q4TGVYlF5h9BT1C61ulc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM5PR1201MB0153.namprd12.prod.outlook.com (2603:10b6:4:57::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 22:36:55 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 22:36:55 +0000
Message-ID: <d1772c6f-ef47-b900-f578-be4b3deb84b7@amd.com>
Date: Tue, 7 Jun 2022 18:36:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] drm/amdkfd: track unified memory reservation with
 xnack off
Content-Language: en-US
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220607171706.28432-1-alex.sierra@amd.com>
 <20220607171706.28432-2-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220607171706.28432-2-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::31) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfad66c8-7990-43be-8fe2-08da48d63985
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0153:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01535DF2FABA8FB58972DDBE92A59@DM5PR1201MB0153.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lc1aKMJ8Ar98EqAnv4V6y4DgMIPpMnSwsSQo/7MYSnyz1fWBASCs4n4QcuqUfY1B4v8A3lMXLRy7rAtQOqV02qHT+G4/qWpRv7rdKfTVsotrBNKnKJV4VpO9MrYUVoAI9q0nN4eUV+PVPnlljo9Urp01gdribIAjMipCo0Yo2lRhAVFeqLAx4rpWZ9HXbG2Gp3Na5/oQRm3u+0bYCnOcPwMvo8Wl0ycSPVWcRJp6L5lNE7nKC7RBjUCpMbWWfIUNdHmeNCjVlWiS3xwy57jOIw1YGgO23KILSY+ZCU94i8yU7ojZgqRGvq+FhnrNbLEL9KWoR1T+5TOdU2jEauGjq8paKGgNNAdXzncwzJNcv0B3HtENR2BjJS92szL3kldENAX1N4MbGyNUjh83QmF5Q3ICvjQj9x2x8Fj42yAdXrQYmzi2+W37LlTxQVk00oCVa6Ms1Lu33etefNClXVtQtgttpmNm70oleMux+WlpZzN76LeW56dFGvioHFTwU9NNsjHrsWHnt0+zBQGfW/4POoLyJcx/1dpEhNNmAbosbarIwDU17jpxdb6y5xUAwDduDiJa8WGERi8qEnqQU3RxQfxP4tH+eHsGaT+GeQWzwKOoRjAitbOllJQQcOYhdPPvBCdqI5Kb/2BgZnDRd7jgBTk0knUUxFUQxeh1WyHp3zJ2yxvsyZIya0ru7d9n91r7lMpptkU0D6z2lQ644w4MkqEkEO4ZMJOazQgbosYdH1ZFs+gPlVaPqc8uEHPcFzfe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(316002)(8676002)(30864003)(31696002)(2906002)(5660300002)(66946007)(8936002)(66556008)(66476007)(2616005)(26005)(186003)(508600001)(86362001)(44832011)(38100700002)(6486002)(6512007)(83380400001)(31686004)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXFZQXF3NFhMMllCQk5iSWR3N1ZxcEFOMFZvY2g1M25jOC9qc3ZxNVFQSTNJ?=
 =?utf-8?B?ZFJod0xKdWxmb1dtVlpkQjk3TmpyZ3NlUGdINEVneVdkaXA3QjcySTVuKzNC?=
 =?utf-8?B?VGtoVlZTTTVxU0VZYWRnaGJ5ejFZZ3JyeGErQjl5THRiZmNVelM1Tk1nL1Jy?=
 =?utf-8?B?bzJYWU1lSzJ3blc2SVBDb3dsZXVLVURQM0lKWnowNnhLUlRVSkVWSENvRlAy?=
 =?utf-8?B?V0dkWklwbEFSMUhoOGI2MVU4R2VEZ3BOdWFiVTF6c3ZEWDNLa3puU0pyL3kv?=
 =?utf-8?B?OUhDMkNiUFJJMVFidUtwSmZCVWIzZ2FpNjFDTXIzR0w2ckplaXVMc1pjOGts?=
 =?utf-8?B?YkF4UTBJdzkyZzRvczd5WU92dzlpVmxhTk1MeCtNVUtWQXpMSHNtNGxVNXk1?=
 =?utf-8?B?RzI3S2RVS2hIZlhNZy85d1lSNnlvZHQvS0oxbGpQb3dObDdLckRGeG95SVZD?=
 =?utf-8?B?VG93UHVhUGhCaksvUngzdVVSeUFhVFgyVHRVWGxLNlVNN050U3oyWisrekNo?=
 =?utf-8?B?VEViRUkrZEE5VmZ5MVhwMUprdGdKcG1WK2M1UlBrTFZLZlhkUHJ2N29RR0hT?=
 =?utf-8?B?dmw2b3BIZ0FrNTZjSXhqalgwZDIvQmprL2duZzR5bTJPNzVDVnMwNmxlb3hR?=
 =?utf-8?B?V1BoOWpIc0dqM0ZZakxYT1k2U0dOMlgyVlo1RWZzbjJTa1owK05hVzBBeWo1?=
 =?utf-8?B?Q1kzRVNZcDlhSnJvQkIvcXgzeEFCZHowRFlObmRlak1GT0JsaFhJTkpaNHN5?=
 =?utf-8?B?cXFEcnlpNUlZc3d4NmMybEZMSWdwUldoZTdMMG1VRkhpbWhQem5yODVwOUpH?=
 =?utf-8?B?OEdWNlRHVU4zK3N0c0pqSkJySE5LUmJsbGo5UEtLc3g2cVdTbWF3Q21KTWxn?=
 =?utf-8?B?bTZNYXQrVTZTdFJHenZ4RURBT0JJN1JtczZDTEpwSFpkQ1hMNkMreVo2Y1lh?=
 =?utf-8?B?UUVETDNCSzRzUlRIZU5mU1RTcEdYV3BLYmV6NjJQZ0ZqT3AwbDl5VXVSdVVh?=
 =?utf-8?B?THV4ZFEzUFdqMUE3U1hjUTl0eTg2V1VkKzRCTGk3Zk5wQXZLOVZ3V3FQcTlW?=
 =?utf-8?B?Y1paL2w3Ry9wd1JxN1JSWWwrY0EzeS9aVWtlU1FnNDFoR1VnSS96T3hzS2o4?=
 =?utf-8?B?TnYzR1BiUDJEdWdpUHk4VGxHWUJ2emdoeHh0OUFKdjJ6dWE0THBmK3lCOXRm?=
 =?utf-8?B?bFQzWUZ3MXgydFUvbEIxWnRxN2dMZHpWVDdiQXBTWnY3ZWRtNEJRMzRJTGh5?=
 =?utf-8?B?UzFrcHBKRVMyTTNGRlVHMGlzQTdZbndUSUF3T3ZKSUlWMWZyUHVJemZ3S0Vj?=
 =?utf-8?B?Z0tmQ0JMMmgyR3VQQTJZYWFLOExIc3Y0OXF3czluTGdQbElCanRSOGd5Skgr?=
 =?utf-8?B?amdQYkl2SEpsbFV5a09FMGRDd0JVSisxQzJhT1AyOGxMb1F1QVhObnRaRHpV?=
 =?utf-8?B?YWZ2T3lBR0dua0JobTRtcEFDZkQ3SVdCT3djc3o1OUQ1cE1NRVNWZEM0dDJ3?=
 =?utf-8?B?V3U3OUpHdkc4NEkyeDdmS3NsRnJaTVhXVU5iV3liTXpSUStRblhlcExmY1FO?=
 =?utf-8?B?d0JtVmNHYU5Sc0JxVDRlVGFyZW15L3VwbVJsZTRxd09pK2VkYnNvODJGdTdO?=
 =?utf-8?B?TkdWcGdFL1FhZlozWFJNS09LWWNIMEh6OExUUEpmZGJ2LzE4aVZGM1VvMVZv?=
 =?utf-8?B?cnRtVjhBSVFmeThoR3hMNUVkazlrY3FQUEFhVzhQZFNQZ0plTnMvSCtiaThq?=
 =?utf-8?B?TDdkSkZSUmx3R1AxWnBiQlR3SWk5bzI5SkZVczJkMUdFRVpXUnZGaWZpL0hm?=
 =?utf-8?B?eGVIZjc0MW54bi9DRk9rSDJUR0pubjFJOWU0dG5pRks3d2VKSmFubHMxY0U0?=
 =?utf-8?B?dlFBWnl5MFlkTVk5b3dRYWp1eU1nY0dXVnNEWEtucW5YNWZ0SlVOaEtUdWZi?=
 =?utf-8?B?UDV1aWdhM1pwTGpXKzkzKzI5NjFFc0F6RGlodVFSR1FZSnNRK3dsZStBNEkw?=
 =?utf-8?B?OU1RVzNpc0Q1NHhWMDU3MmpVc0JoTkRhcElJWTBtNmxydk94c0pHUGw2bFcr?=
 =?utf-8?B?aEIwTVloM3hudUpvRThWVldWVzlNVG1IT2d1cHFZamdkOUI5Zm1hWG9Fcjh3?=
 =?utf-8?B?dDJlUG1kOTlKYnl0cDdkMFBrY0trQVprOGdVR3MrZkszR3g0bVJLcFArWFVS?=
 =?utf-8?B?OGFRVWlqekMvcHBWWGVSVzVISXo3d05wbkNMME14eUkvWmRUSE1PdWN6bFJa?=
 =?utf-8?B?SGIwNnhaSTd1ajF5RmNkM29zK1gvbnNNTk9YM1hVc2dIejZRMXRudFJON2F1?=
 =?utf-8?B?V1RuM1Q1cGVTNFBzM0JOc0N1NDhIUHBNekJyNkw2RFJlZjVDQTZMdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfad66c8-7990-43be-8fe2-08da48d63985
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 22:36:55.2695 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EmwHzRNW2HpO0Xoy8Nu6g+AKahuM9dCYsrWhuYPabrz9Zb/XfC8BIn3pb/J6LnboglLE/vFBtqRvt1DMCY1uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0153
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-06-07 um 13:17 schrieb Alex Sierra:
> [WHY]
> Unified memory with xnack off should be tracked, as userptr mappings
> and legacy allocations do. To avoid oversuscribe system memory when
> xnack off.
> [How]
> Exposing functions reserve_mem_limit and unreserve_mem_limit to SVM
> API and call them on every prange creation and free.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

I'm finding some more problems (see inline). It makes me wonder whether 
there is a good way to test this. We may need to expose the mem limits 
in debugfs so we can check for leaks.


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  4 ++
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 27 ++++++-----
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 47 +++++++++++++------
>   3 files changed, 51 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index f8b9f27adcf5..f55f34af6480 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -301,6 +301,10 @@ bool amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *
>   void amdgpu_amdkfd_block_mmu_notifications(void *p);
>   int amdgpu_amdkfd_criu_resume(void *p);
>   bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev);
> +int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
> +		uint64_t size, u32 alloc_flag);
> +void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
> +		uint64_t size, u32 alloc_flag);
>   
>   #if IS_ENABLED(CONFIG_HSA_AMD)
>   void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 50730d2132a6..f13977ae4579 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -122,7 +122,7 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
>    *
>    * Return: returns -ENOMEM in case of error, ZERO otherwise
>    */
> -static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
> +int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   		uint64_t size, u32 alloc_flag)
>   {
>   	uint64_t reserved_for_pt =
> @@ -157,8 +157,8 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   	     kfd_mem_limit.max_system_mem_limit && !no_system_mem_limit) ||
>   	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
>   	     kfd_mem_limit.max_ttm_mem_limit) ||
> -	    (adev->kfd.vram_used + vram_needed >
> -	     adev->gmc.real_vram_size - reserved_for_pt)) {
> +	    (adev && (adev->kfd.vram_used + vram_needed >
> +	     adev->gmc.real_vram_size - reserved_for_pt))) {

The extra pair of parentheses you added around the a > b is unnecessary.


>   		ret = -ENOMEM;
>   		goto release;
>   	}
> @@ -166,7 +166,10 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   	/* Update memory accounting by decreasing available system
>   	 * memory, TTM memory and GPU memory as computed above
>   	 */
> -	adev->kfd.vram_used += vram_needed;
> +	WARN_ONCE(vram_needed && !adev,
> +		  "adev reference can't be null when vram is used");
> +	if (adev)
> +		adev->kfd.vram_used += vram_needed;
>   	kfd_mem_limit.system_mem_used += system_mem_needed;
>   	kfd_mem_limit.ttm_mem_used += ttm_mem_needed;
>   
> @@ -175,7 +178,7 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   	return ret;
>   }
>   
> -static void unreserve_mem_limit(struct amdgpu_device *adev,
> +void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
>   		uint64_t size, u32 alloc_flag)
>   {
>   	spin_lock(&kfd_mem_limit.mem_limit_lock);
> @@ -184,7 +187,10 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
>   		kfd_mem_limit.system_mem_used -= size;
>   		kfd_mem_limit.ttm_mem_used -= size;
>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
> -		adev->kfd.vram_used -= size;
> +		WARN_ONCE(!adev,
> +			  "adev reference can't be null when alloc mem flags vram is set");
> +		if (adev)
> +			adev->kfd.vram_used -= size;
>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>   		kfd_mem_limit.system_mem_used -= size;
>   	} else if (!(alloc_flag &
> @@ -193,11 +199,8 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
>   		pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
>   		goto release;
>   	}
> -
> -	WARN_ONCE(adev->kfd.vram_used < 0,
> +	WARN_ONCE(adev && adev->kfd.vram_used < 0,
>   		  "KFD VRAM memory accounting unbalanced");
> -	WARN_ONCE(kfd_mem_limit.ttm_mem_used < 0,
> -		  "KFD TTM memory accounting unbalanced");
>   	WARN_ONCE(kfd_mem_limit.system_mem_used < 0,
>   		  "KFD system memory accounting unbalanced");
>   
> @@ -211,7 +214,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
>   	u32 alloc_flags = bo->kfd_bo->alloc_flags;
>   	u64 size = amdgpu_bo_size(bo);
>   
> -	unreserve_mem_limit(adev, size, alloc_flags);
> +	amdgpu_amdkfd_unreserve_mem_limit(adev, size, alloc_flags);
>   
>   	kfree(bo->kfd_bo);
>   }
> @@ -1601,7 +1604,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   	/* Don't unreserve system mem limit twice */
>   	goto err_reserve_limit;
>   err_bo_create:
> -	unreserve_mem_limit(adev, size, flags);
> +	amdgpu_amdkfd_unreserve_mem_limit(adev, size, flags);
>   err_reserve_limit:
>   	mutex_destroy(&(*mem)->lock);
>   	if (gobj)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index d6fc00d51c8c..329b10d1709b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -259,13 +259,22 @@ void svm_range_free_dma_mappings(struct svm_range *prange)
>   	}
>   }
>   
> -static void svm_range_free(struct svm_range *prange)
> +static void svm_range_free(struct svm_range *prange, bool skip_unreserve)
>   {
> +	uint64_t size = (prange->last - prange->start + 1) << PAGE_SHIFT;
> +	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
> +
>   	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx]\n", prange->svms, prange,
>   		 prange->start, prange->last);
>   
>   	svm_range_vram_node_free(prange);
>   	svm_range_free_dma_mappings(prange);
> +
> +	if (!skip_unreserve && !p->xnack_enabled) {
> +		pr_debug("unreserve mem limit: %lld\n", size);
> +		amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
> +					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
> +	}
>   	mutex_destroy(&prange->lock);
>   	mutex_destroy(&prange->migrate_mutex);
>   	kfree(prange);
> @@ -284,7 +293,7 @@ svm_range_set_default_attributes(int32_t *location, int32_t *prefetch_loc,
>   
>   static struct
>   svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
> -			 uint64_t last)
> +			 uint64_t last, bool is_new_alloc)
>   {
>   	uint64_t size = last - start + 1;
>   	struct svm_range *prange;
> @@ -293,6 +302,15 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>   	prange = kzalloc(sizeof(*prange), GFP_KERNEL);
>   	if (!prange)
>   		return NULL;
> +
> +	p = container_of(svms, struct kfd_process, svms);
> +	if (!p->xnack_enabled && is_new_alloc &&
> +	    amdgpu_amdkfd_reserve_mem_limit(NULL, size << PAGE_SHIFT,
> +					    KFD_IOC_ALLOC_MEM_FLAGS_USERPTR)) {
> +		pr_info("SVM mapping failed, exceeds resident system memory limit\n");
> +		kfree(prange);
> +		return NULL;
> +	}
>   	prange->npages = size;
>   	prange->svms = svms;
>   	prange->start = start;
> @@ -307,7 +325,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>   	mutex_init(&prange->migrate_mutex);
>   	mutex_init(&prange->lock);
>   
> -	p = container_of(svms, struct kfd_process, svms);
>   	if (p->xnack_enabled)
>   		bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
>   			    MAX_GPU_INSTANCE);
> @@ -1000,9 +1017,9 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
>   
>   	svms = prange->svms;
>   	if (old_start == start)
> -		*new = svm_range_new(svms, last + 1, old_last);
> +		*new = svm_range_new(svms, last + 1, old_last, false);
>   	else
> -		*new = svm_range_new(svms, old_start, start - 1);
> +		*new = svm_range_new(svms, old_start, start - 1, false);
>   	if (!*new)
>   		return -ENOMEM;
>   
> @@ -1010,7 +1027,7 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
>   	if (r) {
>   		pr_debug("failed %d split [0x%llx 0x%llx] to [0x%llx 0x%llx]\n",
>   			 r, old_start, old_last, start, last);
> -		svm_range_free(*new);
> +		svm_range_free(*new, false);

This should be skip_unreserve=true because the range you're freeing was 
created without reserving space.


>   		*new = NULL;
>   	}
>   
> @@ -1825,7 +1842,7 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
>   {
>   	struct svm_range *new;
>   
> -	new = svm_range_new(old->svms, old->start, old->last);
> +	new = svm_range_new(old->svms, old->start, old->last, false);
>   	if (!new)
>   		return NULL;
>   
> @@ -1951,7 +1968,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   
>   		/* insert a new node if needed */
>   		if (node->start > start) {
> -			prange = svm_range_new(svms, start, node->start - 1);
> +			prange = svm_range_new(svms, start, node->start - 1, true);
>   			if (!prange) {
>   				r = -ENOMEM;
>   				goto out;
> @@ -1967,7 +1984,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   
>   	/* add a final range at the end if needed */
>   	if (start <= last) {
> -		prange = svm_range_new(svms, start, last);
> +		prange = svm_range_new(svms, start, last, true);
>   		if (!prange) {
>   			r = -ENOMEM;
>   			goto out;
> @@ -1979,7 +1996,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   out:
>   	if (r)
>   		list_for_each_entry_safe(prange, tmp, insert_list, list)
> -			svm_range_free(prange);
> +			svm_range_free(prange, false);

OK, so maybe we do need a flag here after all, because we need to 
unreserve space for ranges that were newly inserted (under the comment 
/* insert a new node if needed */), but skip unreserving space for 
ranges that were cloned from existing ones.

Or we need a separate new_list for real new ranges, that gets spliced 
into the insert_list in the success case, and freed with unreserve in 
the failure case.

Regards,
   Felix


>   
>   	return r;
>   }
> @@ -2026,7 +2043,7 @@ svm_range_handle_list_op(struct svm_range_list *svms, struct svm_range *prange,
>   			 svms, prange, prange->start, prange->last);
>   		svm_range_unlink(prange);
>   		svm_range_remove_notifier(prange);
> -		svm_range_free(prange);
> +		svm_range_free(prange, false);
>   		break;
>   	case SVM_OP_UPDATE_RANGE_NOTIFIER:
>   		pr_debug("update notifier 0x%p prange 0x%p [0x%lx 0x%lx]\n",
> @@ -2588,14 +2605,14 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
>   		last = addr;
>   	}
>   
> -	prange = svm_range_new(&p->svms, start, last);
> +	prange = svm_range_new(&p->svms, start, last, true);
>   	if (!prange) {
>   		pr_debug("Failed to create prange in address [0x%llx]\n", addr);
>   		return NULL;
>   	}
>   	if (kfd_process_gpuid_from_adev(p, adev, &gpuid, &gpuidx)) {
>   		pr_debug("failed to get gpuid from kgd\n");
> -		svm_range_free(prange);
> +		svm_range_free(prange, false);
>   		return NULL;
>   	}
>   
> @@ -2884,7 +2901,7 @@ void svm_range_list_fini(struct kfd_process *p)
>   	list_for_each_entry_safe(prange, next, &p->svms.list, list) {
>   		svm_range_unlink(prange);
>   		svm_range_remove_notifier(prange);
> -		svm_range_free(prange);
> +		svm_range_free(prange, false);
>   	}
>   
>   	mutex_destroy(&p->svms.lock);
> @@ -3299,7 +3316,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   			 prange->last);
>   		svm_range_unlink(prange);
>   		svm_range_remove_notifier(prange);
> -		svm_range_free(prange);
> +		svm_range_free(prange, true);
>   	}
>   
>   	mmap_write_downgrade(mm);
