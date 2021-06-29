Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70CAC11F66
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 11:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACD0561DD1
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 11:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD0561DD1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A8606E854;
	Tue, 29 Jun 2021 11:11:06 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37ACC6E854
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 11:11:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4bxQ7okeELLdIvIXeQWIRRxKRVu1iKQKMQ7LXCuHEC3b7BQSKNPeQEgblOCOy+bvOp4hEkSQeg+8zHiuL+2R0y5y3XcGN3tBNFlX+JLXbI/nWoPnx/mR+g7Ju/1RGxhA9IjBI+s69SZV01A2KJPI0rH1AA84afol+rj7621U4lxlj5H2p15Wo02iURSpfzBr76C0Sc4Xu9NZ+KnEYZ5zXcIH+OmXNws84/IYg1vn7I+hkyLehYFDyyBp1SvvF6qrblRyPhAiHDjGlCpzD7pLOx2hRn/UfP+mHhuUqsmq67s/YpZ4wXLqNPa/3F4cjSgQomZnFeR57wxNJeSqjRpUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WH3FORAm31bhJHzFKiHaKaJN0arw6vONYJRcFxW5Kn8=;
 b=ICAdZBMcVJi5lh9QYBfz14CtH19p8DkzT0ZGzINufKy4D5+yBDfbQ/0/lTnI8bIenaW6nA3FVDedoLK+7AgwWQvz0HMMe8/l93BcZ5gC6XCYHcUhT3swnKzFjtFP03kOlM1uquOsVZ9DSPz81Cm4tWKt/n+UDRtJadYn7FAPF4cSXzmQE/Yn3AHSw5eZ76spB6KyJIu8NvTi6Mbr9bQSf3wxvH61coOr3Jq+ZFN8LzoW4wLl7mcK/hVt9JNzc7+RWz6V2nueNjNHe03msL+VJs2k6KcF+S6CCzlqwAYE45dOb8as6alZlGC4GUy4z1kW7o3UNtraJDVg0K94GVewRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WH3FORAm31bhJHzFKiHaKaJN0arw6vONYJRcFxW5Kn8=;
 b=AvEZJIqG0eS2khUsS9QKTIaXn7xIpIlVtsoCSoZCTyEjfYm1imbOotWH3CUG4y1zVacgyY8txW0dZXy78oNAS2Bm432Cb6P4QF8dEP02s2BRGq94SBPaqjtJBsjg7iy+ZNHorUAhLf0pf9DElT9lsKD7DBinmKwLo9Pq9wMbV6o=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21; Tue, 29 Jun
 2021 11:11:01 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 11:11:01 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: use xarray for storing pasid in vm
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210629074914.4114-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <f89e9213-47b6-77e0-20fc-02105e44b958@amd.com>
Date: Tue, 29 Jun 2021 13:10:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210629074914.4114-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:acb7:5516:6a55:2bf5]
X-ClientProxiedBy: FR3P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::19) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:acb7:5516:6a55:2bf5]
 (2a02:908:1252:fb60:acb7:5516:6a55:2bf5) by
 FR3P281CA0028.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.8 via Frontend Transport; Tue, 29 Jun 2021 11:11:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21a93949-6019-43c9-fece-08d93aee93fa
X-MS-TrafficTypeDiagnostic: MN2PR12MB4302:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4302147F590CB0775695C8E983029@MN2PR12MB4302.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HqR/a3ZJPnJ75pvgl9N2YiYQyRDe9LUmfKad20Oh43tN2BLvfsxdyLUVppuy0AeQN3bV5aq5QZZsEw0q1YskwW+nlYoxQSPhjgdqzVFK0JiwKEn7CPvLQx88rRP4ilotA0yo6u/n40BT7bdbCJ48rN8tbeQ0ll0StZ2kBEvZiqR17FUxPW/VhmxpsXwB9lDgWxbSP6yIH5GF9CxHrTdM0jEzYouJ7Btzr0kPjdrXh1yfeosN5o1HRBFC30J+x2/oXjtwsYRy6iS2iZahCvR9G/OozFVhhyfSM1RJta2hlhqbcqApiw+cBLpyGrLpmoKodmaCmUO6Wbjv0hb7XNUKrsd3zysI/pU3IMtRGGtzKMSZkxIgEGKQ1H2APfwFRtPMrFm2Wc3uRiQJxflskHQ//iSjjPWwNuQb+AAVCvvLJgwtg9+d4ntgjRBsHEaxx8/gjIzy8csgzuqAQjD6wfapnBbDlSDC3diwsiB83jbZAbEZSBq7jM0DF+phWvJ24sPNOLzvFFm9tuT3UH+ZUMDNpQ/3/rHvE0+lcftv29aHZ2ztaUNipfEFFkRowgT7YLQVfjYu3ut9zuxJgUknJ57sc1MNmpWine+dNiZ4tZk59pNYQkYdDsVq6c+YLb5gc5ItfIATl3beWQ8WLlAUcZjdVsJile7H+0uHjozZe1KTOCiesbRRhLmWlQDcEYiOljuAU3yhTT9jUlhSvqgbVua7KoiBIM1pNyBjE0kzOZ3qasQnJEcl1grSI9ppL02esH3H
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(38100700002)(478600001)(186003)(2616005)(316002)(4326008)(16526019)(2906002)(83380400001)(31696002)(86362001)(36756003)(8676002)(5660300002)(31686004)(8936002)(6486002)(66476007)(66556008)(6666004)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVEvRk53d3BmNHMxZUZINS8vVWVZY2hYek0zTURqeDVyeTJ3bml1VldkM2E0?=
 =?utf-8?B?Uyszenh5MXI1WmMxakhaNTl5YmowQWZiV3V0Z0VWcWJPTGFHK29GZmNwL0ho?=
 =?utf-8?B?S0xCWU1GbVZnQlVYaEprYmNJUDJwaVUwUEQ4dU5KbmFkRGl4amNiM3ZHTzRt?=
 =?utf-8?B?bTRRV1ZOUGY4dDV1U1YwZ3ZlRXkrT0lWYzBlZ1dpc0NLZFhHZFI1amhVWkNI?=
 =?utf-8?B?eUh3TTcwZGJobGZJOExKUGR4dnN2QkNsdHFkcjFac3BrcXpKS1dEaGMzemdY?=
 =?utf-8?B?V2x0UHJVRUFCNFZQTW8yQWk2K21HWEN6RGlpcWxGNk1DSnZnYll3dnVoTCtv?=
 =?utf-8?B?RG8vVVcwNUtrZHdxWnBqcWpZemZFTTB2OGEyWVpQd0p1QmxRcWZiTkJNbS9h?=
 =?utf-8?B?a1prNmRpVFlqTFdzV1F3OE9HZUtQNVg0aUtiRFhwTjM3VURvc0NMWmdsekFH?=
 =?utf-8?B?V2haaTd3NDczTHJaSWNSVU01dUdDUFh3R3JYK1d2Y2hmbC90aVg4UHpMeWtJ?=
 =?utf-8?B?cGovajBXM2dvY3Zwb1cvaWFJT1h3Z1JzUnBDRnBwdlg3cFJJQWpUUG1sRERM?=
 =?utf-8?B?T1YyaDFNMHpEb0picXZoTmt5Z2lVYk8xa3EwNnlVbERuLzMxWm1LR0ZRYTVx?=
 =?utf-8?B?M0pRSjRjeDRJNm16cXVKb2Y1QVZCQUlSSUtsZEJoS3pTU21oa0JOakZPdGt5?=
 =?utf-8?B?bWxKenRGcjhzYzF2dDI2ZDRJWnVKOTd6T2lJVk0rRXhZR3E1akowM3dSd1cw?=
 =?utf-8?B?cDN1TVIyRURzSEhpRGVhY0M4Vm42ejYrZWdUVHBpc3RjU0xjQ09abVNvRmNq?=
 =?utf-8?B?S1dDUVJFNGJ4OUY2eFBLV1MxcW04czhWUU9nYmRHLys2Sk1qSG0rK0FhRS9T?=
 =?utf-8?B?Y0plVW0rTkh2VEU0bXZBa2EvbXh4TWhKMGd4REpNUm8ydFJXYXRRWXZxYzFO?=
 =?utf-8?B?UTc4VEFIL0g1YW9JUTJpdTVhQm90ZzF0OVczd3JUZTluQkVXQnplaTRTNzFn?=
 =?utf-8?B?OGExYmRuclRvNi9Fd2FFbloyWVhIdDFleUlJM3l1SWh4TDVPV3huS2k5M2VD?=
 =?utf-8?B?MnJUUGhpODhTd2tuUEdETUNWWk95QWVLbUZrOW1kQ0pabWM4Z1J5em91U01S?=
 =?utf-8?B?WXIwek9pek81VHFwWWEvWlh1L2tWZ05sdkV4czI4SWtsNFFZbkJFajBXMzJk?=
 =?utf-8?B?a1kxeG1mZFNMRlUxeWd5NGcxMUtJUTVWLytmMUhFSndEaS9QK2ZFUy94NVZQ?=
 =?utf-8?B?cVdGNFR6d3FvR3I5N1JKYzlsUnQvZUNhaXB6TmNRL0pmcXJVZk1MU2tJUzZH?=
 =?utf-8?B?S2poZHZNR1c3TmVwR3ZNTzI0OXdJd3ArSEFJZlRaRXd4MVlncXhLMWo1Mkx4?=
 =?utf-8?B?MUlaZWpFVnNkQWVVMDJ2c20rSE1pN1BSVW05dDF3S1IzR21NblVwdDZVWEdK?=
 =?utf-8?B?V3BCb1ByY3dERHFzaDRYQnoxdUpyYytwSzNTK3MxNzNJRGtlRWFhRzlJcW9Q?=
 =?utf-8?B?aHhmWkhOU0lublJFdWNwR253eThhNktpaFMwVzV2bVQxcWo5aHN1MXViSVda?=
 =?utf-8?B?N0hWUXM3UHZ4d3B0QXJvT2hSNkVQMzN5OEdLRnJURENrTVg5aUxpVS9vZDls?=
 =?utf-8?B?eFhHQXZDQWMvYXNHWTNOZUFVRU5kV2k1TllzSVo0TjV2QS9iVk1PclN6Zlhj?=
 =?utf-8?B?eEtEOXZqcGhyU3puSktHTUF2SXovQUFpM3R2RXFCVWZrRGo0bFVicm9raVRQ?=
 =?utf-8?B?QTQ4ZVE2TXdmS0pyalU1bVRYREx5RExuUWJodENUcUhlQ01mYUlOaWVRVlI0?=
 =?utf-8?B?S0hSQjBSbUJQV1pwT2JtSWd3dVJDM2ErT2RwV0MrdklDdmVhWHNQcGJlRXlJ?=
 =?utf-8?Q?eYjv/AEMM76qL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a93949-6019-43c9-fece-08d93aee93fa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 11:11:01.1062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GN4Z39nPS6hAcWj72I04mV++iMmmXReghc8rGxXey2R6tvCEtvrlR/dx3YVEijs4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302
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
Cc: Felix.Kuehling@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 29.06.21 um 09:49 schrieb Nirmoy Das:
> Replace idr with xarray as we actually need hash functionality.
> Cleanup code related to vm pasid by adding helper function.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 136 ++++++++++---------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |   6 +-
>   2 files changed, 60 insertions(+), 82 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 63975bda8e76..9b0e8a9d7f86 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -87,6 +87,33 @@ struct amdgpu_prt_cb {
>   	struct dma_fence_cb cb;
>   };
>   
> +int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +			unsigned long pasid)

Proper kerneldoc please when the function is now exported.

> +{
> +	unsigned long flags;
> +	int r;
> +
> +	if (vm->pasid == pasid)
> +		return 0;
> +
> +	if (vm->pasid) {
> +		r = xa_err(xa_erase_irq(&adev->vm_manager.pasids, vm->pasid));
> +		if (r < 0)
> +			return r;

I think we should have a "vm->pasid = 0;" here so that we have a 
consistent state when inserting the new pasid below failed.


> +	}
> +
> +	if (pasid) {
> +		r = xa_err(xa_store_irq(&adev->vm_manager.pasids, pasid, vm,
> +					GFP_KERNEL));
> +		if (r < 0)
> +			return r;
> +	}
> +
> +	vm->pasid = pasid;

This assignment can then be moved into the "if" as well.

Apart from that looks like a really nice cleanup to me.

Regards,
Christian.

> +
> +	return 0;
> +}
> +
>   /*
>    * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
>    * happens while holding this lock anywhere to prevent deadlocks when
> @@ -2940,18 +2967,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
>   
>   	amdgpu_bo_unreserve(vm->root.bo);
>   
> -	if (pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, pasid + 1,
> -			      GFP_ATOMIC);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -		if (r < 0)
> -			goto error_free_root;
> -
> -		vm->pasid = pasid;
> -	}
> +	r = amdgpu_vm_set_pasid(adev, vm, pasid);
> +	if (r)
> +		goto error_free_root;
>   
>   	INIT_KFIFO(vm->faults);
>   
> @@ -3039,18 +3057,15 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	if (r)
>   		goto unreserve_bo;
>   
> -	if (pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, pasid + 1,
> -			      GFP_ATOMIC);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> +	/* Free the original amdgpu allocated pasid,
> +	 * will be replaced with kfd allocated pasid.
> +	 */
> +	if (vm->pasid)
> +		amdgpu_pasid_free(vm->pasid);
>   
> -		if (r == -ENOSPC)
> -			goto unreserve_bo;
> -		r = 0;
> -	}
> +	r = amdgpu_vm_set_pasid(adev, vm, pasid);
> +	if (r)
> +		goto unreserve_bo;
>   
>   	/* Check if PD needs to be reinitialized and do it before
>   	 * changing any other state, in case it fails.
> @@ -3061,7 +3076,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   				       to_amdgpu_bo_vm(vm->root.bo),
>   				       false);
>   		if (r)
> -			goto free_idr;
> +			goto free_pasid_entry;
>   	}
>   
>   	/* Update VM state */
> @@ -3078,7 +3093,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		r = amdgpu_bo_sync_wait(vm->root.bo,
>   					AMDGPU_FENCE_OWNER_UNDEFINED, true);
>   		if (r)
> -			goto free_idr;
> +			goto free_pasid_entry;
>   
>   		vm->update_funcs = &amdgpu_vm_cpu_funcs;
>   	} else {
> @@ -3088,36 +3103,13 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	vm->last_update = NULL;
>   	vm->is_compute_context = true;
>   
> -	if (vm->pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -
> -		/* Free the original amdgpu allocated pasid
> -		 * Will be replaced with kfd allocated pasid
> -		 */
> -		amdgpu_pasid_free(vm->pasid);
> -		vm->pasid = 0;
> -	}
> -
>   	/* Free the shadow bo for compute VM */
>   	amdgpu_bo_unref(&to_amdgpu_bo_vm(vm->root.bo)->shadow);
>   
> -	if (pasid)
> -		vm->pasid = pasid;
> -
>   	goto unreserve_bo;
>   
> -free_idr:
> -	if (pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		idr_remove(&adev->vm_manager.pasid_idr, pasid);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -	}
> +free_pasid_entry:
> +	amdgpu_vm_set_pasid(adev, vm, 0);
>   unreserve_bo:
>   	amdgpu_bo_unreserve(vm->root.bo);
>   	return r;
> @@ -3133,14 +3125,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>    */
>   void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   {
> -	if (vm->pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -	}
> -	vm->pasid = 0;
> +	amdgpu_vm_set_pasid(adev, vm, 0);
>   	vm->is_compute_context = false;
>   }
>   
> @@ -3164,15 +3149,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   
>   	root = amdgpu_bo_ref(vm->root.bo);
>   	amdgpu_bo_reserve(root, true);
> -	if (vm->pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -		vm->pasid = 0;
> -	}
> -
> +	amdgpu_vm_set_pasid(adev, vm, 0);
>   	dma_fence_wait(vm->last_unlocked, false);
>   	dma_fence_put(vm->last_unlocked);
>   
> @@ -3254,8 +3231,7 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
>   	adev->vm_manager.vm_update_mode = 0;
>   #endif
>   
> -	idr_init(&adev->vm_manager.pasid_idr);
> -	spin_lock_init(&adev->vm_manager.pasid_lock);
> +	xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
>   }
>   
>   /**
> @@ -3267,8 +3243,8 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
>    */
>   void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
>   {
> -	WARN_ON(!idr_is_empty(&adev->vm_manager.pasid_idr));
> -	idr_destroy(&adev->vm_manager.pasid_idr);
> +	WARN_ON(!xa_empty(&adev->vm_manager.pasids));
> +	xa_destroy(&adev->vm_manager.pasids);
>   
>   	amdgpu_vmid_mgr_fini(adev);
>   }
> @@ -3337,13 +3313,13 @@ void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
>   	struct amdgpu_vm *vm;
>   	unsigned long flags;
>   
> -	spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> +	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
>   
> -	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
> +	vm = xa_load(&adev->vm_manager.pasids, pasid);
>   	if (vm)
>   		*task_info = vm->task_info;
>   
> -	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> +	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
>   }
>   
>   /**
> @@ -3385,15 +3361,15 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   	struct amdgpu_vm *vm;
>   	int r;
>   
> -	spin_lock_irqsave(&adev->vm_manager.pasid_lock, irqflags);
> -	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
> +	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
> +	vm = xa_load(&adev->vm_manager.pasids, pasid);
>   	if (vm) {
>   		root = amdgpu_bo_ref(vm->root.bo);
>   		is_compute_context = vm->is_compute_context;
>   	} else {
>   		root = NULL;
>   	}
> -	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, irqflags);
> +	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
>   
>   	if (!root)
>   		return false;
> @@ -3411,11 +3387,11 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   		goto error_unref;
>   
>   	/* Double check that the VM still exists */
> -	spin_lock_irqsave(&adev->vm_manager.pasid_lock, irqflags);
> -	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
> +	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
> +	vm = xa_load(&adev->vm_manager.pasids, pasid);
>   	if (vm && vm->root.bo != root)
>   		vm = NULL;
> -	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, irqflags);
> +	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
>   	if (!vm)
>   		goto error_unlock;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index ddb85a85cbba..8e8bc132e590 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -359,8 +359,7 @@ struct amdgpu_vm_manager {
>   	/* PASID to VM mapping, will be used in interrupt context to
>   	 * look up VM of a page fault
>   	 */
> -	struct idr				pasid_idr;
> -	spinlock_t				pasid_lock;
> +	struct xarray				pasids;
>   };
>   
>   struct amdgpu_bo_va_mapping;
> @@ -375,6 +374,9 @@ extern const struct amdgpu_vm_update_funcs amdgpu_vm_sdma_funcs;
>   void amdgpu_vm_manager_init(struct amdgpu_device *adev);
>   void amdgpu_vm_manager_fini(struct amdgpu_device *adev);
>   
> +int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +			unsigned long pasid);
> +
>   long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
>   int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid);
>   int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
