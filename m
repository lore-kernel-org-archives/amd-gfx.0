Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB64C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 00:11:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA36C613A9
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 00:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CA36C613A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B0186E0AD;
	Thu, 18 Nov 2021 00:11:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 094066E0AD
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 00:10:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGTXwpdfMne1TP649EBmk9qskNrbZUKipqHVAzs2siOCNWq8Xxd7tGHZnkMbfNSShNNxiyi6Vmx/OkGj3I6bF3VLGChfHtvkUFsTGmexldV8Ridt6QSSFU6ZjmP2GQT0jxk2dCxZFYggozFpcto6AERj1YA5L9sF1kq/BM5ysgYMrmCKuwkTV9tvxjHUqyK5mEEmNIh5wTWRHpSJ2tnFziuJtjBKGOMQCCBd4xrW20stYdCFXxKwq7FFnfoXyppfrMshm1j6q5C8ucnKE6IUkOPdqe4PClShbLU/1uNjRtVt/mq3EwbCOaBi2BiNRSqFaUl8mYLNDNlCyl8A7oFUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5as+Zf2mVntrTllzHwsX4z4ywuydsQ3AN1QCPw5gW1Q=;
 b=jMkrOG1o43Uvy8AuPijfvlQRk1lpQvmJEGjZjqYihYJGuuemONg8J0nUJ/84gcKtv25ilC4mV6euC86uBiOeIn2dR25XXE017JakIeV4LMAiEfYFqTvGjWDIld6wVoc0ICM49jCTZYWKRV4JkAbH7RgcL9glGBmSDkkMET0HrpR0/quU9cAu/oGy03u689mjpHdGSostJ1NRfUCH12/Mx8gYMScs2qrnXYZEaAk3ZjqOdJJgam39kUSVRjcmr/gYqa0XKNE1EFdCUBBgtFbWZ+1OOFENr+MhrukQ3Qz1HJRPFS2sbjYlhWKvSegzTyoufHS7EANWvmhB6O3ONbJ87A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5as+Zf2mVntrTllzHwsX4z4ywuydsQ3AN1QCPw5gW1Q=;
 b=i9ZGePLXfXZ1WhznX6ys6fN5Wixlt1Rvi/flozZyu3kQp3peapZ774yZWA/5X8nDJ/Le+3yCiRWInNbXqT2iARgYqBfkbWkYtJHfSsvGv0k1VsPiT8gU0kXmO5Hy3n8xXVKV/Kma+LSp8HsKyaZkH3yyNf/A3SxO6fwroWjDgqE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5033.namprd12.prod.outlook.com (2603:10b6:408:132::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 18 Nov
 2021 00:10:56 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%8]) with mapi id 15.20.4713.021; Thu, 18 Nov 2021
 00:10:56 +0000
Subject: Re: [PATCH 2/3] drm/amdkfd: handle VMA remove race
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211117034324.4663-1-Philip.Yang@amd.com>
 <20211117034324.4663-2-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <5e1927f0-2cbc-e639-57b1-f61274ec97f4@amd.com>
Date: Wed, 17 Nov 2021 19:10:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211117034324.4663-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BLAPR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:208:32b::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 BLAPR03CA0024.namprd03.prod.outlook.com (2603:10b6:208:32b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27 via Frontend
 Transport; Thu, 18 Nov 2021 00:10:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b78425a9-a376-474d-34f6-08d9aa27e448
X-MS-TrafficTypeDiagnostic: BN9PR12MB5033:
X-Microsoft-Antispam-PRVS: <BN9PR12MB503367912337EFD5FE31197A929B9@BN9PR12MB5033.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VaJboTc/1pvbr/2caoiQRh6imNZ5vWbiY9U5Ntck9KEWaY2Vv/Khb6qphCxWCtn4c25AnULt7RtNjuPoSC/qSzwO1s+7qBfIGAeQX9GgzML20WXDHMUqGoCZN7cdif6Kpoa2gZT1h0C5DDmOK3ioMh+SXDQGQ0HqRYtJdyHle1+AfaTUfhbUtVBcYe4lUGKiVvmptKAijHruTcFSM9jZEa4W4hZdWH9S2b28+mVOCexe9a4l6u6xzZ89JQipeXw2xDRBhTRiA1xHk3bU3lAOgRXSKnK529dl0pa+lzZTQMPmG+sGIg2mWA9FJCgc47MHQauTuo2Vj+rjORhqYvkxwjjOtd7tz8HSo0tpB1NkPUpJPWFJKorqUVPlN5VZ7IlW73wzu4yhTXv/W7vMHG9k0IX3OMCKYr+GSUinhrBJxp1dPvJqTKWtZ0j3+fWyQso1NsTYCrtDBok+3hUDX31H9nlpcGJAJOmr84+gc7iggblFfdXYZxBmlswnfwc50sJNMtxra1gRjnZ8RgCsqkkKsfrBTCnP7K1nMv/G/2UZavFJ9fULJeklvAk9++QTX8I7fmyWQLvB2/t+rNWnd/P32hWfGS0sgxNjqz4CKUSHYnequHMrGP57SEdyJcgENGqDp8osFTI4ufNZcq1/zq0tCX1JCUeNo1MGmAcIqYNAddqKx5a3eyyWmPYkzPd7l5EFPXyPMD+R2aGF/xVYYDOHgpv+kFQBQBnNVQlIWgmMDM0VKPc0HrhIPbfKLX3yHraI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(86362001)(66556008)(6486002)(5660300002)(53546011)(31696002)(16576012)(66946007)(66476007)(36916002)(508600001)(26005)(316002)(8936002)(83380400001)(4001150100001)(8676002)(38100700002)(44832011)(186003)(956004)(2906002)(2616005)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzdpeEd1TzQ5bzFWN0FlMlVjcDR3Wmx4VVgzL0U0cXU5MCtJUU40OHJYanV1?=
 =?utf-8?B?bVJ2VHZKNDJza0paU2sxVG1QdFVMLzhOU0tUTFN3SmVTdUtMckY2RFI1S1p5?=
 =?utf-8?B?NGJmQmVDM2ZoT2ZkVUVwMHUyN2hxMEtsOGJrZ3hPQlFGNzRwRXBqM0NRSUx1?=
 =?utf-8?B?Z2tCMGpMUm9MdG5WcHkwOE1oN2pGTXkzWkNkak5CbGVWNzRpZllTNVh1Zmx0?=
 =?utf-8?B?WG5vVzNGOTN6OVJVZnNINzZUUEJXUWN1R3MzenJ4SEdjbXEwR1grSmZjT1Ba?=
 =?utf-8?B?aVd3UVZNU3gydnZnb3hpaURTVUJNR0VUb3B3V1lLNWlJZkpsczdJYmk1cXNY?=
 =?utf-8?B?ckdGQlRCbVlHRVlRRkdQWmQvc1djYUJmSlhpaHViVkpISm41VzRReFJVR0FD?=
 =?utf-8?B?YzMrbk5TMnVCd3RKN252bW5EL3BFM0g2QlRvTXhtOFp4cWR3bmk5STdZRFJn?=
 =?utf-8?B?c3g0Q1dnYnNqTWhaZ20vOVYyMldNek55dXJnei81VmZ5cjRWbHdESlBTUWxX?=
 =?utf-8?B?dTBrK3Q4Mk1nWGJ0ZVRJTEhlMWQ2TXIyZ013bEtpT21XSi8yTWdFZUZONkQy?=
 =?utf-8?B?bVRBUjZVYnBQVVJPdEhnU3hlcWVaSlcxNmEyWjM5WFJWUGxyOHJXbVRTZlow?=
 =?utf-8?B?MS8weG1vVWJZY1FjYVM4c3piQ3NweHZRd1F0Z09teEVtcFNSblBZTVF5Qjlr?=
 =?utf-8?B?WEF5ZEZYVHM1dHFtUEFPYnozdTlvRkhUd2hZVmFQZXo3Q2pHU1lHR21qMFlJ?=
 =?utf-8?B?dVdNeU1kK1dxUkJOaDVLSVplNTJNS3pwa2dYZEtFeXpqaTNLNG5iLysrc3VU?=
 =?utf-8?B?b3d1TURoUUE0Zng0enI1dGRRd0pyazE5YkszS0x0YUdYS2NDVm9DQTJUTTlR?=
 =?utf-8?B?c3pTNW1mN214M2kwN1NBeWV5WFcvZWVQYzVPRmh0Wnlza3pqc3NPeW1XSlY0?=
 =?utf-8?B?SWFIRCs1dGd4Y3pLaFdWRDZCSy9jWmVnMVh6UFNISXlydHllM3djZk9jY2x0?=
 =?utf-8?B?dW9Nc1FKK0QyRVhDYWh2Y25pRlpzQ0xQRFl2aEFLNGNJbDNhUGRyS01yYis0?=
 =?utf-8?B?OFlLOXNRVzhyZE9WZjNocXFXdHpRTXhpTTBUa1EzVnhYYm9BNmdyRWRwRklO?=
 =?utf-8?B?WnFRbkdyQmNoTWppV3JXYk9DU3BwTFVnRW1QWTlWWFJhMGlIMVlCWWxRYXlm?=
 =?utf-8?B?bm93OGQ1T0ZoT09kaS9BMG1odlIzMGIzWk42RE8rZll2RHpySlgyWnUxZmVQ?=
 =?utf-8?B?eWI4dlhVb2VEaXlCSnBDT3NmV0prWFhSZ3psa2hoRVNpSVgweWRGcmJpQzU2?=
 =?utf-8?B?c2V5ZncwUWQxWEVEejRsRHhFSm1zTnhkaExKUk5lV3lnVjNWTm1OazVRdnFC?=
 =?utf-8?B?bnE1N3k2NC9wOTAza3NzckJXLyswdUFvUnpoQ0RpcVZuZDd1VEJ3aFhIZm85?=
 =?utf-8?B?N29pa1d2cTVSRkd5dlpaTjZLZ0gwWTRRd01pdmRpTVVBdWVlSm11T3puRkNp?=
 =?utf-8?B?TExGdGlyVk54NHc3RVRaRVhJNGFOdDVjQ1Z0c0RKSGNpdW45aDAxcHpPTkg5?=
 =?utf-8?B?YjE2THBwZTZlN3JWTlNYalRFL092OEZXaHIvcnA3bjlBTUgxdVBpSjdkbGFa?=
 =?utf-8?B?bnE2NUR0S2g5T21BWk9YcUJ3ZzdiekNyN2ZvZFpld2pKNFpZVWlZZ29pS01p?=
 =?utf-8?B?TXdhR0svVGhWaEs1S1NmZ1RDNS9aNWljSmp0SkV2TzZwSWhqaVpPOG9wVUJa?=
 =?utf-8?B?bGxYMFhiM1JCNWY4RmtJQWZ4OWVSRUJOZ2UvNG8zQ3RXRU44WU1rRERMMHY4?=
 =?utf-8?B?TDdVWjFpSitkL3VvSDQ0bHFlOHBadXY0bjIyYXl4Rkl6SnU4SFJlK0FzQVcv?=
 =?utf-8?B?eTVUdzBIc0Q5VncrS3g3cDBYUFowTnl6cXllNERQU1RDRnp2V05ZT2h2WEtu?=
 =?utf-8?B?K0F6R0N6SHpmWGcxU1VIMy9IOXU1dWJBQWlhaFdGb3lVZW80YTFKaEdLV3Nx?=
 =?utf-8?B?LzV5VmV1VWhsbUxwdDhocFBGR1B0aFI5aTYrMDJRRWhYUTN6MXVkZ1BMa1k2?=
 =?utf-8?B?UUhhQ2V0NzlpRG5QSk1iVWZaOGptdTBaR1pYN3IzUUg5U2lPbUxiMlUxS252?=
 =?utf-8?B?RmRaYXR3RDFJcjdrMTBCOG5adHRDNlRuSi9Gc3NpbjY5Q1RxM3ljS3pyUkdq?=
 =?utf-8?Q?rY2H1ismfXBXUa41Pso1w1c=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b78425a9-a376-474d-34f6-08d9aa27e448
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 00:10:56.2887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XkJWhFkpaFs0dmCTDaR2ZFabaW+e9OfpJqRRAphU3amqbVrhlPFbK1HTK5Ncd53objPQ2v4NLlcor9mLgCzSLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5033
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

On 2021-11-16 10:43 p.m., Philip Yang wrote:
> VMA may be removed before unmap notifier callback, restore pages take
> mmap write lock to lookup VMA to avoid race,

The old code looked up the VMA after taking the mmap lock (either read 
or write) and kept holding the lock afterwards. I think even with your 
new code it's possible that the VMA disappears before you take the lock 
the first time, so always taking the write lock only reduces the time 
window in which things can go wrong, but it doesn't remove the race.

I still struggle to understand the race you're trying to fix. The only 
time the svm_restore_pages can see that the VMA is gone AND the prange 
is gone is after the deferred worker has removed the prange. But the 
fault draining in the deferred worker should prevent us from ever seeing 
stale faults in that situation. That means, if no prange is found and no 
VMA is found, it's definitely an application bug.

The only possible race is in the case where the prange still exists but 
the VMA is gone (needed by svm_fault_allowed). We can treat that as a 
special case where we just return success because we know that we're 
handling a stale fault for a VMA that's in the middle of being unmapped. 
The fact that the prange still existed means that there once was a valid 
mapping at the address but the deferred worker just hasn't had a chance 
to clean it up yet.

One more comment inline.


>   and then create unregister
> new range and check VMA access permission, then downgrade to take mmap
> read lock to recover fault. Refactor code to avoid duplicate VMA lookup.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 65 ++++++++++------------------
>   1 file changed, 24 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index c1f367934428..3eb0a9491755 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2329,20 +2329,13 @@ svm_range_best_restore_location(struct svm_range *prange,
>   }
>   
>   static int
> -svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
> -			       unsigned long *start, unsigned long *last,
> -			       bool *is_heap_stack)
> +svm_range_get_range_boundaries(struct kfd_process *p, struct vm_area_struct *vma,
> +			       int64_t addr, unsigned long *start,
> +			       unsigned long *last, bool *is_heap_stack)
>   {
> -	struct vm_area_struct *vma;
>   	struct interval_tree_node *node;
>   	unsigned long start_limit, end_limit;
>   
> -	vma = find_vma(p->mm, addr << PAGE_SHIFT);
> -	if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
> -		pr_debug("VMA does not exist in address [0x%llx]\n", addr);
> -		return -EFAULT;
> -	}
> -
>   	*is_heap_stack = (vma->vm_start <= vma->vm_mm->brk &&
>   			  vma->vm_end >= vma->vm_mm->start_brk) ||
>   			 (vma->vm_start <= vma->vm_mm->start_stack &&
> @@ -2437,9 +2430,10 @@ svm_range_check_vm_userptr(struct kfd_process *p, uint64_t start, uint64_t last,
>   
>   static struct
>   svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
> -						struct kfd_process *p,
> -						struct mm_struct *mm,
> -						int64_t addr)
> +					       struct kfd_process *p,
> +					       struct mm_struct *mm,
> +					       struct vm_area_struct *vma,
> +					       int64_t addr)
>   {
>   	struct svm_range *prange = NULL;
>   	unsigned long start, last;
> @@ -2449,7 +2443,7 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
>   	uint64_t bo_l = 0;
>   	int r;
>   
> -	if (svm_range_get_range_boundaries(p, addr, &start, &last,
> +	if (svm_range_get_range_boundaries(p, vma, addr, &start, &last,
>   					   &is_heap_stack))
>   		return NULL;
>   
> @@ -2552,20 +2546,13 @@ svm_range_count_fault(struct amdgpu_device *adev, struct kfd_process *p,
>   }
>   
>   static bool
> -svm_fault_allowed(struct mm_struct *mm, uint64_t addr, bool write_fault)
> +svm_fault_allowed(struct vm_area_struct *vma, bool write_fault)
>   {
>   	unsigned long requested = VM_READ;
> -	struct vm_area_struct *vma;
>   
>   	if (write_fault)
>   		requested |= VM_WRITE;
>   
> -	vma = find_vma(mm, addr << PAGE_SHIFT);
> -	if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
> -		pr_debug("address 0x%llx VMA is removed\n", addr);
> -		return true;
> -	}
> -
>   	pr_debug("requested 0x%lx, vma permission flags 0x%lx\n", requested,
>   		vma->vm_flags);
>   	return (vma->vm_flags & requested) == requested;
> @@ -2582,7 +2569,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	uint64_t timestamp;
>   	int32_t best_loc;
>   	int32_t gpuidx = MAX_GPU_INSTANCE;
> -	bool write_locked = false;
> +	struct vm_area_struct *vma = NULL;
>   	int r = 0;
>   
>   	if (!KFD_IS_SVM_API_SUPPORTED(adev->kfd.dev)) {
> @@ -2606,26 +2593,22 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   
>   	/* mm is available because kfd_process_notifier_release drain fault */
>   	mm = p->mm;
> +	mmap_write_lock(mm);

Always taking the write lock is unnecessary. I think we can keep the old 
strategy of retrying with the write lock only when necessary. I think 
this should work correctly as long as you lookup the VMA every time 
after taking either the mmap read or write lock. The vma you looked up 
should be valid as long as you hold that lock.

As I pointed out above, if svm_range_from_addr finds a prange but the 
VMA is missing, we can treat that as a special case and return success 
(just draining a stale fault on a VMA that's being unmapped).

Regards,
   Felix


> +
> +	vma = find_vma(p->mm, addr << PAGE_SHIFT);
> +	if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
> +		pr_debug("VMA not found for address 0x%llx\n", addr);
> +		mmap_write_downgrade(mm);
> +		r = -EFAULT;
> +		goto out_unlock_mm;
> +	}
>   
> -	mmap_read_lock(mm);
> -retry_write_locked:
>   	mutex_lock(&svms->lock);
>   	prange = svm_range_from_addr(svms, addr, NULL);
>   	if (!prange) {
>   		pr_debug("failed to find prange svms 0x%p address [0x%llx]\n",
>   			 svms, addr);
> -		if (!write_locked) {
> -			/* Need the write lock to create new range with MMU notifier.
> -			 * Also flush pending deferred work to make sure the interval
> -			 * tree is up to date before we add a new range
> -			 */
> -			mutex_unlock(&svms->lock);
> -			mmap_read_unlock(mm);
> -			mmap_write_lock(mm);
> -			write_locked = true;
> -			goto retry_write_locked;
> -		}
> -		prange = svm_range_create_unregistered_range(adev, p, mm, addr);
> +		prange = svm_range_create_unregistered_range(adev, p, mm, vma, addr);
>   		if (!prange) {
>   			pr_debug("failed to create unregistered range svms 0x%p address [0x%llx]\n",
>   				 svms, addr);
> @@ -2634,8 +2617,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   			goto out_unlock_svms;
>   		}
>   	}
> -	if (write_locked)
> -		mmap_write_downgrade(mm);
> +
> +	mmap_write_downgrade(mm);
>   
>   	mutex_lock(&prange->migrate_mutex);
>   
> @@ -2652,7 +2635,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   		goto out_unlock_range;
>   	}
>   
> -	if (!svm_fault_allowed(mm, addr, write_fault)) {
> +	if (!svm_fault_allowed(vma, write_fault)) {
>   		pr_debug("fault addr 0x%llx no %s permission\n", addr,
>   			write_fault ? "write" : "read");
>   		r = -EPERM;
> @@ -2704,10 +2687,10 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	mutex_unlock(&prange->migrate_mutex);
>   out_unlock_svms:
>   	mutex_unlock(&svms->lock);
> +out_unlock_mm:
>   	mmap_read_unlock(mm);
>   
>   	svm_range_count_fault(adev, p, gpuidx);
> -
>   out:
>   	kfd_unref_process(p);
>   
