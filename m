Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B462C4167D
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Dec 2023 08:27:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1592610E90B;
	Thu, 14 Dec 2023 08:27:52 +0000 (UTC)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA8AD10E8B7
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 01:03:22 +0000 (UTC)
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-77f3183f012so426929085a.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 17:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1702515802; x=1703120602; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Kotqopmhql9RPm3S4FTj2FqpufLgCsxyuc5LZys4ifw=;
 b=VatAgyVUW3qKZLBS6BCPthIpwyFI228pwHkeo9peQqX+1XCPszlKNyGJYeRKkuuudN
 3Qr7LhXv7NPRG/Mt+b7VtgxDxlgfpxScuV+cV1nZoFlo4iR0ew3TcpdHf0MYDtEwyJHY
 j4mlAJAnlOzskqMgWRgV2V+MsxitxqYOEt7lGOu4s3VdcBr5Jp6IWWEuz8XMBDQgJRQN
 Hl/+7dMhMdQJ7ywA54fiSsr9jQeu8upuxfNqgPZqpCDghcTabz0VOEiBnD1aIViCiDAo
 pZOOg7z/txBZEWr+lCEDRVrvw0qeGi0jZ3KbxZOlAU5NCyr7PR3klB5NAqDVAlDJk9MC
 LehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702515802; x=1703120602;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kotqopmhql9RPm3S4FTj2FqpufLgCsxyuc5LZys4ifw=;
 b=SYr5eIi64y+++RakyelGuK2YGNHnx9N0egYcSeaqdJM+fyVWErvSLxlHVOqeZ+goX4
 V0xRCOySzcF4y5UN9bINBjYlD37b23QgDdHtAtcLLqF9sG/0mPyZ0e66m7weZom+1wix
 TDPqRoxKIQvTYdGBE+rJv74m8X48ZINw/wxteHgAtG1tNZftIsgiW26JIq6zthbs3R++
 xmnrPlJihsLgYjX7LRpm3eY0p6rNO/PdqpDwcKac9OlNjAvuZctnnOC9FBldqNMPMney
 XjwmXMeg4Goy+kZjFEt294JztggoPZFXfgO25zczEELMq/pa3JQk5RL7kyatqXbe6DcH
 Y44Q==
X-Gm-Message-State: AOJu0Yx3n/+868ZKzawB5OLV1JcHbZ/gF9va29goKzYSzIj9Bxc0g3Qt
 dAKTh4qxk+byrpwPLHZFWgy2cQ==
X-Google-Smtp-Source: AGHT+IFjYn4/wlSclY9FQAk7x1h05GKodk6C3zlVMTJ3BbOMNQ8WP5BrWLxO1hQ2sob52mgNqAJxdQ==
X-Received: by 2002:a05:620a:1034:b0:77f:2734:4c5d with SMTP id
 a20-20020a05620a103400b0077f27344c5dmr9834012qkk.130.1702515801849; 
 Wed, 13 Dec 2023 17:03:21 -0800 (PST)
Received: from ?IPV6:2600:1700:2000:b002:a1d1:dd74:a6de:fdf?
 ([2600:1700:2000:b002:a1d1:dd74:a6de:fdf])
 by smtp.gmail.com with ESMTPSA id
 ul9-20020a05620a6d0900b0077f0d3bac3bsm4896980qkn.76.2023.12.13.17.03.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 17:03:21 -0800 (PST)
Message-ID: <7ed20fcf-8a9d-40d5-b913-b5d2da443cd6@sifive.com>
Date: Wed, 13 Dec 2023 19:03:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/12] drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
Content-Language: en-US
To: Michael Ellerman <mpe@ellerman.id.au>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-11-samuel.holland@sifive.com>
 <87h6kpdj20.fsf@mail.lhotse>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <87h6kpdj20.fsf@mail.lhotse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 14 Dec 2023 08:27:49 +0000
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
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>,
 Timothy Pearson <tpearson@raptorengineering.com>, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-12-11 6:23 AM, Michael Ellerman wrote:
> Hi Samuel,
> 
> Thanks for trying to clean all this up.
> 
> One problem below.
> 
> Samuel Holland <samuel.holland@sifive.com> writes:
>> Now that all previously-supported architectures select
>> ARCH_HAS_KERNEL_FPU_SUPPORT, this code can depend on that symbol instead
>> of the existing list of architectures. It can also take advantage of the
>> common kernel-mode FPU API and method of adjusting CFLAGS.
>>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ...
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
>> index 4ae4720535a5..b64f917174ca 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
>> @@ -87,20 +78,9 @@ void dc_fpu_begin(const char *function_name, const int line)
>>  	WARN_ON_ONCE(!in_task());
>>  	preempt_disable();
>>  	depth = __this_cpu_inc_return(fpu_recursion_depth);
>> -
>>  	if (depth == 1) {
>> -#if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
>> +		BUG_ON(!kernel_fpu_available());
>>  		kernel_fpu_begin();
>> -#elif defined(CONFIG_PPC64)
>> -		if (cpu_has_feature(CPU_FTR_VSX_COMP))
>> -			enable_kernel_vsx();
>> -		else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP))
>> -			enable_kernel_altivec();
>  
> Note altivec.
> 
>> -		else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
>> -			enable_kernel_fp();
>> -#elif defined(CONFIG_ARM64)
>> -		kernel_neon_begin();
>> -#endif
>>  	}
>>  
>>  	TRACE_DCN_FPU(true, function_name, line, depth);
>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> index ea7d60f9a9b4..5aad0f572ba3 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> @@ -25,40 +25,8 @@
>>  # It provides the general basic services required by other DAL
>>  # subcomponents.
>>  
>> -ifdef CONFIG_X86
>> -dml_ccflags-$(CONFIG_CC_IS_GCC) := -mhard-float
>> -dml_ccflags := $(dml_ccflags-y) -msse
>> -endif
>> -
>> -ifdef CONFIG_PPC64
>> -dml_ccflags := -mhard-float -maltivec
>> -endif
> 
> And altivec is enabled in the flags there.
> 
> That doesn't match your implementation for powerpc in patch 7, which
> only deals with float.
> 
> I suspect the AMD driver actually doesn't need altivec enabled, but I
> don't know that for sure. It compiles without it, but I don't have a GPU
> to actually test. I've added Timothy on Cc who added the support for
> powerpc to the driver originally, hopefully he has a test system.

I tested this series on a POWER9 system with an AMD Radeon RX 6400 GPU (which
requires this FPU code to initialize), and got functioning graphics output.

> Anyway if that's true that it doesn't need altivec we should probably do
> a lead-up patch that drops altivec from the AMD driver explicitly, eg.
> as below.

That makes sense to me. Do you want to provide your Signed-off-by so I can send
this patch with your authorship?

Regards,
Samuel

> cheers
> 
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> index 4ae4720535a5..0de16796466b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> @@ -92,11 +92,7 @@ void dc_fpu_begin(const char *function_name, const int line)
>  #if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
>  		kernel_fpu_begin();
>  #elif defined(CONFIG_PPC64)
> -		if (cpu_has_feature(CPU_FTR_VSX_COMP))
> -			enable_kernel_vsx();
> -		else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP))
> -			enable_kernel_altivec();
> -		else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
> +		if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
>  			enable_kernel_fp();
>  #elif defined(CONFIG_ARM64)
>  		kernel_neon_begin();
> @@ -125,11 +121,7 @@ void dc_fpu_end(const char *function_name, const int line)
>  #if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
>  		kernel_fpu_end();
>  #elif defined(CONFIG_PPC64)
> -		if (cpu_has_feature(CPU_FTR_VSX_COMP))
> -			disable_kernel_vsx();
> -		else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP))
> -			disable_kernel_altivec();
> -		else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
> +		if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
>  			disable_kernel_fp();
>  #elif defined(CONFIG_ARM64)
>  		kernel_neon_end();
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> index 6042a5a6a44f..554c39024a40 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -31,7 +31,7 @@ dml_ccflags := $(dml_ccflags-y) -msse
>  endif
>  
>  ifdef CONFIG_PPC64
> -dml_ccflags := -mhard-float -maltivec
> +dml_ccflags := -mhard-float
>  endif
>  
>  ifdef CONFIG_ARM64
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/Makefile b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
> index acff3449b8d7..7b51364084b5 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
> @@ -30,7 +30,7 @@ dml2_ccflags := $(dml2_ccflags-y) -msse
>  endif
>  
>  ifdef CONFIG_PPC64
> -dml2_ccflags := -mhard-float -maltivec
> +dml2_ccflags := -mhard-float
>  endif
>  
>  ifdef CONFIG_ARM64

