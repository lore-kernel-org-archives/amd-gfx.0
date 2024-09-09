Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F95ECE589
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 21:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8574E10E6B7;
	Mon,  9 Sep 2024 21:02:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gy7mZ2J+";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3881D10E6B7
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 21:02:45 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-206af242bdcso3931045ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Sep 2024 14:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725915765; x=1726520565; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ycOnr9M1awNB75S1/CwVtegcFwRn1CwfK80RHvqT2sM=;
 b=Gy7mZ2J+Uq7PcyZTcbuzsY5NnPhwgpM30AJD5gZjTv2pDunEotjuO0nJaSDV29xYln
 8jq7O2NzbIsqxIaW4g9Ojp9OfRDz9JiwV7EAe0/RdvqZd+fCAoXdADkf39ABnDQ3Ck4z
 rg2X44zAL81hvLUvnsDkSzJFq0uhjtbDJNdIdiPo7UuJW8iY4Ie3tZaNLcfpr8llp9f4
 0RNFzgrJF7vh34UqCtWYTCRNq1pVv0gFn7GWX0+dUFl4q3aPHfwm6dwaRY4ViICC7Jp5
 fondYAGgGv/SUZeqCOd1DHaMjiLxV2iAFY8hVXvjfM3FmGo1gGODdvT1NC78tiLbUYYJ
 Nlmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725915765; x=1726520565;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ycOnr9M1awNB75S1/CwVtegcFwRn1CwfK80RHvqT2sM=;
 b=ODObxdKI/aRb2yCGsJxW1jpyS8CtDQSo5LBWf4gx5sfDdgzd60t15/vheHw5YBzla1
 tio03whXDV+CQ37GcGD23ASdn9RtfMIy8BerW+EIdo+O2S7IiYJG1rv20QWAoqK0KNjb
 2bd7wnravdFWcbrR+leZ1eBT6BLBAncUNXqgW250lM6zz40gP0bv3o6zqY8TO4ZH7WQi
 yC5K3B3JLlWgpItdflRagPJe1Xf25EEIL+4fS4RI9CxkLS/nPKsOCwmEyBnTMPvsgr8y
 JfXQmGQRvhy893o9pWxkQgJIXvdhpUWLweroagmLkSKfngP67z8xLiyMPdG9iNYFzS3p
 8aDw==
X-Gm-Message-State: AOJu0YxK6WmTPs+pdwq1AoVwpQlVpxZcHZFxCQd5J0NFdW6B9rduCQVV
 SKTNAsgpe5sB4cMoe7skH+CLUQMT+avufxFd20dr2mIV9dQh+9wxs3ghL5M/ZDp6TO5k7TLe3oy
 D+u+yEcauxPaYp3S7fFu5BnrxyA9uUqAH
X-Google-Smtp-Source: AGHT+IFpB5t5jtPZuTzR4ps37+EKIvc1MoNS8KSU9s0ahNm1pNqM435KdSEUB3oObic4tP1+6CUiXelnGYMGX1YdpeA=
X-Received: by 2002:a17:903:230b:b0:207:d98:52ea with SMTP id
 d9443c01a7336-2070d985348mr40033995ad.12.1725915764384; Mon, 09 Sep 2024
 14:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240902073417.2025971-1-lijo.lazar@amd.com>
 <20240902073417.2025971-2-lijo.lazar@amd.com>
 <CADnq5_OAFC34hOsUru+iYNKE7RoTwJSdKkt36tOfB=htbVOT=Q@mail.gmail.com>
In-Reply-To: <CADnq5_OAFC34hOsUru+iYNKE7RoTwJSdKkt36tOfB=htbVOT=Q@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Sep 2024 17:02:32 -0400
Message-ID: <CADnq5_MbcK=Gs_1OUSO9Avwj649uaCTYXhZYVnDbL_3=tJBHfw@mail.gmail.com>
Subject: Re: [PATCH 01/10] drm/amdgpu: Add init levels
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com
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

On Mon, Sep 9, 2024 at 4:57=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> On Mon, Sep 2, 2024 at 3:34=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wr=
ote:
> >
> > Add init levels to define the level to which device needs to be
> > initialized.
> >
> > Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 14 ++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 54 ++++++++++++++++++++++
> >  2 files changed, 68 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> > index 6e6580ab7e04..fefdace22894 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -820,6 +820,16 @@ struct amdgpu_mqd {
> >                         struct amdgpu_mqd_prop *p);
> >  };
> >
> > +enum amdgpu_init_lvl_id {
> > +       AMDGPU_INIT_LEVEL_DEFAULT,
> > +       AMDGPU_INIT_LEVEL_MINIMAL,
>
> Add some comments here to define what they mean?  E.g.,
>
> +       AMDGPU_INIT_LEVEL_MINIMAL, /* minimum needed for reset at load ti=
me */

Or maybe:

AMDGPU_INIT_LEVEL_MINIMAL_RESET_ON_INIT

to make it explicit?

>
> > +};
> > +
> > +struct amdgpu_init_level {
> > +       enum amdgpu_init_lvl_id level;
> > +       uint32_t hwini_ip_block_mask;
> > +};
> > +
> >  #define AMDGPU_RESET_MAGIC_NUM 64
> >  #define AMDGPU_MAX_DF_PERFMONS 4
> >  struct amdgpu_reset_domain;
> > @@ -1169,6 +1179,8 @@ struct amdgpu_device {
> >         bool                            enforce_isolation[MAX_XCP];
> >         /* Added this mutex for cleaner shader isolation between GFX an=
d compute processes */
> >         struct mutex                    enforce_isolation_mutex;
> > +
> > +       struct amdgpu_init_level *init_lvl;
> >  };
> >
> >  static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *a=
dev,
> > @@ -1623,4 +1635,6 @@ extern const struct attribute_group amdgpu_vram_m=
gr_attr_group;
> >  extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
> >  extern const struct attribute_group amdgpu_flash_attr_group;
> >
> > +void amdgpu_set_init_level(struct amdgpu_device *adev,
> > +                          enum amdgpu_init_lvl_id lvl);
> >  #endif
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 61a189e30bcd..4fb09c4fbf22 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -144,6 +144,42 @@ const char *amdgpu_asic_name[] =3D {
> >         "LAST",
> >  };
> >
> > +#define AMDGPU_IP_BLK_MASK_ALL GENMASK(AMDGPU_MAX_IP_NUM - 1, 0)
> > +
> > +struct amdgpu_init_level amdgpu_init_default =3D {
> > +       .level =3D AMDGPU_INIT_LEVEL_DEFAULT,
> > +       .hwini_ip_block_mask =3D AMDGPU_IP_BLK_MASK_ALL,
> > +};
> > +
> > +struct amdgpu_init_level amdgpu_init_minimal =3D {
> > +       .level =3D AMDGPU_INIT_LEVEL_MINIMAL,
> > +       .hwini_ip_block_mask =3D
> > +               BIT(AMD_IP_BLOCK_TYPE_GMC) | BIT(AMD_IP_BLOCK_TYPE_SMC)=
 |
> > +               BIT(AMD_IP_BLOCK_TYPE_COMMON) | BIT(AMD_IP_BLOCK_TYPE_I=
H)
> > +};
> > +
> > +static inline bool amdgpu_ip_member_of_hwini(struct amdgpu_device *ade=
v,
> > +                                            enum amd_ip_block_type blo=
ck)
> > +{
> > +       return (adev->init_lvl->hwini_ip_block_mask & (1U << block)) !=
=3D 0;
> > +}
> > +
> > +void amdgpu_set_init_level(struct amdgpu_device *adev,
> > +                          enum amdgpu_init_lvl_id lvl)
> > +{
> > +       switch (lvl) {
> > +       case AMDGPU_INIT_LEVEL_DEFAULT:
>
> Can move the default case here.
>
> > +               adev->init_lvl =3D &amdgpu_init_default;
> > +               break;
> > +       case AMDGPU_INIT_LEVEL_MINIMAL:
> > +               adev->init_lvl =3D &amdgpu_init_minimal;
> > +               break;
> > +       default:
> > +               adev->init_lvl =3D &amdgpu_init_default;
> > +               break;
> > +       }
> > +}
> > +
> >  static inline void amdgpu_device_stop_pending_resets(struct amdgpu_dev=
ice *adev);
> >
> >  /**
> > @@ -2633,6 +2669,9 @@ static int amdgpu_device_ip_hw_init_phase1(struct=
 amdgpu_device *adev)
> >                         continue;
> >                 if (adev->ip_blocks[i].status.hw)
> >                         continue;
> > +               if (!amdgpu_ip_member_of_hwini(
> > +                           adev, adev->ip_blocks[i].version->type))
> > +                       continue;
> >                 if (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOC=
K_TYPE_COMMON ||
> >                     (amdgpu_sriov_vf(adev) && (adev->ip_blocks[i].versi=
on->type =3D=3D AMD_IP_BLOCK_TYPE_PSP)) ||
> >                     adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOC=
K_TYPE_IH) {
> > @@ -2658,6 +2697,9 @@ static int amdgpu_device_ip_hw_init_phase2(struct=
 amdgpu_device *adev)
> >                         continue;
> >                 if (adev->ip_blocks[i].status.hw)
> >                         continue;
> > +               if (!amdgpu_ip_member_of_hwini(
> > +                           adev, adev->ip_blocks[i].version->type))
> > +                       continue;
> >                 r =3D adev->ip_blocks[i].version->funcs->hw_init(adev);
> >                 if (r) {
> >                         DRM_ERROR("hw_init of IP block <%s> failed %d\n=
",
> > @@ -2681,6 +2723,10 @@ static int amdgpu_device_fw_loading(struct amdgp=
u_device *adev)
> >                         if (adev->ip_blocks[i].version->type !=3D AMD_I=
P_BLOCK_TYPE_PSP)
> >                                 continue;
> >
> > +                       if (!amdgpu_ip_member_of_hwini(adev,
> > +                                                      AMD_IP_BLOCK_TYP=
E_PSP))
> > +                               break;
> > +
> >                         if (!adev->ip_blocks[i].status.sw)
> >                                 continue;
> >
> > @@ -2803,6 +2849,10 @@ static int amdgpu_device_ip_init(struct amdgpu_d=
evice *adev)
> >                 }
> >                 adev->ip_blocks[i].status.sw =3D true;
> >
> > +               if (!amdgpu_ip_member_of_hwini(
> > +                           adev, adev->ip_blocks[i].version->type))
> > +                       continue;
> > +
> >                 if (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOC=
K_TYPE_COMMON) {
> >                         /* need to do common hw init early so everythin=
g is set up for gmc */
> >                         r =3D adev->ip_blocks[i].version->funcs->hw_ini=
t((void *)adev);
> > @@ -4196,6 +4246,8 @@ int amdgpu_device_init(struct amdgpu_device *adev=
,
> >
> >         amdgpu_device_set_mcbp(adev);
> >
>
> Add a comment here to make it clear where and why we change the init leve=
l.
>
> > +       amdgpu_set_init_level(adev, AMDGPU_INIT_LEVEL_DEFAULT);
> > +       adev->init_lvl =3D &amdgpu_init_default;
>
> This pointer assignment can be dropped.
>
> >         /* early init functions */
> >         r =3D amdgpu_device_ip_early_init(adev);
> >         if (r)
> > @@ -5473,6 +5525,8 @@ int amdgpu_do_asic_reset(struct list_head *device=
_list_handle,
> >         }
> >
> >         list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
> > +               /* After reset, it's default init level */
> > +               amdgpu_set_init_level(tmp_adev, AMDGPU_INIT_LEVEL_DEFAU=
LT);
> >                 if (need_full_reset) {
> >                         /* post card */
> >                         amdgpu_ras_set_fed(tmp_adev, false);
> > --
> > 2.25.1
> >
