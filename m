Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD79EB64DC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jul 2023 16:09:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B5CA10E379;
	Tue, 18 Jul 2023 16:09:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::625])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D69FE10E378
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jul 2023 16:09:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKHl3qEL36XHc67LPy/cVDecTHydUsmq4NWjEpajBazM9uP2aa480RZ9ZD2y6H3YOG+6lK1C3jEris9StwppZkCPtO1A2mhDz58e08SVX3LD8LwIY/7HHQsyinKX5R8m7c72gvog1MGEBRd9fkpUYDtHF2x8HABBWBcNlNcpT4b1D/YyYiburuAZ1A5EYsSlRIbJaSC1zk6BhOKDr/M10/jf0LQtzNwiHT0oLAZubWw2M2LYNdpJCFddk64kMuzOYxxDzNoAXfMYQGByIviz1yvJZIkmxEyyTkZbGjXoxvgP0ud3AgM4NTgzCHX410F1pM5fSqXtMQ5+DkLe3xqjhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQENix5gjL/R8bKAYA/dXWdXnm4jkQdDHrw5fQmuRr8=;
 b=TqFbwnp3JrMa5vQob3bNFXMxiSBB7gtK5AQJbL2vX+S0QmtIiGp+NLYu2iJS/+ZFy/0bPW8h32E5sdVOaRRyd6Dx+BzQ4pJoympqzSepB6lG8EHiZidHKcywWiwvZHtpt525sPzKmsyKINB+OV5zPkqS/Q3/WmHrutcmayXxDWcXfXirbn+HZwlSYs4h2VWea+ZXLPNXNmLiN5oOmV0bg3qW+GYhFc2u7LGRVQeLT0i26NPufLMRnaJhwSz6ulCOyiVzYRISFywY/akEKQOIWqy9lPLL88agtgwBtI6dOIpqkhPde/TEmER6IDNicF4cN4Y4UxZ0BA/QFGzMslegVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQENix5gjL/R8bKAYA/dXWdXnm4jkQdDHrw5fQmuRr8=;
 b=ImD6RHqh5a1w3dcSgDtR4x4AEaS6fS5rOfv+YD9JeisI7LlXhUkc1y6AiOUaYVIS91ZmyLthvwqpH1ziDO7hZmlyS/OF9wKAckbIeHBEVLM8Rj3y47Mk1CPemMAP3ecDe/bcXNGm83jSTCdJzllj9a0AwnzzqdUB+WV6/aS8YNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by BN9PR12MB5339.namprd12.prod.outlook.com (2603:10b6:408:104::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 16:09:34 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::bfee:712c:bc2f:8844]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::bfee:712c:bc2f:8844%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 16:09:34 +0000
Message-ID: <7c6c2699-0732-9e6b-4c5c-f36bcfa83814@amd.com>
Date: Tue, 18 Jul 2023 12:09:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdgpu: Update ring scheduler info as needed
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230718122120.2938177-1-lijo.lazar@amd.com>
 <843196d3-fc53-77f3-26c5-8df479539f7e@amd.com>
 <c4ea8242-ff13-f395-2eb4-b15633253dcd@amd.com>
 <5de2cb5b-ccc2-68a6-aacf-f1882885817c@amd.com>
 <23ca1d49-ea6d-0980-1bdc-f24a48a880ab@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <23ca1d49-ea6d-0980-1bdc-f24a48a880ab@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0348.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::10) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|BN9PR12MB5339:EE_
X-MS-Office365-Filtering-Correlation-Id: de63fa05-d6e4-456f-69c0-08db87a9604d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xkOCWcpjlXGD9P4QJ5PlW9oBNuh+NgP1nEmNMKGbfpQu0rf7E2IXxyQwYmCgrbaP4UMcdQKRFXKliS7Ek9ySObrY1GWKZmSSP4bDUq1rROPOoqJSKQnltPNwAlAwc923GsjE2MW/93P+JItK29Rx3M085+qjVRaWUXUaHgoGGzlCiWmXzXx751HbA9Gs0Inu9QlGOg1kM7rsJn1XRFunCGN6q2ciI2iqSYAyk42j3hNL15+vDlMzZpAxYtIDSkezo92FgCXWwLhKKFpeAwCPatnmh3vQTeilBdVzEjv/VCK3KLvyMwcPAaneic4iEX1F9tN+KeL4UczcSTqrngA97tsQO+Girz4bDJY5WY69jaM3T+iZaUuF6yfLUPhx/3Aj9oQWmzADBBQSkCd5yy21qzbC64rtJH6tDtBji51kIqzaIjk8vPcru/9qFKMPNtjj5atRzw0LhpB3qToPc3nFXzHixrILIT7mbRoV3VoW5PFm0ILOIMtttaY/0UEELED1YUKs9nf0Mgy0GzbE5cqDLp7VrAf+Dh10lsuWtfWzj92pQHE0hsoMQogulXDwg/fy7HtGz7EfO/d0D2+RSM+XkLQyt+6VatyXSvfEU20S4oKxER61xpjdPt45Z7neFoqyYgsGqzZdwWTJJ4PvCienzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199021)(2906002)(41300700001)(316002)(5660300002)(15650500001)(8936002)(8676002)(31696002)(36756003)(6512007)(6506007)(53546011)(26005)(478600001)(6666004)(6486002)(36916002)(83380400001)(186003)(2616005)(31686004)(38100700002)(4326008)(66476007)(66556008)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWIvYmNBdzArbVV6Z1Z1c2UyYjBXdWU4TEQvT1ZtdzFIaktPSkR1QWJnMU55?=
 =?utf-8?B?KzhtWDltUU04OGdCT2tMaXRXaEVtVjRqSzdxMGl6TGJrTnhBQjEvR2JVdkEx?=
 =?utf-8?B?cjg1YWlkS3ZFc29nWjhmWVVtNW1uZ1lTenJYRm5yM1ZnN1Azbks5SEF6QllR?=
 =?utf-8?B?TXVpUFNMUzJETWlhM0JnSlpZRkdXUU5ZRzJ3YkUvWkVOSzlVRDJwaW5GaTFr?=
 =?utf-8?B?RXlvQzRIeXc5VkhTMHNPRmtZdzdxSkV6cm5EaEN0RUxTVkQyaW1LT1hHNVU1?=
 =?utf-8?B?UytEVzR3aHdpWWthZzQrM2lNZUc5Z0t5STNzYUVEekNKakd4SU9mQmxPSlJD?=
 =?utf-8?B?ZUhTMG5SamliTUR6c1gzL2RzSWdYYy9PY1dYWFpFZ1J4cHNCc0dtYld5NkIy?=
 =?utf-8?B?TGdTQnZNQlBsczVXalBQRnJob00wK0NnUmp6VnpIbHJ0cmw4VFpvNmtLMjdp?=
 =?utf-8?B?b3VFVE15UDYwNkVLZ1ZGNGRjZ2VQY3R0blg0NDFGcWtrVXNNeExuWlVZcDVL?=
 =?utf-8?B?NXJoMHRONE9QNENXei83eGcvbG5TWnlGS1FMOERGSlVwQy80WVVuSUt0cUp1?=
 =?utf-8?B?U0E5b3gxV1JyQTNycGFrWnh0NzdRQWl3Y0J1dm15N3djdUFlM2wwZlZUZGZq?=
 =?utf-8?B?N3dGS0kwRlJHdjdZdU1VY1ZWbjFXTHhLOUtKeVAvZUxhQXBtVktUOTNNSkg0?=
 =?utf-8?B?R2Rqd1Y2a25JSDYzZXdCWlNmOHV3Ykprc1BCdlplL2FVbUZ1bTgwckk5NVpK?=
 =?utf-8?B?bi94S2kxcjdiRTQzN2RDRFppSWlwcEdXVkR3VDBzWFdFeDlWZVJWVGZtaTE3?=
 =?utf-8?B?RlY2N3FtcDV1T3ZGNWZqbkRobVB6NmpLRDRLVW40QUU2ZkVsYVU1ODhvaXNz?=
 =?utf-8?B?djRYM2hYUzNVcGNDMTdncGhWelovdXIveU9kdURWMm03em85SmNqd1UwYndI?=
 =?utf-8?B?UndHMklWWE9zV3ArYzFQZFl4TllPYVlFdmNzQ3dLNzhnWlpWd1NwWUtTSVdh?=
 =?utf-8?B?bjBrc3ZQZXMxL0QzTGRoZ2JSTmZLS2pFU1ZpV0lnUG43TDUwd015czA4Y0to?=
 =?utf-8?B?ZGpVbVUvcjFlUE9DeGg1bktVSWsxa09nbDJFZ2p3Z0RVdW1oSldHNXZCS1Fm?=
 =?utf-8?B?TnFhY3hZNDhtQ3hxS2ppNnlXVUhhYkwwb0V1VkZQSHJBMmVOWmNkZDRtaXRS?=
 =?utf-8?B?NzJzY3o5MzVQRkI3T3UrMTZsYnVLK3VyTk5CckZ3OUJHR3Q3L2p1T3MweDdr?=
 =?utf-8?B?Rk5MRXRMQWRmeHZ0VTJyczRwMUZ4cTZWenFQK0VzbFpGZ3RJOHFMeGc1UnFw?=
 =?utf-8?B?ZGpuU01SeXRqVEtqY2dBcXlmZzFlMTBKZGEzZmEwTDc2MmtHQjBkRzg4bHZN?=
 =?utf-8?B?V2Z1TUFtbzNSckhITXo3MWV2N3pOM0hpZEhjMVl5Skg2LzFzWHArQXNqeVNp?=
 =?utf-8?B?S1QzYmJ5SVhGaXJPZ2tabVNISGRDTlVObkVZUUhTa0RtSlZaTkQ5dE5JSTRw?=
 =?utf-8?B?TGkxWklMRmdsQ1BmTXovVWxQZ0plU3VYZFJHdStRVlVoS080Vmdtc01rTlA2?=
 =?utf-8?B?WUFUVURjRTVVbUtRNjA5SUFWNVdtMHNYNFY4d3FoODRtN0t4MTZVcWFneHlt?=
 =?utf-8?B?Vm1MMjFIWm9FTGNyN01YYjY4Z3VsS2h5clp5SVcybWRZRGU4aVlWOWEwakNn?=
 =?utf-8?B?TUI2R0x6M285alphNWJxaU9vV1JqSnhKUGN5TFFGVFFHUTcwR1ZmUlViTE5M?=
 =?utf-8?B?cmJwZkhxZE9jM0VPbml3QStMQWY2VXF4dFUydHZiQWRtNjRjaTBqWHZjdmRQ?=
 =?utf-8?B?VGJxNFdPelZScEZWNzdLenRob3pUZ3Z5RzdTWEdON01CdVU5anNHcU1qdGNJ?=
 =?utf-8?B?SW1NSmpLQm1tTUN4cXluYXQwSXNEMFE5U1RKNTlScVNPWHNjUk9pVmxIc24v?=
 =?utf-8?B?blJ1elZibU9HSDhiZUdUNTFNUGIwbjV1RVR5eXQ5cWhkMVZNNk5QZVJrMlZ1?=
 =?utf-8?B?U2p1UDB2aGpXckowZEZSL0dFa0tqVjkrSjlWc2tZSk4xa3grN0ZGVmppdkFj?=
 =?utf-8?B?bXhkWXFrMjA0UnRpUC82ZmpCZm9zT1dFMEEyY3VoYW1vWjVPR280bXc2QlJo?=
 =?utf-8?Q?RUPR6CFI2Gl7/qEpWcELzJ7QA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de63fa05-d6e4-456f-69c0-08db87a9604d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 16:09:34.0437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fw9Sl4dNELupPI92scoTvG4p22SEg4irsgi7fSnSfv/vLUvlVgDF0sBaCyww8Izm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5339
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
Cc: Alexander.Deucher@amd.com, James.Zhu@amd.com, Asad.Kamal@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-07-18 11:54, Lazar, Lijo wrote:
>
>
> On 7/18/2023 8:39 PM, James Zhu wrote:
>>
>> On 2023-07-18 10:19, Lazar, Lijo wrote:
>>>
>>>
>>> On 7/18/2023 7:30 PM, James Zhu wrote:
>>>>
>>>> On 2023-07-18 08:21, Lijo Lazar wrote:
>>>>> Not all rings have scheduler associated. Only update scheduler 
>>>>> data for
>>>>> rings with scheduler. It could result in out of bound access as total
>>>>> rings are more than those associated with particular IPs.
>>>>>
>>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>>>>> index 72b629a78c62..d0fc62784e82 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>>>>> @@ -134,7 +134,7 @@ static int aqua_vanjaram_xcp_sched_list_update(
>>>>>       for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>>>>>           ring = adev->rings[i];
>>>>> -        if (!ring || !ring->sched.ready)
>>>>> +        if (!ring || !ring->sched.ready || ring->no_scheduler)
>>>> [JZ] any case for ring->no_scheduler = true, but ring->sched.ready 
>>>> = true?
>>>
>>> amdgpu_gfx_kiq_init_ring sets no_scheduler flag true for kiq rings. 
>>> amdgpu_device_init_schedulers inits schedulers only for rings which 
>>> doesn't have no_scheduler. However in gfx_v9_4_3_xcc_kiq_resume, the 
>>> ring is marked with ring->sched.ready = true;
>>>
>>> I'm not sure why it's done this way, but this is the case even for 
>>> gfxv9.
>> [JZ] I think the sched.ready confuses people. here just means ring is 
>> ready be used.
>
> Thanks for the clarification. One question is then do we need to check 
> ring ready status for assigning xcp ids or just check if the ring is 
> associated with a scheduler?
>
> Keep only this - if (!ring || ring->no_scheduler) to assign xcp ids 
> and leave the ring ready status to the logic which really accepts jobs 
> on the ring?
[JZ] I think keeping ring->sched.ready will reduce schedule list which 
will save a little scheduling time.
>
> Thanks,
> Lijo
>
>>> This patch is Reviewed-by: James Zhu <James.Zhu@amd.com>
>>
>>> Thanks,
>>> Lijo
>>>
>>>>>               continue;
>>>>>           aqua_vanjaram_xcp_gpu_sched_update(adev, ring, 
>>>>> ring->xcp_id);
