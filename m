Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B00DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 00:58:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E06610E81A;
	Tue, 25 Jan 2022 00:58:10 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2080.outbound.protection.outlook.com [40.107.96.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6950C10E81A
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 00:58:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rqjg/Qrkww0oikdrnh0GW2kEwE6WY7s0C0sWmFr++uFXKBO0Y0ptgvspKmOhcYEUUETz//XSsvRmUoxu7c171tDNHsxtYsDoV4qDCdl3sdVE5SZPUImaVtvHYlEXu1E9UaWHWBCO/cjNJdQvEKkM+E2Bh7d8PUa1oEkep5cj1zPOrMtpCv1XxCq8EfV4NN2ksbBBwZtamWrb6h6d7b/hOYWWX1iRSNeTIO1nQH2hNm8iLkunkR3m9zIVN5o5dNBpoUBMgUGY/tksNSDP6DX2SFsP5MxmJeSgPzb1QW1meujVQbGRr/OQIxQZQubjsIqWtgpL0scJQ+XpUmEl5xkalw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMV+CvMXo75TJMLBBZNDU0GlIO637RXpMxBCC38TN54=;
 b=LqUOKoRJJnTXlWiubFcSTxadN88UckNczfE9yL2dUIoHgYOEfZQUwv0PMt8bqso0AQa1uL7ot35gW4dBbK+iUb0AzgzYbxrMBjErk8rkDHW0r1+boye5aVWJQ372WvmaN88VHcXM04bDjCfDdfLPDozX3wkc3StYW5QkA3DqZk1hvoGHMR0MxRrVkjR6fa8MNbbWW2zcxsdwtki+NwkfuY1oMhg2HjMHf6j7rEV8auK6HikGPGi+rFXkghFCZ0hld5Sr+zoqaN+8Mp9mkkT0FDz+ZSb+XXrFoKFy/fL0kkeh7MNp9AwnuDFnQ8nyj11Uh3mbgH0dwtNTbtAOsvZyyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMV+CvMXo75TJMLBBZNDU0GlIO637RXpMxBCC38TN54=;
 b=ktmHoLrC8X0S0lUgoHPlf9bG2nj9v5PAkSp/n5lD5OCbSaPRG9Vx/Snx7jj7iHDRXSfqnc7yWzKnP6jCpbqFarlLvzRxbW5ORM81VkehCX4A09xTs1u5s/hJipLz9K9ofyR9Gk27xWrBY0beZ8NGc5zMXhB/+Ua2Bx1iRValjJc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB2874.namprd12.prod.outlook.com (2603:10b6:5:15e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Tue, 25 Jan
 2022 00:58:07 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 00:58:06 +0000
Message-ID: <944473e4-4889-dbd5-7a62-79f861f8ed67@amd.com>
Date: Mon, 24 Jan 2022 19:58:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] drm/amdkfd: Ensure mm remain valid in svm
 deferred_list work
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220124211144.15161-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220124211144.15161-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e84055a5-f88b-4b3e-fd06-08d9df9dbf94
X-MS-TrafficTypeDiagnostic: DM6PR12MB2874:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB28742CCAC022D7E8D1036892925F9@DM6PR12MB2874.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yE4suT+Q36wP/1HzflaT4hVnyG+XT8iHAszSDj6Sgn0Yegb4ux3mYQp4IpUOLpf3TnRs06tI2rKGP/pRTkWixNakgaJmXnR01WJ78ztixziZt+FztEjWNZk+m9r8o02vyW6n3+R71mxC2d8H8GTZksANY876kghjMzVwr7gw3/AasNpmOGcCgEynQEtAGPyOeQ6qhUoCL7SNwalNk7+8vsc3sgPKhl+P8klzm3n0FdHHQLSErjKx7zXfv1cZv9M8IloRpV3yLJKEMNjxbNGjXsNemqD56WklT3X+AyBYeygfRfZolPMTu8ZUFPfTmNf6FyNCyklC2DRJ6rTVbwyb5C+TMcysZoHeD74cG3YGdwhCWYD/0e9KB8bs+ly5JHjKZdaBTUE6X/YOf0mm1DqXmPtheTAeYmKcqHSnk2GzP9LZ9HNW1CPFzk23f5pCvna2cvylHh3rdeASCA9p8IYELFgsuJH5nUs7P4VGT6YvKXRsFIPdT7gPrP6SsMK4CpxVoKL+JUTBQj9ksU5NTOTSyEmSgD3CaqlA16U8en7Qgvlm5ZOxrGkDZuBrlHDfV+xeUjtWuUznIIfQasPnTYb6JOn2q3wWD7PcNmQQ48cPZLGLbItEFPjTILusjHnGBd86qYgAFLXm9YwgVptYunk5/PhPSPdrjxkl7SmSxpvuquzS+kPrL8Y+QtgmvUTz11AdhQ+UOmOUVooEXPy+yRG6irUnIAzhfWbEX7nL8wL5gWiO0zOmg65tQHNgOYE4ZAiC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(6506007)(44832011)(36756003)(186003)(83380400001)(6486002)(38100700002)(5660300002)(66556008)(6512007)(316002)(66476007)(508600001)(8936002)(86362001)(26005)(31686004)(2906002)(31696002)(2616005)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0t5bUpxQkU0ZU1mTGE5dm9rVDBnMkFld1RtVlFKaVNkNXdqM0VUdWU3OWJp?=
 =?utf-8?B?Q0dqSmtTTWZUUVFlZmhCT2ZaYWJqTlEwZzc3dllGYTA5cHlldmxwZDhWOWg1?=
 =?utf-8?B?TmdzUXRJRDAyOFVGeUhPUE12VFBMV1h5NHNKeUhjYkx6eHRTcVIvU2lhcW1a?=
 =?utf-8?B?dDhlZG1CSE5pdkRiQ2pwc0EwSUhoN2JVdmlRRk5jSkVFelkycDN6cXkyOW9q?=
 =?utf-8?B?UXUwanNMRzd2WGhxUXdGRVBacGVVN0ZSUFg3aVlOZ3lWOFhoa2lCM1lKaGZ2?=
 =?utf-8?B?NjJlYkVCNkZWZFA3QjNhQ1Fib2w1Z1ZBeVRHZDlMRXZsNUpXTDRLMUt2amZ2?=
 =?utf-8?B?SnZyTFdGM2ZXQm9wbU15bWlRL255dTgwNkdiYnZha3c2cHBwcmdDSGphcUVh?=
 =?utf-8?B?RjByem8xYWY3VkhKYVJXWHNMRUlUZ1BxWkp1NUZ5SDZMbDhnOHFITk96a0Fq?=
 =?utf-8?B?dzNGczNBS1V0MXNGZkRNVU9GUnN0T3JYUnYrWThEOE8xV29VTEdhaTc5b2w5?=
 =?utf-8?B?V1dVekMzL0JHZXBvd3Z6SVYzaGJhYWk0RW5QMURTU1NwYytXZkgrOHRxNFlh?=
 =?utf-8?B?TUhGd1hZMlpmQ0tmT09nS1IzOEE3Ym5qdzRrQUNqdmZjTVJvSHBKY3cwcHF4?=
 =?utf-8?B?MUNOcHVoV0hZUXVIRkNTVVNTaE9Zd0NFVW9BMnRocCt3eTg3S09ldktLQVN3?=
 =?utf-8?B?YjQyWXgzenoya09zMG10VHlwZTVSaEFSWkZLTXZWblFPblo5MWRUUTN3c3JN?=
 =?utf-8?B?SmNTVUdJVEZoV0dWRWVDNEZLVHk5d3R1TDBMdTVqL2srWThsUWNMcHFHdVMw?=
 =?utf-8?B?REVpME5iSmRId05rRGMwV2hPNURVRUtTTUlSdU1iSSswSkRLQko1eXVuSUV0?=
 =?utf-8?B?Y21meCtQTnVFZno4WjVyRVBXdVdCVEgzZ05ubmNRd3hMSERUUkNmWUFKdTFl?=
 =?utf-8?B?K3A2eDM1ZGtqODFhWmdKZEZ6UVNoQkpLQUxyVmJsRnliM253TUNnSDFGNThO?=
 =?utf-8?B?d0dRb0E3QWZNTy9UTUVCeG5PMDFaWDRYd2tQZ1Erb1JIT3c3VFJFenNwYkhw?=
 =?utf-8?B?dlF1MmdCaDJaeHJUQ1JBZEJ6WE5ST0doMFE3ZUQ5NWlMZDNlWnJMeXF3aTZj?=
 =?utf-8?B?SUhIRjVHK2FPZ3Y2L0R1NWNKL2FkZWtZd2VlN05ka3o4ZURWTHpxYlNEVkhj?=
 =?utf-8?B?M0tLQlhkWDBpYWtrQm1WeW8xdURxcHIxUFEraG5YYWIyWjdXQ2NLT1NBWEhG?=
 =?utf-8?B?clJXZHVFSWtvbmg4V0Z0NTR3SlNkSHFZT3RwUWp5TTR0anorWm1Ca3N1UXFi?=
 =?utf-8?B?Y0FlYkdFZHk1aFhidHRINGZCczVieCt4ZDRhaWh3bzlSZjdha1FvMlJpL21y?=
 =?utf-8?B?MEJsc3JVRE4xNkVZY2IwT01tWWpDRlBkbjZBUE9wUG5IRmI2TXlFMjBmWnhC?=
 =?utf-8?B?b0FoNGxmZlo3Nm9rK0UzZk5hUjJWdGRLS2NpVDJ5cGxUSzhOQTJGUGFFTytt?=
 =?utf-8?B?U1NuS1M4Y3VKK3hWTHNFcEdnZzJ0RHV4Nk5naW05UXdWYmZETjhzdExoOHQ0?=
 =?utf-8?B?dkt6dGlybXV5bVk4b3A2N0NkbUdoVXBUTjgzbFBoSkdqaVN5Yk10Z0tKVGg3?=
 =?utf-8?B?azBjUzhnaERGSElISTYzN2c2SlFXQ3ZuQ0I4Znd6RWt2NmtPZklnNkVNSDZx?=
 =?utf-8?B?U3dKdktWNklTNU80Y2Y0NEhhenlvbDhoM1JDbFl3L09QNVVhSXFab1pDUU8y?=
 =?utf-8?B?NlRvTUhlQXFsQWVTK0lzbWRZby8zMUwwNlA2U3htZFFQOExJaXBqRFlpN0ho?=
 =?utf-8?B?ZUxKcTZPalVJK3BSR3Zwa3VseDM2UkkvRTh0emtJNFpjalBnR3hxdkdSb0hJ?=
 =?utf-8?B?MFdPbHU5QmYwTVZUdm1hZ0NUd0hTQXVaaUxSdlFwaXZCS2pubmNlV0dVeFdR?=
 =?utf-8?B?VGFCRng4Q1NqYW1Fbkd5ZlI5djY3dnd4N0xLK3NqZFRZQkdJZ3ZscDJlVWFz?=
 =?utf-8?B?QVMyRFRDMm81bmFFb3Vja01vY016Ty9lTndxQjREZm9zeU10c1ppSUg5OWdB?=
 =?utf-8?B?R1o5U3Bjdk5zc2U0YWw4Mi9YQW5uSVBFMStqdWd0bk4zVVc3VG1GT2loTytS?=
 =?utf-8?B?c2lrbkFhOTZURGNCYXNNaXA1TURoMHdtUkJWekxvTzRvZUNBdTduY1FGQ0hZ?=
 =?utf-8?Q?0n+1Pl2snaj126ukzhgIL2c=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e84055a5-f88b-4b3e-fd06-08d9df9dbf94
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 00:58:06.7801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sz8gpwhrfjRKx3IE8RS/EYnmONgz+NQos9WobfTwm2sXfuoJlNRFv0EYuM7ffwLPONcYJqofLlfHmLDlQujnQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2874
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

Am 2022-01-24 um 16:11 schrieb Philip Yang:
> svm_deferred_list work should continue to handle deferred_range_list
> which maybe split to child range to avoid child range leak, and remove
> ranges mmu interval notifier to avoid mm mm_count leak. So taking mm
> reference when adding range to deferred list, to ensure mm is valid in
> the scheduled deferred_list_work, and drop the mm referrence after range
> is handled.
So this reverts much of your previous patch f0b45b5196de ("drm/amdkfd: 
process exit and retry fault race").

One one hand it feels wasteful to have the mm pointer in each work item, 
when we know that the mm pointer will be the same in all of them. On the 
other hand the pointers now properly represent references to the mm 
struct, and it's cleaner to track them per deferred list entry. Also, 
finer-grained locking is not necessarily a bad thing.

The series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> Reported-by: Ruili Ji <ruili.ji@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 62 ++++++++++++++++------------
>   1 file changed, 36 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index f2805ba74c80..225affcddbc1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1985,10 +1985,9 @@ svm_range_update_notifier_and_interval_tree(struct mm_struct *mm,
>   }
>   
>   static void
> -svm_range_handle_list_op(struct svm_range_list *svms, struct svm_range *prange)
> +svm_range_handle_list_op(struct svm_range_list *svms, struct svm_range *prange,
> +			 struct mm_struct *mm)
>   {
> -	struct mm_struct *mm = prange->work_item.mm;
> -
>   	switch (prange->work_item.op) {
>   	case SVM_OP_NULL:
>   		pr_debug("NULL OP 0x%p prange 0x%p [0x%lx 0x%lx]\n",
> @@ -2071,34 +2070,41 @@ static void svm_range_deferred_list_work(struct work_struct *work)
>   	pr_debug("enter svms 0x%p\n", svms);
>   
>   	p = container_of(svms, struct kfd_process, svms);
> -	/* Avoid mm is gone when inserting mmu notifier */
> -	mm = get_task_mm(p->lead_thread);
> -	if (!mm) {
> -		pr_debug("svms 0x%p process mm gone\n", svms);
> -		return;
> -	}
> -retry:
> -	mmap_write_lock(mm);
> -
> -	/* Checking for the need to drain retry faults must be inside
> -	 * mmap write lock to serialize with munmap notifiers.
> -	 */
> -	if (unlikely(atomic_read(&svms->drain_pagefaults))) {
> -		mmap_write_unlock(mm);
> -		svm_range_drain_retry_fault(svms);
> -		goto retry;
> -	}
>   
>   	spin_lock(&svms->deferred_list_lock);
>   	while (!list_empty(&svms->deferred_range_list)) {
>   		prange = list_first_entry(&svms->deferred_range_list,
>   					  struct svm_range, deferred_list);
> -		list_del_init(&prange->deferred_list);
>   		spin_unlock(&svms->deferred_list_lock);
>   
>   		pr_debug("prange 0x%p [0x%lx 0x%lx] op %d\n", prange,
>   			 prange->start, prange->last, prange->work_item.op);
>   
> +		mm = prange->work_item.mm;
> +retry:
> +		mmap_write_lock(mm);
> +
> +		/* Checking for the need to drain retry faults must be inside
> +		 * mmap write lock to serialize with munmap notifiers.
> +		 */
> +		if (unlikely(atomic_read(&svms->drain_pagefaults))) {
> +			mmap_write_unlock(mm);
> +			svm_range_drain_retry_fault(svms);
> +			goto retry;
> +		}
> +
> +		/* Remove from deferred_list must be inside mmap write lock, for
> +		 * two race cases:
> +		 * 1. unmap_from_cpu may change work_item.op and add the range
> +		 *    to deferred_list again, cause use after free bug.
> +		 * 2. svm_range_list_lock_and_flush_work may hold mmap write
> +		 *    lock and continue because deferred_list is empty, but
> +		 *    deferred_list work is actually waiting for mmap lock.
> +		 */
> +		spin_lock(&svms->deferred_list_lock);
> +		list_del_init(&prange->deferred_list);
> +		spin_unlock(&svms->deferred_list_lock);
> +
>   		mutex_lock(&svms->lock);
>   		mutex_lock(&prange->migrate_mutex);
>   		while (!list_empty(&prange->child_list)) {
> @@ -2109,19 +2115,20 @@ static void svm_range_deferred_list_work(struct work_struct *work)
>   			pr_debug("child prange 0x%p op %d\n", pchild,
>   				 pchild->work_item.op);
>   			list_del_init(&pchild->child_list);
> -			svm_range_handle_list_op(svms, pchild);
> +			svm_range_handle_list_op(svms, pchild, mm);
>   		}
>   		mutex_unlock(&prange->migrate_mutex);
>   
> -		svm_range_handle_list_op(svms, prange);
> +		svm_range_handle_list_op(svms, prange, mm);
>   		mutex_unlock(&svms->lock);
> +		mmap_write_unlock(mm);
> +
> +		/* Pairs with mmget in svm_range_add_list_work */
> +		mmput(mm);
>   
>   		spin_lock(&svms->deferred_list_lock);
>   	}
>   	spin_unlock(&svms->deferred_list_lock);
> -
> -	mmap_write_unlock(mm);
> -	mmput(mm);
>   	pr_debug("exit svms 0x%p\n", svms);
>   }
>   
> @@ -2139,6 +2146,9 @@ svm_range_add_list_work(struct svm_range_list *svms, struct svm_range *prange,
>   			prange->work_item.op = op;
>   	} else {
>   		prange->work_item.op = op;
> +
> +		/* Pairs with mmput in deferred_list_work */
> +		mmget(mm);
>   		prange->work_item.mm = mm;
>   		list_add_tail(&prange->deferred_list,
>   			      &prange->svms->deferred_range_list);
