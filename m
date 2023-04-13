Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6EEC77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 20:08:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99FCE10EC25;
	Thu, 13 Apr 2023 20:08:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9378A10EC25
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 20:08:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNfsRN7VC1X7BDoH2LhrnLI4wZ7UO5kfih0VFbWmXnJM2KfFhKzEaFHZZ0JMKrIzvqn+KD66S99l/8GoSiDWQaC+U1cEHZZF6yJ5ce1o5Ir3tBcYDH/S3hJmjiEm1k2g+x2B5h7G5CYASMBeP03c6PQNwvEpop9DYtzOLR/igIbBQRJw67oq01H9LrOatGtMbqCXDm7EH+hs+EfXrPtYnkpEMSPWS/LMfxDLkqzYhqWXe2UCzHs/iWTRb9BVGyQ4fawqShS/IEOmVEGc30kmIoemTv85KmZsjtDmoP+rsP1Qa0IE1WFVOEX5fiD9uHKbEhin5p+wkytK+SKeimHP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4kL15NnoNhyU++agUhQgmHkzQ+aiCcBFuMN6hlCDWw=;
 b=TB9VsIkvpLKMgAHxI2h5N/9k5Gzp0RxksFkZOSbRtrNDhCPCxZVDlomY9gUahGnY0YfFQ6WWRte5cjTnrbPopZuJyhNaYJUK9AF2MbH2dr88eeSvq4Pa8t5MTLct+heDOhq+msTqM72HF/NOHP0Z3uLJQwHlvxCpeKCKqOO2q69RSFOT+dlpz426OtTfOqbuEIOVIPatfIwuJnq6X/x/9Y1xz3aHCoENCEUeSyXOnaPKr5XiqKlw7k5pmPhXCd9QxI9cUO/jieUjvUs/uzq//LChk/PWa1aaTxm7K+/lm8P/GnsdyMb34GXnQPF2FolXetePlEOVAWY5pMh6LkfO0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4kL15NnoNhyU++agUhQgmHkzQ+aiCcBFuMN6hlCDWw=;
 b=q+nQfzw0IfOQl0wZF2C3V+sUVGv1elTn9iArHNq0ov9XmRRQc0uVl4Ay6EuUWl5vW7IdEu9J7GPZ4k0wA+X25jvQ2/vBwOL8WGbqlaPmdzrRQb+VvWMQpS24v+p7hvMjSxbb30yMlrd+AOgWve0Y9dzHqRicJ/OhfY4dwMxzVBY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB4407.namprd12.prod.outlook.com (2603:10b6:208:260::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 20:08:52 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%6]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 20:08:52 +0000
Message-ID: <aa76e51f-8343-a1d0-a4a9-8f1329288535@amd.com>
Date: Thu, 13 Apr 2023 16:08:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Fix some issues at userptr buffer validation
 process.
To: amd-gfx@lists.freedesktop.org, "Chen, Xiaogang" <Xiaogang.Chen@amd.com>
References: <20230412061432.207610-1-xiaogang.chen@amd.com>
Content-Language: en-US
Organization: AMD Inc.
In-Reply-To: <20230412061432.207610-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN2PR12MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: 247b6966-f6c0-43d5-2faa-08db3c5ae6c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WuZSsI4GWqQDBzQXUsHybQlRQ3aRvJj0dhNJhn+yB9FC6CJVTYkyW/wNTRB30ao5DUibwuoetV2Ccl1Kw4d37iEzOGm/d07OswDj1e9jWKzUSkB2aoILf2bf2hsu8QxuGk9apLQKfFc5nc5VCdz4IziBQrKPnRo+eIO3GwOvSQrLLiG8bqB2u/kIqeZ4rSIjrkKh7KUf8IFY9ev/YctJ0oBec20THmnpkuIFs6FLjVpw3V07rjY3LcOKiyONT4RzjPDjpsuWu602qAkRNFgpOljte7KhEgholsS2HHVENgcAstEcbvB3yQOitYUeTyVR+0vECY9kJCB/34N6+MvT8DntXoBr0xytpEGkhydOXoioSRFicMqWbn/T/8NXJnvUctGI1yQTsVkI5frSjDheVkI1lGZJVr0MNVKm03ZBrgkniqnPpj6G/Sg0WazMMkZBgRRsr8982FHkI2P3BI62rn2ulSak5fGdgYDQxIvG9jY2imjQP9msbOSxY3YBSr+116toiUSjxKzfNNU54F05VkwQCUUauP3BT7sXRuSXHNTqfD28zuC2/RAaiFa4lZnPZuUPbcwQMIQ55YeFYugQ8DaknuWPUTjJbZOE1ddhZzfQ16MA5HkMraB5X4sLueaEmo5KL0KhEHIwxG7cLclUvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199021)(316002)(41300700001)(26005)(6512007)(6486002)(6506007)(36916002)(86362001)(38100700002)(186003)(31696002)(2616005)(36756003)(83380400001)(66476007)(66556008)(66946007)(37006003)(6636002)(8676002)(6862004)(8936002)(5660300002)(2906002)(31686004)(44832011)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0JoZEJsZjMwMWplT0NudnZ1SmtNRnowNENvUDZ4YzNkTlZLem50ZklETWtu?=
 =?utf-8?B?L241RThOdlEwRnlqSk45S0tRR0UvbVlCNmtJLzBCSnFpOE5HRVQ1ZmdGNEpH?=
 =?utf-8?B?K0g2eGlRZ2N2dHBvMzYzT0pYQTdJR0RCR0pxdVhaQnBELzN2SzkweEswcEJ0?=
 =?utf-8?B?aUhvUlNRQUpmRkZrNlJKV1FZc3VlKzFCMHI0cDc1MmgrcVJMZkxJckVMYXFP?=
 =?utf-8?B?d2VqVDFLTzdoNnFqSTVqSjA5c0JsOVFEOW9zakVEQ25RQ1N3aFRKbXVqanNt?=
 =?utf-8?B?WmZEMkM2WVZyQW5oVjRybGNPMjR0eTNuR0hOdW00WEI1ZUpvc2RjNmZucDJ4?=
 =?utf-8?B?a0JIdE90NlpCbTJwYnVCWmVZTC90cEFkNnZoQTZQY01JcEk0RGxPd29NcElt?=
 =?utf-8?B?eDJPQVplQ25keEFJbXc3TGFMVFB5TUVRU2xWczFBQWxMUGs5b0tnUWtFRXpi?=
 =?utf-8?B?Z3ExWlBicFZGeE5UK2ZaU1BtRmQ2QnVzRms4bWh0aGZMQ1lwRkhvR1BhcnhE?=
 =?utf-8?B?NEYyZ1M5MG95aDEyRmdzbkRxM2xTWEdGZk01WS81NmNSdHgrR1NpYU9Ncmhz?=
 =?utf-8?B?YjJjVW44SlBPY3FvWlNKTXdKMXJjZWVyTlBHQ2pJQTE4bFhsQnJKZlUzbUJt?=
 =?utf-8?B?WlFzS2RtNWU1amlRTzYzbm41Y3JrenQ5TDdjMWw1NXF4b3FoQWNKWUF5Smo3?=
 =?utf-8?B?ZnFwd3BXdW95eVVSSTZ1Y0xhOE0zTnN5c2dPck0ySlkrWnlLdzJNU0Qxcitz?=
 =?utf-8?B?bWNpMzVuVElXdDdVTEd2NGZoUzJ1VDVRWFc3M2NCVFpWd2xVVk5SRjhmcEdm?=
 =?utf-8?B?emYwdmJhLzE1Y0xjTDgybnBNY2ZSbnVFS1RTa2VoZkI0YjNKOW5oMTk4Q1Ux?=
 =?utf-8?B?L3hOdHkvSisxNVkvN3hPMnIyN2N6MUNPblYwOWVhNG51eFl5RzhPVFFYN1hj?=
 =?utf-8?B?eHJBVjZmOVBDVEgzNkZNK2FvcjVhYVo3NDN6cjgxc3RoMElzNXNoelkyVXBY?=
 =?utf-8?B?QU1LeGJlWFBJbEhvSXd2clZUb1pnOXo3TVJ1Q0NiSk5KZlplMmpVV0kxU0RY?=
 =?utf-8?B?WjltYlRHODF5czZtUTZSOUdHazVVY3h1bkxPWkZ3akZIMmdTL05OZEp3bFVm?=
 =?utf-8?B?R2dXelFDNkoxMWdqb0tsSlk3U1VKTTdZNmM2dnhrUEFOR3JHM2prd0g2Qy9H?=
 =?utf-8?B?ODR2NHVOS01uTlZqQWpzaDZjQ2NuaDJmOUw3aHZJYnc0MmIreWJnMTFDVVVr?=
 =?utf-8?B?dXdUb0dIMU9ieXpWRFlIOEswN2F5SHMyZzZFYjcvT0d0TkI5SFFMZnFiSlJZ?=
 =?utf-8?B?dThOV1h2RDNQNjdFVmordDI4YjBDdkxCMThVZlRCRStqdkEwTTgvQml1c3Vi?=
 =?utf-8?B?TWhEUlUxWlAxb011bjhmRWZDYm1nbXhpeXA2TUVOWERYQW85ZFROUlhCS2Ru?=
 =?utf-8?B?VEpwNFl1M1c4ay8yN215N1YyK2FoZWtDT0lSSEZqR1lldEI5cTVDb3dlZ2Rv?=
 =?utf-8?B?cHJxbGdqZ0VwMFA1YytubGxqMHNGVmRZbjFBY0RuZG1CRDNMK1gzZWY2MjQ4?=
 =?utf-8?B?aE1ZdlBkRjBIUzlIcitoWlc2Ny95M1BFUk9nb2crVFpVWGR6Qys4WnY2N2xN?=
 =?utf-8?B?VldRNmFza0M0azI0M280VGNZcGhxbWFGU2pRWFZMcjBIMEdLR2JZQW95RGhJ?=
 =?utf-8?B?bGNyQURMc2VXazVsdFBmR1A3K25ybm5raEtCTlhEU3B2bUZMeGt4aEQvUkNH?=
 =?utf-8?B?V2c1cFBjWXdTcm11QWVTN3oxOGNEVlEyWTQ2THFyK2Z3K2dDLzdxNzdFeWVY?=
 =?utf-8?B?blpOR3ZQeHNxVU5CVU8xQWtvUlFONWxnRDg1K3BkSmdkYytxeXI4OFR6U0sx?=
 =?utf-8?B?U09rZXJYcjNVa3VPdHJyUnlUUUhxMVQ4Sm5maWNZU0J5VytpcXExNjFSVWFj?=
 =?utf-8?B?SXVqam9ad1lReEJkT21Xak5nUldHbW1rZ2x1anlkSWRSTW1CL1QvbVd4SFJT?=
 =?utf-8?B?elNzTDY0QmZFYXFRczFWczdVRTBtTmNINGJqMzdSK0ZHejY3TWlzeFFMUDBI?=
 =?utf-8?B?UGhwV2VOR3VzRXlSZTVOeGRMUEhVNmpBaVJZYjRnS1ZrQTdodEJxUDV5Mzdu?=
 =?utf-8?Q?40em3f8AzEtKrati5vvij1tZC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247b6966-f6c0-43d5-2faa-08db3c5ae6c4
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 20:08:52.0844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWRZpyiXfdimtoULARGAnsvGygDRc+eb2D24OsTLXF1YZrIWXtskseyJeaVCtwW46x8HT0bdNpx5IHh30KwPbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407
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

Am 2023-04-12 um 02:14 schrieb Xiaogang.Chen:
> From: Xiaogang Chen<xiaogang.chen@amd.com>
>
> Notice userptr buffer restore process has following issues:
>
> 1: amdgpu_ttm_tt_get_user_pages can fail(-EFAULT). If it failed we should not set
> it valid(mem->invalid = 0). In this case mem has no associated hmm range or user_pages
> associated.

We don't want to suspend the process indefinitely when this happens. 
This can happen if usermode calls munmap before unregistering the 
userptr. What we want to happen in this case is, the process should 
resume. If it accesses the virtual address, it will result in a page 
fault, which alerts the application to its mistake. If it doesn't access 
the virtual address, then there is no harm.

It's a good catch that there is no useful hmm_range in this case to 
check validity, so we should not warn about it in 
confirm_valid_user_pages_locked.


> 2: mmu notifier can happen concurrently and update mem->range->notifier->invalidate_seq,
> but not mem->range->notifier_seq. That causes mem->range->notifier_seq stale
> when mem is in process_info->userptr_inval_list and amdgpu_amdkfd_restore_userptr_worker
> got interrupted. At next rescheduled next attempt we use stale mem->range->notifier_seq
> to compare with mem->range->notifier->invalidate_seq.

amdgpu_hmm_range_get_pages updates mem->range->notifier_seq with the 
current mem->range->notifier->invalidate_seq. If an eviction happens 
after this, there is a collision and the range needs to be revalidated. 
I think when you say "mem->range->notifier_seq is stale", it means there 
was a collision. When this happens, mem->invalid should be set to true 
at the same time. So confirm_valid_user_pages_locked should not complain 
because mem->invalid and amdgpu_ttm_tt_get_user_pages_done should agree 
that the range is invalid.

"At next rescheduled next attempt we use stale 
mem->range->notifier_seq": This is not really stale. The notifier_seq 
indicates whether the pages returned by the last call to 
amdgpu_hmm_range_get_pages are still valid. If it's "stale", it means an 
invalidation (evict_userptr) happened and we need to 
amdgpu_hmm_range_get_pages again. In theory, if an invalidation happened 
since the last call, then mem->invalid should also be true. So again, 
the sequence numbers and mem->invalid should agree and there should be 
no warning.

The warning messages printed in confirm_valid_user_pages_locked indicate 
that there is a mismatch between the sequence numbers and mem->invalid. 
As I understand it, such a mismatch should be impossible. Unless there 
are some bad assumptions in the code. I haven't figured out what those 
bad assumptions are yet. Other than the case for -EFAULT you pointed out 
above.

Regards,
   Felix


>
> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 45 +++++++++++++++----
>   1 file changed, 37 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 7b1f5933ebaa..6881f1b0844c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2444,7 +2444,9 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>   			ret = -EAGAIN;
>   			goto unlock_out;
>   		}
> -		mem->invalid = 0;
> +		 /* set mem valid if mem has hmm range associated */
> +		if (mem->range)
> +			mem->invalid = 0;
>   	}
>   
>   unlock_out:
> @@ -2576,16 +2578,28 @@ static int confirm_valid_user_pages_locked(struct amdkfd_process_info *process_i
>   	list_for_each_entry_safe(mem, tmp_mem,
>   				 &process_info->userptr_inval_list,
>   				 validate_list.head) {
> -		bool valid = amdgpu_ttm_tt_get_user_pages_done(
> -				mem->bo->tbo.ttm, mem->range);
> +		/* Only check mem with hmm range associated */
> +		bool valid;
>   
> -		mem->range = NULL;
> -		if (!valid) {
> -			WARN(!mem->invalid, "Invalid BO not marked invalid");
> +		if (mem->range) {
> +			valid = amdgpu_ttm_tt_get_user_pages_done(
> +					mem->bo->tbo.ttm, mem->range);
> +
> +			mem->range = NULL;
> +			if (!valid) {
> +				WARN(!mem->invalid, "Invalid BO not marked invalid");
> +				ret = -EAGAIN;
> +				continue;
> +			}
> +		} else
> +			/* keep mem without hmm range at userptr_inval_list */
> +			continue;
> +
> +		if (mem->invalid) {
> +			WARN(1, "Valid BO is marked invalid");
>   			ret = -EAGAIN;
>   			continue;
>   		}
> -		WARN(mem->invalid, "Valid BO is marked invalid");
>   
>   		list_move_tail(&mem->validate_list.head,
>   			       &process_info->userptr_valid_list);
> @@ -2644,8 +2658,23 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>   	 * reference counting inside KFD will handle this case.
>   	 */
>   	mutex_lock(&process_info->notifier_lock);
> -	if (process_info->evicted_bos != evicted_bos)
> +	if (process_info->evicted_bos != evicted_bos) {
> +		/* mmu notifier interrupted amdgpu_amdkfd_restore_userptr_worker
> +		 * before reschedule next attempt update stale mem->range->notifier_seq
> +		 * inside userptr_inval_list
> +		 */
> +		struct kgd_mem *mem, *tmp_mem;
> +
> +		list_for_each_entry_safe(mem, tmp_mem,
> +				&process_info->userptr_inval_list,
> +				validate_list.head) {
> +
> +			if (mem->range)
> +				mem->range->notifier_seq = mem->range->notifier->invalidate_seq;
> +		}
> +
>   		goto unlock_notifier_out;
> +	}
>   
>   	if (confirm_valid_user_pages_locked(process_info)) {
>   		WARN(1, "User pages unexpectedly invalid");
