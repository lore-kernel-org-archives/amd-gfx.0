Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F111CD98E1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 14:01:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3895510E77D;
	Tue, 16 Jun 2026 14:01:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JWN9sElR";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAB5D10E77D
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 14:01:50 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-1384fc99fcfso71737c88.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 07:01:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781618510; cv=none;
 d=google.com; s=arc-20240605;
 b=iO2bxE92ppetu1VvfVXE1e+jRjGcDLxF65HIGpvEzrU3jbyy3yPJarjQbd5BO5mXbS
 0amseA9OHooAZcpOA6zfxUC8nAkIquyijiTjjigJHLNCnAFTyG1fWGFWqjg3H21dcI6F
 nsKlp66XMrEE2QzT4aBPUbRi9WZgxP7EsVp9SEfk5i6ioFMNcPxkuswK6wMethJ/fSuy
 wiCecJ+0C9YgjKqsosTNU1lF+UMOQOF4prLqSePONSqsAAtKMMSQeEdh91Yd8VdweQBm
 u9Cdm9yiifHoo5J1LGnC2tofDgQ3e+zu5nlhR4NJ1N0Xtp45S6maHrJqF5Ccch421nKX
 Wgbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tQv+U16V14+mYhQ43kDYYnE/t6KFWCEUUK1AmQf/GVI=;
 fh=bFU5C1vOw4EZbv3EHwnOfoxZGdj0WKaOi6TGWT7CCVY=;
 b=Oe/u0Djwoeuc3kBbbgr7GyhRh0lgEgUvV3nCNZPvP4wgLkB1OjbGGhbyspOFziZYVB
 5RFVlpMiZvhTvC0BJkTTQolVC4MD+/SjREEG1uec0oq9MFdi59f3XZLxdLascI6rIBpP
 3y/PXM+s5rfAvYrTc/0+vqVyUfNnlLIqR7MpftZFbov/0aEID6GQDnbR90cqEePifgag
 L+73aStHa6HVPR/CmS/K1uwJ21zopu2bIW6gZvF3Xcmuc2bB4n+T2zQCtBbNF/WszX48
 vGCv4y1mPaL5G8LRtaqOX68pAFNgl/quTrbuLPGbJPL6FpHWQex+2ZisAPSlyZS4r8FW
 ZPLg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781618510; x=1782223310; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tQv+U16V14+mYhQ43kDYYnE/t6KFWCEUUK1AmQf/GVI=;
 b=JWN9sElRw0DpKEcejgP1fMYWv1U7tN7mXc708lIopUJ6LAgmGScDFfdjuSXGMt7sjN
 yQ81CzP1m3qOmO54CNlO/4ehDdd0iyEjHic1gnjlKo7nQyHbuhb2cOT2UYHxs6q6zR8t
 yQDLDe6AaZUkGzg8XL/VLIFUL+dncpGo8XKKTKOONHejpVd3CWSTY6Dv7odBXQi4B6ir
 5X3pYU7GZ+4B5buq4NGLpU9mIxIJmK2NEV0XaWXTaUc70I2jyxDC3WqqPwNZBMXCfxS4
 j/7KLOBv3PtVBqOq1jQnlyRHDq7vBZ9X3IJ+FkhpCZ+4CMDZ1X949bgXEHPbILufw/5A
 ydew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781618510; x=1782223310;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tQv+U16V14+mYhQ43kDYYnE/t6KFWCEUUK1AmQf/GVI=;
 b=JGkTyX74vhY3SGnLoCIRtnX6oVmex8+ScEpIQ62/VEYuhBapvitVyuONMqKWa1PGOg
 1kZWQBZDOkyUw6Ggg5eXCgHwugLZ+BPDv2riPTdS63kdySzz1mBoYA9ZCUrIXpmq7wHO
 69/2wE4cbv7NxPlyFHQKcc+E55Db0YT5GIHQPPsi+qQ35nBCSCVISafN3RvQCAa4hW8u
 AQtKwEP9N84nZFGpjl3y//CEQfFu5W6jviC2aWsQaN29Jmn9SEsqq/nKLdZ9xK+JcHWp
 gFH+j3ODr0dMXO9Lv7gnNP20vIjPFclEpzZYRga3yi498I6AXeYo3kpcEcMTqac9t7n2
 3NaQ==
X-Gm-Message-State: AOJu0Yxswv55UMnthANsnn7v4NGFx0HMtjFjPZ+n3UcCi2y103dvXjIr
 6nd1L8hHYPypaRSE3zCpL+qMgWQEtRX3hntPphr2ZWBnmLCx4TUXDjFpo1GyjY5qX9fbVdNRXJU
 g0WENJLOiI+Barb23eC99Xi/vvzmv21w=
X-Gm-Gg: Acq92OEL90OcW4g86Sw2ip8pOBIIPs3D+rmUACCaefdWlsC+ndo29yqgRc3G/0Ygx4T
 hbSRR4fs/SGiULRpZwSuwGLZa3i/XY+60psxcKhgtqNepcsp8cR1zCIpX2eGS2RSJ/yxRbZkLfU
 TcqC2yFWOYsSqCS8Zo9w8dKz9ZaLvKqlMNJzf9FhSz+Afk4YhR7ZUvHxOrUGLEpSN8SF78clRJ/
 Lw8ZFpk+PJiBqqYK/8J5gIUigjgzHXEr3DhoCvrSpzCbgof31ln/p9qiviqircQK/c2uca1wwb6
 7tU01z8DLMC6bEeenJkGOUq2lmBr1q5RG+QnI9xAdPZvfiDN5+ePq+h6Hdu/ZiGQqOwfkw==
X-Received: by 2002:a05:7022:3d01:b0:139:81c6:67a1 with SMTP id
 a92af1059eb24-13981c66ae5mr1561169c88.1.1781618509614; Tue, 16 Jun 2026
 07:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260424125003.52366-1-tvrtko.ursulin@igalia.com>
 <8693b119-f870-43eb-ac8d-f4c69419693e@igalia.com>
In-Reply-To: <8693b119-f870-43eb-ac8d-f4c69419693e@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Jun 2026 10:01:37 -0400
X-Gm-Features: AVVi8CcVS13QGYcKj5dtSz-lShB_UIB6xw7CN5BuXTXzDn1pkGcuDoVBax5AdZg
Message-ID: <CADnq5_Pga5tgYgnf3gbnL10uCf9pRvv87=U1TYprgPR_c9NFeg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Choose SOC15 RLC register read write
 functions at init time
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
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

On Tue, Jun 9, 2026 at 11:06=E2=80=AFAM Tvrtko Ursulin
<tvrtko.ursulin@igalia.com> wrote:
>
>
> + Alex - wondering you you are interested in this type of a thing or I
> should drop it? Unless I am missing something (could be, it was long
> time ago when I first wrote it), it is a nice .text saving of pointless
> conditionals.

Yes, sorry for the delay.  This just fell off my radar.  I've applied
the series.

Thanks!

Alex


>
> Regards,
>
> Tvrtko
>
> On 24/04/2026 13:50, Tvrtko Ursulin wrote:
> > Currently on every RLC register read the driver checks for three differ=
ent
> > conditions to decide which of the two register read/write functions to
> > call.
> >
> > As these register operations are macros, which is required for register
> > name expansion to work, the result is a significant explosion of genera=
ted
> > (redundant) code which the compiler cannot optimise away.
> >
> > We however know that all of the three conditional are static and can
> > therefore move the decision to driver init time. All that we need to do=
 is
> > define a new vfunc table for the SOC12 RLC read/write functions and jus=
t
> > use them directly.
> >
> > Bloat-o-meter agrees the driver size savings are significant:
> >
> > add/remove: 11/35 grow/shrink: 82/1117 up/down: 53024/-450922 (-397898)
> > ...
> > Total: Before=3D10293928, After=3D9896030, chg -3.87%
> >
> > Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c    | 39 +++++++++++++++++++++=
+
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h    | 10 ++++++
> >   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  2 ++
> >   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |  2 ++
> >   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  2 ++
> >   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     |  2 ++
> >   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  2 ++
> >   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    |  2 ++
> >   drivers/gpu/drm/amd/amdgpu/soc15_common.h  |  8 ++---
> >   10 files changed, 64 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 30ce2e85a506..bd1b0e9ee220 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -3745,6 +3745,7 @@ int amdgpu_device_init(struct amdgpu_device *adev=
,
> >       mutex_init(&adev->gfx.workload_profile_mutex);
> >       mutex_init(&adev->vcn.workload_profile_mutex);
> >
> > +     amdgpu_early_init_rlc_reg_funcs(adev);
> >       amdgpu_device_init_apu_flags(adev);
> >
> >       r =3D amdgpu_device_check_arguments(adev);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_rlc.c
> > index 572a60e1b3cb..002fae3c380e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
> > @@ -583,3 +583,42 @@ int amdgpu_gfx_rlc_init_microcode(struct amdgpu_de=
vice *adev,
> >               amdgpu_gfx_rlc_init_microcode_v2_5(adev);
> >       return 0;
> >   }
> > +
> > +static const struct amdgpu_rlc_reg_funcs amdgpu_sriov_rlc_reg_funcs =
=3D {
> > +     .rreg32 =3D amdgpu_sriov_rreg,
> > +     .wreg32 =3D amdgpu_sriov_wreg,
> > +};
> > +
> > +static u32
> > +amdgpu_rlc_rreg(struct amdgpu_device *adev, u32 reg, u32 acc_flags, u3=
2 hwip,
> > +             u32 xcc_id)
> > +{
> > +     return amdgpu_device_rreg(adev, reg, 0);
> > +}
> > +
> > +static void
> > +amdgpu_rlc_wreg(struct amdgpu_device *adev, u32 reg, u32 value, u32 ac=
c_flags,
> > +             u32 hwip, u32 xcc_id)
> > +{
> > +     amdgpu_device_wreg(adev, reg, value, 0);
> > +}
> > +
> > +static const struct amdgpu_rlc_reg_funcs amdgpu_rlc_reg_funcs =3D {
> > +     .rreg32 =3D amdgpu_rlc_rreg,
> > +     .wreg32 =3D amdgpu_rlc_wreg,
> > +};
> > +
> > +void amdgpu_early_init_rlc_reg_funcs(struct amdgpu_device *adev)
> > +{
> > +     adev->gfx.rlc.reg_funcs =3D &amdgpu_rlc_reg_funcs;
> > +}
> > +
> > +void amdgpu_init_rlc_reg_funcs(struct amdgpu_device *adev)
> > +{
> > +     if (amdgpu_sriov_vf(adev) &&
> > +         adev->gfx.rlc.funcs &&
> > +         adev->gfx.rlc.rlcg_reg_access_supported)
> > +             adev->gfx.rlc.reg_funcs =3D &amdgpu_sriov_rlc_reg_funcs;
> > +     else
> > +             adev->gfx.rlc.reg_funcs =3D &amdgpu_rlc_reg_funcs;
> > +}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_rlc.h
> > index e535534237a1..959d60c90dcd 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> > @@ -262,6 +262,11 @@ struct amdgpu_rlc_funcs {
> >       bool (*is_rlcg_access_range)(struct amdgpu_device *adev, uint32_t=
 reg);
> >   };
> >
> > +struct amdgpu_rlc_reg_funcs {
> > +     u32  (*rreg32)(struct amdgpu_device *adev, u32 reg, u32 acc_flags=
, u32 hwip, u32 xcc_id);
> > +     void (*wreg32)(struct amdgpu_device *adev, u32 reg, u32 val, u32 =
acc_flags, u32 hwip, u32 xcc_id);
> > +};
> > +
> >   struct amdgpu_rlcg_reg_access_ctrl {
> >       uint32_t scratch_reg0;
> >       uint32_t scratch_reg1;
> > @@ -303,6 +308,7 @@ struct amdgpu_rlc {
> >       /* safe mode for updating CG/PG state */
> >       bool in_safe_mode[AMDGPU_MAX_RLC_INSTANCES];
> >       const struct amdgpu_rlc_funcs *funcs;
> > +     const struct amdgpu_rlc_reg_funcs *reg_funcs;
> >
> >       /* for firmware data */
> >       u32 save_and_restore_offset;
> > @@ -374,4 +380,8 @@ void amdgpu_gfx_rlc_fini(struct amdgpu_device *adev=
);
> >   int amdgpu_gfx_rlc_init_microcode(struct amdgpu_device *adev,
> >                                 uint16_t version_major,
> >                                 uint16_t version_minor);
> > +
> > +void amdgpu_early_init_rlc_reg_funcs(struct amdgpu_device *adev);
> > +void amdgpu_init_rlc_reg_funcs(struct amdgpu_device *adev);
> > +
> >   #endif
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v10_0.c
> > index 8b60299b73ef..4bfdd55be7f9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > @@ -7829,6 +7829,8 @@ static int gfx_v10_0_early_init(struct amdgpu_ip_=
block *ip_block)
> >       /* init rlcg reg access ctrl */
> >       gfx_v10_0_init_rlcg_reg_access_ctrl(adev);
> >
> > +     amdgpu_init_rlc_reg_funcs(adev);
> > +
> >       return gfx_v10_0_init_microcode(adev);
> >   }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v11_0.c
> > index 8c82e90f871b..8b9a9d944641 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > @@ -5341,6 +5341,8 @@ static int gfx_v11_0_early_init(struct amdgpu_ip_=
block *ip_block)
> >
> >       gfx_v11_0_init_rlcg_reg_access_ctrl(adev);
> >
> > +     amdgpu_init_rlc_reg_funcs(adev);
> > +
> >       return gfx_v11_0_init_microcode(adev);
> >   }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v12_0.c
> > index 65c33823a688..a5034e39a8e9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > @@ -3912,6 +3912,8 @@ static int gfx_v12_0_early_init(struct amdgpu_ip_=
block *ip_block)
> >
> >       gfx_v12_0_init_rlcg_reg_access_ctrl(adev);
> >
> > +     amdgpu_init_rlc_reg_funcs(adev);
> > +
> >       return gfx_v12_0_init_microcode(adev);
> >   }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v12_1.c
> > index 68fd3c04134d..13de1b356e9d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> > @@ -2915,6 +2915,8 @@ static int gfx_v12_1_early_init(struct amdgpu_ip_=
block *ip_block)
> >
> >       gfx_v12_1_init_rlcg_reg_access_ctrl(adev);
> >
> > +     amdgpu_init_rlc_reg_funcs(adev);
> > +
> >       return gfx_v12_1_init_microcode(adev);
> >   }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_0.c
> > index 95be105671ec..100b5ee44fef 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -4816,6 +4816,8 @@ static int gfx_v9_0_early_init(struct amdgpu_ip_b=
lock *ip_block)
> >       /* init rlcg reg access ctrl */
> >       gfx_v9_0_init_rlcg_reg_access_ctrl(adev);
> >
> > +     amdgpu_init_rlc_reg_funcs(adev);
> > +
> >       return gfx_v9_0_init_microcode(adev);
> >   }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v9_4_3.c
> > index ad4d442e7345..2e17fc1157fd 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > @@ -2525,6 +2525,8 @@ static int gfx_v9_4_3_early_init(struct amdgpu_ip=
_block *ip_block)
> >       /* init rlcg reg access ctrl */
> >       gfx_v9_4_3_init_rlcg_reg_access_ctrl(adev);
> >
> > +     amdgpu_init_rlc_reg_funcs(adev);
> > +
> >       return gfx_v9_4_3_init_microcode(adev);
> >   }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/dr=
m/amd/amdgpu/soc15_common.h
> > index a7b5a95ebebb..a04f61b22379 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> > @@ -38,14 +38,10 @@
> >       (adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + (reg)+(offse=
t))
> >
> >   #define __WREG32_SOC15_RLC__(reg, value, flag, hwip, inst) \
> > -     ((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.r=
lcg_reg_access_supported) ? \
> > -      amdgpu_sriov_wreg(adev, reg, value, flag, hwip, inst) : \
> > -      WREG32(reg, value))
> > +     adev->gfx.rlc.reg_funcs->wreg32(adev, reg, value, flag, hwip, ins=
t)
> >
> >   #define __RREG32_SOC15_RLC__(reg, flag, hwip, inst) \
> > -     ((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.r=
lcg_reg_access_supported) ? \
> > -      amdgpu_sriov_rreg(adev, reg, flag, hwip, inst) : \
> > -      RREG32(reg))
> > +     adev->gfx.rlc.reg_funcs->rreg32(adev, reg, flag, hwip, inst)
> >
> >   #define WREG32_FIELD15(ip, idx, reg, field, val)    \
> >        __WREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][idx][mm##reg##_=
BASE_IDX] + mm##reg,   \
>
