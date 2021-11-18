Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C72C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 00:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E818B613A9
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 00:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E818B613A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 739C66E0D8;
	Thu, 18 Nov 2021 00:14:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF6AB6E0D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 00:14:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WcKKU5ytaEl/a7cKcvo7In6515UzaCpPzMBRwQRDbPMiC3xO1qhXaBVAHEIlTIsr2DQ6REjLlhBABbGP+UhflZyHXpFsObrcX1nxLfeQn+CPtDBTO9dMFI6zSTCtQfJU5zHfa6OegPZg0yJ3r+qtt+ijWgHOvS/8aUHzcPOsaCiGp14ITJcY7wnYMEq7Q29T6Txyndu+7M/RuohJiwIhtViUozf5v18JByx4PY0p9QpALUkA93acIYasgv8AGNeug1UiilxuJ4iDMCYqJVcxnrspAvk3utInSYEGVQfff48hJTnRy0RLOS9V9kekZOLh3NxG4h5BXB8khd4i/gTj4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZjZKfx6G4oCJR+Cmp/Yc02xrSEsay+f7xRz52rpSlE=;
 b=M1WnIQAJJgi7BpcaQo6ojhNa5AEEFCKt36jtJ5cfj3bZ3QsQTh80FAvFscnJazLcyw2ct3Tpa1UKOpMMU0pYRSHhMKitHmQlNGtx0N5uHLnHejy04qXswZsEgCDOP7fLFdwNDyVkUs+6mmbFIGwiCNQKuHyIFjUtHoHgz1NXyhPzCdvv6lMkNG/oBk7uQ+hzGUFjHPLQKHE/E58/gYdBKdIwcRhyZ5Yky9ws1xMcTJVbZk9qt01njZgJvMAisLvpaMKN/d3FSCSNkDXJ9IUUMZ0isrQUku2pAiS/txAQA+H8jVuBV/ZhImgg3pEMEtLm/gamKl7YJRo0y7NBDzrUag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZjZKfx6G4oCJR+Cmp/Yc02xrSEsay+f7xRz52rpSlE=;
 b=qr9koYXW2ROqycUoDj7C3GxbkpsEJ1hxIktogTuIJW8dXnB3jP92i3I2W4+EArT0kYOe34jpL0xbl/CopZUge8K1W8m/ESydWBBb0U4yQo//gHIpl9wRf5kRnWyTPQZ8py51r84AnhIQoys8jqFiXJmHKYg1RsWUkW35OJrJZZg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5033.namprd12.prod.outlook.com (2603:10b6:408:132::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 18 Nov
 2021 00:14:24 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%8]) with mapi id 15.20.4713.021; Thu, 18 Nov 2021
 00:14:24 +0000
Subject: Re: [PATCH 3/3] drm/amdkfd: simplify drain retry fault
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211117034324.4663-1-Philip.Yang@amd.com>
 <20211117034324.4663-3-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <71b8c251-97f3-3064-7861-d2bdb24b6ae9@amd.com>
Date: Wed, 17 Nov 2021 19:14:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211117034324.4663-3-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MN2PR20CA0022.namprd20.prod.outlook.com
 (2603:10b6:208:e8::35) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 MN2PR20CA0022.namprd20.prod.outlook.com (2603:10b6:208:e8::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.20 via Frontend Transport; Thu, 18 Nov 2021 00:14:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2358db7-b481-42a6-a915-08d9aa286051
X-MS-TrafficTypeDiagnostic: BN9PR12MB5033:
X-Microsoft-Antispam-PRVS: <BN9PR12MB50333EB7531A063B38EF2E67929B9@BN9PR12MB5033.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TyKD0iagY/uLaqWRVa3sh7ScEJZPlBQav/TBs4gCaRR7bNr+/MwX9iRMmLBpQ5Dc8MdQp7yXfpdlhs1DR28uYyy/BrW49i42HTpiwy4cUr4qwbEaPb79jghjXERN16Yewovj+dgHl9v42cjgeKAoAfzyMVpAfvQutm9uq6yNNd7b3A0VHwPPbl/sFE2XjPHelCQ2/s3xw7kzhHDfcIyyxwS48lgR9LbcIHc6/U2gWao6GNiQ8dHQZsXIiaPjHk+NsrSIb9QVuX7ynvOCtk8w+W2ZcMk6zGKqDOZORb5znlnuVH9E82vMZ9iWnlIAqkTPPkCH6GQxGoNWuEO+HTSRj9j5OcdPdLcHXDdAEDxwesKRa+A/ehnk+vhapwdNkyL1HHjfStHd1mJnIbibdGK4pPTQjxC/ZxZBVa5MPA+bojQbXZaYpoGZDoZoXjHLAAaL8we/f5On4KKVDu+58TeY1ktJgRUbF58fyQZERVAQoLPgqFaxrgm5Hr8JEu3QrhqDD2GoZ6LzL9No28LQSoszjzmvNVISr/vwukvsFPXH8zWnTgrYiP4/Nrj6Ni25+7rhQPdcxysoF9CMLN6UVVLy0q+xeGvUH3ebHxYeXZHpADsVH5OVUuaqwdED2JX6nntM2UnJXWPcv8I/AyLeSpgYLTufYf/dfJCUGXdcF0j7EZn7ttZGlmMWodBxa6eytRHmVLjAdF+IILAaLl3nZ4psm+RRXQNB2FiY5wVYWt33Nso3vwkF4wNb5WyCBdHZ1/IR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(86362001)(66556008)(6486002)(5660300002)(53546011)(31696002)(16576012)(66946007)(66476007)(36916002)(508600001)(26005)(316002)(8936002)(83380400001)(4001150100001)(8676002)(38100700002)(44832011)(186003)(956004)(2906002)(2616005)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek9uUzRiSmhSRXRaaTh4dGVzSmVOQlNMbTdJU3lqVEx6cDMxT1pNRG5RZGV1?=
 =?utf-8?B?ZlNaTnp6Z2NzYXlzSWVESmlkU04vWDVKVnV2ZUJadStwSG12RU13dG4vVG5o?=
 =?utf-8?B?ajR5RUdPQUs4SUwweG8rbml4ZVhzVFd2d0tsRjBTVFBsS1pFQ1FGUnZPSW1v?=
 =?utf-8?B?UW5HK1RtVHhzMGJtMDVhck1lZHRvTUx4MDRvRkphWDhjdjR0bHFkQ3BkdzF0?=
 =?utf-8?B?ZzlOUThrSDdkUWxHM2hEUW00ZFQyUWdpdkZ2UlErczJ4a0ZFSDNoR2JkRGVu?=
 =?utf-8?B?WEk5RmNiTG8rcFFNYUNDTFdIVUdkbzJtdnRPdTdGUGI5OXNzY2tzK1A4Qmxh?=
 =?utf-8?B?SHBnTFNGb0FqamJVOGxOeFd2cDBiemNULytLNHF3Y0duUGZWNlp0YWdCbU91?=
 =?utf-8?B?TVNJaDVHd2xrMldjSnV5SXc4VXJ4WVBKMkV3VGdyaUwyMmUxcU1DUjhLL2kx?=
 =?utf-8?B?bGtvZzVxOVNHWWxmQXowdmViQ21GMzhNSERGby9tYTBuZnJTRXY0MHNsV0U3?=
 =?utf-8?B?dkIvTmo0MTgxakZ2V2tsY1prVjdJekJFMWJaYWJ2UXJsUnhLMWNiSWV6R1g1?=
 =?utf-8?B?ZlBYTmZ1SHhEeFhEZEsxUWdPTVlZaHRlT3FNaWpMR21vRnpYRDF1dkxsVm9k?=
 =?utf-8?B?bHNOQ2JIMkNyeDROUStyTzJmM2pjbWZ0bE95bFlpS0czQ2U4VFR5QzRuMHhD?=
 =?utf-8?B?aU0relFQcDkwOUJjcmRGUW5nUHIxM2xBaEtDVEJMZzFSVDdTSGpVMXZaaUl0?=
 =?utf-8?B?OVVNK1VkczUwa2xOeHZBTXhqbWpEbFBVR1RPZ0Eva2NaMHZDS1hLZVhVMktl?=
 =?utf-8?B?SHptN3FROEFmT0ZYK1RhbVFtenBVWFRiODBURzJMc2ZjYVA5dWdyRWl3L1BI?=
 =?utf-8?B?bDl3dVhXMXpvS2hVUnNGaThPZGJtbzBYcFlMWEE1dUF1eUYycnV0VlVmU2R3?=
 =?utf-8?B?U0s3K3NQVUFaTEFrcWZkUE9jZmVCVzhWb1VuOGJmSWNtUnRUVU8rVy9ZMExI?=
 =?utf-8?B?R0N3U3d1bmREamVOMWMvWDBjQnp6YWd2UTdMRlUyQTlzOUxwVDd0TmN4bEds?=
 =?utf-8?B?TzlOdE9NbVJzSUk4RUlwZG53NnFxeVltMm5ZL2hOR1NobzdYV2ZlMjB4ZUN0?=
 =?utf-8?B?SEl5Z2RpMEEya0dwRU9wYkNkUEQ4bkRhNHhhclJxbWRMQW9TdEJja0hmZ013?=
 =?utf-8?B?Z0J6SFVqOUJjbi9FbERmak96dTRCSDQyMmNYY01HMU9rMlJIZWVuWmw1RkY4?=
 =?utf-8?B?SXlFNDhLOTNjRGdBelNsWkxqZElmcm9NQ0FuR3p0UWJkcjR1MGRGN0RkN29j?=
 =?utf-8?B?cnhUR2t0aWJ6dmZqMG5xUE5SZDdTd29iSnoxaTdNMUQzdnhCTkYzM2N1T1dM?=
 =?utf-8?B?VmJ0RFMvMTQxVTVwc2wwK3RNVGY5bktEdnVRUDJqK1JGYVZNTFQ2RnRqRHFV?=
 =?utf-8?B?SENLR1NuOGVRcTZRdElVTTdyNFkvT0xkN1NmM2lNbVZoVFArQWhjaWpSSks1?=
 =?utf-8?B?WnZBOFE5Y3ZTbnpUZnEvLzczd21xdG5lMTVPdlRsenpjN2tpVk1tVmFQV1hH?=
 =?utf-8?B?Y2hweGZXVEFheGN3WUtWanJnTTBEOXhPRUZRZWtMVHl2aVRxSm9jS3FmZnpw?=
 =?utf-8?B?bFRBOEQ1QkU2WXhmVUVsbVlmVDV1aUlFd2NzcW0xK01NTDBYcG5ickpJUWxw?=
 =?utf-8?B?aThJai9lK0FGYThuUWVkaStaRzdHWFNPRGxsSkw1d1I4aU45OXJxa29Za3pJ?=
 =?utf-8?B?cHFtRjZtM3VHY1ZMKytKbkdhUmFsRmxGanlCaS9xc3l3NVZMK1NlamF0MWpy?=
 =?utf-8?B?cFFhTkt5eDlwckhvTUd5QmJDV1kvZFZNcTBxY1l2am4rNC90R1JQSUtPQmEv?=
 =?utf-8?B?UnNORVRMS1FXRm9vZm9xUzJwYThJOXZwM0VzSU51cTU4L3JJQ0FTVnRWRi8y?=
 =?utf-8?B?ZThpL3lkd3FPWXZrRnJLc3FldEw2MkFTL1I5UVVNTjk5TVBoUThPdDgrZ00x?=
 =?utf-8?B?cEFhY01adHQ0ZUZBbGxJczlGRG0wNjFVS3Fhc1Q4TXNmSkUra1NRWnlMbkdN?=
 =?utf-8?B?S0pQUnh1Z3VJdjZHWUNLbmp2Q0p2TnZHQ1Joa0RqRWg5cS9CMDhZV1ZVWjVa?=
 =?utf-8?B?Y1RDcWVMYll0VFNJeDVaWGlrUEhQMW0yT3g1M25COFdLcDRJM1c2N2xHRjU5?=
 =?utf-8?Q?WgGv90F5HbvaxEYRjqaxg/M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2358db7-b481-42a6-a915-08d9aa286051
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 00:14:24.4901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICTIMlfDOh/BXNqGPpSQfiSyKjsQ/r8AFf6F3cpnpYBhy5WtTLoXYDhMnDv9u2WA61DubwHQmWYGdoDKxLjBaQ==
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
> unmap range always set svms->drain_pagefaults flag to simplify both
> parent range and child range unmap. Deferred list work takes mmap write
> lock to read and clear svms->drain_pagefaults, to serialize with unmap
> callback.
>
> Add atomic flag svms->draining_faults, if svms->draining_faults is set,
> page fault handle ignore the retry fault, to speed up interrupt handling.
Having both svms->drain_pagefaults and svms->draining_faults is 
confusing. Do we really need both?

Regards,
   Felix

>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h |  1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c  | 24 ++++++++++++++++++------
>   2 files changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 1d3f012bcd2a..4e4640b731e1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -767,6 +767,7 @@ struct svm_range_list {
>   	spinlock_t			deferred_list_lock;
>   	atomic_t			evicted_ranges;
>   	bool				drain_pagefaults;
> +	atomic_t			draining_faults;
>   	struct delayed_work		restore_work;
>   	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
>   	struct task_struct 		*faulting_task;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 3eb0a9491755..d332462bf9d3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1962,6 +1962,7 @@ void svm_range_drain_retry_fault(struct svm_range_list *svms)
>   
>   	p = container_of(svms, struct kfd_process, svms);
>   
> +	atomic_set(&svms->draining_faults, 1);
>   	for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
>   		pdd = p->pdds[i];
>   		if (!pdd)
> @@ -1975,6 +1976,7 @@ void svm_range_drain_retry_fault(struct svm_range_list *svms)
>   		flush_work(&adev->irq.ih1_work);
>   		pr_debug("drain retry fault gpu %d svms 0x%p done\n", i, svms);
>   	}
> +	atomic_set(&svms->draining_faults, 0);
>   }
>   
>   static void svm_range_deferred_list_work(struct work_struct *work)
> @@ -2002,6 +2004,7 @@ static void svm_range_deferred_list_work(struct work_struct *work)
>   	 * mmap write lock to serialize with munmap notifiers.
>   	 */
>   	if (unlikely(READ_ONCE(svms->drain_pagefaults))) {
> +		atomic_set(&svms->draining_faults, 1);
>   		WRITE_ONCE(svms->drain_pagefaults, false);
>   		mmap_write_unlock(mm);
>   		svm_range_drain_retry_fault(svms);
> @@ -2049,12 +2052,6 @@ svm_range_add_list_work(struct svm_range_list *svms, struct svm_range *prange,
>   			struct mm_struct *mm, enum svm_work_list_ops op)
>   {
>   	spin_lock(&svms->deferred_list_lock);
> -	/* Make sure pending page faults are drained in the deferred worker
> -	 * before the range is freed to avoid straggler interrupts on
> -	 * unmapped memory causing "phantom faults".
> -	 */
> -	if (op == SVM_OP_UNMAP_RANGE)
> -		svms->drain_pagefaults = true;
>   	/* if prange is on the deferred list */
>   	if (!list_empty(&prange->deferred_list)) {
>   		pr_debug("update exist prange 0x%p work op %d\n", prange, op);
> @@ -2133,6 +2130,13 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
>   	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] [0x%lx 0x%lx]\n", svms,
>   		 prange, prange->start, prange->last, start, last);
>   
> +	/* Make sure pending page faults are drained in the deferred worker
> +	 * before the range is freed to avoid straggler interrupts on
> +	 * unmapped memory causing "phantom faults".
> +	 */
> +	pr_debug("set range drain_pagefaults true\n");
> +	WRITE_ONCE(svms->drain_pagefaults, true);
> +
>   	unmap_parent = start <= prange->start && last >= prange->last;
>   
>   	list_for_each_entry(pchild, &prange->child_list, child_list) {
> @@ -2595,6 +2599,13 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	mm = p->mm;
>   	mmap_write_lock(mm);
>   
> +	if (!!atomic_read(&svms->draining_faults) ||
> +	    READ_ONCE(svms->drain_pagefaults)) {
> +		pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
> +		mmap_write_downgrade(mm);
> +		goto out_unlock_mm;
> +	}
> +
>   	vma = find_vma(p->mm, addr << PAGE_SHIFT);
>   	if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
>   		pr_debug("VMA not found for address 0x%llx\n", addr);
> @@ -2732,6 +2743,7 @@ int svm_range_list_init(struct kfd_process *p)
>   	mutex_init(&svms->lock);
>   	INIT_LIST_HEAD(&svms->list);
>   	atomic_set(&svms->evicted_ranges, 0);
> +	atomic_set(&svms->draining_faults, 0);
>   	INIT_DELAYED_WORK(&svms->restore_work, svm_range_restore_work);
>   	INIT_WORK(&svms->deferred_list_work, svm_range_deferred_list_work);
>   	INIT_LIST_HEAD(&svms->deferred_range_list);
