Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F10CC6B38
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 19:01:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ECAC10E2EA;
	Thu, 15 Oct 2026 19:01:50 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1579E10E2EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 19:01:45 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-355724d032fso650751eec.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 12:01:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792090904; cv=none;
 d=google.com; s=arc-20260327;
 b=i4s6nqSqh8F/pZPZwq6jEiMCgogMG7bD5MoMkhCpqcaRumMYweDk6JuVoxvDWJ3HYY
 ImFi8qRxvXVJYa7L/yp54vdmChlu+F8bu4uztqzbHuEJTJzeHg9BqDhfDGzruDhzffiQ
 nEiXgYtV2lpZmMHUQ02/8KE4BWG6O14XIck8cz3FWo2y3y71yBnxnU3Hedvg+ZpGcxxz
 sTDzKFKMs+VfNEwB8K1X25GeerUWTrC5OGxGmocHbe8xmn1BGuV1lizk58Zm9Ks4rHzB
 y8qef8qjhQf55I2iO1VAVwJOE5p2gWf9xR9DpYCwKWD/wIWg3sd7yEJttWNT2AA1stAL
 H02g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GSqlEIsMMPdLgM90yMu9rfnGiqltcVn6qKzNnPCW0EY=;
 fh=a2f/LvdhjqUeRcRNYsvv98+ed8stCgzmhl320sJJ1jw=;
 b=an3OJRtiuHE1H0j48Wz1fhApE/VlZrbsIb1xMX8FMsZKM+0NJpesBmKCxgv7J4KOlz
 0iMGzOMfrnzAERvv4uGKMad77WxNtZyhUlJK8DFt4r2Wzug7Bi3lz7Fxp6sbJdkQhnyQ
 uqETQ6kZbRCG+mh6J87MTeY2bALlsXfRFfDn5EelwM6GDV7s4qyJxuXqrRB+ujXcQdJ4
 ++P6xzPFaX1EBcJ/Fq3RfKJimROghzDbIi0/YTnp9qCBRO7ruY77931cj5BXeJPB67ms
 6XI5HISRMs/iFwbNmLzQeAQHWo9IXTKLlPaJSqHGW6SInIxA1RbcM4xme1Ozg1ImsjYe
 PXKg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792090904; x=1792695704; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GSqlEIsMMPdLgM90yMu9rfnGiqltcVn6qKzNnPCW0EY=;
 b=GR8vpf2Ktbzcd6zQ6aApnR5GkYKMBbE+Tk/po9uTYbXmQevroCvQQrHDgtVm/A4D26
 Rr48TrNYbzqpV9rUx5cG0/cad8CVB+DQ4DUtk0ZfQ21IjNEUYa8YsfWG8W8itT4OmQuD
 NUWygbGGYgj3+Du5FTTCeDiHuMnotxZYBD8iYYKwiqaVxJCNtyVydlkK+I95WDBEUTFP
 cdiwX9XACBtCswNK7yf0a+g7ALxM0r3gEb9J6IislEBPlBezxno676Nk/Q5bw77UnGpy
 9LV5oykeNbNihry/+53SbVuEQ6lOkZXJndvQP0E3B+ZojGngYl3UUyNuZiIB/iESFGck
 q66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792090904; x=1792695704;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GSqlEIsMMPdLgM90yMu9rfnGiqltcVn6qKzNnPCW0EY=;
 b=m7nSpWijduKw2rFjyLwYANBk4yvjWGQEF64Frd3qbh/eLRqtekhaZ9gXCB1ek5Q9Bo
 cC+NzxYmqrjoU6d+UmDw0HhFhlSnJt85wp1wOWu/j7IoAxTftZddkamGDiuR6M9Z16FT
 lODz3XLRtnEJ7A1zQhVaLAQT5oL+QHIRojSztJwOASNL3mh04Go0NSlU53JmwgrHTYsT
 0bGIZtwqET25odObAY8JehI0NkE1EqEpDHyYmVtbe2AvgDeIqoKqwIIbmm7gONFTuDUm
 GlYI+dDntRn5BjVqr/vi7cEQKG7Qa2Etjmn8j2o59cDwEp2r9AtYYRCGW831yjtfZ1tB
 sw4w==
X-Gm-Message-State: AFq9FYJcKBo9uwXvWSbwbHLU0a4aFSDwPaBRyj3I7VR2z5Nky3l8glG2
 PNMU5SdFPhwPN+eOGM+wmg1J/vHpnMOSqaSyzmfX7GshrYX176TNLcOcb4oAd8Y1dEiVy+sV16i
 QarvlpKY5sCzVuGXwccWGfLzBV9z4iyY=
X-Gm-Gg: AYBFou3WWBu4jC9eYAgnFEd11evx9GMKZ+CkVp6/uu9lro6ZkqsLOzkGSYW+ehI/Bav
 5SuYkWQtlpQeuT1OlUpTaP6CZ4RZROGCFNeeiA3DsbW8f4BQ8aq+ZHA/4HSOTbq0W4vsytnmQV/
 oIihdJlEEj14a3Uad/VII644YKZlXxbwrGWiY4CqtAlEqteAmTK777sQZXNfR710Mqn65QUlSNn
 EtF+kNF+MBg+CVAgdsHMBxozYoebfpER3fxgLTa7D0530OIKuBPz7AJoLpCXZ1hue3EjTSiqDRx
 qnwY14Of96G01EHeoAorjy/pKvxS9jECe8GrysKjezQE8RzkNu9xNRlT4M4w4CeJen8xKmbC+7O
 yZhKHSEBmIageMIyA5IAF0hK/vsOqE7heZ2/pGrm2ow==
X-Received: by 2002:a05:7022:b043:10b0:127:def:dd72 with SMTP id
 a92af1059eb24-16a5ce9584bmr43025431c88.2.1792090903859; Thu, 15 Oct 2026
 12:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <BN9PR12MB514681E5EDA768CB4497EACFF79D2@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20261015095713.20560-1-qchcio@gmail.com>
 <20261015095713.20560-4-qchcio@gmail.com>
 <CADnq5_NXGqXy7_Ntcv0aGSQt8Ax48-SgWpSv4rTzNjDL-H_8_Q@mail.gmail.com>
In-Reply-To: <CADnq5_NXGqXy7_Ntcv0aGSQt8Ax48-SgWpSv4rTzNjDL-H_8_Q@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Oct 2026 15:01:32 -0400
X-Gm-Features: AclHuK9bE7jG8TbUbXHQL5KZs85YwSupOtLmmAUNi-mrYhsRs_NLi9NrkI6ruto
Message-ID: <CADnq5_Po1jXiuj7KWW3dWYEGQJmMx68ZMRzyBK7QFZcaL0Y_BA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/amdgpu: reset VI ASIC on Apple boards with
 VRAM at 0
To: Maciej Kucharek <qchcio@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, stable@vger.kernel.org
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

On Thu, Oct 15, 2026 at 9:26=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Thu, Oct 15, 2026 at 9:06=E2=80=AFAM Maciej Kucharek <qchcio@gmail.com=
> wrote:
> >
> > On MacBookPros with switchable graphics, the firmware puts VRAM at MC
> > address 0 when the iGPU is enabled.  A later post (S3 resume, GPU
> > reset) moves VRAM back to the VBIOS default.  gmc_v8_0 reads
> > MC_VM_FB_LOCATION once at init and reprograms it only on SR-IOV.  On
> > bare metal, the driver then keeps using the old layout.
> >
> > vi_reset_quirks[] handles this for the MacBookPro14,3 by PCI ID:
> >
> >   commit a22e5e4f2ebb ("drm/amdgpu: reset VI ASIC on MacBookPro14,3")
> >
> > Add the test that SI and CIK use: an Apple subsystem vendor and VRAM at
> > 0.  Other Polaris MacBookPros then get the same reset at load, for
> > example the MacBookPro13,3 if its firmware leaves VRAM at 0.  These
> > boards are not tested.
> >
> > Keep vi_reset_quirks[].  Its MacBookPro15,1 entries fix a different
> > failure, a module reload after S3:
> >
> >   commit a5be7ad8f5f0 ("drm/amdgpu: reset VI ASIC on MacBookPro15,1")
> >
> > VRAM is not at 0 at that point, so the new test may not cover it.
> >
> > After the reset, FB_BASE is not 0, so the new test does not fire again
> > on a module reload.
> >
> > Only compile-tested.
> >
> > Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> > Cc: stable@vger.kernel.org
> > Assisted-by: Claude:claude-opus-5-5
> > Signed-off-by: Maciej Kucharek <qchcio@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/vi.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdg=
pu/vi.c
> > index a0435fd55..cad6bbfce 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> > @@ -1405,6 +1405,16 @@ static bool vi_need_reset_on_init(struct amdgpu_=
device *adev)
> >         unsigned int i;
> >         u32 clock_cntl, pc;
> >
> > +       /*
> > +        * MacBookPros with switchable graphics put VRAM at 0 when the =
iGPU
> > +        * is enabled.  Any later post (S3 resume, GPU reset) moves it =
back to
> > +        * the vbios default, so reset and post on load to start with t=
he
> > +        * vbios layout.
> > +        */
> > +       if (adev->pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_APPLE &&
> > +           !(RREG32(mmMC_VM_FB_LOCATION) & MC_VM_FB_LOCATION__FB_BASE_=
MASK))
> > +               return true;
> > +
> >         for (i =3D 0; i < ARRAY_SIZE(vi_reset_quirks); i++)
> >                 if (adev->pdev->device =3D=3D vi_reset_quirks[i].device=
 &&
> >                     adev->pdev->subsystem_vendor =3D=3D vi_reset_quirks=
[i].subsystem_vendor &&
>
> Please drop the now duplicate quirk handling here.

After re-reading your commit message and thinking about it more, I've
decided to take v1.  Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
and applied.

Thanks!

Alex

>
> Thanks,
>
> Alex
>
> > --
> > 2.55.0
> >
