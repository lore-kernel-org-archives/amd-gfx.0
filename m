Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D916CC54EBC
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 03:15:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 278FE10E522;
	Tue, 10 Jan 2023 03:15:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB2AB10E522
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 03:15:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6kGDzINZ3DtuEm3YAi7ktMqS9qCX/AUAM+sLpGDn3ilHZaLsrmQEHJUM1JDz1iHvRz2TC2d8ZTbMK1A3DLiCgNZuQ33dazPMc/3Z/Z4p65Qn/AZegmCh9SrC93KAEZh7bhUxsm7i26WBAtvRoWHoqJk9aUe1Dnx85xSoJca7VyG3s996+m7dswOm9zF4AwiRAqEDWvB88C5jFQ1Hcxoc58N1GUDZ7nr7xZc4WgJ+5qiDeDVFvXg1EuJGbBVwXOdEP5QgfMI/CBTAosN/18ra3v8sJIXp/P70iNg/mDCq5hgvRDJUmF1hcWnbC1I/U1A/+TsefYbb9fN9lKkXGyM3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XInfl3J8B3kXyrNWPSIX14V3RqVsfgj18g21oX+PMLY=;
 b=eb6wenBZJZSMQ/qvaW948+VkJFrifHbxV5mc+cqc4zk6qxgtK97S8bBxjm/wuW51TK6G3dinzJsTQ4nB/LFcPuoFnv4D0bTbJNQAdt+vJlx/byKOR6FiRsb7+eVm/t3J1k62deknulhF/rHclHLkyGh+ZFq9Yvfm9uf9Y6+vtGVw/LV7m3vztuIvJTCmY5T/nNnKT1eyEAFr/9oJiFrH7l4xG6GNwLpR8Kyi71DuOpTGKdxxTLJZDRRhddUGkL6i7fh/EFdrFkQIVITR/BZGDtv4jkvdpe0/cg8keyZxirPzxqYB+WVE089aPom0x9y/jmK4ysbqdAhTx/fhMlyf9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XInfl3J8B3kXyrNWPSIX14V3RqVsfgj18g21oX+PMLY=;
 b=lxALphRz/KBPXfRRkYq7gjt86gVPGwXeLM2AzdtsEcBpTPVWUpBMs6yCy3J7cAEIAvLcqvETiJSZHZgxXyLDAgLdTfgebi0aACeoariIfw/x3OUqxVby2gtxw1ZJlj9Y1uE2+vUMBVCU/UmFjaActLfDvO1GTzFbgM+6Wpr4gIc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY8PR12MB7145.namprd12.prod.outlook.com (2603:10b6:930:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 03:15:00 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411%5]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 03:15:00 +0000
Message-ID: <05f0daea-2e7c-78b2-29f8-7b7301b8df84@amd.com>
Date: Mon, 9 Jan 2023 22:14:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdkfd: Page aligned VRAM reserve size
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230110000112.29730-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230110000112.29730-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY8PR12MB7145:EE_
X-MS-Office365-Filtering-Correlation-Id: 18fd28ac-72e1-45dd-d888-08daf2b8dbf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YxZLjDWwUbEijvb/F1t+fYBtmLxwetF4W4I0KLVyZFGER2TZvwguctj7GswIGGbsgTrgzdRYlZxHVrOle+5rscZEM848b/qGPjLiGNyZc+1cKQ5Sk6b6Zm5q6T5Di2n7kw8vVRhsXD58/Lc8J4WE8olNQQHNdkY9LKg/O02eIr+gMcLDAsI0C2a57P3tv2FWmS29A2/ZFFJkD8OrLNeUCIPAk6wCOZHTogj3zjkluCwBLqvi76AQWXaiB3OC75bPM3vvm7pyF9IM+P0JxHRdgfaRJhwNiJmmNg/YpuVPXwBiV8+daAkFLvRMGTwHL5j2KN9yvV2sxYkZUMfas/3z4dwaMy6U/rbaGeU6UkMuP6cQCOw+Ygzk6Pum7DIs4kgJCUfMDWuw3l5zI5TsCQ5Wd4w1RpJHhRCnGiC18QdFW3JfZHNW5HjJHXYwpLVjoojeNdyT6LiCKD32OWCVwbJy+BabeVHdY0Ld66K8pKeo/CIa9XGvus6FrUio+cjl5dh415wRgIiR8qtJDqsG3WHnIjR41TKJH0P1o4L7zUvkowgZ6ozY/Ok0HR+XRmAnpMgea343zJ2hILbQRsTYtrbSwWSd5DMq182DV70appczke4CTmI3f0K6hUXlvHRyotvIBMjd6OBLcdy55YQxuUXiO3+SnZLHJDmgiDNlq6zOb6fwHluMUrDfj6xtFL2G2PNuV9TyWtn9mktJyzWrRDDPGN62zZqwKq6C3ej/Ykgh3ZQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199015)(8936002)(2906002)(5660300002)(41300700001)(8676002)(66556008)(316002)(66946007)(66476007)(44832011)(26005)(6512007)(2616005)(38100700002)(31686004)(86362001)(186003)(83380400001)(31696002)(36756003)(478600001)(6506007)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlFUZ1pRVk9HYjJNUHg1V1hQMTNGTzJqVnRUZWh5emtoZFVsZCtISmJ1YXNQ?=
 =?utf-8?B?NUMrQXJQU2x2eHk3Sno4Q2IraGJOWm55cExqTWFRUWt1Q29ORWRrRXRoaTJa?=
 =?utf-8?B?VXRZb3hOYm0ycE9ycDQxNGQwUTUvVm8zbFVsTGlKRy9ZUzIvTEVuUW9valFr?=
 =?utf-8?B?RTUySjFtZnY1Vm0wd2h1VkFBNWdYTnIzT0FVZ3NqK0s2NnBVZjFuRmxkMHh5?=
 =?utf-8?B?Q0V2N3hMbDFPSlNWaUtab0l0VHJCcHQvT09YZGZibklkendjZ3NCZk82RjlV?=
 =?utf-8?B?d0gzdTNnU0EycFNlUFR6eEM0NVVMdnJlMUFJa25tMmM1ZVNNYmhPWTJPekZu?=
 =?utf-8?B?TXp1Y1MxMldxTHRnUkNkd01RWWxIRTZPUks4VmlNZ1pEb3JkcDlHd3lRbTJx?=
 =?utf-8?B?WmIrcThXdnJtZTRZaGJMb2VTbHBjN0tmL3RHeno1dDg1a1hyRG1HRkRyQmph?=
 =?utf-8?B?U2lVUFIxRzUwc3NORFVvcjFkb1FWcWN0TEVJNmRFS3U3WWtSaVA0YUFUOWxw?=
 =?utf-8?B?YjIxeG5BeEhnUE00Q1RTeUxWa1oreDRheUNPbzIyMWk0U0JjU0pEei96NWtC?=
 =?utf-8?B?ZmxyZ3BOQ1ZvWXpoNGE2elBRTUVxL2dqRksyUDlORkRtanR3UUVsMldwTnpB?=
 =?utf-8?B?L0FVVjA2QzZZTWROSjBiVXhjbmRodmlOSU93WUlEL2ZSYndPK3N2Rm4yeXNi?=
 =?utf-8?B?M1ptYndCNzkvMmpaTTNFMDhyNlNZdnl1OUlvSVZES2EwUHI0d2ZYZ05yRDUv?=
 =?utf-8?B?WGZFbWtWNXB6Z2hKa3FXV3djNDNGVDVxYnJCd1BZckI1Q09HU1hFc1JzbXZ4?=
 =?utf-8?B?cE1nVTI3bHpybXdaZVlxY3pXdWZLYXhyNDZzQTZ0TUxMWjdLNTJyK0FHNDhl?=
 =?utf-8?B?RDNIMUNjblVvRFBrUE1XVVcxeG1vUWQzaDdnRzJkRXpOWndyWVRtZThUV0ZC?=
 =?utf-8?B?bEdJYUhJc1JIZzdNUURHMFYvb0pvdmlFYzJlYTY2TG04M3RmQmxOaExtdXI5?=
 =?utf-8?B?YTVucUo4N0tUNldFVUxadkFJT3dvbVR1aXZhV3ZoRUNaQVVGTHhsL3pWWk1W?=
 =?utf-8?B?eTYzR0tnR1E0UWg5d1V6SHRGanNpUmJGTmpxZDZzTU5PTW5Qdkx6S0oyM3d1?=
 =?utf-8?B?aUQvTFMvdHAyMURKK0JrbFFQQzhxeWtPVFJ0TlQ2N0xGK0JiNkxIRnVxUzll?=
 =?utf-8?B?djVldlhYNGEvV09ndytIei9YL0wyc1lKSG0xVzJUSmxLK3ZGUENpK0pGUjFL?=
 =?utf-8?B?WXhGV3ltUUl1N2F0L3ZBSGRIdEdNMldzQkc0ZTFlM3ZYaFlLV3R4YVFXUDU3?=
 =?utf-8?B?K0VoMkZaWDJ5SkhDM0Npbzh2TlI2QmVMRGdYRjVDTjUybExuUVVuaVB2TEZY?=
 =?utf-8?B?MW5zQkVtZksrNzlHWS9MQUJteGJEaFBvTXFZR0hTay83MExNUjNwZUlZZjk4?=
 =?utf-8?B?MWR6b2E4TG5wMjN0RkpOMW1welpaV0tlUmVhYm1nbVIyaXVEdHQvTDV2aGxx?=
 =?utf-8?B?MVRJdFhPVG5BS3k1amVhQU9CdU5xQXFpUXlCQ1NnVzBYTE55Rys4ZE9MaEFs?=
 =?utf-8?B?dGt6MnhqV3Y1OU1HUk83b0VnUER3dkhaRGtyQjN5TkhnWU4yRzNpYm9QS1Mx?=
 =?utf-8?B?QjIwaUlkUHE1MkxPV2J3MkRVVjZQRVk1SUI1Mk0xR3NkZHMzNCs4L25NQ0hl?=
 =?utf-8?B?UnJFemFOQS9kQmRTNTF2Y05rUTFvVG1rRFNBR3JlTzBxekZWbUJ1Y25KSklX?=
 =?utf-8?B?V0FHQnB0WlVlQmVPa0E4blZVZnNPOW9wcG5KUDk5TmJBWnpVQk5iUS9pYmI0?=
 =?utf-8?B?QlpyM3JmMCs1bUxCcytWS3dBcm12Ni81ek9SMWdEaFBqcHVRMHBRZ3M5T2Rs?=
 =?utf-8?B?eVZHM0NrdzNDWElrc3gwSk8wRHRpZUIxTzduRXNGcUM3NENLMitEUlBiL3dX?=
 =?utf-8?B?aXkxYndzcEsvU1Bud3BZa1hoaHdrUmxiRis2R2VmcHk1MFY4S0g0M2o2cXVL?=
 =?utf-8?B?cTk3ak9EdzUwOG04anpubjA3SzYySnpJK0R5Y2VqUUhOWDRDc0RuOG1Ob1F0?=
 =?utf-8?B?d005RTN1Z0ZSS1hCMWlHa2VKQ1pnVUkyN05WYkw2Y1JVUHRXYjNsUExKeEI4?=
 =?utf-8?Q?ukDy+GE77XN0VPbBt5SyjhNfN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18fd28ac-72e1-45dd-d888-08daf2b8dbf7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 03:15:00.6734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PS9nax/GwF0DMLbsp6HCn5KPSY/K9KXCo589tvRlTW8xzUYw/0GoH3U3+9iauw35j2kpvl6JR0RlrKaipxp6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7145
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

Am 2023-01-09 um 19:01 schrieb Philip Yang:
> Use page aligned size to reserve VRAM usage because page aligned TTM BO
> size is used to unreserve VRAM usage, otherwise this cause vram_used
> accounting unbalanced.
>
> Change vram_used definition type to int64_t to be able to trigger
> WARN_ONCE(adev && adev->kfd.vram_used < 0, "..."), to help debug the
> accouting issue with warning and backtrace.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index fb41869e357a..333780491867 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -97,7 +97,7 @@ struct amdgpu_amdkfd_fence {
>   
>   struct amdgpu_kfd_dev {
>   	struct kfd_dev *dev;
> -	uint64_t vram_used;
> +	int64_t vram_used;
>   	uint64_t vram_used_aligned;
>   	bool init_complete;
>   	struct work_struct reset_work;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 2a118669d0e3..f23d94e57762 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -151,7 +151,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   		 * to avoid fragmentation caused by 4K allocations in the tail
>   		 * 2M BO chunk.
>   		 */
> -		vram_needed = size;
> +		vram_needed = PAGE_ALIGN(size);

This only solves part of the problem. size is used in other places in 
this function that should all use the page-aligned size. I think we 
should do the page-alignment at a much higher level, in 
kfd_ioctl_alloc_memory_of_gpu. That way all the kernel code can safely 
assume that buffer sizes are page aligned, and we avoid future surprises.

Regards,
   Felix


>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>   		system_mem_needed = size;
>   	} else if (!(alloc_flag &
