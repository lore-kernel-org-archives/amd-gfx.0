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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2E1C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 11:56:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E8C60EE0
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 11:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 14E8C60EE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90C5289789;
	Tue, 24 Aug 2021 11:56:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF33889718
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 11:56:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrNcVEhQsq8HH3FDQ7308R1RUsQhPe14H/nYHkPtWjtXrD5PfAc2JNRnXIIwlgJnOR7EVrof4tKgTN4C1nws79RtcbTTvIHOWpSDIe8SwWBns7ZqUNvCn8Abf6A5jbF0Akt5L7/F7sOm/mqG88ojyeBvMTXNhhb93Fvc+78CMRpa3Kz31FLBUekDVvr4FSrJ2r0wcTkxyfVT/xBMlesXzJKYjbeRUhR+02ggmYxwDykRKg6V34qPAraOJYfs/k4ixvDP0E5jlWIT2pTo9Dfla5hbmoH4iY9NicDsCd+H9vSx0B274utZdCUMUBKSNjKk9aYdPLXuBCE99/B5NEn2Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZFaYq1a6fk9MKCMEe0m0+DcdZpC9Il538YOsHuI37Y=;
 b=jKdWXjOuxDKtcqXEbXzb0HFbZSz45C16lx48ASq+n861aFkb7yB6zO4hDRklPN7JYG1I1TJuPa42BsqoOgq/wdWIE7++76FLn69XIu9ZeCM5vGqKNfe1DxsSF3YI1h39/Dk9balZV9OmGgHr90yvIdrOyC4ggIeNQa3eCO8a/B5Vyf2xeZGr84Veb7AoV91IBTakcXZsBhUlB8P+v6yoFDp8zldvnXfd3YwiRUjHiZF9uhdmsgTnhDxNDlLc0e2q/3V+7T+kwK1f4013cB0DyDIID1yZPplq25VAVxLI2tT6a+tkxjs3XVEeOKjW3stkvTvD6ODudB7+PiuutMWxjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZFaYq1a6fk9MKCMEe0m0+DcdZpC9Il538YOsHuI37Y=;
 b=ILWHC83hQJsetN5vHvIYO7QLQs8HltmyXq33wljrZME3ocOHXTyoX4G43XP1+cdqPaHlxv2W30TjAmVuUmVUPhiVUhvK3bpOywOlVE9dS+eDM3UuPFhuo+P1hsKF79nAXn5Sw1Kpqnx2E9bPrPZG4hMQV/WRFFdMNfk1V17OPhE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2450.namprd12.prod.outlook.com (2603:10b6:207:4d::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Tue, 24 Aug
 2021 11:56:22 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 11:56:22 +0000
Subject: Re: [PATCH 1/5] drm/sched:add new priority level
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 Satyajit Sahu <satyajit.sahu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com, Alexander.Deucher@amd.com, nirmoy.das@amd.com
References: <20210824055510.1189185-1-satyajit.sahu@amd.com>
 <66607af7-5310-629f-1851-df4b74cebf7d@amd.com>
 <53fb0d0b-e9c3-3a79-9b17-87e4297737bb@amd.com>
 <2952fe71-5948-de45-728f-5a606a8e9abe@amd.com>
 <55f8f164-ece6-1e8f-1c8d-54cc47cf8bc0@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <4435519f-01a2-7344-9eb4-f9f27cb2f7c1@amd.com>
Date: Tue, 24 Aug 2021 13:56:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <55f8f164-ece6-1e8f-1c8d-54cc47cf8bc0@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM8P251CA0023.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::28) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.21] (91.14.161.181) by
 AM8P251CA0023.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.22 via Frontend Transport; Tue, 24 Aug 2021 11:56:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7781218d-d9f8-478b-0251-08d966f63141
X-MS-TrafficTypeDiagnostic: BL0PR12MB2450:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2450C30E0683899C39EDF3EC83C59@BL0PR12MB2450.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9zEmhd4pfEhkkFTddAKgjXAsW+P8OKuy7TRg/N7DxT4p5wKqwW60EID35wNdN2kARZieW9JMHyeGlsElHxRiNW9zLS5STFwOOlARw267ww/GlsMK9oxu6QYFhVQ3PtHCZjiZZQdqf+bAfqxdyXs7vOlWZVbKXsje4A1oz+7jvVTlszQKrHpUpXqPH+T66hp8q5pfKfysXm9OR2V54W5FAxDUSoKSV0bBkpyZDHyRo0O4DaAJ8gWpq4VfXwOvjB6GdaYnsYxZK+W4b0i+QfbFGvQPNF3jvgFrylzomZGgx1HoZLSijukC4AsfemEXItowADzYtE3KyanLhbnDOLM0jNmX94PS8DUaoJkzr/J7fpDqQWMUQCuGG+YRiYGOaxeg55GHBlBErVyoEMUA4+f4epsEqzbKHU+J5uvZEwijhbNL3cYbJuimkM2PEb5t6Qr5EFA3Bfl5W/VOv+chn/2zzf+j686DBIJea9e7qOmHznLsaEbr8e+fBEJ3n0n6iUvc2w8uoQgcUFRGfh6ohl6kKQHO8yI0SeUjdOPd1gmz7dfz49mhR9Y4Gyl5pfaMXcGA4kEAhBhvLduhTGq3zM3g6Iaarb/jBwUTNPKZk0wnbX72szbOWehDKDDzi8vY3oRMY085NS24mrr7plkSji69O3lBUJ3iOXiOd5b5+0mum4HQeTwR5gZCajpOdVSLJQGCmyXrJ7IiBd0iTWZdgNFiRHsrXO29dczaCtxdM8voOsXbIBia+jsivt/yl1sZSvWI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(86362001)(2906002)(6486002)(31686004)(16576012)(31696002)(66946007)(26005)(8936002)(5660300002)(956004)(66476007)(83380400001)(53546011)(66556008)(8676002)(36756003)(316002)(478600001)(110136005)(6666004)(4326008)(186003)(2616005)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0p3czlrWnRMYW5TMU9NaFZnc0NuTTYwY2FrdVFCR1NFUXZ5ejU2RXp1bk43?=
 =?utf-8?B?emIrMHhCYnoxdHNRbnYwL3ZZOXdNUnYyaWdxek41MUVENjZZV0hmKzVqaUxx?=
 =?utf-8?B?UEZpc08vY0ZycHZrakhwNCtMclBvQlNkYjFaQXM1aXA1K0paS1dWMnVXNXA3?=
 =?utf-8?B?azBQYWZwbkYwT3BsRy9kRDRNSTQwVjhsWWUyWHNwMEZYSGZKRFgzV01xMXkv?=
 =?utf-8?B?dld5MmQydStNcldjc2RaY0ZBRzdxL2s1a2tTU3VvLzROWVd3Wmk4YlBoK0FU?=
 =?utf-8?B?V1ZQdkl0L3poL25FNjRyQUgzMnovYkNEZDd2MTFLd3QrY0twelR5UGQrOUNV?=
 =?utf-8?B?bzljODdMSlo2TU9FME5vaTdvNjA1c3BDSGgrM1pRRGQ4TktjUDdZamtJWVoz?=
 =?utf-8?B?SFZvVTFzQkJUTHVaZCtkbXl0UzlZOXVxWTFRVlBoYUQwUno3N2wwY1E2bU0w?=
 =?utf-8?B?UGlBUzdOSkJhSW9pK2dSKzgvbU95Rk5NbTF5eElsNys5RitzM3pQMGNQV1Zt?=
 =?utf-8?B?YW51T0ZTckZxTXhCSTVua21zNTFXak9ndHZrTklDay93d2R6OXNyd3hoRUFQ?=
 =?utf-8?B?UjZ6Z0xFL1FPTERCMGkzaXdXNmErMEU3QXpqbDhXcWVIMFQ1VUZ4L2FWOVNq?=
 =?utf-8?B?L1J6TVhRTXBmUUcwSlJKWUt6ZVA1OGdhdGVqOCtaOUZVNTZqaUtReTFZd2lu?=
 =?utf-8?B?Wlpmd3lMTnBJQWlhenZQM3JEUytkcFlVMWMvR29uMGlla3BrMU5qTXRBUHJV?=
 =?utf-8?B?SHk1T3FFcldFbFpMQlJ2TldKRUpKR3h1OFRtcW9jNFk1Uy8wYVM5bmhrKytK?=
 =?utf-8?B?OWlPVDlQcng2SmZ6RzhkTlQ0Z3hqMSsydkswWFBVNHdjOFNIWGxSK2dzcm1U?=
 =?utf-8?B?ZnFHK0pMQktWTHJnelVwWVozUlYzU1pYdklTRHY3blRzSXQ1OS9iWG9zMGpk?=
 =?utf-8?B?RGNENWR4ZFpqUWNFSlAyalpCT3VteEl2VXF0TnV4djFQMTYwTmJPOFZVcHJF?=
 =?utf-8?B?dmgwMzVRWW81dERkZllDY1lUUW8xQWZXYUFLQTFOSmVSYnhIWmN4d2VtWTVM?=
 =?utf-8?B?cDR4ZHl2Si9lV0NyV29aU1Y5ZEw2Y3lSMERhd1hWTzR1VzlwQzBsR0ZTdDZz?=
 =?utf-8?B?eHg1MjFDMG92TWpQZkRyR05BRnY3T2g1TVpTazdoM0IxaWFpSTBheFQxUTJW?=
 =?utf-8?B?L29vbXVYeFNmS0JlS0p2VkJObGJUTFdhZEpXNStZR3U2YmhOZWs4TElPMzBa?=
 =?utf-8?B?MGk1aElqaEpLc0xYdUo5VllpSG9OMTg2cDNnY21MMVNocldWRmFHZkxMSy9s?=
 =?utf-8?B?a1VndjNpMUJUdjlXZm9SUytGTFhKR0NSbjBPU2w2NnBvV1NVRmhyQjkrc1Fr?=
 =?utf-8?B?a3dOK1NFK3Zjd1pEQklRSmFZNmZpWTY4a3hOMTk4OG9XQnFHbmg5TzNYYnk1?=
 =?utf-8?B?ZFFoZnoxeG9ZNlQrdzByQW4vcUNqWk1OQ0NTNGs5eXNyamNKeis2aUY3TTBH?=
 =?utf-8?B?RW1vVUxRbHloR3FiU20yRmx2SHRxSGp1MVYwRkpROVBtajVHbC9peVVkVkh3?=
 =?utf-8?B?M2JmV09qay9xTEJHSkhzVVJvaUphZUZ5RS9HUXA2ZVBHRHRvOTNtUS9LaXVK?=
 =?utf-8?B?cUhKNTBBOGpjUXFPQndEb0dQSTRJd1hnYnh4blo0eWo3dFRLMGptSTdwYmxj?=
 =?utf-8?B?Y2YyNGdJZ3ZYOFkxRzdrZWdMVjVVTUhtdGpGbkMvY01tV2xKZDdyUk85SVpT?=
 =?utf-8?Q?FUxQo2zgGYVbimAKQw/u2g3At6aazhCHo3J4jAC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7781218d-d9f8-478b-0251-08d966f63141
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 11:56:22.5466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eL9ZZoBBbKjVQ0N8sUL739JbsbJip3KF+/wdq1yx4LVHzXVtxQIDd8Km5/Bv5oc4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2450
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

Am 24.08.21 um 11:45 schrieb Sharma, Shashank:
> On 8/24/2021 2:25 PM, Christian König wrote:
>> Nope that are two completely different things.
>>
>> The DRM_SCHED_PRIORITY_* exposes a functionality of the software 
>> scheduler. E.g. we try to serve kernel queues first and if those are 
>> empty we use high priority etc....
>>
>> But that functionality is completely independent from the hardware 
>> priority handling. In other words you can different hardware queues 
>> with priorities as well and each of them is served by a software 
>> scheduler.
>>
>> In other words imagine the following setup: Two hardware queues, one 
>> normal and one low latency. Each hardware queue is then feed by a 
>> software scheduler with the priorities low,normal,high,kernel.
>>
>> This configuration then gives you 8 different priorities to use.
>>
>
> Thanks for the details, I was under quite a different impression, this 
> explanation helps.

The problem is that we used the SW scheduler enum for the init_priority 
and override_priority. Which is most likely a bad idea.

> I guess this also means that the HW queues are completely left to be 
> managed by the core driver (Like AMDGPU or I915 etc) as of now, and 
> the DRM framework only provides SW schedulers ?

Yes, exactly.

> Does this suggest a scope of a common framework or abstraction layer 
> for HW queues in DRM ? Most of the architectures/HW will atleast have 
> a NORMAL and a higher priority work queue, and their drivers might be 
> handling them in very similar ways.

I don't think so. IIRC we even have generalized ring buffer functions in 
the linux kernel which barely anybody uses because nearly every hw ring 
buffer is different in one way or another.

Christian.

>
> - Shashank
>
>> Regards,
>> Christian.
>>
>> Am 24.08.21 um 10:32 schrieb Sharma, Shashank:
>>> Hi Christian,
>>> I am a bit curious here.
>>>
>>> I thought it would be a good idea to add a new SW priority level, so 
>>> that any other driver can also utilize this SW infrastructure.
>>>
>>> So it could be like, if you have a HW which matches with SW priority 
>>> levels, directly map your HW queue to the SW priority level, like:
>>>
>>> DRM_SCHED_PRIORITY_VERY_HIGH: mapped to a queue in HW reserved for 
>>> real time or very high priority tasks, which can't be missed
>>>
>>> DRM_SCHED_PRIORITY_HIGH : mapped to a queue of High priority tasks, 
>>> for better experience, like encode/decode operations.
>>>
>>> DRM_SCHED_PRIORITY_NORMAL: default, mapped to a queue of tasks 
>>> without a priority context specified
>>>
>>> DRM_SCHED_PRIORITY_MIN: queue for specifically mentioned low 
>>> priority tasks
>>>
>>> Depending on the HW we are running on, we can map these SW queues to 
>>> corresponding HW queues, isn't it ?
>>>
>>> Regards
>>> Shashank
>>>
>>> On 8/24/2021 11:40 AM, Christian König wrote:
>>>> I haven't followed the previous discussion, but that looks like 
>>>> this change is based on a misunderstanding.
>>>>
>>>> Those here are the software priorities used in the scheduler, but 
>>>> what you are working on are the hardware priorities.
>>>>
>>>> That are two completely different things which we shouldn't mix up.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>> Am 24.08.21 um 07:55 schrieb Satyajit Sahu:
>>>>> Adding a new priority level DRM_SCHED_PRIORITY_VERY_HIGH
>>>>>
>>>>> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
>>>>> ---
>>>>>   include/drm/gpu_scheduler.h | 1 +
>>>>>   1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/include/drm/gpu_scheduler.h 
>>>>> b/include/drm/gpu_scheduler.h
>>>>> index d18af49fd009..d0e5e234da5f 100644
>>>>> --- a/include/drm/gpu_scheduler.h
>>>>> +++ b/include/drm/gpu_scheduler.h
>>>>> @@ -40,6 +40,7 @@ enum drm_sched_priority {
>>>>>       DRM_SCHED_PRIORITY_MIN,
>>>>>       DRM_SCHED_PRIORITY_NORMAL,
>>>>>       DRM_SCHED_PRIORITY_HIGH,
>>>>> +    DRM_SCHED_PRIORITY_VERY_HIGH,
>>>>>       DRM_SCHED_PRIORITY_KERNEL,
>>>>>       DRM_SCHED_PRIORITY_COUNT,
>>>>
>>

