Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B16AC38A02
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 08:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C10010E145;
	Mon, 31 Oct 2022 08:14:36 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEB1710E84E
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Oct 2022 15:26:35 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 l16-20020a05600c4f1000b003c6c0d2a445so4052051wmq.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Oct 2022 08:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nP7QJjRq4UzjK0j4jQ6EBtRCWHehfeRnjLM59ebJ0Ks=;
 b=OI+92Op1cbKagyqfE4sFMvFhsBE5ZuQgT05uMinnLD5Ix30h67M3CaQ4jDqwmeHJJ2
 GCGX1veFjjzqu6UqIIqENPdWlL0PIZVJs06KdLIGMvVQwNTyBQqpYI0IyA8qXnCzrFTQ
 hh4wtWsJEv0iRPzSRCAvtAgUEPrNxxphimWJyDGP809tHZbwLXyiDHeknL6RQ9ojGXnU
 5cbe03USDzJuFjPRLPPBsQ0AceWAYwOL84DWRj7LdGAVe/pemTvSuA56cHcvDu2ldJMG
 tkSolsBXRjXpxPM/Cb/uHSkJ9TnrQ/CgSM7P6nrpihVPBZCZVI+6DBuPz9FhGpSAlNvh
 R7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nP7QJjRq4UzjK0j4jQ6EBtRCWHehfeRnjLM59ebJ0Ks=;
 b=LFzEJ/+9uuUHWPaP3vDPyQ+uQMRqX0sRFky8jpyrzkQySGHsUlfPsLB3c0FCU4+lGr
 Dt6PHJMYibo1kFRjiNYxwrZCuFk4XeOnvGqsufON7bOWw79gqNZ+O5gtfK9rWjHHpWcx
 8vaBrFtIvsbM91JcIWG4t7/lkVepTs737d4rqJQgh85RwMClz2cJanOYCJnU+GtXwK79
 NNTdNFwP4HBAJVbGicAconLuTX+yIjxPKf8/TDhd4WVGnBGrXE6yXb8qAeTjyxL1C1nq
 ppzaZZXeZXYEOjE0Mgc39F1Sduy63kt+ZMHdE+FSCyyMzSxr7sFVfDQiMxd+SlnEaYU8
 UPNA==
X-Gm-Message-State: ACrzQf2cUPG+JGkQ3wM3MxMiehYllwXPhb6b4qEMzR2ZioRTiH/5aE/v
 X9LkGCwYiKjORsJsfQjc4yg=
X-Google-Smtp-Source: AMsMyM7DI3ogDVGCDAbMTKoxPnIED8u8XgpFnEGcrctSS5ye9bKM9Reo9XEwfx5VWOnLWHeJEpJLeA==
X-Received: by 2002:a7b:c404:0:b0:3b4:faca:cf50 with SMTP id
 k4-20020a7bc404000000b003b4facacf50mr9916742wmi.67.1666970794186; 
 Fri, 28 Oct 2022 08:26:34 -0700 (PDT)
Received: from ?IPV6:2a02:908:4f6:d280::9a6? ([2a02:908:4f6:d280::9a6])
 by smtp.gmail.com with ESMTPSA id
 i18-20020a1c5412000000b003cf54b77bfesm4259410wmb.28.2022.10.28.08.26.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Oct 2022 08:26:33 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------AZWKwcVkxQvAB3KwnM1duD8A"
Message-ID: <cc79ed1c-99b9-01be-a0f5-5a6b21cce300@gmail.com>
Date: Fri, 28 Oct 2022 17:26:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 1/1] drm/amd/display: add DCN support for ARM64
Content-Language: en-US
To: Nathan Chancellor <nathan@kernel.org>
References: <20221027195227.5312-1-hacc1225@gmail.com>
 <20221027195227.5312-2-hacc1225@gmail.com>
 <Y1vwk3J3HPGugBJO@dev-arch.thelio-3990X>
From: Ao Zhong <hacc1225@gmail.com>
In-Reply-To: <Y1vwk3J3HPGugBJO@dev-arch.thelio-3990X>
X-Mailman-Approved-At: Mon, 31 Oct 2022 08:14:28 +0000
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------AZWKwcVkxQvAB3KwnM1duD8A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 28.10.22 um 17:09 schrieb Nathan Chancellor:
> Additionally, I see the following errors with GCC 12.2.1 from Fedora
> when building allmodconfig. Seems like some $(dml_rcflags) might be
> missing.
>
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c: In function ‘dcn10_resource_construct_fp’:
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1313:52: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
>   1313 |                 dcn_soc->dram_clock_change_latency = 23;
>         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1317:45: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
>   1317 |                 dc->dcn_soc->urgent_latency = 3;
>         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1319:64: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
>   1319 |                 dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 41.60f;
>         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1329:64: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
>   1329 |                 dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 19.2f;
>         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1330:64: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
>   1330 |                 dc->dcn_soc->fabric_and_dram_bandwidth_vnom0p8 = 17.066f;
>         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1331:65: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
>   1331 |                 dc->dcn_soc->fabric_and_dram_bandwidth_vmid0p72 = 14.933f;
>         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1332:65: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
>   1332 |                 dc->dcn_soc->fabric_and_dram_bandwidth_vmin0p65 = 12.8f;
>         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1334:72: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
>   1334 |                         dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 20.80f;
>         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~
>   make[6]: *** [scripts/Makefile.build:250: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.o] Error 1
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c: In function ‘dcn32_populate_dml_pipes_from_context’:
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:1921:70: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
>   1921 |                 pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
>         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:1922:72: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
>   1922 |                 pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
>         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
>   make[6]: *** [scripts/Makefile.build:250: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.o] Error 1

Hi Nathan,

it seems like you haven't merged my patch to isolate the remaining FPU code.

Links: https://patchwork.freedesktop.org/patch/508813/
Links: https://patchwork.freedesktop.org/patch/508816/

Rodrigo says both patches have been applied, but I haven't seen them in the amd-staging-drm-next branch.

This error occurs because the remaining FPU code in dcn10_resource.c has not been isolated.

Ao

--------------AZWKwcVkxQvAB3KwnM1duD8A
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 28.10.22 um 17:09 schrieb Nathan Chancellor:<br>
    <blockquote type="cite"
      cite="mid:Y1vwk3J3HPGugBJO@dev-arch.thelio-3990X">
      <pre class="moz-quote-pre" wrap="">Additionally, I see the following errors with GCC 12.2.1 from Fedora
when building allmodconfig. Seems like some $(dml_rcflags) might be
missing.

  drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c: In function ‘dcn10_resource_construct_fp’:
  drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1313:52: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
  1313 |                 dcn_soc-&gt;dram_clock_change_latency = 23;
        |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
  drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1317:45: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
  1317 |                 dc-&gt;dcn_soc-&gt;urgent_latency = 3;
        |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
  drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1319:64: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
  1319 |                 dc-&gt;dcn_soc-&gt;fabric_and_dram_bandwidth_vmax0p9 = 41.60f;
        |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~
  drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1329:64: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
  1329 |                 dc-&gt;dcn_soc-&gt;fabric_and_dram_bandwidth_vmax0p9 = 19.2f;
        |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
  drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1330:64: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
  1330 |                 dc-&gt;dcn_soc-&gt;fabric_and_dram_bandwidth_vnom0p8 = 17.066f;
        |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~
  drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1331:65: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
  1331 |                 dc-&gt;dcn_soc-&gt;fabric_and_dram_bandwidth_vmid0p72 = 14.933f;
        |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~
  drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1332:65: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
  1332 |                 dc-&gt;dcn_soc-&gt;fabric_and_dram_bandwidth_vmin0p65 = 12.8f;
        |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
  drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1334:72: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
  1334 |                         dc-&gt;dcn_soc-&gt;fabric_and_dram_bandwidth_vmax0p9 = 20.80f;
        |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~
  make[6]: *** [scripts/Makefile.build:250: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.o] Error 1
  drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c: In function ‘dcn32_populate_dml_pipes_from_context’:
  drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:1921:70: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
  1921 |                 pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
        |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
  drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:1922:72: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
  1922 |                 pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
        |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
  make[6]: *** [scripts/Makefile.build:250: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.o] Error 1</pre>
    </blockquote>
    <p>Hi Nathan,</p>
    <p>it seems like you haven't merged my patch to <span class="HwtZe"
        lang="en"><span class="jCAhz ChMk0b"><span class="ryNqvb">isolate
            the remaining FPU code.</span></span></span></p>
    <p><span class="HwtZe" lang="en"><span class="jCAhz ChMk0b"><span
            class="ryNqvb">Links:
            <a class="moz-txt-link-freetext" href="https://patchwork.freedesktop.org/patch/508813/">https://patchwork.freedesktop.org/patch/508813/</a><br>
            Links: <a class="moz-txt-link-freetext" href="https://patchwork.freedesktop.org/patch/508816/">https://patchwork.freedesktop.org/patch/508816/</a></span></span></span></p>
    <p><span class="HwtZe" lang="en"><span class="jCAhz ChMk0b"><span
            class="ryNqvb">Rodrigo says both patches have been applied,
            but I haven't seen them in the amd-staging-drm-next branch.</span></span></span></p>
    <p><span class="HwtZe" lang="en"><span class="jCAhz ChMk0b"><span
            class="ryNqvb">This error occurs because the remaining FPU
            code in dcn10_resource.c has not been isolated.</span></span></span></p>
    <p><span class="HwtZe" lang="en"><span class="jCAhz ChMk0b"><span
            class="ryNqvb">Ao<br>
          </span></span></span></p>
    <p></p>
  </body>
</html>

--------------AZWKwcVkxQvAB3KwnM1duD8A--
