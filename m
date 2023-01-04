Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D70C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jan 2023 14:39:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0993310E440;
	Wed,  4 Jan 2023 14:39:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDE5910E440
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jan 2023 14:39:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfI3x/aY3sGntpQOmxQV6wm3cvCtkUQojP+cpfukjmNrSrSTOK1yh9yn09a8cDwmdOQ8LVoxfND9/9eLD2S0PfUPkEmYU99w1Sleoh2zZktKL1jZ/zy74b6KchmDDPlX4f1HK6EwwT+d4vepPZaCTtLYJ/AbeGTv/3YNK5i7I9RLjSevNfO4xuiEpx8OwEJIthITRCtAJYwdrNRW8jS2JFrbwc0790ztgZ9R3IpI+qaMyPPgknhZ4RQ0lB9M1XVx+Pb9NpFqFRyEip8dI5N0tqoOdb18Y1bRQG1HJU1vVq8h7FIT//V+nZROzY/uRyZ5meOH2zhyhNLAjIUyrMo3/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLQU8//zsVg27fE2swo3MWH8Ik5ROtHN68/4n8Fgdyk=;
 b=AbxRcdWcktrCGDLHPKRsnWKQP/ivJRN0A9EJNoJO9SjBHfcsdsI81frv7W+Dfxpa8FVTV4oTCPPRzSzfoGsY3o481ptqwW2+GEMGshsiHjgP81VA7raccPpYRxpwWyUCfbNrnWIMCMvBCr+hLx5fJXhHKI6uyHz9g8xS3K+Qdku6cr2AItbzQ+Sl5p4kkacCYdOurWha0ZA9SsJeIiPMiUv1nxhFRVH9BEdHP/OzmMW0zuv6KjPCSOPVcecpPveH30rvRLGsxSGSSXi/+JF1XlizxGwfBHyA2WAdm7IoDTcrOipiG8w+mtVAmtOInSVcc2a1/fbkwHzzO6umpqhU1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLQU8//zsVg27fE2swo3MWH8Ik5ROtHN68/4n8Fgdyk=;
 b=uVITGrPXpz2PeLcn4gdk3f2YztzbfJXFQLiBVRxxyBVE6GezDRMT5+8ac1pFdDuBT319oqDdJCmZRRar3394txEznJtDJtYX8nescbmA0N7srDyN9t5AOvD2svcmR5vmDzXBRWMbY7kxL4t0cvnlf6xV2i4NFbyH56qxAnqqnP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by CH2PR12MB4150.namprd12.prod.outlook.com (2603:10b6:610:a6::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 14:39:11 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::d197:9c96:338d:c848]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::d197:9c96:338d:c848%7]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 14:39:11 +0000
Message-ID: <530a9d32-7055-fc4f-f725-ae60e6867334@amd.com>
Date: Wed, 4 Jan 2023 20:08:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [RFC 3/7] drm/amdgpu: Create MQD for userspace queue
To: Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-4-shashank.sharma@amd.com>
 <CADnq5_NONiTu2oEEV1+epbuaH985QBbqMKuM9ZDYEn7Ar5a2pw@mail.gmail.com>
 <d19ada1d-86c1-7278-9bf2-a7571c2830e1@amd.com>
 <a71ce770-7e36-0589-2c47-b0381566541c@amd.com>
 <a75feb71-1121-63cd-5292-503588ee9c88@amd.com>
 <a168df59-8cd3-0262-473a-c4b5f63dc491@amd.com>
 <ced7bb3b-6de2-145c-ccfd-1143529f0990@amd.com>
 <8b00b4b7-640d-4a85-b98f-8fd2a277bea5@amd.com>
 <393ab51d-c4bc-07d4-7502-884d188a61d6@amd.com>
 <b4a601d4-4d08-fea7-5eaa-772194fd6b1a@amd.com>
Content-Language: en-US
From: "Yadav, Arvind" <arvyadav@amd.com>
In-Reply-To: <b4a601d4-4d08-fea7-5eaa-772194fd6b1a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::32) To PH7PR12MB6000.namprd12.prod.outlook.com
 (2603:10b6:510:1dc::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6000:EE_|CH2PR12MB4150:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b1604f4-f1a2-4b3b-a1f7-08daee61713d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fXPJpryQSrKoGQS83skF5JE6BFC5QfaxQ5ib2DKnj3Vxp9hVr2qYHWR3/KRjYnmHH5V/dpIZVrUuIp5fhTI6DpL6oShwNtwBRn7fqsByC7yKABISWh75N0xXyLs7qCDnkgdw+zmWDPgGozlkwChdrIZIvseqPXmw4nwIzJgXPVQn5F0o8k2/YrUfGvQk7sffP+0QDV9GJIll20fm6yuCf1QVFhiluWdvy+RvcXEUELgWcKJcITcQcFd+Q+9RtKPum8ugtmx+EHAvazvRPNR3e0C1ZlE6txzZ6WXbsvZQGLRtS+4Fta0HAWev1BLgkWhHWPMaueC81tlYfScPpypeT/zXwMN2QU05pYJAw6cTX8Yl4XwSQXt80seW4lzqe5UYHYeEwDHrE4Dm10uxs+GghkbNxRcLxKL389Hh34vickRh8rpE/refOlZuqZDa74gT4QU0ZUt9Y3xY3sikNqvMxH5pySZ0XAV3aevWeCHYamgqa1cuMwjYjvxUDYvyaJIZiWl2V+zCRZZYFLEh29L3ii4157aO6sq/TqoMiji92D5qj2QacwIIp6ox8+d3FA+OdbMS2BtVqXvKnBYyXpDDuyV9LDi/EovhBZ0y63f7DPSS05OXHiFqLC+ZogxRNZGp9uQgmQ+Vr9ZQBNYVdo7ZNIkKfJrrXlXuRMtFt5yXgth9ijrPoHV3Rv7ZR3oslwNgdTwGijG9in+LQwNVJAnsBITvp6vFeHc9Q6HyfKHcOCk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199015)(5660300002)(4326008)(41300700001)(316002)(66476007)(66556008)(8676002)(66946007)(8936002)(110136005)(2906002)(6666004)(6506007)(478600001)(6512007)(6486002)(26005)(53546011)(186003)(31686004)(31696002)(66574015)(2616005)(83380400001)(36756003)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3UvN1FZMk5nOEtMZ2RxODdoTnkvVzIzL3VpU3VqZW5VZXBFK0FLMmNLaURQ?=
 =?utf-8?B?R0ovYVJhWlp5eVM2MnR0dkE4Q3hnK21YUERnRXVoR1hPeUJ5dkY1YUZkUVpU?=
 =?utf-8?B?bzBQaWsxOXljN0JFcDB6aVRuZnlqaC82THAvNlRXdnBOVGZJakJVS1pham9Q?=
 =?utf-8?B?NDAvNWpUS042TGFnK01kTnY4NG5KenpRQ2RPQXRMQWZHMGxMeVRQZE4yZmQy?=
 =?utf-8?B?V2h3VGQ1OE1aYm1XS3loWmtleTB0ZlBHMnFyVWpQcVkwSm96amtUd0EySEk2?=
 =?utf-8?B?ZWxyNll0N3NpMmNQWnJ6ejhpZXdjYzRXb3dNenlkT0tPZE96c2tOR2RYSWxa?=
 =?utf-8?B?UzhrbzdZWDFFWmtXN0taL3lCOXNHSnFXSmNIdXQwekZscUNkZkl0R0FGeDFG?=
 =?utf-8?B?QWxiUWljN1hzTWdpSE5DeHc5VERiY3RBMGhIRy96enZZTElIV2hidjgyNnJI?=
 =?utf-8?B?LzBQMnh1Rnk4RHY1d2ZTL28ybCtzTDRwNzVrU1V5Uk9sZFUvTVBZeHVsbWJL?=
 =?utf-8?B?a01sMzhOa1NZdjRsRk1BcHNNWDhNa3ZyZ0Vya0VDRmEvbWFtSnNmYmZURU9R?=
 =?utf-8?B?K09zTlRpdlFvN2NUOWxUdkVuWmhQUTJqTEtDcHp2OHlYamFSaGJqNm9wR1R3?=
 =?utf-8?B?bFgxYW1WRDE0M0l0amVrOHI5bFJjWDdreU5Ebk8rUGpHenZqekN2MmtRZjhT?=
 =?utf-8?B?b0NEZXEwQVgvZFNyeWVHWUR1ZEZEQzVLN3RyR2JhZEoxQkc4VVphVjNtVXpF?=
 =?utf-8?B?MCtJQWdEd3R6T05ncnE2N3NrVVhIU3VDRHNhV3F4REcrQVI1OC9HTzVCUW1o?=
 =?utf-8?B?U0NhNW5WazBFbkZNbkxlNmtFeXc3YVJFOTRHTnFDY0F1TFFSQW4vWHY5QStQ?=
 =?utf-8?B?ZHRvL2pYKzQ5Y1RYSlpRSUZ4OTBpbmlJZDMrbkZyV2huclBkczgza0pJcHVU?=
 =?utf-8?B?aExDM2hFRW9aVk9ybDhZWG1Nd1hpWlJIYnV3QjlOcmVrQXFzaHFiQnpiLzNW?=
 =?utf-8?B?QmtjeDZFY280aDg3OXBjTXBJOXBqYXRuT2pzM2pQaEpPektCV3QwbGJ6OU5Y?=
 =?utf-8?B?UGE1M25WZ0hhWml5RmlZR1RNaUNQRERacEt5d2FLVTJEUkY1ZkNKMHc2K3JM?=
 =?utf-8?B?b1c5cExrWWpzQy9yRUlmR0VvVXlBMjhVa3VZU2xNRG5LWnVIK0JvVWh2T3VF?=
 =?utf-8?B?TDk2OUxGcXRwQ3BBT0gweEZDRk8yeVcwOXpUd3JiY2J1ZlZmQnJoeDFrRkxW?=
 =?utf-8?B?OWYwa1prajdodGVVN2xDMW05cjBMd1pXMkNlVmtsbTBDdFB3QlRrNmQ1R1d6?=
 =?utf-8?B?Y2IvNkdmS3U2N29xSDNqRkx4QnJGc1dOblcyeEtWRTYyNVRRK2E3OWRvM0d3?=
 =?utf-8?B?TnVCV0cwNlc2TUdJSVhnZUpXWEhQVG4rRGN4UVJwalZ1VUVJZjErZEpmaHBu?=
 =?utf-8?B?YnJkY2tjd0lyNkF4S2p2akFBUExoL29nTmFzL0FmdDZFZ293c3lXdmpaeEZX?=
 =?utf-8?B?enRaNW94N0lRU1R3VFY3L0dkd2Q4Rm9uKzFTdFB5WWdvR1hFVVUxUG1Fb0Zn?=
 =?utf-8?B?YmcyT0plcmlsd2o1bzdFVUM5RWZ1MVljTjJtZlBobCtMdTQrTExQL1F0bU1o?=
 =?utf-8?B?MWtwN2dWUEZvOFF2VkV6OTFCZHhHVmlrVWxOcUl2ZkN3UUFWMXNZcU5nZlZw?=
 =?utf-8?B?UWRmQ1RQcDBrSXAwYkwxZlpNTDhVSVRnWS9XK0NOS1d6SHJ5UTRCVXlSbkVp?=
 =?utf-8?B?WmtoT1JNZHJuMk9HZmIxS3FXbVJKd1JJL0lYdXFycG5POXo0Y1EvNmJKT29y?=
 =?utf-8?B?ZGZMYmlNa2h1Yjk4MDhQc0tnaHdxSUpNZTVBQUxQajdsR25SYlY0YzBidkd4?=
 =?utf-8?B?VkNJd0lnd1RMZitCQXNUb0VQU3VzS0UweDI2L2tGNmdWTnN1bFlscm1HbDFP?=
 =?utf-8?B?aWRMY1gxMUw4dXgyb0RIWkN5Y2lsTlhmZFJnSEVDVVNUT0VobVE2eUIvL0FL?=
 =?utf-8?B?WkVDLzRoejBkVDFuQVVrMUVmVnA0Ykc2WmExYll1eDRkeGpJUjhWZnYrUnlm?=
 =?utf-8?B?N3V5dkN1TmRxT3UwUzVVTi9GUWI5aEE3UGNQTlRObG1hVitpOEhOODNSbmp1?=
 =?utf-8?Q?ONUAVwqw5jy/KTvoboxZqi9sT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1604f4-f1a2-4b3b-a1f7-08daee61713d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 14:39:10.9803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ykDw+wEyO1saiYZqt0eQxzFFp5MPJS+Tqj8h/aaBAQl321U0lzFew4u0zA8er4HLOA+3qON/0mpqri3MHmg+Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4150
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 arvind.yadav@amd.com, arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 1/4/2023 8:05 PM, Felix Kuehling wrote:
> Am 2023-01-04 um 04:23 schrieb Shashank Sharma:
>>
>> On 04/01/2023 10:17, Christian König wrote:
>>> Am 04.01.23 um 10:13 schrieb Shashank Sharma:
>>>>
>>>> On 04/01/2023 10:10, Christian König wrote:
>>>>> Am 04.01.23 um 07:21 schrieb Yadav, Arvind:
>>>>>>
>>>>>> On 1/4/2023 12:07 AM, Felix Kuehling wrote:
>>>>>>> Am 2023-01-03 um 04:36 schrieb Shashank Sharma:
>>>>>>>>>> /*MQD struct for usermode Queue*/
>>>>>>>>>> +struct amdgpu_usermode_queue_mqd
>>>>>>>>> This is specific to GC 11.  Every IP and version will have its 
>>>>>>>>> own MQD
>>>>>>>>> format.  That should live in the IP specific code, not the 
>>>>>>>>> generic
>>>>>>>>> code.  We already have the generic MQD parameters that we need 
>>>>>>>>> from
>>>>>>>>> the userq IOCTL.
>>>>>>>>
>>>>>>>> Noted, we can separate out the generic parameters from gen 
>>>>>>>> specific parameter, and will try to wrap it around the generic 
>>>>>>>> structure.
>>>>>>>>
>>>>>>>> - Shashank
>>>>>>>
>>>>>>> Is there a reason why you can't use "struct v11_compute_mqd" 
>>>>>>> from v11_structs.h?
>>>>>>
>>>>>> Hi Felix,
>>>>>>
>>>>>> Yes,  V11_compute_mqd does not have these below member which is 
>>>>>> needed for usermode queue.
>>>>>>
>>>>>>     uint32_t shadow_base_lo; // offset: 0  (0x0)
>>>>>>     uint32_t shadow_base_hi; // offset: 1  (0x1)
>>>>>>     uint32_t gds_bkup_base_lo ; // offset: 2  (0x2)
>>>>>>     uint32_t gds_bkup_base_hi ; // offset: 3  (0x3)
>>>>>>     uint32_t fw_work_area_base_lo; // offset: 4  (0x4)
>>>>>>     uint32_t fw_work_area_base_hi; // offset: 5  (0x5)
>>>>>>     uint32_t shadow_initialized; // offset: 6  (0x6)
>>>>>>     uint32_t ib_vmid; // offset: 7  (0x7)
>>>>>>
>>>>>> So we had to add new MQD structs.
>>>>>
>>>>> Would it make more sense to update the existing MQD structures 
>>>>> than adding new ones?
>>>>>
>>>> Imo, It might be a bit complicated in the bring-up state, but we 
>>>> can take a note of converting this structure into a union of two, 
>>>> or may be renaming it into a superset structure.
>>>
>>> Union? Does that mean we have stuff which is individual for both 
>>> versions of the struct?
>> So far it seems like Gfx MQD structure is a superset of two, but we 
>> have not compared them neck-to-neck yet, hence I feel like we can 
>> defer this task for sometime (but add into to-do list).
>
> v11_gfx_mqd has these fields reserved. Updating the definition with 
> the fields you need should not be a problem. v11_gfx_mqd is already 
> used in gfx_v11_0.c.
>
> The firmware shouldn't care much whether a queue is a kernel mode 
> queue or a user mode queue. The MQD layout should be the same. So 
> having two different structure definitions in two different places 
> doesn't make sense. I don't think it's wise to leave this for cleanup 
> later. That would only cause churn and ultimately more work than doing 
> the right thing in the first place.
>
Thankyou for your comment. We will update as per your suggestions.

~arvind

> Regards,
>   Felix
>
>
>
>>>
>>> BTW: Could we drop the "// offset:" stuff? This could cause problems 
>>> with automated checkers.
>>
>> Sure, we will do it.
>>
>> - Shashank
>>
>>>
>>> Christian.
>>>
>>>>
>>>> - Shashank
>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>
>>>>>> thanks
>>>>>>
>>>>>> ~arvind
>>>>>>
>>>>>>>
>>>>>>> Regards,
>>>>>>>   Felix
>>>>>>>
>>>>>
>>>
