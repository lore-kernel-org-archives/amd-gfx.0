Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85594C4725D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 13:36:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C58010E139;
	Mon, 22 Jan 2024 13:36:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBF9310E139
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 13:36:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNvfrJ7qlED6hjoQ5tVwBR2dC/9cd9M6d8Hb4A7LAy5Bia569xdKYISHfTmn6/MXpl6+5b0EFSPGfLe38cj8qy7rjlZF81NnrgEIPFMitGmxCyM+01/p84mh5r5U23pgpOk3y40PpnZCnnPoDw35+2BySCaNA4ylRR9+r060xBgYwm4I6l/EuTFGg/a+PHwTBOzMnlk0lXzXV5azYJ7eaWWDtgWs/NuWCzCNNEeXJQ12xYw34pdlPjwcOM7LgpdoM6ycLkbQSUmt3Vcs4AkEjylpcLS4C9ubNJu34zKX0rxKez+xof+M4+4oiyybPpZLcgtnozfW5o9VmLTmvnLOdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rW+EgUk1hy7IPE4hdRpLcOC+I3jZhQWdUNV09dpZuk=;
 b=V2M+UAyRRdJmfUaFdPc9Kp5+xyTFRwdHUAfl1LcH9NvQgL17JQ6Ttnr6QyVsOERYt49EuKBkcqqczSNQKphPxPms12yLw6N45YUQPRUmPHREBFRiX0MLgT7R6JFnYyX+WZeQm56HE8+iUWIad4DdbHe0Z7kZMyNM0LDAFkwl/UukWF5RDKR7o36BXQRO3OSyKH050QD9GUucnyoMSkz2mgwBvJzt1kqB/lWH1i4e3tGtH8vaOFcwhwHcMpFVgYRoc7d0fLbtoXf1kDbKmaWVXz06zZz6Qf9sDiX6Kcc8jY2OXi19eu9ZZmBVPlpNSn4VDKBcfK5P9/Zyv3qKOULyTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rW+EgUk1hy7IPE4hdRpLcOC+I3jZhQWdUNV09dpZuk=;
 b=ynu33qey7gzh0lRUmGbgHmb8+EeuYxa2novlvecY11hZ+Y8vW+4p17OuQV7N+MrQm5fiJqz69iDnuoMW0oJOQKDG/WKGAj3pqkwu4B1zJimZ2cfbIGGmp0GC/aGLsg5RsI/CsoNXb35Ox8/0mPeN94vQT3AA9wFKhCosfBUYpss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV3PR12MB9412.namprd12.prod.outlook.com (2603:10b6:408:211::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 13:36:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 13:36:06 +0000
Message-ID: <d45b23d1-ab1d-4285-8b18-a0eebaa2d871@amd.com>
Date: Mon, 22 Jan 2024 14:35:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Reset IH OVERFLOW_CLEAR bit after writing
 rptr
Content-Language: en-US
To: Friedrich Vock <friedrich.vock@gmx.de>,
 Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>
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
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <098e975b-2271-4f11-9549-40bc2c444a28@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0259.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV3PR12MB9412:EE_
X-MS-Office365-Filtering-Correlation-Id: a303cf00-5c26-4b6e-3251-08dc1b4f15e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V3HIT/m1CIqBc82xwvOX+AGg55dAhKVZZSzYYc4GQafDuFio9rvtdS0aTGf6+1IDE2GzVbUzYQY1y78Uj7Fn+2+15zQKN9QrYzhNgekz/smEYwyKoVmiBJgCfS+wZkGaRGaE5WYweUxzGdOvlXAN7MSXmMNqf3HIpc4enoPt5mQSZ3l4euZvmKyqKVaC4SgXWVC6xKy0JegB9ULBri+/lB88cmMFq7IoHMy0kqdc0pjiRVNE81Wv74WDkNVwTyFrnj2tZ8qs+3uOQfwySjsOejPO4GqhbTM1bSyG2DhrS9SyW80/YYgpx+vPKXSp3xWWDeOAPsozolk3FVCIpm2IAK5P1Tev7YLRRriCqgqBo4SKvi2HcrelNc/Bz7uDv25bGF8UZd5+35nRzUVgPr9MKpGEwWtTJmh9YlSE2GGH9KALsmFUc6TXfGfxrPViqnHRLjDcAJnKJt3ypyu1PjgZkBab7vXTe6rR6T+IYsaXSfJqQDa+OEYb13hwHqivQ4zDbG8sYWrPMUt1XQ29vkCDi84g8+mBZAz/jZJGBmaL3kYcfMovWgdyOcSc2Jkt6w5f5GdDXBus78WzNHqdnGPRc0n02JRh6fuBA97th4XpHPEy4AWPBJYoYZQf7x2/0ii+pLxdOG8ZFqKSO04cXn31VA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(66476007)(66556008)(66946007)(8936002)(8676002)(110136005)(2906002)(5660300002)(6636002)(54906003)(38100700002)(316002)(31686004)(83380400001)(4326008)(41300700001)(6486002)(2616005)(26005)(478600001)(6506007)(6512007)(53546011)(6666004)(31696002)(66574015)(36756003)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDh6NFBscE0wYjNGdE1ZdFMvRjhHQVRxVmVDMThrRmZZeVpUZmhxSXRJcUtI?=
 =?utf-8?B?akZ1TXcxNnFVVDQyU29WRjBheTJuMURXRm5uMlovdzJuaFdjS21wVDYxM1U0?=
 =?utf-8?B?cTdzUTJiV2RGOUp5eVBmSjNyTmFZMW01R1JQWm9sM1FtVFlOd3pudWJMMEcr?=
 =?utf-8?B?a1hnYTg5M09VeFM1Qjl0VFZsdnpMOEF4RER3bmJacXNNT1VFRGdHd1ZjL2RR?=
 =?utf-8?B?ZzR4VCtoblFwdjROYTN4WXh4Q1BZQTA1WEpKMzUvRmdMMzVMdXJzdWMzdVZ2?=
 =?utf-8?B?ekY4ZTQyTHFzYTBFRk5KVTQ1TFdTSzA0Z094SWZLVkoyNlhPOFRwMVg4ZDBn?=
 =?utf-8?B?N3d0RDU1ejczUmtVWlpRRG1GSUVYaDd6MENkU2FlM0dZR2J5ZlpTT0JIalZW?=
 =?utf-8?B?UHZCS0gxOW9LVG1uWGUvMWdIRWhpSWRwajArbHlYeTBwc0gweU9ScWZjZVdW?=
 =?utf-8?B?YUwyK00yV1pDaU1INk1ZNmhTNG9Kb0xxcndUeFlCbG1MM3R0dVlrb2xyTkxY?=
 =?utf-8?B?SGJQWFlST1gzcHJlRXl6azJNT3RMN3RZU2c3ek5GOE82YkFtT0FCRXNFNjhj?=
 =?utf-8?B?NkVLL1pjL25zaytiLzg4NzR3aVRrait0YitiZEtTZjZEaDZMcTNOeGxuTHkr?=
 =?utf-8?B?UWRVTFVhOCtHNDZvU0lIRkt5Q3pRSDNXa2VnZmtHQW9nWjNjeWFzR21qZHUz?=
 =?utf-8?B?MzRTbUllWkJySEp2YU9GVGdWczdmWnB3RHZrZ0lCZ3U0elFadS9YOEh2YjlX?=
 =?utf-8?B?cW5xV09IR3hRdDNHZlhscWx0elF2MC96Uzg0dHVSTWdNNEVjYU1tcnNBcm1r?=
 =?utf-8?B?a0R4YWt6d3ByTmowOTQweTVGNXc4alJNdTFhR09lYWFzbnhKaERETU52T2tD?=
 =?utf-8?B?V3AzVmN1LzF3UUlrdUhhdDM5bVNiZmlOWDFxWG1KM0FBWjJ4WEtEbzJaSy9L?=
 =?utf-8?B?YWd6SDNUVnRQMEJMRXBzYjJQZU1BaFllZTdTNVlGN2NGL3ZiS0NkL1VPbzZp?=
 =?utf-8?B?SW1JQlNCMkMxME5Odnl4ZTF5T3N3V0JrSlB1QXdxNi9PYSt4azkyNGg4N0Rp?=
 =?utf-8?B?TlFOMDNmUjgvRjZ1STFwUncvYWJiMzkrU0prYnpFSy96US9HZlUzcUU2ejZT?=
 =?utf-8?B?UkpSc3RQZ0tSR0xXTGgwY0hRcHROd2xIRlJCdFZaWU5vUS9qd21ZSU5lUGJN?=
 =?utf-8?B?NFdQNG1jc05tTnk3ckhhcmFUblEvc05nT3pEYzZkSkMzNjI3eEJFTEV4QXFv?=
 =?utf-8?B?cyt5dHdSaVpCb2F6bFBkM01kdVRSd1ZlWXZGWFN4R0ZQRkQvVDRpdnMyT3ZU?=
 =?utf-8?B?Mld5MlkzOVVzWkMvT3FkN3JUbElVNUZJbGtxcWFIOTEyZVZ1QlhSUTc4Q0hq?=
 =?utf-8?B?dmZLaHBZb05jZ2NGNmI0L3ZqeHdnZUF2M210b24rTGFDR1luM2lmV1BIRU54?=
 =?utf-8?B?c2dVNmJtWjJLcCtYRnFnbUNkdlFlQWdzVXk2NGNKenBzdXJxM1FSbGdTbUtw?=
 =?utf-8?B?MmMwYS9rS1FHclJPTW1OVDU0dGhXeWtOOE5ZVXJKbGhXVDArSWUxODNLOFUy?=
 =?utf-8?B?ekpjVmFuZTBjbkI5a25FNnJiUzVsWGVTbXl6LzVZZ3F3NUxpckFKQlVJWmtm?=
 =?utf-8?B?NGZWVU8wZi9JYVljRzFsZjd2SVpEMXd6Qy9JSGdCUG5RQUxweE5DM0kzbjAr?=
 =?utf-8?B?NUtDaEJVSFRsbkh3SzJhOG9OaEtGa3l4OEV6ZnJXSEg2c3RCbnZhRDcyODl5?=
 =?utf-8?B?STZyYnEwKzBxOTd0VElwN2xVQzgwc0djQkJmNHMzdmhmZHRsUHgzanVYeEd4?=
 =?utf-8?B?VXA0RGFJd2lXcnVvUm1BRXF5cS9vdFl5UXovMWlzQkU3eDV2ZkVLMm9JNGl1?=
 =?utf-8?B?YkhBbUZreTkzTkVYd0JhSWV4Ym5uZDRONXA0Q2Y2QXh3Rkh6K2JXOGRRVXRi?=
 =?utf-8?B?RGwxeWxJSmsycFk4VTkzektYbGJhRTVNVHJYdDc4Wm9wclg2cm1kUWtITElp?=
 =?utf-8?B?NS9seHBSYU5PK2Q4UHdPL3hyckk0LzYra1R4R3UrSy9uRWZqd3hxMkJXU3Ex?=
 =?utf-8?B?OVJ2N0UyN1Zkekk1MEdDdUZTd2RIYTZXUjdZWWJVWWgyKzJTcjYzWTZ5ZTRa?=
 =?utf-8?Q?3gqWnHXi668nizhfBCA0o6Cf8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a303cf00-5c26-4b6e-3251-08dc1b4f15e9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 13:36:06.6865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1cWWuSw+fIvETY7hJHeZrYaohR3jEwRgffs7BFoc+A9YO1Z1mTKRHKedNRJzsEdU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9412
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
 Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 22.01.24 um 11:45 schrieb Friedrich Vock:
> On 22.01.24 11:21, Friedrich Vock wrote:
>> On 22.01.24 11:10, Christian König wrote:
>>> Am 19.01.24 um 20:18 schrieb Felix Kuehling:
>>>> On 2024-01-18 07:07, Christian König wrote:
>>>>> Am 18.01.24 um 00:44 schrieb Friedrich Vock:
>>>>>> On 18.01.24 00:00, Alex Deucher wrote:
>>>>>> [SNIP]
>>>>>> No, amdgpu.noretry=1 does not change anything.
>>>>>
>>>>> Well the good news first the hw engineer answered rather quickly.
>>>>> The bad news is that the hardware really doesn't work as documented
>>>>> in multiple ways.
>>>>>
>>>>> First of all the CLEAR bit is a level and not a trigger, so the
>>>>> intention to clear it is indeed correct. For now please modify this
>>>>> patch so that the CLEAR bit is set and cleared directly after
>>>>> setting it, this way we should be able to detect further overflows
>>>>> immediately.
>>>>>
>>>>> Then the APU the Steam Deck uses simply doesn't have the filter
>>>>> function for page faults in the hardware, the really bad news is it
>>>>> also doesn't have the extra IH rings where we could re-route the
>>>>> faults to prevent overflows.
>>>>>
>>>>> That full explains the behavior you have been seeing, but doesn't
>>>>> really provide a doable solution to mitigate this problem.
>>>>>
>>>>> I'm going to dig deeper into the hw documentation and specification
>>>>> to see if we can use a different feature to avoid the overflow.
>>>>
>>>> If we're not enabling retry faults, then each wave front should
>>>> generate at most one fault. You should be able to avoid overflows by
>>>> making the IH ring large enough to accommodate one fault per wave
>>>> front.
>>>
>>> That is the exact same argument our HW engineers came up with when we
>>> asked why the APU is missing all those nice IH ring overflow avoidance
>>> features the dGPUs have :)
>>>
>> I can reproduce IH overflows on my RX 6700 XT dGPU as well FWIW.

Interesting data point. We have probably looked to much into the faults 
on MI* products and never checked Navi.

Can you try to just setting WPTR_OVERFLOW_ENABLE to 0? At least in 
theory that should disable IH overflows altogether on Navi without 
causing loss of IVs.

>>
>>> The only problem with this approach is that on Navi when a wave is
>>> blocked by waiting on a fault you can't kill it using soft recovery
>>> any more (at least when my understanding is correct).
>>>
>> Killing page-faulted waves via soft recovery works. From my testing on
>> Deck, it seems to take a bit of time, but if you try for long enough
>> soft recovery eventually succeeds.

Ok that is massively strange. We had tons of discussions about that 
shader can't be interrupted while they wait for a fault on Navi.

Maybe killing them is still possible, need to double check that as well.

>
>
> On second thought, could it be that this is the critical flaw in the "at
> most one fault per wave" thinking?

Well completely agree that this. That rational to leave out the new IH 
features on APUs is rather weak.

>
> Most work submissions in practice submit more waves than the number of
> wave slots the GPU has.
> As far as I understand soft recovery, the only thing it does is kill all
> active waves. This frees up the CUs so more waves are launched, which
> can fault again, and that leads to potentially lots of faults for a
> single wave slot in the end.

Exactly that, but killing each wave takes a moment since we do that in a 
loop with a bit delay in there.

So the interrupt handler should at least in theory have time to catch up.

Regards,
Christian.

>
> Regards,
> Friedrich
