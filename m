Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B48C47077
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jan 2024 15:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2F7E10E538;
	Tue, 16 Jan 2024 15:06:10 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 838AD10E511
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 15:06:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMxXXrq+62UwGF0mo2HoJMRWHoHmWItbQqkddclWlUXkzwYkMM/o6QRaW7L1XT5qfnRf/5/n3TmWIom1SRBb21P11jUTIVCt1QDfkUkGjHeI9J6YPjrjnTKQQ23xely80dTodenR5Dr3I/eOw7fyzSFuwA/nXsMyObaLlfJLKBEp/A5z2ofx0J1phCs+HxqbAPwI5ahKG8BKobMSQFFlHUCrfw6OwWv0Ia3L7HVv8GCs6jc/UFP6GxGCRwDld/smgIkmR4J/vrAZ7ircSuLPDokoZ806oaZGi7GVc/3/mqwkhKq2S+mjSGy4qYCi0yq/FEwupTE+2sIfXLFHvIuehQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJkTXEr0IzUNEXpN9PSth/1aRA5UOllyRP0wPV3Wj4w=;
 b=dquQQI7l6zDBMpeqPlgbsiiZI09Nx14+2ULS31bpgAuObLiHBSAwx9atFjN6nBdfZLsLDbLEQ/TOsQtatV0aSMK4vky3uXmU/AA1d/uhUbfr4fEkgWXKsZ9iWxK0TeZyIVFVzI3BPvvWSHWEeay+SZhMMiztViP706qF7UqS4TZ22KAqrZaKTloFRkqf3v6DnIE+T1tXZqSdzM8JbzOT/yRBJeo71BeA9yEmTDiNX6/IHWNg/b19+A7sKhnGvaeot1eEljfT9qEGocl3TsjGA74NQUcMjyJcEU6a/rZ46I3XNLNeY+JwHg9IcIt3T5FgJu/eycBHYeJfL+8MXUbjdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJkTXEr0IzUNEXpN9PSth/1aRA5UOllyRP0wPV3Wj4w=;
 b=shU3di2pTT5OVjMtYdu8/UH32dJqFcA5ZUBxZKMKoMLzAzp/9m5ySXLpwqkyyERka31GU5X3Y63Y55VPIB3/bD1nmhJfzblyD47L+mCQpix67dL7h6qPGq9K8ySplD/6dLNV5KseIaWjj2XBPGtJ+2SkLB+V1fEe8irXoZ8WrOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7137.namprd12.prod.outlook.com (2603:10b6:510:1ed::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 16 Jan
 2024 15:05:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7159.020; Tue, 16 Jan 2024
 15:05:50 +0000
Message-ID: <b48e84b0-8e7a-4290-aa33-e4c01e9f9809@amd.com>
Date: Tue, 16 Jan 2024 16:05:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
Content-Language: en-US
To: Joshua Ashton <joshua@froggi.es>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <20240113140206.2383133-1-joshua@froggi.es>
 <8e5cd59e-075a-480e-8452-87924580122d@froggi.es>
 <1dbe811f-64a0-4ccd-88cf-3fd30f79f7bc@daenzer.net>
 <c36400bd-b8f2-4026-b989-f4e1854b05ca@gmx.de>
 <7194a09a-afe8-4eae-8288-c72e2ac7d0a6@daenzer.net>
 <51b9ffc3-9ab3-4a06-9307-6b2a343f6bc6@gmx.de>
 <CAP+8YyGg91f_z2ktrd7HQMtOSHn34F-8x7O2iRv=TTrXo2NNoA@mail.gmail.com>
 <81a82ffc-c2e6-4ce6-9cc0-4f01dc8b9891@froggi.es>
 <bff749b8-5531-46bd-8e21-97d094e6b4c2@amd.com>
 <9e6fec7b-3786-4221-8024-6b949efd08e7@froggi.es>
 <bfe79411-7f77-48ab-8cfd-4727704739e8@amd.com>
 <3e284517-0372-4c75-9902-7039c09b73e9@froggi.es>
 <baa54077-cf89-4fb7-b505-a41716e66a23@gmail.com>
 <CAAxE2A5v_RkZ9ex4=7jiBSKVb22_1FAj0AANBcmKtETt5c3gVA@mail.gmail.com>
 <de47a17b-3d19-4c74-b77a-e08b0e94cc69@gmail.com>
 <2a9a1a92-a074-456e-8190-3ba0a30d3f30@froggi.es>
 <f6409b43-88f7-4a44-a007-d6686cf11a50@froggi.es>
 <4bfbb2e3-962f-4a74-ba52-0277205c6bfd@froggi.es>
 <75737c81-a470-4bcd-bf98-d2b4e37aa095@froggi.es>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <75737c81-a470-4bcd-bf98-d2b4e37aa095@froggi.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0264.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: d1207646-5be8-4665-0a50-08dc16a4a0aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ioq0wXUWqhKx8QE0YmpnEBwHqZI524i+g/+LM8DifBWtyRhp+HdP5gqkufieCWzYv49YGW7ePxU/5rl7BJjM8jVj09spknwP0Ba2/pqIfK3HyZa3Rz981XTR/Pb4YSRIdW2wE0CME2l0UNigkHSIXyTsm8kc+B1k7jfsryXTz1xP2u6bHkPYoNoHFlDqMhghnDItMVhJPXwmKJ+e+a/cZ3NHKBGbRKxF/2hFNmuiUpx3PbT7jblvaqo0MXFJNdHqKLHho9VC7YwoSm6jdFIPbVTb6X6auC/Q4cIwulp50k2YS8AnhYiorTY7b8S65EuufRXMrZhmT4ZY3uOVVkUbwa2pzjGhvhbWSo9HrD+1ag3W24GutrEus4YkzOCDnT9o8jXBOrWbQYVvmzY1a08SxR3ZF+wTPUb0PRPV7uCjexIhVbKtiINDEk9DEmfLSO/B3kvgBtS+7JdNU/n6tsDmlrs36Pg8j7oQvCunvDPBlrEYPKiy5YuFjSfSAaCHRdZOKe21m6yJRA7uaHBoVHBvD0SfS2e3CguDl97MQfihtVcV8EnNF6Nk9k/TbC6eIae2PsUECKWvRsol7G887ynsCvsCUxiXgr/xd6Je4fxYhoTVyOhCgzserFfE8DXLPmG0t0IRtbR9ZHIhGu9YcD5n1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(31686004)(83380400001)(31696002)(86362001)(36756003)(5660300002)(6512007)(4326008)(8936002)(26005)(6666004)(2616005)(38100700002)(41300700001)(8676002)(54906003)(66946007)(66476007)(478600001)(316002)(110136005)(6506007)(6486002)(2906002)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTkxT0V6dlBuOUlyOENpOGdWSFhHY3YvQTBqRU1QRnUvR1J4UVVUcWtFaXds?=
 =?utf-8?B?MkV0eWF2SUVUaWV3dnpuWVlBa0MwY2ZnUUxSTnlZU3V4NEdkbHpxeDUwaDI4?=
 =?utf-8?B?RW8rcy9JNVBEV2NQUWpuMnc4aENBL1dReVF5dnJIL1dUZnB5a25NRUtUMTVV?=
 =?utf-8?B?VDI3cVFnd2JnSVV2aE9XbGxkazA5RnpLVTZ2Q1l6TEZsaHVxTHNFeHNmdkUv?=
 =?utf-8?B?UnA3U2dnQjJjb01pMFM4b2w2bWxHNTVmMjNONEJwYUdHNHdua3ZkRzZwUUlE?=
 =?utf-8?B?MGxPazlNRWJHTHA2RWdqZ3p5NjhJamhSYjFpcSt3MWFHZFduSWx1Z29CY3Y1?=
 =?utf-8?B?VXM3UFFYQWw0b2NBem1oT3RYRlJiUi9USjlYZzVDclBkbHZ3d3kyWlcyTEVD?=
 =?utf-8?B?Zi9uc0wzMFlKcWg4c09sQWorVUh0RUE1RWlNVGdGb1RUWVhxcjlycmx5N3hC?=
 =?utf-8?B?WnZzL0ZXeGlqSjZuWENERGI0NlV2Q3F5cDdoU3BwUHN4ZUo4Ty9VK1RqNXFq?=
 =?utf-8?B?cFgxMXIzdWhNNXBDWTF6QlZiV3Z6aytnTXRTcHFScTNmL1dEQjlBRWd2RXU5?=
 =?utf-8?B?cHlkNFNJL1pKR3E2NUJQNVVCdE5WQ3ZOVEVkcUZ4MXNnRHFwc0pNRnB6N2gr?=
 =?utf-8?B?RTlpMnd1ZnRuQmZYeGhyU3k5RlQvREt6d2F5cWVMeHcvWmtYTVkrZDdFRnEz?=
 =?utf-8?B?WDc4aGFFcnpKSUh6eld2V1BhVDJudTVURFpaZUVTYnZxd3VteHYvVUFVMEE1?=
 =?utf-8?B?TmhpZGNNRjcvVER1Y1FFRWs0T05aRy82MVRNOXI5TENpTEYyZ1dQZm1GWTFG?=
 =?utf-8?B?R3VXeGh1MktZY2xyMlB2MDZFQ2VlUWNjbW5Cb0ZONUkvSmZsNGNQcFhvM1U1?=
 =?utf-8?B?SEJ5NzRPeGxUQWFVelJSUm9kWU5LRllZNUI0RFhCbGZ5ZWhac054aFRxd3Nj?=
 =?utf-8?B?RWQ1eFB4bmtQZVhxeTdyUUk2U29BVFpFSXNQTzlaajczNXhTRmplVnU4dk9S?=
 =?utf-8?B?ay9oZmJBMGwzSjBpT0lsZWloQXF3RTZlYldaMHJELzlaU3R0WW5OYTNlR2N3?=
 =?utf-8?B?NFduR1NSa2VWTyt4RGltOGZZbnNwZGpaTVRDK2xzSDBkM2lMR3RvNVhyaGlQ?=
 =?utf-8?B?dEhqZEtnTXFuOTFLZXh4eFJNd0tsUU0rU1Q1UjZBdXNaWjNaWkN5MjhoZVc2?=
 =?utf-8?B?NVZsTzczdkpGRG1YZjR1MGx6SGw2ejJGQVU2RU5Xa1VDdXpmY01xK3N6UVA2?=
 =?utf-8?B?emZTV21FdXhVS1RUTlVIU3cwcXhwMlB5a2FFRjFBWHd1bEhJaVJNUytud01a?=
 =?utf-8?B?VlhSU2ZscFN2ZHBtbWNnQ0JWRXRubitWZ3l2V1pJVWx4NUo3NDYwU0RnZ2lX?=
 =?utf-8?B?eldYckthRE1GWkkvSzI3bXdPRytRWkVYa2FUVTIwdXZRckVEL3d0VnQ0VWdz?=
 =?utf-8?B?QU5IbUk0RXlDL3lQUnhKYWZLVlp4YjhKMHJFY1V6YzZlckgwcW1nSE1xQW85?=
 =?utf-8?B?MTlmaDhIYndMZXk5cUlWanRkbFhVbEtKZHJQU1dhc2Y2cGI2UThwVlFlb25o?=
 =?utf-8?B?bGtpZUVZUStxYzlqN2FVNDAxSVk5QnBFY1M0YmNqTi9aL2lKTXNLUVVPK2hW?=
 =?utf-8?B?SEhOOWFjTFZnZlN4OU1rRWlBTXFyMUNvd3hKYXFjTE5ZVVN0aTZZZ085Nk5O?=
 =?utf-8?B?amgrK2pOaWtqWmdOZURrYjI5emtmZ3NrRDVqOGE4YmFXaldkZkU4c093QWRT?=
 =?utf-8?B?bTljMUZhMlZHUTBVVmtiQ1I4RTNCWTh4V0JQL2piQVE4UENnTDErYnN5MUJD?=
 =?utf-8?B?OEdQWnEwUGlOZFdrSHB3R0VzRUNBdGxyYkpOYXFiUmxNd0tVSFNHVDhwcDZB?=
 =?utf-8?B?RkNiTzBWeThsUWRVSlk4NUs1M2IvdzB5OGtYYU11N3V5UlpOdUs1NTdueitH?=
 =?utf-8?B?RFdXRm9sQnFsMTJvendnbWpYZ0RUYWpLbW51cHY5M2JmQXArM1NEZ1pzQTQx?=
 =?utf-8?B?ZHErajg2Vk5DUy94cG1QYU9OR3B4RTU5dXkwVVdyeXNLa0RGMEJlM2lnc3Zj?=
 =?utf-8?B?R1Z6WnRURFB2SERoejh6cHV2WTBvbmV0ZS9uZXB2ODFHa0dhWlNOY0JZclVD?=
 =?utf-8?Q?RwJ4XiG8j9sWtBJw+fuMudqeC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1207646-5be8-4665-0a50-08dc16a4a0aa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 15:05:50.6973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Svug9ujmTt7XWtJOKUwycWwIHA4yxp4fAreaxOkGXtbZIwnHA6GMZ4Aq6r4ICnjz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7137
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
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 amd-gfx@lists.freedesktop.org, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 16.01.24 um 14:48 schrieb Joshua Ashton:
>
> [SNIP]
>>>>> Going to adjust the implementation accordingly.
>>>>
>>>> Awesome, please CC me know when you have something.

Sure, going to keep that in mind.

>>>>
>>>> In the short-term I have changed if (r && r != -ENODATA) to if (r) 
>>>> and that seems to work nicely for me.
>>>
>>> One problem with solely relying on the CS submission return value 
>>> from userspace is cancelled syncobj waits.
>>>
>>> For example, if we have an application with one thread that makes a 
>>> submission, and then kicks off a vkWaitSemaphores to wait on a 
>>> semaphore on another thread and that submission hangs, the syncobj 
>>> relating to the vkWaitSemaphores should be signalled which is fine, 
>>> but we need to return VK_ERROR_DEVICE_LOST if the context loss 
>>> resulted in the signal for the VkSemaphore.
>>>
>>> The way this was previously integrated was with the query thing, 
>>> which as we have established does not provide correct information 
>>> regarding soft recovery at the moment.
>>>
>>> Unless you have an alternative for us to get some error out of the 
>>> syncobj (eg. -ENODATA), then right now we still require the query.
>>>
>>> I think fixing the -ENODATA reporting back for submit is a good 
>>> step, but I believe we still need the query to report the same 
>>> information as we would have gotten from that here.

Yeah, exactly that was one of the reasons why the guilty handling 
approach didn't solved the problem sufficiently.

If I remember correctly at least for the syncobj used on Android you can 
actually query the result of the execution after waiting for them to signal.

So not only the issuer of a submission can get the result, but also 
everybody waiting for the result. In other words Wayland, X, etc... can 
implement graceful handling should an application send them nonsense.

I don't think we ever implemented something similar for drm_syncobj and 
we might need error forwarding in the dma_fence_chain container, but 
stuff like that is trivial to implement should the requirement for this 
ever come up.

>>
>> Hmmm, actually the spec states that VK_SUCCESS is valid in this 
>> situation:
>>
>> Commands that wait indefinitely for device execution (namely 
>> vkDeviceWaitIdle, vkQueueWaitIdle, vkWaitForFences with a maximum 
>> timeout, and vkGetQueryPoolResults with the VK_QUERY_RESULT_WAIT_BIT 
>> bit set in flags) must return in finite time even in the case of a 
>> lost device, and return either VK_SUCCESS or VK_ERROR_DEVICE_LOST.
>>
>> ...
>>
>>
>> Once a device is lost, command execution may fail, and certain 
>> commands that return a VkResult may return VK_ERROR_DEVICE_LOST.
>
> I guess for now disregard last email regarding us potentially needing 
> the query, it does seem that returning SUCCESS is completely valid.

Well how you interpret the information the kernel gives you in userspace 
is your thing. But we should at least make sure that the general 
approach inside the kernel has a design which can handle those requirements.

Christian.

>
> - Joshie 🐸✨
>
>>
>> - Joshie 🐸✨
>>
>>>
>>> Thanks
>>>
>>> - Joshie 🐸✨
>>>
>>>>
>>>> - Joshie 🐸✨
>>>>
>>>>>
>>>>> Christian.
>>>>>
>>>>>>
>>>>>>
>>>>>> Marek
>>>>>
>>>>

