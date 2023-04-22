Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA3BC6FD18
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Apr 2023 06:39:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 529AE10E145;
	Sat, 22 Apr 2023 06:39:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 652A410E145
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Apr 2023 06:39:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzMXdVuJUmQcAzmLpffExdBm9buoDQXXm7uNH55OhMl3aQrnrm7/kk1sq6Ps7PKaJsccQX13gGvN83xacFCPnXy/e8gJEdZUugJaf24YUa+z+xsAPgEh8qo0cItx1ZM7vzeCdKFsTSdw+YaUC3NuYOaZUU4IgCFVCpE2MFWu54fP2NVKE6p7S3+p3qTNzgLbLArX1+GNQX1yKR2jKzAnjA790BcmNvez0fpBjSTSeFGuGB7R5LpwfoL4UF9Ibms3hLFGGh8erKL76RpF8N/C7Nb6Zi2gXMcvG/zLGmcMJOpGEGxUNNjLWMPi2bZg26+CDFsxZPeG1QTrPHQqqlRSFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2ckEbObwdAJ1fNc38mUmjO4XOV++Z7oPMok/Ul9Mm0=;
 b=AtBHTinqfHG4VNieDMaefiT7jzaD2kk+qnYrsIItF1Vv+OkAa7uBu5pugA3/EzlCPfGHyxcyxSn+hi6i/p04DuleGNB0kJdxJ58mpjfhduewmdi3IVuQIe3FseuZWqcYI8hmJJe4QpgpFYUy5FxZ1r+iih25KH3axaFlBQDjRKw2fqK49dRqGrpEQqFQBY4dpEjYBoam9NJ5PJLNeWG3+6grR+lQOV702DOk0KDrx/XqFUM07mGEHiuHdxFXXCsiylMtyAShAT8hTsrtSSZSd9fDwtJ8XmPVaiSqI+/5rGbSNGVHnCGTWWFq0slNdgF7q/1w9xJTgK3REA7yzFTcyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2ckEbObwdAJ1fNc38mUmjO4XOV++Z7oPMok/Ul9Mm0=;
 b=vZ35agscgp5bwfNg5LP4XRbRPInltCZLARnRqSWJTZ/7qtKlciMLDlrOTemwMyv/+/v5gNlW2+sxRwOUQq78Afk53t7fXz0xqZZCom+AFxYeRaOz+yZ3IM2XZfreCD6/LTEtGxGnr9oXqfTqcvqToUlucK4amZ+wUmNMNJVQRGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by MW3PR12MB4346.namprd12.prod.outlook.com (2603:10b6:303:58::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Sat, 22 Apr
 2023 06:39:32 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::3e8b:f34e:7244:eaef]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::3e8b:f34e:7244:eaef%6]) with mapi id 15.20.6319.022; Sat, 22 Apr 2023
 06:39:32 +0000
Message-ID: <0c0fb5c0-1183-c4b3-272d-fe153faefa28@amd.com>
Date: Sat, 22 Apr 2023 08:39:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 08/12] drm/amdgpu: use doorbell manager for kfd kernel
 doorbells
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230412162537.1357-1-shashank.sharma@amd.com>
 <20230412162537.1357-9-shashank.sharma@amd.com>
 <2808cded-f913-58fa-a026-6887445ef37f@amd.com>
Content-Language: en-US
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <2808cded-f913-58fa-a026-6887445ef37f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::18) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|MW3PR12MB4346:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fc121a1-3b9b-41ae-5aff-08db42fc5474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6QyI6oAFpOf88NMZpBcVEYwjqu4aXkqxmIMWobed/cs4DrIXuMA9+t/8xG4VCs1wlh5Z4j96vtPFT2K/fphnnb7KMdVC0k/B0j+WqhrmqNnTqmDN/VjYJJXoTuWus0rE/d1el+HXPON7JCBWJ0ZUFslfGm36Q2zJDE3weQUR3tREk+e94G38Z83LROs8wTXa89KKiOBu+f7GIfZFBt00mzSOnMjH12u6Xay7gA5D0KqN6MBokqWsvr93XsUXua7imra9jvYcAH1DsdEBRckqsNlJMSlfGS1tnMIYFfQM4YUyxxxbd30q1TWheOKNYit1xXvp3m2awjrznNslkDVP5vTPpuC+dTMxVKOZtbQhxbv1rLxQ7mLzDBcpwM7jOZX6ppzWS1GjOU/qtIasfUv3OskS6p0NoIrYIg8jVUmqEzVU0XdCIwyAVRSRMJDy/ujylfksO8l7Y8EU5VaQt7i1FO9tISB8DUcKxSoKuaXi17lvJRwAkC2E+0/D7Prdq/RUHEP+kT6S01lBA6zRZgPtKQay1L3TlnAYy+afQlo6jzlRBmiyGY/lQMXHFnZBSNR/54K7bXOk3S9xV8BGbbPI52G61XwSrP2rH86Ewey20AdGUTz4B5pj8Uo3TRYQmbGkMX5Jt3XLW5Lmj1d2UqJ9pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199021)(66946007)(66476007)(66556008)(316002)(41300700001)(4326008)(8936002)(5660300002)(54906003)(31686004)(44832011)(8676002)(478600001)(186003)(6666004)(2906002)(26005)(53546011)(6506007)(6512007)(2616005)(83380400001)(38100700002)(31696002)(86362001)(6486002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUZMSTJjaFJCdHFoMldJenNDS2w2RnFxV3R1Q2FVYmd0NEsrcTJ1SnhkaDN2?=
 =?utf-8?B?ald1eG0vYjZTRlc5YjhqQm1vK1FXUWJEenVOQ0Mva0RCM2prR2JJeU1BYkFI?=
 =?utf-8?B?Zmp6M3B0Y3ZrZTJ3SGpsbnpyUEFnTUJiblgxUEU5NFR3L1lybFNiVmhqTUQv?=
 =?utf-8?B?NTROY3VzaTVJWnVpdFdEWVFJRHJ1ZGdCWmI1M1llS3R3VUcxalNiUThpMHFn?=
 =?utf-8?B?WTZmSkN5a0ZFa3pSVk1RRHRuOGF5YzZSR2JEa0NCL3g0TDByT2d2MzA4a1ZS?=
 =?utf-8?B?VnB6K0F4VUMweldpQnVQL3ZkRjVnM0lxV2FpYU1WbFA3SlB0V1pjRnRDTEZz?=
 =?utf-8?B?U2tvMDEvMDNMNG9JTzdTZFdnQ0dnSGdIV3ZTTkpXL0RGcC9ST2QwTGdGQkFB?=
 =?utf-8?B?R3pGOGU5V295VUx5QWZnMHhQRUFuWlYrYnNhTTdKV3ZYdkR3NW9iQ2ZGUENw?=
 =?utf-8?B?ckVFMml1MTZ2Qng0QVZOd3JrQmw2Mk8zK21aME9ydzhMTklBTjJCeGFiWGE0?=
 =?utf-8?B?emlhaENCY0JSM2MzRnhFRHhmTGk4ZzUrLzlXTmk3aXE4OHBBS3l3U0NyMHdx?=
 =?utf-8?B?bG9JQnQ3VG4vd2U1anNkaHMxbndNZ3U3RGU3dzZ0R1JkNWh2QmhhMWNBQlVH?=
 =?utf-8?B?aFVwNDRvUm9vcysxMFpYSkFsQk9CUHQzZmM4bFkzeXlERWhKTm13MVJqa01M?=
 =?utf-8?B?Zm9neVljWlliWWR3Uk5kK3lYYUU0Vk5wYVRHS0xxZlZzeUhOVThUNXZhaXJV?=
 =?utf-8?B?TkhQaFI3TUo3OVpDcExpQnR1OW9HazVSRmtiQ0RGaE5Wdzg4aWdFK2lFNHZo?=
 =?utf-8?B?Y0cvZ2Y0Zlhwa0dibjJTRTBCRmcxMGxkdG9YSXNRblZXYjNpTi81QjNpU1BU?=
 =?utf-8?B?WnNjUDQ2OUtiZi9xdFJDS0RiVHlMMUZod3dCZ21WOE8xa1Rpd0Ztbmw1aTE4?=
 =?utf-8?B?YlI2bXl2M3F4WUhiNmRIZFpPblk1UVVMbXdueG8vcVVURC9SRDI2MjZGTEUv?=
 =?utf-8?B?OXpydS9UbVFlUm4rT3hXVmo3NnRubHovelFjUmJ4TUJ0TDN2WlhCaVFwUkJ2?=
 =?utf-8?B?VEhOR25ZR0xXSmN0TmtJdHAxa3NtakFRSW1hK0hMRktMNUtWOWFpd2IyNllk?=
 =?utf-8?B?d05RbmVHYVY1eWh0WjE1WkdpYTJBdXpSWmxWRlJJWGFicytqKys5WFAxZEIv?=
 =?utf-8?B?SmtPQnVxR1UxNmFGN2ZvTnV0Z1NZRmdQMzRuQkdpc015c2JZUXBVTjlVQXBy?=
 =?utf-8?B?Z1pmdWxPZ3JzMm9acFdUb05FUXJEWEdVQ1doZkdvbndnMisybktxWEVvZ1dC?=
 =?utf-8?B?cVNRZnRNaHQxWlNwa0VtTDFhZ3pvYy9QUGwya0FhRXV5NFpGMGNSM09vaW5C?=
 =?utf-8?B?ejVBS3BZU3F0d2daajFCdjdkRW9aTlovSlRUWmFwSC9SVm9jd3RWUStsTWta?=
 =?utf-8?B?Nmp2Z013anF3cUk2TVJhU2M0cHFnaUtHcmYwVEU2Vnc2TFNERWNpV1Q3RkFE?=
 =?utf-8?B?L25kdmlndlpUOFdJZGpnd0U4R3REQkJkejNRREhUQlFncStGTUhvTmE4ZU84?=
 =?utf-8?B?VDJhZEJUaloweG5jV3BRUHRubERHci9WelJGSGxFU0xrTk4wbWM4TnA4QUlI?=
 =?utf-8?B?RkFLK1ZHUkx1Q3Q4Mmxzd2JUTzdydU0xNU9qZTZoUkZnY25ISDhFMkRRZXRV?=
 =?utf-8?B?bmZOVno0SnI4VEdaUGROdGtZaXZTdHAraE9hRGx4UVVXUjlmQ2NOb1gyWVR5?=
 =?utf-8?B?M3BjT1h6czhRd01qWFhXTFF1djlhSDNmTmFId1pwVHJNR0E5Y2hZOXIyenRP?=
 =?utf-8?B?WlRCOU5yU0ZBQmEyV3JaUVVUMEcxZGZaT2tIQVBlUThQeVlIbFBubkRrZytP?=
 =?utf-8?B?TUZYTGVYcVlIK205bEdkenViK3JRbGo2RkJRYksvbjRuNnFnTlZMWS83SjVN?=
 =?utf-8?B?R0RoVjUwU283NFBSNEhGME80UGFvUUR4ZmlxWWNQVzA5emhNL2xuNTRTY1I1?=
 =?utf-8?B?LytialZMcm13RHdHVUlnVW1yZ3Zyd1VOS2NUMThySmJqcmJKZ241WTd1WVhT?=
 =?utf-8?B?U01oZTFwUVQrN3BPU1N5MTVuTXZlMDNzSGZFbFRNZGRlNUtMQkVLNk1TZ21Q?=
 =?utf-8?Q?wsKbUsUVxb6OOIbsF0o0Xc2de?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc121a1-3b9b-41ae-5aff-08db42fc5474
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 06:39:32.2776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmxNOuYBPcmrhkQ1xlfftw56sakPDMDtLIuERD4ZaRpPkiELJuR+UFot8aVB1A5YixfdTPXqu+pMXHbUACvoRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4346
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
 contactshashanksharma@gmail.com, Christian Koenig <christian.koenig@amd.com>,
 arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Felix,

Thanks for your comments, mine inline.


On 21/04/2023 21:58, Felix Kuehling wrote:
>
> On 2023-04-12 12:25, Shashank Sharma wrote:
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
> On GPUs with 64-bit doorbells, ROCm uses two pages of doorbells per 
> process. In hindsight that's probably overkill and we could live with 
> a single doorbell page per process in terms of the number of doorbells 
> needed. But this is not easy to change due to the way that doorbells 
> are routed to SDMA engines, at least on Arcturus and later MI GPUs 
> that have lots of SDMA engines and queues. We need enough doorbells in 
> each process's doorbell slice to reach all SDMA queues. On Arcturus 
> that's up to 64 queues. The way the routing is set up, only 32 
> doorbells per page are routed to various SDMA engines, so we need two 
> pages.
>
> Changing the doorbell routing is not trivial due to SRIOV support, 
> where the routing is programmed by the hypervisor driver. The 
> hypervisor driver and all guest drivers (Windows and Linux) have to 
> agree on the routing. Changing it breaks the ABI between hypervisor 
> and guest drivers.

If I understand correctly, you are suspecting that we are allocating 
less doorbells per KFD process, which is the first impression it 
creates. But if you observe closely, we have split the total KFD 
doorbells into two parts,

- KFD kernel level doorbells: doorbells which are being used for kernel 
rings tests, written by kernel doorbell_write calls, saved in struct 
kfd->doorbells

   size = PAGE_SIZE.

- KFD process level doorbells: doorbell pages which are allocated by 
kernel but mapped and written by userspace processes, saved in struct 
pdd->qpd->doorbells

size = kfd_doorbell_process_slice.

We realized that we only need 1-2 doorbells for KFD kernel level stuff 
(so kept it one page), but need 2-page of doorbells for KFD process, so 
they are sized accordingly.

We have also run kfd_test_suit and verified the changes for any 
regression. Hope this helps in explaining the design.

- Shashank

>
> Regards,
>   Felix
>
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
>>   };
>>     enum kfd_mempool {
