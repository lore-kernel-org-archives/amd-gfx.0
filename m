Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36ABE6BF13
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 14:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D57210EA07;
	Fri, 30 Jan 2026 14:49:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PYtTcoJH";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7F6F10EA07
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 14:49:10 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2b6aa67a792so356378eec.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 06:49:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769784550; cv=none;
 d=google.com; s=arc-20240605;
 b=NQlpFe5QQcW54uUFT1T/KO7k0HxNWnizEvkYsUdQ4mKCk/9jrCK0uDozONFcxNfhFS
 yMjP5pakFTdBigZyw9vrQqiTYjBL4YNxMgas71YqMAZUIcsEbgQ0CJRe4TRTDt0qmPfz
 /uAI7GGTzZciIvdKTWR2m0iqqXMZyQyLGwhJ7P087I22XhgDkZ/TBwsMNIS8kK9oaia8
 nSwRgP+n6u72vDQXokBsqQfo4jpO0eO8OZt10w8IXsOfUk6C3H8rr4pxfbUEYzPSZIEj
 hiDBTnpo9nEL5qzJIt3EWAHCFKCC2RnMdOfvP/W8FQEc2DD5NjR18wqkBp/NwWiLA7y2
 CMLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=avyUD0UewCl38FHDnXrUQ2wKiBvT4lA66knRbnNVi3Y=;
 fh=5LhxUvy9rmGCR9wvmCLTSJqJgkgYd/ZPIVhYvj1ADh4=;
 b=Hakm/vqyVS/soEqEXn/54htVBpKWXHW7yrNRFlmcwwInyWRg+R44BShh02M5923v0B
 36UPsIGC2ZAIMrblWqWsrwjI0biiWRR9K9IuY+Movzh7gooo2zC1/y836UB9b/Z5Yd0c
 oTxp3M6Dp9HyVqvOsKu+7kXXSj8thtnKAPt5lAs8wRnX3tJGr15B7T2koGu+/1Jzq4jx
 m1R0plnBeYl3J2LYAFVSPhBrQvmls6/M4wYcML0y1uTBvdg0thaHprb2HmOADYdEd5V/
 4CCXxSl64SBdMu80be8wwBkqF9FWRLO1fTbDt8smy4WfgdyQjENsMuY88JGWtZI7IEVo
 GEQw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769784550; x=1770389350; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=avyUD0UewCl38FHDnXrUQ2wKiBvT4lA66knRbnNVi3Y=;
 b=PYtTcoJHb179qeko1J6cmLkz/lgUtrkVkrwCBk0vPk1opJ/dwkJs+5dZpcRhEVCBaC
 he93wZv+ZllCyQBtMDztrTEOpqOgNvNltbi5T1vcddfQUHhRced0+OjB+/6l8yn4EMDI
 RqrH3S3oJtlIW7ObPZpa5MV4uzjaV2VOP5cJH1W391BymCtzfs2WUhY2E7JgWKgvOtZ0
 y8QdEPAAhuDwstvwRdOaIRAAvU4dTC8/y5/wFXf54I25X/XNE6T6UrpTvK/i+P5Kny6/
 AuyNY+yrI7GiDHuVqCMB7vGdi9XGuqspUEiqVxb4rwzGkaI5DiyF8IPKMWtscOoA01mw
 zAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769784550; x=1770389350;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=avyUD0UewCl38FHDnXrUQ2wKiBvT4lA66knRbnNVi3Y=;
 b=lEwG0/C5viLKregfhiqUXJ76OJWp/T7QIbSUr5a8wXs3sP7IMFqia14eEKeenRoNxT
 5cShz5vUGHdub9Eua1JVZ+4NzJHBUVl2mQUBnTJdI3ecGEePVhnB9jBIxlVcg3X4mId5
 HRexUBe4vUwd5W4rabnlt2DW3z4fjo4aG0n/JmfxhN3xBs9BSPA64Ah70WeTucm7GqVW
 dbStaQtFFuUKZqn4B3Ox4ltrwveTdlvqu51L0W0pKEVsFsfU0c7ZAoFG//CFtQ6dA6tA
 rYboc6jrI/7LR5+8Ou6URASgMPCHXUe4T93XkT3wpJPsK3fc2LtHD/8j5ELraDixF3am
 7o2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYUlTRLPQjuKmCy4/ZXZ10HWdzG9e2zBsMEuFgdbSlEgV3A4ZKjq1OPzA77R+DVhg3YxS9C5dF@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxedwSubrX8bd/+idIukaRIwDtmbpwX8eu8US8tYkjNwc4+bnVB
 v4aQMSqDYwLCTf/wR72BVAopCMa6sHkT7HnMQuBKkE1PQlfG0h1QKHOYX0XTPwMCktfhfYGukb3
 HpDLwA3ijq94SxkcX5fBzf50n/MomIAo=
X-Gm-Gg: AZuq6aIJh7qJZWpikJMuua2sCmQrB4kgpV0HUIuUTeA8sS2pyvUTuBvPdi6M3sZ8Jzo
 rnwb/XuoIf5JaNDDUMhyXfh4l/+DbtRb8Zu50GZrEKzy35SifBW9BxuR7ANZNR3YUa/fKKrBMqU
 xl2k/A4o2lLMFv2c0boM486iuYOhXGXobJR35RC7wVxqRU4oWcqLpelmQB5cdHE3yJ6dZ3digI9
 nTYjfojks82XrVAo0935j0YHFaM08DQa+fxPiuWJtPwyIdl9uZ1FTg1DXTCg6Ds8FlHDK2a
X-Received: by 2002:a05:7022:220a:b0:124:9e46:830e with SMTP id
 a92af1059eb24-125c0f95649mr867007c88.1.1769784550012; Fri, 30 Jan 2026
 06:49:10 -0800 (PST)
MIME-Version: 1.0
References: <20260126200747.13527-1-alexander.deucher@amd.com>
 <b977ab80-748b-4eb7-b05c-5856db02acb0@amd.com>
In-Reply-To: <b977ab80-748b-4eb7-b05c-5856db02acb0@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 30 Jan 2026 09:48:58 -0500
X-Gm-Features: AZwV_QjPbPwC2CP33RughUVRt0IHrGi30TcTlI6f-tc3Ffr-AXdQVY40ZGKRI2U
Message-ID: <CADnq5_NU4Swq_n12A6HXD+YRRcXahFMYxa4pLHT2-WX33tfgzg@mail.gmail.com>
Subject: Re: [PATCH 01/12] drm/amdgpu/gfx9: handle gfxoff in interrupt set
 functions
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Yifan Zhang <yifan1.zhang@amd.com>
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

On Tue, Jan 27, 2026 at 12:02=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
>
>
> On 27-Jan-26 1:37 AM, Alex Deucher wrote:
> > Need to make sure gfxoff is disallowed when we touch GC
> > registers over MMIO.
> >
>
> I think interrupt enable/disable sequence is only supposed to be done
> under ip power/clock ungate sequence like in hw init/resume/suspend
> sequences. The fix probably should be in the higher level sequence which
> doesn't take care of that.

In that case, Yifan's original patch is probably fine as is.  Someone
should still double check all of the call paths though.

Alex

>
> Thanks,
> Lijo
>
> > Cc: Yifan Zhang <yifan1.zhang@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_0.c
> > index 36f0300a21bfa..05178ee8e0e3a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -6056,6 +6056,7 @@ static int gfx_v9_0_set_priv_reg_fault_state(stru=
ct amdgpu_device *adev,
> >       u32 cp_int_cntl_reg, cp_int_cntl;
> >       int i, j;
> >
> > +     amdgpu_gfx_off_ctrl(adev, false);
> >       switch (state) {
> >       case AMDGPU_IRQ_STATE_DISABLE:
> >       case AMDGPU_IRQ_STATE_ENABLE:
> > @@ -6080,6 +6081,7 @@ static int gfx_v9_0_set_priv_reg_fault_state(stru=
ct amdgpu_device *adev,
> >       default:
> >               break;
> >       }
> > +     amdgpu_gfx_off_ctrl(adev, true);
> >
> >       return 0;
> >   }
> > @@ -6092,6 +6094,7 @@ static int gfx_v9_0_set_bad_op_fault_state(struct=
 amdgpu_device *adev,
> >       u32 cp_int_cntl_reg, cp_int_cntl;
> >       int i, j;
> >
> > +     amdgpu_gfx_off_ctrl(adev, false);
> >       switch (state) {
> >       case AMDGPU_IRQ_STATE_DISABLE:
> >       case AMDGPU_IRQ_STATE_ENABLE:
> > @@ -6116,6 +6119,7 @@ static int gfx_v9_0_set_bad_op_fault_state(struct=
 amdgpu_device *adev,
> >       default:
> >               break;
> >       }
> > +     amdgpu_gfx_off_ctrl(adev, true);
> >
> >       return 0;
> >   }
> > @@ -6125,6 +6129,7 @@ static int gfx_v9_0_set_priv_inst_fault_state(str=
uct amdgpu_device *adev,
> >                                             unsigned type,
> >                                             enum amdgpu_interrupt_state=
 state)
> >   {
> > +     amdgpu_gfx_off_ctrl(adev, false);
> >       switch (state) {
> >       case AMDGPU_IRQ_STATE_DISABLE:
> >       case AMDGPU_IRQ_STATE_ENABLE:
> > @@ -6135,6 +6140,7 @@ static int gfx_v9_0_set_priv_inst_fault_state(str=
uct amdgpu_device *adev,
> >       default:
> >               break;
> >       }
> > +     amdgpu_gfx_off_ctrl(adev, true);
> >
> >       return 0;
> >   }
> > @@ -6152,6 +6158,7 @@ static int gfx_v9_0_set_cp_ecc_error_state(struct=
 amdgpu_device *adev,
> >                                             unsigned type,
> >                                             enum amdgpu_interrupt_state=
 state)
> >   {
> > +     amdgpu_gfx_off_ctrl(adev, false);
> >       switch (state) {
> >       case AMDGPU_IRQ_STATE_DISABLE:
> >               WREG32_FIELD15(GC, 0, CP_INT_CNTL_RING0,
> > @@ -6173,6 +6180,7 @@ static int gfx_v9_0_set_cp_ecc_error_state(struct=
 amdgpu_device *adev,
> >       default:
> >               break;
> >       }
> > +     amdgpu_gfx_off_ctrl(adev, true);
> >
> >       return 0;
> >   }
> > @@ -6183,6 +6191,7 @@ static int gfx_v9_0_set_eop_interrupt_state(struc=
t amdgpu_device *adev,
> >                                           unsigned type,
> >                                           enum amdgpu_interrupt_state s=
tate)
> >   {
> > +     amdgpu_gfx_off_ctrl(adev, false);
> >       switch (type) {
> >       case AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP:
> >               gfx_v9_0_set_gfx_eop_interrupt_state(adev, state);
> > @@ -6214,6 +6223,7 @@ static int gfx_v9_0_set_eop_interrupt_state(struc=
t amdgpu_device *adev,
> >       default:
> >               break;
> >       }
> > +     amdgpu_gfx_off_ctrl(adev, true);
> >       return 0;
> >   }
> >
>
