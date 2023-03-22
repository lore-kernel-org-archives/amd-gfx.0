Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373AFC6FD1F
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Mar 2023 08:50:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4FEA10E3A8;
	Wed, 22 Mar 2023 08:50:38 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9728410E3A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 08:50:37 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id o12so69674497edb.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 01:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679475036;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E0I3F3bAS/B38H2locXjDEQLJMri9zr0AiDSLZC5StI=;
 b=RHagepI4/HuAeKddyswOIQISMya1MzdX2U4es58fXIYsasjgsyVSt3Cr4nGKCZgo0B
 fbUUNbgYOipFwbaECYgvt/KorXxEiwU+uNNagSNVV2Jik2mm58gG4jCbjB09T4tsQIWo
 il9vrtdkBWCwQPTtwUsEbSwaB8tZvYi3Xb80qTZ+FTGSDEMK7de+vybpKZUqOfKcA7HG
 4E5XqW/Cr+RO/LJ9w1/vogdYfD1PmCjHusUEMEv+n7ggFdBMvU5PuJiZIPA+DNv/eDBM
 uR3FV0SHEopfbolGLFaUjPYrINHy9ZwsLBwh+wQ3gdefon+kbGs/tBeLlLXGOEVLnWux
 eZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679475036;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E0I3F3bAS/B38H2locXjDEQLJMri9zr0AiDSLZC5StI=;
 b=YTfk1c1h6LVBYpcNr23TZLFKyl6fDGRLgmUermyYQhi6kcjqZt/CwLIPT4NmBYqJlo
 NoRAG7/j+ZuZfJYkz2oe2bBidSfDWa9+MEqlsjkegq+suBu/ZqvJHKOUzumc82KLfQgS
 i3UGK4Loz9iyyXOWcx6W9o7H0NkXuN69qLIcRIdyCRGTrc8WCTpniA3wmx2u7V0F642j
 P7B1sjyUJuTpfwY5Kouzw7FL95LAlVJ/3DpK3Ma97Ow8ZmBovm0FBnRiLZfrfTYOB1/F
 p4XOYlv4Xc0l++iEp6mnBYKPvKbIHK1NapHjG41rBAvj27/TgYaL/dqMnF1D+YBjkNoW
 mf1A==
X-Gm-Message-State: AO0yUKXGnGNHL1B6XHhAM+jkgyIGh2/zvvi9j1uEHoSa9VqQFLHCq2Si
 0JoAguIoGkO/rKUq70xob+4luy/ETlk=
X-Google-Smtp-Source: AK7set/NB1tWRnzysMJeoDiZKlAlObtC/MUb7hX8F5+3QIw1lfXxV1s9NMvv02V/b//bpPmoJFZOzg==
X-Received: by 2002:aa7:d610:0:b0:4fd:c5e:79b8 with SMTP id
 c16-20020aa7d610000000b004fd0c5e79b8mr6703631edr.32.1679475035942; 
 Wed, 22 Mar 2023 01:50:35 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:65e5:3673:f4af:8235?
 ([2a02:908:1256:79a0:65e5:3673:f4af:8235])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a50c385000000b004f9e6495f94sm7400151edf.50.2023.03.22.01.50.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Mar 2023 01:50:35 -0700 (PDT)
Message-ID: <b7d371d1-705f-e0ca-dcbc-c5478a203bd9@gmail.com>
Date: Wed, 22 Mar 2023 09:50:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 07/11] drm/amdgpu: add UAPI to query GFX shadow sizes
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>
References: <20230320173810.250835-1-alexander.deucher@amd.com>
 <20230320173810.250835-8-alexander.deucher@amd.com>
 <CAAxE2A7enKdyE_cBsCwCFZJjSWQZgOGZYCfUT5ShZN2DGa+Qbw@mail.gmail.com>
 <CADnq5_Or8QGhBwoB-rc8_gY2g3gaX-4Fvz8VaGKnaRXfJZMCNQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_Or8QGhBwoB-rc8_gY2g3gaX-4Fvz8VaGKnaRXfJZMCNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 21.03.23 um 20:53 schrieb Alex Deucher:
> On Mon, Mar 20, 2023 at 8:31 PM Marek Olšák <maraeo@gmail.com> wrote:
>> On Mon, Mar 20, 2023 at 1:38 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>>> Add UAPI to query the GFX shadow buffer requirements
>>> for preemption on GFX11.  UMDs need to specify the shadow
>>> areas for preemption.
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>   include/uapi/drm/amdgpu_drm.h | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>>> index 3d9474af6566..19a806145371 100644
>>> --- a/include/uapi/drm/amdgpu_drm.h
>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>> @@ -886,6 +886,7 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>>>          #define AMDGPU_INFO_VIDEO_CAPS_DECODE           0
>>>          /* Subquery id: Encode */
>>>          #define AMDGPU_INFO_VIDEO_CAPS_ENCODE           1
>>> +#define AMDGPU_INFO_CP_GFX_SHADOW_SIZE         0x22
>>
>> Can you put this into the device structure instead? Let's minimize the number of kernel queries as much as possible.
> I guess, but one nice thing about this is that we can use the query as
> a way to determine if the kernel supports this functionality or not.
> If not, the query returns -ENOTSUP.

Well if we put it at the end of the device info structure the sizes 
should be zero on older kernels/fw.

That will also work nicely.

Christian.

>
> Alex
>
>
>> Thanks,
>> Marek
>>

