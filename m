Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F096CDB482
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 18:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEBE18935C;
	Tue, 17 Oct 2023 18:02:28 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C64BF8935C
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 18:02:26 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1ea82246069so665129fac.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 11:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697565746; x=1698170546; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N4411VFYng8a8HDyhdYjQJ87gKPXTNmusC5D18lXs6s=;
 b=Z9eifuI8K+z4h18OWqx67/ilOPBojOM14r+FYzITP0MNr/YxNNUMSmHhTqe8Z1EJQV
 NdFAfb525WK5nacwhWByVC5delAiwyC3VEz0/ICe/euqUx66BS96L4LLNTh0kKDDX5FG
 RyjpimKbq7FJhTy2tF8e8ZY1U3AOcGT9dPDc2T8Xs7d9OPJ/yjg4jhMj3EHlQogfrR50
 2g1yOE6s1rigdHcgr2jTBODr+UUN/HZfueO6FA8IzTLrlIv7hZXivoqwokOldNQZKeF0
 aUVdV9qvib15PLhXXEobHl2j8k5L9ZQvpGPOofkxofUVhERkYlRAvFAqRJLenwuxrR56
 2Mcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697565746; x=1698170546;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N4411VFYng8a8HDyhdYjQJ87gKPXTNmusC5D18lXs6s=;
 b=cUBwEKvMN1e0XRrGGtQEsu43TDCcEalzL+BmcFGz6GhBEywII0RFnzBYKMUeN2gM3t
 ck3PSb+tSPGWMVu64A9SB5nArq9bg/+h9XPfXcWaMs0E0goswDrBCKbg7CfS/HLAPZYB
 tAKAe27jSztUNAnw58QUROvE29M4ayQhi4xagOoGFHDfZQ7O389rUOMZH3fTzzDNB/E9
 jxk3koMsCj+sh2oCt0eRLqx5lM2JiPKiX7CfDSDVtAL/hAh337uPIztZzUNfV3l7Z8gn
 FrJ6Uh5IWEeKEcrUyZXSOdXEeqU80UB/NqYqOKVnHkC55jk4IIvvN8VmsL+TqXjm2Nrh
 Xd1A==
X-Gm-Message-State: AOJu0YyQ6rVssfFqquK6yHa/3RrYE40PlMc9/2Bem5CAw8DFfxn/uy2P
 p4sfxGaAK4R3eUQhJVrIVkXglgByXSVlnKI6y4Q=
X-Google-Smtp-Source: AGHT+IEWhwy7nMPvdqBQrj3XNb2/fzLnp9F8pJjwtxWOPLaUknBvhhMta1zuQbN9r9f9Gn6rFIioHJiegVhhEqh0GS4=
X-Received: by 2002:a05:6871:2206:b0:1e9:bd5c:ae8b with SMTP id
 sc6-20020a056871220600b001e9bd5cae8bmr2686071oab.5.1697565745825; Tue, 17 Oct
 2023 11:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231016142031.241912-1-Rodrigo.Siqueira@amd.com>
 <20231017172231.GA2348194@dev-arch.thelio-3990X>
In-Reply-To: <20231017172231.GA2348194@dev-arch.thelio-3990X>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Oct 2023 14:02:14 -0400
Message-ID: <CADnq5_OyO9CHqahFvdnx7-8s9654udgdfhUntyxfjae+iHey0Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] Reduce stack size for DML2
To: Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Roman Li <roman.li@amd.com>,
 amd-gfx@lists.freedesktop.org, linux-next@vger.kernel.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Chaitanya Dhere <chaitanya.dhere@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Oct 17, 2023 at 1:22=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Hi Rodrigo,
>
> On Mon, Oct 16, 2023 at 08:19:16AM -0600, Rodrigo Siqueira wrote:
> > Stephen discovers a stack size issue when compiling the latest amdgpu
> > code with allmodconfig. This patchset addresses that issue by splitting
> > a large function into two smaller parts.
> >
> > Thanks
> > Siqueira
> >
> > Rodrigo Siqueira (2):
> >   drm/amd/display: Reduce stack size by splitting function
> >   drm/amd/display: Fix stack size issue on DML2
> >
> >  .../amd/display/dc/dml2/display_mode_core.c   | 3289 +++++++++--------
> >  1 file changed, 1653 insertions(+), 1636 deletions(-)
> >
> > --
> > 2.42.0
> >
>
> This series appears in -next as commit c587ee30f376 ("drm/amd/display:
> Reduce stack size by splitting function"); while it may help stack usage
> for GCC, clang still suffers. All clang versions that the kernel
> supports show a warning for dml_prefetch_check(), the following is with
> LLVM 17.0.2 from kernel.org [1].
>
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6263:=
13: error: stack frame size (2520) exceeds limit (2048) in 'dml_prefetch_ch=
eck' [-Werror,-Wframe-larger-than]
>    6263 | static void dml_prefetch_check(struct display_mode_lib_st *mode=
_lib)
>         |             ^
>
> With clang 18.0.0 (tip of tree) and 15.0.7, I see:
>
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:8277:=
6: error: stack frame size (2056) exceeds limit (2048) in 'dml_core_mode_pr=
ogramming' [-Werror,-Wframe-larger-than]
>    8277 | void dml_core_mode_programming(struct display_mode_lib_st *mode=
_lib, const struct dml_clk_cfg_st *clk_cfg)
>         |      ^
>
> For what it's worth, building with GCC 13.2.0 with a slighly lower
> -Wframe-larger-than value reveals that dml_prefetch_check() is right at
> the current limit and the stack usage of dml_core_mode_programming()
> when built with GCC is not too far of clang's, so it seems like there
> should be a more robust set of fixes, such as the ones that I have
> already done for older generations of this code.
>
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c: In f=
unction 'dml_prefetch_check':
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6705:=
1: error: the frame size of 2048 bytes is larger than 1800 bytes [-Werror=
=3Dframe-larger-than=3D]
>    6705 | }
>         | ^
>
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c: In f=
unction 'dml_core_mode_programming':
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:9893:=
1: error: the frame size of 1880 bytes is larger than 1800 bytes [-Werror=
=3Dframe-larger-than=3D]
>    9893 | } // dml_core_mode_programming
>         | ^
>
> 41012d715d5d drm/amd/display: Mark dml30's UseMinimumDCFCLK() as noinline=
 for stack usage
> 21485d3da659 drm/amd/display: Reduce number of arguments of dml31's Calcu=
lateFlipSchedule()
> 37934d4118e2 drm/amd/display: Reduce number of arguments of dml31's Calcu=
lateWatermarksAndDRAMSpeedChangeSupport()
> a3fef74b1d48 drm/amd/display: Reduce number of arguments of dml32_Calcula=
tePrefetchSchedule()
> c4be0ac987f2 drm/amd/display: Reduce number of arguments of dml32_Calcula=
teWatermarksMALLUseAndDRAMSpeedChangeSupport()
> 25ea501ed85d drm/amd/display: Reduce number of arguments of dml314's Calc=
ulateFlipSchedule()
> ca07f4f5a98b drm/amd/display: Reduce number of arguments of dml314's Calc=
ulateWatermarksAndDRAMSpeedChangeSupport()
>
> It would be really nice if these would somehow make it back to the
> original sources so that we stop going through this every time a new
> version of this code shows up. I thought that AMD has started testing
> with clang, how were these warnings not caught before the code was
> merged? If you are unable to look into these warnings, I can try to
> double back to this once I look into the other fires in -next...

Our clang CI builds are passing just fine.  It seems to be specific to
certain kernel configs.  I guess it depends on how different functions
get inlined.  This issue was reported by Stephen originally which is
how we discovered it.

Alex


Alex
