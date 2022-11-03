Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FCAC433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 14:25:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3516910E602;
	Thu,  3 Nov 2022 14:25:57 +0000 (UTC)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8689810E602
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 14:22:01 +0000 (UTC)
Received: by mail-vs1-xe2b.google.com with SMTP id p4so1995072vsa.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Nov 2022 07:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8/h40Pm+HYbMG1QyloTMawjx/iZ8VyHlxRxwHDZMMNY=;
 b=YjtfxQ/IX75lQDlxT9rTDGb3QI9+ctncaGvGXhmfzQHp8eYFWC++YRmXC81CSG3FaL
 CGNrWWLpyG+uGvmUGnrhud8w/lV2htsCdHCtSxDmS8PYxzM76FWcJbdSmp9lytIGKEw5
 rECL20F6HcNKxysLsvFFYrS2NIHlr+vWE9wp48eYZ9Md3I0Q0IKLJdyzPhVzeu+38Kfa
 0nzHmubxXhXG9h60bJMAbpntnAAICp6f7fbLjov8CNqNaG5Z9TZaZZe1lHa/uINqY00u
 SiICyEHRGt0kka7202yKWroq0r5pOw/fop/9YsyE5uWEHzaep6O8+hwQf6KyudeAnEIE
 a5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8/h40Pm+HYbMG1QyloTMawjx/iZ8VyHlxRxwHDZMMNY=;
 b=vA0stFBAygGQg5ypyRoCZea7+mYeqZnQ7vE5aGLbtjU6R7j2og6ZTnOCY+lfT9BOrv
 Qkis55kjXyXLfURsUsWFW8+4eXT0n1kOUUthICuO7qnATqUKjIXvPfbwvbMaDYAuQbPk
 OgCg9KKxYiZ/bLSnML1K2QNv9sAfLWjj/7Lr5tCyLzFgEQ8tJy7HC+T7p31TWv5DfT8O
 sIxDatEkpcpDf5DwkGkS0kNv/HptjWpXomkWOeyMYve2ci0ELFWGOB9dfjZf+9ERwYf7
 oW3yiBnvZqnSOtKJe8vrx7PSUc8HSvmLlms7BaVG3hpOZSZmVdVWjje7kTaRhJ6xDkd7
 fhMQ==
X-Gm-Message-State: ACrzQf1PviKemoPGYgyCUrmfxviKyRWzZKhroUl91ibJtCp3H82pUULq
 7kd/64v09f+/v2VhTFFzwgJwCPuyosMnnEN3NR8=
X-Google-Smtp-Source: AMsMyM6winVBofSTbcDEY8Mc335Cz/+argEckypfUSTfQdifr6kw4vH8Sx4Em+FAVA83vCyDJZdRSCalFdP5/wFXG8A=
X-Received: by 2002:a67:e281:0:b0:3aa:1c54:f8a1 with SMTP id
 g1-20020a67e281000000b003aa1c54f8a1mr17315392vsf.8.1667485320414; Thu, 03 Nov
 2022 07:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221031193738.23538-1-hacc1225@gmail.com>
 <20221031193738.23538-2-hacc1225@gmail.com>
 <6b5fb93f-fd23-c96d-0f1d-ba8bcd7a5079@amd.com>
 <Y2FJ5wXpEpKf9v/P@dev-arch.thelio-3990X>
 <2f9d42a0-7f42-20b0-18b8-40c38ab10ceb@amd.com>
In-Reply-To: <2f9d42a0-7f42-20b0-18b8-40c38ab10ceb@amd.com>
From: Ao Zhong <hacc1225@gmail.com>
Date: Thu, 3 Nov 2022 15:21:49 +0100
Message-ID: <CAG9e_p2PxVQARaB8Fi8nz22jn6rdxVcdatTu8pc3TJa_Bma4Dg@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] drm/amd/display: add DCN support for ARM64
To: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
Content-Type: multipart/alternative; boundary="000000000000310c0a05ec91aeea"
X-Mailman-Approved-At: Thu, 03 Nov 2022 14:25:55 +0000
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
 Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org,
 Nathan Chancellor <nathan@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000310c0a05ec91aeea
Content-Type: text/plain; charset="UTF-8"

Awesome, thanks!

Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com> schrieb am Do. 3. Nov.
2022 um 15:21:

>
>
> On 2022-11-01 12:31, Nathan Chancellor wrote:
> > On Tue, Nov 01, 2022 at 10:36:08AM -0400, Rodrigo Siqueira Jordao wrote:
> >>
> >>
> >> On 2022-10-31 15:37, Ao Zhong wrote:
> >>> After moving all FPU code to the DML folder, we can enable DCN support
> >>> for the ARM64 platform. Remove the -mgeneral-regs-only CFLAG from the
> >>> code in the DML folder that needs to use hardware FPU, and add a
> control
> >>> mechanism for ARM Neon.
> >>>
> >>> Signed-off-by: Ao Zhong <hacc1225@gmail.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/display/Kconfig           |  3 ++-
> >>>    .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    |  6 ++++++
> >>>    drivers/gpu/drm/amd/display/dc/dml/Makefile   | 20
> +++++++++++++++----
> >>>    3 files changed, 24 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/display/Kconfig
> b/drivers/gpu/drm/amd/display/Kconfig
> >>> index 0142affcdaa3..843a55a6a3ac 100644
> >>> --- a/drivers/gpu/drm/amd/display/Kconfig
> >>> +++ b/drivers/gpu/drm/amd/display/Kconfig
> >>> @@ -6,7 +6,8 @@ config DRM_AMD_DC
> >>>     bool "AMD DC - Enable new display engine"
> >>>     default y
> >>>     select SND_HDA_COMPONENT if SND_HDA_CORE
> >>> -   select DRM_AMD_DC_DCN if (X86 || PPC64)
> >>> +   # !CC_IS_CLANG:
> https://github.com/ClangBuiltLinux/linux/issues/1752>>>> +      select
> DRM_AMD_DC_DCN if (X86 || PPC64 || (ARM64 && KERNEL_MODE_NEON &&
> !CC_IS_CLANG))
> >>>     help
> >>>       Choose this option if you want to use the new display engine
> >>>       support for AMDGPU. This adds required support for Vega and
> >>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> >>> index ab0c6d191038..1743ca0a3641 100644
> >>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> >>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> >>> @@ -31,6 +31,8 @@
> >>>    #elif defined(CONFIG_PPC64)
> >>>    #include <asm/switch_to.h>
> >>>    #include <asm/cputable.h>
> >>> +#elif defined(CONFIG_ARM64)
> >>> +#include <asm/neon.h>
> >>>    #endif
> >>>    /**
> >>> @@ -99,6 +101,8 @@ void dc_fpu_begin(const char *function_name, const
> int line)
> >>>                     preempt_disable();
> >>>                     enable_kernel_fp();
> >>>             }
> >>> +#elif defined(CONFIG_ARM64)
> >>> +           kernel_neon_begin();
> >>>    #endif
> >>>     }
> >>> @@ -136,6 +140,8 @@ void dc_fpu_end(const char *function_name, const
> int line)
> >>>                     disable_kernel_fp();
> >>>                     preempt_enable();
> >>>             }
> >>> +#elif defined(CONFIG_ARM64)
> >>> +           kernel_neon_end();
> >>>    #endif
> >>>     }
> >>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> >>> index d0c6cf61c676..d4e93bed1c8e 100644
> >>> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> >>> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> >>> @@ -33,6 +33,10 @@ ifdef CONFIG_PPC64
> >>>    dml_ccflags := -mhard-float -maltivec
> >>>    endif
> >>> +ifdef CONFIG_ARM64
> >>> +dml_rcflags := -mgeneral-regs-only
> >>> +endif
> >>> +
> >>>    ifdef CONFIG_CC_IS_GCC
> >>>    ifeq ($(call cc-ifversion, -lt, 0701, y), y)
> >>>    IS_OLD_GCC = 1
> >>> @@ -55,8 +59,6 @@ frame_warn_flag := -Wframe-larger-than=2048
> >>>    endif
> >>>    CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
> >>> -
> >>> -ifdef CONFIG_DRM_AMD_DC_DCN
> >>>    CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_ccflags)
> >>>    CFLAGS_$(AMDDALPATH)/dc/dml/dcn10/dcn10_fpu.o := $(dml_ccflags)
> >>>    CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/dcn20_fpu.o := $(dml_ccflags)
> >>> @@ -88,7 +90,6 @@ CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o :=
> $(dml_ccflags)
> >>>    CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_ccflags)
> >>>    CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_ccflags)
> -Wno-tautological-compare
> >>>    CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o :=
> $(dml_rcflags)
> >>> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn2x/dcn2x.o := $(dml_rcflags)
> >>>    CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o :=
> $(dml_rcflags)
> >>>    CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20.o
> := $(dml_rcflags)
> >>>    CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o :=
> $(dml_rcflags)
> >>> @@ -105,7 +106,18 @@
> CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/display_mode_vba_util_32.o :=
> $(dml_rcf
> >>>    CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn301/dcn301_fpu.o :=
> $(dml_rcflags)
> >>>    CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_lib.o :=
> $(dml_rcflags)
> >>>    CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o  :=
> $(dml_rcflags)
> >>> -endif
> >>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn10/dcn10_fpu.o := $(dml_rcflags)
> >>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/dcn20_fpu.o := $(dml_rcflags)
> >>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/display_mode_vba_314.o :=
> $(dml_rcflags)
> >>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/display_rq_dlg_calc_314.o
> := $(dml_rcflags)
> >>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/dcn314_fpu.o :=
> $(dml_rcflags)
> >>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/dcn30_fpu.o := $(dml_rcflags)
> >>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/dcn32_fpu.o := $(dml_rcflags)
> >>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn321/dcn321_fpu.o :=
> $(dml_rcflags)
> >>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/dcn31_fpu.o := $(dml_rcflags)
> >>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn302/dcn302_fpu.o :=
> $(dml_rcflags)
> >>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn303/dcn303_fpu.o :=
> $(dml_rcflags)
> >>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o :=
> $(dml_rcflags)
> >>>    CFLAGS_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o :=
> $(dml_ccflags)
> >>>    CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o :=
> $(dml_ccflags)
> >>>    CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o :=
> $(dml_rcflags)
> >>
> >> lgtm,
> >>
> >> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> >>
> >> Nathan,
> >>
> >> If it is ok for you, I can merge this change.
> >
> > Yes, this version looks good to me, as the code can no longer be built
> > for arm64 when using clang.
> >
> > Cheers,
> > Nathan
>
> I just merged this patch to amd-staging-drm-next.
>
> Thanks
> Siqueira
>

--000000000000310c0a05ec91aeea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div>Awesome, thanks!</div><div><br><div class=3D"gmail_quote"><div dir=3D"=
ltr" class=3D"gmail_attr">Rodrigo Siqueira Jordao &lt;<a href=3D"mailto:Rod=
rigo.Siqueira@amd.com">Rodrigo.Siqueira@amd.com</a>&gt; schrieb am Do. 3. N=
ov. 2022 um 15:21:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;padding-=
left:1ex;border-left-color:rgb(204,204,204)"><br>
<br>
On 2022-11-01 12:31, Nathan Chancellor wrote:<br>
&gt; On Tue, Nov 01, 2022 at 10:36:08AM -0400, Rodrigo Siqueira Jordao wrot=
e:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On 2022-10-31 15:37, Ao Zhong wrote:<br>
&gt;&gt;&gt; After moving all FPU code to the DML folder, we can enable DCN=
 support<br>
&gt;&gt;&gt; for the ARM64 platform. Remove the -mgeneral-regs-only CFLAG f=
rom the<br>
&gt;&gt;&gt; code in the DML folder that needs to use hardware FPU, and add=
 a control<br>
&gt;&gt;&gt; mechanism for ARM Neon.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Ao Zhong &lt;<a href=3D"mailto:hacc1225@gmail.c=
om" target=3D"_blank">hacc1225@gmail.com</a>&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 drivers/gpu/drm/amd/display/Kconfig=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 ++-<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c=C2=A0 =
=C2=A0 |=C2=A0 6 ++++++<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 drivers/gpu/drm/amd/display/dc/dml/Makefile=C2=A0=
 =C2=A0| 20 +++++++++++++++----<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 3 files changed, 24 insertions(+), 5 deletions(-)=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu=
/drm/amd/display/Kconfig<br>
&gt;&gt;&gt; index 0142affcdaa3..843a55a6a3ac 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/display/Kconfig<br>
&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/display/Kconfig<br>
&gt;&gt;&gt; @@ -6,7 +6,8 @@ config DRM_AMD_DC<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0bool &quot;AMD DC - Enable new display engi=
ne&quot;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0default y<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0select SND_HDA_COMPONENT if SND_HDA_CORE<br=
>
&gt;&gt;&gt; -=C2=A0 =C2=A0select DRM_AMD_DC_DCN if (X86 || PPC64)<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0# !CC_IS_CLANG: <a href=3D"https://github.com/Cl=
angBuiltLinux/linux/issues/1752" rel=3D"noreferrer" target=3D"_blank">https=
://github.com/ClangBuiltLinux/linux/issues/1752</a>&gt;&gt;&gt;&gt; +=C2=A0=
 =C2=A0 =C2=A0 select DRM_AMD_DC_DCN if (X86 || PPC64 || (ARM64 &amp;&amp; =
KERNEL_MODE_NEON &amp;&amp; !CC_IS_CLANG))<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0help<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Choose this option if you want to us=
e the new display engine<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0support for AMDGPU. This adds requir=
ed support for Vega and<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c<br>
&gt;&gt;&gt; index ab0c6d191038..1743ca0a3641 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c<br>
&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c<br>
&gt;&gt;&gt; @@ -31,6 +31,8 @@<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 #elif defined(CONFIG_PPC64)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 #include &lt;asm/switch_to.h&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 #include &lt;asm/cputable.h&gt;<br>
&gt;&gt;&gt; +#elif defined(CONFIG_ARM64)<br>
&gt;&gt;&gt; +#include &lt;asm/neon.h&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 #endif<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 /**<br>
&gt;&gt;&gt; @@ -99,6 +101,8 @@ void dc_fpu_begin(const char *function_name=
, const int line)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0preempt_disable();<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0enable_kernel_fp();<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt; +#elif defined(CONFIG_ARM64)<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_neon_begin();=
<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 #endif<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt; @@ -136,6 +140,8 @@ void dc_fpu_end(const char *function_name,=
 const int line)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0disable_kernel_fp();<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0preempt_enable();<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt; +#elif defined(CONFIG_ARM64)<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_neon_end();<b=
r>
&gt;&gt;&gt;=C2=A0 =C2=A0 #endif<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/dri=
vers/gpu/drm/amd/display/dc/dml/Makefile<br>
&gt;&gt;&gt; index d0c6cf61c676..d4e93bed1c8e 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile<br>
&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile<br>
&gt;&gt;&gt; @@ -33,6 +33,10 @@ ifdef CONFIG_PPC64<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 dml_ccflags :=3D -mhard-float -maltivec<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 endif<br>
&gt;&gt;&gt; +ifdef CONFIG_ARM64<br>
&gt;&gt;&gt; +dml_rcflags :=3D -mgeneral-regs-only<br>
&gt;&gt;&gt; +endif<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 ifdef CONFIG_CC_IS_GCC<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 ifeq ($(call cc-ifversion, -lt, 0701, y), y)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 IS_OLD_GCC =3D 1<br>
&gt;&gt;&gt; @@ -55,8 +59,6 @@ frame_warn_flag :=3D -Wframe-larger-than=3D2=
048<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 endif<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o :=
=3D $(dml_ccflags)<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -ifdef CONFIG_DRM_AMD_DC_DCN<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_vba.o :=
=3D $(dml_ccflags)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 CFLAGS_$(AMDDALPATH)/dc/dml/dcn10/dcn10_fpu.o :=
=3D $(dml_ccflags)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/dcn20_fpu.o :=
=3D $(dml_ccflags)<br>
&gt;&gt;&gt; @@ -88,7 +90,6 @@ CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.=
o :=3D $(dml_ccflags)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o=
 :=3D $(dml_ccflags)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o=
 :=3D $(dml_ccflags) -Wno-tautological-compare<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_v=
ba.o :=3D $(dml_rcflags)<br>
&gt;&gt;&gt; -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn2x/dcn2x.o :=3D $(dml_r=
cflags)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_=
mode_vba_20.o :=3D $(dml_rcflags)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_=
rq_dlg_calc_20.o :=3D $(dml_rcflags)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_=
mode_vba_20v2.o :=3D $(dml_rcflags)<br>
&gt;&gt;&gt; @@ -105,7 +106,18 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/=
display_mode_vba_util_32.o :=3D $(dml_rcf<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn301/dcn301_=
fpu.o :=3D $(dml_rcflags)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_l=
ib.o :=3D $(dml_rcflags)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fp=
u.o=C2=A0 :=3D $(dml_rcflags)<br>
&gt;&gt;&gt; -endif<br>
&gt;&gt;&gt; +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn10/dcn10_fpu.o :=3D $(d=
ml_rcflags)<br>
&gt;&gt;&gt; +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/dcn20_fpu.o :=3D $(d=
ml_rcflags)<br>
&gt;&gt;&gt; +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/display_mode_vba_31=
4.o :=3D $(dml_rcflags)<br>
&gt;&gt;&gt; +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/display_rq_dlg_calc=
_314.o :=3D $(dml_rcflags)<br>
&gt;&gt;&gt; +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/dcn314_fpu.o :=3D $=
(dml_rcflags)<br>
&gt;&gt;&gt; +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/dcn30_fpu.o :=3D $(d=
ml_rcflags)<br>
&gt;&gt;&gt; +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/dcn32_fpu.o :=3D $(d=
ml_rcflags)<br>
&gt;&gt;&gt; +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn321/dcn321_fpu.o :=3D $=
(dml_rcflags)<br>
&gt;&gt;&gt; +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/dcn31_fpu.o :=3D $(d=
ml_rcflags)<br>
&gt;&gt;&gt; +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn302/dcn302_fpu.o :=3D $=
(dml_rcflags)<br>
&gt;&gt;&gt; +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn303/dcn303_fpu.o :=3D $=
(dml_rcflags)<br>
&gt;&gt;&gt; +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o :=3D=
 $(dml_rcflags)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 CFLAGS_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_c=
alc.o :=3D $(dml_ccflags)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helper=
s.o :=3D $(dml_ccflags)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dml1_display_r=
q_dlg_calc.o :=3D $(dml_rcflags)<br>
&gt;&gt;<br>
&gt;&gt; lgtm,<br>
&gt;&gt;<br>
&gt;&gt; Reviewed-by: Rodrigo Siqueira &lt;<a href=3D"mailto:Rodrigo.Siquei=
ra@amd.com" target=3D"_blank">Rodrigo.Siqueira@amd.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; Nathan,<br>
&gt;&gt;<br>
&gt;&gt; If it is ok for you, I can merge this change.<br>
&gt; <br>
&gt; Yes, this version looks good to me, as the code can no longer be built=
<br>
&gt; for arm64 when using clang.<br>
&gt; <br>
&gt; Cheers,<br>
&gt; Nathan<br>
<br>
I just merged this patch to amd-staging-drm-next.<br>
<br>
Thanks<br>
Siqueira<br>
</blockquote></div></div>

--000000000000310c0a05ec91aeea--
