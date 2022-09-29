Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF78C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Sep 2022 16:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 115C710E631;
	Thu, 29 Sep 2022 16:46:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B57A10E61D
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Sep 2022 16:46:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCg28JF6YahIv5gRN7NzEjkHgztET/MqAoIHSyfUug+2exR6ENO7uZehJFIhM3C+1+H9SwKMaLj9eoPb7NLO8hb7HQ296NF5CqzKiko2GZsMcjc2RU6+ZkCxSTeKTE2XtXKYYyrXXzCnVpt9pyfW8/qVjfPUmR+s30JupPu+VE4j7kBS8LTFunSEIvIjb/OOrd03f5oWVtglKg71DJyXtp9Lo/zSc4+73M1s/6dwE0yh4cHZzeGS8CLzvTNyjp80mWxB2arrJyEbYx0gJmwrrhGPrYgoBt1uD164HI+rDp+W7rXLcRe2f5up9rbPX/2v0JEWDGa0I3SZo0DngpgM3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvzi7DBfe9SLhF3Xw/LBBCswq6Cc4HoruyF+3eJ9lMg=;
 b=fE7bR6VyEcj2a6joDO5MtSPnItY+DCvQalpXCJTXrdReddZ5oE95Yhbt+DW00uLCyVLt/Z9rTmpLeq3T3AEXdQbcc503L8itx4VUedTOIQC4zYFkjQ8Cfe85+H4WvckjWSAvbS8l4XYTyVPzHxSQj6Ssa7ujLm2bEHXA2ejtrd6ClmPNiEtxqxsnX3muNxxNpSL/KCxoHepKcyMiPKF4y23UgAZXXN1yjzr7mPiKje0y0Bbms6E0TAidhmotnb+19Wbi+eOLRk6iRNQ5aRaFMZk8+bcf7Ech35CQ09YPiYDY6V+KkOdj+Ipzrc/7p/sD+Il3UYhHT0zRor83wa/6Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvzi7DBfe9SLhF3Xw/LBBCswq6Cc4HoruyF+3eJ9lMg=;
 b=BskesmpkTsymrEutOaxnx5qU5vt4QLzSDKa0VDBFONr+TD+GgdTWWA4EuTMOu/hhsdPiMWrnPUeg84NQRuqKjwwIW8gNrXLq9blVM6/ZAh2OwG8n6Qg41EDyFD9X6nUW9YWsJwDJHS9Rfab2h8FpliX6FHl7tUlDSSJGFaPd1+A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by PH7PR12MB7236.namprd12.prod.outlook.com (2603:10b6:510:207::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Thu, 29 Sep
 2022 16:46:43 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::3a6:8841:66ca:7d8d]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::3a6:8841:66ca:7d8d%5]) with mapi id 15.20.5676.022; Thu, 29 Sep 2022
 16:46:43 +0000
Message-ID: <bd9168d6-f6a0-dae6-aa27-ce6c88aafbb6@amd.com>
Date: Thu, 29 Sep 2022 12:46:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 1/1] drm/amdkfd: Track unified memory when switching
 xnack mode
Content-Language: en-CA
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220928161153.17523-1-Philip.Yang@amd.com>
 <cb7e741c-82ae-727d-f958-dc49cd06b7ad@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <cb7e741c-82ae-727d-f958-dc49cd06b7ad@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR05CA0035.namprd05.prod.outlook.com (2603:10b6:610::48)
 To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|PH7PR12MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: 98bd9986-d7a5-4465-3439-08daa23a30ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AEcPDKxEtbjQG0UYADyUxiyHYP9f+ErvFOzFoecBA1+lH6br01JTR2DmAg8ofhimh1yTL64ThXxB9uJvH25D60u7HuT1rW2SeC9bcszgdgjBRENBG3UI/Q0fm8Q9f6keylJyX1YHNyjeU8SYWvCf2ak4jTEuToT3YzJPHPQMuNImuc5xeRUQIGziCoi01GgufxKc9qGd2ghXyMTmtDCYbS6vUNC72kS7QQWPjjX8Fc0mlKRYwtPSQEpdCj+mAIO4rkF7T3JNgS1vGKwwtNB4Wzq+NJPoZQIDnR+7PukMP8Fp1gXxBHrKcSOUf92H5ipddrPkIcJKkWq8/xll730HloSbKxjfkxDc2mL0PLdYyZUC03UvYOYfr4m+ozc80o5s8aGtICW833eqoq3ybxB1PRsv+pGE0KFRE+q+VuMvCYP50xz89rrzuefUqr3k0e5xp05JASb0pPPhMY/6QcZZqra/hc190iqCl065DtP9oTpSQ5UJS7x44gauwS2l8fGIRFPW2RA1aIkLk2c6UqoA3+XmNxSA9BylRjVOFKRd1swWviuOCsOIACLSSGoYHcbx82GmULOY30JbCE21MA/ugBoDEZKFYkqbjCMguzii3lCnIL1TvmqZVRqZlVCIppnyaytgyrwfv56rGVMsk9xrSpvcZUSzvEPYA9XLEg1yN5EhWu/MtZDezhE9r6zvGoG8Y6yMgBareFJ5IVGkCjDDClTUf3ugGGCQ5/zo7BnXltuiO6FUHE9rROpXtOiN5mxgeUY88kXEQe/54vT5Jn7wW9pzCzuVdgY5qsF6aY+kuPg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199015)(8936002)(31686004)(5660300002)(36756003)(26005)(6506007)(31696002)(66556008)(53546011)(66946007)(110136005)(41300700001)(8676002)(66476007)(83380400001)(38100700002)(478600001)(316002)(6512007)(186003)(2906002)(2616005)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um9namZ1VG5HTGZTSVdtQ1p4bUVpeE9veXBlMmJpa0hFNlcrRThNNzZWVTFU?=
 =?utf-8?B?MFB6TmZ4R1F3MEdZMXNQTlVpTk1zaG9pMU9JMm1YczRWaFZTYXFaMks0d1NJ?=
 =?utf-8?B?Y1Y5d1JHNWZRa21CUHNQVWhBZWRLZGlnVlhDOFRIajVFbmd0ZFh6bFk0dkc5?=
 =?utf-8?B?Qk9vWXpwWmhFVUh2endHc29Ka2VERkdJeXJQcUc1VVk0NEZkblJLM0VJdGl1?=
 =?utf-8?B?RERJeVh5WWdtK3Uwa295WlNQT3loTnpNbmczSXBZcGd3WGc0UHh3VXRIRVhQ?=
 =?utf-8?B?UEtEa2JOU3BSVjYyazN6OE9OdFVsTHBuUFpQdmtnWjlZZ05MeWtISWsxSnBl?=
 =?utf-8?B?VDV0REgrZjZ0NkozMzRQdytWSTl6aitFZVVOVkI2b1FnN20rMjluQmRoTkJr?=
 =?utf-8?B?ellXSnNyeXd0R2hWMmdvSlNhK2RRenRlbHBoa0JHNENUZmFDbE84QzJITndp?=
 =?utf-8?B?eWpkUGpnSnBMdXJQc01JNTA4Y3V0UmZIS3J1VEJJV01icGdFQnZ2S1lGY2l0?=
 =?utf-8?B?bUF1d2lid0lVbThiZjhkc3RlUk1pYWhZSHZicXlnYjFtZG9wL1ZWek1obWNx?=
 =?utf-8?B?bjE1WUY2N3AvTzFwd0JTcGhIUmZSYm0zYzlEVFdveFpLY1FUWThqZEEvU1lj?=
 =?utf-8?B?aEF5eFEzaS9JNk1GNldOVUxSejVHa2R0Y3lhcnZnTkYwdDI0TnhJelJjWURa?=
 =?utf-8?B?YXlFTWxiQ25HaUNvTVo2SVdORnFOTnFybVpqbFc3RkRreVIyNGxaMEhVSSsz?=
 =?utf-8?B?d1U3Q2x0TkRZbWpXRFVteWU0Zk94ZS9yb2NYSFBYM2VwNUdGdUdhcHVZc053?=
 =?utf-8?B?Tk9BQWw1eW05Q0IvTTV4UWFOV3hCS3lEaG1MMGNWaWVNMFZQVmZ5VUJKQ25H?=
 =?utf-8?B?SnUvcDNIMHR0NU44Y1FCcFVSd09FNWdXV21NQTJyYmpzWEV3RUFlSXpGOGQr?=
 =?utf-8?B?cmV3bm1jcmtGSGRuS3NXK1BuMGd6YkZoaVdVZmN3RUM1N3RLNlRGUm1SOEwv?=
 =?utf-8?B?UGhicWpTcHN5Tk1Sb015bHNHZFl3TWxpcFZ1cWRORk0yQnRrSDhPZEltczFC?=
 =?utf-8?B?ZHZEbjJDU0hDdUpEZEgxQU5tOEYxUUtMa2ZlaHpTbURXOW9VT2VWdTZTK3Q4?=
 =?utf-8?B?amh4OWF1N0QvOHYrcUJxbnJlRlg4MnF3cXdiclRYVWt2cTJ5RHhWZTM2MGUx?=
 =?utf-8?B?QnpUVlJnSEF4NXpRbFphSWpyRnY4Q1hYSWd0WVJkci8wSFdMMmZiWHhpRXhs?=
 =?utf-8?B?ZW8yUEVzSlBIbUpuMnNQNGpQVGltWEE3RHFwNFh4WlFDWnhNdnZmRWQ3QXVJ?=
 =?utf-8?B?THJKUFNDc1FRQmxnRzZQbnFYQUlpMFgwajRiaFUwNTFjeU54QUsycTFsZm9h?=
 =?utf-8?B?KzNMT2E2Tit3VFNoY1NzVitKWk1JNlBFcXNHazF2ckwyWVJxU2FDMlpMejVD?=
 =?utf-8?B?bVlrSURrNnhkK0pmVzFRQVNRMGxidi9CbnE0bi90cy82Uy8zNVlVQjFYMGph?=
 =?utf-8?B?WGZzYWIzdGJub3RvbnpxSU9mQVdyVmdIdkRmMWo3Nnhvd0dUNFM3ZnJ1Rk0w?=
 =?utf-8?B?amRJZlZNMW9SQ285T0dnTGtmQzZueW5wcUhGMVhaTG5MdWIxaHc5N1FvQXZw?=
 =?utf-8?B?UWcxVlgzcFIrSGtlb000SWFsTXlaTm1FeWhGWVU3ZjBtblgycVNMVkh1TVBE?=
 =?utf-8?B?b0MzaW41bkpaN2hielBmZDhBcllLRjYwRmh2SEU0MXJsYW9wekl1TW5Xbnd5?=
 =?utf-8?B?dU1YdzlhdlJkSTJBbGFPdmMwTEdBUnhiVFNlTlAzRkNiK2R4UXd1aXhydTRH?=
 =?utf-8?B?U2xQeE16NTZvdnJRV1p1UDU5My9IQmJzV2VrSGR6WktPYlhWa1Y0WTJ0QWZm?=
 =?utf-8?B?bndrOUIxRGFnVXc5UDE2dTA4RVFPQ0NVSTNMN2pjbXhIVWNJekJJT0phdThK?=
 =?utf-8?B?WXZjLzVjVnhmL0lWMG8zUVFVRzhSbElNcDZiNlBsY3h2M2NMMGduTzd2T3Ax?=
 =?utf-8?B?aVltbG0yVXJJWlVtWnVGTDl1ajRmdWNpZDNYTWZNcFFDdWxBWWFFZC9uVCtk?=
 =?utf-8?B?NDRtRy94Vzh3a3dFWis0QjU3NzZVQk82SHVXVEc4ZW4zeU9vZ0s4aXZjalRN?=
 =?utf-8?Q?7/Ku9dRfQyJxcNywn5en1blJx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98bd9986-d7a5-4465-3439-08daa23a30ba
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 16:46:43.7221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f75xvnIvj9cLU2OPsh/RPE7NelBKXLMyCDq4q+5V2+YdDlluJvQoDiI2K9N+zhb0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7236
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


On 2022-09-28 15:02, Felix Kuehling wrote:
>
> Am 2022-09-28 um 12:11 schrieb Philip Yang:
>> Unified memory usage with xnack off is tracked to avoid oversubscribe
>> system memory, with xnack on, we don't track unified memory usage to
>> allow memory oversubscribe. When switching xnack mode from off to on,
>> subsequent free ranges allocated with xnack off will not unreserve
>> memory. When switching xnack mode from on to off, subsequent free ranges
>> allocated with xnack on will unreserve memory. Both cases cause memory
>> accounting unbalanced.
>>
>> When switching xnack mode from on to off, need reserve already allocated
>> svm range memory. When switching xnack mode from off to on, need
>> unreserve already allocated svm range memory.
>>
>> v5: Handle prange child ranges
>> v4: Handle reservation memory failure
>> v3: Handle switching xnack mode race with svm_range_deferred_list_work
>> v2: Handle both switching xnack from on to off and from off to on cases
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 26 ++++++++---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 56 +++++++++++++++++++++++-
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  1 +
>>   3 files changed, 76 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 56f7307c21d2..5feaba6a77de 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -1584,6 +1584,8 @@ static int kfd_ioctl_smi_events(struct file 
>> *filep,
>>       return kfd_smi_event_open(pdd->dev, &args->anon_fd);
>>   }
>>   +#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
>> +
>>   static int kfd_ioctl_set_xnack_mode(struct file *filep,
>>                       struct kfd_process *p, void *data)
>>   {
>> @@ -1594,22 +1596,29 @@ static int kfd_ioctl_set_xnack_mode(struct 
>> file *filep,
>>       if (args->xnack_enabled >= 0) {
>>           if (!list_empty(&p->pqm.queues)) {
>>               pr_debug("Process has user queues running\n");
>> -            mutex_unlock(&p->mutex);
>> -            return -EBUSY;
>> +            r = -EBUSY;
>> +            goto out_unlock;
>>           }
>> -        if (args->xnack_enabled && !kfd_process_xnack_mode(p, true))
>> +
>> +        if (p->xnack_enabled == args->xnack_enabled)
>> +            goto out_unlock;
>> +
>> +        if (args->xnack_enabled && !kfd_process_xnack_mode(p, true)) {
>>               r = -EPERM;
>> -        else
>> -            p->xnack_enabled = args->xnack_enabled;
>> +            goto out_unlock;
>> +        }
>> +
>> +        r = svm_range_switch_xnack_reserve_mem(p, args->xnack_enabled);
>>       } else {
>>           args->xnack_enabled = p->xnack_enabled;
>>       }
>> +
>> +out_unlock:
>>       mutex_unlock(&p->mutex);
>>         return r;
>>   }
>>   -#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
>>   static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, 
>> void *data)
>>   {
>>       struct kfd_ioctl_svm_args *args = data;
>> @@ -1629,6 +1638,11 @@ static int kfd_ioctl_svm(struct file *filep, 
>> struct kfd_process *p, void *data)
>>       return r;
>>   }
>>   #else
>> +static int kfd_ioctl_set_xnack_mode(struct file *filep,
>> +                    struct kfd_process *p, void *data)
>> +{
>> +    return -EPERM;
>> +}
>>   static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, 
>> void *data)
>>   {
>>       return -EPERM;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index cf5b4005534c..ff47ac836bd4 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -278,7 +278,7 @@ static void svm_range_free(struct svm_range 
>> *prange, bool update_mem_usage)
>>       svm_range_free_dma_mappings(prange);
>>         if (update_mem_usage && !p->xnack_enabled) {
>> -        pr_debug("unreserve mem limit: %lld\n", size);
>> +        pr_debug("unreserve prange 0x%p size: 0x%llx\n", prange, size);
>>           amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
>>                       KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
>>       }
>> @@ -2956,6 +2956,60 @@ svm_range_restore_pages(struct amdgpu_device 
>> *adev, unsigned int pasid,
>>       return r;
>>   }
>>   +int
>> +svm_range_switch_xnack_reserve_mem(struct kfd_process *p, bool 
>> xnack_enabled)
>> +{
>> +    struct svm_range *prange, *pchild;
>> +    uint64_t reserved_size = 0;
>> +    uint64_t size;
>> +    int r = 0;
>> +
>> +    pr_debug("switching xnack from %d to %d\n", p->xnack_enabled, 
>> xnack_enabled);
>> +
>> +    mutex_lock(&p->svms.lock);
>> +
>> +    list_for_each_entry(prange, &p->svms.list, list) {
>> +        list_for_each_entry(pchild, &prange->child_list, child_list) {
>
> I believe the child_list is not protected by the svms.lock because we 
> update it in MMU notifiers. It is protected by the prange->lock of the 
> parent range.

Yes, svms lock can not protect range child list, we should take 
prange->lock to access range child list, because prange maybe split to 
child ranges by unmap MMU notifier in parallel, taking pchild->lock is 
not needed. Will send out v6 patch.

Regards,

Philip

>
> Regards,
>   Felix
>
>
>> +            size = (pchild->last - pchild->start + 1) << PAGE_SHIFT;
>> +            if (xnack_enabled) {
>> +                amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
>> +                        KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
>> +            } else {
>> +                r = amdgpu_amdkfd_reserve_mem_limit(NULL, size,
>> +                        KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
>> +                if (r)
>> +                    goto out;
>> +                reserved_size += size;
>> +            }
>> +        }
>> +
>> +        size = (prange->last - prange->start + 1) << PAGE_SHIFT;
>> +        if (xnack_enabled) {
>> +            amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
>> +                        KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
>> +        } else {
>> +            r = amdgpu_amdkfd_reserve_mem_limit(NULL, size,
>> +                        KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
>> +            if (r)
>> +                goto out;
>> +            reserved_size += size;
>> +        }
>> +    }
>> +
>> +out:
>> +    if (r)
>> +        amdgpu_amdkfd_unreserve_mem_limit(NULL, reserved_size,
>> +                        KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
>> +    else
>> +        /* Change xnack mode must be inside svms lock, to avoid race 
>> with
>> +         * svm_range_deferred_list_work unreserve memory in parallel.
>> +         */
>> +        p->xnack_enabled = xnack_enabled;
>> +
>> +    mutex_unlock(&p->svms.lock);
>> +    return r;
>> +}
>> +
>>   void svm_range_list_fini(struct kfd_process *p)
>>   {
>>       struct svm_range *prange;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> index 012c53729516..7a33b93f9df6 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> @@ -203,6 +203,7 @@ void svm_range_list_lock_and_flush_work(struct 
>> svm_range_list *svms, struct mm_s
>>   void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
>>     void svm_range_set_max_pages(struct amdgpu_device *adev);
>> +int svm_range_switch_xnack_reserve_mem(struct kfd_process *p, bool 
>> xnack_enabled);
>>     #else
