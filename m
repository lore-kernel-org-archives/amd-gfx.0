Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F0EFED3C3
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2026 13:27:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B3E510E3E7;
	Fri, 24 Apr 2026 13:27:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NJG/JhY+";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F15A10E3E7
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 13:27:33 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-12db2e9b5a7so129025c88.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 06:27:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777037252; cv=none;
 d=google.com; s=arc-20240605;
 b=Azls4CgvTD8NWvUXBBJgWVr1VT95S3LWQJ0Qq5pt6Hi7ugvQhkGw37BcfYH0YC08cL
 /aBdFfcSU66F0XYOCtioqreIcFHryhtv1GHBwA4ANNCvhiBwWw+yQUWlDZBdKZNTZ5Xr
 IpzxWxe3h4k/5lugnN/1DGKtKPLBOnz36eOeOhAp/NOgw1Jh8y+INB/GVoA2HRH7Kit7
 6WwHqCrWy1GU3sMZybPANzF7JqcBZxRgeuXz/KqWh5SmnOiTrkGUjXoqKNAHprvkW7EU
 BzozZnKunyiPuEZ2fwXdcega1gWCTyRWuD1tX0kE1R4oi8Rfhf7Wu/2j9R+EDWa0Aw/+
 T/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Jo1kPPCLsvbjeJDxUDKbxrU3EQnHUFO9mDC7/0i11nE=;
 fh=P9uidmKVPIQC5h9Tnr9iEOJqu7nkgIrHphHAIN8VVy8=;
 b=h2r7H6xOVB2dOSP8V3kT71Vb8ksvESV9fuxxZAQzMIQdSepSkyr11MEEdKzL4mb+B3
 XD3vSFVto2N1NZwUKmkymq22C3aWbMtZgFeTE0r3Kr4DS2sL0ItBPUYehZBLTkL2La27
 ASIb5LlMMBYR9a12zxhpeQfuWy/Hb15FLgv1Tg7cFBd4cZRj17EBDJ7VWOUFZ7n9zcoO
 1yOEIv5eyEI7ygIPcJ4VDyA4NkeJqLg95IAYQ2800vNftotlMAk8xtWDVXdRPh0iXvIZ
 8DUtGC88lKjnRLPQTWnb7MOHwctDVlbdyBdZVOJGiW8UEyNTErlBgYeCl9TnK4N9ucjR
 I4Rg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777037252; x=1777642052; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jo1kPPCLsvbjeJDxUDKbxrU3EQnHUFO9mDC7/0i11nE=;
 b=NJG/JhY+fLlPUB4lrb5eitE5Xm3PKllP+izfbObEDqDhTbIJK3Q6WAuVyAuVCWCwHG
 VUDhqWLqMzMTT0iThlaCCq6sCHhZcFVIgPR42LA2hAS84Mg/VVMyly3fcQ+XY/XtBpie
 juHU8kBm5YrZJGy1jwK80uL/KyXcdHwr4sR1cP/YE6jczzb5jgvRlHyLJ2VKHGymH7uX
 OG9TFIaU1AwNoOIR3jYUo6BJMlUuhf1HnMTeK9G75e2t/hAqudcUqlvRSNoxcIAzvfUK
 D/qqfdYEFH1qgxHWr1RlCLC6q90Y378Vz0oHsZqLQcDnhsgFqP8Mlny+iZFZBevaGfxS
 BcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777037252; x=1777642052;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jo1kPPCLsvbjeJDxUDKbxrU3EQnHUFO9mDC7/0i11nE=;
 b=QmFBnlsj+hKDpzfGvcRmRGULJy/Tn8bHADn5RpPlphMAyHQFX+u4Gs+UghM9Iqofpb
 Sw+y0RZgRj0zSRbeVN8anIDHNGSwBCCONpWtTvMfd0Rb1KwfxBQHvXHXDuTJ275+LApV
 vHWXrgRdV+kAG26FDeoD3XFBb/br1tQ95VJiWrB03L5nna94B2FTxcYHr/w4eEIgnHHR
 xej4MJE6g4tCNGoU7oVNKYFY+KHJhHQ+4sTxnlGglua2FZYHhmF8jIYDwhdfW64s5x6Z
 msqqKMipocN0Xoxojs2JmzOX3Jouy4qUrjWPyPHiEPjes7AmapfJc58f3P/0Tl1T4Osi
 DAdQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/wVpSq3MiYTr93AZjoPoQ/NJI+FFAOQnZWGRhgR7rGfAXC6On7v+hE//DUbfZhBza3JIV+gYti@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxUMwjLineK1YaUKXQ0c6I9scPln8jjnjhu9CMKrO1gcFgf8Qp8
 zn7yPUtbkbKN6X+Wcw7kUyABJurAdtVLu3bNsTxo03HiT+UJRzDNRUARpjCcKcUJa8mOYh8ZDJf
 Tp5Kg1eWFq5p/lClad0Y0NNHz2PBMnQ5V2A==
X-Gm-Gg: AeBDieslrxX6EJjIFIuNUdUuVkbJbQGqJulD3fR52HN1TMExokGIjOtXyDwrYKelCOM
 Lgqdr2NtD82WRe9S6hUuxeXCj10qCHNvnm40wmJunisPeVvktT0LkpiWmpJjlWXo757NA3VeYLV
 Pet00VU8eIvz18qPD4ziv18XyXBamReu9wHIGUSv+aN+R5MwijsjXc6MeXkElRXZ6xD39vMW8xU
 UQIs/nYLULokHCky/6PIMQ7jPhgPWQHdsEgRYKVyys6L2DICe7zXFykRVlpMALR3pI/plJXtOkK
 njrvfPct91LS2YzF0TcxF3u20Hl0TVTYQkO43b9+NhqKBGuys87ISf8X7Fr3BJLw0s3IAIl/VPt
 9aIJ/
X-Received: by 2002:a05:7022:221e:b0:12c:90f9:4da0 with SMTP id
 a92af1059eb24-12c90f94eebmr4431747c88.3.1777037251998; Fri, 24 Apr 2026
 06:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260424081955.873090-1-Jesse.Zhang@amd.com>
 <20260424081955.873090-5-Jesse.Zhang@amd.com>
 <ffd8867b-50b8-4f67-a21c-45dfd24a2ae9@amd.com>
In-Reply-To: <ffd8867b-50b8-4f67-a21c-45dfd24a2ae9@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 24 Apr 2026 09:27:19 -0400
X-Gm-Features: AQROBzB0vOKuF1Z8XUIFQ0sYmIYwsZKVH3ddwOZ_uxy_OwgkGm8v-gLjWTiBn3Y
Message-ID: <CADnq5_OEraKrwjzsdacO0W4UGEJ6eszv5+S+Fk=asVJUgdBxRw@mail.gmail.com>
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

On Fri, Apr 24, 2026 at 4:39=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 4/24/26 10:18, Jesse Zhang wrote:
> > From: "Jesse.zhang" <Jesse.zhang@amd.com>
> >
> > New AMDGPU_INFO query that returns a per-fpriv GEM handle for the
> > kernel-owned BO backing the SDMA UMQ doorbell window, plus its size.
> > Userspace mmap()s that handle through the standard
> > AMDGPU_GEM_OP_MMAP / mmap() flow to obtain a CPU pointer to the
> > routable doorbell BAR window; each created SDMA usermode queue's
> > qword-slot offset inside that mapping is reported in
> > drm_amdgpu_userq_out.sdma_doorbell_offset_bytes.
>
> We added the separate IOCTL for this purpose on the KFD/KGD unification b=
ranch. I think we should just cherry pick that over to amd-staging-drm-next=
.
>
> @Alex what do you think?

Yes, we already have a patch for this and another fix for compute
queues in the unification branch.  We were just waiting on mesa to
make use of it.

Alex

>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 13 +++++++++++++
> >  include/uapi/drm/amdgpu_drm.h           | 16 ++++++++++++++++
> >  2 files changed, 29 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_kms.c
> > index d88e4994c8c1..dbcfbe418e42 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -1425,6 +1425,19 @@ int amdgpu_info_ioctl(struct drm_device *dev, vo=
id *data, struct drm_file *filp)
> >                       return -EINVAL;
> >               }
> >       }
> > +     case AMDGPU_INFO_SDMA_USERQ_DOORBELL: {
> > +             struct drm_amdgpu_info_sdma_userq_doorbell db_info =3D {}=
;
> > +             int r;
> > +
> > +             r =3D amdgpu_sdma_userq_doorbell_create_handle(adev, filp=
,
> > +                                                          &db_info.han=
dle,
> > +                                                          &db_info.siz=
e_bytes);
> > +             if (r)
> > +                     return r;
> > +             return copy_to_user(out, &db_info,
> > +                                 min((size_t)size, sizeof(db_info)))
> > +                     ? -EFAULT : 0;
> > +     }
> >       default:
> >               DRM_DEBUG_KMS("Invalid request %d\n", info->query);
> >               return -EINVAL;
> > diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_dr=
m.h
> > index 79e8bbda046b..533be8ad8a7e 100644
> > --- a/include/uapi/drm/amdgpu_drm.h
> > +++ b/include/uapi/drm/amdgpu_drm.h
> > @@ -1280,6 +1280,22 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
> >  #define AMDGPU_INFO_GPUVM_FAULT                      0x23
> >  /* query FW object size and alignment */
> >  #define AMDGPU_INFO_UQ_FW_AREAS                      0x24
> > +/*
> > + * SDMA usermode-queue doorbell window query.  Returns a per-fpriv GEM
> > + * handle for a kernel-owned BO that backs the routable SDMA doorbell
> > + * window, plus its byte size.  Userspace mmap()s the BO via the stand=
ard
> > + * AMDGPU_GEM_OP_MMAP / mmap() flow to get a CPU pointer; each created
> > + * SDMA usermode queue's slot offset inside that mapping is returned i=
n
> > + * drm_amdgpu_userq_out.sdma_doorbell_offset_bytes.
> > + */
> > +#define AMDGPU_INFO_SDMA_USERQ_DOORBELL              0x25
> > +
> > +struct drm_amdgpu_info_sdma_userq_doorbell {
> > +     /* Per-fpriv GEM handle for the SDMA UMQ doorbell BO. */
> > +     __u32 handle;
> > +     /* Byte size of the BO (=3D=3D mmappable window size). */
> > +     __u32 size_bytes;
> > +};
> >
> >  #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT       0
> >  #define AMDGPU_INFO_MMR_SE_INDEX_MASK        0xff
>
