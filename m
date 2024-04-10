Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137CECD128A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Apr 2024 07:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5896F10F107;
	Thu, 11 Apr 2024 07:41:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="T453n8yT";
	dkim-atps=neutral
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com
 [209.85.160.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D81A610EAA3
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 22:47:30 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id
 586e51a60fabf-22ed72b0082so3202309fac.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 15:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1712789250; x=1713394050; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jexQJX0oM9fCmEvziBSolme7TKZ0EEYhwHpwJAChgvs=;
 b=T453n8yTcu1GeZCoCOB1y+IfjLljZSd/ij9GiyLZ7Y3g+ytsac6zuj+4MqZCQfe98Y
 b9XHGJaVL7uDBnERwOz5gzpYjwFWFkMh3htqImf1WhD/Sf9OyVPjIdz8aQOwoOTo8xTr
 U+Toi3w9nUny55iTp+WNOKVLGtCy9bfRwzLTI/d/iG4Fz/o7WiHwYIGI1M1Kw53SVpVn
 zyhdXvAhfs7kMLgUGuGyXR8Hm+sk/g8pTn0fXmaMJZAi5Bqf/hPaptIlrKWDvqMGTbCQ
 rAz0zMYU0TtrNgGXYepj7k1norwO3Q24jDK1it9Vqx0hwlpeU0mpuAtUinq4VqDxvpx6
 CZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712789250; x=1713394050;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jexQJX0oM9fCmEvziBSolme7TKZ0EEYhwHpwJAChgvs=;
 b=oy6J4Tr+nAd8pWwIcBWWyw/mmavmg5m8wPM3onEH2FCK4ln7HSJanbxILPFt2km15D
 cK64vpIxYm0KFHOU5M8M+i6IfPM3N0zOOSw3DavXKzYKVI/1eVs53T2qSotyfqlD6f/i
 Si9MH4iVP9yDprOoSuW0CTjroTLHVCSO8tC1omSrA1M1ZY4AREWBwTN5W0Robm/nfzon
 7bRWJ0VhocKUnoswgj0hua6kWuPUWqqdCoBXFrjmzqbb0s88bgoNuRX8vq/V7astkLBe
 NoOs5T94xhnp2VGFfzALUXakVJkbabq21NS0xmU0tsCCyc3nvia4O2IDHTkW50DtGQBZ
 NpPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW32218MC27At7rOJw1QM0fw6tEia1+mjquCEnaOUQNp4FJzS/KmtsYuXusWcfeIOi8CveUgGch5NSWh4AVmxq6KMzQzercxuIm0lkeEQ==
X-Gm-Message-State: AOJu0Yy6nKAVZ9NIflrAXYSpOHaalAQRLietGsRKPLVbibN9CsyZylRo
 ksYEJpj5YQc8FsKogT9rmg5PfoqoL/LH2WMfC3do+sGhGQj5+cEN/+tZvGD/Ulg=
X-Google-Smtp-Source: AGHT+IHLiKUoeBUB4OwLHReX4a7dcUh2Eqxld9pK8ip3FgSpidJgLmLzuSWt1Fnkq1wrPVQWu86Qjg==
X-Received: by 2002:a05:6871:80a:b0:22d:f859:2225 with SMTP id
 q10-20020a056871080a00b0022df8592225mr3914938oap.6.1712789249782; 
 Wed, 10 Apr 2024 15:47:29 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.8.167]) by smtp.gmail.com with ESMTPSA id
 lf3-20020a0568700c4300b0022eba51882fsm75970oab.53.2024.04.10.15.47.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Apr 2024 15:47:29 -0700 (PDT)
Message-ID: <75a37a4b-f516-40a3-b6b5-4aa1636f9b60@sifive.com>
Date: Wed, 10 Apr 2024 17:47:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/15] drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
To: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
References: <20240329072441.591471-1-samuel.holland@sifive.com>
 <20240329072441.591471-14-samuel.holland@sifive.com>
 <87wmp4oo3y.fsf@linaro.org>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <87wmp4oo3y.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Apr 2024 07:41:31 +0000
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

Hi Thiago,

On 2024-04-10 5:21 PM, Thiago Jung Bauermann wrote:
> Samuel Holland <samuel.holland@sifive.com> writes:
> 
>> Now that all previously-supported architectures select
>> ARCH_HAS_KERNEL_FPU_SUPPORT, this code can depend on that symbol instead
>> of the existing list of architectures. It can also take advantage of the
>> common kernel-mode FPU API and method of adjusting CFLAGS.
>>
>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> 
> Unfortunately this patch causes build failures on arm with allyesconfig
> and allmodconfig. Tested with next-20240410.
> 
> Error with allyesconfig:
> 
> $ make -j 8 \
>     O=$HOME/.cache/builds/linux-cross-arm \
>     ARCH=arm \
>     CROSS_COMPILE=arm-linux-gnueabihf-
> make[1]: Entering directory '/home/bauermann/.cache/builds/linux-cross-arm'
>     ⋮
> arm-linux-gnueabihf-ld: drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.o: in function `dcn20_populate_dml_pipes_from_context':
> dcn20_fpu.c:(.text+0x20f4): undefined reference to `__aeabi_l2d'
> arm-linux-gnueabihf-ld: dcn20_fpu.c:(.text+0x210c): undefined reference to `__aeabi_l2d'
> arm-linux-gnueabihf-ld: dcn20_fpu.c:(.text+0x2124): undefined reference to `__aeabi_l2d'
> arm-linux-gnueabihf-ld: dcn20_fpu.c:(.text+0x213c): undefined reference to `__aeabi_l2d'
> arm-linux-gnueabihf-ld: drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.o: in function `pipe_ctx_to_e2e_pipe_params':
> dcn_calcs.c:(.text+0x390): undefined reference to `__aeabi_l2d'
> arm-linux-gnueabihf-ld: drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.o:dcn_calcs.c:(.text+0x3a4): more undefined references to `__aeabi_l2d' follow
> arm-linux-gnueabihf-ld: drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.o: in function `optimize_configuration':
> dml2_wrapper.c:(.text+0xcbc): undefined reference to `__aeabi_d2ulz'
> arm-linux-gnueabihf-ld: drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.o: in function `populate_dml_plane_cfg_from_plane_state':
> dml2_translation_helper.c:(.text+0x9e4): undefined reference to `__aeabi_l2d'
> arm-linux-gnueabihf-ld: dml2_translation_helper.c:(.text+0xa20): undefined reference to `__aeabi_l2d'
> arm-linux-gnueabihf-ld: dml2_translation_helper.c:(.text+0xa58): undefined reference to `__aeabi_l2d'
> arm-linux-gnueabihf-ld: dml2_translation_helper.c:(.text+0xa90): undefined reference to `__aeabi_l2d'
> make[3]: *** [/home/bauermann/src/linux/scripts/Makefile.vmlinux:37: vmlinux] Error 1
> make[2]: *** [/home/bauermann/src/linux/Makefile:1165: vmlinux] Error 2
> make[1]: *** [/home/bauermann/src/linux/Makefile:240: __sub-make] Error 2
> make[1]: Leaving directory '/home/bauermann/.cache/builds/linux-cross-arm'
> make: *** [Makefile:240: __sub-make] Error 2
> 
> The error with allmodconfig is slightly different:
> 
> $ make -j 8 \
>     O=$HOME/.cache/builds/linux-cross-arm \
>     ARCH=arm \
>     CROSS_COMPILE=arm-linux-gnueabihf-
> make[1]: Entering directory '/home/bauermann/.cache/builds/linux-cross-arm'
>     ⋮
> ERROR: modpost: "__aeabi_d2ulz" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: modpost: "__aeabi_l2d" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> make[3]: *** [/home/bauermann/src/linux/scripts/Makefile.modpost:145: Module.symvers] Error 1
> make[2]: *** [/home/bauermann/src/linux/Makefile:1876: modpost] Error 2
> make[1]: *** [/home/bauermann/src/linux/Makefile:240: __sub-make] Error 2
> make[1]: Leaving directory '/home/bauermann/.cache/builds/linux-cross-arm'
> make: *** [Makefile:240: __sub-make] Error 2

In both cases, the issue is that the toolchain requires runtime support to
convert between `unsigned long long` and `double`, even when hardware FP is
enabled. There was some past discussion about GCC inlining some of these
conversions[1], but that did not get implemented.

The short-term fix would be to drop the `select ARCH_HAS_KERNEL_FPU_SUPPORT` for
32-bit arm until we can provide these runtime library functions.

Regards,
Samuel

[1]: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91970
