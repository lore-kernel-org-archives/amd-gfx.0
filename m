Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F417DC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 22:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E7EF10E592;
	Tue, 15 Feb 2022 22:31:14 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 065EC10E5A0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 22:31:13 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 f11-20020a4abb0b000000b002e9abf6bcbcso439638oop.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 14:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/7raSjc8QbAjtU9uWq/Z0TpUzi3K0+IoF2oSrKWrorU=;
 b=jD3/vnBIQpWNKxOvkROOP4KWxzgOLcDMDmzd+ywJBZKslEBJPIZTPnRobVhR7d4vs1
 l1OP1Mkls4od9HePVrRd8uL4SNpEDG5nmga5arOlinu9F+8gZKMzlqTpp7OlfqrOJDYK
 +3wwa9zDfH9GCmmK61pyknAbLDySJY1n6I+huhQoyOMafcEKzAJvpGo3OPDkM4YPxTAN
 t/SUGnTAEbSms4RBKsVOV1vehvsEKti8TME3KJ1eGQJnPxrQGdBabt52gjQTv1zkUF8+
 tExFjwEX3OUpPUtavlu/Ns51SnyK++TiuUvzxpSmUl9pzKYg0DeNp/vGZSi5p7TLsSSi
 ScCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/7raSjc8QbAjtU9uWq/Z0TpUzi3K0+IoF2oSrKWrorU=;
 b=Uclg+y5pAcWKNUeyY01RpS2Kp846fzRPRZALlacEB4s/mSjlhNrhvg/LMuoxEIBlHx
 /vduAkW6COWvv1WvpnApH/Po5+nSwzebCU00TAAwbF0AviWx0t6nHpY51/DZpXOMSlrE
 fdHy0CUAfjoo7bKjgQxmWpuBI9i5VG9WQVjWuBFYElFJhZcO4m2TPVX2X67BY7EQZGSd
 ydJVGMW5Eax2AHzQ5a/SanCND9KF8Ua3yD/xotuoIxo9KQQs05Kqgc2r+VSMBoXcdScp
 6WBz4VpT+MS/oJRHrI57Z3Ud1YIn8G2fod8S7qULdEQLsGtQVLIBTofoRM3PU1oDtrkm
 o6WQ==
X-Gm-Message-State: AOAM533cemOJfHRp2Mgid+sT9nkr4a1lsiNsQfCwOPpTADWrXYsaG4ND
 YxMo04Y7487F09ippZfD48DtLb43LciEmYQ/x18=
X-Google-Smtp-Source: ABdhPJxEjQyMWZhwTEmyxIT+3L0vWJ0jaaeiN0PXH6ZfE4Y60j8na+UHUt978e+F2mpeN5CMU5H5NSDmkoNO9KAn7s0=
X-Received: by 2002:a05:6870:912c:b0:d3:44be:7256 with SMTP id
 o44-20020a056870912c00b000d344be7256mr28092oae.73.1644964272254; Tue, 15 Feb
 2022 14:31:12 -0800 (PST)
MIME-Version: 1.0
References: <20220215185337.1873778-1-michel@daenzer.net>
 <a23eda9f-f1a9-4884-360e-d8d22d3b81f6@amd.com>
In-Reply-To: <a23eda9f-f1a9-4884-360e-d8d22d3b81f6@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Feb 2022 17:31:01 -0500
Message-ID: <CADnq5_N4=P2giYtsEhhYx6LtUDUH5EagVURt3Evq02UNcSnGnw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: For vblank_disable_immediate, check PSR
 is really used
To: Harry Wentland <harry.wentland@amd.com>
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
Cc: Leo Li <sunpeng.li@amd.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Tue, Feb 15, 2022 at 2:41 PM Harry Wentland <harry.wentland@amd.com> wro=
te:
>
> On 2022-02-15 13:53, Michel D=C3=A4nzer wrote:
> > From: Michel D=C3=A4nzer <mdaenzer@redhat.com>
> >
> > Even if PSR is allowed for a present GPU, there might be no eDP link
> > which supports PSR.
> >
> > Fixes: 9b510908e420 ("drm/amdgpu/display: Only set vblank_disable_immed=
iate when PSR is not enabled")
> > Signed-off-by: Michel D=C3=A4nzer <mdaenzer@redhat.com>
>
> Looks reasonable to me.
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 17 +++++++++--------
> >  1 file changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index cd8b0d9eb19c..df86517dd532 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -4256,6 +4256,9 @@ static int amdgpu_dm_initialize_drm_device(struct=
 amdgpu_device *adev)
> >       }
> >  #endif
> >
> > +     /* Disable vblank IRQs aggressively for power-saving. */
> > +     adev_to_drm(adev)->vblank_disable_immediate =3D true;
> > +
> >       /* loops over all connectors on the board */
> >       for (i =3D 0; i < link_cnt; i++) {
> >               struct dc_link *link =3D NULL;
> > @@ -4301,19 +4304,17 @@ static int amdgpu_dm_initialize_drm_device(stru=
ct amdgpu_device *adev)
> >                               update_connector_ext_caps(aconnector);
> >                       if (psr_feature_enabled)
> >                               amdgpu_dm_set_psr_caps(link);
> > +
> > +                     /* TODO: Fix vblank control helpers to delay PSR =
entry to allow this when
> > +                      * PSR is also supported.
> > +                      */
> > +                     if (link->psr_settings.psr_feature_enabled)
> > +                             adev_to_drm(adev)->vblank_disable_immedia=
te =3D false;
> >               }
> >
> >
> >       }
> >
> > -     /*
> > -      * Disable vblank IRQs aggressively for power-saving.
> > -      *
> > -      * TODO: Fix vblank control helpers to delay PSR entry to allow t=
his when PSR
> > -      * is also supported.
> > -      */
> > -     adev_to_drm(adev)->vblank_disable_immediate =3D !psr_feature_enab=
led;
> > -
> >       /* Software is initialized. Now we can register interrupt handler=
s. */
> >       switch (adev->asic_type) {
> >  #if defined(CONFIG_DRM_AMD_DC_SI)
>
