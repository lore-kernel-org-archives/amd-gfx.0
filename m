Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF99FED3C3
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2026 13:32:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B381710ED79;
	Fri, 24 Apr 2026 13:32:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KdRc7tXR";
	dkim-atps=neutral
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6089D10ED79
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 13:32:47 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2bda3b4318dso1022382eec.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 06:32:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777037566; cv=none;
 d=google.com; s=arc-20240605;
 b=N8W9oaOn1NP+1a/UzOe4TUg8Jt75VmKoSuW7CRJUFZJUYtDu+Tkv3rcLjPlkXV+5eW
 HcazptmzZTnejdV1SGrZaMLAhwAAu6HtPSP3s4Sk5viw+26d0bsrSa4hU7X/T/V44mJX
 jN+sE0Z2GUy1q/MzdEzgCKbnIjEGdullSE1DQ7WsjEvsga+Rjci+b586Flo6bLgLhU19
 Gbu1EgyLPRXb2QF+Ac+fr/XgDuSOrzI+y3F2/QlB98VqzYuk72xoOC8TG53Nk2P8aLHm
 XMl1ceAhc+5wZj45vq5Hyu8RhdGYmZcJGkbvqOZs7o1O35Xphs/I7xRQvL89C43GQlqK
 DlcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qrstaESlyFrz6gkzBLuEiplzloFKL0zAgAKSb46GRoE=;
 fh=7HvcuaxkCqKD7Nhi4z+N8WUESErfd3iuDHaasL+xjT4=;
 b=lHwKUwY2ZrxAYpzZ+hNxe1UFguYKaQ+hSCemSDaaJUGuazrA4kzeOdO5oAE95IA0qz
 Fb7ssFu5F7ulle+85R9LFciUR1+uF5SCWy3HtF2HjL4nnoXUTzRAIMN9HXBUIthEX8hd
 iSkC+4voQFVSrMBA28Kcga6KoWADSGLJPxuwMzOTY/N+OviUmvGkTaq/n6G0hcJp0C1Z
 TFIK3/VghGRZVOzpbg/eysGIqtGHhpDhtzdeerXR0qLoZ+gKsSictVZvb6kxwAbT5uOG
 nywKjhtnh6tehTZ0ZjhmM1y5fEkwQmZ3Ko8/iYUigmK0S9oF1tsl4B/g+53WAZRBRZir
 fJOw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777037566; x=1777642366; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qrstaESlyFrz6gkzBLuEiplzloFKL0zAgAKSb46GRoE=;
 b=KdRc7tXRsCeMc5YcTZo0XtWU3QTh77H8zxamtA/156f6Mbh4Jmro320jR9dob5ppEf
 aKDf+gY8E22dzcjTUvk/DbikTRwRvJcuUOUGNi+6fN2U4Gcpfo6GVjgJTCH7Ruq6ADau
 RpuRyxA9PfPbbcIyDeSc+cZwHuYIz1toko4ZZ5VJ4uA5tDJgTxMbrBBLyWMtPIFejGmo
 PnAVgGziWiqDE0pv9Of6F70nf61M5TNMxNMlnHrABhSJ9qFS5071cUUf9zFhx9Qvh8K9
 /OaDUuLx5vEWuHD9nWKiRoaaHkMWz2stdPAQxQ8wCvKNGkfqG1ORbxvQo4Wkq0GbCKev
 wDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777037566; x=1777642366;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qrstaESlyFrz6gkzBLuEiplzloFKL0zAgAKSb46GRoE=;
 b=mubt1ZybcwKphOhMYXsKCEPFWaL1XBSUBMLAouFhil+uZk2iNliGpc2MUzO/vqDEHg
 VVqx9OptDUqO21SbmRolGPmsG7GfDAk/xwL8zbZtD9B/Vb/a/RlFWRHs3QAMaPjP9gj9
 64isAVNiiFEbE7yvWAOwbYWsvLOWYPAbwr51T0XPcXSt7Kw842fkRak3p0Q71rWM+H5m
 r2Kf4UzK/ak+3LbPQrUoqYRWTViYtvxcRXKA/UylBLFUUbvH5nBUTKsYGFk5cy0daE23
 fm0tbpddPzod94JHnKXK2gf2x3Dd1m44GK+qpC7ICDRw90MgWFuFKCq584k7k1ZzrJw4
 /vXw==
X-Forwarded-Encrypted: i=1;
 AFNElJ91PUNvS9Mh8mxKnG/bXt6bW7sFfQmqssSEFCodR2Z/xLoW83xgvjDd7XHBL2RE9WJy55Pm2wbE@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwgmhS9ujQ/RjljaCNPQNHIK4Ko4hhcq3BGz61n8wZ5u94IUykv
 Pjq9EiasMXCRB5IegbBILbmB7NG39Qd07kNlzSBlXVXybeg+UJYPvFcVeJRB8mDJ2yfpMZAyS7J
 VuG1wd29DQSuMMX2RswDQVN97f7iaOHc=
X-Gm-Gg: AeBDiesJWiMDfpaMl60rN0nefQMVVByQ6qC3H6Z6caRQi/2WCtDq100gAPeNBFIAXFF
 c8m5hUXnZZ0BHna0zOQRLq9fSoQ3qvQfQ+Rr2jLUClEZEUXxdy1ZWm8B2zUQsfX/qhaoke450VC
 ScF0uzsqjXQwYOAwK9cpVot36tazWwVTf370qCw2ndQrs+BjYEDEPD8iDc556sYpSKw84nb4CYn
 ZQjQ7S6W+SrjN1pkbrZduLUPjvnEQ3a7XrRlB2WCSptF1KrNA2kl/Mo4bvzq8z6bHROpBsD56yx
 ks2f1cyuxCI+qOUqNVjTWOPLmzMSBu8Ror5NMUAeHa/wnZmSTjtt8ztbKF/FfE43pfYlC+OccNI
 TWTX4
X-Received: by 2002:a05:7022:2527:b0:12c:897a:5219 with SMTP id
 a92af1059eb24-12c897a58a8mr4885009c88.5.1777037566440; Fri, 24 Apr 2026
 06:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260424081955.873090-1-Jesse.Zhang@amd.com>
 <20260424081955.873090-5-Jesse.Zhang@amd.com>
 <ffd8867b-50b8-4f67-a21c-45dfd24a2ae9@amd.com>
 <CADnq5_OEraKrwjzsdacO0W4UGEJ6eszv5+S+Fk=asVJUgdBxRw@mail.gmail.com>
In-Reply-To: <CADnq5_OEraKrwjzsdacO0W4UGEJ6eszv5+S+Fk=asVJUgdBxRw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 24 Apr 2026 09:32:34 -0400
X-Gm-Features: AQROBzALciA_rQhFy97McZpU2gbDdSlpqadoL-aDXssk4eHDoeGEDAnOsVGtOq0
Message-ID: <CADnq5_PWxC5RcxfH58g+HTREzwiwFX6_UfTuz-ze2rxFgDi7Rg@mail.gmail.com>
Subject: Re: [PATCH 05/10] drm/amdgpu: add AMDGPU_INFO_SDMA_USERQ_DOORBELL
 ioctl
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org, 
 Alexander.Deucher@amd.com
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 24, 2026 at 9:27=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Fri, Apr 24, 2026 at 4:39=E2=80=AFAM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > On 4/24/26 10:18, Jesse Zhang wrote:
> > > From: "Jesse.zhang" <Jesse.zhang@amd.com>
> > >
> > > New AMDGPU_INFO query that returns a per-fpriv GEM handle for the
> > > kernel-owned BO backing the SDMA UMQ doorbell window, plus its size.
> > > Userspace mmap()s that handle through the standard
> > > AMDGPU_GEM_OP_MMAP / mmap() flow to obtain a CPU pointer to the
> > > routable doorbell BAR window; each created SDMA usermode queue's
> > > qword-slot offset inside that mapping is reported in
> > > drm_amdgpu_userq_out.sdma_doorbell_offset_bytes.
> >
> > We added the separate IOCTL for this purpose on the KFD/KGD unification=
 branch. I think we should just cherry pick that over to amd-staging-drm-ne=
xt.
> >
> > @Alex what do you think?
>
> Yes, we already have a patch for this and another fix for compute
> queues in the unification branch.  We were just waiting on mesa to
> make use of it.

It makes sense to land those patches, but the doorbell offset stuff is
part of David's VCN user queue patch set.  See:
https://lists.freedesktop.org/archives/amd-gfx/2026-February/138619.html

Alex

>
> Alex
>
> >
> > Regards,
> > Christian.
> >
> > >
> > > Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 13 +++++++++++++
> > >  include/uapi/drm/amdgpu_drm.h           | 16 ++++++++++++++++
> > >  2 files changed, 29 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_kms.c
> > > index d88e4994c8c1..dbcfbe418e42 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > @@ -1425,6 +1425,19 @@ int amdgpu_info_ioctl(struct drm_device *dev, =
void *data, struct drm_file *filp)
> > >                       return -EINVAL;
> > >               }
> > >       }
> > > +     case AMDGPU_INFO_SDMA_USERQ_DOORBELL: {
> > > +             struct drm_amdgpu_info_sdma_userq_doorbell db_info =3D =
{};
> > > +             int r;
> > > +
> > > +             r =3D amdgpu_sdma_userq_doorbell_create_handle(adev, fi=
lp,
> > > +                                                          &db_info.h=
andle,
> > > +                                                          &db_info.s=
ize_bytes);
> > > +             if (r)
> > > +                     return r;
> > > +             return copy_to_user(out, &db_info,
> > > +                                 min((size_t)size, sizeof(db_info)))
> > > +                     ? -EFAULT : 0;
> > > +     }
> > >       default:
> > >               DRM_DEBUG_KMS("Invalid request %d\n", info->query);
> > >               return -EINVAL;
> > > diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_=
drm.h
> > > index 79e8bbda046b..533be8ad8a7e 100644
> > > --- a/include/uapi/drm/amdgpu_drm.h
> > > +++ b/include/uapi/drm/amdgpu_drm.h
> > > @@ -1280,6 +1280,22 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
> > >  #define AMDGPU_INFO_GPUVM_FAULT                      0x23
> > >  /* query FW object size and alignment */
> > >  #define AMDGPU_INFO_UQ_FW_AREAS                      0x24
> > > +/*
> > > + * SDMA usermode-queue doorbell window query.  Returns a per-fpriv G=
EM
> > > + * handle for a kernel-owned BO that backs the routable SDMA doorbel=
l
> > > + * window, plus its byte size.  Userspace mmap()s the BO via the sta=
ndard
> > > + * AMDGPU_GEM_OP_MMAP / mmap() flow to get a CPU pointer; each creat=
ed
> > > + * SDMA usermode queue's slot offset inside that mapping is returned=
 in
> > > + * drm_amdgpu_userq_out.sdma_doorbell_offset_bytes.
> > > + */
> > > +#define AMDGPU_INFO_SDMA_USERQ_DOORBELL              0x25
> > > +
> > > +struct drm_amdgpu_info_sdma_userq_doorbell {
> > > +     /* Per-fpriv GEM handle for the SDMA UMQ doorbell BO. */
> > > +     __u32 handle;
> > > +     /* Byte size of the BO (=3D=3D mmappable window size). */
> > > +     __u32 size_bytes;
> > > +};
> > >
> > >  #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT       0
> > >  #define AMDGPU_INFO_MMR_SE_INDEX_MASK        0xff
> >
