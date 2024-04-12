Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83490C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 20:22:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A571F10F867;
	Fri, 12 Apr 2024 20:22:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="avSsI44O";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D3710F867
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 20:22:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcIG3VD2bKBMZVMiTewcTGP5vnW7v6Vtlbx8nEfKPQbyWf7KRvWfB9opIA9XwzPG/cCiv5s4GpQP5RbFE93W0lkpKzLiwlavUf+0BEuPK6WZEv17YLPJ0gJi0x1bNDDUwKFQ4fpUQ7Ouh/qQtdBoSmmeO4BfnUfuucX+cKq4hztEVy+GSBY4YcQRvqbd4vblLVLn2ndMgct/T7q722eDk1LOIIedt1nWSgl6pT6uE05TYHZUOdXndCU7ihsZBUrODyVUdTx0RXfFPot22nUUcjoWjAPgifJxKKKCPTVarzF2UDyNf/W5LDOYcsHmlut3vwuYbo2KLgsO09ystNmPbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/M74DJ9wiuFHbPKZeczcQ3/HXNZGkH+zKHuATrwM+HM=;
 b=jJSSuMXHExiQgYb0d8KINP1LJs1WiNroDJEUHOrZQi+zo6saVQ6MFr4EUT/HTbQeMrUlx/nHA2yzA8ibvLfyYjsbhti70dntiit4ccQ0owj8veWMt2EU+q6BihPW6G79uuZ5x0yn5vmaRqPBOWdgIfvdX0P1E/o8NW6/RlJUL9eio9BkPZBl+5Nc6nIbxpzK4U3TZPjCu65AtaUcgGZyqLT3ECY1Jvepf68wJbJLq+h0WqCxPAjbIJph3hfkWNaBMhUe41kMDGxHKrY9Rk6HRRMGZJw2nUCogTXNzY/7mPPw3iV+EiBDo1yKsETbKcPfCl4T0A2qsXbfBF9fnV+hPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/M74DJ9wiuFHbPKZeczcQ3/HXNZGkH+zKHuATrwM+HM=;
 b=avSsI44OjUajA19DUxeZY6mxGGF8Q6+1rSv4NAZw5WN64JdtClnPEm41AegapQZDbBHS9y08Vs/+slkR0mWN22dHrHS85SA7OAj5+K3IygINoIDL7yOuKy8nBK5eZMzaU1WHp87ScAFxaWlkfEvsS74X88/aau7DmiD0Oh3lDX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CH2PR12MB4246.namprd12.prod.outlook.com (2603:10b6:610:a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 20:22:05 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%5]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 20:22:05 +0000
Message-ID: <0d87bcf4-7ce5-407f-bba0-b6ba45ac36f9@amd.com>
Date: Fri, 12 Apr 2024 16:22:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Enable ogam_ram for dcn32+dcn35+dcn351
To: Melissa Wen <mwen@igalia.com>, Joshua Ashton <joshua@froggi.es>
Cc: amd-gfx@lists.freedesktop.org, Xaver Hugl <xaver.hugl@gmail.com>,
 Ethan Lee <flibitijibibo@gmail.com>
References: <20240410221336.34627-1-joshua@froggi.es>
 <nhr535ncnm6n5btn7o6kkmblppnywvvnni6i4y3v6fmiazbopz@v5wo7kqarrlv>
 <d607ffb8-aca6-44c8-ab0f-e7bf8d3bed0d@froggi.es>
 <ql7dvtd4pa7plrk5e6xdtfs55wfkrsx5nv2bfxtnzfl5l7knek@kbcd2je5o7a2>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <ql7dvtd4pa7plrk5e6xdtfs55wfkrsx5nv2bfxtnzfl5l7knek@kbcd2je5o7a2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0164.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::6) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|CH2PR12MB4246:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2ec49e-f2f6-4c05-4ab7-08dc5b2e3852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BYvc/Wd7d41NZwm0tZKtV6t5/AmTwQEZP0hPOXKghMz7PCo2WazleuUvvAMXhk/fKrUcveQVpqvjESHza1wQgLO3nU5TTYaX6oirdUs/xkRuhXUEj6MYnbSV/SnDhLbTOeT/23KL/QByR/dfnWbvyYKfjTUzkqEHZfPwoji69VRw3j0yI7yITpBh0GaohwE+qGDWwaXkBKmPpvOdRgGCF/NhEbZs7tGNky4NWAULtrxI67Ds95KmRUKWfqjfzQnFmPf1AP6G5OgzQ9DKuedW/mB07Ni871Amd724P6igsa4BBc8oA7i7YwD8JC3LH++8Xu6Cknss5lZu3er1qRqE7rmMR/YD5c7Z3rj2yy5t7XF5lWxTXNDm5fAEWyZjz4dg+3U7RjEAWim9To0oLqCGqHLSMRRAjaRpni1dLxuOeqvD+KYMMMQvMmwZ562VeUi8I+2eL0vwW4ORbnSKfm8BuWslRF0AmggreQvda9flXl3pFzPIPTWoEkdqVK0mMNWJHnvcEgK4Vmh99Hs4WunsTh3b7DvSM33aUpBM2yhnOnJsKXQxiDh5g59TgyqDuEoS7CSI7Jh2P0a+PHF1eUvakFWcDdSVgIRgO7A9srSam4EGgB2F+fg287hBbW/cqzws
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmtuZmpNNEdHQnhBVVYzQUFiY0RlQWk5SC81RERoc1hraVhrazlHa3lHMk0y?=
 =?utf-8?B?MERQQUJYVklaUlZ1Z2hBRjNVMGVhM2pEU0ZPa2I5aDBIcnNTWXphMXNiZFZR?=
 =?utf-8?B?VTRlenh3VzRrK2g3Sm1SYVdSNDFhNDZMNUFQYTBqUFVscWNhU3hjalZlUm82?=
 =?utf-8?B?eEs5NkRvZkxFL3lRY084bll0VjJtWkdLU1FOLzk5VkM5UWRKelA1K3NWYVg3?=
 =?utf-8?B?ejVMNXVGdVZNMjF2UFM0eENCNVhQK2s4VUNnUUV2Z1VtOTdvMVpNY0hXVmJH?=
 =?utf-8?B?c1VJZnRZNTVoaXBYaW4xT3QrZ2ZsUjRUb2kzS0xOS0I4a3Q2NThiWmNMMkUv?=
 =?utf-8?B?bnhFMWtQMUFqU2ZxWHV2eVpLVEd3M2JIM2hRY0F4d0RQdFljOFY2dlNOa0l3?=
 =?utf-8?B?MEJIa2FNN0lDa0JUSS81Mi9IM3o4RHp4ZVZLd2NYRnN6cGxXcDdXeFVPUXM0?=
 =?utf-8?B?YXIzYmgvQWVSWmZtRDJUaGkyZEN0TWZ3WCtnVnlqdXFXbVpDbkM2YzJDSE96?=
 =?utf-8?B?ODBkMW55RTlWVWR4KzUyYmsrQ2dOWktMQVdaNnlSSmNTR1hHeTN3UTBRaE1I?=
 =?utf-8?B?T29wNTY3ZFVsREwxVFJJRnFaUWFGekU4RUlsSFZ6Y3RmdlFFaXVOb2JmNjNn?=
 =?utf-8?B?WlZCcGlqZVBqT0lYUnJjVlVWQS9ORGdHRjNEaEdBbWxpN2Iwb0hKRjkvaU1o?=
 =?utf-8?B?am4yK1IxY1VVSTQzZEhKQUw0cDVXNFNFd0lyR1RTS0Z5cFk0Q2o1ZUtrTnFV?=
 =?utf-8?B?ZkZ2K0pkSmRDVkVIYU9ncm9qa2NzQm5yaG15aFg3bzlDKzI4Zm5ObytGOW84?=
 =?utf-8?B?ZWhITVI4M1ZmOG1Ycjd1eEZjeTcvemNGdGswazZJRzRhVGZKZEtMU2NCdzJF?=
 =?utf-8?B?SzJNejZ5U0xjVUhkWG11K0RUOXVjeTRPVXNVS1RybHhSMU1NbGxmZ3lTL3FO?=
 =?utf-8?B?NVZRM1lSSlhubGFmUzl6bUNQb3dhN242NjJFMmQ1aVpReUV4RTZFVkJlMkxx?=
 =?utf-8?B?UVlGdWlBN3RQT1NabmFFM0RCczF1QzlDeHVaK2dMU3N3RlRxQWdsUU44bDgw?=
 =?utf-8?B?UkN3aStRNGEwTXplRVVGNXdBcmVrdjBGOFA5OUtkSjJocWMyeUVOYldnOEdu?=
 =?utf-8?B?cEFHd2tncmtQdnR6cEh0TWFRNlFQUm1CbGd0TFNtbzlJczU0VjI1RWo4NlZk?=
 =?utf-8?B?OE8yblJQeDA1ZDlYYUxlZ1VFYVlFU2FHZmpKNXIxOENIK2tjRnNPd0ZkREZt?=
 =?utf-8?B?Ky80aitXbFpoVitkVnJ6UDVqNjdVYm9rVGRJNEMwVVlzdmVJUGxMUUZRUXRz?=
 =?utf-8?B?cjVCQTJqNTZkRUVJaTdUR3gza3lLNkFiYUtFME5lK0NBQTZvUkVHN1JMVmN5?=
 =?utf-8?B?Q3F0dFlNL0ovT3doaithVlhMaTAxYzNJN2diRE95MUU4bjBqMWg2NTIzS1Jo?=
 =?utf-8?B?QitKd0txT2tWeWRmWlQ0VmZ3TW94U2dzZm45YmE2SVZxK2FZSElwZTZ2NE1F?=
 =?utf-8?B?VGIwcno4YWlNTnU0MFF3YUxFajVrS0NyUHo3L01OSkpwZTFYaCtFWkNxczBw?=
 =?utf-8?B?L2x0WHJKSi81ay8rSWFIUkRvcmRmdDY5MzJhZkErMHBOZVBQN0JkMUs2MGpo?=
 =?utf-8?B?dzB2V1UyUm1DeDhoWFFjUkYwTEl5dW1oV2pNNnpJejRqbTF3VEFFaVh2Szlt?=
 =?utf-8?B?M2tHOXI4ZmUyclYwZVBYc2g1VzBJL1lUcm1ZaE1SRDdHRFphanBFdTcyNE9h?=
 =?utf-8?B?ZXAwcTMxL2lMRllKTkhtUzZmeVVTemJIcGhpOWhlNUQ0OTlGbyt1b2lJcVZ5?=
 =?utf-8?B?MlZmaVNxS0M3bnVHZHdGRXdoQ3QvOUZUa0VtM2REYS90NVp5YWdwUytBUzIw?=
 =?utf-8?B?RmIrYlhmK3gzUGZUcHlxRk1ZelBJR0tIc1NmSzFQdmN2cDV1Rzlad2pEUFNC?=
 =?utf-8?B?VEZrZDhKc0Z2VkoySDA3aWJJUG92MGVxeUZUUmtMenRMNnJtWWVYZGJTdUYr?=
 =?utf-8?B?UVlGeStFZVE3K0cvOGF5MEZrQnliUlprekQvdW90RkpqV0VFVnJYMStwTkVm?=
 =?utf-8?B?ZTM5Mllsdk54ZWZORS95ZmJlRkV4YklWUHVJNlN1RTdlY3BXYmNncGwyOTNC?=
 =?utf-8?Q?bBc74vqsGsz6YLJYH0KUY2KZs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2ec49e-f2f6-4c05-4ab7-08dc5b2e3852
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 20:22:05.3327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfvw3T2xIV0t6J9G3Rut3h+BAN+fEjxxu2a1B5MkY6rSyPmz+g18079mAvXwzBpSILeftQIFn3/foeF7MY6rTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4246
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



On 2024-04-12 12:26, Melissa Wen wrote:
> On 04/12, Joshua Ashton wrote:
>>
>>
>> On 4/11/24 3:26 PM, Melissa Wen wrote:
>>> On 04/10, Joshua Ashton wrote:
>>>> The comment here states "no OGAM in DPP since DCN1", yet that is not
>>>> true.
>>>>
>>>> Testing on an RX 7900XTX (dcn32), it actually does exist in hardware and
>>>> works fine.
>>>> My best guess is the comment is confused with OGAM ROM for DPP, rather
>>>> than OGAM RAM.
>>>>
>>>> I did not test dcn35/351 as I do not have that hardware, but I assume
>>>> the same follows there given the seemingly erroneous comment.
>>>> Someone at AMD should check that before merging this commit.
>>>
>>> hmm... I don't have any of these hw versions, but AFAIU if there is
>>> ogam/blend lut block in dcn32, the helper implementation for programming
>>> it properly (i.e. dpp_program_blnd_lut) is also missing here:
>>> - https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/display/dc/dpp/dcn32/dcn32_dpp.c#L125
>>> right? So, it's good if AMD people can check it too.
>>>
>>> Melissa
>>
>> Hmm, yes. But, see dcn32_set_mcm_luts, that seems to handle per-plane blend
>> + shaper + 3D LUT state which is equivalent to what existed before?
> 
> oh, cool! nice finding. blnd_lut is set on plane state, but programmed
> on MPC now.
> 
> But I see the color pipeline changed in many stages from this version:
> - shaper + 3dlut before **or** after blending, but not before **and** after?
> - where post-blending gamut_remap_matrix is located now in this
>   pipeline with mpcc postblend_1dlut and shaper+3dlut with mutable
>   position?
>   I guess something like:
>   - [shaper -> 3dlut -> blnd_lut] -> ctm -> regamma ??

[1dlut -> 3dlut -> 1dlut] is now a movable block, called Movable CM
(color management), or MCM for short. It can occur before blending or
after. Because of that it moved to MPC (multi-plane combiner).

If it's positioned for pre-blending it looks like this:

DPP -> MCM -> BLND -> Blending -> Gamut Remap -> Out Gam -> OPP -> ...

If it's positioned for post-blending it looks like this:

DPP -> BLND -> Blending -> MCM -> Gamut Remap -> Out Gam -> OPP

This is the case since DCN 3.2.

Because of that you don't have an ogam_ram in dpp anymore for DCN 3.2
and newer.

>>
>> Therefore, I think I am actually wrong with enabling the ogam_ram in DPP cap
>> here, and the right solution is to change the check for exposing the
>> property to account for these LUTs being available per-plane with mcm.
>>
>> (what is mcm btw...? lots of acronyms and stuff moving around in hw hehe)
> 
> yes, shaper, 3dlut, blend_lut don't seem DPP caps anymore. MCM looks
> like a component of MPC, so I think we need new mpc.color caps to
> describe them properly (?)
> 
> I also didn't find in the Linux/AMD glossary or code comment that
> describe what MCM is...
> 
>>
>> What's a good way for us to check for that? Seems like the caps don't help
>> much there. We could check for the literal function ptr I guess...?
>>
>> What are your thoughts, Harry and Melissa?
> 

I wonder if it makes sense to add an mcm cap to mpc_color_caps. Will need to
chat with some people about that.

Harry

> yeah, AFAIK color caps values are manually set and may contain
> misleading information. I'm unsure that using function ptr would solve
> the issue of having undocumented caps introduced to the color pipeline,
> such as MCM, but your suggestion seems more reliable.
> 
> Anyway, the timing where the color pipeline was merged didn't help, but
> if new caps and functions are not documented and the DM handles are not
> updated accordingly, we will have the same issue in the future. 
> For example, I see two new ptrs were introduced and implemented here:
> - https://gitlab.freedesktop.org/agd5f/linux/-/commit/a820190204aef
> - https://gitlab.freedesktop.org/agd5f/linux/-/commit/90f33674a0756
> and we would need to update the DM color mgmt anyway to check these
> new/unknown functions.
> 
> Seems okay if we check program_1dlut instead of ogam_ram caps, but what
> should we do for dpp/mpc shaper+3d lut in set_mcm_luts? I mean, should
> we enable plane or CRTC shaper+3dlut on DM? x_X
> 
> Anyway, thanks for all these findings!
> 
> I would like to hear more from AMD too.
> 
> Melissa
> 
>>
>> - Joshie 🐸✨
>>
>>>
>>>>
>>>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>>>>
>>>> Cc: Harry Wentland <harry.wentland@amd.com>
>>>> Cc: Xaver Hugl <xaver.hugl@gmail.com>
>>>> Cc: Melissa Wen <mwen@igalia.com>
>>>> Cc: Ethan Lee <flibitijibibo@gmail.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c  | 2 +-
>>>>   drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c  | 2 +-
>>>>   .../gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c    | 2 +-
>>>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
>>>> index 9aa39bd25be9..94f5d2b5aadf 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
>>>> @@ -2182,7 +2182,7 @@ static bool dcn32_resource_construct(
>>>>   	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
>>>>   	dc->caps.color.dpp.hw_3d_lut = 1;
>>>> -	dc->caps.color.dpp.ogam_ram = 0;  // no OGAM in DPP since DCN1
>>>> +	dc->caps.color.dpp.ogam_ram = 1;
>>>>   	// no OGAM ROM on DCN2 and later ASICs
>>>>   	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
>>>>   	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
>>>> index 25ac450944e7..708d63cc3f7f 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
>>>> @@ -1861,7 +1861,7 @@ static bool dcn35_resource_construct(
>>>>   	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
>>>>   	dc->caps.color.dpp.hw_3d_lut = 1;
>>>> -	dc->caps.color.dpp.ogam_ram = 0;  // no OGAM in DPP since DCN1
>>>> +	dc->caps.color.dpp.ogam_ram = 1;
>>>>   	// no OGAM ROM on DCN301
>>>>   	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
>>>>   	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
>>>> index 8a57adb27264..053e8ec6d1ef 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
>>>> @@ -1841,7 +1841,7 @@ static bool dcn351_resource_construct(
>>>>   	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
>>>>   	dc->caps.color.dpp.hw_3d_lut = 1;
>>>> -	dc->caps.color.dpp.ogam_ram = 0;  // no OGAM in DPP since DCN1
>>>> +	dc->caps.color.dpp.ogam_ram = 1;
>>>>   	// no OGAM ROM on DCN301
>>>>   	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
>>>>   	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
>>>> -- 
>>>> 2.44.0
>>>>
