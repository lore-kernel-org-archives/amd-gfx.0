Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B0DEB64DC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jul 2023 16:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0F1610E376;
	Tue, 18 Jul 2023 16:12:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BE0D10E376
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jul 2023 16:12:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTZ/n/3cQ6gki4hMMF4Wf89YmVM0dj+HjB46eAHh2lN1NMYW1bk91KwpASmv0TMMtL3YWRvGzJLS7PG9PSI5q125QDfsh+sSLx0p9iyCLFyNerEJR5ZzrocU0WJCIDO0NMtpL/m68znnhisjje1c0luxFoVtL9IDacqJ9Y3VV4G+gRt9GU41nKkV4026atwZbeBZosEzRhDPNFgYNGauL6zWBctJcR3zeoGjHmmjwpRumb0RT8ZT621SDwr+/Q4le48MYE4LmZZmanIMzR6Vnsrx+dgX9d0dwI2BN5YEe6Tmv3SjPBlK50/XP5D9nEvvRfhXV7grQ7hXXUjINSWlwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yoCEfbwtbG12V3TfcJGpyjTRLO+KWuCkJlPPRv1Tgo=;
 b=ZY8a70Xa0VlgBVfPv5va8OPwwxkd9VyfHuLv9ZlrToM0pnzAWq6aVZm/FQcuFQGoxIIQPeX5t0iAZLKGelWTh0AdO/TnAehN4hiMYQdSY4TrNnWBFf01Ll2FHDb+cMiVcBlw/7NdnAe9za9TSzwK56Uw3WzxkZkK7/07AwMg+JD54SMWYhFr15yVFJ2I9/UpfDSTXiJ+6r2ZSKcTIkr+MzUW0mEDGVNXrxIhuJNxZEhZBeQsDqYsYsV5V0R0d4ZRsnXjIwEYkaOqhDPhZmF5FYb3cWLklnD75W7QOc0YnO04K5QiPpITYb93CZXsr33jkCBEb2NajBpUxqF2Jghd6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yoCEfbwtbG12V3TfcJGpyjTRLO+KWuCkJlPPRv1Tgo=;
 b=2EXgzx/Ftb+gYd+fZkW1ijkrNWde8m0nVL/fDY/U8E4sKXDWzrAb39TGgexAdozpKXKciX86zrzwkpxXG8B9IbA68rV+/Am7jwrus3wfT+7yO3sI6ZqV3vbDlLQARw9+ER5nJh/LFBoD+131PWPTSq+HRoOmnhG/TZ3DFNX1Fz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 16:12:43 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::e30e:689d:405b:b3c2]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::e30e:689d:405b:b3c2%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 16:12:43 +0000
Message-ID: <844c21ed-fdeb-d6d7-f103-c4d0660544ae@amd.com>
Date: Tue, 18 Jul 2023 21:42:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: Update ring scheduler info as needed
Content-Language: en-US
To: James Zhu <jamesz@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230718122120.2938177-1-lijo.lazar@amd.com>
 <843196d3-fc53-77f3-26c5-8df479539f7e@amd.com>
 <c4ea8242-ff13-f395-2eb4-b15633253dcd@amd.com>
 <5de2cb5b-ccc2-68a6-aacf-f1882885817c@amd.com>
 <23ca1d49-ea6d-0980-1bdc-f24a48a880ab@amd.com>
 <7c6c2699-0732-9e6b-4c5c-f36bcfa83814@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <7c6c2699-0732-9e6b-4c5c-f36bcfa83814@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::8) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: eb84587a-364f-47c4-aa1b-08db87a9d0d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dc+koKtHQGJz4CQMB4ZMrV+G/j8kiurOKT4cWlyuQQNpCi2YhS4s7eEBrG2kWXXIX4fg6fdqWZ9JZP1lLI8laMxeKhBmjxyOvT3heJx0DeCXUDNJJH0tNFKwT7iO5QdsWqyweLsS8A2Z/rpy93fBhAUSK4oHub1c+LRFzMF/hKBu1vBO52bLVjqpUCmw57XfWh/ue5ZIhmtEAoA/tqwiMpuggNhtT+bOHWn+6tXFse5dQseCRZ1wKavBAu9TylL/W701648m5iTlv4c6xaAnTyaT4AcM55TswdjCLXWrlBAMK0d3xPccPBnlk+3ANy9bb5C+ZWAcuEkUJDDUK6H03IQfQWbPizVHiBSW2OD+IUAcDX2BMU3dmIDnpEut6gAhYc/uXL6LhzxDkc/QoQhlM45kQAGHfvAdMnk693g88zs8dLFqnn/+vdqC0QUVLF+pGEemtNQSepkLEe1/GgDT9IzWkMUu7Z0zXW8fITeGVUHkof6gMrvGx3D0G5AfmY4mJDoOaeoc2ueotWZ08sL9uRkFYqPGxGrr2EvJuFYp+E7J/h+7XVkGFd9uL62eg+jwxB9aM1Vf8YnO3Exiq9hGvNtyAwobEwEHbjLBDHAmpEb6ll92sjWBajCjMs4+k+3+tDcqjwoqoW03LJgrZ3OxhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199021)(6512007)(53546011)(6506007)(36756003)(66556008)(38100700002)(66946007)(66476007)(15650500001)(31696002)(2906002)(5660300002)(316002)(8936002)(4326008)(8676002)(41300700001)(6486002)(26005)(86362001)(6666004)(478600001)(31686004)(2616005)(83380400001)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzhxM3JKTjNkZHp5S1pWdmRLcEpsaW90WkNReHpuWXRHTE5JY1p5d25oSW9S?=
 =?utf-8?B?REMvZ1hUd0pVR1M1QjVHVzd4TlBOenJBZ0xKLzgxUHR6N1puUlNHalQvSCtr?=
 =?utf-8?B?NmJ4NzlGRm1PSDlTSyttUkROOFJpdUVwV1pIM3F0SGJtRk1KNzFJRW05YWpy?=
 =?utf-8?B?dGtMOG1EbElVTGpMejNGUFEyQi9UNCsyZ21ReEcxRWEydm1vbFpUanovRnVx?=
 =?utf-8?B?YnFTMUR6aDVKYXJ4dVFweVA5U3VCTGxTZ2x6WDNDQUQxVUQ3NlAyUnlNZytW?=
 =?utf-8?B?RmdML3NteHpzcHp0cXhENVNITllVdmo2dHFsYUNXZEJIZmdpc0hpRThhSkxH?=
 =?utf-8?B?dXJ6UTNXMkdpSURlS3JWcXh6UlhpR1ZxdTYzb1loK05ZcDlLY1BVVWJNL2s2?=
 =?utf-8?B?UDNUQnhWVEtCSlVEVmVRaStpem5uYlMwdFVnRGl2S01KdE9GM1RLQXFDQktv?=
 =?utf-8?B?a2lCQzJIbkhpWVI5ajdKV3lKQnBqbUY3MWpXNWxQUjlyWUhlL2Vxb0kxNEdR?=
 =?utf-8?B?d2NvVXhqTW5kaVdsSm4vMU9PVG5VNEQvL243ckpneUo3T29SVUp4RjduT2NR?=
 =?utf-8?B?dDE0QWV0RTVSVi8xUHZtVVpLNFBRWVhRd3RNQ1phRVB4S2tWTlpHOGErQ0xt?=
 =?utf-8?B?SjFqWi9NeEVWVkdUeW1lUmxXUGtDS00wdXBJUkFiVlZDeHVMZzdSQmFYcnpw?=
 =?utf-8?B?d0c1NUlIejE5THU3Q2tEVmY0cnRYQmNUa0gwVk1xaTgvbVpqbnl4VGZGNWRE?=
 =?utf-8?B?c1lJK3ZNa0gvd1FaU0NPYUVOaXAvQTdaeG1wdVR1UE5ySjBVR3NWazU2Qkg4?=
 =?utf-8?B?R3NUcWQ3VFhpZWdrMlJIeWl6bk5XT056VlVzN3ZCZU8yWWJudnJuVEMxaENK?=
 =?utf-8?B?SHlhUVFtRFBJS3RpSURpeDljRiszNkNCbUNaM3A5MEl5blJQaEltTzdMSGlt?=
 =?utf-8?B?K043RzdmRTZzL1htWEVHdnRNYWdRUkE5K2Y4UXlJR2ZnNEpmQ3ZvajRQN0RO?=
 =?utf-8?B?MVJRa3FXNVJBZXM0YVd2MElKUWVCWlJaOHZ6M2xGek1xTjc0YzZORnNkYnB6?=
 =?utf-8?B?VlVBbWplZUwySnVhVGlwZ1REMXg2QW1oUStvQkNuTFEveE1SUnM5Y1MwV2RV?=
 =?utf-8?B?bThydmoxWHVmcVVlSWZnUVNyeDR1dmhqTUZyRUswSnRxTFc5TmxSQ1MrQlNC?=
 =?utf-8?B?YkV3THh6T0lDN1VqQWtQbG5WcklOYkFJNytOUUNBSHpiSCszdHZTVFh1Q1FO?=
 =?utf-8?B?OGpyYjN0TVVkc2IyQkswbEhJVGhwQWgrWS9vK090aUNGREtZeHV1Mnlud0d4?=
 =?utf-8?B?NEsrQzVLS2M5S0poVHFKQ3U5RWkwK2p4d1QzQ2lIUHZBcmlkQkFselNPQ3gx?=
 =?utf-8?B?RCtpL1k1aGZOV3FpOUJSNFQ5M2NoTWNJckVPb1Nrc1BMUW5BN2NLd3JXRjFY?=
 =?utf-8?B?MHpSYkswNVc0a0hlTG00aDV2NFhoejdXZjJwWVlBaTBWSUhRY1BqQ2wvYUtO?=
 =?utf-8?B?WWtISDVqdDFCNDdkek1oaDllSnpiaWliMWNhU2lVOU5Wc3UvUVFMYjI3S0N0?=
 =?utf-8?B?N3NkV2RFR004R3RjUHhIUW9QVkc0RTRLanBIUExLZERsV2tleTJyUUd4dG0r?=
 =?utf-8?B?dHVHVFdGcU90dWExd1krNGN3ZkRVWmtsQ3FCa1NiL3plcEFWeUptRlljRUlC?=
 =?utf-8?B?Sk9ZeDdIY1lmZ1dvQ3pDeEY3NUVjb09OS3NQaTNIK29oNlVmdlArWG94c3Uw?=
 =?utf-8?B?QjRuVSttcG9Hb0lBU3dHUTd0S0Q3bytOakVHeEtIZHJlS0NpTXpkd3JsZEdq?=
 =?utf-8?B?ZHp5cHNiMitSRHFQbnhES21CVlVzK1ErUWYrc0FacGRZV2Y4NHh5a0twT2NC?=
 =?utf-8?B?L0VicEk5OUY2aGhDa1V4bWNaaWg3dmdCVGY1cUZQdmdrZGFjMEsyMzJGQWZR?=
 =?utf-8?B?VGdKUlJYaVlub3ZMaWNDazRBdWM5eVpEc3RkSlZ3MjBBbmtHUjNWTWlXN3lm?=
 =?utf-8?B?RGdCNmZBUDdlcmNZRTdCWGJRQ0VZempFR1dtNDZMY3lCZDQ1R0hZdEhERUtx?=
 =?utf-8?B?TlJYOFJwNTduV3g1WXRxMjdQM28zeUhYTG5rVHBwWkpBRjhVbE5XWUp5VUdV?=
 =?utf-8?Q?PAOmA4lsjNMcbgZw9da9wBlhi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb84587a-364f-47c4-aa1b-08db87a9d0d7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 16:12:43.1547 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCVLusnVfJKAJnsUGpIaVL4cvwlZT+ZUriYjkRg2OPue40iLwr5xMCFsus0lSGZ6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573
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



On 7/18/2023 9:39 PM, James Zhu wrote:
> 
> On 2023-07-18 11:54, Lazar, Lijo wrote:
>>
>>
>> On 7/18/2023 8:39 PM, James Zhu wrote:
>>>
>>> On 2023-07-18 10:19, Lazar, Lijo wrote:
>>>>
>>>>
>>>> On 7/18/2023 7:30 PM, James Zhu wrote:
>>>>>
>>>>> On 2023-07-18 08:21, Lijo Lazar wrote:
>>>>>> Not all rings have scheduler associated. Only update scheduler 
>>>>>> data for
>>>>>> rings with scheduler. It could result in out of bound access as total
>>>>>> rings are more than those associated with particular IPs.
>>>>>>
>>>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 2 +-
>>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>>>>>> index 72b629a78c62..d0fc62784e82 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>>>>>> @@ -134,7 +134,7 @@ static int aqua_vanjaram_xcp_sched_list_update(
>>>>>>       for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>>>>>>           ring = adev->rings[i];
>>>>>> -        if (!ring || !ring->sched.ready)
>>>>>> +        if (!ring || !ring->sched.ready || ring->no_scheduler)
>>>>> [JZ] any case for ring->no_scheduler = true, but ring->sched.ready 
>>>>> = true?
>>>>
>>>> amdgpu_gfx_kiq_init_ring sets no_scheduler flag true for kiq rings. 
>>>> amdgpu_device_init_schedulers inits schedulers only for rings which 
>>>> doesn't have no_scheduler. However in gfx_v9_4_3_xcc_kiq_resume, the 
>>>> ring is marked with ring->sched.ready = true;
>>>>
>>>> I'm not sure why it's done this way, but this is the case even for 
>>>> gfxv9.
>>> [JZ] I think the sched.ready confuses people. here just means ring is 
>>> ready be used.
>>
>> Thanks for the clarification. One question is then do we need to check 
>> ring ready status for assigning xcp ids or just check if the ring is 
>> associated with a scheduler?
>>
>> Keep only this - if (!ring || ring->no_scheduler) to assign xcp ids 
>> and leave the ring ready status to the logic which really accepts jobs 
>> on the ring?
> [JZ] I think keeping ring->sched.ready will reduce schedule list which 
> will save a little scheduling time.

Fine, will just push this one.

Thanks,
Lijo

>>
>> Thanks,
>> Lijo
>>
>>>> This patch is Reviewed-by: James Zhu <James.Zhu@amd.com>
>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>>>               continue;
>>>>>>           aqua_vanjaram_xcp_gpu_sched_update(adev, ring, 
>>>>>> ring->xcp_id);
