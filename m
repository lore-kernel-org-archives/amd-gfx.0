Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DC2C77B61
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Apr 2023 12:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE49410E1E7;
	Sat,  8 Apr 2023 12:39:01 +0000 (UTC)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AAAE10EE44
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Apr 2023 18:30:07 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-23f8be2d34eso219948a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Apr 2023 11:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20210112; t=1680892206; x=1683484206;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6HFtEQBBSrqrPLBtxkiSj0n1tTAIZHxJ4QeL5qxREtA=;
 b=O1wwHa9VLQNTHqqJ/D+SH5M1jhXYC4VHWJ3i1l2T8RfxHmu1tlSsZjw6xpCFpC/sE5
 2OmAe9WoxEaCC9T6IXmDpBliDHN2t0iizQAbdFWvizz9Rnw2XjrlljslXIkmXDCSXTcG
 Q+ZW0ZQnNgmHUpUmt3jpBZnoLqKfKzfmwiccwXsFzQaS2tuROvBmdFXhUCHdAr6HqQTE
 7Yd/82l3J9kPU8xJQp0EYOi94CrJH1itSa+lU8FuIIfjTU7db4H63Wmr4QTCtAKOhviu
 xt7UCiyU7+nzOuYmgLyqJApOlL3e7l+3d5zqjwteUcj0RsrVKH7GJOp3gBJmrf1EOkJ/
 kqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680892206; x=1683484206;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6HFtEQBBSrqrPLBtxkiSj0n1tTAIZHxJ4QeL5qxREtA=;
 b=Wu8rpnn3UXxOzaNSMQ31ThYCS6x87CmKGE/xSjA1Ema/fpbK0x+K6Re46Gt0fHT6XY
 /aqaJ2kUOF4LL7IU0xE7C1RRAWOxXwB5+TrxjfYLhhQ/iss/a99PGwBwpR9ZoiTOAmSa
 dEh9FjV9UwphGvMFvElTx0h/7N0CwaejNta+XpDfbPTSwz57MGv2gHu6uTWuWn6K0EaD
 tOwZwEZQsZKo690Eh9AikYEVnwhJKirTy1MNUUrYh21crQN42vGut8+/SPp/SovXTxBM
 a4MQBlnrv+A80ghWwoFhwyHxD9t8W2oZ8v6i6dQpzhwD0lruxO4OjID1uhsgDAOyzCYN
 Jflw==
X-Gm-Message-State: AAQBX9fQbqQogO02h9Nl8IFPavgk3Yv1Wh4P20iKypKxKwsBlLEGAkky
 /es9DYPlPv7OtqhLOOb8ssrSWi+CU24Iz3W/NsOVGg==
X-Google-Smtp-Source: AKy350Zn9nhE87iZkJPFl7414s8bVyJul5VukIyzyCsiFEtRHapVK5V9N1ZeYdKb2AlkJUj1xE94rcNxMRPPdz4DjIU=
X-Received: by 2002:a05:6a00:2e23:b0:62a:d87a:a375 with SMTP id
 fc35-20020a056a002e2300b0062ad87aa375mr1663621pfb.4.1680892206429; Fri, 07
 Apr 2023 11:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230325134503.1335510-1-trix@redhat.com>
 <CAKwvOdng_wH8qKnnGN=VpUhLK9q6wyc7sZKO7ORt-3QOKVP_nw@mail.gmail.com>
In-Reply-To: <CAKwvOdng_wH8qKnnGN=VpUhLK9q6wyc7sZKO7ORt-3QOKVP_nw@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 7 Apr 2023 11:29:55 -0700
Message-ID: <CAKwvOd=CVq3DTPwUgDgghJBKsUKgL69K7Hne5=gY9V7vwshfAg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove unused matching_stream_ptrs
 variable
To: Tom Rix <trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 08 Apr 2023 12:39:00 +0000
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
Cc: Cruise.Hung@amd.com, llvm@lists.linux.dev, sunpeng.li@amd.com,
 airlied@gmail.com, Xinhui.Pan@amd.com, Rodrigo.Siqueira@amd.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 wenjing.liu@amd.com, nathan@kernel.org, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, alexander.deucher@amd.com, Jun.Lei@amd.com,
 harry.wentland@amd.com, christian.koenig@amd.com, Jimmy.Kizito@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 7, 2023 at 10:52=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Jimmy, can you review?
>
> The change LGTM; but I'm not sure if there was something else intended he=
re.

Nevermind, Jimmy's email address bounced.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> On Sat, Mar 25, 2023 at 6:45=E2=80=AFAM Tom Rix <trix@redhat.com> wrote:
> >
> > clang with W=3D1 reports
> > drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_enc_cfg.c:625:6: =
error:
> >   variable 'matching_stream_ptrs' set but not used [-Werror,-Wunused-bu=
t-set-variable]
> >         int matching_stream_ptrs =3D 0;
> >             ^
> > This variable is not used so remove it.
> >
> > Signed-off-by: Tom Rix <trix@redhat.com>
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/dr=
ivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
> > index 41198c729d90..30c0644d4418 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
> > @@ -622,7 +622,6 @@ bool link_enc_cfg_validate(struct dc *dc, struct dc=
_state *state)
> >         int i, j;
> >         uint8_t valid_count =3D 0;
> >         uint8_t dig_stream_count =3D 0;
> > -       int matching_stream_ptrs =3D 0;
> >         int eng_ids_per_ep_id[MAX_PIPES] =3D {0};
> >         int ep_ids_per_eng_id[MAX_PIPES] =3D {0};
> >         int valid_bitmap =3D 0;
> > @@ -645,9 +644,7 @@ bool link_enc_cfg_validate(struct dc *dc, struct dc=
_state *state)
> >                 struct link_enc_assignment assignment =3D state->res_ct=
x.link_enc_cfg_ctx.link_enc_assignments[i];
> >
> >                 if (assignment.valid) {
> > -                       if (assignment.stream =3D=3D state->streams[i])
> > -                               matching_stream_ptrs++;
> > -                       else
> > +                       if (assignment.stream !=3D state->streams[i])
> >                                 valid_stream_ptrs =3D false;
> >                 }
> >         }
> > --
> > 2.27.0
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Thanks,
~Nick Desaulniers
