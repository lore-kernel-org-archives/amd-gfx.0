Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96593C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 02:15:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BD92610E6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 02:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5BD92610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 887AC6E2BC;
	Thu, 30 Sep 2021 02:15:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADCD56E2BC
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 02:15:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUXeVcB5kiEMo0lV5CM0dKrykiAzJVUOSToxqPV0320AnXM4YUvooGuf+j48DRhBLA/Qfk/3J0ECep/AZ2Xk/v8DYgp5v9M/6KGDae4/oSGNYN2HI+ZOEdpolHQiXlKmG2oaDuvp8B1y9PBfvcjU4E71h1nDMNE7cl7uKb5CJtLjBBPAHgNOm+VIVHM8yVmcDd1FBndvGpNF2LLJTI2WHOb6p4FFC5zJdrV1kfFkj0DN/gXGiYhE2/ehpLXTAyS46qpD+kcBY4xt5rpS4MhpKjpzZjFmz/Rl0G0JnL4Mw450nFLkRyME0o1/vfsnqEJsEhiSewyviLSwklE0JcOdHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=t6cbXW7YDiOWH5zC9z67ice9EDGHPxKLJup6U7O8VwA=;
 b=FCvBWJ5P09hJnOoZ8xTRcerh3M1yo28mq2AA7EqP4Z/KM1kJ5UluU+tk3XTY+yLR/voOZKfp6M3bGD8ZXE7HfLsucnTDvFOnh0FkfLCxng+vaIctgIm7EaSqBrRJvijsuG6q/4q5Prv+yURSOkl8T/lFIHVJ46AoQpKbLXJvSy7O9u1tEFcVZQYYfK5rDaS7MNi2FAiiET49EVje6DDBIaxvw9dU2pm1JHccVV+dNBDFg2PNvRa9mlNUdn604aPJGuz87D5E9U+pvdi6ME4+Cb4yUur0BmlCr4eEYDZdOCo4qvHP+F/MksyVDe4wvJlj/piKIK1n27NIFkl5DkDqvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6cbXW7YDiOWH5zC9z67ice9EDGHPxKLJup6U7O8VwA=;
 b=mdSrPRXqxe/btsxeH2VmFECYPqPo55BFUFpevtqUEqsro1CFMWS7Tbl2nr83CyGOx1fBb2C5Gc2uiIcNjG4NgLYIJytisNKwhf3EQa4EiPEEwdCNxReLHbggCpyJd4gpZQtzo7WfM6AjY8McdxzI++Nj7AgbyanOJYR1c+O9aY0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB2481.namprd12.prod.outlook.com
 (2603:10b6:404:a7::10) by BN6PR1201MB0145.namprd12.prod.outlook.com
 (2603:10b6:405:4d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Thu, 30 Sep
 2021 02:15:12 +0000
Received: from BN6PR1201MB2481.namprd12.prod.outlook.com
 ([fe80::dd15:b4fe:60de:266e]) by BN6PR1201MB2481.namprd12.prod.outlook.com
 ([fe80::dd15:b4fe:60de:266e%9]) with mapi id 15.20.4544.022; Thu, 30 Sep 2021
 02:15:12 +0000
Subject: Re: [PATCH] drm/amdkfd: avoid conflicting address mappings
To: Mike Lothian <mike@fireburn.co.uk>, Alex Sierra <alex.sierra@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20210719211857.29954-1-alex.sierra@amd.com>
 <CAHbf0-Ew51w4U9b1Z9Jw1gCEz2gJKSZWOC47eb-XJYT2tgVSYg@mail.gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <b7a56aba-a142-ca6a-a609-bec8dad507c3@amd.com>
Date: Wed, 29 Sep 2021 22:15:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAHbf0-Ew51w4U9b1Z9Jw1gCEz2gJKSZWOC47eb-XJYT2tgVSYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::40) To BN6PR1201MB2481.namprd12.prod.outlook.com
 (2603:10b6:404:a7::10)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YTOPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Thu, 30 Sep 2021 02:15:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a109941-1597-4b84-203c-08d983b82269
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0145:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0145B52BA576389CB553B16192AA9@BN6PR1201MB0145.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KjAbZvCCer9BDU3S3t4UgAiwXEzjlqD49v5CJjxQiAKPrEP2vLRMtlfYycK6YoS7gT9JZZmCV8arhPdIiqXEPgmtrgixHzrsSYVvza4xJNU64oVxJYQA71kWl/tatb50qustECfp6jPEPBsEyg+TiUAoQiOEtLHDItJyK7BZHeMQK567qInC3DMa4RatQmQlgc7+rGMaQ/Lp/bs4RO6keYfQKY0MfRdJMe5VUC+qFF5/ijDxntYdLDH9MpVhiZh7X+ZcbQBtksFQdQGCWzVnzTFnPyHk8rtWd3/oryYmMmVBpXxhGswBFiSwqCmEMZaptCAE7G8KLdpXjyGlMv93ZYGuIH0P/LX7WEgxAGtBQDVYjel1UXZoRbxiDOasaMA9gFD2EIdo1Z3HsrU3XriMRw5z9FU9rnFm28X18yM/UdfWG6On3j/z3g1KHObTI3s03b7RARwPW8x98UyjuNr1GioKR8t3ahx7byW5kjIKFXSi4lvCypm82w09Uz/WQYjm9IdMxw2ROgdL6+B1NeBU1BOr8yC59pqD0pi/HJIiBRj+vQvk4HHJSuvPv9vF+oO6+1deH1KaVJG5xuw3rojKcdXyAJ/q+Zbu8aoEahmBm71acUm9EZVlg4b/gczimURpkqbzp8D7TCXUgNVDVXOqam0bGyGoFnp9M21U0UAqYhhwm30VgvLztCIPcDpU3TAPOcyVyS/fMue6EePQM20LvU2UyleMxRfsxHm3UoFV4u2nLri8AzrzL9hcSdM5iGED
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB2481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(53546011)(2616005)(956004)(2906002)(66556008)(6636002)(86362001)(5660300002)(44832011)(66946007)(36756003)(26005)(38100700002)(66476007)(4326008)(8936002)(6486002)(8676002)(83380400001)(36916002)(110136005)(31686004)(966005)(16576012)(316002)(31696002)(508600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MSs0WHRqSmJWc3VVMmJQTmJRajdTbWhIRElvL21nVzZOUHZuTnZjRlNzWXha?=
 =?utf-8?B?eDdJbGtyVW43ejErSEpqdXlJUnRyeEViZ3pqQ0F6YlhoU2p6eHNFTTN2QjJ6?=
 =?utf-8?B?ZGROQXoyRExTUTdjdFhYU1ZCelArWUZlUGNUY2tXbk4ydTRsUTkva2FJeWYx?=
 =?utf-8?B?R0I0Q3hFSXpwWGRCTS9IVEwvZU03NHo5WlQxSk5DTHZlVXpiTzdHK1RvcFho?=
 =?utf-8?B?VkxLZmVweng4U3p1SHBtTlRwVGNBVG5NdHc2eFIzalk1QkIxbUt6blRBTzRB?=
 =?utf-8?B?NHo4ZGZaVXlhQjVXK0FqWm9qQ1ErU3pabHY5Skl1ZTVlOWZZQVlEQ0xOL3Jx?=
 =?utf-8?B?dHkzY05EczZqbmVEVDljMlRGMUh4RXozbUNhS1RRcmxZNmprd0NYemFJRVZU?=
 =?utf-8?B?bmU1ZDc5dkVZV0NSOW0wMktVVFM1K1YvdTNqTm9vNW11MURkUlBpdGU0UzFO?=
 =?utf-8?B?Y3hnQ0s2STg2YzVQOFZOV2poNXQ1NStydzBsMThhdHhzRkRETS9SK2VSZ3ZJ?=
 =?utf-8?B?YzU4ZTM4S3Y4NjF0c0xGSnR3bWc1WnVRRnJhVEs4a2YrZk4xTEs1b2pFbGRY?=
 =?utf-8?B?RUtTNXNTcXp6MGNsQnlaOERTSGN2eG4wdHNmbDlOMERXQnpPTWlpekdZWEZs?=
 =?utf-8?B?ZG94MXJWNm5wSEJFck9qUlc5TWNtTW9vQkI5OXVLZHlaN2U3UHJNd2ZXSFI1?=
 =?utf-8?B?eWs0MTJqUzFKRHp5a3hhTjZwaEoyMGZrRCtxY0ZSN1lzc00xSmZFNmxrNWM4?=
 =?utf-8?B?VUdNTW5uZ0dwYjl6aDdkWnpPN3hQQnB0dWlZVDk0RlZMcTJkbXA2VjYvR1lr?=
 =?utf-8?B?WS92S0xpczZkSno3M1BlK3Z4em45bUx4SXl6TFdpNW9TUVNEaG1SZU1SVWNx?=
 =?utf-8?B?VUZmeWtoVmU5MWJwaHFJaHNnd2FaUjhJWkdTR0krZ1hkRHh4M2d1VjlmeEFJ?=
 =?utf-8?B?b2xEMW1aZXppMmhRMU44QnVZNlFtUm9FVkp4VytDTlh4bHFDMEN1djVjNHNB?=
 =?utf-8?B?cTlOc1doOTR0VWFYUDM1eVVaUXR2WWxkOTJ1RmhReFdzL2trY2lReGUvQlMz?=
 =?utf-8?B?RVByN05NMWFkWXhMS0YxcnFaamRuR1lTNWxycEtXWkFhTjlNYW9jZkplbWFG?=
 =?utf-8?B?QTMySmRtSDlLS3VhRTQzdU5odEM0ckltemlIYXFXYXpNUWM4Q3IvTmdrMEhm?=
 =?utf-8?B?RzZ6UHc0Y0htVXp0SU13bEFIa1dCUlN3WjUvSzFlZnBlUmloQVZTQlgwZFNG?=
 =?utf-8?B?TUYyMXJQUVluQm4yRGtCbmoxNzFmYmZsOVd4YlZhbjdabEVwYncybEF0Zmdi?=
 =?utf-8?B?SWdPeWEydkVRdEtqNlQ4VHh6OTlBbnI3SCtaWnJNODV6ZTJBdENpSEJVTFZp?=
 =?utf-8?B?U0kzdzB3anZjYnZYYWJmbFU4dUlwajRPRXlpaVZBNHJWWGxCWDh2OGJmQ2NE?=
 =?utf-8?B?dGVXVXBnTkRBUTE5clNIVVNkbVNjWGo0N3RkYW1PaUVzOVQzRnFNTC9hMkJv?=
 =?utf-8?B?V092eW5lbkxnNkVKcWVSSmpkUmRZTlFMdnljMEhTZnJ1WTFkMDR1aGg1Z1FM?=
 =?utf-8?B?QW82YmZjRW9hWmNQYlAzakhQTHJScjQ5eC90ZkNFbDlka3dyYWE4S3p0YkdE?=
 =?utf-8?B?QjQrMkNEb29jWGEzdGcyVjRnRFJ6d3pMYzlqYU9ueHFNWnlCZ0s4YzAwT3hz?=
 =?utf-8?B?bHB2T1h5UVBHdWJ0VnllNE5qd0dZSk45Z1ZwWlNaQjMzcWFMbTFZcWt1Vzh0?=
 =?utf-8?Q?0bdsF/VjOhjWk50IAiBMC72CTwf5SX77w6DX7Re?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a109941-1597-4b84-203c-08d983b82269
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB2481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 02:15:12.7460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhGVQ3dBnkmoUAoFNLTUdEWeXzrM7/Utstka/OPt0F2ImBYTRLQjF0YRgTcf2zd5+VhDcvfMJ68zUaxPO/5ZBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0145
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

On 2021-09-29 7:35 p.m., Mike Lothian wrote:
> Hi
>
> This patch is causing a compile failure for me
>
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_chardev.c:1254:25: error:
> unused variable 'svms' [-Werror,-Wunused-variable]
>         struct svm_range_list *svms = &p->svms;
>                                ^
> 1 error generated.
>
> I'll turn off Werror
I guess the struct svm_range_list *svms declaration should be under #if 
IS_ENABLED(CONFIG_HSA_AMD_SVM). Alternatively, we could get rid of it 
and use p->svms directly (it's used in 3 places in that function).

Would you like to propose a patch for that?

Thanks,
   Felix


>
> On Mon, 19 Jul 2021 at 22:19, Alex Sierra <alex.sierra@amd.com> wrote:
>> [Why]
>> Avoid conflict with address ranges mapped by SVM
>> mechanism that try to be allocated again through
>> ioctl_alloc in the same process. And viceversa.
>>
>> [How]
>> For ioctl_alloc_memory_of_gpu allocations
>> Check if the address range passed into ioctl memory
>> alloc does not exist already in the kfd_process
>> svms->objects interval tree.
>>
>> For SVM allocations
>> Look for the address range into the interval tree VA from
>> the VM inside of each pdds used in a kfd_process.
>>
>> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 13 ++++
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 79 +++++++++++++++++++-----
>>   2 files changed, 75 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 67541c30327a..f39baaa22a62 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -1251,6 +1251,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>>          struct kfd_process_device *pdd;
>>          void *mem;
>>          struct kfd_dev *dev;
>> +       struct svm_range_list *svms = &p->svms;
>>          int idr_handle;
>>          long err;
>>          uint64_t offset = args->mmap_offset;
>> @@ -1259,6 +1260,18 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>>          if (args->size == 0)
>>                  return -EINVAL;
>>
>> +#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
>> +       mutex_lock(&svms->lock);
>> +       if (interval_tree_iter_first(&svms->objects,
>> +                                    args->va_addr >> PAGE_SHIFT,
>> +                                    (args->va_addr + args->size - 1) >> PAGE_SHIFT)) {
>> +               pr_err("Address: 0x%llx already allocated by SVM\n",
>> +                       args->va_addr);
>> +               mutex_unlock(&svms->lock);
>> +               return -EADDRINUSE;
>> +       }
>> +       mutex_unlock(&svms->lock);
>> +#endif
>>          dev = kfd_device_by_id(args->gpu_id);
>>          if (!dev)
>>                  return -EINVAL;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 31f3f24cef6a..043ee0467916 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -2581,9 +2581,54 @@ int svm_range_list_init(struct kfd_process *p)
>>          return 0;
>>   }
>>
>> +/**
>> + * svm_range_is_vm_bo_mapped - check if virtual address range mapped already
>> + * @p: current kfd_process
>> + * @start: range start address, in pages
>> + * @last: range last address, in pages
>> + *
>> + * The purpose is to avoid virtual address ranges already allocated by
>> + * kfd_ioctl_alloc_memory_of_gpu ioctl.
>> + * It looks for each pdd in the kfd_process.
>> + *
>> + * Context: Process context
>> + *
>> + * Return 0 - OK, if the range is not mapped.
>> + * Otherwise error code:
>> + * -EADDRINUSE - if address is mapped already by kfd_ioctl_alloc_memory_of_gpu
>> + * -ERESTARTSYS - A wait for the buffer to become unreserved was interrupted by
>> + * a signal. Release all buffer reservations and return to user-space.
>> + */
>> +static int
>> +svm_range_is_vm_bo_mapped(struct kfd_process *p, uint64_t start, uint64_t last)
>> +{
>> +       uint32_t i;
>> +       int r;
>> +
>> +       for (i = 0; i < p->n_pdds; i++) {
>> +               struct amdgpu_vm *vm;
>> +
>> +               if (!p->pdds[i]->drm_priv)
>> +                       continue;
>> +
>> +               vm = drm_priv_to_vm(p->pdds[i]->drm_priv);
>> +               r = amdgpu_bo_reserve(vm->root.bo, false);
>> +               if (r)
>> +                       return r;
>> +               if (interval_tree_iter_first(&vm->va, start, last)) {
>> +                       pr_debug("Range [0x%llx 0x%llx] already mapped\n", start, last);
>> +                       amdgpu_bo_unreserve(vm->root.bo);
>> +                       return -EADDRINUSE;
>> +               }
>> +               amdgpu_bo_unreserve(vm->root.bo);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>   /**
>>    * svm_range_is_valid - check if virtual address range is valid
>> - * @mm: current process mm_struct
>> + * @mm: current kfd_process
>>    * @start: range start address, in pages
>>    * @size: range size, in pages
>>    *
>> @@ -2592,28 +2637,27 @@ int svm_range_list_init(struct kfd_process *p)
>>    * Context: Process context
>>    *
>>    * Return:
>> - *  true - valid svm range
>> - *  false - invalid svm range
>> + *  0 - OK, otherwise error code
>>    */
>> -static bool
>> -svm_range_is_valid(struct mm_struct *mm, uint64_t start, uint64_t size)
>> +static int
>> +svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
>>   {
>>          const unsigned long device_vma = VM_IO | VM_PFNMAP | VM_MIXEDMAP;
>>          struct vm_area_struct *vma;
>>          unsigned long end;
>> +       unsigned long start_unchg = start;
>>
>>          start <<= PAGE_SHIFT;
>>          end = start + (size << PAGE_SHIFT);
>> -
>>          do {
>> -               vma = find_vma(mm, start);
>> +               vma = find_vma(p->mm, start);
>>                  if (!vma || start < vma->vm_start ||
>>                      (vma->vm_flags & device_vma))
>> -                       return false;
>> +                       return -EFAULT;
>>                  start = min(end, vma->vm_end);
>>          } while (start < end);
>>
>> -       return true;
>> +       return svm_range_is_vm_bo_mapped(p, start_unchg, (end - 1) >> PAGE_SHIFT);
>>   }
>>
>>   /**
>> @@ -2913,9 +2957,9 @@ svm_range_set_attr(struct kfd_process *p, uint64_t start, uint64_t size,
>>
>>          svm_range_list_lock_and_flush_work(svms, mm);
>>
>> -       if (!svm_range_is_valid(mm, start, size)) {
>> -               pr_debug("invalid range\n");
>> -               r = -EFAULT;
>> +       r = svm_range_is_valid(p, start, size);
>> +       if (r) {
>> +               pr_debug("invalid range r=%d\n", r);
>>                  mmap_write_unlock(mm);
>>                  goto out;
>>          }
>> @@ -3016,17 +3060,18 @@ svm_range_get_attr(struct kfd_process *p, uint64_t start, uint64_t size,
>>          uint32_t flags = 0xffffffff;
>>          int gpuidx;
>>          uint32_t i;
>> +       int r = 0;
>>
>>          pr_debug("svms 0x%p [0x%llx 0x%llx] nattr 0x%x\n", &p->svms, start,
>>                   start + size - 1, nattr);
>>
>>          mmap_read_lock(mm);
>> -       if (!svm_range_is_valid(mm, start, size)) {
>> -               pr_debug("invalid range\n");
>> -               mmap_read_unlock(mm);
>> -               return -EINVAL;
>> -       }
>> +       r = svm_range_is_valid(p, start, size);
>>          mmap_read_unlock(mm);
>> +       if (r) {
>> +               pr_debug("invalid range r=%d\n", r);
>> +               return r;
>> +       }
>>
>>          for (i = 0; i < nattr; i++) {
>>                  switch (attrs[i].type) {
>> --
>> 2.32.0
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
