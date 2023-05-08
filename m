Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D69C77B7F
	for <amd-gfx@archiver.kernel.org>; Mon,  8 May 2023 15:51:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ED3610E128;
	Mon,  8 May 2023 15:51:59 +0000 (UTC)
X-Greylist: delayed 305 seconds by postgrey-1.36 at gabe;
 Mon, 08 May 2023 15:51:56 UTC
Received: from 189.cn (ptr.189.cn [183.61.185.102])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9C68A10E128
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 May 2023 15:51:56 +0000 (UTC)
HMM_SOURCE_IP: 10.64.8.43:47158.1430520327
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
 by 189.cn (HERMES) with SMTP id 7FE971002D0;
 Mon,  8 May 2023 23:46:41 +0800 (CST)
Received: from  ([114.242.206.180])
 by gateway-151646-dep-85667d6c59-fm8l8 with ESMTP id
 10d356d3088243c48c5866795556142a for chenhuacai@loongson.cn; 
 Mon, 08 May 2023 23:46:48 CST
X-Transaction-ID: 10d356d3088243c48c5866795556142a
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Message-ID: <1b888568-b1f4-c764-7212-5a940fb8454a@189.cn>
Date: Mon, 8 May 2023 23:46:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [V3] drm/amdgpu/display: Enable DC_FP for LoongArch
To: Huacai Chen <chenhuacai@loongson.cn>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Pan@freedesktop.org, Xinhui <Xinhui.Pan@amd.com>,
 David Airlie <airlied@linux.ie>
References: <20230508030941.476694-1-chenhuacai@loongson.cn>
Content-Language: en-US
From: Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <20230508030941.476694-1-chenhuacai@loongson.cn>
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
Cc: loongson-kernel@lists.loongnix.cn, WANG Xuerui <kernel@xen0n.name>,
 Xuefeng Li <lixuefeng@loongson.cn>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Nice patch!


I have tested this patch on ls3a5000+ls7a2000+AMDGPU RX550, but it seems 
that dc_fpu_begin() and

dc_fpu_end() will not be called on AMDGPU RX550. But it at least proved that

this patch does not introduce bugs to what already works.


I can proved that after apply this patch,  glmark2 still works like a 
charm.

fbtest and kms_flip test also run very well.


On 2023/5/8 11:09, Huacai Chen wrote:
> LoongArch now provides kernel_fpu_begin() and kernel_fpu_end() that are
> used like the x86 counterparts in commit 2b3bd32ea3a22ea2d ("LoongArch:
> Provide kernel fpu functions"), so we can enable DC_FP on LoongArch for
> supporting more DCN devices.
>
> Signed-off-by: WANG Xuerui <kernel@xen0n.name>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> V2: Update commit message to add the commit which provides kernel fpu
>      functions.
> V3: Update commit message again and rebase on the latest code.
>
>   drivers/gpu/drm/amd/display/Kconfig            | 2 +-
>   drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c | 6 ++++--
>   drivers/gpu/drm/amd/display/dc/dml/Makefile    | 5 +++++
>   3 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> index 2d8e55e29637..49df073962d5 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -8,7 +8,7 @@ config DRM_AMD_DC
>   	depends on BROKEN || !CC_IS_CLANG || X86_64 || SPARC64 || ARM64
>   	select SND_HDA_COMPONENT if SND_HDA_CORE
>   	# !CC_IS_CLANG: https://github.com/ClangBuiltLinux/linux/issues/1752
> -	select DRM_AMD_DC_FP if (X86 || (PPC64 && ALTIVEC) || (ARM64 && KERNEL_MODE_NEON && !CC_IS_CLANG))
> +	select DRM_AMD_DC_FP if (X86 || LOONGARCH || (PPC64 && ALTIVEC) || (ARM64 && KERNEL_MODE_NEON && !CC_IS_CLANG))
>   	help
>   	  Choose this option if you want to use the new display engine
>   	  support for AMDGPU. This adds required support for Vega and
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> index c42aa947c969..172aa10a8800 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> @@ -33,6 +33,8 @@
>   #include <asm/cputable.h>
>   #elif defined(CONFIG_ARM64)
>   #include <asm/neon.h>
> +#elif defined(CONFIG_LOONGARCH)
> +#include <asm/fpu.h>
>   #endif
>   
>   /**
> @@ -88,7 +90,7 @@ void dc_fpu_begin(const char *function_name, const int line)
>   	*pcpu += 1;
>   
>   	if (*pcpu == 1) {
> -#if defined(CONFIG_X86)
> +#if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
>   		migrate_disable();
>   		kernel_fpu_begin();
>   #elif defined(CONFIG_PPC64)
> @@ -128,7 +130,7 @@ void dc_fpu_end(const char *function_name, const int line)
>   	pcpu = get_cpu_ptr(&fpu_recursion_depth);
>   	*pcpu -= 1;
>   	if (*pcpu <= 0) {
> -#if defined(CONFIG_X86)
> +#if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
>   		kernel_fpu_end();
>   		migrate_enable();
>   #elif defined(CONFIG_PPC64)
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> index 01db035589c5..77cf5545c94c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -38,6 +38,11 @@ ifdef CONFIG_ARM64
>   dml_rcflags := -mgeneral-regs-only
>   endif
>   
> +ifdef CONFIG_LOONGARCH
> +dml_ccflags := -mfpu=64
> +dml_rcflags := -msoft-float
> +endif
> +
>   ifdef CONFIG_CC_IS_GCC
>   ifneq ($(call gcc-min-version, 70100),y)
>   IS_OLD_GCC = 1
