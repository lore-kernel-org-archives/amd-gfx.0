Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA7BC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 18:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E85610E21E;
	Mon,  6 Jun 2022 18:05:01 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04AF910E21E
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 18:04:59 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-f2e0a41009so20093110fac.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jun 2022 11:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=b+t/q+ADWPsrgfw+dYHRwTZezd4nPt0cu1qLI9F+Edo=;
 b=YRepWoPW0vXjKTWECG3h7zv5f6XDbLYLZgBU7gItwJjrVWK2qhUdfdYEP+K/t03YgD
 9r6DhhfEdxzWCPHVoVsCmj0+Q/8MQio+WjGE/5gBrO/Hk7lxAgxKAxFfEGjABxMO+OAs
 Ipg99Yv4LhRexfNSbQeGzqjowCtoEcn3VrZ3IerYakRAXOfJF1GaFHW79NgyqI9Saai5
 rPHfUsbhFF1YvkeluoUwKjONqAVGyQWT3zTNJTjvpPQAGXkRfRlOMUg5f0fN4xEnuE2W
 LTGO0rdOPw0OhY0DCb9kqKNqq2sBW5YheiI/KyK5qYhKS2golEBXC3BcqjX0vYCbLhjy
 AP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=b+t/q+ADWPsrgfw+dYHRwTZezd4nPt0cu1qLI9F+Edo=;
 b=pDfpyU8brpKHAWgjE7Vt/MkpnG5zt4uxOcWseDGeiY+ugGNOJiOY8GpyBNZYswa7Zm
 hZmIGqrhzd5Y1N8O/fk0c7lf18ob9K38jj6jW0GFq529rQDOSEyKp8bLUvmNXIBUy5yc
 oyIKBYCsQlRKRPgOPmGLjRUCEFI4rjPkvBbTD3dzis8tlTy9jsGXciobRXRsyYj+c8zL
 GNmMieGpJNroOBA3m+wpk5WFhzJkUMl9C1gSpZ3+oQad0rTvR8rTJl6PTYfAqNCkZJ3z
 I1flvdER8Fqx9Fw4IWtX+dq9EZuWXCp4hZgZJ1pEJ3ZQpv1ldsKWWRFBScGKvC5twUp3
 aB4g==
X-Gm-Message-State: AOAM530Xn9mjx3i3YahAxnAV10ElHQdw87kQGz4PTCNKp0+9hH41gvD9
 P2CqeK00mh2eI9kznFoupDLCk2Enu6e5s29pjfA=
X-Google-Smtp-Source: ABdhPJwhpNpxvlPl1DcYWbGUMOri108RhpxOkHallaPtB4cGuKOca6H6vmkWGPAkD8a8au60lmTIi218ip6VIV5cqjw=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr14421508oap.253.1654538699045; Mon, 06
 Jun 2022 11:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220603185042.3408844-1-Rodrigo.Siqueira@amd.com>
 <20220603185042.3408844-7-Rodrigo.Siqueira@amd.com>
 <24e1099e-bf3c-dca2-a8a9-8cd0196248a2@amd.com>
 <CADnq5_MOCk0R3hC6+Yw_e8MQtJR4MhR11wMuTUmeNacp_jOJ_g@mail.gmail.com>
 <c0e6f3d7-e1a7-4446-350c-14a499e78479@amd.com>
In-Reply-To: <c0e6f3d7-e1a7-4446-350c-14a499e78479@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Jun 2022 14:04:48 -0400
Message-ID: <CADnq5_PrB7A2gV5gsyqhkhbihMMeFSVetMp15SmWntSK94o+9A@mail.gmail.com>
Subject: Re: [PATCH 6/6] Revert "drm/amd/display: Drop unnecessary guard from
 DC resource"
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 6, 2022 at 2:02 PM Harry Wentland <harry.wentland@amd.com> wrot=
e:
>
>
>
> On 2022-06-06 12:17, Alex Deucher wrote:
> > On Mon, Jun 6, 2022 at 10:16 AM Harry Wentland <harry.wentland@amd.com>=
 wrote:
> >>
> >> On 2022-06-03 14:50, Rodrigo Siqueira wrote:
> >>> This reverts commit 78baa3c4dfff4375b109bc5e19663a2f7fad1190.
> >>>
> >>> This commit introduced the below compilation error when using
> >>> allmodconfig:
> >>>
> >>> error: implicit declaration of function =E2=80=98remove_hpo_dp_link_e=
nc_from_ctx=E2=80=99; did you mean =E2=80=98add_hpo_dp_link_enc_to_ctx=E2=
=80=99? [-Werror=3Dimplicit-function-declaration]
> >>>  2010 |   remove_hpo_dp_link_enc_from_ctx(&new_ctx->res_ctx, del_pipe=
, del_pipe->stream);
> >>>       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>>       |   add_hpo_dp_link_enc_to_ctx
> >>>
> >>> Fixes: 78baa3c4dfff43 ("drm/amd/display: Drop unnecessary guard from =
DC resource")
> >>> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> >>> ---
> >>>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/driv=
ers/gpu/drm/amd/display/dc/core/dc_resource.c
> >>> index 7357efb8b439..9bbdfcd6b3a4 100644
> >>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> >>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> >>> @@ -2002,6 +2002,7 @@ enum dc_status dc_remove_stream_from_ctx(
> >>>       if (dc->res_pool->funcs->link_enc_unassign)
> >>>               dc->res_pool->funcs->link_enc_unassign(new_ctx, del_pip=
e->stream);
> >>>
> >>> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> >>>       if (is_dp_128b_132b_signal(del_pipe)) {
> >>>               update_hpo_dp_stream_engine_usage(
> >>>                       &new_ctx->res_ctx, dc->res_pool,
> >>> @@ -2009,6 +2010,7 @@ enum dc_status dc_remove_stream_from_ctx(
> >>>                       false);
> >>>               remove_hpo_dp_link_enc_from_ctx(&new_ctx->res_ctx, del_=
pipe, del_pipe->stream);
> >>
> >> Wouldn't a better solution be to drop the DCN guards around
> >> remove_hpo_dp_link_enc_from_ctx and release_hpo_dp_link_enc?
> >> Not sure why those were guarded in the first place.
> >
> > They were added by me in:
> >
> > commit d8e4fb9112e88d8d87ffbc38fa511e7118042d4f
> > Author: Alex Deucher <alexander.deucher@amd.com>
> > Date:   Wed Jun 1 22:22:07 2022 -0400
> >
> >     drm/amdgpu/display: Protect some functions with CONFIG_DRM_AMD_DC_D=
CN
> >
> >     Protect remove_hpo_dp_link_enc_from_ctx() and release_hpo_dp_link_e=
nc()
> >     with CONFIG_DRM_AMD_DC_DCN as the functions are only called from co=
de
> >     that is protected by CONFIG_DRM_AMD_DC_DCN.  Fixes build fail with
> >     -Werror=3Dunused-function.
> >
> >     Fixes: 9b0e0d433f74 ("drm/amd/display: Add dependant changes for DC=
N32/321")
> >     Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> >     Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> >     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >     Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> >
>
> I remember your patch was needed but don't see it now. I wonder
> if someone removed the reason the guards were needed.

It might have just been a temporary bandaid due to further patches
still waiting for CI to complete.

Alex


>
> Harry
>
> > Maybe they are no longer required?
> >
> > Alex
> >
> >
> >>
> >> Harry
> >>
> >>>       }
> >>> +#endif
> >>>
> >>>       if (del_pipe->stream_res.audio)
> >>>               update_audio_usage(
> >>
>
