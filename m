Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B347C3DA5D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 13:59:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3AA010E215;
	Mon, 22 Jul 2024 13:59:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TAStJeEs";
	dkim-atps=neutral
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E533C10E215
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 13:59:00 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id
 5614622812f47-3cabac56b38so2764597b6e.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 06:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721656740; x=1722261540; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X03gXzx5jQhGV8fc9lZT+c16HBytE26sagbbeBG8cAg=;
 b=TAStJeEsDkWbTbNEaZh7pjzdfyJpn9UZxxBR/alO/Hhd3WUKopkK7JZxnojya6awWj
 47ZkQEeQjTFpwTXGpvJxHhsqz6rcxGbalWqrrYSTl+o48mIXgQ379mGx5LgwC3J/KLei
 rjOEB2QJANCbmZZoiLQbl+ZioIO7+Q5KvV3tgEVW5QrCG1KOpYVUv6kZDuoVKUldrlvg
 0i7RGwYnAcke4hWWNrxn6DvNCCzO+Zwmnz4gfR0qnk725eKy6JBYGyrJDu5bVG/nyF5h
 sDGYOxBZkhm3elxq+IOPpEY0H4DIuh2XeVErMs36l633yBLnIJPvYGyBd2Z4H7RuBAfc
 A9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721656740; x=1722261540;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X03gXzx5jQhGV8fc9lZT+c16HBytE26sagbbeBG8cAg=;
 b=JiwYXPu6dlGya05i/8KuPxW+3jCmNPPXkXfCihXj17922FODCFaIVAspFRsUr6+uWP
 K1lEPjI1bZrzuIvW6D9Z1xBkCaU3nezctP72EXEcvWiJzvIPVhFIlmRQNscuR6YHxrg4
 VNYav9FDSIv2tovRnIqix1xkwr3KpBex4UVtB9754f3pMuZ991bCHMfYbzQSw9knbbSw
 Clr/yRzj7jtFkcgyuGY9WJjZOhTQaZQnN8gJ8iCGvdQxcDiS39dGLBG0nEVyyHAOxRbi
 bjvbnkyCB9UjY0Vb5xxTOgtUW6CqIXsdyDiv3yXfmAqIm55ldAPBT2P9jccFvRoz1gaY
 +tHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY3gArvWlfBfsJJP9vCo7uKrqDIgMP96DsUszD2C2Mf8vFhlNOdlucgR4u5wDvYoLMO/MRPmjerS5Lgq1QK5jAMFH3pdniwrI2WRlcPQ==
X-Gm-Message-State: AOJu0Yy8fFIo5M8Qx+mBFZ0TI6zymjAcBP6eZ+6fZIdDsTVy1Nrfqe3d
 ejoUaeN+WT+5WHuu2t60wcFQRnQFi7889xnDyzkXCHnaP69eS/KHQKQk5e+o0Hyw1S31lipLYHj
 JCsh2LLk8RbsSBPx0wU5PSbLPSKo=
X-Google-Smtp-Source: AGHT+IEqz3X0QM5TKoy8VcWaUZMaJlJK0aWbJbvZ7wdFOsMGAJKYo8pkuB6h7GrhEmTExFZHJ7C7PwwvpwQeyZRluK4=
X-Received: by 2002:a05:6808:124a:b0:3d5:5f8b:4ff2 with SMTP id
 5614622812f47-3dae974daa1mr7445264b6e.24.1721656738865; Mon, 22 Jul 2024
 06:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240717204011.15342-1-alexander.deucher@amd.com>
 <20240717204011.15342-2-alexander.deucher@amd.com>
 <e3c11386-ddf6-47ab-8416-39694936db3f@gmail.com>
In-Reply-To: <e3c11386-ddf6-47ab-8416-39694936db3f@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 Jul 2024 09:58:46 -0400
Message-ID: <CADnq5_N1RC6KQXihY6_JV770vD7oOR8iZL8CED_xw79SFacGyw@mail.gmail.com>
Subject: Re: [PATCH 2/6] drm/amdgpu/gfx11: Enable bad opcode interrupt
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Jesse Zhang <jesse.zhang@amd.com>, Prike Liang <Prike.Liang@amd.com>
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

On Mon, Jul 22, 2024 at 9:55=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 17.07.24 um 22:40 schrieb Alex Deucher:
> > From: Jesse Zhang <jesse.zhang@amd.com>
> >
> > For the bad opcode case, it will cause CP/ME hang.
> > The firmware will prevent the ME side from hanging by raising a bad opc=
ode interrupt.
> > And the driver needs to perform a vmid reset when receiving the interru=
pt.
> >
> > v2: update irq naming (drop priv) (Alex)
> >
> > Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> > Reviewed-by: Prike Liang <Prike.Liang@amd.com>
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 73 +++++++++++++++++++++++++=
+
> >   1 file changed, 73 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v11_0.c
> > index 02efa475eb7e..ce5cb60b8628 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > @@ -1569,6 +1569,13 @@ static int gfx_v11_0_sw_init(void *handle)
> >       if (r)
> >               return r;
> >
> > +     /* Bad opcode Event */
> > +     r =3D amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GRBM_CP,
> > +                           GFX_11_0_0__SRCID__CP_BAD_OPCODE_ERROR,
> > +                           &adev->gfx.bad_op_irq);
> > +     if (r)
> > +             return r;
> > +
> >       /* Privileged reg */
> >       r =3D amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GRBM_CP,
> >                             GFX_11_0_0__SRCID__CP_PRIV_REG_FAULT,
> > @@ -4646,6 +4653,7 @@ static int gfx_v11_0_hw_fini(void *handle)
> >
> >       amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
> >       amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> > +     amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
> >
> >       if (!adev->no_hw_access) {
> >               if (amdgpu_async_gfx_ring) {
> > @@ -5002,6 +5010,9 @@ static int gfx_v11_0_late_init(void *handle)
> >       if (r)
> >               return r;
> >
> > +     r =3D amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
> > +     if (r)
> > +             return r;
> >       return 0;
> >   }
> >
> > @@ -6293,6 +6304,51 @@ static int gfx_v11_0_set_priv_reg_fault_state(st=
ruct amdgpu_device *adev,
> >       return 0;
> >   }
> >
> > +static int gfx_v11_0_set_bad_op_fault_state(struct amdgpu_device *adev=
,
> > +                                         struct amdgpu_irq_src *source=
,
> > +                                         unsigned type,
> > +                                         enum amdgpu_interrupt_state s=
tate)
> > +{
> > +     u32 cp_int_cntl_reg, cp_int_cntl;
> > +     int i , j;
> > +
> > +     switch (state) {
> > +     case AMDGPU_IRQ_STATE_DISABLE:
> > +     case AMDGPU_IRQ_STATE_ENABLE:
>
> That switch is pretty pointless since state can only be disabled or enabl=
ed.
>
> Most likely just c&p from an older version of the code and at some point
> lost it's relevance.
>
> Apart from that the series looks good to me.

Yeah, all of the other irq functions follow that same model.  If you
feel strongly, I can change it.

Alex


>
> Regards,
> Christian.
>
> > +             for (i =3D 0; i < adev->gfx.me.num_me; i++) {
> > +                     for (j =3D 0; j < adev->gfx.me.num_pipe_per_me; j=
++) {
> > +                             cp_int_cntl_reg =3D gfx_v11_0_get_cpg_int=
_cntl(adev, i, j);
> > +
> > +                             if (cp_int_cntl_reg) {
> > +                                     cp_int_cntl =3D RREG32_SOC15_IP(G=
C, cp_int_cntl_reg);
> > +                                     cp_int_cntl =3D REG_SET_FIELD(cp_=
int_cntl, CP_INT_CNTL_RING0,
> > +                                                                 OPCOD=
E_ERROR_INT_ENABLE,
> > +                                                                 state=
 =3D=3D AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
> > +                                     WREG32_SOC15_IP(GC, cp_int_cntl_r=
eg, cp_int_cntl);
> > +                             }
> > +                     }
> > +             }
> > +             for (i =3D 0; i < adev->gfx.mec.num_mec; i++) {
> > +                     for (j =3D 0; j < adev->gfx.mec.num_pipe_per_mec;=
 j++) {
> > +                             /* MECs start at 1 */
> > +                             cp_int_cntl_reg =3D gfx_v11_0_get_cpc_int=
_cntl(adev, i + 1, j);
> > +
> > +                             if (cp_int_cntl_reg) {
> > +                                     cp_int_cntl =3D RREG32_SOC15_IP(G=
C, cp_int_cntl_reg);
> > +                                     cp_int_cntl =3D REG_SET_FIELD(cp_=
int_cntl, CP_ME1_PIPE0_INT_CNTL,
> > +                                                                 OPCOD=
E_ERROR_INT_ENABLE,
> > +                                                                 state=
 =3D=3D AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
> > +                                     WREG32_SOC15_IP(GC, cp_int_cntl_r=
eg, cp_int_cntl);
> > +                             }
> > +                     }
> > +             }
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +     return 0;
> > +}
> > +
> >   static int gfx_v11_0_set_priv_inst_fault_state(struct amdgpu_device *=
adev,
> >                                              struct amdgpu_irq_src *sou=
rce,
> >                                              unsigned int type,
> > @@ -6369,6 +6425,15 @@ static int gfx_v11_0_priv_reg_irq(struct amdgpu_=
device *adev,
> >       return 0;
> >   }
> >
> > +static int gfx_v11_0_bad_op_irq(struct amdgpu_device *adev,
> > +                             struct amdgpu_irq_src *source,
> > +                             struct amdgpu_iv_entry *entry)
> > +{
> > +     DRM_ERROR("Illegal opcode in command stream \n");
> > +     gfx_v11_0_handle_priv_fault(adev, entry);
> > +     return 0;
> > +}
> > +
> >   static int gfx_v11_0_priv_inst_irq(struct amdgpu_device *adev,
> >                                  struct amdgpu_irq_src *source,
> >                                  struct amdgpu_iv_entry *entry)
> > @@ -6747,6 +6812,11 @@ static const struct amdgpu_irq_src_funcs gfx_v11=
_0_priv_reg_irq_funcs =3D {
> >       .process =3D gfx_v11_0_priv_reg_irq,
> >   };
> >
> > +static const struct amdgpu_irq_src_funcs gfx_v11_0_bad_op_irq_funcs =
=3D {
> > +     .set =3D gfx_v11_0_set_bad_op_fault_state,
> > +     .process =3D gfx_v11_0_bad_op_irq,
> > +};
> > +
> >   static const struct amdgpu_irq_src_funcs gfx_v11_0_priv_inst_irq_func=
s =3D {
> >       .set =3D gfx_v11_0_set_priv_inst_fault_state,
> >       .process =3D gfx_v11_0_priv_inst_irq,
> > @@ -6764,6 +6834,9 @@ static void gfx_v11_0_set_irq_funcs(struct amdgpu=
_device *adev)
> >       adev->gfx.priv_reg_irq.num_types =3D 1;
> >       adev->gfx.priv_reg_irq.funcs =3D &gfx_v11_0_priv_reg_irq_funcs;
> >
> > +     adev->gfx.bad_op_irq.num_types =3D 1;
> > +     adev->gfx.bad_op_irq.funcs =3D &gfx_v11_0_bad_op_irq_funcs;
> > +
> >       adev->gfx.priv_inst_irq.num_types =3D 1;
> >       adev->gfx.priv_inst_irq.funcs =3D &gfx_v11_0_priv_inst_irq_funcs;
> >
>
