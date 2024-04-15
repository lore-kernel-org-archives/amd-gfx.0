Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AD4C00A94
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Apr 2024 16:04:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B59641126B7;
	Mon, 15 Apr 2024 16:04:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aSr1FYUg";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8820D1126B7
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Apr 2024 16:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ga/uQCX9tWnXqTmiYEh8FTioAFsSdxkv44ob60FxjKixMQDK6gf3qdmw9GOtz//rb1WtSeCRGHjXax4NfFCRY8hH47HzbXKHXoF77qSPn8ESpGNtIDffw+vEWFlKtTMpRfrkC3wTvCn4nUwTgEKVrZbkEXCdZINxNTMv2tjzBhWbda2QY4GEtRWN427xMoMZFn7YdzCOCPyKOxpud9gO+tt8hgv+OwamJZMFKoJ05F5vGwPX4V1xR1D/hvjXXlxdMbMI+Kdi6q9YJZgM7vSVy8ZnhfeSGCpONUJBl89OjsSjDfbUN4EAbMvq9Fn+UHNDBVPk702ByAsrw373QKiDEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UR5XkIu74ZE1c2rxAvBjlL7ktJ4pEDKRVsY2oRLAnKI=;
 b=kTmMG7L82gWOsg5OM4Y9aa9oC0eA5WvQ2S84UHsysVuzB7x6+jppghPjgvCxkSMexNG1atSO+bHK2aosNGlwTTD9GO0+gQbywnA8+skmWjvlVCQ5OWB351MOy6OeKycf4JJmlys8QHpZMLfScHp+F6O4PvUhDRzKifxh3P2jqVrpO2NDHEbN/2xQSxj7b/jbpA1Gl1+3B2zexCrjd0l0Kb+LTZPQq7Kx82joSaB2Sokf8qp/Rvb2+Zg29kannMaZvt5fDtvRmcIT0qKzEym2SvfwVOOAVlDHqtLEKAVVX5mjd5mwlokq9C+BsOhKEeqYpuYan2gCZu/Zc0Rpto2aug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UR5XkIu74ZE1c2rxAvBjlL7ktJ4pEDKRVsY2oRLAnKI=;
 b=aSr1FYUg8CoZiZorfNZ93sQ71Q2xUSpCoRJ7bkLJgiBUaU9P/j/t3+2F/h4tPa1sxiD8dJflXULD9oVwqPX6Dw72/b0iITK1svc3y8nYi29E0LXme3IipoXh2lmhaxINPMJYkQWmy7d0Mq9iPos8lHu6DN6XdKwxCulkrrSKlvg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CYXPR12MB9319.namprd12.prod.outlook.com (2603:10b6:930:e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 16:04:12 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%5]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 16:04:12 +0000
Message-ID: <1b55bb0a-4cf6-4274-bc1d-fc9fba558c49@amd.com>
Date: Mon, 15 Apr 2024 12:04:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Enable ogam_ram for dcn32+dcn35+dcn351
To: Melissa Wen <mwen@igalia.com>
Cc: Joshua Ashton <joshua@froggi.es>, amd-gfx@lists.freedesktop.org,
 Xaver Hugl <xaver.hugl@gmail.com>, Ethan Lee <flibitijibibo@gmail.com>
References: <20240410221336.34627-1-joshua@froggi.es>
 <nhr535ncnm6n5btn7o6kkmblppnywvvnni6i4y3v6fmiazbopz@v5wo7kqarrlv>
 <d607ffb8-aca6-44c8-ab0f-e7bf8d3bed0d@froggi.es>
 <ql7dvtd4pa7plrk5e6xdtfs55wfkrsx5nv2bfxtnzfl5l7knek@kbcd2je5o7a2>
 <0d87bcf4-7ce5-407f-bba0-b6ba45ac36f9@amd.com>
 <c8635e5a-111d-4991-a89b-a40c9f64e376@amd.com>
 <o23hy6szj4ikxixrizjth7w6cdg7z5r74c77gi6lucpqhba6sr@xurztpq6uiml>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <o23hy6szj4ikxixrizjth7w6cdg7z5r74c77gi6lucpqhba6sr@xurztpq6uiml>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0018.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::21) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|CYXPR12MB9319:EE_
X-MS-Office365-Filtering-Correlation-Id: e760b59e-7435-4424-1c3c-08dc5d65b0b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YXJSs9HhgTQvarccm/Umgq/N3sKY0GJvWKBHLLLp8nRf1x/MYL7VvyYWYwur7ocDJH4Pf48lURuc/Wtj7x0XLTQakS45XuLqfUhtM7XwNQXYnBNR4PpfNAP1AHZCTavrQZB+pIA1iBSkoaeHQ9ENxdkkxQb9ptK5hNHmLWq4wycsymq5Lkw1ADoiv+LK0EADigk+M4d+IVk5w/r7PunTVZ3JFMcpfEj4qFJDQG5aJvjhWvpE2EbtmluL1c3MOGa+LFpa1BLd+wlWFidyj2xWRQq7Ksx+Kf+iYZcqQOIPgVd2dTclrPVYcNVJrHdZEuqqThWzjVgDRB78l1fath98Ho8cMXQI3IyKfnNm3Ef1wWDZKouqOEXWFMmtOryxKTo6RRfL9tLCJmthTjFOpLfzP+gSt2wbyYbYnaDY+isuVN2V4pdy+zPq0SBCnzK7EVNLQzhv9dRrnR6i1BgMill0rDAkIGC5S5ksmtdirGCu6Qe2hvR19ZwtGjkmqxPAsq21j6M18rBXB1/3D8WQZAELhh47vByUgCfyWJSYaG9/QJu3fTa1NXi32Oz2R3Ca/HpfkHiJMbfMA6kfXq0hlsC0XgMDT311CQL5+teq2/q10GV7kfQRrqEHtsAJ1Td+XP62
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFA1bmRGd2s4clVFeVNkVm9aM3FRUW5pcTJRU2tEZWNkNStXUkh1QUdhYlJy?=
 =?utf-8?B?ZzlxR2c4Y2I5ZW5USHdFOVpkV0pTdkRsbURrYTJrNGRJU0x2ZDNGLzdDckEy?=
 =?utf-8?B?dXorWUdwbE9waFIrWVF0Sk9HWnl6WHZQNWpmV1BBZjgxbXBtZXpEQk5namZM?=
 =?utf-8?B?UHJKdXVGYUJqdTZvTndmaEZna3QyZ0I4K0RLS0twQzlZczV0a01BeUNFZzg0?=
 =?utf-8?B?QThMVzBMRk9qUzRQOWxjUzN4Y3RnZE8yN0diOGVRbjlHK1BKelZuYWRBUXFP?=
 =?utf-8?B?bWdrZEhsbitSMjhZdGdxdnZEVXo5R1loZzEwV05kcTIxbU1yUkEwaXlRRGVh?=
 =?utf-8?B?ZjVkV3V6bWFlYW1OcUp3STVQa2VkNFlwWmNORDlhdjl1Y3RQM0NhaGM0dWcy?=
 =?utf-8?B?UWM3cTFHQllwU0E4eXVsS3d5UkhHdDRRTXBlTTZ6VFhHR0pUZjl5SzBMQjFM?=
 =?utf-8?B?WkFOL3ZiTjUxRjZOY2R0K1p4YVhkeHdRdTdERTVpYjlndEtoSW54K0t0YXFs?=
 =?utf-8?B?OWtPTDhBcTRseEU1bUc1U3d6YzRJMkVpcWhqQ0dlaC9CaGJXbU5zSGl1cXpW?=
 =?utf-8?B?bk1GSmdaclZUQ2JhUkp0bkJrUDNHcEE2clliaGFSb05oRFNMSmwzdUJ6dkRT?=
 =?utf-8?B?eXRKbXJVR2tYWG1HeWZtWmxjNkhtNlJXTkR1bjNYSnhZdGdmc0ordElzclNl?=
 =?utf-8?B?aGJMamVVZVVwaVRTUmM2aEk2UVVQYlM1NWtZOHJldHY2dmxhMXA5OWJscUxl?=
 =?utf-8?B?WEtybzVaNFB6cG1LQTE1NkowMVh4bTRkcElOWlR6Wlh5R1g3QmgvQlJRQzIw?=
 =?utf-8?B?UjI0ZjBSL1RrY2pnUkY4bGlCMVYvalpCblg2M2RZMjA5RGVWaFgxR3NaR2ZZ?=
 =?utf-8?B?dDJNSW1mZkVtVVdGRnRTcEFScTVqTzFYcUJKZitlSDYwaE1BT1JXaG1TR3lq?=
 =?utf-8?B?M0plYUd0dWpiOE82dW9qaW5tUU5ML3c1QmVKT3ZGVVI4WGY1NVMvdjE0QVpm?=
 =?utf-8?B?N1RJditXeForem51a1B0T3I3emZmR20wU3pncGduWnUweTBlMS95TVFHUjhM?=
 =?utf-8?B?dW0vZGI3ZHJTMjgrR0l6NTJUUzF3MkFNaEozbHJlL0Y2Y2xLT2FiNjIxSTJR?=
 =?utf-8?B?aWhKcVRyZXBDeVYzNjB5c2dTR200Q2lPdG5ic2pJZnUrTG9tcGdhaldGSHdM?=
 =?utf-8?B?ajRUUkVmYUVvVm5uWG9RMGFNNlp6OVU4Z2RkMDBsNmxLeEZsbXVETk83cWl2?=
 =?utf-8?B?eG85b0RuTTVuMEliazdBOXoxaStEMVh3TjllTkxJNnMxSXBiVDVLUHJSVWZZ?=
 =?utf-8?B?L3QzdnNETlBNMjNLZWVnSWFjeTBlRFJzWjBMQytSVFR3VEsyYzlPVlBXaXE2?=
 =?utf-8?B?b05oVDIxREh3RFNMV3RZc3ZlZytMcWkxZVc0c0wwc00xT0Q4QkkzN0NhYlMx?=
 =?utf-8?B?SmZ5S3ZLOFY5SC9HV2pzcCtoRFN5aTZ0VGFFZ0laSkFjamVkdDFTK24zSWUv?=
 =?utf-8?B?cXRQQ2pjVWFxZVZQUUdlU1VoYURiaVhrbnVCcXJycEZRNjR6VWtnNUZhUWVP?=
 =?utf-8?B?MC8ydVBWaGlKMWI0YXhRVzhjZE9nNkRMNHVNMkdjWUs3alp4ZHh2RXlTSytU?=
 =?utf-8?B?N0FmYkVvY252NDRPOUVVVmkzdTNMRmdJcXlibWk0di9UN1BkeGU1LzdqWlNi?=
 =?utf-8?B?OGhpeDVzejduTjd6UlZZYnE3cTRGY3owVldrMUhsZmpVbCtnYVVOZXlrQjcw?=
 =?utf-8?B?YTNYTEovYzNLVk9wNDM2b1lWbCtHYlBkS09EMmhERFpIUTNPM3dqQzFIcnE2?=
 =?utf-8?B?dkVLY2xnM0Q4eTg4c2wvSEVNaVFZM3VLdGg4R2pub2Z5OCs4T0ZuNFVwVnBY?=
 =?utf-8?B?RWp1NXVDSzRnejY2WTNUcmEwbVNtYnFTRzgrMitEM0k4R2JEL3NsQnZ3Q1ls?=
 =?utf-8?B?YkhmVklORE1PdFgzenpsSnFwNFQvYmJDenEydHNBcHpjcnVTK3d3U1kxQWU0?=
 =?utf-8?B?a3pieU5oMWlXYU9WeWFSa2lNRFR3YU5UNTZNZThyVVlPbmluTGRoWmM3Skpo?=
 =?utf-8?B?SnNHVG1yODI0WlFHYkZKTlE5RnRGZlJvaG5PMDFlakRXY3h1OFZBWGtHekN5?=
 =?utf-8?Q?iuskPdFiCBiG8dh1TAbdl5NQN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e760b59e-7435-4424-1c3c-08dc5d65b0b0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 16:04:12.7170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ViBHIbmcEpwXAmjHlOOw3/T0oi0UkSPHVNazumNi2CPf0qs0vMa6H+q/hIiNueFKSpJ4w0Yeuk5ynedl5me+nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9319
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



On 2024-04-15 11:27, Melissa Wen wrote:
> On 04/12, Harry Wentland wrote:
>>
>>
>> On 2024-04-12 16:22, Harry Wentland wrote:
>>>
>>>
>>> On 2024-04-12 12:26, Melissa Wen wrote:
>>>> On 04/12, Joshua Ashton wrote:
>>>>>
>>>>>
>>>>> On 4/11/24 3:26 PM, Melissa Wen wrote:
>>>>>> On 04/10, Joshua Ashton wrote:
>>>>>>> The comment here states "no OGAM in DPP since DCN1", yet that is not
>>>>>>> true.
>>>>>>>
>>>>>>> Testing on an RX 7900XTX (dcn32), it actually does exist in hardware and
>>>>>>> works fine.
>>>>>>> My best guess is the comment is confused with OGAM ROM for DPP, rather
>>>>>>> than OGAM RAM.
>>>>>>>
>>>>>>> I did not test dcn35/351 as I do not have that hardware, but I assume
>>>>>>> the same follows there given the seemingly erroneous comment.
>>>>>>> Someone at AMD should check that before merging this commit.
>>>>>>
>>>>>> hmm... I don't have any of these hw versions, but AFAIU if there is
>>>>>> ogam/blend lut block in dcn32, the helper implementation for programming
>>>>>> it properly (i.e. dpp_program_blnd_lut) is also missing here:
>>>>>> - https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/display/dc/dpp/dcn32/dcn32_dpp.c#L125
>>>>>> right? So, it's good if AMD people can check it too.
>>>>>>
>>>>>> Melissa
>>>>>
>>>>> Hmm, yes. But, see dcn32_set_mcm_luts, that seems to handle per-plane blend
>>>>> + shaper + 3D LUT state which is equivalent to what existed before?
>>>>
>>>> oh, cool! nice finding. blnd_lut is set on plane state, but programmed
>>>> on MPC now.
>>>>
>>>> But I see the color pipeline changed in many stages from this version:
>>>> - shaper + 3dlut before **or** after blending, but not before **and** after?
>>>> - where post-blending gamut_remap_matrix is located now in this
>>>>   pipeline with mpcc postblend_1dlut and shaper+3dlut with mutable
>>>>   position?
>>>>   I guess something like:
>>>>   - [shaper -> 3dlut -> blnd_lut] -> ctm -> regamma ??
>>>
>>> [1dlut -> 3dlut -> 1dlut] is now a movable block, called Movable CM
>>> (color management), or MCM for short. It can occur before blending or
>>> after. Because of that it moved to MPC (multi-plane combiner).
>>>
>>> If it's positioned for pre-blending it looks like this:
>>>
>>> DPP -> MCM -> BLND -> Blending -> Gamut Remap -> Out Gam -> OPP -> ...
>>>
>>> If it's positioned for post-blending it looks like this:
>>>
>>> DPP -> BLND -> Blending -> MCM -> Gamut Remap -> Out Gam -> OPP
>>>
>>> This is the case since DCN 3.2.
>>>
>>> Because of that you don't have an ogam_ram in dpp anymore for DCN 3.2
>>> and newer.
>>>
>>>>>
>>>>> Therefore, I think I am actually wrong with enabling the ogam_ram in DPP cap
>>>>> here, and the right solution is to change the check for exposing the
>>>>> property to account for these LUTs being available per-plane with mcm.
>>>>>
>>>>> (what is mcm btw...? lots of acronyms and stuff moving around in hw hehe)
>>>>
>>>> yes, shaper, 3dlut, blend_lut don't seem DPP caps anymore. MCM looks
>>>> like a component of MPC, so I think we need new mpc.color caps to
>>>> describe them properly (?)
>>>>
>>>> I also didn't find in the Linux/AMD glossary or code comment that
>>>> describe what MCM is...
>>>>
>>>>>
>>>>> What's a good way for us to check for that? Seems like the caps don't help
>>>>> much there. We could check for the literal function ptr I guess...?
>>>>>
>>>>> What are your thoughts, Harry and Melissa?
>>>>
>>>
>>> I wonder if it makes sense to add an mcm cap to mpc_color_caps. Will need to
>>> chat with some people about that.
>>>
>>
>> I dug through the code a bit and talked with our resident expert. It looks
>> like all the programming for in_shaper_func, lut_3d_func, and blend_tf should
>> still work and assume a fixed pre-blending mcm, which is what we want.
> 
> Hi Harry,
> 
> Thank you for explaning the latest changes in the color pipeline.
> Since MCM is fixed pre-blending in the current dcn32 driver:
> 
> 1. I understand that the implementation for post-blending shaper/3dlut
> isn't available in the current dcn32 driver, right?
> 

Correct.

> 2. Does the dcn32 hardware itself support the configuration of both pre-
> and post-blending shaper/3dlut at the same time? Or, for example, dcn32
> will advertise two color pipelines: one with pre-blending 3dlut and no
> post-blending, and another without pre-blending and only post-blending
> 3dlut? 
> 

HW supports it. SW (driver) support is lacking. At this point I'm only
targetting pre-blend MCM. We can consider postblend MCM if there's a
concrete need.

Color pipelines would be per plane or stream. In the case where we'd
want to support both pre-blend and post-blend MCM we would have 3dlut
in both the plane and the (to-be-implemented) stream color pipeline
and reject an atomic commit if the configuration can't be supported.

In theory one could support both pre-blending and post-blending
3dlut if one picks two pipes to drive the configuration.

Either way, adding a post-blend MCM will complicate the entire thing
a fair bit and for that reason I would prefer to avoid dealing with a
post-blend 3dlut unless we get a specific ask for it.

Harry

> Melissa
> 
>>
>> Caps don't really reflect MCM very well yet. We could either add an mcm
>> flag to mpc_color_caps or simply check that DCN is 3.2 or newer:
>> 	amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 2, 0)
>>
>> Harry
>>
>>> Harry
>>>
>>>> yeah, AFAIK color caps values are manually set and may contain
>>>> misleading information. I'm unsure that using function ptr would solve
>>>> the issue of having undocumented caps introduced to the color pipeline,
>>>> such as MCM, but your suggestion seems more reliable.
>>>>
>>>> Anyway, the timing where the color pipeline was merged didn't help, but
>>>> if new caps and functions are not documented and the DM handles are not
>>>> updated accordingly, we will have the same issue in the future. 
>>>> For example, I see two new ptrs were introduced and implemented here:
>>>> - https://gitlab.freedesktop.org/agd5f/linux/-/commit/a820190204aef
>>>> - https://gitlab.freedesktop.org/agd5f/linux/-/commit/90f33674a0756
>>>> and we would need to update the DM color mgmt anyway to check these
>>>> new/unknown functions.
>>>>
>>>> Seems okay if we check program_1dlut instead of ogam_ram caps, but what
>>>> should we do for dpp/mpc shaper+3d lut in set_mcm_luts? I mean, should
>>>> we enable plane or CRTC shaper+3dlut on DM? x_X
>>>>
>>>> Anyway, thanks for all these findings!
>>>>
>>>> I would like to hear more from AMD too.
>>>>
>>>> Melissa
>>>>
>>>>>
>>>>> - Joshie 🐸✨
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>>>>>>>
>>>>>>> Cc: Harry Wentland <harry.wentland@amd.com>
>>>>>>> Cc: Xaver Hugl <xaver.hugl@gmail.com>
>>>>>>> Cc: Melissa Wen <mwen@igalia.com>
>>>>>>> Cc: Ethan Lee <flibitijibibo@gmail.com>
>>>>>>> ---
>>>>>>>   drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c  | 2 +-
>>>>>>>   drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c  | 2 +-
>>>>>>>   .../gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c    | 2 +-
>>>>>>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
>>>>>>> index 9aa39bd25be9..94f5d2b5aadf 100644
>>>>>>> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
>>>>>>> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
>>>>>>> @@ -2182,7 +2182,7 @@ static bool dcn32_resource_construct(
>>>>>>>   	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
>>>>>>>   	dc->caps.color.dpp.hw_3d_lut = 1;
>>>>>>> -	dc->caps.color.dpp.ogam_ram = 0;  // no OGAM in DPP since DCN1
>>>>>>> +	dc->caps.color.dpp.ogam_ram = 1;
>>>>>>>   	// no OGAM ROM on DCN2 and later ASICs
>>>>>>>   	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
>>>>>>>   	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
>>>>>>> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
>>>>>>> index 25ac450944e7..708d63cc3f7f 100644
>>>>>>> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
>>>>>>> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
>>>>>>> @@ -1861,7 +1861,7 @@ static bool dcn35_resource_construct(
>>>>>>>   	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
>>>>>>>   	dc->caps.color.dpp.hw_3d_lut = 1;
>>>>>>> -	dc->caps.color.dpp.ogam_ram = 0;  // no OGAM in DPP since DCN1
>>>>>>> +	dc->caps.color.dpp.ogam_ram = 1;
>>>>>>>   	// no OGAM ROM on DCN301
>>>>>>>   	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
>>>>>>>   	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
>>>>>>> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
>>>>>>> index 8a57adb27264..053e8ec6d1ef 100644
>>>>>>> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
>>>>>>> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
>>>>>>> @@ -1841,7 +1841,7 @@ static bool dcn351_resource_construct(
>>>>>>>   	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
>>>>>>>   	dc->caps.color.dpp.hw_3d_lut = 1;
>>>>>>> -	dc->caps.color.dpp.ogam_ram = 0;  // no OGAM in DPP since DCN1
>>>>>>> +	dc->caps.color.dpp.ogam_ram = 1;
>>>>>>>   	// no OGAM ROM on DCN301
>>>>>>>   	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
>>>>>>>   	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
>>>>>>> -- 
>>>>>>> 2.44.0
>>>>>>>
>>

