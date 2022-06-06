Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB866C43334
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 16:17:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A1E911A8DB;
	Mon,  6 Jun 2022 16:17:52 +0000 (UTC)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 057B711A8CB
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 16:17:51 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 v12-20020a4a314c000000b0041b65c7e100so1276056oog.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jun 2022 09:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=t1xpQlD5cJAeEy37XExGSr4SKHZAm3ZafwOPs0egETA=;
 b=mZIMgnvmaGxFsGCYUA1I2WyqMn9mF69wT/HAJnHDcF2b+RapclVco7DpAWodCs+u4J
 VFJ/dH08LkLuou6SfCgv8YMf+z8a7v2kh8dR5NGldo5VocFIilOaW3DhP9qHo50PNjad
 uAqpsS95dF6M+roDu42lNsWKc1vjT2mWVqN1ARDtAxm7gO8RV6J0xvZ0FvzrXgn8TJY+
 RxpLoFu/5q2EBMUj/h2oP/I9omVNnIF1rXLRRUqW+M1wY36bU/JC6QUm1TKGyimBZvbc
 fP1BmOD+sYRZHlLxt1gharRuCanPEbmCj4bnpbfDh1e2vABO7qaCvsrpHVlyUJ2Mr4WD
 sSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=t1xpQlD5cJAeEy37XExGSr4SKHZAm3ZafwOPs0egETA=;
 b=471fay2HyJZjtX684v4zj94Hu5P40yjmxTnDdIRz8vmi3lwlCN5du5eMBVFNX1jokh
 RMe1GA3+NyEHrx1rdE1lLqil7dc18woidCk14jJ1Zi4gVn2FnQBo4VPqLVCXRKv2uhHR
 V54iAF9qC0ArYrYn1/LmnsZMhITgq/FK0QAwpyzpAWuagWeCgXmLnans5r5Z2idvUy4P
 msERDGe1mmg2CHrPoDviUZlEF0L9nahVectkRD5fWIsVFD7oDWvkV5G61l5Q7tlEQbjv
 mncQbKdXij0XTgMMuSSERZLhCQvuOoPNZ2XW1F5o2Z+HjCS9Sbo6BjDkBcpei+LDYkqA
 AFVg==
X-Gm-Message-State: AOAM532xbFgKxODI/SBRhSK5sOq200vyscdKA/3+aTGUkNiF9aOhywED
 NJlWl1BCR4zhNnFOLGRvvfSWVDLTuxCZHivB4TSYuzeNsTc=
X-Google-Smtp-Source: ABdhPJwYbqZwe5tjflHvSzc3/q0iUqeCfJMUDPLMQR7sK5u5CH+Kn+EYvFXJ+jwziCYB95VAg/GvprZ0rnVpoVlz13k=
X-Received: by 2002:a4a:d858:0:b0:40e:7d54:1b98 with SMTP id
 g24-20020a4ad858000000b0040e7d541b98mr10449640oov.68.1654532270280; Mon, 06
 Jun 2022 09:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220603185042.3408844-1-Rodrigo.Siqueira@amd.com>
 <20220603185042.3408844-7-Rodrigo.Siqueira@amd.com>
 <24e1099e-bf3c-dca2-a8a9-8cd0196248a2@amd.com>
In-Reply-To: <24e1099e-bf3c-dca2-a8a9-8cd0196248a2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Jun 2022 12:17:39 -0400
Message-ID: <CADnq5_MOCk0R3hC6+Yw_e8MQtJR4MhR11wMuTUmeNacp_jOJ_g@mail.gmail.com>
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

On Mon, Jun 6, 2022 at 10:16 AM Harry Wentland <harry.wentland@amd.com> wro=
te:
>
> On 2022-06-03 14:50, Rodrigo Siqueira wrote:
> > This reverts commit 78baa3c4dfff4375b109bc5e19663a2f7fad1190.
> >
> > This commit introduced the below compilation error when using
> > allmodconfig:
> >
> > error: implicit declaration of function =E2=80=98remove_hpo_dp_link_enc=
_from_ctx=E2=80=99; did you mean =E2=80=98add_hpo_dp_link_enc_to_ctx=E2=80=
=99? [-Werror=3Dimplicit-function-declaration]
> >  2010 |   remove_hpo_dp_link_enc_from_ctx(&new_ctx->res_ctx, del_pipe, =
del_pipe->stream);
> >       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >       |   add_hpo_dp_link_enc_to_ctx
> >
> > Fixes: 78baa3c4dfff43 ("drm/amd/display: Drop unnecessary guard from DC=
 resource")
> > Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/driver=
s/gpu/drm/amd/display/dc/core/dc_resource.c
> > index 7357efb8b439..9bbdfcd6b3a4 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > @@ -2002,6 +2002,7 @@ enum dc_status dc_remove_stream_from_ctx(
> >       if (dc->res_pool->funcs->link_enc_unassign)
> >               dc->res_pool->funcs->link_enc_unassign(new_ctx, del_pipe-=
>stream);
> >
> > +#if defined(CONFIG_DRM_AMD_DC_DCN)
> >       if (is_dp_128b_132b_signal(del_pipe)) {
> >               update_hpo_dp_stream_engine_usage(
> >                       &new_ctx->res_ctx, dc->res_pool,
> > @@ -2009,6 +2010,7 @@ enum dc_status dc_remove_stream_from_ctx(
> >                       false);
> >               remove_hpo_dp_link_enc_from_ctx(&new_ctx->res_ctx, del_pi=
pe, del_pipe->stream);
>
> Wouldn't a better solution be to drop the DCN guards around
> remove_hpo_dp_link_enc_from_ctx and release_hpo_dp_link_enc?
> Not sure why those were guarded in the first place.

They were added by me in:

commit d8e4fb9112e88d8d87ffbc38fa511e7118042d4f
Author: Alex Deucher <alexander.deucher@amd.com>
Date:   Wed Jun 1 22:22:07 2022 -0400

    drm/amdgpu/display: Protect some functions with CONFIG_DRM_AMD_DC_DCN

    Protect remove_hpo_dp_link_enc_from_ctx() and release_hpo_dp_link_enc()
    with CONFIG_DRM_AMD_DC_DCN as the functions are only called from code
    that is protected by CONFIG_DRM_AMD_DC_DCN.  Fixes build fail with
    -Werror=3Dunused-function.

    Fixes: 9b0e0d433f74 ("drm/amd/display: Add dependant changes for DCN32/=
321")
    Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Reviewed-by: Harry Wentland <harry.wentland@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>

Maybe they are no longer required?

Alex


>
> Harry
>
> >       }
> > +#endif
> >
> >       if (del_pipe->stream_res.audio)
> >               update_audio_usage(
>
