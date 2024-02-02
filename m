Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BD0C47DB3
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Feb 2024 13:43:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CE2210E8ED;
	Fri,  2 Feb 2024 13:43:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2u9rLQRg";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5026710E8ED
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Feb 2024 13:43:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOdSAAGoangi+2t+hQvEzjhzhL0e5x4PWO9r0tjifVR/YAkUK6a+5c0/KKpNotUw2+p7JgUaaeanC5v5yK5J/HQr3hMWcybJYDecjcQH+qYTTHod0E5+5MLuREf66stmk5xQtdxD9Nj/9Hs2xcZCMCFzESGmA/0QCQEVoFQEagVGrdqzCnahsIowxiWErnPvWEB3dxpuGY9tAj5QYB2gbsGe93XoUzzS7BXok0Li4uhQp7uysesa3yXUDc2zOwqGbS/xyCVWY/o9w1E93Q85SxIUFQPmkNaF+dW5N6tpXgQSP2s+/9lXNdZfqREnh75YL8nLsbXiLB/HxufXbljkow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUqrIHtKQ7dqLjdXq7/E+8G3+JVq6MhRSlp2q3CkK2Q=;
 b=TfonvDIiQhQnXdwFwbzzNdIU9IHY4c3hm4oknORiNDjZBKZ4jwnSmMsBoSrbwSMk/eu4YAecff9XBLMiSQvPjr7xgL3QtI1GzPPzIIrIQgnS8Dbc4e5zf3OnSyxVbKZ2t9R/gn6257IwGLprBB4xGehBBLTDBO9UfOAC70RUUrsmB7+bXnQMAC6ihOwYySxSUu/RYLXbrwC9Xp602g45+HBjdwnfcRdh3eRGhgFCqopO7SXz1XZmcFWU3W4bkiFI0qKdqbKh3WxBxl0fVZGMTjQiYhXlyp29P9x766b0f0s1mqX6nArn4KYIfcHKh7GaXd6YQ78tWhfxcVHyZftQpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUqrIHtKQ7dqLjdXq7/E+8G3+JVq6MhRSlp2q3CkK2Q=;
 b=2u9rLQRg0yTRu4IxqPmdP3zMl63TmzbAKVWNgQKse08WL4DPwlaqbJ0u1DvIfoUpCrmja4MXt9GMpLaK8pzImfGYWCM0BZy1+3zgd2Bl96ke+api8DTVOCKtHZGnKLWe11s8npcCzxgOQXxl4pyb1ZbYcQ8V5MIv0Bkspm35/cc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH0PR12MB8577.namprd12.prod.outlook.com (2603:10b6:610:18b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.9; Fri, 2 Feb
 2024 13:31:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7270.009; Fri, 2 Feb 2024
 13:31:29 +0000
Message-ID: <da2221ee-9131-46b7-97e1-c489a93bd8d7@amd.com>
Date: Fri, 2 Feb 2024 14:31:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Reset IH OVERFLOW_CLEAR bit after writing
 rptr
Content-Language: en-US
To: Joshua Ashton <joshua@froggi.es>, Friedrich Vock <friedrich.vock@gmx.de>, 
 Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240114130008.868941-1-friedrich.vock@gmx.de>
 <69cec077-4011-4738-bbb0-8fb1e6f52159@gmail.com>
 <abdfec21-2642-4c68-8c51-cdfba54928aa@gmx.de>
 <577a8451-0791-4bd1-8c6c-61a7cc293174@gmail.com>
 <d15ac325-e830-4e11-a239-56eaeddecae8@gmx.de>
 <e977939c-db01-4b14-8494-0bdad5be7a8a@gmail.com>
 <CADnq5_Nb=ruoA2j-mHrQbxHY=yzwGm2kKjDiQ+ajk3urKKLing@mail.gmail.com>
 <42af4788-10bb-4107-bd1a-05f15dc9c1fa@gmx.de>
 <4d3e3c70-3307-4068-9416-613a19f587d4@gmail.com>
 <6590bae2-406d-4f45-a3e9-5dc6653925cf@amd.com>
 <0db29a99-f434-4886-9204-54eafaefa31a@amd.com>
 <60efdecd-0957-4e06-9f1e-7343dff87a8a@gmx.de>
 <098e975b-2271-4f11-9549-40bc2c444a28@gmx.de>
 <d45b23d1-ab1d-4285-8b18-a0eebaa2d871@amd.com>
 <dc8506c4-9114-473e-bfdc-8a24f2264392@froggi.es>
 <2906c98e-47fe-4a39-b32d-9d060d571076@amd.com>
 <e8d1bca4-61f1-4b44-b70b-c66f8b095860@gmx.de>
 <7483cddf-010e-4df0-80ed-468f744449d8@amd.com>
 <17c04323-b645-492e-8df1-7da8c80416f5@froggi.es>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <17c04323-b645-492e-8df1-7da8c80416f5@froggi.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH0PR12MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: e88d4236-f3e1-412c-f7a9-08dc23f34374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Vhg7J5r23jqLMim+ciauYlCGAeiksMhHa+wKTN8U8E8nKkMAw0cvuRR3dgJND8x4xQfGpjBwCu1R5QW5L5yBEJhQXCLdCip0LUoDhvLxdDWJACJLpFs4PCtS3a/+gVzT0l90oMjoV2L7aQy1BzbY0xrn2oK3ksTbjOobQbzk92h1SLBdf5sLinptHEHAEnoUWkOeyCUAdqxAemEp9wTaSSax/4VWSXcx5t+gRSOYxfkqRHjzaIOOFpUsbOsecP+4A3vaLGZJM9cXEoCBZMGsKU/jSgY9VaIVCRlPNn9v0rygIyyaMHG9tqbj9XLySOXLKQ6RCB6P98fIeUMq1N/do0CtsLdbcUyZLmYXJjQDMB7g1b0LN3us8PXGCD16R5jzRNQJo2GLac+ep38DFGUA4OXC3mMZj/IqZ0TDy4PmN3AtM7t/0a7pQ9ZyWEDqDTMd9UFMMhaU6dXqmcs5CuS6oZ2Blily7cQNWyyKy1MTfteZlSidsQDnaxnCnQXe1G1c/9AcjX+3lB0w+7P9w4oNl5YEa5a+rk4JbrXIW4puQACq8W5EAaN3RuZgsxuoGCE5bKLAp1YRwpyZ4pcQralyrMv1jSCvn3obJzDatAuZeSKkXl8fuZjSMihVTBjguUauM7J3H0sT6vadGsxZN+LUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(230922051799003)(186009)(451199024)(1800799012)(2906002)(31686004)(498600001)(5660300002)(83380400001)(6486002)(110136005)(4326008)(66476007)(36756003)(6636002)(66556008)(31696002)(6512007)(66946007)(6666004)(6506007)(8676002)(86362001)(8936002)(53546011)(2616005)(38100700002)(26005)(66574015)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uzk5eU1CQVdudjBFZTJ1YWFrRVJtcmpVZXFNcW1UOFo5a3Urb1hBVkpnc0w3?=
 =?utf-8?B?c3FQaHh2TTRFSUZqNy92Nk1TVHUxZTBPUjhIV2c2cVVWaGQrYU5qa3JrUWtn?=
 =?utf-8?B?NlNLMFA0NWxMcHRaNHdkbXBsWnM1SlFoTkRnY2RlcFNuWlhzKzFJR2Z2SzlS?=
 =?utf-8?B?cFk3MytLd25ETHd6WTNiQm1IMWhxanEzcHNSRHBtYitxTWJqVFZhNlcyaVFE?=
 =?utf-8?B?eTAvRzRoZGdVQmR5YkdaRXd3QzAzU2RaZkgwbXBJa2p2c1hrdDVLRW4zOHp3?=
 =?utf-8?B?ekpsSitvcXBIYW5FOUNuQ3Q3emVNcjVjQlFNOHNVUTJFdUtTcTNyNTB1Rm56?=
 =?utf-8?B?R2djcXZmL2N3SVdTdmptWmRHMm9kSE9yekpNVGlRR3VtQ0RSczd3eTAzWlNh?=
 =?utf-8?B?OVVleVpmY0cvTit0dEJNK3krZmJPcE5UR2FYWXM1TE5qM00zNXprSWFmcWRW?=
 =?utf-8?B?WUU5azNtVjRYamNsRkM1WHJ5SWFoTjBDR1ltZUlQN2VIdTJvTXpvQnhtRFZU?=
 =?utf-8?B?MjFiRStEekdGWGxBZmVRVzV4bUZrSy9aaEJROHo1aWpzSW1ialg0L0FvWWxp?=
 =?utf-8?B?WnExU2ZKQUtMWXN4OUpkd1phTEgwYWp0QkpOMVlwbjlOano2OGg5b3Z2TWVz?=
 =?utf-8?B?UHNESDJCdnZGa1F6bzFBWFhIRFRjeWdOajVFMVpWRGVLUFBPUWxvN2tQL2hh?=
 =?utf-8?B?cG1EK2U2QmpHdWg4OTlZMTBPWGhVYnhJMG54SC9xOVo3U1Bybzg4QVh1M3g5?=
 =?utf-8?B?ZkFkSFQ4ajlmS2swdGEzejRKVzNkMDNDT3NKc25XOXVQUFFDRGwvVG1XVUFy?=
 =?utf-8?B?UGNFektBOGV5WHNUSlUySC9WVko3aFV5clBodXZ6bVRwMHZPNk03RHZJNHJU?=
 =?utf-8?B?SithN1ptQ3lwZjNad1JXUUVJZG5peEozUDlDdHRJdTUxQmhxSkVkMG12ZXdU?=
 =?utf-8?B?NXF0alc0ZlR4SEJlTTBtTmtsMktISml6Mkdtc0NzVi9VRmZuNzBDaklOL3pS?=
 =?utf-8?B?NU1Mazg4VThnQWhYR3I2WXFKVHQ3VzVXL1pmY0FHUmFZWjB6RHdUdkQ3d2c0?=
 =?utf-8?B?WmdzRXRaSG4zd05CeG16bHdpK01aRmpGaytvM3lXWFk1M0lrV1o4SDNraDFI?=
 =?utf-8?B?aUFoUHZOREJyaHFBdjliVUVaZTAwSlRFS3FFNTh2ZHl5M3dyVVhNeG9xMzBV?=
 =?utf-8?B?T1VMQ1BKVi9SNGlwV0lEL000cmhndXdPTVQxWlRZTlZYZWZZcWJXR1ZWMWRX?=
 =?utf-8?B?V3ZXTWZOMFNZZTBNeHZGOFhYMkJ0cXFqWEhQM3BwekdudE96UlRBR05iLzhY?=
 =?utf-8?B?VTlCR1kzK0NCMC9lOEIyV2MwMkVrdXZMbXM0NHNuVXdIZjc1RGx0RUNuUTI3?=
 =?utf-8?B?Nk01d29QNzVNZXk4SU14ZDhySFQ5cGQ1RDN4NytCZlJqNlRuckNrejRvdGtW?=
 =?utf-8?B?WWJ1WWxMM1hVV2QzZDJkSmVrbEIwNXBmdmE3M3lNamk5NG1LbllEd3R2OUxC?=
 =?utf-8?B?d0Y3bE9NK21ITVM3ZHFaVXB4Rk95eXFJUlZ5VEhqYTVkNFlGQy9vMlkvNVpl?=
 =?utf-8?B?YmgvUW9YbFA4YjNzUEJzdjA4aGkra3M0VWJzNXp5YS9ya3IydXFQMU1URkM5?=
 =?utf-8?B?NjUyVzFnd0FQT1MvYWRlY0tITjY4cUNZeXBRTUFWUTJ5TDR6R1o2dHp1RDhU?=
 =?utf-8?B?dnFYbjlOMkdzNUgrdGhPN1gxaFROZmp2Yzl1WjYxN2x3MnpmYkdNSWtaalVv?=
 =?utf-8?B?czhYNTZqbm9vTzlwTFFlalY4NWhrcHRhTldqL1hwelM5RDloZVRRWUNtSXA2?=
 =?utf-8?B?VVFoSlhMK0pWRTA3UTRKRk1nYWlQK1lIdU5FRzF0Tmd1alFyc0MrbDhzNC80?=
 =?utf-8?B?NjlWUUZ6N2VtczQrWFNqMThWK1ZUV0pMblVIWXU5ek1xbDIrenFGaWxUckpy?=
 =?utf-8?B?YU9jUHNGS2ROanhMakd1WThmR3BtWnYyQnJpbWhlYUYzU09XUlZObkdhR01j?=
 =?utf-8?B?WlFXNTFFMjEzU0FJclhwMW5RanJvZEhkT1VQVWtKaTVyOUJ0aTR5a1E1S1BO?=
 =?utf-8?B?eEVpSDVkR2lJVlIwb2FnZW5jemhhTitrR2x3SkxGOXk5dVdleFYvWnBIQkg4?=
 =?utf-8?Q?IDdU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88d4236-f3e1-412c-f7a9-08dc23f34374
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 13:31:29.6966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtubAPSakRJtkT5GGSKmD5VXEE1YAkLJayTKWehe87TTYn9Xyrdh6e50VzRm8IYT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8577
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

Hi Joshie,

the first patch is already on the way upstream since that is a clear bug 
fix.

Sunil has setup a test system and contacted up with Friedrich to get his 
hands on the test application and reproduced the problem. It looks like 
that the OVERFLOW_CLEAR bit is only the tip of the iceberg of incorrect 
IH documentation and we are now nuking the HW engineers responsible for 
this block with questions.

I will also be pushing that we get an IGT tests for this and that we 
find a long term solution to not be surprised by incorrect hw 
documentation any more.

Thanks,
Christian.

Am 02.02.24 um 12:11 schrieb Joshua Ashton:
> Hello Christian,
>
> Any update on finding an upstreamable solution for this problem?
>
> Having working hang recovery is really important for us on Steam Deck, 
> and it would be nice to have an upstream solution, and not carry a 
> bunch of patches you disagree with. :P
>
> Thanks
> - Joshie 🐸✨
>
> On 1/23/24 12:49, Christian König wrote:
>> Am 23.01.24 um 12:35 schrieb Friedrich Vock:
>>> On 23.01.24 10:36, Christian König wrote:
>>>>
>>>>
>>>> Am 22.01.24 um 23:39 schrieb Joshua Ashton:
>>>>> [SNIP]
>>>>>>>
>>>>>>> Most work submissions in practice submit more waves than the 
>>>>>>> number of
>>>>>>> wave slots the GPU has.
>>>>>>> As far as I understand soft recovery, the only thing it does is
>>>>>>> kill all
>>>>>>> active waves. This frees up the CUs so more waves are launched, 
>>>>>>> which
>>>>>>> can fault again, and that leads to potentially lots of faults for a
>>>>>>> single wave slot in the end.
>>>>>>
>>>>>> Exactly that, but killing each wave takes a moment since we do that
>>>>>> in a loop with a bit delay in there.
>>>>>>
>>>>>> So the interrupt handler should at least in theory have time to
>>>>>> catch up.
>>>>>
>>>>> I don't think there is any delay in that loop is there?
>>>>
>>>> Mhm, looks like I remember that incorrectly.
>>>>
>>>>>
>>>>>     while (!dma_fence_is_signaled(fence) &&
>>>>>            ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
>>>>>         ring->funcs->soft_recovery(ring, vmid);
>>>>>
>>>>> (soft_recovery function does not have a delay/sleep/whatever either)
>>>>>
>>>>> FWIW, two other changes we did in SteamOS to make recovery more
>>>>> reliable on VANGOGH was:
>>>>>
>>>>> 1) Move the timeout determination after the spinlock setting the
>>>>> fence error.
>>>>
>>>> Well that should not really have any effect.
>>>>
>>>>>
>>>>> 2) Raise the timeout from 0.1s to 1s.
>>>>
>>>> Well that's not necessarily a good idea. If the SQ isn't able to
>>>> respond in 100ms then I would really go into a hard reset.
>>>>
>>>> Waiting one extra second is way to long here.
>>>
>>> Bumping the timeout seemed to be necessary in order to reliably
>>> soft-recover from hangs with page faults. (Being able to soft-recover
>>> from these is actually a really good thing, because if e.g. games
>>> accidentally trigger faults, it won't kill a user's entire system.)
>>
>> I still have an extremely bad feeling about that. From the 
>> discussions a wave which waits for a fault resolution can't be 
>> preempted nor killed.
>>
>> So what most likely happens is that some of the state sticks around 
>> in the hw and can only be cleared with a hard recovery.
>>
>> For the steam deck it might still be the better option but that is 
>> most likely not the best solution for every use case. It could for 
>> example be that the system doesn't have the full performance any more.
>>
>>>
>>> However, the bump I had in mind was more moderate: Currently the 
>>> timeout
>>> is 10ms (=0.01s). Bumping that to 0.1s already improves reliability
>>> enough. I agree that waiting a full second before giving up might be a
>>> bit too long.
>>
>> Well we should never have a timeout longer than we would expect a 
>> submission to be. So assuming a minimum of 10fps we should never go 
>> over 100ms or so.
>>
>> If killing the waves takes longer than the original submission would 
>> have then there is most likely some state not correctly cleared in 
>> the hw and we really have to do a hard reset to clean up.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Regards,
>>> Friedrich
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> - Joshie 🐸✨
>>>>>
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>>
>>>>>>> Regards,
>>>>>>> Friedrich
>>>>>
>>>>
>>

