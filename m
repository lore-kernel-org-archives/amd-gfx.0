Return-Path: <SRS0=CFUU=N4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8E1C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Sep 2021 16:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C07676101C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Sep 2021 16:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C07676101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F01C089B27;
	Mon,  6 Sep 2021 16:45:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A509189B20
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Sep 2021 16:45:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dO9OtMJ6Hm/ZJAdTiVbzT+nydBcI1dBWWOIz6b+OCWTb5zFI521Zfa9iydCPaNAeKbLHc95cVe9pKpgrU+cg9bl3THi9iaxfkC6V2TMAIOAXtiz3Ms0Pri2H4/iFhYM7CLQtlPuIh83cxRyRuLadOX5WHr9l6zF9APtWHU+8Ou4OVLT9/Uk7qu7x1OltD0snR2npT8OmU+uKgqfLMNu6GfW/F+rFplOLjIsulmBP5c6670x2mAGmi1rWZE1NbGmgnb91GE8dWUMrKLbK2RVtJdNnY+wN3Tpe06bKcUna4nkaoz8+FKBjWRVXrXq5+ZWWKPwQAHgsbewZ9U4d8oFUNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Y/Ob/4t6LyFqd7E9RgG/uVrKVf3r46zwaWOCdSWKRic=;
 b=cBCMFYpZJ6E7DksV+UgA2UYUEAdIfElyundDhUQSIH+bFCeTuzAwcRzDOoMxVkLesvpWQ498m6uANxuCpWSGdivU95sretCSyvpKAzN7S9SwtqNAzDDhO8f2TnKIxmnx//z033k5XEzVmD4CySx548P0TDmAHGuBY5KDTWdztXCEdvhZtdwOTRdAv5ROWdAX9FCK4kEsP9oYSj1QCouxlineegK8RHfNTctEdRf7zdVw50H8GSboXaK+sB96TJnefuaRnf8hyVhOrTbfkK+yJTDrlDr8wu6fAYtFzKru7OJIUkAJH0/CPHuTQLgP1F2fi9MMJ73kXZQgmhCZ48FKEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/Ob/4t6LyFqd7E9RgG/uVrKVf3r46zwaWOCdSWKRic=;
 b=En60WBoW2QU+FHXue9zCPOAlXfwKQB9eGuV1d5tjKVokn+c934MI75oOLS98msNP3C+O1hIrY0/8KKRgrs0FX1wTUN0vfd8/rGz9jfuewKwlLWTDM9htwAeGC6r3qhKpCiC2BG+Eq++uG65q1a6yOiuVBq675dR5YdzJvVJykJw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Mon, 6 Sep
 2021 16:45:33 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9c06:d113:293:f09b]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9c06:d113:293:f09b%8]) with mapi id 15.20.4478.025; Mon, 6 Sep 2021
 16:45:33 +0000
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
 <1b7ec90e-752a-3111-c226-25ec1d3c385f@amd.com>
 <0db529ef-e19f-550a-ae01-bed1a586765f@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
Message-ID: <2cc7ef01-0871-457c-6f85-6ac78220b3ff@amd.com>
Date: Mon, 6 Sep 2021 22:15:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <0db529ef-e19f-550a-ae01-bed1a586765f@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::24) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
Received: from [192.168.68.103] (106.51.20.251) by
 MAXPR01CA0106.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.17 via Frontend Transport; Mon, 6 Sep 2021 16:45:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3513ddf-aa11-40b3-3405-08d97155be4e
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB53115D302AE220D995FF211AF2D29@DM4PR12MB5311.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3nWZIC6OMrZYxV2+bkSO2lWsGnxpdpLVOunWFJ8fq090Z3xn2hI3gKQ2DuvLJuWgK7zujVM+AmCSMxULGZ9RQOA5SSTpfZxSdpjsiH+yUP68BNt04I8EddMNEfT3yPXmNVpZSI/34i8udgmh2THUhUGMO6EoHrsrlwy5Zgv61XseC0Yt1IzvgpGYooXbZaMrzSs8vAVzwXhHPfe+7yMI4TNHFODqUBr50CZ37h8WBDLeED/HZ6GWwJmwQQhsbWHjUcGf3nCbP0ewc3ArjDKIipbzbJKHAN9CSV2KdDjGmMGjpDeMDDH1JK9kkLwLQNx5DZoUt9uxbIh/FMJvruhsuS9g+ghneeaDCcpFB47j5OtnnI9V0b55SwOanEvXXgwrDEC8iIDC/n7HPQMQmISfo9fFggGlh6gbAGqtQdA4YwTJWavq6UyTKT9Ji1+hhX+QkWUyW2EfHvWsdkapnCWVSmTVOD2RfolyUeyKM7Cvfk+F09xEUIXOJjfSd1+iMAJfRJ27XA82gEp0qhyPYieb4g/GbMn1zZEK4UPC0BkuumF+weqUYcD9oHqhPy/raClsgVMmoDql27WVxRLUYNTqxJVpx6hrBFEI5/RnxFL7BO1qbM8kjASj9B3pZzJAHULTlD7Teson13ufLDGwmW85MzS15ziP7mrGXDRC6fQkM/EXq36usoPk5j4ZA5jOPJGDTeEq41nBrT5tASSYWiBEOuQ/jqkQ7xOfskdZ+GAupcY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(38100700002)(956004)(316002)(31696002)(26005)(53546011)(4326008)(55236004)(186003)(6486002)(86362001)(8676002)(8936002)(2906002)(83380400001)(66476007)(1006002)(66946007)(66556008)(5660300002)(6666004)(36756003)(2616005)(31686004)(16576012)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qy9aUjJWbGJJbWVNaEppY2JMQzlZdHFucVhJY1l5dWwwNVJ3MDNKQk5uK2Yy?=
 =?utf-8?B?OFJtTmNzNzl6M0g1M2ZPckx3Y3NRVFlzeTlDc1Y1WlVSR1JpbWR4UEM5U1pq?=
 =?utf-8?B?U2pVWjcxK0wwYkRSQVVzME5uc1UxV3BXL0ZWYitvYjhKS3dXYkZseU95TU1H?=
 =?utf-8?B?aTdwaUI1QndEbkV0ME9INnQ2UmtqcjBiK01oMXNIQUlGZXZZVVVaTlRGUGV3?=
 =?utf-8?B?aXV6eGR5cEg5STRhL0lOc0dWVzVkUXJoVmsvME9zZ3ZoUTVuMjI1N1kyZkxh?=
 =?utf-8?B?VUZFY042UExVMGRIWjl6SVRWcEc3b3hYaGcvTGhTdWxwL3NJQ1FIQkJkRmpH?=
 =?utf-8?B?bjg1clpiN2YxYThoVEswcHB6N1dYQVd0bWJibkNtdFVKd0JkK2h5dFFZV1Jx?=
 =?utf-8?B?OTJXZk8vQ21MdlNWT2RzVGZhM3draFFha2xRZVdnMXBKZ1hmMVR0L3ZTcVlB?=
 =?utf-8?B?cHJDMWtpRE9LbDdiZXpYbytNcThHNGdxZERtQXJkeCtlT3VJZlhCRStVTVVH?=
 =?utf-8?B?WVo4YnVpOGlEMHpCaEliRlRwTEpuNWlBODI4bkEzVTg5UFphSWRLYlNQbW9C?=
 =?utf-8?B?RnVkRTBCWXBzRHhWK1dpZC9qRTFyRGtPN3V0NEttN1FuWTdjaWVuckx6VnZF?=
 =?utf-8?B?KzVrVWVZemw0K0hNRU9WazQ0UzdQYS9aSmtiUEdUN0lFU3NlRlZVODl0U0NZ?=
 =?utf-8?B?SjdlSnpxTFlPand5c0pBM3ZoY2RUNk1Jb1dKLzhqK1lEZ01ackIxM3FVZnQ3?=
 =?utf-8?B?QVJaU1pEa2VoSUo0emFRRkwvWU44MVg2Wk12bmhRWWtsZ29RcjNBUUZsbE9r?=
 =?utf-8?B?OU9iY25HbWp4K2tMUTEycjdQSCsxUDdoc25uMkNQMjliVXphVmx3R2F2bk9I?=
 =?utf-8?B?Z21GTlRJOHkrUG5IaXhzSWxiTGtpNWhGM1Bkb3hjekpoaElyV1RLWVdmS29N?=
 =?utf-8?B?YWtKTWFIM005UHVIUXIzd01rWm1WM25oWmhGd1VQNU1aZ29LNHc5M0lOdWxh?=
 =?utf-8?B?V1hUMGJTanB3NWFXWkVaQW4rRThvbG9qcUl0d2p1azAyTmFwL0lmamlxNlBQ?=
 =?utf-8?B?ejNnQmhtd0FITkRIbDNDQTNaVm5vR2JQTkpmMnJyVTZheXB2dFQ2cCs2VS9S?=
 =?utf-8?B?NmVaT09DUndMUGd0VE1CT0hRSm1vWG9QVm1UZ2dwZm00QWZabXFwK2lwTXpQ?=
 =?utf-8?B?R1dpbjRNdU1iL1RoVnZ2L0xNU1BEVXR5MGtsSGhHcW0rejg4L2Y2SEJrc3JS?=
 =?utf-8?B?UVJSS2krZXVteExsRDdYNjh5VzIzbjRnRnFVRTVXbnVHWHp0YitzcytxUjBO?=
 =?utf-8?B?Rko0cThzeFNYejlRVXU1RVk0L2NzMyt1Zlh3Y1huN3lpT085QTVpN1lMbDJZ?=
 =?utf-8?B?dWxibXVMVDVZbmFQZmNuOW04WEtycE1TcWdidE9EKzlqSFpDd0tOMm8yaFVN?=
 =?utf-8?B?b0hqbFN2dUxqMVVLYnE3WnlXbWtoSWhOZUJ4bTZ4MklYVlJma3BSV2xBNG9O?=
 =?utf-8?B?dXlSaW5DUkltK1U1VzVXQjFSNXJ2d3Rjd1ExendDS3NrZ2dMTDI0ZGpQY0RV?=
 =?utf-8?B?SDdZc0JyTlhTRWZ1YmxUVVZETGh3NEp4VG52Skx1VERhaUlkdmJKTHpxdGVn?=
 =?utf-8?B?VGJIdStOZkdzc0pFbVVLN0YyNzVGK1dvSUdvS1VTWDB2dWFiQnArT3d3b2FQ?=
 =?utf-8?B?WTMvR0FMME42S3pzWk1GdzdOQStUb1BNT2FMK0FtOE1neXN6L0dqL2ZaTlIv?=
 =?utf-8?Q?tGwi6HiaxjDdReGLq7h4Uxo5yY/pfj7XIfe4Smz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3513ddf-aa11-40b3-3405-08d97155be4e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2021 16:45:33.0323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6O0zMa+XjUJvWVoN6gQJPlNyB8NeNlFsKHODQ9Siz2KnfQcvhZ1Tfvsotrsvgdm42rENF/rNPCYe50XNv/seAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5311
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



On 9/5/2021 5:01 PM, Das, Nirmoy wrote:
> 
> On 9/5/2021 10:03 AM, Sharma, Shashank wrote:
>>
>>
>> On 9/3/2021 9:44 PM, Das, Nirmoy wrote:
>>> Hi Shashank,
>>>
>>> On 9/3/2021 5:51 PM, Das, Nirmoy wrote:
>>>>
>>>> On 9/3/2021 5:26 PM, Sharma, Shashank wrote:
>>>>>
>>>>>
>>>>> On 9/3/2021 1:39 PM, Das, Nirmoy wrote:
>>>>>>
>>>>>> On 9/3/2021 8:36 AM, Sharma, Shashank wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 9/2/2021 5:14 PM, Nirmoy Das wrote:
>>>>>>>> Use debugfs_create_file_size API for creating ring debugfs
>>>>>>>> file, also cleanup surrounding code.
>>>>>>>>
>>>>>>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>>>>>>> ---
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  4 +---
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    | 16 +++++-----------
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  8 +-------
>>>>>>>>   3 files changed, 7 insertions(+), 21 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>>> index 077f9baf74fe..dee56ab19a8f 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>>> @@ -1734,9 +1734,7 @@ int amdgpu_debugfs_init(struct 
>>>>>>>> amdgpu_device *adev)
>>>>>>>>           if (!ring)
>>>>>>>>               continue;
>>>>>>>>   -        if (amdgpu_debugfs_ring_init(adev, ring)) {
>>>>>>>> -            DRM_ERROR("Failed to register debugfs file for 
>>>>>>>> rings !\n");
>>>>>>>> -        }
>>>>>>>> +        amdgpu_debugfs_ring_init(adev, ring);
>>>>>>>>       }
>>>>>>>>         amdgpu_ras_debugfs_create_all(adev);
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>>>>> index f40753e1a60d..968521d80514 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>>>>> @@ -415,26 +415,20 @@ static const struct file_operations 
>>>>>>>> amdgpu_debugfs_ring_fops = {
>>>>>>>>     #endif
>>>>>>>>   -int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>>>>>>> +void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>>>>>>>                    struct amdgpu_ring *ring)
>>>>>>>>   {
>>>>>>>>   #if defined(CONFIG_DEBUG_FS)
>>>>>>>>       struct drm_minor *minor = adev_to_drm(adev)->primary;
>>>>>>>> -    struct dentry *ent, *root = minor->debugfs_root;
>>>>>>>> +    struct dentry *root = minor->debugfs_root;
>>>>>>>>       char name[32];
>>>>>>>>         sprintf(name, "amdgpu_ring_%s", ring->name);
>>>>>>>>   -    ent = debugfs_create_file(name,
>>>>>>>> -                  S_IFREG | S_IRUGO, root,
>>>>>>>> -                  ring, &amdgpu_debugfs_ring_fops);
>>>>>>>> -    if (IS_ERR(ent))
>>>>>>>> -        return -ENOMEM;
>>>>>>>
>>>>>>> Why are we doing this ? Why to make it void from int ?
>>>>>>
>>>>>>
>>>>>> We tend to ignore debugfs return values as those are not serious 
>>>>>> errors. This to sync with rest of our
>>>>>>
>>>>>> debugfs calls.
>>>>>>
>>>>>>
>>>>>> Regards,
>>>>>>
>>>>>> Nirmoy
>>>>>>
>>>>>
>>>>>
>>>>> I am not suere if completely removing the provision of return value 
>>>>> is a good way of doing it, we can always ignore it at the caller 
>>>>> side, isn't it ?
>>>
>>>
>>>
>>> I just realized while making the change debugfs_create_file_size() is 
>>> void return, so we don't have anything useful to return in 
>>> amdgpu_debugfs_ring_init()
>>>
>>>
>>
>> Ah, it makes better sense now. Probably just a mention in the body of 
>> the message that we are moving from debugfs_create_file() to 
>> debugfs_create_file_size(), will make this change of return type more 
>> logical.
> 
> 
> Yes, I have that "Use debugfs_create_file_size API for creating ring 
> debugfs file,..."
> 
> 

My bad, I was too focused (and a bit confused due to uasge of clean-up) 
around the code change.

Suggestion for message: Use debugfs_create_file_size API for creating 
ring debugfs, and as its a NULL returning API, change the return type 
for amdgpu_debugfs_ring_init API as well.

With (or even without) this change, please feel free to use:

Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>

- Shashank

> Nirmoy
> 
>>
>> - Shashank
>>
>>> Regards,
>>>
>>> Nirmoy
>>>
>>>
>>>>
>>>>
>>>> Yes, we are currently throwing an error msg and ignoring it. I don't 
>>>> have a strong opinion regarding this, I will send a v2 restoring 
>>>> previous behavior.
>>>>
>>>>
>>>> Thanks,
>>>>
>>>> Nirmoy
>>>>
>>>>
>>>>>
>>>>> - Shashank
>>>>>
>>>>>>>
>>>>>>> - Shashank
>>>>>>>
>>>>>>>
>>>>>>>> -
>>>>>>>> -    i_size_write(ent->d_inode, ring->ring_size + 12);
>>>>>>>> -    ring->ent = ent;
>>>>>>>> +    debugfs_create_file_size(name, S_IFREG | S_IRUGO, root, ring,
>>>>>>>> +                 &amdgpu_debugfs_ring_fops,
>>>>>>>> +                 ring->ring_size + 12);
>>>>>>>>   #endif
>>>>>>>> -    return 0;
>>>>>>>>   }
>>>>>>>>     /**
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>>> index 88d80eb3fea1..c29fbce0a5b4 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>>> @@ -253,10 +253,6 @@ struct amdgpu_ring {
>>>>>>>>       bool            has_compute_vm_bug;
>>>>>>>>       bool            no_scheduler;
>>>>>>>>       int            hw_prio;
>>>>>>>> -
>>>>>>>> -#if defined(CONFIG_DEBUG_FS)
>>>>>>>> -    struct dentry *ent;
>>>>>>>> -#endif
>>>>>>>>   };
>>>>>>>>     #define amdgpu_ring_parse_cs(r, p, ib) 
>>>>>>>> ((r)->funcs->parse_cs((p), (ib)))
>>>>>>>> @@ -356,8 +352,6 @@ static inline void 
>>>>>>>> amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
>>>>>>>>     int amdgpu_ring_test_helper(struct amdgpu_ring *ring);
>>>>>>>>   -int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>>>>>>> +void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>>>>>>>                    struct amdgpu_ring *ring);
>>>>>>>> -void amdgpu_debugfs_ring_fini(struct amdgpu_ring *ring);
>>>>>>>> -
>>>>>>>>   #endif
>>>>>>>>
