Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81FBEDEC51
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 13:54:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5649910E4CC;
	Wed, 13 Sep 2023 13:54:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB69C10E4C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 13:54:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdbzvIq7wpVlN6VQkWUvzlfrP/tp+rx5EQ2uowxRH1vpkXOzLQFpQ3hrqwAxtWcBteCeOcLTPJ94OPMijLQVpigBT/2/SM3wZnb90W/jpRY5kM42K8b89ExHYbSd/oKj8SDE7bxjc8zShxC2gX6fyQIDCgvml71J3jtR0RN3EG1U0G2uGv74i+Qnu5CJuHxLupyS3hVj671BiB2u1ImTtBh1wCxnPuAX2wuXoXMFW+Vsd8Xi+I+g2kDHLwPQopIndgBIQw5QGoBCJLglPEdpZUVbGwvcbbGECfvSKkvSLB5f6M7ib0Ugejv9FeMLiM6YEJ0sH3csrzN/wNX8lQsaLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPMJeFTmbX5rCzlNXIcvqU3FhMqjWJiAquzPQ68PJpE=;
 b=JcLQxMMiGOUR+46reSVldeQIbQWP3OUGsSGNkaE4WmbdHNmZDMPtGUQnScCXaE3GNcCFG6t8bI+kFTgcu6wvYE9CrbzGw2yp/5ZIJSygUbOZ9ALJTE2+UY+mtkeoAruErwWg4FmtS1LTtgLEZKk0BwJhGsBST8tHj8+dXyVazTiSC1uD+NtEsTf4pB679K/i8AfSaiww74wg6C0H5sAUJB3cFoxYmgxzAMES7jJwnADz4UYDD1jTEPwqQhcD1jz9T+KDNvzapvyePHFzNtXWIJ9dA8jNUgKn22jqtG3T+XeZIqhdOXADFsovq12Iu+/7AeWxI0BQvP3dGQqJ75pMzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPMJeFTmbX5rCzlNXIcvqU3FhMqjWJiAquzPQ68PJpE=;
 b=iec/qjMLJOkM7LjV/owrmUuPYMmhvgxlRvymr59PyGCyGOMslzK7kkrBya2n6gbHQmKTQC0MzZcqrIBSaTQLIThNcwa14OU9rkSJQa44KZL+dA5JvsEEqhM47DmHWfTtRGAzlAgfv1fZBhxp8y6C4yVj3+gSTQqGnj7LK8Q33Sw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.27; Wed, 13 Sep 2023 13:54:35 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010%6]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 13:54:35 +0000
Content-Type: multipart/alternative;
 boundary="------------dzjtrEF2Q3w5WyymERAFffBP"
Message-ID: <d9037d0e-e9fb-35f6-9e00-a2e1799bc2f6@amd.com>
Date: Wed, 13 Sep 2023 09:54:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBkcm0vYW1kZ3B1OiBJZ25vcmUgZmly?=
 =?UTF-8?Q?st_evction_failure_during_suspend?=
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230908033952.41872-1-xinhui.pan@amd.com>
 <9ee0c0b2-dbe8-7e47-cd64-d35b974861e3@gmail.com>
 <DM4PR12MB5165CCF46CDD5781D41920EE87F1A@DM4PR12MB5165.namprd12.prod.outlook.com>
 <55b144a2-ce60-4f37-e5d8-a25c3b5e21ef@gmail.com>
 <DM4PR12MB516574733B83A0F3F8451A5887F0A@DM4PR12MB5165.namprd12.prod.outlook.com>
 <303c2bbb-865c-d5da-1418-21dc803f61a3@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <303c2bbb-865c-d5da-1418-21dc803f61a3@gmail.com>
X-ClientProxiedBy: YT4PR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS7PR12MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: e1ba55d2-15fd-4632-9a6f-08dbb460f6c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LY56nhKLv8rN/7QwYoshpJsx1r/7zIT8jGiuxK7fzDv8Sd4mL6A7pRIanKc9/VqzuLJB5RLW+Q1IGz9/NXV1MznkhXzOlK/lai3gcH+ShKpSqxKx1mSc8wV092hoYYcGuw3DcWwLiWSItWvjGgdUKaibK18ukkGjkYgR+OqJ7jOLR83A7pZ1uSwg5XAka2MQXm3brdUvXGnTmU8/C9GKwWujQ9p29K36g2IwzXoCMiBsPvWloXtJXtwoolpFHDyUwpBAgp956JAE0w8yFHYW0UdNFNsZ6Vxi7hrz1+U2D9j1agqpMYX1YJm6oHJPeui4Ud+GEBxP/qxcHSq8XKhV30FF5LtnFbtkkenVgE75VTS9R7DbLK3fqjQR+jnAOXlL9CqPRgL5GTNv1mea6xz6xRLp88oB8YkwpkjO707/EAakzMx1bC4JTl0QyWeVL5nnUxoIIcUk6bMg/LbFgknM5SdSZ2SK0jG5OOCseVLGJIH/yxXljzHbtD24pgxLEGc0InYK4AgyFlJNtKRYI6HSj3pIzck9tMTH+2Oom2OUuTN/P5LgtIO0hplqHE94FP9N9+HXet21dW6K+NtUtD0i44aPPsm9gAvdcUbtuvxWu6gvYQtUootdpJ/BpCuiD82mwn9NgJSYIznSPxFG6qUBgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(376002)(136003)(366004)(39860400002)(186009)(451199024)(1800799009)(66574015)(2616005)(36756003)(26005)(53546011)(33964004)(6486002)(6506007)(6512007)(224303003)(8936002)(44832011)(5660300002)(4326008)(110136005)(66946007)(41300700001)(54906003)(66476007)(316002)(66556008)(2906002)(31696002)(38100700002)(15650500001)(478600001)(86362001)(30864003)(83380400001)(19627405001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjBQQVV3d0ZnSGh5NDdac0IxZXNEMUFmbkFQZjlsTHpZVUI3K0hkQ0JrRzVC?=
 =?utf-8?B?ZTBWSDc3cHpuNU1peUsxbXJSaWE2RHdFL1d6bUNhZFlzY1BtYmFRQ0FBa3J6?=
 =?utf-8?B?SXpWR29kM3dqWlp5K29lYWpaeXBnMWdVVmF4c1E4VnRZaGdXRnRHRTdyQzZO?=
 =?utf-8?B?QVNmeHpwNUlEVW9tQWlkb3ZqbWRLQmh5Q3VSc3hnYktKTHQxdmNrSkhLMWZV?=
 =?utf-8?B?RVpXUFBKTmsrdUN1QUZROVZjclpSZHlad3VtVzkzNklxOHUwV2RUVGE5YkJC?=
 =?utf-8?B?aEE5alVXZ1ZVRDNFRDFvaFdFazZ4YmFkVC9qVTNqSWFicHU3dE5EWXJ2bTRv?=
 =?utf-8?B?SWtacXRHZ0lZYVpEZVpWcTZjRjMwY2pza0pXRUFZczZqa3ppUzZrZEhqZUpB?=
 =?utf-8?B?a0ZWQWpielE2c3Nvd1gwOVNGcWs5MDNYeUJrTWRTa3RXR3ZUK1Z6NS9XelIy?=
 =?utf-8?B?WTVmNjFNUWR0cXJnRFNBSGp6MFlOdjRlQnpSTWlQMTlncC9Ud200eDFZMFNS?=
 =?utf-8?B?ZEgyaUZXa1VFVlVnRjMyUVEyWEpRbk1vbFpRckZFMmFyMC96VFFMMzZ5YUdL?=
 =?utf-8?B?ZUcrNWEzQ0pMQUdJVjlQakZaZnVXczJiaVJ1dnNUalVJKzR3bTJTbUNsektC?=
 =?utf-8?B?UXo1bHVPVU5odytwdS9Cemw1Sk0yN21IVlhlMHBWbncrM2JpQ044S0FCL3Z6?=
 =?utf-8?B?aWhUT043aFBmL3R1a3ZHcWtIVFpmTm5jOWNQT1U5M3g2YzlpeWV2eWx2Sjhm?=
 =?utf-8?B?cVB0K1EvWDVqeTJiT0Y1WGFPM1lITDQ5WFR1U1JPWDRPVnYwMlB6Ly9kejM1?=
 =?utf-8?B?Wk9pampHTU9NejZJR3V2eHNCYWZ6VWZ6SXhmK2swUGtYdGI0UFNMNmdYM1VS?=
 =?utf-8?B?cklscjZIenN2M242NHNXVHpPdWdBK25leVlJMnF3VVR3N1dlZUpKOUxCWE5K?=
 =?utf-8?B?c3hZK3dHcUNydHVseTF6Qm5hN1F0cDRLMGdvZS9pVnJ3OEEwQ2ljZkdFSzY4?=
 =?utf-8?B?MnY0Skd2ZXBxK2cydk5rZEswSWNXeTFsaitSano2Y3dtUmNWUkZpTEVPUnJO?=
 =?utf-8?B?OGNzK0czdGpONjJSL2xETm9RT0x5bjRKRjM2Sk5qdEF3bGZpV2F2aXMzUEFs?=
 =?utf-8?B?bWRlbXhmWG5LcEY1aWsvbVUxQmxoT1VhSnh3bUdYZFpzbDVFTXAwT3VlTENL?=
 =?utf-8?B?b2orNGVIZ2NCRWJqYk5TdGh6YlVPbjBYdnBqNGdSSFB3c2o4elhDdzZsYXVX?=
 =?utf-8?B?WE5wUWN5VEZrYisxdjhwWndoc2trVG5nVDA3MmE0RmlqNTMyR2FtMHZ1anhS?=
 =?utf-8?B?YlZKVVFQNVpaNTFHRExwbnAxV0Q5ZGNQMmE4V1daVXdFWnh0M2NOdEJCMTl3?=
 =?utf-8?B?WkNJVFZMbURYbzJ6RVMwTUs3M2R4TTkrcFJZdmlLa0ZsUzdkVFIxUnZqRmRl?=
 =?utf-8?B?eWhxV1EwZTFEbGZoVEk5YlNIZDBjMjJ5WmxnT0xJYTVQMGZMWUZnYUEwdW5o?=
 =?utf-8?B?Nk5ycnJkUms2SjhiYklhaTAzL3pHcXIzR1lDQkdIVGMrNDByK0FMSjhMZDJO?=
 =?utf-8?B?eStkYVdjRStwV29UczcwMEhZdlJHWnBocHlvMG8yL3R5cTVQSkczRnJvZjhu?=
 =?utf-8?B?dVE4b3F6d0plb3JtM1llVWkrY1lQbE40Qk5QWHhVZ1N4WGNZREtxd1BzdFIx?=
 =?utf-8?B?cXdsOG9ObFhZamZjWXIzTVZZR3NRamcxMStycTFnS216RjY1UXV0NXVFTnoy?=
 =?utf-8?B?MEs4Q3J1M0JEV2w5TlhKbTdqWHhpR2owS3NzV1RaQis5UFRLMlUxSEc5eVBM?=
 =?utf-8?B?aDBpZUVVRzB1eUlTVjFyN3hsS3hyZTdEcmczQ2phb2swaDlLTEx4dHpYa2JJ?=
 =?utf-8?B?TXJHWEpOeTlZNjZIZ0ZGZHhPZmRUSUozMTMvL2VpTkhla2MzbkJ3RlNKTEpy?=
 =?utf-8?B?ajkxdzVyNm5jdVpYOE1ieVZHK2FodHdFeE00VTFsR3M4WmdiTEZJSHhGRk1X?=
 =?utf-8?B?M0hjejdNS3ZCQVN1alNYYzlldURFVk52amJjRUpYOUFiajZUTE5MTDRTWFNJ?=
 =?utf-8?B?WGxQMDcwNFVHOU9EQlpCeHNyWUhobVhWN3ZDZ0s3c1BReStxQWxEYmtxMU1G?=
 =?utf-8?Q?LdjR7PkMvNbS5YUMJ0SEyw+b6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ba55d2-15fd-4632-9a6f-08dbb460f6c7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 13:54:35.4484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVlDcthNesbO3Bt1tq6ZbgYHcjK0a9HX2NZARmmR5WYzK4AmqtThGbOdJULJ2+k8Y/0bC5QUujleIVJ0rrOEkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5741
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Fan, Shikang" <Shikang.Fan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------dzjtrEF2Q3w5WyymERAFffBP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023-09-13 4:07, Christian König wrote:
> [+Fleix]
>
> Well that looks like quite a serious bug.
>
> If I'm not completely mistaken the KFD work item tries to restore the 
> process by moving BOs into memory even after the suspend freeze. 
> Normally work items are frozen together with the user space processes 
> unless explicitly marked as not freezable.
>
> That this causes problem during the first eviction phase is just the 
> tip of the iceberg here. If a BO is moved into invisible memory during 
> this we wouldn't be able to get it out of that in the second phase 
> because SDMA and hw is already turned off.
>
> @Felix any idea how that can happen? Have you guys marked a work item 
> / work queue as not freezable?

We don't set anything to non-freezable in KFD.


Regards,
   Felix


> Or maybe the display guys?
>
> @Xinhui please investigate what work item that is and where that is 
> coming from. Something like "if (adev->in_suspend) dump_stack();" in 
> the right place should probably do it.
>
> Thanks,
> Christian.
>
> Am 13.09.23 um 07:13 schrieb Pan, Xinhui:
>>
>> [AMD Official Use Only - General]
>>
>>
>> I notice that only user space process are frozen on my side.  kthread 
>> and workqueue  keeps running. Maybe some kernel configs are not enabled.
>> I made one module which just prints something like i++ with mutex 
>> lock both in workqueue and kthread. I paste some logs below.
>> [438619.696196] XH: 14 from workqueue
>> [438619.700193] XH: 15 from kthread
>> [438620.394335] PM: suspend entry (deep)
>> [438620.399619] Filesystems sync: 0.001 seconds
>> [438620.403887] PM: Preparing system for sleep (deep)
>> [438620.409299] Freezing user space processes
>> [438620.414862] Freezing user space processes completed (elapsed 
>> 0.001 seconds)
>> [438620.421881] OOM killer disabled.
>> [438620.425197] Freezing remaining freezable tasks
>> [438620.430890] Freezing remaining freezable tasks completed (elapsed 
>> 0.001 seconds)
>> [438620.438348] PM: Suspending system (deep)
>> .....
>> [438623.746038] PM: suspend of devices complete after 3303.137 msecs
>> [438623.752125] PM: start suspend of devices complete after 3309.713 
>> msecs
>> [438623.758722] PM: suspend debug: Waiting for 5 second(s).
>> [438623.792166] XH: 22 from kthread
>> [438623.824140] XH: 23 from workqueue
>>
>>
>> So BOs definitely can be in use during suspend.
>> Even if kthread or workqueue can be stopped with one special kernel 
>> config. I think suspend can only stop the workqueue with its callback 
>> finish.
>> otherwise something like below makes things crazy.
>> LOCK BO
>> do something
>>     -> schedule or wait, anycode might sleep.  Stopped by suspend 
>> now? no, i think.
>> UNLOCK BO
>>
>> I do tests  with  cmds below.
>> echo devices  > /sys/power/pm_test
>> echo 0  > /sys/power/pm_async
>> echo 1  > /sys/power/pm_print_times
>> echo 1 > /sys/power/pm_debug_messages
>> echo 1 > /sys/module/amdgpu/parameters/debug_evictions
>> ./kfd.sh --gtest_filter=KFDEvictTest.BasicTest
>> pm-suspend
>>
>> thanks
>> xinhui
>>
>>
>> ------------------------------------------------------------------------
>> *发件人:* Christian König <ckoenig.leichtzumerken@gmail.com>
>> *发送时间:* 2023年9月12日 17:01
>> *收件人:* Pan, Xinhui <Xinhui.Pan@amd.com>; 
>> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>> *抄送:* Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, 
>> Christian <Christian.Koenig@amd.com>; Fan, Shikang <Shikang.Fan@amd.com>
>> *主题:* Re: [PATCH] drm/amdgpu: Ignore first evction failure during 
>> suspend
>> When amdgpu_device_suspend() is called processes should be frozen
>> already. In other words KFD queues etc... should already be idle.
>>
>> So when the eviction fails here we missed something previously and that
>> in turn can cause tons amount of problems.
>>
>> So ignoring those errors is most likely not a good idea at all.
>>
>> Regards,
>> Christian.
>>
>> Am 12.09.23 um 02:21 schrieb Pan, Xinhui:
>> > [AMD Official Use Only - General]
>> >
>> > Oh yep, Pinned BO is moved to other LRU list, So eviction fails 
>> because of other reason.
>> > I will change the comments in the patch.
>> > The problem is eviction fails as many reasons, say, BO is locked.
>> > ASAIK, kfd will stop the queues and flush some evict/restore work 
>> in its suspend callback. SO the first eviction before kfd callback 
>> likely fails.
>> >
>> > -----Original Message-----
>> > From: Christian König <ckoenig.leichtzumerken@gmail.com>
>> > Sent: Friday, September 8, 2023 2:49 PM
>> > To: Pan, Xinhui <Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org
>> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, 
>> Christian <Christian.Koenig@amd.com>; Fan, Shikang <Shikang.Fan@amd.com>
>> > Subject: Re: [PATCH] drm/amdgpu: Ignore first evction failure 
>> during suspend
>> >
>> > Am 08.09.23 um 05:39 schrieb xinhui pan:
>> >> Some BOs might be pinned. So the first eviction's failure will abort
>> >> the suspend sequence. These pinned BOs will be unpined afterwards
>> >> during suspend.
>> > That doesn't make much sense since pinned BOs don't cause eviction 
>> failure here.
>> >
>> > What exactly is the error code you see?
>> >
>> > Christian.
>> >
>> >> Actaully it has evicted most BOs, so that should stil work fine in
>> >> sriov full access mode.
>> >>
>> >> Fixes: 47ea20762bb7 ("drm/amdgpu: Add an extra evict_resource call
>> >> during device_suspend.")
>> >> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>> >> ---
>> >>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++----
>> >>    1 file changed, 5 insertions(+), 4 deletions(-)
>> >>
>> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> >> index 5c0e2b766026..39af526cdbbe 100644
>> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> >> @@ -4148,10 +4148,11 @@ int amdgpu_device_suspend(struct drm_device
>> >> *dev, bool fbcon)
>> >>
>> >>        adev->in_suspend = true;
>> >>
>> >> -     /* Evict the majority of BOs before grabbing the full access */
>> >> -     r = amdgpu_device_evict_resources(adev);
>> >> -     if (r)
>> >> -             return r;
>> >> +     /* Try to evict the majority of BOs before grabbing the full 
>> access
>> >> +      * Ignore the ret val at first place as we will unpin some 
>> BOs if any
>> >> +      * afterwards.
>> >> +      */
>> >> + (void)amdgpu_device_evict_resources(adev);
>> >>
>> >>        if (amdgpu_sriov_vf(adev)) {
>> >> amdgpu_virt_fini_data_exchange(adev);
>>
>
--------------dzjtrEF2Q3w5WyymERAFffBP
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2023-09-13 4:07, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:303c2bbb-865c-d5da-1418-21dc803f61a3@gmail.com">
      
      [+Fleix]<br>
      <br>
      Well that looks like quite a serious bug.<br>
      <br>
      If I'm not completely mistaken the KFD work item tries to restore
      the process by moving BOs into memory even after the suspend
      freeze. Normally work items are frozen together with the user
      space processes unless explicitly marked as not freezable.<br>
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
      <br>
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
            process are frozen on my side.&nbsp; kthread and workqueue&nbsp; keeps
            running. Maybe some kernel configs are not enabled.</div>
          <div style="font-family: Aptos, Aptos_EmbeddedFont,
            Aptos_MSFontService, Calibri, Helvetica, sans-serif;
            font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof"> I made one module which just prints
            something like i++ with mutex lock both in workqueue and
            kthread. I paste some logs below.</div>
          <div style="font-family: Aptos, Aptos_EmbeddedFont,
            Aptos_MSFontService, Calibri, Helvetica, sans-serif;
            font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
            ContentPasted0"> [438619.696196] XH: 14 from workqueue
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
            font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
            ContentPasted1"> [438623.746038] PM: suspend of devices
            complete after 3303.137 msecs
            <div class="ContentPasted1">[438623.752125] PM: start
              suspend of devices complete after 3309.713 msecs</div>
            <div class="ContentPasted1">[438623.758722] PM: suspend
              debug: Waiting for 5 second(s).</div>
            <div class="ContentPasted1">[438623.792166] XH: 22 from
              kthread</div>
            [438623.824140] XH: 23 from workqueue</div>
          <div style="font-family: Aptos, Aptos_EmbeddedFont,
            Aptos_MSFontService, Calibri, Helvetica, sans-serif;
            font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
            ContentPasted1"> <br>
          </div>
          <div style="font-family: Aptos, Aptos_EmbeddedFont,
            Aptos_MSFontService, Calibri, Helvetica, sans-serif;
            font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
            ContentPasted1"> <br>
          </div>
          <div style="font-family: Aptos, Aptos_EmbeddedFont,
            Aptos_MSFontService, Calibri, Helvetica, sans-serif;
            font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
            ContentPasted1"> So BOs definitely can be in use during
            suspend.</div>
          <div style="font-family: Aptos, Aptos_EmbeddedFont,
            Aptos_MSFontService, Calibri, Helvetica, sans-serif;
            font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
            ContentPasted1"> Even if kthread or workqueue can be stopped
            with one special kernel config. I think suspend can only
            stop the workqueue with its callback finish. <br>
          </div>
          <div style="font-family: Aptos, Aptos_EmbeddedFont,
            Aptos_MSFontService, Calibri, Helvetica, sans-serif;
            font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
            ContentPasted1"> otherwise something like below makes things
            crazy.</div>
          <div style="font-family: Aptos, Aptos_EmbeddedFont,
            Aptos_MSFontService, Calibri, Helvetica, sans-serif;
            font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
            ContentPasted1"> LOCK BO</div>
          <div style="font-family: Aptos, Aptos_EmbeddedFont,
            Aptos_MSFontService, Calibri, Helvetica, sans-serif;
            font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
            ContentPasted1"> do something<br>
          </div>
          <div style="font-family: Aptos, Aptos_EmbeddedFont,
            Aptos_MSFontService, Calibri, Helvetica, sans-serif;
            font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
            ContentPasted1"> &nbsp;&nbsp;&nbsp; -&gt; schedule or wait, anycode might
            sleep.&nbsp; Stopped by suspend now? no, i think.<br>
          </div>
          <div style="font-family: Aptos, Aptos_EmbeddedFont,
            Aptos_MSFontService, Calibri, Helvetica, sans-serif;
            font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
            ContentPasted1"> UNLOCK BO<br>
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
            font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
            ContentPasted2"> echo devices &nbsp;&gt; /sys/power/pm_test
            <div class="ContentPasted2">echo 0 &nbsp;&gt; /sys/power/pm_async</div>
            <div class="ContentPasted2">echo 1 &nbsp;&gt;
              /sys/power/pm_print_times</div>
            <div class="ContentPasted2">echo 1 &gt;
              /sys/power/pm_debug_messages</div>
            echo 1 &gt; /sys/module/amdgpu/parameters/debug_evictions</div>
          <div style="font-family: Aptos, Aptos_EmbeddedFont,
            Aptos_MSFontService, Calibri, Helvetica, sans-serif;
            font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
            ContentPasted2 ContentPasted3"> ./kfd.sh
            --gtest_filter=KFDEvictTest.BasicTest</div>
          <div style="font-family: Aptos, Aptos_EmbeddedFont,
            Aptos_MSFontService, Calibri, Helvetica, sans-serif;
            font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
            ContentPasted2 ContentPasted3"> pm-suspend<br>
          </div>
          <div style="font-family: Aptos, Aptos_EmbeddedFont,
            Aptos_MSFontService, Calibri, Helvetica, sans-serif;
            font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
            ContentPasted2"> <br>
          </div>
          <div style="font-family: Aptos, Aptos_EmbeddedFont,
            Aptos_MSFontService, Calibri, Helvetica, sans-serif;
            font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
            ContentPasted2"> thanks</div>
          <div style="font-family: Aptos, Aptos_EmbeddedFont,
            Aptos_MSFontService, Calibri, Helvetica, sans-serif;
            font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
            ContentPasted2"> xinhui</div>
          <div style="font-family: Aptos, Aptos_EmbeddedFont,
            Aptos_MSFontService, Calibri, Helvetica, sans-serif;
            font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
            ContentPasted2"> <br>
          </div>
          <div style="font-family: Aptos, Aptos_EmbeddedFont,
            Aptos_MSFontService, Calibri, Helvetica, sans-serif;
            font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
            ContentPasted2"> <br>
          </div>
          <hr tabindex="-1" style="display:inline-block; width:98%">
          <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:
              11pt; color: rgb(0, 0, 0);" face="Calibri, sans-serif"><b>发件人:</b>
              Christian König <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
              <b>发送时间:</b> 2023年9月12日 17:01<br>
              <b>收件人:</b> Pan, Xinhui <a class="moz-txt-link-rfc2396E" href="mailto:Xinhui.Pan@amd.com" moz-do-not-send="true">&lt;Xinhui.Pan@amd.com&gt;</a>;
              <a class="moz-txt-link-abbreviated moz-txt-link-freetext" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
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
                  &gt; Oh yep, Pinned BO is moved to other LRU list, So
                  eviction fails because of other reason.<br>
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
                  &gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                  | 9 +++++----<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp; 1 file changed, 5 insertions(+), 4
                  deletions(-)<br>
                  &gt;&gt;<br>
                  &gt;&gt; diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                  &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
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
                  &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Ignore the ret val at first place as
                  we will unpin some BOs if any<br>
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
  </body>
</html>

--------------dzjtrEF2Q3w5WyymERAFffBP--
