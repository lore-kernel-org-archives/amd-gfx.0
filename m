Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6498C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 02:52:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34F9E10F36F;
	Thu,  5 May 2022 02:52:45 +0000 (UTC)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9E8310F36F
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 02:52:43 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 y22-20020a4acb96000000b0035eb01f5b65so514776ooq.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 May 2022 19:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WxfVMq4gTWVUgkG84ce/d0uyPc0fsGOy4UVprQB4VBo=;
 b=aMyf+ROe0AaQqywzzya1bJvSpL2BI7wX/JO0fYvXnhJoH97hl7wZsBuI6MNDfjK+gt
 S+cKDN9gNkAR0gOmTHbsCRoOiDWk3UmaFh+JsBZYXUW40qxPdZF/pNBpQUBNPVxarvwt
 vHzhkctmzDAGRjnuCKD3cd9qS5bzaYod2D4J8OUbeVziL38g5jwa+dWUkKvHduSa+jfG
 QrA+vWycHUZkh68uumRUI9sF8XalBigaCA6DVlISE2LyDw8krV611575EY7as/BUkNMI
 HhbbS4rqd5NzYWluMXUswtk+bqytSNm1AxZamL8tJD5NSAztILsGRSqtT5s9ZX3xGXyr
 e00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WxfVMq4gTWVUgkG84ce/d0uyPc0fsGOy4UVprQB4VBo=;
 b=Vmrf6VeOe8Z0biJAlR917ZfgdGTd+RSLHP9WG5zvlGEHAVAZ4WoNpRrR3SRl1PIi5U
 DKDjKUQesHte+bbwMYiectyEBjAaYpZRSjwBgJ+FfjV+gWudTvPq2gIfPVsJVlyyTXDQ
 6la8yerBPvtaNKPrUwnDgbOav/2PR28+OrG997HQE6BKdyzkVII6ifLQn6lxbyw/Tzx9
 hZdvq698Reic4y5zR8c1oNkXSd8l0QevgNfgPrat0GGZ65HoIpbiUTMd52HM+Et4Itw+
 5F8pnrWFMU0znbiVjSqO/M98p8z4oK2tlqNwNW1OhLAekeZRTvPFh8Zls+vShr3iQnDe
 u7SQ==
X-Gm-Message-State: AOAM530ieavKpoCyfZ5QzOKpduGu+n4MX+7D7azxkq2DXwMy3Br2mZ2b
 Gc9ySldULThrP1TZQTmKQvcPJKpjnCEHC4JTVMBjnui96lc=
X-Google-Smtp-Source: ABdhPJwdv+kRjKdfXMabYZ0ufOGkqxRcY0UZgJOp1GxkYJDB/vHzSr+bIc4vidDl+GwvgJQUuLx88ReGInacVUZqP+M=
X-Received: by 2002:a4a:e2ca:0:b0:35e:b623:8799 with SMTP id
 l10-20020a4ae2ca000000b0035eb6238799mr8465980oot.68.1651719162993; Wed, 04
 May 2022 19:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220503203834.1230487-1-alexander.deucher@amd.com>
 <fb2286ca-1162-93e0-daf0-6c76f2426efc@amd.com>
In-Reply-To: <fb2286ca-1162-93e0-daf0-6c76f2426efc@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 May 2022 22:52:31 -0400
Message-ID: <CADnq5_O5CiO0vW=3s6Uf3HcRnPFRO2RK6KEGbZqjwK_ofqXpjw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: handle asics with 1 SDMA instance
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Xiaojian Du <Xiaojian.Du@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 4, 2022 at 2:28 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 03.05.22 um 22:38 schrieb Alex Deucher:
> > From: Xiaojian Du <Xiaojian.Du@amd.com>
> >
> > This patch will handle asics with 1 SDMA instance.
> >
> > Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
> > Reviewed-by: Huang Rui <ray.huang@amd.com>
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/soc21.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/a=
mdgpu/soc21.c
> > index 307a1da13557..29acc5573f56 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> > @@ -252,8 +252,9 @@ static int soc21_read_register(struct amdgpu_device=
 *adev, u32 se_num,
> >       *value =3D 0;
> >       for (i =3D 0; i < ARRAY_SIZE(soc21_allowed_read_registers); i++) =
{
> >               en =3D &soc21_allowed_read_registers[i];
> > -             if (reg_offset !=3D
> > -                 (adev->reg_offset[en->hwip][en->inst][en->seg] + en->=
reg_offset))
> > +             if ((i =3D=3D 7 && (adev->sdma.num_instances =3D=3D 1)) |=
| /* some asics don't have SDMA1 */
> > +                     reg_offset !=3D
> > +                     (adev->reg_offset[en->hwip][en->inst][en->seg] + =
en->reg_offset))
>
> Hui what? Why do we filter out register reads in the low level function?

It was copied from nv.c.  The proper solution is to handle it like we
do in soc15.c:
if (adev->reg_offset[en->hwip][en->inst] &&
                    reg_offset !=3D (adev->reg_offset[en->hwip][en->inst][e=
n->seg]
                                        + en->reg_offset))
                    continue;

Alex

>
> >                       continue;
> >
> >               *value =3D soc21_get_register_value(adev,
>
