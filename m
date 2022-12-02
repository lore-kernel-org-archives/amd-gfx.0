Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EA3C4321E
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Dec 2022 12:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95B2C10E6EB;
	Fri,  2 Dec 2022 12:00:42 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03CBE10E6EB
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Dec 2022 12:00:38 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id gu23so11004244ejb.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Dec 2022 04:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=46alcYnUwWpLWLP3SjYYI0z8mk2pPrdjarlJLMhEr3o=;
 b=PjLY7IlBOURrZ5e9yHlnW3hTI8A6+HoXB93tkFqmUGEzy22zHmFfgZ2Eo7HV6OQwJu
 RLQZWG2UT5nFKJPw2SSDzxBHkQE3wWbgYbbqvazcz1XS0ExBQhNYOj8jNS1yuhrLSsG8
 Ol5Q3MW39F3iAA+VHw0jZCrdPTXlBSQX4LuUEX3HYt79aw94Au8rOZacl+j/EhySELBL
 AkQ5BHGXvi1pX8YFfXaLlyUwVCySkli3XgR2XJyHmJm2/a3ITWJhdy0hsZ3d1w2iuuZe
 I22wKr8A//khNGCZy1g0ndl3T94qnu4AObVHeTXIviquR/7qU/gIQrGjtZ6y+c1DE1Rb
 d25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=46alcYnUwWpLWLP3SjYYI0z8mk2pPrdjarlJLMhEr3o=;
 b=x76Qgx8Ln0PSpCKv3xjvi214a/Pbd4d3Vj5IVjL3IEwNRhr9xzZePHEP6DeyyeJM7d
 gbgVVDWnszJ7+goekCTMZ7UYcfWq/K47WJnaMthuE3cXPqcLDEzwJ2stCqTAQRsvXZjA
 f+PYNBPXazDD4msEkKHEzcXv/FNFTmQb5uUzDGNul9lu0vTlpas3BlMcvqKfOCiiDGmH
 RNysmlFVVHYYCb7FvhxbUQ1ndyiCgYyon8EnBFjEsLdlXvw2rJjxCLuM0u1VYKm3Wi/G
 J8CuLGq64PGAJG4/tZ9yjDdlpSdLTzwyMdXkFKrFynQGWKswlt9Cc+9HVWyKIpLCpLRV
 fn2g==
X-Gm-Message-State: ANoB5pnLp9+9zlS/Cn/zIqfkrd1/6fq4sWz7xtJCFh48E7hQ1SBRXtoG
 KgRIsHn7JquND0SvqRY5s2c=
X-Google-Smtp-Source: AA0mqf7OHADX39j2RUfoN8Wk74yza/oNpfb1cTYFP5ya7bU047WV1xjubHshjjVjcHx4Y0LLcjnKHQ==
X-Received: by 2002:a17:906:350e:b0:7ae:f441:6ade with SMTP id
 r14-20020a170906350e00b007aef4416ademr47918678eja.436.1669982436453; 
 Fri, 02 Dec 2022 04:00:36 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:51a7:e035:179b:d8f0?
 ([2a02:908:1256:79a0:51a7:e035:179b:d8f0])
 by smtp.gmail.com with ESMTPSA id
 24-20020a170906329800b007b29d292852sm2963085ejw.148.2022.12.02.04.00.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Dec 2022 04:00:35 -0800 (PST)
Message-ID: <65d03a2b-7938-0479-9c6d-b816e65a3fb9@gmail.com>
Date: Fri, 2 Dec 2022 13:00:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] drm/amdgpu: add GART, GPUVM, and GTT to glossary
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221201214153.8453-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20221201214153.8453-1-alexander.deucher@amd.com>
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
Cc: luben.tuikov@amd.com, Peter Maucher <bellosilicio@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 01.12.22 um 22:41 schrieb Alex Deucher:
> Add definitions to clarify GPU virtual memory.
>
> v2: clarify the terms a bit more
>
> Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
> Suggested-by: Peter Maucher <bellosilicio@gmail.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for the series.

> ---
>   Documentation/gpu/amdgpu/amdgpu-glossary.rst | 23 ++++++++++++++++++++
>   1 file changed, 23 insertions(+)
>
> diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> index 326896e9800d..00a47ebb0b0f 100644
> --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> @@ -30,12 +30,35 @@ we have a dedicated glossary for Display Core at
>       EOP
>         End Of Pipe/Pipeline
>   
> +    GART
> +      Graphics Address Remapping Table.  This is the name we use for the GPUVM
> +      page table used by the GPU kernel driver.  It remaps system resources
> +      (memory or MMIO space) into the GPU's address space so the GPU can access
> +      them.  The name GART harkens back to the days of AGP when the platform
> +      provided an MMU that the GPU could use to get a contiguous view of
> +      scattered pages for DMA.  The MMU has since moved on to the GPU, but the
> +      name stuck.
> +
>       GC
>         Graphics and Compute
>   
>       GMC
>         Graphic Memory Controller
>   
> +    GPUVM
> +      GPU Virtual Memory.  This is the GPU's MMU.  The GPU supports multiple
> +      virtual address spaces that can be in flight at any given time.  These
> +      allow the GPU to remap VRAM and system resources into GPU virtual address
> +      spaces for use by the GPU kernel driver and applications using the GPU.
> +      These provide memory protection for different applications using the GPU.
> +
> +    GTT
> +      Graphics Translation Tables.  This is a memory pool managed through TTM
> +      which provides access to system resources (memory or MMIO space) for
> +      use by the GPU. These addresses can be mapped into the "GART" GPUVM page
> +      table for use by the kernel driver or into per process GPUVM page tables
> +      for application usage.
> +
>       IH
>         Interrupt Handler
>   

