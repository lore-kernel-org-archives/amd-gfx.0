Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAB4C77B61
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Apr 2023 15:34:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86EBF10E1C1;
	Sun,  9 Apr 2023 15:34:42 +0000 (UTC)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE9FC10E1C1
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Apr 2023 15:34:41 +0000 (UTC)
Received: by mail-yb1-xb32.google.com with SMTP id e127so2553860ybf.8
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Apr 2023 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1681054479; x=1683646479;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ePpB+3qx+2tUUqR26igEUJ4Qj+OZz+7NkYc5ml4Q1L4=;
 b=eTd8AxGZtRE9dRBgc6bV5gKzwA0okqyBtGeylQJnVGnvc/n0J8RFWC1Y7VJG9NV7hG
 pF0X1bDjrngQ4iEy480qtYNbsXznH/eFDpEuc62y2peQ8lXqagnZmfUihizdEdILzRmL
 hO4H9RWDaJkcx0GTxGdE7oYZHOI0Q0lku1B/SD6eenJm1Ic59zoViYHgPceCCgwgMkev
 qJGrjYHHJQJS9XQK2gE/Gio9yoF7t1VLB8Asw5edPUFy4SRbSCJ1xudYsRFkq8R8kvRE
 JaoBbSrw+XJUC0o06Pf4tFCffrT6rZzyGkAjlnf0l0kbrOgL9NHACDsOOPc17+n5mUfC
 7NVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681054479; x=1683646479;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ePpB+3qx+2tUUqR26igEUJ4Qj+OZz+7NkYc5ml4Q1L4=;
 b=fzJLZXCcon6+uAFsKf9+uG/McPxICMnoNgQWoWWUuTXcZMHbU6dLr5cJWvQuIt4qBR
 S9Kybnao5DmDUURMZ/8jyp880vrhKhRePUZt8n9r0me9iYgiRD1wKwABGlW8nvnOtRUV
 FguFwUrqzrrI4o6xqvOK2K+dWyltL24Oo4YDW3+jRIpEAGivqaWISb1o6Z3HmCjmWqR3
 8LlNGZTTEDZ9LRa78GwaXvpUubLxfEkfQ2pAQ1YlLWiao0Jx3KiiXspYQL0Ksr6jp1Oe
 RwNfn3J+iw7SPDDeCTbjtY6PN8r4l/SjnFFHLxWlOYZTVmFDXuiqhEIgG/yEkURTiyZn
 CuMw==
X-Gm-Message-State: AAQBX9fuRMhd5hC/hfqwDEdX5wxTVUua9rmUpvwV0dng1f17lsAYi/6x
 4W/C7WdtB6MibqWgPAKM9wEI2oloCZh/KgdvEr70zQ==
X-Google-Smtp-Source: AKy350aPpuwd5s8QeGPveHcwf2MFCaxep/aXOhdD5SpKiRKXT2Hxxtp75AsQPJe297rjAvBVhdWwoa42sDsVrMBRXYU=
X-Received: by 2002:a25:d10c:0:b0:b79:22d7:95ff with SMTP id
 i12-20020a25d10c000000b00b7922d795ffmr5558596ybg.2.1681054478922; Sun, 09 Apr
 2023 08:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230409144445.374816-1-bas@basnieuwenhuizen.nl>
 <20230409144445.374816-3-bas@basnieuwenhuizen.nl>
 <99dad825-894a-bc00-7a26-6b1b917477d4@gmail.com>
In-Reply-To: <99dad825-894a-bc00-7a26-6b1b917477d4@gmail.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Sun, 9 Apr 2023 17:32:26 +0200
Message-ID: <CAP+8YyF8-5aVoLBmAUy0rS6rturFk0GMYy6Y6wLA2p9U1P7iAw@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Add support for querying the max ibs in a
 submission.
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
Cc: maraeo@gmail.com, timur.kristof@gmail.com, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, David Airlie <airlied@gmail.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Apr 9, 2023 at 5:30=E2=80=AFPM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 09.04.23 um 16:44 schrieb Bas Nieuwenhuizen:
> > We need to introduce a new version of the info struct because
> > libdrm_amdgpu forgot any versioning info in amdgpu_query_hw_ip_info
> > so the mesa<->libdrm_amdgpu interface can't handle increasing the
> > size.
>
> Those are not forgotten, but simply unnecessary.
>
> The size of the input output structures are given to the IOCTL in bytes
> and additional bytes should be filled with zeros.

At the ioctl side, yes, but it is libdrm_amdgpu filling in the size,
while passing in the struct directly from the client (mesa or
whatever). So if we have new libdrm_amdgpu and old mesa, then mesa
allocates  N bytes on the stack and libdrm_amdgpu happily tells the
kernel in the ioctl "this struct is N+8 bytes long" which would cause
corruption?

- Bas

>
> So you should be able to extend the structures at the end without
> breaking anything.
>
> Regards,
> Christian.
>
> >
> > This info would be used by radv to figure out when we need to
> > split a submission into multiple submissions. radv currently has
> > a limit of 192 which seems to work for most gfx submissions, but
> > is way too high for e.g. compute or sdma.
> >
> > Because the kernel handling is just fine we can just use the v2
> > everywhere and have the return_size do the versioning for us,
> > with userspace interpreting 0 as unknown.
> >
> > Userspace implementation:
> > https://gitlab.freedesktop.org/bnieuwenhuizen/drm/-/tree/ib-rejection
> > https://gitlab.freedesktop.org/bnieuwenhuizen/mesa/-/tree/ib-rejection
> >
> > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2498
> > Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> > Cc: David Airlie <airlied@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  7 ++++--
> >   include/uapi/drm/amdgpu_drm.h           | 29 ++++++++++++++++++++++++=
+
> >   2 files changed, 34 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_kms.c
> > index 89689b940493..c7e815c2733e 100644
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
> > index b6eb90df5d05..45e5ae546d19 100644
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
> > @@ -1144,6 +1147,32 @@ struct drm_amdgpu_info_hw_ip {
> >       __u32  ip_discovery_version;
> >   };
> >
> > +/* The prefix fields of this are intentionally the same as those of
> > + * struct drm_amdgpu_info_hw_ip. The struct has a v2 to resolve a lack=
 of
> > + * versioning on the libdrm_amdgpu side.
> > + */
> > +struct drm_amdgpu_info_hw_ip2 {
> > +     /** Version of h/w IP */
> > +     __u32  hw_ip_version_major;
> > +     __u32  hw_ip_version_minor;
> > +     /** Capabilities */
> > +     __u64  capabilities_flags;
> > +     /** command buffer address start alignment*/
> > +     __u32  ib_start_alignment;
> > +     /** command buffer size alignment*/
> > +     __u32  ib_size_alignment;
> > +     /** Bitmask of available rings. Bit 0 means ring 0, etc. */
> > +     __u32  available_rings;
> > +     /** version info: bits 23:16 major, 15:8 minor, 7:0 revision */
> > +     __u32  ip_discovery_version;
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
