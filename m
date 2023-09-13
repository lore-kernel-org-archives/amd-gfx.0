Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BE1EDEC5C
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 14:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB0B910E4A9;
	Wed, 13 Sep 2023 14:29:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB65510E471
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 14:29:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcnJbyMguKTB8O7DvrfJ4pKAp3KeXzGNWp67trKA0dgdU2MA4upGgFTnfupL6ZJdBAYT8BHnPCs72GuZ2OuGNiLpfeuJp4LDl7qGOJ4VRlZ8Y8OMZM35icERAgeNfjHbU81/uFBADD9cphhrCO6zpSo1Aetiv4uASKp0qaP1+hA5ZI4YMPttPF2fBaw4ev37RJPNUEpoENWsZZ8xzT3NgJilgeYYfBpmhh899H30V/CgrLAmprMg9PT7II73mNMA46EV7Sb4VkUcNoOPpceeKAHTaenRNuW3huqG0DK6DuPKA/soKtAj53tHfKmHeuSz9Qre2wYe8R1HIO6mkwsxgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PPqOQBLbjn1zP+dtzG1SMEXjur0VaHjK+TKQPEq/JA=;
 b=ASYykUhirwoKtpgr7zu8zY8XRa5pBiRYqrl1VR8/oQQ3NcuAbwtwmb8yVRzRF9VEbN60twSPt7/j36xS4PHmWuFwHckm5WUFsxyqZeQ2rSs5YekJ8DIGA6xm5nX22R/8Kwyoc9bYxIeGXTs4bN3cklHcWs3hXpHuh+kMKk9m5MEqX1aQGRypzexEV6hXY7TOljZjAXoFRKoXRjSxbSJTwKQqpgU3FkHEf1uMuRAPgCyR0MF9JL9Y534/v8ENun9XZmG/HkeRaxFOQwjZTGFI2aYWc+q/XMPovcGnfhb/nKkx7SfFgdcOwcyYunQe+MU7kwEAfXaf47LwU9LWrPGDRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PPqOQBLbjn1zP+dtzG1SMEXjur0VaHjK+TKQPEq/JA=;
 b=eFRYlckEpJOfLaeXaP4UDXJQQkXE12BCjyu31NKoNIGkk0ieXNYiYI1SJnAreAHm4m+BD+QrGwPiqhqcy4N3YxaMDWSMZqe3OukWs5RjSwF9w1sBowhEy0al1MgpFCTiTVxkxBRU3CreJfBw70nDcGd3+vKDAasgkJhSdbCmgME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL1PR12MB5778.namprd12.prod.outlook.com (2603:10b6:208:391::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Wed, 13 Sep
 2023 14:29:06 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::55cb:215b:389e:eced]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::55cb:215b:389e:eced%5]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 14:29:06 +0000
Content-Type: multipart/alternative;
 boundary="------------nSaMBpwA3tgnZ5VHU8rEWlzu"
Message-ID: <59d9927d-5216-e2fa-22cd-205e4a35ebaa@amd.com>
Date: Wed, 13 Sep 2023 16:28:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBkcm0vYW1kZ3B1OiBJZ25vcmUgZmly?=
 =?UTF-8?Q?st_evction_failure_during_suspend?=
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Wentland, Harry" <Harry.Wentland@amd.com>
References: <20230908033952.41872-1-xinhui.pan@amd.com>
 <9ee0c0b2-dbe8-7e47-cd64-d35b974861e3@gmail.com>
 <DM4PR12MB5165CCF46CDD5781D41920EE87F1A@DM4PR12MB5165.namprd12.prod.outlook.com>
 <55b144a2-ce60-4f37-e5d8-a25c3b5e21ef@gmail.com>
 <DM4PR12MB516574733B83A0F3F8451A5887F0A@DM4PR12MB5165.namprd12.prod.outlook.com>
 <303c2bbb-865c-d5da-1418-21dc803f61a3@gmail.com>
 <d9037d0e-e9fb-35f6-9e00-a2e1799bc2f6@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <d9037d0e-e9fb-35f6-9e00-a2e1799bc2f6@amd.com>
X-ClientProxiedBy: FR3P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BL1PR12MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d2bc2bc-0e50-47f9-2b4a-08dbb465c8f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: owHlvRXCngGmqQk5hdu00qbV7CVACaa/M07YjS12xyKcIMLrC8lOd+TR7DiPnRBd3cPv3DFy7c7BJkTxK2YbA+kPS6u5ecFY7Co9Uo8ex4ZJ/7nHBj9TDWZKlVT41gAy7qDOAqg0eficP/aDBK1kgvYiHUNJ/J+Cte6iLEogWywWKRpNOQsl3/E0HFaeqZnJuukWfKhNyQg/P3RiUSdkhL7Y1TySeea5tPQwQjjL8hFI5tMGTdyH6J1gTGT26lFygfj6rzs7dY1dmA5ZH8sNTRFnH/Q9rgG8bvmDFr5hcfraKslWeQPuzCu+CtAda8O6D+z9VqfD4izsj2w1lGhvKcxlTfFPa/2YujrJt2JHt/+893VlkclpSg8MAqT6CczmTpeiYXf0BDOyyDixtyraK8Qh/C7u3b8vF6pQ3ffiBv9sqe31905yV1ENfux+l/RTo6hyv4cH7li9ud4W9cULn/AQiH/nQBpWnRMupqsuD9jLwzibGT7IxUI2ziDZUKGUL+qAvBifFfO3zrsaOZomk8fe4nO91/kmDj4hRuiWJd1cu661I3NdDCcQJdeXIfsOiCgllVwa/17z8YPe/mTO0Mfi59k2JNYP6jWUEcUhGH4oHwng0j9Ew3+O7cPOqeWQU/SNdBHyGayUZyFm2od7Ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(396003)(136003)(366004)(346002)(186009)(451199024)(1800799009)(19627405001)(31686004)(33964004)(53546011)(6506007)(6666004)(6486002)(36756003)(41300700001)(31696002)(224303003)(38100700002)(86362001)(2616005)(26005)(4326008)(30864003)(15650500001)(66556008)(6512007)(2906002)(478600001)(83380400001)(66574015)(6636002)(54906003)(66476007)(110136005)(5660300002)(316002)(66946007)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUZEaTFnUGlOR3o4RFRxREFUNkF4aHB5UG1VNWJnbi94V2FoZXExYXhFOVNm?=
 =?utf-8?B?b0trK3VZOFZPTWxYbmlvamdzcXJuMzZib2wzTTZxWGQzWS90WEFDb0lyeUlm?=
 =?utf-8?B?Y3ViWHpDSnUvTUQ2VEp5T3FDUGFhOFhEVkJ1WEowS0NDVWhxTWFwNkduc1Ft?=
 =?utf-8?B?OGhTUTRsT1M5VGlkSUVYVmdPSG1uMVhzU2J2YTY3SnhiZ2k1Yk93dGtYNWlR?=
 =?utf-8?B?c2w0ODJNVCsxTGtkSGxBQWpqOFFQQld0NWpZbkZnblBwMXBMZVNGRlJRNFBW?=
 =?utf-8?B?Z2RYR3BreEZtRS9NK0V1VFhBeG1ZeUpNajM3Y3MyUmNKNlMzamVpdUx2Ynow?=
 =?utf-8?B?NmNRbGxOZ1hFVnAxL3hwZHhscUhEeGdBM0IxcmViWDVOa0VyVjlaUnVWOEVv?=
 =?utf-8?B?Q2ViV1FVYTYzSUJxZ2UrODNmVklnUUR2V1dzbGFhSU9pSFJJZDFGSkIxWnlC?=
 =?utf-8?B?YjV0bTVaemNFRWZENS9VTDdWWjFoeTFTZndLS0g5YzFNb2w4ZVdzOE1ZRS9U?=
 =?utf-8?B?S1hRazRpUjRMNCtqdjdKZnVhUDBQSm1EckJWeTA4OENDUkpaMVYwbzQ4cTZE?=
 =?utf-8?B?SDZEczFoeWtXY1Y3b1AyTWxYVWVNaHN6TjRkSWpyaWtjR0hacmx4QURHSkZQ?=
 =?utf-8?B?SHNQeDZYUklwZHc2SldzSEdkOVV1QzZ6OFJVbVhNSlJWM2JQS1NIMzB2b1hT?=
 =?utf-8?B?SzlVYU1MVTN1aHVaaVJPWFJWbzkrSExPbXY4MklIYURUazlvcjBVWDA0QkpE?=
 =?utf-8?B?MGNibG1YN280U2NmVVNQUUljL3F2SElWK2FKVGF5cXBqazJPcVk2aGtuNU1K?=
 =?utf-8?B?SnFVd0R3WnJyKy9JVjBuM09kRzlIWHRhWm16d2RzTXErdzBKZExrQlZHSC9r?=
 =?utf-8?B?Qy9HREJKTkZsTndYWndnSGVIYnZQYXBCclBqK0JzckxtbmRZVjN5bmNVaE5T?=
 =?utf-8?B?RzFYd05icmFHdmlyZi8vanlmV1RmdVF4a1B5c3JIbEM4TkxoV3JHQ05GeStq?=
 =?utf-8?B?VThFdUprYWFGbkd1elRXS3RrZGcwNnl0REZuYVhCZm1aMWV6ZGs3c1h2UGdr?=
 =?utf-8?B?aHU5MXM3TTc4d0YrS0RtT0IzOTFlalB2U2NZV0xSTlgwZ0VTb1pYSy93ZndZ?=
 =?utf-8?B?NGpHRHg3YkxVcnk0TGhTRHRXV1dWV3psMFNXOUVMb0JkNGJPdDZlTyt0cTRw?=
 =?utf-8?B?OFR4bTh4aUpFckZBTDFjVUppTklGejg4aGRHUlFOdEYvd3V4Q252djNkeXl1?=
 =?utf-8?B?Q3lFUnN3ekthZ0lRNU9xTnpsa2dJYVA3VU84ai96aFVBZ3FEVDB3S29tWDBQ?=
 =?utf-8?B?YUFYd3FKeWxOSWVZa3grNzFPWkpGSG8rQU5WdTUvOXR6anhQQjRMUWpTbUxx?=
 =?utf-8?B?VnpRWEs2QVpCMmc4OGtVWmxpL1JzR2xoTTAwSW1zekpJUmUzRlArK2FHRHF0?=
 =?utf-8?B?UlRsVW1wR3FzTzlYalY4UnNNK0lwWkV5akdudTVVTnNlUUdOSzFyTXdnMlgv?=
 =?utf-8?B?WWNnZ0hFNGNWYit5V0VWeVliZW5CVVpMcjRlSWZ0ai9IUml5VkJ1U3RhMHN1?=
 =?utf-8?B?WVBBRS91MjlxZUpjWG5ZbStBQk1uclhVcFhBblVPMG5sQkRjdlNiWEZMbnEz?=
 =?utf-8?B?SzdETVIzSVFpbmhmTHJUa2tOSjRyeHp5SXMrZ2wzb0lvaU1Nb2RoOEUwVEFx?=
 =?utf-8?B?N2U0TGJiTGRhS05tQTU0TlgvSVRvWWowWUExQ0NSV2xST2Q5VnM1UWlJOUM4?=
 =?utf-8?B?R0twOTg3ZWpMOUVoTnF3UnhieTZxUzNTbktZR2ZrZEM4OUUyUmN1dzc3NVZu?=
 =?utf-8?B?a0QwZXRpTytrc3RMOStacGd1b0U0VHRaay9tWVF0T0xKNTVNNWVyVCttT1N0?=
 =?utf-8?B?MjBkQVU1SFBGVk1Ob3pWNGlzZG9RV3BZbVA5Y3BjZEpxNTBTUjJMbjJuZTBY?=
 =?utf-8?B?L0w5aXc1dUtESlpDUW4zS09OUHdEMTJrOU15cks5L2FydmgrSnVBM2xRdkJo?=
 =?utf-8?B?Q3lWbUhGTWV1TUdKNHJ0Q3duVWc2dSsrMWtnbFVPRXJTTmtqZzFFQ1pseit4?=
 =?utf-8?B?aXp0bWpxOGNvaWVld09OYlpnWWdsV1VweWZuUTcyaXovaVRDUG1oU3lsdkVm?=
 =?utf-8?Q?VOqNYMPHm+sxFzHPs8+UuHY7F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2bc2bc-0e50-47f9-2b4a-08dbb465c8f1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 14:29:06.1036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ta5KSeHNpMg5cBr23e+fVbVD4GYoRmzD/WbpTV86f5M4OY59q8gSm2moDqXjSkBv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5778
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Fan,
 Shikang" <Shikang.Fan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------nSaMBpwA3tgnZ5VHU8rEWlzu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[+Harry]

Am 13.09.23 um 15:54 schrieb Felix Kuehling:
> On 2023-09-13 4:07, Christian König wrote:
>> [+Fleix]
>>
>> Well that looks like quite a serious bug.
>>
>> If I'm not completely mistaken the KFD work item tries to restore the 
>> process by moving BOs into memory even after the suspend freeze. 
>> Normally work items are frozen together with the user space processes 
>> unless explicitly marked as not freezable.
>>
>> That this causes problem during the first eviction phase is just the 
>> tip of the iceberg here. If a BO is moved into invisible memory 
>> during this we wouldn't be able to get it out of that in the second 
>> phase because SDMA and hw is already turned off.
>>
>> @Felix any idea how that can happen? Have you guys marked a work item 
>> / work queue as not freezable?
>
> We don't set anything to non-freezable in KFD.
>
>
> Regards,
>   Felix
>
>
>> Or maybe the display guys?

Do you guys in the display do any delayed update in a work item which is 
marked as not-freezable?

Otherwise I have absolutely no idea what's going on here.

Thanks,
Christian.

>>
>> @Xinhui please investigate what work item that is and where that is 
>> coming from. Something like "if (adev->in_suspend) dump_stack();" in 
>> the right place should probably do it.
>>
>> Thanks,
>> Christian.
>>
>> Am 13.09.23 um 07:13 schrieb Pan, Xinhui:
>>>
>>> [AMD Official Use Only - General]
>>>
>>>
>>> I notice that only user space process are frozen on my side.  
>>> kthread and workqueue keeps running. Maybe some kernel configs are 
>>> not enabled.
>>> I made one module which just prints something like i++ with mutex 
>>> lock both in workqueue and kthread. I paste some logs below.
>>> [438619.696196] XH: 14 from workqueue
>>> [438619.700193] XH: 15 from kthread
>>> [438620.394335] PM: suspend entry (deep)
>>> [438620.399619] Filesystems sync: 0.001 seconds
>>> [438620.403887] PM: Preparing system for sleep (deep)
>>> [438620.409299] Freezing user space processes
>>> [438620.414862] Freezing user space processes completed (elapsed 
>>> 0.001 seconds)
>>> [438620.421881] OOM killer disabled.
>>> [438620.425197] Freezing remaining freezable tasks
>>> [438620.430890] Freezing remaining freezable tasks completed 
>>> (elapsed 0.001 seconds)
>>> [438620.438348] PM: Suspending system (deep)
>>> .....
>>> [438623.746038] PM: suspend of devices complete after 3303.137 msecs
>>> [438623.752125] PM: start suspend of devices complete after 3309.713 
>>> msecs
>>> [438623.758722] PM: suspend debug: Waiting for 5 second(s).
>>> [438623.792166] XH: 22 from kthread
>>> [438623.824140] XH: 23 from workqueue
>>>
>>>
>>> So BOs definitely can be in use during suspend.
>>> Even if kthread or workqueue can be stopped with one special kernel 
>>> config. I think suspend can only stop the workqueue with its 
>>> callback finish.
>>> otherwise something like below makes things crazy.
>>> LOCK BO
>>> do something
>>>     -> schedule or wait, anycode might sleep.  Stopped by suspend 
>>> now? no, i think.
>>> UNLOCK BO
>>>
>>> I do tests  with  cmds below.
>>> echo devices  > /sys/power/pm_test
>>> echo 0  > /sys/power/pm_async
>>> echo 1  > /sys/power/pm_print_times
>>> echo 1 > /sys/power/pm_debug_messages
>>> echo 1 > /sys/module/amdgpu/parameters/debug_evictions
>>> ./kfd.sh --gtest_filter=KFDEvictTest.BasicTest
>>> pm-suspend
>>>
>>> thanks
>>> xinhui
>>>
>>>
>>> ------------------------------------------------------------------------
>>> *发件人:* Christian König <ckoenig.leichtzumerken@gmail.com>
>>> *发送时间:* 2023年9月12日 17:01
>>> *收件人:* Pan, Xinhui <Xinhui.Pan@amd.com>; 
>>> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>>> *抄送:* Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, 
>>> Christian <Christian.Koenig@amd.com>; Fan, Shikang <Shikang.Fan@amd.com>
>>> *主题:* Re: [PATCH] drm/amdgpu: Ignore first evction failure during 
>>> suspend
>>> When amdgpu_device_suspend() is called processes should be frozen
>>> already. In other words KFD queues etc... should already be idle.
>>>
>>> So when the eviction fails here we missed something previously and that
>>> in turn can cause tons amount of problems.
>>>
>>> So ignoring those errors is most likely not a good idea at all.
>>>
>>> Regards,
>>> Christian.
>>>
>>> Am 12.09.23 um 02:21 schrieb Pan, Xinhui:
>>> > [AMD Official Use Only - General]
>>> >
>>> > Oh yep, Pinned BO is moved to other LRU list, So eviction fails 
>>> because of other reason.
>>> > I will change the comments in the patch.
>>> > The problem is eviction fails as many reasons, say, BO is locked.
>>> > ASAIK, kfd will stop the queues and flush some evict/restore work 
>>> in its suspend callback. SO the first eviction before kfd callback 
>>> likely fails.
>>> >
>>> > -----Original Message-----
>>> > From: Christian König <ckoenig.leichtzumerken@gmail.com>
>>> > Sent: Friday, September 8, 2023 2:49 PM
>>> > To: Pan, Xinhui <Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org
>>> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, 
>>> Christian <Christian.Koenig@amd.com>; Fan, Shikang <Shikang.Fan@amd.com>
>>> > Subject: Re: [PATCH] drm/amdgpu: Ignore first evction failure 
>>> during suspend
>>> >
>>> > Am 08.09.23 um 05:39 schrieb xinhui pan:
>>> >> Some BOs might be pinned. So the first eviction's failure will abort
>>> >> the suspend sequence. These pinned BOs will be unpined afterwards
>>> >> during suspend.
>>> > That doesn't make much sense since pinned BOs don't cause eviction 
>>> failure here.
>>> >
>>> > What exactly is the error code you see?
>>> >
>>> > Christian.
>>> >
>>> >> Actaully it has evicted most BOs, so that should stil work fine in
>>> >> sriov full access mode.
>>> >>
>>> >> Fixes: 47ea20762bb7 ("drm/amdgpu: Add an extra evict_resource call
>>> >> during device_suspend.")
>>> >> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>>> >> ---
>>> >> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++----
>>> >>    1 file changed, 5 insertions(+), 4 deletions(-)
>>> >>
>>> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> >> index 5c0e2b766026..39af526cdbbe 100644
>>> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> >> @@ -4148,10 +4148,11 @@ int amdgpu_device_suspend(struct drm_device
>>> >> *dev, bool fbcon)
>>> >>
>>> >>        adev->in_suspend = true;
>>> >>
>>> >> -     /* Evict the majority of BOs before grabbing the full access */
>>> >> -     r = amdgpu_device_evict_resources(adev);
>>> >> -     if (r)
>>> >> -             return r;
>>> >> +     /* Try to evict the majority of BOs before grabbing the 
>>> full access
>>> >> +      * Ignore the ret val at first place as we will unpin some 
>>> BOs if any
>>> >> +      * afterwards.
>>> >> +      */
>>> >> + (void)amdgpu_device_evict_resources(adev);
>>> >>
>>> >>        if (amdgpu_sriov_vf(adev)) {
>>> >> amdgpu_virt_fini_data_exchange(adev);
>>>
>>

--------------nSaMBpwA3tgnZ5VHU8rEWlzu
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    [+Harry]<br>
    <br>
    <div class="moz-cite-prefix">Am 13.09.23 um 15:54 schrieb Felix
      Kuehling:<br>
    </div>
    <blockquote type="cite" cite="mid:d9037d0e-e9fb-35f6-9e00-a2e1799bc2f6@amd.com">
      
      <div class="moz-cite-prefix">On 2023-09-13 4:07, Christian König
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:303c2bbb-865c-d5da-1418-21dc803f61a3@gmail.com">
        [+Fleix]<br>
        <br>
        Well that looks like quite a serious bug.<br>
        <br>
        If I'm not completely mistaken the KFD work item tries to
        restore the process by moving BOs into memory even after the
        suspend freeze. Normally work items are frozen together with the
        user space processes unless explicitly marked as not freezable.<br>
        <br>
        That this causes problem during the first eviction phase is just
        the tip of the iceberg here. If a BO is moved into invisible
        memory during this we wouldn't be able to get it out of that in
        the second phase because SDMA and hw is already turned off.<br>
        <br>
        @Felix any idea how that can happen? Have you guys marked a work
        item / work queue as not freezable?</blockquote>
      <p>We don't set anything to non-freezable in KFD.</p>
      <p><br>
      </p>
      <p>Regards,<br>
        &nbsp; Felix<br>
      </p>
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:303c2bbb-865c-d5da-1418-21dc803f61a3@gmail.com"> Or
        maybe the display guys?<br>
      </blockquote>
    </blockquote>
    <br>
    Do you guys in the display do any delayed update in a work item
    which is marked as not-freezable?<br>
    <br>
    Otherwise I have absolutely no idea what's going on here.<br>
    <br>
    Thanks,<br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:d9037d0e-e9fb-35f6-9e00-a2e1799bc2f6@amd.com">
      <blockquote type="cite" cite="mid:303c2bbb-865c-d5da-1418-21dc803f61a3@gmail.com"> <br>
        @Xinhui please investigate what work item that is and where that
        is coming from. Something like &quot;if (adev-&gt;in_suspend)
        dump_stack();&quot; in the right place should probably do it.<br>
        <br>
        Thanks,<br>
        Christian.<br>
        <br>
        <div class="moz-cite-prefix">Am 13.09.23 um 07:13 schrieb Pan,
          Xinhui:<br>
        </div>
        <blockquote type="cite" cite="mid:DM4PR12MB516574733B83A0F3F8451A5887F0A@DM4PR12MB5165.namprd12.prod.outlook.com">
          <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
          <p style="font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left"> [AMD Official Use Only - General]<br>
          </p>
          <br>
          <div>
            <div style="font-family: Aptos, Aptos_EmbeddedFont,
              Aptos_MSFontService, Calibri, Helvetica, sans-serif;
              font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof"> I notice that only user space
              process are frozen on my side.&nbsp; kthread and workqueue&nbsp;
              keeps running. Maybe some kernel configs are not enabled.</div>
            <div style="font-family: Aptos, Aptos_EmbeddedFont,
              Aptos_MSFontService, Calibri, Helvetica, sans-serif;
              font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof"> I made one module which just
              prints something like i++ with mutex lock both in
              workqueue and kthread. I paste some logs below.</div>
            <div style="font-family: Aptos, Aptos_EmbeddedFont,
              Aptos_MSFontService, Calibri, Helvetica, sans-serif;
              font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof ContentPasted0"> [438619.696196] XH:
              14 from workqueue
              <div class="ContentPasted0">[438619.700193] XH: 15 from
                kthread</div>
              <div class="ContentPasted0">[438620.394335] PM: suspend
                entry (deep)</div>
              <div class="ContentPasted0">[438620.399619] Filesystems
                sync: 0.001 seconds</div>
              <div class="ContentPasted0">[438620.403887] PM: Preparing
                system for sleep (deep)</div>
              <div class="ContentPasted0">[438620.409299] Freezing user
                space processes</div>
              <div class="ContentPasted0">[438620.414862] Freezing user
                space processes completed (elapsed 0.001 seconds)</div>
              <div class="ContentPasted0">[438620.421881] OOM killer
                disabled.</div>
              <div class="ContentPasted0">[438620.425197] Freezing
                remaining freezable tasks</div>
              <div class="ContentPasted0">[438620.430890] Freezing
                remaining freezable tasks completed (elapsed 0.001
                seconds)</div>
              [438620.438348] PM: Suspending system (deep)<br>
            </div>
            <div style="font-family: Aptos, Aptos_EmbeddedFont,
              Aptos_MSFontService, Calibri, Helvetica, sans-serif;
              font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof"> .....</div>
            <div style="font-family: Aptos, Aptos_EmbeddedFont,
              Aptos_MSFontService, Calibri, Helvetica, sans-serif;
              font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof ContentPasted1"> [438623.746038] PM:
              suspend of devices complete after 3303.137 msecs
              <div class="ContentPasted1">[438623.752125] PM: start
                suspend of devices complete after 3309.713 msecs</div>
              <div class="ContentPasted1">[438623.758722] PM: suspend
                debug: Waiting for 5 second(s).</div>
              <div class="ContentPasted1">[438623.792166] XH: 22 from
                kthread</div>
              [438623.824140] XH: 23 from workqueue</div>
            <div style="font-family: Aptos, Aptos_EmbeddedFont,
              Aptos_MSFontService, Calibri, Helvetica, sans-serif;
              font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof ContentPasted1"> <br>
            </div>
            <div style="font-family: Aptos, Aptos_EmbeddedFont,
              Aptos_MSFontService, Calibri, Helvetica, sans-serif;
              font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof ContentPasted1"> <br>
            </div>
            <div style="font-family: Aptos, Aptos_EmbeddedFont,
              Aptos_MSFontService, Calibri, Helvetica, sans-serif;
              font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof ContentPasted1"> So BOs definitely
              can be in use during suspend.</div>
            <div style="font-family: Aptos, Aptos_EmbeddedFont,
              Aptos_MSFontService, Calibri, Helvetica, sans-serif;
              font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof ContentPasted1"> Even if kthread or
              workqueue can be stopped with one special kernel config. I
              think suspend can only stop the workqueue with its
              callback finish. <br>
            </div>
            <div style="font-family: Aptos, Aptos_EmbeddedFont,
              Aptos_MSFontService, Calibri, Helvetica, sans-serif;
              font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof ContentPasted1"> otherwise something
              like below makes things crazy.</div>
            <div style="font-family: Aptos, Aptos_EmbeddedFont,
              Aptos_MSFontService, Calibri, Helvetica, sans-serif;
              font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof ContentPasted1"> LOCK BO</div>
            <div style="font-family: Aptos, Aptos_EmbeddedFont,
              Aptos_MSFontService, Calibri, Helvetica, sans-serif;
              font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof ContentPasted1"> do something<br>
            </div>
            <div style="font-family: Aptos, Aptos_EmbeddedFont,
              Aptos_MSFontService, Calibri, Helvetica, sans-serif;
              font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof ContentPasted1"> &nbsp;&nbsp;&nbsp; -&gt; schedule
              or wait, anycode might sleep.&nbsp; Stopped by suspend now? no,
              i think.<br>
            </div>
            <div style="font-family: Aptos, Aptos_EmbeddedFont,
              Aptos_MSFontService, Calibri, Helvetica, sans-serif;
              font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof ContentPasted1"> UNLOCK BO<br>
            </div>
            <div style="font-family: Aptos, Aptos_EmbeddedFont,
              Aptos_MSFontService, Calibri, Helvetica, sans-serif;
              font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof"> <br>
            </div>
            <div style="font-family: Aptos, Aptos_EmbeddedFont,
              Aptos_MSFontService, Calibri, Helvetica, sans-serif;
              font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof"> I do tests&nbsp; with&nbsp; cmds below.<br>
            </div>
            <div style="font-family: Aptos, Aptos_EmbeddedFont,
              Aptos_MSFontService, Calibri, Helvetica, sans-serif;
              font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof ContentPasted2"> echo devices &nbsp;&gt;
              /sys/power/pm_test
              <div class="ContentPasted2">echo 0 &nbsp;&gt;
                /sys/power/pm_async</div>
              <div class="ContentPasted2">echo 1 &nbsp;&gt;
                /sys/power/pm_print_times</div>
              <div class="ContentPasted2">echo 1 &gt;
                /sys/power/pm_debug_messages</div>
              echo 1 &gt; /sys/module/amdgpu/parameters/debug_evictions</div>
            <div style="font-family: Aptos, Aptos_EmbeddedFont,
              Aptos_MSFontService, Calibri, Helvetica, sans-serif;
              font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof ContentPasted2 ContentPasted3">
              ./kfd.sh --gtest_filter=KFDEvictTest.BasicTest</div>
            <div style="font-family: Aptos, Aptos_EmbeddedFont,
              Aptos_MSFontService, Calibri, Helvetica, sans-serif;
              font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof ContentPasted2 ContentPasted3">
              pm-suspend<br>
            </div>
            <div style="font-family: Aptos, Aptos_EmbeddedFont,
              Aptos_MSFontService, Calibri, Helvetica, sans-serif;
              font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof ContentPasted2"> <br>
            </div>
            <div style="font-family: Aptos, Aptos_EmbeddedFont,
              Aptos_MSFontService, Calibri, Helvetica, sans-serif;
              font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof ContentPasted2"> thanks</div>
            <div style="font-family: Aptos, Aptos_EmbeddedFont,
              Aptos_MSFontService, Calibri, Helvetica, sans-serif;
              font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof ContentPasted2"> xinhui</div>
            <div style="font-family: Aptos, Aptos_EmbeddedFont,
              Aptos_MSFontService, Calibri, Helvetica, sans-serif;
              font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof ContentPasted2"> <br>
            </div>
            <div style="font-family: Aptos, Aptos_EmbeddedFont,
              Aptos_MSFontService, Calibri, Helvetica, sans-serif;
              font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof ContentPasted2"> <br>
            </div>
            <hr tabindex="-1" style="display:inline-block; width:98%">
            <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:
                11pt; color: rgb(0, 0, 0);" face="Calibri, sans-serif"><b>发件人:</b>
                Christian König <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
                <b>发送时间:</b> 2023年9月12日 17:01<br>
                <b>收件人:</b> Pan, Xinhui <a class="moz-txt-link-rfc2396E" href="mailto:Xinhui.Pan@amd.com" moz-do-not-send="true">&lt;Xinhui.Pan@amd.com&gt;</a>;
                <a class="moz-txt-link-abbreviated
                  moz-txt-link-freetext" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
                <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
                <b>抄送:</b> Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
                Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>;
                Fan, Shikang <a class="moz-txt-link-rfc2396E" href="mailto:Shikang.Fan@amd.com" moz-do-not-send="true">&lt;Shikang.Fan@amd.com&gt;</a><br>
                <b>主题:</b> Re: [PATCH] drm/amdgpu: Ignore first evction
                failure during suspend</font>
              <div>&nbsp;</div>
            </div>
            <div class="BodyFragment"><font size="2"><span style="font-size:11pt">
                  <div class="PlainText">When amdgpu_device_suspend() is
                    called processes should be frozen <br>
                    already. In other words KFD queues etc... should
                    already be idle.<br>
                    <br>
                    So when the eviction fails here we missed something
                    previously and that <br>
                    in turn can cause tons amount of problems.<br>
                    <br>
                    So ignoring those errors is most likely not a good
                    idea at all.<br>
                    <br>
                    Regards,<br>
                    Christian.<br>
                    <br>
                    Am 12.09.23 um 02:21 schrieb Pan, Xinhui:<br>
                    &gt; [AMD Official Use Only - General]<br>
                    &gt;<br>
                    &gt; Oh yep, Pinned BO is moved to other LRU list,
                    So eviction fails because of other reason.<br>
                    &gt; I will change the comments in the patch.<br>
                    &gt; The problem is eviction fails as many reasons,
                    say, BO is locked.<br>
                    &gt; ASAIK, kfd will stop the queues and flush some
                    evict/restore work in its suspend callback. SO the
                    first eviction before kfd callback likely fails.<br>
                    &gt;<br>
                    &gt; -----Original Message-----<br>
                    &gt; From: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
                    &gt; Sent: Friday, September 8, 2023 2:49 PM<br>
                    &gt; To: Pan, Xinhui <a class="moz-txt-link-rfc2396E" href="mailto:Xinhui.Pan@amd.com" moz-do-not-send="true">&lt;Xinhui.Pan@amd.com&gt;</a>;
                    <a class="moz-txt-link-abbreviated
                      moz-txt-link-freetext" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                    &gt; Cc: Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
                    Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>;
                    Fan, Shikang <a class="moz-txt-link-rfc2396E" href="mailto:Shikang.Fan@amd.com" moz-do-not-send="true">&lt;Shikang.Fan@amd.com&gt;</a><br>
                    &gt; Subject: Re: [PATCH] drm/amdgpu: Ignore first
                    evction failure during suspend<br>
                    &gt;<br>
                    &gt; Am 08.09.23 um 05:39 schrieb xinhui pan:<br>
                    &gt;&gt; Some BOs might be pinned. So the first
                    eviction's failure will abort<br>
                    &gt;&gt; the suspend sequence. These pinned BOs will
                    be unpined afterwards<br>
                    &gt;&gt; during suspend.<br>
                    &gt; That doesn't make much sense since pinned BOs
                    don't cause eviction failure here.<br>
                    &gt;<br>
                    &gt; What exactly is the error code you see?<br>
                    &gt;<br>
                    &gt; Christian.<br>
                    &gt;<br>
                    &gt;&gt; Actaully it has evicted most BOs, so that
                    should stil work fine in<br>
                    &gt;&gt; sriov full access mode.<br>
                    &gt;&gt;<br>
                    &gt;&gt; Fixes: 47ea20762bb7 (&quot;drm/amdgpu: Add an
                    extra evict_resource call<br>
                    &gt;&gt; during device_suspend.&quot;)<br>
                    &gt;&gt; Signed-off-by: xinhui pan <a class="moz-txt-link-rfc2396E" href="mailto:xinhui.pan@amd.com" moz-do-not-send="true">&lt;xinhui.pan@amd.com&gt;</a><br>
                    &gt;&gt; ---<br>
                    &gt;&gt;&nbsp;&nbsp;&nbsp;
                    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9
                    +++++----<br>
                    &gt;&gt;&nbsp;&nbsp;&nbsp; 1 file changed, 5 insertions(+), 4
                    deletions(-)<br>
                    &gt;&gt;<br>
                    &gt;&gt; diff --git
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                    &gt;&gt;
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                    &gt;&gt; index 5c0e2b766026..39af526cdbbe 100644<br>
                    &gt;&gt; ---
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                    &gt;&gt; +++
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                    &gt;&gt; @@ -4148,10 +4148,11 @@ int
                    amdgpu_device_suspend(struct drm_device<br>
                    &gt;&gt; *dev, bool fbcon)<br>
                    &gt;&gt;<br>
                    &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;in_suspend = true;<br>
                    &gt;&gt;<br>
                    &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Evict the majority of BOs before
                    grabbing the full access */<br>
                    &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; r =
                    amdgpu_device_evict_resources(adev);<br>
                    &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
                    &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
                    &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Try to evict the majority of BOs
                    before grabbing the full access<br>
                    &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Ignore the ret val at first place
                    as we will unpin some BOs if any<br>
                    &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * afterwards.<br>
                    &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
                    &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;
                    (void)amdgpu_device_evict_resources(adev);<br>
                    &gt;&gt;<br>
                    &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
                    &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    amdgpu_virt_fini_data_exchange(adev);<br>
                    <br>
                  </div>
                </span></font></div>
          </div>
        </blockquote>
        <br>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------nSaMBpwA3tgnZ5VHU8rEWlzu--
