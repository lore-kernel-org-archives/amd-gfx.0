Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC55CC25B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 20:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5367E10E00B;
	Wed, 16 Aug 2023 20:41:41 +0000 (UTC)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3268210E3BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 20:41:39 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-56c884e1d74so5089693eaf.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 13:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692218498; x=1692823298;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uDyj/gHei25LbKKRQlQ3FrMzpMMf6uvFGzU+lZKqsG0=;
 b=eKQfLklwUQrvXOFNHJHd0njKxGRoLaXzr7RLlp5Q5TbLjBj060fv9iMivAF1mc6IZU
 JElX/VZxGBU/RWGow9dPlg113+RBzKH0ME0ZDDToOEHWz/OugaMIjPE3whNSEAv31si7
 dZuUoXPQ20zeA0pLsKSgdSrXo7McKEWLNgU8CuM8xL9vXgO04+BfMkyMfzGW3QkDV53h
 TV/kRVsvjnMvCp0BWjl+YnPn4tQePLwWcdncz86NdNFurbC+XbtkvSAkedwFRMVC9+sM
 aokA9s0f2RxKeEkWK/wEzsPxW+l9eQfzF1VSOs8O5Lv4fwL5W20LyeAN23AZ8Hk9whEa
 EzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692218498; x=1692823298;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uDyj/gHei25LbKKRQlQ3FrMzpMMf6uvFGzU+lZKqsG0=;
 b=iai74oHMVcvXOFm0kLU5a7g5/P9P1Cxqv3i42PKrsnwVOhmSzfIJ75aDcFg8PDoq6R
 n50PbZng6GaAXBmaUHyVtYlaRrFgZ696Ovy9vjIpOWRO9mluIVtQAjOmS/IVU4OU23fO
 dTTE/hbHz4HoglIYwnwITOgaRPAQymUUYeGss5Vp+cp0zkZFlh1Q4JcwEOuZsBwP24bf
 0fuDRgm3N6JOlwtp0K5cZskM9gyuUbhGspjPfvL88684Xn1Rqxx9ohFkUlsCzyTD/8jf
 YEHQtd5M36edIvP1mpM4V1NtsYZ3q94uc7/UxyyruX2JcXyI4jPOo6GC68Yuih6RQblc
 cqVg==
X-Gm-Message-State: AOJu0Yy3uGTWvh8uvMJGyiJbaoj30w/nLvmsALjSd/CW9WgNSQ05jgNc
 0YOav6FSqzBkNsOVqTgqj9Lz2sse+VNkoioR90cAeNXDybg=
X-Google-Smtp-Source: AGHT+IGx1L9ZDhjG9Zs0q2B/knNO2x7ULWoxE5fRTtM8VQ+j3DLv3jeZIOPvN24ZPF8le/lryoll5Lcnn8Gn4dXsAtY=
X-Received: by 2002:a05:6870:d249:b0:1bb:4795:d6e4 with SMTP id
 h9-20020a056870d24900b001bb4795d6e4mr3659785oac.29.1692218498386; Wed, 16 Aug
 2023 13:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230815085710.842188-1-kenneth.feng@amd.com>
 <CADnq5_N6436Mdqz+V4er+=VFm=6O_C=i5T3R2+Nkc_eqh8uZLw@mail.gmail.com>
 <DM4PR12MB5165F86B0A31F1084FF5FC068E15A@DM4PR12MB5165.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5165F86B0A31F1084FF5FC068E15A@DM4PR12MB5165.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Aug 2023 16:41:27 -0400
Message-ID: <CADnq5_POku=d8X83iTOs-=ZthNYaShT3mg6VF1F8Es31_qa_mQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: allow the user to force BACO on smu v13.0.0/7
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Aug 15, 2023 at 9:02=E2=80=AFPM Feng, Kenneth <Kenneth.Feng@amd.com=
> wrote:
>
> [AMD Official Use Only - General]
>
> Hi Alex,
> Right, just BAMACO has its advantage for the fast resume.
> Maybe later we can further identify which sku needs to save more power vs=
 faster resume time.
> For example, mobile device can by default use BACO and desktop/workstatio=
n device can by default use BAMACO.

Well, we don't really take advantage of it at the moment.  We need to
add a check in amdgpu_device_evict_resources() and if BAMACO is
selected, we can skip evicting resources from vram.  Otherwise we
evict everything which pretty much nullifies the latency advantage of
BAMACO.  So unless we fix that, we should default to BACO to save the
extra power.

Alex

> Thanks.
>
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Wednesday, August 16, 2023 12:56 AM
> To: Feng, Kenneth <Kenneth.Feng@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amd/pm: allow the user to force BACO on smu v13.=
0.0/7
>
> Caution: This message originated from an External Source. Use proper caut=
ion when opening attachments, clicking links, or responding.
>
>
> On Tue, Aug 15, 2023 at 5:05=E2=80=AFAM Kenneth Feng <kenneth.feng@amd.co=
m> wrote:
> >
> > allow the user to force BACO on smu v13.0.0/7
> >
> > Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
>
> Acked-by: Alex Deucher <alexander.deucher@amd.com> Would it be better to =
default to BACO?  It would save more power at the expense of resume latency=
.
>
> Alex
>
>
> > ---
> >  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       | 2 +-
> >  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 3 ++-
> > drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 3 ++-
> >  3 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> > index 895cda8e6934..52e9c7611013 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> > @@ -2263,7 +2263,7 @@ int smu_v13_0_baco_set_state(struct smu_context *=
smu,
> >         if (state =3D=3D SMU_BACO_STATE_ENTER) {
> >                 ret =3D smu_cmn_send_smc_msg_with_param(smu,
> >                                                       SMU_MSG_EnterBaco=
,
> > -                                                     smu_baco->maco_su=
pport ?
> > +                                                     (smu_baco->maco_s=
upport && amdgpu_runtime_pm !=3D 1) ?
> >                                                       BACO_SEQ_BAMACO :=
 BACO_SEQ_BACO,
> >                                                       NULL);
> >         } else {
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > index a5857acee641..12ccc12657d7 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > @@ -2211,7 +2211,8 @@ static int smu_v13_0_0_baco_enter(struct
> > smu_context *smu)
> >
> >         if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev))
> >                 return smu_v13_0_baco_set_armd3_sequence(smu,
> > -                               smu_baco->maco_support ? BACO_SEQ_BAMAC=
O : BACO_SEQ_BACO);
> > +                               (smu_baco->maco_support && amdgpu_runti=
me_pm !=3D 1) ?
> > +                                       BACO_SEQ_BAMACO :
> > + BACO_SEQ_BACO);
> >         else
> >                 return smu_v13_0_baco_enter(smu);  } diff --git
> > a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > index 93b3e8fa8238..f0bcc7995983 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > @@ -2139,7 +2139,8 @@ static int smu_v13_0_7_baco_enter(struct
> > smu_context *smu)
> >
> >         if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev))
> >                 return smu_v13_0_baco_set_armd3_sequence(smu,
> > -                               smu_baco->maco_support ? BACO_SEQ_BAMAC=
O : BACO_SEQ_BACO);
> > +                               (smu_baco->maco_support && amdgpu_runti=
me_pm !=3D 1) ?
> > +                                       BACO_SEQ_BAMACO :
> > + BACO_SEQ_BACO);
> >         else
> >                 return smu_v13_0_baco_enter(smu);  }
> > --
> > 2.34.1
> >
