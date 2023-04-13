Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2199C77B6E
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 13:08:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CC0E10E365;
	Thu, 13 Apr 2023 13:08:57 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 431E310E365
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 13:08:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7yI5kzHGUyDeAz8MFl0JFLBHTHkqhbihi0nCZqdiZIIPx2Fhl3uN6CrlRHPeUJloYkuvkVF0UDWxxdPeL3ebmVqeo6Wxz+rjunJZJSHY4ciXEZu9HKQrV2ZQzhu+zhys24YA+st5Ga+8TRuUozsmB0ogOomQYiuDFSk5MMZyFetxlw6dFsVwe3vnx50+8dWvzPGLHStDVjB3DR2Wb9J8HyPbAkp5mA7HX2ac3VHtlO+i6R2smsKb4d3a4mFzGjFJCY1qgGGpBuVxfKliWvkq4vBs1Vme1HTzriUiApTAoSLYO+k4n/o4aVD1gdlzygcZT1qcekMcGLCrptaV89jgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9lg2HHpOWmKkRkk2Yje/tEzo7HXHABmw+qZDqMoJ+E=;
 b=aoysS/V1bsNyLFOXRvGzcYOb8OP7rQhj+aPCO/7bRxs9VDCKXCMy/0K7jbJALuL3phURz7tAk2ijIW7msMKnX4//06ETNrA87PpDuzwEYlg/eIpDUNvJgbawDo8hsTLVLhkqGfaCR9m5IsZwDCQHhoCSsfr2TN3pUADqlKedGEcV0+NvluQ7NxmVM2d2OY7zVg6Xhm/JVgqCXVNPzVxz5u/bIh8btaKgyXMi/K0muXoDkOB0TLCaBtwMxN3/LgDcVP1jM/QKlHUQ24k05B/WglQi7aDaKFF/3iWfQgz1A0bqBjq4DU6X5cyQ8DF2fXNSDihnPmTHWkxhwi/2uy2BPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9lg2HHpOWmKkRkk2Yje/tEzo7HXHABmw+qZDqMoJ+E=;
 b=Qxbv1Yz2LuJeHPim+aJAnPr4HdVbMnSz5XQKqJ8bcJZRyMHu/B2fdPdpOPXTx4isLd8pcCYROqamItlOLMZoZMkiqX10fUY6K/tafduczUgdwIIgqh/wVOV4T+yB4cVeA9yZYdmPnewRufBVylmi8BUHe7Gp/GaLdY767YReB3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by PH7PR12MB7795.namprd12.prod.outlook.com (2603:10b6:510:278::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Thu, 13 Apr
 2023 13:08:52 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%5]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 13:08:52 +0000
Message-ID: <c0465c84-3b20-8c0b-49f9-1800fdc7344c@amd.com>
Date: Thu, 13 Apr 2023 15:08:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 08/12] drm/amdgpu: use doorbell manager for kfd kernel
 doorbells
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230412162537.1357-1-shashank.sharma@amd.com>
 <20230412162537.1357-9-shashank.sharma@amd.com>
 <7b580294-bcf7-2107-5851-2b09bd519e86@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <7b580294-bcf7-2107-5851-2b09bd519e86@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::26) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|PH7PR12MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: 314ac804-cd98-44e6-075e-08db3c203a7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5kkfH/68LJLf3wnQomHF8CUqA7UhWr631ONBDtuOn1yoktuQE/ztNMiyRH+DbLSyetJqd1NxBlA9/IDFlxWn2KrmJWZnUB4UzQYrJ7VTWADwtBSJeP4toybykGLngBuFka14BNA8sSL3JP2yTLYkSrbLJFHX9ahgY3gIA8bube7TyOaziordsENwdXwMqv7M71lf4Vy7N0b5FKjA98mKhaYt7iP3+9ySlbWtmhFjJ7sX7WuHFzt/4evLIdM2tcVVoKe/LjCqAHmsffToh4ejo2kAvGL/xVTspXu8aPAyLYFKhyeZ07F4ZZSci5k+o3KzUp5QNDmS2/gmsu6Dvkta+OI3Ltc6jrs3i1l+6Rlz4GsRhkZUeI3Gc4In596EF/rIlyUxH6GoxDKv96yBmEEtTx75Kpff+HxUErEK9KYMIZyH5wMaFhDsK4nnmihb1Rqa4nCoN9QTiEi172/cmNYR/30Ub1PDZpuM5zySP1kR6ghRBumAPMYRzdVQ/MzH8SAaiHUPXgfIKvw1f2CuySNU1K/6r92a51gDPuMoDuEw6faKajaB/CW8534/950MkIW5+8tWJ6tzgKJCPPTzRjGi7gH1hQpDvUIbtrzm0DXBZ+3byiAkL9UkH5SPlkwrMUGP3yfUtW2mTeeI8+iHLcYwJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199021)(66574015)(31686004)(8676002)(66556008)(66476007)(66946007)(6486002)(4326008)(54906003)(478600001)(41300700001)(316002)(36756003)(31696002)(86362001)(2616005)(6512007)(6506007)(26005)(6666004)(53546011)(83380400001)(44832011)(5660300002)(8936002)(38100700002)(186003)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzFOVkZsZzgxeDcyQW0rQmZ5K0tuVmVMVGhKb2o0dzFjbHMra29tZHg3dXc0?=
 =?utf-8?B?RjUrNE5lM2hsSnZwQ0xkUnN4N25nbHlKQ2ZrVEwrMElZbmpRMEtFbnR0S3Nj?=
 =?utf-8?B?WUZ3QkpGS2xkeVVRZEw4VTMrbzR5Q2M5QlBWOE1TeVdQdFpvdzkzd0RRMlFR?=
 =?utf-8?B?V3lNMjFjRFZwenVLT1RMSUpHd0xFdVRlRzE1ZzFSdjhhaUFtbzhaVmI5WFBE?=
 =?utf-8?B?ZmtSV05QY2lmZUNDR3RtcWFySUVpZHZKazdGRHNaSEZsR3MvVWVEb1U1TmhW?=
 =?utf-8?B?SXZkVDNJQjhWbDZnTFkvTUdaSE9nTEdPaThhR3VzZjB3T0lWQTJ6SmNpY21k?=
 =?utf-8?B?cERhTi9YSWZKL1RXU3lZbmJIakt1V04xa2Y2Qi9vQmtqRWYzNXhtajVEMEJN?=
 =?utf-8?B?TUVHUGtKcStRQW8vVDhtdmlJa00xbjhCWmZxSU9nUGYzYmkrUTVDa1NXNHdI?=
 =?utf-8?B?Ny9DSzVJd1NydUdDaFkzWU5qQ2xaQjVWNjVhNkk2WlZvWjg2VW8rNDZsTFVw?=
 =?utf-8?B?NGpEb01pWGV6N0twVW8rSWNwTWc5ckdjbitNRG8zbmVqS0x3Znd3M2ZVK0Yz?=
 =?utf-8?B?dWxyZkg0cUtZeUxsKzlOeCs3VVdrR0xZdXRjSjZDdzVJVVdVU2VFSlVUdlcy?=
 =?utf-8?B?ektDdGNrNTJzM2o2RmdVNWV0V2VaZVUyMzJZVFU5SHFoWG16QXdzRFIxUVVv?=
 =?utf-8?B?OFFiSUhCYnk4NVh0eEwwSVpZcHJJL2I3YUN0cVpOeU44TXJHRm1wSnRUVU05?=
 =?utf-8?B?azRGajgzbTJlUWI5YThWSTJZTWJlSC9sRlJQWlEwNWxhS016bFIwbVpyVzc0?=
 =?utf-8?B?ZlBuQ0Z2UnBaS3JBRjg3VC9ZL2hTbnJtZjEzUTVJSXVNeWhpSXdoWHJJNFZ1?=
 =?utf-8?B?N0RkSnBOQlVBWSsxSWpvUUtGTlZONmFJRjVWMFFJK2xxdjBodUhnVWFxUVF1?=
 =?utf-8?B?czd6blhCN3ZCb0d5QmtsZG1ibWQ1bHZNVE95Q0NSUEZWdFJ6aU9sTVYwMmVr?=
 =?utf-8?B?djgxSjlMeTkyd1NuRVpEcXJVVHdmL1QrM0FCSVFrNW94eGpZYVdRRTBzV3ZQ?=
 =?utf-8?B?ZnpoRTJsSTRPc1d0SFdPaGJRcmhOUHFsa0pFS1RZd0RlNTh5M1VNNWFGZm4x?=
 =?utf-8?B?SWFwTnB4cnVyM09RK2dZd2J0NDJjVythUHZrUitTbUI1ZjRSY3hOK0hCc3JB?=
 =?utf-8?B?azlXOENYd2E4dUtiRVZHazRWYms5MHVWUUovcmhlRVBLQU83VytGajcxelJR?=
 =?utf-8?B?emppS3dGQ2ltUW92U1QxdnI2RkxZOHJNdWNZY3lURXpvdEVYb2VBVWVLZmd6?=
 =?utf-8?B?c09xMWpBcDQvemNrMGtZT0pxVFpqaEFTK1RYUFd4QmxlY21wR05GWlBhUmVW?=
 =?utf-8?B?UEdhc3czQzdKSFBkU1Q2WmZBSWVRYXQ0WlFQLzZ2N1duWEJCRVR6Z29OT1lF?=
 =?utf-8?B?S0J5Uk5EalQxVzBHamd4Z2pRSk95QXB5aEEzb1VLUkVRY2xuU3FtQUxNK3FB?=
 =?utf-8?B?cFV1YlRaWC9Td092eGwyeERxdVEybWlIRFNTa2lwcXIyY09OWk1KTS8yaUNN?=
 =?utf-8?B?SmVuSVRxSEpKS1gzbmhmVVBNd2RuMVpoL3BPUXFuajJ2TzBVeTBUd1E5R1NB?=
 =?utf-8?B?ME1sVzNLd1pRU0YwNnJDVWd0WXNRc2NEUW8wWHloaXI2SThmcFVuSEJZR3JE?=
 =?utf-8?B?YXE0cjhPRURwWmxKTXVLSkpHZDlZOWhFa21PWmEzTGQzRDR0STlqWmZvSnNz?=
 =?utf-8?B?cjhjTkt0dWI2RFNxeUt1LzQvd0k2MW1xWmQ2NWFDWkVIaDhucGNURW9VYzZI?=
 =?utf-8?B?YkFQMkcwT2lXb1o4R0MvNTRPY0w1TGFFclVzL2VCbk5RR2taZVljOGhsY3k3?=
 =?utf-8?B?WUlLUERaUmJ2UmR0U0RGd05pWTlRaVJkOFhueEpGRk9nVW9KVThxNVdiVUlh?=
 =?utf-8?B?T1BpdEpQdDl0N3NBQU5meW84andsNE1QWGpkUVJEZTRuVFVUcGl3Q1lLVU9Q?=
 =?utf-8?B?bUlJUjVNNmVjZ0ZpUjJ0bXYzZE5URlh5UEZsRjBVMHlKR29xYlRzZTQ4ejZh?=
 =?utf-8?B?RUh3bWZ6ZnA2dTRVbHZjYVhsbWp3WFJyZVB3aHNIVzVwU3Y1VXdZZldxSTJw?=
 =?utf-8?Q?QLupBi0CD2KVp8PqSM2UUVfRO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 314ac804-cd98-44e6-075e-08db3c203a7e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 13:08:52.4040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKHTKlQTjtRKs0nBXlzATwwrUlpWYFKIozccX3ya095Vy9H8fZSlp4amdAF3kK7j+q3vTq2aOwbvzz0t4wipBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7795
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
Cc: Alex Deucher <alexander.deucher@amd.com>, mukul.joshi@amd.com,
 Felix Kuehling <Felix.Kuehling@amd.com>, contactshashanksharma@gmail.com,
 arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Christian,

On 13/04/2023 13:02, Christian König wrote:
> Am 12.04.23 um 18:25 schrieb Shashank Sharma:
>> This patch:
>> - adds a doorbell bo in kfd device structure.
>> - creates doorbell page for kfd kernel usages.
>> - updates the get_kernel_doorbell and free_kernel_doorbell functions
>>    accordingly
>>
>> V2: Do not use wrapper API, use direct amdgpu_create_kernel(Alex)
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c   |   2 -
>>   drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 110 ++++++----------------
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |   6 ++
>>   3 files changed, 36 insertions(+), 82 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> index b8936340742b..49e3c4e021af 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> @@ -435,8 +435,6 @@ struct kfd_dev *kgd2kfd_probe(struct 
>> amdgpu_device *adev, bool vf)
>>       atomic_set(&kfd->compute_profile, 0);
>>         mutex_init(&kfd->doorbell_mutex);
>> -    memset(&kfd->doorbell_available_index, 0,
>> -        sizeof(kfd->doorbell_available_index));
>>         atomic_set(&kfd->sram_ecc_flag, 0);
>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
>> index cd4e61bf0493..82b4a56b0afc 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
>> @@ -61,81 +61,39 @@ size_t kfd_doorbell_process_slice(struct kfd_dev 
>> *kfd)
>>   /* Doorbell calculations for device init. */
>>   int kfd_doorbell_init(struct kfd_dev *kfd)
>>   {
>> -    size_t doorbell_start_offset;
>> -    size_t doorbell_aperture_size;
>> -    size_t doorbell_process_limit;
>> +    int r;
>> +    int size = PAGE_SIZE;
>
> It's usually good practice to declare variables like "r" and "i" last. 
> Some upstream maintainers even require reverse xmas tree here.
Noted, will change it.
>
>>   -    /*
>> -     * With MES enabled, just set the doorbell base as it is needed
>> -     * to calculate doorbell physical address.
>> -     */
>> -    if (kfd->shared_resources.enable_mes) {
>> -        kfd->doorbell_base =
>> -            kfd->shared_resources.doorbell_physical_address;
>> -        return 0;
>> -    }
>> -
>> -    /*
>> -     * We start with calculations in bytes because the input data might
>> -     * only be byte-aligned.
>> -     * Only after we have done the rounding can we assume any 
>> alignment.
>> -     */
>> -
>> -    doorbell_start_offset =
>> - roundup(kfd->shared_resources.doorbell_start_offset,
>> -                    kfd_doorbell_process_slice(kfd));
>> -
>> -    doorbell_aperture_size =
>> - rounddown(kfd->shared_resources.doorbell_aperture_size,
>> -                    kfd_doorbell_process_slice(kfd));
>> -
>> -    if (doorbell_aperture_size > doorbell_start_offset)
>> -        doorbell_process_limit =
>> -            (doorbell_aperture_size - doorbell_start_offset) /
>> -                        kfd_doorbell_process_slice(kfd);
>> -    else
>> -        return -ENOSPC;
>> -
>> -    if (!kfd->max_doorbell_slices ||
>> -        doorbell_process_limit < kfd->max_doorbell_slices)
>> -        kfd->max_doorbell_slices = doorbell_process_limit;
>> -
>> -    kfd->doorbell_base = 
>> kfd->shared_resources.doorbell_physical_address +
>> -                doorbell_start_offset;
>> -
>> -    kfd->doorbell_base_dw_offset = doorbell_start_offset / sizeof(u32);
>> -
>> -    kfd->doorbell_kernel_ptr = ioremap(kfd->doorbell_base,
>> -                       kfd_doorbell_process_slice(kfd));
>> -
>> -    if (!kfd->doorbell_kernel_ptr)
>> +    /* Bitmap to dynamically allocate doorbells from kernel page */
>> +    kfd->doorbell_bitmap = bitmap_zalloc(size / sizeof(u32), 
>> GFP_KERNEL);
>> +    if (!kfd->doorbell_bitmap) {
>> +        DRM_ERROR("Failed to allocate kernel doorbell bitmap\n");
>>           return -ENOMEM;
>> +    }
>>   -    pr_debug("Doorbell initialization:\n");
>> -    pr_debug("doorbell base           == 0x%08lX\n",
>> -            (uintptr_t)kfd->doorbell_base);
>> -
>> -    pr_debug("doorbell_base_dw_offset      == 0x%08lX\n",
>> -            kfd->doorbell_base_dw_offset);
>> -
>> -    pr_debug("doorbell_process_limit  == 0x%08lX\n",
>> -            doorbell_process_limit);
>> -
>> -    pr_debug("doorbell_kernel_offset  == 0x%08lX\n",
>> -            (uintptr_t)kfd->doorbell_base);
>> -
>> -    pr_debug("doorbell aperture size  == 0x%08lX\n",
>> -            kfd->shared_resources.doorbell_aperture_size);
>> -
>> -    pr_debug("doorbell kernel address == %p\n", 
>> kfd->doorbell_kernel_ptr);
>> +    /* Alloc a doorbell page for KFD kernel usages */
>> +    r = amdgpu_bo_create_kernel(kfd->adev,
>> +                    size,
>> +                    PAGE_SIZE,
>> +                    AMDGPU_GEM_DOMAIN_DOORBELL,
>> +                    &kfd->doorbells,
>> +                    NULL,
>> +                    (void **)&kfd->doorbell_kernel_ptr);
>> +    if (r) {
>> +        pr_err("failed to allocate kernel doorbells\n");
>> +        bitmap_free(kfd->doorbell_bitmap);
>> +        return r;
>> +    }
>>   +    pr_debug("Doorbell kernel address == %p\n", 
>> kfd->doorbell_kernel_ptr);
>>       return 0;
>>   }
>>     void kfd_doorbell_fini(struct kfd_dev *kfd)
>>   {
>> -    if (kfd->doorbell_kernel_ptr)
>> -        iounmap(kfd->doorbell_kernel_ptr);
>> +    bitmap_free(kfd->doorbell_bitmap);
>> +    amdgpu_bo_free_kernel(&kfd->doorbells, NULL,
>> +                 (void **)&kfd->doorbell_kernel_ptr);
>>   }
>>     int kfd_doorbell_mmap(struct kfd_dev *dev, struct kfd_process 
>> *process,
>> @@ -188,22 +146,15 @@ void __iomem *kfd_get_kernel_doorbell(struct 
>> kfd_dev *kfd,
>>       u32 inx;
>>         mutex_lock(&kfd->doorbell_mutex);
>> -    inx = find_first_zero_bit(kfd->doorbell_available_index,
>> -                    KFD_MAX_NUM_OF_QUEUES_PER_PROCESS);
>> +    inx = find_first_zero_bit(kfd->doorbell_bitmap, PAGE_SIZE / 
>> sizeof(u32));
>>   -    __set_bit(inx, kfd->doorbell_available_index);
>> +    __set_bit(inx, kfd->doorbell_bitmap);
>>       mutex_unlock(&kfd->doorbell_mutex);
>>         if (inx >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS)
>>           return NULL;
>>   -    inx *= kfd->device_info.doorbell_size / sizeof(u32);
>> -
>> -    /*
>> -     * Calculating the kernel doorbell offset using the first
>> -     * doorbell page.
>> -     */
>> -    *doorbell_off = kfd->doorbell_base_dw_offset + inx;
>> +    *doorbell_off = amdgpu_doorbell_index_on_bar(kfd->adev, 
>> kfd->doorbells, inx);
>>         pr_debug("Get kernel queue doorbell\n"
>>               "     doorbell offset   == 0x%08X\n"
>> @@ -217,11 +168,10 @@ void kfd_release_kernel_doorbell(struct kfd_dev 
>> *kfd, u32 __iomem *db_addr)
>>   {
>>       unsigned int inx;
>>   -    inx = (unsigned int)(db_addr - kfd->doorbell_kernel_ptr)
>> -        * sizeof(u32) / kfd->device_info.doorbell_size;
>> +    inx = (unsigned int)(db_addr - kfd->doorbell_kernel_ptr);
>>         mutex_lock(&kfd->doorbell_mutex);
>> -    __clear_bit(inx, kfd->doorbell_available_index);
>> +    __clear_bit(inx, kfd->doorbell_bitmap);
>>       mutex_unlock(&kfd->doorbell_mutex);
>>   }
>>   @@ -280,7 +230,7 @@ phys_addr_t kfd_get_process_doorbells(struct 
>> kfd_process_device *pdd)
>>       if (!pdd->doorbell_index) {
>>           int r = kfd_alloc_process_doorbells(pdd->dev,
>>                               &pdd->doorbell_index);
>> -        if (r)
>> +        if (r < 0)
>>               return 0;
>>       }
>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 552c3ac85a13..0b199eb6dc88 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -346,6 +346,12 @@ struct kfd_dev {
>>         /* HMM page migration MEMORY_DEVICE_PRIVATE mapping */
>>       struct dev_pagemap pgmap;
>> +
>> +    /* Kernel doorbells for KFD device */
>> +    struct amdgpu_bo *doorbells;
>> +
>> +    /* bitmap for dynamic doorbell allocation from this object */
>> +    unsigned long *doorbell_bitmap;
>
> When doorbell_available_index is now not longer used you should 
> probably remove it as well.

Actually, KFD used two levels of bitmaps to allocate doorbell:

- first level of bitmap to assign a pool of 1024 doorbells to a client 
from big doorbell pool,

- second level of bitmap to allocate one doorbell to the queue from the 
1024 doorbells of the clients.

In the new design, we are allocating and saving a page of doorbells for 
KFD kernel, but we still need one bitmap to dynamically allocate and 
assign single doorbell from the page, both at process and kernel level. 
So doorbell_bitmap is replacement for doorbell_available_index in kfd, 
to make code symmetrical everywhere (kfd kernel, mes kernel and kfd 
process).

- Shashank

>
>>   };
>>     enum kfd_mempool {
>
