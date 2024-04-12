Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198C1C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 01:01:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6975910E649;
	Fri, 12 Apr 2024 01:01:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=froggi.es header.i=joshua@froggi.es header.b="skCAsg1N";
	dkim-atps=neutral
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B29810F41E
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 01:01:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1712883665; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=aGTi4VgkeJp20YGplwnAiwD7E3bMFOqsKM9euv3wGRuwnXhnXjCH9CJcBLdQkAnamXUnp3TLEVSa1u3CQoJKR/q6xoZyQuzy5xGa1Xs357/MdqcL2nmfI3XhPABZ/1JoNfqrUwiO2LpCxbXmR8cTbN3q8R8M8y4/ZisbhlpanFU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1712883665;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=LsmTqGHIwyZNuX3T5T9ZB8GSCUrsFtT4/M3Qldu3qzg=; 
 b=gzUl1KLY1Y6iVXJoEpfa9eK4PXnXEBz9AQSNsU4nKmKBbwF4gSuLRd6qdVnBFxDZ2H0QN+4Tt0L0XgVwGrSuQTEFaa2b/vBlD2fQ/S75FYN7/0+MVwiJVBGj01LUDUy2JHxSxy8BQUylhZS9rjQcsiMrb27+LRVGI4PptmWepHY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=froggi.es;
 spf=pass  smtp.mailfrom=joshua@froggi.es;
 dmarc=pass header.from=<joshua@froggi.es>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1712883665; 
 s=mail; d=froggi.es; i=joshua@froggi.es;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=LsmTqGHIwyZNuX3T5T9ZB8GSCUrsFtT4/M3Qldu3qzg=;
 b=skCAsg1Npkhb3pes3rgeslFxWkuMWpoV2w1E3jIHlHAetUPlcM4oLgRHh8dUfKPa
 B/xldPT+HcakCTfEt4IBrizQAEPPzjrsXbi4c3s+FJGsi9iPqqTH6fhh4pRQt2ccvVu
 q4uTtgIhb/6s7n0a3nMZOo8RVViowX/HA1ZjAOR8=
Received: by mx.zohomail.com with SMTPS id 171288366208516.212918945980732;
 Thu, 11 Apr 2024 18:01:02 -0700 (PDT)
Message-ID: <d607ffb8-aca6-44c8-ab0f-e7bf8d3bed0d@froggi.es>
Date: Fri, 12 Apr 2024 02:00:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Enable ogam_ram for dcn32+dcn35+dcn351
To: Melissa Wen <mwen@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Xaver Hugl <xaver.hugl@gmail.com>, Ethan Lee <flibitijibibo@gmail.com>
References: <20240410221336.34627-1-joshua@froggi.es>
 <nhr535ncnm6n5btn7o6kkmblppnywvvnni6i4y3v6fmiazbopz@v5wo7kqarrlv>
Content-Language: en-US
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <nhr535ncnm6n5btn7o6kkmblppnywvvnni6i4y3v6fmiazbopz@v5wo7kqarrlv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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



On 4/11/24 3:26 PM, Melissa Wen wrote:
> On 04/10, Joshua Ashton wrote:
>> The comment here states "no OGAM in DPP since DCN1", yet that is not
>> true.
>>
>> Testing on an RX 7900XTX (dcn32), it actually does exist in hardware and
>> works fine.
>> My best guess is the comment is confused with OGAM ROM for DPP, rather
>> than OGAM RAM.
>>
>> I did not test dcn35/351 as I do not have that hardware, but I assume
>> the same follows there given the seemingly erroneous comment.
>> Someone at AMD should check that before merging this commit.
> 
> hmm... I don't have any of these hw versions, but AFAIU if there is
> ogam/blend lut block in dcn32, the helper implementation for programming
> it properly (i.e. dpp_program_blnd_lut) is also missing here:
> - https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/display/dc/dpp/dcn32/dcn32_dpp.c#L125
> right? So, it's good if AMD people can check it too.
> 
> Melissa

Hmm, yes. But, see dcn32_set_mcm_luts, that seems to handle per-plane 
blend + shaper + 3D LUT state which is equivalent to what existed before?

Therefore, I think I am actually wrong with enabling the ogam_ram in DPP 
cap here, and the right solution is to change the check for exposing the 
property to account for these LUTs being available per-plane with mcm.

(what is mcm btw...? lots of acronyms and stuff moving around in hw hehe)

What's a good way for us to check for that? Seems like the caps don't 
help much there. We could check for the literal function ptr I guess...?

What are your thoughts, Harry and Melissa?

- Joshie 🐸✨

> 
>>
>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>>
>> Cc: Harry Wentland <harry.wentland@amd.com>
>> Cc: Xaver Hugl <xaver.hugl@gmail.com>
>> Cc: Melissa Wen <mwen@igalia.com>
>> Cc: Ethan Lee <flibitijibibo@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c  | 2 +-
>>   drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c  | 2 +-
>>   .../gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c    | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
>> index 9aa39bd25be9..94f5d2b5aadf 100644
>> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
>> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
>> @@ -2182,7 +2182,7 @@ static bool dcn32_resource_construct(
>>   	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
>>   
>>   	dc->caps.color.dpp.hw_3d_lut = 1;
>> -	dc->caps.color.dpp.ogam_ram = 0;  // no OGAM in DPP since DCN1
>> +	dc->caps.color.dpp.ogam_ram = 1;
>>   	// no OGAM ROM on DCN2 and later ASICs
>>   	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
>>   	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
>> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
>> index 25ac450944e7..708d63cc3f7f 100644
>> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
>> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
>> @@ -1861,7 +1861,7 @@ static bool dcn35_resource_construct(
>>   	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
>>   
>>   	dc->caps.color.dpp.hw_3d_lut = 1;
>> -	dc->caps.color.dpp.ogam_ram = 0;  // no OGAM in DPP since DCN1
>> +	dc->caps.color.dpp.ogam_ram = 1;
>>   	// no OGAM ROM on DCN301
>>   	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
>>   	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
>> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
>> index 8a57adb27264..053e8ec6d1ef 100644
>> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
>> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
>> @@ -1841,7 +1841,7 @@ static bool dcn351_resource_construct(
>>   	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
>>   
>>   	dc->caps.color.dpp.hw_3d_lut = 1;
>> -	dc->caps.color.dpp.ogam_ram = 0;  // no OGAM in DPP since DCN1
>> +	dc->caps.color.dpp.ogam_ram = 1;
>>   	// no OGAM ROM on DCN301
>>   	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
>>   	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
>> -- 
>> 2.44.0
>>
