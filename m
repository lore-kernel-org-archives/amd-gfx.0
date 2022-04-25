Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E3FC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 13:48:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A26A810E12D;
	Mon, 25 Apr 2022 13:48:43 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2067.outbound.protection.outlook.com [40.107.102.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8709010E12D
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 13:48:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzbKeZf6XyXczx8gy3TkY5+3Xy9tw0CxxpAhmx9CRe8tSz/NccqStCfO4CTzOf6NUhxig4ym3HzzgMgG2gYp5/CsxBwG0K3Dit+qESEJdu7ppmyFMErbZ7LfLHiVEM6GKeGPu//vcppFvTvJIiFUY6Y8ueTpIVhlU5Bkvrl8S0LbYnv/AUsInOQNLLUqf1Vz7+ZPvcTF3ZNuASlLLFz4Lulr4kVEQ4LsLgFhK3Qq4IOeXyS/wRHdtq8fdT2v8K3cTC9/5YyZVz/sJRlcj5+BGSrHbsZ34kxLpcRJlfGzMp1h+qx0Ug8x5mr/g+TWFZFMwBO8r0IDKSYHlhzPH4JhGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZVrtrlFWraTqyjmWVGuhPxQ4ZNI5G6elGk3O6UlQG0=;
 b=a50SeYWUmjSEkuYsbPgd3Qn3KxfwOnm27RSd5xA9qEMSY5XOlXXpnnRCracZPAu0j3cklBtJVG3WgQjSa37ZKKyfMDzFugNvatki5FhsgJx9S5QBQFziwrwYO5zFxQpYO41D333M0psS0vNtWtApPgPxCKb1ewaPuOsRw1mPao1BTpavVwfU4pYGbTgs8vdCeEbw7mwp63raNZzGjtEPlpw5soAvQ7J9AcYUErkEvXDQDOB8/IdBKqoCwLbJPizwvfBVXXVA/XlI4OhP41+6ZeQ85+aHeS1GZ345xgz/31JkN2qfw5Dla+HDb4GaWP4WeObVgR7hpdz+CzvgG1ISQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZVrtrlFWraTqyjmWVGuhPxQ4ZNI5G6elGk3O6UlQG0=;
 b=vFcq9392qQPvOdqduaLOe6HxLa91lgwLhC6kMULbmYSnPdH2RZ6YoLlMLb506R2HZzVAnwoKGq/kuNGH7D1XnIJSPkYVo7QrRoV7d7Ti1L5FobTo55dxlO14oygGg/42FIeZ5U2pukZL7EWhX/t9HpW9koeVXjcQe+GNoyTft/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM5PR12MB1531.namprd12.prod.outlook.com (2603:10b6:4:f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Mon, 25 Apr 2022 13:48:40 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%9]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 13:48:40 +0000
Message-ID: <9aa87139-fbff-abab-607e-8c8ff0bcc9fe@amd.com>
Date: Mon, 25 Apr 2022 09:48:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] drm/amdkfd: Add SVM range mapped_to_gpu flag
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220420004742.8780-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220420004742.8780-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::33) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c0fc436-203a-43dc-d426-08da26c24e11
X-MS-TrafficTypeDiagnostic: DM5PR12MB1531:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB15318AB4D1618E088AC6AC2192F89@DM5PR12MB1531.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /6k288CSQeqHpTj+nVGCyIydAiSdszEom1Xe6IxyZT8QsNEVoDPbANzJEg+fgX+6EGMHksoU5Ifc4rXeQAnA8I5sGl1r1fD7AXDnhBE6pwCMgmRiqW8p0G0Ube97rF+9fnpQAh7uDbmaSZx9gadPvxfUgEUJshbljiwKXS9tcwjA58Y4245AEizQAZXjSArDiULveNxHOu6UqLjW8eLiEUf30v4hJAYsmFOSApruqB3v+cSkrps/bKW4NQHvse5kT6T8xra+sI/SP+top5xz/HWImXxJ7q4yLS1vDTrp2q0arw5t0YS/mXK5nUhJ6ZXArHpaA2FcL1fHO8vX62xIxFPhMFZ+/sZrlWhHfJZ9RAq3BLh7J0Oa85IeRH5fJKeYGlVBLQuZoYXyVKKgu10G7wqXXH0QdDoZrdibyHbgnVDrLir/sei+qjvg8xc125XNQDbY9WvtpuLgqzRMpEivaiY2JOgX57xDqPj3OS6OFGpcQYo4RNHrR0ef4RwOhOa77yFdoBr7ha6IXIua7o2NrymEiN8PlOZz76+WilC06wa1IY/Xvha+H15thpaRDocbatWV5VnDX/Rdqijb0mHUErCaAsKPc+zddoOEeZt53diYrUEm3KtQJUHB9ZDDClRB3afuiia4vC7gKgk16vEp4H5B8b5tJX5f3GDU3mlUu+Nt3/l5Fw/kl+LlLci4a56jcq+cBbxoCJeMqR4OMNruXlRgugrfhghFJUEJgNVtZAE+IjXlVgAckfVehW+Vrf2a
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(31696002)(186003)(38100700002)(2616005)(5660300002)(31686004)(36756003)(316002)(44832011)(8676002)(66476007)(66556008)(8936002)(66946007)(86362001)(6512007)(2906002)(508600001)(83380400001)(6506007)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V00vOWhrWklrek96RGltbnlEdkJtdllZSGVTQmpCaStMMnJCNkZUTVdBVXYr?=
 =?utf-8?B?TjRHU0N5MXpldVhHdVlVRmdkWmVkL1ZPR0VveVVoY3JmL1d2VEk0UUpyMFN4?=
 =?utf-8?B?dUhkbE9aRGtIb0xwSHNyTm1GQjZLMnU5Sy81MENlRmhWOFhlSmc5NHBzVUc2?=
 =?utf-8?B?ZnJFSUZWS1ZCNS9Pek1TRTFYZ2RPc0laRmoyS0M2YXB1WDNlUEVWczJYdFFL?=
 =?utf-8?B?cnF1UjZVYzFVL0ZQWTFYamtmR0NyaVBzL0NNNlNoZWpFdGlvclhlR01YbFVJ?=
 =?utf-8?B?NHZtQ1dMVURxVGg4YjJmNUpxeTRnUnBqeXBXa0pzVC9sRDRqYmlVRjZBTDBk?=
 =?utf-8?B?V25sQmNja1NuSVd2VHJIMjRhUFJjR2xXelJlWmxUZncrY08zZGtUTVdoTGsy?=
 =?utf-8?B?VzhhVXZLZStmOERHN25FQXg1bVBqdTN1VG9XU0xpVEUxdWJGZWhVcm44OUdV?=
 =?utf-8?B?Sy91akh5OG5WVDR0OEk3WUI3QVM0VHlqU1RHODF6ZW9MNnovaXl1aVNpeFp4?=
 =?utf-8?B?U1Fic1FYaHgxQmZkVFVuM1BHdFl5bUlGUVAwUTN4NU1xR09ySWJPMlB5QU1P?=
 =?utf-8?B?RkJpeVlvTE1PU1lJa2Q1V1VsTUpmTjd6eWZEQlBYZEdiWG1yNVpBNjRyaHla?=
 =?utf-8?B?RUdVSWRkZWNyNk5ydUVzSWtSUTYrUURaMHFXdXpJUjN6ajcrbE50a0pPRHBS?=
 =?utf-8?B?aTJYczNXRHR4RkZta3FYNVNpLzd1ZksyNVIvM2hqUWFYb0ZxVzM0TnpCNDZu?=
 =?utf-8?B?TlFXczdjbXRWYmM2VUl6TkVtVm5Ya2pxa0FiKzd2dytVMW5tcGhYeDlLSXA0?=
 =?utf-8?B?WUFDU2V0YU5NUG8zMEc5enM5OXd6TzhtRWx0bEJlb3Uxa1RRNWxVbTZjclU4?=
 =?utf-8?B?TDFSZ3FkWGJPMW5BWEt4NCtHQXBWeklOSnZPeUpuYTJjbk4wOFBGSzgxTi9P?=
 =?utf-8?B?cEVUeld5K2NHQWR6UldZdEs2ZGlTNEgyRG5zMmw2Q09DamYzOGYzMW1hWEpZ?=
 =?utf-8?B?bWR0aE5vd0x3WVZHeGRKc2grcVRQalVMZlpSQzc3a1JQRGZ5VTMxM2ZnbExk?=
 =?utf-8?B?VHI5OFM5NG5Ka1BHSXZScWJuWE1yRHVIT3g4QXQvNWhpZzFKWWtaZHdVSSs2?=
 =?utf-8?B?djFPb25UY0p4R210elp1OXhTekx1ZUd1NWhGNnlZU0VIMXRUbkpVc2hDbkM0?=
 =?utf-8?B?OE84NFgvNG50UTlTMDhwR1ZRRmt0VkRUVjh0R1gwTFRDZ29Ea3JpYThHaHFn?=
 =?utf-8?B?K2NidVlUNVJ6bjBCN0NlWXFxblZ4QXd0dTNrWTh4NUU4cVNGc1doSnU0cHBa?=
 =?utf-8?B?UWxJUll5ZnYybXRmOWR3ZjJOKzdDVEs2OVN2S29rNFN5aVNCSEZ2VW5tRmg1?=
 =?utf-8?B?NGx0MGRRSEpycGpPT2lpMzlZdk5iZ2ZjNG9JOUxzZjVhbWNtaWV0YVVEZTRJ?=
 =?utf-8?B?d3hIdGpDTFRZL2FQakZ6aTl2WUNub3FBOXArVGRoMFNaMk1FU3hZRCtUWENZ?=
 =?utf-8?B?Y0gvWW5IVXh2OEwybThYVkxyOGNQbHF5UHc3MkRoRGczbEIvOHNzVitsRDhU?=
 =?utf-8?B?VnNlQlhHUEluUERHOUhGZTJNT08xVXo4UVhkRjR6aDlVNGVMdHhWMmQ4Q0ZV?=
 =?utf-8?B?SFZ3TU4vZmg1RS81eVBFbk1GVWFFalUwRzgzTGNDdFI5L0tTTWhqSWhCeXZG?=
 =?utf-8?B?MVE1clRLMCtRV2I4SnlFUGNYbEtFcFY4eW9sYVVCZGdNRW5mMzk3eXpjREdL?=
 =?utf-8?B?MXVGRXdsZFpRbFFJTGJDbWF3cmE4TkNSOS9ycS9HYVlRdmJ3eXd1OTVLK3dH?=
 =?utf-8?B?M2dOREdsTFhyYzduOUhYOG5TNk1zZnBoUDBRWmJTcVc5K2haeXVxVVpYYTlr?=
 =?utf-8?B?T0NxbGp3Q3VmQkR2MEFRblFkUTVMY0ZrOXVtOVlSazlkL3EvTG4zWTVxMEdV?=
 =?utf-8?B?UTloMFd2VFlvSFhKa1hFS1lRbEQySHozdURsZlJ6Q0NYRVdYUW5YUldvQU9P?=
 =?utf-8?B?cCtKS1Axazd2RkxuVWRzTWJRNEppcklvMGxFNmgvaWlxRDJwb2lYQnYyTkJ5?=
 =?utf-8?B?OG9DSWlBUzI4ZHFyNk1aR082bmJqMEJVMmdoalpvOTRnTmZrL3RJWnhlSDZH?=
 =?utf-8?B?QVprdENrdE1Bb3RCdEVnZ01zakNwMDRIQlh5RldjclhMMlgrbmU3TXRBZjdp?=
 =?utf-8?B?ei94QSs5YkxWRWZrWFVmV1NTbEl3b1A1Y0NNOC9ZVGdaRytYVWp6amtlUmdX?=
 =?utf-8?B?bzFuZXBkR3B3anpkaFhPUlBncU9EakpHUmdXZWRXclE3NG9VelZ3RVBMNytk?=
 =?utf-8?B?U0duZTBMYjBPQVBOTHRCM3ltdWRuS2xMME5TeVN5bmdydy9takphdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0fc436-203a-43dc-d426-08da26c24e11
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 13:48:40.3991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dY+4S75Ri1zkxcYqNRcNnYeP4bKc7po/eNKBVX29bP73uVnmNccjPliNHalua9Nt+XHezPhYK1kWr3SxQDnX2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1531
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

Am 2022-04-19 um 20:47 schrieb Philip Yang:
> To avoid unnecessary unmap SVM range from GPUs if range is not mapped on
> GPUs when migrating the range. This flag will also be used to flush TLB
> when updating the existing mapping on GPUs.
>
> It is protected by prange->migrate_mutex and mmap read lock in MMU
> notifier callback.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 17 ++++++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  1 +
>   2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 5afe216cf099..6be1695f3a09 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -951,6 +951,7 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
>   	new->prefetch_loc = old->prefetch_loc;
>   	new->actual_loc = old->actual_loc;
>   	new->granularity = old->granularity;
> +	new->mapped_to_gpu = old->mapped_to_gpu;
>   	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
>   	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
>   
> @@ -1204,6 +1205,17 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
>   	uint32_t gpuidx;
>   	int r = 0;
>   
> +	if (!prange->mapped_to_gpu) {
> +		pr_debug("prange 0x%p [0x%lx 0x%lx] not mapped to GPU\n",
> +			 prange, prange->start, prange->last);
> +		return 0;
> +	}
> +
> +	if (prange->start == start && prange->last == last) {
> +		pr_debug("unmap svms 0x%p prange 0x%p\n", prange->svms, prange);
> +		prange->mapped_to_gpu = false;
> +	}
> +
>   	bitmap_or(bitmap, prange->bitmap_access, prange->bitmap_aip,
>   		  MAX_GPU_INSTANCE);
>   	p = container_of(prange->svms, struct kfd_process, svms);
> @@ -1590,8 +1602,10 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		addr = next;
>   	}
>   
> -	if (addr == end)
> +	if (addr == end) {
>   		prange->validated_once = true;
> +		prange->mapped_to_gpu = true;
> +	}
>   
>   unreserve_out:
>   	svm_range_unreserve_bos(&ctx);
> @@ -1822,6 +1836,7 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
>   	new->prefetch_loc = old->prefetch_loc;
>   	new->actual_loc = old->actual_loc;
>   	new->granularity = old->granularity;
> +	new->mapped_to_gpu = old->mapped_to_gpu;
>   	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
>   	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 66c77f00ac3e..2d54147b4dda 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -133,6 +133,7 @@ struct svm_range {
>   	DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
>   	DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
>   	bool				validated_once;
> +	bool				mapped_to_gpu;
>   };
>   
>   static inline void svm_range_lock(struct svm_range *prange)
