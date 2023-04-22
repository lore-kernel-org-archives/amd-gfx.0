Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7932C6FD18
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Apr 2023 06:46:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AD4F10E158;
	Sat, 22 Apr 2023 06:46:00 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3DFA10E158
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Apr 2023 06:45:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpXi021BMWwVxQq/tD/hQTRCfpBRE7nCzezwnnShatLtR5WzGq1xSM8gRwVb47DGYvo/euIXUcDQxbdgy3137ME3OcDb8dAcwgwneo6vT0I5kdSDyuzOIwXTxPl4WJLaDqdmSeHh+SJqjM38awJWXnx0zsW2beV+yVTK+tOkvftFgeODmPXdwp2P99Rd6aZzeQ5W4hVaInwnY6o3wcAh4r4VmnmFihTKofCZBVMIjVLwBmuWCKtB2PiM7yfJdlWzZMi+iev+dmy791PiILKH6sWKXulG/c/T1Xzfwq8P9VJf7CbtxJTf953hlBZNYW2LKqz9XGyK14kp0I/AzmAdlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTEGif8OiWQCEvBFB/uw6iOkxrNhptuBSWsSVz/8FsM=;
 b=JSgNIDDXVqF/tji7FoUr7XxH5LWJG6ifMKiBf5wVt86mu4FmsiOzM5OmJOohCeW2rpV4zPiQUnUabugxxFC0XcdVxUM0a5B5f4sqxBj2Y8Qs4yoa51pUXT14iqqe3RtbloU2wOg8ymr3B3RNR0sPi2UrmfEb1io7vLBS8uKaYH7hzf5fhfhXFlfj8TtxmAwcGoizPINhRNldpwgLJuWTZ50+p9AYIQfSqriuJk9mjWoB53gl+u3oURn+DcFHpxUs4vbmgjXbmbFUlumPU2EkUSUoOErJmEIISKakcOQ/mVIq4yHx34NJqJ4ySLhsvhM/jwE0tVhxfjJw1Vs3SXR5ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTEGif8OiWQCEvBFB/uw6iOkxrNhptuBSWsSVz/8FsM=;
 b=yWlOnqnFq8ddXDhT0ewylrkfH1b5QIu0qM0azjKgah0t8SQgq+CWd78415s8Dj+RBzsOBGbPwsHQ9rVeVJhuSLem8MyJs+11PNbIJEVYjvZz+DKs/9qQIxgUAEFEs0g8OSw2cRhSgK0mp6E6njNyKeX9nh51Dr/sSwiuCPHrwNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Sat, 22 Apr
 2023 06:45:50 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::3e8b:f34e:7244:eaef]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::3e8b:f34e:7244:eaef%6]) with mapi id 15.20.6319.022; Sat, 22 Apr 2023
 06:45:50 +0000
Message-ID: <bc3d9f40-1339-e95f-0e88-200362a1161f@amd.com>
Date: Sat, 22 Apr 2023 08:45:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 09/12] drm/amdgpu: use doorbell manager for kfd process
 doorbells
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230412162537.1357-1-shashank.sharma@amd.com>
 <20230412162537.1357-10-shashank.sharma@amd.com>
 <b8bf2cc9-6a72-5fce-e19f-cf69e37f382e@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <b8bf2cc9-6a72-5fce-e19f-cf69e37f382e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::12) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 515e4db3-d174-4224-72c1-08db42fd35be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4F2Rf+ZrNiXib7G4XNvwodHIwrrdj6UmwnXK4geUfoPV0Dtln5bbw339LhKBbIkazF2j+xO1bPWMIiELGd5UjEa8FP8HY8Q94NNIo+OZ6G0pJolXaOYzHwa8D5JGuSOHiu27/CNCcarII1XaaKdg6OPuiVuqqWMz0z7z8cVOd+QfDmenWmK/VTLYZYJ4yuQqhtd2F5v4mEsSEmd7Vfj68xXrBzd2JeWneEeJjD7nwlOqoYnlmIWkBnyxOxa6n/rRsNL62a9heiQmB6snO2RnRU9hdEAU6QD90knSESBupqT2ZjqhGqrn9s4UeUK4EcZaj8Pqclhq7ArU9EvX/crnfsE4ElKaCwyL5f6uWw03LgNwMTMtlmXcriuh0EaGJ3Ktmgf+QhPt4OMIS5cqlKtNkULvh0i3g+h3vvMYCqDSjyQMcOeS+aWfU9ESa30fC94WhZEayOVPkulvekQCbzXsZaLiPMqTZvjTvZ6sa7JWS5swAsfXrBkT6JCtI2Eo4DAoS7rQmzSbp6PNUlk9h07Qo6njW2Mc06nN2wFPjtqktWY6iz1B85fAhjaEtpdzlxo8nyBCAtZmhrM6uWor9HcC8cQSTTrbikgs81Me9K891DlbtmZzegfUQL1JCmUnJRSUOqidT28dcpQCsx04xsw4MA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199021)(4326008)(316002)(66946007)(66476007)(66556008)(54906003)(6486002)(6666004)(86362001)(478600001)(8936002)(5660300002)(8676002)(41300700001)(2906002)(44832011)(30864003)(31696002)(36756003)(38100700002)(2616005)(26005)(6512007)(53546011)(186003)(83380400001)(6506007)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2kweFpEMkdwbE05R1RTZjR0WE1sVUhrUEZBaFVBYWhncWgyd0VBdytWUzZz?=
 =?utf-8?B?NVNWUkYrZ09VM0E5c2dRNlFXSnFNTWdvcDE5MkZYKzZlMzJEeXY0ZjhFbFc4?=
 =?utf-8?B?L1lBV3k1UWRKb3o0QThSMjZ2ejRyTUZpZFJXTTB6Ukd2R05GRWZPMlVRQkVL?=
 =?utf-8?B?NHBtVUFXZTE0MFN6SXlNeFdWZEtndUxyeG1UenZhak1SeFlpM05qNEJtOFRR?=
 =?utf-8?B?U0tmSmRDR0owMUdQZDhiVFBwWk9mSzlQNHlCc2dtak5OMUZTcno0SlJhWW5H?=
 =?utf-8?B?Sm9kbTFRRDJ1VXkrai9zK0VaQ2pyS05YNUJRbnVGYkljWnZTRjlVWGV6OG5h?=
 =?utf-8?B?SVVwU0wzeTUyWTdDR2FlNVJIQ1F6TTYwUWRwRGhxaTFmMHB4UjVKTHkvQndR?=
 =?utf-8?B?c0tObjlVbExHOXNWcW9ZRDEyOEVWS2JycVlaY21Xcm1lUWUvY2FGNmJKSE5M?=
 =?utf-8?B?VU16MlI5TUprY2FSclBtQlpYVDBsNUZ1WTJLazgvSjJ4S201RnBscjg3SFhw?=
 =?utf-8?B?L1gxUlVqUkl4ekNCUWs1d21YRnFZSTR1dEt3b1FFbEVYN0VEbEVOK0xOQit6?=
 =?utf-8?B?WkxicmR2L1EvSmdObU1IektaYk43MXk1NjVZTnlYZ0tMa0Z2djdMbVpUb0xi?=
 =?utf-8?B?NUZpWEVtY3JXcEFWOWMyaXFIdFlKNmQrVUovazVFVngwODJuVGpKZmI2SDhB?=
 =?utf-8?B?L0FXbTVwVWwvRmdXTmFaTFVDVUJsZDBzWFpVUmdaWE1uUkxNS0t4aGtEWm56?=
 =?utf-8?B?MklqTXNDZkhZZGxjdjR4R1B5MkFXY0lnbk5GNmloWFN6QjJ1MWFNMUNwa1Uw?=
 =?utf-8?B?T09oajVCYlF5dXFhd1BuZEJjU2UzNE5aRkhXbGhTT0pVR2x6NzR1bHROOVRz?=
 =?utf-8?B?cFRYT1V3Y1BweXB4b1V6K0IwMzUzSlRJZlJEd2hiTnJCdmFVMFlnUFNLMWdC?=
 =?utf-8?B?c1hyTGNFVU5sTlU3bkpHMlRqcXZ2LzdKbCtXcUJJTDFWRi91QXhCeEtwMkQr?=
 =?utf-8?B?citNQXBFSWRhRjErQkE2S1BNd2x4TzRJbHR3QkFGRTI5VzdEMnI5MCtSVk91?=
 =?utf-8?B?SnBEWDVDWGMrK1p3aDJqNTA2THNNR2VLYlZOY0V5L2Z6VkFHbjlzTkpJRWd5?=
 =?utf-8?B?TW5UdTlBcGtuMFd5ZmxiZktiTG1sUjZMd2RRbDArY2ZHeHgyd0pYMlBLcnBS?=
 =?utf-8?B?VHE4ajI1dVJYWUdNK2NNT0dHY3QzUFBYakIyUHE2MnNXamlLRlVhcnVheXhj?=
 =?utf-8?B?RFZUYVdDaXFNajdqQkFDdUNUUHcwMmowaDJjNDBzdVpxUHJCa2tkN3h0QUc3?=
 =?utf-8?B?c1d4ZnYvOUpQTTZpUGxKTUNYTStkVFpmMGswSnFPNlZrOEZvTWl1bFF5Qk1H?=
 =?utf-8?B?ekVleW85aWkrcThsRmdwNHJVK1JmVTA0ZEJtVzJCSjBvVDJ0SldlM2Vrb1lR?=
 =?utf-8?B?ZmRBdE5LWWwrYmFLNHJubGlnOXJ2dUNuSVlqMWtvRXFyTE9ZOTFySWtQSDBv?=
 =?utf-8?B?TG5pMUZZbHdGcG9vVVNnbzRFUzE3Y3Yvd29iZHVRRkhKUlR1RVNSM1N1RnZk?=
 =?utf-8?B?QWk0QXJpeENtVk03SFNwUWY3TmZVbXNvT0VuSGdKZ2ZkUkhJdTd5Y2VhYTEv?=
 =?utf-8?B?Z1l6VnlWekNwQ3JObWZueEFLbnpVaXhwaXd1bWFDRnVJQVB2dUt2ZmhVSGkr?=
 =?utf-8?B?NEE3dm5vWFA2a2lxajcvdG1GakZpM1czQlpqeERYVlJYSzNEQ3BvbGlkQkhj?=
 =?utf-8?B?VCtMVFkrd2U0aE9INFhIY01HN2xuRm5JQTNnK09aUVRwMk00VHhNQnRpb3FI?=
 =?utf-8?B?Qm0vNjNkYmRhSUJ2QVFIOWlDaXJDUktUbUN1dXEvTitLT2xxK2srR3lJb242?=
 =?utf-8?B?STdabkc5Y2h6NUV0L1JlWmZlajVEbFNQWUxWb0RZTXN4UlV6cEsweE1oVi85?=
 =?utf-8?B?UlpwVDR6bWVUYy9nN0JrN2FmY1pkZGtoczAyWkZhQ3psazViKzFjRmJLLzFk?=
 =?utf-8?B?Z1daVVo4eGJCZnUwZlAzYjcyUXRVcXk0NzVIZWZ6eEZFT3Q5KzlrWlN6T2tH?=
 =?utf-8?B?bUdlc2ZtMUVYaWhSN3poQVA1bzlGMnQzbDdBd0Q4YUlCR3ZBNk9DUXd5VzZr?=
 =?utf-8?Q?t1nQ5EY45MYjiLlKh31kTYB0Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515e4db3-d174-4224-72c1-08db42fd35be
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 06:45:50.0774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPa1Rw3xjpMhIp2vHXXa8gBV6QLxVosm4cPGiXnVBY2VkKtoyL09VScAEsGCPOpLMD1koqSOyxFYkKg1M1y4WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918
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


On 21/04/2023 22:11, Felix Kuehling wrote:
> On 2023-04-12 12:25, Shashank Sharma wrote:
>> This patch:
>> - adds a doorbell object in kfd pdd structure.
>> - allocates doorbells for a process while creating its pdd.
>> - frees the doorbells with pdd destroy.
>> - removes previous calls to allocate process doorbells as
>>    its not required anymore.
>>
>> PS: This patch ensures that we don't break the existing KFD
>>      functionality, but now KFD userspace library should also
>>      create doorbell pages as AMDGPU GEM objects using libdrm
>>      functions in userspace. The reference code for the same
>>      is available with AMDGPU Usermode queue libdrm MR. Once
>>      this is done, we will not need to create process doorbells
>>      in kernel.
>
> I like this approach of keeping existing functionality working, but 
> having a transition path for user mode. If I understand it correctly, 
> allocating doorbells as GEM objects would enable overcommitment of 
> doorbells. That's a capability we haven't had in KFD up to now. Trying 
> to launch too many processes that need doorbells would simlpy fail.
>
> With overcommitment, idle processes could have their doorbells objects 
> evicted, sot that active processes can work. Doorbell objects would 
> need eviction fences to ensure that processes are not scheduled on the 
> GPU while their doorbell allocation is in use by other processes. The 
> doorbell offset in the queue properties would need to be updated when 
> doorbells are validated and potentially moved to different physical 
> pages.
>
> These details would need to be worked out in kernel mode before user 
> mode can transition to GEM for doorbell allocation.
Noted,
>
>
>>
>> V2: - Do not use doorbell wrapper API, use amdgpu_bo_create_kernel
>>        instead (Alex).
>>      - Do not use custom doorbell structure, instead use separate
>>        variables for bo and doorbell_bitmap (Alex)
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 13 ----
>>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |  8 +--
>>   drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c     | 65 ++++++++++---------
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  9 ++-
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 21 +++---
>>   .../amd/amdkfd/kfd_process_queue_manager.c    | 22 +++----
>>   6 files changed, 64 insertions(+), 74 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 6d291aa6386b..0e40756417e5 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -327,12 +327,6 @@ static int kfd_ioctl_create_queue(struct file 
>> *filep, struct kfd_process *p,
>>           goto err_bind_process;
>>       }
>>   -    if (!pdd->doorbell_index &&
>> -        kfd_alloc_process_doorbells(dev, &pdd->doorbell_index) < 0) {
>> -        err = -ENOMEM;
>> -        goto err_alloc_doorbells;
>> -    }
>> -
>
> You're moving this to kfd_create_process_device_data, which means 
> processes will allocate and pin doorbells, even if they never create 
> queues. We specifically moved this to first queue creation to allow 
> more ROCm processes to be started, as long as they don't create 
> queues. This is important on systems with many GPUs where not all 
> processes need to use all GPU. It also helps with certain tools that 
> need to initialized ROCr to gather information, but don't need to 
> create queues. See this patch for reference:
>
> commit 16f0013157bf8c95d10b9360491e3c920f85641e
> Author: Felix Kuehling <Felix.Kuehling@amd.com>
> Date:   Wed Aug 3 14:45:45 2022 -0400
>
>     drm/amdkfd: Allocate doorbells only when needed
>         Only allocate doorbells when the first queue is created on a 
> GPU or the
>     doorbells need to be mapped into CPU or GPU virtual address space. 
> This
>     avoids allocating doorbells unnecessarily and can allow more 
> processes
>     to use KFD on multi-GPU systems.
>         Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>     Reviewed-by: Kent Russell <kent.Russell@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
>
> Until we have an alternative way to allocate doorbells that supports 
> overcommitment, late doorbell allocation is an important feature. This 
> change will cause regressions for some ROCm users.

Thanks for pointing this out. I suspected that doorbell creation is 
getting delayed deliberately, but could not understand why. I will move 
the process level doorbell creation to this same point, which will allow 
late doorbell allocation as well.

- Shashank

>
> Regards,
>   Felix
>
>
>
>>       /* Starting with GFX11, wptr BOs must be mapped to GART for MES 
>> to determine work
>>        * on unmapped queues for usermode queue oversubscription (no 
>> aggregated doorbell)
>>        */
>> @@ -410,7 +404,6 @@ static int kfd_ioctl_create_queue(struct file 
>> *filep, struct kfd_process *p,
>>       if (wptr_bo)
>>           amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
>>   err_wptr_map_gart:
>> -err_alloc_doorbells:
>>   err_bind_process:
>>   err_pdd:
>>       mutex_unlock(&p->mutex);
>> @@ -2163,12 +2156,6 @@ static int criu_restore_devices(struct 
>> kfd_process *p,
>>               ret = PTR_ERR(pdd);
>>               goto exit;
>>           }
>> -
>> -        if (!pdd->doorbell_index &&
>> -            kfd_alloc_process_doorbells(pdd->dev, 
>> &pdd->doorbell_index) < 0) {
>> -            ret = -ENOMEM;
>> -            goto exit;
>> -        }
>>       }
>>         /*
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> index ecb4c3abc629..855bf8ce3f16 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> @@ -371,7 +371,7 @@ static int allocate_doorbell(struct 
>> qcm_process_device *qpd,
>>               unsigned int found;
>>                 found = find_first_zero_bit(qpd->doorbell_bitmap,
>> -                        KFD_MAX_NUM_OF_QUEUES_PER_PROCESS);
>> +                            KFD_MAX_NUM_OF_QUEUES_PER_PROCESS);
>>               if (found >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS) {
>>                   pr_debug("No doorbells available");
>>                   return -EBUSY;
>> @@ -381,9 +381,9 @@ static int allocate_doorbell(struct 
>> qcm_process_device *qpd,
>>           }
>>       }
>>   -    q->properties.doorbell_off =
>> -        kfd_get_doorbell_dw_offset_in_bar(dev, qpd_to_pdd(qpd),
>> -                      q->doorbell_id);
>> +    q->properties.doorbell_off = 
>> amdgpu_doorbell_index_on_bar(dev->adev,
>> +                                  qpd->proc_doorbells,
>> +                                  q->doorbell_id);
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
>> index 82b4a56b0afc..718cfe9cb4f5 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
>> @@ -227,46 +227,47 @@ uint64_t kfd_get_number_elems(struct kfd_dev *kfd)
>>     phys_addr_t kfd_get_process_doorbells(struct kfd_process_device 
>> *pdd)
>>   {
>> -    if (!pdd->doorbell_index) {
>> -        int r = kfd_alloc_process_doorbells(pdd->dev,
>> -                            &pdd->doorbell_index);
>> -        if (r < 0)
>> -            return 0;
>> -    }
>> +    struct amdgpu_device *adev = pdd->dev->adev;
>> +    uint32_t first_db_index;
>>   -    return pdd->dev->doorbell_base +
>> -        pdd->doorbell_index * kfd_doorbell_process_slice(pdd->dev);
>> +    first_db_index = amdgpu_doorbell_index_on_bar(adev, 
>> pdd->qpd.proc_doorbells, 0);
>> +    return adev->doorbell.base + first_db_index * sizeof(uint32_t);
>>   }
>>   -int kfd_alloc_process_doorbells(struct kfd_dev *kfd, unsigned int 
>> *doorbell_index)
>> +int kfd_alloc_process_doorbells(struct kfd_dev *kfd, struct 
>> kfd_process_device *pdd)
>>   {
>> -    int r = 0;
>> -
>> -    if (!kfd->shared_resources.enable_mes)
>> -        r = ida_simple_get(&kfd->doorbell_ida, 1,
>> -                   kfd->max_doorbell_slices, GFP_KERNEL);
>> -    else
>> -        r = amdgpu_mes_alloc_process_doorbells(
>> -                (struct amdgpu_device *)kfd->adev,
>> -                doorbell_index);
>> +    int r;
>> +    struct qcm_process_device *qpd = &pdd->qpd;
>>   -    if (r > 0)
>> -        *doorbell_index = r;
>> +    /* Allocate bitmap for dynamic doorbell allocation */
>> +    qpd->doorbell_bitmap = 
>> bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
>> +                         GFP_KERNEL);
>> +    if (!qpd->doorbell_bitmap) {
>> +        DRM_ERROR("Failed to allocate process doorbell bitmap\n");
>> +        return -ENOMEM;
>> +    }
>>   -    if (r < 0)
>> -        pr_err("Failed to allocate process doorbells\n");
>> +    /* Allocate doorbells for this process */
>> +    r = amdgpu_bo_create_kernel(kfd->adev,
>> +                    kfd_doorbell_process_slice(kfd),
>> +                    PAGE_SIZE,
>> +                    AMDGPU_GEM_DOMAIN_DOORBELL,
>> +                    &qpd->proc_doorbells,
>> +                    NULL,
>> +                    NULL);
>> +    if (r) {
>> +        DRM_ERROR("Failed to allocate process doorbells\n");
>> +        bitmap_free(qpd->doorbell_bitmap);
>> +        return r;
>> +    }
>>   -    return r;
>> +    return 0;
>>   }
>>   -void kfd_free_process_doorbells(struct kfd_dev *kfd, unsigned int 
>> doorbell_index)
>> +void kfd_free_process_doorbells(struct kfd_dev *kfd, struct 
>> kfd_process_device *pdd)
>>   {
>> -    if (doorbell_index) {
>> -        if (!kfd->shared_resources.enable_mes)
>> -            ida_simple_remove(&kfd->doorbell_ida, doorbell_index);
>> -        else
>> -            amdgpu_mes_free_process_doorbells(
>> -                    (struct amdgpu_device *)kfd->adev,
>> -                    doorbell_index);
>> -    }
>> +    struct qcm_process_device *qpd = &pdd->qpd;
>> +
>> +    bitmap_free(qpd->doorbell_bitmap);
>> +    amdgpu_bo_free_kernel(&qpd->proc_doorbells, NULL, NULL);
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 0b199eb6dc88..dfff77379acb 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -661,7 +661,10 @@ struct qcm_process_device {
>>       uint64_t ib_base;
>>       void *ib_kaddr;
>>   -    /* doorbell resources per process per device */
>> +    /* doorbells for kfd process */
>> +    struct amdgpu_bo *proc_doorbells;
>> +
>> +    /* bitmap for dynamic doorbell allocation from the bo */
>>       unsigned long *doorbell_bitmap;
>>   };
>>   @@ -1009,9 +1012,9 @@ unsigned int 
>> kfd_get_doorbell_dw_offset_in_bar(struct kfd_dev *kfd,
>>                       unsigned int doorbell_id);
>>   phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd);
>>   int kfd_alloc_process_doorbells(struct kfd_dev *kfd,
>> -                unsigned int *doorbell_index);
>> +                 struct kfd_process_device *pdd);
>>   void kfd_free_process_doorbells(struct kfd_dev *kfd,
>> -                unsigned int doorbell_index);
>> +                 struct kfd_process_device *pdd);
>>   /* GTT Sub-Allocator */
>>     int kfd_gtt_sa_allocate(struct kfd_dev *kfd, unsigned int size,
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index 51b1683ac5c1..217ff72a97b0 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -1037,10 +1037,9 @@ static void kfd_process_destroy_pdds(struct 
>> kfd_process *p)
>>               free_pages((unsigned long)pdd->qpd.cwsr_kaddr,
>>                   get_order(KFD_CWSR_TBA_TMA_SIZE));
>>   -        bitmap_free(pdd->qpd.doorbell_bitmap);
>>           idr_destroy(&pdd->alloc_idr);
>>   -        kfd_free_process_doorbells(pdd->dev, pdd->doorbell_index);
>> +        kfd_free_process_doorbells(pdd->dev, pdd);
>>             if (pdd->dev->shared_resources.enable_mes)
>>               amdgpu_amdkfd_free_gtt_mem(pdd->dev->adev,
>> @@ -1453,11 +1452,6 @@ static int init_doorbell_bitmap(struct 
>> qcm_process_device *qpd,
>>       if (!KFD_IS_SOC15(dev))
>>           return 0;
>>   -    qpd->doorbell_bitmap = 
>> bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
>> -                         GFP_KERNEL);
>> -    if (!qpd->doorbell_bitmap)
>> -        return -ENOMEM;
>> -
>>       /* Mask out doorbells reserved for SDMA, IH, and VCN on SOC15. */
>>       pr_debug("reserved doorbell 0x%03x - 0x%03x\n", range_start, 
>> range_end);
>>       pr_debug("reserved doorbell 0x%03x - 0x%03x\n",
>> @@ -1499,9 +1493,15 @@ struct kfd_process_device 
>> *kfd_create_process_device_data(struct kfd_dev *dev,
>>       if (!pdd)
>>           return NULL;
>>   +    retval = kfd_alloc_process_doorbells(dev, pdd);
>> +    if (retval) {
>> +        pr_err("failed to allocate process doorbells\n");
>> +        goto err_free_pdd;
>> +    }
>> +
>>       if (init_doorbell_bitmap(&pdd->qpd, dev)) {
>>           pr_err("Failed to init doorbell for process\n");
>> -        goto err_free_pdd;
>> +        goto err_free_db;
>>       }
>>         pdd->dev = dev;
>> @@ -1529,7 +1529,7 @@ struct kfd_process_device 
>> *kfd_create_process_device_data(struct kfd_dev *dev,
>>                           false);
>>           if (retval) {
>>               pr_err("failed to allocate process context bo\n");
>> -            goto err_free_pdd;
>> +            goto err_free_db;
>>           }
>>           memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
>>       }
>> @@ -1541,6 +1541,9 @@ struct kfd_process_device 
>> *kfd_create_process_device_data(struct kfd_dev *dev,
>>         return pdd;
>>   +err_free_db:
>> +    kfd_free_process_doorbells(pdd->dev, pdd);
>> +
>>   err_free_pdd:
>>       kfree(pdd);
>>       return NULL;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> index 5137476ec18e..6c95586f08a6 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> @@ -344,17 +344,19 @@ int pqm_create_queue(struct 
>> process_queue_manager *pqm,
>>           goto err_create_queue;
>>       }
>>   -    if (q && p_doorbell_offset_in_process)
>> +    if (q && p_doorbell_offset_in_process) {
>>           /* Return the doorbell offset within the doorbell page
>>            * to the caller so it can be passed up to user mode
>>            * (in bytes).
>> -         * There are always 1024 doorbells per process, so in case
>> -         * of 8-byte doorbells, there are two doorbell pages per
>> -         * process.
>> +         * relative doorbell index = Absolute doorbell index -
>> +         * absolute index of first doorbell in the page.
>>            */
>> -        *p_doorbell_offset_in_process =
>> -            (q->properties.doorbell_off * sizeof(uint32_t)) &
>> -            (kfd_doorbell_process_slice(dev) - 1);
>> +        uint32_t first_db_index = 
>> amdgpu_doorbell_index_on_bar(pdd->dev->adev,
>> +                                    pdd->qpd.proc_doorbells, 0);
>> +
>> +        *p_doorbell_offset_in_process = (q->properties.doorbell_off
>> +                        - first_db_index) * sizeof(uint32_t);
>> +    }
>>         pr_debug("PQM After DQM create queue\n");
>>   @@ -858,12 +860,6 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>>           goto exit;
>>       }
>>   -    if (!pdd->doorbell_index &&
>> -        kfd_alloc_process_doorbells(pdd->dev, &pdd->doorbell_index) 
>> < 0) {
>> -        ret = -ENOMEM;
>> -        goto exit;
>> -    }
>> -
>>       /* data stored in this order: mqd, ctl_stack */
>>       mqd = q_extra_data;
>>       ctl_stack = mqd + q_data->mqd_size;
