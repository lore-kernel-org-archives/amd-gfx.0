Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E5FC43334
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jun 2022 07:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C495F10EF41;
	Wed, 15 Jun 2022 07:22:36 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7F6410EF41
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jun 2022 07:22:35 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id 25so14748944edw.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jun 2022 00:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=2iOjGFH+0VvWUV5ACDD2eDSjaDVmhP1jdbRzJuDOvYU=;
 b=OwcyS0hMXn9WSA7IYw3XHZkvtaF/oVjprd3XMpUoEYpqUWd36Mr+kwghmr1dL1DZXc
 9z/6WI7rUpSRnkc8YEt5+dKxUcbt+HxLZ+KvUWHICTdJ8/FnDqOYrmYyQSTxdwJl9U05
 eMj5PoWnen8WZlyG+Ai1cdpPSwlgMrFnrdO9V+DXjEiKeGx/uuMzhlfTGEVeNkx4+W26
 FbCknVOsLpavjcsZFSqRvXp+vg10ey1ySGLX1jNuf8Gno5sOFrQMC0CeP7igaK4x7XoH
 +gF74v4lfl1THHtFOEDEBCO16av9Kj0xOWeG6AuGCSwFKCQvc7SA0/3Yu2YdBiy5RyEC
 PfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=2iOjGFH+0VvWUV5ACDD2eDSjaDVmhP1jdbRzJuDOvYU=;
 b=ghx5yy2fe33jsh959luABPhobq+a25/CK3W7eawoNFqk83h83rGEBNc8ut9dvede+X
 wQ/H9s9s3wWHY5MBs1V/Ex0FY358J+JlrwS1ndeBznvDJrbwnSEqJWX9NbCr9hCtgGBx
 7UhLG4SOzIUHGbX9nALDph1fmyEWmjN5HysEbwmgoBoaO9bNrFRlVxW6lrKA1QU+ob+B
 zkE352C8RefMl+ja+/tvlNc8R5Y0uK9q1cbWdKRhS5giFF+bp/rnDps23Sy4LF/dacOy
 PZ11fCWr1NunNlarQaODmU7cXcC0uGoBa8OQ10XZhtkGoFwVUdQSzbxZsJxcHh5B7Los
 zS5A==
X-Gm-Message-State: AOAM533Qn0Uf6/1AGgtwBOrD5GnD+/t8trqL4451qCwwWrkSTvNxeT0h
 5OVDNLJE3DJUEe279+25M4g=
X-Google-Smtp-Source: ABdhPJxKaWyyM7xQhZ3GXgsjfFnUmZeZ/05xLBgE9NAKDEr3BbpolNRCNSmJOJcg0VEJFvJeNOSpuQ==
X-Received: by 2002:a05:6402:1cb5:b0:42d:ddda:7459 with SMTP id
 cz21-20020a0564021cb500b0042dddda7459mr11070828edb.16.1655277754070; 
 Wed, 15 Jun 2022 00:22:34 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea4d2.dip0.t-ipconnect.de.
 [91.14.164.210]) by smtp.gmail.com with ESMTPSA id
 f24-20020a170906085800b00711c7cca428sm5913599ejd.155.2022.06.15.00.22.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jun 2022 00:22:33 -0700 (PDT)
Message-ID: <ef3cc9a0-8b14-06db-9ae1-8ecc5fdf8849@gmail.com>
Date: Wed, 15 Jun 2022 09:22:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu/display: make FP handling in Makefiles
 consistent
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20220610154247.338073-1-alexander.deucher@amd.com>
 <CADnq5_NRFXCNFJ-rXnPgs=e-NbhtfL85zdOxkwLOAmnX0n10Jw@mail.gmail.com>
 <CADnq5_NwbEsm_h0G1iFDsQ8mXQcemGjctasfVNzE7x+0Yf60LQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_NwbEsm_h0G1iFDsQ8mXQcemGjctasfVNzE7x+0Yf60LQ@mail.gmail.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Well in this case Acked-by: Christian König <christian.koenig@amd.com>

Christian.

Am 14.06.22 um 15:30 schrieb Alex Deucher:
> Anyone?  This fixes the build on non-x86.
>
> Alex
>
> On Mon, Jun 13, 2022 at 9:52 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>> Ping?
>>
>> On Fri, Jun 10, 2022 at 11:43 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>>> Use the same pattern as the DML Makefile and while we are here
>>> add a missing x86 guard around the msse flags for DCN3.2.x.
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile | 3 +--
>>>   drivers/gpu/drm/amd/display/dc/dcn201/Makefile  | 1 -
>>>   drivers/gpu/drm/amd/display/dc/dcn30/Makefile   | 6 ++----
>>>   drivers/gpu/drm/amd/display/dc/dcn302/Makefile  | 8 +++++++-
>>>   drivers/gpu/drm/amd/display/dc/dcn32/Makefile   | 5 +++--
>>>   drivers/gpu/drm/amd/display/dc/dcn321/Makefile  | 5 +++--
>>>   6 files changed, 16 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
>>> index c935c10b5f4f..7b505e1e9308 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
>>> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
>>> @@ -180,7 +180,7 @@ CLK_MGR_DCN32 = dcn32_clk_mgr.o dcn32_clk_mgr_smu_msg.o
>>>   AMD_DAL_CLK_MGR_DCN32 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn32/,$(CLK_MGR_DCN32))
>>>
>>>   ifdef CONFIG_X86
>>> -CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn32/dcn32_clk_mgr.o := -msse
>>> +CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn32/dcn32_clk_mgr.o := -mhard-float -msse
>>>   endif
>>>
>>>   ifdef CONFIG_PPC64
>>> @@ -191,7 +191,6 @@ ifdef CONFIG_CC_IS_GCC
>>>   ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>>>   IS_OLD_GCC = 1
>>>   endif
>>> -CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn32/dcn32_clk_mgr.o := -mhard-float
>>>   endif
>>>
>>>   ifdef CONFIG_X86
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
>>> index f68038ceb1b1..96cbd4ccd344 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
>>> @@ -18,7 +18,6 @@ ifdef CONFIG_CC_IS_GCC
>>>   ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>>>   IS_OLD_GCC = 1
>>>   endif
>>> -CFLAGS_$(AMDDALPATH)/dc/dcn201/dcn201_resource.o += -mhard-float
>>>   endif
>>>
>>>   ifdef CONFIG_X86
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
>>> index dfd77b3cc84d..c20331eb62e0 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
>>> @@ -32,8 +32,8 @@ DCN30 = dcn30_init.o dcn30_hubbub.o dcn30_hubp.o dcn30_dpp.o dcn30_optc.o \
>>>
>>>
>>>   ifdef CONFIG_X86
>>> -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -msse
>>> -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -msse
>>> +CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -mhard-float -msse
>>> +CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mhard-float -msse
>>>   endif
>>>
>>>   ifdef CONFIG_PPC64
>>> @@ -45,8 +45,6 @@ ifdef CONFIG_CC_IS_GCC
>>>   ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>>>   IS_OLD_GCC = 1
>>>   endif
>>> -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o += -mhard-float
>>> -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o += -mhard-float
>>>   endif
>>>
>>>   ifdef CONFIG_X86
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
>>> index f9561d7f97a1..e4b69ad0dde5 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
>>> @@ -8,7 +8,7 @@
>>>   DCN3_02 = dcn302_init.o dcn302_hwseq.o dcn302_resource.o
>>>
>>>   ifdef CONFIG_X86
>>> -CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -msse
>>> +CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -mhard-float -msse
>>>   endif
>>>
>>>   ifdef CONFIG_PPC64
>>> @@ -16,6 +16,12 @@ CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -mhard-float -maltivec
>>>   endif
>>>
>>>   ifdef CONFIG_X86
>>> +ifdef CONFIG_CC_IS_GCC
>>> +ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>>> +IS_OLD_GCC = 1
>>> +endif
>>> +endif
>>> +
>>>   ifdef IS_OLD_GCC
>>>   # Stack alignment mismatch, proceed with caution.
>>>   # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
>>> index 3d09db3070f4..34f2e37b6704 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
>>> @@ -16,7 +16,7 @@ DCN32 = dcn32_resource.o dcn32_hubbub.o dcn32_hwseq.o dcn32_init.o \
>>>                  dcn32_mpc.o
>>>
>>>   ifdef CONFIG_X86
>>> -CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o := -msse
>>> +CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o := -mhard-float -msse
>>>   endif
>>>
>>>   ifdef CONFIG_PPC64
>>> @@ -27,9 +27,9 @@ ifdef CONFIG_CC_IS_GCC
>>>   ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>>>   IS_OLD_GCC = 1
>>>   endif
>>> -CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o += -mhard-float
>>>   endif
>>>
>>> +ifdef CONFIG_X86
>>>   ifdef IS_OLD_GCC
>>>   # Stack alignment mismatch, proceed with caution.
>>>   # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
>>> @@ -38,6 +38,7 @@ CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o += -mpreferred-stack-boundary=4
>>>   else
>>>   CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o += -msse2
>>>   endif
>>> +endif
>>>
>>>   AMD_DAL_DCN32 = $(addprefix $(AMDDALPATH)/dc/dcn32/,$(DCN32))
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/Makefile b/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
>>> index 5896ca303e39..e554fd6c16f2 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
>>> @@ -13,7 +13,7 @@
>>>   DCN321 = dcn321_resource.o dcn321_dio_link_encoder.o
>>>
>>>   ifdef CONFIG_X86
>>> -CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o := -msse
>>> +CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o := -mhard-float -msse
>>>   endif
>>>
>>>   ifdef CONFIG_PPC64
>>> @@ -24,9 +24,9 @@ ifdef CONFIG_CC_IS_GCC
>>>   ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>>>   IS_OLD_GCC = 1
>>>   endif
>>> -CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o += -mhard-float
>>>   endif
>>>
>>> +ifdef CONFIG_X86
>>>   ifdef IS_OLD_GCC
>>>   # Stack alignment mismatch, proceed with caution.
>>>   # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
>>> @@ -35,6 +35,7 @@ CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o += -mpreferred-stack-boundary=4
>>>   else
>>>   CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o += -msse2
>>>   endif
>>> +endif
>>>
>>>   AMD_DAL_DCN321 = $(addprefix $(AMDDALPATH)/dc/dcn321/,$(DCN321))
>>>
>>> --
>>> 2.35.3
>>>

