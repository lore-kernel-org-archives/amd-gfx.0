Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45ABBC43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 13:38:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D89FD10E6D7;
	Thu,  9 Jul 2026 13:38:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OLscckpr";
	dkim-atps=neutral
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32C2E10E6D7
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 13:38:33 +0000 (UTC)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-92e5d6f35c1so149495585a.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jul 2026 06:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783604312; x=1784209112; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cY+Cwx64dN8rgNGWsBXNTHATaNfDpSzQVoJ6jgXC8y4=;
 b=OLscckpr9CjLq+C/5cr/trdIxUehVtVBDdgPrSkSGay345W2f25ORgQxSOtv1DU5OW
 TZkeWxy1YIBnB9kJp/0S7QxdknvMUtXOhkDsyofV6pP5ghaB/lmvKjQefbl62+XnCksn
 bulfMxacofMJ0KPkWgeBmAFVms2rc/103iGJBLN7JLIdcDnKnJdkgdqb7TZv13y3KCX4
 Obr3UXnpVzAelpMiBi6udfzeOi4my6GLlu627YGkYi4K6mFi8QgaVgk2GpNrP3bZa4Cp
 pPmQbHIx1yWsQFy6DFjRb0nBpgQKAJ0sKWY0tdJcWMhWdcoIgKxJyPIF8KnGzqQitntB
 6m3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783604312; x=1784209112;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cY+Cwx64dN8rgNGWsBXNTHATaNfDpSzQVoJ6jgXC8y4=;
 b=ZZ0x5myToTUel7FvJJ0DPd/GQx3TXo6bz+AXkLZCecUbJqlQ2CmrI7S638sh+eRckY
 SWrZU4ieX0KRYqV7yRrVeb/VfBkPoGlibdUgGwqM+8c/cF9FDZ8qccf1Tvp9yY1vcvUE
 jp6AHZ9+CHe2feBVx1EHlDsdGoOe4yTNbiuKai/nAdx8gTKFR1pQYnw973Ql7snnw27X
 mA0OSxMWs6Rw10BTSOVQ+IPcHBIxR+b+BXKCY7q38c6ELJ7WndrW4pC9nJFNR1sClDnl
 XwXwhh0fHrxUZQ/cHKYn8Nf2p1nPTnTSQS1qGeNPLwf36RpL8urwJ/wvF31aQyRaX9/o
 henw==
X-Gm-Message-State: AOJu0Yxw1hokIpuY3cFz3AN5MxWe44XdXdyCcYioO8r5Z5YRvEGtstbT
 ZnN5nYfT+wXAhDLJ9eBPDD9AqX/vlyl/QRe+yL49l8vRW2n/SefP0t0O
X-Gm-Gg: AfdE7ckiO9rZjkizrdB6hDdeR6DaSWT+kaXle7MYKW2rGOGuv3zvCkE3FQLRlSV+1nR
 54zh2Etl0qCP32Cof6gzW3G8+ntuRHS2bKlrJv/+F+BEd+HpC1/k1c5LD4Bg/wAiDFUfNTer7RR
 1x+kcD0qgjl2oArvu6G0+xbsrjaGCNB8RD3PSI8uch6YolFIExGWRz+iZTYRGSD5ctfsaa1CLR2
 ZX8vPBwUaj3QdLYMaUZ7q/eX9Q7E8x/1mTNRmn3KAivoqdaA9lBbASbetWJJbSLqCAT874qpEo7
 fRdE8eW2owQpno9rQ/iWJvh+l9/MwyJnMnOiz81MVNwpFlaq0NfMWOdsxf4ECzOU9pIKvsaxncB
 sY22SfGYyMQGxz1CAG66oXU/9U/8J53vVnmvtm5c/fkEMg0vjJTohIzmkNUc6EC13fqFuanwSPQ
 vOh5p6CgANe8CFNrvmtvD1
X-Received: by 2002:a05:620a:6603:b0:915:abc4:b570 with SMTP id
 af79cd13be357-92ecf8d3e56mr813911985a.48.1783604311761; 
 Thu, 09 Jul 2026 06:38:31 -0700 (PDT)
Received: from [192.168.1.100] ([32.219.225.223])
 by smtp.googlemail.com with ESMTPSA id
 af79cd13be357-92ecff35229sm383946685a.36.2026.07.09.06.38.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 06:38:31 -0700 (PDT)
Message-ID: <6135675c-9e65-4bfb-9b8d-0645187d6a82@gmail.com>
Date: Thu, 9 Jul 2026 09:38:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Remove vbios bounds check from
 pp_entries_max()
To: "Kamal, Asad" <Asad.Kamal@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
References: <20260704101120.674980-1-john.olender@gmail.com>
 <CADnq5_ODf=T4VD9_RptQaEtJr5Zinsom8jW8GJL56GN6shvJsQ@mail.gmail.com>
 <DM4PR12MB5748B149AA0BB0C5CE58BD3B8EFE2@DM4PR12MB5748.namprd12.prod.outlook.com>
 <c26d3312-0d50-4e2c-8516-7cee2b41bf83@gmail.com>
 <DM4PR12MB5748979CE743162FA87C69EB8EFE2@DM4PR12MB5748.namprd12.prod.outlook.com>
Content-Language: en-US
From: John Olender <john.olender@gmail.com>
In-Reply-To: <DM4PR12MB5748979CE743162FA87C69EB8EFE2@DM4PR12MB5748.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 7/9/26 8:19 AM, Kamal, Asad wrote:
> AMD General
> 
> Hi @John Olender,
> 
> amdgpu_atom_parse_data_header() does not validate usStructureSize against the BIOS boundary — it reads the value directly from the BIOS bytes without any bounds check:
> 
> if (size)
>     *size = CU16(idx);   /* raw BIOS read, no validation */
> So soft_pp_table_size is whatever the VBIOS claims and cannot be trusted for the VBIOS path.
> 

Just before this assignment is where I'm suggesting the parsed table
ends be sanity checked against the vbios size.  A table whose end
blatantly overflows the vbios would then be rejected early.

This would avoid redundant checks in the inline pp_entries_max().

Thanks,
John

> Regarding other ATOM tables — the PP table is unique in that the host driver parses its sub-tables entry-by-entry, using ucNumEntries from the BIOS to drive kzalloc() sizes and loop bounds. That is the direct exploit path this series addresses. Most other ATOM tables are either passed raw to firmware, read as a fixed-size struct, or executed as ATOM scripts — none use a BIOS-supplied count to allocate kernel memory in a loop, so an inflated usStructureSize is harmless for them.
> 
> The bios_end check in pp_entries_max() is still needed for the VBIOS path and the !hardcode_pp_table condition correctly gates it.
> 
> Thanks & Regards
> Asad
> 
> -----Original Message-----
> From: John Olender <john.olender@gmail.com>
> Sent: Thursday, July 9, 2026 4:09 PM
> To: Kamal, Asad <Asad.Kamal@amd.com>; Alex Deucher <alexdeucher@gmail.com>
> Cc: amd-gfx@lists.freedesktop.org; Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Subject: Re: [PATCH] drm/amd/pm: Remove vbios bounds check from pp_entries_max()
> 
> On 7/9/26 5:57 AM, Kamal, Asad wrote:
>> AMD General
>>
>> Hi @John Olender,
>>
>> Good catch. However,  as Alex points out, removing the check entirely drops protection for VBIOS-sourced tables.
>>
>> Instead of removing the check, could you condition it on hardcode_pp_table? When it is NULL we are on the VBIOS path and the bios_end check should stay. When it is non-NULL a custom table was uploaded via sysfs and the check can be skipped — soft_pp_table_size is already set to the kernel-supplied upload size.
>>
>> if (!hwmgr->hardcode_pp_table) {
>>         const char *bios_end = (const char *)adev->bios + adev->bios_size;
>>         if (pp_end > bios_end)
>>                 return 0;
>> }
>>
>> This fixes your regression while keeping Alex's concern addressed. Please let me know if it ok with you.
>>
>> Thanks & Regards
>> Asad
> 
> Hmm.
> 
> Checking for vbios overflow when a table header is parsed should allow
> pp_entries_max() to implicitly detect vbios overflow for the vbios-provided pp_table.
> 
> Is there a reason all atom tables are not sanity checked in this way?
> It seems odd that the pp_table header isn't trusted while the rest of the table headers are.
> 
> Thanks,
> John
> 
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Alex Deucher
>> Sent: Wednesday, July 8, 2026 10:08 PM
>> To: John Olender <john.olender@gmail.com>
>> Cc: amd-gfx@lists.freedesktop.org; Feng, Kenneth
>> <Kenneth.Feng@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Lazar,
>> Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;
>> Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
>> Subject: Re: [PATCH] drm/amd/pm: Remove vbios bounds check from
>> pp_entries_max()
>>
>> On Sat, Jul 4, 2026 at 6:19 AM John Olender <john.olender@gmail.com> wrote:
>>>
>>> The soft_pp_table is not contained within the vbios when using a
>>> pp_table override since commit 3cfe433630508 ("drm/amd/pm: Use
>>> uploaded size for legacy custom PPTable").
>>>
>>> Fixes: e30b3e3ab51ad ("drm/amdgpu/pm: add pp_entries_max() helper")
>>> Signed-off-by: John Olender <john.olender@gmail.com>
>>
>> Removing this will effectively remove the bounds check from tables read from the bios.  I don't think we want to do that.
>>
>> Alex
>>
>>> ---
>>>  drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h | 4 ----
>>>  1 file changed, 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
>>> index 7ebc1344023ff..19023a850e882 100644
>>> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
>>> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
>>> @@ -833,14 +833,10 @@ static inline uint32_t pp_entries_max(const struct pp_hwmgr *hwmgr,
>>>                                       const void *sub_table,
>>>                                       size_t hdr_size, size_t
>>> rec_size)  {
>>> -       struct amdgpu_device *adev = (struct amdgpu_device *)hwmgr->adev;
>>> -       const char *bios_end = (const char *)adev->bios + adev->bios_size;
>>>         const char *pp_end   = (const char *)hwmgr->soft_pp_table
>>>                                + hwmgr->soft_pp_table_size;
>>>         const char *entries  = (const char *)sub_table + hdr_size;
>>>
>>> -       if (pp_end > bios_end)
>>> -               return 0;
>>>         if (!rec_size || entries >= pp_end)
>>>                 return 0;
>>>         return (uint32_t)((pp_end - entries) / rec_size);
>>>
>>> base-commit: e3cc8c108f9a91728f9ff6e24cbf3b41c58b8f8b
>>> --
>>> 2.47.3
>>>
> 

