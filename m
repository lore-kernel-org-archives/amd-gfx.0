Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8584BC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 05:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D8B710F141;
	Wed, 27 Apr 2022 05:55:00 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7461310F141
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 05:54:58 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id g6so1276749ejw.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 22:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=eTfT8gpfjUuP9fzyKdPzHDNYfyn3NfjRnDxTqZWP5Hw=;
 b=cXxk83edMwf9NkBJlBgWXmoRk+LrI0vM10u5vjXDNte7iWRZxyEBesPUuMo9MphHED
 8/uj4KC69JPtEfVwjIlr+gI1vNZNZw7Fp/8cb9zHLwb6In30NPTC7BwRosFwoGOLCZEs
 lE5g4H3RecABHbatEE870hqD8PKP1s7ijv5O2QnHbngjSQYxCC29MyYKSPjRdIwACKog
 F4qa1DeMXwIzb6VylVbYtJZSkzrMJASf5cu18f0xkMAh2XTheBia/ZMxAKY7hrMFYpPe
 SnBuJeXSNhCs5ushUU6Az6fiumoVN56UByzb8dmA6c+wYz0IfMPoH/Jc1IcrDT1qIy01
 UCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=eTfT8gpfjUuP9fzyKdPzHDNYfyn3NfjRnDxTqZWP5Hw=;
 b=FewMHdEyyzl/ttoJhXm5YQ0nIsK6L7aoxRvweJPzJQzexWQchrDysgS5nkDplVSuJG
 pA+ZLIvM+FNhvlDJTZgCiLv5wmP5vfi12Yaz+xWAQDy+IOBw/9LS8Uu0nnIU+6XKXY5k
 GljhjfF2pJ7E72phmWSG7OefofAfl+rydwiIB874vx3KZuglAjor8MDkYbhQ6AEAhN7r
 IALkm6miObkzAtxf220CjYR7zqznkXIEA+mUWcVFhMZ9spjFqyZ2gBCRuhz1pNOOcJPB
 VXAZWmX/3PZQC0QPojrjLZVaS5cJPHy0eXJ+Tdeip7cBcWP6+5sPW0m9R34guaH47YXj
 ly4Q==
X-Gm-Message-State: AOAM532fUhXgiRskgalxsw48BkqhtKt7Tkp1uEbmopBalxqsOll3rAfu
 cwgHg7BWpj88hqTWsHMOkPA=
X-Google-Smtp-Source: ABdhPJwevEB3jvylFzu+roC7woThlRkohYfV/N3l3fz7m0Xr5C546P0zStHJNOSUZp+WxOV58eTd5w==
X-Received: by 2002:a17:907:900a:b0:6f3:8e8f:4236 with SMTP id
 ay10-20020a170907900a00b006f38e8f4236mr14575508ejc.390.1651038897023; 
 Tue, 26 Apr 2022 22:54:57 -0700 (PDT)
Received: from [192.168.178.21] (p57b0b9e1.dip0.t-ipconnect.de.
 [87.176.185.225]) by smtp.gmail.com with ESMTPSA id
 z14-20020a170906944e00b006f38c33b6e3sm4125607ejx.68.2022.04.26.22.54.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Apr 2022 22:54:55 -0700 (PDT)
Message-ID: <bc1a0ce5-e505-4eb8-536b-5b4fb0bf4db7@gmail.com>
Date: Wed, 27 Apr 2022 07:54:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/5] Add new SoC21 infrastructure
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220426185255.3039590-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220426185255.3039590-1-alexander.deucher@amd.com>
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

Am 26.04.22 um 20:52 schrieb Alex Deucher:
> This adds GPU SoC infrastructure for asics which
> use the soc21 design.  The first two patches are
> register headers which are too big for the mailing
> list so I have omitted them.

We really have to find a way to better compress those.

Anyway series is Acked-by: Christian König <christian.koenig@amd.com>

>
> Hawking Zhang (3):
>    drm/amdgpu: add mp v13_0_0 ip headers v7
>    drm/amdgpu: add gc v11_0_0 ip headers v11
>    drm/amdgpu: add nbio callback to query rom offset
>
> Likun Gao (1):
>    drm/amdgpu: add new write field for soc21
>
> Stanley.Yang (1):
>    drm/amdgpu: add soc21 common ip block v2
>
>   drivers/gpu/drm/amd/amdgpu/Makefile           |     2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      |    13 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h      |     1 +
>   drivers/gpu/drm/amd/amdgpu/soc15_common.h     |     8 +
>   drivers/gpu/drm/amd/amdgpu/soc21.c            |   620 +
>   drivers/gpu/drm/amd/amdgpu/soc21.h            |    30 +
>   .../include/asic_reg/gc/gc_11_0_0_default.h   |  6114 +++
>   .../include/asic_reg/gc/gc_11_0_0_offset.h    | 11670 +++++
>   .../include/asic_reg/gc/gc_11_0_0_sh_mask.h   | 41635 ++++++++++++++++
>   .../include/asic_reg/mp/mp_13_0_0_offset.h    |   461 +
>   .../include/asic_reg/mp/mp_13_0_0_sh_mask.h   |   682 +
>   11 files changed, 61233 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/soc21.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/soc21.h
>   create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_default.h
>   create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
>   create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_sh_mask.h
>   create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_0_offset.h
>   create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_0_sh_mask.h
>

