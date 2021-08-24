Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9803C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 13:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 999DB611AF
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 13:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 999DB611AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E0CC6E02F;
	Tue, 24 Aug 2021 13:24:10 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2083.outbound.protection.outlook.com [40.107.96.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BE546E02F
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 13:24:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oD4GhrC7qE6PL48tM9T4BskPgnz6cZSKlj3pEH9835N0jx+OnKNbRRznwgNohp6vVzIdzOnIqs5YOYiSbS2K4hIBjKRFpwmsCx3nNCBks61mbjivTt73pIzKlay1uItwjZoPBszM4bb0M1i3MX1XQJPt1hwVgxVBAjehE3RPOz8An6I3nnXHCtBDpkbpbmNPIFKhoBAsKMb+rHJndQ0ZL80tFsnvUKsMgkWafPObll04+lexRPyzOzAL3Db6cl3TSQLVli+N7/45xln9mNyKo8u5OasezjEs6r5pBCUISsoE362tahg8E6+9Xrh2WfX+j0CpCxK9BzYVqTUXtdo0Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4j7Hicn/e58iwcwp29Z6KVYEVXzc7QNl9s1Vm1z9Rs=;
 b=EU4l2ow7yRKENQkTmAYFzwVFXW/Vi7bAKbmPjOg592exLbpgqSE7S1xxoBR81F6aCdw4tX2OykE9L+L9NNaH+jQf9D4bSn9pgDC4xrCJnww1ZCOY+A7GhhvKnuB06kNrhwAG40jInDXMu81d2xwBXpSV3X3Iu8GG8jV5tEn/X4e1PT9rxqQ+7nt3C7EtMkCbex9cX9kasa+q+IdOsz0+OkRWjeupNLOvp9IG7GqJBYbn+44sS0d6lbTcScZMUHa+swVsUXkHgdATetjp6dcHXrYdNVq14Z9oJtUvErx0c1sNsRUyorObbpC4hyBiVSNYVbZImbydO7A1JXBCq++TZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4j7Hicn/e58iwcwp29Z6KVYEVXzc7QNl9s1Vm1z9Rs=;
 b=yJ0IJXzTYyl392mTYX+rQCy5Gblsnb7/rsQdISKnc2rdahH/Xki5Jkm9robYoBewZvyY2tVrV7z4JIa9b8Dus608YYaHxtZAVmDyEr54GUmnReJ3vSSY/1MFWwnacNwQfRj78ocfPL0WHR75pIxVk4Fhx+ZcnyhGW3/8KbpS5es=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Tue, 24 Aug
 2021 13:24:06 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%7]) with mapi id 15.20.4457.017; Tue, 24 Aug 2021
 13:24:06 +0000
Subject: Re: [PATCH 1/5] drm/sched:add new priority level
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Satyajit Sahu <satyajit.sahu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com, Alexander.Deucher@amd.com, shashank.sharma@amd.com
References: <20210824055510.1189185-1-satyajit.sahu@amd.com>
 <66607af7-5310-629f-1851-df4b74cebf7d@amd.com>
 <4e2337a6-8d76-49ba-c0b3-e89f4c04b4a0@amd.com>
 <49509444-2e27-86e6-abe5-8a44dedc0f10@amd.com>
 <89f6e6e7-662d-995f-a281-7e5712fff772@amd.com>
 <6223bf14-653c-12c5-d871-483d43aca98f@gmail.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <066afec4-7955-bbf8-78d7-36da4bc738d9@amd.com>
Date: Tue, 24 Aug 2021 15:23:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <6223bf14-653c-12c5-d871-483d43aca98f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0027.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::40) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.54.68] (165.204.72.6) by
 AM0PR02CA0027.eurprd02.prod.outlook.com (2603:10a6:208:3e::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 13:24:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 333c58ee-04d5-46ee-93c2-08d96702728d
X-MS-TrafficTypeDiagnostic: DM4PR12MB5136:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB51363D835438DAF86C44C0DF8BC59@DM4PR12MB5136.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bvSuN2m52F5HXMsBXFVF2xZmMiTVoPFa3o9rq0L5d4JzT5M0TbJWCKGlTOSUUAPJXDJDa5/a76wVx79Y5jsy1ctBHwvF9cJjxSIVOTatsOcwz8Mqg16GFjy24dOqEsKJqCnFB1Bx5YdQI7jZiIAyzQIIV/WBs29nqfcclfJZtLPOkhF6AUsoDUYgdrLrn9gIJ/fRm51gVjIMngzsvILzqUhZ1zFojAU+CyCDGJf6ujyV5/H7dtvo8u3PrNfolBRmc4EU7d/fYQrxnHgDMHi2GHzry0udASVnQ7gmU/JKCLOJzDbqyp6g8xasf5N7zyKZorXTfLJOJNat5+m6D/1m7ywV9h5B0ZCyix9pOJ0LkVVl5RIp4bVKRR0/gGn7HQjSHkmPznj1qcLV6VgwsvRWcte6GqlrDiBdSFqujce7uh+JfBsHJDFoh8fHs9sef/m0RcSkLOH+3R24zFuWQ6QghBI1+mR39kA8ZPosYDK3Zbw6PMGfSwuZIfVs3eAcyxchOUJltFVZzLE/OZAaceSdlb/MDzbnhK6OSPU1GGO/fufvjpN/sWG19rxBR75sMGp/LNwIzNRyPpWlO7gwM0VK2n8+reGzvTIpxSZDqmC87i4BMxKXZV5zUNtcGATT44jKpgqyalGcfv6Ew6sYXCnMEZLbb71YuCz9CMA4RkEZd07a/OCFrOTY18Xs2DjetJ5Vbn1e9QQCn5r/zKLGCsqA8GwjghXWa9h3XKsKDAhS9Mjm8cRMP2PBEUIqIQeme3mI8SAdVL5tXN2hu0BVXfC5xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(31696002)(66556008)(52116002)(8676002)(66476007)(8936002)(53546011)(6666004)(86362001)(38100700002)(38350700002)(66946007)(316002)(66574015)(26005)(2906002)(186003)(110136005)(5660300002)(6486002)(36756003)(16576012)(4326008)(478600001)(31686004)(956004)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1RpQ0VucEl4L1ZiY0FDaHYzb09FMUlEMkdyNGd2UnN5WE5RRkRIdHV3R0xU?=
 =?utf-8?B?RXNWSXl1T2Fpa1EyMEx5Q3c3MWtybEJSTWROZUt2bHV3Ny8xU1lMM0V5UXBY?=
 =?utf-8?B?emNNWHFvZS85MG00ZWZzcCsvazRYeUNvNGNQUVBUZnhlL29CeHR2ZW1hYW1y?=
 =?utf-8?B?ckt1bVQwR0t4VEZnN1p2TVBhM0dyc1JGL1A1ZjhQcnp0RGJSV2dkc0R0bFVl?=
 =?utf-8?B?UVlUWWZxcjRhNDY4K3VmdExndlVVSXFvcFFvR2hLeHpkcWJsWmlvTzRpOS9W?=
 =?utf-8?B?amwyaXg1d3VtRkVlcm9kZE9FWjl5a2psMmhaTmluL2dQa2M0S3k0NzM4Uy9L?=
 =?utf-8?B?Mm1PVmRoQlJZdmIydG5WN0xSMjNjVDd1NVVROXNMMXNpNE1yOEVURyszTjRx?=
 =?utf-8?B?L29BeHFNVHg1RFdobmo4T3U4MnBRODZXZEVBV2p1YmhwbzlHVlFxTW1qU1pD?=
 =?utf-8?B?SVpHYUZqeEVwS3Q5aUVJOCs2TVRyUm5XMVBFOFhUVjNNaE5Ea3FndFVVYjB3?=
 =?utf-8?B?SDN4dFdjNC9DRHFPckczL1ZtQnFVc0RsTTZueStlU0VFS1R1TzhUbXdBb0pl?=
 =?utf-8?B?R0RmT29RRWdVVm1pdTVKV1hIUUNKaC9CbS9udVhxY0xHL1dNckF1NjJEcFZI?=
 =?utf-8?B?c2NGRTBCTFBrK09pWGh6TWd1OUdBZmJ6cldYWnZXZExVNmdBNy93M2tncHQ1?=
 =?utf-8?B?TlZpK0VVRGFvenFHRUNPNEQ3QVZFRmJ3cUc5NnZqTWc0dEVJSitIQk4yRVMz?=
 =?utf-8?B?dUtZNzY1QklEOVJTTDYrVHljZVpvaVduaWRuSk9PQkd3eEY2TmdLdTFUTUhX?=
 =?utf-8?B?L2MwZ0V0czNqNWFacUw0UmVNK1h1aC9XbDAraFpNVDZ6MEpDNHNVWngyalE0?=
 =?utf-8?B?b1BIK2NnaDVuMCtDWkdidTlQTFphZXFxak01Rk5PTStoZW9aY2V2d2JmdzVI?=
 =?utf-8?B?QWQ3MlNWQWx0bEE3Z0F2VExRNDcxOXZ1V1l1OTFnUUozMm1DN0tHeTJUeVpz?=
 =?utf-8?B?T0syeFpwVVpid0J0K1VKZ1RvM0h0cHZ1Y05ONkxUaUxUVDFERGN4Rjl3WWpX?=
 =?utf-8?B?ZmRvMVlmV2dCU2FRdVNlNmN6N3RHdE8xQmJ5Q2RqbWlINUlrbDgzZFZscGkr?=
 =?utf-8?B?QzlqNlBJU3JhSlkyMkVwVXRXVWVPRENZSGR2RzlZNUg3cUdvZ21PcmJ4ak1P?=
 =?utf-8?B?dXVqdWxyRk50blhETldBYzRhSDRQVDlkUEJRZmViZloremsxQUh4UVJoVGNE?=
 =?utf-8?B?WSs1VkpiTnRkMDZtNVVNOWdRS2x6b2xPUEQzTkVySWNPRTkxM1R1MTVkb0RE?=
 =?utf-8?B?WVBaSEhYcXBrc0VxT01EMVNES1NOWkdteVd3S3kvN3ZFbnVhdVJuTjhuWU54?=
 =?utf-8?B?TGg4UGhzMWhlN1J2QkQ5R2FRQXlRUkNyZlluRFJma2tJTnYyWDI2YUhWOWRi?=
 =?utf-8?B?QjZNdDhSM2dhMjh2Nkswc051VG5QY21FOTdxRG9odVFNbEVTZWYzb3V5N1lx?=
 =?utf-8?B?UnB1b0pBRjJOZzdIcm9lbHh5OTJXeC90dmh1b3FNbGtTMnRGN3ZNU3gvZmZB?=
 =?utf-8?B?Sk00d2VpdENFUFNJRzVMMEYyVVpkc0dhMzlGWnJYTWFmaEhiV0N0WitLSHd2?=
 =?utf-8?B?OFkxTHhobTJXN2tEckdrb3pDN1c5NGdIWWxXcElWWFFIdDkrNHJpdVNjRk9r?=
 =?utf-8?B?Wlo3WUd3b2dFbnRLWjVMTHRtdUEwQ0lLN0RsaGZYaXJWa0lqV3NpbW8vSUho?=
 =?utf-8?Q?3RDQr/H+cntLTABv+/xY3ehX+a6nKmx0NTeBmUO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 333c58ee-04d5-46ee-93c2-08d96702728d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 13:24:06.2626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNSwIl3o2thg66j01Vh2xqMYxbncsJ7FA052VBbaVoricQfLD8YkqhyhCEAVve4pgic1sSzzd0IZ/DJ+cZwXlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5136
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


On 8/24/2021 3:18 PM, Christian König wrote:
> Am 24.08.21 um 14:39 schrieb Das, Nirmoy:
>>
>> On 8/24/2021 2:07 PM, Christian König wrote:
>>> Am 24.08.21 um 13:57 schrieb Das, Nirmoy:
>>>> Hi Christian,
>>>>
>>>> On 8/24/2021 8:10 AM, Christian König wrote:
>>>>> I haven't followed the previous discussion, but that looks like 
>>>>> this change is based on a misunderstanding.
>>>>
>>>>
>>>> In previous discussion I sort of suggested to have new DRM prio as 
>>>> I didn't see any other way to map priority provided by the 
>>>> userspace to this new 3rd hw priority.
>>>>
>>>> Do you think we should use other information from userspace like 
>>>> queue id to determine hardware priority ?
>>>
>>> If I'm not completely mistaken we have dropped the concept of 
>>> exposing multiple queues/instances completely.
>>
>>
>> Yes, that is my understanding too.
>>
>>>
>>> What we should probably do is to use the (cleaned up) UAPI enum for 
>>> init_priority and override_priority instead of the drm scheduler enums.
>>
>>
>> I went through the drm code, now I see what you mean. So what we are 
>> now doing is:  mapping  AMDGPU_CTX_PRIORITY_*  to 
>> DRM_SCHED_PRIORITY_*  and then to hw priority which is not nice.
>>
>> We should rather map AMDGPU_CTX_PRIORITY_* to hw priority directly.
>
> Exactly that's my idea, yes.
>
> If you want feel free to put this on your TODO for a potential cleanup.


Yes Sure, I will try have a patch ready asap so that Satyajit can work 
on top of that.


Regards,

Nirmoy

>
> Christian.
>
>>
>>
>> Regards,
>>
>> Nirmoy
>>
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>>
>>>> Regards,
>>>>
>>>> Nirmoy
>>>>
>>>>>
>>>>> Those here are the software priorities used in the scheduler, but 
>>>>> what you are working on are the hardware priorities.
>>>>>
>>>>> That are two completely different things which we shouldn't mix up.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>> Am 24.08.21 um 07:55 schrieb Satyajit Sahu:
>>>>>> Adding a new priority level DRM_SCHED_PRIORITY_VERY_HIGH
>>>>>>
>>>>>> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
>>>>>> ---
>>>>>>   include/drm/gpu_scheduler.h | 1 +
>>>>>>   1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/include/drm/gpu_scheduler.h 
>>>>>> b/include/drm/gpu_scheduler.h
>>>>>> index d18af49fd009..d0e5e234da5f 100644
>>>>>> --- a/include/drm/gpu_scheduler.h
>>>>>> +++ b/include/drm/gpu_scheduler.h
>>>>>> @@ -40,6 +40,7 @@ enum drm_sched_priority {
>>>>>>       DRM_SCHED_PRIORITY_MIN,
>>>>>>       DRM_SCHED_PRIORITY_NORMAL,
>>>>>>       DRM_SCHED_PRIORITY_HIGH,
>>>>>> +    DRM_SCHED_PRIORITY_VERY_HIGH,
>>>>>>       DRM_SCHED_PRIORITY_KERNEL,
>>>>>>         DRM_SCHED_PRIORITY_COUNT,
>>>>>
>>>
>
