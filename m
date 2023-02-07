Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB61C636D4
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 16:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3E5310E563;
	Tue,  7 Feb 2023 16:37:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF13410E563
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 16:37:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqTA3pq4NUSJTbIFN4Gy5ucseSfmAwtUrJpfzcvsg6mCNlK+Rw2bNTNz5ETsZQrgbFKYO14MIsZGjOdotL46xQhOAfKHZLzy1WUn+zbQUumcDmLa9AIRHYYdDVKXAT2oVTjaCsH3jy6QIXLfMky5bkOg+SeZhk9HaMSW67gG3Irc7tobRfhSMV1A0Iuea726EVthrBtcoY3S2KEnX7V9695O/J43igXy9bSUGPD5I/KIL44Z9opT4hFbeh6hNSY9uHONgynCAheUFiXrfQppy73VUaXs1HQvv5Rt/IUHMZPKkt4mYXCTvw0UwE3uKrCbvxzBd8lQem6AvOWgBLvWMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pc5PlB152l9+7rlw1XdtCmk7k5LDfRlMEQk/GVvcJKc=;
 b=Nq0vmBx0Q6Va0bDc/rnxjB2xz80y+IBe/DBpbOe+/pcsbIJE0bucNZW8Px7LPzr7jYhWkCRkF1sCrn4q85uhNkc+dJo6vWb1rIUfPLWWEUqcmFSuLTdPj9GTY5p/BZ71w7DCmw2o1TNs4CXH6JhOJyl2RURZBgLVYNGPIkkTcXS4JvOU6dm+++SZ5pR8G2k3SVVu5bPYCyZY68L2yQV1luJgsD1Pad908zqsLCWxAklceGydsNSZvXmMcKqSMlpUc6iS63E1fCM6/mdMH0x6BFdpuaw2f0oY5A6pCipnH3IF9TAxRSiM4jJ+qgTxEoSrYHXAB67fF8mSR072h+9ytQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pc5PlB152l9+7rlw1XdtCmk7k5LDfRlMEQk/GVvcJKc=;
 b=yuW7TIIQFRtTJqzYptbtrf7DIO9I6XmNhoiLqwmiJSVjkKmMGpW62621Jc9YSpqq+fYGleTJN/HQBIZhJ7CMZIEh20zCWiOHoz5kQ6IeqO38EndbDSIkY+bBq2KJq5LPHYkznpVkx1xVJ49gQvHY/3cpesry9glWsulW3BQbjos=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DS0PR12MB7653.namprd12.prod.outlook.com (2603:10b6:8:13e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 16:37:43 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f%4]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 16:37:42 +0000
Message-ID: <48c0d13f-7ccc-1f05-2a0a-e20bdb1e1fb5@amd.com>
Date: Tue, 7 Feb 2023 17:37:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/8] drm/amdgpu: Add V11 graphics MQD functions
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <20230203215409.2021-5-shashank.sharma@amd.com>
 <CADnq5_M8wnDZUEvDVA_CdyE0sxgg0FragSbO19LjhRE_XMJ-OA@mail.gmail.com>
 <d6e62077-7c6e-1fb4-8abe-275ccdf72003@amd.com>
 <CADnq5_OGOeFLnJyspTYvoOyKv1E=3Tp6uUweCF_JYFRFftuphw@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_OGOeFLnJyspTYvoOyKv1E=3Tp6uUweCF_JYFRFftuphw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::8) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DS0PR12MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: 295439e7-53dc-4766-6978-08db0929a245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gPu9ZOH9dfoXC0ZQVKcJiUqRVeOLRXfQpHlNOLPrg50qMHmqkhnQH7Y7SYJoVc8xq6In2M1wkavB4fiyN4Zi69BbqliEWTM3wUhT6YT83l5Y7B87VjTpgqrqrv2X3KcNesLTDuhDAilEQ8wNmbo39StqJ1d38S+uHAC7T28DaTFZ6cDNV8klXhUbdeBQAa/BmrgoW/JeMvLmTOOI+8l4oxVdoOzWZcIsoDbvgqYiqiFKD36LTGJUH2x+yIq1sL2khFvPYhH0k+pDudIIVeC2alotkQ13+0F1sL10YBg39BdCs3LeOYSGvayW9r98Rztg+Uk+SFkn1qeOxjX4nWoW90cINobAeoZm9/EJ+ZDLNaT59gVbwI6Fbwga6tgfhZEqowUlYRvUDrmaEFQwmPnCtSDogRCQpGWrg6p+dApLJAdRgr7cObzjHUSwrnh6qCvAHk4w0U1ojHv5fkbaNhMfywhQuRhHJtfXUWBnLWZkF1XuAz0BkYAuoGwfv29TzqHIb5MdkbfXYUHgbyc5h56/L2lLHbu33hGFN9OADh8jJu8WqpT2U+Rz78AHDJybUQ+ecuibIo5WGPD2T1Ds5iysYKvxjAuVOC9g3LqItEC6EHq9w33syiaTuT3VEN0wZGU0/H1mwjGIwa3/YqEQsplzNXAZxvNQ5Vxkc27f+/FjTheEDAede4vApTP/Jj5hb8fg/nrCgcBoGE8yktHruKIFKZvQocECUtqhewM2QfGPXck=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199018)(66899018)(31686004)(2906002)(4326008)(66556008)(38100700002)(86362001)(41300700001)(186003)(36756003)(44832011)(5660300002)(2616005)(6512007)(30864003)(53546011)(6666004)(6506007)(26005)(31696002)(478600001)(83380400001)(6486002)(8936002)(66946007)(66476007)(8676002)(54906003)(316002)(6916009)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THdLMHA1TFRzQXI2RTF0bkNIcWlvZWtkYTZMRkVheVhsMllHWE9VWElKTkFr?=
 =?utf-8?B?UUorbHNvSmdzWWJ2MlZBc2ZBMSszTmROODFLTUpWVFB1NS9iMjJHQTN6RzJj?=
 =?utf-8?B?ZytBcHVsQ3FrYU5HVWdoZE5YMXlKSk9oY0M3R003ZFhFbFpkd2owc1ZUeWs5?=
 =?utf-8?B?b3dJb3BjeElHeWF3a0pvek1jMEpUUnAzdFhrb3ZMV3dGRzFnWUlVLzhTTUNS?=
 =?utf-8?B?d2F1ZHlyRFZobEtualdLd05yV2JSQUJna0hjMVZJU2dVUkZUU0l6SVdDMXYv?=
 =?utf-8?B?QUhzMlFLWTdkTHdNUXJwOWd6NzB2OUtPVDJHY293WTBCeUFHbHpxdklIN25o?=
 =?utf-8?B?OTBzL0hZTWpabmJMdVBCcXRscHdhZU1uOHIwMytoT1Y1c0FPLzJSeExDU25j?=
 =?utf-8?B?N1A4RzBjY3BpUENnN05IdlNEMHlNN0JjVTUxc2NyMWlqZGoybDFhSmFXbmJo?=
 =?utf-8?B?OTRLTmxJa0Npc0lIVzdQT2YvUTlraUNQRVZ1d3hvRklPbm9QZWM3c210TktM?=
 =?utf-8?B?eVNzVklMMEVDZ3VRdlk0N2lQZU5qN1FsUnlBR0dZMDI3U2RrL3dXMk1KaGZi?=
 =?utf-8?B?S0pxc2owblV6bVpycThkZjF1RnA1emYzRGU3SlNYUXo3UUlBZlVtSDd0V0Z1?=
 =?utf-8?B?Vm10QllwOVREQ0lRTlNhUnprWWZlUEVJcStmUXI3VG1KYnRBZmxuMGNFdXdS?=
 =?utf-8?B?RlpOMHVLUHhjVTdCMUlCcXJRMzE3SkpPVXF3VEYrRlY5YzE0RkwyMzFKYkVC?=
 =?utf-8?B?N09IRE5UMXUrd1d5YWdvay96VDJ0aXpXOGN4cTEwTVFYUm9abEtLczlUVXJj?=
 =?utf-8?B?c2FpSnVIUEpQQVJxRVlsZ3BVYW5IR0k1TTBUeUYvNjBhR2RJZit5Vy84cGhJ?=
 =?utf-8?B?SFhXc0VLdElHNjBVV3VqR2ZvQk1HMHdVWkdHaGpEWiswcEhUQ3dCTjA1VUF5?=
 =?utf-8?B?ZDdzOUY3cC9aNXhkVlRZMS9XNi9mUkRvVzFvZ0dIT0M2MUY0dTAyK2RMODhh?=
 =?utf-8?B?aVkyd0lKR3lLaEpKdno1MENHVVZjYW5rZ3dyQ2UvV3pPVmhrOGs4SGh6bStC?=
 =?utf-8?B?QWFKV1E2VysySC9LZHNSVi92eXBHNWxNNTdyNDgwMFNHS2xLWUVaVGNEdGxs?=
 =?utf-8?B?czZFRlBuYWNLQng3ZmdHTGk4OCtRSVYzL2FSdmJCUkpBMi9JdjEzZlorcThw?=
 =?utf-8?B?SGxqL0hDM2daOFBIWGtMQ0docGc4Mkt2enE2M1pYdVFkTmVFdXpNSExvSTYz?=
 =?utf-8?B?SDI5elUzNGNBTlBuazJuZjlsbitzQ0phMGE4L3JZUFY4a1NLa1ZXNW1IOGNY?=
 =?utf-8?B?L01UK2E1VUVsQzdRTlBEN1NWU2dUQlcxYUtDbERrYS9pV00yYjdrUWxiQk5x?=
 =?utf-8?B?ZnJpdWdXanNOcE9sd2dLVWZGWGp4L0N5RTZiMDFXNTBJdFRwcXIyVXFVaDJS?=
 =?utf-8?B?SU5CUUk4OEg5UmpXdzBqdVdpbXRlY0cvc0V6aFUvR255SG5QSkVjSms5ZVVD?=
 =?utf-8?B?MjYxVzFMaWpadXd0cmY5TVVCK0xCVTg0TG82SW5UbU1TQkZJQTRXb1hmajZa?=
 =?utf-8?B?OUZRSGNPdXFKd1c0enBVVHl4SGg3S2pjUHR0bXVCMWlaWWpIS1hNU3hoODhv?=
 =?utf-8?B?VUFwQUVYbE9uUlc4L0hIdXZKTjUzM0RMMXQ1M0xwamMrQjVMcHc5aWxlVUhh?=
 =?utf-8?B?UVJxUUJTczExalFDeElNRENMeGtId2JweG5OQUxRWGJoTGZPYjVIaFkvQU1C?=
 =?utf-8?B?Wkw1UGdadWw4UHBybTBvRzEwYXVTbVdTcUowOVdtVVZZbFZOazB2dmdNWHhZ?=
 =?utf-8?B?SjNJcks5YWYzb3d6aHZ0a3B2bWxmRDZCUVpVT3RIa1NaRUFNTCtkRWxVNHl4?=
 =?utf-8?B?VDQwMHowVXc4RUtCQmRacm9wMzA3dXpEc1hPTWJhUEs0SWJRbngrZWhnd2Y4?=
 =?utf-8?B?WWlIaERyZjNaWTFVRUYyMmJRZE9rVFZGMFYxazZXV0t0NlJid2JVamxIQUJY?=
 =?utf-8?B?RUpTYUJhMEdJQ0VyTDhHNU9Md3oyYkd1RUxpK2FKaXozTDkwTDBiZWZsZXZ4?=
 =?utf-8?B?QzhVR3pJdUJrUTBWRi9FMFg3ZFhjUE1mR1FIYW5jM2trTS9FYkZqQ3JWNnEv?=
 =?utf-8?Q?4M916qttoacnSIM2n1kt7lK3O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 295439e7-53dc-4766-6978-08db0929a245
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 16:37:42.7430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vO1lSlv1Abv6s01rjswvLasSV7IedkCwjSgHNlu7y8V/hJ07ci5Sl2GWs5E5Z7Xqa7Y1hmJ1POqPK5e35bx5oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7653
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
Cc: alexander.deucher@amd.com, Arvind Yadav <arvind.yadav@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 07/02/2023 17:05, Alex Deucher wrote:
> On Tue, Feb 7, 2023 at 10:43 AM Shashank Sharma <shashank.sharma@amd.com> wrote:
>>
>> On 07/02/2023 16:17, Alex Deucher wrote:
>>> On Fri, Feb 3, 2023 at 4:55 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>>>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>>>
>>>> MQD describes the properies of a user queue to the HW, and allows it to
>>>> accurately configure the queue while mapping it in GPU HW. This patch
>>>> adds:
>>>> - A new header file which contains the userqueue MQD definition for
>>>>     V11 graphics engine.
>>>> - A new function which fills it with userqueue data and prepares MQD
>>>> - A function which sets-up the MQD function ptrs in the generic userqueue
>>>>     creation code.
>>>>
>>>> V1: Addressed review comments from RFC patch series
>>>>       - Reuse the existing MQD structure instead of creating a new one
>>>>       - MQD format and creation can be IP specific, keep it like that
>>>>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/Makefile           |   1 +
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  28 ++++
>>>>    .../amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c | 132 ++++++++++++++++++
>>>>    drivers/gpu/drm/amd/include/v11_structs.h     |  16 +--
>>>>    4 files changed, 169 insertions(+), 8 deletions(-)
>>>>    create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>> index 764801cc8203..6ae9d5792791 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>> @@ -212,6 +212,7 @@ amdgpu-y += amdgpu_amdkfd.o
>>>>
>>>>    # add usermode queue
>>>>    amdgpu-y += amdgpu_userqueue.o
>>>> +amdgpu-y += amdgpu_userqueue_mqd_gfx_v11.o
>>>>
>>>>    ifneq ($(CONFIG_HSA_AMD),)
>>>>    AMDKFD_PATH := ../amdkfd
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> index 625c2fe1e84a..9f3490a91776 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> @@ -202,13 +202,41 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>>>>        return r;
>>>>    }
>>>>
>>>> +extern const struct amdgpu_userq_mqd_funcs userq_gfx_v11_mqd_funcs;
>>>> +
>>>> +static int
>>>> +amdgpu_userqueue_setup_mqd_funcs(struct amdgpu_userq_mgr *uq_mgr)
>>>> +{
>>>> +    int maj;
>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>> +    uint32_t version = adev->ip_versions[GC_HWIP][0];
>>>> +
>>>> +    maj = IP_VERSION_MAJ(version);
>>>> +    if (maj == 11) {
>>>> +        uq_mgr->userq_mqd_funcs = &userq_gfx_v11_mqd_funcs;
>>>> +    } else {
>>>> +        DRM_WARN("This IP doesn't support usermode queues\n");
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>> I think it would be cleaner to just store these callbacks in adev.
>>> Maybe something like adev->user_queue_funcs[AMDGPU_HW_IP_NUM].  Then
>>> in early_init for each IP, we can register the callbacks.  When the
>>> user goes to create a new user_queue, we can check check to see if the
>>> function pointer is NULL or not for the queue type:
>>>
>>> if (!adev->user_queue_funcs[ip_type])
>>>     return -EINVAL
>>>
>>> r = adev->user_queue_funcs[ip_type]->create_queue();
>> Sounds like a good idea, we can do this.
>>
>>> Actually, there is already an mqd manager interface (adev->mqds[]).
>>> Maybe you can leverage that interface.
>> Yep, I saw that and initially even tried to work on that interface
>> itself, and then realized that it doesn't allow us to pass some
>>
>> additional parameters (like queue->vm, various BOs like proc_ctx_bo,
>> gang_ctx_bo's and so on). All of these are required in the MQD
>>
>> and we will need them to be added into MQD. I even thought of expanding
>> this structure with additional parameters, but I felt like
>>
>> it defeats the purpose of this MQD properties. But if you feel strongly
>> about that, we can work around it.
> I think it would be cleaner to just add whatever additional mqd
> properties you need to amdgpu_mqd_prop, and then you can share
> gfx_v11_0_gfx_mqd_init() and gfx_v11_0_compute_mqd_init()  for GFX and
> sdma_v6_0_mqd_init() for SDMA.  That way if we make changes to the MQD
> configuration, we only have to change one function.
>
> Alex

Noted,

We might have to add some additional fptrs for .prepare_map() and 
.prepare_unmap(). in the mqd funcs.

These are the required to prepare data for MES HW queue mapping.

- Shashank

>
>>>> +    return 0;
>>>> +}
>>>> +
>>>>    int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
>>>>    {
>>>> +    int r;
>>>> +
>>>>        mutex_init(&userq_mgr->userq_mutex);
>>>>        idr_init_base(&userq_mgr->userq_idr, 1);
>>>>        INIT_LIST_HEAD(&userq_mgr->userq_list);
>>>>        userq_mgr->adev = adev;
>>>>
>>>> +    r = amdgpu_userqueue_setup_mqd_funcs(userq_mgr);
>>>> +    if (r) {
>>>> +        DRM_ERROR("Failed to setup MQD functions for usermode queue\n");
>>>> +        return r;
>>>> +    }
>>>> +
>>>>        return 0;
>>>>    }
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
>>>> new file mode 100644
>>>> index 000000000000..57889729d635
>>>> --- /dev/null
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
>>>> @@ -0,0 +1,132 @@
>>>> +/*
>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>> + *
>>>> + * Permission is hereby granted, free of charge, to any person obtaining a
>>>> + * copy of this software and associated documentation files (the "Software"),
>>>> + * to deal in the Software without restriction, including without limitation
>>>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>>>> + * and/or sell copies of the Software, and to permit persons to whom the
>>>> + * Software is furnished to do so, subject to the following conditions:
>>>> + *
>>>> + * The above copyright notice and this permission notice shall be included in
>>>> + * all copies or substantial portions of the Software.
>>>> + *
>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>> + *
>>>> + */
>>>> +#include "amdgpu.h"
>>>> +#include "amdgpu_userqueue.h"
>>>> +#include "v11_structs.h"
>>>> +#include "amdgpu_mes.h"
>>>> +#include "gc/gc_11_0_0_offset.h"
>>>> +#include "gc/gc_11_0_0_sh_mask.h"
>>>> +
>>>> +static int
>>>> +amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>>>> +{
>>>> +    uint32_t tmp, rb_bufsz;
>>>> +    uint64_t hqd_gpu_addr, wb_gpu_addr;
>>>> +    struct v11_gfx_mqd *mqd = queue->mqd_cpu_ptr;
>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>> +
>>>> +    /* set up gfx hqd wptr */
>>>> +    mqd->cp_gfx_hqd_wptr = 0;
>>>> +    mqd->cp_gfx_hqd_wptr_hi = 0;
>>>> +
>>>> +    /* set the pointer to the MQD */
>>>> +    mqd->cp_mqd_base_addr = queue->mqd_gpu_addr & 0xfffffffc;
>>>> +    mqd->cp_mqd_base_addr_hi = upper_32_bits(queue->mqd_gpu_addr);
>>>> +
>>>> +    /* set up mqd control */
>>>> +    tmp = RREG32_SOC15(GC, 0, regCP_GFX_MQD_CONTROL);
>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, VMID, 0);
>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, PRIV_STATE, 1);
>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, CACHE_POLICY, 0);
>>>> +    mqd->cp_gfx_mqd_control = tmp;
>>>> +
>>>> +    /* set up gfx_hqd_vimd with 0x0 to indicate the ring buffer's vmid */
>>>> +    tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_VMID);
>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_VMID, VMID, 0);
>>>> +    mqd->cp_gfx_hqd_vmid = 0;
>>>> +
>>>> +    /* set up default queue priority level
>>>> +    * 0x0 = low priority, 0x1 = high priority */
>>>> +    tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_QUEUE_PRIORITY);
>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUEUE_PRIORITY, PRIORITY_LEVEL, 0);
>>>> +    mqd->cp_gfx_hqd_queue_priority = tmp;
>>>> +
>>>> +    /* set up time quantum */
>>>> +    tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_QUANTUM);
>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUANTUM, QUANTUM_EN, 1);
>>>> +    mqd->cp_gfx_hqd_quantum = tmp;
>>>> +
>>>> +    /* set up gfx hqd base. this is similar as CP_RB_BASE */
>>>> +    hqd_gpu_addr = queue->queue_gpu_addr >> 8;
>>>> +    mqd->cp_gfx_hqd_base = hqd_gpu_addr;
>>>> +    mqd->cp_gfx_hqd_base_hi = upper_32_bits(hqd_gpu_addr);
>>>> +
>>>> +    /* set up hqd_rptr_addr/_hi, similar as CP_RB_RPTR */
>>>> +    wb_gpu_addr = queue->rptr_gpu_addr;
>>>> +    mqd->cp_gfx_hqd_rptr_addr = wb_gpu_addr & 0xfffffffc;
>>>> +    mqd->cp_gfx_hqd_rptr_addr_hi =
>>>> +    upper_32_bits(wb_gpu_addr) & 0xffff;
>>>> +
>>>> +    /* set up rb_wptr_poll addr */
>>>> +    wb_gpu_addr = queue->wptr_gpu_addr;
>>>> +    mqd->cp_rb_wptr_poll_addr_lo = wb_gpu_addr & 0xfffffffc;
>>>> +    mqd->cp_rb_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr) & 0xffff;
>>>> +
>>>> +    /* set up the gfx_hqd_control, similar as CP_RB0_CNTL */
>>>> +    rb_bufsz = order_base_2(queue->queue_size / 4) - 1;
>>>> +    tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_CNTL);
>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BUFSZ, rb_bufsz);
>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BLKSZ, rb_bufsz - 2);
>>>> +#ifdef __BIG_ENDIAN
>>>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, BUF_SWAP, 1);
>>>> +#endif
>>>> +    mqd->cp_gfx_hqd_cntl = tmp;
>>>> +
>>>> +    /* set up cp_doorbell_control */
>>>> +    tmp = RREG32_SOC15(GC, 0, regCP_RB_DOORBELL_CONTROL);
>>>> +    if (queue->use_doorbell) {
>>>> +        tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
>>>> +                    DOORBELL_OFFSET, queue->doorbell_index);
>>>> +        tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
>>>> +                    DOORBELL_EN, 1);
>>>> +    } else {
>>>> +        tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
>>>> +                    DOORBELL_EN, 0);
>>>> +    }
>>>> +    mqd->cp_rb_doorbell_control = tmp;
>>>> +
>>>> +    /* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
>>>> +    mqd->cp_gfx_hqd_rptr = RREG32_SOC15(GC, 0, regCP_GFX_HQD_RPTR);
>>>> +
>>>> +    /* activate the queue */
>>>> +    mqd->cp_gfx_hqd_active = 1;
>>>> +
>>> Can you use gfx_v11_0_gfx_mqd_init() and gfx_v11_0_compute_mqd_init()
>>> directly or leverage adev->mqds[]?
>> Let us try this out and come back.
>>
>> - Shashank
>>
>>
>>> Alex
>>>
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static void
>>>> +amdgpu_userq_gfx_v11_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>>>> +{
>>>> +
>>>> +}
>>>> +
>>>> +static int amdgpu_userq_gfx_v11_mqd_size(struct amdgpu_userq_mgr *uq_mgr)
>>>> +{
>>>> +    return sizeof(struct v11_gfx_mqd);
>>>> +}
>>>> +
>>>> +const struct amdgpu_userq_mqd_funcs userq_gfx_v11_mqd_funcs = {
>>>> +    .mqd_size = amdgpu_userq_gfx_v11_mqd_size,
>>>> +    .mqd_create = amdgpu_userq_gfx_v11_mqd_create,
>>>> +    .mqd_destroy = amdgpu_userq_gfx_v11_mqd_destroy,
>>>> +};
>>>> diff --git a/drivers/gpu/drm/amd/include/v11_structs.h b/drivers/gpu/drm/amd/include/v11_structs.h
>>>> index b8ff7456ae0b..f8008270f813 100644
>>>> --- a/drivers/gpu/drm/amd/include/v11_structs.h
>>>> +++ b/drivers/gpu/drm/amd/include/v11_structs.h
>>>> @@ -25,14 +25,14 @@
>>>>    #define V11_STRUCTS_H_
>>>>
>>>>    struct v11_gfx_mqd {
>>>> -       uint32_t reserved_0; // offset: 0  (0x0)
>>>> -       uint32_t reserved_1; // offset: 1  (0x1)
>>>> -       uint32_t reserved_2; // offset: 2  (0x2)
>>>> -       uint32_t reserved_3; // offset: 3  (0x3)
>>>> -       uint32_t reserved_4; // offset: 4  (0x4)
>>>> -       uint32_t reserved_5; // offset: 5  (0x5)
>>>> -       uint32_t reserved_6; // offset: 6  (0x6)
>>>> -       uint32_t reserved_7; // offset: 7  (0x7)
>>>> +       uint32_t shadow_base_lo; // offset: 0  (0x0)
>>>> +       uint32_t shadow_base_hi; // offset: 1  (0x1)
>>>> +       uint32_t gds_bkup_base_lo; // offset: 2  (0x2)
>>>> +       uint32_t gds_bkup_base_hi; // offset: 3  (0x3)
>>>> +       uint32_t fw_work_area_base_lo; // offset: 4  (0x4)
>>>> +       uint32_t fw_work_area_base_hi; // offset: 5  (0x5)
>>>> +       uint32_t shadow_initialized; // offset: 6  (0x6)
>>>> +       uint32_t ib_vmid; // offset: 7  (0x7)
>>>>           uint32_t reserved_8; // offset: 8  (0x8)
>>>>           uint32_t reserved_9; // offset: 9  (0x9)
>>>>           uint32_t reserved_10; // offset: 10  (0xA)
>>>> --
>>>> 2.34.1
>>>>
