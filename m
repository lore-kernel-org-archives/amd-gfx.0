Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A685C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 16:32:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04E7661250
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 16:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 04E7661250
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7412D6E095;
	Thu, 30 Sep 2021 16:32:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B67536E095
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 16:32:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAKoSohjtz65wHUJsuSaDBHOQwRFCwfE1oh+FQKEz1cnTSaAVTXLugG1OVmPF6ZsveRxTzio6brp9jx6Ft833RpxZOVTobaVPXzBF/hN6xmFJ7Z5u/QJTdBdE3nopeb0liqxa7b9jsLlxTWmkXmLeVz8DwSbPbGh9tCRjIPnuuRoy7t1FRI/h+6EiFXdcmpdmofBgrmX2cSbacMFBYhkG2XvT8ZzidaAa8zMf7kKOMAH7pgGGqLGkL5lrceoikeZxm7F1lIJ3tc0iAjifdrnwwn6VpxdPn9pkkkv4RwIKseXfNLGGsIdK7gVEwla1MwSyXy1sPVurA1xRi6tCXKkIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=wJqBnv/W1dlM9xlpSb8OzCzL/JKMbPgT/0iP3GLGBDg=;
 b=PJ4C4zXhXZOcoEpoG68ePLx56+FE4aG+iBviDqG7VSaF1H6p8ebHfaMVQLgJiUrGoFokzyJKMl0zFf+jgBSLPehwIGyUuk4FtXLKI5qpIDJvcCHuI6CzkvZ+M4JWAfh/4VAGDS5DXf2KUOi4oxejBAfW+MafzBWENBxR0EqFDKClHZymEwLRbVDeJeTWQXivRxumLjDxN8ha7ghUWDga/ypBvsnN7Es4CJkillGj0S7qvUp+7yAHX08QVNPDLSgQVSdaiHofy/ZJyaK+6TmY0GF8SZek/TdympNN3imstfJylM/a6pXJq+IBQwZzS21qLuBSNi5dkKFVvinYD+ROlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJqBnv/W1dlM9xlpSb8OzCzL/JKMbPgT/0iP3GLGBDg=;
 b=0Y5a8vEI9bD0ffDwTifNwu5+lbs7hjA8ma3Evxtie9dspH86UPMKg/WTHFLcOUbL5SMJo0soVBaNSd00RKeC73mot4vdPFY1LcqWTSJ0PCznnx5Q34V+TrOWEMsn/hoa3n98tmZP0LvYu8IuIxN8YrWgmJN8jmF2Vpp2FBcp6ok=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN6PR12MB2688.namprd12.prod.outlook.com (2603:10b6:805:6f::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Thu, 30 Sep
 2021 16:32:46 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::f1aa:9adc:b4f:4d14]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::f1aa:9adc:b4f:4d14%9]) with mapi id 15.20.4544.023; Thu, 30 Sep 2021
 16:32:46 +0000
Subject: Re: [PATCH] drm/amdkfd: avoid conflicting address mappings
To: Felix Kuehling <felix.kuehling@amd.com>, Mike Lothian <mike@fireburn.co.uk>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20210719211857.29954-1-alex.sierra@amd.com>
 <CAHbf0-Ew51w4U9b1Z9Jw1gCEz2gJKSZWOC47eb-XJYT2tgVSYg@mail.gmail.com>
 <b7a56aba-a142-ca6a-a609-bec8dad507c3@amd.com>
From: "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>
Message-ID: <69740233-042a-57a7-ee8d-54af96ba92f7@amd.com>
Date: Thu, 30 Sep 2021 11:32:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <b7a56aba-a142-ca6a-a609-bec8dad507c3@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SA9P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::32) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
Received: from [172.31.9.47] (165.204.77.11) by
 SA9P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.17 via Frontend Transport; Thu, 30 Sep 2021 16:32:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 232ae310-f5b8-4448-8150-08d9842fef60
X-MS-TrafficTypeDiagnostic: SN6PR12MB2688:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2688F333FBA94197E50B0AF5FDAA9@SN6PR12MB2688.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S+yQcRDXA+mAfC/vD+Q1zu95xJb3m0fafQ9vHaMaLAV+o4hNDRsPY48JzBuZIVXiT/c8NatGj31Z00nGV7OuSjzVeXXiIjo4l9aGK5Vf0ix3yvJJ9HY3VuAb/0JaOgVGkEQQzUtR6HziTDo4ArFdwmL8Es3XxefxhoG5O88VcYQwzhSUII5B56jIqr6Cka2SB165HeScwVWevDZpQHvOJ6kBIOtu4uCpaIkH+oUpRnU516OctEg5ubxv4SAmlGMxAJIXe93bSX45g6r8PSXg3V70Qv3j8fdJV+MvfPNYHTKGPMiwtrI1uDMDeGRFyzofyh7T6QRFA+pNvdZwzkJbvxeQU4uuff44C+YubULcs07zIWMi75SfEh04xx929eozLmeyNwhD8XpThJFY2yyocSpQzwk1kZ+oZ/vFva/hKQJSniwY8phMZGJB1jRm/BGR6psqSZCLJsEQTfBJZBbrTyK/U5zswEhOnq4LduLx2ph/DWI6aT8Y3dLgfjxoM4J4p7H687HtFvP44PWCqhD41xm1M4Qad1QJC8laUqSGvkJh7mGUmSy8kDfFU7SN/rs4nP4w2DtGgOkEMocOW9T1q50JeVUBQtUbELlhMa8Yz/rfS7Tjhkz/W4vhUObgyU7AVcuvNdWtP3by7ae1beRmLFrbZQTzE+iokfUDJ0P7N44NZkI7KDilpLdXVj2FNEgW2BkQiHoHgOfAUwDl70WJFNyr/DRu2KKSYXbqwbDJyuCRGKYzRUoc8k0HQSSWNv1aDieAhnPsomJq4WdMLTFEUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(8936002)(186003)(4326008)(956004)(36756003)(31686004)(966005)(2616005)(508600001)(53546011)(8676002)(2906002)(86362001)(5660300002)(38350700002)(38100700002)(66946007)(83380400001)(6486002)(110136005)(66476007)(16576012)(31696002)(316002)(66556008)(52116002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2ZWRUgvMEdqY1ZxTkxLTngzQk9XNGd6VUFLdVBVN1V0THdmQ2FIbWhpODBn?=
 =?utf-8?B?Um5GbVNCWmRzYzhsVTlUbndwdk1aNFU2czRhTm5KY0tueTd3b0lLWmNEalZk?=
 =?utf-8?B?U3duZXhBRG9XNWd6T0ZRR0I4eEpxbnVFbDFZdGs5SzdwRG13aTUzcTU4ZUlB?=
 =?utf-8?B?NC9hYjZ1alFKTDJTS1pMZFR2L0lSU1EwNDRUVGVQSDVGV0RBeTNVOTBUYm5a?=
 =?utf-8?B?c3JERFJYbXNGVE1aM3R2KzhFMGc0S1lQeEljMjhLaDV6Z1ZwMHAwT0lmN3NS?=
 =?utf-8?B?WHZ3dEdRbXJ2cFViZG9QWG9XZE9uWHc4VXFWdEwzampLZFpQUXNlODhXVmhB?=
 =?utf-8?B?RmRPaDY1bm50ei9KY1h1UXlkMVVNVS9BQUprTmROVHduUHVrLzJzQlM2c2Nx?=
 =?utf-8?B?TTZTY0VEeFVmSW9KWUxvRERZL3huY0Y3czlIaWRDR3M0Nk9ZN3BySVdsTEZN?=
 =?utf-8?B?VEJnd09Ld003UFM3VlpLcUJ1OUtRdlpCNjhubVZsRGRtakxEbmVINWRQNTh5?=
 =?utf-8?B?bm5WZFJaa2VpbkhHdWVjZ0p3U0d1K3JBOEdsWkFxN1FxVzBRRXYyUHJlSXVU?=
 =?utf-8?B?Tmpyc0owVVBwOXp5WWw4YVNTTFAyTkVRTmEzOUdaaXBMTm03UWEvNEZUTW9r?=
 =?utf-8?B?SUNVK3Ryb1IzdnRnTmZPTHl6RXlmU1ZjY242Tkw2aDQ1ckhSVnIveU82dGI4?=
 =?utf-8?B?Zk1LSlFtL3dPVHhRZzFhN0JPaVVvT3FMaEVwK2VzcGN2WnJGbVBHY0UyU2lV?=
 =?utf-8?B?UFNCeW9TazJGOVBDZFZ4dExhemVQcDZpOGhPUFJITlpTdmw3ekx5dTNIakt6?=
 =?utf-8?B?Z2s5MlI2RUpZRk9ZVGhmd0xHek5JODB6cGJHb3Iva0ZUZU9JT2JQVlZ1alFM?=
 =?utf-8?B?YzMveHNTd3hQMWxkSUpYWStUSjdtKzd5RUpDaDk3U0ZTY3RVWHY4akNQV3lY?=
 =?utf-8?B?MmFsUDFPbFlIZC9tbE81Y3pnQTJVMTgyZ2R1b1JvZE13WXJZd0xGQzFsVFhI?=
 =?utf-8?B?SVhFa1lkcEVRY1REQVFwb0VDbWNqSDBDVkh3NnZ4WDB2c09FcGZlZkRrSVRK?=
 =?utf-8?B?ak9kZzNPc1poamMrTHpka0JlaEY5K0NqeHJOTjlaOUxjcHdpSmlxRHR3ZENw?=
 =?utf-8?B?VTgrSnJyeVN0aC85ZllGb0xlTjhBc0ZWMWVHT2pSYTI5ZlZWcjlSSUNkMkRH?=
 =?utf-8?B?aWt6L3FzcEszbFZ3ZGxvWE4vcnRFMFVhdW9hcGlSWk5TcEFsN0FYb0NtQndE?=
 =?utf-8?B?Ymd0S0VRUGEvdFRydkpIbmFxelNsWVUvVFJpemo5TWp0WncyTFp1QXBHVDJT?=
 =?utf-8?B?RTZzUHAwRHB4b3JkLzdYaUZpTjhybk5JRXo5a0lkQm82SjlSSlZaVnY4clJj?=
 =?utf-8?B?RzN1YUVlenp6WHdVa0ZqWkVVWVRiUEFGb1ZObldvNkkxdWczQXlYWnNpcTVQ?=
 =?utf-8?B?d3FRaGY2dDN2RjgyRlFvRWFHTFZ0T25HSk9qSDZpRTk1ZjBDS29MVlpmRE15?=
 =?utf-8?B?NUhsQUdnbU1Oa3NUNlZ5RkFNWmFRWXlwYlBqdjZCN3BXcFhpNUJQUGRXcU0r?=
 =?utf-8?B?MUZLdFpUdFFPSmd2Vm9naW9BQjF5VFR0N0VXdlBqZ3BXSzNrNmFOMEdBd2RN?=
 =?utf-8?B?Z2pZVy9DYTJxc0swZXE1STNLRVRwU0EweHB1T3UyeXJYSnNNQlRhQmpvRTll?=
 =?utf-8?B?YVpQSGs5aldURFZtNFFkVGcvcEN4dFFncnByTHRNNUg0SkUvRnhUUFZLOTdH?=
 =?utf-8?Q?4z0dA6VKSGVCsQaAdkSrtxq01UTnzyxJ2c3vzpi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 232ae310-f5b8-4448-8150-08d9842fef60
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 16:32:46.6075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ypw5T6PQQ8VVQGoFTMq+N76loRf9gTreIKTc6baerkquWJz2IrrDIyTOLdTKismubv+rJTQuihKsYCJVpOpU/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2688
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


On 9/29/2021 9:15 PM, Felix Kuehling wrote:
> On 2021-09-29 7:35 p.m., Mike Lothian wrote:
>> Hi
>>
>> This patch is causing a compile failure for me
>>
>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_chardev.c:1254:25: error:
>> unused variable 'svms' [-Werror,-Wunused-variable]
>>         struct svm_range_list *svms = &p->svms;
>>                                ^
>> 1 error generated.
>>
>> I'll turn off Werror
> I guess the struct svm_range_list *svms declaration should be under 
> #if IS_ENABLED(CONFIG_HSA_AMD_SVM). Alternatively, we could get rid of 
> it and use p->svms directly (it's used in 3 places in that function).
>
> Would you like to propose a patch for that?

I have submitted the patch that fix this for review

Regards,
Alex Sierra

>
> Thanks,
>   Felix
>
>
>>
>> On Mon, 19 Jul 2021 at 22:19, Alex Sierra <alex.sierra@amd.com> wrote:
>>> [Why]
>>> Avoid conflict with address ranges mapped by SVM
>>> mechanism that try to be allocated again through
>>> ioctl_alloc in the same process. And viceversa.
>>>
>>> [How]
>>> For ioctl_alloc_memory_of_gpu allocations
>>> Check if the address range passed into ioctl memory
>>> alloc does not exist already in the kfd_process
>>> svms->objects interval tree.
>>>
>>> For SVM allocations
>>> Look for the address range into the interval tree VA from
>>> the VM inside of each pdds used in a kfd_process.
>>>
>>> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 13 ++++
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 79 
>>> +++++++++++++++++++-----
>>>   2 files changed, 75 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> index 67541c30327a..f39baaa22a62 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> @@ -1251,6 +1251,7 @@ static int 
>>> kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>>>          struct kfd_process_device *pdd;
>>>          void *mem;
>>>          struct kfd_dev *dev;
>>> +       struct svm_range_list *svms = &p->svms;
>>>          int idr_handle;
>>>          long err;
>>>          uint64_t offset = args->mmap_offset;
>>> @@ -1259,6 +1260,18 @@ static int 
>>> kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>>>          if (args->size == 0)
>>>                  return -EINVAL;
>>>
>>> +#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
>>> +       mutex_lock(&svms->lock);
>>> +       if (interval_tree_iter_first(&svms->objects,
>>> +                                    args->va_addr >> PAGE_SHIFT,
>>> +                                    (args->va_addr + args->size - 
>>> 1) >> PAGE_SHIFT)) {
>>> +               pr_err("Address: 0x%llx already allocated by SVM\n",
>>> +                       args->va_addr);
>>> +               mutex_unlock(&svms->lock);
>>> +               return -EADDRINUSE;
>>> +       }
>>> +       mutex_unlock(&svms->lock);
>>> +#endif
>>>          dev = kfd_device_by_id(args->gpu_id);
>>>          if (!dev)
>>>                  return -EINVAL;
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 31f3f24cef6a..043ee0467916 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -2581,9 +2581,54 @@ int svm_range_list_init(struct kfd_process *p)
>>>          return 0;
>>>   }
>>>
>>> +/**
>>> + * svm_range_is_vm_bo_mapped - check if virtual address range 
>>> mapped already
>>> + * @p: current kfd_process
>>> + * @start: range start address, in pages
>>> + * @last: range last address, in pages
>>> + *
>>> + * The purpose is to avoid virtual address ranges already allocated by
>>> + * kfd_ioctl_alloc_memory_of_gpu ioctl.
>>> + * It looks for each pdd in the kfd_process.
>>> + *
>>> + * Context: Process context
>>> + *
>>> + * Return 0 - OK, if the range is not mapped.
>>> + * Otherwise error code:
>>> + * -EADDRINUSE - if address is mapped already by 
>>> kfd_ioctl_alloc_memory_of_gpu
>>> + * -ERESTARTSYS - A wait for the buffer to become unreserved was 
>>> interrupted by
>>> + * a signal. Release all buffer reservations and return to user-space.
>>> + */
>>> +static int
>>> +svm_range_is_vm_bo_mapped(struct kfd_process *p, uint64_t start, 
>>> uint64_t last)
>>> +{
>>> +       uint32_t i;
>>> +       int r;
>>> +
>>> +       for (i = 0; i < p->n_pdds; i++) {
>>> +               struct amdgpu_vm *vm;
>>> +
>>> +               if (!p->pdds[i]->drm_priv)
>>> +                       continue;
>>> +
>>> +               vm = drm_priv_to_vm(p->pdds[i]->drm_priv);
>>> +               r = amdgpu_bo_reserve(vm->root.bo, false);
>>> +               if (r)
>>> +                       return r;
>>> +               if (interval_tree_iter_first(&vm->va, start, last)) {
>>> +                       pr_debug("Range [0x%llx 0x%llx] already 
>>> mapped\n", start, last);
>>> +                       amdgpu_bo_unreserve(vm->root.bo);
>>> +                       return -EADDRINUSE;
>>> +               }
>>> +               amdgpu_bo_unreserve(vm->root.bo);
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>>   /**
>>>    * svm_range_is_valid - check if virtual address range is valid
>>> - * @mm: current process mm_struct
>>> + * @mm: current kfd_process
>>>    * @start: range start address, in pages
>>>    * @size: range size, in pages
>>>    *
>>> @@ -2592,28 +2637,27 @@ int svm_range_list_init(struct kfd_process *p)
>>>    * Context: Process context
>>>    *
>>>    * Return:
>>> - *  true - valid svm range
>>> - *  false - invalid svm range
>>> + *  0 - OK, otherwise error code
>>>    */
>>> -static bool
>>> -svm_range_is_valid(struct mm_struct *mm, uint64_t start, uint64_t 
>>> size)
>>> +static int
>>> +svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t 
>>> size)
>>>   {
>>>          const unsigned long device_vma = VM_IO | VM_PFNMAP | 
>>> VM_MIXEDMAP;
>>>          struct vm_area_struct *vma;
>>>          unsigned long end;
>>> +       unsigned long start_unchg = start;
>>>
>>>          start <<= PAGE_SHIFT;
>>>          end = start + (size << PAGE_SHIFT);
>>> -
>>>          do {
>>> -               vma = find_vma(mm, start);
>>> +               vma = find_vma(p->mm, start);
>>>                  if (!vma || start < vma->vm_start ||
>>>                      (vma->vm_flags & device_vma))
>>> -                       return false;
>>> +                       return -EFAULT;
>>>                  start = min(end, vma->vm_end);
>>>          } while (start < end);
>>>
>>> -       return true;
>>> +       return svm_range_is_vm_bo_mapped(p, start_unchg, (end - 1) 
>>> >> PAGE_SHIFT);
>>>   }
>>>
>>>   /**
>>> @@ -2913,9 +2957,9 @@ svm_range_set_attr(struct kfd_process *p, 
>>> uint64_t start, uint64_t size,
>>>
>>>          svm_range_list_lock_and_flush_work(svms, mm);
>>>
>>> -       if (!svm_range_is_valid(mm, start, size)) {
>>> -               pr_debug("invalid range\n");
>>> -               r = -EFAULT;
>>> +       r = svm_range_is_valid(p, start, size);
>>> +       if (r) {
>>> +               pr_debug("invalid range r=%d\n", r);
>>>                  mmap_write_unlock(mm);
>>>                  goto out;
>>>          }
>>> @@ -3016,17 +3060,18 @@ svm_range_get_attr(struct kfd_process *p, 
>>> uint64_t start, uint64_t size,
>>>          uint32_t flags = 0xffffffff;
>>>          int gpuidx;
>>>          uint32_t i;
>>> +       int r = 0;
>>>
>>>          pr_debug("svms 0x%p [0x%llx 0x%llx] nattr 0x%x\n", 
>>> &p->svms, start,
>>>                   start + size - 1, nattr);
>>>
>>>          mmap_read_lock(mm);
>>> -       if (!svm_range_is_valid(mm, start, size)) {
>>> -               pr_debug("invalid range\n");
>>> -               mmap_read_unlock(mm);
>>> -               return -EINVAL;
>>> -       }
>>> +       r = svm_range_is_valid(p, start, size);
>>>          mmap_read_unlock(mm);
>>> +       if (r) {
>>> +               pr_debug("invalid range r=%d\n", r);
>>> +               return r;
>>> +       }
>>>
>>>          for (i = 0; i < nattr; i++) {
>>>                  switch (attrs[i].type) {
>>> -- 
>>> 2.32.0
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
