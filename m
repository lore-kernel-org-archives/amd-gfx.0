Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C07E4C636CC
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 14:19:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5046910E513;
	Tue,  7 Feb 2023 14:19:24 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92CB210E50E
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 14:19:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/BqysxN3YeTCTbgpc4srp5qEzAqf6bsoF8vx+sKpe3K4dSawnYGG8RKpQkc+ZIzvTF7xM41nZ34rV4EGUNUmZ0AYQkvi4maLT3afpNsuNYeLB4pEJPnzCN1jJQ4AMOPPt7Zlxs51eioNKBg6rbE05V9HenLjca7u7YYwA2NVt15IPPYEwyE4dqLcigGMI+rdllvpUuqkGURbBuxp+OyGafPE2sbWjFP9UHC0slfzbIN9TaBnRoS7UDG4ekCHmVU7qclqUjVbKukFaGrXSU1wxRdtcs7FpDwbu6bIZTlwL6rL6DH0asHr5GJkvSwGbFp463/CaRzt8iv0IGmV3ShYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5OAu9wUBNxHHmR66OLgJB239tZWX1UqgPCsaLS9mL8=;
 b=S9GAzZxi9CO4YpjzSqmuZOvMyQ1bWKKZtVEHTs3OyYbPDOY2tB0o5YMPYwtRU7d+UaZWluQQP3PnlocJAiLMD0B342l0u6ZbPiAlpwX4nrcl7P9W5d6lgoCTabJ1ST8cRTjKvs9Fa2Zvrh3+XvE/o4ljW2DppW0wU0x7aTlUX0D3P/OPOB79AQuuvX8nZjTZHb9R82tbHmaSyM8ergZSNp1sbA0xWiQHCcxNo2SCWCA/tzpN0IO9v5BAO8Qa7HIvvn8PWsEt3QKcM4mEOgWv9NbCV31qp+WqOqGSFLA4lqs7KSu+eqV9dWe7SQe7W2HSUatSm6tjl3V/QSvBuU3WtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5OAu9wUBNxHHmR66OLgJB239tZWX1UqgPCsaLS9mL8=;
 b=NSg0y1IfF3fO/ZbHpy8R6Adsc1ttOYsAVFzGHJu2Uz2HDb5J2eansAVMjHnq41+tE6ZJ4tsh0zcZB/uHeo6qwd7c3/mEmo2569URi+366bw4ECFJuPylEX8G598P62noVMC1GFCw+VB5KUkumeYv5HktuOOGqUDuS2IwbEN5ebE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29; Tue, 7 Feb
 2023 14:19:18 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6064.032; Tue, 7 Feb 2023
 14:19:17 +0000
Message-ID: <53e67546-cf9b-860e-d39f-f0258c3a5d31@amd.com>
Date: Tue, 7 Feb 2023 15:19:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/8] drm/amdgpu: UAPI for user queue management
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <20230203215409.2021-2-shashank.sharma@amd.com>
 <CADnq5_MSMivTzo0k+wJj+bGpsQZ3HEDVt5XqzjGdBiv08fFWCQ@mail.gmail.com>
 <95ac9ea3-47c8-744c-7fd7-ddc54b19926f@amd.com>
 <CADnq5_M9q0R=d=KU8P4oVOCY0Gw97Uhzy6Mrg0GgxeROGn6xrQ@mail.gmail.com>
 <afce1a57-8007-5d1b-0715-9756d7d07153@amd.com>
 <CADnq5_P8UJYvnH_kWcPY2hfnhU3Ppo-3RoQAU5Ohf1T841kvzQ@mail.gmail.com>
 <bb992153-fa99-7b50-a188-e49a8d673439@gmail.com>
 <e5762028-238e-f317-8ba7-9c284d7a80af@amd.com>
 <CADnq5_ORm-=seDMuV8Z=c7K+zPypbvu=huzPmHSe1A44m_cTyQ@mail.gmail.com>
 <7cde3170-49c3-9b15-4289-df754ca4804e@gmail.com>
 <CADnq5_Pw6hjpSce1Oy+Y4O_CQxdmqurNSbTHK6tuhzKPzx=ucA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_Pw6hjpSce1Oy+Y4O_CQxdmqurNSbTHK6tuhzKPzx=ucA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0191.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::9) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ0PR12MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: 56da11c9-f495-42f9-a66a-08db09164c23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IjQLnjE8HrUags+w1+PO36pvwAurwQArssGRz98tPPEzm3BAH5Y6T5hAfHY77fkXnVNDmKhB+MHhSxZHF6ibD0SXznHIX1jPBnz2ayzzODGbW3jB8f1OVS9PV9QwuRQpfh9zXr+e6Acprr+Dbfm6gn7fz4C1ijJd/7Z3FcMFcpZnTodF++t9tDgnZ4ft5vDr/zNRzqGspcU6zhw5vD7GgD9isAIdZzc6ImFQg43o009Fli+t7WvxoxlQffkQRYb1kObPUUXvCBu7hT/rg2j9xv8XpY5BLxyx2g57ci80zC2OTyUIrYMskbGkPsRjhnl3aNVSq0HqWP/NEMDdC1WVygFoQlOFNhRfrFf3qKO4EFrggRogXT5uS2rzwUg6ywCizRROvRB00kPvesCnRl2/hmqEzUUDU1A4a3kcm5B5OPQpYekmA8Ek2ZA3Jfsh3bx//JtGG1eqNgKGT8+npAr8kKAUBB0hsUYDp4ax6enjjteMqA4t8VTqxpWo0Bmk2pEvVEbGT0PVUuTvQ2bqYbJ7bRlNrcPsdtqsTW24znUw/Bv3qBbO46Yb32aM2IPYBofXDHpxiW2nrfFsrunU9xwySgQIIgn7OfgEmhg1KNYP+7ACI/WCp/ZRvUuedGFfaCO3AuQMHrR9ScwMvo0W3T3sQw1BEko6vzXJ/1VBZchgUeMj0U2+ZQxrb/eNDfpqnWX4m9ArDqq44zBBF2xOAwcur0KlzHPHvD/PyeKMmsuIFqs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199018)(110136005)(316002)(6486002)(478600001)(31686004)(38100700002)(66476007)(8676002)(186003)(26005)(31696002)(4326008)(66556008)(6512007)(66946007)(86362001)(5660300002)(41300700001)(6666004)(6506007)(66574015)(36756003)(8936002)(2616005)(83380400001)(53546011)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WCtqNEljQ0I5NlJzNXA5a0h2WmwwV2VTSG1BdUVwZ0ZnYVNWOEUwejNFT1B3?=
 =?utf-8?B?dTVOcU5ja2pjb2w5QzdPTjB3UDA2ODlIbW9ZMTVnYUFLeFJuc2dzMXBqUVBS?=
 =?utf-8?B?OEYrOEVjZjZLSFprOUVSTkF2R3pxYW1KOStxTUZHYzR0bjZSeE9jMTlQZlpR?=
 =?utf-8?B?eTJWYjhkakR1Mk10MVl1c3J6b1B6RGtoODlwRWxkVXVMWVRkY2V3WXNuQS9q?=
 =?utf-8?B?dlBUeWVqWEplVGwxTWFpYnpLcWtzc3pyZ2pOYjRJZElQSSszekhyUjh1WENT?=
 =?utf-8?B?VWQ3RklvVldZdkZITGs2aHVZT0xXTUR0REc4R09QdWlQYTI4d2phSm1nS0Vw?=
 =?utf-8?B?ODdOVzlETzNzNEl0K3owTm1QWDVHanZQckNoQ21yYjFVZkFOTXJnYno1OG1r?=
 =?utf-8?B?eUpDQ3UwY3pXZlJ5a21YYTdkdFREKzJhZjZQN053WG5SamJWUzF0ckl0ODg3?=
 =?utf-8?B?dkNnOU9iQkFYOGcxOEk5eGl0aVplRDdydHoxMzRDNUFMZ3h0SHcvSWFGYXJl?=
 =?utf-8?B?dnFLUnZ6TCtlSENCMXhXaGRVRzNIQTBveW4xLzhsTkRrQUhpVnZodUxIZEZw?=
 =?utf-8?B?QjNYeW0xZWJab29uK3pBeUtnT1g0enRHTWdBTU4vUkNzeDVZY0RIdHJEOWV1?=
 =?utf-8?B?NndXSWIyUHV4OGRsQmtZTm9yTERnVW5ubHlYNFBqZWVYRjRhTldvWVBuQkNW?=
 =?utf-8?B?NzVzc1pndTQ1RGVZWFByVWJ3TTQySU9rUnUxR243RWhlSStPNmIwZkt5VzZu?=
 =?utf-8?B?dmRLSUJydFlqY3RkSVhGbEQ0eGd0MWZPK1dMT2pHZXRGSlg0a1RXb0o5SitK?=
 =?utf-8?B?Q0llOVhCRnNkUEtucFBxN0hzbE9DRkRWeW93aDNsSVRTaU42NnMzQjdzVXFC?=
 =?utf-8?B?cFZ2QUxkOUpiOXkwMGdJMy9JNDNEbmhwMEVxeWNpWVNPNXExNk5DRWJpS2Vs?=
 =?utf-8?B?VE1PU1JLd3liekc2QWFrMGhtSzNHK094aTlYYmFoN2tYYVFZVjdDYi9ua3hJ?=
 =?utf-8?B?aXBqWDRVV3NibXhPdXpuWUZzaktFb2VqRkp2NmhVeHhlQzdOVlpEWStuZzZZ?=
 =?utf-8?B?dUYyZFFsTFM3bDhFQkVjT1dPSUNtZm9JSHlweUNoQUtab0pNd05DTWRMeGc2?=
 =?utf-8?B?YURxZEdqYnhzRmx0d2dSUkxSaWl2Ym91Tm5RdTdTU1pJdUZkSk11czJlTjVu?=
 =?utf-8?B?aE90UWw4NXV5TlVETElGdGZxa2RIUng5cmFKd0hmQUFZWEJreWZXMU9iK1Vw?=
 =?utf-8?B?UmV1T3F5VWxTaTJhY1pPM25NV3piSE9YSnM4ZnZET3B3TUMwdzlQQUFrUWNz?=
 =?utf-8?B?eHlERlRZTG00RVhPV0pDeTA4bkNoR1diSExmNlJTYTVFRlJ0eDhoYk5VTmNq?=
 =?utf-8?B?YmJuZ09UMEJMbFg5N3kxdjJCV2o3Qlk0QUp1bHpKdW1tT1ZEZVNGOE9WbWJY?=
 =?utf-8?B?S3E4bzB0Si9IRHBGS1lxWUVOTW9UenYvUkJBeFg2R3hRa2c2N3FIcG5xNjRS?=
 =?utf-8?B?YnV1MHJQZlBhUFQ5MmtSY3FYS2hYYTlwYXlOblBSR1hsRWdJWGdneFIrN0Mr?=
 =?utf-8?B?QUVCMEl0OXphdHk3S0EyNlRkZWQ2Tjh2MGJlQkxGeTJoR3VKSmdBRG1vbWtw?=
 =?utf-8?B?K2o3czdJU2w4VGRXMnFyTG5ZMGRPeGtEbzN5UThhL1hqTm0yMDJIbmZsRzd6?=
 =?utf-8?B?MTl5MTZLU2F3dThHZGRqcUlLMVBYbnZCRkQ3ajFCZHYzdWpERllHZmtjMURx?=
 =?utf-8?B?UURPSS8yT1lLRW5US0Z2aWlUdjQvS2h0Z2UzWUt0SnBvWTZMWFo1K1FaZXdp?=
 =?utf-8?B?NmpEWFYzb1Z1bHpJZ1NiU3ZBSTlZeHdjV2dkZjhOV3ArOWVSK1hWWWVOaFA5?=
 =?utf-8?B?MzZESlZBN2YvcXJqN0xxVnFPT25yOFNoY25FeXc2MEUvTjgzN3RpUnhGN01O?=
 =?utf-8?B?U2RjQnBDVzduMjRweHVsZ3FVMGcwSCs3dGw5c2s1TlpES0QzSWpNcHRmVXdi?=
 =?utf-8?B?N1hCOXJXYUw1QXV5cVQxM1FSRXFRaVppWDZ6TWxlMkNuem44c0hzUXBvMjJp?=
 =?utf-8?B?aUdGUGdqTG1FNm9SanhGcnRrWVBEMmFhYnBNdytXSXFldndtK1J0NVpLM1RK?=
 =?utf-8?Q?PNL8ADWaB+FnRePP4LfQ5GotA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56da11c9-f495-42f9-a66a-08db09164c23
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 14:19:17.6111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUqkSnj4NPEox0C6cfAVohQuUsWUpV/cPXuAbO2hJJSO88IRKYCTnK8pYrRmG3Pf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6806
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
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 07.02.23 um 15:17 schrieb Alex Deucher:
> On Tue, Feb 7, 2023 at 9:11 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Am 07.02.23 um 15:07 schrieb Alex Deucher:
>>> On Tue, Feb 7, 2023 at 2:38 AM Shashank Sharma <shashank.sharma@amd.com> wrote:
>>>> On 07/02/2023 08:03, Christian König wrote:
>>>>> Am 06.02.23 um 22:03 schrieb Alex Deucher:
>>>>>> On Mon, Feb 6, 2023 at 12:01 PM Christian König
>>>>>> <christian.koenig@amd.com> wrote:
>>>>>>> Am 06.02.23 um 17:56 schrieb Alex Deucher:
>>>>>>>> On Fri, Feb 3, 2023 at 5:26 PM Shashank Sharma
>>>>>>>> <shashank.sharma@amd.com> wrote:
>>>>>>>>> Hey Alex,
>>>>>>>>>
>>>>>>>>> On 03/02/2023 23:07, Alex Deucher wrote:
>>>>>>>>>> On Fri, Feb 3, 2023 at 4:54 PM Shashank Sharma
>>>>>>>>>> <shashank.sharma@amd.com> wrote:
>>>>>>>>>>> From: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>>>>
>>>>>>>>>>> This patch intorduces new UAPI/IOCTL for usermode graphics
>>>>>>>>>>> queue. The userspace app will fill this structure and request
>>>>>>>>>>> the graphics driver to add a graphics work queue for it. The
>>>>>>>>>>> output of this UAPI is a queue id.
>>>>>>>>>>>
>>>>>>>>>>> This UAPI maps the queue into GPU, so the graphics app can start
>>>>>>>>>>> submitting work to the queue as soon as the call returns.
>>>>>>>>>>>
>>>>>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>>>>>>> ---
>>>>>>>>>>>       include/uapi/drm/amdgpu_drm.h | 53
>>>>>>>>>>> +++++++++++++++++++++++++++++++++++
>>>>>>>>>>>       1 file changed, 53 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/include/uapi/drm/amdgpu_drm.h
>>>>>>>>>>> b/include/uapi/drm/amdgpu_drm.h
>>>>>>>>>>> index 4038abe8505a..6c5235d107b3 100644
>>>>>>>>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>>>>>>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>>>>>>>>> @@ -54,6 +54,7 @@ extern "C" {
>>>>>>>>>>>       #define DRM_AMDGPU_VM                  0x13
>>>>>>>>>>>       #define DRM_AMDGPU_FENCE_TO_HANDLE     0x14
>>>>>>>>>>>       #define DRM_AMDGPU_SCHED               0x15
>>>>>>>>>>> +#define DRM_AMDGPU_USERQ               0x16
>>>>>>>>>>>
>>>>>>>>>>>       #define DRM_IOCTL_AMDGPU_GEM_CREATE
>>>>>>>>>>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union
>>>>>>>>>>> drm_amdgpu_gem_create)
>>>>>>>>>>>       #define DRM_IOCTL_AMDGPU_GEM_MMAP DRM_IOWR(DRM_COMMAND_BASE
>>>>>>>>>>> + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>>>>>>>>>> @@ -71,6 +72,7 @@ extern "C" {
>>>>>>>>>>>       #define DRM_IOCTL_AMDGPU_VM DRM_IOWR(DRM_COMMAND_BASE +
>>>>>>>>>>> DRM_AMDGPU_VM, union drm_amdgpu_vm)
>>>>>>>>>>>       #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE
>>>>>>>>>>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union
>>>>>>>>>>> drm_amdgpu_fence_to_handle)
>>>>>>>>>>>       #define DRM_IOCTL_AMDGPU_SCHED DRM_IOW(DRM_COMMAND_BASE +
>>>>>>>>>>> DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
>>>>>>>>>>> +#define DRM_IOCTL_AMDGPU_USERQ DRM_IOW(DRM_COMMAND_BASE +
>>>>>>>>>>> DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>>>>>>>>>>>
>>>>>>>>>>>       /**
>>>>>>>>>>>        * DOC: memory domains
>>>>>>>>>>> @@ -302,6 +304,57 @@ union drm_amdgpu_ctx {
>>>>>>>>>>>              union drm_amdgpu_ctx_out out;
>>>>>>>>>>>       };
>>>>>>>>>>>
>>>>>>>>>>> +/* user queue IOCTL */
>>>>>>>>>>> +#define AMDGPU_USERQ_OP_CREATE 1
>>>>>>>>>>> +#define AMDGPU_USERQ_OP_FREE   2
>>>>>>>>>>> +
>>>>>>>>>>> +#define AMDGPU_USERQ_MQD_FLAGS_SECURE  (1 << 0)
>>>>>>>>>>> +#define AMDGPU_USERQ_MQD_FLAGS_AQL     (1 << 1)
>>>>>>>>>>> +
>>>>>>>>>>> +struct drm_amdgpu_userq_mqd {
>>>>>>>>>>> +       /** Flags: AMDGPU_USERQ_MQD_FLAGS_* */
>>>>>>>>>>> +       __u32   flags;
>>>>>>>>>>> +       /** IP type: AMDGPU_HW_IP_* */
>>>>>>>>>>> +       __u32   ip_type;
>>>>>>>>>>> +       /** GEM object handle */
>>>>>>>>>>> +       __u32   doorbell_handle;
>>>>>>>>>>> +       /** Doorbell offset in dwords */
>>>>>>>>>>> +       __u32   doorbell_offset;
>>>>>>>>>> Since doorbells are 64 bit, maybe this offset should be in qwords.
>>>>>>>>> Can you please help to cross check this information ? All the
>>>>>>>>> existing
>>>>>>>>> kernel doorbell calculations are keeping doorbells size as
>>>>>>>>> sizeof(u32)
>>>>>>>> Doorbells on pre-vega hardware are 32 bits so that is where that comes
>>>>>>>> from, but from vega onward most doorbells are 64 bit.  I think some
>>>>>>>> versions of VCN may still use 32 bit doorbells.  Internally in the
>>>>>>>> kernel driver we just use two slots for newer hardware, but for the
>>>>>>>> UAPI, I think we can just stick with 64 bit slots to avoid confusion.
>>>>>>>> Even if an engine only uses a 32 bit one, I don't know that there is
>>>>>>>> much value to trying to support variable doorbell sizes.
>>>>>>> I think we can stick with using __u32 because this is *not* the size of
>>>>>>> the doorbell entries.
>>>>>>>
>>>>>>> Instead this is the offset into the BO where to find the doorbell for
>>>>>>> this queue (which then in turn is 64bits wide).
>>>>>>>
>>>>>>> Since we will probably never have more than 4GiB doorbells we should be
>>>>>>> pretty save to use 32bits here.
>>>>>> Yes, the offset would still be 32 bits, but the units would be
>>>>>> qwords.  E.g.,
>>>>>>
>>>>>> +       /** Doorbell offset in qwords */
>>>>>> +       __u32   doorbell_offset;
>>>>>>
>>>>>> That way you couldn't accidently specify an overlapping doorbell.
>>>>> Ah, so you only wanted to fix the comment. That was absolutely not
>>>>> clear from the discussion.
>>>> If I understand this correctly, the offset of the doorbell in the BO is
>>>> still is 32-bit, but its width (size in bytes) is 64 bits. Am I getting
>>>> that right ?
>>> Right.  Each doorbell is 64 bits (8 bytes) so this value would
>>> basically be an index into the doorbell bo.  Having it be a 64 bit
>>> index rather than a 32 bit index would avoid the possibility of users
>>> specifying overlapping doorbells.  E.g.,
>>> offset in bytes
>>> 0 - doorbell
>>> 4 - doorbell
>>> Would be incorrect, while
>>> offset in bytes
>>> 0 - doorbell
>>> 8 - doorbell
>>> Would be correct.
>>>
>>> I.e., u64 doorbell_page[512] vs u32 doorbell_page[1024]
>> Well I usually prefer just straight byte offsets, but I think the main
>> question is what does the underlying hw/fw use?
>>
>> If that's a dword index we should probably stick with that in the UAPI
>> as well. If it's in qword then stick to that, if it's in bytes than use
>> that.
> The MQD takes a dword offset from the start of the BAR, but the
> doorbell is 64 bits wide so we have to be careful that we check for
> overlapping doorbells.

Well then let's just add an "if (doorbell_idx & 0x1) return -EINVAL;" to 
the kernel instead.

That's far less confusing that having dword in the MQD and qword in the 
UAPI.

Christian.

>
> Alex
>
>> Otherwise we will just confuse people when we convert between the
>> different API levels.
>>
>> Christian.
>>
>>> Alex
>>>
>>>> - Shashank
>>>>
>>>>> Christian.
>>>>>
>>>>>> Alex
>>>>>>
>>>>>>> Christian.
>>>>>>>
>>>>>>>> Alex
>>>>>>>>
>>>>>>>>>>> +       /** GPU virtual address of the queue */
>>>>>>>>>>> +       __u64   queue_va;
>>>>>>>>>>> +       /** Size of the queue in bytes */
>>>>>>>>>>> +       __u64   queue_size;
>>>>>>>>>>> +       /** GPU virtual address of the rptr */
>>>>>>>>>>> +       __u64   rptr_va;
>>>>>>>>>>> +       /** GPU virtual address of the wptr */
>>>>>>>>>>> +       __u64   wptr_va;
>>>>>>>>>>> +};
>>>>>>>>>>> +
>>>>>>>>>>> +struct drm_amdgpu_userq_in {
>>>>>>>>>>> +       /** AMDGPU_USERQ_OP_* */
>>>>>>>>>>> +       __u32   op;
>>>>>>>>>>> +       /** Flags */
>>>>>>>>>>> +       __u32   flags;
>>>>>>>>>>> +       /** Queue handle to associate the queue free call with,
>>>>>>>>>>> +        * unused for queue create calls */
>>>>>>>>>>> +       __u32   queue_id;
>>>>>>>>>>> +       __u32   pad;
>>>>>>>>>>> +       /** Queue descriptor */
>>>>>>>>>>> +       struct drm_amdgpu_userq_mqd mqd;
>>>>>>>>>>> +};
>>>>>>>>>>> +
>>>>>>>>>>> +struct drm_amdgpu_userq_out {
>>>>>>>>>>> +       /** Queue handle */
>>>>>>>>>>> +       __u32   q_id;
>>>>>>>>>> Maybe this should be queue_id to match the input.
>>>>>>>>> Agree.
>>>>>>>>>
>>>>>>>>> - Shashank
>>>>>>>>>
>>>>>>>>>> Alex
>>>>>>>>>>
>>>>>>>>>>> +       /** Flags */
>>>>>>>>>>> +       __u32   flags;
>>>>>>>>>>> +};
>>>>>>>>>>> +
>>>>>>>>>>> +union drm_amdgpu_userq {
>>>>>>>>>>> +       struct drm_amdgpu_userq_in in;
>>>>>>>>>>> +       struct drm_amdgpu_userq_out out;
>>>>>>>>>>> +};
>>>>>>>>>>> +
>>>>>>>>>>>       /* vm ioctl */
>>>>>>>>>>>       #define AMDGPU_VM_OP_RESERVE_VMID      1
>>>>>>>>>>>       #define AMDGPU_VM_OP_UNRESERVE_VMID    2
>>>>>>>>>>> --
>>>>>>>>>>> 2.34.1
>>>>>>>>>>>

