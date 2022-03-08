Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD983C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 18:53:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8917410E2F0;
	Tue,  8 Mar 2022 18:53:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9448110E2EE
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 18:53:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdg3VHWWfjH+8NxVxkisgtErcufbuFJ9EU9g0ZG7OnTGOBv2C6m3dKi8KpPghQOWMjTttKlNx0uFNe/tG14GADrrtOIYl+ZECDVjJV41cXhijOoCPJQlT7szNOigjtU54gqBg4OY4D2dMsKE4deMrr+/h5qHBwYc6QQ17cRggnq0IMLsfJri/XGQNGZfNZXmDC5jEAsoSwXgJJuMk2DrA0vrkHqYfKEXTGMLyU57ZvFndRDyu1FqfKbJk2qi0P2r2TAwIxAtNM8zO5FK81mucKeIt3DAkZozX0OdADKl1+HlM7AZVC9YmbsKU8sj9HFdeqAwqvvsket0gc3OEFP91g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95/Vo+KtHuzmSQITFCmOFj/DqG/LoYDWv6+xeycAEvA=;
 b=Ldw+c0wN0a0fqS0wVVzCl2i1wCtCJinRFT5ozmcP0qUrcBdMSnprd4OeJ3NT0nARja2OpLrOD6EioppQLtLjV6MwcbV0yhaICEACLbglNv1hXr49/sKqfzCFqN3RzXD+DywLPIj1/zndpPg8bP3nX1z2aAex5nRH/H6QNzSrpikYodHhynK3KfsER4hK66uZMmobarG0ZS5KQFnQFmPoVvZau8zVleaLEd+bzcvlZPgsvgqLjvfJTU7y0ArVxzaHHJlo7So7yemJ/bVqQEYF1YaQ7h3DHB1AD7S/q4aP9b2mhyLOPfZKeuld9scF8daYWzccChws3ealWVjzQzKiug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95/Vo+KtHuzmSQITFCmOFj/DqG/LoYDWv6+xeycAEvA=;
 b=LXDL/3eFLlrZ2uchBGXSSmN3DddjlF6ED3g2MdeXIYjoOkZosOoBgXbRPsFpvhfXKyAgeeLkkXTLrKUTknk7URM5XVOaO32FLVbJdqLMXz9DcrD0jmaOOUSYvqq+tNk1UZKVTgJSkOORefCAaFMWm4pAEEawrSr+iOFOYTAO+RQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by MWHPR12MB1392.namprd12.prod.outlook.com (2603:10b6:300:14::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 18:53:44 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 18:53:43 +0000
Content-Type: multipart/alternative;
 boundary="------------M3CAahUthySlHkLDSM75veeB"
Message-ID: <b857cc9e-a615-bc19-61f7-226df46581f6@amd.com>
Date: Tue, 8 Mar 2022 13:53:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdgpu: add work function for GPU reset event
Content-Language: en-US
To: "Somalapuram, Amaranath" <asomalap@amd.com>,
 "Sharma, Shashank" <shashank.sharma@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
 <20220307162631.2496286-2-contactshashanksharma@gmail.com>
 <9de42884-d1e2-309a-e669-5132539fbd22@amd.com>
 <bc293ab7-db45-2b16-aeb8-291cffef8ba4@amd.com>
 <abf6d329-6a3f-26f0-1d5b-75b3ff55acfd@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <abf6d329-6a3f-26f0-1d5b-75b3ff55acfd@amd.com>
X-ClientProxiedBy: YT2PR01CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::21) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 160e913a-7237-4871-b587-08da0134f7e8
X-MS-TrafficTypeDiagnostic: MWHPR12MB1392:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1392D4FFD69319A7FF752DFCEA099@MWHPR12MB1392.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X6gCqGCQzf3GuVylLzOfwbFuT6gCK7T5tcPbWsqGAakWqhX2WOD+tbzZSonj6/SpXXJ8UQfKhOOUVB/A+E3647hlSTAXpcDooPFMi3CvZzWOe8L2TJwSI8ImznGRw2VunvmDv9y4MXgJQHj+FY2fhQcBcGPX7iokK5Zb0ZUM7O+pvM2wzCPuxXPJp0bytpZfQ8CQ744Ab9PRNPxlBahkxCmqm2qdqrM408t+RVRVmJCle9omCighKGEoupAP4Z70drWnHV+oC6TiVWW4VO06vfBnJonQMrC9c+RJIA4ghMgMHO81bI3cCiIdFA052GZVEJxfVPFgMbojIGOsbzAYHkuVf02S3DR9XiRWxW0+trquVt4dRhB7+gGvgLFk9KEgn/6nP17LdcL6KffC5Qve5gvk8c4XFYHXTpGk/eSzim3/0FLX9ZADB7DdSbEuN6tlb8HvGZrrOdPualB+/d+s4D0/pib1byCaRolRmT1D2vfBWM82jlHvxiILpiEr37z306KvhNwatDneZ4r0uyW04WvxS6xd0YgQyokB77gd9rII4ujCBMdVIJ2AHkL0ULRH9fhnJJxrOMNj0FCVdegp+rG1LpYd2+NEzXRXCMAmXuVgwzxlb6l7+FR2l6Hs7TWQf9rvAMvid1tC0Ijb9MzKqECAa2k7vrloq7RHgcm7O5oYe/iHY5kZY8ko4gZX5afW8DAqh63ubO3nEfA4d42XYTDpeknyJ6VVPG4+VWVgSeQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(508600001)(6486002)(31686004)(54906003)(316002)(86362001)(31696002)(83380400001)(186003)(36756003)(8676002)(4326008)(38100700002)(8936002)(5660300002)(2906002)(66556008)(66476007)(66946007)(6506007)(6512007)(2616005)(44832011)(33964004)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEVOTWNvRG8xa1Y1dSsvV01Hb2tNeU9PdHRKWXpZYkxGUlFVd3U3ZlY4WVZq?=
 =?utf-8?B?cmpZSzRnVHprSjRrRExiQXVsWWxHQ3plK3RkektxaThhZFhLbWdWcjJaWEJS?=
 =?utf-8?B?T2hrVURTSTZ4SjV2RkhkT3VLZGlmdGZUSlUvemE4cjc1cnVZS0dnQlpoZ0VJ?=
 =?utf-8?B?STZzam5tSWNBK0lWeWNEM09JU2tZZDNGeTlGcnFjd1BtZE1QT0dqM2dXbnIv?=
 =?utf-8?B?V3h6eTc2UzVhT2J0RTh6b092elA3WjgyQXZZSnRjc2Q5MFZJbDlDRWRWYWtn?=
 =?utf-8?B?UXduaUVaS29mQTVBKy9Bc0xmbm5EOGZEYlhicWFMTFpjWjBsQzAzN1F4Mzha?=
 =?utf-8?B?L3dNdU9LaE9takx5eE1oOWFieUhTK2g1ZHVaekxMS1JZYVJ2aEl6N2hPVjY3?=
 =?utf-8?B?enFPbjZISG5ZWEpLcm1PWk5RdHloSVQrSXFIYnMvTDRVbmgrN2FpZk5teElT?=
 =?utf-8?B?OTFJNlhFQjR3OGRYNENIMDZRNjV3Y3J4M25aMTdscnZoWHA3anNFem1sOXNj?=
 =?utf-8?B?K3ArVUgvby94Y2RiYmRQYVdqN0ltaXV3LzlWbHN2V2tpQjUyQTF3OXBrRkE1?=
 =?utf-8?B?MURCRi80ZEJUaitMMjdwRE9iWkp0ZVNmaGUvVCtIYXlaTXhSdUpwVkpxb2JU?=
 =?utf-8?B?Ym1ZRytmd1dVUmhKL2VoRGtaRTNYaTFCcTNrVDk4cjBQTEZIVWRxZU9mZ1FJ?=
 =?utf-8?B?bENybllXSXBRMXVKMlVyQkpxSk1HMWoyWDVIOXJaUmlYa0c1R21VREtoSWll?=
 =?utf-8?B?TmxudHJacFJxZFYyeURCTG5qZ2tHQWs1d0Y0dkZVOHEreWREbHVUSllYZ2tF?=
 =?utf-8?B?empHcmlNSTJjU0FUV1MwUnpsMTRQSWlCV2dCS2xpMUVodzJibkl5QmRsOWVM?=
 =?utf-8?B?aEtKRkFlYXpNWndsMWVVcWVUaXhhR0ZCdzR4S2l5YXcvKzM2NU8zSHdnTXh6?=
 =?utf-8?B?ek9aZ2xvTndCUnV3TmpScERkY1RTVHFPbzRRVC91QzlzTW9MWlAxa2hhTTU1?=
 =?utf-8?B?UWhvK0FBMXdMTGJJNC9xais3RHEwai85UFJTellQMkowbG5PVHNFT3R4Y29V?=
 =?utf-8?B?Q2xBVmM5SllKcEg2TFAzeUNSUS81OUVMTVU3REtVdFh4R0ozbGZDMGFRWEhK?=
 =?utf-8?B?K0d1Q1pkdnQrUzFTbCtkMkptOUJNYUtRZSs4TnlNanRjb3dieVdmMTZHWXUy?=
 =?utf-8?B?OTdUR3FIQjlZcGZsM0xCYTJPb1JoNjRSaWN5MHJzT3lnUVY1S0JpOWlLU1d3?=
 =?utf-8?B?V3MvOFNvWGtxL3R2T2NMSFFNTGxVNjJEOExFcGZoN3p0dTFoa1FrN0tPQURQ?=
 =?utf-8?B?cmRoMzFhMk41Smd2cVNrVlAvcEswM3VPZkpQVXVJVk54a0xoS3VEd29WMkxD?=
 =?utf-8?B?WnFjdFZYSU9YMlBUQWwzYkVsRTRqQnNWSlRrUUpicEpqTTBoYTJia1RlNXkr?=
 =?utf-8?B?SjV6ek1OVGlWZzdaRXZmdUpnRXNaK3VaK2dGTGQyK0NMMnY3UlBGbHdUUjJ6?=
 =?utf-8?B?UE9LTThkUmVMYmRxeXQ4MkczSVNjQjR0YUcvdDNwbFo4RmNUc3pPb3pUbkUy?=
 =?utf-8?B?dkFUMy9iaHBteVYvOExjZ1d0VlFiVXY5K3lVaGtTTW4vMFhEZ1pEZmprZnZk?=
 =?utf-8?B?dllQMTlIVlVvbzRkNXVuNE5rOFczblR0ako3eGltWnVKQng3TDh6QTdYb3lE?=
 =?utf-8?B?VUptcHlVOGxiUllSYjArdEpvYUNhUEZlaXNkcHQ1RDY5Qm85YVkrZXVpZUYz?=
 =?utf-8?B?M1ZIWE8zT3RvSHgvQUo0RVpPaW4zUkZ2eC9HTEYwV0I1YjFkUWU5b3VSWm5Y?=
 =?utf-8?B?VUhXcEdmQmlTL2hLQWkrUkUxM1FkZ1g0RHJnb1Z3RkJodE5KTFY2R3FwVjJx?=
 =?utf-8?B?MXoxejNsZ3JoWEZRWnB0MzNYMis3Q0NEVjN6Z3lncFUvR0RidXRWQVpJYjAv?=
 =?utf-8?B?emR0akhyZVdvaHV2RkVjYUZKakRXcFRtVXRqenU5bTh5S0JlaWs5cFBoYkd1?=
 =?utf-8?B?OWVGNXZnNE81UVllUUwrUzFwS21EK0kyLzdNL1JlY1ovZ3FpMkFXOFI4WS9Q?=
 =?utf-8?B?OUZuaHE1Z2Z5aTJBd2JuRjF5OXNjQlI3Wkt1cS9XMHpaREdwTURmVXM3OUpY?=
 =?utf-8?B?L083Q0dQMDd3T1BlcGhjbEpmSWZXRllENnpKNkl5WXR2RllFWXdQZlZMd2NH?=
 =?utf-8?B?N2ZkRS9JTm5SeDliSkFSd21JbDFHYWIvMG54MVgzQkd6MWJaNHNHd1FuZVpO?=
 =?utf-8?Q?h0FGxymRsp11IE2w49jRC5VPIheqfjQwBXqNBOmt08=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 160e913a-7237-4871-b587-08da0134f7e8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 18:53:43.7527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjLayw9TkpTFaITZ1zrACBmmpkd+9txjlWbuRgaxlBLtCMMdHUmvO1pK3HpoVsCUFCfvJLRFFoGxmG4l9sXUYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1392
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
Cc: Alexander Deucher <alexander.deucher@amd.com>,
 amaranath.somalapuram@amd.com, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------M3CAahUthySlHkLDSM75veeB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2022-03-08 12:20, Somalapuram, Amaranath wrote:
>
>
> On 3/8/2022 10:00 PM, Sharma, Shashank wrote:
>> Hello Andrey
>>
>> On 3/8/2022 5:26 PM, Andrey Grodzovsky wrote:
>>>
>>> On 2022-03-07 11:26, Shashank Sharma wrote:
>>>> From: Shashank Sharma <shashank.sharma@amd.com>
>>>>
>>>> This patch adds a work function, which will get scheduled
>>>> in event of a GPU reset, and will send a uevent to user with
>>>> some reset context infomration, like a PID and some flags.
>>>
>>>
>>> Where is the actual scheduling of the work function ? Shouldn't
>>> there be a patch for that too ?
>>>
>>
>> Yes, Amar is working on that patch, on top of these patches. They 
>> should be out soon. I thought it was a good idea to get quick 
>> feedback on the basic patches before we build something on top of it.
>>
> schedule_work() will be called in the function amdgpu_do_asic_reset ()
>

I didn't follow closely on the requirements and so I don't know but, 
what about
job timeout that was able to soft recover - do you need to cover this 
too ? Or
in this case no need to restart user application and you hence don't care ?

Andrey


> after getting vram_lost info:
>
> vram_lost = amdgpu_device_check_vram_lost(tmp_adev);
>
> update  amdgpu_reset_event_ctx and call schedule_work()
>
>   * vram_lost
>   * reset_context->job->vm->task_info.process_name
>   * reset_context->job->vm->task_info.pid
>
> Regards,
> S.Amarnath
>> - Shashank
>>
>>> Andrey
>>>
>>>
>>>>
>>>> The userspace can do some recovery and post-processing work
>>>> based on this event.
>>>>
>>>> V2:
>>>> - Changed the name of the work to gpu_reset_event_work
>>>>    (Christian)
>>>> - Added a structure to accommodate some additional information
>>>>    (like a PID and some flags)
>>>>
>>>> Cc: Alexander Deucher <alexander.deucher@amd.com>
>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  7 +++++++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 +++++++++++++++++++
>>>>   2 files changed, 26 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index d8b854fcbffa..7df219fe363f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -813,6 +813,11 @@ struct amd_powerplay {
>>>>   #define AMDGPU_RESET_MAGIC_NUM 64
>>>>   #define AMDGPU_MAX_DF_PERFMONS 4
>>>>   #define AMDGPU_PRODUCT_NAME_LEN 64
>>>> +struct amdgpu_reset_event_ctx {
>>>> +    uint64_t pid;
>>>> +    uint32_t flags;
>>>> +};
>>>> +
>>>>   struct amdgpu_device {
>>>>       struct device            *dev;
>>>>       struct pci_dev            *pdev;
>>>> @@ -1063,6 +1068,7 @@ struct amdgpu_device {
>>>>       int asic_reset_res;
>>>>       struct work_struct        xgmi_reset_work;
>>>> +    struct work_struct        gpu_reset_event_work;
>>>>       struct list_head        reset_list;
>>>>       long                gfx_timeout;
>>>> @@ -1097,6 +1103,7 @@ struct amdgpu_device {
>>>>       pci_channel_state_t        pci_channel_state;
>>>>       struct amdgpu_reset_control     *reset_cntl;
>>>> +    struct amdgpu_reset_event_ctx   reset_event_ctx;
>>>>       uint32_t ip_versions[MAX_HWIP][HWIP_MAX_INSTANCE];
>>>>       bool                ram_is_direct_mapped;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index ed077de426d9..c43d099da06d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -73,6 +73,7 @@
>>>>   #include <linux/pm_runtime.h>
>>>>   #include <drm/drm_drv.h>
>>>> +#include <drm/drm_sysfs.h>
>>>>   MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
>>>>   MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
>>>> @@ -3277,6 +3278,23 @@ bool amdgpu_device_has_dc_support(struct 
>>>> amdgpu_device *adev)
>>>>       return amdgpu_device_asic_has_dc_support(adev->asic_type);
>>>>   }
>>>> +static void amdgpu_device_reset_event_func(struct work_struct 
>>>> *__work)
>>>> +{
>>>> +    struct amdgpu_device *adev = container_of(__work, struct 
>>>> amdgpu_device,
>>>> +                          gpu_reset_event_work);
>>>> +    struct amdgpu_reset_event_ctx *event_ctx = 
>>>> &adev->reset_event_ctx;
>>>> +
>>>> +    /*
>>>> +     * A GPU reset has happened, indicate the userspace and pass the
>>>> +     * following information:
>>>> +     *    - pid of the process involved,
>>>> +     *    - if the VRAM is valid or not,
>>>> +     *    - indicate that userspace may want to collect the ftrace 
>>>> event
>>>> +     * data from the trace event.
>>>> +     */
>>>> +    drm_sysfs_reset_event(&adev->ddev, event_ctx->pid, 
>>>> event_ctx->flags);
>>>> +}
>>>> +
>>>>   static void amdgpu_device_xgmi_reset_func(struct work_struct 
>>>> *__work)
>>>>   {
>>>>       struct amdgpu_device *adev =
>>>> @@ -3525,6 +3543,7 @@ int amdgpu_device_init(struct amdgpu_device 
>>>> *adev,
>>>>                 amdgpu_device_delay_enable_gfx_off);
>>>>       INIT_WORK(&adev->xgmi_reset_work, 
>>>> amdgpu_device_xgmi_reset_func);
>>>> +    INIT_WORK(&adev->gpu_reset_event_work, 
>>>> amdgpu_device_reset_event_func);
>>>>       adev->gfx.gfx_off_req_count = 1;
>>>>       adev->pm.ac_power = power_supply_is_system_supplied() > 0;
--------------M3CAahUthySlHkLDSM75veeB
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-03-08 12:20, Somalapuram,
      Amaranath wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:abf6d329-6a3f-26f0-1d5b-75b3ff55acfd@amd.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 3/8/2022 10:00 PM, Sharma,
        Shashank wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:bc293ab7-db45-2b16-aeb8-291cffef8ba4@amd.com">Hello
        Andrey <br>
        <br>
        On 3/8/2022 5:26 PM, Andrey Grodzovsky wrote: <br>
        <blockquote type="cite"> <br>
          On 2022-03-07 11:26, Shashank Sharma wrote: <br>
          <blockquote type="cite">From: Shashank Sharma <a class="moz-txt-link-rfc2396E" href="mailto:shashank.sharma@amd.com" moz-do-not-send="true">&lt;shashank.sharma@amd.com&gt;</a>
            <br>
            <br>
            This patch adds a work function, which will get scheduled <br>
            in event of a GPU reset, and will send a uevent to user with
            <br>
            some reset context infomration, like a PID and some flags. <br>
          </blockquote>
          <br>
          <br>
          Where is the actual scheduling of the work function ?
          Shouldn't <br>
          there be a patch for that too ? <br>
          <br>
        </blockquote>
        <br>
        Yes, Amar is working on that patch, on top of these patches.
        They should be out soon. I thought it was a good idea to get
        quick feedback on the basic patches before we build something on
        top of it. <br>
        <br>
      </blockquote>
      <p>schedule_work() will be called in the function
        amdgpu_do_asic_reset () <br>
      </p>
    </blockquote>
    <p><br>
    </p>
    <p>I didn't follow closely on the requirements and so I don't know
      but, what about<br>
      job timeout that was able to soft recover - do you need to cover
      this too ? Or<br>
      in this case no need to restart user application and you hence
      don't care ?</p>
    <p>Andrey</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:abf6d329-6a3f-26f0-1d5b-75b3ff55acfd@amd.com">
      <p> </p>
      <p>after getting vram_lost info:<br>
      </p>
      <p>vram_lost = amdgpu_device_check_vram_lost(tmp_adev);</p>
      <p>update&nbsp; amdgpu_reset_event_ctx and call schedule_work()</p>
      <ul>
        <li>vram_lost</li>
        <li>reset_context-&gt;job-&gt;vm-&gt;task_info.process_name</li>
        <li>reset_context-&gt;job-&gt;vm-&gt;task_info.pid</li>
      </ul>
      Regards,<br>
      S.Amarnath<br>
      <blockquote type="cite" cite="mid:bc293ab7-db45-2b16-aeb8-291cffef8ba4@amd.com">-
        Shashank <br>
        <br>
        <blockquote type="cite">Andrey <br>
          <br>
          <br>
          <blockquote type="cite"> <br>
            The userspace can do some recovery and post-processing work
            <br>
            based on this event. <br>
            <br>
            V2: <br>
            - Changed the name of the work to gpu_reset_event_work <br>
            &nbsp;&nbsp; (Christian) <br>
            - Added a structure to accommodate some additional
            information <br>
            &nbsp;&nbsp; (like a PID and some flags) <br>
            <br>
            Cc: Alexander Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com" moz-do-not-send="true">&lt;alexander.deucher@amd.com&gt;</a>
            <br>
            Cc: Christian Koenig <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com" moz-do-not-send="true">&lt;christian.koenig@amd.com&gt;</a>
            <br>
            Signed-off-by: Shashank Sharma <a class="moz-txt-link-rfc2396E" href="mailto:shashank.sharma@amd.com" moz-do-not-send="true">&lt;shashank.sharma@amd.com&gt;</a>
            <br>
            --- <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 7 +++++++ <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19
            +++++++++++++++++++ <br>
            &nbsp; 2 files changed, 26 insertions(+) <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
            b/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
            index d8b854fcbffa..7df219fe363f 100644 <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
            @@ -813,6 +813,11 @@ struct amd_powerplay { <br>
            &nbsp; #define AMDGPU_RESET_MAGIC_NUM 64 <br>
            &nbsp; #define AMDGPU_MAX_DF_PERFMONS 4 <br>
            &nbsp; #define AMDGPU_PRODUCT_NAME_LEN 64 <br>
            +struct amdgpu_reset_event_ctx { <br>
            +&nbsp;&nbsp;&nbsp; uint64_t pid; <br>
            +&nbsp;&nbsp;&nbsp; uint32_t flags; <br>
            +}; <br>
            + <br>
            &nbsp; struct amdgpu_device { <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *dev; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pci_dev&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *pdev; <br>
            @@ -1063,6 +1068,7 @@ struct amdgpu_device { <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int asic_reset_res; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct work_struct&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xgmi_reset_work; <br>
            +&nbsp;&nbsp;&nbsp; struct work_struct&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_reset_event_work; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_list; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_timeout; <br>
            @@ -1097,6 +1103,7 @@ struct amdgpu_device { <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_channel_state_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_channel_state; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_control&nbsp;&nbsp;&nbsp;&nbsp; *reset_cntl; <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_reset_event_ctx&nbsp;&nbsp; reset_event_ctx; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            ip_versions[MAX_HWIP][HWIP_MAX_INSTANCE]; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_is_direct_mapped; <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c <br>
            index ed077de426d9..c43d099da06d 100644 <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c <br>
            @@ -73,6 +73,7 @@ <br>
            &nbsp; #include &lt;linux/pm_runtime.h&gt; <br>
            &nbsp; #include &lt;drm/drm_drv.h&gt; <br>
            +#include &lt;drm/drm_sysfs.h&gt; <br>
            &nbsp; MODULE_FIRMWARE(&quot;amdgpu/vega10_gpu_info.bin&quot;); <br>
            &nbsp; MODULE_FIRMWARE(&quot;amdgpu/vega12_gpu_info.bin&quot;); <br>
            @@ -3277,6 +3278,23 @@ bool
            amdgpu_device_has_dc_support(struct amdgpu_device *adev) <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return
            amdgpu_device_asic_has_dc_support(adev-&gt;asic_type); <br>
            &nbsp; } <br>
            +static void amdgpu_device_reset_event_func(struct
            work_struct *__work) <br>
            +{ <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = container_of(__work,
            struct amdgpu_device, <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_reset_event_work); <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_reset_event_ctx *event_ctx =
            &amp;adev-&gt;reset_event_ctx; <br>
            + <br>
            +&nbsp;&nbsp;&nbsp; /* <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; * A GPU reset has happened, indicate the userspace and
            pass the <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; * following information: <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;&nbsp; - pid of the process involved, <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;&nbsp; - if the VRAM is valid or not, <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;&nbsp; - indicate that userspace may want to collect the
            ftrace event <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; * data from the trace event. <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; */ <br>
            +&nbsp;&nbsp;&nbsp; drm_sysfs_reset_event(&amp;adev-&gt;ddev,
            event_ctx-&gt;pid, event_ctx-&gt;flags); <br>
            +} <br>
            + <br>
            &nbsp; static void amdgpu_device_xgmi_reset_func(struct
            work_struct *__work) <br>
            &nbsp; { <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = <br>
            @@ -3525,6 +3543,7 @@ int amdgpu_device_init(struct
            amdgpu_device *adev, <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_delay_enable_gfx_off); <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_WORK(&amp;adev-&gt;xgmi_reset_work,
            amdgpu_device_xgmi_reset_func); <br>
            +&nbsp;&nbsp;&nbsp; INIT_WORK(&amp;adev-&gt;gpu_reset_event_work,
            amdgpu_device_reset_event_func); <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.gfx_off_req_count = 1; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.ac_power =
            power_supply_is_system_supplied() &gt; 0; <br>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------M3CAahUthySlHkLDSM75veeB--
