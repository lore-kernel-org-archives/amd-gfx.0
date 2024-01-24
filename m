Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CD6C46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 21:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8C4B10E338;
	Wed, 24 Jan 2024 21:13:18 +0000 (UTC)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com
 [209.85.161.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FD4F10E338
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 21:13:17 +0000 (UTC)
Received: by mail-oo1-f43.google.com with SMTP id
 006d021491bc7-59969ec581aso2606679eaf.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 13:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706130737; x=1706735537; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ww+t2+HiTsG8go3OS3gfU/F489gESqWcMLy6ToS1xWs=;
 b=J7Z5x3zFR6/1g3NARDV2rdUJbZ1AQdicb2MUTOw2mlYEi1JqH2lF/kTp81hnm93sJu
 60fLbPEMrUfygWULza86Vek89Vl0ybq40R3n/S03Yi3MICrGQ5DT0eHV7l2GjsuzPVyj
 rg1oddTrY61dm9uJrLJEy6I+h0167eQPDqqvuvu1qP8ifvQQ+vFU5ELzrLYr3Jx5qzLW
 twkFLLxvkEVz6Wv6ASasC+HTvkt8m39HcjJFOc6yNrVj8L+Ah1YmPd8/ciXua+sSGwZ3
 w0Os9eyxcsszP3snVL827tDZhF8C4US9g6OWNp/twWS9I6GEsRKDXmtVkreYkgm/AaA+
 eCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706130737; x=1706735537;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ww+t2+HiTsG8go3OS3gfU/F489gESqWcMLy6ToS1xWs=;
 b=AeOyXMI1+3jfHxXKp3p5PAdZniGsh8W5eyB3+g0eQ4yav4N5dFZJ8s/X6daQJzEmnF
 D85TETDnZVzgXva9UJ9yvQRSEdHjsm5jy6VOCN9HzpM92OSoh5USEI5oClzezy93CpwG
 62hOt/M+P9eP/pHy0Faevjbp6Ux954o5WyBby6tLrLDRXBO0TCKQd/K/VS4u8o/b/MGQ
 PieIFin5sfhZRaI35Ts4v6MX5kOI5FdcOHWUoR3tEda5a4OossEiwm3WF0U6mOny/G+a
 u4l/A8NKkS5TdefFxnin6U1Atm3xhudZzZ5ix7XHf0ypcmZOU5D5qfOmIq9bp7mejGuj
 VqzQ==
X-Gm-Message-State: AOJu0YwNHrDcjJ+iF/+lfMvQ5XgRJ6KGp57autyWWNNhTcL1/l0SatSq
 hSSWl13xE0Jd5XeETtmRoSZuPWh5tDPeZJCYzUzF/hWK06BHsi+c34vE6ije+k7E8LDXW1mr8qu
 bzSj0JJrArxUSrjM4aG/TqSHUzE0b3Pjs
X-Google-Smtp-Source: AGHT+IGnlderuSRdPZwEIH+Xc+QJdbUCYBH6cOEdVVzRGUj+OSzOUb3b8cTMenItSMnsYUe4jaVMV/7Vf4CzrS09u7s=
X-Received: by 2002:a05:6871:8904:b0:214:c7e7:478d with SMTP id
 ti4-20020a056871890400b00214c7e7478dmr400756oab.45.1706130736713; Wed, 24 Jan
 2024 13:12:16 -0800 (PST)
MIME-Version: 1.0
References: <20240115190733.1483942-1-jay.cornwall@amd.com>
 <9fc91c67-6088-c361-3179-969f4907dfff@amd.com>
In-Reply-To: <9fc91c67-6088-c361-3179-969f4907dfff@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 24 Jan 2024 16:12:05 -0500
Message-ID: <CADnq5_NYoP1kx-eHwzTF5KbsNFeNy__ramY3rzYYCgOSfFR_Bw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Use S_ENDPGM_SAVED in trap handler
To: Jay Cornwall <jay.cornwall@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 24, 2024 at 4:01=E2=80=AFPM Jay Cornwall <jay.cornwall@amd.com>=
 wrote:
>
> On 1/15/2024 13:07, Jay Cornwall wrote:
> > This instruction has no functional difference to S_ENDPGM
> > but allows performance counters to track save events correctly.
> >
> > Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> > ---
> >  drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h     | 14 +++++++-------
> >  .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm |  2 +-
> >  .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm  |  2 +-
> >  3 files changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/g=
pu/drm/amd/amdkfd/cwsr_trap_handler.h
> > index df75863393fc..d1caaf0e6a7c 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> > +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> > @@ -674,7 +674,7 @@ static const uint32_t cwsr_trap_gfx9_hex[] =3D {
> >       0x86ea6a6a, 0x8f6e837a,
> >       0xb96ee0c2, 0xbf800002,
> >       0xb97a0002, 0xbf8a0000,
> > -     0xbe801f6c, 0xbf810000,
> > +     0xbe801f6c, 0xbf9b0000,
> >  };
> >
> >  static const uint32_t cwsr_trap_nv1x_hex[] =3D {
> > @@ -1091,7 +1091,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] =3D {
> >       0xb9eef807, 0x876dff6d,
> >       0x0000ffff, 0x87fe7e7e,
> >       0x87ea6a6a, 0xb9faf802,
> > -     0xbe80226c, 0xbf810000,
> > +     0xbe80226c, 0xbf9b0000,
> >       0xbf9f0000, 0xbf9f0000,
> >       0xbf9f0000, 0xbf9f0000,
> >       0xbf9f0000, 0x00000000,
> > @@ -1574,7 +1574,7 @@ static const uint32_t cwsr_trap_arcturus_hex[] =
=3D {
> >       0x86ea6a6a, 0x8f6e837a,
> >       0xb96ee0c2, 0xbf800002,
> >       0xb97a0002, 0xbf8a0000,
> > -     0xbe801f6c, 0xbf810000,
> > +     0xbe801f6c, 0xbf9b0000,
> >  };
> >
> >  static const uint32_t cwsr_trap_aldebaran_hex[] =3D {
> > @@ -2065,7 +2065,7 @@ static const uint32_t cwsr_trap_aldebaran_hex[] =
=3D {
> >       0x86ea6a6a, 0x8f6e837a,
> >       0xb96ee0c2, 0xbf800002,
> >       0xb97a0002, 0xbf8a0000,
> > -     0xbe801f6c, 0xbf810000,
> > +     0xbe801f6c, 0xbf9b0000,
> >  };
> >
> >  static const uint32_t cwsr_trap_gfx10_hex[] =3D {
> > @@ -2500,7 +2500,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] =3D {
> >       0x876dff6d, 0x0000ffff,
> >       0x87fe7e7e, 0x87ea6a6a,
> >       0xb9faf802, 0xbe80226c,
> > -     0xbf810000, 0xbf9f0000,
> > +     0xbf9b0000, 0xbf9f0000,
> >       0xbf9f0000, 0xbf9f0000,
> >       0xbf9f0000, 0xbf9f0000,
> >  };
> > @@ -2944,7 +2944,7 @@ static const uint32_t cwsr_trap_gfx11_hex[] =3D {
> >       0xb8eef802, 0xbf0d866e,
> >       0xbfa20002, 0xb97af802,
> >       0xbe80486c, 0xb97af802,
> > -     0xbe804a6c, 0xbfb00000,
> > +     0xbe804a6c, 0xbfb10000,
> >       0xbf9f0000, 0xbf9f0000,
> >       0xbf9f0000, 0xbf9f0000,
> >       0xbf9f0000, 0x00000000,
> > @@ -3436,5 +3436,5 @@ static const uint32_t cwsr_trap_gfx9_4_3_hex[] =
=3D {
> >       0x86ea6a6a, 0x8f6e837a,
> >       0xb96ee0c2, 0xbf800002,
> >       0xb97a0002, 0xbf8a0000,
> > -     0xbe801f6c, 0xbf810000,
> > +     0xbe801f6c, 0xbf9b0000,
> >  };
> > diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/d=
rivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> > index e0140df0b0ec..71b3dc0c7363 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> > +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> > @@ -1104,7 +1104,7 @@ L_RETURN_WITHOUT_PRIV:
> >       s_rfe_b64       s_restore_pc_lo                                  =
       //Return to the main shader program and resume execution
> >
> >  L_END_PGM:
> > -     s_endpgm
> > +     s_endpgm_saved
> >  end
> >
> >  function write_hwreg_to_mem(s, s_rsrc, s_mem_offset)
> > diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm b/dr=
ivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
> > index e506411ad28a..bb26338204f4 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
> > +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
> > @@ -921,7 +921,7 @@ L_RESTORE:
> >  /*                   the END                                          =
 */
> >  /*********************************************************************=
*****/
> >  L_END_PGM:
> > -    s_endpgm
> > +    s_endpgm_saved
> >
> >  end
> >
>
> Ping. Patch has been tested and verified, just looking for an Ack.
