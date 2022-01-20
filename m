Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D0AC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 16:29:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA98110E215;
	Thu, 20 Jan 2022 16:29:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7CF610E215
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 16:29:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1SzpiOLah3+bjZ9zRjHo1lHea8L2D5Z1BvRrairauQpk6iKHbvTtnrkLxJPlShdEukYS2HLQS16y9HuZq7kxU9hzkoo0nibXhaNVPxbCZDmf/KZkvhEblPKm7Pqz5LK0QrVk964gZZ8ez2loXXciAb3ct3HIATH3APlYw/1JxLrzjR2wjvLgNtAWVD9RGSJe79aLpC/Z9WvAKmdRr4fBFvzSRJ8u1vgzuDKGS6iZ7DRVMJgVd1U13ULl9jXakQcTjIkk5rESViG1KBx5I0xmx2VgM/DQxPW60bOp7fQXt644AC8TLKUOdLYFf/LR8QOnGh8LSMfxWA6xWh4HtUkgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQzax09IWS4YT7CeZ8G4CbxETrNM+cNJPWVu2cURk9o=;
 b=hp7KjqnkMgLpHYJtaNGwoq4SIbo0UJp7EFrsZJoHiMdL+Bwp5y8TxKUGEezq6GUqFL87OZ7z3LqHiw/RCsMy0SH/EO3vcCsuFcXWgiiZU7J1GC88XgFRzD02naRQc2CuOj+1voxegk9fVDgcU5Sx2cdtvmRXprMf/8lFsjG9/tvTjWoch3B9J+kf3zY93dJCeCclKlVOPWIb+/aNrejMkqzjWi5mlUGWNyU3+c0Wu3X7k5nvLBnfeIPPcZr5UVLnI+NsoAcaGJMd0dpKrQyvNMcFOM4VU/ytd0kFqc6ji7kJEgL46L3x0++Du1Xb9XDbr203SzpgQvxR5o92php9HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQzax09IWS4YT7CeZ8G4CbxETrNM+cNJPWVu2cURk9o=;
 b=hQxm4A5Ju+djpWgZke7wEdb/q8DxlFacsy7gN++bW55oUsBfRb2f2W+259Samvam1/h+FAsAljQFKAg48vxpH2bRorypK2hvsSYkxnOFlZxVcuzAL8hjA4Lsx0JT3DR5HoysjvHV3o0PgUZQ9Lw3cwamjHn1BzRRnnSVAlsh2Jo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB2864.namprd12.prod.outlook.com (2603:10b6:208:ac::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Thu, 20 Jan
 2022 16:29:35 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4909.011; Thu, 20 Jan 2022
 16:29:35 +0000
Subject: Re: [PATCH 1/2] drm/amdkfd: svm deferred_list work continue cleanup
 after mm gone
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220119162246.21457-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <9bae3b62-d402-4bf0-719f-61c3cf8bc752@amd.com>
Date: Thu, 20 Jan 2022 11:29:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220119162246.21457-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::34) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2701df89-a62c-4a25-b2c4-08d9dc320b7f
X-MS-TrafficTypeDiagnostic: MN2PR12MB2864:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB28645667DAFAEFE0F849D6EC925A9@MN2PR12MB2864.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OqSORY3SlOk592w1g2oGSzIJjk/qF8nnQlngx3+mI4eDC5mShGM2l120nGnr+7ak+0S/mCCVdN+VPYj6EpgZWLC2i3AYDwmGqy670Il2dPobyQlsjuO0NUhmxS2+JrB9FwGItKCXX+RqPbqZkV8x+mUC+bCcn6NsXHOklxzUW6+EA1U0igavUCvv/Hb83v+EOtOc9qJOw8NKjL003ieloNCz36j4kW3eiugW7j8wdZIvpahHK5LH7pEUvug+EPF3cVa9o7DTLu4jH0K86IfMUP9sZ5QzWDHXg34gdOXttSuOPW4Oioa8P1e+t7gGTb/KPt9YvwfuiPUxxXukU1e38REKAjpypsQ0MY35ULMCdzMrSWN9w2Qrn/jU2QyhitaNTdy+3kVmqxupJMvNFVedZgqmfE+TsQMwmdXpqexOan8QJPMIz+IwQeCpKvSAXEUdQgKyBiSFrCB0DskE2rvPPzR/LiHrlKEsdIDSdwc2CcYofiEvySp+cIIkOohw+H+guU9xz1EzRBbGgNzF59EorSkNQqTq0UfQUuPNZBwOfMpCQzUDjMWKJusJhSHHIiIt/lhuqRXWOejkVWqGUDEPUfNZsXTJGPsKU1OHO+awYkqCEAIU4UsB/lT/pMdtt1XstCk0IjPk0S8wznulYTRrboXilPahzEeEepbO1ssPEy/4YWWrqxED8za81/2I8xwcopIdYi8A/gCvnOr0IeY+VRMHc9OX71MiuUxoDrETP4e5yLKKq6JlHlUZnvtojUhX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(38100700002)(26005)(31686004)(36756003)(6506007)(8936002)(86362001)(4326008)(2906002)(6666004)(83380400001)(508600001)(31696002)(316002)(2616005)(5660300002)(44832011)(66556008)(6486002)(66946007)(66476007)(8676002)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3hSb005YXZndkhoQkJCNnBCL29XYmN4WUNrNCtlMnVJcHpveUtCQXBSYU15?=
 =?utf-8?B?a0IxQlNuV0p2ZjRyVnV5MDd6eXFhQ3R6MC9CdGJuTFJNZ0kxS1RGYVVhNmhM?=
 =?utf-8?B?SmJ1VWFDK1RzSDdLQVhheEwwdlVJVmNWWDgycUR1UTEvbUhwbmd2dUJxSVVM?=
 =?utf-8?B?eTFUZmhlc1ZJR3d6SGhIVjV0TkxPR1NTWTFXRGU5TkpIcXl5TWVvUlNkcm5a?=
 =?utf-8?B?ZnAwbXZEcURwajZuOTRjM0RtM0xyckJUQUQ0QW1tbWV1c2hROEhjMmY2L01u?=
 =?utf-8?B?eDRYNEs5M08vTDg2Y3I2L1QxWWdvVWlLaEVpd2hVWFdTTGN5UCtVWEdnK21M?=
 =?utf-8?B?M0lQUHNLb1RJMlZvOU1ib0h3TWVibDBvMFc3RVlTTzJqMHRicER6SlExVVRj?=
 =?utf-8?B?WkNmZllIbWNrNmtlTnVKdjBrSUExSHpQQXM2MFcvV3FWclRtSUtaZCs1TEFj?=
 =?utf-8?B?bUI0T3ZPQlZFNVpRZ0Q0ZVByK1dLS0QwWEtWSC9yOHVKTHdwTVphWmZaWDJG?=
 =?utf-8?B?c0VGTURqdlNtRllRWkg1Vnc0bDhNZHpyNmtWR3NoeTVMaUhJZjVnSCt3NWZJ?=
 =?utf-8?B?dUswWjJKNkNrMUcrNVYweUtxMTVJU3BTVFJuS0N4UVQ5Wkh3L3g4NHZ3bUlS?=
 =?utf-8?B?UVhVTkhFR2Q3NEZJbW9sMTRrQys4M21xK2RSenQrY1g4NHhISnBiOXlmTkxv?=
 =?utf-8?B?NEtWQWtabU5lYk9qTERUbFdDWGhpd3NBNzdoTkRubElNeXltaHNWU1IrTmRD?=
 =?utf-8?B?U2J4S21HUDRtcFdVVVpBVVdMSUp1Rklpc01VZnZZQzJXcXl5RCtRMmFZOWpt?=
 =?utf-8?B?RFNTUkVhR2FYeDNLclJSY1BsZXJQSkNIVEsrK1NJcmtlWlQwcEdyY2ZYTFp3?=
 =?utf-8?B?SGdMemdtU24vNWtyT1ZKdlMzejRzTWt0a3JnWDJYNVAyR3NxQjIvRGIwdThl?=
 =?utf-8?B?RHJha1cxcSs4UG9rQ3Y1SElyY3JaVndqUlZmSitzU2lxVTVyMDlRWWtubVpR?=
 =?utf-8?B?cnk2WUZIaEUrZFVoOENiaWJ1Ni9LWktWaEgyclNZVWF4dG5kN21pWEs1cS8y?=
 =?utf-8?B?d05lS0RmZ2JqREZkN0hxejVPQUN2cG5JRWpKYXd2WlQyWml3SlcycHgreHph?=
 =?utf-8?B?YUZxZzVidUhhdDNLaDVJbEZIVDlGeDBEeTNrRkRGMU1LOE5mMkltaER6eTVm?=
 =?utf-8?B?bURRV0NocG1TdXV2SXVtelFiN05xYk1XRitMNTh6d3B6UGNIS2JMbUVwOEcz?=
 =?utf-8?B?YXQ3MmF2eWk2azZ1UWFGQ2NDOTBsMjdjM1NkUTlXQ1FzQkcrcXRKd3B3czM2?=
 =?utf-8?B?V3Z2UUdqSEV3cHNaUDUxS0FxS01rTFd6dTlTV0M4a1pKYnJUejhJdVJZVDdD?=
 =?utf-8?B?OHZlams4ZlkrR1ZLbW5QV25MZU0xYlJjRDNnSnRpdjR2a3JnSmVhc0RjYXZs?=
 =?utf-8?B?QmFIbXVNTnJxNldxUmQ2bnFvelNteWxUMUQ5SGpyR2RYN0RjRVlaSjdXUi9Q?=
 =?utf-8?B?TkVQbXRvOE9VaHo4T2U2T0J1RHpXOThYejR0WUNuNS9NMEpNb20rRVJsUWN1?=
 =?utf-8?B?U2NGZDFlbUlyTkd5dGk1RUJVb3RDQlphSEkxRWY2NUpPUFpSSzJQZVo4R2FC?=
 =?utf-8?B?V3BQVjZ4eXdlTnZzeWR3TEprLzFIaGVOOFIxVVZDUjBIOWFEbVl0aWcxVDFu?=
 =?utf-8?B?U0dwWnJPZGNlL0phNmtkUVY0WWVPd1JERVI4MEpCYWFPeDg4VElKRUhKTUNo?=
 =?utf-8?B?VWdOVnZYRllZZlc0MEdUTHlqaWNTSC9EL05LM25MWWo0Vk9jYmJTbTd0bXFB?=
 =?utf-8?B?SVBqVTlrOHUzdmR5QzExSHJsRzJoV0txQUEwKzU0QnlnV3ZIb2YrZTNFdVNE?=
 =?utf-8?B?cHIyakpuZnJJS1pGRytWOEhjY3BhVzZPcVZ5K1lLVU1xVTBZQWRlamFBMzVk?=
 =?utf-8?B?QkcxSmpZUnMvYW8zR0xVdXVSZXZXaHlqY3lsNHJwbFZFTUFIWThGaTFZWUlI?=
 =?utf-8?B?YkdjbDdvM0VydERlNDBIUitGMzE2cXk1UkZ6ZGtIeEFoblRSUS93WXBNWDFy?=
 =?utf-8?B?VDZDb1FqUUl2c3ZEdzFNcDhtbTc3eThPVXVRNWdybjF1WHU0NWxVaUtGNTZw?=
 =?utf-8?B?SjVXSTdBeVhINVhtc3lNQnhmdXdyV2JNV1M5TkZLNmV3WUdCUVB0c054MWNp?=
 =?utf-8?Q?NPTJbotFEhdeFkR2wyqlD9g=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2701df89-a62c-4a25-b2c4-08d9dc320b7f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 16:29:35.1216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1OsjnGcT5c6lAEtkTZkUGKtPSBZAghTmmrV9HEdSTZxDeGA76GkGZwh7DcS/g/HU6Dh/hXbt8O46QiAtdO/2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2864
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
Cc: ruili.ji@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Can we instead take a proper reference to the mm in
svm_range_add_list_work? That way the mm would remain valid as long as
the work is scheduled.

So instead of calling get_task_mm in svm_range_deferred_list_work, do it
in svm_range_add_list_work.

Regards,
  Felix


Am 2022-01-19 um 11:22 a.m. schrieb Philip Yang:
> After mm is removed from task->mm, deferred_list work should continue to
> handle deferred_range_list which maybe split to child range to avoid
> child range leak, and remove ranges mmu interval notifier to avoid mm
> mm_count leak, but skip updating notifier and inserting new notifier.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> Reported-by: Ruili Ji <ruili.ji@amd.com>
> Tested-by: Ruili Ji <ruili.ji@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 41 ++++++++++++++++------------
>  1 file changed, 24 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index f2805ba74c80..9ec195e1ef23 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1985,10 +1985,9 @@ svm_range_update_notifier_and_interval_tree(struct mm_struct *mm,
>  }
>  
>  static void
> -svm_range_handle_list_op(struct svm_range_list *svms, struct svm_range *prange)
> +svm_range_handle_list_op(struct svm_range_list *svms, struct svm_range *prange,
> +			 struct mm_struct *mm)
>  {
> -	struct mm_struct *mm = prange->work_item.mm;
> -
>  	switch (prange->work_item.op) {
>  	case SVM_OP_NULL:
>  		pr_debug("NULL OP 0x%p prange 0x%p [0x%lx 0x%lx]\n",
> @@ -2004,25 +2003,29 @@ svm_range_handle_list_op(struct svm_range_list *svms, struct svm_range *prange)
>  	case SVM_OP_UPDATE_RANGE_NOTIFIER:
>  		pr_debug("update notifier 0x%p prange 0x%p [0x%lx 0x%lx]\n",
>  			 svms, prange, prange->start, prange->last);
> -		svm_range_update_notifier_and_interval_tree(mm, prange);
> +		if (mm)
> +			svm_range_update_notifier_and_interval_tree(mm, prange);
>  		break;
>  	case SVM_OP_UPDATE_RANGE_NOTIFIER_AND_MAP:
>  		pr_debug("update and map 0x%p prange 0x%p [0x%lx 0x%lx]\n",
>  			 svms, prange, prange->start, prange->last);
> -		svm_range_update_notifier_and_interval_tree(mm, prange);
> +		if (mm)
> +			svm_range_update_notifier_and_interval_tree(mm, prange);
>  		/* TODO: implement deferred validation and mapping */
>  		break;
>  	case SVM_OP_ADD_RANGE:
>  		pr_debug("add 0x%p prange 0x%p [0x%lx 0x%lx]\n", svms, prange,
>  			 prange->start, prange->last);
>  		svm_range_add_to_svms(prange);
> -		svm_range_add_notifier_locked(mm, prange);
> +		if (mm)
> +			svm_range_add_notifier_locked(mm, prange);
>  		break;
>  	case SVM_OP_ADD_RANGE_AND_MAP:
>  		pr_debug("add and map 0x%p prange 0x%p [0x%lx 0x%lx]\n", svms,
>  			 prange, prange->start, prange->last);
>  		svm_range_add_to_svms(prange);
> -		svm_range_add_notifier_locked(mm, prange);
> +		if (mm)
> +			svm_range_add_notifier_locked(mm, prange);
>  		/* TODO: implement deferred validation and mapping */
>  		break;
>  	default:
> @@ -2071,20 +2074,22 @@ static void svm_range_deferred_list_work(struct work_struct *work)
>  	pr_debug("enter svms 0x%p\n", svms);
>  
>  	p = container_of(svms, struct kfd_process, svms);
> -	/* Avoid mm is gone when inserting mmu notifier */
> +
> +	/* If mm is gone, continue cleanup the deferred_range_list */
>  	mm = get_task_mm(p->lead_thread);
> -	if (!mm) {
> +	if (!mm)
>  		pr_debug("svms 0x%p process mm gone\n", svms);
> -		return;
> -	}
> +
>  retry:
> -	mmap_write_lock(mm);
> +	if (mm)
> +		mmap_write_lock(mm);
>  
>  	/* Checking for the need to drain retry faults must be inside
>  	 * mmap write lock to serialize with munmap notifiers.
>  	 */
>  	if (unlikely(atomic_read(&svms->drain_pagefaults))) {
> -		mmap_write_unlock(mm);
> +		if (mm)
> +			mmap_write_unlock(mm);
>  		svm_range_drain_retry_fault(svms);
>  		goto retry;
>  	}
> @@ -2109,19 +2114,21 @@ static void svm_range_deferred_list_work(struct work_struct *work)
>  			pr_debug("child prange 0x%p op %d\n", pchild,
>  				 pchild->work_item.op);
>  			list_del_init(&pchild->child_list);
> -			svm_range_handle_list_op(svms, pchild);
> +			svm_range_handle_list_op(svms, pchild, mm);
>  		}
>  		mutex_unlock(&prange->migrate_mutex);
>  
> -		svm_range_handle_list_op(svms, prange);
> +		svm_range_handle_list_op(svms, prange, mm);
>  		mutex_unlock(&svms->lock);
>  
>  		spin_lock(&svms->deferred_list_lock);
>  	}
>  	spin_unlock(&svms->deferred_list_lock);
>  
> -	mmap_write_unlock(mm);
> -	mmput(mm);
> +	if (mm) {
> +		mmap_write_unlock(mm);
> +		mmput(mm);
> +	}
>  	pr_debug("exit svms 0x%p\n", svms);
>  }
>  
