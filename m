Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DAAC79FB9
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 06:56:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 588C210EF60;
	Wed,  9 Sep 2026 06:56:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VievpDNd";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B26310E4BE
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 20:00:47 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-84e27035206so4726181b3a.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Sep 2026 13:00:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788897646; cv=none;
 d=google.com; s=arc-20260327;
 b=pgswLo/9kyQarbIhbvCjHKe/rTwUxmSNfSImhqLl3DbAyxKnMpA1TzI4AhPNmdb+j2
 dkmOqW/17u0eLS2wuHjLDDgG8zJSoqBMUQ3LnQA2wsx+2USSB/NL88lA2lUV7w4qL63o
 R0Cj7aIsCEvBuQLjbFNscTrSsU7eBiXVol0igu4jvITgU3YRmhiBVLF7JCPn7PXD564j
 BxUD/afyP+8P9cR3hKkf9dluHZ0KAg9AW8jhf1o0d2nUGQ/FOmU4s7GWfvsbuDyCaIMx
 hmVEp5TyRaDHVYinECmQ2VC1HvbfEMmsh2Jk7fnm4olFXu4vwJP2U1c8PtK2BFB8gJOy
 O3gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CgnFpj0KhXyBQSPhlPzZGfxCaAjurfhKYEu5Mk/FQ5I=;
 fh=Ul71IiJuojwXq3NNGvkE23P8+sAIMGBgH/iAPfzOAkE=;
 b=dX/wQxVGwtyUdbGElE+UN/rCPkcRbkutNEiX0pJk4HSGtASmG3D4GTUpW1U4q32QXo
 Qd5ufK1m5GD1k7O7eBBy0g1dYXBNDJ0/f+z9ncDb/b/HgzHwTbISejtCyYfyWuZqxADY
 1ZNWon2IyNF0uHx0ez08nQX1SlH6k45yUjD5RNPUMPWFGmBD5nJHwYj/RnoDXBtol3E5
 tb9Q6Hw013R34Yf3+f5ydmXTW2y+xXCMrY1F0eh1rE1asK4WZ87mAQsXCG66RPD5n/4U
 KF+e7JicQ//x9DLIK/iR4sackUOS1SneFnzjqINi8QVVLR9sTulEbq01GuhML1kosYEa
 vYGg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788897646; x=1789502446; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CgnFpj0KhXyBQSPhlPzZGfxCaAjurfhKYEu5Mk/FQ5I=;
 b=VievpDNde6CEW0R4lFbi8/0YZoUmriTrEagV5143CGgCwcQs8AeQ7QQH+JbxvTEqje
 GPN/Iy27LjRGArmjz4CkelD213RDuJoHkF6PAZEGC6sGQ5SmKJZfWLKZx1VL9+ipt8RV
 bpaXaVTLqpXN5i0tITfh14ElaJ6WQv1QaOAAv5A2Hw7Uh6Z8SpoPL9bEdS0nlgjPS/m2
 YpBKFWR6iKL8KbViBiASJB8EWMJHpYhh2BJ0hKj0SA6E4MMxuJ39TjDeeEz5VlZt5Ezt
 VAWG2BG4FMKerqv+/+M6AzwWaNI391WjmlhV280cGolIijQlaB1lnRtHmE4RVgBOYKE5
 31Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788897646; x=1789502446;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CgnFpj0KhXyBQSPhlPzZGfxCaAjurfhKYEu5Mk/FQ5I=;
 b=lD4Utxg6zsD4fVSEcRDOCeRc5J0p/C6gi7KLhQUp1+vQSiqz47oMt/e9fWzOYc41Wo
 B+g8t6Jvf/a5d06kWzq1tmQtwgtWBAN9dwb1YGQH8mStlG6+Y2LxV35xrWq/jVv7Y47V
 WCA06rWG+xt5N7Msl81IJ8+oINfBLskktpz8W6nRU/xPRa1TVbDkyqETwiqkkNTzUwTv
 OiQXuLmUr3Tzom3knT+2F9kwWCVuMNioXcFrNFkxK5i/x8PNatugn01Axc9GwmquVsw3
 AsHn5kl9tqqLRb5pyJAab+Dpdu7k9YDgfp32e2ANWDOLs9TydZ9e149ovSehfmY1/T+j
 bPdw==
X-Gm-Message-State: AFuF++m5BpgLLFoAbp2r9xTE7+RrmC2wXPCf+I4JVRZwYU2rAnKjlEhp
 QBQEA9pi/b7qgLvN/BgOSHJs9TmKN9HpLVHULzuoOAbqnMpdJg5Q2NDCnsFI9QE2ETi45p6/Tpt
 a3QMPgTOO/GrZKdYjgZqs9BEfnn3Ees0=
X-Gm-Gg: AYBFou24VNHoqzXl/D/esX9/EWYeAsZL8WJuVpNbqOMGONZs6nlw7UN+dG+URATYwXx
 +csmvcGZoIm6tFiYXv9ZwxQdNvhASXDAA9oprnGJBwN4R2QdzlKxHboFMYGrGAj3IVrkhbhE/g5
 fPArSTPMeQS4sQykcNiRWOl+lnaM+xy/yNJWCBegN0JD/QWZDJBtuHpNi8vhk9L6TCGKIPKzmpf
 hQI6KtBdoBK2Ws5mVGaB5tYfh34XiWT9cYdEscYuSj4U8qixN/sWAFO7ElOgnY/iHkYaJSbE71E
 wKS3aqtxtgjzoWaVaBEmDg1eeedkqOlLj7wF0jUwbfInKihFKITc3cnk
X-Received: by 2002:a05:6a21:a06:b0:3d3:aec2:4dcc with SMTP id
 adf61e73a8af0-3da3a0fd0f3mr52835956637.24.1788897646281; Tue, 08 Sep 2026
 13:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260825211819.100210-1-mauriciobellon@gmail.com>
 <20260825211819.100210-3-mauriciobellon@gmail.com>
 <CHXPR12MB99922037436C4ADE71BA82E152E5B12@CHXPR12MB999220.namprd12.prod.outlook.com>
In-Reply-To: <CHXPR12MB99922037436C4ADE71BA82E152E5B12@CHXPR12MB999220.namprd12.prod.outlook.com>
From: Mauricio Bellon <mauriciobellon@gmail.com>
Date: Tue, 8 Sep 2026 17:00:33 -0300
X-Gm-Features: AcwNN1WthglvDl-B0dk2ve42MA1wB5FLHFgw6l5Zd038WYo8I01-a0pmBvdKj24
Message-ID: <CABNo9DcRfNQyw436eP_Y4PdbbwW7NTH3tfH0SB4st+uShFvtJA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/display: enable sink DSC before source DSC
To: "Zuo, Jerry" <Jerry.Zuo@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lin,
 Wayne" <Wayne.Lin@amd.com>, 
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 Mauricio Bellon <mbellon@lenovo.com>, 
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Li,
 Sun peng (Leo)" <Sunpeng.Li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, 
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 09 Sep 2026 06:56:16 +0000
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

Hi Jerry,

Thanks for catching that, you're right.

I went back through the sequence and confirmed that my new
dp_set_dsc_on_rx() call runs in the pre-enable phase, before
enable_link() performs DP link training. I had mixed up the requirement
to configure source-side DSC before link setup with the separate
requirement to enable DSC on the sink only after training.

It happened to work with the X13 and monitor I tested, including the
hotplug cases, but that clearly doesn't make the ordering safe for other
sinks. I won't keep patch 2 in its current form.

Would the right place for dp_set_dsc_on_rx() be at the start of the
post-enable phase, after link training but before
hwss->enable_stream()? Or should it stay in its current location after
hwss->enable_stream()?

I'll wait for your guidance on the intended placement before sending a
revision. Patch 1 should be independent of this sink DSC ordering change.

Thanks,
Mauricio


Em ter., 8 de set. de 2026 =C3=A0s 15:14, Zuo, Jerry <Jerry.Zuo@amd.com> es=
creveu:
>
> AMD General
>
> Hi Mauricio:
>
>      This change breaks dsc, causing black screen.
>
>      Sink RX dsc enable should land after link training. Writing dsc enab=
le to the RX on an untrained link is too early, that should be done after t=
raining. That is likely to be the main sequence regression.
>
> Regards,
> Jerry
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Mauricio Bellon
> > Sent: Tuesday, August 25, 2026 17:18
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Lin, Wayne <Wayne.Lin@amd.com>; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; Mauricio Bellon <mbellon@lenovo.com>;
> > Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
> > <Sunpeng.Li@amd.com>; Rodrigo Siqueira <siqueira@igalia.com>; Deucher,
> > Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; stable@vger.kernel.org
> > Subject: [PATCH 2/2] drm/amd/display: enable sink DSC before source DSC
> >
> > [Some people who received this message don't often get email from
> > mauriciobellon@gmail.com. Learn why this is important at
> > https://aka.ms/LearnAboutSenderIdentification ]
> >
> > From: Mauricio Bellon <mbellon@lenovo.com>
> >
> > Direct DisplayPort high-refresh modes using DSC and two-way ODM can
> > commit without visible output during a 4K120-to-4K144 transition. A wor=
king
> > 4K144 stream can also return black after long-pulse hotplug reconstruct=
ion.
> >
> > The DPMS-on path currently enables source DSC before link enablement bu=
t
> > does not enable sink DSC until after the source stream is enabled. This=
 leaves
> > the sink and source compression state ordered differently while the str=
eam is
> > brought up.
> >
> > Enable sink DSC immediately before source DSC in the pre-enable phase, =
and
> > remove the later redundant sink-enable operation near PPS packet
> > programming. This establishes the order as sink DSC, source DSC, stream
> > enablement, and PPS before the compressed stream becomes visible.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Mauricio Bellon <mbellon@lenovo.com>
> > ---
> >  drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> > b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> > index 48b086d15..412ce52b3 100644
> > --- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> > +++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> > @@ -2635,8 +2635,10 @@ static enum dc_status
> > link_set_dpms_on_pre_enable_link(
> >          */
> >         if (stream->timing.flags.DSC) {
> >                 if (dc_is_dp_signal(stream->signal) ||
> > -                       dc_is_virtual_signal(stream->signal))
> > +                       dc_is_virtual_signal(stream->signal)) {
> > +                       dp_set_dsc_on_rx(pipe_ctx, true);
> >                         link_set_dsc_enable(pipe_ctx, true);
> > +               }
> >         }
> >
> >         if (link->replay_settings.config.replay_supported
> > && !dc_is_embedded_signal(link->connector_signal))
> > @@ -2729,7 +2731,6 @@ static enum dc_status
> > link_set_dpms_on_post_enable_link(
> >         if (stream->timing.flags.DSC) {
> >                 if (dc_is_dp_signal(stream->signal) ||
> >                                 dc_is_virtual_signal(stream->signal)) {
> > -                       dp_set_dsc_on_rx(pipe_ctx, true);
> >                         link_set_dsc_pps_packet(pipe_ctx, true, true);
> >                 }
> >         }
> > --
> > 2.53.0
>
