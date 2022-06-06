Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EA9C43334
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 16:00:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DD8011313C;
	Mon,  6 Jun 2022 16:00:45 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 283E011313C
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 16:00:44 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-f2bb84f9edso19642333fac.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jun 2022 09:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gVvUVsyFD+MLreqg5TGSKpKZ74EvjxKIEyK3gsExQK4=;
 b=AEKMPehlN6PoCT5OWE6JeJL5OQSFTHrGRUOlASjBDJ2IM+8mBY/TJqyu3OKxZ+VqoI
 c+9x+4MLQOTvlr671svDiw+f7XqLSz5G3YvMuR8kWHNxff6u+TGy/Y0jbxbKIQchFKh0
 i3Q042zcSeLiHUmIXqC4nqtrcGfoXxn6h8MhOi+kGM3CN6CT2WQ8z1WCnwEE7ypkaLLQ
 jWurHOVKz52DiPixV1p0f4t+hymiUmNeqqE4sIXui+c5vMJiIf6vbpcQyebVhygB20vi
 kuWV34USZxyAv9cn7Az28iuJbEZYCGnq21GuZWSlZq/5sqtM4VFQq0tSCPBqfeetDBLB
 74Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gVvUVsyFD+MLreqg5TGSKpKZ74EvjxKIEyK3gsExQK4=;
 b=CMglTcotwHckF+Fh92wGpcTSK7MvxscoCc0fvOvXYdgE8fhUVrJUJWB10w0MxCAWqn
 3IRwekmqytkRmokosMIdE3000R8JUABgRuMIWonOoA6ZSu/zxme8dIjgj1pOCFwjQe0d
 oVnGxRky2eMGc11opqc8Lmaa8oPvmqWeuLzeEpBh/w3XE+cemiqgUpA3Mc+nCcLD1ifK
 3ABF0RW5gsjdZukijGbu6h5rLVvmTW2SHuYxy/QqAZFE0jCgIqTyEpMyePZFICQ1PraM
 Wb2ZpkbEp/267rxsVLwG+rNZG/S+/wddctUjyl89yB7N1iENH+A+ZhuFo+N4s8wPWf+S
 B91w==
X-Gm-Message-State: AOAM533+6UJ9vOczTs2Td5HRVCpGmlMT2SrZco+EZZA05HVnB8OMva/d
 2EvFpb65+WkRbJEQ1dYuMsDS5GrehAfsboujQzc=
X-Google-Smtp-Source: ABdhPJxyJ/GbgSYIgmJK6795kYHjHkx3uta8yG63IMiqCrF8SkQdBBhuRksWWtiqkiNrE95xyMVUcOIduGzgnzrsxbo=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr14065099oap.253.1654531243352; Mon, 06
 Jun 2022 09:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220606154228.839904-1-alexander.deucher@amd.com>
 <20220606154228.839904-2-alexander.deucher@amd.com>
 <8eed1f30-3703-fd64-626e-ab088bbde57c@amd.com>
In-Reply-To: <8eed1f30-3703-fd64-626e-ab088bbde57c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Jun 2022 12:00:31 -0400
Message-ID: <CADnq5_PwiVGFHzPrrX6785Ln2e_GojuVpKwjjNPwxG95cihB4A@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/display: fix DCN3.2 Makefiles for non-x86
To: Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Alex Deucher <alexander.deucher@amd.com>, kernel test robot <lkp@intel.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 6, 2022 at 11:54 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2022-06-06 11:42, Alex Deucher wrote:
> > Add proper handling for PPC64.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dcn32/Makefile  | 9 ++++++++-
> >  drivers/gpu/drm/amd/display/dc/dcn321/Makefile | 9 ++++++++-
> >  2 files changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
> > index 6e0328060255..3d09db3070f4 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
> > @@ -15,12 +15,19 @@ DCN32 = dcn32_resource.o dcn32_hubbub.o dcn32_hwseq.o dcn32_init.o \
> >               dcn32_dio_stream_encoder.o dcn32_dio_link_encoder.o dcn32_hpo_dp_link_encoder.o \
> >               dcn32_mpc.o
> >
> > -CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o := -mhard-float -msse
> > +ifdef CONFIG_X86
> > +CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o := -msse
>
> Should this have an -mhard-float as well? I see that in the other
> Makefiles.
>
> The entry below only adds it for gcc, not for clang.

A bunch of the other resource Makefiles don't seem to have it.  E.g.,
drivers/gpu/drm/amd/display/dc/dcn30/Makefile
drivers/gpu/drm/amd/display/dc/dcn302/Makefile

drivers/gpu/drm/amd/display/dc/dcn201/Makefile and
drivers/gpu/drm/amd/display/dc/dml/Makefile do include it however.

Alex

>
> Harry
>
> > +endif
> > +
> > +ifdef CONFIG_PPC64
> > +CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o := -mhard-float -maltivec
> > +endif
> >
> >  ifdef CONFIG_CC_IS_GCC
> >  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
> >  IS_OLD_GCC = 1
> >  endif
> > +CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o += -mhard-float
> >  endif
> >
> >  ifdef IS_OLD_GCC
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/Makefile b/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
> > index 9b61d08700ca..5896ca303e39 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
> > @@ -12,12 +12,19 @@
> >
> >  DCN321 = dcn321_resource.o dcn321_dio_link_encoder.o
> >
> > -CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o := -mhard-float -msse
> > +ifdef CONFIG_X86
> > +CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o := -msse
> > +endif
> > +
> > +ifdef CONFIG_PPC64
> > +CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o := -mhard-float -maltivec
> > +endif
> >
> >  ifdef CONFIG_CC_IS_GCC
> >  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
> >  IS_OLD_GCC = 1
> >  endif
> > +CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o += -mhard-float
> >  endif
> >
> >  ifdef IS_OLD_GCC
>
