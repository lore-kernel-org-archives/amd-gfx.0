Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE79ECAAA1
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Oct 2022 15:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44CE510E860;
	Fri, 28 Oct 2022 15:48:32 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43B5810E85E
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Oct 2022 15:48:29 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 72690B828BB;
 Fri, 28 Oct 2022 15:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89522C433D7;
 Fri, 28 Oct 2022 15:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666972106;
 bh=mbsamtltS2Ok1xD4XGUo5XVr08mORwKCj3h7gL77wtE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PhgYRVh7IiSgjtHX78yN+gF0O7dN9D0wYe6lTZit8UB5ZsjbINuqNmLXC7OqILGd8
 a4lOF1WfjNLeWgNWRsqpJWnYlV2+ZlKfl9H0yBo21N/Qj0swZA9u0nfZANO2rnxOUI
 BgE9+UdANNDLAg0VRvyjq6GZSZWQ25HLN/cPcabYlcbiIxGQwM0w0i0f9tkGCPTlX7
 ke9JCz1MT+m5oC/VITm2IuuhR56j54SrL9s96vi3SwRftWz4SrxsnLeMq1T0nTzhhl
 2K7BgwmW3rK18IDRBZRlyahDX0YAZsRZLQKeDar6kH+qloekx7ZPnBGrbp0udumbiV
 PpHLAk+J18kjg==
Date: Fri, 28 Oct 2022 08:48:23 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
Subject: Re: [PATCH v3 1/1] drm/amd/display: add DCN support for ARM64
Message-ID: <Y1v5x+tiJy3IurF3@dev-arch.thelio-3990X>
References: <20221027195227.5312-1-hacc1225@gmail.com>
 <20221027195227.5312-2-hacc1225@gmail.com>
 <Y1vwk3J3HPGugBJO@dev-arch.thelio-3990X>
 <f31b8573-336a-dd0b-1628-d60066ce533c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f31b8573-336a-dd0b-1628-d60066ce533c@amd.com>
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
Cc: Ao Zhong <hacc1225@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Arnd Bergmann <arnd@arndb.de>, Leo Li <sunpeng.li@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Rodrigo,

On Fri, Oct 28, 2022 at 11:35:32AM -0400, Rodrigo Siqueira Jordao wrote:
> 
> 
> On 2022-10-28 11:09, Nathan Chancellor wrote:
> > Hi Ao,
> > 
> > On Thu, Oct 27, 2022 at 09:52:29PM +0200, Ao Zhong wrote:
> > > After moving all FPU code to the DML folder, we can enable DCN support
> > > for the ARM64 platform. Remove the -mgeneral-regs-only CFLAG from the
> > > code in the DML folder that needs to use hardware FPU, and add a control
> > > mechanism for ARM Neon.
> > > 
> > > Signed-off-by: Ao Zhong <hacc1225@gmail.com>
> > > ---
> > >   drivers/gpu/drm/amd/display/Kconfig           |  2 +-
> > >   .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    |  6 ++++++
> > >   drivers/gpu/drm/amd/display/dc/dml/Makefile   | 20 +++++++++++++++----
> > >   3 files changed, 23 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> > > index 0142affcdaa3..a7f1c4e51719 100644
> > > --- a/drivers/gpu/drm/amd/display/Kconfig
> > > +++ b/drivers/gpu/drm/amd/display/Kconfig
> > > @@ -6,7 +6,7 @@ config DRM_AMD_DC
> > >   	bool "AMD DC - Enable new display engine"
> > >   	default y
> > >   	select SND_HDA_COMPONENT if SND_HDA_CORE
> > > -	select DRM_AMD_DC_DCN if (X86 || PPC64)
> > > +	select DRM_AMD_DC_DCN if (X86 || PPC64 || (ARM64 && KERNEL_MODE_NEON))
> > >   	help
> > >   	  Choose this option if you want to use the new display engine
> > >   	  support for AMDGPU. This adds required support for Vega and
> > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> > > index ab0c6d191038..1743ca0a3641 100644
> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> > > @@ -31,6 +31,8 @@
> > >   #elif defined(CONFIG_PPC64)
> > >   #include <asm/switch_to.h>
> > >   #include <asm/cputable.h>
> > > +#elif defined(CONFIG_ARM64)
> > > +#include <asm/neon.h>
> > >   #endif
> > >   /**
> > > @@ -99,6 +101,8 @@ void dc_fpu_begin(const char *function_name, const int line)
> > >   			preempt_disable();
> > >   			enable_kernel_fp();
> > >   		}
> > > +#elif defined(CONFIG_ARM64)
> > > +		kernel_neon_begin();
> > >   #endif
> > >   	}
> > > @@ -136,6 +140,8 @@ void dc_fpu_end(const char *function_name, const int line)
> > >   			disable_kernel_fp();
> > >   			preempt_enable();
> > >   		}
> > > +#elif defined(CONFIG_ARM64)
> > > +		kernel_neon_end();
> > >   #endif
> > >   	}
> > > diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> > > index d0c6cf61c676..d4e93bed1c8e 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> > > +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> > > @@ -33,6 +33,10 @@ ifdef CONFIG_PPC64
> > >   dml_ccflags := -mhard-float -maltivec
> > >   endif
> > > +ifdef CONFIG_ARM64
> > > +dml_rcflags := -mgeneral-regs-only
> > > +endif
> > > +
> > >   ifdef CONFIG_CC_IS_GCC
> > >   ifeq ($(call cc-ifversion, -lt, 0701, y), y)
> > >   IS_OLD_GCC = 1
> > > @@ -55,8 +59,6 @@ frame_warn_flag := -Wframe-larger-than=2048
> > >   endif
> > >   CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
> > > -
> > > -ifdef CONFIG_DRM_AMD_DC_DCN
> > >   CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_ccflags)
> > >   CFLAGS_$(AMDDALPATH)/dc/dml/dcn10/dcn10_fpu.o := $(dml_ccflags)
> > >   CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/dcn20_fpu.o := $(dml_ccflags)
> > > @@ -88,7 +90,6 @@ CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_ccflags)
> > >   CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_ccflags)
> > >   CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_ccflags) -Wno-tautological-compare
> > >   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
> > > -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn2x/dcn2x.o := $(dml_rcflags)
> > >   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_rcflags)
> > >   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20.o := $(dml_rcflags)
> > >   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_rcflags)
> > > @@ -105,7 +106,18 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/display_mode_vba_util_32.o := $(dml_rcf
> > >   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn301/dcn301_fpu.o := $(dml_rcflags)
> > >   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_rcflags)
> > >   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o  := $(dml_rcflags)
> > > -endif
> > > +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn10/dcn10_fpu.o := $(dml_rcflags)
> > > +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/dcn20_fpu.o := $(dml_rcflags)
> > > +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/display_mode_vba_314.o := $(dml_rcflags)
> > > +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/display_rq_dlg_calc_314.o := $(dml_rcflags)
> > > +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/dcn314_fpu.o := $(dml_rcflags)
> > > +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/dcn30_fpu.o := $(dml_rcflags)
> > > +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/dcn32_fpu.o := $(dml_rcflags)
> > > +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn321/dcn321_fpu.o := $(dml_rcflags)
> > > +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/dcn31_fpu.o := $(dml_rcflags)
> > > +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn302/dcn302_fpu.o := $(dml_rcflags)
> > > +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn303/dcn303_fpu.o := $(dml_rcflags)
> > > +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_rcflags)
> > >   CFLAGS_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_ccflags)
> > >   CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_ccflags)
> > >   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_rcflags)
> > > -- 
> > > 2.37.4
> > > 
> > 
> > Enabling this code for arm64 reveals the following warnings when
> > building allmodconfig with clang. A very recent change in LLVM added the
> > variable and spill information so that will not be seen with older
> > versions but I also saw the warnings with clang 15.0.0 from Fedora.
> > 
> >    drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:1852:13: error: stack frame size (2112) exceeds limit (2048) in 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation' [-Werror,-Wframe-larger-than]
> >    static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation(
> >                ^
> >    1152/2112 (54.55%) spills, 960/2112 (45.45%) variables
> > 
> >    drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3542:6: error: stack frame size (2240) exceeds limit (2048) in 'dml30_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
> >    void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
> >        ^
> >    1451/2240 (64.78%) spills, 789/2240 (35.22%) variables
> > 
> >    drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:3791:6: error: stack frame size (2736) exceeds limit (2048) in 'dml31_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
> >    void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
> >        ^
> >    1342/2736 (49.05%) spills, 1394/2736 (50.95%) variables
> > 
> >    drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_mode_vba_314.c:3890:6: error: stack frame size (2720) exceeds limit (2048) in 'dml314_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
> >    void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
> >        ^
> >    1325/2720 (48.71%) spills, 1395/2720 (51.29%) variables
> > 
> >    drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:59:13: error: stack frame size (2208) exceeds limit (2048) in 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation' [-Werror,-Wframe-larger-than]
> >    static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation(
> >                ^
> >    1397/2208 (63.27%) spills, 811/2208 (36.73%) variables
> > 
> >    drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:1681:6: error: stack frame size (2496) exceeds limit (2048) in 'dml32_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
> >    void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
> >        ^
> >    1504/2496 (60.26%) spills, 992/2496 (39.74%) variables
> > 
> > I can try to take a look at these next week, as I have prior obligations
> > today, unless others wanted to help me out ;)
> 
> Hi Nathan,
> 
> Thanks a lot for checking this.
> 
> About those stack frame issues, I guess they are generic, right? I mean, I
> don't see why we only see it if we enable arm64.

I do not see these warnings on x86_64 as I had to tackle them for 6.0.
powerpc allmodconfig is already broken with clang for other reasons so I
am not sure if these warnings are there; I can try to test that. I am
not sure why things are going sideways for arm64 with clang here but I
would really like to keep allmodconfig building without any issues, as
that is a good target for catching new warnings due to -Werror.

> > Additionally, I see the following errors with GCC 12.2.1 from Fedora
> > when building allmodconfig. Seems like some $(dml_rcflags) might be
> > missing.
> > 
> >    drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c: In function ‘dcn10_resource_construct_fp’:
> >    drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1313:52: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
> >    1313 |                 dcn_soc->dram_clock_change_latency = 23;
> >          |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> >    drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1317:45: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
> >    1317 |                 dc->dcn_soc->urgent_latency = 3;
> >          |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> >    drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1319:64: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
> >    1319 |                 dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 41.60f;
> >          |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~
> >    drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1329:64: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
> >    1329 |                 dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 19.2f;
> >          |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
> >    drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1330:64: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
> >    1330 |                 dc->dcn_soc->fabric_and_dram_bandwidth_vnom0p8 = 17.066f;
> >          |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~
> >    drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1331:65: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
> >    1331 |                 dc->dcn_soc->fabric_and_dram_bandwidth_vmid0p72 = 14.933f;
> >          |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~
> >    drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1332:65: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
> >    1332 |                 dc->dcn_soc->fabric_and_dram_bandwidth_vmin0p65 = 12.8f;
> >          |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
> >    drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1334:72: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
> >    1334 |                         dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 20.80f;
> >          |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~
> >    make[6]: *** [scripts/Makefile.build:250: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.o] Error 1
> >    drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c: In function ‘dcn32_populate_dml_pipes_from_context’:
> >    drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:1921:70: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
> >    1921 |                 pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
> >          |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> >    drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:1922:72: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
> >    1922 |                 pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
> >          |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> >    make[6]: *** [scripts/Makefile.build:250: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.o] Error 1
> 
> Could you check if you have this commit in your branch?
> 
> drm/amd/display: move remaining FPU code to dml folder
> 
> iirc, I merged it around Tue:
> https://gitlab.freedesktop.org/agd5f/linux/-/commits/amd-staging-drm-next

Ah sorry, I had to use the drm-next branch because amd-staging-drm-next
is based on 5.18, meaning it does not have support for a recent pahole
flag that is on by default, which breaks all of my builds. That support
was enabled in 6.0 if I remember correctly; drm-next is based on 6.1-rc1
so everything works fine there. You can just ignore this error since it
was already fixed.

Cheers,
Nathan
