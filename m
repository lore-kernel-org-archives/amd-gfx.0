Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA3EC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 21:05:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DF6310E977;
	Fri, 12 Apr 2024 21:05:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PFahCs01";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8369710E977
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 21:05:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhUYuwQaql3FoUdrh95KDKAOQXV26UJjEELGssk3+v6v3xD9UyBEct3OOoTDWFcaJxbB/hJe61CQ0wqCKpqrFw2MZ707rjd2ON1QDzY+bS1ylzzXD43EzrsGC53ZkncF0FglGm2aj0FNTdEFSRIjW1JhxiLx3H4KSZFOdf8T44dfWFuMZJSlMrYHpG/Zw5Wh9ILGCXoRlsP1xhz4pP06mWkNTEeP4CzJfgWVEwq6Nb9KKAm1SED38JGxz7OoFB80WOZ11b/aUhPYqEKjUZ5X0LVYt75HBthFUUvhVCCL4A+hHbWg4rB9Sr3yY6NRPyQJNc+p5HQOl7YgK8iOBss5HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llScZtS2Kn5rFKBTVvvkLKdxVJ8qGeT0Nk2KUzKznDc=;
 b=b9Bi8FTbzbpvQxgErBn6dtlyhpJL5VGDoIWmrLTuK20qxWxKelZQTvtb1qbfae3ZvSp6vm1nnwjVu0i+Y6coFzbWQjKuCTH1YMAogxI/7r0uIEL20sgLMEiHKYg7AHkvUlFxt2cGQ52IDQzRcpZWNMmqEGrCQ3JYSxCbx+qlLrdM612duLdzx27J/H5Uf4tuuFwDb//Ce+WAPjsQupEciMydeeqLr49iqagFkbM5V2KiuWW9jKuP5Dy2fbwNBMumUEpfiG7pPaswC4lMZOiheoufcM/EuOQ1HnIKcqmKsx6a1EIp4J8hH25I7OXdwsKO0xY8khOLrBQG1A5vOYPmBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llScZtS2Kn5rFKBTVvvkLKdxVJ8qGeT0Nk2KUzKznDc=;
 b=PFahCs01KdC1HhhmsvkT7Jlc5DFFgAApqJxMNIGZ1TzUogkZQsToMQQHMN/jlOFSoqmH6EWXQ2JkGVVRYnsxvjL+ya1a8xe+2lYRtKw07L7JePvoHx+WyyD3mp1zqk3fEUHoQ4lk1bEQMfkOFyn12KlxoimsW55Umr6uArNuk4Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SJ0PR12MB6901.namprd12.prod.outlook.com (2603:10b6:a03:47e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 21:05:05 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%5]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 21:05:05 +0000
Message-ID: <c8635e5a-111d-4991-a89b-a40c9f64e376@amd.com>
Date: Fri, 12 Apr 2024 17:05:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Enable ogam_ram for dcn32+dcn35+dcn351
From: Harry Wentland <harry.wentland@amd.com>
To: Melissa Wen <mwen@igalia.com>, Joshua Ashton <joshua@froggi.es>
Cc: amd-gfx@lists.freedesktop.org, Xaver Hugl <xaver.hugl@gmail.com>,
 Ethan Lee <flibitijibibo@gmail.com>
References: <20240410221336.34627-1-joshua@froggi.es>
 <nhr535ncnm6n5btn7o6kkmblppnywvvnni6i4y3v6fmiazbopz@v5wo7kqarrlv>
 <d607ffb8-aca6-44c8-ab0f-e7bf8d3bed0d@froggi.es>
 <ql7dvtd4pa7plrk5e6xdtfs55wfkrsx5nv2bfxtnzfl5l7knek@kbcd2je5o7a2>
 <0d87bcf4-7ce5-407f-bba0-b6ba45ac36f9@amd.com>
Content-Language: en-US
In-Reply-To: <0d87bcf4-7ce5-407f-bba0-b6ba45ac36f9@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::16) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SJ0PR12MB6901:EE_
X-MS-Office365-Filtering-Correlation-Id: 901ea784-9e0f-4d48-7721-08dc5b343a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IYzqxqYnyNKxOVQfSS/luFO6kS6BxwIEL4ah2odrdo/ADCKuI9v+8QfSNas2NgsEL32ZFc4og9k5/wh1q/2poctWibOlemrdg9jU2f6CAnC6m4FiVHJXmnzKbSTEjOP2NzWBbv3SHT51FBIHqQ0cfGUHQjn/UqXYYjQPbTll7W7nRfPQanH8qM8fLfD1SaKtnWMevG5mLdUITgXXZ5UskZNmoNkLGa1eIPvuM0kwLaXFPBnOa7zTlQSXGUvqynLYXFoLLRhmMyZkIYEiHLhK50jecLittci5z7vlKiGqZgRg26YpK1zov8dIfahBtiGsKJUpy/l8g4sh1qPG+BZ0FbqWn97u3k+aza3hyx048G4HBLscX99EEbSx//ArRAxlmLVinaqaA9xdN2zAvSXt5NCvhfQmIExBmBLZz8+MH4gnLPNkJPajbALFrVhygLI4uQL7NjhbltgrXh6YnV/BBj+WKtTTRGKFnjBVV6bfO3XfcjMeP47XJoh17KS22Nz9FeebPmFqE524pwq46yJLUln9UPa5JdrA9FUD1tXEGHNBpLk17jL0Xs5ZY/zja2hoWGZO2rdbI3PEZPVPLcXZwniyKKnhupATnDGijT/iGwrScdw2d00k8wNoV/qLdG71
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzFQcm11RU9ySFlmZ21yOXdjdGpGNk5KY0piNFpKcWZpME42N0VWYUxTMGlD?=
 =?utf-8?B?TE90cnpWbHdQZ3ZsWXFjSklvRGtDQ0pDWkdYVjkzZm9md0JUUFpya2pFTVBS?=
 =?utf-8?B?TmM3Z3ZiY3hjZnNISnRHZGdXOHBBMVJUZHoza0ZianBLZm5PWTRtZllTODFk?=
 =?utf-8?B?NUYxbkt4RnFaODJiN0pzME9WK25keEU0QzB0NHZNV2Y1UnorWDRXWHcrUUlq?=
 =?utf-8?B?bGNjU29qTllvNE10Q0twY1ptdHJxTmJpc0xESEYvVkl1UzZRVGVPcWZEU21H?=
 =?utf-8?B?aEVzbGtJcE1iUTlwdFNqcFFsajBaTDBNZUhsblNyRmhaNTJ1MVJEVFJlcGR0?=
 =?utf-8?B?MXJKU3IvRzJ0Rk9nNld3VklzK0VoWVRIaGx4VnRhVm1lUU5FNExhSXZyZ255?=
 =?utf-8?B?NTJ0em1KeXZtNjNRUngxSEorcWtGM2htZFBrV0NQSUJPeUdHSW5KajhuK2xT?=
 =?utf-8?B?ZUF6MEhjamREeFIrRWZLYkFJenJDRlVJSWJ4elhlaUVLMFdURUV2b3o4UmMz?=
 =?utf-8?B?bVBHallZVTJEV1dxQlVmVzJKTXRvTnl5Z3dyd0F2YkJQQWlNb0RMSHFic3dL?=
 =?utf-8?B?QkxQZHRnWDFKMXhzL2JYU2IvQzRVMDI0VjFhbXZxeHIwdjR2MVpaemJySWM4?=
 =?utf-8?B?ZVVHQ1A2STI4dUFqWHpoVVQveE5LdWUzOEJGT3JRMmtNd1hYSmhtTkxYYTdF?=
 =?utf-8?B?c2lsWU9Zbm9vV2xOY2dBcDgvMXV0R2gzT1RNQjN6cTZ2MGJ4ZFBrYWoyY2J2?=
 =?utf-8?B?Y2w1VlZTUzlFenl3Q3BBZmdwQjZ2K1J3Wmk1ZWIwUmJPSEp2bHhpMGJYRjNJ?=
 =?utf-8?B?S2JMZW03SzdFUndxUjA3N1pjcDR2UVUwUzZaQWhncEpxeG5tNGRrYlp4b0gv?=
 =?utf-8?B?UzlZazBka014TVVnVUl1ckNmRHcrS2ZGbkVUMC9kVDF0b1JYcjU0RmF1M0JU?=
 =?utf-8?B?NkF6bGE2Zm1DbytydWJzQk4rTGp4N2JoUUlUR2JrOTREaDg1TDkyNmtnVnZm?=
 =?utf-8?B?c0RldExGN0NrS0llNXZONkp5ZzBSRGtZL1lETUo3VTlSNjNDbzM1clk0alhW?=
 =?utf-8?B?RHFRQ2ZpbVZEL2pMTXhrRlNiR2lzS1QyT3NZTEdSMzFJYU1NcnBidERZQk10?=
 =?utf-8?B?Zk56SFJoQUlDY0xnaFF1VFlBelZEcStOUCthUVpHbllSYnRtNWVPWVBhMUlZ?=
 =?utf-8?B?alFUbE1neXJMWFhGZWxZN0xQdXV5dHJYdG1MYjhJb0IwOVBHRWtPNWtlcXBJ?=
 =?utf-8?B?dm9aNFN0dCtkaUZ2QlBjWVIvSGMxQVpPZEFQSkJaQ0FWZlljcjdxTXJFNEw3?=
 =?utf-8?B?YTFVVHV3Y0c5QmhndTBUaG53dFg2VTU3Wjhvekp2L1RHaUQ0eTFiSnB6djhJ?=
 =?utf-8?B?cFBEWlp2Z05pSTY3ZERXekRsSnRZMXZ4ZHIyeDJJdkc1VHhNVisreFFFRmR4?=
 =?utf-8?B?KzJXZkZWN2xxVE1vUmJINkZKdnRPZS8wRjAyTVVUazVJcy9jWmVIQWdpR1Vk?=
 =?utf-8?B?RnlUVkxESnp6amh3RG9HbFBEVU92WDQzUHNNKzhDN2NLNk5CRUpQUGFQQ0Q1?=
 =?utf-8?B?WE9GcWdXN3p2ODNmL0JBZUJ1S2REZU5TVldISWFpT29qcFJDRTZCaHVzNzNT?=
 =?utf-8?B?UG05bkxnVit2MkQwNkprUFRhckVETnRIVXhDL1NQY1M0NU9qUWhBbEZxNit0?=
 =?utf-8?B?WW9YYWQ5OVlFaHN3cEViTW00Z00rM2huUmFJL252SU9LWTFWTDZ6TWpJdkYx?=
 =?utf-8?B?UmQrZzlWcnJzWm4vb0VkT1U5MW1Za2lHdmk3TzZabElNTzFkb2pLSmlpcVYw?=
 =?utf-8?B?cDduY3IxZmlNZFNvWC9NTEZtUXZ4RUNYUTg4UTBYRC95RTJlNnJ0eHF3SFd2?=
 =?utf-8?B?SzN2bGVKa1VnZHU3cVdCdW43V1lORFpoUTBodTNLSm5idzVnSGd6ZTBZQmVy?=
 =?utf-8?B?T0FHeXJkZldBTGVyNFpUTjk4TnowamRRVWpjK2E2S1Z6WHVpUTJUSnk4Q0Rj?=
 =?utf-8?B?bVpHc0JFeVczOVV1OFdVVHVJbExIcm1kQzAzUStlUGdSWGppTWY3NGpYWmNX?=
 =?utf-8?B?Rk45eThCUyt5OXpyS3ZSa1lSMmVManlOKzlocFFLK1VqSmlWK0x2bnd0MU1G?=
 =?utf-8?Q?TVTRdkxm7gaAsPrsgmVAX7a1d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901ea784-9e0f-4d48-7721-08dc5b343a05
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 21:05:05.0925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nV773Br/0YMgp4dEN9Ts5Vy3LGQ0XNWIlTdH/2XOxMN+RFkm0jNtDS35wfaK4IaB59XnA0vgVpOct3gq/BsRwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6901
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



On 2024-04-12 16:22, Harry Wentland wrote:
> 
> 
> On 2024-04-12 12:26, Melissa Wen wrote:
>> On 04/12, Joshua Ashton wrote:
>>>
>>>
>>> On 4/11/24 3:26 PM, Melissa Wen wrote:
>>>> On 04/10, Joshua Ashton wrote:
>>>>> The comment here states "no OGAM in DPP since DCN1", yet that is not
>>>>> true.
>>>>>
>>>>> Testing on an RX 7900XTX (dcn32), it actually does exist in hardware and
>>>>> works fine.
>>>>> My best guess is the comment is confused with OGAM ROM for DPP, rather
>>>>> than OGAM RAM.
>>>>>
>>>>> I did not test dcn35/351 as I do not have that hardware, but I assume
>>>>> the same follows there given the seemingly erroneous comment.
>>>>> Someone at AMD should check that before merging this commit.
>>>>
>>>> hmm... I don't have any of these hw versions, but AFAIU if there is
>>>> ogam/blend lut block in dcn32, the helper implementation for programming
>>>> it properly (i.e. dpp_program_blnd_lut) is also missing here:
>>>> - https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/display/dc/dpp/dcn32/dcn32_dpp.c#L125
>>>> right? So, it's good if AMD people can check it too.
>>>>
>>>> Melissa
>>>
>>> Hmm, yes. But, see dcn32_set_mcm_luts, that seems to handle per-plane blend
>>> + shaper + 3D LUT state which is equivalent to what existed before?
>>
>> oh, cool! nice finding. blnd_lut is set on plane state, but programmed
>> on MPC now.
>>
>> But I see the color pipeline changed in many stages from this version:
>> - shaper + 3dlut before **or** after blending, but not before **and** after?
>> - where post-blending gamut_remap_matrix is located now in this
>>   pipeline with mpcc postblend_1dlut and shaper+3dlut with mutable
>>   position?
>>   I guess something like:
>>   - [shaper -> 3dlut -> blnd_lut] -> ctm -> regamma ??
> 
> [1dlut -> 3dlut -> 1dlut] is now a movable block, called Movable CM
> (color management), or MCM for short. It can occur before blending or
> after. Because of that it moved to MPC (multi-plane combiner).
> 
> If it's positioned for pre-blending it looks like this:
> 
> DPP -> MCM -> BLND -> Blending -> Gamut Remap -> Out Gam -> OPP -> ...
> 
> If it's positioned for post-blending it looks like this:
> 
> DPP -> BLND -> Blending -> MCM -> Gamut Remap -> Out Gam -> OPP
> 
> This is the case since DCN 3.2.
> 
> Because of that you don't have an ogam_ram in dpp anymore for DCN 3.2
> and newer.
> 
>>>
>>> Therefore, I think I am actually wrong with enabling the ogam_ram in DPP cap
>>> here, and the right solution is to change the check for exposing the
>>> property to account for these LUTs being available per-plane with mcm.
>>>
>>> (what is mcm btw...? lots of acronyms and stuff moving around in hw hehe)
>>
>> yes, shaper, 3dlut, blend_lut don't seem DPP caps anymore. MCM looks
>> like a component of MPC, so I think we need new mpc.color caps to
>> describe them properly (?)
>>
>> I also didn't find in the Linux/AMD glossary or code comment that
>> describe what MCM is...
>>
>>>
>>> What's a good way for us to check for that? Seems like the caps don't help
>>> much there. We could check for the literal function ptr I guess...?
>>>
>>> What are your thoughts, Harry and Melissa?
>>
> 
> I wonder if it makes sense to add an mcm cap to mpc_color_caps. Will need to
> chat with some people about that.
> 

I dug through the code a bit and talked with our resident expert. It looks
like all the programming for in_shaper_func, lut_3d_func, and blend_tf should
still work and assume a fixed pre-blending mcm, which is what we want.

Caps don't really reflect MCM very well yet. We could either add an mcm
flag to mpc_color_caps or simply check that DCN is 3.2 or newer:
	amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 2, 0)

Harry

> Harry
> 
>> yeah, AFAIK color caps values are manually set and may contain
>> misleading information. I'm unsure that using function ptr would solve
>> the issue of having undocumented caps introduced to the color pipeline,
>> such as MCM, but your suggestion seems more reliable.
>>
>> Anyway, the timing where the color pipeline was merged didn't help, but
>> if new caps and functions are not documented and the DM handles are not
>> updated accordingly, we will have the same issue in the future. 
>> For example, I see two new ptrs were introduced and implemented here:
>> - https://gitlab.freedesktop.org/agd5f/linux/-/commit/a820190204aef
>> - https://gitlab.freedesktop.org/agd5f/linux/-/commit/90f33674a0756
>> and we would need to update the DM color mgmt anyway to check these
>> new/unknown functions.
>>
>> Seems okay if we check program_1dlut instead of ogam_ram caps, but what
>> should we do for dpp/mpc shaper+3d lut in set_mcm_luts? I mean, should
>> we enable plane or CRTC shaper+3dlut on DM? x_X
>>
>> Anyway, thanks for all these findings!
>>
>> I would like to hear more from AMD too.
>>
>> Melissa
>>
>>>
>>> - Joshie 🐸✨
>>>
>>>>
>>>>>
>>>>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>>>>>
>>>>> Cc: Harry Wentland <harry.wentland@amd.com>
>>>>> Cc: Xaver Hugl <xaver.hugl@gmail.com>
>>>>> Cc: Melissa Wen <mwen@igalia.com>
>>>>> Cc: Ethan Lee <flibitijibibo@gmail.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c  | 2 +-
>>>>>   drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c  | 2 +-
>>>>>   .../gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c    | 2 +-
>>>>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
>>>>> index 9aa39bd25be9..94f5d2b5aadf 100644
>>>>> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
>>>>> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
>>>>> @@ -2182,7 +2182,7 @@ static bool dcn32_resource_construct(
>>>>>   	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
>>>>>   	dc->caps.color.dpp.hw_3d_lut = 1;
>>>>> -	dc->caps.color.dpp.ogam_ram = 0;  // no OGAM in DPP since DCN1
>>>>> +	dc->caps.color.dpp.ogam_ram = 1;
>>>>>   	// no OGAM ROM on DCN2 and later ASICs
>>>>>   	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
>>>>>   	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
>>>>> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
>>>>> index 25ac450944e7..708d63cc3f7f 100644
>>>>> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
>>>>> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
>>>>> @@ -1861,7 +1861,7 @@ static bool dcn35_resource_construct(
>>>>>   	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
>>>>>   	dc->caps.color.dpp.hw_3d_lut = 1;
>>>>> -	dc->caps.color.dpp.ogam_ram = 0;  // no OGAM in DPP since DCN1
>>>>> +	dc->caps.color.dpp.ogam_ram = 1;
>>>>>   	// no OGAM ROM on DCN301
>>>>>   	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
>>>>>   	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
>>>>> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
>>>>> index 8a57adb27264..053e8ec6d1ef 100644
>>>>> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
>>>>> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
>>>>> @@ -1841,7 +1841,7 @@ static bool dcn351_resource_construct(
>>>>>   	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
>>>>>   	dc->caps.color.dpp.hw_3d_lut = 1;
>>>>> -	dc->caps.color.dpp.ogam_ram = 0;  // no OGAM in DPP since DCN1
>>>>> +	dc->caps.color.dpp.ogam_ram = 1;
>>>>>   	// no OGAM ROM on DCN301
>>>>>   	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
>>>>>   	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
>>>>> -- 
>>>>> 2.44.0
>>>>>

