Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5323CD129E
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Apr 2024 07:41:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0043F10F272;
	Thu, 11 Apr 2024 07:41:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TkHwlgg1";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57919112773
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 22:21:42 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-1e4149e7695so29262835ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 15:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712787702; x=1713392502; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQ9C1Cr3AvASEU86K/hlf2OO0iCRrNUVuyjVHdlWHE4=;
 b=TkHwlgg1Xm2iq3gfnylt1e3JG/+Y5cLmIreCelKvXvZsv7JrBRDfIBnfk6BMq4zvjT
 IAvSYIN4azM4+90dgDXTNjISggQj3+9p/koF/Yuz8CnOFjGQe+K/CX7FeHabpMKT+6IG
 qgoKQ/XuOWYNjOUkAI+esWbbeL52+V3QsqzlA0Tk6yMqYQgbC/qMDIX9IYUKjp9lmD2j
 ZrMGNGeNvwQHa2HMZvBKrectKSrlsuloFAANAedrY7nuqxyPEVtO8j82QHgvrsqEO+Fo
 skyJqnGuFqG7VdKz4441zyvtZUxIba8ueU5hOVxFnDzGABsJMoIfThld2yDwBbq2nK+u
 oz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712787702; x=1713392502;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UQ9C1Cr3AvASEU86K/hlf2OO0iCRrNUVuyjVHdlWHE4=;
 b=fi2QayRZaFeF2onkpKLQrkE6SV/A/ki7Pox/qTCmzGwxB0+0nBeosTUP2pMxygV9qL
 a3RArEXx7yOQ8qR+duDEGFMqgTI11dCRgqxFouD8YqiQihqIH31+JbUOjS4KFs5lPjRz
 2A8GJ+J29ygbyGonAUKXvlY8KlYw9b5nRh3bRnEVDhNuD14uK6kdgDLmAT2xuy0QWMWP
 2DtVKDRpxRijvL9PXyBcbBQkyzdZWSKA0CBQj5E2yewicsy/+SvoLY/3Qaev3REl3GTi
 T0d1kjcwIDwS5X7I9Tan82AYL2sWIJh+zJXKJwZXZ/Bv+VLx7EK5E/aAEZf2Zd8GQDMh
 duAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5kR3VNWBOeeWW6PWMkalbGJ3lzhaU6M+I0ImUNyXQlpJfyO2RgslAcEaNCEEUO6nTYK+la7vtyii7L0jntzJ2HVGcAxw4VAQnZhkFNg==
X-Gm-Message-State: AOJu0Yyx4wEiiUE77pinOEeoWii0dpF+hFCd5ub0ONCdKGb63zpNhXUy
 2i7/y/q3pp8kpPf9H3U02xUXhUo/0mwkuETBK4aDxX3a/C1jLe85WJQaoYnzbTOq9QHiqB4HmjY
 d80E=
X-Google-Smtp-Source: AGHT+IEyXjz5iWD+JzMbxman4f15iRJH7qvrzDvYbxC6J1pXkyjcclFUtxHEFXG2Dt+UzEnUxH7BCA==
X-Received: by 2002:a17:902:e810:b0:1e3:e081:e7f5 with SMTP id
 u16-20020a170902e81000b001e3e081e7f5mr5334384plg.66.1712787701595; 
 Wed, 10 Apr 2024 15:21:41 -0700 (PDT)
Received: from localhost ([2804:214:8686:5e16:705e:67c9:b3ef:a558])
 by smtp.gmail.com with ESMTPSA id
 q8-20020a170902b10800b001e107222eb5sm39198plr.191.2024.04.10.15.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 15:21:41 -0700 (PDT)
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org,  x86@kernel.org,
 linux-kernel@vger.kernel.org,  linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,  linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>,  loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org,  Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH v4 13/15] drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
In-Reply-To: <20240329072441.591471-14-samuel.holland@sifive.com> (Samuel
 Holland's message of "Fri, 29 Mar 2024 00:18:28 -0700")
References: <20240329072441.591471-1-samuel.holland@sifive.com>
 <20240329072441.591471-14-samuel.holland@sifive.com>
User-Agent: mu4e 1.12.2; emacs 29.3
Date: Wed, 10 Apr 2024 19:21:37 -0300
Message-ID: <87wmp4oo3y.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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


Hello,

Samuel Holland <samuel.holland@sifive.com> writes:

> Now that all previously-supported architectures select
> ARCH_HAS_KERNEL_FPU_SUPPORT, this code can depend on that symbol instead
> of the existing list of architectures. It can also take advantage of the
> common kernel-mode FPU API and method of adjusting CFLAGS.
>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Unfortunately this patch causes build failures on arm with allyesconfig
and allmodconfig. Tested with next-20240410.

Error with allyesconfig:

$ make -j 8 \
    O=3D$HOME/.cache/builds/linux-cross-arm \
    ARCH=3Darm \
    CROSS_COMPILE=3Darm-linux-gnueabihf-
make[1]: Entering directory '/home/bauermann/.cache/builds/linux-cross-arm'
    =E2=8B=AE
arm-linux-gnueabihf-ld: drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.=
o: in function `dcn20_populate_dml_pipes_from_context':
dcn20_fpu.c:(.text+0x20f4): undefined reference to `__aeabi_l2d'
arm-linux-gnueabihf-ld: dcn20_fpu.c:(.text+0x210c): undefined reference to =
`__aeabi_l2d'
arm-linux-gnueabihf-ld: dcn20_fpu.c:(.text+0x2124): undefined reference to =
`__aeabi_l2d'
arm-linux-gnueabihf-ld: dcn20_fpu.c:(.text+0x213c): undefined reference to =
`__aeabi_l2d'
arm-linux-gnueabihf-ld: drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.=
o: in function `pipe_ctx_to_e2e_pipe_params':
dcn_calcs.c:(.text+0x390): undefined reference to `__aeabi_l2d'
arm-linux-gnueabihf-ld: drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.=
o:dcn_calcs.c:(.text+0x3a4): more undefined references to `__aeabi_l2d' fol=
low
arm-linux-gnueabihf-ld: drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.o:=
 in function `optimize_configuration':
dml2_wrapper.c:(.text+0xcbc): undefined reference to `__aeabi_d2ulz'
arm-linux-gnueabihf-ld: drivers/gpu/drm/amd/display/dc/dml2/dml2_translatio=
n_helper.o: in function `populate_dml_plane_cfg_from_plane_state':
dml2_translation_helper.c:(.text+0x9e4): undefined reference to `__aeabi_l2=
d'
arm-linux-gnueabihf-ld: dml2_translation_helper.c:(.text+0xa20): undefined =
reference to `__aeabi_l2d'
arm-linux-gnueabihf-ld: dml2_translation_helper.c:(.text+0xa58): undefined =
reference to `__aeabi_l2d'
arm-linux-gnueabihf-ld: dml2_translation_helper.c:(.text+0xa90): undefined =
reference to `__aeabi_l2d'
make[3]: *** [/home/bauermann/src/linux/scripts/Makefile.vmlinux:37: vmlinu=
x] Error 1
make[2]: *** [/home/bauermann/src/linux/Makefile:1165: vmlinux] Error 2
make[1]: *** [/home/bauermann/src/linux/Makefile:240: __sub-make] Error 2
make[1]: Leaving directory '/home/bauermann/.cache/builds/linux-cross-arm'
make: *** [Makefile:240: __sub-make] Error 2

The error with allmodconfig is slightly different:

$ make -j 8 \
    O=3D$HOME/.cache/builds/linux-cross-arm \
    ARCH=3Darm \
    CROSS_COMPILE=3Darm-linux-gnueabihf-
make[1]: Entering directory '/home/bauermann/.cache/builds/linux-cross-arm'
    =E2=8B=AE
ERROR: modpost: "__aeabi_d2ulz" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] unde=
fined!
ERROR: modpost: "__aeabi_l2d" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefi=
ned!
make[3]: *** [/home/bauermann/src/linux/scripts/Makefile.modpost:145: Modul=
e.symvers] Error 1
make[2]: *** [/home/bauermann/src/linux/Makefile:1876: modpost] Error 2
make[1]: *** [/home/bauermann/src/linux/Makefile:240: __sub-make] Error 2
make[1]: Leaving directory '/home/bauermann/.cache/builds/linux-cross-arm'
make: *** [Makefile:240: __sub-make] Error 2

--
Thiago
