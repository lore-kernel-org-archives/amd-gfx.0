Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C03CCD193
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 13:04:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68B8E10E272;
	Mon, 20 Oct 2025 13:04:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HhvGZxu2";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FF3810E272
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 13:04:11 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-29245cb814cso5244105ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 06:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760965450; x=1761570250; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oywArE2yT38qX4uPs/jdieZLja8wS++qduwzE6rJ9Uo=;
 b=HhvGZxu2zPht1Z73LUYCwjKElaxtomOmDg/uMHHasuWe9uKZ1t0RZq263Ms4KgFlEY
 n0eKN5agE3EaBjCZkEkYzuyV5vEsm9esvqW01WNK3GVPu6pKwO0i3fE/OIKc/eSFADjT
 Wd4YT5BFX3MzCSxfmPGntI2eaIZ+iNha+vjgct2AM+E6NJJgcoiCitU3JmzT63VcfUpi
 VCDDgcv77GYQBDJZ+R1Aiuspw16K+ZipwoBbJEL254EKE2wtB8Vwu4eCknZJbqoo+Cut
 YVIwNogv5bJ4vAziMrrWG8pfupDvIxu0V7jsKIN4ZTL+p2PSgFBUmuucfuFsTzTSyB0Q
 Jm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760965450; x=1761570250;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oywArE2yT38qX4uPs/jdieZLja8wS++qduwzE6rJ9Uo=;
 b=huGZwVgilEfiNuudpbobTG4MFN9rdoti06JzYFzeYa8nMg1cFYXwDUy9eA0UavDdAa
 rpGSxfAa3QChkLxSUR3H5rX+9cVSaAl/+QBy7ythxqLLMzxG3mk+1NHUXJOZY38oCK/p
 D4Hh3EnZ0LtZr8g/dmrJytRZIBc0TtybaahIOrjeM17/tX/qqM506bITSTvnv43rHVOM
 Y+7DZSCioL9CNMHzO6guRLpEBt2IyxnquZZxewfbhfSAjtr/+LFbHis3L5859/LCzqJm
 FpPClDfy9/Vu8B/01CTg2fiG3AD61VAQCI8SZyZTxZm85C1GyT3eg8LVL5MYI4X1ToJJ
 PFLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmNyoS/E/eQ5lyUEndsw0O03wHhn88rgKd9yiSXqayh3qAsSXwBcGPdmoMe8YpohHd82J10VP5@lists.freedesktop.org
X-Gm-Message-State: AOJu0YztntaNRqZ2ndtWcai50fVQB+dJ4FLVYaSUfr5DOXKtZ22Y1Pn2
 CJagy2kWyCrxD/JSUICGveOGOPel/emLADvhjtQ/r8Fg4h/9rZoOyDo6ue+X4dUjaAx0WOecB6N
 phePyGxL2t2g50cKsRJcKFC9Pbx/LAp0=
X-Gm-Gg: ASbGncsrATTbKve91mGENskcIdgGMkP0u4WsRp0/+z30E6QsRMX1jDN+yL17WCO4lep
 I+xqpOyDixHciYELwe/UMpkCNcZbCabNBYk7jkKPf0rPr/RmOAG9TuhBMqpSnVFloXI1aybobw9
 qq5lUcaXTLtVqq9nzNe1syNXhDAnzO2EsfDw7lS4uK9ArmhPTWFQbnv+NbL22ewInlkonmJ3lNc
 LqxIC0NThOFwytgN6VJi7oEMOiMpvzbTgILYOcf330Bh3vH2PBpO+zhY8bE
X-Google-Smtp-Source: AGHT+IGj3NqQk7YuYSYYY0l1WSrTtcIITzZ7eA2amD+NtUWcASFzDQS/4tWH7DpeSdIY1+/SVtvDIZHls2ZJPUG0s/0=
X-Received: by 2002:a17:902:f645:b0:290:c3a9:42b5 with SMTP id
 d9443c01a7336-290c9d1fdefmr80734425ad.5.1760965450454; Mon, 20 Oct 2025
 06:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20251008050418.3399656-1-lijo.lazar@amd.com>
 <a021f76ec289089dab0715399d44ad7704af8c69.camel@gmail.com>
In-Reply-To: <a021f76ec289089dab0715399d44ad7704af8c69.camel@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Oct 2025 09:03:57 -0400
X-Gm-Features: AS18NWBggFp3lt496eQC1Aqpjnw8Nwmko1WV_Oqxb61XDKlKwSiFPYwAK5gsiHY
Message-ID: <CADnq5_O5GkGaqQn0e_bm6K1fjCfX_1Siom6QkOw3oJDUDQUimA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Skip SDMA suspend during mode-2 reset
To: timur.kristof@gmail.com
Cc: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org, 
 Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Asad.Kamal@amd.com
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

On Mon, Oct 20, 2025 at 8:31=E2=80=AFAM <timur.kristof@gmail.com> wrote:
>
> On Wed, 2025-10-08 at 10:34 +0530, Lijo Lazar wrote:
> > For SDMA IP versions > v4.4.2, firmware will take care of quiescing
> > SDMA
> > before mode-2 reset.
> >
> > Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/aldebaran.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> > b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> > index 9569dc16dd3d..0007d00b9e8f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> > @@ -88,6 +88,10 @@ static int aldebaran_mode2_suspend_ip(struct
> > amdgpu_device *adev)
> >       uint32_t ip_block;
> >       int r, i;
> >
> > +     /* Skip suspend of SDMA IP versions > 4.4.2. They are multi-
> > aid */
>
> What does "multi-aid" mean here?

Active Interposer Die.  Multi-chiplet platforms like MI300.

Alex

>
>
> > +     if (adev->aid_mask)
> > +             ip_block_mask &=3D ~BIT(AMD_IP_BLOCK_TYPE_SDMA);
> > +
> >       amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> >       amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> >
