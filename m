Return-Path: <SRS0=/nsf=NZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B52C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Sep 2021 15:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 932396054E
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Sep 2021 15:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 932396054E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1CEA6E8A9;
	Fri,  3 Sep 2021 15:51:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E72186E8A9
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Sep 2021 15:51:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyNbNvb6KwkB/FCVK7tpCQoz1K4x57GzhqrTNG8ETUnTv5fL2xySZIFdYykupRrYfKDEa/QHqgFby/bND6mJasYq2BoKYlTJFuGRtWBNI3ml1zYkUrVJTmBwHevSmGAVBjJcUAQlCr9H0jWlR2iE45EcQP6AHpwpAEL7NJ+Dgw4lHYqF46U+anBNtya+pgucEjZt79esqVk3Z4y67ymHu2ZZKdP90o21e66VGmWjz4WaSgTmw95zOfVrPJamDNbzCK7v1wCQ0hFFKNJmrgmSdzZq4p+yocEm64fUtH9vtU1tB0j5nCmvLocP8MOzJbV+1UY5JP44daqIn9ADifbh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=3e9TH9jemXpE09JemTFWFT+yewpvtOnMozEjI5WhftA=;
 b=GP3qNQl3ODNlgLXaTQU7zLP3XYV+EPARPnDh4t/dvHlsCGDKQV8MOIMUBQUgHud9It8TjVnJHEweqN+nzJYor8sIg+PEia1pn6e1tN5uPjjTHycCry4m1Bcd0tdTDLuZAdxyKZd+zJXq8VZrtH/Eit6sTvbn5RTYub9AXgMoRkbtCO9NQwaUgT1o4BA8yR9UDe5IQnTgwCo0rgfs6EYU6BUtuXBenPJAGIRLi+338QOH96RTTq/6lHyqw4R66sxLcaABO6wz2Jaet2GzTNg70Kr1A8KkUYwjjgw5bciyzokTzEEwEvD0gcEl6Yc3YE4P28++vCeLS3oUppTtZlmkMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3e9TH9jemXpE09JemTFWFT+yewpvtOnMozEjI5WhftA=;
 b=tmQd0EcfS1D04cavPoPnW0wg0vkdzc8VHmes2vjLyb7qE3rrI9nbWBBdmI/TSgBWlt9bldG8vrc5Rr36PL5XbfH/pSwy0SyvpUw++AZGivJJpfCXNxU0goSWwM41X0gwRZ0RzRremXghk5h/IBkhrK3LmvyGTQdkpbOBcktM/qY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5055.namprd12.prod.outlook.com (2603:10b6:5:38a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Fri, 3 Sep
 2021 15:51:46 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4478.022; Fri, 3 Sep 2021
 15:51:45 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: cleanup debugfs for amdgpu rings
To: "Sharma, Shashank" <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com
References: <20210902114459.3866-1-nirmoy.das@amd.com>
 <20210902114459.3866-2-nirmoy.das@amd.com>
 <e3a13fd6-f3f3-7980-14d6-b93948053535@amd.com>
 <29a155c4-085a-442c-08f7-50ea56f831d6@amd.com>
 <ba709b1d-5eeb-e748-811f-fbea728ab0b9@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <82d8e743-1b0f-daa9-3bda-fc791dd1795e@amd.com>
Date: Fri, 3 Sep 2021 17:51:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <ba709b1d-5eeb-e748-811f-fbea728ab0b9@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0701CA0016.eurprd07.prod.outlook.com
 (2603:10a6:200:42::26) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f20:4c00:3c5f:f8c4:464d:d43]
 (2003:c5:8f20:4c00:3c5f:f8c4:464d:d43) by
 AM4PR0701CA0016.eurprd07.prod.outlook.com (2603:10a6:200:42::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend
 Transport; Fri, 3 Sep 2021 15:51:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 847f5c4d-9f11-44cb-4159-08d96ef2bb7b
X-MS-TrafficTypeDiagnostic: DM4PR12MB5055:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB50550071C4438DAD3C5230678BCF9@DM4PR12MB5055.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TCjGB/YOt8m1vBQOVh731ZUfngdvvEOuoGNJPr0Z9l/SfAGRl8X9vIh9r442d/XgFOKVi22ZrKwVRLDcDB5eTQqNPIkeNXfKqbdJ/J2UhHEMiaaQ+shtGXxUXjnDhqHR/uYXHnG/ZLxHv9iTb4vihFZVRsS5Q+NnizO/NOcW8aHYcLhiWVcOoZxjSQdR8XC9INj430ss+Vim6sU+Nu5fVjaXxk+ehTMYEE25V3VUcxCpVd6yYfdqmVHITUKrCpIufSvtt48qQ88460ttifNwOyuig6IrPScWoxrLbe6FYiy+Ff5zr0Nkim60T2MapL53R/36PzZDStEhivT6SqkJ7zNGQ7HuaZ4Y65JMz4mz4TaFQ/WcmyrkHo0jsI//6l88J/+z5wYwKcCVZHQ2lgeC+/nlyFGJLyTv5vRTKdDkx8297q3rM38iO109E4CaU7WmBWBNz+KMJ8DckO9Rh00UJp4GYb9NT4ZFQkxsjpiEjgAAdEZm57+Lj295/o8tQzcK5+aNkidMUH7Rk62+KbwPmHJWjQ+xAXH11d32Rxyep/aFaM+gKWUg6hZSkFUaPg6jB8hSjh4RrhiVPeL5H/yhKmDrBboc40SA1S/Kq/dZBCGvWlKQO6ZhfapzlTzu49/xlPHpnoHEogQT6Jvny+4xyzP5IAu8NoSvpsdLPsZRWntOquMNOUyqFOOf2aaqEhX6ck4Zy4Fq5ARcM1y0xlQ7nEzWhvGx6fdcMOY6eZSNk4c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(52116002)(31696002)(4326008)(478600001)(36756003)(2616005)(66946007)(66476007)(66556008)(83380400001)(5660300002)(86362001)(53546011)(8676002)(2906002)(6666004)(186003)(6486002)(38100700002)(31686004)(8936002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFI5UzJ5QUxWb1pRQk5VbXBCRWJGMDNBTDFoZ2VvMnZFY2R3YmFTVVRHK3lU?=
 =?utf-8?B?VC9yc0IxMG9mMDJkVXNlRFJEZzFITEg4b0xJT2diVFFsdDZnbHRjZC9tZVZz?=
 =?utf-8?B?ZE1qbDRmRkNZdHhXZCsrQUoxNVFEcTNiemJyS2FUTDlIVjh6c1V1bFRlcCtr?=
 =?utf-8?B?TC9PVHhZYy9HZlN1ZzBPdU9GdC9IMjJDZnU4c0xsZ2hYQ0hlRmRaNGhxa0dF?=
 =?utf-8?B?MUtrMnVHTmVLbjdRSVduWU40NU9ndlBscEFGRCtpTTN4SUxTTHdiVDIraFFz?=
 =?utf-8?B?a2xFa0NTb3orM2RHUlZCN01jZ1dTaVNxaFVrbXdhTStPUnZubUNCdXd3aXo1?=
 =?utf-8?B?OFExN0Y4ZEYwNk8wL1ZKbDBKZk14eWMxV2JIdkJLbERNMkYyRGkzZ2szMkhk?=
 =?utf-8?B?WUZTUjZqTEhTU2lIMi9iYzdjaDkxS1FLNUVveVRUVFVhTmdoWTdtS1Z5U1RJ?=
 =?utf-8?B?Rm91MWMzeFpvVEh2VC9lVG14RldrNXJ3VmxYZ3N3T1NhZkY2SmVNRnNmbk5N?=
 =?utf-8?B?cDhnN3grbE5qRTF2aDRHQmI3YmxudlZCaTRvRU4zR2JRRUtObzgzQkxhVHRE?=
 =?utf-8?B?UkdVK1ZFZEw5eThtZ2RBSlFvRXYxak5wcmlwZGp0SlIzRVdscmtjcTZsTy9h?=
 =?utf-8?B?c3RPN25XeGg5dVBRZEZpWGNJZ3NxZDl3TTU0enhwQzlYdHl6dHh3YW1Sd21l?=
 =?utf-8?B?d1gyL2hwaXY5UjB6VmJKWC9YQ1NVUWE4QTc0Wk4yZHB1WmUxV3lKZTU5ME9D?=
 =?utf-8?B?Wkh3VXJWSEZKNnhmK1dTK0dXZTVWejN1NzUxMWRIOHUzY3o0Tk5PMm1tME5m?=
 =?utf-8?B?QWdxNjJZSnh4T3lUeVVmNjlUSTIvVmFyL2NQQU1LZFZnaE1sOC9vTllJOFhu?=
 =?utf-8?B?TEFaMU54Snk1aXpxOW9XQ3R0b2NqS1RlczlDT1Via1h6TkV1SEZTL0E4RWVE?=
 =?utf-8?B?RjhocTl3eCtWWXovRnZwT3N5Q243TWp0andWVWJuYWQ2VWVPdkZlQk1kK1BF?=
 =?utf-8?B?RGZQS25wODVzaEpaR1FZQWhDQmJJY1U4emVZQlpLNGdDK2Myc09YbGNKR005?=
 =?utf-8?B?V2NUZ0taK2VEM3N1SGFpQjB1aEdEbVpvNU1DRVU1LytUdTBsSDg3c1RBMDZF?=
 =?utf-8?B?aHpyUDd2NCtuZUN6UGhIZ2RUT1NDWGJ2Q0pONFJndzNTYk56d01Gbi93cmJl?=
 =?utf-8?B?TXkzekhpZmJ6aUQ2eTJtTmVZeVpQTnljRkcyVmVINU1rSFdOWXlxck9yNkYv?=
 =?utf-8?B?MGN3bEtKbDhpeDFrVVIyRFROdyswUGpHM05KbktvNnV0ZmJwNGhqZWpULzIv?=
 =?utf-8?B?VXZmMm9HSlBDc3lBWXQ3MU9aNnJ6MHBrTTRScDBSMzNIWlVaYUpIdVJuSlBB?=
 =?utf-8?B?aGsvUlBjZkVDRGc1SThmWmtRaTJtdWM3UEo0R1pBTUpHbW13ZUlwMnFVZnFJ?=
 =?utf-8?B?Ny8xbVR5aXVKMEFoYmZZb0s1cWJFRFIrSmR3bCtSVmVjRGRJTUFCR2ljVzls?=
 =?utf-8?B?cVY5TEg3QXJlcklqYml4TnZuekY1UDRFN0RCWlhzVSt3UC9uZWtWalZrblI1?=
 =?utf-8?B?TDcvZlR3SFErSHArUEp5QnpJZ2JlZERsSjlMNS9NRm5Ga2c4QmR3MXhtT1hx?=
 =?utf-8?B?RmNJamhWZGtqbkF5R2pFRWdWUXFEZW5oNkFaOXgvc0tQT2F1ZFlzRE5vcUFG?=
 =?utf-8?B?NEhqQmNOOVEvZVhJWDl2ZXJGZjJwcURNOW0xRGRiWEhzeVkyUzRUMWtQRmVT?=
 =?utf-8?B?anpUZmZRcDlKeXo3cW82VlJrY0ROMHE5TjVqU3JyZU9HcTVaMnpJbDNqTGJl?=
 =?utf-8?B?eEkxbDhvRmxFdEQyU1czWVhLeUMzZjhGM21uQURyaFBTcGZPdGtxTXdGc2xh?=
 =?utf-8?Q?mYFiSSRtlcb1y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 847f5c4d-9f11-44cb-4159-08d96ef2bb7b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 15:51:45.7577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLlF1wYuhvqyvvBbYUny7Y0AwllcbSO24rTBqf2vo1T3KQQOa5Ez4sTFU+8Beh9oV2xBzhJ7NaxOf/YZWFnmwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5055
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


On 9/3/2021 5:26 PM, Sharma, Shashank wrote:
>
>
> On 9/3/2021 1:39 PM, Das, Nirmoy wrote:
>>
>> On 9/3/2021 8:36 AM, Sharma, Shashank wrote:
>>>
>>>
>>> On 9/2/2021 5:14 PM, Nirmoy Das wrote:
>>>> Use debugfs_create_file_size API for creating ring debugfs
>>>> file, also cleanup surrounding code.
>>>>
>>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  4 +---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    | 16 +++++-----------
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  8 +-------
>>>>   3 files changed, 7 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> index 077f9baf74fe..dee56ab19a8f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> @@ -1734,9 +1734,7 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>>> *adev)
>>>>           if (!ring)
>>>>               continue;
>>>>   -        if (amdgpu_debugfs_ring_init(adev, ring)) {
>>>> -            DRM_ERROR("Failed to register debugfs file for rings 
>>>> !\n");
>>>> -        }
>>>> +        amdgpu_debugfs_ring_init(adev, ring);
>>>>       }
>>>>         amdgpu_ras_debugfs_create_all(adev);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> index f40753e1a60d..968521d80514 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> @@ -415,26 +415,20 @@ static const struct file_operations 
>>>> amdgpu_debugfs_ring_fops = {
>>>>     #endif
>>>>   -int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>>> +void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>>>                    struct amdgpu_ring *ring)
>>>>   {
>>>>   #if defined(CONFIG_DEBUG_FS)
>>>>       struct drm_minor *minor = adev_to_drm(adev)->primary;
>>>> -    struct dentry *ent, *root = minor->debugfs_root;
>>>> +    struct dentry *root = minor->debugfs_root;
>>>>       char name[32];
>>>>         sprintf(name, "amdgpu_ring_%s", ring->name);
>>>>   -    ent = debugfs_create_file(name,
>>>> -                  S_IFREG | S_IRUGO, root,
>>>> -                  ring, &amdgpu_debugfs_ring_fops);
>>>> -    if (IS_ERR(ent))
>>>> -        return -ENOMEM;
>>>
>>> Why are we doing this ? Why to make it void from int ?
>>
>>
>> We tend to ignore debugfs return values as those are not serious 
>> errors. This to sync with rest of our
>>
>> debugfs calls.
>>
>>
>> Regards,
>>
>> Nirmoy
>>
>
>
> I am not suere if completely removing the provision of return value is 
> a good way of doing it, we can always ignore it at the caller side, 
> isn't it ?


Yes, we are currently throwing an error msg and ignoring it. I don't 
have a strong opinion regarding this, I will send a v2 restoring  
previous behavior.


Thanks,

Nirmoy


>
> - Shashank
>
>>>
>>> - Shashank
>>>
>>>
>>>> -
>>>> -    i_size_write(ent->d_inode, ring->ring_size + 12);
>>>> -    ring->ent = ent;
>>>> +    debugfs_create_file_size(name, S_IFREG | S_IRUGO, root, ring,
>>>> +                 &amdgpu_debugfs_ring_fops,
>>>> +                 ring->ring_size + 12);
>>>>   #endif
>>>> -    return 0;
>>>>   }
>>>>     /**
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>> index 88d80eb3fea1..c29fbce0a5b4 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>> @@ -253,10 +253,6 @@ struct amdgpu_ring {
>>>>       bool            has_compute_vm_bug;
>>>>       bool            no_scheduler;
>>>>       int            hw_prio;
>>>> -
>>>> -#if defined(CONFIG_DEBUG_FS)
>>>> -    struct dentry *ent;
>>>> -#endif
>>>>   };
>>>>     #define amdgpu_ring_parse_cs(r, p, ib) 
>>>> ((r)->funcs->parse_cs((p), (ib)))
>>>> @@ -356,8 +352,6 @@ static inline void 
>>>> amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
>>>>     int amdgpu_ring_test_helper(struct amdgpu_ring *ring);
>>>>   -int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>>> +void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>>>                    struct amdgpu_ring *ring);
>>>> -void amdgpu_debugfs_ring_fini(struct amdgpu_ring *ring);
>>>> -
>>>>   #endif
>>>>
