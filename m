Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F70C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jun 2022 13:37:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D92C10E7C9;
	Mon, 13 Jun 2022 13:37:49 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A88E010E7B3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 13:37:48 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id k24so7776822oij.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 06:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0o9v/pFCY1IQ+/mWJJTYqOS2EpXFsJBmrl9j9ZzGFUA=;
 b=Dk/Dn6ZHxm/HTwdRxJ3v9kk1TmWuwvjizGAUf8ST0OoxFh62c4dKacka/co7waMxLc
 GeQs7mkBNvHBnU8TxBUq75ivn4sH7a8q0SAl9bpUH23X9mxSlvecSa/sY3JPX0aeVXhH
 oqWaDa1+HYnlKTVvGt7n+76EbLvuHCIMTWjn7N4Jl6vc6+LGjSDcgwUSNDloITTHEZB0
 QFAFaO0rMQNVxUQvPZLR3C4z2F6BKl0bbRLn7aUuJEVf011TOiEaVPRveX/tl2vCK1km
 siYzTM7UtgpznZneX9tRdsaVukrOsO6pwkIZ66SFhvEmJuHFmXGTkKxh/QtMDLXwkS4S
 pYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0o9v/pFCY1IQ+/mWJJTYqOS2EpXFsJBmrl9j9ZzGFUA=;
 b=tPH5e41l34ZjqlMdU+PoeSjI7wIxX+01hfirbZ1DM48yWyA1twRFgnretYD+jqjWdl
 lNyQxrQNX5EXFxi0D5xUb9fuXpyN+e/P/idYoRzDD1bymaeT3eyuKyeBPEH08v+eKnwt
 1cg8enfxFvcY+voFD3egpDoA985RegvV32mL4018eUGkEyiMqmL6SHvI3YIOEKy+3+8+
 0CZQURufMLVE2MIqO2hVxvv+kwIJv+orDbiO0XShK1nX7BHoDvSss4gWeOedzO94sLRn
 CZhHTpSqdh/sPgPRIgreHTx7xAdwIZB6n6hHchy52tkH2q8ke3ckc9egT6Rr7PPcCrHy
 rcqA==
X-Gm-Message-State: AOAM531vIUL0Dur3Op8n8iUFkCmdfLi67+3ZIsF21//Sh5PXkPC//zr1
 UwSaV6IbbRZ1wIJjssqwHZOq8dKdreloI3jkxfA=
X-Google-Smtp-Source: ABdhPJyoKQZ5Houbg8HkrLgLtIjv+qyfvhOownTf9f6vZkdJfKZgnH+/pwrLTXerW9YDOYkyAk/dvOSkJPZFKxxKhxA=
X-Received: by 2002:a05:6808:114f:b0:32b:1be0:2316 with SMTP id
 u15-20020a056808114f00b0032b1be02316mr6397848oiu.200.1655127467836; Mon, 13
 Jun 2022 06:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220610154247.338073-1-alexander.deucher@amd.com>
 <140c121a-f8b9-d7cc-5b77-c41e90b5829c@gmail.com>
In-Reply-To: <140c121a-f8b9-d7cc-5b77-c41e90b5829c@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Jun 2022 09:37:36 -0400
Message-ID: <CADnq5_NB4hkfviicJY4QqAj66EBF0oVHTaYnZxFZkkDu69nNrg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: make FP handling in Makefiles
 consistent
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 13, 2022 at 2:08 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 10.06.22 um 17:42 schrieb Alex Deucher:
> > Use the same pattern as the DML Makefile and while we are here
> > add a missing x86 guard around the msse flags for DCN3.2.x.
>
> IIRC the idea was to limit the whole float handling to the DML and
> remove it from the rest of the code.
>
> But not sure if that's already completed yet.

Yeah, that is the end goal, but it's not complete yet.

Alex


>
> Christian.
>
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile | 3 +--
> >   drivers/gpu/drm/amd/display/dc/dcn201/Makefile  | 1 -
> >   drivers/gpu/drm/amd/display/dc/dcn30/Makefile   | 6 ++----
> >   drivers/gpu/drm/amd/display/dc/dcn302/Makefile  | 8 +++++++-
> >   drivers/gpu/drm/amd/display/dc/dcn32/Makefile   | 5 +++--
> >   drivers/gpu/drm/amd/display/dc/dcn321/Makefile  | 5 +++--
> >   6 files changed, 16 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/=
gpu/drm/amd/display/dc/clk_mgr/Makefile
> > index c935c10b5f4f..7b505e1e9308 100644
> > --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> > @@ -180,7 +180,7 @@ CLK_MGR_DCN32 =3D dcn32_clk_mgr.o dcn32_clk_mgr_smu=
_msg.o
> >   AMD_DAL_CLK_MGR_DCN32 =3D $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn32/=
,$(CLK_MGR_DCN32))
> >
> >   ifdef CONFIG_X86
> > -CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn32/dcn32_clk_mgr.o :=3D -msse
> > +CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn32/dcn32_clk_mgr.o :=3D -mhard-floa=
t -msse
> >   endif
> >
> >   ifdef CONFIG_PPC64
> > @@ -191,7 +191,6 @@ ifdef CONFIG_CC_IS_GCC
> >   ifeq ($(call cc-ifversion, -lt, 0701, y), y)
> >   IS_OLD_GCC =3D 1
> >   endif
> > -CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn32/dcn32_clk_mgr.o :=3D -mhard-floa=
t
> >   endif
> >
> >   ifdef CONFIG_X86
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile b/drivers/g=
pu/drm/amd/display/dc/dcn201/Makefile
> > index f68038ceb1b1..96cbd4ccd344 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
> > @@ -18,7 +18,6 @@ ifdef CONFIG_CC_IS_GCC
> >   ifeq ($(call cc-ifversion, -lt, 0701, y), y)
> >   IS_OLD_GCC =3D 1
> >   endif
> > -CFLAGS_$(AMDDALPATH)/dc/dcn201/dcn201_resource.o +=3D -mhard-float
> >   endif
> >
> >   ifdef CONFIG_X86
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gp=
u/drm/amd/display/dc/dcn30/Makefile
> > index dfd77b3cc84d..c20331eb62e0 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
> > @@ -32,8 +32,8 @@ DCN30 =3D dcn30_init.o dcn30_hubbub.o dcn30_hubp.o dc=
n30_dpp.o dcn30_optc.o \
> >
> >
> >   ifdef CONFIG_X86
> > -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o :=3D -msse
> > -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o :=3D -msse
> > +CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o :=3D -mhard-float -msse
> > +CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o :=3D -mhard-float -msse
> >   endif
> >
> >   ifdef CONFIG_PPC64
> > @@ -45,8 +45,6 @@ ifdef CONFIG_CC_IS_GCC
> >   ifeq ($(call cc-ifversion, -lt, 0701, y), y)
> >   IS_OLD_GCC =3D 1
> >   endif
> > -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o +=3D -mhard-float
> > -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o +=3D -mhard-float
> >   endif
> >
> >   ifdef CONFIG_X86
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile b/drivers/g=
pu/drm/amd/display/dc/dcn302/Makefile
> > index f9561d7f97a1..e4b69ad0dde5 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
> > @@ -8,7 +8,7 @@
> >   DCN3_02 =3D dcn302_init.o dcn302_hwseq.o dcn302_resource.o
> >
> >   ifdef CONFIG_X86
> > -CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o :=3D -msse
> > +CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o :=3D -mhard-float -ms=
se
> >   endif
> >
> >   ifdef CONFIG_PPC64
> > @@ -16,6 +16,12 @@ CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o :=
=3D -mhard-float -maltivec
> >   endif
> >
> >   ifdef CONFIG_X86
> > +ifdef CONFIG_CC_IS_GCC
> > +ifeq ($(call cc-ifversion, -lt, 0701, y), y)
> > +IS_OLD_GCC =3D 1
> > +endif
> > +endif
> > +
> >   ifdef IS_OLD_GCC
> >   # Stack alignment mismatch, proceed with caution.
> >   # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-=
boundary=3D3
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile b/drivers/gp=
u/drm/amd/display/dc/dcn32/Makefile
> > index 3d09db3070f4..34f2e37b6704 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
> > @@ -16,7 +16,7 @@ DCN32 =3D dcn32_resource.o dcn32_hubbub.o dcn32_hwseq=
.o dcn32_init.o \
> >               dcn32_mpc.o
> >
> >   ifdef CONFIG_X86
> > -CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o :=3D -msse
> > +CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o :=3D -mhard-float -msse
> >   endif
> >
> >   ifdef CONFIG_PPC64
> > @@ -27,9 +27,9 @@ ifdef CONFIG_CC_IS_GCC
> >   ifeq ($(call cc-ifversion, -lt, 0701, y), y)
> >   IS_OLD_GCC =3D 1
> >   endif
> > -CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o +=3D -mhard-float
> >   endif
> >
> > +ifdef CONFIG_X86
> >   ifdef IS_OLD_GCC
> >   # Stack alignment mismatch, proceed with caution.
> >   # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-=
boundary=3D3
> > @@ -38,6 +38,7 @@ CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o +=3D -=
mpreferred-stack-boundary=3D4
> >   else
> >   CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o +=3D -msse2
> >   endif
> > +endif
> >
> >   AMD_DAL_DCN32 =3D $(addprefix $(AMDDALPATH)/dc/dcn32/,$(DCN32))
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/Makefile b/drivers/g=
pu/drm/amd/display/dc/dcn321/Makefile
> > index 5896ca303e39..e554fd6c16f2 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
> > @@ -13,7 +13,7 @@
> >   DCN321 =3D dcn321_resource.o dcn321_dio_link_encoder.o
> >
> >   ifdef CONFIG_X86
> > -CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o :=3D -msse
> > +CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o :=3D -mhard-float -ms=
se
> >   endif
> >
> >   ifdef CONFIG_PPC64
> > @@ -24,9 +24,9 @@ ifdef CONFIG_CC_IS_GCC
> >   ifeq ($(call cc-ifversion, -lt, 0701, y), y)
> >   IS_OLD_GCC =3D 1
> >   endif
> > -CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o +=3D -mhard-float
> >   endif
> >
> > +ifdef CONFIG_X86
> >   ifdef IS_OLD_GCC
> >   # Stack alignment mismatch, proceed with caution.
> >   # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-=
boundary=3D3
> > @@ -35,6 +35,7 @@ CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o +=3D=
 -mpreferred-stack-boundary=3D4
> >   else
> >   CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o +=3D -msse2
> >   endif
> > +endif
> >
> >   AMD_DAL_DCN321 =3D $(addprefix $(AMDDALPATH)/dc/dcn321/,$(DCN321))
> >
>
