Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C347EB64DC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jul 2023 15:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE2D910E37A;
	Tue, 18 Jul 2023 15:55:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B25DE10E379
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jul 2023 15:54:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFhbPslCviWXdyuu2lwhCRir47YoiwVKr827N/T/hnT2lB40t631EVYAFbz1UJ95iUyIGCVh16o7Phz32MF7/MIXvOOeHq3HX0f3no9ve62fKvob3cLh1w9hHbC1Bq57+ipSYj6QgI/MLGWvMvynUBVpO75UrqaQTzqKTx6SKxBvJLQMxCrd0VtcOLL01J6Cpc2Th7+HrQCFw31guwyFOFG3tWjJhVU6oUbSeAnwJIKvyz1nJb02NwEKIZQFIRTixJjK2S0tW6gBYcBEdXZkmPivYEbYr+VlZ+i8dIWUi7A50MXjnOlTV76FF0Yeu8KakPg+9Mbh7w+IL4KKbfNi/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9THdoj8OdkQ41J+VZHNXdPNZ2pG9CZ9NwjjJseYZbOc=;
 b=mFQuhSFz8C2wW97d0Beuw2k/jfws6IrfOKPRacKxhZxcUNkghG8OfuN1yl9Tx34CUiJuWQ5VGTE7XOGeU6zAeIvWWzcAq6UVWCWd9RvfYB+YROOS1u23ff+hZxlOeQXzJmEZqJOUZb0QVHJwKZKS4PPoGt/AV+CBAB5flLUvMPZyC26igLHH69YyqptmHEplDhiYADpCa5wZ++Rn5pM7FexqsrJgz64jHF0Ve8AKTknuuLygyaFE1OeYFyr9NvyCk4O7k9ekFQ9f8mlABArE6nfdYTOD2BWfs7w6wElbZF5j2BSUCPR8YAzOdCJZhpFMVv8YHUyX9sPnR8ZxVK3tvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9THdoj8OdkQ41J+VZHNXdPNZ2pG9CZ9NwjjJseYZbOc=;
 b=VufGlddlMWSFSm3Suvrmo8dT0lyylXYZufV3wzPb7beeVTrtvKsScSQ3/GfHZz67tS53CC0K6ESCaCYw+3RkYJ1vTEiN4qFpJ2+QV3xGP4dB2th9FaJgKmvOI0Maslz8goWGU+dOHMS1ibsIuLEtLEO2MTX0uZMRrPnRWPb5u0U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CY8PR12MB7339.namprd12.prod.outlook.com (2603:10b6:930:51::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 15:54:56 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::e30e:689d:405b:b3c2]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::e30e:689d:405b:b3c2%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 15:54:54 +0000
Message-ID: <23ca1d49-ea6d-0980-1bdc-f24a48a880ab@amd.com>
Date: Tue, 18 Jul 2023 21:24:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: Update ring scheduler info as needed
Content-Language: en-US
To: James Zhu <jamesz@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230718122120.2938177-1-lijo.lazar@amd.com>
 <843196d3-fc53-77f3-26c5-8df479539f7e@amd.com>
 <c4ea8242-ff13-f395-2eb4-b15633253dcd@amd.com>
 <5de2cb5b-ccc2-68a6-aacf-f1882885817c@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <5de2cb5b-ccc2-68a6-aacf-f1882885817c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::15) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|CY8PR12MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: f8d88169-1a83-4bf1-307b-08db87a75414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wucV1rAh3VvV7WzYI8Yv3HY9Cn5EubB/OSwFM/A1lEJxLyFsyzyxf5aeEfgXfneVBuitPQctMsu6FDlatpaGkQJtsJVbkGj6R8ggjroSn63/8jLmyqM0PVkjkxx5zeO0QqQcBpUBhIHggESJVyCTlKS3ZfyG4zoAvhtL0AK3j9UpV2JGgCsPr7OcJGPi3BemPTi/7yfxhSrw4FMBwClhXjEyQWE5QCjlcX4KXpPALZJj5Wu+AOWuk5/h9rJrjnh5djkxf3vmOYWckNMoGcXzK1vTVWyE9NIzDLEiiYgWvIJwVuPyEmoaCGN1xwZJGcUMufygqgUA5A7uVs2YhK9dJ9y+KD/bTdV8nXFHVQRq5SH8Mh/Fd3LzZ2KiyKOPSc6JBpwnBuAVleTzdmFGHbvVAlWmcnL+UD2qMWJ2cTl8wpwvKOTDf0xv41RUanD5XdwHcSFV7ChVWnETxRM+4daMCF6hkN3dr14KECkveYTwXiHnWAZi1ZFAUdnmmMKKxS6ly40Izqpjp/6vXryldVAKcdqoKwWZeDM+joAIgH2f80Cw4Fz+ZWTs393bFQO3dVGs3edjmyTPjyptBzNAxpAH693+P+Kff4qgeOxm0sdy3GQfbV0uc86uE9x0WWEKYZ1HLOR2h1ovTwGTgARwclmigg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199021)(6666004)(6512007)(6486002)(478600001)(53546011)(26005)(6506007)(186003)(15650500001)(2906002)(66556008)(66476007)(4326008)(5660300002)(316002)(41300700001)(66946007)(8676002)(8936002)(2616005)(38100700002)(86362001)(31696002)(83380400001)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG0vSzIzY2pVQ1NKMnRCeTY5bXFuNHM3T0laQUU4K2NKaHlkdGkrdXFlNWM2?=
 =?utf-8?B?MG5UcGZUR0ZMQnlZNkV6WjlvS3hhZkN4cExrTWtudU5sTWhEY3NXd201Z0Jj?=
 =?utf-8?B?QndPaS9UVU5kMXNzeGk0WUprbVA5RnJjOGNlc0pqMWdFdlM3aFdNc0VEWng1?=
 =?utf-8?B?cFFmazc3czlkQlFlNkwrdnc3bnhrbUFCWThLZUFISTJxc2hsakdSdUJSVm1L?=
 =?utf-8?B?N2JTOG5MT2NiN1NQSXpzd0tsM2xpb1hML1oyN2tGZ0t6ZlM3ZUdKSzVoc0dO?=
 =?utf-8?B?U1hJNjN5SC9wNGtHK2VaSnJiK05Ic3Q2NXJNaU9BS2h1YVhBUTdJUGhoYWtE?=
 =?utf-8?B?a1RHNG45ZFRpaHl3WUFEN0I3VkRpMlpURVRqNVRCNnkzeTB2bW9FeGozOFZK?=
 =?utf-8?B?Q2dFeE1yM2g0VmorTjFtb2ZqdjNIak8yaGRwWGR4TFlrSFVwWm02Vk5QaFdk?=
 =?utf-8?B?ODRPdlVCVUw3enBNQ3RXMjlWYVVKZHYxMi9YY3N5YXFmZ2d2a0Zzc1VxVDd5?=
 =?utf-8?B?cmpqblRWbnc1YTlBT2Y4NGhjbXJMTUpDWDJNMjRWeG1UemUzV1NScHFEUG9n?=
 =?utf-8?B?Tjg4RzA4MGthUWNkdHpGRFNQK1FoS2tjOExZbjBsUERpN3FoRG9kT0tzUFBO?=
 =?utf-8?B?THIyU2tqMmxiSFNOM0ZmemZWRm9rTm44cDFZazRnN2RqcGMydUJlVzBwSUR3?=
 =?utf-8?B?WE9xcUthUVNDV0U5SkI5Ync5dDc3UnNRT0dGSGpidXpaL1JtMFRWcnVyRUlj?=
 =?utf-8?B?T2RRVGZPUHplZHNUSFFpZm9yQXcwSWJBVXBSemE0TnZCS1UxbGdRNTRYUitm?=
 =?utf-8?B?alBZbW0vMHZacTM5Nk5pL1JYMUdYaEtWU1VzZlNMV1hpeHROK0tkZDJiUDdU?=
 =?utf-8?B?WkhVaGhMWndLVnRML1RydzR5bEJCNHBiVlFUSmxvcnB5cytYMDJwSklHTFdW?=
 =?utf-8?B?TXoySlJYcExqWFM0UWY0cEpNM3VTcDYwYnRtRXV6cXZmMUFQcDFQVDQ3UXVG?=
 =?utf-8?B?VCtmMDJ5UFZGeTdjTTh1cWVxR01FNWxzSzZxZlEwOHkxTjF2Q29BbmZlaUto?=
 =?utf-8?B?VXpHRERFcVk0RS8rakcvY2lDaWhlTzJPSVQ4bDhaYkpyMWNNL0ZUM1JNbXdP?=
 =?utf-8?B?Z0lIZmlDWW4yVGs1WkpBVGdOUkxjdmppTjFIbEN2UWJ6b3pKb0pQSkFpSnBD?=
 =?utf-8?B?SGRPeDJ4WmM0SWVrMDRRY0NCcmxwb0xrWWllZnhwYXR5RGZqVmp1dWc0VHRl?=
 =?utf-8?B?NENGN29zNU5UeUgxMGVtNy9USTE0bnAyZEUzZUx2NkorakIxckFSbVlTeGI4?=
 =?utf-8?B?bXk4WHNOc0dvZld5bm1FVFNEczZmOEgvSXQrUFk2KzlyWm80RmlIY3VxTmtt?=
 =?utf-8?B?bjhGdTFUTTV0ZmJBYVpHeFhzY3hBY0tkMytwVkFoU3Q3aTUzNDJWVWxRTjdm?=
 =?utf-8?B?K0E4VXkzYmFod2d2T0VUc1RFdzZxeDJoQ1ZHVDNqWVVncHJ0WkdXRHRvcktW?=
 =?utf-8?B?Z1RPNThmL1N1QWFseEh1Qk1tbDFGZWR3Ti80MGtKMElNaXcwMEhUTWlrYk85?=
 =?utf-8?B?b25rOTZWQnNMaTVKRHppV3FJZkhBeXk3dW9keUt2SDdaMzZOekwzeXVObmkx?=
 =?utf-8?B?NzZnbElYRWczNEoxTWEzVDlGNTlHSnRBallLa0hOeGswWC9TRDBwNHJGU2hL?=
 =?utf-8?B?Q2x5TTh0WW91cVBSN1FBeFZEcTJKQ1NaV1NzUU1FRmlRcDhGTWY2eHlpczBa?=
 =?utf-8?B?c0txSDJyaDAyVFIxQ1hRVi9UWWdpSnM2L3gvWTNmMWQ2eVBNS1lHYXY4cFht?=
 =?utf-8?B?UXRENitNNWV5eTFnVEtxbG4wNHdKRzlEQWFHbzBFNVJ2bzdIRkh6UTdSNzda?=
 =?utf-8?B?eUU3dW1sOVkwM0MzMkVLZk4wc3ZxUzdBWjRQdVg4WXVnRzBzMWpNQmM0aFdU?=
 =?utf-8?B?WFZIbzY2bCttZWNJNXUveExxNTJXRGg3M2xUbDFqL3M5S1BJZ2NxTVdiUTF2?=
 =?utf-8?B?RHpCUTNHakdPeGVNRzk5Nm8wM3RsTll6SkNTclhtSkZIcStIT3VBQ2RPT1Vh?=
 =?utf-8?B?Z3hoQWErSkZ4SXoySFFxQWRWNUtBd21mUkxJRjR3T3FraUlDalB0V2UxNmNv?=
 =?utf-8?Q?DVmehhjMMqb545Zr/hRUT46Ss?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d88169-1a83-4bf1-307b-08db87a75414
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 15:54:54.7431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AdjgmHkzRyRmvF84qksmejCrAMmR6GFuzbYFF+wj3X9Yfu/Y2+TE45WikVaee5do
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7339
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



On 7/18/2023 8:39 PM, James Zhu wrote:
> 
> On 2023-07-18 10:19, Lazar, Lijo wrote:
>>
>>
>> On 7/18/2023 7:30 PM, James Zhu wrote:
>>>
>>> On 2023-07-18 08:21, Lijo Lazar wrote:
>>>> Not all rings have scheduler associated. Only update scheduler data for
>>>> rings with scheduler. It could result in out of bound access as total
>>>> rings are more than those associated with particular IPs.
>>>>
>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>>>> index 72b629a78c62..d0fc62784e82 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>>>> @@ -134,7 +134,7 @@ static int aqua_vanjaram_xcp_sched_list_update(
>>>>       for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>>>>           ring = adev->rings[i];
>>>> -        if (!ring || !ring->sched.ready)
>>>> +        if (!ring || !ring->sched.ready || ring->no_scheduler)
>>> [JZ] any case for ring->no_scheduler = true, but ring->sched.ready = 
>>> true?
>>
>> amdgpu_gfx_kiq_init_ring sets no_scheduler flag true for kiq rings. 
>> amdgpu_device_init_schedulers inits schedulers only for rings which 
>> doesn't have no_scheduler. However in gfx_v9_4_3_xcc_kiq_resume, the 
>> ring is marked with ring->sched.ready = true;
>>
>> I'm not sure why it's done this way, but this is the case even for gfxv9.
> [JZ] I think the sched.ready confuses people. here just means ring is 
> ready be used.

Thanks for the clarification. One question is then do we need to check 
ring ready status for assigning xcp ids or just check if the ring is 
associated with a scheduler?

Keep only this - if (!ring || ring->no_scheduler) to assign xcp ids and 
leave the ring ready status to the logic which really accepts jobs on 
the ring?

Thanks,
Lijo

>> This patch is Reviewed-by: James Zhu <James.Zhu@amd.com>
> 
>> Thanks,
>> Lijo
>>
>>>>               continue;
>>>>           aqua_vanjaram_xcp_gpu_sched_update(adev, ring, ring->xcp_id);
