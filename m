Return-Path: <SRS0=YYL8=OG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40099C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 00:24:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8D30610A6
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 00:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D8D30610A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=froggi.es
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 562C66EA86;
	Thu, 16 Sep 2021 00:24:01 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71AC56EA86
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Sep 2021 00:24:00 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id s24so3473992wmh.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Sep 2021 17:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=froggi.es; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=WoCEUrJEHIN1T0EzhrYcmcs+lUndLzGoPKSHGaIONMk=;
 b=GjNLwNMxb2G9M1bJGJ0DzYv4x5ZYCJvuANFnixDisOMGlSiDwAup0+QAYuktBLCnGE
 sOXzwGABw9H+ym3qM2ukdzdOb5uTTEEF0MMRKMU3tfn+lYPfyHVYqUnMebeNJwgXgNUJ
 /uvnHXwBAtHlmOyya6FzHQn6iSrWTAhxCgTX5GH646gjSH/jWsELaZvtFduC2c9PZD/z
 Mr8e+/B20Ku4ug+KWAtKr2LHkP4QB+ivoje3rv5GYkg8crXqLs6NggRUjx0z5taGiOug
 oPJh5xS+m8dy2NHsWo8HxHoXueDiQjQgBGDw030oGpnI56FtqWirSvLukZA9aoJ0KfdV
 TqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=WoCEUrJEHIN1T0EzhrYcmcs+lUndLzGoPKSHGaIONMk=;
 b=vnp4D8/R41Tpwr2d96btMqfpbviLLJtbffnR2iW9c0k7hP1BM2jH6xnd3mZzRtNq+O
 aTqHeHcaKXACw+qbv6Uq7tNEjmtbiqc/mfnT67O80ZfMYQ9lzU8i4HuakT32oceLpwN+
 IMu/Zw3TTwfdWjGOPAqDLlugt9lk7N61cKjq3BoQJp0TrKB3SQr5ggXhHHk9Yte9FtuD
 8XzE/FPXyDm+bR1x99i/rRsQuEfiJH50HnPz97Yy666/HF1Vt+2izWXEV2Q7JqyDekb0
 jDDKbBmcTZo0VSjBdW1r2faUwSetHT1hyS78gql5PLS/BGXOQch0ujaqDhbdFY/sPuvu
 6lpg==
X-Gm-Message-State: AOAM530dNByfKFSZ0ZcXICPe6aQ3pau101z57BXE+efVBv77CSLTGDuf
 Cu7hCF1inJ4JHYPJbbeK5FU2PIkcA9QZ5xBl5HI=
X-Google-Smtp-Source: ABdhPJzZk4D3i7NQndxPuxwIYdaPrYpzFPenmr2CMpeP6GxoIKSskT11YQhB2+S9f/bkKZCfRrOoKg==
X-Received: by 2002:a05:600c:4154:: with SMTP id
 h20mr7043330wmm.172.1631751838731; 
 Wed, 15 Sep 2021 17:23:58 -0700 (PDT)
Received: from [192.168.0.61]
 (cpc89720-darl9-2-0-cust754.11-2.cable.virginm.net. [86.2.110.243])
 by smtp.gmail.com with ESMTPSA id v185sm253746wme.15.2021.09.15.17.23.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Sep 2021 17:23:58 -0700 (PDT)
Message-ID: <4f77cc16-783c-3920-d666-431b7252641e@froggi.es>
Date: Thu, 16 Sep 2021 01:23:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 3/3] drm/amd/display: Add modifiers capable of DCC image
 stores for gfx10_3
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
References: <20210914235948.893422-1-joshua@froggi.es>
 <20210914235948.893422-3-joshua@froggi.es>
 <CAAxE2A4yR7aXPocAHdsKsyN-vVQFUKiX_7gyxD6-iG4mzHTs6A@mail.gmail.com>
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <CAAxE2A4yR7aXPocAHdsKsyN-vVQFUKiX_7gyxD6-iG4mzHTs6A@mail.gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/16/21 01:11, Marek Olšák wrote:
> Based on the discussions we had about displayable DCC internally, only 
> MAX_COMPRESSED_BLOCK = 64B with both DCC_INDEPENDENT_64B_BLOCKS and 
> DCC_INDEPENDENT_128B_BLOCKS is supported by DCN on RDNA 2.
> 
 From my testing:

It works fine when setting PRIMARY_SURFACE_DCC_IND_BLK to 2 
(hubp_ind_block_128b) with 128b blocks alone.

Previously, PRIMARY_SURFACE_DCC_IND_BLK would only ever be 1 or 0, and 
both of these values do not work for 128b.

This change has been tested with both Gamescope compositing and for Doom 
Eternal.

I have validated that the modifiers are in use in both of these 
scenarios and the register values were found and tested with

sudo umr -O bits -r vangogh.dcn301.mmHUBPREQ0_DCSURF_SURFACE_CONTROL

- Joshie 🐸✨


> Is there something new on the hardware side that I missed?
> 
> Marek
> 
> On Tue, Sep 14, 2021 at 7:59 PM Joshua Ashton <joshua@froggi.es 
> <mailto:joshua@froggi.es>> wrote:
> 
>     Some games, ie. Doom Eternal, present from compute following compute
>     post-fx and would benefit from having DCC image stores available.
> 
>     DCN on gfx10_3 doesn't need INDEPENDENT_128B_BLOCKS = 0 so we can expose
>     these modifiers capable of DCC image stores.
> 
>     Signed-off-by: Joshua Ashton <joshua@froggi.es
>     <mailto:joshua@froggi.es>>
>     Reviewed-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl
>     <mailto:bas@basnieuwenhuizen.nl>>
>     ---
>       .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 21 +++++++++++++++++++
>       1 file changed, 21 insertions(+)
> 
>     diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>     b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>     index 2a24e43623cb..a4e33a4336a0 100644
>     --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>     +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>     @@ -4817,6 +4817,16 @@ add_gfx10_3_modifiers(const struct
>     amdgpu_device *adev,
>                          AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
>                          AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,
>     AMD_FMT_MOD_DCC_BLOCK_64B));
> 
>     +       add_modifier(mods, size, capacity, AMD_FMT_MOD |
>     +                   AMD_FMT_MOD_SET(TILE,
>     AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
>     +                   AMD_FMT_MOD_SET(TILE_VERSION,
>     AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
>     +                   AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
>     +                   AMD_FMT_MOD_SET(PACKERS, pkrs) |
>     +                   AMD_FMT_MOD_SET(DCC, 1) |
>     +                   AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
>     +                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
>     +                   AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,
>     AMD_FMT_MOD_DCC_BLOCK_128B));
>     +
>              add_modifier(mods, size, capacity, AMD_FMT_MOD |
>                          AMD_FMT_MOD_SET(TILE,
>     AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
>                          AMD_FMT_MOD_SET(TILE_VERSION,
>     AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
>     @@ -4829,6 +4839,17 @@ add_gfx10_3_modifiers(const struct
>     amdgpu_device *adev,
>                          AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
>                          AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,
>     AMD_FMT_MOD_DCC_BLOCK_64B));
> 
>     +       add_modifier(mods, size, capacity, AMD_FMT_MOD |
>     +                   AMD_FMT_MOD_SET(TILE,
>     AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
>     +                   AMD_FMT_MOD_SET(TILE_VERSION,
>     AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
>     +                   AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
>     +                   AMD_FMT_MOD_SET(PACKERS, pkrs) |
>     +                   AMD_FMT_MOD_SET(DCC, 1) |
>     +                   AMD_FMT_MOD_SET(DCC_RETILE, 1) |
>     +                   AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
>     +                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
>     +                   AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,
>     AMD_FMT_MOD_DCC_BLOCK_128B));
>     +
>              add_modifier(mods, size, capacity, AMD_FMT_MOD |
>                          AMD_FMT_MOD_SET(TILE,
>     AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
>                          AMD_FMT_MOD_SET(TILE_VERSION,
>     AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
>     -- 
>     2.33.0
> 
