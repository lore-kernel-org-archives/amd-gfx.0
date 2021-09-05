Return-Path: <SRS0=lW8h=N3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BC1C433F5
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Sep 2021 08:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 864F76103B
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Sep 2021 08:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 864F76103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAA5289C9B;
	Sun,  5 Sep 2021 08:03:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CF6D89C9B
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Sep 2021 08:03:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ki+KGx87VXoduVl9UzGQgJc2DKm5FtjPO99LR0jQ9dXaVdZJ5ds4y0CCzXiBrwUtfS0/zE2DIn4euR511hC04VsXANZHyC8oZnUnN7IBKAkzkQkdK43AraMvMrGGb01dxr4d+q6arUSNyEhWsx+UyhHeCKOfdNklhPR+Z+6OZeMBYT9hfxEEpUJjoXHKx04fFb2ROtkVEt7LUmvvj3Wy0BXsmsKguQy2JjMCWmyvwjxCsaYmhD1B6/9xkVM5rBfXIyRlZp+1VM4LFK15OoZPCe04Rb9qaC3zmRhv0sw17rjAO2ELzk+VfvTsM7Bzyp2dMGrPnfSq8CtoQGFGYGTE7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=t49xpI+SP0IjmPmkZHy7kiMmP0wgUkp8WWV+8IphuNU=;
 b=ToOVzWL3qOK7cgp+P+oiaNpatXQdHgp1MzRGnE4H1x8XrVtQdsQkXrFqF6S36pJYKPWdss41+sUsi0QF5zUKVjlfCRljJdVLHXQRlNvMLmNm80G1YFLmYlGAXe90ZeYPYD1lz1N9L3wSnC9tF9fIDL8TUbHpUZdOIsHUh6/0KGD1SB7wskIpGzSvU5RH3dHA3Ryt4U9YWFX1Lffarj89AW95QQmPOSB8tB60M1zC5a4uHRGd73dew8gR4MczMutjziYtq9EpzHPmUdcw1ENA0dToHLVXV/DXWaaO4+koOBQPcGQeAJcgqGotJiX3zXHC4eWZrHMWn8KuDNKF3kCG5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t49xpI+SP0IjmPmkZHy7kiMmP0wgUkp8WWV+8IphuNU=;
 b=ZJWo4TeekiDb2p3vUmjZ6dA3FC9I9RUoFyC++LNhi7BYZsRGkITqAvOaTzwcVXwgZnLWNFWlx2gm5TgxE09rkOoXrQMNzVoyGp2PmiUyISqN1Jaa1h8y/Ku15rrKnQCgC70B+t2VEkB2zbJmOuvb7TShMknmhwYH2FwvogVDpHI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM6PR12MB5551.namprd12.prod.outlook.com (2603:10b6:5:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Sun, 5 Sep
 2021 08:03:44 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9c06:d113:293:f09b]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9c06:d113:293:f09b%8]) with mapi id 15.20.4478.025; Sun, 5 Sep 2021
 08:03:44 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: cleanup debugfs for amdgpu rings
To: "Das, Nirmoy" <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com
References: <20210902114459.3866-1-nirmoy.das@amd.com>
 <20210902114459.3866-2-nirmoy.das@amd.com>
 <e3a13fd6-f3f3-7980-14d6-b93948053535@amd.com>
 <29a155c4-085a-442c-08f7-50ea56f831d6@amd.com>
 <ba709b1d-5eeb-e748-811f-fbea728ab0b9@amd.com>
 <82d8e743-1b0f-daa9-3bda-fc791dd1795e@amd.com>
 <7370b0d3-a179-1138-bbc7-728dcd131498@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
Message-ID: <1b7ec90e-752a-3111-c226-25ec1d3c385f@amd.com>
Date: Sun, 5 Sep 2021 13:33:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <7370b0d3-a179-1138-bbc7-728dcd131498@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR0101CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::20) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
Received: from [192.168.68.104] (106.51.20.251) by
 MAXPR0101CA0058.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend
 Transport; Sun, 5 Sep 2021 08:03:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e61bf37-f91f-49e0-001e-08d97043ae82
X-MS-TrafficTypeDiagnostic: DM6PR12MB5551:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB5551288E7C96FB26FA7B4532F2D19@DM6PR12MB5551.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rp9sx2wnnajKEMhxrEu7qzYmmSTHSEhxYYlfI8OovhVoRdvD6NiGgA+nxRSs0Exr0kjBWGce1QzcBd/F83d4fCwEI9xtYLz52ghc6f4GE5RoEE3jrIWHxCIJIzdn1RAfedLTdhK9Mopntt4x0vi5lfHQHKGSxp/lMSF0JK4kRuIPBAZP0TioJ1Aj5jxwZ6QvqRpu4wgGLVfLPRdWm+Rj94Zc+NBffvMQ7ZRl59VR5fNV3Zjt0OxBLXgbAY8N7TpiCaert3zdRU1RjSEZKZYNx9C6GlGu6YSlzugUOMFKHOEn3ADvSCajyAt6yXjdEYb4qy7tg5vKjAuYQGYLBkJUeo465y6V8K0okqfvnD9p7OOK7l6zpXaDKMVywBuTfuRUZhJoKsRLjsA8q9RX3NUvF8dHq6DO5fAN+KHgm9sTJje0EgjOXIku9R58IckDmkYVEKC1CoYTU9V6k4Wd6jojlbeRJ/Y9i0T9AZJlwIW8lMnL4ku2yyg7V73sVyWOa9Dw6AyA0VRknp/OH+NqBf9tmeii04MpTLLQL01unxb7OQc1hLWgGfKoPhCJ7hd+z+9Xzg/KsrX6CtIeBDfU4fmHzsQ+Csjq9wszWdSBBp2dKwJtGAw6SEP7RSaS3fydDywgFtvJQC1PyD5gBi2pTW5EATcMWk53V1aOpLyaxeeJ23TQ8zvG9EXf95Qs/E9Ja9NMO0IOWGcNRwOPqwplgtyHW66AQAdVIDB62QszTiafkwcyaU6QskgWQ2rEttyZtt5f
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(6486002)(53546011)(55236004)(2906002)(2616005)(956004)(38100700002)(36756003)(186003)(1006002)(8676002)(316002)(16576012)(4326008)(6666004)(5660300002)(26005)(31696002)(8936002)(478600001)(86362001)(66946007)(83380400001)(66556008)(66476007)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkFsWHRIK3BSUXhDc3htRkpVZllpVjVXa0haLy9LeWladjh4NEVHaVF4SzBC?=
 =?utf-8?B?WkxjN05wUjVmZzRNTitDVm9XbDhBbHVoYlBHR0lvbmlPK1owZDFCOEtvNVZm?=
 =?utf-8?B?aUJtYm5SaXVMUXFKUDY5Z3hKKzVsWHdJRHlkdHJLNnNiN0FueVZ2MzJuYWdX?=
 =?utf-8?B?ZGNqMUNpVGpaKy9HN1RSK1RsbXJUTkJFeEVJOVlrY3hXdHdNVnlYaU4xSEE3?=
 =?utf-8?B?MHRKRmtLcHR5U2pBY1lWR2JjR0JjTTM2NWNYUURUc3JYUEFqbGI2UHlUN1JN?=
 =?utf-8?B?WVZmdFdPV1QvRnB5WjRhMnc1ai83MVNDcEU2VmdHak5uMjVoKzlxeE11UmNl?=
 =?utf-8?B?K0RjMU91aUdZNkY1aDdVUnhIb3dVQlp0WEhYaTAzSmFJOWlVcFlDLzVTaHFV?=
 =?utf-8?B?aStNOTI3UCtuakJMMFlrRTJJRWc0Z3c2Z09kKzRmNUVTWG9jWVhNS093cWl4?=
 =?utf-8?B?MTdBWkNXTVZYNnVPeVVla3BKNFVOanlFL2MzMWMvdHZIcnhuanZZMnBDTjN3?=
 =?utf-8?B?R0cvTWJ2bDlUTVVrRVRvZGhDSkpGTVBONTZOby9JLzdUUFQzMFcwMzk2U0Er?=
 =?utf-8?B?YU9EYmtjNG0vdGtGMzJRT0NPS0pzZUphVU5zaVByZFFMTU1scmNIR0xta3Ft?=
 =?utf-8?B?cjUwNzBValZ1elBJbWpldy90a2NySEZkZ1NIeFBMWGRUcW9sVWg4MXkrYy95?=
 =?utf-8?B?QVdkN3M3b2pVVUlwL0IzdnlqVUM5YVdqMU1zWHBpT1pPc0QzUE9RTnNyYWdT?=
 =?utf-8?B?SGkyU3VOYkQ0eG1XSmR5ZHgzNW9LcUp1enB3ekFZQXdLRzFobVdRTWhFRDhF?=
 =?utf-8?B?NnF6bnZYUzRhcWFtR1hjbDVzMUR6Q0hQcTE1SzFOTU9FclQyRzZ5VDRMbFR4?=
 =?utf-8?B?ZjJVcjRnQ0JPRlM3RVJURmdUS2pZMjNObjRuRjhPd1kwZHlvd0VFUzl2WEUx?=
 =?utf-8?B?WE5yWVRrcFNKNUxHT3hTeW5UVm0yMzB6SjlVTjVHYTNEKzZ3SG9qazdmMlBU?=
 =?utf-8?B?a0QwVnI1M1ZBT24zZ1lXYUNocVMyL0YvVUVxcC83TjB4dHZDOGFHZ3lqNVlI?=
 =?utf-8?B?UWhLekl2cXJhMDF1akxlQkJFYThqRTVPbllJTEZUcVdPbmt3d0YwVUdjamJn?=
 =?utf-8?B?Y3JzaTZHSFlCYzZPVDFhOWxoRUw0WW1zOUhqZHJlWHFTa1pGbkFyMVRHenFn?=
 =?utf-8?B?YS9kQlN6NUdHaDQ0SzExYjJ5S2VmbEd5K2hZTXR1YkJKZSsvQ1Q0QkdZb0ls?=
 =?utf-8?B?OVhGUkYwKzd6S0c2L05CUlVKTjBETUJCaG9NRXN1bjZwMnZ6ZkJZeGdueXpu?=
 =?utf-8?B?MWFaSDJnTDIzVGg5QXl2RWMvWWhVaTh5aHhDWWdYSEU4NGJVOEsrV2RNeVlr?=
 =?utf-8?B?clJvQWVIRlhLa0p5d3BJKzNxc3hkOTJDaTVlempXbnhWbUZVcTdvNGYvamIw?=
 =?utf-8?B?ZmRPcGxqOE85SzJ6bkVtVUkyTHhUYkhuVFJFdkhVQlRPc20xckZreGFvai9S?=
 =?utf-8?B?YS93WW5ZTSswb01vSVE3ekJnQUtOeUkvcXpXTlFVQjBQMnJ5bzVXaWFrL3ZW?=
 =?utf-8?B?QWxBb1dEV3YyNndDRE52VTZFQTByOEJSYjRLRVZZUk40WjhaZDJVZkNMODRQ?=
 =?utf-8?B?aHRMaktjYzkyZmRrcVM1cjExOWNobXR4SmVONHAyUUppTjB2NGt5SXFiM1lD?=
 =?utf-8?B?ZjluNGgwMUdNMFdjUi9ibVBxT3VGMVdVdG9nS1haWnF0d0lZZEJmSGloMHRK?=
 =?utf-8?Q?NN2MMUgOVC5DbF4S25fBZE+5gS1p/YhR7sfczUK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e61bf37-f91f-49e0-001e-08d97043ae82
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2021 08:03:44.4173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ns6LkFz/lHNI79hQtIC/cM/uPqwpsLBK1upjMPG7Gsu84wvaUq99UFWs5tsRTkLKJZclMyPjxWdhtEd3NZUFow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5551
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



On 9/3/2021 9:44 PM, Das, Nirmoy wrote:
> Hi Shashank,
> 
> On 9/3/2021 5:51 PM, Das, Nirmoy wrote:
>>
>> On 9/3/2021 5:26 PM, Sharma, Shashank wrote:
>>>
>>>
>>> On 9/3/2021 1:39 PM, Das, Nirmoy wrote:
>>>>
>>>> On 9/3/2021 8:36 AM, Sharma, Shashank wrote:
>>>>>
>>>>>
>>>>> On 9/2/2021 5:14 PM, Nirmoy Das wrote:
>>>>>> Use debugfs_create_file_size API for creating ring debugfs
>>>>>> file, also cleanup surrounding code.
>>>>>>
>>>>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  4 +---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    | 16 +++++-----------
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  8 +-------
>>>>>>   3 files changed, 7 insertions(+), 21 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>> index 077f9baf74fe..dee56ab19a8f 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>> @@ -1734,9 +1734,7 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>>>>> *adev)
>>>>>>           if (!ring)
>>>>>>               continue;
>>>>>>   -        if (amdgpu_debugfs_ring_init(adev, ring)) {
>>>>>> -            DRM_ERROR("Failed to register debugfs file for rings 
>>>>>> !\n");
>>>>>> -        }
>>>>>> +        amdgpu_debugfs_ring_init(adev, ring);
>>>>>>       }
>>>>>>         amdgpu_ras_debugfs_create_all(adev);
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>>> index f40753e1a60d..968521d80514 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>>> @@ -415,26 +415,20 @@ static const struct file_operations 
>>>>>> amdgpu_debugfs_ring_fops = {
>>>>>>     #endif
>>>>>>   -int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>>>>> +void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>>>>>                    struct amdgpu_ring *ring)
>>>>>>   {
>>>>>>   #if defined(CONFIG_DEBUG_FS)
>>>>>>       struct drm_minor *minor = adev_to_drm(adev)->primary;
>>>>>> -    struct dentry *ent, *root = minor->debugfs_root;
>>>>>> +    struct dentry *root = minor->debugfs_root;
>>>>>>       char name[32];
>>>>>>         sprintf(name, "amdgpu_ring_%s", ring->name);
>>>>>>   -    ent = debugfs_create_file(name,
>>>>>> -                  S_IFREG | S_IRUGO, root,
>>>>>> -                  ring, &amdgpu_debugfs_ring_fops);
>>>>>> -    if (IS_ERR(ent))
>>>>>> -        return -ENOMEM;
>>>>>
>>>>> Why are we doing this ? Why to make it void from int ?
>>>>
>>>>
>>>> We tend to ignore debugfs return values as those are not serious 
>>>> errors. This to sync with rest of our
>>>>
>>>> debugfs calls.
>>>>
>>>>
>>>> Regards,
>>>>
>>>> Nirmoy
>>>>
>>>
>>>
>>> I am not suere if completely removing the provision of return value 
>>> is a good way of doing it, we can always ignore it at the caller 
>>> side, isn't it ?
> 
> 
> 
> I just realized while making the change debugfs_create_file_size() is 
> void return, so we don't have anything useful to return in 
> amdgpu_debugfs_ring_init()
> 
> 

Ah, it makes better sense now. Probably just a mention in the body of 
the message that we are moving from debugfs_create_file() to 
debugfs_create_file_size(), will make this change of return type more 
logical.

- Shashank

> Regards,
> 
> Nirmoy
> 
> 
>>
>>
>> Yes, we are currently throwing an error msg and ignoring it. I don't 
>> have a strong opinion regarding this, I will send a v2 restoring 
>> previous behavior.
>>
>>
>> Thanks,
>>
>> Nirmoy
>>
>>
>>>
>>> - Shashank
>>>
>>>>>
>>>>> - Shashank
>>>>>
>>>>>
>>>>>> -
>>>>>> -    i_size_write(ent->d_inode, ring->ring_size + 12);
>>>>>> -    ring->ent = ent;
>>>>>> +    debugfs_create_file_size(name, S_IFREG | S_IRUGO, root, ring,
>>>>>> +                 &amdgpu_debugfs_ring_fops,
>>>>>> +                 ring->ring_size + 12);
>>>>>>   #endif
>>>>>> -    return 0;
>>>>>>   }
>>>>>>     /**
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>> index 88d80eb3fea1..c29fbce0a5b4 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>> @@ -253,10 +253,6 @@ struct amdgpu_ring {
>>>>>>       bool            has_compute_vm_bug;
>>>>>>       bool            no_scheduler;
>>>>>>       int            hw_prio;
>>>>>> -
>>>>>> -#if defined(CONFIG_DEBUG_FS)
>>>>>> -    struct dentry *ent;
>>>>>> -#endif
>>>>>>   };
>>>>>>     #define amdgpu_ring_parse_cs(r, p, ib) 
>>>>>> ((r)->funcs->parse_cs((p), (ib)))
>>>>>> @@ -356,8 +352,6 @@ static inline void 
>>>>>> amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
>>>>>>     int amdgpu_ring_test_helper(struct amdgpu_ring *ring);
>>>>>>   -int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>>>>> +void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>>>>>                    struct amdgpu_ring *ring);
>>>>>> -void amdgpu_debugfs_ring_fini(struct amdgpu_ring *ring);
>>>>>> -
>>>>>>   #endif
>>>>>>
