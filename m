Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB540C761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 18:48:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BB5810EF93;
	Thu, 30 Mar 2023 18:48:50 +0000 (UTC)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 422F110EF93
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 18:48:48 +0000 (UTC)
Received: by mail-ua1-x92c.google.com with SMTP id h34so14532999uag.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 11:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680202127;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UNoWGnhKr86ZnoqUN5wbEJERqQq6pHDtg+fvOlrxg2U=;
 b=R7cwJ7BLWZ1StzTczgFqWhvpGN/t5o78YITsiDFIKT2bSJwydE5WpZf8xHikJjKVq8
 EOKMpldRe4hdBCSmcW7DyoWfP6WNUEl4LyfXwQQ/vn3o7OStrFtEBb/XMmn5UpZrEYbC
 /EnkKAyIXOBZjbFGHou7r4D/2WhXHgP0HmtaSs3wcZedmsacrguB5hV5kdQl7SYnmzLY
 wR35M+vNfBH2C9yUbC3FAH06nscT395rlvcvHLtgCOYsbVVOBkUn5b9hAt25Ar3LWE+V
 e/fKx+EvhneiT7ttJtnJJluBOWThuyX4zGbjxQirJBULxbU5wCw+54yE+qBLUsdlUSE6
 qDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680202127;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UNoWGnhKr86ZnoqUN5wbEJERqQq6pHDtg+fvOlrxg2U=;
 b=eWMqJEOWBc+itxSdPgf3+dLXWkJlTuJNI6pzsF0i3gDkvbnAn3Lr0TBVvqgG/G8HXR
 rSc5S4Q7T/jDBTVPzxPOFw2fvqMC0TFObI97aUTBnzcVLnEcD9Wp6c+HsEI5Wt7PANe1
 /My0DsLNYE4TkaSDMxe25hC37tTC9rYTVr1mmPnPgyHZhZZsHkC013XE5TUX3h/Baprn
 mq1Eni+BgyEUSZg2GuRt2BxglrIS+0omUROXgf+ZQvqjjq+Vmbsu5d7p/PwRU8aqyFtW
 Oc4BguA8N0wt/KQBygb1VDIYA98SUwhchVz9PygTZNjcsAxT9cWxZtkDsgVlZsks9oEW
 M6Qg==
X-Gm-Message-State: AAQBX9fHo4X0qHry8DORtjPMtwF1M0cNdYbX9UA2ZeYkXvfG3p8aYvFR
 0ixpQvG4nNXncOcdh94jUCKcExLyhYZXwmqqwCcXkt2v
X-Google-Smtp-Source: AKy350YR1ZmXUofDWrlyzJQ7nwGLJNCDsd/c65JhtWlwyo+9vFIxMwljiyV3rhcxTPJHuKJi6p7q1Z5x+2qUYm+/1qI=
X-Received: by 2002:a1f:3890:0:b0:432:911c:d523 with SMTP id
 f138-20020a1f3890000000b00432911cd523mr13338303vka.1.1680202127200; Thu, 30
 Mar 2023 11:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230329152521.1980681-1-alexander.deucher@amd.com>
 <20230329152521.1980681-10-alexander.deucher@amd.com>
 <e0800275-c356-bbad-ac5a-c92cf0d14c35@gmail.com>
In-Reply-To: <e0800275-c356-bbad-ac5a-c92cf0d14c35@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Mar 2023 14:48:35 -0400
Message-ID: <CADnq5_M-UED9corfWFQxw0dbq9nBH64s8dQV0Z1Gnac6WhnF6g@mail.gmail.com>
Subject: Re: [PATCH 09/13] drm/amdgpu: add get_gfx_shadow_info callback for
 gfx11
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 30, 2023 at 2:16=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 29.03.23 um 17:25 schrieb Alex Deucher:
> > Used to get the size and alignment requirements for
> > the gfx shadow buffer for preemption.
> >
> > v2: use FW version check to determine whether to
> >      return a valid size here
> >      return an error if not supported (Alex)
> > v3: drop GDS (Alex)
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 25 +++++++++++++++++++++++++
> >   1 file changed, 25 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v11_0.c
> > index 1fc1e941f7df..df2eabf50e6e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > @@ -822,6 +822,30 @@ static void gfx_v11_0_select_me_pipe_q(struct amdg=
pu_device *adev,
> >       soc21_grbm_select(adev, me, pipe, q, vm);
> >   }
> >
> > +/* all sizes are in bytes */
> > +#define MQD_SHADOW_BASE_SIZE      73728
> > +#define MQD_SHADOW_BASE_ALIGNMENT 256
> > +#define MQD_FWWORKAREA_SIZE       484
> > +#define MQD_FWWORKAREA_ALIGNMENT  256
> > +
> > +static int gfx_v11_0_get_gfx_shadow_info(struct amdgpu_device *adev,
> > +                                      struct amdgpu_gfx_shadow_info *s=
hadow_info)
> > +{
> > +     if (shadow_info) {
>
> Why would anybody call this without parameter?

They shouldn't.  I'll drop it.

Alex

>
> Christian.
>
> > +             if (adev->gfx.cp_gfx_shadow) {
> > +                     shadow_info->shadow_size =3D MQD_SHADOW_BASE_SIZE=
;
> > +                     shadow_info->shadow_alignment =3D MQD_SHADOW_BASE=
_ALIGNMENT;
> > +                     shadow_info->csa_size =3D MQD_FWWORKAREA_SIZE;
> > +                     shadow_info->csa_alignment =3D MQD_FWWORKAREA_ALI=
GNMENT;
> > +                     return 0;
> > +             } else {
> > +                     memset(shadow_info, 0, sizeof(struct amdgpu_gfx_s=
hadow_info));
> > +                     return -ENOTSUPP;
> > +             }
> > +     }
> > +     return -EINVAL;
> > +}
> > +
> >   static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs =3D {
> >       .get_gpu_clock_counter =3D &gfx_v11_0_get_gpu_clock_counter,
> >       .select_se_sh =3D &gfx_v11_0_select_se_sh,
> > @@ -830,6 +854,7 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_=
funcs =3D {
> >       .read_wave_vgprs =3D &gfx_v11_0_read_wave_vgprs,
> >       .select_me_pipe_q =3D &gfx_v11_0_select_me_pipe_q,
> >       .update_perfmon_mgcg =3D &gfx_v11_0_update_perf_clk,
> > +     .get_gfx_shadow_info =3D &gfx_v11_0_get_gfx_shadow_info,
> >   };
> >
> >   static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
>
