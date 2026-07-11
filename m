Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A6DC43458
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jul 2026 11:07:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8660D10E325;
	Sat, 11 Jul 2026 11:07:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Uk531Kpq";
	dkim-atps=neutral
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A982110E325
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jul 2026 11:07:52 +0000 (UTC)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-8eff5ce3b95so14360556d6.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jul 2026 04:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783768071; x=1784372871; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=E4AaajT6iyDTns6M8VOXDQETqusoAERSyLGW8UHedwo=;
 b=Uk531Kpqs1Pc9v1b2hhx55+lKMqxbhOzG6yOyFevRaiNZbGWjm0bClzUzUm7IOxq8Q
 fO807mPqJIph6nY2Ur0jI2lmvcdpwADIiWeDCE0fPNWGtmHePDIud4JiYyZOeMsljoIp
 oJFkCBogY6ospYNQT8rDgDg6uf9AFEump20fIviGsdoKkov95ZNwzgb1wNDVxF+p8Nzs
 d+bp0qtA6O8Y9BNs/GehctU4XySc/aLUoOjsZoYqXgyXy/Ac9e7HFea0u0NAei6+olSG
 BrJ2Pi/Otw8tK6PqfulcNn9kB6HdYOt6tH8s1crku62wV3EqWkWa0ej2vPLkNavq8y2H
 wXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783768071; x=1784372871;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E4AaajT6iyDTns6M8VOXDQETqusoAERSyLGW8UHedwo=;
 b=XAp/MrmbvBhT/OIB1Ds0Z5n4PT7VynB5EBVA2tlkczJQ7v0VG5soazLVTBWyJ+5yjo
 UzNj76YBqYCfnTOoI5piQHvkiz93fqqnyYWy6D1pVDJ7cZsJynfCZ0SKRUGAt+p9OaRN
 wvxZDB7ApBcUJzOLKaMcmGvBHYSPn8p0AhHzygAUDkNRBS9QV6v6PqXEB3PiZPvEcN+I
 +R1l9FmPFq9sd6P8afumlM2xVNEJrjAYqAy42XbEP74Lcd8KcLJR7l6medPI2BRnnF5T
 eYCGye7+5jgxjyfbbm53+Hbjyy9TMwc5XSBsIRsPW+F/oW8b2QqYI0rCJHzR7/J6pX+u
 c69g==
X-Gm-Message-State: AOJu0YzTYhLyUMECJ4wrj2h+3dkVHCtqubnXQBNDdNp6rmPlKCL3none
 4qkBACIKs+v4fZzcIkvsbfC11PTbn0d579v+u+BGjINDo5Ppnhhjtd6A
X-Gm-Gg: AfdE7ckYVBEp2srUf+7N0TdEWcuESLwJnlCzNF6E9xBG4QLnZmfvNmW2e0Fgpbia1tP
 Tf0jNhQ0BKgNLcM8wvN5KkkQXT1TrVjyhyT752voVhL7L2mwvF6V4uP0r7NpeBbKCPGdrBpzUxb
 vQFLjfi7E1d5DrPFnALTzOruct5sErls7dO/7E+3JxAQX3lpYRFxfWq1AIOjUYVX0GBknuCg7/J
 MZjLAsIVnBbEsG56YWJfxfp23VO0+YmBgxIDRF2fz2adXVxZbNMsj1rCfqlWDZ5jFhZN8kKnOXY
 FHWldbHyYtMfWXfxSfyPXPqzG9kKafliIyl8QPD4R0hzh8JPdKbzLK1kwkAQ43f4HnqyIhJumhl
 uTQGy3fcrrucNIhkYXFY+xuSkZPAfHA8cwDnl4CvaDzDcW0S5ttCMoFRRKgzY06dREEF4G4a1xG
 /sJ6A3lHIFKaALQliSxk3p
X-Received: by 2002:a05:620a:2624:b0:92e:e7e0:ea45 with SMTP id
 af79cd13be357-92ef2bcc657mr286093785a.47.1783768071419; 
 Sat, 11 Jul 2026 04:07:51 -0700 (PDT)
Received: from [192.168.1.100] ([32.219.225.223])
 by smtp.googlemail.com with ESMTPSA id
 af79cd13be357-92ee5d5fc4dsm434752185a.40.2026.07.11.04.07.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Jul 2026 04:07:50 -0700 (PDT)
Message-ID: <bc07a078-3797-4e36-aac5-988ba1684d9a@gmail.com>
Date: Sat, 11 Jul 2026 07:07:49 -0400
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
 <6135675c-9e65-4bfb-9b8d-0645187d6a82@gmail.com>
 <DM4PR12MB5748EB8BE771E9C1A9DBAB108EFD2@DM4PR12MB5748.namprd12.prod.outlook.com>
Content-Language: en-US
From: John Olender <john.olender@gmail.com>
In-Reply-To: <DM4PR12MB5748EB8BE771E9C1A9DBAB108EFD2@DM4PR12MB5748.namprd12.prod.outlook.com>
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

On 7/10/26 11:41 AM, Kamal, Asad wrote:
> AMD General
> 
> Hi @John Olender,
> 
> You are right — ctx->bios_size is available in struct atom_context so the check is straightforward to add in amdgpu_atom_parse_data_header(). If that validation lands, soft_pp_table_size will be bounded at parse time, making the bios_end check in pp_entries_max() redundant for the VBIOS path.
> 
> That would be the cleaner two-step solution:
> 
> 1) Add usStructureSize bounds check in amdgpu_atom_parse_data_header() — benefits all ATOM data tables
> 2) Remove the bios_end check from pp_entries_max() — now safe since parse-time validation guarantees pp_end ≤ bios_end
> 
> However, that is a change to the core ATOM parser touching all data table callers — it needs its own patch and review. If you want to send that patch, we can then simplify pp_entries_max() accordingly.
> 
> In the meantime, I will send a follow-up patch that conditions the bios_end check on !hardcode_pp_table to fix the custom PP table regression while keeping Alex's VBIOS protection in place.
> 
> Thanks
> Asad

Sounds good.

Thanks,
John

> 
> -----Original Message-----
> From: John Olender <john.olender@gmail.com>
> Sent: Thursday, July 9, 2026 7:09 PM
> To: Kamal, Asad <Asad.Kamal@amd.com>; Alex Deucher <alexdeucher@gmail.com>
> Cc: amd-gfx@lists.freedesktop.org; Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Subject: Re: [PATCH] drm/amd/pm: Remove vbios bounds check from pp_entries_max()
> 
> On 7/9/26 8:19 AM, Kamal, Asad wrote:
>> AMD General
>>
>> Hi @John Olender,
>>
>> amdgpu_atom_parse_data_header() does not validate usStructureSize against the BIOS boundary — it reads the value directly from the BIOS bytes without any bounds check:
>>
>> if (size)
>>     *size = CU16(idx);   /* raw BIOS read, no validation */
>> So soft_pp_table_size is whatever the VBIOS claims and cannot be trusted for the VBIOS path.
>>
> 
> Just before this assignment is where I'm suggesting the parsed table ends be sanity checked against the vbios size.  A table whose end blatantly overflows the vbios would then be rejected early.
> 
> This would avoid redundant checks in the inline pp_entries_max().
> 
> Thanks,
> John
> 
>> Regarding other ATOM tables — the PP table is unique in that the host driver parses its sub-tables entry-by-entry, using ucNumEntries from the BIOS to drive kzalloc() sizes and loop bounds. That is the direct exploit path this series addresses. Most other ATOM tables are either passed raw to firmware, read as a fixed-size struct, or executed as ATOM scripts — none use a BIOS-supplied count to allocate kernel memory in a loop, so an inflated usStructureSize is harmless for them.
>>
>> The bios_end check in pp_entries_max() is still needed for the VBIOS path and the !hardcode_pp_table condition correctly gates it.
>>
>> Thanks & Regards
>> Asad
>>
>> -----Original Message-----
>> From: John Olender <john.olender@gmail.com>
>> Sent: Thursday, July 9, 2026 4:09 PM
>> To: Kamal, Asad <Asad.Kamal@amd.com>; Alex Deucher
>> <alexdeucher@gmail.com>
>> Cc: amd-gfx@lists.freedesktop.org; Feng, Kenneth
>> <Kenneth.Feng@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang,
>> Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin)
>> <KevinYang.Wang@amd.com>
>> Subject: Re: [PATCH] drm/amd/pm: Remove vbios bounds check from
>> pp_entries_max()
>>
>> On 7/9/26 5:57 AM, Kamal, Asad wrote:
>>> AMD General
>>>
>>> Hi @John Olender,
>>>
>>> Good catch. However,  as Alex points out, removing the check entirely drops protection for VBIOS-sourced tables.
>>>
>>> Instead of removing the check, could you condition it on hardcode_pp_table? When it is NULL we are on the VBIOS path and the bios_end check should stay. When it is non-NULL a custom table was uploaded via sysfs and the check can be skipped — soft_pp_table_size is already set to the kernel-supplied upload size.
>>>
>>> if (!hwmgr->hardcode_pp_table) {
>>>         const char *bios_end = (const char *)adev->bios + adev->bios_size;
>>>         if (pp_end > bios_end)
>>>                 return 0;
>>> }
>>>
>>> This fixes your regression while keeping Alex's concern addressed. Please let me know if it ok with you.
>>>
>>> Thanks & Regards
>>> Asad
>>
>> Hmm.
>>
>> Checking for vbios overflow when a table header is parsed should allow
>> pp_entries_max() to implicitly detect vbios overflow for the vbios-provided pp_table.
>>
>> Is there a reason all atom tables are not sanity checked in this way?
>> It seems odd that the pp_table header isn't trusted while the rest of the table headers are.
>>
>> Thanks,
>> John
>>
>>> -----Original Message-----
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>> Alex Deucher
>>> Sent: Wednesday, July 8, 2026 10:08 PM
>>> To: John Olender <john.olender@gmail.com>
>>> Cc: amd-gfx@lists.freedesktop.org; Feng, Kenneth
>>> <Kenneth.Feng@amd.com>; Deucher, Alexander
>>> <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Lazar,
>>> Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;
>>> Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
>>> Subject: Re: [PATCH] drm/amd/pm: Remove vbios bounds check from
>>> pp_entries_max()
>>>
>>> On Sat, Jul 4, 2026 at 6:19 AM John Olender <john.olender@gmail.com> wrote:
>>>>
>>>> The soft_pp_table is not contained within the vbios when using a
>>>> pp_table override since commit 3cfe433630508 ("drm/amd/pm: Use
>>>> uploaded size for legacy custom PPTable").
>>>>
>>>> Fixes: e30b3e3ab51ad ("drm/amdgpu/pm: add pp_entries_max() helper")
>>>> Signed-off-by: John Olender <john.olender@gmail.com>
>>>
>>> Removing this will effectively remove the bounds check from tables read from the bios.  I don't think we want to do that.
>>>
>>> Alex
>>>
>>>> ---
>>>>  drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h | 4 ----
>>>>  1 file changed, 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
>>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
>>>> index 7ebc1344023ff..19023a850e882 100644
>>>> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
>>>> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
>>>> @@ -833,14 +833,10 @@ static inline uint32_t pp_entries_max(const struct pp_hwmgr *hwmgr,
>>>>                                       const void *sub_table,
>>>>                                       size_t hdr_size, size_t
>>>> rec_size)  {
>>>> -       struct amdgpu_device *adev = (struct amdgpu_device *)hwmgr->adev;
>>>> -       const char *bios_end = (const char *)adev->bios + adev->bios_size;
>>>>         const char *pp_end   = (const char *)hwmgr->soft_pp_table
>>>>                                + hwmgr->soft_pp_table_size;
>>>>         const char *entries  = (const char *)sub_table + hdr_size;
>>>>
>>>> -       if (pp_end > bios_end)
>>>> -               return 0;
>>>>         if (!rec_size || entries >= pp_end)
>>>>                 return 0;
>>>>         return (uint32_t)((pp_end - entries) / rec_size);
>>>>
>>>> base-commit: e3cc8c108f9a91728f9ff6e24cbf3b41c58b8f8b
>>>> --
>>>> 2.47.3
>>>>
>>
> 

