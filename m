Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362BEC28B30
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Mar 2025 19:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F081189EAC;
	Sun, 23 Mar 2025 19:57:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nvcp81ls";
	dkim-atps=neutral
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com
 [209.85.160.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28DC589EAC
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Mar 2025 19:57:49 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-2c1e7e318a7so720473fac.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Mar 2025 12:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742759868; x=1743364668; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aC/mrB68fVmJzWZbmYAmteSkn7GR3D0r1UJMo16eRsg=;
 b=Nvcp81lsjXJjs9gJ5iUR6iUdq/mv8pbOZIU1OoRk6a+zKfCdGeEENG65gQJGgEXmzk
 tgp3Jt9tltt0FIA+RqP+QrzAX+l5mVpRPtDiHnYYS/9jBd1zQ5vLO3BqXjaV7iELgAQB
 JkSiIRZ5UvHoahOjg9YUTY6NRL4AD0lEYnk3rJRaTH01XnfJ9sMbJF0dV9IV66ygw8o+
 9TMjLxSNW7JcBVVQF5BH2IZvgBnZXNcklRy/TEQvjnFg7sjhf9tmVQN/CD7yL5vSN2vz
 eJb6wQrLxlujheVvhOebfb/HSTp+v53SMlvznqr40Wncc2dS7U6GspwRA3si2he0k84j
 dU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742759868; x=1743364668;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aC/mrB68fVmJzWZbmYAmteSkn7GR3D0r1UJMo16eRsg=;
 b=JrxfS3i7TD2TnCQS6FiH4GsCktY6H0zeOsZJU8/YtW4RbLa5UVA44MMA5k4Z0KDQ1z
 WnFQtOtV98nlUs2yBzQZgDChcEcCmJh3rlp58PxiuF5akK3K/SC2x6H/j2vRf4inp28R
 bnSEQ9co2ZjoP83rN3wrHAZSVIivpHp8SFncUKDeEA5axLY+5aRRq97JuMU0NTtZbfMZ
 YcC+kVm7fj6cf/XgNCGGz3dKd4/zl92FeTsIuMSTaCOBRp0qkyD5MIdfpPdrJOsm6MuS
 8CkW36RbPXXpxSa1Pw/9cqVELzzDcdSyGZ0mduLfDAZ5lFP1lMBnuZsDmacpUWxYSqr4
 5rIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxRRsOOh3pH/YF2W/APn9zpYM5b8SZ7kWHcXT0FX0L0VwCGML19xBeTjSGWTK24bPrSGJgmpLD@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzAydtA3w237X8QzAYipSskrKbHDDPLAPWUe24XIOCLCm9p15Sg
 Z8aEAxibVhZw/+CFYM13EiSN6etNKAe1Rgw31v2bJ914Ju6sPzGQAkxb0PIT8lWSu4KdafWkm+u
 MWzgK3IGyTa69fBLdP1sVeKX7aqE=
X-Gm-Gg: ASbGncsvxnd/GwFR4QOtZvKbuMuatXgcQRVhk29c5PTSyT9pOcb+pFdfpgl8CqaNuhs
 PGPBUP8ql532HhzN8bECNzWLzSN+I+JkoTrJuuYXFdeThnJorq8MTyLQ19doVvRhR7xRI9Yb0mD
 bn+NFK8saFagDAz9HYAPY1OUhUDeo=
X-Google-Smtp-Source: AGHT+IHsuWj72CeJn3og0RnHMmqEyO3eVz3S6xJyOfA0lyU+HkqSNRO1ADoNU2vXvLDyZwd2JOCI3qTQBBN1Q4YkLgs=
X-Received: by 2002:a05:6870:2107:b0:29e:4ba5:4de8 with SMTP id
 586e51a60fabf-2c7802ffeeamr2229418fac.6.1742759868209; Sun, 23 Mar 2025
 12:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250317212919.1018717-1-alexander.deucher@amd.com>
 <CAAxE2A5FxaUh7vtPdqC-c_tAtSzXOjonpBBUj8=C7HDbL-pR0w@mail.gmail.com>
 <CADnq5_PiTSCfqyYDsJXcaUFABUkmg4+_VU07winkoih3H3Ln1g@mail.gmail.com>
In-Reply-To: <CADnq5_PiTSCfqyYDsJXcaUFABUkmg4+_VU07winkoih3H3Ln1g@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Sun, 23 Mar 2025 15:57:12 -0400
X-Gm-Features: AQ5f1JpssYTkIi7Pkt1TqFgeeRcBvgRl5fTv8ChfxvbZG6z-JxPC8gfuPCrBpsA
Message-ID: <CAAxE2A7+tGV_SfxA8pHUwNAnwJoZHMF7cDsbAv1TFAhcS1uTsA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add UAPI to query if user queues are supported
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 marek.olsak@amd.com, prike.liang@amd.com, sunil.khatri@amd.com
Content-Type: multipart/alternative; boundary="000000000000dfa2a0063107e666"
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

--000000000000dfa2a0063107e666
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding it into drm_amdgpu_info_device with a DRM version bump is better.

Marek

On Fri, Mar 21, 2025 at 4:54=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:

> I can move it into device_info if that's better.
>
> Alex
>
> On Fri, Mar 21, 2025 at 3:42=E2=80=AFPM Marek Ol=C5=A1=C3=A1k <maraeo@gma=
il.com> wrote:
> >
> > This is not in device_info, but it'll do.
> >
> > Reviewed-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>
> >
> > Marek
> >
> > On Mon, Mar 17, 2025 at 5:38=E2=80=AFPM Alex Deucher <alexander.deucher=
@amd.com>
> wrote:
> >>
> >> Add an INFO query to check if user queues are supported.
> >>
> >> v2: switch to a mask of IPs (Marek)
> >>
> >> Cc: marek.olsak@amd.com
> >> Cc: prike.liang@amd.com
> >> Cc: sunil.khatri@amd.com
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> ---
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 13 +++++++++++++
> >>  include/uapi/drm/amdgpu_drm.h           |  8 ++++++++
> >>  2 files changed, 21 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> >> index 3b7dfd56ccd0e..1d683c0487697 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> >> @@ -1340,6 +1340,19 @@ int amdgpu_info_ioctl(struct drm_device *dev,
> void *data, struct drm_file *filp)
> >>                         return -EINVAL;
> >>                 }
> >>         }
> >> +       case AMDGPU_INFO_UQ_SUPPORTED: {
> >> +               struct drm_amdgpu_info_uq_supported uq_supported =3D {=
};
> >> +
> >> +               if (adev->userq_funcs[AMDGPU_HW_IP_GFX])
> >> +                       uq_supported.supported |=3D (1 <<
> AMDGPU_HW_IP_GFX);
> >> +               if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE])
> >> +                       uq_supported.supported |=3D (1 <<
> AMDGPU_HW_IP_COMPUTE);
> >> +               if (adev->userq_funcs[AMDGPU_HW_IP_DMA])
> >> +                       uq_supported.supported |=3D (1 <<
> AMDGPU_HW_IP_DMA);
> >> +               ret =3D copy_to_user(out, &uq_supported,
> >> +                                  min((size_t)size,
> sizeof(uq_supported))) ? -EFAULT : 0;
> >> +               return 0;
> >> +       }
> >>         default:
> >>                 DRM_DEBUG_KMS("Invalid request %d\n", info->query);
> >>                 return -EINVAL;
> >> diff --git a/include/uapi/drm/amdgpu_drm.h
> b/include/uapi/drm/amdgpu_drm.h
> >> index 5dbd9037afe75..4b64e91002c05 100644
> >> --- a/include/uapi/drm/amdgpu_drm.h
> >> +++ b/include/uapi/drm/amdgpu_drm.h
> >> @@ -1195,6 +1195,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
> >>  #define AMDGPU_INFO_GPUVM_FAULT                        0x23
> >>  /* query FW object size and alignment */
> >>  #define AMDGPU_INFO_UQ_FW_AREAS                        0x24
> >> +/* query if user queues are supported */
> >> +#define AMDGPU_INFO_UQ_SUPPORTED               0x25
> >>
> >>  #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT 0
> >>  #define AMDGPU_INFO_MMR_SE_INDEX_MASK  0xff
> >> @@ -1572,6 +1574,12 @@ struct drm_amdgpu_info_uq_metadata {
> >>         };
> >>  };
> >>
> >> +struct drm_amdgpu_info_uq_supported {
> >> +       /** returns a mask for each IP type (1 << AMDGPU_HW_IP_*) */
> >> +       __u32   supported;
> >> +       __u32   pad;
> >> +};
> >> +
> >>  /*
> >>   * Supported GPU families
> >>   */
> >> --
> >> 2.48.1
> >>
>

--000000000000dfa2a0063107e666
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Adding it into drm_amdgpu_info_device with a DRM vers=
ion bump is better.</div><div><br></div><div>Marek</div></div><br><div clas=
s=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_att=
r">On Fri, Mar 21, 2025 at 4:54=E2=80=AFPM Alex Deucher &lt;<a href=3D"mail=
to:alexdeucher@gmail.com">alexdeucher@gmail.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">I can move it into device_in=
fo if that&#39;s better.<br>
<br>
Alex<br>
<br>
On Fri, Mar 21, 2025 at 3:42=E2=80=AFPM Marek Ol=C5=A1=C3=A1k &lt;<a href=
=3D"mailto:maraeo@gmail.com" target=3D"_blank">maraeo@gmail.com</a>&gt; wro=
te:<br>
&gt;<br>
&gt; This is not in device_info, but it&#39;ll do.<br>
&gt;<br>
&gt; Reviewed-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:marek.olsak@a=
md.com" target=3D"_blank">marek.olsak@amd.com</a>&gt;<br>
&gt;<br>
&gt; Marek<br>
&gt;<br>
&gt; On Mon, Mar 17, 2025 at 5:38=E2=80=AFPM Alex Deucher &lt;<a href=3D"ma=
ilto:alexander.deucher@amd.com" target=3D"_blank">alexander.deucher@amd.com=
</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Add an INFO query to check if user queues are supported.<br>
&gt;&gt;<br>
&gt;&gt; v2: switch to a mask of IPs (Marek)<br>
&gt;&gt;<br>
&gt;&gt; Cc: <a href=3D"mailto:marek.olsak@amd.com" target=3D"_blank">marek=
.olsak@amd.com</a><br>
&gt;&gt; Cc: <a href=3D"mailto:prike.liang@amd.com" target=3D"_blank">prike=
.liang@amd.com</a><br>
&gt;&gt; Cc: <a href=3D"mailto:sunil.khatri@amd.com" target=3D"_blank">suni=
l.khatri@amd.com</a><br>
&gt;&gt; Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deuche=
r@amd.com" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 13 +++++++++++++<b=
r>
&gt;&gt;=C2=A0 include/uapi/drm/amdgpu_drm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 8 ++++++++<br>
&gt;&gt;=C2=A0 2 files changed, 21 insertions(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt;&gt; index 3b7dfd56ccd0e..1d683c0487697 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt;&gt; @@ -1340,6 +1340,19 @@ int amdgpu_info_ioctl(struct drm_device *de=
v, void *data, struct drm_file *filp)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0case AMDGPU_INFO_UQ_SUPPORTED: {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm=
_amdgpu_info_uq_supported uq_supported =3D {};<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&=
gt;userq_funcs[AMDGPU_HW_IP_GFX])<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0uq_supported.supported |=3D (1 &lt;&lt; AMDGPU_HW_IP_GF=
X);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&=
gt;userq_funcs[AMDGPU_HW_IP_COMPUTE])<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0uq_supported.supported |=3D (1 &lt;&lt; AMDGPU_HW_IP_CO=
MPUTE);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&=
gt;userq_funcs[AMDGPU_HW_IP_DMA])<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0uq_supported.supported |=3D (1 &lt;&lt; AMDGPU_HW_IP_DM=
A);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D co=
py_to_user(out, &amp;uq_supported,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 min((size_t)size, s=
izeof(uq_supported))) ? -EFAULT : 0;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<=
br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_D=
EBUG_KMS(&quot;Invalid request %d\n&quot;, info-&gt;query);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n -EINVAL;<br>
&gt;&gt; diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdg=
pu_drm.h<br>
&gt;&gt; index 5dbd9037afe75..4b64e91002c05 100644<br>
&gt;&gt; --- a/include/uapi/drm/amdgpu_drm.h<br>
&gt;&gt; +++ b/include/uapi/drm/amdgpu_drm.h<br>
&gt;&gt; @@ -1195,6 +1195,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {<b=
r>
&gt;&gt;=C2=A0 #define AMDGPU_INFO_GPUVM_FAULT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x23<br>
&gt;&gt;=C2=A0 /* query FW object size and alignment */<br>
&gt;&gt;=C2=A0 #define AMDGPU_INFO_UQ_FW_AREAS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x24<br>
&gt;&gt; +/* query if user queues are supported */<br>
&gt;&gt; +#define AMDGPU_INFO_UQ_SUPPORTED=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00x25<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT 0<br>
&gt;&gt;=C2=A0 #define AMDGPU_INFO_MMR_SE_INDEX_MASK=C2=A0 0xff<br>
&gt;&gt; @@ -1572,6 +1574,12 @@ struct drm_amdgpu_info_uq_metadata {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt;&gt;=C2=A0 };<br>
&gt;&gt;<br>
&gt;&gt; +struct drm_amdgpu_info_uq_supported {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/** returns a mask for each IP type (1=
 &lt;&lt; AMDGPU_HW_IP_*) */<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 =C2=A0supported;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 =C2=A0pad;<br>
&gt;&gt; +};<br>
&gt;&gt; +<br>
&gt;&gt;=C2=A0 /*<br>
&gt;&gt;=C2=A0 =C2=A0* Supported GPU families<br>
&gt;&gt;=C2=A0 =C2=A0*/<br>
&gt;&gt; --<br>
&gt;&gt; 2.48.1<br>
&gt;&gt;<br>
</blockquote></div>

--000000000000dfa2a0063107e666--
