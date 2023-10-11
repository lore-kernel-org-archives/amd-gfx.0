Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9420ECDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Oct 2023 20:17:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2378F10E17F;
	Wed, 11 Oct 2023 20:17:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4095A10E17F
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Oct 2023 20:17:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMhbDItkxB1gEA0V5ektRuRsy/bKqgpmPjvQMRPg9sVwqDfmQYR95EX2d1/FS5l5xZtbaQFuKdCvdB8aA0yCVEsexOLrGtVdA8dn98Ms7nGoiudslCtgydLzNJgC1JwIBy26puqr19zPQXRMUYxKgqQROkddoBMrkWgxuK+bYWtfr67ZDecCxMYIOgzKt4C/oO8xlcHRYYIzLUtKUl2gQ7EZazykOPrNLcu5REuFxS39SwevvGGIgcjOvjZqfxzdBSd4ZwGugsIcQIm//AWAdyo7WNYTlObi0S3oAWtnE9vJBeRXtEwkj778lLUjju0cHvqqkxgGQ4hhYMODj5wqfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7QC8MOZvf0R4XqF+f73cpigw2Sbvj39QnZjhrjfA6A=;
 b=FqIHw8ERIL0rnzlzga8ANsePjQ6lvVPdVD9K9BS7LgrO1LSmjRs939OVuPKttquB7fAF6oI6za01qy687CGHlYJEc5Q7F7J6DN+Z+djJg8Sm8X5R28mlDr9y11G2DmPsz2rNBwC4TcYgUrGlufD9gbVJ+/I8srjjYJ0e4qERFD8ukbvWAI+g2KOkcAgt2Fq7lOBaoocWYqHYkHjMrS546tQ6tmCv3fLYepDDckOH6rsIrHrCVsF3Bmj2RxyXcDKuPWuBNjSyZNENavlheriu+wVOKTCNvQaU9rjVgCamZYaqXp0S7gSEfoMvei52fAmCikyazFTIr3yezPxLaDu+ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7QC8MOZvf0R4XqF+f73cpigw2Sbvj39QnZjhrjfA6A=;
 b=slHQ7ZjNwHn7mo7YH6WewsmwNDc8APr451H9wBgHEuJpmh6v+5D/Gh2F3RrEt8lGIYkT3+T/KL45gOpUUINvCn0+btXVUXYdZJVBOHGLc12kgpMQiv6L3KpzTzeHm7y9gSTK+lV9u1N1X7Hk1er/0X8aIUhE+dTefa3ObQDJTWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 SA0PR12MB4526.namprd12.prod.outlook.com (2603:10b6:806:98::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Wed, 11 Oct 2023 20:17:42 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::f381:62fe:194c:ad48]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::f381:62fe:194c:ad48%3]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 20:17:39 +0000
Message-ID: <6ebed308-fcea-3114-95ed-7952b96e0eec@amd.com>
Date: Wed, 11 Oct 2023 15:17:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 5/7] drm/amdkfd: Check bitmap_mapped flag to skip retry
 fault
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231010144024.3016-1-Philip.Yang@amd.com>
 <20231010144024.3016-5-Philip.Yang@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20231010144024.3016-5-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0063.namprd13.prod.outlook.com
 (2603:10b6:806:23::8) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|SA0PR12MB4526:EE_
X-MS-Office365-Filtering-Correlation-Id: 734db7d3-7251-4369-15ab-08dbca971e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a63OrCKBMXH6ZvIDwkx1t87Vx2DJCX+G4iy1U6600j+FwxiIVZSF/+H5WPas4r/ReURK8vEzH05EHkDCgvgiBuC03cZ5QZcSlqUnCP/tL+112sWixtL4TyQNUKZhMYx5LHm0oe+m9e1haKI8qEW2lxVWtNt2/g+vGxttIgdXf/RDa7i1w0bKp0aC6tVpQEv9OQHuq51M3WaFImCtVlA2ZUrjWW5RJ08gzQ7p5/yewk0pzMZ6dljLenNGt1OBG7uti3kOlGSUaAkHQ2Pt3W9m6otUVwgNB0jrU8qfgmwj90nmgNfRCMHstt9cArwdiwKbPR0Fkde4OlBwbKvkK4TWnmr4LSBnVBudqOzW3HU1ArSh5jVPhZL0EfMvbq15LVq1g6zVWFcEY6lHZ2mikhM31/OEO3MzYSHn8r2c6p+6nucb2SXisBZT39S4/NyFeTuG4ckysFPt+qrp1otQ3oQosvuq5Bm0GqDmgZlOX1AmwOlpHSdp1B5/9cSxNFXY8sjJ7E/FkHno1J9LWyrvxyZZ7lJVzJzfLi+kXZqhZ5CxToRI3NhTcpn+z2eH/nuCkmz0nCAhh1KVJfzpjTtnFxn+J16N2RaQD+5Eed214t9QZsL4jamV6YfKBBdDydZsnAoui/kWbDca+6k4LxkdHo8j4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(2616005)(31686004)(6512007)(53546011)(31696002)(38100700002)(36756003)(86362001)(26005)(8936002)(2906002)(83380400001)(66556008)(6486002)(6506007)(478600001)(41300700001)(4326008)(8676002)(316002)(66476007)(66946007)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0NrK3JCRXcyOGR6eHFpRXdnUHl2NzJuMS8rMHVZNDRxa3ZGYU9yUVEzYXhY?=
 =?utf-8?B?R210RmZueHlJTXEyTzh6djNETGpQVTVtbHQ4K2xhZ3lWU2JvMW55a2ZDd3hI?=
 =?utf-8?B?ZmZSVXJvdzgxRnlIeHcvVEZTOE1Wdk1nSHowa2lUTnpJU0hpdFdPQlB1TitR?=
 =?utf-8?B?UktzODVXamlaRGtUcXRVblVyV0huc0dBNHpPS21JKzhNSnRMNEZveTlmZFNP?=
 =?utf-8?B?TVJFUFcvT0kxQ0taSml6cnYyS3BqNWxrbnBDRmc2azloM0tRRkFLN1lMa2pJ?=
 =?utf-8?B?VWQvMGxwYVVmUFV3cnNJTitKOGZ1TUNsdnFPN2dVLzh3SU1XeVlucWtHRnRD?=
 =?utf-8?B?SnBRYkYxa0pMcnRrVFJsKzY0Y0w0SkR2cDRhcTJMZGtSd2FxbWRDZVQ5aG1I?=
 =?utf-8?B?Sk8wRmppYldsNjI4VHJwMU4xbHYvTVE5S2U2NEdZdUJNMzlNMGRka1k4N1Zm?=
 =?utf-8?B?NTRWRkQ5MUEzNzV5b05YZ2M4MFN0Zk93SWozMXVUbkx3SmsvcC8rNm1FTjZ5?=
 =?utf-8?B?L2xwaDgxQStzcUVUL0JEcldqa2U0VW5CdkJvMnNYc1hCNnk1d0o5UXRkVHN0?=
 =?utf-8?B?THgyM1ovcU5KK1dYMDB0SGxMMk1CRnhJeUZ4aGRJbFR0UWtrbUMrR0Z5ODB0?=
 =?utf-8?B?MmpWL0JBUm44SFZOQmFxWmxsUTU3djVvWTB3TEpCanJqZnpPaEhQZmg5SURv?=
 =?utf-8?B?eHRtdkVJWXhoRGd6WDZ6NHRzQm5vTGh5R3dMK0RweEc2Y2svWGVSc1drR0lQ?=
 =?utf-8?B?bVN1aTRud0xZbmtrRzdNMjRQSzdEd0VRS1BPM0hRQTJhTnZIUnV5RkE3NTN5?=
 =?utf-8?B?YjRPT1BoMG5sUVVnRnVWNTBqQ0RHaXdzR3ZkV1B6S3drZ3lHNmpEcmY5aWVz?=
 =?utf-8?B?eGJaWmRDTkdaNXA1YXJLVXc4ZGlWQWdESW5ZOXlndnB6ZzJld0k1V1VGaFJM?=
 =?utf-8?B?MFlWRjNaWmR6R0owN2xDK1pWc3ArYnBiU1Q2RlUybVlsbkZxVGlqVlJ6bVB2?=
 =?utf-8?B?cUxUUDd5YjhKTXBjaTBGQTZsNDNBUUlZVjZ1MnFnWlJZRlFjcTlHWU1oMFZu?=
 =?utf-8?B?enpOVVQ5KzdWUXduT21ETHlFS05McUJYbGptYzVRT2xSTHBlZjdOSjBZOXlN?=
 =?utf-8?B?ZXBXMXRYOW5NbXFtRjZSYkJmYXlwbFhuNmNzd09rOTBBNUJWYXhVcTlLTU5i?=
 =?utf-8?B?S0c3ZGxyaFlrMC9GWWxlYy9YVFRhaUZvWjExNm1GNnJDdVV4cXZFQmN3ZHVk?=
 =?utf-8?B?T2NWa3RneHVKb0cwMGtTY3lzRWlnRnlTcnVEUDF2Mm40QVNUY1U5R0pYR2dB?=
 =?utf-8?B?MXBjM2tmV0tJWkxnT2gwNHpaMkxJeEdqVXZGRXVrdnJPMmtSZWxmSEVDa1BX?=
 =?utf-8?B?bS81L0lacG1yWSsxSFM0K2NZY0RBZ2ZjM2IyOUFVTk5PMUR1UnZrQlB5VnlK?=
 =?utf-8?B?VFFwenFWWGZPSW02VExnZ0E1Sm1BVjgxTUJWNVVPN3B3VFhVWmYrSzBneUlz?=
 =?utf-8?B?enNXQlZtelBHdVcwb0ZwUHloSVRyU05TMHl3azNzWGNkUnlCQVpjd1dyVzhD?=
 =?utf-8?B?WUR4WUdUVVRFZkZaeWJJMGdLQ0xaSkRLT2xkeGRJc1N1a0U2WHA1cWt4aG5P?=
 =?utf-8?B?d0lQd2ZSWFYyOVpaekROenFYWVhSeitBdy8wek02bmQ0MlVsN1JzTWFWMHFN?=
 =?utf-8?B?QzB2TFVFTVJiejFKcW1temtUQUtLcS9QU2xOR3BWbHFoalBqR2VlVHhhcWdJ?=
 =?utf-8?B?S21CWTBZMGdrQzZ1QnVwQUpXK3NiTEZpVGdqaHFKcW02Nk0zcnh6OGVmS1VS?=
 =?utf-8?B?ZWQwNjg1b1NXVGtzYWdJOXVqWmNWamNnZlZib1pvdVdsRjlwMFg3TG13UDhO?=
 =?utf-8?B?S3djVmZPbU4vMWhMa21sWTNJRGFQLytrdTVIa293RXBLK3FBZGI4L1RQTGZB?=
 =?utf-8?B?bHRxVzE5TDM0WVQ1c2I5dTlnNVFXMXBTMkVQT2pIZ2VKTFZJc21FMUVrNWJp?=
 =?utf-8?B?eEFqNXBYMFU2dkkwbGhXekpiNzAzd1RzVzRDbXZFNDBjak5uSVRrdER4ZHhK?=
 =?utf-8?B?TWxnTU5xVE1sVTlCMUdYdUNyNVpDODVBbUFqcHV4cVIrT1gzd2FuVHNKM0xX?=
 =?utf-8?Q?Cx/U=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 734db7d3-7251-4369-15ab-08dbca971e07
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 20:17:39.7134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ojs8YB1TnleOwFpDhxQfQacPkrpJmKP8KZzy62JKik2G4l88g0fPxd2FBNE2Y1UM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4526
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 10/10/2023 9:40 AM, Philip Yang wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> Remove prange validate_timestamp which is not accurate for multiple
> GPUs.
>
> Use the bitmap_mapped flag to skip the retry fault from different pages
> of the same range if the range is already mapped on the specific GPU.
This should be "different pages of same granularity range" as comments 
inside function svm_range_restore_page.
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 24 ++++++++----------------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  1 -
>   2 files changed, 8 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index daa996d7039d..0ee5633c8972 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -43,10 +43,6 @@
>
>   #define AMDGPU_SVM_RANGE_RESTORE_DELAY_MS 1
>
> -/* Long enough to ensure no retry fault comes after svm range is restored and
> - * page table is updated.
> - */
> -#define AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING   (2UL * NSEC_PER_MSEC)
>   #if IS_ENABLED(CONFIG_DYNAMIC_DEBUG)
>   #define dynamic_svm_range_dump(svms) \
>          _dynamic_func_call_no_desc("svm_range_dump", svm_range_debug_dump, svms)
> @@ -369,7 +365,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>          INIT_LIST_HEAD(&prange->deferred_list);
>          INIT_LIST_HEAD(&prange->child_list);
>          atomic_set(&prange->invalid, 0);
> -       prange->validate_timestamp = 0;
>          prange->vram_pages = 0;
>          mutex_init(&prange->migrate_mutex);
>          mutex_init(&prange->lock);
> @@ -1938,8 +1933,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>          }
>
>          svm_range_unreserve_bos(ctx);
> -       if (!r)
> -               prange->validate_timestamp = ktime_get_boottime();
>
>   free_ctx:
>          kfree(ctx);
> @@ -3214,15 +3207,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>                  goto out_unlock_range;
>          }
>
> -       /* skip duplicate vm fault on different pages of same range */
> -       if (ktime_before(timestamp, ktime_add_ns(prange->validate_timestamp,
> -                               AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING))) {
> -               pr_debug("svms 0x%p [0x%lx %lx] already restored\n",
> -                        svms, prange->start, prange->last);
> -               r = 0;
> -               goto out_unlock_range;
> -       }
> -
>          /* __do_munmap removed VMA, return success as we are handling stale
>           * retry fault.
>           */
> @@ -3248,6 +3232,14 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>                  goto out_unlock_range;
>          }
>
> +       /* skip duplicate vm fault on different pages of same granularity range */
> +       if (svm_range_partial_mapped_dev(gpuidx, prange, addr, addr)) {

should use svm_range_complete_mapped on gpuidx, instead of 
svm_range_partial_mapped_dev?

Regards

Xiaogang

> +               pr_debug("svms 0x%p [0x%lx %lx] addr 0x%llx already mapped on gpu %d\n",
> +                        svms, prange->start, prange->last, addr, gpuidx);
> +               r = 0;
> +               goto out_unlock_range;
> +       }
> +
>          pr_debug("svms %p [0x%lx 0x%lx] best restore 0x%x, actual loc 0x%x\n",
>                   svms, prange->start, prange->last, best_loc,
>                   prange->actual_loc);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 7e165854bc0e..7a12be42cf16 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -129,7 +129,6 @@ struct svm_range {
>          uint32_t                        actual_loc;
>          uint8_t                         granularity;
>          atomic_t                        invalid;
> -       ktime_t                         validate_timestamp;
>          struct mmu_interval_notifier    notifier;
>          struct svm_work_list_item       work_item;
>          struct list_head                deferred_list;
> --
> 2.35.1
>
