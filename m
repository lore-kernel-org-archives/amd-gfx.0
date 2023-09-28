Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D457E743C4
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Sep 2023 21:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C8B510E6B4;
	Thu, 28 Sep 2023 21:50:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5479910E6B4
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 21:50:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLrfb2T3oZ1mF9UZd03/FOkXhtjPgktFKzFXmfD6zSGSMbYsLF4MurIiISdgCPwjtIeIcP10lVncY43BhmcHhoAgmUJunJsi3gHxVZ8m5fccxlD26KN4fC4R5cU+lGSk02ORLSLozs5GTklAJ7PlYNZR0+2fCYSlOcHJReHA3TQ6vGai+8gJbsgU445nYOl4LKa3D0+jeL+atDjfvnFIn6cioXhamoTXApMJvfj1KG4fqQLqBnyBpIKiiRBnHfyFLNXwAC13zcOzFQjbJ2n+R84D6LWOhw2P1qjGIgxh6/J2HghJk1PXYNOnIXlqV22JOBAtcGGTnTF+bKTvszHvYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5ViNiKbNHYwMSdsKiJ84JsSoMGbYcrYJ93zD6WndGQ=;
 b=BfnsyZ+MiIwXiNKHYKG90aTjEr/DvqOJPKCUYSaMMbFSOs/jCTLA50oN7peOXjwCRoGM02+hIKCL8GIOtAEY1kuU1m8Xl2QvFS2mKjU1uR5Z1nEH8oCNt4Ph/3v1dzFi2h1G9Xmjsz5OrGrGvEvjBPwmqzkQDPc8dwwGo14gSK3yLVTtYDq21cMGE2oyDnzMiZgiPhjZ2hRY027NuzPWRnknzFRH0Eb7cEHE7m7oVi4zjetppduyBQ9x1sm2q0ZTr3+tOClHGd7OjPGMXhIRxznHpTYG7NBrh2/ZrYHaHQ1WRFTnZaN+mp38qUzyl046U4pxuP7uxbdwsnP1PW4NOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5ViNiKbNHYwMSdsKiJ84JsSoMGbYcrYJ93zD6WndGQ=;
 b=YztXeHKhyMwzDdjrc6NfnGEya8SVyO9iJjRP/eFVqIslR/um7x3rQVqR9Q7PZSF85chBw0cOm9X7+1FTKFQE+Xzlt2d2nL4wLXDbxfuIkPZ7qnO28Jwxd+vIo3A63ZCWHaniy0qgoAzAjx6/gWlAQ5A0LtWdWi/ahhJbh063kOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH0PR12MB5677.namprd12.prod.outlook.com (2603:10b6:510:14d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Thu, 28 Sep
 2023 21:50:28 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6838.024; Thu, 28 Sep 2023
 21:50:28 +0000
Message-ID: <31e7dded-f043-6e80-f993-e527e423814b@amd.com>
Date: Thu, 28 Sep 2023 17:50:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/amdkfd: Wait vm update fence after retry fault
 recovered
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230922213759.20904-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230922213759.20904-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH0PR12MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: ae027625-1ed1-44e7-b889-08dbc06ceda7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zgzov8MWqWSE0qqpHmHY1xdIbHPIhKUoqwxHB7JkTH3DEY/X/vP/pb6IHLV3UpDwDXPH5W7Z1/3n/iTNh7JLLi3NG+1IXxh+PyLREfMKztU5XcIz+oEAicl+dzUcNKSESFX2A8wEIuqTA05SqqT+tJCau3pkxSYWFhYeeKkv5mBego90Qld9cpzkeSHahmbZGn+iAmhBdG16a/T6rjWRJRPz1SgUwmzyB8tgnxFY1NkZLpoyBn0OTJNnMw0UqpldeBeG2zoafhXB4KQFPK1UWd/u2ZoYOM2ouCCopEaBSPzGZbLTG2PRRjkNo7WSsoLqJ1TcXiXt5QXqreo0a9H4M1EgyEe13cpI5iUl6+CoR9ymEhjp2oIXk9PFGQHtHrDpNFrVTEfq5Hk/5Z70uEnRvAwt5yYzImUGABApfphNibUCojJwwQgWRU6D+dT6CORBFZv2e71eBufPFoy3JFM95NL3HJD1CNiaSKFxqaMAtsUV2gIDh9gcm31IJZL70BQqfvD++mpBwtNxsUL43gcNIdcZy21MIm0q84W02JmtZnFCZUdc6LtmkHn/GHuMWHxAFB1F9YBPM8ZcJilnvvizoHNvzE3yo9vDWQt4z7ycqoe/xYN2JcMAO82D3N2AumkJcPmFPm1cKCq73OhZP4LFHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(2906002)(31686004)(15650500001)(5660300002)(8936002)(44832011)(8676002)(316002)(41300700001)(66946007)(66556008)(66476007)(26005)(478600001)(36916002)(6486002)(6506007)(6666004)(53546011)(36756003)(83380400001)(2616005)(6512007)(86362001)(38100700002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnduM2NFaTRzWnJoZUNyeENsQVE1aCsvR0NhU2FHY0ExUU8vczhTTWdaazMr?=
 =?utf-8?B?Ky9RaWVzeGVrc3MvWG5pakowb3E3R2dHOVFCYkY3emNwK1RvUUlCdXNYT0Nv?=
 =?utf-8?B?alF0dGVlOUZFb2ZndFIxYVA2VTVQRUVLYzZkREhxVFdpditsbWVudEZxclk0?=
 =?utf-8?B?K2RPR0lGbE5aTE1kU012cnRxVVlFNGlGNW5sTHlhSlRQNXdTVjNML01saGp1?=
 =?utf-8?B?bjNkcWxBMTFlMkgzZmxGZ2ZWK2dudkd2eTl3T1RmMGVkV2kzNUp0V3hXV2lp?=
 =?utf-8?B?bkU0OGIzU3dLSWlHb0pGcGl2ME80Z0JUeVF0U2pMcUw4bUFMOTdZQ2pHRXFN?=
 =?utf-8?B?OGlKeThnSUxWQ01TREpBcUtIUWRhamdyR1lEbjJRSnRLOXJqQ1JHUnBPMHhq?=
 =?utf-8?B?TnNvS1cwa1ZYWlNSellnZFY4ZVFESURFZ29UU0txZkgyam5GOFdxYmNyVnFS?=
 =?utf-8?B?aG5ZU1NvMFhDUWtWZmZYMDFyS2NnaTltQ2VLbXNzejBJeHVNTUozdWhVcFp4?=
 =?utf-8?B?TW5UdVozZkEvTjVmT1BoZ2FZVzhZS0djVVJmL1VyT3lHUUNNL1RyNGxCSEpm?=
 =?utf-8?B?bWxCakExL1hNWUl4ZzZ2NVpoYytyNUNRUEdhL1dSQ0VCdDdwaGE4L2twbVhs?=
 =?utf-8?B?ZTdQVnVIenRIMkNvR3pVU2MwN3ZhTG82ajNib1BSU2tFVm1wMXR0MGowL2Yy?=
 =?utf-8?B?Yi9GelFvd0Y4QTB0R1JZWUJqVUxvNklBbURsMUI0ckpJYzVJYWZub0ZnTDZE?=
 =?utf-8?B?YW02eFpLb1VUcmZnK2tBN1d3SmpOUCtaOUNRbDhmWkZ2Z1FwZTlteDlvYzU2?=
 =?utf-8?B?T3VRbzVjUmZrNWJJS1FBV1l5eTNYc1QzR29rOTBBTVc1dnp3Z3F5c1pjc2FT?=
 =?utf-8?B?VEdrYTF5blVIQWJBNzBJbStvZU92U0RVTStUR3BySmkwTVFYWGN2MitwSEpp?=
 =?utf-8?B?bE5qWml6YlU4ZHhXSGs1ZnN2NEVTd3p3MVVucDlFdG5tMFVYaml2WlNNb3do?=
 =?utf-8?B?bG1HTWErQnlWcDZBY0ttS2hTWkpyUy9uNm96N0wxMysxaWVBTGZLWjQvb2tT?=
 =?utf-8?B?MDVsSUNmVGVsOWQ5emI2dEZneXE1bG5zNkh4dXZnSzBibnQ3bW91bktTTmZr?=
 =?utf-8?B?WjhMWko0OGthR0pxU3BTbStkdHlhNW5mVFNpdW4wNzJTZFdaOVE1M3JXNkNt?=
 =?utf-8?B?VjVkeEVaREZLQ29HbnNIT3RjYWxVM2Yxc0VKV05SY1BmU25GYTVzbDF2cDMz?=
 =?utf-8?B?ektrQzVORXdTUnBRTzZVbTlLZ3FqUlU0aUoyVmQ4eEtBNXI0M3VxSEt2WjEy?=
 =?utf-8?B?ZXQ4ZHlQU2hKckJnWXVaTW9DUUs0L05DR2I5Ukp5N2FvWkdzaUJxdVZBYnZa?=
 =?utf-8?B?cHQ4T0VxWkUvcDB1anVBWUtoZldZTlZOK0xBMis2dXFhK05GRWdrSHhqRXNR?=
 =?utf-8?B?UlZTUy9zY3dCTDNSU3dzbnRNWTVQUmI0ODkvenhhMC82ZmIyNWRPVlVIM1VS?=
 =?utf-8?B?NUdTNmIzbFVCVW1UU3RVYklGYnRGdlB3UXVYMU50Vjg3V3FOQWdXK1F6SXVk?=
 =?utf-8?B?YzkzN1JXdWZYeFQyUk1UWlF3bGljQzRzc0lXYTN4aHZqSTFWeEQ0S1ZIY205?=
 =?utf-8?B?Y0RaMDgrMFBSdVQrbjRSeXdjK1p1SERWcUYyREhBbkxrUUs4TWp1cVBCZUdt?=
 =?utf-8?B?Tm5hQzdMcERpd2lmUXBDTnIwajRLbzBmb1hHOXpDSStlR0FGNkIvSkplRFVG?=
 =?utf-8?B?WDZEUHVYMnE4TGFJTlJtR3lHK1BKSkl6Wk8rODFjaThsTm54clpVeXdqTzFD?=
 =?utf-8?B?Wkh1ZC9JaTNNQjFTQ0NFSmo4Y0VEaVZjNFVWQS93eUNaTjNOcHdXNEtyUDV6?=
 =?utf-8?B?UmVJbDNzSlFVajJpMEYvVnlkMGdCYkl2eWJocEtRUWZsbXhEOGZIbkNGaTNN?=
 =?utf-8?B?YWJ4TmRYWUFpS0YvTFdCV0ZUOGR6d1IwOWlRQ3pUMmd3ZVAxVllPYmlNSEhv?=
 =?utf-8?B?OUs5RFhhazRqWG82aDZxc1Njd25kQnhOQXZNNnNaVVBNbVRSTGtBRGVITTl4?=
 =?utf-8?B?cVhrYmNCZ2I3bTVwU2VueWZzMGRwVkxXdHVvMjB0UCtrMEFOWDJtbHN0S3M3?=
 =?utf-8?Q?PQ+hhnePfODhjHL5RzVxFBaEh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae027625-1ed1-44e7-b889-08dbc06ceda7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 21:50:28.0252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84SRWlb8RiRuPweah62Xc85Ku/B+b9VpP+Ztq7jeLAQv5WxnP3KYmp1dLeRBpmlOtQn9lb69rCB3htQZptXgtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5677
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

On 2023-09-22 17:37, Philip Yang wrote:
> Otherwise kfd flush tlb does nothing if vm update fence callback doesn't
> update vm->tlb_seq. H/W will generate retry fault again.
>
> This works now because retry fault keep coming, recover will update page
> table again after AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING timeout and flush
> tlb.

I think I'm OK with this change. But as I understand it, this is really 
part of another patch series that depends on this fix. It's not needed 
with the way we currently handle retry faults. Am I misunderstanding it?

This is not an optimal solution, but I think it's only meant to be 
temporary. I think we want to get to a solution that allows us to 
schedule TLB flushes asynchronously using the fences. For now, the 
impact is limited to small-BAR GPUs that use SDMA for page table 
updates, so I'm OK with that.

Regards,
   Felix


> Remove wait parameter in svm_range_validate_and_map because it is
> always called with true.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 70aa882636ab..61f4de1633a8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1447,7 +1447,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   static int
>   svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
>   		      unsigned long npages, bool readonly,
> -		      unsigned long *bitmap, bool wait, bool flush_tlb)
> +		      unsigned long *bitmap, bool flush_tlb)
>   {
>   	struct kfd_process_device *pdd;
>   	struct amdgpu_device *bo_adev = NULL;
> @@ -1480,8 +1480,7 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
>   
>   		r = svm_range_map_to_gpu(pdd, prange, offset, npages, readonly,
>   					 prange->dma_addr[gpuidx],
> -					 bo_adev, wait ? &fence : NULL,
> -					 flush_tlb);
> +					 bo_adev, &fence, flush_tlb);
>   		if (r)
>   			break;
>   
> @@ -1605,7 +1604,7 @@ static void *kfd_svm_page_owner(struct kfd_process *p, int32_t gpuidx)
>    */
>   static int svm_range_validate_and_map(struct mm_struct *mm,
>   				      struct svm_range *prange, int32_t gpuidx,
> -				      bool intr, bool wait, bool flush_tlb)
> +				      bool intr, bool flush_tlb)
>   {
>   	struct svm_validate_context *ctx;
>   	unsigned long start, end, addr;
> @@ -1729,7 +1728,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   
>   		if (!r)
>   			r = svm_range_map_to_gpus(prange, offset, npages, readonly,
> -						  ctx->bitmap, wait, flush_tlb);
> +						  ctx->bitmap, flush_tlb);
>   
>   		if (!r && next == end)
>   			prange->mapped_to_gpu = true;
> @@ -1823,7 +1822,7 @@ static void svm_range_restore_work(struct work_struct *work)
>   		mutex_lock(&prange->migrate_mutex);
>   
>   		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
> -					       false, true, false);
> +					       false, false);
>   		if (r)
>   			pr_debug("failed %d to map 0x%lx to gpus\n", r,
>   				 prange->start);
> @@ -3064,7 +3063,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   		}
>   	}
>   
> -	r = svm_range_validate_and_map(mm, prange, gpuidx, false, false, false);
> +	r = svm_range_validate_and_map(mm, prange, gpuidx, false, false);
>   	if (r)
>   		pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n",
>   			 r, svms, prange->start, prange->last);
> @@ -3603,7 +3602,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   		flush_tlb = !migrated && update_mapping && prange->mapped_to_gpu;
>   
>   		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
> -					       true, true, flush_tlb);
> +					       true, flush_tlb);
>   		if (r)
>   			pr_debug("failed %d to map svm range\n", r);
>   
