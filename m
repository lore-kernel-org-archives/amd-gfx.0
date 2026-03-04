Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30567EDEC02
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 02:48:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8E5A10E92D;
	Wed,  4 Mar 2026 02:48:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="copaIFNH";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ACA610E92D
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 02:48:13 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-12739fe9a0eso377091c88.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Mar 2026 18:48:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772592493; cv=none;
 d=google.com; s=arc-20240605;
 b=KvRM3gSMx6Wxt4kEm3gCq7t7aEnzkMM4mXKVfSomZjrBkADSFTRqBBCxXk7g/nxB6e
 XsTmo5aecsityX+vFeEzOiBWbHh+GSagxL+uDD50hFVr+sfM4RTHLqgJd8UfH904POft
 SASrA99k3AW/O/djfi8AmjKqoWfAPGudtbpHXU9wg698EDrNJKog1EWUoYquGQmDJQnG
 ZzF0zcaDuuK4K71ALTjpk12hhFcx8e5lZrS6fCx2n1hQFkKa4P89U5ye+pREwLsYiANR
 zYE+NMaK0a83DXbvDb0EFIrfK+Cg+n8HSvbab1u8XRu1ivKS/nAoUQyhDoHChsEWswyJ
 k5CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZtpDCZdjkZT0rHCn3JvJk06oIsC/m7A0CfVnxZ351yE=;
 fh=tlsiiLrKjlGpiIhfcj5JlwhRlQlqD7sOpZUA5XJB1/U=;
 b=dDZazL+ed7btAaIpVjbjuK2w+z1vlcdFTsguB0ljex1GztSh+j4OzuN59LPHrypyLC
 8zeZUVQHz4yFTSRExWzxDT8WYYTxr7FzRCZ1dhWNyUfHuZ86cvhZ1nCJexV0IMl7fbTw
 SqaUWuxXSmYK5WOOc+4nAU/rhtsbORPy5PmA307uqZwual6jXJ2npUb3OW5bvc2JJyk6
 b4VYqED7J20MaUkVz/4BjM/O2c5nmYOhdv1mP5U9mryFKQW0I6ibGH6tpbPxupEJDPVE
 OGXfPYbXivNTB9h+du6kta8XWm7iJyk0zi4bbzXb9ssXE8Gds9GPenZn+vvQvXTli8/G
 C3QQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772592493; x=1773197293; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZtpDCZdjkZT0rHCn3JvJk06oIsC/m7A0CfVnxZ351yE=;
 b=copaIFNH4JjG5p3hDRDw9YI4vcmOk6VrBwoj6t1h/lolNdDWTmpnZpcbwhx8KbWDFw
 qwNsEluh5GVqqBHprPKRGOB5fD68OdocJ9xDvCHSltmDJtCn3mk81wMIIo67HwsJHnm9
 hVYWg0FRiZ2y41c1UYxyUDZ4klvGWIDr+LfETnHP2yyRvuwGxohl9oSSI44BBMRoKpn7
 C4fqacSdZBvx70F3C4XwOkoLs3uc1QtpFTrtCn60ajCVgLBRIvq418NQfsfzXAGF5N4q
 L/HchSZUiLNEn/D/QsmNvxhOnHaVHgvJ1VvS3iZ0Uo+1MdaQuQPJ50sgTUtWLLYgeNxH
 V1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772592493; x=1773197293;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZtpDCZdjkZT0rHCn3JvJk06oIsC/m7A0CfVnxZ351yE=;
 b=oweQMadDRNecwkLHC8JOXDMSPLxd/7MgaoJhRQfYsmuna/U6tmrvM3vuLJWNowrvpz
 UzIHsCT1dwqJoU4My58Yb59UqTfwVrFkmWu1xQat0EjNR+tvkmrWvC73bJ5yTyyOammk
 ExZiJoR0GZkD8//i3V+0EDO4wFFVh124m2EC75zu7wg2xQH94nuGi9vzUlLa2rltCiWF
 sza7NOPwioUytlBT+IHz6Kgo8vc5eAjAGLKl9XWVjfhFXgPRbfODkmK2GBYm2ezZK4mS
 EqoUGXEpZ7lKUS4x1yFwp+GXI1k75NOVDOGfqaP069G/30Bo3HYWY0QXjjRLo0dRFcrs
 UvZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW95ONnQ2PiCUJSLgEZZxbE3ADVeM62SZ2tQt/yeF/MS5OTRAxfe1ltdoYhXCO79a1fs++2onQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzlc+GwpClLB3tW/wKLdXufwMskIF1fBYSv26XmFh29p6g+MS4h
 uHiUGTQwNw52o4lmv/7fxJR3cBFVIjcjIkCS8ZKP9j8bOMRhhrc4+HGdbVtyNTyOFb1iaLjdnSw
 TK6SIz9xINeelthahBlJCGRGe8+0EUuU=
X-Gm-Gg: ATEYQzw2igIQztcpcUqaLXSxZ10WutUNBSidyFe1cu35S5RHSYffR04ulV3t/WaiSKg
 liOYEC8TEESjMKs0cK5SeSyKCjo7zkksSZ+XYCyFD2CtXtwTFniNBpIwv5mtazA1PMBLqskc5Hc
 nUG9rxARj9lvn8ML+RMrkOwTBbl2EYA8pmOPBOJGwz/h+ul8nUq6CrGoT11QMTqwiErHZw1RXPe
 /ncrt8tqqv+fd0Ag9EuyW7YiADnQnHdNJSxjYlBcv3FvRF6IACQ02Ubv9V1U8I9YCINKzKnZSc1
 05TwTSupuu6OpCqvGja74GA6atup7LIBoalXwm3kFk9vpGYmurlZ2aS5pmbarEio8Ku0aA==
X-Received: by 2002:a05:7022:6baa:b0:119:e56b:46ba with SMTP id
 a92af1059eb24-128b70b90d5mr75684c88.4.1772592492552; Tue, 03 Mar 2026
 18:48:12 -0800 (PST)
MIME-Version: 1.0
References: <20260128195327.2158888-1-alexander.deucher@amd.com>
 <CADnq5_Obq9LW2TrvB0y8ELha1BubjWz9n2sh59Zr2NRN+EZoWQ@mail.gmail.com>
 <MW6PR12MB8898534497BC30024E6704BBFB7CA@MW6PR12MB8898.namprd12.prod.outlook.com>
In-Reply-To: <MW6PR12MB8898534497BC30024E6704BBFB7CA@MW6PR12MB8898.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Mar 2026 21:48:01 -0500
X-Gm-Features: AaiRm51-C0gMm9awiD7MSh31DwvfFvpQf5QJHyNK_qozCKkl51pLoHgthIIb6O0
Message-ID: <CADnq5_Ogo6-veXYze_t4PJJ-PaWefCFHSZ1JMJZLGMniZzSAPA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx12.1: add support for disable_kq
To: "Yu, Lang" <Lang.Yu@amd.com>
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

On Tue, Mar 3, 2026 at 9:02=E2=80=AFPM Yu, Lang <Lang.Yu@amd.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> >-----Original Message-----
> >From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex =
Deucher
> >Sent: Tuesday, March 3, 2026 11:23 PM
> >To: Deucher, Alexander <Alexander.Deucher@amd.com>
> >Cc: amd-gfx@lists.freedesktop.org
> >Subject: Re: [PATCH] drm/amdgpu/gfx12.1: add support for disable_kq
> >
> >Ping?
> >
> >Alex
> >
> >On Wed, Jan 28, 2026 at 3:12=E2=80=AFPM Alex Deucher <alexander.deucher@=
amd.com>
> >wrote:
> >>
> >> Plumb in support for disabling kernel queues and make it the default.
> >> For testing, kernel queues can be re-enabled by setting
> >> amdgpu.user_queue=3D0
> >>
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> ---
> >>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 109
> >> +++++++++++++++++++------
> >>  1 file changed, 82 insertions(+), 27 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> >> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> >> index 08ae50a6313f3..f93ee275ce398 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> >> @@ -1155,11 +1155,13 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_=
block
> >*ip_block)
> >>                 break;
> >>         }
> >>
> >> -       /* recalculate compute rings to use based on hardware configur=
ation */
> >> -       num_compute_rings =3D (adev->gfx.mec.num_pipe_per_mec *
> >> -                            adev->gfx.mec.num_queue_per_pipe) / 2;
> >> -       adev->gfx.num_compute_rings =3D min(adev->gfx.num_compute_ring=
s,
> >> -                                         num_compute_rings);
> >> +       if (adev->gfx.num_compute_rings) {
> >> +               /* recalculate compute rings to use based on hardware =
configuration */
> >> +               num_compute_rings =3D (adev->gfx.mec.num_pipe_per_mec =
*
> >> +                                    adev->gfx.mec.num_queue_per_pipe)=
 / 2;
> >> +               adev->gfx.num_compute_rings =3D min(adev->gfx.num_comp=
ute_rings,
> >> +                                                 num_compute_rings);
> >> +       }
> >>
> >>         num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> >>
> >> @@ -2794,6 +2796,36 @@ static void gfx_v12_1_xcc_fini(struct amdgpu_de=
vice
> >*adev,
> >>         gfx_v12_1_xcc_enable_gui_idle_interrupt(adev, false, xcc_id);
> >> }
> >>
> >> +static int gfx_v12_1_set_userq_eop_interrupts(struct amdgpu_device *a=
dev,
> >> +                                             bool enable) {
> >> +       unsigned int irq_type;
> >> +       int m, p, r, x, num_xcc;
> >> +
> >> +       if (adev->gfx.disable_kq) {
> >> +               num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> >> +               for (x =3D 0; x < num_xcc; x++) {
> >> +                       for (m =3D 0; m < adev->gfx.mec.num_mec; ++m) =
{
> >> +                               for (p =3D 0; p < adev->gfx.mec.num_pi=
pe_per_mec; p++) {
> >> +                                       irq_type =3D
> >AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
> >> +                                               + (m * adev->gfx.mec.n=
um_pipe_per_mec)
> >> +                                               + p;
> >> +                                       if (enable)
> >> +                                               r =3D amdgpu_irq_get(a=
dev, &adev->gfx.eop_irq,
> >> +                                                                  irq=
_type);
> >> +                                       else
> >> +                                               r =3D amdgpu_irq_put(a=
dev, &adev->gfx.eop_irq,
> >> +                                                                  irq=
_type);
> >> +                                       if (r)
> >> +                                               return r;
> >> +                               }
> >> +                       }
> >> +               }
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >>  static int gfx_v12_1_hw_fini(struct amdgpu_ip_block *ip_block)  {
> >>         struct amdgpu_device *adev =3D ip_block->adev; @@ -2801,6
> >> +2833,7 @@ static int gfx_v12_1_hw_fini(struct amdgpu_ip_block
> >> *ip_block)
> >>
> >>         amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
> >>         amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> >> +       gfx_v12_1_set_userq_eop_interrupts(adev, false);
> >>
> >>         num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> >>         for (i =3D 0; i < num_xcc; i++) { @@ -2868,10 +2901,26 @@ stat=
ic
> >> int gfx_v12_1_early_init(struct amdgpu_ip_block *ip_block)  {
> >>         struct amdgpu_device *adev =3D ip_block->adev;
> >>
> >> +
> >> +       switch (amdgpu_user_queue) {
> >> +       case -1:
> >> +       default:
> >> +               adev->gfx.disable_kq =3D true;
> >> +               adev->gfx.disable_uq =3D true;
> >> +               break;
>
> This disables both user queue and kernel queue by default.
> Is it expected?

Yes.  there's not really a need for kernel queues or KGD user queues
in this case.

Alex

>
> Regards
> Lang
>
> >> +       case 0:
> >> +               adev->gfx.disable_kq =3D false;
> >> +               adev->gfx.disable_uq =3D true;
> >> +               break;
> >> +       }
> >> +
> >>         adev->gfx.funcs =3D &gfx_v12_1_gfx_funcs;
> >>
> >> -       adev->gfx.num_compute_rings =3D min(amdgpu_gfx_get_num_kcq(ade=
v),
> >> -                                         AMDGPU_MAX_COMPUTE_RINGS);
> >> +       if (adev->gfx.disable_kq)
> >> +               adev->gfx.num_compute_rings =3D 0;
> >> +       else
> >> +               adev->gfx.num_compute_rings =3D min(amdgpu_gfx_get_num=
_kcq(adev),
> >> +
> >> + AMDGPU_MAX_COMPUTE_RINGS);
> >>
> >>         gfx_v12_1_set_kiq_pm4_funcs(adev);
> >>         gfx_v12_1_set_ring_funcs(adev); @@ -2898,6 +2947,10 @@ static
> >> int gfx_v12_1_late_init(struct amdgpu_ip_block *ip_block)
> >>         if (r)
> >>                 return r;
> >>
> >> +       r =3D gfx_v12_1_set_userq_eop_interrupts(adev, true);
> >> +       if (r)
> >> +               return r;
> >> +
> >>         return 0;
> >>  }
> >>
> >> @@ -3719,29 +3772,31 @@ static void gfx_v12_1_handle_priv_fault(struct
> >amdgpu_device *adev,
> >>         if (xcc_id =3D=3D -EINVAL)
> >>                 return;
> >>
> >> -       switch (me_id) {
> >> -       case 0:
> >> -               for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> >> -                       ring =3D &adev->gfx.gfx_ring[i];
> >> -                       /* we only enabled 1 gfx queue per pipe for no=
w */
> >> -                       if (ring->me =3D=3D me_id && ring->pipe =3D=3D=
 pipe_id)
> >> -                               drm_sched_fault(&ring->sched);
> >> -               }
> >> -               break;
> >> -       case 1:
> >> -       case 2:
> >> -               for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> >> -                       ring =3D &adev->gfx.compute_ring
> >> +       if (!adev->gfx.disable_kq) {
> >> +               switch (me_id) {
> >> +               case 0:
> >> +                       for (i =3D 0; i < adev->gfx.num_gfx_rings; i++=
) {
> >> +                               ring =3D &adev->gfx.gfx_ring[i];
> >> +                               /* we only enabled 1 gfx queue per pip=
e for now */
> >> +                               if (ring->me =3D=3D me_id && ring->pip=
e =3D=3D pipe_id)
> >> +                                       drm_sched_fault(&ring->sched);
> >> +                       }
> >> +                       break;
> >> +               case 1:
> >> +               case 2:
> >> +                       for (i =3D 0; i < adev->gfx.num_compute_rings;=
 i++) {
> >> +                               ring =3D &adev->gfx.compute_ring
> >>                                         [i +
> >>                                          xcc_id * adev->gfx.num_comput=
e_rings];
> >> -                       if (ring->me =3D=3D me_id && ring->pipe =3D=3D=
 pipe_id &&
> >> -                           ring->queue =3D=3D queue_id)
> >> -                               drm_sched_fault(&ring->sched);
> >> +                               if (ring->me =3D=3D me_id && ring->pip=
e =3D=3D pipe_id &&
> >> +                                   ring->queue =3D=3D queue_id)
> >> +                                       drm_sched_fault(&ring->sched);
> >> +                       }
> >> +                       break;
> >> +               default:
> >> +                       BUG();
> >> +                       break;
> >>                 }
> >> -               break;
> >> -       default:
> >> -               BUG();
> >> -               break;
> >>         }
> >>  }
> >>
> >> --
> >> 2.52.0
> >>
