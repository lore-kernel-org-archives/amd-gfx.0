Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5096C77B7A
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 16:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B4DA8825E;
	Thu, 25 May 2023 16:42:19 +0000 (UTC)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A96B58825E
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 16:42:17 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-55517975c5fso388313eaf.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 09:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685032936; x=1687624936;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cztSLLsRKGwDZeD/uPpQK8WqJ5ggb0ypQoE8LNY5phE=;
 b=YadvJoCfrSHPg59ZDzIylqQ/KAx/luhWZ82SqK1vkz2DbXsh0RtpqxOeQAv6Z+u8iI
 SBKYncg0fDibyUg0B1WYrmnXokPpRShshDGQmkwf6PS6ZggDQx0wh82MCtpjks2SeWVA
 fzwqZ7CUs0Sdlr0JAzn4sOrhDL6cOEGGbeSWwyVD+tClwws/oWNhcnAbWUFxxFxFh4hH
 JuUcKXlYFB5kwA9guNBVRNUszsZXiK0CRIlN4np1hFFGbEbhhKpb8dHRndQd8ImatYE6
 6H1S+EiNFXOQrHg/uY1n0lHuNhPB72MfJqwJkIU34g1CAgSPeMDONqbCWNL4cTv33G6g
 bKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685032936; x=1687624936;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cztSLLsRKGwDZeD/uPpQK8WqJ5ggb0ypQoE8LNY5phE=;
 b=SRrYl/j4mdyF5vlbbk3Nok33rnlOJjVoqs3BaiVetv4PrhYKnYu7FTs36LCkAON9nQ
 VHxQV+/h094nkKS+/LwFC3SHbEuVKHdpymzQmpJRS4i7az22f/Kg6E51MtTOOmFwrBIG
 s01HTuCaeWTG8IUTnmsvlRGPNpbnxyDcA8FZvEdThoG77eIhyjIUj82/vVZhqiMt2sUU
 uBAJMnZ97agaBN63IlMpMHtvwxQqrQNh9gZ0zuWgcDK0ULvDNRVT9vJ4TUW8485RMupE
 mEh80zSbWTiN7QKztYj65cFcM6bb+/L26DhoIdscF+jqavFIBcGwsygqWf9ourlSE8og
 zMFA==
X-Gm-Message-State: AC+VfDw+cppsx/s3nbxk3Q90nrEmt3wx5moi3OCt6A3sC7Ky+ekLax1P
 DUdtVk/EbONOPGu8AzxaH5WQSZVIqMcUOUzGao0=
X-Google-Smtp-Source: ACHHUZ5e5uUXVPQhAKFISbYHRSFolK957VuRYu4ojEdLKfVvbighLDKW7jrgRW9g+7RmEeQpXFAa5USagEo5eRU2izY=
X-Received: by 2002:a4a:340a:0:b0:555:422a:38e9 with SMTP id
 b10-20020a4a340a000000b00555422a38e9mr6593717ooa.9.1685032936415; Thu, 25 May
 2023 09:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230519124438.365184-1-srinivasan.shanmugam@amd.com>
 <20230525152247.GA187374@dev-arch.thelio-3990X>
 <c25b9e4b-535e-801b-12c3-8d4415c321ff@amd.com>
 <20230525162911.GA552113@dev-arch.thelio-3990X>
In-Reply-To: <20230525162911.GA552113@dev-arch.thelio-3990X>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 May 2023 12:42:05 -0400
Message-ID: <CADnq5_Ndax1krkonfeBt4=iW5Kfh-nW+M_UhqVJV9gUQC2JEBw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Mark mmhub_v1_8_mmea_err_status_reg as
 __maybe_unused
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
Cc: llvm@lists.linux.dev, Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org,
 Luben Tuikov <luben.tuikov@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 25, 2023 at 12:29=E2=80=AFPM Nathan Chancellor <nathan@kernel.o=
rg> wrote:
>
> On Thu, May 25, 2023 at 12:26:56PM -0400, Luben Tuikov wrote:
> > On 2023-05-25 11:22, Nathan Chancellor wrote:
> > > On Fri, May 19, 2023 at 06:14:38PM +0530, Srinivasan Shanmugam wrote:
> > >> Silencing the compiler from below compilation error:
> > >>
> > >> drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c:704:23: error: variable 'mmh=
ub_v1_8_mmea_err_status_reg' is not needed and will not be emitted [-Werror=
,-Wunneeded-internal-declaration]
> > >> static const uint32_t mmhub_v1_8_mmea_err_status_reg[] =3D {
> > >>                       ^
> > >> 1 error generated.
> > >>
> > >> Mark the variable as __maybe_unused to make it clear to clang that t=
his
> > >> is expected, so there is no more warning.
> > >>
> > >> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > >> Cc: Lijo Lazar <lijo.lazar@amd.com>
> > >> Cc: Luben Tuikov <luben.tuikov@amd.com>
> > >> Cc: Alex Deucher <alexander.deucher@amd.com>
> > >> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> > >
> > > Traditionally, this attribute would go between the [] and =3D, but th=
at is
> > > a nit. Can someone please pick this up to unblock our builds on -next=
?
> > >
> > > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> >
> > I'll pick this up, fix it, and submit to amd-staging-drm-next.
>
> Thanks a lot :)
>
> > Which -next are you referring to, Nathan?
>
> linux-next, this warning breaks the build when -Werror is enabled, such
> as with allmodconfig:
>
> https://storage.tuxsuite.com/public/clangbuiltlinux/continuous-integratio=
n2/builds/2QHtlCTz2JL0yXNpRB5hVmiP9lq/build.log
>

Srinivasan has already pushed it.  I'll push it out once CI has
completed.  We are trying to figure out the best way to enable -WERROR
in our CI system as it is almost always broken depending on what
compiler you are using.  Also, I'm not sure fixing these is always
better.  A lot of these warnings seem spurious and in a lot of cases
the "fix" doesn't really improve the code, it just silences a warning.
As one of my coworkers put it, there is a reason warnings are not
errors.

Alex


> Cheers,
> Nathan
>
> > >> ---
> > >>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 1 +
> > >>  1 file changed, 1 insertion(+)
> > >>
> > >> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/d=
rm/amd/amdgpu/mmhub_v1_8.c
> > >> index 3648994724c2..cba087e529c0 100644
> > >> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> > >> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> > >> @@ -701,6 +701,7 @@ static void mmhub_v1_8_reset_ras_error_count(str=
uct amdgpu_device *adev)
> > >>            mmhub_v1_8_inst_reset_ras_error_count(adev, i);
> > >>  }
> > >>
> > >> +__maybe_unused
> > >>  static const uint32_t mmhub_v1_8_mmea_err_status_reg[] =3D {
> > >>    regMMEA0_ERR_STATUS,
> > >>    regMMEA1_ERR_STATUS,
> > >> --
> > >> 2.25.1
> > >>
> >
