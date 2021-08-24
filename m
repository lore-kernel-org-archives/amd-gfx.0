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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB4DC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 09:45:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7675761360
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 09:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7675761360
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13B4A892E6;
	Tue, 24 Aug 2021 09:45:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2133892E6
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 09:45:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pcj2/RJhgXf1xaZ1lzmgspmXGGBck0UGCs8M4fVJYrY3T+LNvtd4ljYPAd8JUJXumfg0S+Wfi532iKODnDiF6MRbeniIxEE2CpDh0YFpCK3yAmDgZHIPdawKKPZsAaDyCo7JY9epE7xyZVEI6PF3U6P4XDhe7G5Nr1dMhVMF8TAYSFY3KpLaykOfM7jx/9K5xSeb30cTgdm9I9Yin5t91rUQahgPYFG6CwJ9aCAtS62mFCZMHq2DazmubQhHwlWOtpGM+bnJvyTlIrh1Ufm/7sthOtJh3B9LlHtGZY5v155Y65a5spCQI5y6DVis4BSKgL+dUqsma9wLVTSFVsJ39g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAWN1SBoNnGuiDjYlqgzls+lvdER8gKwuzNwPzPXKPU=;
 b=DcRp3djUgK2ISaXFqMahMu32z8U5I8n/Z4jARBo/c4fk4IVnygZVSHV30joj3bHeEWUxMrnxcp8ulZo4rfxZAiWYUtY63Y4T0Lf0BGRBa8b7t8ac4+ew3kMPK96hYg8UBnq83TxQdb15U1I7waWdV8qALQEA38ef+6zgByYnbsn050oxF1eVE5b37uoSGe8q/+Xy9T5wAyP9hIv7iOJKJ+chg104rq1iWlWFXXZysy9ltBgTQyFc65B1Gie9eYqPPBsAa8daZSPSmUQ8w8H4TvMV+kbRg9JMnozTaABObC/ok5KeKO7+8ki10UBCSQP0igL3DSiJ4MAVaFkOEqG6vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAWN1SBoNnGuiDjYlqgzls+lvdER8gKwuzNwPzPXKPU=;
 b=CAa4d1K5+uu/EPHWGBMKsm4KhL+h7dRifACdjXDcnsYSlPvrRy1GxGyVcelC3+GxZ1+kEClmSIt2YCLxwBhvNfjY9YyixwRnZkdvY1q8HOwRWUSdQrVcLOialdg2RIIKMBSkk/u6dcn1K7PjFqnVVP+bTzd2w+/7p62ccjV8Dso=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 09:45:39 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::946e:7191:34a2:9850]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::946e:7191:34a2:9850%9]) with mapi id 15.20.4436.025; Tue, 24 Aug 2021
 09:45:39 +0000
Subject: Re: [PATCH 1/5] drm/sched:add new priority level
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Satyajit Sahu <satyajit.sahu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com, Alexander.Deucher@amd.com, nirmoy.das@amd.com
References: <20210824055510.1189185-1-satyajit.sahu@amd.com>
 <66607af7-5310-629f-1851-df4b74cebf7d@amd.com>
 <53fb0d0b-e9c3-3a79-9b17-87e4297737bb@amd.com>
 <2952fe71-5948-de45-728f-5a606a8e9abe@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
Message-ID: <55f8f164-ece6-1e8f-1c8d-54cc47cf8bc0@amd.com>
Date: Tue, 24 Aug 2021 15:15:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <2952fe71-5948-de45-728f-5a606a8e9abe@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PR0101CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::30) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.89.110] (165.204.159.242) by
 PN1PR0101CA0020.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Tue, 24 Aug 2021 09:45:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d11ca8ca-44c9-4cf9-27a0-08d966e3ee49
X-MS-TrafficTypeDiagnostic: DM4PR12MB5263:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5263B09455199BC860912D89F2C59@DM4PR12MB5263.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 96sSdQAoFKox8uSTAAME+gjahdLY3yIVpgIkPjk3RrBoRHkk8lylv+ibt9Gf51S6pYXjgFpTCqzIrgqeIgEQk7nd/sfdAbWBFls8WBiYX+U1ShCFBA/RpniG+djfquWIfwkGIg6yzV1wFD+beeId6mTqbOe8cRvg3p87TRM2Nn98VhOe0Diskcz8uVo4KGnCDnF4x9yb0sguWK8ZV3QmrfI+DMhmJSUw5gIXGl3gt5v+0WedC6axh6jvTelUjmVJciDR+jGtHmt1R4dQ0h6a0E70EseUbd/cFmuDmISk1BsGa9t8us59FKanfYlaxZaP2Ix0lrZu3QYEx+vctkCRsDpDdpoxIioFNG5et6mAwCL22UMfesGR9qPnH/tdn79NST6s+80NPMhNOP2vpuW2aV0Kj/f7uRkiZ6ukwYc2i7II9BMEgb/x+smrTuG+ygzPXM1x3HigsfskdwI/kQLnx6ATXU1MTMbJK8oWhdlQPPL39y4bU1CNEO31XbQFGvjAI2eF1PWkzR2cAqQnTLoBZfF5MqQIk/7B0UGDtF7PouFpn54F6fPTLL+MRN5TInZseYsAm0NDBnsyASQgz1oaCYkiOEsbeDcQ0XAkCXFW00IVk86l6+H6kb+Ngd0LTgkH8N1sgXsOaCgzZoelYEY/nX7vgbTFfzZca8CXLDTT2ZP9nL5SHLGZW4Sp/rKrkWKtaiw9uxTx6OplKNCPqzD/lv9n+KoBH1nJaQBejaStCFbejA8kuQGdVbAdjr68Gl9A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(36756003)(8936002)(16576012)(31686004)(316002)(5660300002)(2616005)(53546011)(66556008)(186003)(956004)(66476007)(6486002)(38100700002)(31696002)(8676002)(66946007)(110136005)(478600001)(6666004)(86362001)(4326008)(83380400001)(2906002)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzRMUmE0aSsvN2R1RWh4aEE2ZlZqNG9HaHRhQWk1WTZhZE14YmZSTzZBaUtn?=
 =?utf-8?B?NCt3Z3BKbnNWNHVkK3FERUhuUG5LR3dUeDZyOWNZdGp4V2RxK24xbG5VM0JH?=
 =?utf-8?B?QkcwaVpmY2hLOWJ3VW95cVlwT05ZU2h4ck9pZ1ZxYUlneExTTHlvaDR3WlpC?=
 =?utf-8?B?VFdrbjF1MW9oS3VKK2xDYjlhdW1tRVFONGhnNEFCTFN2VTUzMGtiQkxSOXFv?=
 =?utf-8?B?TW84TDNmSDZJOWpTYlJrVDY2bEVDMlZnTC9ST29sOXJzYks4UUZjNDdxUFVW?=
 =?utf-8?B?aHNrWkg0ZjUza2V0eDFWS3dxdCtZclZrQWh6M0RoOVJxcHN6ZlAydkQza29O?=
 =?utf-8?B?MUtvbmdtSkI0UjVjRTZ1Q1huMXo0NkI0bmppZ0NMRXZUb1VTUm1rVFVuU2Jh?=
 =?utf-8?B?WXRTcm0za2ovRDliS0c1S2d6alM3YzZzdytnYXFhTWQ3cHhIc3ZrQytBMStI?=
 =?utf-8?B?bXpMWFliaCs5RFMwSkg4VEhIMVpnZjVhSlFQSmtlYzdjTm1kWVBpa01Kb2F2?=
 =?utf-8?B?UHdWRStoU3Uyb0VrQWdwT2ZYSkhXQkpTQ3FDRnZUeGxHaFFtdUMrNW5VNGgr?=
 =?utf-8?B?WGtHazhNMHFNcXN6VzZNS2FwM3pyTWNrMHBsVm1sMWdNdTM3cDFsOGRFS2da?=
 =?utf-8?B?YmFrSGNsUy9CcHBuVllFQWZ6MTZxNENLMkljRnhPOXpKM0tBeU83Qm1zRG9P?=
 =?utf-8?B?R1JNV1BJM0VYVVo4cWh4QU4zTUhJLzBrdFB0a0UzUkptMmdGck1ZK2MxWlkz?=
 =?utf-8?B?eUpTQXdENEVqemZicmljRjRxVWV4VURTYU5uQXlRV09EVDlGT1FlUVlPNzlu?=
 =?utf-8?B?NGJyWTFFbmllQ1ZSOHQ3VVROb29aK3A1Ri9BRWlQRVZFaXlLUDFKQWZRRUwr?=
 =?utf-8?B?b2hRWk4rYlNGcm1XVmVOSU1FVWdUMnBUaURiWldES21STDlJTllyM3BQTThO?=
 =?utf-8?B?cmdqcFdtV3FZdU5LeFpQcTBUK1RTUWx6a0xmV1lPM0JiNTNlT3o5OHBjcXJN?=
 =?utf-8?B?V2J1Y3E5Uk9TdDNhZVNSY3Q3Y2pNUnQzWnNBbjNFaWhDNk1rbG1PUDdKZ3pr?=
 =?utf-8?B?WFVxNkwxUVFuZmhRa2x0VGxoVFlUaUN2YWVYOGp5cXpkUGZJNFRMU01FVGlr?=
 =?utf-8?B?OFBKcWNsTW1mQzhBbFQwTVVWb3NZRDU3VFBxVlZFVnNkK3BRTlJHZ1U0TklX?=
 =?utf-8?B?aDVtTi93bjB4OU5ZUG1LYWNTdms1RzRzVXMrOFlURzkwblFMSDlONCs1Y2FF?=
 =?utf-8?B?S0NGYmE3MW0wbjFCUE1odm9Zbm0xZ1FXVXFVdnNPY29qV2RtTWhqTHBZM0lZ?=
 =?utf-8?B?WE1KUU9VclJWQlNDOUg5SHNFMXdEK3JXVDN5TzhRam15TzVJNEVmd3Rqblp2?=
 =?utf-8?B?cmZWNzRWRjJXZGloZGhzQzFFRm00NVE5SlkvaXdlYkhvUmF6THBMd3ZRdW5x?=
 =?utf-8?B?cXBuRU9QTjlaS3ZKNnVvMThESGlIMDBYaXhsb1ZyTHpaVzJxb21qSDM1eTcx?=
 =?utf-8?B?MEl3V2tQQVM3NGdkMWxlL2VYMWFNczBIWm9NOUw1KzZaQlBCdjlZRkpTYVk4?=
 =?utf-8?B?SHQ5Sjd0OFB2WFdGbGtsU0hBOW9nWEJqMjNiQXcvNmhDQWdzMFgvRjZmMXAy?=
 =?utf-8?B?emd0cGkwNzNWckhjZTByU292NDlYNDdWQVNWVktibVpvVC8rbXBLSUtaTHhP?=
 =?utf-8?B?b0MrVlRmenl4WUtYMUNhZ09kdHc2WGVJQmw3SU5QQTVjQ0pDa3VpRW9WMHVY?=
 =?utf-8?Q?8d7htlp1K2eXWIDZd2TiVZlp36j9IA3qbNhLQp1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11ca8ca-44c9-4cf9-27a0-08d966e3ee49
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 09:45:39.2151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1GNuqJZRu2d+DIop4+SwyhfYKH1ET13qna6XYtLA9xAExfPiC24xhDFUnFPnyHMvF1dxuiivB4MiA/8csCjBRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5263
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



On 8/24/2021 2:25 PM, Christian König wrote:
> Nope that are two completely different things.
> 
> The DRM_SCHED_PRIORITY_* exposes a functionality of the software 
> scheduler. E.g. we try to serve kernel queues first and if those are 
> empty we use high priority etc....
> 
> But that functionality is completely independent from the hardware 
> priority handling. In other words you can different hardware queues with 
> priorities as well and each of them is served by a software scheduler.
> 
> In other words imagine the following setup: Two hardware queues, one 
> normal and one low latency. Each hardware queue is then feed by a 
> software scheduler with the priorities low,normal,high,kernel.
> 
> This configuration then gives you 8 different priorities to use.
> 

Thanks for the details, I was under quite a different impression, this 
explanation helps.

I guess this also means that the HW queues are completely left to be 
managed by the core driver (Like AMDGPU or I915 etc) as of now, and the 
DRM framework only provides SW schedulers ?

Does this suggest a scope of a common framework or abstraction layer for 
HW queues in DRM ? Most of the architectures/HW will atleast have a 
NORMAL and a higher priority work queue, and their drivers might be 
handling them in very similar ways.

- Shashank

> Regards,
> Christian.
> 
> Am 24.08.21 um 10:32 schrieb Sharma, Shashank:
>> Hi Christian,
>> I am a bit curious here.
>>
>> I thought it would be a good idea to add a new SW priority level, so 
>> that any other driver can also utilize this SW infrastructure.
>>
>> So it could be like, if you have a HW which matches with SW priority 
>> levels, directly map your HW queue to the SW priority level, like:
>>
>> DRM_SCHED_PRIORITY_VERY_HIGH: mapped to a queue in HW reserved for 
>> real time or very high priority tasks, which can't be missed
>>
>> DRM_SCHED_PRIORITY_HIGH : mapped to a queue of High priority tasks, 
>> for better experience, like encode/decode operations.
>>
>> DRM_SCHED_PRIORITY_NORMAL: default, mapped to a queue of tasks without 
>> a priority context specified
>>
>> DRM_SCHED_PRIORITY_MIN: queue for specifically mentioned low priority 
>> tasks
>>
>> Depending on the HW we are running on, we can map these SW queues to 
>> corresponding HW queues, isn't it ?
>>
>> Regards
>> Shashank
>>
>> On 8/24/2021 11:40 AM, Christian König wrote:
>>> I haven't followed the previous discussion, but that looks like this 
>>> change is based on a misunderstanding.
>>>
>>> Those here are the software priorities used in the scheduler, but 
>>> what you are working on are the hardware priorities.
>>>
>>> That are two completely different things which we shouldn't mix up.
>>>
>>> Regards,
>>> Christian.
>>>
>>> Am 24.08.21 um 07:55 schrieb Satyajit Sahu:
>>>> Adding a new priority level DRM_SCHED_PRIORITY_VERY_HIGH
>>>>
>>>> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
>>>> ---
>>>>   include/drm/gpu_scheduler.h | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
>>>> index d18af49fd009..d0e5e234da5f 100644
>>>> --- a/include/drm/gpu_scheduler.h
>>>> +++ b/include/drm/gpu_scheduler.h
>>>> @@ -40,6 +40,7 @@ enum drm_sched_priority {
>>>>       DRM_SCHED_PRIORITY_MIN,
>>>>       DRM_SCHED_PRIORITY_NORMAL,
>>>>       DRM_SCHED_PRIORITY_HIGH,
>>>> +    DRM_SCHED_PRIORITY_VERY_HIGH,
>>>>       DRM_SCHED_PRIORITY_KERNEL,
>>>>       DRM_SCHED_PRIORITY_COUNT,
>>>
> 
