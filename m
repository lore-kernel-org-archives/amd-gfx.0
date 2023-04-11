Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5BC0C76196
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 08:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C41D10E4E3;
	Tue, 11 Apr 2023 08:25:18 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5D2510E4E3
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 08:25:15 +0000 (UTC)
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5491fa028adso468114477b3.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 01:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1681201514; x=1683793514;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QBtAXgK5nNY+kGkO+cIyzf6n/gwhb6ien07NFnADZ+U=;
 b=JsCL6RX2/kVAD+Y6gvZcGFO3kBE7+PVdGVIMq1JuhgtUGu9ZcWHftqlzk6aXYjsLR4
 jaKSepebm/wFwZAsYKJLt4+acy/BrjwE8pgIfqo9GeMkNsAQ7QQuc0I445GKNdDrpOns
 7PnRn4io6lBPdKPNADbuW2C58XgMXzED5WHKmH2Tjly0SKioGT+ZWYw93Ows5UIAWWrU
 AEGumxL9itaKrFyVkJxWFJSuEmWceR3HwLXHUWw9eptftTdR0u0cWjgbanES0AJgk4Q+
 495A7un9yAON4GS43WVPmFG3DqyPU6r3zChl/3NHvVg7Tlh2RJ2wI2g2Sv+rv9NFPGKh
 tPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681201514; x=1683793514;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QBtAXgK5nNY+kGkO+cIyzf6n/gwhb6ien07NFnADZ+U=;
 b=ZtyovBIRzRE5xyRnezXNJ0mIJBgNd1dG8y5SthhZBkMKgNB2+N2lcRG3a6L69YgMlV
 Xzrxaq8V7UkQGkIkYNWSpwsYDGmitGSXnjv6npjF9/8gaff2NL/XnU6/T7S0+rVzkMUD
 ncwINuzdk5OAkkyZcAEYnAZufWotYB4JbJ30RFv8C1xIwxVs67BNUDsLuPn3gsJX/pxy
 JgyRnofKB8KN3DATGfVgccwoRTjfv+371gHSqU+Ibd7oDOANLI49Sp55b7fFs3fo7wX+
 BT61DvZm9SEA1xfgtkNzANPHWutthPMHJr4BUb0N9fNEYq23i6cFK6a5NWCHJkxxGof2
 vSvg==
X-Gm-Message-State: AAQBX9dZEnFQK9RX4lFstvdsnRR2UoA6bzMGPeLORwOp9pbmxl/IyKy/
 iD/ThEsYQM7S5MW/wYxXjjkMh9TpkfG5AUyvD1HsgQ==
X-Google-Smtp-Source: AKy350bYQe4oph03i0KvhPspwwm3eCUDtrSdkx+lMp9h1aLMK079kzgj8X3QMZ8eBsZ7Z+GFpqrkZrL9pManp0xlxbg=
X-Received: by 2002:a0d:ec50:0:b0:54d:913b:c9e8 with SMTP id
 r16-20020a0dec50000000b0054d913bc9e8mr5330160ywn.5.1681201514461; Tue, 11 Apr
 2023 01:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230409185956.725016-1-bas@basnieuwenhuizen.nl>
 <20230409185956.725016-3-bas@basnieuwenhuizen.nl>
 <698f4bbc-6253-2b61-ba82-68f6e7164ef6@amd.com>
In-Reply-To: <698f4bbc-6253-2b61-ba82-68f6e7164ef6@amd.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Tue, 11 Apr 2023 10:22:57 +0200
Message-ID: <CAP+8YyHKxEPYqr2NwnGZ3vEf_+7NeFH7FPXCvSwdzOLrUGgdDw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/amdgpu: Add support for querying the max ibs
 in a submission. (v2)
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
Cc: alexander.deucher@amd.com, David Airlie <airlied@gmail.com>,
 maraeo@gmail.com, amd-gfx@lists.freedesktop.org, timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Apr 11, 2023 at 10:10=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 09.04.23 um 20:59 schrieb Bas Nieuwenhuizen:
> > We need to introduce a new version of the info struct because
> > libdrm_amdgpu forgot any versioning info in amdgpu_query_hw_ip_info
> > so the mesa<->libdrm_amdgpu interface can't handle increasing the
> > size.
> >
> > This info would be used by radv to figure out when we need to
> > split a submission into multiple submissions. radv currently has
> > a limit of 192 which seems to work for most gfx submissions, but
> > is way too high for e.g. compute or sdma.
>
> Why do you need so many IBs in the first place?
>
> You can use sub-IBs since R600 and newer hw even supports a JUMP command
> to chain IBs together IIRC.

Couple of reasons:

1) We can't reliably use sub-IBs (both because on GFX6-7 there are
indirect draw commands that cannot be used in sub-IBs and because the
Vulkan API exposes sub-IBs, so we can have the primary IBs be sub-IBs
already)

2) We believed GFX6 may not support chaining. (Then again, it turns
out the GFX7+ packet may just work on GFX6?
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/22406)

3) Chaining doesn't work if the IB may be in flight multiple times in
a different sequence.

We try to chain when we can but (2) and (3) are cases where we
fallback to submitting multiple IBs.

>
> For the kernel UAPI you only need separate IBs if you have separate
> properties on them, E.g. preamble or submitting to a different engine.
>
> Everything else just needs additional CPU overhead in the IOCTL.
>
> Regards,
> Christian.
>
> >
> > Because the kernel handling is just fine we can just use the v2
> > everywhere and have the return_size do the versioning for us,
> > with userspace interpreting 0 as unknown.
> >
> > Userspace implementation:
> > https://gitlab.freedesktop.org/bnieuwenhuizen/drm/-/tree/ib-rejection
> > https://gitlab.freedesktop.org/bnieuwenhuizen/mesa/-/tree/ib-rejection
> >
> > v2: Use base member in the new struct.
> >
> > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2498
> > Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> > Cc: David Airlie <airlied@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 31 ++++++++++++++----------=
-
> >   include/uapi/drm/amdgpu_drm.h           | 14 +++++++++++
> >   2 files changed, 31 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_kms.c
> > index 89689b940493..5b575e1aef1a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -360,7 +360,7 @@ static int amdgpu_firmware_info(struct drm_amdgpu_i=
nfo_firmware *fw_info,
> >
> >   static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
> >                            struct drm_amdgpu_info *info,
> > -                          struct drm_amdgpu_info_hw_ip *result)
> > +                          struct drm_amdgpu_info_hw_ip2 *result)
> >   {
> >       uint32_t ib_start_alignment =3D 0;
> >       uint32_t ib_size_alignment =3D 0;
> > @@ -431,6 +431,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *=
adev,
> >               return -EINVAL;
> >       }
> >
> > +     result->max_ibs =3D UINT_MAX;
> >       for (i =3D 0; i < adev->num_rings; ++i) {
> >               /* Note that this uses that ring types alias the equivale=
nt
> >                * HW IP exposes to userspace.
> > @@ -438,6 +439,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *=
adev,
> >               if (adev->rings[i]->funcs->type =3D=3D info->query_hw_ip.=
type &&
> >                   adev->rings[i]->sched.ready) {
> >                       ++num_rings;
> > +                     result->max_ibs =3D min(result->max_ibs,
> > +                                           adev->rings[i]->max_ibs);
> >               }
> >       }
> >
> > @@ -452,36 +455,36 @@ static int amdgpu_hw_ip_info(struct amdgpu_device=
 *adev,
> >       num_rings =3D min(amdgpu_ctx_num_entities[info->query_hw_ip.type]=
,
> >                       num_rings);
> >
> > -     result->hw_ip_version_major =3D adev->ip_blocks[i].version->major=
;
> > -     result->hw_ip_version_minor =3D adev->ip_blocks[i].version->minor=
;
> > +     result->base.hw_ip_version_major =3D adev->ip_blocks[i].version->=
major;
> > +     result->base.hw_ip_version_minor =3D adev->ip_blocks[i].version->=
minor;
> >
> >       if (adev->asic_type >=3D CHIP_VEGA10) {
> >               switch (type) {
> >               case AMD_IP_BLOCK_TYPE_GFX:
> > -                     result->ip_discovery_version =3D adev->ip_version=
s[GC_HWIP][0];
> > +                     result->base.ip_discovery_version =3D adev->ip_ve=
rsions[GC_HWIP][0];
> >                       break;
> >               case AMD_IP_BLOCK_TYPE_SDMA:
> > -                     result->ip_discovery_version =3D adev->ip_version=
s[SDMA0_HWIP][0];
> > +                     result->base.ip_discovery_version =3D adev->ip_ve=
rsions[SDMA0_HWIP][0];
> >                       break;
> >               case AMD_IP_BLOCK_TYPE_UVD:
> >               case AMD_IP_BLOCK_TYPE_VCN:
> >               case AMD_IP_BLOCK_TYPE_JPEG:
> > -                     result->ip_discovery_version =3D adev->ip_version=
s[UVD_HWIP][0];
> > +                     result->base.ip_discovery_version =3D adev->ip_ve=
rsions[UVD_HWIP][0];
> >                       break;
> >               case AMD_IP_BLOCK_TYPE_VCE:
> > -                     result->ip_discovery_version =3D adev->ip_version=
s[VCE_HWIP][0];
> > +                     result->base.ip_discovery_version =3D adev->ip_ve=
rsions[VCE_HWIP][0];
> >                       break;
> >               default:
> > -                     result->ip_discovery_version =3D 0;
> > +                     result->base.ip_discovery_version =3D 0;
> >                       break;
> >               }
> >       } else {
> > -             result->ip_discovery_version =3D 0;
> > +             result->base.ip_discovery_version =3D 0;
> >       }
> > -     result->capabilities_flags =3D 0;
> > -     result->available_rings =3D (1 << num_rings) - 1;
> > -     result->ib_start_alignment =3D ib_start_alignment;
> > -     result->ib_size_alignment =3D ib_size_alignment;
> > +     result->base.capabilities_flags =3D 0;
> > +     result->base.available_rings =3D (1 << num_rings) - 1;
> > +     result->base.ib_start_alignment =3D ib_start_alignment;
> > +     result->base.ib_size_alignment =3D ib_size_alignment;
> >       return 0;
> >   }
> >
> > @@ -536,7 +539,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void =
*data, struct drm_file *filp)
> >               }
> >               return copy_to_user(out, &ui32, min(size, 4u)) ? -EFAULT =
: 0;
> >       case AMDGPU_INFO_HW_IP_INFO: {
> > -             struct drm_amdgpu_info_hw_ip ip =3D {};
> > +             struct drm_amdgpu_info_hw_ip2 ip =3D {};
> >               int ret;
> >
> >               ret =3D amdgpu_hw_ip_info(adev, info, &ip);
> > diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_dr=
m.h
> > index b6eb90df5d05..6b9e35b6f747 100644
> > --- a/include/uapi/drm/amdgpu_drm.h
> > +++ b/include/uapi/drm/amdgpu_drm.h
> > @@ -1128,6 +1128,9 @@ struct drm_amdgpu_info_device {
> >       __u32 enabled_rb_pipes_mask_hi;
> >   };
> >
> > +/* The size of this struct cannot be increased for compatibility reaso=
ns, use
> > + * struct drm_amdgpu_info_hw_ip2 instead.
> > + */
> >   struct drm_amdgpu_info_hw_ip {
> >       /** Version of h/w IP */
> >       __u32  hw_ip_version_major;
> > @@ -1144,6 +1147,17 @@ struct drm_amdgpu_info_hw_ip {
> >       __u32  ip_discovery_version;
> >   };
> >
> > +struct drm_amdgpu_info_hw_ip2 {
> > +     /** Previous version of the struct */
> > +     struct drm_amdgpu_info_hw_ip  base;
> > +     /** The maximum number of IBs one can submit in a single submissi=
on
> > +      * ioctl. (When using gang submit: this is per IP type)
> > +      */
> > +     __u32  max_ibs;
> > +     /** padding to 64bit for arch differences */
> > +     __u32  pad;
> > +};
> > +
> >   struct drm_amdgpu_info_num_handles {
> >       /** Max handles as supported by firmware for UVD */
> >       __u32  uvd_max_handles;
>
