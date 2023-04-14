Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D648C77B72
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 21:24:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D721210E204;
	Fri, 14 Apr 2023 21:24:05 +0000 (UTC)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A284710E204
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 21:24:04 +0000 (UTC)
Received: by mail-yb1-xb31.google.com with SMTP id v7so18831697ybi.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 14:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1681507443; x=1684099443;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aor8FFyPa7gdIkOwnvWaisVAAZm2/GU4s34Z7GeS0v0=;
 b=XBZ79kSigA7uWJAGHoOMXDXL28khvIW1NRes9F9/n5Ks71Bx5L8MYaCPQtnK0xZNm2
 nEUR7BYplJdywiYdbRL8+sgyJdUFliCIlL2EcRapoAp54FAlbjL0MzaSrjBfg6kP45O0
 bjliH5pi8/G749tizmlQ/f0MKzAz8YXOQM8H1IJw7B8o+o3qxZ7z9JfcNAjDKlkDkqti
 ayDKfLTxfPOfp5Kjc1ccMyVKw6i1OXSLPALp1iGrPwNX1rbumcOanxMXhKs1kActHD94
 oKIiLfUMGiJI0VvOGNBQ+vZFHUipXt6jbpHdfyNhubrKZ1zvjxdsuTtZPMGK3JdTIvmF
 XdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681507443; x=1684099443;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aor8FFyPa7gdIkOwnvWaisVAAZm2/GU4s34Z7GeS0v0=;
 b=WnwXgnk0OnaPnM+ALw+oR8R864+NB64xAfa7dB8X0f2A+MxISkWUgS98n4h/9avjgU
 zJeE7mVRxB0/2mudqykw1XmVhDkOhaE0qFrpFQghZtTdW58R86ZegL3DsTkTmOfaLmci
 nQeuXX9i9pdTEh42IbgZJVfeJ4+R1IBPP8AYo3ng2pRlWeeQpIhPcE64QSEeHeOsE/CV
 Ero3nNWZQkRtI+VcUfwcBcZit+ROJQP9IzpBh1KVSwK1SX2l2Cwj9PqsaQMYOjUs1b9B
 aa1BQReuur/qHGzly3sJlvIorFbWwf3aPPiE2BOrWC6DvBpbrKDf5Bm/oX9x69aHFEKf
 KchQ==
X-Gm-Message-State: AAQBX9dQWVeidqzSF1emv6YU51eIB/LbzFMKMnn/hvuAU/JqR2lv7lP1
 8vZrsZfbfZ8nQPo/OLp4pf7v0bKmDpvsw0NU+ni6Ig==
X-Google-Smtp-Source: AKy350YhveCapHcpE7HNXoImIqT1NRMUD8BJ7C62DBrmDihJBWuD+4ZcnvOdHt4vDD+9cvAwgRrL0evoRhJvFWRroqs=
X-Received: by 2002:a25:d2ca:0:b0:b8f:2258:4d22 with SMTP id
 j193-20020a25d2ca000000b00b8f22584d22mr4714786ybg.2.1681507443294; Fri, 14
 Apr 2023 14:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230413142253.414333-1-bas@basnieuwenhuizen.nl>
 <20230413142253.414333-3-bas@basnieuwenhuizen.nl>
 <CADnq5_OAxFO0_7ZzkC5xoLHUzbjmv7+V37TrWUnadApv7GgOEQ@mail.gmail.com>
In-Reply-To: <CADnq5_OAxFO0_7ZzkC5xoLHUzbjmv7+V37TrWUnadApv7GgOEQ@mail.gmail.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Fri, 14 Apr 2023 23:21:39 +0200
Message-ID: <CAP+8YyFdNoDELSMhUqvVerJYiTZJ+n1jCfjBMMpt3qnOogBDmg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] drm/amdgpu: Add support for querying the max ibs
 in a submission. (v3)
To: Alex Deucher <alexdeucher@gmail.com>
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

On Fri, Apr 14, 2023 at 11:18=E2=80=AFPM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Thu, Apr 13, 2023 at 10:25=E2=80=AFAM Bas Nieuwenhuizen
> <bas@basnieuwenhuizen.nl> wrote:
> >
> > This info would be used by radv to figure out when we need to
> > split a submission into multiple submissions. radv currently has
> > a limit of 192 which seems to work for most gfx submissions, but
> > is way too high for e.g. compute or sdma.
> >
> > Userspace is available at
> > https://gitlab.freedesktop.org/bnieuwenhuizen/mesa/-/commits/ib-rejecti=
on-v3
> >
> > v3: Completely rewrote based on suggestion of making it a separate quer=
y.
> >
> > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2498
> > Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>
> Maybe a 4th patch to bump the driver version?

In the userspace I just make the query and put in some guessed values
if it errors out,  which doesn't need the driver version enumeration.

>
> Alex
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 9 +++++++++
> >  include/uapi/drm/amdgpu_drm.h           | 2 ++
> >  2 files changed, 11 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_kms.c
> > index 0efb38539d70..1a2e342af1c0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -1140,6 +1140,15 @@ int amdgpu_info_ioctl(struct drm_device *dev, vo=
id *data, struct drm_file *filp)
> >                 kfree(caps);
> >                 return r;
> >         }
> > +       case AMDGPU_INFO_MAX_IBS: {
> > +               uint32_t max_ibs[AMDGPU_HW_IP_NUM];
> > +
> > +               for (i =3D 0; i < AMDGPU_HW_IP_NUM; ++i)
> > +                       max_ibs[i] =3D amdgpu_ring_max_ibs(i);
> > +
> > +               return copy_to_user(out, max_ibs,
> > +                                   min((size_t)size, sizeof(max_ibs)))=
 ? -EFAULT : 0;
> > +       }
> >         default:
> >                 DRM_DEBUG_KMS("Invalid request %d\n", info->query);
> >                 return -EINVAL;
> > diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_dr=
m.h
> > index b6eb90df5d05..6981e59a9401 100644
> > --- a/include/uapi/drm/amdgpu_drm.h
> > +++ b/include/uapi/drm/amdgpu_drm.h
> > @@ -876,6 +876,8 @@ struct drm_amdgpu_cs_chunk_data {
> >         #define AMDGPU_INFO_VIDEO_CAPS_DECODE           0
> >         /* Subquery id: Encode */
> >         #define AMDGPU_INFO_VIDEO_CAPS_ENCODE           1
> > +/* Query the max number of IBs per gang per submission */
> > +#define AMDGPU_INFO_MAX_IBS                    0x22
> >
> >  #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT 0
> >  #define AMDGPU_INFO_MMR_SE_INDEX_MASK  0xff
> > --
> > 2.40.0
> >
