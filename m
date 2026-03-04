Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FBDEDEBFF
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 02:50:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37FF010E934;
	Wed,  4 Mar 2026 02:50:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GIlaBs0b";
	dkim-atps=neutral
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAC2C10E934
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 02:50:42 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2be07cafe27so150793eec.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Mar 2026 18:50:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772592642; cv=none;
 d=google.com; s=arc-20240605;
 b=i9Fn9CQHuGFIsbw7Tyd8VTISqT58600l5hpVNNUHio0bdwx6gEOjlFjLUC7Qt7S77F
 3Ua1hQlK3j0GvArXlgRxlDhiuZ+RXCKOvNlb5VOKM0K692b8BmUs+0VOQtivHKNvTTbj
 5y5guf68zP0TWWVvObDSFxb4rYlWDS4qEZzJwOKTpW2FNDI2prgHlBV/lnh6GbKOx/um
 D6VPxEJkWbn21tAlcx0Nl1leeWit91glXZpGiCMJx29SSjFANoWluk8FYxELSfruCXmu
 jBU3ViCtMLZyzWReujH8Map+slt1InoXjRMjIhe+Ea2Id17H8WiXWc8CLMpneucvcTjw
 A5vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=s+wyotfeTL8j7PrKGthWitYqoz0nxzIwaV6VCyNsJ58=;
 fh=NQIu43eAQYctZw17OV5FaXiWTG9qISXCZt5N6elVUQs=;
 b=Wd0wIC7MQ/Mj/xFBSpW5vjBtcLq8lDQ5HkVrVEXWc4FL9z6rjj6ZfrkzI+WEeWfbuG
 rwBuDZcAOCDjHGyYCWeTKhClAjD5O3XAeyk1afB6i/5gaUqYb8GpiwK1h5/Qt0rj0UoI
 wvms04JzpgQkWq3tbP+0uUW8iGGE9IjavG4j0kuzKIQd2jYcVqShfWqUHTxhVVOvzMNi
 5kQWFi6AfnSoJfa5BlPFiSoy6mAMj0yOUOOinXIPBFknSlHrEdorWmOCP3pnPzSMQMZg
 blhxzT7rwAfwBe6CyYXUxNIXEuTGqmi5TQ9fG/B3/wghsjdv3pxcxZVbAupQI/V+2f0w
 J1Dg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772592642; x=1773197442; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s+wyotfeTL8j7PrKGthWitYqoz0nxzIwaV6VCyNsJ58=;
 b=GIlaBs0bln1NgWkNJYEFCCkUMmQNy3SVYLGT7zQD/AFLJ7rBYIVJTcU7C9YnuHfjBW
 aTf4558a0/DChSSeAovylCJ876Ou5dESTpoL6HL1bkNBgTbdsnEZSeigz0tvG8Bhu1Rm
 Gjl+nwUvNUde4Dne73A+42AEJ1wHuy1IlP9xkXdOe3gYRLVO269SmPtGfCg8nqEmfPki
 jiUGVuF8iAR5z5XV1giee7+4Gi1lh0a4T0uyE/ByEG6zcx7qWm4re3XGroED15x1bIiH
 6mkvZ8ZqIOr756zBbu34MT1PKVNSJOCbB8/pwKApKhkYos5f318dJJLTcJ8NzaMCU5Lf
 Z10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772592642; x=1773197442;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s+wyotfeTL8j7PrKGthWitYqoz0nxzIwaV6VCyNsJ58=;
 b=Q28bRbaYEp0zTyZUPAH6xtBLeY3zTfR4t3cV7MRvS7MSn0rfLXQ2y1x/j0xcwJLCXU
 jLDPA0aQ9xEsCsHbd1Y8c7Wmx2/+DoHwn7dC1Sz8R4h0sIl4cOlTy+IT1oT22M6kVE9H
 b3IJYSaoeOlzl8q8AByz1Hzyc8m/TrXpfnrtFuKOGbGFOtb5lwzEmSewAMpZt2iM9Sr1
 Zwzgj0Hr0lxOV7k9mS4xgTbiRBCsluT3LeZp+PLyjN3OwLuEcanTYDS+oO6P8UuKAn4u
 aruR4yaFsbgpudkp/pVTX8zOcanu0XKNmp798gs/CQmueOBtho9LMX5rEN474rTBCXf2
 NikA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxdy9nuLCPoWXeC6IV/xGQm0rHyWB4g9ORZkML5YluYozxYhdVFXnQVtJDnVVn9o1n1vEbRrFG@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYgONcjTlOjKoZ6E01/BK4nzZegiR6nbSJrYT7cpPMipYVd0JS
 zHeWP+MLx6luTpWxn2QEUStoD7CcRvWGVRe3lUh1ubnJyf1sD6K3+DIoJoIjd5TxVzkVYqCqTok
 JwsPo3ndvTkTr+WcmahA0cSwAsMbkkwc=
X-Gm-Gg: ATEYQzwwBNal97E4E3fhpkPNFSyPWdE2sCuHnAhivch1GobjHWD7Bx7aWaKTTn4NkR0
 au/cV6oa0WX38EgAXqBI08wOcwsUZI0hjGMnAvHzv8zzxKM6lGHFbM0g6Slq0UExN9ZsvGq39Rc
 tSrjvOfmD/ozvmd0WHPI7eWi4HLNZu7h/IQg7Z9U99oP37k1X6Kg3x3GfkWTKm3JKTDgOmT1n5Y
 MTtcu8jXmrdsIdzWNXxtsRRTLMUSqT76Xujkc/KEaozIxhzbyjWonZBZgzle9v4u18+bXqK5+2I
 KbZiw7cPDWWZvhL+VhbAVsd12cddN5y724C9NiuTTaPUlu7rb6oeI9JXFhoPjgUpYDP2JA==
X-Received: by 2002:a05:7022:6b82:b0:11b:65e:f33 with SMTP id
 a92af1059eb24-128b70664bbmr111241c88.1.1772592642058; Tue, 03 Mar 2026
 18:50:42 -0800 (PST)
MIME-Version: 1.0
References: <20260128195327.2158888-1-alexander.deucher@amd.com>
 <CADnq5_Obq9LW2TrvB0y8ELha1BubjWz9n2sh59Zr2NRN+EZoWQ@mail.gmail.com>
 <DM4PR12MB515201223E5BBA196E562C3BE37CA@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB515201223E5BBA196E562C3BE37CA@DM4PR12MB5152.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Mar 2026 21:50:30 -0500
X-Gm-Features: AaiRm53Br-hjZ6A35KCavv9Gh_CB7cIzIK3BlJdKt89CsiEIy78kDNPQPERLQH8
Message-ID: <CADnq5_PdbXJHvY-N6WOrdiCqovH97Y1XGcomcHwYkBeRCMMRcg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx12.1: add support for disable_kq
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Tue, Mar 3, 2026 at 8:28=E2=80=AFPM Zhang, Jesse(Jie) <Jesse.Zhang@amd.c=
om> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> > Deucher
> > Sent: Tuesday, March 3, 2026 11:23 PM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org
> > Subject: Re: [PATCH] drm/amdgpu/gfx12.1: add support for disable_kq
> >
> > Ping?
> >
> > Alex
> >
> > On Wed, Jan 28, 2026 at 3:12=E2=80=AFPM Alex Deucher <alexander.deucher=
@amd.com>
> > wrote:
> > >
> > > Plumb in support for disabling kernel queues and make it the default.
> > > For testing, kernel queues can be re-enabled by setting
> > > amdgpu.user_queue=3D0
> > >
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 109
> > > +++++++++++++++++++------
> > >  1 file changed, 82 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> > > b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> > > index 08ae50a6313f3..f93ee275ce398 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> > > @@ -1155,11 +1155,13 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip=
_block
> > *ip_block)
> > >                 break;
> > >         }
> > >
> > > -       /* recalculate compute rings to use based on hardware configu=
ration */
> > > -       num_compute_rings =3D (adev->gfx.mec.num_pipe_per_mec *
> > > -                            adev->gfx.mec.num_queue_per_pipe) / 2;
> > > -       adev->gfx.num_compute_rings =3D min(adev->gfx.num_compute_rin=
gs,
> > > -                                         num_compute_rings);
> > > +       if (adev->gfx.num_compute_rings) {
> > > +               /* recalculate compute rings to use based on hardware=
 configuration */
> > > +               num_compute_rings =3D (adev->gfx.mec.num_pipe_per_mec=
 *
> > > +                                    adev->gfx.mec.num_queue_per_pipe=
) / 2;
> > > +               adev->gfx.num_compute_rings =3D min(adev->gfx.num_com=
pute_rings,
> > > +                                                 num_compute_rings);
> > > +       }
> > >
> > >         num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> > >
> > > @@ -2794,6 +2796,36 @@ static void gfx_v12_1_xcc_fini(struct
> > amdgpu_device *adev,
> > >         gfx_v12_1_xcc_enable_gui_idle_interrupt(adev, false, xcc_id);
> > > }
> > >
> > > +static int gfx_v12_1_set_userq_eop_interrupts(struct amdgpu_device *=
adev,
> > > +                                             bool enable) {
> > > +       unsigned int irq_type;
> > > +       int m, p, r, x, num_xcc;
> > > +
> > > +       if (adev->gfx.disable_kq) {
> > > +               num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> > > +               for (x =3D 0; x < num_xcc; x++) {
> > > +                       for (m =3D 0; m < adev->gfx.mec.num_mec; ++m)=
 {
> > > +                               for (p =3D 0; p < adev->gfx.mec.num_p=
ipe_per_mec; p++) {
> > > +                                       irq_type =3D
> > AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
> > > +                                               + (m * adev->gfx.mec.=
num_pipe_per_mec)
> > > +                                               + p;
> > > +                                       if (enable)
> > > +                                               r =3D amdgpu_irq_get(=
adev, &adev->gfx.eop_irq,
> > > +                                                                  ir=
q_type);
> > > +                                       else
> > > +                                               r =3D amdgpu_irq_put(=
adev, &adev->gfx.eop_irq,
> > > +                                                                  ir=
q_type);
> > > +                                       if (r)
> > > +                                               return r;
> > > +                               }
> > > +                       }
> > > +               }
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  static int gfx_v12_1_hw_fini(struct amdgpu_ip_block *ip_block)  {
> > >         struct amdgpu_device *adev =3D ip_block->adev; @@ -2801,6
> > > +2833,7 @@ static int gfx_v12_1_hw_fini(struct amdgpu_ip_block
> > > *ip_block)
> > >
> > >         amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
> > >         amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> > > +       gfx_v12_1_set_userq_eop_interrupts(adev, false);
> > >
> > >         num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> > >         for (i =3D 0; i < num_xcc; i++) { @@ -2868,10 +2901,26 @@ sta=
tic
> > > int gfx_v12_1_early_init(struct amdgpu_ip_block *ip_block)  {
> > >         struct amdgpu_device *adev =3D ip_block->adev;
> > >
> > > +
> > > +       switch (amdgpu_user_queue) {
> > > +       case -1:
> > > +       default:
> > > +               adev->gfx.disable_kq =3D true;
> > > +               adev->gfx.disable_uq =3D true;
> Should we keep it consistent with the gfx11 settings (gfx_v11_0_early_ini=
t)?

There's no need for kernel queues or KGD user queues in this case.

Alex

> Except this question, Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
> > > +               break;
> > > +       case 0:
> > > +               adev->gfx.disable_kq =3D false;
> > > +               adev->gfx.disable_uq =3D true;
> > > +               break;
> > > +       }
> > > +
> > >         adev->gfx.funcs =3D &gfx_v12_1_gfx_funcs;
> > >
> > > -       adev->gfx.num_compute_rings =3D min(amdgpu_gfx_get_num_kcq(ad=
ev),
> > > -                                         AMDGPU_MAX_COMPUTE_RINGS);
> > > +       if (adev->gfx.disable_kq)
> > > +               adev->gfx.num_compute_rings =3D 0;
> > > +       else
> > > +               adev->gfx.num_compute_rings =3D
> > min(amdgpu_gfx_get_num_kcq(adev),
> > > +
> > > + AMDGPU_MAX_COMPUTE_RINGS);
> > >
> > >         gfx_v12_1_set_kiq_pm4_funcs(adev);
> > >         gfx_v12_1_set_ring_funcs(adev); @@ -2898,6 +2947,10 @@ static
> > > int gfx_v12_1_late_init(struct amdgpu_ip_block *ip_block)
> > >         if (r)
> > >                 return r;
> > >
> > > +       r =3D gfx_v12_1_set_userq_eop_interrupts(adev, true);
> > > +       if (r)
> > > +               return r;
> > > +
> > >         return 0;
> > >  }
> > >
> > > @@ -3719,29 +3772,31 @@ static void gfx_v12_1_handle_priv_fault(struc=
t
> > amdgpu_device *adev,
> > >         if (xcc_id =3D=3D -EINVAL)
> > >                 return;
> > >
> > > -       switch (me_id) {
> > > -       case 0:
> > > -               for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> > > -                       ring =3D &adev->gfx.gfx_ring[i];
> > > -                       /* we only enabled 1 gfx queue per pipe for n=
ow */
> > > -                       if (ring->me =3D=3D me_id && ring->pipe =3D=
=3D pipe_id)
> > > -                               drm_sched_fault(&ring->sched);
> > > -               }
> > > -               break;
> > > -       case 1:
> > > -       case 2:
> > > -               for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> > > -                       ring =3D &adev->gfx.compute_ring
> > > +       if (!adev->gfx.disable_kq) {
> > > +               switch (me_id) {
> > > +               case 0:
> > > +                       for (i =3D 0; i < adev->gfx.num_gfx_rings; i+=
+) {
> > > +                               ring =3D &adev->gfx.gfx_ring[i];
> > > +                               /* we only enabled 1 gfx queue per pi=
pe for now */
> > > +                               if (ring->me =3D=3D me_id && ring->pi=
pe =3D=3D pipe_id)
> > > +                                       drm_sched_fault(&ring->sched)=
;
> > > +                       }
> > > +                       break;
> > > +               case 1:
> > > +               case 2:
> > > +                       for (i =3D 0; i < adev->gfx.num_compute_rings=
; i++) {
> > > +                               ring =3D &adev->gfx.compute_ring
> > >                                         [i +
> > >                                          xcc_id * adev->gfx.num_compu=
te_rings];
> > > -                       if (ring->me =3D=3D me_id && ring->pipe =3D=
=3D pipe_id &&
> > > -                           ring->queue =3D=3D queue_id)
> > > -                               drm_sched_fault(&ring->sched);
> > > +                               if (ring->me =3D=3D me_id && ring->pi=
pe =3D=3D pipe_id &&
> > > +                                   ring->queue =3D=3D queue_id)
> > > +                                       drm_sched_fault(&ring->sched)=
;
> > > +                       }
> > > +                       break;
> > > +               default:
> > > +                       BUG();
> > > +                       break;
> > >                 }
> > > -               break;
> > > -       default:
> > > -               BUG();
> > > -               break;
> > >         }
> > >  }
> > >
> > > --
> > > 2.52.0
> > >
