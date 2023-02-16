Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85703C61DA4
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Feb 2023 13:13:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AE7010E179;
	Thu, 16 Feb 2023 13:13:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2988110E179
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Feb 2023 13:13:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7xjCRT+TLiF8vKDxnP9NIO86yj6Z9Wvr9siOflDlbyh95uCI7T3Ndq7u63DTS8N628kaOyw2yRqd1ahjsf9FzGjz+5kwPn98NG6++NGuUB1hXXJhTO6GYE0ojnFSPpI46UR6b3t22u1C6QMEuK7/WM0TZdOy99N3zH3rMf4qGz/17g3kdjfB2g9zjEOGaHoyxicXZ/BNwXWOs4yTUqP5GSsXII+RDCSSJoEWQRJGfKLv36VXO6XcfDo7Apn9kCFj12w45Nq67jD3SeXyLdZ8DDDsjmDQu9i+6YRG6Yj/b66rwS7Ze++9UOH2i/aHFNlg7EwM1pqsS4B0x+p0QnW1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VJvVemQPiEUCPRTGurN8vU/g7dJ+xzDPsc6C600cOo=;
 b=eszcRVw5uVtOrFUQCGpsmdhDvJK7oWy3nq0QM95+E1/7FsAKJCV8sY+LMbbUxLZJFHCFjFP2zPH1D8lzDyolsXHzbDKi1SGhvVL1ZJehC7mDk7aGK4aCBgDdsrCSKAmoddshIYWES5HN5ksP6fGOi+VosgDYfw5WaeerynAQm1jx8N6V2ndq/7mZYZ4W+FMmg7GtekAnzXZ5IdQaXy14subwxjjp9qA7l49oNQ5ZKniPFQw0dOnJmP9eylB6y0yv6QvrPITCNy+C0k8TO15iWQCvEDPd/Pd1DeVI6ClB3NeGcvVyL7CtrdBYEy3WEujmdE37mhuhTmTUlhqe5E+A+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VJvVemQPiEUCPRTGurN8vU/g7dJ+xzDPsc6C600cOo=;
 b=m3H7HBIg6nA5UnKXWkPQFCgnLw44HrlO7p3aGLOtUGgHuuGd6k6qnYRwR9LKRvb28/B4l4ox+TMxpU/h1v1hLNH78k3G/esxbLZXDw0MZmDy7dEmyBm5JTBhkxPU+Xf13jarQTW3O9BtzO6ydS1F3RDS5A36uidOVrCbwF+eXQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by SN7PR12MB8435.namprd12.prod.outlook.com (2603:10b6:806:2e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 13:13:19 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6c1f:b156:aec5:de5a]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6c1f:b156:aec5:de5a%4]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 13:13:18 +0000
Message-ID: <e1ac82e8-8ad8-dd5b-32f4-4bf572962029@amd.com>
Date: Thu, 16 Feb 2023 14:13:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 7/8] drm/amdgpu: create doorbell kernel object
Content-Language: en-US
From: Shashank Sharma <shashank.sharma@amd.com>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230214161510.2153-1-shashank.sharma@amd.com>
 <20230214161510.2153-8-shashank.sharma@amd.com>
 <4d5dee60-537d-745d-9bc9-1246f50427fe@amd.com>
 <626ab9bd-9cd2-809b-1691-10ff31b4f52f@amd.com>
In-Reply-To: <626ab9bd-9cd2-809b-1691-10ff31b4f52f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::21) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|SN7PR12MB8435:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb56db7-1672-40da-cb06-08db101f9202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LQq/4XIuJOF8cISEDkejJz+DxTl6kToYpytHErS/uU34w0uUW0RHMvh7cL+vuhOGoPqzGxfqgJOCdYTBfkeaB15SgYwn+wWcrvnhzd7gsX1QeZTXtPuF7NGmBGBoUho//AI9vHwsHp2o25xOnjBgqDdJkVYEL0IuKdRKQSUDh1iy5b5xVLGqVSpm4lOwTan6Y/D92Xcnlv2b3r66N3IQY6jwksiYlWjgDyomIqZ7IuFFh8Y3a1bNkwbopT4CQSVSADlEmCgEeJvPW3ewsc9sp1Ko9NjksjsNfw8+hmv0Ci/xNWFIoE3I+w6MAXPCbK90KiuWprtM9+2OYsKeFERf1KDQ4TRPDvDbFQuaQMOR7cwXs2MOMh386DmVshIlAsEsYk3JJfeBjrDrTlXy/YnG6xB7HaPeuE8vncyASTyOjpVTKioflg7KwXwM9JMxzqlf7Jn2H0ESL0MN/xi9f+Wb2hLcEJE3CGdhoXKAVvc2RoaaBGMHs1gAHR3u4623iqzJZ4jodwO1uoFrz0s2Ppy2wxQi2jbWzDIfs2a6oF7GV3M6Mmw1rwKjG5QWROdb9GpwSFfdCKSZqzpytJ+wIUoquuWQGYjju1WXkJQGkKaSErvZSvnmVDG60ZNovQeT2H8H32d9FQK3+u9Z1AEoUmEr093MQMgg8ttXNBHDrxVaonhnqL6vemvT+OD9JeEE1uxX63A8TkrqtdQwucryLViTXV9SjPIE0kgwPWuElvMs1AQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199018)(36756003)(66476007)(5660300002)(44832011)(41300700001)(2906002)(8936002)(66556008)(478600001)(6486002)(4326008)(8676002)(66946007)(316002)(38100700002)(31686004)(66574015)(2616005)(6666004)(53546011)(6506007)(86362001)(186003)(31696002)(26005)(6512007)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHVrNmhDZ3RVQ0ZDbU40Y2Q0VjE1M3JKN0lPanVXTyswTDhONG1CV3JkbnVV?=
 =?utf-8?B?dC9mcGsvN1RDVk9odkNBK1ZacWtZM2l3c1VjSk5rd0NpWGJYV016SjFna3R4?=
 =?utf-8?B?TFNvUy9IWU05TmpxeXJSbkxHV3dIb3VRUDQwY2dtODFQUEZ0aHpWN2hHdVE2?=
 =?utf-8?B?SDA3QlhVSzBOckJReEZiODh5UG1wcmxPYU42TXp1VE1hK2pHdFZyOVduK3hx?=
 =?utf-8?B?cnRzQi82U3ZQL1g1M0R6bElQYlFwdXJ6RGVRTHNpYWJackRPK3NZa3Y4czBV?=
 =?utf-8?B?V2JER0lsMEtLTGNka2NzeU9BSFNhTFpkV3NTTy9YMTdDOTBGZzg4WXhTVmJK?=
 =?utf-8?B?Z3pVS3Z4QzJKcnFsQjd4UThCMTU4K0Y3VURQU1M3UzdrK1lIajdBbGdGM29n?=
 =?utf-8?B?T0ZKZjRmbjBKUndtVHhTeFJ0V3hFR0tHRHUxUWgvM1kwendBKzVYSENwdTVU?=
 =?utf-8?B?cEZINExoNUswaWZoUVQwU2VEUUo1RU1tNTBiYkNwOFR1TlhMOGsyNVFPVElZ?=
 =?utf-8?B?SHNtVzA4dTlPcHg3YzJTaVJSRWtlaFZBb2Z1L0JVMUdPdUxiUjQ5VDlwbUxm?=
 =?utf-8?B?RnpIK2R1cm1HNTVtOVJHWFR6bzdRM2p5RXpVWHQwaDhhY1FMaEFUSWtIMklQ?=
 =?utf-8?B?Y2UzaVJhaWVpYmxEVnFPQ1RsMDVaZmx3R3FPMGdmWFQrOURmc1A4aUs2STh1?=
 =?utf-8?B?c0dBeHFjWTBUMlY4VVhqb0lWTnBTNndzaC9vTTBrOVVhaFVMdVdSdUdqUlVR?=
 =?utf-8?B?MHpQTjJjMkhtMkxFNGNXTEROSE5aK2VQUHNPRXBkVEsvWEtGTm4zdW4yR0RH?=
 =?utf-8?B?WkxrYXRqR3VtWmR6VEtsb2FrQTdhZzhpQzlPRC80N3gvbm5PQndudkU3WElN?=
 =?utf-8?B?SVdYWG5TY1Rlc1VkN09RT0UyaTB1OHVmSld5MjQyKzVFckJTZ2pndFJ3SVVJ?=
 =?utf-8?B?TEJNLzdzYUEzQW40TDZTblhQeTdyZ3ljT0xySStUMnBGYmJzMkljc283L2Jy?=
 =?utf-8?B?VmJrcDJZa3BZWFMzUjhEQzY0UUcwM21PMVMyaTEyUGdjb3p0NEF0aWhnckU1?=
 =?utf-8?B?SDY0S2phSUp4VmR0YkRGQUpvVHBJclEweGVHT2xteWd6Vm9aSzNGeDNIQlpi?=
 =?utf-8?B?ZVNpWTlUTnZUMUUyYlplNmlibklRMExib05kd3ZDT0VoZ3E0bGpuVEhpUWNS?=
 =?utf-8?B?V2U3UlNCSWJYQ0ZNcW56MFJmTXNGQ29mWG94RWUxNjF1Zk1iUVBaRjYxek53?=
 =?utf-8?B?ZzRWSSs3MkRockpSak8xTitMTUtIT21pdHhoOGlDRGR5OFllLzlEY1gzVjBU?=
 =?utf-8?B?NzN1bGhBU3h0M2EwQzREc1BqRVNpZ05ENEQ4UXhSZWdZRzBFK2sxWnBKcWJX?=
 =?utf-8?B?THFTS0VjQ08xM2tpK0lZMzE0R3FURURkYW9reUc4Q3hNbW1jMXdCeG5kSklB?=
 =?utf-8?B?RmhLU0JzTHd6NE5vTFBiNDFGWmhmNXpJRExXY2lkczN3Y0NEMThqMHRMcHly?=
 =?utf-8?B?V09GMHUrQnJpL1gzMitSbXM2L2cvTFFYMHRHZGJUYXFYd1o4UkQ0MDBaWUxq?=
 =?utf-8?B?QVV1YWV5TmhaVlB3alZIK2lqNFRjT29aQWRQOGVudnFoekl3UkRmZkVJZWht?=
 =?utf-8?B?dWJrdEVBRDR1YTNGcU5TMXNRazFDenZzc3JWUHhnTlZTeUh3KzFsSVZPM0l0?=
 =?utf-8?B?V1hJdmxBaTRoSFhWSnp4ak56QnJEWFpRYkh1aGZzSWwvQjV1RzByQzdjeFgx?=
 =?utf-8?B?NlMrMktmOTVrZlE2Y2VnenRTaG1kcXBjK0RGR0Z4TXZOb0xYci9Vdmx4ak84?=
 =?utf-8?B?K0EvVHBIczlPSFJSZW9wNFUwVndzOUNPWnIwQ2FYemlZZHplb1IxYmhVY3V4?=
 =?utf-8?B?bVF4amVkSnBhNERSU2k0alFSb1F2TmxZdjM3NzdJWXRDd3hxdWdDTThuWFFN?=
 =?utf-8?B?Yzg2ckFlYnFhczZyT2tyWjA2MTBRMjF5YXZlNnpQZnR4RDBaeGRBSEV4bGdi?=
 =?utf-8?B?M2FPbXdxVEVrczYrVnlRNHBObGpadVBZeDlpeXl1SHZPTmdLMFYxRnVmblh4?=
 =?utf-8?B?dFk0VU4wdHNmRSs1VlFxN3RxZnhYNld3dGtBeDBvMFQwVVBGRHUya1hsMXZ3?=
 =?utf-8?Q?90JFNt4binzUdEK2UFYGCHelH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb56db7-1672-40da-cb06-08db101f9202
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 13:13:18.6664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8Zr8l1THzDEU3b9tOmGIyB6jvAsJyqjuLeVvQiyttuYVP+GL2cGIESYM3sKMczuPNhzQ/2NZfC9aQgNDsWEfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8435
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
Cc: alexander.deucher@amd.com,
 Shashank Sharma <contactshashanksharma@gmail.com>, Arvind.Yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 14/02/2023 20:26, Shashank Sharma wrote:
>
> On 14/02/2023 19:35, Christian König wrote:
>> Am 14.02.23 um 17:15 schrieb Shashank Sharma:
>>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>>
>>> This patch does the following:
>>> - Initializes TTM range management for domain DOORBELL.
>>> - Introduces a kernel bo for doorbell management in form of 
>>> mman.doorbell_kernel_bo.
>>>    This bo holds the kernel doorbell space now.
>>> - Removes ioremapping of doorbell-kernel memory, as its not required 
>>> now.
>>>
>>> V2:
>>> - Addressed review comments from Christian:
>>>      - do not use kernel_create_at(0), use kernel_create() instead.
>>>      - do not use ttm_resource_manager, use range_manager instead.
>>>      - do not ioremap doorbell, TTM will do that.
>>> - Split one big patch into 2
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 22 ++++++++++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  7 +++++++
>>>   2 files changed, 29 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index e9dc24191fc8..086e83c17c0f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -1879,12 +1879,32 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>>           return r;
>>>       }
>>>   +    r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_DOORBELL, 
>>> adev->doorbell.doorbell_aper_size);
>>> +    if (r) {
>>> +        DRM_ERROR("Failed initializing oa heap.\n");
>>> +        return r;
>>> +    }
>>> +
>>>       if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
>>>                   AMDGPU_GEM_DOMAIN_GTT,
>>>                   &adev->mman.sdma_access_bo, NULL,
>>>                   &adev->mman.sdma_access_ptr))
>>>           DRM_WARN("Debug VRAM access will use slowpath MM access\n");
>>>   +    /* Create a doorbell BO for kernel usages */
>>> +    r = amdgpu_bo_create_kernel(adev,
>>> +                    adev->mman.doorbell_kernel_bo_size,
>>> +                    PAGE_SIZE,
>>> +                    AMDGPU_GEM_DOMAIN_DOORBELL,
>>> +                    &adev->mman.doorbell_kernel_bo,
>>> +                    &adev->mman.doorbell_gpu_addr,
>>> +                    (void **)&adev->mman.doorbell_cpu_addr);
>>> +
>>> +    if (r) {
>>> +        DRM_ERROR("Failed to create doorbell BO, err=%d\n", r);
>>> +        return r;
>>> +    }
>>> +
>>
>> I would even move this before the SDMA VRAM buffer since the later is 
>> only nice to have while the doorbell is mandatory to have.
> Agree,
>>
>>>       return 0;
>>>   }
>>>   @@ -1908,6 +1928,8 @@ void amdgpu_ttm_fini(struct amdgpu_device 
>>> *adev)
>>>                         NULL, NULL);
>>>       amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>>>                       &adev->mman.sdma_access_ptr);
>>> + amdgpu_bo_free_kernel(&adev->mman.doorbell_kernel_bo,
>>> +                  NULL, (void **)&adev->mman.doorbell_cpu_addr);
>>>       amdgpu_ttm_fw_reserve_vram_fini(adev);
>>>       amdgpu_ttm_drv_reserve_vram_fini(adev);
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> index 9cf5d8419965..50748ff1dd3c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> @@ -97,6 +97,13 @@ struct amdgpu_mman {
>>>       /* PAGE_SIZE'd BO for process memory r/w over SDMA. */
>>>       struct amdgpu_bo    *sdma_access_bo;
>>>       void            *sdma_access_ptr;
>>> +
>>> +    /* doorbells reserved for the kernel driver */
>>> +    u32            num_kernel_doorbells;    /* Number of doorbells 
>>> actually reserved for kernel */
>>> +    uint64_t        doorbell_kernel_bo_size;
>>
>> That looks like duplicated information. We should only keep either 
>> the number of kernel doorbells or the kernel doorbell bo size around, 
>> not both.
> Yeah, agree. I can remove one of these two.

On a second thought, while doing some experiments with doorbells I 
realized that we might want to keep both of these, as:

num_kernel_doorbell = actual doorbells reserved for kernel,

doorbell_kernel_bo_size = max (PAGE_SIZE,  num_kernel_doorbell* sizeof(u32))

I will have to update the code to reflect that as well.


- Shashank

>>
>> And BTW please no comment after structure members.
>>
> Noted,
>
> - Shashank
>
>> Christian.
>>
>>> +    uint64_t        doorbell_gpu_addr;
>>> +    struct amdgpu_bo    *doorbell_kernel_bo;
>>> +    u32            *doorbell_cpu_addr;
>>>   };
>>>     struct amdgpu_copy_mem {
>>
