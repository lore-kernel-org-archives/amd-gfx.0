Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6D2C761AF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 14:42:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 081F510EE9E;
	Thu, 30 Mar 2023 14:42:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57C4110EE96
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:42:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKRzBcMU1NqUOuQ/XMxlyEBh/VX5Q0418zy9FQFwaGzzqGdO6gJRitOkxscRcqKW/hQtHBz5QpHEdm+0/4LkYXFFHdRN7+6iBOXJTWRjn8LKjMbY2qLsPjQ74A+Ptzx0Ruo3o3P/jRJ6R0/3lUHCpdJx64Tw9SP4EFwiGjPtgWIZfxiCX4tCTRVJngzuLnK9ouHULFLhmqtjmjNAVcAKpDlqs6Ply75XkcE0UthlYvUb9ahODmgzWSmhMhs8Kq+EEwuZFBPdFunwZiplInxOjYlJdG+nOgj05xA0SG6p+HHbAqEoZ9Fig4r62TxehlULwvGsG+4DQLWCb9P+RdX5kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odklySx9/dxqeackxUb0mtSAE2k313OewR0gmOFRPS4=;
 b=KmpPLiXMUfkg8UIL/aObPB2YGe3WRohkOqo6Xu0aqZjyv+5rGL7t4sbHpEVeGyQOQLrqmLCU5gdfgGBKj8RF3HQvdgILY0tAXlW4tdpD3DiCZpymt+MUYoqjq6qKBNnCvB43KqcArnIl02sPsg2ed7MdcmQ3VZ1FCbsXY3oHtuDkRuYWhvH4rmY+tYITCkYZHAKl9PeqKJZJiKvpo93gL2saa8Ja8d0lGtSm48cGCJG+5ly0xoLGx+F3dcWMEzxX4hzulbVrOoIeUJp3tfbfYGtyX87hJaxk09Tfs/BUBV9H7I8q7YAAqoEeFNuGtH1N5FJV3v+mYv/g0zZB5HtWJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odklySx9/dxqeackxUb0mtSAE2k313OewR0gmOFRPS4=;
 b=ltjN2RJS8YRCohxShivWjpLjulvhRJdOT+o6lUnI5wNeaEWRIGaxwnxbVcNqXtymqL6tlcpnqqz+o99tchLkd5W8BhaZdGWmp6l6Tpw8i80T5r/c4HcFj4uu+0gebSAPGpDjWqHrHCCRMsDWfph5tAJSumDxXd/n8hBtUCi4iNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB4960.namprd12.prod.outlook.com (2603:10b6:5:1bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 14:42:14 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 14:42:14 +0000
Message-ID: <1b468b00-6435-425c-ae0a-5ed4c1727d96@amd.com>
Date: Thu, 30 Mar 2023 16:42:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 09/16] drm/amdgpu: create kernel doorbell page
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Shashank Sharma <shashank.sharma@amd.com>
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-10-shashank.sharma@amd.com>
 <4c4776ea-c53c-a37a-ba4b-3a0be4e7645c@amd.com>
 <0ceb747c-d71f-a6ae-67e4-a53f136ca0bd@amd.com>
 <CADnq5_OZkNwPhwAmvmzVN+w6B4oBmMWdBGsuTBJP0y9ct9eUMA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_OZkNwPhwAmvmzVN+w6B4oBmMWdBGsuTBJP0y9ct9eUMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::9) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM6PR12MB4960:EE_
X-MS-Office365-Filtering-Correlation-Id: db5da34b-4ca8-4040-9e7e-08db312cf37d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NkqmvPhavLUs+M8yaqlB2I8sX0ELmS1xsKGmdF6pJOnWoS0BgYYslJ3yamyJwV/0oTYyP1HxWtt4mSkhk43LBQFHJCgTcOB4twGBUSur+tOF7x6dB+taE9MH3nhIT3cHpo6gXzAB7zsjtAAbdZsJ9zQxflDACeoSmO57HD8wFDl1QWDj18bJd/evWwzdao6MbRyzm1mfMMg2O8bDJoSbCm2eHKdAA1ETHXf9GX7smEGbyBcgrPOfy4KX22BxX2GsswbX3H8oJrMieNXF5MN1FvjbGjmA9TifNgLprzU4L1hyTF16s80UwooHFKhII+/uegamFySXMeBewS6b0LloSa2Uk1GAVSR8MrQoV33MB+06lds38k6nEFw41auvgdwXsk5GIsxi3sXpQBeLaoxKZ8ul3Dx/+fBeWpI+rJgje9YRvBpq0hDyUx0blzUVBRkG4Wyng7EXAWuCyjgrktu7JYwwMvE+FbYwzT1IORhthlifDp5P0HQObxpTXqpRCy9XuC2/ld/NuUYonSDOltE0o/VGVridq78XsW677u1s9K86H4JF+8oDXwuLyEQRieXlmI0fCdM/TGnXWYsiHj75PtUuW2A0wv+XD+tdKS+oauhKpG/hbmlP5TXvXhOGImkLdVDtMXg29jJkHB29qJ30aQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199021)(478600001)(53546011)(38100700002)(2906002)(6486002)(5660300002)(66574015)(2616005)(186003)(8936002)(36756003)(6506007)(54906003)(110136005)(6636002)(316002)(31696002)(41300700001)(66556008)(66946007)(86362001)(66476007)(4326008)(8676002)(6666004)(6512007)(83380400001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE9uTDhPWWI2MjlPQ05VR252a2Z0NTB5QWthQW1aaVd1N0Z6SVZxeGcxVlBZ?=
 =?utf-8?B?bWJISWFRTVhPVURoY3ZDNjZPTDJXclZFVW5EeDltZkd1bzJlNjdGZnVqcXh3?=
 =?utf-8?B?MGdaY01jUW1oRTJsdmplQ0lYT1BsV2tKQ05jaUFieTcxZlpkb1lZVUprZjli?=
 =?utf-8?B?Z3dQNGo2MmJpWHZCUDVHbkllOWRrWENyNUEvcHRNODJWZVpmdStQZ1NUUUMr?=
 =?utf-8?B?T2lCeisrNGhKUDRZT3N6NFU5VS9Wbm9rVysrNDZuYzhhUkhjdjM2SkZvcFcw?=
 =?utf-8?B?N3I5OEFqTUVlb1dTVk1YbHBtM3dXUER1c2Q1bkJCL3dyQmdiRzhEUUozM3F3?=
 =?utf-8?B?aHJRRlZzVmVjTVpJM1UwM1RMV0JNK0xlMlNlMk92aGM5Z25SSkVaaFF5R3JS?=
 =?utf-8?B?OHdrY1I4TUN6WitTZms0cFNzUWkyQ1p4dEtBSzhhZEtrcWhBR1pWRUgwd0Y4?=
 =?utf-8?B?dkVVU3FHeVhGRnJtaU1CUWR5bnhvUUpzNmIzWkYxUC96TExCNGRvc2NTOFYw?=
 =?utf-8?B?YTRrKzRCUEo1WEwzZFltNUxHSjF0RFlVOFp4eWwxU051MkdXank3N1krZERM?=
 =?utf-8?B?cWh4R0ZWUHRNZ1U3ZmR4SjFvT0IzUDVxandJbWpIRXZpY1BudzlVd2RQYVhX?=
 =?utf-8?B?TVl1UHY3eHFIanVlNW55SUxZWDltMW5Pc0puZzZDelZHV1RBUHM5OE94WGk1?=
 =?utf-8?B?L21BdXllVjU0L3dQQ09NVTYrSjBFVkhiZ2ZDMGZXN0Y5U3RubkN4Rms2UFVV?=
 =?utf-8?B?K0NsM2NQMmV1WHpabHlSeG9QbzJNNGxhTGJRWUh3K2hqSEtMeWtDMHJFQWtv?=
 =?utf-8?B?dmRaMHVCTFk4SkIxclBWRzh2ZnBFaTZIemNXb1MrR0FZN1F1UVZoazJQNHVa?=
 =?utf-8?B?OVU1c1ZQTXBzSjkyT1NCTzVBb0JBOHRYczRmMHJWK01WQmZTSmliL05jMVpI?=
 =?utf-8?B?Z1RRdjkrTWNCUjFlZnU4Wlh4ZUdGRlFnTHpabGFjZW9OdE9Da0dYdGduZ1Yr?=
 =?utf-8?B?aEZPTW9vYWI2bVZ0ekhvc09WdmFGVTdBaTdqNVVZM2NTRmdUTTUrRVhYR2hn?=
 =?utf-8?B?MWdIaFhMTVY4VWhMdlhIWFpGemFwMU5RVmtteUsyM3NSWWxLNVRrMEVMNGMx?=
 =?utf-8?B?TEJUcVphRHY2cVVTM3RQOUdlNmtwb296ZTV3U2p4eFhCRGlUSU4zdG9tQjBM?=
 =?utf-8?B?dytUNVJCNFducmV1NjMwZ0thTVExMys1VUFwZE1ObXgzNW5lSm1zb2VqempO?=
 =?utf-8?B?VDBCazhGR0VvbXdQQXZrSS96Q1F1bjVITzMwTk5vaU5vOTJodTVTUUsyMUh3?=
 =?utf-8?B?WDVqcXE2VmdvdmNUWnZyZG5YRjZ1bXU1ODFCOHUwT0Nta2c4YUg5SURpaTZ1?=
 =?utf-8?B?d0lZdVkyTFpSL3dCem84cVA4WUVEUlUvN1FDNnBYcU8vQ0xydlpNVnVoYTda?=
 =?utf-8?B?M3lqTGFzTEp3KzAxSDJLT2c4M0NpK0xabVFoZmhxNk13bTBFSm1tUU1HMDJU?=
 =?utf-8?B?ZEUxTlVCTmtTU201U2YrZGcxdTFjVGtTc3RZamRkVEJpTkRpRTVIVElEYkNO?=
 =?utf-8?B?a0k1Zy9Yb0t0bGZxZUVPd3Vqa09hRHowTlJ6NStCOU90QmZ4b2VROXZ3T0gw?=
 =?utf-8?B?UW1mRWxJVnpNeTNlVXN4ZTRQMC9LZWc1bDdFSkNkR283aDd5WlhKbXd1NFZ4?=
 =?utf-8?B?SUEvMnhYTnFuR0kzcG44MlFYRUdRekN3WERNSWxjZUZFdkpreGdPRUlNUi9v?=
 =?utf-8?B?bWRpbXlMMzZMKzg0ZlJza3dhYWJyL0hJVDJ4Rkg2T3hlUjEwVVRHZzVoSlE1?=
 =?utf-8?B?SVhndDJrNjRSc2VXQWNSUmR0WncyaXdzek03Yy9hSHNsRlJyUzBMbHQ0czN6?=
 =?utf-8?B?UmVoRFRpMHNuK1JJY1BaN3o4SHoyR0N0QS80Qm1hK2ptR2M5NVlxMDNMN25F?=
 =?utf-8?B?RktMUGlzY2M1SmtVYVZyZStwdjNJTENhaEcraDU3ZXkvRkM0SGRoVUE2QW9s?=
 =?utf-8?B?ZUZ3cHBvS0pKWWdwQ1pxUEpiYzVaaWlNRmk5SzUvN21BREJkOE9ncCtqWExR?=
 =?utf-8?B?bk51ck1ObGFENUc4TDl3SzFtS1ZKcGFDREUzSWt6U1lBYVEyS3NCTFEvZ3RD?=
 =?utf-8?B?WllXWFNybVg3eTlHVENycHhuRmticnp2S1FnNFQ4aE9xZnVtRXcwVzhDUHdB?=
 =?utf-8?Q?wmLRBfcuB6E5OVsDcislNqvnKXkZOwMevjoMNzFdAsZX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db5da34b-4ca8-4040-9e7e-08db312cf37d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 14:42:14.4606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tr6SLewJiwXOBydyZxwRxUbj0/yu4hCs4dtAaQ5SobbDm9nf7Xj9KDAfNRV2bKL5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4960
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 30.03.23 um 16:39 schrieb Alex Deucher:
> On Thu, Mar 30, 2023 at 7:49 AM Shashank Sharma <shashank.sharma@amd.com> wrote:
>>
>> On 30/03/2023 13:30, Christian König wrote:
>>>
>>> Am 29.03.23 um 17:47 schrieb Shashank Sharma:
>>>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>>>
>>>> This patch:
>>>> - creates a doorbell page for graphics driver usages.
>>>> - removes the adev->doorbell.ptr variable, replaces it with
>>>>     kernel-doorbell-bo's cpu address.
>>>>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 16 ++++++-
>>>>    .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 44 +++++++++++++++----
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 +++
>>>>    3 files changed, 57 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>> index 6581b78fe438..10a9bb10e974 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>> @@ -49,10 +49,13 @@ struct amdgpu_doorbell {
>>>>        /* doorbell mmio */
>>>>        resource_size_t        base;
>>>>        resource_size_t        size;
>>>> -    u32 __iomem        *ptr;
>>>> +    u32    __iomem        *ptr;
>>> This one can probably go away if we use the pointer from
>>> amdgpu_bo_create_kernel().
>> We started like that, but later realized that the cpu_addr from
>> create_kernel() will just limit us
>>
>> to that object only, whereas we are keeping this ptr to ioremap the
>> whole doorbell space in one shot.
> Why do we need that?  For the kernel driver, we'd only need to mmap
> the page used for kernel doorbells.  Then each user app would mmap its
> doorbell page.

Yes, that is exactly my concern as well.

The kernel needs a fixed number of doorbells allocated for its internal 
use. Everything else should probably use the normal BO API.

For KFD we can use the BO API internal in the kernel, but that is 
certainly completely different to the kernel allocations.

Christian.

>
> Alex
>
>> - Shashank
>>
>>>>          /* Number of doorbells reserved for amdgpu kernel driver */
>>>>        u32 num_kernel_doorbells;
>>>> +
>>>> +    /* For kernel doorbell pages */
>>>> +    struct amdgpu_doorbell_obj kernel_doorbells;
>>>>    };
>>>>      /* Reserved doorbells for amdgpu (including multimedia).
>>>> @@ -369,6 +372,17 @@ void amdgpu_doorbell_free_page(struct
>>>> amdgpu_device *adev,
>>>>    int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>>>>                    struct amdgpu_doorbell_obj *db_obj);
>>>>    +/**
>>>> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel doorbells
>>>> for graphics
>>>> + *
>>>> + * @adev: amdgpu_device pointer
>>>> + *
>>>> + * Creates doorbells for graphics driver
>>>> + *
>>>> + * returns 0 on success, error otherwise.
>>>> + */
>>>> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device
>>>> *adev);
>>>> +
>>>>    #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>>>>    #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
>>>>    #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>> index 8be15b82b545..b46fe8b1378d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>> @@ -160,6 +160,38 @@ int amdgpu_doorbell_alloc_page(struct
>>>> amdgpu_device *adev,
>>>>        return 0;
>>>>    }
>>>>    +/**
>>>> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel doorbells
>>>> for graphics
>>>> + *
>>>> + * @adev: amdgpu_device pointer
>>>> + *
>>>> + * Creates doorbells for graphics driver
>>>> + *
>>>> + * returns 0 on success, error otherwise.
>>>> + */
>>>> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device *adev)
>>>> +{
>>>> +    int r;
>>>> +    struct amdgpu_doorbell_obj *kernel_doorbells =
>>>> &adev->doorbell.kernel_doorbells;
>>>> +
>>>> +    kernel_doorbells->doorbell_bitmap =
>>>> bitmap_zalloc(adev->doorbell.num_kernel_doorbells,
>>>> +                              GFP_KERNEL);
>>>> +    if (!kernel_doorbells->doorbell_bitmap) {
>>>> +        DRM_ERROR("Failed to create kernel doorbell bitmap\n");
>>>> +        return -ENOMEM;
>>>> +    }
>>>> +
>>>> +    kernel_doorbells->size = adev->doorbell.num_kernel_doorbells *
>>>> sizeof(u32);
>>>> +    r = amdgpu_doorbell_alloc_page(adev, kernel_doorbells);
>>>> +    if (r) {
>>>> +        bitmap_free(kernel_doorbells->doorbell_bitmap);
>>>> +        DRM_ERROR("Failed to allocate kernel doorbells, err=%d\n", r);
>>>> +        return r;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>>    /*
>>>>     * GPU doorbell aperture helpers function.
>>>>     */
>>>> @@ -179,7 +211,6 @@ int amdgpu_device_doorbell_init(struct
>>>> amdgpu_device *adev)
>>>>            adev->doorbell.base = 0;
>>>>            adev->doorbell.size = 0;
>>>>            adev->doorbell.num_kernel_doorbells = 0;
>>>> -        adev->doorbell.ptr = NULL;
>>>>            return 0;
>>>>        }
>>>>    @@ -208,12 +239,7 @@ int amdgpu_device_doorbell_init(struct
>>>> amdgpu_device *adev)
>>>>        if (adev->asic_type >= CHIP_VEGA10)
>>>>            adev->doorbell.num_kernel_doorbells += 0x400;
>>>>    -    adev->doorbell.ptr = ioremap(adev->doorbell.base,
>>>> -                     adev->doorbell.num_kernel_doorbells *
>>>> -                     sizeof(u32));
>>>> -    if (adev->doorbell.ptr == NULL)
>>>> -        return -ENOMEM;
>>>> -
>>>> +    adev->doorbell.ptr = ioremap(adev->doorbell.base,
>>>> adev->doorbell.size);
>>>>        return 0;
>>>>    }
>>>>    @@ -226,6 +252,6 @@ int amdgpu_device_doorbell_init(struct
>>>> amdgpu_device *adev)
>>>>     */
>>>>    void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
>>>>    {
>>>> -    iounmap(adev->doorbell.ptr);
>>>> -    adev->doorbell.ptr = NULL;
>>>> + bitmap_free(adev->doorbell.kernel_doorbells.doorbell_bitmap);
>>>> +    amdgpu_doorbell_free_page(adev, &adev->doorbell.kernel_doorbells);
>>>>    }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> index 203d77a20507..75c6852845c4 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> @@ -1866,6 +1866,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>>>            return r;
>>>>        }
>>>>    +    /* Create a boorbell page for kernel usages */
>>>> +    r = amdgpu_doorbell_create_kernel_doorbells(adev);
>>>> +    if (r) {
>>>> +        DRM_ERROR("Failed to initialize kernel doorbells. \n");
>>>> +        return r;
>>>> +    }
>>>> +
>>>>        /* Initialize preemptible memory pool */
>>>>        r = amdgpu_preempt_mgr_init(adev);
>>>>        if (r) {

