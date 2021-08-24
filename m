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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCF3C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 08:55:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30CD561361
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 08:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 30CD561361
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF9CD896E4;
	Tue, 24 Aug 2021 08:55:29 +0000 (UTC)
X-Greylist: delayed 95387 seconds by postgrey-1.36 at gabe;
 Tue, 24 Aug 2021 08:55:28 UTC
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (unknown
 [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92319896E4
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 08:55:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gt6xsjYdMkiXWOr0+kJT7gvMoK3vLQp0On0k5eZNHzXLcNxUfQDDFmR3MkmppM5l4pZm2XFZkWpLmE5xPPWIltiucXjCFZrlSv+zRUMob2rtVxoN1bVPm4WfEbZ5YOWKKDoJupZAyM8hcvNxN5ePMy5SmrWITMDRuKkI10N9OeScw8iTdWZfAhqlwwGowuIZAHR3RZAGltf1xYzTA45Bt50e02KaX/Nf81vZVzi4MHZ+jDnom+M9Q60fd8JWAlsGV80HkZNQQhNyvoUZdtUH01cd1wFy5vpi99h7DLtFS6AFWjGzxF72vMdvN9aKA4BZgDvOoKIV13GpNamZjvojug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ks2++JLTcj1RqfRHMnqR5F7nMjQy0i4nF1uoTWQ8DVs=;
 b=myDjFf5MTjiSwgC3ADWnjfQtt3EIDsyUn6KDJbP8TV5MtCl9pdM9tFuRcY5+AshOjjiPRCJJ5oHoeFo+aW4f6Iws/KyMdiF1J4jQoYDxbpi1DZYfZTJe81y1mfce6+XKdOLWarsE03wbfbg8TE4aI2Plw5Y81W9UAMOQUrh84lcUMioIPPNWxM+Vykm+NcKNl+ilhPqd1shxy1By65ZeYNuSfrfOzGh4R/b+PI6pp1GAm8avcCLDVWUzewyv5kcIbJ6pkurvF1bKq3n0amlPZthO/vQ3W7g3u32geNOtFBkw3RFsEPRE3QuROHfAf/vK6fmlE5Pt/YVY9+9opRZMmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ks2++JLTcj1RqfRHMnqR5F7nMjQy0i4nF1uoTWQ8DVs=;
 b=kPkJHmD+CzcPfULdUs4MGUkEuS7UFRsOyJo/2jEvvRfftuAeBS45gNxD9PsH8kw7+QgP6PlK0U6o6PgeCPprvBB792pyg17vG7ZOsPtPj1wA2iC4xFp+8ZlOeZ5ODsemDoh78JVYSBUdFP/6qwryvkC6/bW5OrT5uRkM47pT5oQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2451.namprd12.prod.outlook.com (2603:10b6:207:4e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Tue, 24 Aug
 2021 08:55:25 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 08:55:24 +0000
Subject: Re: [PATCH 1/5] drm/sched:add new priority level
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 Satyajit Sahu <satyajit.sahu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com, Alexander.Deucher@amd.com, nirmoy.das@amd.com
References: <20210824055510.1189185-1-satyajit.sahu@amd.com>
 <66607af7-5310-629f-1851-df4b74cebf7d@amd.com>
 <53fb0d0b-e9c3-3a79-9b17-87e4297737bb@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2952fe71-5948-de45-728f-5a606a8e9abe@amd.com>
Date: Tue, 24 Aug 2021 10:55:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <53fb0d0b-e9c3-3a79-9b17-87e4297737bb@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0114.eurprd05.prod.outlook.com
 (2603:10a6:207:2::16) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.21] (91.14.161.181) by
 AM3PR05CA0114.eurprd05.prod.outlook.com (2603:10a6:207:2::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 08:55:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b72ec32-a093-482e-53b7-08d966dce91f
X-MS-TrafficTypeDiagnostic: BL0PR12MB2451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2451EA897609E44C93603DA083C59@BL0PR12MB2451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DFTCmWo+3uWgvNBELHC72PScqdrQy77pkN1/iL1endmvtSxlfa4o5/MoEzOFEnusSDr7QfnoHBpxAr9CrZAVccXPn5kkA4VyoU4KNFegi0Q3q5Nyd3vyEuI5TALLPf5EXD8pn+B2U/XM0zCgJv3Z8fgsYfO718asIdlU9hru72kfN6/ozd85ZjCc8m3/2IH5W7C11U5u1HnZhULqDDb/XEoqoLkzhOdTOB5eQ2J8sLsYfficfs1lTGUI4RMT2sIWJkJgTqZoYmnsPGqOC5TlSsf6M1VA/Q7L3JbrRAtcpneTAWyXzxxnBXuAJSo16WtRzYal6+s7VkaQ6ryuof02v6v3XyyPrcPmYJHq1vl8HGfM7xhxEGL9f+r0wcXIjVuP230adkpsbK6/j3XYWYBMWGyuVHV0661RzXzONNEv4NU+ntv5vrWAA66TeroI7OkluUaXNoHy3lFVRDqWpN+yqN2mFapNK+YZfzT5zldVE2NWOCv1A6KRTDRu18m52M31C0pbd8TpCitNTPLaVvhBKQ8iYNnLJ4jQSnZRGDnHiZ7ut2TJoavxMXYBDuddEhJSIhQxzpmCosZUlzN7is+TI0BJF5SoJVq1VmCCdF3QAMhpsChsXPDJUO/vAHur6YiS2FUk+W0NnTY108MEmI30SRodA+XuT92/wgpvltsRVrDFwLpN5BtD/PKCVBIjz8wWubBxJECGL4tRJo78oTESpUWUA9/lM8xRNavqhpj3ipbYwGZ+nUie7j3ezfmkVWCI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(36756003)(956004)(2906002)(16576012)(8936002)(83380400001)(2616005)(31696002)(4326008)(186003)(110136005)(478600001)(6666004)(38100700002)(8676002)(86362001)(66556008)(66476007)(53546011)(26005)(5660300002)(6486002)(316002)(66946007)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGkxQ0FmdlFtL3ErK1I4UC9BOVpGd0tRZzlrSGg1WnpXeHdLTGVTZTRPRVFr?=
 =?utf-8?B?Y1BxbCtpMmpOTXNpWEJyWWxiQldCa0lnM0E2dEhlVCtVMFd4Ly81UVdXdmZJ?=
 =?utf-8?B?WHdBRUtGaUkzWmxQYUxESjF5MmVTRFhQblVoT1RRVU9FaTdxVmgxNGlBLzBE?=
 =?utf-8?B?cUxSbE84QmRMdDduQ0ZtVkxPOGd4TjBFNDhUZFlXckxidjFtSGJFbnJRVWR5?=
 =?utf-8?B?aXdNeG54WVMxU2VaSG83QlBSZklCajlid3NsVTB4VkRYajJCVzNzSFRrMFVJ?=
 =?utf-8?B?N01SMVRTYnBCQXlsNmEvMFUxY1BzNW1nUGg3WE0vVmpOamgweitHNEYrZnNj?=
 =?utf-8?B?elhUY1Nvamp5Q0RuSmJCRndkU3dKRFpuSWJPMU9kWFR5MUpWZEdLaTdCZEJO?=
 =?utf-8?B?NHV3bHZqc29yNGtaMkh6dEMyQlBsY1pwNXBQdi9KcDdDMm1LaUR3WmoweTNP?=
 =?utf-8?B?a3llMWdrMVZTKzVOWDJwdDluWTZaOTFqQ2NCc1plVWg3cG5PaFErRFFFakNj?=
 =?utf-8?B?d1Y2YVROZ0JMQjlGZWNmaEQ5cHliT2M3OEFpdXFTNHRZT25CRzRPbWcwTVpy?=
 =?utf-8?B?NzVOVFZLVWw3a0QvVEpwSkF2enc2ZXRpL3JENnJycEtmWFp6d3NqVlR5WjBX?=
 =?utf-8?B?VkZ0c04yZDJUVmEzQVpPOUIrY1VMakRoWUk4NXZCcWJTTGtvd0kzK1NGNVJx?=
 =?utf-8?B?ZzJOVEZCKzVmT0R2TW5qdHlmZzJuSEpMWDVwWmdCUFk2Ry85MU1qcFhFZ1Uz?=
 =?utf-8?B?VGErbC9QcVp1RCs2amZBZ2kwUUZKMFA0Tmg4SktXSDBEbVZUTXhLUEh4Si8x?=
 =?utf-8?B?dkFFUUFRVlc3Y2RoTlVYTDdnR1JaZVVOOFBFc0FreW15Rm9oQ1BDMmdneDFO?=
 =?utf-8?B?eDRHaGlpbFp0cGc3R3lqNnN5Qzl4SEFxb2tVVG9DUXhWSm13Zi9MN0dHcTZU?=
 =?utf-8?B?V0JlTmlQc3luWm5KNnJ1akxpMm1La3Exd2VEN3VLUGY1azZ3WXVBSFlHL041?=
 =?utf-8?B?NUlyQytRdTQ1djZzWm1SNkVUc25hMFdrODlsc2s4Sk04QTVYNWVBbTNtSlJP?=
 =?utf-8?B?eWdYUUlwQW55Rk1jUHRhWGgvQXZ6bUxvcUFqYVdqZG1KRkFRUXB5RkoyVXNj?=
 =?utf-8?B?YXp0N2hxUHNlNkpsVTQrZzN3M1BTeEkvRkxBSEJySEd4UjBLT0lBd3E0MTBP?=
 =?utf-8?B?TUZ2eVFXOVZEY3lYYmp0UVdSMlZ5QkI5RW5VckcyNWpCM2pab1ZsOXlTaTB6?=
 =?utf-8?B?TW13WnVkVEpZN09TcXRBblF6YmRBb2I3RTZhZGF3UE9SREVUdFJnVERJSmxw?=
 =?utf-8?B?SzJ3ZVlIZjlaUDNZSTBJcVVXQU9Ob0VrWVJYc01PWUdldTFKdEVjMlBGSGN5?=
 =?utf-8?B?VVBYaUlNU0k2QjZNL3RQSEFIemU5YU5KU09mWXIvVTJlcW44SWNkcUVCKzhy?=
 =?utf-8?B?RG45eWhDY2wwMU5vNHRSd09yd3drMW1xMmVTNmh6bWJwTnQzeE44dmJvWVhu?=
 =?utf-8?B?VjUvckJ4RXYwQ055a3orSkQweTgvZnZFOUdLdk81ejFxRlRWbHkwVWlYV2du?=
 =?utf-8?B?VEFlTEt1ckM3Y3lzWDZuL0R4MFg5RWg1WnlmQmFldTFVT0drZk5vejlNK3lh?=
 =?utf-8?B?TlJsVEhQTGlnRUlTK2ovM1RNZEladnpmZFVjdityMUhvSEV5bGlheHdlMnNl?=
 =?utf-8?B?SDYxY2hRRXQ1RU4vVlZjdzJON0lMWTJsYXkyNUJaL1JmdllURUJiam5sVGZN?=
 =?utf-8?Q?OIddFlnNlFrC/WFKlGg3MfrCCAXUJy3bzdCwajL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b72ec32-a093-482e-53b7-08d966dce91f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 08:55:24.1337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRvjrJ42LGGWXmV9B2B5fSpDczeYNtyWMB5lTjY4hT4BbSvokPjRL2bnPw/gUXGm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2451
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

Nope that are two completely different things.

The DRM_SCHED_PRIORITY_* exposes a functionality of the software 
scheduler. E.g. we try to serve kernel queues first and if those are 
empty we use high priority etc....

But that functionality is completely independent from the hardware 
priority handling. In other words you can different hardware queues with 
priorities as well and each of them is served by a software scheduler.

In other words imagine the following setup: Two hardware queues, one 
normal and one low latency. Each hardware queue is then feed by a 
software scheduler with the priorities low,normal,high,kernel.

This configuration then gives you 8 different priorities to use.

Regards,
Christian.

Am 24.08.21 um 10:32 schrieb Sharma, Shashank:
> Hi Christian,
> I am a bit curious here.
>
> I thought it would be a good idea to add a new SW priority level, so 
> that any other driver can also utilize this SW infrastructure.
>
> So it could be like, if you have a HW which matches with SW priority 
> levels, directly map your HW queue to the SW priority level, like:
>
> DRM_SCHED_PRIORITY_VERY_HIGH: mapped to a queue in HW reserved for 
> real time or very high priority tasks, which can't be missed
>
> DRM_SCHED_PRIORITY_HIGH : mapped to a queue of High priority tasks, 
> for better experience, like encode/decode operations.
>
> DRM_SCHED_PRIORITY_NORMAL: default, mapped to a queue of tasks without 
> a priority context specified
>
> DRM_SCHED_PRIORITY_MIN: queue for specifically mentioned low priority 
> tasks
>
> Depending on the HW we are running on, we can map these SW queues to 
> corresponding HW queues, isn't it ?
>
> Regards
> Shashank
>
> On 8/24/2021 11:40 AM, Christian König wrote:
>> I haven't followed the previous discussion, but that looks like this 
>> change is based on a misunderstanding.
>>
>> Those here are the software priorities used in the scheduler, but 
>> what you are working on are the hardware priorities.
>>
>> That are two completely different things which we shouldn't mix up.
>>
>> Regards,
>> Christian.
>>
>> Am 24.08.21 um 07:55 schrieb Satyajit Sahu:
>>> Adding a new priority level DRM_SCHED_PRIORITY_VERY_HIGH
>>>
>>> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
>>> ---
>>>   include/drm/gpu_scheduler.h | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
>>> index d18af49fd009..d0e5e234da5f 100644
>>> --- a/include/drm/gpu_scheduler.h
>>> +++ b/include/drm/gpu_scheduler.h
>>> @@ -40,6 +40,7 @@ enum drm_sched_priority {
>>>       DRM_SCHED_PRIORITY_MIN,
>>>       DRM_SCHED_PRIORITY_NORMAL,
>>>       DRM_SCHED_PRIORITY_HIGH,
>>> +    DRM_SCHED_PRIORITY_VERY_HIGH,
>>>       DRM_SCHED_PRIORITY_KERNEL,
>>>       DRM_SCHED_PRIORITY_COUNT,
>>

