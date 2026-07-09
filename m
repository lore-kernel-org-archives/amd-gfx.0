Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0120C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 10:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D71C10F4D8;
	Thu,  9 Jul 2026 10:39:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KxJgaOgN";
	dkim-atps=neutral
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4108210F4D1
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 10:39:01 +0000 (UTC)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-92e5d6f35c1so137432285a.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jul 2026 03:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783593540; x=1784198340; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ipv8nUTZ4lSFh5Z+iy3nm8QjWynaDMWNF/DB7hYgx3Q=;
 b=KxJgaOgNF5FYA9xdSrqcIEmH6hfiL5bttdZ3dHW0DVQvwquqrReUGx1+gTsOuScjZ5
 KkC6OKsra8YJdFSvzGIECRJZ+SUI2TAAnAOlcbGbjskTr3nMw7QWqx8kV4eW0pq3O7p+
 HMwPC9n75dHOKwrrmzOfgRdZgVA7UWA9V4eL0UZkw4LvjGPjW0bzQVtuzKiRTwDPOJfn
 kOxNxfMnuypfCUXygHQpK8b395LF+sDz7iYGlzI/OIdq8S4J1g+lkAlCzBPyYX3H3O6z
 IHEZdTDS/oU5aK64YBuR+t8AG6PPsxuoVHWgYZmF+KWfLWXlequ7PHvgYVoz63MLHzSs
 x9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783593540; x=1784198340;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ipv8nUTZ4lSFh5Z+iy3nm8QjWynaDMWNF/DB7hYgx3Q=;
 b=UV1LarU0fGkYp4k7UmNkcjmG9Wf0jwHqzWA2N0/j8JQ1JR0o7N4NVfn3b2SPtB2DNI
 9IIYMLP5p6IG2aNliWrOxNBxE5l7pzpqs3OG/Hp5xR48PStPNulJXsZfN7mBSLl9Qvsq
 BDU43n9MAhyZmQ6yucaVwg4o8IoFRsGwzqJrymZMRsmYgEuRVgCoaPNdxQn7Gih0yv2r
 EDh3E/CCuf2QPqRl6O/pxN+lfvGZezpaWmwapFOmgzu16D1Et15ZhfkxIzIAr7BABHVL
 +cCtVbdoCU+Ycx+OH29yoJESDzgcSgCat6Q6/zGMbukU8TJcKSdwRchX6zQZuNwwzD6M
 WbpA==
X-Gm-Message-State: AOJu0Ywu8CW4ARCqfA9FK9xEna9DfW/uJlc4cuOGpev2oXkbe08sddV9
 touH9BqqXxFB80bPgYl1FLLKIqUT4TWEJBfw6ZGvv1KFhyJxumaMLlQm
X-Gm-Gg: AfdE7ckB0H8/uc2I9sUPVKjV0EY1nUciDqr1Opk7GqqZLipXW8V+b1+YIaQ4CcYwrLb
 zSlr0pODVNXhX+gjY0iqxIixuMtafPgy4Zev6WNHtaa9Dm1df9zYDcXmp2qx1Dc5GHxo1oXwnES
 bhiWUe2p6ffeJAGhGiIAJCcpbNbasxt4CMyszYtUNC+Td3rJuRaxTRNESwledQjG4tUTN5Dq2NN
 A+1Z/2Kwu0oFO+T+fjq+IYszBb+2SdfAqduLUbTYzhmNCiJ79AgCPUcOaspbA2ilH3+3I4vM3WZ
 eB+AR5CCnEoS0RYU+XnEtXIfE1iYLbrNW3fj2faXzBEpcAXqxmHYI0jpNZ3XfasHPg4j7U8gyap
 7rJckaTjdP+ouyWs/aikuWxpMsMp/5BJPVDtItDc2SBXF6If8qH5pL4u7Hi6g7ZIgE4xGwuq4ZS
 uLeKInDf+u471aZdtx9dSN
X-Received: by 2002:a05:620a:179f:b0:92e:c118:18b4 with SMTP id
 af79cd13be357-92ecf944d35mr643274485a.83.1783593540071; 
 Thu, 09 Jul 2026 03:39:00 -0700 (PDT)
Received: from [192.168.1.100] ([32.219.225.223])
 by smtp.googlemail.com with ESMTPSA id
 af79cd13be357-92e90bc3a9csm1742856685a.21.2026.07.09.03.38.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 03:38:59 -0700 (PDT)
Message-ID: <c26d3312-0d50-4e2c-8516-7cee2b41bf83@gmail.com>
Date: Thu, 9 Jul 2026 06:38:58 -0400
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
Content-Language: en-US
From: John Olender <john.olender@gmail.com>
In-Reply-To: <DM4PR12MB5748B149AA0BB0C5CE58BD3B8EFE2@DM4PR12MB5748.namprd12.prod.outlook.com>
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

On 7/9/26 5:57 AM, Kamal, Asad wrote:
> AMD General
> 
> Hi @John Olender,
> 
> Good catch. However,  as Alex points out, removing the check entirely drops protection for VBIOS-sourced tables.
> 
> Instead of removing the check, could you condition it on hardcode_pp_table? When it is NULL we are on the VBIOS path and the bios_end check should stay. When it is non-NULL a custom table was uploaded via sysfs and the check can be skipped — soft_pp_table_size is already set to the kernel-supplied upload size.
> 
> if (!hwmgr->hardcode_pp_table) {
>         const char *bios_end = (const char *)adev->bios + adev->bios_size;
>         if (pp_end > bios_end)
>                 return 0;
> }
> 
> This fixes your regression while keeping Alex's concern addressed. Please let me know if it ok with you.
> 
> Thanks & Regards
> Asad

Hmm.

Checking for vbios overflow when a table header is parsed should allow
pp_entries_max() to implicitly detect vbios overflow for the
vbios-provided pp_table.

Is there a reason all atom tables are not sanity checked in this way?
It seems odd that the pp_table header isn't trusted while the rest of
the table headers are.

Thanks,
John

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
> Sent: Wednesday, July 8, 2026 10:08 PM
> To: John Olender <john.olender@gmail.com>
> Cc: amd-gfx@lists.freedesktop.org; Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Subject: Re: [PATCH] drm/amd/pm: Remove vbios bounds check from pp_entries_max()
> 
> On Sat, Jul 4, 2026 at 6:19 AM John Olender <john.olender@gmail.com> wrote:
>>
>> The soft_pp_table is not contained within the vbios when using a
>> pp_table override since commit 3cfe433630508 ("drm/amd/pm: Use
>> uploaded size for legacy custom PPTable").
>>
>> Fixes: e30b3e3ab51ad ("drm/amdgpu/pm: add pp_entries_max() helper")
>> Signed-off-by: John Olender <john.olender@gmail.com>
> 
> Removing this will effectively remove the bounds check from tables read from the bios.  I don't think we want to do that.
> 
> Alex
> 
>> ---
>>  drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
>> b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
>> index 7ebc1344023ff..19023a850e882 100644
>> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
>> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
>> @@ -833,14 +833,10 @@ static inline uint32_t pp_entries_max(const struct pp_hwmgr *hwmgr,
>>                                       const void *sub_table,
>>                                       size_t hdr_size, size_t
>> rec_size)  {
>> -       struct amdgpu_device *adev = (struct amdgpu_device *)hwmgr->adev;
>> -       const char *bios_end = (const char *)adev->bios + adev->bios_size;
>>         const char *pp_end   = (const char *)hwmgr->soft_pp_table
>>                                + hwmgr->soft_pp_table_size;
>>         const char *entries  = (const char *)sub_table + hdr_size;
>>
>> -       if (pp_end > bios_end)
>> -               return 0;
>>         if (!rec_size || entries >= pp_end)
>>                 return 0;
>>         return (uint32_t)((pp_end - entries) / rec_size);
>>
>> base-commit: e3cc8c108f9a91728f9ff6e24cbf3b41c58b8f8b
>> --
>> 2.47.3
>>

