Return-Path: <SRS0=UsYE=JJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FB3C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 18:05:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F41961289
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 18:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F41961289
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD39A89E5F;
	Mon, 12 Apr 2021 18:05:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37A0489E65
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Apr 2021 18:05:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXO/x6IeZRNPc5FE/h7tZjiX8v1GE/BhdWVYhsxommmTWS7cbEBnadsTIwmqFnMhuwUn2BCWDRZ3u9ZTbRiE1sHGA3QsYNjPd+lOcDFvN8Ig7mvSnmD3TDWSrnlz7mhPYnoQYbjZBfKMuMsPQXknQfmD08XBgAVxgJ5PlySels90IHbLfwhlaJXzc+XjOmhVsHSr6ZBc6isvP8P3RSV8OPwuA3ynWxdO2NQDsFkcRikerMfD4zi9C1leY4mmjZph59ekKf0VqAfgLu3OpJ+AGtoeTKJnSAZN6DPWimWv6DckyOz9o35vxz7xUT5+D3ygS7dPqFEGtQtm21/HRk5KnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfD1aQmqe+JhsbnWR9Rav7u+tCyqw71tH6vtpQTGGwU=;
 b=mceD+aoX/xvNqG3pMVGLr2HJIoJavDu7DW6rHqzV5hv038HCrOpXCOMgcka0HlY/GYbkDH5ML0Obbgr94WHoePy+2FEGPVyc0PUkv48hYXa1vWx45ZHZ8OqoqB2UvOWJ5ei6yvdQBT6Fw54CSAuADW/rHz0yHGFgUjC1Rc/LCDtOZhp20ITTycAz1nxHCEptYu4sEZTUj0jF0cDm3dG0TLp4k2jx677FXK8O44a+RSL6jNBZhSIyG4MAN+bXOIn99iI7XK4B3kVcqOlKk9G2RoB2DG1CUj4jgRScNZhWYTy9RYZSYgQi6OXRLqsaJseGYDwIOgjQ3YSDVwOL1S6gNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfD1aQmqe+JhsbnWR9Rav7u+tCyqw71tH6vtpQTGGwU=;
 b=Yj2Ph3/4VVKW0ZVAtSquu+8bfNIQ2vMM5aPDQVUyoaXE0yEWmnwQj2yEG7PTgRTaF/yGkw4M0YwpxsfSbKzK+JH/r3sMKssrMQo8WuMm4J/eIg5a9E4PSGWC7dVxiSAiwK8U5TV/WYelqKllkYKY6/DgUnv6tDcNbYcnE17afxE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Mon, 12 Apr
 2021 18:05:21 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 18:05:21 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <1e37bb4d-f54d-1b7e-4632-94cfcf749528@amd.com>
 <51d7873d-cf35-6be5-79c2-024937c67f6a@amd.com>
 <29ffe63b-9049-824f-84fc-a92fdb451e0d@amd.com>
 <e37bdceb-cdb2-a826-21cf-8cb88748be08@gmail.com>
 <1e4b766d-b5c2-e6b5-8be6-9b2fae3abc94@amd.com>
 <b67ab565-e4be-0809-7021-cb59fd10464a@amd.com>
 <8c2cbe39-ea05-add4-efee-65527e53bb34@gmail.com>
 <50e0907c-52d6-1fdb-aa5e-39b1c326180c@amd.com>
 <4a1e3961-8708-46b7-bfd8-86a4ee4e2726@amd.com>
 <f36bef2c-d5c2-7290-c029-2bcc9d834bbc@amd.com>
 <b3965720-ea45-7664-5927-dd3836bfa46d@amd.com>
 <32b2ab00-7514-43ce-cb28-a437c194c16a@gmail.com>
 <01f69c6f-02a3-3387-db6b-0fa1bfa9bd17@amd.com>
 <70a534b7-2e55-cdd7-2f82-3b8799967aa0@amd.com>
 <62a329d4-ffd1-3ac1-03eb-dd0089b75541@amd.com>
 <b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com>
 <80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com>
 <cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com>
 <aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a970101f-89f1-8bdf-51d9-4a4e5e0f9e9a@amd.com>
Date: Mon, 12 Apr 2021 20:05:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:924c:f5e7:1b2d:1b8c]
X-ClientProxiedBy: AM0PR01CA0074.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::15) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:924c:f5e7:1b2d:1b8c]
 (2a02:908:1252:fb60:924c:f5e7:1b2d:1b8c) by
 AM0PR01CA0074.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Mon, 12 Apr 2021 18:05:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c513a2a1-6c82-46e1-bd8d-08d8fddd89ae
X-MS-TrafficTypeDiagnostic: MN2PR12MB4157:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4157EBD9B7E25DB57B519DBC83709@MN2PR12MB4157.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FAe+FJjCjGdyXgh0WB4w14bPis7RdyJPsGdOIsMxZS5pqHq9M19/Ohuu6zFjc7sxt/VVB5XBb1kNwn1JNrZgilwgAl2SdP2tVnOiStvS6pnTWzHatRSRSGZbMNW0O8tuR6iayJmG8J2PmJ5/dkg9J1LU+ajk0it1ovaz1FktG9YlBm0BYFc+qijHYeiSszGQeLGSq61PPpk8EMz/qW6/BQEDTchkKqBWUVIYcqvxeG1JYWgCYatUazAqSsnkL9ubXZFP9vl2u7+17pgiDD6eMcWMgNJ3WYzZmrSC2ApyILv9N3JKIiUHhyyjy84/BpEjeo+ILKnIpNSgHDQbbRTx8uzYj8EdXeom8VByYbPoD4xF5FL3vE4bvGfpn793yXp1o9+MaMJ5+Y3cxToo+qDMODFST4mcLXK2HhMLhiP/pS7yNZzChWYEyAhOixpM/k5oG21th4hvzT+CS2rp25M8VoGeU0jJT0JnP4ne/KPk69Yj/EAjRQFMkQsFmQn3ewb335S23V1fzbCJ2b6pHb1LVtHW2tcLf22moc8IzLAUGfeGBwQ4opt3SC6V+h19iadtrHPIUxiwlyVJmYcxTTTAjrIPq/AB/ZKAjyYpiyOp/xLtf8DAMAIayZLcs5v50XyD+uV2K//02eAIqa5WYH7Hs11Z3watVlKuHqv80NwAE8vyd84XddHXRpXTd0w5CqdOXkErDENEm7EAbvfAVDqc7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(6666004)(31686004)(66476007)(8936002)(66946007)(36756003)(45080400002)(86362001)(6636002)(52116002)(66556008)(2906002)(966005)(8676002)(478600001)(38100700002)(316002)(16526019)(921005)(66574015)(2616005)(6486002)(110136005)(30864003)(83380400001)(5660300002)(166002)(31696002)(186003)(53546011)(33964004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ejFIRXNkSmRaUFM5b2llTEZLak5BZXRoeEIvSEswKy9NaHlzTUx5UjIwSTYv?=
 =?utf-8?B?NVZpeHdMZ3hjdGdMcHZlMjJBWmZmNExuQ3RxajRRVWZQOWI5TUhQR2RMUFk5?=
 =?utf-8?B?dVAwWGUyVDhseGxzNnhrSDdqR0tobzFBaTl5dkFaelJkbVlPeEg2Qi94YXRz?=
 =?utf-8?B?cnVWaTQxVERRNlNBby81MjNFZlQzWndKM3Y5aE5YZzByM2lweFg0M0wrcGZs?=
 =?utf-8?B?NjBzNkkwTS9sWmRlaXpmbFB5K1lkakIrOGxrKzRpdCtsTTlqbUMrclVuOGxP?=
 =?utf-8?B?ajZ0V1BGeFZmYTNIblVOaGNGNVJCS0FLa3pEZEhHWHdtb2xFMm55S0NNSVZy?=
 =?utf-8?B?Y3BKV1Rnc0JvZUcrcWpmZ2xrR2VENzJjR3lMN1l2TE5qZWdGSlNlbWY5b0tr?=
 =?utf-8?B?czBhRVVYM3JtZTNTR21USHIrNldOMUUzT3hndk1iOUxETFpQbGxoU3JIR3lj?=
 =?utf-8?B?OFFlaVdQU2YxT3hKZlhrYmVnVm9kNTk5eUx3UEQ5Y1VaZmd1VUJVVFRzbzZU?=
 =?utf-8?B?L1dvNVJSeUliY0FTRjg1UGZyT2RKaVI4ajdoamc1TlNtZW9aYmxyV2JpU3ha?=
 =?utf-8?B?Y0Z4dS9ZNG1nakhUYTBKVnJsRmdNTzlDZmN3YUovYTFtY0pVc2QzejBYZ05o?=
 =?utf-8?B?ZyswMDAyN0E3TkxWb0hjL2NwZ1hYY0RpNzVEU2tZRFNzSFljaStKaS8weFJo?=
 =?utf-8?B?WlN6TVpQVFBsRXJlTG94OUp4S1pNK0twQm5idFUvRzhWNWJzV05xWk5scE5h?=
 =?utf-8?B?NFVDUWNUZGhiZ0pmVVRmVjZEUFIzaTN1a3hVcWxNK3ZuUGZIZmx5QXZDaUth?=
 =?utf-8?B?WTFUbnZKdGxqUDhOVlhWVU9zTjg0SnQ2QlBBaTNKRnNZb1BzNGxtbDUxUVVY?=
 =?utf-8?B?Vk90UUhSbmgzY2Y3OVluWjF3bThPc0owWFpJMmFSSTRjNGwwWlIySnZCOXNZ?=
 =?utf-8?B?ZSsxSGs5TWxLaUJ6V3BBczdPMHRjZ2htTk9TRVpmU2FJNElkVXZpMmxSQ21Z?=
 =?utf-8?B?OXRsNGdtaDdXQ2x6MVVYQ214c2kycExIS1U5SG50Y2UyaEhJMWNJRTRxN3M5?=
 =?utf-8?B?ZUp6S01LajdjNDAzTytYZ1BMa0hNODRCM1ZrSE5HczlZNXhpWUp3K2xURUZs?=
 =?utf-8?B?Ulk2ZlpwVUc3NmpTMWNuOGtFL1U3VnMva3JyVWhsVEUyTnRvQUt6WnM4NURQ?=
 =?utf-8?B?cnNsSlhSeE1ieXo3MUFheDczdEdHb3Zyb3hXRDN3VFZKM2cwUWFhcnBFOVpk?=
 =?utf-8?B?SEpGTzNqWUNEaGs5QUFKZWxNby91NjhhWXpHYkI4V0MrWWd4cDRkcjdjWjI3?=
 =?utf-8?B?N1RFYlo4WnhIdWZjekNIbkc1YWtBOEliVjhGakxrd3RYQzZCMURFeGdNcXJF?=
 =?utf-8?B?eUJqb3NoaWt1aVpqUHFJeTFtQWxjYlBQT212cHlXUG1RTnJaMDNWOHlYVER2?=
 =?utf-8?B?U3pIWlpsMnVMUFo3UWt0ZzlxeCtIRThZTmRnQTY3Uk5RMFRqMTVGR0NScmNp?=
 =?utf-8?B?UGxobU1IS0NKZzVUaTcvY0I1ejdxS2MreXEzMlhIWTlTVkczQkxDYWdKbW9Q?=
 =?utf-8?B?a3ZPekNxVTYyR1NiRTNKNkZ0MDFxRlN1S1dHTFMyM1NWaDV3VlRJTHNHaFJq?=
 =?utf-8?B?UTBWTFVMMDNUWE0rMlV2Q2ZzeW1zdkpqOUI5NkpkT2NFbkpsdmhnNURwRUJ6?=
 =?utf-8?B?UU5DbGZKTUw4aVY5MDE0RThPSkFtcHBYMkR4b0N6SFFQTUcyblM0dWZlYkl6?=
 =?utf-8?B?bE5VdVNzUGFsL0pDazNxWTZEdjM5VXJjSE9sN2d6dWx6b1h1MWpHMTNEL3U0?=
 =?utf-8?B?MUc5OTlXSXBJQjVNVjZhdkdxZFRydFhoQWZuNHVJaGpmMmRrUkkxeTdNT1FF?=
 =?utf-8?Q?1kuY5Sp1C76PR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c513a2a1-6c82-46e1-bd8d-08d8fddd89ae
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 18:05:21.5083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: saxFE3WRMXYmFilC6Y8qoauMuGjZIMG1V65y7yKRdQGxlCXYxM7vzr9QmAKvQv63
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157
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
Content-Type: multipart/mixed; boundary="===============0898502722=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0898502722==
Content-Type: multipart/alternative;
 boundary="------------395D831E1728C45F76FD36C6"
Content-Language: en-US

--------------395D831E1728C45F76FD36C6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 12.04.21 um 20:01 schrieb Andrey Grodzovsky:
>
> On 2021-04-12 1:44 p.m., Christian König wrote:
>
>>
>> Am 12.04.21 um 19:27 schrieb Andrey Grodzovsky:
>>> On 2021-04-10 1:34 p.m., Christian König wrote:
>>>> Hi Andrey,
>>>>
>>>> Am 09.04.21 um 20:18 schrieb Andrey Grodzovsky:
>>>>> [SNIP]
>>>>>>>
>>>>>>> If we use a list and a flag called 'emit_allowed' under a lock 
>>>>>>> such that in amdgpu_fence_emit we lock the list, check the flag 
>>>>>>> and if true add the new HW fence to list and proceed to HW 
>>>>>>> emition as normal, otherwise return with -ENODEV. In 
>>>>>>> amdgpu_pci_remove we take the lock, set the flag to false, and 
>>>>>>> then iterate the list and force signal it. Will this not prevent 
>>>>>>> any new HW fence creation from now on from any place trying to 
>>>>>>> do so ?
>>>>>>
>>>>>> Way to much overhead. The fence processing is intentionally lock 
>>>>>> free to avoid cache line bouncing because the IRQ can move from 
>>>>>> CPU to CPU.
>>>>>>
>>>>>> We need something which at least the processing of fences in the 
>>>>>> interrupt handler doesn't affect at all.
>>>>>
>>>>>
>>>>> As far as I see in the code, amdgpu_fence_emit is only called from 
>>>>> task context. Also, we can skip this list I proposed and just use 
>>>>> amdgpu_fence_driver_force_completion for each ring to signal all 
>>>>> created HW fences.
>>>>
>>>> Ah, wait a second this gave me another idea.
>>>>
>>>> See amdgpu_fence_driver_force_completion():
>>>>
>>>> amdgpu_fence_write(ring, ring->fence_drv.sync_seq);
>>>>
>>>> If we change that to something like:
>>>>
>>>> amdgpu_fence_write(ring, ring->fence_drv.sync_seq + 0x3FFFFFFF);
>>>>
>>>> Not only the currently submitted, but also the next 0x3FFFFFFF 
>>>> fences will be considered signaled.
>>>>
>>>> This basically solves out problem of making sure that new fences 
>>>> are also signaled without any additional overhead whatsoever.
>>>
>>>
>>> Problem with this is that the act of setting the sync_seq to some 
>>> MAX value alone is not enough, you actually have to call 
>>> amdgpu_fence_process to iterate and signal the fences currently 
>>> stored in ring->fence_drv.fences array and to guarantee that once 
>>> you done your signalling no more HW fences will be added to that 
>>> array anymore. I was thinking to do something like bellow:
>>>
>>
>> Well we could implement the is_signaled callback once more, but I'm 
>> not sure if that is a good idea.
>
>
> This indeed could save the explicit signaling I am doing bellow but I 
> also set an error code there which might be helpful to propagate to users
>
>
>>
>>> amdgpu_fence_emit()
>>>
>>> {
>>>
>>>     dma_fence_init(fence);
>>>
>>>     srcu_read_lock(amdgpu_unplug_srcu)
>>>
>>>     if (!adev->unplug)) {
>>>
>>>         seq = ++ring->fence_drv.sync_seq;
>>>         emit_fence(fence);
>>>
>>> */* We can't wait forever as the HW might be gone at any point*/**
>>>        dma_fence_wait_timeout(old_fence, 5S);*
>>>
>>
>> You can pretty much ignore this wait here. It is only as a last 
>> resort so that we never overwrite the ring buffers.
>
>
> If device is present how can I ignore this ?
>
>
>>
>> But it should not have a timeout as far as I can see.
>
>
> Without timeout wait the who approach falls apart as I can't call 
> srcu_synchronize on this scope because once device is physically gone 
> the wait here will be forever
>

Yeah, but this is intentional. The only alternative to avoid corruption 
is to wait with a timeout and call BUG() if that triggers. That isn't 
much better.

>
>>
>>>         ring->fence_drv.fences[seq & 
>>> ring->fence_drv.num_fences_mask] = fence;
>>>
>>>     } else {
>>>
>>>         dma_fence_set_error(fence, -ENODEV);
>>>         DMA_fence_signal(fence)
>>>
>>>     }
>>>
>>>     srcu_read_unlock(amdgpu_unplug_srcu)
>>>     return fence;
>>>
>>> }
>>>
>>> amdgpu_pci_remove
>>>
>>> {
>>>
>>>     adev->unplug = true;
>>>     synchronize_srcu(amdgpu_unplug_srcu)
>>>
>>
>> Well that is just duplicating what drm_dev_unplug() should be doing 
>> on a different level.
>
>
> drm_dev_unplug is on a much wider scope, for everything in the device 
> including 'flushing' in flight IOCTLs, this deals specifically with 
> the issue of force signalling HW fences
>

Yeah, but it adds the same overhead as the device srcu.

Christian.

> Andrey
>
>
>>
>> Christian.
>>
>>>     /* Past this point no more fence are submitted to HW ring and 
>>> hence we can safely call force signal on all that are currently there.
>>>      * Any subsequently created  HW fences will be returned signaled 
>>> with an error code right away
>>>      */
>>>
>>>     for_each_ring(adev)
>>>         amdgpu_fence_process(ring)
>>>
>>>     drm_dev_unplug(dev);
>>>     Stop schedulers
>>>     cancel_sync(all timers and queued works);
>>>     hw_fini
>>>     unmap_mmio
>>>
>>> }
>>>
>>>
>>> Andrey
>>>
>>>
>>>>
>>>>
>>>>>
>>>>>>>>
>>>>>>>> Alternatively grabbing the reset write side and stopping and 
>>>>>>>> then restarting the scheduler could work as well.
>>>>>>>>
>>>>>>>> Christian.
>>>>>>>
>>>>>>>
>>>>>>> I didn't get the above and I don't see why I need to reuse the 
>>>>>>> GPU reset rw_lock. I rely on the SRCU unplug flag for unplug. 
>>>>>>> Also, not clear to me why are we focusing on the scheduler 
>>>>>>> threads, any code patch to generate HW fences should be covered, 
>>>>>>> so any code leading to amdgpu_fence_emit needs to be taken into 
>>>>>>> account such as, direct IB submissions, VM flushes e.t.c
>>>>>>
>>>>>> You need to work together with the reset lock anyway, cause a 
>>>>>> hotplug could run at the same time as a reset.
>>>>>
>>>>>
>>>>> For going my way indeed now I see now that I have to take reset 
>>>>> write side lock during HW fences signalling in order to protect 
>>>>> against scheduler/HW fences detachment and reattachment during 
>>>>> schedulers stop/restart. But if we go with your approach  then 
>>>>> calling drm_dev_unplug and scoping amdgpu_job_timeout with 
>>>>> drm_dev_enter/exit should be enough to prevent any concurrent GPU 
>>>>> resets during unplug. In fact I already do it anyway - 
>>>>> https://nam11.safelinks.protection.outlook.com/?url=https:%2F%2Fcgit.freedesktop.org%2F~agrodzov%2Flinux%2Fcommit%2F%3Fh%3Ddrm-misc-next%26id%3Def0ea4dd29ef44d2649c5eda16c8f4869acc36b1&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Ceefa9c90ed8c405ec3b708d8fc46daaa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637536728550884740%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=UiNaJE%2BH45iYmbwSDnMSKZS5z0iak0fNlbbfYqKS2Jo%3D&amp;reserved=0
>>>>
>>>> Yes, good point as well.
>>>>
>>>> Christian.
>>>>
>>>>>
>>>>> Andrey
>>>>>
>>>>>
>>>>>>
>>>>>>
>>>>>> Christian.
>>>>>>
>>>>>>>
>>>>>>> Andrey
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Christian.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Andrey
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>> Andrey
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>
>>>>
>>


--------------395D831E1728C45F76FD36C6
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 12.04.21 um 20:01 schrieb Andrey Grodzovsky:<br>
    <blockquote type="cite" cite="mid:aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com">
      
      <p>On 2021-04-12 1:44 p.m., Christian König wrote:<br>
      </p>
      <blockquote type="cite" cite="mid:cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com"> <br>
        Am 12.04.21 um 19:27 schrieb Andrey Grodzovsky:<br>
        <blockquote type="cite" cite="mid:80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com">
          <div class="moz-cite-prefix">On 2021-04-10 1:34 p.m.,
            Christian König wrote:<br>
          </div>
          <blockquote type="cite" cite="mid:b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com">Hi
            Andrey, <br>
            <br>
            Am 09.04.21 um 20:18 schrieb Andrey Grodzovsky: <br>
            <blockquote type="cite">[SNIP] <br>
              <blockquote type="cite">
                <blockquote type="cite"> <br>
                  If we use a list and a flag called 'emit_allowed'
                  under a lock such that in amdgpu_fence_emit we lock
                  the list, check the flag and if true add the new HW
                  fence to list and proceed to HW emition as normal,
                  otherwise return with -ENODEV. In amdgpu_pci_remove we
                  take the lock, set the flag to false, and then iterate
                  the list and force signal it. Will this not prevent
                  any new HW fence creation from now on from any place
                  trying to do so ? <br>
                </blockquote>
                <br>
                Way to much overhead. The fence processing is
                intentionally lock free to avoid cache line bouncing
                because the IRQ can move from CPU to CPU. <br>
                <br>
                We need something which at least the processing of
                fences in the interrupt handler doesn't affect at all. <br>
              </blockquote>
              <br>
              <br>
              As far as I see in the code, amdgpu_fence_emit is only
              called from task context. Also, we can skip this list I
              proposed and just use amdgpu_fence_driver_force_completion
              for each ring to signal all created HW fences. <br>
            </blockquote>
            <br>
            Ah, wait a second this gave me another idea. <br>
            <br>
            See amdgpu_fence_driver_force_completion(): <br>
            <br>
            amdgpu_fence_write(ring, ring-&gt;fence_drv.sync_seq); <br>
            <br>
            If we change that to something like: <br>
            <br>
            amdgpu_fence_write(ring, ring-&gt;fence_drv.sync_seq +
            0x3FFFFFFF); <br>
            <br>
            Not only the currently submitted, but also the next
            0x3FFFFFFF fences will be considered signaled. <br>
            <br>
            This basically solves out problem of making sure that new
            fences are also signaled without any additional overhead
            whatsoever.</blockquote>
          <p><br>
          </p>
          <p>Problem with this is that the act of setting the sync_seq
            to some MAX value alone is not enough, you actually have to
            call amdgpu_fence_process to iterate and signal the fences
            currently stored in ring-&gt;fence_drv.fences array and to
            guarantee that once you done your signalling no more HW
            fences will be added to that array anymore. I was thinking
            to do something like bellow:</p>
        </blockquote>
        <br>
        Well we could implement the is_signaled callback once more, but
        I'm not sure if that is a good idea.<br>
      </blockquote>
      <p><br>
      </p>
      <p>This indeed could save the explicit signaling I am doing bellow
        but I also set an error code there which might be helpful to
        propagate to users</p>
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com"> <br>
        <blockquote type="cite" cite="mid:80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com">
          <p>amdgpu_fence_emit()</p>
          <p>{</p>
          <p>&nbsp;&nbsp;&nbsp; dma_fence_init(fence);<br>
          </p>
          <p>&nbsp;&nbsp;&nbsp; srcu_read_lock(amdgpu_unplug_srcu)</p>
          <p>&nbsp;&nbsp;&nbsp; if (!adev-&gt;unplug)) {</p>
          <p>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; seq = ++ring-&gt;fence_drv.sync_seq;<br>
            &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; emit_fence(fence);</p>
          <p>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <b>/* We can't wait forever as the HW might be
              gone at any point*/</b><b><br>
              &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; dma_fence_wait_timeout(old_fence, 5S);</b><br>
          </p>
        </blockquote>
        <br>
        You can pretty much ignore this wait here. It is only as a last
        resort so that we never overwrite the ring buffers.<br>
      </blockquote>
      <p><br>
      </p>
      <p>If device is present how can I ignore this ?</p>
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com"> <br>
        But it should not have a timeout as far as I can see.<br>
      </blockquote>
      <p><br>
      </p>
      <p>Without timeout wait the who approach falls apart as I can't
        call srcu_synchronize on this scope because once device is
        physically gone the wait here will be forever</p>
    </blockquote>
    <br>
    Yeah, but this is intentional. The only alternative to avoid
    corruption is to wait with a timeout and call BUG() if that
    triggers. That isn't much better.<br>
    <br>
    <blockquote type="cite" cite="mid:aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com">
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com"> <br>
        <blockquote type="cite" cite="mid:80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com">
          <p> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ring-&gt;fence_drv.fences[seq &amp;
            ring-&gt;fence_drv.num_fences_mask] = fence;<br>
          </p>
          <p>&nbsp;&nbsp;&nbsp; } else {</p>
          <p>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dma_fence_set_error(fence, -ENODEV);<br>
            &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; DMA_fence_signal(fence) &nbsp;&nbsp; <br>
          </p>
          <p>&nbsp;&nbsp;&nbsp; } &nbsp; <br>
          </p>
          <p>&nbsp;&nbsp;&nbsp; srcu_read_unlock(amdgpu_unplug_srcu)<br>
            &nbsp;&nbsp;&nbsp; return fence;<br>
          </p>
          <p>}</p>
          <p>amdgpu_pci_remove <br>
          </p>
          <p>{</p>
          <p>&nbsp;&nbsp;&nbsp; adev-&gt;unplug = true;<br>
            &nbsp;&nbsp;&nbsp; synchronize_srcu(amdgpu_unplug_srcu) <br>
          </p>
        </blockquote>
        <br>
        Well that is just duplicating what drm_dev_unplug() should be
        doing on a different level.<br>
      </blockquote>
      <p><br>
      </p>
      <p>drm_dev_unplug is on a much wider scope, for everything in the
        device including 'flushing' in flight IOCTLs, this deals
        specifically with the issue of force signalling HW fences</p>
    </blockquote>
    <br>
    Yeah, but it adds the same overhead as the device srcu.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com">
      <p>Andrey</p>
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com"> <br>
        Christian.<br>
        <br>
        <blockquote type="cite" cite="mid:80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com">
          <p>&nbsp;&nbsp;&nbsp; /* Past this point no more fence are submitted to HW
            ring and hence we can safely call force signal on all that
            are currently there. <br>
            &nbsp;&nbsp;&nbsp;&nbsp; * Any subsequently created&nbsp; HW fences will be returned
            signaled with an error code right away <br>
            &nbsp;&nbsp;&nbsp;&nbsp; */<br>
          </p>
          <p>&nbsp;&nbsp;&nbsp; for_each_ring(adev)<br>
            &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; amdgpu_fence_process(ring)</p>
          <p>&nbsp;&nbsp;&nbsp; drm_dev_unplug(dev);<br>
            &nbsp;&nbsp;&nbsp; Stop schedulers<br>
            &nbsp;&nbsp;&nbsp; cancel_sync(all timers and queued works);<br>
            &nbsp;&nbsp;&nbsp; hw_fini<br>
            &nbsp;&nbsp;&nbsp; unmap_mmio<br>
          </p>
          <p>}</p>
          <p><br>
          </p>
          <p>Andrey</p>
          <p><br>
          </p>
          <blockquote type="cite" cite="mid:b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com"> <br>
            <br>
            <blockquote type="cite"> <br>
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite"> <br>
                    Alternatively grabbing the reset write side and
                    stopping and then restarting the scheduler could
                    work as well. <br>
                    <br>
                    Christian. <br>
                  </blockquote>
                  <br>
                  <br>
                  I didn't get the above and I don't see why I need to
                  reuse the GPU reset rw_lock. I rely on the SRCU unplug
                  flag for unplug. Also, not clear to me why are we
                  focusing on the scheduler threads, any code patch to
                  generate HW fences should be covered, so any code
                  leading to amdgpu_fence_emit needs to be taken into
                  account such as, direct IB submissions, VM flushes
                  e.t.c <br>
                </blockquote>
                <br>
                You need to work together with the reset lock anyway,
                cause a hotplug could run at the same time as a reset. <br>
              </blockquote>
              <br>
              <br>
              For going my way indeed now I see now that I have to take
              reset write side lock during HW fences signalling in order
              to protect against scheduler/HW fences detachment and
              reattachment during schedulers stop/restart. But if we go
              with your approach&nbsp; then calling drm_dev_unplug and
              scoping amdgpu_job_timeout with drm_dev_enter/exit should
              be enough to prevent any concurrent GPU resets during
              unplug. In fact I already do it anyway - <a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https:%2F%2Fcgit.freedesktop.org%2F~agrodzov%2Flinux%2Fcommit%2F%3Fh%3Ddrm-misc-next%26id%3Def0ea4dd29ef44d2649c5eda16c8f4869acc36b1&amp;amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Ceefa9c90ed8c405ec3b708d8fc46daaa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637536728550884740%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=UiNaJE%2BH45iYmbwSDnMSKZS5z0iak0fNlbbfYqKS2Jo%3D&amp;amp;reserved=0" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https:%2F%2Fcgit.freedesktop.org%2F~agrodzov%2Flinux%2Fcommit%2F%3Fh%3Ddrm-misc-next%26id%3Def0ea4dd29ef44d2649c5eda16c8f4869acc36b1&amp;amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Ceefa9c90ed8c405ec3b708d8fc46daaa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637536728550884740%7CUnknown%7CTWFpbGZsb3d8eyJWIj
 oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=UiNaJE%2BH45iYmbwSDnMSKZS5z0iak0fNlbbfYqKS2Jo%3D&amp;amp;reserved=0</a><br>
            </blockquote>
            <br>
            Yes, good point as well. <br>
            <br>
            Christian. <br>
            <br>
            <blockquote type="cite"> <br>
              Andrey <br>
              <br>
              <br>
              <blockquote type="cite"> <br>
                <br>
                Christian. <br>
                <br>
                <blockquote type="cite"> <br>
                  Andrey <br>
                  <br>
                  <br>
                  <blockquote type="cite"> <br>
                    <blockquote type="cite"> <br>
                      Christian. <br>
                      <br>
                      <blockquote type="cite"> <br>
                        Andrey <br>
                        <br>
                        <br>
                        <blockquote type="cite"> <br>
                          <blockquote type="cite">Andrey <br>
                            <br>
                            <br>
                          </blockquote>
                          <br>
                        </blockquote>
                      </blockquote>
                      <br>
                    </blockquote>
                    <br>
                  </blockquote>
                </blockquote>
                <br>
              </blockquote>
            </blockquote>
            <br>
          </blockquote>
        </blockquote>
        <br>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------395D831E1728C45F76FD36C6--

--===============0898502722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0898502722==--
