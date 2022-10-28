Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF78FA3740
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 08:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC3A510E13F;
	Mon, 31 Oct 2022 08:14:38 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 899F510E84E
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Oct 2022 15:28:06 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id z14so7030694wrn.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Oct 2022 08:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6SejV+lvrszfH7A+FwQaeAvHFHP9xBrTzTJwTXgzIXY=;
 b=UT0TtMfnYcM289g5Ylp5Rg1tVVsB8jbNMc3Mmb1eItbGw5+YKQkgWcJh0MS9RLVVee
 4kTLP8qDqXeBBZfUbrefLKNCVNpXiRFAXBaYWvZmsWYUtWtY2GpEXuNY7f23MAG5kgq2
 FS38MFfTgB2+ci21OkYzeRoKK5/2zS+Zy2wEKoJNuXahYsFB+xTYJ1EdNByu8byOD6DK
 Ma7oCOzkFOuMaZGpTKxuz8FIrMEMQk5+sgxnanViH36r8No6NKiDzHdjqNhg+P8W30de
 6uJhKRf24+LZNdS1ANCkMoVey6fLdaZDTrDDyPHn7szUEcKTStluxDkeVuSiapDNmx5W
 jGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6SejV+lvrszfH7A+FwQaeAvHFHP9xBrTzTJwTXgzIXY=;
 b=W0gQw89j/h36b+jdGPQ+r0WZNIAN2dSX9uWiq8dv3L2AgHTIuaPfyCDUw+fNJa3q/F
 tyCUjWiaiK3jMRr7YLbEr+hLm2oWSOKDuC+zWq7vZE8H56jJot29KNvC1v31KHtl4yRp
 3F/WXzt1cFRJ8KFaJ1dqkOIskvgUyo+15UaJyCCRo9Q8sSk4xhLJhvu3PgGbuebHxCFL
 ihAHePknzkTyEl3sinFya2/EPxhEHqw6I47opiaV9bnkJ9vITF71lhuLv9K6gc9bR5Jo
 IZQWQTKxwpb7gUx0XDPBDYLMtOCpwat+sdR41Jjima8schDT42j6bCxgTdNnmsYEhQlS
 mTFg==
X-Gm-Message-State: ACrzQf2ajaMrmRUjcJYs+wGXGwtwNnTYWGWd/kl8Y0Y02sp4E49313Ui
 XeqCg/L098LKHZU47xiPEvw=
X-Google-Smtp-Source: AMsMyM6lERUYIVyXJtmoRASCZBLuEiUrcxgYTuHt5G9axNcdNlxk05TWxES/ITROpvAaJjUAX6+XaA==
X-Received: by 2002:a5d:684a:0:b0:236:7930:a3e9 with SMTP id
 o10-20020a5d684a000000b002367930a3e9mr15233783wrw.27.1666970884945; 
 Fri, 28 Oct 2022 08:28:04 -0700 (PDT)
Received: from ?IPV6:2a02:908:4f6:d280::9a6? ([2a02:908:4f6:d280::9a6])
 by smtp.gmail.com with ESMTPSA id
 he11-20020a05600c540b00b003c6c5a5a651sm4481257wmb.28.2022.10.28.08.28.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Oct 2022 08:28:04 -0700 (PDT)
Message-ID: <dfc62a96-1953-27a3-3f8a-b7bab03f69aa@gmail.com>
Date: Fri, 28 Oct 2022 17:28:03 +0200
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
