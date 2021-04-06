Return-Path: <SRS0=1IUY=JD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E22C433B4
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 11:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA56F6128B
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 11:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA56F6128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A90286E824;
	Tue,  6 Apr 2021 11:21:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 809AC6E824
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Apr 2021 11:21:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fG1SqbRQhrl9fc+vPDJBaRHNrvBtPwACwU+p2gGLrEHFbWPCef6LpUCfy946/XTlt7HZ2NCDpfKZmCSR9ft2bFjUJLCD33mEjH1HmmO3BsAY5S+OyB6ka0FrV2HZq5CDBi0X2Ekd4r37EFkfD+v7UsnRdhQDRwHrcx5rGWJpBKY1hYcCZhVCyzWAgEFjFX/EeYzBaZAgYuBHC8dMWmAlJF5R7kKZzOvnBkt2lD1U5DH3apWVR2Mmj55+9kj0beT3e6DkbFIQLr/dbm3IGHU73BbouxdO1t6YYAwB9syc1D9DsFtInHFvQl2tnowZ1LQE99+7PHqhGPvEViO9gXkssQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IdB6Oi8KmFAnaaM2GiwgtSGKjzWYNn1nRe5uPgtfa0=;
 b=AjUIrc0AWkHLDTM+LWzASWgB8fPN2I7mX8uRpIwSs5nTbQwFg+qOzk/7R4s/r3RHLIupVw5lwlNr7TTBBh0oWdfJl+fdxl2VmzsOV9xESFm/097tj3vMU+ZmrL504DfiuGFxanymflJUz6Xoa/ScSnei6HtOVtpGiB0d2qnzZmWJsrXYK1epN0pwYb0GkEYWz79HFIOkdzqzbNwB0n71W7HYR3Ff7V43FQZeCWQuVoe9/P8jEHQbCtJuTiz0uRMD3qoeVt5O0GGuH65L+WxrmlpMMFSg6xluK1pdsQY2xmm651fhop3/3l6a+W+FoU5EeacRpDHNjzVMnaiV8g+/jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IdB6Oi8KmFAnaaM2GiwgtSGKjzWYNn1nRe5uPgtfa0=;
 b=NfsxujQFzUmAV+s/DAhQTW1GcZpOwdtLuraGdylDyEdmty34ZEbTDRmJkYaxkPiVyscP+2fszUmzhgE1z2XZJkNgZu2OfPHe/Q25vHVzYKglT0zojTMdXNrJKVlkOyIMFQT/3wCt4kFOCbsX9yQn38lgx1dkRENmULcv0hdfOgg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4689.namprd12.prod.outlook.com (2603:10b6:208:8f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Tue, 6 Apr
 2021 11:21:11 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 11:21:09 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <d40648ba-9948-5442-23ed-d352f824f8f9@amd.com>
 <DM5PR12MB25330F3CD92C587C2E921424ED699@DM5PR12MB2533.namprd12.prod.outlook.com>
 <MN2PR12MB3775531A74B886A207134B1583699@MN2PR12MB3775.namprd12.prod.outlook.com>
 <DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com>
 <378fdffb-99b5-2a14-736d-a06f310b040c@amd.com>
 <1e37bb4d-f54d-1b7e-4632-94cfcf749528@amd.com>
 <51d7873d-cf35-6be5-79c2-024937c67f6a@amd.com>
Message-ID: <54ea4f74-7fdf-e02f-bb4e-1ddb101d9a81@amd.com>
Date: Tue, 6 Apr 2021 13:21:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <51d7873d-cf35-6be5-79c2-024937c67f6a@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:8475:9991:cfb3:4162]
X-ClientProxiedBy: FR0P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::8) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:8475:9991:cfb3:4162]
 (2a02:908:1252:fb60:8475:9991:cfb3:4162) by
 FR0P281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:15::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.10 via Frontend Transport; Tue, 6 Apr 2021 11:21:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fa6c3ca-f439-4bbc-0d63-08d8f8ee13ef
X-MS-TrafficTypeDiagnostic: BL0PR12MB4689:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4689950281A529A1489E086183769@BL0PR12MB4689.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q5XAqQc12pjaokKan3X+v73jTg/F5cmF9JzMFC6hUuBMgH4MvYByYiRXySk0MtsBpsqDgYk4rDSgK8+VzjxjiiGAk0nqwhg5cDayGTgak3k2xIpZ8JcA/x1L0xGj8O+dralnPyjVw9YTm6RV9IJR1G4/0hRszncD5RIr14C8wxTSxMUK0skOK/jfu7190MZgsjWXod2Xeig9/psDA654HdvXKXixPaFJXd+B9LNbRDjkJzRUqVVNHJU8TDr+9zEx0RyMl7QH4VcoDtp3e9qQS2ZUxI5djKCeV3e813zrLjblIQJnrqFJMl8lmgP8jPEkVLk1evVXMYz+DF4m419TtyxZxvGdere0VC3HqHuhhUouV2oJc1H+mYvRGyCE3QzYkpRa/WUVsuxnhwzDfKEN0+bJL7dfsAovvHxx7JAVfi/d3WjDVVLya+LzekvuVWE+eZFQymAKNrBXjBiaxz6OsNHmJ6RnJlx5jK+zMkdxVdR4jQ89vhNAG69IYnfhWO4t/kLABXj90Ygt9YwY5iu15nlNwXkyOYvOUWSmRpV5qQU2JHVzN+z+QaXO449+QpT9DdBDyP4OkJNdwDMfG/7aEWjs+0DUkZAHHUw8J3/pMzgN1pHmBDpEooNazkJ8hvNnaHziKAzOo4kIEXSu9hiA6oIxmWe8GvMJEQFXUozzmOcY7zbRKbnXnAWRHtNZcF7Yntgd2nycGVTwQEuvaKKWG7yklcfaay4vR8JYDagwDsY02vgkDWbUBigAvY1FcGzbtUFf5jFz2cTZQPvmUtwA+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(66574015)(31696002)(21615005)(5660300002)(921005)(38100700001)(966005)(16526019)(30864003)(86362001)(6486002)(2906002)(31686004)(8676002)(6666004)(166002)(83380400001)(33964004)(52116002)(8936002)(36756003)(316002)(2616005)(186003)(6636002)(66946007)(478600001)(53546011)(66476007)(110136005)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y0ZvSGE1NUNVMmJWWXpRWHhSc3ZVbVJVQWZwbER5UDA1bXVDZ01DTGhoc0Vm?=
 =?utf-8?B?RVROWStrZnB4cWVaSTQ2NlJPZGRyd0QvNlU1TWJzL0dNQlZ4VWJObEFBUFVi?=
 =?utf-8?B?bjdiR3l0cUlhRnM0ZzFhV2RvMVNCQWUrbzNNbUJSS2R3UWJPNHNWU0c1V3Rs?=
 =?utf-8?B?VmFJNzgxbXZCOFFveE1lK0ZqbzhBUHZ5ZVdSa0R2WDRrWm9wdFozcFE1VWVs?=
 =?utf-8?B?MkZ6bDFST2JsblpTOW13OHF0VjBYN1hxRGRJOVRha2tBaVkwaTN6SGVYU2c2?=
 =?utf-8?B?K3BWaHVaaXVJUVg0WlVsMFpIQXZkbHV1K2NoSHNvRlNSanJJQ0piWk9QSm9R?=
 =?utf-8?B?MmQ5NFJPbWpXRlNRZ3ZKMkRmODQra0VmeHZhaW9XdzE3WjlXVDV6OVFIWTA2?=
 =?utf-8?B?cnNiVis4V3RPVzRObHREc25zQzZ1MnVZUVFnUDhESVduUFREM1A3clNHTERU?=
 =?utf-8?B?MFIwSEhRU3RGKy9UTEowZktpL2pyc1pWWjZrUTJtNHk2dnYyL2VPN0o2V1Ew?=
 =?utf-8?B?Znp6aFR6aGZ2MkV0MGJLTUNGS2cvREhGcEs0R3NMMTZxR1l5ZWlrUEgzRFdN?=
 =?utf-8?B?YUgwVlpOdHpWVGtjV3BqNkZvRlFFS1ZsNDQzQ2hOZ0lwSWVOK3FiZzBaQU5i?=
 =?utf-8?B?bzFwc3Z1WWpmTmRXRytqMTNsNDBXNGsyajJUVFZFdTV5N2t6WldkYnF3QTJs?=
 =?utf-8?B?YjhZaDluWHVoTVZyZ2hhL0tOY3lUbFRWY2Zmb1BPYUk3L0MvUmJOYUZ1OFVT?=
 =?utf-8?B?UXlGY1NkZWF2NmdpSUlpMnNMNHRueEpHNXdoaFhWcG1wbTN5T0pyVEd0Sjli?=
 =?utf-8?B?YTZKZk9EbGVYdFRvcSs3UExPOVVhNGx1VzVIc3V1a1RldTQ1YTVyS2ZzOFBj?=
 =?utf-8?B?aHJlSjlPRElFMmRmcEgzVWVpRklYVmdScktjU2paOW16ZkkweEx2bldkTHEw?=
 =?utf-8?B?ZUhnd0plbkoxbFFyeFhRVUxUVVViZXgvMDUrMlhpMzdNYnZnSlJZbDlSSTM2?=
 =?utf-8?B?aWp1SlZwZ0VZUzZ3M0xxbytlTVBSVllqaG1PUzhuSzlOUlM3cU9tUjBoTnJC?=
 =?utf-8?B?eXM4UFB1ajZrdHFMY3BwRklpU0hLU0JOeDVEdXRCM3pHekFZTDFrM3FmS1Vr?=
 =?utf-8?B?SnBDelJMMkhXejREbm1USnFjaHptQnZUOFhueFVGZ1dnbjZqZjViOVRqR3Bl?=
 =?utf-8?B?MVFTMnRZdmcrbk9hTGVLYjluUmorRHdKb1BuV0RGbTRKK3RRUEpTSVFMSDZ0?=
 =?utf-8?B?dDBzSVZtSWVlNEQ4RVUvTHdBT3VaZnZSc3ROZkEwYUZkYi9xZlJEaXFiaFU5?=
 =?utf-8?B?T29KZlAwNUoxSStiTDFrNnorOXdHc2NjWHRtaHFwNkdXaktZdEpZZmRWNW9m?=
 =?utf-8?B?SUlPRXFzcTlqNjBsRG5QTzVtV2hFd1JxaEdmZDdyUW1yamRGRy90R3hQWGJW?=
 =?utf-8?B?K0FTVm02Q0I3V3lNbmtYWlJCMjE3bTEyMk9CbDRaSXM5Q0pBc1hJaWhGRjhX?=
 =?utf-8?B?bUdla0dHaGJ3ZmZtOWd3b0ZyNkwvc1VxNVd4dVZPMkZqT1VHWFJWYXZtSmdY?=
 =?utf-8?B?dUxpdENsZE1rRDBjajBla2gwSkdLRmZvUW5NSWZCeWtUalBRelVSYXljN245?=
 =?utf-8?B?aWtleGxmYzB2Wk1xT1czU2pTdFlkMFhkVHZyR2wxdnRabzhiZmZGNEVTWm1C?=
 =?utf-8?B?VlJLcDlyV05yT0h2ekxOY2svOVovTFhaZEZkQjBhaW52SnBuS0lzOVNDMkYr?=
 =?utf-8?B?dW0xaXRNSWw5NEZTL2dPQlZ6NWhlSWJVTVdXYjd5SS9GdzJKbXNDZ3VuaGl5?=
 =?utf-8?B?UlozeW51eUpSMFhyWllnUUpOZnIrSW9zOWNWTXo2VlpWQkhROFBOVXBTcjdu?=
 =?utf-8?Q?XOBnR9ixpYNCF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa6c3ca-f439-4bbc-0d63-08d8f8ee13ef
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 11:21:09.5572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUXj0nBWFahe0+cL/r73zd7SIzpzWj8F8zY7orX/5fsTEDKCTNs0ruM5maBGV85/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4689
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
Content-Type: multipart/mixed; boundary="===============2079471485=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2079471485==
Content-Type: multipart/alternative;
 boundary="------------D74928E7BE7DF7ED777A7C43"
Content-Language: en-US

--------------D74928E7BE7DF7ED777A7C43
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



Am 06.04.21 um 12:34 schrieb Christian König:
> Hi Andrey,
>
> well good question. My job is to watch over the implementation and 
> design and while I always help I can adjust anybodies schedule.

That should read "I can't adjust anybodies schedule".

Christian.

>
> Is the patch to print a warning when the hardware is accessed without 
> holding the locks merged yet? If not then that would probably be a 
> good starting point.
>
> Then we would need to unify this with the SRCU to make sure that we 
> have both the reset lock as well as block the hotplug code from 
> reusing the MMIO space.
>
> And then testing, testing, testing to see if we have missed something.
>
> Christian.
>
> Am 05.04.21 um 19:58 schrieb Andrey Grodzovsky:
>>
>> Denis, Christian, are there any updates in the plan on how to move on 
>> with this ? As you know I need very similar code for my up-streaming 
>> of device hot-unplug. My latest solution 
>> (https://lists.freedesktop.org/archives/amd-gfx/2021-January/058606.html) 
>> was not acceptable because of low level guards on the register 
>> accessors level which was hurting performance. Basically I need a way 
>> to prevent any MMIO write accesses from kernel driver after device is 
>> removed (UMD accesses are taken care of by page faulting dummy page). 
>> We are using now hot-unplug code for Freemont program and so 
>> up-streaming became more of a priority then before. This MMIO access 
>> issue is currently my main blocker from up-streaming. Is there any 
>> way I can assist in pushing this on ?
>>
>> Andrey
>>
>> On 2021-03-18 5:51 a.m., Christian König wrote:
>>> Am 18.03.21 um 10:30 schrieb Li, Dennis:
>>>>
>>>> >>> The GPU reset doesn't complete the fences we wait for. It only 
>>>> completes the hardware fences as part of the reset.
>>>>
>>>> >>> So waiting for a fence while holding the reset lock is illegal 
>>>> and needs to be avoided.
>>>>
>>>> I understood your concern. It is more complex for DRM GFX, 
>>>> therefore I abandon adding lock protection for DRM ioctls now. 
>>>> Maybe we can try to add all kernel  dma_fence waiting in a list, 
>>>> and signal all in recovery threads. Do you have same concern for 
>>>> compute cases?
>>>>
>>>
>>> Yes, compute (KFD) is even harder to handle.
>>>
>>> See you can't signal the dma_fence waiting. Waiting for a dma_fence 
>>> also means you wait for the GPU reset to finish.
>>>
>>> When we would signal the dma_fence during the GPU reset then we 
>>> would run into memory corruption because the hardware jobs running 
>>> after the GPU reset would access memory which is already freed.
>>>
>>>> >>> Lockdep also complains about this when it is used correctly. 
>>>> The only reason it doesn't complain here is because you use an 
>>>> atomic+wait_event instead of a locking primitive.
>>>>
>>>> Agree. This approach will escape the monitor of lockdep.  Its goal 
>>>> is to block other threads when GPU recovery thread start. But I 
>>>> couldn’t find a better method to solve this problem. Do you have 
>>>> some suggestion?
>>>>
>>>
>>> Well, completely abandon those change here.
>>>
>>> What we need to do is to identify where hardware access happens and 
>>> then insert taking the read side of the GPU reset lock so that we 
>>> don't wait for a dma_fence or allocate memory, but still protect the 
>>> hardware from concurrent access and reset.
>>>
>>> Regards,
>>> Christian.
>>>
>>>> Best Regards
>>>>
>>>> Dennis Li
>>>>
>>>> *From:* Koenig, Christian <Christian.Koenig@amd.com>
>>>> *Sent:* Thursday, March 18, 2021 4:59 PM
>>>> *To:* Li, Dennis <Dennis.Li@amd.com>; 
>>>> amd-gfx@lists.freedesktop.org; Deucher, Alexander 
>>>> <Alexander.Deucher@amd.com>; Kuehling, Felix 
>>>> <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
>>>> *Subject:* AW: [PATCH 0/4] Refine GPU recovery sequence to enhance 
>>>> its stability
>>>>
>>>> Exactly that's what you don't seem to understand.
>>>>
>>>> The GPU reset doesn't complete the fences we wait for. It only 
>>>> completes the hardware fences as part of the reset.
>>>>
>>>> So waiting for a fence while holding the reset lock is illegal and 
>>>> needs to be avoided.
>>>>
>>>> Lockdep also complains about this when it is used correctly. The 
>>>> only reason it doesn't complain here is because you use an 
>>>> atomic+wait_event instead of a locking primitive.
>>>>
>>>> Regards,
>>>>
>>>> Christian.
>>>>
>>>> ------------------------------------------------------------------------
>>>>
>>>> *Von:*Li, Dennis <Dennis.Li@amd.com <mailto:Dennis.Li@amd.com>>
>>>> *Gesendet:* Donnerstag, 18. März 2021 09:28
>>>> *An:* Koenig, Christian <Christian.Koenig@amd.com 
>>>> <mailto:Christian.Koenig@amd.com>>; amd-gfx@lists.freedesktop.org 
>>>> <mailto:amd-gfx@lists.freedesktop.org> 
>>>> <amd-gfx@lists.freedesktop.org 
>>>> <mailto:amd-gfx@lists.freedesktop.org>>; Deucher, Alexander 
>>>> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>; 
>>>> Kuehling, Felix <Felix.Kuehling@amd.com 
>>>> <mailto:Felix.Kuehling@amd.com>>; Zhang, Hawking 
>>>> <Hawking.Zhang@amd.com <mailto:Hawking.Zhang@amd.com>>
>>>> *Betreff:* RE: [PATCH 0/4] Refine GPU recovery sequence to enhance 
>>>> its stability
>>>>
>>>> >>> Those two steps need to be exchanged or otherwise it is 
>>>> possible that new delayed work items etc are started before the 
>>>> lock is taken.
>>>> What about adding check for adev->in_gpu_reset in work item? If 
>>>> exchange the two steps, it maybe introduce the deadlock.  For 
>>>> example, the user thread hold the read lock and waiting for the 
>>>> fence, if recovery thread try to hold write lock and then complete 
>>>> fences, in this case, recovery thread will always be blocked.
>>>>
>>>>
>>>> Best Regards
>>>> Dennis Li
>>>> -----Original Message-----
>>>> From: Koenig, Christian <Christian.Koenig@amd.com 
>>>> <mailto:Christian.Koenig@amd.com>>
>>>> Sent: Thursday, March 18, 2021 3:54 PM
>>>> To: Li, Dennis <Dennis.Li@amd.com <mailto:Dennis.Li@amd.com>>; 
>>>> amd-gfx@lists.freedesktop.org 
>>>> <mailto:amd-gfx@lists.freedesktop.org>; Deucher, Alexander 
>>>> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>; 
>>>> Kuehling, Felix <Felix.Kuehling@amd.com 
>>>> <mailto:Felix.Kuehling@amd.com>>; Zhang, Hawking 
>>>> <Hawking.Zhang@amd.com <mailto:Hawking.Zhang@amd.com>>
>>>> Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance 
>>>> its stability
>>>>
>>>> Am 18.03.21 um 08:23 schrieb Dennis Li:
>>>> > We have defined two variables in_gpu_reset and reset_sem in adev 
>>>> object. The atomic type variable in_gpu_reset is used to avoid 
>>>> recovery thread reenter and make lower functions return more 
>>>> earlier when recovery start, but couldn't block recovery thread 
>>>> when it access hardware. The r/w semaphore reset_sem is used to 
>>>> solve these synchronization issues between recovery thread and 
>>>> other threads.
>>>> >
>>>> > The original solution locked registers' access in lower 
>>>> functions, which will introduce following issues:
>>>> >
>>>> > 1) many lower functions are used in both recovery thread and 
>>>> others. Firstly we must harvest these functions, it is easy to miss 
>>>> someones. Secondly these functions need select which lock (read 
>>>> lock or write lock) will be used, according to the thread it is 
>>>> running in. If the thread context isn't considered, the added lock 
>>>> will easily introduce deadlock. Besides that, in most time, 
>>>> developer easily forget to add locks for new functions.
>>>> >
>>>> > 2) performance drop. More lower functions are more frequently called.
>>>> >
>>>> > 3) easily introduce false positive lockdep complaint, because 
>>>> write lock has big range in recovery thread, but low level 
>>>> functions will hold read lock may be protected by other locks in 
>>>> other threads.
>>>> >
>>>> > Therefore the new solution will try to add lock protection for 
>>>> ioctls of kfd. Its goal is that there are no threads except for 
>>>> recovery thread or its children (for xgmi) to access hardware when 
>>>> doing GPU reset and resume. So refine recovery thread as the following:
>>>> >
>>>> > Step 0: atomic_cmpxchg(&adev->in_gpu_reset, 0, 1)
>>>> >     1). if failed, it means system had a recovery thread running, 
>>>> current thread exit directly;
>>>> >     2). if success, enter recovery thread;
>>>> >
>>>> > Step 1: cancel all delay works, stop drm schedule, complete all 
>>>> unreceived fences and so on. It try to stop or pause other threads.
>>>> >
>>>> > Step 2: call down_write(&adev->reset_sem) to hold write lock, 
>>>> which will block recovery thread until other threads release read 
>>>> locks.
>>>>
>>>> Those two steps need to be exchanged or otherwise it is possible 
>>>> that new delayed work items etc are started before the lock is taken.
>>>>
>>>> Just to make it clear until this is fixed the whole patch set is a NAK.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>> >
>>>> > Step 3: normally, there is only recovery threads running to 
>>>> access hardware, it is safe to do gpu reset now.
>>>> >
>>>> > Step 4: do post gpu reset, such as call all ips' resume functions;
>>>> >
>>>> > Step 5: atomic set adev->in_gpu_reset as 0, wake up other threads 
>>>> and release write lock. Recovery thread exit normally.
>>>> >
>>>> > Other threads call the amdgpu_read_lock to synchronize with 
>>>> recovery thread. If it finds that in_gpu_reset is 1, it should 
>>>> release read lock if it has holden one, and then blocks itself to 
>>>> wait for recovery finished event. If thread successfully hold read 
>>>> lock and in_gpu_reset is 0, it continues. It will exit normally or 
>>>> be stopped by recovery thread in step 1.
>>>> >
>>>> > Dennis Li (4):
>>>> >    drm/amdgpu: remove reset lock from low level functions
>>>> >    drm/amdgpu: refine the GPU recovery sequence
>>>> >    drm/amdgpu: instead of using down/up_read directly
>>>> >    drm/amdkfd: add reset lock protection for kfd entry functions
>>>> >
>>>> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h |   6 +
>>>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  14 +-
>>>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 173 +++++++++++++-----
>>>> >   .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c |   8 -
>>>> >   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |   4 +-
>>>> >   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c |   9 +-
>>>> >   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c |   5 +-
>>>> >   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c |   5 +-
>>>> >   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 172 ++++++++++++++++-
>>>> >   drivers/gpu/drm/amd/amdkfd/kfd_priv.h |   3 +-
>>>> >   drivers/gpu/drm/amd/amdkfd/kfd_process.c |   4 +
>>>> >   .../amd/amdkfd/kfd_process_queue_manager.c |  17 ++
>>>> >   12 files changed, 345 insertions(+), 75 deletions(-)
>>>> >
>>>>
>>>
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------D74928E7BE7DF7ED777A7C43
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">Am 06.04.21 um 12:34 schrieb Christian
      König:<br>
    </div>
    <blockquote type="cite" cite="mid:51d7873d-cf35-6be5-79c2-024937c67f6a@amd.com">
      
      Hi Andrey,<br>
      <br>
      well good question. My job is to watch over the implementation and
      design and while I always help I can adjust anybodies schedule.<br>
    </blockquote>
    <br>
    That should read &quot;I can't adjust anybodies schedule&quot;.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:51d7873d-cf35-6be5-79c2-024937c67f6a@amd.com"> <br>
      Is the patch to print a warning when the hardware is accessed
      without holding the locks merged yet? If not then that would
      probably be a good starting point.<br>
      <br>
      Then we would need to unify this with the SRCU to make sure that
      we have both the reset lock as well as block the hotplug code from
      reusing the MMIO space.<br>
      <br>
      And then testing, testing, testing to see if we have missed
      something.<br>
      <br>
      Christian.<br>
      <br>
      <div class="moz-cite-prefix">Am 05.04.21 um 19:58 schrieb Andrey
        Grodzovsky:<br>
      </div>
      <blockquote type="cite" cite="mid:1e37bb4d-f54d-1b7e-4632-94cfcf749528@amd.com">
        <p>Denis, Christian, are there any updates in the plan on how to
          move on with this ? As you know I need very similar code for
          my up-streaming of device hot-unplug. My latest solution (<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/archives/amd-gfx/2021-January/058606.html" moz-do-not-send="true">https://lists.freedesktop.org/archives/amd-gfx/2021-January/058606.html</a>)
          was not acceptable because of low level guards on the register
          accessors level which was hurting performance. Basically I
          need a way to prevent any MMIO write accesses from kernel
          driver after device is removed (UMD accesses are taken care of
          by page faulting dummy page). We are using now hot-unplug code
          for Freemont program and so up-streaming became more of a
          priority then before. This MMIO access issue is currently my
          main blocker from up-streaming. Is there any way I can assist
          in pushing this on ?</p>
        <p>Andrey&nbsp; <br>
        </p>
        <div class="moz-cite-prefix">On 2021-03-18 5:51 a.m., Christian
          König wrote:<br>
        </div>
        <blockquote type="cite" cite="mid:378fdffb-99b5-2a14-736d-a06f310b040c@amd.com"> Am
          18.03.21 um 10:30 schrieb Li, Dennis:<br>
          <blockquote type="cite" cite="mid:DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com">
            <meta name="Generator" content="Microsoft Word 15 (filtered
              medium)">
            <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
            <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:等线;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:"\@等线";
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
            <div class="WordSection1">
              <p class="MsoNormal">&gt;&gt;&gt; The GPU reset doesn't
                complete the fences we wait for. It only completes the
                hardware fences as part of the reset.<o:p></o:p></p>
              <p class="MsoNormal">&gt;&gt;&gt; So waiting for a fence
                while holding the reset lock is illegal and needs to be
                avoided.<o:p></o:p></p>
              <p class="MsoNormal">I understood your concern. It is more
                complex for DRM GFX, therefore I abandon adding lock
                protection for DRM ioctls now. Maybe we can try to add
                all kernel &nbsp;dma_fence waiting in a list, and signal all
                in recovery threads. Do you have same concern for
                compute cases? </p>
            </div>
          </blockquote>
          <br>
          Yes, compute (KFD) is even harder to handle.<br>
          <br>
          See you can't signal the dma_fence waiting. Waiting for a
          dma_fence also means you wait for the GPU reset to finish.<br>
          <br>
          When we would signal the dma_fence during the GPU reset then
          we would run into memory corruption because the hardware jobs
          running after the GPU reset would access memory which is
          already freed.<br>
          <br>
          <blockquote type="cite" cite="mid:DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com">
            <div class="WordSection1">
              <p class="MsoNormal"><o:p></o:p></p>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
              <p class="MsoNormal">&gt;&gt;&gt; Lockdep also complains
                about this when it is used correctly. The only reason it
                doesn't complain here is because you use an
                atomic+wait_event instead of a locking primitive.<o:p></o:p></p>
              <p class="MsoNormal">Agree. This approach will escape the
                monitor of lockdep.&nbsp; Its goal is to block other threads
                when GPU recovery thread start. But I couldn’t find a
                better method to solve this problem. Do you have some
                suggestion? </p>
            </div>
          </blockquote>
          <br>
          Well, completely abandon those change here.<br>
          <br>
          What we need to do is to identify where hardware access
          happens and then insert taking the read side of the GPU reset
          lock so that we don't wait for a dma_fence or allocate memory,
          but still protect the hardware from concurrent access and
          reset.<br>
          <br>
          Regards,<br>
          Christian.<br>
          <br>
          <blockquote type="cite" cite="mid:DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com">
            <div class="WordSection1">
              <p class="MsoNormal"><o:p></o:p></p>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
              <p class="MsoNormal">Best Regards<o:p></o:p></p>
              <p class="MsoNormal">Dennis Li<o:p></o:p></p>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
              <div>
                <div style="border:none;border-top:solid #E1E1E1
                  1.0pt;padding:3.0pt 0in 0in 0in">
                  <p class="MsoNormal"><b>From:</b> Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>
                    <br>
                    <b>Sent:</b> Thursday, March 18, 2021 4:59 PM<br>
                    <b>To:</b> Li, Dennis <a class="moz-txt-link-rfc2396E" href="mailto:Dennis.Li@amd.com" moz-do-not-send="true">&lt;Dennis.Li@amd.com&gt;</a>;
                    <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>;
                    Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
                    Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a>;
                    Zhang, Hawking <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com" moz-do-not-send="true">&lt;Hawking.Zhang@amd.com&gt;</a><br>
                    <b>Subject:</b> AW: [PATCH 0/4] Refine GPU recovery
                    sequence to enhance its stability<o:p></o:p></p>
                </div>
              </div>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                    UI&quot;,sans-serif;color:black">Exactly that's what
                    you don't seem to understand.<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                    UI&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                    UI&quot;,sans-serif;color:black">The GPU reset
                    doesn't complete the fences we wait for. It only
                    completes the hardware fences as part of the reset.<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                    UI&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                    UI&quot;,sans-serif;color:black">So waiting for a
                    fence while holding the reset lock is illegal and
                    needs to be avoided.<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                    UI&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                    UI&quot;,sans-serif;color:black">Lockdep also
                    complains about this when it is used correctly. The
                    only reason it doesn't complain here is because you
                    use an atomic+wait_event instead of a locking
                    primitive.<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                    UI&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                    UI&quot;,sans-serif;color:black">Regards,<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                    UI&quot;,sans-serif;color:black">Christian.<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
              </div>
              <div class="MsoNormal" style="text-align:center" align="center">
                <hr width="98%" size="2" align="center"> </div>
              <div id="divRplyFwdMsg">
                <p class="MsoNormal"><b><span style="color:black">Von:</span></b><span style="color:black"> Li, Dennis &lt;<a href="mailto:Dennis.Li@amd.com" moz-do-not-send="true">Dennis.Li@amd.com</a>&gt;<br>
                    <b>Gesendet:</b> Donnerstag, 18. März 2021 09:28<br>
                    <b>An:</b> Koenig, Christian &lt;<a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;;
                    <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
                    &lt;<a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;;
                    Deucher, Alexander &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;;
                    Kuehling, Felix &lt;<a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">Felix.Kuehling@amd.com</a>&gt;;
                    Zhang, Hawking &lt;<a href="mailto:Hawking.Zhang@amd.com" moz-do-not-send="true">Hawking.Zhang@amd.com</a>&gt;<br>
                    <b>Betreff:</b> RE: [PATCH 0/4] Refine GPU recovery
                    sequence to enhance its stability</span> <o:p></o:p></p>
                <div>
                  <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                </div>
              </div>
              <div>
                <div>
                  <p class="MsoNormal">&gt;&gt;&gt; Those two steps need
                    to be exchanged or otherwise it is possible that new
                    delayed work items etc are started before the lock
                    is taken.<br>
                    What about adding check for adev-&gt;in_gpu_reset in
                    work item? If exchange the two steps, it maybe
                    introduce the deadlock.&nbsp; For example, the user
                    thread hold the read lock and waiting for the fence,
                    if recovery thread try to hold write lock and then
                    complete fences, in this case, recovery thread will
                    always be blocked.<o:p></o:p></p>
                </div>
                <div>
                  <p class="MsoNormal" style="margin-bottom:12.0pt"><br>
                    Best Regards<br>
                    Dennis Li<br>
                    -----Original Message-----<br>
                    From: Koenig, Christian &lt;<a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;
                    <br>
                    Sent: Thursday, March 18, 2021 3:54 PM<br>
                    To: Li, Dennis &lt;<a href="mailto:Dennis.Li@amd.com" moz-do-not-send="true">Dennis.Li@amd.com</a>&gt;;
                    <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                      amd-gfx@lists.freedesktop.org</a>; Deucher,
                    Alexander &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;;
                    Kuehling, Felix &lt;<a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">Felix.Kuehling@amd.com</a>&gt;;
                    Zhang, Hawking &lt;<a href="mailto:Hawking.Zhang@amd.com" moz-do-not-send="true">Hawking.Zhang@amd.com</a>&gt;<br>
                    Subject: Re: [PATCH 0/4] Refine GPU recovery
                    sequence to enhance its stability<br>
                    <br>
                    Am 18.03.21 um 08:23 schrieb Dennis Li:<br>
                    &gt; We have defined two variables in_gpu_reset and
                    reset_sem in adev object. The atomic type variable
                    in_gpu_reset is used to avoid recovery thread
                    reenter and make lower functions return more earlier
                    when recovery start, but couldn't block recovery
                    thread when it access hardware. The r/w semaphore
                    reset_sem is used to solve these synchronization
                    issues between recovery thread and other threads.<br>
                    &gt;<br>
                    &gt; The original solution locked registers' access
                    in lower functions, which will introduce following
                    issues:<br>
                    &gt;<br>
                    &gt; 1) many lower functions are used in both
                    recovery thread and others. Firstly we must harvest
                    these functions, it is easy to miss someones.
                    Secondly these functions need select which lock
                    (read lock or write lock) will be used, according to
                    the thread it is running in. If the thread context
                    isn't considered, the added lock will easily
                    introduce deadlock. Besides that, in most time,
                    developer easily forget to add locks for new
                    functions.<br>
                    &gt;<br>
                    &gt; 2) performance drop. More lower functions are
                    more frequently called.<br>
                    &gt;<br>
                    &gt; 3) easily introduce false positive lockdep
                    complaint, because write lock has big range in
                    recovery thread, but low level functions will hold
                    read lock may be protected by other locks in other
                    threads.<br>
                    &gt;<br>
                    &gt; Therefore the new solution will try to add lock
                    protection for ioctls of kfd. Its goal is that there
                    are no threads except for recovery thread or its
                    children (for xgmi) to access hardware when doing
                    GPU reset and resume. So refine recovery thread as
                    the following:<br>
                    &gt;<br>
                    &gt; Step 0:
                    atomic_cmpxchg(&amp;adev-&gt;in_gpu_reset, 0, 1)<br>
                    &gt;&nbsp;&nbsp;&nbsp;&nbsp; 1). if failed, it means system had a
                    recovery thread running, current thread exit
                    directly;<br>
                    &gt;&nbsp;&nbsp;&nbsp;&nbsp; 2). if success, enter recovery thread;<br>
                    &gt;<br>
                    &gt; Step 1: cancel all delay works, stop drm
                    schedule, complete all unreceived fences and so on.
                    It try to stop or pause other threads.<br>
                    &gt;<br>
                    &gt; Step 2: call
                    down_write(&amp;adev-&gt;reset_sem) to hold write
                    lock, which will block recovery thread until other
                    threads release read locks.<br>
                    <br>
                    Those two steps need to be exchanged or otherwise it
                    is possible that new delayed work items etc are
                    started before the lock is taken.<br>
                    <br>
                    Just to make it clear until this is fixed the whole
                    patch set is a NAK.<br>
                    <br>
                    Regards,<br>
                    Christian.<br>
                    <br>
                    &gt;<br>
                    &gt; Step 3: normally, there is only recovery
                    threads running to access hardware, it is safe to do
                    gpu reset now.<br>
                    &gt;<br>
                    &gt; Step 4: do post gpu reset, such as call all
                    ips' resume functions;<br>
                    &gt;<br>
                    &gt; Step 5: atomic set adev-&gt;in_gpu_reset as 0,
                    wake up other threads and release write lock.
                    Recovery thread exit normally.<br>
                    &gt;<br>
                    &gt; Other threads call the amdgpu_read_lock to
                    synchronize with recovery thread. If it finds that
                    in_gpu_reset is 1, it should release read lock if it
                    has holden one, and then blocks itself to wait for
                    recovery finished event. If thread successfully hold
                    read lock and in_gpu_reset is 0, it continues. It
                    will exit normally or be stopped by recovery thread
                    in step 1.<br>
                    &gt;<br>
                    &gt; Dennis Li (4):<br>
                    &gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: remove reset lock from low level
                    functions<br>
                    &gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: refine the GPU recovery sequence<br>
                    &gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: instead of using down/up_read
                    directly<br>
                    &gt;&nbsp;&nbsp;&nbsp; drm/amdkfd: add reset lock protection for
                    kfd entry functions<br>
                    &gt;<br>
                    &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    |&nbsp;&nbsp; 6 +<br>
                    &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c&nbsp;&nbsp;
                    |&nbsp; 14 +-<br>
                    &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbsp;&nbsp;
                    | 173 +++++++++++++-----<br>
                    &gt;&nbsp;&nbsp; .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c&nbsp;&nbsp;&nbsp;
                    |&nbsp;&nbsp; 8 -<br>
                    &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    |&nbsp;&nbsp; 4 +-<br>
                    &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    |&nbsp;&nbsp; 9 +-<br>
                    &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    |&nbsp;&nbsp; 5 +-<br>
                    &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    |&nbsp;&nbsp; 5 +-<br>
                    &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    | 172 ++++++++++++++++-<br>
                    &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    |&nbsp;&nbsp; 3 +-<br>
                    &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    |&nbsp;&nbsp; 4 +<br>
                    &gt;&nbsp;&nbsp; .../amd/amdkfd/kfd_process_queue_manager.c&nbsp;&nbsp;&nbsp;
                    |&nbsp; 17 ++<br>
                    &gt;&nbsp;&nbsp; 12 files changed, 345 insertions(+), 75
                    deletions(-)<br>
                    &gt;<o:p></o:p></p>
                </div>
              </div>
            </div>
          </blockquote>
          <br>
          <br>
          <fieldset class="mimeAttachmentHeader"></fieldset>
          <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
        </blockquote>
      </blockquote>
      <br>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------D74928E7BE7DF7ED777A7C43--

--===============2079471485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2079471485==--
