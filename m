Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C50EF8FED
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 14:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1323610E9FC;
	Wed,  4 Mar 2026 14:34:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aBTh3JeS";
	dkim-atps=neutral
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8D5C10E9FC
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 14:34:22 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2bd801b40dbso528542eec.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Mar 2026 06:34:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772634862; cv=none;
 d=google.com; s=arc-20240605;
 b=eEVVPJxhglCk1uLCODZcdI1uiJHfAncIPifcO/QxVDSuvJkXGVFEee9M7bX1z5KqJy
 lOPL0awZZg2giuXtoo7AIs+3mkFtUNQyOm782INcfRNJYJQ/pVLGpaPO57RhqORTdt1Z
 dYfgEvW8xKTWmVvtgNo5inuGmBVkjDpDerqhTXFTi2ij9v7g5XZsA+9iUzkxljXUGmNy
 F4Zgk+ZUcg+Cy3tb3ZnaRq4bLeL86dI1FRoaVisVARtWtYrfJkGvYj2XgLM58+TYlk+O
 Sqsl+a7jhN7pOtA36lFWTF0ccXYwGUUdmfRuZJUHc86g9mTtM3vmlT0pr5nbEiJVP+uI
 /FmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=D2oGVFuTiIHH1g06Y96JiIqgEDCKHZBmp3pZpk54MHY=;
 fh=fHc3JtneCT5wIcwEQQJBXRIFMPt/s58A2hMdRroa3Ck=;
 b=Dcuh1ym4OMce329Y0Q509LxX7+mCdbCphwOcB0JQAvs04VOkPpmv6CsWUDdNDQeSFC
 dD8Iw6TSUCVlIO7oPN8Tn0LbuYzhOnddd4cKZYVHr62EHOOh6Lbm/3zvQobb9xBm8QEu
 BqfYM7sRdjCZduUlFixvK5VKgazyNeXcnEfh+oaLMXO8ILGl2+3/Zr+r6oOhSebPOQO6
 dOCDCsHfivQMN81/QHw+qcPR3dL8Vb9B0b2hBaWkhXd0sB56eBXQZBaSK6HhIs7hmpO4
 E1UGh3Gt9sUq1L1INPYHNk9dtCyH8VP0VxZxZ+MTC3UHHqFJvoZOET8oppXWxNnlR1I4
 XXgQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772634862; x=1773239662; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D2oGVFuTiIHH1g06Y96JiIqgEDCKHZBmp3pZpk54MHY=;
 b=aBTh3JeSPiXAwLRd/TapHe17LWyZGmUhkBvINb3IxIy2B2vAG+XsCbHMm3cZhVUNQt
 siPmBFHklXi+rFakUlRxUHFwHifUDTlF3v0qptz/yUoznENy10M+pUKhv3Zole46p4aX
 puaC5IXsVz2x6+Y8jOVdNlDgbkAs0kFAO7tDg+0W5f6eEgbAK75UcgGGmCJU8OpLDmUq
 G/Akd626B33C+KhrpArGkbDWqfs7AkEoIwjiFl3xum8SO7Um2MxtE30NzcyAfOLlHjJG
 TdNeBdEmFEZFjYfA160LwNCjckYKrj7AprP+VfUmhCeIVW1P/flKZ/dk8FaBEzqGZ+Uf
 qhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772634862; x=1773239662;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D2oGVFuTiIHH1g06Y96JiIqgEDCKHZBmp3pZpk54MHY=;
 b=aP9geEMgH3ZpQAyXDAhJg9sFLvdtsceOp68ve046RoN9wSnssMM+R9wUi/XaNdhT7r
 hYKjxTbcMoTF2KVVQBBT0o8aTK+/lY0LZjlkjRfjosSkQ9mjuwjYoDY9kCt5ocvPQiMA
 fHxb4B22ASl7xVqi0ffWZHl4JNEpMxRGtBv+qIPONrGoEdLTJ2dsMc8V0ZusYpsbPCBt
 C3MqIOPm/WSL3xohLD+WMcJa6CpQ/OZdVN7pnm7ENbSRgC7SclGa014Ol+sjOOJTz56Y
 aI2W/x5pA0v+NsVkMKuK+CA/3kiC1ODarRwQXW97ET8c1+MxpEYgzlutx62IM+WYps+q
 M5fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8XuQiQVvHsexO+LpW8Pt9HEZFY9AaFUTwv8wxib8eN5PN8IpzC8Tb3BZ1YMb5C2YsxwvTJQGz@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJKNVsSxoL0srNPYynSsoqbdNaOlCH7w3tjw4v++g7sicSwWEe
 TFKB1Q7c7F+3dm8rql+ttErJiIYS+RUeadqY1bfqpQmIez1X/LvUAVzmJH7OU1dzJrMXyXuBWBE
 UVj2hfzQWdkuBBkKgt/FhYk/93Q76BO8=
X-Gm-Gg: ATEYQzyRp2/Sgn4mmw9/O4AXI7d3oUJeXShIy5dhL2ycwy0JvSTQr17dLsoY9ryWf5s
 xAABkNTRdkp/62MXlQ6g+Lyt9ZLm30HVNTlOHJR8IklipmTV3QDDw2379t2yskb9qVe+NgfXseE
 /WLXXSSJUK9BhtIC0UevIS4pdGZffRDMRV53biUbZ6rPk5uE06MGXxhKKMxPAkdzkkNIaUGLZ+n
 ldAdcIeY9P2wRmc2lstFZMjzrnkVcQMBsS27SoG9/aKtVsPbSwcEY2oT517E8CYxEAnKwiUzY7W
 cQeYLtpT3ov6qC4mJSdGwKkTRidNtBhmI1QsRrctk+c8totykqg6MsYCd7OIeycY1nPjyA==
X-Received: by 2002:a05:7022:2224:b0:123:308f:667b with SMTP id
 a92af1059eb24-128b707b6dbmr503806c88.2.1772634862009; Wed, 04 Mar 2026
 06:34:22 -0800 (PST)
MIME-Version: 1.0
References: <20260128195327.2158888-1-alexander.deucher@amd.com>
 <CADnq5_Obq9LW2TrvB0y8ELha1BubjWz9n2sh59Zr2NRN+EZoWQ@mail.gmail.com>
 <MW6PR12MB8898534497BC30024E6704BBFB7CA@MW6PR12MB8898.namprd12.prod.outlook.com>
 <CADnq5_Ogo6-veXYze_t4PJJ-PaWefCFHSZ1JMJZLGMniZzSAPA@mail.gmail.com>
 <MW6PR12MB889871CDCB52DB3CD24CE612FB7CA@MW6PR12MB8898.namprd12.prod.outlook.com>
In-Reply-To: <MW6PR12MB889871CDCB52DB3CD24CE612FB7CA@MW6PR12MB8898.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Mar 2026 09:34:08 -0500
X-Gm-Features: AaiRm526C1-YasRqIRZ9NPzNviN6JM-708pwuhjplyny2FMg6aOOfOjozj7xshc
Message-ID: <CADnq5_NVB_xSPKXoL2LvhWrJSAOD7Qzg93uH1hiXPvgpp2NA=w@mail.gmail.com>
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

On Tue, Mar 3, 2026 at 10:52=E2=80=AFPM Yu, Lang <Lang.Yu@amd.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> >-----Original Message-----
> >From: Alex Deucher <alexdeucher@gmail.com>
> >Sent: Wednesday, March 4, 2026 10:48 AM
> >To: Yu, Lang <Lang.Yu@amd.com>
> >Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> >gfx@lists.freedesktop.org
> >Subject: Re: [PATCH] drm/amdgpu/gfx12.1: add support for disable_kq
> >
> >On Tue, Mar 3, 2026 at 9:02=E2=80=AFPM Yu, Lang <Lang.Yu@amd.com> wrote:
> >>
> >> [AMD Official Use Only - AMD Internal Distribution Only]
> >>
> >> >-----Original Message-----
> >> >From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> >> >Alex Deucher
> >> >Sent: Tuesday, March 3, 2026 11:23 PM
> >> >To: Deucher, Alexander <Alexander.Deucher@amd.com>
> >> >Cc: amd-gfx@lists.freedesktop.org
> >> >Subject: Re: [PATCH] drm/amdgpu/gfx12.1: add support for disable_kq
> >> >
> >> >Ping?
> >> >
> >> >Alex
> >> >
> >> >On Wed, Jan 28, 2026 at 3:12=E2=80=AFPM Alex Deucher
> >> ><alexander.deucher@amd.com>
> >> >wrote:
> >> >>
> >> >> Plumb in support for disabling kernel queues and make it the defaul=
t.
> >> >> For testing, kernel queues can be re-enabled by setting
> >> >> amdgpu.user_queue=3D0
> >> >>
> >> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> >> ---
> >> >>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 109
> >> >> +++++++++++++++++++------
> >> >>  1 file changed, 82 insertions(+), 27 deletions(-)
> >> >>
> >> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> >> >> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> >> >> index 08ae50a6313f3..f93ee275ce398 100644
> >> >> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> >> >> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> >> >> @@ -1155,11 +1155,13 @@ static int gfx_v12_1_sw_init(struct
> >> >> amdgpu_ip_block
> >> >*ip_block)
> >> >>                 break;
> >> >>         }
> >> >>
> >> >> -       /* recalculate compute rings to use based on hardware confi=
guration */
> >> >> -       num_compute_rings =3D (adev->gfx.mec.num_pipe_per_mec *
> >> >> -                            adev->gfx.mec.num_queue_per_pipe) / 2;
> >> >> -       adev->gfx.num_compute_rings =3D min(adev->gfx.num_compute_r=
ings,
> >> >> -                                         num_compute_rings);
> >> >> +       if (adev->gfx.num_compute_rings) {
> >> >> +               /* recalculate compute rings to use based on hardwa=
re configuration
> >*/
> >> >> +               num_compute_rings =3D (adev->gfx.mec.num_pipe_per_m=
ec *
> >> >> +                                    adev->gfx.mec.num_queue_per_pi=
pe) / 2;
> >> >> +               adev->gfx.num_compute_rings =3D min(adev->gfx.num_c=
ompute_rings,
> >> >> +                                                 num_compute_rings=
);
> >> >> +       }
> >> >>
> >> >>         num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> >> >>
> >> >> @@ -2794,6 +2796,36 @@ static void gfx_v12_1_xcc_fini(struct
> >> >> amdgpu_device
> >> >*adev,
> >> >>         gfx_v12_1_xcc_enable_gui_idle_interrupt(adev, false,
> >> >> xcc_id); }
> >> >>
> >> >> +static int gfx_v12_1_set_userq_eop_interrupts(struct amdgpu_device=
 *adev,
> >> >> +                                             bool enable) {
> >> >> +       unsigned int irq_type;
> >> >> +       int m, p, r, x, num_xcc;
> >> >> +
> >> >> +       if (adev->gfx.disable_kq) {
> >> >> +               num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> >> >> +               for (x =3D 0; x < num_xcc; x++) {
> >> >> +                       for (m =3D 0; m < adev->gfx.mec.num_mec; ++=
m) {
> >> >> +                               for (p =3D 0; p < adev->gfx.mec.num=
_pipe_per_mec; p++) {
> >> >> +                                       irq_type =3D
> >> >AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
> >> >> +                                               + (m * adev->gfx.me=
c.num_pipe_per_mec)
> >> >> +                                               + p;
> >> >> +                                       if (enable)
> >> >> +                                               r =3D amdgpu_irq_ge=
t(adev, &adev->gfx.eop_irq,
> >> >> +                                                                  =
irq_type);
> >> >> +                                       else
> >> >> +                                               r =3D amdgpu_irq_pu=
t(adev, &adev->gfx.eop_irq,
> >> >> +                                                                  =
irq_type);
> >> >> +                                       if (r)
> >> >> +                                               return r;
> >> >> +                               }
> >> >> +                       }
> >> >> +               }
> >> >> +       }
> >> >> +
> >> >> +       return 0;
> >> >> +}
> >> >> +
> >> >>  static int gfx_v12_1_hw_fini(struct amdgpu_ip_block *ip_block)  {
> >> >>         struct amdgpu_device *adev =3D ip_block->adev; @@ -2801,6
> >> >> +2833,7 @@ static int gfx_v12_1_hw_fini(struct amdgpu_ip_block
> >> >> *ip_block)
> >> >>
> >> >>         amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
> >> >>         amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> >> >> +       gfx_v12_1_set_userq_eop_interrupts(adev, false);
> >> >>
> >> >>         num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> >> >>         for (i =3D 0; i < num_xcc; i++) { @@ -2868,10 +2901,26 @@
> >> >> static int gfx_v12_1_early_init(struct amdgpu_ip_block *ip_block)  =
{
> >> >>         struct amdgpu_device *adev =3D ip_block->adev;
> >> >>
> >> >> +
> >> >> +       switch (amdgpu_user_queue) {
> >> >> +       case -1:
> >> >> +       default:
> >> >> +               adev->gfx.disable_kq =3D true;
> >> >> +               adev->gfx.disable_uq =3D true;
> >> >> +               break;
> >>
> >> This disables both user queue and kernel queue by default.
> >> Is it expected?
> >
> >Yes.  there's not really a need for kernel queues or KGD user queues in =
this case.
>
> Thanks.  This also disables the sanity test (ring/ib) test in kernel by d=
efault one of kernel queue's functionality.

Yes, but we don't want to enable kernel queues for this IP.

Alex

>
> Regards
> Lang
>
> >Alex
> >
> >>
> >> Regards
> >> Lang
> >>
> >> >> +       case 0:
> >> >> +               adev->gfx.disable_kq =3D false;
> >> >> +               adev->gfx.disable_uq =3D true;
> >> >> +               break;
> >> >> +       }
> >> >> +
> >> >>         adev->gfx.funcs =3D &gfx_v12_1_gfx_funcs;
> >> >>
> >> >> -       adev->gfx.num_compute_rings =3D min(amdgpu_gfx_get_num_kcq(=
adev),
> >> >> -                                         AMDGPU_MAX_COMPUTE_RINGS)=
;
> >> >> +       if (adev->gfx.disable_kq)
> >> >> +               adev->gfx.num_compute_rings =3D 0;
> >> >> +       else
> >> >> +               adev->gfx.num_compute_rings =3D
> >> >> + min(amdgpu_gfx_get_num_kcq(adev),
> >> >> +
> >> >> + AMDGPU_MAX_COMPUTE_RINGS);
> >> >>
> >> >>         gfx_v12_1_set_kiq_pm4_funcs(adev);
> >> >>         gfx_v12_1_set_ring_funcs(adev); @@ -2898,6 +2947,10 @@
> >> >> static int gfx_v12_1_late_init(struct amdgpu_ip_block *ip_block)
> >> >>         if (r)
> >> >>                 return r;
> >> >>
> >> >> +       r =3D gfx_v12_1_set_userq_eop_interrupts(adev, true);
> >> >> +       if (r)
> >> >> +               return r;
> >> >> +
> >> >>         return 0;
> >> >>  }
> >> >>
> >> >> @@ -3719,29 +3772,31 @@ static void
> >> >> gfx_v12_1_handle_priv_fault(struct
> >> >amdgpu_device *adev,
> >> >>         if (xcc_id =3D=3D -EINVAL)
> >> >>                 return;
> >> >>
> >> >> -       switch (me_id) {
> >> >> -       case 0:
> >> >> -               for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> >> >> -                       ring =3D &adev->gfx.gfx_ring[i];
> >> >> -                       /* we only enabled 1 gfx queue per pipe for=
 now */
> >> >> -                       if (ring->me =3D=3D me_id && ring->pipe =3D=
=3D pipe_id)
> >> >> -                               drm_sched_fault(&ring->sched);
> >> >> -               }
> >> >> -               break;
> >> >> -       case 1:
> >> >> -       case 2:
> >> >> -               for (i =3D 0; i < adev->gfx.num_compute_rings; i++)=
 {
> >> >> -                       ring =3D &adev->gfx.compute_ring
> >> >> +       if (!adev->gfx.disable_kq) {
> >> >> +               switch (me_id) {
> >> >> +               case 0:
> >> >> +                       for (i =3D 0; i < adev->gfx.num_gfx_rings; =
i++) {
> >> >> +                               ring =3D &adev->gfx.gfx_ring[i];
> >> >> +                               /* we only enabled 1 gfx queue per =
pipe for now */
> >> >> +                               if (ring->me =3D=3D me_id && ring->=
pipe =3D=3D pipe_id)
> >> >> +                                       drm_sched_fault(&ring->sche=
d);
> >> >> +                       }
> >> >> +                       break;
> >> >> +               case 1:
> >> >> +               case 2:
> >> >> +                       for (i =3D 0; i < adev->gfx.num_compute_rin=
gs; i++) {
> >> >> +                               ring =3D &adev->gfx.compute_ring
> >> >>                                         [i +
> >> >>                                          xcc_id * adev->gfx.num_com=
pute_rings];
> >> >> -                       if (ring->me =3D=3D me_id && ring->pipe =3D=
=3D pipe_id &&
> >> >> -                           ring->queue =3D=3D queue_id)
> >> >> -                               drm_sched_fault(&ring->sched);
> >> >> +                               if (ring->me =3D=3D me_id && ring->=
pipe =3D=3D pipe_id &&
> >> >> +                                   ring->queue =3D=3D queue_id)
> >> >> +                                       drm_sched_fault(&ring->sche=
d);
> >> >> +                       }
> >> >> +                       break;
> >> >> +               default:
> >> >> +                       BUG();
> >> >> +                       break;
> >> >>                 }
> >> >> -               break;
> >> >> -       default:
> >> >> -               BUG();
> >> >> -               break;
> >> >>         }
> >> >>  }
> >> >>
> >> >> --
> >> >> 2.52.0
> >> >>
