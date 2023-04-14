Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4821BC77B72
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 21:47:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38D4510EEB8;
	Fri, 14 Apr 2023 21:47:00 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A84710EEB8
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 21:46:58 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-187b51ed66fso3352486fac.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 14:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681508817; x=1684100817;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EKEY0ogz3Icq3iCgV5w8H/UrP+gItFlVck+6Sylgn1A=;
 b=qWqakAtIAvKfVOumjWh66Bp4JLF2ZaKmQlC6dEDCchX4KdYdTmJN0vBAh2ajDH9qB7
 vPQT1QB6+YnnO0Qj+Onqi3SsxIFToNwWnUfszAFlylFJ2RW3ZrDGgSIaXI3iwNhh/B70
 taJRX8eRwM3ggfw0NmaaOjO977i6yVKiSUS+CXuyuMqY68JvXYbbpulAV1evICDE+iD8
 zyZ6JbVWHEsnWMzvMNVyuuXN6A1WdU/I1yOBRoSKpzq40OwsF78BAamvCOsAzQEG0ims
 c7OT8SdlP1lClr8BfUb0MACQeG4Kp2bsrroWxie0pmRnj9hLxgTJeqJ+OvE4dmpXbA01
 qIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681508817; x=1684100817;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EKEY0ogz3Icq3iCgV5w8H/UrP+gItFlVck+6Sylgn1A=;
 b=fQcqEwIkKsRHWcHz7zuz3BKFipXc7gMi3yZls2Q+Jbp9Zj15vcQDtZ9HgEm6vR1bpn
 lvaWXletxoJHByziWLHI5AAWq3n8gS0b5eqdtrgm1y6/LDtblNbOyBvMhAnNx1GPacOl
 NdUu9iXIvao+Bgi2up4SoON4tSmxFEFpyU39G8QWoSETwIBoUAeS1A+j97+aZYbbAnPg
 WromOWZXQDnlIb/9h3vejkt/Ni9KE+PJaep2xoNx0EmSpOZGYuK4469/iSAFkqt9HQB3
 EqGXW9xCJT5ITn458DhT5lKcazBuTstcKgbQlXnfKVUeESHllKrJPdJEwIT2Ks35imqv
 ubgg==
X-Gm-Message-State: AAQBX9fgpHHUrdJiVTkSfcw337mIsqor87uk1/Q2CFLkjY1ZvBhpNVWW
 pF0800jysfJPk2+ckLuCNgnkaa22+eJG9Fq1+2s=
X-Google-Smtp-Source: AKy350av82C1CZcpMjNxTQb6t+JP+BnkrPZ6vuziqezHHPgEsZXxJG3ZYXMWM9vqcksHVrAtLe+EnJ8C52fn27OUiIQ=
X-Received: by 2002:a05:6870:f141:b0:187:a083:deb9 with SMTP id
 l1-20020a056870f14100b00187a083deb9mr2567625oac.3.1681508816990; Fri, 14 Apr
 2023 14:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230413142253.414333-1-bas@basnieuwenhuizen.nl>
 <20230413142253.414333-3-bas@basnieuwenhuizen.nl>
 <CADnq5_OAxFO0_7ZzkC5xoLHUzbjmv7+V37TrWUnadApv7GgOEQ@mail.gmail.com>
 <CAP+8YyFdNoDELSMhUqvVerJYiTZJ+n1jCfjBMMpt3qnOogBDmg@mail.gmail.com>
In-Reply-To: <CAP+8YyFdNoDELSMhUqvVerJYiTZJ+n1jCfjBMMpt3qnOogBDmg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 Apr 2023 17:46:45 -0400
Message-ID: <CADnq5_OoPjZtwQaBLsz9jmNsp3Zipj02DTTrOyQh76keS7FmYg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] drm/amdgpu: Add support for querying the max ibs
 in a submission. (v3)
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
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
Cc: alexander.deucher@amd.com, maraeo@gmail.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org, timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 14, 2023 at 5:24=E2=80=AFPM Bas Nieuwenhuizen
<bas@basnieuwenhuizen.nl> wrote:
>
> On Fri, Apr 14, 2023 at 11:18=E2=80=AFPM Alex Deucher <alexdeucher@gmail.=
com> wrote:
> >
> > On Thu, Apr 13, 2023 at 10:25=E2=80=AFAM Bas Nieuwenhuizen
> > <bas@basnieuwenhuizen.nl> wrote:
> > >
> > > This info would be used by radv to figure out when we need to
> > > split a submission into multiple submissions. radv currently has
> > > a limit of 192 which seems to work for most gfx submissions, but
> > > is way too high for e.g. compute or sdma.
> > >
> > > Userspace is available at
> > > https://gitlab.freedesktop.org/bnieuwenhuizen/mesa/-/commits/ib-rejec=
tion-v3
> > >
> > > v3: Completely rewrote based on suggestion of making it a separate qu=
ery.
> > >
> > > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2498
> > > Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> >
> > Maybe a 4th patch to bump the driver version?
>
> In the userspace I just make the query and put in some guessed values
> if it errors out,  which doesn't need the driver version enumeration.

Ok.  Applied the series.  Thanks!

Alex


>
> >
> > Alex
> >
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 9 +++++++++
> > >  include/uapi/drm/amdgpu_drm.h           | 2 ++
> > >  2 files changed, 11 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_kms.c
> > > index 0efb38539d70..1a2e342af1c0 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > @@ -1140,6 +1140,15 @@ int amdgpu_info_ioctl(struct drm_device *dev, =
void *data, struct drm_file *filp)
> > >                 kfree(caps);
> > >                 return r;
> > >         }
> > > +       case AMDGPU_INFO_MAX_IBS: {
> > > +               uint32_t max_ibs[AMDGPU_HW_IP_NUM];
> > > +
> > > +               for (i =3D 0; i < AMDGPU_HW_IP_NUM; ++i)
> > > +                       max_ibs[i] =3D amdgpu_ring_max_ibs(i);
> > > +
> > > +               return copy_to_user(out, max_ibs,
> > > +                                   min((size_t)size, sizeof(max_ibs)=
)) ? -EFAULT : 0;
> > > +       }
> > >         default:
> > >                 DRM_DEBUG_KMS("Invalid request %d\n", info->query);
> > >                 return -EINVAL;
> > > diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_=
drm.h
> > > index b6eb90df5d05..6981e59a9401 100644
> > > --- a/include/uapi/drm/amdgpu_drm.h
> > > +++ b/include/uapi/drm/amdgpu_drm.h
> > > @@ -876,6 +876,8 @@ struct drm_amdgpu_cs_chunk_data {
> > >         #define AMDGPU_INFO_VIDEO_CAPS_DECODE           0
> > >         /* Subquery id: Encode */
> > >         #define AMDGPU_INFO_VIDEO_CAPS_ENCODE           1
> > > +/* Query the max number of IBs per gang per submission */
> > > +#define AMDGPU_INFO_MAX_IBS                    0x22
> > >
> > >  #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT 0
> > >  #define AMDGPU_INFO_MMR_SE_INDEX_MASK  0xff
> > > --
> > > 2.40.0
> > >
